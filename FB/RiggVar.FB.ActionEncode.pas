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

    { MeshBuilderOptions }
    faToggleSolidFlip: result := fagToggleSolidFlip;
    faWantSpecialY: result := fagWantSpecialY;
    faToggleShowEdges: result := fagToggleShowEdges;
    faUniqueMode1: result := fagUniqueMode1;
    faUniqueMode2: result := fagUniqueMode2;
    faToggleUniqueVertices: result := fagToggleUniqueVertices;

    { ColorSwat }
    faToggleColorSwat: result := fagToggleColorSwat;

    { Lux }
    faToggleLux: result := fagToggleLux;

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
    faWheelFrequency01: result := fagWheelFrequency01;
    faWheelFrequency001: result := fagWheelFrequency001;

    { ColorScheme }
    faCycleColorSchemeM: result := fagCycleColorSchemeM;
    faCycleColorSchemeP: result := fagCycleColorSchemeP;

    { UI }
    faToggleColorPanel: result := fagToggleColorPanel;
    faColorPanelOn: result := fagColorPanelOn;
    faColorPanelOff: result := fagColorPanelOff;

    { FederText }
    faToggleAllText: result := fagToggleAllText;
    faToggleTouchFrame: result := fagToggleTouchFrame;

    { ViewParams }
    faPan: result := fagPan;
    faParamRX: result := fagParamRX;
    faParamRY: result := fagParamRY;
    faParamRZ: result := fagParamRZ;
    faParamCZ: result := fagParamCZ;

    { ParamT }
    faParamT1: result := fagParamT1;
    faParamT2: result := fagParamT2;
    faParamT3: result := fagParamT3;
    faParamT4: result := fagParamT4;

    { ViewFlags }
    faToggleTouchMenu: result := fagToggleTouchMenu;
    faToggleEquationText: result := fagToggleEquationText;
    faTogglePrimeText: result := fagTogglePrimeText;
    faToggleSecondText: result := fagToggleSecondText;
    faToggleLabelText: result := fagToggleLabelText;
    faLabelBatchM: result := fagLabelBatchM;
    faLabelBatchP: result := fagLabelBatchP;
    faLabelTextP: result := fagLabelTextP;
    faLabelTextM: result := fagLabelTextM;

    { Bahn }
    faNorthCap: result := fagNorthCap;
    faSouthCap: result := fagSouthCap;
    faParamCapValue: result := fagParamCapValue;

    { SampleNavigation }
    faGotoSample1: result := fagGotoSample1;

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

    { BitmapCycle }
    faCycleBitmapM: result := fagCycleBitmapM;
    faCycleBitmapP: result := fagCycleBitmapP;
    faRandom: result := fagRandom;
    faRandomWhite: result := fagRandomWhite;
    faRandomBlack: result := fagRandomBlack;
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

    { ColorMapping }
    faCLA: result := fagCLA;
  end;
end;

end.
