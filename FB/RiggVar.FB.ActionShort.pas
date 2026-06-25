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
    faShowImage: result := 'BI';
    faShowMemo: result := 'FM';
    faShowActions: result := 'FA';
    faShowInfo: result := 'FI';

    { TouchLayout }
    faTouchTablet: result := 'tab';
    faTouchPhone: result := 'pho';
    faTouchDesk: result := 'dsk';

    { ActionMapping }
    faProcessAll: result := 'pa';

    { Scene }
    faScene1: result := 'S1';
    faScene2: result := 'S2';
    faScene3: result := 'S3';
    faScene4: result := 'S4';
    faScene5: result := 'S5';

    { Plot }
    faPlot0: result := 'P0';
    faPlot1: result := 'P1';
    faPlot2: result := 'P2';
    faPlot3: result := 'P3';
    faPlot4: result := 'P4';
    faPlot5: result := 'P5';
    faPlot6: result := 'P6';
    faPlot7: result := 'P7';
    faPlot8: result := 'P8';
    faPlot9: result := 'P9';
    faPlot10: result := 'P10';
    faPlot11: result := 'P11';
    faPlot12: result := 'P12';
    faPlot13: result := 'P13';

    { Figure }
    faFigure1: result := 'F1';
    faFigure2: result := 'F2';
    faFigure3: result := 'F3';
    faFigure4: result := 'F4';
    faFigure5: result := 'F5';
    faFigure6: result := 'F6';

    { Graph }
    faGraph1: result := 'G1';
    faGraph2: result := 'G2';
    faGraph3: result := 'G3';
    faGraph4: result := 'G4';
    faGraph5: result := 'G5';

    { Color }
    faColor0: result := 'c0';
    faColor1: result := 'c1';
    faColor2: result := 'c2';
    faColor3: result := 'c3';
    faColor4: result := 'c4';
    faColor5: result := 'c5';
    faColor6: result := 'c6';

    { Param }
    faParam0: result := 'fp0';
    faParam1: result := 'fp1';
    faParam2: result := 'fp2';
    faParam3: result := 'fp3';
    faParam4: result := 'fp4';
    faParam5: result := 'fp5';
    faParam6: result := 'fp6';
    faParam7: result := 'fp7';
    faParam8: result := 'fp8';
    faParam9: result := 'fp9';

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

    { ModelOptions }
    faToggleSolutionMode: result := 's';
    faToggleVorzeichen: result := 'v';
    faToggleLinearForce: result := 'lf';
    faToggleGleich: result := '=';
    faToggleMCap: result := 'm';
    faTogglePCap: result := 'p';
    faForceZ0: result := 'FZ0';
    faWantZ12: result := 'Z12';
    faDiff0: result := 'd-0';
    faDiff1: result := 'd-1';
    faDiff10: result := 'd10';

    { OptionCycle }
    faCyclePlotM: result := 'e-';
    faCyclePlotP: result := 'e+';
    faCycleGraphM: result := 'g-';
    faCycleGraphP: result := 'g+';
    faCycleFigureM: result := 'f-';
    faCycleFigureP: result := 'f+';

    { ForceMode }
    faForceMode0: result := 'f0';
    faForceMode1: result := 'f1';
    faForceMode2: result := 'f2';

    { FederMode }
    faM1: result := 'm1';
    faM2: result := 'm2';
    faM3: result := 'm3';

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

    { MeshMode }
    faReducedMesh: result := 'rm';
    faReduceMode0: result := 'rm0';
    faReduceMode1: result := 'rm1';
    faReduceMode2: result := 'rm2';
    faReduceMode3: result := 'rm3';

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
    faTakeCapValueSnapshot: result := 'tCV';

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

    { MeshFigures }
    faToggleMarker: result := 'tgm';
    faToggleGrid: result := 'tgl';
    faToggleGridFrequency: result := 'tgf';
    faToggleDiameter3: result := 'tcr';
    faDiameter3On: result := 'cr1';
    faDiameter3Off: result := 'cr0';
    faToggleCylinder: result := 'cyl';
    faToggleCube: result := 'tcc';
    faToggleCorner: result := 'tcp';
    faToggleLimitPlane: result := 'tlp';

    { VertexPulling }
    faToggleZeroPulling: result := 'wZP';
    faToggleLimitPulling: result := 'wLP';
    faToggleSlicePulling: result := 'wSP';
    faToggleTargetPulling: result := 'wTP';
    faToggleRightPulling: result := 'wRP';

    { MeshBuilderOptions }
    faToggleSolidFlip: result := 'thf';
    faWantSpecialY: result := 'wsy';
    faToggleShowEdges: result := 'tse';
    faUniqueMode1: result := 'u1';
    faUniqueMode2: result := 'u2';
    faToggleUniqueVertices: result := 'tuv';

    { TextureExport }
    faCopyBinCode: result := 'cbc';
    faCopyBinCodeTest: result := 'bct';

    { ColorMix }
    faColorMix0: result := 'cm0';
    faColorMix1: result := 'cm1';
    faColorMix2: result := 'cm2';
    faColorMix3: result := 'cm3';
    faColorMix4: result := 'cm4';
    faColorMix5: result := 'cm5';
    faColorMixP: result := 'cm+';
    faColorMixM: result := 'cm-';

    { ColorSwat }
    faToggleColorSwat: result := 'cs';

    { Lux }
    faLux1On: result := 'l11';
    faLux1Off: result := 'l10';
    faToggleLux1: result := 'li1';
    faLux2On: result := 'l21';
    faLux2Off: result := 'l20';
    faToggleLux2: result := 'li2';
    faLux3On: result := 'l31';
    faLux3Off: result := 'l30';
    faToggleLux3: result := 'li3';
    faLux4On: result := 'l41';
    faLux4Off: result := 'l40';
    faToggleLux4: result := 'li4';
    faLuxOn: result := 'lx1';
    faLuxOff: result := 'lx0';
    faToggleLux: result := 'lux';

    { LuxMarker }
    faLuxMarkerOn: result := 'xm1';
    faLuxMarkerOff: result := 'xm0';
    faToggleLuxMarker: result := 'lma';

    { LightMode }
    faLightMode0: result := 'lm0';
    faLightMode1: result := 'lm1';
    faLightMode2: result := 'lm2';
    faLightMode3: result := 'lm3';
    faLightMode4: result := 'lm4';

    { ResetLight }
    faResetLightPosition: result := 'RL1';
    faResetLightParams: result := 'RL2';

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
    faWheelFrequency05: result := 'wf2';
    faWheelFrequency02: result := 'wf3';
    faWheelFrequency01: result := 'wf4';
    faWheelFrequency001: result := 'wf5';
    faWheelFrequency0001: result := 'wf6';

    { ColorScheme }
    faCycleColorSchemeM: result := 'c-';
    faCycleColorSchemeP: result := 'c+';

    { Step }
    faStepRXM: result := 'rxm';
    faStepRXP: result := 'rxp';
    faStepRYM: result := 'rym';
    faStepRYP: result := 'ryp';
    faStepRZM: result := 'rzm';
    faStepRZP: result := 'rzp';
    faStepCZM: result := 'czm';
    faStepCZP: result := 'czp';

    { UI }
    faToggleColorPanel: result := 'cp';
    faColorPanelOn: result := 'CPA';
    faColorPanelOff: result := 'cpa';
    faPaletteOn: result := 'PAL';
    faPaletteOff: result := 'pal';

    { Locks }
    faToggleLuxLock: result := 'll';
    faToggleParamLock: result := 'pl';
    faToggleTextureLock: result := 'tl';
    faToggleBackgroundLock: result := 'bl';
    faToggleForceLock: result := 'fl';
    faToggleReportLock: result := 'rl';

    { Opacity }
    faToggleOpacity: result := 'top';
    faOpacityOn: result := 'op1';
    faOpacityOff: result := 'op0';

    { FederText }
    faToggleAllText: result := 'tat';
    faToggleTouchFrame: result := 'fra';

    { ViewParams }
    faPan: result := 'pan';
    faParamRX: result := 'rx';
    faParamRY: result := 'ry';
    faParamRZ: result := 'rz';
    faParamCZ: result := 'cz';

    { ViewParamsFC }
    faParamTRS: result := 'trs';
    faParamTRT: result := 'trt';
    faParamTRX: result := 'trx';
    faParamTRY: result := 'try';

    { ParamT }
    faParamT1: result := 't1';
    faParamT2: result := 't2';
    faParamT3: result := 't3';
    faParamT4: result := 't4';

    { ViewFlags }
    faToggleBMap: result := 'bm';
    faToggleZoom: result := 'tz';
    faToggleTouchMenu: result := 'men';
    faToggleEquationText: result := 'tbl';
    faTogglePrimeText: result := 'txt';
    faToggleSecondText: result := 'lbl';
    faToggleLabelText: result := 'ltv';
    faLabelBatchM: result := 'lb-';
    faLabelBatchP: result := 'lb+';
    faLabelTextP: result := 'ltp';
    faLabelTextM: result := 'ltm';

    { Report }
    faCopyShortCutReport: result := 'scr';
    faWriteActionReport: result := '~ar';
    faWriteActionTable: result := '~at';
    faWriteActionConst: result := '~ac';
    faWriteActionNames: result := '~an';
    faWriteVersion1: result := 'W1';
    faWriteVersion2: result := 'W2';
    faWriteCode: result := 'WC';
    faWriteDiff1: result := 'D1';
    faWriteDiffCode: result := 'DC';
    faWriteDiffBin: result := 'DB';
    faWriteBandInfo3: result := 'B3';
    faWriteBandInfo5: result := 'B5';
    faWriteEquationInfo: result := 'eI';
    faWriteVirtual: result := 'WV';
    faBlockTest: result := 'BT';

    { ReportOptions }
    faSourcePascal: result := 'pas';
    faSourceMaxima: result := 'max';
    faSourceMaple: result := 'mpl';
    faSourceMathematica: result := 'cs3';

    { CopyImage }
    faCopyScreenshot: result := 'css';
    faCopyBitmap3D: result := 'CB3';
    faCopyTextureBitmap: result := 'CTB';
    faCopyImprintedBitmap: result := 'cib';
    faCopyImprintedBitmapTest: result := 'ibt';

    { CopyOptions }
    faToggleHardCopy: result := 'thc';
    faHardCopyOn: result := 'hc1';
    faHardCopyOff: result := 'hc0';
    faTogglePngCopy: result := 'tpc';
    faPngCopyOn: result := 'pc1';
    faPngCopyOff: result := 'pc0';
    faToggleNoCopy: result := 'tnc';
    faNoCopyOn: result := 'nc1';
    faNoCopyOff: result := 'nc0';

    { GraphOptions }
    faToggleDiameter: result := 'dia';
    faToggleProbe: result := 'pro';

    { Bahn }
    faNorthCap: result := 'ncv';
    faSouthCap: result := 'scv';
    faEastCap: result := 'ecv';
    faWestCap: result := 'wcv';
    faParamCapValue: result := 'pcv';
    faParamBahnRadius: result := 'bpr';
    faParamBahnPositionX: result := 'bpx';
    faParamBahnPositionY: result := 'bpy';
    faParamBahnAngle: result := 'bpa';
    faParamBahnCylinderD: result := 'bcd';
    faParamBahnCylinderZ: result := 'bcz';

    { ExampleData }
    faExample01: result := 'e01';
    faExample02: result := 'e02';
    faExample03: result := 'e03';
    faExample04: result := 'e04';
    faExample05: result := 'e05';
    faExample06: result := 'e06';
    faExample07: result := 'e07';
    faExample08: result := 'e08';
    faExample09: result := 'e09';

    { SampleNavigation }
    faSampleM: result := 'S-';
    faSampleP: result := 'S+';
    faGotoSample1: result := 'gs1';

    { Help }
    faToggleHelp: result := 'th';
    faToggleReport: result := 'tr';
    faToggleButtonReport: result := 'bfr';
    faCycleHelpM: result := 'H';
    faCycleHelpP: result := 'h';
    faHelpCycle: result := 'hC';
    faHelpList: result := 'hL';
    faHelpHome: result := 'hh';

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

    { Language }
    faToggleLanguage: result := 'lan';

    { CopyPaste }
    faSave: result := 'sav';
    faLoad: result := 'loa';
    faOpen: result := 'ope';
    faCopy: result := '^c';
    faPaste: result := '^v';

    { ViewOptions }
    faToggleMoveMode: result := 'tmm';
    faLinearMove: result := 'lmm';
    faExpoMove: result := 'emm';
    faToggleOrbitMode: result := 'omt';

    { BitmapCycle }
    faCycleBitmapM: result := 'b-';
    faCycleBitmapP: result := 'b+';
    faRandom: result := 'ran';
    faRandomWhite: result := 'rcw';
    faRandomBlack: result := 'rcb';
    faRandomBambu1: result := 'rc1';
    faRandomBambu2: result := 'rc2';
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

    { FigureSize }
    faFigureSizeXS: result := '.XS';
    faFigureSizeS: result := '.S';
    faFigureSizeM: result := '.M';
    faFigureSizeL: result := '.L';
    faFigureSizeXL: result := '.XL';

    { EyeSize }
    faEyeSizeS: result := 'esS';
    faEyeSizeM: result := 'esM';
    faEyeSizeL: result := 'esL';

    { LayerSelection }
    faSelectLayer1: result := '.L1';
    faSelectLayer2: result := '.L2';
    faSelectLayer3: result := '.L3';
    faSelectLayer4: result := '.L4';
    faSelectLayer5: result := '.L5';
    faSelectLayer6: result := '.L6';
    faSelectLayer7: result := '.L7';

    { ColorSelection }
    faSelectColor1: result := '.C1';
    faSelectColor2: result := '.C2';
    faSelectColor3: result := '.C3';
    faSelectColor4: result := '.C4';

    { ColorMapping }
    faCLA: result := '.';
    faMapColorToLayer: result := 'c:l';
    faSelectColorMapping1: result := '.M1';
    faSelectColorMapping2: result := '.M2';
    faSelectColorMapping3: result := '.M3';
    faSelectColorMapping4: result := '.M4';
    faSelectColorMapping5: result := '.M5';
    faSelectColorMapping6: result := '.M6';
  end;
end;

end.
