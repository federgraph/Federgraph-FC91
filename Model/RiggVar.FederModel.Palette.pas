unit RiggVar.FederModel.Palette;

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
  System.UIConsts,
  System.UITypes,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Color,
  RiggVar.FB.Def,
  RiggVar.FederModel.TouchBase,
  RiggVar.FederModel.Touch;

type
  TFederPalette = class
  private
    FPaletteMode: Boolean;
    FPalettePage: Integer;
    FPaletteColor: TAlphaColor;
    FPaletteColorString: string;
    claPaletteBtn: TAlphaColor;

    procedure InitTouchMenu;
    procedure InitCornerMenu(page: Integer);

    function GetTouchMenuColor(Index: Integer): TAlphaColor;

    procedure SetPaletteMode(const Value: Boolean);
    procedure SetPaletteColor(const Value: TAlphaColor);
    function GetTouchMenu: TTouchMenu;
    function GetFederText: TFederTouch;
    function GetMenuColor(Index: Integer): TAlphaColor;
    procedure SetMenuColor(Index: Integer; const Value: TAlphaColor);
    procedure SetLabelText(Index: Integer; const Value: string);
    function GetActionText(Index: Integer): string;
    function GetPaletteBtn: TCornerBtn;
    function GetPaletteBtnID: Integer;
    function GetColorName(Value: TAlphaColor): string;
  public
    AutoApply: Boolean;

    constructor Create;

    procedure TogglePalette(Value: Integer);

    function HandleTouchBtnClick(Sender: TTouchBtn): Boolean;

    procedure InitPalettePage(page: Integer; l: TList<TAlphaColor>);

    property PaletteMode: Boolean read FPaletteMode write SetPaletteMode;
    property PaletteColor: TAlphaColor read FPaletteColor write SetPaletteColor;
    property PaletteColorString: string read FPaletteColorString;

    property FederText: TFederTouch read GetFederText;
    property TouchMenu: TTouchMenu read GetTouchMenu;
    property MenuColor[Index: Integer]: TAlphaColor read GetMenuColor write SetMenuColor;
    property LabelText[Index: Integer]: string write SetLabelText;
    property ActionText[Index: Integer]: string read GetActionText;

    property PalettePage: Integer read FPalettePage;
    property PaletteBtn: TCornerBtn read GetPaletteBtn;
    property PaletteBtnID: Integer read GetPaletteBtnID;
  end;

implementation

uses
  RiggVar.App.Main;

constructor TFederPalette.Create;
begin
  AutoApply := True;
  claPaletteBtn := claGray;
  FPalettePage := 1;
end;

procedure TFederPalette.InitPalettePage(page: Integer; l: TList<TAlphaColor>);
begin
  FPalettePage := page;
  case page of
    0:
    begin
      { 1} l.Add(claWhite);
      { 2} l.Add(claWhiteSmoke);
      { 3} l.Add(claGainsboro);
      { 4} l.Add(claLightGray);
      { 5} l.Add(claSilver);
      { 6} l.Add(claDarkGray);

      { 7} l.Add(claGray);
      { 8} l.Add(claDimGray);
      { 9} l.Add(claBlack);
      {10} l.Add(claLightPink);
      {11} l.Add(claThistle);
      {12} l.Add(claOrchid);
      {13} l.Add(claMediumPurple);
      {14} l.Add(claLightCyan);

      {15} l.Add(claCornFlowerBlue);
      {16} l.Add(claMediumTurquoise);
      {17} l.Add(claLightGreen);
      {18} l.Add(claLawnGreen);
      {19} l.Add(claSnow);
      {20} l.Add(claPeachPuff);
      {21} l.Add(claTan);
      {22} l.Add(claLightCoral);

      {23} l.Add(claSalmon);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(claIndianRed);
      {26} l.Add(claSienna);
      {27} l.Add(claGold);
      {28} l.Add(claDarkOrange);
      {29} l.Add(claGray);
    end;
    1:
    begin
      { 1} l.Add(claLavenderblush);
      { 2} l.Add(claLightPink);
      { 3} l.Add(claPink);
      { 4} l.Add(claDeepPink);
      { 5} l.Add(claHotPink);
      { 6} l.Add(claThistle);

      { 7} l.Add(claPlum);
      { 8} l.Add(claViolet);
      { 9} l.Add(claOrchid);
      {10} l.Add(claPaleVioletRed);
      {11} l.Add(claMediumVioletRed);
      {12} l.Add(claCrimson);
      {13} l.Add(claFuchsia);
      {14} l.Add(claDarkMagenta);

      {15} l.Add(claMediumOrchid);
      {16} l.Add(claDarkOrchid);
      {17} l.Add(claSlateBlue);
      {18} l.Add(claMediumPurple);
      {19} l.Add(claPurple);
      {20} l.Add(claBlueViolet);
      {21} l.Add(claDarkViolet);
      {22} l.Add(claIndigo);

      {23} l.Add(claRed);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(claGreen);
      {26} l.Add(claWhite);
      {27} l.Add(claBlack);
      {28} l.Add(claGray);
    end;

    2:
    begin
      { 1} l.Add(claGhostWhite);
      { 2} l.Add(claAliceBlue);
      { 3} l.Add(claAzure);
      { 4} l.Add(claLightCyan);
      { 5} l.Add(claLavender);
      { 6} l.Add(claPaleTurquoise);

      { 7} l.Add(claPowderBlue);
      { 8} l.Add(claLightBlue);
      { 9} l.Add(claLightSteelBlue);
      {10} l.Add(claLightSkyBlue);
      {11} l.Add(claSkyBlue);
      {12} l.Add(claLightSlateGray);
      {13} l.Add(claSlateGray);
      {14} l.Add(claDarkSlateGray);

      {15} l.Add(claCadetBlue);
      {16} l.Add(claSteelBlue);
      {17} l.Add(claCornFlowerBlue);
      {18} l.Add(claDodgerBlue);
      {19} l.Add(claRoyalBlue);
      {20} l.Add(claMediumBlue);
      {21} l.Add(claBlue);
      {22} l.Add(claDarkBlue);

      {23} l.Add(claNavy);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(claMidnightBlue);
      {26} l.Add(claMintCream);
      {27} l.Add(claHoneydew);
      {28} l.Add(claChartreuse);
    end;

    3:
    begin
      { 1} l.Add(claDeepSkyBlue);
      { 2} l.Add(claDarkTurquoise);
      { 3} l.Add(claAqua);
      { 4} l.Add(claDarkCyan);
      { 5} l.Add(claTeal);
      { 6} l.Add(claAquamarine);

      { 7} l.Add(claMediumAquamarine);
      { 8} l.Add(claMediumTurquoise);
      { 9} l.Add(claTurquoise);
      {10} l.Add(claMediumSeaGreen);
      {11} l.Add(claSeaGreen);
      {12} l.Add(claLightSeaGreen);
      {13} l.Add(claMediumSpringGreen);
      {14} l.Add(claSpringGreen);

      {15} l.Add(claPaleGreen);
      {16} l.Add(claLightGreen);
      {17} l.Add(claDarkSeaGreen);
      {18} l.Add(claLimeGreen);
      {19} l.Add(claYellowGreen);
      {20} l.Add(claGreenYellow);
      {21} l.Add(claOliveDrab);
      {22} l.Add(claDarkOliveGreen);

      {23} l.Add(claForestGreen);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(claGreen);
      {26} l.Add(claDarkGreen);
      {27} l.Add(claLime);
      {28} l.Add(claLawnGreen);
    end;

    4:
    begin
      { 1} l.Add(claSnow);
      { 2} l.Add(claIvory);
      { 3} l.Add(claFloralWhite);
      { 4} l.Add(claSeashell);
      { 5} l.Add(claOldLace);
      { 6} l.Add(claLinen);

      { 7} l.Add(claMistyRose);
      { 8} l.Add(claLightYellow);
      { 9} l.Add(claCornSilk);
      {10} l.Add(claBeige);
      {11} l.Add(claAntiqueWhite);
      {12} l.Add(claPapayaWhip);
      {13} l.Add(claLightGoldenrodYellow);
      {14} l.Add(claLemonChiffon);

      {15} l.Add(claBlanchedAlmond);
      {16} l.Add(claBisque);
      {17} l.Add(claPeachPuff);
      {18} l.Add(claMoccasin);
      {19} l.Add(claWheat);
      {20} l.Add(claNavajoWhite);
      {21} l.Add(claPaleGoldenrod);
      {22} l.Add(claRosyBrown);

      {23} l.Add(claKhaki);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(claTan);
      {26} l.Add(claBurlyWood);
      {27} l.Add(claLightCoral);
      {28} l.Add(claRed);
    end;

    5:
    begin
      { 1} l.Add(claLightSalmon);
      { 2} l.Add(claDarkSalmon);
      { 3} l.Add(claSalmon);
      { 4} l.Add(claDarkKhaki);
      { 5} l.Add(claSandyBrown);
      { 6} l.Add(claCoral);

      { 7} l.Add(claTomato);
      { 8} l.Add(claPeru);
      { 9} l.Add(claIndianRed);
      {10} l.Add(claSienna);
      {11} l.Add(claBrown);
      {12} l.Add(claFireBrick);
      {13} l.Add(claGoldenrod);
      {14} l.Add(claChocolate);

      {15} l.Add(claSaddleBrown);
      {16} l.Add(claDarkGoldenrod);
      {17} l.Add(claYellow);
      {18} l.Add(claOlive);
      {19} l.Add(claGold);
      {20} l.Add(claOrange);
      {21} l.Add(claDarkOrange);
      {22} l.Add(claRed);

      {23} l.Add(claDarkRed);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(claMaroon);
      {26} l.Add(claWhite);
      {27} l.Add(claBlack);
      {28} l.Add(claGray);
    end;

    6: { Bambulab PLA Basic colors }
    begin
      { 1} l.Add(TBasicColors.PLABasic_JadeWhite);
      { 2} l.Add(TBasicColors.PLABasic_Beige);
      { 3} l.Add(TBasicColors.PLABasic_Gold);
      { 4} l.Add(TBasicColors.PLABasic_Silver);
      { 5} l.Add(TBasicColors.PLABasic_Gray);
      { 6} l.Add(TBasicColors.PLABasic_Bronze);

      { 7} l.Add(TBasicColors.PLABasic_Brown);
      { 8} l.Add(TBasicColors.PLABasic_CocoaBrown);
      { 9} l.Add(TBasicColors.PLABasic_MaroonRed);
      {10} l.Add(TBasicColors.PLABasic_Red);
      {11} l.Add(TBasicColors.PLABasic_Magenta);
      {12} l.Add(TBasicColors.PLABasic_Pink);
      {13} l.Add(TBasicColors.PLABasic_HotPink);
      {14} l.Add(TBasicColors.PLABasic_Orange);

      {15} l.Add(TBasicColors.PLABasic_Pumpkin);
      {16} l.Add(TBasicColors.PLABasic_SunflowerYellow);
      {17} l.Add(TBasicColors.PLABasic_Yellow);
      {18} l.Add(TBasicColors.PLABasic_BrightGreen);
      {19} l.Add(TBasicColors.PLABasic_BambuGreen);
      {20} l.Add(TBasicColors.PLABasic_MistletoeGreen);
      {21} l.Add(TBasicColors.PLABasic_Turquoise);
      {22} l.Add(TBasicColors.PLABasic_Cyan);

      {23} l.Add(TBasicColors.PLABasic_Blue);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(TBasicColors.PLABasic_CobaltBlue);
      {26} l.Add(TBasicColors.PLABasic_Purple);
      {27} l.Add(TBasicColors.PLABasic_IndigoPurple);
      {28} l.Add(TBasicColors.PLABasic_BlueGray);
    end;

    7: { Bambulab PLA Matte colors }
    begin
      { 1} l.Add(TMatteColors.PLAMatte_AshGray);
      { 2} l.Add(TMatteColors.PLAMatte_AshGray);
      { 3} l.Add(TMatteColors.PLAMatte_AshGray);
      { 4} l.Add(TMatteColors.PLAMatte_IvoryWhite);
      { 5} l.Add(TMatteColors.PLAMatte_LatteBrown);
      { 6} l.Add(TMatteColors.PLAMatte_DesertTan);

      { 7} l.Add(TMatteColors.PLAMatte_AshGray);
      { 8} l.Add(TMatteColors.PLAMatte_LilacPurple);
      { 9} l.Add(TMatteColors.PLAMatte_SakuraPink);
      {10} l.Add(TMatteColors.PLAMatte_MandarinOrange);
      {11} l.Add(TMatteColors.PLAMatte_LemonYellow);
      {12} l.Add(TMatteColors.PLAMatte_ScarletRed);
      {13} l.Add(TMatteColors.PLAMatte_DarkRed);
      {14} l.Add(TMatteColors.PLAMatte_DarkBrown);

      {15} l.Add(TMatteColors.PLAMatte_DarkGreen);
      {16} l.Add(TMatteColors.PLAMatte_GrassGreen);
      {17} l.Add(TMatteColors.PLAMatte_IceBlue);
      {18} l.Add(TMatteColors.PLAMatte_MarineBlue);
      {19} l.Add(TMatteColors.PLAMatte_DarkBlue);
      {20} l.Add(TMatteColors.PLAMatte_Charcoal);
      {21} l.Add(TMatteColors.PLAMatte_AshGray);
      {22} l.Add(TMatteColors.PLAMatte_AshGray);

      {23} l.Add(TMatteColors.PLAMatte_AshGray);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(TMatteColors.PLAMatte_AshGray);
      {26} l.Add(TMatteColors.PLAMatte_AshGray);
      {27} l.Add(TMatteColors.PLAMatte_AshGray);
      {28} l.Add(TMatteColors.PLAMatte_AshGray);
    end;

    8: { Bambulab dark colors }
    begin
      { 1} l.Add(TBambuColors.PLAMatte_DarkBlue);
      { 2} l.Add(TBambuColors.PLABasic_Gray);
      { 3} l.Add(TBambuColors.PLABasic_Blue);
      { 4} l.Add(TBambuColors.PLAMatte_MarineBlue);
      { 5} l.Add(TBambuColors.PLABasic_Cyan);
      { 6} l.Add(TBambuColors.PLABasic_Turquoise);

      { 7} l.Add(TBambuColors.PLABasic_BrightGreen);
      { 8} l.Add(TBambuColors.PLABasic_IndigoPurple);
      { 9} l.Add(TBambuColors.PLABasic_Purple);
      {10} l.Add(TBambuColors.PLABasic_CobaltBlue);
      {11} l.Add(TBambuColors.PLABasic_SunflowerYellow);
      {12} l.Add(TBambuColors.PLABasic_Bronze);
      {13} l.Add(TBambuColors.PLABasic_Brown);
      {14} l.Add(TBambuColors.PLABasic_CocoaBrown);

      {15} l.Add(TBambuColors.PLABasic_MaroonRed);
      {16} l.Add(TBambuColors.PLABasic_Red);
      {17} l.Add(TBambuColors.PLAMatte_DarkRed);
      {18} l.Add(TBambuColors.PLAMatte_ScarletRed);
      {19} l.Add(TBambuColors.PLABasic_HotPink);
      {20} l.Add(TBambuColors.PLABasic_Magenta);
      {21} l.Add(TBambuColors.PLABasic_Orange);
      {22} l.Add(TBambuColors.PLABasic_Pumpkin);

      {23} l.Add(TWebColors.Gray);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(TBambuColors.PLABasic_MistletoeGreen);
      {26} l.Add(TBambuColors.PLABasic_BambuGreen);
      {27} l.Add(TBambuColors.PLAMatte_GrassGreen);
      {28} l.Add(TBambuColors.PLABasic_Black);
    end;

    9:{ Bambulab light colors }
    begin
      { 1} l.Add(TWebColors.Gray);
      { 2} l.Add(TWebColors.Gray);
      { 3} l.Add(TBambuColors.PLABasic_Gray);
      { 4} l.Add(TBambuColors.PLABasic_Silver);
      { 5} l.Add(TBambuColors.PLABasic_LightGray);
      { 6} l.Add(TWebColors.Gray);

      { 7} l.Add(TBambuColors.PLABasic_Yellow);
      { 8} l.Add(TWebColors.Gray);
      { 9} l.Add(TBambuColors.PLAMatte_IceBlue);
      {10} l.Add(TBambuColors.PLAMatte_SakuraPink);
      {11} l.Add(TBambuColors.PLABasic_Gold);
      {12} l.Add(TBambuColors.PLAMatte_LatteBrown);
      {13} l.Add(TBambuColors.PLABasic_Beige);
      {14} l.Add(TBambuColors.PLAMatte_DesertTan);

      {15} l.Add(TWebColors.Gray);
      {16} l.Add(TWebColors.Gray);
      {17} l.Add(TWebColors.Gray);
      {18} l.Add(TWebColors.Gray);
      {19} l.Add(TWebColors.Gray);
      {20} l.Add(TWebColors.Gray);
      {21} l.Add(TWebColors.Gray);
      {22} l.Add(TWebColors.Gray);

      {23} l.Add(TWebColors.Gray);
      {24} l.Add(claPaletteBtn);
      {25} l.Add(TWebColors.Gray);
      {26} l.Add(TWebColors.Gray);
      {27} l.Add(TBambuColors.PLAMatte_IvoryWhite);
      {28} l.Add(TWebColors.Gray);
    end;

  end;
end;

function TFederPalette.GetTouchMenuColor(Index: Integer): TAlphaColor;
begin
  case Index of
    0: result := claLightGray;
    1: result := claLightPink;
    2: result := claLightBlue;
    3: result := claLightGreen;
    4: result := claBurlywood;
    5: result := claLightSalmon;
    6: result := TBasicColors.PLABasic_Blue;
    7: result := TMatteColors.PLAMatte_SakuraPink;
    8: result := TBasicColors.PLABasic_Red;
    9: result := TBasicColors.PLABasic_Beige;
    else
      result := claPaletteBtn;
  end;
end;

procedure TFederPalette.TogglePalette(Value: Integer);
begin
  case Value of
    1:
    begin
      PaletteMode := True;
      InitCornerMenu(0);
      InitTouchMenu;
    end
    else
    begin
      PaletteMode := False;
      FederText.Reset;
    end;
  end;
end;

function TFederPalette.GetColorName(Value: TAlphaColor): string;
begin
  case FPalettePage of
    6: result := ColorVar.PLABasicPool.ColorToString(Value);
    7: result := ColorVar.PLAMattePool.ColorToString(Value);
    8: result := ColorVar.BambuColorPool.ColorToString(Value);
    9: result := ColorVar.BambuColorPool.ColorToString(Value);
    else
      result := ColorVar.RggColorPool.ColorToString(Value);
  end;
end;

procedure TFederPalette.SetPaletteColor(const Value: TAlphaColor);
begin
  FPaletteColor := Value;
  FPaletteColorString := GetColorName(Value);
  LabelText[5] := FPaletteColorString;
end;

procedure TFederPalette.SetPaletteMode(const Value: Boolean);
begin
  FPaletteMode := Value;
end;

function TFederPalette.HandleTouchBtnClick(Sender: TTouchBtn): Boolean;
var
  cla: TAlphaColor;
begin
  cla := Sender.Shape.Fill.Color;

  if (Sender.MenuBtn = False)
    and ((Sender.FederAction = faPaletteOn) or (Sender.FederAction = faPaletteOff))
  then
  begin
    result := False;
    Exit;
    { the palette toggle button,
      this is a regular Action,
      result must be false }
  end;

  if Sender.Parent = FederText.OptionBar.Container then
  begin
    result := False;
    Exit;
  end;

  if Sender.Parent = FederText.TransitBar.Container then
  begin
    result := False;
    Exit;
  end;

  if not PaletteMode then
  begin
    result := False;
    Exit;
  end;

  result := True;

  if Sender.MenuBtn then
  begin
    case Sender.ID of
      -1: { diese Paletten nicht aktivieren }
      begin

      end;

      else
      begin
        InitCornerMenu(Sender.ID);
        LabelText[4] := 'Palette ' + IntToStr(Sender.ID);
      end;
    end;
  end

  else if Sender.ID > 0 then // if CornerBtn, not Touchbar
  begin
    PaletteColor := cla;
    if AutoApply then
      Main.ApplyPaletteColor;
  end

end;

procedure TFederPalette.InitCornerMenu(page: Integer);
var
  cb: TCornerBtn;
  l: TList<TAlphaColor>;
  id: Integer;
  i: Integer;
  pid: Integer;
begin
  l := TList<TAlphaColor>.Create;
  InitPalettePage(page, l);
  pid := PaletteBtnID;
  for i := 1 to FederText.CornerBtnCount do
  begin
    id := i;
    cb := FederText.FindCornerBtn(id);
    if not Assigned(cb) then
    begin
      Continue;
    end;

    { Action }
    if (id = pid) then
    begin
      cb.FederAction := faPaletteOff;
      cb.Color := claPaletteBtn;
    end
    else
    begin
      cb.FederAction := faNoop;
      cb.UpdateHint;
    end;

    { Color }
    if (id <> pid) and (i <= l.Count)  then
    begin
      cb.Color := l[i-1];
      cb.Hint := GetColorName(cb.Color);
    end;

    { Caption }
    if (id = pid) then
      cb.Caption := ActionText[cb.FederAction]
    else
    begin
      cb.Text.Text := IntToStr(cb.ID)
    end;

    { Opacity}
    cb.Opacity := 1.0;
  end;
  l.Free;
end;

procedure TFederPalette.InitTouchMenu;
var
  tb: TTouchBtn;
begin
  for tb in TouchMenu.TouchBtnList do
  begin
    tb.Shape.Fill.Color := GetTouchMenuColor(tb.ID);
    tb.Shape.Opacity := 1.0;
    tb.UpdateHint;
  end;
end;

function TFederPalette.GetTouchMenu: TTouchMenu;
begin
  result := FederText.TouchMenu;
end;

function TFederPalette.GetActionText(Index: Integer): string;
begin
  result := Main.ActionHandler.GetShortCaption(Index);
end;

function TFederPalette.GetFederText: TFederTouch;
begin
  result := Main.FederText1;
end;

procedure TFederPalette.SetLabelText(Index: Integer; const Value: string);
begin
  if Assigned(FederText) then
    FederText.LeftLine[Index].Text := Value;
end;

function TFederPalette.GetMenuColor(Index: Integer): TAlphaColor;
begin
  if Assigned(TouchMenu) then
    result := TouchMenu.TouchBtnList[Index].Shape.Fill.Color
  else
    result := claGray;
end;

procedure TFederPalette.SetMenuColor(Index: Integer; const Value: TAlphaColor);
begin
  if Assigned(TouchMenu) then
    TouchMenu.TouchBtnList[Index].Shape.Fill.Color := Value;
end;

function TFederPalette.GetPaletteBtn: TCornerBtn;
begin
  result := Main.FederText.PaletteBtn;
end;

function TFederPalette.GetPaletteBtnID: Integer;
var
  tb: TTouchBtn;
begin
  result := -1;
  tb := PaletteBtn;
  if Assigned(tb) then
  begin
    result := tb.ID;
  end;
end;

end.
