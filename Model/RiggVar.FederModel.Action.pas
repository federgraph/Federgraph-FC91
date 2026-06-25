unit RiggVar.FederModel.Action;

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
  RiggVar.FB.ActionConst,
  RiggVar.FB.Action,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst;

type
  TFederActionHandler = class(TFederActionHandlerBase)
  public
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure ViewportKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
    procedure ViewportKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState); override;

    function GetShortCaption(fa: TFederAction): string; override;
    function GetCaption(fa: TFederAction): string; override;
    procedure Execute(fa: TFederAction); override;
    function GetChecked(fa: TFederAction): Boolean; override;
    function GetEnabled(fa: TFederAction): Boolean; override;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FederModel.ActionExecute,
  RiggVar.FederModel.ActionChecked;

procedure TFederActionHandler.ViewportKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  fa: Integer;
begin
  if Main.Keyboard <> nil then
  begin
{$ifdef MSWINDOWS}
    fa := Main.Keyboard.KeyDownAction(Key, KeyChar, Shift);
{$endif}
{$ifdef MACOS}
    fa := Main.Keyboard.KeyUpAction(Key, KeyChar, Shift);
{$endif}
{$ifdef Android}
    fa := Main.Keyboard.KeyUpAction(Key, KeyChar, Shift);
{$endif}
    if fa <> faNoop then
    begin
      Execute(fa);
      Key := 0;
    end;
  end;
end;

procedure TFederActionHandler.ViewportKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  fa: Integer;
begin
  if Main.Keyboard <> nil then
  begin
{$ifdef MSWINDOWS}
    fa := Main.Keyboard.KeyUpAction(Key, KeyChar, Shift);
{$endif}
{$ifdef MACOS}
    fa := Main.Keyboard.KeyDownAction(Key, KeyChar, Shift);
{$endif}
{$ifdef Android}
    fa := Main.Keyboard.KeyDownAction(Key, KeyChar, Shift);
{$endif}
    if fa <> faNoop then
    begin
      Execute(fa);
      Key := 0;
    end;
  end;
end;

procedure TFederActionHandler.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  fa: Integer;
begin
  fa := faNoop;

  if ssCtrl in Shift then
  begin
    if Key = 49 then
      fa := faGraph1
    else if Key = 50 then
      fa := faGraph2
    else if Key = 51 then
      fa := faGraph3
    else if Key = 52 then
      fa := faGraph4
    else if Key = 53 then
      fa := faGraph5
  end;

  if fa <> faNoop then
    Execute(fa);
end;

procedure TFederActionHandler.Execute(fa: TFederAction);
var
  M: TMain;
begin
  if fa >= faMax then
    Exit;

  M := Main;
  if M = nil then
    Exit;

  if not M.IsUp then
  begin
    Exit;
  end;

  case fa of
    faToggleReportLock:
    begin
      M.ReportLock := not M.ReportLock;
      M.CheckStateNeeded;
    end;

    faNoop,
    faMax:
    begin
      { do nothing }
    end
    else
    begin
      if not M.ReportLock then
        ReportPage := GetReportPage(fa);
      M.CheckStateNeeded;
      M.TextUpdateNeeded;
      M.GraphUpdateNeeded;
    end;
  end;

  if not FederActionExecute(fa) then
  begin
    M.HandleAction(fa);
  end
  else
  begin
    M.BubbleUpAction(fa);
  end;

  M.GenActionMsg(fa);
end;

function TFederActionHandler.GetCaption(fa: TFederAction): string;
begin
  result := inherited;

  case fa of
    faAnimationStartA: result := 'A1-A-Script-L';

    faAnimationStartD: result := 'A2-D-CurrentSample-TargetSample-D';
    faAnimationStartF: result := 'A3-F-CurrentState-CurrentSample';
    faAnimationStartS: result := 'A4-S-CurrentSample-NextSample';
    faAnimationStartT: result := 'A5-T-CurrentSample-TargetSample';
  end;

  if Main.PaletteMode then
  begin
    case fa of
      faLayout0: result := 'Layout 0';
      faLayout1: result := 'Layout 1';
      faLayout2: result := 'Layout 2';
      faLayout3: result := 'Layout 3';
      faLayout4: result := 'Layout 4';
      faLayout5: result := 'Layout 5';
      faLayout6: result := 'PLABasic colors';
      faLayout7: result := 'PLAMatte colors';
      faLayout8: result := 'Bambulab dark colors';
      faLayout9: result := 'Bambulab light colors';
    end;
  end;
end;

function TFederActionHandler.GetChecked(fa: TFederAction): Boolean;
begin
  result := GetFederActionChecked(fa);
end;

function TFederActionHandler.GetEnabled(fa: TFederAction): Boolean;
begin
  result := True;
  case fa of
    faHubM,
    faHubP: result := Main.SampleManager.HubCount > 1;

    faLevelM,
    faLevelP: result :=
      (Main.SampleManager.BundleID = 2) and
      (Main.SampleManager.HubCount > 1) and
      (Main.SampleManager.Hub  > 0);

    faAnimationStartA: result := (Main.Param = 14) and not Main.AnimationPlayer.Playing;
    faAnimationStartD: result := not Main.AnimationPlayer.Playing;
    faAnimationStartT: result := not Main.AnimationPlayer.Playing;

    faTogglePCap: result := not Main.ReducedMesh;
    faToggleMCap: result := not Main.ReducedMesh;

    faShowEditField: result := MainVar.WantEditField;
    faToggleUniqueVertices: result := Main.FederScene.WantLux;

    faUniqueMode1,
    faUniqueMode2: result := Main.FederScene.WantLux and MainVar.WantUniqueVertices;
  end;
end;

function TFederActionHandler.GetShortCaption(fa: TFederAction): string;
begin
  case fa of
    faCLA: result := '';

    { Example }
    faExample01: result := 'E1';
    faExample02: result := 'E2';
    faExample03: result := 'E3';
    faExample04: result := 'E4';
    faExample05: result := 'E5';
    faExample06: result := 'E6';
    faExample07: result := 'E7';
    faExample08: result := 'E8';
    faExample09: result := 'E9';

  else
    result := inherited;
  end;
end;

end.
