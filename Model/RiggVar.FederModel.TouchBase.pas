unit RiggVar.FederModel.TouchBase;

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
  System.Math,
  System.UITypes,
  System.UIConsts,
  System.Generics.Collections,
  FMX.Types,
  FMX.Objects,
  FMX.Controls,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Def;

type
  TTouchBtn = class(TControl)
  private
    FID: Integer;
    FCaption: string;
    FColor: TAlphaColor;
    FText: TText;
    FShape: TShape;
    FFederAction: TFederAction;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetCaption(const Value: string);
    procedure SetFederAction(const Value: TFederAction);
    function GetColor: TAlphaColor;
  protected
    procedure SetHint(const Value: string); override;
    procedure HandleClick(Sender: TObject);
  public
    X0, Y0: Integer;
    X, Y: Integer;
    class var
      OffsetX: Integer;
      OffsetY: Integer;
      BtnWidth: Integer;
      BtnHeight: Integer;
      Circle: Boolean;
      WantHint: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitPosition; virtual;

    procedure Init;
    procedure CheckState;
    procedure CheckCircleState;
    procedure UpdateHint;

    property ID: Integer read FID write FID;
    property Caption: string read FCaption write SetCaption;
    property Hint: string write SetHint;
    property FederAction: TFederAction read FFederAction write SetFederAction;
    property Shape: TShape read FShape;
    property Text: TText read FText;
    property Color: TAlphaColor read GetColor write SetColor;
  end;

  TCornerPos = (
    cpTL, // TopLeft corner
    cpTR,
    cpBL,
    cpBR,
    cpT, // top side
    cpR,
    cpB,
    cpL
  );

  TCornerBtn = class(TTouchBtn)
  private
    procedure UpdateUV;
  public
    U, V: Integer;
    CornerPos: TCornerPos;
    procedure InitPosition; override;
  end;

  TCornerMenu = class
  public
    function NewBtn(
      CornerPos: TCornerPos;
      X, Y: Integer;
      BtnColor: TAlphaColor;
      fa: TFederAction;
      BtnID: Integer = 0
      ): TCornerBtn;

    class var
    TStart: Integer;
    RStart: Integer;
    BStart: Integer;
    LStart: Integer;
    TCount: Integer;
    RCount: Integer;
    BCount: Integer;
    LCount: Integer;
  end;

  TFederTouchBase = class
  private
    OldX: single;
    OldY: single;
    Down: Boolean;
    FOwnsMouse: Boolean;

    procedure OnMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: single);
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: single);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
    procedure OnMouseLeave(Sender: TObject);
    procedure BorderTrack(Sender: TObject; X, Y: single);

    procedure InitCornerMenu;

    procedure InitShapes;
    procedure CheckBtnOrder;
    procedure SetOwnsMouse(const Value: Boolean);
  public
    InitOK: Boolean;
    CornerBtnList: TObjectList<TCornerBtn>;
    CornerMenu: TCornerMenu;

    SL00: TCornerBtn;
    ST00: TCornerBtn;
    SB00: TCornerBtn;
    SR00: TCornerBtn;

    class var
      OpacityValue: single;
      OwnerComponent: TComponent;
      ParentObject: TFmxObject;
      ClickedID: Integer;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure Init;
    procedure CheckState;
    procedure CheckCircleState; virtual;
    procedure UpdateShape;
    procedure UpdateColorScheme;
    property OwnsMouse: Boolean read FOwnsMouse write SetOwnsMouse;
  end;

const
  BtnBorderColor: TAlphaColor = claNull;
  BtnBorderWidth: Integer = 4;
  BtnBorderRadius: Integer = 8;
  DockStartX: Integer = 2;
  ValueStartX: single = 2.8;
  RightStartY: single = 5;
  RightMarginX: single = 120;

implementation

uses
  RiggVar.App.Main;

{ TTouchBtn }

constructor TTouchBtn.Create(AOwner: TComponent);
begin
  inherited;
  Width := BtnWidth;
  Height := BtnHeight;
  FColor := claWhite;
end;

destructor TTouchBtn.Destroy;
begin
  inherited;
end;

function TTouchBtn.GetColor: TAlphaColor;
begin
  result := FShape.Fill.Color;
end;

procedure TTouchBtn.HandleClick(Sender: TObject);
begin
  if Enabled then
  begin
    TFederTouchBase.ClickedID := ID;
    Main.ActionHandler.Execute(FederAction);
  end;
end;

procedure TTouchBtn.CheckState;
var
  r: TRectangle;
  e: Boolean;
  c: Boolean;
begin
  if FShape is TRectangle then
  begin
    r := FShape as TRectangle;

    c := Main.ActionHandler.GetChecked(FederAction);
    e := Main.ActionHandler.GetEnabled(FederAction);
    if not c then
      r.Corners := [TCorner.TopLeft, TCorner.TopRight, TCorner.BottomLeft, TCorner.BottomRight]
    else
      r.Corners := [
        TCorner.TopLeft,
  //      TCorner.TopRight,
        TCorner.BottomLeft,
        TCorner.BottomRight
        ];

     if not e then
      r.Fill.Color := claSilver
     else
      r.Fill.Color := FColor;

     Enabled := e;
  end;
end;

procedure TTouchBtn.CheckCircleState;
var
  cr: TCircle;
  c: Boolean;
  e: Boolean;
begin
  if FShape is TCircle then
  begin
    c := Main.ActionHandler.GetChecked(FederAction);
    e := Main.ActionHandler.GetEnabled(FederAction);
    cr := FShape as TCircle;
    if e then
    begin
    if c then
      cr.Fill.Color := claAqua
    else
       cr.Fill.Color := MainVar.ColorScheme.claTouchBtnFill;
    end
    else
    begin
     if c then
       cr.Fill.Color := claBlue
     else
       cr.Fill.Color := claGray;
    end;
  end;
end;

procedure TTouchBtn.SetFederAction(const Value: TFederAction);
begin
  FFederAction := Value;
end;

procedure TTouchBtn.SetCaption(const Value: string);
begin
  FCaption := Value;
  if Assigned(FText) then
    FText.Text := Value;
end;

procedure TTouchBtn.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
  if Assigned(FShape) then
  begin
    FShape.Fill.Color := Value;
  end;
end;

procedure TTouchBtn.SetHint(const Value: string);
begin
  if Assigned(FText) then
  begin
    FText.Hint := Value;
  end;
end;

procedure TTouchBtn.UpdateHint;
begin
  if WantHint then
  begin
    Hint := Main.ActionHandler.GetCaption(FederAction);
  end;
end;

procedure TTouchBtn.Init;
var
  r: TRectangle;
begin
  InitPosition;

  if Circle then
    FShape := TCircle.Create(Self)
  else
  begin
    r := TRectangle.Create(Self);
    r.CornerType := TCornerType.Round;
    r.Corners := [TCorner.TopLeft, TCorner.TopRight, TCorner.BottomLeft, TCorner.BottomRight];
    r.XRadius := BtnBorderRadius;
    r.YRadius := BtnBorderRadius;
    FShape := r;
  end;

  FShape.Fill.Color := MainVar.ColorScheme.claTouchBtnFill;
  FShape.Stroke.Color := BtnBorderColor;
  FShape.Stroke.Thickness := BtnBorderWidth;
  FShape.Opacity := 1.0;
  FShape.Align := TAlignLayout.Client;

  FText := TText.Create(Self);
  FText.Align := TAlignLayout.Center;
  FText.Text := FCaption;
  FText.Opacity := 1.0;
  FText.Font.Size := MainConst.DefaultBtnFontSize;

  FText.OnClick := HandleClick;
  FShape.OnClick := HandleClick;

  FShape.AddObject(FText);
  Self.AddObject(FShape);

  if WantHint then
  begin
    FText.ShowHint := True;
    UpdateHint;
  end;
end;

procedure TTouchBtn.InitPosition;
begin
  Position.X := X * BtnWidth + OffsetX;
  Position.Y := Y * BtnHeight + OffsetY;
end;

{ TCornerMenu }

function TCornerMenu.NewBtn(
  CornerPos: TCornerPos;
  X, Y: Integer;
  BtnColor: TAlphaColor;
  fa: TFederAction;
  BtnID: Integer = 0
  ): TCornerBtn;
var
  b: TCornerBtn;
begin
  b := TCornerBtn.Create(TFederTouchBase.OwnerComponent);
  TFederTouchBase.ParentObject.AddObject(b);
  b.CornerPos := CornerPos;
  b.FID := BtnID;
  b.X := X;
  b.Y := Y;
  b.FederAction := fa;
  b.Opacity := TFederTouchBase.OpacityValue;
  b.Init;
  b.Color := BtnColor;

  b.Caption := Main.ActionHandler.GetShortCaption(fa);
  b.FText.Color := MainVar.ColorScheme.claCornerBtnText;
  b.FText.Font.Size := MainConst.DefaultBtnFontSize;
  b.FText.Opacity := 1.0;
  b.FShape.Opacity := 1.0;

  result := b;
end;

{ TCornerBtn }

procedure TCornerBtn.UpdateUV;
begin
  U := X;
  V := Y;

  case CornerPos of
    cpTL, cpTR,  cpBL, cpBR:
    begin
      if not Main.IsLandscape then
      begin
        U := Y;
        V := X;
      end;

      if U > 0 then
      begin
        case CornerPos of
          cpTL:
          begin
            Inc(TCornerMenu.TStart);
            Inc(TCornerMenu.TCount);
          end;
          cpTR:
          begin
            Inc(TCornerMenu.TCount);
          end;
          cpBL:
          begin
            Inc(TCornerMenu.BStart);
            Inc(TCornerMenu.BCount);
          end;
          cpBR:
          begin
            Inc(TCornerMenu.BCount);
          end;
        end;
      end;
      if V > 0 then
      begin
        case CornerPos of
          cpTL:
          begin
            Inc(TCornerMenu.LStart);
            Inc(TCornerMenu.LCount);
          end;
          cpTR:
          begin
            Inc(TCornerMenu.RStart);
            Inc(TCornerMenu.RCount);
          end;
          cpBL:
          begin
            Inc(TCornerMenu.LCount);
          end;
          cpBR:
          begin
            Inc(TCornerMenu.RCount);
          end;
        end;
      end;

    end;
  end;
end;

procedure TCornerBtn.InitPosition;
var
  mx, my: Boolean;
begin
  UpdateUV;
  case CornerPos of
    cpTL:
    begin
      mx := False;
      my := False;
    end;
    cpTR:
    begin
      mx := True;
      my := False;
    end;
    cpBR:
    begin
      mx := True;
      my := True;
    end;
    cpBL:
    begin
      mx := False;
      my := True;
    end;

    cpT:
    begin
      mx := False;
      my := False;
    end;
    cpR:
    begin
      mx := True;
      my := False;
    end;
    cpB:
    begin
      mx := False;
      my := True;
    end;
    cpL:
    begin
      mx := False;
      my := False;
    end;

    else
    begin
      mx := False;
      my := False;
    end;
  end;

  if mx then
    Position.X := MainVar.ClientWidth - (U + 1) * MainVar.Raster
  else
    Position.X := U * MainVar.Raster;

  if my then
    Position.Y := MainVar.ClientHeight - (V + 1) * MainVar.Raster
  else
    Position.Y := V * MainVar.Raster;
end;

{ TFederTouchBase }

procedure TFederTouchBase.CheckBtnOrder;
begin
  { virtual }
end;

procedure TFederTouchBase.CheckCircleState;
begin
  { virtual }
end;

procedure TFederTouchBase.CheckState;
var
  b: TCornerBtn;
begin
  Inc(Main.CounterCheckState);
  Main.TextUpdateNeeded;
  for b in CornerBtnList do
    b.CheckState;
  CheckCircleState;
end;

constructor TFederTouchBase.Create(AOwner: TComponent);
begin
  OpacityValue := 0.5;
  CornerBtnList := TObjectList<TCornerBtn>.Create;
  CornerBtnList.OwnsObjects := False;
  CornerMenu := TCornerMenu.Create;
end;

destructor TFederTouchBase.Destroy;
begin
  CornerMenu.Free;
  CornerBtnList.Free;
  inherited;
end;

procedure TFederTouchBase.Init;
begin
  if not InitOK then
  begin
    InitShapes;
    InitOK := True;
  end;
end;

procedure TFederTouchBase.InitShapes;
begin
  if not InitOK then
  begin
    InitCornerMenu;
    SL00.FShape.OnMouseDown := OnMouseDown;
    SR00.FShape.OnMouseDown := OnMouseDown;
    ST00.FShape.OnMouseDown := OnMouseDown;
    SB00.FShape.OnMouseDown := OnMouseDown;

    SL00.FShape.OnMouseMove := OnMouseMove;
    SR00.FShape.OnMouseMove := OnMouseMove;
    ST00.FShape.OnMouseMove := OnMouseMove;
    SB00.FShape.OnMouseMove := OnMouseMove;

    SL00.FShape.OnMouseUp := OnMouseUp;
    SR00.FShape.OnMouseUp := OnMouseUp;
    ST00.FShape.OnMouseUp := OnMouseUp;
    SB00.FShape.OnMouseUp := OnMouseUp;

    SL00.FShape.OnMouseLeave := OnMouseLeave;
    SR00.FShape.OnMouseLeave := OnMouseLeave;
    ST00.FShape.OnMouseLeave := OnMouseLeave;
    SB00.FShape.OnMouseLeave := OnMouseLeave;

    InitOK := True;
    UpdateShape;
  end;
end;

procedure TFederTouchBase.UpdateColorScheme;
var
  b: TCornerBtn;
begin
  for b in CornerBtnList do
    b.FText.Color := MainVar.ColorScheme.claCornerBtnText;

  ST00.FShape.Fill.Color := MainVar.ColorScheme.claCornerScrollbar;
  ST00.FText.Color := MainVar.ColorScheme.claCornerBtnText;
  SB00.FShape.Fill.Color := MainVar.ColorScheme.claCornerScrollbar;
  SB00.FText.Color := MainVar.ColorScheme.claCornerBtnText;
  SL00.FShape.Fill.Color := MainVar.ColorScheme.claCornerScrollbar;
  SL00.FText.Color := MainVar.ColorScheme.claCornerBtnText;
  SR00.FShape.Fill.Color := MainVar.ColorScheme.claCornerScrollbar;
  SR00.FText.Color := MainVar.ColorScheme.claCornerBtnText;
end;

procedure TFederTouchBase.BorderTrack(Sender: TObject; X, Y: single);
begin
  if Sender = SB00.Shape then
  begin
    if Abs(X - OldX) > 0 then
    begin
      Main.DoTouchbarBottom(X - OldX);
      OldX := X;
      OldY := Y;
    end;
  end
  else if Sender = ST00.Shape then
  begin
    if Abs(X - OldX) > 0 then
    begin
      Main.DoTouchbarTop(X - OldX);
      OldX := X;
      OldY := Y;
    end;
  end
  else if Sender = SL00.Shape then
  begin
    if Abs(Y - OldY) > 10 then
    begin
      Main.DoTouchbarLeft(OldY - Y);
      OldX := X;
      OldY := Y;
    end;
  end
  else if Sender = SR00.Shape then
  begin
    if Abs(Y - OldY) > 10 then
    begin
      Main.DoTouchbarRight(OldY - Y);
      OldX := X;
      OldY := Y;
    end;
  end
  else
  begin
    OldX := X;
    OldY := Y;
  end;
end;

procedure TFederTouchBase.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
begin
  Down := True;
  OldX := X;
  OldY := Y;
  FOwnsMouse := True;
end;

procedure TFederTouchBase.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: single);
begin
  if Main.IsUp then
  begin
    if Down then
      BorderTrack(Sender, X, Y);
  end;
end;

procedure TFederTouchBase.OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
begin
  Down := False;
  FOwnsMouse := False;
end;

procedure TFederTouchBase.SetOwnsMouse(const Value: Boolean);
begin
  FOwnsMouse := Value;
end;

procedure TFederTouchBase.OnMouseLeave(Sender: TObject);
begin
  Down := False;
end;

procedure TFederTouchBase.UpdateShape;
var
  b: TCornerBtn;
begin
  if InitOK then
  begin
    TCornerMenu.TStart := 1;
    TCornerMenu.RStart := 1;
    TCornerMenu.BStart := 1;
    TCornerMenu.LStart := 1;

    TCornerMenu.TCount := 2;
    TCornerMenu.RCount := 2;
    TCornerMenu.BCount := 2;
    TCornerMenu.LCount := 2;

    for b in CornerBtnList do
      b.InitPosition;

    ST00.Position.X := TCornerMenu.TStart * MainVar.Raster;
    ST00.Position.Y := 0;

    SR00.Position.X := MainVar.ClientWidth - MainVar.Raster;
    SR00.Position.Y := TCornerMenu.RStart * MainVar.Raster;

    SB00.Position.X := TCornerMenu.BStart * MainVar.Raster;
    SB00.Position.Y := MainVar.ClientHeight - MainVar.Raster;

    SL00.Position.X := 0;
    SL00.Position.Y := TCornerMenu.LStart * MainVar.Raster;

    ST00.Width := MainVar.ClientWidth - (TCornerMenu.TCount) * MainVar.Raster;
    SB00.Width := MainVar.ClientWidth - (TCornerMenu.BCount) * MainVar.Raster;
    SL00.Height := MainVar.ClientHeight - (TCornerMenu.LCount) * MainVar.Raster;
    SR00.Height := MainVar.ClientHeight - (TCornerMenu.RCount) * MainVar.Raster;

    CheckBtnOrder;
  end;
end;

procedure TFederTouchBase.InitCornerMenu;
var
  cp: TCornerPos;
  cla: TAlphaColor;
  claTextureParam: TAlphaColor;
  claParam: TAlphaColor;
  claOption: TAlphaColor;
  claMeshSize: TAlphaColor;
begin
  cla := claWhite;
  claParam := claYellow;
  claTextureParam := claPlum;
  claOption := claCornflowerBlue;
  claMeshSize := claLightGray;

  TCornerBtn.OffsetX := 0;
  TCornerBtn.OffsetY := 0;
  TCornerBtn.BtnWidth := MainVar.Raster;
  TCornerBtn.BtnHeight := MainVar.Raster;
  TCornerBtn.Circle := False;

  cp := cpTL;
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 0, claOption, faToggleColorPanel));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, claTextureParam, faParamT1));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, claTextureParam, faParamT2));

  cp := cpTR;
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 0, cla, faReset));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, claParam, faParamR));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 2, 0, claParam, faParamL));

  cp := cpBR;
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, claMeshSize, faMeshSize128));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 0, claMeshSize, faMeshSize64));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 1, claMeshSize, faMeshSize32));

  cp := cpBL;
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 0, 0, cla, faToggleSolidFlip));
  CornerBtnList.Add(CornerMenu.NewBtn(cp, 1, 0, cla, faToggleShowEdges));

  cla := MainVar.ColorScheme.claCornerScrollbar;
  ST00 := CornerMenu.NewBtn(cpT, 0, 0, cla, faNoop);
  SR00 := CornerMenu.NewBtn(cpR, 0, 0, cla, faNoop);
  SB00 := CornerMenu.NewBtn(cpB, 0, 0, cla, faNoop);
  SL00 := CornerMenu.NewBtn(cpL, 0, 0, cla, faNoop);

  SL00.FText.Align := TAlignLayout.Client;
  SL00.FText.HitTest := False;
  SL00.FText.Font.Size := 28;

  SR00.FText.Align := TAlignLayout.Client;
  SR00.FText.HitTest := False;
  SR00.FText.Font.Size := 28;

  ST00.FText.Align := TAlignLayout.Client;
  ST00.FText.HitTest := False;
  ST00.FText.Font.Size := 28;

  SB00.FText.Align := TAlignLayout.Client;
  SB00.FText.HitTest := False;
  SB00.FText.Font.Size := 28;
end;

end.
