unit RiggVar.EQ.Equation0S;

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
  RiggVar.FB.Equation;

type
  TFederEquation0S = class(TFederEquation)
  private
    g7: single;
  protected
    procedure f01(x, y: single);
  public
    procedure InitKoord; override;
    function GetValue(x, y : single): single; override;
    function CalcValue(x, y : single; af: Integer): single; override;
    function CalcRaw(x, y : single): single; override;
    function GetStatusLine: string; override;
  end;

implementation

procedure TFederEquation0S.InitKoord;
begin
  FaktorG3 := 500.0;
  FaktorEQ := 100 * 1000;
  MaxPlotFigure := 4;

  x1 :=  10; y1 := 10; l1 := 1; k1 := 1;
  x2 :=  20; y2 := 20; l2 := 1; k2 := 1;
  x3 :=  30; y3 := 30; l3 := 1; k3 := 1;
end;

function TFederEquation0S.GetValue(x, y: single): single;
begin
  result := 0;

  if Plot > -1 then
  begin
    result := CalcValue(x, y, Figure);
  end;

  if result > MaxInt then
    result := MaxInt;
  if result < -MaxInt then
    result := -MaxInt;
end;

function TFederEquation0S.CalcRaw(x, y: single): single;
begin
  if fcap < 1 then
    fcap := 1;
  f01(x, y);
  result := g7;
end;

function TFederEquation0S.CalcValue(x, y: single; af: Integer): single;
begin
  if fcap < 1 then
    fcap := 1;

  f01(x, y);

  result := g7 / fcap - OffsetZ;
  if PlusCap and (result > pcap) then
    result := pcap;
  if MinusCap and (result < mcap) then
    result := mcap;
end;

procedure TFederEquation0S.f01(x, y : single);
begin
  t2 := 10;
  t1 := 3.0 + l4 / 10;

  //x and y range from -3.1 to +3.1,
  //while z ranges from -2 to +2.
  x := x / 25;
  y := y / 25;

  if PlusCap then
  begin
    if x < -t1 then
      x := -t1;
    if y < -t1 then
      y := -t1;
  end;

  if MinusCap then
  begin
    if x > t1 then
      x := t1;
    if y > t1 then
      y := t1;
  end;

  g7 := (x-x1/t2)*(x-x2/t2)*(x-x3/t2)
       *(x+x1/t2)*(x+x2/t2)*(x+x3/t2)
       *(y-y1/t2)*(y-y2/t2)*(y-y3/t2)
       *(y+y1/t2)*(y+y2/t2)*(y+y3/t2) * 50000;
end;

function TFederEquation0S.GetStatusLine: string;
begin
  case Plot of
    0: result := '(x-x1)*(x-x2)*(x-x3)*(x+x1)*(x+x2)*(x+x3) *(y-y1)*(y-y2)*(y-y3) *(y+y1)*(y+y2)*(y+y3)';
  end;
end;

end.
