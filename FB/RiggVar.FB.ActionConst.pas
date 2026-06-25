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

  { Keyboard }
  faKeyboard01 = 343;
  faKeyboard02 = 344;
  faSetShift = 345;
  faSetCtrl = 346;
  faClearShift = 347;

  { UI }
  faParamLabelTextX = 348;
  faParamLabelTextY = 349;
  faParamLabelTextZ = 350;
  faToggleColorPanel = 351;
  faColorPanelOn = 352;
  faColorPanelOff = 353;
  faShowEditField = 354;
  faFocusEditField = 355;
  faInitSpecial = 356;
  faPaletteOn = 357;
  faPaletteOff = 358;

  { Locks }
  faToggleLuxLock = 359;
  faToggleParamLock = 360;
  faToggleTextureLock = 361;
  faToggleBackgroundLock = 362;
  faToggleForceLock = 363;
  faToggleReportLock = 364;

  { Opacity }
  faToggleOpacity = 365;
  faOpacityOn = 366;
  faOpacityOff = 367;

  { MainMenuActivation }
  faMainMenuHide = 368;
  faMainMenuShow = 369;

  { FederText }
  faToggleAllText = 370;
  faToggleTouchFrame = 371;

  { ViewParams }
  faPan = 372;
  faParamRX = 373;
  faParamRY = 374;
  faParamRZ = 375;
  faParamCZ = 376;

  { ViewParamsFC }
  faRotStep0 = 377;
  faRotStep1 = 378;
  faRotStep2 = 379;
  faRotStep3 = 380;
  faRotStepA = 381;
  faParamTRS = 382;
  faParamTRT = 383;
  faParamTRX = 384;
  faParamTRY = 385;

  { ParamT }
  faParamT1 = 386;
  faParamT2 = 387;
  faParamT3 = 388;
  faParamT4 = 389;

  { ViewFlags }
  faToggleBMap = 390;
  faToggleZoom = 391;
  faToggleTouchMenu = 392;
  faToggleEquationText = 393;
  faTogglePrimeText = 394;
  faToggleSecondText = 395;
  faToggleLabelText = 396;
  faLabelBatchM = 397;
  faLabelBatchP = 398;
  faLabelTextP = 399;
  faLabelTextM = 400;

  { Report }
  faCopyShortCutReport = 401;
  faWriteActionReport = 402;
  faWriteActionTable = 403;
  faWriteActionConst = 404;
  faWriteActionNames = 405;
  faWriteVersion1 = 406;
  faWriteVersion2 = 407;
  faWriteCode = 408;
  faWriteDiff1 = 409;
  faWriteDiffCode = 410;
  faWriteDiffBin = 411;
  faWriteBandInfo3 = 412;
  faWriteBandInfo5 = 413;
  faWriteEquationInfo = 414;
  faWriteVirtual = 415;
  faBlockTest = 416;

  { ReportOptions }
  faSourcePascal = 417;
  faSourceMaxima = 418;
  faSourceMaple = 419;
  faSourceMathematica = 420;

  { CopyImage }
  faCopyScreenshot = 421;
  faCopyBitmap3D = 422;
  faCopyTextureBitmap = 423;
  faCopyImprintedBitmap = 424;
  faCopyImprintedBitmapTest = 425;

  { CopyOptions }
  faToggleHardCopy = 426;
  faHardCopyOn = 427;
  faHardCopyOff = 428;
  faTogglePngCopy = 429;
  faPngCopyOn = 430;
  faPngCopyOff = 431;
  faToggleNoCopy = 432;
  faNoCopyOn = 433;
  faNoCopyOff = 434;

  { GraphOptions }
  faToggleDiameter = 435;
  faToggleProbe = 436;

  { Bahn }
  faNorthCap = 437;
  faSouthCap = 438;
  faEastCap = 439;
  faWestCap = 440;
  faParamCapValue = 441;
  faParamBahnRadius = 442;
  faParamBahnPositionX = 443;
  faParamBahnPositionY = 444;
  faParamBahnAngle = 445;
  faParamBahnCylinderD = 446;
  faParamBahnCylinderZ = 447;

  { AnimationStore }
  faRecall1 = 448;
  faRecall2 = 449;
  faMemory1 = 450;
  faMemory2 = 451;
  faTransit = 452;

  { AnimPlay }
  faPlay = 453;
  faExecute = 454;
  faAnimationStop = 455;
  faAnimationStartA = 456;
  faAnimationStartD = 457;
  faAnimationStartF = 458;
  faAnimationStartS = 459;
  faAnimationStartT = 460;

  { Transit }
  faTransitionAll = 461;
  faTransitionScript = 462;

  { Connect }
  faConnect = 463;
  faDisconnect = 464;
  faDownload = 465;
  faAutoSend = 466;
  faAutoSendOn = 467;
  faAutoSendOff = 468;

  { ExampleData }
  faExample01 = 469;
  faExample02 = 470;
  faExample03 = 471;
  faExample04 = 472;
  faExample05 = 473;
  faExample06 = 474;
  faExample07 = 475;
  faExample08 = 476;
  faExample09 = 477;

  { Repo }
  faSwapBundle = 478;
  faRepo010 = 479;
  faRepo020 = 480;
  faRepo050 = 481;

  { SampleNavigation }
  faLevelM = 482;
  faLevelP = 483;
  faHubM = 484;
  faHubP = 485;
  faSampleM = 486;
  faSampleP = 487;
  faGotoSample0 = 488;
  faGotoSample1 = 489;

  { DebugOptions }
  faTestBtnClick = 490;
  faRunBinPixelTest = 491;

  { EmptyLastLine }
  faELLOn = 492;
  faELLOff = 493;

  { Help }
  faToggleHelp = 494;
  faToggleReport = 495;
  faToggleButtonReport = 496;
  faCycleHelpM = 497;
  faCycleHelpP = 498;
  faHelpCycle = 499;
  faHelpList = 500;
  faHelpHome = 501;

  { BtnLegendTablet }
  faTL01 = 502;
  faTL02 = 503;
  faTL03 = 504;
  faTL04 = 505;
  faTL05 = 506;
  faTL06 = 507;
  faTR01 = 508;
  faTR02 = 509;
  faTR03 = 510;
  faTR04 = 511;
  faTR05 = 512;
  faTR06 = 513;
  faTR07 = 514;
  faTR08 = 515;
  faBL01 = 516;
  faBL02 = 517;
  faBL03 = 518;
  faBL04 = 519;
  faBL05 = 520;
  faBL06 = 521;
  faBL07 = 522;
  faBL08 = 523;
  faBR01 = 524;
  faBR02 = 525;
  faBR03 = 526;
  faBR04 = 527;
  faBR05 = 528;
  faBR06 = 529;

  { BtnLegendPhone }
  faMB01 = 530;
  faMB02 = 531;
  faMB03 = 532;
  faMB04 = 533;
  faMB05 = 534;
  faMB06 = 535;
  faMB07 = 536;
  faMB08 = 537;

  { TouchBarLegend }
  faTouchBarTop = 538;
  faTouchBarBottom = 539;
  faTouchBarLeft = 540;
  faTouchBarRight = 541;

  { Reset }
  faReset = 542;
  faResetPosition = 543;
  faResetRotation = 544;
  faResetZoom = 545;

  { DropTarget }
  faToggleDropTarget = 546;

  { Language }
  faToggleLanguage = 547;

  { CopyPaste }
  faSave = 548;
  faLoad = 549;
  faOpen = 550;
  faCopy = 551;
  faPaste = 552;

  { ViewOptions }
  faToggleMoveMode = 553;
  faLinearMove = 554;
  faExpoMove = 555;
  faToggleQuickMesh = 556;
  faToggleOrbitMode = 557;

  { BitmapCycle }
  faCycleBitmapM = 558;
  faCycleBitmapP = 559;
  faRandom = 560;
  faRandomWhite = 561;
  faRandomBlack = 562;
  faRandomBambu1 = 563;
  faRandomBambu2 = 564;
  faBitmapEscape = 565;
  faBitmapOne = 566;
  faToggleContour = 567;

  { Layout0 }
  faLayout0 = 568;
  faLayout1 = 569;
  faLayout2 = 570;
  faLayout3 = 571;
  faLayout4 = 572;
  faLayout5 = 573;
  faLayout6 = 574;
  faLayout7 = 575;
  faLayout8 = 576;
  faLayout9 = 577;

  { Layout1 }
  faLayout10 = 578;
  faLayout11 = 579;
  faLayout12 = 580;
  faLayout13 = 581;
  faLayout14 = 582;
  faLayout15 = 583;
  faLayout16 = 584;
  faLayout17 = 585;
  faLayout18 = 586;
  faLayout19 = 587;

  { Layout2 }
  faLayout20 = 588;
  faLayout21 = 589;
  faLayout22 = 590;
  faLayout23 = 591;
  faLayout24 = 592;
  faLayout25 = 593;
  faLayout26 = 594;
  faLayout27 = 595;
  faLayout28 = 596;
  faLayout29 = 597;

  { Layout3 }
  faLayout30 = 598;
  faLayout31 = 599;
  faLayout32 = 600;
  faLayout33 = 601;
  faLayout34 = 602;
  faLayout35 = 603;
  faLayout36 = 604;
  faLayout37 = 605;
  faLayout38 = 606;
  faLayout39 = 607;

  { Layout4 }
  faLayout40 = 608;
  faLayout41 = 609;
  faLayout42 = 610;
  faLayout43 = 611;
  faLayout44 = 612;
  faLayout45 = 613;
  faLayout46 = 614;
  faLayout47 = 615;
  faLayout48 = 616;
  faLayout49 = 617;

  { Layout5 }
  faLayout50 = 618;
  faLayout51 = 619;
  faLayout52 = 620;
  faLayout53 = 621;
  faLayout54 = 622;
  faLayout55 = 623;
  faLayout56 = 624;
  faLayout57 = 625;
  faLayout58 = 626;
  faLayout59 = 627;

  { Layout6 }
  faLayout60 = 628;
  faLayout61 = 629;
  faLayout62 = 630;
  faLayout63 = 631;
  faLayout64 = 632;
  faLayout65 = 633;
  faLayout66 = 634;
  faLayout67 = 635;
  faLayout68 = 636;
  faLayout69 = 637;

  { Layout7 }
  faLayout70 = 638;
  faLayout71 = 639;
  faLayout72 = 640;
  faLayout73 = 641;
  faLayout74 = 642;
  faLayout75 = 643;
  faLayout76 = 644;
  faLayout77 = 645;
  faLayout78 = 646;
  faLayout79 = 647;

  { Layout8 }
  faLayout80 = 648;
  faLayout81 = 649;
  faLayout82 = 650;
  faLayout83 = 651;
  faLayout84 = 652;
  faLayout85 = 653;
  faLayout86 = 654;
  faLayout87 = 655;
  faLayout88 = 656;
  faLayout89 = 657;

  { Layout9 }
  faLayout90 = 658;
  faLayout91 = 659;
  faLayout92 = 660;
  faLayout93 = 661;
  faLayout94 = 662;
  faLayout95 = 663;
  faLayout96 = 664;
  faLayout97 = 665;
  faLayout98 = 666;
  faLayout99 = 667;

  { MenuNav }
  faMenuXX = 668;
  faMenu00 = 669;
  faMenu10 = 670;
  faMenu20 = 671;
  faMenu30 = 672;
  faMenu40 = 673;
  faMenu50 = 674;
  faMenu60 = 675;
  faMenu70 = 676;
  faMenu80 = 677;
  faMenu90 = 678;

  { FigureSize }
  faFigureSizeXS = 679;
  faFigureSizeS = 680;
  faFigureSizeM = 681;
  faFigureSizeL = 682;
  faFigureSizeXL = 683;

  { EyeSize }
  faEyeSizeS = 684;
  faEyeSizeM = 685;
  faEyeSizeL = 686;

  { LayerSelection }
  faSelectLayer1 = 687;
  faSelectLayer2 = 688;
  faSelectLayer3 = 689;
  faSelectLayer4 = 690;
  faSelectLayer5 = 691;
  faSelectLayer6 = 692;
  faSelectLayer7 = 693;

  { ColorSelection }
  faSelectColor1 = 694;
  faSelectColor2 = 695;
  faSelectColor3 = 696;
  faSelectColor4 = 697;

  { ColorMapping }
  faCLA = 698;
  faMapColorToLayer = 699;
  faSelectColorMapping1 = 700;
  faSelectColorMapping2 = 701;
  faSelectColorMapping3 = 702;
  faSelectColorMapping4 = 703;
  faSelectColorMapping5 = 704;
  faSelectColorMapping6 = 705;

  faMax = 706;

implementation

end.
