unit RiggVar.Bitmap.Bitmap02;

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
  System.Types,
  System.UITypes,
  System.UIConsts,
  FMX.Graphics,
  FMX.Types,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.ColorConst,
  RiggVar.Bitmap.Bitmap00;

type
  TBitmapBuilder02 = class(TStripColors)
  private
    c1, c34: TAlphaColor;
    PixelBuffer: TColorBands;
    FStripCount: Integer;
    HasRingWidthInfo: Boolean;

    FPixelFaktor: Integer;
    FPixelCount: Integer;

    Farbe1: TAlphaColor;
    Farbe2: TAlphaColor;
    FCapValueSnapShot: single;

    procedure CompileBands;

    function GetBand(j: Integer): TColorBand;
    function GetBandColor(j: Integer): TAlphaColor;
    function GetBandWidth(j: Integer): Integer;

    function GetRingWidth(j: Integer): Integer;
    procedure SetRingWidth(j: Integer; const Value: Integer);
    procedure SetRingWidthRelative(j: Integer; const Value: Integer);
    procedure SetRingWidthContour(j: Integer; const Value: Integer);
    function GetRingWidthContour(j: Integer): Integer;

    procedure EnsureBlindColor(j: Integer);
    function CheckBlindColor(j: Integer; c: TAlphaColor): TAlphaColor;

    procedure WriteBandInfo(b: Integer; ML: TStrings; BandInfoFormat: TBandInfoFormat);

    procedure ProcessBandInfo(ML: TStrings; c: char);
    procedure WriteBandInfoPart(b: Integer; ML: TStrings; c: char);

    procedure ReadBandColorProps;
    procedure StretchLinear;
    procedure SetPixelFaktor(const Value: Integer);
    function CheckBlindFarbe(j: Integer; c: TAlphaColor): TAlphaColor;
    procedure ResetContour;
    procedure SwapFarbeIn;
    procedure SwapFarbeOut;
    procedure SetCapValueSnapShot(const Value: single);
  protected
    procedure InitBands1;
    procedure InitBands2;
    function FormatBandInfoN(j: Integer): string;
  public
    Verbose: Boolean;
    Changed: Boolean;
    RingWidthChanged: Boolean;
    WantColorNames: Boolean;
    WantWebColors: Boolean;

    RingMap: array of Integer;

    constructor Create;
    destructor Destroy; override;

    procedure MarkForUpdate(reason: TUpdateReason);

    procedure InitProps(bid: Integer);

    procedure SaveBinProps(ML: TStrings);
    procedure SaveBin(ML: TStrings);
    procedure SaveCodeProps(ML: TStrings);
    procedure SaveCode(ML: TStrings);
    procedure SaveCode6(ML: TStrings);
    procedure SaveText(ML: TStrings);

    function GetBitmap: TBitmap;
    procedure GetRingInfoReport(AFigureSize: TSizeName; ML: TStrings);

    function FindPickedRing(TexCoordY: single): Integer;

    procedure GetBandInfo(b: Integer; ML: TStrings);
    procedure ReadBandInfo(BandInfo: TColorBands);
    procedure AssignBandInfo(j: Integer; const TempColorBand: TColorBand);

    procedure InitDefaultRingWidth(Value: Integer);
    function CanChangeAbsoluteWidth(j: Integer; const Value: Integer): Boolean;
    function CanChangeRelativeWidth(j: Integer; const Value: Integer): Boolean;
    function CanChangeContourWidth(j: Integer; const Value: Integer): Boolean;

    property RingWidth[j: Integer]: Integer read GetRingWidth write SetRingWidth;
    property RingWidthRelative[j: Integer]: Integer write SetRingWidthRelative;
    property RingWidthContour[j: Integer]: Integer read GetRingWidthContour write SetRingWidthContour;

    property Band[j: Integer]: TColorBand read GetBand;
    property PixelFaktor: Integer read FPixelFaktor write SetPixelFaktor;
    property PixelCount: Integer read FPixelCount;

    property CapValueSnapShot: single read FCapValueSnapShot write SetCapValueSnapShot;
  end;

implementation

uses
  RiggVar.App.Main;

{ TBitmapBuilder02 }

constructor TBitmapBuilder02.Create;
begin
  inherited;
  Farbe1 := claBlack;
  Farbe2 := claBlack;

  FStripCount := StripConst.StripCount;
  Verbose := True;
  WantColorNames := True;
  WantWebColors := True;

  FCapValueSnapshot := 60;
  FPixelFaktor := 1;
  FPixelCount := FPixelFaktor * 360;

  PixelBuffer := TColorBands.Create;
  PixelBuffer.InitItems(4 * 360);

  SetLength(RingMap, FPixelCount);
  InitDefaultRingWidth(StripConst.DefaultBandWidth);
end;

destructor TBitmapBuilder02.Destroy;
begin
  PixelBuffer.Free;
  inherited;
end;

function TBitmapBuilder02.GetBand(j: Integer): TColorBand;
begin
  if (j >= 0) and (j < ColorBands.Count) then
    result := ColorBands[j]
  else
    result := nil;
end;

procedure TBitmapBuilder02.ReadBandInfo(BandInfo: TColorBands);
var
  cr, cb, cc: TColorBand;
  j: Integer;
begin
  UpdatingRings := True;
  for j := 0 to 35 do
  begin
    cr := BandInfo[j];

    cb := ColorBands[j];
    cc := ColorCache[j];

    cc.Clone(cr);
    cb.Clone(cc);

    HasRingWidthInfo := True;
    RingWidthChanged := True;
  end;
end;

function TBitmapBuilder02.GetRingWidth(j: Integer): Integer;
begin
  if (j > 0) and (j < StripConst.StripCount) then
    result := ColorBands[j].Width
  else
    result := StripConst.DefaultBandWidth;
end;

procedure TBitmapBuilder02.SetCapValueSnapShot(const Value: single);
begin
  if Value < 10 then
    Exit;
  if Value > 200 then
    Exit;

  FCapValueSnapShot := Value;
end;

procedure TBitmapBuilder02.SetPixelFaktor(const Value: Integer);
begin
  FPixelFaktor := Value;
  case Value of
    1: FPixelCount := 1 * 360;
    2: FPixelCount := 2 * 360;
    4: FPixelCount := 4 * 360;
  end;
  SetLength(RingMap, FPixelCount);
  HasRingWidthInfo := True;
  RingWidthChanged := True;
end;

procedure TBitmapBuilder02.SetRingWidth(j: Integer; const Value: Integer);
begin
  if (Value > 0) and (Value < FPixelCount)  then
  begin
    if (j > 0) and (j <= StripConst.StripCount) then
    begin
      ColorCache[j].Width := Value;
      ColorBands[j].Width := Value;
      HasRingWidthInfo := True;
      RingWidthChanged := True;
    end;
  end;
end;

procedure TBitmapBuilder02.SetRingWidthRelative(j: Integer; const Value: Integer);
var
  w1, w2, wd: Integer;
begin
  if (Value > 0) and (Value < FPixelCount)  then
  begin
    if (j > 0) and (j <= StripConst.StripCount - 1) then
    begin
      w1 := ColorBands[j].Width;
      w2 := ColorBands[j+1].Width;
      wd := Value - w1;
      w1 := Value;
      w2 := w2 - wd;
      if (w1 > 0) and (w2 > 0) then
      begin
        ColorBands[j].Width := w1;
        ColorBands[j+1].Width := w2;
        ColorCache[j].Width := w1;
        ColorCache[j+1].Width := w2;
        HasRingWidthInfo := True;
        RingWidthChanged := True;
      end;
    end;
  end;
end;

procedure TBitmapBuilder02.SetRingWidthContour(j: Integer; const Value: Integer);
var
  cr: TColorBand;
begin
  cr := ColorBands[j];
  if (Value > 0) and (Value < cr.Width) then
  begin
    cr.Contour := Value;
    HasRingWidthInfo := True;
    RingWidthChanged := True;
  end;
end;

function TBitmapBuilder02.GetRingWidthContour(j: Integer): Integer;
begin
  result := ColorBands[j].Contour;
end;

procedure TBitmapBuilder02.ResetContour;
var
  j: Integer;
begin
  for j := 1 to StripConst.StripCount do
    ColorBands[j].Contour := 1;
end;

procedure TBitmapBuilder02.InitDefaultRingWidth(Value: Integer);
var
  j: Integer;
  v: Integer;
begin
  HasRingWidthInfo := False;
  if (Value > 0) and (Value < FPixelCount) then
    v := Value
  else
    v := StripConst.DefaultBandWidth;

  for j := 1 to StripConst.StripCount do
    ColorBands[j].Width := v;

  ResetContour;
end;

procedure TBitmapBuilder02.GetBandInfo(b: Integer; ML: TStrings);
begin
  WriteBandInfoPart(b, ML, 'N')
end;

procedure TBitmapBuilder02.ProcessBandInfo(ML: TStrings; c: char);
begin
  WriteBandInfoPart(1, ML, c);
  WriteBandInfoPart(2, ML, c);
end;

procedure TBitmapBuilder02.WriteBandInfoPart(b: Integer; ML: TStrings; c: char);
var
  i, j, k: Integer;
begin
  case b of
    1:
    begin
      i := 1;
      k := 17;
    end;

    2:
    begin
      i := 18;
      k := 34;
    end;

    else
    begin
      i := 0;
      k := 35;
    end;
  end;

  for j := i to k do
  begin
    if c = 'N' then
      ML.Add(FormatBandInfoN(j));
  end;
end;

function TBitmapBuilder02.FindPickedRing(TexCoordY: single): Integer;
var
  pixel: Integer;
begin
  pixel := Round(TexCoordY * FPixelCount);

  if pixel < 0 then
    pixel := 0;
  if pixel > FPixelCount - 1 then
    pixel := FPixelCount - 1;

  result := RingMap[pixel];
end;

procedure TBitmapBuilder02.WriteBandInfo(b: Integer; ML: TStrings; BandInfoFormat: TBandInfoFormat);
var
  i, j, k: Integer;
  cr: TColorBand;
begin
  case b of
    1:
    begin
      i := 1;
      k := 17;
    end;

    2:
    begin
      i := 18;
      k := 34;
    end;

    else
    begin
      i := 0;
      k := 35;
    end;
  end;

  for j := i to k do
  begin
    cr := ColorBands[j];
    ML.Add(cr.FormatBandInfo(BandInfoFormat));
  end;
end;

function TBitmapBuilder02.FormatBandInfoN(j: Integer): string;
begin
  result := ColorBands[j].FormatBandInfoNZ(Main.CurrentRing);
end;

procedure TBitmapBuilder02.SaveBinProps(ML: TStrings);
begin
  if Verbose or (BlindColorCount <> 0) then
    ML.Add(Format(fbd, [nBlindColorCount, BlindColorCount]));

  if Verbose or (StripWidth <> StripConst.DefaultStripWidth) then
    ML.Add(Format(fbd, [nStripWidth, StripWidth]));
  if Verbose or (BandWidth <> StripConst.DefaultBandWidth) then
    ML.Add(Format(fbd, [nBandWidth, BandWidth]));

  if Verbose or (SchemeID <> 16) then
    ML.Add(Format(fbd, [nStandardColor, SchemeID]));

  if Verbose or not WantContour then
    ML.Add(Format(fbd, [nWantContour, BoolInt[WantContour]]));
  if Verbose or WantShirtColor then
    ML.Add(Format(fbd, [nWantShirtColor, BoolInt[WantShirtColor]]));

  if Verbose or SquareBitmap then
    ML.Add(Format(fbd, [nSquareBitmap, BoolInt[SquareBitmap]]));
  if Verbose or HorizontalBitmap then
    ML.Add(Format(fbd, [nHorizontalBitmap, BoolInt[HorizontalBitmap]]));
  if Verbose or SquareSym then
    ML.Add(Format(fbd, [nSquareSym, BoolInt[SquareSym]]));

  if Verbose or RandomPaint then
    ML.Add(Format(fbd, [nRandomPaint, BoolInt[RandomPaint]]));
  if Verbose or StandardPaint then
    ML.Add(Format(fbd, [nStandardPaint, BoolInt[StandardPaint]]));
  if Verbose or MonoPaint then
    ML.Add(Format(fbd, [nMonoPaint, BoolInt[MonoPaint]]));
end;

procedure TBitmapBuilder02.SaveCodeProps(ML: TStrings);
begin
  if Verbose or (BlindColorCount <> 0) then
    ML.Add(Format(dsd, [cBlindColorCount, BlindColorCount]));

  if Verbose or (StripWidth <> StripConst.DefaultStripWidth) then
    ML.Add(Format(dsd, [cStripWidth, StripWidth]));
  if Verbose or (BandWidth <> StripConst.DefaultBandWidth) then
    ML.Add(Format(dsd, [cBandWidth, BandWidth]));

  if Verbose or (SchemeID <> 16) then
    ML.Add(Format(dsd, [cStandardColor, SchemeID]));

  if Verbose or not WantContour then
    ML.Add(Format(dss, [cWantContour, BoolStr[WantContour]]));
  if Verbose or WantShirtColor then
    ML.Add(Format(dss, [cWantShirtColor, BoolStr[WantShirtColor]]));

  if Verbose or SquareBitmap then
    ML.Add(Format(dss, [cSquareBitmap, BoolStr[SquareBitmap]]));
  if Verbose or HorizontalBitmap then
    ML.Add(Format(dss, [cHorizontalBitmap, BoolStr[HorizontalBitmap]]));
  if Verbose or SquareSym then
    ML.Add(Format(dss, [cSquareSym, BoolStr[SquareSym]]));

  if Verbose or RandomPaint then
    ML.Add(Format(dss, [cRandomPaint, BoolStr[RandomPaint]]));
  if Verbose or StandardPaint then
    ML.Add(Format(dss, [cStandardPaint, BoolStr[StandardPaint]]));
  if Verbose or MonoPaint then
    ML.Add(Format(dss, [cMonoPaint, BoolStr[MonoPaint]]));
end;

procedure TBitmapBuilder02.SaveBin(ML: TStrings);
begin
  SaveBinProps(ML);
  WriteBandInfo(0, ML, BandInfoFormatB);
end;

procedure TBitmapBuilder02.SaveCode(ML: TStrings);
begin
  SaveCodeProps(ML);

  ML.Add('');
  ML.Add('//BandInfo := W-R-G-B;');
  WriteBandInfo(0, ML, BandInfoFormat4);
end;

procedure TBitmapBuilder02.SaveCode6(ML: TStrings);
begin
  SaveCodeProps(ML);

  ML.Add('');
  ML.Add('//BandInfo := W-R-G-B-C-A;');
  WriteBandInfo(0, ML, BandInfoFormat6);
end;

procedure TBitmapBuilder02.SaveText(ML: TStrings);
begin
  SaveCodeProps(ML);
  ProcessBandInfo(ML, 'N');
end;

function TBitmapBuilder02.GetBandWidth(j: Integer): Integer;
begin
  if HasRingWidthInfo then
    result := RingWidth[j]
  else
    result := BandWidth;
end;

function TBitmapBuilder02.GetBandColor(j: Integer): TAlphaColor;
var
  r, g, b: Integer;
  temp: Integer;
  acr: TAlphaColorRec;
begin
  if StandardPaint then
  begin
    if UpdatingRings then
      result := RingColor[j]
    else
    begin
      result := GetBitmapColor(SchemeID, j);
      result := CheckBlindColor(j, result);
    end;
  end
  else
  begin
    if UpdatingRings then
    begin
      result := RingColor[j];
    end
    else
    begin
      if MonoPaint then
      begin
        temp := j * 5;
        r := Round(255 - temp);
        g := Round(255 - temp);
        b := Round(255);
      end
      else if RandomPaint then
      begin
        if WantWebColors then
        begin
          r := Random(147); // excluding claNull
          temp := MyAlphaColors[r].Value;
          acr := TAlphaColorRec(temp); //TAlphaColorRec(TAlphaColor(temp));
          r := acr.R;
          g := acr.G;
          b := acr.B;
        end
        else
        begin
          r := Random(255);
          g := Random(255);
          b := Random(255);
        end;
      end
      else
      begin
        r := Round(255 - j);
        g := Round(255 - j);
        b := Round(255 - j);
      end;
      result := MakeColor(r, g, b);
      ColorCache[j].Color := result;
      ColorBands[j].Color := result;
    end;
  end;

  if BlindColorOverride then
    if (j < BlindColorOverrideValue)
      or (j > FStripCount - BlindColorOverrideValue)
    then
      result := BackgroundColor;

  if WantShirtColor then
    if (j < BlindColorCount)
      or (j > FStripCount - BlindColorCount)
    then
      result := BackgroundColor;
end;

procedure TBitmapBuilder02.SwapFarbeIn;
var
  cr1: Integer;
  cr2: Integer;
begin
  cr1 := Main.CurrentRing;
  cr2 := Main.CurrentRing + 1;
  Farbe1 := claBlack;
  Farbe2 := claBlack;
  if (cr1 > -1) and (cr1 < ColorBands.Count) then
  begin
    Farbe1 := ColorBands[cr1].Farbe;
    ColorBands[cr1].Farbe := claNavy;
  end;
  if (cr2 > -1) and (cr2 < ColorBands.Count) then
  begin
    Farbe2 := ColorBands[cr2].Farbe;
    ColorBands[cr2].Farbe := claLime;
  end;
end;

procedure TBitmapBuilder02.SwapFarbeOut;
var
  cr1: Integer;
  cr2: Integer;
begin
  cr1 := Main.CurrentRing;
  cr2 := Main.CurrentRing + 1;
  if (cr1 > -1) and (cr1 < ColorBands.Count) then
  begin
    ColorBands[cr1].Farbe := Farbe1;
  end;
  if (cr2 > -1) and (cr2 < ColorBands.Count) then
  begin
    ColorBands[cr2].Farbe := Farbe2;
  end;
end;

function TBitmapBuilder02.GetBitmap: TBitmap;
var
  Data: TBitmapData;
  i: Integer;
begin
  TColorBand.T1 := Main.FederModel.FT1;
  TColorBand.T2 := Main.FederModel.FT2;

  if SchemeID < 1 then
  begin
    { do nothing }
  end
  else if SchemeID in [7, 11, 14..23] then
    InitBands2
  else
    InitBands1;

  if ContourOverride then
    WantContour := ContourOverrideValue;
  if BlindColorOverride then
    BlindColorCount := BlindColorOverrideValue;

  if ShowCurrentBand then
    SwapFarbeIn;

  CompileBands;

  result := TBitmap.Create(1, FPixelCount);
  if result.Map(TMapAccess.Write, Data) then
  begin
    for i := 0 to FPixelCount-1 do
    begin
      RingMap[i] := PixelBuffer[i].Ring;
      Data.SetPixel(0, i, PixelBuffer[i].Color);
    end;
    result.Unmap(Data);
  end;

  UpdateReason := TUpdateReason.cuNone;
  Changed := False;
  RingWidthChanged := False;
  UpdatingRings := False;

  if ShowCurrentBand then
    SwapFarbeOut;
end;

procedure TBitmapBuilder02.EnsureBlindColor(j: Integer);
begin
  ColorBands[j].Color := CheckBlindColor(j, ColorCache[j].Color);

  if StripColor = claNull then
    StripColor := claBlack;

  ColorBands[j].Farbe := CheckBlindFarbe(j, ColorCache[j].Farbe);
end;

function TBitmapBuilder02.CheckBlindColor(j: Integer; c: TAlphaColor): TAlphaColor;
var
  bcc: Integer;
begin
  bcc := BlindColorCount;
  if BlindColorOverride then
    bcc := BlindColorOverrideValue;

  if j <= bcc then
  begin
    if WantShirtColor then
      result := BackgroundColor
    else
      result := c1;
  end
  else if j <= StripConst.StripCount - bcc then
  begin
    result := c;
  end
  else
  begin
    if WantShirtColor then
      result := BackgroundColor
    else
      result := c34;
  end;
end;

function TBitmapBuilder02.CheckBlindFarbe(j: Integer; c: TAlphaColor): TAlphaColor;
begin
  if j <= BlindColorCount then
  begin
    if WantShirtColor and WantShirtFarbe then
      result := BackgroundColor
    else if WantShirtFarbe then
      result := c1
    else
      result := StripColor;
  end
  else if j <= StripConst.StripCount - BlindColorCount then
  begin
    result := StripColor;
  end
  else
  begin
    if WantShirtColor and WantShirtFarbe then
      result := BackgroundColor
    else if WantShirtFarbe then
      result := c34    
    else
      result := StripColor;
  end;
end;

procedure TBitmapBuilder02.InitBands1;
var
  j: Integer;
  bc: TAlphaColor;
  bw: Integer;
  cr: TColorBand;
begin
  GetBitmapColor(SchemeID, 1);
  GetBitmapColor(SchemeID, 34);

  c1 := ColorBands[1].Color;
  c34 := ColorBands[34].Color;

  for j := 17 downto 1 do
  begin
    bc := GetBandColor(j);
    bw := GetBandWidth(j);
    cr := ColorBands[j];
    cr.Width := bw;
    cr.Color := bc;
    cr.Farbe := StripColor;
  end;

  for j := 18 to 34 do
  begin
    bc := GetBandColor(j);
    bw := GetBandWidth(j);
    cr := ColorBands[j];
    cr.Width := bw;
    cr.Color := bc;
    cr.Farbe := StripColor;
  end;

  if not RingWidthChanged then
    Changed := True;
end;

procedure TBitmapBuilder02.InitBands2;
var
  j: Integer;
begin
  case UpdateReason of

    TUpdateReason.cuNone,
    TUpdateReason.cuColorMix,
    TUpdateReason.cuBitmap:
    begin
      ReadBandColorProps;
    end;

    TUpdateReason.cuParamRingWidthT3,
    TUpdateReason.cuParamRingWidthT4:
    begin
      InitDefaultRingWidth(Round(Main.FederModel.FT4));
    end;

    TUpdateReason.cuParamBandCount:
    begin
      StretchLinear;
    end;
  end;

  c1 := ColorCache[1].Color;
  c34 := ColorCache[34].Color;

  for j := 1 to 34 do
    EnsureBlindColor(j);

  if not RingWidthChanged then
    Changed := True;
end;

procedure TBitmapBuilder02.AssignBandInfo(j: Integer; const TempColorBand: TColorBand);
var
  cla: TAlphaColor;
begin
  case j of
    0: StripColor := TempColorBand.Color;
    35: BackgroundColor := TempColorBand.Color;
  end;

  case j of
    0, 35:
    begin
      Band[j].Ring := j;
      Band[j].Width := TempColorBand.Width;
      Band[j].Color := TempColorBand.Color;
    end;
  end;

  case j of
    1..34:
    begin
      Band[j].Ring := j;
      Band[j].Width := TempColorBand.Width;
      cla := BandColorData.MG(j, TempColorBand.Color);
      Band[j].Color := cla;
      CacheColor(j, cla);
    end;
  end;
end;

procedure TBitmapBuilder02.ReadBandColorProps;
begin
  BandColorData.IntitColorBands(SchemeID, ColorMix);

  BlindColorCount := BandColorData.BlindColorCount;

  StripWidth := BandColorData.StripWidth;
  BandWidth := BandColorData.BandWidth;

  WantContour := BandColorData.WantContour;
  WantShirtColor := BandColorData.WantShirtColor;

  SquareBitmap := BandColorData.SquareBitmap;
  HorizontalBitmap := BandColorData.HorizontalBitmap;
  SquareSym := BandColorData.SquareSym;

  RandomPaint := BandColorData.RandomPaint;
  StandardPaint := BandColorData.StandardPaint;
  MonoPaint := BandColorData.MonoPaint;

  StripColor := Band[0].Color;
  BackgroundColor := Band[35].Color;
end;

procedure TBitmapBuilder02.InitProps(bid: Integer);
begin
  SquareBitmap := False;
  HorizontalBitmap := False;
  SquareSym := False;

  StandardPaint := False;
  MonoPaint := False;
  RandomPaint := False;

  SchemeID := bid;

  case bid of
    7:
    begin
      StandardPaint := True;
      StripColor := claGray;
      StripWidth := Round(Main.FederModel.FT3);
      BandWidth := Round(Main.FederModel.FT4);
    end;

    8:
    begin
      { gray strips }
      StripColor := claGray;
      StripWidth := Round(Main.FederModel.FT3);
      BandWidth := Round(Main.FederModel.FT4);
    end;
    9:
    begin
      { blue strips }
      MonoPaint := True;
      StripColor := claGray;
      StripWidth := StripConst.DefaultStripWidth;
      BandWidth := StripConst.DefaultBandWidth;
    end;
    10:
    begin
      { blue strips, red rings }
      MonoPaint := True;
      StripColor := claRed;
      StripWidth := StripConst.DefaultStripWidth;
      BandWidth := StripConst.DefaultBandWidth;
    end;
    11:
    begin
      { red strips, gray rings }
      StandardPaint := True;
      StripColor := claRed;
      StripWidth := StripConst.DefaultStripWidth;
      BandWidth := StripConst.DefaultBandWidth;
    end;
    12:
    begin
      { random strips, black rings }
      RandomPaint := True;
      //TAlphaColorRec(tempcla).A := 0;
      StripColor := claBlack;
      StripWidth := Round(Main.FederModel.FT3);
      BandWidth := Round(Main.FederModel.FT4);
    end;
    13:
    begin
      { random strips, white rings }
      RandomPaint := True;
      StripColor := claWhite;
      StripWidth := Round(Main.FederModel.FT3);
      BandWidth := Round(Main.FederModel.FT4);
    end;

    14..21: // 14 = escape index
    begin
      StandardPaint := True;
      StripColor := claBlack;
      StripWidth := Round(Main.FederModel.FT3);
      BandWidth := Round(Main.FederModel.FT4);
    end;

    22:
    begin
      HorizontalBitmap := True;
      StripColor := claCornflowerblue;
      StripWidth := 5;
      BandWidth := Round(Main.FederModel.FT4);
    end;
    23:
    begin
      HorizontalBitmap := True;
      StripColor := claRed;
      StripWidth := 5;
      BandWidth := StripConst.DefaultBandWidth;
    end;
    24:
    begin
      SquareSym := False;
      SquareBitmap := True;
      StripColor := claNavy;
      StripWidth := 5;
      BandWidth := Round(Main.FederModel.FT4);
    end;

    25:
    begin
      StandardPaint := True;
      StripColor := Main.StripColor;
      StripWidth := Round(Main.FederModel.FT3);
      BandWidth := Round(Main.FederModel.FT4);
    end;

    else
    begin

    end;
  end;
end;

procedure TBitmapBuilder02.MarkForUpdate(reason: TUpdateReason);
begin
  UpdateReason := reason;
  HasRingWidthInfo := True;
  RingWidthChanged := True;
end;

procedure TBitmapBuilder02.StretchLinear;
var
  j: Integer;
  c: Integer;
  w: Integer;
begin
  c := Round(Main.FederModel.ParamBandCount);
  if c < 1 then
    c := 1;
  if c > 50 then
    c := 50;

  w := 180 div c;

  for j := 1 to 34 do
    ColorBands[j].Width := w;
end;

procedure TBitmapBuilder02.CompileBands;
var
  t: Integer;
  i: Integer;
  j: Integer;
  k: Integer;
  cr: TColorBand;
  w: Integer;
  pc1: Integer;
  pc2: Integer;
begin
  pc2 := FPixelCount;
  pc1 := FPixelCount div 2;
  i := pc1;
  t := 0;
  for j := 17 downto 1 do
  begin
    cr := ColorBands[j];
    cr.Ring := j;
    w := cr.Width * FPixelFaktor;
    cr.TexCoordY2 := -(t + 0) / pc1;
    cr.TexCoordY1 := -(t + w) / pc1;
    cr.WValue2 := -(t + 0);
    cr.WValue1 := -(t + w);
    cr.ZValue2 := cr.TexCoordY2 * cr.T2 - cr.T1;
    cr.ZValue1 := cr.TexCoordY1 * cr.T2 - cr.T1;
    for k := 0 to w-1 do
    begin
      Dec(i);
      Inc(t);
      if i <= -1 then
        break;
      if i = 0 then
        PixelBuffer[i].Color := cr.Color
      else if WantContour and (k > w - 1 - StripWidth) then
        PixelBuffer[i].Color := cr.Farbe
      else if WantContour and (k > w - 1 - cr.Contour * FPixelFaktor) then
        PixelBuffer[i].Color := cr.Farbe
      else
        PixelBuffer[i].Color := cr.Color;
      PixelBuffer[i].Ring := cr.Ring;
    end;
    if i <= -1 then
      break;
  end;

  for j := i downto 0 do
  begin
    if Assigned(cr) then
    begin
      PixelBuffer[j].Color := cr.Color;
      PixelBuffer[j].Ring := cr.Ring;
    end;
  end;

  i := pc1-1;
  t := 0;
  for j := 18 to 34 do
  begin
    cr := ColorBands[j];
    cr.Ring := j;
    w := cr.Width * FPixelFaktor;
    cr.TexCoordY1 := (t + 0) / pc1;
    cr.TexCoordY2 := (t + w) / pc1;
    cr.WValue1 := t;
    cr.WValue2 := t + w;
    cr.ZValue2 := cr.TexCoordY2 * cr.T2 - cr.T1;
    cr.ZValue1 := cr.TexCoordY1 * cr.T2 - cr.T1;
    for k := 0 to w-1 do
    begin
      Inc(i);
      Inc(t);
      if i >= pc2 then
        break;
      if i = pc2-1 then
        PixelBuffer[i].Color := cr.Color
      else if WantContour and (k < StripWidth) then
        PixelBuffer[i].Color := cr.Farbe
      else if WantContour and (k < cr.Contour * FPixelFaktor) then
        PixelBuffer[i].Color := cr.Farbe
      else
        PixelBuffer[i].Color := cr.Color;
      PixelBuffer[i].Ring := cr.Ring;
    end;
    if i >= pc2-1 then
      break;
  end;

  for j := i to pc2-1 do
  begin
    if Assigned(cr) then
    begin
      PixelBuffer[j].Color := cr.Color;
      PixelBuffer[j].Ring := cr.Ring;
    end;
  end;
end;

function TBitmapBuilder02.CanChangeAbsoluteWidth(j: Integer; const Value: Integer): Boolean;
begin
  result := Value > 0;
  if Assigned(ColorBands[j]) then
    result := Value < 100;
end;

function TBitmapBuilder02.CanChangeRelativeWidth(j: Integer; const Value: Integer): Boolean;
var
  w1, w2, wd: Integer;
begin
  result := False;
  if (Value > 0) and (Value < FPixelCount)  then
  begin
    if (j > 0) and (j <= StripConst.StripCount - 1) then
    begin
      w1 := ColorBands[j].Width;
      w2 := ColorBands[j+1].Width;
      wd := Value - w1;
      w1 := Value;
      w2 := w2 - wd;
      if (w1 > 0) and (w2 > 0) then
      begin
        result := True;
      end;
    end;
  end;
end;

function TBitmapBuilder02.CanChangeContourWidth(j: Integer; const Value: Integer): Boolean;
begin
  result := Value > 0;
  if Assigned(ColorBands[j]) then
    result := Value < ColorBands[j].Width - 1;
end;

procedure TBitmapBuilder02.GetRingInfoReport(AFigureSize: TSizeName; ML: TStrings);
var
  i, j: Integer;
  cr: TColorBand;
  s: string;
  f: single;
  sh: Integer;
  ivon1, ibis1: Integer;
  ivon2, ibis2: Integer;
  cv: Integer;
  ar: Integer;
  FigureHeight: Integer;
begin
  case AFigureSize of
    TSizeName.ExtraSmall: f := 100 / 240;
    TSizeName.Small: f := 120 / 240;
    TSizeName.Medium: f := 160 / 240;
    TSizeName.Large: f := 240 / 240;
    TSizeName.ExtraLarge: f := 320 / 240;
    else
      f := 1.0;
  end;

  cv := Round(FCapValueSnapShot);
  ar := Round(Main.FederModel.AbsoluteRange);

  FigureHeight := Round(2 * ar * f);
  if FigureHeight < 1 then
    FigureHeight := 240;

  ML.Add(Format('Figure Size = %.2f (%d mm)', [f, FigureHeight]));
  ML.Add(Format('CapValue = %.2f (%d mm)', [Main.CapValue, Round(Main.CapValue)]));
  ML.Add(Format('CapValue Snapshot = %.2f (%d mm)', [FCapValueSnapshot, cv]));
  ML.Add('');
  j := 0;
  ibis1 := 0;

  for i := 18 to 24 do
  begin
    cr := ColorBands[i];

    sh  := cr.Width;

    ivon1 := ibis1;
    ibis1 := ivon1 + sh;

    ivon2 := cv - ibis1;
    ibis2 := cv - ivon1;

    Inc(j);
    s := Format('%2d: %2d = (%2d - %2d) [%3.0f - %3.0f]', [j, sh, ivon1, ibis1, ivon2 * f, ibis2 * f]);
    ML.Add(s);
  end;
end;

end.
