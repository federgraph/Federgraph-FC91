unit RiggVar.Conn.Input;

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
  System.Classes;

type
  TFederRecorder = class
  private
    ML1, ML2: TStrings;
    FAutoSend: Boolean;
    procedure SetAutoSend(const Value: Boolean);
  public
    LastMsg: string;
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure RecordMsg(s: string);
    procedure Send;

    property AutoSend: Boolean read FAutoSend write SetAutoSend;
  end;

implementation

uses
  RiggVar.App.Main;

(*
const
  spHost = 0;
  spPort = 1;

//    FederConnection: TFederInputConnection;
//    GameController: TFederGameController;
//    GameUpdate: TGridUpdate;

procedure TFormMain.ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
begin
  if Assigned(Main) then
    if not AppIsClosing then
    begin
      GameUpdate.DoOnIdle;
    end;
  Done := True;
end;

procedure TFormMain.Init;
begin
  Main := TMain.Create;

  FederConnection := TFederInputConnection.Create;
  FederConnection.ConnectBtn := ConnectBtn;
  FederConnection.DisconnectBtn := DisconnectBtn;
  FederConnection.OnUpdateLED := OnUpdateLED;
  FederConnection.Init;
  OnUpdateLED(nil);

  { GameController }
  GameController := TFederGameController.Create;
  GameController.OnProductionEvent := OnRecorderEvent;

  { AutoConnector}
  Main.AutoConnector.Connection := FederConnection;
  Main.AutoConnector.Run;

  GameUpdate := TGridUpdate.Create;
  GameUpdate.OnUpdateView := UpdateGame;
  GameUpdate.Delay := 50;
  GameUpdate.ViewEnabled := True;

  AutoSend := True;
end;

procedure TFormMain.CheckBtnClick(Sender: TObject);
begin
  GameController.Check;
end;

procedure TFormMain.ClearBtnClick(Sender: TObject);
begin
  ML1.Clear;
  ML2.Clear;
end;

procedure TFormMain.EditBtnClick(Sender: TObject);
var
  FormConn: TFormConn;
begin
  FormConn := TFormConn.Create(nil);
  FormConn.edHost.Text := Main.IniImage.Host;
  FormConn.edPort.Text := IntToStr(Main.IniImage.Port);
  if FormConn.ShowModal = mrOK then
  begin
    Main.IniImage.Host := FormConn.edHost.Text;
    Main.IniImage.Port := StrToIntDef(FormConn.edPort.Text, Main.IniImage.Port);
  end;
  FormConn.Free;
end;

procedure TFormMain.AutoSendBtnClick(Sender: TObject);
begin
  AutoSend := not AutoSend;
end;

procedure TFormMain.SetAutoSend(const Value: Boolean);
begin
  FAutoSend := Value;
end;

procedure TFormMain.OnUpdateLED(Sender: TObject);
var
  cla: TColor;
begin
  StatusBar.Panels[spHost].Text := FederConnection.HostPanelText;
  StatusBar.Panels[spPort].Text := FederConnection.PortPanelText;

  case FederConnection.FLEDColor of
    csRed:
      cla := clRed;
    csYellow:
      cla := clYellow;
    csGreen:
      cla := clLime;
  else
    cla := clGray;
  end;
  LED.Brush.Color := cla;
  EditBtn.Enabled := cla = clRed;
end;

procedure TFormMain.OnRecorderEvent(k: string; v: Integer);
begin
  RecordMsg(k + '=' + IntToStr(v));
end;

procedure TFormMain.UpdateGame(Sender: TObject);
begin
  if Assigned(Main) then
    if not AppIsClosing then
    begin
      GameController.Loop;
    end;
end;

*)

{ TFederRecorder }

constructor TFederRecorder.Create;
begin
  ML1 := TStringList.Create;
  ML2 := TStringList.Create;
end;

destructor TFederRecorder.Destroy;
begin
  ML1.Free;
  ML2.Free;
  inherited;
end;

procedure TFederRecorder.Clear;
begin
  ML1.Clear;
  ML2.Clear;
end;

procedure TFederRecorder.SetAutoSend(const Value: Boolean);
begin
  FAutoSend := Value;
end;

procedure TFederRecorder.RecordMsg(s: string);
begin
  LastMsg := s;
  Main.FederText.UpdateTextQuick;

  if AutoSend then
  begin
    ML1.Clear;
  end;
  if ML1.Count > 200 then
    ML1.Delete(0);
  ML1.Add(s);
  if AutoSend then
    Send;
end;

procedure TFederRecorder.Send;
begin
  Main.ProcessInput(ML1, ML2);
end;

end.
