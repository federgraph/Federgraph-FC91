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

  { ActionMapping }
  faProcessAll = 18;

  { Scene }
  faScene1 = 19;
  faScene2 = 20;
  faScene3 = 21;
  faScene4 = 22;
  faScene5 = 23;

  { Plot }
  faPlot0 = 24;
  faPlot1 = 25;
  faPlot2 = 26;
  faPlot3 = 27;
  faPlot4 = 28;
  faPlot5 = 29;
  faPlot6 = 30;
  faPlot7 = 31;
  faPlot8 = 32;
  faPlot9 = 33;
  faPlot10 = 34;
  faPlot11 = 35;
  faPlot12 = 36;
  faPlot13 = 37;

  { Figure }
  faFigure1 = 38;
  faFigure2 = 39;
  faFigure3 = 40;
  faFigure4 = 41;
  faFigure5 = 42;
  faFigure6 = 43;

  { Graph }
  faGraph1 = 44;
  faGraph2 = 45;
  faGraph3 = 46;
  faGraph4 = 47;
  faGraph5 = 48;

  { Color }
  faColor0 = 49;
  faColor1 = 50;
  faColor2 = 51;
  faColor3 = 52;
  faColor4 = 53;
  faColor5 = 54;
  faColor6 = 55;

  { Param }
  faParam0 = 56;
  faParam1 = 57;
  faParam2 = 58;
  faParam3 = 59;
  faParam4 = 60;
  faParam5 = 61;
  faParam6 = 62;
  faParam7 = 63;
  faParam8 = 64;
  faParam9 = 65;

  { SystemParam }
  faParamX1 = 66;
  faParamY1 = 67;
  faParamZ1 = 68;
  faParamL1 = 69;
  faParamK1 = 70;
  faParamX2 = 71;
  faParamY2 = 72;
  faParamZ2 = 73;
  faParamL2 = 74;
  faParamK2 = 75;
  faParamX3 = 76;
  faParamY3 = 77;
  faParamZ3 = 78;
  faParamL3 = 79;
  faParamK3 = 80;
  faParamX4 = 81;
  faParamY4 = 82;
  faParamZ4 = 83;
  faParamL4 = 84;
  faParamK4 = 85;

  { OffsetParam }
  faOffsetX = 86;
  faOffsetY = 87;
  faOffsetZ = 88;

  { CoordParam }
  faCoord0 = 89;
  faCoord1 = 90;
  faCoord2 = 91;
  faCoord3 = 92;

  { LuxParam }
  faParamL1X = 93;
  faParamL1Y = 94;
  faParamL1Z = 95;
  faParamL2X = 96;
  faParamL2Y = 97;
  faParamL2Z = 98;
  faParamL3X = 99;
  faParamL3Y = 100;
  faParamL3Z = 101;
  faParamL4X = 102;
  faParamL4Y = 103;
  faParamL4Z = 104;

  { ParamCycle }
  faCycleX = 105;
  faCycleY = 106;
  faCycleZ = 107;
  faCycleL = 108;
  faCycleK = 109;
  faCycleO = 110;
  faCycleR = 111;
  faCycleT = 112;
  faCycleU = 113;

  { ModelParams }
  faParamR = 114;
  faParamT = 115;
  faParamL = 116;
  faParamK = 117;
  faParamZ = 118;
  faParamA = 119;
  faParamG = 120;
  faParamX12 = 121;
  faParamY12 = 122;
  faParamZ12 = 123;
  faParamY3F = 124;
  faParamL3F = 125;
  faParamLF = 126;

  { ModelOptions }
  faToggleSolutionMode = 127;
  faToggleVorzeichen = 128;
  faToggleLinearForce = 129;
  faToggleGleich = 130;
  faToggleMCap = 131;
  faTogglePCap = 132;
  faForceZ0 = 133;
  faWantZ12 = 134;
  faDiff0 = 135;
  faDiff1 = 136;
  faDiff10 = 137;

  { OptionCycle }
  faCyclePlotM = 138;
  faCyclePlotP = 139;
  faCycleGraphM = 140;
  faCycleGraphP = 141;
  faCycleFigureM = 142;
  faCycleFigureP = 143;

  { ForceMode }
  faForceMode0 = 144;
  faForceMode1 = 145;
  faForceMode2 = 146;

  { FederMode }
  faM1 = 147;
  faM2 = 148;
  faM3 = 149;

  { RingActions }
  faBlindRingP = 150;
  faBlindRingM = 151;
  faCycleRingP = 152;
  faCycleRingM = 153;
  faToggleShirtColor = 154;
  faShirtColorOn = 155;
  faShirtColorOff = 156;
  faApplyRingColor = 157;
  faToggleShirtFarbe = 158;
  faShirtFarbeOn = 159;
  faShirtFarbeOff = 160;
  faPixelCount1 = 161;
  faPixelCount2 = 162;
  faPixelCount4 = 163;

  { ParamBand }
  faParamBandSelected = 164;
  faParamBandCount = 165;
  faParamBandDistributionX = 166;
  faParamBandDistributionY = 167;
  faParamBandWidth = 168;
  faBandWidthAbsolute = 169;
  faBandWidthRelative = 170;
  faBandWidthContour = 171;

  { BlindRingSelection }
  faBlindRing1 = 172;
  faBlindRing5 = 173;
  faBlindRingA = 174;
  faBlindRingB = 175;
  faBlindRingC = 176;
  faBlindRingD = 177;
  faBlindRingE = 178;
  faBlindRingF = 179;

  { CurrentBand }
  faShowCurrentBand0 = 180;
  faShowCurrentBand1 = 181;
  faShowCurrentBandT = 182;

  { BandSelection }
  faBandSelectionM = 183;
  faBandSelectionP = 184;
  faBandSelection16 = 185;
  faBandSelection17 = 186;
  faBandSelection18 = 187;
  faBandSelection19 = 188;
  faBandSelection20 = 189;
  faBandSelection21 = 190;

  { MeshMode }
  faReducedMesh = 191;
  faReduceMode0 = 192;
  faReduceMode1 = 193;
  faReduceMode2 = 194;
  faReduceMode3 = 195;

  { MeshSize }
  faMeshSize4 = 196;
  faMeshSize8 = 197;
  faMeshSize16 = 198;
  faMeshSize32 = 199;
  faMeshSize64 = 200;
  faMeshSize128 = 201;
  faMeshSize256 = 202;
  faMeshSize316 = 203;
  faMeshSize512 = 204;

  { MeshExport }
  faWantBottom = 205;
  faWantBottomMirrored = 206;
  faWantSideCaps = 207;
  faTestSingleSide = 208;
  faTakeCapValueSnapshot = 209;

  { MeshExportCoords }
  faExportCoordsNative = 210;
  faExportCoordsBlender = 211;
  faExportCoords3DV = 212;
  faExportCoords3DP = 213;

  { ExporterOBJ }
  faWantAutoFolder = 214;
  faExportMtl = 215;
  faExportObj = 216;
  faWantMaterial = 217;
  faWantSimpleName = 218;
  faWantAngularDir = 219;
  faWantNormals = 220;
  faWantUVs = 221;
  faObjDigits2 = 222;
  faObjDigits3 = 223;
  faObjDigits4 = 224;
  faObjDigits5 = 225;

  { MeshFigures }
  faToggleMarker = 226;
  faToggleGrid = 227;
  faToggleGridFrequency = 228;
  faToggleDiameter3 = 229;
  faDiameter3On = 230;
  faDiameter3Off = 231;
  faToggleCylinder = 232;
  faToggleCube = 233;
  faToggleCorner = 234;
  faToggleLimitPlane = 235;

  { VertexPulling }
  faToggleZeroPulling = 236;
  faToggleLimitPulling = 237;
  faToggleSlicePulling = 238;
  faToggleTargetPulling = 239;
  faToggleRightPulling = 240;

  { MeshBuilderOptions }
  faToggleSolidFlip = 241;
  faWantSpecialY = 242;
  faToggleShowEdges = 243;
  faUniqueMode1 = 244;
  faUniqueMode2 = 245;
  faToggleUniqueVertices = 246;

  { TextureExport }
  faCopyBinCode = 247;
  faCopyBinCodeTest = 248;

  { ColorMix }
  faColorMix0 = 249;
  faColorMix1 = 250;
  faColorMix2 = 251;
  faColorMix3 = 252;
  faColorMix4 = 253;
  faColorMix5 = 254;
  faColorMixP = 255;
  faColorMixM = 256;

  { ColorSwat }
  faToggleColorSwat = 257;

  { Lux }
  faLux1On = 258;
  faLux1Off = 259;
  faToggleLux1 = 260;
  faLux2On = 261;
  faLux2Off = 262;
  faToggleLux2 = 263;
  faLux3On = 264;
  faLux3Off = 265;
  faToggleLux3 = 266;
  faLux4On = 267;
  faLux4Off = 268;
  faToggleLux4 = 269;
  faLuxOn = 270;
  faLuxOff = 271;
  faToggleLux = 272;

  { LuxMarker }
  faLuxMarkerOn = 273;
  faLuxMarkerOff = 274;
  faToggleLuxMarker = 275;

  { LightMode }
  faLightMode0 = 276;
  faLightMode1 = 277;
  faLightMode2 = 278;
  faLightMode3 = 279;
  faLightMode4 = 280;

  { ResetLight }
  faResetLightPosition = 281;
  faResetLightParams = 282;

  { Wheel }
  faParamValuePlus1 = 283;
  faParamValueMinus1 = 284;
  faParamValuePlus10 = 285;
  faParamValueMinus10 = 286;
  faWheelLeft = 287;
  faWheelRight = 288;
  faWheelDown = 289;
  faWheelUp = 290;

  { WheelFrequency }
  faWheelFrequency1 = 291;
  faWheelFrequency05 = 292;
  faWheelFrequency02 = 293;
  faWheelFrequency01 = 294;
  faWheelFrequency001 = 295;
  faWheelFrequency0001 = 296;

  { ColorScheme }
  faCycleColorSchemeM = 297;
  faCycleColorSchemeP = 298;

  { Step }
  faStepRXM = 299;
  faStepRXP = 300;
  faStepRYM = 301;
  faStepRYP = 302;
  faStepRZM = 303;
  faStepRZP = 304;
  faStepCZM = 305;
  faStepCZP = 306;

  { UI }
  faToggleColorPanel = 307;
  faColorPanelOn = 308;
  faColorPanelOff = 309;
  faPaletteOn = 310;
  faPaletteOff = 311;

  { Locks }
  faToggleLuxLock = 312;
  faToggleParamLock = 313;
  faToggleTextureLock = 314;
  faToggleBackgroundLock = 315;
  faToggleForceLock = 316;
  faToggleReportLock = 317;

  { Opacity }
  faToggleOpacity = 318;
  faOpacityOn = 319;
  faOpacityOff = 320;

  { FederText }
  faToggleAllText = 321;
  faToggleTouchFrame = 322;

  { ViewParams }
  faPan = 323;
  faParamRX = 324;
  faParamRY = 325;
  faParamRZ = 326;
  faParamCZ = 327;

  { ViewParamsFC }
  faParamTRS = 328;
  faParamTRT = 329;
  faParamTRX = 330;
  faParamTRY = 331;

  { ParamT }
  faParamT1 = 332;
  faParamT2 = 333;
  faParamT3 = 334;
  faParamT4 = 335;

  { ViewFlags }
  faToggleBMap = 336;
  faToggleZoom = 337;
  faToggleTouchMenu = 338;
  faToggleEquationText = 339;
  faTogglePrimeText = 340;
  faToggleSecondText = 341;
  faToggleLabelText = 342;
  faLabelBatchM = 343;
  faLabelBatchP = 344;
  faLabelTextP = 345;
  faLabelTextM = 346;

  { Report }
  faCopyShortCutReport = 347;
  faWriteActionReport = 348;
  faWriteActionTable = 349;
  faWriteActionConst = 350;
  faWriteActionNames = 351;
  faWriteVersion1 = 352;
  faWriteVersion2 = 353;
  faWriteCode = 354;
  faWriteDiff1 = 355;
  faWriteDiffCode = 356;
  faWriteDiffBin = 357;
  faWriteBandInfo3 = 358;
  faWriteBandInfo5 = 359;
  faWriteEquationInfo = 360;
  faWriteVirtual = 361;
  faBlockTest = 362;

  { ReportOptions }
  faSourcePascal = 363;
  faSourceMaxima = 364;
  faSourceMaple = 365;
  faSourceMathematica = 366;

  { CopyImage }
  faCopyScreenshot = 367;
  faCopyBitmap3D = 368;
  faCopyTextureBitmap = 369;
  faCopyImprintedBitmap = 370;
  faCopyImprintedBitmapTest = 371;

  { CopyOptions }
  faToggleHardCopy = 372;
  faHardCopyOn = 373;
  faHardCopyOff = 374;
  faTogglePngCopy = 375;
  faPngCopyOn = 376;
  faPngCopyOff = 377;
  faToggleNoCopy = 378;
  faNoCopyOn = 379;
  faNoCopyOff = 380;

  { GraphOptions }
  faToggleDiameter = 381;
  faToggleProbe = 382;

  { Bahn }
  faNorthCap = 383;
  faSouthCap = 384;
  faEastCap = 385;
  faWestCap = 386;
  faParamCapValue = 387;
  faParamBahnRadius = 388;
  faParamBahnPositionX = 389;
  faParamBahnPositionY = 390;
  faParamBahnAngle = 391;
  faParamBahnCylinderD = 392;
  faParamBahnCylinderZ = 393;

  { ExampleData }
  faExample01 = 394;
  faExample02 = 395;
  faExample03 = 396;
  faExample04 = 397;
  faExample05 = 398;
  faExample06 = 399;
  faExample07 = 400;
  faExample08 = 401;
  faExample09 = 402;

  { SampleNavigation }
  faSampleM = 403;
  faSampleP = 404;
  faGotoSample1 = 405;

  { Help }
  faToggleHelp = 406;
  faToggleReport = 407;
  faToggleButtonReport = 408;
  faCycleHelpM = 409;
  faCycleHelpP = 410;
  faHelpCycle = 411;
  faHelpList = 412;
  faHelpHome = 413;

  { BtnLegendTablet }
  faTL01 = 414;
  faTL02 = 415;
  faTL03 = 416;
  faTL04 = 417;
  faTL05 = 418;
  faTL06 = 419;
  faTR01 = 420;
  faTR02 = 421;
  faTR03 = 422;
  faTR04 = 423;
  faTR05 = 424;
  faTR06 = 425;
  faTR07 = 426;
  faTR08 = 427;
  faBL01 = 428;
  faBL02 = 429;
  faBL03 = 430;
  faBL04 = 431;
  faBL05 = 432;
  faBL06 = 433;
  faBL07 = 434;
  faBL08 = 435;
  faBR01 = 436;
  faBR02 = 437;
  faBR03 = 438;
  faBR04 = 439;
  faBR05 = 440;
  faBR06 = 441;

  { BtnLegendPhone }
  faMB01 = 442;
  faMB02 = 443;
  faMB03 = 444;
  faMB04 = 445;
  faMB05 = 446;
  faMB06 = 447;
  faMB07 = 448;
  faMB08 = 449;

  { TouchBarLegend }
  faTouchBarTop = 450;
  faTouchBarBottom = 451;
  faTouchBarLeft = 452;
  faTouchBarRight = 453;

  { Reset }
  faReset = 454;
  faResetPosition = 455;
  faResetRotation = 456;
  faResetZoom = 457;

  { Language }
  faToggleLanguage = 458;

  { CopyPaste }
  faSave = 459;
  faLoad = 460;
  faOpen = 461;
  faCopy = 462;
  faPaste = 463;

  { ViewOptions }
  faToggleMoveMode = 464;
  faLinearMove = 465;
  faExpoMove = 466;
  faToggleOrbitMode = 467;

  { BitmapCycle }
  faCycleBitmapM = 468;
  faCycleBitmapP = 469;
  faRandom = 470;
  faRandomWhite = 471;
  faRandomBlack = 472;
  faRandomBambu1 = 473;
  faRandomBambu2 = 474;
  faBitmapEscape = 475;
  faBitmapOne = 476;
  faToggleContour = 477;

  { Layout0 }
  faLayout0 = 478;
  faLayout1 = 479;
  faLayout2 = 480;
  faLayout3 = 481;
  faLayout4 = 482;
  faLayout5 = 483;
  faLayout6 = 484;
  faLayout7 = 485;
  faLayout8 = 486;
  faLayout9 = 487;

  { FigureSize }
  faFigureSizeXS = 488;
  faFigureSizeS = 489;
  faFigureSizeM = 490;
  faFigureSizeL = 491;
  faFigureSizeXL = 492;

  { EyeSize }
  faEyeSizeS = 493;
  faEyeSizeM = 494;
  faEyeSizeL = 495;

  { LayerSelection }
  faSelectLayer1 = 496;
  faSelectLayer2 = 497;
  faSelectLayer3 = 498;
  faSelectLayer4 = 499;
  faSelectLayer5 = 500;
  faSelectLayer6 = 501;
  faSelectLayer7 = 502;

  { ColorSelection }
  faSelectColor1 = 503;
  faSelectColor2 = 504;
  faSelectColor3 = 505;
  faSelectColor4 = 506;

  { ColorMapping }
  faCLA = 507;
  faMapColorToLayer = 508;
  faSelectColorMapping1 = 509;
  faSelectColorMapping2 = 510;
  faSelectColorMapping3 = 511;
  faSelectColorMapping4 = 512;
  faSelectColorMapping5 = 513;
  faSelectColorMapping6 = 514;

  faMax = 515;

implementation

end.
