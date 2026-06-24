unit RiggVar.Mesh.MeshDataHelper;

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
  System.RTLConsts,
  System.Math,
  System.Math.Vectors,
  System.Types,
  FMX.Types3D;

type
  TMeshDataHelper = class Helper for TMeshData
  private
    function GetCuboidWidth: single;
    function GetCuboidHeight: single;
    function GetCuboidDepth: single;
    function GetCuboidCenter: TPoint3D;
  public
    function RayCastIntersect(
      const Width, Height, Depth: Single;
      const RayPos, RayDir: TPoint3D;
      var Intersection: TPoint3D): Boolean; overload;

    function RayCastIntersectRing(
      const Width, Height, Depth: Single;
      const RayPos, RayDir: TPoint3D;
      var Intersection: TPoint3D): TPoint3D;

    property CuboidWidth: single read GetCuboidWidth;
    property CuboidHeight: single read GetCuboidHeight;
    property CuboidDepth: single read GetCuboidDepth;
    property CuboidCenter: TPoint3D read GetCuboidCenter;
  end;

implementation

uses
  RiggVar.App.Main;

(*

TMeshData.RayCastIntersect
  uses RayCastPlaneIntersect
  uses RayCastCuboidIntersect
  uses RayCastTriangleIntersect

RayCastCuboidIntersect
  uses RayCastEllipsoidIntersect

RayCastEllipsoidIntersect
  uses RayCastSphereIntersect

RayCastTriangleIntersect
  uses RayCastPlaneIntersect
  uses SameSide

Local function Inside of method RayCastCuboidIntersect
  expects normalised vertice coordinates:

  function Inside(const Value: TPoint3D): Boolean;
  begin
    Result :=
          (Abs(Value.X - CuboidCenter.X) <= (0.501 * LWidth))
      and (Abs(Value.Y - CuboidCenter.Y) <= (0.501 * LHeight))
      and (Abs(Value.Z - CuboidCenter.Z) <= (0.501 * LDepth));
  end;

*)

function IsEssentiallyZero(const Value: Single): Boolean;
begin
  Result := (Value < Epsilon2) and (Value > -Epsilon2);
end;

function IsNotEssentiallyZero(const Value: Single): Boolean;
begin
  Result := (Value > Epsilon2) or (Value < -Epsilon2);
end;

function SameSide(const P1, P2: TPoint3D; A, B: TPoint3D): Boolean;
var
  CP1, CP2: TPoint3D;
begin
  CP1 := (B - A).CrossProduct(P1 - A);
  CP2 := (B - A).CrossProduct(P2 - A);
  if CP1.DotProduct(CP2) >= 0 then
    Result := True
  else
    Result := False;
end;

{
  See: http://en.wikipedia.org/wiki/Line-plane_intersection
  See: http://paulbourke.net/geometry/planeline/
}
function RayCastPlaneIntersect(const RayPos, RayDir, PlanePoint, PlaneNormal: TPoint3D;
  var Intersection: TPoint3D): Boolean;
var
  LDotProd, LFactor: Single;
begin
  // Is the Ray parallel to the plane?
  LDotProd := RayDir.DotProduct(PlaneNormal);
  if IsNotEssentiallyZero(LDotProd) then
  begin
    LFactor := (PlanePoint - RayPos).DotProduct(PlaneNormal) / LDotProd;
    if LFactor > 0 then
    begin
      Result := True;
      Intersection := RayPos + RayDir * LFactor;
    end
    else
      Result := False; // The Ray points away from the plane
  end
  else
    Result := False;
end;

{
  See: http://en.wikipedia.org/wiki/Line–sphere_intersection
  See: http://www.ccs.neu.edu/home/fell/CSU540/programs/RayTracingFormulas.htm
}
function RayCastSphereIntersect(const RayPos, RayDir, SphereCenter: TPoint3D;
  const SphereRadius: Single; var IntersectionNear, IntersectionFar: TPoint3D): Integer;
var
  A, B, C, B2, FourAC, Discriminant, LRoot, TwoA, LFactor: Single;
  LTempVec: TPoint3D;
begin
  A := RayDir.X * RayDir.X + RayDir.Y * RayDir.Y + RayDir.Z * RayDir.Z;
  B := 2 * (
    RayDir.X * (RayPos.X - SphereCenter.X)
    + RayDir.Y * (RayPos.Y - SphereCenter.Y)
    + RayDir.Z * (RayPos.Z - SphereCenter.Z)
  );
  C :=
      SphereCenter.X * SphereCenter.X
    + SphereCenter.Y * SphereCenter.Y
    + SphereCenter.Z * SphereCenter.Z
    + RayPos.X * RayPos.X
    + RayPos.Y * RayPos.Y
    + RayPos.Z * RayPos.Z
    - 2 * (SphereCenter.X * RayPos.X + SphereCenter.Y * RayPos.Y + SphereCenter.Z * RayPos.Z)
    - SphereRadius * SphereRadius;

  B2 := B * B;
  FourAC := 4 * A * C;
  discriminant := b2 - fourac;

  if (discriminant < 0) then
  begin
    Result := 0;
  end
  else if (discriminant = 0) then
  begin
    Result := 1;
    LFactor := -B / (2 * A); // we already know the descriminant is 0
    IntersectionNear := RayPos + RayDir * LFactor;
    IntersectionFar := IntersectionNear;
  end
  else
  begin
    Result := 2;
    LRoot := Sqrt(B2 - FourAC);
    TwoA := 2 * A;
    LFactor := (-B - LRoot)/TwoA;
    IntersectionNear := RayPos + RayDir * LFactor;
    LFactor := (-B + LRoot)/TwoA;
    IntersectionFar := RayPos + RayDir * LFactor;
    if RayPos.Distance(IntersectionNear) > RayPos.Distance(IntersectionFar) then
    begin
      LTempVec := IntersectionNear;
      IntersectionNear := IntersectionFar;
      IntersectionFar := LTempVec;
    end;
  end;
end;

{
  We can use the Sphere Intersect algorithm if we distort space so we have a single common radius
}
function RayCastEllipsoidIntersect(
  const RayPos, RayDir, EllipsoidCenter: TPoint3D;
  const XRadius, YRadius, ZRadius: Single;
  var IntersectionNear, IntersectionFar: TPoint3D): Integer;
var
  LCommonRadius, LFactorX, LFactorY, LFactorZ: Single;
  LRayPos, LRayDir, LSphereCenter: TPoint3D;
begin
  // avoid degenerate cases (where ellipsoid is a plane or line)
  if IsNotEssentiallyZero(XRadius)
  and IsNotEssentiallyZero(YRadius)
  and IsNotEssentiallyZero(ZRadius) then
  begin
    LCommonRadius := XRadius;
    LCommonRadius := Max(LCommonRadius, YRadius);
    LCommonRadius := Max(LCommonRadius, ZRadius);
    LFactorX := LCommonRadius/XRadius;
    LFactorY := LCommonRadius/YRadius;
    LFactorZ := LCommonRadius/ZRadius;
    LRayPos := TPoint3D.Create(RayPos.X * LFactorX, RayPos.Y * LFactorY, RayPos.Z * LFactorZ);
    LRayDir := TPoint3D.Create(RayDir.X * LFactorX, RayDir.Y * LFactorY, RayDir.Z * LFactorZ);
    LSphereCenter := TPoint3D.Create(EllipsoidCenter.X * LFactorX, EllipsoidCenter.Y * LFactorY, EllipsoidCenter.Z * LFactorZ);
    Result := RayCastSphereIntersect(LRayPos, LRayDir, LSphereCenter, LCommonRadius, IntersectionNear, IntersectionFar);
    // adjust intersection points as needed
    if Result > 0 then
    begin
      IntersectionNear.X := IntersectionNear.X / LFactorX;
      IntersectionNear.Y := IntersectionNear.Y / LFactorY;
      IntersectionNear.Z := IntersectionNear.Z / LFactorZ;
      IntersectionFar.X := IntersectionFar.X / LFactorX;
      IntersectionFar.Y := IntersectionFar.Y / LFactorY;
      IntersectionFar.Z := IntersectionFar.Z / LFactorZ;
    end;
  end
  else
    Result := 0;
end;

function RayCastCuboidIntersect(
  const RayPos, RayDir, CuboidCenter: TPoint3D;
  const Width, Height, Depth: Single;
  var IntersectionNear, IntersectionFar: TPoint3D): Integer;
var
  LWidth, LHeight, LDepth: Single;
  LContinueSearch: Boolean;
  A, B, C: Single;
  LIntercepts: array of TPoint3D;
  LDimensionVec, LThicknessVec: TPoint3D;
  I: Integer;
const
  Root3Over2: Single = 0.866025404; //WurzelDreiHalbe

  function TryEllipsoidShortCut(const W, H, D: Single): Boolean;
  var
    LMax, LMin: Single;
  begin
    LMin := W;
    LMin := Min(LMin, H);
    LMin := Min(LMin, D);
    LMax := W;
    LMax := Max(LMax, H);
    LMax := Max(LMax, D);
    Result := (LMin/LMax) > 0.1;
  end;

  function Inside(const Value: TPoint3D): Boolean;
  begin
    Result :=
          (Abs(Value.X - CuboidCenter.X) <= (0.501 * LWidth))
      and (Abs(Value.Y - CuboidCenter.Y) <= (0.501 * LHeight))
      and (Abs(Value.Z - CuboidCenter.Z) <= (0.501 * LDepth));
  end;

  // FireMonkey layers (which are basically 2D) have a hard coded thickness of 0.01
  function IsThickerThan2DLayer(const Value: Single): Boolean;
  begin
    Result := (Value > 0.01) or (Value < -0.01);
  end;

begin
  Result := 0;
  LWidth := Abs(Width);
  LHeight := Abs(Height);
  LDepth := Abs(Depth);

  // try to check as plane
  if IsEssentiallyZero(LDepth) and IsNotEssentiallyZero(LWidth) and IsNotEssentiallyZero(LHeight) then
  begin
    if RayCastPlaneIntersect(RayPos, RayDir, CuboidCenter, TPoint3D.Create(0, 0, 1), IntersectionNear)
      and (Abs(IntersectionNear.X) < LWidth / 2)
      and (Abs(IntersectionNear.Y) < Height / 2) then
    begin
      Result := 1;
      IntersectionFar := IntersectionNear;
    end;
    Exit;
  end;
  if IsNotEssentiallyZero(LDepth) and IsEssentiallyZero(LWidth) and IsNotEssentiallyZero(LHeight) then
  begin
    if RayCastPlaneIntersect(RayPos, RayDir, CuboidCenter, TPoint3D.Create(1, 0, 0), IntersectionNear)
      and (Abs(IntersectionNear.Z) < LDepth / 2)
      and (Abs(IntersectionNear.Y) < Height / 2) then
    begin
      Result := 1;
      IntersectionFar := IntersectionNear;
    end;
    Exit;
  end;
  if IsNotEssentiallyZero(LDepth) and IsNotEssentiallyZero(LWidth) and IsEssentiallyZero(LHeight) then
  begin
    if RayCastPlaneIntersect(RayPos, RayDir, CuboidCenter, TPoint3D.Create(0, 1, 0), IntersectionNear)
      and (Abs(IntersectionNear.X) < LWidth / 2)
      and (Abs(IntersectionNear.Z) < Depth / 2) then
    begin
      Result := 1;
      IntersectionFar := IntersectionNear;
    end;
    Exit;
  end;

  // is empty
  if IsEssentiallyZero(LDepth) and IsEssentiallyZero(LWidth) and IsEssentiallyZero(LHeight) then
  begin
    Result := 0;
    Exit;
  end;

  SetLength(LIntercepts, 2);
  // To find the real answer, we need to see how the ray intersects with the faces of the cuboid.
  // As a shortcut, we can see if there is intersection with an ellipsoid that encompasses the
  // entirety of the cuboid. Don't bother if the aspect ratio is too large.
  if TryEllipsoidShortCut(LWidth, LHeight, LDepth) then
  begin
    // Derivation:
    //
    // Equation of ellipsoid (http://en.wikipedia.org/wiki/Ellipsoid):
    //
    // (x^2)/(a^2) + (y^2)/(b^2) + (z^2)/(c^2) = 1
    //
    // We also know that for the ellipsoid inscribed INSIDE the cuboid:
    //
    //  a' = Width/2
    //  b' = Height/2
    //  c' = Depth/2
    //
    // To find the ellipsoid which encloses the cuboid, we need to simply scale
    // up the ellipsoid which is inscribed within. Thus:
    //
    //  a = factor * a' = factor * Width/2
    //  b = factor * b' = factor * Height/2
    //  c = factor * c' = factor * Depth/2
    //
    // We know one solution for the equation of the ellipsoid which encloses the
    // cuboid is found when:
    //
    // x = Width/2
    // y = Height/2
    // z = Depth/2
    //
    // thus:
    //
    // ((Width/2)^2)/(a^2) + ((Height/2)^2)/(b^2)) + ((Depth/2)^2)/(c^2) = 1
    //
    // substitute a, b, c and simplify:
    //
    // 1/factor^2 + 1/factor^2 + 1/factor^2 = 1
    //
    // 3/factor^2 = 1
    //
    // factor = SquareRoot(3)
    //
    // yielding:
    //
    //  a = SquareRoot(3) * Width/2
    //  b = SquareRoot(3) * Height/2
    //  c = SquareRoot(3) * Depth/2

    A := Root3Over2 * LWidth;
    B := Root3Over2 * LHeight;
    C := Root3Over2 * LDepth;

    LContinueSearch := RayCastEllipsoidIntersect(RayPos, RayDir, CuboidCenter, A, B, C, LIntercepts[0], LIntercepts[1]) > 0;
  end
  else
    LContinueSearch := True;

  if LContinueSearch then
  begin
    // We failed the ellipsoid check, now we need to do the hard work and check each face
    Result := 0;

    // store these in a vector so we can iterate over them
    LDimensionVec := TPoint3D.Create(LWidth/2, LHeight/2, LDepth/2);
    LThicknessVec := TPoint3D.Create(Min(LHeight, LDepth), Min(LWidth, LDepth), Min(LWidth, LHeight));

    for I := 0 to 2 do
    begin
      if (Result < 2)
        and IsNotEssentiallyZero(RayDir.V[I])
        and IsThickerThan2DLayer(LThicknessVec.V[I]) then
      begin
        LIntercepts[Result] := RayPos + RayDir * ((CuboidCenter.V[I] - LDimensionVec.V[I] - RayPos.V[I]) / RayDir.V[I]);
        if Inside(LIntercepts[Result]) then
          Inc(Result);

        if (Result < 2) then
        begin
          LIntercepts[Result] := RayPos + RayDir * ((CuboidCenter.V[I] + LDimensionVec.V[I] - RayPos.V[I]) / RayDir.V[I]);
          if Inside(LIntercepts[Result]) then
            Inc(Result);
        end;
      end;
    end;

    if Result = 1 then
    begin
      IntersectionNear := LIntercepts[0];
      IntersectionFar := LIntercepts[0];
    end
    else if Result = 2 then
    begin
      if RayPos.Distance(LIntercepts[0]) < RayPos.Distance(LIntercepts[1]) then
      begin
        IntersectionNear := LIntercepts[0];
        IntersectionFar := LIntercepts[1];
      end
      else
      begin
        IntersectionNear := LIntercepts[1];
        IntersectionFar := LIntercepts[0];
      end;
    end;
  end
  else
    Result := 0;
end;

{
  See: http://en.wikipedia.org/wiki/Barycentric_coordinate_system_(mathematics)#Determining_if_a_point_is_inside_a_triangle
  See: http://mathworld.wolfram.com/BarycentricCoordinates.html
  See: http://www.blackpawn.com/texts/pointinpoly/default.html
}
//fixed method
function RayCastTriangleIntersect(const RayPos, RayDir, Vertex1, Vertex2, Vertex3: TPoint3D;
  var Intersection: TPoint3D): Boolean;
var
  N, P, A, C: TPoint3D;
begin
  A := Vertex1 - Vertex2;
//B := Vertex2 - Vertex3; // unused
  C := Vertex3 - Vertex1;
  N := A.CrossProduct(C);
  Result := False;
  if RayCastPlaneIntersect(RayPos, RayDir, Vertex1, N, P) then
  begin
    {
      Result :=
      SameSide(P, A, B, C) and
      SameSide(P, B, A, C) and
      SameSide(P, C, A, B);    //original code
    }

    Result :=
      SameSide(P, Vertex1, Vertex2, Vertex3) and
      SameSide(P, Vertex2, Vertex3, Vertex1) and
      SameSide(P, Vertex3, Vertex1, Vertex2); // Corrected

    if Result then
      Intersection := P;
  end;
end;

function TMeshDataHelper.RayCastIntersect(const Width, Height, Depth: Single;
  const RayPos, RayDir: TPoint3D; var Intersection: TPoint3D): Boolean;
var
  INear, IFar, P1, P2, P3: TPoint3D;
  I: Integer;
  P: TPoint3D;
begin
  // Start with a simple test of the bounding cuboid
  Result := RayCastCuboidIntersect(
    RayPos, RayDir,
    CuboidCenter,
    CuboidWidth,
    CuboidHeight,
    CuboidDepth,
    INear, IFar) > 0;
  if Result then
  begin
    // Now, reset the result and check the triangles
    Result := False;
    if (VertexBuffer.Size > 0) and (IndexBuffer.Size > 0) then
    begin
      for I := 0 to (IndexBuffer.Length div 3) - 1 do
      begin
        if (IndexBuffer[(I * 3) + 0] < VertexBuffer.Length) and
          (IndexBuffer[(I * 3) + 1] < VertexBuffer.Length) and
          (IndexBuffer[(I * 3) + 2] < VertexBuffer.Length) then
        begin
          P := VertexBuffer.Vertices[IndexBuffer[(I * 3) + 0]];
          P1 := TPoint3D.Create(P.X * Width, P.Y * Height, P.Z * Depth);
          P := VertexBuffer.Vertices[IndexBuffer[(I * 3) + 1]];
          P2 := TPoint3D.Create(P.X * Width, P.Y * Height, P.Z * Depth);
          P := VertexBuffer.Vertices[IndexBuffer[(I * 3) + 2]];
          P3 := TPoint3D.Create(P.X * Width, P.Y * Height, P.Z * Depth);
          if RayCastTriangleIntersect(RayPos, RayDir, P1, P2, P3, INear) then
          begin
            Intersection := INear;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TMeshDataHelper.RayCastIntersectRing(const Width, Height, Depth: Single;
  const RayPos, RayDir: TPoint3D; var Intersection: TPoint3D): TPoint3D;
var
  INear, IFar, P1, P2, P3: TPoint3D;
  I: Integer;
  P: TPoint3D;
  b: Boolean;
  i0, i1, i2: Integer;
  v0, v1, v2: Integer;
  w, h, d: single;
begin
  { Should be overload of RayCastIntersect?
    It is the same as RayCastIntersect,
    except that it returns the Indices of Vertices of hit Triangle in a TPoint3D,
    or (-2, -2, -2) if it does not hit a triangle. }

  result.X := -2;
  result.Y := -2;
  result.Z := -2;
  // Start with a simple test of the bounding cuboid
  b := RayCastCuboidIntersect(
    RayPos, RayDir,
    CuboidCenter,
    CuboidWidth,
    CuboidHeight,
    CuboidDepth,
    INear, IFar) > 0;
  if b then
  begin
    // Now, reset the result and check the triangles
    if (VertexBuffer.Size > 0) and (IndexBuffer.Size > 0) then
    begin
      w := Width;
      h := Height;
      d := Depth;

      for I := 0 to (IndexBuffer.Length div 3) - 1 do
      begin
        i0 := (I * 3) + 0;
        i1 := (I * 3) + 1;
        i2 := (I * 3) + 2;

        v0 := IndexBuffer[i0];
        v1 := IndexBuffer[i1];
        v2 := IndexBuffer[i2];

        if (v0 < VertexBuffer.Length) and
           (v1 < VertexBuffer.Length) and
           (v2 < VertexBuffer.Length) then
        begin
          P := VertexBuffer.Vertices[v0];
          P1 := TPoint3D.Create(P.X * w, P.Y * h, P.Z * d);
          P := VertexBuffer.Vertices[v1];
          P2 := TPoint3D.Create(P.X * w, P.Y * h, P.Z * d);
          P := VertexBuffer.Vertices[v2];
          P3 := TPoint3D.Create(P.X * w, P.Y * h, P.Z * d);
          if RayCastTriangleIntersect(RayPos, RayDir, P1, P2, P3, INear) then
          begin
            Intersection := INear;
            Result.X := v0;
            Result.Y := v1;
            Result.Z := v2;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TMeshDataHelper.GetCuboidWidth: single;
begin
  if MainVar.Transform3D.GlobalScale = 1.0 then
    result := Main.FederMesh.Width
  else
    result := Main.MeshBuilder.Width;
end;

function TMeshDataHelper.GetCuboidHeight: single;
begin
  if MainVar.Transform3D.GlobalScale = 1.0 then
    result := Main.FederMesh.Height
  else
    result := Main.MeshBuilder.Height;
end;

function TMeshDataHelper.GetCuboidDepth: single;
begin
  if MainVar.Transform3D.GlobalScale = 1.0 then
    result := Main.FederMesh.Depth
  else
    result := Main.MeshBuilder.Depth;
end;

function TMeshDataHelper.GetCuboidCenter: TPoint3D;
begin
  result := NullPoint3D;
end;

end.
