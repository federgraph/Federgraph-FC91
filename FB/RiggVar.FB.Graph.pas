unit RiggVar.FB.Graph;

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
  System.Classes,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Math,
  System.Math.Vectors,
  FMX.Graphics,
  FMX.Types,
  FMX.Materials,
  FMX.MaterialSources,
  FMX.Objects3D,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.FB.Bitmap;

type
  TFederDummy = class(TDummy)
  public
    procedure RotateObject(dx, dy, dz: single);
    procedure ScaleObject(ds: single);
    procedure UpdateQuaternion;
  end;

  TFederSceneBase = class
  protected
    FLabelTextScale: single;
    FOpacity: single;
    FModulationColor: TAlphaColor;
    FPlot: Integer;
    FScene: Integer;
    FBitmap: Integer;

    FGridFrequency: Integer;

    FWantLux: Boolean;
    FWantLux1: Boolean;
    FWantLux2: Boolean;
    FWantLux3: Boolean;
    FWantLux4: Boolean;

    FShowLabel: Boolean;
    FShowDiameter: Boolean;
    FShowDiameter3: Boolean;
    FShowGrid: Boolean;
    FShowCylinder: Boolean;
    FShowCorner: Boolean;
    FShowCube: Boolean;
    FShowLimitPlane: Boolean;
    FShowKugel: Boolean;
    FShowLuxMarker: Boolean;

    FEvenMesh: Boolean;
    FPolarMesh: Boolean;
    FOpenMesh: Boolean;
    FReducedMesh: Boolean;
    FFilterMesh: Boolean;
    FLinearMesh: Boolean;
    FFuzzyMesh: Boolean;
    FQuickMesh: Boolean;
    FHullMesh: Boolean;
    FInvertedMesh: Boolean;
    FUprightMesh: Boolean;
    FFlippedTexture: Boolean;

    FReduceMode: Integer;

    procedure SetPlot(const Value: Integer); virtual;
    procedure SetScene(const Value: Integer); virtual;
    procedure SetBitmap(const Value: Integer); virtual;

    procedure SetGridFrequency(const Value: Integer); virtual;

    procedure SetOpacity(const Value: single); virtual;
    procedure SetShowCube(const Value: Boolean); virtual;
    procedure SetShowCorner(const Value: Boolean); virtual;
    procedure SetShowLimitPlane(const Value: Boolean); virtual;
    procedure SetShowCylinder(const Value: Boolean); virtual;
    procedure SetShowDiameter(const Value: Boolean); virtual;
    procedure SetShowDiameter3(const Value: Boolean); virtual;
    procedure SetShowGrid(const Value: Boolean); virtual;
    procedure SetShowKugel(const Value: Boolean); virtual;
    procedure SetShowLabel(const Value: Boolean); virtual;
    procedure SetShowLuxMarker(const Value: Boolean); virtual;

    procedure SetWantLux(const Value: Boolean); virtual;
    procedure SetWantLux1(const Value: Boolean); virtual;
    procedure SetWantLux2(const Value: Boolean); virtual;
    procedure SetWantLux3(const Value: Boolean); virtual;
    procedure SetWantLux4(const Value: Boolean); virtual;

    procedure SetEvenMesh(const Value: Boolean); virtual;
    procedure SetFilterMesh(const Value: Boolean); virtual;
    procedure SetFuzzyMesh(const Value: Boolean); virtual;
    procedure SetLinearMesh(const Value: Boolean); virtual;
    procedure SetOpenMesh(const Value: Boolean); virtual;
    procedure SetPolarMesh(const Value: Boolean); virtual;
    procedure SetReducedMesh(const Value: Boolean); virtual;
    procedure SetHullMesh(const Value: Boolean); virtual;
    procedure SetInvertedMesh(const Value: Boolean); virtual;
    procedure SetUprightMesh(const Value: Boolean); virtual;
    procedure SetFlippedTexture(const Value: Boolean); virtual;
    procedure SetQuickMesh(const Value: Boolean); virtual;

    procedure SetIsOpaque(const Value: Boolean); virtual;
    function GetIsOpaque: Boolean; virtual;

    function GetTextureLock: Boolean; virtual;
    procedure SetReduceMode(const Value: Integer); virtual;
    procedure SetTextureLock(const Value: Boolean); virtual;
    procedure SetModulationColor(const Value: TAlphaColor); virtual;

    function GetModelGroupPos: TPoint3D; virtual;
    function GetModelGroupRot: TPoint3D; virtual;

    function GetTextureBitmapText: string; virtual;
    function GetMeshStatusText: string; virtual;

    procedure SetLabelTextScale(const Value: single); virtual;
    function GetModelGroupScale: single; virtual;
    procedure SetModelGroupScale(const Value: single);  virtual;

    function GetMaterialSource: TMaterialSource; virtual;
  public
    BMP: TBitmap;

    BlockInitDataOnce: Boolean;

    procedure MarkDirty;
    procedure Init; virtual;
    procedure InitGraph(BitmapIndex: Integer); virtual;
    procedure InitBitmap; virtual;

    procedure SaveToFederData(fd: TFederData); virtual;
    procedure LoadFromFederData(fd: TFederData); virtual;

    procedure ModulateColor; virtual;
    procedure MoveLight(X, Y: single); virtual;
    procedure MoveLightZ(Shift: Boolean; Delta: single); virtual;
    procedure MoveColor(NewColor: TAlphaColor); virtual;

    procedure UpdateKegel; virtual;
    procedure UpdateProbe; virtual;
    procedure UpdateLight; virtual;
    procedure UpdateLimitPlane; virtual;

    procedure ResetLightPosition; virtual;
    procedure ResetLightParams; virtual;

    procedure ForceBitmap(const Value: Integer); virtual;
    procedure EnsureBitmap; virtual;
    procedure EnsureBitmapStrip(cs: TColorStrip); virtual;

    procedure OpenTexture(fn: string); virtual;
    procedure CloseTexture; virtual;

    function GetLuxParamValue(fp: TFederParam): single; virtual;
    function GetParamValue(fp: TFederParam): single; virtual;
    procedure SetParamValue(fp: TFederParam; Value: single); virtual;

    procedure GetMatrixInfo(SL: TStrings); virtual;
    procedure GetLightInfo(SL: TStrings); virtual;
    function GetLuxColor(Value: Integer): TAlphaColor; virtual;
    procedure ResetDataRandom(ID: Integer); virtual;

    procedure ToggleCube;
    procedure ToggleCorner;
    procedure ToggleLimitPlane;
    procedure ToggleProbe;
    procedure ToggleCylinder;
    procedure ToggleDiameter;
    procedure ToggleGrid;
    procedure ToggleGridFrequency;
    procedure ToggleLabel;
    procedure ToggleMarker;

    procedure ToggleLux(Value: Integer);
    procedure ToggleLux1(Value: Integer);
    procedure ToggleLux2(Value: Integer);
    procedure ToggleLux3(Value: Integer);
    procedure ToggleLuxN(N, Value: Integer);

    procedure LoadBitmap(Image: TBitmap); virtual;

    property Scene: Integer read FScene write SetScene;
    property Plot: Integer read FPlot write SetPlot;
    property Bitmap: Integer read FBitmap write SetBitmap;
    property Opacity: single read FOpacity write SetOpacity;

    property GridFrequency: Integer read FGridFrequency write SetGridFrequency;

    property FlippedTexture: Boolean read FFlippedTexture write SetFlippedTexture;
    property UprightMesh: Boolean read FUprightMesh write SetUprightMesh;
    property InvertedMesh: Boolean read FInvertedMesh write SetInvertedMesh;
    property HullMesh: Boolean read FHullMesh write SetHullMesh;
    property ReducedMesh: Boolean read FReducedMesh write SetReducedMesh;
    property PolarMesh: Boolean read FPolarMesh write SetPolarMesh;
    property FilterMesh: Boolean read FFilterMesh write SetFilterMesh;
    property FuzzyMesh: Boolean read FFuzzyMesh write SetFuzzyMesh;
    property LinearMesh: Boolean read FLinearMesh write SetLinearMesh;
    property OpenMesh: Boolean read FOpenMesh write SetOpenMesh;
    property QuickMesh: Boolean read FQuickMesh write SetQuickMesh;
    property EvenMesh: Boolean read FEvenMesh write SetEvenMesh;
    property IsOpaque: Boolean read GetIsOpaque write SetIsOpaque;

    property ShowCube: Boolean read FShowCube write SetShowCube;
    property ShowCorner: Boolean read FShowCorner write SetShowCorner;
    property ShowLimitPlane: Boolean read FShowLimitPlane write SetShowLimitPlane;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid;
    property ShowKugel: Boolean read FShowKugel write SetShowKugel;
    property ShowCylinder: Boolean read FShowCylinder write SetShowCylinder;
    property ShowDiameter: Boolean read FShowDiameter write SetShowDiameter;
    property ShowDiameter3: Boolean read FShowDiameter3 write SetShowDiameter3;
    property ShowLabel: Boolean read FShowLabel write SetShowLabel;
    property ShowLuxMarker: Boolean read FShowLuxMarker write SetShowLuxMarker;

    property WantLux: Boolean read FWantLux write SetWantLux;
    property WantLux1: Boolean read FWantLux1 write SetWantLux1;
    property WantLux2: Boolean read FWantLux2 write SetWantLux2;
    property WantLux3: Boolean read FWantLux3 write SetWantLux3;
    property WantLux4: Boolean read FWantLux4 write SetWantLux4;

    property TextureLock: Boolean read GetTextureLock write SetTextureLock;
    property ReduceMode: Integer read FReduceMode write SetReduceMode;
    property ModulationColor: TAlphaColor read FModulationColor write SetModulationColor;

    property ModelGroupRot: TPoint3D read GetModelGroupRot;
    property ModelGroupPos: TPoint3D read GetModelGroupPos;

    property TextureBitmapText: string read GetTextureBitmapText;
    property MeshStatusText: string read GetMeshStatusText;
    property ModelGroupScale: single read GetModelGroupScale write SetModelGroupScale;
    property LabelTextScale: single read FLabelTextScale write SetLabelTextScale;

    property MaterialSource: TMaterialSource read GetMaterialSource;
  end;

implementation

{ TFederDummy }

procedure TFederDummy.RotateObject(dx, dy, dz: single);
var
  mx, my, mz: TMatrix3D;
  m: TMatrix3D;
begin
  mx := TMatrix3D.CreateRotationX(DegToRad(dy));
  my := TMatrix3D.CreateRotationY(DegToRad(dx));
  mz := TMatrix3D.CreateRotationZ(DegToRad(dz));

  m := mx * my * mz;

  FLocalMatrix := FLocalMatrix * m;
  RecalcAbsolute;
  Repaint;
end;

procedure TFederDummy.ScaleObject(ds: single);
var
  p: TPoint3D;
  m: TMatrix3D;
begin
  p := TPoint3D.Create(ds, ds, ds);
  m := TMatrix3D.CreateScaling(p);
  FLocalMatrix := FLocalMatrix * m;
  RecalcAbsolute;
  Repaint;
end;

procedure TFederDummy.UpdateQuaternion;
var
  a: Single;
  NeedChange: Boolean;
  NewValue: TPoint3D;
begin
  { see procedure TControl3D.RotationChanged }

  NeedChange := False;
  NewValue := RotationAngle.Point;
  a := DegNormalize(RotationAngle.X - FSavedRotationAngle.X);
  if a <> 0 then
  begin
    FQuaternion := FQuaternion * TQuaternion3D.Create(Point3D(1, 0, 0), DegToRad(a));
    NeedChange := True;
    NewValue.X := DegNormalize(RotationAngle.X);
  end;
  a := DegNormalize(RotationAngle.Y - FSavedRotationAngle.Y);
  if a <> 0 then
  begin
    FQuaternion := FQuaternion * TQuaternion3D.Create(Point3D(0, 1, 0), DegToRad(a));
    NeedChange := True;
    NewValue.Y := DegNormalize(RotationAngle.Y);
  end;
  a := DegNormalize(RotationAngle.Z - FSavedRotationAngle.Z);
  if a <> 0 then
  begin
    FQuaternion := FQuaternion * TQuaternion3D.Create(Point3D(0, 0, 1), DegToRad(a));
    NeedChange := True;
    NewValue.Z := DegNormalize(RotationAngle.Z);
  end;
  if NeedChange then
  begin
    FSavedRotationAngle := RotationAngle.Point;
    RotationAngle.SetPoint3DNoChange(NewValue);
    //MatrixChanged(Sender); //do not do that ! only update FQuaternion.
  end;
end;

{ TFederSceneBase }

procedure TFederSceneBase.CloseTexture;
begin

end;

procedure TFederSceneBase.EnsureBitmap;
begin

end;

procedure TFederSceneBase.EnsureBitmapStrip(cs: TColorStrip);
begin

end;

procedure TFederSceneBase.ForceBitmap(const Value: Integer);
begin

end;

function TFederSceneBase.GetIsOpaque: Boolean;
begin
  result := True;
end;

procedure TFederSceneBase.GetLightInfo(SL: TStrings);
begin

end;

function TFederSceneBase.GetLuxColor(Value: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TFederSceneBase.GetLuxParamValue(fp: TFederParam): single;
begin
  result := 0;
end;

function TFederSceneBase.GetMaterialSource: TMaterialSource;
begin
  result := nil;
end;

procedure TFederSceneBase.GetMatrixInfo(SL: TStrings);
begin

end;

function TFederSceneBase.GetMeshStatusText: string;
begin
  result := '';
end;

function TFederSceneBase.GetModelGroupPos: TPoint3D;
begin
  result := TPoint3D.Create(0, 0, 0);
end;

function TFederSceneBase.GetModelGroupRot: TPoint3D;
begin
  result := TPoint3D.Create(0, 0, 0);
end;

function TFederSceneBase.GetModelGroupScale: single;
begin
  result := 1.0;
end;

function TFederSceneBase.GetParamValue(fp: TFederParam): single;
begin
  result := 0;
end;

function TFederSceneBase.GetTextureBitmapText: string;
begin
  result := '';
end;

function TFederSceneBase.GetTextureLock: Boolean;
begin
  result := False;
end;

procedure TFederSceneBase.Init;
begin
end;

procedure TFederSceneBase.InitBitmap;
begin

end;

procedure TFederSceneBase.InitGraph(BitmapIndex: Integer);
begin

end;

procedure TFederSceneBase.LoadBitmap(Image: TBitmap);
begin

end;

procedure TFederSceneBase.MarkDirty;
begin
  FBitmap := -2;
end;

procedure TFederSceneBase.ModulateColor;
begin

end;

procedure TFederSceneBase.MoveColor(NewColor: TAlphaColor);
begin

end;

procedure TFederSceneBase.MoveLight(X, Y: single);
begin

end;

procedure TFederSceneBase.MoveLightZ(Shift: Boolean; Delta: single);
begin

end;

procedure TFederSceneBase.OpenTexture(fn: string);
begin

end;

procedure TFederSceneBase.ResetDataRandom(ID: Integer);
begin

end;

procedure TFederSceneBase.LoadFromFederData(fd: TFederData);
begin

end;

procedure TFederSceneBase.SaveToFederData(fd: TFederData);
begin

end;

procedure TFederSceneBase.SetBitmap(const Value: Integer);
begin
  FBitmap := Value;
end;

procedure TFederSceneBase.SetFilterMesh(const Value: Boolean);
begin
  FFilterMesh := Value;
end;

procedure TFederSceneBase.SetFuzzyMesh(const Value: Boolean);
begin
  FFuzzyMesh := Value;
end;

procedure TFederSceneBase.SetGridFrequency(const Value: Integer);
begin
  FGridFrequency := Value;
end;

procedure TFederSceneBase.SetIsOpaque(const Value: Boolean);
begin
end;

procedure TFederSceneBase.SetLabelTextScale(const Value: single);
begin
  FLabelTextScale := Value;
end;

procedure TFederSceneBase.SetLinearMesh(const Value: Boolean);
begin
  FLinearMesh := Value;
end;

procedure TFederSceneBase.SetModelGroupScale(const Value: single);
begin

end;

procedure TFederSceneBase.SetModulationColor(const Value: TAlphaColor);
begin
  FModulationColor := Value;
end;

procedure TFederSceneBase.SetOpacity(const Value: single);
begin
  FOpacity := Value;
end;

procedure TFederSceneBase.SetOpenMesh(const Value: Boolean);
begin
  FOpenMesh := Value;
end;

procedure TFederSceneBase.SetParamValue(fp: TFederParam; Value: single);
begin

end;

procedure TFederSceneBase.SetPlot(const Value: Integer);
begin
  FPlot := Value;
end;

procedure TFederSceneBase.SetEvenMesh(const Value: Boolean);
begin
  FEvenMesh := Value;
end;

procedure TFederSceneBase.SetPolarMesh(const Value: Boolean);
begin
  FPolarMesh := Value;
end;

procedure TFederSceneBase.SetQuickMesh(const Value: Boolean);
begin
  FQuickMesh := Value;
end;

procedure TFederSceneBase.SetUprightMesh(const Value: Boolean);
begin
  FUprightMesh := Value;
end;

procedure TFederSceneBase.SetFlippedTexture(const Value: Boolean);
begin
  FUprightMesh := Value;
end;

procedure TFederSceneBase.SetInvertedMesh(const Value: Boolean);
begin
  FInvertedMesh := Value;
end;

procedure TFederSceneBase.SetHullMesh(const Value: Boolean);
begin
  FHullMesh := Value;
end;

procedure TFederSceneBase.SetReducedMesh(const Value: Boolean);
begin
  FReducedMesh := Value;
end;

procedure TFederSceneBase.SetReduceMode(const Value: Integer);
begin
  FReduceMode := Value;
end;

procedure TFederSceneBase.SetShowCube(const Value: Boolean);
begin
  FShowCube := Value;
end;

procedure TFederSceneBase.SetShowCorner(const Value: Boolean);
begin
  FShowCorner := Value;
end;

procedure TFederSceneBase.SetShowLimitPlane(const Value: Boolean);
begin
  FShowLimitPlane := Value;
end;

procedure TFederSceneBase.SetScene(const Value: Integer);
begin
  FScene := Value;
end;

procedure TFederSceneBase.SetShowCylinder(const Value: Boolean);
begin
  FShowCylinder := Value;
end;

procedure TFederSceneBase.SetShowDiameter(const Value: Boolean);
begin
  FShowDiameter := Value;
end;

procedure TFederSceneBase.SetShowDiameter3(const Value: Boolean);
begin
  FShowDiameter3 := Value;
end;

procedure TFederSceneBase.SetShowGrid(const Value: Boolean);
begin
  FShowGrid := Value;
end;

procedure TFederSceneBase.SetShowKugel(const Value: Boolean);
begin
  FShowKugel := Value;
end;

procedure TFederSceneBase.SetShowLabel(const Value: Boolean);
begin
  FShowLabel := Value;
end;

procedure TFederSceneBase.SetShowLuxMarker(const Value: Boolean);
begin
  FShowLuxMarker := Value;
end;

procedure TFederSceneBase.SetTextureLock(const Value: Boolean);
begin

end;

procedure TFederSceneBase.SetWantLux(const Value: Boolean);
begin
  FWantLux := Value;
end;

procedure TFederSceneBase.SetWantLux1(const Value: Boolean);
begin
  FWantLux1 := Value;
end;

procedure TFederSceneBase.SetWantLux2(const Value: Boolean);
begin
  FWantLux2 := Value;
end;

procedure TFederSceneBase.SetWantLux3(const Value: Boolean);
begin
  FWantLux3 := Value;
end;

procedure TFederSceneBase.SetWantLux4(const Value: Boolean);
begin
  FWantLux4 := Value;
end;

procedure TFederSceneBase.UpdateKegel;
begin

end;

procedure TFederSceneBase.UpdateLight;
begin

end;

procedure TFederSceneBase.UpdateProbe;
begin

end;

procedure TFederSceneBase.UpdateLimitPlane;
begin

end;

procedure TFederSceneBase.ToggleCube;
begin
  ShowCube := not ShowCube ;
end;

procedure TFederSceneBase.ToggleCorner;
begin
  ShowCorner := not ShowCorner;
end;

procedure TFederSceneBase.ToggleLimitPlane;
begin
  ShowLimitPlane := not ShowLimitPlane;
end;

procedure TFederSceneBase.ToggleProbe;
begin
  { toggle Cylinder and keep Diameter in sync }
  ShowCylinder := not ShowCylinder;
  ShowDiameter := ShowCylinder;
end;

procedure TFederSceneBase.ToggleCylinder;
begin
  ShowCylinder := not ShowCylinder;
end;

procedure TFederSceneBase.ToggleDiameter;
begin
  ShowDiameter := not ShowDiameter;
end;

procedure TFederSceneBase.ToggleLabel;
begin
  ShowLabel := not ShowLabel;
end;

procedure TFederSceneBase.ToggleGrid;
begin
  ShowGrid := not ShowGrid;
end;

procedure TFederSceneBase.ToggleGridFrequency;
begin
  if GridFrequency = 20 then
    GridFrequency := 10
  else
    GridFrequency := 20;
end;

procedure TFederSceneBase.ToggleMarker;
begin
  ShowKugel := not ShowKugel;
end;

procedure TFederSceneBase.ResetLightPosition;
begin
  { virtual }
end;

procedure TFederSceneBase.ResetLightParams;
begin
  { virtual }
end;

procedure TFederSceneBase.ToggleLux(Value: Integer);
begin
  //Main.FederData.LuxLock := false;
  case Value of
    0: WantLux := False;
    1: WantLux := True;
    else
      WantLux := not WantLux;
  end;
end;

procedure TFederSceneBase.ToggleLux1(Value: Integer);
begin
  case Value of
    0: WantLux1 := false;
    1: WantLux1 := True;
    else
      WantLux1 := not WantLux1;
  end;
end;

procedure TFederSceneBase.ToggleLux2(Value: Integer);
begin
  case Value of
    0: WantLux2 := false;
    1: WantLux2 := True;
    else
      WantLux2 := not WantLux2;
  end;
end;

procedure TFederSceneBase.ToggleLux3(Value: Integer);
begin
  case Value of
    0: WantLux3 := false;
    1: WantLux3 := True;
    else
      WantLux3 := not WantLux3;
  end;
end;

procedure TFederSceneBase.ToggleLuxN(N: Integer; Value: Integer);
begin
  case N of
    1:
    begin
      case Value of
        0: WantLux1 := false;
        1: WantLux1 := True;
        else
          WantLux1 := not WantLux1;
      end;
    end;

    2:
    begin
      case Value of
        0: WantLux2 := false;
        1: WantLux2 := True;
        else
          WantLux2 := not WantLux2;
      end;
    end;

    3:
    begin
      case Value of
        0: WantLux3 := false;
        1: WantLux3 := True;
        else
          WantLux3 := not WantLux3;
      end;
    end;

    4:
    begin
      case Value of
        0: WantLux4 := false;
        1: WantLux4 := True;
        else
          WantLux4 := not WantLux4;
      end;
    end;

    else
    begin
      case Value of
        0: ShowLuxMarker := false;
        1: ShowLuxMarker := True;
        else
          ShowLuxMarker := not ShowLuxMarker;
      end;
    end;
  end;
end;

end.