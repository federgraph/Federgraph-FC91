unit RiggVar.Conn.Client;

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
{$ifdef ANDROID}
  RiggVar.Conn.DummyClient,
{$endif}
{$ifdef MACOS}
  RiggVar.Conn.DummyClient,
{$endif}
{$ifdef MSWINDOWS}
  RiggVar.Conn.DummyClient,
//  RiggVar.Conn.DelphiClient,
//  RiggVar.Conn.IndyClient,
//  RiggVar.Conn.IcsClient,
{$endif}
  System.SysUtils,
  System.Classes;

type
  TResultClient = class
  private
    procedure SetMsg(Sender: TObject; s: string);
    function GetConnected: Boolean;
    procedure SetConnected(const Value: Boolean);
  public
    Client: TClient;
    constructor Create(AHost: string; APort: Integer);
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
    procedure NewClient(AHost: string; APort: Integer);
    property Connected: Boolean read GetConnected write SetConnected;
  end;

implementation

{ TResultClient }

constructor TResultClient.Create(AHost: string; APort: Integer);
begin
  inherited Create;
  Client := TClient.Create;
  Client.Init(AHost, APort);
  Client.OnHandleMsg := SetMsg;
end;

destructor TResultClient.Destroy;
begin
  Client.Free;
  inherited;
end;

procedure TResultClient.Connect;
begin
  Client.Connect;
end;

procedure TResultClient.Disconnect;
begin
  Client.Disconnect;
end;

function TResultClient.GetConnected: Boolean;
begin
  result := false;
  if Assigned(Client) then
    result := Client.IsConnected;
end;

procedure TResultClient.NewClient(AHost: string; APort: Integer);
var
  ne: TNotifyEvent;
  hme: THandleMsgEvent;
begin
  if not Connected then
  begin
    ne := Client.OnConnectedChanged;
    hme := Client.OnHandleMsg;
    Client.Free;
    Client := TClient.Create;
    Client.Init(AHost, APort);
    Client.OnHandleMsg := SetMsg;
    Client.OnConnectedChanged := ne;
    Client.OnHandleMsg := hme;
  end;
end;

procedure TResultClient.SetConnected(const Value: Boolean);
begin
  Connect;
end;

procedure TResultClient.SetMsg(Sender: TObject; s: string);
begin
  {
  Default do nothing Eventhandler,
  dort wo die Instanz von TResultClient erzeugt wird
  wird normalerweise der spezielle Handler angehangen.
  }
end;

end.
