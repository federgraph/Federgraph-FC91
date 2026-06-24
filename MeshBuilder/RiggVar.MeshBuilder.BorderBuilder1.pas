unit RiggVar.MeshBuilder.BorderBuilder1;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Math,
  System.Math.Vectors,
  System.Generics.Defaults,
  System.Generics.Collections,
  FMX.Types,
  FMX.Types3D,
  RiggVar.FB.Def,
  RiggVar.FB.MeshParams,
  RiggVar.Mesh.Stitcher,
  RiggVar.Mesh.MeshBuilder,
  RiggVar.MeshBuilder.BorderBuilder;

type
  TBorderBuilder1 = class(TFederStitcher)
  private
    EdgeComparer1: IComparer<TTriangleEdge>;
    EdgeComparer2: IEqualityComparer<TTriangleEdge>;

    AllEdges: TEdgeList;
    TempEdges: TEdgeList;

    StartIndexType: TStartIndexType;
    StartEdgeIndex: Integer;
    NextCounter: Integer;
    PrevCounter: Integer;

    FCapValue: single;

    BorderPositionN: single;
    BorderPositionS: single;
    BorderPositionW: single;
    BorderPositionE: single;

    procedure InitTempEdges(UnsortedEdges: TEdgeList);
    function AddNextEdge(LastIndex2: Integer): Boolean;
    function AddPrevEdge(LastIndex1: Integer): Boolean;
    procedure InitBorderPolygon(AEdgePart: TEdgePart; var ABorderPoly: TPolygon);
  public
    LogList: TStringList;
    Problems: TBorderBuilderProblems;

    UniqueEdges: TEdgeDictionary;
    SortedEdges: TEdgeList;

    Flatten: Boolean;
    Mirror: Boolean;

    BorderArray: TPoint3DArray;
    BorderPoly: TPolygon;

    BorderEdgesNorth: TEdgeList;
    BorderEdgesSouth: TEdgeList;
    BorderEdgesWest: TEdgeList;
    BorderEdgesEast: TEdgeList;

    BorderPolyNorth: TPolygon;
    BorderPolySouth: TPolygon;
    BorderPolyWest: TPolygon;
    BorderPolyEast: TPolygon;

    BorderArrayNW: TPoint3DArray;
    BorderArrayNE: TPoint3DArray;
    BorderArraySW: TPoint3DArray;
    BorderArraySE: TPoint3DArray;

    BorderArrayWest: TPoint3DArray;
    BorderArrayEast: TPoint3DArray;

    constructor Create;
    destructor Destroy; override;

    procedure Clear; override;
    procedure AddStats(ML: TStrings); override;

    procedure PrepareEdges(MB: TMeshBuilderBase; ACapValue: single);

    procedure FindStartEdgeXMin(EL: TEdgeList);
    procedure FindStartEdgeXMax(EL: TEdgeList);
    procedure FindStartEdgeYMax(EL: TEdgeList);
    procedure FindStartEdgeYMin(EL: TEdgeList);

    function GetStartEdgeXMin: TTriangleEdge;
    function GetStartEdgeXMax: TTriangleEdge;
    function GetStartEdgeYMin: TTriangleEdge;
    function GetStartEdgeYMax: TTriangleEdge;

    procedure FindBorderX(BorderEdges: TEdgeList; AX: single);
    procedure FindBorderY(BorderEdges: TEdgeList; AY: single);
    procedure FindBorderNorth(AY: single);
    procedure FindBorderSouth(AY: single);
    procedure FindBorderWest(AX: single);
    procedure FindBorderEast(AX: single);

    procedure InitEdges;
    procedure InitBorderEdges(AZ: single);
    procedure InitSortedEdges(UnsortedEdges: TEdgeList);
    procedure InitBorderArray;

    procedure InitBorderArrayNorthAndSouth;
    procedure InitBorderArrayWestAndEast;
    procedure InitBorderPoints(AEdgePart: TEdgePart);

    procedure InitBorderPolygons;
    property CapValue: single read FCapValue write FCapValue;
  end;

implementation

uses
  RiggVar.App.Main;

{ TBorderBuilder1 }

constructor TBorderBuilder1.Create;
begin
  inherited;

  LogList := TStringList.Create;

  EdgeComparer1 := TTriangleEdgeComparer1.Create;
  EdgeComparer2 := TTriangleEdgeComparer2.Create;

  AllEdges := TEdgeList.Create(EdgeComparer1);
  UniqueEdges := TEdgeDictionary.Create(InitialCapacity, EdgeComparer2);
  TempEdges := TEdgeList.Create(EdgeComparer1);
  SortedEdges := TEdgeList.Create(EdgeComparer1);

  BorderEdgesWest := TEdgeList.Create(EdgeComparer1);
  BorderEdgesEast := TEdgeList.Create(EdgeComparer1);

  BorderEdgesNorth := TEdgeList.Create(EdgeComparer1);
  BorderEdgesSouth := TEdgeList.Create(EdgeComparer1);
end;

destructor TBorderBuilder1.Destroy;
begin
  BorderEdgesNorth.Free;
  BorderEdgesSouth.Free;

  BorderEdgesWest.Free;
  BorderEdgesEast.Free;

  SortedEdges.Free;
  TempEdges.Free;
  AllEdges.Free;
  UniqueEdges.Free;
  LogList.Free;

  inherited;
end;

procedure TBorderBuilder1.Clear;
begin
  inherited;

  AllEdges.Clear;
  UniqueEdges.Clear;
  TempEdges.Clear;
  SortedEdges.Clear;

  BorderEdgesNorth.Clear;
  BorderEdgesSouth.Clear;
  BorderEdgesWest.Clear;
  BorderEdgesEast.Clear;
end;

procedure TBorderBuilder1.InitEdges;
var
  e1, e2, e3: TTriangleEdge;
  Index1, Index2, Index3: Integer;
  i: Integer;
  t: TStitcherTriangle;
begin
  for i := 0 to KeptTriangles.Count - 1 do
  begin
    t := KeptTriangles[i];

    e1 := TTriangleEdge.Create(t.T1, t.T2);
    e2 := TTriangleEdge.Create(t.T2, t.T3);
    e3 := TTriangleEdge.Create(t.T3, t.T1);

    Index1 := AllEdges.Add(e1);
    Index2 := AllEdges.Add(e2);
    Index3 := AllEdges.Add(e3);

    if not UniqueEdges.ContainsKey(e1) then
      UniqueEdges.Add(e1, Index1);

    if not UniqueEdges.ContainsKey(e2) then
      UniqueEdges.Add(e2, Index2);

    if not UniqueEdges.ContainsKey(e3) then
      UniqueEdges.Add(e3, Index3);
  end;
end;

procedure TBorderBuilder1.InitTempEdges(UnsortedEdges: TEdgeList);
var
  i: Integer;
begin
  TempEdges.Clear;
  for i := 0 to UnsortedEdges.Count - 1 do
    TempEdges.Add(UnsortedEdges[i]);
end;

procedure TBorderBuilder1.InitSortedEdges(UnsortedEdges: TEdgeList);
var
  cr: TTriangleEdge;
  b: Boolean;
begin
  if UnsortedEdges.Count = 0 then
    Exit;

  InitTempEdges(UnsortedEdges);
  Assert(UnsortedEdges.Count = TempEdges.Count);

  if (StartEdgeIndex >= 0) and (StartEdgeIndex < TempEdges.Count) then
  begin
    case StartIndexType of
      MinX: cr := GetStartEdgeXMin;
      MaxX: cr := GetStartEdgeXMax;
      MinY: cr := GetStartEdgeYMin;
      MaxY: cr := GetStartEdgeYMax;
      else cr := TempEdges[0];
    end;
  end
  else
  begin
    StartEdgeIndex := 0;
    cr := TempEdges[0];
  end;

  if (StartEdgeIndex > TempEdges.Count - 1) or (StartEdgeIndex < 0) then
  begin
    Include(Problems, problem_CannotDeleteFromTempEdges);
    Exit;
  end;

  SortedEdges.Add(cr);
  TempEdges.Delete(StartEdgeIndex);

  cr := SortedEdges.Last;
  b := True;
  while b do
  begin
    b := AddNextEdge(cr.Index2);
    if b then
    begin
      cr := SortedEdges.Last;
    end;
  end;
  NextCounter := SortedEdges.Count;

  cr := SortedEdges.First;
  b := True;
  while b do
  begin
    b := AddPrevEdge(cr.Index1);
    if b then
    begin
      cr := SortedEdges.First;
    end;
  end;
  PrevCounter := SortedEdges.Count - NextCounter;
end;

function TBorderBuilder1.AddNextEdge(LastIndex2: Integer): Boolean;
var
  i: Integer;
  e, cr: TTriangleEdge;
begin
  result := False;
  for i := 0 to TempEdges.Count - 1 do
  begin
    e := TempEdges[i];
    if (e.Index1 = LastIndex2) then
    begin
      SortedEdges.Add(e);

      TempEdges.Delete(i);
      result := True;
      break;
    end
    else if (e.Index2 = LastIndex2) then
    begin
      cr.Index1 := e.Index2;
      cr.Index2 := e.Index1;

      SortedEdges.Add(cr);

      TempEdges.Delete(i);
      result := True;
      break;
    end;
  end;
end;

function TBorderBuilder1.AddPrevEdge(LastIndex1: Integer): Boolean;
var
  i: Integer;
  e, cr: TTriangleEdge;
begin
  result := False;
  for i := 0 to TempEdges.Count - 1 do
  begin
    e := TempEdges[i];
    if (e.Index2 = LastIndex1) then
    begin
      SortedEdges.Insert(0, e);

      TempEdges.Delete(i);
      result := True;
      break;
    end
    else if (e.Index1 = LastIndex1) then
    begin
      cr.Index1 := e.Index2;
      cr.Index2 := e.Index1;

      SortedEdges.Insert(0, cr);

      TempEdges.Delete(i);
      result := True;
      break;
    end;
  end;
end;

procedure TBorderBuilder1.FindStartEdgeYMax(EL: TEdgeList);
var
  maxY: Integer;
  maxEdgeIndex: Integer;
  i: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  maxY := -MaxInt;
  maxEdgeIndex := 0;
  for i := 0 to EL.Count - 1 do
  begin
    e := EL[i];
    UniqueIndices.TryGetValue(e.Index1, v1);
    UniqueIndices.TryGetValue(e.Index2, v2);
    if v1.Y > maxY then
    begin
      maxY := v1.Y;
      maxEdgeIndex := i;
    end;
    if v2.Y > maxY then
    begin
      maxY := v2.Y;
      maxEdgeIndex := i;
    end;
  end;
  StartEdgeIndex := maxEdgeIndex;
  StartIndexType := TStartIndexType.MaxY;
end;

procedure TBorderBuilder1.FindStartEdgeYMin(EL: TEdgeList);
var
  minY: Integer;
  minEdgeIndex: Integer;
  i: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  minY := MaxInt;
  minEdgeIndex := 0;
  for i := 0 to EL.Count - 1 do
  begin
    e := EL[i];
    UniqueIndices.TryGetValue(e.Index1, v1);
    UniqueIndices.TryGetValue(e.Index2, v2);
    if v1.Y < minY then
    begin
      minY := v1.Y;
      minEdgeIndex := i;
    end;
    if v2.Y < minY then
    begin
      minY := v2.Y;
      minEdgeIndex := i;
    end;
  end;
  StartEdgeIndex := minEdgeIndex;
  StartIndexType := TStartIndexType.MinY;
end;

procedure TBorderBuilder1.FindStartEdgeXMin(EL: TEdgeList);
var
  minX: Integer;
  minEdgeIndex: Integer;
  i: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  minX := MaxInt;
  minEdgeIndex := 0;
  for i := 0 to EL.Count - 1 do
  begin
    e := EL[i];
    UniqueIndices.TryGetValue(e.Index1, v1);
    UniqueIndices.TryGetValue(e.Index2, v2);
    if v1.X < minX then
    begin
      minX := v1.X;
      minEdgeIndex := i;
    end;
    if v2.X < minX then
    begin
      minX := v2.X;
      minEdgeIndex := i;
    end;
  end;
  StartEdgeIndex := minEdgeIndex;
  StartIndexType := TStartIndexType.MinX;
end;

procedure TBorderBuilder1.FindStartEdgeXMax(EL: TEdgeList);
var
  maxX: Integer;
  maxEdgeIndex: Integer;
  i: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  maxX := -MaxInt;
  maxEdgeIndex := 0;
  for i := 0 to EL.Count - 1 do
  begin
    e := EL[i];
    UniqueIndices.TryGetValue(e.Index1, v1);
    UniqueIndices.TryGetValue(e.Index2, v2);
    if v1.X > maxX then
    begin
      maxX := v1.X;
      maxEdgeIndex := i;
    end;
    if v2.X > maxX then
    begin
      maxX := v2.X;
      maxEdgeIndex := i;
    end;
  end;
  StartEdgeIndex := maxEdgeIndex;
  StartIndexType := TStartIndexType.MaxX;
end;

function TBorderBuilder1.GetStartEdgeYMin: TTriangleEdge;
var
  temp: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  e := TempEdges[StartEdgeIndex];
  UniqueIndices.TryGetValue(e.Index1, v1);
  UniqueIndices.TryGetValue(e.Index2, v2);
  if v1.Y > v2.Y then
  begin
    temp := e.Index1;
    e.Index1 := e.Index2;
    e.Index2 := temp;
  end;
  result := e;
end;

function TBorderBuilder1.GetStartEdgeYMax: TTriangleEdge;
var
  temp: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  e := TempEdges[StartEdgeIndex];
  UniqueIndices.TryGetValue(e.Index1, v1);
  UniqueIndices.TryGetValue(e.Index2, v2);
  if v1.Y < v2.Y then
  begin
    temp := e.Index1;
    e.Index1 := e.Index2;
    e.Index2 := temp;
  end;
  result := e;
end;

function TBorderBuilder1.GetStartEdgeXMin: TTriangleEdge;
var
  temp: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  e := TempEdges[StartEdgeIndex];
  UniqueIndices.TryGetValue(e.Index1, v1);
  UniqueIndices.TryGetValue(e.Index2, v2);
  if v1.X > v2.X then
  begin
    temp := e.Index1;
    e.Index1 := e.Index2;
    e.Index2 := temp;
  end;
  result := e;
end;

function TBorderBuilder1.GetStartEdgeXMax: TTriangleEdge;
var
  temp: Integer;
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
begin
  e := TempEdges[StartEdgeIndex];
  UniqueIndices.TryGetValue(e.Index1, v1);
  UniqueIndices.TryGetValue(e.Index2, v2);
  if v1.X < v2.X then
  begin
    temp := e.Index1;
    e.Index1 := e.Index2;
    e.Index2 := temp;
  end;
  result := e;
end;

procedure TBorderBuilder1.InitBorderArray;
var
  i: Integer;
  e: TTriangleEdge;
  v: TStitcherVertex;
  p: TPoint3D;
begin
  SetLength(BorderArray, SortedEdges.Count + 1);
  for i := 0 to SortedEdges.Count - 1 do
  begin
    e := SortedEdges[i];
    UniqueIndices.TryGetValue(e.Index1, v);
    p := v.OriginalPoint;
    if Flatten then
      p.Z := FCapValue;
    if Mirror then
      p.Z := FCapValue + (FCapValue - p.Z);
    BorderArray[i] := p;

    if i = SortedEdges.Count - 1 then
    begin
      UniqueIndices.TryGetValue(e.Index2, v);
      p := v.OriginalPoint;
      if Flatten then
        p.Z := FCapValue;
      if Mirror then
        p.Z := FCapValue + (FCapValue - p.Z);
      BorderArray[i + 1] := p;
    end;
  end;

end;

procedure TBorderBuilder1.InitBorderPolygon(AEdgePart: TEdgePart; var ABorderPoly: TPolygon);
var
  i: Integer;
  p: TPoint3D;
begin
  InitBorderPoints(AEdgePart);
  SetLength(ABorderPoly, Length(BorderArray));
  for i := 0 to Length(BorderArray) - 1 do
  begin
    p := BorderArray[i];
    ABorderPoly[i] := TPointF.Create(p.X, p.Y);
  end;
end;

procedure TBorderBuilder1.AddStats(ML: TStrings);
begin
  inherited;
  ML.Add('');
  ML.Add('--- TBorderBuilder1.AddStats');
  ML.Add('');
  ML.Add(Format('AllEdges.Count = %d', [AllEdges.Count]));
  ML.Add(Format('UniqueEdges.Count = %d', [UniqueEdges.Count]));

  ML.Add(Format('BorderEdgesNorth.Count = %d', [BorderEdgesNorth.Count]));
  ML.Add(Format('BorderEdgesSouth.Count = %d', [BorderEdgesSouth.Count]));
  ML.Add('');
  ML.Add(Format('BorderEdgesWest.Count = %d', [BorderEdgesWest.Count]));
  ML.Add(Format('BorderEdgesEast.Count = %d', [BorderEdgesEast.Count]));

  ML.Add(Format('SortedEdges.Count = %d', [SortedEdges.Count]));
  ML.Add(Format('StartEdgeIndex = %d', [StartEdgeIndex]));
  ML.Add(Format('NextCounter = %d', [NextCounter]));
  ML.Add(Format('PrevCounter = %d', [PrevCounter]));
end;

procedure TBorderBuilder1.FindBorderNorth(AY: single);
begin
  FindBorderY(BorderEdgesNorth, AY);
end;

procedure TBorderBuilder1.FindBorderSouth(AY: single);
begin
  FindBorderY(BorderEdgesSouth, AY);
end;

procedure TBorderBuilder1.FindBorderY(BorderEdges: TEdgeList; AY: single);
var
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
  Target: Integer;
begin
  Target := Round(AY * DigitScale);

  for e in UniqueEdges.Keys do
  begin
    UniqueIndices.TryGetValue(e.Index1, v1);
    UniqueIndices.TryGetValue(e.Index2, v2);

    if (v1.Y = Target) and (v2.Y = Target) then
    begin
      BorderEdges.Add(e);
    end;
  end;
end;

procedure TBorderBuilder1.FindBorderWest(AX: single);
begin
  FindBorderX(BorderEdgesWest, AX);
end;

procedure TBorderBuilder1.FindBorderEast(AX: single);
begin
  FindBorderX(BorderEdgesEast, AX);
end;

procedure TBorderBuilder1.FindBorderX(BorderEdges: TEdgeList; AX: single);
var
  e: TTriangleEdge;
  v1, v2: TStitcherVertex;
  Target: Integer;
begin
  Target := Round(AX * DigitScale);

  for e in UniqueEdges.Keys do
  begin
    UniqueIndices.TryGetValue(e.Index1, v1);
    UniqueIndices.TryGetValue(e.Index2, v2);

    if (v1.X = Target) and (v2.X = Target) then
    begin
      BorderEdges.Add(e);
    end;
  end;
end;

procedure TBorderBuilder1.InitBorderEdges(AZ: single);
begin
  BorderEdgesNorth.Clear;
  BorderEdgesSouth.Clear;
  BorderEdgesWest.Clear;
  BorderEdgesEast.Clear;

  BorderPositionN := -(Main.vp.range - Main.vp.OffsetY);
  BorderPositionS := +(Main.vp.range + Main.vp.OffsetY);
  BorderPositionW := -(Main.vp.range - Main.vp.OffsetX);
  BorderPositionE := +(Main.vp.range + Main.vp.OffsetX);

  FindBorderNorth(BorderPositionN);
  FindBorderSouth(BorderPositionS);
  FindBorderWest(BorderPositionW);
  FindBorderEast(BorderPositionE);
end;

procedure TBorderBuilder1.InitBorderPoints(AEdgePart: TEdgePart);
begin
  SortedEdges.Clear;
  case AEdgePart of

    North:
    begin
      FindStartEdgeXMin(BorderEdgesNorth);
      InitSortedEdges(BorderEdgesNorth);
      InitBorderArray;
    end;

    South:
    begin
      FindStartEdgeXMin(BorderEdgesSouth);
      InitSortedEdges(BorderEdgesSouth);
      InitBorderArray;
    end;

    West:
    begin
      FindStartEdgeYMax(BorderEdgesWest);
      InitSortedEdges(BorderEdgesWest);
      InitBorderArray;
    end;

    East:
    begin
      FindStartEdgeYMax(BorderEdgesEast);
      InitSortedEdges(BorderEdgesEast);
      InitBorderArray;
    end;

  end;
end;

procedure TBorderBuilder1.InitBorderPolygons;
begin
  InitBorderPolygon(TEdgePart.West, BorderPolyWest);
  InitBorderPolygon(TEdgePart.East, BorderPolyEast);
  InitBorderPolygon(TEdgePart.North, BorderPolyNorth);
  InitBorderPolygon(TEdgePart.South, BorderPolySouth);
end;

procedure TBorderBuilder1.InitBorderArrayNorthAndSouth;
begin
  FindStartEdgeXMin(BorderEdgesNorth);
  SortedEdges.Clear;
  InitSortedEdges(BorderEdgesNorth);
  InitBorderArray;
  BorderArrayNW := BorderArray;

  FindStartEdgeXMax(BorderEdgesNorth);
  SortedEdges.Clear;
  InitSortedEdges(BorderEdgesNorth);
  InitBorderArray;
  BorderArrayNE := BorderArray;

  FindStartEdgeXMin(BorderEdgesSouth);
  SortedEdges.Clear;
  InitSortedEdges(BorderEdgesSouth);
  InitBorderArray;
  BorderArraySW := BorderArray;

  FindStartEdgeXMax(BorderEdgesSouth);
  SortedEdges.Clear;
  InitSortedEdges(BorderEdgesSouth);
  InitBorderArray;
  BorderArraySE := BorderArray;
end;

procedure TBorderBuilder1.InitBorderArrayWestAndEast;
begin
  FindStartEdgeXMax(BorderEdgesWest);
  SortedEdges.Clear;
  InitSortedEdges(BorderEdgesWest);
  InitBorderArray;
  BorderArrayWest := BorderArray;

  FindStartEdgeYMax(BorderEdgesEast);
  SortedEdges.Clear;
  InitSortedEdges(BorderEdgesEast);
  InitBorderArray;
  BorderArrayEast := BorderArray;
end;

procedure TBorderBuilder1.PrepareEdges(MB: TMeshBuilderBase; ACapValue: single);
begin
  Clear;
  MB.AddData(Self);
  InitEdges;
  InitBorderEdges(ACapValue);
end;

end.
