unit RiggVar.FederModel.Color;

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

{$define WantSpecialImage}

uses
  System.UIConsts,
  System.UITypes,
  System.SysUtils,
  FMX.Types,
  FMX.Controls3D,
  FMX.Viewport3D,
  FMX.Layers3D,
  FMX.Types3D,
  FMX.Objects3D,
  FMX.Ani;

type
  TFederColor = class
  private
    ColorAnimation: TColorAnimation;
    FScale: Integer;
    FPositionX: Integer;
    FPositionY: Integer;

    FPositionBaseX: single;
    FPositionBaseY: single;

    procedure ColorAnimationProcess(Sender: TObject);
{$ifdef WantSpecialImage}
    function InitDir: string;
    function GetFileName: string;
{$endif}
    procedure SetScale(const Value: Integer);
    procedure SetPositionX(const Value: Integer);
    procedure SetPositionY(const Value: Integer);
  public
    ColorIndex: Integer;
    Image: TImage3D;
    Light: TLight;

    procedure Init(vp: TViewport3D);
    procedure InitImage;

    procedure GoRed;
    procedure GoBlue;
    procedure GoColor;
    procedure Start(StopColor: TAlphaColor);
    procedure Stop;

    property PositionX: Integer read FPositionX write SetPositionX;
    property PositionY: Integer read FPositionY write SetPositionY;
    property Scale: Integer read FScale write SetScale;
  end;

implementation

uses
{$ifdef WantSpecialImage}
  RiggVar.Util.AppUtils,
{$endif}
  RiggVar.App.Main;

procedure TFederColor.GoRed;
begin
  ColorAnimation.Stop;
  Image.ModulationColor := claRed;
end;

procedure TFederColor.GoBlue;
begin
  ColorAnimation.Stop;
  Image.ModulationColor := claBlue;
end;

procedure TFederColor.GoColor;
var
  cla: TAlphaColor;
begin
  ColorAnimation.Stop;
  Inc(ColorIndex);
  if ColorIndex > 6 then
    ColorIndex := 0;

  case ColorIndex of
    1: cla := claRed;
    2: cla := claGreen;
    3: cla := claBlue;
    4: cla := claCyan;
    5: cla := claMagenta;
    6: cla := claYellow;
    else
      cla := claWhite;
  end;

  Image.ModulationColor := cla;
end;

procedure TFederColor.InitImage;
{$ifdef WantSpecialImage}
var
  fn: string;
{$endif}
begin
{$ifdef WantSpecialImage}
  fn := GetFileName;
  if FileExists(fn) then
    Image.Bitmap.LoadFromFile(GetFileName);
{$endif}
end;

{$ifdef WantSpecialImage}
function TFederColor.GetFileName: string;
begin
  result := IncludeTrailingPathDelimiter(InitDir) + 'Images\Image01.png';
end;

function TFederColor.InitDir: string;
begin
  result := TAppUtils.GetProjectDir;
end;
{$endif}

procedure TFederColor.ColorAnimationProcess(Sender: TObject);
begin
  Image.ModulationColor := Light.Color;
end;

procedure TFederColor.Init(vp: TViewport3D);
begin
  Image := TImage3D.Create(vp);
  Image.HitTest := False;
  Light := TLight.Create(vp);
  ColorAnimation := TColorAnimation.Create(vp);

  ColorAnimation.Parent := Light;
  ColorAnimation.PropertyName := 'Diffuse';

  ColorAnimation.OnProcess := ColorAnimationProcess;
  ColorAnimation.StartFromCurrent := True;
  ColorAnimation.StartValue := claWhite;
  ColorAnimation.StopValue := claBlue;
  ColorAnimation.Duration := 2.0;
  ColorAnimation.StartFromCurrent := True;
  ColorAnimation.Loop := False;
  ColorAnimation.AutoReverse := False;
  ColorAnimation.AnimationType := TAnimationType.InOut;
  ColorAnimation.Interpolation := TInterpolationType.Linear;

  Image.Projection := TProjection.Screen;
  Image.Parent := vp;
  Image.Width := vp.Width;
  Image.Height := vp.Height;
  Image.Depth := 1;
  Image.Position.X := vp.Width/2;
  Image.Position.Y := vp.Height/2;
  Image.Position.Z := 0;
  Image.RotationAngle.Empty;
  Image.Scale.X := 1.0;
  Image.Scale.Y := Image.Scale.Y;

  FPositionBaseX := Image.Position.X;
  FPositionBaseY := Image.Position.Y;

  Light.LightType := TLightType.Directional;
  Light.Position.Z := -10;
  Light.Parent := vp;

  Light.Color := claWhite;
end;

procedure TFederColor.SetPositionX(const Value: Integer);
begin
  FPositionX := Value;
  if Assigned(Image) then
  begin
    Image.Position.X := FPositionBaseX + Value;
  end;
end;

procedure TFederColor.SetPositionY(const Value: Integer);
begin
  FPositionY := Value;
  if Assigned(Image) then
  begin
    Image.Position.Y := FPositionBaseY + Value;
  end;
end;

procedure TFederColor.SetScale(const Value: Integer);
begin
  FScale := Value;
  if Assigned(Image) then
  begin
    Image.Scale.X := FScale / 100;
    Image.Scale.Y := Image.Scale.X;
  end;
end;

procedure TFederColor.Start(StopColor: TAlphaColor);
begin
  ColorAnimation.StopValue := StopColor;
  ColorAnimation.Start;
end;

procedure TFederColor.Stop;
begin
  ColorAnimation.Stop;
  Image.ModulationColor := claWhite;
  Light.Color := claWhite;
end;

end.
