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
  faShowImage = 12;
  faShowMemo = 13;
  faShowActions = 14;
  faShowInfo = 15;

  { TouchLayout }
  faTouchTablet = 16;
  faTouchPhone = 17;
  faTouchDesk = 18;

  { ActionMapping }
  faProcessAll = 19;

  { Scene }
  faScene1 = 20;
  faScene2 = 21;
  faScene3 = 22;
  faScene4 = 23;
  faScene5 = 24;

  { Plot }
  faPlot0 = 25;
  faPlot1 = 26;
  faPlot2 = 27;
  faPlot3 = 28;
  faPlot4 = 29;
  faPlot5 = 30;
  faPlot6 = 31;
  faPlot7 = 32;
  faPlot8 = 33;
  faPlot9 = 34;
  faPlot10 = 35;
  faPlot11 = 36;
  faPlot12 = 37;
  faPlot13 = 38;

  { Figure }
  faFigure1 = 39;
  faFigure2 = 40;
  faFigure3 = 41;
  faFigure4 = 42;
  faFigure5 = 43;
  faFigure6 = 44;

  { Graph }
  faGraph1 = 45;
  faGraph2 = 46;
  faGraph3 = 47;
  faGraph4 = 48;
  faGraph5 = 49;

  { Color }
  faColor0 = 50;
  faColor1 = 51;
  faColor2 = 52;
  faColor3 = 53;
  faColor4 = 54;
  faColor5 = 55;
  faColor6 = 56;

  { Param }
  faParam0 = 57;
  faParam1 = 58;
  faParam2 = 59;
  faParam3 = 60;
  faParam4 = 61;
  faParam5 = 62;
  faParam6 = 63;
  faParam7 = 64;
  faParam8 = 65;
  faParam9 = 66;

  { SystemParam }
  faParamX1 = 67;
  faParamY1 = 68;
  faParamZ1 = 69;
  faParamL1 = 70;
  faParamK1 = 71;
  faParamX2 = 72;
  faParamY2 = 73;
  faParamZ2 = 74;
  faParamL2 = 75;
  faParamK2 = 76;
  faParamX3 = 77;
  faParamY3 = 78;
  faParamZ3 = 79;
  faParamL3 = 80;
  faParamK3 = 81;
  faParamX4 = 82;
  faParamY4 = 83;
  faParamZ4 = 84;
  faParamL4 = 85;
  faParamK4 = 86;

  { OffsetParam }
  faOffsetX = 87;
  faOffsetY = 88;
  faOffsetZ = 89;

  { CoordParam }
  faCoord0 = 90;
  faCoord1 = 91;
  faCoord2 = 92;
  faCoord3 = 93;

  { LuxParam }
  faParamL1X = 94;
  faParamL1Y = 95;
  faParamL1Z = 96;
  faParamL2X = 97;
  faParamL2Y = 98;
  faParamL2Z = 99;
  faParamL3X = 100;
  faParamL3Y = 101;
  faParamL3Z = 102;
  faParamL4X = 103;
  faParamL4Y = 104;
  faParamL4Z = 105;

  { ParamCycle }
  faCycleX = 106;
  faCycleY = 107;
  faCycleZ = 108;
  faCycleL = 109;
  faCycleK = 110;
  faCycleO = 111;
  faCycleR = 112;
  faCycleT = 113;
  faCycleU = 114;

  { ModelParams }
  faParamR = 115;
  faParamT = 116;
  faParamL = 117;
  faParamK = 118;
  faParamZ = 119;
  faParamA = 120;
  faParamG = 121;
  faParamX12 = 122;
  faParamY12 = 123;
  faParamZ12 = 124;
  faParamY3F = 125;
  faParamL3F = 126;
  faParamLF = 127;

  { ModelOptions }
  faToggleSolutionMode = 128;
  faToggleVorzeichen = 129;
  faToggleLinearForce = 130;
  faToggleGleich = 131;
  faToggleMCap = 132;
  faTogglePCap = 133;
  faForceZ0 = 134;
  faWantZ12 = 135;
  faDiff0 = 136;
  faDiff1 = 137;
  faDiff10 = 138;

  { OptionCycle }
  faCyclePlotM = 139;
  faCyclePlotP = 140;
  faCycleGraphM = 141;
  faCycleGraphP = 142;
  faCycleFigureM = 143;
  faCycleFigureP = 144;

  { ForceMode }
  faForceMode0 = 145;
  faForceMode1 = 146;
  faForceMode2 = 147;

  { FederMode }
  faM1 = 148;
  faM2 = 149;
  faM3 = 150;

  { RingActions }
  faBlindRingP = 151;
  faBlindRingM = 152;
  faCycleRingP = 153;
  faCycleRingM = 154;
  faToggleShirtColor = 155;
  faShirtColorOn = 156;
  faShirtColorOff = 157;
  faApplyRingColor = 158;
  faToggleShirtFarbe = 159;
  faShirtFarbeOn = 160;
  faShirtFarbeOff = 161;
  faPixelCount1 = 162;
  faPixelCount2 = 163;
  faPixelCount4 = 164;

  { ParamBand }
  faParamBandSelected = 165;
  faParamBandCount = 166;
  faParamBandDistributionX = 167;
  faParamBandDistributionY = 168;
  faParamBandWidth = 169;
  faBandWidthAbsolute = 170;
  faBandWidthRelative = 171;
  faBandWidthContour = 172;

  { BlindRingSelection }
  faBlindRing1 = 173;
  faBlindRing5 = 174;
  faBlindRingA = 175;
  faBlindRingB = 176;
  faBlindRingC = 177;
  faBlindRingD = 178;
  faBlindRingE = 179;
  faBlindRingF = 180;

  { CurrentBand }
  faShowCurrentBand0 = 181;
  faShowCurrentBand1 = 182;
  faShowCurrentBandT = 183;

  { BandSelection }
  faBandSelectionM = 184;
  faBandSelectionP = 185;
  faBandSelection16 = 186;
  faBandSelection17 = 187;
  faBandSelection18 = 188;
  faBandSelection19 = 189;
  faBandSelection20 = 190;
  faBandSelection21 = 191;

  { MeshMode }
  faReducedMesh = 192;
  faReduceMode0 = 193;
  faReduceMode1 = 194;
  faReduceMode2 = 195;
  faReduceMode3 = 196;

  { MeshSize }
  faMeshSize4 = 197;
  faMeshSize8 = 198;
  faMeshSize16 = 199;
  faMeshSize32 = 200;
  faMeshSize64 = 201;
  faMeshSize128 = 202;
  faMeshSize256 = 203;
  faMeshSize316 = 204;
  faMeshSize512 = 205;

  { MeshExport }
  faWantBottom = 206;
  faWantBottomMirrored = 207;
  faWantSideCaps = 208;
  faTestSingleSide = 209;
  faTakeCapValueSnapshot = 210;

  { MeshExportCoords }
  faExportCoordsNative = 211;
  faExportCoordsBlender = 212;
  faExportCoords3DV = 213;
  faExportCoords3DP = 214;

  { ExporterOBJ }
  faWantAutoFolder = 215;
  faExportMtl = 216;
  faExportObj = 217;
  faWantMaterial = 218;
  faWantSimpleName = 219;
  faWantAngularDir = 220;
  faWantNormals = 221;
  faWantUVs = 222;
  faObjDigits2 = 223;
  faObjDigits3 = 224;
  faObjDigits4 = 225;
  faObjDigits5 = 226;

  { MeshFigures }
  faToggleMarker = 227;
  faToggleGrid = 228;
  faToggleGridFrequency = 229;
  faToggleDiameter3 = 230;
  faDiameter3On = 231;
  faDiameter3Off = 232;
  faToggleCylinder = 233;
  faToggleCube = 234;
  faToggleCorner = 235;
  faToggleLimitPlane = 236;

  { VertexPulling }
  faToggleZeroPulling = 237;
  faToggleLimitPulling = 238;
  faToggleSlicePulling = 239;
  faToggleTargetPulling = 240;
  faToggleRightPulling = 241;

  { MeshBuilderOptions }
  faToggleSolidFlip = 242;
  faWantSpecialY = 243;
  faToggleShowEdges = 244;
  faUniqueMode1 = 245;
  faUniqueMode2 = 246;
  faToggleUniqueVertices = 247;

  { TextureExport }
  faCopyBinCode = 248;
  faCopyBinCodeTest = 249;

  { ColorMix }
  faColorMix0 = 250;
  faColorMix1 = 251;
  faColorMix2 = 252;
  faColorMix3 = 253;
  faColorMix4 = 254;
  faColorMix5 = 255;
  faColorMixP = 256;
  faColorMixM = 257;

  { ColorSwat }
  faToggleColorSwat = 258;

  { Lux }
  faLux1On = 259;
  faLux1Off = 260;
  faToggleLux1 = 261;
  faLux2On = 262;
  faLux2Off = 263;
  faToggleLux2 = 264;
  faLux3On = 265;
  faLux3Off = 266;
  faToggleLux3 = 267;
  faLux4On = 268;
  faLux4Off = 269;
  faToggleLux4 = 270;
  faLuxOn = 271;
  faLuxOff = 272;
  faToggleLux = 273;

  { LuxMarker }
  faLuxMarkerOn = 274;
  faLuxMarkerOff = 275;
  faToggleLuxMarker = 276;

  { LightMode }
  faLightMode0 = 277;
  faLightMode1 = 278;
  faLightMode2 = 279;
  faLightMode3 = 280;
  faLightMode4 = 281;

  { ResetLight }
  faResetLightPosition = 282;
  faResetLightParams = 283;

  { Wheel }
  faParamValuePlus1 = 284;
  faParamValueMinus1 = 285;
  faParamValuePlus10 = 286;
  faParamValueMinus10 = 287;
  faWheelLeft = 288;
  faWheelRight = 289;
  faWheelDown = 290;
  faWheelUp = 291;

  { WheelFrequency }
  faWheelFrequency1 = 292;
  faWheelFrequency05 = 293;
  faWheelFrequency02 = 294;
  faWheelFrequency01 = 295;
  faWheelFrequency001 = 296;
  faWheelFrequency0001 = 297;

  { ColorScheme }
  faCycleColorSchemeM = 298;
  faCycleColorSchemeP = 299;

  { Step }
  faStepRXM = 300;
  faStepRXP = 301;
  faStepRYM = 302;
  faStepRYP = 303;
  faStepRZM = 304;
  faStepRZP = 305;
  faStepCZM = 306;
  faStepCZP = 307;

  { UI }
  faToggleColorPanel = 308;
  faColorPanelOn = 309;
  faColorPanelOff = 310;
  faPaletteOn = 311;
  faPaletteOff = 312;

  { Locks }
  faToggleLuxLock = 313;
  faToggleParamLock = 314;
  faToggleTextureLock = 315;
  faToggleBackgroundLock = 316;
  faToggleForceLock = 317;
  faToggleReportLock = 318;

  { Opacity }
  faToggleOpacity = 319;
  faOpacityOn = 320;
  faOpacityOff = 321;

  { FederText }
  faToggleAllText = 322;
  faToggleTouchFrame = 323;

  { ViewParams }
  faPan = 324;
  faParamRX = 325;
  faParamRY = 326;
  faParamRZ = 327;
  faParamCZ = 328;

  { ViewParamsFC }
  faParamTRS = 329;
  faParamTRT = 330;
  faParamTRX = 331;
  faParamTRY = 332;

  { ParamT }
  faParamT1 = 333;
  faParamT2 = 334;
  faParamT3 = 335;
  faParamT4 = 336;

  { ViewFlags }
  faToggleBMap = 337;
  faToggleZoom = 338;
  faToggleTouchMenu = 339;
  faToggleEquationText = 340;
  faTogglePrimeText = 341;
  faToggleSecondText = 342;
  faToggleLabelText = 343;
  faLabelBatchM = 344;
  faLabelBatchP = 345;
  faLabelTextP = 346;
  faLabelTextM = 347;

  { Report }
  faCopyShortCutReport = 348;
  faWriteActionReport = 349;
  faWriteActionTable = 350;
  faWriteActionConst = 351;
  faWriteActionNames = 352;
  faWriteVersion1 = 353;
  faWriteVersion2 = 354;
  faWriteCode = 355;
  faWriteDiff1 = 356;
  faWriteDiffCode = 357;
  faWriteDiffBin = 358;
  faWriteBandInfo3 = 359;
  faWriteBandInfo5 = 360;
  faWriteEquationInfo = 361;
  faWriteVirtual = 362;
  faBlockTest = 363;

  { ReportOptions }
  faSourcePascal = 364;
  faSourceMaxima = 365;
  faSourceMaple = 366;
  faSourceMathematica = 367;

  { CopyImage }
  faCopyScreenshot = 368;
  faCopyBitmap3D = 369;
  faCopyTextureBitmap = 370;
  faCopyImprintedBitmap = 371;
  faCopyImprintedBitmapTest = 372;

  { CopyOptions }
  faToggleHardCopy = 373;
  faHardCopyOn = 374;
  faHardCopyOff = 375;
  faTogglePngCopy = 376;
  faPngCopyOn = 377;
  faPngCopyOff = 378;
  faToggleNoCopy = 379;
  faNoCopyOn = 380;
  faNoCopyOff = 381;

  { GraphOptions }
  faToggleDiameter = 382;
  faToggleProbe = 383;

  { Bahn }
  faNorthCap = 384;
  faSouthCap = 385;
  faEastCap = 386;
  faWestCap = 387;
  faParamCapValue = 388;
  faParamBahnRadius = 389;
  faParamBahnPositionX = 390;
  faParamBahnPositionY = 391;
  faParamBahnAngle = 392;
  faParamBahnCylinderD = 393;
  faParamBahnCylinderZ = 394;

  { ExampleData }
  faExample01 = 395;
  faExample02 = 396;
  faExample03 = 397;
  faExample04 = 398;
  faExample05 = 399;
  faExample06 = 400;
  faExample07 = 401;
  faExample08 = 402;
  faExample09 = 403;

  { SampleNavigation }
  faSampleM = 404;
  faSampleP = 405;
  faGotoSample1 = 406;

  { Help }
  faToggleHelp = 407;
  faToggleReport = 408;
  faToggleButtonReport = 409;
  faCycleHelpM = 410;
  faCycleHelpP = 411;
  faHelpCycle = 412;
  faHelpList = 413;
  faHelpHome = 414;

  { BtnLegendTablet }
  faTL01 = 415;
  faTL02 = 416;
  faTL03 = 417;
  faTL04 = 418;
  faTL05 = 419;
  faTL06 = 420;
  faTR01 = 421;
  faTR02 = 422;
  faTR03 = 423;
  faTR04 = 424;
  faTR05 = 425;
  faTR06 = 426;
  faTR07 = 427;
  faTR08 = 428;
  faBL01 = 429;
  faBL02 = 430;
  faBL03 = 431;
  faBL04 = 432;
  faBL05 = 433;
  faBL06 = 434;
  faBL07 = 435;
  faBL08 = 436;
  faBR01 = 437;
  faBR02 = 438;
  faBR03 = 439;
  faBR04 = 440;
  faBR05 = 441;
  faBR06 = 442;

  { BtnLegendPhone }
  faMB01 = 443;
  faMB02 = 444;
  faMB03 = 445;
  faMB04 = 446;
  faMB05 = 447;
  faMB06 = 448;
  faMB07 = 449;
  faMB08 = 450;

  { TouchBarLegend }
  faTouchBarTop = 451;
  faTouchBarBottom = 452;
  faTouchBarLeft = 453;
  faTouchBarRight = 454;

  { Reset }
  faReset = 455;
  faResetPosition = 456;
  faResetRotation = 457;
  faResetZoom = 458;

  { Language }
  faToggleLanguage = 459;

  { CopyPaste }
  faSave = 460;
  faLoad = 461;
  faOpen = 462;
  faCopy = 463;
  faPaste = 464;

  { ViewOptions }
  faToggleMoveMode = 465;
  faLinearMove = 466;
  faExpoMove = 467;
  faToggleOrbitMode = 468;

  { BitmapCycle }
  faCycleBitmapM = 469;
  faCycleBitmapP = 470;
  faRandom = 471;
  faRandomWhite = 472;
  faRandomBlack = 473;
  faRandomBambu1 = 474;
  faRandomBambu2 = 475;
  faBitmapEscape = 476;
  faBitmapOne = 477;
  faToggleContour = 478;

  { Layout0 }
  faLayout0 = 479;
  faLayout1 = 480;
  faLayout2 = 481;
  faLayout3 = 482;
  faLayout4 = 483;
  faLayout5 = 484;
  faLayout6 = 485;
  faLayout7 = 486;
  faLayout8 = 487;
  faLayout9 = 488;

  { FigureSize }
  faFigureSizeXS = 489;
  faFigureSizeS = 490;
  faFigureSizeM = 491;
  faFigureSizeL = 492;
  faFigureSizeXL = 493;

  { EyeSize }
  faEyeSizeS = 494;
  faEyeSizeM = 495;
  faEyeSizeL = 496;

  { LayerSelection }
  faSelectLayer1 = 497;
  faSelectLayer2 = 498;
  faSelectLayer3 = 499;
  faSelectLayer4 = 500;
  faSelectLayer5 = 501;
  faSelectLayer6 = 502;
  faSelectLayer7 = 503;

  { ColorSelection }
  faSelectColor1 = 504;
  faSelectColor2 = 505;
  faSelectColor3 = 506;
  faSelectColor4 = 507;

  { ColorMapping }
  faCLA = 508;
  faMapColorToLayer = 509;
  faSelectColorMapping1 = 510;
  faSelectColorMapping2 = 511;
  faSelectColorMapping3 = 512;
  faSelectColorMapping4 = 513;
  faSelectColorMapping5 = 514;
  faSelectColorMapping6 = 515;

  faMax = 516;

implementation

end.
