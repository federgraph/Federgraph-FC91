unit RiggVar.Anim.Script;

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
  FMX.Forms,
  FMX.Types,
  FMX.Types3D,
  Math,
  RiggVar.Col.Animation,
  RiggVar.FB.Def,
  RiggVar.FB.Data,
  RiggVar.FB.Classes,
  RiggVar.FederModel.Memory;

type
  TManualTransition = class(TFederMemory)
  public
    procedure Transit; override;
  end;

  TFederScript = class(TLineParser)
  private
    VKL: TStringList;
    MLRef: TStrings;
    GhostWritingOn: Boolean;
    FAngleDiff: single;
    FAutoReverse: Boolean;
    FUniformRotation: Boolean;

    fd: TFederData;
    cr: TAnimationRowCollectionItem;
    FAddLine: TRecorderEvent;

    procedure SetColor(const Value: Integer);
    procedure SetSample(const Value: Integer);
    procedure SetRX(const Value: single);
    procedure SetRY(const Value: single);
    procedure SetRZ(const Value: single);
    procedure SetRW(const Value: single);
    procedure SetNS(const Value: Integer);
    procedure SetDU(const Value: Integer);
    procedure SetIT(const Value: TInterpolationType);
    procedure SetAT(const Value: TAnimationType);
    procedure SetAR(const Value: Boolean);
    procedure SetFC(const Value: Boolean);
    procedure InitCurrent;
    procedure AddLineFunction(k: string; v: Integer);
    procedure InitKeys;
    function IsValidKey(s: string): Boolean;
    function NormalizeAngle(Angle: single): single;
 protected
    function ParseKeyValue(Key, Value: string): Boolean; override;

    procedure TestScript1;
    procedure TestScript2;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear; virtual;
    function Add: TAnimationRowCollectionItem; virtual;

    function ZoomIn(a: single): single;
    function ZoomOut(a: single): single;
    function AngleLeft(a, b: single): single;
    function AngleRight(a, b: single): single;
    function AngleDiff(a: single): single;

    procedure RotateM(fmk: TFederMessageKind; s, i: single);
    procedure RotateP(fmk: TFederMessageKind; s, i: single);
    function XPlus(s, i: single): single;
    function YMinus(s, i: single): single;
    function YPlus(s, i: single): single;
    function XMinus(s, i: single): single;
    function ZPlus(s, i: single): single;
    function ZMinus(s, i: single): single;

    property NS: Integer write SetNS;
    property RX: single write SetRX;
    property RY: single write SetRY;
    property RZ: single write SetRZ;
    property RW: single write SetRW;
    property DU: Integer write SetDU;
    property IT: TInterpolationType write SetIT;
    property AT: TAnimationType write SetAT;
    property AR: Boolean write SetAR;
    property FC: Boolean write SetFC;

    property Color: Integer write SetColor;
    property Sample: Integer write SetSample;

    procedure MoveTo(fp: TFederParam; Value: single); overload;
    procedure MoveTo(fp: TFederParam; Value: Integer); overload;
    procedure MoveTo(p: Integer; Value: Integer); overload;

    procedure JumpTo(mk: TFederMessageKind; mv: Integer); overload;
    procedure JumpTo(mk, mv: Integer); overload;

    procedure Init;
    procedure InitSample;
    procedure LoadScriptSample;

    procedure X1;
    procedure Y1;
    procedure Z1;

    procedure XM;
    procedure XP;

    procedure YM;
    procedure YP;

    procedure ZM;
    procedure ZP;

    procedure TouchIn;
    procedure TouchOut;

    procedure A1;
    procedure A2;
    procedure A3;

    procedure WriteScript2(ML: TStrings);
    procedure WriteScript1(ML: TStrings);
    procedure ReadScript(ML: TStrings);
    procedure ReadTestScript;

    procedure Rotate(fmk: TFederMessageKind; s, i: single); overload;
    procedure Rotate(p: Integer; s, i: single); overload;
    procedure Rotate(p: Integer; t: Integer); overload;
    procedure Rotate(p: Integer; t: single); overload;
    procedure Rotate(fmk: TFederMessageKind; t: single); overload;

    property AutoReverse: Boolean read FAutoReverse write FAutoReverse;
    property UniformRotation: Boolean read FUniformRotation write FUniformRotation;
    property AddLine: TRecorderEvent read FAddLine write FAddLine;

    property Current: TAnimationRowCollectionItem read cr;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederScript }

procedure TFederScript.LoadScriptSample;
begin
  Clear;
  Main.LoadFromFederData;
  Main.AnimationPlayer.Speed := 1.0;
end;

constructor TFederScript.Create;
begin
  inherited;
  fd := Main.FederData;
  FAngleDiff := 180;
  FUniformRotation := True;
  FAddLine := AddLineFunction;
  VKL := TStringList.Create;
  InitKeys;
end;

destructor TFederScript.Destroy;
begin
  fd := nil;
  VKL.Free;
  inherited;
end;

procedure TFederScript.Init;
begin
  Clear;
end;

procedure TFederScript.SetAR(const Value: Boolean);
begin
  if (cr <> nil) then
    cr.AutoReverse := BoolInt[Value];
end;

procedure TFederScript.SetAT(const Value: TAnimationType);
begin
  if (cr <> nil) then
    cr.AnimationType := Integer(Value);
end;

procedure TFederScript.SetColor(const Value: Integer);
begin
  cr := Add;
  cr.Param := 0; // discrete value
  cr.StopValue := TFederUtils.GetMessageKindInt(fmkColor);
  cr.StartValue := Value;
end;

//procedure TFederScript.SetDirectTransition(const Value: Boolean);
//begin
//  FDirectTransition := Value;
//end;

procedure TFederScript.SetDU(const Value: Integer);
begin
  if (cr <> nil) then
    cr.Duration := Value;
end;

procedure TFederScript.SetFC(const Value: Boolean);
begin
  if (cr <> nil) then
    cr.FromCurrent := BoolInt[Value];
end;

//procedure TFederScript.SetFullTransition(const Value: Boolean);
//begin
//  FFullTransition := Value;
//end;

procedure TFederScript.SetIT(const Value: TInterpolationType);
begin
  if (cr <> nil) then
    cr.InterpolationType := Integer(Value);
end;

//procedure TFederScript.SetLongTransition(const Value: Boolean);
//begin
//  FLongTransition := Value;
//end;

procedure TFederScript.SetNS(const Value: Integer);
begin
  Clear;
  Sample := Value;
end;

procedure TFederScript.Rotate(fmk: TFederMessageKind; s, i: single);
var
  p: Integer;
begin
  case fmk of
    fmkRX: p := Integer(fprx);
    fmkRY: p := Integer(fpry);
    else
      p := Integer(fprz);
  end;
  Rotate(p, s, i);
end;

procedure TFederScript.Rotate(p: Integer; s, i: single);
var
  t: single;
  Stop1, Start2: Integer;
begin
  t := NormalizeAngle(s + i);
  if i < 0 then
  begin
    Stop1 := -180;
    Start2 := 180;
  end
  else
  begin
    Stop1 := 360;
    Start2 := 180;
  end;

  if t > s then
  begin
    cr := Add;
    cr.Param := p;
    cr.AutoReverse := 0;
    cr.FromCurrent := 0;
    cr.StartValue := Round(s);
    cr.StopValue := Stop1;
    IT := TInterpolationType.Linear;

    cr := Add;
    cr.Param := p;
    cr.AutoReverse := 0;
    cr.FromCurrent := 0;
    cr.StartValue := Start2;
    cr.StopValue := Round(t);
    IT := TInterpolationType.Linear;
  end
  else
  begin
    cr := Add;
    cr.Param := p;
    cr.StopValue := Round(t);
    IT := TInterpolationType.Cubic;
  end;
end;

procedure TFederScript.Rotate(p: Integer; t: single);
begin
  cr := Add;
  cr.Param := p;
  cr.StopValue := Round(t);
  IT := TInterpolationType.Cubic;
end;

procedure TFederScript.Rotate(p: Integer; t: Integer);
begin
  cr := Add;
  cr.Param := p;
  cr.StopValue := t;
  IT := TInterpolationType.Cubic;
end;

procedure TFederScript.Rotate(fmk: TFederMessageKind; t: single);
var
  p: Integer;
begin
  case fmk of
    fmkRX: p := Integer(fprx);
    fmkRY: p := Integer(fpry);
    else
      p := Integer(fprz);
  end;

  cr := Add;
  cr.Param := p;
  cr.StopValue := Round(t);
  IT := TInterpolationType.Cubic;
end;

procedure TFederScript.RotateM(fmk: TFederMessageKind; s, i: single);
var
  p: Integer;
  t: single;
begin
  case fmk of
    fmkRX: p := Integer(fprx);
    fmkRY: p := Integer(fpry);
    else
      p := Integer(fprz);
  end;

  t := AngleLeft(s, i);
  if t > s then
  begin
    cr := Add;
    cr.Param := p;
    cr.AutoReverse := 0;
    cr.FromCurrent := 0;
    cr.StartValue := Round(s);
    cr.StopValue := -180;
    IT := TInterpolationType.Linear;

    cr := Add;
    cr.Param := p;
    cr.AutoReverse := 0;
    cr.FromCurrent := 0;
    cr.StartValue := 180;
    cr.StopValue := Round(t);
    IT := TInterpolationType.Linear;
  end
  else
  begin
    cr := Add;
    cr.Param := p;
    cr.StopValue := Round(t);
    IT := TInterpolationType.Cubic;
  end;
end;

procedure TFederScript.RotateP(fmk: TFederMessageKind; s, i: single);
var
  p: Integer;
  t: single;
begin
  case fmk of
    fmkRX: p := Integer(fprx);
    fmkRY: p := Integer(fpry);
    else
      p := Integer(fprz);
  end;

  t := AngleRight(s, i);
  if t < s then
  begin
    cr := Add;
    cr.Param := p;
    cr.StopValue := 360;
    IT := TInterpolationType.Linear;

    cr := Add;
    cr.Param := p;
    cr.AutoReverse := 0;
    cr.FromCurrent := 0;
    cr.StartValue := 0;
    cr.StopValue := Round(t);
    IT := TInterpolationType.Linear;
  end
  else
  begin
    cr := Add;
    cr.Param := p;
    cr.StopValue := Round(t);
    IT := TInterpolationType.Cubic;
  end;
end;

procedure TFederScript.SetRX(const Value: single);
begin
  cr := Add;
  cr.Param := Integer(fprx); // Rotation.X
  cr.StopValue := Round(Value);
  IT := TInterpolationType.Cubic;
end;

procedure TFederScript.SetRY(const Value: single);
begin
  cr := Add;
  cr.Param := Integer(fpry); // Rotation.Y
  cr.StopValue := Round(Value);
  IT := TInterpolationType.Cubic;
end;

procedure TFederScript.SetRZ(const Value: single);
begin
  cr := Add;
  cr.Param := Integer(fprz); // Rotation.Z
  cr.StopValue := Round(Value);
  IT := TInterpolationType.Cubic;
end;

procedure TFederScript.SetRW(const Value: single);
begin
  cr := Add;
  cr.Param := Integer(fpcz); // Wheel
  cr.StopValue := Round(Value);
end;

procedure TFederScript.SetSample(const Value: Integer);
begin
  cr := Add;
  cr.Param := 0; //Discrete value
  cr.StopValue := TFederUtils.GetMessageKindInt(fmkSample);
  cr.StartValue := Value;
end;

procedure TFederScript.MoveTo(fp: TFederParam; Value: Integer);
begin
  cr := Add;
  cr.Param := TFederUtils.GetParamInt(fp);
  cr.StopValue := Value;
  cr.AutoReverse := 0;
end;

procedure TFederScript.MoveTo(p: Integer; Value: Integer);
begin
  cr := Add;
  cr.Param := p;
  cr.StopValue := Value;
  cr.AutoReverse := 0;
end;

procedure TFederScript.MoveTo(fp: TFederParam; Value: single);
begin
  cr := Add;
  cr.Param := TFederUtils.GetParamInt(fp);
  cr.StopValue := Round(Value);
  cr.AutoReverse := 0;
end;

procedure TFederScript.TestScript1;
begin
  Clear;

  cr := Add;
  cr.Param := Integer(fprx); // RotationAngle.X - (left mouse buttpon horizontal)
  cr.StopValue := 90;

  cr := Add;
  cr.Param := Integer(fpry); // RotationAngle.Y (left mouse button vertical)
  cr.StopValue := 45;

  cr := Add;
  cr.Param := Integer(fprz); // RotationAngle.Z (right mouse button horizontal)
  cr.StopValue := 30;

  cr := Add;
  cr.Param := Integer(fpcz); // Camera.Z (scroll wheel backwards)
  cr.StopValue := 3; // number of ticks - zoom out

  cr := Add;
  cr.Param := 0; // discrete value
  cr.StopValue := TFederUtils.GetMessageKindInt(fmkColor); // Color
  cr.StartValue := 2; // Blue

  cr := Add;
  cr.Param := 0; // discrete value
  cr.StopValue := TFederUtils.GetMessageKindInt(fmkSample); // Sample
  cr.StartValue := 6; // Sample 6

  cr := Add;
  cr.Param := 0; // discrete value
  cr.StopValue := TFederUtils.GetMessageKindInt(fmkColor); // 4 - Color
  cr.StartValue := 0; // White
end;

procedure TFederScript.TestScript2;
begin
  NS := 3;
  RY := 60;
  RW := 3;

  cr.AnimationType := Integer(TAnimationType.Out);
  cr.InterpolationType := Integer(TInterpolationType.Back);

  MoveTo(fpy3, 40);
  DU := 1;
  cr.AnimationType := Integer(TAnimationType.InOut);
  cr.InterpolationType := Integer(TInterpolationType.Quintic);

  MoveTo(fpy3, -65);
  DU := 2;
  cr.AnimationType := Integer(TAnimationType.Out);
  cr.InterpolationType := Integer(TInterpolationType.Linear);

  RY := 210;
  RX := 120;
  RY := 120;
  RX := 150;

  Color := 2;
  Color := 1;
end;

function TFederScript.AngleDiff(a: single): single;
begin
  result := AngleRight(a, 180);
end;

function TFederScript.AngleRight(a, b: single): single;
begin
  result := NormalizeAngle(a + b);
end;

function TFederScript.AngleLeft(a, b: single): single;
begin
  result := NormalizeAngle(a - b);
end;

function TFederScript.ZoomIn(a: single): single;
begin
  result := a - a/2;
end;

function TFederScript.ZoomOut(a: single): single;
begin
  result := a + a/2;
end;

procedure TFederScript.InitSample;
begin
  Main.SampleManager.LoadSample;
end;

procedure TFederScript.InitCurrent;
begin
  Main.Frame3D.SaveRotation(fd);
  Main.Frame3D.LoadRotation(fd);
end;

procedure TFederScript.XM;
begin
  InitCurrent;
  Clear;
  XMinus(fd.AngleX, 90);
  AR := False;
end;

function TFederScript.XMinus(s, i: single): single;
var
  t: single;
begin
  t := AngleLeft(s, i);
  if FUniformRotation then
    RotateM(fmkRX, s, i)
  else
    RX := t;
  if FAutoReverse then
    RX := s;
  result := t;
end;

procedure TFederScript.XP;
begin
  InitCurrent;
  Clear;
  XPlus(fd.AngleX, 90);
  AR := False;
end;

function TFederScript.XPlus(s, i: single): single;
var
  t: single;
begin
  t := AngleRight(s, i);
  if FUniformRotation then
    RotateP(fmkRX, s, i)
  else
    RX := t;
  if FAutoReverse then
    RX := s;
  result := t;
end;

procedure TFederScript.YM;
begin
  InitCurrent;
  Clear;
  YMinus(fd.AngleY, 90);
  AR := False;
end;

function TFederScript.YMinus(s, i: single): single;
var
  t: single;
begin
  t := AngleLeft(s, i);
  if FUniformRotation then
    RotateM(fmkRY, s, i)
  else
    RY := t;
  if FAutoReverse then
    RY := s;
  result := t;
end;

procedure TFederScript.YP;
begin
  InitCurrent;
  Clear;
  YPlus(fd.AngleY, 90);
  AR := False;
end;

function TFederScript.YPlus(s, i: single): single;
var
  t: single;
begin
  t := AngleRight(s, i);
  if FUniformRotation then
    RotateP(fmkRY, s, i)
  else
    RY := t;
  if FAutoReverse then
    RY := s;
  result := t;
end;

procedure TFederScript.X1;
begin
  InitCurrent;
  Clear;
  RX := AngleDiff(fd.AngleX);
  AR := False;
  if FAutoReverse then
    RX := fd.AngleX;
end;

procedure TFederScript.Y1;
begin
  InitCurrent;
  Clear;
  RY := AngleDiff(fd.AngleY);
  AR := False;
  if FAutoReverse then
    RY := fd.AngleY;
end;

procedure TFederScript.TouchOut;
begin
  InitCurrent;
  Clear;
  RW := ZoomOut(fd.PosZ);
  if FAutoReverse then
    RW := fd.PosZ;
end;

procedure TFederScript.TouchIn;
begin
  InitCurrent;
  Clear;
  RW := ZoomIn(fd.PosZ);
  if FAutoReverse then
    RW := fd.PosZ;
end;

procedure TFederScript.A1;
begin
  InitSample;
  Clear;
  RY := AngleDiff(fd.AngleY);
  RY := fd.AngleY;
  RX := AngleDiff(fd.AngleX);
  RX := fd.AngleX;
end;

procedure TFederScript.A2;
begin
  InitSample;
  Clear;
  RY := AngleDiff(fd.AngleY);
  RY := fd.AngleY;
  RX := AngleDiff(fd.AngleX);
  RX := fd.AngleX;
  RW := ZoomIn(fd.PosZ);
  RW := fd.PosZ;
  RW := ZoomOut(fd.PosZ);
  RW := fd.PosZ;
end;

procedure TFederScript.A3;
begin
  InitSample;
  NS := Main.Sample;
  RW := fd.PosZ + 10;
  RZ := AngleRight(fd.AngleZ, 30);
  RY := AngleRight(fd.AngleY, 30);
  RX := AngleRight(fd.AngleX, 30);
  RX := fd.AngleX;
  RY := fd.AngleY;
  RZ := fd.AngleZ;
  RW := fd.PosZ;
end;

procedure TFederScript.JumpTo(mk: TFederMessageKind; mv: Integer);
begin
  cr := Add;
  cr.Param := 0;
  cr.StopValue := TFederUtils.GetMessageKindInt(mk);
  cr.StartValue := mv;
end;

procedure TFederScript.JumpTo(mk, mv: Integer);
begin
  cr := Add;
  cr.Param := 0;
  cr.StopValue := mk;
  cr.StartValue := mv;
end;

procedure TFederScript.WriteScript1(ML: TStrings);
var
  cr: TAnimationRowCollectionItem;
  i: Integer;
  p, pstart, pstop: Integer;
  fp: TFederParam;
  fmk: TFederMessageKind;
  s: string;
begin
  ML.Add('  Collection.Clear;');
  Main.AnimationData.First;
  for i := 0 to Main.AnimationData.Count-1 do
  begin
    cr := Main.AnimationData.Next;
    if (cr = nil) then
      break;
    p := cr.Param;
    pstart := cr.StartValue;
    pstop := cr.StopValue;

    if p = 0 then
    begin
      fmk := TFederMessageKind(pstop);
      s := TFederUtils.GetMessageKindString(fmk);
      if GhostWritingOn then
        JumpTo(pstop, pstart);
      ML.Add(Format('  JumpTo(%d,%d); //%s', [pstop, pstart, s]));
    end

    else if p in [24..26] then
    begin
      if GhostWritingOn then
        Rotate(p, pstop);
      ML.Add(Format('  Rotate(%d,%d);', [p, pstop]));
    end

    else
    begin
      fp := TFederUtils.GetFederParam(p);
      s := TFederUtils.GetParamCaption(fp);
      if GhostWritingOn then
        MoveTo(fp, pstop);
      ML.Add(Format('  MoveTo(%d,%d); //Param %s', [p, pstop, s]));
    end;

  end;
end;

procedure TFederScript.ReadTestScript;
begin
  Clear;
  JumpTo(12, 3); // Sample
  MoveTo(5, 40); // Param l2
  JumpTo(1, 4); // Graph
  Rotate(24, 30);
end;

procedure TFederScript.WriteScript2(ML: TStrings);
var
  i: Integer;
  cr: TAnimationRowCollectionItem;
begin
  MLRef := ML;
  ML.BeginUpdate;
  //ML.Clear;
  if Assigned(AddLine) then
  begin
    if Main.AnimationData.Count > 0 then
    begin
      AddLine('NS', 0);
      Main.AnimationData.First;
      for i := 0 to Main.AnimationData.Count-1 do
      begin
        cr := Main.AnimationData.Next;
        if (cr = nil) then
          break;
        AddLine('NE', 0);
        AddLine('PA', cr.Param);

        if cr.StartValue <> StartValueDefault then
          AddLine('VA', cr.StartValue);
        if cr.StopValue <> StopValueDefault then
          AddLine('VE', cr.StopValue);
        if cr.Duration <> DurationDefault then
          AddLine('DU', cr.Duration);
        if cr.AutoReverse <> AutoReverseDefault then
          AddLine('AR', cr.AutoReverse);
        if cr.Loop <> LoopDefault then
          AddLine('LP', cr.Loop);
        if cr.FromCurrent <> FromCurrentDefault then
          AddLine('FC', cr.FromCurrent);
        if cr.AnimationType <> AnimationTypeDefault then
          AddLine('AT', cr.AnimationType);
        if cr.InterpolationType <> InterpolationTypeDefault then
          AddLine('IT', cr.InterpolationType);
      end;
      AddLine('GO', 0);
    end;
  end;
  ML.EndUpdate;
  MLRef := nil;
end;

procedure TFederScript.AddLineFunction(k: string; v: Integer);
begin
  if (MLRef <> nil) then
    MLRef.Add(k + '=' + IntToStr(v));
end;

procedure TFederScript.InitKeys;
begin
  VKL.Clear;
  VKL.Add('AR');
  VKL.Add('AT');
  VKL.Add('DU');
  VKL.Add('FC');
  VKL.Add('GO');
  VKL.Add('IT');
  VKL.Add('LP');
  VKL.Add('NS');
  VKL.Add('NE');
  VKL.Add('PA');
  VKL.Add('VA');
  VKL.Add('VE');
end;

function TFederScript.IsValidKey(s: string): Boolean;
begin
  result := VKL.IndexOf(s) >= 0;
end;

procedure TFederScript.ReadScript(ML: TStrings);
var
  i: Integer;
  s: string;
begin
  if (ML <> nil) then
  for i := 0 to ML.Count-1 do
  begin
    s := ML[i];
    if not ParseLine(s) then
    begin
      Clear;
      break;
    end;
  end;
end;

function TFederScript.ParseKeyValue(Key, Value: string): Boolean;
var
  V: Integer;
  fmk: TFederMessageKind;
  ad: TAnimationData;
begin
  result := True;
  V := StrToIntDef(Value, MaxInt);
  if V = MaxInt then
    Exit;

  if not IsValidKey(Key) then
    Exit;

  if Key = 'NS' then
    fmk := fmkAnimNewStory
  else if Key = 'NE' then
    fmk := fmkAnimNewEntry
  else if Key = 'PA' then
    fmk := fmkAnimParam
  else if Key = 'VA' then
    fmk := fmkAnimStartValue
  else if Key = 'VE' then
    fmk := fmkAnimStopValue
  else if Key = 'AT' then
    fmk := fmkAnimAT
  else if Key = 'IT' then
    fmk := fmkAnimIT
  else if Key = 'DU' then
    fmk := fmkAnimDU
  else if Key = 'AR' then
    fmk := fmkAnimAR
  else if Key = 'LP' then
    fmk := fmkAnimLP
  else if Key = 'FC' then
    fmk := fmkAnimFC
  else if Key = 'GO' then
    fmk := fmkAnimGO
  else
    fmk := fmkNoop;

  Main.AnimationPlayer.Stop;
  ad := Main.AnimationData;
  case fmk of
    fmkAnimNewStory: ad.Clear;
    fmkAnimNewEntry: ad.Add;

    fmkAnimParam: ad.EditParam(ad.CurrentRow, Value);
    fmkAnimStartValue: ad.EditStartValue(ad.CurrentRow, Value);
    fmkAnimStopValue: ad.EditStopValue(ad.CurrentRow, Value);

    fmkAnimAT: ad.EditAnimationType(ad.CurrentRow, Value);
    fmkAnimIT: ad.EditIterpolationType(ad.CurrentRow, Value);
    fmkAnimDU: ad.EditDuration(ad.CurrentRow, Value);
    fmkAnimAR: ad.EditAutoReverse(ad.CurrentRow, Value);
    fmkAnimLP: ad.EditLoop(ad.CurrentRow, Value);
    fmkAnimFC: ad.EditFromCurrent(ad.CurrentRow, Value);

    fmkAnimGO:
    begin
      //
    end;
  end;
end;

function TFederScript.NormalizeAngle(Angle: single): single;
begin
  result := Angle - Int(Angle / 360) * 360;
  if Result < -180 then
    Result := Result + 360;
end;

procedure TFederScript.Clear;
begin
  Main.AnimationData.Clear;
end;

function TFederScript.Add: TAnimationRowCollectionItem;
begin
  result := Main.AnimationData.Add;
end;

procedure TFederScript.ZM;
begin
  InitCurrent;
  Clear;
  ZMinus(fd.AngleZ, 90);
  AR := False;
end;

function TFederScript.ZMinus(s, i: single): single;
var
  t: single;
begin
  t := AngleLeft(s, i);
  if FUniformRotation then
    RotateM(fmkRZ, s, i)
  else
    RZ := t;
  if FAutoReverse then
    RZ := s;
  result := t;
end;

procedure TFederScript.ZP;
begin
  InitCurrent;
  Clear;
  ZPlus(fd.AngleZ, 90);
  AR := False;
end;

function TFederScript.ZPlus(s, i: single): single;
var
  t: single;
begin
  t := AngleRight(s, i);
  if FUniformRotation then
    RotateP(fmkRZ, s, i)
  else
    RZ := t;
  if FAutoReverse then
    RZ := s;
  result := t;
end;

procedure TFederScript.Z1;
begin
  InitCurrent;
  Clear;
  RZ := AngleDiff(fd.AngleZ);
  AR := False;
  if FAutoReverse then
    RZ := fd.AngleZ;
end;

{ TManualTransition }

procedure TManualTransition.Transit;
begin
  if not Main.AnimationPlayer.IsPlaying then
  begin
    Main.SavedParam := Main.Param;

    Main.FederModel.LoadFromFederData(fd1);
    Main.FederScript.Clear;

    { Parallel Move }
    fd1.ParallelAnimationValue := 1;
    fd2.ParallelAnimationValue := 1000;
    Main.ParallelAnimation.Init(fd1, fd2);
    Main.FederScript.MoveTo(fppa, fd2.ParallelAnimationValue);
    Main.FederScript.Current.Duration := Duration;

    if Main.AnimationData.Count > 0 then
      Main.AnimationPlayer.Calc;
  end
  else
    Main.AnimationPlayer.Stop;
end;

end.
