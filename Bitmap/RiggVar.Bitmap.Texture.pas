unit RiggVar.Bitmap.Texture;

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
  System.UIConsts,
  System.UITypes,
  FMX.Graphics,
  FMX.Types,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Data,
  RiggVar.Bitmap.Bitmap99,
  RiggVar.Bitmap.Bitmap02;

type
  TFederTexture = class
  private
    BitmapBuilder99: TBitmapBuilder99;
  public
    BitmapBuilder: TBitmapBuilder02;
    UsedT3: single;
    UsedT4: single;
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFederData(fd: TFederData);
    function GetBitmapText: string;
    function GetBitmap(bid: Integer = 0): TBitmap;
  end;

implementation

uses
  RiggVar.App.Main;

constructor TFederTexture.Create;
begin
  BitmapBuilder := TBitmapBuilder02.Create;
  BitmapBuilder99 := TBitmapBuilder99.Create;
  BitmapBuilder.UseViewportBackground := True;
end;

destructor TFederTexture.Destroy;
begin
  BitmapBuilder.Free;
  BitmapBuilder99.Free;
  inherited;
end;

function TFederTexture.GetBitmapText: string;
begin
  result := 'not implemented';
end;

procedure TFederTexture.LoadFromFederData(fd: TFederData);
begin
  if fd.HasBandProps then
  begin
    BitmapBuilder.StripWidth := fd.StripWidth;
    BitmapBuilder.BandWidth := fd.BandWidth;

    BitmapBuilder.SchemeID := fd.StandardColor;
    BitmapBuilder.BlindColorCount := fd.BlindColorCount;

    BitmapBuilder.WantContour := fd.WantContour;
    BitmapBuilder.WantShirtColor := fd.WantShirtColor;

    BitmapBuilder.SquareBitmap := fd.SquareBitmap;
    BitmapBuilder.HorizontalBitmap := fd.HorizontalBitmap;
    BitmapBuilder.SquareSym := fd.SquareSym;

    BitmapBuilder.RandomPaint := fd.RandomPaint;
    BitmapBuilder.StandardPaint := fd.StandardPaint;
    BitmapBuilder.MonoPaint := fd.MonoPaint;

    BitmapBuilder.StripColor := Main.ColorStrip.StripColor;
  end;

  if fd.HasBandColor then
  begin
    BitmapBuilder.ReadBandInfo(fd.ColorBands);
    fd.HasBandColor := False;
  end
  else
  begin
    { causes ReadBandColorProps to be called in TBitmapBuilder02.InitBands2 }
    BitmapBuilder.UpdateReason := TUpdateReason.cuNone;
  end;
end;

function TFederTexture.GetBitmap(bid: Integer): TBitmap;
begin
  case bid of
    0: result := BitmapBuilder.GetBitmap;

    1..6:
    begin
      { props not used }
      BitmapBuilder99.BitmapID := bid;
      result := BitmapBuilder99.GetBitmap;
    end;

    else
    begin
      { init props from built-in values and go }
      case BitmapBuilder.UpdateReason of
        TUpdateReason.cuBlindCount,
        TUpdateReason.cuColorMix,
        TUpdateReason.cuBandsPasted:
        begin
          { do nothing }
        end;

        else
        begin
          BitmapBuilder.InitProps(bid);
        end;
      end;

      result := BitmapBuilder.GetBitmap;
    end;
  end;

  { if external Bitmap cannot load }
  if result = nil then
  begin
    BitmapBuilder99.BitmapID := 2;
    result := BitmapBuilder99.GetBitmap;
  end;

  UsedT3 := BitmapBuilder.StripWidth;
  UsedT4 := BitmapBuilder.BandWidth;
end;

end.
