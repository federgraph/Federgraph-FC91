unit RiggVar.EQ.SimpleFormula;

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
  RiggVar.FB.Formula;

type
  TSimpleFederFormula = class(TFederFormulaBase)
  private
    x1, x2, x3: single;
    y1, y2, y3: single;
    l1, l2, l3: single;

    a1, a2, a3: single;
    t1, t2, t3: single;
    b1, b2, b3: single;
    u1, u2, u3: single;

    u: single;
  public
    constructor Create(AModelID: Integer = 1); override;
    function GetValue(x, y: single): single; override;
    function GetValueN(x, y: single): single; override;
    function TakesAbsolute: Boolean; override;
  end;

implementation

{ TSimpleFederFormula }

constructor TSimpleFederFormula.Create(AModelID: Integer = 1);
begin
  inherited Create(AModelID);

  x1 := -64.95;
  x2 := 64.95;
  x3 := 0;

  y1 := 37.5;
  y2 := 37.5;
  y3 := -75;

  l1 := 90;
  l2 := 90;
  l3 := 90;
end;

function TSimpleFederFormula.GetValueN(x, y: single): single;
begin
  a1 := sqr(x-x1) + sqr(y-y1);
  a2 := sqr(x-x2) + sqr(y-y2);
  a3 := sqr(x-x3) + sqr(y-y3);

  t1 := sqrt(a1);
  t2 := sqrt(a2);
  t3 := sqrt(a3);

  b1 := t2 * t3 * (t1-l1);
  b2 := t1 * t3 * (t2-l2);
  b3 := t1 * t2 * (t3-l3);

  u1 := b1 * (x-x1);
  u2 := b2 * (x-x2);
  u3 := b3 * (x-x3);

  u := u1 + u2 + u3;

  result := u / 500000;
end;

function TSimpleFederFormula.TakesAbsolute: Boolean;
begin
  result := True;
end;

function TSimpleFederFormula.GetValue(x, y: single): single;
begin
  result := Abs(GetValueN(x, y));
end;

end.
