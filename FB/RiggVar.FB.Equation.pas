unit RiggVar.FB.Equation;

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
  TFederEquation = class
  private
    a1, a2, a3: single;
    b1, b2, b3: single;
    t1, t2, t3: single;

    u1, u2, u3, u: single;

    fcap: single;
  public
    x1, x2, x3: single;
    y1, y2, y3: single;
    z1, z2, z3: single;
    l1, l2, l3: single;

    TakesAbsolute: Boolean;
    ErrorCounter: Integer;
    rmin: single;
    rmax: single;

    SpringCount: Integer;

    constructor Create;

    procedure Reset;
    procedure PrepareCalc;
    function GetValueN(x, y: single): single;
    function GetValue(x, y: single): single;
  end;

implementation

{ TFederEquation, https://federgraph.de/feder-formula.html }

constructor TFederEquation.Create;
begin
  Reset;
end;

procedure TFederEquation.Reset;
begin
  SpringCount := 3;
  TakesAbsolute := True;

  x1 := -64.95;
  x2 := 64.95;
  x3 := 0;

  y1 := 37.5;
  y2 := 37.5;
  y3 := -75;

  z1 := 0;
  z2 := 0;
  z3 := 0;

  l1 := 90;
  l2 := 90;
  l3 := 90;

  fcap := 500000;
end;

function TFederEquation.GetValue(x, y: single): single;
begin
  result := GetValueN(x, y);
  result := abs(result);
end;

function TFederEquation.GetValueN(x, y: single): single;
begin
  if fcap < 1 then
    fcap := 1;

  a1 := sqr(x-x1) + sqr(y-y1);
  a2 := sqr(x-x2) + sqr(y-y2);
  a3 := sqr(x-x3) + sqr(y-y3);

  t1 := sqrt(a1 + sqr(z1));
  t2 := sqrt(a2 + sqr(z2));
  t3 := sqrt(a3 + sqr(z3));

  b1 := t2 * t3 * (t1-l1);
  b2 := t1 * t3 * (t2-l2);
  b3 := t1 * t2 * (t3-l3);

  u1 := b1 * (x-x1);
  u2 := b2 * (x-x2);
  u3 := b3 * (x-x3);

  u := u1 + u2 + u3;

  result := u / fcap;

  if result > MaxInt then
    result := MaxInt;
  if result < -MaxInt then
    result := -MaxInt;
end;

procedure TFederEquation.PrepareCalc;
begin

end;

end.
