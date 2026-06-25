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
    faToggleAllText: M.FederText.ToggleAllText;
    faToggleTouchMenu: M.FederText.ToggleTouchMenu;
    faToggleTouchFrame: M.FederText.ToggleTouchFrame;
    faToggleEquationText: M.FederText.ToggleEquationText;
    faTogglePrimeText: M.FederText.TogglePrimeText;
    faToggleSecondText: M.FederText.ToggleSecondText;

    faParamValueMinus1,
    faWheelLeft: M.DoMouseWheel([ssShift], -1);

    faParamValuePlus1,
    faWheelRight: M.DoMouseWheel([ssShift], 1);

    faParamValuePlus10,
    faWheelUp: M.DoMouseWheel([ssCtrl], 1);

    faParamValueMinus10,
    faWheelDown: M.DoMouseWheel([ssCtrl], -1);

    faActionPageM: M.CycleToolSet(-1);
    faActionPageP: M.CycleToolSet(1);
    faActionPage1: M.FederText.ActionPage := 1;
    faActionPage2: M.FederText.ActionPage := 2;
    faActionPage3: M.FederText.ActionPage := 3;
    faActionPage4: M.FederText.ActionPage := 4;
    faActionPage5: M.FederText.ActionPage := 5;
    faActionPage6: M.FederText.ActionPage := 6;
    faActionPageE: M.FederText.ActionPage := -1;
    faActionPageS: M.FederText.ActionPage := -3;
    faActionPageX: M.FederText.ActionPage := -2;

    faCycleBitmapP: M.CycleBitmapP;
    faCycleBitmapM:  M.CycleBitmapM;

    faCycleColorSchemeM: M.CycleColorSchemeM;
    faCycleColorSchemeP: M.CycleColorSchemeP;

    faMeshSize16: M.MeshSize := 16;
    faMeshSize32: M.MeshSize := 32;
    faMeshSize64: M.MeshSize := 64;
    faMeshSize128: M.MeshSize := 128;
    faMeshSize256: M.MeshSize := 256;
    faMeshSize316: M.MeshSize := 316;
    faMeshSize512: M.MeshSize := 512;

    faReset: M.DoReset;
    faResetPosition: M.DoResetPosition;
    faResetRotation: M.DoResetRotation;
    faResetZoom: M.DoResetZoom;

    faRandomBlack: M.RandomBitmapBlack;
    faBitmapEscape: M.CycleBitmapE;
    faBitmapOne: M.CycleBitmapOne;

    faToggleContour: M.ToggleContourPixel;

    faGotoSample1: M.DoReset;

    faLabelBatchP: M.ToggleLabelBatch(1);
    faLabelBatchM: M.ToggleLabelBatch(-1);

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

    faShowInfo: M.ShowInfo;
    faToggleShowEdges: M.ToggleShowEdges;

    faCLA,
    faTL01 .. faTL06,
    faTR01 .. faTR08,
    faBL01 .. faBL08,
    faBR01 .. faBR06: M.ApplyButtonColor(fa);

    faLayout0 .. faLayout9: M.TransitBarLayout := fa - faLayout0;

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
