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

{$I App\RiggVar.App.Defs.inc}

uses
  RiggVar.FB.ActionConst,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  System.SysUtils,
  System.Classes,
  System.Math,
  System.Messaging,
  System.UITypes,
  System.UIConsts,
  System.Types,
  FMX.Graphics,
  FMX.Viewport3D,
  FMX.StdCtrls,
  FMX.Platform,
  FMX.Types,
  FMX.Types3D,
  FMX.Forms,
  FMX.Controls,
  FMX.ExtCtrls,
  FMX.Layouts,
  FMX.Colors,
  FMX.Layers3D,
  FMX.Objects;

type
  TFormMain = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure InitTimerTimer(Sender: TObject);
  private
    AllowResizing: Boolean;
    DrawingNeeded: Boolean;
    ExitSizeMoveCounter: Integer;
    FBandColor: TAlphaColor;
    FShowColorPanel: Boolean;
    FViewportState: Integer;
    NewControlSize: TControlSize;
    ResizeCounter: Integer;
    SmallViewportSize: Integer;
    ZInfoCounter: Integer;
    procedure ActionsBtnClick(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
    procedure ColorPanelChange(Sender: TObject);
    procedure CreateColorPanel;
    procedure CreateHintText;
    procedure CreateLayouts;
    procedure DestroyForms;
    procedure DoOnResize;
    procedure DoOrientationChanged(const Sender: TObject; const M: TMessage);
    procedure FixZOrderForBackground;
    function GetContentHeight: single;
    function GetContentParent: TFmxObject;
    function GetContentWidth: single;
    function GetIsUp: Boolean;
    function HandleAppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;
    procedure HandleColorPanelChanged;
    procedure HandleRingWidthChanged;
    procedure Init;
    procedure InitChecker;
    procedure InitColorPanel;
    procedure InitFormat;
    procedure InitViewport;
    procedure InitViewportX(ModelID: Integer; l: TLayout; v: TViewport3D);
    procedure LayoutHintText;
    procedure Log(s: string);
    procedure MemoBtnClick(Sender: TObject);
    procedure RegisterForAppEvents;
    procedure ResizeColorPanel;
    procedure RingPicked(Sender: TObject);
    procedure SetBandColor(const Value: TAlphaColor);
    procedure SetIsUp(const Value: Boolean);
    procedure SetShowColorPanel(const Value: Boolean);
    procedure SetViewportState(const Value: Integer);
    procedure UpdateHintTextPosition;
  public
    CheckerBitmap: TBitmap;
    CheckerImage: TImage;
    claBackground: TAlphaColor;
    ColorPanel: TColorPanel;
    ColorPanelChanged: Boolean;
    HintText: TText;
    InitTimer: TTimer;
    KeyCharReceived: Boolean;
    Layout3D: TLayout;
    Viewport: TViewport3D;
    WantColorPanel: Boolean;
    WantPhone: Boolean;
    WantPortrait: Boolean;
    procedure CreateCheckerBitmap;
    procedure Draw(ModelID: Integer = 1);
    procedure FormResizeEnd(Sender: TObject);
    procedure HandleAction(fa: TFederAction);
    procedure HandleKey(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure HandleShowHint(Sender: TObject);
    procedure InitZOrderInfo(ML: TStrings);
    procedure InvalidateGraph(Sender: TObject);
    function MakeScreenshot: TBitmap;
    procedure UpdateBackground;
    procedure UpdateChecker(a: Integer = 0);
    procedure UpdateDisplay;
    procedure UpdateHintText(fa: Integer);
    procedure UpdateLayout(l: TLayout);
    property BandColor: TAlphaColor read FBandColor write SetBandColor;
    property ContentHeight: single read GetContentHeight;
    property ContentParent: TFmxObject read GetContentParent;
    property ContentWidth: single read GetContentWidth;
    property IsUp: Boolean read GetIsUp write SetIsUp;
    property ShowColorPanel: Boolean read FShowColorPanel write SetShowColorPanel;
    property ViewportState: Integer read FViewportState write SetViewportState;
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
  RiggVar.FederModel.Frame3D,
  RiggVar.FB.Action,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Data,
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
        end
        else if Main.FederFrame.IsClean then
        begin
          Main.ModelUpdate.DoOnIdle;
        end
        else
        begin
          Main.FederFrame.DoOnIdle;
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

procedure TFormMain.CreateCheckerBitmap;
var
  cb: TBitmap;
  sr, dr: TRectF;
  d: Integer;
begin
  d := 30;
  sr := RectF(0, 0, d, d);

  cb := TBitmap.Create(d, d);
  cb.Canvas.BeginScene;
  cb.Canvas.Clear(claDarkGray);
  cb.Canvas.EndScene;

  CheckerBitmap := TBitmap.Create(2 * d, 2 * d);
  CheckerBitmap.Canvas.BeginScene;
  CheckerBitmap.Canvas.Clear(claGray);

  dr.Left := 0;
  dr.Top := 0;
  dr.Right := dr.Left + d;
  dr.Bottom := dr.Top + d;

  CheckerBitmap.Canvas.DrawBitmap(cb, sr, dr, 1.0);
  dr.Left := dr.Left + d;
  dr.Top := dr.Top + d;
  dr.Left := dr.Right + d;
  dr.Top := dr.Bottom + d;
  CheckerBitmap.Canvas.DrawBitmap(cb, sr, dr, 1.0);

  CheckerBitmap.Canvas.EndScene;

  cb.Free;
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

procedure TFormMain.CreateLayouts;
begin
  Layout3D := TLayout.Create(self);
  Layout3D.Name := 'Layout3D';
  Self.AddObject(Layout3D);
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

procedure TFormMain.DoOnResize;
begin
  if IsUp and AllowResizing then
  begin
    Inc(ResizeCounter);
    ResizeColorPanel;
    UpdateLayout(Layout3D);
    Main.UpdateTouch;
    Main.UpdateText;
    UpdateHintTextPosition;

    if CheckerImage <> nil then
      CheckerImage.SendToBack;

    SetViewportState(ViewportState);

    HandleAction(faNoop);
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

procedure TFormMain.Draw(ModelID: Integer);
begin
end;

procedure TFormMain.FixZOrderForBackground;
begin
  CheckerImage.SendToBack;
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
{$ifdef MSWINDOWS}
  if IsUp then
  begin
    ViewportState := 0;
    Viewport.SetFocus;
  end;
{$endif}
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
{$ifdef IOS}
  InitTimer := TTimer.Create(Self);
  InitTimer.Interval := 1000;
  InitTimer.OnTimer := InitTimerTimer;
  InitTimer.Enabled := True;
{$endif}

{$ifdef MSWINDOWS}
  InitTimer := TTimer.Create(Self);
  InitTimer.Interval := 10;
  InitTimer.OnTimer := InitTimerTimer;
  InitTimer.Enabled := True;
{$endif}

{$ifdef ANDROID}
  InitTimer := TTimer.Create(Self);
  InitTimer.Interval := 1000;
  InitTimer.OnTimer := InitTimerTimer;
  InitTimer.Enabled := True;
{$endif}

{$ifdef OSX}
  InitTimer := TTimer.Create(Self);
  InitTimer.Interval := 10;
  InitTimer.OnTimer := InitTimerTimer;
  InitTimer.Enabled := True;
{$endif}
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TOrientationChangedMessage, DoOrientationChanged);

  MainVar.AppIsClosing := True;

  DestroyForms;

  CheckerBitmap.Free;
  NewControlSize.Free;

  Main.Free;
  Main := nil;
end;

procedure TFormMain.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  if IsUp then
    Main.FederFrame.HandleMouseWheel(Sender, Shift, WheelDelta, Handled);
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  DoOnResize;
end;

procedure TFormMain.FormResizeEnd(Sender: TObject);
begin
  Inc(ExitSizeMoveCounter);
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
  result := self;
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

  if (FormMemo <> nil) and (FormMemo.Visible) then
    FormMemo.AutoUpdate;
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
      MainVar.ShouldRecycleSocket := True;
      Log('Will Become Inactive');
    end;
    TApplicationEvent.EnteredBackground:
    begin
      MainVar.ShouldRecycleSocket := True;
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
begin
  if IsUp then
  begin
    if Main.LightMode then
    begin
      if ColorPanel <> nil then
        Main.FederScene.MoveColor(ColorPanel.Color);
      InvalidateGraph(nil);
    end
    else
    begin
      Main.UpdateRingColor3(ColorPanel.Color);
    end;
  end;
  ColorPanelChanged := False;
end;

procedure TFormMain.HandleKey(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  MainVar.BatchStopRequested := True;
  if IsUp then
    Main.ActionHandler.FormKeyUp(Sender, Key, KeyChar, Shift);
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

  NewControlSize := TControlSize.Create(TSizeF.Create(0, 0));

  Application.OnException := ApplicationEventsException;
  Application.OnIdle := ApplicationEventsIdle;

{$ifdef debug}
  ReportMemoryLeaksOnShutdown := True;
{$endif}

  InitFormat;

  FormatSettings.DecimalSeparator := '.';
  Caption := UpperCase(Application.Title);

  claBackground := StringToAlphaColor('#FF333333');

  CreateLayouts;

  WantColorPanel := True;
  CreateColorPanel;

  Main := TMain.Create;
  Main.WantPosZ12 := False;

  RegisterForAppEvents;

  InitViewport;
{$ifdef WantLED}
  Main.FederText.WantLED := True;
{$else}
  Main.FederText.WantLED := False;
{$endif}

  Main.Init;

  CreateHintText;
  LayoutHintText;

  Main.IsReady := True;
  Main.ModelUpdate.Delay := 80;

  Main.KeyBinding := 1;
  Main.FederKeyboard1.KeyMapping := 1;

  Main.FederText1.AllVisible := True;
  Main.FederText1.TextVisible := True;
  Main.FederText1.TransitBarLayout := 0;
  Main.FederText1.EquationVisible := True;
  Main.FederText1.MenuVisible := True;

  TFederData.Want2D := False;
  Main.FederData.TextureLock := False;
  Main.FederData.BackgroundLock := True;
  Main.FederReport.WantShortTable := True;

  Main.Want2D := False;
  Main.Want3D := True;
  Main.WantAnimation := False;

  Main.MeshSize := MainConst.DefaultMeshSize;

  Main.WantTimedParams := True;
  Main.Frame3D.WantIdleMove := True;

  Main.Trackbar_Value := Main.FederModel.ParamValue;
  IsUp := True;
  AllowResizing := True;
  Main.FederModel.Refresh;

  if WantColorPanel then
    InitColorPanel;

  InitChecker;

  Main.DoReset;

  Main.FederMesh.OnRingPicked := RingPicked;

  Main.GotoSample(1);
  Main.Example01;

  SmallViewportSize := 5 * MainVar.Raster;
  ViewportState := 0;

  HintText.BringToFront;
  Application.OnHint := HandleShowHint;

//  Main.ActionHandler.Execute(faReset);

//  Main.ActionHandler.Execute(faToggleColorPanel);
  Main.ActionHandler.Execute(faToggleColorSwat);
//  Main.ActionHandler.Execute(faResetRotation);

//  Main.ActionHandler.ReportPage := rpColorInfo2;
//  Main.ActionHandler.Execute(faToggleReportLock);
//  Main.FederText1.ActionPage := 1;

  Main.BubbleUpAction(faNoop);
  TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, DoOrientationChanged);

{$ifdef MSWINDOWS}
  ViewportState := 0;
  Viewport.SetFocus;
{$endif}
end;

procedure TFormMain.InitChecker;
begin
  CreateCheckerBitmap;

  CheckerImage := TImage.Create(Self);
  CheckerImage.Parent := Self;
  CheckerImage.Name := 'CheckerImage';

  CheckerImage.Bitmap := CheckerBitmap;
  CheckerImage.WrapMode := TImageWrapMode.Tile;
  CheckerImage.CanFocus := False;

  UpdateChecker;

  CheckerImage.SendToBack;
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

procedure TFormMain.InitFormat;
var
  a: Integer;
begin
  WantPhone := False;
  WantPortrait := False;
  if WantPhone then
  begin
    if WantPortrait then
    begin
      a := 2;
      case a of
        1:
        begin
          ClientWidth := 320;
          ClientHeight := 548;
        end;

        2:
        begin
          { iPhone 3 (3.5 Inch): 640 x 920 }
          ClientWidth := 320;
          ClientHeight := 460;
        end;

        3:
        begin
          { iPhone 4+5 (4 Inch): 640 x 1136 }
          ClientWidth := 320;
          ClientHeight := 667;
        end;

        4:
        begin
          { iPhone 6 (4.7 Inch): 750 x 1334 }
          ClientWidth := 375;
          ClientHeight := 548;
        end;

        5:
        begin
          { iPhone 6 Plus (5.5 Inch): 1242 x 2208 }
          //(you need the screenshot in this resolution,
          //the phone scales them down to 1080 x 1920)
          ClientWidth := 375;
          ClientHeight := 548;
        end;

        6:
        begin
          { iPad: 1536 x 2048 }

        end;
      end;

    end
    else
    begin
    ClientWidth := 420;
    ClientHeight := 580;
    end;
  end
  else
  begin
    if Screen.WorkAreaWidth < 1200 then
    begin
      ClientWidth := 1036; // 1000 will wrap main menu
      ClientHeight := 800;
    end
    else
    begin
      ClientWidth := 1200;
      ClientHeight := 800;
  end;
  end;
end;

procedure TFormMain.InitTimerTimer(Sender: TObject);
begin
  InitTimer.Enabled := False;
  if not IsUp then
    Init;
end;

procedure TFormMain.InitViewport;
var
  t: single;
begin
  Viewport := TViewport3D.Create(Layout3D);

{$ifdef MSWindows}
  Viewport.OnKeyUp := HandleKey;
{$endif}
{$ifdef MacOS}
  Viewport.OnKeyDown := HandleKey;
{$endif}

  InitViewportX(1, Layout3D, Viewport);

  t := Viewport.Scene.GetSceneScale;
  if t > 1 then
    Main.IsRetina := True;
end;

procedure TFormMain.InitViewportX(ModelID: Integer; l: TLayout; v: TViewport3D);
var
  fm: TFederFrame3D;
begin
  fm := Main.FederFrame3D;
  UpdateLayout(l);

  v.Parent := l;
  v.UsingDesignCamera := False;
  v.Align := TAlignLayout.Client;

  v.OnKeyDown := fm.ViewportKeyDown;
  v.OnKeyUp := fm.ViewportKeyUp;
  v.OnMouseDown := fm.ViewportMouseDown;
  v.OnMouseMove := fm.ViewportMouseMove;
  v.OnMouseUp := fm.ViewportMouseUp;
  v.OnClick := fm.ViewportClick;
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
    Draw;
    Inc(Main.CounterDrawing3D);
  end;
end;

procedure TFormMain.LayoutHintText;
begin
//  HintText.Position.X := 7 * MainVar.Raster + 30;
  HintText.Position.Y := 1 * MainVar.Raster + 10;
  UpdateHintTextPosition;
end;

procedure TFormMain.Log(s: string);
begin
  if IsUp then
  begin
    Main.Logger.Info(s);
  end;
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
//    Main.WriteCode(FormMemo.Memo.Lines);
    FormMemo.GotoHelpHome;
  end;
  FormMemo.Visible := True;
  FormMemo.Activate;
end;

procedure TFormMain.RegisterForAppEvents;
var aFMXApplicationEventService: IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(aFMXApplicationEventService)) then
    aFMXApplicationEventService.SetApplicationEventHandler(HandleAppEvent)
  else
    Log('Application Event Service is not supported.');
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
  if ColorPanel.Visible then
  begin
    ColorPanel.Color := Main.BitmapBuilder.RingColor[r];
    Main.RingIndexUpdated;
  end;

//  Caption := Application.Title +  ' -  CurrentRing = ' + IntToStr(r);
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

procedure TFormMain.SetViewportState(const Value: Integer);
//var
//  TargetSize: Integer;
begin
  FViewportState := Value;
  Viewport.Align := TAlignLayout.None;
  case Value of
    0:
    begin
      Viewport.Position.X := 0;
      Viewport.Position.Y := 0;
      Viewport.Size := Layout3D.Size;
      UpdateChecker(2);
      CheckerImage.Visible := True;
    end;
    1:
    begin
      Viewport.Position.X := 3 * MainVar.Raster;
      Viewport.Position.Y := 3 * MainVar.Raster;
      NewControlSize.Width := SmallViewportSize;
      NewControlSize.Height := SmallViewportSize;
      Viewport.Size := NewControlSize;
      UpdateChecker;
      CheckerImage.Visible := False;
    end;
    2:
    begin
      Viewport.Position.X := MainVar.Raster;
      Viewport.Position.Y := MainVar.Raster;
      NewControlSize.Width := ClientHeight - 2 * MainVar.Raster;
      NewControlSize.Height := Viewport.Height * 2/3;
      Viewport.Size := NewControlSize;
      UpdateChecker;
      CheckerImage.Visible := False;
    end;
//    3:
//    begin
//      TargetSize := 3200;
//      Viewport.Position.X := -TargetSize + MainVar.Raster + SmallViewportSize;
//      Viewport.Position.Y := -TargetSize + MainVar.Raster + SmallViewportSize;
//      NewControlSize.Width := TargetSize;
//      NewControlSize.Height := TargetSize;
//      Viewport.Size := NewControlSize;
//      CheckerImage.Visible := False;
//    end;
  end;

  FixZOrderForBackground;

  Viewport.Repaint;
  Main.UpdateTouch;
end;

procedure TFormMain.UpdateBackground;
begin
  if ViewportState = 1 then
    Main.BlackText;

  if MainVar.ColorScheme.claBackground = claNull then
    Main.BlackText;

  Self.Fill.Color := MainVar.ColorScheme.claBackground;
  Viewport.Color := MainVar.ColorScheme.claBackground;

  if HintText <> nil then
    HintText.TextSettings.FontColor := MainVar.ColorScheme.claHint;
end;

procedure TFormMain.UpdateChecker(a: Integer = 0);
begin
  case a of
    0:
    begin
      CheckerImage.Position.X := 0;
      CheckerImage.Position.Y := 0;
      CheckerImage.Width := ClientWidth;
      CheckerImage.Height := ClientHeight;
    end;

    1:
    begin
      CheckerImage.Position.X := Viewport.Position.X;
      CheckerImage.Position.Y := Viewport.Position.Y;
      CheckerImage.Width := Viewport.Width;
      CheckerImage.Height := Viewport.Height;
    end;

    2:
    begin
      CheckerImage.Position.X := 0;
      CheckerImage.Position.Y := 0;
      CheckerImage.Width := ClientWidth;
      CheckerImage.Height := ClientHeight;
    end;

    3:
    begin
      CheckerImage.Position.X := MainVar.Raster;
      CheckerImage.Position.Y := MainVar.Raster;
      CheckerImage.Width := ClientWidth - 2 * MainVar.Raster;
      CheckerImage.Height := ClientHeight - 2 * MainVar.Raster;
    end;
  end;
end;

procedure TFormMain.UpdateDisplay;
begin
  Resize;
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

procedure TFormMain.UpdateLayout(l: TLayout);
var
  d: Integer;
  cw, cw2: Integer;
  ch, ch2: Integer;
begin
  d := -1;

  if (l = Layout3D) then
    d := DisloF;

  Assert(l <> nil);

  cw := ClientWidth;
  cw2 := cw div 2;
  ch := ClientHeight;
  ch2 := ch div 2;

  case d of
    DisloF: // full screen
    begin
      l.Position.X := 0;
      l.Position.Y := 0;
      l.Width := cw;
      l.Height := ch;
    end;

    DisloL: // left half
    begin
      l.Position.X := 0;
      l.Position.Y := 0;
      l.Width := cw2;
      l.Height := ch;
    end;

    DisloR: // right half
    begin
      l.Position.X := cw2;
      l.Position.Y := 0;
      l.Width := cw2;
      l.Height := ch;
    end;

    DisloHideL: // hidden left
    begin
      l.Position.X := 0;
      l.Position.Y := 0;
      l.Width := 0;
      l.Height := ch;
      l.SendToBack;
    end;

    DisloHideR: // hidden right
    begin
      l.Position.X := cw;
      l.Position.Y := 0;
      l.Width := 0;
      l.Height := ch;
      l.SendToBack;
    end;

    DisloHideTL:
    begin
      l.Position.X := 0;
      l.Position.Y := 0;
      l.Width := 0;
      l.Height := ch2;
      l.SendToBack;
    end;

    DisloHideTR:
    begin
      l.Position.X := cw2;
      l.Position.Y := 0;
      l.Width := 0;
      l.Height := ch2;
      l.SendToBack;
    end;

    DisloHideBL:
    begin
      l.Position.X := 0;
      l.Position.Y := ch2;
      l.Width := 0;
      l.Height := ch2;
      l.SendToBack;
    end;

    DisloHideBR:
    begin
      l.Position.X := cw2;
      l.Position.Y := ch2;
      l.Width := 0;
      l.Height := ch2;
      l.SendToBack;
    end;

    DisloHideM: // zero width in the middle
    begin
      l.Position.X := cw2;
      l.Position.Y := 0;
      l.Width := 0;
      l.Height := ch;
      l.SendToBack;
    end;

    DisloTL:
    begin
      l.Position.X := 0;
      l.Position.Y := 0;
      l.Width := cw2;
      l.Height := ch2;
      l.SendToBack;
    end;

    DisloTR:
    begin
      l.Position.X := cw2;
      l.Position.Y := 0;
      l.Width := cw2;
      l.Height := ch2;
      l.SendToBack;
  end;

    DisloBL:
    begin
      l.Position.X := 0;
      l.Position.Y := ch2;
      l.Width := cw2;
      l.Height := ch2;
      l.SendToBack;
    end;

    DisloBR:
    begin
      l.Position.X := cw2;
      l.Position.Y := ch2;
      l.Width := cw2;
      l.Height := ch2;
      l.SendToBack;
    end;
  end;
end;

end.
