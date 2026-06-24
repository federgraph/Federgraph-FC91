unit RiggVar.FB.Def;

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
  System.Math.Vectors,
  System.Generics.Collections,
  RiggVar.FB.ListArray,
  RiggVar.FB.DefConst;

{$I App\RiggVar.App.Defs.inc}

const
  BoolStr: array[Boolean] of string = ('False', 'True');
  BoolInt: array[Boolean] of Integer = (0, 1);
  BoolFloat: array[Boolean] of single = (0.0, 1.0);

type
  TSizeName = (
    ExtraSmall,
    Small,
    Medium,
    Large,
    ExtraLarge
  );

  TExportSelector = (
    AllParts,
    TopOnly,
    BottomOnly,
    NorthOnly,
    SouthOnly,
    WestOnly,
    EastOnly
  );

  TExportCoords = (
    Native,
    App_Blender,
    App_3D_Viewer,
    App_3D_Printer
  );

const
  SizeName: array[TSizeName] of string = ('XS', 'S', 'M',  'L', 'XL');

type
  TConnectionStatus = (csRed, csYellow, csGreen);

{$ifdef OriginalFMX}
  TViewType = (Perspective, Orthographic);
{$endif}

  TGuiAction = (
    gaAnimationStop,
    gaConnectionStatus
  );

  TFederMessageValue = (
    fmvNone,
    fmvActionReset,
    fmvActionExecute,
    fmvMessageValue,
    fmvParamValue,
    fmvActionDownload,
    fmvActionPlay
  );

  TFederMessageType = (
    fmtInt,
    fmtDouble,
    fmtBool
  );

  TBandWidthOption = (
    bwAbsolute,
    bwRelative,
    bwContour
  );

  TLineRec = record
  public
    constructor Create(x1, y1, x2, y2: single); overload;
    constructor Create(PA, PB: TPointF); overload;
    case Integer of
      0: (Left, Top, Right, Bottom: Single);
      1: (TopLeft, BottomRight: TPointF);
      2: (StartPoint, EndPoint: TPointF);
  end;

  TPlotData = record
  public
    PlotArea: TRectF;
    CPA: TPointF; // center point A
    CPB: TPointF;
    CPC: TPointF;
    RA, RB, RC: single;
    HL: TRectF; // Horzontal Line Data, Left-Right
    VL: TRectF; // Vertical Line Data, Top-Bottom
  end;

  TPolygonListArray = class(TListArray<TPointF>)
  private
    function GetPolygon: TPolygon;
  public
    procedure UpdateLength(NewCount: Integer);
    property Polygon: TPolygon read GetPolygon;
  end;

  TPolyCurve = record
  public
    AZ: single;
    Mode: Integer;
    CurveSet: Integer;
    CurveNo: Integer;
    Color: TAlphaColor;
    Poly: TPolygonListArray;
    function TrimPoly(ATrimDistance: single = 4.0): Integer;
    function GetPolygon: TPolygon;
    function GetMirrorPolygon: TPolygon;
    property Polygon: TPolygon read GetPolygon;
    property MirrorPolygon: TPolygon read GetMirrorPolygon;
  end;

  TPolygun = record
  public
    Line: TLineRec;
    Color: TAlphaColor;
    Width: single;
  end;

  TPoint3DArray = array of TPoint3D;
  TPolyCurveArray = TArray<TPolyCurve>;
  TPolygunArray = TArray<TPolygun>;
  TPolygonArray = TArray<TPolygon>;
  TPolygunList = TList<TPolygun>;
  TPolygonList = TList<TPolygon>;
  TIntegerList = TList<Integer>;

  TFederMessageKind = (
    fmkNoop,
    fmkAction,
    fmkParam,
    fmkParamValue,

    fmkPalCol,

    fmkAnimNewStory,
    fmkAnimNewEntry,
    fmkAnimParam,
    fmkAnimStartValue,
    fmkAnimStopValue,
    fmkAnimGO,
    fmkAnimAT,
    fmkAnimIT,
    fmkAnimDU,
    fmkAnimAR,
    fmkAnimLP,
    fmkAnimFC,

    fmkTX,
    fmkTY,
    fmkRX,
    fmkRY,
    fmkRZ,
    fmkCZ,

    fmkX1,
    fmkY1,
    fmkX2,
    fmkY2,
    fmkX3,
    fmkY3,
    fmkX4,
    fmkY4,

    fmkX12,
    fmkY12,
    fmkZ12,

    fmkSW,
    fmkBW,
    fmkDW,

    fmkScene,
    fmkGraph,
    fmkPlot,
    fmkFigure,
    fmkBitmap,
    fmkColor,

    fmkMinusCap,
    fmkPlusCap,
    fmkOpacity,
    fmkBigmap,
    fmkMeshSize,
    fmkLevel,
    fmkHub,
    fmkSample,

    fmkParallelX1,
    fmkParallelX2,
    fmkParallelX3,
    fmkParallelX4,

    fmkParallelY1,
    fmkParallelY2,
    fmkParallelY3,
    fmkParallelY4,

    fmkParallelZ,
    fmkParallelZ1,
    fmkParallelZ2,
    fmkParallelZ3,
    fmkParallelZ4,

    fmkParallelL,
    fmkParallelL1,
    fmkParallelL2,
    fmkParallelL3,
    fmkParallelL4,

    fmkParallelK,
    fmkParallelK1,
    fmkParallelK2,
    fmkParallelK3,
    fmkParallelK4,

    fmkParallelOX,
    fmkParallelOY,
    fmkParallelOZ,

    fmkParallelT,
    fmkParallelT1,
    fmkParallelT2,
    fmkParallelT3,
    fmkParallelT4,

    fmkParallelORX,
    fmkParallelORY,
    fmkParallelORZ,
    fmkParallelX12,
    fmkParallelY12,
    fmkParallelZ12,

    fmkParallelTRX,
    fmkParallelTRY,
    fmkParallelTRT,
    fmkParallelTRS,

    fmkParallelGain,
    fmkParallelLimit,
    fmkParallelRange,

    fmkParallelAttenuation,
    fmkParallelAbsoluteRange,
    fmkParallelCapValue,

    fmkParallelRX,
    fmkParallelRY,
    fmkParallelRZ,
    fmkParallelCZ,
    fmkParallelSW,
    fmkParallelBW,
    fmkParallelDW,

    fmkParallelSample,
    fmkParallelHub,
    fmkParallelColor,

    fmkM1,
    fmkM2,
    fmkM3,
    fmkM4,

    fmkForceMode,
    fmkSolutionMode,
    fmkPlotFigure,
    fmkDrawFigure,
    fmkVorzeichen,
    fmkOpenMesh,
    fmkPolarMesh,
    fmkLinearMesh,
    fmkFuzzyMesh,
    fmkFilterMesh,
    fmkReducedMesh,
    fmkHullMesh,
    fmkInvertedMesh,
    fmkUprightMesh,
    fmkFlippedTexture,

    fmkDim,
    fmkGleich,

    fmkEulerX,
    fmkEulerY,
    fmkEulerZ

  );

  TFederParam = (
    fpDiscreteValue,

    fpx1,
    fpx2,
    fpx3,
    fpx4,

    fpy1,
    fpy2,
    fpy3,
    fpy4,

    fpZ,
    fpz1,
    fpz2,
    fpz3,
    fpz4,

    fpL,
    fpl1,
    fpl2,
    fpl3,
    fpl4,

    fpK,
    fpk1,
    fpk2,
    fpk3,
    fpk4,

    fpox,
    fpoy,
    fpoz,

    fpAttenuation,
    fpGrenze,
    fpRange,
    fpAbsoluteRange,

    fpT,
    fpt1,
    fpt2,
    fpt3,
    fpt4,

    fptrx,
    fptry,
    fptrt,
    fptrs,

    fprx,
    fpry,
    fprz,

    fptx,
    fpty,
    fpcz,

    fph, //Hub
    fps, //Sample
    fppa, //Parallel Animation

    fppx,
    fppy,

    fp0,
    fp1,
    fp2,
    fp3,
    fp4,
    fp5,
    fp6,
    fp7,
    fp8,
    fp9,

    fpbpr,
    fpbpx,
    fpbpy,
    fpbpa,
    fpbs1,
    fpbs2,
    fpbcf,
    fpbcd,
    fpbcz,

    fpl1x,
    fpl1y,
    fpl1z,

    fpl2x,
    fpl2y,
    fpl2z,

    fpl3x,
    fpl3y,
    fpl3z,

    fpl4x,
    fpl4y,
    fpl4z,
    fpkw,
    fpmz,

    fpBandSelected,

    fpBandCount,
    fpBandDistributionX,
    fpBandDistributionY,

    fpBandWidth,

    fpLabelTextX,
    fpLabelTextY,
    fpLabelTextZ,

    fpPan,

    fpController,
    fpWinkel,
    fpVorstag,
    fpWante,
    fpWoben,
    fpSalingH,
    fpSalingA,
    fpSalingL,
    fpSalingW,
    fpMastfallF0C,
    fpMastfallF0F,
    fpMastfallVorlauf,
    fpBiegung,
    fpD0X,

    fpx12,
    fpy12,
    fpz12,

    fpParamCapValue,
    fpNorthCapValue,
    fpSouthCapValue,
    fpEastCapValue,
    fpWestCapValue,

    fpParamY3f,
    fpParamL3f,
    fpParamLf,

    fpCoord0,
    fpCoord1,
    fpCoord2,
    fpCoord3,

    fpFresnelR0,
    fpRoughness,

    fpSpotPower,
    fpFalloffStart,
    fpFalloffEnd,
    fpLightStrength,
    fpSpecPower,
    fpOpacity,

    fpEmisLight,
    fpAmbiLight,
    fpDiffLight,
    fpSpecLight,

    fpParamMatEmis,
    fpParamMatAmbi,
    fpParamMatDiff,
    fpParamMatSpec,
    fpParamMatShin,
    fpParamLitCutt,
    fpParamLitExpo,
    fpParamLitDiff,
    fpParamLitSpec,
    fpParamLitColR,
    fpParamLitColG,
    fpParamLitColB,
    fpParamLitPosX,
    fpParamLitPosY,
    fpParamLitPosZ,
    fpParamLitDirX,
    fpParamLitDirY,
    fpParamLitDirZ,
    fpParamLitAttX,
    fpParamLitAttY,
    fpParamLitAttZ,

    fpParamEggX,
    fpParamEggZ,

    fpUnknown
  );

  TTrackingEvent = procedure(k: TFederParam; v: Integer) of object;
  TAbsoluteEvent = procedure(k: TFederParam; v: Integer) of object;
  TRelativeEvent = procedure(k: TFederMessageKind; v: Integer) of object;
  TRecorderEvent = procedure(k: string; v: Integer) of object;
  TMessageEvent = procedure(s: string) of object;

  TFederUtils = class
  public
    class function StrToParamInt(s: string): Integer;
    class function StrToParamIndex(s: string): Integer;
    class function StrToColorIndex(s: string): Integer;

    class function GetParamCaption(fp: TFederParam): string;
    class function GetParamInt(fp: TFederParam): Integer;
    class function GetParamIndex(fp: TFederParam): Integer;
    class function IsViewParam(fp: TFederParam): Boolean; overload;
    class function IsViewParam(fp: Integer): Boolean; overload;
    class function GetFederParam(idx: Integer): TFederParam;
    class function IsRggParam(fp: Integer): Boolean; overload;

    class function IsDiscreteParam(fmk: TFederMessageKind): Boolean;
    class function GetMessageKindInt(fmk: TFederMessageKind): Integer;
    class function GetMessageKindString(mk: TFederMessageKind): string;
    class function GetMessageKindLabel(mk: TFederMessageKind): string;

    class function StrToParallelMK(s: string): TFederMessageKind; static;
    class function GetParallelMK(fp: TFederParam): TFederMessageKind;
  end;

  TFederMeshType =
  (
    fmtLinearK,
    fmtLinearP,
    fmtNonlinearK,
    fmtNonlinearP,
    fmtFilteredK
  );

implementation

uses
  RiggVar.FB.ParamDef;

{ TFederUtils }

class function TFederUtils.StrToColorIndex(s: string): Integer;
var
  c: char;
begin
  if s = '' then
    result := 0
  else
  begin
    c := LowerCase(s)[1];
    if c = 'w' then
      result := 0 //white
    else if c = 'r' then
      result := 1 //red
    else if c = 'g' then
      result := 2 //green
    else if c = 'b' then
      result := 3 //blue
    else if c = 'm' then
      result := 4 //magenta
    else if c = 'c' then
      result := 5 //cyan
    else if c = 'y' then
      result := 6 //yellow
    else
      result := 0;
  end;
end;

class function TFederUtils.StrToParamInt(s: string): Integer;
var
  fp: TFederParam;
begin
  result := 0;
  for fp := Low(TFederParam) to High(TFederParam) do
    if Lowercase(GetParamCaption(fp)) = Lowercase(s) then
    begin
      result := GetParamIndex(fp);
      break;
    end;
end;

class function TFederUtils.StrToParamIndex(s: string): Integer;
begin
  if s = 'x' then
    result := GetParamIndex(fprx)
  else if s = 'y' then
    result := GetParamIndex(fpry)
  else if s = 'z' then
    result := GetParamIndex(fpcz)
  else
    result := StrToParamInt(s);
end;

class function TFederUtils.StrToParallelMK(s: string): TFederMessageKind;
begin
  result := fmkNoop;

  if s = cParallelX1 then
    result := fmkParallelX1
  else if s = cParallelX2 then
    result := fmkParallelX2
  else if s = cParallelX3 then
    result := fmkParallelX3
  else if s = cParallelX4 then
    result := fmkParallelX4
  else if s = cParallelX12 then
    result := fmkParallelX12

  else if s = cParallelY1 then
    result := fmkParallelY1
  else if s = cParallelY2 then
    result := fmkParallelY2
  else if s = cParallelY3 then
    result := fmkParallelY3
  else if s = cParallelY4 then
    result := fmkParallelY4
  else if s = cParallelY12 then
    result := fmkParallelY12

  else if s = cParallelZ then
    result := fmkParallelZ
  else if s = cParallelZ1 then
    result := fmkParallelZ1
  else if s = cParallelZ2 then
    result := fmkParallelZ2
  else if s = cParallelZ3 then
    result := fmkParallelZ3
  else if s = cParallelZ4 then
    result := fmkParallelZ4
  else if s = cParallelZ12 then
    result := fmkParallelZ12

  else if s = cParallelL then
    result := fmkParallelL
  else if s = cParallelL1 then
    result := fmkParallelL1
  else if s = cParallelL2 then
    result := fmkParallelL2
  else if s = cParallelL3 then
    result := fmkParallelL3
  else if s = cParallelL4 then
    result := fmkParallelL4

  else if s = cParallelK then
    result := fmkParallelK
  else if s = cParallelK1 then
    result := fmkParallelK1
  else if s = cParallelK2 then
    result := fmkParallelK2
  else if s = cParallelK3 then
    result := fmkParallelK3
  else if s = cParallelK4 then
    result := fmkParallelK4

  else if s = cParallelOX then
    result := fmkParallelOX
  else if s = cParallelOY then
    result := fmkParallelOY
  else if s = cParallelOZ then
    result := fmkParallelOZ

  else if s = cParallelRX then
    result := fmkParallelRX
  else if s = cParallelRY then
    result := fmkParallelRY
  else if s = cParallelRZ then
    result := fmkParallelRZ
  else if s = cParallelCZ then
    result := fmkParallelCZ
  else if s = cParallelSW then
    result := fmkParallelSW
  else if s = cParallelBW then
    result := fmkParallelBW
  else if s = cParallelDW then
    result := fmkParallelDW

  else if s = cParallelT then
    result := fmkParallelT
  else if s = cParallelT1 then
    result := fmkParallelT1
  else if s = cParallelT2 then
    result := fmkParallelT2
  else if s = cParallelT3 then
    result := fmkParallelT3
  else if s = cParallelT4 then
    result := fmkParallelT4

  else if s = cParallelGain then
    result := fmkParallelGain
  else if s = cParallelLimit then
    result := fmkParallelLimit
  else if s = cParallelRange then
    result := fmkParallelRange

  else if s = cParallelAttenuation then
    result := fmkParallelAttenuation
  else if s = cParallelAbsoluteRange then
    result := fmkParallelAbsoluteRange
  else if s = cParallelCapValue then
    result := fmkParallelCapValue
end;

class function TFederUtils.GetParallelMK(fp: TFederParam): TFederMessageKind;
var
  mk: TFederMessageKind;
begin
  case fp of
    fpDiscreteValue: mk := fmkNoop;

    fpx1: mk := fmkParallelX1;
    fpx2: mk := fmkParallelX2;
    fpx3: mk := fmkParallelX3;
    fpx4: mk := fmkParallelX4;

    fpy1: mk := fmkParallelY1;
    fpy2: mk := fmkParallelY2;
    fpy3: mk := fmkParallelY3;
    fpy4: mk := fmkParallelY4;

    fpz: mk := fmkParallelZ;
    fpz1: mk := fmkParallelZ1;
    fpz2: mk := fmkParallelZ2;
    fpz3: mk := fmkParallelZ3;
    fpz4: mk := fmkParallelZ4;

    fpL: mk := fmkParallelL;
    fpl1: mk := fmkParallelL1;
    fpl2: mk := fmkParallelL2;
    fpl3: mk := fmkParallelL3;
    fpl4: mk := fmkParallelK4;

    fpK: mk := fmkParallelK;
    fpk1: mk := fmkParallelK1;
    fpk2: mk := fmkParallelK2;
    fpk3: mk := fmkParallelK3;
    fpk4: mk := fmkParallelK4;

    fpox: mk := fmkParallelOX;
    fpoy: mk := fmkParallelOY;
    fpoz: mk := fmkParallelOZ;

    fpT: mk := fmkParallelT;
    fpt1: mk := fmkParallelT1;
    fpt2: mk := fmkParallelT2;
    fpt3: mk := fmkParallelT3;
    fpt4: mk := fmkParallelT4;

    fpAttenuation: mk := fmkParallelAttenuation;
    fpAbsoluteRange: mk := fmkParallelAbsoluteRange;
    fpParamCapValue: mk := fmkParallelCapValue;

    fpGrenze: mk := fmkParallelLimit;
    fpRange: mk := fmkParallelRange;

    fptrx: mk := fmkParallelTRX;
    fptry: mk := fmkParallelTRY;
    fptrt: mk := fmkParallelTRT;
    fptrs: mk := fmkParallelTRS;
    fprx: mk := fmkRX;
    fpry: mk := fmkRY;
    fprz: mk := fmkRZ;

    fptx: mk := fmkTX;
    fpty: mk := fmkTY;
    fpcz: mk := fmkCZ;

    fps: mk := fmkNoop;
    fppa: mk := fmkNoop;

    fpx12: mk := fmkParallelX12;
    fpy12: mk := fmkParallelY12;
    fpz12: mk := fmkParallelZ12;

    fpUnknown: mk := fmkNoop;
    else
      mk := fmkNoop;
  end;
  result := mk;
end;

class function TFederUtils.IsDiscreteParam(fmk: TFederMessageKind): Boolean;
begin
  case fmk of
    fmkScene,
    fmkGraph,
    fmkPlot,
    fmkFigure,
    fmkBitmap,
    fmkColor,
    fmkMinusCap,
    fmkPlusCap,
    fmkOpacity,
    fmkBigmap,
    fmkMeshSize,
    fmkAction,
    fmkLevel,
    fmkHub,
    fmkSample: result := True;

    fmkM1,
    fmkM2,
    fmkM3,
    fmkM4: result := True;

    fmkForceMode,
    fmkSolutionMode,
    fmkPlotFigure,
    fmkDrawFigure,
    fmkVorzeichen,
    fmkOpenMesh,
    fmkPolarMesh,
    fmkLinearMesh,
    fmkFuzzyMesh,
    fmkFilterMesh,
    fmkReducedMesh,
    fmkHullMesh,
    fmkInvertedMesh,
    fmkUprightMesh,
    fmkFlippedTexture,
    fmkDim,
    fmkGleich: result := True;

    fmkParallelSample,
    fmkParallelHub,
    fmkParallelColor: result := True;

    else
      result := False;
  end;
end;

class function TFederUtils.IsRggParam(fp: Integer): Boolean;
begin
  result := TFederParam(fp) in [fpController .. fpD0X];
end;

class function TFederUtils.IsViewParam(fp: Integer): Boolean;
begin
  result := IsViewParam(GetFederParam(fp));
end;

class function TFederUtils.IsViewParam(fp: TFederParam): Boolean;
begin
  case fp of
    fprx,
    fpry,
    fprz,
    fptx,
    fpty,
    fpcz,
    fppx,
    fppy: result := True;

    else
      result := false;
  end;
end;

class function TFederUtils.GetFederParam(idx: Integer): TFederParam;
var
  j: SmallInt;
begin
  j := Integer(High(TFederParam));
  if idx > j then
    result := fpUnknown
  else if idx < 0 then
    result := fpUnknown
  else
  begin
    result := TFederParamDef.Decode(idx);
  end;
end;

class function TFederUtils.GetParamInt(fp: TFederParam): Integer;
begin
  result := TFederParamDef.Encode(fp);
end;

class function TFederUtils.GetParamIndex(fp: TFederParam): Integer;
begin
  result := GetParamInt(fp) - 1;
end;

class function TFederUtils.GetMessageKindInt(fmk: TFederMessageKind): Integer;
begin
  result := Integer(fmk);
end;

class function TFederUtils.GetMessageKindString(mk: TFederMessageKind): string;
begin
  case mk of
    fmkNoop: result := cNoop;
    fmkAction: result := cAction;
    fmkPalCol: result := cPalCol;
    fmkParam: result := cParam;
    fmkParamValue: result := cParamValue;

    fmkAnimNewStory: result := cAnimNewStory;
    fmkAnimNewEntry: result := cAnimNewEntry;
    fmkAnimParam: result := cAnimParam;
    fmkAnimStartValue: result := cAnimStartValue;
    fmkAnimStopValue: result := cAnimStopValue;
    fmkAnimGO: result := cAnimGO;
    fmkAnimAT: result := cAnimAnimationType;
    fmkAnimIT: result := cAnimInterpolationType;
    fmkAnimDU: result := cAnimDuration;
    fmkAnimAR: result := cAnimAutoReverse;
    fmkAnimLP: result := cAnimLoop;
    fmkAnimFC: result := cAnimFromCurrent;

    fmkTX: result := cTX;
    fmkTY: result := cTY;
    fmkRX: result := cRX;
    fmkRY: result := cRY;
    fmkRZ: result := cRZ;
    fmkCZ: result := cCZ;

    fmkX1: result := cX1;
    fmkY1: result := cY1;
    fmkX2: result := cX2;
    fmkY2: result := cY2;
    fmkX3: result := cX3;
    fmkY3: result := cY3;
    fmkX4: result := cX4;
    fmkY4: result := cY4;

    fmkX12: result := cx12;
    fmkY12: result := cy12;
    fmkZ12: result := cz12;

    fmkScene: result := cScene;
    fmkGraph: result := cGraph;
    fmkPlot: result := cPlot;
    fmkFigure: result := cFigure;
    fmkBitmap: result := cBitmap;
    fmkColor: result := cColor;

    fmkMinusCap: result := cMinusCap;
    fmkPlusCap: result := cPlusCap;
    fmkOpacity: result := cOpacity;
    fmkBigmap: result := cBigmap;
    fmkMeshSize: result := cMeshSize;
    fmkLevel: result := cLevel;
    fmkHub: result := cHub;
    fmkSample: result := cSample;

    fmkParallelX1: result := cParallelX1;
    fmkParallelX2: result := cParallelX2;
    fmkParallelX3: result := cParallelX3;
    fmkParallelX4: result := cParallelX4;
    fmkParallelX12: result := cParallelX12;

    fmkParallelY1: result := cParallelY1;
    fmkParallelY2: result := cParallelY2;
    fmkParallelY3: result := cParallelY3;
    fmkParallelY4: result := cParallelY4;
    fmkParallelY12: result := cParallelY12;

    fmkParallelZ: result := cParallelZ;
    fmkParallelZ1: result := cParallelZ1;
    fmkParallelZ2: result := cParallelZ2;
    fmkParallelZ3: result := cParallelZ3;
    fmkParallelZ4: result := cParallelZ4;
    fmkParallelZ12: result := cParallelZ12;

    fmkParallelL: result := cParallelL;
    fmkParallelL1: result := cParallelL1;
    fmkParallelL2: result := cParallelL2;
    fmkParallelL3: result := cParallelL3;
    fmkParallelL4: result := cParallelL4;

    fmkParallelK: result := cParallelK;
    fmkParallelK1: result := cParallelK1;
    fmkParallelK2: result := cParallelK2;
    fmkParallelK3: result := cParallelK3;
    fmkParallelK4: result := cParallelK4;

    fmkParallelOX: result := cParallelOX;
    fmkParallelOY: result := cParallelOY;
    fmkParallelOZ: result := cParallelOZ;

    fmkParallelRX: result := cParallelRX;
    fmkParallelRY: result := cParallelRY;
    fmkParallelRZ: result := cParallelRZ;
    fmkParallelCZ: result := cParallelCZ;
    fmkParallelSW: result := cParallelSW;
    fmkParallelBW: result := cParallelBW;
    fmkParallelDW: result := cParallelDW;

    fmkParallelT: result := cParallelT;
    fmkParallelT1: result := cParallelT1;
    fmkParallelT2: result := cParallelT2;
    fmkParallelT3: result := cParallelT3;
    fmkParallelT4: result := cParallelT4;

    fmkParallelGain: result := cParallelGain;
    fmkParallelLimit: result := cParallelLimit;
    fmkParallelRange: result := cParallelRange;

    fmkParallelAttenuation: result := cParallelAttenuation;
    fmkParallelAbsoluteRange: result := cParallelAbsoluteRange;
    fmkParallelCapValue: result := cParallelCapValue;

    fmkParallelSample: result := cParallelSample;
    fmkParallelHub: result := cParallelHub;
    fmkParallelColor: result := cParallelColor;

    fmkM1: result := cm1;
    fmkM2: result := cm2;
    fmkM3: result := cm3;
    fmkM4: result := cm4;

    fmkForceMode: result := cForceMode;
    fmkSolutionMode: result := cSolutionMode;
    fmkPlotFigure: result := cPlotFigure;
    fmkDrawFigure: result := cDrawFigure;
    fmkVorzeichen: result := cVorzeichen;
    fmkOpenMesh: result := cOpenMesh;
    fmkPolarMesh: result := cPolarMesh;
    fmkLinearMesh: result := cLinearMesh;
    fmkFuzzyMesh: result := cFuzzyMesh;
    fmkFilterMesh: result := cFilterMesh;
    fmkReducedMesh: result := cReducedMesh;
    fmkHullMesh: result := cHullMesh;
    fmkInvertedMesh: result := cInvertedMesh;
    fmkUprightMesh: result := cUprightMesh;
    fmkFlippedTexture: result := cFlippedTexture;
    fmkDim: result := cDim;
    fmkGleich: result := cGleich;

    fmkEulerX: result := cEulerX;
    fmkEulerY: result := cEulerY;
    fmkEulerZ: result := cEulerZ;

    fmkParallelORX: result := cParallelORX;
    fmkParallelORY: result := cParallelORY;
    fmkParallelORZ: result := cParallelORZ;

  end;
end;

class function TFederUtils.GetMessageKindLabel(mk: TFederMessageKind): string;
begin
  case mk of
    fmkNoop: result := 'NO';

    fmkLevel: result := 'LE';
    fmkHub: result := 'HU';
    fmkSample: result := 'SA';

    fmkMeshSize: result := 'MS';

    fmkScene: result := 'SC';
    fmkGraph: result := 'GR';
    fmkPlot: result := 'PL';
    fmkFigure: result := 'FI';
    fmkBitmap: result := 'BM';
    fmkColor: result := 'CL';
    fmkParam: result := 'PA';
    fmkPlotFigure: result := 'PF';
    fmkDrawFigure: result := 'DF';

    fmkDim: result := 'DI';
    else
      result := '--'
  end;
end;

class function TFederUtils.GetParamCaption(fp: TFederParam): string;
begin
  case fp of
    fpL: result := 'L';
    fpl1: result := cl1;
    fpl2: result := cl2;
    fpl3: result := cl3;
    fpl4: result := cl4;

    fpK: result := 'K';
    fpk1: result := ck1;
    fpk2: result := ck2;
    fpk3: result := ck3;
    fpk4: result := ck4;

    fpox: result := 'ox';
    fpoy: result := 'oy';
    fpoz: result := 'oz';

    fpx1: result := cx1;
    fpx2: result := cx2;
    fpx3: result := cx3;
    fpx4: result := cx4;

    fpy1: result := cy1;
    fpy2: result := cy2;
    fpy3: result := cy3;
    fpy4: result := cy4;

    fpz: result := 'Z';
    fpz1: result := cz1;
    fpz2: result := cz2;
    fpz3: result := cz3;
    fpz4: result := cz4;

    fpAttenuation: result := 'A';
    fpGrenze: result := 'G';
    fpRange: result := 'R';
    fpAbsoluteRange: result := 'AR';

    fpT: result := 'T';
    fps: result := 's';

    fpt1: result := 't1';
    fpt2: result := 't2';
    fpt3: result := 't3';
    fpt4: result := 't4';

    fptrt: result := 'trt';
    fptrx: result := 'trx';
    fptry: result := 'try';
    fptrs: result := 'trs';

    fprx: result := cRX;
    fpry: result := cRY;
    fprz: result := cRZ;
    fptx: result := cTX;
    fpty: result := cTY;
    fpcz: result := cCZ;
    fppa: result := cPA;

    fppx: result := cpx;
    fppy: result := cpy;

    fp0: result := cp0;
    fp1: result := cp1;
    fp2: result := cp2;
    fp3: result := cp3;
    fp4: result := cp4;
    fp5: result := cp5;
    fp6: result := cp6;
    fp7: result := cp7;
    fp8: result := cp8;
    fp9: result := cp9;

    fpbpr: result := cbpr;
    fpbpx: result := cbpx;
    fpbpy: result := cbpy;
    fpbpa: result := cbpa;
    fpbs1: result := cbs1;
    fpbs2: result := cbs2;
    fpbcf: result := cbpf;
    fpbcd: result := cbpd;
    fpbcz: result := cbpz;

    fpl1x: result := cl1x;
    fpl1y: result := cl1y;
    fpl1z: result := cl1z;

    fpl2x: result := cl2x;
    fpl2y: result := cl2y;
    fpl2z: result := cl2z;

    fpl3x: result := cl3x;
    fpl3y: result := cl3y;
    fpl3z: result := cl3z;

    fpl4x: result := cl4x;
    fpl4y: result := cl4y;
    fpl4z: result := cl4z;
    fpkw: result := clkw;
    fpmz: result := clmz;

    fpBandSelected: result := cParamBandSelected;

    fpBandCount: result := cParamBandCount;
    fpBandDistributionX: result := cParamBandDistributionX;
    fpBandDistributionY: result := cParamBandDistributionY;
    fpBandWidth: result := cParamBandWidth;

    fpLabelTextX: result := cParamLabelTextX;
    fpLabelTextY: result := cParamLabelTextY;
    fpLabelTextZ: result := cParamLabelTextZ;

    fpPan: result := cPan;

    fpVorstag..fpD0X: result := 'rgg';

    fpx12: result := cx12;
    fpy12: result := cy12;
    fpz12: result := cz12;

    fpParamY3f: result := 'y3f';
    fpParamL3f: result := 'l3f';
    fpParamLf: result := 'Lf';

    fpCoord0: result := 'oo0';
    fpCoord1: result := 'oo1';
    fpCoord2: result := 'oo2';
    fpCoord3: result := 'oo3';

    fpParamCapValue: result := 'pcv';
    fpNorthCapValue: result := 'ncv';
    fpSouthCapValue: result := 'scv';
    fpEastCapValue: result := 'ecv';
    fpWestCapValue: result := 'wcv';

    fpFresnelR0: result := 'fro';
    fpRoughness: result := 'rou';

    fpSpotPower: result := 'spo';
    fpFalloffStart: result := 'fos';
    fpFalloffEnd: result := 'foe';
    fpLightStrength: result := 'lco';

    fpSpecPower: result := 'spe';
    fpOpacity: result := 'opa';

    fpEmisLight: result := 'eli';
    fpAmbiLight: result := 'ali';
    fpDiffLight: result := 'dli';
    fpSpecLight: result := 'sli';

    fpParamMatEmis: result := 'maE';
    fpParamMatAmbi: result := 'maA';
    fpParamMatDiff: result := 'maD';
    fpParamMatSpec: result := 'maS';
    fpParamMatShin: result := 'maR';
    fpParamLitCutt: result := 'liC';
    fpParamLitExpo: result := 'liE';
    fpParamLitDiff: result := 'liD';
    fpParamLitSpec: result := 'liS';
    fpParamLitColR: result := 'liR';
    fpParamLitColG: result := 'liG';
    fpParamLitColB: result := 'liB';
    fpParamLitPosX: result := 'liX';
    fpParamLitPosY: result := 'liY';
    fpParamLitPosZ: result := 'liZ';
    fpParamLitDirX: result := 'liU';
    fpParamLitDirY: result := 'liV';
    fpParamLitDirZ: result := 'liW';
    fpParamLitAttX: result := 'laX';
    fpParamLitAttY: result := 'laY';
    fpParamLitAttZ: result := 'laZ';
    fpParamEggX: result := 'epX';
    fpParamEggZ: result := 'epZ';

    else
      result := 'ukn';
  end;
end;

{ TLineRec }

constructor TLineRec.Create(x1, y1, x2, y2: single);
begin
  StartPoint := TPointF.Create(x1, y1);
  EndPoint := TPointF.Create(x2, y2);
end;

constructor TLineRec.Create(PA, PB: TPointF);
begin
  StartPoint := PA;
  EndPoint := PB;
end;

{ TPolyCurve }

function TPolyCurve.TrimPoly(ATrimDistance: single): Integer;
var
  i, j: Integer;
  d: single;
  minD: single;
  P1, P2: TPointF;
  pc: Integer; // purgeCount
begin
  i := 0;
  j := 2;
  minD := ATrimDistance;
  pc := 0;
  while (j < Poly.Count) do
  begin
    P1 := Poly[i];
    P2 := Poly[j];
    d := P1.Distance(P2);
    if (d < minD) then
    begin
      Poly.Delete(j-1);
      Inc(pc);
    end
    else
    begin
      Inc(i);
      Inc(j);
    end;
  end;
  result := pc;
end;

function TPolyCurve.GetPolygon: TPolygon;
var
  i: Integer;
begin
  SetLength(result, Poly.Count);
  for i := 0 to Poly.Count - 1 do
    result[i] := Poly[i];
end;

function TPolyCurve.GetMirrorPolygon: TPolygon;
var
  i: Integer;
begin
  SetLength(result, Poly.Count);
  for i := 0 to Poly.Count - 1 do
  begin
    result[i] := Poly[i];
    result[i].X := -result[i].X;
  end;
end;

{ TPolygonListArray }

function TPolygonListArray.GetPolygon: TPolygon;
var
  i: Integer;
begin
  SetLength(result, Count);
  for i := 0 to Count - 1 do
    result[i] := Self[i];
end;

procedure TPolygonListArray.UpdateLength(NewCount: Integer);
begin
  while (Count < NewCount) do
  begin
    Add(TPoint.Zero);
  end;
  while (Count > 0) and (Count > NewCount) do
  begin
    Delete(Count - 1);
  end;
end;

end.
