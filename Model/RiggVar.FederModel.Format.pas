unit RiggVar.FederModel.Format;

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
  System.Math,
  System.SysUtils,
  System.Types,
  System.UITypes;

type
  TFormatManager = class
  private
    InitialFormat: TSize;
    FWantClientFormat: Boolean;
    procedure SetFormatIndex(const Value: Integer);
    procedure SetSize(const Value: TSize);
    function GetSize: TSize;
    procedure UpdateFormatIndex(fi: Integer);
    procedure SetWantClientFormat(const Value: Boolean);
    procedure UpdateSize(p: TSize);
    function GetFormatInfo: string;
  public
    constructor Create;

    procedure MakeFotoFormat;
    procedure MakeBigger;
    procedure MakeSmaller;
    procedure MakeDefaultSize;

    function GetFormat(idx: Integer): TSize;

    property FormatIndex: Integer write SetFormatIndex;
    property Size: TSize read GetSize write SetSize;
    property WantClientFormat: Boolean read FWantClientFormat write SetWantClientFormat;
    property FormatInfo: string read GetFormatInfo;
  end;

implementation

uses
  FrmMain;

constructor TFormatManager.Create;
begin
  WantClientFormat := True;
  InitialFormat.cx := FormMain.ClientWidth;
  InitialFormat.cy := FormMain.ClientHeight;
end;

function TFormatManager.GetFormat(idx: Integer): TSize;
var
  w, h: Integer;
begin
  case idx of
    0:
    begin
      w := 1500;
      h := 1000;
    end;
    1:
    begin
      { Tablet Landscape }
      w := 1024;
      h := 768;
    end;
    2:
    begin
      { Tablet Portrait }
      w := 768;
      h := 840;
    end;
    3:
    begin
      { Phone Small Landscape }
      w := 480;
      h := 320;
    end;
    4:
    begin
      { Phone Small Portrait }
      w := 320;
      h := 480;
    end;
    5:
    begin
      { Phone Bigger Landscape }
      w := 640;
      h := 480;
    end;
    6:
    begin
      { Phone Bigger Portrait }
      w := 480;
      h := 640;
    end;
    7:
    begin
      { Test }
      w := 900;
      h := 600;
    end;
    else
    begin
      w := InitialFormat.cx;
      h := InitialFormat.cy;
    end;
  end;
  result := TSize.Create(w, h);
end;

function TFormatManager.GetSize: TSize;
begin
  if WantClientFormat then
  begin
    result.Width := FormMain.ClientWidth;
    result.Height := FormMain.ClientHeight;
  end
  else
  begin
    result.Width := FormMain.Width;
    result.Height := FormMain.Height;
  end;
end;

procedure TFormatManager.SetSize(const Value: TSize);
begin
  if WantClientFormat then
  begin
    FormMain.ClientWidth := Value.Width;
    FormMain.ClientHeight := Value.Height;
  end
  else
  begin
    FormMain.Width := Value.Width;
    FormMain.Height := Value.Height;
  end;
end;

procedure TFormatManager.SetWantClientFormat(const Value: Boolean);
begin
  FWantClientFormat := Value;
end;

procedure TFormatManager.SetFormatIndex(const Value: Integer);
begin
  UpdateFormatIndex(Value);
end;

procedure TFormatManager.UpdateFormatIndex(fi: Integer);
begin
  UpdateSize(GetFormat(fi));
end;

procedure TFormatManager.UpdateSize(p: TSize);
begin
  Size := p;
end;

procedure TFormatManager.MakeBigger;
var
  p: TSize;
begin
  p := Size;
  p.Width := Round(p.Width * 1.2);
  p.Height := Round(p.Height * 1.2);
  if p.Height <= 1080 then
    UpdateSize(p);
end;

procedure TFormatManager.MakeSmaller;
var
  p: TSize;
begin
  p := Size;
  p.Width := Round(p.Width / 1.2);
  p.Height := Round(p.Height / 1.2);
  if p.Height >= 512 then
    UpdateSize(p);
end;

procedure TFormatManager.MakeDefaultSize;
var
  p: TSize;
begin
  p := Size;
  p.Width := InitialFormat.cx;
  p.Height := InitialFormat.cy;
  UpdateSize(p);
end;

procedure TFormatManager.MakeFotoFormat;
var
  p: TSize;
  temp, x, y: Integer;
begin
  WantClientFormat := True;
  p := Size; // ClientSize;
  if p.Width > 3/2 * p.Height then
  begin
    y := p.Height - p.Height mod 2;
    temp := y div 2;
    x := temp * 3;
    p.Height := y;
    p.Width := x;
    UpdateSize(p);
  end;
end;

function TFormatManager.GetFormatInfo: string;
begin
  result := Format(
    '%dx%d',
    [FormMain.ClientWidth, FormMain.ClientHeight]);
end;

end.
