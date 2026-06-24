unit RiggVar.FB.Data;

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
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Bitmap;

type
  TFederData = class;

  ISampleHub = interface
    function GetCount: Integer;
    procedure UpdateSample(FederData: TFederData);
    procedure LoadSample(FederData: TFederData; ID: Integer);
    procedure LoadScript(ID: Integer);
    procedure Transit;
    property Count: Integer read GetCount;
  end;

  ISampleBundle = interface
    procedure LoadFromFile;
    procedure SaveToFile;

    function GetMatrixCount: Integer;
    function GetFederData(k: Integer): TFederData;

    function GetHub: Integer;
    function GetSample: Integer;

    procedure SetHub(const Value: Integer);
    procedure SetSample(const Value: Integer);

    function GetHubCount: Integer;
    function GetSampleCount: Integer;

    procedure NextHub;
    procedure PreviousHub;
    procedure GotoHub(h: Integer);

    procedure NextSample;
    procedure PrevSample;

    function GetSampleHub: ISampleHub;

    property SampleHub: ISampleHub read GetSampleHub;

    property Hub: Integer read GetHub write SetHub;
    property Sample: Integer read GetSample write SetSample;

    property HubCount: Integer read GetHubCount;
    property SampleCount: Integer read GetSampleCount;
  end;

  TFederData0 = class
  protected
    FParam: Integer;
    FBitmap: Integer;
    FColorScheme2D: Integer;
    FColorScheme3D: Integer;
    function GetGraphFactor: single;
    function GetBitmap: Integer; virtual;
    function GetParam: Integer; virtual;
    function GetColorScheme2D: Integer; virtual;
    function GetColorScheme3D: Integer; virtual;
  public
    x1, x2, x3, x4: single;
    y1, y2, y3, y4: single;
    z1, z2, z3, z4: single;
    l1, l2, l3, l4: single;
    k1, k2, k3, k4: single;
    m1, m2, m3, m4: Integer;

    Dim: Integer;
    DrawFigure: Integer;

    Scene: Integer;
    Graph: Integer;
    Plot: Integer;
    Figure: Integer;
    Color: Integer;

    OffsetX: Integer;
    OffsetY: Integer;
    OffsetZ: Integer;

    MeshSize: Integer;
    Attenuation: Integer;
    Limit: Integer;
    Range: Integer;

    CapValue: Integer;
    AbsoluteRange: Integer;

    MinusCap: Boolean;
    PlusCap: Boolean;
    Opacity: Boolean;
    Bigmap: Boolean;
    Pin: Boolean;
    Norm: Boolean;
    TextureNorm: Integer;

    AngleX: single;
    AngleY: single;
    AngleZ: single;
    PosX: single;
    PosY: single;
    PosZ: single;
    PosZ1: single;
    PosZ2: single;

    T1: Integer;
    T2: Integer;
    T3: Integer;
    T4: Integer;

    ForceMode: Integer;
    SolutionMode: Boolean;
    PlotFigure: Integer;
    Vorzeichen: Boolean;
    Gleich: Boolean;
    LinearForce: Boolean;
    SliceMode: Integer;

    ReducedMesh: Boolean;

    IV: single;
    IW: single;
    JV: single;
    JW: single;

    ParamBahnRadius: single;
    ParamBahnPositionX: single;
    ParamBahnPositionY: single;
    ParamBahnAngle: single;
    ParamBahnStrokeWidth1: Integer;
    ParamBahnStrokeWidth2: Integer;
    ParamBahnCylinderF: single;
    ParamBahnCylinderD: Integer;
    ParamBahnCylinderZ: Integer;

    ShowGrid: Boolean;
    ShowKugel: Boolean;
    ShowCylinder: Boolean;
    ShowDiameter: Boolean;
    ShowLB: Boolean;
    ShowLL: Boolean;
    ShowLC1: Boolean;
    ShowLC2: Boolean;

    NullpunktX: single;
    NullpunktY: single;
    PaintboxZoom: single;
    PaintboxRotation: single;

    Lux: Boolean;

    Lux1: Boolean;
    Lux1X: Integer;
    Lux1Y: Integer;
    Lux1Z: Integer;

    Lux2: Boolean;
    Lux2X: Integer;
    Lux2Y: Integer;
    Lux2Z: Integer;

    Lux3: Boolean;
    Lux3X: Integer;
    Lux3Y: Integer;
    Lux3Z: Integer;

    Lux4: Boolean;
    Lux4X: Integer;
    Lux4Y: Integer;
    Lux4Z: Integer;

    { ColorBand Properties }

    BlindColorCount: Integer;
    StripWidth: Integer;
    BandWidth: Integer;
    StandardColor: Integer;

    WantContour: Boolean;
    WantShirtColor: Boolean;
    SquareBitmap: Boolean;
    HorizontalBitmap: Boolean;
    SquareSym: Boolean;
    RandomPaint: Boolean;
    StandardPaint: Boolean;
    MonoPaint: Boolean;

    StripColor: TAlphaColor;
    BackgroundColor: TAlphaColor;

    procedure InitLimitFromCapValue;
    procedure InitCapValueFromLimit;
    procedure InitRangeFromAbsoluteRange;
    procedure InitAbsoluteRangeFromRange;

    function GetRangeFromAbsoluteRange: single;

    property Gain: Integer read Attenuation write Attenuation;
    property Param: Integer read GetParam write FParam;
    property Bitmap: Integer read GetBitmap write FBitmap;
    property ColorScheme2D: Integer read GetColorScheme2D write FColorScheme2D;
    property ColorScheme3D: Integer read GetColorScheme3D write FColorScheme3D;
  end;

  TFederData = class(TFederData0)
  private
    FVersion: Integer;
    FModified: Boolean;

    FLockedParam: Integer;
    FLockedTexture: Integer;
    FLockedBackground: Integer;

    FParamLock: Boolean;
    FTextureLock: Boolean;
    FBackgroundLock: Boolean;

    FForceLock: Boolean;
    FLuxLock: Boolean;

    FHasModelInfo: Boolean;
    FHasStripColor: Boolean;
    FHasBandColor: Boolean;
    ColorCache: TStringList;
    TempColorBand: TColorBand;
    FHasBandProps: Boolean;
    function GetHasColorInfo: Boolean;
    procedure SetBands(j: Integer; const Value: string);
    function GetComputedTitle: string;
  protected
    function StrToAlphaColorDef(const s: string; DefaultColor: TAlphaColor = claWhite): TAlphaColor;
    function GetBitmap: Integer; override;
    function GetParam: Integer; override;
    function GetColorScheme2D: Integer; override;
    function GetColorScheme3D: Integer; override;

    procedure SetLockedParam(const Value: Integer);
    procedure SetLockedTexture(const Value: Integer);
    procedure SetLockedBackground(const Value: Integer);

    procedure SetParamLock(const Value: Boolean);
    procedure SetTextureLock(const Value: Boolean);
    procedure SetBackgroundLock(const Value: Boolean);

    procedure SetForceLock(const Value: Boolean);
    procedure SetLuxLock(const Value: Boolean);

    procedure SetModified(const Value: Boolean);

    procedure FormatDiff(ML: TStrings; s: string);
    procedure FormatLine(ML: TStrings; k, v: string);

    procedure Check(ML: TStrings);
    procedure ReadVersion(ML: TStrings);
    function IsCode(ML: TStrings): Boolean;
    function IsBinCode(ML: TStrings): Boolean;

    function WrapAngleX: single;
    function WrapAngleY: single;
    function WrapAngleZ: single;

    procedure ParseBandInfo(s: string);
    procedure ParseColorCode(s: string);
    procedure ParseBinColorCode(s: string);
    function ParseKeyInteger(s: string): Integer;

    procedure ReadColorCode(ML: TStrings);
    function TokenOK(a, b: Integer): Boolean;

    function GetScript: TStrings; virtual;
    function GetScriptLineCount: Integer; virtual;
  public
    WantTags: Boolean;
    SLSampleData: TStringList;
    SLAnimationData: TStringList;

    Title: string;
    SubTitle: string;
    ParallelAnimationValue: single;

    ColorStrip: TColorStrip;
    ColorBands: TColorBands;

    class var
      Want2D: Boolean;
      DB: Integer;
      DefaultSlot: Boolean;

    constructor Create;
    destructor Destroy; override;

    procedure SetBandColor(j: Integer; cs: string);
    procedure SetStripColor(j: Integer; cs: string);
    procedure InitDefault;
    procedure InitSample1;
    procedure ResetUI;
    procedure ResetCodeFlags;

    procedure Load(ML: TStrings);
    procedure Assign(fd: TFederData);

    procedure LoadNativeBin(ML: TStrings); virtual;
    procedure LoadNative(ML: TStrings); virtual;
    procedure SaveNative(ML: TStrings); virtual;
    procedure LoadVirtual(ML: TStrings); virtual;
    procedure SaveVirtual(ML: TStrings); virtual;

    procedure LoadCode(ML: TStrings);
    procedure LoadBinCode(ML: TStrings);
    procedure SaveCode(ML: TStrings); virtual;
    procedure SaveDiffBin(fd: TFederData; ML: TStrings); virtual;
    procedure SaveDiffCode(fd: TFederData; ML: TStrings); virtual;
    procedure ShowVersion1Diff(fd: TFederData; ML: TStrings); virtual;
    procedure WriteVersion1Diff(fd: TFederData; ML: TStrings); virtual;

    property Modified: Boolean read FModified write SetModified;
    property HasModelInfo: Boolean read FHasModelInfo write FHasModelInfo;
    property HasBandProps: Boolean read FHasBandProps write FHasBandProps;
    property HasStripColor: Boolean read FHasStripColor write FHasStripColor;
    property HasBandColor: Boolean read FHasBandColor write FHasBandColor;
    property HasColorInfo: Boolean read GetHasColorInfo;
    property Bands[j: Integer]: string write SetBands;

    property LockedParam: Integer read FLockedParam write SetLockedParam;
    property LockedTexture: Integer read FLockedTexture write SetLockedTexture;
    property LockedBackground: Integer read FLockedBackground write SetLockedBackground;

    property ParamLock: Boolean read FParamLock write SetParamLock;
    property TextureLock: Boolean read FTextureLock write SetTextureLock;
    property BackgroundLock: Boolean read FBackgroundLock write SetBackgroundLock;
    property ForceLock: Boolean read FForceLock write SetForceLock;
    property LuxLock: Boolean read FLuxLock write SetLuxLock;

    property ScriptLineCount: Integer read GetScriptLineCount;
    property Script: TStrings read GetScript;
    property Version: Integer read FVersion write FVersion;
    property ComputedTitle: string read GetComputedTitle;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederData0 }

function TFederData0.GetBitmap: Integer;
begin
  result := FBitmap;
end;

function TFederData0.GetColorScheme2D: Integer;
begin
  result := FColorScheme2D;
end;

function TFederData0.GetColorScheme3D: Integer;
begin
  result := FColorScheme3D;
end;

function TFederData0.GetParam: Integer;
begin
  result := FParam;
end;

function TFederData0.GetGraphFactor: single;
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

function TFederData0.GetRangeFromAbsoluteRange: single;
var
  f: single;
begin
  f := GetGraphFactor;
  result := (AbsoluteRange / f) - 50;
end;

procedure TFederData0.InitLimitFromCapValue;
begin
  Limit := CapValue - 100;
end;

procedure TFederData0.InitCapValueFromLimit;
begin
  CapValue := 100 + Limit;
end;

procedure TFederData0.InitRangeFromAbsoluteRange;
begin
  Range := Round(GetRangeFromAbsoluteRange);
end;

procedure TFederData0.InitAbsoluteRangeFromRange;
var
  f: single;
begin
  f := GetGraphFactor;
  AbsoluteRange := Round((Range + 50) * f);
end;

{ TFederData }

constructor TFederData.Create;
begin
  TempColorBand := TColorBand.Create;
  SLSampleData := TStringList.Create;
  SLAnimationData := TStringList.Create;
  ColorBands := TColorBands.Create;
  ColorBands.InitItems(36);
  ColorStrip := TColorStrip.Create;
  ColorCache := TStringList.Create;
  InitDefault;
end;

destructor TFederData.Destroy;
begin
  TempColorBand.Free;
  SLSampleData.Free;
  SLAnimationData.Free;
  ColorBands.Free;
  ColorStrip.Free;
  ColorCache.Free;
  inherited;
end;

procedure TFederData.Assign(fd: TFederData);
begin
  x1 := fd.x1;
  x2 := fd.x2;
  x3 := fd.x3;
  x4 := fd.x4;

  y1 := fd.y1;
  y2 := fd.y2;
  y3 := fd.y3;
  y4 := fd.y4;

  z1 := fd.z1;
  z2 := fd.z2;
  z3 := fd.z3;
  z4 := fd.z4;

  l1 := fd.l1;
  l2 := fd.l2;
  l3 := fd.l3;
  l4 := fd.l4;

  k1 := fd.k1;
  k2 := fd.k2;
  k3 := fd.k3;
  k4 := fd.k4;

  m1 := fd.m1;
  m2 := fd.m2;
  m3 := fd.m3;
  m4 := fd.m4;

  Dim := fd.Dim;
  DrawFigure := fd.DrawFigure;

  Scene := fd.Scene;
  Graph := fd.Graph;
  Plot := fd.Plot;
  Figure := fd.Figure;

  Bitmap := fd.FBitmap;
  Color := fd.Color;

  OffsetX := fd.OffsetX;
  OffsetY := fd.OffsetY;
  OffsetZ := fd.OffsetZ;

  MeshSize := fd.MeshSize;
  Attenuation := fd.Attenuation;
  Limit := fd.Limit;
  Range := fd.Range;
  Param := fd.FParam;

  CapValue := fd.CapValue;
  AbsoluteRange := fd.AbsoluteRange;

  MinusCap := fd.MinusCap;
  PlusCap := fd.PlusCap;
  Opacity := fd.Opacity;
  Bigmap := fd.Bigmap;
  Pin := fd.Pin;
  Norm := fd.Norm;
  TextureNorm := fd.TextureNorm;

  AngleX := fd.AngleX;
  AngleY := fd.AngleY;
  AngleZ := fd.AngleZ;
  PosX := fd.PosX;
  PosY := fd.PosY;
  PosZ := fd.PosZ;

  T1 := fd.T1;
  T2 := fd.T2;
  T3 := fd.T3;
  T4 := fd.T4;

  ForceMode := fd.ForceMode;
  SolutionMode := fd.SolutionMode;
  PlotFigure := fd.PlotFigure;
  Vorzeichen := fd.Vorzeichen;
  Gleich := fd.Gleich;
  Linearforce := fd.LinearForce;
  SliceMode := fd.SliceMode;

  ReducedMesh := fd.ReducedMesh;

  IV := fd.IV;
  IW := fd.IW;
  JV := fd.JV;
  JW := fd.JW;

  ParamBahnRadius := fd.ParamBahnRadius;
  ParamBahnPositionX := fd.ParamBahnPositionX;
  ParamBahnPositionY := fd.ParamBahnPositionY;
  ParamBahnAngle := fd.ParamBahnAngle;
  ParamBahnStrokeWidth1 := fd.ParamBahnStrokeWidth1;
  ParamBahnStrokeWidth2 := fd.ParamBahnStrokeWidth2;
  ParamBahnCylinderF := fd.ParamBahnCylinderF;
  ParamBahnCylinderD := fd.ParamBahnCylinderD;
  ParamBahnCylinderZ := fd.ParamBahnCylinderZ;

  ShowGrid := fd.ShowGrid;
  ShowKugel := fd.ShowKugel;
  ShowCylinder := fd.ShowCylinder;
  ShowDiameter := fd.ShowDiameter;
  ShowLB := fd.ShowLB;
  ShowLL := fd.ShowLL;
  ShowLC1 := fd.ShowLC1;
  ShowLC2 := fd.ShowLC2;

  NullpunktX := fd.NullpunktX;
  NullpunktY := fd.NullpunktY;
  PaintboxZoom := fd.PaintboxZoom;
  PaintboxRotation := fd.PaintboxRotation;

  ColorScheme2D := fd.FColorScheme2D;
  ColorScheme3D := fd.FColorScheme3D;

  ColorStrip.Assign(fd.ColorStrip);
  ColorBands.Clone(fd.ColorBands);

  Lux := fd.Lux;

  Lux1 := fd.Lux1;
  Lux1X := fd.Lux1X;
  Lux1Y := fd.Lux1Y;
  Lux1Z := fd.Lux1Z;

  Lux2 := fd.Lux2;
  Lux2X := fd.Lux2X;
  Lux2Y := fd.Lux2Y;
  Lux2Z := fd.Lux2Z;

  Lux3 := fd.Lux3;
  Lux3X := fd.Lux3X;
  Lux3Y := fd.Lux3Y;
  Lux3Z := fd.Lux3Z;

  Lux4 := fd.Lux4;
  Lux4X := fd.Lux4X;
  Lux4Y := fd.Lux4Y;
  Lux4Z := fd.Lux4Z;

  FModified := fd.Modified;
end;

procedure TFederData.SaveVirtual(ML: TStrings);
begin
  SaveNative(ML);
end;

function TFederData.GetBitmap: Integer;
begin
  if TextureLock then
    result  := FLockedTexture
  else
    result := FBitmap;
end;

function TFederData.GetColorScheme2D: Integer;
begin
  if BackgroundLock then
    result  := FLockedBackground
  else
    Result := FColorScheme2D;
end;

function TFederData.GetColorScheme3D: Integer;
begin
  if BackgroundLock then
    result  := FLockedBackground
  else
    Result := FColorScheme3D;
end;

function TFederData.GetComputedTitle: string;
begin
  if SubTitle <> '' then
    result := Format('"%s, %s."', [Title, SubTitle])
  else
    result := Title;
end;

function TFederData.GetHasColorInfo: Boolean;
begin
  result := HasBandColor or HasStripColor;
end;

procedure TFederData.SetLockedBackground(const Value: Integer);
begin
  FLockedBackground := Value;
end;

procedure TFederData.SetLockedTexture(const Value: Integer);
begin
  FLockedTexture := Value;
end;

procedure TFederData.SetLockedParam(const Value: Integer);
begin
  FLockedParam := Value;
end;

procedure TFederData.SetLuxLock(const Value: Boolean);
begin
  FLuxLock := Value;
end;

procedure TFederData.SetModified(const Value: Boolean);
begin
  FModified := Value;
end;

function TFederData.GetParam: Integer;
begin
  if ParamLock then
    result := FLockedParam
  else
    result := FParam;
end;

function TFederData.GetScript: TStrings;
begin
  result := SLAnimationData;
end;

function TFederData.GetScriptLineCount: Integer;
begin
  result := SLAnimationData.Count;
end;

function TFederData.IsBinCode(ML: TStrings): Boolean;
begin
  if ML.Count > 1 then
  begin
    result := Pos('0=', ML[0]) > 0;
  end
  else
    result := false;
end;

function TFederData.IsCode(ML: TStrings): Boolean;
begin
  result := false;

  { first attempt }
  if ML.Count > 1 then
  begin
    //result := Trim(ML[0]) = 'with fd do';
    result := Pos(':=', ML[1])  > 0;
  end;

  { second attempt }
  if (result = False) and (ML.Count > 3) then
  begin
    { // Sample 0-0-1 from FC91 }
    { // 15.05.2025 10:57:55 }
    result := Pos(':=', ML[3])  > 0;
  end;

end;

procedure TFederData.SetTextureLock(const Value: Boolean);
begin
  FTextureLock := Value;
  FLockedTexture := FBitmap;
end;

procedure TFederData.SetParamLock(const Value: Boolean);
begin
  FParamLock := Value;
  FLockedParam := FParam;
end;

procedure TFederData.SetBackgroundLock(const Value: Boolean);
begin
  FBackgroundLock := Value;
  FLockedBackground := MainVar.ColorScheme.Scheme;
end;

procedure TFederData.SetForceLock(const Value: Boolean);
begin
  FForceLock := Value;
end;

function TFederData.WrapAngleX: single;
begin
//  if AngleX = 180 then
//    result := 0
//  else
    result := AngleX;
end;

function TFederData.WrapAngleY: single;
begin
//  if AngleY = 90 then
//    result := 0
//  else
    result := AngleY;
end;

function TFederData.WrapAngleZ: single;
begin
//  if AngleZ = 180 then
//    result := 0
//  else
    result := AngleZ;
end;

procedure TFederData.SetStripColor(j: Integer; cs: string);
begin
  ColorStrip.Color[j] := StringToAlphaColor(cs);
end;

procedure TFederData.SetBandColor(j: Integer; cs: string);
var
  cr: TColorBand;
begin
  if TempColorBand.Parse(cs) then
  case j of
//    0: StripColor := TempColorBand.Color;
//    35: BackgroundColor := TempColorBand.Color;
    0..35:
    //1..34:
    begin
      cr := ColorBands[j];
      cr.Ring := j;
      cr.Width := TempColorBand.Width;
      cr.Color := TempColorBand.Color;
      cr.Contour := TempColorBand.Contour;
    end;
  end;
end;

procedure TFederData.LoadBinCode(ML: TStrings);
var
  i: Integer;
  s: string;
  k: Integer;
begin
  for i := 0 to ML.Count-1 do
  begin
    s := Trim(ML[i]);
    if s = '' then
      Continue;
    k := ParseKeyInteger(s);
    if k >= 900 then
    begin
      ParseBinColorCode(s);
      Continue;
    end;
  end;
  if ML.Count > 0 then
  begin
    Check(ML);
    ReadVersion(ML);
    LoadNativeBin(ML)
  end;
end;

procedure TFederData.LoadCode(ML: TStrings);
var
  i: Integer;
  s: string;
begin
  FHasModelInfo := True;
  FHasStripColor := False;
  FHasBandColor := False;
  FHasBandProps := True;
  for i := 0 to ML.Count-1 do
  begin
    s := Trim(ML[i]);
    if s.StartsWith('//') then
      Continue;
    if s = '' then
      Continue;
    if Pos('with', s) > 0 then
      Continue;
    if Pos('begin', s) > 0 then
      Continue;
    if Pos('end;', s) > 0 then
      Continue;
    if Pos('StripColor(', s) > 0 then
    begin
      if i < 1 then
        FHasBandProps := False;
      if i < 17 then
        FHasModelInfo := False;
      FHasStripColor := True;
      ParseColorCode(s);
      Continue;
    end;
    if Pos('Bands[', s) > 0 then
    begin
      if i < 1 then
        FHasBandProps := False;
      if i < 17 then
        FHasModelInfo := False;
      FHasBandColor := True;
      ParseBandInfo(s);
      Continue;
    end;
//    else if (Pos('900=', s) > 0) or (Pos('=#', s) > 0) then
//    begin
//      ParseBinColorCode(s);
//      Continue;
//    end;
    s := StringReplace(s, ':=', '=', []);
    s := StringReplace(s, ';', '', []);
    ML[i] := s;
  end;
  if ML.Count > 0 then
  begin
    Check(ML);
    ReadVersion(ML);
//    if IsBinCode(ML) then
//      LoadBinCode(ML)
//    else
      LoadNative(ML);
  end;
end;

procedure TFederData.ReadVersion(ML: TStrings);
var
  s: string;
begin
  FVersion := 2;
  { Check has been called before on ML ! }
  s := ML.Values['Version'];
  if s = '' then
    s := ML.Values['version'];
  FVersion := StrToIntDef(s, 2);
end;

procedure TFederData.Check(ML: TStrings);
var
  s: string;
  temp: string;
  i, l: Integer;
begin
  for l := 0 to ML.Count-1 do
  begin
    s := ML[l];
    i := Pos('=', s);
    if i > 0 then
    begin
      temp := Trim(Copy(s, 1, i-1)) + '=' + Trim(Copy(s, i+1, Length(s)));
      ML[l] := temp;
    end
    else
      temp := StringReplace(Trim(s), ' ', '_', [rfReplaceAll]);
  end;
end;

procedure TFederData.Load(ML: TStrings);
begin
  if IsBinCode(ML) then
  begin
    ColorStrip.Clear;
    ColorCache.Clear;
    LoadBinCode(ML);
    ReadColorCode(ColorCache);
    ColorCache.Clear;
  end
  else if IsCode(ML) then
  begin
    ColorStrip.Clear;
    ColorCache.Clear;
    LoadCode(ML);
    ReadColorCode(ColorCache);
    ColorCache.Clear;
  end
  else
  begin
    Check(ML);
    ReadVersion(ML);
    if FVersion = 1 then
      LoadNative(ML)
    else
      LoadVirtual(ML);
  end;
  FModified := False;
end;

procedure TFederData.ReadColorCode(ML: TStrings);
var
  i: Integer;
  k: string;
  j: Integer;
  v: string;
begin
  for i := 0 to ML.Count-1 do
  begin
    k := ML.Names[i];
    j := StrToIntDef(k, -1);
    v := ML.Values[k];
    if HasStripColor then
      SetStripColor(j, v);
    if HasBandColor then
      SetBandColor(j, v);
  end;
end;

function TFederData.TokenOK(a, b: Integer): Boolean;
begin
  result := (b > a)
    and (a > -1)
    and (b > - 1)
    and (b - a > 0)
end;

procedure TFederData.ParseBinColorCode(s: string);
var
  j: Integer;
  cs: string;
  js: string;
  StartIndex, EndIndex, l: Integer;
begin
  //900=Green
  //901=#FFB5EBC3
  //902=010-162-185-115

  j := -1;
  StartIndex := 0;
  EndIndex := s.IndexOf('=');
  if TokenOK(StartIndex, EndIndex) then
  begin
    { extract Param j }
    l := EndIndex - StartIndex;
    js := s.Substring(StartIndex, l);
    js := js.Trim;
    j := StrToIntDef(js, -1) - nStripColorOffset;
    { extract Param cs }
    cs := s.Substring(EndIndex + 1);
    cs := cs.Trim;
  end;
  if (j > -1) and (cs <> '') then
    ColorCache.Add(Format('%d=%s', [j, cs]));
end;

procedure TFederData.ParseColorCode(s: string);
var
  j: Integer;
  cs: string;
  js: string;
  StartIndex, EndIndex, l: Integer;
begin
  //StripColor(0, 'Green');
  //StripColor(1, '#FFB5EBC3');

  { extract Param j }
  j := -1;
  StartIndex := s.IndexOf('(') + 1;
  EndIndex := s.IndexOf(',');
  if TokenOK(StartIndex, EndIndex) then
  begin
    l := EndIndex - StartIndex;
    js := s.Substring(StartIndex, l);
    js := js.Trim;
    j := StrToIntDef(js, -1);
  end;

  { extract Param cs }
  cs := '';
  StartIndex := s.IndexOf('''') + 1;
  EndIndex := s.IndexOf(''')');
  if TokenOK(StartIndex, EndIndex) then
  begin
    l := EndIndex - StartIndex;
    cs := s.Substring(StartIndex, l);
    cs := cs.Trim;
  end;

  if (j > -1) and (cs <> '') then
    ColorCache.Add(Format('%d=%s', [j, cs]));
end;

procedure TFederData.ParseBandInfo(s: string);
var
  j: Integer;
  cs: string;
  js: string;
  StartIndex, EndIndex, l: Integer;
begin
  //Bands[01] := '010-162-185-115';
  //or
  //Bands[01] := '010-Red';

  { extract Param j }
  j := -1;
  StartIndex := s.IndexOf('[') + 1;
  EndIndex := s.IndexOf(']');
  if TokenOK(StartIndex, EndIndex) then
  begin
    l := EndIndex - StartIndex;
    js := s.Substring(StartIndex, l);
    js := js.Trim;
    j := StrToIntDef(js, -1);
  end;

  { extract Param cs }
  cs := '';
  StartIndex := s.IndexOf('''') + 1;
  EndIndex := s.IndexOf(''';');
  if TokenOK(StartIndex, EndIndex) then
  begin
    l := EndIndex - StartIndex;
    cs := s.Substring(StartIndex, l);
    cs := cs.Trim;
  end;

  if (j > -1) and (cs <> '') then
    ColorCache.Add(Format('%d=%s', [j, cs]));
end;

function TFederData.ParseKeyInteger(s: string): Integer;
var
  js: string;
  StartIndex, EndIndex, l: Integer;
begin
  result := -1;
  StartIndex := 0;
  EndIndex := s.IndexOf('=');
  if TokenOK(StartIndex, EndIndex) then
  begin
    l := EndIndex - StartIndex;
    js := s.Substring(StartIndex, l);
    js := js.Trim;
    result := StrToIntDef(js, result);
  end;
end;

procedure TFederData.ResetUI;
begin
  Dim := 5;
  DrawFigure := 1;

  Scene := 3;
  Graph := 3;
  Plot := 10;
  Figure := 3;
  Bitmap := 1;
  Color := 1;
  Param := 1;

  MinusCap := False;
  PlusCap := False;
  Opacity := False;
  Bigmap := False;
  Pin := False;
  Norm := False;
  TextureNorm := 0;

  ForceMode := 0;
  SolutionMode := True;
  PlotFigure := 1;
  Vorzeichen := False;
  Gleich := False;
  LinearForce := True;
  SliceMode := 0;

  ShowGrid := False;
  ShowKugel := False;
  ShowCylinder := False;
  ShowDiameter := False;
  ShowLB := True;
  ShowLL := False;
  ShowLC1 := True;
  ShowLC2 := False;

  Lux := False;

  Lux1 := False;
  Lux1X := 0;
  Lux1Y := 0;
  Lux1Z := LightConst.Front;

  Lux2 := False;
  Lux2X := 0;
  Lux2Y := 0;
  Lux2Z := LightConst.Back;

  Lux3 := False;
  Lux3X := LightConst.West;
  Lux3Y := 0;
  Lux3Z := LightConst.WestZ;

  Lux4 := False;
  Lux4X := 0;
  Lux4Y := LightConst.North;
  Lux4Z := 0;
end;

procedure TFederData.InitDefault;
begin
  x1 := -10;
  x2 := 10;
  x3 := 0;
  x4 := 0;

  y1 := -10;
  y2 := -10;
  y3 := 10;
  y4 := 0;

  z1 := 0;
  z2 := 0;
  z3 := 0;
  z4 := 0;

  l1 := 10;
  l2 := 10;
  l3 := 10;
  l4 := 10;

  k1 := 1;
  k2 := 1;
  k3 := 1;
  k4 := 1;

  m1 := 0;
  m2 := 0;
  m3 := 0;
  m4 := 0;

  Dim := 5;
  DrawFigure := 1;

  Scene := 3;
  Graph := 3;
  Plot := 3;
  Figure := 3;
  Bitmap := 1;
  Color := 1;

  OffsetX := 0;
  OffsetY := 0;
  OffsetZ := 0;

  MeshSize := MainConst.DefaultMeshSize;
  Attenuation := 0;
  Limit := -75;
  Range := 0;
  Param := 14;

  InitCapValueFromLimit;
  AbsoluteRange := 0;

  MinusCap := False;
  PlusCap := False;
  Opacity := False;
  Bigmap := False;
  Pin := False;
  Norm := False;
  TextureNorm := 0;

  AngleX := 0.00;
  AngleY := 0.00;
  AngleZ := 0.00;
  PosX := 0;
  PosY := 0;
  PosZ := 20;
  PosZ1 := 0;
  PosZ2 := 0;

  T1 := 0;
  T2 := 50;
  T3 := StripConst.DefaultStripWidth;
  T4 := StripConst.DefaultBandWidth;

  ForceMode := 0;
  SolutionMode := True;
  PlotFigure := 1;
  Vorzeichen := False;
  Gleich := False;
  LinearForce := True;
  SliceMode := 0;

  ReducedMesh := False;

  IV := 30;
  IW := 5;
  JV := 150;
  JW := 5;

  ParamBahnRadius := 100;
  ParamBahnPositionX := 0;
  ParamBahnPositionY := 0;
  ParamBahnAngle := 0;
  ParamBahnCylinderF := 0;
  ParamBahnCylinderD := 10;
  ParamBahnCylinderZ := 0;

  ShowGrid := False;
  ShowKugel := False;
  ShowCylinder := True;
  ShowDiameter := True;
  ColorScheme3D := MainVar.ColorScheme.Scheme;

  ShowLB := True;
  ShowLL := True;
  ShowLC1 := True;
  ShowLC2 := True;

  NullpunktX := 400;
  NullpunktY := 400;
  PaintboxZoom := 1;
  PaintboxRotation := 0;

  ColorScheme2D := MainVar.ColorScheme.Scheme;
  ParamBahnStrokeWidth1 := 1;
  ParamBahnStrokeWidth2 := 2;

  Lux := False;

  Lux1 := True;
  Lux1X := 0;
  Lux1Y := 0;
  Lux1Z := LightConst.Front;

  Lux2 := False;
  Lux2X := 0;
  Lux2Y := 0;
  Lux2Z := LightConst.Back;

  Lux3 := True;
  Lux3X := LightConst.West;
  Lux3Y := 0;
  Lux3Z := LightConst.WestZ;

  Lux4 := False;
  Lux4X := 0;
  Lux4Y := LightConst.North;
  Lux4Z := 0;

  BlindColorCount := 0;

  StripWidth := StripConst.DefaultStripWidth;
  BandWidth := StripConst.DefaultBandWidth;

  StandardColor := 17;

  WantContour := True;
  WantShirtColor := False;

  SquareBitmap := False;
  HorizontalBitmap := False;
  SquareSym := False;

  RandomPaint := False;
  StandardPaint := True;
  MonoPaint := False;

  StripColor := claBlack;
  BackgroundColor := claWhite;

  ColorStrip.Clear;
end;

procedure TFederData.LoadVirtual(ML: TStrings);
begin
  LoadNative(ML);
end;

procedure TFederData.FormatDiff(ML: TStrings; s: string);
begin
  ML.Add('TS(''' + s + ''');');
end;

procedure TFederData.FormatLine(ML: TStrings; k, v: string);
begin
  ML.Add(k + '=' + v);
end;

procedure TFederData.SaveCode(ML: TStrings);
begin

end;

procedure TFederData.SaveDiffBin(fd: TFederData; ML: TStrings);
begin

end;

procedure TFederData.SaveDiffCode(fd: TFederData; ML: TStrings);
begin

end;

procedure TFederData.SaveNative(ML: TStrings);
begin

end;

procedure TFederData.LoadNative(ML: TStrings);
begin

end;

procedure TFederData.LoadNativeBin(ML: TStrings);
begin

end;

procedure TFederData.WriteVersion1Diff(fd: TFederData; ML: TStrings);
begin

end;

procedure TFederData.ShowVersion1Diff(fd: TFederData; ML: TStrings);
begin

end;

function TFederData.StrToAlphaColorDef(const s: string; DefaultColor: TAlphaColor): TAlphaColor;
var
  sr: string;
  sg: string;
  sb: string;
  r, g, b: Byte;
  sa: TArray<string>;
begin
  result := DefaultColor;
  //RRR-GGG-BBB
  if Length(s) = 11 then
  begin
    sa := s.Split(['-']);
    if Length(sa) = 3 then
    begin
      sr := sa[0];
      sg := sa[1];
      sb := sa[2];
      r := StrToIntDef(sr, 0);
      g := StrToIntDef(sg, 0);
      b := StrToIntDef(sb, 0);
      result := MakeColor(r, g, b);
    end;
  end;
end;

procedure TFederData.SetBands(j: Integer; const Value: string);
begin
  TempColorBand.Parse(Value);

  case j of
    0: StripColor := TempColorBand.Color;
    35: BackgroundColor := TempColorBand.Color;
  end;

  case j of
    0..35:
    begin
      HasBandColor := True;
      ColorBands[j].Ring := j;
      ColorBands[j].Width := TempColorBand.Width;
      ColorBands[j].Color := TempColorBand.Color;
    end;
  end;

end;

procedure TFederData.ResetCodeFlags;
begin
  FHasModelInfo := True;
  FHasStripColor := False;
  FHasBandColor := False;
  FHasBandProps := True;
end;

procedure TFederData.InitSample1;
begin
  Version := 2;
  InitDefault;

  x1 := 64.95;
  x2 := -64.95;
  y1 := 37.5;
  y2 := 37.5;
  y3 := -75;
  l1 := 90;
  l2 := 90;
  l3 := 90;
  l4 := 90;
  Range := 40;
  Plot := 10;
  Figure := 2;
  Param := 14;
  Bitmap := 17;
  AngleX := 180.00;
  PosZ := 9.15;
  T1 := 11;
  T2 := 200;
  ShowCylinder := False;
  ShowDiameter := False;
  ColorScheme3D := 4;
end;

end.
