unit RiggVar.FederModel.SDB050H04;

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
  TSDB050H04 = class(TSampleHub)
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

{ TSDB050H04 }

procedure TSDB050H04.InitSample0(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-107';
x1 := 0;
x2 := 0;
y3 := -10;
y4 := -10;
l1 := 137;
l2 := 137;
l3 := 137;
l4 := 137;
k1 := 10;
k2 := 10;
k3 := 10;
k4 := 10;
OffsetZ := 30;
Gain := 10;
Limit := 0;
Range := -17;
Scene := 1;
Graph := 1;
Plot := 10;
Param := 24;
AngleX := 167.00;
PosZ := 12.54;
T1 := 300;
T2 := 500;
SolutionMode := False;
Gleich := True;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H04.InitSample1(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-109';
x1 := 0.44;
x2 := -125.03;
x3 := -91.4114284515381;
x4 := -72;
y1 := 9.41192245483398;
y2 := 43.0325126647949;
y3 := -82.4444351196289;
y4 := -10;
l1 := 376;
l2 := 376;
l3 := 376;
l4 := 376;
Range := 50;
Bitmap := 16;
AngleX := 180.00;
PosZ := 10.00;
T1 := 7;
T2 := 196;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H04.InitSample2(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-110';
x1 := 0;
x2 := 0;
y1 := 0;
y2 := 0;
y3 := 0;
l1 := 85;
l2 := 85;
l3 := 85;
l4 := 85;
k1 := 10;
k2 := 10;
k3 := 10;
Gain := 50;
Limit := 0;
Graph := 4;
Plot := 7;
Param := 21;
Bitmap := 6;
AngleX := 180.00;
PosZ := 9.09;
T2 := 10;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H04.InitSample3(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-117';
x1 := 0;
x2 := 0;
y1 := 0;
y2 := 0;
y3 := 0;
y4 := -30;
l1 := 111;
l2 := 111;
l3 := 111;
l4 := 111;
k1 := 10;
k2 := 10;
k3 := 10;
k4 := 0;
OffsetZ := -25;
MinusCap := True;
Limit := 0;
Range := 275;
Graph := 1;
Plot := 10;
Param := 21;
Bitmap := 19;
AngleX := 180.00;
PosZ := 10.00;
SolutionMode := False;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 5;
  end;
end;

procedure TSDB050H04.InitSample4(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-120';
x1 := 56;
x2 := -56;
y1 := 56;
y2 := 56;
y3 := -56;
l1 := 30;
l2 := 30;
l3 := 30;
l4 := 30;
k1 := 10;
k2 := 10;
k3 := 10;
k4 := 0;
MinusCap := True;
MeshSize := 256;
Gain := 29;
Limit := 0;
Range := 8;
Graph := 2;
Figure := 2;
Param := 18;
AngleX := 180.00;
PosZ := 6.97;
T1 := 40;
T2 := 72;
ParamBahnRadius := 20;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 1;
  end;
end;

procedure TSDB050H04.InitSample5(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-128';
x1 := 0.44;
x2 := -125.03;
x3 := -91.4114284515381;
x4 := -72;
y1 := 9.41192245483398;
y2 := 43.0325126647949;
y3 := -82.4444351196289;
y4 := -10;
l1 := 187;
l2 := 187;
l3 := 187;
l4 := 187;
Range := 120;
Bitmap := 17;
AngleX := 180.00;
PosZ := 11.67;
T1 := 0;
T2 := 196;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H04.InitSample6(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-130';
x1 := 30;
x2 := -30;
y1 := 30;
y2 := 30;
y3 := -30;
l1 := 335;
l2 := 55;
l3 := 345;
l4 := 335;
k1 := 10;
k2 := 10;
k3 := 10;
Limit := 0;
Range := 103;
Figure := 4;
Param := 21;
Bitmap := 17;
AngleX := 180.00;
PosZ := 10.00;
T1 := 2;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

procedure TSDB050H04.InitSample7(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-132';
x1 := 0;
x2 := -31.6352195739746;
x3 := 31.6352195739746;
x4 := -45.1797790527344;
y1 := -56.5685424804688;
y2 := 45.1797790527344;
y3 := -45.1797790527344;
y4 := -31.6352195739746;
l1 := 135;
l2 := 135;
l3 := 135;
l4 := 135;
MinusCap := True;
Gain := 40;
Range := 66;
Scene := 5;
Plot := 10;
Figure := 1;
Param := 48;
Bitmap := 17;
AngleX := 180.00;
PosZ := 12.58;
T2 := 430;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 2;
  end;
end;

procedure TSDB050H04.InitSample8(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-136';
x1 := -104.79;
x2 := 104.79;
y1 := -60.5;
y2 := -60.5;
y3 := 121;
l1 := 199;
l2 := 199;
l3 := 199;
l4 := 199;
MinusCap := True;
Bigmap := True;
MeshSize := 64;
Range := 60;
Graph := 4;
Plot := 11;
Figure := 2;
Bitmap := 16;
AngleX := 180.00;
PosZ := 9.76;
T1 := 67;
T2 := 130;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 1;
  end;
end;

procedure TSDB050H04.InitSample9(fd: TFederData);
begin
  with fd do
  begin
Title := 'FC50-148';
x1 := -48;
x2 := 48;
x3 := -48;
x4 := 48;
y1 := -48;
y2 := -48;
y3 := 48;
y4 := 48;
l1 := 162;
l2 := 162;
l3 := 162;
l4 := 162;
k1 := 2;
k2 := 2;
k3 := 2;
k4 := 2;
PlusCap := True;
Bigmap := True;
Limit := 0;
Range := 14;
Scene := 4;
Graph := 4;
Plot := 4;
Bitmap := 2;
AngleX := 180.00;
PosX := -0.35;
PosY := -1.12;
PosZ := 9.61;
T1 := 20;
T2 := 310;
ShowCylinder := False;
ShowDiameter := False;
ColorScheme3D := 4;
  end;
end;

end.
