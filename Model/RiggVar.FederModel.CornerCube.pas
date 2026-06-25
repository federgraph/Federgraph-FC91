unit RiggVar.FederModel.CornerCube;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.Math,
  System.Math.Vectors,
  System.RTLConsts,
  System.UIConsts,
  System.UITypes,
  FMX.Graphics,
  FMX.Types3D,
  FMX.MaterialSources,
  FMX.Objects,
  FMX.Objects3D;

type
  TCornerCube = class(TCustomMesh)
  private
    FRotX: single;
    FPosZ: single;
    FDefaultPosZ: single;
    procedure RotateX(deg: single);
    procedure SetRotX(const Value: single);
    procedure SetPosZ(const Value: single);
    procedure SetDefaultPosZ(const Value: single);
  protected
    procedure RebuildMesh;
    function DoRayCastIntersect(const RayPos, RayDir: TPoint3D; var Intersection: TPoint3D): Boolean; override;
  public
    Premultiply: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure AddReport(SL: TStrings);
    property RotX: single read FRotX write SetRotX;
    property PosZ: single read FPosZ write SetPosZ;
    property DefaultPosZ: single read FDefaultPosZ write SetDefaultPosZ;
  published
    property MaterialSource;
    property Cursor default crDefault;
    property DragMode default TDragMode.dmManual;
    property Position;
    property Scale;
    property RotationAngle;
    property Locked default False;
    property Width;
    property Height;
    property Depth;
    property Opacity nodefault;
    property Projection;
    property HitTest default True;
    property VisibleContextMenu default True;
    property TwoSide default False;
    property Visible default True;
    property ZWrite default True;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnKeyDown;
    property OnKeyUp;
    property OnRender;
  end;

  TCornerCubeTextureMaterialSource = class(TTextureMaterialSource)
  private
    BMP: TBitmap;
    FColor1: TAlphaColor;
    FColor2: TAlphaColor;
    FColor3: TAlphaColor;
    FColor4: TAlphaColor;
    FColor5: TAlphaColor;
    FColor6: TAlphaColor;
    function GenerateTextureBitmap: TBitmap;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Color1: TAlphaColor read FColor1 write FColor1;
    property Color6: TAlphaColor read FColor6 write FColor6;

    property Color2: TAlphaColor read FColor2 write FColor2;
    property Color5: TAlphaColor read FColor5 write FColor5;

    property Color3: TAlphaColor read FColor3 write FColor3;
    property Color4: TAlphaColor read FColor4 write FColor4;
  end;

  TColoredCornerCube = class(TCornerCube)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TCornerCube }

constructor TCornerCube.Create(AOwner: TComponent);
begin
  inherited;
  RebuildMesh;
end;

procedure TCornerCube.RebuildMesh;
var
  X, Y: Integer;
  Face: Integer;
  FaceVertexLength: Integer;
  FaceIndexLength: Integer;
  VertexOffset: Integer;
  IndexOffset: Integer;
  c1, c2: single;
  i: Integer;

  function TextureIndexOfFace(i: Integer): single;
  begin
    result := i / 10 - 0.05;
  end;
begin
  Data.VertexBuffer.Length := 3 * 8;
  Data.IndexBuffer.Length := 3 * 6 * 2;

  { Faces 1 and 6 }
  c1 := TextureIndexOfFace(1);
  c2 := TextureIndexOfFace(6);
  VertexOffset := 0;
  IndexOffset := 0;
  FaceVertexLength := 4;
  FaceIndexLength := 6;
  for Face := 0 to 1 do
  begin
    for Y := 0 to 1 do
    begin
      for X := 0 to 1 do
      begin
        if not Odd(Face) then
        begin
          i := VertexOffset + X + (Y * 2);
          Data.VertexBuffer.Vertices[i] := Point3D(-0.5 + X, -0.5 + Y, -0.5);
          Data.VertexBuffer.Normals[i] := Point3D(0, 0, -1);
          Data.VertexBuffer.TexCoord0[i] := PointF(0, c1);
        end
        else
        begin
          i := VertexOffset + FaceVertexLength + X + (Y * 2);
          Data.VertexBuffer.Vertices[i] := Point3D(-0.5 + X, -0.5 + Y, 0.5);
          Data.VertexBuffer.Normals[i] := Point3D(0, 0, 1);
          Data.VertexBuffer.TexCoord0[i] := PointF(0, c2);
        end;
      end;
    end;
    i := IndexOffset + (Face * FaceIndexLength);
    if Odd(Face) then
    begin
      Data.IndexBuffer[i + 0] := VertexOffset + FaceVertexLength + 0;
      Data.IndexBuffer[i + 2] := VertexOffset + FaceVertexLength + 1;
      Data.IndexBuffer[i + 1] := VertexOffset + FaceVertexLength + 2;
      Data.IndexBuffer[i + 3] := VertexOffset + FaceVertexLength + 2;
      Data.IndexBuffer[i + 5] := VertexOffset + FaceVertexLength + 1;
      Data.IndexBuffer[i + 4] := VertexOffset + FaceVertexLength + 3;
    end
    else
    begin
      Data.IndexBuffer[i + 0] := VertexOffset + 0;
      Data.IndexBuffer[i + 1] := VertexOffset + 1;
      Data.IndexBuffer[i + 2] := VertexOffset + 2;
      Data.IndexBuffer[i + 3] := VertexOffset + 2;
      Data.IndexBuffer[i + 4] := VertexOffset + 1;
      Data.IndexBuffer[i + 5] := VertexOffset + 3;
    end;
  end;

  { Faces 3 and 4 }
  c1 := TextureIndexOfFace(3);
  c2 := TextureIndexOfFace(4);
  VertexOffset := VertexOffset + FaceVertexLength * 2;
  IndexOffset := IndexOffset + FaceIndexLength * 2;
  FaceVertexLength := 4;
  FaceIndexLength := 6;
  for Face := 0 to 1 do
  begin
    for Y := 0 to 1 do
    begin
      for X := 0 to 1 do
      begin
        i := VertexOffset + (Face * FaceVertexLength) + X + (Y * 2);
        if Odd(Face) then
        begin
          Data.VertexBuffer.Vertices[i] := TPoint3D.Create(-0.5 + X, -0.5, -0.5 + Y);
          Data.VertexBuffer.Normals[i] := TPoint3D.Create(0, -1, 0);
          Data.VertexBuffer.TexCoord0[i] := PointF(0, c1);
        end
        else
        begin
          Data.VertexBuffer.Vertices[i] := TPoint3D.Create(-0.5 + X, 0.5, -0.5 + Y);
          Data.VertexBuffer.Normals[i] := TPoint3D.Create(0, 1, 0);
          Data.VertexBuffer.TexCoord0[i] := PointF(0, c2);
        end;
      end;
    end;
    i := IndexOffset + (Face * FaceIndexLength);
    if Odd(Face) then
    begin
      Data.IndexBuffer[i + 0] := VertexOffset + (Face * FaceVertexLength) + 0;
      Data.IndexBuffer[i + 2] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 1] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 3] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 5] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 4] := VertexOffset + (Face * FaceVertexLength) + 3;
    end
    else
    begin
      Data.IndexBuffer[i + 0] := VertexOffset + (Face * FaceVertexLength) + 0;
      Data.IndexBuffer[i + 1] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 2] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 3] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 4] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 5] := VertexOffset + (Face * FaceVertexLength) + 3;
    end;
  end;

  { Faces 5 and 2 }
  c1 := TextureIndexOfFace(5);
  c2 := TextureIndexOfFace(2);
  VertexOffset := VertexOffset + FaceVertexLength * 2;
  IndexOffset := IndexOffset + FaceIndexLength * 2;
  FaceVertexLength := 4;
  FaceIndexLength := 6;
  for Face := 0 to 1 do
  begin
    for Y := 0 to 1 do
    begin
      for X := 0 to 1 do
      begin
        i := VertexOffset + (Face * FaceVertexLength) + X + (Y * 2);
        if Odd(Face) then
        begin
          Data.VertexBuffer.Vertices[i] := TPoint3D.Create(-0.5, -0.5 + X, -0.5 + Y);
          Data.VertexBuffer.Normals[i] := TPoint3D.Create(-1, 0, 0);
          Data.VertexBuffer.TexCoord0[i] := PointF(0, c1);
        end
        else
        begin
          Data.VertexBuffer.Vertices[i] := TPoint3D.Create(0.5, -0.5 + X, -0.5 + Y);
          Data.VertexBuffer.Normals[i] := TPoint3D.Create(1, 0, 0);
          Data.VertexBuffer.TexCoord0[i] := PointF(0, c2);
        end;
      end;
    end;
    i := IndexOffset + (Face * FaceIndexLength);
    if not Odd(Face) then
    begin
      Data.IndexBuffer[i + 0] := VertexOffset + (Face * FaceVertexLength) + 0;
      Data.IndexBuffer[i + 2] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 1] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 3] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 5] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 4] := VertexOffset + (Face * FaceVertexLength) + 3;
    end
    else
    begin
      Data.IndexBuffer[i + 0] := VertexOffset + (Face * FaceVertexLength) + 0;
      Data.IndexBuffer[i + 1] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 2] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 3] := VertexOffset + (Face * FaceVertexLength) + 2;
      Data.IndexBuffer[i + 4] := VertexOffset + (Face * FaceVertexLength) + 1;
      Data.IndexBuffer[i + 5] := VertexOffset + (Face * FaceVertexLength) + 3;
    end;
  end;
end;

function TCornerCube.DoRayCastIntersect(const RayPos, RayDir: TPoint3D; var Intersection: TPoint3D): Boolean;
var
  NearIntersectionPoint, FarIntersectionPoint: TPoint3D;
  Side: Single;
begin
  { Calling inherited will search through the MeshData for intersection. This is
    wasted effort for such a simple shape. }
  Result := False;
  case WrapMode of
    TMeshWrapMode.Original:
    begin
        Result := RayCastCuboidIntersect(RayPos, RayDir, TPoint3D.Zero, Width, Height, Depth, NearIntersectionPoint,
          FarIntersectionPoint) > 0;
        if Result then
        Intersection := TPoint3D(LocalToAbsoluteVector(NearIntersectionPoint));
    end;
    TMeshWrapMode.Resize:
    begin
        Result := RayCastCuboidIntersect(RayPos, RayDir, TPoint3D.Zero, 1, 1, 1, NearIntersectionPoint,
          FarIntersectionPoint) > 0;
        if Result then
        Intersection := TPoint3D(LocalToAbsoluteVector(NearIntersectionPoint));
    end;
    TMeshWrapMode.Fit:
    begin
      Side := Min(Width, Height);
      Side := Min(Depth, Side);
      Result := RayCastCuboidIntersect(RayPos, RayDir, TPoint3D.Zero, Side, Side, Side, NearIntersectionPoint,
        FarIntersectionPoint) > 0;
      if Result then
        Intersection := TPoint3D(LocalToAbsoluteVector(NearIntersectionPoint));
    end;
    TMeshWrapMode.Stretch:
    begin
      Result := RayCastCuboidIntersect(RayPos, RayDir, TPoint3D.Zero, Width, Height, Depth, NearIntersectionPoint, FarIntersectionPoint) > 0;
      if Result then
        Intersection := TPoint3D(LocalToAbsoluteVector(NearIntersectionPoint));
    end;
  end;
end;

procedure TCornerCube.RotateX(deg: single);
var
  m: TMatrix3D;
begin
  m := TMatrix3D.CreateRotationX(DegToRad(deg));
  if PreMultiply then
    FLocalMatrix := m * FLocalMatrix // local axis
  else
    FLocalMatrix := FLocalMatrix * m; // global axis
  RecalcAbsolute;
  Repaint;
end;

procedure TCornerCube.SetRotX(const Value: single);
var
  delta: single;
begin
  delta := Value - FRotX;
  RotateX(delta);
  FRotX := Value;
end;

procedure TCornerCube.SetDefaultPosZ(const Value: single);
begin
  FDefaultPosZ := Value;
  FPosZ := Value;
end;

procedure TCornerCube.SetPosZ(const Value: single);
begin
  FPosZ := Value;
  ResetRotationAngle;
  Position.Z := Value;
  RotationAngle.Y := 45;
  RotateX(FRotX);
end;

{ TColoredCornerCube }

constructor TColoredCornerCube.Create(AOwner: TComponent);
begin
  inherited;
  MaterialSource := TCornerCubeTextureMaterialSource.Create(Self);
end;

{ TCornerCubeTextureMaterialSource }

constructor TCornerCubeTextureMaterialSource.Create(AOwner: TComponent);
begin
  inherited;
  FColor1 := claSlateBlue; // +Z, front left
  FColor2 := claCornflowerblue; // +X, front right

  FColor3 := claYellow; // +Y, top
  FColor4 := claLime; // -Y, bottom

  FColor5 := claPlum; // -Z, back right
  FColor6 := claFuchsia; // -X, back left

  BMP := GenerateTextureBitmap;
  Texture := BMP;
end;

destructor TCornerCubeTextureMaterialSource.Destroy;
begin
  BMP.Free;
  inherited;
end;

function TCornerCubeTextureMaterialSource.GenerateTextureBitmap: TBitmap;
var
  Data: TBitmapData;
  i: Integer;
  cla: TAlphaColor;
begin
  result := TBitmap.Create(1, 10);
  if result.Map(TMapAccess.Write, Data) then
  begin
    for i := 0 to 9 do
    begin
      case i of
        0: cla := FColor1;
        1: cla := FColor2;
        2: cla := FColor3;
        3: cla := FColor4;
        4: cla := FColor5;
        5: cla := FColor6;
        else
          cla := claWhite;
      end;
      Data.SetPixel(0, i, cla);
    end;
    result.Unmap(Data);
  end;
end;

procedure TCornerCube.AddReport(SL: TStrings);
begin
  SL.Add(Format('%s', [ClassName]));

  if Name <> '' then
    SL.Add(Format('Name = %s', [Name]));
end;

end.
