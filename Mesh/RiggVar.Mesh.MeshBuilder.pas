unit RiggVar.Mesh.MeshBuilder;

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
  System.SysUtils,
  System.Classes,
  System.Math,
  System.Math.Vectors,
  System.Types,
  System.Generics.Collections,
  System.RTLConsts,
  FMX.Types,
  FMX.Types3D,
  RiggVar.Mesh.Stitcher,
  RiggVar.Poly.Rack,
  RiggVar.FB.Def,
  RiggVar.FB.MeshParams;

type
  TVertexState = record
  public
    LoopCounter: Integer;
    LineTag: Integer;
    Pulled: Boolean;
    PulledLeft: Boolean;
    PulledRight: Boolean;
    PullDirection: Integer;
    QuadCrossings: Integer;
    procedure Clear;
    function NeedMoreDetail: Boolean;
  end;

  TEdgeData = record
  public
    viA: Integer;
    viB: Integer;
    PA: TPoint3D;
    PB: TPoint3D;
    function CheckCrossing(Soll: single): Boolean;
  end;

  TQuadEdges = record
  public
    H1: TPoint; // contains Index values of two TPoint3Ds
    H2: TPoint;
    V1: TPoint;
    V2: TPoint;
  end;

  TVertexQuad = record
  public
    X: Integer;
    Y: Integer;

    A0: Integer;
    A1: Integer;
    A2: Integer;
    A3: Integer;

    procedure ClearAdjacent;
    function GetEdges: TQuadEdges;
  end;

  TFederLimits = record
    ZeroLimit: single;
    MCapLimit: single;
    PCapLimit: single;
    SliceLimitM: single;
    SliceLimitP: single;
  end;

  TMeshBuilderBase = class
  private
    function GetCenter: TPoint3D;
    function GetDepth: single;
    function GetHeight: single;
    function GetWidth: single;
  protected
    FT: TList<TPointF>; // texture coordinates
    FV: TList<TPoint3D>; // stores vertices (P) used for triangles
    T1: TList<Integer>; // stores Index 1 of (all) triangles
    T2: TList<Integer>;
    T3: TList<Integer>;
    xmax, ymax, zmax: single;
    xmin, ymin, zmin: single;
    procedure BingoLog(s: string);
    procedure InitTE; virtual;
    function IsInHandFlippedArea(i: Integer): Boolean; virtual;
    procedure MakeUniqueVertices; virtual;
    procedure UpdateIB(IB: TIndexBuffer); virtual;
    procedure UpdateTE(VB: TVertexBuffer); virtual;
    procedure UpdateTexCoord(VB: TVertexBuffer);
    procedure UpdateVB(VB: TVertexBuffer); virtual;
  public
    ExportOffsetZ: single;
    MaterialName: string;
    ObjectName: string;
    pc1: TPointF;
    pc2: TPointF;
    te1: single;
    te2: single;
    WantNormals: Boolean;
    WantTexCoord: Boolean;
    WantUniqueVertices: Boolean;
    WantUpdateTE: Boolean;
    constructor Create;
    destructor Destroy; override;
    function AddData(MV: TMeshVisitor; AVertexOffset: Integer = 0): Integer; virtual;
    procedure ApplyExportOffsetZ(Value: single); virtual;
    procedure GetMeshDataMatrixReport(ML: TStrings; ReportID: Integer); virtual;
    function GetMeshDataName: string; virtual;
    function GetMeshDataReport(ReportID: Integer = 0): string; virtual;
    procedure GetMinMax;
    procedure InitData; virtual;
    procedure Normalize(f: single); virtual;
    procedure Update3DBuffers(VB: TVertexBuffer; IB: TIndexBuffer); virtual;
    property Center: TPoint3D read GetCenter;
    property Depth: single read GetDepth;
    property Height: single read GetHeight;
    property Width: single read GetWidth;
  end;

  TMeshBuilder = class(TMeshBuilderBase)
  protected
    BangoCounter: Integer; // for debugging
    BengoCounter: Integer; // for debugging
    BingoCounter: Integer; // for debugging
    BongoCounter: Integer; // for debugging
    BungoCounter: Integer; // for debugging
    H1: TList<Integer>; // Index 1 of triangles to be kept after reduce op
    H2: TList<Integer>;
    H3: TList<Integer>;
    SL: TStringList;
    TL: TList<TTriangleInfo>;
    UV: TList<TPoint3D>; // unique vertices
    procedure AddBingoInfo(LongVersion: Boolean = False);
    procedure Bango;
    procedure Bengo;
    procedure Bingo;
    procedure Bongo;
    procedure Bungo;
    procedure MakeUniqueH;
    procedure MakeUniqueH1;
    procedure MakeUniqueH2;
    procedure MakeUniqueT;
    procedure MakeUniqueVertices; override;
    procedure Reduce; virtual;
    procedure ResetBingoCounter;
    function SkipTest3(az1, az2, az3: single): Boolean;
    procedure SL_Add(s: string; TargetLength: Integer = 36);
    procedure UpdateIB(IB: TIndexBuffer); override;
  public
    CapValue: single;
    FlatMesh: Boolean;
    IsBottom: Boolean;
    IsFlippedHand: Boolean;
    IsLeftHand: Boolean;
    PartOffsetZ: single;
    ReducedMesh: Boolean;
    ReduceMode: Integer;
    SliceHeight: single;
    UniqueMode: Integer;
    WantDetailPulling: Boolean;
    WantMirroredBottom: Boolean;
    WantFlippedHands: Boolean;
    WantLimitPulling: Boolean;
    WantRightPulling: Boolean;
    WantSlicePulling: Boolean;
    WantSpecialY: Boolean;
    WantTargetPulling: Boolean;
    WantZeroPulling: Boolean;
    constructor Create;
    destructor Destroy; override;
    function AddData(MV: TMeshVisitor; AVertexOffset: Integer = 0): Integer; override;
    procedure ApplyExportOffsetZ(Value: single); override;
    procedure FlattenToCapValue(Value: single);
    procedure Update3DBuffers(VB: TVertexBuffer; IB: TIndexBuffer); override;
  end;

  TFederMeshBuilder = class(TMeshBuilder)
  private
  const
    DefaultLoopMax = 30;
    DefaultLoopTarget = 0.001;
    LoopTargetMin = 0.001;
    TagBottom = 3;
    TagHorizontal = 1;
    TagLeft = 2;
    TagRight = 4;
    TagTop = 1;
    TagVertical = 2;
  var
    CurrentLineTag: Integer;
    CurrentPullDirection: Integer;
    FederLimits: TFederLimits;
    FLoopFaktor: single;
    GD: TList<TVertexState>; // additional info about vertices
    GN: TList<TPoint3D>; // temp vertices, computed w/o capping
    Limit1: single;
    Limit2: single;
    Limit3: single;
    Limit4: single;
    Limit5: single;
    LimitCount: Integer;
    LoopCounter: Integer; // for limit pulling of segment
    LoopMax: Integer;
    LoopTarget: single;
    NominalQuadCount: Integer;
    P: TPoint3D; // contains u, v, and w
    P1, P2, P3: TPoint3D; // for limit pulling of segment
    QA: TList<TVertexQuad>;
    PolyRack: TPolyRack;
    R1: TPolyRadBase;
    R2: TPolyRadBase;
    u, v, w: single;
    vi1, vi3: Integer; // vertex indices of segment endpoints
    procedure AddLoopCounterInfo(LongVersion: Boolean = False);
    procedure ApplyAbsolute;
    procedure ApplyBottomCapping(CapValue: single);
    procedure ApplyCapping;
    procedure ApplyFlip;
    procedure ApplyLimitPulling;
    procedure ApplyLimitPullingQA;
    procedure ApplySliceCapping;
    procedure ApplyTopCapping(CapValue: single);
    procedure ApplyVertexPostProcesssing;
    procedure AssignPoint;
    procedure AssignPoints;
    function CheckCrossing(P1, P2: TPoint3D; Soll: single = 0): Boolean;
    function ComputeZN(P: TPoint3D): single;
    procedure DoLimitPullingQA(CapValue: single; Tag: Integer);
    procedure DoLoopPolyTest(PA, PE: TPoint3D; Soll: single = 0);
    procedure DoSpecialOp(Edge: TPoint; Soll: single; DirTag: Integer);
    function FindNew(P1, P2: TPoint3D; Soll: single = 0): TPoint3D;
    function GetPullIndex: Integer; inline;
    function GetSpecialY: Integer;
    procedure Init2;
    procedure InitG(x, y: Integer);
    procedure InitLimits;
    procedure InitQuads;
    procedure InitTriangles;
    procedure ResetGD;
    procedure SavePulling(VI: Integer);
    procedure SetLoopFaktor(const Value: single);
    function SkipFlippedHands: Boolean;
    procedure UpdateFedergraphSize;
    procedure UpdateFromMeshParams(vp: TMeshParams);
    procedure UpdateHandArea;
    function UpdateTrianglesQA(NI: Integer; vq: TVertexQuad): Integer;
  protected
    procedure InitTE; override;
    function IsInHandFlippedArea(i: Integer): Boolean; override;
    procedure UpdateVB(VB: TVertexBuffer); override;
    function VertexIndex(x, y: Integer): Integer;
  public
    SlicePullingMode: Integer;
    TriangleCount: Integer;
    VertexCount: Integer;
    vp: TMeshParams; // injected
    OuterOptionZ: TVertexOptionZ;
    constructor Create;
    destructor Destroy; override;
    function CheckForData(fn: string): Boolean;
    procedure GetMeshDataInfo;
    procedure GetMeshDataMatrixReport(ML: TStrings; ReportID: Integer = 0); override;
    function GetMeshDataName: string; override;
    function GetMeshDataReport(ReportID: Integer = 0): string; override;
    procedure InitData; override;
    procedure Normalize(f: single); override;
    procedure NormalizeRelative(f: single);
    procedure Update3DBuffers(VB: TVertexBuffer; IB: TIndexBuffer); override;
    procedure UpdateSize(VBL, IBL: Integer);
    property LoopFaktor: single read FLoopFaktor write SetLoopFaktor;
    property SliceBC: Integer read BungoCounter;
  end;

implementation

{ TVertexState }

procedure TVertexState.Clear;
begin
  LoopCounter := 0;
  LineTag := 0;
  Pulled := False;
  PulledLeft := False;
  PulledRight := False;
  PullDirection := 0;
  QuadCrossings := 0;
end;

function TVertexState.NeedMoreDetail: Boolean;
begin
  result := QuadCrossings > 0;
end;

{ TVertexQuad }

procedure TVertexQuad.ClearAdjacent;
begin
end;

function TVertexQuad.GetEdges: TQuadEdges;
begin
{ A0 A1
  A3 A2 }

  { top }
  result.H1.X := A0;
  result.H1.Y := A1;

  { bottom }
  result.H2.X := A3;
  result.H2.Y := A2;

  { left }
  result.V1.X := A0;
  result.V1.Y := A3;

  { right }
  result.V2.X := A1;
  result.V2.Y := A2;
end;

function TEdgeData.CheckCrossing(Soll: single): Boolean;
var
  s1, s2: TValueSign;
begin
  s1 := Sign(PA.Z - Soll);
  s2 := Sign(PB.Z - Soll);

  if s1 = 0 then
  begin
    result := False;
    Exit;
  end;

  if s2 = 0 then
  begin
    result := False;
    Exit;
  end;

  result :=  s1 <> s2;
end;

{ TMeshBuilderBase }

constructor TMeshBuilderBase.Create;
begin
  FV := TList<TPoint3D>.Create;
  FT := TList<TPointF>.Create;

  T1 := TList<Integer>.Create;
  T2 := TList<Integer>.Create;
  T3 := TList<Integer>.Create;

  pc1 := TPointF.Create(0.5, 0.0);
  pc2 := TPointF.Create(0.5, 1.0);
end;

destructor TMeshBuilderBase.Destroy;
begin
  FV.Free;
  FT.Free;

  T1.Free;
  T2.Free;
  T3.Free;

  inherited;
end;

function TMeshBuilderBase.AddData(MV: TMeshVisitor; AVertexOffset: Integer = 0): Integer;
var
  i: Integer;
  o: Integer;
begin
  if ObjectName <> '' then
    MV.AddObjectName(ObjectName);

  result := FV.Count;

  for i := 0 to FV.Count - 1 do
    MV.AddVertex(FV[i]);

  if MaterialName <> '' then
    MV.AddMaterialName(MaterialName);

  o := AVertexOffset;

  for i := 0 to T1.Count - 1 do
    MV.AddTriangle(T1[i] + o, T2[i] + o, T3[i] + o);
end;

procedure TMeshBuilderBase.ApplyExportOffsetZ(Value: single);
begin
  { virtual }
end;

procedure TMeshBuilderBase.BingoLog(s: string);
begin
  Log.d(s);
end;

function TMeshBuilderBase.GetCenter: TPoint3D;
begin
  result := TPoint3D.Create((xmin + xmax) / 2, (ymin + ymax) / 2, (zmin + zmax) / 2);
end;

function TMeshBuilderBase.GetDepth: single;
begin
  result := zmax - zmin;
end;

function TMeshBuilderBase.GetHeight: single;
begin
  result := ymax - ymin;
end;

procedure TMeshBuilderBase.GetMeshDataMatrixReport(ML: TStrings; ReportID: Integer);
begin
end;

function TMeshBuilderBase.GetMeshDataName: string;
begin
  result := self.ClassName;
end;

function TMeshBuilderBase.GetMeshDataReport(ReportID: Integer): string;
begin
  result := '';
end;

procedure TMeshBuilderBase.GetMinMax;
var
  i: Integer;
begin
  xmin := FV[0].X;
  ymin := FV[0].Y;
  zmin := FV[0].Z;

  xmax := xmin;
  ymax := ymin;
  zmax := zmin;

  for i := 0 to FV.Count - 1 do
  begin
    if FV[i].X < xmin then
      xmin := FV[i].X;
    if FV[i].Y < ymin then
      ymin := FV[i].Y;
    if FV[i].Z < zmin then
      zmin := FV[i].Z;

    if FV[i].X > xmax then
      xmax := FV[i].X;
    if FV[i].Y > ymax then
      ymax := FV[i].Y;
    if FV[i].Z > zmax then
      zmax := FV[i].Z;
  end;
end;

function TMeshBuilderBase.GetWidth: single;
begin
  result := xmax - xmin;
end;

procedure TMeshBuilderBase.InitData;
begin

end;

procedure TMeshBuilderBase.InitTE;
begin
  { virtual }
  te1 := 151;
  te2 := 300;
end;

function TMeshBuilderBase.IsInHandFlippedArea(i: Integer): Boolean;
begin
  result := False;
end;

procedure TMeshBuilderBase.MakeUniqueVertices;
begin

end;

procedure TMeshBuilderBase.Normalize(f: single);
begin

end;

procedure TMeshBuilderBase.Update3DBuffers(VB: TVertexBuffer; IB: TIndexBuffer);
begin
  if WantUniqueVertices then
  begin
    MakeUniqueVertices;
  end;

  UpdateVB(VB);

  if WantUpdateTE then
    UpdateTE(VB);

  if WantTexCoord then
    UpdateTexCoord(VB);

  UpdateIB(IB);
end;

procedure TMeshBuilderBase.UpdateIB(IB: TIndexBuffer);
var
  i, j: Integer;
begin
    IB.Length := T1.Count * 3;
    for i := 0 to T1.Count - 1 do
    begin
      j := i * 3;
      IB[j] := T1[i];
      IB[j+1] := T2[i];
      IB[j+2] := T3[i];
    end;
end;

procedure TMeshBuilderBase.UpdateTE(VB: TVertexBuffer);
var
  i: Integer;
  u, v: single;
begin
  InitTE; // virtual

  for i := 0 to FV.Count - 1 do
  begin
    u := (FV[i].X + te1) / te2;
    v := (FV[i].Z + te1) / te2;
    VB.TexCoord0[i] := PointF(u, v);
  end;
end;

procedure TMeshBuilderBase.UpdateTexCoord(VB: TVertexBuffer);
var
  i: Integer;
begin
  for i := 0 to FV.Count - 1 do
  begin
    VB.TexCoord0[i] := FT[i];
  end;
end;

procedure TMeshBuilderBase.UpdateVB(VB: TVertexBuffer);
var
  i: Integer;
begin
  VB.Length := FV.Count;

  { assign Vertices }
  for i := 0 to FV.Count - 1 do
  begin
    VB.Vertices[i] := FV[i];
  end;
end;

{ TMeshBuilder }

constructor TMeshBuilder.Create;
begin
  inherited;

  SL := TStringList.Create;

  te1 := 0;
  te2 := 1;

  UV := TList<TPoint3D>.Create;

  H1 := TList<Integer>.Create;
  H2 := TList<Integer>.Create;
  H3 := TList<Integer>.Create;

  TL := TList<TTriangleInfo>.Create;
end;

destructor TMeshBuilder.Destroy;
begin
  UV.Free;

  TL.Free;

  H1.Free;
  H2.Free;
  H3.Free;

  SL.Free;

  inherited;
end;

procedure TMeshBuilder.AddBingoInfo(LongVersion: Boolean);
begin
  if LongVersion then
  begin
    SL_Add(Format('Bango = %4d', [BangoCounter]));
    SL_Add(Format('Bengo = %4d', [BengoCounter]));
    SL_Add(Format('Bingo = %4d', [BingoCounter]));
    SL_Add(Format('Bongo = %4d', [BongoCounter]));
    SL_Add(Format('Bungo = %4d', [BungoCounter]));
  end
  else
    SL_Add(Format('Bingo = %d; %d; %d; %d; %d',
      [BangoCounter, BengoCounter, BingoCounter, BongoCounter, BungoCounter]));
end;

function TMeshBuilder.AddData(MV: TMeshVisitor; AVertexOffset: Integer = 0): Integer;
var
  i: Integer;
  o: Integer;
begin
  if ObjectName <> '' then
    MV.AddObjectName(ObjectName);

  result := FV.Count;

  for i := 0 to FV.Count - 1 do
    MV.AddVertex(FV[i]);

  if MaterialName <> '' then
    MV.AddMaterialName(MaterialName);

  o := AVertexOffset;

  if ReducedMesh then
    for i := 0 to H1.Count - 1 do
      MV.AddTriangle(H1[i] + o, H2[i] + o, H3[i] + o)
  else
    for i := 0 to T1.Count - 1 do
      MV.AddTriangle(T1[i] + o, T2[i] + o, T3[i] + o);
end;

procedure TMeshBuilder.ApplyExportOffsetZ(Value: single);
var
  i: Integer;
  cr: TPoint3D;
begin
  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    if cr.Z < CapValue then
    begin
      cr.Z := cr.Z + Value;
      FV[i] := cr;
    end;
  end;
end;

procedure TMeshBuilder.Bango;
begin
  Inc(BangoCounter);
end;

procedure TMeshBuilder.Bengo;
begin
  Inc(BengoCounter);
end;

procedure TMeshBuilder.Bingo;
begin
  Inc(BingoCounter);
end;

procedure TMeshBuilder.Bongo;
begin
  Inc(BongoCounter);
end;

procedure TMeshBuilder.Bungo;
begin
  Inc(BungoCounter);
end;

procedure TMeshBuilder.FlattenToCapValue(Value: single);
var
  i: Integer;
  cr: TPoint3D;
begin
  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    if cr.Z < Value then
    begin
      cr.Z := Value;
      FV[i] := cr;
    end;
  end;
end;

procedure TMeshBuilder.MakeUniqueH;
begin
  case UniqueMode of
    1: MakeUniqueH1;
    2: MakeUniqueH2;
    else
      MakeUniqueH2;
  end;
end;

procedure TMeshBuilder.MakeUniqueH1;
var
  i, j: Integer;
  i1, i2, i3: Integer;
begin
  for i := 0 to H1.Count - 1 do
  begin
    UV.Add(TPoint3D.Zero);
    UV.Add(TPoint3D.Zero);
    UV.Add(TPoint3D.Zero);

    j := i * 3;

    i1 := H1[i];
    i2 := H2[i];
    i3 := H3[i];

    H1[i] := j;
    H2[i] := j + 1;
    H3[i] := j + 2;

    UV[j]   := FV[i1];
    UV[j+1] := FV[i2];
    UV[j+2] := FV[i3];
  end;
end;

procedure TMeshBuilder.MakeUniqueH2;
var
  i, j: Integer;
  i1, i2, i3: Integer;
  compareValue: single;
begin
   { UV has been cleared already }
  Assert(UV.Count = 0);

  { keep all existing vertices }
  for i := 0 to FV.Count - 1 do
    UV.Add(FV[i]);

  { add new vertices only for triangles near zero (where needed) }

  compareValue := 0.1;
  j := UV.Count;
  for i := 0 to H1.Count - 1 do
  begin
    i1 := H1[i];
    i2 := H2[i];
    i3 := H3[i];

    if (Abs(FV[i1].Z) < compareValue) then
    begin
      H1[i] := j;
      UV.Add(FV[i1]);
      Inc(j);
    end;

    if (Abs(FV[i2].Z) < compareValue) then
    begin
      H2[i] := j;
      UV.Add(FV[i2]);
      Inc(j);
    end;

    if (Abs(FV[i3].Z) < compareValue) then
    begin
      H3[i] := j;
      UV.Add(FV[i3]);
      Inc(j);
    end;

  end;
end;

procedure TMeshBuilder.MakeUniqueT;
var
  i, j: Integer;
  i1, i2, i3: Integer;
begin
  for i := 0 to T1.Count - 1 do
  begin
    UV.Add(TPoint3D.Zero);
    UV.Add(TPoint3D.Zero);
    UV.Add(TPoint3D.Zero);

    i1 := T1[i];
    i2 := T2[i];
    i3 := T3[i];

    j := i * 3;

    T1[i] := j;
    T2[i] := j + 1;
    T3[i] := j + 2;

    UV[j]   := FV[i1];
    UV[j+1] := FV[i2];
    UV[j+2] := FV[i3];
  end;
end;

procedure TMeshBuilder.MakeUniqueVertices;
var
  i: Integer;
begin
  UV.Clear;

  if ReducedMesh then
    MakeUniqueH
  else
    MakeUniqueT;

  FV.Clear;
  for i := 0 to UV.Count - 1 do
    FV.Add(UV[i]);
end;

procedure TMeshBuilder.Reduce;
var
  i: Integer;
  P1, P2, P3: TPoint3D;
  skip: Boolean;
  L: single;
  o: Integer;
begin
  H1.Clear;
  H2.Clear;
  H3.Clear;

  L := CapValue;
  o := FV.Count;
  for i := 0 to T1.Count - 1 do
  begin
    P1 := FV[T1[i] mod o];
    P2 := FV[T2[i] mod o];
    P3 := FV[T3[i] mod o];

    skip := False;
    case ReduceMode of
      0:
      begin
        skip := ((P1.Z >= +L) and (P2.Z >= +L) and (P3.Z >= +L)) or
                ((P1.Z <= -L) and (P2.Z <= -L) and (P3.Z <= -L));
      end;
      1: skip := (P1.Z >= +L) and (P2.Z >= +L) and (P3.Z >= +L);
      2: skip := (P1.Z <= -L) and (P2.Z <= -L) and (P3.Z <= -L);

      3:
      begin
        { skip normal horizontal triangles }
        if (Abs(P1.Z - P2.Z) < 0.001) and (Abs(P2.Z - P3.Z) < 0.001) then
        begin
          skip := SkipTest3(P1.Z, P2.Z, P3.Z);
        end;
      end;
    end;

    { prevent holes in mesh near zero }
    if Abs(P1.Z) < 0.001 then
      skip := False;

    if not skip then
    begin
      H1.Add(T1[i]);
      H2.Add(T2[i]);
      H3.Add(T3[i]);
    end;
  end;
end;

procedure TMeshBuilder.ResetBingoCounter;
begin
  BangoCounter := 0;
  BengoCounter := 0;
  BingoCounter := 0;
  BongoCounter := 0;
  BungoCounter := 0;
end;

function TMeshBuilder.SkipTest3(az1, az2, az3: single): Boolean;
const
  eps: single = 0.001;
  BottomHand: single = Abs(-3.2);
  BottomEye: single = 36.5;
  SaddleHeight: single = 43.3;

  function IsNear(Value: single): Boolean;
  begin
    result := (Abs(az1 - Value) < eps) or
              (Abs(az2 - Value) < eps) or
              (Abs(az3 - Value) < eps);
  end;

  function IsInValidRange: Boolean;
  begin
    result := (az1 - PartOffsetZ < CapValue) and
              (az1 - PartOffsetZ > CapValue - SliceHeight);
  end;

begin
  { return false if triangle must be kept,
    return true if triangle can be skipped }

  { skip by default }
  result := True;

  { but not when near a value of z where horizontal triangles are expected }
  if IsInValidRange then
  begin
    result := False;
  end

  else if (PartOffsetZ = 0) then
  begin

    if IsNear(0) or
       IsNear(BottomEye) or
       IsNear(BottomHand) or
       IsNear(SaddleHeight) then
      result := False;

  end

  else if PartOffsetZ <> 0 then
  begin

    if IsNear(0 + PartOffsetZ) or
       IsNear(BottomEye + PartOffsetZ) or
       IsNear(BottomHand + PartOffsetZ) or
       IsNear(SaddleHeight + PartOffsetZ) then
      result := False;

  end

end;

procedure TMeshBuilder.SL_Add(s: string; TargetLength: Integer);
var
  c: Integer;
  t: string;
begin
  c := TargetLength - s.Length;
  if c > 0 then
    t := StringOfChar(' ', c);
  SL.Add(s + t + '|');
end;

procedure TMeshBuilder.UpdateIB(IB: TIndexBuffer);
var
  i, j: Integer;
begin
  if ReducedMesh then
  begin
    IB.Length := H1.Count * 3;
    for i := 0 to H1.Count - 1 do
    begin
      j := i * 3;
      if IsBottom then
      begin
        IB[j] := H1[i];
        IB[j+1] := H3[i];
        IB[j+2] := H2[i];
      end
      else
      begin
        IB[j] := H1[i];
        IB[j+1] := H2[i];
        IB[j+2] := H3[i];
      end;
    end;
  end
  else
    inherited;
end;

{ TFederMeshBuilder }

constructor TFederMeshBuilder.Create;
begin
  inherited;

  WantMirroredBottom := False;
  WantUpdateTE := True;

  LoopMax := DefaultLoopMax;
  LoopTarget := DefaultLoopTarget;

  GN := TList<TPoint3D>.Create;
  GD := TList<TVertexState>.Create;
  QA := TList<TVertexQuad>.Create;

  WantZeroPulling := True;
  WantLimitPulling := True;

  WantTargetPulling := True;
  WantRightPulling := False;

  PolyRack := TPolyRack.Create(1);
  R1 := PolyRack.Poly1;
  R2 := PolyRack.Poly2;
end;

destructor TFederMeshBuilder.Destroy;
begin
  PolyRack.Free;
  GN.Free;
  GD.Free;
  QA.Free;
  inherited;
end;

procedure TFederMeshBuilder.AddLoopCounterInfo(LongVersion: Boolean);
var
  CounterPulledTotal: Integer;

  LoopCounterMax: Integer;
  LoopCounterSum: Integer;
  LoopCounterAvg: single;
  lc: Integer;

  vs: TVertexState;
begin
  if GD.Count = 0 then
    Exit;

  LoopCounterMax := 0;
  LoopCounterSum := 0;
  LoopCounterAvg := 0;

  CounterPulledTotal := 0;

  for vs in GD do
  begin
    if not vs.Pulled then
      Continue;

    Inc(CounterPulledTotal);
    lc := vs.LoopCounter;
    if lc > LoopCounterMax then
      LoopCounterMax := lc;
    LoopCounterSum := LoopCounterSum + lc;
  end;

  if CounterPulledTotal > 0 then
    LoopCounterAvg := LoopCounterSum / CounterPulledTotal;

  if LongVersion then
  begin
  SL_Add(Format('Pulled Total   = %4d', [CounterPulledTotal]));
  SL_Add(Format('LoopCounterMax = %4d', [LoopCounterMax]));
  SL_Add(Format('LoopCounterAvg = %.2f', [LoopCounterAvg]));
  end
  else
    SL_Add(Format('LoopStats = %d; %d; %.2f;',
      [CounterPulledTotal, LoopCounterMax, LoopCounterAvg]));
end;

procedure TFederMeshBuilder.ApplyAbsolute;
var
  i: Integer;
  cr, cr2: TPoint3D;
  pf: TPointF;
  temp: Boolean;
begin
  if vp.EQ.TakesAbsolute then
  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];

    cr2 := cr;
    cr2.Z := Abs(cr.Z);

    pf := TPointF.Create(cr.X, cr.Y);

    temp := False;
    if WantFlippedHands then
    begin
      if R1.Contains(pf) then
      begin
        if cr.Z > 0 then
        begin
          temp := False;
          cr2.Z := -cr2.Z;
        end;
      end;

      if R2.Contains(pf) then
      begin
        if cr.Z < 0 then
        begin
          temp := True;
        end;
      end;
    end;

    if temp then
      FV[i] := cr
    else
      FV[i] := cr2;
  end;
end;

procedure TFederMeshBuilder.ApplyBottomCapping(CapValue: single);
var
  i: Integer;
  cr: TPoint3D;
begin
  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    if cr.Z > CapValue then
    begin
      cr.Z := CapValue;
      FV[i] := cr;
    end;
  end;
end;

procedure TFederMeshBuilder.ApplyCapping;
var
  i: Integer;
  z: single;
  cr: TPoint3D;
begin
  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    z := cr.Z;
    if vp.PlusCap and (z > vp.pcap) then
      z := vp.pcap;
    if vp.MinusCap and (z < vp.mcap) then
      z := vp.mcap;
    cr.Z := z;
    FV[i] := cr;
  end;
end;

procedure TFederMeshBuilder.ApplyFlip;
var
  i: Integer;
  cr: TPoint3D;
begin
  if vp.EQ.TakesAbsolute then
    for i := 0 to FV.Count - 1 do
    begin
      cr := FV[i];
      cr.Z := - cr.Z;
      FV[i] := cr;
    end;
end;

procedure TFederMeshBuilder.ApplyLimitPulling;
begin
  InitLimits;
  ApplyLimitPullingQA;
  if WantSlicePulling then
    ApplySliceCapping;
end;

procedure TFederMeshBuilder.ApplyLimitPullingQA;
begin
  if WantSlicePulling then
  begin
    case SlicePullingMode of
      0:
      begin
        if (LimitCount = 5) { and WantZeroPulling } then
        begin
          DoLimitPullingQA(Limit1, 5); // ZeroLimit;
          DoLimitPullingQA(Limit2, 6); // PCapLimit;
          DoLimitPullingQA(Limit3, 7); // MCapLimit;
          DoLimitPullingQA(Limit4, 8); // SliceLimitP;
          DoLimitPullingQA(Limit5, 9); // SliceLimitM;
        end
        else
        begin
          DoLimitPullingQA(Limit1, 6); // PCapLimit;
          DoLimitPullingQA(Limit2, 7); // MCapLimit;
          DoLimitPullingQA(Limit3, 8); // SliceLimitP;
          DoLimitPullingQA(Limit4, 9); // SliceLimitM;
        end;
      end;

      1:
      begin
        { upper slice border ( lower z-Value) }
        DoLimitPullingQA(Limit1, 8); // SliceLimitP;
        DoLimitPullingQA(Limit2, 9); // SliceLimitM;
      end;

      2:
      begin
        { lower slice border ( higher z-Value) }
        DoLimitPullingQA(Limit1, 6); // PCapLimit;
        DoLimitPullingQA(Limit2, 7); // MCapLimit;
      end;

      3:
      begin
        DoLimitPullingQA(Limit1, 5); // ZeroLimit;
        DoLimitPullingQA(Limit2, 6); // PCapLimit;
        DoLimitPullingQA(Limit3, 7); // MCapLimit;
      end;

    end;
  end
  else
  begin
    if LimitCount >= 1 then
      DoLimitPullingQA(Limit1, 1);
    if LimitCount >= 2 then
      DoLimitPullingQA(Limit2, 2);
    if LimitCount >= 3 then
      DoLimitPullingQA(Limit3, 3);
  end;
end;

procedure TFederMeshBuilder.ApplySliceCapping;
begin
  if IsFlippedHand then
  begin
    if not IsLeftHand then
      ApplyFlip;
  end
  else
    ApplyAbsolute;

  if not WantFlippedHands then
  ApplyTopCapping(FederLimits.SliceLimitP);
  ApplyBottomCapping(FederLimits.PCapLimit);
end;

procedure TFederMeshBuilder.ApplyTopCapping(CapValue: single);
var
  i: Integer;
  cr: TPoint3D;
begin
  if IsFlippedHand then
    Exit;

  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    if cr.Z < CapValue then
    begin
      cr.Z := CapValue;
      FV[i] := cr;
    end;
  end;
end;

procedure TFederMeshBuilder.ApplyVertexPostProcesssing;
begin
  if vp.EQ.TakesAbsolute and not WantSlicePulling then
  begin
    ApplyAbsolute;
  end;

  if (vp.PlusCap or vp.MinusCap) and not WantSlicePulling then
    ApplyCapping;

  AssignPoints;
end;

procedure TFederMeshBuilder.AssignPoint;
begin
  P.X := u;
  P.Y := v;
  P.Z := w;
end;

procedure TFederMeshBuilder.AssignPoints;
var
  i: Integer;
  cr: TPoint3D;
begin
  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    u := cr.X;
    v := cr.Y;
    w := cr.Z + PartOffsetZ;
    AssignPoint;
    FV[i] := P;
  end;
end;

function TFederMeshBuilder.CheckCrossing(P1, P2: TPoint3D; Soll: single = 0): Boolean;
var
  s1, s2: TValueSign;
begin
  s1 := Sign(P1.Z - Soll);
  s2 := Sign(P2.Z - Soll);

  if s1 = 0 then
  begin
    result := False;
    Exit;
  end;

  if s2 = 0 then
  begin
    result := False;
    Exit;
  end;

  result :=  s1 <> s2;
end;

function TFederMeshBuilder.CheckForData(fn: string): Boolean;
begin
  result := false;
end;

function TFederMeshBuilder.ComputeZN(P: TPoint3D): single;
begin
  result := vp.EQ.GetValueN(P.X, P.Y);
end;

procedure TFederMeshBuilder.DoLimitPullingQA(CapValue: single; Tag: Integer);
var
  vq: TVertexQuad;
  qe: TQuadEdges;
begin
  CurrentLineTag := Tag;
  for vq in QA do
  begin
    qe := vq.GetEdges;

    { top and left edge of every quad }
    DoSpecialOp(qe.H1, CapValue, TagTop); // same as TagHorizontal = 1
    DoSpecialOp(qe.V1, CapValue, TagLeft); // same as TagVertical = 2
    if (vq.Y = vp.mc - 1) then
    begin
      { bottom edge in last row of quads  }
      DoSpecialOp(qe.H2, CapValue, TagBottom);
    end;
    if (vq.X = vp.mc - 1) then
    begin
      { right edge in last quad ( in every row of quads) }
      DoSpecialOp(qe.V2, CapValue, TagRight);
    end;
  end;
end;

procedure TFederMeshBuilder.DoLoopPolyTest(PA, PE: TPoint3D; Soll: single = 0);
begin
  CheckCrossing(PA, PE, Soll);

  if PA.Z <> ComputeZN(PA) then
    Bango;
  if PE.Z <> ComputeZN(PE) then
    Bango;
end;

procedure TFederMeshBuilder.DoSpecialOp(Edge: TPoint; Soll: single; DirTag: Integer);
var
  VI: Integer;
begin
  vi1 := Edge.X;
  vi3 := Edge.Y;
  P1 := GN[vi1];
  P3 := GN[vi3];
  CurrentPullDirection := DirTag;

  { SkipFlippedHands uses P1 and P3 }
  if SkipFlippedHands then
      Exit;

  if CheckCrossing(P1, P3, Soll) then
  begin
    P2 := FindNew(P1, P3, Soll);
    VI := GetPullIndex;
    if not GD[VI].Pulled then
    begin
      SavePulling(VI);
    end
    else
    begin
      Bongo;
      if GD[VI].LineTag <> CurrentLineTag then
        Bingo;
    end;
  end;
end;

function TFederMeshBuilder.FindNew(P1, P2: TPoint3D; Soll: single = 0): TPoint3D;
var
  z: single;
  PA, PB, PT: TPoint3D;
  z1, z2: single;
begin
  z1 := P1.Z;
  z2 := P2.Z;

  if z1 < z2 then
  begin
    PA := P1;
    PB := P2;
  end
  else
  begin
    PA := P2;
    PB := P1;
  end;

  LoopCounter := 0;
  repeat
    Inc(LoopCounter);

    PT := PA + (PB - PA) * 0.5;

    z := ComputeZN(PT);

    if z - Soll < 0 then
      PA := PT
    else
      PB := PT;

  until (Abs(z - Soll) < LoopTarget) or (LoopCounter = LoopMax);

  if LoopCounter = LoopMax then
  begin
    DoLoopPolyTest(P1, P2, Soll);
  end;

  if WantTargetPulling then
    PT.Z := Soll
  else
    PT.Z := z;
  result := PT;
end;

procedure TFederMeshBuilder.GetMeshDataInfo;
begin
  SL.Add('MeshData Info 00');
  SL.Add('');
  AddLoopCounterInfo;
  AddBingoInfo;
  SL.Add('');
  SL_Add(Format('FV.Count = %d', [FV.Count]));
  SL_Add(Format('GD.Count = %d', [GD.Count]));
  SL_Add(Format('QO.Count = %d', [QA.Count]));
  SL_Add(Format('T1.Count = %d', [T1.Count]));
end;

procedure TFederMeshBuilder.GetMeshDataMatrixReport(ML: TStrings; ReportID: Integer);
var
  x, y: Integer;
  s, t: string;
  VI: Integer;
  cr: TVertexState;
begin
  if ReportID = 0 then
  begin
    ML.Add(GetMeshDataName);
    Exit;
  end;

  for y := 0 to vp.mc do
  begin
    s := '';
    for x := 0 to vp.mc do
    begin
      VI := VertexIndex(x, y);
      cr := GD[VI];
      case ReportID of
        1: t := cr.LineTag.ToString;
        2: t := cr.Pulled.ToInteger.ToString;
        3:
        begin
          case cr.PullDirection of
            0: t := '.';
            1: t := 'h';
            2: t := 'v';
            3: t := 'h';
            4: t := 'V';
            else t := '_';
          end;
        end;
        4:
        begin
          case cr.LoopCounter of
            0: t := '.';
            1..9: t := cr.LoopCounter.ToString;
            else t := Char(cr.LoopCounter + Integer('A'));
          end;
        end;
        5: t := cr.QuadCrossings.ToString;
        6:
        begin
          if cr.QuadCrossings > 1 then
            t := cr.QuadCrossings.ToString
          else
            t := '.';
        end;
      end;
      if t = '0' then
        t := '.';
      s := s + t;
    end;
    ML.Add(s);
  end;
end;

function TFederMeshBuilder.GetMeshDataName: string;
begin
  result := 'TFederMeshBuilder';
end;

function TFederMeshBuilder.GetMeshDataReport(ReportID: Integer = 0): string;
begin
  SL.Clear;
  if ReportID = 0 then
    GetMeshDataInfo // always writes to SL
  else
    GetMeshDataMatrixReport(SL, ReportID);
  result := SL.Text;
end;

function TFederMeshBuilder.GetPullIndex: Integer;
begin
  if WantRightPulling then
    result := vi3
  else
    result := vi1;
end;

function TFederMeshBuilder.GetSpecialY: Integer;
var
  Target: single;
  t: single;
  t1, t2: Integer;
  d1, d2: single;
begin
  if vp.msy < 0.0001 then
  begin
    result := -1;
    Exit;
  end;

  Target := vp.EQ.y1;
  t := (Target - vp.sy) / vp.msy;
  t1 := Floor(t);
  t2 := Ceil(t);

  d1 := t - t1;
  d2 := t2 - t;

  if d1 < d2 then
    result := t1
  else
    result := t2;
end;

procedure TFederMeshBuilder.Init2;
var
  x, y: Integer;
  Target: single;
  specialY: Integer;
begin
  Target := vp.EQ.y1;
  specialY := GetSpecialY;

  for y := 0 to vp.mc do
  begin
    v := vp.sy + y * vp.msy;

    if WantSpecialY and (y = specialY) then
      v := Target;

    for x := 0 to vp.mc do
    begin
      u := vp.sx + x * vp.msx;
      InitG(x, y);
    end;
  end;
end;

procedure TFederMeshBuilder.InitData;
begin
  vp.Update;

  UpdateFromMeshParams(vp);

  UpdateFedergraphSize;

  vp.EQ.PrepareCalc;

  UpdateHandArea;

  Init2;
  ResetGD;
  ResetBingoCounter;
  ApplyLimitPulling;
  ApplyVertexPostProcesssing;
  InitTriangles;

  if ReducedMesh then
    Reduce;
  if FlatMesh then
    FlattenToCapValue(vp.CapValue);
end;

procedure TFederMeshBuilder.InitG(x, y: Integer);
var
  VI: Integer;
begin
  if u < vp.EQ.rmin then
    vp.EQ.rmin := u;
  if u > vp.EQ.rmax then
    vp.EQ.rmax := u;

  w := vp.EQ.GetValueN(u, v);
  P.X := u;
  P.Y := v;
  P.Z := w;

  VI := VertexIndex(x, y);
  FV[VI] := P;

  GN[VI] := FV[VI];
end;

procedure TFederMeshBuilder.InitLimits;
var
  h: Single;
begin
  h := Abs(vp.SliceHeight);
  if h < 0.5 then
    h := 0.5;

  if vp.EQ.TakesAbsolute and (h > vp.CapValue) then
    h := vp.CapValue;

  FederLimits.ZeroLimit := Abs(vp.OffsetZ);
  FederLimits.PCapLimit := vp.pcap;
  FederLimits.MCapLimit := vp.mcap;
  FederLimits.SliceLimitP := vp.pcap - h;
  FederLimits.SliceLimitM := vp.mcap + h;

  Limit1 := 0;
  Limit2 := 0;
  Limit3 := 0;
  Limit4 := 0;
  Limit5 := 0;
  LimitCount := 0;

  if WantSlicePulling then
  begin
    case SlicePullingMode of
      0:
      begin
        { faSlicePulling }
        if WantZeroPulling then
        begin
          Limit1 := FederLimits.ZeroLimit;
          Limit2 := FederLimits.PCapLimit;
          Limit3 := FederLimits.MCapLimit;
          Limit4 := FederLimits.SliceLimitP;
          Limit5 := FederLimits.SliceLimitM;
          LimitCount := 5;
        end
        else
        begin
          Limit1 := FederLimits.PCapLimit;
          Limit2 := FederLimits.MCapLimit;
          Limit3 := FederLimits.SliceLimitP;
          Limit4 := FederLimits.SliceLimitM;
          LimitCount := 4;
        end;
      end;
      1:
      begin
        { faSlicePullingTop }
        Limit1 := FederLimits.SliceLimitP;
        Limit2 := FederLimits.SliceLimitM;
        LimitCount := 2;
      end;
      2:
      begin
        { faSlicePullingBottom }
        Limit1 := FederLimits.PCapLimit;
        Limit2 := FederLimits.MCapLimit;
        LimitCount := 2;
      end;
      3:
      begin
        { faSlicePullingCross }
        Limit1 := FederLimits.ZeroLimit;
        Limit2 := FederLimits.PCapLimit;
        Limit3 := FederLimits.MCapLimit;
        LimitCount := 3;
      end;
    end;
  end
  else if WantZeroPulling and not WantLimitPulling then
  begin
    Limit1 := FederLimits.ZeroLimit;
    LimitCount := 1;
  end
  else if WantZeroPulling and WantLimitPulling then
  begin
    Limit1 := FederLimits.ZeroLimit;
    Limit2 := FederLimits.PCapLimit;
    Limit3 := FederLimits.MCapLimit;
    LimitCount := 3;
  end
  else if (not WantZeroPulling) and (WantLimitPulling) then
  begin
    Limit1 := FederLimits.PCapLimit;
    Limit2 := FederLimits.MCapLimit;
    LimitCount := 2;
  end
  else
  begin
    LimitCount := 0;
  end;
end;

procedure TFederMeshBuilder.InitQuads;
var
  x, y: Integer;
  i, j: Integer;
  vq: TVertexQuad;
begin
  QA.Clear;
  for y := 0 to vp.mc - 1 do
  begin
    vq.Y := y;
    for x := 0 to vp.mc - 1 do
    begin
      vq.X := x;

      { get 4 adjacent points }
      i :=  y      * (vp.mc+1) + x;
      j := (y + 1) * (vp.mc+1) + x;

      { A0 A1 }
      { A3 A2 }

      vq.A0 := i;
      vq.A1 := i+1;
      vq.A2 := j+1;
      vq.A3 := j;

      vq.ClearAdjacent;

      QA.Add(vq);
    end;
  end;
  NominalQuadCount := QA.Count;
end;

procedure TFederMeshBuilder.InitTE;
begin
  te1 := vp.te1;
  te2 := vp.te2;
end;

procedure TFederMeshBuilder.InitTriangles;
var
  ti: Integer;
  vq: TVertexQuad;
begin
  ti := 0;
  for vq in QA do
  begin
      ti := UpdateTrianglesQA(ti, vq);
  end;
end;

function TFederMeshBuilder.IsInHandFlippedArea(i: Integer): Boolean;
var
  p: TPointF;
begin
  p := TPointF.Create(FV[i].X, FV[i].Y);
  result := R1.Contains(p) or R2.contains(p);
end;

procedure TFederMeshBuilder.Normalize(f: single);
var
  mx, nx: single;
  my, ny: single;
  mz, nz: single;
  i: Integer;
  cr: TPoint3D;
begin
  GetMinMax;

  mx := xmax - xmin;
  nx := xmin + mx / 2;

  my := ymax - ymin;
  ny := ymin + my / 2;

  mz := zmax - zmin;
  nz := zmin + mz / 2;

  if abs(mx) < Epsilon then
    mx := Epsilon;
  if abs(my) < Epsilon then
    my := Epsilon;
  if abs(mz) < Epsilon then
    mz := Epsilon;

  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    cr.X := (cr.X - nx) * f / mx;
    cr.Y := (cr.Y - ny) * f / my;
    cr.Z := (cr.Z - nz) * f / mz;
    FV[i] := cr;
  end;
end;

procedure TFederMeshBuilder.NormalizeRelative(f: single);
var
  mx, nx: single;
  my, ny: single;
  mz, nz: single;
  m: single;
  i: Integer;
  cr: TPoint3D;
begin
  GetMinMax;

  mx := xmax - xmin;
  nx := xmin + mx / 2;

  my := ymax - ymin;
  ny := ymin + my / 2;

  mz := zmax - zmin;
  nz := zmin + mz / 2;

  m := mx;
  if my > m then
    m := my;
  if mz > m then
    m := mz;

  if abs(m) < 1 then
    m := 1;

  for i := 0 to FV.Count - 1 do
  begin
    cr := FV[i];
    cr.X := (cr.X - nx) * f / m;
    cr.Y := (cr.Y - ny) * f / m;
    cr.Z := (cr.Z - nz) * f / m;
    FV[i] := cr;
  end;
end;

procedure TFederMeshBuilder.ResetGD;
var
  i: Integer;
  cr: TVertexState;
begin
  for i := 0 to GD.Count - 1 do
  begin
    cr := GD[i];
    cr.Clear;
    GD[i] := cr;
  end;
end;

procedure TFederMeshBuilder.SavePulling(VI: Integer);
var
  cr: TVertexState;
begin
  { update pulled vertex }
  FV[VI] := P2;

  { store meta-data for pulled vertex }
  cr := GD[VI];
  cr.LineTag := CurrentLineTag;
  cr.PullDirection := CurrentPullDirection;
  cr.Pulled := True;
  if VI = vi1 then
    cr.PulledLeft := True
  else if VI = vi3 then
    cr.PulledRight := True;
  cr.LoopCounter := LoopCounter;
  GD[VI] := cr;
end;

procedure TFederMeshBuilder.SetLoopFaktor(const Value: single);
var
  t: single;
begin
  t := DefaultLoopTarget + Value * 0.001;
  if t >= LoopTargetMin then
  begin
    LoopTarget := t;
    FLoopFaktor := LoopTarget;
  end
  else
  begin
    LoopTarget := LoopTargetMin;
    FLoopFaktor := LoopTarget;
  end;
end;

function TFederMeshBuilder.SkipFlippedHands: Boolean;
var
  pf1, pf2: TPointF;
begin
  result := False;
  if WantFlippedHands then
  begin
    pf1 := TPointF.Create(P1.X, P1.Y);
    pf2 := TPointF.Create(P3.X, P3.Y);
    result :=
      R1.Contains(pf1) or
      R2.Contains(pf1) or
      R1.Contains(pf2) or
      R2.Contains(pf2);
  end;
end;

procedure TMeshBuilder.Update3DBuffers(VB: TVertexBuffer; IB: TIndexBuffer);
begin
  UV.Clear;

  inherited;
end;

procedure TFederMeshBuilder.Update3DBuffers(VB: TVertexBuffer; IB: TIndexBuffer);
begin
  UV.Clear;

  if vp.WantLux and WantUniqueVertices then
  begin
    MakeUniqueVertices;
  end;

  UpdateVB(VB);

  UpdateTE(VB);

  UpdateIB(IB);

  VertexCount := FV.Count;
end;

procedure TFederMeshBuilder.UpdateFedergraphSize;
var
  vc, ic: Integer;
  CountV, CountI: Integer;
begin
  CountV := sqr(vp.mc + 1);
  CountI := sqr(vp.mc);

  vc := CountV;
  ic := CountI * 2;

  UpdateSize(vc, ic);
end;

procedure TFederMeshBuilder.UpdateFromMeshParams(vp: TMeshParams);
begin
  WantUpdateTE := True;
  WantTexCoord := False;

  WantFlippedHands := vp.WantFlippedHands;
  WantMirroredBottom := vp.WantMirroredBottom;
  IsFlippedHand := WantFlippedHands;
  OuterOptionZ := vp.OuterOptionZ;

  WantUniqueVertices := vp.WantUniqueVertices;
  UniqueMode := vp.UniqueMode;

  ReducedMesh := vp.ReducedMesh;
  ReduceMode := vp.ReduceMode;

  WantZeroPulling := vp.WantZeroPulling;
  SlicePullingMode := vp.SlicePullingMode;

  CapValue := vp.CapValue;
  SliceHeight := vp.SliceHeight;

  te1 := vp.te1;
  te2 := vp.te2;
end;

procedure TFederMeshBuilder.UpdateHandArea;
begin
  PolyRack.Compute;
end;

procedure TFederMeshBuilder.UpdateSize(VBL, IBL: Integer);
var
  vertexArray: array of TPoint3D;
  vertexStateArray: array of TVertexState;
  triangleIndexArray: array of Integer;
begin
  if VBL <> VertexCount then
  begin
    SetLength(vertexArray, VBL);
    FV.Clear;
    FV.AddRange(vertexArray);

    SetLength(vertexArray, VBL);
    GN.Clear;
    GN.AddRange(vertexArray);

    SetLength(vertexStateArray, VBL);
    GD.Clear;
    GD.AddRange(vertexStateArray);

    InitQuads;
  end;

  if IBL <> TriangleCount then
  begin
    SetLength(triangleIndexArray, IBL);
    T1.Clear;
    T2.Clear;
    T3.Clear;
    T1.AddRange(triangleIndexArray);
    T2.AddRange(triangleIndexArray);
    T3.AddRange(triangleIndexArray);
  end;

  VertexCount := VBL;
  TriangleCount := IBL;
end;

function TFederMeshBuilder.UpdateTrianglesQA(NI: Integer; vq: TVertexQuad): Integer;
begin
      T1[NI] := vq.A1;
      T2[NI] := vq.A2;
      T3[NI] := vq.A3;
      T1[NI+1] := vq.A3;
      T2[NI+1] := vq.A0;
      T3[NI+1] := vq.A1;
      result := NI + 2;
end;

procedure TFederMeshBuilder.UpdateVB(VB: TVertexBuffer);
var
  i: Integer;
  p: TPoint3D;
begin
  VB.Length := FV.Count;

  { 1. Assign Vertices }
  for i := 0 to FV.Count - 1 do
  begin
    p := FV[i];
    case OuterOptionZ of
      TVertexOptionZ.Normal: ;
      TVertexOptionZ.FlatBottom: p.Z := vp.CapValue;
      TVertexOptionz.MirroredBottom: p.Z := vp.CapValue + (vp.CapValue - p.Z);
    end;
    VB.Vertices[i] := p;
  end;
end;

function TFederMeshBuilder.VertexIndex(x, y: Integer): Integer;
begin
  result := y * (vp.mc + 1) + x;
end;

end.
