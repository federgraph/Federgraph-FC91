unit RiggVar.Bitmap.Strips;

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
  RiggVar.FB.Bitmap;

type
  TStripColorData = class(TColorDataSource)
  protected
    function GetBitmapColor1(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor2(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor3(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor4(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor5(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor6(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor7(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor8(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor9(j: Integer): TAlphaColor; virtual;
    function GetBitmapColor0(j: Integer): TAlphaColor; virtual;
  public
    function GetBitmapColor(SchemeID: Integer; j: Integer; Mix: Integer = 0): TAlphaColor; virtual;
  end;

implementation

{ TStripColorData }

function TStripColorData.GetBitmapColor1(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor2(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor3(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor4(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor5(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor6(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor7(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor8(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor9(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor0(j: Integer): TAlphaColor;
begin
  result := claWhite;
end;

function TStripColorData.GetBitmapColor(SchemeID, j, Mix: Integer): TAlphaColor;
begin
  result := claWhite;
end;

end.
