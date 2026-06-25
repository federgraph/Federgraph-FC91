unit RiggVar.FederModel.Graph;

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
  System.Types,
  System.Math,
  System.Math.Vectors,
  System.UITypes,
  System.UIConsts,
  FMX.Graphics,
  FMX.Types3D,
  FMX.Objects3D,
  FMX.Controls3D,
  FMX.Types,
  FMX.Materials,
  FMX.MaterialSources,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Equation,
  RiggVar.FB.Graph,
  RiggVar.FB.MeshParams,
  RiggVar.FB.Model,
  RiggVar.FederModel.CornerCube,
  RiggVar.FederModel.CornerPlane,
  RiggVar.Mesh.FederMesh,
  RiggVar.Bitmap.Texture;

type
  TFederSceneOne = class(TFederSceneBase)
  private
    FNewBitmap: Integer;

    FStatusText: string;
    cP: char;
    cL: char;
    cF: char;
    cO: char;
    cR: char;

    function CurrentLightMarker(Value: Integer): Char;
    function GetInitDataOK: Boolean;
    procedure SetInitDataOK(const Value: Boolean);

    procedure UpdateMeshStatus;
    procedure AssignBitmap;
    function GetFederMesh: TFederMesh;
  protected
    ModelParent: TControl3D;
    ModelOwner: TComponent;

    Grid: TGrid3D;

    Kugel1: TShape3D;
    Kugel2: TShape3D;
    Kugel3: TShape3D;
    Kugel4: TShape3D;
    Material1: TLightMaterialSource;
    Material2: TLightMaterialSource;
    Material3: TLightMaterialSource;
    Material4: TLightMaterialSource;

    Cylinder1: TEllipse3D;
    Cylinder2: TEllipse3D;
    MaterialC1: TLightMaterialSource;
    MaterialC2: TLightMaterialSource;

    Diameter1: TPlane;
    Diameter3: TPlane;
    MaterialD1: TLightMaterialSource;
    MaterialD3: TLightMaterialSource;

    LabelText: TText3D;
    LabelTextMaterial: TLightMaterialSource;

    MaterialSourceL: TLightMaterialSource;
    MaterialSourceT: TTextureMaterialSource;

    FModelGroup: TFederDummy;

    procedure InitModel;
    procedure InitCornerCube(cr: TShape3D);
    procedure InitCornerPlane(cr: TCornerPlane; ms: TMaterialSource);
    procedure InitLimitPlane(cr: TCornerPlane; ms: TMaterialSource);
    procedure InitAxis(cr: TShape3D; ms: TMaterialSource);
    procedure InitCylinder(cr: TEllipse3D);
    procedure InitDiameter(cr: TPlane);

    procedure SetGridFrequency(const Value: Integer); override;

    procedure SetWantLux1(const Value: Boolean); override;
    procedure SetWantLux2(const Value: Boolean); override;
    procedure SetWantLux3(const Value: Boolean); override;
    procedure SetWantLux4(const Value: Boolean); override;

    procedure SetShowKugel(const Value: Boolean); override;
    procedure SetShowGrid(const Value: Boolean); override;
    procedure SetShowLabel(const Value: Boolean); override;
    procedure SetShowCube(const Value: Boolean); override;
    procedure SetShowCorner(const Value: Boolean); override;
    procedure SetShowLimitPlane(const Value: Boolean); override;
    procedure SetShowCylinder(const Value: Boolean); override;
    procedure SetShowDiameter(const Value: Boolean); override;
    procedure SetShowLuxMarker(const Value: Boolean); override;

    function GetModelGroupScale: single; override;
    procedure SetModelGroupScale(const Value: single); override;
    procedure SetLabelTextScale(const Value: single); override;

    function GetModelGroup: TFederDummy;

    function GetRotationInfo(rp: TPoint3D): TPoint3D;

    procedure ResetLux(Value: Integer);
    procedure ResetLuxAll;
    procedure EnsureLight;

    procedure UpdateCylinder;
    procedure UpdateDiameter;
  public
    FT1: Integer;
    FT2: Integer;
    WantFlimmer: Boolean;

    CornerCube: TColoredCornerCube;

    CornerPlane1: TCornerPlane;
    CornerPlane2: TCornerPlane;
    CornerPlaneMaterial1: TColorMaterialSource;
    CornerPlaneMaterial2: TColorMaterialSource;

    LimitPlane: TCornerPlane;
    LimitPlaneMaterial: TColorMaterialSource;

    CreateLux1: Boolean;
    Lux1: TLight;
    Lux1Cone: TCone;
    Lux1ConeMaterial: TLightMaterialSource;

    CreateLux2: Boolean;
    Lux2: TLight;
    Lux2Cone: TCone;
    Lux2ConeMaterial: TLightMaterialSource;

    CreateLux3: Boolean;
    Lux3: TLight;
    Lux3Cone: TCone;
    Lux3ConeMaterial: TColorMaterialSource;

    CreateLux4: Boolean;
    Lux4: TLight;
    Lux4Cone: TCone;
    Lux4ConeMaterial: TColorMaterialSource;

    FrontLight: TLight;
    BackLight: TLight;
    WestLight: TLight;
    EastLight: TLight;
    NorthLight: TLight;
    SouthLight: TLight;

    constructor Create;
    destructor Destroy; override;

    function GetModelGroupPos: TPoint3D; override;
    function GetModelGroupRot: TPoint3D; override;

    procedure SetParamValue(fp: TFederParam; Value: single); override;
    function GetParamValue(fp: TFederParam): single; override;
    function GetLuxParamValue(fp: TFederParam): single; override;

    procedure ResetLightPosition; override;
    procedure UpdateLight; override;
    procedure UpdateProbe; override;
    procedure UpdateLimitPlane; override;
  protected
    procedure SetBitmap(const Value: Integer); override;
    procedure SetOpacity(const Value: single); override;
    procedure SetOpenMesh(const Value: Boolean); override;
    procedure SetPolarMesh(const Value: Boolean); override;
    procedure SetWantLux(const Value: Boolean); override;
    procedure SetReducedMesh(const Value: Boolean); override;
    procedure SetModulationColor(const Value: TAlphaColor); override;

    procedure SetIsOpaque(const Value: Boolean); override;
    function GetIsOpaque: Boolean; override;

    function GetTextureLock: Boolean; override;
    procedure SetTextureLock(const Value: Boolean); override;

    function GetTextureBitmapText: string; override;
    function GetMeshStatusText: string; override;
    function GetMaterialSource: TMaterialSource; override;
  public
    procedure ResetFBitmap;
    procedure InitBitmap; override;
    procedure Init; override;
    procedure UpdateAxis;

    procedure ResetDataRandom(ID: Integer); override;

    procedure GetMatrixInfo(SL: TStrings); override;
    procedure GetLightInfo(SL: TStrings); override;

    procedure InitGraph(BitmapIndex: Integer); override;
    procedure SaveToFederData(fd: TFederData); override;
    procedure LoadFromFederData(fd: TFederData); override;

    procedure LoadBitmap(Image: TBitmap); override;
    procedure ForceBitmap(const Value: Integer); override;
    procedure EnsureBitmap; override;
    procedure EnsureBitmapStrip(cs: TColorStrip); override;

    procedure ModulateColor; override;
    procedure MoveColor(NewColor: TAlphaColor); override;
    function GetLuxColor(Value: Integer): TAlphaColor; override;

    property InitDataOK: Boolean read GetInitDataOK write SetInitDataOK;
    property FederMesh: TFederMesh read GetFederMesh;
    property ModelGroup: TFederDummy read GetModelGroup;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FB.Classes;

{ TFederSceneOne }

constructor TFederSceneOne.Create;
begin
  inherited;
  FReduceMode := 0;
  FOpacity := 1.0;
  FBitmap := 1;
  FLinearMesh := True;
  FOpenMesh := False;
  FPolarMesh := True;
  FFilterMesh := False;
  FModulationColor := claWhite;

  MaterialSourceL := TLightMaterialSource.Create(nil);
  MaterialSourceL.Shininess := 30;
  MaterialSourceL.Diffuse := claWhite;
  MaterialSourceL.Specular := claWhite;

  MaterialSourceT := TTextureMaterialSource.Create(nil);

  FBitmap := 17;
  InitBitmap;
end;

destructor TFederSceneOne.Destroy;
begin
  BMP.Free;
  MaterialSourceL.Free;
  MaterialSourceT.Free;
  inherited;
end;

function TFederSceneOne.GetFederMesh: TFederMesh;
begin
  result := Main.FederMesh;
end;

procedure TFederSceneOne.InitModel;
begin
  CreateLux1 := True;
  CreateLux2 := True;
  CreateLux3 := True;
  CreateLux4 := True;

  if not Assigned(FModelGroup) then
  begin
    FModelGroup := TFederDummy.Create(Main.Viewport);
    FModelGroup.Parent := Main.Viewport;

    ModelOwner := Main.Viewport;
    ModelParent := ModelGroup;

    Material1 := TLightMaterialSource.Create(ModelOwner);
    Material1.Emissive := claRed;
    Material2 := TLightMaterialSource.Create(ModelOwner);
    Material2.Emissive := claGreen;
    Material3 := TLightMaterialSource.Create(ModelOwner);
    Material3.Emissive := claBlue;
    Material4 := TLightMaterialSource.Create(ModelOwner);
    Material4.Emissive := claYellow;

    Kugel1 := TCone.Create(ModelOwner);
    Kugel2 := TCone.Create(ModelOwner);
    Kugel3 := TCone.Create(ModelOwner);
    Kugel4 := TCone.Create(ModelOwner);
    Kugel1.Name := 'Kugel1';
    Kugel2.Name := 'Kugel2';
    Kugel3.Name := 'Kugel3';
    Kugel4.Name := 'Kugel4';

    Cylinder1 := TEllipse3D.Create(ModelOwner);
    Cylinder2 := TEllipse3D.Create(ModelOwner);
    Diameter1 := TPlane.Create(ModelOwner);
    Diameter3 := TPlane.Create(ModelOwner);
    Cylinder1.Name := 'Cylinder1';
    Cylinder2.Name := 'Cylinder2';
    Diameter1.Name := 'Diameter1';
    Diameter3.Name := 'Diameter3';

    InitAxis(Kugel1, Material1);
    InitAxis(Kugel2, Material2);
    InitAxis(Kugel3, Material3);
    InitAxis(Kugel4, Material4);
    InitCylinder(Cylinder1);
    InitCylinder(Cylinder2);
    InitDiameter(Diameter1);
    InitDiameter(Diameter3);

    Grid := TGrid3D.Create(ModelOwner);
    Grid.Width := 300;
    Grid.Height := 300;
    GridFrequency := 10;
    Grid.Marks := 50;
    Grid.HitTest := False;
    Grid.LineColor := claGray;
    Grid.Scale.X := MainVar.Transform3D.GlobalScale;
    Grid.Scale.Y := MainVar.Transform3D.GlobalScale;
    Grid.Scale.Z := MainVar.Transform3D.GlobalScale;
    Grid.Name := 'Grid';
    ModelParent.AddObject(Grid);

    LabelTextMaterial := TLightMaterialSource.Create(ModelOwner);
    LabelTextMaterial.Emissive := claNavy;
    LabelTextMaterial.Ambient := claNavy;
    LabelText := TText3D.Create(ModelOwner);
    LabelText.TwoSide := False;
    LabelText.WordWrap := False;
    LabelText.HitTest := False;
    LabelText.Sides := [TExtrudedShapeSide.Front, TExtrudedShapeSide.Shaft, TExtrudedShapeSide.Back];
    LabelText.Width := 5;
    LabelText.Height := 1.5;
    LabelText.Depth := 0.2;
    LabelText.MaterialSource := LabelTextMaterial;
    LabelText.MaterialBackSource := LabelTextMaterial;
    LabelText.MaterialShaftSource := LabelTextMaterial;
    LabelText.Text := 'Federgraph';
    LabelText.Opacity := 0.5;
    LabelText.Position.Z := 0;
    LabelText.Visible := False;
    LabelText.Name := 'LabelText';
    ModelParent.AddObject(LabelText);

    FrontLight := TLight.Create(ModelOwner);
    FrontLight.LightType := TLightType.Directional;

    BackLight := TLight.Create(ModelOwner);
    BackLight.LightType := TLightType.Point;
    BackLight.Position.Z := LightConst.Back;
    BackLight.Color := claWhite;

    WestLight := TLight.Create(ModelOwner);
    WestLight.LightType := TLightType.Point;
    WestLight.Position.X := LightConst.West;
    WestLight.Color := claLime;

    EastLight := TLight.Create(ModelOwner);
    EastLight.LightType := TLightType.Point;
    EastLight.Position.X := LightConst.East;
    EastLight.Color := claFuchsia;

    NorthLight := TLight.Create(ModelOwner);
    NorthLight.LightType := TLightType.Point;
    NorthLight.Position.Y := LightConst.North;
    NorthLight.Color := claWhite;

    SouthLight := TLight.Create(ModelOwner);
    SouthLight.LightType := TLightType.Point;
    SouthLight.Position.Y := LightConst.South;
    SouthLight.Color := claWhite;

    Lux1 := FrontLight;
    Lux2 := BackLight;
    Lux3 := WestLight;
    Lux4 := NorthLight;

    ModelParent.AddObject(FrontLight);
    ModelParent.AddObject(BackLight);
    ModelParent.AddObject(WestLight);
    ModelParent.AddObject(EastLight);
    ModelParent.AddObject(NorthLight);
    ModelParent.AddObject(SouthLight);

    Lux1ConeMaterial := TLightMaterialSource.Create(ModelOwner);
    Lux1ConeMaterial.Emissive := claFuchsia;
    Lux1Cone := TCone.Create(ModelOwner);
    InitAxis(Lux1Cone, Lux1ConeMaterial);

    Lux2ConeMaterial := TLightMaterialSource.Create(ModelOwner);
    Lux2ConeMaterial.Emissive := claAqua;
    Lux2Cone := TCone.Create(ModelOwner);
    InitAxis(Lux2Cone, Lux2ConeMaterial);

    Lux3ConeMaterial := TColorMaterialSource.Create(ModelOwner);
    Lux3ConeMaterial.Color := claLime;
    Lux3Cone := TCone.Create(ModelOwner);
    InitAxis(Lux3Cone, Lux3ConeMaterial);

    Lux4ConeMaterial := TColorMaterialSource.Create(ModelOwner);
    Lux4ConeMaterial.Color := claGray;
    Lux4Cone := TCone.Create(ModelOwner);
    InitAxis(Lux4Cone, Lux4ConeMaterial);

    CornerCube := TColoredCornerCube.Create(ModelOwner);
    CornerCube.DefaultPosZ := 20;
    CornerCube.Visible := False;
    InitCornerCube(CornerCube);

    CornerPlaneMaterial1 := TColorMaterialSource.Create(ModelOwner);
    CornerPlaneMaterial1.Color := claSlateblue;
    CornerPlane1 := TCornerPlane.Create(ModelOwner);
    CornerPlane1.RotY := -45;
    InitCornerPlane(CornerPlane1, CornerPlaneMaterial1);

    CornerPlaneMaterial2 := TColorMaterialSource.Create(ModelOwner);
    CornerPlaneMaterial2.Color := claNavy;
    CornerPlane2 := TCornerPlane.Create(ModelOwner);
    CornerPlane2.RotY := 45;
    InitCornerPlane(CornerPlane2, CornerPlaneMaterial2);

    LimitPlaneMaterial := TColorMaterialSource.Create(ModelOwner);
    LimitPlaneMaterial.Color := claWhite;
    LimitPlane := TCornerPlane.Create(ModelOwner);
    LimitPlane.Opacity := 0.5;
    InitLimitPlane(LimitPlane, LimitPlaneMaterial);
    UpdateLimitPlane;

    ShowLuxMarker := False;

    Main.Viewport.AddObject(ModelGroup);
  end;
end;

procedure TFederSceneOne.InitCylinder(cr: TEllipse3D);
begin
  if cr = Cylinder1 then
  begin
    MaterialC1 := TLightMaterialSource.Create(ModelOwner);
    MaterialC1.Emissive := claAqua;
  end
  else
  begin
    MaterialC2 := TLightMaterialSource.Create(ModelOwner);
    MaterialC2.Emissive := claBlue;
  end;

  cr.HitTest := False;
  cr.Depth := 10;
  cr.Parent := ModelParent;
  cr.Sides := [TExtrudedShapeSide.Shaft];
  cr.Flatness := 0.1;
  cr.TwoSide := True;
  if cr = Cylinder1 then
    cr.MaterialShaftSource := MaterialC1
  else
    cr.MaterialShaftSource := MaterialC2;
  cr.Position.Z := 5;
  cr.Visible := False;
  ModelParent.AddObject(cr);

  UpdateCylinder;
end;

procedure TFederSceneOne.InitDiameter(cr: TPlane);
begin
  if cr = Diameter1 then
  begin
    MaterialD1 := TLightMaterialSource.Create(ModelOwner);
    MaterialD1.Emissive := claOrange;
  end
  else
  begin
    MaterialD3 := TLightMaterialSource.Create(ModelOwner);
    MaterialD3.Emissive := claIndianRed;
  end;

  cr.HitTest := False;
  cr.Parent := ModelParent;
  cr.TwoSide := True;
  if cr = Diameter1 then
    cr.MaterialSource := MaterialD1
  else
    cr.MaterialSource := MaterialD3;
  cr.Position.Z := 5;
  cr.Visible := False;
  ModelParent.AddObject(cr);

  UpdateDiameter;
end;

procedure TFederSceneOne.InitCornerCube(cr: TShape3D);
var
  d: single;
begin
  d := 5.0;
  cr.Scale.X := 80;
  cr.Scale.Y := 80;
  cr.Scale.Z := 80;
  cr.Position.Z := 20;

  cr.Width := d * MainVar.Transform3D.GlobalScale;
  cr.Height := d * MainVar.Transform3D.GlobalScale;
  cr.Depth := d * MainVar.Transform3D.GlobalScale;
  cr.Parent := ModelParent;
  cr.RotationAngle.Y := 45;
  cr.HitTest := False;
  cr.Visible := False;
  ModelParent.AddObject(cr);
end;

procedure TFederSceneOne.InitCornerPlane(cr: TCornerPlane; ms: TMaterialSource);
begin
  cr.Width := 400 * MainVar.Transform3D.GlobalScale;
  cr.Height := 400 * MainVar.Transform3D.GlobalScale;

  cr.DefaultPosZ := 10;

  if cr = CornerPlane1 then
  begin
    cr.Position.X := cr.Width / 2 * cos(DegToRad(cr.RotY));
  end
  else
  begin
    cr.Position.X := -cr.Width / 2 * cos(DegToRad(cr.RotY));
  end;

  cr.RotationAngle.Y := cr.RotY;
  cr.Position.Z := cr.PosZ;

  cr.Parent := ModelParent;
  cr.TwoSide := True;
  cr.MaterialSource := ms;
  cr.HitTest := False;
  cr.Visible := ShowCorner;
  ModelParent.AddObject(cr);
end;

procedure TFederSceneOne.InitLimitPlane(cr: TCornerPlane; ms: TMaterialSource);
begin
  cr.Width := 400 * MainVar.Transform3D.GlobalScale;
  cr.Height := 400 * MainVar.Transform3D.GlobalScale;

  cr.DefaultPosZ := 100;

  cr.Position.Z := cr.PosZ;

  cr.Parent := ModelParent;
  cr.TwoSide := True;
  cr.MaterialSource := ms;
  cr.HitTest := False;
  cr.Visible := ShowLimitPlane;
  ModelParent.AddObject(cr);
end;

procedure TFederSceneOne.InitAxis(cr: TShape3D; ms: TMaterialSource);
var
  d: single;
  f: single;
begin
  d := 5.0;
  f := MainVar.Transform3D.GlobalScale;
  cr.Width := d * f;
  cr.Height := d * f;
  cr.Depth := d * f;
  cr.Parent := ModelParent;
  cr.MaterialSource := ms;
  cr.RotationAngle.X := 90;
  ModelParent.AddObject(cr);
end;

procedure TFederSceneOne.EnsureLight;
begin
  if Assigned(Lux1)
  and Assigned(Lux2)
  and Assigned(Lux3)
  and Assigned(Lux4)
  then
  begin
    if (Lux1.Enabled = False)
      and (Lux2.Enabled = False)
      and (Lux3.Enabled = False)
      and (Lux4.Enabled = False)
    then
      WantLux1 := True;
      if Lux1.Position.Z = 0 then
      begin
        Main.FederModel.Lux1Z := -1;
      end;
  end;
end;

{$Hints off}
procedure TFederSceneOne.UpdateAxis;
var
  eq: TFederEquation;
  f: single;
begin
  if FShowKugel and (Kugel1 <> nil) then
  begin
    eq := Main.FederModel.EQ;
    f := MainVar.Transform3D.GlobalScale;
    Kugel1.Position.X := eq.x1 * f;
    Kugel1.Position.Y := eq.y1 * f;
    Kugel2.Position.X := eq.x2 * f;
    Kugel2.Position.Y := eq.y2 * f;
    Kugel3.Position.X := eq.x3 * f;
    Kugel3.Position.Y := eq.y3 * f;
    Kugel4.Position.X := eq.x4 * f;
    Kugel4.Position.Y := eq.y4 * f;
  end;
end;
{$Hints on}

procedure TFederSceneOne.UpdateLimitPlane;
var
  fm: TFederModel;
  f: single;
begin
  if not Assigned(LimitPlane) then
    Exit;
  fm := Main.FederModel;
  f := MainVar.Transform3D.GlobalScale;
  LimitPlane.PosZ := f * fm.CapValue + 1;
end;

procedure TFederSceneOne.UpdateProbe;
begin
  if Assigned(Cylinder1) then
  begin
    UpdateCylinder;
    UpdateDiameter;
  end;
end;

procedure TFederSceneOne.UpdateCylinder;
var
  w, h: single;
  fm: TFederModel;
  f: single;
begin
  fm := Main.FederModel;
  f := MainVar.Transform3D.GlobalScale;
  w := abs(fm.ParamBahnRadius * 2 * f);
  h := abs(fm.ParamBahnRadius * 2 * f);
  if w < 0.1 then
    w := 0.1;
  if h < 0.1 then
    h := 0.1;

  if Assigned(Cylinder1) then
  begin
    Cylinder1.Flatness := w / 50;
    Cylinder1.Width := w;
    Cylinder1.Height := h;
    Cylinder1.Position.X := fm.ParamBahnPositionX * f;
    Cylinder1.Position.Y := fm.ParamBahnPositionY * f;
    Cylinder1.Depth := fm.ParamBahnCylinderD;
    Cylinder1.Position.Z := Cylinder1.Depth / 2 - fm.ParamBahnCylinderZ;
  end;

  if Assigned(Cylinder2) then
  begin
    Cylinder2.Flatness := w / 50;
    Cylinder2.Width := w + 0.01;
    Cylinder2.Height := h + 0.01;
    Cylinder2.Position.X := fm.ParamBahnPositionX * f;
    Cylinder2.Position.Y := fm.ParamBahnPositionY * f;
    Cylinder2.Depth := fm.ParamBahnCylinderD;
    Cylinder2.Position.Z := Cylinder1.Depth / 2 - fm.ParamBahnCylinderZ;
  end;
end;

procedure TFederSceneOne.UpdateDiameter;
var
  w: single;
  fm: TFederModel;
  f: single;
begin
  fm := Main.FederModel;
  f := MainVar.Transform3D.GlobalScale;
  w := abs(fm.ParamBahnRadius * 2 * f);
  if w < 0.5 then
    w := 0.5;
  if Assigned(CornerCube) then
  begin
    if fm.Param = Integer(fpbcz) then
    begin
      CornerCube.PosZ := CornerCube.DefaultPosZ - fm.ParamBahnCylinderZ;
    end;
    if fm.Param = Integer(fpbpa) then
    begin
      CornerCube.RotX := fm.ParamBahnAngle;
    end;
  end;
  if Assigned(CornerPlane1) then
  begin
    if fm.Param = Integer(fpbcz) then
    begin
      CornerPlane1.PosZ := CornerPlane1.DefaultPosZ - fm.ParamBahnCylinderZ;
      CornerPlane2.PosZ := CornerPlane1.DefaultPosZ - fm.ParamBahnCylinderZ;
    end;
    if fm.Param = Integer(fpbpa) then
    begin
      CornerPlane1.RotX := fm.ParamBahnAngle;
      CornerPlane2.RotX := fm.ParamBahnAngle;
    end;
  end;
  if Assigned(Diameter1) then
  begin
    Diameter1.Width := w;
    Diameter1.Height := fm.ParamBahnCylinderD;
    Diameter1.Position.X := fm.ParamBahnPositionX * f;
    Diameter1.Position.Y := fm.ParamBahnPositionY * f;
    Diameter1.Position.Z := fm.ParamBahnCylinderD / 2 - fm.ParamBahnCylinderZ;
    Diameter1.RotationAngle.X := 90;
    Diameter1.RotationAngle.Y := -fm.ParamBahnAngle;
  end;
  if Assigned(Diameter3) then
  begin
    Diameter3.Width := w;
    Diameter3.Height := 10 * f;
    Diameter3.Position.X := fm.ParamBahnPositionX * f;
    Diameter3.Position.Y := fm.ParamBahnPositionY * f;
    Diameter3.Position.Z := fm.ParamBahnCylinderD / 2 - fm.ParamBahnCylinderZ;
    Diameter3.RotationAngle.Z := -fm.ParamBahnAngle;
  end;

end;

procedure TFederSceneOne.SetGridFrequency(const Value: Integer);
begin
  FGridFrequency := Value;
  Grid.Frequency := Value;
end;

procedure TFederSceneOne.SetShowCube(const Value: Boolean);
begin
  FShowCube := Value;
  if Assigned(CornerCube) then
  begin
    CornerCube.Visible := Value;
  end;
end;

procedure TFederSceneOne.SetShowCorner(const Value: Boolean);
begin
  FShowCorner := Value;
  if Assigned(CornerPlane1) then
  begin
    CornerPlane1.Visible := Value;
    CornerPlane2.Visible := Value;
  end;
end;

procedure TFederSceneOne.SetShowLimitPlane(const Value: Boolean);
begin
  FShowLimitPlane := Value;
  if Assigned(LimitPlane) then
  begin
    LimitPlane.Visible := Value;
  end;
end;

procedure TFederSceneOne.SetShowCylinder(const Value: Boolean);
begin
  FShowCylinder := Value;
  if Assigned(Cylinder1) then
  begin
    Cylinder1.Visible := Value;
    Cylinder2.Visible := Value;
  end;
end;

procedure TFederSceneOne.SetShowDiameter(const Value: Boolean);
begin
  FShowDiameter := Value;
  if Assigned(Diameter1) then
  begin
    Diameter1.Visible := Value;
    Diameter3.Visible := Value;
  end;
end;

procedure TFederSceneOne.SetShowGrid(const Value: Boolean);
begin
  FShowGrid := Value;
  if Assigned(Grid) then
  begin
    Grid.Visible := Value;
  end;
end;

procedure TFederSceneOne.SetShowKugel(const Value: Boolean);
var
  fm: TFederModel;
begin
  fm := Main.FederModel;
  FShowKugel := Value;
  if Assigned(Kugel1) then
  begin
    UpdateAxis;
    Kugel1.Visible := Value;
    Kugel2.Visible := Value and (fm.Scene > 1);
    Kugel3.Visible := Value and (fm.Scene > 2);
    Kugel4.Visible := Value and (fm.Scene > 3);
  end;
end;

procedure TFederSceneOne.SetShowLuxMarker(const Value: Boolean);
begin
  FShowLuxMarker := Value;
  if Assigned(Lux1Cone) then
  begin
    UpdateLight;
    Lux1Cone.Visible := Value;
    Lux2Cone.Visible := Value;
    Lux3Cone.Visible := Value;
    Lux4Cone.Visible := Value;
  end;
end;

procedure TFederSceneOne.SetShowLabel(const Value: Boolean);
begin
  FShowLabel := Value;
  if Assigned(LabelText) then
  begin
    LabelText.Visible := Value;
   end;
end;

procedure TFederSceneOne.SetLabelTextScale(const Value: single);
var
  t: single;
begin
  t := 0;
  if Value > 0 then
    t := 1.2
  else if Value < 0 then
    t := 0.8;

  if t <> 0 then
  begin
    LabelText.Width := LabelText.Width * t;
    LabelText.Height := LabelText.Height * t;
    LabelText.Depth := LabelText.Depth * t;
  end;
end;

procedure TFederSceneOne.SetParamValue(fp: TFederParam; Value: single);
begin
  case fp of
    fpLabelTextX: LabelText.Position.X := Value;
    fpLabelTextY: LabelText.Position.Y := Value;
    fpLabelTextZ: LabelText.Position.Z := Value;
  end;
end;

function TFederSceneOne.GetParamValue(fp: TFederParam): single;
begin
  case fp of
    fpLabelTextX: result := LabelText.Position.X;
    fpLabelTextY: result := LabelText.Position.Y;
    fpLabelTextZ: result := LabelText.Position.Z;
    else
      result := 0;
  end;
end;

function TFederSceneOne.GetRotationInfo(rp: TPoint3D): TPoint3D;
var
  rm: TMatrix3D;
  ax, ay, az: single;
  ayt: single;
  mt: single;
begin
{
Euler angles from rotation matrix.

  m11, m12, m13
  m21, m22, m23
  m31, m32, m33

psi = ax := arctan2(rm.m32, rm.m33);
the = ay := arctan2(-rm.m31, sqrt(sqr(rm.m32) + sqr(rm.m33)));
phi = az := arctan2(rm.m21, rm.m11);

In special case where angle around y-axis is 90° or -90°
all elements in first column and last row are zero,
except element m31,
which is either 1 or -1.

fix for special case:
rotate around the x-axis 180°
and compute az as atan2(m12, -m22).
}

  rm := FModelGroup.LocalMatrix;

  ay := arctan2(-rm.m31, sqrt(sqr(rm.m32) + sqr(rm.m33)));

  mt := rm.m31;
  { argument for ArcSin must be in -1..1 }
  if mt > 1 then
    mt := 1
  else if rm.m31 < -1 then
    mt := -1;
  ayt := -ArcSin(mt);
  if TUtils.IsEssentiallyZero(ayt) then
  begin
    ax := 0;
    ay := 0;
    az := 0;
    if (rp.X = 0) and  (rp.Y = 0) then
    begin
      az := -rp.Z;
      if az > 180 then
        az := az - 360;
      if az < -180 then
        az := 360 + az;
      az := DegToRad(az);
    end
    else if (rp.X = 0) and (rp.Z = 0) then
    begin
      ax := rp.Y;
      if ax > 180 then
        ax := ax - 360;
      ax := DegToRad(ax);
      ax := -ax;
    end;
  end

  else
  begin
//    ct := cos(ay);
//    ax := arctan2(rm.m32/ct, rm.m33/ct);
//    az := arctan2(rm.m21/ct, rm.m11/ct);

    ax := arctan2(rm.m32, rm.m33);
    az := arctan2(rm.m21, rm.m11);
  end;

  result.X := RadToDeg(ax);
  result.Y := RadToDeg(-ay);
  result.Z := RadToDeg(-az);
end;

procedure TFederSceneOne.ResetFBitmap;
begin
  FBitmap := -1;
end;

function TFederSceneOne.GetModelGroup: TFederDummy;
begin
  result := FModelGroup;
end;

function TFederSceneOne.GetModelGroupPos: TPoint3D;
begin
  result := ModelGroup.Position.Point;
end;

function TFederSceneOne.GetModelGroupRot: TPoint3D;
begin
  result := ModelGroup.RotationAngle.Point;
end;

function TFederSceneOne.GetModelGroupScale: single;
begin
  result := ModelGroup.Scale.X;
end;

procedure TFederSceneOne.SetModelGroupScale(const Value: single);
begin
  ModelGroup.ScaleObject(Value);
end;

procedure TFederSceneOne.SetWantLux1(const Value: Boolean);
begin
  FWantLux1 := Value;
  UpdateLight;
end;

procedure TFederSceneOne.SetWantLux2(const Value: Boolean);
begin
  FWantLux2 := Value;
  UpdateLight;
end;

procedure TFederSceneOne.SetWantLux3(const Value: Boolean);
begin
  FWantLux3 := Value;
  UpdateLight;
end;

procedure TFederSceneOne.SetWantLux4(const Value: Boolean);
begin
  FWantLux4 := Value;
  UpdateLight;
end;

procedure TFederSceneOne.ResetLightPosition;
begin
  ResetLuxAll;
  UpdateLight;
end;

procedure TFederSceneOne.ResetLuxAll;
var
  i: Integer;
begin
  for i := 1 to 4 do
    ResetLux(i);
end;

procedure TFederSceneOne.ResetLux(Value: Integer);
var
  fm: TFederModel;
begin
  fm := Main.FederModel;
  case Value of
    1:
    begin
      { Directional Front Light }
      Assert(Lux1 = FrontLight);

      fm.Lux1X := 0;
      fm.Lux1Y := 0;
      fm.Lux1Z := LightConst.Front;

      Lux1.Position.X := fm.Lux1X;
      Lux1.Position.Y := fm.Lux1Y;
      Lux1.Position.Z := fm.Lux1Z;
    end;
    2:
    begin
      { Back Light }
      Assert(Lux2 = BackLight);

      fm.Lux2X := 0;
      fm.Lux2Y := 0;
      fm.Lux2Z := LightConst.Back;

      Lux2.Position.X := fm.Lux2X;
      Lux2.Position.Y := fm.Lux2Y;
      Lux2.Position.Z := fm.Lux2Z;
    end;
    3:
    begin
      {  West and East Lights. }
      Assert(Lux3 = WestLight);

      fm.Lux3X := LightConst.West;
      fm.Lux3Y := 0;
      fm.Lux3Z := LightConst.WestZ;

      Lux3.Position.X := fm.Lux3X;
      Lux3.Position.Y := fm.Lux3Y;
      Lux3.Position.Z := fm.Lux3Z;

      EastLight.Position.X := -fm.Lux3X;
      EastLight.Position.Y := fm.Lux3Y;
      EastLight.Position.Z := fm.Lux3Z;
    end;
    4:
    begin
      { North and South Lights. }
      Assert(Lux4 = NorthLight);

      fm.Lux4X := 0;
      fm.Lux4Y := LightConst.North;
      fm.Lux4Z := 0;

      Lux4.Position.X := fm.Lux4X;
      Lux4.Position.Y := fm.Lux4Y;
      Lux4.Position.Z := fm.Lux4Z;

      SouthLight.Position.X := fm.Lux4X;
      SouthLight.Position.Y := -fm.Lux4Y;
      SouthLight.Position.Z := fm.Lux4Z;
    end;
  end;
end;

procedure TFederSceneOne.UpdateLight;
var
  fd: TFederModel;
begin
  fd := Main.FederModel;
  if Assigned(Lux1) then
  begin
    { Front Light }

    Lux1.Enabled := WantLux1;

    Lux1.Position.X := fd.Lux1X;
    Lux1.Position.Y := fd.Lux1Y;
    Lux1.Position.Z := fd.Lux1Z;

    Lux1Cone.Position.X := Lux1.Position.X;
    Lux1Cone.Position.Y := Lux1.Position.Y;
    Lux1Cone.Position.Z := Lux1.Position.Z;
  end;

  if Assigned(Lux2) then
  begin
    { Back Light }

    Lux2.Enabled := WantLux2;

    Lux2.Position.X := fd.Lux2X;
    Lux2.Position.Y := fd.Lux2Y;
    Lux2.Position.Z := fd.Lux2Z;

    Lux2Cone.Position.X := Lux2.Position.X;
    Lux2Cone.Position.Y := Lux2.Position.Y;
    Lux2Cone.Position.Z := Lux2.Position.Z;
  end;

  if Assigned(Lux3) then
  begin
    Lux3.Enabled := WantLux3;

    Lux3.Position.X := fd.Lux3X;
    Lux3.Position.Y := fd.Lux3Y;
    Lux3.Position.Z := fd.Lux3Z;

    Lux3Cone.Position.X := fd.Lux3X;
    Lux3Cone.Position.Y := fd.Lux3Y;
    Lux3Cone.Position.Z := fd.Lux3Z;

    EastLight.Enabled := WestLight.Enabled;

    EastLight.Position.X := -fd.Lux3X;
    EastLight.Position.Y := fd.Lux3Y;
    EastLight.Position.Z := fd.Lux3Z;
  end;

  if Assigned(Lux4) then
  begin
    { North and South Lights. }

    Lux4.Enabled := WantLux4;

    Lux4.Position.X := fd.Lux4X;
    Lux4.Position.Y := fd.Lux4Y;
    Lux4.Position.Z := fd.Lux4Z;

    Lux4Cone.Position.X := fd.Lux4X;
    Lux4Cone.Position.Y := fd.Lux4Y;
    Lux4Cone.Position.Z := fd.Lux4Z;

    SouthLight.Enabled := NorthLight.Enabled;

    SouthLight.Position.X := fd.Lux4X;
    SouthLight.Position.Y := -fd.Lux4Y;
    SouthLight.Position.Z := fd.Lux4Z;
  end;
  if Main.FederText <> nil then
    if Main.CurrentReportPage = rpLightInfo then
      Main.TextUpdateNeeded;
end;

function TFederSceneOne.GetMaterialSource: TMaterialSource;
begin
  if WantLux then
    result := MaterialSourceL
  else
    result := MaterialSourceT
end;

procedure TFederSceneOne.Init;
begin
  UpdateMeshStatus;
  InitModel;
  Main.AddMeshesToScene(ModelParent);
end;

procedure TFederSceneOne.InitBitmap;
begin
  if BMP <> nil then
    BMP.Free;
  BMP := Main.FederTexture.GetBitmap(Bitmap);
  AssignBitmap;
end;

procedure TFederSceneOne.UpdateMeshStatus;
begin
  if FLinearMesh then
    cL := 'L'
  else
    cL := 'l';

  if FPolarMesh then
    cP := 'P'
  else
    cP := 'p';

  if FFuzzyMesh then
    cF := 'F'
  else
    cF := 'f';

  if FOpenMesh then
    cO := 'O'
  else
    cO := 'o';

  if FReducedMesh then
    cR := 'R'
  else
    cR := 'r';

  FStatusText := cL + cP + cF + cO + cR;
end;

function TFederSceneOne.GetTextureBitmapText: string;
begin
  result := Main.FederTexture.GetBitmapText;
end;

function TFederSceneOne.GetTextureLock: Boolean;
begin
  result := Main.FederData.TextureLock;
end;

function TFederSceneOne.GetIsOpaque: Boolean;
begin
  result := FOpacity > 0.9;
end;

function TFederSceneOne.GetMeshStatusText: string;
begin
  result := FStatusText;
end;

procedure TFederSceneOne.SetBitmap(const Value: Integer);
begin
  if (FBitmap = 0)
    or Main.UpdatingColorMix
    or Main.BitmapBuilder.UpdatingRings
    or (FBitmap = StripConst.RandomColorIndexW)
    or (FBitmap = StripConst.RandomColorIndexB)
    or (FBitmap <> Value)
    or (BMP = nil)
  then
  begin
    ForceBitmap(Value);
  end;
end;

procedure TFederSceneOne.SetOpacity(const Value: single);
begin
  InitDataOK := False;
  FOpacity := Value;
  UpdateMeshStatus;
  FederMesh.Opacity := Value;
end;

procedure TFederSceneOne.SetOpenMesh(const Value: Boolean);
begin
  InitDataOK := False;
  FederMesh.MeshChanged := True;
  FOpenMesh := Value;
  UpdateMeshStatus;
  Main.InitData(nil);
end;

procedure TFederSceneOne.SetPolarMesh(const Value: Boolean);
begin
  InitDataOK := False;
  FederMesh.MeshChanged := True;
  FPolarMesh := Value;
  UpdateMeshStatus;
  Main.InitData(nil);
end;

procedure TFederSceneOne.SetIsOpaque(const Value: Boolean);
begin
  if Value then
    Opacity := 1.0
  else
    Opacity := 0.5;
end;

procedure TFederSceneOne.SetModulationColor(const Value: TAlphaColor);
begin
  InitDataOK := False;
  FModulationColor := Value;
  ModulateColor;
end;

procedure TFederSceneOne.SetWantLux(const Value: Boolean);
begin
  FWantLux := Value;
  FederMesh.MaterialSource := MaterialSource;
  if Value then
  begin
    EnsureLight;
    FederMesh.Data.CalcFaceNormals;
  end;
  UpdateLight;
end;

procedure TFederSceneOne.SetReducedMesh(const Value: Boolean);
begin
  InitDataOK := False;
  FReducedMesh := Value;
  UpdateMeshStatus;
  if not BlockInitDataOnce then
  begin
    Main.InitData(nil);
  end;
  BlockInitDataOnce := False;
end;

procedure TFederSceneOne.InitGraph(BitmapIndex: Integer);
begin
  InitDataOK := False;
  FNewBitmap := BitmapIndex;
  EnsureBitmap;

  ModelGroup.Scale.X := 0.36;
  ModelGroup.Scale.Y := 0.36;
  ModelGroup.Scale.Z := 0.36;

  ModelGroup.RotationAngle.X := 0.0;
  ModelGroup.RotationAngle.Y := 0.0;
  ModelGroup.RotationAngle.Z := 0.0;

  ModelGroup.Position.X := 0.0;
  ModelGroup.Position.Y := 0.0;
  ModelGroup.Position.Z := 0.0;

  ModelGroup.Width := 1.0;
  ModelGroup.Height := 1.0;
  ModelGroup.Depth := 1.0;

  ModelGroup.TwoSide := True;
  ModelGroup.Opacity := 1.0;
end;

procedure TFederSceneOne.ResetDataRandom(ID: Integer);
begin
  if Assigned(Main.FederModel.EQ) then
  begin
    Main.FederModel.EQ.InitRandom(ID);
    InitDataOK := False;
    FT1 := FT1 - 5 + Random(10);
    FT2 := FT2 - 5 + Random(10);
    Main.InitData(nil);
  end;
end;

procedure TFederSceneOne.SetTextureLock(const Value: Boolean);
begin
  Main.FederData.TextureLock := Value;
end;

procedure TFederSceneOne.LoadBitmap(Image: TBitmap);
begin
  if Assigned(BMP) then
    BMP.Free;
  BMP := Image;
end;

procedure TFederSceneOne.AssignBitmap;
begin
  MaterialSourceT.Texture := BMP;
  MaterialSourceL.Texture := BMP;
end;

procedure TFederSceneOne.ForceBitmap(const Value: Integer);
begin
  FBitmap := Value;
  if not TextureLock then
    InitBitmap;
end;

procedure TFederSceneOne.SaveToFederData(fd: TFederData);
begin
  { Control C }
  fd.Bitmap := FBitmap;
  fd.OpenMesh := FOpenMesh;
  fd.PolarMesh := FPolarMesh;
  fd.LinearMesh := FLinearMesh;
  fd.FuzzyMesh := FFuzzyMesh;

  fd.Lux := WantLux;
  fd.Lux1 := WantLux1;
  fd.Lux2 := WantLux2;
  fd.Lux3 := WantLux3;
  fd.Lux4 := WantLux4;
end;

procedure TFederSceneOne.LoadFromFederData(fd: TFederData);
begin
  FNewBitmap := fd.Bitmap;

  FOpenMesh := fd.OpenMesh;
  FPolarMesh := fd.PolarMesh;
  FLinearMesh := fd.LinearMesh;
  FFuzzyMesh := fd.FuzzyMesh;
  FReducedMesh := fd.ReducedMesh;

  if not fd.LuxLock then
  begin
    WantLux := fd.Lux;
    WantLux1 := fd.Lux1;
    WantLux2 := fd.Lux2;
    WantLux3 := fd.Lux3;
    WantLux4 := fd.Lux4;
    UpdateLight;
  end;
end;

procedure TFederSceneOne.EnsureBitmap;
var
  M: TMain;
begin
  M := Main;
  if (FNewBitmap <> FBitmap)
  or (M.FederModel.FT3 <> M.FederTexture.UsedT3)
  or (M.FederModel.FT4 <> M.FederTexture.UsedT4)
  then
  begin
    ForceBitmap(FNewBitmap);
  end;
  FNewBitmap := -1;
end;

procedure TFederSceneOne.EnsureBitmapStrip(cs: TColorStrip);
begin
  if cs.HasColor then
  begin
    FNewBitmap := 25;
    Main.BitmapBuilder.ReadColorStrip(cs);
    ForceBitmap(FNewBitmap);
    FNewBitmap := -1;
  end
  else
  begin
    EnsureBitmap;
  end;
end;

procedure TFederSceneOne.MoveColor(NewColor: TAlphaColor);
begin
  case Main.CurrentLight of
    1: Lux1.Color := NewColor;
    2: Lux2.Color := NewColor;
    3: Lux3.Color := NewColor;
    4: Lux4.Color := NewColor;
  end;
end;

function TFederSceneOne.GetLuxColor(Value: Integer): TAlphaColor;
begin
  case Main.CurrentLight of
    1: result := Lux1.Color;
    2: result := Lux2.Color;
    3: result := Lux3.Color;
    4: result := Lux4.Color;
    else
      result := claWhite;
  end;
end;

function TFederSceneOne.CurrentLightMarker(Value: Integer): Char;
begin
  if Main.CurrentLight = Value then
    result := '*'
  else
    result := '-';
end;

procedure TFederSceneOne.GetMatrixInfo(SL: TStrings);
var
  fs: string;
  m: TMatrix3D;
  f: single;
begin
  f := 100;

  m := Main.Frame3D.CameraDummy.LocalMatrix;

  fs := '%7.2f %7.2f %7.2f %7.2f';
  with m do
  begin
    SL.Add(Format(fs, [m11*f, m12*f, m13*f, m14]));
    SL.Add(Format(fs, [m21*f, m22*f, m23*f, m24]));
    SL.Add(Format(fs, [m31*f, m32*f, m33*f, m34]));
    SL.Add(Format(fs, [m41, m42, m43, m44]));
  end;
end;

procedure TFederSceneOne.GetLightInfo(SL: TStrings);
var
  ft: string;
  fs: string;
begin
  ft := '%7.2f %7.2f %7.2f %d %s';

  fs := Format('F1: %s', [ft]);
  SL.Add(Format(fs, [
    Lux1.Position.X,
    Lux1.Position.Y,
    Lux1.Position.Z,
    BoolInt[Lux1.Enabled],
    CurrentLightMarker(1)
    ]));

  fs := Format('B2: %s', [ft]);
  SL.Add(Format(fs, [
    Lux2.Position.X,
    Lux2.Position.Y,
    Lux2.Position.Z,
    BoolInt[Lux2.Enabled],
    CurrentLightMarker(2)
    ]));

  fs := Format('W3: %s', [ft]);
  SL.Add(Format(fs, [
    Lux3.Position.X,
    Lux3.Position.Y,
    Lux3.Position.Z,
    BoolInt[Lux3.Enabled],
    CurrentLightMarker(3)
    ]));

  fs := Format('E3: %s', [ft]);
  SL.Add(Format(fs, [
    EastLight.Position.X,
    EastLight.Position.Y,
    EastLight.Position.Z,
    BoolInt[Lux3.Enabled],
    CurrentLightMarker(3)
    ]));

  fs := Format('N4: %s', [ft]);
  SL.Add(Format(fs, [
    Lux4.Position.X,
    Lux4.Position.Y,
    Lux4.Position.Z,
    BoolInt[Lux4.Enabled],
    CurrentLightMarker(4)
    ]));

  fs := Format('S4: %s', [ft]);
  SL.Add(Format(fs, [
    SouthLight.Position.X,
    SouthLight.Position.Y,
    SouthLight.Position.Z,
    BoolInt[Lux4.Enabled],
    CurrentLightMarker(4)
    ]));
end;

function TFederSceneOne.GetInitDataOK: Boolean;
begin
  result := Main.InitDataOK;
end;

procedure TFederSceneOne.SetInitDataOK(const Value: Boolean);
begin
  Main.InitDataOK := Value;
end;

procedure TFederSceneOne.ModulateColor;
var
  b: TBitmap;
  x, y: Integer;
  Texture: TBitmap;
  bd: TBitmapData;
  M: TMain;
begin
  M := Main;
  b := M.FederScene.BMP;
  if not Assigned(b) then
    Exit;

  if MaterialSource = MaterialSourceT then
    Texture := MaterialSourceT.Texture
  else if MaterialSource = MaterialSourceL then
    Texture := MaterialSourceL.Texture
  else
    Exit;

  if Texture.Width <> b.Width then
    Exit;
  if Texture.Height <> b.Height then
    Exit;

  if b.Map(TMapAccess.Write, bd) then
  begin
    for x := 0 to b.Width-1 do
    begin
      for y := 0 to b.Height-1 do
      begin
        bd.SetPixel(x, y, bd.GetPixel(x, y) and ModulationColor);
      end;
    end;
    b.Unmap(bd);
    if MaterialSource is TTextureMaterialSource then
      MaterialSourceT.Texture := b
    else
      MaterialSourceL.Texture := b;
  end;
end;

function TFederSceneOne.GetLuxParamValue(fp: TFederParam): single;
begin
  case fp of
    fpl1x: result := Lux1.Position.X;
    fpl1y: result := Lux1.Position.Y;
    fpl1z: result := Lux1.Position.Z;

    fpl2x: result := Lux2.Position.X;
    fpl2y: result := Lux2.Position.Y;
    fpl2z: result := Lux2.Position.Z;

    fpl3x: result := Lux3.Position.X;
    fpl3y: result := Lux3.Position.Y;
    fpl3z: result := Lux3.Position.Z;

    fpl4x: result := Lux4.Position.X;
    fpl4y: result := Lux4.Position.Y;
    fpl4z: result := Lux4.Position.Z;
    else
      result := 0;
  end;
end;

end.
