unit RiggVar.Grid.Control;

(*
-
-     F
-    * * *
-   *   *   G
-  *     * *   *
- E - - - H - - - I
-  *     * *         *
-   *   *   *           *
-    * *     *             *
-     D-------A---------------B
-              *
-              (C) federgraph.de
-
*)

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Math,
  System.Rtti,
  System.RTLConsts,
  System.Generics.Collections,
  FMX.Consts,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Controls.Model,
  FMX.Objects,
  FMX.Grid,
  FMX.Grid.Style,
  FMX.Header,
  FMX.TextLayout,
  FMX.Presentation.Factory,
  FMX.Presentation.Style,
  RiggVar.Grid.ColGrid;

type
  TDisplayGrid = class(TStringGrid)
  private
    FColCount: Integer;
    procedure InitHeaderStyle;
    procedure HandleHeaderItemOnClick(Sender: TObject);
    procedure HandleOnApplyStyleLookup(Sender: TObject);
    procedure HandleEditingDone(Sender: TObject; const ACol, ARow: Integer);
    procedure SetColCount(const Value: Integer);
    function GetCol: Integer;
    function GetRow: Integer;
    function GetColWidth(ACol: Integer): Integer;
    procedure SetColWidth(ACol: Integer; const Value: Integer);
    procedure SetCaption(Col: Integer; const Value: string);
    function GetCaption(Col: Integer): string;
    function GetEditorMode: Boolean;
    procedure SetEditorMode(const Value: Boolean);
  public
    ColGrid: TColGrid;
    DefaultColWidth: Integer;
    FinishEditFlag: Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ClearRow(Row: Integer);
    procedure Reset;
    procedure SetupGrid;
    procedure ShowHeader;
    procedure ShowData;

    procedure InvalidateGrid;
    procedure CancelEdit;
    procedure FinishEdit(ACol, ARow: Integer; var Value: string);

    property ColCount: Integer read FColCount write SetColCount;
    property Row: Integer read GetRow;
    property Col: Integer read GetCol;

    property ColWidth[ACol: Integer]: Integer read GetColWidth write SetColWidth;
    property EditorMode: Boolean read GetEditorMode write SetEditorMode;
    property Captions[ACol: Integer]: string read GetCaption write SetCaption;
  end;

  TDisplayGridColumn = class(TColumn)
  protected
    procedure BeforeDrawing(const Canvas: TCanvas); override;
    procedure DrawBackground(const Canvas: TCanvas; const Bounds: TRectF;
      const Row: Integer; const Value: TValue; const State: TGridDrawStates); override;
  public
    [Weak] DisplayGrid: TDisplayGrid;
    Tal: TTextAlign;
    Col: Integer;
    constructor Create(AOwner: TComponent); override;
  end;

var
  WantSmallRows: Boolean;

implementation

uses
  RiggVar.Grid.ColBase,
  RiggVar.Grid.Color;

type
  TColorCache = class(TDictionary<TColor,TBrush>)
  private
    function GetBrush(AColor: TColor): TBrush;
  public
    destructor Destroy; override;
  end;

var
  ColorCache: TColorCache;

{ TDisplayGrid }

constructor TDisplayGrid.Create(AOwner: TComponent);
var
  GridOptions: TGridOptions;
begin
  inherited;

  StyleLookup := 'gridstyle';

  if WantSmallRows then
    RowHeight := 17
  else
    RowHeight := 24;

  OnApplyStyleLookup := HandleOnApplyStyleLookup;
  Model.OnEditingDone := HandleEditingDone;

  GridOptions := Model.Options;
  GridOptions := GridOptions - [TGridOption.ColumnMove];
  GridOptions := GridOptions + [TGridOption.AlternatingRowBackground];

  Model.Options := GridOptions;

end;

destructor TDisplayGrid.Destroy;
var
  c: TColumn;
begin
  while FColCount > 0 do
  begin
    c := self.Columns[FColCount - 1];
    self.RemoveObject(c);
    c.Parent := nil;
    c.Free;
    Dec(FColCount);
  end;
  inherited;
end;

procedure TDisplayGrid.InvalidateGrid;
begin
end;

procedure TDisplayGrid.HandleEditingDone(Sender: TObject; const ACol, ARow: Integer);
var
  v: string;
begin
  v := Cells[ACol, ARow];
  FinishEdit(ACol, ARow, v);
end;

procedure TDisplayGrid.HandleHeaderItemOnClick(Sender: TObject);
var
  hi: THeaderItem;
  i: Integer;
begin
  if Sender is THeaderItem then
  begin
    hi := Sender as THeaderItem;
    i := hi.Index;
    if Assigned(ColGrid) then
    begin
      ColGrid.InitDisplayOrder(i);
      ColGrid.ShowData;
    end;
  end;
end;

procedure TDisplayGrid.CancelEdit;
begin
end;

procedure TDisplayGrid.Reset;
begin
end;

procedure TDisplayGrid.FinishEdit(ACol, ARow: Integer; var Value: string);
var
  cp: TBaseColProp;
  cr: TBaseRowCollectionItem;
begin
  cp := ColGrid.ColsActive[ACol];
  cr := ColGrid.GetRowCollectionItem(ARow);

  if Assigned(cr) then
  begin

    if Assigned(cp) then
    begin
     if Assigned(cp.OnFinishEdit) then
      cp.OnFinishEdit(cr, Value);

      if Assigned(cp.OnFinishEdit2) then
        cp.OnFinishEdit2(cr, Value, cp.NameID);
    end;

    if Assigned(ColGrid.OnFinishEditCR) then
    begin
      //EditorMode := False; //does not work !
      FinishEditFlag := True;
      ColGrid.OnFinishEditCR(cr);
      FinishEditFlag := False;
    end;
  end;
end;

function TDisplayGrid.GetCol: Integer;
begin
  result := ColumnIndex;
end;

function TDisplayGrid.GetRow: Integer;
begin
  result := Selected;
end;

procedure TDisplayGrid.SetupGrid;
var
  cl: TBaseRowCollection;
  i: Integer;
begin
  ColGrid.MenuMode := true;
  cl := ColGrid.GetBaseRowCollection;

  { init RowCount, clear visible cells }
  if Assigned(cl) and (cl.Count > 0) then
    RowCount := cl.FilteredCount
  else
    RowCount := 0;
  for i := 0 to RowCount - 1 do
    ClearRow(i);

  { init width of columns, show captions }
  ShowHeader;
end;

procedure TDisplayGrid.ShowHeader;
var
  i: Integer;
  cp: TBaseColProp;
begin
  ColCount := ColGrid.ColsActive.VisibleCount;
  for i := 0 to ColGrid.ColsActive.Count - 1 do
  begin
    cp := ColGrid.ColsActive[i];
    if Assigned(cp) and cp.Visible then
    begin
      ColWidth[i] := cp.Width;
      Captions[i] := cp.Caption;
    end;
  end;
end;

procedure TDisplayGrid.ShowData;
var
  i, j: Integer;
  cr: TBaseRowCollectionItem;
  cl: TBaseRowCollection;
begin
  if EditorMode then
  begin
    if not FinishEditFlag then
      Exit;
  end;

  cl := ColGrid.GetBaseRowCollection;
  if Assigned(cl) then
  begin
    { check RowCount }
    if RowCount <> cl.Count then
    begin
      if cl.Count > 0 then
        RowCount := cl.FilteredCount
      else
        RowCount := 0;
    end;
    { update all rows }
    for j := 0 to cl.Count - 1 do
    begin
      i := j;
      if (ColGrid.DisplayOrder.Count = cl.FilteredCount) then
        i := ColGrid.DisplayOrder.DisplayIndex[j];
      if (i < 0) or (i > cl.Count - 1) then
        Continue;
      cr := cl[i];
      if cr.IsInFilter then
      begin
        if Assigned(ColGrid.ColsActive) then
          ColGrid.ColsActive.UpdateRow(ColGrid.GridModel, j, cr);
      end;
    end;
  end;
end;

procedure TDisplayGrid.SetColCount(const Value: Integer);
var
  c: TDisplayGridColumn;
  cp: TBaseColProp;
begin
  while FColCount < Value do
  begin
    c := TDisplayGridColumn.Create(self);
    c.Parent := self;
    c.Width := DefaultColWidth;

    if ColGrid <> nil then
    begin
      { set Alignment and ReadOnly properties }
      cp := ColGrid.ColsActive[FColCount];
      if cp <> nil then
      begin
        if cp.Alignment = TAlignment.taRightJustify then
          c.Tal := TTextAlign.Trailing;
        c.ReadOnly := cp.ReadOnly;
        c.Col := FColCount;
        c.DisplayGrid := Self;
      end;
    end;

    Inc(FColCount);
  end;
  if Value > 0 then
    while FColCount > Value do
    begin
      Columns[FColCount-1].Free;
      Dec(FColCount);
    end;
end;

procedure TDisplayGrid.InitHeaderStyle;
var
  i: Integer;
  hr: THeader;
  hi: THeaderItem;
  fo: TFmxObject;
begin
  hr := nil;
  fo := FindStyleResource('header');
  if Assigned(fo) and (fo is THeader) then
    hr := THeader(fo);
  if Assigned(hr) then
    for i := 0 to hr.ChildrenCount - 1 do
    begin
      hi := THeaderItem(hr.Children[i]);
      //hi.DragMode := TDragMode.dmManual;
      hi.OnClick := HandleHeaderItemOnClick;
    end;
end;

procedure TDisplayGrid.HandleOnApplyStyleLookup(Sender: TObject);
begin
  InitHeaderStyle;
end;

function TDisplayGrid.GetColWidth(ACol: Integer): Integer;
begin
  result := Floor(Columns[ACol].Width);
end;

function TDisplayGrid.GetEditorMode: Boolean;
begin
  result := Model.EditorMode;
end;

procedure TDisplayGrid.SetEditorMode(const Value: Boolean);
begin
  Model.EditorMode := Value;
end;

procedure TDisplayGrid.SetColWidth(ACol: Integer; const Value: Integer);
begin
  Columns[ACol].Width := Value;
end;

function TDisplayGrid.GetCaption(Col: Integer): string;
var
  cl: TDisplayGridColumn;
begin
  cl := TDisplayGridColumn(Columns[Col]);
  if cl <> nil then
  begin
    result := cl.Header;
  end
  else
    result := '';
end;

procedure TDisplayGrid.SetCaption(Col: Integer; const Value: string);
var
  c: TDisplayGridColumn;
begin
  c := TDisplayGridColumn(Columns[Col]);
  if (c <> nil) then
  begin
    c.Header := Value;
  end;
end;

procedure TDisplayGrid.ClearRow(Row: Integer);
begin

end;

{ TDisplayGridColumn }

constructor TDisplayGridColumn.Create(AOwner: TComponent);
begin
  inherited;
  Tal := TTextAlign.Leading;
end;

procedure TDisplayGridColumn.BeforeDrawing(const Canvas: TCanvas);
begin
  if Layout = nil then
    inherited;

  Layout.BeginUpdate;
  try
    Layout.HorizontalAlign := Tal;
  finally
    Layout.EndUpdate;
  end;
end;

procedure TDisplayGridColumn.DrawBackground(const Canvas: TCanvas; const Bounds: TRectF; const Row: Integer; const Value: TValue;
  const State: TGridDrawStates);
var
  cp: TCellProp;
begin
  if (Model <> nil) and (DisplayGrid <> nil) and (DisplayGrid.ColGrid <> nil) then
  begin
    cp := DisplayGrid.ColGrid.CellProps.CellProp[Col, Row];
    Canvas.Fill.Assign(ColorCache.GetBrush(cp.Color));
    Canvas.FillRect(Bounds, 0, 0, AllCorners, AbsoluteOpacity);
  end;
end;

{ TColorCache }

function TColorCache.GetBrush(AColor: TColor): TBrush;
var
  ac: TAlphaColor;
begin
  ac := claWhite;
  TAlphaColorRec(ac).R := TColorRec(AColor).R;
  TAlphaColorRec(ac).G := TColorRec(AColor).G;
  TAlphaColorRec(ac).B := TColorRec(AColor).B;

  if not ContainsKey(AColor) then
  begin
    Add(AColor, TBrush.Create(TBrushKind.Solid, ac));
  end;
  result := Items[AColor];
end;

destructor TColorCache.Destroy;
var
  Color: TColor;
begin
  for Color in Keys do
  begin
    ExtractPair(Color).Value.Free;
  end;
  inherited;
end;

initialization
  TPresentationProxyFactory.Current.Register(TDisplayGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);
  ColorCache := TColorCache.Create(16);

finalization
  TPresentationProxyFactory.Current.Unregister(TDisplayGrid, TControlType.Styled, TStyledPresentationProxy<TStyledGrid>);
  ColorCache.Free;
  ColorCache := nil;
end.
