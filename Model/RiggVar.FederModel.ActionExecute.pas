unit RiggVar.FederModel.ActionExecute;

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

{ return  true if handled }
function FederActionExecute(fa: TFederAction): Boolean;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FB.DefConst,
  RiggVar.FB.Def;

function FederActionExecute(fa: TFederAction): Boolean;
var
  M: TMain;
begin
  result := True;

  M := Main;
  if M = nil then
    Exit;

  case fa of
    faMeshSize32: M.MeshSize := 32;
    faMeshSize64: M.MeshSize := 64;
    faMeshSize128: M.MeshSize := 128;
    faMeshSize256: M.MeshSize := 256;
    faMeshSize512: M.MeshSize := 512;

    faReset: M.DoReset;
    faResetPosition: M.DoResetPosition;
    faResetRotation: M.DoResetRotation;
    faResetZoom: M.DoResetZoom;

    faRandomBlack: M.RandomBitmapBlack;
    faBitmapEscape: M.CycleBitmapE;
    faBitmapOne: M.CycleBitmapOne;

    faToggleContour: M.ToggleContourPixel;

    faToggleColorPanel: M.ToggleColorPanel;
    faToggleColorSwat: M.ShowColorSwat := not M.ShowColorSwat;

    faShowCurrentBand0: M.ShowCurrentBand := False;
    faShowCurrentBand1: M.ShowCurrentBand := True;
    faShowCurrentBandT: M.ShowCurrentBand := not M.ShowCurrentBand;

    faBandWidthRelative:
    begin
      M.BandWidthOption := bwRelative;
      M.FederParam := fpBandWidth;
    end;

    faToggleShowEdges: M.ToggleShowEdges;

    faExportCoordsNative: M.ExportCoords := TExportCoords.Native;
    faExportCoordsBlender: M.ExportCoords := TExportCoords.App_Blender;
    faExportCoords3DV: M.ExportCoords := TExportCoords.App_3D_Viewer;
    faExportCoords3DP: M.ExportCoords := TExportCoords.App_3D_Printer;

    faExportMtl: M.ExportMtl;
    faExportObj: M.ExportObj;
    faWantAutoFolder: MainVar.WantAutoFolder := not MainVar.WantAutoFolder;
    faWantMaterial: M.ExporterOBJ.WantMaterial := not M.ExporterOBJ.WantMaterial;
    faWantSimpleName: M.ExporterOBJ.WantSimpleName := not M.ExporterOBJ.WantSimpleName;
    faWantAngularDir: M.ExporterOBJ.WantAngularDir := not M.ExporterOBJ.WantAngularDir;
    faWantNormals: M.ExporterOBJ.WantNormals := not M.ExporterOBJ.WantNormals;
    faWantUvs: M.ExporterOBJ.WantUVs := not M.ExporterOBJ.WantUVs;
    faObjDigits2: M.ExporterOBJ.ObjDigits := 2;
    faObjDigits3: M.ExporterOBJ.ObjDigits := 3;
    faObjDigits4: M.ExporterOBJ.ObjDigits := 4;
    faObjDigits5: M.ExporterOBJ.ObjDigits := 5;

    faWantSpecialY: M.ToggleSpecialY;
    faTestSingleSide: M.ToggleSingleSide;
    faToggleSolidFlip: M.ToggleSolidFlip;

    faParamCZ: M.FederParam := fpcz;
    faParamT1: M.FederParam := fpt1;
    faParamT2: M.FederParam := fpt2;
    faParamR: M.FederParam := fpAbsoluteRange;
    faParamL: M.FederParam := fpL;
    faNorthCap: M.FederParam := fpNorthCapValue;
    faSouthCap: M.FederParam := fpSouthCapValue;
    faParamCapValue: M.FederParam := fpParamCapValue;

    faWantBottom: M.ToggleBottom;
    faWantBottomMirrored: M.ToggleMirroredBottom;
    faWantSideCaps: M.ToggleSideCaps;

    faToggleLux: M.ToggleLux(-1);
    else
    begin
      result := False;
    end;

  end;
end;

end.
