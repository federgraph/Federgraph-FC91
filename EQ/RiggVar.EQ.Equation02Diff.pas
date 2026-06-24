unit RiggVar.EQ.Equation02Diff;

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
  RiggVar.EQ.Equation02;

type
  TDiffEquation02 = class(TFederEquation02)
  private
    _dx1, _dx2: single;
    _dy1, _dy2: single;
    _t1, _t2: single;
    _dt1, _dt2: single;
    _p1, _p2: single;
    _q1, _q2: single;
    _r1, _r2: single;

    dx1, dx2: single;
    dy1, dy2: single;
    dt1, dt2: single;
    p1, p2: single;
    q1, q2: single;
    r1, r2: single;

    Accu: single;
    k: single;
    PrepDiffOK: Boolean;

    procedure Prep(x, y: single);
    procedure RotateVars(Idx: Integer);

    function Run1(x, y: single): single;
    procedure Part1(i: Integer; x, y: single; b: Boolean);

    function Run2(x, y: single): single;
    procedure Part2(i: Integer; x, y: single; b: Boolean);
  protected
    procedure Orig0;
    procedure Orig1;
    procedure Orig2;

    function Diff1(i: Integer; x, y: single): single; override;
    function Diff2(i: Integer; x, y: single): single; override;
  end;

implementation

function TDiffEquation02.Run2(x, y: single): single;
begin
  Accu := 0;

  PrepDiffOK :=
        (abs(t1) > Epsilon)
    and (abs(t2) > Epsilon)
    and (abs(dt1) > Epsilon)
    and (abs(dt2) > Epsilon)
    and (abs(p1) > Epsilon)
    and (abs(p2) > Epsilon)
    and (abs(q1) > Epsilon)
    and (abs(q2) > Epsilon)
    and (abs(r1) > Epsilon)
    and (abs(r2) > Epsilon);

  if PrepDiffOK then
  begin
    Part2(1, x, y, True);
    Part2(2, x, y, False);
    Part2(3, x, y, False);
    Part2(4, x, y, False);
    Part2(5, x, y, False);
    Part2(6, x, y, True);
    Part2(7, x, y, False);
    Part2(8, x, y, False);
    Part2(9, x, y, True);
    Part2(10, x, y, True);
    Part2(11, x, y, True);
    Part2(12, x, y, False);
    Part2(13, x, y, False);
    Part2(14, x, y, True);
    Part2(15, x, y, False);
    Part2(16, x, y, False);
    Part2(17, x, y, True);
    Part2(18, x, y, True);
    Part2(19, x, y, True);
    Part2(20, x, y, False);
    Part2(21, x, y, False);
    Part2(22, x, y, True);
    Part2(23, x, y, False);
    Part2(24, x, y, False);
    Part2(25, x, y, True);
    Part2(26, x, y, True);
    Part2(27, x, y, True);
    Part2(28, x, y, True);
    Part2(29, x, y, False);
  end;
  result := Accu;
end;

procedure TDiffEquation02.Part2(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
//    (3 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    ((x - x2)^2 + (y - y2)^2)^(5/2)
      z := 3 * k1 * dx1 * sqr(dx2) * dt1 + sqr(dy1);
      n := q2;
    end;

    2:
    begin
//    (k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    ((x - x2)^2 + (y - y2)^2)^(3/2)
      z := k1 * dx1 * dt1;
      n := p2;
    end;

    3:
    begin
//    (2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    ((x - x2)^2 + (y - y2)^2)^(3/2)
      z := 2 * k1 * dx2 * dt1;
      n := p2;
    end;

    4:
    begin
//    (2 k1 (x - x1)^2 (x - x2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 2 * k1 * sqr(dx1) * dx2;
      n := t1 * p2;
    end;

    5:
    begin
//    (k1 (x - x1) (x - x2)^2)/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := k1 * dx1 * sqr(dx2);
      n := t1 * p2;
    end;

    6:
    begin
//    (k1 (x - x1) (x - x2)^2 (y - y1)^2)/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := k1 * dx1 * sqr(dx2) * sqr(dy1);
      n := p1 * p2;
    end;

    7:
    begin
//    (k1 (x - x1)^3)/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * Power(dx1, 3);
      n := p1 * t2;
    end;

    8:
    begin
//    (2 k1 (x - x1)^2 (x - x2))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 2 * k1 * sqr(dx1) * dx2;
      n := p1 * t2;
    end;

    9:
    begin
//    (4 k1 (x - x1))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 4 * k1 * dx1;
      n := t1 * t2;
    end;

    10:
    begin
//    (2 k1 (x - x2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 2 * k1 *dx2;
      n := t1 * t2;
    end;

    11:
    begin
//    (6 k1 (x - x1)^2 (x - x2) (y - y1)^2)/
//    (((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 6 * k1 * sqr(dx1) * dx2 * sqr(dy1);
      n := q1 * t2;
    end;

    12:
    begin
//    (k1 (x - x1) (y - y1)^2)/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * dx1 * sqr(dy1);
      n := p1 * t2;
    end;

    13:
    begin
//    (2 k1 (x - x2) (y - y1)^2)/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 2 * k1 * dx2 * sqr(dy1);
      n := p1 * t2;
    end;

    14:
    begin
//    (3 k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(5/2)
      z := 3 * k1 * Power(dx1, 3) * t2;
      n := q1;
    end;

    15:
    begin
//    (3 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(3/2)
      z := 3 * k1 * dx1 * t2;
      n := p1;
    end;

    16:
    begin
//    (15 k1 (x - x1)^3 (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(7/2)
      z := 15 * k1 * Power(dx1, 3) * sqr(dy1) * t2;
      n := r1;
    end;

    17:
    begin
//    (9 k1 (x - x1) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(5/2)
      z := 9 * k1 * dx1 * sqr(dy1) * t2;
      n := q1;
    end;

    18:
    begin
//    (6 k1 (x - x1) (x - x2)^2 (y - y1) (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))
      z := 6 * k1 * dx1 * sqr(dx2) * dy1 * dy2;
      n := t1 * q2;
    end;

    19:
    begin
//    (4 k1 (x - x1)^2 (x - x2) (y - y1) (y - y2))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 4 * k1 * sqr(dx1) * dx2 * dy1 * dy2;
      n := p1 * p2;
    end;

    20:
    begin
//    (2 k1 (x - x1) (y - y1) (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 2 * k1 * dx1 * dy1 * dy2;
      n := t1 * p2;
    end;

    21:
    begin
//    (4 k1 (x - x2) (y - y1) (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 4 * k1 * dx2 * dy1 * dy2;
      n := t1 * p2;
    end;

    22:
    begin
//    (6 k1 (x - x1)^3 (y - y1) (y - y2))/
//    (((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 6 * k1 * Power(dx1, 3) * dy1 * dy2;
      n := q1 * t2;
    end;

    23:
    begin
//    (6 k1 (x - x1) (y - y1) (y - y2))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 6 * k1 * dx1 * dy1 * dy2;
      n := p1 * t2;
      end;

    24:
    begin
//    (15 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
//    ((x - x2)^2 + (y - y2)^2)^(7/2)
      z := 15 * k1 * dx1 * sqr(dx2) * dt1 * sqr(dy2);
      n := r2;
    end;

    25:
    begin
//    (3 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
//    ((x - x2)^2 + (y - y2)^2)^(5/2)
      z := 3 * k1 * dx1 * dt1 * sqr(dy2);
      n := q2;
    end;

    26:
    begin
//    ((6 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
//    ((x - x2)^2 + (y - y2)^2)^(5/2))
      z := 6 * k1 * dx2 * dt1 * sqr(dy2);
      n := q2;
    end;

    27:
    begin
//    (6 k1 (x - x1)^2 (x - x2) (y - y2)^2)/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))
      z := 6 * k1 *sqr(dx1) * dx2 * sqr(dy2);
      n := t1 * q2;
    end;

    28:
    begin
//    (k1 (x - x1)^3 (y - y2)^2)/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := k1 * Power(dx1, 3) * sqr(dy2);
      n := p1 * p2;
    end;

    29:
    begin
//    (3 k1 (x - x1) (y - y2)^2)/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 3 * k1 * dx1 * sqr(dy2);
      n := t1 * p2;
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

procedure TDiffEquation02.Orig0;
begin
(*
ClearAll[x, y]

ClearAll[x1, x2, x3]
ClearAll[y1, y2, y3]
ClearAll[l1, l2, l3]
ClearAll[k1, k2, k3]

ClearAll[a1, a2, a3]
a1 = (x - x1)^2 + (y - y1)^2;
a2 = (x - x2)^2 + (y - y2)^2;

ClearAll[t1, t2, t3]
t1 = Sqrt[a1];
t2 = Sqrt[a2];

ClearAll[b1, b2, b3]
b1 = t2*(t1 - l1)*k1;

ClearAll[u1]
u1 = b1*(x - x1)
g1 = D[u1, x, y]
g2 = D[g1, x, y];

---

k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2]
*)

end;

procedure TDiffEquation02.Orig1;
begin
(*
+ Summand 1
(k1 (x - x1) (x - x2) (y - y1))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])

- Summand 2
(k1 (x - x1)^2 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x1)^2 + (y - y1)^2)^(3/2)

+ Summand 3
(k1 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2])/
Sqrt[(x - x1)^2 + (y - y1)^2]

- Summand 4
(k1 (x - x1) (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2))/
((x - x2)^2 + (y - y2)^2)^(3/2)

+ Summand 5
(k1 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2))/
Sqrt[(x - x2)^2 + (y - y2)^2]

+ Summand 6
(k1 (x - x1)^2 (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
*)
end;

procedure TDiffEquation02.Orig2;
begin
(*

+ Summand 1
(3 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
((x - x2)^2 + (y - y2)^2)^(5/2)

- Summand 2
(k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
((x - x2)^2 + (y - y2)^2)^(3/2)

- Summand 3
(2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
((x - x2)^2 + (y - y2)^2)^(3/2)

- Summand 4
(2 k1 (x - x1)^2 (x - x2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))

- Summand 5
(k1 (x - x1) (x - x2)^2)/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))

+ Summand 6
(k1 (x - x1) (x - x2)^2 (y - y1)^2)/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))

- Summand 7
(k1 (x - x1)^3)/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])

- Summand 8
(2 k1 (x - x1)^2 (x - x2))/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])

+ Summand 9
(4 k1 (x - x1))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])

+ Summand 10
(2 k1 (x - x2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])

+ Summand 11
(6 k1 (x - x1)^2 (x - x2) (y - y1)^2)/
(((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])

- Summand 12
(k1 (x - x1) (y - y1)^2)/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])

- Summand 13
(2 k1 (x - x2) (y - y1)^2)/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])

+ Summand 14
(3 k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x1)^2 + (y - y1)^2)^(5/2)

- Summand 15
(3 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x1)^2 + (y - y1)^2)^(3/2)

- Summand 16
(15 k1 (x - x1)^3 (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x1)^2 + (y - y1)^2)^(7/2)

+ Summand 17
(9 k1 (x - x1) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x1)^2 + (y - y1)^2)^(5/2)

+ Summand 18
(6 k1 (x - x1) (x - x2)^2 (y - y1) (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))

+ Summand 19
(4 k1 (x - x1)^2 (x - x2) (y - y1) (y - y2))/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))

- Summand 20
(2 k1 (x - x1) (y - y1) (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))

- Summand 21
(4 k1 (x - x2) (y - y1) (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))

+ Summand 22
(6 k1 (x - x1)^3 (y - y1) (y - y2))/
(((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])

- Summand 23
(6 k1 (x - x1) (y - y1) (y - y2))/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])

- Summand 24
(15 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
((x - x2)^2 + (y - y2)^2)^(7/2)

+ Summand 25
(3 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
((x - x2)^2 + (y - y2)^2)^(5/2)

+ Summand 26
((6 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
((x - x2)^2 + (y - y2)^2)^(5/2))

+ Summand 27
(6 k1 (x - x1)^2 (x - x2) (y - y2)^2)/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))

+ Summand 28
(k1 (x - x1)^3 (y - y2)^2)/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))

- Summand 29
(3 k1 (x - x1) (y - y2)^2)/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))

*)

end;

function TDiffEquation02.Run1(x, y: single): single;
begin
  Accu := 0;

  PrepDiffOK := (abs(t1) > Epsilon)
    and (abs(t2) > Epsilon)
    and (abs(dt1) > Epsilon)
    and (abs(p1) > Epsilon)
    and (abs(p2) > Epsilon)
//    and (abs(q1) > Epsilon)
//    and (abs(q2) > Epsilon)
//    and (abs(r1) > Epsilon)
//    and (abs(r2) > Epsilon)
    ;

  if PrepDiffOK then
  begin
    Part1(1, x, y, True);
    Part1(2, x, y, False);
    Part1(3, x, y, True);
    Part1(4, x, y, False);
    Part1(5, x, y, True);
    Part1(6, x, y, True);
  end;

  result := Accu;
end;

procedure TDiffEquation02.Part1(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
//    (k1 (x - x1) (x - x2) (y - y1))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * dx1 * dx2 * dy1;
      n := t1 * t2;
    end;

    2:
    begin
//    (k1 (x - x1)^2 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(3/2)
      z := k1 * sqr(dx1) * dy1 * t2;
      n := p1;
    end;

    3:
    begin
//    (k1 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    Sqrt[(x - x1)^2 + (y - y1)^2]
      z := k1 * dy1 * t2;
      n := t1;
    end;

    4:
    begin
//    (k1 (x - x1) (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2))/
//    ((x - x2)^2 + (y - y2)^2)^(3/2)
      z := k1 * dx1 * dx2 * dt1 * dy2;
      n := p2;
    end;

    5:
    begin
//    (k1 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2))/
//    Sqrt[(x - x2)^2 + (y - y2)^2]
      z := k1 * dt1 * dy2;
      n := t2
    end;

    6:
    begin
//    (k1 (x - x1)^2 (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * sqr(dx1) * dy2;
      n := t1 * t2;
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

procedure TDiffEquation02.Prep(x, y: single);
begin
  _dx1 := x - x1;
  _dx2 := x - x2;

  _dy1 := y - y1;
  _dy2 := y - y2;

  a1 := sqr(_dx1) + sqr(_dy1);
  a2 := sqr(_dx2) + sqr(_dy2);

  _t1 := sqrt(a1);
  _t2 := sqrt(a2);

  _dt1 := _t1 - l1;
  _dt2 := _t2 - l2;

  _p1 := Power(a1, 3/2);
  _p2 := Power(a2, 3/2);

  _q1 := Power(a1, 5/2);
  _q2 := Power(a2, 5/2);

  _r1 := Power(a1, 7/2);
  _r2 := Power(a2, 7/2);
end;

procedure TDiffEquation02.RotateVars(Idx: Integer);
begin
  case Idx of
    2:
    begin
      dx1 := _dx2;
      dx2 := _dx1;

      dy1 := _dy2;
      dy2 := _dy1;

      t1 := _t2;
      t2 := _t1;

      dt1 := _dt2;
      dt2 := _dt1;

      p1 := _p2;
      p2 := _p1;

      q1 := _q2;
      q2 := _q1;

      r1 := _r2;
      r2 := _r1;

      k := k2;
    end;
    else
    begin
      dx1 := _dx1;
      dx2 := _dx2;

      dy1 := _dy1;
      dy2 := _dy2;

      t1 := _t1;
      t2 := _t2;

      dt1 := _dt1;
      dt2 := _dt2;

      p1 := _p1;
      p2 := _p2;

      q1 := _q1;
      q2 := _q2;

      r1 := _r1;
      r2 := _r2;

      k := k1;
    end;
  end;
end;

function TDiffEquation02.Diff1(i: Integer; x, y: single): single;
var
  pd1: single;
  pd2: single;
begin
  Prep(x, y);
  case i of
    1, 2:
    begin
      RotateVars(i);
      pd1 := Run1(x, y);
      result := pd1 * 100;
    end;
    else
    begin
      RotateVars(1);
      pd1 := Run1(x, y);
      RotateVars(2);
      pd2 := Run1(x, y);
      result := (pd1 + pd2) * 100;
    end;
  end;
  result := result * 8;
end;

function TDiffEquation02.Diff2(i: Integer; x, y: single): single;
var
  pd1: single;
  pd2: single;
begin
  Prep(x, y);
  case i of
    1, 2:
    begin
      RotateVars(i);
      pd1 := Run2(x, y);
      result := pd1 * 100;
    end;
    else
    begin
      RotateVars(1);
      pd1 := Run2(x, y);
      RotateVars(2);
      pd2 := Run2(x, y);
      result := (pd1 + pd2) * 100;
    end;
  end;
  result := result * 8;
end;

end.
