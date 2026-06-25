unit RiggVar.Col.Animation;

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
  FMX.Types,
  FMX.Ani,
  RiggVar.Grid.ColGrid,
  RiggVar.FB.Classes,
  RiggVar.FB.Def;

const
  ATMax = 2;
  ITMax = 10;
  PMax = 29;
  VMin = -1000;
  VMax = 1000;
  DUMax = 10;

  AnimationTypeDefault = 2;
  InterpolationTypeDefault = 0;
  StartValueDefault = 1;
  StopValueDefault = 10;
  DurationDefault = 1;
  AutoReverseDefault = 1;
  LoopDefault = 0;
  FromCurrentDefault = 1;
  ParamDefault = 1;

type
  TAnimationNode = class;

  TAnimationRowCollectionItem = class(TBaseRowCollectionItem)
  private
    FAnimationType: Integer;
    FInterpolationType: Integer;
    FParam: Integer;
    FStartValue: Integer;
    FStopValue: Integer;
    FDuration: Integer;
    FAutoReverse: Integer;
    FLoop: Integer;
    FFromCurrent: Integer;
    FAnimation: TAnimation;
    procedure SetModified(const Value: Boolean);
    function GetAnimationNode: TAnimationNode;
    procedure SetAnimation(const Value: TAnimation);
  public
    destructor Destroy; override;

    function ATNumber(AT: TAnimationType): Integer;
    function ITNumber(IT: TInterpolationType): Integer;
    function ATString: string;
    function ITString: string;
    function ParamString: string;

    procedure Assign(Source: TPersistent); override;
    procedure ClearResult; override;
    function GetBaseNode: TBaseNode;
    property Modified: Boolean write SetModified;
    property ru: TAnimationNode read GetAnimationNode;
  published
    property AnimationType: Integer read FAnimationType write FAnimationType;
    property InterpolationType: Integer read FInterpolationType write FInterpolationType;
    property Param: Integer read FParam write FParam;
    property StartValue: Integer read FStartValue write FStartValue;
    property StopValue: Integer read FStopValue write FStopValue;
    property Duration: Integer read FDuration write FDuration;
    property AutoReverse: Integer read FAutoReverse write FAutoReverse;
    property Loop: Integer read FLoop write FLoop;
    property FromCurrent: Integer read FFromCurrent write FFromCurrent;
    property Animation: TAnimation read FAnimation write SetAnimation;
  end;

  TAnimationRowCollection = class(TBaseRowCollection)
  private
    function GetItem(Index: Integer): TAnimationRowCollectionItem;
    procedure SetItem(Index: Integer; const Value: TAnimationRowCollectionItem);
  public
    function Add: TAnimationRowCollectionItem;
    function FindKey(Bib: Integer): TAnimationRowCollectionItem;
    property Items[Index: Integer]: TAnimationRowCollectionItem read GetItem write SetItem;
  end;

  TAnimationColProp = class(TBaseColProp)
  public
    procedure InitColsAvail; override;
    procedure GetTextDefault(crgs: TBaseRowCollectionItem; var Value: string); override;
  end;

  TAnimationBO = class;

  TAnimationNode = class(TBaseNode)
  private
    function GetAnimationRowCollection: TAnimationRowCollection;
    function GetAnimationBO: TAnimationBO;
  protected
    function GetBaseColPropClass: TBaseColPropClass; override;
  public
    RectangleMode: Boolean;
    constructor Create(AOwner: TBaseColBO);
    destructor Destroy; override;
    procedure Init(RowCount: Integer);
    procedure Calc; override;
    function FindBib(Bib: Integer): TAnimationRowCollectionItem;
    property AnimationRowCollection: TAnimationRowCollection read GetAnimationRowCollection;
    property AnimationBO: TAnimationBO read GetAnimationBO;
  end;

  TAnimationBO = class(TBaseColBO)
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
    procedure InitColsActiveLayout(StringGrid: TColGrid; ALayout: Integer); override;
    procedure EditAnimationType(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditIterpolationType(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditParam(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditStartValue(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditStopValue(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditDuration(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditAutoReverse(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditLoop(crgs: TBaseRowCollectionItem; var Value: string);
    procedure EditFromCurrent(crgs: TBaseRowCollectionItem; var Value: string);
    property CurrentRow: TBaseRowCollectionItem read GetCurrentRow write SetCurrentRow;
    property CurrentNode: TBaseNode read GetCurrentNode write SetCurrentNode;
  end;

  TAnimationData = class(TAnimationBO)
  private
    FIndex: Integer;
    function GetCount: Integer;
    function GetModified: Boolean;
    procedure SetModified(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Calc;
    procedure Clear; override;
    function Add: TAnimationRowCollectionItem;
    procedure First;
    function Next: TAnimationRowCollectionItem;
    function Current: TAnimationRowCollectionItem;
    function Find(i: Integer): TAnimationRowCollectionItem;
    procedure Edit(fmk: TFederMessageKind; var V: string);
    property Count: Integer read GetCount;
    property Modified: Boolean read GetModified write SetModified;
  end;

implementation

uses
  RiggVar.App.Main;

const
  //NumID_Bib = 1;
  NumID_AnimationType = 2;
  NumID_InterpolationType = 3;
  NumID_Param = 4;
  NumID_StartValue = 5;
  NumID_StopValue = 6;
  NumID_Duration = 7;
  NumID_AutoReverse = 8;
  NumID_Loop = 9;
  NumID_FromCurrent = 10;


{ TAnimationRowCollectionItem }

procedure TAnimationRowCollectionItem.Assign(Source: TPersistent);
var
  o: TAnimationRowCollectionItem;
begin
  if Source is TAnimationRowCollectionItem then
  begin
    o := TAnimationRowCollectionItem(Source);
    AnimationType := o.AnimationType;
    InterpolationType := o.InterpolationType;
    StartValue := o.StartValue;
    StopValue := o.StopValue;
    Param := o.Param;
    Duration := o.Duration;
    AutoReverse := o.AutoReverse;
    Loop := o.Loop;
    FromCurrent := o.FromCurrent;
  end
  else
    inherited Assign(Source);
end;

procedure TAnimationRowCollectionItem.SetAnimation(const Value: TAnimation);
begin
  FAnimation := Value;
end;

procedure TAnimationRowCollectionItem.SetModified(const Value: Boolean);
var
  rd: TBaseNode;
begin
  rd := GetBaseNode;
  if Assigned(rd) then
    rd.Modified := True;
end;

function TAnimationRowCollectionItem.GetBaseNode: TBaseNode;
var
  cl: TAnimationRowCollection;
begin
  cl := Collection as TAnimationRowCollection;
  result := cl.BaseNode;
end;

function TAnimationRowCollectionItem.GetAnimationNode: TAnimationNode;
var
  cl: TAnimationRowCollection;
begin
  result := nil;
  cl := Collection as TAnimationRowCollection;
  if cl.BaseNode is TAnimationNode then
    result := TAnimationNode(cl.BaseNode);
end;

procedure TAnimationRowCollectionItem.ClearResult;
begin
  inherited;
  FAnimationType := AnimationTypeDefault;
  FInterpolationType := InterpolationTypeDefault;
  FParam := ParamDefault;
  StartValue := StartValueDefault;
  FStopValue := StopValueDefault;
  FDuration := DurationDefault;
  FAutoReverse := AutoReverseDefault;
  FLoop := LoopDefault;
  FFromCurrent := FromCurrentDefault;
end;

destructor TAnimationRowCollectionItem.Destroy;
begin
  if Assigned(FAnimation) then
  begin
    FAnimation.Stop;
    FAnimation.Free;
  end;
  inherited;
end;

function TAnimationRowCollectionItem.ATNumber(AT: TAnimationType): Integer;
begin
  case AT of
    TAnimationType.In: result := 0;
    TAnimationType.Out: result := 1;
    TAnimationType.InOut: result := 2;
    else
      result := 0;
  end;
end;

function TAnimationRowCollectionItem.ATString: string;
begin
  case FAnimationType of
    0: result := 'In';
    1: result := 'Out';
    2: result := 'InOut';
    else
      result := '';
  end;
end;

function TAnimationRowCollectionItem.ITNumber(IT: TInterpolationType): Integer;
begin
  case IT of
    TInterpolationType.Linear: result := 0;
    TInterpolationType.Quadratic: result := 1;
    TInterpolationType.Cubic: result := 2;
    TInterpolationType.Quartic: result := 3;
    TInterpolationType.Quintic: result := 4;
    TInterpolationType.Sinusoidal: result := 5;
    TInterpolationType.Exponential: result := 6;
    TInterpolationType.Circular: result := 7;
    TInterpolationType.Elastic: result := 8;
    TInterpolationType.Back: result := 9;
    TInterpolationType.Bounce: result := 10;
    else
      result := 0;
  end;
end;

function TAnimationRowCollectionItem.ITString: string;
begin
  case FInterpolationType of
    0: result := 'Linear';
    1: result := 'Quadratic';
    2: result := 'Cubic';
    3: result := 'Quartic';
    4: result := 'Quintic';
    5: result := 'Sinusoidal';
    6: result := 'Exponential';
    7: result := 'Circular';
    8: result := 'Elastic';
    9: result := 'Back';
    10: result := 'Bounce';
    else
      result := '';
  end;
end;

function TAnimationRowCollectionItem.ParamString: string;
begin
  result := TFederUtils.GetParamCaption(TFederUtils.GetFederParam(FParam));
end;

{ TAnimationRowCollection }

function TAnimationRowCollection.GetItem(Index: Integer): TAnimationRowCollectionItem;
begin
  result := nil;
  if (Index >= 0) and (Index < Count) then
    Result := TAnimationRowCollectionItem(inherited GetItem(Index));
end;

procedure TAnimationRowCollection.SetItem(Index: Integer; const Value:
  TAnimationRowCollectionItem);
begin
  if (Index >= 0) and (Index < Count) then
    inherited SetItem(Index, Value);
end;

function TAnimationRowCollection.Add: TAnimationRowCollectionItem;
begin
  Result := TAnimationRowCollectionItem(inherited Add);
  Result.BaseID := Count;
  Result.ClearResult;
end;

function TAnimationRowCollection.FindKey(Bib: Integer): TAnimationRowCollectionItem;
var
  i: Integer;
  o: TAnimationRowCollectionItem;
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

{ TAnimationColProp }

procedure TAnimationColProp.GetTextDefault(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
begin
  Value := '';
  if crgs is TAnimationRowCollectionItem then
    cr := TAnimationRowCollectionItem(crgs)
  else
    exit;

  inherited;

  if NameID = 'col_AT' then
    Value := cr.ATString

  else if NameID = 'col_IT' then
    Value := cr.ITString

  else if NameID = 'col_Start' then
    Value := IntToStr(cr.StartValue)

  else if NameID = 'col_Stop' then
    Value := IntToStr(cr.StopValue)

  else if NameID = 'col_Param' then
    Value := cr.ParamString

  else if NameID = 'col_DU' then
    Value := IntToStr(cr.Duration)

  else if NameID = 'col_AR' then
    Value := IntToStr(cr.AutoReverse)

  else if NameID = 'col_Loop' then
    Value := IntToStr(cr.Loop)

  else if NameID = 'col_FromCurrent' then
    Value := IntToStr(cr.FromCurrent)

end;

procedure TAnimationColProp.InitColsAvail;
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

  { AnimationType }
  cp := ColsAvail.Add;
  cp.NameID := 'col_AT';
  cp.Caption := 'AT';
  cp.Width := 45;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_AnimationType;

  { InterpolationType }
  cp := ColsAvail.Add;
  cp.NameID := 'col_IT';
  cp.Caption := 'IT';
  cp.Width := 70;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_InterpolationType;

  { Param }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Param';
  cp.Caption := 'Param';
  cp.Width := 70;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Param;

  { StartValue }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Start';
  cp.Caption := 'Start';
  cp.Width := 50;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_StartValue;

  { StopValue }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Stop';
  cp.Caption := 'Stop';
  cp.Width := 50;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_StopValue;

  { Duration }
  cp := ColsAvail.Add;
  cp.NameID := 'col_DU';
  cp.Caption := 'DU';
  cp.Width := 30;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Duration;

  { AutoReverse }
  cp := ColsAvail.Add;
  cp.NameID := 'col_AR';
  cp.Caption := 'AR';
  cp.Width := 30;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_AutoReverse;

  { Loop }
  cp := ColsAvail.Add;
  cp.NameID := 'col_Loop';
  cp.Caption := 'LP';
  cp.Width := 30;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_Loop;

  { FromCurrent }
  cp := ColsAvail.Add;
  cp.NameID := 'col_FromCurrent';
  cp.Caption := 'FC';
  cp.Width := 30;
  cp.Sortable := True;
  cp.Alignment := taRightJustify;
  cp.NumID := NumID_FromCurrent;
end;

{ TAnimationNode }

constructor TAnimationNode.Create(AOwner: TBaseColBO);
begin
  inherited;
  BaseRowCollection := TAnimationRowCollection.Create(Self, TAnimationRowCollectionItem);
end;

destructor TAnimationNode.Destroy;
begin
  BaseRowCollection.Free;
  inherited;
end;

function TAnimationNode.GetAnimationRowCollection: TAnimationRowCollection;
begin
  result := BaseRowCollection as TAnimationRowCollection;
end;

function TAnimationNode.GetBaseColPropClass: TBaseColPropClass;
begin
  result := TAnimationColProp;
end;

procedure TAnimationNode.Init(RowCount: Integer);
var
  o: TAnimationRowCollectionItem;
  i: Integer;
begin
  BaseRowCollection.Clear;

  for i := 0 to RowCount - 1 do
  begin
    o := AnimationRowCollection.Add;
    o.BaseID := i + 1;
  end;
end;

procedure TAnimationNode.Calc;
begin
  Main.AnimationPlayer.Calc;
  { note: Modified is not used here }
  Modified := False;
end;

function TAnimationNode.GetAnimationBO: TAnimationBO;
begin
  result := nil;
  if Assigned(BaseColBO) then
    result := BaseColBO as TAnimationBO;
end;

function TAnimationNode.FindBib(Bib: Integer): TAnimationRowCollectionItem;
var
  cl: TAnimationRowCollection;
  cr: TAnimationRowCollectionItem;
  i: Integer;
begin
  result := nil;
  if Bib = 0 then
    exit;
  cl := AnimationRowCollection;
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

{ TAnimationBO }

procedure TAnimationBO.InitColsActive(StringGrid: TColGrid);
begin
  InitColsActiveLayout(StringGrid, 0);
end;

procedure TAnimationBO.InitColsActiveLayout(StringGrid: TColGrid; ALayout: Integer);
var
  cp: TBaseColProp;
begin
  StringGrid.ColsActive.Clear;
  StringGrid.AddColumn('col_BaseID');

  StringGrid.AddColumn('col_Bib');
  cp := StringGrid.AddColumn('col_AT');
  cp.OnFinishEdit := EditAnimationType;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_IT');
  cp.OnFinishEdit := EditIterpolationType;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_Param');
  cp.OnFinishEdit := EditParam;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_Stop');
  cp.OnFinishEdit := EditStopValue;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_Start');
  cp.OnFinishEdit := EditStartValue;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_DU');
  cp.OnFinishEdit := EditDuration;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_AR');
  cp.OnFinishEdit := EditAutoReverse;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_Loop');
  cp.OnFinishEdit := EditLoop;
  cp.ReadOnly := False;

  cp := StringGrid.AddColumn('col_FromCurrent');
  cp.OnFinishEdit := EditFromCurrent;
  cp.ReadOnly := False;
end;

function TAnimationBO.GetCurrentRow: TBaseRowCollectionItem;
begin
  result := FCurrentRow;
end;

function TAnimationBO.GetCurrentNode: TBaseNode;
begin
  result := FCurrentNode;
end;

procedure TAnimationBO.SetCurrentRow(const Value:
  TBaseRowCollectionItem);
begin
  if Value = nil then
    FCurrentRow := nil
  else
    FCurrentRow := Value;
end;

procedure TAnimationBO.SetCurrentNode(const Value: TBaseNode);
begin
  FCurrentNode := Value;
end;

procedure TAnimationBO.EditAnimationType(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
begin
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    cr.AnimationType := StrToIntDef(Value, cr.AnimationType);
    if cr.AnimationType > ATMax then
      cr.AnimationType := ATMax;
    if cr.AnimationType < 0 then
      cr.AnimationType := 0;
    Value := cr.ATString;
    cr.Modified := True;
  end;
end;

procedure TAnimationBO.EditIterpolationType(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
begin
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    cr.InterpolationType := StrToIntDef(Value, cr.InterpolationType);
    if cr.InterpolationType > ITMax then
      cr.InterpolationType := ITMax;
    if cr.InterpolationType < 0 then
      cr.InterpolationType := 0;
    Value := cr.ITString;
    cr.Modified := True;
  end;
end;

procedure TAnimationBO.EditParam(crgs: TBaseRowCollectionItem; var Value: string);
var
  cr: TAnimationRowCollectionItem;
  temp: Integer;
begin
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    { Achtung:
      In FR14 Receiving StrToIntDef erforderlich, weil Param als Zahl über das Netzwerk kommt.
      In FR12 muss 'x1' durchgelassen werden, darf nicht als hex interpetiert werden.
    }
    temp := -1;
    if not TUtils.StartsWith(Value, Lowercase('x')) then
      temp := StrToIntDef(Value, -1);
    if temp = -1 then
      temp := TFederUtils.StrToParamIndex(Value) + 1;
    if (temp > PMax) or (temp < 0) then
    begin
      Value := cr.ParamString;
    end
    else
    begin
      cr.Param := temp;
      Value := cr.ParamString;
      cr.Modified := True;
    end;
  end;
end;

procedure TAnimationBO.EditStartValue(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
  temp: Integer;
begin
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    temp  := StrToIntDef(Value, cr.StartValue);
    if temp > VMax then
      temp := VMax
    else if temp < VMin then
      temp := VMin;
    cr.StartValue := temp;
    Value := IntToStr(cr.StartValue);
    cr.Modified := True;
  end;
end;

procedure TAnimationBO.EditStopValue(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
  temp: Integer;
begin
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    temp  := StrToIntDef(Value, cr.StopValue);
    if temp > VMax then
      temp := VMax
    else if temp < VMin then
      temp := VMin;
    cr.StopValue := temp;
    Value := IntToStr(cr.StopValue);
    cr.Modified := True;
  end;
end;

procedure TAnimationBO.EditDuration(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
  temp: Integer;
begin
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    temp  := StrToIntDef(Value, cr.Duration);
    if temp > VMax then
      temp := VMax
    else if temp < VMin then
      temp := VMin;
    cr.Duration := temp;
    Value := IntToStr(cr.Duration);
    cr.Modified := True;
  end;
end;

procedure TAnimationBO.EditAutoReverse(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
  temp: Integer;
begin
  { Value string should parse as Boolean, 0 = False, 1 = True }
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    temp  := StrToIntDef(Value, cr.AutoReverse);
    if temp > 0 then
      temp := 1
    else if temp < 1 then
      temp := 0;
    cr.AutoReverse := temp;
    Value := IntToStr(cr.AutoReverse);
    cr.Modified := True;
  end;
end;

procedure TAnimationBO.EditLoop(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
  temp: Integer;
begin
  { Value string should parse as Boolean, 0 = False, 1 = True }
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    temp  := StrToIntDef(Value, cr.Loop);
    if temp > 0 then
      temp := 1
    else if temp < 1 then
      temp := 0;
    cr.Loop := temp;
    Value := IntToStr(cr.Loop);
    cr.Modified := True;
  end;
end;

procedure TAnimationBO.EditFromCurrent(crgs: TBaseRowCollectionItem; var Value:
  string);
var
  cr: TAnimationRowCollectionItem;
  temp: Integer;
begin
  { Value string should parse as Boolean, 0 = False, 1 = True }
  if (crgs <> nil) and (crgs is TAnimationRowCollectionItem) then
  begin
    cr := TAnimationRowCollectionItem(crgs);
    temp  := StrToIntDef(Value, cr.FromCurrent);
    if temp > 0 then
      temp := 1
    else if temp < 1 then
      temp := 0;
    cr.FromCurrent := temp;
    Value := IntToStr(cr.FromCurrent);
    cr.Modified := True;
  end;
end;

{ TAnimationData }

function TAnimationData.Add: TAnimationRowCollectionItem;
begin
  if FCurrentNode.BaseRowCollection.Count < 200 then
    FCurrentRow := TAnimationRowCollection(FCurrentNode.BaseRowCollection).Add;
  result := TAnimationRowCollectionItem(FCurrentRow);
end;

procedure TAnimationData.Calc;
begin
  CurrentNode.Calc;
end;

procedure TAnimationData.Clear;
begin
  inherited;
  FCurrentNode.BaseRowCollection.Clear;
end;

constructor TAnimationData.Create;
begin
  FCurrentNode := TAnimationNode.Create(self);
end;

destructor TAnimationData.Destroy;
begin
  FCurrentNode.Free;
  inherited;
end;

procedure TAnimationData.Edit(fmk: TFederMessageKind; var V: string);
begin
  case fmk of
    fmkAnimNewStory: Clear;
    fmkAnimNewEntry: Add;

    fmkAnimParam: EditParam(CurrentRow, V);
    fmkAnimStartValue: EditStartValue(CurrentRow, V);
    fmkAnimStopValue: EditStopValue(CurrentRow, V);

    fmkAnimAT: EditAnimationType(CurrentRow, V);
    fmkAnimIT: EditIterpolationType(CurrentRow, V);
    fmkAnimDU: EditDuration(CurrentRow, V);
    fmkAnimAR: EditAutoReverse(CurrentRow, V);
    fmkAnimLP: EditLoop(CurrentRow, V);
    fmkAnimFC: EditFromCurrent(CurrentRow, V);

    fmkAnimGO:
    begin
      //
    end;
  end;
end;

procedure TAnimationData.First;
begin
  FIndex := 0;
end;

function TAnimationData.GetCount: Integer;
begin
  result := CurrentNode.BaseRowCollection.Count;
end;

function TAnimationData.GetModified: Boolean;
begin
  result := CurrentNode.Modified;
end;

function TAnimationData.Current: TAnimationRowCollectionItem;
begin
  if (FIndex >= 0) and (FIndex < Count) then
    result := CurrentNode.BaseRowCollection.Items[FIndex] as TAnimationRowCollectionItem
  else
    result := nil;
end;

function TAnimationData.Next: TAnimationRowCollectionItem;
begin
  result := Current;
  Inc(FIndex);
end;

function TAnimationData.Find(i: Integer): TAnimationRowCollectionItem;
begin
  if (i >= 0) and (i < Count) then
    result := CurrentNode.BaseRowCollection.Items[i] as TAnimationRowCollectionItem
  else
    result := nil;
end;

procedure TAnimationData.SetModified(const Value: Boolean);
begin
  CurrentNode.Modified := Value;
end;

end.

