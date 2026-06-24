unit RiggVar.FB.MeshParams;

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
  RiggVar.FB.DefConst,
  RiggVar.FB.Equation;

type
  TVertexInfo = record
    Index: Integer;
    X: Integer;
    Y: Integer;
    Z: single;
  end;

  TTriangleInfo = record
    Index1: Integer;
    Index2: Integer;
    Index3: Integer;
  end;

  TVertexOptionZ = (
    Normal,
    FlatBottom,
    MirroredBottom
  );

  TMeshParams = class
  private
    procedure InitOnce;
  public
    EQ: TFederEquation;

    range: single;
    rangex: single;
    rangey: single;

    ox: single;
    oy: single;
    oz: single;

    mc: Integer;
    sx, sy: single;
    ex, ey: single;
    msx, msy: single;
    ms: single;

    ReducedMesh: Boolean;
    ReduceMode: Integer;

    WantZeroPulling: Boolean;
    WantSlicePulling: Boolean;

    UniqueMode: Integer;
    WantUniqueVertices: Boolean;
    WantFlippedHands: Boolean;
    WantMirroredBottom: Boolean;
    OuterOptionZ: TVertexOptionZ;

    SlicePullingMode: Integer;

    CapValue: single;
    SliceHeight: single;

    MinusCap: Boolean;
    PlusCap: Boolean;

    NormScale: Integer;
    GlobalScale: single;
    ModelGroupScale: single;

    T1: single;
    T2: single;
    te1: single;
    te2: single;
    BigMapFactorT2: single;
    ot1: single;
    ot2: single;

    SpringCount: Integer;
    Figure: Integer;
    Attenuation: single;
    CapFactor: single;
    CapOverride: Boolean;

    MeshMode: Integer;

    fcap: single;
    pcap: single;
    mcap: single;

    WantLux: Boolean;

    constructor Create(AEQ: TFederEquation);
    procedure Reset;

    procedure InitTE;
    procedure SaveTE;
    procedure PrepareCalc;
    procedure Update;

    property OffsetX: single read ox write ox;
    property OffsetY: single read oy write oy;
    property OffsetZ: single read oz write oz;

    property MeshSize: Integer read mc write mc;
  end;

implementation

constructor TMeshParams.Create(AEQ: TFederEquation);
begin
  EQ := AEQ;

  Figure := 2;
  SpringCount := 3;

  range := ModelConst.Range;

  ox := 0;
  oy := -ModelConst.OffsetY;
  oz := 0;

  mc := 128;

  CapValue := 60;
  SliceHeight := 25;

  ReduceMode := 0;

  T1 := 0;
  T2 := 180;

  te1 := T1;
  te2 := T2 / 2;

  fcap := 500000;
  pcap := CapValue;
  mcap := -CapValue;

  BigMapFactorT2 := 1;

  InitOnce;
  Reset;
  Update;
end;

procedure TMeshParams.InitTE;
begin
  te1 := T1 / 10;
  te2 := Abs(T2 * BigMapFactorT2);

  te2 := te2 * 2;
  te1 := te1 + (te2 / 2);
  if te2 < 0.1 then
    te2 := 0.1;
end;

procedure TMeshParams.SaveTE;
begin
  ot1 := te1;
  ot2 := te2;
end;

procedure TMeshParams.PrepareCalc;
var
  gain1: single;
  gain2: single;
  gain3: single;
  gain4: single;
begin
  gain1 := Abs(Attenuation);

  if gain1 < 1000 then
    gain2 := sqr(gain1 / 100) * 100 * 1000
  else
    gain2 := sqr(10) * 100 * 1000;

  case SpringCount of
    1: gain3 := 0.005;
    2: gain3 := 1;
    3: gain3 := 500;
    4: gain3 := 25;
    else
      gain3 := 1;
  end;

  gain4 := (1000 + gain2) * gain3;

  if CapOverride then
  begin
    fcap := fcap * CapFactor;
    CapOverride := False;
  end
  else
  case Figure of
    1: fcap := gain4 * 0.1;
    2: fcap := gain4 * 1;
    3: fcap := gain4 * 10;
    4: fcap := gain4 * 100;
    5: fcap := gain4 * 1000;
  end;

  pcap := CapValue;
  mcap := -pcap;
end;

procedure TMeshParams.Update;
begin
  rangex := range;
  rangey := range;

  sx := -rangex + OffsetX;
  sy := -rangey + OffsetY;
  ex := rangex + OffsetX;
  ey := rangey + OffsetY;

  ms := 2 * rangey / mc;
  msx := ms;
  msy := ms;

  SaveTE;
  InitTE;
  PrepareCalc;
end;

procedure TMeshParams.InitOnce;
begin
  MeshMode := 1;
  ModelGroupScale := 1.0;
  GlobalScale := 8;
end;

procedure TMeshParams.Reset;
begin
  ReducedMesh := False;

  PlusCap := False;
  MinusCap := False;

  WantZeroPulling := True;
  WantSlicePulling := False;

  WantLux := True;

  WantFlippedHands := False;
  WantMirroredBottom := False;
  WantUniqueVertices := True;
  OuterOptionZ := TVertexOptionZ.Normal;
end;

end.
