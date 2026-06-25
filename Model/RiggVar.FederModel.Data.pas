unit RiggVar.FederModel.Data;

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
  System.SysUtils,
  System.Classes,
  System.Types,
  System.UITypes,
  System.UIConsts,
  RiggVar.FB.Action,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Classes,
  RiggVar.FB.Data;

type
  TFederData1 = class(TFederData)
  public
    procedure LoadNative(ML: TStrings); override;
    procedure LoadNativeBin(ML: TStrings); override;
    procedure SaveCode(ML: TStrings); override;
    procedure SaveDiffBin(fd: TFederData; ML: TStrings); override;
    procedure SaveDiffCode(fd: TFederData; ML: TStrings); override;
    procedure SaveNative(ML: TStrings); override;
    procedure ShowVersion1Diff(fd: TFederData; ML: TStrings); override;
    procedure WriteVersion1Diff(fd: TFederData; ML: TStrings); override;
  end;

  TFederData2 = class(TFederData1)
  protected
    sVersion: string;

    sx1, sx2, sx3, sx4: string;
    sy1, sy2, sy3, sy4: string;
    sz1, sz2, sz3, sz4: string;
    sl1, sl2, sl3, sl4: string;
    sk1, sk2, sk3, sk4: string;
    sm1, sm2, sm3, sm4: string;

    sDim: string;
    sDrawFigure: string;

    sScene: string;
    sGraph: string;
    sPlot: string;
    sFigure: string;
    sBitmap: string;
    sColor: string;

    sOffsetX: string;
    sOffsetY: string;
    sOffsetZ: string;

    sMeshSize: string;
    sGain: string;
    sLimit: string;
    sCapValue: string;
    sRange: string;
    sAbsoluteRange: string;
    sParam: string;

    sMinusCap: string;
    sPlusCap: string;
    sOpacity: string;
    sBigmap: string;
    sPin: string;
    sNorm: string;
    sTextureNorm: string;

    sAngleX: string;
    sAngleY: string;
    sAngleZ: string;
    sPosX: string;
    sPosY: string;
    sPosZ: string;
    sPosZ1: string;
    sPosZ2: string;

    sT1: string;
    sT2: string;
    sT3: string;
    sT4: string;

    sForceMode: string;
    sSolutionMode: string;
    sPlotFigure: string;
    sVorzeichen: string;
    sGleich: string;
    sLinearForce: string;
    sSliceMode: string;

    sOpenMesh: string;
    sPolarMesh: string;
    sLinearMesh: string;
    sFuzzyMesh: string;
    sReducedMesh: string;

    sIV: string;
    sIW: string;
    sJV: string;
    sJW: string;

    sParamBahnRadius: string;
    sParamBahnPositionX: string;
    sParamBahnPositionY: string;
    sParamBahnAngle: string;
    sParamBahnStrokeWidth1: string;
    sParamBahnStrokeWidth2: string;
    sParamBahnCylinderF: string;
    sParamBahnCylinderD: string;
    sParamBahnCylinderZ: string;

    sShowGrid: string;
    sShowKugel: string;
    sShowCylinder: string;
    sShowDiameter: string;
    sShowLB: string;
    sShowLL: string;
    sShowLC1: string;
    sShowLC2: string;

    sNullpunktX: string;
    sNullpunktY: string;
    sPaintboxZoom: string;
    sPaintboxRotation: string;

    sColorScheme2D: string;
    sColorScheme3D: string;

    sLux: string;

    sLux1: string;
    sLux1X: string;
    sLux1Y: string;
    sLux1Z: string;

    sLux2: string;
    sLux2X: string;
    sLux2Y: string;
    sLux2Z: string;

    sLux3: string;
    sLux3X: string;
    sLux3Y: string;
    sLux3Z: string;

    sLux4: string;
    sLux4X: string;
    sLux4Y: string;
    sLux4Z: string;
  public
    constructor Create;
    procedure LoadVirtual(ML: TStrings); override;
    procedure SaveVirtual(ML: TStrings); override;
    function ReadParamValue(s: string): Integer;
  end;

  TFederData3 = class(TFederData2)
  public
    procedure LoadVirtual(ML: TStrings); override;
  end;

implementation

uses
  RiggVar.App.Main;

const
  fs_F = '%2.2f';
  fs_G = '%.2g';
  fs_D = '%d';

procedure TFederData1.WriteVersion1Diff(fd: TFederData; ML: TStrings);
begin
  ML.Add('version=1');

  if x1 <> fd.x1 then
    FormatLine(ML, 'x1', Format(fs_G, [x1]));
  if x2 <> fd.x2 then
    FormatLine(ML, 'x2', Format(fs_G, [x2]));
  if x3 <> fd.x3 then
    FormatLine(ML, 'x3', Format(fs_G, [x3]));
  if x4 <> fd.x4 then
    FormatLine(ML, 'x4', Format(fs_G, [x4]));

  if y1 <> fd.y1 then
    FormatLine(ML, 'y1', Format(fs_G, [y1]));
  if y2 <> fd.y2 then
    FormatLine(ML, 'y2', Format(fs_G, [y2]));
  if y3 <> fd.y3 then
    FormatLine(ML, 'y3', Format(fs_G, [y3]));
  if y4 <> fd.y4 then
    FormatLine(ML, 'y4', Format(fs_G, [y4]));

  if z1 <> fd.z1 then
    FormatLine(ML, 'z1', Format(fs_G, [z1]));
  if z2 <> fd.z2 then
    FormatLine(ML, 'z2', Format(fs_G, [z2]));
  if z3 <> fd.z3 then
    FormatLine(ML, 'z3', Format(fs_G, [z3]));
  if z4 <> fd.z4 then
    FormatLine(ML, 'z4', Format(fs_G, [z4]));

  if l1 <> fd.l1 then
    FormatLine(ML, 'l1', Format(fs_G, [l1]));
  if l2 <> fd.l2 then
    FormatLine(ML, 'l2', Format(fs_G, [l2]));
  if l3 <> fd.l3 then
    FormatLine(ML, 'l3', Format(fs_G, [l3]));
  if l4 <> fd.l4 then
    FormatLine(ML, 'l4', Format(fs_G, [l4]));

  if k1 <> fd.k1 then
    FormatLine(ML, 'k1', Format(fs_G, [k1]));
  if k2 <> fd.k2 then
    FormatLine(ML, 'k2', Format(fs_G, [k2]));
  if k3 <> fd.k3 then
    FormatLine(ML, 'k3', Format(fs_G, [k3]));
  if k4 <> fd.k4 then
    FormatLine(ML, 'k4', Format(fs_G, [k4]));

  if m1 <> fd.m1 then
    FormatLine(ML, 'm1', Format(fs_D, [m1]));
  if m2 <> fd.m2 then
    FormatLine(ML, 'm2', Format(fs_D, [m2]));
  if m3 <> fd.m3 then
    FormatLine(ML, 'm3', Format(fs_D, [m3]));
  if m4 <> fd.m4 then
    FormatLine(ML, 'm4', Format(fs_D, [m4]));

  if OffsetX <> fd.OffsetX then
    FormatLine(ML, 'OffsetX', Format(fs_D, [OffsetX]));
  if OffsetY <> fd.OffsetY then
    FormatLine(ML, 'OffsetY', Format(fs_D, [OffsetY]));
  if OffsetZ <> fd.OffsetZ then
    FormatLine(ML, 'OffsetZ', Format(fs_D, [OffsetZ]));

  if MinusCap <> fd.MinusCap then
    FormatLine(ML, 'MinusCap', Format(fs_D, [BoolInt[MinusCap]]));
  if Opacity <> fd.Opacity then
    FormatLine(ML, 'Opacity', Format(fs_D, [BoolInt[Opacity]]));
  if Bigmap <> fd.Bigmap then
    FormatLine(ML, 'Bigmap', Format(fs_D, [BoolInt[Bigmap]]));
  if Pin <> fd.Pin then
    FormatLine(ML, 'Pin', Format(fs_D, [BoolInt[Pin]]));
  if Norm <> fd.Norm then
    FormatLine(ML, 'Norm', Format(fs_D, [BoolInt[Norm]]));
  if TextureNorm <> fd.TextureNorm then
    FormatLine(ML, 'TextureNorm', Format(fs_D, [TextureNorm]));

  if MeshSize <> fd.MeshSize then
    FormatLine(ML, 'MeshSize', Format(fs_D, [MeshSize]));
  if Gain <> fd.Gain then
    FormatLine(ML, 'Gain', Format(fs_D, [Gain]));
  if CapValue <> fd.CapValue then
    FormatLine(ML, 'CapValue', Format(fs_D, [CapValue]));
  if AbsoluteRange <> fd.AbsoluteRange then
    FormatLine(ML, 'AbsoluteRange', Format(fs_D, [AbsoluteRange]));
  if ReducedMesh <> fd.ReducedMesh then
    FormatLine(ML, 'ReducedMesh', Format(fs_D, [BoolInt[ReducedMesh]]));
  if PlusCap <> fd.PlusCap then
    FormatLine(ML, 'PlusCap', Format(fs_D, [BoolInt[PlusCap]]));

  if Dim <> fd.Dim then
    FormatLine(ML, 'Dim', Format(fs_D, [Dim]));
  if DrawFigure <> fd.DrawFigure then
    FormatLine(ML, 'DrawFigure', Format(fs_D, [DrawFigure]));

  if Scene <> fd.Scene then
    FormatLine(ML, 'Scene', Format(fs_D, [Scene]));
  if Graph <> fd.Graph then
    FormatLine(ML, 'Graph', Format(fs_D, [Graph]));
  if Plot <> fd.Plot then
    FormatLine(ML, 'Plot', Format(fs_D, [Plot]));
  if Figure <> fd.Figure then
    FormatLine(ML, 'Figure', Format(fs_D, [Figure]));
  if Bitmap <> fd.Bitmap then
    FormatLine(ML, 'Bitmap', Format(fs_D, [Bitmap]));
  if Param <> Param then
    FormatLine(ML, 'Param', Format(fs_D, [Param]));

  if Color <> fd.Color then
    FormatLine(ML, 'Color', Format(fs_D, [Color]));

  if AngleX <> fd.AngleX then
  begin
    FormatLine(ML, 'AngleX', Format(fs_F, [WrapAngleX]));
  end;
  if AngleY <> fd.AngleY then
  begin
    FormatLine(ML, 'AngleY', Format(fs_F, [WrapAngleY]));
  end;
  if AngleZ <> fd.AngleZ then
  begin
    FormatLine(ML, 'AngleZ', Format(fs_F, [WrapAngleZ]));
  end;
  if PosX <> fd.PosX then
    FormatLine(ML, 'PosX', Format(fs_F, [PosX]));
  if PosY <> fd.PosY then
    FormatLine(ML, 'PosY', Format(fs_F, [PosY]));
  if PosZ <> fd.PosZ then
    FormatLine(ML, 'PosZ', Format(fs_F, [PosZ]));

  if T1 <> fd.T1 then
    FormatLine(ML, 'T1', Format(fs_D, [T1]));
  if T2 <> fd.T2 then
    FormatLine(ML, 'T2', Format(fs_D, [T2]));
  if T3 <> fd.T3 then
    FormatLine(ML, 'T3', Format(fs_D, [T3]));
  if T4 <> fd.T4 then
    FormatLine(ML, 'T4', Format(fs_D, [T4]));

  if ForceMode <> fd.ForceMode then
    FormatLine(ML, 'ForceMode', Format(fs_D, [ForceMode]));
  if SolutionMode <> fd.SolutionMode then
    FormatLine(ML, cSolutionMode, Format(fs_D, [BoolInt[SolutionMode]]));
  if PlotFigure <> fd.PlotFigure then
    FormatLine(ML, 'PlotFigure', Format(fs_D, [PlotFigure]));
  if Vorzeichen <> fd.Vorzeichen then
    FormatLine(ML, 'Vorzeichen', Format(fs_D, [BoolInt[Vorzeichen]]));
  if Gleich <> fd.Gleich then
    FormatLine(ML, cGleich, Format(fs_D, [BoolInt[Gleich]]));
  if LinearForce <> fd.LinearForce then
    FormatLine(ML, cLinearForce, Format(fs_D, [BoolInt[LinearForce]]));
  if SliceMode <> fd.SliceMode then
    FormatLine(ML, 'SliceMode', Format(fs_D, [SliceMode]));

  if OpenMesh <> fd.OpenMesh then
    FormatLine(ML, 'OpenMesh', Format(fs_D, [BoolInt[OpenMesh]]));
  if PolarMesh <> fd.PolarMesh then
    FormatLine(ML, 'PolarMesh', Format(fs_D, [BoolInt[PolarMesh]]));
  if LinearMesh <> fd.LinearMesh then
    FormatLine(ML, 'LinearMesh', Format(fs_D, [BoolInt[LinearMesh]]));
  if FuzzyMesh <> fd.FuzzyMesh then
    FormatLine(ML, 'FuzzyMesh', Format(fs_D, [BoolInt[FuzzyMesh]]));

  if IV <> fd.IV then
    FormatLine(ML, 'IV', Format(fs_F, [IV]));
  if IW <> fd.IW then
    FormatLine(ML, 'IW', Format(fs_F, [IW]));
  if JV <> fd.JV then
    FormatLine(ML, 'JV', Format(fs_F, [JV]));
  if JW <> fd.JW then
    FormatLine(ML, 'JW', Format(fs_F, [JW]));

  if ParamBahnRadius <> fd.ParamBahnRadius then
    FormatLine(ML, cParamBahnRadius, Format(fs_F, [ParamBahnRadius]));
  if ParamBahnPositionX <> fd.ParamBahnPositionX then
    FormatLine(ML, cParamBahnPositionX, Format(fs_F, [ParamBahnPositionX]));
  if ParamBahnPositionY <> fd.ParamBahnPositionY then
    FormatLine(ML, cParamBahnPositionY, Format(fs_F, [ParamBahnPositionY]));
  if ParamBahnAngle <> fd.ParamBahnAngle then
    FormatLine(ML, cParamBahnAngle, Format(fs_F, [ParamBahnAngle]));

  if ParamBahnCylinderF <> fd.ParamBahnCylinderF then
    FormatLine(ML, cParamBahnCylinderF, Format(fs_F, [ParamBahnCylinderF]));
  if ParamBahnCylinderD <> fd.ParamBahnCylinderD then
    FormatLine(ML, cParamBahnCylinderD, Format(fs_D, [ParamBahnCylinderD]));
  if ParamBahnCylinderZ <> fd.ParamBahnCylinderZ then
    FormatLine(ML, cParamBahnCylinderZ, Format(fs_D, [ParamBahnCylinderZ]));

  if ShowGrid then
    FormatLine(ML, cShowGrid, Format(fs_D, [BoolInt[ShowGrid]]));
  if ShowKugel then
    FormatLine(ML, cShowKugel, Format(fs_D, [BoolInt[ShowKugel]]));
  if not ShowCylinder then
    FormatLine(ML, cShowCylinder, Format(fs_D, [BoolInt[ShowCylinder]]));
  if not ShowDiameter then
    FormatLine(ML, cShowDiameter, Format(fs_D, [BoolInt[ShowDiameter]]));
  if ColorScheme3D <> fd.ColorScheme3D then
    FormatLine(ML, cColorScheme3D, Format(fs_D, [ColorScheme3D]));

  if Want2D then
  begin
    if not ShowLB then
      FormatLine(ML, cShowLB, Format(fs_D, [BoolInt[ShowLB]]));
    if not ShowLL then
      FormatLine(ML, cShowLL, Format(fs_D, [BoolInt[ShowLL]]));
    if not ShowLC1 then
      FormatLine(ML, cShowLC1, Format(fs_D, [BoolInt[ShowLC1]]));
    if not ShowLC2 then
      FormatLine(ML, cShowLC2, Format(fs_D, [BoolInt[ShowLC2]]));

    if NullpunktX <> fd.NullpunktX then
      FormatLine(ML, cNullpunktX, Format(fs_F, [NullpunktX]));
    if NullpunktY <> fd.NullpunktY then
      FormatLine(ML, cNullpunktY, Format(fs_F, [NullpunktY]));
    if PaintboxZoom <> fd.PaintboxZoom then
      FormatLine(ML, cPaintboxZoom, Format(fs_F, [PaintboxZoom]));
    if PaintboxRotation <> fd.PaintboxRotation then
      FormatLine(ML, cPaintboxRotation, Format(fs_F, [PaintboxRotation]));

    if ColorScheme2D <> fd.ColorScheme2D then
      FormatLine(ML, cColorScheme2D, Format(fs_D, [ColorScheme2D]));
    if ParamBahnStrokeWidth1 <> fd.ParamBahnStrokeWidth1 then
      FormatLine(ML, cParamBahnStrokeWidth1, Format(fs_D, [ParamBahnStrokeWidth1]));
    if ParamBahnStrokeWidth2<> fd.ParamBahnStrokeWidth2 then
      FormatLine(ML, cParamBahnStrokeWidth2, Format(fs_D, [ParamBahnStrokeWidth2]));
  end;

  if Lux then
    FormatLine(ML, cLux, Format(fs_D, [BoolInt[Lux]]));

  if Lux1 then
    FormatLine(ML, cLux1, Format(fs_D, [BoolInt[Lux1]]));
  if Lux1X <> fd.Lux1X then
    FormatLine(ML, cLux1X, Format(fs_D, [Lux1X]));
  if Lux1Y <> fd.Lux1Y then
    FormatLine(ML, cLux1Y, Format(fs_D, [Lux1Y]));
  if Lux1Z <> fd.Lux1Z then
    FormatLine(ML, cLux1Z, Format(fs_D, [Lux1Z]));

  if Lux2 then
    FormatLine(ML, cLux2, Format(fs_D, [BoolInt[Lux2]]));
  if Lux2X <> fd.Lux2X then
    FormatLine(ML, cLux2X, Format(fs_D, [Lux2X]));
  if Lux2Y <> fd.Lux2Y then
    FormatLine(ML, cLux2Y, Format(fs_D, [Lux2Y]));
  if Lux2Z <> fd.Lux2Z then
    FormatLine(ML, cLux2Z, Format(fs_D, [Lux2Z]));

  if Lux3 then
    FormatLine(ML, cLux3, Format(fs_D, [BoolInt[Lux3]]));
  if Lux3X <> fd.Lux3X then
    FormatLine(ML, cLux3X, Format(fs_D, [Lux3X]));
  if Lux3Y <> fd.Lux3Y then
    FormatLine(ML, cLux3Y, Format(fs_D, [Lux3Y]));
  if Lux3Z <> fd.Lux3Z then
    FormatLine(ML, cLux3Z, Format(fs_D, [Lux3Z]));

  if Lux4 then
    FormatLine(ML, cLux4, Format(fs_D, [BoolInt[Lux4]]));
  if Lux4X <> fd.Lux4X then
    FormatLine(ML, cLux4X, Format(fs_D, [Lux4X]));
  if Lux4Y <> fd.Lux4Y then
    FormatLine(ML, cLux4Y, Format(fs_D, [Lux4Y]));
  if Lux4Z <> fd.Lux4Z then
    FormatLine(ML, cLux4Z, Format(fs_D, [Lux4Z]));

end;

procedure TFederData1.ShowVersion1Diff(fd: TFederData; ML: TStrings);
begin
  if x1 <> fd.x1 then
    FormatDiff(ML, Format('x1;%.2g;%.2g', [x1,fd.x1]));
  if x2 <> fd.x2 then
    FormatDiff(ML, Format('x2;%.2g;%.2g', [x2,fd.x2]));
  if x3 <> fd.x3 then
    FormatDiff(ML, Format('x3;%.2g;%.2g', [x3,fd.x3]));
  if x4 <> fd.x4 then
    FormatDiff(ML, Format('x4;%.2g;%.2g', [x4,fd.x4]));

  if y1 <> fd.y1 then
    FormatDiff(ML, Format('y1;%.2g;%.2g', [y1,fd.y1]));
  if y2 <> fd.y2 then
    FormatDiff(ML, Format('y2;%.2g;%.2g', [y2,fd.y2]));
  if y3 <> fd.y3 then
    FormatDiff(ML, Format('y3;%.2g;%.2g', [y3,fd.y3]));
  if y4 <> fd.y4 then
    FormatDiff(ML, Format('y4;%.2g;%.2g', [y4,fd.y4]));

  if z1 <> fd.z1 then
    FormatDiff(ML, Format('z1;%.2g;%.2g', [z1,fd.z1]));
  if z2 <> fd.z2 then
    FormatDiff(ML, Format('z2;%.2g;%.2g', [z2,fd.z2]));
  if z3 <> fd.z3 then
    FormatDiff(ML, Format('z3;%.2g;%.2g', [z3,fd.z3]));
  if z4 <> fd.z4 then
    FormatDiff(ML, Format('z4;%.2g;%.2g', [z4,fd.z4]));

  if l1 <> fd.l1 then
    FormatDiff(ML, Format('l1;%.2g;%.2g', [l1,fd.l1]));
  if l2 <> fd.l2 then
    FormatDiff(ML, Format('l2;%.2g;%.2g', [l2,fd.l2]));
  if l3 <> fd.l3 then
    FormatDiff(ML, Format('l3;%.2g;%.2g', [l3,fd.l3]));
  if l4 <> fd.l4 then
    FormatDiff(ML, Format('l4;%.2g;%.2g', [l4,fd.l4]));

  if k1 <> fd.k1 then
    FormatDiff(ML, Format('k1;%.2g;%.2g', [k1,fd.k1]));
  if k2 <> fd.k2 then
    FormatDiff(ML, Format('k2;%.2g;%.2g', [k2,fd.k2]));
  if k3 <> fd.k3 then
    FormatDiff(ML, Format('k3;%.2g;%.2g', [k3,fd.k3]));
  if k4 <> fd.k4 then
    FormatDiff(ML, Format('k4;%.2g;%.2g', [k4,fd.k4]));

  if m1 <> fd.m1 then
    FormatDiff(ML, Format('m1;%d;%d', [m1,fd.m1]));
  if m2 <> fd.m2 then
    FormatDiff(ML, Format('m2;%d;%d', [m2,fd.m2]));
  if m3 <> fd.m3 then
    FormatDiff(ML, Format('m3;%d;%d', [m3,fd.m3]));
  if m4 <> fd.m4 then
    FormatDiff(ML, Format('m4;%d;%d', [m4,fd.m4]));

  if OffsetX <> fd.OffsetX then
    FormatDiff(ML, Format('OffsetX;%d;%d', [OffsetX,fd.OffsetX]));
  if OffsetY <> fd.OffsetY then
    FormatDiff(ML, Format('OffsetY;%d;%d', [OffsetY,fd.OffsetY]));
  if OffsetZ <> fd.OffsetZ then
    FormatDiff(ML, Format('OffsetZ;%d;%d', [OffsetZ,fd.OffsetZ]));

  if MinusCap <> fd.MinusCap then
    FormatDiff(ML, Format('MinusCap;%d;%d', [BoolInt[MinusCap],BoolInt[fd.MinusCap]]));
  if Opacity <> fd.Opacity then
    FormatDiff(ML, Format('Opacity;%d;%d', [BoolInt[Opacity],BoolInt[fd.Opacity]]));
  if Bigmap <> fd.Bigmap then
    FormatDiff(ML, Format('Bigmap;%d;%d', [BoolInt[Bigmap],BoolInt[fd.Bigmap]]));
  if Pin <> fd.Pin then
    FormatDiff(ML, Format('Pin;%d;%d', [BoolInt[Pin],BoolInt[fd.Pin]]));
  if Norm <> fd.Norm then
    FormatDiff(ML, Format('Norm;%d;%d', [BoolInt[Norm],BoolInt[fd.Norm]]));
  if TextureNorm <> fd.TextureNorm then
    FormatDiff(ML, Format('TextureNorm;%d;%d', [TextureNorm,fd.TextureNorm]));

  if MeshSize <> fd.MeshSize then
    FormatDiff(ML, Format('MeshSize;%d;%d', [MeshSize, fd.MeshSize]));
  if Gain <> fd.Gain then
    FormatDiff(ML, Format('Gain;%d;%d', [Gain, fd.Gain]));
  if CapValue <> fd.CapValue then
    FormatDiff(ML, Format('CapValue;%d;%d', [CapValue, fd.CapValue]));
  if AbsoluteRange <> fd.AbsoluteRange then
    FormatDiff(ML, Format('AbsoluteRange;%d;%d', [AbsoluteRange, fd.AbsoluteRange]));
  if ReducedMesh <> fd.ReducedMesh then
    FormatDiff(ML, Format('ReducedMesh;%d;%d', [BoolInt[ReducedMesh], BoolInt[fd.ReducedMesh]]));
  if PlusCap <> fd.PlusCap then
    FormatDiff(ML, Format('PlusCap;%d;%d', [BoolInt[PlusCap],BoolInt[fd.PlusCap]]));

  if Dim <> fd.Dim then
    FormatDiff(ML, Format('Dim;%d;%d', [Dim, fd.Dim]));
  if DrawFigure <> fd.DrawFigure then
    FormatDiff(ML, Format('DrawFigure;%d;%d', [DrawFigure, fd.DrawFigure]));

  if Scene <> fd.Scene then
    FormatDiff(ML, Format('Scene;%d;%d', [Scene, fd.Scene]));
  if Graph <> fd.Graph then
    FormatDiff(ML, Format('Graph;%d;%d', [Graph, fd.Graph]));
  if Plot <> fd.Plot then
    FormatDiff(ML, Format('Plot;%d;%d', [Plot, fd.Plot]));
  if Figure <> fd.Figure then
    FormatDiff(ML, Format('Figure;%d;%d', [Figure, fd.Figure]));
  if Bitmap <> fd.Bitmap then
    FormatDiff(ML, Format('Bitmap;%d;%d', [Bitmap, fd.Bitmap]));
  if Param <> fd.Param then
    FormatDiff(ML, Format('Param;%d;%d', [Param, fd.Param]));

  if Color <> fd.Color then
    FormatDiff(ML, Format('Color;%d;%d', [Color, fd.Color]));

  if AngleX <> fd.AngleX then
    FormatDiff(ML, Format('AngleX;%2.2f;%2.2f', [AngleX, fd.AngleX]));
  if AngleY <> fd.AngleY then
    FormatDiff(ML, Format('AngleY;%2.2f;%2.2f', [AngleY, fd.AngleY]));
  if AngleZ <> fd.AngleZ then
    FormatDiff(ML, Format('AngleZ;%2.2f;%2.2f', [AngleZ, fd.AngleZ]));
  if PosX <> fd.PosX then
    FormatDiff(ML, Format('PosX;%2.2f;%2.2f', [PosX, fd.PosX]));
  if PosY <> fd.PosY then
    FormatDiff(ML, Format('PosY;%2.2f;%2.2f', [PosY, fd.PosY]));
  if PosZ <> fd.PosZ then
    FormatDiff(ML, Format('PosZ;%2.2f;%2.2f', [PosZ, fd.PosZ]));

  if T1 <> fd.T1 then
    FormatDiff(ML, Format('T1;%d;%d', [T1, fd.T1]));
  if T2 <> fd.T2 then
    FormatDiff(ML, Format('T2;%d;%d', [T2, fd.T2]));
  if T3 <> fd.T3 then
    FormatDiff(ML, Format('T3;%d;%d', [T3, fd.T3]));
  if T4 <> fd.T4 then
    FormatDiff(ML, Format('T4;%d;%d', [T4, fd.T4]));

  if ForceMode <> fd.ForceMode then
    FormatDiff(ML, Format('ForceMode;%d;%d', [ForceMode, fd.ForceMode]));
  if SolutionMode <> fd.SolutionMode then
    FormatDiff(ML, Format('SolutionMode;%d;%d', [BoolInt[SolutionMode], BoolInt[fd.SolutionMode]]));
  if PlotFigure <> fd.PlotFigure then
    FormatDiff(ML, Format('PlotFigure;%d;%d', [PlotFigure, fd.PlotFigure]));
  if Vorzeichen <> fd.Vorzeichen then
    FormatDiff(ML, Format('Vorzeichen;%d;%d', [BoolInt[Vorzeichen], BoolInt[fd.Vorzeichen]]));
  if Gleich <> fd.Gleich then
    FormatDiff(ML, Format('Gleich;%d;%d', [BoolInt[Gleich], BoolInt[fd.Gleich]]));
  if LinearForce <> fd.LinearForce then
    FormatDiff(ML, Format('LinearForce;%d;%d', [BoolInt[LinearForce], BoolInt[fd.LinearForce]]));
  if SliceMode <> fd.SliceMode then
    FormatDiff(ML, Format('SliceMode;%d;%d', [SliceMode, fd.SliceMode]));

  if OpenMesh <> fd.OpenMesh then
    FormatDiff(ML, Format('OpenMesh;%d;%d', [BoolInt[OpenMesh], BoolInt[fd.OpenMesh]]));
  if PolarMesh <> fd.PolarMesh then
    FormatDiff(ML, Format('PolarMesh;%d;%d', [BoolInt[PolarMesh], BoolInt[fd.PolarMesh]]));
  if LinearMesh <> fd.LinearMesh then
    FormatDiff(ML, Format('LinearMesh;%d;%d', [BoolInt[LinearMesh], BoolInt[fd.LinearMesh]]));
  if FuzzyMesh <> fd.FuzzyMesh then
    FormatDiff(ML, Format('FuzzyMesh;%d;%d', [BoolInt[FuzzyMesh], BoolInt[fd.FuzzyMesh]]));

  if IV <> fd.IV then
    FormatDiff(ML, Format('IV;%2.2f;%2.2f', [IV, fd.IV]));
  if IW <> fd.IW then
    FormatDiff(ML, Format('IW;%2.2f;%2.2f', [IW, fd.IW]));
  if JV <> fd.JV then
    FormatDiff(ML, Format('JV;%2.2f;%2.2f', [JV, fd.JV]));
  if JW <> fd.JW then
    FormatDiff(ML, Format('JW;%2.2f;%2.2f', [JW, fd.JW]));

  if ParamBahnRadius <> fd.ParamBahnRadius then
    FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cParamBahnRadius, ParamBahnRadius, fd.ParamBahnRadius]));
  if ParamBahnPositionX <> fd.ParamBahnPositionX then
    FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cParamBahnPositionX, ParamBahnPositionX, fd.ParamBahnPositionX]));
  if ParamBahnPositionY <> fd.ParamBahnPositionY then
    FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cParamBahnPositionY, ParamBahnPositionY, fd.ParamBahnPositionY]));
  if ParamBahnAngle <> fd.ParamBahnAngle then
    FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cParamBahnAngle, ParamBahnAngle, fd.ParamBahnAngle]));

  if ParamBahnCylinderF <> fd.ParamBahnCylinderF then
    FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cParamBahnCylinderF, ParamBahnCylinderF, fd.ParamBahnCylinderF]));
  if ParamBahnCylinderD <> fd.ParamBahnCylinderD then
    FormatDiff(ML, Format('%s;%d;%d', [cParamBahnCylinderD, ParamBahnCylinderD, fd.ParamBahnCylinderD]));
  if ParamBahnCylinderZ <> fd.ParamBahnCylinderZ then
    FormatDiff(ML, Format('%s;%d;%d', [cParamBahnCylinderZ, ParamBahnCylinderZ, fd.ParamBahnCylinderZ]));

  if ShowGrid then
    FormatDiff(ML, Format('%s;%d;%d', [cShowGrid, BoolInt[ShowGrid], BoolInt[fd.ShowGrid]]));
  if ShowKugel then
    FormatDiff(ML, Format('%s;%d;%d', [cShowKugel, BoolInt[ShowKugel], BoolInt[fd.ShowKugel]]));
  if not ShowCylinder then
    FormatDiff(ML, Format('%s;%d;%d', [cShowCylinder, BoolInt[ShowCylinder], BoolInt[fd.ShowCylinder]]));
  if not ShowDiameter then
    FormatDiff(ML, Format('%s;%d;%d', [cShowDiameter, BoolInt[ShowDiameter], BoolInt[fd.ShowDiameter]]));

  if ColorScheme3D <> fd.ColorScheme3D then
    FormatDiff(ML, Format('%s;%d;%d', [cColorScheme3D, ColorScheme3D, fd.ColorScheme3D]));

  if Want2D then
  begin
    if not ShowLB then
      FormatDiff(ML, Format('%s;%d;%d', [cShowLB, BoolInt[ShowLB], BoolInt[fd.ShowLB]]));
    if not ShowLL then
      FormatDiff(ML, Format('%s;%d;%d', [cShowLL, BoolInt[ShowLL], BoolInt[fd.ShowLL]]));
    if not ShowLC1 then
      FormatDiff(ML, Format('%s;%d;%d', [cShowLC1, BoolInt[ShowLC1], BoolInt[fd.ShowLC1]]));
    if not ShowLC2 then
      FormatDiff(ML, Format('%s;%d;%d', [cShowLC2, BoolInt[ShowLC2], BoolInt[fd.ShowLC2]]));

    if NullpunktX <> fd.NullpunktX then
      FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cNullpunktX, NullpunktX, fd.NullpunktX]));
    if NullpunktY <> fd.NullpunktY then
      FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cNullpunktY, NullpunktY, fd.NullpunktY]));
    if PaintboxZoom <> fd.PaintboxZoom then
      FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cPaintboxZoom, PaintboxZoom, fd.PaintboxZoom]));
    if PaintboxRotation <> fd.PaintboxRotation then
      FormatDiff(ML, Format('%s;%2.2f;%2.2f', [cPaintboxRotation, PaintboxRotation, fd.PaintboxRotation]));

    if ColorScheme2D <> fd.ColorScheme2D then
      FormatDiff(ML, Format('%s;%d;%d', [cColorScheme2D, ColorScheme2D, fd.ColorScheme2D]));
    if ParamBahnStrokeWidth1 <> fd.ParamBahnStrokeWidth1 then
      FormatDiff(ML, Format('%s;%d;%d', [cParamBahnStrokeWidth1, ParamBahnStrokeWidth1, fd.ParamBahnStrokeWidth1]));
    if ParamBahnStrokeWidth2 <> fd.ParamBahnStrokeWidth2 then
      FormatDiff(ML, Format('%s;%d;%d', [cParamBahnStrokeWidth2, ParamBahnStrokeWidth2, fd.ParamBahnStrokeWidth2]));
  end;

  if Lux then
    FormatDiff(ML, Format('%s;%d;%d', [cLux, BoolInt[Lux], BoolInt[fd.Lux]]));

  if Lux1 then
    FormatDiff(ML, Format('%s;%d;%d', [cLux1, BoolInt[Lux1], BoolInt[fd.Lux1]]));
  if Lux1X <> fd.Lux1X then
    FormatDiff(ML, Format('%s;%d;%d', [cLux1X, Lux1X, fd.Lux1X]));
  if Lux1Y <> fd.Lux1Y then
    FormatDiff(ML, Format('%s;%d;%d', [cLux1Y, Lux1Y, fd.Lux1Y]));
  if Lux1Z <> fd.Lux1Z then
    FormatDiff(ML, Format('%s;%d;%d', [cLux1Z, Lux1Z, fd.Lux1Z]));

  if Lux2 then
    FormatDiff(ML, Format('%s;%d;%d', [cLux2, BoolInt[Lux2], BoolInt[fd.Lux2]]));
  if Lux2X <> fd.Lux2X then
    FormatDiff(ML, Format('%s;%d;%d', [cLux2X, Lux2X, fd.Lux2X]));
  if Lux2Y <> fd.Lux2Y then
    FormatDiff(ML, Format('%s;%d;%d', [cLux2Y, Lux2Y, fd.Lux2Y]));
  if Lux2Z <> fd.Lux2Z then
    FormatDiff(ML, Format('%s;%d;%d', [cLux2Z, Lux2Z, fd.Lux2Z]));

  if Lux3 then
    FormatDiff(ML, Format('%s;%d;%d', [cLux3, BoolInt[Lux3], BoolInt[fd.Lux3]]));
  if Lux3X <> fd.Lux3X then
    FormatDiff(ML, Format('%s;%d;%d', [cLux3X, Lux3X, fd.Lux3X]));
  if Lux3Y <> fd.Lux3Y then
    FormatDiff(ML, Format('%s;%d;%d', [cLux3Y, Lux3Y, fd.Lux3Y]));
  if Lux3Z <> fd.Lux3Z then
    FormatDiff(ML, Format('%s;%d;%d', [cLux3Z, Lux3Z, fd.Lux3Z]));

  if Lux4 then
    FormatDiff(ML, Format('%s;%d;%d', [cLux4, BoolInt[Lux4], BoolInt[fd.Lux4]]));
  if Lux4X <> fd.Lux4X then
    FormatDiff(ML, Format('%s;%d;%d', [cLux4X, Lux4X, fd.Lux4X]));
  if Lux4Y <> fd.Lux4Y then
    FormatDiff(ML, Format('%s;%d;%d', [cLux4Y, Lux4Y, fd.Lux4Y]));
  if Lux4Z <> fd.Lux4Z then
    FormatDiff(ML, Format('%s;%d;%d', [cLux4Z, Lux4Z, fd.Lux4Z]));
end;

procedure TFederData1.SaveNative(ML: TStrings);
begin
  ML.Add(Format(fsd, [cVersion, 1]));

  ML.Add(Format(fsg, [cx1, x1]));
  ML.Add(Format(fsg, [cx2, x2]));
  ML.Add(Format(fsg, [cx3, x3]));
  ML.Add(Format(fsg, [cx4, x4]));

  ML.Add(Format(fsg, [cy1, y1]));
  ML.Add(Format(fsg, [cy2, y2]));
  ML.Add(Format(fsg, [cy3, y3]));
  ML.Add(Format(fsg, [cy4, y4]));

  ML.Add(Format(fsg, [cz1, z1]));
  ML.Add(Format(fsg, [cz2, z2]));
  ML.Add(Format(fsg, [cz3, z3]));
  ML.Add(Format(fsg, [cz4, z4]));

  ML.Add(Format(fsg, [cl1, l1]));
  ML.Add(Format(fsg, [cl2, l2]));
  ML.Add(Format(fsg, [cl3, l3]));
  ML.Add(Format(fsg, [cl4, l4]));

  ML.Add(Format(fsg, [ck1, k1]));
  ML.Add(Format(fsg, [ck2, k2]));
  ML.Add(Format(fsg, [ck3, k3]));
  ML.Add(Format(fsg, [ck4, k3]));

  ML.Add(Format(fsd, [cm1, m1]));
  ML.Add(Format(fsd, [cm2, m2]));
  ML.Add(Format(fsd, [cm3, m3]));
  ML.Add(Format(fsd, [cm4, m3]));

  ML.Add(Format(fsd, [cOffsetX, OffsetX]));
  ML.Add(Format(fsd, [cOffsetY, OffsetY]));
  ML.Add(Format(fsd, [cOffsetZ, OffsetZ]));

  ML.Add(Format(fss, [cMinusCap, BoolStr[MinusCap]]));
  ML.Add(Format(fss, [cOpacity, BoolStr[Opacity]]));
  ML.Add(Format(fss, [cBigmap, BoolStr[Bigmap]]));
  ML.Add(Format(fss, [cPin, BoolStr[Pin]]));
  ML.Add(Format(fss, [cNorm, BoolStr[Norm]]));
  ML.Add(Format(fsd, [cTextureNorm, TextureNorm]));

  ML.Add(Format(fsd, [cMeshSize, MeshSize]));
  ML.Add(Format(fsd, [cGain, Gain]));
  ML.Add(Format(fsd, [cCapValue, CapValue]));
  ML.Add(Format(fsd, [cAbsoluteRange, AbsoluteRange]));
  ML.Add(Format(fss, [cReducedMesh, BoolStr[ReducedMesh]]));
  ML.Add(Format(fss, [cPlusCap, BoolStr[PlusCap]]));

  ML.Add(Format(fsd, [cDim, Dim]));
  ML.Add(Format(fsd, [cDrawFigure, DrawFigure]));

  ML.Add(Format(fsd, [cScene, Scene]));
  ML.Add(Format(fsd, [cGraph, Graph]));
  ML.Add(Format(fsd, [cPlot, Plot]));
  ML.Add(Format(fsd, [cFigure, Figure]));
  ML.Add(Format(fsd, [cParam, Param]));

  ML.Add(Format(fsd, [cBitmap, Bitmap]));
  ML.Add(Format(fsd, [cColor, Color]));

  ML.Add(Format(fsf, [cAngleX, WrapAngleX]));
  ML.Add(Format(fsf, [cAngleY, WrapAngleY]));
  ML.Add(Format(fsf, [cAngleZ, WrapAngleZ]));

  ML.Add(Format(fsf, [cPosX, PosX]));
  ML.Add(Format(fsf, [cPosY, PosY]));
  ML.Add(Format(fsf, [cPosZ, PosZ]));

  ML.Add(Format(fsd, [cT1, T1]));
  ML.Add(Format(fsd, [cT2, T2]));
  ML.Add(Format(fsd, [cT3, T3]));
  ML.Add(Format(fsd, [cT4, T4]));

  ML.Add(Format(fsd, [cForceMode, ForceMode]));
  ML.Add(Format(fss, [cSolutionMode, BoolStr[SolutionMode]]));
  ML.Add(Format(fsd, [cPlotFigure, PlotFigure]));
  ML.Add(Format(fss, [cVorzeichen, BoolStr[Vorzeichen]]));
  ML.Add(Format(fss, [cGleich, BoolStr[Gleich]]));
  ML.Add(Format(fss, [cLinearForce, BoolStr[LinearForce]]));
  ML.Add(Format(fsd, [cSliceMode, SliceMode]));

  ML.Add(Format(fss, [cOpenMesh, BoolStr[OpenMesh]]));
  ML.Add(Format(fss, [cPolarMesh, BoolStr[PolarMesh]]));
  ML.Add(Format(fss, [cLinearMesh, BoolStr[LinearMesh]]));
  ML.Add(Format(fss, [cFuzzyMesh, BoolStr[FuzzyMesh]]));

  ML.Add(Format(fsf, [civ, iv]));
  ML.Add(Format(fsf, [ciw, iw]));
  ML.Add(Format(fsf, [cjv, jv]));
  ML.Add(Format(fsf, [cjw, jw]));

  ML.Add(Format(fsf, [cbpr, ParamBahnRadius]));
  ML.Add(Format(fsf, [cbpx, ParamBahnPositionX]));
  ML.Add(Format(fsf, [cbpy, ParamBahnPositionY]));
  ML.Add(Format(fsf, [cbpa, ParamBahnAngle]));

  ML.Add(Format(fsf, [cbpf, ParamBahnCylinderF]));
  ML.Add(Format(fsd, [cbpd, ParamBahnCylinderD]));
  ML.Add(Format(fsd, [cbpz, ParamBahnCylinderZ]));

  ML.Add(Format(fss, [cshgr, BoolStr[ShowGrid]]));
  ML.Add(Format(fss, [cshku, BoolStr[ShowKugel]]));
  ML.Add(Format(fss, [cshcy, BoolStr[ShowCylinder]]));
  ML.Add(Format(fss, [cshdi, BoolStr[ShowDiameter]]));
  ML.Add(Format(fsd, [ccs2, ColorScheme3D]));

  if Want2D then
  begin
    ML.Add(Format(fss, [cshlb, BoolStr[ShowLB]]));
    ML.Add(Format(fss, [cshll, BoolStr[ShowLL]]));
    ML.Add(Format(fss, [cshc1, BoolStr[ShowLC1]]));
    ML.Add(Format(fss, [cshc2, BoolStr[ShowLC2]]));

    ML.Add(Format(fsf, [cnpx, NullpunktX]));
    ML.Add(Format(fsf, [cnpy, NullpunktY]));
    ML.Add(Format(fsf, [cpbz, PaintboxZoom]));
    ML.Add(Format(fsf, [cpbr, PaintboxRotation]));

    ML.Add(Format(fsf, [ccs1, ColorScheme2D]));
    ML.Add(Format(fsd, [cbs1, ParamBahnStrokeWidth1]));
    ML.Add(Format(fsd, [cbs2, ParamBahnStrokeWidth2]));
  end;

  ML.Add(Format(fss, [cLux, BoolStr[Lux]]));

  ML.Add(Format(fss, [cLux1, BoolStr[Lux1]]));
  ML.Add(Format(fsd, [cl1x, Lux1X]));
  ML.Add(Format(fsd, [cl1y, Lux1Y]));
  ML.Add(Format(fsd, [cl1z, Lux1Z]));

  ML.Add(Format(fss, [cLux2, BoolStr[Lux2]]));
  ML.Add(Format(fsd, [cl2x, Lux2X]));
  ML.Add(Format(fsd, [cl2y, Lux2Y]));
  ML.Add(Format(fsd, [cl2z, Lux2Z]));

  ML.Add(Format(fss, [cLux3, BoolStr[Lux3]]));
  ML.Add(Format(fsd, [cl3x, Lux3X]));
  ML.Add(Format(fsd, [cl3y, Lux3Y]));
  ML.Add(Format(fsd, [cl3z, Lux3Z]));

  ML.Add(Format(fss, [cLux4, BoolStr[Lux4]]));
  ML.Add(Format(fsd, [cl4x, Lux4X]));
  ML.Add(Format(fsd, [cl4y, Lux4Y]));
  ML.Add(Format(fsd, [cl4z, Lux4Z]));
end;

procedure TFederData1.SaveDiffBin(fd: TFederData; ML: TStrings);
begin
  ML.Add(Format(fbd, [nVersion, 1]));
  if x1 <> fd.x1 then
    ML.Add(Format(fbg, [nx1, x1]));
  if x2 <> fd.x2 then
    ML.Add(Format(fbg, [nx2, x2]));
  if x3 <> fd.x3 then
    ML.Add(Format(fbg, [nx3, x3]));
  if x4 <> fd.x4 then
    ML.Add(Format(fbg, [nx4, x4]));

  if y1 <> fd.y1 then
    ML.Add(Format(fbg, [ny1, y1]));
  if y2 <> fd.y2 then
    ML.Add(Format(fbg, [ny2, y2]));
  if y3 <> fd.y3 then
    ML.Add(Format(fbg, [ny3, y3]));
  if y4 <> fd.y4 then
    ML.Add(Format(fbg, [ny4, y4]));

  if z1 <> fd.z1 then
    ML.Add(Format(fbg, [nz1, z1]));
  if z2 <> fd.z2 then
    ML.Add(Format(fbg, [nz2, z2]));
  if z3 <> fd.z3 then
    ML.Add(Format(fbg, [nz3, z3]));
  if z4 <> fd.z4 then
    ML.Add(Format(fbg, [nz4, z4]));

  if l1 <> fd.l1 then
    ML.Add(Format(fbg, [nl1, l1]));
  if l2 <> fd.l2 then
    ML.Add(Format(fbg, [nl2, l2]));
  if l3 <> fd.l3 then
    ML.Add(Format(fbg, [nl3, l3]));
  if l4 <> fd.l4 then
    ML.Add(Format(fbg, [nl4, l4]));

  if k1 <> fd.k1 then
    ML.Add(Format(fbg, [nk1, k1]));
  if k2 <> fd.k2 then
    ML.Add(Format(fbg, [nk2, k2]));
  if k3 <> fd.k3 then
    ML.Add(Format(fbg, [nk3, k3]));
  if k4 <> fd.k4 then
    ML.Add(Format(fbg, [nk4, k4]));

  if m1 <> fd.m1 then
    ML.Add(Format(fbd, [nm1, m1]));
  if m2 <> fd.m2 then
    ML.Add(Format(fbd, [nm2, m2]));
  if m3 <> fd.m3 then
    ML.Add(Format(fbd, [nm3, m3]));
  if m4 <> fd.m4 then
    ML.Add(Format(fbd, [nm4, m4]));

  if OffsetX <> fd.OffsetX then
    ML.Add(Format(fbd, [nOffsetX, OffsetX]));
  if OffsetY <> fd.OffsetY then
    ML.Add(Format(fbd, [nOffsetY, OffsetY]));
  if OffsetZ <> fd.OffsetZ then
    ML.Add(Format(fbd, [nOffsetZ, OffsetZ]));

  if MinusCap <> fd.MinusCap then
    ML.Add(Format(fbs, [nMinusCap, BoolStr[MinusCap]]));
  if Opacity <> fd.Opacity then
    ML.Add(Format(fbs, [nOpacity, BoolStr[Opacity]]));
  if Bigmap <> fd.Bigmap then
    ML.Add(Format(fbs, [nBigmap, BoolStr[Bigmap]]));
  if Pin <> fd.Pin then
    ML.Add(Format(fbs, [nPin, BoolStr[Pin]]));
  if Norm <> fd.Norm then
    ML.Add(Format(fbs, [nNorm, BoolStr[Norm]]));
  if TextureNorm <> fd.TextureNorm then
    ML.Add(Format(fbd, [nTextureNorm, TextureNorm]));

  if MeshSize <> fd.MeshSize then
    ML.Add(Format(fbd, [nMeshSize, MeshSize]));
  if Gain <> fd.Gain then
    ML.Add(Format(fbd, [nGain, Gain]));
  if CapValue <> fd.CapValue then
    ML.Add(Format(fbd, [nCapValue, CapValue]));
  if AbsoluteRange <> fd.AbsoluteRange then
    ML.Add(Format(fbd, [nAbsoluteRange, AbsoluteRange]));
  if ReducedMesh <> fd.ReducedMesh then
    ML.Add(Format(fbs, [nReducedMesh, BoolStr[ReducedMesh]]));
  if PlusCap <> fd.PlusCap then
    ML.Add(Format(fbs, [nPlusCap, BoolStr[PlusCap]]));

  if Dim <> fd.Dim then
    ML.Add(Format(fbd, [nDim, Dim]));
  if DrawFigure <> fd.DrawFigure then
    ML.Add(Format(fbd, [nDrawFigure, DrawFigure]));

  if Scene <> fd.Scene then
    ML.Add(Format(fbd, [nScene, Scene]));
  if Graph <> fd.Graph then
    ML.Add(Format(fbd, [nGraph, Graph]));
  if Plot <> fd.Plot then
    ML.Add(Format(fbd, [nPlot, Plot]));
  if Figure <> fd.Figure then
    ML.Add(Format(fbd, [nFigure, Figure]));
  if FParam <> fd.Param then
    ML.Add(Format(fbd, [nParam, Param]));

  if FBitmap <> fd.Bitmap then
    ML.Add(Format(fbd, [nBitmap, Bitmap]));
  if Color <> fd.Color then
    ML.Add(Format(fbd, [nColor, Color]));

  if Abs(WrapAngleX) > Epsilon then
  ML.Add(Format(fbf, [nAngleX, WrapAngleX]));
  if Abs(WrapAngleY) > Epsilon then
  ML.Add(Format(fbf, [nAngleY, WrapAngleY]));
  if Abs(WrapAngleZ) > Epsilon then
  ML.Add(Format(fbf, [nAngleZ, WrapAngleZ]));
  if PosX <> fd.PosX then
  ML.Add(Format(fbf, [nPosX, PosX]));
  if PosY <> fd.PosY then
  ML.Add(Format(fbf, [nPosY, PosY]));
  if PosZ <> fd.PosZ then
  ML.Add(Format(fbf, [nPosZ, PosZ]));

  if T1 <> fd.T1 then
    ML.Add(Format(fbd, [nT1, T1]));
  if T2 <> fd.T2 then
    ML.Add(Format(fbd, [nT2, T2]));
  if T3 <> fd.T3 then
    ML.Add(Format(fbd, [nT3, T3]));
  if T4 <> fd.T4 then
    ML.Add(Format(fbd, [nT4, T4]));

  if ForceMode <> fd.ForceMode then
    ML.Add(Format(fbd, [nForceMode, ForceMode]));

  if SolutionMode <> fd.SolutionMode then
  ML.Add(Format(fbs, [nSolutionMode, BoolStr[SolutionMode]]));
  if PlotFigure <> fd.PlotFigure then
    ML.Add(Format(fbd, [nPlotFigure, PlotFigure]));
  if Vorzeichen <> fd.Vorzeichen then
    ML.Add(Format(fbs, [nVorzeichen, BoolStr[Vorzeichen]]));
  if Gleich <> fd.Gleich then
    ML.Add(Format(fbs, [nGleich, BoolStr[Gleich]]));
  if LinearForce <> fd.LinearForce then
    ML.Add(Format(fbs, [nLinearForce, BoolStr[LinearForce]]));
  if SliceMode <> fd.SliceMode then
    ML.Add(Format(fbd, [nSliceMode, SliceMode]));

  if OpenMesh <> fd.OpenMesh then
    ML.Add(Format(fbs, [nOpenMesh, BoolStr[OpenMesh]]));
  if PolarMesh <> fd.PolarMesh then
    ML.Add(Format(fbs, [nPolarMesh, BoolStr[PolarMesh]]));
  if LinearMesh <> fd.LinearMesh then
    ML.Add(Format(fbs, [nLinearMesh, BoolStr[LinearMesh]]));
  if FuzzyMesh <> fd.FuzzyMesh then
    ML.Add(Format(fbs, [nFuzzyMesh, BoolStr[FuzzyMesh]]));

  if IV <> fd.IV then
    ML.Add(Format(fbf, [nIV, IV]));
  if IW <> fd.IW then
    ML.Add(Format(fbf, [nIW, IW]));
  if JV <> fd.JV then
    ML.Add(Format(fbf, [nJV, JV]));
  if JW <> fd.JW then
    ML.Add(Format(fbf, [nJW, JW]));

  if ParamBahnRadius <> fd.ParamBahnRadius then
    ML.Add(Format(fbg, [nParamBahnRadius, ParamBahnRadius]));
  if ParamBahnPositionX <> fd.ParamBahnPositionX then
    ML.Add(Format(fbg, [nParamBahnPositionX, ParamBahnPositionX]));
  if ParamBahnPositionY <> fd.ParamBahnPositionY then
    ML.Add(Format(fbg, [nParamBahnPositionY, ParamBahnPositionY]));
  if ParamBahnAngle <> fd.ParamBahnAngle then
    ML.Add(Format(fbg, [nParamBahnAngle, ParamBahnAngle]));

  if ParamBahnCylinderF <> fd.ParamBahnCylinderF then
    ML.Add(Format(fbg, [nParamBahnCylinderF, ParamBahnCylinderF]));
  if ParamBahnCylinderD <> fd.ParamBahnCylinderD then
    ML.Add(Format(fbd, [nParamBahnCylinderD, ParamBahnCylinderD]));
  if ParamBahnCylinderZ <> fd.ParamBahnCylinderZ then
    ML.Add(Format(fbd, [nParamBahnCylinderZ, ParamBahnCylinderZ]));

  if ShowGrid then
    ML.Add(Format(fbs, [nShowGrid, BoolStr[ShowGrid]]));
  if ShowKugel then
    ML.Add(Format(fbs, [nShowKugel, BoolStr[ShowKugel]]));
  if not ShowCylinder then
    ML.Add(Format(fbs, [nShowCylinder, BoolStr[ShowCylinder]]));
  if not ShowDiameter then
    ML.Add(Format(fbs, [nShowDiameter, BoolStr[ShowDiameter]]));
  if ColorScheme3D <> fd.ColorScheme3D then
    ML.Add(Format(fbd, [nColorScheme3D, ColorScheme3D]));

  if Want2D then
  begin
    if not ShowLB then
      ML.Add(Format(fbs, [nShowLB, BoolStr[ShowLB]]));
    if not ShowLL then
      ML.Add(Format(fbs, [nShowLL, BoolStr[ShowLL]]));
    if not ShowLC1 then
      ML.Add(Format(fbs, [nShowLC1, BoolStr[ShowLC1]]));
    if not ShowLC2 then
      ML.Add(Format(fbs, [nShowLC2, BoolStr[ShowLC2]]));

    if NullpunktX <> fd.NullpunktX then
      ML.Add(Format(fbf, [nNullpunktX, NullpunktX]));
    if NullpunktY <> fd.NullpunktY then
      ML.Add(Format(fbf, [nNullpunktY, NullpunktY]));
    if PaintboxZoom <> fd.PaintboxZoom then
      ML.Add(Format(fbf, [nPaintboxZoom, PaintboxZoom]));
    if PaintboxRotation <> fd.PaintboxRotation then
      ML.Add(Format(fbf, [nPaintboxRotation, PaintboxRotation]));

    if ColorScheme2D <> fd.ColorScheme2D then
      ML.Add(Format(fbd, [nColorScheme2D, ColorScheme2D]));
    if ParamBahnStrokeWidth1 <> fd.ParamBahnStrokeWidth1 then
      ML.Add(Format(fbd, [nParamBahnStrokeWidth1, ParamBahnStrokeWidth1]));
    if ParamBahnStrokeWidth2 <> fd.ParamBahnStrokeWidth2 then
      ML.Add(Format(fbd, [nParamBahnStrokeWidth2, ParamBahnStrokeWidth2]));
  end;

  if Lux then
    ML.Add(Format(fbs, [nLux, BoolStr[Lux]]));

  if Lux1 then
    ML.Add(Format(fbs, [nLux1, BoolStr[Lux1]]));
  if Lux1X <> fd.Lux1X then
    ML.Add(Format(fbd, [nLux1X, Lux1X]));
  if Lux1Y <> fd.Lux1Y then
    ML.Add(Format(fbd, [nLux1Y, Lux1Y]));
  if Lux1Z <> fd.Lux1Z then
    ML.Add(Format(fbd, [nLux1Z, Lux1Z]));

  if Lux2 then
    ML.Add(Format(fbs, [nLux2, BoolStr[Lux2]]));
  if Lux2X <> fd.Lux2X then
    ML.Add(Format(fbd, [nLux2X, Lux2X]));
  if Lux2Y <> fd.Lux2Y then
    ML.Add(Format(fbd, [nLux2Y, Lux2Y]));
  if Lux2Z <> fd.Lux2Z then
    ML.Add(Format(fbd, [nLux2Z, Lux2Z]));

  if Lux3 then
    ML.Add(Format(fbs, [nLux3, BoolStr[Lux3]]));
  if Lux3X <> fd.Lux3X then
    ML.Add(Format(fbd, [nLux3X, Lux3X]));
  if Lux3Y <> fd.Lux3Y then
    ML.Add(Format(fbd, [nLux3Y, Lux3Y]));
  if Lux3Z <> fd.Lux3Z then
    ML.Add(Format(fbd, [nLux3Z, Lux3Z]));

  if Lux4 then
    ML.Add(Format(fbs, [nLux4, BoolStr[Lux4]]));
  if Lux4X <> fd.Lux4X then
    ML.Add(Format(fbd, [nLux4X, Lux4X]));
  if Lux4Y <> fd.Lux4Y then
    ML.Add(Format(fbd, [nLux4Y, Lux4Y]));
  if Lux4Z <> fd.Lux4Z then
    ML.Add(Format(fbd, [nLux4Z, Lux4Z]));

  Main.SaveColorInfoBin(ML, 4);
end;

procedure TFederData1.SaveDiffCode(fd: TFederData; ML: TStrings);
begin
  if WantTags then
  begin
    ML.Add('<h3>Model Data</h3>');
    ML.Add('<div id="model-data"><pre>');
    ML.Add('//model.begin;');
  end;
  ML.Add('Version := 2;');
  if x1 <> fd.x1 then
    ML.Add(Format('x1 := %.5g;', [x1]));
  if x2 <> fd.x2 then
    ML.Add(Format('x2 := %.5g;', [x2]));
  if x3 <> fd.x3 then
    ML.Add(Format('x3 := %.5g;', [x3]));
  if x4 <> fd.x4 then
    ML.Add(Format('x4 := %.5g;', [x4]));

  if y1 <> fd.y1 then
    ML.Add(Format('y1 := %.5g;', [y1]));
  if y2 <> fd.y2 then
    ML.Add(Format('y2 := %.5g;', [y2]));
  if y3 <> fd.y3 then
    ML.Add(Format('y3 := %.5g;', [y3]));
  if y4 <> fd.y4 then
    ML.Add(Format('y4 := %.5g;', [y4]));

  if z1 <> fd.z1 then
    ML.Add(Format('z1 := %.5g;', [z1]));
  if z2 <> fd.z2 then
    ML.Add(Format('z2 := %.5g;', [z2]));
  if z3 <> fd.z3 then
    ML.Add(Format('z3 := %.5g;', [z3]));
  if z4 <> fd.z4 then
    ML.Add(Format('z4 := %.5g;', [z4]));

  if l1 <> fd.l1 then
    ML.Add(Format('l1 := %.5g;', [l1]));
  if l2 <> fd.l2 then
    ML.Add(Format('l2 := %.5g;', [l2]));
  if l3 <> fd.l3 then
    ML.Add(Format('l3 := %.5g;', [l3]));
  if l4 <> fd.l4 then
    ML.Add(Format('l4 := %.5g;', [l4]));

  if k1 <> fd.k1 then
    ML.Add(Format('k1 := %.5g;', [k1]));
  if k2 <> fd.k2 then
    ML.Add(Format('k2 := %.5g;', [k2]));
  if k3 <> fd.k3 then
    ML.Add(Format('k3 := %.5g;', [k3]));
  if k4 <> fd.k4 then
    ML.Add(Format('k4 := %.5g;', [k4]));

  if m1 <> fd.m1 then
    ML.Add(Format('m1 := %d;', [m1]));
  if m2 <> fd.m2 then
    ML.Add(Format('m2 := %d;', [m2]));
  if m3 <> fd.m3 then
    ML.Add(Format('m3 := %d;', [m3]));
  if m4 <> fd.m4 then
    ML.Add(Format('m4 := %d;', [m4]));

  if OffsetX <> fd.OffsetX then
    ML.Add(Format('OffsetX := %d;', [OffsetX]));
  if OffsetY <> fd.OffsetY then
    ML.Add(Format('OffsetY := %d;', [OffsetY]));
  if OffsetZ <> fd.OffsetZ then
    ML.Add(Format('OffsetZ := %d;', [OffsetZ]));

  if MinusCap <> fd.MinusCap then
    ML.Add(Format('MinusCap := %s;', [BoolStr[MinusCap]]));
  if Opacity <> fd.Opacity then
    ML.Add(Format('Opacity := %s;', [BoolStr[Opacity]]));
  if Bigmap <> fd.Bigmap then
    ML.Add(Format('Bigmap := %s;', [BoolStr[Bigmap]]));
  if Pin <> fd.Pin then
    ML.Add(Format('Pin := %s;', [BoolStr[Pin]]));
  if Norm <> fd.Norm then
    ML.Add(Format('Norm := %s;', [BoolStr[Norm]]));
  if TextureNorm <> fd.TextureNorm then
    ML.Add(Format('TextureNorm := %d;', [TextureNorm]));

  if MeshSize <> fd.MeshSize then
    ML.Add(Format('MeshSize := %d;', [MeshSize]));
  if Gain <> fd.Gain then
    ML.Add(Format('Gain := %d;', [Gain]));
  if CapValue <> fd.CapValue then
    ML.Add(Format('CapValue := %d;', [CapValue]));
  if AbsoluteRange <> fd.AbsoluteRange then
    ML.Add(Format('AbsoluteRange := %d;', [AbsoluteRange]));
  if ReducedMesh <> fd.ReducedMesh then
    ML.Add(Format('ReducedMesh := %s;', [BoolStr[ReducedMesh]]));
  if PlusCap <> fd.PlusCap then
    ML.Add(Format('PlusCap := %s;', [BoolStr[PlusCap]]));

  if Dim <> fd.Dim then
    ML.Add(Format('Dim := %d;', [Dim]));
  if DrawFigure <> fd.DrawFigure then
    ML.Add(Format('DrawFigure := %d;', [DrawFigure]));

  if Scene <> fd.Scene then
    ML.Add(Format('Scene := %d;', [Scene]));
  if Graph <> fd.Graph then
    ML.Add(Format('Graph := %d;', [Graph]));
  if Plot <> fd.Plot then
    ML.Add(Format('Plot := %d;', [Plot]));
  if Figure <> fd.Figure then
    ML.Add(Format('Figure := %d;', [Figure]));
  if FParam <> fd.Param then
    ML.Add(Format('Param := %d;', [Param]));

  if FBitmap <> fd.Bitmap then
    ML.Add(Format('Bitmap := %d;', [Bitmap]));
  if Color <> fd.Color then
    ML.Add(Format('Color := %d;', [Color]));

  if Abs(WrapAngleX) > Epsilon then
  ML.Add(Format('AngleX := %2.2f;', [WrapAngleX]));
  if Abs(WrapAngleY) > Epsilon then
  ML.Add(Format('AngleY := %2.2f;', [WrapAngleY]));
  if Abs(WrapAngleZ) > Epsilon then
  ML.Add(Format('AngleZ := %2.2f;', [WrapAngleZ]));
  if PosX <> fd.PosX then
  ML.Add(Format('PosX := %2.2f;', [PosX]));
  if PosY <> fd.PosY then
  ML.Add(Format('PosY := %2.2f;', [PosY]));
  if PosZ <> fd.PosZ then
  ML.Add(Format('PosZ := %2.2f;', [PosZ]));

  if T1 <> fd.T1 then
    ML.Add(Format('T1 := %d;', [T1]));
  if T2 <> fd.T2 then
    ML.Add(Format('T2 := %d;', [T2]));
  if T3 <> fd.T3 then
    ML.Add(Format('T3 := %d;', [T3]));
  if T4 <> fd.T4 then
    ML.Add(Format('T4 := %d;', [T4]));

  if ForceMode <> fd.ForceMode then
    ML.Add(Format('ForceMode := %d;', [ForceMode]));

  if SolutionMode <> fd.SolutionMode then
  ML.Add(Format('SolutionMode := %s;', [BoolStr[SolutionMode]]));
  if PlotFigure <> fd.PlotFigure then
    ML.Add(Format('PlotFigure := %d;', [PlotFigure]));
  if Vorzeichen <> fd.Vorzeichen then
    ML.Add(Format('Vorzeichen := %s;', [BoolStr[Vorzeichen]]));
  if Gleich <> fd.Gleich then
    ML.Add(Format('Gleich := %s;', [BoolStr[Gleich]]));
  if LinearForce <> fd.LinearForce then
    ML.Add(Format('LinearForce := %s;', [BoolStr[LinearForce]]));
  if SliceMode <> fd.SliceMode then
    ML.Add(Format('SliceMode := %d;', [SliceMode]));

  if OpenMesh <> fd.OpenMesh then
    ML.Add(Format('OpenMesh := %s;', [BoolStr[OpenMesh]]));
  if PolarMesh <> fd.PolarMesh then
    ML.Add(Format('PolarMesh := %s;', [BoolStr[PolarMesh]]));
  if LinearMesh <> fd.LinearMesh then
    ML.Add(Format('LinearMesh := %s;', [BoolStr[LinearMesh]]));
  if FuzzyMesh <> fd.FuzzyMesh then
    ML.Add(Format('FuzzyMesh := %s;', [BoolStr[FuzzyMesh]]));

  if IV <> fd.IV then
    ML.Add(Format('IV := %2.2f;', [IV]));
  if IW <> fd.IW then
    ML.Add(Format('IW := %2.2f;', [IW]));
  if JV <> fd.JV then
    ML.Add(Format('JV := %2.2f;', [JV]));
  if JW <> fd.JW then
    ML.Add(Format('JW := %2.2f;', [JW]));

  if ParamBahnRadius <> fd.ParamBahnRadius then
    ML.Add(Format(dsg, [cParamBahnRadius, ParamBahnRadius]));
  if ParamBahnPositionX <> fd.ParamBahnPositionX then
    ML.Add(Format(dsg, [cParamBahnPositionX, ParamBahnPositionX]));
  if ParamBahnPositionY <> fd.ParamBahnPositionY then
    ML.Add(Format(dsg, [cParamBahnPositionY, ParamBahnPositionY]));
  if ParamBahnAngle <> fd.ParamBahnAngle then
    ML.Add(Format(dsg, [cParamBahnAngle, ParamBahnAngle]));

  if ParamBahnCylinderF <> fd.ParamBahnCylinderF then
    ML.Add(Format(dsg, [cParamBahnCylinderF, ParamBahnCylinderF]));
  if ParamBahnCylinderD <> fd.ParamBahnCylinderD then
    ML.Add(Format(dsd, [cParamBahnCylinderD, ParamBahnCylinderD]));
  if ParamBahnCylinderZ <> fd.ParamBahnCylinderZ then
    ML.Add(Format(dsd, [cParamBahnCylinderZ, ParamBahnCylinderZ]));

  if ShowGrid then
    ML.Add(Format(dss, [cShowGrid, BoolStr[ShowGrid]]));
  if ShowKugel then
    ML.Add(Format(dss, [cShowKugel, BoolStr[ShowKugel]]));
  if not ShowCylinder then
    ML.Add(Format(dss, [cShowCylinder, BoolStr[ShowCylinder]]));
  if not ShowDiameter then
    ML.Add(Format(dss, [cShowDiameter, BoolStr[ShowDiameter]]));
  if ColorScheme3D <> fd.ColorScheme3D then
    ML.Add(Format(dsd, [cColorScheme3D, ColorScheme3D]));

  if Want2D then
  begin
    if not ShowLB then
      ML.Add(Format(dss, [cShowLB, BoolStr[ShowLB]]));
    if not ShowLL then
      ML.Add(Format(dss, [cShowLL, BoolStr[ShowLL]]));
    if not ShowLC1 then
      ML.Add(Format(dss, [cShowLC1, BoolStr[ShowLC1]]));
    if not ShowLC2 then
      ML.Add(Format(dss, [cShowLC2, BoolStr[ShowLC2]]));

    if NullpunktX <> fd.NullpunktX then
      ML.Add(Format(dsf, [cNullpunktX, NullpunktX]));
    if NullpunktY <> fd.NullpunktY then
      ML.Add(Format(dsf, [cNullpunktY, NullpunktY]));
    if PaintboxZoom <> fd.PaintboxZoom then
      ML.Add(Format(dsf, [cPaintboxZoom, PaintboxZoom]));
    if PaintboxRotation <> fd.PaintboxRotation then
      ML.Add(Format(dsf, [cPaintboxRotation, PaintboxRotation]));

    if ColorScheme2D <> fd.ColorScheme2D then
      ML.Add(Format(dsd, [cColorScheme2D, ColorScheme2D]));
    if ParamBahnStrokeWidth1 <> fd.ParamBahnStrokeWidth1 then
      ML.Add(Format(dsd, [cParamBahnStrokeWidth1, ParamBahnStrokeWidth1]));
    if ParamBahnStrokeWidth2 <> fd.ParamBahnStrokeWidth2 then
      ML.Add(Format(dsd, [cParamBahnStrokeWidth2, ParamBahnStrokeWidth2]));
  end;

  if Lux then
    ML.Add(Format(dss, [cLux, BoolStr[Lux]]));

  if Lux1 then
    ML.Add(Format(dss, [cLux1, BoolStr[Lux1]]));
  if Lux1X <> fd.Lux1X then
    ML.Add(Format(dsd, [cLux1X, Lux1X]));
  if Lux1Y <> fd.Lux1Y then
    ML.Add(Format(dsd, [cLux1Y, Lux1Y]));
  if Lux1Z <> fd.Lux1Z then
    ML.Add(Format(dsd, [cLux1Z, Lux1Z]));

  if Lux2 then
    ML.Add(Format(dss, [cLux2, BoolStr[Lux2]]));
  if Lux2X <> fd.Lux2X then
    ML.Add(Format(dsd, [cLux2X, Lux2X]));
  if Lux2Y <> fd.Lux2Y then
    ML.Add(Format(dsd, [cLux2Y, Lux2Y]));
  if Lux2Z <> fd.Lux2Z then
    ML.Add(Format(dsd, [cLux2Z, Lux2Z]));

  if Lux3 then
    ML.Add(Format(dss, [cLux3, BoolStr[Lux3]]));
  if Lux3X <> fd.Lux3X then
    ML.Add(Format(dsd, [cLux3X, Lux3X]));
  if Lux3Y <> fd.Lux3Y then
    ML.Add(Format(dsd, [cLux3Y, Lux3Y]));
  if Lux3Z <> fd.Lux3Z then
    ML.Add(Format(dsd, [cLux3Z, Lux3Z]));

  if Lux4 then
    ML.Add(Format(dss, [cLux4, BoolStr[Lux4]]));
  if Lux4X <> fd.Lux4X then
    ML.Add(Format(dsd, [cLux4X, Lux4X]));
  if Lux4Y <> fd.Lux4Y then
    ML.Add(Format(dsd, [cLux4Y, Lux4Y]));
  if Lux4Z <> fd.Lux4Z then
    ML.Add(Format(dsd, [cLux4Z, Lux4Z]));

  if WantTags then
  begin
    ML.Add('//model.end;');
    ML.Add('</pre></div>');
  end;

  ML.Add('');
  if not WantTags then
  begin
    ML.Add('{ ColorInfo }');
    ML.Add('');
  end;

  if WantTags then
  begin
    ML.Add('<h3>Color Data</h3>');
    ML.Add('<div id="color-data"><pre>');
    ML.Add('//color.begin;');
  end;
  Main.SaveColorInfoCode(ML, 4);
  if WantTags then
  begin
    ML.Add('//color.end;');
    ML.Add('</pre></div>');
  end;
end;

procedure TFederData1.SaveCode(ML: TStrings);
begin
  if WantTags then
  begin
    ML.Add('<div id="model-data"><pre>');
    ML.Add('//model.begin;');
  end;
  ML.Add(Format('x1 := %.5g;', [x1]));
  ML.Add(Format('x2 := %.5g;', [x2]));
  ML.Add(Format('x3 := %.5g;', [x3]));
  ML.Add(Format('x4 := %.5g;', [x4]));

  ML.Add(Format('y1 := %.5g;', [y1]));
  ML.Add(Format('y2 := %.5g;', [y2]));
  ML.Add(Format('y3 := %.5g;', [y3]));
  ML.Add(Format('y4 := %.5g;', [y4]));

  ML.Add(Format('z1 := %.5g;', [z1]));
  ML.Add(Format('z2 := %.5g;', [z2]));
  ML.Add(Format('z3 := %.5g;', [z3]));
  ML.Add(Format('z4 := %.5g;', [z4]));

  ML.Add(Format('l1 := %.5g;', [l1]));
  ML.Add(Format('l2 := %.5g;', [l2]));
  ML.Add(Format('l3 := %.5g;', [l3]));
  ML.Add(Format('l4 := %.5g;', [l4]));

  ML.Add(Format('k1 := %.5g;', [k1]));
  ML.Add(Format('k2 := %.5g;', [k2]));
  ML.Add(Format('k3 := %.5g;', [k3]));
  ML.Add(Format('k4 := %.5g;', [k4]));

  ML.Add(Format('m1 := %d;', [m1]));
  ML.Add(Format('m2 := %d;', [m2]));
  ML.Add(Format('m3 := %d;', [m3]));
  ML.Add(Format('m4 := %d;', [m4]));

  ML.Add(Format('OffsetX := %d;', [OffsetX]));
  ML.Add(Format('OffsetY := %d;', [OffsetY]));
  ML.Add(Format('OffsetZ := %d;', [OffsetZ]));

  ML.Add(Format('MinusCap := %s;', [BoolStr[MinusCap]]));
  ML.Add(Format('Opacity := %s;', [BoolStr[Opacity]]));
  ML.Add(Format('Bigmap := %s;', [BoolStr[Bigmap]]));
  ML.Add(Format('Pin := %s;', [BoolStr[Pin]]));
  ML.Add(Format('Norm := %s;', [BoolStr[Norm]]));
  ML.Add(Format('TextureNorm := %d;', [TextureNorm]));

  ML.Add(Format('MeshSize := %d;', [MeshSize]));
  ML.Add(Format('Gain := %d;', [Gain]));
  ML.Add(Format('CapValue := %d;', [CapValue]));
  ML.Add(Format('AbsoluteRange := %d;', [AbsoluteRange]));
  ML.Add(Format('ReducedMesh := %s;', [BoolStr[ReducedMesh]]));
  ML.Add(Format('PlusCap := %s;', [BoolStr[PlusCap]]));

  ML.Add(Format('Dim := %d;', [Dim]));
  ML.Add(Format('DrawFigure := %d;', [DrawFigure]));

  ML.Add(Format('Scene := %d;', [Scene]));
  ML.Add(Format('Graph := %d;', [Graph]));
  ML.Add(Format('Plot := %d;', [Plot]));
  ML.Add(Format('Figure := %d;', [Figure]));
  ML.Add(Format('Param := %d;', [Param]));

  ML.Add(Format('Bitmap := %d;', [Bitmap]));
  ML.Add(Format('Color := %d;', [Color]));

  ML.Add(Format('AngleX := %2.2f;', [WrapAngleX]));
  ML.Add(Format('AngleY := %2.2f;', [WrapAngleY]));
  ML.Add(Format('AngleZ := %2.2f;', [WrapAngleZ]));
  ML.Add(Format('PosX := %2.2f;', [PosX]));
  ML.Add(Format('PosY := %2.2f;', [PosY]));
  ML.Add(Format('PosZ := %2.2f;', [PosZ]));

  ML.Add(Format('T1 := %d;', [T1]));
  ML.Add(Format('T2 := %d;', [T2]));
  ML.Add(Format('T3 := %d;', [T3]));
  ML.Add(Format('T4 := %d;', [T4]));

  ML.Add(Format('ForceMode := %d;', [ForceMode]));
  ML.Add(Format('SolutionMode := %s;', [BoolStr[SolutionMode]]));
  ML.Add(Format('PlotFigure := %d;', [PlotFigure]));
  ML.Add(Format('Vorzeichen := %s;', [BoolStr[Vorzeichen]]));
  ML.Add(Format('Gleich := %s;', [BoolStr[Gleich]]));
  ML.Add(Format('LinearForce := %s;', [BoolStr[LinearForce]]));
  ML.Add(Format('SliceMode := %d;', [SliceMode]));

  ML.Add(Format('OpenMesh := %s;', [BoolStr[OpenMesh]]));
  ML.Add(Format('PolarMesh := %s;', [BoolStr[PolarMesh]]));
  ML.Add(Format('LinearMesh := %s;', [BoolStr[LinearMesh]]));
  ML.Add(Format('FuzzyMesh := %s;', [BoolStr[FuzzyMesh]]));

  ML.Add(Format('IV := %2.2f;', [IV]));
  ML.Add(Format('IW := %2.2f;', [IW]));
  ML.Add(Format('JV := %2.2f;', [JV]));
  ML.Add(Format('JW := %2.2f;', [JW]));

  ML.Add(Format('%s := %.2g;', [cParamBahnRadius, ParamBahnRadius]));
  ML.Add(Format('%s := %.2g;', [cParamBahnPositionX, ParamBahnPositionX]));
  ML.Add(Format('%s := %.2g;', [cParamBahnPositionY, ParamBahnPositionY]));
  ML.Add(Format('%s := %.2g;', [cParamBahnAngle, ParamBahnAngle]));

  ML.Add(Format('%s := %.2g;', [cParamBahnCylinderF, ParamBahnCylinderF]));
  ML.Add(Format('%s := %d;', [cParamBahnCylinderD, ParamBahnCylinderD]));
  ML.Add(Format('%s := %d;', [cParamBahnCylinderZ, ParamBahnCylinderZ]));

  ML.Add(Format('%s := %s;', [cShowGrid, BoolStr[ShowGrid]]));
  ML.Add(Format('%s := %s;', [cShowKugel, BoolStr[ShowKugel]]));
  ML.Add(Format('%s := %s;', [cShowCylinder, BoolStr[ShowCylinder]]));
  ML.Add(Format('%s := %s;', [cShowDiameter, BoolStr[ShowDiameter]]));
  ML.Add(Format('%s := %d;', [cColorScheme3D, ColorScheme3D]));

  if Want2D then
  begin
    ML.Add(Format('%s := %s;', [cShowLB, BoolStr[ShowLB]]));
    ML.Add(Format('%s := %s;', [cShowLL, BoolStr[ShowLL]]));
    ML.Add(Format('%s := %s;', [cShowLC1, BoolStr[ShowLC1]]));
    ML.Add(Format('%s := %s;', [cShowLC2, BoolStr[ShowLC2]]));

    ML.Add(Format('%s := %2.2f;', [cNullpunktX, NullpunktX]));
    ML.Add(Format('%s := %2.2f;', [cNullpunktY, NullpunktY]));
    ML.Add(Format('%s := %2.2f;', [cPaintboxZoom, PaintboxZoom]));
    ML.Add(Format('%s := %2.2f;', [cPaintboxRotation, PaintboxRotation]));

    ML.Add(Format('%s := %d;', [cColorScheme2D, ColorScheme2D]));
    ML.Add(Format('%s := %d;', [cParamBahnStrokeWidth1, ParamBahnStrokeWidth1]));
    ML.Add(Format('%s := %d;', [cParamBahnStrokeWidth2, ParamBahnStrokeWidth2]));
  end;

  ML.Add(Format('%s := %s;', [cLux, BoolStr[Lux]]));

  ML.Add(Format('%s := %s;', [cLux1, BoolStr[Lux1]]));
  ML.Add(Format('%s := %d;', [cLux1X, Lux1X]));
  ML.Add(Format('%s := %d;', [cLux1Y, Lux1Y]));
  ML.Add(Format('%s := %d;', [cLux1Z, Lux1Z]));

  ML.Add(Format('%s := %s;', [cLux2, BoolStr[Lux2]]));
  ML.Add(Format('%s := %d;', [cLux2X, Lux2X]));
  ML.Add(Format('%s := %d;', [cLux2Y, Lux2Y]));
  ML.Add(Format('%s := %d;', [cLux2Z, Lux2Z]));

  ML.Add(Format('%s := %s;', [cLux3, BoolStr[Lux3]]));
  ML.Add(Format('%s := %d;', [cLux3X, Lux3X]));
  ML.Add(Format('%s := %d;', [cLux3Y, Lux3Y]));
  ML.Add(Format('%s := %d;', [cLux3Z, Lux3Z]));

  ML.Add(Format('%s := %s;', [cLux4, BoolStr[Lux4]]));
  ML.Add(Format('%s := %d;', [cLux4X, Lux4X]));
  ML.Add(Format('%s := %d;', [cLux4Y, Lux4Y]));
  ML.Add(Format('%s := %d;', [cLux4Z, Lux4Z]));
  if WantTags then
  begin
    ML.Add('//model.end;');
    ML.Add('</pre></div>');
  end;
end;

procedure TFederData1.LoadNative(ML: TStrings);
var
  s: string;
begin
  InitDefault;

  s := ML.Values[cx1];
  x1 := StrToFloatDef(s, x1);
  s := ML.Values[cx2];
  x2 := StrToFloatDef(s, x2);
  s := ML.Values[cx3];
  x3 := StrToFloatDef(s, x3);
  s := ML.Values[cx4];
  x4 := StrToFloatDef(s, x4);

  s := ML.Values[cy1];
  y1 := StrToFloatDef(s, y1);
  s := ML.Values[cy2];
  y2 := StrToFloatDef(s, y2);
  s := ML.Values[cy3];
  y3 := StrToFloatDef(s, y3);
  s := ML.Values[cy4];
  y4 := StrToFloatDef(s, y4);

  s := ML.Values[cz1];
  z1 := StrToFloatDef(s, z1);
  s := ML.Values[cz2];
  z2 := StrToFloatDef(s, z2);
  s := ML.Values[cz3];
  z3 := StrToFloatDef(s, z3);
  s := ML.Values[cz4];
  z4 := StrToFloatDef(s, z4);

  s := ML.Values[cl1];
  l1 := StrToFloatDef(s, l1);
  s := ML.Values[cl2];
  l2 := StrToFloatDef(s, l2);
  s := ML.Values[cl3];
  l3 := StrToFloatDef(s, l3);
  s := ML.Values[cl4];
  l4 := StrToFloatDef(s, l4);

  s := ML.Values[ck1];
  k1 := StrToFloatDef(s, k1);
  s := ML.Values[ck2];
  k2 := StrToFloatDef(s, k2);
  s := ML.Values[ck3];
  k3 := StrToFloatDef(s, k3);
  s := ML.Values[ck4];
  k4 := StrToFloatDef(s, k4);

  s := ML.Values[cm1];
  m1 := StrToIntDef(s, m1);
  s := ML.Values[cm2];
  m2 := StrToIntDef(s, m2);
  s := ML.Values[cm3];
  m3 := StrToIntDef(s, m3);
  s := ML.Values[cm4];
  m4 := StrToIntDef(s, m4);

  s := ML.Values[cOffsetX];
  OffsetX := StrToIntDef(s, OffsetX);
  s := ML.Values[cOffsetY];
  OffsetY := StrToIntDef(s, OffsetY);
  s := ML.Values[cOffsetZ];
  OffsetZ := StrToIntDef(s, OffsetZ);

  s := ML.Values[cMinusCap];
  MinusCap := TUtils.IsTrue(s);
  s := ML.Values[cPlusCap];
  PlusCap := TUtils.IsTrue(s);
  s := ML.Values[cOpacity];
  Opacity := TUtils.IsTrue(s);
  s := ML.Values[cBigmap];
  Bigmap := TUtils.IsTrue(s);
  s := ML.Values[cPin];
  Pin := TUtils.IsTrue(s);
  s := ML.Values[cNorm];
  Norm := TUtils.IsTrue(s);
  s := ML.Values[cTextureNorm];
  TextureNorm := StrToIntDef(s, TextureNorm);

  s := ML.Values[cMeshSize];
  MeshSize := StrToIntDef(s, MeshSize);
  s := ML.Values[cGain];
  Gain := StrToIntDef(s, Gain);
  s := ML.Values[cLimit];
  Limit := StrToIntDef(s, Limit);
  s := ML.Values[cRange];
  Range := StrToIntDef(s, Range);

  InitCapValueFromLimit;
  s := ML.Values[cCapValue];
  if s <> '' then
  begin
    CapValue := StrToIntDef(s, CapValue);
  end;

  InitAbsoluteRangeFromRange;
  s := ML.Values[cAbsoluteRange];
  if s <> '' then
  begin
    AbsoluteRange := StrToIntDef(s, AbsoluteRange);
  end;

  s := ML.Values[cDim];
  Dim := StrToIntDef(s, Dim);
  s := ML.Values[cDrawFigure];
  DrawFigure := StrToIntDef(s, DrawFigure);

  s := ML.Values[cScene];
  Scene := StrToIntDef(s, Scene);
  s := ML.Values[cGraph];
  Graph := StrToIntDef(s, Graph);
  s := ML.Values[cPlot];
  Plot := StrToIntDef(s, Plot);
  s := ML.Values[cFigure];
  Figure := StrToIntDef(s, Figure);
  s := ML.Values[cParam];
  Param := StrToIntDef(s, FParam);

  s := ML.Values[cBitmap];
  Bitmap := StrToIntDef(s, FBitmap);
  s := ML.Values[cColor];
  Color := StrToIntDef(s, Color);

  s := ML.Values[cAngleX];
  AngleX := StrToFloatDef(s, AngleX);
  s := ML.Values[cAngleY];
  AngleY := StrToFloatDef(s, AngleY);
  s := ML.Values[cAngleZ];
  AngleZ := StrToFloatDef(s, AngleZ);
  s := ML.Values[cPosX];
  PosX := StrToFloatDef(s, PosX);
  s := ML.Values[cPosY];
  PosY := StrToFloatDef(s, PosY);
  s := ML.Values[cPosZ];
  PosZ := StrToFloatDef(s, PosZ);
  s := ML.Values[cPosZ1];
  PosZ1 := StrToFloatDef(s, PosZ1);
  s := ML.Values[cPosZ2];
  PosZ2 := StrToFloatDef(s, PosZ2);

  s := ML.Values[cT1];
  T1 := StrToIntDef(s, T1);
  s := ML.Values[cT2];
  T2 := StrToIntDef(s, T2);
  s := ML.Values[cT3];
  T3 := StrToIntDef(s, T3);
  s := ML.Values[cT4];
  T4 := StrToIntDef(s, T4);

  s := ML.Values[cForceMode];
  ForceMode := StrToIntDef(s, 0);
  s := ML.Values[cSolutionMode];
  if s = '' then
    SolutionMode := True
  else
    SolutionMode := TUtils.IsTrue(s);
  s := ML.Values[cPlotFigure];
  PlotFigure := StrToIntDef(s, 1);
  s := ML.Values[cVorzeichen];
  Vorzeichen := TUtils.IsTrue(s);
  s := ML.Values[cGleich];
  Gleich := TUtils.IsTrue(s);
  s := ML.Values[cLinearForce];
  LinearForce := TUtils.IsEmptyOrTrue(s);
  s := ML.Values[cSliceMode];
  SliceMode := StrToIntDef(s, 0);

  s := ML.Values[cOpenMesh];
  OpenMesh := TUtils.IsTrue(s);
  s := ML.Values[cPolarMesh];
  PolarMesh := TUtils.StrToBoolDef(s, True);
  s := ML.Values[cLinearMesh];
  LinearMesh := TUtils.StrToBoolDef(s, True);
  s := ML.Values[cFuzzyMesh];
  FuzzyMesh := TUtils.IsTrue(s);
  s := ML.Values[cReducedMesh];
  ReducedMesh := TUtils.IsTrue(s);

  s := ML.Values[civ];
  IV := StrToFloatDef(s, IV);
  s := ML.Values[ciw];
  IW := StrToFloatDef(s, IW);
  s := ML.Values[cjv];
  JV := StrToFloatDef(s, JV);
  s := ML.Values[cjw];
  JW := StrToFloatDef(s, JW);

  s := ML.Values[cParamBahnRadius];
  ParamBahnRadius := StrToFloatDef(s, ParamBahnRadius);
  s := ML.Values[cParamBahnPositionX];
  ParamBahnPositionX := StrToFloatDef(s, ParamBahnPositionX);
  s := ML.Values[cParamBahnPositionY];
  ParamBahnPositionY := StrToFloatDef(s, ParamBahnPositionY);
  s := ML.Values[cParamBahnAngle];
  ParamBahnAngle := StrToFloatDef(s, ParamBahnAngle);

  s := ML.Values[cParamBahnCylinderF];
  ParamBahnCylinderF := StrToFloatDef(s, ParamBahnCylinderF);
  s := ML.Values[cParamBahnCylinderD];
  ParamBahnCylinderD := StrToIntDef(s, ParamBahnCylinderD);
  s := ML.Values[cParamBahnCylinderZ];
  ParamBahnCylinderZ := StrToIntDef(s, ParamBahnCylinderZ);

  s := ML.Values[cShowGrid];
  ShowGrid := TUtils.IsTrue(s);
  s := ML.Values[cShowKugel];
  ShowKugel := TUtils.IsTrue(s);
  s := ML.Values[cShowCylinder];
  ShowCylinder := not TUtils.IsFalse(s);
  s := ML.Values[cShowDiameter];
  ShowDiameter := not TUtils.IsFalse(s);
  s := ML.Values[cColorScheme3D];
  ColorScheme3D := StrToIntDef(s, ColorScheme3D);

  if Want2D then
  begin
    s := ML.Values[cShowLB];
    ShowLB := not TUtils.IsFalse(s);
    s := ML.Values[cShowLL];
    ShowLL := not TUtils.IsFalse(s);
    s := ML.Values[cShowLC1];
    ShowLC1 := not TUtils.IsFalse(s);
    s := ML.Values[cShowLC2];
    ShowLC2 := not TUtils.IsFalse(s);

    s := ML.Values[cNullpunktX];
    NullpunktX := StrToFloatDef(s, NullpunktX);
    s := ML.Values[cNullpunktY];
    NullpunktY := StrToFloatDef(s, NullpunktY);
    s := ML.Values[cPaintboxZoom];
    PaintboxZoom := StrToFloatDef(s, PaintboxZoom);
    s := ML.Values[cPaintboxRotation];
    PaintboxRotation := StrToFloatDef(s, PaintboxRotation);

    s := ML.Values[cColorScheme2D];
    ColorScheme2D := StrToIntDef(s, ColorScheme2D);
    s := ML.Values[cParamBahnStrokeWidth1];
    ParamBahnStrokeWidth1 := StrToIntDef(s, ParamBahnStrokeWidth1);
    s := ML.Values[cParamBahnStrokeWidth2];
    ParamBahnStrokeWidth2 := StrToIntDef(s, ParamBahnStrokeWidth2);
  end;

  s := ML.Values[cLux];
  Lux := TUtils.IsTrue(s);

  s := ML.Values[cLux1];
  Lux1 := TUtils.IsTrue(s);
  s := ML.Values[cLux1X];
  Lux1X := StrToIntDef(s, Lux1X);
  s := ML.Values[cLux1Y];
  Lux1Y := StrToIntDef(s, Lux1Y);
  s := ML.Values[cLux1Z];
  Lux1Z := StrToIntDef(s, Lux1Z);

  s := ML.Values[cLux2];
  Lux2 := TUtils.IsTrue(s);
  s := ML.Values[cLux2X];
  Lux2X := StrToIntDef(s, Lux2X);
  s := ML.Values[cLux2Y];
  Lux2Y := StrToIntDef(s, Lux2Y);
  s := ML.Values[cLux2Z];
  Lux2Z := StrToIntDef(s, Lux2Z);

  s := ML.Values[cLux3];
  Lux3 := TUtils.IsTrue(s);
  s := ML.Values[cLux3X];
  Lux3X := StrToIntDef(s, Lux3X);
  s := ML.Values[cLux3Y];
  Lux3Y := StrToIntDef(s, Lux3Y);
  s := ML.Values[cLux3Z];
  Lux3Z := StrToIntDef(s, Lux3Z);

  s := ML.Values[cLux4];
  Lux4 := TUtils.IsTrue(s);
  s := ML.Values[cLux4X];
  Lux4X := StrToIntDef(s, Lux4X);
  s := ML.Values[cLux4Y];
  Lux4Y := StrToIntDef(s, Lux4Y);
  s := ML.Values[cLux4Z];
  Lux4Z := StrToIntDef(s, Lux4Z);

  { ColorBand Properties }

  s := ML.Values[cBlindColorCount];
  BlindColorCount := StrToIntDef(s, BlindColorCount);

  s := ML.Values[cStripWidth];
  StripWidth := StrToIntDef(s, StripWidth);

  s := ML.Values[cBandWidth];
  BandWidth := StrToIntDef(s, BandWidth);

  s := ML.Values[cStandardColor];
  StandardColor := StrToIntDef(s, StandardColor);

  s := ML.Values[cWantContour];
  WantContour := TUtils.IsTrue(s);

  s := ML.Values[cWantShirtColor];
  WantShirtColor := TUtils.IsTrue(s);

  s := ML.Values[cSquareBitmap];
  SquareBitmap := TUtils.IsTrue(s);

  s := ML.Values[cHorizontalBitmap];
  HorizontalBitmap := TUtils.IsTrue(s);

  s := ML.Values[cSquareSym];
  SquareSym := TUtils.IsTrue(s);

  s := ML.Values[cRandomPaint];
  RandomPaint := TUtils.IsTrue(s);

  s := ML.Values[cStandardPaint];
  StandardPaint := TUtils.IsTrue(s);

  s := ML.Values[cMonoPaint];
  MonoPaint := TUtils.IsTrue(s);

  s := ML.Values[cStripColor];
  StripColor := StrToAlphaColorDef(s, StripColor);

  s := ML.Values[cBackgroundColor];
  BackgroundColor := StrToAlphaColorDef(s, BackgroundColor);
end;

procedure TFederData1.LoadNativeBin(ML: TStrings);

  function Find(i: Integer): string;
  begin
    result := ML.Values[IntToStr(i)];
  end;

var
  s: string;
begin
  InitDefault;

  s := Find(nx1);
  x1 := StrToFloatDef(s, x1);
  s := Find(nx2);
  x2 := StrToFloatDef(s, x2);
  s := Find(nx3);
  x3 := StrToFloatDef(s, x3);
  s := Find(nx4);
  x4 := StrToFloatDef(s, x4);

  s := Find(ny1);
  y1 := StrToFloatDef(s, y1);
  s := Find(ny2);
  y2 := StrToFloatDef(s, y2);
  s := Find(ny3);
  y3 := StrToFloatDef(s, y3);
  s := Find(ny4);
  y4 := StrToFloatDef(s, y4);

  s := Find(nz1);
  z1 := StrToFloatDef(s, z1);
  s := Find(nz2);
  z2 := StrToFloatDef(s, z2);
  s := Find(nz3);
  z3 := StrToFloatDef(s, z3);
  s := Find(nz4);
  z4 := StrToFloatDef(s, z4);

  s := Find(nl1);
  l1 := StrToFloatDef(s, l1);
  s := Find(nl2);
  l2 := StrToFloatDef(s, l2);
  s := Find(nl3);
  l3 := StrToFloatDef(s, l3);
  s := Find(nl4);
  l4 := StrToFloatDef(s, l4);

  s := Find(nk1);
  k1 := StrToFloatDef(s, k1);
  s := Find(nk2);
  k2 := StrToFloatDef(s, k2);
  s := Find(nk3);
  k3 := StrToFloatDef(s, k3);
  s := Find(nk4);
  k4 := StrToFloatDef(s, k4);

  s := Find(nm1);
  m1 := StrToIntDef(s, m1);
  s := Find(nm2);
  m2 := StrToIntDef(s, m2);
  s := Find(nm3);
  m3 := StrToIntDef(s, m3);
  s := Find(nm4);
  m4 := StrToIntDef(s, m4);

  s := Find(nOffsetX);
  OffsetX := StrToIntDef(s, OffsetX);
  s := Find(nOffsetY);
  OffsetY := StrToIntDef(s, OffsetY);
  s := Find(nOffsetZ);
  OffsetZ := StrToIntDef(s, OffsetZ);

  s := Find(nMinusCap);
  MinusCap := TUtils.IsTrue(s);
  s := Find(nPlusCap);
  PlusCap := TUtils.IsTrue(s);
  s := Find(nOpacity);
  Opacity := TUtils.IsTrue(s);
  s := Find(nBigmap);
  Bigmap := TUtils.IsTrue(s);
  s := Find(nPin);
  Pin := TUtils.IsTrue(s);
  s := Find(nNorm);
  Norm := TUtils.IsTrue(s);
  s := Find(nTextureNorm);
  TextureNorm := StrToIntDef(s, TextureNorm);

  s := Find(nMeshSize);
  MeshSize := StrToIntDef(s, MeshSize);
  s := Find(nGain);
  Gain := StrToIntDef(s, Gain);
  s := Find(nLimit);
  Limit := StrToIntDef(s, Limit);
  s := Find(nCapValue);
  CapValue := StrToIntDef(s, CapValue);
  s := Find(nRange);
  Range := StrToIntDef(s, Range);
  s := Find(nAbsoluteRange);
  AbsoluteRange := StrToIntDef(s, AbsoluteRange);

  s := Find(nDim);
  Dim := StrToIntDef(s, Dim);
  s := Find(nDrawFigure);
  DrawFigure := StrToIntDef(s, DrawFigure);

  s := Find(nScene);
  Scene := StrToIntDef(s, Scene);
  s := Find(nGraph);
  Graph := StrToIntDef(s, Graph);
  s := Find(nPlot);
  Plot := StrToIntDef(s, Plot);
  s := Find(nFigure);
  Figure := StrToIntDef(s, Figure);
  s := Find(nParam);
  Param := StrToIntDef(s, FParam);

  s := Find(nBitmap);
  Bitmap := StrToIntDef(s, FBitmap);
  s := Find(nColor);
  Color := StrToIntDef(s, Color);

  s := Find(nAngleX);
  AngleX := StrToFloatDef(s, AngleX);
  s := Find(nAngleY);
  AngleY := StrToFloatDef(s, AngleY);
  s := Find(nAngleZ);
  AngleZ := StrToFloatDef(s, AngleZ);
  s := Find(nPosX);
  PosX := StrToFloatDef(s, PosX);
  s := Find(nPosY);
  PosY := StrToFloatDef(s, PosY);
  s := Find(nPosZ);
  PosZ := StrToFloatDef(s, PosZ);
  s := ML.Values[cPosZ1];
  PosZ1 := StrToFloatDef(s, PosZ1);
  s := ML.Values[cPosZ2];
  PosZ2 := StrToFloatDef(s, PosZ2);

  s := Find(nT1);
  T1 := StrToIntDef(s, T1);
  s := Find(nT2);
  T2 := StrToIntDef(s, T2);
  s := Find(nT3);
  T3 := StrToIntDef(s, T3);
  s := Find(nT4);
  T4 := StrToIntDef(s, T4);

  s := Find(nForceMode);
  ForceMode := StrToIntDef(s, 0);
  s := Find(nSolutionMode);
  if s = '' then
    SolutionMode := True
  else
    SolutionMode := TUtils.IsTrue(s);
  s := Find(nPlotFigure);
  PlotFigure := StrToIntDef(s, 1);
  s := Find(nVorzeichen);
  Vorzeichen := TUtils.IsTrue(s);
  s := Find(nGleich);
  Gleich := TUtils.IsTrue(s);
  s := Find(nLinearForce);
  LinearForce := TUtils.IsEmptyOrTrue(s);
  s := Find(nSliceMode);
  SliceMode := StrToIntDef(s, 0);

  s := Find(nOpenMesh);
  OpenMesh := TUtils.IsTrue(s);
  s := Find(nPolarMesh);
  PolarMesh := TUtils.StrToBoolDef(s, True);
  s := Find(nLinearMesh);
  LinearMesh := TUtils.StrToBoolDef(s, True);
  s := Find(nFuzzyMesh);
  FuzzyMesh := TUtils.IsTrue(s);
  s := Find(nReducedMesh);
  ReducedMesh := TUtils.IsTrue(s);

  s := Find(niv);
  IV := StrToFloatDef(s, IV);
  s := Find(niw);
  IW := StrToFloatDef(s, IW);
  s := Find(njv);
  JV := StrToFloatDef(s, JV);
  s := Find(njw);
  JW := StrToFloatDef(s, JW);

  s := Find(nParamBahnRadius);
  ParamBahnRadius := StrToFloatDef(s, ParamBahnRadius);
  s := Find(nParamBahnPositionX);
  ParamBahnPositionX := StrToFloatDef(s, ParamBahnPositionX);
  s := Find(nParamBahnPositionY);
  ParamBahnPositionY := StrToFloatDef(s, ParamBahnPositionY);
  s := Find(nParamBahnAngle);
  ParamBahnAngle := StrToFloatDef(s, ParamBahnAngle);

  s := Find(nParamBahnCylinderF);
  ParamBahnCylinderF := StrToFloatDef(s, ParamBahnCylinderF);
  s := Find(nParamBahnCylinderD);
  ParamBahnCylinderD := StrToIntDef(s, ParamBahnCylinderD);
  s := Find(nParamBahnCylinderZ);
  ParamBahnCylinderZ := StrToIntDef(s, ParamBahnCylinderZ);

  s := Find(nShowGrid);
  ShowGrid := TUtils.IsTrue(s);
  s := Find(nShowKugel);
  ShowKugel := TUtils.IsTrue(s);
  s := Find(nShowCylinder);
  ShowCylinder := not TUtils.IsFalse(s);
  s := Find(nShowDiameter);
  ShowDiameter := not TUtils.IsFalse(s);
  s := Find(nColorScheme3D);
  ColorScheme3D := StrToIntDef(s, ColorScheme3D);

  if Want2D then
  begin
    s := Find(nShowLB);
    ShowLB := not TUtils.IsFalse(s);
    s := Find(nShowLL);
    ShowLL := not TUtils.IsFalse(s);
    s := Find(nShowLC1);
    ShowLC1 := not TUtils.IsFalse(s);
    s := Find(nShowLC2);
    ShowLC2 := not TUtils.IsFalse(s);

    s := Find(nNullpunktX);
    NullpunktX := StrToFloatDef(s, NullpunktX);
    s := Find(nNullpunktY);
    NullpunktY := StrToFloatDef(s, NullpunktY);
    s := Find(nPaintboxZoom);
    PaintboxZoom := StrToFloatDef(s, PaintboxZoom);
    s := Find(nPaintboxRotation);
    PaintboxRotation := StrToFloatDef(s, PaintboxRotation);

    s := Find(nColorScheme2D);
    ColorScheme2D := StrToIntDef(s, ColorScheme2D);
    s := Find(nParamBahnStrokeWidth1);
    ParamBahnStrokeWidth1 := StrToIntDef(s, ParamBahnStrokeWidth1);
    s := Find(nParamBahnStrokeWidth2);
    ParamBahnStrokeWidth2 := StrToIntDef(s, ParamBahnStrokeWidth2);
  end;

  s := Find(nLux);
  Lux := TUtils.IsTrue(s);

  s := Find(nLux1);
  Lux1 := TUtils.IsTrue(s);
  s := Find(nLux1X);
  Lux1X := StrToIntDef(s, Lux1X);
  s := Find(nLux1Y);
  Lux1Y := StrToIntDef(s, Lux1Y);
  s := Find(nLux1X);
  Lux1Z := StrToIntDef(s, Lux1Z);

  s := Find(nLux2);
  Lux2 := TUtils.IsTrue(s);
  s := Find(nLux2X);
  Lux2X := StrToIntDef(s, Lux2X);
  s := Find(nLux2Y);
  Lux2Y := StrToIntDef(s, Lux2Y);
  s := Find(nLux2X);
  Lux2Z := StrToIntDef(s, Lux2Z);

  s := Find(nLux3);
  Lux3 := TUtils.IsTrue(s);
  s := Find(nLux3X);
  Lux3X := StrToIntDef(s, Lux3X);
  s := Find(nLux3Y);
  Lux3Y := StrToIntDef(s, Lux3Y);
  s := Find(nLux3X);
  Lux3Z := StrToIntDef(s, Lux3Z);

  s := Find(nLux4);
  Lux4 := TUtils.IsTrue(s);
  s := Find(nLux4X);
  Lux4X := StrToIntDef(s, Lux4X);
  s := Find(nLux4Y);
  Lux4Y := StrToIntDef(s, Lux4Y);
  s := Find(nLux4X);
  Lux4Z := StrToIntDef(s, Lux4Z);

  { ColorBand Properties }

  s := Find(nBlindColorCount);
  BlindColorCount := StrToIntDef(s, BlindColorCount);

  s := Find(nStripWidth);
  StripWidth := StrToIntDef(s, StripWidth);

  s := Find(nBandWidth);
  BandWidth := StrToIntDef(s, BandWidth);

  s := Find(nStandardColor);
  StandardColor := StrToIntDef(s, StandardColor);

  s := Find(nWantContour);
  WantContour := TUtils.IsTrue(s);

  s := Find(nWantShirtColor);
  WantShirtColor := TUtils.IsTrue(s);

  s := Find(nSquareBitmap);
  SquareBitmap := TUtils.IsTrue(s);

  s := Find(nHorizontalBitmap);
  HorizontalBitmap := TUtils.IsTrue(s);

  s := Find(nSquareSym);
  SquareSym := TUtils.IsTrue(s);

  s := Find(nRandomPaint);
  RandomPaint := TUtils.IsTrue(s);

  s := Find(nStandardPaint);
  StandardPaint := TUtils.IsTrue(s);

  s := Find(nMonoPaint);
  MonoPaint := TUtils.IsTrue(s);

  s := Find(nStripColor);
  StripColor := StrToAlphaColorDef(s, StripColor);

  s := Find(nBackgroundColor);
  BackgroundColor := StrToAlphaColorDef(s, BackgroundColor);

  s := Find(nStripColorOffset);
  BackgroundColor := StrToAlphaColorDef(s, BackgroundColor);
end;

{ TFederData2 }

constructor TFederData2.Create;
begin
  inherited Create;
  sVersion := 'version';

  sx1 := 'x1';
  sx2 := 'x2';
  sx3 := 'x3';
  sx4 := 'x4';

  sy1 := 'y1';
  sy2 := 'y2';
  sy3 := 'y3';
  sy4 := 'y4';

  sz1 := 'z1';
  sz2 := 'z2';
  sz3 := 'z3';
  sz4 := 'z4';

  sl1 := 'l1';
  sl2 := 'l2';
  sl3 := 'l3';
  sl4 := 'l4';

  sk1 := 'k1';
  sk2 := 'k2';
  sk3 := 'k3';
  sk4 := 'k4';

  sm1 := 'm1';
  sm2 := 'm2';
  sm3 := 'm3';
  sm4 := 'm4';

  sDim := 'di';
  sDrawFigure := 'df';

  sScene := 'sc';
  sGraph := 'gr';
  sPlot := 'pl';
  sFigure := 'fi';
  sBitmap := 'bi';
  sColor := 'co';

  sOffsetX := 'ox';
  sOffsetY := 'oy';
  sOffsetZ := 'oz';

  sMeshSize := 'ms';
  sGain := 'gn';
  sLimit := 'li';
  sCapValue := 'cv';
  sRange := 'ra';
  sAbsoluteRange := 'ar';
  sParam := 'pa';

  sMinusCap := 'mc';
  sPlusCap := 'pc';
  sOpacity := 'op';
  sBigmap := 'bm';
  sPin := 'pn';
  sNorm := 'nm';
  sTextureNorm := 'tn';

  sAngleX := 'ax';
  sAngleY := 'ay';
  sAngleZ := 'az';
  sPosX := 'px';
  sPosY := 'py';
  sPosZ := 'pz';
  sPosZ1 := 'p1';
  sPosZ2 := 'p2';

  sT1 := 't1';
  sT2 := 't2';
  sT3 := 't3';
  sT4 := 't4';

  sForceMode := 'fm';
  sSolutionMode := 'sm';
  sPlotFigure := 'pf';
  sVorzeichen := 'vz';
  sGleich := 'gl';
  sLinearForce := 'lf';
  sSliceMode := 'ij';

  sOpenMesh := 'om';
  sPolarMesh := 'pm';
  sLinearMesh := 'lm';
  sFuzzyMesh := 'zm';
  sFuzzyMesh := 'rm';

  sIV := 'iv';
  sIW := 'iw';
  sJV := 'jv';
  sJW := 'jw';

  sParamBahnRadius := 'br';
  sParamBahnPositionX := 'bx';
  sParamBahnPositionY := 'by';
  sParamBahnAngle := 'ba';

  sParamBahnStrokeWidth1 := 'b1';
  sParamBahnStrokeWidth2 := 'b2';

  sParamBahnCylinderF := 'bf';
  sParamBahnCylinderD := 'bd';
  sParamBahnCylinderZ := 'bz';

  sShowGrid := 'sg';
  sShowKugel := 'sk';
  sShowCylinder := 'sc';
  sShowDiameter := 'sd';
  sShowLB := 'sb';
  sShowLL := 'sl';
  sShowLC1 := 'sr'; //red
  sShowLC2 := 'sg'; //show green curve

  sNullpunktX := 'nx';
  sNullpunktY := 'ny';
  sPaintboxZoom := 'pz';
  sPaintboxRotation := 'pr';

  sColorScheme2D := 'c2';
  sColorScheme3D := 'c3';

  sLux := 'a0';

  sLux1 := 'b0';
  sLux1X := 'bx';
  sLux1Y := 'by';
  sLux1Z := 'bz';

  sLux2 := 'c0';
  sLux2X := 'cx';
  sLux2Y := 'cy';
  sLux2Z := 'cz';

  sLux3 := 'd0';
  sLux3X := 'dx';
  sLux3Y := 'dy';
  sLux3Z := 'dz';

  sLux4 := 'e0';
  sLux4X := 'ex';
  sLux4Y := 'ey';
  sLux4Z := 'ez';
end;

procedure TFederData2.LoadVirtual(ML: TStrings);
var
  s: string;
  v: Integer;
begin
  InitDefault;
  s := ML.Values[sVersion];
  v := StrToIntDef(s, 0);
  if v = 2 then
  begin
    s := ML.Values[sx1];
    x1 := StrToFloatDef(s, x1);
    s := ML.Values[sx2];
    x2 := StrToFloatDef(s, x2);
    s := ML.Values[sx3];
    x3 := StrToFloatDef(s, x3);
    s := ML.Values[sx4];
    x4 := StrToFloatDef(s, x4);

    s := ML.Values[sy1];
    y1 := StrToFloatDef(s, y1);
    s := ML.Values[sy2];
    y2 := StrToFloatDef(s, y2);
    s := ML.Values[sy3];
    y3 := StrToFloatDef(s, y3);
    s := ML.Values[sy4];
    y4 := StrToFloatDef(s, y4);

    s := ML.Values[sz1];
    z1 := StrToFloatDef(s, z1);
    s := ML.Values[sz2];
    z2 := StrToFloatDef(s, z2);
    s := ML.Values[sz3];
    z3 := StrToFloatDef(s, z3);
    s := ML.Values[sz4];
    z4 := StrToFloatDef(s, z4);

    s := ML.Values[sl1];
    l1 := StrToFloatDef(s, l1);
    s := ML.Values[sl2];
    l2 := StrToFloatDef(s, l2);
    s := ML.Values[sl3];
    l3 := StrToFloatDef(s, l3);
    s := ML.Values[sl4];
    l4 := StrToFloatDef(s, l4);

    s := ML.Values[sk1];
    k1 := StrToFloatDef(s, k1);
    s := ML.Values[sk2];
    k2 := StrToFloatDef(s, k2);
    s := ML.Values[sk3];
    k3 := StrToFloatDef(s, k3);
    s := ML.Values[sk4];
    k4 := StrToFloatDef(s, k4);

    s := ML.Values[sm1];
    m1 := StrToIntDef(s, m1);
    s := ML.Values[sm2];
    m2 := StrToIntDef(s, m2);
    s := ML.Values[sm3];
    m3 := StrToIntDef(s, m3);
    s := ML.Values[sm4];
    m4 := StrToIntDef(s, m4);

    s := ML.Values[sOffsetX];
    OffsetX := StrToIntDef(s, OffsetX);
    s := ML.Values[sOffsetY];
    OffsetY := StrToIntDef(s, OffsetY);
    s := ML.Values[sOffsetZ];
    OffsetZ := StrToIntDef(s, OffsetZ);

    s := ML.Values[sMinusCap];
    MinusCap := TUtils.IsTrue(s);
    s := ML.Values[sPlusCap];
    PlusCap := TUtils.IsTrue(s);
    s := ML.Values[sOpacity];
    Opacity := TUtils.IsTrue(s);
    s := ML.Values[sBigmap];
    Bigmap := TUtils.IsTrue(s);
    s := ML.Values[sPin];
    Pin := TUtils.IsTrue(s);
    s := ML.Values[sNorm];
    Norm := TUtils.IsTrue(s);
    s := ML.Values[sTextureNorm];
    TextureNorm := StrToIntDef(s, TextureNorm);

    s := ML.Values[sMeshSize];
    MeshSize := StrToIntDef(s, MeshSize);
    s := ML.Values[sGain];
    Gain := StrToIntDef(s, Gain);
    s := ML.Values[sLimit];
    Limit := StrToIntDef(s, Limit);
    s := ML.Values[sRange];
    Range := StrToIntDef(s, Range);

    InitCapValueFromLimit;
    s := ML.Values[cCapValue];
    if s <> '' then
    begin
      CapValue := StrToIntDef(s, CapValue);
    end;

    InitAbsoluteRangeFromRange;
    s := ML.Values[cAbsoluteRange];
    if s <> '' then
    begin
      AbsoluteRange := StrToIntDef(s, AbsoluteRange);
    end;

    s := ML.Values[sDim];
    Dim := StrToIntDef(s, Dim);
    s := ML.Values[sDrawFigure];
    DrawFigure := StrToIntDef(s, DrawFigure);

    s := ML.Values[sScene];
    Scene := StrToIntDef(s, Scene);
    s := ML.Values[sGraph];
    Graph := StrToIntDef(s, Graph);
    s := ML.Values[sPlot];
    Plot := StrToIntDef(s, Plot);
    s := ML.Values[sFigure];
    Figure := StrToIntDef(s, Figure);
    s := ML.Values[sParam];
    Param := ReadParamValue(s);

    s := ML.Values[sBitmap];
    Bitmap := StrToIntDef(s, FBitmap);
    s := ML.Values[sColor];
    Color := StrToIntDef(s, Color);

    s := ML.Values[sAngleX];
    AngleX := StrToFloatDef(s, AngleX);
    s := ML.Values[sAngleY];
    AngleY := StrToFloatDef(s, AngleY);
    s := ML.Values[sAngleZ];
    AngleZ := StrToFloatDef(s, AngleZ);
    s := ML.Values[sPosX];
    PosX := StrToFloatDef(s, PosX);
    s := ML.Values[sPosY];
    PosY := StrToFloatDef(s, PosY);
    s := ML.Values[sPosZ];
    PosZ := StrToFloatDef(s, PosZ);
    s := ML.Values[sPosZ1];
    PosZ1 := StrToFloatDef(s, PosZ1);
    s := ML.Values[sPosZ2];
    PosZ2 := StrToFloatDef(s, PosZ2);

    s := ML.Values[sT1];
    T1 := StrToIntDef(s, T1);
    s := ML.Values[sT2];
    T2 := StrToIntDef(s, T2);
    s := ML.Values[sT3];
    T3 := StrToIntDef(s, T3);
    s := ML.Values[sT4];
    T4 := StrToIntDef(s, T4);

    s := ML.Values[cForceMode];
    ForceMode := StrToIntDef(s, 0);
    s := ML.Values[cSolutionMode];
    if s = '' then
      SolutionMode := True
    else
      SolutionMode := TUtils.IsTrue(s);
    s := ML.Values[cPlotFigure];
    PlotFigure := StrToIntDef(s, 1);
    s := ML.Values[cVorzeichen];
    Vorzeichen := TUtils.IsTrue(s);
    s := ML.Values[cGleich];
    Gleich := TUtils.IsTrue(s);
    s := ML.Values[cLinearForce];
    LinearForce := TUtils.IsEmptyOrTrue(s);
    s := ML.Values[cSliceMode];
    SliceMode := StrToIntDef(s, 0);

    s := ML.Values[cOpenMesh];
    OpenMesh := TUtils.IsTrue(s);
    s := ML.Values[cPolarMesh];
    PolarMesh := TUtils.StrToBoolDef(s, True);
    s := ML.Values[cLinearMesh];
    LinearMesh := TUtils.StrToBoolDef(s, True);
    s := ML.Values[cFuzzyMesh];
    FuzzyMesh := TUtils.IsTrue(s);
    s := ML.Values[cReducedMesh];
    ReducedMesh := TUtils.IsTrue(s);

    s := ML.Values[siv];
    IV := StrToFloatDef(s, IV);
    s := ML.Values[siw];
    IW := StrToFloatDef(s, IW);
    s := ML.Values[sjv];
    JV := StrToFloatDef(s, JV);
    s := ML.Values[sjw];
    JW := StrToFloatDef(s, JW);

    s := ML.Values[sParamBahnRadius];
    ParamBahnRadius := StrToFloatDef(s, ParamBahnRadius);
    s := ML.Values[sParamBahnPositionX];
    ParamBahnPositionX := StrToFloatDef(s, ParamBahnPositionX);
    s := ML.Values[sParamBahnPositionY];
    ParamBahnPositionY := StrToFloatDef(s, ParamBahnPositionY);
    s := ML.Values[sParamBahnAngle];
    ParamBahnAngle := StrToFloatDef(s, ParamBahnAngle);

    s := ML.Values[sParamBahnCylinderF];
    ParamBahnCylinderF := StrToFloatDef(s, ParamBahnCylinderF);
    s := ML.Values[sParamBahnCylinderD];
    ParamBahnCylinderD := StrToIntDef(s, ParamBahnCylinderD);
    s := ML.Values[sParamBahnCylinderZ];
    ParamBahnCylinderZ := StrToIntDef(s, ParamBahnCylinderZ);

    s := ML.Values[cShowGrid];
    ShowGrid := TUtils.IsTrue(s);
    s := ML.Values[cShowKugel];
    ShowKugel := TUtils.IsTrue(s);
    s := ML.Values[cShowCylinder];
    ShowCylinder := TUtils.IsTrue(s);
    s := ML.Values[cShowDiameter];
    ShowDiameter := TUtils.IsTrue(s);
    s := ML.Values[sColorScheme3D];
    ColorScheme3D := StrToIntDef(s, ColorScheme3D);

    if Want2D then
    begin
      s := ML.Values[cShowLB];
      ShowLB := TUtils.IsTrue(s);
      s := ML.Values[cShowLL];
      ShowLL := TUtils.IsTrue(s);
      s := ML.Values[cShowLC1];
      ShowLC1 := TUtils.IsTrue(s);
      s := ML.Values[cShowLC2];
      ShowLC2 := TUtils.IsTrue(s);

      s := ML.Values[sNullpunktX];
      NullpunktX := StrToFloatDef(s, NullpunktX);
      s := ML.Values[sNullpunktY];
      NullpunktY := StrToFloatDef(s, NullpunktY);
      s := ML.Values[sPaintboxZoom];
      PaintboxZoom := StrToFloatDef(s, PaintboxZoom);
      s := ML.Values[sPaintboxRotation];
      PaintboxRotation := StrToFloatDef(s, PaintboxRotation);

      s := ML.Values[sColorScheme2D];
      ColorScheme2D := StrToIntDef(s, ColorScheme2D);
      s := ML.Values[sParamBahnStrokeWidth1];
      ParamBahnStrokeWidth1 := StrToIntDef(s, ParamBahnStrokeWidth1);
      s := ML.Values[sParamBahnStrokeWidth2];
      ParamBahnStrokeWidth2 := StrToIntDef(s, ParamBahnStrokeWidth2);
    end;

    s := ML.Values[cLux];
    Lux := TUtils.IsTrue(s);

    s := ML.Values[cLux1];
    Lux1 := TUtils.IsTrue(s);
    s := ML.Values[sLux1X];
    Lux1X := StrToIntDef(s, Lux1X);
    s := ML.Values[sLux1Y];
    Lux1Y := StrToIntDef(s, Lux1Y);
    s := ML.Values[sLux1Z];
    Lux1Z := StrToIntDef(s, Lux1Z);

    s := ML.Values[cLux2];
    Lux2 := TUtils.IsTrue(s);
    s := ML.Values[sLux2X];
    Lux2X := StrToIntDef(s, Lux2X);
    s := ML.Values[sLux2Y];
    Lux2Y := StrToIntDef(s, Lux2Y);
    s := ML.Values[sLux2Z];
    Lux2Z := StrToIntDef(s, Lux2Z);

    s := ML.Values[cLux3];
    Lux3 := TUtils.IsTrue(s);
    s := ML.Values[sLux3X];
    Lux3X := StrToIntDef(s, Lux3X);
    s := ML.Values[sLux3Y];
    Lux3Y := StrToIntDef(s, Lux3Y);
    s := ML.Values[sLux3Z];
    Lux3Z := StrToIntDef(s, Lux3Z);

    s := ML.Values[cLux4];
    Lux4 := TUtils.IsTrue(s);
    s := ML.Values[sLux4X];
    Lux4X := StrToIntDef(s, Lux4X);
    s := ML.Values[sLux4Y];
    Lux4Y := StrToIntDef(s, Lux4Y);
    s := ML.Values[sLux4Z];
    Lux4Z := StrToIntDef(s, Lux4Z);
  end;
end;

function TFederData2.ReadParamValue(s: string): Integer;
var
  i: Integer;
begin
   { old }
  //result := StrToIntDef(s, FParam);

  { new }
  i := StrToIntDef(s, -1);
  if i > -1 then
    result := i
  else
    result := TFederUtils.StrToParamInt(s);

  if result < 1 then
    result := FParam;
end;

procedure TFederData2.SaveVirtual(ML: TStrings);
begin
  ML.Add(Format(fsd, [sVersion, 2]));

  ML.Add(Format(fsg, [sx1, x1]));
  ML.Add(Format(fsg, [sx2, x2]));
  ML.Add(Format(fsg, [sx3, x3]));
  ML.Add(Format(fsg, [sx4, x4]));

  ML.Add(Format(fsg, [sy1, y1]));
  ML.Add(Format(fsg, [sy2, y2]));
  ML.Add(Format(fsg, [sy3, y3]));
  ML.Add(Format(fsg, [sy4, y4]));

  ML.Add(Format(fsg, [sz1, z1]));
  ML.Add(Format(fsg, [sz2, z2]));
  ML.Add(Format(fsg, [sz3, z3]));
  ML.Add(Format(fsg, [sz4, z4]));

  ML.Add(Format(fsg, [sl1, l1]));
  ML.Add(Format(fsg, [sl2, l2]));
  ML.Add(Format(fsg, [sl3, l3]));
  ML.Add(Format(fsg, [sl4, l4]));

  ML.Add(Format(fsg, [sk1, k1]));
  ML.Add(Format(fsg, [sk2, k2]));
  ML.Add(Format(fsg, [sk3, k3]));
  ML.Add(Format(fsg, [sk4, k4]));

  ML.Add(Format(fsd, [sm1, m1]));
  ML.Add(Format(fsd, [sm2, m2]));
  ML.Add(Format(fsd, [sm3, m3]));
  ML.Add(Format(fsd, [sm4, m4]));

  ML.Add(Format(fsd, [sOffsetX, OffsetX]));
  ML.Add(Format(fsd, [sOffsetY, OffsetY]));
  ML.Add(Format(fsd, [sOffsetZ, OffsetZ]));

  ML.Add(Format(fss, [sMinusCap, BoolStr[MinusCap]]));
  ML.Add(Format(fss, [sOpacity, BoolStr[Opacity]]));
  ML.Add(Format(fss, [sBigmap, BoolStr[Bigmap]]));
  ML.Add(Format(fss, [sPin, BoolStr[Pin]]));
  ML.Add(Format(fss, [sNorm, BoolStr[Norm]]));
  ML.Add(Format(fsd, [sTextureNorm, TextureNorm]));

  ML.Add(Format(fsd, [sMeshSize, MeshSize]));
  ML.Add(Format(fsd, [sGain, Gain]));
  ML.Add(Format(fsd, [sCapValue, CapValue]));
  ML.Add(Format(fsd, [sAbsoluteRange, AbsoluteRange]));
  ML.Add(Format(fss, [sReducedMesh, BoolStr[ReducedMesh]]));
  ML.Add(Format(fss, [sPlusCap, BoolStr[PlusCap]]));

  ML.Add(Format(fsd, [sDim, Dim]));
  ML.Add(Format(fsd, [sDrawFigure, DrawFigure]));

  ML.Add(Format(fsd, [sScene, Scene]));
  ML.Add(Format(fsd, [sGraph, Graph]));
  ML.Add(Format(fsd, [sPlot, Plot]));
  ML.Add(Format(fsd, [sFigure, Figure]));
  ML.Add(Format(fsd, [sParam, Param]));

  ML.Add(Format(fsd, [sBitmap, Bitmap]));
  ML.Add(Format(fsd, [sColor, Color]));

  ML.Add(Format(fsf, [sAngleX, WrapAngleX]));
  ML.Add(Format(fsf, [sAngleY, WrapAngleY]));
  ML.Add(Format(fsf, [sAngleZ, WrapAngleZ]));
  ML.Add(Format(fsf, [sPosX, PosX]));
  ML.Add(Format(fsf, [sPosY, PosY]));
  ML.Add(Format(fsf, [sPosZ, PosZ]));

  ML.Add(Format(fsd, [sT1, T1]));
  ML.Add(Format(fsd, [sT2, T2]));
  ML.Add(Format(fsd, [sT3, T3]));
  ML.Add(Format(fsd, [sT4, T4]));

  ML.Add(Format(fsd, [sForceMode, ForceMode]));
  ML.Add(Format(fss, [sSolutionMode, BoolStr[SolutionMode]]));
  ML.Add(Format(fsd, [sPlotFigure, PlotFigure]));
  ML.Add(Format(fss, [sVorzeichen, BoolStr[Vorzeichen]]));
  ML.Add(Format(fss, [sGleich, BoolStr[Gleich]]));
  ML.Add(Format(fss, [sLinearForce, BoolStr[LinearForce]]));
  ML.Add(Format(fsd, [sSliceMode, SliceMode]));

  ML.Add(Format(fss, [sOpenMesh, BoolStr[OpenMesh]]));
  ML.Add(Format(fss, [sPolarMesh, BoolStr[PolarMesh]]));
  ML.Add(Format(fss, [sLinearMesh, BoolStr[LinearMesh]]));
  ML.Add(Format(fss, [sFuzzyMesh, BoolStr[FuzzyMesh]]));

  ML.Add(Format(fsf, [siv, IV]));
  ML.Add(Format(fsf, [siw, IW]));
  ML.Add(Format(fsf, [sjv, JV]));
  ML.Add(Format(fsf, [sjw, JW]));

  ML.Add(Format(fsf, [sParamBahnRadius, ParamBahnRadius]));
  ML.Add(Format(fsf, [sParamBahnPositionX, ParamBahnPositionX]));
  ML.Add(Format(fsf, [sParamBahnPositionY, ParamBahnPositionY]));
  ML.Add(Format(fsf, [sParamBahnAngle, ParamBahnAngle]));

  ML.Add(Format(fsf, [sParamBahnCylinderF, ParamBahnCylinderF]));
  ML.Add(Format(fsd, [sParamBahnCylinderD, ParamBahnCylinderD]));
  ML.Add(Format(fsd, [sParamBahnCylinderZ, ParamBahnCylinderZ]));

  ML.Add(Format(fss, [sShowGrid, BoolStr[ShowGrid]]));
  ML.Add(Format(fss, [sShowKugel, BoolStr[ShowKugel]]));
  ML.Add(Format(fss, [sShowCylinder, BoolStr[ShowCylinder]]));
  ML.Add(Format(fss, [sShowDiameter, BoolStr[ShowDiameter]]));
  ML.Add(Format(fsd, [sColorScheme3D, ColorScheme3D]));

  if Want2D then
  begin
    ML.Add(Format(fss, [sShowLB, BoolStr[ShowLB]]));
    ML.Add(Format(fss, [sShowLL, BoolStr[ShowLL]]));
    ML.Add(Format(fss, [sShowLC1, BoolStr[ShowLC1]]));
    ML.Add(Format(fss, [sShowLC2, BoolStr[ShowLC2]]));

    ML.Add(Format(fsf, [sNullpunktX, NullpunktX]));
    ML.Add(Format(fsf, [sNullpunktY, NullpunktY]));
    ML.Add(Format(fsf, [sPaintboxZoom, PaintboxZoom]));
    ML.Add(Format(fsf, [sPaintboxRotation, PaintboxRotation]));

    ML.Add(Format(fsd, [sColorScheme2D, ColorScheme2D]));
    ML.Add(Format(fsd, [sParamBahnStrokeWidth1, ParamBahnStrokeWidth1]));
    ML.Add(Format(fsd, [sParamBahnStrokeWidth2, ParamBahnStrokeWidth2]));
  end;

  ML.Add(Format(fss, [sLux, BoolStr[Lux]]));

  ML.Add(Format(fss, [sLux1, BoolStr[Lux1]]));
  ML.Add(Format(fsd, [sLux1X, Lux1X]));
  ML.Add(Format(fsd, [sLux1Y, Lux1Y]));
  ML.Add(Format(fsd, [sLux1Z, Lux1Z]));

  ML.Add(Format(fss, [sLux2, BoolStr[Lux2]]));
  ML.Add(Format(fsd, [sLux2X, Lux2X]));
  ML.Add(Format(fsd, [sLux2Y, Lux2Y]));
  ML.Add(Format(fsd, [sLux2Z, Lux2Z]));

  ML.Add(Format(fss, [sLux3, BoolStr[Lux3]]));
  ML.Add(Format(fsd, [sLux3X, Lux3X]));
  ML.Add(Format(fsd, [sLux3Y, Lux3Y]));
  ML.Add(Format(fsd, [sLux3Z, Lux3Z]));

  ML.Add(Format(fss, [sLux4, BoolStr[Lux4]]));
  ML.Add(Format(fsd, [sLux4X, Lux4X]));
  ML.Add(Format(fsd, [sLux4Y, Lux4Y]));
  ML.Add(Format(fsd, [sLux4Z, Lux4Z]));
end;

{ TFederData3 }

procedure TFederData3.LoadVirtual(ML: TStrings);
var
  i: Integer;
  b: Integer;
  s: string;
begin
  SLSampleData.Clear;
  SLAnimationData.Clear;
  b := 1;
  for i := 0 to ML.Count - 1 do
  begin
    s := ML[i];
    if TUtils.StartsWith(s, 'SampleData.Begin') then
    begin
      b := 1;
      Continue;
    end
    else if TUtils.StartsWith(s, 'SampleData.End') then
    begin
      b := 0;
      Continue;
    end
    else if TUtils.StartsWith(s, 'AnimationData.Begin') then
    begin
      b := 2;
      Continue;
    end
    else if TUtils.StartsWith(s, 'AnimationData.End') then
    begin
      //b := 0;
      Break;
    end;

    case b of
      1: SLSampleData.Add(s);
      2: SLAnimationData.Add(s);
    end;
  end;

  if SLSampleData.Count > 25 then
  begin
    inherited LoadVirtual(SLSampleData);
  end;

  if SLAnimationData.Count > 2 then
  begin
    Main.LoadAnimScript(SLAnimationData);
  end;
end;

end.
