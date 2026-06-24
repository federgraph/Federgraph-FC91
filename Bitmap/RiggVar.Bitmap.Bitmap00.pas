unit RiggVar.Bitmap.Bitmap00;

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
  System.UIConsts,
  System.UITypes,
  System.SysUtils,
  System.Classes,
  RiggVar.Bitmap.Strips,
  RiggVar.Bitmap.Bands,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst;

type
  TStripColors = class
  private
    FBlindColorCount: Integer;
    FColorMix: Integer;
    procedure RotateColorsM;
    procedure RotateColorsP;
    procedure SetBlindColorCount(const Value: Integer);
    function GetRingColor(j: Integer): TAlphaColor;
    procedure SetRingColor(j: Integer; const Value: TAlphaColor);
    procedure SetStripColor(const Value: TAlphaColor);
    procedure SetBackgroundColor(const Value: TAlphaColor);
    function GetBackgroundColor: TAlphaColor;
    function GetStripColor: TAlphaColor;
    procedure SetUpdatingRings(const Value: Boolean);
    procedure SetColorMix(const Value: Integer);
    function GetBlindColorCount: Integer;
  protected
    FUpdatingRings: Boolean;
    ColorBand: TColorBand;
  public
    ColorCache: TColorBands;
    ColorBands: TColorBands;

    UpdateReason: TUpdateReason;

    StripWidth: Integer;
    BandWidth: Integer;

    SchemeID: Integer;

    WantContour: Boolean;
    WantShirtColor: Boolean;
    WantShirtFarbe: Boolean;

    SquareBitmap: Boolean;
    HorizontalBitmap: Boolean;
    SquareSym: Boolean;

    RandomPaint: Boolean;
    StandardPaint: Boolean;
    MonoPaint: Boolean;

    BlindColorOverride: Boolean;
    BlindColorOverrideValue: Integer;

    UseViewportBackground: Boolean;
    BackgroundColorOverride: Boolean;
    BackgroundColorOverrideValue: TAlphaColor;

    ShowCurrentBand: Boolean;
    ContourOverride: Boolean;
    ContourOverrideValue: Boolean;

    class var
      StripColorData: TStripColorData;
      BandColorData: TBandColorData;

    class constructor Create;
    class destructor Destroy;

    constructor Create;
    destructor Destroy; override;

    procedure CacheColor(j: Integer; c: TAlphaColor);

    procedure WriteColorInfoBin(ML: TStrings);
    procedure WriteColorInfoBin2(ML: TStrings);
    procedure WriteColorInfoCode(ML: TStrings);
    procedure ReadStripColors(ML: TStrings);
    procedure ReadColorStrip(cs: TColorStrip);

    procedure RotateColors(Value: Integer);
    procedure BlindRings(Value: Integer);
    procedure BlindColors(Value: Integer);
    procedure BlindColors2(Value: Integer);
    procedure BlindColor(j: Integer);

    function ReadBitmapColor(ASchemeID: Integer; j: Integer; Mix: Integer = 0): TAlphaColor;
    function GetBitmapColor(ASchemeID, j: Integer): TAlphaColor;

    property RingColor[j: Integer]: TAlphaColor read GetRingColor write SetRingColor;
    property BlindColorCount: Integer read GetBlindColorCount write SetBlindColorCount;

    property StripColor: TAlphaColor read GetStripColor write SetStripColor;
    property BackgroundColor: TAlphaColor read GetBackgroundColor write SetBackgroundColor;

    property UpdatingRings: Boolean read FUpdatingRings write SetUpdatingRings;
    property ColorMix: Integer read FColorMix write SetColorMix;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.Bitmap.Bands01,
  RiggVar.Bitmap.Strips01;

{ TStripColors }

class constructor TStripColors.Create;
begin
  StripColorData := TStripColorData01.Create;
  BandColorData := TBandColorData01.Create;
end;

class destructor TStripColors.Destroy;
begin
  StripColorData.Free;
  BandColorData.Free;
  inherited;
end;

constructor TStripColors.Create;
begin
  BackgroundColorOverride := False;
  BackgroundColorOverrideValue := claAliceBlue;

  BlindColorOverride := False;
  BlindColorOverrideValue := 10;

  ContourOverride := False;
  ContourOverrideValue := False;

  FBlindColorCount := 1;
  WantContour := True;

  ColorBand := TColorBand.Create;

  ColorCache := TColorBands.Create;
  ColorCache.InitItems(36);

  ColorBands := TColorBands.Create;
  ColorBands.InitItems(36);
end;

destructor TStripColors.Destroy;
begin
  ColorBand.Free;
  ColorBands.Free;
  ColorCache.Free;
  inherited;
end;

procedure TStripColors.RotateColors(Value: Integer);
begin
  UpdatingRings := True;
  UpdateReason := TUpdateReason.cuRingCycle;

  if Value > 0 then
    RotateColorsP
  else
    RotateColorsM
end;

procedure TStripColors.RotateColorsP;
var
  j: Integer;
  cla: TAlphaColor;
begin
  cla := ColorCache[1].Color;
  for j := 1 to StripConst.StripCount-1 do
    ColorCache[j].Color := ColorCache[j+1].Color;
  ColorCache[StripConst.StripCount].Color := cla;
end;

procedure TStripColors.RotateColorsM;
var
  j: Integer;
  cla: TAlphaColor;
begin
  cla := ColorCache[StripConst.StripCount].Color;
  for j := StripConst.StripCount-1 downto 2 do
    ColorCache[j].Color := ColorCache[j-1].Color;
  ColorCache[1].Color := cla;
end;

procedure TStripColors.CacheColor(j: Integer; c: TAlphaColor);
begin
  if (j > 0) and (j <= StripConst.StripCount) then
  begin
    ColorBands[j].Color := c;
    ColorCache[j].Color := c;
  end;
end;

function TStripColors.GetBlindColorCount: Integer;
begin
  result := FBlindColorCount;
  if BlindColorOverride then
    result := BlindColorOverrideValue;
end;

procedure TStripColors.SetBlindColorCount(const Value: Integer);
begin
  if (Value > 0) and (Value <= StripConst.StripCount div 2) then
    FBlindColorCount := Value;
end;

procedure TStripColors.SetColorMix(const Value: Integer);
begin
  FColorMix := Value;
  UpdateReason := TUpdateReason.cuColorMix;
end;

procedure TStripColors.ReadColorStrip(cs: TColorStrip);
var
  j: Integer;
begin
  UpdatingRings := True;
  for j := 1 to StripConst.StripCount do
  begin
    ColorBands[j].Color := cs.Color[j];
  end;
end;

procedure TStripColors.WriteColorInfoBin2(ML: TStrings);
var
  j: Integer;
  ji: Integer;
  cs: string;
  c: TAlphaColor;
begin
  ji := nStripColorOffset + 0;
  c := Main.StripColor;
  cs := IntToHex(Integer(c), 8);
  ML.Add(Format(fbs, [ji, cs]));
  for j := 1 to StripConst.StripCount do
  begin
    ji := nStripColorOffset + j;
    c := ColorBands[j].Color;
    cs := IntToHex(Integer(c), 8);
    ML.Add(Format(fbs, [ji, cs]));
  end;
end;

procedure TStripColors.WriteColorInfoBin(ML: TStrings);
var
  j: Integer;
  cs: string;
  c: TAlphaColor;
begin
  c := Main.StripColor;
  cs := AlphaColorToString(c);
  ML.Add(Format(fbs, [nStripColorOffset, cs]));
  for j := 1 to StripConst.StripCount do
  begin
    c := ColorBands[j].Color;
    cs := AlphaColorToString(c);
    ML.Add(Format(fbs, [nStripColorOffset + j, cs]));
  end;
end;

procedure TStripColors.WriteColorInfoCode(ML: TStrings);
var
  j: Integer;
  s: string;
  c: TAlphaColor;
  fs: string;
begin
  fs := 'StripColor(%d, ''%s'');';
  c := Main.StripColor;
  if not AlphaColorToIdent(Integer(c), s) then
    s := AlphaColorToString(c);
  ML.Add(Format(fs, [0, s]));
  for j := 1 to StripConst.StripCount do
  begin
    c := ColorBands[j].Color;
    s := AlphaColorToString(c);
    ML.Add(Format(fs, [j, s]));
  end;
end;

procedure TStripColors.ReadStripColors(ML: TStrings);
var
  i: Integer;
  j: Integer;
  s, t, n, v: string;
  c: TAlphaColor;
begin
  for i := 1 to ML.Count-1 do
  begin
    s := ML[i];
    n := ML.Names[i];
    v := ML.Values[n];
    t := s.Substring(1);
    j := StrToIntDef(t, 0);
    if (j > 0) and (j <= StripConst.StripCount) then
    begin
      c := StringToAlphaColor(v);
      ColorBands[j].Color := c;
    end;
  end;
end;

function TStripColors.ReadBitmapColor(ASchemeID, j, Mix: Integer): TAlphaColor;
begin
  result := StripColorData.GetBitmapColor(ASchemeID, j, ColorMix);
  CacheColor(j, result);
end;

procedure TStripColors.BlindRings(Value: Integer);
var
  j: Integer;
begin
  UpdatingRings := True;
  UpdateReason := TUpdateReason.cuBlindCount;

  BlindColorCount := Value;

  for j := 1 to StripConst.StripCount do
  begin
    BlindColor(j);
  end;
end;

procedure TStripColors.BlindColors(Value: Integer);
var
  j: Integer;
begin
  UpdatingRings := True;
  UpdateReason := TUpdateReason.cuBlindCount;

  if Value > 0 then
    BlindColorCount := BlindColorCount + 1
  else if Value < 0 then
    BlindColorCount := BlindColorCount - 1;

  for j := 1 to StripConst.StripCount do
  begin
    BlindColor(j);
  end;
end;

procedure TStripColors.BlindColors2(Value: Integer);
var
  j: Integer;
begin
  UpdatingRings := True;
  UpdateReason := TUpdateReason.cuBlindCount;

  if Value > 0 then
    BlindColorOverrideValue := BlindColorOverrideValue + 1
  else if Value < 0 then
    BlindColorOverrideValue := BlindColorOverrideValue - 1;

  for j := 1 to StripConst.StripCount do
  begin
    BlindColor(j);
  end;
end;

procedure TStripColors.BlindColor(j: Integer);
var
  cla: TAlphaColor;
begin
  if BlindColorCount >= j then
  begin
    if WantShirtColor then
    begin
      cla := MainVar.ColorScheme.claBackground;
    end
    else
    begin
      cla := ColorCache[1].Color;
    end;
  end
  else if j <= StripConst.StripCount - BlindColorCount then
  begin
    cla := ColorCache[j].Color;
  end
  else
  begin
    if WantShirtColor then
    begin
      cla := MainVar.ColorScheme.claBackground;
    end
    else
    begin
      cla := ColorCache[StripConst.StripCount].Color;
    end;
  end;
  ColorBands[j].Color := cla;
end;

function TStripColors.GetBitmapColor(ASchemeID, j: Integer): TAlphaColor;
begin
  case j of
    1..34:
    begin
      case ASchemeID of
        7: result := ReadBitmapColor(7, j);
        11: result := ReadBitmapColor(11, j);
        14: result := ReadBitmapColor(14, j);
        15: result := ReadBitmapColor(15, j);
        16: result := ReadBitmapColor(16, j);
        17: result := ReadBitmapColor(17, j);
        18: result := ReadBitmapColor(18, j);
        19: result := ReadBitmapColor(19, j);
        20: result := ReadBitmapColor(20, j);
        21: result := ReadBitmapColor(21, j);
        else
          result := claWhite;
      end;
    end
    else
     result := claRed;
  end;
end;

function TStripColors.GetRingColor(j: Integer): TAlphaColor;
begin
  if (j > 0) and (j <= StripConst.StripCount) then
    result := ColorCache[j].Color
  else
    result := claWhite;
end;

procedure TStripColors.SetRingColor(j: Integer; const Value: TAlphaColor);
begin
  if UpdateReason <> TUpdateReason.cuRandom then
  begin
    UpdatingRings := True;
    UpdateReason := TUpdateReason.cuRingColor;
  end;
  if (j > 0) and (j <= StripConst.StripCount) then
  begin
    ColorCache[j].Color := Value;
    ColorBands[j].Color := Value;
  end;
end;

function TStripColors.GetStripColor: TAlphaColor;
begin
  result := ColorCache[0].Color;
end;

procedure TStripColors.SetStripColor(const Value: TAlphaColor);
begin
  ColorCache[0].Color := Value;
end;

procedure TStripColors.SetUpdatingRings(const Value: Boolean);
begin
  FUpdatingRings := Value;
end;

function TStripColors.GetBackgroundColor: TAlphaColor;
begin
  if BackgroundColorOverride then
    result := BackgroundColorOverrideValue
  else if UseViewportBackground then
    result := MainVar.ColorScheme.claBackground
  else
    result := ColorCache[35].Color;
end;

procedure TStripColors.SetBackgroundColor(const Value: TAlphaColor);
begin
  ColorCache[35].Color := Value;
end;

end.
