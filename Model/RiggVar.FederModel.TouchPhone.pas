unit RiggVar.FederModel.TouchPhone;

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
  FMX.Types,
  FMX.Objects,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Classes,
  RiggVar.FB.Def,
  RiggVar.FB.Text,
  RiggVar.FederModel.TouchBase;

type
  TFederTouchPhone = class(TFederTouchBase)
  private
    HubText: TText;
    SampleText: TText;
    PlotText: TText;
    OptionLine: TText;
    StatusLine: TText;
    EquationLine: TText;
    FederTextData: TFederTextDataPhone;
    procedure ToolBtnClick(Sender: TObject);
    procedure InitCornerMenu;
  protected
    procedure InitShapes;
    procedure InitText;
    procedure SetTextVisible(const Value: Boolean); override;
    procedure SetActionMap(const Value: Integer); override;
    procedure SetSwatVisible(const Value: Boolean); override;
    procedure SetSwatColor(const Value: TAlphaColor); override;
  public

    ColorSwat: TRectangle;

    constructor Create(AOwner: TComponent); override;
    procedure Init; override;
    procedure InitActions(Layout: Integer); override;
    procedure MoveText; override;
    procedure ToggleTouchFrame; override;
    procedure TogglePrimeText; override;
    procedure UpdateColorScheme; override;
    procedure UpdateText; override;
    procedure UpdateMissing; override;
    procedure UpdateTextQuick; override;
    procedure UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus); override;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederTouchPhone }

constructor TFederTouchPhone.Create(AOwner: TComponent);
begin
  inherited;
  ActionMap := 1;
  OpacityValue := 0.5;
  Main.ActionMapPhone.ActionProc := InitAction;
  Main.ActionMapPhone.ActionColorProc := InitActionWithColor;

  ColorSwat := TRectangle.Create(Self);
end;

procedure TFederTouchPhone.Init;
begin
  Width := MainVar.ClientWidth;
  Height := MainVar.ClientHeight;
  if not InitOK then
  begin
    InitShapes;
    InitText;
    UpdateColorScheme;
    InitOK := True;
    UpdateShape;
  end;
end;

procedure TFederTouchPhone.InitShapes;
begin
  if not InitOK then
  begin
    if WantLED then
    begin
      ConnLED := TCircle.Create(OwnerComponent);
      ConnLED.Width := 14;
      ConnLED.Height := 14;
      ConnLED.Opacity := 0.5;
      ConnLED.Fill.Color := claGray;
      ConnLED.Position.X := 1.5 * MainVar.Raster - 7;
      ConnLED.Position.Y := 1.5 * MainVar.Raster - 7;
      ConnLED.OnClick := ToolBtnClick;
      ParentObject.AddObject(ConnLED);
      ConnLED.Visible := True;
    end;

{$ifdef WantToolBtn}
    ToolBtn := TCircle.Create(OwnerComponent);
    ToolBtn.Position.X := MainVar.Raster;
    ToolBtn.Position.Y := MainVar.Raster;
    ToolBtn.Width := MainVar.Raster;
    ToolBtn.Height := MainVar.Raster;
    ToolBtn.Opacity := 0.1;
    ToolBtn.Fill.Color := MainVar.ColorScheme.claToolBtnFill;
    ToolBtn.OnClick := ToolBtnClick;
    ParentObject.AddObject(ToolBtn);
{$endif}

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

procedure TFederTouchPhone.UpdateColorScheme;
var
  b: TCornerBtn;
  tc1, tc2: TAlphaColor;
  tc: TAlphaColor;
begin
{$ifdef WantToolBtn}
  ToolBtn.Fill.Color := MainVar.ColorScheme.claToolBtnFill;
{$endif}

  for b in CornerBtnList do
    b.Text.Color := MainVar.ColorScheme.claCornerBtnText;

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

  HubText.Color := tc;
  SampleText.Color := tc;
  PlotText.Color := tc;
  OptionLine.Color := tc;
  StatusLine.Color := tc;
  EquationLine.Color := tc;
end;

procedure TFederTouchPhone.SetSwatColor(const Value: TAlphaColor);
begin
  inherited;
  ColorSwat.Fill.Color := Value;
end;

procedure TFederTouchPhone.SetSwatVisible(const Value: Boolean);
begin
  inherited;
  ColorSwat.Visible := Value;
end;

procedure TFederTouchPhone.ToolBtnClick(Sender: TObject);
begin
  FrameVisible := not FrameVisible;

  if FrameVisible then
  begin
    ColorSwat.Visible := True;
    TextVisible := True;
    ToolBtn.Opacity := 0.1;
    Main.FrameVisibilityChanged;
  end
  else
  begin
    ColorSwat.Visible := False;
    TextVisible := False;
    ToolBtn.Opacity := 0.05;
    Main.FrameVisibilityChanged;
  end;

  MoveText;
end;

procedure TFederTouchPhone.InitCornerMenu;
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

  fa := faNoop;
  cl := claYellow;
  PageBtnP := CornerMenu.NewBtn(cpTR, 0, 0, cl, faActionPageP, 9);
  PageBtnM := CornerMenu.NewBtn(cpTL, 0, 0, cl, faActionPageM, 10);
  CornerBtnList.Add(PageBtnP);
  CornerBtnList.Add(PageBtnM);
  cl := claCornflowerBlue;
  CornerBtnList.Add(CornerMenu.NewBtn(cpBL, 0, 0, cl, fa, 7));
  CornerBtnList.Add(CornerMenu.NewBtn(cpBR, 0, 0, cl, fa, 8));

  cp := cpTL;
  cl := claWhite;
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, cl, fa, 1));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, cl, fa, 2));
  MissBtnListB.Add(CornerMenu.NewBtn(cp, 3, 0, cl, fa, 3));
  MissID.Add(3);

  cp := cpBR;
  cl := claWhite;
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, cl, fa, 6));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, cl, fa, 5));
  MissBtnListB.Add(CornerMenu.NewBtn(cp, 3, 0, cl, fa, 4));
  MissID.Add(4);

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

  InitActions(1);

  UpdateMissing;
end;

procedure TFederTouchPhone.InitText;
begin
  if not InitOK then
  begin
    HubText := NewLabelText(nil);
    LAT.Parent := ParentObject;
    LAT.Position.X := 1 * MainVar.Raster + 8;
    LAT.Position.Y := 2 * MainVar.Raster + 8;
    LAT.Font.Size := 18;
    LAT.Color := MainVar.ColorScheme.claLabelText;

    SampleText := NewLabelText(LAT);
    PlotText := NewLabelText(LAT);
    OptionLine := NewLabelText(LAT);
    StatusLine := NewLabelText(LAT);
    EquationLine := NewLabelText(LAT);

    LAT := TText.Create(OwnerComponent);
    LAT.Font.Size := 16;
    LHT := LineHeight(LAT);
    LAT.Free;

    Main.TextUpdateNeeded;
  end;
end;

procedure TFederTouchPhone.UpdateText;
begin
  if InitOK then
  begin
    Main.UpdateFederTextDataPhone(FederTextData);

    PageBtnP.Text.Text := IntToStr(ActionPage);
    PageBtnM.Text.Text := IntToStr(ActionPage);

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

    HubText.Text := FederTextData.Line1;
    SampleText.Text := FederTextData.Line2;
    PlotText.Text := FederTextData.Line3;

    EquationLine.Text := FederTextData.Line4;
    StatusLine.Text := FederTextData.Line5;
    OptionLine.Text := FederTextData.Line6;
  end;
end;

procedure TFederTouchPhone.ToggleTouchFrame;
begin
  FrameVisible := not FrameVisible;
end;

procedure TFederTouchPhone.UpdateMissing;
begin
  if MaxCount > FMaxBtnPhone then
    AddMissingB
  else
    RemoveMissingB;

  if MinCount > FMinBtnPhone then
    AddMissingS
  else
    RemoveMissingS;
end;

procedure TFederTouchPhone.UpdateTextQuick;
begin
  if InitOK then
  begin
    { SB00 text will be taken care of in regular UpdateText }
  end;
end;

procedure TFederTouchPhone.UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus);
begin
  if WantLED then
  begin
    if not Assigned(ConnLED) then
      WantLED := false
    else
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
  end
end;

procedure TFederTouchPhone.TogglePrimeText;
begin
  TextVisible := not TextVisible;
end;

procedure TFederTouchPhone.SetTextVisible(const Value: Boolean);
var
  t: Boolean;
begin
  t := Value;
  FTextVisible := t;
  HubText.Visible := t;
  SampleText.Visible := t;
  PlotText.Visible := t;
  OptionLine.Visible := t;
  StatusLine.Visible := t;
  EquationLine.Visible := t;
end;

procedure TFederTouchPhone.MoveText;
var
  LH: single;
  X, Y: single;
begin
  inherited;
  if Assigned(HubText) then
  begin
    LH := LineHeight(HubText);

    if Main.IsLandscape then
    begin
      X := 2 * MainVar.Raster;
      Y := MainVar.Raster;
    end
    else
    begin
      X := MainVar.Raster;
      Y := 2 * MainVar.Raster;
    end;

    HubText.Position.Y := Y;
    SampleText.Position.Y := Y + 1 * LH;
    PlotText.Position.Y := Y + 2 * LH;

    OptionLine.Position.Y := Y + 4 * LH;
    StatusLine.Position.Y := Y + 5 * LH;
    EquationLine.Position.Y := Y + 6 * LH;

    HubText.Position.X := X;
    SampleText.Position.X := X;
    PlotText.Position.X := X;
    OptionLine.Position.X := X;
    StatusLine.Position.X := X;
    EquationLine.Position.X := X;

    ColorSwat.Position.X := MainVar.ClientWidth - 2 * MainVar.Raster;
    ColorSwat.Position.Y := 1 * MainVar.Raster;
  end;
end;

procedure TFederTouchPhone.InitActions(Layout: Integer);
begin
  Main.ActionMapPhone.InitActions(Layout);
end;

procedure TFederTouchPhone.SetActionMap(const Value: Integer);
begin
  inherited;

  MaxPageIndex := Main.ActionMapPhone.PageCount;
  EscapePageIndex := Main.ActionMapPhone.EscapeIndex;
end;

end.
