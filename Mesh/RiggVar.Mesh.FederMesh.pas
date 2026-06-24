unit RiggVar.Mesh.FederMesh;

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

{$define WantFix}

uses
  System.SysUtils,
  System.RTLConsts,
  System.Classes,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Math.Vectors,
  FMX.Graphics,
  FMX.Types3D,
  FMX.Objects3D,
  FMX.Controls3D,
  FMX.Types,
  FMX.Materials,
  FMX.MaterialSources,
  RiggVar.FB.MeshParams,
  RiggVar.Mesh.BuilderMesh,
  RiggVar.Mesh.MeshBuilder,
  RiggVar.Mesh.MeshDataHelper;

type
  TFederMesh = class(TBuilderMesh)
  private
    FPickVertice0: Integer;
    FOnRingPicked: TNotifyEvent;
    FFederMeshBuilder: TFederMeshBuilder;
    procedure ProcessPick;
    procedure SetOnRingPicked(const Value: TNotifyEvent);
    procedure SetMeshParams(const Value: TMeshParams);
    procedure SetFederMeshBuilder(const Value: TFederMeshBuilder);
  protected
    vp: TMeshParams;
{$ifdef WantFix}
    function DoRayCastIntersect(
      const RayPos, RayDir: TPoint3D;
      var Intersection: TPoint3D): Boolean; override;
{$endif}
  public
    MeshChanged: Boolean;
    WantFlippedHands: Boolean;
    WantMirroredBottom: Boolean;

    constructor Create(AOwner: TComponent); override;

    procedure InitGraph;
    procedure InitData;
    procedure UpdateColor;
    procedure PickRing(X, Y: Single);
    procedure ToggleTwoSide;

    property FederMeshBuilder: TFederMeshBuilder read FFederMeshBuilder write SetFederMeshBuilder;
    property MeshParams: TMeshParams read vp write SetMeshParams;
    property OnRingPicked: TNotifyEvent read FOnRingPicked write SetOnRingPicked;
  published
    property Data;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederMesh }

constructor TFederMesh.Create(AOwner: TComponent);
begin
  inherited;
  FederMeshBuilder := TFederMeshBuilder.Create;
end;

{$ifdef WantFix}
function TFederMesh.DoRayCastIntersect(const RayPos, RayDir: TPoint3D;
  var Intersection: TPoint3D): Boolean;
var
  lv, av: TVector3D;
begin
  if Data.RayCastIntersect(Width, Height, Depth, RayPos, RayDir, Intersection)
  then
  begin
    lv := TVector3D.Create(Intersection, 1.0);
    av := LocalToAbsoluteVector(lv);
    Intersection := TPoint3D.Create(av.X, av.Y, av.Z);
    Result := True;
  end
  else if csDesigning in ComponentState then
    Result := inherited
  else
    Result := False;
end;
{$endif}

procedure TFederMesh.InitGraph;
var
  f: single;
begin
  f := MainVar.Transform3D.GlobalScale;
  Scale.X := f;
  Scale.Y := f;
  Scale.Z := f;

  RotationAngle.X := 0.0;
  RotationAngle.Y := 0.0;
  RotationAngle.Z := 0.0;

  Position.X := 0.0;
  Position.Y := 0.0;
  Position.Z := 0.0;

  Width := 1.0;
  Height := 1.0;
  Depth := 1.0;

  TwoSide := True;
  Opacity := 1.0;

  WrapMode := TMeshWrapMode.Original;
  MaterialSource := Main.MaterialSource;
  HitTest := False;
end;

procedure TFederMesh.InitData;
var
  VB: TVertexBuffer;
  IB: TIndexBuffer;
begin
  FederMeshBuilder.LoopFaktor := Main.LoopFaktor;
  FederMeshBuilder.InitData;

  if vp.GlobalScale = 1.0 then
    MeshBuilder.Normalize(1.0)
  else
    MeshBuilder.GetMinMax;

  Data.Clear;

  VB := Data.VertexBuffer;
  IB := Data.IndexBuffer;
  MeshBuilder.Update3DBuffers(VB, IB);

  if vp.WantLux then
  begin
    Data.CalcFaceNormals;
  end;
end;

procedure TFederMesh.UpdateColor;
var
  i: Integer;
  P: TPointF;
  x, y: single;
begin
  vp.InitTE;
  for i := 0 to Data.VertexBuffer.Length - 1 do
  begin
    P := Data.VertexBuffer.TexCoord0[i];
    x := P.X * vp.ot2 - vp.ot1;
    y := P.Y * vp.ot2 - vp.ot1;
    Data.VertexBuffer.TexCoord0[i] := PointF((x+vp.te1)/vp.te2,(y+vp.te1)/vp.te2);
  end;
  vp.SaveTE;
end;

procedure TFederMesh.PickRing(X, Y: Single);
var
  vRayPos, vRayDir: TVector3D;
  pRayPos, pRayDir: TPoint3D;
  pIntersection: TPoint3D;
  temp: TPoint3D;
  w, h, d: single;
  s: single;
begin
  Main.CurrentRing := 0;
  Context.Pick(X, Y, TProjection.Camera, vRayPos, vRayDir);
  pRayDir := TPoint3D.Create(vRayDir.X, vRayDir.Y, vRayDir.Z);
  pRayPos := TPoint3D.Create(vRayPos.X, vRayPos.Y, vRayPos.Z);
  if RayCastIntersect(pRayPos, pRayDir, pIntersection) then
  begin
    s := vp.GlobalScale * vp.ModelGroupScale;
    w := Width  * s;
    h := Height * s;
    d := Depth  * s;

    temp := Data.RayCastIntersectRing(
      w,
      h,
      d,
      pRayPos, pRayDir, pIntersection);

    FPickVertice0 := Round(temp.X);

    if FPickVertice0 > -1 then
    begin
      ProcessPick;
      if Assigned(OnRingPicked) then
      begin
        OnRingPicked(nil);
      end;
    end;
  end;
end;

procedure TFederMesh.ProcessPick;
var
  v0: Integer;
  t: single;
  P: TPoint3D;
begin
  v0 := FPickVertice0;
  if (v0 > -1) and (v0 < Data.VertexBuffer.Length) then
  begin
    P := Data.VertexBuffer.Vertices[v0];
    t := Data.VertexBuffer.TexCoord0[v0].Y;
    Main.UpdateCurrentRing(t);
  end;
end;

procedure TFederMesh.SetFederMeshBuilder(const Value: TFederMeshBuilder);
begin
  FFederMeshBuilder := Value;
  MeshBuilder := Value;
end;

procedure TFederMesh.SetMeshParams(const Value: TMeshParams);
begin
  vp := Value;
  FederMeshBuilder.vp := Value;
end;

procedure TFederMesh.SetOnRingPicked(const Value: TNotifyEvent);
begin
  FOnRingPicked := Value;
end;

procedure TFederMesh.ToggleTwoSide;
begin
  TwoSide := not TwoSide;
  Main.GraphUpdateNeeded;
end;

end.
