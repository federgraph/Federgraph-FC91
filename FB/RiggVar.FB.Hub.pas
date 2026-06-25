unit RiggVar.FB.Hub;

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
  RiggVar.FB.Data;

type
  TSampleHub = class
  private
    FCount: Integer;
  protected
    procedure InitSample0(fd: TFederData); virtual;
    procedure InitSample1(fd: TFederData); virtual;
    procedure InitSample2(fd: TFederData); virtual;
    procedure InitSample3(fd: TFederData); virtual;
    procedure InitSample4(fd: TFederData); virtual;
    procedure InitSample5(fd: TFederData); virtual;
    procedure InitSample6(fd: TFederData); virtual;
    procedure InitSample7(fd: TFederData); virtual;
    procedure InitSample8(fd: TFederData); virtual;
    procedure InitSample9(fd: TFederData); virtual;
  public
    constructor Create;
    procedure UpdateSample(fd: TFederData);
    procedure LoadSample(fd: TFederData; ID: Integer);
    procedure LoadScript(ID: Integer);
    function GetCount: Integer;
    property Count: Integer read GetCount;
  end;

implementation

uses
  RiggVar.App.Main;

{ TSampleHub }

constructor TSampleHub.Create;
begin
  FCount := 10;
end;

function TSampleHub.GetCount: Integer;
begin
  result := FCount;
end;

procedure TSampleHub.LoadSample(fd: TFederData; ID: Integer);
var
  DefaultAbsoluteRange: single;
  DefaultCapValue: single;
begin
  fd.Version := 0; //Read old code by default (if no version info)
  fd.ResetCodeFlags;
  fd.DefaultSlot := False;
  fd.InitDefault;
  DefaultAbsoluteRange := fd.AbsoluteRange;
  DefaultCapValue := fd.CapValue;
  case ID of
    0: InitSample0(fd);
    1: InitSample1(fd);
    2: InitSample2(fd);
    3: InitSample3(fd);
    4: InitSample4(fd);
    5: InitSample5(fd);
    6: InitSample6(fd);
    7: InitSample7(fd);
    8: InitSample8(fd);
    9: InitSample9(fd);
    10: InitSample0(fd);
  end;

  if fd.AbsoluteRange = DefaultAbsoluteRange then
    fd.InitAbsoluteRangeFromRange
  else
    fd.InitRangeFromAbsoluteRange;

  if fd.CapValue = DefaultCapValue then
    fd.InitCapValueFromLimit
  else
    fd.InitLimitFromCapValue;
end;

{ TSampleHub }

procedure TSampleHub.InitSample0(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-000';
x1 := 0;
x2 := 0;
x4 := 18.7858028411865;
y1 := 0;
y2 := 0;
y3 := 0;
y4 := 81.8506546020508;
l1 := -10;
l2 := -10;
l3 := -10;
l4 := -10;
k1 := 15;
k2 := 15;
k3 := 15;
k4 := 15;
OffsetY := 11;
MinusCap := True;
Gain := 38;
Graph := 1;
Plot := 11;
Figure := 2;
Bitmap := 14;
AngleX := 180.00;
PosZ := 2.80;
T3 := 3;
SolutionMode := False;
  end;
end;

procedure TSampleHub.InitSample1(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-001';
x1 := 64.95;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Limit := 0;
Range := 50;
Plot := 10;
Figure := 2;
Param := 14;
Bitmap := 17;
AngleX := 180.00;
PosZ := 10.49;
T1 := 1;
T2 := 150;
ColorScheme3D := 4;

CapValue := 64;
PolarMesh := False;
PlusCap := False;
  end;
end;

procedure TSampleHub.InitSample2(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-002';
x1 := 64.95;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 211;
l2 := 211;
l3 := 211;
l4 := 211;
Range := 50;
Plot := 10;
Figure := 2;
Param := 17;
Bitmap := 21;
AngleX := 180.00;
PosX := -0.24;
PosY := -1.40;
PosZ := 6.83;
T1 := 1;
T2 := 187;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSampleHub.InitSample3(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-003';
x1 := 0;
x2 := 0;
y1 := 0;
y2 := 0;
y3 := 0;
l1 := 350;
l2 := 350;
l3 := 350;
l4 := 350;
Bigmap := True;
Range := 175;
Plot := 7;
Bitmap := 2;
PosZ := 97.22;
T2 := 500;
  end;
end;

procedure TSampleHub.InitSample4(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-004';
x1 := 64.95;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 148;
l2 := 148;
l3 := 148;
l4 := 148;
Bigmap := True;
Range := 43;
Plot := 2;
Bitmap := 2;
AngleX := 180.00;
PosZ := 15.65;
T2 := 22;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

procedure TSampleHub.InitSample5(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-005';
x1 := -14;
x2 := 14;
y1 := -14;
y2 := -14;
y3 := 14;
l1 := 64;
l2 := 64;
l3 := 64;
l4 := 64;
k1 := 0;
k2 := 50;
k3 := -50;
k4 := 0;
Limit := 0;
Range := -15;
Graph := 5;
Plot := 8;
Bitmap := 2;
AngleX := 180.00;
PosZ := 12.79;
T2 := 200;
  end;
end;

procedure TSampleHub.InitSample6(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-006';
x1 := -14;
x2 := 14;
y1 := -14;
y2 := -14;
y3 := 14;
l1 := 44;
l2 := 44;
l3 := 44;
l4 := 44;
k1 := 0;
k2 := 50;
k3 := -50;
k4 := 0;
Limit := 0;
Range := -15;
Graph := 5;
Plot := 6;
Figure := 2;
Bitmap := 14;
AngleX := 180.00;
PosZ := 13.40;
T2 := 200;
  end;
end;

procedure TSampleHub.InitSample7(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-007';
x1 := 4.85676288604736;
x2 := -153.283248901367;
x3 := 153.286499023438;
y1 := 185.412139892578;
y2 := -88.4943618774414;
y3 := -88.5000076293945;
z1 := 110;
l1 := 270;
l2 := 270;
l3 := 270;
l4 := 270;
k4 := 0;
Limit := 0;
Range := 128;
Plot := 4;
Figure := 2;
Bitmap := 17;
AngleX := 180.00;
PosZ := 27.62;
T1 := 15;
T2 := 130;
  end;
end;

procedure TSampleHub.InitSample8(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-008';
x1 := 65;
x2 := -65;
y1 := 0;
y2 := 0;
y3 := -65;
y4 := 65;
z1 := 10;
z2 := 10;
z3 := 10;
z4 := 10;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Bigmap := True;
Gain := 21;
Range := 19;
Scene := 4;
Plot := 10;
Figure := 4;
Param := 17;
Bitmap := 12;
AngleX := 180.00;
PosZ := 10.00;
T2 := 37;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;

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

{ BandInfo := Width-Red-Green-Blue; }
Bands[0] := '001-000-000-000';
Bands[1] := '011-034-139-034';
Bands[2] := '011-255-099-071';
Bands[3] := '011-173-216-230';
Bands[4] := '011-238-232-170';
Bands[5] := '011-000-255-255';
Bands[6] := '011-245-245-220';
Bands[7] := '011-255-165-000';
Bands[8] := '011-186-085-211';
Bands[9] := '011-216-191-216';
Bands[10] := '011-176-196-222';
Bands[11] := '011-105-105-105';
Bands[12] := '011-205-133-063';
Bands[13] := '011-255-000-255';
Bands[14] := '011-205-133-063';
Bands[15] := '011-128-128-000';
Bands[16] := '011-075-000-130';
Bands[17] := '011-233-150-122';
Bands[18] := '011-250-240-230';
Bands[19] := '011-230-230-250';
Bands[20] := '011-255-255-000';
Bands[21] := '011-248-248-255';
Bands[22] := '011-176-224-230';
Bands[23] := '011-085-107-047';
Bands[24] := '011-248-248-255';
Bands[25] := '011-173-255-047';
Bands[26] := '011-000-250-154';
Bands[27] := '011-255-245-238';
Bands[28] := '011-128-128-128';
Bands[29] := '011-255-228-181';
Bands[30] := '011-072-061-139';
Bands[31] := '011-255-245-238';
Bands[32] := '011-105-105-105';
Bands[33] := '011-143-188-143';
Bands[34] := '011-255-020-147';
Bands[35] := '255-051-051-051';
  end;
end;

procedure TSampleHub.InitSample9(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Sample-009';
x1 := 64.9509506225586;
x2 := 0.000957755721174181;
x3 := -64.9519119262695;
y1 := -37.4983520507813;
y2 := 74.9983520507813;
y3 := -37.4999961853027;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
m1 := 2;
m3 := 2;
Range := 90;
Plot := 4;
Figure := 2;
Bitmap := 8;
AngleX := 180.00;
T1 := 1;
T2 := 196;
ForceMode := 3;
  end;
end;

procedure TSampleHub.LoadScript(ID: Integer);
begin
  { not implemented }
end;

procedure TSampleHub.UpdateSample(fd: TFederData);
begin
  { not implemented }
end;

end.
