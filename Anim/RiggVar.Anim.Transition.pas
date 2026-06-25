unit RiggVar.Anim.Transition;

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
  System.Classes,
  FMX.Types,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.Anim.Script,
  RiggVar.Anim.ParallelAnimation;

type
  TTransitionType = (
    ttDirect,
    ttParallel,
    ttOne
  );

  TSampleSource = (
    ssCurrentState,
    ssCurrentSample,
    ssTargetSample,
    ssNextSample,
    ssLocalSample
  );

  TSampleTransition = class
  private
    fd1: TFederData;
    fd2: TFederData;

    FWantFullShow: Boolean;
    FDuration: Integer;

    TargetSample3A: Integer;
    TargetSample3B: Integer;

    TargetSample4A: Integer;
//    TargetSample4B: Integer;

    FTargetSample: Integer;
    FTransitionType: TTransitionType;
    FStartSampleSource: TSampleSource;
    FEndSampleSource: TSampleSource;

    function GetCount: Integer;
    procedure SetDuration(const Value: Integer);

    procedure TransitionDirect;
    procedure TransitionParallel;
    procedure TransitionOne;

    procedure LoadSample(fd: TFederData; ID: Integer);
    procedure LoadSituation(fd: TFederData; ss: TSampleSource);

    function GetTargetSample(Scene: Integer): Integer;
    function CheckTargetSample(t: Integer): Integer;
  protected
    procedure InitSample1(fd: TFederData);
    procedure InitSample2(fd: TFederData);
    procedure InitSample3(fd: TFederData);
  public
    constructor Create;
    destructor Destroy; override;

    procedure HandleAction(fa: TFederAction);

    property Count: Integer read GetCount;
    property Duration: Integer read FDuration write SetDuration;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FederModel.Data;

{ TSampleTransition }

constructor TSampleTransition.Create;
begin
  fd1 := TFederData3.Create;
  fd2 := TFederData3.Create;

  FDuration := 8;

  FTransitionType := ttParallel;
  FStartSampleSource := ssCurrentSample;
  FEndSampleSource := ssTargetSample;

  TargetSample3A := 1;
  TargetSample3B := 2;

  TargetSample4A := 3;
//  TargetSample4B := 3;
end;

destructor TSampleTransition.Destroy;
begin
  fd1.Free;
  fd2.Free;
  inherited;
end;

procedure TSampleTransition.InitSample1(fd: TFederData);
begin
  with fd do
  begin
Title := 'Federgraph';
SubTitle := 'das Original';
Version := 2;
x1 := 64.95;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
MeshSize := 256;
Limit := 0;
Range := 40;
Plot := 10;
Figure := 2;
Param := 14;
Bitmap := 22;
AngleX := 180.00;
AngleY := -10.00;
PosY := 1;
PosZ := 9.15;
T1 := 11;
T2 := 200;
StandardColor := 17;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
Lux := False;
Lux1 := True;
Lux1X := -6;
Lux1Y := 1;
Lux1Z := -7;

OffsetY := -30;
CapValue := 60;
AbsoluteRange := 120;
PolarMesh := False;
PlusCap := False;
ReducedMesh := True;
T1 := 0;
T2 := 180;
  end;
end;

procedure TSampleTransition.InitSample2(fd: TFederData);
begin
  with fd do
  begin
Title := 'Sad-Face-2025';
SubTitle := 'in Zufallsfarben verfügbar';
Version := 2;
Version := 2;
x1 := 35;
x2 := -35;
y1 := 17.5;
y2 := 17.5;
y3 := -92;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
OffsetY := -32;
CapValue := 44;
AbsoluteRange := 120;
ReducedMesh := True;
Plot := 10;
Figure := 2;
Param := 29;
Bitmap := 12;
AngleX := 150.00;
AngleY := -10.00;
PosX := 0.80;
PosY := 0.80;
PosZ := 10.00;
T1 := 10;
T2 := 200;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;

{ ColorInfo }

BlindColorCount := 1;
StripWidth := 1;
BandWidth := 11;
StandardColor := 12;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := True;
StandardPaint := False;
MonoPaint := False;

//BandInfo := W-R-G-B;
Bands[0] := '001-000-000-000';
Bands[1] := '011-144-238-144';
Bands[2] := '011-205-133-063';
Bands[3] := '011-119-136-153';
Bands[4] := '011-255-160-122';
Bands[5] := '011-192-192-192';
Bands[6] := '011-211-211-211';
Bands[7] := '011-255-215-000';
Bands[8] := '011-148-000-211';
Bands[9] := '011-000-255-255';
Bands[10] := '011-250-128-114';
Bands[11] := '011-128-128-128';
Bands[12] := '011-248-248-255';
Bands[13] := '011-184-134-011';
Bands[14] := '011-065-105-225';
Bands[15] := '011-153-050-204';
Bands[16] := '011-128-128-000';
Bands[17] := '011-255-250-250';
Bands[18] := '011-000-128-000';
Bands[19] := '011-248-248-255';
Bands[20] := '011-127-255-000';
Bands[21] := '011-230-230-250';
Bands[22] := '011-178-034-034';
Bands[23] := '011-144-238-144';
Bands[24] := '011-250-128-114';
Bands[25] := '011-250-240-230';
Bands[26] := '011-219-112-147';
Bands[27] := '011-123-104-238';
Bands[28] := '011-075-000-130';
Bands[29] := '011-106-090-205';
Bands[30] := '011-147-112-219';
Bands[31] := '011-255-255-224';
Bands[32] := '011-000-000-255';
Bands[33] := '011-144-238-144';
Bands[34] := '011-253-245-230';
Bands[35] := '255-051-051-051';
  end;
end;

procedure TSampleTransition.InitSample3(fd: TFederData);
begin
  with fd do
  begin
Title := 'Der-Alte-03';
SubTitle := 'die flache Version';
// Sample 0-0-3 from FC91
// 24.05.2025 10:39:23
Version := 2;
x1 := 65;
x2 := -65;
y1 := 0;
y2 := 0;
y3 := -65;
y4 := -24;
z1 := 10;
z2 := 10;
z3 := 10;
z4 := 10;
l1 := 98;
l2 := 98;
l3 := 98;
l4 := 98;
OffsetY := -37;
Bigmap := True;
Gain := 325;
CapValue := 50;
AbsoluteRange := 110;
ReducedMesh := True;
PlusCap := True;
Scene := 4;
Plot := 10;
Figure := 2;
Param := 33;
Bitmap := 16;
AngleX := -170.39;
AngleY := -7.06;
AngleZ := 3.22;
PosX := -0.30;
PosY := 0.90;
PosZ := 10.10;
T1 := 20;
T2 := 37;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

function TSampleTransition.GetCount: Integer;
begin
  result := Main.SampleManager.SampleHub.Count;
end;

function TSampleTransition.CheckTargetSample(t: Integer): Integer;
begin
  result := 1;

  if t = TargetSample3A then
    result := TargetSample3B
  else if t = TargetSample3B then
    result := TargetSample3A;

//  if t = TargetSample4A then
//    result := TargetSample4B
//  else if t = TargetSample4B then
//    result := TargetSample4A;
end;

function TSampleTransition.GetTargetSample(Scene: Integer): Integer;
begin
  result := FTargetSample;
  case Scene of
    3: result := TargetSample3A;
    4: result := TargetSample4A;
  end;
end;

procedure TSampleTransition.SetDuration(const Value: Integer);
begin
  if Value > 1 then
    FDuration := Value
  else
    FDuration := 5;
end;

procedure TSampleTransition.LoadSample(fd: TFederData; ID: Integer);
begin
//  fd.T1 := 0;
//  fd.T2 := 0;
  Main.SampleManager.SampleHub.LoadSample(fd, ID);
end;

procedure TSampleTransition.TransitionOne;
var
  fs: TFederScript;
begin
  fs := Main.FederScript;

  { Reset Zoom and Angle }
  if fd1.PosZ <> 20 then
  begin
    fs.MoveTo(fpcz, 20);
    fd1.PosZ := 20;
  end;
  if fd1.AngleZ <> 0 then
  begin
    fs.Rotate(fmkRZ, 0);
    fd1.AngleZ := 0;
  end;
  if fd1.AngleY <> 0 then
  begin
    fs.Rotate(fmkRY, 0);
    fd1.AngleY := 0;
  end;
  if fd1.AngleX <> fd2.AngleX then
  begin
    fs.Rotate(fmkRX, 0);
    fd1.AngleX := 0;
  end;

  { Reset Offset }
  if fd1.OffsetX <> 0 then
  begin
    fs.MoveTo(fpox, 0);
    fd1.OffsetX := 0;
  end;
  if fd1.OffsetY <> 0 then
  begin
    fs.MoveTo(fpoy, 0);
    fd1.OffsetY := 0;
  end;
  if fd1.OffsetZ <> 0 then
  begin
    fs.MoveTo(fpoz, 0);
    fd1.OffsetZ := 0;
  end;

  if fd1.Graph <> 3 then
  begin
    fs.JumpTo(fmkGraph, 3);
    fd1.Graph := 3;
  end;

  if fd1.MinusCap <> False then
  begin
    fs.JumpTo(fmkMinusCap, 0);
    fd1.MinusCap := False;
  end;

  if fd1.PlusCap <> False then
  begin
    fs.JumpTo(fmkPlusCap, 0);
    fd1.PlusCap := False;
  end;

  if fd1.x1 <> fd2.x1 then
    fs.MoveTo(fpx1, fd2.x1);
  if fd1.x2 <> fd2.x2 then
    fs.MoveTo(fpx2, fd2.x2);
  if fd1.x3 <> fd2.x3 then
    fs.MoveTo(fpx3, fd2.x3);

  if fd1.y1 <> fd2.y1 then
    fs.MoveTo(fpy1, fd2.y1);
  if fd1.y2 <> fd2.y2 then
    fs.MoveTo(fpy2, fd2.y2);
  if fd1.y3 <> fd2.y3 then
    fs.MoveTo(fpy3, fd2.y3);

  if (fd2.l1 = fd2.l2) and (fd2.l2 = fd2.l3) then
  begin
    fs.MoveTo(fpl, fd2.l1);
  end
  else
  begin
    if fd1.l1 <> fd2.l1 then
      fs.MoveTo(fpl1, fd2.l1);
    if fd1.l2 <> fd2.l2 then
      fs.MoveTo(fpl2, fd2.l2);
    if fd1.l3 <> fd2.l3 then
      fs.MoveTo(fpl3, fd2.l3);
  end;

  if (fd2.k1 = fd2.k2) and (fd2.k2 = fd2.k3) then
  begin
    fs.MoveTo(fpk, fd2.k1);
  end
  else
  begin
    if fd1.k1 <> fd2.k1 then
      fs.MoveTo(fpk1, fd2.k1);
    if fd1.k2 <> fd2.k2 then
      fs.MoveTo(fpk2, fd2.k2);
    if fd1.k3 <> fd2.k3 then
      fs.MoveTo(fpk3, fd2.k3);
  end;

  if fd1.AngleX <> fd2.AngleX then
    fs.Rotate(fmkRX, fd2.AngleX);
  if fd1.AngleY <> fd2.AngleY then
    fs.Rotate(fmkRY, fd2.AngleY);
  if fd1.AngleZ <> fd2.AngleZ then
    fs.Rotate(fmkRZ, fd2.AngleZ);
  if fd1.PosZ <> fd2.PosZ then
    fs.MoveTo(fpcz, fd2.PosZ);

  if FWantFullShow then
  begin
    if fd1.OffsetX <> fd2.OffsetX then
      fs.MoveTo(fpox, fd2.OffsetX);
    if fd1.OffsetY <> fd2.OffsetY then
      fs.MoveTo(fpoy, fd2.OffsetY);
    if fd1.OffsetZ <> fd2.OffsetZ then
      fs.MoveTo(fpoz, fd2.OffsetZ);
    if fd1.Gain <> fd2.Gain then
      fs.MoveTo(fpAttenuation, fd2.Gain);
    if fd1.Limit <> fd2.Limit then
      fs.MoveTo(fpGrenze, fd2.Limit);
    if fd1.Range <> fd2.Range then
      fs.MoveTo(fpRange, fd2.Range);

    if fd1.Bitmap <> fd2.Bitmap then
      fs.JumpTo(fmkBitmap, fd2.Bitmap);
    if fd1.MeshSize <> fd2.MeshSize then
      fs.JumpTo(fmkMeshSize, fd2.MeshSize);
    if fd1.MinusCap <> fd2.MinusCap then
      fs.JumpTo(fmkMinusCap, BoolInt[fd2.MinusCap]);
    if fd1.PlusCap <> fd2.PlusCap then
      fs.JumpTo(fmkPlusCap, BoolInt[fd2.PlusCap]);
    if fd1.Graph <> fd2.Graph then
      fs.JumpTo(fmkGraph, fd2.Graph);
    if fd1.Bigmap <> fd2.Bigmap then
    begin
      //fs.JumpTo(fmkBigmap, BoolInt[fd2.Bigmap]);
      fs.MoveTo(fpt1, 35);
      if fd2.Bigmap then
        fs.MoveTo(fpt2, Main.FederModel.FT2 * 10)
      else
        fs.MoveTo(fpt2, Main.FederModel.FT2 / 10);
      fs.Current.Duration := 3;
      fs.Current.InterpolationType := fs.Current.ITNumber(TInterpolationType.Quartic);
    end;
    if fd1.Color <> fd2.Color then
      fs.JumpTo(fmkColor, fd2.Color);
  end;

  fs.JumpTo(fmkSample, FTargetSample);
end;

procedure TSampleTransition.TransitionParallel;
var
  fs: TFederScript;
begin
  fs := Main.FederScript;

//  if FWantReset then
//  begin

  { Reset Zoom and Angle }
//  if fd1.PosZ <> 20 then
//  begin
//    fs.MoveTo(fpcz, 20);
//    fd1.PosZ := 20;
//  end;
//  if fd1.AngleZ <> 0 then
//  begin
//    fs.Rotate(fmkRZ, 0);
//    fd1.AngleZ := 0;
//  end;
//  if fd1.AngleY <> 0 then
//  begin
//    fs.Rotate(fmkRY, 0);
//    fd1.AngleY := 0;
//  end;
//  if fd1.AngleX <> fd2.AngleX then
//  begin
//    fs.Rotate(fmkRX, 0);
//    fd1.AngleX := 0;
//  end;

  { Reset Offset }
//  if fd1.OffsetX <> 0 then
//  begin
//    fs.MoveTo(fpox, 0);
//    fd1.OffsetX := 0;
//  end;
//  if fd1.OffsetY <> 0 then
//  begin
//    fs.MoveTo(fpoy, 0);
//    fd1.OffsetY := 0;
//  end;
//  if fd1.OffsetZ <> 0 then
//  begin
//    fs.MoveTo(fpoz, 0);
//    fd1.OffsetZ := 0;
//  end;

//  if fd1.Graph <> 3 then
//  begin
//    fs.JumpTo(fmkGraph, 3);
//    fd1.Graph := 3;
//  end;

//  if fd1.MinusCap <> False then
//  begin
//    fs.JumpTo(fmkMinusCap, 0);
//    fd1.MinusCap := False;
//  end;

//  if fd1.PlusCap <> False then
//  begin
//    fs.JumpTo(fmkPlusCap, 0);
//    fd1.PlusCap := False;
//  end;

  { Parallel Move ! }
  fd1.ParallelAnimationValue := 0;
  fd2.ParallelAnimationValue := 1000;
  Main.ParallelAnimation.Init(fd1, fd2);
  fs.MoveTo(fppa, fd2.ParallelAnimationValue);
  fs.Current.Duration := 4;

//  if fd1.AngleX <> fd2.AngleX then
//    fs.Rotate(fmkRX, fd2.AngleX);
//  if fd1.AngleY <> fd2.AngleY then
//    fs.Rotate(fmkRY, fd2.AngleY);
//  if fd1.AngleZ <> fd2.AngleZ then
//    fs.Rotate(fmkRZ, fd2.AngleZ);
  if fd1.PosZ <> fd2.PosZ then
    fs.MoveTo(fpcz, fd2.PosZ);

//  if FWantFullShow then
//  begin
//    if fd1.Bitmap <> fd2.Bitmap then
//      fs.JumpTo(fmkBitmap, fd2.Bitmap);
//    if fd1.MeshSize <> fd2.MeshSize then
//      fs.JumpTo(fmkMeshSize, fd2.MeshSize);
//    if fd1.MinusCap <> fd2.MinusCap then
//      fs.JumpTo(fmkMinusCap, BoolInt[fd2.MinusCap]);
//    if fd1.PlusCap <> fd2.PlusCap then
//      fs.JumpTo(fmkPlusCap, BoolInt[fd2.PlusCap]);
//    if fd1.Graph <> fd2.Graph then
//      fs.JumpTo(fmkGraph, fd2.Graph);
//    if fd1.Color <> fd2.Color then
//      fs.JumpTo(fmkColor, fd2.Color);
//  end;

//  { Load the taget KeyFrame (Sample) }
//  fs.JumpTo(fmkSample, FTargetSample);
end;

procedure TSampleTransition.TransitionDirect;
var
  fs: TFederScript;
begin
  fs := Main.FederScript;

  { Parallel Move ! }
  fd1.ParallelAnimationValue := 0;
  fd2.ParallelAnimationValue := 1000;
  Main.ParallelAnimation.Init(fd1, fd2);
  fs.MoveTo(fppa, fd2.ParallelAnimationValue);
  fs.Current.Duration := FDuration;

  if fd1.AngleX <> fd2.AngleX then
    fs.Rotate(fmkRX, fd2.AngleX);
  if fd1.AngleY <> fd2.AngleY then
    fs.Rotate(fmkRY, fd2.AngleY);
  if fd1.AngleZ <> fd2.AngleZ then
    fs.Rotate(fmkRZ, fd2.AngleZ);
  if fd1.PosZ <> fd2.PosZ then
    fs.MoveTo(fpcz, fd2.PosZ);

  if FWantFullShow then
  begin
    if fd1.Bitmap <> fd2.Bitmap then
      fs.JumpTo(fmkBitmap, fd2.Bitmap);
    if fd1.MeshSize <> fd2.MeshSize then
      fs.JumpTo(fmkMeshSize, fd2.MeshSize);
    if fd1.MinusCap <> fd2.MinusCap then
      fs.JumpTo(fmkMinusCap, BoolInt[fd2.MinusCap]);
    if fd1.PlusCap <> fd2.PlusCap then
      fs.JumpTo(fmkPlusCap, BoolInt[fd2.PlusCap]);
    if fd1.Graph <> fd2.Graph then
      fs.JumpTo(fmkGraph, fd2.Graph);
    if fd1.Color <> fd2.Color then
      fs.JumpTo(fmkColor, fd2.Color);
  end;

  { Load the taget KeyFrame (Sample) }
  fs.JumpTo(fmkSample, FTargetSample);
end;

procedure TSampleTransition.HandleAction(fa: TFederAction);
begin
  if Main.AnimationPlayer.IsPlaying then
  begin
    Main.AnimationPlayer.Stop;
  end;

  if Main.AnimationPlayer.Playing then
  begin
    Exit;
  end;

  Main.FederScript.Clear;

  case fa of

    faAnimationStartF:
    begin
      FWantFullShow := True;
      FTransitionType := ttParallel;
      FStartSampleSource := ssCurrentState;
      FEndSampleSource := ssCurrentSample;
    end;

    faAnimationStartT:
    begin
      FWantFullShow := True;
      FTransitionType := ttParallel;
      FStartSampleSource := ssCurrentSample;
      FEndSampleSource := ssTargetSample;
    end;

    faAnimationStartD:
    begin
      FWantFullShow := False;
      FTransitionType := ttDirect;
      FStartSampleSource := ssCurrentSample;
      FEndSampleSource := ssTargetSample;
    end;

    faAnimationStartS:
    begin
      FWantFullShow := True;
      FTransitionType := ttOne;
      FStartSampleSource := ssCurrentSample;
      FEndSampleSource := ssNextSample;
    end;

    else
      Exit;
  end;

  LoadSituation(fd1, FStartSampleSource);
  LoadSituation(fd2, FEndSampleSource);

  case FTransitionType of
    ttDirect: TransitionDirect;
    ttParallel: TransitionParallel;
    ttOne: TransitionOne;
  end;

  if Main.AnimationData.Count > 0 then
    Main.AnimationPlayer.Calc;
end;

procedure TSampleTransition.LoadSituation(fd: TFederData; ss: TSampleSource);
var
  t: Integer;
begin
  t := Main.SampleManager.Sample;

  case ss of
    ssCurrentState:
    begin
      Main.UpdateData;
      fd.Assign(Main.FederData);
    end;

    ssCurrentSample:
    begin
      LoadSample(fd, t);
    end;

    ssTargetSample:
    begin
      FTargetSample := GetTargetSample(fd1.Scene);
      FTargetSample := CheckTargetSample(t);
      LoadSample(fd, FTargetSample);
    end;

    ssNextSample:
    begin
      FTargetSample := t + 1;
      if t >= Count then
        t := 1;
      LoadSample(fd, t);
    end;

    ssLocalSample:
    begin
      if fd1.Scene = 3 then
        InitSample1(fd)
      else if fd1.Scene = 4 then
        InitSample3(fd)
    end;

  end;
end;

end.
