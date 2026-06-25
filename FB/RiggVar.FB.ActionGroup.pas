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

  ActionGroupForms: TActionGroup = [
    faShowImage,
    faShowMemo,
    faShowActions,
    faShowColor,
    faShowBambu,
    faShowInfo];

  ActionGroupTouchLayout: TActionGroup = [
    faTouchTablet,
    faTouchPhone,
    faTouchDesk];

  ActionGroupActionMapping: TActionGroup = [
    faProcessAll];

  ActionGroupScene: TActionGroup = [
    faScene1,
    faScene2,
    faScene3,
    faScene4,
    faScene5];

  ActionGroupPlot: TActionGroup = [
    faPlot0,
    faPlot1,
    faPlot2,
    faPlot3,
    faPlot4,
    faPlot5,
    faPlot6,
    faPlot7,
    faPlot8,
    faPlot9,
    faPlot10,
    faPlot11,
    faPlot12,
    faPlot13];

  ActionGroupFigure: TActionGroup = [
    faFigure1,
    faFigure2,
    faFigure3,
    faFigure4,
    faFigure5,
    faFigure6];

  ActionGroupGraph: TActionGroup = [
    faGraph1,
    faGraph2,
    faGraph3,
    faGraph4,
    faGraph5];

  ActionGroupColor: TActionGroup = [
    faColor0,
    faColor1,
    faColor2,
    faColor3,
    faColor4,
    faColor5,
    faColor6];

  ActionGroupParam: TActionGroup = [
    faParam0,
    faParam1,
    faParam2,
    faParam3,
    faParam4,
    faParam5,
    faParam6,
    faParam7,
    faParam8,
    faParam9];

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

  ActionGroupModelOptions: TActionGroup = [
    faToggleSolutionMode,
    faToggleVorzeichen,
    faToggleLinearForce,
    faToggleGleich,
    faToggleMCap,
    faTogglePCap,
    faForceZ0,
    faWantZ12,
    faDiff0,
    faDiff1,
    faDiff10];

  ActionGroupOptionCycle: TActionGroup = [
    faCyclePlotM,
    faCyclePlotP,
    faCycleGraphM,
    faCycleGraphP,
    faCycleFigureM,
    faCycleFigureP];

  ActionGroupForceMode: TActionGroup = [
    faForceMode0,
    faForceMode1,
    faForceMode2];

  ActionGroupFederMode: TActionGroup = [
    faM1,
    faM2,
    faM3];

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

  ActionGroupMeshMode: TActionGroup = [
    faOpenMesh,
    faPolarMesh,
    faReducedMesh,
    faReduceMode0,
    faReduceMode1,
    faReduceMode2,
    faReduceMode3];

  ActionGroupMeshSize: TActionGroup = [
    faMeshSize4,
    faMeshSize8,
    faMeshSize16,
    faMeshSize32,
    faMeshSize64,
    faMeshSize128,
    faMeshSize256,
    faMeshSize316,
    faMeshSize512,
    faMeshSize1024];

  ActionGroupMeshExport: TActionGroup = [
    faWantBottom,
    faWantBottomMirrored,
    faWantSideCaps,
    faTestSingleSide,
    faTakeCapValueSnapshot];

  ActionGroupMeshExportCoords: TActionGroup = [
    faExportCoordsNative,
    faExportCoordsBlender,
    faExportCoords3DV,
    faExportCoords3DP];

  ActionGroupMeshOptions: TActionGroup = [
    faTextureJitt,
    faTextureJack];

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

  ActionGroupMeshFigures: TActionGroup = [
    faToggleMarker,
    faToggleGrid,
    faToggleGridFrequency,
    faToggleDiameter3,
    faDiameter3On,
    faDiameter3Off,
    faToggleCylinder,
    faToggleCube,
    faToggleCorner,
    faToggleLimitPlane];

  ActionGroupVertexPulling: TActionGroup = [
    faToggleZeroPulling,
    faToggleLimitPulling,
    faToggleSlicePulling,
    faToggleTargetPulling,
    faToggleRightPulling,
    faToggleCrackFixing];

  ActionGroupMeshBuilderOptions: TActionGroup = [
    faToggleSolidFlip,
    faWantSpecialY,
    faToggleShowEdges,
    faUniqueMode1,
    faUniqueMode2,
    faToggleUniqueVertices];

  ActionGroupPin: TActionGroup = [
    faTogglePin,
    faPinOn,
    faPinOff];

  ActionGroupNorm: TActionGroup = [
    faToggleNorm,
    faNormOn,
    faNormOff];

  ActionGroupTextureNorm: TActionGroup = [
    faTextureNormP,
    faTextureNormM,
    faTextureNorm0,
    faTextureNorm1,
    faTextureNorm2];

  ActionGroupTextureExport: TActionGroup = [
    faCopyBinCode,
    faCopyBinCodeTest];

  ActionGroupTextureImport: TActionGroup = [
    faTextureClear];

  ActionGroupColorMix: TActionGroup = [
    faColorMix0,
    faColorMix1,
    faColorMix2,
    faColorMix3,
    faColorMix4,
    faColorMix5,
    faColorMixP,
    faColorMixM];

  ActionGroupColorSwat: TActionGroup = [
    faToggleColorSwat];

  ActionGroupLux: TActionGroup = [
    faLux1On,
    faLux1Off,
    faToggleLux1,
    faLux2On,
    faLux2Off,
    faToggleLux2,
    faLux3On,
    faLux3Off,
    faToggleLux3,
    faLux4On,
    faLux4Off,
    faToggleLux4,
    faLuxOn,
    faLuxOff,
    faToggleLux];

  ActionGroupLuxMarker: TActionGroup = [
    faLuxMarkerOn,
    faLuxMarkerOff,
    faToggleLuxMarker];

  ActionGroupLightMode: TActionGroup = [
    faLightMode0,
    faLightMode1,
    faLightMode2,
    faLightMode3,
    faLightMode4];

  ActionGroupResetLight: TActionGroup = [
    faResetLightPosition,
    faResetLightParams];

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
    faWheelFrequency05,
    faWheelFrequency02,
    faWheelFrequency01,
    faWheelFrequency001,
    faWheelFrequency0001];

  ActionGroupColorScheme: TActionGroup = [
    faCycleColorSchemeM,
    faCycleColorSchemeP];

  ActionGroupStep: TActionGroup = [
    faStepRXM,
    faStepRXP,
    faStepRYM,
    faStepRYP,
    faStepRZM,
    faStepRZP,
    faStepCZM,
    faStepCZP];

  ActionGroupUI: TActionGroup = [
    faToggleColorPanel,
    faColorPanelOn,
    faColorPanelOff,
    faPaletteOn,
    faPaletteOff];

  ActionGroupLocks: TActionGroup = [
    faToggleLuxLock,
    faToggleParamLock,
    faToggleTextureLock,
    faToggleBackgroundLock,
    faToggleForceLock,
    faToggleReportLock];

  ActionGroupOpacity: TActionGroup = [
    faToggleOpacity,
    faOpacityOn,
    faOpacityOff];

  ActionGroupFederText: TActionGroup = [
    faToggleAllText,
    faToggleTouchFrame];

  ActionGroupViewParams: TActionGroup = [
    faPan,
    faParamRX,
    faParamRY,
    faParamRZ,
    faParamCZ];

  ActionGroupViewParamsFC: TActionGroup = [
    faParamTRS,
    faParamTRT,
    faParamTRX,
    faParamTRY];

  ActionGroupParamT: TActionGroup = [
    faParamT1,
    faParamT2,
    faParamT3,
    faParamT4];

  ActionGroupViewFlags: TActionGroup = [
    faToggleBMap,
    faToggleZoom,
    faToggleTouchMenu,
    faToggleEquationText,
    faTogglePrimeText,
    faToggleSecondText,
    faToggleLabelText,
    faLabelBatchM,
    faLabelBatchP,
    faLabelTextP,
    faLabelTextM];

  ActionGroupReport: TActionGroup = [
    faCopyShortCutReport,
    faWriteActionReport,
    faWriteActionTable,
    faWriteActionConst,
    faWriteActionNames,
    faWriteVersion1,
    faWriteVersion2,
    faWriteCode,
    faWriteDiff1,
    faWriteDiffCode,
    faWriteDiffBin,
    faWriteBandInfo3,
    faWriteBandInfo5,
    faWriteEquationInfo,
    faWriteVirtual,
    faBlockTest];

  ActionGroupReportOptions: TActionGroup = [
    faSourcePascal,
    faSourceMaxima,
    faSourceMaple,
    faSourceMathematica];

  ActionGroupCopyImage: TActionGroup = [
    faCopyScreenshot,
    faCopyBitmap3D,
    faCopyTextureBitmap,
    faCopyImprintedBitmap,
    faCopyImprintedBitmapTest];

  ActionGroupCopyOptions: TActionGroup = [
    faToggleHardCopy,
    faHardCopyOn,
    faHardCopyOff,
    faTogglePngCopy,
    faPngCopyOn,
    faPngCopyOff,
    faToggleNoCopy,
    faNoCopyOn,
    faNoCopyOff];

  ActionGroupGraphOptions: TActionGroup = [
    faToggleDiameter,
    faToggleProbe];

  ActionGroupBahn: TActionGroup = [
    faNorthCap,
    faSouthCap,
    faEastCap,
    faWestCap,
    faParamCapValue,
    faParamBahnRadius,
    faParamBahnPositionX,
    faParamBahnPositionY,
    faParamBahnAngle,
    faParamBahnCylinderD,
    faParamBahnCylinderZ];

  ActionGroupExampleData: TActionGroup = [
    faExample01,
    faExample02,
    faExample03,
    faExample04,
    faExample05,
    faExample06,
    faExample07,
    faExample08,
    faExample09];

  ActionGroupRepo: TActionGroup = [
    faSwapBundle,
    faRepo010,
    faRepo020,
    faRepo050];

  ActionGroupSampleNavigation: TActionGroup = [
    faLevelM,
    faLevelP,
    faHubM,
    faHubP,
    faSampleM,
    faSampleP,
    faGotoSample0,
    faGotoSample1];

  ActionGroupHelp: TActionGroup = [
    faToggleHelp,
    faToggleReport,
    faToggleButtonReport,
    faCycleHelpM,
    faCycleHelpP,
    faHelpCycle,
    faHelpList,
    faHelpHome];

  ActionGroupBtnLegendTablet: TActionGroup = [
    faTL01,
    faTL02,
    faTL03,
    faTL04,
    faTL05,
    faTL06,
    faTR01,
    faTR02,
    faTR03,
    faTR04,
    faTR05,
    faTR06,
    faTR07,
    faTR08,
    faBL01,
    faBL02,
    faBL03,
    faBL04,
    faBL05,
    faBL06,
    faBL07,
    faBL08,
    faBR01,
    faBR02,
    faBR03,
    faBR04,
    faBR05,
    faBR06];

  ActionGroupBtnLegendPhone: TActionGroup = [
    faMB01,
    faMB02,
    faMB03,
    faMB04,
    faMB05,
    faMB06,
    faMB07,
    faMB08];

  ActionGroupTouchBarLegend: TActionGroup = [
    faTouchBarTop,
    faTouchBarBottom,
    faTouchBarLeft,
    faTouchBarRight];

  ActionGroupReset: TActionGroup = [
    faReset,
    faResetPosition,
    faResetRotation,
    faResetZoom];

  ActionGroupLanguage: TActionGroup = [
    faToggleLanguage];

  ActionGroupCopyPaste: TActionGroup = [
    faSave,
    faLoad,
    faOpen,
    faCopy,
    faPaste];

  ActionGroupViewOptions: TActionGroup = [
    faToggleMoveMode,
    faLinearMove,
    faExpoMove,
    faToggleOrbitMode];

  ActionGroupBitmapCycle: TActionGroup = [
    faCycleBitmapM,
    faCycleBitmapP,
    faRandom,
    faRandomWhite,
    faRandomBlack,
    faRandomBambu1,
    faRandomBambu2,
    faBitmapEscape,
    faBitmapOne,
    faToggleContour];

  ActionGroupLayout0: TActionGroup = [
    faLayout0,
    faLayout1,
    faLayout2,
    faLayout3,
    faLayout4,
    faLayout5,
    faLayout6,
    faLayout7,
    faLayout8,
    faLayout9];

  ActionGroupLayout1: TActionGroup = [
    faLayout10,
    faLayout11,
    faLayout12,
    faLayout13,
    faLayout14,
    faLayout15,
    faLayout16,
    faLayout17,
    faLayout18,
    faLayout19];

  ActionGroupLayout2: TActionGroup = [
    faLayout20,
    faLayout21,
    faLayout22,
    faLayout23,
    faLayout24,
    faLayout25,
    faLayout26,
    faLayout27,
    faLayout28,
    faLayout29];

  ActionGroupLayout3: TActionGroup = [
    faLayout30,
    faLayout31,
    faLayout32,
    faLayout33,
    faLayout34,
    faLayout35,
    faLayout36,
    faLayout37,
    faLayout38,
    faLayout39];

  ActionGroupLayout4: TActionGroup = [
    faLayout40,
    faLayout41,
    faLayout42,
    faLayout43,
    faLayout44,
    faLayout45,
    faLayout46,
    faLayout47,
    faLayout48,
    faLayout49];

  ActionGroupLayout5: TActionGroup = [
    faLayout50,
    faLayout51,
    faLayout52,
    faLayout53,
    faLayout54,
    faLayout55,
    faLayout56,
    faLayout57,
    faLayout58,
    faLayout59];

  ActionGroupLayout6: TActionGroup = [
    faLayout60,
    faLayout61,
    faLayout62,
    faLayout63,
    faLayout64,
    faLayout65,
    faLayout66,
    faLayout67,
    faLayout68,
    faLayout69];

  ActionGroupLayout7: TActionGroup = [
    faLayout70,
    faLayout71,
    faLayout72,
    faLayout73,
    faLayout74,
    faLayout75,
    faLayout76,
    faLayout77,
    faLayout78,
    faLayout79];

  ActionGroupLayout8: TActionGroup = [
    faLayout80,
    faLayout81,
    faLayout82,
    faLayout83,
    faLayout84,
    faLayout85,
    faLayout86,
    faLayout87,
    faLayout88,
    faLayout89];

  ActionGroupLayout9: TActionGroup = [
    faLayout90,
    faLayout91,
    faLayout92,
    faLayout93,
    faLayout94,
    faLayout95,
    faLayout96,
    faLayout97,
    faLayout98,
    faLayout99];

  ActionGroupMenuNav: TActionGroup = [
    faMenuXX,
    faMenu00,
    faMenu10,
    faMenu20,
    faMenu30,
    faMenu40,
    faMenu50,
    faMenu60,
    faMenu70,
    faMenu80,
    faMenu90];

  ActionGroupFigureSize: TActionGroup = [
    faFigureSizeXS,
    faFigureSizeS,
    faFigureSizeM,
    faFigureSizeL,
    faFigureSizeXL];

  ActionGroupEyeSize: TActionGroup = [
    faEyeSizeS,
    faEyeSizeM,
    faEyeSizeL];

  ActionGroupLayerSelection: TActionGroup = [
    faSelectLayer1,
    faSelectLayer2,
    faSelectLayer3,
    faSelectLayer4,
    faSelectLayer5,
    faSelectLayer6,
    faSelectLayer7];

  ActionGroupColorSelection: TActionGroup = [
    faSelectColor1,
    faSelectColor2,
    faSelectColor3,
    faSelectColor4];

  ActionGroupColorMapping: TActionGroup = [
    faCLA,
    faMapColorToLayer,
    faSelectColorMapping1,
    faSelectColorMapping2,
    faSelectColorMapping3,
    faSelectColorMapping4,
    faSelectColorMapping5,
    faSelectColorMapping6];

implementation

end.
