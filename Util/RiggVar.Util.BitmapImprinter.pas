unit RiggVar.Util.BitmapImprinter;

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
  FMX.Graphics,
  FMX.Types;

type
  TBitmapImprinter = class
  public
    procedure WriteTest(ML: TStrings);
    procedure ReadTest(ML: TStrings);
    procedure SaveToBitmap(Bitmap: TBitmap; ML: TStrings);
    procedure LoadFromBitmap(Bitmap: TBitmap; ML: TStrings);
    procedure LoadFromFile(fn: string; ML: TStrings);
    function CheckForData(fn: string): Boolean;
    function CheckBitmapForData(Bitmap: TBitmap): Boolean;
  end;

implementation

{ TBitmapImprinter }

procedure TBitmapImprinter.WriteTest(ML: TStrings);
var
  h, w: Integer;
  ByteCount: Integer;
  PixelCount: Integer;

  i: Integer;
  k: Integer;
  c: char;
  x: Integer;

  s: string;
  u: string;
begin
  s := ML.Text;
  ML.Clear;

  h := 40;
  w := 40;
  PixelCount := h * w;
  ByteCount := Length(s);

  if ByteCount > PixelCount then
    Exit;

  k := -1;
  for i := 0 to ByteCount - 1 do
  begin
    c := s[i+1];
    if c = #10 then
      c := ';';
    if c = #13 then
      Continue;

    Inc(k);
    x := k mod w;

    if x = w-2 then
    begin
      u := u + c;
      ML.Add(u);
      u := '';
    end
    else
    begin
      u := u + c;
    end;
  end;
  u := u + '~';
  if u <> '' then
    ML.Add(u)
end;

procedure TBitmapImprinter.LoadFromFile(fn: string; ML: TStrings);
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.CreateFromFile(fn);
  LoadFromBitmap(Bitmap, ML);
  Bitmap.Free;
end;

procedure TBitmapImprinter.ReadTest(ML: TStrings);
var
  s: string;
  i: Integer;
  c: char;
  u: string;
begin
  s := ML.Text;
  ML.Add('');

  u := '';
  for i := 1 to Length(s) do
  begin
    c := s[i];
    if c = #10 then
      Continue
    else if c = #13 then
      Continue
    else if c = ';' then
    begin
      ML.Add(u);
      u := '';
      Continue;
    end
    else if c = '~' then
    begin
      if u <> '' then
        ML.Add(u);
      break;
    end
    else
    begin
      u := u + c;
    end;
  end;
end;

(*

0=1;1=64.95;2=-64.95;5=37.5;6=37.5;7=-7
5;9=90;10=90;11=90;12=90;34=40;23=10;24=
2;25=16;40=180.00;45=9.15;75=7;76=196;20
5=False;206=False;216=4;217=True;218=0.3
6;900=Green;901=#FF520A97;902=#FFE7B693;
903=#FFEC4659;904=#FF92E6E2;905=#FF169BD
B;906=#FF7B8A47;907=#FFE6DEDC;908=#FF55B
6DD;909=#FFEC3876;910=#FFD4EB58;911=#FF5
B5E5C;912=#FF9F8BB9;913=#FFE81956;914=#F
FF0A9A4;915=#FF0BC9A9;916=#FF1DCA09;917=
#FFD96F39;918=#FFA2B973;919=#FFE3CF68;92
0=#FF91B229;921=#FFE284D8;922=#FF3E9FBA;
923=#FFF64AD2;924=#FF2F7FFB;925=#FF02BB8
4;926=#FF7AC535;927=#FF730EC0;928=#FFDF8
519;929=#FF4AFBC5;930=#FF5B428E;931=#FF0
A930D;932=#FF944000;933=#FFB945D5;~


0=1
1=64.95
2=-64.95
5=37.5
6=37.5
7=-75
9=90
10=90
11=90
12=90
34=40
23=10
24=2
25=16
40=180.00
45=9.15
75=7
76=196
205=False
206=False
216=4
217=True
218=0.36
900=Green
901=#FF520A97
902=#FFE7B693
903=#FFEC4659
904=#FF92E6E2
905=#FF169BDB
906=#FF7B8A47
907=#FFE6DEDC
908=#FF55B6DD
909=#FFEC3876
910=#FFD4EB58
911=#FF5B5E5C
912=#FF9F8BB9
913=#FFE81956
914=#FFF0A9A4
915=#FF0BC9A9
916=#FF1DCA09
917=#FFD96F39
918=#FFA2B973
919=#FFE3CF68
920=#FF91B229
921=#FFE284D8
922=#FF3E9FBA
923=#FFF64AD2
924=#FF2F7FFB
925=#FF02BB84
926=#FF7AC535
927=#FF730EC0
928=#FFDF8519
929=#FF4AFBC5
930=#FF5B428E
931=#FF0A930D
932=#FF944000
933=#FFB945D5

*)

procedure TBitmapImprinter.SaveToBitmap(Bitmap: TBitmap; ML: TStrings);
var
  h, w: Integer;
  ByteCount: Integer;
  PixelCount: Integer;

  i: Integer;
  k: Integer;
  c: char;
  x, y: Integer;

  s: string;
  t: TBytes;
  u: Byte;

  Data: TBitmapData;
  r, g, b: Byte;
  cla: TAlphaColor;
begin
  h := Bitmap.Height;
  w := Bitmap.Width;
  PixelCount := h * w;

  s := ML.Text;
  t := TEncoding.UTF8.GetBytes(s);
  ByteCount := Length(t);

  if ByteCount > PixelCount then
    Exit;

  k := -1;
  if Bitmap.Map(TMapAccess.ReadWrite, Data) then
  begin
    for i := 0 to ByteCount - 1 do
    begin
      c := s[i+1];
      u := t[i];
      if c = #10 then
        u := Ord(';');
      if c = #13 then
        Continue;

      Inc(k);
      x := k mod w;
      y := k div w;
      cla := Data.GetPixel(x, y);
      r := u;
      g := TAlphaColorRec(cla).G;
      b := TAlphaColorRec(cla).B;
      cla := MakeColor(r, g, b);
      Data.SetPixel(x, y, cla)
    end;

    c := '~';
    u := Ord(c);
    Inc(k);
    x := k mod w;
    y := k div w;
    cla := Data.GetPixel(x, y);
    r := u;
    g := TAlphaColorRec(cla).G;
    b := TAlphaColorRec(cla).B;
    cla := MakeColor(r, g, b);
    Data.SetPixel(x, y, cla);
    Bitmap.Unmap(Data);
  end;
end;

procedure TBitmapImprinter.LoadFromBitmap(Bitmap: TBitmap; ML: TStrings);
var
  h, w: Integer;
  PixelCount: Integer;

  x, y: Integer;

  i: Integer;
  k: Integer;
  c: char;
  b: Byte;

  Data: TBitmapData;
  cla: TAlphaColor;

  u: string;
begin
  h := Bitmap.Height;
  w := Bitmap.Width;
  PixelCount := h * w;

  k := -1;
  if Bitmap.Map(TMapAccess.Read, Data) then
  begin
    for i := 0 to PixelCount-1 do
    begin
      Inc(k);
      x := k mod w;
      y := k div w;
      cla := Data.GetPixel(x, y);
      b := TAlphaColorRec(cla).R;
      c := char(b);

      if c = ';' then
      begin
        ML.Add(u);
        u := '';
        Continue;
      end
      else if c = '~' then
      begin
        if u <> '' then
          ML.Add(u);
        break;
      end
      else
      begin
        u := u + c;
      end;
    end;
    Bitmap.Unmap(Data);
  end;
end;

function TBitmapImprinter.CheckBitmapForData(Bitmap: TBitmap): Boolean;
var
  h, w: Integer;
  PixelCount: Integer;

  x, y: Integer;

  k: Integer;
  i: Integer;
  b: Byte;
  c: char;

  Data: TBitmapData;
  cla: TAlphaColor;

  u: string;
begin
  h := Bitmap.Height;
  w := Bitmap.Width;
  PixelCount := h * w;

  u := '';
  k := -1;
  if Bitmap.Map(TMapAccess.Read, Data) then
  begin
    for i := 0 to PixelCount-1 do
    begin
      Inc(k);
      x := k mod w;
      y := k div w;
      cla := Data.GetPixel(x, y);
      b := TAlphaColorRec(cla).R;
      c := char(b);
      u := u + c;
      if i = 2 then
        break;
    end;
    Bitmap.Unmap(Data);
  end;

  result := u = '0=1'
end;

function TBitmapImprinter.CheckForData(fn: string): Boolean;
var
  Bitmap: TBitmap;
begin
  result := False;
  if FileExists(fn) then
  begin
    Bitmap := TBitmap.CreateFromFile(fn);
    result := CheckBitmapForData(Bitmap);
    Bitmap.Free;
  end;
end;

end.
