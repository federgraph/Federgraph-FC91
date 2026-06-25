unit RiggVar.FB.Report;

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
  System.Types,
  RiggVar.FB.DefConst;

type
  TFederReport = class
  protected
    SL: TStringList;
  public
    WantShortTable: Boolean;
    constructor Create;
    destructor Destroy; override;

    function GetReport(AReportPage: TReportPage): string;

    function GetRingInfo: string; virtual;
    function GetColorMapping: string; virtual;
    function GetSelectedColors: string; virtual;
    function GetAppInfo: string; virtual;

    function GetModelStatus: string; virtual;
    function GetViewStatus: string; virtual;
    function GetRotationInfo: string; virtual;
    function GetZoomInfo: string; virtual;
    function GetMatrixInfo: string; virtual;
    function GetLightInfo: string; virtual;
    function GetLockStatus: string; virtual;
    function GetColorInfo1: string; virtual;
    function GetColorInfo2: string; virtual;
    function GetMeshDataInfo: string; virtual;
    function GetBufferInfo: string; virtual;
    function GetBufferDesc: string; virtual;
    function GetInfoMemo: string; virtual;
  end;

implementation

uses
  FMX.Forms,
  RiggVar.FB.Def,
  RiggVar.App.Main;

constructor TFederReport.Create;
begin
  SL := TStringList.Create;
end;

destructor TFederReport.Destroy;
begin
  SL.Free;
  inherited;
end;

function TFederReport.GetRingInfo: string;
begin
  SL.Clear;
  SL.Add('Ring Info');
  SL.Add('');
  Main.GetRingInfoReport(SL);
  result := SL.Text;
end;

function TFederReport.GetColorMapping: string;
begin
  SL.Clear;
  SL.Add('Color Mapping');
  SL.Add('');
  Main.RingBuilder.GetColorMappingReport(SL);
  result := SL.Text;
end;

function TFederReport.GetSelectedColors: string;
begin
  SL.Clear;
  SL.Add('Selected Colors');
  SL.Add('');
  Main.RingBuilder.ListSelectedColors(SL);
  result := SL.Text;
end;

function TFederReport.GetAppInfo: string;
begin
  SL.Clear;
  SL.Add('App Info');
  SL.Add('');
  SL.Add('-     F                           -');
  SL.Add('-    * * *                        -');
  SL.Add('-   *   *   G                     -');
  SL.Add('-  *     * *   *                  -');
  SL.Add('- E - - - H - - - I               -');
  SL.Add('-  *     * *         *            -');
  SL.Add('-   *   *   *           *         -');
  SL.Add('-    * *     *             *      -');
  SL.Add('-     D-------A---------------B   -');
  SL.Add('-              *                  -');
  SL.Add('-              (C) federgraph.de  -');

  result := SL.Text;
end;

function TFederReport.GetRotationInfo: string;
begin
  SL.Clear;
  SL.Insert(0, 'Rotation Info');
  result := SL.Text;
end;

function TFederReport.GetModelStatus: string;
var
  ft1: string;
  ft2: string;
  ft3: string;
  ft4: string;
  fs: string;
begin
  SL.Clear;
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
        fs := Format('k: %s', [ft4]);
        SL.Add(Format(fs, [k1, k2, k3, k4]));
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
        fs := Format('k: %s', [ft2]);
        SL.Add(Format(fs, [k1, k2]));
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
        fs := Format('k: %s', [ft3]);
        SL.Add(Format(fs, [k1, k2, k3]));
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
        fs := Format('k: %s', [ft1]);
        SL.Add(Format(fs, [k1]));
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
      fs := Format('k: %s', [ft4]);
      SL.Add(Format(fs, [k1, k2, k3, k4]));
      fs := Format('m: %s', ['%7d %7d %7d %7d']);
      SL.Add(Format(fs, [m1, m2, m3, m4]));
    end;

  end;
  SL.Insert(0, 'Model Status');
  result := SL.Text;
end;

function TFederReport.GetViewStatus: string;
begin
  SL.Clear;
  SL.Insert(0, 'View Status');
  result := SL.Text;
end;

function TFederReport.GetMatrixInfo: string;
begin
  SL.Clear;
  SL.Insert(0, 'Matrix Info');
  result := SL.Text;
end;

function TFederReport.GetZoomInfo: string;
begin
  SL.Clear;
  SL.Insert(0, 'Zoom Info');
  result := SL.Text;
end;

function TFederReport.GetMeshDataInfo: string;
begin
  SL.Clear;
  SL.Insert(0, 'MeshData Info');
  result := SL.Text;
end;

function TFederReport.GetBufferInfo: string;
begin
  SL.Clear;
  SL.Insert(0, 'BufferInfo');
  result := SL.Text;
end;

function TFederReport.GetBufferDesc: string;
begin
  SL.Clear;
  SL.Insert(0, 'BufferDesc');
  result := SL.Text;
end;

function TFederReport.GetColorInfo1: string;
begin
  SL.Clear;
  SL.Insert(0, 'ColorInfo 1');
  result := SL.Text;
end;

function TFederReport.GetColorInfo2: string;
begin
  SL.Clear;
  SL.Insert(0, 'ColorInfo 2');
  result := SL.Text;
end;

function TFederReport.GetLightInfo: string;
begin
  SL.Clear;
  SL.Insert(0, 'Light Info');
  result := SL.Text;
end;

function TFederReport.GetInfoMemo: string;
begin
  SL.Clear;

  SL.Add(Format('Info: %s', [Application.Title]));
  SL.Add('');
  SL.Add('-     F                           -');
  SL.Add('-    * * *                        -');
  SL.Add('-   *   *   G                     -');
  SL.Add('-  *     * *   *                  -');
  SL.Add('- E - - - H - - - I               -');
  SL.Add('-  *     * *         *            -');
  SL.Add('-   *   *   *           *         -');
  SL.Add('-    * *     *             *      -');
  SL.Add('-     D-------A---------------B   -');
  SL.Add('-              *                  -');
  SL.Add('-              (C) federgraph.de  -');

  result := SL.Text;
end;

function TFederReport.GetLockStatus: string;
begin
  SL.Clear;
  SL.Add('ReportLock      : ' +  IntToStr(BoolInt[Main.ReportLock]));
  SL.Add('BackgroundLock : ' +  IntToStr(BoolInt[Main.FederData.BackgroundLock]));
  SL.Add('TextureLock    : ' +  IntToStr(BoolInt[Main.FederData.TextureLock]));
  SL.Add('LuxLock        : ' +  IntToStr(BoolInt[Main.FederData.LuxLock]));
  SL.Add('ParamLock      : ' +  IntToStr(BoolInt[Main.FederData.ParamLock]));
  SL.Add('ForceLock      : ' +  IntToStr(BoolInt[Main.FederData.ForceLock]));
  SL.Insert(0, 'Lock Status');
  result := SL.Text;
end;

function TFederReport.GetReport(AReportPage: TReportPage): string;
begin
  case AReportPage of
    rpZoomInfo: result := GetZoomInfo;
    rpRingInfo: result := GetRingInfo;
    rpColorMapping: result := GetColorMapping;
    rpSelectedColors: result := GetSelectedColors;
    rpAppInfo: result := GetAppInfo;
    rpModelStatus: result := GetModelStatus;
    rpLightInfo: result := GetLightInfo;
    rpViewStatus: result := GetViewStatus;
    rpRotationInfo: result := GetRotationInfo;
    rpMatrixInfo: result := GetMatrixInfo;
    rpLockStatus: result := GetLockStatus;
    rpColorInfo1: result := GetColorInfo1;
    rpColorInfo2: result := GetColorInfo2;
    rpInfoMemo: result := GetInfoMemo;
    rpMeshDataInfo: result := GetMeshDataInfo;
    rpBufferInfo: result := GetBufferInfo;
    rpBufferDesc: result := GetBufferDesc;
    else
      result := GetModelStatus;
  end;
end;

end.
