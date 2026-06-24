unit RiggVar.MeshBuilder.BorderBuilder;

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
  RiggVar.Mesh.MeshBuilder;

type
  TBorderBuilderProblem = (
    problem_UnknownBorderBuilder,
    problem_CannotDeleteFromTempEdges,
    problem_CannotFindNorthElement,
    problem_EdgeListCountSmall,
    problem_EdgeListCountBig
  );

  TBorderBuilderProblems = set of TBorderBuilderProblem;

  TEdgePart = (
    North,
    South,
    West,
    East,
    HandWest1,
    HandEast2,
    EyeWest3,
    EyeEast4
  );

  TStartIndexType = (
    MinX,
    MaxX,
    MinY,
    MaxY
  );

  TTriangleEdge = record
  public
    Index1: Integer; // unique vertex index 1
    Index2: Integer; // unique vertex index 2
    constructor Create(AIndex1, AIndex2: Integer);
    procedure Clear;
    class operator Equal(const Edge1, Edge2: TTriangleEdge): Boolean; inline;
    class operator NotEqual(const Edge1, Edge2: TTriangleEdge): Boolean; inline;
    function EqualsTo(const Edge: TTriangleEdge): Boolean; inline;
    function ConnectsTo(const AEdge: TTriangleEdge): Boolean;
    function ConnectsToHead(const AEdge: TTriangleEdge): Boolean;
    function ConnectsToTail(const AEdge: TTriangleEdge): Boolean;
  end;

  TTriangleEdgeComparer1 = class(TInterfacedObject, IComparer<TTriangleEdge>)
  public
    function Compare(const Left, Right: TTriangleEdge): Integer; reintroduce;
  end;

  TTriangleEdgeComparer2 = class(TInterfacedObject, IEqualityComparer<TTriangleEdge>)
  public
    function Equals(const Left, Right: TTriangleEdge): Boolean; reintroduce;
    function GetHashCode(const Value: TTriangleEdge): Integer; reintroduce;
  end;

  TEdgeList = TList<TTriangleEdge>;
  TEdgeDictionary = TDictionary<TTriangleEdge, Integer>;

implementation

{ TTriangleEdge }

procedure TTriangleEdge.Clear;
begin
  Index1 := -1;
  Index2 := -1;
end;

function TTriangleEdge.ConnectsTo(const AEdge: TTriangleEdge): Boolean;
begin
  if Self.Index1 = AEdge.Index1 then
    result := True
  else if Self.Index1 = AEdge.Index2 then
    result := True
  else if Self.Index2 = AEdge.Index1 then
    result := True
  else if Self.Index2 = AEdge.Index2 then
    result := True
  else
    result := False;
end;

function TTriangleEdge.ConnectsToHead(const AEdge: TTriangleEdge): Boolean;
begin
  if Self.Index1 = AEdge.Index1 then
    result := True
  else if Self.Index1 = AEdge.Index2 then
    result := True
  else
    result := False;
end;

function TTriangleEdge.ConnectsToTail(const AEdge: TTriangleEdge): Boolean;
begin
  if Self.Index2 = AEdge.Index1 then
    result := True
  else if Self.Index2 = AEdge.Index2 then
    result := True
  else
    result := False;
end;

constructor TTriangleEdge.Create(AIndex1, AIndex2: Integer);
begin
  Index1 := AIndex1;
  Index2 := AIndex2;
end;

class operator TTriangleEdge.Equal(const Edge1, Edge2: TTriangleEdge): Boolean;
var
  b1, b2: Boolean;
begin
  b1 := (Edge1.Index1 = Edge2.Index1) and (Edge1.Index2 = Edge2.Index2);
  b2 := (Edge1.Index1 = Edge2.Index2) and (Edge1.Index2 = Edge2.Index1);
  result := b1 or b2;
end;

class operator TTriangleEdge.NotEqual(const Edge1, Edge2: TTriangleEdge): Boolean;
begin
  result := not (Edge1 = Edge2);
end;

function TTriangleEdge.EqualsTo(const Edge: TTriangleEdge): Boolean;
var
  b1, b2: Boolean;
begin
  b1 := (Index1 = Edge.Index1) and (Index2 = Edge.Index2);
  b2 := (Index1 = Edge.Index2) and (Index2 = Edge.Index1);
  result := b1 or b2;
end;

{ TTriangleEdgeComparer1 }

function TTriangleEdgeComparer1.Compare(const Left, Right: TTriangleEdge): Integer;
begin
  result := (Left.Index1 + Left.Index2) - (Right.Index1 + Right.Index2);
end;

{ TTriangleEdgeComparer2 }

function TTriangleEdgeComparer2.Equals(const Left, Right: TTriangleEdge): Boolean;
begin
  result := Left = Right;
end;

function TTriangleEdgeComparer2.GetHashCode(const Value: TTriangleEdge): Integer;
begin
  result := Value.Index1 + Value.Index2;
end;

end.

