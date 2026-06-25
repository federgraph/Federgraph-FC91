unit RiggVar.FederModel.SDB050H03;

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
  TSDB050H03 = class(TSampleHub)
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

{ TSDB050H03 }

procedure TSDB050H03.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-064';
x1 := 17;
x2 := -17;
y1 := -17;
y2 := -17;
y3 := 17;
l1 := 40;
l2 := 40;
l3 := 40;
l4 := 30;
k1 := 50;
k2 := 0;
k3 := -14;
k4 := 4;
OffsetZ := 6;
Bigmap := True;
Limit := 0;
Graph := 4;
Plot := 4;
Bitmap := 14;
AngleX := 180.00;
PosZ := 9.60;
T1 := -7;
T2 := 20;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H03.InitSample1(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-069';
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
PosZ := 10.03;
T1 := 15;
T2 := 130;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 1;
  end;
end;

procedure TSDB050H03.InitSample2(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-070';
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
Bitmap := 11;
AngleX := 180.00;
PosZ := 8.00;
T3 := 3;
SolutionMode := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H03.InitSample3(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-074';
x1 := 0;
x2 := 0;
y1 := 0;
y2 := 0;
y3 := 0;
l1 := 40;
l2 := 40;
l3 := 40;
l4 := 40;
Gain := 40;
Range := -10;
Scene := 4;
Plot := 11;
Figure := 2;
Bitmap := 18;
AngleX := 180.00;
PosZ := 10.00;
T2 := 150;
SolutionMode := False;
Gleich := True;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H03.InitSample4(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-080';
x1 := 135;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Gain := 9;
Limit := -50;
Range := 60;
Plot := 9;
Figure := 2;
Param := 20;
Bitmap := 15;
AngleX := 180.00;
PosX := -1.47;
PosY := -0.44;
PosZ := 10.17;
T2 := 246;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H03.InitSample5(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-082';
x1 := -0.11;
x2 := -285.89;
x3 := -143;
x4 := -215.680595397949;
y1 := 0.5;
y2 := 0.5;
y3 := -247;
y4 := -99.6502532958984;
l1 := 191;
l2 := 191;
l3 := 191;
l4 := 191;
k1 := 3;
k2 := 3;
k3 := 3;
k4 := 3;
Gain := 83;
Range := 80;
Plot := 10;
Figure := 2;
Param := 23;
Bitmap := 10;
AngleX := 180.00;
PosZ := 4.21;
T1 := -84;
T2 := 85;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H03.InitSample6(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-085';
x1 := 1;
x2 := 7.48;
x3 := -22.5237913131714;
x4 := -8.73648297786713;
y1 := -1;
y2 := 31.5103003978729;
y3 := 22.5829977989197;
y4 := 20.1519231796265;
l1 := 30;
l2 := 30;
l3 := 30;
l4 := 0;
k1 := 41;
k2 := 41;
k3 := 41;
k4 := 41;
Limit := 0;
Range := -52;
Scene := 1;
Graph := 5;
Plot := 6;
Figure := 1;
Param := 15;
Bitmap := 10;
AngleX := 180.00;
PosZ := 11.89;
T2 := 12;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 1;
  end;
end;

procedure TSDB050H03.InitSample7(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-100';
x1 := -12.9903810567666;
x2 := 12.9903810567666;
y1 := -7.5;
y2 := -7.5;
y3 := 15;
l1 := 124;
l2 := 124;
l3 := 124;
l4 := 124;
k1 := 0;
k2 := 50;
k3 := -50;
k4 := 0;
Limit := 0;
Range := 5;
Graph := 5;
Plot := 6;
Figure := 2;
Param := 21;
Bitmap := 15;
AngleX := 180.00;
PosZ := 10.19;
T2 := 200;
Gleich := True;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H03.InitSample8(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-102';
x1 := -24.12;
x2 := -10.12;
x3 := 7.12435674667358;
x4 := -4.99999952316284;
y1 := 13.784610748291;
y2 := -10.4641017913818;
y3 := 15.6602544784546;
y4 := 8.66025447845459;
l1 := 44;
l2 := 44;
l3 := 44;
l4 := 44;
k1 := 0;
k2 := 50;
k3 := -50;
k4 := 0;
OffsetZ := -30;
Bigmap := True;
MeshSize := 512;
Gain := 6;
Limit := 0;
Range := -5;
Graph := 5;
Plot := 6;
Figure := 1;
Bitmap := 15;
AngleX := 180.00;
PosZ := 22.80;
T1 := 11;
T2 := 120;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H03.InitSample9(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-105';
x1 := -20;
x2 := 20;
y1 := -20;
y2 := -20;
y3 := 20;
l1 := 200;
l2 := 200;
l3 := 200;
l4 := 200;
Range := -10;
Plot := 4;
Figure := 2;
Param := 21;
Bitmap := 17;
AngleX := 180.00;
PosZ := 6.90;
T1 := -7;
T2 := 200;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

end.
