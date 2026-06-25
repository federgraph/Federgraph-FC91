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
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.RTLConsts,
  FMX.Controls3D,
  FMX.Graphics,
  FMX.Types,
  FMX.Types3D,
  FMX.Forms,
  FMX.Viewport3D,
  FMX.Objects3D,
  FMX.Colors,
  FMX.Objects;

type
  TFormMain = class(TForm)
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
    Down: TPointF;
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
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
    procedure ColorPanelChange(Sender: TObject);
    procedure CreateColorPanel;
    function GetIsUp: Boolean;
    procedure HandleColorPanelChanged;
    procedure HandleRingWidthChanged;
    procedure Init;
    procedure InitCamera;
    procedure InitColorBox;
    procedure InitColorPanel;
    procedure InitLight;
    procedure InitMesh;
    procedure InitTouch;
    procedure InitViewport;
    procedure ResizeColorPanel;
    procedure ResizeColorBox;
    procedure RingPicked(Sender: TObject);
    procedure SetBandColor(const Value: TAlphaColor);
    procedure SetIsUp(const Value: Boolean);
    procedure SetMeshText(const Value: string);
    procedure SetParamText(const Value: string);
    procedure SetRingText(const Value: string);
    procedure SetShowColorPanel(const Value: Boolean);
    procedure SetValueText(const Value: string);
    procedure SetZoomText(const Value: string);
    procedure UpdateRotation;
  protected
    procedure ActionsBtnClick(Sender: TObject);
    procedure DestroyForms;
    procedure Log(s: string);
  public
    claBackground: TAlphaColor;
    Camera: TCamera;
    CameraDummy: TDummy;
    CameraDummyRotationAngle: TPoint3D;
    ColorBox: TColorBox;
    ColorPanel: TColorPanel;
    ColorPanelChanged: Boolean;
    Viewport: TViewport3D;
    WantColorPanel: Boolean;
    procedure DoMM(fmk: TFederMessageKind; X, Y: Single);
    procedure DoZoom(Delta: single);
    procedure HandleAction(fa: TFederAction);
    procedure HandleKey(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure InvalidateGraph(Sender: TObject);
    procedure ResetCamera;
    procedure ResetRotation;
    procedure ResetPosition;
    procedure ResetZoom;
    procedure ToggleLux;
    property BandColor: TAlphaColor read FBandColor write SetBandColor;
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
  RiggVar.App.Main,
  RiggVar.FB.Bitmap;

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
        if Main.BitmapBuilder.RingWidthChanged then
        begin
          HandleRingWidthChanged;
        end
        else if ColorPanelChanged then
        begin
          HandleColorPanelChanged;
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

procedure TFormMain.DestroyForms;
begin
  if FormAction <> nil then
  begin
    FormAction.Free;
    FormAction := nil;
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

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
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
  MainVar.ClientWidth := ClientWidth;
  MainVar.ClientHeight := ClientHeight;

  ResizeColorBox;
  ResizeColorPanel;

  if FormShown then
  begin
    Main.FederTouch.UpdateShape;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  if not FormShown then
  begin
    Main.IsUp := True;
    InitTouch;
    FormShown := True;
    Viewport.SetFocus;
    Caption := 'Federgraph FC91P';
    Main.ActionHandler.Execute(faReset);
  end;
end;

function TFormMain.GetIsUp: Boolean;
begin
  result := Main.IsUp;
end;

procedure TFormMain.HandleAction(fa: TFederAction);
begin
  if Main.GraphUpdatingNeeded then
  begin
    Main.GraphUpdatingNeeded := False;
    InvalidateGraph(nil);
  end;

  if Main.StateCheckingNeeded then
  begin
    Main.FederTouch.CheckState;
    Main.StateCheckingNeeded := False;
  end;

  if Main.TextUpdatingNeeded then
  begin
    Main.UpdateText;
    Main.TextUpdatingNeeded := False;
  end;
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
  end;
end;

procedure TFormMain.HandleRingWidthChanged;
begin
  Main.UpdateRings;
  Main.BitmapBuilder.UpdateReason := TUpdateReason.cuParamBandWidth;
  Main.BitmapBuilder.RingWidthChanged := False;
  InvalidateGraph(nil);
end;

procedure TFormMain.Init;
begin
  FormMain := self;

  Application.OnException := ApplicationEventsException;
  Application.OnIdle := ApplicationEventsIdle;

{$ifdef debug}
  ReportMemoryLeaksOnShutdown := True;
{$endif}

  FormatSettings.DecimalSeparator := '.';
  Caption := 'Federgraph ' + Application.Title.ToUpper;

  claBackground := StringToAlphaColor('#FF333333');

  WantColorPanel := True;
  CreateColorPanel;

  Main := TMain.Create;

  InitViewport;
  InitCamera;
  InitLight;
  InitMesh;

  if WantColorPanel then
    InitColorPanel;

  InitColorBox;
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

procedure TFormMain.ResizeColorBox;
begin
  ColorBox.Position.Point := TPointF.Create(75, 75);
end;

procedure TFormMain.InitColorBox;
begin
  ColorBox := TColorBox.Create(Self);
  ColorBox.Parent := Self;
  ColorBox.Name := 'ColorBox';
  ResizeColorBox;
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
  BackLight.Position.Z := LightConst.Back;
  BackLight.Color := claWhite;
  Viewport.AddObject(BackLight);

  WestLight := TLight.Create(Self);
  WestLight.LightType := TLightType.Point;
  WestLight.Position.X := LightConst.West;
  WestLight.Position.Z := LightConst.WestZ;
  WestLight.Color := claLime;
  Viewport.AddObject(WestLight);

  EastLight := TLight.Create(Self);
  EastLight.LightType := TLightType.Point;
  EastLight.Position.X := LightConst.East;
  EastLight.Position.Z := LightConst.WestZ;
  EastLight.Color := claFuchsia;
  Viewport.AddObject(EastLight);

  NorthLight := TLight.Create(Self);
  NorthLight.LightType := TLightType.Point;
  NorthLight.Position.Y := LightConst.North;
  NorthLight.Color := claWhite;
  Viewport.AddObject(NorthLight);

  SouthLight := TLight.Create(Self);
  SouthLight.LightType := TLightType.Point;
  SouthLight.Position.Y := LightConst.South;
  SouthLight.Color := claWhite;
  Viewport.AddObject(SouthLight);
end;

procedure TFormMain.InitMesh;
begin
  Main.AddMeshesToScene(Viewport);
  Main.FederMesh.OnRingPicked := RingPicked;
end;

procedure TFormMain.InitTouch;
begin
  Main.FederTouch.OwnerComponent := Self;
  Main.FederTouch.ParentObject := Viewport;
  MainVar.ClientWidth := ClientWidth;
  MainVar.ClientHeight := ClientHeight;
  Main.FederTouch.Init;
end;

procedure TFormMain.InitViewport;
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
end;

procedure TFormMain.InvalidateGraph(Sender: TObject);
begin
  if Viewport <> nil then
  begin
    Viewport.InvalidateRect(Viewport.ClipRect);
    Viewport.Repaint;
  end;
end;

procedure TFormMain.Log(s: string);
begin

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
      ColorPanel.Position.Y := 6 * MainVar.Raster;
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

  if (ColorBox <> nil) and ColorBox.Visible then
  begin
    ColorBox.Color := Main.BitmapBuilder.RingColor[r];
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
  Main.FederTouch.SR00.Caption := Value;
end;

procedure TFormMain.SetParamText(const Value: string);
begin
  Main.FederTouch.ST00.Caption := Value;
end;

procedure TFormMain.SetRingText(const Value: string);
begin
  Main.FederTouch.SL00.Caption := Value;
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
  Main.FederTouch.SB00.Caption := Value;
end;

procedure TFormMain.SetZoomText(const Value: string);
begin
  Main.FederTouch.SB00.Caption := Value;
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
  else if KeyChar = 's' then
  begin
    Main.ActionHandler.Execute(faWantSideCaps);
    Exit;
  end

  else if KeyChar = 'm' then
  begin
    Main.ActionHandler.Execute(faWantBottomMirrored);
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
  else if KeyChar = 'F' then
  begin
    Main.ActionHandler.Execute(faToggleColorSwat);
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
