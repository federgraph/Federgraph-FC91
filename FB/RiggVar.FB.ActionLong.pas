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
    faShowMemo: result := 'Form Memo';
    faShowActions: result := 'Form Actions';
    faShowInfo: result := 'Form Info';

    { TouchLayout }
    faTouchTablet: result := 'Touch Tablet';
    faTouchPhone: result := 'Touch Phone';
    faTouchDesk: result := 'Touch Desk';

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

    { MeshExport }
    faWantBottom: result := 'Want Bottom';
    faWantBottomMirrored: result := 'Want Bottom Mirrored';
    faWantSideCaps: result := 'Want Side Caps';
    faTestSingleSide: result := 'Test SingleSide rendering';

    { MeshExportCoords }
    faExportCoordsNative: result := 'ExportCoords Native';
    faExportCoordsBlender: result := 'ExportCoords Blender';
    faExportCoords3DV: result := 'ExportCoords 3DV';
    faExportCoords3DP: result := 'ExportCoords 3DP';

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

    { MeshBuilderOptions }
    faToggleSolidFlip: result := 'Toggle SolidFlip';
    faWantSpecialY: result := 'Want Special Y';
    faToggleShowEdges: result := 'Toggle ShowEdges';
    faUniqueMode1: result := 'Unique Mode 1';
    faUniqueMode2: result := 'Unique Mode 2';
    faToggleUniqueVertices: result := 'Toggle UniqueVertices';

    { ColorSwat }
    faToggleColorSwat: result := 'Color Swat';

    { Lux }
    faToggleLux: result := 'Light';

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
    faWheelFrequency01: result := 'Wheel Frequency 0.1';
    faWheelFrequency001: result := 'Wheel Frequency 0.01';

    { ColorScheme }
    faCycleColorSchemeM: result := 'cycle color scheme -';
    faCycleColorSchemeP: result := 'cycle color scheme +';

    { UI }
    faToggleColorPanel: result := 'Color Panel';
    faColorPanelOn: result := 'Toggle Color Panel On';
    faColorPanelOff: result := 'Toggle Color Panel Off';

    { FederText }
    faToggleAllText: result := 'Toggle All Text';
    faToggleTouchFrame: result := 'Toggle Touch Frame';

    { ViewParams }
    faPan: result := 'Pan';
    faParamRX: result := 'Model Rotation X';
    faParamRY: result := 'Model Rotation Y';
    faParamRZ: result := 'Model Rotation Z';
    faParamCZ: result := 'Camera Position Z';

    { ParamT }
    faParamT1: result := 'Param T1';
    faParamT2: result := 'Param T2';
    faParamT3: result := 'Param T3';
    faParamT4: result := 'Param T4';

    { ViewFlags }
    faToggleTouchMenu: result := 'Toggle Touch Menu';
    faToggleEquationText: result := 'Equation text visibility';
    faTogglePrimeText: result := 'Primary text visibility';
    faToggleSecondText: result := 'Secondary text visibility';
    faToggleLabelText: result := 'Label text visibility';
    faLabelBatchM: result := 'cycle label batch -';
    faLabelBatchP: result := 'cycle label batch +';
    faLabelTextP: result := 'LabelText plus';
    faLabelTextM: result := 'LabelText minus';

    { Bahn }
    faNorthCap: result := 'Param North Cap Value';
    faSouthCap: result := 'Param South Cap Value';
    faParamCapValue: result := 'Param Cap Value';

    { SampleNavigation }
    faGotoSample1: result := 'Goto Sample 1';

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

    { BitmapCycle }
    faCycleBitmapM: result := 'cycle bitmap -';
    faCycleBitmapP: result := 'cycle bitmap +';
    faRandom: result := 'Random Param Values';
    faRandomWhite: result := 'random colors white rings';
    faRandomBlack: result := 'random colors black rings';
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

    { ColorMapping }
    faCLA: result := 'Apply Color';
  end;
end;

end.
