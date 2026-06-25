unit RiggVar.FB.ActionName;

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

function GetFederActionName(fa: TFederAction): string;

implementation

function GetFederActionName(fa: TFederAction): string;
begin
  result := '??';
  case fa of
    // --- generated code snippet ---

    { EmptyAction }
    faNoop: result := 'faNoop';

    { Pages }
    faActionPageM: result := 'faActionPageM';
    faActionPageP: result := 'faActionPageP';
    faActionPageE: result := 'faActionPageE';
    faActionPageS: result := 'faActionPageS';
    faActionPageX: result := 'faActionPageX';
    faActionPage1: result := 'faActionPage1';
    faActionPage2: result := 'faActionPage2';
    faActionPage3: result := 'faActionPage3';
    faActionPage4: result := 'faActionPage4';
    faActionPage5: result := 'faActionPage5';
    faActionPage6: result := 'faActionPage6';

    { Forms }
    faShowImage: result := 'faShowImage';
    faShowMemo: result := 'faShowMemo';
    faShowActions: result := 'faShowActions';
    faShowColor: result := 'faShowColor';
    faShowBambu: result := 'faShowBambu';
    faShowInfo: result := 'faShowInfo';

    { TouchLayout }
    faTouchTablet: result := 'faTouchTablet';
    faTouchPhone: result := 'faTouchPhone';
    faTouchDesk: result := 'faTouchDesk';

    { ActionMapping }
    faProcessAll: result := 'faProcessAll';

    { Scene }
    faScene1: result := 'faScene1';
    faScene2: result := 'faScene2';
    faScene3: result := 'faScene3';
    faScene4: result := 'faScene4';
    faScene5: result := 'faScene5';

    { Plot }
    faPlot0: result := 'faPlot0';
    faPlot1: result := 'faPlot1';
    faPlot2: result := 'faPlot2';
    faPlot3: result := 'faPlot3';
    faPlot4: result := 'faPlot4';
    faPlot5: result := 'faPlot5';
    faPlot6: result := 'faPlot6';
    faPlot7: result := 'faPlot7';
    faPlot8: result := 'faPlot8';
    faPlot9: result := 'faPlot9';
    faPlot10: result := 'faPlot10';
    faPlot11: result := 'faPlot11';
    faPlot12: result := 'faPlot12';
    faPlot13: result := 'faPlot13';

    { Figure }
    faFigure1: result := 'faFigure1';
    faFigure2: result := 'faFigure2';
    faFigure3: result := 'faFigure3';
    faFigure4: result := 'faFigure4';
    faFigure5: result := 'faFigure5';
    faFigure6: result := 'faFigure6';

    { Graph }
    faGraph1: result := 'faGraph1';
    faGraph2: result := 'faGraph2';
    faGraph3: result := 'faGraph3';
    faGraph4: result := 'faGraph4';
    faGraph5: result := 'faGraph5';

    { Color }
    faColor0: result := 'faColor0';
    faColor1: result := 'faColor1';
    faColor2: result := 'faColor2';
    faColor3: result := 'faColor3';
    faColor4: result := 'faColor4';
    faColor5: result := 'faColor5';
    faColor6: result := 'faColor6';

    { Param }
    faParam0: result := 'faParam0';
    faParam1: result := 'faParam1';
    faParam2: result := 'faParam2';
    faParam3: result := 'faParam3';
    faParam4: result := 'faParam4';
    faParam5: result := 'faParam5';
    faParam6: result := 'faParam6';
    faParam7: result := 'faParam7';
    faParam8: result := 'faParam8';
    faParam9: result := 'faParam9';

    { SystemParam }
    faParamX1: result := 'faParamX1';
    faParamY1: result := 'faParamY1';
    faParamZ1: result := 'faParamZ1';
    faParamL1: result := 'faParamL1';
    faParamK1: result := 'faParamK1';
    faParamX2: result := 'faParamX2';
    faParamY2: result := 'faParamY2';
    faParamZ2: result := 'faParamZ2';
    faParamL2: result := 'faParamL2';
    faParamK2: result := 'faParamK2';
    faParamX3: result := 'faParamX3';
    faParamY3: result := 'faParamY3';
    faParamZ3: result := 'faParamZ3';
    faParamL3: result := 'faParamL3';
    faParamK3: result := 'faParamK3';
    faParamX4: result := 'faParamX4';
    faParamY4: result := 'faParamY4';
    faParamZ4: result := 'faParamZ4';
    faParamL4: result := 'faParamL4';
    faParamK4: result := 'faParamK4';

    { OffsetParam }
    faOffsetX: result := 'faOffsetX';
    faOffsetY: result := 'faOffsetY';
    faOffsetZ: result := 'faOffsetZ';

    { CoordParam }
    faCoord0: result := 'faCoord0';
    faCoord1: result := 'faCoord1';
    faCoord2: result := 'faCoord2';
    faCoord3: result := 'faCoord3';

    { LuxParam }
    faParamL1X: result := 'faParamL1X';
    faParamL1Y: result := 'faParamL1Y';
    faParamL1Z: result := 'faParamL1Z';
    faParamL2X: result := 'faParamL2X';
    faParamL2Y: result := 'faParamL2Y';
    faParamL2Z: result := 'faParamL2Z';
    faParamL3X: result := 'faParamL3X';
    faParamL3Y: result := 'faParamL3Y';
    faParamL3Z: result := 'faParamL3Z';
    faParamL4X: result := 'faParamL4X';
    faParamL4Y: result := 'faParamL4Y';
    faParamL4Z: result := 'faParamL4Z';

    { ParamCycle }
    faCycleX: result := 'faCycleX';
    faCycleY: result := 'faCycleY';
    faCycleZ: result := 'faCycleZ';
    faCycleL: result := 'faCycleL';
    faCycleK: result := 'faCycleK';
    faCycleO: result := 'faCycleO';
    faCycleR: result := 'faCycleR';
    faCycleT: result := 'faCycleT';
    faCycleU: result := 'faCycleU';

    { ModelParams }
    faParamR: result := 'faParamR';
    faParamT: result := 'faParamT';
    faParamL: result := 'faParamL';
    faParamK: result := 'faParamK';
    faParamZ: result := 'faParamZ';
    faParamA: result := 'faParamA';
    faParamG: result := 'faParamG';
    faParamX12: result := 'faParamX12';
    faParamY12: result := 'faParamY12';
    faParamZ12: result := 'faParamZ12';
    faParamY3F: result := 'faParamY3F';
    faParamL3F: result := 'faParamL3F';
    faParamLF: result := 'faParamLF';

    { ModelOptions }
    faToggleSolutionMode: result := 'faToggleSolutionMode';
    faToggleVorzeichen: result := 'faToggleVorzeichen';
    faToggleLinearForce: result := 'faToggleLinearForce';
    faToggleGleich: result := 'faToggleGleich';
    faToggleMCap: result := 'faToggleMCap';
    faTogglePCap: result := 'faTogglePCap';
    faForceZ0: result := 'faForceZ0';
    faWantZ12: result := 'faWantZ12';
    faDiff0: result := 'faDiff0';
    faDiff1: result := 'faDiff1';
    faDiff10: result := 'faDiff10';

    { OptionCycle }
    faCyclePlotM: result := 'faCyclePlotM';
    faCyclePlotP: result := 'faCyclePlotP';
    faCycleGraphM: result := 'faCycleGraphM';
    faCycleGraphP: result := 'faCycleGraphP';
    faCycleFigureM: result := 'faCycleFigureM';
    faCycleFigureP: result := 'faCycleFigureP';

    { ForceMode }
    faForceMode0: result := 'faForceMode0';
    faForceMode1: result := 'faForceMode1';
    faForceMode2: result := 'faForceMode2';

    { FederMode }
    faM1: result := 'faM1';
    faM2: result := 'faM2';
    faM3: result := 'faM3';

    { RingActions }
    faBlindRingP: result := 'faBlindRingP';
    faBlindRingM: result := 'faBlindRingM';
    faCycleRingP: result := 'faCycleRingP';
    faCycleRingM: result := 'faCycleRingM';
    faToggleShirtColor: result := 'faToggleShirtColor';
    faShirtColorOn: result := 'faShirtColorOn';
    faShirtColorOff: result := 'faShirtColorOff';
    faApplyRingColor: result := 'faApplyRingColor';
    faToggleShirtFarbe: result := 'faToggleShirtFarbe';
    faShirtFarbeOn: result := 'faShirtFarbeOn';
    faShirtFarbeOff: result := 'faShirtFarbeOff';
    faPixelCount1: result := 'faPixelCount1';
    faPixelCount2: result := 'faPixelCount2';
    faPixelCount4: result := 'faPixelCount4';

    { ParamBand }
    faParamBandSelected: result := 'faParamBandSelected';
    faParamBandCount: result := 'faParamBandCount';
    faParamBandDistributionX: result := 'faParamBandDistributionX';
    faParamBandDistributionY: result := 'faParamBandDistributionY';
    faParamBandWidth: result := 'faParamBandWidth';
    faBandWidthAbsolute: result := 'faBandWidthAbsolute';
    faBandWidthRelative: result := 'faBandWidthRelative';
    faBandWidthContour: result := 'faBandWidthContour';

    { BlindRingSelection }
    faBlindRing1: result := 'faBlindRing1';
    faBlindRing5: result := 'faBlindRing5';
    faBlindRingA: result := 'faBlindRingA';
    faBlindRingB: result := 'faBlindRingB';
    faBlindRingC: result := 'faBlindRingC';
    faBlindRingD: result := 'faBlindRingD';
    faBlindRingE: result := 'faBlindRingE';
    faBlindRingF: result := 'faBlindRingF';

    { CurrentBand }
    faShowCurrentBand0: result := 'faShowCurrentBand0';
    faShowCurrentBand1: result := 'faShowCurrentBand1';
    faShowCurrentBandT: result := 'faShowCurrentBandT';

    { BandSelection }
    faBandSelectionM: result := 'faBandSelectionM';
    faBandSelectionP: result := 'faBandSelectionP';
    faBandSelection16: result := 'faBandSelection16';
    faBandSelection17: result := 'faBandSelection17';
    faBandSelection18: result := 'faBandSelection18';
    faBandSelection19: result := 'faBandSelection19';
    faBandSelection20: result := 'faBandSelection20';
    faBandSelection21: result := 'faBandSelection21';

    { MeshMode }
    faOpenMesh: result := 'faOpenMesh';
    faPolarMesh: result := 'faPolarMesh';
    faReducedMesh: result := 'faReducedMesh';
    faReduceMode0: result := 'faReduceMode0';
    faReduceMode1: result := 'faReduceMode1';
    faReduceMode2: result := 'faReduceMode2';
    faReduceMode3: result := 'faReduceMode3';

    { MeshSize }
    faMeshSize4: result := 'faMeshSize4';
    faMeshSize8: result := 'faMeshSize8';
    faMeshSize16: result := 'faMeshSize16';
    faMeshSize32: result := 'faMeshSize32';
    faMeshSize64: result := 'faMeshSize64';
    faMeshSize128: result := 'faMeshSize128';
    faMeshSize256: result := 'faMeshSize256';
    faMeshSize316: result := 'faMeshSize316';
    faMeshSize512: result := 'faMeshSize512';
    faMeshSize1024: result := 'faMeshSize1024';

    { MeshExport }
    faWantBottom: result := 'faWantBottom';
    faWantBottomMirrored: result := 'faWantBottomMirrored';
    faWantSideCaps: result := 'faWantSideCaps';
    faTestSingleSide: result := 'faTestSingleSide';
    faTakeCapValueSnapshot: result := 'faTakeCapValueSnapshot';

    { MeshExportCoords }
    faExportCoordsNative: result := 'faExportCoordsNative';
    faExportCoordsBlender: result := 'faExportCoordsBlender';
    faExportCoords3DV: result := 'faExportCoords3DV';
    faExportCoords3DP: result := 'faExportCoords3DP';

    { MeshOptions }
    faTextureJitt: result := 'faTextureJitt';
    faTextureJack: result := 'faTextureJack';

    { ExporterOBJ }
    faWantAutoFolder: result := 'faWantAutoFolder';
    faExportMtl: result := 'faExportMtl';
    faExportObj: result := 'faExportObj';
    faWantMaterial: result := 'faWantMaterial';
    faWantSimpleName: result := 'faWantSimpleName';
    faWantAngularDir: result := 'faWantAngularDir';
    faWantNormals: result := 'faWantNormals';
    faWantUVs: result := 'faWantUVs';
    faObjDigits2: result := 'faObjDigits2';
    faObjDigits3: result := 'faObjDigits3';
    faObjDigits4: result := 'faObjDigits4';
    faObjDigits5: result := 'faObjDigits5';

    { MeshFigures }
    faToggleMarker: result := 'faToggleMarker';
    faToggleGrid: result := 'faToggleGrid';
    faToggleGridFrequency: result := 'faToggleGridFrequency';
    faToggleDiameter3: result := 'faToggleDiameter3';
    faDiameter3On: result := 'faDiameter3On';
    faDiameter3Off: result := 'faDiameter3Off';
    faToggleCylinder: result := 'faToggleCylinder';
    faToggleCube: result := 'faToggleCube';
    faToggleCorner: result := 'faToggleCorner';
    faToggleLimitPlane: result := 'faToggleLimitPlane';

    { VertexPulling }
    faToggleZeroPulling: result := 'faToggleZeroPulling';
    faToggleLimitPulling: result := 'faToggleLimitPulling';
    faToggleSlicePulling: result := 'faToggleSlicePulling';
    faToggleTargetPulling: result := 'faToggleTargetPulling';
    faToggleRightPulling: result := 'faToggleRightPulling';
    faToggleCrackFixing: result := 'faToggleCrackFixing';

    { MeshBuilderOptions }
    faToggleSolidFlip: result := 'faToggleSolidFlip';
    faWantSpecialY: result := 'faWantSpecialY';
    faToggleShowEdges: result := 'faToggleShowEdges';
    faUniqueMode1: result := 'faUniqueMode1';
    faUniqueMode2: result := 'faUniqueMode2';
    faToggleUniqueVertices: result := 'faToggleUniqueVertices';

    { Pin }
    faTogglePin: result := 'faTogglePin';
    faPinOn: result := 'faPinOn';
    faPinOff: result := 'faPinOff';

    { Norm }
    faToggleNorm: result := 'faToggleNorm';
    faNormOn: result := 'faNormOn';
    faNormOff: result := 'faNormOff';

    { TextureNorm }
    faTextureNormP: result := 'faTextureNormP';
    faTextureNormM: result := 'faTextureNormM';
    faTextureNorm0: result := 'faTextureNorm0';
    faTextureNorm1: result := 'faTextureNorm1';
    faTextureNorm2: result := 'faTextureNorm2';

    { TextureExport }
    faCopyBinCode: result := 'faCopyBinCode';
    faCopyBinCodeTest: result := 'faCopyBinCodeTest';

    { TextureImport }
    faTextureClear: result := 'faTextureClear';

    { ColorMix }
    faColorMix0: result := 'faColorMix0';
    faColorMix1: result := 'faColorMix1';
    faColorMix2: result := 'faColorMix2';
    faColorMix3: result := 'faColorMix3';
    faColorMix4: result := 'faColorMix4';
    faColorMix5: result := 'faColorMix5';
    faColorMixP: result := 'faColorMixP';
    faColorMixM: result := 'faColorMixM';

    { ColorSwat }
    faToggleColorSwat: result := 'faToggleColorSwat';

    { Lux }
    faLux1On: result := 'faLux1On';
    faLux1Off: result := 'faLux1Off';
    faToggleLux1: result := 'faToggleLux1';
    faLux2On: result := 'faLux2On';
    faLux2Off: result := 'faLux2Off';
    faToggleLux2: result := 'faToggleLux2';
    faLux3On: result := 'faLux3On';
    faLux3Off: result := 'faLux3Off';
    faToggleLux3: result := 'faToggleLux3';
    faLux4On: result := 'faLux4On';
    faLux4Off: result := 'faLux4Off';
    faToggleLux4: result := 'faToggleLux4';
    faLuxOn: result := 'faLuxOn';
    faLuxOff: result := 'faLuxOff';
    faToggleLux: result := 'faToggleLux';

    { LuxMarker }
    faLuxMarkerOn: result := 'faLuxMarkerOn';
    faLuxMarkerOff: result := 'faLuxMarkerOff';
    faToggleLuxMarker: result := 'faToggleLuxMarker';

    { LightMode }
    faLightMode0: result := 'faLightMode0';
    faLightMode1: result := 'faLightMode1';
    faLightMode2: result := 'faLightMode2';
    faLightMode3: result := 'faLightMode3';
    faLightMode4: result := 'faLightMode4';

    { ResetLight }
    faResetLightPosition: result := 'faResetLightPosition';
    faResetLightParams: result := 'faResetLightParams';

    { Wheel }
    faParamValuePlus1: result := 'faParamValuePlus1';
    faParamValueMinus1: result := 'faParamValueMinus1';
    faParamValuePlus10: result := 'faParamValuePlus10';
    faParamValueMinus10: result := 'faParamValueMinus10';
    faWheelLeft: result := 'faWheelLeft';
    faWheelRight: result := 'faWheelRight';
    faWheelDown: result := 'faWheelDown';
    faWheelUp: result := 'faWheelUp';

    { WheelFrequency }
    faWheelFrequency1: result := 'faWheelFrequency1';
    faWheelFrequency05: result := 'faWheelFrequency05';
    faWheelFrequency02: result := 'faWheelFrequency02';
    faWheelFrequency01: result := 'faWheelFrequency01';
    faWheelFrequency001: result := 'faWheelFrequency001';
    faWheelFrequency0001: result := 'faWheelFrequency0001';

    { ColorScheme }
    faCycleColorSchemeM: result := 'faCycleColorSchemeM';
    faCycleColorSchemeP: result := 'faCycleColorSchemeP';

    { Step }
    faStepRXM: result := 'faStepRXM';
    faStepRXP: result := 'faStepRXP';
    faStepRYM: result := 'faStepRYM';
    faStepRYP: result := 'faStepRYP';
    faStepRZM: result := 'faStepRZM';
    faStepRZP: result := 'faStepRZP';
    faStepCZM: result := 'faStepCZM';
    faStepCZP: result := 'faStepCZP';

    { UI }
    faToggleColorPanel: result := 'faToggleColorPanel';
    faColorPanelOn: result := 'faColorPanelOn';
    faColorPanelOff: result := 'faColorPanelOff';
    faPaletteOn: result := 'faPaletteOn';
    faPaletteOff: result := 'faPaletteOff';

    { Locks }
    faToggleLuxLock: result := 'faToggleLuxLock';
    faToggleParamLock: result := 'faToggleParamLock';
    faToggleTextureLock: result := 'faToggleTextureLock';
    faToggleBackgroundLock: result := 'faToggleBackgroundLock';
    faToggleForceLock: result := 'faToggleForceLock';
    faToggleReportLock: result := 'faToggleReportLock';

    { Opacity }
    faToggleOpacity: result := 'faToggleOpacity';
    faOpacityOn: result := 'faOpacityOn';
    faOpacityOff: result := 'faOpacityOff';

    { FederText }
    faToggleAllText: result := 'faToggleAllText';
    faToggleTouchFrame: result := 'faToggleTouchFrame';

    { ViewParams }
    faPan: result := 'faPan';
    faParamRX: result := 'faParamRX';
    faParamRY: result := 'faParamRY';
    faParamRZ: result := 'faParamRZ';
    faParamCZ: result := 'faParamCZ';

    { ViewParamsFC }
    faParamTRS: result := 'faParamTRS';
    faParamTRT: result := 'faParamTRT';
    faParamTRX: result := 'faParamTRX';
    faParamTRY: result := 'faParamTRY';

    { ParamT }
    faParamT1: result := 'faParamT1';
    faParamT2: result := 'faParamT2';
    faParamT3: result := 'faParamT3';
    faParamT4: result := 'faParamT4';

    { ViewFlags }
    faToggleBMap: result := 'faToggleBMap';
    faToggleZoom: result := 'faToggleZoom';
    faToggleTouchMenu: result := 'faToggleTouchMenu';
    faToggleEquationText: result := 'faToggleEquationText';
    faTogglePrimeText: result := 'faTogglePrimeText';
    faToggleSecondText: result := 'faToggleSecondText';
    faToggleLabelText: result := 'faToggleLabelText';
    faLabelBatchM: result := 'faLabelBatchM';
    faLabelBatchP: result := 'faLabelBatchP';
    faLabelTextP: result := 'faLabelTextP';
    faLabelTextM: result := 'faLabelTextM';

    { Report }
    faCopyShortCutReport: result := 'faCopyShortCutReport';
    faWriteActionReport: result := 'faWriteActionReport';
    faWriteActionTable: result := 'faWriteActionTable';
    faWriteActionConst: result := 'faWriteActionConst';
    faWriteActionNames: result := 'faWriteActionNames';
    faWriteVersion1: result := 'faWriteVersion1';
    faWriteVersion2: result := 'faWriteVersion2';
    faWriteCode: result := 'faWriteCode';
    faWriteDiff1: result := 'faWriteDiff1';
    faWriteDiffCode: result := 'faWriteDiffCode';
    faWriteDiffBin: result := 'faWriteDiffBin';
    faWriteBandInfo3: result := 'faWriteBandInfo3';
    faWriteBandInfo5: result := 'faWriteBandInfo5';
    faWriteEquationInfo: result := 'faWriteEquationInfo';
    faWriteVirtual: result := 'faWriteVirtual';
    faBlockTest: result := 'faBlockTest';

    { ReportOptions }
    faSourcePascal: result := 'faSourcePascal';
    faSourceMaxima: result := 'faSourceMaxima';
    faSourceMaple: result := 'faSourceMaple';
    faSourceMathematica: result := 'faSourceMathematica';

    { CopyImage }
    faCopyScreenshot: result := 'faCopyScreenshot';
    faCopyBitmap3D: result := 'faCopyBitmap3D';
    faCopyTextureBitmap: result := 'faCopyTextureBitmap';
    faCopyImprintedBitmap: result := 'faCopyImprintedBitmap';
    faCopyImprintedBitmapTest: result := 'faCopyImprintedBitmapTest';

    { CopyOptions }
    faToggleHardCopy: result := 'faToggleHardCopy';
    faHardCopyOn: result := 'faHardCopyOn';
    faHardCopyOff: result := 'faHardCopyOff';
    faTogglePngCopy: result := 'faTogglePngCopy';
    faPngCopyOn: result := 'faPngCopyOn';
    faPngCopyOff: result := 'faPngCopyOff';
    faToggleNoCopy: result := 'faToggleNoCopy';
    faNoCopyOn: result := 'faNoCopyOn';
    faNoCopyOff: result := 'faNoCopyOff';

    { GraphOptions }
    faToggleDiameter: result := 'faToggleDiameter';
    faToggleProbe: result := 'faToggleProbe';

    { Bahn }
    faNorthCap: result := 'faNorthCap';
    faSouthCap: result := 'faSouthCap';
    faEastCap: result := 'faEastCap';
    faWestCap: result := 'faWestCap';
    faParamCapValue: result := 'faParamCapValue';
    faParamBahnRadius: result := 'faParamBahnRadius';
    faParamBahnPositionX: result := 'faParamBahnPositionX';
    faParamBahnPositionY: result := 'faParamBahnPositionY';
    faParamBahnAngle: result := 'faParamBahnAngle';
    faParamBahnCylinderD: result := 'faParamBahnCylinderD';
    faParamBahnCylinderZ: result := 'faParamBahnCylinderZ';

    { ExampleData }
    faExample01: result := 'faExample01';
    faExample02: result := 'faExample02';
    faExample03: result := 'faExample03';
    faExample04: result := 'faExample04';
    faExample05: result := 'faExample05';
    faExample06: result := 'faExample06';
    faExample07: result := 'faExample07';
    faExample08: result := 'faExample08';
    faExample09: result := 'faExample09';

    { Repo }
    faSwapBundle: result := 'faSwapBundle';
    faRepo010: result := 'faRepo010';
    faRepo020: result := 'faRepo020';
    faRepo050: result := 'faRepo050';

    { SampleNavigation }
    faLevelM: result := 'faLevelM';
    faLevelP: result := 'faLevelP';
    faHubM: result := 'faHubM';
    faHubP: result := 'faHubP';
    faSampleM: result := 'faSampleM';
    faSampleP: result := 'faSampleP';
    faGotoSample0: result := 'faGotoSample0';
    faGotoSample1: result := 'faGotoSample1';

    { Help }
    faToggleHelp: result := 'faToggleHelp';
    faToggleReport: result := 'faToggleReport';
    faToggleButtonReport: result := 'faToggleButtonReport';
    faCycleHelpM: result := 'faCycleHelpM';
    faCycleHelpP: result := 'faCycleHelpP';
    faHelpCycle: result := 'faHelpCycle';
    faHelpList: result := 'faHelpList';
    faHelpHome: result := 'faHelpHome';

    { BtnLegendTablet }
    faTL01: result := 'faTL01';
    faTL02: result := 'faTL02';
    faTL03: result := 'faTL03';
    faTL04: result := 'faTL04';
    faTL05: result := 'faTL05';
    faTL06: result := 'faTL06';
    faTR01: result := 'faTR01';
    faTR02: result := 'faTR02';
    faTR03: result := 'faTR03';
    faTR04: result := 'faTR04';
    faTR05: result := 'faTR05';
    faTR06: result := 'faTR06';
    faTR07: result := 'faTR07';
    faTR08: result := 'faTR08';
    faBL01: result := 'faBL01';
    faBL02: result := 'faBL02';
    faBL03: result := 'faBL03';
    faBL04: result := 'faBL04';
    faBL05: result := 'faBL05';
    faBL06: result := 'faBL06';
    faBL07: result := 'faBL07';
    faBL08: result := 'faBL08';
    faBR01: result := 'faBR01';
    faBR02: result := 'faBR02';
    faBR03: result := 'faBR03';
    faBR04: result := 'faBR04';
    faBR05: result := 'faBR05';
    faBR06: result := 'faBR06';

    { BtnLegendPhone }
    faMB01: result := 'faMB01';
    faMB02: result := 'faMB02';
    faMB03: result := 'faMB03';
    faMB04: result := 'faMB04';
    faMB05: result := 'faMB05';
    faMB06: result := 'faMB06';
    faMB07: result := 'faMB07';
    faMB08: result := 'faMB08';

    { TouchBarLegend }
    faTouchBarTop: result := 'faTouchBarTop';
    faTouchBarBottom: result := 'faTouchBarBottom';
    faTouchBarLeft: result := 'faTouchBarLeft';
    faTouchBarRight: result := 'faTouchBarRight';

    { Reset }
    faReset: result := 'faReset';
    faResetPosition: result := 'faResetPosition';
    faResetRotation: result := 'faResetRotation';
    faResetZoom: result := 'faResetZoom';

    { Language }
    faToggleLanguage: result := 'faToggleLanguage';

    { CopyPaste }
    faSave: result := 'faSave';
    faLoad: result := 'faLoad';
    faOpen: result := 'faOpen';
    faCopy: result := 'faCopy';
    faPaste: result := 'faPaste';

    { ViewOptions }
    faToggleMoveMode: result := 'faToggleMoveMode';
    faLinearMove: result := 'faLinearMove';
    faExpoMove: result := 'faExpoMove';
    faToggleOrbitMode: result := 'faToggleOrbitMode';

    { BitmapCycle }
    faCycleBitmapM: result := 'faCycleBitmapM';
    faCycleBitmapP: result := 'faCycleBitmapP';
    faRandom: result := 'faRandom';
    faRandomWhite: result := 'faRandomWhite';
    faRandomBlack: result := 'faRandomBlack';
    faRandomBambu1: result := 'faRandomBambu1';
    faRandomBambu2: result := 'faRandomBambu2';
    faBitmapEscape: result := 'faBitmapEscape';
    faBitmapOne: result := 'faBitmapOne';
    faToggleContour: result := 'faToggleContour';

    { Layout0 }
    faLayout0: result := 'faLayout0';
    faLayout1: result := 'faLayout1';
    faLayout2: result := 'faLayout2';
    faLayout3: result := 'faLayout3';
    faLayout4: result := 'faLayout4';
    faLayout5: result := 'faLayout5';
    faLayout6: result := 'faLayout6';
    faLayout7: result := 'faLayout7';
    faLayout8: result := 'faLayout8';
    faLayout9: result := 'faLayout9';

    { Layout1 }
    faLayout10: result := 'faLayout10';
    faLayout11: result := 'faLayout11';
    faLayout12: result := 'faLayout12';
    faLayout13: result := 'faLayout13';
    faLayout14: result := 'faLayout14';
    faLayout15: result := 'faLayout15';
    faLayout16: result := 'faLayout16';
    faLayout17: result := 'faLayout17';
    faLayout18: result := 'faLayout18';
    faLayout19: result := 'faLayout19';

    { Layout2 }
    faLayout20: result := 'faLayout20';
    faLayout21: result := 'faLayout21';
    faLayout22: result := 'faLayout22';
    faLayout23: result := 'faLayout23';
    faLayout24: result := 'faLayout24';
    faLayout25: result := 'faLayout25';
    faLayout26: result := 'faLayout26';
    faLayout27: result := 'faLayout27';
    faLayout28: result := 'faLayout28';
    faLayout29: result := 'faLayout29';

    { Layout3 }
    faLayout30: result := 'faLayout30';
    faLayout31: result := 'faLayout31';
    faLayout32: result := 'faLayout32';
    faLayout33: result := 'faLayout33';
    faLayout34: result := 'faLayout34';
    faLayout35: result := 'faLayout35';
    faLayout36: result := 'faLayout36';
    faLayout37: result := 'faLayout37';
    faLayout38: result := 'faLayout38';
    faLayout39: result := 'faLayout39';

    { Layout4 }
    faLayout40: result := 'faLayout40';
    faLayout41: result := 'faLayout41';
    faLayout42: result := 'faLayout42';
    faLayout43: result := 'faLayout43';
    faLayout44: result := 'faLayout44';
    faLayout45: result := 'faLayout45';
    faLayout46: result := 'faLayout46';
    faLayout47: result := 'faLayout47';
    faLayout48: result := 'faLayout48';
    faLayout49: result := 'faLayout49';

    { Layout5 }
    faLayout50: result := 'faLayout50';
    faLayout51: result := 'faLayout51';
    faLayout52: result := 'faLayout52';
    faLayout53: result := 'faLayout53';
    faLayout54: result := 'faLayout54';
    faLayout55: result := 'faLayout55';
    faLayout56: result := 'faLayout56';
    faLayout57: result := 'faLayout57';
    faLayout58: result := 'faLayout58';
    faLayout59: result := 'faLayout59';

    { Layout6 }
    faLayout60: result := 'faLayout60';
    faLayout61: result := 'faLayout61';
    faLayout62: result := 'faLayout62';
    faLayout63: result := 'faLayout63';
    faLayout64: result := 'faLayout64';
    faLayout65: result := 'faLayout65';
    faLayout66: result := 'faLayout66';
    faLayout67: result := 'faLayout67';
    faLayout68: result := 'faLayout68';
    faLayout69: result := 'faLayout69';

    { Layout7 }
    faLayout70: result := 'faLayout70';
    faLayout71: result := 'faLayout71';
    faLayout72: result := 'faLayout72';
    faLayout73: result := 'faLayout73';
    faLayout74: result := 'faLayout74';
    faLayout75: result := 'faLayout75';
    faLayout76: result := 'faLayout76';
    faLayout77: result := 'faLayout77';
    faLayout78: result := 'faLayout78';
    faLayout79: result := 'faLayout79';

    { Layout8 }
    faLayout80: result := 'faLayout80';
    faLayout81: result := 'faLayout81';
    faLayout82: result := 'faLayout82';
    faLayout83: result := 'faLayout83';
    faLayout84: result := 'faLayout84';
    faLayout85: result := 'faLayout85';
    faLayout86: result := 'faLayout86';
    faLayout87: result := 'faLayout87';
    faLayout88: result := 'faLayout88';
    faLayout89: result := 'faLayout89';

    { Layout9 }
    faLayout90: result := 'faLayout90';
    faLayout91: result := 'faLayout91';
    faLayout92: result := 'faLayout92';
    faLayout93: result := 'faLayout93';
    faLayout94: result := 'faLayout94';
    faLayout95: result := 'faLayout95';
    faLayout96: result := 'faLayout96';
    faLayout97: result := 'faLayout97';
    faLayout98: result := 'faLayout98';
    faLayout99: result := 'faLayout99';

    { MenuNav }
    faMenuXX: result := 'faMenuXX';
    faMenu00: result := 'faMenu00';
    faMenu10: result := 'faMenu10';
    faMenu20: result := 'faMenu20';
    faMenu30: result := 'faMenu30';
    faMenu40: result := 'faMenu40';
    faMenu50: result := 'faMenu50';
    faMenu60: result := 'faMenu60';
    faMenu70: result := 'faMenu70';
    faMenu80: result := 'faMenu80';
    faMenu90: result := 'faMenu90';

    { FigureSize }
    faFigureSizeXS: result := 'faFigureSizeXS';
    faFigureSizeS: result := 'faFigureSizeS';
    faFigureSizeM: result := 'faFigureSizeM';
    faFigureSizeL: result := 'faFigureSizeL';
    faFigureSizeXL: result := 'faFigureSizeXL';

    { EyeSize }
    faEyeSizeS: result := 'faEyeSizeS';
    faEyeSizeM: result := 'faEyeSizeM';
    faEyeSizeL: result := 'faEyeSizeL';

    { LayerSelection }
    faSelectLayer1: result := 'faSelectLayer1';
    faSelectLayer2: result := 'faSelectLayer2';
    faSelectLayer3: result := 'faSelectLayer3';
    faSelectLayer4: result := 'faSelectLayer4';
    faSelectLayer5: result := 'faSelectLayer5';
    faSelectLayer6: result := 'faSelectLayer6';
    faSelectLayer7: result := 'faSelectLayer7';

    { ColorSelection }
    faSelectColor1: result := 'faSelectColor1';
    faSelectColor2: result := 'faSelectColor2';
    faSelectColor3: result := 'faSelectColor3';
    faSelectColor4: result := 'faSelectColor4';

    { ColorMapping }
    faCLA: result := 'faCLA';
    faMapColorToLayer: result := 'faMapColorToLayer';
    faSelectColorMapping1: result := 'faSelectColorMapping1';
    faSelectColorMapping2: result := 'faSelectColorMapping2';
    faSelectColorMapping3: result := 'faSelectColorMapping3';
    faSelectColorMapping4: result := 'faSelectColorMapping4';
    faSelectColorMapping5: result := 'faSelectColorMapping5';
    faSelectColorMapping6: result := 'faSelectColorMapping6';
  end;
end;

end.
