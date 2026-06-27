unit RiggVar.FB.ActionDecode;

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
  RiggVar.FB.ActionConst;

function GetFederActionDecodedValue(fag: TFederAction): Integer;

implementation

uses
  RiggVar.FB.ActionDef;

function GetFederActionDecodedValue(fag: TFederAction): Integer;
begin
  result := -1;
  case fag of
    // --- generated code snippet ---

    { EmptyAction }
    fagNoop: result := faNoop;

    { Pages }
    fagActionPageM: result := faActionPageM;
    fagActionPageP: result := faActionPageP;
    fagActionPageE: result := faActionPageE;
    fagActionPageS: result := faActionPageS;
    fagActionPageX: result := faActionPageX;
    fagActionPage1: result := faActionPage1;
    fagActionPage2: result := faActionPage2;
    fagActionPage3: result := faActionPage3;
    fagActionPage4: result := faActionPage4;
    fagActionPage5: result := faActionPage5;
    fagActionPage6: result := faActionPage6;

    { Forms }
    fagShowImage: result := faShowImage;
    fagShowMemo: result := faShowMemo;
    fagShowActions: result := faShowActions;
    fagShowColor: result := faShowColor;
    fagShowBambu: result := faShowBambu;
    fagShowAnim: result := faShowAnim;
    fagEditText: result := faEditText;
    fagEditConn: result := faEditConn;
    fagEditHost: result := faEditHost;
    fagEditPort: result := faEditPort;
    fagShowRepo: result := faShowRepo;
    fagShowInfo: result := faShowInfo;

    { TouchLayout }
    fagTouchTablet: result := faTouchTablet;
    fagTouchPhone: result := faTouchPhone;
    fagTouchDesk: result := faTouchDesk;

    { ActionMapping }
    fagProcessAll: result := faProcessAll;

    { Scene }
    fagScene1: result := faScene1;
    fagScene2: result := faScene2;
    fagScene3: result := faScene3;
    fagScene4: result := faScene4;
    fagScene5: result := faScene5;

    { Plot }
    fagPlot0: result := faPlot0;
    fagPlot1: result := faPlot1;
    fagPlot2: result := faPlot2;
    fagPlot3: result := faPlot3;
    fagPlot4: result := faPlot4;
    fagPlot5: result := faPlot5;
    fagPlot6: result := faPlot6;
    fagPlot7: result := faPlot7;
    fagPlot8: result := faPlot8;
    fagPlot9: result := faPlot9;
    fagPlot10: result := faPlot10;
    fagPlot11: result := faPlot11;
    fagPlot12: result := faPlot12;
    fagPlot13: result := faPlot13;

    { Figure }
    fagFigure1: result := faFigure1;
    fagFigure2: result := faFigure2;
    fagFigure3: result := faFigure3;
    fagFigure4: result := faFigure4;
    fagFigure5: result := faFigure5;
    fagFigure6: result := faFigure6;

    { Graph }
    fagGraph1: result := faGraph1;
    fagGraph2: result := faGraph2;
    fagGraph3: result := faGraph3;
    fagGraph4: result := faGraph4;
    fagGraph5: result := faGraph5;

    { Color }
    fagColor0: result := faColor0;
    fagColor1: result := faColor1;
    fagColor2: result := faColor2;
    fagColor3: result := faColor3;
    fagColor4: result := faColor4;
    fagColor5: result := faColor5;
    fagColor6: result := faColor6;

    { Param }
    fagParam0: result := faParam0;
    fagParam1: result := faParam1;
    fagParam2: result := faParam2;
    fagParam3: result := faParam3;
    fagParam4: result := faParam4;
    fagParam5: result := faParam5;
    fagParam6: result := faParam6;
    fagParam7: result := faParam7;
    fagParam8: result := faParam8;
    fagParam9: result := faParam9;

    { SystemParam }
    fagParamX1: result := faParamX1;
    fagParamY1: result := faParamY1;
    fagParamZ1: result := faParamZ1;
    fagParamL1: result := faParamL1;
    fagParamK1: result := faParamK1;
    fagParamX2: result := faParamX2;
    fagParamY2: result := faParamY2;
    fagParamZ2: result := faParamZ2;
    fagParamL2: result := faParamL2;
    fagParamK2: result := faParamK2;
    fagParamX3: result := faParamX3;
    fagParamY3: result := faParamY3;
    fagParamZ3: result := faParamZ3;
    fagParamL3: result := faParamL3;
    fagParamK3: result := faParamK3;
    fagParamX4: result := faParamX4;
    fagParamY4: result := faParamY4;
    fagParamZ4: result := faParamZ4;
    fagParamL4: result := faParamL4;
    fagParamK4: result := faParamK4;

    { OffsetParam }
    fagOffsetX: result := faOffsetX;
    fagOffsetY: result := faOffsetY;
    fagOffsetZ: result := faOffsetZ;

    { CoordParam }
    fagCoord0: result := faCoord0;
    fagCoord1: result := faCoord1;
    fagCoord2: result := faCoord2;
    fagCoord3: result := faCoord3;

    { LuxParam }
    fagParamL1X: result := faParamL1X;
    fagParamL1Y: result := faParamL1Y;
    fagParamL1Z: result := faParamL1Z;
    fagParamL2X: result := faParamL2X;
    fagParamL2Y: result := faParamL2Y;
    fagParamL2Z: result := faParamL2Z;
    fagParamL3X: result := faParamL3X;
    fagParamL3Y: result := faParamL3Y;
    fagParamL3Z: result := faParamL3Z;
    fagParamL4X: result := faParamL4X;
    fagParamL4Y: result := faParamL4Y;
    fagParamL4Z: result := faParamL4Z;

    { ParamCycle }
    fagCycleX: result := faCycleX;
    fagCycleY: result := faCycleY;
    fagCycleZ: result := faCycleZ;
    fagCycleL: result := faCycleL;
    fagCycleK: result := faCycleK;
    fagCycleO: result := faCycleO;
    fagCycleR: result := faCycleR;
    fagCycleT: result := faCycleT;
    fagCycleU: result := faCycleU;

    { ModelParams }
    fagParamR: result := faParamR;
    fagParamT: result := faParamT;
    fagParamL: result := faParamL;
    fagParamK: result := faParamK;
    fagParamZ: result := faParamZ;
    fagParamA: result := faParamA;
    fagParamG: result := faParamG;
    fagParamX12: result := faParamX12;
    fagParamY12: result := faParamY12;
    fagParamZ12: result := faParamZ12;
    fagParamY3F: result := faParamY3F;
    fagParamL3F: result := faParamL3F;
    fagParamLF: result := faParamLF;

    { ModelOptions }
    fagToggleSolutionMode: result := faToggleSolutionMode;
    fagToggleVorzeichen: result := faToggleVorzeichen;
    fagToggleLinearForce: result := faToggleLinearForce;
    fagToggleGleich: result := faToggleGleich;
    fagToggleMCap: result := faToggleMCap;
    fagTogglePCap: result := faTogglePCap;
    fagForceZ0: result := faForceZ0;
    fagWantZ12: result := faWantZ12;
    fagDiff0: result := faDiff0;
    fagDiff1: result := faDiff1;
    fagDiff10: result := faDiff10;

    { OptionCycle }
    fagCyclePlotM: result := faCyclePlotM;
    fagCyclePlotP: result := faCyclePlotP;
    fagCycleGraphM: result := faCycleGraphM;
    fagCycleGraphP: result := faCycleGraphP;
    fagCycleFigureM: result := faCycleFigureM;
    fagCycleFigureP: result := faCycleFigureP;

    { ForceMode }
    fagForceMode0: result := faForceMode0;
    fagForceMode1: result := faForceMode1;
    fagForceMode2: result := faForceMode2;

    { FederMode }
    fagM1: result := faM1;
    fagM2: result := faM2;
    fagM3: result := faM3;

    { RingActions }
    fagBlindRingP: result := faBlindRingP;
    fagBlindRingM: result := faBlindRingM;
    fagCycleRingP: result := faCycleRingP;
    fagCycleRingM: result := faCycleRingM;
    fagToggleShirtColor: result := faToggleShirtColor;
    fagShirtColorOn: result := faShirtColorOn;
    fagShirtColorOff: result := faShirtColorOff;
    fagApplyRingColor: result := faApplyRingColor;
    fagToggleShirtFarbe: result := faToggleShirtFarbe;
    fagShirtFarbeOn: result := faShirtFarbeOn;
    fagShirtFarbeOff: result := faShirtFarbeOff;
    fagPixelCount1: result := faPixelCount1;
    fagPixelCount2: result := faPixelCount2;
    fagPixelCount4: result := faPixelCount4;

    { ParamBand }
    fagParamBandSelected: result := faParamBandSelected;
    fagParamBandCount: result := faParamBandCount;
    fagParamBandDistributionX: result := faParamBandDistributionX;
    fagParamBandDistributionY: result := faParamBandDistributionY;
    fagParamBandWidth: result := faParamBandWidth;
    fagBandWidthAbsolute: result := faBandWidthAbsolute;
    fagBandWidthRelative: result := faBandWidthRelative;
    fagBandWidthContour: result := faBandWidthContour;

    { BlindRingSelection }
    fagBlindRing1: result := faBlindRing1;
    fagBlindRing5: result := faBlindRing5;
    fagBlindRingA: result := faBlindRingA;
    fagBlindRingB: result := faBlindRingB;
    fagBlindRingC: result := faBlindRingC;
    fagBlindRingD: result := faBlindRingD;
    fagBlindRingE: result := faBlindRingE;
    fagBlindRingF: result := faBlindRingF;

    { CurrentBand }
    fagShowCurrentBand0: result := faShowCurrentBand0;
    fagShowCurrentBand1: result := faShowCurrentBand1;
    fagShowCurrentBandT: result := faShowCurrentBandT;

    { BandSelection }
    fagBandSelectionM: result := faBandSelectionM;
    fagBandSelectionP: result := faBandSelectionP;
    fagBandSelection16: result := faBandSelection16;
    fagBandSelection17: result := faBandSelection17;
    fagBandSelection18: result := faBandSelection18;
    fagBandSelection19: result := faBandSelection19;
    fagBandSelection20: result := faBandSelection20;
    fagBandSelection21: result := faBandSelection21;

    { MeshMode }
    fagOpenMesh: result := faOpenMesh;
    fagPolarMesh: result := faPolarMesh;
    fagReducedMesh: result := faReducedMesh;
    fagReduceMode0: result := faReduceMode0;
    fagReduceMode1: result := faReduceMode1;
    fagReduceMode2: result := faReduceMode2;
    fagReduceMode3: result := faReduceMode3;

    { MeshSize }
    fagMeshSize4: result := faMeshSize4;
    fagMeshSize8: result := faMeshSize8;
    fagMeshSize16: result := faMeshSize16;
    fagMeshSize32: result := faMeshSize32;
    fagMeshSize64: result := faMeshSize64;
    fagMeshSize128: result := faMeshSize128;
    fagMeshSize256: result := faMeshSize256;
    fagMeshSize316: result := faMeshSize316;
    fagMeshSize512: result := faMeshSize512;
    fagMeshSize1024: result := faMeshSize1024;

    { MeshExport }
    fagWantBottom: result := faWantBottom;
    fagWantBottomMirrored: result := faWantBottomMirrored;
    fagWantSideCaps: result := faWantSideCaps;
    fagTestSingleSide: result := faTestSingleSide;
    fagTakeCapValueSnapshot: result := faTakeCapValueSnapshot;

    { MeshExportCoords }
    fagExportCoordsNative: result := faExportCoordsNative;
    fagExportCoordsBlender: result := faExportCoordsBlender;
    fagExportCoords3DV: result := faExportCoords3DV;
    fagExportCoords3DP: result := faExportCoords3DP;

    { MeshOptions }
    fagTextureJitt: result := faTextureJitt;
    fagTextureJack: result := faTextureJack;

    { ExporterOBJ }
    fagWantAutoFolder: result := faWantAutoFolder;
    fagExportMtl: result := faExportMtl;
    fagExportObj: result := faExportObj;
    fagWantMaterial: result := faWantMaterial;
    fagWantSimpleName: result := faWantSimpleName;
    fagWantAngularDir: result := faWantAngularDir;
    fagWantNormals: result := faWantNormals;
    fagWantUVs: result := faWantUVs;
    fagObjDigits2: result := faObjDigits2;
    fagObjDigits3: result := faObjDigits3;
    fagObjDigits4: result := faObjDigits4;
    fagObjDigits5: result := faObjDigits5;

    { MeshFigures }
    fagToggleMarker: result := faToggleMarker;
    fagToggleGrid: result := faToggleGrid;
    fagToggleGridFrequency: result := faToggleGridFrequency;
    fagToggleDiameter3: result := faToggleDiameter3;
    fagDiameter3On: result := faDiameter3On;
    fagDiameter3Off: result := faDiameter3Off;
    fagToggleCylinder: result := faToggleCylinder;
    fagToggleCube: result := faToggleCube;
    fagToggleCorner: result := faToggleCorner;
    fagToggleLimitPlane: result := faToggleLimitPlane;

    { VertexPulling }
    fagToggleZeroPulling: result := faToggleZeroPulling;
    fagToggleLimitPulling: result := faToggleLimitPulling;
    fagToggleSlicePulling: result := faToggleSlicePulling;
    fagToggleTargetPulling: result := faToggleTargetPulling;
    fagToggleRightPulling: result := faToggleRightPulling;
    fagToggleCrackFixing: result := faToggleCrackFixing;

    { MeshBuilderOptions }
    fagToggleSolidFlip: result := faToggleSolidFlip;
    fagWantSpecialY: result := faWantSpecialY;
    fagToggleShowEdges: result := faToggleShowEdges;
    fagUniqueMode1: result := faUniqueMode1;
    fagUniqueMode2: result := faUniqueMode2;
    fagToggleUniqueVertices: result := faToggleUniqueVertices;

    { Pin }
    fagTogglePin: result := faTogglePin;
    fagPinOn: result := faPinOn;
    fagPinOff: result := faPinOff;

    { Norm }
    fagToggleNorm: result := faToggleNorm;
    fagNormOn: result := faNormOn;
    fagNormOff: result := faNormOff;

    { TextureNorm }
    fagTextureNormP: result := faTextureNormP;
    fagTextureNormM: result := faTextureNormM;
    fagTextureNorm0: result := faTextureNorm0;
    fagTextureNorm1: result := faTextureNorm1;
    fagTextureNorm2: result := faTextureNorm2;

    { TextureExport }
    fagCopyBinCode: result := faCopyBinCode;
    fagCopyBinCodeTest: result := faCopyBinCodeTest;

    { TextureImport }
    fagTextureClear: result := faTextureClear;

    { ColorMix }
    fagColorMix0: result := faColorMix0;
    fagColorMix1: result := faColorMix1;
    fagColorMix2: result := faColorMix2;
    fagColorMix3: result := faColorMix3;
    fagColorMix4: result := faColorMix4;
    fagColorMix5: result := faColorMix5;
    fagColorMixP: result := faColorMixP;
    fagColorMixM: result := faColorMixM;

    { ColorSwat }
    fagToggleColorSwat: result := faToggleColorSwat;

    { Lux }
    fagLux1On: result := faLux1On;
    fagLux1Off: result := faLux1Off;
    fagToggleLux1: result := faToggleLux1;
    fagLux2On: result := faLux2On;
    fagLux2Off: result := faLux2Off;
    fagToggleLux2: result := faToggleLux2;
    fagLux3On: result := faLux3On;
    fagLux3Off: result := faLux3Off;
    fagToggleLux3: result := faToggleLux3;
    fagLux4On: result := faLux4On;
    fagLux4Off: result := faLux4Off;
    fagToggleLux4: result := faToggleLux4;
    fagLuxOn: result := faLuxOn;
    fagLuxOff: result := faLuxOff;
    fagToggleLux: result := faToggleLux;

    { LuxMarker }
    fagLuxMarkerOn: result := faLuxMarkerOn;
    fagLuxMarkerOff: result := faLuxMarkerOff;
    fagToggleLuxMarker: result := faToggleLuxMarker;

    { LightMode }
    fagLightMode0: result := faLightMode0;
    fagLightMode1: result := faLightMode1;
    fagLightMode2: result := faLightMode2;
    fagLightMode3: result := faLightMode3;
    fagLightMode4: result := faLightMode4;

    { ResetLight }
    fagResetLightPosition: result := faResetLightPosition;
    fagResetLightParams: result := faResetLightParams;

    { Wheel }
    fagParamValuePlus1: result := faParamValuePlus1;
    fagParamValueMinus1: result := faParamValueMinus1;
    fagParamValuePlus10: result := faParamValuePlus10;
    fagParamValueMinus10: result := faParamValueMinus10;
    fagWheelLeft: result := faWheelLeft;
    fagWheelRight: result := faWheelRight;
    fagWheelDown: result := faWheelDown;
    fagWheelUp: result := faWheelUp;

    { WheelFrequency }
    fagWheelFrequency1: result := faWheelFrequency1;
    fagWheelFrequency05: result := faWheelFrequency05;
    fagWheelFrequency02: result := faWheelFrequency02;
    fagWheelFrequency01: result := faWheelFrequency01;
    fagWheelFrequency001: result := faWheelFrequency001;
    fagWheelFrequency0001: result := faWheelFrequency0001;

    { ColorScheme }
    fagCycleColorSchemeM: result := faCycleColorSchemeM;
    fagCycleColorSchemeP: result := faCycleColorSchemeP;

    { AnimatedRotations }
    fagRotX: result := faRotX;
    fagRotY: result := faRotY;
    fagRotZ: result := faRotZ;
    fagRotXM: result := faRotXM;
    fagRotXP: result := faRotXP;
    fagRotYM: result := faRotYM;
    fagRotYP: result := faRotYP;
    fagRotZM: result := faRotZM;
    fagRotZP: result := faRotZP;

    { Step }
    fagStepRXM: result := faStepRXM;
    fagStepRXP: result := faStepRXP;
    fagStepRYM: result := faStepRYM;
    fagStepRYP: result := faStepRYP;
    fagStepRZM: result := faStepRZM;
    fagStepRZP: result := faStepRZP;
    fagStepCZM: result := faStepCZM;
    fagStepCZP: result := faStepCZP;

    { UI }
    fagParamLabelTextX: result := faParamLabelTextX;
    fagParamLabelTextY: result := faParamLabelTextY;
    fagParamLabelTextZ: result := faParamLabelTextZ;
    fagToggleColorPanel: result := faToggleColorPanel;
    fagColorPanelOn: result := faColorPanelOn;
    fagColorPanelOff: result := faColorPanelOff;
    fagShowEditField: result := faShowEditField;
    fagFocusEditField: result := faFocusEditField;
    fagInitSpecial: result := faInitSpecial;
    fagPaletteOn: result := faPaletteOn;
    fagPaletteOff: result := faPaletteOff;

    { Locks }
    fagToggleLuxLock: result := faToggleLuxLock;
    fagToggleParamLock: result := faToggleParamLock;
    fagToggleTextureLock: result := faToggleTextureLock;
    fagToggleBackgroundLock: result := faToggleBackgroundLock;
    fagToggleForceLock: result := faToggleForceLock;
    fagToggleReportLock: result := faToggleReportLock;

    { Opacity }
    fagToggleOpacity: result := faToggleOpacity;
    fagOpacityOn: result := faOpacityOn;
    fagOpacityOff: result := faOpacityOff;

    { MainMenuActivation }
    fagMainMenuHide: result := faMainMenuHide;
    fagMainMenuShow: result := faMainMenuShow;

    { FederText }
    fagToggleAllText: result := faToggleAllText;
    fagToggleTouchFrame: result := faToggleTouchFrame;

    { ViewParams }
    fagPan: result := faPan;
    fagParamRX: result := faParamRX;
    fagParamRY: result := faParamRY;
    fagParamRZ: result := faParamRZ;
    fagParamCZ: result := faParamCZ;

    { ViewParamsFC }
    fagRotStep0: result := faRotStep0;
    fagRotStep1: result := faRotStep1;
    fagRotStep2: result := faRotStep2;
    fagRotStep3: result := faRotStep3;
    fagRotStepA: result := faRotStepA;
    fagParamTRS: result := faParamTRS;
    fagParamTRT: result := faParamTRT;
    fagParamTRX: result := faParamTRX;
    fagParamTRY: result := faParamTRY;

    { ParamT }
    fagParamT1: result := faParamT1;
    fagParamT2: result := faParamT2;
    fagParamT3: result := faParamT3;
    fagParamT4: result := faParamT4;

    { ViewFlags }
    fagToggleBMap: result := faToggleBMap;
    fagToggleZoom: result := faToggleZoom;
    fagToggleTouchMenu: result := faToggleTouchMenu;
    fagToggleEquationText: result := faToggleEquationText;
    fagTogglePrimeText: result := faTogglePrimeText;
    fagToggleSecondText: result := faToggleSecondText;
    fagToggleLabelText: result := faToggleLabelText;
    fagLabelBatchM: result := faLabelBatchM;
    fagLabelBatchP: result := faLabelBatchP;
    fagLabelTextP: result := faLabelTextP;
    fagLabelTextM: result := faLabelTextM;

    { Report }
    fagCopyShortCutReport: result := faCopyShortCutReport;
    fagWriteActionReport: result := faWriteActionReport;
    fagWriteActionTable: result := faWriteActionTable;
    fagWriteActionConst: result := faWriteActionConst;
    fagWriteActionNames: result := faWriteActionNames;
    fagWriteVersion1: result := faWriteVersion1;
    fagWriteVersion2: result := faWriteVersion2;
    fagWriteCode: result := faWriteCode;
    fagWriteDiff1: result := faWriteDiff1;
    fagWriteDiffCode: result := faWriteDiffCode;
    fagWriteDiffBin: result := faWriteDiffBin;
    fagWriteBandInfo3: result := faWriteBandInfo3;
    fagWriteBandInfo5: result := faWriteBandInfo5;
    fagWriteEquationInfo: result := faWriteEquationInfo;
    fagWriteVirtual: result := faWriteVirtual;
    fagBlockTest: result := faBlockTest;

    { ReportOptions }
    fagSourcePascal: result := faSourcePascal;
    fagSourceMaxima: result := faSourceMaxima;
    fagSourceMaple: result := faSourceMaple;
    fagSourceMathematica: result := faSourceMathematica;

    { CopyImage }
    fagCopyScreenshot: result := faCopyScreenshot;
    fagCopyBitmap3D: result := faCopyBitmap3D;
    fagCopyTextureBitmap: result := faCopyTextureBitmap;
    fagCopyImprintedBitmap: result := faCopyImprintedBitmap;
    fagCopyImprintedBitmapTest: result := faCopyImprintedBitmapTest;

    { CopyOptions }
    fagToggleHardCopy: result := faToggleHardCopy;
    fagHardCopyOn: result := faHardCopyOn;
    fagHardCopyOff: result := faHardCopyOff;
    fagTogglePngCopy: result := faTogglePngCopy;
    fagPngCopyOn: result := faPngCopyOn;
    fagPngCopyOff: result := faPngCopyOff;
    fagToggleNoCopy: result := faToggleNoCopy;
    fagNoCopyOn: result := faNoCopyOn;
    fagNoCopyOff: result := faNoCopyOff;

    { GraphOptions }
    fagToggleDiameter: result := faToggleDiameter;
    fagToggleProbe: result := faToggleProbe;

    { Bahn }
    fagNorthCap: result := faNorthCap;
    fagSouthCap: result := faSouthCap;
    fagEastCap: result := faEastCap;
    fagWestCap: result := faWestCap;
    fagParamCapValue: result := faParamCapValue;
    fagParamBahnRadius: result := faParamBahnRadius;
    fagParamBahnPositionX: result := faParamBahnPositionX;
    fagParamBahnPositionY: result := faParamBahnPositionY;
    fagParamBahnAngle: result := faParamBahnAngle;
    fagParamBahnCylinderD: result := faParamBahnCylinderD;
    fagParamBahnCylinderZ: result := faParamBahnCylinderZ;

    { AnimationStore }
    fagRecall1: result := faRecall1;
    fagRecall2: result := faRecall2;
    fagMemory1: result := faMemory1;
    fagMemory2: result := faMemory2;
    fagTransit: result := faTransit;

    { AnimPlay }
    fagPlay: result := faPlay;
    fagExecute: result := faExecute;
    fagAnimationStop: result := faAnimationStop;
    fagAnimationStartA: result := faAnimationStartA;
    fagAnimationStartD: result := faAnimationStartD;
    fagAnimationStartF: result := faAnimationStartF;
    fagAnimationStartS: result := faAnimationStartS;
    fagAnimationStartT: result := faAnimationStartT;

    { Transit }
    fagTransitionAll: result := faTransitionAll;
    fagTransitionScript: result := faTransitionScript;

    { Connect }
    fagConnect: result := faConnect;
    fagDisconnect: result := faDisconnect;
    fagDownload: result := faDownload;
    fagAutoSend: result := faAutoSend;
    fagAutoSendOn: result := faAutoSendOn;
    fagAutoSendOff: result := faAutoSendOff;

    { ExampleData }
    fagExample01: result := faExample01;
    fagExample02: result := faExample02;
    fagExample03: result := faExample03;
    fagExample04: result := faExample04;
    fagExample05: result := faExample05;
    fagExample06: result := faExample06;
    fagExample07: result := faExample07;
    fagExample08: result := faExample08;
    fagExample09: result := faExample09;

    { Repo }
    fagSwapBundle: result := faSwapBundle;
    fagRepo010: result := faRepo010;
    fagRepo020: result := faRepo020;
    fagRepo050: result := faRepo050;

    { SampleNavigation }
    fagLevelM: result := faLevelM;
    fagLevelP: result := faLevelP;
    fagHubM: result := faHubM;
    fagHubP: result := faHubP;
    fagSampleM: result := faSampleM;
    fagSampleP: result := faSampleP;
    fagGotoSample0: result := faGotoSample0;
    fagGotoSample1: result := faGotoSample1;

    { DebugOptions }
    fagTestBtnClick: result := faTestBtnClick;
    fagRunBinPixelTest: result := faRunBinPixelTest;

    { EmptyLastLine }
    fagELLOn: result := faELLOn;
    fagELLOff: result := faELLOff;

    { Help }
    fagToggleHelp: result := faToggleHelp;
    fagToggleReport: result := faToggleReport;
    fagToggleButtonReport: result := faToggleButtonReport;
    fagCycleHelpM: result := faCycleHelpM;
    fagCycleHelpP: result := faCycleHelpP;
    fagHelpCycle: result := faHelpCycle;
    fagHelpList: result := faHelpList;
    fagHelpHome: result := faHelpHome;

    { BtnLegendTablet }
    fagTL01: result := faTL01;
    fagTL02: result := faTL02;
    fagTL03: result := faTL03;
    fagTL04: result := faTL04;
    fagTL05: result := faTL05;
    fagTL06: result := faTL06;
    fagTR01: result := faTR01;
    fagTR02: result := faTR02;
    fagTR03: result := faTR03;
    fagTR04: result := faTR04;
    fagTR05: result := faTR05;
    fagTR06: result := faTR06;
    fagTR07: result := faTR07;
    fagTR08: result := faTR08;
    fagBL01: result := faBL01;
    fagBL02: result := faBL02;
    fagBL03: result := faBL03;
    fagBL04: result := faBL04;
    fagBL05: result := faBL05;
    fagBL06: result := faBL06;
    fagBL07: result := faBL07;
    fagBL08: result := faBL08;
    fagBR01: result := faBR01;
    fagBR02: result := faBR02;
    fagBR03: result := faBR03;
    fagBR04: result := faBR04;
    fagBR05: result := faBR05;
    fagBR06: result := faBR06;

    { BtnLegendPhone }
    fagMB01: result := faMB01;
    fagMB02: result := faMB02;
    fagMB03: result := faMB03;
    fagMB04: result := faMB04;
    fagMB05: result := faMB05;
    fagMB06: result := faMB06;
    fagMB07: result := faMB07;
    fagMB08: result := faMB08;

    { TouchBarLegend }
    fagTouchBarTop: result := faTouchBarTop;
    fagTouchBarBottom: result := faTouchBarBottom;
    fagTouchBarLeft: result := faTouchBarLeft;
    fagTouchBarRight: result := faTouchBarRight;

    { Reset }
    fagReset: result := faReset;
    fagResetPosition: result := faResetPosition;
    fagResetRotation: result := faResetRotation;
    fagResetZoom: result := faResetZoom;

    { DropTarget }
    fagToggleDropTarget: result := faToggleDropTarget;

    { Language }
    fagToggleLanguage: result := faToggleLanguage;

    { CopyPaste }
    fagSave: result := faSave;
    fagLoad: result := faLoad;
    fagOpen: result := faOpen;
    fagCopy: result := faCopy;
    fagPaste: result := faPaste;

    { ViewOptions }
    fagToggleMoveMode: result := faToggleMoveMode;
    fagLinearMove: result := faLinearMove;
    fagExpoMove: result := faExpoMove;
    fagToggleQuickMesh: result := faToggleQuickMesh;
    fagToggleOrbitMode: result := faToggleOrbitMode;

    { BitmapCycle }
    fagCycleBitmapM: result := faCycleBitmapM;
    fagCycleBitmapP: result := faCycleBitmapP;
    fagRandom: result := faRandom;
    fagRandomWhite: result := faRandomWhite;
    fagRandomBlack: result := faRandomBlack;
    fagRandomBambu1: result := faRandomBambu1;
    fagRandomBambu2: result := faRandomBambu2;
    fagBitmapEscape: result := faBitmapEscape;
    fagBitmapOne: result := faBitmapOne;
    fagToggleContour: result := faToggleContour;

    { Layout0 }
    fagLayout0: result := faLayout0;
    fagLayout1: result := faLayout1;
    fagLayout2: result := faLayout2;
    fagLayout3: result := faLayout3;
    fagLayout4: result := faLayout4;
    fagLayout5: result := faLayout5;
    fagLayout6: result := faLayout6;
    fagLayout7: result := faLayout7;
    fagLayout8: result := faLayout8;
    fagLayout9: result := faLayout9;

    { Layout1 }
    fagLayout10: result := faLayout10;
    fagLayout11: result := faLayout11;
    fagLayout12: result := faLayout12;
    fagLayout13: result := faLayout13;
    fagLayout14: result := faLayout14;
    fagLayout15: result := faLayout15;
    fagLayout16: result := faLayout16;
    fagLayout17: result := faLayout17;
    fagLayout18: result := faLayout18;
    fagLayout19: result := faLayout19;

    { Layout2 }
    fagLayout20: result := faLayout20;
    fagLayout21: result := faLayout21;
    fagLayout22: result := faLayout22;
    fagLayout23: result := faLayout23;
    fagLayout24: result := faLayout24;
    fagLayout25: result := faLayout25;
    fagLayout26: result := faLayout26;
    fagLayout27: result := faLayout27;
    fagLayout28: result := faLayout28;
    fagLayout29: result := faLayout29;

    { Layout3 }
    fagLayout30: result := faLayout30;
    fagLayout31: result := faLayout31;
    fagLayout32: result := faLayout32;
    fagLayout33: result := faLayout33;
    fagLayout34: result := faLayout34;
    fagLayout35: result := faLayout35;
    fagLayout36: result := faLayout36;
    fagLayout37: result := faLayout37;
    fagLayout38: result := faLayout38;
    fagLayout39: result := faLayout39;

    { Layout4 }
    fagLayout40: result := faLayout40;
    fagLayout41: result := faLayout41;
    fagLayout42: result := faLayout42;
    fagLayout43: result := faLayout43;
    fagLayout44: result := faLayout44;
    fagLayout45: result := faLayout45;
    fagLayout46: result := faLayout46;
    fagLayout47: result := faLayout47;
    fagLayout48: result := faLayout48;
    fagLayout49: result := faLayout49;

    { Layout5 }
    fagLayout50: result := faLayout50;
    fagLayout51: result := faLayout51;
    fagLayout52: result := faLayout52;
    fagLayout53: result := faLayout53;
    fagLayout54: result := faLayout54;
    fagLayout55: result := faLayout55;
    fagLayout56: result := faLayout56;
    fagLayout57: result := faLayout57;
    fagLayout58: result := faLayout58;
    fagLayout59: result := faLayout59;

    { Layout6 }
    fagLayout60: result := faLayout60;
    fagLayout61: result := faLayout61;
    fagLayout62: result := faLayout62;
    fagLayout63: result := faLayout63;
    fagLayout64: result := faLayout64;
    fagLayout65: result := faLayout65;
    fagLayout66: result := faLayout66;
    fagLayout67: result := faLayout67;
    fagLayout68: result := faLayout68;
    fagLayout69: result := faLayout69;

    { Layout7 }
    fagLayout70: result := faLayout70;
    fagLayout71: result := faLayout71;
    fagLayout72: result := faLayout72;
    fagLayout73: result := faLayout73;
    fagLayout74: result := faLayout74;
    fagLayout75: result := faLayout75;
    fagLayout76: result := faLayout76;
    fagLayout77: result := faLayout77;
    fagLayout78: result := faLayout78;
    fagLayout79: result := faLayout79;

    { Layout8 }
    fagLayout80: result := faLayout80;
    fagLayout81: result := faLayout81;
    fagLayout82: result := faLayout82;
    fagLayout83: result := faLayout83;
    fagLayout84: result := faLayout84;
    fagLayout85: result := faLayout85;
    fagLayout86: result := faLayout86;
    fagLayout87: result := faLayout87;
    fagLayout88: result := faLayout88;
    fagLayout89: result := faLayout89;

    { Layout9 }
    fagLayout90: result := faLayout90;
    fagLayout91: result := faLayout91;
    fagLayout92: result := faLayout92;
    fagLayout93: result := faLayout93;
    fagLayout94: result := faLayout94;
    fagLayout95: result := faLayout95;
    fagLayout96: result := faLayout96;
    fagLayout97: result := faLayout97;
    fagLayout98: result := faLayout98;
    fagLayout99: result := faLayout99;

    { MenuNav }
    fagMenuXX: result := faMenuXX;
    fagMenu00: result := faMenu00;
    fagMenu10: result := faMenu10;
    fagMenu20: result := faMenu20;
    fagMenu30: result := faMenu30;
    fagMenu40: result := faMenu40;
    fagMenu50: result := faMenu50;
    fagMenu60: result := faMenu60;
    fagMenu70: result := faMenu70;
    fagMenu80: result := faMenu80;
    fagMenu90: result := faMenu90;

    { FigureSize }
    fagFigureSizeXS: result := faFigureSizeXS;
    fagFigureSizeS: result := faFigureSizeS;
    fagFigureSizeM: result := faFigureSizeM;
    fagFigureSizeL: result := faFigureSizeL;
    fagFigureSizeXL: result := faFigureSizeXL;

    { EyeSize }
    fagEyeSizeS: result := faEyeSizeS;
    fagEyeSizeM: result := faEyeSizeM;
    fagEyeSizeL: result := faEyeSizeL;

    { LayerSelection }
    fagSelectLayer1: result := faSelectLayer1;
    fagSelectLayer2: result := faSelectLayer2;
    fagSelectLayer3: result := faSelectLayer3;
    fagSelectLayer4: result := faSelectLayer4;
    fagSelectLayer5: result := faSelectLayer5;
    fagSelectLayer6: result := faSelectLayer6;
    fagSelectLayer7: result := faSelectLayer7;

    { ColorSelection }
    fagSelectColor1: result := faSelectColor1;
    fagSelectColor2: result := faSelectColor2;
    fagSelectColor3: result := faSelectColor3;
    fagSelectColor4: result := faSelectColor4;

    { ColorMapping }
    fagCLA: result := faCLA;
    fagMapColorToLayer: result := faMapColorToLayer;
    fagSelectColorMapping1: result := faSelectColorMapping1;
    fagSelectColorMapping2: result := faSelectColorMapping2;
    fagSelectColorMapping3: result := faSelectColorMapping3;
    fagSelectColorMapping4: result := faSelectColorMapping4;
    fagSelectColorMapping5: result := faSelectColorMapping5;
    fagSelectColorMapping6: result := faSelectColorMapping6;
  end;
end;

end.
