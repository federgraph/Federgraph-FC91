unit RiggVar.FB.ActionShort;

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

function GetFederActionShort(fa: TFederAction): string;

implementation

function GetFederActionShort(fa: TFederAction): string;
begin
  result := '??';
  case fa of
    // --- generated code snippet ---

    { EmptyAction }
    faNoop: result := '';

    { Pages }
    faActionPageM: result := 'P-';
    faActionPageP: result := 'P+';
    faActionPageE: result := 'PE';
    faActionPageS: result := 'PS';
    faActionPageX: result := 'LP';
    faActionPage1: result := 'HP';
    faActionPage2: result := 'SP';
    faActionPage3: result := 'ap3';
    faActionPage4: result := 'ap4';
    faActionPage5: result := 'ap5';
    faActionPage6: result := 'ap6';

    { Forms }
    faShowMemo: result := 'FM';
    faShowActions: result := 'FA';
    faShowInfo: result := 'FI';

    { TouchLayout }
    faTouchTablet: result := 'tab';
    faTouchPhone: result := 'pho';
    faTouchDesk: result := 'dsk';

    { SystemParam }
    faParamX1: result := 'x1';
    faParamY1: result := 'y1';
    faParamZ1: result := 'z1';
    faParamL1: result := 'l1';
    faParamK1: result := 'k1';
    faParamX2: result := 'x2';
    faParamY2: result := 'y2';
    faParamZ2: result := 'z2';
    faParamL2: result := 'l2';
    faParamK2: result := 'k2';
    faParamX3: result := 'x3';
    faParamY3: result := 'y3';
    faParamZ3: result := 'z3';
    faParamL3: result := 'l3';
    faParamK3: result := 'k3';
    faParamX4: result := 'x4';
    faParamY4: result := 'y4';
    faParamZ4: result := 'z4';
    faParamL4: result := 'l4';
    faParamK4: result := 'k4';

    { OffsetParam }
    faOffsetX: result := 'ox';
    faOffsetY: result := 'oy';
    faOffsetZ: result := 'oz';

    { CoordParam }
    faCoord0: result := 'oo0';
    faCoord1: result := 'oo1';
    faCoord2: result := 'oo2';
    faCoord3: result := 'oo3';

    { LuxParam }
    faParamL1X: result := 'l1x';
    faParamL1Y: result := 'l1y';
    faParamL1Z: result := 'l1z';
    faParamL2X: result := 'l2x';
    faParamL2Y: result := 'l2y';
    faParamL2Z: result := 'l2z';
    faParamL3X: result := 'l3x';
    faParamL3Y: result := 'l3y';
    faParamL3Z: result := 'l3z';
    faParamL4X: result := 'l4x';
    faParamL4Y: result := 'l4y';
    faParamL4Z: result := 'l4z';

    { ParamCycle }
    faCycleX: result := 'x';
    faCycleY: result := 'y';
    faCycleZ: result := 'z';
    faCycleL: result := 'l';
    faCycleK: result := 'k';
    faCycleO: result := 'o';
    faCycleR: result := 'r';
    faCycleT: result := 't';
    faCycleU: result := 'u';

    { ModelParams }
    faParamR: result := 'R';
    faParamT: result := 'T';
    faParamL: result := 'L';
    faParamK: result := 'K';
    faParamZ: result := 'Z';
    faParamA: result := 'A';
    faParamG: result := 'G';
    faParamX12: result := 'x12';
    faParamY12: result := 'y12';
    faParamZ12: result := 'z12';
    faParamY3F: result := 'y3f';
    faParamL3F: result := 'l3f';
    faParamLF: result := 'Lf';

    { RingActions }
    faBlindRingP: result := 'br+';
    faBlindRingM: result := 'br-';
    faCycleRingP: result := 'cr+';
    faCycleRingM: result := 'cr-';
    faToggleShirtColor: result := 'tsc';
    faShirtColorOn: result := 'sh1';
    faShirtColorOff: result := 'sh0';
    faApplyRingColor: result := 'arc';
    faToggleShirtFarbe: result := 'tsf';
    faShirtFarbeOn: result := 'sf1';
    faShirtFarbeOff: result := 'sf0';
    faPixelCount1: result := 'bh1';
    faPixelCount2: result := 'bh2';
    faPixelCount4: result := 'bh4';

    { ParamBand }
    faParamBandSelected: result := 'bs';
    faParamBandCount: result := 'bc';
    faParamBandDistributionX: result := 'bdx';
    faParamBandDistributionY: result := 'bdy';
    faParamBandWidth: result := 'bw';
    faBandWidthAbsolute: result := 'bwa';
    faBandWidthRelative: result := 'bwr';
    faBandWidthContour: result := 'bwc';

    { BlindRingSelection }
    faBlindRing1: result := 'br1';
    faBlindRing5: result := 'br5';
    faBlindRingA: result := 'brA';
    faBlindRingB: result := 'brB';
    faBlindRingC: result := 'brC';
    faBlindRingD: result := 'brD';
    faBlindRingE: result := 'brE';
    faBlindRingF: result := 'brF';

    { CurrentBand }
    faShowCurrentBand0: result := 'cb0';
    faShowCurrentBand1: result := 'cb1';
    faShowCurrentBandT: result := 'cbt';

    { BandSelection }
    faBandSelectionM: result := 'bs-';
    faBandSelectionP: result := 'bs+';
    faBandSelection16: result := 'b16';
    faBandSelection17: result := 'b17';
    faBandSelection18: result := 'b18';
    faBandSelection19: result := 'b19';
    faBandSelection20: result := 'b20';
    faBandSelection21: result := 'b21';

    { MeshSize }
    faMeshSize4: result := '004';
    faMeshSize8: result := '008';
    faMeshSize16: result := '016';
    faMeshSize32: result := '032';
    faMeshSize64: result := '064';
    faMeshSize128: result := '128';
    faMeshSize256: result := '256';
    faMeshSize316: result := '316';
    faMeshSize512: result := '512';

    { MeshExport }
    faWantBottom: result := 'wB';
    faWantBottomMirrored: result := '-|-';
    faWantSideCaps: result := 'wS';
    faTestSingleSide: result := 'tSS';

    { MeshExportCoords }
    faExportCoordsNative: result := 'ecN';
    faExportCoordsBlender: result := 'ecB';
    faExportCoords3DV: result := 'ecV';
    faExportCoords3DP: result := 'ecP';

    { ExporterOBJ }
    faWantAutoFolder: result := 'wAF';
    faExportMtl: result := 'MTL';
    faExportObj: result := 'Obj';
    faWantMaterial: result := 'mtl';
    faWantSimpleName: result := 'wSN';
    faWantAngularDir: result := 'wAD';
    faWantNormals: result := '.vn';
    faWantUVs: result := '.vt';
    faObjDigits2: result := '.d2';
    faObjDigits3: result := '.d3';
    faObjDigits4: result := '.d4';
    faObjDigits5: result := '.d5';

    { MeshBuilderOptions }
    faToggleSolidFlip: result := 'thf';
    faWantSpecialY: result := 'wsy';
    faToggleShowEdges: result := 'tse';
    faUniqueMode1: result := 'u1';
    faUniqueMode2: result := 'u2';
    faToggleUniqueVertices: result := 'tuv';

    { ColorSwat }
    faToggleColorSwat: result := 'cs';

    { Lux }
    faToggleLux: result := 'lux';

    { Wheel }
    faParamValuePlus1: result := '+1';
    faParamValueMinus1: result := '-1';
    faParamValuePlus10: result := '+10';
    faParamValueMinus10: result := '-10';
    faWheelLeft: result := 'wl';
    faWheelRight: result := 'wr';
    faWheelDown: result := 'wd';
    faWheelUp: result := 'wu';

    { WheelFrequency }
    faWheelFrequency1: result := 'wf1';
    faWheelFrequency01: result := 'wf4';
    faWheelFrequency001: result := 'wf5';

    { ColorScheme }
    faCycleColorSchemeM: result := 'c-';
    faCycleColorSchemeP: result := 'c+';

    { UI }
    faToggleColorPanel: result := 'cp';
    faColorPanelOn: result := 'CPA';
    faColorPanelOff: result := 'cpa';

    { FederText }
    faToggleAllText: result := 'tat';
    faToggleTouchFrame: result := 'fra';

    { ViewParams }
    faPan: result := 'pan';
    faParamRX: result := 'rx';
    faParamRY: result := 'ry';
    faParamRZ: result := 'rz';
    faParamCZ: result := 'cz';

    { ParamT }
    faParamT1: result := 't1';
    faParamT2: result := 't2';
    faParamT3: result := 't3';
    faParamT4: result := 't4';

    { ViewFlags }
    faToggleTouchMenu: result := 'men';
    faToggleEquationText: result := 'tbl';
    faTogglePrimeText: result := 'txt';
    faToggleSecondText: result := 'lbl';
    faToggleLabelText: result := 'ltv';
    faLabelBatchM: result := 'lb-';
    faLabelBatchP: result := 'lb+';
    faLabelTextP: result := 'ltp';
    faLabelTextM: result := 'ltm';

    { Bahn }
    faNorthCap: result := 'ncv';
    faSouthCap: result := 'scv';
    faParamCapValue: result := 'pcv';

    { SampleNavigation }
    faGotoSample1: result := 'gs1';

    { BtnLegendTablet }
    faTL01: result := '#1';
    faTL02: result := '#2';
    faTL03: result := '#3';
    faTL04: result := '#4';
    faTL05: result := '#5';
    faTL06: result := '#6';
    faTR01: result := '1#';
    faTR02: result := '2#';
    faTR03: result := '3#';
    faTR04: result := '4#';
    faTR05: result := '5#';
    faTR06: result := '6#';
    faTR07: result := '7#';
    faTR08: result := '8#';
    faBL01: result := '1*';
    faBL02: result := '2*';
    faBL03: result := '3*';
    faBL04: result := '4*';
    faBL05: result := '5*';
    faBL06: result := '6*';
    faBL07: result := '7*';
    faBL08: result := '8*';
    faBR01: result := '*1';
    faBR02: result := '*2';
    faBR03: result := '*3';
    faBR04: result := '*4';
    faBR05: result := '*5';
    faBR06: result := '*6';

    { BtnLegendPhone }
    faMB01: result := '_1';
    faMB02: result := '_2';
    faMB03: result := '_3';
    faMB04: result := '_4';
    faMB05: result := '_5';
    faMB06: result := '_6';
    faMB07: result := '_7';
    faMB08: result := '_8';

    { TouchBarLegend }
    faTouchBarTop: result := 'tbT';
    faTouchBarBottom: result := 'tbB';
    faTouchBarLeft: result := 'tbL';
    faTouchBarRight: result := 'tbR';

    { Reset }
    faReset: result := 'res';
    faResetPosition: result := 'rpo';
    faResetRotation: result := 'rro';
    faResetZoom: result := 'rzo';

    { BitmapCycle }
    faCycleBitmapM: result := 'b-';
    faCycleBitmapP: result := 'b+';
    faRandom: result := 'ran';
    faRandomWhite: result := 'rcw';
    faRandomBlack: result := 'rcb';
    faBitmapEscape: result := 'be';
    faBitmapOne: result := 'bf';
    faToggleContour: result := 'ct';

    { Layout0 }
    faLayout0: result := '0';
    faLayout1: result := '1';
    faLayout2: result := '2';
    faLayout3: result := '3';
    faLayout4: result := '4';
    faLayout5: result := '5';
    faLayout6: result := '6';
    faLayout7: result := '7';
    faLayout8: result := '8';
    faLayout9: result := '9';

    { ColorMapping }
    faCLA: result := '.';
  end;
end;

end.
