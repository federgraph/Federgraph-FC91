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

    { MeshExport }
    fagWantBottom: result := faWantBottom;
    fagWantBottomMirrored: result := faWantBottomMirrored;
    fagWantSideCaps: result := faWantSideCaps;
    fagTestSingleSide: result := faTestSingleSide;

    { MeshExportCoords }
    fagExportCoordsNative: result := faExportCoordsNative;
    fagExportCoordsBlender: result := faExportCoordsBlender;
    fagExportCoords3DV: result := faExportCoords3DV;
    fagExportCoords3DP: result := faExportCoords3DP;

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

    { MeshBuilderOptions }
    fagToggleSolidFlip: result := faToggleSolidFlip;
    fagWantSpecialY: result := faWantSpecialY;
    fagToggleShowEdges: result := faToggleShowEdges;
    fagUniqueMode1: result := faUniqueMode1;
    fagUniqueMode2: result := faUniqueMode2;
    fagToggleUniqueVertices: result := faToggleUniqueVertices;

    { ColorSwat }
    fagToggleColorSwat: result := faToggleColorSwat;

    { Lux }
    fagToggleLux: result := faToggleLux;

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
    fagWheelFrequency01: result := faWheelFrequency01;
    fagWheelFrequency001: result := faWheelFrequency001;

    { ColorScheme }
    fagCycleColorSchemeM: result := faCycleColorSchemeM;
    fagCycleColorSchemeP: result := faCycleColorSchemeP;

    { UI }
    fagToggleColorPanel: result := faToggleColorPanel;

    { ViewParams }
    fagPan: result := faPan;
    fagParamRX: result := faParamRX;
    fagParamRY: result := faParamRY;
    fagParamRZ: result := faParamRZ;
    fagParamCZ: result := faParamCZ;

    { ParamT }
    fagParamT1: result := faParamT1;
    fagParamT2: result := faParamT2;
    fagParamT3: result := faParamT3;
    fagParamT4: result := faParamT4;

    { Bahn }
    fagNorthCap: result := faNorthCap;
    fagSouthCap: result := faSouthCap;
    fagParamCapValue: result := faParamCapValue;

    { Reset }
    fagReset: result := faReset;
    fagResetPosition: result := faResetPosition;
    fagResetRotation: result := faResetRotation;
    fagResetZoom: result := faResetZoom;

    { BitmapCycle }
    fagCycleBitmapM: result := faCycleBitmapM;
    fagCycleBitmapP: result := faCycleBitmapP;
    fagRandom: result := faRandom;
    fagRandomWhite: result := faRandomWhite;
    fagRandomBlack: result := faRandomBlack;
    fagBitmapEscape: result := faBitmapEscape;
    fagBitmapOne: result := faBitmapOne;
    fagToggleContour: result := faToggleContour;
  end;
end;

end.
