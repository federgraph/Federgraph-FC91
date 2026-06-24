unit RiggVar.EQ.Equation01Diff;

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
  System.Math,
  System.Types,
  RiggVar.EQ.Equation01;

type
  TDiffEquation01 = class(TFederEquation01)
  private
    dx1: single;
    dy1: single;
    p1: single;
    q1: single;
    r1: single;

    Accu: single;
    PrepDiffOK: Boolean;

    procedure Prep(x, y: single);

    function Run1(x, y: single): single;
    procedure Part1(i: Integer; x, y: single; b: Boolean);

    function Run2(x, y: single): single;
    procedure Part2(i: Integer; x, y: single; b: Boolean);
  protected
    procedure Orig;

    function Diff1(i: Integer; x, y: single): single; override;
    function Diff2(i: Integer; x, y: single): single; override;
  end;

implementation

function TDiffEquation01.Run2(x, y: single): single;
begin
  Accu := 0;

  PrepDiffOK :=
        (abs(p1) > Epsilon)
    and (abs(q1) > Epsilon)
    and (abs(r1) > Epsilon);

  if PrepDiffOK then
  begin
    Part2(1, x, y, True);
    Part2(2, x, y, False);
    Part2(3, x, y, False);
    Part2(4, x, y, True);
  end;
  result := Accu;
end;

procedure TDiffEquation01.Part2(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
//    (3 k1 (x - x1)^3)/
//    ((x - x1)^2 + (y - y1)^2)^(5/2)
      z := 3 * k1 * Power(dx1, 3);
      n := q1;
    end;

    2:
    begin
//    (3 k1 (x - x1))/
//    ((x - x1)^2 + (y - y1)^2)^(3/2)
      z := 3 * k1 * dx1;
      n := p1;
    end;

    3:
    begin
//    (15 k1 (x - x1)^3 (y - y1)^2)/
//    ((x - x1)^2 + (y - y1)^2)^(7/2)
      z := 15 * k1 * Power(dx1, 3) * sqr(dy1);
      n := r1;
    end;

    4:
    begin
//    (9 k1 (x - x1) (y - y1)^2)/
//    ((x - x1)^2 + (y - y1)^2)^(5/2)
      z := 9 * k1 * dx1 * sqr(dy1);
      n := q1;
    end;

    else
    begin
      z := 0;
      n := 1;
    end;
  end;

  q := z / n;
  if b then
    Accu := Accu + q
  else
    Accu := Accu - q;
end;

procedure TDiffEquation01.Orig;
begin
(*

k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2])

---

- Summand 1
((k1 (x - x1)^2 (y - y1))/
((x - x1)^2 + (y - y1)^2)^(3/2))

+ Summand 2
(k1 (y - y1))/
Sqrt[(x - x1)^2 + (y - y1)^2]

---

+ Summand 1
(3 k1 (x - x1)^3)/
((x - x1)^2 + (y - y1)^2)^(5/2)

- Summand 2
(3 k1 (x - x1))/
((x - x1)^2 + (y - y1)^2)^(3/2)

- Summand 3
(15 k1 (x - x1)^3 (y - y1)^2)/
((x - x1)^2 + (y - y1)^2)^(7/2)

+ Summand 4
(9 k1 (x - x1) (y - y1)^2)/
((x - x1)^2 + (y - y1)^2)^(5/2)

*)
end;

function TDiffEquation01.Run1(x, y: single): single;
begin
  Accu := 0;

  PrepDiffOK :=
        (abs(t1) > Epsilon)
    and (abs(p1) > Epsilon);

  if PrepDiffOK then
  begin
    Part1(1, x, y, False);
    Part1(2, x, y, True);
  end;

  result := Accu;
end;

procedure TDiffEquation01.Part1(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
//    ((k1 (x - x1)^2 (y - y1))/
//    ((x - x1)^2 + (y - y1)^2)^(3/2))
      z := k1 * sqr(dx1) * dy1;
      n := p1;
    end;

    2:
    begin
//    (k1 (y - y1))/
//    Sqrt[(x - x1)^2 + (y - y1)^2]
      z := k1 * dy1;
      n := t1;
    end;

    else
    begin
      z := 0;
      n := 1;
    end;

  end;

  q := z / n;
  if b then
    Accu := Accu + q
  else
    Accu := Accu - q;
end;

procedure TDiffEquation01.Prep(x, y: single);
var
  temp: single;
begin
  dx1 := x - x1;
  dy1 := y - y1;
  a1 := sqr(dx1) + sqr(dy1);
  t1 := sqrt(a1);
  temp := (a1 - l1);
  if (temp < 0.0000001) then
  begin
    p1 := 0;
    q1 := 0;
    r1 := 0;
  end
  else
  begin
    p1 := Power((a1-l1), 3/2);
    q1 := Power((a1-l1), 5/2);
    r1 := Power((a1-l1), 7/2);
  end;
end;

function TDiffEquation01.Diff1(i: Integer; x, y: single): single;
var
  pd1: single;
begin
  Prep(x, y);
  pd1 := Run1(x, y);
  result := pd1 * 100;
  result := result * 8;
end;

function TDiffEquation01.Diff2(i: Integer; x, y: single): single;
var
  pd1: single;
begin
  Prep(x, y);
  pd1 := Run2(x, y);
  result := pd1 * 100;
  result := result * 8;
end;

end.
