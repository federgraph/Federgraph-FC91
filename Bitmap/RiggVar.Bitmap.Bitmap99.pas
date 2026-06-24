unit RiggVar.Bitmap.Bitmap99;

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
  System.UITypes,
  System.UIConsts,
  FMX.Graphics,
  FMX.Types,
  RiggVar.FB.Bitmap;

type
  TBitmapBuilder99 = class
  private
    function GetBitmap99(
      color: Boolean; szmin, szmax, offset, gain: Integer): TBitmap;
    function GetBitmap1: TBitmap;
    function GetBitmap2: TBitmap;
    function GetBitmap3: TBitmap;
    function GetBitmap4: TBitmap;
    function GetBitmap5: TBitmap;
    function GetBitmap6: TBitmap;
  public
    BitmapID: Integer;
    ColorHSL: Boolean;
    SZMin: Integer;
    SZMax: Integer;
    Offset: Integer;
    Gain: Integer;
    function GetBitmap: TBitmap; //override;
  end;

implementation

function TBitmapBuilder99.GetBitmap: TBitmap;
begin
  case BitmapID of
    1: result := GetBitmap1;
    2: result := GetBitmap2;
    3: result := GetBitmap3;
    4: result := GetBitmap4;
    5: result := GetBitmap5;
    6: result := GetBitmap6;
    else
      result := GetBitmap99(ColorHSL, SZMin, SZMax, Offset, Gain);
  end;
end;

function TBitmapBuilder99.GetBitmap99(color: Boolean; szmin, szmax, offset, gain: Integer): TBitmap;
var
  Data: TBitmapData;
  i: Integer;
  u, v: Integer;
  h, l, s: single;
  cla: TAlphaColor;
begin
  result := TBitmap.Create(1, 360);
  if result.Map(TMapAccess.Write, Data) then
  begin
    s := 0.75;
    l := 0.5;
    u := szmin;
    v := 1;
    for i := 0 to 359 do
    begin

      h := (offset + u * gain) / 360;
      if h < 0 then
        h := 0;
      if h > 1 then
        h := 1;

      if color then
        cla := HSLtoRGB(h, s, l)
      else
        cla := MakeColor(round(h * $FF), round(h * $FF), round(h * $FF));

      Data.SetPixel(0, i, cla);

      { modulate color between toolchain szmin and szmax }
      if u >= szmax then
      begin
        Dec(u);
        v := -1;
      end
      else if u <= szmin then
      begin
        Inc(u);
        v := 1;
      end
      else
        u := u + v;
    end;
    result.Unmap(Data);
  end;
end;

function TBitmapBuilder99.GetBitmap1: TBitmap;
begin
//  BitmapBuilder99.ColorHSL := True;
//  BitmapBuilder99.SZMin := 0;
//  BitmapBuilder99.SZMax := 360;
//  BitmapBuilder99.Offset := 0;
//  BitmapBuilder99.Gain := 1;
  result := GetBitmap99(True, 0, 360, 0, 1);
end;

function TBitmapBuilder99.GetBitmap2: TBitmap;
begin
  result := GetBitmap99(True, 0, 10, 0, 36);
end;

function TBitmapBuilder99.GetBitmap3: TBitmap;
begin
  result := GetBitmap99(False, 0, 10, 300, -20);
end;

function TBitmapBuilder99.GetBitmap4: TBitmap;
begin
  result := GetBitmap99(False, 90, 270, 0, 1);
end;

function TBitmapBuilder99.GetBitmap5: TBitmap;
begin
  result := GetBitmap99(True, 0, 10, 40, 10);
end;

function TBitmapBuilder99.GetBitmap6: TBitmap;
begin
  result := GetBitmap99(True, 0, 10, 200, 20);
end;

end.
