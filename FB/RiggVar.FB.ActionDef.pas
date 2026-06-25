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
  fagShowImage = 1677;
  fagShowMemo = 15;
  fagShowActions = 16;
  fagShowColor = 1446;
  fagShowBambu = 1661;
  fagShowAnim = 30;
  fagEditText = 31;
  fagEditConn = 32;
  fagEditHost = 33;
  fagEditPort = 34;
  fagShowRepo = 38;
  fagShowInfo = 21;

  { TouchLayout }
  fagTouchTablet = 45;
  fagTouchPhone = 46;
  fagTouchDesk = 47;

  { ActionMapping }
  fagProcessAll = 1663;

  { Scene }
  fagScene1 = 48;
  fagScene2 = 49;
  fagScene3 = 50;
  fagScene4 = 51;
  fagScene5 = 52;

  { Plot }
  fagPlot0 = 53;
  fagPlot1 = 54;
  fagPlot2 = 55;
  fagPlot3 = 56;
  fagPlot4 = 57;
  fagPlot5 = 58;
  fagPlot6 = 59;
  fagPlot7 = 60;
  fagPlot8 = 61;
  fagPlot9 = 62;
  fagPlot10 = 63;
  fagPlot11 = 64;
  fagPlot12 = 65;
  fagPlot13 = 66;

  { Figure }
  fagFigure1 = 67;
  fagFigure2 = 68;
  fagFigure3 = 69;
  fagFigure4 = 70;
  fagFigure5 = 71;
  fagFigure6 = 72;

  { Graph }
  fagGraph1 = 73;
  fagGraph2 = 74;
  fagGraph3 = 75;
  fagGraph4 = 76;
  fagGraph5 = 77;

  { Color }
  fagColor0 = 78;
  fagColor1 = 79;
  fagColor2 = 80;
  fagColor3 = 81;
  fagColor4 = 82;
  fagColor5 = 83;
  fagColor6 = 84;

  { Param }
  fagParam0 = 85;
  fagParam1 = 86;
  fagParam2 = 87;
  fagParam3 = 88;
  fagParam4 = 89;
  fagParam5 = 90;
  fagParam6 = 91;
  fagParam7 = 92;
  fagParam8 = 93;
  fagParam9 = 94;

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

  { ModelOptions }
  fagToggleSolutionMode = 166;
  fagToggleVorzeichen = 167;
  fagToggleLinearForce = 168;
  fagToggleGleich = 169;
  fagToggleMCap = 170;
  fagTogglePCap = 171;
  fagForceZ0 = 172;
  fagWantZ12 = 173;
  fagDiff0 = 174;
  fagDiff1 = 175;
  fagDiff10 = 176;

  { OptionCycle }
  fagCyclePlotM = 177;
  fagCyclePlotP = 178;
  fagCycleGraphM = 179;
  fagCycleGraphP = 180;
  fagCycleFigureM = 181;
  fagCycleFigureP = 182;

  { ForceMode }
  fagForceMode0 = 187;
  fagForceMode1 = 188;
  fagForceMode2 = 189;

  { FederMode }
  fagM1 = 190;
  fagM2 = 191;
  fagM3 = 192;

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

  { MeshMode }
  fagOpenMesh = 264;
  fagPolarMesh = 265;
  fagReducedMesh = 267;
  fagReduceMode0 = 268;
  fagReduceMode1 = 269;
  fagReduceMode2 = 270;
  fagReduceMode3 = 271;

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
  fagMeshSize1024 = 281;

  { MeshExport }
  fagWantBottom = 1667;
  fagWantBottomMirrored = 1706;
  fagWantSideCaps = 1707;
  fagTestSingleSide = 1680;
  fagTakeCapValueSnapshot = 1669;

  { MeshExportCoords }
  fagExportCoordsNative = 1547;
  fagExportCoordsBlender = 1548;
  fagExportCoords3DV = 1549;
  fagExportCoords3DP = 1550;

  { MeshOptions }
  fagTextureJitt = 301;
  fagTextureJack = 302;

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

  { MeshFigures }
  fagToggleMarker = 292;
  fagToggleGrid = 293;
  fagToggleGridFrequency = 294;
  fagToggleDiameter3 = 697;
  fagDiameter3On = 698;
  fagDiameter3Off = 699;
  fagToggleCylinder = 295;
  fagToggleCube = 296;
  fagToggleCorner = 297;
  fagToggleLimitPlane = 298;

  { VertexPulling }
  fagToggleZeroPulling = 314;
  fagToggleLimitPulling = 315;
  fagToggleSlicePulling = 316;
  fagToggleTargetPulling = 317;
  fagToggleRightPulling = 318;
  fagToggleCrackFixing = 1668;

  { MeshBuilderOptions }
  fagToggleSolidFlip = 1624;
  fagWantSpecialY = 1606;
  fagToggleShowEdges = 1616;
  fagUniqueMode1 = 1695;
  fagUniqueMode2 = 1696;
  fagToggleUniqueVertices = 1620;

  { Pin }
  fagTogglePin = 352;
  fagPinOn = 353;
  fagPinOff = 354;

  { Norm }
  fagToggleNorm = 355;
  fagNormOn = 356;
  fagNormOff = 357;

  { TextureNorm }
  fagTextureNormP = 358;
  fagTextureNormM = 359;
  fagTextureNorm0 = 360;
  fagTextureNorm1 = 361;
  fagTextureNorm2 = 362;

  { TextureExport }
  fagCopyBinCode = 363;
  fagCopyBinCodeTest = 364;

  { TextureImport }
  fagTextureClear = 367;

  { ColorMix }
  fagColorMix0 = 368;
  fagColorMix1 = 369;
  fagColorMix2 = 370;
  fagColorMix3 = 371;
  fagColorMix4 = 372;
  fagColorMix5 = 373;
  fagColorMixP = 374;
  fagColorMixM = 375;

  { ColorSwat }
  fagToggleColorSwat = 376;

  { Lux }
  fagLux1On = 464;
  fagLux1Off = 465;
  fagToggleLux1 = 466;
  fagLux2On = 467;
  fagLux2Off = 468;
  fagToggleLux2 = 469;
  fagLux3On = 470;
  fagLux3Off = 471;
  fagToggleLux3 = 472;
  fagLux4On = 473;
  fagLux4Off = 474;
  fagToggleLux4 = 475;
  fagLuxOn = 476;
  fagLuxOff = 477;
  fagToggleLux = 478;

  { LuxMarker }
  fagLuxMarkerOn = 479;
  fagLuxMarkerOff = 480;
  fagToggleLuxMarker = 481;

  { LightMode }
  fagLightMode0 = 482;
  fagLightMode1 = 483;
  fagLightMode2 = 484;
  fagLightMode3 = 485;
  fagLightMode4 = 486;

  { ResetLight }
  fagResetLightPosition = 487;
  fagResetLightParams = 488;

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
  fagWheelFrequency05 = 1672;
  fagWheelFrequency02 = 1673;
  fagWheelFrequency01 = 1674;
  fagWheelFrequency001 = 1675;
  fagWheelFrequency0001 = 1676;

  { ColorScheme }
  fagCycleColorSchemeM = 504;
  fagCycleColorSchemeP = 505;

  { AnimatedRotations }
  fagRotX = 562;
  fagRotY = 563;
  fagRotZ = 515;
  fagRotXM = 564;
  fagRotXP = 565;
  fagRotYM = 566;
  fagRotYP = 567;
  fagRotZM = 513;
  fagRotZP = 514;

  { Step }
  fagStepRXM = 516;
  fagStepRXP = 517;
  fagStepRYM = 518;
  fagStepRYP = 519;
  fagStepRZM = 520;
  fagStepRZP = 521;
  fagStepCZM = 522;
  fagStepCZP = 523;

  { Keyboard }
  fagKeyboard01 = 524;
  fagKeyboard02 = 525;
  fagSetShift = 526;
  fagSetCtrl = 527;
  fagClearShift = 528;

  { UI }
  fagParamLabelTextX = 529;
  fagParamLabelTextY = 530;
  fagParamLabelTextZ = 531;
  fagToggleColorPanel = 534;
  fagColorPanelOn = 535;
  fagColorPanelOff = 536;
  fagShowEditField = 538;
  fagFocusEditField = 539;
  fagInitSpecial = 540;
  fagPaletteOn = 532;
  fagPaletteOff = 533;

  { Locks }
  fagToggleLuxLock = 542;
  fagToggleParamLock = 543;
  fagToggleTextureLock = 544;
  fagToggleBackgroundLock = 545;
  fagToggleForceLock = 546;
  fagToggleReportLock = 1670;

  { Opacity }
  fagToggleOpacity = 547;
  fagOpacityOn = 548;
  fagOpacityOff = 549;

  { MainMenuActivation }
  fagMainMenuHide = 550;
  fagMainMenuShow = 551;

  { FederText }
  fagToggleAllText = 552;
  fagToggleTouchFrame = 553;

  { ViewParams }
  fagPan = 554;
  fagParamRX = 558;
  fagParamRY = 559;
  fagParamRZ = 560;
  fagParamCZ = 561;

  { ViewParamsFC }
  fagRotStep0 = 568;
  fagRotStep1 = 569;
  fagRotStep2 = 570;
  fagRotStep3 = 571;
  fagRotStepA = 572;
  fagParamTRS = 577;
  fagParamTRT = 578;
  fagParamTRX = 579;
  fagParamTRY = 580;

  { ParamT }
  fagParamT1 = 586;
  fagParamT2 = 587;
  fagParamT3 = 588;
  fagParamT4 = 589;

  { ViewFlags }
  fagToggleBMap = 590;
  fagToggleZoom = 591;
  fagToggleTouchMenu = 595;
  fagToggleEquationText = 596;
  fagTogglePrimeText = 597;
  fagToggleSecondText = 598;
  fagToggleLabelText = 599;
  fagLabelBatchM = 600;
  fagLabelBatchP = 601;
  fagLabelTextP = 602;
  fagLabelTextM = 603;

  { Report }
  fagCopyShortCutReport = 615;
  fagWriteActionReport = 616;
  fagWriteActionTable = 617;
  fagWriteActionConst = 618;
  fagWriteActionNames = 619;
  fagWriteVersion1 = 620;
  fagWriteVersion2 = 621;
  fagWriteCode = 622;
  fagWriteDiff1 = 623;
  fagWriteDiffCode = 624;
  fagWriteDiffBin = 625;
  fagWriteBandInfo3 = 626;
  fagWriteBandInfo5 = 627;
  fagWriteEquationInfo = 628;
  fagWriteVirtual = 629;
  fagBlockTest = 630;

  { ReportOptions }
  fagSourcePascal = 631;
  fagSourceMaxima = 632;
  fagSourceMaple = 633;
  fagSourceMathematica = 634;

  { CopyImage }
  fagCopyScreenshot = 635;
  fagCopyBitmap3D = 638;
  fagCopyTextureBitmap = 639;
  fagCopyImprintedBitmap = 640;
  fagCopyImprintedBitmapTest = 641;

  { CopyOptions }
  fagToggleHardCopy = 653;
  fagHardCopyOn = 654;
  fagHardCopyOff = 655;
  fagTogglePngCopy = 656;
  fagPngCopyOn = 657;
  fagPngCopyOff = 658;
  fagToggleNoCopy = 659;
  fagNoCopyOn = 660;
  fagNoCopyOff = 661;

  { GraphOptions }
  fagToggleDiameter = 696;
  fagToggleProbe = 700;

  { Bahn }
  fagNorthCap = 1700;
  fagSouthCap = 1701;
  fagEastCap = 1705;
  fagWestCap = 1704;
  fagParamCapValue = 712;
  fagParamBahnRadius = 714;
  fagParamBahnPositionX = 715;
  fagParamBahnPositionY = 716;
  fagParamBahnAngle = 717;
  fagParamBahnCylinderD = 721;
  fagParamBahnCylinderZ = 722;

  { AnimationStore }
  fagRecall1 = 733;
  fagRecall2 = 734;
  fagMemory1 = 735;
  fagMemory2 = 736;
  fagTransit = 737;

  { AnimPlay }
  fagPlay = 738;
  fagExecute = 739;
  fagAnimationStop = 740;
  fagAnimationStartA = 741;
  fagAnimationStartD = 742;
  fagAnimationStartF = 743;
  fagAnimationStartS = 744;
  fagAnimationStartT = 745;

  { Transit }
  fagTransitionAll = 746;
  fagTransitionScript = 747;

  { Connect }
  fagConnect = 748;
  fagDisconnect = 749;
  fagDownload = 750;
  fagAutoSend = 751;
  fagAutoSendOn = 752;
  fagAutoSendOff = 753;

  { ExampleData }
  fagExample01 = 1526;
  fagExample02 = 1527;
  fagExample03 = 1528;
  fagExample04 = 1529;
  fagExample05 = 1530;
  fagExample06 = 1531;
  fagExample07 = 1532;
  fagExample08 = 1533;
  fagExample09 = 1534;

  { Repo }
  fagSwapBundle = 757;
  fagRepo010 = 758;
  fagRepo020 = 759;
  fagRepo050 = 760;

  { SampleNavigation }
  fagLevelM = 764;
  fagLevelP = 765;
  fagHubM = 766;
  fagHubP = 767;
  fagSampleM = 768;
  fagSampleP = 769;
  fagGotoSample0 = 770;
  fagGotoSample1 = 771;

  { DebugOptions }
  fagTestBtnClick = 796;
  fagRunBinPixelTest = 799;

  { EmptyLastLine }
  fagELLOn = 800;
  fagELLOff = 801;

  { Help }
  fagToggleHelp = 802;
  fagToggleReport = 803;
  fagToggleButtonReport = 804;
  fagCycleHelpM = 805;
  fagCycleHelpP = 806;
  fagHelpCycle = 807;
  fagHelpList = 808;
  fagHelpHome = 809;

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

  { DropTarget }
  fagToggleDropTarget = 1040;

  { Language }
  fagToggleLanguage = 1041;

  { CopyPaste }
  fagSave = 1042;
  fagLoad = 1043;
  fagOpen = 1044;
  fagCopy = 1045;
  fagPaste = 1046;

  { ViewOptions }
  fagToggleMoveMode = 1048;
  fagLinearMove = 1049;
  fagExpoMove = 1050;
  fagToggleQuickMesh = 1051;
  fagToggleOrbitMode = 1708;

  { BitmapCycle }
  fagCycleBitmapM = 1055;
  fagCycleBitmapP = 1056;
  fagRandom = 1057;
  fagRandomWhite = 1058;
  fagRandomBlack = 1059;
  fagRandomBambu1 = 1665;
  fagRandomBambu2 = 1666;
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

  { Layout1 }
  fagLayout10 = 1247;
  fagLayout11 = 1248;
  fagLayout12 = 1249;
  fagLayout13 = 1250;
  fagLayout14 = 1251;
  fagLayout15 = 1252;
  fagLayout16 = 1253;
  fagLayout17 = 1254;
  fagLayout18 = 1255;
  fagLayout19 = 1256;

  { Layout2 }
  fagLayout20 = 1257;
  fagLayout21 = 1258;
  fagLayout22 = 1259;
  fagLayout23 = 1260;
  fagLayout24 = 1261;
  fagLayout25 = 1262;
  fagLayout26 = 1263;
  fagLayout27 = 1264;
  fagLayout28 = 1265;
  fagLayout29 = 1266;

  { Layout3 }
  fagLayout30 = 1267;
  fagLayout31 = 1268;
  fagLayout32 = 1269;
  fagLayout33 = 1270;
  fagLayout34 = 1271;
  fagLayout35 = 1272;
  fagLayout36 = 1273;
  fagLayout37 = 1274;
  fagLayout38 = 1275;
  fagLayout39 = 1276;

  { Layout4 }
  fagLayout40 = 1277;
  fagLayout41 = 1278;
  fagLayout42 = 1279;
  fagLayout43 = 1280;
  fagLayout44 = 1281;
  fagLayout45 = 1282;
  fagLayout46 = 1283;
  fagLayout47 = 1284;
  fagLayout48 = 1285;
  fagLayout49 = 1286;

  { Layout5 }
  fagLayout50 = 1287;
  fagLayout51 = 1288;
  fagLayout52 = 1289;
  fagLayout53 = 1290;
  fagLayout54 = 1291;
  fagLayout55 = 1292;
  fagLayout56 = 1293;
  fagLayout57 = 1294;
  fagLayout58 = 1295;
  fagLayout59 = 1296;

  { Layout6 }
  fagLayout60 = 1297;
  fagLayout61 = 1298;
  fagLayout62 = 1299;
  fagLayout63 = 1300;
  fagLayout64 = 1301;
  fagLayout65 = 1302;
  fagLayout66 = 1303;
  fagLayout67 = 1304;
  fagLayout68 = 1305;
  fagLayout69 = 1306;

  { Layout7 }
  fagLayout70 = 1307;
  fagLayout71 = 1308;
  fagLayout72 = 1309;
  fagLayout73 = 1310;
  fagLayout74 = 1311;
  fagLayout75 = 1312;
  fagLayout76 = 1313;
  fagLayout77 = 1314;
  fagLayout78 = 1315;
  fagLayout79 = 1316;

  { Layout8 }
  fagLayout80 = 1317;
  fagLayout81 = 1318;
  fagLayout82 = 1319;
  fagLayout83 = 1320;
  fagLayout84 = 1321;
  fagLayout85 = 1322;
  fagLayout86 = 1323;
  fagLayout87 = 1324;
  fagLayout88 = 1325;
  fagLayout89 = 1326;

  { Layout9 }
  fagLayout90 = 1327;
  fagLayout91 = 1328;
  fagLayout92 = 1329;
  fagLayout93 = 1330;
  fagLayout94 = 1331;
  fagLayout95 = 1332;
  fagLayout96 = 1333;
  fagLayout97 = 1334;
  fagLayout98 = 1335;
  fagLayout99 = 1336;

  { MenuNav }
  fagMenuXX = 1340;
  fagMenu00 = 1341;
  fagMenu10 = 1342;
  fagMenu20 = 1343;
  fagMenu30 = 1344;
  fagMenu40 = 1345;
  fagMenu50 = 1346;
  fagMenu60 = 1347;
  fagMenu70 = 1348;
  fagMenu80 = 1349;
  fagMenu90 = 1350;

  { FigureSize }
  fagFigureSizeXS = 1636;
  fagFigureSizeS = 1637;
  fagFigureSizeM = 1638;
  fagFigureSizeL = 1639;
  fagFigureSizeXL = 1640;

  { EyeSize }
  fagEyeSizeS = 1641;
  fagEyeSizeM = 1642;
  fagEyeSizeL = 1643;

  { LayerSelection }
  fagSelectLayer1 = 1644;
  fagSelectLayer2 = 1645;
  fagSelectLayer3 = 1646;
  fagSelectLayer4 = 1647;
  fagSelectLayer5 = 1648;
  fagSelectLayer6 = 1649;
  fagSelectLayer7 = 1650;

  { ColorSelection }
  fagSelectColor1 = 1651;
  fagSelectColor2 = 1652;
  fagSelectColor3 = 1653;
  fagSelectColor4 = 1654;

  { ColorMapping }
  fagCLA = 1664;
  fagMapColorToLayer = 1662;
  fagSelectColorMapping1 = 1655;
  fagSelectColorMapping2 = 1656;
  fagSelectColorMapping3 = 1657;
  fagSelectColorMapping4 = 1658;
  fagSelectColorMapping5 = 1659;
  fagSelectColorMapping6 = 1660;

  fagMax = 1661;

implementation

end.
