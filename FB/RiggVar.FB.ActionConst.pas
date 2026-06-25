unit RiggVar.FB.ActionConst;

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

type
  TFederAction = Integer;

const
  // --- generated code snippet ---

  { EmptyAction }
  faNoop = 0;

  { Pages }
  faActionPageM = 1;
  faActionPageP = 2;
  faActionPageE = 3;
  faActionPageS = 4;
  faActionPageX = 5;
  faActionPage1 = 6;
  faActionPage2 = 7;
  faActionPage3 = 8;
  faActionPage4 = 9;
  faActionPage5 = 10;
  faActionPage6 = 11;

  { Forms }
  faShowMemo = 12;
  faShowActions = 13;
  faShowInfo = 14;

  { TouchLayout }
  faTouchTablet = 15;
  faTouchPhone = 16;
  faTouchDesk = 17;

  { SystemParam }
  faParamX1 = 18;
  faParamY1 = 19;
  faParamZ1 = 20;
  faParamL1 = 21;
  faParamK1 = 22;
  faParamX2 = 23;
  faParamY2 = 24;
  faParamZ2 = 25;
  faParamL2 = 26;
  faParamK2 = 27;
  faParamX3 = 28;
  faParamY3 = 29;
  faParamZ3 = 30;
  faParamL3 = 31;
  faParamK3 = 32;
  faParamX4 = 33;
  faParamY4 = 34;
  faParamZ4 = 35;
  faParamL4 = 36;
  faParamK4 = 37;

  { OffsetParam }
  faOffsetX = 38;
  faOffsetY = 39;
  faOffsetZ = 40;

  { CoordParam }
  faCoord0 = 41;
  faCoord1 = 42;
  faCoord2 = 43;
  faCoord3 = 44;

  { LuxParam }
  faParamL1X = 45;
  faParamL1Y = 46;
  faParamL1Z = 47;
  faParamL2X = 48;
  faParamL2Y = 49;
  faParamL2Z = 50;
  faParamL3X = 51;
  faParamL3Y = 52;
  faParamL3Z = 53;
  faParamL4X = 54;
  faParamL4Y = 55;
  faParamL4Z = 56;

  { ParamCycle }
  faCycleX = 57;
  faCycleY = 58;
  faCycleZ = 59;
  faCycleL = 60;
  faCycleK = 61;
  faCycleO = 62;
  faCycleR = 63;
  faCycleT = 64;
  faCycleU = 65;

  { ModelParams }
  faParamR = 66;
  faParamT = 67;
  faParamL = 68;
  faParamK = 69;
  faParamZ = 70;
  faParamA = 71;
  faParamG = 72;
  faParamX12 = 73;
  faParamY12 = 74;
  faParamZ12 = 75;
  faParamY3F = 76;
  faParamL3F = 77;
  faParamLF = 78;

  { RingActions }
  faBlindRingP = 79;
  faBlindRingM = 80;
  faCycleRingP = 81;
  faCycleRingM = 82;
  faToggleShirtColor = 83;
  faShirtColorOn = 84;
  faShirtColorOff = 85;
  faApplyRingColor = 86;
  faToggleShirtFarbe = 87;
  faShirtFarbeOn = 88;
  faShirtFarbeOff = 89;
  faPixelCount1 = 90;
  faPixelCount2 = 91;
  faPixelCount4 = 92;

  { ParamBand }
  faParamBandSelected = 93;
  faParamBandCount = 94;
  faParamBandDistributionX = 95;
  faParamBandDistributionY = 96;
  faParamBandWidth = 97;
  faBandWidthAbsolute = 98;
  faBandWidthRelative = 99;
  faBandWidthContour = 100;

  { BlindRingSelection }
  faBlindRing1 = 101;
  faBlindRing5 = 102;
  faBlindRingA = 103;
  faBlindRingB = 104;
  faBlindRingC = 105;
  faBlindRingD = 106;
  faBlindRingE = 107;
  faBlindRingF = 108;

  { CurrentBand }
  faShowCurrentBand0 = 109;
  faShowCurrentBand1 = 110;
  faShowCurrentBandT = 111;

  { BandSelection }
  faBandSelectionM = 112;
  faBandSelectionP = 113;
  faBandSelection16 = 114;
  faBandSelection17 = 115;
  faBandSelection18 = 116;
  faBandSelection19 = 117;
  faBandSelection20 = 118;
  faBandSelection21 = 119;

  { MeshSize }
  faMeshSize4 = 120;
  faMeshSize8 = 121;
  faMeshSize16 = 122;
  faMeshSize32 = 123;
  faMeshSize64 = 124;
  faMeshSize128 = 125;
  faMeshSize256 = 126;
  faMeshSize316 = 127;
  faMeshSize512 = 128;

  { MeshExport }
  faWantBottom = 129;
  faWantBottomMirrored = 130;
  faWantSideCaps = 131;
  faTestSingleSide = 132;

  { MeshExportCoords }
  faExportCoordsNative = 133;
  faExportCoordsBlender = 134;
  faExportCoords3DV = 135;
  faExportCoords3DP = 136;

  { ExporterOBJ }
  faWantAutoFolder = 137;
  faExportMtl = 138;
  faExportObj = 139;
  faWantMaterial = 140;
  faWantSimpleName = 141;
  faWantAngularDir = 142;
  faWantNormals = 143;
  faWantUVs = 144;
  faObjDigits2 = 145;
  faObjDigits3 = 146;
  faObjDigits4 = 147;
  faObjDigits5 = 148;

  { MeshBuilderOptions }
  faToggleSolidFlip = 149;
  faWantSpecialY = 150;
  faToggleShowEdges = 151;
  faUniqueMode1 = 152;
  faUniqueMode2 = 153;
  faToggleUniqueVertices = 154;

  { ColorSwat }
  faToggleColorSwat = 155;

  { Lux }
  faToggleLux = 156;

  { Wheel }
  faParamValuePlus1 = 157;
  faParamValueMinus1 = 158;
  faParamValuePlus10 = 159;
  faParamValueMinus10 = 160;
  faWheelLeft = 161;
  faWheelRight = 162;
  faWheelDown = 163;
  faWheelUp = 164;

  { WheelFrequency }
  faWheelFrequency1 = 165;
  faWheelFrequency01 = 166;
  faWheelFrequency001 = 167;

  { ColorScheme }
  faCycleColorSchemeM = 168;
  faCycleColorSchemeP = 169;

  { UI }
  faToggleColorPanel = 170;
  faColorPanelOn = 171;
  faColorPanelOff = 172;

  { FederText }
  faToggleAllText = 173;
  faToggleTouchFrame = 174;

  { ViewParams }
  faPan = 175;
  faParamRX = 176;
  faParamRY = 177;
  faParamRZ = 178;
  faParamCZ = 179;

  { ParamT }
  faParamT1 = 180;
  faParamT2 = 181;
  faParamT3 = 182;
  faParamT4 = 183;

  { ViewFlags }
  faToggleTouchMenu = 184;
  faToggleEquationText = 185;
  faTogglePrimeText = 186;
  faToggleSecondText = 187;
  faToggleLabelText = 188;
  faLabelBatchM = 189;
  faLabelBatchP = 190;
  faLabelTextP = 191;
  faLabelTextM = 192;

  { Bahn }
  faNorthCap = 193;
  faSouthCap = 194;
  faParamCapValue = 195;

  { SampleNavigation }
  faGotoSample1 = 196;

  { BtnLegendTablet }
  faTL01 = 197;
  faTL02 = 198;
  faTL03 = 199;
  faTL04 = 200;
  faTL05 = 201;
  faTL06 = 202;
  faTR01 = 203;
  faTR02 = 204;
  faTR03 = 205;
  faTR04 = 206;
  faTR05 = 207;
  faTR06 = 208;
  faTR07 = 209;
  faTR08 = 210;
  faBL01 = 211;
  faBL02 = 212;
  faBL03 = 213;
  faBL04 = 214;
  faBL05 = 215;
  faBL06 = 216;
  faBL07 = 217;
  faBL08 = 218;
  faBR01 = 219;
  faBR02 = 220;
  faBR03 = 221;
  faBR04 = 222;
  faBR05 = 223;
  faBR06 = 224;

  { BtnLegendPhone }
  faMB01 = 225;
  faMB02 = 226;
  faMB03 = 227;
  faMB04 = 228;
  faMB05 = 229;
  faMB06 = 230;
  faMB07 = 231;
  faMB08 = 232;

  { TouchBarLegend }
  faTouchBarTop = 233;
  faTouchBarBottom = 234;
  faTouchBarLeft = 235;
  faTouchBarRight = 236;

  { Reset }
  faReset = 237;
  faResetPosition = 238;
  faResetRotation = 239;
  faResetZoom = 240;

  { BitmapCycle }
  faCycleBitmapM = 241;
  faCycleBitmapP = 242;
  faRandom = 243;
  faRandomWhite = 244;
  faRandomBlack = 245;
  faBitmapEscape = 246;
  faBitmapOne = 247;
  faToggleContour = 248;

  { Layout0 }
  faLayout0 = 249;
  faLayout1 = 250;
  faLayout2 = 251;
  faLayout3 = 252;
  faLayout4 = 253;
  faLayout5 = 254;
  faLayout6 = 255;
  faLayout7 = 256;
  faLayout8 = 257;
  faLayout9 = 258;

  { ColorMapping }
  faCLA = 259;

  faMax = 260;

implementation

end.
