unit RiggVar.Conn.DelphiClient;

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

{$IFDEF MSWINDOWS}
uses
  SysUtils,
  Classes,
  ScktComp;

type
  THandleMsgEvent = procedure(Sender: TObject; s: string) of object;

  TClient = class
  private
    FOnHandleMsg: THandleMsgEvent;
    FOnConnectedChanged: TNotifyEvent;
    function GetIsConnected: Boolean;
  protected
    FBuffer: string;
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure HandleMsg(s: string);
  public
    ClientSocket: TClientSocket;
    constructor Create;
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
    property IsConnected: Boolean read GetIsConnected;
  end;

  TConnUtils = class
  private
    class function ReceiveText(Sender: TObject; Socket: TCustomWinSocket)
      : string; static;
    class function SendMsg(Socket: TCustomWinSocket; s: string;
      UseUnicode: Boolean = true): Boolean; static;
    class function SendMsg_Ansi(Socket: TCustomWinSocket; s: string)
      : Boolean; static;
    class function SendMsg_UTF8(Socket: TCustomWinSocket; s: string)
      : Boolean; static;
  protected
    class function SendMsg_MemStream(Socket: TCustomWinSocket; s: string)
      : Boolean; static;
  end;

{$ENDIF}

implementation

uses
  RiggVar.App.Main;

{ TConnUtils }

{$IFDEF MSWINDOWS}

class function TConnUtils.ReceiveText(Sender: TObject;
  Socket: TCustomWinSocket): string;
var
  s: AnsiString;
begin
  SetLength(s, Socket.ReceiveLength);
  SetLength(s, Socket.ReceiveBuf(Pointer(s)^, Length(s)));
  result := string(s);
end;

class function TConnUtils.SendMsg_Ansi(Socket: TCustomWinSocket;
  s: string): Boolean;
var
  ansi: AnsiString;
  i: Integer;
begin
  result := false;
  ansi := AnsiString(s);
  if Assigned(Socket) then
  begin
    i := Socket.SendText(AnsiChar(#2) + ansi + AnsiChar(#3));
    result := i = Length(s) + 2;
  end;
end;

class function TConnUtils.SendMsg_UTF8(Socket: TCustomWinSocket;
  s: string): Boolean;
var
  i: Integer;
  utf8: Utf8String;
  ansi: AnsiString;
begin
  result := false;
  utf8 := UTF8Encode(s);
  utf8 := AnsiChar(#2) + utf8 + AnsiChar(#3);
  ansi := AnsiString(utf8);
  if Assigned(Socket) then
  begin
    i := Socket.SendText(ansi);
    result := i = Length(ansi);
  end;
end;

class function TConnUtils.SendMsg_MemStream(Socket: TCustomWinSocket;
  s: string): Boolean;
var
  utf8: Utf8String;
  bom: TBytes;
  b: byte;
  ms: TMemoryStream;
begin
  result := false;
  ms := TMemoryStream.Create;
  try
    b := 2;
    ms.Write(b, SizeOf(b));
    bom := TEncoding.utf8.GetPreamble;
    ms.Write(bom[0], Length(bom));
    utf8 := UTF8Encode(s);
    ms.Write(Pointer(utf8)^, Length(utf8));
    b := 3;
    ms.Write(b, SizeOf(b));
    if Assigned(Socket) then
    begin
      result := Socket.SendStream(ms);
    end;
  finally
    ms.Free;
  end;
end;

class function TConnUtils.SendMsg(Socket: TCustomWinSocket; s: string;
  UseUnicode: Boolean): Boolean;
var
  uni: Boolean;
begin
  uni := UseUnicode and Main.IniImage.UseUnicode;
  if uni then
    result := SendMsg_UTF8(Socket, s)
  else
    result := SendMsg_Ansi(Socket, s);
end;

{ TClient }

constructor TClient.Create;
begin
  ClientSocket := TClientSocket.Create(nil);
  ClientSocket.OnRead := ClientSocketRead;
  ClientSocket.OnError := ClientSocketError;
  ClientSocket.OnConnect := ClientSocketConnect;
  ClientSocket.OnDisConnect := ClientSocketDisconnect;
end;

procedure TClient.Init(AHost: string; APort: Integer);
begin
  ClientSocket.Host := AHost;
  ClientSocket.Port := APort;
end;

destructor TClient.Destroy;
begin
  ClientSocket.Active := False;
  ClientSocket.Close;
  ClientSocket.Free;
  inherited;
end;

procedure TClient.Connect;
begin
  ClientSocket.Active := True;
end;

procedure TClient.Disconnect;
begin
  if ClientSocket.Active then
    ClientSocket.Active := False;
end;

function TClient.GetIsConnected: Boolean;
begin
  result := ClientSocket.Active;
end;

procedure TClient.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if Assigned(OnConnectedChanged) then
    OnConnectedChanged(Self);
end;

procedure TClient.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if Assigned(OnConnectedChanged) then
    OnConnectedChanged(Self);
end;

procedure TClient.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  s: string;
  c: char;
  i: Integer;
begin
  s := TConnUtils.ReceiveText(Sender, Socket);
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

function TClient.SendMsg(s: string): Boolean;
begin
  result := TConnUtils.SendMsg(ClientSocket.Socket, s);
end;

procedure TClient.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  Main.Logger.Error('Error connecting to ' + ClientSocket.Host);
  ErrorCode := 0;
end;

function TClient.Host: string;
begin
  result := ClientSocket.Host;
end;

function TClient.Port: Integer;
begin
  result := ClientSocket.Port;
end;

procedure TClient.HandleMsg(s: string);
begin
  if Assigned(OnHandleMsg) then
    OnHandleMsg(Self, s);
end;

{$endif}

end.
