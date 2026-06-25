unit RiggVar.FederModel.ActionChecked;

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

function GetFederActionChecked(fa: TFederAction): Boolean;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst;

function GetFederActionChecked(fa: TFederAction): Boolean;
var
  M: TMain;
begin
  result := False;
  M := Main;
  if M = nil then
    Exit;
  if not M.IsUp then
    Exit;

  case fa of
    faCycleX: result := (M.Param = TFederUtils.GetParamInt(fpx1)) or
                        (M.Param = TFederUtils.GetParamInt(fpx2)) or
                        (M.Param = TFederUtils.GetParamInt(fpx3)) or
                        (M.Param = TFederUtils.GetParamInt(fpx4));

    faCycleY: result := (M.Param = TFederUtils.GetParamInt(fpy1)) or
                        (M.Param = TFederUtils.GetParamInt(fpy2)) or
                        (M.Param = TFederUtils.GetParamInt(fpy3)) or
                        (M.Param = TFederUtils.GetParamInt(fpy4));

    faCycleZ: result := (M.Param = TFederUtils.GetParamInt(fpz1)) or
                        (M.Param = TFederUtils.GetParamInt(fpz2)) or
                        (M.Param = TFederUtils.GetParamInt(fpz3)) or
                        (M.Param = TFederUtils.GetParamInt(fpz4));

    faCycleK: result := (M.Param = TFederUtils.GetParamInt(fpk1)) or
                        (M.Param = TFederUtils.GetParamInt(fpk2)) or
                        (M.Param = TFederUtils.GetParamInt(fpk3)) or
                        (M.Param = TFederUtils.GetParamInt(fpk4));

    faCycleL: result := (M.Param = TFederUtils.GetParamInt(fpl1)) or
                        (M.Param = TFederUtils.GetParamInt(fpl2)) or
                        (M.Param = TFederUtils.GetParamInt(fpl3)) or
                        (M.Param = TFederUtils.GetParamInt(fpl4));

    faCycleO: result := (M.Param = TFederUtils.GetParamInt(fpox)) or
                        (M.Param = TFederUtils.GetParamInt(fpoy)) or
                        (M.Param = TFederUtils.GetParamInt(fpoz));

    faOffsetX: result := M.Param = TFederUtils.GetParamInt(fpox);
    faOffsetY: result := M.Param = TFederUtils.GetParamInt(fpoy);
    faOffsetZ: result := M.Param = TFederUtils.GetParamInt(fpoz);

    faScene1: result := M.FederModel.Scene = 1;
    faScene2: result := M.FederModel.Scene = 2;
    faScene3: result := M.FederModel.Scene = 3;
    faScene4: result := M.FederModel.Scene = 4;
    faScene5: result := M.FederModel.Scene = 5;

    faPlot0: result := M.FederModel.Plot = 0;
    faPlot1: result := M.FederModel.Plot = 1;
    faPlot2: result := M.FederModel.Plot = 2;
    faPlot3: result := M.FederModel.Plot = 3;
    faPlot4: result := M.FederModel.Plot = 4;
    faPlot5: result := M.FederModel.Plot = 5;
    faPlot6: result := M.FederModel.Plot = 6;
    faPlot7: result := M.FederModel.Plot = 7;
    faPlot8: result := M.FederModel.Plot = 8;
    faPlot9: result := M.FederModel.Plot = 9;
    faPlot10: result := M.FederModel.Plot = 10;
    faPlot11: result := M.FederModel.Plot = 11;
    faPlot12: result := M.FederModel.Plot = 12;
    faPlot13: result := M.FederModel.Plot = 13;

    faFigure1: result := M.FederModel.Figure = 1;
    faFigure2: result := M.FederModel.Figure = 2;
    faFigure3: result := M.FederModel.Figure = 3;
    faFigure4: result := M.FederModel.Figure = 4;
    faFigure5: result := M.FederModel.Figure = 5;
    faFigure6: result := M.FederModel.Figure = 6;

    faGraph1: result := M.FederModel.Graph = 1;
    faGraph2: result := M.FederModel.Graph = 2;
    faGraph3: result := M.FederModel.Graph = 3;
    faGraph4: result := M.FederModel.Graph = 4;
    faGraph5: result := M.FederModel.Graph = 5;

    faParamT1: result := M.ParamManager.CurrentParam = fpt1;
    faParamT2: result := M.ParamManager.CurrentParam = fpt2;
    faParamT3: result := M.ParamManager.CurrentParam = fpt3;
    faParamT4: result := M.ParamManager.CurrentParam = fpt4;
    faParamRX: result := M.ParamManager.CurrentParam = fprx;
    faParamRY: result := M.ParamManager.CurrentParam = fpry;
    faParamRZ: result := M.ParamManager.CurrentParam = fprz;
    faParamCZ: result := M.ParamManager.CurrentParam = fpcz;

    faParamR: result := (M.ParamManager.CurrentParam = fpAbsoluteRange) or (M.ParamManager.CurrentParam = fpRange);
    faParamT: result := M.ParamManager.CurrentParam = fpt;
    faParamL: result := M.ParamManager.CurrentParam = fpl;
    faParamK: result := M.ParamManager.CurrentParam = fpk;
    faParamZ: result := M.ParamManager.CurrentParam = fpz;
    faParamA: result := M.ParamManager.CurrentParam = fpAttenuation;
    faParamG: result := M.ParamManager.CurrentParam = fpGrenze;

    faParamTRS: result := M.ParamManager.CurrentParam = fptrs;
    faParamTRT: result := M.ParamManager.CurrentParam = fptrt;
    faParamTRX: result := M.ParamManager.CurrentParam = fptrx;
    faParamTRY: result := M.ParamManager.CurrentParam = fptry;
    faParamX12: result := M.ParamManager.CurrentParam = fpx12;
    faParamY12: result := M.ParamManager.CurrentParam = fpy12;
    faParamZ12: result := M.ParamManager.CurrentParam = fpz12;

    faParam0: result := M.ParamManager.CurrentParam = fp0;
    faParam1: result := M.ParamManager.CurrentParam = fp1;
    faParam2: result := M.ParamManager.CurrentParam = fp2;
    faParam3: result := M.ParamManager.CurrentParam = fp3;
    faParam4: result := M.ParamManager.CurrentParam = fp4;
    faParam5: result := M.ParamManager.CurrentParam = fp5;
    faParam6: result := M.ParamManager.CurrentParam = fp6;
    faParam7: result := M.ParamManager.CurrentParam = fp7;
    faParam8: result := M.ParamManager.CurrentParam = fp8;
    faParam9: result := M.ParamManager.CurrentParam = fp9;

    faToggleAllText: result := M.FederText.AllVisible;
    faToggleTouchFrame: result := M.FederText.FrameVisible;
    faToggleTouchMenu: result := M.FederText.MenuVisible;
    faToggleEquationText: result := M.FederText.EquationVisible;
    faTogglePrimeText: result := M.FederText.TextVisible;
    faToggleSecondText: result := M.FederText.TitleVisible;
    faToggleLabelText: result := M.FederScene.ShowLabel;

    faToggleMarker: result := M.FederScene.ShowKugel;
    faToggleGrid: result := M.FederScene.ShowGrid;
    faToggleGridFrequency: result := M.FederScene.GridFrequency <> 10;
    faToggleQuickMesh: result := M.FederScene.QuickMesh;
    faToggleParamLock: result := M.FederData.ParamLock;
    faToggleReportLock: result := M.ReportLock;
    faToggleTextureLock: result := M.FederData.TextureLock;
    faToggleBMap: result := M.Bigmap;
    faToggleMCap: result := M.MinusCap;
    faTogglePCap: result := M.PlusCap;
    faToggleSolutionMode:  result := M.SolutionMode;
    faToggleVorzeichen: result := M.Vorzeichen;

    faToggleOrbitMode: result := M.OrbitMode;
    faToggleMoveMode: result := M.MoveMode;
    faLinearMove: result := M.MoveMode;
    faExpoMove: result := not M.MoveMode;

    faToggleGleich: result := M.Gleich;

    faOpenMesh: result := M.OpenMesh;
    faPolarMesh: result := M.PolarMesh;
    faReducedMesh: result := M.ReducedMesh;

    faMeshSize4: result := M.FederModel.MeshSize = 4;
    faMeshSize8: result := M.FederModel.MeshSize = 8;
    faMeshSize16: result := M.FederModel.MeshSize = 16;
    faMeshSize32: result := M.FederModel.MeshSize = 32;
    faMeshSize64: result := M.FederModel.MeshSize = 64;
    faMeshSize128: result := M.FederModel.MeshSize = 128;
    faMeshSize256: result := M.FederModel.MeshSize = 256;
    faMeshSize316: result := M.FederModel.MeshSize = 316;
    faMeshSize512: result := M.FederModel.MeshSize = 512;
    faMeshSize1024: result := M.FederModel.MeshSize = 1024;

    faWheelFrequency1: result := M.WheelFrequency = 1;
    faWheelFrequency05: result := M.WheelFrequency = 2;
    faWheelFrequency02: result := M.WheelFrequency = 3;
    faWheelFrequency01: result := M.WheelFrequency = 4;
    faWheelFrequency001: result := M.WheelFrequency = 5;
    faWheelFrequency0001: result := M.WheelFrequency = 6;

    faSetShift: result := ssShift in MainVar.ShiftState;
    faSetCtrl: result := ssCtrl in MainVar.ShiftState;
    faClearShift: result := MainVar.ShiftState = [];

    faKeyboard01: result := M.KeyBinding = 1;
    faKeyboard02: result := M.KeyBinding = 2;

    faAutoSend: result := M.AutoSend = faAutoSendOn;
    faToggleShirtColor: result := M.HasShirtColor;
    faShirtColorOn: result := M.HasShirtColor;
    faShirtColorOff: result := not M.HasShirtColor;
    faToggleShirtFarbe: result := M.HasShirtFarbe;
    faShirtFarbeOn: result := M.HasShirtFarbe;
    faShirtFarbeOff: result := not M.HasShirtFarbe;
    faToggleContour: result := M.BitmapBuilder.WantContour;

    faToggleLinearForce: result := M.Federmodel.EQ.LinearForce;
    faToggleColorPanel: result := M.ShowColorPanel;
    faToggleDropTarget: result := M.DropTargetVisible;
    faToggleForceLock: result := M.FederData.ForceLock;

    faShowCurrentBand0: result := not M.ShowCurrentBand;
    faShowCurrentBand1: result := M.ShowCurrentBand;
    faShowCurrentBandT: result := M.ShowCurrentBand;

    faColor0: result := M.Color = 0;
    faColor1: result := M.Color = 1;
    faColor2: result := M.Color = 2;
    faColor3: result := M.Color = 3;
    faColor4: result := M.Color = 4;
    faColor5: result := M.Color = 5;
    faColor6: result := M.Color = 6;

    faReduceMode0: result := M.FederScene.ReduceMode = 0;
    faReduceMode1: result := M.FederScene.ReduceMode = 1;
    faReduceMode2: result := M.FederScene.ReduceMode = 2;
    faReduceMode3: result := M.FederScene.ReduceMode = 3;

    faToggleZeroPulling: result := M.ZeroPulling;
    faToggleLimitPulling: result := M.LimitPulling;
    faToggleSlicePulling: result := M.SlicePulling;
    faToggleTargetPulling: result := M.TargetPulling;
    faToggleRightPulling: result := M.RightPulling;
    faToggleCrackFixing: result := M.CrackFixing;

    faTextureJitt: result := M.TextureJitt;
    faTextureJack: result := M.TextureJack;

    faForceMode0: result := M.FederModel.ForceMode = 0;
    faForceMode1: result := M.FederModel.ForceMode = 1;
    faForceMode2: result := M.FederModel.ForceMode = 2;

    faToggleLux: result := M.FederScene.WantLux;
    faToggleLux1: result := M.FederScene.WantLux1;
    faToggleLux2: result := M.FederScene.WantLux2;
    faToggleLux3: result := M.FederScene.WantLux3;
    faToggleLux4: result := M.FederScene.WantLux4;
    faToggleLuxMarker: result := M.FederScene.ShowLuxMarker;
    faToggleLuxLock: result := M.FederData.LuxLock;

    faToggleHardCopy: result := MainVar.HardCopyFlag;
    faTogglePngCopy: result := MainVar.PngCopyFlag;
    faToggleNoCopy: result := MainVar.NoCopyFlag;

    faColorMix0: result := M.RGBColorMix = 0;
    faColorMix1: result := M.RGBColorMix = 1;
    faColorMix2: result := M.RGBColorMix = 2;
    faColorMix3: result := M.RGBColorMix = 3;
    faColorMix4: result := M.RGBColorMix = 4;
    faColorMix5: result := M.RGBColorMix = 5;

    faTogglePin: result := M.FederModel.Pin;
    faToggleNorm: result := M.FederModel.Norm;

    faTextureNorm0: result := M.FederModel.TextureNorm = 0;
    faTextureNorm1: result := M.FederModel.TextureNorm = 1;
    faTextureNorm2: result := M.FederModel.TextureNorm = 2;

    faPixelCount1: result := M.PixelCount = 1;
    faPixelCount2: result := M.PixelCount = 2;
    faPixelCount4: result := M.PixelCount = 4;

    faSwapBundle: result := M.GetChecked(fa);

    faToggleColorSwat: result := M.ShowColorSwat;

    faLightMode0: result := M.CurrentLight = 0;
    faLightMode1: result := M.CurrentLight = 1;
    faLightMode2: result := M.CurrentLight = 2;
    faLightMode3: result := M.CurrentLight = 3;
    faLightMode4: result := M.CurrentLight = 4;

    faCoord0: result := M.CurrentCoord = 0;
    faCoord1: result := M.CurrentCoord = 1;
    faCoord2: result := M.CurrentCoord = 2;
    faCoord3: result := M.CurrentCoord = 3;

    faBandWidthAbsolute: result := (M.ParamManager.CurrentParam = fpBandWidth) and (M.BandWidthOption = bwAbsolute);
    faBandWidthRelative: result :=  (M.ParamManager.CurrentParam = fpBandWidth) and (M.BandWidthOption = bwRelative);
    faBandWidthContour: result :=  (M.ParamManager.CurrentParam = fpBandWidth) and (M.BandWidthOption = bwContour);
    faParamBandSelected: result := M.ParamManager.CurrentParam = fpBandSelected;

    faToggleCube: result := M.FederScene.ShowCube;
    faToggleCorner: result := M.FederScene.ShowCorner;
    faToggleLimitPlane: result := M.FederScene.ShowLimitPlane;
    faToggleCylinder: result := M.FederScene.ShowCylinder;
    faToggleDiameter: result := M.FederScene.ShowDiameter;

    faNorthCap: result := M.ParamManager.CurrentParam = fpNorthCapValue;
    faSouthCap: result := M.ParamManager.CurrentParam = fpSouthCapValue;
    faEastCap: result := M.ParamManager.CurrentParam = fpEastCapValue;
    faWestCap: result := M.ParamManager.CurrentParam = fpWestCapValue;
    faParamCapValue: result := M.ParamManager.CurrentParam = fpParamCapValue;

    faParamBahnRadius: result := M.ParamManager.CurrentParam = fpbpr;
    faParamBahnPositionX: result := M.ParamManager.CurrentParam = fpbpx;
    faParamBahnPositionY: result := M.ParamManager.CurrentParam = fpbpy;
    faParamBahnAngle: result := M.ParamManager.CurrentParam = fpbpa;
    faParamBahnCylinderD: result := M.ParamManager.CurrentParam = fpbcd;
    faParamBahnCylinderZ: result := M.ParamManager.CurrentParam = fpbcz;

    faToggleShowEdges: result := MainVar.ShowEdges;
    faToggleUniqueVertices: result := MainVar.WantUniqueVertices;
    faWantSpecialY: result := M.MeshBuilder.WantSpecialY;

    faParamL1X: result := M.ParamManager.CurrentParam = fpL1X;
    faParamL1Y: result := M.ParamManager.CurrentParam = fpL1Y;
    faParamL1Z: result := M.ParamManager.CurrentParam = fpL1Z;

    faParamL2X: result := M.ParamManager.CurrentParam = fpL2X;
    faParamL2Y: result := M.ParamManager.CurrentParam = fpL2Y;
    faParamL2Z: result := M.ParamManager.CurrentParam = fpL2Z;

    faParamL3X: result := M.ParamManager.CurrentParam = fpL3X;
    faParamL3Y: result := M.ParamManager.CurrentParam = fpL3Y;
    faParamL3Z: result := M.ParamManager.CurrentParam = fpL3Z;

    faParamL4X: result := M.ParamManager.CurrentParam = fpL4X;
    faParamL4Y: result := M.ParamManager.CurrentParam = fpL4Y;
    faParamL4Z: result := M.ParamManager.CurrentParam = fpL4Z;

    faPan: result := M.CurrentParam = fpPan;

    faFigureSizeXS: result := M.FigureSize = TSizeName.ExtraSmall;
    faFigureSizeS: result := M.FigureSize = TSizeName.Small;
    faFigureSizeM: result := M.FigureSize = TSizeName.Medium;
    faFigureSizeL: result := M.FigureSize = TSizeName.Large;
    faFigureSizeXL: result := M.FigureSize = TSizeName.ExtraLarge;

    faSelectLayer1: result := M.Layer = 1;
    faSelectLayer2: result := M.Layer = 2;
    faSelectLayer3: result := M.Layer = 3;
    faSelectLayer4: result := M.Layer = 4;
    faSelectLayer5: result := M.Layer = 5;
    faSelectLayer6: result := M.Layer = 6;
    faSelectLayer7: result := M.Layer = 7;

    faSelectColor1: result := M.SelectedColor = 1;
    faSelectColor2: result := M.SelectedColor = 2;
    faSelectColor3: result := M.SelectedColor = 3;
    faSelectColor4: result := M.SelectedColor = 4;

    faSelectColorMapping1: result := M.RingBuilder.MapID = 1;
    faSelectColorMapping2: result := M.RingBuilder.MapID = 2;
    faSelectColorMapping3: result := M.RingBuilder.MapID = 3;
    faSelectColorMapping4: result := M.RingBuilder.MapID = 4;
    faSelectColorMapping5: result := M.RingBuilder.MapID = 5;
    faSelectColorMapping6: result := M.RingBuilder.MapID = 6;

    faEyeSizeS: result := M.RingBuilder.EyeSize = TSizeName.Small;
    faEyeSizeM: result := M.RingBuilder.EyeSize = TSizeName.Medium;
    faEyeSizeL: result := M.RingBuilder.EyeSize = TSizeName.Large;

    faExample01: result := M.ExampleID = 1;
    faExample02: result := M.ExampleID = 2;
    faExample03: result := M.ExampleID = 3;
    faExample04: result := M.ExampleID = 4;
    faExample05: result := M.ExampleID = 5;
    faExample06: result := M.ExampleID = 6;
    faExample07: result := M.ExampleID = 7;
    faExample08: result := M.ExampleID = 8;
    faExample09: result := M.ExampleID = 9;

    faMenu00: result := M.MenubarLayout = 0;
    faMenu10: result := M.MenubarLayout = 10;
    faMenu20: result := M.MenubarLayout = 20;
    faMenu30: result := M.MenubarLayout = 30;
    faMenu40: result := M.MenubarLayout = 40;
    faMenu50: result := M.MenubarLayout = 50;
    faMenu60: result := M.MenubarLayout = 60;
    faMenu70: result := M.MenubarLayout = 70;
    faMenu80: result := M.MenubarLayout = 80;
    faMenu90: result := M.MenubarLayout = 90;

    faLayout0 .. faLayout99: result := M.TransitBarLayout = fa - faLayout0;
    faShowEditField: result := M.ShowEditField;

    faExportCoordsNative: result := M.ExportCoords = TExportCoords.Native;
    faExportCoordsBlender: result := M.ExportCoords = TExportCoords.App_Blender;
    faExportCoords3DV: result := M.ExportCoords = TExportCoords.App_3D_Viewer;
    faExportCoords3DP: result := M.ExportCoords = TExportCoords.App_3D_Printer;

    faWantAutoFolder: result := MainVar.WantAutoFolder;
    faWantMaterial: result := M.ExporterOBJ.WantMaterial;
    faWantSimpleName: result := M.ExporterOBJ.WantSimpleName;
    faWantAngularDir: result := M.ExporterOBJ.WantAngularDir;
    faWantNormals: result := M.ExporterOBJ.WantNormals;
    faWantUVs: result := M.ExporterOBJ.WantUVs;
    faObjDigits2: result := M.ExporterOBJ.ObjDigits = 2;
    faObjDigits3: result := M.ExporterOBJ.ObjDigits = 3;
    faObjDigits4: result := M.ExporterOBJ.ObjDigits = 4;
    faObjDigits5: result := M.ExporterOBJ.ObjDigits = 5;

    faTestSingleSide: result := not M.FederMesh.TwoSide;
    faToggleSolidFlip: result := M.FederMesh.WantFlippedHands;

    faWantBottom: result := M.SolidPartVisible;
    faWantBottomMirrored: result := M.Inner.WantMirroredBottom;
    faWantSideCaps: result := M.SideCapVisible;

    faUniqueMode1: result := MainVar.UniqueMode = 1;
    faUniqueMode2: result := MainVar.UniqueMode = 2;
  end;
end;

end.
