unit RiggVar.Col.Action;

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
  RiggVar.Grid.ColGrid,
  RiggVar.Grid.Color,
  RiggVar.Grid.ReportGrid,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Classes,
  RiggVar.FB.Def;

type
  TActionNode = class;

  TActionRowCollectionItem = class(TBaseRowCollectionItem)
  private
    FActionValue: Integer;
    FActionName: string;
    FActionGroup: Integer;
    FShortName: string;
    FShortcut: string;
    FCaption: string;
    procedure SetModified(const Value: Boolean);
    function GetActionNode: TActionNode;
  public
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure ClearResult; override;
    function GetBaseNode: TBaseNode;
    property Modified: Boolean write SetModified;
    property ru: TActionNode read GetActionNode;
  published
    property ActionValue: Integer read FActionValue write FActionValue;
    property ActionName: string read FActionName write FActionName;
    property ActionGroup: Integer read FActionGroup write FActionGroup;
    property ShortName: string read FShortName write FShortName;
    property Shortcut: string read FShortcut write FShortcut;
    property Caption: string read FCaption write FCaption;
  end;

  TActionRowCollection = class(TBaseRowCollection)
  private
    function GetItem(Index: Integer): TActionRowCollectionItem;
    procedure SetItem(Index: Integer; const Value: TActionRowCollectionItem);
  public
    function Add: TActionRowCollectionItem;
    function FindKey(Bib: Integer): TActionRowCollectionItem;
    property Items[Index: Integer]: TActionRowCollectionItem read GetItem write SetItem;
  end;

  TActionColProp = class(TBaseColProp)
  private
    procedure GetSortKeyActionName(crgs: TBaseRowCollectionItem;
      var Value: string; const ColName: string);
    procedure GetSortKeyShortcut(crgs: TBaseRowCollectionItem;
      var Value: string; const ColName: string);
    procedure GetSortKeyShortName(crgs: TBaseRowCollectionItem;
      var Value: string; const ColName: string);
    procedure GetSortKeyCaption(crgs: TBaseRowCollectionItem;
      var Value: string; const ColName: string);
    function LeadingChars(LengthRequired: Integer; const sIn: string): string;
  public
    procedure InitColsAvail; override;
    procedure GetTextDefault(crgs: TBaseRowCollectionItem; var Value: string); override;
  end;

  TActionBO = class;

  TActionNode = class(TBaseNode)
  private
    function GetActionRowCollection: TActionRowCollection;
    function GetActionBO: TActionBO;
  protected
    function GetBaseColPropClass: TBaseColPropClass; override;
  public
    constructor Create(AOwner: TBaseColBO);
    destructor Destroy; override;
    procedure Init(RowCount: Integer);
    procedure Calc; override;
    function FindBib(Bib: Integer): TActionRowCollectionItem;
    property ActionRowCollection: TActionRowCollection read GetActionRowCollection;
    property ActionBO: TActionBO read GetActionBO;
  end;

  TActionBO = class(TBaseColBO)
  private
    FCurrentNode: TBaseNode;
    FCurrentRow: TBaseRowCollectionItem;
  protected
    function GetCurrentRow: TBaseRowCollectionItem; override;
    procedure SetCurrentRow(const Value: TBaseRowCollectionItem); override;
    function GetCurrentNode: TBaseNode; override;
    procedure SetCurrentNode(const Value: TBaseNode); override;
  public
    procedure InitColsActive(StringGrid: TColGrid); override;
    procedure InitColsActiveLayout(StringGrid: TColGrid; aLayout: Integer); override;
    property CurrentRow: TBaseRowCollectionItem read GetCurrentRow write  SetCurrentRow;
    property CurrentNode: TBaseNode read GetCurrentNode write SetCurrentNode;
  end;

  TActionData = class(TActionBO)
  private
    FIndex: Integer;
    function GetCount: Integer;
    function GetModified: Boolean;
    procedure SetModified(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load;
    procedure Calc;
    procedure Clear; override;
    function Add: TActionRowCollectionItem;
    procedure First;
    function Next: TActionRowCollectionItem;
    function Current: TActionRowCollectionItem;
    function Find(i: Integer): TActionRowCollectionItem;
    property Count: Integer read GetCount;
    property Modified: Boolean read GetModified write SetModified;
  end;

  TActionReport = class(TActionData)
  private
    Grid: TReportGrid;
  public
    Layout: Integer;
    WantProsa: Boolean;

    constructor Create;
    destructor Destroy; override;

    procedure IndexReport(SL: TStrings);
    procedure CssReport(SL: TStrings);
    procedure ProsaReport(SL: TStrings);
    procedure FinishReport(SL: TStrings);
    procedure FinishTable(SL: TStrings);
    procedure TableSortReport(SL: TStrings; Modus: Integer);
    procedure TableSortData(SL: TStrings);
  end;

implementation

uses
  RiggVar.App.Main;

const
  //NumID_Bib = 1;
  NumID_ActionValue = 2;
  NumID_Shortcut = 3;
  NumID_ActionName = 4;
  NumID_ShortName = 5;
  NumID_Caption = 6;
  NumID_ActionGroup = 7;

{ TActionRowCollectionItem }

procedure TActionRowCollectionItem.Assign(Source: TPersistent);
var
  o: TActionRowCollectionItem;
begin
  if Source is TActionRowCollectionItem then
  begin
    o := TActionRowCollectionItem(Source);
    ActionValue := o.ActionValue;
    ActionName := o.ActionName;
    ActionGroup := o.ActionGroup;
    ShortName := o.ShortName;
    Shortcut := o.Shortcut;
    Caption := o.Caption;
  end
  else
    inherited Assign(Source);
end;

procedure TActionRowCollectionItem.SetModified(const Value: Boolean);
var
  rd: TBaseNode;
begin
  rd := GetBaseNode;
  if Assigned(rd) then
    rd.Modified := True;
end;

function TActionRowCollectionItem.GetBaseNode: TBaseNode;
var
  cl: TActionRowCollection;
begin
  cl := Collection as TActionRowCollection;
  result := cl.BaseNode;
end;

function TActionRowCollectionItem.GetActionNode: TActionNode;
var
  cl: TActionRowCollection;
begin
  result := nil;
  cl := Collection as TActionRowCollection;
  if cl.BaseNode is TActionNode then
    result := TActionNode(cl.BaseNode);
end;

procedure TActionRowCollectionItem.ClearResult;
begin
  inherited;
  FActionValue := -1;
  FActionName := 'faUnknown';
  FActionGroup := 0;
  FShortName := 'ShortName';
  FShortcut := 'Shortcut';
  FCaption := 'Caption';
end;

destructor TActionRowCollectionItem.Destroy;
begin
  inherited;
end;

{ TActionRowCollection }

function TActionRowCollection.GetItem(Index: Integer): TActionRowCollectionItem;
begin
  result := nil;
  if (Index >= 0) and (Index < Count) then
    Result := TActionRowCollectionItem(inherited GetItem(Index));
end;

procedure TActionRowCollection.SetItem(Index: Integer; const Value:
  TActionRowCollectionItem);
begin
  if (Index >= 0) and (Index < Count) then
    inherited SetItem(Index, Value);
end;

function TActionRowCollection.Add: TActionRowCollectionItem;
begin
  Result := TActionRowCollectionItem(inherited Add);
  Result.BaseID := Count;
  Result.ClearResult;
end;

function TActionRowCollection.FindKey(Bib: Integer): TActionRowCollectionItem;
var
  i: Integer;
  o: TActionRowCollectionItem;
begin
  result := nil;
  for i := 0 to Count - 1 do
  begin
    o := Items[i];
    if (o.ID = Bib) then
    begin
      result := o;
      break;
    end;
  end;
end;

{ TActionColProp }

function TActionColProp.LeadingChars(LengthRequired: Integer; const sIn: string): string;
var
  s: string;
  i: Integer;
begin
  s := '';
  { get LengthRequired zeros / erstmal die required Anzahl Nullen holen }
  for i := 1 to LengthRequired do
    s := s + ' ';
  { place zeros in front / davorsetzen }
  s := s + sIn;
  { and select LengthRequired characters from the right / rightaligned auslesen }
  Result := Copy(s, Length(s) - LengthRequired + 1, LengthRequired);
end;

procedure TActionColProp.GetSortKeyActionName(crgs: TBaseRowCollectionItem;
  var Value: string; const ColName: string);
var
  cr: TActionRowCollectionItem;
  i: Integer;
begin
  if (crgs <> nil) and (crgs is TActionRowCollectionItem) then
  begin
    cr := TActionRowCollectionItem(crgs);
    i := CompareText(Value, cr.ActionName);
    if i > 0 then
      Value := cr.ActionName;
  end;
end;

procedure TActionColProp.GetSortKeyShortName(crgs: TBaseRowCollectionItem;
  var Value: string; const ColName: string);
var
  cr: TActionRowCollectionItem;
  i: Integer;
begin
  if (crgs <> nil) and (crgs is TActionRowCollectionItem) then
  begin
    cr := TActionRowCollectionItem(crgs);
    if StrToIntDef(cr.ShortName, -1) <> -1 then
    begin
      Value := LeadingChars(3, Value);
    end
    else
    begin
    i := CompareStr(Value, cr.FShortName);
    if i > 0 then
      Value := cr.FShortcut
  end;
end;
end;

procedure TActionColProp.GetSortKeyShortcut(crgs: TBaseRowCollectionItem;
  var Value: string; const ColName: string);
var
  cr: TActionRowCollectionItem;
  i: Integer;
begin
  if (crgs <> nil) and (crgs is TActionRowCollectionItem) then
  begin
    cr := TActionRowCollectionItem(crgs);
    if cr.FShortCut = '' then
    begin
      Value := '€€';
    end
    else
    begin
    i := CompareStr(Value, cr.FShortcut);
    if i > 0 then
      Value := cr.FShortcut
  end;
end;
end;

procedure TActionColProp.GetSortKeyCaption(crgs: TBaseRowCollectionItem;
  var Value: string; const ColName: string);
var
  cr: TActionRowCollectionItem;
  i: Integer;
begin
  if (crgs <> nil) and (crgs is TActionRowCollectionItem) then
  begin
    cr := TActionRowCollectionItem(crgs);

    if StrToIntDef(cr.Caption, -1) <> -1 then
    begin
      Value := LeadingChars(6, Value);
    end
    else
    begin
    i := CompareText(Value, cr.Caption);
    if i > 0 then
      Value := cr.Caption
  end;
end;
end;

procedure TActionColProp.GetTextDefault(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TActionRowCollectionItem;
begin
  Value := '';
  if crgs is TActionRowCollectionItem then
    cr := TActionRowCollectionItem(crgs)
  else
    exit;

  inherited;

  if NameID = 'col_AN' then
    Value := cr.ActionName

  else if NameID = 'col_AV' then
    Value := IntToStr(cr.FActionValue)

  else if NameID = 'col_AG' then
    Value := IntToStr(cr.FActionGroup)

  else if NameID = 'col_SN' then
    Value := cr.ShortName

  else if NameID = 'col_SC' then
    Value := cr.Shortcut

  else if NameID = 'col_CA' then
    Value := cr.Caption
end;

procedure TActionColProp.InitColsAvail;
var
  cp: TBaseColProp;
  ColsAvail: TBaseColProps;
begin
  if Collection is TBaseColProps then
    ColsAvail := TBaseColProps(Collection)
  else
    exit;

  inherited;

  cp := ColsAvail[0];
  cp.Width := 35;

  { ActionValue }
  cp := ColsAvail.Add;
  cp.NameID := 'col_AV';
  cp.Caption := 'AV';
  cp.Width := 45;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_ActionValue;

  { ActionGroup }
  cp := ColsAvail.Add;
  cp.NameID := 'col_AG';
  cp.Caption := 'Group';
  cp.Width := 45;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_ActionGroup;

  { ActionName }
  cp := ColsAvail.Add;
  cp.NameID := 'col_AN';
  cp.Caption := 'Action Name';
  cp.Width := 190;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeString;
  cp.OnGetSortKey2 := GetSortKeyActionName;
  cp.Alignment := taLeftJustify;
  cp.NumID := NumID_ActionName;

  { ShortName }
  cp := ColsAvail.Add;
  cp.NameID := 'col_SN';
  cp.Caption := 'Short Name';
  cp.Width := 80;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeString;
  cp.OnGetSortKey2 := GetSortKeyShortName;
  cp.Alignment := taLeftJustify;
  cp.NumID := NumID_ShortName;

  { Shortcut }
  cp := ColsAvail.Add;
  cp.NameID := 'col_SC';
  cp.Caption := 'Shortcut';
  cp.Width := 90;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeString;
  cp.OnGetSortKey2 := GetSortKeyShortcut;
  cp.Alignment := taLeftJustify;
  cp.NumID := NumID_Shortcut;

  { Caption }
  cp := ColsAvail.Add;
  cp.NameID := 'col_CA';
  cp.Caption := 'Caption';
  cp.Width := 220;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeString;
  cp.OnGetSortKey2 := GetSortKeyCaption;
  cp.Alignment := taLeftJustify;
  cp.NumID := NumID_Caption;
end;

{ TActionNode }

constructor TActionNode.Create(AOwner: TBaseColBO);
begin
  inherited;
  BaseRowCollection := TActionRowCollection.Create(Self, TActionRowCollectionItem);
end;

destructor TActionNode.Destroy;
begin
  BaseRowCollection.Free;
  inherited;
end;

function TActionNode.GetActionRowCollection: TActionRowCollection;
begin
  result := BaseRowCollection as TActionRowCollection;
end;

function TActionNode.GetBaseColPropClass: TBaseColPropClass;
begin
  result := TActionColProp;
end;

procedure TActionNode.Init(RowCount: Integer);
var
  o: TActionRowCollectionItem;
  i: Integer;
begin
  BaseRowCollection.Clear;

  for i := 0 to RowCount - 1 do
  begin
    o := ActionRowCollection.Add;
    o.BaseID := i + 1;
  end;
end;

procedure TActionNode.Calc;
begin
  Modified := False;
end;

function TActionNode.GetActionBO: TActionBO;
begin
  result := nil;
  if Assigned(BaseColBO) then
    result := BaseColBO as TActionBO;
end;

function TActionNode.FindBib(Bib: Integer): TActionRowCollectionItem;
var
  cl: TActionRowCollection;
  cr: TActionRowCollectionItem;
  i: Integer;
begin
  result := nil;
  if Bib = 0 then
    exit;
  cl := ActionRowCollection;
  for i := 0 to cl.Count-1 do
  begin
    cr := cl.Items[i];
    if cr.ID = Bib then
    begin
      result := cr;
      break;
    end;
  end;
end;

{ TActionBO }

procedure TActionBO.InitColsActive(StringGrid: TColGrid);
begin
  InitColsActiveLayout(StringGrid, 0);
end;

procedure TActionBO.InitColsActiveLayout(StringGrid: TColGrid;
  aLayout: Integer);
begin
  with StringGrid do
  begin
    ColsActive.Clear;
    AddColumn('col_BaseID');
    AddColumn('col_AG');
    AddColumn('col_AN');
    AddColumn('col_SN');
    AddColumn('col_SC');
    AddColumn('col_CA');
  end;
end;

function TActionBO.GetCurrentRow: TBaseRowCollectionItem;
begin
  result := FCurrentRow;
end;

function TActionBO.GetCurrentNode: TBaseNode;
begin
  result := FCurrentNode;
end;

procedure TActionBO.SetCurrentRow(const Value:
  TBaseRowCollectionItem);
begin
  if Value = nil then
    FCurrentRow := nil
  else
    FCurrentRow := Value;
end;

procedure TActionBO.SetCurrentNode(const Value: TBaseNode);
begin
  FCurrentNode := Value;
end;

{ TActionData }

function TActionData.Add: TActionRowCollectionItem;
begin
  result := nil;
  if FCurrentNode.BaseRowCollection.Count < faMax then
    result := TActionRowCollection(FCurrentNode.BaseRowCollection).Add;
end;

procedure TActionData.Calc;
begin
  CurrentNode.Calc;
end;

procedure TActionData.Clear;
begin
  inherited;
  FCurrentNode.BaseRowCollection.Clear;
end;

constructor TActionData.Create;
begin
  FCurrentNode := TActionNode.Create(self);
end;

destructor TActionData.Destroy;
begin
  FCurrentNode.Free;
  inherited;
end;

procedure TActionData.First;
begin
  FIndex := 0;
end;

function TActionData.GetCount: Integer;
begin
  result := CurrentNode.BaseRowCollection.Count;
end;

function TActionData.GetModified: Boolean;
begin
  result := CurrentNode.Modified;
end;

function TActionData.Current: TActionRowCollectionItem;
begin
  if (FIndex >= 0) and (FIndex < Count) then
    result := CurrentNode.BaseRowCollection.Items[FIndex] as TActionRowCollectionItem
  else
    result := nil;
end;

function TActionData.Next: TActionRowCollectionItem;
begin
  result := Current;
  Inc(FIndex);
end;

function TActionData.Find(i: Integer): TActionRowCollectionItem;
begin
  if (i >= 0) and (i < Count) then
    result := CurrentNode.BaseRowCollection.Items[i] as TActionRowCollectionItem
  else
    result := nil;
end;

procedure TActionData.SetModified(const Value: Boolean);
begin
  CurrentNode.Modified := Value;
end;

procedure TActionData.Load;
begin
  Main.LoadActionItems;
end;

{ TActionReport }

constructor TActionReport.Create;
begin
  inherited Create;
  WantProsa := false;
  Layout := 0;
  Grid := TReportGrid.Create;
  Grid.Name := 'ActionReport';
end;

destructor TActionReport.Destroy;
begin
  Grid.Free;
  inherited Destroy;
end;

procedure TActionReport.IndexReport(SL: TStrings);
var
  c: Integer;
  r: Integer;
  k: Integer;
  sep: string;
  g: TColGrid;
  cl: TBaseRowCollection;
  cr: TBaseRowCollectionItem;
  cp: TBaseColProp;
begin
  SL.Clear;
  sep := ',';

  { Shortcuts}
  cl := CurrentNode.BaseRowCollection;

  Grid.Node := CurrentNode;
  Grid.ColBO := self;
  Grid.Name := 'IndexReport';
  Grid.InitGrid;
  g := Grid.ColGrid;
  g.ColorSchema := colorRed;
  g.UseHTML := True;
  g.UpdateAll;

  { first column is ID-column, always counting from 1 upwards }
  for r := 0 to cl.Count - 1 do
  begin
    SL.Add(IntToStr(r+1));
  end;

  { from second column to last column }
  for c := 1 to g.ColsActive.Count - 1 do
  begin
    cp := g.ColsActive.Items[c];
    if cp = nil then
      Continue;

    { retain default sort-order for unsortable columns }
    if not cp.Sortable then
    begin
      for r := 0 to cl.Count - 1 do
      begin
        SL[r] := SL[r] + sep + IntToStr(r+1);
      end;
      Continue;
    end;

    g.InitDisplayOrder(c);
    for r := 0 to cl.Count - 1 do
    begin
      k := g.DisplayOrder.DisplayIndex[r];
      cr := cl[k];
      SL[r] := SL[r] + sep + IntToStr(cr.BaseID);
    end;
  end;

  for r := 0 to cl.Count - 2 do
  begin
    SL[r] := '[' + SL[r] + '],';
  end;
  r := cl.Count-1;
  if r > -1 then
  begin
    SL[r] := '[' + SL[r] + ']';
    SL.Insert(0, '[');
    SL.Add(']');
  end;
end;

procedure TActionReport.CssReport(SL: TStrings);
var
  crlf: string;
  cp: TBaseColProp;
  g: TColGrid;

  s, css, clss: string;
  r, c: Integer;

  p, race: Integer;
  srace: string;
  fleet: Integer;
begin
  SL.Clear();

  Grid.ColBO := CurrentNode.BaseColBO;
  Grid.Node := CurrentNode;
  Grid.Layout := Layout;
  Grid.Name := 'CssReport';
  Grid.InitGrid;
  g := Grid.ColGrid;
  g.ColsActive.SortColIndex := 0;
  g.AlwaysShowCurrent := false; // true = with Error-Colors and Current-Colors
  g.UseHTML := true;
  g.UpdateAll();

  SL.Add('<div id="results">');
  SL.Add('<table class="sortable fr results">');
  SL.Add(crlf);

  { header row }
  SL.Add('<thead>');
  SL.Add('<tr>');
  for c := 0 to Grid.Grid.ColCount - 1 do
  begin
    cp := g.ColsActive[c];
    if (cp = nil) then
      Continue;

    { content of field }
    s := g.GridModel.Cells[c, 0];
    if (s = '') then
        s := '&nbsp;';

    { css for field }
    css := 'h';
    if (cp.Alignment = taLeftJustify) then
        css := css + 'l';
    clss := Format(' class="%s"', [css]);

    { add field }
    SL.Add(Format('<th%s>%s</th>', [clss, s]));
  end;
  SL.Add('</tr>');
  SL.Add('</thead>');
  SL.Add('<tbody>');
  SL.Add(crlf);

  { normal rows }
  for r := 1 to g.GridModel.RowCount - 1 do
  begin
    SL.Add('<tr>');
    for c := 0 to g.GridModel.ColCount - 1 do
    begin
      cp := g.ColsActive[c];
      if (cp = nil) then
        Continue;

      { content of field }
      s := g.GridModel.Cells[c, r];
      if (s = '') then
          s := '&nbsp;';

      { css for field }
      clss := Grid.GetCSSClass(g.CellProps.CellProp[c, r]);

      { if column is a race-column }
      p := Pos('col_R', cp.NameID);
      if (p > 0) and (Length(cp.NameID) > 5) then
      begin
        srace := Copy(cp.NameID, 6, MaxInt);
        race := StrToIntDef(srace, -1);
        if (race > 0) then
        begin
          fleet := 0;
          css := 'g' + IntToStr(fleet);
          clss := Format(' class="%s"', [css]);
        end
      end
      else
      begin
        if Pos(clss, 'bgcolor') > 0 then
        begin
          css := 'n';
          clss := Format(' class="%s"', [css]);
        end;
      end;

      { add field }
      SL.Add(Format('<td%s>%s</td>', [clss, s]));
    end;
    SL.Add('</tr>');
    SL.Add(crlf);
  end;

  SL.Add('</tbody>');
  SL.Add('</table>');
  SL.Add('</div>');
end;

procedure TActionReport.ProsaReport(SL: TStrings);
var
  crlf: string;
  cp: TBaseColProp;
  g: TColGrid;

  s, css, clss: string;
  r, c: Integer;

  p, race: Integer;
  srace: string;
  fleet: Integer;
begin
  SL.Clear();

  Grid.ColBO := CurrentNode.BaseColBO;
  Grid.Node := CurrentNode;
  Grid.Layout := Layout;
  Grid.InitGrid;
  g := Grid.ColGrid;
  g.ColsActive.SortColIndex := 0;
  g.AlwaysShowCurrent := false; // true = with Error-Colors and Current-Colors
  g.UseHTML := true;
  g.UpdateAll();

  SL.Add('<div id="results">');
  SL.Add(crlf);

  for r := 1 to g.GridModel.RowCount - 1 do
  begin
    SL.Add('<p>');
    for c := 0 to g.GridModel.ColCount - 1 do
    begin
      cp := g.ColsActive[c];
      if (cp = nil) then
        Continue;

      { content of field }
      s := g.GridModel.Cells[c, r];
      if (s = '') then
          s := '&nbsp;';

      { css for field }
      clss := Grid.GetCSSClass(g.CellProps.CellProp[c, r]);

      { if column is a race-column }
      p := Pos('col_R', cp.NameID);
      if (p > 0) and (Length(cp.NameID) > 5) then
      begin
        srace := Copy(cp.NameID, 6, MaxInt);
        race := StrToIntDef(srace, -1);
        if (race > 0) then
        begin
          fleet := 0;
          css := 'g' + IntToStr(fleet);
          clss := Format(' class="%s"', [css]);
        end
      end
      else
      begin
        if Pos(clss, 'bgcolor') > 0 then
        begin
          css := 'n';
          clss := Format(' class="%s"', [css]);
        end;
      end;

      { add field }
      SL.Add(Format('<span%s>%s</span>', [clss, s]));
    end;
    SL.Add('</p>');
    SL.Add(crlf);
  end;

  SL.Add('</div>');
end;

procedure TActionReport.TableSortReport(SL: TStrings; Modus: Integer);
begin
  SL.Clear;
  SL.Add('<html>');
  SL.Add('<head><title></title></head>');
  SL.Add('<body>');
  SL.Add('<h1>Federgraph Actions</h1>');
  SL.Add('');
  TableSortData(SL);
  SL.Add('');
  SL.Add('</body>');
  SL.Add('</html>');
end;

procedure TActionReport.TableSortData(SL: TStrings);
var
  SL1: TStringList;
  i: Integer;
begin
  SL1 := TStringList.Create;
  try
    if WantProsa then
      ProsaReport(SL1)
    else
      CssReport(SL1);

    for i := 0 to SL1.Count - 1 do
    begin
      SL.Add(SL1[i]);
    end;
    SL.Add('');
    SL.Add('<div id="index_table"><pre>');
    IndexReport(SL1);
    for i := 0 to SL1.Count - 1 do
    begin
      SL.Add(SL1[i]);
    end;
    SL.Add('</pre></div>');
  finally
    SL1.Free;
  end;
end;

procedure TActionReport.FinishTable(SL: TStrings);
begin
  SL.Clear();
	TableSortData(SL);
end;

procedure TActionReport.FinishReport(SL: TStrings);
begin
  TableSortReport(SL, 1);
end;

end.

