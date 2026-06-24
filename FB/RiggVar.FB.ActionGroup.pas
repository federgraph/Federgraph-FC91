unit RiggVar.FB.ActionGroup;

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
  RiggVar.FB.ActionConst;

type
  TActionGroup = array of TFederAction;

const

// --- generated code ---

  ActionGroupEmptyAction: TActionGroup = [
    faNoop];

  ActionGroupPages: TActionGroup = [
    faActionPageM,
    faActionPageP,
    faActionPageE,
    faActionPageS,
    faActionPageX,
    faActionPage1,
    faActionPage2,
    faActionPage3,
    faActionPage4,
    faActionPage5,
    faActionPage6];

  ActionGroupSystemParam: TActionGroup = [
    faParamX1,
    faParamY1,
    faParamZ1,
    faParamL1,
    faParamK1,
    faParamX2,
    faParamY2,
    faParamZ2,
    faParamL2,
    faParamK2,
    faParamX3,
    faParamY3,
    faParamZ3,
    faParamL3,
    faParamK3,
    faParamX4,
    faParamY4,
    faParamZ4,
    faParamL4,
    faParamK4];

  ActionGroupOffsetParam: TActionGroup = [
    faOffsetX,
    faOffsetY,
    faOffsetZ];

  ActionGroupCoordParam: TActionGroup = [
    faCoord0,
    faCoord1,
    faCoord2,
    faCoord3];

  ActionGroupLuxParam: TActionGroup = [
    faParamL1X,
    faParamL1Y,
    faParamL1Z,
    faParamL2X,
    faParamL2Y,
    faParamL2Z,
    faParamL3X,
    faParamL3Y,
    faParamL3Z,
    faParamL4X,
    faParamL4Y,
    faParamL4Z];

  ActionGroupParamCycle: TActionGroup = [
    faCycleX,
    faCycleY,
    faCycleZ,
    faCycleL,
    faCycleK,
    faCycleO,
    faCycleR,
    faCycleT,
    faCycleU];

  ActionGroupModelParams: TActionGroup = [
    faParamR,
    faParamT,
    faParamL,
    faParamK,
    faParamZ,
    faParamA,
    faParamG,
    faParamX12,
    faParamY12,
    faParamZ12,
    faParamY3F,
    faParamL3F,
    faParamLF];

  ActionGroupRingActions: TActionGroup = [
    faBlindRingP,
    faBlindRingM,
    faCycleRingP,
    faCycleRingM,
    faToggleShirtColor,
    faShirtColorOn,
    faShirtColorOff,
    faApplyRingColor,
    faToggleShirtFarbe,
    faShirtFarbeOn,
    faShirtFarbeOff,
    faPixelCount1,
    faPixelCount2,
    faPixelCount4];

  ActionGroupParamBand: TActionGroup = [
    faParamBandSelected,
    faParamBandCount,
    faParamBandDistributionX,
    faParamBandDistributionY,
    faParamBandWidth,
    faBandWidthAbsolute,
    faBandWidthRelative,
    faBandWidthContour];

  ActionGroupBlindRingSelection: TActionGroup = [
    faBlindRing1,
    faBlindRing5,
    faBlindRingA,
    faBlindRingB,
    faBlindRingC,
    faBlindRingD,
    faBlindRingE,
    faBlindRingF];

  ActionGroupCurrentBand: TActionGroup = [
    faShowCurrentBand0,
    faShowCurrentBand1,
    faShowCurrentBandT];

  ActionGroupBandSelection: TActionGroup = [
    faBandSelectionM,
    faBandSelectionP,
    faBandSelection16,
    faBandSelection17,
    faBandSelection18,
    faBandSelection19,
    faBandSelection20,
    faBandSelection21];

  ActionGroupMeshSize: TActionGroup = [
    faMeshSize4,
    faMeshSize8,
    faMeshSize16,
    faMeshSize32,
    faMeshSize64,
    faMeshSize128,
    faMeshSize256,
    faMeshSize316,
    faMeshSize512];

  ActionGroupMeshExport: TActionGroup = [
    faWantBottom,
    faWantBottomMirrored,
    faWantSideCaps,
    faTestSingleSide];

  ActionGroupMeshExportCoords: TActionGroup = [
    faExportCoordsNative,
    faExportCoordsBlender,
    faExportCoords3DV,
    faExportCoords3DP];

  ActionGroupExporterOBJ: TActionGroup = [
    faWantAutoFolder,
    faExportMtl,
    faExportObj,
    faWantMaterial,
    faWantSimpleName,
    faWantAngularDir,
    faWantNormals,
    faWantUVs,
    faObjDigits2,
    faObjDigits3,
    faObjDigits4,
    faObjDigits5];

  ActionGroupMeshBuilderOptions: TActionGroup = [
    faToggleSolidFlip,
    faWantSpecialY,
    faToggleShowEdges,
    faUniqueMode1,
    faUniqueMode2,
    faToggleUniqueVertices];

  ActionGroupColorSwat: TActionGroup = [
    faToggleColorSwat];

  ActionGroupLux: TActionGroup = [
    faToggleLux];

  ActionGroupWheel: TActionGroup = [
    faParamValuePlus1,
    faParamValueMinus1,
    faParamValuePlus10,
    faParamValueMinus10,
    faWheelLeft,
    faWheelRight,
    faWheelDown,
    faWheelUp];

  ActionGroupWheelFrequency: TActionGroup = [
    faWheelFrequency1,
    faWheelFrequency01,
    faWheelFrequency001];

  ActionGroupColorScheme: TActionGroup = [
    faCycleColorSchemeM,
    faCycleColorSchemeP];

  ActionGroupUI: TActionGroup = [
    faToggleColorPanel];

  ActionGroupViewParams: TActionGroup = [
    faPan,
    faParamRX,
    faParamRY,
    faParamRZ,
    faParamCZ];

  ActionGroupParamT: TActionGroup = [
    faParamT1,
    faParamT2,
    faParamT3,
    faParamT4];

  ActionGroupBahn: TActionGroup = [
    faNorthCap,
    faSouthCap,
    faParamCapValue];

  ActionGroupReset: TActionGroup = [
    faReset,
    faResetPosition,
    faResetRotation,
    faResetZoom];

  ActionGroupBitmapCycle: TActionGroup = [
    faCycleBitmapM,
    faCycleBitmapP,
    faRandom,
    faRandomWhite,
    faRandomBlack,
    faBitmapEscape,
    faBitmapOne,
    faToggleContour];

implementation

end.
