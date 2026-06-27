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
  faShowAnim = 17;
  faEditText = 18;
  faEditConn = 19;
  faEditHost = 20;
  faEditPort = 21;
  faShowRepo = 22;
  faShowInfo = 23;

  { TouchLayout }
  faTouchTablet = 24;
  faTouchPhone = 25;
  faTouchDesk = 26;

  { ActionMapping }
  faProcessAll = 27;

  { Scene }
  faScene1 = 28;
  faScene2 = 29;
  faScene3 = 30;
  faScene4 = 31;
  faScene5 = 32;

  { Plot }
  faPlot0 = 33;
  faPlot1 = 34;
  faPlot2 = 35;
  faPlot3 = 36;
  faPlot4 = 37;
  faPlot5 = 38;
  faPlot6 = 39;
  faPlot7 = 40;
  faPlot8 = 41;
  faPlot9 = 42;
  faPlot10 = 43;
  faPlot11 = 44;
  faPlot12 = 45;
  faPlot13 = 46;

  { Figure }
  faFigure1 = 47;
  faFigure2 = 48;
  faFigure3 = 49;
  faFigure4 = 50;
  faFigure5 = 51;
  faFigure6 = 52;

  { Graph }
  faGraph1 = 53;
  faGraph2 = 54;
  faGraph3 = 55;
  faGraph4 = 56;
  faGraph5 = 57;

  { Color }
  faColor0 = 58;
  faColor1 = 59;
  faColor2 = 60;
  faColor3 = 61;
  faColor4 = 62;
  faColor5 = 63;
  faColor6 = 64;

  { Param }
  faParam0 = 65;
  faParam1 = 66;
  faParam2 = 67;
  faParam3 = 68;
  faParam4 = 69;
  faParam5 = 70;
  faParam6 = 71;
  faParam7 = 72;
  faParam8 = 73;
  faParam9 = 74;

  { SystemParam }
  faParamX1 = 75;
  faParamY1 = 76;
  faParamZ1 = 77;
  faParamL1 = 78;
  faParamK1 = 79;
  faParamX2 = 80;
  faParamY2 = 81;
  faParamZ2 = 82;
  faParamL2 = 83;
  faParamK2 = 84;
  faParamX3 = 85;
  faParamY3 = 86;
  faParamZ3 = 87;
  faParamL3 = 88;
  faParamK3 = 89;
  faParamX4 = 90;
  faParamY4 = 91;
  faParamZ4 = 92;
  faParamL4 = 93;
  faParamK4 = 94;

  { OffsetParam }
  faOffsetX = 95;
  faOffsetY = 96;
  faOffsetZ = 97;

  { CoordParam }
  faCoord0 = 98;
  faCoord1 = 99;
  faCoord2 = 100;
  faCoord3 = 101;

  { LuxParam }
  faParamL1X = 102;
  faParamL1Y = 103;
  faParamL1Z = 104;
  faParamL2X = 105;
  faParamL2Y = 106;
  faParamL2Z = 107;
  faParamL3X = 108;
  faParamL3Y = 109;
  faParamL3Z = 110;
  faParamL4X = 111;
  faParamL4Y = 112;
  faParamL4Z = 113;

  { ParamCycle }
  faCycleX = 114;
  faCycleY = 115;
  faCycleZ = 116;
  faCycleL = 117;
  faCycleK = 118;
  faCycleO = 119;
  faCycleR = 120;
  faCycleT = 121;
  faCycleU = 122;

  { ModelParams }
  faParamR = 123;
  faParamT = 124;
  faParamL = 125;
  faParamK = 126;
  faParamZ = 127;
  faParamA = 128;
  faParamG = 129;
  faParamX12 = 130;
  faParamY12 = 131;
  faParamZ12 = 132;
  faParamY3F = 133;
  faParamL3F = 134;
  faParamLF = 135;

  { ModelOptions }
  faToggleSolutionMode = 136;
  faToggleVorzeichen = 137;
  faToggleLinearForce = 138;
  faToggleGleich = 139;
  faToggleMCap = 140;
  faTogglePCap = 141;
  faForceZ0 = 142;
  faWantZ12 = 143;
  faDiff0 = 144;
  faDiff1 = 145;
  faDiff10 = 146;

  { OptionCycle }
  faCyclePlotM = 147;
  faCyclePlotP = 148;
  faCycleGraphM = 149;
  faCycleGraphP = 150;
  faCycleFigureM = 151;
  faCycleFigureP = 152;

  { ForceMode }
  faForceMode0 = 153;
  faForceMode1 = 154;
  faForceMode2 = 155;

  { FederMode }
  faM1 = 156;
  faM2 = 157;
  faM3 = 158;

  { RingActions }
  faBlindRingP = 159;
  faBlindRingM = 160;
  faCycleRingP = 161;
  faCycleRingM = 162;
  faToggleShirtColor = 163;
  faShirtColorOn = 164;
  faShirtColorOff = 165;
  faApplyRingColor = 166;
  faToggleShirtFarbe = 167;
  faShirtFarbeOn = 168;
  faShirtFarbeOff = 169;
  faPixelCount1 = 170;
  faPixelCount2 = 171;
  faPixelCount4 = 172;

  { ParamBand }
  faParamBandSelected = 173;
  faParamBandCount = 174;
  faParamBandDistributionX = 175;
  faParamBandDistributionY = 176;
  faParamBandWidth = 177;
  faBandWidthAbsolute = 178;
  faBandWidthRelative = 179;
  faBandWidthContour = 180;

  { BlindRingSelection }
  faBlindRing1 = 181;
  faBlindRing5 = 182;
  faBlindRingA = 183;
  faBlindRingB = 184;
  faBlindRingC = 185;
  faBlindRingD = 186;
  faBlindRingE = 187;
  faBlindRingF = 188;

  { CurrentBand }
  faShowCurrentBand0 = 189;
  faShowCurrentBand1 = 190;
  faShowCurrentBandT = 191;

  { BandSelection }
  faBandSelectionM = 192;
  faBandSelectionP = 193;
  faBandSelection16 = 194;
  faBandSelection17 = 195;
  faBandSelection18 = 196;
  faBandSelection19 = 197;
  faBandSelection20 = 198;
  faBandSelection21 = 199;

  { MeshMode }
  faOpenMesh = 200;
  faPolarMesh = 201;
  faReducedMesh = 202;
  faReduceMode0 = 203;
  faReduceMode1 = 204;
  faReduceMode2 = 205;
  faReduceMode3 = 206;

  { MeshSize }
  faMeshSize4 = 207;
  faMeshSize8 = 208;
  faMeshSize16 = 209;
  faMeshSize32 = 210;
  faMeshSize64 = 211;
  faMeshSize128 = 212;
  faMeshSize256 = 213;
  faMeshSize316 = 214;
  faMeshSize512 = 215;
  faMeshSize1024 = 216;

  { MeshExport }
  faWantBottom = 217;
  faWantBottomMirrored = 218;
  faWantSideCaps = 219;
  faTestSingleSide = 220;
  faTakeCapValueSnapshot = 221;

  { MeshExportCoords }
  faExportCoordsNative = 222;
  faExportCoordsBlender = 223;
  faExportCoords3DV = 224;
  faExportCoords3DP = 225;

  { MeshOptions }
  faTextureJitt = 226;
  faTextureJack = 227;

  { ExporterOBJ }
  faWantAutoFolder = 228;
  faExportMtl = 229;
  faExportObj = 230;
  faWantMaterial = 231;
  faWantSimpleName = 232;
  faWantAngularDir = 233;
  faWantNormals = 234;
  faWantUVs = 235;
  faObjDigits2 = 236;
  faObjDigits3 = 237;
  faObjDigits4 = 238;
  faObjDigits5 = 239;

  { MeshFigures }
  faToggleMarker = 240;
  faToggleGrid = 241;
  faToggleGridFrequency = 242;
  faToggleDiameter3 = 243;
  faDiameter3On = 244;
  faDiameter3Off = 245;
  faToggleCylinder = 246;
  faToggleCube = 247;
  faToggleCorner = 248;
  faToggleLimitPlane = 249;

  { VertexPulling }
  faToggleZeroPulling = 250;
  faToggleLimitPulling = 251;
  faToggleSlicePulling = 252;
  faToggleTargetPulling = 253;
  faToggleRightPulling = 254;
  faToggleCrackFixing = 255;

  { MeshBuilderOptions }
  faToggleSolidFlip = 256;
  faWantSpecialY = 257;
  faToggleShowEdges = 258;
  faUniqueMode1 = 259;
  faUniqueMode2 = 260;
  faToggleUniqueVertices = 261;

  { Pin }
  faTogglePin = 262;
  faPinOn = 263;
  faPinOff = 264;

  { Norm }
  faToggleNorm = 265;
  faNormOn = 266;
  faNormOff = 267;

  { TextureNorm }
  faTextureNormP = 268;
  faTextureNormM = 269;
  faTextureNorm0 = 270;
  faTextureNorm1 = 271;
  faTextureNorm2 = 272;

  { TextureExport }
  faCopyBinCode = 273;
  faCopyBinCodeTest = 274;

  { TextureImport }
  faTextureClear = 275;

  { ColorMix }
  faColorMix0 = 276;
  faColorMix1 = 277;
  faColorMix2 = 278;
  faColorMix3 = 279;
  faColorMix4 = 280;
  faColorMix5 = 281;
  faColorMixP = 282;
  faColorMixM = 283;

  { ColorSwat }
  faToggleColorSwat = 284;

  { Lux }
  faLux1On = 285;
  faLux1Off = 286;
  faToggleLux1 = 287;
  faLux2On = 288;
  faLux2Off = 289;
  faToggleLux2 = 290;
  faLux3On = 291;
  faLux3Off = 292;
  faToggleLux3 = 293;
  faLux4On = 294;
  faLux4Off = 295;
  faToggleLux4 = 296;
  faLuxOn = 297;
  faLuxOff = 298;
  faToggleLux = 299;

  { LuxMarker }
  faLuxMarkerOn = 300;
  faLuxMarkerOff = 301;
  faToggleLuxMarker = 302;

  { LightMode }
  faLightMode0 = 303;
  faLightMode1 = 304;
  faLightMode2 = 305;
  faLightMode3 = 306;
  faLightMode4 = 307;

  { ResetLight }
  faResetLightPosition = 308;
  faResetLightParams = 309;

  { Wheel }
  faParamValuePlus1 = 310;
  faParamValueMinus1 = 311;
  faParamValuePlus10 = 312;
  faParamValueMinus10 = 313;
  faWheelLeft = 314;
  faWheelRight = 315;
  faWheelDown = 316;
  faWheelUp = 317;

  { WheelFrequency }
  faWheelFrequency1 = 318;
  faWheelFrequency05 = 319;
  faWheelFrequency02 = 320;
  faWheelFrequency01 = 321;
  faWheelFrequency001 = 322;
  faWheelFrequency0001 = 323;

  { ColorScheme }
  faCycleColorSchemeM = 324;
  faCycleColorSchemeP = 325;

  { AnimatedRotations }
  faRotX = 326;
  faRotY = 327;
  faRotZ = 328;
  faRotXM = 329;
  faRotXP = 330;
  faRotYM = 331;
  faRotYP = 332;
  faRotZM = 333;
  faRotZP = 334;

  { Step }
  faStepRXM = 335;
  faStepRXP = 336;
  faStepRYM = 337;
  faStepRYP = 338;
  faStepRZM = 339;
  faStepRZP = 340;
  faStepCZM = 341;
  faStepCZP = 342;

  { UI }
  faParamLabelTextX = 343;
  faParamLabelTextY = 344;
  faParamLabelTextZ = 345;
  faToggleColorPanel = 346;
  faColorPanelOn = 347;
  faColorPanelOff = 348;
  faShowEditField = 349;
  faFocusEditField = 350;
  faInitSpecial = 351;
  faPaletteOn = 352;
  faPaletteOff = 353;

  { Locks }
  faToggleLuxLock = 354;
  faToggleParamLock = 355;
  faToggleTextureLock = 356;
  faToggleBackgroundLock = 357;
  faToggleForceLock = 358;
  faToggleReportLock = 359;

  { Opacity }
  faToggleOpacity = 360;
  faOpacityOn = 361;
  faOpacityOff = 362;

  { MainMenuActivation }
  faMainMenuHide = 363;
  faMainMenuShow = 364;

  { FederText }
  faToggleAllText = 365;
  faToggleTouchFrame = 366;

  { ViewParams }
  faPan = 367;
  faParamRX = 368;
  faParamRY = 369;
  faParamRZ = 370;
  faParamCZ = 371;

  { ViewParamsFC }
  faRotStep0 = 372;
  faRotStep1 = 373;
  faRotStep2 = 374;
  faRotStep3 = 375;
  faRotStepA = 376;
  faParamTRS = 377;
  faParamTRT = 378;
  faParamTRX = 379;
  faParamTRY = 380;

  { ParamT }
  faParamT1 = 381;
  faParamT2 = 382;
  faParamT3 = 383;
  faParamT4 = 384;

  { ViewFlags }
  faToggleBMap = 385;
  faToggleZoom = 386;
  faToggleTouchMenu = 387;
  faToggleEquationText = 388;
  faTogglePrimeText = 389;
  faToggleSecondText = 390;
  faToggleLabelText = 391;
  faLabelBatchM = 392;
  faLabelBatchP = 393;
  faLabelTextP = 394;
  faLabelTextM = 395;

  { Report }
  faCopyShortCutReport = 396;
  faWriteActionReport = 397;
  faWriteActionTable = 398;
  faWriteActionConst = 399;
  faWriteActionNames = 400;
  faWriteVersion1 = 401;
  faWriteVersion2 = 402;
  faWriteCode = 403;
  faWriteDiff1 = 404;
  faWriteDiffCode = 405;
  faWriteDiffBin = 406;
  faWriteBandInfo3 = 407;
  faWriteBandInfo5 = 408;
  faWriteEquationInfo = 409;
  faWriteVirtual = 410;
  faBlockTest = 411;

  { ReportOptions }
  faSourcePascal = 412;
  faSourceMaxima = 413;
  faSourceMaple = 414;
  faSourceMathematica = 415;

  { CopyImage }
  faCopyScreenshot = 416;
  faCopyBitmap3D = 417;
  faCopyTextureBitmap = 418;
  faCopyImprintedBitmap = 419;
  faCopyImprintedBitmapTest = 420;

  { CopyOptions }
  faToggleHardCopy = 421;
  faHardCopyOn = 422;
  faHardCopyOff = 423;
  faTogglePngCopy = 424;
  faPngCopyOn = 425;
  faPngCopyOff = 426;
  faToggleNoCopy = 427;
  faNoCopyOn = 428;
  faNoCopyOff = 429;

  { GraphOptions }
  faToggleDiameter = 430;
  faToggleProbe = 431;

  { Bahn }
  faNorthCap = 432;
  faSouthCap = 433;
  faEastCap = 434;
  faWestCap = 435;
  faParamCapValue = 436;
  faParamBahnRadius = 437;
  faParamBahnPositionX = 438;
  faParamBahnPositionY = 439;
  faParamBahnAngle = 440;
  faParamBahnCylinderD = 441;
  faParamBahnCylinderZ = 442;

  { AnimationStore }
  faRecall1 = 443;
  faRecall2 = 444;
  faMemory1 = 445;
  faMemory2 = 446;
  faTransit = 447;

  { AnimPlay }
  faPlay = 448;
  faExecute = 449;
  faAnimationStop = 450;
  faAnimationStartA = 451;
  faAnimationStartD = 452;
  faAnimationStartF = 453;
  faAnimationStartS = 454;
  faAnimationStartT = 455;

  { Transit }
  faTransitionAll = 456;
  faTransitionScript = 457;

  { Connect }
  faConnect = 458;
  faDisconnect = 459;
  faDownload = 460;
  faAutoSend = 461;
  faAutoSendOn = 462;
  faAutoSendOff = 463;

  { ExampleData }
  faExample01 = 464;
  faExample02 = 465;
  faExample03 = 466;
  faExample04 = 467;
  faExample05 = 468;
  faExample06 = 469;
  faExample07 = 470;
  faExample08 = 471;
  faExample09 = 472;

  { Repo }
  faSwapBundle = 473;
  faRepo010 = 474;
  faRepo020 = 475;
  faRepo050 = 476;

  { SampleNavigation }
  faLevelM = 477;
  faLevelP = 478;
  faHubM = 479;
  faHubP = 480;
  faSampleM = 481;
  faSampleP = 482;
  faGotoSample0 = 483;
  faGotoSample1 = 484;

  { DebugOptions }
  faTestBtnClick = 485;
  faRunBinPixelTest = 486;

  { EmptyLastLine }
  faELLOn = 487;
  faELLOff = 488;

  { Help }
  faToggleHelp = 489;
  faToggleReport = 490;
  faToggleButtonReport = 491;
  faCycleHelpM = 492;
  faCycleHelpP = 493;
  faHelpCycle = 494;
  faHelpList = 495;
  faHelpHome = 496;

  { BtnLegendTablet }
  faTL01 = 497;
  faTL02 = 498;
  faTL03 = 499;
  faTL04 = 500;
  faTL05 = 501;
  faTL06 = 502;
  faTR01 = 503;
  faTR02 = 504;
  faTR03 = 505;
  faTR04 = 506;
  faTR05 = 507;
  faTR06 = 508;
  faTR07 = 509;
  faTR08 = 510;
  faBL01 = 511;
  faBL02 = 512;
  faBL03 = 513;
  faBL04 = 514;
  faBL05 = 515;
  faBL06 = 516;
  faBL07 = 517;
  faBL08 = 518;
  faBR01 = 519;
  faBR02 = 520;
  faBR03 = 521;
  faBR04 = 522;
  faBR05 = 523;
  faBR06 = 524;

  { BtnLegendPhone }
  faMB01 = 525;
  faMB02 = 526;
  faMB03 = 527;
  faMB04 = 528;
  faMB05 = 529;
  faMB06 = 530;
  faMB07 = 531;
  faMB08 = 532;

  { TouchBarLegend }
  faTouchBarTop = 533;
  faTouchBarBottom = 534;
  faTouchBarLeft = 535;
  faTouchBarRight = 536;

  { Reset }
  faReset = 537;
  faResetPosition = 538;
  faResetRotation = 539;
  faResetZoom = 540;

  { DropTarget }
  faToggleDropTarget = 541;

  { Language }
  faToggleLanguage = 542;

  { CopyPaste }
  faSave = 543;
  faLoad = 544;
  faOpen = 545;
  faCopy = 546;
  faPaste = 547;

  { ViewOptions }
  faToggleMoveMode = 548;
  faLinearMove = 549;
  faExpoMove = 550;
  faToggleQuickMesh = 551;
  faToggleOrbitMode = 552;

  { BitmapCycle }
  faCycleBitmapM = 553;
  faCycleBitmapP = 554;
  faRandom = 555;
  faRandomWhite = 556;
  faRandomBlack = 557;
  faRandomBambu1 = 558;
  faRandomBambu2 = 559;
  faBitmapEscape = 560;
  faBitmapOne = 561;
  faToggleContour = 562;

  { Layout0 }
  faLayout0 = 563;
  faLayout1 = 564;
  faLayout2 = 565;
  faLayout3 = 566;
  faLayout4 = 567;
  faLayout5 = 568;
  faLayout6 = 569;
  faLayout7 = 570;
  faLayout8 = 571;
  faLayout9 = 572;

  { Layout1 }
  faLayout10 = 573;
  faLayout11 = 574;
  faLayout12 = 575;
  faLayout13 = 576;
  faLayout14 = 577;
  faLayout15 = 578;
  faLayout16 = 579;
  faLayout17 = 580;
  faLayout18 = 581;
  faLayout19 = 582;

  { Layout2 }
  faLayout20 = 583;
  faLayout21 = 584;
  faLayout22 = 585;
  faLayout23 = 586;
  faLayout24 = 587;
  faLayout25 = 588;
  faLayout26 = 589;
  faLayout27 = 590;
  faLayout28 = 591;
  faLayout29 = 592;

  { Layout3 }
  faLayout30 = 593;
  faLayout31 = 594;
  faLayout32 = 595;
  faLayout33 = 596;
  faLayout34 = 597;
  faLayout35 = 598;
  faLayout36 = 599;
  faLayout37 = 600;
  faLayout38 = 601;
  faLayout39 = 602;

  { Layout4 }
  faLayout40 = 603;
  faLayout41 = 604;
  faLayout42 = 605;
  faLayout43 = 606;
  faLayout44 = 607;
  faLayout45 = 608;
  faLayout46 = 609;
  faLayout47 = 610;
  faLayout48 = 611;
  faLayout49 = 612;

  { Layout5 }
  faLayout50 = 613;
  faLayout51 = 614;
  faLayout52 = 615;
  faLayout53 = 616;
  faLayout54 = 617;
  faLayout55 = 618;
  faLayout56 = 619;
  faLayout57 = 620;
  faLayout58 = 621;
  faLayout59 = 622;

  { Layout6 }
  faLayout60 = 623;
  faLayout61 = 624;
  faLayout62 = 625;
  faLayout63 = 626;
  faLayout64 = 627;
  faLayout65 = 628;
  faLayout66 = 629;
  faLayout67 = 630;
  faLayout68 = 631;
  faLayout69 = 632;

  { Layout7 }
  faLayout70 = 633;
  faLayout71 = 634;
  faLayout72 = 635;
  faLayout73 = 636;
  faLayout74 = 637;
  faLayout75 = 638;
  faLayout76 = 639;
  faLayout77 = 640;
  faLayout78 = 641;
  faLayout79 = 642;

  { Layout8 }
  faLayout80 = 643;
  faLayout81 = 644;
  faLayout82 = 645;
  faLayout83 = 646;
  faLayout84 = 647;
  faLayout85 = 648;
  faLayout86 = 649;
  faLayout87 = 650;
  faLayout88 = 651;
  faLayout89 = 652;

  { Layout9 }
  faLayout90 = 653;
  faLayout91 = 654;
  faLayout92 = 655;
  faLayout93 = 656;
  faLayout94 = 657;
  faLayout95 = 658;
  faLayout96 = 659;
  faLayout97 = 660;
  faLayout98 = 661;
  faLayout99 = 662;

  { MenuNav }
  faMenuXX = 663;
  faMenu00 = 664;
  faMenu10 = 665;
  faMenu20 = 666;
  faMenu30 = 667;
  faMenu40 = 668;
  faMenu50 = 669;
  faMenu60 = 670;
  faMenu70 = 671;
  faMenu80 = 672;
  faMenu90 = 673;

  { FigureSize }
  faFigureSizeXS = 674;
  faFigureSizeS = 675;
  faFigureSizeM = 676;
  faFigureSizeL = 677;
  faFigureSizeXL = 678;

  { EyeSize }
  faEyeSizeS = 679;
  faEyeSizeM = 680;
  faEyeSizeL = 681;

  { LayerSelection }
  faSelectLayer1 = 682;
  faSelectLayer2 = 683;
  faSelectLayer3 = 684;
  faSelectLayer4 = 685;
  faSelectLayer5 = 686;
  faSelectLayer6 = 687;
  faSelectLayer7 = 688;

  { ColorSelection }
  faSelectColor1 = 689;
  faSelectColor2 = 690;
  faSelectColor3 = 691;
  faSelectColor4 = 692;

  { ColorMapping }
  faCLA = 693;
  faMapColorToLayer = 694;
  faSelectColorMapping1 = 695;
  faSelectColorMapping2 = 696;
  faSelectColorMapping3 = 697;
  faSelectColorMapping4 = 698;
  faSelectColorMapping5 = 699;
  faSelectColorMapping6 = 700;

  faMax = 701;

implementation

end.
