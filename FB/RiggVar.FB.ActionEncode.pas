unit RiggVar.FB.ActionEncode;

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

function GetFederActionEncodedValue(fa: TFederAction): Integer;

implementation

uses
  RiggVar.FB.ActionDef;

function GetFederActionEncodedValue(fa: TFederAction): Integer;
begin
  result := -1;
  case fa of
    // --- generated code snippet ---

    { EmptyAction }
    faNoop: result := fagNoop;

    { Pages }
    faActionPageM: result := fagActionPageM;
    faActionPageP: result := fagActionPageP;
    faActionPageE: result := fagActionPageE;
    faActionPageS: result := fagActionPageS;
    faActionPageX: result := fagActionPageX;
    faActionPage1: result := fagActionPage1;
    faActionPage2: result := fagActionPage2;
    faActionPage3: result := fagActionPage3;
    faActionPage4: result := fagActionPage4;
    faActionPage5: result := fagActionPage5;
    faActionPage6: result := fagActionPage6;

    { Forms }
    faShowMemo: result := fagShowMemo;
    faShowActions: result := fagShowActions;
    faShowInfo: result := fagShowInfo;

    { TouchLayout }
    faTouchTablet: result := fagTouchTablet;
    faTouchPhone: result := fagTouchPhone;
    faTouchDesk: result := fagTouchDesk;

    { ActionMapping }
    faProcessAll: result := fagProcessAll;

    { Scene }
    faScene1: result := fagScene1;
    faScene2: result := fagScene2;
    faScene3: result := fagScene3;
    faScene4: result := fagScene4;
    faScene5: result := fagScene5;

    { Plot }
    faPlot0: result := fagPlot0;
    faPlot1: result := fagPlot1;
    faPlot2: result := fagPlot2;
    faPlot3: result := fagPlot3;
    faPlot4: result := fagPlot4;
    faPlot5: result := fagPlot5;
    faPlot6: result := fagPlot6;
    faPlot7: result := fagPlot7;
    faPlot8: result := fagPlot8;
    faPlot9: result := fagPlot9;
    faPlot10: result := fagPlot10;
    faPlot11: result := fagPlot11;
    faPlot12: result := fagPlot12;
    faPlot13: result := fagPlot13;

    { Figure }
    faFigure1: result := fagFigure1;
    faFigure2: result := fagFigure2;
    faFigure3: result := fagFigure3;
    faFigure4: result := fagFigure4;
    faFigure5: result := fagFigure5;
    faFigure6: result := fagFigure6;

    { Graph }
    faGraph1: result := fagGraph1;
    faGraph2: result := fagGraph2;
    faGraph3: result := fagGraph3;
    faGraph4: result := fagGraph4;
    faGraph5: result := fagGraph5;

    { Color }
    faColor0: result := fagColor0;
    faColor1: result := fagColor1;
    faColor2: result := fagColor2;
    faColor3: result := fagColor3;
    faColor4: result := fagColor4;
    faColor5: result := fagColor5;
    faColor6: result := fagColor6;

    { Param }
    faParam0: result := fagParam0;
    faParam1: result := fagParam1;
    faParam2: result := fagParam2;
    faParam3: result := fagParam3;
    faParam4: result := fagParam4;
    faParam5: result := fagParam5;
    faParam6: result := fagParam6;
    faParam7: result := fagParam7;
    faParam8: result := fagParam8;
    faParam9: result := fagParam9;

    { SystemParam }
    faParamX1: result := fagParamX1;
    faParamY1: result := fagParamY1;
    faParamZ1: result := fagParamZ1;
    faParamL1: result := fagParamL1;
    faParamK1: result := fagParamK1;
    faParamX2: result := fagParamX2;
    faParamY2: result := fagParamY2;
    faParamZ2: result := fagParamZ2;
    faParamL2: result := fagParamL2;
    faParamK2: result := fagParamK2;
    faParamX3: result := fagParamX3;
    faParamY3: result := fagParamY3;
    faParamZ3: result := fagParamZ3;
    faParamL3: result := fagParamL3;
    faParamK3: result := fagParamK3;
    faParamX4: result := fagParamX4;
    faParamY4: result := fagParamY4;
    faParamZ4: result := fagParamZ4;
    faParamL4: result := fagParamL4;
    faParamK4: result := fagParamK4;

    { OffsetParam }
    faOffsetX: result := fagOffsetX;
    faOffsetY: result := fagOffsetY;
    faOffsetZ: result := fagOffsetZ;

    { CoordParam }
    faCoord0: result := fagCoord0;
    faCoord1: result := fagCoord1;
    faCoord2: result := fagCoord2;
    faCoord3: result := fagCoord3;

    { LuxParam }
    faParamL1X: result := fagParamL1X;
    faParamL1Y: result := fagParamL1Y;
    faParamL1Z: result := fagParamL1Z;
    faParamL2X: result := fagParamL2X;
    faParamL2Y: result := fagParamL2Y;
    faParamL2Z: result := fagParamL2Z;
    faParamL3X: result := fagParamL3X;
    faParamL3Y: result := fagParamL3Y;
    faParamL3Z: result := fagParamL3Z;
    faParamL4X: result := fagParamL4X;
    faParamL4Y: result := fagParamL4Y;
    faParamL4Z: result := fagParamL4Z;

    { ParamCycle }
    faCycleX: result := fagCycleX;
    faCycleY: result := fagCycleY;
    faCycleZ: result := fagCycleZ;
    faCycleL: result := fagCycleL;
    faCycleK: result := fagCycleK;
    faCycleO: result := fagCycleO;
    faCycleR: result := fagCycleR;
    faCycleT: result := fagCycleT;
    faCycleU: result := fagCycleU;

    { ModelParams }
    faParamR: result := fagParamR;
    faParamT: result := fagParamT;
    faParamL: result := fagParamL;
    faParamK: result := fagParamK;
    faParamZ: result := fagParamZ;
    faParamA: result := fagParamA;
    faParamG: result := fagParamG;
    faParamX12: result := fagParamX12;
    faParamY12: result := fagParamY12;
    faParamZ12: result := fagParamZ12;
    faParamY3F: result := fagParamY3F;
    faParamL3F: result := fagParamL3F;
    faParamLF: result := fagParamLF;

    { ModelOptions }
    faToggleSolutionMode: result := fagToggleSolutionMode;
    faToggleVorzeichen: result := fagToggleVorzeichen;
    faToggleLinearForce: result := fagToggleLinearForce;
    faToggleGleich: result := fagToggleGleich;
    faToggleMCap: result := fagToggleMCap;
    faTogglePCap: result := fagTogglePCap;
    faForceZ0: result := fagForceZ0;
    faWantZ12: result := fagWantZ12;
    faDiff0: result := fagDiff0;
    faDiff1: result := fagDiff1;
    faDiff10: result := fagDiff10;

    { OptionCycle }
    faCyclePlotM: result := fagCyclePlotM;
    faCyclePlotP: result := fagCyclePlotP;
    faCycleGraphM: result := fagCycleGraphM;
    faCycleGraphP: result := fagCycleGraphP;
    faCycleFigureM: result := fagCycleFigureM;
    faCycleFigureP: result := fagCycleFigureP;

    { ForceMode }
    faForceMode0: result := fagForceMode0;
    faForceMode1: result := fagForceMode1;
    faForceMode2: result := fagForceMode2;

    { FederMode }
    faM1: result := fagM1;
    faM2: result := fagM2;
    faM3: result := fagM3;

    { RingActions }
    faBlindRingP: result := fagBlindRingP;
    faBlindRingM: result := fagBlindRingM;
    faCycleRingP: result := fagCycleRingP;
    faCycleRingM: result := fagCycleRingM;
    faToggleShirtColor: result := fagToggleShirtColor;
    faShirtColorOn: result := fagShirtColorOn;
    faShirtColorOff: result := fagShirtColorOff;
    faApplyRingColor: result := fagApplyRingColor;
    faToggleShirtFarbe: result := fagToggleShirtFarbe;
    faShirtFarbeOn: result := fagShirtFarbeOn;
    faShirtFarbeOff: result := fagShirtFarbeOff;
    faPixelCount1: result := fagPixelCount1;
    faPixelCount2: result := fagPixelCount2;
    faPixelCount4: result := fagPixelCount4;

    { ParamBand }
    faParamBandSelected: result := fagParamBandSelected;
    faParamBandCount: result := fagParamBandCount;
    faParamBandDistributionX: result := fagParamBandDistributionX;
    faParamBandDistributionY: result := fagParamBandDistributionY;
    faParamBandWidth: result := fagParamBandWidth;
    faBandWidthAbsolute: result := fagBandWidthAbsolute;
    faBandWidthRelative: result := fagBandWidthRelative;
    faBandWidthContour: result := fagBandWidthContour;

    { BlindRingSelection }
    faBlindRing1: result := fagBlindRing1;
    faBlindRing5: result := fagBlindRing5;
    faBlindRingA: result := fagBlindRingA;
    faBlindRingB: result := fagBlindRingB;
    faBlindRingC: result := fagBlindRingC;
    faBlindRingD: result := fagBlindRingD;
    faBlindRingE: result := fagBlindRingE;
    faBlindRingF: result := fagBlindRingF;

    { CurrentBand }
    faShowCurrentBand0: result := fagShowCurrentBand0;
    faShowCurrentBand1: result := fagShowCurrentBand1;
    faShowCurrentBandT: result := fagShowCurrentBandT;

    { BandSelection }
    faBandSelectionM: result := fagBandSelectionM;
    faBandSelectionP: result := fagBandSelectionP;
    faBandSelection16: result := fagBandSelection16;
    faBandSelection17: result := fagBandSelection17;
    faBandSelection18: result := fagBandSelection18;
    faBandSelection19: result := fagBandSelection19;
    faBandSelection20: result := fagBandSelection20;
    faBandSelection21: result := fagBandSelection21;

    { MeshMode }
    faReducedMesh: result := fagReducedMesh;
    faReduceMode0: result := fagReduceMode0;
    faReduceMode1: result := fagReduceMode1;
    faReduceMode2: result := fagReduceMode2;
    faReduceMode3: result := fagReduceMode3;

    { MeshSize }
    faMeshSize4: result := fagMeshSize4;
    faMeshSize8: result := fagMeshSize8;
    faMeshSize16: result := fagMeshSize16;
    faMeshSize32: result := fagMeshSize32;
    faMeshSize64: result := fagMeshSize64;
    faMeshSize128: result := fagMeshSize128;
    faMeshSize256: result := fagMeshSize256;
    faMeshSize316: result := fagMeshSize316;
    faMeshSize512: result := fagMeshSize512;

    { MeshExport }
    faWantBottom: result := fagWantBottom;
    faWantBottomMirrored: result := fagWantBottomMirrored;
    faWantSideCaps: result := fagWantSideCaps;
    faTestSingleSide: result := fagTestSingleSide;
    faTakeCapValueSnapshot: result := fagTakeCapValueSnapshot;

    { MeshExportCoords }
    faExportCoordsNative: result := fagExportCoordsNative;
    faExportCoordsBlender: result := fagExportCoordsBlender;
    faExportCoords3DV: result := fagExportCoords3DV;
    faExportCoords3DP: result := fagExportCoords3DP;

    { ExporterOBJ }
    faWantAutoFolder: result := fagWantAutoFolder;
    faExportMtl: result := fagExportMtl;
    faExportObj: result := fagExportObj;
    faWantMaterial: result := fagWantMaterial;
    faWantSimpleName: result := fagWantSimpleName;
    faWantAngularDir: result := fagWantAngularDir;
    faWantNormals: result := fagWantNormals;
    faWantUVs: result := fagWantUVs;
    faObjDigits2: result := fagObjDigits2;
    faObjDigits3: result := fagObjDigits3;
    faObjDigits4: result := fagObjDigits4;
    faObjDigits5: result := fagObjDigits5;

    { MeshFigures }
    faToggleMarker: result := fagToggleMarker;
    faToggleGrid: result := fagToggleGrid;
    faToggleGridFrequency: result := fagToggleGridFrequency;
    faToggleDiameter3: result := fagToggleDiameter3;
    faDiameter3On: result := fagDiameter3On;
    faDiameter3Off: result := fagDiameter3Off;
    faToggleCylinder: result := fagToggleCylinder;
    faToggleCube: result := fagToggleCube;
    faToggleCorner: result := fagToggleCorner;
    faToggleLimitPlane: result := fagToggleLimitPlane;

    { VertexPulling }
    faToggleZeroPulling: result := fagToggleZeroPulling;
    faToggleLimitPulling: result := fagToggleLimitPulling;
    faToggleSlicePulling: result := fagToggleSlicePulling;
    faToggleTargetPulling: result := fagToggleTargetPulling;
    faToggleRightPulling: result := fagToggleRightPulling;

    { MeshBuilderOptions }
    faToggleSolidFlip: result := fagToggleSolidFlip;
    faWantSpecialY: result := fagWantSpecialY;
    faToggleShowEdges: result := fagToggleShowEdges;
    faUniqueMode1: result := fagUniqueMode1;
    faUniqueMode2: result := fagUniqueMode2;
    faToggleUniqueVertices: result := fagToggleUniqueVertices;

    { TextureExport }
    faCopyBinCode: result := fagCopyBinCode;
    faCopyBinCodeTest: result := fagCopyBinCodeTest;

    { ColorMix }
    faColorMix0: result := fagColorMix0;
    faColorMix1: result := fagColorMix1;
    faColorMix2: result := fagColorMix2;
    faColorMix3: result := fagColorMix3;
    faColorMix4: result := fagColorMix4;
    faColorMix5: result := fagColorMix5;
    faColorMixP: result := fagColorMixP;
    faColorMixM: result := fagColorMixM;

    { ColorSwat }
    faToggleColorSwat: result := fagToggleColorSwat;

    { Lux }
    faLux1On: result := fagLux1On;
    faLux1Off: result := fagLux1Off;
    faToggleLux1: result := fagToggleLux1;
    faLux2On: result := fagLux2On;
    faLux2Off: result := fagLux2Off;
    faToggleLux2: result := fagToggleLux2;
    faLux3On: result := fagLux3On;
    faLux3Off: result := fagLux3Off;
    faToggleLux3: result := fagToggleLux3;
    faLux4On: result := fagLux4On;
    faLux4Off: result := fagLux4Off;
    faToggleLux4: result := fagToggleLux4;
    faLuxOn: result := fagLuxOn;
    faLuxOff: result := fagLuxOff;
    faToggleLux: result := fagToggleLux;

    { LuxMarker }
    faLuxMarkerOn: result := fagLuxMarkerOn;
    faLuxMarkerOff: result := fagLuxMarkerOff;
    faToggleLuxMarker: result := fagToggleLuxMarker;

    { LightMode }
    faLightMode0: result := fagLightMode0;
    faLightMode1: result := fagLightMode1;
    faLightMode2: result := fagLightMode2;
    faLightMode3: result := fagLightMode3;
    faLightMode4: result := fagLightMode4;

    { ResetLight }
    faResetLightPosition: result := fagResetLightPosition;
    faResetLightParams: result := fagResetLightParams;

    { Wheel }
    faParamValuePlus1: result := fagParamValuePlus1;
    faParamValueMinus1: result := fagParamValueMinus1;
    faParamValuePlus10: result := fagParamValuePlus10;
    faParamValueMinus10: result := fagParamValueMinus10;
    faWheelLeft: result := fagWheelLeft;
    faWheelRight: result := fagWheelRight;
    faWheelDown: result := fagWheelDown;
    faWheelUp: result := fagWheelUp;

    { WheelFrequency }
    faWheelFrequency1: result := fagWheelFrequency1;
    faWheelFrequency05: result := fagWheelFrequency05;
    faWheelFrequency02: result := fagWheelFrequency02;
    faWheelFrequency01: result := fagWheelFrequency01;
    faWheelFrequency001: result := fagWheelFrequency001;
    faWheelFrequency0001: result := fagWheelFrequency0001;

    { ColorScheme }
    faCycleColorSchemeM: result := fagCycleColorSchemeM;
    faCycleColorSchemeP: result := fagCycleColorSchemeP;

    { Step }
    faStepRXM: result := fagStepRXM;
    faStepRXP: result := fagStepRXP;
    faStepRYM: result := fagStepRYM;
    faStepRYP: result := fagStepRYP;
    faStepRZM: result := fagStepRZM;
    faStepRZP: result := fagStepRZP;
    faStepCZM: result := fagStepCZM;
    faStepCZP: result := fagStepCZP;

    { UI }
    faToggleColorPanel: result := fagToggleColorPanel;
    faColorPanelOn: result := fagColorPanelOn;
    faColorPanelOff: result := fagColorPanelOff;
    faPaletteOn: result := fagPaletteOn;
    faPaletteOff: result := fagPaletteOff;

    { Locks }
    faToggleLuxLock: result := fagToggleLuxLock;
    faToggleParamLock: result := fagToggleParamLock;
    faToggleTextureLock: result := fagToggleTextureLock;
    faToggleBackgroundLock: result := fagToggleBackgroundLock;
    faToggleForceLock: result := fagToggleForceLock;
    faToggleReportLock: result := fagToggleReportLock;

    { Opacity }
    faToggleOpacity: result := fagToggleOpacity;
    faOpacityOn: result := fagOpacityOn;
    faOpacityOff: result := fagOpacityOff;

    { FederText }
    faToggleAllText: result := fagToggleAllText;
    faToggleTouchFrame: result := fagToggleTouchFrame;

    { ViewParams }
    faPan: result := fagPan;
    faParamRX: result := fagParamRX;
    faParamRY: result := fagParamRY;
    faParamRZ: result := fagParamRZ;
    faParamCZ: result := fagParamCZ;

    { ViewParamsFC }
    faParamTRS: result := fagParamTRS;
    faParamTRT: result := fagParamTRT;
    faParamTRX: result := fagParamTRX;
    faParamTRY: result := fagParamTRY;

    { ParamT }
    faParamT1: result := fagParamT1;
    faParamT2: result := fagParamT2;
    faParamT3: result := fagParamT3;
    faParamT4: result := fagParamT4;

    { ViewFlags }
    faToggleBMap: result := fagToggleBMap;
    faToggleZoom: result := fagToggleZoom;
    faToggleTouchMenu: result := fagToggleTouchMenu;
    faToggleEquationText: result := fagToggleEquationText;
    faTogglePrimeText: result := fagTogglePrimeText;
    faToggleSecondText: result := fagToggleSecondText;
    faToggleLabelText: result := fagToggleLabelText;
    faLabelBatchM: result := fagLabelBatchM;
    faLabelBatchP: result := fagLabelBatchP;
    faLabelTextP: result := fagLabelTextP;
    faLabelTextM: result := fagLabelTextM;

    { Report }
    faCopyShortCutReport: result := fagCopyShortCutReport;
    faWriteActionReport: result := fagWriteActionReport;
    faWriteActionTable: result := fagWriteActionTable;
    faWriteActionConst: result := fagWriteActionConst;
    faWriteActionNames: result := fagWriteActionNames;
    faWriteVersion1: result := fagWriteVersion1;
    faWriteVersion2: result := fagWriteVersion2;
    faWriteCode: result := fagWriteCode;
    faWriteDiff1: result := fagWriteDiff1;
    faWriteDiffCode: result := fagWriteDiffCode;
    faWriteDiffBin: result := fagWriteDiffBin;
    faWriteBandInfo3: result := fagWriteBandInfo3;
    faWriteBandInfo5: result := fagWriteBandInfo5;
    faWriteEquationInfo: result := fagWriteEquationInfo;
    faWriteVirtual: result := fagWriteVirtual;
    faBlockTest: result := fagBlockTest;

    { ReportOptions }
    faSourcePascal: result := fagSourcePascal;
    faSourceMaxima: result := fagSourceMaxima;
    faSourceMaple: result := fagSourceMaple;
    faSourceMathematica: result := fagSourceMathematica;

    { CopyImage }
    faCopyScreenshot: result := fagCopyScreenshot;
    faCopyBitmap3D: result := fagCopyBitmap3D;
    faCopyTextureBitmap: result := fagCopyTextureBitmap;
    faCopyImprintedBitmap: result := fagCopyImprintedBitmap;
    faCopyImprintedBitmapTest: result := fagCopyImprintedBitmapTest;

    { CopyOptions }
    faToggleHardCopy: result := fagToggleHardCopy;
    faHardCopyOn: result := fagHardCopyOn;
    faHardCopyOff: result := fagHardCopyOff;
    faTogglePngCopy: result := fagTogglePngCopy;
    faPngCopyOn: result := fagPngCopyOn;
    faPngCopyOff: result := fagPngCopyOff;
    faToggleNoCopy: result := fagToggleNoCopy;
    faNoCopyOn: result := fagNoCopyOn;
    faNoCopyOff: result := fagNoCopyOff;

    { GraphOptions }
    faToggleDiameter: result := fagToggleDiameter;
    faToggleProbe: result := fagToggleProbe;

    { Bahn }
    faNorthCap: result := fagNorthCap;
    faSouthCap: result := fagSouthCap;
    faEastCap: result := fagEastCap;
    faWestCap: result := fagWestCap;
    faParamCapValue: result := fagParamCapValue;
    faParamBahnRadius: result := fagParamBahnRadius;
    faParamBahnPositionX: result := fagParamBahnPositionX;
    faParamBahnPositionY: result := fagParamBahnPositionY;
    faParamBahnAngle: result := fagParamBahnAngle;
    faParamBahnCylinderD: result := fagParamBahnCylinderD;
    faParamBahnCylinderZ: result := fagParamBahnCylinderZ;

    { ExampleData }
    faExample01: result := fagExample01;
    faExample02: result := fagExample02;
    faExample03: result := fagExample03;
    faExample04: result := fagExample04;
    faExample05: result := fagExample05;
    faExample06: result := fagExample06;
    faExample07: result := fagExample07;
    faExample08: result := fagExample08;
    faExample09: result := fagExample09;

    { SampleNavigation }
    faSampleM: result := fagSampleM;
    faSampleP: result := fagSampleP;
    faGotoSample1: result := fagGotoSample1;

    { Help }
    faToggleHelp: result := fagToggleHelp;
    faToggleReport: result := fagToggleReport;
    faToggleButtonReport: result := fagToggleButtonReport;
    faCycleHelpM: result := fagCycleHelpM;
    faCycleHelpP: result := fagCycleHelpP;
    faHelpCycle: result := fagHelpCycle;
    faHelpList: result := fagHelpList;
    faHelpHome: result := fagHelpHome;

    { BtnLegendTablet }
    faTL01: result := fagTL01;
    faTL02: result := fagTL02;
    faTL03: result := fagTL03;
    faTL04: result := fagTL04;
    faTL05: result := fagTL05;
    faTL06: result := fagTL06;
    faTR01: result := fagTR01;
    faTR02: result := fagTR02;
    faTR03: result := fagTR03;
    faTR04: result := fagTR04;
    faTR05: result := fagTR05;
    faTR06: result := fagTR06;
    faTR07: result := fagTR07;
    faTR08: result := fagTR08;
    faBL01: result := fagBL01;
    faBL02: result := fagBL02;
    faBL03: result := fagBL03;
    faBL04: result := fagBL04;
    faBL05: result := fagBL05;
    faBL06: result := fagBL06;
    faBL07: result := fagBL07;
    faBL08: result := fagBL08;
    faBR01: result := fagBR01;
    faBR02: result := fagBR02;
    faBR03: result := fagBR03;
    faBR04: result := fagBR04;
    faBR05: result := fagBR05;
    faBR06: result := fagBR06;

    { BtnLegendPhone }
    faMB01: result := fagMB01;
    faMB02: result := fagMB02;
    faMB03: result := fagMB03;
    faMB04: result := fagMB04;
    faMB05: result := fagMB05;
    faMB06: result := fagMB06;
    faMB07: result := fagMB07;
    faMB08: result := fagMB08;

    { TouchBarLegend }
    faTouchBarTop: result := fagTouchBarTop;
    faTouchBarBottom: result := fagTouchBarBottom;
    faTouchBarLeft: result := fagTouchBarLeft;
    faTouchBarRight: result := fagTouchBarRight;

    { Reset }
    faReset: result := fagReset;
    faResetPosition: result := fagResetPosition;
    faResetRotation: result := fagResetRotation;
    faResetZoom: result := fagResetZoom;

    { Language }
    faToggleLanguage: result := fagToggleLanguage;

    { CopyPaste }
    faSave: result := fagSave;
    faLoad: result := fagLoad;
    faOpen: result := fagOpen;
    faCopy: result := fagCopy;
    faPaste: result := fagPaste;

    { ViewOptions }
    faToggleMoveMode: result := fagToggleMoveMode;
    faLinearMove: result := fagLinearMove;
    faExpoMove: result := fagExpoMove;
    faToggleOrbitMode: result := fagToggleOrbitMode;

    { BitmapCycle }
    faCycleBitmapM: result := fagCycleBitmapM;
    faCycleBitmapP: result := fagCycleBitmapP;
    faRandom: result := fagRandom;
    faRandomWhite: result := fagRandomWhite;
    faRandomBlack: result := fagRandomBlack;
    faRandomBambu1: result := fagRandomBambu1;
    faRandomBambu2: result := fagRandomBambu2;
    faBitmapEscape: result := fagBitmapEscape;
    faBitmapOne: result := fagBitmapOne;
    faToggleContour: result := fagToggleContour;

    { Layout0 }
    faLayout0: result := fagLayout0;
    faLayout1: result := fagLayout1;
    faLayout2: result := fagLayout2;
    faLayout3: result := fagLayout3;
    faLayout4: result := fagLayout4;
    faLayout5: result := fagLayout5;
    faLayout6: result := fagLayout6;
    faLayout7: result := fagLayout7;
    faLayout8: result := fagLayout8;
    faLayout9: result := fagLayout9;

    { FigureSize }
    faFigureSizeXS: result := fagFigureSizeXS;
    faFigureSizeS: result := fagFigureSizeS;
    faFigureSizeM: result := fagFigureSizeM;
    faFigureSizeL: result := fagFigureSizeL;
    faFigureSizeXL: result := fagFigureSizeXL;

    { EyeSize }
    faEyeSizeS: result := fagEyeSizeS;
    faEyeSizeM: result := fagEyeSizeM;
    faEyeSizeL: result := fagEyeSizeL;

    { LayerSelection }
    faSelectLayer1: result := fagSelectLayer1;
    faSelectLayer2: result := fagSelectLayer2;
    faSelectLayer3: result := fagSelectLayer3;
    faSelectLayer4: result := fagSelectLayer4;
    faSelectLayer5: result := fagSelectLayer5;
    faSelectLayer6: result := fagSelectLayer6;
    faSelectLayer7: result := fagSelectLayer7;

    { ColorSelection }
    faSelectColor1: result := fagSelectColor1;
    faSelectColor2: result := fagSelectColor2;
    faSelectColor3: result := fagSelectColor3;
    faSelectColor4: result := fagSelectColor4;

    { ColorMapping }
    faCLA: result := fagCLA;
    faMapColorToLayer: result := fagMapColorToLayer;
    faSelectColorMapping1: result := fagSelectColorMapping1;
    faSelectColorMapping2: result := fagSelectColorMapping2;
    faSelectColorMapping3: result := fagSelectColorMapping3;
    faSelectColorMapping4: result := fagSelectColorMapping4;
    faSelectColorMapping5: result := fagSelectColorMapping5;
    faSelectColorMapping6: result := fagSelectColorMapping6;
  end;
end;

end.
