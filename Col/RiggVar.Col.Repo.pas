unit RiggVar.Col.Repo;

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
  TRepoNode = class;

  TRepoRowCollectionItem = class(TBaseRowCollectionItem)
  private
    procedure SetModified(const Value: Boolean);
    function GetEventNode: TRepoNode;
  public
    Hub: Integer;
    Sample: Integer;
    Scene: Integer;
    Plot: Integer;
    PlotFigure: Integer;
    Bitmap: Integer;
    Param: Integer;
    Title: string;

    procedure Assign(Source: TPersistent); override;
    procedure ClearResult; override;
    function GetBaseNode: TBaseNode;
    property Modified: Boolean write SetModified;
    property ru: TRepoNode read GetEventNode;
  end;

  TRepoRowCollection = class(TBaseRowCollection)
  private
    function GetItem(Index: Integer): TRepoRowCollectionItem;
    procedure SetItem(Index: Integer; const Value: TRepoRowCollectionItem);
  public
    function Add: TRepoRowCollectionItem;
    function FindKey(Bib: Integer): TRepoRowCollectionItem;
    property Items[Index: Integer]: TRepoRowCollectionItem read GetItem write
      SetItem;
  end;

  TRepoColProp = class(TBaseColProp)
  private
    procedure GetSortKeyTitle(crgs: TBaseRowCollectionItem;
      var Value: string; const ColName: string);
    function LeadingChars(LengthRequired: Integer; const sIn: string): string;
  public
    procedure InitColsAvail; override;
    procedure GetTextDefault(crgs: TBaseRowCollectionItem; var Value: string);
      override;
  end;

  TRepoBO = class;

  TRepoNode = class(TBaseNode)
  private
    function GetEventRowCollection: TRepoRowCollection;
    function GetEventBO: TRepoBO;
  protected
    function GetBaseColPropClass: TBaseColPropClass; override;
  public
    constructor Create(AOwner: TBaseColBO);
    destructor Destroy; override;
    procedure Init(RowCount: Integer);
    procedure Calc; override;
    function FindBib(Bib: Integer): TRepoRowCollectionItem;
    property EventRowCollection: TRepoRowCollection read GetEventRowCollection;
    property EventBO: TRepoBO read GetEventBO;
  end;

  TRepoBO = class(TBaseColBO)
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
    property CurrentRow: TBaseRowCollectionItem read GetCurrentRow write
      SetCurrentRow;
    property CurrentNode: TBaseNode read GetCurrentNode write SetCurrentNode;
  end;

  TRepoData = class(TRepoBO)
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
    function Add: TRepoRowCollectionItem;
    procedure First;
    function Next: TRepoRowCollectionItem;
    function Current: TRepoRowCollectionItem;
    function Find(i: Integer): TRepoRowCollectionItem;
    property Count: Integer read GetCount;
    property Modified: Boolean read GetModified write SetModified;
  end;

  TRepoReport = class(TRepoData)
  private
    Grid: TReportGrid;
  public
    Node: TBaseNode;
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
  NumID_Hub = 2;
  NumID_Sample = 3;
  NumID_Scene = 4;
  NumID_Plot = 5;
  NumID_PlotFigure = 6;
  NumID_Bitmap = 7;
  NumID_Param = 8;
  NumID_Title = 9;

{ TEventRowCollectionItem }

procedure TRepoRowCollectionItem.Assign(Source: TPersistent);
var
  o: TRepoRowCollectionItem;
begin
  if Source is TRepoRowCollectionItem then
  begin
    o := TRepoRowCollectionItem(Source);
    Hub := o.Hub;
    Sample := o.Sample;
    Scene := o.Scene;
    Plot := o.Plot;
    PlotFigure := o.PlotFigure;
    Bitmap := o.Bitmap;
    Param := o.Param;
    Title := o.Title;
  end
  else
    inherited Assign(Source);
end;

procedure TRepoRowCollectionItem.SetModified(const Value: Boolean);
var
  rd: TBaseNode;
begin
  rd := GetBaseNode;
  if Assigned(rd) then
    rd.Modified := True;
end;

function TRepoRowCollectionItem.GetBaseNode: TBaseNode;
var
  cl: TRepoRowCollection;
begin
  cl := Collection as TRepoRowCollection;
  result := cl.BaseNode;
end;

function TRepoRowCollectionItem.GetEventNode: TRepoNode;
var
  cl: TRepoRowCollection;
begin
  result := nil;
  cl := Collection as TRepoRowCollection;
  if cl.BaseNode is TRepoNode then
    result := TRepoNode(cl.BaseNode);
end;

procedure TRepoRowCollectionItem.ClearResult;
begin
  inherited;
  Hub := 1;
  Sample := 1;
  Scene := 3;
  Plot := 10;
  PlotFigure := 0;
  Bitmap := 12;
  Param := 1;
  Title := '';
end;

{ TEventRowCollection }

function TRepoRowCollection.GetItem(Index: Integer): TRepoRowCollectionItem;
begin
  result := nil;
  if (Index >= 0) and (Index < Count) then
    Result := TRepoRowCollectionItem(inherited GetItem(Index));
end;

procedure TRepoRowCollection.SetItem(Index: Integer; const Value:
  TRepoRowCollectionItem);
begin
  if (Index >= 0) and (Index < Count) then
    inherited SetItem(Index, Value);
end;

function TRepoRowCollection.Add: TRepoRowCollectionItem;
begin
  Result := TRepoRowCollectionItem(inherited Add);
  Result.BaseID := Count;
  Result.ClearResult;
end;

function TRepoRowCollection.FindKey(Bib: Integer): TRepoRowCollectionItem;
var
  i: Integer;
  o: TRepoRowCollectionItem;
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

{ TEventColProp }

function TRepoColProp.LeadingChars(LengthRequired: Integer; const sIn: string): string;
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

procedure TRepoColProp.GetSortKeyTitle(crgs: TBaseRowCollectionItem;
  var Value: string; const ColName: string);
var
  cr: TRepoRowCollectionItem;
  i: Integer;
begin
  if (crgs <> nil) and (crgs is TRepoRowCollectionItem) then
  begin
    cr := TRepoRowCollectionItem(crgs);
    if StrToIntDef(cr.Title, -1) <> -1 then
    begin
      Value := LeadingChars(6, Value);
    end
    else
    begin
      i := CompareText(Value, cr.Title);
      if i > 0 then
        Value := cr.Title;
    end;
  end;
end;

procedure TRepoColProp.GetTextDefault(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TRepoRowCollectionItem;
begin
  Value := '';
  if crgs is TRepoRowCollectionItem then
    cr := TRepoRowCollectionItem(crgs)
  else
    exit;

  inherited;

  if NameID = 'col_Hub' then
    Value := IntToStr(cr.Hub)

  else if NameID = 'col_Sample' then
    Value := IntToStr(cr.Sample)

  else if NameID = 'col_Scene' then
    Value := IntToStr(cr.Scene)

  else if NameID = 'col_Plot' then
    Value := IntToStr(cr.Plot)

  else if NameID = 'col_PlotFigure' then
    Value := IntToStr(cr.PlotFigure)

  else if NameID = 'col_Bitmap' then
    Value := IntToStr(cr.Bitmap)

  else if NameID = 'col_Param' then
    Value := IntToStr(cr.Param)

  else if NameID = 'col_Title' then
    Value := cr.Title
end;

procedure TRepoColProp.InitColsAvail;
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

  { Hub }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Hub';
  cp.Caption := 'Hub';
  cp.Width := 45;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Hub;

  { Sample }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Sample';
  cp.Caption := 'Sample';
  cp.Width := 60;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Sample;

  { Scene }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Scene';
  cp.Caption := 'Scene';
  cp.Width := 45;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Scene;

  { Plot }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Plot';
  cp.Caption := 'Plot';
  cp.Width := 45;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Plot;

  { PlotFigure }
  cp := ColsAvail.Add;
  cp.NameID := 'col_PlotFigure';
  cp.Caption := 'PF';
  cp.Width := 45;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_PlotFigure;

  { Bitmap }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Bitmap';
  cp.Caption := 'Bitmap';
  cp.Width := 45;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Bitmap;

  { Param }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Param';
  cp.Caption := 'Param';
  cp.Width := 45;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeInteger;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Param;

  { Title }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Title';
  cp.Caption := 'Title';
  cp.Width := 200;
  cp.Sortable := True;
  cp.ColType := TColType.colTypeString;
  cp.OnGetSortKey2 := GetSortKeyTitle;
  cp.Alignment := taLeftJustify;
  cp.NumID := NumID_Title;
end;

{ TEventNode }

constructor TRepoNode.Create(AOwner: TBaseColBO);
begin
  inherited;
  BaseRowCollection := TRepoRowCollection.Create(Self, TRepoRowCollectionItem);
end;

destructor TRepoNode.Destroy;
begin
  BaseRowCollection.Free;
  inherited;
end;

function TRepoNode.GetEventRowCollection: TRepoRowCollection;
begin
  result := BaseRowCollection as TRepoRowCollection;
end;

function TRepoNode.GetBaseColPropClass: TBaseColPropClass;
begin
  result := TRepoColProp;
end;

procedure TRepoNode.Init(RowCount: Integer);
var
  o: TRepoRowCollectionItem;
  i: Integer;
begin
  BaseRowCollection.Clear;

  for i := 0 to RowCount - 1 do
  begin
    o := EventRowCollection.Add;
    o.BaseID := i + 1;
  end;
end;

procedure TRepoNode.Calc;
begin
  Modified := False;
end;

function TRepoNode.GetEventBO: TRepoBO;
begin
  result := nil;
  if Assigned(BaseColBO) then
    result := BaseColBO as TRepoBO;
end;

function TRepoNode.FindBib(Bib: Integer): TRepoRowCollectionItem;
var
  cl: TRepoRowCollection;
  cr: TRepoRowCollectionItem;
  i: Integer;
begin
  result := nil;
  if Bib = 0 then
    exit;
  cl := EventRowCollection;
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

{ TEventBO }

procedure TRepoBO.InitColsActive(StringGrid: TColGrid);
begin
  InitColsActiveLayout(StringGrid, 0);
end;

procedure TRepoBO.InitColsActiveLayout(StringGrid: TColGrid;
  aLayout: Integer);
begin
  with StringGrid do
  begin
    ColsActive.Clear;
    AddColumn('col_BaseID');
    AddColumn('col_Hub');
    AddColumn('col_Sample');
    AddColumn('col_Scene');
    AddColumn('col_Plot');
    AddColumn('col_PlotFigure');
    AddColumn('col_Bitmap');
    AddColumn('col_Param');
    AddColumn('col_Title');
  end;
end;

function TRepoBO.GetCurrentRow: TBaseRowCollectionItem;
begin
  result := FCurrentRow;
end;

function TRepoBO.GetCurrentNode: TBaseNode;
begin
  result := FCurrentNode;
end;

procedure TRepoBO.SetCurrentRow(const Value:
  TBaseRowCollectionItem);
begin
  if Value = nil then
    FCurrentRow := nil
  else
    FCurrentRow := Value;
end;

procedure TRepoBO.SetCurrentNode(const Value: TBaseNode);
begin
  FCurrentNode := Value;
end;

{ TActionData }

function TRepoData.Add: TRepoRowCollectionItem;
begin
  result := nil;
  if FCurrentNode.BaseRowCollection.Count < faMax then
    result := TRepoRowCollection(FCurrentNode.BaseRowCollection).Add;
end;

procedure TRepoData.Calc;
begin
  CurrentNode.Calc;
end;

procedure TRepoData.Clear;
begin
  inherited;
  FCurrentNode.BaseRowCollection.Clear;
end;

constructor TRepoData.Create;
begin
  FCurrentNode := TRepoNode.Create(self);
end;

destructor TRepoData.Destroy;
begin
  FCurrentNode.Free;
  inherited;
end;

procedure TRepoData.First;
begin
  FIndex := 0;
end;

function TRepoData.GetCount: Integer;
begin
  result := CurrentNode.BaseRowCollection.Count;
end;

function TRepoData.GetModified: Boolean;
begin
  result := CurrentNode.Modified;
end;

function TRepoData.Current: TRepoRowCollectionItem;
begin
  if (FIndex >= 0) and (FIndex < Count) then
    result := CurrentNode.BaseRowCollection.Items[FIndex] as TRepoRowCollectionItem
  else
    result := nil;
end;

function TRepoData.Next: TRepoRowCollectionItem;
begin
  result := Current;
  Inc(FIndex);
end;

function TRepoData.Find(i: Integer): TRepoRowCollectionItem;
begin
  if (i >= 0) and (i < Count) then
    result := CurrentNode.BaseRowCollection.Items[i] as TRepoRowCollectionItem
  else
    result := nil;
end;

procedure TRepoData.SetModified(const Value: Boolean);
begin
  CurrentNode.Modified := Value;
end;

procedure TRepoData.Load;
begin
  Main.LoadSampleItems;
end;

{ TActionReport }

constructor TRepoReport.Create;
begin
  inherited Create;
  WantProsa := false;
  Layout := 0;
  Grid := TReportGrid.Create;
  Grid.Name := 'WebOutput';
end;

destructor TRepoReport.Destroy;
begin
  Grid.Free;
  inherited Destroy;
end;

procedure TRepoReport.IndexReport(SL: TStrings);
var
  c: Integer;
  r: Integer;
  k: Integer;
  sep: string;
  g: TColGrid;
  ev: TRepoBO;
  cl: TBaseRowCollection;
  cr: TBaseRowCollectionItem;
  cp: TBaseColProp;
begin
  SL.Clear;
  sep := ',';

  //Shortcuts
  ev := self;
  Node := ev.CurrentNode;
  cl := Node.BaseRowCollection;

  Grid.Node := Node;
  Grid.ColBO := ev;
  Grid.Name := 'IndexReport';
  Grid.InitGrid;
  g := Grid.ColGrid;
  g.ColorSchema := colorRed;
  g.UseHTML := True;
  g.UpdateAll;

  //first column is ID-column, always counting from 1 upwards
  for r := 0 to cl.Count - 1 do
  begin
    SL.Add(IntToStr(r+1));
  end;

  //from second column to last column
  for c := 1 to g.ColsActive.Count - 1 do
  begin
    cp := g.ColsActive.Items[c];
    if cp = nil then
      Continue;

    //retain default sort-order for unsortable columns
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

procedure TRepoReport.CssReport(SL: TStrings);
var
  crlf: string;
  en: TRepoNode;
  cp: TBaseColProp;
  g: TColGrid;

  s, css, clss: string;
  r, c: Integer;

  p, race: Integer;
  srace: string;
  fleet: Integer;
begin
  SL.Clear();

  en := CurrentNode as TRepoNode;

  Node := en;

  Grid.ColBO := Node.BaseColBO;
  Grid.Node := Node;
  Grid.Layout := Layout;
  Grid.Name := 'CssReport';
  Grid.InitGrid;
  g := Grid.ColGrid;
  g.ColsActive.SortColIndex := 0;
  g.AlwaysShowCurrent := false; //true=with Error-Colors and Current-Colors
  g.UseHTML := true;
  g.UpdateAll();

  SL.Add('<div id="results">');
  SL.Add('<table class="sortable fr results">');
  SL.Add(crlf);

  //header row
  SL.Add('<thead>');
  SL.Add('<tr>');
  for c := 0 to Grid.Grid.ColCount - 1 do
  begin
    cp := g.ColsActive[c];
    if (cp = nil) then
      Continue;

    //content of field
    s := g.GridModel.Cells[c, 0];
    if (s = '') then
        s := '&nbsp;';

    //css for field
    css := 'h';
    if (cp.Alignment = taLeftJustify) then
        css := css + 'l';
    clss := Format(' class="%s"', [css]);

    //add field
    SL.Add(Format('<th%s>%s</th>', [clss, s]));
  end;
  SL.Add('</tr>');
  SL.Add('</thead>');
  SL.Add('<tbody>');
  SL.Add(crlf);

  //normal rows
  for r := 1 to g.GridModel.RowCount - 1 do
  begin
    SL.Add('<tr>');
    for c := 0 to g.GridModel.ColCount - 1 do
    begin
      cp := g.ColsActive[c];
      if (cp = nil) then
        Continue;

      //content of field
      s := g.GridModel.Cells[c, r];
      if (s = '') then
          s := '&nbsp;';

      //css for field
      clss := Grid.GetCSSClass(g.CellProps.CellProp[c, r]);

      //if column is a race-column
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

      //add field
      SL.Add(Format('<td%s>%s</td>', [clss, s]));
    end;
    SL.Add('</tr>');
    SL.Add(crlf);
  end;

  SL.Add('</tbody>');
  SL.Add('</table>');
  SL.Add('</div>');
end;

procedure TRepoReport.ProsaReport(SL: TStrings);
var
  crlf: string;
  en: TRepoNode;
  cp: TBaseColProp;
  g: TColGrid;

  s, css, clss: string;
  r, c: Integer;

  p, race: Integer;
  srace: string;
  fleet: Integer;
begin
  SL.Clear();

  en := CurrentNode as TRepoNode;

  Node := en;

  Grid.ColBO := Node.BaseColBO;
  Grid.Node := Node;
  Grid.Layout := Layout;
  Grid.InitGrid;
  g := Grid.ColGrid;
  g.ColsActive.SortColIndex := 0;
  g.AlwaysShowCurrent := false; //true=with Error-Colors and Current-Colors
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

      //content of field
      s := g.GridModel.Cells[c, r];
      if (s = '') then
          s := '&nbsp;';

      //css for field
      clss := Grid.GetCSSClass(g.CellProps.CellProp[c, r]);

      //if column is a race-column
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

      //add field
      SL.Add(Format('<span%s>%s</span>', [clss, s]));
    end;
    SL.Add('</p>');
    SL.Add(crlf);
  end;

  SL.Add('</div>');
end;

procedure TRepoReport.TableSortReport(SL: TStrings; Modus: Integer);
begin
  SL.Clear;
  SL.Add('<html>');
  SL.Add('<head><title></title></head>');
  SL.Add('<body>');
  SL.Add('<h1>Federgraph Repo</h1>');
  SL.Add('');
  TableSortData(SL);
  SL.Add('');
  SL.Add('</body>');
  SL.Add('</html>');
end;

procedure TRepoReport.TableSortData(SL: TStrings);
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

procedure TRepoReport.FinishTable(SL: TStrings);
begin
  SL.Clear();
	TableSortData(SL);
end;

procedure TRepoReport.FinishReport(SL: TStrings);
begin
  TableSortReport(SL, 1);
end;

end.

