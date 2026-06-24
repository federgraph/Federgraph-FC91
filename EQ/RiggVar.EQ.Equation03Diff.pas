unit RiggVar.EQ.Equation03Diff;

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
  RiggVar.EQ.Equation03;

type
  TDiffEquation03 = class(TFederEquation03)
  private
    _dx1, _dx2, _dx3: single;
    _dy1, _dy2, _dy3: single;
    _t1, _t2, _t3: single;
    _dt1, _dt2, _dt3: single;
    _p1, _p2, _p3: single;
    _q1, _q2, _q3: single;
    _r1, _r2, _r3: single;

    dx1, dx2, dx3: single;
    dy1, dy2, dy3: single;
    dt1, dt2, dt3: single;
    p1, p2, p3: single;
    q1, q2, q3: single;
    r1, r2, r3: single;

    Accu: single;
    k: single;
    PrepDiffOK: Boolean;

    function Run1(x, y: single): single;
    procedure Part1(i: Integer; x, y: single; b: Boolean);

    function Run2(x, y: single): single;
    procedure Part2(i: Integer; x, y: single; b: Boolean);
    procedure RotateVars(Idx: Integer);
    procedure Prep(x, y: single);
  protected
    procedure Orig1;
    procedure Orig2;
    procedure Part1a(i: Integer; x, y: single; b: Boolean);
    procedure Part1b(i: Integer; x, y: single; b: Boolean);
    procedure Part2a(i: Integer; x, y: single; b: Boolean);
    procedure Part2b(i: Integer; x, y: single; b: Boolean);

    function Diff1(i: Integer; x, y: single): single; override;
    function Diff2(i: Integer; x, y: single): single; override;
  end;

implementation

//procedure TDiffEquation03.Prep2(x, y: single);
//begin
//  dx1 := x - x1;
//  dx2 := x - x2;
//  dx3 := x - x3;
//
//  dy1 := y - y1;
//  dy2 := y - y2;
//  dy3 := y - y3;
//
//  a1 := sqr(dx1) + sqr(dy1);
//  a2 := sqr(dx2) + sqr(dy2);
//  a3 := sqr(dx3) + sqr(dy3);
//
//  t1 := sqrt(a1);
//  t2 := sqrt(a2);
//  t3 := sqrt(a3);
//
//  dt1 := t1 - l1;
//  dt2 := t2 - l2;
//  dt3 := t3 - l3;
//
//  p1 := Power(a1, 3/2);
//  p2 := Power(a2, 3/2);
//  p3 := Power(a3, 3/2);
//
//  q1 := Power(a1, 5/2);
//  q2 := Power(a2, 5/2);
//  q3 := Power(a3, 5/2);
//
//  r1 := Power(a1, 7/2);
//  r2 := Power(a2, 7/2);
//  r3 := Power(a3, 7/2);
//end;

function TDiffEquation03.Run2(x, y: single): single;
begin
  Accu := 0;

  PrepDiffOK := (abs(t1) > Epsilon)
    and (abs(t2) > Epsilon)
    and (abs(t3) > Epsilon)
    and (abs(p1) > Epsilon)
    and (abs(p2) > Epsilon)
    and (abs(p3) > Epsilon)
    and (abs(dt1) > Epsilon)
    and (abs(dt2) > Epsilon)
    and (abs(dt3) > Epsilon);

  if PrepDiffOK then
  begin
    Part2(1, x, y, True);
    Part2(2, x, y, False);
    Part2(3, x, y, False);
    Part2(4, x, y, False);
    Part2(5, x, y, False);
    Part2(6, x, y, False);
    Part2(7, x, y, False);
    Part2(8, x, y, True);
    Part2(9, x, y, False);
    Part2(10, x, y, True);
    Part2(11, x, y, False);
    Part2(12, x, y, False);
    Part2(13, x, y, True);
    Part2(14, x, y, True);
    Part2(15, x, y, True);
    Part2(16, x, y, True);
    Part2(17, x, y, True);
    Part2(18, x, y, True);
    Part2(19, x, y, False);
    Part2(20, x, y, False);
    Part2(21, x, y, False);
    Part2(22, x, y, True);
    Part2(23, x, y, True);
    Part2(24, x, y, True);
    Part2(25, x, y, False);
    Part2(26, x, y, False);
    Part2(27, x, y, False);
    Part2(28, x, y, False);
    Part2(29, x, y, True);
    Part2(30, x, y, True);
    Part2(31, x, y, True);
    Part2(32, x, y, False);
    Part2(33, x, y, False);
    Part2(34, x, y, False);
    Part2(35, x, y, True);
    Part2(36, x, y, False);
    Part2(37, x, y, False);
    Part2(38, x, y, False);
    Part2(39, x, y, False);
    Part2(40, x, y, True);
    Part2(41, x, y, False);
    Part2(42, x, y, False);
    Part2(43, x, y, True);
    Part2(44, x, y, True);
    Part2(45, x, y, True);
    Part2(46, x, y, False);
    Part2(47, x, y, False);
    Part2(48, x, y, True);
    Part2(49, x, y, False);
    Part2(50, x, y, False);
    Part2(51, x, y, True);
    Part2(52, x, y, True);
    Part2(53, x, y, True);
    Part2(54, x, y, False);
    Part2(55, x, y, False);
    Part2(56, x, y, True);
    Part2(57, x, y, False);
    Part2(58, x, y, False);
    Part2(59, x, y, True);
    Part2(60, x, y, True);
    Part2(61, x, y, True);
    Part2(62, x, y, True);
    Part2(63, x, y, False);
    Part2(64, x, y, True);
    Part2(65, x, y, True);
    Part2(66, x, y, False);
    Part2(67, x, y, True);
    Part2(68, x, y, False);
    Part2(69, x, y, False);
    Part2(70, x, y, True);
    Part2(71, x, y, False);
    Part2(72, x, y, False);
    Part2(73, x, y, False);
    Part2(74, x, y, False);
    Part2(75, x, y, False);
    Part2(76, x, y, True);
    Part2(77, x, y, True);
    Part2(78, x, y, True);
    Part2(79, x, y, False);
    Part2(80, x, y, True);
    Part2(81, x, y, False);
    Part2(82, x, y, False);
    Part2(83, x, y, False);
    Part2(84, x, y, False);
    Part2(85, x, y, True);
    Part2(86, x, y, False);
    Part2(87, x, y, True);
    Part2(88, x, y, True);
    Part2(89, x, y, True);
    Part2(90, x, y, True);
    Part2(91, x, y, True);
    Part2(92, x, y, False);
    Part2(93, x, y, False);
    Part2(94, x, y, False);
    Part2(95, x, y, True);
    Part2(96, x, y, False);
  end;
  result := Accu;
end;

procedure TDiffEquation03.Part2(i: Integer; x, y: single; b: Boolean);
begin
  Part2b(i, x, y, b);
end;

procedure TDiffEquation03.Part2a(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
//    (3 k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x3)^2 + (y - y3)^2)^(5/2)
      z := 3 * k1 * dx1 * sqr(x - x3) * dt1 * t2;
      n := q3;
    end;

    2:
    begin
//    (2 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 2 * k1 * dx1 * dx2 * dx3 * dt1;
      n := t2 * p3;
    end;

    3:
    begin
//    (k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := k1 * dx1 * sqr(dx3) * dt2;
      n := t2 * p2;

    end;

    4:
    begin
//    (k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x3)^2 + (y - y3)^2)^(3/2)
      z := k1 * dx1 * dt1 * t2;
      n := p3;
    end;

    5:
    begin
//    (2 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    ((x - x3)^2 + (y - y3)^2)^(3/2)
      z := 2 * k1 * dx3 * dt2 * t2;
      n := p3;
    end;

    6:
    begin
//    (2 k1 (x - x1)^2 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 2 * k1 * sqr(dx1) * dx3 * t2;
      n := t1 * p3;
    end;

    7:
    begin
//    (k1 (x - x1) (x - x3)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := k1 * dx1 * sqr(dx3) * t2;
      n := t1 * p3;
    end;

    8:
    begin
//    (k1 (x - x1) (x - x3)^2 (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := k1 * dx1 * sqr(dx3) * sqr(dy1) * t2;
      n := p1 * p3;
    end;

    9:
    begin
//    (2 k1 (x - x1) (x - x3)^2 (y - y1) (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 2 * dx1 * sqr(dx3) * dy1 * dy2;
      n := t1 * t2 * p3;
    end;

    10:
    begin
//    (k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := k1 * dx1 * sqr(dx3) * dt1 * sqr(dy2);
      n := p2 * p3;
    end;

    11:
    begin
//    (k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * dx1 * sqr(dx2) * dt1;
      n := p2 * t3;
    end;

    12:
    begin
//    (2 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx1 * dx2 * dx3 * dt1;
      n := p2 * t3;
    end;

    13:
    begin
//    (2 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1  * dx1 * dt1;
      n := t2 * t3;
    end;

    14:
    begin
//    (2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx2 * dt1;
      n := t2 * t3;
    end;

    15:
    begin
//    (2 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx3 * dt1;
      n := t2 * t3;
    end;

    16:
    begin
//    (2 k1 (x - x1)^2 (x - x2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * sqr(dx1) * dx2;
      n := t1 * t2 * t3;
    end;

    17:
    begin
//    (2 k1 (x - x1)^2 (x - x3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * sqr(dx1) * dx3;
      n := t1 * t2 * t3;
    end;

    18:
    begin
//    (2 k1 (x - x1) (x - x2) (x - x3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx1 * dx2 * dx3;
      n := t1 * t2 * t3;
    end;

    19:
    begin
//    (2 k1 (x - x1) (x - x2) (x - x3) (y - y1)^2)/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx1 * dx2 * dx3 * sqr(dy1);
      n := p1 * t2 * t3;
    end;

    20:
    begin
//    (k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * Power(dx1, 3) * t2;
      n := p1 * t3;
    end;

    21:
    begin
//    (2 k1 (x - x1)^2 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * sqr(dx1) * dx3 * t2;
      n := p2 * t3;
    end;

    22:
    begin
//    (4 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * dx1 * t2;
      n := t1 * t3;
    end;

    23:
    begin
//    (2 k1 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx3 * t2;
      n := t1 * t3;
    end;

    24:
    begin
//    (6 k1 (x - x1)^2 (x - x3) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 6 * k1 * sqr(dx1) * dx3 * sqr(dy1) * t2;
      n := q1 * t3;
    end;

    25:
    begin
//    (k1 (x - x1) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * dx1 * sqr(dy1) * t2;
      n := p1 * t3;
    end;

    26:
    begin
//    (2 k1 (x - x3) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx3 * sqr(dy1) * t2;
      n := p1 * t3;
    end;

    27:
    begin
//    (4 k1 (x - x1) (x - x2) (x - x3) (y - y1) (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * dx1 * dx2 * dx3 * dy1 * dy2;
      n := t1 * p2 * t3;
    end;

    28:
    begin
//    (4 k1 (x - x1)^2 (x - x3) (y - y1) (y - y2))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * sqr(dx1) * dx3 * dy1 * dy2;
      n := p1 * t2 * t3;
    end;

    29:
    begin
//    (2 k1 (x - x1) (y - y1) (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx1 * dy1 * dy2;
      n := t1* t2 * t3;
    end;

    30:
    begin
//    (4 k1 (x - x3) (y - y1) (y - y2))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * dx3 * dy1 * dy2;
      n := t1* t2 * t3;
    end;

    31:
    begin
//    (6 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
//    (((x - x2)^2 + (y - y2)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 6 * k1 * dx1 * dx2 * dx3 * dt1 * sqr(dy2);
      n := q2 * t3;
    end;

    32:
    begin
//    (k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * dx1 * dt1 * sqr(dy2);
      n := p2 * t3;
    end;

    33:
    begin
//    (2 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx3 * dt1 * sqr(dy2);
      n := p2 * t3;
    end;

    34:
    begin
//    (2 k1 (x - x1)^2 (x - x3) (y - y2)^2)/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * sqr(dx1) * dx3 * sqr(dy2);
      n := t1 * p2 * t3;
    end;

    35:
    begin
//    (3 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x2)^2 + (y - y2)^2)^(5/2)
      z := 3 * k1 * dx1 * sqr(dx2) * dt1 * t3;
      n := q2;
    end;

    36:
    begin
//    (k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x2)^2 + (y - y2)^2)^(3/2)
      z := k1 * dx1 * dt1 * t3;
      n := p2;
    end;

    37:
    begin
//    (2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x2)^2 + (y - y2)^2)^(3/2)
      z := 2 * k1 * dx2 * dt1 * t3;
      n := p2;
    end;

    38:
    begin
//    (2 k1 (x - x1)^2 (x - x2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 2 * k1 * sqr(dx1) * dx2 * t3;
      n := t1 * p2;
    end;

    39:
    begin
//    (k1 (x - x1) (x - x2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := k1 * dx1 * sqr(dx2) *t3;
      n := t1 * p2;
    end;

    40:
    begin
//    (k1 (x - x1) (x - x2)^2 (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := k1 * dx1 * sqr(dx2) * sqr(dy1) * t3;
      n := p1 * p2;
    end;

    41:
    begin
//    (k1 (x - x1)^3 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * Power(dx1, 3) * t3;
      n := p1 * t2;
    end;

    42:
    begin
//    (2 k1 (x - x1)^2 (x - x2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 2 * k1 * sqr(dx1) * dx2 * t3;
      n := p1 * t2;
    end;

    43:
    begin
//    (4 k1 (x - x1) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 4 * k1 * dx1 * t3;
      n := t1 * t2;
    end;

    44:
    begin
//    (2 k1 (x - x2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 2 * k1 * dx2 * t3;
      n := t1 * t2;
    end;

    45:
    begin
//    (6 k1 (x - x1)^2 (x - x2) (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 6 * k1 * sqr(dx1) * dx2 * sqr(dy1) * t3;
      n := q1 * t2;
    end;

    46:
    begin
//    (k1 (x - x1) (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * dx1 * sqr(dy1) * t3;
      n := p1 * t2;
    end;

    47:
    begin
//    (2 k1 (x - x2) (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 2 * k1 * dx2 * sqr(dy1) * t3;
      n := p1 * t2;
    end;

    48:
    begin
//    (3 k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(5/2)
      z := 3 * k1 * Power(dx1, 3) * t2 * t3;
      n := q1;
    end;

    49:
    begin
//    (3 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(3/2)
      z := 3 * k1 * dx1 * t2 * t3;
      n := p1;
    end;

    50:
    begin
//    (15 k1 (x - x1)^3 (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(7/2)
      z := 15 * k1 * Power(dx1, 3) * sqr(dy1) * t2 * t3;
      n := r1;
    end;

    51:
    begin
//    (9 k1 (x - x1) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(5/2)
      z := 9 * k1 * dx1 * sqr(dy1) * t2 * t3;
      n := q1;
    end;

    52:
    begin
//    (6 k1 (x - x1) (x - x2)^2 (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))
      z := 6 * k1 * dx1 * sqr(dx2) * (dy1) * dy2 * t3;
      n := t1 * q2;
    end;

    53:
    begin
//    (4 k1 (x - x1)^2 (x - x2) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 4 * k1 * sqr(dx1) * dx2 * dy1 * dy2 * t3;
      n := p1 * p2;
    end;

    54:
    begin
//    (2 k1 (x - x1) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 2 * k1 * dx1 * dy1 * dy2 * t3;
      n := t1 * p2;
    end;

    55:
    begin
//    (4 k1 (x - x2) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 4 * k1 * dx2 * dy1 * dy2 * t3;
      n := t1 * p2;
    end;

    56:
    begin
//    (6 k1 (x - x1)^3 (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 6 * k1 * Power(dx1, 3) * dy1 * dy2 * t3;
      n := q1 * t2;
    end;

    57:
    begin
//    (6 k1 (x - x1) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
      z := 6 * k1 * dx1 * dy1 * dy2 * t3;
      n := p1 * t2;
    end;

    58:
    begin
//    (15 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x2)^2 + (y - y2)^2)^(7/2)
      z := 15 * k1 * dx1 * sqr(dx2) * dt1 * sqr(dy2) * t3;
      n := r2;
    end;

    59:
    begin
//    (3 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x2)^2 + (y - y2)^2)^(5/2)
      z := 3 * k1  * dx1 * dt1 * sqr(dy2) * t3;
      n := q2;
    end;

    60:
    begin
//    (6 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x2)^2 + (y - y2)^2)^(5/2)
      z := 6 * k1 * dx2 * dt1 * sqr(dy2) * t3;
      n := q2;
    end;

    61:
    begin
//    (6 k1 (x - x1)^2 (x - x2) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))
      z := 6 * k1 * sqr(dx1) * dx2 * sqr(dy2) * t3;
      n := t1 * q2;
    end;

    62:
    begin
//    (k1 (x - x1)^3 (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := k1 * Power(dx1, 3) * sqr(dy2) * t3;
      n := p1 * p2;
    end;

    63:
    begin
//    (3 k1 (x - x1) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
      z := 3 * k1 * dx1 * sqr(dy2) * t3;
      n := t1 * p2;
    end;

    64:
    begin
//    (6 k1 (x - x1) (x - x3)^2 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(5/2))
      z := 6 * k1 * dx1 * sqr(dx3) * dy1 * t2 * dy3;
      n := t1 * q3;
    end;

    65:
    begin
//    (6 k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(5/2))
      z := 6 * k1 * dx1 * sqr(dx3) * dt1 * dy2 * dy3;
      n := t2 * q3;
    end;

    66:
    begin
//    (4 k1 (x - x1) (x - x2) (x - x3) (y - y1) (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 4 * k1 * dx1 * dx2 * dx3 * dy1 * dy3;
      n := t1 * t2 * p3;
    end;

    67:
    begin
//    (4 k1 (x - x1)^2 (x - x3) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 4 * k1 * sqr(dx1) * dx3 * dy1 * t2 * dy3;
      n := p1 * p3;
    end;

    68:
    begin
//    (2 k1 (x - x1) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 2 * k1 * dx1 * dy1 * t2 * dy3;
      n := t1 * p3;
    end;

    69:
    begin
//    (4 k1 (x - x3) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 4 * k1 * dx3 * dy1 * t2 * dy3;
      n := t1 * p3;
    end;

    70:
    begin
//    (4 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 4 * k1 * dx1 * dx2 * dx3 * dt1 * dy2 * dy3;
      n := p2 * p3;
    end;

    71:
    begin
//    (2 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 2 * k1 * dx1 * dt1 * dy2 * dy3;
      n := t2 * p3;
    end;

    72:
    begin
//    (4 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 4 * k1 * dx3 * dt1 * dy2 * dy3;
      n := t2 * p3;
    end;

    73:
    begin
//    (4 k1 (x - x1)^2 (x - x3) (y - y2) (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 4 * k1 * sqr(dx1) * dx3 * dy2 * dy3;
      n := t1 * t2 * p3;
    end;

    74:
    begin
//    (2 k1 (x - x1) (x - x2)^2 (y - y1) (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx1 * sqr(dx2) * dy1 * dy3;
      n := t1 * p2 * t3;
    end;

    75:
    begin
//    (4 k1 (x - x1)^2 (x - x2) (y - y1) (y - y3))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * sqr(dx1) * dx2 * dy1 * dy3;
      n := p1 * t2 * t3;
    end;

    76:
    begin
//    (2 k1 (x - x1) (y - y1) (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx1 * dy1 * dy3;
      n := t1 * t2 * t3;
    end;

    77:
    begin
//    (4 k1 (x - x2) (y - y1) (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * dx2 * dy1 * dy3;
      n := t1 * t2 * t3;
    end;

    78:
    begin
//    (6 k1 (x - x1)^3 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    (((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 6 * k1 * Power(dx1, 3) * dy1 * t2 * dy3;
      n := q1 * t3;
    end;

    79:
    begin
//    (6 k1 (x - x1) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 6 * k1 * dx1 * dy1 * t2 * dy3;
      n := p1 * t3;
    end;

    80:
    begin
//    (6 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
//    (((x - x2)^2 + (y - y2)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 6 * k1 * dx1 * sqr(dx2) * dt1 * dy2 * dy3;
      n := q2 * t3;
    end;

    81:
    begin
//    (2 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * dx1 * dt1 * dy2 * dy3;
      n := q2 * t3;
    end;

    82:
    begin
//    (4 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * dx2 * dt1 * dy2 * dy3;
      n := q2 * t3;
    end;

    83:
    begin
//    (4 k1 (x - x1)^2 (x - x2) (y - y2) (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 4 * k1 * sqr(dx1) * dx2 * dy2 * dy3;
      n := t1 * p2 * t3;
    end;

    84:
    begin
//    (2 k1 (x - x1)^3 (y - y2) (y - y3))/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 2 * k1 * Power(dx1, 3) * dy2 * dy3;
      n := p1 * t2 * t3;
    end;

    85:
    begin
//    (6 k1 (x - x1) (y - y2) (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := 6 * k1 * dx1 * dy2 * dy3;
      n := t1 * t2 * t3;
    end;

    86:
    begin
//    (15 k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
//    ((x - x3)^2 + (y - y3)^2)^(7/2)
      z := 15 * k1 * dx1 * sqr(dx3) * dt1 * t2 * sqr(dy3);
      n := r3;
    end;

    87:
    begin
//    (6 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3)^2)/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(5/2))
      z := 6 * k1 * dx1 * dx2 * dx3 * dt1 * sqr(dy3);
      n := t2 * q3;
    end;

    88:
    begin
//    (3 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
//    ((x - x3)^2 + (y - y3)^2)^(5/2)
      z := 3 * k1 * dx1 * dt1 * t2 * sqr(dy3);
      n := q3;
    end;

    89:
    begin
//    (6 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
//    ((x - x3)^2 + (y - y3)^2)^(5/2)
      z := 6 * k1 * dx3 * dt1 * t2 * sqr(dy3);
      n := q3;
    end;

    90:
    begin
//    (6 k1 (x - x1)^2 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(5/2))
      z := 6 * k1 * sqr(dx1) * dx3 * t2 * sqr(dy3);
      n := t1 * q3;
    end;

    91:
    begin
//    (k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3)^2)/
//    (((x - x2)^2 + (y - y2)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := k1 * dx1 * sqr(dx2) * dt1 * sqr(dy3);
      n := p2 * p3;
    end;

    92:
    begin
//    (k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3)^2)/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := k1 * dx1 * dt1 * sqr(dy3);
      n := t2 * p3;
    end;

    93:
    begin
//    (2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3)^2)/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 2 * k1 * dx2 * dt1 * sqr(dy3);
      n := t2 * p3;
    end;

    94:
    begin
//    (2 k1 (x - x1)^2 (x - x2) (y - y3)^2)/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 2 * k1 * sqr(dx1) * dx2 * sqr(dy3);
      n := t1 * t2 * p3;
    end;

    95:
    begin
//    (k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
//    (((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := k1 * Power(dx1, 3) * t2 * sqr(dy3);
      n := p1 * p3;
    end;

    96:
    begin
//    (3 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
      z := 3 * k1 * dx1 * t2 * sqr(dy3);
      n := t1 * p3;
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

procedure TDiffEquation03.Orig2;
begin
(*

+ Summand 1
3 k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x3)^2 + (y - y3)^2)^(5/2)
- Summand 2
(2 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
(Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 3
(k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
(Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 4
(k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x3)^2 + (y - y3)^2)^(3/2)
- Summand 5
(2 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2])/
((x - x3)^2 + (y - y3)^2)^(3/2)
- Summand 6
(2 k1 (x - x1)^2 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 7
(k1 (x - x1) (x - x3)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
+ Summand 8
(k1 (x - x1) (x - x3)^2 (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 9
(2 k1 (x - x1) (x - x3)^2 (y - y1) (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
+  Summand 10
(k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
(((x - x2)^2 + (y - y2)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
-  Summand 11
(k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
(((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
-  Summand 12
(2 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
(((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
+  Summand 13
(2 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
(Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+  Summand 14
(2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
(Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+  Summand 15
(2 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]))/
(Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+  Summand 16
(2 k1 (x - x1)^2 (x - x2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 17
(2 k1 (x - x1)^2 (x - x3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 18
(2 k1 (x - x1) (x - x2) (x - x3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 19
(2 k1 (x - x1) (x - x2) (x - x3) (y - y1)^2)/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 20
(k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 21
(2 k1 (x - x1)^2 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 22
(4 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 23
(2 k1 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 24
(6 k1 (x - x1)^2 (x - x3) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
(((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 25
(k1 (x - x1) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 26
(2 k1 (x - x3) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 27
(4 k1 (x - x1) (x - x2) (x - x3) (y - y1) (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 28
(4 k1 (x - x1)^2 (x - x3) (y - y1) (y - y2))/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 29
(2 k1 (x - x1) (y - y1) (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 30
(4 k1 (x - x3) (y - y1) (y - y2))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 31
(6 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
(((x - x2)^2 + (y - y2)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 33
(2 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2)/
(((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 34
(2 k1 (x - x1)^2 (x - x3) (y - y2)^2)/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 35
(3 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x2)^2 + (y - y2)^2)^(5/2)
- Summand 36
(k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x2)^2 + (y - y2)^2)^(3/2)
- Summand 37
(2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x2)^2 + (y - y2)^2)^(3/2)
- Summand 39
(k1 (x - x1) (x - x2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
+ Summand 40
(k1 (x - x1) (x - x2)^2 (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
- Summand 42
(2 k1 (x - x1)^2 (x - x2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
+ Summand 43
(4 k1 (x - x1) Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
+ Summand 44
(2 k1 (x - x2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
+ Summand 45
(6 k1 (x - x1)^2 (x - x2) (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])
- Summand 46
(k1 (x - x1) (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
- Summand 47
(2 k1 (x - x2) (y - y1)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
+ Summand 48
(3 k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x1)^2 + (y - y1)^2)^(5/2)
- Summand 49
(3 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x1)^2 + (y - y1)^2)^(3/2)
- Summand 50
(15 k1 (x - x1)^3 (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x1)^2 + (y - y1)^2)^(7/2)
+ Summand 51
(9 k1 (x - x1) (y - y1)^2 Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x1)^2 + (y - y1)^2)^(5/2)
+ Summand 52
(6 k1 (x - x1) (x - x2)^2 (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))
+ Summand 53
(4 k1 (x - x1)^2 (x - x2) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
- Summand 54
(2 k1 (x - x1) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
- Summand 55
(4 k1 (x - x2) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
+ Summand 56
(6 k1 (x - x1)^3 (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x2)^2 + (y - y2)^2])
- Summand 57
(6 k1 (x - x1) (y - y1) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2])
- Summand 58
(15 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x2)^2 + (y - y2)^2)^(7/2)
+ Summand 59
(3 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x2)^2 + (y - y2)^2)^(5/2)
+ Summand 61
(6 k1 (x - x1)^2 (x - x2) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(5/2))
+ Summand 62
(k1 (x - x1)^3 (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x2)^2 + (y - y2)^2)^(3/2))
- Summand 63
(3 k1 (x - x1) (y - y2)^2 Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2))
+ Summand 64
(6 k1 (x - x1) (x - x3)^2 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(5/2))
+ Summand 65
(6 k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
(Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(5/2))
- Summand 66
(4 k1 (x - x1) (x - x2) (x - x3) (y - y1) (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
+ Summand 67
(4 k1 (x - x1)^2 (x - x3) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 68
(2 k1 (x - x1) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 69
(4 k1 (x - x3) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
+ Summand 70
(4 k1 (x - x1) (x - x2) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
(((x - x2)^2 + (y - y2)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 71
(2 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
(Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 72
(4 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
(Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 73
(4 k1 (x - x1)^2 (x - x3) (y - y2) (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 74
(2 k1 (x - x1) (x - x2)^2 (y - y1) (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 75
(4 k1 (x - x1)^2 (x - x2) (y - y1) (y - y3))/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 77
(4 k1 (x - x2) (y - y1) (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 78
(6 k1 (x - x1)^3 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
(((x - x1)^2 + (y - y1)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 79
(6 k1 (x - x1) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 80
(6 k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
(((x - x2)^2 + (y - y2)^2)^(5/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 81
(2 k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
(((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 82
(4 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) (y - y3))/
(((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 83
(4 k1 (x - x1)^2 (x - x2) (y - y2) (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x2)^2 + (y - y2)^2)^(3/2) Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 84
(2 k1 (x - x1)^3 (y - y2) (y - y3))/
(((x - x1)^2 + (y - y1)^2)^(3/2) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+ Summand 85
(6 k1 (x - x1) (y - y2) (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
- Summand 86
(15 k1 (x - x1) (x - x3)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
((x - x3)^2 + (y - y3)^2)^(7/2)
+ Summand 89
(6 k1 (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
((x - x3)^2 + (y - y3)^2)^(5/2)
+ Summand 90
(6 k1 (x - x1)^2 (x - x3) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(5/2))
+ Summand 91
(k1 (x - x1) (x - x2)^2 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3)^2)/
(((x - x2)^2 + (y - y2)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 92
(k1 (x - x1) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3)^2)/
(Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 93
(2 k1 (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3)^2)/
(Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 94
(2 k1 (x - x1)^2 (x - x2) (y - y3)^2)/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
+ Summand 95
(k1 (x - x1)^3 Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
(((x - x1)^2 + (y - y1)^2)^(3/2) ((x - x3)^2 + (y - y3)^2)^(3/2))
- Summand 96
(3 k1 (x - x1) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3)^2)/
(Sqrt[(x - x1)^2 + (y - y1)^2] ((x - x3)^2 + (y - y3)^2)^(3/2))
*)
end;

procedure TDiffEquation03.Part2b(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
      z := 3 * k1 * dx1 * sqr(dx3) * dt1 * t2;
      n := q3;
    end;

    2:
    begin
      z := 2 * k1 * dx1 * dx2 * dx3 * dt1;
      n := t2 * p3;
    end;

    3:
    begin
      z := k1 * dx1 * sqr(dx3) * dt2;
      n := t2 * p2;

    end;

    4:
    begin
      z := k1 * dx1 * dt1 * t2;
      n := p3;
    end;

    5:
    begin
      z := 2 * k1 * dx3 * dt2 * t2;
      n := p3;
    end;

    6:
    begin
      z := 2 * k1 * sqr(dx1) * dx3 * t2;
      n := t1 * p3;
    end;

    7:
    begin
      z := k1 * dx1 * sqr(dx3) * t2;
      n := t1 * p3;
    end;

    8:
    begin
      z := k1 * dx1 * sqr(dx3) * sqr(dy1) * t2;
      n := p1 * p3;
    end;

    9:
    begin
      z := 2 * dx1 * sqr(dx3) * dy1 * dy2;
      n := t1 * t2 * p3;
    end;

    10:
    begin
      z := k1 * dx1 * sqr(dx3) * dt1 * sqr(dy2);
      n := p2 * p3;
    end;

    11:
    begin
      z := k1 * dx1 * sqr(dx2) * dt1;
      n := p2 * t3;
    end;

    12:
    begin
      z := 2 * k1 * dx1 * dx2 * dx3 * dt1;
      n := p2 * t3;
    end;

    13:
    begin
      z := 2 * k1  * dx1 * dt1;
      n := t2 * t3;
    end;

    14:
    begin
      z := 2 * k1 * dx2 * dt1;
      n := t2 * t3;
    end;

    15:
    begin
      z := 2 * k1 * dx3 * dt1;
      n := t2 * t3;
    end;

    16:
    begin
      z := 2 * k1 * sqr(dx1) * dx2;
      n := t1 * t2 * t3;
    end;

    17:
    begin
      z := 2 * k1 * sqr(dx1) * dx3;
      n := t1 * t2 * t3;
    end;

    18:
    begin
      z := 2 * k1 * dx1 * dx2 * dx3;
      n := t1 * t2 * t3;
    end;

    19:
    begin
      z := 2 * k1 * dx1 * dx2 * dx3 * sqr(dy1);
      n := p1 * t2 * t3;
    end;

    20:
    begin
      z := k1 * Power(dx1, 3) * t2;
      n := p1 * t3;
    end;

    21:
    begin
      z := 2 * k1 * sqr(dx1) * dx3 * t2;
      n := p2 * t3;
    end;

    22:
    begin
      z := 4 * k1 * dx1 * t2;
      n := t1 * t3;
    end;

    23:
    begin
      z := 2 * k1 * dx3 * t2;
      n := t1 * t3;
    end;

    24:
    begin
      z := 6 * k1 * sqr(dx1) * dx3 * sqr(dy1) * t2;
      n := q1 * t3;
    end;

    25:
    begin
      z := k1 * dx1 * sqr(dy1) * t2;
      n := p1 * t3;
    end;

    26:
    begin
      z := 2 * k1 * dx3 * sqr(dy1) * t2;
      n := p1 * t3;
    end;

    27:
    begin
      z := 4 * k1 * dx1 * dx2 * dx3 * dy1 * dy2;
      n := t1 * p2 * t3;
    end;

    28:
    begin
      z := 4 * k1 * sqr(dx1) * dx3 * dy1 * dy2;
      n := p1 * t2 * t3;
    end;

    29:
    begin
      z := 2 * k1 * dx1 * dy1 * dy2;
      n := t1* t2 * t3;
    end;

    30:
    begin
      z := 4 * k1 * dx3 * dy1 * dy2;
      n := t1* t2 * t3;
    end;

    31:
    begin
      z := 6 * k1 * dx1 * dx2 * dx3 * dt1 * sqr(dy2);
      n := q2 * t3;
    end;

    32:
    begin
      z := k1 * dx1 * dt1 * sqr(dy2);
      n := p2 * t3;
    end;

    33:
    begin
      z := 2 * k1 * dx3 * dt1 * sqr(dy2);
      n := p2 * t3;
    end;

    34:
    begin
      z := 2 * k1 * sqr(dx1) * dx3 * sqr(dy2);
      n := t1 * p2 * t3;
    end;

    35:
    begin
      z := 3 * k1 * dx1 * sqr(dx2) * dt1 * t3;
      n := q2;
    end;

    36:
    begin
      z := k1 * dx1 * dt1 * t3;
      n := p2;
    end;

    37:
    begin
      z := 2 * k1 * dx2 * dt1 * t3;
      n := p2;
    end;

    38:
    begin
      z := 2 * k1 * sqr(dx1) * dx2 * t3;
      n := t1 * p2;
    end;

    39:
    begin
      z := k1 * dx1 * sqr(dx2) *t3;
      n := t1 * p2;
    end;

    40:
    begin
      z := k1 * dx1 * sqr(dx2) * sqr(dy1) * t3;
      n := p1 * p2;
    end;

    41:
    begin
      z := k1 * Power(dx1, 3) * t3;
      n := p1 * t2;
    end;

    42:
    begin
      z := 2 * k1 * sqr(dx1) * dx2 * t3;
      n := p1 * t2;
    end;

    43:
    begin
      z := 4 * k1 * dx1 * t3;
      n := t1 * t2;
    end;

    44:
    begin
      z := 2 * k1 * dx2 * t3;
      n := t1 * t2;
    end;

    45:
    begin
      z := 6 * k1 * sqr(dx1) * dx2 * sqr(dy1) * t3;
      n := q1 * t2;
    end;

    46:
    begin
      z := k1 * dx1 * sqr(dy1) * t3;
      n := p1 * t2;
    end;

    47:
    begin
      z := 2 * k1 * dx2 * sqr(dy1) * t3;
      n := p1 * t2;
    end;

    48:
    begin
      z := 3 * k1 * Power(dx1, 3) * t2 * t3;
      n := q1;
    end;

    49:
    begin
      z := 3 * k1 * dx1 * t2 * t3;
      n := p1;
    end;

    50:
    begin
      z := 15 * k1 * Power(dx1, 3) * sqr(dy1) * t2 * t3;
      n := r1;
    end;

    51:
    begin
      z := 9 * k1 * dx1 * sqr(dy1) * t2 * t3;
      n := q1;
    end;

    52:
    begin
      z := 6 * k1 * dx1 * sqr(dx2) * (dy1) * dy2 * t3;
      n := t1 * q2;
    end;

    53:
    begin
      z := 4 * k1 * sqr(dx1) * dx2 * dy1 * dy2 * t3;
      n := p1 * p2;
    end;

    54:
    begin
      z := 2 * k1 * dx1 * dy1 * dy2 * t3;
      n := t1 * p2;
    end;

    55:
    begin
      z := 4 * k1 * dx2 * dy1 * dy2 * t3;
      n := t1 * p2;
    end;

    56:
    begin
      z := 6 * k1 * Power(dx1, 3) * dy1 * dy2 * t3;
      n := q1 * t2;
    end;

    57:
    begin
      z := 6 * k1 * dx1 * dy1 * dy2 * t3;
      n := p1 * t2;
    end;

    58:
    begin
      z := 15 * k1 * dx1 * sqr(dx2) * dt1 * sqr(dy2) * t3;
      n := r2;
    end;

    59:
    begin
      z := 3 * k1  * dx1 * dt1 * sqr(dy2) * t3;
      n := q2;
    end;

    60:
    begin
      z := 6 * k1 * dx2 * dt1 * sqr(dy2) * t3;
      n := q2;
    end;

    61:
    begin
      z := 6 * k1 * sqr(dx1) * dx2 * sqr(dy2) * t3;
      n := t1 * q2;
    end;

    62:
    begin
      z := k1 * Power(dx1, 3) * sqr(dy2) * t3;
      n := p1 * p2;
    end;

    63:
    begin
      z := 3 * k1 * dx1 * sqr(dy2) * t3;
      n := t1 * p2;
    end;

    64:
    begin
      z := 6 * k1 * dx1 * sqr(dx3) * dy1 * t2 * dy3;
      n := t1 * q3;
    end;

    65:
    begin
      z := 6 * k1 * dx1 * sqr(dx3) * dt1 * dy2 * dy3;
      n := t2 * q3;
    end;

    66:
    begin
      z := 4 * k1 * dx1 * dx2 * dx3 * dy1 * dy3;
      n := t1 * t2 * p3;
    end;

    67:
    begin
      z := 4 * k1 * sqr(dx1) * dx3 * dy1 * t2 * dy3;
      n := p1 * p3;
    end;

    68:
    begin
      z := 2 * k1 * dx1 * dy1 * t2 * dy3;
      n := t1 * p3;
    end;

    69:
    begin
      z := 4 * k1 * dx3 * dy1 * t2 * dy3;
      n := t1 * p3;
    end;

    70:
    begin
      z := 4 * k1 * dx1 * dx2 * dx3 * dt1 * dy2 * dy3;
      n := p2 * p3;
    end;

    71:
    begin
      z := 2 * k1 * dx1 * dt1 * dy2 * dy3;
      n := t2 * p3;
    end;

    72:
    begin
      z := 4 * k1 * dx3 * dt1 * dy2 * dy3;
      n := t2 * p3;
    end;

    73:
    begin
      z := 4 * k1 * sqr(dx1) * dx3 * dy2 * dy3;
      n := t1 * t2 * p3;
    end;

    74:
    begin
      z := 2 * k1 * dx1 * sqr(dx2) * dy1 * dy3;
      n := t1 * p2 * t3;
    end;

    75:
    begin
      z := 4 * k1 * sqr(dx1) * dx2 * dy1 * dy3;
      n := p1 * t2 * t3;
    end;

    76:
    begin
      z := 2 * k1 * dx1 * dy1 * dy3;
      n := t1 * t2 * t3;
    end;

    77:
    begin
      z := 4 * k1 * dx2 * dy1 * dy3;
      n := t1 * t2 * t3;
    end;

    78:
    begin
      z := 6 * k1 * Power(dx1, 3) * dy1 * t2 * dy3;
      n := q1 * t3;
    end;

    79:
    begin
      z := 6 * k1 * dx1 * dy1 * t2 * dy3;
      n := p1 * t3;
    end;

    80:
    begin
      z := 6 * k1 * dx1 * sqr(dx2) * dt1 * dy2 * dy3;
      n := q2 * t3;
    end;

    81:
    begin
      z := 2 * k1 * dx1 * dt1 * dy2 * dy3;
      n := q2 * t3;
    end;

    82:
    begin
      z := 4 * k1 * dx2 * dt1 * dy2 * dy3;
      n := q2 * t3;
    end;

    83:
    begin
      z := 4 * k1 * sqr(dx1) * dx2 * dy2 * dy3;
      n := t1 * p2 * t3;
    end;

    84:
    begin
      z := 2 * k1 * Power(dx1, 3) * dy2 * dy3;
      n := p1 * t2 * t3;
    end;

    85:
    begin
      z := 6 * k1 * dx1 * dy2 * dy3;
      n := t1 * t2 * t3;
    end;

    86:
    begin
      z := 15 * k1 * dx1 * sqr(dx3) * dt1 * t2 * sqr(dy3);
      n := r3;
    end;

    87:
    begin
      z := 6 * k1 * dx1 * dx2 * dx3 * dt1 * sqr(dy3);
      n := t2 * q3;
    end;

    88:
    begin
      z := 3 * k1 * dx1 * dt1 * t2 * sqr(dy3);
      n := q3;
    end;

    89:
    begin
      z := 6 * k1 * dx3 * dt1 * t2 * sqr(dy3);
      n := q3;
    end;

    90:
    begin
      z := 6 * k1 * sqr(dx1) * dx3 * t2 * sqr(dy3);
      n := t1 * q3;
    end;

    91:
    begin
      z := k1 * dx1 * sqr(dx2) * dt1 * sqr(dy3);
      n := p2 * p3;
    end;

    92:
    begin
      z := k1 * dx1 * dt1 * sqr(dy3);
      n := t2 * p3;
    end;

    93:
    begin
      z := 2 * k1 * dx2 * dt1 * sqr(dy3);
      n := t2 * p3;
    end;

    94:
    begin
      z := 2 * k1 * sqr(dx1) * dx2 * sqr(dy3);
      n := t1 * t2 * p3;
    end;

    95:
    begin
      z := k1 * Power(dx1, 3) * t2 * sqr(dy3);
      n := p1 * p3;
    end;

    96:
    begin
      z := 3 * k1 * dx1 * t2 * sqr(dy3);
      n := t1 * p3;
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

procedure TDiffEquation03.Orig1;
begin
(*
(k1 (x - x1) (x - x3) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+
(k1 (x - x1) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2))/
(Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+
(k1 (x - x1) (x - x2) (y - y1) Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
-
(k1 (x - x1)^2 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x1)^2 + (y - y1)^2)^(3/2)
+
(k1 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
Sqrt[(x - x1)^2 + (y - y1)^2]
-
(k1 (x - x1) (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
((x - x2)^2 + (y - y2)^2)^(3/2)
+
(k1 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
Sqrt[(x - x2)^2 + (y - y2)^2]
+
(k1 (x - x1)^2 (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
-
(k1 (x - x1) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
((x - x3)^2 + (y - y3)^2)^(3/2)
+
(k1 (x - x1) (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3))/
(Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
+
(k1 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
Sqrt[(x - x3)^2 + (y - y3)^2]
+
(k1 (x - x1)^2 Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
(Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
*)
end;

function TDiffEquation03.Run1(x, y: single): single;
begin
  Accu := 0;

  PrepDiffOK := (abs(t1) > Epsilon)
    and (abs(t2) > Epsilon)
    and (abs(t3) > Epsilon)
    and (abs(p1) > Epsilon)
    and (abs(p2) > Epsilon)
    and (abs(p3) > Epsilon)
    and (abs(dt1) > Epsilon)
    and (abs(dt2) > Epsilon)
    and (abs(dt3) > Epsilon);

  if PrepDiffOK then
  begin
    Part1(1, x, y, True);
    Part1(2, x, y, True);
    Part1(3, x, y, True);
    Part1(4, x, y, False);
    Part1(5, x, y, True);
    Part1(6, x, y, False);
    Part1(7, x, y, True);
    Part1(8, x, y, True);
    Part1(9, x, y, False);
    Part1(10, x, y, True);
    Part1(11, x, y, True);
    Part1(12, x, y, True);
  end;

  result := Accu;
end;

procedure TDiffEquation03.Part1(i: Integer; x, y: single; b: Boolean);
begin
  Part1b(i, x, y, b);
end;

procedure TDiffEquation03.Part1a(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
//    (k1 (x - x1) (x - x3) (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * dx1 * dx3 * dy1 * t2;
      n := t2 * t3;
    end;

    2:
    begin
//    (k1 (x - x1) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * dx1 * dx3 * dt1 * dy2;
      n := t2 * t3;
    end;

    3:
    begin
//    (k1 (x - x1) (x - x2) (y - y1) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * dx1 * dx2 * dy1 * t3;
      n := t1 * t2;
    end;

    4:
    begin
//    (k1 (x - x1)^2 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x1)^2 + (y - y1)^2)^(3/2)
      z := k1 * sqr(dx1) * dy1 * t2 * t3;
      n := p1;
    end;

    5:
    begin
//    (k1 (y - y1) Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])/
//    Sqrt[(x - x1)^2 + (y - y1)^2]
      z := k1 * dy1 * t2 * t3;
      n := t1;
    end;

    6:
    begin
//    (k1 (x - x1) (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    ((x - x2)^2 + (y - y2)^2)^(3/2)
      z := k1 * dx1 * dx2 * dt1 * dy2 * t3;
      n := p2;
    end;

    7:
    begin
//    (k1 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    Sqrt[(x - x2)^2 + (y - y2)^2]
      z := k1 * dt1 * dy2 * t3;
      n := t2;
    end;

    8:
    begin
//    (k1 (x - x1)^2 (y - y2) Sqrt[(x - x3)^2 + (y - y3)^2])/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x2)^2 + (y - y2)^2])
      z := k1 * sqr(dx1) * dy2 * t3;
      n := t1 * t2;
    end;

    9:
    begin
//    (k1 (x - x1) (x - x3) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    ((x - x3)^2 + (y - y3)^2)^(3/2)
      z := k1 * dx1 * dx3 * dt1 * t2 * dy3;
      n := p3;
    end;

    10:
    begin
//    (k1 (x - x1) (x - x2) (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) (y - y3))/
//    (Sqrt[(x - x2)^2 + (y - y2)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * dx1 * dx2 * dt1 * dy3;
      n := t2 * t3;
    end;

    11:
    begin
//    (k1 (-l1 + Sqrt[(x - x1)^2 + (y - y1)^2]) Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    Sqrt[(x - x3)^2 + (y - y3)^2]
      z := k1 * dt1 * t2 * dy3;
      n := t3;
    end;

    12:
    begin
//    (k1 (x - x1)^2 Sqrt[(x - x2)^2 + (y - y2)^2] (y - y3))/
//    (Sqrt[(x - x1)^2 + (y - y1)^2] Sqrt[(x - x3)^2 + (y - y3)^2])
      z := k1 * sqr(dx1) * t2 * dy3;
      n := t1 * t3;
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

procedure TDiffEquation03.Part1b(i: Integer; x, y: single; b: Boolean);
var
  z, n, q: single;
begin
  case i of
    1:
    begin
      z := k1 * dx1 * dx3 * dy1 * t2;
      n := t2 * t3;
    end;

    2:
    begin
      z := k1 * dx1 * dx3 * dt1 * dy2;
      n := t2 * t3;
    end;

    3:
    begin
      z := k1 * dx1 * dx2 * dy1 * t3;
      n := t1 * t2;
    end;

    4:
    begin
      z := k1 * sqr(dx1) * dy1 * t2 * t3;
      n := p1;
    end;

    5:
    begin
      z := k1 * dy1 * t2 * t3;
      n := t1;
    end;

    6:
    begin
      z := k1 * dx1 * dx2 * dt1 * dy2 * t3;
      n := p2;
    end;

    7:
    begin
      z := k1 * dt1 * dy2 * t3;
      n := t2;
    end;

    8:
    begin
      z := k1 * sqr(dx1) * dy2 * t3;
      n := t1 * t2;
    end;

    9:
    begin
      z := k1 * dx1 * dx3 * dt1 * t2 * dy3;
      n := p3;
    end;

    10:
    begin
      z := k1 * dx1 * dx2 * dt1 * dy3;
      n := t2 * t3;
    end;

    11:
    begin
      z := k1 * dt1 * t2 * dy3;
      n := t3;
    end;

    12:
    begin
      z := k1 * sqr(dx1) * t2 * dy3;
      n := t1 * t3;
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

procedure TDiffEquation03.Prep(x, y: single);
begin
  _dx1 := x - x1;
  _dx2 := x - x2;
  _dx3 := x - x3;

  _dy1 := y - y1;
  _dy2 := y - y2;
  _dy3 := y - y3;

  a1 := sqr(_dx1) + sqr(_dy1);
  a2 := sqr(_dx2) + sqr(_dy2);
  a3 := sqr(_dx3) + sqr(_dy3);

  _t1 := sqrt(a1);
  _t2 := sqrt(a2);
  _t3 := sqrt(a3);

  _dt1 := _t1 - l1;
  _dt2 := _t2 - l2;
  _dt3 := _t3 - l3;

  _p1 := Power(a1, 3/2);
  _p2 := Power(a2, 3/2);
  _p3 := Power(a3, 3/2);

  _q1 := Power(a1, 5/2);
  _q2 := Power(a2, 5/2);
  _q3 := Power(a3, 5/2);

  _r1 := Power(a1, 7/2);
  _r2 := Power(a2, 7/2);
  _r3 := Power(a3, 7/2);
end;

procedure TDiffEquation03.RotateVars(Idx: Integer);
begin
  case Idx of
    3:
    begin
      dx1 := _dx3;
      dx2 := _dx1;
      dx3 := _dx2;

      dy1 := _dy3;
      dy2 := _dy1;
      dy3 := _dy2;

      t1 := _t3;
      t2 := _t1;
      t3 := _t2;

      dt1 := _dt3;
      dt2 := _dt1;
      dt3 := _dt2;

      p1 := _p3;
      p2 := _p1;
      p3 := _p2;

      q1 := _q3;
      q2 := _q1;
      q3 := _q2;

      r1 := _r3;
      r2 := _r1;
      r3 := _r2;

      k := k3;
    end;
    2:
    begin
      dx1 := _dx2;
      dx2 := _dx3;
      dx3 := _dx1;

      dy1 := _dy2;
      dy2 := _dy3;
      dy3 := _dy1;

      t1 := _t2;
      t2 := _t3;
      t3 := _t1;

      dt1 := _dt2;
      dt2 := _dt3;
      dt3 := _dt1;

      p1 := _p2;
      p2 := _p3;
      p3 := _p1;

      q1 := _q2;
      q2 := _q3;
      q3 := _q1;

      r1 := _r2;
      r2 := _r3;
      r3 := _r1;

      k := k2;
    end;
    else
    begin
      dx1 := _dx1;
      dx2 := _dx2;
      dx3 := _dx3;

      dy1 := _dy1;
      dy2 := _dy2;
      dy3 := _dy3;

      t1 := _t1;
      t2 := _t2;
      t3 := _t3;

      dt1 := _dt1;
      dt2 := _dt2;
      dt3 := _dt3;

      p1 := _p1;
      p2 := _p2;
      p3 := _p3;

      q1 := _q1;
      q2 := _q2;
      q3 := _q3;

      r1 := _r1;
      r2 := _r2;
      r3 := _r3;

      k := k1;
    end;
  end;
end;

function TDiffEquation03.Diff1(i: Integer; x, y: single): single;
var
  pd1: single;
  pd2: single;
  pd3: single;
begin
  Prep(x, y);
  case i of
    1, 2, 3:
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
      RotateVars(3);
      pd3 := Run1(x, y);
      result := (pd1 + pd2 + pd3) * 100;
    end;
  end;
  result := result * 8;
  //result := abs(result);
end;

function TDiffEquation03.Diff2(i: Integer; x, y: single): single;
var
  pd1: single;
  pd2: single;
  pd3: single;
begin
  Prep(x, y);
  case i of
    1, 2, 3:
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
      RotateVars(3);
      pd3 := Run2(x, y);
      result := (pd1 + pd2 + pd3) * 100;
    end;
  end;
  result := result * 8;
  //result := abs(result);
end;

end.
