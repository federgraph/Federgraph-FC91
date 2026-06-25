unit RiggVar.FederModel.Frame3D;

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

{$define HasCamera}

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
  RiggVar.FB.Frame;

type
  TFederFrame3D = class(TFederFrameBase)
  public
    Camera00: TCamera;
    procedure InitWithViewport(vp: TViewport3D);
    procedure DoZoom(Delta: single); override;
    procedure DoZoomTimed3D(Delta: single); override;
    procedure LoadEulerAngle(ed: TPoint3D); override;
    procedure DoParamValueChange(fp: TFederParam; pv: single); override;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederFrame3D }

procedure TFederFrame3D.InitWithViewport(vp: TViewport3D);
begin
  if vp = nil then
    Exit;

  { CameraDummy }
  CameraDummy := TDummy.Create(vp);
  vp.AddObject(CameraDummy);

{$ifdef HasCamera}
 { Camera }
  Camera00 := TCamera.Create(vp);
  Camera := Camera00;
  CameraDummy.AddObject(Camera);
  if Assigned(vp) then
  begin
    vp.Color := MainVar.ColorScheme.claBackground;
    vp.Camera := Camera00;
    if Main.IsDesktop then
      vp.CanFocus := True;
  end;
{$endif}

  Reset;
end;

procedure TFederFrame3D.LoadEulerAngle(ed: TPoint3D);
begin
{$ifdef HasCamera}
  if Assigned(CameraDummy) then
  begin
    CameraDummyRotationAngle := ed;
    CameraDummy.RotationAngle.Point := TPoint3D.Zero;
    UpdateRotation;
  end;
{$endif}
end;

procedure TFederFrame3D.DoParamValueChange(fp: TFederParam; pv: single);
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

procedure TFederFrame3D.DoZoom(Delta: single);
begin
    mmfmk := fmkCZ;
    mmDelta := mmDelta + Delta;
end;

procedure TFederFrame3D.DoZoomTimed3D(Delta: single);
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

end.
