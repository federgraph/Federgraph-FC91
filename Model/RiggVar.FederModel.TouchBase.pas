unit RiggVar.FederModel.TouchBase;

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

{$define WantToolBtn}

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
  RiggVar.FB.ActionMap,
  RiggVar.FB.Classes,
  RiggVar.FB.Text,
  RiggVar.FB.Color,
  RiggVar.FB.Def;

type
  TTouchBtn = class(TControl)
  private
    FID: Integer;
    FMenuBtn: Boolean;
    FOptiBtn: Boolean;
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
    property MenuBtn: Boolean read FMenuBtn;
    property OptiBtn: Boolean read FOptiBtn;
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

  TTouchBarBase = class
  protected
    FBtnCount: Integer;
  public
    TouchBtnList: TObjectList<TTouchBtn>;
    procedure UpdateColorScheme;
    constructor Create;
    destructor Destroy; override;
    property BtnCount: Integer read FBtnCount;
  end;

  TTouchMenu = class(TTouchBarBase)
  private
    FColumnCount: Integer;
    procedure SetColumnCount(const Value: Integer);
  public
    procedure AddBtn(fa: TFederAction);
    procedure UpdateShape(Docked: Boolean; LimitY: Integer);
    procedure UpdateAction(Idx: Integer; NewAction: TFederAction);
    property ColumnCount: Integer read FColumnCount write SetColumnCount;
  end;

  TTouchBar = class(TTouchBarBase)
  private
    FTop: Boolean;
    FCount: Integer;
    procedure SetVisible(const Value: Boolean);
    function GetVisible: Boolean;
  public
    Container: TRectangle;
    procedure InitContainer(ATop: Boolean; ACount: Integer);
    procedure InitPosition;
    procedure UpdateAction(Idx: Integer; NewAction: TFederAction);
    procedure AddBtn(fa: TFederAction);
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  TFederTouchBase = class(TFederText)
  private
    function GetMaxCount: Integer;
    function GetMinCount: Integer;
  protected
    FMinBtnCount: Integer;
    FMaxBtnCount: Integer;
    FMaxBtnPhone: Integer;
    FMinBtnPhone: Integer;

    MissID: TList<Integer>;
    MissBtnListB: TObjectList<TCornerBtn>;
    MissBtnListS: TObjectList<TCornerBtn>;

    MaxPageIndex: Integer;
    EscapePageIndex: Integer;

    FMenuBarLayout: Integer;

    FWantMenuVisible: Boolean;
    FWantEquationVisible: Boolean;
    FWantTextVisible: Boolean;
    FWantTitleVisible: Boolean;
    FWantSwatVisible: Boolean;

    OldX: single;
    OldY: single;
    Down: Boolean;

{$ifdef WantToolBtn}
    ToolBtn: TCircle;
{$endif}

    ConnLED: TCircle;
    LAT: TText;
    LHT: single;

    AppliedApp: Integer;

    function FindMissBtn(id: Integer): TCornerBtn;
    function FindMissBtnB(id: Integer): TCornerBtn;
    function FindMissBtnS(id: Integer): TCornerBtn;
    procedure AddMissingB;
    procedure AddMissingS;
    procedure RemoveMissingB;
    procedure RemoveMissingS;

    function LineHeight(t: TText): single;
    function NewLabelText(t: TText): TText;

    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: single);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
    procedure OnMouseLeave(Sender: TObject);
    procedure BorderTrack(Sender: TObject; X, Y: single);

    procedure SetActionPage(const Value: Integer); override;
    procedure SetFrameVisible(const Value: Boolean); override;

    procedure InitAction(BtnID: Integer; fa: TFederAction);
    procedure InitActionWithColor(BtnID: Integer; fa: TFederAction; ac: TAlphaColor);

    function GetPaletteBtn: TCornerBtn; virtual;

    procedure SetAllVisible(const Value: Boolean); override;
    procedure SetTransitBarLayout(const Value: Integer); override;
    procedure SetMenuBarLayout(const Value: Integer);
  public
    WantLED: Boolean;
    Spruch: string;

    CornerBtnList: TObjectList<TCornerBtn>;
    CornerMenu: TCornerMenu;

    HomeBtn: TCornerBtn;
    PageBtnP: TCornerBtn;
    PageBtnM: TCornerBtn;

    SL00: TCornerBtn;
    ST00: TCornerBtn;
    SB00: TCornerBtn;
    SR00: TCornerBtn;

    class var
      OpacityValue: single;
      OwnerComponent: TComponent;
      ParentObject: TFmxObject;
      ClickedID: Integer;
      VerticalTouchbarHelpText: string;
      HorizontalTouchbarHelpText: string;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ToolBtnClick(Sender: TObject);
    procedure ToggleTouchFrame; override;
    procedure UpdateText; override;

    procedure Init; override;
    procedure CheckState; virtual;
    procedure UpdateWH;
    procedure CheckCircleState; virtual;
    procedure MoveText; virtual;
    procedure CheckBtnOrder; virtual;

    procedure Report(ML: TStrings);
    function FindCornerBtn(id: Integer): TCornerBtn;
    function GetColorOfButton(BtnID: Integer): TAlphaColor;
    function GetHintForColorBtn(BtnID: Integer): string;

    procedure InitActions(Layout: Integer); virtual;
    procedure UpdateMissing; virtual;
    procedure UpdateToolSet(Delta: Integer);
    procedure UpdateShape;
    procedure UpdateColorScheme; virtual;
    procedure UpdatePageBtnText;
    procedure ResetAge; virtual;

    procedure InitMenuBarActions(ALayout: Integer); virtual;
    procedure InitTransitBarActions(ALayout: Integer); virtual;
    procedure InitActionFromInfo(ActionInfo: TActionInfo); virtual;

    property MinCount: Integer read GetMinCount;
    property MaxCount: Integer read GetMaxCount;
    property MenuBarLayout: Integer read FMenuBarLayout write SetMenuBarLayout;

    property PaletteBtn: TCornerBtn read GetPaletteBtn;
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
    if Main.IsPhone
      or not Main.FederPaletteHandleTouchBtnClick(Self)
    then
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

{ TTouchBarBase }

constructor TTouchBarBase.Create;
begin
  TouchBtnList := TObjectList<TTouchBtn>.Create;
  TouchBtnList.OwnsObjects := False;
end;

destructor TTouchBarBase.Destroy;
begin
  TouchBtnList.Free;
  inherited;
end;

procedure TTouchBarBase.UpdateColorScheme;
var
  b: TTouchBtn;
begin
  if not Main.PaletteMode then
    for b in TouchBtnList do
    begin
      b.FShape.Fill.Color := MainVar.ColorScheme.claTouchBtnFill;
      b.FText.Color := MainVar.ColorScheme.claCornerBtnText;
    end;
end;

{ TTouchMenu }

procedure TTouchMenu.AddBtn(fa: TFederAction);
var
  b: TTouchBtn;
begin
  if fa <> faNoop then
  begin
    b := TTouchBtn.Create(TFederTouchBase.OwnerComponent);
    b.X := (BtnCount) mod ColumnCount;
    b.Y := BtnCount div ColumnCount;
    b.FederAction := fa;
    b.Caption := Main.ActionHandler.GetShortCaption(fa);
    b.FMenuBtn := True;
    b.Init;
    TFederTouchBase.ParentObject.AddObject(b);
    TouchBtnList.Add(b);
    b.ID := TouchBtnList.Count-1;
    b.FShape.Opacity := 0.4;
    b.FText.Opacity := 1.0;
  end;
  Inc(FBtnCount);
end;

procedure TTouchMenu.SetColumnCount(const Value: Integer);
begin
  FColumnCount := Value;
end;

procedure TTouchMenu.UpdateShape(Docked: Boolean; LimitY: Integer);
var
  b: TTouchBtn;
  v: Boolean;
begin
  for b in TouchBtnList do
  begin
    v := True;
    if Docked then
      v := (b.X  < DockStartX) or (b.Y > 1);

    if b.Y > LimitY then
      v := False;

    b.Visible := v;
  end;
end;

procedure TTouchMenu.UpdateAction(Idx: Integer; NewAction: TFederAction);
var
  b: TTouchBtn;
begin
  if (Idx >= 0) and (Idx < BtnCount) then
  begin
    b := TouchBtnList[Idx] as TTouchBtn;
    b.FederAction := NewAction;
    b.Caption := Main.ActionHandler.GetShortCaption(NewAction);
//    b.UpdateHint;
    b.Hint := TActionMap.CurrentMenuCaptions[Idx];
  end;
end;

{ TTouchBar }

procedure TTouchBar.AddBtn(fa: TFederAction);
var
  b: TTouchBtn;
begin
  b := TTouchBtn.Create(TFederTouchBase.OwnerComponent);
  b.X := BtnCount;
  b.Y := 0;
  b.FederAction := fa;
  b.Caption := Main.ActionHandler.GetShortCaption(fa);

  b.Init;
  Container.AddObject(b);
  TouchBtnList.Add(b);
  b.ID := TouchBtnList.Count-1;
  b.FOptiBtn := TTouchBtn.Circle;

  Inc(FBtnCount);
end;

function TTouchBar.GetVisible: Boolean;
begin
  if Assigned(Container) then
    result := Container.Visible
  else
    result := False;
end;

procedure TTouchBar.InitContainer(ATop: Boolean; ACount: Integer);
begin
  FTop := ATop;
  FCount := ACount;
  Container := TRectangle.Create(TFederTouchBase.OwnerComponent);
  Container.Fill.Color := claWhite;
  Container.Stroke.Color := BtnBorderColor;
  Container.Stroke.Thickness := BtnBorderWidth;
  Container.XRadius := BtnBorderRadius;
  Container.YRadius := BtnBorderRadius;
  Container.Opacity := 0.4;

  InitPosition;

  Container.Width := FCount * TTouchBtn.BtnWidth;
  Container.Height := TTouchBtn.BtnHeight;
  TFederTouchBase.ParentObject.AddObject(Container);
end;

procedure TTouchBar.InitPosition;
begin
  if FTop then
  begin
    Container.Position.X := 2 * MainVar.Raster;
    Container.Position.Y := MainVar.Raster;
  end
  else
  begin
    Container.Position.X := MainVar.ClientWidth - (1 + FCount) * MainVar.Raster;
    Container.Position.Y := MainVar.ClientHeight - 2 * MainVar.Raster;
  end;
end;

procedure TTouchBar.SetVisible(const Value: Boolean);
begin
  if Assigned(Container) then
    Container.Visible := Value;
end;

procedure TTouchBar.UpdateAction(Idx: Integer; NewAction: TFederAction);
var
  b: TTouchBtn;
begin
  if (Idx >= 0) and (Idx < BtnCount) then
  begin
    if Container.Children[Idx] is TTouchBtn then
    begin
      b := Container.Children[Idx] as TTouchBtn;
      b.FederAction := NewAction;
      b.Caption := Main.ActionHandler.GetShortCaption(NewAction);
      b.UpdateHint;
    end;
  end;
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

procedure TFederTouchBase.UpdateWH;
begin
  Width := MainVar.ClientWidth;
  Height := MainVar.ClientHeight;
end;

procedure TFederTouchBase.CheckBtnOrder;
begin
  { virtual }
end;

procedure TFederTouchBase.CheckCircleState;
begin
  { virtual }
end;

procedure TFederTouchBase.MoveText;
begin
  Width := MainVar.ClientWidth;
  Height := MainVar.ClientHeight;
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
  inherited;
  FFrameVisible := True;
  FMaxBtnCount := 12;
  FMinBtnCount := 8;
  FMaxBtnPhone := 6;
  FMinBtnPhone := 4;

  FActionPage := 1;
  EscapePageIndex := FActionPage + 1;
  MissID := TList<Integer>.Create;
  MissBtnListB := TObjectList<TCornerBtn>.Create;
  MissBtnListS := TObjectList<TCornerBtn>.Create;
  CornerBtnList := TObjectList<TCornerBtn>.Create;
  CornerBtnList.OwnsObjects := False;
  CornerMenu := TCornerMenu.Create;
end;

destructor TFederTouchBase.Destroy;
begin
  MissID.Free;
  CornerMenu.Free;
  CornerBtnList.Free;
  MissBtnListB.Free;
  MissBtnListS.Free;
  inherited;
end;

function TFederTouchBase.GetMinCount: Integer;
begin
  result := Min(MainVar.ClientWidth, MainVar.ClientHeight) div MainVar.Raster;
end;

function TFederTouchBase.GetMaxCount: Integer;
begin
  result := Max(MainVar.ClientWidth, MainVar.ClientHeight) div MainVar.Raster;
end;

procedure TFederTouchBase.Init;
begin
  { virtual }
end;

procedure TFederTouchBase.SetActionPage(const Value: Integer);
begin
  if Value = -3 then
  begin
    if FActionPage = 1 then
      FActionPage := EscapePageIndex
    else
      FActionPage := 1;
  end
  else if Value = -2 then
    FActionPage := MaxPageIndex
  else if Value = -1 then
    FActionPage := EscapePageIndex
  else if (Value = EscapePageIndex) and (FActionPage = EscapePageIndex + 1) then
    FActionPage := EscapePageIndex
  else if (Value = EscapePageIndex) and (FActionPage = EscapePageIndex - 1) then
    FActionPage := 1
  else
    FActionPage := Value;

    if FActionPage > MaxPageIndex then
    FActionPage := 1;
  if FActionPage < 1 then
      FActionPage := EscapePageIndex - 1;

  InitActions(FActionPage);

  Main.CheckStateNeeded;
  Main.TextUpdateNeeded;
end;

procedure TFederTouchBase.UpdateColorScheme;
begin
  { virtual }
end;

procedure TFederTouchBase.SetFrameVisible(const Value: Boolean);
var
  b: TCornerBtn;
begin
  FFrameVisible := Value;

{$ifdef WantToolBtn}
  if Value then
    ToolBtn.Opacity := 0.1
  else
    ToolBtn.Opacity := 0.05;
{$endif}

  for b in CornerBtnList do
    b.Visible := Value;

  ST00.Visible := Value;
  SR00.Visible := Value;
  SB00.Visible := Value;
  SL00.Visible := Value;
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
  OwnsMouse := True;
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
  OwnsMouse := False;
end;

procedure TFederTouchBase.OnMouseLeave(Sender: TObject);
begin
  Down := False;
end;

procedure TFederTouchBase.UpdateShape;
var
  b: TCornerBtn;
begin
  UpdateWH;

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

{$ifdef WantToolBtn}
    ToolBtn.Position.X := MainVar.Raster;
    ToolBtn.Position.Y := MainVar.Raster;
    ToolBtn.Width := MainVar.Raster;
{$endif}

    if Assigned(ConnLED) then
    begin
      ConnLED.Position.X := ToolBtn.Position.X + 0.5 * MainVar.Raster - 7;
      ConnLED.Position.Y := ToolBtn.Position.Y + 0.5 * MainVar.Raster - 7;
    end;

    MoveText;
    CheckBtnOrder;
  end;
end;

procedure TFederTouchBase.UpdateToolSet(Delta: Integer);
begin
  ActionPage := FActionPage + Delta;
end;

procedure TFederTouchBase.InitAction(BtnID: Integer; fa: TFederAction);
var
  tb: TCornerBtn;
begin
  tb := FindCornerBtn(BtnID);
  if not Assigned(tb) then
    tb := FindMissBtn(BtnID);
  if Assigned(tb) then
  begin
    tb.FederAction := fa;
    tb.Caption := Main.ActionHandler.GetShortCaption(fa);
    tb.UpdateHint;
  end;
end;

procedure TFederTouchBase.InitActionWithColor(BtnID: Integer; fa: TFederAction; ac: TAlphaColor);
var
  tb: TCornerBtn;
begin
  tb := FindCornerBtn(BtnID);
  if not Assigned(tb) then
    tb := FindMissBtn(BtnID);
  if Assigned(tb) then
  begin
    tb.FederAction := fa;
    tb.Caption := Main.ActionHandler.GetShortCaption(fa);
    tb.UpdateHint;
    tb.Color := ac;
    if fa = faCLA then
    begin
      tb.Hint := ColorVar.RggColorPool.ColorToString(ac);
    end;
  end;
end;

procedure TFederTouchBase.InitActions(Layout: Integer);
begin
  { virtual }
end;

procedure TFederTouchBase.InitActionFromInfo(ActionInfo: TActionInfo);
begin
  { virtual }
end;

function TFederTouchBase.LineHeight(t: TText): single;
begin
  result := t.Font.Size + Round(t.Font.Size / 4);
end;

function TFederTouchBase.NewLabelText(t: TText): TText;
begin
  result := TText.Create(OwnerComponent);
  result.AutoSize := True;
  result.WordWrap := False;
  if Assigned(t) then
  begin
    result.Position.X := t.Position.X;
    result.Position.Y := t.Position.Y + LineHeight(t);
    result.Font.Size := t.Font.Size;
    result.Font.Family := t.Font.Family;
    result.Color := t.Color;
    result.Parent := t.Parent;
    result.HorzTextAlign := t.HorzTextAlign;
  end;
  result.BringToFront;
  result.Enabled := False;
  LAT := result;
end;

procedure TFederTouchBase.SetAllVisible(const Value: Boolean);
begin
  if Value then
  begin
    { make components visible as recorded before }
    FrameVisible := True;
    TextVisible := FWantTextVisible;
    EquationVisible := FWantEquationVisible;
    MenuVisible := FWantMenuVisible;
    TitleVisible := FWantTitleVisible;
    SwatVisible := FWantSwatVisible;
    ToolBtn.Opacity := 0.1;
  end
  else
  begin
    { if Frame/All is currently visible }

    { record current state }
    FWantMenuVisible := FMenuVisible;
    FWantEquationVisible := FEquationVisible;
    FWantTextVisible := FTextVisible;
    FWantTitleVisible := FTitleVisible;
    FWantSwatVisible := FSwatVisible;

    { and switch all off}
    FrameVisible := False;
    TextVisible := False;
    EquationVisible := False;
    MenuVisible := False;
    SwatVisible := False;
    //TitleVisible := False; //leave this as is
    ToolBtn.Opacity := 0.05;
  end;

  FAllVisible := Value;
end;

function TFederTouchBase.FindCornerBtn(id: Integer): TCornerBtn;
var
  cb: TCornerBtn;
begin
  result := nil;
  for cb in CornerBtnList do
    if cb.ID = id then
    begin
      result := cb;
      break;
    end;
end;

procedure TFederTouchBase.UpdateText;
begin
  if InitOK then
  begin
    UpdatePageBtnText;
  end;
end;

procedure TFederTouchBase.UpdatePageBtnText;
begin
  if not Main.PaletteMode then
  begin
    PageBtnP.Text.Text := IntToStr(ActionPage);
    PageBtnM.Text.Text := IntToStr(ActionPage);
  end;
end;

procedure TFederTouchBase.ResetAge;
begin
  { virtual }
end;

function TFederTouchBase.GetPaletteBtn: TCornerBtn;
begin
  result := nil;
end;

procedure TFederTouchBase.SetMenuBarLayout(const Value: Integer);
begin
  FMenuBarLayout := Value;
  InitMenuBarActions(Value);
  TransitBarLayout := Value;
end;

procedure TFederTouchBase.SetTransitBarLayout(const Value: Integer);
begin
  FTransitBarLayout := Value;
  InitTransitBarActions(Value);
end;

procedure TFederTouchBase.InitMenuBarActions(ALayout: Integer);
begin
  { virtual }
end;

procedure TFederTouchBase.InitTransitBarActions(ALayout: Integer);
begin
  { virtual }
end;

procedure TFederTouchBase.Report(ML: TStrings);
var
  cb: TCornerBtn;
  s: string;

  function GetLocationString(cp: TCornerPos): string;
  begin
    case cp of
      cpTL: result := 'TL';
      cpTR: result := 'TR';
      cpBL: result := 'BL';
      cpBR: result := 'BR';
      cpT: result := 'T';
      cpR: result := 'R';
      cpB: result := 'B';
      cpL: result := 'L';
    end;
  end;

  procedure AddLine(cb: TCornerBtn);
  begin
    s := Format('%.2d: %s, %s = %s', [
      cb.ID,
      GetLocationString(cb.CornerPos),
      Main.ActionHandler.GetCaption(cb.FederAction),
      cb.Caption
      ]);
    ML.Add(s);
  end;

begin
  for cb in CornerBtnList do
    AddLine(cb);
end;

procedure TFederTouchBase.ToolBtnClick(Sender: TObject);
begin
  ToggleTouchFrame;
end;

procedure TFederTouchBase.ToggleTouchFrame;
begin
  FrameVisible := not FrameVisible;

  Main.FrameVisibilityChanged;

{$ifdef WantToolBtn}
  if FrameVisible then
  begin
    ToolBtn.Opacity := 0.1;
   end
  else
  begin
    ToolBtn.Opacity := 0.05;
  end;
{$endif}
end;

function TFederTouchBase.FindMissBtn(id: Integer): TCornerBtn;
var
  cb: TCornerBtn;
begin
  result := nil;
  for cb in MissBtnListB do
    if cb.ID = id then
    begin
      result := cb;
      break;
    end;
  for cb in MissBtnListS do
    if cb.ID = id then
    begin
      result := cb;
      break;
    end;
end;

function TFederTouchBase.FindMissBtnB(id: Integer): TCornerBtn;
var
  cb: TCornerBtn;
begin
  result := nil;
  for cb in MissBtnListB do
    if cb.ID = id then
    begin
      result := cb;
      break;
    end;
end;

function TFederTouchBase.FindMissBtnS(id: Integer): TCornerBtn;
var
  cb: TCornerBtn;
begin
  result := nil;
  for cb in MissBtnListS do
    if cb.ID = id then
    begin
      result := cb;
      break;
    end;
end;

procedure TFederTouchBase.AddMissingB;
var
  i: Integer;
  bid: Integer;
  cb: TCornerBtn;
  mb: TCornerBtn;
begin
  for i := 0 to MissID.Count-1 do
  begin
    bid := MissID[i];
    cb := FindCornerBtn(bid);
    mb := FindMissBtnB(bid);
    if Assigned(mb) then
      mb.Visible := FFrameVisible;
    if (cb = nil) and (mb <> nil) then
      CornerBtnList.Add(mb);
  end;
end;

procedure TFederTouchBase.AddMissingS;
var
  i: Integer;
  bid: Integer;
  cb: TCornerBtn;
  mb: TCornerBtn;
begin
  for i := 0 to MissID.Count-1 do
  begin
    bid := MissID[i];
    cb := FindCornerBtn(bid);
    mb := FindMissBtnS(bid);
    if Assigned(mb) then
      mb.Visible := FFrameVisible;
    if (cb = nil) and (mb <> nil) then
      CornerBtnList.Add(mb);
  end;
end;

procedure TFederTouchBase.RemoveMissingB;
var
  i: Integer;
  bid: Integer;
  cb: TCornerBtn;
  mb: TCornerBtn;
begin
  for i := 0 to MissID.Count-1 do
  begin
    bid := MissID[i];
    cb := FindCornerBtn(bid);
    mb := FindMissBtnB(bid);
    if Assigned(mb) then
      mb.Visible := False;
    if (cb <> nil) and (mb <> nil) then
      CornerBtnList.Remove(mb);
  end;
end;

procedure TFederTouchBase.RemoveMissingS;
var
  i: Integer;
  bid: Integer;
  cb: TCornerBtn;
  mb: TCornerBtn;
begin
  for i := 0 to MissID.Count-1 do
  begin
    bid := MissID[i];
    cb := FindCornerBtn(bid);
    mb := FindMissBtnS(bid);
    if Assigned(mb) then
      mb.Visible := False;
    if (cb <> nil) and (mb <> nil) then
      CornerBtnList.Remove(mb);
  end;
end;

procedure TFederTouchBase.UpdateMissing;
begin
  if MaxCount > FMaxBtnCount then
    AddMissingB
  else
    RemoveMissingB;

  if MinCount > FMinBtnCount then
    AddMissingS
  else
    RemoveMissingS;
end;

function TFederTouchBase.GetColorOfButton(BtnID: Integer): TAlphaColor;
var
  tb: TCornerBtn;
begin
  tb := FindCornerBtn(BtnID);
  if not Assigned(tb) then
    tb := FindMissBtn(BtnID);
  if tb <> nil then
  begin
    result := tb.Color;
  end
  else
    result := claBlack;
end;

function TFederTouchBase.GetHintForColorBtn(BtnID: Integer): string;
begin
  result := ColorVar.RggColorPool.ColorToString(GetColorOfButton(BtnID));
end;

end.
