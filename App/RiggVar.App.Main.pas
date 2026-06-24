unit RiggVar.App.Main;

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
  RiggVar.FB.Scheme,
  RiggVar.FB.Transform,
  RiggVar.App.Main0;

type
  TMain = TMain0;

var
  Main: TMain;

type
  MainConst = class
  public const
    WantOldBandColors = False;
    PerspectiveZoomDefault = 10;
    OrthoZoomDefault = 0.5;
    TrackbarFrequency = 0.1;
    PlotCount = 11;
    SceneCount = 5;
    GraphCount = 5;
    FigureCount = 4;
    DrawFigureCount = 7;
    LineFigureCount = 9;
    DefaultMeshSize = 128;
    MaxMeshSize = 512;
    ColorSchemeCount = 8;
    DefaultBtnFontSize = 24;
    FC = True;
    RG = False;
  end;

  MainVar = class
  public class var
    InitDataOK: Boolean;
    GPUScale: Boolean;
    AppIsClosing: Boolean;
    TextureRepeat: Boolean;
    AppTitle: string;
    AppFolder: string;

    ColorScheme: TColorScheme;
    Transform2D: TTransform2D;
    Transform3D: TTransform3D;

    Raster: Integer;
    WheelFrequency: single;
    ShiftState: TShiftState;

    ClientWidth: Integer;
    ClientHeight: Integer;

    ShowEdges: Boolean;
    WantUniqueVertices: Boolean;
    UniqueMode: Integer;
    WantAutoFolder: Boolean;

    RG: Boolean;
    FC: Boolean;

    class constructor Create;
    class destructor Destroy;
  end;

var
  IsWebApp: Boolean = false;
  IsService: Boolean = false;
  IsWinGUI: Boolean = false;
  IsTest: Boolean = false;
  IsSandboxed: Boolean = true;
  WantErrorWindow: Boolean = true;
  CacheRequestToken: string;

const
  FederFileName = 'Feder-File.txt';
  FederFileNameAuto = 'Feder-File-Auto.txt';

implementation

{ MainVar }

class constructor MainVar.Create;
begin
  Raster := 70;
  WheelFrequency := 1;
  ShiftState := [];

  AppIsClosing := False;
  AppTitle := 'FC91P'; // sometimes initialized in FormMain, from Application.Title set in dpr
  AppFolder := 'FC';
  TextureRepeat := False;
  WantUniqueVertices := True;
  UniqueMode := 2;
  ShowEdges := False;

  ColorScheme := TColorScheme.Create(6);

  Transform2D := TTransform2D.Create;
  Transform2D.Init;

  Transform3D := TTransform3D.Create;
  Transform3D.Init;

  RG := False;
  FC := True;
end;

class destructor MainVar.Destroy;
begin
  Transform2D.Free;
  Transform3D.Free;

  inherited;
end;

end.