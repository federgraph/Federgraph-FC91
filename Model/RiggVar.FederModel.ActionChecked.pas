unit RiggVar.FederModel.ActionChecked;

(*
-
-     F
-    * *  *
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
  RiggVar.FB.ActionConst;

function GetFederActionChecked(fa: TFederAction): Boolean;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst;

function GetFederActionChecked(fa: TFederAction): Boolean;
var
  M: TMain;
begin
  result := False;
  M := Main;
  if M = nil then
    Exit;
  if not M.IsUp then
    Exit;

  case fa of
    faToggleAllText: result := M.FederText.AllVisible;
    faToggleTouchFrame: result := M.FederText.FrameVisible;
    faToggleTouchMenu: result := M.FederText.MenuVisible;
    faToggleEquationText: result := M.FederText.EquationVisible;
    faTogglePrimeText: result := M.FederText.TextVisible;
    faToggleSecondText: result := M.FederText.TitleVisible;

    faToggleContour: result := M.BitmapBuilder.WantContour;

    faShowCurrentBand0: result := not M.ShowCurrentBand;
    faShowCurrentBand1: result := M.ShowCurrentBand;
    faShowCurrentBandT: result := M.ShowCurrentBand;

    faMeshSize16: result := M.MeshSize = 16;
    faMeshSize32: result := M.MeshSize = 32;
    faMeshSize64: result := M.MeshSize = 64;
    faMeshSize128: result := M.MeshSize = 128;
    faMeshSize256: result := M.MeshSize = 256;
    faMeshSize316: result := M.MeshSize = 316;
    faMeshSize512: result := M.MeshSize = 512;

    faParamL: result := M.FederParam = fpL;
    faParamR: result := M.FederParam = fpAbsoluteRange;
    faNorthCap: result := M.FederParam = fpNorthCapValue;
    faSouthCap: result := M.FederParam = fpSouthCapValue;
    faParamCapValue: result := M.FederParam = fpParamCapValue;
    faParamT1: result := M.FederParam = fpt1;
    faParamT2: result := M.FederParam = fpt2;
    faParamCZ: result := M.FederParam = fpcz;

    faBandWidthRelative: result :=  (M.FederParam = fpBandWidth) and (M.BandWidthOption = bwRelative);

    faLayout0 .. faLayout9: result := M.TransitBarLayout = fa - faLayout0;

    faExportCoordsNative: result := M.ExportCoords = TExportCoords.Native;
    faExportCoordsBlender: result := M.ExportCoords = TExportCoords.App_Blender;
    faExportCoords3DV: result := M.ExportCoords = TExportCoords.App_3D_Viewer;
    faExportCoords3DP: result := M.ExportCoords = TExportCoords.App_3D_Printer;

    faWantAutoFolder: result := MainVar.WantAutoFolder;
    faWantMaterial: result := M.ExporterOBJ.WantMaterial;
    faWantSimpleName: result := M.ExporterOBJ.WantSimpleName;
    faWantAngularDir: result := M.ExporterOBJ.WantAngularDir;
    faWantNormals: result := M.ExporterOBJ.WantNormals;
    faWantUVs: result := M.ExporterOBJ.WantUVs;
    faObjDigits2: result := M.ExporterOBJ.ObjDigits = 2;
    faObjDigits3: result := M.ExporterOBJ.ObjDigits = 3;
    faObjDigits4: result := M.ExporterOBJ.ObjDigits = 4;
    faObjDigits5: result := M.ExporterOBJ.ObjDigits = 5;

    faToggleShowEdges: result := MainVar.ShowEdges;
    faTestSingleSide: result := not M.FederMesh.TwoSide;
    faToggleSolidFlip: result := M.vp.WantFlippedHands;
    faWantSpecialY: result := M.MeshBuilder.WantSpecialY;
    faToggleLux: result := M.vp.WantLux;

    faToggleColorPanel: result := M.ShowColorPanel;
    faToggleColorSwat: result := M.ShowColorSwat;

    faWantBottom: result := M.SolidPartVisible;
    faWantBottomMirrored: result := M.Inner.WantMirroredBottom;
    faWantSideCaps: result := M.SideCapVisible;
  end;
end;

end.
