unit RiggVar.FederModel.ActionExecute;

(*
-
-     F
-    * *  *
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
  System.SysUtils,
  System.Classes,
  RiggVar.FB.ActionConst;

{ return  true if handled }
function FederActionExecute(fa: TFederAction): Boolean;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FB.DefConst,
  RiggVar.FB.Def;

function FederActionExecute(fa: TFederAction): Boolean;
var
  M: TMain;
begin
  result := True;

  M := Main;
  if M = nil then
    Exit;

  case fa of
    faToggleAllText: M.FederText.ToggleAllText;
    faToggleTouchMenu: M.FederText.ToggleTouchMenu;
    faToggleTouchFrame: M.FederText.ToggleTouchFrame;
    faToggleEquationText: M.FederText.ToggleEquationText;
    faTogglePrimeText: M.FederText.TogglePrimeText;
    faToggleSecondText: M.FederText.ToggleSecondText;

    faParamValueMinus1,
    faWheelLeft: M.DoMouseWheel([ssShift], -1);

    faParamValuePlus1,
    faWheelRight: M.DoMouseWheel([ssShift], 1);

    faParamValuePlus10,
    faWheelUp: M.DoMouseWheel([ssCtrl], 1);

    faParamValueMinus10,
    faWheelDown: M.DoMouseWheel([ssCtrl], -1);

    faScene1: M.GotoScene(1);
    faScene2: M.GotoScene(2);
    faScene3: M.GotoScene(3);
    faScene4: M.GotoScene(4);
    faScene5: M.GotoScene(5);

    faGraph1: M.Graph := 1;
    faGraph2: M.Graph := 2;
    faGraph3: M.Graph := 3;
    faGraph4: M.Graph := 4;
    faGraph5: M.Graph := 5;

    faColor0: M.Color := 0;
    faColor1: M.Color := 1;
    faColor2: M.Color := 2;
    faColor3: M.Color := 3;
    faColor4: M.Color := 4;
    faColor5: M.Color := 5;
    faColor6: M.Color := 6;

    faPlot0: M.Plot := 0;
    faPlot1: M.Plot := 1;
    faPlot2: M.Plot := 2;
    faPlot3: M.Plot := 3;
    faPlot4: M.Plot := 4;
    faPlot5: M.Plot := 5;
    faPlot6: M.Plot := 6;
    faPlot7: M.Plot := 7;
    faPlot8: M.Plot := 8;
    faPlot9: M.Plot := 9;
    faPlot10: M.Plot := 10;
    faPlot11: M.Plot := 11;
    faPlot12: M.Plot := 12;
    faPlot13: M.Plot := 13;

    faFigure1: M.Figure := 1;
    faFigure2: M.Figure := 2;
    faFigure3: M.Figure := 3;
    faFigure4: M.Figure := 4;
    faFigure5: M.Figure := 5;
    faFigure6: M.Figure := 6;

    faRotX: M.RotX;
    faRotY: M.RotY;
    faRotZ: M.RotZ;
    faRotXM: M.RotXM;
    faRotXP: M.RotXP;
    faRotYM: M.RotYM;
    faRotYP: M.RotYP;
    faRotZM: M.RotZM;
    faRotZP: M.RotZP;

    faLevelM: M.CycleDBM;
    faLevelP: M.CycleDBP;
    faHubM: M.LoadHub(true);
    faHubP: M.LoadHub(false);
    faSampleM: M.LoadSample(true);
    faSampleP: M.LoadSample(false);

    faActionPageM: M.CycleToolSet(-1);
    faActionPageP: M.CycleToolSet(1);
    faActionPage1: M.FederText.ActionPage := 1;
    faActionPage2: M.FederText.ActionPage := 2;
    faActionPage3: M.FederText.ActionPage := 3;
    faActionPage4: M.FederText.ActionPage := 4;
    faActionPage5: M.FederText.ActionPage := 5;
    faActionPage6: M.FederText.ActionPage := 6;
    faActionPageE: M.FederText.ActionPage := -1;
    faActionPageS: M.FederText.ActionPage := -3;
    faActionPageX: M.FederText.ActionPage := -2;

    faHelpHome: M.GotoHelpHome;
    faCycleHelpM: M.CycleHelpM;
    faCycleHelpP: M.CycleHelpP;
    faCycleBitmapP: M.CycleBitmapP;
    faCycleBitmapM:  M.CycleBitmapM;
    faCyclePlotP: M.Plot := M.CyclePlotP;
    faCyclePlotM: M.Plot := M.CyclePlotM;
    faCycleGraphP: M.Graph := M.CycleGraphP;
    faCycleGraphM: M.Graph := M.CycleGraphM;
    faCycleFigureP: M.Figure := M.CycleFigureP;
    faCycleFigureM: M.Figure := M.CycleFigureM;

    faCycleX: M.ParamManager.CycleX;
    faCycleY: M.ParamManager.CycleY;
    faCycleZ: M.ParamManager.CycleZ;

    faCycleColorSchemeM: M.CycleColorSchemeM;
    faCycleColorSchemeP: M.CycleColorSchemeP;

    faToggleGleich: M.Gleich := not M.Gleich;

    faOpenMesh: M.OpenMesh := not M.OpenMesh;
    faPolarMesh: M.PolarMesh := not M.PolarMesh;
    faReducedMesh: M.ReducedMesh := not M.ReducedMesh;
    faReduceMode0: M.ReduceMode := 0;
    faReduceMode1: M.ReduceMode := 1;
    faReduceMode2: M.ReduceMode := 2;
    faReduceMode3: M.ReduceMode := 3;

    faMeshSize4: M.MeshSize := 4;
    faMeshSize8: M.MeshSize := 8;
    faMeshSize16: M.MeshSize := 16;
    faMeshSize32: M.MeshSize := 32;
    faMeshSize64: M.MeshSize := 64;
    faMeshSize128: M.MeshSize := 128;
    faMeshSize256: M.MeshSize := 256;
    faMeshSize316: M.MeshSize := 316;
    faMeshSize512: M.MeshSize := 512;
    faMeshSize1024: M.MeshSize := 1024;

    faWheelFrequency1: M.WheelFrequency := 1;
    faWheelFrequency05: M.WheelFrequency := 2;
    faWheelFrequency02: M.WheelFrequency := 3;
    faWheelFrequency01: M.WheelFrequency := 4;
    faWheelFrequency001: M.WheelFrequency := 5;
    faWheelFrequency0001: M.WheelFrequency := 6;

    faSetShift: MainVar.ShiftState := [ssShift];
    faSetCtrl: MainVar.ShiftState := [ssCtrl];
    faClearShift: MainVar.ShiftState := [];

    faParamT1: M.ParamManager.ChangeParam(fpt1);
    faParamT2: M.ParamManager.ChangeParam(fpt2);
    faParamT3: M.ParamManager.ChangeParam(fpt3);
    faParamT4: M.ParamManager.ChangeParam(fpt4);

    faParamRX: M.ParamManager.ChangeParam(fprx);
    faParamRY: M.ParamManager.ChangeParam(fpry);
    faParamRZ: M.ParamManager.ChangeParam(fprz);
    faParamCZ: M.ParamManager.ChangeParam(fpcz);

    faParamR: M.ParamManager.ChangeParam(fpAbsoluteRange);
    faParamT: M.ParamManager.ChangeParam(fpt);
    faParamK: M.ParamManager.ChangeParam(fpk);
    faParamL: M.ParamManager.ChangeParam(fpl);
    faParamZ: M.ParamManager.ChangeParam(fpz);
    faParamA: M.ParamManager.ChangeParam(fpAttenuation);
    faParamG: M.ParamManager.ChangeParam(fpGrenze);

    faParamTRS: M.ParamManager.ChangeParam(fptrs);
    faParamTRT: M.ParamManager.ChangeParam(fptrt);
    faParamTRX: M.ParamManager.ChangeParam(fptrx);
    faParamTRY: M.ParamManager.ChangeParam(fptry);
    faParamX12: M.ParamManager.ChangeParam(fpx12);
    faParamY12: M.ParamManager.ChangeParam(fpy12);
    faParamZ12: M.ParamManager.ChangeParam(fpz12);

    faParamX3: M.ParamManager.ChangeParam(fpx3);
    faParamY3: M.ParamManager.ChangeParam(fpy3);
    faParamZ3: M.ParamManager.ChangeParam(fpz3);
    faParamL3: M.ParamManager.ChangeParam(fpl3);
    faParamK3: M.ParamManager.ChangeParam(fpk3);

    faOffsetX: M.ParamManager.ChangeParam(fpox);
    faOffsetY: M.ParamManager.ChangeParam(fpoy);
    faOffsetZ: M.ParamManager.ChangeParam(fpoz);

    faCycleK: M.ParamManager.CycleK;
    faCycleL: M.ParamManager.CycleL;
    faCycleO: M.ParamManager.CycleO;
    faCycleR: M.ParamManager.CycleR;
    faCycleT: M.ParamManager.CycleT;
    faCycleU: M.ParamManager.CycleU;

    faToggleMarker: M.FederScene.ToggleMarker;
    faToggleGrid: M.FederScene.ToggleGrid;
    faToggleGridFrequency: M.FederScene.ToggleGridFrequency;

    faToggleCube: M.FederScene.ToggleCube;
    faToggleCorner: M.FederScene.ToggleCorner;
    faToggleLimitPlane: M.FederScene.ToggleLimitPlane;
    faToggleCylinder: M.FederScene.ToggleCylinder;
    faToggleDiameter: M.FederScene.ToggleDiameter;
    faToggleProbe: M.ToggleProbe;
    faToggleLabelText: M.FederScene.ToggleLabel;

    faLayout0 .. faLayout99: M.TransitBarLayout := fa - faLayout0;

    faMenuXX: M.MenubarLayout := -1;
    faMenu00: M.MenubarLayout := 0;
    faMenu10: M.MenubarLayout := 10;
    faMenu20: M.MenubarLayout := 20;
    faMenu30: M.MenubarLayout := 30;
    faMenu40: M.MenubarLayout := 40;
    faMenu50: M.MenubarLayout := 50;
    faMenu60: M.MenubarLayout := 60;
    faMenu70: M.MenubarLayout := 70;
    faMenu80: M.MenubarLayout := 80;
    faMenu90: M.MenubarLayout := 90;

    faToggleQuickMesh: M.FederScene.QuickMesh := not M.FederScene.QuickMesh;
    faToggleParamLock: M.FederData.ParamLock := not M.FederData.ParamLock;
    faToggleTextureLock: M.FederData.TextureLock := not M.FederData.TextureLock;
    faToggleBackgroundLock: M.FederData.BackgroundLock := not M.FederData.BackgroundLock;
    faToggleForceLock: M.FederData.ForceLock := not M.FederData.ForceLock;
    faToggleLuxLock: M.FederData.LuxLock := not M.FederData.LuxLock;

    faToggleBMap: M.Bigmap := not M.Bigmap;
    faToggleMCap: M.MinusCap := not M.MinusCap;
    faTogglePCap: M.PlusCap := not M.PlusCap;
    faToggleSolutionMode: M.SolutionMode := not M.SolutionMode;
    faToggleVorzeichen: M.Vorzeichen := not M.Vorzeichen;

    faToggleOrbitMode: M.OrbitMode := not M.OrbitMode;
    faToggleMoveMode: M.MoveMode := not M.MoveMode;
    faLinearMove: M.MoveMode := False;
    faExpoMove: M.MoveMode := True;

    faForceMode0: M.FederModel.ForceMode := 0;
    faForceMode1: M.FederModel.ForceMode := 1;
    faForceMode2: M.FederModel.ForceMode := 2;

    faM1:
    begin
      M.FederText.FlashCaption := 'm1';
      M.CycleMX(1);
    end;
    faM2:
    begin
      M.FederText.FlashCaption := 'm2';
      M.CycleMX(2);
    end;
    faM3:
    begin
      M.FederText.FlashCaption := 'm3';
      M.CycleMX(3);
    end;

    faTextureClear:
    begin
      //DropTargetVisible := False;
      M.CloseBitmap;
    end;

    faSave:
    begin
      M.FederText.FlashCaption := 'Ctrl s (Save)';
      M.SaveAction;
    end;

    faLoad:
    begin
      M.FederText.FlashCaption := 'Ctrl l (Load)';
      M.LoadAction;
    end;

    faOpen:
    begin
      M.FederText.FlashCaption := 'Ctrl o (Open)';
      M.OpenBundle;
    end;

    faCopy:
    begin
      M.FederText.FlashCaption := 'Ctrl c (Copy Code)';
      M.CopyDiffCode;
    end;

    faPaste:
    begin
      M.FederText.FlashCaption := 'Ctrl v';
      M.PasteSample;
    end;

    faAnimationStop: M.Stop;

    faAnimationStartA: M.ScriptL;

    faAnimationStartD,
    faAnimationStartF,
    faAnimationStartS,
    faAnimationStartT: M.SampleTransition.HandleAction(fa);

    faRecall1: M.FederMemory.Recall1;
    faRecall2: M.FederMemory.Recall2;
    faMemory1: M.FederMemory.Memory1;
    faMemory2: M.FederMemory.Memory2;
    faTransit: M.FederMemory.Transit;

    faConnect: M.ConnectAction;
    faDisconnect: M.DisconnectAction;
    faDownload: M.DownloadAction;

    faTakeCapValueSnapShot: M.TakeCapValueSnapShot;

    faCopyScreenshot: M.CopyScreenshot;
    faCopyBitmap3D: M.CopyBitmap3D;
    faCopyTextureBitmap: M.CopyTextureBitmap;

    faKeyboard01: M.KeyBinding := 1;
    faKeyboard02: M.KeyBinding := 2;

    faReset: M.DoReset;
    faResetPosition: M.DoResetPosition;
    faResetRotation: M.DoResetRotation;
    faResetZoom: M.DoResetZoom;

    faRandom: M.DoRandom(1);
    faRandomWhite: M.RandomBitmapWhite;
    faRandomBlack: M.RandomBitmapBlack;
    faRandomBambu1: M.DoRandomBambu1;
    faRandomBambu2: M.DoRandomBambu2;
    faBitmapEscape: M.CycleBitmapE;
    faBitmapOne: M.CycleBitmapOne;
    faPan: M.ParamManager.ChangeParam(fpPan);
    faInitSpecial: M.InitSpecial;
    faCycleRingP: M.CycleRing(1);
    faCycleRingM: M.CycleRing(-1);
    faBlindRingP: M.BlindRing(1);
    faBlindRingM: M.BlindRing(-1);
    faBlindRing1: M.BlindRingAbsolute(1);
    faBlindRing5: M.BlindRingAbsolute(5);
    faBlindRingA: M.BlindRingAbsolute(10);
    faBlindRingB: M.BlindRingAbsolute(11);
    faBlindRingC: M.BlindRingAbsolute(12);
    faBlindRingD: M.BlindRingAbsolute(13);
    faBlindRingE: M.BlindRingAbsolute(14);
    faBlindRingF: M.BlindRingAbsolute(15);

    faToggleContour: M.ToggleContourPixel;
    faDiff0: M.ToggleDiff(0);
    faDiff1: M.ToggleDiff(1);
    faDiff10: M.ToggleDiff(2);

    faAutoSend,
    faAutoSendOn,
    faAutoSendOff: M.AutoSend := fa;

    faToggleShirtColor: M.ToggleShirtColor;
    faShirtColorOn: M.UpdateShirtColor(True);
    faShirtColorOff: M.UpdateShirtColor(False);

    faShirtFarbeOn: M.UpdateShirtFarbe(True);
    faShirtFarbeOff: M.UpdateShirtFarbe(False);
    faToggleShirtFarbe: M.ToggleShirtFarbe;

    faLabelTextP: M.FederScene.LabelTextScale := 1;
    faLabelTextM: M.FederScene.LabelTextScale := -1;

    faParam0: M.ParamManager.ChangeParam(fp0);
    faParam1: M.ParamManager.ChangeParam(fp1);
    faParam2: M.ParamManager.ChangeParam(fp2);
    faParam3: M.ParamManager.ChangeParam(fp3);
    faParam4: M.ParamManager.ChangeParam(fp4);
    faParam5: M.ParamManager.ChangeParam(fp5);
    faParam6: M.ParamManager.ChangeParam(fp6);
    faParam7: M.ParamManager.ChangeParam(fp7);
    faParam8: M.ParamManager.ChangeParam(fp8);
    faParam9: M.ParamManager.ChangeParam(fp9);

    faSourcePascal: M.CopySource(0);
    faSourceMaxima: M.CopySource(1);
    faSourceMaple: M.CopySource(2);
    faSourceMathematica: M.CopySource(3);

    faNorthCap: M.ParamManager.ChangeParam(fpNorthCapValue);
    faSouthCap: M.ParamManager.ChangeParam(fpSouthCapValue);
    faEastCap: M.ParamManager.ChangeParam(fpEastCapValue);
    faWestCap: M.ParamManager.ChangeParam(fpWestCapValue);
    faParamCapValue: M.ParamManager.ChangeParam(fpParamCapValue);

    faParamBahnRadius: M.ParamManager.ChangeParam(fpbpr);
    faParamBahnPositionX: M.ParamManager.ChangeParam(fpbpx);
    faParamBahnPositionY: M.ParamManager.ChangeParam(fpbpy);
    faParamBahnAngle: M.ParamManager.ChangeParam(fpbpa);
    faParamBahnCylinderD: M.ParamManager.ChangeParam(fpbcd);
    faParamBahnCylinderZ: M.ParamManager.ChangeParam(fpbcz);

    faLabelBatchP: M.ToggleLabelBatch(1);
    faLabelBatchM: M.ToggleLabelBatch(-1);

    faRotStep0: M.DoRotStep(0);
    faRotStep1: M.DoRotStep(1);
    faRotStep2: M.DoRotStep(2);
    faRotStep3: M.DoRotStep(3);
    faRotStepA: M.DoRotStep(4);

    faToggleLinearForce: M.ToggleLinearForce;
    faToggleColorPanel: M.ToggleColorPanel;
    faToggleColorSwat: M.ShowColorSwat := not M.ShowColorSwat;

    faCopyBinCode: M.CopyDiffBin;
    faCopyBinCodeTest: M.CopyDiffBinTest;
    faRunBinPixelTest: M.RunBinPixelTest;

    faCopyImprintedBitmap: M.CopyImprintedBitmap;
    faCopyImprintedBitmapTest: M.CopyImprintedBitmapTest;

    faCopyShortcutReport: M.CopyShortcutReport;

    faToggleZeroPulling: M.ToggleZeroPulling;
    faToggleLimitPulling: M.ToggleLimitPulling;
    faToggleSlicePulling: M.ToggleSlicePulling(0);
    faToggleTargetPulling: M.ToggleTargetPulling;
    faToggleRightPulling: M.ToggleRightPulling;
    faToggleCrackFixing: M.ToggleCrackFixing;

    faTextureJitt: M.ToggleTextureJitt;
    faTextureJack: M.ToggleTextureJack;

    faParamL1X: M.ParamManager.ChangeParam(fpL1X);
    faParamL1Y: M.ParamManager.ChangeParam(fpL1Y);
    faParamL1Z: M.ParamManager.ChangeParam(fpL1Z);

    faParamL2X: M.ParamManager.ChangeParam(fpL2X);
    faParamL2Y: M.ParamManager.ChangeParam(fpL2Y);
    faParamL2Z: M.ParamManager.ChangeParam(fpL2Z);

    faParamL3X: M.ParamManager.ChangeParam(fpL3X);
    faParamL3Y: M.ParamManager.ChangeParam(fpL3Y);
    faParamL3Z: M.ParamManager.ChangeParam(fpL3Z);

    faParamL4X: M.ParamManager.ChangeParam(fpL4X);
    faParamL4Y: M.ParamManager.ChangeParam(fpL4Y);
    faParamL4Z: M.ParamManager.ChangeParam(fpL4Z);

    faLuxOn: M.ToggleLux(1);
    faLuxOff: M.ToggleLux(0);
    faToggleLux: M.ToggleLux(-1);

    faLux1On: M.ToggleLux1(1);
    faLux1Off: M.ToggleLux1(0);
    faToggleLux1: M.ToggleLux1(-1);

    faLux2On: M.ToggleLux2(1);
    faLux2Off: M.ToggleLux2(0);
    faToggleLux2: M.ToggleLux2(-1);

    faLux3On: M.ToggleLux3(1);
    faLux3Off: M.ToggleLux3(0);
    faToggleLux3: M.ToggleLux3(-1);

    faLux4On: M.ToggleLuxN(4, 1);
    faLux4Off: M.ToggleLuxN(4, 0);
    faToggleLux4: M.ToggleLuxN(4, -1);

    faLuxMarkerOn: M.ToggleLuxN(0, 1);
    faLuxMarkerOff: M.ToggleLuxN(0, 0);
    faToggleLuxMarker: M.ToggleLuxN(0, -1);

    faLightMode0: M.ToggleLightMode(0);
    faLightMode1: M.ToggleLightMode(1);
    faLightMode2: M.ToggleLightMode(2);
    faLightMode3: M.ToggleLightMode(3);
    faLightMode4: M.ToggleLightMode(4);

    faRepo010: M.InitRepo(10);
    faRepo020: M.InitRepo(20);
    faRepo050: M.InitRepo(50);

    faColorPanelOn: M.ShowColorPanel := True;
    faColorPanelOff: M.ShowColorPanel := False;

    faShowCurrentBand0: M.ShowCurrentBand := False;
    faShowCurrentBand1: M.ShowCurrentBand := True;
    faShowCurrentBandT: M.ShowCurrentBand := not M.ShowCurrentBand;

    faForceZ0: M.WantPosZ12 := False;
    faWantZ12: M.WantPosZ12 := True;

    faFocusEditField: M.FocusEditField;
    faShowEditField: M.ShowEditField := not M.ShowEditField;

    faStepRXM: M.DoMM(fmkRY, -10, 0);
    faStepRXP: M.DoMM(fmkRY, 10, 0);
    faStepRYM: M.DoMM(fmkRX, 0, -10);
    faStepRYP: M.DoMM(fmkRX, 0, 10);
    faStepRZM: M.DoMM(fmkRZ, -10, 0);
    faStepRZP: M.DoMM(fmkRZ, 10, 0);
    faStepCZM: M.DoZoom(0.3);
    faStepCZP: M.DoZoom(-0.3);

    faGotoSample0: M.GotoSample(0);
    faGotoSample1: M.GotoSample(1);

    faToggleOpacity: M.Opacity := not M.Opacity;
    faOpacityOn: M.Opacity := True;
    faOpacityOff: M.Opacity := False;

    faToggleHardCopy: MainVar.HardCopyFlag := not MainVar.HardCopyFlag;
    faHardCopyOn: MainVar.HardCopyFlag := True;
    faHardCopyOff: MainVar.HardCopyFlag := False;

    faTogglePngCopy: MainVar.PngCopyFlag := not MainVar.PngCopyFlag;
    faPngCopyOn: MainVar.PngCopyFlag := True;
    faPngCopyOff: MainVar.PngCopyFlag := False;

    faToggleNoCopy: MainVar.NoCopyFlag := not MainVar.NoCopyFlag;
    faNoCopyOn: MainVar.NoCopyFlag := True;
    faNoCopyOff: MainVar.NoCopyFlag := False;

    faColorMix0: M.RGBColorMix := 0;
    faColorMix1: M.RGBColorMix := 1;
    faColorMix2: M.RGBColorMix := 2;
    faColorMix3: M.RGBColorMix := 3;
    faColorMix4: M.RGBColorMix := 4;
    faColorMix5: M.RGBColorMix := 5;

    faColorMixP: M.CycleColorMixP;
    faColorMixM: M.CycleColorMixM;

    faTogglePin: M.FederModel.Pin := not M.FederModel.Pin;
    faPinOn: M.FederModel.Pin := True;
    faPinOff: M.FederModel.Pin := False;

    faToggleNorm: M.FederModel.Norm := not M.FederModel.Norm;
    faNormOn: M.FederModel.Norm := True;
    faNormOff: M.FederModel.Norm := False;

    faTextureNormP: M.CycleTextureNormP;
    faTextureNormM: M.CycleTextureNormM;
    faTextureNorm0: M.FederModel.TextureNorm := 0;
    faTextureNorm1: M.FederModel.TextureNorm := 1;
    faTextureNorm2: M.FederModel.TextureNorm := 2;

    faApplyRingColor: M.ApplyPaletteColor;

    faPixelCount1: M.PixelCount := 1;
    faPixelCount2: M.PixelCount := 2;
    faPixelCount4: M.PixelCount := 4;

    faBandSelectionM: M.ChangeRingIndex(M.CurrentRing - 1);
    faBandSelectionP: M.ChangeRingIndex(M.CurrentRing + 1);
    faBandSelection16: M.ChangeRingIndex(16);
    faBandSelection17: M.ChangeRingIndex(17);
    faBandSelection18: M.ChangeRingIndex(18);
    faBandSelection19: M.ChangeRingIndex(19);
    faBandSelection20: M.ChangeRingIndex(20);
    faBandSelection21: M.ChangeRingIndex(21);
    faParamBandSelected: M.ParamManager.ChangeParam(fpBandSelected);

    faParamBandCount: M.ParamManager.ChangeParam(fpBandCount);
    faParamBandDistributionX: M.ParamManager.ChangeParam(fpBandDistributionX);
    faParamBandDistributionY: M.ParamManager.ChangeParam(fpBandDistributionY);

    faParamBandWidth: M.ParamManager.ChangeParam(fpBandWidth);

    faBandWidthAbsolute:
    begin
      M.BandWidthOption := bwAbsolute;
      M.ParamManager.ChangeParam(fpBandWidth);
    end;
    faBandWidthRelative:
    begin
      M.BandWidthOption := bwRelative;
      M.ParamManager.ChangeParam(fpBandWidth);
    end;
    faBandWidthContour:
    begin
      M.BandWidthOption := bwContour;
      M.ParamManager.ChangeParam(fpBandWidth);
    end;

    faParamLabelTextX: M.ParamManager.ChangeParam(fpLabelTextX);
    faParamLabelTextY: M.ParamManager.ChangeParam(fpLabelTextY);
    faParamLabelTextZ: M.ParamManager.ChangeParam(fpLabelTextZ);

    faWriteActionReport,
    faWriteActionTable,
    faWriteActionConst,
    faWriteActionNames: M.HandleAction(fa);

    faSwapBundle: M.SwapBundle;

    faTransitionAll,
    faTransitionScript,
    faWriteVersion1,
    faWriteVersion2,
    faWriteCode,
    faWriteDiff1,
    faWriteDiffCode,
    faWriteDiffBin,
    faWriteBandInfo3,
    faWriteBandInfo5,
    faWriteEquationInfo,
    faWriteVirtual: M.HandleAction(fa);

    faBlockTest,
    faHelpCycle,
    faHelpList: M.HandleAction(fa);

    faTouchTablet,
    faTouchPhone,
    faTouchDesk: M.Touch := fa;

    faELLOn,
    faELLOff: M.HandleAction(fa);

    faMainMenuHide: M.MainMenuVisible := False;
    faMainMenuShow: M.MainMenuVisible := True;

    faTestBtnClick: M.MakeScene4;
    faShowInfo: M.ShowInfo;
    faToggleShowEdges: M.ToggleShowEdges;
    faToggleUniqueVertices: M.ToggleUniqueVertices;

    faUniqueMode1: M.ToggleUniqueMode(1);
    faUniqueMode2: M.ToggleUniqueMode(2);

    faFigureSizeXS: M.UpdateFigureSize(TSizeName.ExtraSmall);
    faFigureSizeS: M.UpdateFigureSize(TSizeName.Small);
    faFigureSizeM: M.UpdateFigureSize(TSizeName.Medium);
    faFigureSizeL: M.UpdateFigureSize(TSizeName.Large);
    faFigureSizeXL: M.UpdateFigureSize(TSizeName.ExtraLarge);

    faExample01: M.LoadExample(1);
    faExample02: M.LoadExample(2);
    faExample03: M.LoadExample(3);
    faExample04: M.LoadExample(4);
    faExample05: M.LoadExample(5);
    faExample06: M.LoadExample(6);
    faExample07: M.LoadExample(7);
    faExample08: M.LoadExample(8);

    faExample09: M.Example00;

    faSelectColor1: M.SelectedColor := 1;
    faSelectColor2: M.SelectedColor := 2;
    faSelectColor3: M.SelectedColor := 3;
    faSelectColor4: M.SelectedColor := 4;

    faSelectLayer1: M.Layer := 1;
    faSelectLayer2: M.Layer := 2;
    faSelectLayer3: M.Layer := 3;
    faSelectLayer4: M.Layer := 4;
    faSelectLayer5: M.Layer := 5;
    faSelectLayer6: M.Layer := 6;
    faSelectLayer7: M.Layer := 7;

    faMapColorToLayer: M.MapColorToLayer;
    faProcessAll: M.ActionItemList.ProcessAll;

    faSelectColorMapping1: M.UpdateRingMapping(1);
    faSelectColorMapping2: M.UpdateRingMapping(2);
    faSelectColorMapping3: M.UpdateRingMapping(3);
    faSelectColorMapping4: M.UpdateRingMapping(4);
    faSelectColorMapping5: M.UpdateRingMapping(5);
    faSelectColorMapping6: M.UpdateRingMapping(6);

    faEyeSizeS: M.UpdateEyeSize(TSizeName.Small);
    faEyeSizeM: M.UpdateEyeSize(TSizeName.Medium);
    faEyeSizeL: M.UpdateEyeSize(TSizeName.Large);

    faCLA,
    faTL01 .. faTL06,
    faTR01 .. faTR08,
    faBL01 .. faBL08,
    faBR01 .. faBR06: M.ApplyButtonColor(fa);

    faExportCoordsNative: M.ExportCoords := TExportCoords.Native;
    faExportCoordsBlender: M.ExportCoords := TExportCoords.App_Blender;
    faExportCoords3DV: M.ExportCoords := TExportCoords.App_3D_Viewer;
    faExportCoords3DP: M.ExportCoords := TExportCoords.App_3D_Printer;

    faExportMtl: M.ExportMtl;
    faExportObj: M.ExportObj;
    faWantAutoFolder: MainVar.WantAutoFolder := not MainVar.WantAutoFolder;
    faWantMaterial: M.ExporterOBJ.WantMaterial := not M.ExporterOBJ.WantMaterial;
    faWantSimpleName: M.ExporterOBJ.WantSimpleName := not M.ExporterOBJ.WantSimpleName;
    faWantAngularDir: M.ExporterOBJ.WantAngularDir := not M.ExporterOBJ.WantAngularDir;
    faWantNormals: M.ExporterOBJ.WantNormals := not M.ExporterOBJ.WantNormals;
    faWantUvs: M.ExporterOBJ.WantUVs := not M.ExporterOBJ.WantUVs;
    faObjDigits2: M.ExporterOBJ.ObjDigits := 2;
    faObjDigits3: M.ExporterOBJ.ObjDigits := 3;
    faObjDigits4: M.ExporterOBJ.ObjDigits := 4;
    faObjDigits5: M.ExporterOBJ.ObjDigits := 5;

    faWantSpecialY: M.ToggleSpecialY;
    faTestSingleSide: M.ToggleSingleSide;
    faToggleSolidFlip: M.ToggleSolidFlip;

    faWantBottom: M.ToggleBottom;
    faWantBottomMirrored: M.ToggleMirroredBottom;
    faWantSideCaps: M.ToggleSideCaps;

    else
    begin
      result := False;
    end;

  end;
end;

end.
