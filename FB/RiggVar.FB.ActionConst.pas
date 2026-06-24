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

  { SystemParam }
  faParamX1 = 12;
  faParamY1 = 13;
  faParamZ1 = 14;
  faParamL1 = 15;
  faParamK1 = 16;
  faParamX2 = 17;
  faParamY2 = 18;
  faParamZ2 = 19;
  faParamL2 = 20;
  faParamK2 = 21;
  faParamX3 = 22;
  faParamY3 = 23;
  faParamZ3 = 24;
  faParamL3 = 25;
  faParamK3 = 26;
  faParamX4 = 27;
  faParamY4 = 28;
  faParamZ4 = 29;
  faParamL4 = 30;
  faParamK4 = 31;

  { OffsetParam }
  faOffsetX = 32;
  faOffsetY = 33;
  faOffsetZ = 34;

  { CoordParam }
  faCoord0 = 35;
  faCoord1 = 36;
  faCoord2 = 37;
  faCoord3 = 38;

  { LuxParam }
  faParamL1X = 39;
  faParamL1Y = 40;
  faParamL1Z = 41;
  faParamL2X = 42;
  faParamL2Y = 43;
  faParamL2Z = 44;
  faParamL3X = 45;
  faParamL3Y = 46;
  faParamL3Z = 47;
  faParamL4X = 48;
  faParamL4Y = 49;
  faParamL4Z = 50;

  { ParamCycle }
  faCycleX = 51;
  faCycleY = 52;
  faCycleZ = 53;
  faCycleL = 54;
  faCycleK = 55;
  faCycleO = 56;
  faCycleR = 57;
  faCycleT = 58;
  faCycleU = 59;

  { ModelParams }
  faParamR = 60;
  faParamT = 61;
  faParamL = 62;
  faParamK = 63;
  faParamZ = 64;
  faParamA = 65;
  faParamG = 66;
  faParamX12 = 67;
  faParamY12 = 68;
  faParamZ12 = 69;
  faParamY3F = 70;
  faParamL3F = 71;
  faParamLF = 72;

  { RingActions }
  faBlindRingP = 73;
  faBlindRingM = 74;
  faCycleRingP = 75;
  faCycleRingM = 76;
  faToggleShirtColor = 77;
  faShirtColorOn = 78;
  faShirtColorOff = 79;
  faApplyRingColor = 80;
  faToggleShirtFarbe = 81;
  faShirtFarbeOn = 82;
  faShirtFarbeOff = 83;
  faPixelCount1 = 84;
  faPixelCount2 = 85;
  faPixelCount4 = 86;

  { ParamBand }
  faParamBandSelected = 87;
  faParamBandCount = 88;
  faParamBandDistributionX = 89;
  faParamBandDistributionY = 90;
  faParamBandWidth = 91;
  faBandWidthAbsolute = 92;
  faBandWidthRelative = 93;
  faBandWidthContour = 94;

  { BlindRingSelection }
  faBlindRing1 = 95;
  faBlindRing5 = 96;
  faBlindRingA = 97;
  faBlindRingB = 98;
  faBlindRingC = 99;
  faBlindRingD = 100;
  faBlindRingE = 101;
  faBlindRingF = 102;

  { CurrentBand }
  faShowCurrentBand0 = 103;
  faShowCurrentBand1 = 104;
  faShowCurrentBandT = 105;

  { BandSelection }
  faBandSelectionM = 106;
  faBandSelectionP = 107;
  faBandSelection16 = 108;
  faBandSelection17 = 109;
  faBandSelection18 = 110;
  faBandSelection19 = 111;
  faBandSelection20 = 112;
  faBandSelection21 = 113;

  { MeshSize }
  faMeshSize4 = 114;
  faMeshSize8 = 115;
  faMeshSize16 = 116;
  faMeshSize32 = 117;
  faMeshSize64 = 118;
  faMeshSize128 = 119;
  faMeshSize256 = 120;
  faMeshSize316 = 121;
  faMeshSize512 = 122;

  { MeshExport }
  faWantBottom = 123;
  faWantBottomMirrored = 124;
  faWantSideCaps = 125;
  faTestSingleSide = 126;

  { MeshExportCoords }
  faExportCoordsNative = 127;
  faExportCoordsBlender = 128;
  faExportCoords3DV = 129;
  faExportCoords3DP = 130;

  { ExporterOBJ }
  faWantAutoFolder = 131;
  faExportMtl = 132;
  faExportObj = 133;
  faWantMaterial = 134;
  faWantSimpleName = 135;
  faWantAngularDir = 136;
  faWantNormals = 137;
  faWantUVs = 138;
  faObjDigits2 = 139;
  faObjDigits3 = 140;
  faObjDigits4 = 141;
  faObjDigits5 = 142;

  { MeshBuilderOptions }
  faToggleSolidFlip = 143;
  faWantSpecialY = 144;
  faToggleShowEdges = 145;
  faUniqueMode1 = 146;
  faUniqueMode2 = 147;
  faToggleUniqueVertices = 148;

  { ColorSwat }
  faToggleColorSwat = 149;

  { Lux }
  faToggleLux = 150;

  { Wheel }
  faParamValuePlus1 = 151;
  faParamValueMinus1 = 152;
  faParamValuePlus10 = 153;
  faParamValueMinus10 = 154;
  faWheelLeft = 155;
  faWheelRight = 156;
  faWheelDown = 157;
  faWheelUp = 158;

  { WheelFrequency }
  faWheelFrequency1 = 159;
  faWheelFrequency01 = 160;
  faWheelFrequency001 = 161;

  { ColorScheme }
  faCycleColorSchemeM = 162;
  faCycleColorSchemeP = 163;

  { UI }
  faToggleColorPanel = 164;

  { ViewParams }
  faPan = 165;
  faParamRX = 166;
  faParamRY = 167;
  faParamRZ = 168;
  faParamCZ = 169;

  { ParamT }
  faParamT1 = 170;
  faParamT2 = 171;
  faParamT3 = 172;
  faParamT4 = 173;

  { Bahn }
  faNorthCap = 174;
  faSouthCap = 175;
  faParamCapValue = 176;

  { Reset }
  faReset = 177;
  faResetPosition = 178;
  faResetRotation = 179;
  faResetZoom = 180;

  { BitmapCycle }
  faCycleBitmapM = 181;
  faCycleBitmapP = 182;
  faRandom = 183;
  faRandomWhite = 184;
  faRandomBlack = 185;
  faBitmapEscape = 186;
  faBitmapOne = 187;
  faToggleContour = 188;

  faMax = 189;

implementation

end.
