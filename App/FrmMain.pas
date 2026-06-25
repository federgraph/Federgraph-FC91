unit FrmMain;

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
  RiggVar.FB.ActionConst,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  System.SysUtils,
  System.Classes,
  System.Math,
  System.Math.Vectors,
  System.Messaging,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.RTLConsts,
  FMX.Controls,
  FMX.Controls3D,
  FMX.Graphics,
  FMX.StdCtrls,
  FMX.Platform,
  FMX.Types,
  FMX.Types3D,
  FMX.Forms,
  FMX.Viewport3D,
  FMX.Objects3D,
  FMX.Colors,
  FMX.Objects;

type
  TFormMain = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HandleMouseDown(Shift: TShiftState; X, Y: Single);
    procedure HandleMouseMove(Shift: TShiftState; X, Y: Single);
    procedure ViewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ViewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure ViewportMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    AllowResizing: Boolean;
    Down: TPointF;
    DrawingNeeded: Boolean;
    ExitSizeMoveCounter: Integer;
    FBandColor: TAlphaColor;
    FormShown: Boolean;
    FShowColorPanel: Boolean;
    FrontLight: TLight;
    BackLight: TLight;
    WestLight: TLight;
    EastLight: TLight;
    NorthLight: TLight;
    SouthLight: TLight;
    MouseDown: Boolean;
    ResizeCounter: Integer;
    ZInfoCounter: Integer;
    procedure ActionsBtnClick(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
    procedure ColorPanelChange(Sender: TObject);
    procedure CreateColorPanel;
    procedure CreateHintText;
    procedure DestroyForms;
    procedure DoOnResize;
    procedure DoOrientationChanged(const Sender: TObject; const M: TMessage);
    function GetContentHeight: single;
    function GetContentParent: TFmxObject;
    function GetContentWidth: single;
    function GetIsUp: Boolean;
    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    procedure HandleColorPanelChanged;
    procedure HandleRingWidthChanged;
    procedure Init;
    procedure InitCamera;
    procedure InitColorPanel;
    procedure InitLight;
    procedure InitMesh;
    procedure InitViewport;
    procedure LayoutHintText;
    procedure Log(s: string);
    procedure MemoBtnClick(Sender: TObject);
    procedure RegisterForAppEvents;
    procedure ResizeColorPanel;
    procedure RingPicked(Sender: TObject);
    procedure SetBandColor(const Value: TAlphaColor);
    procedure SetIsUp(const Value: Boolean);
    procedure SetMeshText(const Value: string);
    procedure SetParamText(const Value: string);
    procedure SetRingText(const Value: string);
    procedure SetShowColorPanel(const Value: Boolean);
    procedure SetValueText(const Value: string);
    procedure SetZoomText(const Value: string);
    procedure UpdateHintTextPosition;
    procedure UpdateRotation;
  public
    claBackground: TAlphaColor;
    Camera: TCamera;
    CameraDummy: TDummy;
    CameraDummyRotationAngle: TPoint3D;
    ColorPanel: TColorPanel;
    ColorPanelChanged: Boolean;
    HintText: TText;
    Viewport: TViewport3D;
    WantColorPanel: Boolean;
    procedure DoMM(fmk: TFederMessageKind; X, Y: Single);
    procedure DoZoom(Delta: single);
    procedure FormResizeEnd(Sender: TObject);
    procedure HandleAction(fa: TFederAction);
    procedure HandleKey(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure HandleShowHint(Sender: TObject);
    procedure InitZOrderInfo(ML: TStrings);
    procedure InvalidateGraph(Sender: TObject);
    function MakeScreenshot: TBitmap;
    procedure UpdateBackground;
    procedure ResetCamera;
    procedure ResetRotation;
    procedure ResetPosition;
    procedure ResetZoom;
    procedure ToggleLux;
    procedure UpdateHintText(fa: Integer);
    property BandColor: TAlphaColor read FBandColor write SetBandColor;
    property ContentHeight: single read GetContentHeight;
    property ContentParent: TFmxObject read GetContentParent;
    property ContentWidth: single read GetContentWidth;
    property IsUp: Boolean read GetIsUp write SetIsUp;
    property MeshText: string write SetMeshText;
    property ParamText: string write SetParamText;
    property RingText: string write SetRingText;
    property ShowColorPanel: Boolean read FShowColorPanel write SetShowColorPanel;
    property ValueText: string write SetValueText;
    property ZoomText: string write SetZoomText;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses
  FrmAction,
  FrmMemo,
  RiggVar.App.Main,
  RiggVar.FederModel.TouchBase,
  RiggVar.FB.Action,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Classes;

{ TFormMain }

procedure TFormMain.ActionsBtnClick(Sender: TObject);
begin
  if not Assigned(FormAction) then
  begin
    FormAction := TFormAction.Create(nil);
  end;
  FormAction.Visible := True;
  FormAction.Activate;
end;

procedure TFormMain.ApplicationEventsException(Sender: TObject; E: Exception);
begin
  Log(E.Message);
end;

procedure TFormMain.ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
begin
  if IsUp then
  begin
    if Main <> nil then
    begin
      if not MainVar.AppIsClosing then
      begin
        if Main.BitmapBuilder.RingWidthChanged then
        begin
          HandleRingWidthChanged;
        end
        else if ColorPanelChanged then
        begin
          HandleColorPanelChanged;
        end;

        if DrawingNeeded then
        begin
          DrawingNeeded := False;
          InvalidateGraph(nil);
        end;
      end;
    end;
  end;
  Done := True;
end;

procedure TFormMain.ColorPanelChange(Sender: TObject);
begin
  ColorPanelChanged := True;
end;

procedure TFormMain.CreateColorPanel;
begin
  if WantColorPanel then
  begin
    ColorPanel := TColorPanel.Create(self);
    ColorPanel.Name := 'ColorPanel';
    Self.AddObject(ColorPanel);
    ColorPanel.OnChange := ColorPanelChange;
  end;
end;

procedure TFormMain.CreateHintText;
begin
  HintText := TText.Create(Self);
  HintText.Name := 'HintText';
  HintText.Parent := Self;
  HintText.WordWrap := False;
  HintText.AutoSize := True;
  HintText.HorzTextAlign := TTextAlign.Leading;
  HintText.Font.Family := 'Consolas';
  HintText.Font.Size := 18;
  HintText.Text := 'HintText';
  HintText.TextSettings.FontColor := claYellow;
end;

procedure TFormMain.DestroyForms;
begin
  if FormAction <> nil then
  begin
    FormAction.Free;
    FormAction := nil;
  end;
  if FormMemo <> nil then
  begin
    FormMemo.Free;
    FormMemo := nil;
  end;
end;

procedure TFormMain.DoMM(fmk: TFederMessageKind; X, Y: Single);
begin
  if FormShown then
  begin
    case fmk of
      fmkTX, fmkTY:
      begin
        Camera.Position.X := Camera.Position.X - X * 0.1;
        Camera.Position.Y := Camera.Position.Y + Y * 0.1;
        Down := PointF(X, Y);
      end;

      fmkRX, fmkRY:
      begin
        CameraDummyRotationAngle.X := CameraDummyRotationAngle.X - Y * 0.2;
        CameraDummyRotationAngle.Y := CameraDummyRotationAngle.Y - X * 0.2;
        UpdateRotation;
        Down := PointF(X, Y);
      end;

      fmkRZ:
      begin
        CameraDummyRotationAngle.Z := CameraDummyRotationAngle.Z + X * 0.3;
        UpdateRotation;
        Down := PointF(X, Y);
      end;
    end;
  end;
end;

procedure TFormMain.DoOnResize;
begin
  MainVar.ClientWidth := ClientWidth;
  MainVar.ClientHeight := ClientHeight;

  if IsUp and AllowResizing then
  begin
    Inc(ResizeCounter);
    ResizeColorPanel;

    Main.UpdateTouch;
    Main.UpdateText;
    UpdateHintTextPosition;

//    HandleAction(faNoop);
  end;
end;

procedure TFormMain.DoOrientationChanged(const Sender: TObject; const M: TMessage);
var
  screenService: IFMXScreenService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, screenService) then
  begin
    DrawingNeeded := True;
  end;
end;

procedure TFormMain.DoZoom(Delta: single);
var
  l: single;
  CameraZ: single;
begin
  if FormShown then
  begin
    CameraZ := Camera.Position.Z;

    l := CameraZ - Delta;

    if l < 5 then
      l := 5;
    if l > 30 then
      l := 30;

    Camera.Position.Z := l;
    ZoomText := IntToStr(Round(l));
  end;
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
{$ifdef MSWINDOWS}
  if IsUp then
  begin
    Viewport.SetFocus;
  end;
{$endif}
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, DoOrientationChanged);

  DestroyForms;
  Main.Free;
  Main := nil;
end;

procedure TFormMain.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  i: single;
begin
  if WheelDelta > 0 then
    i := 1
  else if WheelDelta < 0 then
    i := -1
  else
    i := 0;

  if ssCtrl in Shift then
  begin
    DoZoom(i);
  end
  else
  begin
    if ssShift in Shift then
      Main.DoBigWheel(i)
    else
      Main.DoSmallWheel(i);
  end;
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  DoOnResize;
end;

procedure TFormMain.FormResizeEnd(Sender: TObject);
begin
  Inc(ExitSizeMoveCounter);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  if not FormShown then
  begin
    FormShown := True;
    Main.IsUp := True;

    UpdateBackground;
    Viewport.SetFocus;

    Main.TextUpdateNeeded;
    Main.BubbleUpAction(faNoop);
  end;
end;

function TFormMain.GetContentHeight: single;
begin
  if Assigned(Viewport) then
    result := Viewport.Height
  else
    result := ClientHeight;
end;

function TFormMain.GetContentParent: TFmxObject;
begin
  result := Viewport;
end;

function TFormMain.GetContentWidth: single;
begin
  if Assigned(Viewport) then
    result := Viewport.Width
  else
    result := ClientWidth;
end;

function TFormMain.GetIsUp: Boolean;
begin
  if not MainVar.AppIsClosing and (Main <> nil) then
    result := Main.IsUp
  else
    result := False;
end;

procedure TFormMain.HandleAction(fa: TFederAction);
begin
  case fa of
    faShowActions: ActionsBtnClick(nil);
    faShowMemo: MemoBtnClick(nil);
  end;

  if Main.GraphUpdatingNeeded then
  begin
    Main.GraphUpdatingNeeded := False;
    InvalidateGraph(nil);
  end;

  if Main.StateCheckingNeeded then
  begin
    Main.FederText.CheckState;
    Main.StateCheckingNeeded := False;
  end;

  if Main.FlashClearingNeeded then
  begin
    Main.FederText.ClearFlash;
    Main.FlashClearingNeeded := False;
  end;

  if Main.TextUpdatingNeeded then
  begin
    Main.FederText.UpdateText;
    Main.TextUpdatingNeeded := False;
  end;

  UpdateHintText(fa);
end;

function TFormMain.HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
begin
  case AAppEvent of
    TApplicationEvent.FinishedLaunching:
    begin
      Log('Finished Launching');
      DrawingNeeded := True;
    end;
    TApplicationEvent.BecameActive:
    begin
      Log('Became Active');
      DrawingNeeded := True;
    end;
    TApplicationEvent.WillBecomeInactive:
    begin
//      MainVar.ShouldRecycleSocket := True;
      Log('Will Become Inactive');
    end;
    TApplicationEvent.EnteredBackground:
    begin
//      MainVar.ShouldRecycleSocket := True;
      Log('Entered Background');
    end;
    TApplicationEvent.WillBecomeForeground:
    begin
      Log('Will Become Foreground');
    end;
    TApplicationEvent.WillTerminate:
    begin
      Log('Will Terminate');
    end;
    TApplicationEvent.LowMemory:
    begin
      Log('Low Memory');
    end;
    TApplicationEvent.TimeChange:
    begin
      Log('Time Change');
    end;
    TApplicationEvent.OpenURL:
    begin
      Log('Open URL');
    end;
  end;
  result := True;
end;

procedure TFormMain.HandleColorPanelChanged;
var
  ring: Integer;
begin
  if IsUp then
  begin
    ring := Round(Main.CurrentRing);
    if ring = 0 then
      ring := Round(Main.FederModel._fp6);
    if ring < 1 then
      ring := 1;
    if ring > StripConst.StripCount then
      ring := StripConst.StripCount;

    Main.BitmapBuilder.UpdatingRings := True;
    Main.RingColor[ring] := ColorPanel.Color;
    Main.Bitmap := Main.Bitmap;
    Main.BitmapBuilder.UpdatingRings := False;
    InvalidateGraph(nil);
  end;
  ColorPanelChanged := False;
end;

procedure TFormMain.HandleKey(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if KeyChar = '{' then
    Main.MeshSize := 32
  else if KeyChar = '}' then
    Main.MeshSize := 64
  else if KeyChar = '(' then
    Main.MeshSize := 128
  else if KeyChar = ')' then
    Main.MeshSize := 256

  else if Key = vkEscape then
    Main.DoReset

  else if KeyChar = 'E' then
    Main.ExportObj

  else if KeyChar = '+' then
  begin
    Main.ActionHandler.Execute(faActionPageP);
    Exit;
  end

  else if KeyChar = '*' then
  begin
    Main.ActionHandler.Execute(faActionPageM);
    Exit;
  end

  else if KeyChar = 'h' then
  begin
    Main.ActionHandler.Execute(faToggleSolidFlip);
    Exit;
  end

  else if KeyChar = ' ' then
  begin
    Main.ActionHandler.Execute(faToggleShowEdges);
    Exit;
  end

  else if KeyChar = 'l' then
  begin
    Main.ActionHandler.Execute(faToggleLux);
    Exit;
  end

  else if KeyChar = 'b' then
  begin
    Main.ActionHandler.Execute(faWantBottom);
    Exit;
  end

  else if KeyChar = 'y' then
  begin
    Main.ActionHandler.Execute(faWantSpecialY);
    Exit;
  end

  else if KeyChar = 'C' then
  begin
    Main.ActionHandler.Execute(faToggleColorPanel);
    Exit;
  end

  else if Key = vkLeft then
  begin
    Main.ActionHandler.Execute(faWheelLeft);
    Exit;
  end

  else if Key = vkRight then
  begin
    Main.ActionHandler.Execute(faWheelRight);
    Exit;
  end

  else if Key = vkUp then
  begin
    Main.ActionHandler.Execute(faWheelUp);
    Exit;
  end

  else if Key = vkDown then
  begin
    Main.ActionHandler.Execute(faWheelDown);
    Exit;
  end

  else if KeyChar = 'c' then
    Main.FederParam := fpParamCapValue
  else if KeyChar = 'n' then
    Main.FederParam := fpNorthCapValue
  else if KeyChar = 's' then
    Main.FederParam := fpSouthCapValue
  else if KeyChar = 't' then
    Main.FederParam := fpT1
  else if KeyChar = 'T' then
    Main.FederParam := fpT2
  else if KeyChar = 'L' then
    Main.FederParam := fpL
  else if KeyChar = 'R' then
    Main.FederParam := fpAbsoluteRange

  ;

  Main.CheckStateNeeded;
  Main.TextUpdateNeeded;
  Main.GraphUpdateNeeded;

  Main.BubbleUpAction(faNoop);
end;

procedure TFormMain.HandleMouseDown(Shift: TShiftState; X, Y: Single);
begin
  Down := PointF(X, Y);
  if Main.FederMesh.Parent <> nil then
    Main.FederMesh.PickRing(X, Y);
end;

procedure TFormMain.HandleMouseMove(Shift: TShiftState; X, Y: Single);
begin
  if FormShown then
  begin
    if (ssCtrl in Shift) and (ssLeft in Shift) then
    begin
      Camera.Position.X := Camera.Position.X - ((X - Down.X) * 0.04);
      Camera.Position.Y := Camera.Position.Y + ((Y - Down.Y) * 0.04);
      Down := PointF(X, Y);
    end
    else if ssLeft in Shift then
    begin
      CameraDummyRotationAngle.X := CameraDummyRotationAngle.X - ((Y - Down.Y) * 0.2);
      CameraDummyRotationAngle.Y := CameraDummyRotationAngle.Y - ((X - Down.X) * 0.2);
      UpdateRotation;
      Down := PointF(X, Y);
    end
    else if ssRight in Shift then
    begin
      CameraDummyRotationAngle.Z := CameraDummyRotationAngle.Z + ((X - Down.X) * 0.3);
      UpdateRotation;
      Down := PointF(X, Y);
    end;

    if Main.CurrentReportPage = rpViewStatus then
    begin
      Main.TextUpdateNeeded;
      Main.BubbleUpAction(faNoop);
    end;
  end;
end;

procedure TFormMain.HandleRingWidthChanged;
begin
  Main.UpdateRings;
  Main.BitmapBuilder.UpdateReason := TUpdateReason.cuParamBandWidth;
  Main.BitmapBuilder.RingWidthChanged := False;
  InvalidateGraph(nil);
end;

procedure TFormMain.HandleShowHint(Sender: TObject);
begin
{$ifdef MSWINDOWS}
  HintText.Text := Application.Hint;
{$endif}
{$ifdef OSX}
  HintText.Text := Application.Hint;
{$endif}
end;

procedure TFormMain.Init;
begin
  FormMain := self;

  Application.OnException := ApplicationEventsException;
  Application.OnIdle := ApplicationEventsIdle;

{$ifdef debug}
  ReportMemoryLeaksOnShutdown := True;
{$endif}

{$ifdef MSWindows}
  Width := 1200;
  Height := 800;
{$endif}

  FormatSettings.DecimalSeparator := '.';
  Caption := 'Federgraph ' + Application.Title.ToUpper;

  claBackground := StringToAlphaColor('#FF333333');

  WantColorPanel := True;
  CreateColorPanel;

  Main := TMain.Create;

  RegisterForAppEvents;

  InitViewport;
  InitCamera;
  InitLight;
  InitMesh;

  Main.Init;

  CreateHintText;
  LayoutHintText;

  Main.IsReady := True;

  Main.FederText1.AllVisible := True;
  Main.FederText1.TextVisible := True;
  Main.FederText1.TransitBarLayout := 0;
  Main.FederText1.EquationVisible := True;
  Main.FederText1.MenuVisible := True;

  IsUp := True;
  AllowResizing := True;
  Main.FederModel.Refresh;

  if WantColorPanel then
    InitColorPanel;

  HintText.BringToFront;
  Application.OnHint := HandleShowHint;

//  Main.ActionHandler.Execute(faReset);

//  Main.ActionHandler.Execute(faToggleColorPanel);
  Main.ActionHandler.Execute(faToggleColorSwat);
//  Main.ActionHandler.Execute(faResetRotation);

//  Main.ActionHandler.ReportPage := rpColorInfo2;
//  Main.ActionHandler.Execute(faToggleReportLock);
  Main.FederText1.ActionPage := 1;

  TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, DoOrientationChanged);

{$ifdef MSWINDOWS}
  Viewport.SetFocus;
{$endif}
end;

procedure TFormMain.InitCamera;
begin
  CameraDummy := TDummy.Create(Self);
  CameraDummy.Parent := Viewport;
  Viewport.AddObject(CameraDummy);

  Camera := TCamera.Create(Self);
  Camera.Parent := Viewport;
  CameraDummy.AddObject(Camera);

  Viewport.Camera := Camera;

  ResetCamera;
end;

procedure TFormMain.InitColorPanel;
begin
  if ColorPanel <> nil then
  begin
    ResizeColorPanel;
    ColorPanel.Width := 2 * MainVar.Raster;
    ColorPanel.Height := 2 * MainVar.Raster;
    ColorPanel.Visible := False;
    ColorPanel.UseAlpha := False;
    ColorPanel.Opacity := 0.5;
    ColorPanel.OnChange := ColorPanelChange;
  end;
end;

procedure TFormMain.InitLight;
begin
  FrontLight := TLight.Create(Self);
  FrontLight.LightType := TLightType.Directional;
  Viewport.AddObject(FrontLight);

  BackLight := TLight.Create(Self);
  BackLight.LightType := TLightType.Point;
  BackLight.Position.Z := 80;
  BackLight.Color := claWhite;
  Viewport.AddObject(BackLight);

  WestLight := TLight.Create(Self);
  WestLight.LightType := TLightType.Point;
  WestLight.Position.X := -100;
  WestLight.Color := claLime;
  Viewport.AddObject(WestLight);

  EastLight := TLight.Create(Self);
  EastLight.LightType := TLightType.Point;
  EastLight.Position.X := 100;
  EastLight.Color := claFuchsia;
  Viewport.AddObject(EastLight);

  NorthLight := TLight.Create(Self);
  NorthLight.LightType := TLightType.Point;
  NorthLight.Position.Y := 150;
  NorthLight.Color := claWhite;
  Viewport.AddObject(NorthLight);

  SouthLight := TLight.Create(Self);
  SouthLight.LightType := TLightType.Point;
  SouthLight.Position.Y := -150;
  SouthLight.Color := claWhite;
  Viewport.AddObject(SouthLight);
end;

procedure TFormMain.InitMesh;
begin
  Main.AddMeshesToScene(Viewport);
  Main.FederMesh.OnRingPicked := RingPicked;
end;

procedure TFormMain.InitViewport;
var
  t: single;
begin
  Viewport := TViewport3D.Create(self);
  Viewport.Parent := self;
  Viewport.UsingDesignCamera := False;
  Viewport.Align := TAlignLayout.Client; // set Alignment after setting Parent

{$ifdef MSWindows}
  Viewport.OnKeyUp := HandleKey;
{$endif}
{$ifdef MacOS}
  Viewport.OnKeyDown := HandleKey;
{$endif}

  Viewport.OnMouseDown := ViewportMouseDown;
  Viewport.OnMouseMove := ViewportMouseMove;
  Viewport.OnMouseUp := ViewportMouseUp;

  Viewport.Color := claBackground;
  Viewport.CanFocus := true;

  t := Viewport.Scene.GetSceneScale;
  if t > 1 then
    Main.IsRetina := True;
end;

procedure TFormMain.InitZOrderInfo(ML: TStrings);
var
  i: Integer;
  o: TFMXObject;
  c: TControl;
begin
  ML.Add('ZOrder-Report for FormMain.Children:');
  ML.Add('Item - Visible; HitTest; Name: ClassName');
  Inc(ZInfoCounter);
  for i := 0 to Self.ChildrenCount-1 do
  begin
    o := Self.Children.Items[i];
    if o is TControl then
    begin
      c := o as TControl;
      ML.Add(Format('%2d - %d; %d; %s: %s', [i, BoolInt[c.Visible], BoolInt[c.HitTest], c.Name, c.ClassName]));
    end;
  end;

  ML.Add('');
  ML.Add(Format('ZInfoCounter = %d', [ZInfoCounter]));
  ML.Add(Format('Self.Fill.Color = %s', [AlphaColorToString(Self.Fill.Color)]));
end;

procedure TFormMain.InvalidateGraph(Sender: TObject);
begin
  if IsUp and (Viewport <> nil) then
  begin
    Viewport.InvalidateRect(Viewport.ClipRect);
    Viewport.Repaint;
    Inc(Main.CounterDrawing3D);
  end;
end;

procedure TFormMain.LayoutHintText;
begin
  HintText.Position.Y := 1 * MainVar.Raster + 10;
  UpdateHintTextPosition;
end;

procedure TFormMain.Log(s: string);
begin

end;

function TFormMain.MakeScreenshot: TBitmap;
begin
  Result := TBitmap.Create(Round(ClientWidth), Round(ClientHeight));
  Result.Clear(0);
  if Result.Canvas.BeginScene then
  try
    PaintTo(Result.Canvas);
  finally
    Result.Canvas.EndScene;
  end;
end;

procedure TFormMain.MemoBtnClick(Sender: TObject);
begin
  if not Assigned(FormMemo) then
  begin
    FormMemo := TFormMemo.Create(nil);
    FormMemo.Memo.Lines.Clear;
  end;
  FormMemo.Visible := True;
end;

procedure TFormMain.RegisterForAppEvents;
var aFMXApplicationEventService: IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(aFMXApplicationEventService)) then
    aFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent)
  else
    Log('Application Event Service is not supported.');
end;

procedure TFormMain.ResetCamera;
begin
  { CameraDummy }

  CameraDummy.Position.Point := TPoint3D.Zero;
  CameraDummyRotationAngle := TPoint3D.Create(180, 0, 0);
  UpdateRotation;

  { Camera }

  Camera.Position.X := 0.0;
  Camera.Position.Y := 0.0;
  Camera.Position.Z := 20.0;

  Camera.ResetRotationAngle;
  Camera.RotationAngle.X := 180;
  Camera.RotationAngle.Y := 0;
  Camera.RotationAngle.Z := 0;
end;

procedure TFormMain.ResetRotation;
begin
  CameraDummyRotationAngle.X := 180;
  CameraDummyRotationAngle.Y := 0;
  CameraDummyRotationAngle.Z := 0;
  UpdateRotation;
end;

procedure TFormMain.ResetPosition;
begin
  Camera.Position.X := 0.0;
  Camera.Position.Y := 0.0;
end;

procedure TFormMain.ResetZoom;
begin
  Camera.Position.Z := 20.0;
end;

procedure TFormMain.ResizeColorPanel;
begin
  if ColorPanel <> nil then
  begin
    if Main.IsPhone then
    begin
      ColorPanel.Position.X := MainVar.Raster;
      ColorPanel.Position.Y := 2 * MainVar.Raster;
    end
    else
    begin
      ColorPanel.Position.X := 3 * MainVar.Raster + 20;
      ColorPanel.Position.Y := 5.5 * MainVar.Raster;
    end;
  end;
end;

procedure TFormMain.RingPicked(Sender: TObject);
var
  r: Integer;
begin
  r := Main.CurrentRing;

  if (Main.FederText1 <> nil) and Main.FederText1.SwatVisible then
  begin
    Main.FederText1.SwatColor := Main.BitmapBuilder.RingColor[r];
  end;
  if (Main.FederText2 <> nil) then
  begin
    Main.FederText2.SwatColor := Main.BitmapBuilder.RingColor[r];
  end;

  ColorPanel.Color := Main.BitmapBuilder.RingColor[r];
  Main.RingIndexUpdated;
end;

procedure TFormMain.SetBandColor(const Value: TAlphaColor);
begin
  FBandColor := Value;
  if Assigned(ColorPanel) then
  begin
    ColorPanel.Color := Value;
    ColorPanelChanged := False;
  end;
end;

procedure TFormMain.SetIsUp(const Value: Boolean);
begin
  Main.IsUp := Value;
end;

procedure TFormMain.SetMeshText(const Value: string);
begin
//  Main.FederText.SR00.Caption := Value;
end;

procedure TFormMain.SetParamText(const Value: string);
begin
//  Main.FederText.ST00.Caption := Value;
end;

procedure TFormMain.SetRingText(const Value: string);
begin
//  Main.FederText.SL00.Caption := Value;
end;

procedure TFormMain.SetShowColorPanel(const Value: Boolean);
begin
  FShowColorPanel := Value;
  if Assigned(ColorPanel) then
  begin
    ColorPanel.Visible := Value;
    if Value then
    begin
      ColorPanel.BringToFront;
      ColorPanel.Color := Main.BitmapBuilder.RingColor[Main.CurrentRing];
    end;
  end;
end;

procedure TFormMain.SetValueText(const Value: string);
begin
  Main.FederText.SB00.Caption := Value;
end;

procedure TFormMain.UpdateBackground;
begin
  Self.Fill.Color := MainVar.ColorScheme.claBackground;
  Viewport.Color := MainVar.ColorScheme.claBackground;

  if HintText <> nil then
    HintText.TextSettings.FontColor := MainVar.ColorScheme.claHint;
end;

procedure TFormMain.SetZoomText(const Value: string);
begin
  Main.FederText.SB00.Caption := Value;
end;

procedure TFormMain.ToggleLux;
begin
  FrontLight.Enabled := Main.vp.WantLux;

  if FrontLight.Enabled then
    Main.MaterialSource.Ambient := claNull
  else
    Main.MaterialSource.Ambient := claWhite;

  BackLight.Enabled := FrontLight.Enabled;
  WestLight.Enabled := FrontLight.Enabled;
  EastLight.Enabled := FrontLight.Enabled;
  NorthLight.Enabled := FrontLight.Enabled;
  SouthLight.Enabled := FrontLight.Enabled;

  Main.Refresh;
end;

procedure TFormMain.UpdateRotation;
begin
  CameraDummy.ResetRotationAngle;
  CameraDummy.RotationAngle.Point := CameraDummyRotationAngle;
end;

procedure TFormMain.UpdateHintText(fa: Integer);
begin
  if (HintText <> nil) and HintText.Visible then
  begin
{$ifdef IOS}
  if fa = faCLA then
    HintText.Text := Main.FederText.GetHintForColorBtn(Main.FederText.ClickedID)
  else if fa <> faNoop then
    HintText.Text := Main.ActionHandler.GetCaption(fa) + #10 + Main.ActionHandler.GetShortcutString(fa)
  else
    HintText.Text := '';
{$endif}
{$ifdef Android}
  if fa = faCLA then
    HintText.Text := Main.FederText.GetHintForColorBtn(Main.FederText.ClickedID)
  else if fa <> faNoop then
    HintText.Text := Main.ActionHandler.GetCaption(fa) + #10 + Main.ActionHandler.GetShortcutString(fa)
  else
    HintText.Text := '';
{$endif}
  end;
end;

procedure TFormMain.UpdateHintTextPosition;
begin
  if (HintText <> nil) then
  begin
    if Main.IsPhone and (ClientWidth < ClientHeight) then
      HintText.Position.X := 2 * MainVar.Raster + 30
    else
      HintText.Position.X := 7 * MainVar.Raster + 30;
  end;
end;

procedure TFormMain.ViewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MouseDown := True;
  HandleMouseDown(Shift, X, Y);
end;

procedure TFormMain.ViewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  if MouseDown then
    HandleMouseMove(Shift, X, Y);
end;

procedure TFormMain.ViewportMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MouseDown := False;
end;

end.
