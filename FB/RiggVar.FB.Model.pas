unit RiggVar.FB.Model;

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
  System.Math.Vectors,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Classes,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Equation;

type
  TFederModelEQBase = class
  public
    EQ: TFederEquation;
    EQIndex: Integer;
    constructor Create;
    destructor Destroy; override;
    procedure SwapEQ(newEQIndex: Integer); virtual;
  end;

  TFederModel = class
  private
    FederModelEQ: TFederModelEQBase;

    { not persisted }
    SL: TStringList;
    SB: TStringBuilder;
    FLoading: Boolean;

    FParamValueOld: single;
    FParamValue: single;
    FParamChanged: Boolean;
    FParamDiff: single;
    FParamDiffRef: single;

    FActive: Boolean;
    FResolution: Integer;

    { persisted }

    FScene: Integer;
    FGraph: Integer;
    FPlot: Integer;
    FFigure: Integer;

    FMeshSize: Integer;
    FParam: Integer;

    FPin: Boolean;
    FNorm: Boolean;
    FTextureNorm: Integer;
    FMinusCap: Boolean;
    FPlusCap: Boolean;
    FBigMap: Boolean;
    FOnInitData: TNotifyEvent;
    FVorzeichen: Boolean;
    FPlotFigure: Integer;
    FDim: Integer;
    FForceMode: Integer;
    FSolutionMode: Boolean;

    FLineFigure: Integer;
    FScanFigure: Integer;
    FDrawFigure: Integer;

    vp1, vp2, vp3, vp4: TPoint3D;
    vp5, vp6, vp7, vp8: TPoint3D;

    procedure InitScene;
    procedure InitParamValue;

    function HandleAsViewParam(const Value: single): Boolean;

    procedure SetOnInitData(const Value: TNotifyEvent);

    procedure SetOffsetX(const Value: single);
    procedure SetOffsetY(const Value: single);
    procedure SetOffsetZ(const Value: single);

    procedure SetAbsoluteRange(const mmRange: single);
    procedure SetRange(const Value: single);
    procedure SetAttenuation(const Value: single);
    procedure SetLimit(const Value: single);
    procedure SetNorth(const Value: single);
    procedure SetSouth(const Value: single);
    procedure SetEast(const Value: single);
    procedure SetWest(const Value: single);

    procedure SetMinusCap(const Value: Boolean);
    procedure SetPlusCap(const Value: Boolean);

    procedure SetScene(const Value: Integer);
    procedure SetGraph(const Value: Integer);
    procedure SetPlot(const Value: Integer);
    procedure SetFigure(const Value: Integer);

    procedure SetParam(const Value: Integer);
    procedure SetParamValue(const Value: single);

    procedure SetPin(const Value: Boolean);
    procedure SetNorm(const Value: Boolean);
    procedure SetTextureNorm(const Value: Integer);
    procedure SetMeshSize(const Value: Integer);
    procedure SetBigMap(const Value: Boolean);
    procedure SetVorzeichen(const Value: Boolean);
    procedure SetPlotFigure(const Value: Integer);
    procedure SetDim(const Value: Integer);
    procedure SetForceMode(const Value: Integer);
    procedure SetSolutionMode(const Value: Boolean);
    procedure SetResolution(const Value: Integer);

    procedure SetInitDataOK(const Value: Boolean);
    function GetInitDataOK: Boolean;
    procedure SetInitData98(const Value: Boolean);

    function GetPlot: Integer;
    function GetParamValue: single;
    function GetModelStatus: string;
    function GetStatusText: string;
    function GetRangeText: string;
    function GetEquationText: string;
    function GetOptionText: string;
    function GetNeedKoordInit: Boolean;
    procedure HandleDiff(Value: single);
    procedure SetParamValueQick(const Value: single);
    procedure SetCurrentParam(const Value: TFederParam);
    function GetCurrentParam: TFederParam;
    function GetBigMapFactorT2: Integer;
    function GetAbsoluteRangeFromRange: single;
    function GetRangeFromAbsoluteRange: single;

    procedure DoTRS;
    function InitDataTRS(f: single): single;
    function GetCapValue: single;
    procedure SetCapValue(const Value: single);
    procedure SetDrawFigure(const Value: Integer);
    procedure SetLineFigure(const Value: Integer);
    procedure SetScanFigure(const Value: Integer);
    procedure SetParamBahnStrokeWidth1(const Value: single);
    procedure SetParamBahnStrokeWidth2(const Value: single);
    function GetEQ: TFederEquation;
  protected
    function GetRangeText1: string;
    function GetRangeText2: string;
    property InitDataOK: Boolean read GetInitDataOK write SetInitDataOK;
    property InitData98: Boolean write SetInitData98;
  public
    IsCombi: Boolean;

    oc1, oc2, oc3, oc4, oc5, oc6, oc7, oc8, oc9, oc10: char;

    FAttenuation: single;
    FLimit: single;

    FRange: single;
    FAbsoluteRange: single;
    FNorth: single;
    FSouth: single;
    FWest: single;
    FEast: single;

    FOffsetX: single;
    FOffsetY: single;
    FOffsetZ: single;

    WantGleich: Boolean;

    rangex: single;
    rangey: single;

    FRangeFactor: single;

    mc: Integer;
    mx, my, ms: single;

    FT1: single;
    FT2: single;
    FT3: single;
    FT4: single;

    _fp0, _fp1, _fp2, _fp3, _fp4, _fp5, _fp6, _fp7, _fp8, _fp9: single;

    ParamBahnRadius: single;
    ParamBahnPositionX: single;
    ParamBahnPositionY: single;
    ParamBahnAngle: single;
    FParamBahnStrokeWidth1: single;
    FParamBahnStrokeWidth2: single;
    ParamBahnCylinderF: single;
    ParamBahnCylinderD: single;
    ParamBahnCylinderZ: single;
    SliceHeight: single;

    Lux1X: single;
    Lux1Y: single;
    Lux1Z: single;

    Lux2X: single;
    Lux2Y: single;
    Lux2Z: single;

    Lux3X: single;
    Lux3Y: single;
    Lux3Z: single;

    Lux4X: single;
    Lux4Y: single;
    Lux4Z: single;

    ParamBandSelected: single;

    ParamBandCount: single;
    ParamBandDistributionX: single;
    ParamBandDistributionY: single;
    ParamBandWidth: single;

    ParamLabelTextX: single;
    ParamLabelTextY: single;
    ParamLabelTextZ: single;

    LinearForce: Boolean;
    ChangingParam: Boolean;

    ParamCoord0: single;
    ParamCoord1: single;
    ParamCoord2: single;
    ParamCoord3: single;

    CapOverride: Boolean;
    CapFactor: single;

    constructor Create(AFederModelEQ: TFederModelEQBase);
    destructor Destroy; override;

    procedure PrepCalc;

    procedure Reset;
    procedure Refresh;
    procedure RefreshWithRange;
    function GetFPValue(fp: TFederParam): single;

    function GetGraphFactor: single;
    procedure InitData2D;
    procedure InitData; virtual;
    procedure InitRange;
    procedure UpdateVP;
    procedure UpdateParamValue(NewValue: single);

    procedure SaveToFederData(fd: TFederData);
    procedure LoadFromFederData(fd: TFederData);

    property OnInitData: TNotifyEvent read FOnInitData write SetOnInitData;

    property OffsetX: single read FOffsetX write SetOffsetX;
    property OffsetY: single read FOffsetY write SetOffsetY;
    property OffsetZ: single read FOffsetZ write SetOffsetZ;

    property Pin: Boolean read FPin write SetPin;
    property Norm: Boolean read FNorm write SetNorm;
    property TextureNorm: Integer read FTextureNorm write SetTextureNorm;
    property PlusCap: Boolean read FPlusCap write SetPlusCap;
    property MinusCap: Boolean read FMinusCap write SetMinusCap;
    property BigMap: Boolean read FBigMap write SetBigMap;

    property North: single read FNorth write SetNorth;
    property South: single read FSouth write SetSouth;
    property East: single read FEast write SetEast;
    property West: single read FWest write SetWest;
    property RangeFactor: single read FRangeFactor write FRangeFactor;
    property Range: single read FRange write SetRange;
    property AbsoluteRange: single read FAbsoluteRange write SetAbsoluteRange;
    property Limit: single read FLimit write SetLimit;
    property Attenuation: single read FAttenuation write SetAttenuation;
    property CapValue: single read GetCapValue write SetCapValue;

    property Scene: Integer read FScene write SetScene;
    property GraphQuick: Integer read FGraph write FGraph;
    property Graph: Integer read FGraph write SetGraph;
    property Plot: Integer read GetPlot write SetPlot;
    property Figure: Integer read FFigure write SetFigure;
    property Param: Integer read FParam write SetParam;
    property ParamValueQuick: single read GetParamValue write SetParamValueQick;
    property ParamValue: single read GetParamValue write SetParamValue;
    property ParamDiff: single read FParamDiff;

    property Dim: Integer read FDim write SetDim;
    property MeshSize: Integer read FMeshSize write SetMeshSize;
    property Resolution: Integer read FResolution write SetResolution;

    property Active: Boolean read FActive write FActive;
    property Loading: Boolean read FLoading write FLoading;
    property NeedKoordInit: Boolean read GetNeedKoordInit;

    property ModelStatus: string read GetModelStatus;
    property StatusText: string read GetStatusText;
    property RangeText: string read GetRangeText;
    property EquationText: string read GetEquationText;
    property OptionText: string read GetOptionText;

    property ScanFigure: Integer read FScanFigure write SetScanFigure;
    property LineFigure: Integer read FLineFigure write SetLineFigure;
    property DrawFigure: Integer read FDrawFigure write SetDrawFigure;
    property PlotFigure: Integer read FPlotFigure write SetPlotFigure;
    property ForceMode: Integer read FForceMode write SetForceMode;
    property SolutionMode: Boolean read FSolutionMode write SetSolutionMode;
    property Vorzeichen: Boolean read FVorzeichen write SetVorzeichen;

    property ParamBahnStrokeWidth1: single read FParamBahnStrokeWidth1 write SetParamBahnStrokeWidth1;
    property ParamBahnStrokeWidth2: single read FParamBahnStrokeWidth2 write SetParamBahnStrokeWidth2;

    property EQ: TFederEquation read GetEQ;
    property Equation: TFederEquation read GetEQ;
    property CurrentParam: TFederParam read GetCurrentParam write SetCurrentParam;
    property BigMapFactorT2: Integer read GetBigMapFactorT2;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederModel }

constructor TFederModel.Create(AFederModelEQ: TFederModelEQBase);
begin
  Randomize;

  SB := TStringBuilder.Create;
  SL := TStringList.Create;

  FederModelEQ := AFederModelEQ;

  Reset;

  InitScene;
  InitParamValue;
end;

destructor TFederModel.Destroy;
begin
  FederModelEQ.Free;
  SL.Free;
  SB.Free;
  inherited;
end;

procedure TFederModel.SetScene(const Value: Integer);
begin
  InitData98 := False;
  FScene := Value;
  if Main.IsUp then
    Main.FederScene.Scene := Value;
  InitScene;
  if Active then
    InitData;
end;

procedure TFederModel.SetVorzeichen(const Value: Boolean);
begin
  InitData98 := False;
  FVorzeichen := Value;
  if Active then
  begin
    InitData;
  end;
end;

procedure TFederModel.SetAttenuation(const Value: single);
begin
  InitData98 := False;
  FAttenuation := Value;
  if Active then
  begin
    InitData;
  end;
end;

procedure TFederModel.SetLimit(const Value: single);
begin
  InitData98 := False;
  FLimit := Value;
  if Active then
  begin
    InitData;
  end;
end;

procedure TFederModel.SetScanFigure(const Value: Integer);
begin
  InitData98 := False;
  FScanFigure := Value;
  if Value < 0 then
    FScanFigure := 2
  else if Value > 2 then
    FScanFigure := 0;
  if Active then
    InitData;
end;

procedure TFederModel.SetLineFigure(const Value: Integer);
begin
  InitData98 := False;
  FLineFigure := Value;
  if Value < 0 then
    FLineFigure := MainConst.LineFigureCount
  else if Value > MainConst.LineFigureCount then
    FLineFigure := 0;
  if Active and (FLineFigure = 0) then
    InitData;
end;

procedure TFederModel.SetGraph(const Value: Integer);
begin
  InitData98 := False;
  FGraph := Value;
  FAbsoluteRange := GetAbsoluteRangeFromRange; // with new value for FGraph
  FRange := GetRangeFromAbsoluteRange;
  InitRange;
  if Active then
    InitData;
end;

procedure TFederModel.SetForceMode(const Value: Integer);
begin
  InitData98 := False;
  if Value > 3 then
    FForceMode := 0
  else
    FForceMode := Value;

  if Active then
    InitData;
end;

procedure TFederModel.SetPlot(const Value: Integer);
begin
  InitData98 := False;
  FPlot := Value;
  if Main.IsUp then
    Main.FederScene.Plot := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetPlotFigure(const Value: Integer);
begin
  InitData98 := False;
  FPlotFigure := Value;
  if Value < 1 then
    FPlotFigure := EQ.MaxPlotFigure
  else if Value > EQ.MaxPlotFigure then
    FPlotFigure := 1;
  EQ.PlotFigure := FPlotFigure;
  if Active then
    InitData;
end;

procedure TFederModel.SetFigure(const Value: Integer);
begin
  InitData98 := False;
  FFigure := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetOffsetX(const Value: single);
begin
  InitData98 := False;
  FOffsetX := Value;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetOffsetY(const Value: single);
begin
  InitData98 := False;
  FOffsetY := Value;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetOffsetZ(const Value: single);
begin
  InitData98 := False;
  FOffsetZ := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetOnInitData(const Value: TNotifyEvent);
begin
  FOnInitData := Value;
end;

procedure TFederModel.SetParam(const Value: Integer);
begin
  FParam := Value;
  FParamChanged := True;
  FParamValueOld := 0;
  FParamDiff := 0;
  FParamDiffRef := 0;
  CurrentParam := TFederUtils.GetFederParam(FParam);

  if (CurrentParam = fptrt) then
  begin
    vp1.X := EQ.x1;
    vp1.Y := EQ.y1;
    vp1.Z := EQ.z1;

    vp2.X := EQ.x2;
    vp2.Y := EQ.y2;
    vp2.Z := EQ.z2;

    vp3.X := EQ.x3;
    vp3.Y := EQ.y3;
    vp3.Z := EQ.z3;

    vp4.X := EQ.x4;
    vp4.Y := EQ.y4;
    vp4.Z := EQ.z4;
  end;
end;

procedure TFederModel.SetParamBahnStrokeWidth1(const Value: single);
begin
  if Value >= 1 then
    FParamBahnStrokeWidth1 := Value
  else
    FParamBahnStrokeWidth1 := 1;
end;

procedure TFederModel.SetParamBahnStrokeWidth2(const Value: single);
begin
  if Value >= 1 then
    FParamBahnStrokeWidth2 := Value
  else
    FParamBahnStrokeWidth2 := 1;
end;

procedure TFederModel.HandleDiff(Value: single);
begin
  if Value > FParamDiffRef then
    FParamDiff := 1 * MainVar.WheelFrequency
  else
    FParamDiff := -1 * MainVar.WheelFrequency;

  if Abs(Value - FParamDiffRef) > 2 * MainVar.WheelFrequency then
    FParamDiff := FParamDiff * 10 * MainVar.WheelFrequency;

  FParamDiffRef := Value;
end;

procedure TFederModel.SetParamValue(const Value: single);
begin
  if Loading or (FParamValue <> Value) then
  begin
    HandleDiff(Value);
    if not HandleAsViewParam(Value) then
    begin
      FParamChanged := False;
      FParamValue := Value;
      InitParamValue;

      case CurrentParam of
        fpBandSelected: Exit;
      end;

      if Active then
      begin
        if MainVar.GPUScale then
          UpdateVP
        else
          InitData;
      end;
    end;
  end;
end;

procedure TFederModel.SetParamValueQick(const Value: single);
begin
  FParamChanged := True;
  FParamValue := Value;
end;

function TFederModel.HandleAsViewParam(const Value: single): Boolean;
var
  fp: TFederParam;
begin
  { result = true means case was handled }
  result := False;
  fp := TFederUtils.GetFederParam(FParam);
  if fp = fpUnknown then
    result := true // ignore
  else if TFederUtils.IsViewParam(fp) then
  begin
    if not MainVar.AppIsClosing then
    begin
      Main.ViewParamValue[fp] := Value;
      result := true; // done
    end;
  end;
end;

procedure TFederModel.SetPin(const Value: Boolean);
begin
  InitData98 := False;
  FPin := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetNorm(const Value: Boolean);
begin
  InitData98 := False;
  FNorm := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetTextureNorm(const Value: Integer);
begin
  InitDataOK := False;
  FTextureNorm := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetPlusCap(const Value: Boolean);
begin
  InitData98 := False;
  FPlusCap := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetBigMap(const Value: Boolean);
begin
  InitData98 := False;
  FBigMap := Value;
  if Active then
    InitData;
end;

function TFederModel.GetCapValue: single;
begin
  result := 100 + FLimit;
end;

procedure TFederModel.SetCapValue(const Value: single);
begin
  FLimit := Value - 100;
  if Active then
    Main.FederScene.UpdateLimitPlane;
end;

procedure TFederModel.SetCurrentParam(const Value: TFederParam);
begin
  Main.ParamManager.CurrentParam := Value;
end;

procedure TFederModel.SetDim(const Value: Integer);
begin
  InitData98 := False;
  if Value > 0 then
  begin
    FDim := Value;
    if Active then
      InitData;
  end;
end;

procedure TFederModel.SetDrawFigure(const Value: Integer);
begin
  InitData98 := False;
  FDrawFigure := Value;
  if Value < 1 then
    FDrawFigure := MainConst.DrawFigureCount
  else if Value > MainConst.DrawFigureCount then
    FDrawFigure := 1;
  if Active then
    InitData;
end;

function TFederModel.GetGraphFactor: single;
begin
  case Graph of
    1: result := 1.0;
    2: result := 1.3;
    3: result := 1.8;
    4: result := 2.4;
    5: result := 3.6;
    6: result := 5.0;
    else
      result := 10;
  end;
end;

function TFederModel.GetAbsoluteRangeFromRange: single;
var
  f: single;
begin
  f := GetGraphFactor;
  { mmr := f * (50 + r); }
  { r := (mmr / f) - 50; }
  result := f * (50 + FRange);
end;

function TFederModel.GetRangeFromAbsoluteRange: single;
var
  f: single;
begin
  f := GetGraphFactor;
  { mmr := f * (50 + r); }
  { r := (mmr / f) - 50; }
  result := (FAbsoluteRange / f) - 50;
end;

procedure TFederModel.SetAbsoluteRange(const mmRange: single);
begin
  InitData98 := False;
  FAbsoluteRange := mmRange;
  FRange := GetRangeFromAbsoluteRange;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetRange(const Value: single);
begin
  InitData98 := False;
  FRange := Value;
  FAbsoluteRange := GetAbsoluteRangeFromRange;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetNorth(const Value: single);
begin
  InitData98 := False;
  FNorth := Value;
  FOffsetY := -(FNorth + FSouth) / 2;
  FAbsoluteRange := (FNorth - FSouth) / 2;
  FRange := GetRangeFromAbsoluteRange;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetSouth(const Value: single);
begin
  InitData98 := False;
  FSouth := Value;
  FOffsetY := -(FNorth + FSouth) / 2;
  FAbsoluteRange := (FNorth - FSouth) / 2;
  FRange := GetRangeFromAbsoluteRange;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetEast(const Value: single);
begin
  InitData98 := False;
  FEast := Value;
  FOffsetX := (FEast + FWest) / 2;
  FAbsoluteRange := (FEast - FWest) / 2;
  FRange := GetRangeFromAbsoluteRange;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetWest(const Value: single);
begin
  InitData98 := False;
  FWest := Value;
  FOffsetX := (FEast + FWest) / 2;
  FAbsoluteRange := (FEast - FWest) / 2;
  FRange := GetRangeFromAbsoluteRange;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.SetSolutionMode(const Value: Boolean);
begin
  InitData98 := False;
  FSolutionMode := Value;
  if Active then
    InitData;
end;

procedure TFederModel.SetMeshSize(const Value: Integer);
begin
  InitDataOK := False;
  if (Value >= 4) and (Value <= 1024) then
  begin
    FMeshSize := Value;
    Graph := Graph;
  end;
end;

procedure TFederModel.SetResolution(const Value: Integer);
begin
  InitDataOK := False;
  if (Value >= 1) and (Value <= 6) then
  begin
    FResolution := Value;
    InitData2D;
  end;
end;

procedure TFederModel.SetMinusCap(const Value: Boolean);
begin
  InitData98 := False;
  FMinusCap := Value;
  if Active then
    InitData;
end;

procedure TFederModel.UpdateParamValue(NewValue: single);
begin
  FParamValue := NewValue;
  FParamValueOld := NewValue;
end;

procedure TFederModel.UpdateVP;
begin
  Main.UpdateVP;
end;

procedure TFederModel.InitScene;
begin
  FederModelEQ.SwapEQ(Scene);
  if NeedKoordInit then
    EQ.InitKoord;
  InitRange;
end;

procedure TFederModel.InitRange;
begin
  rangex := FAbsoluteRange;
  rangey := rangex;

  mc := FMeshSize;
  ms := 2 * rangey / mc;

  mx := rangex + OffsetX;
  my := rangey + OffsetY;

  FNorth := FAbsoluteRange - FOffsetY;
  FSouth := -FAbsoluteRange - FOffsetY;
  FEast := FAbsoluteRange + FOffsetX;
  FWest := -FAbsoluteRange + FOffsetX;
end;

procedure TFederModel.InitData;
begin
  if Main.IsUp then
  begin
    EQ.ErrorCounter := 0;
    EQ.rmin := 0;
    EQ.rmax := 0;

    PrepCalc;
    EQ.PrepareCalc;

    if Assigned(OnInitData) then
    begin
      OnInitData(self);
    end;
  end;
end;

procedure TFederModel.InitData2D;
begin
  if Main.IsUp then
  begin
    EQ.ErrorCounter := 0;
    EQ.rmin := 0;
    EQ.rmax := 0;

    EQ.PrepareCalc;
  end;
end;

procedure TFederModel.InitParamValue;
var
  fp: TFederParam;
  temp: single;
begin
  fp := TFederUtils.GetFederParam(Param);
  case fp of
    fpx12:
    begin
      if not Loading then
      begin
        temp := FParamValue - FParamValueOld;
        EQ.x1 := EQ.x1 - temp;
        EQ.x2 := EQ.x2 + temp;
        FParamValueOld := FParamValue;
      end;
    end;

    fpy12:
    begin
      if not Loading then
      begin
        temp := FParamValue - FParamValueOld;
        EQ.y1 := EQ.y1 + temp;
        EQ.y2 := EQ.y2 + temp;
        FParamValueOld := FParamValue;
      end;
    end;

    fpz12:
    begin
      if not Loading then
      begin
        temp := FParamValue - FParamValueOld;
        EQ.z1 := EQ.z1 + temp;
        EQ.z2 := EQ.z2 + temp;
        FParamValueOld := FParamValue;
      end;
    end;

    fptrx:
    begin
      if not Loading then
      begin
        temp := FParamValue - FParamValueOld;
        EQ.x1 := EQ.x1 + temp;
        EQ.x2 := EQ.x2 + temp;
        EQ.x3 := EQ.x3 + temp;
        EQ.x4 := EQ.x4 + temp;
        FParamValueOld := FParamValue;
      end;
    end;

    fptry:
    begin
      if not Loading then
      begin
        temp := FParamValue - FParamValueOld;
        EQ.y1 := EQ.y1 + temp;
        EQ.y2 := EQ.y2 + temp;
        EQ.y3 := EQ.y3 + temp;
        EQ.y4 := EQ.y4 + temp;
        FParamValueOld := FParamValue;
      end;
    end;

    fptrt:
    begin
      { Achtung: Bug in CreateRotationMatrix when FParamValue = -1) }
      if not Loading then
      begin
        vp5 := TUtils.RotateDegrees(vp1, FParamValue);
        vp6 := TUtils.RotateDegrees(vp2, FParamValue);
        vp7 := TUtils.RotateDegrees(vp3, FParamValue);
        vp8 := TUtils.RotateDegrees(vp4, FParamValue);

        EQ.x1 := vp5.X;
        EQ.x2 := vp6.X;
        EQ.x3 := vp7.X;
        EQ.x4 := vp8.X;

        EQ.y1 := vp5.Y;
        EQ.y2 := vp6.Y;
        EQ.y3 := vp7.Y;
        EQ.y4 := vp8.Y;
      end;
    end;

    fptrs: DoTRS;
    fpt:
    begin
      if FederModelEQ.EQIndex = 4 then
      begin
        if WantGleich then
        begin
          EQ.x1 := -FParamValue;
          EQ.x2 := FParamValue;
          EQ.x3 := -FParamValue;
          EQ.x4 := FParamValue;

          EQ.y1 := -FParamValue;
          EQ.y2 := -FParamValue;
          EQ.y3 := +FParamValue;
          EQ.y4 := +FParamValue;
        end
        else
        begin
          EQ.x1 := -FParamValue;
          EQ.x2 := FParamValue;
          EQ.x3 := 0;
          EQ.x4 := 0;

          EQ.y1 := 0;
          EQ.y2 := 0;
          EQ.y3 := 2;
          EQ.y4 := 2;
        end;
      end
      else if FederModelEQ.EQIndex = 3 then
      begin
        if WantGleich then
        begin
          EQ.x1 := -FParamValue;
          EQ.x2 := FParamValue;
          EQ.x3 := 0;

          EQ.y1 := -0.5 * FParamValue;
          EQ.y2 := EQ.y1;
          EQ.y3 := EQ.y1 + Sqrt(3) * FParamValue;
        end
        else
        begin
          EQ.x1 := -FParamValue;
          EQ.x2 := FParamValue;
          EQ.x3 := 0;

          EQ.y1 := -0.5 * FParamValue;
          EQ.y2 := -0.5 * FParamValue;
          EQ.y3 := 1.5 * FParamValue;
        end;
      end
      else if FederModelEQ.EQIndex = 2 then
      begin
        EQ.x1 := -FParamValue;
        EQ.x2 := FParamValue;
        EQ.y1 := 0;
        EQ.y2 := 0;
      end
      else
      begin
        EQ.x1 := FParamValue;
        EQ.y1 := FParamValue;
      end;
    end;

    fpL:
    begin
      EQ.l1 := FParamValue;
      EQ.l2 := FParamValue;
      EQ.l3 := FParamValue;
      EQ.l4 := FParamValue;
    end;

    fpK:
    begin
      EQ.k1 := FParamValue;
      EQ.k2 := FParamValue;
      EQ.k3 := FParamValue;
      EQ.k4 := FParamValue;
    end;

    fpZ:
    begin
      EQ.z1 := FParamValue;
      EQ.z2 := FParamValue;
      EQ.z3 := FParamValue;
      EQ.z4 := FParamValue;
    end;

    fpl1: EQ.l1 := FParamValue;
    fpl2: EQ.l2 := FParamValue;
    fpl3: EQ.l3 := FParamValue;
    fpl4: EQ.l4 := FParamValue;

    fpk1: EQ.k1 := FParamValue;
    fpk2: EQ.k2 := FParamValue;
    fpk3: EQ.k3 := FParamValue;
    fpk4: EQ.k4 := FParamValue;

    fpox: begin FOffsetX := FParamValue; InitRange; end;
    fpoy: begin FOffsetY := FParamValue; InitRange; end;
    fpoz: begin FOffsetZ := FParamValue; InitRange; end;

    fpx1: EQ.x1 := FParamValue;
    fpx2: EQ.x2 := FParamValue;
    fpx3: EQ.x3 := FParamValue;
    fpx4: EQ.x4 := FParamValue;

    fpy1: EQ.y1 := FParamValue;
    fpy2: EQ.y2 := FParamValue;
    fpy3: EQ.y3 := FParamValue;
    fpy4: EQ.y4 := FParamValue;

    fpz1: EQ.z1 := FParamValue;
    fpz2: EQ.z2 := FParamValue;
    fpz3: EQ.z3 := FParamValue;
    fpz4: EQ.z4 := FParamValue;

    fpAttenuation: FAttenuation := FParamValue;
    fpGrenze:
    begin
      FLimit := FParamValue;
      Main.FederScene.UpdateLimitPlane;
    end;
    fpRange:
    begin
      FRange := FParamValue;
      FAbsoluteRange := GetAbsoluteRangeFromRange;
      InitRange;
    end;
    fpAbsoluteRange:
    begin
      FAbsoluteRange := FParamValue;
      FRange := GetRangeFromAbsoluteRange;
      InitRange;
    end;
    fpNorthCapValue:
    begin
      FNorth := FParamValue;
      FOffsetY := -(FNorth + FSouth) / 2;
      FAbsoluteRange := (FNorth - FSouth) / 2;
      FRange := GetRangeFromAbsoluteRange;
      InitRange;
    end;
    fpSouthCapValue:
    begin
      FSouth := FParamValue;
      FOffsetY := -(FNorth + FSouth) / 2;
      FAbsoluteRange := (FNorth - FSouth) / 2;
      FRange := GetRangeFromAbsoluteRange;
      InitRange;
    end;
    fpEastCapValue:
    begin
      FEast := FParamValue;
      FOffsetX := (FWest + FEast) / 2;
      FAbsoluteRange := (FEast - FWest) / 2;
      FRange := GetRangeFromAbsoluteRange;
      InitRange;
    end;
    fpWestCapValue:
    begin
      FWest := FParamValue;
      FOffsetX := (FWest + FEast) / 2;
      FAbsoluteRange := (FEast - FWest) / 2;
      FRange := GetRangeFromAbsoluteRange;
      InitRange;
    end;

    fpt1: FT1 := FParamValue;
    fpt2: FT2 := FParamValue;
    fpt3:
    begin
      FT3 := FParamValue;
      Main.UpdateReason := TUpdateReason.cuParamRingWidthT3;
      Main.UpdateRings;
    end;
    fpt4:
    begin
      FT4 := FParamValue;
      Main.UpdateReason := TUpdateReason.cuParamRingWidthT4;
      Main.UpdateRings;
    end;

    fpl1x:
    begin
      Lux1X := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl1y:
    begin
      Lux1Y := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl1z:
    begin
      Lux1Z := FParamValue;
      Main.FederScene.UpdateLight;
    end;

    fpl2x:
    begin
      Lux2X := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl2y:
    begin
      Lux2Y := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl2z:
    begin
      Lux2Z := FParamValue;
      Main.FederScene.UpdateLight;
    end;

    fpl3x:
    begin
      Lux3X := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl3y:
    begin
      Lux3Y := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl3z:
    begin
      Lux3Z := FParamValue;
      Main.FederScene.UpdateLight;
    end;

    fpl4x:
    begin
      Lux4X := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl4y:
    begin
      Lux4Y := FParamValue;
      Main.FederScene.UpdateLight;
    end;
    fpl4z:
    begin
      Lux4Z := FParamValue;
      Main.FederScene.UpdateLight;
    end;

    fpBandCount:
    begin
      ParamBandCount := FParamValue / MainVar.WheelFrequency;
      Main.MarkForUpdate(TUpdateReason.cuParamBandCount);
    end;
    fpBandDistributionX:
    begin
      ParamBandDistributionX := FParamValue / MainVar.WheelFrequency;
      Main.MarkForUpdate(TUpdateReason.cuParamBandDistributionX);
    end;
    fpBandDistributionY:
    begin
      ParamBandDistributionY := FParamValue / MainVar.WheelFrequency;
      Main.MarkForUpdate(TUpdateReason.cuParamBandDistributionY);
    end;

    fpBandSelected:
    begin
      ParamBandSelected := Round(Main.Trackbar_Value);
      Main.RingIndexChanged;
      ParamBandWidth := Main.RingWidth;
     end;

    fpBandWidth:
    begin
      ParamBandWidth := FParamValue;
      Main.RingWidth := Round(ParamBandWidth);
    end;

    fpLabelTextX:
    begin
      ParamLabelTextX := FParamValue;
      Main.FederScene.SetParamValue(fp, FParamValue);
    end;
    fpLabelTextY:
    begin
      ParamLabelTextY := FParamValue;
      Main.FederScene.SetParamValue(fp, FParamValue);
    end;
    fpLabelTextZ:
    begin
      ParamLabelTextZ := FParamValue;
      Main.FederScene.SetParamValue(fp, FParamValue);
    end;

    fp0: _fp0 := FParamValue;
    fp1: _fp1 := FParamValue;
    fp2: _fp2 := FParamValue;
    fp3: _fp3 := FParamValue;
    fp4: _fp4 := FParamValue;
    fp5: _fp5 := FParamValue;
    fp6: _fp6 := FParamValue;
    fp7: _fp7 := FParamValue;
    fp8: _fp8 := FParamValue;
    fp9: _fp9 := FParamValue;

    fppa: Main.DoParallelUpdate(FParamValue);

    fpParamCapValue: CapValue := FParamValue;

    fpbpr:
    begin
      ParamBahnRadius := FParamValue;
      Main.FederScene.UpdateProbe;
    end;
    fpbpx:
    begin
      ParamBahnPositionX := FParamValue;
      Main.FederScene.UpdateProbe;
    end;
    fpbpy:
    begin
      ParamBahnPositionY := FParamValue;
      Main.FederScene.UpdateProbe;
    end;
    fpbpa:
    begin
      ParamBahnAngle := FParamValue;
      Main.FederScene.UpdateProbe;
    end;
    fpbs1: ParamBahnStrokeWidth1 := FParamValue;
    fpbs2: ParamBahnStrokeWidth2 := FParamValue;
    fpbcf: ParamBahnCylinderF := FParamValue;
    fpbcd:
    begin
      ParamBahnCylinderD := FParamValue / 10;
      Main.FederScene.UpdateProbe;
    end;
    fpbcz:
    begin
      ParamBahnCylinderZ := FParamValue / 10;
      Main.FederScene.UpdateProbe;
    end;

    fpParamY3f: EQ.y3f := FParamValue;
    fpParamL3f: EQ.l3f := FParamValue;
    fpParamLf: EQ.Lf := FParamValue;

    fpCoord0: ParamCoord0 := FParamValue;
    fpCoord1: ParamCoord1 := FParamValue;
    fpCoord2: ParamCoord2 := FParamValue;
    fpCoord3: ParamCoord3 := FParamValue;
  end;
end;

function TFederModel.GetCurrentParam: TFederParam;
begin
  result := Main.ParamManager.CurrentParam;
end;

function TFederModel.GetEQ: TFederEquation;
begin
  result := FederModelEQ.EQ;
end;

function TFederModel.GetEquationText: string;
begin
  SL.Clear;
  EQ.InitMemo(SL);
  result := SL.Text;
end;

function TFederModel.GetNeedKoordInit: Boolean;
begin
  //result := not Loading;
  result := False;
end;

function TFederModel.GetOptionText: string;
begin
  if Vorzeichen then
    oc1 := 'V'
  else
    oc1 := 'v';

  if SolutionMode then
    oc2 := 'S'
  else
    oc2 := 's';

  if ForceMode = 2 then
    oc3 := '2'
  else if ForceMode = 1 then
    oc3 := '1'
  else
    oc3 := '0';

  if WantGleich then
    oc4 := '='
  else
    oc4 := '-';

  if BigMap then
    oc5 := 'B'
  else
    oc5 := 'b';

  case FDim of
    1: oc6 := '1';
    2: oc6 := '2';
    3: oc6 := '3';
    4: oc6 := '4';
    5: oc6 := '5';
    else
      oc6 := '*';
  end;

  if PlusCap then
    oc7 := 'P'
  else
    oc7 := 'p';

  if MinusCap then
    oc8 := 'M'
  else
    oc8 := 'm';

  if EQ.LinearForce then
    oc10 := 'n'
  else
    oc10 := 'N';

  result := oc1 + oc2 + oc3 + oc4 + oc5 + oc6 + oc7 + oc8 + oc9 + oc10;
end;

function TFederModel.GetParamValue: single;
var
  fp: TFederParam;
begin
  fp := TFederUtils.GetFederParam(Param);
  result := GetFPValue(fp);
end;

function TFederModel.GetPlot: Integer;
begin
  result := FPlot;
end;

function TFederModel.GetFPValue(fp: TFederParam): single;
begin
  case fp of
    fptrs: result := 0;
    fptrt: result := 0;
    fptrx: result := 0;
    fptry: result := 0;

    fpt: result := EQ.x2;
    fpl: result := EQ.l1;
    fpk: result := EQ.k1;
    fpz: result := EQ.z1;

    fpl1: result := EQ.l1;
    fpl2: result := EQ.l2;
    fpl3: result := EQ.l3;
    fpl4: result := EQ.l4;

    fpk1: result := EQ.k1;
    fpk2: result := EQ.k2;
    fpk3: result := EQ.k3;
    fpk4: result := EQ.k4;

    fpox: result := OffsetX;
    fpoy: result := OffsetY;
    fpoz: result := OffsetZ;

    fpx1: result := EQ.x1;
    fpx2: result := EQ.x2;
    fpx3: result := EQ.x3;
    fpx4: result := EQ.x4;

    fpy1: result := EQ.y1;
    fpy2: result := EQ.y2;
    fpy3: result := EQ.y3;
    fpy4: result := EQ.y4;

    fpz1: result := EQ.z1;
    fpz2: result := EQ.z2;
    fpz3: result := EQ.z3;
    fpz4: result := EQ.z4;

    fpAttenuation: result := FAttenuation;
    fpGrenze: result := FLimit;
    fpRange: result := FRange;
    fpAbsoluteRange: result := FAbsoluteRange;
    fpNorthCapValue: result := FNorth;
    fpSouthCapValue: result := FSouth;
    fpEastCapValue: result := FEast;
    fpWestCapValue: result := FWest;

    fpt1: result := FT1;
    fpt2: result := FT2;
    fpt3: result := FT3;
    fpt4: result := FT4;

    fppx,
    fppy: result := Main.ViewParamValue[fp];

    fp0: result := _fp0;
    fp1: result := _fp1;
    fp2: result := _fp2;
    fp3: result := _fp3;
    fp4: result := _fp4;
    fp5: result := _fp5;
    fp6: result := _fp6;
    fp7: result := _fp7;
    fp8: result := _fp8;
    fp9: result := _fp9;

    fpBandSelected: result := ParamBandSelected;

    fpBandCount: result := ParamBandCount;
    fpBandDistributionX: result := ParamBandDistributionX;
    fpBandDistributionY: result := ParamBandDistributionY;

    fpBandWidth:
    case Main.BandWidthOption of
        bwAbsolute: result := Main.RingWidth;
        bwRelative: result := Main.RingWidth;
        bwContour: result := Main.RingContourWidth;
      else
      result := Main.RingWidth;
    end;

    fpLabelTextX: result := Main.FederScene.GetParamValue(fp);
    fpLabelTextY: result := Main.FederScene.GetParamValue(fp);
    fpLabelTextZ: result := Main.FederScene.GetParamValue(fp);

    fpParamCapValue: result := CapValue;

    fpbpr: result := ParamBahnRadius;
    fpbpx: result := ParamBahnPositionX;
    fpbpy: result := ParamBahnPositionY;
    fpbpa: result := ParamBahnAngle;
    fpbs1: result := ParamBahnStrokeWidth1;
    fpbs2: result := ParamBahnStrokeWidth2;
    fpbcf: result := ParamBahnCylinderF;
    fpbcd: result := ParamBahnCylinderD * 10;
    fpbcz: result := ParamBahnCylinderZ * 10;

    fpl1x: result := Lux1X;
    fpl1y: result := Lux1Y;
    fpl1z: result := Lux1Z;

    fpl2x: result := Lux2X;
    fpl2y: result := Lux2Y;
    fpl2z: result := Lux2Z;

    fpl3x: result := Lux3X;
    fpl3y: result := Lux3Y;
    fpl3z: result := Lux3Z;

    fpl4x: result := Lux4X;
    fpl4y: result := Lux4Y;
    fpl4z: result := Lux4Z;

    fpParamY3f: result := EQ.y3f;
    fpParamL3f: result := EQ.l3f;
    fpParamLf: result := EQ.Lf;

    fpCoord0: result := ParamCoord0;
    fpCoord1: result := ParamCoord1;
    fpCoord2: result := ParamCoord2;
    fpCoord3: result := ParamCoord3;
    else
      result := 1;
  end;

  if Main.FederFrame.InitOK then
  case fp of
    fprx,
    fpry,
    fprz,

    fptx,
    fpty,
    fpcz: result := Main.ViewParamValue[fp];

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
    fpl4z: result := Main.FederScene.GetLuxParamValue(fp);
  end;
end;

function TFederModel.GetModelStatus: string;
var
  ft: string;
  fs: string;
begin
  SL.Clear;
  ft := '%7.2f %7.2f %7.2f %7.2f';
  with EQ do
  begin
    fs := Format('x: %s', [ft]);
    SL.Add(Format(fs, [x1, x2, x3, x4]));
    fs := Format('y: %s', [ft]);
    SL.Add(Format(fs, [y1, y2, y3, y4]));
    fs := Format('z: %s', [ft]);
    SL.Add(Format(fs, [z1, z2, z3, z4]));
    fs := Format('l: %s', [ft]);
    SL.Add(Format(fs, [l1, l2, l3, l4]));
    fs := Format('k: %s', [ft]);
    SL.Add(Format(fs, [k1, k2, k3, k4]));
    fs := Format('m: %s', ['%7d %7d %7d %7d']);
    SL.Add(Format(fs, [m1, m2, m3, m4]));
  end;
  result := SL.Text;
end;

function TFederModel.GetStatusText: string;
var
  ft: string;
  fs: string;
begin
  ft := ' (%.2f %.2f %.2f %.2f)';
  fs := Format('x:%s y:%s l:%s k%s ', [ft, ft, ft, ft]);
  with EQ do
    result := Format(fs, [x1, x2, x3, x4, y1, y2, y3, y4, l1, l2, l3, l4, k1, k2, k3, k4]);
end;

function TFederModel.GetRangeText: string;
begin
  result := GetRangeText1;
end;

function TFederModel.GetRangeText1: string;
begin
  if (EQ.rmin = 0) and (EQ.rmax = 0) then
    result := Format('Range %.2f Factor %.2f', [FRange, FRangeFactor])
  else
    result := Format('Range %.2f Factor %.2f = [%.2f ... %.2f]', [FRange, FRangeFactor, EQ.rmin, EQ.rmax]);
end;

function TFederModel.GetRangeText2: string;
begin
  SB.Clear;
  SB.AppendFormat('R %d', [FRange]).AppendLine;
  SB.AppendFormat('F %.2f', [FRangeFactor]).AppendLine;
  SB.AppendFormat('%.2f', [EQ.rmin]).AppendLine;
  SB.AppendFormat('%.2f', [EQ.rmax]).AppendLine;
  result := SB.ToString;
end;

procedure TFederModel.RefreshWithRange;
begin
  InitData98 := False;
  if Active then
  begin
    InitRange;
    InitData;
  end;
end;

procedure TFederModel.Refresh;
begin
  InitData98 := False;
  if Active then
  begin
    InitData;
  end;
end;

procedure TFederModel.Reset;
begin
  ParamBandSelected := 21;

  ParamBandCount := 17;
  ParamBandDistributionX := 10;
  ParamBandDistributionY := 80;

  Pin := False;
  Norm := False;
  TextureNorm := 0;

  WantGleich := False;

  FederModelEQ.SwapEQ(3);
  FSolutionMode := True;
  FVorzeichen := False;
  FForceMode := 0;
  FMeshSize := MainConst.DefaultMeshSize;
  FResolution := 1;

  FScene := 3;
  FGraph := 3;
  FPlot := 1;
  FFigure := 3;
  FPlotFigure := 1;
  FDrawFigure := 1;
  FDim := 5;

  FAttenuation := 0;
  FLimit := 100;
  FRange := 0;
  FAbsoluteRange := 0;

  FOffsetX := 0;
  FOffsetY := 0;
  FOffsetZ := 0;

  FMinusCap := False;
  FPlusCap := False;

  FParam := 14;
  FParamValue := 0;
  FParamChanged := False;

  rangex := 0;
  rangey := 0;
  FRangeFactor := 1;

  mc := 0;
  mx := 0;
  my := 0;
  ms := 0;

  FT1 := 0;
  FT2 := 50;
  FT3 := StripConst.DefaultStripWidth;
  FT4 := StripConst.DefaultBandWidth;

  { CapValue := 0; } // CapValue is dependent on Limit
  SliceHeight := 50;

  ParamBahnRadius := 100;
  ParamBahnPositionX := 0;
  ParamBahnPositionY := 0;
  ParamBahnAngle := 0;
  ParamBahnStrokeWidth1 := 1;
  ParamBahnStrokeWidth2 := 2;
  ParamBahnCylinderF := 0;
  ParamBahnCylinderD := 1;
  ParamBahnCylinderZ := 0;

  Lux1X := 0;
  Lux1Y := 0;
  Lux1Z := LightConst.Front;

  Lux2X := 0;
  Lux2Y := 0;
  Lux2Z := LightConst.Back;

  Lux3X := LightConst.West;
  Lux3Y := 0;
  Lux3Z := LightConst.WestZ;

  Lux4X := 0;
  Lux4Y := LightConst.North;
  Lux4Z := 0;

  ParamCoord0 := 0;
  ParamCoord1 := 1;
  ParamCoord2 := 2;
  ParamCoord3 := 3;
end;

procedure TFederModel.LoadFromFederData(fd: TFederData);
begin
  InitData98 := False;
  FederModelEQ.SwapEQ(fd.Scene);

  if fd.Bitmap <> 0 then
    Main.InitDefaultRingWidth(StripConst.DefaultBandWidth);

  ParamBandSelected := 21;
  Main.CurrentRing := Round(ParamBandSelected);

  EQ.y3f := 0;
  EQ.l3f := 0;
  EQ.Lf := 0;

  EQ.x1 := fd.x1;
  EQ.x2 := fd.x2;
  EQ.x3 := fd.x3;
  EQ.x4 := fd.x4;

  EQ.y1 := fd.y1;
  EQ.y2 := fd.y2;
  EQ.y3 := fd.y3;
  EQ.y4 := fd.y4;

  EQ.z1 := fd.z1;
  EQ.z2 := fd.z2;
  EQ.z3 := fd.z3;
  EQ.z4 := fd.z4;

  EQ.l1 := fd.l1;
  EQ.l2 := fd.l2;
  EQ.l3 := fd.l3;
  EQ.l4 := fd.l4;

  EQ.k1 := fd.k1;
  EQ.k2 := fd.k2;
  EQ.k3 := fd.k3;
  EQ.k4 := fd.k4;

  EQ.m1 := fd.m1;
  EQ.m2 := fd.m2;
  EQ.m3 := fd.m3;
  EQ.m4 := fd.m4;

  FDim := fd.Dim;
  FDrawFigure := fd.DrawFigure;

  FScene := fd.Scene;
  FGraph := fd.Graph;
  FPlot := fd.Plot;
  FFigure := fd.Figure;

  FOffsetX := fd.OffsetX;
  FOffsetY := fd.OffsetY;
  FOffsetZ := fd.OffsetZ;

  WantGleich := fd.Gleich;
  LinearForce := fd.LinearForce;

  FMeshSize := fd.MeshSize;
  FAttenuation := fd.Attenuation;
  FLimit := fd.Limit;
  FRange := fd.Range;
  FAbsoluteRange := GetAbsoluteRangeFromRange;
  FParam := fd.Param;

  if fd.CapValue > 0 then
    FLimit := fd.CapValue - 100;

  if fd.AbsoluteRange > 0 then
  begin
    FAbsoluteRange := fd.AbsoluteRange;
    FRange := GetRangeFromAbsoluteRange;
  end;

  FMinusCap := fd.MinusCap;
  FPlusCap := fd.PlusCap;
  FBigMap := fd.BigMap;
  FPin := fd.Pin;
  FNorm := fd.Norm;
  FTextureNorm := fd.TextureNorm;

  FParamValue := GetParamValue;
  FParamChanged := True;

  FT1 := 0;
  FT2 := 1;
  FT3 := StripConst.DefaultStripWidth;
  FT4 := StripConst.DefaultBandWidth;

//  if fd.T1 >= 0 then
    FT1 := fd.T1;
  if fd.T2 >= 0 then
    FT2 := fd.T2;
  if fd.T3 >= 0 then
    FT3 := fd.T3;
  if fd.T4 >= 0 then
    FT4 := fd.T4;

  if not fd.ForceLock then
  begin
    FForceMode := fd.ForceMode;
    FSolutionMode := fd.SolutionMode;
  end;
  PlotFigure := fd.PlotFigure;
  FVorzeichen := fd.Vorzeichen;

  ParamBahnRadius := fd.ParamBahnRadius;
  ParamBahnPositionX := fd.ParamBahnPositionX;
  ParamBahnPositionY := fd.ParamBahnPositionY;
  ParamBahnAngle := fd.ParamBahnAngle;
  ParamBahnStrokeWidth1 := fd.ParamBahnStrokeWidth1;
  ParamBahnStrokeWidth2 := fd.ParamBahnStrokeWidth2;
  ParamBahnCylinderF := fd.ParamBahnCylinderF;
  ParamBahnCylinderD := fd.ParamBahnCylinderD / 10;
  ParamBahnCylinderZ := fd.ParamBahnCylinderZ / 10;

  Main.FederScene.BlockInitDataOnce := True;
  Main.FederScene.ReducedMesh := False;
  Main.FederScene.ReduceMode := 0;

  Main.FederScene.ShowGrid := fd.ShowGrid;
  Main.FederScene.ShowKugel := fd.ShowKugel;

  if IsCombi then
  begin
    Main.FederScene.ShowCylinder := fd.ShowCylinder;
    Main.FederScene.ShowDiameter := fd.ShowDiameter;
  end
  else
  begin
    Main.FederScene.ShowCylinder := False;
    Main.FederScene.ShowDiameter := False;
  end;

  Main.vp.Reset;

  MainVar.Transform2D.NullpunktX := fd.NullpunktX;
  MainVar.Transform2D.NullpunktY := fd.NullpunktY;
  MainVar.Transform2D.PaintboxZoom := fd.PaintboxZoom;
  MainVar.Transform2D.PaintboxRotation := fd.PaintboxRotation;

  MainVar.WantUniqueVertices := True;

  if not fd.LuxLock then
  begin
    Lux1X := fd.Lux1X;
    Lux1Y := fd.Lux1Y;
    Lux1Z := fd.Lux1Z;

    Lux2X := fd.Lux2X;
    Lux2Y := fd.Lux2Y;
    Lux2Z := fd.Lux2Z;

    Lux3X := fd.Lux3X;
    Lux3Y := fd.Lux3Y;
    Lux3Z := fd.Lux3Z;

    Lux4X := fd.Lux4X;
    Lux4Y := fd.Lux4Y;
    Lux4Z := fd.Lux4Z;
  end;
end;

procedure TFederModel.SaveToFederData(fd: TFederData);
begin
  fd.x1 := EQ.x1;
  fd.x2 := EQ.x2;
  fd.x3 := EQ.x3;
  fd.x4 := EQ.x4;

  fd.y1 := EQ.y1;
  fd.y2 := EQ.y2;
  fd.y3 := EQ.y3;
  fd.y4 := EQ.y4;

  fd.z1 := EQ.z1;
  fd.z2 := EQ.z2;
  fd.z3 := EQ.z3;
  fd.z4 := EQ.z4;

  fd.l1 := EQ.l1;
  fd.l2 := EQ.l2;
  fd.l3 := EQ.l3;
  fd.l4 := EQ.l4;

  fd.k1 := EQ.k1;
  fd.k2 := EQ.k2;
  fd.k3 := EQ.k3;
  fd.k4 := EQ.k4;

  fd.m1 := EQ.m1;
  fd.m2 := EQ.m2;
  fd.m3 := EQ.m3;
  fd.m4 := EQ.m4;

  fd.Dim := FDim;
  fd.DrawFigure := FDrawFigure;

  fd.Scene := FScene;
  fd.Graph := FGraph;
  fd.Plot := FPlot;
  fd.Figure := FFigure;

  fd.OffsetX := Round(FOffsetX);
  fd.OffsetY := Round(FOffsetY);
  fd.OffsetZ := Round(FOffsetZ);

  fd.MeshSize := FMeshSize;
  fd.Attenuation := Round(FAttenuation);
  fd.Limit := Round(FLimit);
  fd.Range := Round(FRange);
  fd.Param := FParam;

  fd.CapValue := Round(CapValue);
  fd.AbsoluteRange := Round(AbsoluteRange);

  fd.MinusCap := FMinusCap;
  fd.PlusCap := FPlusCap;
  fd.BigMap := FBigMap;
  fd.Pin := FPin;
  fd.Norm := FNorm;
  fd.TextureNorm := FTextureNorm;

  fd.T1 := Round(FT1);
  fd.T2 := Round(FT2);
  fd.T3 := Round(FT3);
  fd.T4 := Round(FT4);

  fd.ForceMode := FForceMode;
  fd.SolutionMode := FSolutionMode;
  fd.PlotFigure := FPlotFigure;
  fd.Vorzeichen := FVorzeichen;
  fd.Gleich := WantGleich;
  fd.LinearForce := EQ.LinearForce;

  fd.ParamBahnRadius := ParamBahnRadius;
  fd.ParamBahnPositionX := ParamBahnPositionX;
  fd.ParamBahnPositionY := ParamBahnPositionY;
  fd.ParamBahnAngle := ParamBahnAngle;
  fd.ParamBahnStrokeWidth1 := Round(ParamBahnStrokeWidth1);
  fd.ParamBahnStrokeWidth2 := Round(ParamBahnStrokeWidth2);
  fd.ParamBahnCylinderF := ParamBahnCylinderF;
  fd.ParamBahnCylinderD := Round(ParamBahnCylinderD) * 10;
  fd.ParamBahnCylinderZ := Round(ParamBahnCylinderZ) * 10;

  fd.ShowGrid := Main.FederScene.ShowGrid;
  fd.ShowKugel := Main.FederScene.ShowKugel;
  fd.ShowCylinder := Main.FederScene.ShowCylinder;
  fd.ShowDiameter := Main.FederScene.ShowDiameter;
  fd.ReducedMesh := Main.FederScene.ReducedMesh;

  fd.NullpunktX := MainVar.Transform2D.NullpunktX;
  fd.NullpunktY := MainVar.Transform2D.NullpunktY;
  fd.PaintboxZoom := MainVar.Transform2D.PaintboxZoom;
  fd.PaintboxRotation := MainVar.Transform2D.PaintboxRotation;

  fd.ColorScheme2D := MainVar.ColorScheme.Scheme;
  fd.ColorScheme3D := MainVar.ColorScheme.Scheme;

  fd.Lux1X := Round(Lux1X);
  fd.Lux1Y := Round(Lux1Y);
  fd.Lux1Z := Round(Lux1Z);

  fd.Lux2X := Round(Lux2X);
  fd.Lux2Y := Round(Lux2Y);
  fd.Lux2Z := Round(Lux2Z);

  fd.Modified := True;
end;

procedure TFederModel.SetInitData98(const Value: Boolean);
begin
  if not MainVar.GPUScale then
    MainVar.InitDataOK := Value;
end;

function TFederModel.GetInitDataOK: Boolean;
begin
  result := Main.InitDataOK;
end;

procedure TFederModel.SetInitDataOK(const Value: Boolean);
begin
  Main.InitDataOK := Value;
end;

procedure TFederModel.PrepCalc;
begin
  EQ.Attenuation := Attenuation;
  EQ.Limit := Limit;
  EQ.Figure := Figure;
  EQ.Plot := Plot;
  EQ.Dim := Dim;

  EQ.PlusCap := PlusCap;
  EQ.MinusCap := MinusCap;

  EQ.OffsetZ := OffsetZ;

  EQ.Vorzeichen := Vorzeichen;
  EQ.SolutionMode := SolutionMode;
  EQ.ForceMode := ForceMode;
  EQ.LinearForce := LinearForce;

  EQ.WantDiff := Main.WantDiff;
  EQ.WantDiffOnce := Main.WantDiffOnce;

  EQ.Hub := Main.Hub;
  EQ.Sample := Main.Sample;
end;

function TFederModel.GetBigMapFactorT2: Integer;
begin
  if BigMap then
    result := 10
  else
    result := 1;
end;

procedure TFederModel.DoTRS;
var
  AP1, AP2: single;
  temp: single;
begin
  AP1 := InitDataTRS(1.0);

  if FParamValue = FParamValueOld then
    temp := 1.0
  else if FParamValue > FParamValueOld then
    temp := 1.1
  else
    temp := 1 / 1.1;

  EQ.x1 := EQ.x1 * temp;
  EQ.y1 := EQ.y1 * temp;
  EQ.z1 := EQ.z1 * temp;
  EQ.l1 := EQ.l1 * temp;

  EQ.x2 := EQ.x2 * temp;
  EQ.y2 := EQ.y2 * temp;
  EQ.z2 := EQ.z2 * temp;
  EQ.l2 := EQ.l2 * temp;

  EQ.x3 := EQ.x3 * temp;
  EQ.y3 := EQ.y3 * temp;
  EQ.z3 := EQ.z3 * temp;
  EQ.l3 := EQ.l3 * temp;

  EQ.x4 := EQ.x4 * temp;
  EQ.y4 := EQ.y4 * temp;
  EQ.z4 := EQ.z4 * temp;
  EQ.l4 := EQ.l4 * temp;

  AP2 := InitDataTRS(temp);

  //there are two PrepareCalc methods
  //one in RiggVar.FB.Equation (TFederEquation.PrepareCalc;) used with CPU
  //and one in in RiggVar.FB.Mesh (TViewParams.PrepareCalc;) used with GPU

  //see procedure TViewParams.PrepareCalc;
  //Gain will be used there to set up fcap
  //which will be put into MP04.W := vp.fcap;
  //see procedure TFederConstantBufferData.Update;
  //in FederScene.Material.Buffer
  //and used in vertex shader code, this line:
  //z = z / fcap - OffsetZ;

  //we want to override fcap to keep z-range the same.
  if AP1 > 0.5 then
  begin
    CapOverride := True;
    CapFactor := AP2 / AP1;
  end
  else
  begin
    CapOverride := False;
  if temp > 1 then
    FAttenuation := Round(FAttenuation + 6.2)
  else
    FAttenuation := Round(FAttenuation - 6.2);
  end;

  FParamValueOld := FParamValue;
end;

function TFederModel.InitDataTRS(f: single): single;
begin
  EQ.ErrorCounter := 0;
  EQ.rmin := 0;
  EQ.rmax := 0;

  PrepCalc; // --> FEQ.Gain := Gain;
  EQ.PrepareCalc; // Same as TViewParams.PrepareCalc;

  result := EQ.CalcRaw(1.0 * f, 1.0 * f);
end;

{ TFederModelEQBase }

constructor TFederModelEQBase.Create;
begin
  EQ := TFederEquation.Create;
  EQIndex := 3;
end;

destructor TFederModelEQBase.Destroy;
begin
  EQ.Free;
  inherited;
end;

procedure TFederModelEQBase.SwapEQ(newEQIndex: Integer);
begin

end;

end.
