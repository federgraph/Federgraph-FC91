unit RiggVar.FB.ActionLong;

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
  RiggVar.FB.ActionConst;

function GetFederActionLong(fa: TFederAction): string;

implementation

function GetFederActionLong(fa: TFederAction): string;
begin
  result := '??';
  case fa of
    // --- generated code snippet ---

    { EmptyAction }
    faNoop: result := 'Noop';

    { Pages }
    faActionPageM: result := 'Action Page -';
    faActionPageP: result := 'Action Page +';
    faActionPageE: result := 'Action Page E';
    faActionPageS: result := 'Action Page S';
    faActionPageX: result := 'Action Page X';
    faActionPage1: result := 'Action Page 1';
    faActionPage2: result := 'Action Page 2';
    faActionPage3: result := 'Action Page 3';
    faActionPage4: result := 'Action Page 4';
    faActionPage5: result := 'Action Page 5';
    faActionPage6: result := 'Action Page 6';

    { Forms }
    faShowImage: result := 'Form Image';
    faShowMemo: result := 'Form Memo';
    faShowActions: result := 'Form Actions';
    faShowColor: result := 'Form Color';
    faShowBambu: result := 'Form Bambu';
    faShowAnim: result := 'Form Animations';
    faEditText: result := 'Edit Text';
    faEditConn: result := 'Edit Connection Info';
    faEditHost: result := 'Edit Host Info';
    faEditPort: result := 'Edit Port Info';
    faShowRepo: result := 'Form Repository';
    faShowInfo: result := 'Form Info';

    { TouchLayout }
    faTouchTablet: result := 'Touch Tablet';
    faTouchPhone: result := 'Touch Phone';
    faTouchDesk: result := 'Touch Desk';

    { ActionMapping }
    faProcessAll: result := 'Process All';

    { Scene }
    faScene1: result := 'S1';
    faScene2: result := 'S2';
    faScene3: result := 'S3';
    faScene4: result := 'S4';
    faScene5: result := 'S5';

    { Plot }
    faPlot0: result := 'P0';
    faPlot1: result := 'P1';
    faPlot2: result := 'P2';
    faPlot3: result := 'P3';
    faPlot4: result := 'P4';
    faPlot5: result := 'P5';
    faPlot6: result := 'P6';
    faPlot7: result := 'P7';
    faPlot8: result := 'P8';
    faPlot9: result := 'P9';
    faPlot10: result := 'P10';
    faPlot11: result := 'P11';
    faPlot12: result := 'P12';
    faPlot13: result := 'P13';

    { Figure }
    faFigure1: result := 'F1';
    faFigure2: result := 'F2';
    faFigure3: result := 'F3';
    faFigure4: result := 'F4';
    faFigure5: result := 'F5';
    faFigure6: result := 'F6';

    { Graph }
    faGraph1: result := 'G1';
    faGraph2: result := 'G2';
    faGraph3: result := 'G3';
    faGraph4: result := 'G4';
    faGraph5: result := 'G5';

    { Color }
    faColor0: result := 'C0';
    faColor1: result := 'C1';
    faColor2: result := 'C2';
    faColor3: result := 'C3';
    faColor4: result := 'C4';
    faColor5: result := 'C5';
    faColor6: result := 'C6';

    { Param }
    faParam0: result := 'Param 0';
    faParam1: result := 'Param 1';
    faParam2: result := 'Param 2';
    faParam3: result := 'Param 3';
    faParam4: result := 'Param 4';
    faParam5: result := 'Param 5';
    faParam6: result := 'Param 6';
    faParam7: result := 'Param 7';
    faParam8: result := 'Param 8';
    faParam9: result := 'Param 9';

    { SystemParam }
    faParamX1: result := 'Param x1';
    faParamY1: result := 'Param y1';
    faParamZ1: result := 'Param z1';
    faParamL1: result := 'Param l1';
    faParamK1: result := 'Param k1';
    faParamX2: result := 'Param x2';
    faParamY2: result := 'Param y2';
    faParamZ2: result := 'Param z2';
    faParamL2: result := 'Param l2';
    faParamK2: result := 'Param k2';
    faParamX3: result := 'Param x3';
    faParamY3: result := 'Param y3';
    faParamZ3: result := 'Param z3';
    faParamL3: result := 'Param l3';
    faParamK3: result := 'Param k3';
    faParamX4: result := 'Param x4';
    faParamY4: result := 'Param y4';
    faParamZ4: result := 'Param z4';
    faParamL4: result := 'Param l4';
    faParamK4: result := 'Param k4';

    { OffsetParam }
    faOffsetX: result := 'Param Offset X';
    faOffsetY: result := 'Param Offset Y';
    faOffsetZ: result := 'Param Offset Z';

    { CoordParam }
    faCoord0: result := 'Move Coord 0';
    faCoord1: result := 'Move Coord 1';
    faCoord2: result := 'Move Coord 2';
    faCoord3: result := 'Move Coord 3';

    { LuxParam }
    faParamL1X: result := 'Param Lux 1 X';
    faParamL1Y: result := 'Param Lux 1 Y';
    faParamL1Z: result := 'Param Lux 1 Z';
    faParamL2X: result := 'Param Lux 2 X';
    faParamL2Y: result := 'Param Lux 2 Y';
    faParamL2Z: result := 'Param Lux 2 Z';
    faParamL3X: result := 'Param Lux 3 X';
    faParamL3Y: result := 'Param Lux 3 Y';
    faParamL3Z: result := 'Param Lux 3 Z';
    faParamL4X: result := 'Param Lux 4 X';
    faParamL4Y: result := 'Param Lux 4 Y';
    faParamL4Z: result := 'Param Lux 4 Z';

    { ParamCycle }
    faCycleX: result := 'cycle coord x';
    faCycleY: result := 'cycle coord y';
    faCycleZ: result := 'cycle coord z';
    faCycleL: result := 'cycle length l';
    faCycleK: result := 'cycle factor k';
    faCycleO: result := 'cycle offset o';
    faCycleR: result := 'cycle rotation r';
    faCycleT: result := 'cycle texture params';
    faCycleU: result := 'cycle u +';

    { ModelParams }
    faParamR: result := 'Range';
    faParamT: result := 'Triangle';
    faParamL: result := 'Length';
    faParamK: result := 'Param K';
    faParamZ: result := 'Plane';
    faParamA: result := 'Attenuation';
    faParamG: result := 'Grenze';
    faParamX12: result := 'Param x12';
    faParamY12: result := 'Param y12';
    faParamZ12: result := 'Param z12';
    faParamY3F: result := 'y3f';
    faParamL3F: result := 'l3f';
    faParamLF: result := 'Lf';

    { ModelOptions }
    faToggleSolutionMode: result := 'Solution mode';
    faToggleVorzeichen: result := 'Vorzeichen (Sign)';
    faToggleLinearForce: result := 'Linear Force';
    faToggleGleich: result := 'Gleichseitig (Equilateral)';
    faToggleMCap: result := 'Minus cap';
    faTogglePCap: result := 'Plus cap';
    faForceZ0: result := 'Use original PosZ';
    faWantZ12: result := 'Use PosZ1 if available';
    faDiff0: result := 'Set Diffmode to false';
    faDiff1: result := 'Set Diffmode to true';
    faDiff10: result := 'Raise Diffmode flag (one time)';

    { OptionCycle }
    faCyclePlotM: result := 'cycle plot -';
    faCyclePlotP: result := 'cycle plot +';
    faCycleGraphM: result := 'cycle graph -';
    faCycleGraphP: result := 'cycle graph +';
    faCycleFigureM: result := 'cycle figure -';
    faCycleFigureP: result := 'cycle figure +';

    { ForceMode }
    faForceMode0: result := 'Zug-Druck';
    faForceMode1: result := 'Zug';
    faForceMode2: result := 'Druck';

    { FederMode }
    faM1: result := 'm1';
    faM2: result := 'm2';
    faM3: result := 'm3';

    { RingActions }
    faBlindRingP: result := 'Blind Ring P';
    faBlindRingM: result := 'Blind Ring M';
    faCycleRingP: result := 'Cycle Ring P';
    faCycleRingM: result := 'Cycle Ring M';
    faToggleShirtColor: result := 'Toggle shirt color';
    faShirtColorOn: result := 'Shirt color on';
    faShirtColorOff: result := 'Shirt color off';
    faApplyRingColor: result := 'ApplyRingColor';
    faToggleShirtFarbe: result := 'Toggle shirt Farbe';
    faShirtFarbeOn: result := 'Shirt Farbe on';
    faShirtFarbeOff: result := 'Shirt Farbe off';
    faPixelCount1: result := ' Pixel Count 1';
    faPixelCount2: result := ' Pixel Count 2';
    faPixelCount4: result := ' Pixel Count 4';

    { ParamBand }
    faParamBandSelected: result := 'Param Band Selected';
    faParamBandCount: result := 'Param Band Count';
    faParamBandDistributionX: result := 'Param Band Distribution X';
    faParamBandDistributionY: result := 'Param Band Distribution Y';
    faParamBandWidth: result := 'Param Band Width';
    faBandWidthAbsolute: result := 'Band Width Absolute';
    faBandWidthRelative: result := 'Band Width Relative';
    faBandWidthContour: result := 'Band Width Countour';

    { BlindRingSelection }
    faBlindRing1: result := 'Blind Ring 1';
    faBlindRing5: result := 'Blind Ring 5';
    faBlindRingA: result := 'Blind Ring A';
    faBlindRingB: result := 'Blind Ring B';
    faBlindRingC: result := 'Blind Ring C';
    faBlindRingD: result := 'Blind Ring D';
    faBlindRingE: result := 'Blind Ring E';
    faBlindRingF: result := 'Blind Ring F';

    { CurrentBand }
    faShowCurrentBand0: result := 'Hide Current Band';
    faShowCurrentBand1: result := 'Show Current Band';
    faShowCurrentBandT: result := 'Toggle Current Band';

    { BandSelection }
    faBandSelectionM: result := 'Band Selection -';
    faBandSelectionP: result := 'Band Selection +';
    faBandSelection16: result := 'Band Selection 16';
    faBandSelection17: result := 'Band Selection 17';
    faBandSelection18: result := 'Band Selection 18';
    faBandSelection19: result := 'Band Selection 19';
    faBandSelection20: result := 'Band Selection 20';
    faBandSelection21: result := 'Band Selection 21';

    { MeshMode }
    faOpenMesh: result := 'Open mesh';
    faPolarMesh: result := 'Polar mesh';
    faReducedMesh: result := 'Reduced mesh';
    faReduceMode0: result := 'Reduce mode 0';
    faReduceMode1: result := 'Reduce mode 1';
    faReduceMode2: result := 'Reduce mode 2';
    faReduceMode3: result := 'Reduce mode 3';

    { MeshSize }
    faMeshSize4: result := 'MeshSize 4';
    faMeshSize8: result := 'MeshSize 8';
    faMeshSize16: result := 'MeshSize 16';
    faMeshSize32: result := 'MeshSize 32';
    faMeshSize64: result := 'MeshSize 64';
    faMeshSize128: result := 'MeshSize 128';
    faMeshSize256: result := 'MeshSize 256';
    faMeshSize316: result := 'MeshSize 316';
    faMeshSize512: result := 'MeshSize 512';
    faMeshSize1024: result := 'MeshSize 1024';

    { MeshExport }
    faWantBottom: result := 'Want Bottom';
    faWantBottomMirrored: result := 'Want Bottom Mirrored';
    faWantSideCaps: result := 'Want Side Caps';
    faTestSingleSide: result := 'Test SingleSide rendering';
    faTakeCapValueSnapshot: result := 'Take CapValue Snapshot';

    { MeshExportCoords }
    faExportCoordsNative: result := 'ExportCoords Native';
    faExportCoordsBlender: result := 'ExportCoords Blender';
    faExportCoords3DV: result := 'ExportCoords 3DV';
    faExportCoords3DP: result := 'ExportCoords 3DP';

    { MeshOptions }
    faTextureJitt: result := 'Texture Jitter';
    faTextureJack: result := 'Texture Jack';

    { ExporterOBJ }
    faWantAutoFolder: result := 'Want Auto Folder';
    faExportMtl: result := 'Export MTL';
    faExportObj: result := 'Export Obj';
    faWantMaterial: result := 'Want Material (mtl)';
    faWantSimpleName: result := 'Want Simple Name';
    faWantAngularDir: result := 'Want Angular Dir';
    faWantNormals: result := 'Want Normals (nv)';
    faWantUVs: result := 'Want UVs (nt)';
    faObjDigits2: result := '2 Digits';
    faObjDigits3: result := '3 Digits';
    faObjDigits4: result := '4 Digits';
    faObjDigits5: result := '5 Digits';

    { MeshFigures }
    faToggleMarker: result := 'Marker';
    faToggleGrid: result := 'Grid';
    faToggleGridFrequency: result := 'Grid frequency';
    faToggleDiameter3: result := 'Toggle Diameter 3';
    faDiameter3On: result := 'Diameter 3 On';
    faDiameter3Off: result := 'Diameter 3 Off';
    faToggleCylinder: result := 'Toggle Cylinder';
    faToggleCube: result := 'Show Cube';
    faToggleCorner: result := 'Show Corner';
    faToggleLimitPlane: result := 'Toggle Limit Plane';

    { VertexPulling }
    faToggleZeroPulling: result := 'Zero Pulling';
    faToggleLimitPulling: result := 'Limit Pulling';
    faToggleSlicePulling: result := 'Slice Pulling';
    faToggleTargetPulling: result := 'Target Pulling';
    faToggleRightPulling: result := 'Right Pulling';
    faToggleCrackFixing: result := 'Crack Fixing';

    { MeshBuilderOptions }
    faToggleSolidFlip: result := 'Toggle SolidFlip';
    faWantSpecialY: result := 'Want Special Y';
    faToggleShowEdges: result := 'Toggle ShowEdges';
    faUniqueMode1: result := 'Unique Mode 1';
    faUniqueMode2: result := 'Unique Mode 2';
    faToggleUniqueVertices: result := 'Toggle UniqueVertices';

    { Pin }
    faTogglePin: result := 'Toggle Pin';
    faPinOn: result := 'Pin AP On';
    faPinOff: result := 'Pin AP Off';

    { Norm }
    faToggleNorm: result := 'Toggle Norm';
    faNormOn: result := 'Norm On';
    faNormOff: result := 'Norm Off';

    { TextureNorm }
    faTextureNormP: result := 'Texture Norm +';
    faTextureNormM: result := 'Texture Norm -';
    faTextureNorm0: result := 'Texture Norm 0';
    faTextureNorm1: result := 'Texture Norm 1';
    faTextureNorm2: result := 'Texture Norm 2';

    { TextureExport }
    faCopyBinCode: result := 'Copy Bin Code';
    faCopyBinCodeTest: result := 'Copy Bin Code Test';

    { TextureImport }
    faTextureClear: result := 'Reset Texture';

    { ColorMix }
    faColorMix0: result := 'Color Mix 0 (rgb)';
    faColorMix1: result := 'Color Mix 1 (rbg)';
    faColorMix2: result := 'Color Mix 2 (gbr)';
    faColorMix3: result := 'Color Mix 3 (grb)';
    faColorMix4: result := 'Color Mix 4 (brg)';
    faColorMix5: result := 'Color Mix 5 (bgr)';
    faColorMixP: result := 'Cycle ColorMix Plus';
    faColorMixM: result := 'Cycle Color Mix Minus';

    { ColorSwat }
    faToggleColorSwat: result := 'Color Swat';

    { Lux }
    faLux1On: result := 'Lux 1 On';
    faLux1Off: result := 'Lux 1 Off';
    faToggleLux1: result := 'Lux 1';
    faLux2On: result := 'Lux 2 On';
    faLux2Off: result := 'Lux 2 Off';
    faToggleLux2: result := 'Lux 2';
    faLux3On: result := 'Lux 3 On';
    faLux3Off: result := 'Lux 3 Off';
    faToggleLux3: result := 'Lux 3';
    faLux4On: result := 'Lux 4 On';
    faLux4Off: result := 'Lux 4 Off';
    faToggleLux4: result := 'Lux 4';
    faLuxOn: result := 'Light On';
    faLuxOff: result := 'Light Off';
    faToggleLux: result := 'Light';

    { LuxMarker }
    faLuxMarkerOn: result := 'Lux Marker On';
    faLuxMarkerOff: result := 'Lux Marker Off';
    faToggleLuxMarker: result := 'Toggle Lux Marker';

    { LightMode }
    faLightMode0: result := 'LightMode 0';
    faLightMode1: result := 'LightMode 1';
    faLightMode2: result := 'LightMode 2';
    faLightMode3: result := 'LightMode 3';
    faLightMode4: result := 'LightMode 4';

    { ResetLight }
    faResetLightPosition: result := 'Reset Light 1 (Position)';
    faResetLightParams: result := 'Reset Light 2 (Params)';

    { Wheel }
    faParamValuePlus1: result := 'Param Value + 1';
    faParamValueMinus1: result := 'Param Value - 1';
    faParamValuePlus10: result := 'Param Value + 10';
    faParamValueMinus10: result := 'Param Value - 10';
    faWheelLeft: result := 'Wheel -1';
    faWheelRight: result := 'Wheel +1';
    faWheelDown: result := 'Wheel -10';
    faWheelUp: result := 'Wheel +10';

    { WheelFrequency }
    faWheelFrequency1: result := 'Wheel Frequency 1';
    faWheelFrequency05: result := 'Wheel Frequency 0.5';
    faWheelFrequency02: result := 'Wheel Frequency 0.2';
    faWheelFrequency01: result := 'Wheel Frequency 0.1';
    faWheelFrequency001: result := 'Wheel Frequency 0.01';
    faWheelFrequency0001: result := 'Wheel Frequenc 0.001';

    { ColorScheme }
    faCycleColorSchemeM: result := 'cycle color scheme -';
    faCycleColorSchemeP: result := 'cycle color scheme +';

    { AnimatedRotations }
    faRotX: result := 'Rot X';
    faRotY: result := 'Rot Y';
    faRotZ: result := 'Rot Z';
    faRotXM: result := 'Rotation X+';
    faRotXP: result := 'Rotation X-';
    faRotYM: result := 'Rotation Y-';
    faRotYP: result := 'Rotation Y+';
    faRotZM: result := 'Rotation Z-';
    faRotZP: result := 'Rotation Z+';

    { Step }
    faStepRXM: result := 'Rotation step x-';
    faStepRXP: result := 'Rotation step x+';
    faStepRYM: result := 'Rotation step y-';
    faStepRYP: result := 'Rotation step y+';
    faStepRZM: result := 'Rotation step z-';
    faStepRZP: result := 'Rotation step z+';
    faStepCZM: result := 'Zoom step cz-';
    faStepCZP: result := 'Zoom step cz+';

    { UI }
    faParamLabelTextX: result := 'Label Text X';
    faParamLabelTextY: result := 'Label Text Y';
    faParamLabelTextZ: result := 'lLabel Text Z';
    faToggleColorPanel: result := 'Color Panel';
    faColorPanelOn: result := 'Toggle Color Panel On';
    faColorPanelOff: result := 'Toggle Color Panel Off';
    faShowEditField: result := 'Show Edit field';
    faFocusEditField: result := 'Focus Edit field';
    faInitSpecial: result := 'Init Special';
    faPaletteOn: result := 'Toggle Palette On';
    faPaletteOff: result := 'Toggle Palette Off';

    { Locks }
    faToggleLuxLock: result := 'Lux Lock';
    faToggleParamLock: result := 'Param lock';
    faToggleTextureLock: result := 'Texture lock';
    faToggleBackgroundLock: result := 'Set background color lock';
    faToggleForceLock: result := 'Force lock';
    faToggleReportLock: result := 'Report Lock';

    { Opacity }
    faToggleOpacity: result := 'Toggle Opacity';
    faOpacityOn: result := 'Opacity On';
    faOpacityOff: result := 'Opacity Off';

    { MainMenuActivation }
    faMainMenuHide: result := 'Hide Main Menu';
    faMainMenuShow: result := 'Show Menu Show';

    { FederText }
    faToggleAllText: result := 'Toggle All Text';
    faToggleTouchFrame: result := 'Toggle Touch Frame';

    { ViewParams }
    faPan: result := 'Pan';
    faParamRX: result := 'Model Rotation X';
    faParamRY: result := 'Model Rotation Y';
    faParamRZ: result := 'Model Rotation Z';
    faParamCZ: result := 'Camera Position Z';

    { ViewParamsFC }
    faRotStep0: result := 'Test Rotation Step 0';
    faRotStep1: result := 'Test Rotation Step 1';
    faRotStep2: result := 'Test Rotation Step 2';
    faRotStep3: result := 'Test Rotation Step 3';
    faRotStepA: result := 'Test Rotation Step 4 (A)';
    faParamTRS: result := 'Param trs';
    faParamTRT: result := 'Param trt';
    faParamTRX: result := 'Param trx';
    faParamTRY: result := 'Param try';

    { ParamT }
    faParamT1: result := 'Param T1';
    faParamT2: result := 'Param T2';
    faParamT3: result := 'Param T3';
    faParamT4: result := 'Param T4';

    { ViewFlags }
    faToggleBMap: result := 'Big map';
    faToggleZoom: result := 'Toggle tile zoom';
    faToggleTouchMenu: result := 'Toggle Touch Menu';
    faToggleEquationText: result := 'Equation text visibility';
    faTogglePrimeText: result := 'Primary text visibility';
    faToggleSecondText: result := 'Secondary text visibility';
    faToggleLabelText: result := 'Label text visibility';
    faLabelBatchM: result := 'cycle label batch -';
    faLabelBatchP: result := 'cycle label batch +';
    faLabelTextP: result := 'LabelText plus';
    faLabelTextM: result := 'LabelText minus';

    { Report }
    faCopyShortCutReport: result := 'Copy Shortcut Report';
    faWriteActionReport: result := 'Write Action Report';
    faWriteActionTable: result := 'Write Action Table';
    faWriteActionConst: result := 'Write Action Constants';
    faWriteActionNames: result := 'Write Action Names';
    faWriteVersion1: result := 'Write Version 1 - Java Properties style';
    faWriteVersion2: result := 'Write Version 2 - Two digit keys';
    faWriteCode: result := 'Write Code - Pascal style';
    faWriteDiff1: result := 'Write Version 1 Diff';
    faWriteDiffCode: result := 'Write Diff Code';
    faWriteDiffBin: result := 'Write Bin Data';
    faWriteBandInfo3: result := 'Write Band Info 3: W-R-G-B';
    faWriteBandInfo5: result := 'Write Band Info 5: W-R-G-B-C-A';
    faWriteEquationInfo: result := 'Write Equation Info';
    faWriteVirtual: result := 'Write Virtual';
    faBlockTest: result := 'Block Test';

    { ReportOptions }
    faSourcePascal: result := 'Copy Pascal';
    faSourceMaxima: result := 'Copy Maxima';
    faSourceMaple: result := 'Copy Maple';
    faSourceMathematica: result := 'Copy Mathematica';

    { CopyImage }
    faCopyScreenshot: result := 'Copy Screenshot';
    faCopyBitmap3D: result := 'Copy 3D Bitmap';
    faCopyTextureBitmap: result := 'Copy Texture Bitmap';
    faCopyImprintedBitmap: result := 'Copy Imprinted Bitmap';
    faCopyImprintedBitmapTest: result := 'Copy Imprinted Bitmap Test';

    { CopyOptions }
    faToggleHardCopy: result := 'Toggle Hard Copy';
    faHardCopyOn: result := 'Hard Copy On';
    faHardCopyOff: result := 'Hard Copy Off';
    faTogglePngCopy: result := 'Toggle Png Copy';
    faPngCopyOn: result := 'Png Copy On';
    faPngCopyOff: result := 'Png Copy Off';
    faToggleNoCopy: result := 'Toggle No Copy';
    faNoCopyOn: result := 'No Copy On';
    faNoCopyOff: result := 'No Copy Off';

    { GraphOptions }
    faToggleDiameter: result := 'Toggle Diameter';
    faToggleProbe: result := 'Toggle Probe';

    { Bahn }
    faNorthCap: result := 'Param North Cap Value';
    faSouthCap: result := 'Param South Cap Value';
    faEastCap: result := 'Param East Cap Value';
    faWestCap: result := 'Param West Cap Value';
    faParamCapValue: result := 'Param Cap Value';
    faParamBahnRadius: result := 'Param Bahn: Radius';
    faParamBahnPositionX: result := 'Param Bahn: Position X';
    faParamBahnPositionY: result := 'Param Bahn: Position Y';
    faParamBahnAngle: result := 'Param Bahn: Angle';
    faParamBahnCylinderD: result := 'Param Bahn: Cylinder Depth';
    faParamBahnCylinderZ: result := 'Param Bahn: Cylinder Position Z';

    { AnimationStore }
    faRecall1: result := 'Memory Recall 1';
    faRecall2: result := 'Memory Recall 2';
    faMemory1: result := 'Memory 1';
    faMemory2: result := 'Memory 2';
    faTransit: result := 'Transition Start/Stop';

    { AnimPlay }
    faPlay: result := 'Play';
    faExecute: result := 'Execute';
    faAnimationStop: result := 'Animation Stop';
    faAnimationStartA: result := 'A1';
    faAnimationStartD: result := 'A2';
    faAnimationStartF: result := 'A3';
    faAnimationStartS: result := 'A4';
    faAnimationStartT: result := 'A5';

    { Transit }
    faTransitionAll: result := 'Transition All';
    faTransitionScript: result := 'Transition Script';

    { Connect }
    faConnect: result := 'Connect';
    faDisconnect: result := 'Disconnect';
    faDownload: result := 'Download';
    faAutoSend: result := 'Toggle AutoSend';
    faAutoSendOn: result := 'Set AutoSend on';
    faAutoSendOff: result := 'Turn AutoSend off';

    { ExampleData }
    faExample01: result := 'Example 01';
    faExample02: result := 'Example 02';
    faExample03: result := 'Example 03';
    faExample04: result := 'Example 04';
    faExample05: result := 'Example 05';
    faExample06: result := 'Example 06';
    faExample07: result := 'Example 07';
    faExample08: result := 'Example 08';
    faExample09: result := 'Example 09';

    { Repo }
    faSwapBundle: result := 'swap bundle';
    faRepo010: result := 'Repo 10';
    faRepo020: result := 'Repo 20';
    faRepo050: result := 'Repo 50';

    { SampleNavigation }
    faLevelM: result := 'Level -';
    faLevelP: result := 'Level +';
    faHubM: result := 'Hub -';
    faHubP: result := 'Hub +';
    faSampleM: result := 'Sample -';
    faSampleP: result := 'Sample +';
    faGotoSample0: result := 'Goto Sample 0';
    faGotoSample1: result := 'Goto Sample 1';

    { DebugOptions }
    faTestBtnClick: result := 'Test Btn Click';
    faRunBinPixelTest: result := 'Run Bin Pixel Test';

    { EmptyLastLine }
    faELLOn: result := 'Empty Last Line On';
    faELLOff: result := 'Empty Last Line Off';

    { Help }
    faToggleHelp: result := 'Toggle Help Text';
    faToggleReport: result := 'Toggle Report';
    faToggleButtonReport: result := 'Button Frame Report';
    faCycleHelpM: result := 'cycle help text -';
    faCycleHelpP: result := 'cycle help text +';
    faHelpCycle: result := 'Help Cycle';
    faHelpList: result := 'Help Listing';
    faHelpHome: result := 'Help home';

    { BtnLegendTablet }
    faTL01: result := 'Top Left 1';
    faTL02: result := 'Top Left 2';
    faTL03: result := 'Top Left 3';
    faTL04: result := 'Top Left 4';
    faTL05: result := 'Top Left 5';
    faTL06: result := 'Top Left 6';
    faTR01: result := 'Top Right 1';
    faTR02: result := 'Top Right 2';
    faTR03: result := 'Top Right 3';
    faTR04: result := 'Top Right 4';
    faTR05: result := 'Top Right 5';
    faTR06: result := 'Top Right 6';
    faTR07: result := 'Top Right 7';
    faTR08: result := 'Top Right 8';
    faBL01: result := 'Bottom Left 1';
    faBL02: result := 'Bottom Left 2';
    faBL03: result := 'Bottom Left 3';
    faBL04: result := 'Bottom Left 4';
    faBL05: result := 'Bottom Left 5';
    faBL06: result := 'Bottom Left 6';
    faBL07: result := 'Bottom Left 7';
    faBL08: result := 'Bottom Left 8';
    faBR01: result := 'Bottom Right 1';
    faBR02: result := 'Bottom Right 2';
    faBR03: result := 'Bottom Right 3';
    faBR04: result := 'Bottom Right 4';
    faBR05: result := 'Bottom Right 5';
    faBR06: result := 'Bottom Right 6';

    { BtnLegendPhone }
    faMB01: result := 'Mobile Btn 1';
    faMB02: result := 'Mobile Btn 2';
    faMB03: result := 'Mobile Btn 3';
    faMB04: result := 'Mobile Btn 4';
    faMB05: result := 'Mobile Btn 5';
    faMB06: result := 'Mobile Btn 6';
    faMB07: result := 'Mobile Btn 7';
    faMB08: result := 'Mobile Btn 8';

    { TouchBarLegend }
    faTouchBarTop: result := 'TouchBar Top';
    faTouchBarBottom: result := 'TouchBar Bottom';
    faTouchBarLeft: result := 'TouchBar Left';
    faTouchBarRight: result := 'TouchBar Right';

    { Reset }
    faReset: result := 'Reset';
    faResetPosition: result := 'Reset Position';
    faResetRotation: result := 'Reset Rotation';
    faResetZoom: result := 'Reset Zoom';

    { DropTarget }
    faToggleDropTarget: result := 'Drop target';

    { Language }
    faToggleLanguage: result := 'Toggle Language';

    { CopyPaste }
    faSave: result := 'Save';
    faLoad: result := 'Load';
    faOpen: result := 'Open';
    faCopy: result := 'Copy';
    faPaste: result := 'Paste';

    { ViewOptions }
    faToggleMoveMode: result := 'Toggle move mode';
    faLinearMove: result := 'Linear move';
    faExpoMove: result := 'Exponential move';
    faToggleQuickMesh: result := 'Quick mesh';
    faToggleOrbitMode: result := 'fToggle orbit mode';

    { BitmapCycle }
    faCycleBitmapM: result := 'cycle bitmap -';
    faCycleBitmapP: result := 'cycle bitmap +';
    faRandom: result := 'Random Param Values';
    faRandomWhite: result := 'random colors white rings';
    faRandomBlack: result := 'random colors black rings';
    faRandomBambu1: result := 'random PLA colors 1';
    faRandomBambu2: result := 'random PLA colors 2';
    faBitmapEscape: result := 'Enter outer cycle';
    faBitmapOne: result := 'goto bitmap one';
    faToggleContour: result := 'Toggle contour rings';

    { Layout0 }
    faLayout0: result := 'Transitbar Layout 0';
    faLayout1: result := 'Transitbar Layout 1';
    faLayout2: result := 'Transitbar Layout 2';
    faLayout3: result := 'Transitbar Layout 3';
    faLayout4: result := 'Transitbar Layout 4';
    faLayout5: result := 'Transitbar Layout 5';
    faLayout6: result := 'Transitbar Layout 6';
    faLayout7: result := 'Transitbar Layout 7';
    faLayout8: result := 'Transitbar Layout 8';
    faLayout9: result := 'Transitbar Layout 9';

    { Layout1 }
    faLayout10: result := 'Transitbar Layout 10';
    faLayout11: result := 'Transitbar Layout 11';
    faLayout12: result := 'Transitbar Layout 12';
    faLayout13: result := 'Transitbar Layout 13';
    faLayout14: result := 'Transitbar Layout 14';
    faLayout15: result := 'Transitbar Layout 15';
    faLayout16: result := 'Transitbar Layout 16';
    faLayout17: result := 'Transitbar Layout 17';
    faLayout18: result := 'Transitbar Layout 18';
    faLayout19: result := 'Transitbar Layout 19';

    { Layout2 }
    faLayout20: result := 'Transitbar Layout 20';
    faLayout21: result := 'Transitbar Layout 21';
    faLayout22: result := 'Transitbar Layout 22';
    faLayout23: result := 'Transitbar Layout 23';
    faLayout24: result := 'Transitbar Layout 24';
    faLayout25: result := 'Transitbar Layout 25';
    faLayout26: result := 'Transitbar Layout 26';
    faLayout27: result := 'Transitbar Layout 27';
    faLayout28: result := 'Transitbar Layout 28';
    faLayout29: result := 'Transitbar Layout 29';

    { Layout3 }
    faLayout30: result := 'Transitbar Layout 30';
    faLayout31: result := 'Transitbar Layout 31';
    faLayout32: result := 'Transitbar Layout 32';
    faLayout33: result := 'Transitbar Layout 33';
    faLayout34: result := 'Transitbar Layout 34';
    faLayout35: result := 'Transitbar Layout 35';
    faLayout36: result := 'Transitbar Layout 36';
    faLayout37: result := 'Transitbar Layout 37';
    faLayout38: result := 'Transitbar Layout 38';
    faLayout39: result := 'Transitbar Layout 39';

    { Layout4 }
    faLayout40: result := 'Transitbar Layout 40';
    faLayout41: result := 'Transitbar Layout 41';
    faLayout42: result := 'Transitbar Layout 42';
    faLayout43: result := 'Transitbar Layout 43';
    faLayout44: result := 'Transitbar Layout 44';
    faLayout45: result := 'Transitbar Layout 45';
    faLayout46: result := 'Transitbar Layout 46';
    faLayout47: result := 'Transitbar Layout 47';
    faLayout48: result := 'Transitbar Layout 48';
    faLayout49: result := 'Transitbar Layout 49';

    { Layout5 }
    faLayout50: result := 'Transitbar Layout 50';
    faLayout51: result := 'Transitbar Layout 51';
    faLayout52: result := 'Transitbar Layout 52';
    faLayout53: result := 'Transitbar Layout 53';
    faLayout54: result := 'Transitbar Layout 54';
    faLayout55: result := 'Transitbar Layout 55';
    faLayout56: result := 'Transitbar Layout 56';
    faLayout57: result := 'Transitbar Layout 57';
    faLayout58: result := 'Transitbar Layout 58';
    faLayout59: result := 'Transitbar Layout 59';

    { Layout6 }
    faLayout60: result := 'Transitbar Layout 60';
    faLayout61: result := 'Transitbar Layout 61';
    faLayout62: result := 'Transitbar Layout 62';
    faLayout63: result := 'Transitbar Layout 63';
    faLayout64: result := 'Transitbar Layout 64';
    faLayout65: result := 'Transitbar Layout 65';
    faLayout66: result := 'Transitbar Layout 66';
    faLayout67: result := 'Transitbar Layout 67';
    faLayout68: result := 'Transitbar Layout 68';
    faLayout69: result := 'Transitbar Layout 69';

    { Layout7 }
    faLayout70: result := 'Transitbar Layout 70';
    faLayout71: result := 'Transitbar Layout 71';
    faLayout72: result := 'Transitbar Layout 72';
    faLayout73: result := 'Transitbar Layout 73';
    faLayout74: result := 'Transitbar Layout 74';
    faLayout75: result := 'Transitbar Layout 75';
    faLayout76: result := 'Transitbar Layout 76';
    faLayout77: result := 'Transitbar Layout 77';
    faLayout78: result := 'Transitbar Layout 78';
    faLayout79: result := 'Transitbar Layout 79';

    { Layout8 }
    faLayout80: result := 'Transitbar Layout 80';
    faLayout81: result := 'Transitbar Layout 81';
    faLayout82: result := 'Transitbar Layout 82';
    faLayout83: result := 'Transitbar Layout 83';
    faLayout84: result := 'Transitbar Layout 84';
    faLayout85: result := 'Transitbar Layout 85';
    faLayout86: result := 'Transitbar Layout 86';
    faLayout87: result := 'Transitbar Layout 87';
    faLayout88: result := 'Transitbar Layout 88';
    faLayout89: result := 'Transitbar Layout 89';

    { Layout9 }
    faLayout90: result := 'Transitbar Layout 90';
    faLayout91: result := 'Transitbar Layout 91';
    faLayout92: result := 'Transitbar Layout 92';
    faLayout93: result := 'Transitbar Layout 93';
    faLayout94: result := 'Transitbar Layout 94';
    faLayout95: result := 'Transitbar Layout 95';
    faLayout96: result := 'Transitbar Layout 96';
    faLayout97: result := 'Transitbar Layout 97';
    faLayout98: result := 'Transitbar Layout 98';
    faLayout99: result := 'Transitbar Layout 99';

    { MenuNav }
    faMenuXX: result := 'Menubar Layout XX';
    faMenu00: result := 'Menubar Layout 00';
    faMenu10: result := 'Menubar Layout 10';
    faMenu20: result := 'Menubar Layout 20';
    faMenu30: result := 'Menubar Layout 30';
    faMenu40: result := 'Menubar Layout 40';
    faMenu50: result := 'Menubar Layout 50';
    faMenu60: result := 'Menubar Layout 60';
    faMenu70: result := 'Menubar Layout 70';
    faMenu80: result := 'Menubar Layout 80';
    faMenu90: result := 'Menubar Layout 90';

    { FigureSize }
    faFigureSizeXS: result := 'Figure Size XS';
    faFigureSizeS: result := 'Figure Size S';
    faFigureSizeM: result := 'Figure Size M';
    faFigureSizeL: result := 'Figure Size L';
    faFigureSizeXL: result := 'Figure Size XL';

    { EyeSize }
    faEyeSizeS: result := 'Select Eye Size S';
    faEyeSizeM: result := 'Select Eye Size M';
    faEyeSizeL: result := 'Select Eye Size L';

    { LayerSelection }
    faSelectLayer1: result := 'Select Layer 1';
    faSelectLayer2: result := 'Select Layer 2';
    faSelectLayer3: result := 'Select Layer 3';
    faSelectLayer4: result := 'Select Layer 4';
    faSelectLayer5: result := 'Select Layer 5';
    faSelectLayer6: result := 'Select Layer 6';
    faSelectLayer7: result := 'Select Layer 7';

    { ColorSelection }
    faSelectColor1: result := 'Select Color 1';
    faSelectColor2: result := 'Select Color 2';
    faSelectColor3: result := 'Select Color 3';
    faSelectColor4: result := 'Select Color 4';

    { ColorMapping }
    faCLA: result := 'Apply Color';
    faMapColorToLayer: result := 'Assign Color To Layer';
    faSelectColorMapping1: result := 'Select Color Mapping 1';
    faSelectColorMapping2: result := 'Select Color Mapping 2';
    faSelectColorMapping3: result := 'Select Color Mapping 3';
    faSelectColorMapping4: result := 'Select Color Mapping 4';
    faSelectColorMapping5: result := 'Select Color Mapping 5';
    faSelectColorMapping6: result := 'Select Color Mapping 6';
  end;
end;

end.
