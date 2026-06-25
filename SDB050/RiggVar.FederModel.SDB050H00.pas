unit RiggVar.FederModel.SDB050H00;

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
  TSDB050H00 = class(TSampleHub)
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

{ TSDB050H00 }

procedure TSDB050H00.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'FCS1-0';
x1 := -50;
x2 := 50;
y1 := 0;
y2 := 0;
y3 := 0;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Norm := True;
TextureNorm := 1;
Range := -117;
Scene := 2;
Plot := 4;
Figure := 2;
Bitmap := 15;
AngleX := 180.00;
PosZ := 8.19;
T1 := -31;
T2 := 66;
ParamBahnRadius := 150;
ParamBahnCylinderD := 400;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 7;
  end;
end;
{
procedure TSDB050H00.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-000';
x1 := 72;
x2 := -72;
y1 := 72;
y2 := 72;
y3 := -72;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Gain := 12;
Range := 30;
Plot := 10;
Figure := 2;
Param := 22;
Bitmap := 21;
AngleX := 180.00;
PosZ := 10.49;
T1 := -8;
T2 := 56;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;
}
procedure TSDB050H00.InitSample1(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-001';
x1 := 64.95;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Range := 40;
Plot := 10;
Figure := 2;
Bitmap := 16;
AngleX := 180.00;
PosZ := 9.15;
T1 := 1;
T2 := 196;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H00.InitSample2(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-005';
x1 := -65;
x2 := 65;
y1 := -65;
y2 := -65;
y3 := 65;
l1 := 94;
l2 := 94;
l3 := 94;
l4 := 0;
k4 := 0;
OffsetZ := -25;
Limit := 0;
Range := 146;
Graph := 1;
Plot := 5;
Figure := 2;
Param := 4;
Bitmap := 16;
AngleX := 180.00;
PosX := -0.44;
PosY := 0.55;
PosZ := 7.01;
T2 := 325;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H00.InitSample3(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-006';
x1 := 64.95;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
PlusCap := True;
Limit := -50;
Range := 40;
Plot := 10;
Figure := 2;
Param := 22;
Bitmap := 17;
AngleX := 180.00;
PosZ := 9.15;
T1 := 1;
T2 := 200;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 6;
  end;
end;

procedure TSDB050H00.InitSample4(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-007';
x1 := 64.95;
x2 := -64.95;
y1 := 37.5;
y2 := 37.5;
y3 := -75;
l1 := 90;
l2 := 90;
l3 := 90;
l4 := 90;
Range := 40;
Plot := 9;
Figure := 2;
Bitmap := 17;
AngleX := 180.00;
PosZ := 9.15;
T1 := 0;
T2 := 196;
LinearForce := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H00.InitSample5(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-008';
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
l1 := 100;
l2 := 100;
l3 := 100;
l4 := 100;
Bigmap := True;
Gain := 21;
Range := 39;
Scene := 4;
Plot := 10;
Figure := 4;
Bitmap := 17;
AngleX := 180.00;
PosY := 1.30;
PosZ := 8.77;
T1 := 1;
T2 := 26;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H00.InitSample6(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-009';
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
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H00.InitSample7(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-010';
x1 := 64.95;
x2 := -64.95;
y1 := -68.5;
y2 := -68.5;
y3 := -181;
y4 := -106;
l1 := 110;
l2 := 110;
l3 := 110;
l4 := 110;
Range := 40;
Plot := 10;
Figure := 2;
Param := 50;
Bitmap := 17;
AngleX := 180.00;
PosZ := 9.15;
T1 := 1;
T2 := 210;
SolutionMode := False;
LinearForce := False;
ParamBahnPositionY := 20;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H00.InitSample8(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-011';
x1 := -90;
x2 := 90;
y1 := -90;
y2 := -90;
y3 := 90;
y4 := 140;
l1 := 116;
l2 := 116;
l3 := 116;
l4 := 116;
Range := 30;
Plot := 10;
Figure := 2;
Bitmap := 17;
AngleX := 180.00;
PosZ := 10.00;
T1 := 1;
T2 := 176;
SolutionMode := False;
LinearForce := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 6;
  end;
end;

procedure TSDB050H00.InitSample9(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-012';
x1 := 64.95;
x2 := -64.95;
y1 := -68.5;
y2 := -68.5;
y3 := -181;
y4 := -106;
l1 := 110;
l2 := 110;
l3 := 110;
l4 := 110;
Range := 40;
Plot := 10;
Figure := 2;
Param := 23;
Bitmap := 17;
AngleX := 180.00;
PosZ := 9.15;
T1 := 1;
T2 := 176;
SolutionMode := False;
LinearForce := False;
ParamBahnPositionY := 20;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

end.
