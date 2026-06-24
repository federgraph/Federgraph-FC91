unit RiggVar.Mesh.Stitcher;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Math.Vectors,
  System.Generics.Defaults,
  System.Generics.Collections,
  System.Hash,
  RiggVar.FB.DefConst;

type
  TMeshVisitor = class
  public
    procedure AddObjectName(s: string); virtual; abstract;
    procedure AddMaterialName(s: string); virtual; abstract;

    procedure AddVertex(P: TPoint3D); virtual; abstract;
    procedure AddTriangle(i1, i2, i3: Integer); virtual; abstract;
  end;

  TPartInfo = record
    ID: Integer;
    ObjectName: string;
    MaterialName: string;
    FirstTriangleIndex: Integer;
    procedure Clear;
  end;

  TStitcherVertex = record
  public
    OriginalPoint: TPoint3D;
    OriginalIndex: Integer;
    UniqueIndex: Integer;
    UsedIndex: Integer;
    IsUnique: Boolean;
    IsUsed: Boolean;
    X: Int64;
    Y: Int64;
    Z: Int64;
    function StitchedPoint: TPoint3D;
    constructor Create(AVertex: TPoint3D);
    class operator Equal(const APoint1, APoint2: TStitcherVertex): Boolean; inline;
    class operator NotEqual(const APoint1, APoint2: TStitcherVertex): Boolean; inline;
    function EqualsTo(const APoint: TStitcherVertex): Boolean; inline;
  end;

  TStitcherVertexComparer = class(TInterfacedObject, IEqualityComparer<TStitcherVertex>)
  public
    function Equals(const Left, Right: TStitcherVertex): Boolean; reintroduce;
    function GetHashCode(const Value: TStitcherVertex): Integer; reintroduce;
  end;

  TStitcherTriangle = record
  public
    i1: Integer;
    i2: Integer;
    i3: Integer;

    T1: Integer;
    T2: Integer;
    T3: Integer;
    constructor Create(i1, i2, i3: Integer);
  end;

  TStitcherVertices = TList<TStitcherVertex>;
  TStitcherTriangles = TList<TStitcherTriangle>;
  TPartInfoList = TList<TPartInfo>;

  TUniqueVertices = TDictionary<TStitcherVertex, Integer>;
  TUniqueIndices = TDictionary<Integer, TStitcherVertex>;
  TVertexLookup = TDictionary<Integer, Integer>;

  TFederStitcher = class(TMeshVisitor)
  private
    FNewIndexLookup: TVertexLookup;
    FOutIndexLookup: TVertexLookup;
    FUsedIndices: TList<Integer>;

    FVertexComparer: IEqualityComparer<TStitcherVertex>;
    FPartInfo: TPartInfo;
    FPartInfoList: TPartInfoList;

    OriginalVertexCount: Integer;
    NewVertexCount: Integer;
    UsedVertexCount: Integer;
    DegeneratedTriangleCount: Integer;

    AllVertices: TStitcherVertices;
    UniqueVertices: TUniqueVertices;

    function GetVertexFormatString: string;
  protected
    KeptTriangles: TStitcherTriangles;
  public
    Verbose: Boolean;
    UniqueIndices: TUniqueIndices;

    class var
    DigitScale: Integer;
    InitialCapacity: Integer;

    WantVerboseMeta: Boolean;

    class constructor Create;
    constructor Create;
    destructor Destroy; override;

    procedure Clear; virtual;

    procedure AddObjectName(s: string); override;
    procedure AddMaterialName(s: string); override;
    procedure AddVertex(P: TPoint3D); override;
    procedure AddTriangle(i1, i2, i3: Integer); override;

    procedure NextPart;

    procedure UpdateML(ML: TStrings);
    procedure AddStats(ML: TStrings); virtual;
  end;

implementation

{ TFederStitcher }

class constructor TFederStitcher.Create;
begin
  WantVerboseMeta := False;
  InitialCapacity := 100000;
  DigitScale := 100;
end;

constructor TFederStitcher.Create;
begin
  FVertexComparer := TStitcherVertexComparer.Create;

  AllVertices := TStitcherVertices.Create;
  KeptTriangles := TStitcherTriangles.Create;
  FPartInfoList := TPartInfoList.Create;
  FPartInfo.Clear;

  UniqueVertices := TUniqueVertices.Create(InitialCapacity, FVertexComparer);
  UniqueIndices := TUniqueIndices.Create(InitialCapacity);
  FNewIndexLookup := TVertexLookup.Create(InitialCapacity);
  FOutIndexLookup := TVertexLookup.Create(InitialCapacity);
  FUsedIndices := TList<Integer>.Create;
end;

destructor TFederStitcher.Destroy;
begin
  AllVertices.Free;
  KeptTriangles.Free;
  UniqueVertices.Free;
  UniqueIndices.Free;
  FNewIndexLookup.Free;
  FOutIndexLookup.Free;
  FPartInfoList.Free;
  FUsedIndices.Free;
  inherited;
end;

function TFederStitcher.GetVertexFormatString: string;
var
  temp: string;
begin
  case DigitScale of
    100000: temp := '%s%d.%5.5d';
    10000: temp := '%s%d.%4.4d';
    1000: temp := '%s%d.%3.3d';
    100: temp := '%s%d.%2.2d';
    10: temp := '%s%d.%1.1d';
  end;
  result := 'v' + temp + temp + temp;
end;

procedure TFederStitcher.Clear;
begin
  FPartInfo.Clear;
  FPartInfoList.Clear;
  FNewIndexLookup.Clear;
  FOutIndexLookup.Clear;
  FUsedIndices.Clear;
  UniqueVertices.Clear;
  UniqueIndices.Clear;
  AllVertices.Clear;
  KeptTriangles.Clear;

  OriginalVertexCount := 0;
  NewVertexCount := 0;
  UsedVertexCount := 0;
  DegeneratedTriangleCount := 0;
end;

procedure TFederStitcher.NextPart;
begin
  FPartInfoList.Add(FPartInfo);
  FPartInfo.ID := FPartInfoList.Count;
  FPartInfo.FirstTriangleIndex := KeptTriangles.Count;
  FPartInfo.ObjectName := 'Part ' + IntToStr(FPartInfo.ID);
  FPartInfo.MaterialName := 'White';
end;

procedure TFederStitcher.AddObjectName(s: string);
begin
  FPartInfo.ObjectName := s;
end;

procedure TFederStitcher.AddMaterialName(s: string);
begin
  FPartInfo.MaterialName := s;
end;

procedure TFederStitcher.AddStats(ML: TStrings);
begin
  ML.Add('');
  ML.Add('--- TFederStitcher.AddStats');
  ML.Add('');
  ML.Add(Format('AllVertices.Count = %d', [AllVertices.Count]));
  ML.Add(Format('KeptTriangles.Count = %d', [KeptTriangles.Count]));

  if Verbose then
  begin
    ML.Add(Format('UniqueVertices.Count = %d', [UniqueVertices.Count]));
    ML.Add(Format('UniqueIndices.Count = %d', [UniqueIndices.Count]));
    ML.Add(Format('NewIndexLookup.Count = %d', [FNewIndexLookup.Count]));
    ML.Add(Format('OriginalVertexCount = %d', [OriginalVertexCount]));
    ML.Add(Format('NewVertexCount = %d', [NewVertexCount]));
  end;

  ML.Add(Format('VertexCount Diff = %d', [OriginalVertexCount - NewVertexCount]));
  ML.Add(Format('DegeneratedTriangleCount = %d', [DegeneratedTriangleCount]));
end;

procedure TFederStitcher.AddVertex(P: TPoint3D);
var
  v: TStitcherVertex;
  NewIndex: Integer;
begin
  v := TStitcherVertex.Create(P);

  v.OriginalIndex := OriginalVertexCount;
  Inc(OriginalVertexCount);

  if UniqueVertices.ContainsKey(v) then
  begin
    UniqueVertices.TryGetValue(v, NewIndex);
    v.UniqueIndex := NewIndex;
    v.IsUnique := False;
  end
  else
  begin
    v.IsUnique := True;
    v.UniqueIndex := NewVertexCount;
    Inc(NewVertexCount);
    UniqueVertices.Add(v, v.UniqueIndex);
    UniqueIndices.Add(v.UniqueIndex, v);
  end;

  FNewIndexLookup.Add(v.OriginalIndex, v.UniqueIndex);
  AllVertices.Add(v);
end;

procedure TFederStitcher.AddTriangle(i1, i2, i3: Integer);
var
  t: TStitcherTriangle;
begin
  t := TStitcherTriangle.Create(i1, i2, i3);
  FNewIndexLookup.TryGetValue(i1, t.T1);
  FNewIndexLookup.TryGetValue(i2, t.T2);
  FNewIndexLookup.TryGetValue(i3, t.T3);

  { filter out degenerated triangles }
  if (t.T1 = t.T2) or (t.T2 = t.T3) or (T.T3 = t.T1) then
  begin
    Inc(DegeneratedTriangleCount);
  end
  else
    KeptTriangles.Add(t);
end;

procedure TFederStitcher.UpdateML(ML: TStrings);
const
  fsf = 'f %d %d %d';
var
  i: Integer;
  v: TStitcherVertex;
  t: TStitcherTriangle;
  IsNegativeX: Boolean;
  IsNegativeY: Boolean;
  IsNegativeZ: Boolean;
  Vorzeichen: array[Boolean] of string;
  fsv: string;

  j: Integer;
  b1: Boolean;
  b2: Boolean;
  b3: Boolean;
  b: Boolean;
  t1: Integer;
  t2: Integer;
  t3: Integer;
begin
  if FPartInfoList.Count > 0 then
    FPartInfo := FPartInfoList[0];

  fsv := GetVertexFormatString;

  ML.Add('mtllib federgraph-material.mtl');

  if FPartInfo.ObjectName <> '' then
    ML.Add(Format('o %s', [FPartInfo.ObjectName]));

  Vorzeichen[False] := ' ';
  Vorzeichen[True] := ' -';

  j := 0;
  for i := 0 to KeptTriangles.Count - 1 do
  begin
    t := KeptTriangles[i];

    t1 := t.T1;
    b := UniqueIndices.TryGetValue(t1, v);
    Assert(b);
    if not v.IsUsed then
    begin
      v.IsUsed := True;
      v.UsedIndex := j;
      UniqueIndices.AddOrSetValue(t1, v);
      FUsedIndices.Add(t1);
      if not FOutIndexLookup.ContainsKey(t1) then
      begin
        FOutIndexLookup.Add(t1, j);
      end;
      Inc(j);
    end;

    t2 := t.T2;
    b := UniqueIndices.TryGetValue(t2, v);
    Assert(b);
    if not v.IsUsed then
    begin
      v.IsUsed := True;
      v.UsedIndex := j;
      UniqueIndices.AddOrSetValue(t2, v);
      FUsedIndices.Add(t2);
      if not FOutIndexLookup.ContainsKey(t2) then
      begin
        FOutIndexLookup.Add(t2, j);
      end;
      Inc(j);
    end;

    t3 := t.T3;
    b := UniqueIndices.TryGetValue(t3, v);
    Assert(b);
    if not v.IsUsed then
    begin
      v.IsUsed := True;
      v.UsedIndex := j;
      UniqueIndices.AddOrSetValue(t3, v);
      FUsedIndices.Add(t3);
      if not FOutIndexLookup.ContainsKey(t3) then
      begin
        FOutIndexLookup.Add(t3, j);
      end;
      Inc(j);
    end;
  end;

  for i := 0 to FUsedIndices.Count - 1 do
  begin
    v := UniqueIndices[FUsedIndices[i]];

    Assert(v.IsUsed);

    IsNegativeX := v.X < 0;
    IsNegativeY := v.Y < 0;
    IsNegativeZ := v.Z < 0;

    ML.Add(Format(fsv, [
      Vorzeichen[IsNegativeX], Abs(v.X) div DigitScale, Abs(v.X) mod DigitScale,
      Vorzeichen[IsNegativeY], Abs(v.Y) div DigitScale, Abs(v.Y) mod DigitScale,
      Vorzeichen[IsNegativeZ], Abs(v.Z) div DigitScale, Abs(v.Z) mod DigitScale
      ]));
  end;

  ML.Add('');

  for i := 0 to KeptTriangles.Count - 1 do
  begin
    if FPartInfo.FirstTriangleIndex = i then
    begin
      if FPartInfo.MaterialName <> '' then
        ML.Add(Format('usemtl %s', [FPartInfo.MaterialName]));
      if FPartInfoList.Count > FPartInfo.ID + 1 then
        FPartInfo := FPartInfoList[FPartInfo.ID + 1];
    end;

    t := KeptTriangles[i];

    b1 := FOutIndexLookup.TryGetValue(t.T1, t1);
    b2 := FOutIndexLookup.TryGetValue(t.T2, t2);
    b3 := FOutIndexLookup.TryGetValue(t.T3, t3);
    b := b1 and b2 and b3;
    Assert(b);

    { + 1 because triangle indices in .obj format are one-based }
    ML.Add(Format(fsf, [t1 + 1, t2 + 1, t3 + 1]));
  end;
end;

{ TStitcherTriangle }

constructor TStitcherTriangle.Create(i1, i2, i3: Integer);
begin
  { original info will not change }
  Self.i1 := i1;
  Self.i2 := i2;
  Self.i3 := i3;

  { will be updated in TFederStitcher.AddTriangle() }
  T1 := i1;
  T2 := i2;
  T3 := i3;
end;

{ TStitcherVertex }

constructor TStitcherVertex.Create(AVertex: TPoint3D);
begin
  OriginalPoint := AVertex;

  X := Round(AVertex.X * TFederStitcher.DigitScale);
  Y := Round(AVertex.Y * TFederStitcher.DigitScale);
  Z := Round(AVertex.Z * TFederStitcher.DigitScale);

  OriginalIndex := -1;
  UniqueIndex := -1;
  UsedIndex := -1;
  IsUnique := False;
  IsUsed := False;
end;

class operator TStitcherVertex.Equal(const APoint1, APoint2: TStitcherVertex): Boolean;
begin
  result :=
    (APoint1.X = APoint2.X) and
    (APoint1.Y = APoint2.Y) and
    (APoint1.Z = APoint2.Z);
end;

class operator TStitcherVertex.NotEqual(const APoint1,
  APoint2: TStitcherVertex): Boolean;
begin
  result := not (APoint1 = APoint2);
end;

function TStitcherVertex.StitchedPoint: TPoint3D;
begin
  result.X := X / TFederStitcher.DigitScale;
  result.Y := Y / TFederStitcher.DigitScale;
  result.Z := Z / TFederStitcher.DigitScale;
end;

function TStitcherVertex.EqualsTo(const APoint: TStitcherVertex): Boolean;
begin
  Result := (X = APoint.X) and (Y = APoint.Y) and (Z = APoint.Z);
end;

{ TStitcherVertexComparer }

function TStitcherVertexComparer.Equals(const Left, Right: TStitcherVertex): Boolean;
begin
  result := Left = Right;
end;

function TStitcherVertexComparer.GetHashCode(const Value: TStitcherVertex): Integer;
begin
  result := THashBobJenkins.GetHashValue(Value.X, SizeOf(Integer), 0);
  result := THashBobJenkins.GetHashValue(Value.Y, SizeOf(Integer), result);
  result := THashBobJenkins.GetHashValue(Value.Z, SizeOf(Integer), result);
end;

{ TPartInfo }

procedure TPartInfo.Clear;
begin
  ID := 0;
  ObjectName := '';
  MaterialName := '';
  FirstTriangleIndex := 0;
end;

end.
