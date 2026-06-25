unit RiggVar.FederModel.ActionMapTransit;

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

uses
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionMap;

type
  TLayoutDef = record
     Caption: string;
     A0: TFederAction;
     A1: TFederAction;
     A2: TFederAction;
     A3: TFederAction;
     A4: TFederAction;
     A5: TFederAction;
     procedure Clear;
  end;

  TActionMapTransit = class(TActionMap)
  private
    function InitLayoutDef(Layout: Integer): TLayoutDef;
  public
    constructor Create;
    procedure InitActions(Layout: Integer); override;
    procedure InitMenuCaptions(Menu: Integer = 0);
  end;

implementation

constructor TActionMapTransit.Create;
begin
  inherited;
  FPageCount := 87;
  TestName := 'Layout';
end;

procedure TActionMapTransit.InitMenuCaptions(Menu: Integer = 0);
var
  i: Integer;
  cr: TLayoutDef;
begin
  for i := 0 to 9 do
  begin
    cr := InitLayoutDef(Menu + i);
    CurrentMenuCaptions[i] := cr.Caption;
  end;
end;

procedure TActionMapTransit.InitActions(Layout: Integer);
var
  cr: TLayoutDef;
  ButtonIndex: Integer;
begin
  cr := InitLayoutDef(Layout);

  InitAction(0, cr.A0);
  InitAction(1, cr.A1);
  InitAction(2, cr.A2);
  InitAction(3, cr.A3);
  InitAction(4, cr.A4);
  InitAction(5, cr.A5);

  ButtonIndex := Layout mod 10;
  if ButtonIndex > 9 then
    ButtonIndex := 9;
  CurrentMenuCaptions[ButtonIndex] := cr.Caption;
end;

function TActionMapTransit.InitLayoutDef(Layout: Integer): TLayoutDef;
  procedure InitA(Pos: Integer; fa: TFederAction);
  begin
    case Pos of
      0: result.A0 := fa;
      1: result.A1 := fa;
      2: result.A2 := fa;
      3: result.A3 := fa;
      4: result.A4 := fa;
      5: result.A5 := fa;
    end;
  end;
begin
  result.Clear;

  case Layout of

    0:
    begin
      result.Caption := 'Param Value Buttons';
      InitA(0, faParamValueMinus10);
      InitA(1, faParamValueMinus1);
      InitA(2, faParamValuePlus1);
      InitA(3, faParamValuePlus10);
      InitA(4, faToggleContour);
      InitA(5, faShowCurrentBandT);
    end;

    1:
    begin
      result.Caption := 'Mesh Size Buttons';
      InitA(0, faMeshSize16);
      InitA(1, faMeshSize32);
      InitA(2, faMeshSize64);
      InitA(3, faMeshSize128);
      InitA(4, faMeshSize256);
      InitA(5, faMeshSize512);
    end;

    2:
    begin
      result.Caption := 'Band Params and Options';
      InitA(0, faBandWidthAbsolute);
      InitA(1, faBandWidthRelative);
      InitA(2, faBandWidthContour);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faParamBandSelected);
    end;

    3:
    begin
      result.Caption := 'More Band Options';
      InitA(0, faShirtColorOff);
      InitA(1, faShirtColorOn);
      InitA(2, faShirtFarbeOff);
      InitA(3, faShirtFarbeOn);
      InitA(4, faBlindRingM);
      InitA(5, faBlindRingP);
    end;

    4:
    begin
      result.Caption := 'Mesh Options';
      InitA(0, faWantBottom);
      InitA(1, faWantSideCaps);
      InitA(2, faToggleSolidFlip);
      InitA(3, faReducedMesh);
      InitA(4, faTogglePCap);
      InitA(5, faWantBottomMirrored);
    end;

    5:
    begin
      result.Caption := 'Popular Params';
      InitA(0, faParamR);
      InitA(1, faParamA);
      InitA(2, faParamZ);
      InitA(3, faParamL);
      InitA(4, faNoop);
      InitA(5, faPan);
    end;

    6:
    begin
      result.Caption := 'Reset Actions';
      InitA(0, faReset);
      InitA(1, faResetRotation);
      InitA(2, faResetPosition);
      InitA(3, faResetZoom);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    7:
    begin
      result.Caption := 'Texture Params';
      InitA(0, faParamT1);
      InitA(1, faParamT2);
      InitA(2, faParamT3);
      InitA(3, faParamT4);
      InitA(4, faToggleContour);
      InitA(5, faShowCurrentBandT);
    end;

    8:
    begin
      result.Caption := 'Button Page shortcuts';
      InitA(0, faActionPage1);
      InitA(1, faActionPage2);
      InitA(2, faActionPageE);
      InitA(3, faActionPage4);
      InitA(4, faActionPage5);
      InitA(5, faActionPageX);
    end;

    9:
    begin
      result.Caption := 'Menu Buttons';
      InitA(0, faNoop);
      InitA(1, faMenu10);
      InitA(2, faMenu20);
      InitA(3, faMenu30);
      InitA(4, faMenu40);
      InitA(5, faMenu50);
    end;

    { 10 Color, Light, Cylinder, Reduce, Frustum, Marker, Wheel }

    10:
    begin
      result.Caption := 'Cylinder and Diameter';
      InitA(0, faToggleCylinder);
      InitA(1, faToggleDiameter);
      InitA(2, faParamBahnRadius);
      InitA(3, faParamBahnPositionX);
      InitA(4, faParamBahnPositionY);
      InitA(5, faParamBahnAngle);
    end;

    11:
    begin
      result.Caption := 'Farbauszug';
      InitA(0, faColor0);
      InitA(1, faColor1);
      InitA(2, faColor2);
      InitA(3, faColor3);
      InitA(4, faColor4);
      InitA(5, faColor5);
    end;

    12:
    begin
      result.Caption := 'Color Mix';
      InitA(0, faColor0);
      InitA(1, faColorMix0);
      InitA(2, faColorMixM);
      InitA(3, faColorMixP);
      InitA(4, faNoop);
      InitA(5, faColor6);
    end;

    13:
    begin
      result.Caption := 'Reduce Mode';
      InitA(0, faReduceMode0);
      InitA(1, faReduceMode1);
      InitA(2, faReduceMode2);
      InitA(3, faReduceMode3);
      InitA(4, faReducedMesh);
      InitA(5, faOpenMesh);
    end;

    14:
    begin
      result.Caption := 'Lock Buttons';
      InitA(0, faToggleBackgroundLock);
      InitA(1, faToggleTextureLock);
      InitA(2, faToggleParamLock);
      InitA(3, faToggleLuxLock);
      InitA(4, faToggleForceLock);
      InitA(5, faTextureClear);
    end;

    15:
    begin
      result.Caption := 'Grid and Lux Marker';
      InitA(0, faToggleGrid);
      InitA(1, faToggleGridFrequency);
      InitA(2, faToggleMarker);
      InitA(3, faToggleLuxMarker);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    16:
    begin
      result.Caption := 'Lux Toggle';
      InitA(0, faToggleLux);
      InitA(1, faToggleLux1);
      InitA(2, faToggleLux2);
      InitA(3, faToggleLux3);
      InitA(4, faToggleLux4);
      InitA(5, faNoop);
    end;

    17:
    begin
      result.Caption := 'Wheel Buttons';
      InitA(0, faWheelLeft);
      InitA(1, faWheelRight);
      InitA(2, faWheelDown);
      InitA(3, faWheelUp);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    18:
    begin
      result.Caption := 'Copy Buttons';
      InitA(0, faCopy);
      InitA(1, faPaste);
      InitA(2, faCopyBinCode);
      InitA(3, faCopyBinCodeTest);
      InitA(4, faSourcePascal);
      InitA(5, faSourceMaxima);
    end;

    19:
    begin
      result.Caption := 'Menu Buttons';
      InitA(0, faMenu00);
      InitA(1, faNoop);
      InitA(2, faMenu20);
      InitA(3, faMenu30);
      InitA(4, faMenu40);
      InitA(5, faMenu50);
    end;

    { 20 Params }

    20:
    begin
      result.Caption := 'Param Selection';
      InitA(0, faParamR);
      InitA(1, faParamG);
      InitA(2, faParamA);
      InitA(3, faParamZ);
      InitA(4, faParamT);
      InitA(5, faParamL);
    end;

    21:
    begin
      result.Caption := 'Zoom and Rotation Params';
      InitA(0, faParamCZ);
      InitA(1, faNoop);
      InitA(2, faNoop);
      InitA(3, faParamRX);
      InitA(4, faParamRY);
      InitA(5, faParamRZ);
    end;

//    22:
//    begin
//      InitA(0, faParamORX);
//      InitA(1, faParamORY);
//      InitA(2, faParamORZ);
//      InitA(3, faNoop);
//      InitA(4, faNoop);
//      InitA(5, faParamCZ);
//    end;

//    23:
//    begin
//      InitA(0, faParam0);
//      InitA(1, faParam1);
//      InitA(2, faParam2);
//      InitA(3, faParam3);
//      InitA(4, faParam4);
//      InitA(5, faParam5);
//    end;

//    24:
//    begin
//      InitA(0, faParam6);
//      InitA(1, faParam7);
//      InitA(2, faParam8);
//      InitA(3, faParam9);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    25:
//    begin
//      InitA(0, faParamIV);
//      InitA(1, faParamIW);
//      InitA(2, faParamJV);
//      InitA(3, faParamJW);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

    26:
    begin
      result.Caption := 'Model Options';
      InitA(0, faToggleSolutionMode);
      InitA(1, faToggleVorzeichen);
      InitA(2, faToggleGleich);
      InitA(3, faToggleLinearForce);
      InitA(4, faToggleMoveMode);
      InitA(5, faNoop);
    end;

    27:
    begin
      result.Caption := 'Wheel Buttons';
      InitA(0, faWheelLeft);
      InitA(1, faWheelRight);
      InitA(2, faWheelDown);
      InitA(3, faWheelUp);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    28:
    begin
      result.Caption := 'Copy Buttons';
      InitA(0, faCopy);
      InitA(1, faPaste);
      InitA(2, faCopyBinCode);
      InitA(3, faCopyBinCodeTest);
      InitA(4, faSourcePascal);
      InitA(5, faSourceMaxima);
    end;

    29:
    begin
      result.Caption := 'Menu Buttons';
      InitA(0, faMenu00);
      InitA(1, faMenu10);
      InitA(2, faNoop);
      InitA(3, faMenu30);
      InitA(4, faMenu40);
      InitA(5, faMenu50);
    end;

    { 30 - Model Switches }

    30:
    begin
      result.Caption := 'Plot Combo 1';
      InitA(0, faPlot0);
      InitA(1, faPlot1);
      InitA(2, faPlot2);
      InitA(3, faPlot3);
      InitA(4, faPlot4);
      InitA(5, faPlot5);
    end;

    31:
    begin
      result.Caption := 'Plot Combo 2';
      InitA(0, faPlot6);
      InitA(1, faPlot7);
      InitA(2, faPlot8);
      InitA(3, faPlot9);
      InitA(4, faPlot10);
      InitA(5, faPlot11);
    end;

    32:
    begin
      result.Caption := 'Plot Combo 3';
      InitA(0, faPlot12);
      InitA(1, faPlot13);
      InitA(2, faNoop);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    33:
    begin
      result.Caption := 'Graph Combo';
      InitA(0, faGraph1);
      InitA(1, faGraph2);
      InitA(2, faGraph3);
      InitA(3, faGraph4);
      InitA(4, faGraph5);
      InitA(5, faNoop);
    end;

    34:
    begin
      result.Caption := 'Figure Combo';
      InitA(0, faFigure1);
      InitA(1, faFigure2);
      InitA(2, faFigure3);
      InitA(3, faFigure4);
      InitA(4, faFigure5);
      InitA(5, faFigure6);
    end;

    35:
    begin
      result.Caption := 'Scene Combo';
      InitA(0, faScene1);
      InitA(1, faScene2);
      InitA(2, faScene3);
      InitA(3, faScene4);
      InitA(4, faScene5);
      InitA(5, faNoop);
    end;

//    36:
//    begin
//      result.Caption := 'PlotFigure and Dim';
//      InitA(0, faPlotFigureM);
//      InitA(1, faPlotFigureP);
//      InitA(2, faDimM);
//      InitA(3, faDimP);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

    37:
    begin
      result.Caption := 'Wheel Frequency';
      InitA(0, faWheelFrequency1);
      InitA(1, faWheelFrequency05);
      InitA(2, faWheelFrequency02);
      InitA(3, faWheelFrequency01);
      InitA(4, faWheelFrequency001);
      InitA(5, faWheelFrequency0001);
    end;

    39:
    begin
      result.Caption := 'Menu Buttons';
      InitA(0, faMenu00);
      InitA(1, faMenu10);
      InitA(2, faMenu20);
      InitA(3, faNoop);
      InitA(4, faMenu40);
      InitA(5, faMenu50);
    end;

    { 40 - Animation }

//    40:
//    begin
//      result.Caption := 'Memory Recall and Transit';
//      InitA(0, faMemory1);
//      InitA(1, faMemory2);
//      InitA(2, faRecall1);
//      InitA(3, faRecall2);
//      InitA(4, faTransit);
//      InitA(5, faAnimationStop);
//    end;

//    41:
//    begin
//      result.Caption := 'Animated Rotations';
//      InitA(0, faRotX);
//      InitA(1, faRotY);
//      InitA(2, faRotZ);
//      InitA(3, faNoop);
//      InitA(4, faCycleSliceModeM);
//      InitA(5, faCycleSliceModeP);
//    end;

//    42:
//    begin
//      result.Caption := 'Rotation Steps';
//      InitA(0, faRotXM);
//      InitA(1, faRotXP);
//      InitA(2, faRotYM);
//      InitA(3, faRotYP);
//      InitA(4, faRotZM);
//      InitA(5, faRotZP);
//    end;

//    43:
//    begin
//      result.Caption := 'Shader Export';
//      InitA(0, faExportShaderDX);
//      InitA(1, faExportShaderGL);
//      InitA(2, faExportShaderRC);
//      InitA(3, faExportShaderAll);
//      InitA(4, faExportShaderBin);
//      InitA(5, faReportLiveObjects);
//    end;

    44:
    begin
      result.Caption := 'Shader 2';
//      InitA(3, faShaderMode1);
//      InitA(4, faShaderMode2);
//      InitA(5, faShaderMode3);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    49:
    begin
      result.Caption := 'Menu Buttons';
      InitA(0, faMenu00);
      InitA(1, faMenu10);
      InitA(2, faMenu20);
      InitA(3, faMenu30);
      InitA(4, faNoop);
      InitA(5, faMenu50);
    end;

    { 50 - Aussortiert }

    50:
    begin
      result.Caption := 'Sample Nav';
      InitA(0, faGotoSample1);
      InitA(1, faSwapBundle);
      InitA(2, faSampleM);
      InitA(3, faSampleP);
      InitA(4, faHubM);
      InitA(5, faHubP);
    end;

//    51:
//    begin
//      result.Caption := 'Repo Selection';
//      InitA(0, faRepo010);
//      InitA(1, faRepo020);
//      InitA(2, faRepo050);
//      InitA(3, faRepo100);
//      InitA(4, faRepo150);
//      InitA(5, faRepo480);
//    end;

//    52:
//    begin
//      result.Caption := 'DropTarget';
//      InitA(0, faToggleLabelText);
//      InitA(1, faNoop);
//      InitA(2, faNoop);
//      InitA(3, faNoop);
//      InitA(4, faNoop);
//      InitA(5, faToggleDropTarget);
//    end;

    53:
    begin
      result.Caption := 'Param K';
      InitA(0, faNoop);
      InitA(1, faNoop);
      InitA(2, faParamK);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    54:
    begin
      result.Caption := 'Force Mode';
      InitA(0, faForceMode0);
      InitA(1, faForceMode1);
      InitA(2, faForceMode2);
      InitA(3, faM1);
      InitA(4, faM2);
      InitA(5, faM3);
    end;

//    55:
//    begin
//      result.Caption := 'Perspective';
//      InitA(0, faParamNP);
//      InitA(1, faParamFP);
//      InitA(2, faParamVA);
//      InitA(3, faNoop);
//      InitA(4, faResetFrustum);
//      InitA(5, faViewTypePerspective);
//    end;

//    56:
//    begin
//      result.Caption := 'Light Mode';
//      InitA(0, faLightMode0);
//      InitA(1, faLightMode1);
//      InitA(2, faLightMode2);
//      InitA(3, faLightMode3);
//      InitA(4, faLightMode4);
//      InitA(5, faNoop);
//    end;

//    57:
//    begin
//      result.Caption := 'Connection';
//      InitA(0, faConnect);
//      InitA(1, faDisconnect);
//      InitA(2, faDownload);
//      InitA(3, faAutoSend);
//      InitA(4, faEditHost);
//      InitA(5, faEditPort);
//    end;

    59:
    begin
      result.Caption := 'Menu Buttons';
      InitA(0, faMenu00);
      InitA(1, faMenu10);
      InitA(2, faMenu20);
      InitA(3, faMenu30);
      InitA(4, faMenu40);
      InitA(5, faNoop);
    end;

    { 60 - Display and Format }

//    60:
//    begin
//      result.Caption := 'Tiles 1-5';
//      InitA(0, faTile0);
//      InitA(1, faTile1);
//      InitA(2, faTile2);
//      InitA(3, faTile3);
//      InitA(4, faTile4);
//      InitA(5, faTile5);
//    end;

//    61:
//    begin
//      result.Caption := 'Tile 6-9';
//      InitA(0, faTile6);
//      InitA(1, faTile7);
//      InitA(2, faTile8);
//      InitA(3, faTile9);
//      InitA(4, faFormatPortrait);
//      InitA(5, faFormatLandscape);
//    end;

//    62:
//    begin
//      result.Caption := 'Display';
//      InitA(0, faDisplay2D);
//      InitA(1, faDisplay3D);
//      InitA(2, faDisplay32);
//      InitA(3, faDisplay00);
//      InitA(4, faCycleDisplayP);
//      InitA(5, faCycleDisplayM);
//    end;

//    63:
//    begin
//      result.Caption := 'Main Menu Toggle';
//      InitA(0, faMainMenuHide);
//      InitA(1, faMainMenuShow);
//      InitA(2, faNoop);
//      InitA(3, faNoop);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    64:
//    begin
//      result.Caption := 'Viewport Size';
//      InitA(0, faViewportSizeA);
//      InitA(1, faViewportSizeB);
//      InitA(2, faViewportSizeC);
//      InitA(3, faViewportSizeD);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    65:
//    begin
//    result.Caption := 'Icon Size';
//      InitA(0, faIconSize128);
//      InitA(1, faIconSize256);
//      InitA(2, faIconSize512);
//      InitA(3, faIconSize640);
//      InitA(4, faIconSize960);
//      InitA(5, faIconSize01K);
//    end;

    { 70 - Copy and Create }

    70:
    begin
      result.Caption := 'Copy Bitmap';
      InitA(0, faNoop);
      InitA(1, faCopyBitmap3D);
      InitA(2, faCopyImprintedBitmap);
      InitA(3, faCopyImprintedBitmapTest);
      InitA(4, faCopyTextureBitmap);
      InitA(5, faNoop);
    end;

//    71:
//    begin
//      result.Caption := 'Copy Tiled Image';
//      InitA(0, faCopyTiledImage0);
//      InitA(1, faCopyTiledImage1);
//      InitA(2, faCopyTiledImage2);
//      InitA(3, faCopyTiledImage3);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    72:
//    begin
//      result.Caption := 'Create Image Series 3D';
//      InitA(0, faNoop);
//      InitA(1, faNoop);
//      InitA(2, faNoop);
//      InitA(3, faCreateImageSeries3D);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    73:
//    begin
//      result.Caption := 'Action Report';
//      InitA(0, faWriteActionTable);
//      InitA(1, faWriteActionReport);
//      InitA(2, faCopyShortcutReport);
//      InitA(3, faCopyMeshDataReport);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    74:
//    begin
//      result.Caption := 'DB Export Import';
//      InitA(0, faExportDB);
//      InitA(1, faImportDB);
//      InitA(2, faDelay0);
//      InitA(3, faDelay1);
//      InitA(4, faDelay2);
//      InitA(5, faDelay3);
//    end;

//    75:
//    begin
//      result.Caption := 'Material Options';
//      InitA(0, faMediumWater);
//      InitA(1, faMediumGlass);
//      InitA(2, faMediumPlastic);
//      InitA(3, faMediumGold);
//      InitA(4, faMediumSilver);
//      InitA(5, faMediumCopper);
//    end;

//    76:
//    begin
//      result.Caption := 'Out Options 1';
//      InitA(0, faOutOriginal);
//      InitA(1, faOutPos);
//      InitA(2, faOutNor);
//      InitA(3, faOutTex);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    77:
//    begin
//      result.Caption := 'Out Options 2';
//      InitA(0, faOutOriginal);
//      InitA(1, faOutN);
//      InitA(2, faOutL);
//      InitA(3, faOutV);
//      InitA(4, faOutH);
//      InitA(5, faNoop);
//    end;

//    78:
//    begin
//      result.Caption := 'Out Options 3';
//      InitA(0, faOutOriginal);
//      InitA(1, faOutDiffuse);
//      InitA(2, faOutSpecular);
//      InitA(3, faOutEmissive);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    79:
//    begin
//      result.Caption := 'Out Options 4';
//      InitA(0, faContentUseRes);
//      InitA(1, faContentLevelS);
//      InitA(2, faContentLevelM);
//      InitA(3, faContentLevelL);
//      InitA(4, faNoop);
//      InitA(5, faWantHand);
//    end;

    { 80 - Dialogs and Keyboard }

    80:
    begin
      result.Caption := 'Forms';
      InitA(0, faNoop);
      InitA(1, faNoop);
      InitA(2, faShowMemo);
      InitA(3, faShowActions);
      InitA(4, faNoop);
      InitA(5, faShowInfo);
    end;

    81:
    begin
      result.Caption := 'Save and Load';
      InitA(0, faSave);
      InitA(1, faLoad);
      InitA(2, faOpen);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

//    82:
//    begin
//      result.Caption := 'Keyboard and Flags';
//      InitA(0, faSetShift);
//      InitA(1, faSetCtrl);
//      InitA(2, faClearShift);
//      InitA(3, faNoop);
//      InitA(4, faKeyboard01);
//      InitA(5, faKeyboard02);
//    end;

//    83:
//    begin
//      result.Caption := 'Dialogs';
//      InitA(0, faNoop);
//      InitA(1, faEditText);
//      InitA(2, faNoop);
//      InitA(3, faNoop);
//      InitA(4, faNoop);
//      InitA(5, faNoop);
//    end;

//    84:
//    begin
//      result.Caption := '2D Graph Options';
//      InitA(0, faToggleTF);
//      InitA(1, faToggleDF);
//      InitA(2, faToggleLL);
//      InitA(3, faToggleLC1);
//      InitA(4, faToggleLC2);
//      InitA(5, faNoop);
//    end;

//    85:
//    begin
//      result.Caption := '2D Canvas';
//      InitA(0, faRepaint);
//      InitA(1, faToggleCanvasClear);
//      InitA(2, faToggleDash);
//      InitA(3, faParamBahnStrokeWidth1);
//      InitA(4, faParamBahnStrokeWidth2);
//      InitA(5, faNoop);
//    end;

//    86:
//    begin
//      result.Caption := '2D Resolution';
//      InitA(0, faResolution1);
//      InitA(1, faResolution2);
//      InitA(2, faResolution3);
//      InitA(3, faResolution4);
//      InitA(4, faResolution5);
//      InitA(5, faResolution6);
//    end;

//    87:
//    begin
//      result.Caption := '2D Draw Figure';
//      InitA(0, faNoop);
//      InitA(1, faNoop);
//      InitA(2, faNoop);
//      InitA(3, faNoop);
//      InitA(4, faCycleDrawFigureP);
//      InitA(5, faCycleDrawFigureM);
//    end;

    88:
    begin
      result.Caption := 'Param Y3f';
      InitA(0, faParamY3f);
      InitA(1, faParamL3f);
      InitA(2, faParamLf);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    89:
    begin
      result.Caption := 'TR Params';
      InitA(0, faParamTRT);
      InitA(1, faParamTRX);
      InitA(2, faParamTRY);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    { 90 - Lighting }

    90: // Lights (used in Light Material 4)
    begin
//      result.Caption := 'Light Mappings';
//      InitA(0, faMappedLight1);
//      InitA(1, faMappedLight2);
//      InitA(2, faMappedLight3);
//      InitA(3, faMappedLight4);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    91: // Light Material 1
    begin
//      result.Caption := 'Light Material 1 Options';
//      InitA(0, faPositionalLight);
//      InitA(1, faDirectionalLight);
//      InitA(2, faSpotLight);
      InitA(3, faNoop);
      InitA(4, faNoop);
//      InitA(5, faSimpleLight);
    end;

    92: // Light Material 2
    begin
//      result.Caption := 'Light Material 2 Params';
//      InitA(0, faParamFresnelR0);
//      InitA(1, faParamRoughness);
//      InitA(2, faParamSpotPower);
//      InitA(3, faParamFalloffStart);
//      InitA(4, faParamFallOffEnd);
//      InitA(5, faParamLightStrength);
    end;

    93: // Light Material 3
    begin
//      result.Caption := 'Light Material 3 Params';
//      InitA(0, faParamEmisLight);
//      InitA(1, faParamAmbiLight);
//      InitA(2, faParamDiffLight);
//      InitA(3, faParamSpecLight);
//      InitA(4, faParamSpecPower);
//      InitA(5, faParamOpacity);
    end;

    94: // Light 1 and 4
    begin
//      result.Caption := 'Light 1 and 4 Params 1';
//      InitA(0, faParamMatEmis);
//      InitA(1, faParamMatAmbi);
//      InitA(2, faParamMatDiff);
//      InitA(3, faParamMatSpec);
      InitA(4, faNoop);
//      InitA(5, faParamOpacity);
    end;

    95: // Light 1 and 4
    begin
//      result.Caption := 'Light 1 and 4 Params 2';
//      InitA(0, faParamLitDiff);
//      InitA(1, faParamLitSpec);
//      InitA(2, faNoop);
//      InitA(3, faParamLitCutt);
//      InitA(4, faParamLitExpo);
//      InitA(5, faParamMatShin);
    end;

    96: // Light 1 and 4
    begin
//      result.Caption := 'Light 1 and 4 Params 3';
//      InitA(0, faParamLitPosX);
//      InitA(1, faParamLitPosY);
//      InitA(2, faParamLitPosZ);
//      InitA(3, faParamLitDirX);
//      InitA(4, faParamLitDirY);
//      InitA(5, faParamLitDirZ);
    end;

    97: // Light 1
    begin
//      result.Caption := 'Light 1 Params 5';
//      InitA(0, faParamLitAttX);
//      InitA(1, faParamLitAttY);
//      InitA(2, faParamLitAttZ);
//      InitA(3, faParamLitColR);
//      InitA(4, faParamLitColG);
//      InitA(5, faParamLitColB);
    end;

    else
    begin
      result.Caption := 'Unused';
      InitA(0, faNoop);
      InitA(1, faNoop);
      InitA(2, faNoop);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;
  end;
end;

{ TLayoutDef }

procedure TLayoutDef.Clear;
begin
  Caption := 'not implemented';
  A0 := faNoop;
  A1 := faNoop;
  A2 := faNoop;
  A3 := faNoop;
  A4 := faNoop;
  A5 := faNoop;
end;

end.
