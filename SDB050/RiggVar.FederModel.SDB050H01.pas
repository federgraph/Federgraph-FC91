unit RiggVar.FederModel.SDB050H01;

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
  TSDB050H01 = class(TSampleHub)
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

{ TSDB050H01 }

procedure TSDB050H01.InitSample0(fd: TFederData);
var
  w3: single;
  a: Integer;
  h: single;
  ro: single;
  ri: single;
begin
  w3 := sqrt(3);
  a := 100;
  h := w3/2 * a;
  ro := w3/3 * a;
  ri := w3/6 * a;
  with fd do
  begin
Title := 'FCS1-1';
x1 := -ri;
x2 := -ri;
x3 := ro;
y1 := a / 2;
y2 := -a / 2;
y3 := 0;
l1 := h;
l2 := h;
l3 := h;
l4 := h;
//x1 := -28.8675136566162;
//x2 := -28.8675136566162;
//x3 := 57.7350273132324;
//y1 := 50;
//y2 := -50;
//y3 := 0;
Range := 10;
Plot := 4;
Figure := 1;
Param := 1;
Bitmap := 16;
AngleX := 180.00;
PosZ := 9.15;
T1 := -10;
T2 := 186;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 1;
ColorScheme2D := 1;
  end;
end;
{
procedure TSDB050H01.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-013';
x1 := -30;
x2 := 30;
y1 := 0;
y2 := 0;
l1 := 40;
l2 := 40;
l3 := 40;
l4 := 52;
k1 := 200;
k2 := 200;
k3 := 750;
k4 := 0;
Limit := 0;
Graph := 1;
Plot := 4;
Figure := 4;
Param := 3;
AngleX := 180.00;
PosZ := 8.09;
T2 := 14;
ParamBahnRadius := 50;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;
}
procedure TSDB050H01.InitSample1(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-014';
x1 := -96;
x2 := 96;
y1 := -96;
y2 := -96;
y3 := 96;
l1 := 182;
l2 := 182;
l3 := 182;
l4 := 182;
k1 := 10;
k2 := 10;
k3 := 10;
k4 := 0;
Limit := 0;
Range := 140;
Scene := 2;
Plot := 8;
Bitmap := 16;
AngleX := 180.00;
PosZ := 10.00;
T2 := 380;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;

{ ColorStripInfo }

BlindColorCount := 0;
StripWidth := 1;
BandWidth := 10;
StandardColor := 16;
WantContour := True;
WantShirtColor := False;
SquareBitmap := False;
HorizontalBitmap := False;
SquareSym := False;
RandomPaint := True;
StandardPaint := False;
MonoPaint := False;

Bands[0] := '001-000-000-000';
Bands[35] := '255-051-051-051';

//BandInfo 1 := Width-Red-Green-Blue;
Bands[1] := '010-198-050-177';
Bands[2] := '010-198-050-177';
Bands[3] := '010-205-242-172';
Bands[4] := '010-239-133-166';
Bands[5] := '010-044-079-152';
Bands[6] := '010-205-242-172';
Bands[7] := '010-029-009-037';
Bands[8] := '010-010-147-096';
Bands[9] := '010-037-136-226';
Bands[10] := '010-044-079-152';
Bands[11] := '010-135-050-187';
Bands[12] := '010-031-200-127';
Bands[13] := '010-003-028-231';
Bands[14] := '010-029-009-037';
Bands[15] := '010-179-013-065';
Bands[16] := '010-073-179-045';
Bands[17] := '010-141-015-235';

//BandInfo 2 := Width-Red-Green-Blue;
Bands[18] := '010-088-203-033';
Bands[19] := '030-255-000-000';
Bands[20] := '010-180-202-055';
Bands[21] := '010-064-240-130';
Bands[22] := '010-045-049-173';
Bands[23] := '010-075-044-076';
Bands[24] := '010-103-036-177';
Bands[25] := '010-062-142-083';
Bands[26] := '010-072-107-014';
Bands[27] := '010-253-054-166';
Bands[28] := '010-010-207-110';
Bands[29] := '010-097-015-221';
Bands[30] := '010-171-171-052';
Bands[31] := '010-046-210-133';
Bands[32] := '010-224-152-241';
Bands[33] := '010-080-059-220';
Bands[34] := '010-127-111-124';

  end;
end;

procedure TSDB050H01.InitSample2(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-019';
x1 := 3.88226246833801;
x2 := 34.3354606628418;
x3 := 4.02219009399414;
x4 := 11.5732507705688;
y1 := -106.183464050293;
y2 := -121.157577514648;
y3 := -144.714660644531;
y4 := -129.090774536133;
l1 := -20;
l2 := 40;
l3 := -130;
l4 := 31;
k1 := 19;
k2 := 0;
k3 := -14;
k4 := 4;
OffsetZ := 6;
Limit := 0;
Range := 217;
Graph := 4;
Plot := 4;
Param := 3;
Bitmap := 15;
AngleX := 180.00;
PosZ := 10.00;
T1 := 27;
T2 := 200;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 2;
  end;
end;

procedure TSDB050H01.InitSample3(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-020';
x1 := 63;
x2 := -63;
y1 := 63;
y2 := 63;
y3 := -63;
l1 := 94;
l2 := 94;
l3 := 94;
l4 := 94;
k1 := 10;
k2 := 10;
k3 := 10;
k4 := 0;
OffsetZ := -25;
Limit := 0;
Range := 146;
Graph := 1;
Plot := 6;
Figure := 2;
Bitmap := 21;
AngleX := 180.00;
PosZ := 10.00;
T2 := 90;
T4 := 21;
SolutionMode := False;
PlotFigure := 2;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H01.InitSample4(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-023';
x1 := 165;
x2 := -75;
x3 := 260;
y1 := 35;
y2 := 35;
y3 := -155;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Range := 170;
Plot := 11;
Param := 36;
Bitmap := 21;
AngleX := 180.00;
PosX := -3.30;
PosY := 3.10;
PosZ := 14.36;
T1 := 0;
T2 := 196;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H01.InitSample5(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-025';
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
PosZ := 10.00;
T1 := 1;
T2 := 196;
ForceMode := 3;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H01.InitSample6(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-026';
x1 := -64.9499969482422;
x2 := 64.9499969482422;
x3 := 6.55670828564325E-006;
y1 := -37.4999961853027;
y2 := -37.5000038146973;
y3 := 75;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
m1 := 2;
m2 := 2;
m3 := 1;
Range := 50;
Plot := 4;
Figure := 2;
Bitmap := 14;
AngleX := 180.00;
PosZ := 10.00;
T1 := 0;
T2 := 196;
ForceMode := 3;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H01.InitSample7(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-027';
x1 := 65;
x2 := -65;
y1 := 0;
y2 := 0;
y3 := -65;
y4 := 25;
z1 := 10;
z2 := 10;
z3 := 10;
z4 := 10;
l1 := 88;
l2 := 88;
l3 := 88;
l4 := 88;
Bigmap := True;
Gain := 21;
Range := 19;
Scene := 4;
Plot := 10;
Figure := 4;
Param := 22;
Bitmap := 18;
AngleX := 180.00;
PosZ := 8.42;
T1 := 27;
T2 := 22;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H01.InitSample8(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-028';
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
Bitmap := 17;
AngleX := 180.00;
PosZ := 10.00;
T1 := 0;
T2 := 37;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H01.InitSample9(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-030';
x1 := -30;
x2 := 30;
y1 := 0;
y2 := 0;
y3 := 30;
l1 := 30;
l2 := 30;
l3 := 30;
l4 := 30;
k1 := 10;
k2 := 0;
k3 := 10;
k4 := 30;
Limit := 0;
Bitmap := 17;
AngleX := 180.00;
PosZ := 10.00;
T1 := 1;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

end.
