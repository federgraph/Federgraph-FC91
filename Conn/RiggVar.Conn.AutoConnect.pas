unit RiggVar.Conn.AutoConnect;

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
  RiggVar.Conn.Connection;

type
  TAutoConnector = class
  public
    Connection: TFederConnection;
    procedure Run;
  end;

implementation


{ TAutoConnector }

procedure TAutoConnector.Run;
begin
  if not Connection.ResultClient.Connected then
    Connection.ResultClient.Connect;

end;

end.
