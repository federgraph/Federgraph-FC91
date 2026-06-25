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
  faOpenMesh = 194;
  faPolarMesh = 195;
  faReducedMesh = 196;
  faReduceMode0 = 197;
  faReduceMode1 = 198;
  faReduceMode2 = 199;
  faReduceMode3 = 200;

  { MeshSize }
  faMeshSize4 = 201;
  faMeshSize8 = 202;
  faMeshSize16 = 203;
  faMeshSize32 = 204;
  faMeshSize64 = 205;
  faMeshSize128 = 206;
  faMeshSize256 = 207;
  faMeshSize316 = 208;
  faMeshSize512 = 209;
  faMeshSize1024 = 210;

  { MeshExport }
  faWantBottom = 211;
  faWantBottomMirrored = 212;
  faWantSideCaps = 213;
  faTestSingleSide = 214;
  faTakeCapValueSnapshot = 215;

  { MeshExportCoords }
  faExportCoordsNative = 216;
  faExportCoordsBlender = 217;
  faExportCoords3DV = 218;
  faExportCoords3DP = 219;

  { MeshOptions }
  faTextureJitt = 220;
  faTextureJack = 221;

  { ExporterOBJ }
  faWantAutoFolder = 222;
  faExportMtl = 223;
  faExportObj = 224;
  faWantMaterial = 225;
  faWantSimpleName = 226;
  faWantAngularDir = 227;
  faWantNormals = 228;
  faWantUVs = 229;
  faObjDigits2 = 230;
  faObjDigits3 = 231;
  faObjDigits4 = 232;
  faObjDigits5 = 233;

  { MeshFigures }
  faToggleMarker = 234;
  faToggleGrid = 235;
  faToggleGridFrequency = 236;
  faToggleDiameter3 = 237;
  faDiameter3On = 238;
  faDiameter3Off = 239;
  faToggleCylinder = 240;
  faToggleCube = 241;
  faToggleCorner = 242;
  faToggleLimitPlane = 243;

  { VertexPulling }
  faToggleZeroPulling = 244;
  faToggleLimitPulling = 245;
  faToggleSlicePulling = 246;
  faToggleTargetPulling = 247;
  faToggleRightPulling = 248;
  faToggleCrackFixing = 249;

  { MeshBuilderOptions }
  faToggleSolidFlip = 250;
  faWantSpecialY = 251;
  faToggleShowEdges = 252;
  faUniqueMode1 = 253;
  faUniqueMode2 = 254;
  faToggleUniqueVertices = 255;

  { Pin }
  faTogglePin = 256;
  faPinOn = 257;
  faPinOff = 258;

  { Norm }
  faToggleNorm = 259;
  faNormOn = 260;
  faNormOff = 261;

  { TextureNorm }
  faTextureNormP = 262;
  faTextureNormM = 263;
  faTextureNorm0 = 264;
  faTextureNorm1 = 265;
  faTextureNorm2 = 266;

  { TextureExport }
  faCopyBinCode = 267;
  faCopyBinCodeTest = 268;

  { TextureImport }
  faTextureClear = 269;

  { ColorMix }
  faColorMix0 = 270;
  faColorMix1 = 271;
  faColorMix2 = 272;
  faColorMix3 = 273;
  faColorMix4 = 274;
  faColorMix5 = 275;
  faColorMixP = 276;
  faColorMixM = 277;

  { ColorSwat }
  faToggleColorSwat = 278;

  { Lux }
  faLux1On = 279;
  faLux1Off = 280;
  faToggleLux1 = 281;
  faLux2On = 282;
  faLux2Off = 283;
  faToggleLux2 = 284;
  faLux3On = 285;
  faLux3Off = 286;
  faToggleLux3 = 287;
  faLux4On = 288;
  faLux4Off = 289;
  faToggleLux4 = 290;
  faLuxOn = 291;
  faLuxOff = 292;
  faToggleLux = 293;

  { LuxMarker }
  faLuxMarkerOn = 294;
  faLuxMarkerOff = 295;
  faToggleLuxMarker = 296;

  { LightMode }
  faLightMode0 = 297;
  faLightMode1 = 298;
  faLightMode2 = 299;
  faLightMode3 = 300;
  faLightMode4 = 301;

  { ResetLight }
  faResetLightPosition = 302;
  faResetLightParams = 303;

  { Wheel }
  faParamValuePlus1 = 304;
  faParamValueMinus1 = 305;
  faParamValuePlus10 = 306;
  faParamValueMinus10 = 307;
  faWheelLeft = 308;
  faWheelRight = 309;
  faWheelDown = 310;
  faWheelUp = 311;

  { WheelFrequency }
  faWheelFrequency1 = 312;
  faWheelFrequency05 = 313;
  faWheelFrequency02 = 314;
  faWheelFrequency01 = 315;
  faWheelFrequency001 = 316;
  faWheelFrequency0001 = 317;

  { ColorScheme }
  faCycleColorSchemeM = 318;
  faCycleColorSchemeP = 319;

  { Step }
  faStepRXM = 320;
  faStepRXP = 321;
  faStepRYM = 322;
  faStepRYP = 323;
  faStepRZM = 324;
  faStepRZP = 325;
  faStepCZM = 326;
  faStepCZP = 327;

  { UI }
  faToggleColorPanel = 328;
  faColorPanelOn = 329;
  faColorPanelOff = 330;
  faPaletteOn = 331;
  faPaletteOff = 332;

  { Locks }
  faToggleLuxLock = 333;
  faToggleParamLock = 334;
  faToggleTextureLock = 335;
  faToggleBackgroundLock = 336;
  faToggleForceLock = 337;
  faToggleReportLock = 338;

  { Opacity }
  faToggleOpacity = 339;
  faOpacityOn = 340;
  faOpacityOff = 341;

  { FederText }
  faToggleAllText = 342;
  faToggleTouchFrame = 343;

  { ViewParams }
  faPan = 344;
  faParamRX = 345;
  faParamRY = 346;
  faParamRZ = 347;
  faParamCZ = 348;

  { ViewParamsFC }
  faParamTRS = 349;
  faParamTRT = 350;
  faParamTRX = 351;
  faParamTRY = 352;

  { ParamT }
  faParamT1 = 353;
  faParamT2 = 354;
  faParamT3 = 355;
  faParamT4 = 356;

  { ViewFlags }
  faToggleBMap = 357;
  faToggleZoom = 358;
  faToggleTouchMenu = 359;
  faToggleEquationText = 360;
  faTogglePrimeText = 361;
  faToggleSecondText = 362;
  faToggleLabelText = 363;
  faLabelBatchM = 364;
  faLabelBatchP = 365;
  faLabelTextP = 366;
  faLabelTextM = 367;

  { Report }
  faCopyShortCutReport = 368;
  faWriteActionReport = 369;
  faWriteActionTable = 370;
  faWriteActionConst = 371;
  faWriteActionNames = 372;
  faWriteVersion1 = 373;
  faWriteVersion2 = 374;
  faWriteCode = 375;
  faWriteDiff1 = 376;
  faWriteDiffCode = 377;
  faWriteDiffBin = 378;
  faWriteBandInfo3 = 379;
  faWriteBandInfo5 = 380;
  faWriteEquationInfo = 381;
  faWriteVirtual = 382;
  faBlockTest = 383;

  { ReportOptions }
  faSourcePascal = 384;
  faSourceMaxima = 385;
  faSourceMaple = 386;
  faSourceMathematica = 387;

  { CopyImage }
  faCopyScreenshot = 388;
  faCopyBitmap3D = 389;
  faCopyTextureBitmap = 390;
  faCopyImprintedBitmap = 391;
  faCopyImprintedBitmapTest = 392;

  { CopyOptions }
  faToggleHardCopy = 393;
  faHardCopyOn = 394;
  faHardCopyOff = 395;
  faTogglePngCopy = 396;
  faPngCopyOn = 397;
  faPngCopyOff = 398;
  faToggleNoCopy = 399;
  faNoCopyOn = 400;
  faNoCopyOff = 401;

  { GraphOptions }
  faToggleDiameter = 402;
  faToggleProbe = 403;

  { Bahn }
  faNorthCap = 404;
  faSouthCap = 405;
  faEastCap = 406;
  faWestCap = 407;
  faParamCapValue = 408;
  faParamBahnRadius = 409;
  faParamBahnPositionX = 410;
  faParamBahnPositionY = 411;
  faParamBahnAngle = 412;
  faParamBahnCylinderD = 413;
  faParamBahnCylinderZ = 414;

  { ExampleData }
  faExample01 = 415;
  faExample02 = 416;
  faExample03 = 417;
  faExample04 = 418;
  faExample05 = 419;
  faExample06 = 420;
  faExample07 = 421;
  faExample08 = 422;
  faExample09 = 423;

  { Repo }
  faSwapBundle = 424;
  faRepo010 = 425;
  faRepo020 = 426;
  faRepo050 = 427;

  { SampleNavigation }
  faLevelM = 428;
  faLevelP = 429;
  faHubM = 430;
  faHubP = 431;
  faSampleM = 432;
  faSampleP = 433;
  faGotoSample0 = 434;
  faGotoSample1 = 435;

  { Help }
  faToggleHelp = 436;
  faToggleReport = 437;
  faToggleButtonReport = 438;
  faCycleHelpM = 439;
  faCycleHelpP = 440;
  faHelpCycle = 441;
  faHelpList = 442;
  faHelpHome = 443;

  { BtnLegendTablet }
  faTL01 = 444;
  faTL02 = 445;
  faTL03 = 446;
  faTL04 = 447;
  faTL05 = 448;
  faTL06 = 449;
  faTR01 = 450;
  faTR02 = 451;
  faTR03 = 452;
  faTR04 = 453;
  faTR05 = 454;
  faTR06 = 455;
  faTR07 = 456;
  faTR08 = 457;
  faBL01 = 458;
  faBL02 = 459;
  faBL03 = 460;
  faBL04 = 461;
  faBL05 = 462;
  faBL06 = 463;
  faBL07 = 464;
  faBL08 = 465;
  faBR01 = 466;
  faBR02 = 467;
  faBR03 = 468;
  faBR04 = 469;
  faBR05 = 470;
  faBR06 = 471;

  { BtnLegendPhone }
  faMB01 = 472;
  faMB02 = 473;
  faMB03 = 474;
  faMB04 = 475;
  faMB05 = 476;
  faMB06 = 477;
  faMB07 = 478;
  faMB08 = 479;

  { TouchBarLegend }
  faTouchBarTop = 480;
  faTouchBarBottom = 481;
  faTouchBarLeft = 482;
  faTouchBarRight = 483;

  { Reset }
  faReset = 484;
  faResetPosition = 485;
  faResetRotation = 486;
  faResetZoom = 487;

  { Language }
  faToggleLanguage = 488;

  { CopyPaste }
  faSave = 489;
  faLoad = 490;
  faOpen = 491;
  faCopy = 492;
  faPaste = 493;

  { ViewOptions }
  faToggleMoveMode = 494;
  faLinearMove = 495;
  faExpoMove = 496;
  faToggleOrbitMode = 497;

  { BitmapCycle }
  faCycleBitmapM = 498;
  faCycleBitmapP = 499;
  faRandom = 500;
  faRandomWhite = 501;
  faRandomBlack = 502;
  faRandomBambu1 = 503;
  faRandomBambu2 = 504;
  faBitmapEscape = 505;
  faBitmapOne = 506;
  faToggleContour = 507;

  { Layout0 }
  faLayout0 = 508;
  faLayout1 = 509;
  faLayout2 = 510;
  faLayout3 = 511;
  faLayout4 = 512;
  faLayout5 = 513;
  faLayout6 = 514;
  faLayout7 = 515;
  faLayout8 = 516;
  faLayout9 = 517;

  { Layout1 }
  faLayout10 = 518;
  faLayout11 = 519;
  faLayout12 = 520;
  faLayout13 = 521;
  faLayout14 = 522;
  faLayout15 = 523;
  faLayout16 = 524;
  faLayout17 = 525;
  faLayout18 = 526;
  faLayout19 = 527;

  { Layout2 }
  faLayout20 = 528;
  faLayout21 = 529;
  faLayout22 = 530;
  faLayout23 = 531;
  faLayout24 = 532;
  faLayout25 = 533;
  faLayout26 = 534;
  faLayout27 = 535;
  faLayout28 = 536;
  faLayout29 = 537;

  { Layout3 }
  faLayout30 = 538;
  faLayout31 = 539;
  faLayout32 = 540;
  faLayout33 = 541;
  faLayout34 = 542;
  faLayout35 = 543;
  faLayout36 = 544;
  faLayout37 = 545;
  faLayout38 = 546;
  faLayout39 = 547;

  { Layout4 }
  faLayout40 = 548;
  faLayout41 = 549;
  faLayout42 = 550;
  faLayout43 = 551;
  faLayout44 = 552;
  faLayout45 = 553;
  faLayout46 = 554;
  faLayout47 = 555;
  faLayout48 = 556;
  faLayout49 = 557;

  { Layout5 }
  faLayout50 = 558;
  faLayout51 = 559;
  faLayout52 = 560;
  faLayout53 = 561;
  faLayout54 = 562;
  faLayout55 = 563;
  faLayout56 = 564;
  faLayout57 = 565;
  faLayout58 = 566;
  faLayout59 = 567;

  { Layout6 }
  faLayout60 = 568;
  faLayout61 = 569;
  faLayout62 = 570;
  faLayout63 = 571;
  faLayout64 = 572;
  faLayout65 = 573;
  faLayout66 = 574;
  faLayout67 = 575;
  faLayout68 = 576;
  faLayout69 = 577;

  { Layout7 }
  faLayout70 = 578;
  faLayout71 = 579;
  faLayout72 = 580;
  faLayout73 = 581;
  faLayout74 = 582;
  faLayout75 = 583;
  faLayout76 = 584;
  faLayout77 = 585;
  faLayout78 = 586;
  faLayout79 = 587;

  { Layout8 }
  faLayout80 = 588;
  faLayout81 = 589;
  faLayout82 = 590;
  faLayout83 = 591;
  faLayout84 = 592;
  faLayout85 = 593;
  faLayout86 = 594;
  faLayout87 = 595;
  faLayout88 = 596;
  faLayout89 = 597;

  { Layout9 }
  faLayout90 = 598;
  faLayout91 = 599;
  faLayout92 = 600;
  faLayout93 = 601;
  faLayout94 = 602;
  faLayout95 = 603;
  faLayout96 = 604;
  faLayout97 = 605;
  faLayout98 = 606;
  faLayout99 = 607;

  { MenuNav }
  faMenuXX = 608;
  faMenu00 = 609;
  faMenu10 = 610;
  faMenu20 = 611;
  faMenu30 = 612;
  faMenu40 = 613;
  faMenu50 = 614;
  faMenu60 = 615;
  faMenu70 = 616;
  faMenu80 = 617;
  faMenu90 = 618;

  { FigureSize }
  faFigureSizeXS = 619;
  faFigureSizeS = 620;
  faFigureSizeM = 621;
  faFigureSizeL = 622;
  faFigureSizeXL = 623;

  { EyeSize }
  faEyeSizeS = 624;
  faEyeSizeM = 625;
  faEyeSizeL = 626;

  { LayerSelection }
  faSelectLayer1 = 627;
  faSelectLayer2 = 628;
  faSelectLayer3 = 629;
  faSelectLayer4 = 630;
  faSelectLayer5 = 631;
  faSelectLayer6 = 632;
  faSelectLayer7 = 633;

  { ColorSelection }
  faSelectColor1 = 634;
  faSelectColor2 = 635;
  faSelectColor3 = 636;
  faSelectColor4 = 637;

  { ColorMapping }
  faCLA = 638;
  faMapColorToLayer = 639;
  faSelectColorMapping1 = 640;
  faSelectColorMapping2 = 641;
  faSelectColorMapping3 = 642;
  faSelectColorMapping4 = 643;
  faSelectColorMapping5 = 644;
  faSelectColorMapping6 = 645;

  faMax = 646;

implementation

end.
