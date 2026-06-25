unit RiggVar.FederModel.Touch;

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

{$define WantToolBtn}

uses
  System.Math,
  System.SysUtils,
  System.Classes,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Generics.Collections,
  FMX.Types,
  FMX.Objects,
  FMX.Layouts,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Action,
  RiggVar.FB.ActionMap,
  RiggVar.FB.Classes,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Text,
  RiggVar.FederModel.TextContainer,
  RiggVar.FederModel.TouchBase;

type
  TFederTouch = class(TFederTouchBase)
  private
    FCornerBtnOpacity: single;
    FMenuBtnOpacity: single;
    FTransitBtnOpacity: single;
    FlashText: TText;

    procedure InitCornerMenu;
    procedure ResetCornerMenu;
    procedure ResetTransitBar;
    procedure ResetTouchMenu;

    procedure ToolBtnClick(Sender: TObject);

    procedure InitTouchMenu;
    procedure InitOptionBar;
    procedure InitTransitBar;

    function GetLeftLine(AIndex: Integer): TText;
    function GetMenuBtnMax(Layout: Integer): Integer;
    function GetCornerBtnCount: Integer;
    function GetActionText(AIndex: Integer): string;
    procedure UpdateTransitbarAction(BtnID, Action: Integer);
    function GetBottomLayoutBelowTouchMenu: Boolean;
  protected
    procedure InitShapes;
    procedure InitText;
    procedure InitBottomLayout;
    procedure InitLeftText;
    procedure InitBottomText;

    procedure UpdateMenubarActions(Layout: Integer);
    procedure UpdateTransitbarActions(Layout: Integer);

    function GetEquationVisible: Boolean; override;

//    function GetPaletteBtn: TCornerBtn; override;

    procedure SetAllVisible(const Value: Boolean); override;
    procedure SetMenuVisible(const Value: Boolean); override;
    procedure SetEquationVisible(const Value: Boolean); override;
    procedure SetTitleVisible(const Value: Boolean); override;
    procedure SetTextVisible(const Value: Boolean); override;
    procedure SetActionMap(const Value: Integer); override;
    procedure SetSwatVisible(const Value: Boolean); override;
    procedure SetSwatColor(const Value: TAlphaColor); override;
    procedure SetFlashCaption(const Value: string); override;
  public
    OptionBar: TTouchBar;
    TransitBar: TTouchBar;
    TouchMenu: TTouchMenu;
    EquationText: TTextContainer;
    BottomLayout: TLayout;

    MsgText: TText;

    ParamText: TText;
    ValueText: TText;
    TempoText: TText;

    MilliesLine: TText;
    StatusLine: TText;
    OptionLine: TText;
    EquationLine: TText;
    RecorderLine: TText;
    ConnectionLine: TText;

    ColorSwat: TRectangle;

    FederTextData: TFederTextData;
    FederTextDataQuick: TFederTextDataQuick;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

//    function FindPaletteBtn: TCornerBtn;

    procedure Reset;

    procedure Init; override;
    procedure InitActions(Layout: Integer); override;
    procedure InitActionFromInfo(ActionInfo: TActionInfo); override;
    procedure MoveText; override;
    procedure UpdateColorScheme; override;
    procedure UpdateText; override;
    procedure ClearFlash; override;
    procedure InitMenuBarActions(ALayout: Integer); override;
    procedure InitTransitBarActions(ALayout: Integer); override;
    procedure CheckBtnOrder; override;
//    procedure UpdateTextQuick; override;
    procedure UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus); override;
    procedure CheckState; override;
    procedure CheckCircleState; override;

    procedure ToggleAllText; override;
    procedure ToggleTouchFrame; override;
    procedure ToggleTouchMenu; override;
    procedure ToggleEquationText; override;
    procedure TogglePrimeText; override;
    procedure ToggleSecondText; override;

    property LeftLine[AIndex: Integer]: TText read GetLeftLine;
    property ActionText[AIndex: Integer]: string read GetActionText;
    property CornerBtnCount: Integer read GetCornerBtnCount;
    property WantBottomLayoutBelowTouchMenu: Boolean read GetBottomLayoutBelowTouchMenu;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederTouch }

constructor TFederTouch.Create(AOwner: TComponent);
begin
  inherited;
  ActionMap := 1;
  OpacityValue := 0.5;

  Main.ActionMapTransit.ActionProc := UpdateTransitBarAction;

  Main.ActionMapTablet.ActionProc := InitAction;
  Main.ActionMapTablet.ActionColorProc := InitActionWithColor;

  TouchMenu := TTouchMenu.Create;
  TransitBar := TTouchBar.Create;
  OptionBar := TTouchBar.Create;
  EquationText := TTextContainer.Create;

  ColorSwat := TRectangle.Create(Self);
end;

destructor TFederTouch.Destroy;
begin
  TouchMenu.Free;
  TransitBar.Free;
  OptionBar.Free;
  EquationText.Free;
  inherited;
end;

function TFederTouch.GetEquationVisible: Boolean;
begin
  if Assigned(EquationText) then
    result := EquationText.Visible
  else
    result := False;
end;

function TFederTouch.GetLeftLine(AIndex: Integer): TText;
begin
  case AIndex of
    1: result := MilliesLine;
    2: result := StatusLine;
    3: result := OptionLine;
    4: result := EquationLine;
    5: result := RecorderLine;
    6: result := ConnectionLine;
    else
      result := RecorderLine;
  end;
end;

procedure TFederTouch.Init;
begin
  if not InitOK then
  begin
    InitShapes;
    InitText;
    AllVisible := True;
    UpdateColorScheme;
    InitOK := True;
    UpdateShape;
  end;
end;

procedure TFederTouch.InitShapes;
begin
  if not InitOK then
  begin
{$ifdef WantToolBtn}
    ToolBtn := TCircle.Create(OwnerComponent);
    { Position set in TFederTouchBase.UpdateShape }
    ToolBtn.Width := MainVar.Raster;
    ToolBtn.Height := MainVar.Raster;
    ToolBtn.Opacity := 0.1;
    ToolBtn.Fill.Color := MainVar.ColorScheme.claToolBtnFill;
    ToolBtn.OnClick := ToolBtnClick;
    ParentObject.AddObject(ToolBtn);
{$endif}

    if WantLED then
    begin
      ConnLED := TCircle.Create(OwnerComponent);
      ConnLED.Width := 14;
      ConnLED.Height := 14;
      ConnLED.Opacity := 0.5;
      ConnLED.Fill.Color := claGray;
      ConnLED.OnClick := ToolBtnClick;
      ParentObject.AddObject(ConnLED);
      ConnLED.Visible := True;
    end;

    InitCornerMenu;

    SL00.Shape.OnMouseDown := OnMouseDown;
    SR00.Shape.OnMouseDown := OnMouseDown;
    ST00.Shape.OnMouseDown := OnMouseDown;
    SB00.Shape.OnMouseDown := OnMouseDown;

    SL00.Shape.OnMouseMove := OnMouseMove;
    SR00.Shape.OnMouseMove := OnMouseMove;
    ST00.Shape.OnMouseMove := OnMouseMove;
    SB00.Shape.OnMouseMove := OnMouseMove;

    SL00.Shape.OnMouseUp := OnMouseUp;
    SR00.Shape.OnMouseUp := OnMouseUp;
    ST00.Shape.OnMouseUp := OnMouseUp;
    SB00.Shape.OnMouseUp := OnMouseUp;

    SL00.Shape.OnMouseLeave := OnMouseLeave;
    SR00.Shape.OnMouseLeave := OnMouseLeave;
    ST00.Shape.OnMouseLeave := OnMouseLeave;
    SB00.Shape.OnMouseLeave := OnMouseLeave;

    InitOptionBar;
    InitTouchMenu;
    InitTransitBar;

    EquationText.Init;

    ColorSwat.CornerType := TCornerType.Round;
    ColorSwat.XRadius := 5;
    ColorSwat.YRadius := 5;
    Self.AddObject(ColorSwat);
    ColorSwat.Width := MainVar.Raster;
    ColorSwat.Height := MainVar.Raster;
    ColorSwat.Stroke.Color := claNull;
    ColorSwat.Stroke.Thickness := 4;
  end;
end;

procedure TFederTouch.UpdateColorScheme;
var
  b: TCornerBtn;
  tc1, tc2: TAlphaColor;
  tc: TAlphaColor;
begin
  ToolBtn.Fill.Color := MainVar.ColorScheme.claToolBtnFill;

  OptionBar.UpdateColorScheme;
  TransitBar.UpdateColorScheme;
  TouchMenu.UpdateColorScheme;
  for b in CornerBtnList do
    b.Text.Color := MainVar.ColorScheme.claCornerBtnText;

  EquationText.Shape.Fill.Color := MainVar.ColorScheme.claEquationFill;
  EquationText.TextComponent.Color := MainVar.ColorScheme.claEquationText;

  tc1 := MainVar.ColorScheme.claCornerScrollbar;
  tc2 := MainVar.ColorScheme.claCornerBtnText;

  ST00.Shape.Fill.Color := tc1;
  ST00.Text.Color := tc2;
  SB00.Shape.Fill.Color := tc1;
  SB00.Text.Color := tc2;
  SL00.Shape.Fill.Color := tc1;
  SL00.Text.Color := tc2;
  SR00.Shape.Fill.Color := tc1;
  SR00.Text.Color := tc2;

  tc := MainVar.ColorScheme.claLabelText;

  ParamText.Color := tc;
  ValueText.Color := tc;
  TempoText.Color := tc;

  tc := MainVar.ColorScheme.claOptionText;

  MsgText.Color := tc;
  FlashText.Color := tc;

  MilliesLine.Color := tc;
  StatusLine.Color := tc;
  OptionLine.Color := tc;
  EquationLine.Color := tc;
  RecorderLine.Color := tc;
  ConnectionLine.Color := tc;
end;

procedure TFederTouch.SetMenuVisible(const Value: Boolean);
var
  f: TFmxObject;
  tb: TTouchBtn;
begin
    FMenuVisible := Value;
  { Parent of TouchBtn must now be Self (FederTouch) }
  for f in Children do
      if f is TTouchBtn then
      begin
        tb := TTouchBtn(f);
        if tb.MenuBtn then
          tb.Visible := Value;
      end;
end;

procedure TFederTouch.SetSwatColor(const Value: TAlphaColor);
begin
  inherited;
  ColorSwat.Fill.Color := Value;
end;

procedure TFederTouch.SetSwatVisible(const Value: Boolean);
begin
  inherited;
  ColorSwat.Visible := Value;
end;

procedure TFederTouch.ToolBtnClick(Sender: TObject);
begin
  AllVisible := not AllVisible;
  Main.ShowColorSwat := SwatVisible;
  Main.ShowColorPanel := Main.ShowColorPanel;
  Main.FrameVisibilityChanged;
end;

procedure TFederTouch.SetAllVisible(const Value: Boolean);
begin
  inherited;
  OptionBar.Visible := Value;
  TransitBar.Visible := Value;
  MoveText;
end;

procedure TFederTouch.SetEquationVisible(const Value: Boolean);
begin
  FEquationVisible := Value;
  EquationText.Visible := Value;
end;

procedure TFederTouch.InitOptionBar;
begin
  TTouchBtn.Circle := True;
  TTouchBtn.OffsetX := 0;
  TTouchBtn.OffsetY := 0;
  TTouchBtn.BtnWidth := MainVar.Raster;
  TTouchBtn.BtnHeight := MainVar.Raster;

  OptionBar.InitContainer(True, 5);
  OptionBar.AddBtn(faToggleTouchMenu);
  OptionBar.AddBtn(faTogglePrimeText);
  OptionBar.AddBtn(faToggleEquationText);
  OptionBar.AddBtn(faLabelBatchM);
  OptionBar.AddBtn(faLabelBatchP);
  OptionBar.Container.Fill.Color := claWhite;
end;

procedure TFederTouch.InitTransitBar;
begin
  TTouchBtn.Circle := True;
  TTouchBtn.OffsetX := 0;
  TTouchBtn.OffsetY := 0;
  TTouchBtn.BtnWidth := MainVar.Raster;
  TTouchBtn.BtnHeight := MainVar.Raster;

  TransitBar.InitContainer(False, 6);
  TransitBar.AddBtn(faNoop);
  TransitBar.AddBtn(faNoop);
  TransitBar.AddBtn(faNoop);
  TransitBar.AddBtn(faNoop);
  TransitBar.AddBtn(faNoop);
  TransitBar.AddBtn(faNoop);

  TransitBar.Container.Fill.Color := claLightGray;
  TransitBar.Container.Visible := True;

  FTransitBtnOpacity := TransitBar.TouchBtnList[0].Shape.Opacity;
end;

procedure TFederTouch.InitTransitBarActions(ALayout: Integer);
begin
  if Assigned(TransitBar) then
    UpdateTransitbarActions(ALayout);
end;

procedure TFederTouch.InitMenuBarActions(ALayout: Integer);
begin
  if Assigned(TouchMenu) then
    UpdateMenubarActions(ALayout);
end;

procedure TFederTouch.InitTouchMenu;
begin
  TTouchBtn.Circle := False;
  TTouchBtn.OffsetX := MainVar.Raster;
  TTouchBtn.OffsetY := 3 * MainVar.Raster;
  TTouchBtn.BtnWidth := MainVar.Raster;
  TTouchBtn.BtnHeight := MainVar.Raster;

  TouchMenu.ColumnCount := 2;

  TouchMenu.AddBtn(faLayout0);
  TouchMenu.AddBtn(faLayout1);
  TouchMenu.AddBtn(faLayout2);
  TouchMenu.AddBtn(faLayout3);
  TouchMenu.AddBtn(faLayout4);
  TouchMenu.AddBtn(faLayout5);
  TouchMenu.AddBtn(faLayout6);
  TouchMenu.AddBtn(faLayout7);
  TouchMenu.AddBtn(faLayout8);
  TouchMenu.AddBtn(faLayout9);

  FMenuBtnOpacity := TouchMenu.TouchBtnList[0].Shape.Opacity;
end;

procedure TFederTouch.InitCornerMenu;
var
  cp: TCornerPos;
  cl: TAlphaColor;
  fa: TFederAction;
begin
  MissID.Clear;

  TCornerBtn.OffsetX := 0;
  TCornerBtn.OffsetY := 0;
  TCornerBtn.BtnWidth := MainVar.Raster;
  TCornerBtn.BtnHeight := MainVar.Raster;
  TCornerBtn.Circle := False;

  cl := claGray;
  fa := faNoop;

  cp := cpTL;
  PageBtnM := CornerMenu.NewBtn(cp, 0, 0, cl, fa, 1);
  CornerBtnList.Add(PageBtnM);
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 1, cl, fa, 2));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, cl, fa, 3));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, cl, fa, 4));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 3, 0, cl, fa, 5));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 4, 0, cl, fa, 6));

  cp := cpTR;
  PageBtnP := CornerMenu.NewBtn(cp, 0, 0, cl, fa, 7);
  CornerBtnList.Add(PageBtnP);
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 1, cl, fa, 8));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 2, cl, fa, 9));
  MissBtnListS.Add(CornerMenu.NewBtn(cp, 0, 3, cl, fa, 10));
  MissID.Add(10);

  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, cl, fa, 11));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, cl, fa, 12));
  MissBtnListB.Add(CornerMenu.NewBtn(cp, 3, 0, cl, fa, 13));
  MissBtnListB.Add(CornerMenu.NewBtn(cp, 4, 0, cl, fa, 14));
  MissID.Add(13);
  MissID.Add(14);

  cp := cpBL;
  HomeBtn := CornerMenu.NewBtn(cp, 0, 0, cl, fa, 15);
  CornerBtnList.Add(HomeBtn);
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, cl, fa, 16));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, cl, fa, 17));
  MissBtnListB.Add(CornerMenu.NewBtn(cp, 3, 0, cl, fa, 18));
  MissBtnListB.Add(CornerMenu.NewBtn(cp, 4, 0, cl, fa, 19));
  MissID.Add(18);
  MissID.Add(19);

  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 1, cl, fa, 20));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 2, cl, fa, 21));
  MissBtnListS.Add(CornerMenu.NewBtn(cp, 0, 3, cl, fa, 22));
  MissID.Add(22);

  cp := cpBR;
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 0, cl, fa, 23));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 1, cl, fa, 24));

  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, cl, fa, 25));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, cl, fa, 26));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 3, 0, cl, fa, 27));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 4, 0, cl, fa, 28));

  cl := MainVar.ColorScheme.claCornerScrollbar;
  ST00 := CornerMenu.NewBtn(cpT, 0, 0, cl, faTouchBarTop);
  SR00 := CornerMenu.NewBtn(cpR, 0, 0, cl, faTouchBarRight);
  SB00 := CornerMenu.NewBtn(cpB, 0, 0, cl, faTouchBarBottom);
  SL00 := CornerMenu.NewBtn(cpL, 0, 0, cl, faTouchBarLeft);

  ST00.Text.Align := TAlignLayout.Client;
  ST00.Text.HitTest := False;
  ST00.Text.Font.Size := MainConst.DefaultBtnFontSize;

  SB00.Text.Align := TAlignLayout.Client;
  SB00.Text.HitTest := False;
  SB00.Text.Font.Size := MainConst.DefaultBtnFontSize;

  SL00.Text.Align := TAlignLayout.Client;
  SL00.Text.HitTest := False;
  SL00.Text.Font.Size := MainConst.DefaultBtnFontSize;

  SR00.Text.Align := TAlignLayout.Client;
  SR00.Text.HitTest := False;
  SR00.Text.Font.Size := MainConst.DefaultBtnFontSize;

  ST00.Text.Text := '';
  SB00.Text.Text := '';
  SL00.Text.Text := '';
  SR00.Text.Text := '';

  FCornerBtnOpacity := PageBtnM.Opacity;

  UpdateMissing;
  ResetCornerMenu;
end;

procedure TFederTouch.MoveText;
var
  LimitY: Integer; // multiple of Raster
begin
  inherited;
  LimitY := Round(SB00.Position.Y) div MainVar.Raster - 5;
  TransitBar.InitPosition;
  TransitBar.Visible := AllVisible and (LimitY > 0);

  if FEquationVisible then
    EquationText.UpdateShape;

  if MenuVisible then
    TouchMenu.UpdateShape(EquationText.Docked, LimitY);

  if LimitY < 5 then
    BottomLayout.Position.Y := (4 + LimitY) * MainVar.Raster + 8
  else
    BottomLayout.Position.Y := 8 * MainVar.Raster + 8;

  ColorSwat.Position.X := MainVar.ClientWidth - 2 * MainVar.Raster;
  ColorSwat.Position.Y := 1 * MainVar.Raster;
end;

procedure TFederTouch.InitText;
begin
  if not InitOK then
  begin
    LAT := TText.Create(OwnerComponent);
    LAT.Font.Size := 16;
    LHT := LineHeight(LAT);
    LAT.Free;
    LAT := nil;

    InitLeftText;
    InitBottomLayout;
    InitBottomText;

    TextVisible := True;
    TitleVisible := MainVar.ClientWidth >= 768;
    Main.TextUpdateNeeded;
  end;
end;

procedure TFederTouch.SetFlashCaption(const Value: string);
begin
  if Assigned(FlashText) then
    FlashText.Text := Value;
end;

procedure TFederTouch.SetTextVisible(const Value: Boolean);
begin
  FTextVisible := Value;

  ParamText.Visible := Value;
  ValueText.Visible := Value;
  TempoText.Visible := Value;
  FlashText.Visible := Value;

  MilliesLine.Visible := Value;
  StatusLine.Visible := Value;
  OptionLine.Visible := Value;
  EquationLine.Visible := Value;
  RecorderLine.Visible := Value;
  ConnectionLine.Visible := Value and WantLED;

  if Value then
  begin
    Main.TextIndex := 0;
  end;
end;

procedure TFederTouch.SetTitleVisible(const Value: Boolean);
begin
  FTitleVisible := Value;
  MsgText.Visible := Value;
end;

procedure TFederTouch.ClearFlash;
begin
  FlashCaption := '';
end;

procedure TFederTouch.UpdateText;
begin
  if InitOK then
  begin
    Main.UpdateFederTextData(FederTextData);

    if FederTextData.Spruch <> '' then
      MsgText.Text := Spruch
    else
      MsgText.Text := FederTextData.MsgText;

    UpdatePageBtnText;

    if FederTextData.HelpFlash then
    begin
      SL00.Text.Text := VerticalTouchbarHelpText;
      SR00.Text.Text := VerticalTouchbarHelpText;
      ST00.Text.Text := HorizontalTouchbarHelpText;
      SB00.Text.Text := HorizontalTouchbarHelpText;
    end
    else
    begin
      SL00.Text.Text := FederTextData.SL00;
      SR00.Text.Text := FederTextData.SR00;
      ST00.Text.Text := FederTextData.ST00;
      SB00.Text.Text := FederTextData.SB00;
    end;

    ParamText.Text := FederTextData.ParamText;
    ValueText.Text := FederTextData.ValueText;
    TempoText.Text := FederTextData.TempoText;

    MilliesLine.Text := FederTextData.MilliesLine;
    StatusLine.Text := FederTextData.StatusLine;
    OptionLine.Text := FederTextData.OptionLine;
    //ConnectionLine.Text := FederTextData.ConnectionLine;
    RecorderLine.Text := FederTextData.RecorderLine;
    EquationLine.Text := FederTextData.EquationLine;

    EquationText.Text := FederTextData.EquationText;
  end;
end;

//procedure TFederTouch.UpdateTextQuick;
//begin
//  if InitOK then
//  begin
//    Main.UpdateFederTextDataQuick(FederTextDataQuick);
//    TempoText.Text := FederTextDataQuick.TempoText;
//    RecorderLine.Text := FederTextDataQuick.RecorderLine;
//  end;
//end;

procedure TFederTouch.InitBottomLayout;
begin
  BottomLayout := TLayout.Create(OwnerComponent);
  BottomLayout.Align := TAlignLayout.None;
  BottomLayout.Position.X := 1 * MainVar.Raster + 8;
  BottomLayout.Position.Y := 8 * MainVar.Raster + 8;
  BottomLayout.Width := 4 * MainVar.Raster;
  BottomLayout.Height := 6 * LHT;
  ParentObject.AddObject(BottomLayout);
end;

procedure TFederTouch.InitLeftText;
begin
  MsgText := NewLabelText(nil);
  LAT.Parent := ParentObject;
  LAT.Position.X := 6 * MainVar.Raster + 8;
  LAT.Position.Y := 5 * MainVar.Raster;
  LAT.Font.Size := 48;
  LAT.Opacity := 0.5;
  LAT.Color := MainVar.ColorScheme.claLabelText;
  LAT.Text := '';
  LAT.AutoSize := True;

  ParamText := NewLabelText(LAT);
  LAT.Font.Size := 48;
  LAT.Position.X := MainVar.Raster + 8;
  LAT.Position.Y := 2 * MainVar.Raster;
  LAT.Opacity := 0.7;
  LAT.Font.Size := 48;

  ValueText := NewLabelText(LAT);
  LAT.Font.Size := 18;
  LAT.Position.X := ValueStartX * MainVar.Raster;
  LAT.Position.Y := 2 * MainVar.Raster + 8;

  TempoText := NewLabelText(LAT);

  FlashText := NewLabelText(LAT);
  LAT.Font.Size := 18;
  LAT.Position.X := 7 * MainVar.Raster;
  LAT.Position.Y := 8 * MainVar.Raster + 8;
end;

procedure TFederTouch.InitBottomText;
begin
  MilliesLine := NewLabelText(LAT);
  LAT.Parent := BottomLayout;
  LAT.Font.Size := 16;
  LAT.Position.X := 0;
  LAT.Position.Y := 0;
  LAT.Color := claGray;

  StatusLine := NewLabelText(LAT);
  LAT.Color := claTeal;

  OptionLine := NewLabelText(LAT);
  LAT.Color := claCornflowerblue;

  EquationLine := NewLabelText(LAT);
  LAT.Color := claCrimson;

  RecorderLine := NewLabelText(LAT);
  LAT.Color := claGray;

  ConnectionLine := NewLabelText(LAT);
  LAT.Color := claGray;
end;

procedure TFederTouch.ToggleTouchFrame;
begin
  FrameVisible := not FrameVisible;
end;

procedure TFederTouch.ToggleTouchMenu;
begin
  MenuVisible := not MenuVisible;
  MoveText;
end;

procedure TFederTouch.ToggleAllText;
begin
  AllVisible := not AllVisible;
end;

procedure TFederTouch.ToggleEquationText;
begin
  EquationVisible := not EquationVisible;
  MoveText;
end;

procedure TFederTouch.TogglePrimeText;
begin
  TextVisible := not TextVisible;
end;

procedure TFederTouch.ToggleSecondText;
begin
  TitleVisible := not MsgText.Visible;
end;

procedure TFederTouch.UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus);
var
  fs: string;
  s: string;
begin
  if WantLED and Assigned(ConnLED) then
  begin
    case Status of
      csRed:
      begin
        ConnLED.Fill.Color := claRed;
      end;
      csYellow:
      begin
        ConnLED.Fill.Color := claYellow;
      end;
      csGreen:
      begin
        ConnLED.Fill.Color := claLime;
      end;
    end;
    fs := '%s | %s | %s | %s';
    s := Format(fs, [Host, Port, Counter, Msg]);
    ConnectionLine.Text := s;
  end
  else
  begin
    ConnectionLine.Text := 'Connection Line';
  end;
end;

procedure TFederTouch.UpdateMenuBarActions(Layout: Integer);
var
  i: Integer;
  m: Integer;
begin
  case Layout of
    10, 20, 30, 40, 50, 60, 70, 80, 90:
    begin
      m := GetMenuBtnMax(Layout);
      for i := 0 to 9 do
        if i > m then
          TouchMenu.UpdateAction(i, faNoop)
        else
          TouchMenu.UpdateAction(i, TFederAction(faLayout0 + Layout + i));
    end;

    else
    begin
      TouchMenu.UpdateAction(0, faLayout0);
      TouchMenu.UpdateAction(1, faLayout1);
      TouchMenu.UpdateAction(2, faLayout2);
      TouchMenu.UpdateAction(3, faLayout3);
      TouchMenu.UpdateAction(4, faLayout4);
      TouchMenu.UpdateAction(5, faLayout5);
      TouchMenu.UpdateAction(6, faLayout6);
      TouchMenu.UpdateAction(7, faLayout7);
      TouchMenu.UpdateAction(8, faLayout8);
      TouchMenu.UpdateAction(9, faLayout9);
    end;
  end;
end;

procedure TFederTouch.InitActionFromInfo(ActionInfo: TActionInfo);
begin
  Main.ActionMapTablet.InitActionFromInfo(ActionInfo);
end;

procedure TFederTouch.InitActions(Layout: Integer);
begin
   Main.ActionMapTablet.InitActions(Layout);
end;

procedure TFederTouch.UpdateTransitbarActions(Layout: Integer);
begin
  Main.ActionMapTransit.InitActions(Layout);
end;

procedure TFederTouch.UpdateTransitbarAction(BtnID: Integer; Action: Integer);
begin
  TransitBar.UpdateAction(BtnID, Action);
end;

function TFederTouch.GetMenuBtnMax(Layout: Integer): Integer;
begin
  { ToDo: update MenuBtn Count }
  case Layout of
    00: result := 9;
    10: result := 9;
    20: result := 9;
    30: result := 9;
    40: result := 9;
    50: result := 9;
//    60: result := 3;
//    70: result := 4;
//    80: result := 7;
//    90: result := 7;
    else
      result := -1;
  end;
end;

function TFederTouch.GetActionText(AIndex: Integer): string;
begin
  result := Main.ActionHandler.GetShortCaption(AIndex);
end;

function TFederTouch.GetBottomLayoutBelowTouchMenu: Boolean;
begin
  result := Main.IsPortrait;
end;

function TFederTouch.GetCornerBtnCount: Integer;
begin
  result := CornerBtnList.Count;
end;

procedure TFederTouch.ResetCornerMenu;
var
  cb: TCornerBtn;
begin
  ActionPage := ActionPage; // call virtual setter --> InitActions

  for cb in CornerBtnList do
  begin
    cb.Opacity := FCornerBtnOpacity;
  end;
end;

procedure TFederTouch.ResetTouchMenu;
var
  tb: TTouchBtn;
begin
  for tb in TouchMenu.TouchBtnList do
  begin
    tb.Shape.Fill.Color := MainVar.ColorScheme.claTouchBtnFill;
    tb.Shape.Opacity := FMenuBtnOpacity;
  end;
end;

procedure TFederTouch.ResetTransitBar;
var
  tb: TTouchBtn;
begin
  for tb in TransitBar.TouchBtnList do
  begin
    tb.Shape.Fill.Color := claGray;
    tb.Shape.Opacity := FTransitBtnOpacity;
    tb.Caption := ActionText[tb.FederAction];
  end;
end;

procedure TFederTouch.Reset;
begin
  ResetTouchMenu;
  ResetTransitBar;
  ResetCornerMenu;
end;

procedure TFederTouch.CheckBtnOrder;
begin
  if Main.PaletteMode then
  begin
    ActionPage := ActionPage;
  end;
end;

//function TFederTouch.GetPaletteBtn: TCornerBtn;
//begin
//  result := FindPaletteBtn;
//end;

procedure TFederTouch.SetActionMap(const Value: Integer);
begin
  inherited;

  MaxPageIndex := Main.ActionMapTablet.PageCount;
  EscapePageIndex := Main.ActionMapTablet.EscapeIndex;

  if InitOK then
    Reset;
end;

//function TFederTouch.FindPaletteBtn: TCornerBtn;
//var
//  cb: TCornerBtn;
//begin
//  result := nil;
//  for cb in CornerBtnList do
//    if (cb.FederAction = faPaletteOn) or (cb.FederAction = faPaletteOff) then
//    begin
//      result := cb;
//      break;
//    end;
//end;

procedure TFederTouch.CheckCircleState;
var
  b: TTouchBtn;
begin
  for b in TransitBar.TouchBtnList do
    b.CheckCircleState;
  for b in OptionBar.TouchBtnList do
    b.CheckCircleState;
end;

procedure TFederTouch.CheckState;
var
  b: TTouchBtn;
begin
  inherited;
  for b in TouchMenu.TouchBtnList do
    b.CheckState;
end;

end.
