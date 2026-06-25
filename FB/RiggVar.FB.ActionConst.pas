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
  faShowColor = 15;
  faShowBambu = 16;
  faShowInfo = 17;

  { TouchLayout }
  faTouchTablet = 18;
  faTouchPhone = 19;
  faTouchDesk = 20;

  { ActionMapping }
  faProcessAll = 21;

  { Scene }
  faScene1 = 22;
  faScene2 = 23;
  faScene3 = 24;
  faScene4 = 25;
  faScene5 = 26;

  { Plot }
  faPlot0 = 27;
  faPlot1 = 28;
  faPlot2 = 29;
  faPlot3 = 30;
  faPlot4 = 31;
  faPlot5 = 32;
  faPlot6 = 33;
  faPlot7 = 34;
  faPlot8 = 35;
  faPlot9 = 36;
  faPlot10 = 37;
  faPlot11 = 38;
  faPlot12 = 39;
  faPlot13 = 40;

  { Figure }
  faFigure1 = 41;
  faFigure2 = 42;
  faFigure3 = 43;
  faFigure4 = 44;
  faFigure5 = 45;
  faFigure6 = 46;

  { Graph }
  faGraph1 = 47;
  faGraph2 = 48;
  faGraph3 = 49;
  faGraph4 = 50;
  faGraph5 = 51;

  { Color }
  faColor0 = 52;
  faColor1 = 53;
  faColor2 = 54;
  faColor3 = 55;
  faColor4 = 56;
  faColor5 = 57;
  faColor6 = 58;

  { Param }
  faParam0 = 59;
  faParam1 = 60;
  faParam2 = 61;
  faParam3 = 62;
  faParam4 = 63;
  faParam5 = 64;
  faParam6 = 65;
  faParam7 = 66;
  faParam8 = 67;
  faParam9 = 68;

  { SystemParam }
  faParamX1 = 69;
  faParamY1 = 70;
  faParamZ1 = 71;
  faParamL1 = 72;
  faParamK1 = 73;
  faParamX2 = 74;
  faParamY2 = 75;
  faParamZ2 = 76;
  faParamL2 = 77;
  faParamK2 = 78;
  faParamX3 = 79;
  faParamY3 = 80;
  faParamZ3 = 81;
  faParamL3 = 82;
  faParamK3 = 83;
  faParamX4 = 84;
  faParamY4 = 85;
  faParamZ4 = 86;
  faParamL4 = 87;
  faParamK4 = 88;

  { OffsetParam }
  faOffsetX = 89;
  faOffsetY = 90;
  faOffsetZ = 91;

  { CoordParam }
  faCoord0 = 92;
  faCoord1 = 93;
  faCoord2 = 94;
  faCoord3 = 95;

  { LuxParam }
  faParamL1X = 96;
  faParamL1Y = 97;
  faParamL1Z = 98;
  faParamL2X = 99;
  faParamL2Y = 100;
  faParamL2Z = 101;
  faParamL3X = 102;
  faParamL3Y = 103;
  faParamL3Z = 104;
  faParamL4X = 105;
  faParamL4Y = 106;
  faParamL4Z = 107;

  { ParamCycle }
  faCycleX = 108;
  faCycleY = 109;
  faCycleZ = 110;
  faCycleL = 111;
  faCycleK = 112;
  faCycleO = 113;
  faCycleR = 114;
  faCycleT = 115;
  faCycleU = 116;

  { ModelParams }
  faParamR = 117;
  faParamT = 118;
  faParamL = 119;
  faParamK = 120;
  faParamZ = 121;
  faParamA = 122;
  faParamG = 123;
  faParamX12 = 124;
  faParamY12 = 125;
  faParamZ12 = 126;
  faParamY3F = 127;
  faParamL3F = 128;
  faParamLF = 129;

  { ModelOptions }
  faToggleSolutionMode = 130;
  faToggleVorzeichen = 131;
  faToggleLinearForce = 132;
  faToggleGleich = 133;
  faToggleMCap = 134;
  faTogglePCap = 135;
  faForceZ0 = 136;
  faWantZ12 = 137;
  faDiff0 = 138;
  faDiff1 = 139;
  faDiff10 = 140;

  { OptionCycle }
  faCyclePlotM = 141;
  faCyclePlotP = 142;
  faCycleGraphM = 143;
  faCycleGraphP = 144;
  faCycleFigureM = 145;
  faCycleFigureP = 146;

  { ForceMode }
  faForceMode0 = 147;
  faForceMode1 = 148;
  faForceMode2 = 149;

  { FederMode }
  faM1 = 150;
  faM2 = 151;
  faM3 = 152;

  { RingActions }
  faBlindRingP = 153;
  faBlindRingM = 154;
  faCycleRingP = 155;
  faCycleRingM = 156;
  faToggleShirtColor = 157;
  faShirtColorOn = 158;
  faShirtColorOff = 159;
  faApplyRingColor = 160;
  faToggleShirtFarbe = 161;
  faShirtFarbeOn = 162;
  faShirtFarbeOff = 163;
  faPixelCount1 = 164;
  faPixelCount2 = 165;
  faPixelCount4 = 166;

  { ParamBand }
  faParamBandSelected = 167;
  faParamBandCount = 168;
  faParamBandDistributionX = 169;
  faParamBandDistributionY = 170;
  faParamBandWidth = 171;
  faBandWidthAbsolute = 172;
  faBandWidthRelative = 173;
  faBandWidthContour = 174;

  { BlindRingSelection }
  faBlindRing1 = 175;
  faBlindRing5 = 176;
  faBlindRingA = 177;
  faBlindRingB = 178;
  faBlindRingC = 179;
  faBlindRingD = 180;
  faBlindRingE = 181;
  faBlindRingF = 182;

  { CurrentBand }
  faShowCurrentBand0 = 183;
  faShowCurrentBand1 = 184;
  faShowCurrentBandT = 185;

  { BandSelection }
  faBandSelectionM = 186;
  faBandSelectionP = 187;
  faBandSelection16 = 188;
  faBandSelection17 = 189;
  faBandSelection18 = 190;
  faBandSelection19 = 191;
  faBandSelection20 = 192;
  faBandSelection21 = 193;

  { MeshMode }
  faReducedMesh = 194;
  faReduceMode0 = 195;
  faReduceMode1 = 196;
  faReduceMode2 = 197;
  faReduceMode3 = 198;

  { MeshSize }
  faMeshSize4 = 199;
  faMeshSize8 = 200;
  faMeshSize16 = 201;
  faMeshSize32 = 202;
  faMeshSize64 = 203;
  faMeshSize128 = 204;
  faMeshSize256 = 205;
  faMeshSize316 = 206;
  faMeshSize512 = 207;

  { MeshExport }
  faWantBottom = 208;
  faWantBottomMirrored = 209;
  faWantSideCaps = 210;
  faTestSingleSide = 211;
  faTakeCapValueSnapshot = 212;

  { MeshExportCoords }
  faExportCoordsNative = 213;
  faExportCoordsBlender = 214;
  faExportCoords3DV = 215;
  faExportCoords3DP = 216;

  { ExporterOBJ }
  faWantAutoFolder = 217;
  faExportMtl = 218;
  faExportObj = 219;
  faWantMaterial = 220;
  faWantSimpleName = 221;
  faWantAngularDir = 222;
  faWantNormals = 223;
  faWantUVs = 224;
  faObjDigits2 = 225;
  faObjDigits3 = 226;
  faObjDigits4 = 227;
  faObjDigits5 = 228;

  { MeshFigures }
  faToggleMarker = 229;
  faToggleGrid = 230;
  faToggleGridFrequency = 231;
  faToggleDiameter3 = 232;
  faDiameter3On = 233;
  faDiameter3Off = 234;
  faToggleCylinder = 235;
  faToggleCube = 236;
  faToggleCorner = 237;
  faToggleLimitPlane = 238;

  { VertexPulling }
  faToggleZeroPulling = 239;
  faToggleLimitPulling = 240;
  faToggleSlicePulling = 241;
  faToggleTargetPulling = 242;
  faToggleRightPulling = 243;

  { MeshBuilderOptions }
  faToggleSolidFlip = 244;
  faWantSpecialY = 245;
  faToggleShowEdges = 246;
  faUniqueMode1 = 247;
  faUniqueMode2 = 248;
  faToggleUniqueVertices = 249;

  { TextureExport }
  faCopyBinCode = 250;
  faCopyBinCodeTest = 251;

  { ColorMix }
  faColorMix0 = 252;
  faColorMix1 = 253;
  faColorMix2 = 254;
  faColorMix3 = 255;
  faColorMix4 = 256;
  faColorMix5 = 257;
  faColorMixP = 258;
  faColorMixM = 259;

  { ColorSwat }
  faToggleColorSwat = 260;

  { Lux }
  faLux1On = 261;
  faLux1Off = 262;
  faToggleLux1 = 263;
  faLux2On = 264;
  faLux2Off = 265;
  faToggleLux2 = 266;
  faLux3On = 267;
  faLux3Off = 268;
  faToggleLux3 = 269;
  faLux4On = 270;
  faLux4Off = 271;
  faToggleLux4 = 272;
  faLuxOn = 273;
  faLuxOff = 274;
  faToggleLux = 275;

  { LuxMarker }
  faLuxMarkerOn = 276;
  faLuxMarkerOff = 277;
  faToggleLuxMarker = 278;

  { LightMode }
  faLightMode0 = 279;
  faLightMode1 = 280;
  faLightMode2 = 281;
  faLightMode3 = 282;
  faLightMode4 = 283;

  { ResetLight }
  faResetLightPosition = 284;
  faResetLightParams = 285;

  { Wheel }
  faParamValuePlus1 = 286;
  faParamValueMinus1 = 287;
  faParamValuePlus10 = 288;
  faParamValueMinus10 = 289;
  faWheelLeft = 290;
  faWheelRight = 291;
  faWheelDown = 292;
  faWheelUp = 293;

  { WheelFrequency }
  faWheelFrequency1 = 294;
  faWheelFrequency05 = 295;
  faWheelFrequency02 = 296;
  faWheelFrequency01 = 297;
  faWheelFrequency001 = 298;
  faWheelFrequency0001 = 299;

  { ColorScheme }
  faCycleColorSchemeM = 300;
  faCycleColorSchemeP = 301;

  { Step }
  faStepRXM = 302;
  faStepRXP = 303;
  faStepRYM = 304;
  faStepRYP = 305;
  faStepRZM = 306;
  faStepRZP = 307;
  faStepCZM = 308;
  faStepCZP = 309;

  { UI }
  faToggleColorPanel = 310;
  faColorPanelOn = 311;
  faColorPanelOff = 312;
  faPaletteOn = 313;
  faPaletteOff = 314;

  { Locks }
  faToggleLuxLock = 315;
  faToggleParamLock = 316;
  faToggleTextureLock = 317;
  faToggleBackgroundLock = 318;
  faToggleForceLock = 319;
  faToggleReportLock = 320;

  { Opacity }
  faToggleOpacity = 321;
  faOpacityOn = 322;
  faOpacityOff = 323;

  { FederText }
  faToggleAllText = 324;
  faToggleTouchFrame = 325;

  { ViewParams }
  faPan = 326;
  faParamRX = 327;
  faParamRY = 328;
  faParamRZ = 329;
  faParamCZ = 330;

  { ViewParamsFC }
  faParamTRS = 331;
  faParamTRT = 332;
  faParamTRX = 333;
  faParamTRY = 334;

  { ParamT }
  faParamT1 = 335;
  faParamT2 = 336;
  faParamT3 = 337;
  faParamT4 = 338;

  { ViewFlags }
  faToggleBMap = 339;
  faToggleZoom = 340;
  faToggleTouchMenu = 341;
  faToggleEquationText = 342;
  faTogglePrimeText = 343;
  faToggleSecondText = 344;
  faToggleLabelText = 345;
  faLabelBatchM = 346;
  faLabelBatchP = 347;
  faLabelTextP = 348;
  faLabelTextM = 349;

  { Report }
  faCopyShortCutReport = 350;
  faWriteActionReport = 351;
  faWriteActionTable = 352;
  faWriteActionConst = 353;
  faWriteActionNames = 354;
  faWriteVersion1 = 355;
  faWriteVersion2 = 356;
  faWriteCode = 357;
  faWriteDiff1 = 358;
  faWriteDiffCode = 359;
  faWriteDiffBin = 360;
  faWriteBandInfo3 = 361;
  faWriteBandInfo5 = 362;
  faWriteEquationInfo = 363;
  faWriteVirtual = 364;
  faBlockTest = 365;

  { ReportOptions }
  faSourcePascal = 366;
  faSourceMaxima = 367;
  faSourceMaple = 368;
  faSourceMathematica = 369;

  { CopyImage }
  faCopyScreenshot = 370;
  faCopyBitmap3D = 371;
  faCopyTextureBitmap = 372;
  faCopyImprintedBitmap = 373;
  faCopyImprintedBitmapTest = 374;

  { CopyOptions }
  faToggleHardCopy = 375;
  faHardCopyOn = 376;
  faHardCopyOff = 377;
  faTogglePngCopy = 378;
  faPngCopyOn = 379;
  faPngCopyOff = 380;
  faToggleNoCopy = 381;
  faNoCopyOn = 382;
  faNoCopyOff = 383;

  { GraphOptions }
  faToggleDiameter = 384;
  faToggleProbe = 385;

  { Bahn }
  faNorthCap = 386;
  faSouthCap = 387;
  faEastCap = 388;
  faWestCap = 389;
  faParamCapValue = 390;
  faParamBahnRadius = 391;
  faParamBahnPositionX = 392;
  faParamBahnPositionY = 393;
  faParamBahnAngle = 394;
  faParamBahnCylinderD = 395;
  faParamBahnCylinderZ = 396;

  { ExampleData }
  faExample01 = 397;
  faExample02 = 398;
  faExample03 = 399;
  faExample04 = 400;
  faExample05 = 401;
  faExample06 = 402;
  faExample07 = 403;
  faExample08 = 404;
  faExample09 = 405;

  { Repo }
  faSwapBundle = 406;
  faRepo010 = 407;
  faRepo020 = 408;
  faRepo050 = 409;

  { SampleNavigation }
  faLevelM = 410;
  faLevelP = 411;
  faHubM = 412;
  faHubP = 413;
  faSampleM = 414;
  faSampleP = 415;
  faGotoSample0 = 416;
  faGotoSample1 = 417;

  { Help }
  faToggleHelp = 418;
  faToggleReport = 419;
  faToggleButtonReport = 420;
  faCycleHelpM = 421;
  faCycleHelpP = 422;
  faHelpCycle = 423;
  faHelpList = 424;
  faHelpHome = 425;

  { BtnLegendTablet }
  faTL01 = 426;
  faTL02 = 427;
  faTL03 = 428;
  faTL04 = 429;
  faTL05 = 430;
  faTL06 = 431;
  faTR01 = 432;
  faTR02 = 433;
  faTR03 = 434;
  faTR04 = 435;
  faTR05 = 436;
  faTR06 = 437;
  faTR07 = 438;
  faTR08 = 439;
  faBL01 = 440;
  faBL02 = 441;
  faBL03 = 442;
  faBL04 = 443;
  faBL05 = 444;
  faBL06 = 445;
  faBL07 = 446;
  faBL08 = 447;
  faBR01 = 448;
  faBR02 = 449;
  faBR03 = 450;
  faBR04 = 451;
  faBR05 = 452;
  faBR06 = 453;

  { BtnLegendPhone }
  faMB01 = 454;
  faMB02 = 455;
  faMB03 = 456;
  faMB04 = 457;
  faMB05 = 458;
  faMB06 = 459;
  faMB07 = 460;
  faMB08 = 461;

  { TouchBarLegend }
  faTouchBarTop = 462;
  faTouchBarBottom = 463;
  faTouchBarLeft = 464;
  faTouchBarRight = 465;

  { Reset }
  faReset = 466;
  faResetPosition = 467;
  faResetRotation = 468;
  faResetZoom = 469;

  { Language }
  faToggleLanguage = 470;

  { CopyPaste }
  faSave = 471;
  faLoad = 472;
  faOpen = 473;
  faCopy = 474;
  faPaste = 475;

  { ViewOptions }
  faToggleMoveMode = 476;
  faLinearMove = 477;
  faExpoMove = 478;
  faToggleOrbitMode = 479;

  { BitmapCycle }
  faCycleBitmapM = 480;
  faCycleBitmapP = 481;
  faRandom = 482;
  faRandomWhite = 483;
  faRandomBlack = 484;
  faRandomBambu1 = 485;
  faRandomBambu2 = 486;
  faBitmapEscape = 487;
  faBitmapOne = 488;
  faToggleContour = 489;

  { Layout0 }
  faLayout0 = 490;
  faLayout1 = 491;
  faLayout2 = 492;
  faLayout3 = 493;
  faLayout4 = 494;
  faLayout5 = 495;
  faLayout6 = 496;
  faLayout7 = 497;
  faLayout8 = 498;
  faLayout9 = 499;

  { Layout1 }
  faLayout10 = 500;
  faLayout11 = 501;
  faLayout12 = 502;
  faLayout13 = 503;
  faLayout14 = 504;
  faLayout15 = 505;
  faLayout16 = 506;
  faLayout17 = 507;
  faLayout18 = 508;
  faLayout19 = 509;

  { Layout2 }
  faLayout20 = 510;
  faLayout21 = 511;
  faLayout22 = 512;
  faLayout23 = 513;
  faLayout24 = 514;
  faLayout25 = 515;
  faLayout26 = 516;
  faLayout27 = 517;
  faLayout28 = 518;
  faLayout29 = 519;

  { Layout3 }
  faLayout30 = 520;
  faLayout31 = 521;
  faLayout32 = 522;
  faLayout33 = 523;
  faLayout34 = 524;
  faLayout35 = 525;
  faLayout36 = 526;
  faLayout37 = 527;
  faLayout38 = 528;
  faLayout39 = 529;

  { Layout4 }
  faLayout40 = 530;
  faLayout41 = 531;
  faLayout42 = 532;
  faLayout43 = 533;
  faLayout44 = 534;
  faLayout45 = 535;
  faLayout46 = 536;
  faLayout47 = 537;
  faLayout48 = 538;
  faLayout49 = 539;

  { Layout5 }
  faLayout50 = 540;
  faLayout51 = 541;
  faLayout52 = 542;
  faLayout53 = 543;
  faLayout54 = 544;
  faLayout55 = 545;
  faLayout56 = 546;
  faLayout57 = 547;
  faLayout58 = 548;
  faLayout59 = 549;

  { Layout6 }
  faLayout60 = 550;
  faLayout61 = 551;
  faLayout62 = 552;
  faLayout63 = 553;
  faLayout64 = 554;
  faLayout65 = 555;
  faLayout66 = 556;
  faLayout67 = 557;
  faLayout68 = 558;
  faLayout69 = 559;

  { Layout7 }
  faLayout70 = 560;
  faLayout71 = 561;
  faLayout72 = 562;
  faLayout73 = 563;
  faLayout74 = 564;
  faLayout75 = 565;
  faLayout76 = 566;
  faLayout77 = 567;
  faLayout78 = 568;
  faLayout79 = 569;

  { Layout8 }
  faLayout80 = 570;
  faLayout81 = 571;
  faLayout82 = 572;
  faLayout83 = 573;
  faLayout84 = 574;
  faLayout85 = 575;
  faLayout86 = 576;
  faLayout87 = 577;
  faLayout88 = 578;
  faLayout89 = 579;

  { Layout9 }
  faLayout90 = 580;
  faLayout91 = 581;
  faLayout92 = 582;
  faLayout93 = 583;
  faLayout94 = 584;
  faLayout95 = 585;
  faLayout96 = 586;
  faLayout97 = 587;
  faLayout98 = 588;
  faLayout99 = 589;

  { MenuNav }
  faMenuXX = 590;
  faMenu00 = 591;
  faMenu10 = 592;
  faMenu20 = 593;
  faMenu30 = 594;
  faMenu40 = 595;
  faMenu50 = 596;
  faMenu60 = 597;
  faMenu70 = 598;
  faMenu80 = 599;
  faMenu90 = 600;

  { FigureSize }
  faFigureSizeXS = 601;
  faFigureSizeS = 602;
  faFigureSizeM = 603;
  faFigureSizeL = 604;
  faFigureSizeXL = 605;

  { EyeSize }
  faEyeSizeS = 606;
  faEyeSizeM = 607;
  faEyeSizeL = 608;

  { LayerSelection }
  faSelectLayer1 = 609;
  faSelectLayer2 = 610;
  faSelectLayer3 = 611;
  faSelectLayer4 = 612;
  faSelectLayer5 = 613;
  faSelectLayer6 = 614;
  faSelectLayer7 = 615;

  { ColorSelection }
  faSelectColor1 = 616;
  faSelectColor2 = 617;
  faSelectColor3 = 618;
  faSelectColor4 = 619;

  { ColorMapping }
  faCLA = 620;
  faMapColorToLayer = 621;
  faSelectColorMapping1 = 622;
  faSelectColorMapping2 = 623;
  faSelectColorMapping3 = 624;
  faSelectColorMapping4 = 625;
  faSelectColorMapping5 = 626;
  faSelectColorMapping6 = 627;

  faMax = 628;

implementation

end.
