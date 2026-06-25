unit RiggVar.FB.Frame;

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
  System.Math,
  System.Math.Vectors,
  System.UIConsts,
  System.SysUtils,
  System.Classes,
  System.Types,
  System.UITypes,
  FMX.Types,
  FMX.Types3D,
  FMX.Objects3D,
  FMX.Layers3D,
  FMX.Ani,
  FMX.Controls3D,
  FMX.Layouts,
  FMX.Viewport3D,
  RiggVar.FB.Classes,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst;

type
  TBorderTrack = (
    btNoop,
    btTop,
    btBottom,
    btLeft,
    btRight,
    btInside,
    btOutside,
    btTopLeft,
    btTopRight,
    btBottomLeft,
    btBottomRight
  );

  TEulerAngle = class
  private
    HasX: Boolean;
    HasY: Boolean;
    HasZ: Boolean;
    FX: single;
    FY: single;
    FZ: single;
    procedure SetX(const Value: single);
    procedure SetY(const Value: single);
    procedure SetZ(const Value: single);
    function GetRotation: TPoint3D;
    procedure SetRotation(const Value: TPoint3D);
    function GetHasValue: Boolean;
  public
    procedure Reset;
    procedure Wrap;
    property X: single read FX write SetX;
    property Y: single read FY write SetY;
    property Z: single read FZ write SetZ;
    property Rotation: TPoint3D read GetRotation write SetRotation;
    property HasValue: Boolean read GetHasValue;
  end;

  IFederFrame = interface
  ['{C3787BCE-2E98-4D98-9478-519C51103405}']
    procedure HandleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure ViewportKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure ViewportKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);

    procedure ViewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
    procedure ViewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: single);
    procedure ViewportMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
    procedure ViewportClick(Sender: TObject);

    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure ImageClick(Sender: TObject);

    procedure UpdateSize(X, Y: single);
    procedure DoOnIdle;

    procedure Reset;
    procedure ResetRotation;
    procedure ResetPosition;
    procedure ResetZoom;
    procedure ResetPositionAndRotation;

    procedure DoZoom(Delta: single);
    procedure DoZoomTimed(Delta: single);
    procedure DoZoomTimed3D(Delta: single);
    procedure DoMM(fmk: TFederMessageKind; X, Y: single);
    procedure DoMMTimed(fmk: TFederMessageKind; X, Y: single);
    procedure DoMMRemote(fmk: TFederMessageKind; X, Y: single);
    procedure DoParamValueChange(fp: TFederParam; pv: single);

    procedure SaveToFederData(fd: TFederData);
    procedure LoadFromFederData(fd: TFederData);

    function GetWheelStatusText: string;
    function GetViewStatusText: string;
    function GetOnViewportChanged: TNotifyEvent;
    function GetMoveMode: Boolean;
    function GetIsClean: Boolean;
    function GetMoveModeText: string;
    function GetMouseDown: Boolean;
    function GetOrbitMode: Boolean;

    procedure SetOnViewportChanged(const Value: TNotifyEvent);
    procedure SetMoveMode(const Value: Boolean);
    procedure SetOrbitMode(const Value: Boolean);

    procedure UpdateRotation;

    property ViewStatusText: string read GetViewStatusText;
    property WheelStatusText: string read GetWheelStatusText;

    property MouseDown: Boolean read GetMouseDown;
    property IsClean: Boolean read GetIsClean;
    property MoveMode: Boolean read GetMoveMode write SetMoveMode;
    property OrbitMode: Boolean read GetOrbitMode write SetOrbitMode;
    property OnViewportChanged: TNotifyEvent read GetOnViewportChanged write SetOnViewportChanged;
    property MoveModeText: string read GetMoveModeText;
  end;

  TFederFrameBase = class
  private
    FOnViewportChanged: TNotifyEvent;
    FMouseRotationSpeed: single;

    SB: TStringBuilder;

    FColor: TAlphaColor;
    FColorChanged: TNotifyEvent;

    procedure SetColor(const Value: TAlphaColor);
    procedure SetColorChanged(const Value: TNotifyEvent);

    function GetWheelStatusText: string; virtual;
    function GetViewStatusText: string; virtual;

    procedure SetOnViewportChanged(const Value: TNotifyEvent);
    procedure SetMoveMode(const Value: Boolean);
    procedure SetOrbitMode(const Value: Boolean);
    function GetMoveMode: Boolean;
    function GetOrbitMode: Boolean;
    function GetIsClean: Boolean;
    function GetMoveModeText: string;
    function GetDefaultRX: Integer;
    function GetOnViewportChanged: TNotifyEvent;
    function GetMouseDown: Boolean;
  protected
    OldX, OldY: single;
    Down: Boolean;

    mmfmk: TFederMessageKind;
    mmX, mmY, mmDelta: single;

    FLastTrack: TBorderTrack;
    RasterR, RasterB: single;
    RasterW, RasterH: single;

    WantLinearMove: Boolean;
    WantLinearZoom: Boolean;
    WantOrbitMode1: Boolean;

    FWheelBetrag: single;
    FWheelValue: single;
    FWheelDelta: single;

    procedure HandleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single); virtual;
    procedure HandleMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single); virtual;
    procedure HandleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: single); virtual;
    procedure HandleNormalMove(Sender: TObject; Shift: TShiftState; X, Y: single); virtual;

    procedure HandleClick(Sender: TObject);
    procedure ClearIdleMoveInfo;
    procedure ViewportChanged;

    function GetViewStatusText1: string;
    function GetViewStatusText2: string;
    function GetViewStatusText3: string;

    procedure HandleTrackMove(X, Y: single);
    procedure UpdateBorderTrack(X, Y: single);
  public
    WantIdleMove: Boolean;
    CameraDummy: TDummy;
    Camera: TControl3D;

    ColorIndex: Integer;
    RotationInfo: TPoint3D;

    PickRadius: single;
    PickX, PickY: single;
    PickShift: TShiftState;

    InitOK: Boolean;

    CameraDummyRotationAngle: TPoint3D;

    constructor Create;
    destructor Destroy; override;

    procedure UpdateMousDownPoint(Value: TPointF);
    procedure UpdateSize(X, Y: single);
    procedure DoOnIdle;

    procedure HandleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure ViewportKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure ViewportKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);

    procedure ViewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);
    procedure ViewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: single);
    procedure ViewportMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single);

    procedure ViewportClick(Sender: TObject);

    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure ImageClick(Sender: TObject);

    procedure Reset; virtual;
    procedure ResetRotation; virtual;
    procedure ResetPosition; virtual;
    procedure ResetZoom; virtual;
    procedure ResetPositionAndRotation; virtual;

    procedure DoZoom(Delta: single); virtual;
    procedure DoZoomTimed(Delta: single); virtual;
    procedure DoZoomTimed3D(Delta: single); virtual;
    procedure DoMM(fmk: TFederMessageKind; X, Y: single);
    procedure DoMMTimed(fmk: TFederMessageKind; X, Y: single); virtual;
    procedure DoMMRemote(fmk: TFederMessageKind; X, Y: single);
    procedure DoParamValueChange(fp: TFederParam; pv: single); virtual; abstract;

    procedure SaveToFederData(fd: TFederData);
    procedure LoadFromFederData(fd: TFederData);

    procedure SaveRotation(fd: TFederData);
    procedure LoadRotation(fd: TFederData);
    procedure LoadEulerAngle(ed: TPoint3D); virtual; abstract;
    function GetRotationInfo: TPoint3D;
    procedure UpdateRotation;

    procedure GotoBlue;
    procedure GotoRed;
    procedure GotoNextColor;
    procedure GotoPrevColor;
    procedure GotoColor;

    procedure AddRasterInfo(ML: TStrings);
    procedure UpdateRasterSize(IsRetina: Boolean; X, Y: single);
    function DoCameraZoom(Delta, CameraPositionZ: single): single;
    function DoPaintboxZoom(Delta, CurrentValue: single): single;

    property Color: TAlphaColor read FColor write SetColor;
    property ColorChanged: TNotifyEvent read FColorChanged write SetColorChanged;
    property ViewStatusText: string read GetViewStatusText;
    property WheelStatusText: string read GetWheelStatusText;

    property MouseDown: Boolean read GetMouseDown;
    property IsClean: Boolean read GetIsClean;
    property MoveMode: Boolean read GetMoveMode write SetMoveMode;
    property OnViewportChanged: TNotifyEvent read GetOnViewportChanged write SetOnViewportChanged;
    property MoveModeText: string read GetMoveModeText;
    property OrbitMode: Boolean read GetOrbitMode write SetOrbitMode;

    property DefaultRX: Integer read GetDefaultRX;
  end;

  TFederFrameBase3D = class(TFederFrameBase)
  protected
    procedure HandleMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: single); override;
  public
    procedure InitWithViewport(vp: TViewport3D);

    procedure LoadEulerAngle(ed: TPoint3D); override;
    procedure DoParamValueChange(fp: TFederParam; pv: single); override;
  end;

  TFederFrameBase2D = class(TFederFrameBase)
  public
    procedure InitWithLayout(vp: TLayout);

    procedure LoadEulerAngle(ed: TPoint3D); override;
    procedure DoParamValueChange(fp: TFederParam; pv: single); override;
  end;

implementation

uses
  RiggVar.App.Main;

{ TEulerAngle }

function TEulerAngle.GetHasValue: Boolean;
begin
  result := HasX and HasY and HasZ;
end;

function TEulerAngle.GetRotation: TPoint3D;
begin
  result.X := FX;
  result.Y := FY;
  result.Z := FZ;
end;

procedure TEulerAngle.Reset;
begin
  HasX := False;
  HasY := False;
  HasZ := False;
  FX := 0;
  FY := 0;
  FZ := 0;
end;

procedure TEulerAngle.SetRotation(const Value: TPoint3D);
begin
  X := Value.X;
  Y := Value.Y;
  Z := Value.Z;
end;

procedure TEulerAngle.SetX(const Value: single);
begin
  FX := Value;
  HasX := True;
end;

procedure TEulerAngle.SetY(const Value: single);
begin
  FY := Value;
  HasY := True;
end;

procedure TEulerAngle.SetZ(const Value: single);
begin
  FZ := Value;
  HasZ := True;
end;

procedure TEulerAngle.Wrap;
begin
//  if FX = 180 then
//    FX := 0;
  if FY = 90 then
    FY := 0;
  if FZ = 180 then
    FZ := 0;
end;

{ TFederFrame3D }

constructor TFederFrameBase.Create;
begin
  inherited;
  SB := TStringBuilder.Create;
  WantIdleMove := True;
  FWheelBetrag := MainVar.Transform3D.GlobalZoom;
  PickRadius := 4;
  WantOrbitMode1 := True;
end;

destructor TFederFrameBase.Destroy;
begin
  SB.Free;
  inherited;
end;

procedure TFederFrameBase.DoMM(fmk: TFederMessageKind; X, Y: single);
begin
  if InitOK then
  begin
    case fmk of
      fmkTX, fmkTY:
      begin
        mmfmk := fmk;
        mmX := mmX - X * 0.1;
        mmY := mmY + Y * 0.1;
      end;

      fmkRX, fmkRY:
      begin
        mmfmk := fmk;
        mmX := mmX - Y * 0.2;
        mmY := mmY - X * 0.2;
      end;

      fmkRZ:
      begin
        mmfmk := fmk;
        mmX := mmX + X * 0.2;
      end;
    end;
  end;
end;

function TFederFrameBase.GetMouseDown: Boolean;
begin
  result := Down;
end;

function TFederFrameBase.GetMoveMode: Boolean;
begin
  result := WantLinearMove;
end;

function TFederFrameBase.GetMoveModeText: string;
begin
  if MoveMode then
  begin
    if Main.IsPhone then
      result := 'mm'
    else
      result := 'Fine move'
  end
  else
    result := ''; // normal move
end;

function TFederFrameBase.GetOnViewportChanged: TNotifyEvent;
begin
  result := FOnViewportChanged;
end;

function TFederFrameBase.GetOrbitMode: Boolean;
begin
  result := WantOrbitMode1;
end;

procedure TFederFrameBase.SetMoveMode(const Value: Boolean);
begin
  WantLinearMove := Value;
  WantLinearZoom := Value;
end;

function TFederFrameBase.GetDefaultRX: Integer;
begin
  result := 180;
end;

function TFederFrameBase.GetIsClean: Boolean;
begin
  result := mmfmk = fmkNoop;
end;

procedure TFederFrameBase.AddRasterInfo(ML: TStrings);
begin
  ML.Add(Format('RasterR = %6.2f', [RasterR]));
  ML.Add(Format('RasterW = %6.2f', [RasterW]));
  ML.Add(Format('RasterB = %6.2f', [RasterB]));
  ML.Add(Format('RasterH = %6.2f', [RasterH]));
end;

procedure TFederFrameBase.ClearIdleMoveInfo;
begin
  mmfmk := fmkNoop;
  mmX := 0;
  mmY := 0;
  mmDelta := 0;
end;

procedure TFederFrameBase.UpdateRasterSize(IsRetina: Boolean; X, Y: single);
begin
  RasterW := X;
  RasterH := Y;
  RasterR := RasterW - MainVar.Raster;
  RasterB := RasterH - MainVar.Raster;
end;

procedure TFederFrameBase.UpdateBorderTrack(X, Y: single);
var
  MVR: single;
begin
  FLastTrack := btNoop;

  MVR := MainVar.Raster;

  { Inside}
  if (X > MVR) and (X < RasterR) and (Y > MVR) and (Y < RasterB) then
    FLastTrack := btInside

  { Outside }
  else if (X < 0) or (X > RasterW) or (Y < 0) or (Y > RasterH) then
    FLastTrack := btOutside

  { Corner }
  else if (X < MVR) and (Y < MVR) then
    FLastTrack := btTopLeft
  else if (X > RasterR) and (Y < MVR) then
    FLastTrack := btTopRight
  else if (X < MVR) and (Y > RasterB) then
    FLastTrack := btBottomLeft
  else if (X > RasterR) and (Y > RasterB) then
    FLastTrack := btBottomRight

  { Bar }
  else if Y < MVR then
    FLastTrack := btTop
  else if Y > RasterB then
    FLastTrack := btBottom
  else if X < MVR then
    FLastTrack := btLeft
  else if X > RasterR then
    FLastTrack := btRight;
end;

procedure TFederFrameBase.UpdateMousDownPoint(Value: TPointF);
begin
  OldX := Value.X;
  OldY := Value.Y;
end;

procedure TFederFrameBase.HandleTrackMove(X, Y: single);
begin
  if FLastTrack = btBottom then
  begin
    if Abs(X - OldX) > 0 then
    begin
      DoZoom((OldX-X) / 20);
      OldX := X;
      OldY := Y;
    end;
  end
  else if FLastTrack = btTop then
  begin
    if Abs(X - OldX) > 0 then
    begin
      DoMM(fmkRZ, (X-OldX) / 1, 0);
      OldX := X;
      OldY := Y;
    end;
  end
  else if FLastTrack = btLeft then
  begin
    if (Round(Abs(Y - OldY)) div 8) > 0 then
    begin
      Main.DoBigWheel(OldY - Y);
      OldX := X;
      OldY := Y;
    end;
  end
  else if FLastTrack = btRight then
  begin
    if (Round(Abs(Y - OldY)) div 8) > 0 then
    begin
      Main.DoSmallWheel(OldY - Y);
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

procedure TFederFrameBase.HandleClick(Sender: TObject);
begin
  //on iPod Touch (with Retina display)
  //only topleft quarter of the screen generates click events
  UpdateBorderTrack(OldX, OldY);
//  case FLastTrack of
//    btTopLeft: Main.ActionHandler.Execute(faHubM);
//    btTopRight: Main.ActionHandler.Execute(faHubP);
//    btBottomLeft: Main.ActionHandler.Execute(faSampleM);
//    btBottomRight: Main.ActionHandler.Execute(faSampleP);
//  end;
end;

procedure TFederFrameBase.SetOnViewportChanged(const Value: TNotifyEvent);
begin
  FOnViewportChanged := Value;
end;

procedure TFederFrameBase.SetOrbitMode(const Value: Boolean);
begin
  WantOrbitMode1 := Value;
  if WantOrbitMode1 then
  begin
    CameraDummyRotationAngle := CameraDummy.RotationAngle.Point;
  end
  else
  begin
    CameraDummyRotationAngle := TPoint3D.Zero;
  end;
end;

procedure TFederFrameBase.ViewportChanged;
begin
  if Assigned(OnViewportChanged) then
    OnViewportChanged(nil);
end;

procedure TFederFrameBase.ViewportMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  HandleMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TFederFrameBase.ViewportMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  HandleMouseMove(Sender, Shift, X, Y);
end;

procedure TFederFrameBase.ViewportMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  HandleMouseUp(Sender, Button, Shift, X, Y);
  Main.SpecialDoOnMouseUp(X, Y);
end;

procedure TFederFrameBase.ImageClick(Sender: TObject);
begin
  HandleClick(Sender);
end;

procedure TFederFrameBase.ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos: TVector3D; RayDir: TVector3D);
begin
  HandleMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TFederFrameBase.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single; RayPos: TVector3D; RayDir: TVector3D);
begin
  HandleMouseMove(Sender, Shift, X, Y);
end;

procedure TFederFrameBase.ImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos: TVector3D; RayDir: TVector3D);
begin
  HandleMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TFederFrameBase.HandleMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  OldX := X;
  OldY := Y;
  PickX := X;
  PickY := Y;
  ClearIdleMoveInfo;
  UpdateBorderTrack(X, Y);
  Down := True;
end;

procedure TFederFrameBase.HandleMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  FLastTrack := btNoop;
  Down := False;
  Main.FederText.OwnsMouse := False;

//  if Main.IsInputClient then
//    Main.DoEulerSync;
  if Main.CanPick then
  begin
    PickShift := Shift;
    if (Abs(X - PickX) < PickRadius) and (Abs(Y - PickY) < PickRadius)  then
      Main.PickRing(X, Y);
  end;
end;

procedure TFederFrameBase.HandleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  if InitOK then
  begin
    if not Main.FederText.FrameVisible then
    begin
      UpdateBorderTrack(X, Y);
      if Down then
      begin
        if FLastTrack <> btInside then
          HandleTrackMove(X, Y)
        else
          HandleNormalMove(Sender, Shift, X, Y);
      end;
    end
    else
      HandleNormalMove(Sender, Shift, X, Y);
  end;
end;

procedure TFederFrameBase.HandleNormalMove(Sender: TObject; Shift: TShiftState; X, Y: single);
var
  ldx, ldy: single;
  rx, ry: Integer;
begin
  if InitOK and Down and not Main.FederText.OwnsMouse then
  begin
    ldx := X - OldX;
    ldy := Y - OldY;
    rx := Round(ldx);
    ry := Round(ldy);

    if Main.LightMode then
    begin
      if WantIdleMove then
      begin
        mmfmk := fmkRX;
        mmX := X;
        mmY := Y;
        OldX := X;
        OldY := Y;
      end
      else
      begin
        Main.FederScene.MoveLight(X, Y);
      end;
    end
    else if (ssCtrl in Shift) and (ssLeft in Shift) then
    begin
      { Pan }
      if WantLinearMove then
      begin
        Camera.Position.X := Camera.Position.X - ldx * 0.01;
        Camera.Position.Y := Camera.Position.Y + ldy * 0.01;
      end
      else
      begin
        Camera.Position.X := Camera.Position.X - ldx * 0.1;
        Camera.Position.Y := Camera.Position.Y + ldy * 0.1;
      end;
      OldX := X;
      OldY := Y;
    end
    else if (ssLeft in Shift) then
    begin
      if WantLinearMove and (FWheelValue > 1) then
        FMouseRotationSpeed := 0.2 / FWheelValue
      else
        FMouseRotationSpeed := 0.2;

      if WantIdleMove then
      begin
        mmfmk := fmkRX;
        mmX := mmX + ldy * FMouseRotationSpeed;
        mmY := mmY + ldx * FMouseRotationSpeed;
        OldX := X;
        OldY := Y;
      end
      else
      begin
        if ry <> 0 then
        begin
          CameraDummyRotationAngle.X := CameraDummyRotationAngle.X - ldy * FMouseRotationSpeed;
          UpdateRotation;
        end;
        if rx <> 0 then
        begin
          CameraDummyRotationAngle.Y := CameraDummyRotationAngle.Y - ldx * FMouseRotationSpeed;
          UpdateRotation;
        end;
        OldX := X;
        OldY := Y;
        RotationInfo := GetRotationInfo;
        ViewportChanged;
      end;
    end
    else if (ssRight in Shift) then
    begin
      if rx <> 0 then
      begin
        CameraDummyRotationAngle.Z := CameraDummyRotationAngle.Z + ldx * 0.3;
        UpdateRotation;
      end;
      OldX := X;
      OldY := Y;
      RotationInfo := GetRotationInfo;
      ViewportChanged;
    end;
  end;

  { needed for rpRotationInfo and rpLightInfo }
  if Down and (Main.ActionHandler.ReportPage in [rpRotationInfo, rpMatrixInfo, rpLightInfo, rpZoomInfo]) then
//    Main.FederText.UpdateText
//  else
    Main.TextUpdateNeeded;
end;

procedure TFederFrameBase.DoMMRemote(fmk: TFederMessageKind; X, Y: single);
begin
  if InitOK then
  begin
    case fmk of
      fmkTX, fmkTY:
      begin
        Camera.Position.X := Camera.Position.X + X * 0.1;
        Camera.Position.Y := Camera.Position.Y + Y * 0.1;
      end;

      fmkRX, fmkRY:
      begin
        CameraDummyRotationAngle.X := CameraDummyRotationAngle.X + Y * 0.2;
        CameraDummyRotationAngle.Y := CameraDummyRotationAngle.Y + X * 0.2;
        UpdateRotation;
        ViewportChanged;
      end;

      fmkRZ:
      begin
        CameraDummyRotationAngle.Z := CameraDummyRotationAngle.Z + X * 0.3;
        UpdateRotation;
        ViewportChanged;
      end;
    end;
  end;
end;

procedure TFederFrameBase.DoMMTimed(fmk: TFederMessageKind; X, Y: Single);
begin
  if InitOK then
  begin
    case fmk of
      fmkTX, fmkTY:
      begin
        Camera.Position.X := Camera.Position.X - X;
        Camera.Position.Y := Camera.Position.Y + Y;
      end;

      fmkRX, fmkRY:
      begin
        if Main.LightMode then
        begin
          Main.FederScene.MoveLight(X, Y);
          ViewportChanged;
        end
        else
        begin
          CameraDummyRotationAngle.X := CameraDummyRotationAngle.X - X;
          CameraDummyRotationAngle.Y := CameraDummyRotationAngle.Y - Y;
          UpdateRotation;
          ViewportChanged;
        end;
      end;

      fmkRZ:
      begin
        CameraDummyRotationAngle.Z := CameraDummyRotationAngle.Z + X;
        UpdateRotation;
        ViewportChanged;
      end;
    end;
  end;
  ClearIdleMoveInfo;
end;

procedure TFederFrameBase.DoZoom(Delta: single);
begin
  mmfmk := fmkCZ;
  mmDelta := mmDelta + Delta;
end;

procedure TFederFrameBase.DoZoomTimed(Delta: single);
var
  temp: single;
begin
  if Delta <> 0 then
  begin
    temp := Delta;
    if WantLinearMove then
      temp := Delta * 0.5;
    DoZoomTimed3D(temp);
    ClearIdleMoveInfo;
  end;
end;

procedure TFederFrameBase.DoZoomTimed3D(Delta: single);
var
  v: TPoint3D;
  l: single;
begin
  if InitOK then
  begin
    if Delta > 3 then
      Delta := 3;
    if Delta < -3 then
      Delta := -3;

    l := DoCameraZoom(Delta, Camera.Position.Z);

    v := TPoint3D.Create(0, 0, 1);
    v.X := Camera.Position.X;
    v.Y := Camera.Position.Y;
    v.Z := l;

    Camera.Position.Point := v;

    ViewportChanged;
  end;
end;

procedure TFederFrameBase.ViewportClick(Sender: TObject);
begin
  HandleClick(Sender);
end;

procedure TFederFrameBase.DoOnIdle;
begin
  if mmfmk = fmkCZ then
    DoZoomTimed(mmDelta)
  else
    DoMMTimed(mmfmk, mmX, mmY);

    Main.UpdateViewParamValue;

    { needed for rpRotationInfo and rpLightInfo }
    if Main.TextUpdatingNeeded then
    begin
      Main.FederText.UpdateText;
      Main.TextUpdatingNeeded := False;
    end;
end;

procedure TFederFrameBase.HandleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  if Main.LightMode then
  begin
    Main.FederScene.MoveLightZ(ssShift in Shift, WheelDelta);
  end
  else if (ssCtrl in Shift) and (ssShift in Shift) then
  begin
    Main.DoRasterWheel(WheelDelta);
  end
  else if ssShift in Shift then
  begin
    Main.DoBigWheel(WheelDelta);
  end
  else if ssCtrl in Shift then
  begin
    DoZoomTimed(WheelDelta/120);
  end
  else
  begin
    Main.DoSmallWheel(WheelDelta);
  end;
  Handled := True;
end;

procedure TFederFrameBase.ViewportKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Main.IsUp then
    Main.ActionHandler.ViewportKeyDown(Sender, Key, KeyChar, Shift);
end;

procedure TFederFrameBase.ViewportKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Main.IsUp then
    Main.ActionHandler.ViewportKeyUp(Sender, Key, KeyChar, Shift);
end;

procedure TFederFrameBase.UpdateSize(X, Y: single);
begin
  RasterW := X;
  RasterH := Y;
  RasterR := RasterW - MainVar.Raster;
  RasterB := RasterH - MainVar.Raster;
end;

procedure TFederFrameBase.Reset;
begin
  if (CameraDummy = nil) or (Camera = nil) then
    Exit;

  CameraDummy.Position.X := 0;
  CameraDummy.Position.Y := 0;
  CameraDummy.Position.Z := 0;

  CameraDummy.ResetRotationAngle;
  CameraDummyRotationAngle.X := DefaultRX;
  CameraDummyRotationAngle.Y := 0;
  CameraDummyRotationAngle.Z := 0;
  UpdateRotation;

  Camera.Position.X := 0.0;
  Camera.Position.Y := 0.0;
  Camera.Position.Z := MainVar.Transform3D.GlobalZoom;

  Camera.ResetRotationAngle;
  Camera.RotationAngle.X := 180;
  Camera.RotationAngle.Y := 0;
  Camera.RotationAngle.Z := 0;

  FWheelBetrag := Camera.Position.Z;
end;

procedure TFederFrameBase.ResetPositionAndRotation;
begin
  if (CameraDummy = nil) or (Camera = nil) then
    Exit;

  CameraDummy.Position.X := 0;
  CameraDummy.Position.Y := 0;
  CameraDummy.Position.Z := 0;

  CameraDummy.ResetRotationAngle;
  CameraDummyRotationAngle.X := DefaultRX;
  CameraDummyRotationAngle.Y := 0;
  CameraDummyRotationAngle.Z := 0;
  UpdateRotation;

  Camera.Position.X := 0.0;
  Camera.Position.Y := 0.0;

  Camera.ResetRotationAngle;
  Camera.RotationAngle.X := 180;
  Camera.RotationAngle.Y := 0;
  Camera.RotationAngle.Z := 0;
end;

procedure TFederFrameBase.ResetRotation;
begin
  if (CameraDummy = nil) or (Camera = nil) then
    Exit;

  CameraDummy.ResetRotationAngle;
  CameraDummyRotationAngle.X := DefaultRX;
  CameraDummyRotationAngle.Y := 0;
  CameraDummyRotationAngle.Z := 0;

  Camera.ResetRotationAngle;
  Camera.RotationAngle.X := 180;
  Camera.RotationAngle.Y := 0;
  Camera.RotationAngle.Z := 0;
end;

procedure TFederFrameBase.ResetPosition;
begin
  if (CameraDummy = nil) or (Camera = nil) then
    Exit;

  CameraDummy.Position.X := 0;
  CameraDummy.Position.Y := 0;
  CameraDummy.Position.Z := 0;

  Camera.Position.X := 0.0;
  Camera.Position.Y := 0.0;
end;

procedure TFederFrameBase.ResetZoom;
begin
  if (CameraDummy = nil) or (Camera = nil) then
    Exit;

  Camera.Position.Z := MainVar.Transform3D.GlobalZoom;
end;

function TFederFrameBase.GetViewStatusText: string;
begin
  result := GetViewStatusText1;
end;

function TFederFrameBase.GetViewStatusText1: string;
var
  ft: string;
  fs: string;
begin
  if Assigned(CameraDummy) then
  begin
    ft := ' (%.2f %.2f %.2f)';
    fs := Format('XY%s CP%s CR%s', [ft, ft, ft]);
    result := Format(fs, [
    CameraDummyRotationAngle.X, //Rotation X, 0 (RG) or 180 (FC)
    CameraDummyRotationAngle.Y, //Rotation Y
    CameraDummyRotationAngle.Z, //Rotation Z
    Camera.Position.X, //always 0
    Camera.Position.Y, //always 0
    Camera.Position.Z, //MouseWheel
    Camera.RotationAngle.X, //always 180
    Camera.RotationAngle.Y, //always 0
    Camera.RotationAngle.Z //always 0
    ]);
  end;
end;

function TFederFrameBase.GetViewStatusText2: string;
var
  ft: string;
  fs: string;
begin
  if Assigned(CameraDummy) then
  begin
  ft := '%.2f';
  fs := Format('RX %s RY %s RZ %s Wheel %s', [ft, ft, ft, ft]);
  result := Format(fs, [
  CameraDummyRotationAngle.X,
  CameraDummyRotationAngle.Y,
  CameraDummyRotationAngle.Z,
  Camera.Position.Z
  ]);
  end
  else
    result := '';
end;

function TFederFrameBase.GetViewStatusText3: string;
var
  ft: string;
begin
  SB.Clear;
  if Assigned(CameraDummy) then
  begin
    ft := '%s %.2f';
    SB.AppendLine(Format(ft, ['RX', CameraDummyRotationAngle.X]));
    SB.AppendLine(Format(ft, ['RY', CameraDummyRotationAngle.Y]));
    SB.AppendLine(Format(ft, ['RZ', CameraDummyRotationAngle.Z]));
    SB.AppendLine(Format(ft, ['CZ', Camera.Position.Z]));
  end;
  result := SB.ToString;
end;

procedure TFederFrameBase.SaveToFederData(fd: TFederData);
begin
  SaveRotation(fd);
end;

procedure TFederFrameBase.LoadFromFederData(fd: TFederData);
begin
  LoadRotation(fd);
end;

procedure TFederFrameBase.SaveRotation(fd: TFederData);
var
  p: TPoint3D;
begin
  p := GetRotationInfo;
  fd.AngleX := -p.X;
  fd.AngleY := -p.Y;
  fd.AngleZ := -p.Z;
  if Camera <> nil then
  begin
  fd.PosX := Camera.Position.X;
  fd.PosY := Camera.Position.Y;
  fd.PosZ := Camera.Position.Z;
  end
  else
  begin
    fd.PosX := 0;
    fd.PosY := 0;
    fd.PosZ := -10.49;
  end;
end;

procedure TFederFrameBase.LoadRotation(fd: TFederData);
begin
  if Assigned(CameraDummy) then
  begin
    Reset;

    CameraDummyRotationAngle.X := fd.AngleX;
    CameraDummyRotationAngle.Y := fd.AngleY;
    CameraDummyRotationAngle.Z := fd.AngleZ;
    CameraDummy.RotationAngle.Point := TPoint3D.Zero;
    UpdateRotation;

    Camera.Position.X := fd.PosX;
    Camera.Position.Y := fd.PosY;

    if Main.WantPosZ12 then
    begin
    if fd.PosZ2 > 0 then
      Camera.Position.Z := fd.PosZ2
    else if fd.PosZ1 > 0 then
      Camera.Position.Z := fd.PosZ1
    else
      Camera.Position.Z := fd.PosZ;
    end
    else
      Camera.Position.Z := fd.PosZ;

    FWheelBetrag := Camera.Position.Z;
  end;
end;

function TFederFrameBase.GetRotationInfo: TPoint3D;
var
  rm: TMatrix3D;
  ax, ay, az: single;
  mt: single;
  ayt: single;
begin
  if CameraDummy = nil then
    Exit;

  rm := CameraDummy.LocalMatrix;

  ay := arctan2(-rm.m31, sqrt(sqr(rm.m32) + sqr(rm.m33)));

  mt := rm.m31;
  { argument mt for ArcSin function must be in range -1..1 }
  if mt > 1 then
    mt := 1
  else if rm.m31 < -1 then
    mt := -1;
  ayt := -ArcSin(mt);
  if TUtils.IsEssentiallyZero(ayt) then
  begin
    az := 0;
    ay := 0;
    ax := 0;
    if (CameraDummyRotationAngle.Y = 0)
    and  (CameraDummyRotationAngle.Z = 0)
    then
    begin
      ax := CameraDummyRotationAngle.X;
      if ax > 180 then
        ax := ax - 360;
      ax := DegToRad(ax);
      ax := -ax;
    end
    else if (CameraDummyRotationAngle.X = 180)
    and  (CameraDummyRotationAngle.Y = 0)
    then
    begin
      ax := DegToRad(180);
      az := CameraDummyRotationAngle.Z;
      if az > 180 then
        az := az - 360;
      az := DegToRad(az);
      az := -az;
    end
  end
  else
  begin
    ax := arctan2(rm.m32, rm.m33);
    az := arctan2(rm.m21, rm.m11);
  end;

  result.X := RadToDeg(ax);
  result.Y := RadToDeg(ay);
  result.Z := RadToDeg(az);
end;

function TFederFrameBase.GetWheelStatusText: string;
begin
  result := Format('Wheel %.2f Delta %.2f', [FWheelBetrag, FWheelDelta]);
end;

function TFederFrameBase.DoCameraZoom(Delta, CameraPositionZ: single): single;
var
  l: single;
begin
  FWheelValue := Abs(CameraPositionZ);
  FWheelDelta := 0.2 * Delta;

  if (Abs(FWheelValue) >= 0.5) then
  begin
    if WantLinearZoom and (Abs(FWheelValue) > 1) then
      FWheelDelta := Sign(FWheelDelta) * 0.05
    else
      FWheelDelta := MainVar.Transform3D.GlobalZoomSpeed * FWheelValue * Delta; //<-- normal
  end
  else
    FWheelValue := 0.5;

  l := FWheelBetrag + FWheelDelta;

  if (l < MainVar.Transform3D.GlobalZoomMin) then
    l := MainVar.Transform3D.GlobalZoomMin
  else if (l > MainVar.Transform3D.GlobalZoomMax) then
    l := MainVar.Transform3D.GlobalZoomMax;

  result := l;
  FWheelBetrag := l;
end;

function TFederFrameBase.DoPaintboxZoom(Delta, CurrentValue: single): single;
var
  t: single;
begin
  t := CurrentValue;
  if WantLinearZoom then
    t := t - 0.01 * Delta
  else
    t := t - 0.1 * Delta;
  if t < 0.1 then
    t := 0.1;
  if t > 100 then
    t := 100;
  result := t;
end;

procedure TFederFrameBase.GotoRed;
begin
  Color := claRed;
end;

procedure TFederFrameBase.GotoBlue;
begin
  Color := claBlue;
end;

procedure TFederFrameBase.GotoPrevColor;
begin
  Dec(ColorIndex);
  if ColorIndex < 0 then
    ColorIndex := 6;
  GotoColor;
end;

procedure TFederFrameBase.GotoNextColor;
begin
  Inc(ColorIndex);
  if ColorIndex > 6 then
    ColorIndex := 0;
  GotoColor;
end;

procedure TFederFrameBase.GotoColor;
var
  cla: TAlphaColor;
begin
  case ColorIndex of
    1: cla := claRed;
    2: cla := claGreen;
    3: cla := claBlue;
    4: cla := claMagenta;
    5: cla := claCyan;
    6: cla := claYellow;
    else
      cla := claWhite;
  end;
  Color := cla;
end;

procedure TFederFrameBase.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
  if Assigned(ColorChanged) then
    ColorChanged(self);
end;

procedure TFederFrameBase.SetColorChanged(const Value: TNotifyEvent);
begin
  FColorChanged := Value;
end;

procedure TFederFrameBase.UpdateRotation;
var
  dP: TPoint3D;
begin
  dP := CameraDummyRotationAngle;

  if OrbitMode then
  begin
    CameraDummy.ResetRotationAngle;
    CameraDummy.RotationAngle.Point := CameraDummyRotationAngle;
  end
  else
  begin
    CameraDummy.RotationAngle.X := CameraDummy.RotationAngle.X + dP.X;
    CameraDummy.RotationAngle.Y := CameraDummy.RotationAngle.Y + dP.Y;
    CameraDummy.RotationAngle.Z := CameraDummy.RotationAngle.Z + dP.Z;
    CameraDummyRotationAngle := TPoint3D.Zero;
  end;
end;

{ TFederFrameBase3D }

procedure TFederFrameBase3D.InitWithViewport(vp: TViewport3D);
begin
  if vp = nil then
    Exit;

  { CameraDummy }
  CameraDummy := TDummy.Create(vp);
  vp.AddObject(CameraDummy);

{$ifdef HasCamera}
 { Camera }
  Camera := TCamera00.Create(vp);
  CameraDummy.AddObject(Camera);
{$ifdef PatchedFMX}
  if Assigned(Camera.Context) then
  begin
    { Context can be nil if Viewport.Size is still (0, 0) }
    Camera.Context.OnPick := Camera.Pick;
    Camera.Context.OnGetMatrix := Camera.GetProjectionMatrix;
  end;
{$endif}
  if Assigned(vp) then
  begin
    vp.Color := MainVar.ColorScheme.claBackground3D;
    vp.Camera := Camera;
    if Main.IsDesktop then
      vp.CanFocus := True;
  end;
{$endif}

  Reset;
end;

procedure TFederFrameBase3D.LoadEulerAngle(ed: TPoint3D);
begin
{$ifdef HasCamera}
  if Assigned(CameraDummy) and (Camera.ViewType = TViewType.Perspective) then
  begin
    CameraDummyRotationAngle := ed;
    UpdateRotation;
  end;
{$endif}
end;

procedure TFederFrameBase3D.DoParamValueChange(fp: TFederParam; pv: single);
begin
  if InitOK then
  case fp of
    fprx:
    begin
      CameraDummyRotationAngle.X := Round(pv) mod 360;
      UpdateRotation;
    end;
    fpry:
    begin
      CameraDummyRotationAngle.Y := Round(pv) mod 360;
      UpdateRotation;
    end;
    fprz:
    begin
      CameraDummyRotationAngle.Z := Round(pv) mod 360;
      UpdateRotation;
    end;
    fptx:
    begin
      if Abs(pv) < 100 then
        Camera.Position.X := pv;
    end;
    fpty:
    begin
      if Abs(pv) < 100 then
        Camera.Position.Y := pv;
    end;
    fpcz:
    begin
      if (pv >= MainVar.Transform3D.GlobalZoomMin) and (pv <= MainVar.Transform3D.GlobalZoomMax) then
        Camera.Position.Z := pv;
    end;
    fppx:
    begin
      Camera.Position.X := pv / 20;
    end;
    fppy:
    begin
      Camera.Position.Y := pv / 20;
    end;
  end
  else
  begin
    //Main.Logger.Info('...');
  end;
  ClearIdleMoveInfo;
end;

procedure TFederFrameBase3D.HandleMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  inherited;

  if Main.IsInputClient then
    Main.DoEulerSync;
  if Main.CanPick then
  begin
    PickShift := Shift;
    if (Abs(X - PickX) < PickRadius) and (Abs(Y - PickY) < PickRadius)  then
      Main.PickRing(X, Y);
  end;
end;

{ TFederFrameBase2D }

procedure TFederFrameBase2D.InitWithLayout(vp: TLayout);
begin
  if Assigned(vp) then
  begin
    if Main.IsDesktop then
      vp.CanFocus := True;
    InitOK := True;
  end;

  CameraDummy := TDummy.Create(vp);
  CameraDummy.Visible := False;
  vp.AddObject(CameraDummy);

  Camera := TControl3D.Create(vp);
  Camera.Visible := False;
  CameraDummy.AddObject(Camera);
end;

procedure TFederFrameBase2D.DoParamValueChange(fp: TFederParam; pv: single);
begin
  ClearIdleMoveInfo;
end;

procedure TFederFrameBase2D.LoadEulerAngle(ed: TPoint3D);
begin

end;

end.
