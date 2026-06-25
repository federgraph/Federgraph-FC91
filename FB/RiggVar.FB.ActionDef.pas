unit RiggVar.FB.ActionDef;

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

const
  // --- generated code snippet ---

  { EmptyAction }
  fagNoop = 0;

  { Pages }
  fagActionPageM = 1;
  fagActionPageP = 2;
  fagActionPageE = 3;
  fagActionPageS = 4;
  fagActionPageX = 5;
  fagActionPage1 = 6;
  fagActionPage2 = 7;
  fagActionPage3 = 8;
  fagActionPage4 = 9;
  fagActionPage5 = 10;
  fagActionPage6 = 11;

  { Forms }
  fagShowMemo = 15;
  fagShowActions = 16;
  fagShowInfo = 21;

  { TouchLayout }
  fagTouchTablet = 45;
  fagTouchPhone = 46;
  fagTouchDesk = 47;

  { SystemParam }
  fagParamX1 = 95;
  fagParamY1 = 96;
  fagParamZ1 = 97;
  fagParamL1 = 98;
  fagParamK1 = 99;
  fagParamX2 = 100;
  fagParamY2 = 101;
  fagParamZ2 = 102;
  fagParamL2 = 103;
  fagParamK2 = 104;
  fagParamX3 = 105;
  fagParamY3 = 106;
  fagParamZ3 = 107;
  fagParamL3 = 108;
  fagParamK3 = 109;
  fagParamX4 = 110;
  fagParamY4 = 111;
  fagParamZ4 = 112;
  fagParamL4 = 113;
  fagParamK4 = 114;

  { OffsetParam }
  fagOffsetX = 1455;
  fagOffsetY = 1456;
  fagOffsetZ = 1457;

  { CoordParam }
  fagCoord0 = 115;
  fagCoord1 = 116;
  fagCoord2 = 117;
  fagCoord3 = 118;

  { LuxParam }
  fagParamL1X = 119;
  fagParamL1Y = 120;
  fagParamL1Z = 121;
  fagParamL2X = 122;
  fagParamL2Y = 123;
  fagParamL2Z = 124;
  fagParamL3X = 125;
  fagParamL3Y = 126;
  fagParamL3Z = 127;
  fagParamL4X = 128;
  fagParamL4Y = 129;
  fagParamL4Z = 130;

  { ParamCycle }
  fagCycleX = 136;
  fagCycleY = 137;
  fagCycleZ = 138;
  fagCycleL = 139;
  fagCycleK = 140;
  fagCycleO = 141;
  fagCycleR = 142;
  fagCycleT = 143;
  fagCycleU = 144;

  { ModelParams }
  fagParamR = 148;
  fagParamT = 149;
  fagParamL = 150;
  fagParamK = 151;
  fagParamZ = 152;
  fagParamA = 153;
  fagParamG = 154;
  fagParamX12 = 155;
  fagParamY12 = 156;
  fagParamZ12 = 157;
  fagParamY3F = 158;
  fagParamL3F = 159;
  fagParamLF = 160;

  { RingActions }
  fagBlindRingP = 203;
  fagBlindRingM = 204;
  fagCycleRingP = 205;
  fagCycleRingM = 206;
  fagToggleShirtColor = 208;
  fagShirtColorOn = 209;
  fagShirtColorOff = 210;
  fagApplyRingColor = 211;
  fagToggleShirtFarbe = 212;
  fagShirtFarbeOn = 213;
  fagShirtFarbeOff = 214;
  fagPixelCount1 = 215;
  fagPixelCount2 = 216;
  fagPixelCount4 = 217;

  { ParamBand }
  fagParamBandSelected = 218;
  fagParamBandCount = 219;
  fagParamBandDistributionX = 220;
  fagParamBandDistributionY = 221;
  fagParamBandWidth = 222;
  fagBandWidthAbsolute = 223;
  fagBandWidthRelative = 224;
  fagBandWidthContour = 225;

  { BlindRingSelection }
  fagBlindRing1 = 226;
  fagBlindRing5 = 227;
  fagBlindRingA = 228;
  fagBlindRingB = 229;
  fagBlindRingC = 230;
  fagBlindRingD = 231;
  fagBlindRingE = 232;
  fagBlindRingF = 233;

  { CurrentBand }
  fagShowCurrentBand0 = 234;
  fagShowCurrentBand1 = 235;
  fagShowCurrentBandT = 236;

  { BandSelection }
  fagBandSelectionM = 237;
  fagBandSelectionP = 238;
  fagBandSelection16 = 239;
  fagBandSelection17 = 240;
  fagBandSelection18 = 241;
  fagBandSelection19 = 242;
  fagBandSelection20 = 243;
  fagBandSelection21 = 244;

  { MeshSize }
  fagMeshSize4 = 272;
  fagMeshSize8 = 273;
  fagMeshSize16 = 274;
  fagMeshSize32 = 275;
  fagMeshSize64 = 276;
  fagMeshSize128 = 277;
  fagMeshSize256 = 278;
  fagMeshSize316 = 279;
  fagMeshSize512 = 280;

  { MeshExport }
  fagWantBottom = 1667;
  fagWantBottomMirrored = 1706;
  fagWantSideCaps = 1707;
  fagTestSingleSide = 1680;

  { MeshExportCoords }
  fagExportCoordsNative = 1547;
  fagExportCoordsBlender = 1548;
  fagExportCoords3DV = 1549;
  fagExportCoords3DP = 1550;

  { ExporterOBJ }
  fagWantAutoFolder = 1589;
  fagExportMtl = 1590;
  fagExportObj = 1491;
  fagWantMaterial = 1686;
  fagWantSimpleName = 1687;
  fagWantAngularDir = 1688;
  fagWantNormals = 1678;
  fagWantUVs = 1679;
  fagObjDigits2 = 1682;
  fagObjDigits3 = 1683;
  fagObjDigits4 = 1684;
  fagObjDigits5 = 1685;

  { MeshBuilderOptions }
  fagToggleSolidFlip = 1624;
  fagWantSpecialY = 1606;
  fagToggleShowEdges = 1616;
  fagUniqueMode1 = 1695;
  fagUniqueMode2 = 1696;
  fagToggleUniqueVertices = 1620;

  { ColorSwat }
  fagToggleColorSwat = 376;

  { Lux }
  fagToggleLux = 478;

  { Wheel }
  fagParamValuePlus1 = 493;
  fagParamValueMinus1 = 494;
  fagParamValuePlus10 = 495;
  fagParamValueMinus10 = 496;
  fagWheelLeft = 500;
  fagWheelRight = 501;
  fagWheelDown = 502;
  fagWheelUp = 503;

  { WheelFrequency }
  fagWheelFrequency1 = 1671;
  fagWheelFrequency01 = 1674;
  fagWheelFrequency001 = 1675;

  { ColorScheme }
  fagCycleColorSchemeM = 504;
  fagCycleColorSchemeP = 505;

  { UI }
  fagToggleColorPanel = 534;
  fagColorPanelOn = 535;
  fagColorPanelOff = 536;

  { FederText }
  fagToggleAllText = 552;
  fagToggleTouchFrame = 553;

  { ViewParams }
  fagPan = 554;
  fagParamRX = 558;
  fagParamRY = 559;
  fagParamRZ = 560;
  fagParamCZ = 561;

  { ParamT }
  fagParamT1 = 586;
  fagParamT2 = 587;
  fagParamT3 = 588;
  fagParamT4 = 589;

  { ViewFlags }
  fagToggleTouchMenu = 595;
  fagToggleEquationText = 596;
  fagTogglePrimeText = 597;
  fagToggleSecondText = 598;
  fagToggleLabelText = 599;
  fagLabelBatchM = 600;
  fagLabelBatchP = 601;
  fagLabelTextP = 602;
  fagLabelTextM = 603;

  { Bahn }
  fagNorthCap = 1700;
  fagSouthCap = 1701;
  fagParamCapValue = 712;

  { SampleNavigation }
  fagGotoSample1 = 771;

  { BtnLegendTablet }
  fagTL01 = 964;
  fagTL02 = 965;
  fagTL03 = 966;
  fagTL04 = 967;
  fagTL05 = 968;
  fagTL06 = 969;
  fagTR01 = 970;
  fagTR02 = 971;
  fagTR03 = 972;
  fagTR04 = 973;
  fagTR05 = 974;
  fagTR06 = 975;
  fagTR07 = 976;
  fagTR08 = 977;
  fagBL01 = 978;
  fagBL02 = 979;
  fagBL03 = 980;
  fagBL04 = 981;
  fagBL05 = 982;
  fagBL06 = 983;
  fagBL07 = 984;
  fagBL08 = 985;
  fagBR01 = 986;
  fagBR02 = 987;
  fagBR03 = 988;
  fagBR04 = 989;
  fagBR05 = 990;
  fagBR06 = 991;

  { BtnLegendPhone }
  fagMB01 = 992;
  fagMB02 = 993;
  fagMB03 = 994;
  fagMB04 = 995;
  fagMB05 = 996;
  fagMB06 = 997;
  fagMB07 = 998;
  fagMB08 = 999;

  { TouchBarLegend }
  fagTouchBarTop = 1000;
  fagTouchBarBottom = 1001;
  fagTouchBarLeft = 1002;
  fagTouchBarRight = 1003;

  { Reset }
  fagReset = 1033;
  fagResetPosition = 1034;
  fagResetRotation = 1035;
  fagResetZoom = 1036;

  { BitmapCycle }
  fagCycleBitmapM = 1055;
  fagCycleBitmapP = 1056;
  fagRandom = 1057;
  fagRandomWhite = 1058;
  fagRandomBlack = 1059;
  fagBitmapEscape = 1060;
  fagBitmapOne = 1061;
  fagToggleContour = 1062;

  { Layout0 }
  fagLayout0 = 1237;
  fagLayout1 = 1238;
  fagLayout2 = 1239;
  fagLayout3 = 1240;
  fagLayout4 = 1241;
  fagLayout5 = 1242;
  fagLayout6 = 1243;
  fagLayout7 = 1244;
  fagLayout8 = 1245;
  fagLayout9 = 1246;

  { ColorMapping }
  fagCLA = 1664;

  fagMax = 1665;

implementation

end.
