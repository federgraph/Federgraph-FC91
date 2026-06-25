unit RiggVar.Conn.DummyClient;

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
  System.Classes;

type
  THandleMsgEvent = procedure(Sender: TObject; s: string) of object;

  TClient = class
  private
    FHost: string;
    FPort: Integer;
    FIsConnected: Boolean;
    FOnHandleMsg: THandleMsgEvent;
    FOnConnectedChanged: TNotifyEvent;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init(AHost: string; APort: Integer);
    function Host: string;
    function Port: Integer;
    function SendMsg(s: string): Boolean;
    procedure Connect;
    procedure Disconnect;
    property OnHandleMsg: THandleMsgEvent read FOnHandleMsg write FOnHandleMsg;
    property OnConnectedChanged: TNotifyEvent read FOnConnectedChanged write FOnConnectedChanged;
    property IsConnected: Boolean read FIsConnected;
  end;

implementation

constructor TClient.Create;
begin
end;

procedure TClient.Init(AHost: string; APort: Integer);
begin
  FHost := AHost;
  FPort := APort;
end;

destructor TClient.Destroy;
begin
end;

function TClient.Host: string;
begin
  result := FHost;
end;

function TClient.Port: Integer;
begin
  result := FPort;
end;

function TClient.SendMsg(s: string): Boolean;
begin
  result := false;
end;

procedure TClient.Connect;
begin
  if not FIsConnected then
    FIsConnected := True;
end;

procedure TClient.Disconnect;
begin
  FIsConnected := False;
end;

end.

