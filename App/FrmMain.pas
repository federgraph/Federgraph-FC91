unit FrmMain;

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
  System.Types,
  System.UITypes,
  System.Classes,
  System.Math.Vectors,
  System.UIConsts,
  RiggVar.FB.DefConst,
  RiggVar.FB.Equation,
  RiggVar.FB.MeshParams,
  RiggVar.Mesh.BuilderMesh,
  RiggVar.Mesh.MeshBuilder,
  RiggVar.FederModel.Material,
  FMX.Controls3D,
  FMX.Objects3D,
  FMX.Viewport3D,
  FMX.Types3D,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs;

type
  TFederMessageKind = (
    fmkTX,
    fmkTY,
    fmkRX,
    fmkRY,
    fmkRZ
  );

  TFormMain = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
  private
    Down: TPointF;
    MouseDown: Boolean;
    FormShown: Boolean;
    FederMaterial: TFederMaterial;
    Mesh: TBuilderMesh;
    MeshBuilder: TFederMeshBuilder;
    FrontLight: TLight;
    BackLight: TLight;
    WestLight: TLight;
    EastLight: TLight;
    NorthLight: TLight;
    SouthLight: TLight;
    ZoomText: string;
    procedure DoZoom(Delta: single);
    procedure HandleMouseDown(Shift: TShiftState; X, Y: Single);
    procedure HandleMouseMove(Shift: TShiftState; X, Y: Single);
    procedure Init;
    procedure InitCamera;
    procedure InitLight;
    procedure InitMaterial;
    procedure InitMesh;
    procedure InitViewport;
    procedure ResetCamera;
    procedure UpdateRotation;
    procedure ViewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ViewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure ViewportMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  public
    claBackground: TAlphaColor;
    Camera: TCamera;
    CameraDummy: TDummy;
    CameraDummyRotationAngle: TPoint3D;
    FederEquation: TFederEquation;
    MeshParams: TMeshParams;
    Viewport: TViewport3D;
    procedure HandleKey(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

{ TFormMain }

procedure TFormMain.DoZoom(Delta: single);
var
  l: single;
  CameraZ: single;
begin
  if FormShown then
  begin
    CameraZ := Camera.Position.Z;

    l := CameraZ + Delta * 3;

    if l < 4 then
      l := 4;
    if l > 16 then
      l := 16;

    Camera.Position.Z := l;
    ZoomText := IntToStr(Round(l));
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  MeshParams.Free;
  FederEquation.Free;
  MeshBuilder.Free;
  FederMaterial.Free;
end;

procedure TFormMain.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  i: single;
begin
  if WheelDelta > 0 then
    i := 1
  else if WheelDelta < 0 then
    i := -1
  else
    i := 0;

  if ssCtrl in Shift then
  begin
    DoZoom(i);
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  if not FormShown then
  begin
    FormShown := True;
    Viewport.SetFocus;
  end;
end;

procedure TFormMain.HandleMouseDown(Shift: TShiftState; X, Y: Single);
begin
  Down := PointF(X, Y);
end;

procedure TFormMain.HandleMouseMove(Shift: TShiftState; X, Y: Single);
begin
  if FormShown then
  begin
    if (ssCtrl in Shift) and (ssLeft in Shift) then
    begin
      Camera.Position.X := Camera.Position.X - ((X - Down.X) * 0.01);
      Camera.Position.Y := Camera.Position.Y + ((Y - Down.Y) * 0.01);
      Down := PointF(X, Y);
    end
    else if ssLeft in Shift then
    begin
      CameraDummyRotationAngle.X := CameraDummyRotationAngle.X - ((Y - Down.Y) * 0.2);
      CameraDummyRotationAngle.Y := CameraDummyRotationAngle.Y - ((X - Down.X) * 0.2);
      UpdateRotation;
      Down := PointF(X, Y);
    end
    else if ssRight in Shift then
    begin
      CameraDummyRotationAngle.Z := CameraDummyRotationAngle.Z + ((X - Down.X) * 0.3);
      UpdateRotation;
      Down := PointF(X, Y);
    end;
  end;
end;

procedure TFormMain.Init;
begin
  FormMain := self;

{$ifdef debug}
  ReportMemoryLeaksOnShutdown := True;
{$endif}

  FormatSettings.DecimalSeparator := '.';
  Caption := 'Federgraph ' + Application.Title.ToUpper;

  claBackground := StringToAlphaColor('#FF333333');

  InitViewport;
  InitCamera;
  InitLight;
  InitMaterial;
  InitMesh;
end;

procedure TFormMain.InitMaterial;
begin
  FederMaterial := TFederMaterial.Create;
end;

procedure TFormMain.InitMesh;
begin
  Mesh := TBuilderMesh.Create(Self);
  Mesh.Parent := Viewport;
  Mesh.WrapMode := TMeshWrapMode.Original;
  Mesh.HitTest := False;
  Mesh.TwoSide := True;
  Mesh.Scale.Point := TPoint3D.Create(0.02, 0.02, 0.02);
  Mesh.MaterialSource := FederMaterial.MaterialSource;

  FederEquation := TFederEquation.Create;

  MeshParams := TMeshParams.Create(FederEquation);
  MeshParams.ReducedMesh := True;
  MeshParams.ReduceMode := 3;
  MeshParams.PlusCap := True;
  MeshParams.WantSlicePulling := False;
  MeshParams.SlicePullingMode := 3;
  MeshParams.WantFlippedHands := True;
  MeshParams.WantUniqueVertices := True;
  MeshParams.UniqueMode := 2;

  MeshBuilder := TFederMeshBuilder.Create;
  MeshBuilder.vp := MeshParams;
  MeshBuilder.WantUpdateTE := True;
  MeshBuilder.InitData;
  MeshBuilder.Update3DBuffers(Mesh.Data.VertexBuffer, Mesh.Data.IndexBuffer);
  Mesh.Data.CalcFaceNormals;
end;

procedure TFormMain.InitCamera;
begin
  CameraDummy := TDummy.Create(Self);
  CameraDummy.Parent := Viewport;
  Viewport.AddObject(CameraDummy);

  Camera := TCamera.Create(Self);
  Camera.Parent := Viewport;
  CameraDummy.AddObject(Camera);

  Viewport.Camera := Camera;

  ResetCamera;
end;

procedure TFormMain.InitLight;
begin
  FrontLight := TLight.Create(Self);
  FrontLight.LightType := TLightType.Directional;
  Viewport.AddObject(FrontLight);

  BackLight := TLight.Create(Self);
  BackLight.LightType := TLightType.Point;
  BackLight.Position.Z := LightConst.Back;
  BackLight.Color := claWhite;
  Viewport.AddObject(BackLight);

  WestLight := TLight.Create(Self);
  WestLight.LightType := TLightType.Point;
  WestLight.Position.X := LightConst.West;
  WestLight.Position.Z := LightConst.WestZ;
  WestLight.Color := claLime;
  Viewport.AddObject(WestLight);

  EastLight := TLight.Create(Self);
  EastLight.LightType := TLightType.Point;
  EastLight.Position.X := LightConst.East;
  EastLight.Position.Z := LightConst.WestZ;
  EastLight.Color := claFuchsia;
  Viewport.AddObject(EastLight);

  NorthLight := TLight.Create(Self);
  NorthLight.LightType := TLightType.Point;
  NorthLight.Position.Y := LightConst.North;
  NorthLight.Color := claWhite;
  Viewport.AddObject(NorthLight);

  SouthLight := TLight.Create(Self);
  SouthLight.LightType := TLightType.Point;
  SouthLight.Position.Y := LightConst.South;
  SouthLight.Color := claWhite;
  Viewport.AddObject(SouthLight);
end;

procedure TFormMain.InitViewport;
begin
  Viewport := TViewport3D.Create(self);
  Viewport.Parent := self;
  Viewport.UsingDesignCamera := False;
  Viewport.Align := TAlignLayout.Client; // set Alignment after setting Parent

{$ifdef MSWindows}
  Viewport.OnKeyUp := HandleKey;
{$endif}
{$ifdef MacOS}
  Viewport.OnKeyDown := HandleKey;
{$endif}

  Viewport.OnMouseDown := ViewportMouseDown;
  Viewport.OnMouseMove := ViewportMouseMove;
  Viewport.OnMouseUp := ViewportMouseUp;

  Viewport.Color := claBackground;
  Viewport.CanFocus := true;
end;

procedure TFormMain.ResetCamera;
begin
  { CameraDummy }

  CameraDummy.Position.X := 0;
  CameraDummy.Position.Y := 0;
  CameraDummy.Position.Z := 0;

  CameraDummyRotationAngle := TPoint3D.Create(180, 0, 0);
  UpdateRotation;

  { Camera }

  Camera.Position.X := 0.0;
  Camera.Position.Y := 0.0;
  Camera.Position.Z := 8.0;

  Camera.ResetRotationAngle;
  Camera.RotationAngle.X := 180;
  Camera.RotationAngle.Y := 0;
  Camera.RotationAngle.Z := 0;
end;

procedure TFormMain.UpdateRotation;
begin
  CameraDummy.ResetRotationAngle;
  CameraDummy.RotationAngle.Point := CameraDummyRotationAngle;
end;

procedure TFormMain.HandleKey(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin

  if KeyChar = ' ' then
  begin
    Mesh.ShowEdges := not Mesh.ShowEdges;
    Mesh.Repaint;
    Exit;
  end

end;

procedure TFormMain.ViewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MouseDown := True;
  HandleMouseDown(Shift, X, Y);
end;

procedure TFormMain.ViewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  if MouseDown then
    HandleMouseMove(Shift, X, Y);
end;

procedure TFormMain.ViewportMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MouseDown := False;
end;

end.
