unit RiggVar.FederModel.Report;

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
  System.SysUtils,
  System.Classes,
  System.Types,
  FMX.Controls3D,
  System.Math.Vectors,
  RiggVar.FB.Def,
  RiggVar.FB.Report;

type
  TFederReport1 = class(TFederReport)
  protected
    HeaderIndex: Integer;
    WantK: Boolean;
    function GetAppStatus: string;
    function GetAppStatus1: string;
    function GetAppStatus2: string;
  public
    function GetZoomInfo: string; override;
    function GetModelStatus: string; override;
    function GetViewStatus: string; override;
    function GetRotationInfo: string; override;
    function GetMatrixInfo: string; override;
    function GetLightInfo: string; override;
    function GetLockStatus: string; override;
    function GetColorInfo1: string; override;
    function GetColorInfo2: string; override;
    function GetMeshDataInfo: string; override;
  end;

implementation

uses
  RiggVar.FB.Classes,
  RiggVar.App.Main;

function TFederReport1.GetZoomInfo: string;
var
  ft: string;
  fs: string;
  f: single;
{$ifdef PatchedFMX}
  p: TPoint3D;
  cr: TControl3D;
{$endif}
begin
  SL.Clear;

  ft := '%5.2f %5.2f %5.2f %5.2f';

  fs := 'Camera.Position.Z = %5.2f';
  f := Main.Frame3D.Camera00.Position.Z;
  SL.Add(Format(fs, [f]));

{$ifdef PatchedFMX}
  cr := Main.Frame3D.Camera00;
  p := cr.Quaternion.ImagPart;
  f := cr.Quaternion.RealPart;
  fs := Format('Camera = (%s)', [ft]);
  SL.Add(Format(fs, [p.X, p.Y, p.Z, f]));
{$endif}

  SL.Add('');
  SL.Add(Format('SetValueCounter = %d', [Main.ParallelAnimation.SetValueCounter]));

  SL.Insert(0, 'Zoom Info');
  result := SL.Text;
end;

function TFederReport1.GetRotationInfo: string;
var
  ft: string;
  fs: string;
  p: TPoint3D;
begin
  SL.Clear;
  GetAppStatus;

  ft := '%7.2f %7.2f %7.2f';

  fs := Format('RA: %s', [ft]);
  SL.Add(Format(fs, [
    Main.Frame3D.CameraDummy.RotationAngle.X,
    Main.Frame3D.CameraDummy.RotationAngle.Y,
    Main.Frame3D.CameraDummy.RotationAngle.Z
    ]));

  p := Main.Frame3D.GetRotationInfo;
  fs := Format('RI: %s', [ft]);
  SL.Add(Format(fs, [
    -p.X,
    -p.Y,
    -p.Z
    ]));

  SL.Insert(HeaderIndex, '');
  SL.Insert(HeaderIndex, 'RI = Rotation Info (Euler Angles)');
  SL.Insert(HeaderIndex, 'RA = CameraDummy.RotationAngle');
  SL.Insert(HeaderIndex, 'Rotation Info');
  result := SL.Text;
end;

function TFederReport1.GetViewStatus: string;
var
  ft: string;
  fs: string;
  p: TPoint3D;
begin
  SL.Clear;
  GetAppStatus;

  ft := '%7.2f %7.2f %7.2f';
  fs := Format('CDRA: %s', [ft]);
  SL.Add(Format(fs, [
    Main.Frame3D.CameraDummy.RotationAngle.X,
    Main.Frame3D.CameraDummy.RotationAngle.Y,
    Main.Frame3D.CameraDummy.RotationAngle.Z
    ]));

  p := Main.Frame3D.GetRotationInfo;
  fs := Format('F3RI: %s', [ft]);
  SL.Add(Format(fs, [
    -p.X,
    -p.Y,
    -p.Z
    ]));

  fs := Format('CARA: %s', [ft]);
  SL.Add(Format(fs, [
    Main.Frame3D.Camera00.RotationAngle.X,
    Main.Frame3D.Camera00.RotationAngle.Y,
    Main.Frame3D.Camera00.RotationAngle.Z
    ]));

  fs := Format('CAPO: %s', [ft]);
  SL.Add(Format(fs, [
    Main.Frame3D.Camera00.Position.X,
    Main.Frame3D.Camera00.Position.Y,
    Main.Frame3D.Camera00.Position.Z
    ]));

  if Main.Want2D then
  begin
    fs := Format('PBNP: %s', [ft]);
    SL.Add(Format(fs, [
      MainVar.Transform2D.NullPunktX,
      MainVar.Transform2D.NullPunktY,
      MainVar.Transform2D.PaintboxRotation
      ]));
  end;

  p := Main.FederScene.ModelGroupRot;
  fs := Format('MGRA: %s', [ft]);
  SL.Add(Format(fs, [
    p.X,
    p.Y,
    p.Z
    ]));

  p := Main.FederScene.ModelGroupPos;
  fs := Format('MGPO: %s', [ft]);
  SL.Add(Format(fs, [
    p.X,
    p.Y,
    p.Z
    ]));

  SL.Insert(HeaderIndex, 'View Status');
  result := SL.Text;
end;

function TFederReport1.GetModelStatus: string;
var
  ft1: string;
  ft2: string;
  ft3: string;
  ft4: string;
  fs: string;
begin
  SL.Clear;
  GetAppStatus;
  ft1 := '%7.2f';
  ft2 := '%7.2f %7.2f';
  ft3 := '%7.2f %7.2f %7.2f';
  ft4 := '%7.2f %7.2f %7.2f %7.2f';
  with Main.FederModel.Equation do
  begin
    if WantShortTable then
    case Main.FederModel.Scene of
      4:
      begin
        fs := Format('x: %s', [ft4]);
        SL.Add(Format(fs, [x1, x2, x3, x4]));
        fs := Format('y: %s', [ft4]);
        SL.Add(Format(fs, [y1, y2, y3, y4]));
        fs := Format('z: %s', [ft4]);
        SL.Add(Format(fs, [z1, z2, z3, z4]));
        fs := Format('l: %s', [ft4]);
        SL.Add(Format(fs, [l1, l2, l3, l4]));
        if WantK then
        begin
        fs := Format('k: %s', [ft4]);
        SL.Add(Format(fs, [k1, k2, k3, k4]));
        end;
        fs := Format('m: %s', ['%7d %7d %7d %7d']);
        SL.Add(Format(fs, [m1, m2, m3, m4]));
      end;
      2:
      begin
        fs := Format('x: %s', [ft2]);
        SL.Add(Format(fs, [x1, x2]));
        fs := Format('y: %s', [ft2]);
        SL.Add(Format(fs, [y1, y2]));
        fs := Format('z: %s', [ft2]);
        SL.Add(Format(fs, [z1, z2]));
        fs := Format('l: %s', [ft2]);
        SL.Add(Format(fs, [l1, l2]));
        if WantK then
        begin
        fs := Format('k: %s', [ft2]);
        SL.Add(Format(fs, [k1, k2]));
        end;
        fs := Format('m: %s', ['%7d %7d']);
        SL.Add(Format(fs, [m1, m2]));
      end;
      3:
      begin
        fs := Format('x: %s', [ft3]);
        SL.Add(Format(fs, [x1, x2, x3]));
        fs := Format('y: %s', [ft3]);
        SL.Add(Format(fs, [y1, y2, y3]));
        fs := Format('z: %s', [ft3]);
        SL.Add(Format(fs, [z1, z2, z3]));
        fs := Format('l: %s', [ft3]);
        SL.Add(Format(fs, [l1, l2, l3]));
        if WantK then
        begin
        fs := Format('k: %s', [ft3]);
        SL.Add(Format(fs, [k1, k2, k3]));
        end;
        fs := Format('m: %s', ['%7d %7d %7d']);
        SL.Add(Format(fs, [m1, m2, m3]));
      end;
      else
      begin
        fs := Format('x: %s', [ft1]);
        SL.Add(Format(fs, [x1]));
        fs := Format('y: %s', [ft1]);
        SL.Add(Format(fs, [y1]));
        fs := Format('z: %s', [ft1]);
        SL.Add(Format(fs, [z1]));
        fs := Format('l: %s', [ft1]);
        SL.Add(Format(fs, [l1]));
        if WantK then
        begin
        fs := Format('k: %s', [ft1]);
        SL.Add(Format(fs, [k1]));
        end;
        fs := Format('m: %s', ['%7d']);
        SL.Add(Format(fs, [m1]));
      end;
    end
    else
    begin
      fs := Format('x: %s', [ft4]);
      SL.Add(Format(fs, [x1, x2, x3, x4]));
      fs := Format('y: %s', [ft4]);
      SL.Add(Format(fs, [y1, y2, y3, y4]));
      fs := Format('z: %s', [ft4]);
      SL.Add(Format(fs, [z1, z2, z3, z4]));
      fs := Format('l: %s', [ft4]);
      SL.Add(Format(fs, [l1, l2, l3, l4]));
      if WantK then
      begin
      fs := Format('k: %s', [ft4]);
      SL.Add(Format(fs, [k1, k2, k3, k4]));
      end;
      fs := Format('m: %s', ['%7d %7d %7d %7d']);
      SL.Add(Format(fs, [m1, m2, m3, m4]));
    end;

  end;
  SL.Insert(HeaderIndex, 'Model Status');
  result := SL.Text;
end;


function TFederReport1.GetMatrixInfo: string;
begin
  SL.Clear;
  GetAppStatus;
  Main.FederScene.GetMatrixInfo(SL);
  SL.Insert(HeaderIndex, 'CameraDummy');
  SL.Insert(HeaderIndex, 'Matrix Info');
  result := SL.Text;
end;

function TFederReport1.GetMeshDataInfo: string;
begin
  result := Main.MeshBuilder.GetMeshDataReport(0);
end;

function TFederReport1.GetLightInfo: string;
begin
  SL.Clear;
  GetAppStatus;
  Main.FederScene.GetLightInfo(SL);
  SL.Insert(HeaderIndex, 'Light Info');
  result := SL.Text;
end;

function TFederReport1.GetLockStatus: string;
begin
  SL.Clear;
  GetAppStatus;
  SL.Add('ReportLock     : ' +  IntToStr(BoolInt[Main.ReportLock]));
  SL.Add('BackgroundLock : ' +  IntToStr(BoolInt[Main.FederData.BackgroundLock]));
  SL.Add('TextureLock    : ' +  IntToStr(BoolInt[Main.FederData.TextureLock]));
  SL.Add('LuxLock        : ' +  IntToStr(BoolInt[Main.FederData.LuxLock]));
  SL.Add('ParamLock      : ' +  IntToStr(BoolInt[Main.FederData.ParamLock]));
  SL.Add('ForceLock      : ' +  IntToStr(BoolInt[Main.FederData.ForceLock]));
  SL.Insert(HeaderIndex, 'Lock Status');
  result := SL.Text;
end;


function TFederReport1.GetColorInfo1: string;
begin
  SL.Clear;
  Main.FederTexture.BitmapBuilder.GetBandInfo(1, SL);
  SL.Insert(0, 'Color Info 1');
  result := SL.Text;
end;

function TFederReport1.GetColorInfo2: string;
begin
  SL.Clear;
  Main.FederTexture.BitmapBuilder.GetBandInfo(2, SL);
  SL.Insert(0, 'Color Info 2');
  result := SL.Text;
end;

function TFederReport1.GetAppStatus: string;
begin
  GetAppStatus2;
end;

function TFederReport1.GetAppStatus2: string;
var
  s1: string;
  s2: string;
  s3: string;
  s: string;
begin
  s1 := 'Bundle ' + IntToStr(Main.SampleManager.BundleID);
  s2 := 'Sample ' +  Format('%d-%d-%d', [Main.Level, Main.Hub, Main.Sample]);
  s3 := Format('SGF %d', [100 * Main.FederModel.Scene + 10 * Main.FederModel.Graph + Main.FederModel.Figure]);
  s := s1 + '; ' + s2 + '; ' +  s3 + ';';
  SL.Add(s);

  s1 := 'MeshSize ' + IntToStr(Main.FederModel.MeshSize);
  s2 := 'Plot ' + IntToStr(Main.FederModel.Plot);
  s3 := 'PlotFigure ' + IntToStr(Main.FederModel.PlotFigure);
  s := s1 + '; ' + s2 + '; ' +  s3 + ';';
  SL.Add(s);

  s1 := 'Pin ' + IntToStr(BoolInt[Main.FederModel.Pin]);
  s2 := 'Norm ' + IntToStr(BoolInt[Main.FederModel.Norm]);
  s3 := 'TextureNorm ' + IntToStr(Main.FederModel.TextureNorm);
  s := s1 + '; ' + s2 + '; ' +  s3 + ';';
  SL.Add(s);

  s1 := 'Bitmap ' + IntToStr(Main.FederScene.Bitmap);
  s2 := 'Param ' + IntToStr(Main.FederModel.Param);
  s3 := 'SVC ' + IntToStr(Main.ParallelAnimation.SetValueCounter);
  s := s1 + '; ' + s2 + '; ' + s3 + ';';
  SL.Add(s);

  SL.Add('');
  HeaderIndex := SL.Count;
end;

function TFederReport1.GetAppStatus1: string;
begin
  SL.Add(Format('%d-%d-%d', [Main.Level, Main.Hub, Main.Sample]));
  SL.Add(TFederUtils.GetMessageKindLabel(fmkScene) + ' ' + IntToStr(Main.FederModel.Scene));
  SL.Add(TFederUtils.GetMessageKindLabel(fmkGraph) + ' ' + IntToStr(Main.FederModel.Graph) + '-' + IntToStr(BoolInt[Main.FederModel.Norm]));
  SL.Add(TFederUtils.GetMessageKindLabel(fmkPlot) + ' ' + IntToStr(Main.FederModel.Plot) + '-' + IntToStr(BoolInt[Main.FederModel.Pin]));
  SL.Add(TFederUtils.GetMessageKindLabel(fmkFigure) + ' ' + IntToStr(Main.FederModel.Figure));
  SL.Add(TFederUtils.GetMessageKindLabel(fmkBitmap) + ' ' + IntToStr(Main.FederScene.Bitmap) + '-' + IntToStr(Main.FederModel.TextureNorm));
  SL.Add(TFederUtils.GetMessageKindLabel(fmkMeshSize) + ' ' + IntToStr(Main.FederModel.MeshSize));
  SL.Add('');
  HeaderIndex := SL.Count;
end;

end.
