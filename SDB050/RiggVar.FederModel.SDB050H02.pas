unit RiggVar.FederModel.SDB050H02;

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
  TSDB050H02 = class(TSampleHub)
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

{ TSDB050H02 }

procedure TSDB050H02.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'FCS1-2';
x1 := 50;
x2 := 0;
y1 := 50;
y2 := 0;
y3 := 0;
l1 := 80;
l2 := 80;
l3 := 80;
l4 := 80;
k2 := 0;
k3 := 0;
k4 := 0;
Pin := True;
Gain := 6;
Range := -11;
Dim := 6;
Scene := 5;
Plot := 4;
Figure := 2;
Bitmap := 16;
AngleX := 180.00;
T1 := -45;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;
{
procedure TSDB050H02.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-031';
x1 := -40;
x2 := 40;
y1 := -30;
y2 := -30;
y3 := 20;
l1 := 30;
l2 := 30;
l3 := 30;
l4 := 0;
Gain := 16;
Plot := 7;
Figure := 1;
Bitmap := 15;
AngleX := 180.00;
PosX := -0.11;
PosY := -0.71;
PosZ := 9.15;
T1 := 7;
T2 := 196;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 3;
  end;
end;
}
procedure TSDB050H02.InitSample1(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-039';
x1 := -26;
x2 := 66;
x3 := 20;
x4 := 20;
y1 := -46;
y2 := -46;
y3 := 46;
l1 := 40;
l2 := 40;
l3 := 40;
l4 := 40;
k1 := 50;
k2 := 0;
k3 := -50;
k4 := 0;
Limit := 0;
Range := -30;
Graph := 4;
Plot := 4;
Param := 23;
Bitmap := 18;
AngleX := 180.00;
PosZ := 7.74;
T1 := -10;
T2 := 30;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H02.InitSample2(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-040';
x1 := -40;
x2 := 40;
y1 := -40;
y2 := -40;
y3 := 40;
l1 := 60;
l2 := 60;
l3 := 60;
l4 := 60;
k1 := 20;
k2 := 20;
k3 := 20;
k4 := 20;
Limit := 0;
Range := 20;
Graph := 1;
Plot := 11;
Param := 21;
Bitmap := 17;
AngleX := 180.00;
PosZ := 9.57;
T1 := -8;
T2 := 200;
SolutionMode := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H02.InitSample3(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-041';
x1 := -30;
x2 := 30;
y1 := 0;
y2 := 0;
y3 := 0;
l1 := 60;
l2 := 60;
l3 := 60;
l4 := 60;
k1 := 10;
k2 := 10;
k3 := 10;
k4 := 10;
Limit := 0;
Range := 20;
Scene := 2;
Graph := 1;
Plot := 11;
Param := 21;
Bitmap := 17;
AngleX := 180.00;
PosZ := 8.00;
T2 := 200;
SolutionMode := False;
Gleich := True;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H02.InitSample4(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-048';
x1 := 65;
x2 := -65;
y1 := 20;
y2 := 20;
y3 := -45;
y4 := -4;
z1 := 10;
z2 := 10;
z3 := 10;
z4 := 10;
l1 := 125;
l2 := 125;
l3 := 125;
l4 := 125;
Bigmap := True;
Gain := 21;
Range := 139;
Scene := 4;
Plot := 11;
Bitmap := 14;
AngleX := 180.00;
PosZ := 10.00;
T1 := 12;
T2 := 21;
SolutionMode := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 2;
  end;
end;

procedure TSDB050H02.InitSample5(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-049';
x1 := 65;
x2 := -65;
y1 := 30;
y2 := 30;
y3 := -35;
y4 := 6;
z1 := 10;
z2 := 10;
z3 := 10;
z4 := 10;
l1 := 125;
l2 := 125;
l3 := 125;
l4 := 125;
Bigmap := True;
Gain := 21;
Range := 139;
Scene := 4;
Plot := 11;
Bitmap := 11;
AngleX := 180.00;
PosZ := 10.00;
T1 := 13;
T2 := 21;
SolutionMode := False;
LinearForce := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 2;
  end;
end;

procedure TSDB050H02.InitSample6(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-056';
x1 := -11;
x2 := 11;
y3 := 37;
y4 := -8;
z1 := 10;
z2 := 10;
z3 := 10;
z4 := 10;
l1 := 91;
l2 := 91;
l3 := 91;
l4 := 91;
Bigmap := True;
Gain := 41;
Range := 6;
Scene := 4;
Plot := 11;
Figure := 2;
Param := 22;
Bitmap := 11;
AngleX := 180.00;
PosZ := 10.00;
T1 := 32;
T2 := 21;
SolutionMode := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 2;
  end;
end;

procedure TSDB050H02.InitSample7(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-057';
x1 := -11;
x2 := 11;
y1 := -11;
y2 := -11;
y3 := 36;
y4 := -9;
z1 := 10;
z2 := 10;
z3 := 10;
z4 := 10;
l1 := 99;
l2 := 99;
l3 := 99;
l4 := 99;
Bigmap := True;
Gain := 41;
Range := 1;
Scene := 4;
Plot := 5;
Figure := 2;
Param := 22;
Bitmap := 18;
AngleX := 180.00;
PosZ := 10.00;
T1 := 19;
T2 := 21;
SolutionMode := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 1;
  end;
end;

procedure TSDB050H02.InitSample8(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-060';
x1 := -0.00219121645204723;
x2 := 122.977806091309;
x3 := -122.975616455078;
y1 := -142.003814697266;
y2 := 71.0038146972656;
y3 := 70.9999923706055;
z1 := -179;
z4 := 10;
l1 := 270;
l2 := 270;
l3 := 270;
l4 := 270;
k1 := -1;
k2 := -1;
k3 := -1;
k4 := -1;
Bigmap := True;
Gain := 38;
Range := 100;
Graph := 4;
Plot := 4;
Figure := 1;
Param := 3;
Bitmap := 11;
AngleX := 180.00;
PosZ := 10.00;
T1 := 7;
T2 := 10;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H02.InitSample9(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-063';
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
l1 := 102;
l2 := 102;
l3 := 102;
l4 := 102;
OffsetX := -10;
OffsetY := 20;
OffsetZ := 30;
MinusCap := True;
Bigmap := True;
Gain := 32;
Range := 19;
Scene := 4;
Plot := 11;
Figure := 4;
Param := 12;
Bitmap := 17;
AngleX := -180.00;
PosZ := 10.00;
T1 := 20;
T2 := 22;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

end.
