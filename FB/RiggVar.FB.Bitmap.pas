unit RiggVar.FB.Bitmap;

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
  System.UITypes,
  System.UIConsts,
  System.Generics.Collections,
  RiggVar.FB.DefConst;

type
  TUpdateReason = (
    cuNone,
    cuBitmap,
    cuRandom,
    cuBackground,
    cuContour,
    cuShirtColor,
    cuBlindCount,
    cuColorMix,
    cuRingCycle,
    cuRingColor,
    cuRingWidth,

    cuParamBandSelected,
    cuParamBandWidth,

    cuParamBandCount,
    cuParamBandDistributionX,
    cuParamBandDistributionY,

    cuParamRingWidthT3,
    cuParamRingWidthT4,

    cuStripsPasted,
    cuBandsPasted
  );

  TBandInfoFormat = (
    BandInfoFormat4,
    BandInfoFormat6,
    BandInfoFormatB,
    BandInfoFormatC
  );

  TColorBand = class
  public
    Ring: Integer;
    Color: TAlphaColor;
    Width: Integer;
    Contour: Integer;
    Farbe: TAlphaColor;
    TexCoordY1: single;
    TexCoordY2: single;
    ZValue1: single;
    ZValue2: single;
    WValue1: Integer;
    WValue2: Integer;
    class var
      WantColorNames: Boolean;
      T1, T2: single;
    procedure Clone(cr: TColorBand);
    function ToString: string; override;
    function ToLongString: string;
    function Parse(s: string): Boolean;
    procedure Clear;
    function FormatBandInfo(BandInfoFormat: TBandInfoFormat): string;
    function FormatBandInfo4: string;
    function FormatBandInfo6: string;
    function FormatBandInfoB: string;
    function FormatBandInfoC: string;
    function FormatBandInfoN(ACurrentRing: Integer): string;
    function FormatBandInfoNZ(ACurrentRing: Integer): string;
    function FormatBandInfoNW(ACurrentRing: Integer): string;
  end;

  TColorBands = class(TList<TColorBand>)
  private
    procedure ClearBands;
  public
    destructor Destroy; override;
    procedure InitItems(k: Integer);
    procedure Clone(Other: TColorBands);
  end;

  TColorStrip = class
  private
    Colors: array[0..StripConst.StripCount] of TAlphaColor;
    FHasColor: Boolean;
    function GetColor(j: Integer): TAlphaColor;
    procedure SetColor(j: Integer; const Value: TAlphaColor);
    function GetStripColor: TAlphaColor;
    procedure SetStripColor(const Value: TAlphaColor);
  public
    procedure Clear;
    procedure Assign(cr: TColorStrip);
    property Color[j: Integer]: TAlphaColor read GetColor write SetColor;
    property StripColor: TAlphaColor read GetStripColor write SetStripColor;
    property HasColor: Boolean read FHasColor;
  end;

  TColorDataSource = class
  public
    ColorMix: Integer;
    function MC(j, r, g, b: Integer): TAlphaColor;
    function MG(j, c: TAlphaColor): TAlphaColor;
  end;

implementation

{ TColorBand }

procedure TColorBand.Clear;
begin
  Color := claWhite;
  Width := StripConst.DefaultBandWidth;
  Contour := 1;
  Farbe := claBlack;
  Ring := 0;
end;

function TColorBand.FormatBandInfoB: string;
var
  cr: TAlphaColorRec;
  cs: string;
begin
  cr := TAlphaColorRec(Color);
  cs := Format('%.3d-%.3d-%.3d', [cr.R, cr.G, cr.B]);
  result  := Format('%d=%.3d-%s', [nStripColorOffset + Ring, Width, cs]);
end;

function TColorBand.FormatBandInfoC: string;
var
  cs: string;
begin
  cs := ToString;
  result  := Format('%d=%s', [Ring, cs]);
end;

procedure TColorBand.Clone(cr: TColorBand);
begin
  Width := cr.Width;
  Contour := cr.Contour;
  Color := cr.Color;
  Farbe := cr.Farbe;
end;

function TColorBand.FormatBandInfo(BandInfoFormat: TBandInfoFormat): string;
begin
  case BandInfoFormat of
    TBandInfoFormat.BandInfoFormat4: result := FormatBandInfo4;
    TBandInfoFormat.BandInfoFormat6: result := FormatBandInfo6;
    TBandInfoFormat.BandInfoFormatB: result := FormatBandInfoB;
    TBandInfoFormat.BandInfoFormatC: result := FormatBandInfoC;
    else
      result := ToString;
  end;
end;

function TColorBand.FormatBandInfo4: string;
var
  cr: TAlphaColorRec;
  cs: string;
begin
  result := '';
  if WantColorNames and AlphaColorToIdent(Integer(Color), cs) then
  begin
    if cs.StartsWith('x') then
    begin
      cr := TAlphaColorRec(Color);
      cs := Format('%.3d-%.3d-%.3d', [cr.R, cr.G, cr.B]);
    end;
    result  := Format('Bands[%d] := ''%.3d-%s'';', [Ring, Width, cs]);
  end
  else
  begin
    cr := TAlphaColorRec(Color);
    cs := Format('%.3d-%.3d-%.3d', [cr.R, cr.G, cr.B]);
    result  := Format('Bands[%d] := ''%.3d-%s'';', [Ring, Width, cs]);
  end;
end;

function TColorBand.FormatBandInfo6: string;
var
  cr: TAlphaColorRec;
  cs: string;
begin
  cr := TAlphaColorRec(Color);
  cs := Format('%.3d-%.3d-%.3d-%.3d-%.3d-%.3d', [Width, cr.R, cr.G, cr.B, Contour, cr.A]);
  result  := Format('Bands[%d] := ''%s'';', [Ring, cs]);
end;

function TColorBand.FormatBandInfoN(ACurrentRing: Integer): string;
var
  cr: TAlphaColorRec;
  cs: string;
begin
  cr := TAlphaColorRec(Color);
  cs := Format('%.3d-%.3d-%.3d', [cr.R, cr.G, cr.B]);
  result  := Format('%.2d/%.2d %s', [Ring, Width, cs]);
  if Ring = ACurrentRing then
    result := result + ' <-'
  else
    result := result + ' --';
end;

function TColorBand.FormatBandInfoNZ(ACurrentRing: Integer): string;
var
  cr: TAlphaColorRec;
  cs: string;
begin
  cr := TAlphaColorRec(Color);
  cs := Format('%.3d-%.3d-%.3d', [cr.R, cr.G, cr.B]);
  result  := Format('%.2d/%.2d %s %7.2f, %7.2f', [Ring, Width, cs, ZValue1, ZValue2]);
  if Ring = ACurrentRing then
    result := result + ' <-'
  else
    result := result + ' --';
end;

function TColorBand.FormatBandInfoNW(ACurrentRing: Integer): string;
var
  cr: TAlphaColorRec;
  cs: string;
begin
  cr := TAlphaColorRec(Color);
  cs := Format('%.3d-%.3d-%.3d', [cr.R, cr.G, cr.B]);
  result  := Format('%.2d/%.2d %s %.3d, %.3d', [Ring, Width, cs, WValue1, WValue2]);
  if Ring = ACurrentRing then
    result := result + ' <-'
  else
    result := result + ' --';
end;

function TColorBand.ToString: string;
var
  cr: TAlphaColorRec;
begin
  cr := TAlphaColorRec(Color);
  result := Format('%.3d-%.3d-%.3d', [cr.R, cr.G, cr.B]);
end;

function TColorBand.ToLongString: string;
var
  cr: TAlphaColorRec;
begin
  cr := TAlphaColorRec(Color);
  result := Format('%.3d-%.3d-%.3d-%.3d-%.3d', [Width, cr.R, cr.G, cr.B, Contour, cr.A]);
end;

function TColorBand.Parse(s: string): Boolean;
var
  sw: string;
  sc: string;
  sa: string;
  sr: string;
  sg: string;
  sb: string;
  a, r, g, b: Byte;
  sar: TArray<string>;
  cla: TAlphaColor;
begin
  result := False;
  //WWW-RRR-GGG-BBB-CCC-AAA
  if Length(s) = 23 then
  begin
    sar := s.Split(['-']);
    if Length(sar) = 6 then
    begin
      sw := sar[0];
      sr := sar[1];
      sg := sar[2];
      sb := sar[3];
      sc := sar[4];
      sa := sar[5];
      Width := StrToIntDef(sw, 0);
      Contour := StrToIntDef(sc, 0);
      a := StrToIntDef(sa, 0);
      r := StrToIntDef(sr, 0);
      g := StrToIntDef(sg, 0);
      b := StrToIntDef(sb, 0);
      cla := MakeColor(r, g, b, a);
      Color := cla;
      result := True;
    end;
  end
  //WWW-RRR-GGG-BBB
  else if Length(s) = 15 then
  begin
    sar := s.Split(['-']);
    if Length(sar) = 4 then
    begin
      sw := sar[0];
      sr := sar[1];
      sg := sar[2];
      sb := sar[3];
      Width := StrToIntDef(sw, 0);
      r := StrToIntDef(sr, 0);
      g := StrToIntDef(sg, 0);
      b := StrToIntDef(sb, 0);
      cla := MakeColor(r, g, b);
      Color := cla;
      Contour := 0;
      result := True;
    end;
  end
  else
  begin
    sar := s.Split(['-']);
    if Length(sar) = 2 then
    begin
      sw := sar[0];
      sr := sar[1];
      Width := StrToIntDef(sw, 0);
      cla := StringToAlphaColor(sr);
      Color := cla;
      Contour := 0;
      result := True;
    end;
  end;
end;

{ TColorBands }

procedure TColorBands.InitItems(k: Integer);
var
  j: Integer;
  cr: TColorBand;
begin
  if Count < k then
    for j := Count to k - 1 do
    begin
      cr := TColorBand.Create;
      cr.Color := claWhite;
      cr.Farbe := claBlack;
      cr.Width := StripConst.DefaultBandWidth;
      cr.Contour := StripConst.DefaultStripWidth;
      Add(cr);
    end;
end;

procedure TColorBands.ClearBands;
var
  i: Integer;
  cr: TColorBand;
begin
  for i := Count - 1 downto 0 do
  begin
    cr := Self[i];
    cr.Free;
  end;
  Clear;
end;

procedure TColorBands.Clone(Other: TColorBands);
var
  j: Integer;
  cr1: TColorBand;
  cr2: TColorBand;
begin
  if Count = Other.Count then
  begin
  for j := 0 to Count - 1 do
  begin
    cr1 := Self[j];
    cr2 := Other[j];
      if cr2.Ring = j then
        cr1.Clone(cr2);
    end;
  end;
end;

destructor TColorBands.Destroy;
begin
  ClearBands;
  inherited;
end;

{ TColorStrip }

procedure TColorStrip.Assign(cr: TColorStrip);
var
  j: Integer;
begin
  for j := 0 to StripConst.StripCount do
    Colors[j] := cr.Colors[j];
end;

procedure TColorStrip.Clear;
var
  j: Integer;
begin
  FHasColor := False;
  Colors[0] := claBlack;
  for j := 1 to StripConst.StripCount do
    Colors[j] := claWhite;
end;

function TColorStrip.GetColor(j: Integer): TAlphaColor;
begin
  result := Colors[j];
end;

function TColorStrip.GetStripColor: TAlphaColor;
begin
  result := Colors[0];
end;

procedure TColorStrip.SetStripColor(const Value: TAlphaColor);
begin
  Colors[0] := Value;
end;

procedure TColorStrip.SetColor(j: Integer; const Value: TAlphaColor);
begin
  if (j >= 0) and (j <= StripConst.StripCount) then
  begin
    Colors[j] := Value;
    FHasColor := True;
  end;
end;

{ TColorDataSource }

function TColorDataSource.MC(j, r, g, b: Integer): TAlphaColor;
var
  ar, ag, ab: Integer;
begin
  case ColorMix of
    1:
    begin
     ar := r;
     ag := b;
     ab := g;
    end;
    2:
    begin
     ar := g;
     ag := b;
     ab := r;
    end;
    3:
    begin
     ar := g;
     ag := r;
     ab := b;
    end;
    4:
    begin
     ar := b;
     ag := r;
     ab := g;
    end;
    5:
    begin
     ar := b;
     ag := g;
     ab := r;
    end;

    else //0:
    begin
     ar := r;
     ag := g;
     ab := b;
    end;
  end;

  result := MakeColor(ar, ag, ab);
end;

function TColorDataSource.MG(j, c: TAlphaColor): TAlphaColor;
begin
  result := MC(j,
  TAlphaColorRec(c).R,
  TAlphaColorRec(c).G,
  TAlphaColorRec(c).B);
end;

end.
