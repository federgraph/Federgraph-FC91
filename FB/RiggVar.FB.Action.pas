unit RiggVar.FB.Action;

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
  System.UITypes,
  RiggVar.FB.ActionConst,
  RiggVar.FB.DefConst;

type
  IFederActionHandler = interface
  ['{F4DE90A6-6D46-42F0-8119-F309A3802479}']
    procedure Execute(fa: TFederAction);
    function GetEnabled(fa: TFederAction): Boolean;
    function GetChecked(fa: TFederAction): Boolean;
    function GetCaption(fa: TFederAction): string;
    function GetShortCaption(fa: TFederAction): string;
    function GetShortcutString(fa: TFederAction): string;
    function GetActionName(fa: TFederAction): string;
    function GetActionGroup(fa: TFederAction): Integer;
  end;

  TFederActionHandlerBase = class(TInterfacedObject, IFederActionHandler)
  private
    FReportPage: TReportPage;
    FLanguage: Integer;
    procedure SetLanguage(const Value: Integer);
  protected
    procedure WriteActionTable; virtual;
  public
    procedure ViewportKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState); virtual;
    procedure ViewportKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState); virtual;

    procedure ExportTable(ML: TStrings); virtual;
    procedure CheckForDuplicates(ML: TStringList); virtual;
    procedure Execute(fa: TFederAction); virtual;
    function GetEnabled(fa: TFederAction): Boolean; virtual;
    function GetChecked(fa: TFederAction): Boolean; virtual;
    function GetCaption(fa: TFederAction): string; virtual;
    function GetShortCaption(fa: TFederAction): string; virtual;
    function GetShortcutString(fa: TFederAction): string; virtual;
    function GetReportPage(fa: TFederAction): TReportPage; virtual;
    function GetShortcutReport(ML: TStrings): string; virtual;

    function GetActionName(fa: TFederAction): string; virtual;
    function GetActionGroup(fa: TFederAction): Integer; virtual;

    property ReportPage: TReportPage read FReportPage write FReportPage;
    property Language: Integer read FLanguage write SetLanguage;
  end;

implementation

uses
  RiggVar.FB.ActionName,
  RiggVar.FB.ActionShort,
  RiggVar.FB.ActionLong;

function TFederActionHandlerBase.GetShortCaption(fa: TFederAction): string;
begin
  result := GetFederActionShort(fa);
end;

function TFederActionHandlerBase.GetShortcutString(fa: TFederAction): string;
begin
  { virtual, do nothing here }
  result := '';
end;

function TFederActionHandlerBase.GetShortcutReport(ML: TStrings): string;
begin
  { virtual, do nothing here }
  result := '';
end;

function TFederActionHandlerBase.GetActionName(fa: TFederAction): string;
begin
  result := GetFederActionName(fa);
end;

function TFederActionHandlerBase.GetActionGroup(fa: TFederAction): Integer;
begin
  result := 0;
end;

function TFederActionHandlerBase.GetCaption(fa: TFederAction): string;
begin
  result := GetFederActionLong(fa);
end;

function TFederActionHandlerBase.GetChecked(fa: TFederAction): Boolean;
begin
  result := False;
end;

function TFederActionHandlerBase.GetEnabled(fa: TFederAction): Boolean;
begin
  result := True;
end;

procedure TFederActionHandlerBase.Execute(fa: TFederAction);
begin
  { virtual, do nothing here }
end;

procedure TFederActionHandlerBase.CheckForDuplicates(ML: TStringList);
begin
  { not implemented here }
end;

procedure TFederActionHandlerBase.ExportTable(ML: TStrings);
begin
  { virtual, do nothing here }
end;

procedure TFederActionHandlerBase.WriteActionTable;
begin
  { virtual, do nothing here }
end;

procedure TFederActionHandlerBase.SetLanguage(const Value: Integer);
begin
  FLanguage := Value;
end;

procedure TFederActionHandlerBase.ViewportKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  { virtual }
end;

procedure TFederActionHandlerBase.ViewportKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  { virtual }
end;

function TFederActionHandlerBase.GetReportPage(fa: TFederAction): TReportPage;
var
  rp: TReportPage;
begin
  case fa of
    faSampleM,
    faSampleP,
    faGotoSample1,
    faSwapBundle,
    faParamX12,
    faParamY12,
    faParamZ12,
    faCycleX,
    faCycleY,
    faCycleZ,
    faCycleL,
    faCycleK,
    faParamT,
    faParamL,
    faParamK,
    faParamZ: rp := rpModelStatus;

    faParamRX,
    faParamRY,
    faParamRZ: rp := rpViewStatus;

    faParamCZ: rp := rpViewStatus;

    faToggleBackgroundLock,
    faToggleTextureLock,
    faToggleForceLock,
    faToggleLuxLock,
    faToggleParamLock: rp := rpLockStatus;

    faLux1On,
    faLux1Off,
    faLux2On,
    faLux2Off,
    faLux3On,
    faLux3Off,
    faLux4On,
    faLux4Off,
    faLightMode0,
    faLightMode1,
    faLightMode2,
    faLightMode3,
    faLightMode4,
    faToggleLux,
    faToggleLux1,
    faToggleLux2,
    faToggleLux3,
    faToggleLux4: rp := rpLightInfo;

    faBandSelection16,
    faBandSelection17: rp := rpColorInfo1;

    faParamBandWidth,
    faBandSelection18,
    faBandSelection19,
    faBandSelection20,
    faBandSelection21,
    faParamBandSelected: rp := rpColorInfo2;

    faShowInfo: rp := rpAppInfo;

    faToggleCrackFixing,
    faToggleZeroPulling,
    faToggleLimitPulling: rp := rpMeshDataInfo;

    faTakeCapValueSnapshot: rp := rpRingInfo;
    else
      rp := rpAny;
  end;
  result := rp;
end;

end.
