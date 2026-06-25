unit RiggVar.FederModel.SDB010H00;

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
  RiggVar.FB.Data,
  RiggVar.FB.Hub;

type
  TSDB010H00 = class(TSampleHub)
  protected
    procedure InitSample0(fd: TFederData); override;
    procedure InitSample1(fd: TFederData); override;
    procedure InitSample2(fd: TFederData); override;
    procedure InitSample3(fd: TFederData); override;
    procedure InitSample4(fd: TFederData); override;
    procedure InitSample5(fd: TFederData); override;
    procedure InitSample6(fd: TFederData); override;
    procedure InitSample7(fd: TFederData); override;
    procedure InitSample8(fd: TFederData); override;
    procedure InitSample9(fd: TFederData); override;
  end;

implementation

{ TSDB010H00 }

procedure TSDB010H00.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'Equilateral-Arrangement';
SubTitle := 'für Experimente';
Version := 2;
x1 := -50;
x2 := 50;
y1 := -25;
y2 := -25;
y3 := 62;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
k4 := 0;
Bigmap := True;
Gain := 20;
CapValue := 100;
AbsoluteRange := 166;
ReducedMesh := True;
PlusCap := True;
Plot := 4;
Figure := 1;
Param := 32;
Bitmap := 15;
AngleX := 180.00;
PosZ := 6.93;
T1 := 44;
T2 := 13;
SolutionMode := False;
Gleich := True;
LinearForce := False;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

procedure TSDB010H00.InitSample1(fd: TFederData);
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
Bitmap := 17;
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
Lux := True;
Lux1 := True;
Lux2 := False;
Lux3 := True;
Lux4 := False;

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

procedure TSDB010H00.InitSample2(fd: TFederData);
begin
  with fd do
  begin
Title := 'Sad-Face-2025';
SubTitle := 'in Zufallsfarben verfügbar';
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

procedure TSDB010H00.InitSample3(fd: TFederData);
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

//Title := 'Hand-Detail';
//Version := 2;
//x1 := -0.11;
//x2 := -2.9E002;
//x3 := -1.4E002;
//x4 := -2.2E002;
//y1 := 0.5;
//y2 := 0.5;
//y3 := -2.5E002;
//y4 := -1E002;
//l1 := 1.9E002;
//l2 := 1.9E002;
//l3 := 1.9E002;
//l4 := 1.9E002;
//k1 := 3;
//k2 := 3;
//k3 := 3;
//k4 := 3;
//Gain := 83;
//CapValue := 63;
//AbsoluteRange := 234;
//ReducedMesh := True;
//PlusCap := True;
//Plot := 10;
//Figure := 2;
//Param := 32;
//Bitmap := 10;
//AngleX := 118.51;
//AngleY := 11.05;
//AngleZ := 178.53;
//PosZ := 4.21;
//T1 := 50;
//T2 := 85;
//ShowCylinder := False;
//ShowDiameter := False;
  end;
end;

procedure TSDB010H00.InitSample4(fd: TFederData);
begin
  with fd do
  begin
Title := 'Still-Happy';
SubTitle := 'ein einarmiger Bandit';
Version := 2;
x1 := 66;
x2 := -66;
x4 := 10;
y1 := 40;
y2 := 58;
y3 := -75;
z1 := 8;
z2 := 70;
z3 := 8;
z4 := 8;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
OffsetY := -30;
CapValue := 88;
AbsoluteRange := 120;
ReducedMesh := True;
PlusCap := True;
Plot := 10;
Figure := 2;
Param := 119;
Bitmap := 20;
AngleX := -155.76;
AngleY := -4.16;
AngleZ := 1.77;
PosZ := 10.44;
T1 := 69;
T2 := 203;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

procedure TSDB010H00.InitSample5(fd: TFederData);
begin
  with fd do
  begin
Title := 'Schlange-Rund';
SubTitle := 'Ansichtsexemplar';
Version := 2;
x1 := 65;
x2 := -65;
y1 := 38;
y2 := 38;
y3 := -75;
z1 := 20;
z2 := 20;
z3 := 40;
z4 := 20;
l1 := 2E002;
l2 := 2E002;
l3 := 2E002;
l4 := 2E002;
OffsetY := 85;
CapValue := 115;
AbsoluteRange := 100;
ReducedMesh := True;
PlusCap := True;
Plot := 10;
Figure := 2;
Param := 25;
Bitmap := 19;
Color := 5;
AngleX := -153.89;
AngleY := -2.63;
AngleZ := 9.83;
PosX := -0.40;
PosY := -2.00;
PosZ := 8.81;
T1 := 10;
T2 := 170;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

procedure TSDB010H00.InitSample6(fd: TFederData);
begin
  with fd do
  begin
Title := 'Ostdeutsche-Friedenstaube';
SubTitle := 'glühende Ausführung';
// Sample 0-0-6 from FC91
// 24.05.2025 18:01:32
Version := 2;
x1 := -40;
x2 := 40;
y1 := -30;
y2 := -30;
y3 := 20;
l1 := 30;
l2 := 30;
l3 := 30;
l4 := 30;
Gain := 16;
CapValue := 33;
AbsoluteRange := 80;
ReducedMesh := True;
PlusCap := True;
Plot := 7;
Figure := 1;
Bitmap := 12;
AngleX := 175.03;
AngleY := 11.06;
AngleZ := 174.79;
PosX := -0.11;
PosY := -0.71;
PosZ := 9.15;
T1 := 7;
T2 := 196;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
Lux := True;
Lux1 := True;
Lux1Z := -10;

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
Bands[0] := '001-000-000-080';
Bands[1] := '011-030-144-255';
Bands[2] := '011-255-250-240';
Bands[3] := '011-127-255-212';
Bands[4] := '011-224-255-255';
Bands[5] := '011-253-245-230';
Bands[6] := '011-255-228-225';
Bands[7] := '011-255-250-250';
Bands[8] := '011-255-105-180';
Bands[9] := '011-255-245-238';
Bands[10] := '011-000-000-128';
Bands[11] := '011-100-149-237';
Bands[12] := '011-000-255-255';
Bands[13] := '011-250-128-114';
Bands[14] := '011-238-232-170';
Bands[15] := '011-240-128-128';
Bands[16] := '011-211-211-211';
Bands[17] := '011-218-112-214';
Bands[18] := '011-255-000-000';
Bands[19] := '011-000-128-128';
Bands[20] := '011-127-255-212';
Bands[21] := '011-160-082-045';
Bands[22] := '011-255-250-240';
Bands[23] := '011-173-216-230';
Bands[24] := '011-184-134-011';
Bands[25] := '011-255-000-255';
Bands[26] := '011-000-128-128';
Bands[27] := '011-072-209-204';
Bands[28] := '011-138-043-226';
Bands[29] := '011-112-128-144';
Bands[30] := '011-000-000-205';
Bands[31] := '011-030-144-255';
Bands[32] := '011-255-255-224';
Bands[33] := '011-128-128-000';
Bands[34] := '011-128-128-000';
Bands[35] := '255-051-051-051';
  end;
end;

procedure TSDB010H00.InitSample7(fd: TFederData);
begin
  with fd do
  begin
Title := 'Birne-09';
SubTitle := 'sehr einsam';
Version := 2;
x1 := 65;
x2 := -65;
y1 := 33;
y2 := 33;
y3 := 230;
z1 := 190;
z2 := 190;
z3 := 190;
z4 := 190;
l1 := 280;
l2 := 280;
l3 := 280;
l4 := 280;
OffsetY := 53;
Gain := 34;
CapValue := 135;
AbsoluteRange := 211;
ReducedMesh := True;
PlusCap := True;
Plot := 10;
Figure := 2;
Param := 33;
Bitmap := 14;
AngleX := 153.06;
AngleY := 10.28;
AngleZ := -171.28;
PosX := -1.30;
PosY := -0.30;
PosZ := 14.75;
T1 := 44;
T2 := 648;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

procedure TSDB010H00.InitSample8(fd: TFederData);
begin
  with fd do
  begin
Title := 'Musterschüler-02';
SubTitle := 'hört gut';
Version := 2;
x1 := 65;
x2 := -65;
y1 := 38;
y2 := 38;
y3 := 270;
l1 := 210;
l2 := 210;
l3 := 100;
l4 := 210;
OffsetY := 15;
Gain := 13;
CapValue := 55;
AbsoluteRange := 165;
ReducedMesh := True;
PlusCap := True;
Plot := 10;
Figure := 2;
Param := 25;
Bitmap := 19;
AngleX := -151.04;
AngleY := -13.81;
AngleZ := 13.86;
PosX := 0.10;
PosY := -1.70;
PosZ := 15.96;
T1 := 9;
T2 := 190;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

procedure TSDB010H00.InitSample9(fd: TFederData);
begin
  with fd do
  begin
Title := 'Godzilla-Variante';
SubTitle := 'hier ganz harmlos';
Version := 2;
x1 := 65;
x2 := -65;
y1 := 38;
y2 := 38;
y3 := -75;
z1 := -11;
z2 := -11;
z3 := -11;
z4 := -11;
l1 := 220;
l2 := 220;
l3 := 220;
l4 := 220;
OffsetY := 44;
MinusCap := True;
AbsoluteRange := 65;
ReducedMesh := True;
PlusCap := True;
Plot := 10;
Figure := 2;
Param := 30;
Bitmap := 14;
AngleX := -166.68;
AngleY := -25.53;
AngleZ := -1.69;
PosX := 0.30;
PosY := -1.50;
PosZ := 6.96;
T1 := 7;
T2 := 126;
LinearForce := False;
PolarMesh := False;
ShowCylinder := False;
ShowDiameter := False;
  end;
end;

end.
