unit RiggVar.Conn.MsgToken;

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

var
  cAppTitle: string = 'App';

  cTokenID: string = 'SNR';
  cTokenBib: string = 'Bib';
  cTokenCount: string = 'Count';
  cTokenMsg: string = 'Msg';

  //master tokens, specific for application category:
  cTokenA: string = 'A';
  cTokenB: string = 'B';
  cTokenZ: string = 'Z';
  cTokenY: string = 'Y';
  cTokenX1: string = 'X1';
  cTokenX2: string = 'X2';
  cTokenX3: string = 'X3';
  cTokenX4: string = 'X4';
  cTokenX5: string = 'X5';
  cTokenX6: string = 'X6';
  cTokenXX: string = 'XX';

  //slave tokens, updated in SetDivisionName at runtime:
  cTokenSport: string = 'A.*.';
  cTokenOutput: string = 'A.*.Output.';
  cTokenAnonymousRequest: string = 'A.*.Request.';
  cTokenAnonymousOutput: string = 'A.*.Output.';

  cDefaultPortSet: Integer = 3;

function LongToken(t: string): string;
procedure SetDivisionName(const Value: string);

implementation

function LongToken(t: string): string;
begin
  //long tokens are disabled
  result := t;
end;

procedure SetDivisionName(const Value: string);
begin
  cTokenB := Value;
  cTokenSport := cTokenA + '.' + Value + '.';
  cTokenOutput := cTokenSport + 'Output.';
  cTokenAnonymousRequest := cTokenA + '.*.Request.';
  cTokenAnonymousOutput := cTokenA + '.*.Output.';
end;

end.
