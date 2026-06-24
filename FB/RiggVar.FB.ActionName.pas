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

    { MeshExport }
    faWantBottom: result := 'faWantBottom';
    faWantBottomMirrored: result := 'faWantBottomMirrored';
    faWantSideCaps: result := 'faWantSideCaps';
    faTestSingleSide: result := 'faTestSingleSide';

    { MeshExportCoords }
    faExportCoordsNative: result := 'faExportCoordsNative';
    faExportCoordsBlender: result := 'faExportCoordsBlender';
    faExportCoords3DV: result := 'faExportCoords3DV';
    faExportCoords3DP: result := 'faExportCoords3DP';

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

    { MeshBuilderOptions }
    faToggleSolidFlip: result := 'faToggleSolidFlip';
    faWantSpecialY: result := 'faWantSpecialY';
    faToggleShowEdges: result := 'faToggleShowEdges';
    faUniqueMode1: result := 'faUniqueMode1';
    faUniqueMode2: result := 'faUniqueMode2';
    faToggleUniqueVertices: result := 'faToggleUniqueVertices';

    { ColorSwat }
    faToggleColorSwat: result := 'faToggleColorSwat';

    { Lux }
    faToggleLux: result := 'faToggleLux';

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
    faWheelFrequency01: result := 'faWheelFrequency01';
    faWheelFrequency001: result := 'faWheelFrequency001';

    { ColorScheme }
    faCycleColorSchemeM: result := 'faCycleColorSchemeM';
    faCycleColorSchemeP: result := 'faCycleColorSchemeP';

    { UI }
    faToggleColorPanel: result := 'faToggleColorPanel';

    { ViewParams }
    faPan: result := 'faPan';
    faParamRX: result := 'faParamRX';
    faParamRY: result := 'faParamRY';
    faParamRZ: result := 'faParamRZ';
    faParamCZ: result := 'faParamCZ';

    { ParamT }
    faParamT1: result := 'faParamT1';
    faParamT2: result := 'faParamT2';
    faParamT3: result := 'faParamT3';
    faParamT4: result := 'faParamT4';

    { Bahn }
    faNorthCap: result := 'faNorthCap';
    faSouthCap: result := 'faSouthCap';
    faParamCapValue: result := 'faParamCapValue';

    { Reset }
    faReset: result := 'faReset';
    faResetPosition: result := 'faResetPosition';
    faResetRotation: result := 'faResetRotation';
    faResetZoom: result := 'faResetZoom';

    { BitmapCycle }
    faCycleBitmapM: result := 'faCycleBitmapM';
    faCycleBitmapP: result := 'faCycleBitmapP';
    faRandom: result := 'faRandom';
    faRandomWhite: result := 'faRandomWhite';
    faRandomBlack: result := 'faRandomBlack';
    faBitmapEscape: result := 'faBitmapEscape';
    faBitmapOne: result := 'faBitmapOne';
    faToggleContour: result := 'faToggleContour';
  end;
end;

end.
