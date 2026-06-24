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

  TMeshParams = class
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
    WantLimitPulling: Boolean;
    WantDetailPulling: Boolean;
    WantTargetPulling: Boolean;
    WantSlicePulling: Boolean;
    WantRightPulling: Boolean;

    WantFlippedHands: Boolean;

    SlicePullingMode: Integer;

    CapValue: single;
    SliceHeight: single;

    MinusCap: Boolean;
    PlusCap: Boolean;

    NormScale: Integer;

    T1: single;
    T2: single;
    te1: single;
    te2: single;

    fcap: single;
    pcap: single;
    mcap: single;

    constructor Create(AEQ: TFederEquation);
    procedure Reset;

    procedure InitTE;
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

  range := 120;
  rangex := range;
  rangey := range;

  ox := 0;
  oy := -30;
  oz := 0;

  mc := 256;
  sx := -range;
  sy := -range;
  ex := range;
  ey := range;

  ms := 2 * range / mc;
  msx := ms;
  msy := ms;

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

  Reset;
  Update;
end;

procedure TMeshParams.InitTE;
begin
  te1 := T1 / 10;
  te2 := Abs(T2);

  te2 := te2 * 2;
  te1 := te1 + (te2 / 2);
  if te2 < 0.1 then
    te2 := 0.1;
end;

procedure TMeshParams.PrepareCalc;
begin
  fcap := 500000;
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

  InitTE;
  PrepareCalc;
end;

procedure TMeshParams.Reset;
begin
  ReducedMesh := False;

  PlusCap := False;
  MinusCap := False;

  WantDetailPulling := True;
  WantTargetPulling := True;
  WantRightPulling := False;

  WantZeroPulling := True;
  WantLimitPulling := True;
  WantSlicePulling := False;

  WantFlippedHands := False;

end;

end.
