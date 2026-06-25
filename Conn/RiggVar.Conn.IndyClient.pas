unit RiggVar.Conn.IndyClient;

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
  SysUtils,
  Classes,
  IdStack,
  IdGlobal,
  IdIOHandler,
  IdIOHandlerSocket,
  IdTCPClient;

type
  THandleMsgEvent = procedure(Sender: TObject; s: string) of object;

  TReceiveThread = class(TThread)
  private
    FBuffer: string;
    FDataAvailable: THandleMsgEvent;
    procedure SetDataAvailable(const Value: THandleMsgEvent);
  protected
    procedure Execute; override;
  public
    IO: TIdIOHandler;
    tc: TIdTCpClient;
    FSocket: TIdIOHandlerSocket;
    destructor Destroy; override;
    procedure HandleData;
    property OnDataAvailable: THandleMsgEvent read FDataAvailable write SetDataAvailable;
  end;

  TClient = class
  private
    ReceiveThread: TReceiveThread;
    tc: TIdTCPClient;
    FHost: string;
    FPort: Integer;
    FIsConnected: Boolean;
    FOnHandleMsg: THandleMsgEvent;
    FOnConnectedChanged: TNotifyEvent;
    FBuffer: string;
    procedure ReadFromSocket;
    procedure HandleMsg(s: string);
    procedure SessionConnected(Sender: TObject);
    procedure SessionDisconnected(Sender: TObject);
    procedure DataAvailable(Sender: TObject; s: string);
    procedure InitSocket;
  public
    destructor Destroy; override;
    procedure Init(AHost: string; APort: Integer);
    function Host: string;
    function Port: Integer;
    function SendMsg(s: string): Boolean;
    procedure Connect;
    procedure Disconnect;
    property OnHandleMsg: THandleMsgEvent read FOnHandleMsg write FOnHandleMsg;
    property OnConnectedChanged: TNotifyEvent read FOnConnectedChanged
      write FOnConnectedChanged;
    property IsConnected: Boolean read FIsConnected;
  end;

implementation

uses
  RiggVar.App.Main;

{ TReceiveThread }

destructor TReceiveThread.Destroy;
begin
  tc.Free;
  inherited;
end;

procedure TReceiveThread.Execute;
begin
  Assert(FSocket <> nil, 'FSocket must not be nil');
  while not Terminated do
  begin
    IO.CheckForDataOnSource(2);
    if not IO.InputBufferIsEmpty then
    begin
      FBuffer := IO.ReadLn(char(#3));
      if FBuffer <> '' then
      begin
        Synchronize(HandleData);
        //HandleData;
        FBuffer := '';
      end;
    end;
  end;
end;

procedure TReceiveThread.HandleData;
begin
  if Assigned(OnDataAvailable) then
    OnDataAvailable(self, FBuffer + char(#3));
end;

procedure TReceiveThread.SetDataAvailable(const Value: THandleMsgEvent);
begin
  FDataAvailable := Value;
end;

{ TClient }

destructor TClient.Destroy;
begin
  if Assigned(tc) then
  begin
    tc.OnConnected := nil;
    tc.OnDisconnected := nil;
    if tc.Connected then
      tc.Disconnect;
    if Assigned(ReceiveThread) then
    begin
      ReceiveThread.OnDataAvailable := nil;
      ReceiveThread.FreeOnTerminate := True;
      ReceiveThread.Terminate;
    end
    else
      tc.Free;
  end;
  inherited;
end;

procedure TClient.ReadFromSocket;
begin
  if not Assigned(ReceiveThread) then
  begin
    try
      ReceiveThread := TReceiveThread.Create(true);
      ReceiveThread.IO := tc.IOHandler;
      ReceiveThread.tc := tc;
      ReceiveThread.FSocket := tc.Socket;
      ReceiveThread.OnDataAvailable := DataAvailable;
      //ReceiveThread.FreeOnTerminate := True;
      ReceiveThread.Start;
    except
    end;
  end;
end;

procedure TClient.Init(AHost: string; APort: Integer);
begin
  FHost := AHost;
  FPort := APort;
end;

function TClient.Host: string;
begin
  result := FHost;
end;

function TClient.Port: Integer;
begin
  result := FPort;
end;

procedure TClient.InitSocket;
begin
  tc := TIdTCPClient.Create(nil);
  tc.Host := FHost;
  tc.Port := FPort;
  tc.ConnectTimeout := 3000;
  //tc.ReuseSocket := TIdReuseSocket.rsTrue;
  tc.OnConnected := SessionConnected;
  tc.OnDisconnected := SessionDisconnected;
end;

procedure TClient.SessionConnected(Sender: TObject);
begin
  if tc.IOHandler.Connected then
  begin
    FIsConnected := True;
    ReadFromSocket;
  end
  else
  begin
    FIsConnected := False;
  end;
  if Assigned(OnConnectedChanged) then
    OnConnectedChanged(Self);
end;

procedure TClient.SessionDisconnected(Sender: TObject);
begin
  FIsConnected := False;
  if Assigned(OnConnectedChanged) then
    OnConnectedChanged(Self);
end;

procedure TClient.DataAvailable(Sender: TObject; s: string);
var
  c: char;
  i: Integer;
begin
  for i := 1 to Length(s) do
  begin
    c := s[i];
    if c = #2 then
      FBuffer := ''
    else if c = #3 then
    begin
      HandleMsg(FBuffer);
      FBuffer := '';
    end
    else
      FBuffer := FBuffer + c;
  end;
end;

procedure TClient.HandleMsg(s: string);
begin
  if Assigned(OnHandleMsg) then
    OnHandleMsg(Self, s);
end;

function TClient.SendMsg(s: string): Boolean;
var
//  b: TBytes;
  c: TIdBytes;
begin
  result := False;
//  b := TEncoding.UTF8.GetBytes(char(#2) + s + char(#3));
  c := IndyTextEncoding_UTF8.GetBytes(char(#2) + s + char(#3));
  tc.IOHandler.WriteDirect(c);
end;

procedure TClient.Connect;
begin
  try
    if not Assigned(tc) then
      InitSocket;
    if not FIsConnected then
    begin
      FIsConnected := True;
      tc.Connect;
    end;
  except on e: EIdSocketError do
    Main.Logger.Info(Format('Cannot connect to Host:%s Port:%d', [Main.IniImage.Host, Main.IniImage.Port]));
  end;
end;

procedure TClient.Disconnect;
begin
  FIsConnected := False;
  if Assigned(ReceiveThread) then
  begin
    try
      tc.Disconnect;
      ReceiveThread.tc := nil;
      ReceiveThread.FreeOnTerminate := True;
      ReceiveThread.Terminate;
      //ReceiveThread.Free;
      ReceiveThread := nil;
    except
    end;
  end;
end;

end.
