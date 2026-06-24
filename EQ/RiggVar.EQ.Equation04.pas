unit RiggVar.EQ.Equation04;

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
  System.Classes,
  System.Math,
  System.Math.Vectors,
  System.Types,
  RiggVar.FB.Equation;

type
  TFederEquation04 = class(TFederEquation)
  private
    u1, u2, u3, u4: single;
    v1, v2, v3, v4: single;
    u, v: single;

    cf, sf: single;

    _vp, _v1, _v2, _v3, _v4: TPoint3D;
    _f0, _f1, _f2, _f3, _f4: TPoint3D;
    _n1, _n2, _n3, _n4: TPoint3D;

    g7: single;
    procedure f03(x, y: single);
    procedure BerechneWinkel(x, y: single);
  protected
    procedure InitPascal(ML: TStrings);
    procedure InitMaxima(ML: TStrings);
  public
    constructor Create(AModelID: Integer = 1); override;
    procedure InitKoord; override;
    procedure InitMemo(ML: TStrings); override;
    function GetValue(x, y : single): single; override;
    function CalcValue(x, y : single; af: Integer): single; override;
    function CalcRaw(x, y : single): single; override;
    function GetStatusLine: string; override;
  end;

implementation

constructor TFederEquation04.Create;
begin
  inherited Create(AModelID);
  FSpringCount := 4;
end;

procedure TFederEquation04.f03(x, y : single);
begin
  a1 := sqr(x-x1) + sqr(y-y1);
  a2 := sqr(x-x2) + sqr(y-y2);
  a3 := sqr(x-x3) + sqr(y-y3);
  a4 := sqr(x-x4) + sqr(y-y4);

//  t1 := sqrt(a1);
//  t2 := sqrt(a2);
//  t3 := sqrt(a3);
//  t4 := sqrt(a4);
  t1 := sqrt(a1 + sqr(z1));
  t2 := sqrt(a2 + sqr(z2));
  t3 := sqrt(a3 + sqr(z3));
  t4 := sqrt(a4 + sqr(z4));

  g7 := 0;
  case Plot of

    4:
    begin
      { Betrag }
      if (t1 > Epsilon) and (t2 > Epsilon)
      and (t3 > Epsilon) and (t4 > Epsilon) then
      begin
//        f1 := k1 * (t1 - l1);
//        f2 := k2 * (t2 - l2);
//        f3 := k3 * (t3 - l3);
//        f4 := k4 * (t4 - l4);
        if ForceMode = 3 then
        begin
          f1 := Force(k1, t1, l1, m1);
          f2 := Force(k2, t2, l2, m2);
          f3 := Force(k3, t3, l3, m3);
          f4 := Force(k4, t4, l4, m4);
        end
        else
        begin
          f1 := Kraft(k1, t1, l1);
          f2 := Kraft(k2, t2, l2);
          f3 := Kraft(k3, t3, l3);
          f4 := Kraft(k4, t4, l4);
        end;

        u1 := f1 * (x-x1) / t1;
        u2 := f2 * (x-x2) / t2;
        u3 := f3 * (x-x3) / t3;
        u4 := f4 * (x-x4) / t4;

        v1 := f1 * (y-y1) / t1;
        v2 := f2 * (y-y2) / t2;
        v3 := f3 * (y-y3) / t3;
        v4 := f4 * (y-y4) / t4;

        u := u1 + u2 + u3 + u4;
        v := v1 + v2 + v3 + v4;

        g7 := sqrt(sqr(u) + sqr(v));
        g7 := g7 * FaktorEQ;
      end
      else
      begin
        g7 := 4 * abs(k1 * l1);
        g7 := g7 * FaktorEQ;
      end;
    end;

    6:
    begin
      { Richtung }
      BerechneWinkel(x, y);
    end;

    8:
    begin
      { Energie }
      b1 := k1 * sqr(t1 - l1) / 2;
      b2 := k2 * sqr(t2 - l2) / 2;
      b3 := k3 * sqr(t3 - l3) / 2;
      b4 := k4 * sqr(t4 - l4) / 2;
      g7 := (b1 + b2 + b3 + b4) * FaktorEQ;
    end;

    else
    begin
      if SolutionMode then
      begin
        b1 := t2 * t3 * t4 * (t1-l1) * k1;
        b2 := t1 * t3 * t4 * (t2-l2) * k2;
        b3 := t1 * t2 * t4 * (t3-l3) * k3;
        b4 := t1 * t2 * t3 * (t4-l4) * k4;

        u1 := b1 * (x - x1);
        u2 := b2 * (x - x2);
        u3 := b3 * (x - x3);
        u4 := b4 * (x - x4);

        v1 := b1 * (y - y1);
        v2 := b2 * (y - y2);
        v3 := b3 * (y - y3);
        v4 := b4 * (y - y4);

        u := u1 + u2 + u3 + u4;
        v := v1 + v2 + v3 + v4;
      end
      else
      begin
        if (t1 > Epsilon) and (t2 > Epsilon)
          and (t3 > Epsilon) and (t4 > Epsilon) then
        begin
          if ForceMode = 3 then
          begin
            f1 := Force(k1, t1, l1, m1);
            f2 := Force(k2, t2, l2, m2);
            f3 := Force(k3, t3, l3, m3);
            f4 := Force(k4, t4, l4, m4);
          end
          else
          begin
            f1 := Kraft(k1, t1, l1);
            f2 := Kraft(k2, t2, l2);
            f3 := Kraft(k3, t3, l3);
            f4 := Kraft(k4, t4, l4);
          end;

          u1 := f1 * (x-x1) / t1;
          u2 := f2 * (x-x2) / t2;
          u3 := f3 * (x-x3) / t3;
          u4 := f4 * (x-x4) / t4;

          v1 := f1 * (y-y1) / t1;
          v2 := f2 * (y-y2) / t2;
          v3 := f3 * (y-y3) / t3;
          v4 := f4 * (y-y4) / t4;

          u := (u1 + u2 + u3 + u4) * 100000;
          v := (v1 + v2 + v3 + v4) * 100000;
        end
        else
        begin
          case Plot of
            11:
            begin
              u := k1 * l1 * 2 * 100000;
              v := u;
            end;
            else
            begin
              u := 0;
              v := 0;
            end;
          end;
        end;
      end;

      case Plot of
        0: g7 := v;
        1:
        begin
          if SolutionMode then
            g7 := (b1 + b2 + b3 + b4)
          else
            g7 := (f1 + f2 + f3 + f4) * 100000;
        end;
        2: g7 := sqrt(sqr(u) + sqr(v));
        3: g7 := u;
        //4: Betrag
        5: g7 := Abs(u + v);
        //6: Richtung
        7: g7 := Abs(v);
        //8: Energie;
        9: g7 := u;
       10: g7 := Abs(u);
       11: g7 := Abs(u) + Abs(v);
       12: g7 := Sin( t1 / 10 ) * 10000000;
       13: g7 := Abs(Sin( t1 / 10 ) * 10000000);
      end;

    end;
  end;

end;

function TFederEquation04.GetStatusLine: string;
begin
  case Plot of
    0: result := 'v';
    1:
    begin
      if SolutionMode then
        result := 'sum bn'
      else
        result := 'sum fn'
    end;
    2: result := 'sqrt(sum q)';
    3: result := 'u + v';
    4: result := StrBetrag;
    5: result := 'abs(u + v)';
    6: result := StrRichtung;
    7: result := 'abs(v)';
    8: result := StrEnergie;
    9: result := 'u';
    10: result := 'abs(u)';
    11: result := 'abs(u) + abs(v)';
    12: result := 'sin(t1/10)';
    13: result := 'abs(sin(t1/10))';
  end;
end;

procedure TFederEquation04.InitMemo(ML: TStrings);
begin
  case SourceFormat of
    0: InitPascal(ML);
    1: InitMaxima(ML);
  end;
end;

function TFederEquation04.GetValue(x, y: single): single;
begin
  result := 0;
  if Plot > -1 then
  begin
    if WantDiff or WantDiffOnce then
    begin
      d := 0.01;
      d1 := CalcValue(x - d, y, Figure);
      d2 := CalcValue(x + d, y, Figure);
      d3 := CalcValue(x, y - d, Figure);
      d4 := CalcValue(x, y + d, Figure);
      result := ((d2 - d1) + (d4 - d3)) / d * 4;
    end
    else
    begin
      result := CalcValue(x, y, Figure);
    end;
  end;

  if result > MaxInt then
    result := MaxInt;
  if result < -MaxInt then
    result := -MaxInt;
end;

function TFederEquation04.CalcRaw(x, y: single): single;
begin
  if fcap < 1 then
    fcap := 1;
  f03(x, y);
  result := g7;
end;

function TFederEquation04.CalcValue(x, y: single; af: Integer): single;
begin
  if fcap < 1 then
    fcap := 1;
  f03(x, y);
  result := g7 / fcap - OffsetZ;
  if PlusCap and (result > pcap) then
    result := pcap;
  if MinusCap and (result < mcap) then
    result := mcap;
end;

procedure TFederEquation04.BerechneWinkel(x, y: single);
begin
  { Betrag Kraft in Feder}
//  b1 := k1 * (t1 - l1);
//  b2 := k2 * (t2 - l2);
//  b3 := k3 * (t3 - l3);
//  b4 := k4 * (t4 - l4);
  if ForceMode = 3 then
  begin
    b1 := Force(k1, t1, l1, m1);
    b2 := Force(k2, t2, l2, m2);
    b3 := Force(k3, t3, l3, m3);
    b4 := Force(k4, t4, l4, m4);
  end
  else
  begin
    b1 := Kraft(k1, t1, l1);
    b2 := Kraft(k2, t2, l2);
    b3 := k3 * (t3 - l3);
    b4 := k4 * (t4 - l4);
  end;

  { gemeinsamer Punkt }
  _vp := TPoint3D.Create(x, y, 0);

  { TPoint3D in Richtung der Feder }
  _v1 := _vp - TPoint3D.Create(x1, y1, 0);
  _v2 := _vp - TPoint3D.Create(x2, y2, 0);
  _v3 := _vp - TPoint3D.Create(x3, y3, 0);
  _v4 := _vp - TPoint3D.Create(x4, y4, 0);

  { normalisierte Kraft in Richtung Feder mit Betrag 1 }
  _n1 := _v1.Normalize;
  _n2 := _v2.Normalize;
  _n3 := _v3.Normalize;
  _n4 := _v4.Normalize;

  { betragsrichtige Kraft in Feder }
  _f1 := _n1 * b1;
  _f2 := _n2 * b2;
  _f3 := _n3 * b3;
  _f4 := _n4 * b4;

  { resultierende Kraft }
  _f0 := _f1 + _f2;
  _f0 := _f0 + _f3;
  _f0 := _f0 + _f4;

  { Cosinus und Sinus von F}
  cf := _f0.AngleCosine(TPoint3D.Create(1, 0, 1));
  sf := _f0.AngleCosine(TPoint3D.Create(0, 1, 1));

  case PlotFigure of
    1:
    begin
      g7 := cf * 200 * FaktorEQ;
    end;

    2:
    begin
      g7 := Abs(cf) * 200 * FaktorEQ;
    end;

    3:
    begin
      g7 := Abs(sf) * 200 * FaktorEQ;
    end;

    4:
    begin
      g7 := sf * 200 * FaktorEQ;
    end;

  end;

end;

procedure TFederEquation04.InitKoord;
begin
  FaktorG3 := 25.0;
  FaktorEQ := 500 * 1000;
  MaxPlotFigure := 4;

  x1 := -30; y1 :=  0; l1 := 30; k1 := 1;
  x2 :=  30; y2 :=  0; l2 := 30; k2 := 1;
  x3 := -30; y3 := 10; l3 := 30; k3 := 1;
  x4 :=  30; y4 := 10; l4 := 30; k4 := 1;
end;

procedure TFederEquation04.InitPascal(ML: TStrings);
begin
  ML.Add('a1 := sqr(x-x1) + sqr(y-y1);');
  ML.Add('a2 := sqr(x-x2) + sqr(y-y2);');
  ML.Add('a3 := sqr(x-x3) + sqr(y-y3);');
  ML.Add('a4 := sqr(x-x4) + sqr(y-y4);');
  ML.Add('t1 := sqrt(a1);');
  ML.Add('t2 := sqrt(a2);');
  ML.Add('t3 := sqrt(a3);');
  ML.Add('t4 := sqrt(a4);');
  case Plot of
    4:
    begin
      ML.Add('f1 := k1 * (t1-l1);');
      ML.Add('f2 := k2 * (t2-l2);');
      ML.Add('f3 := k3 * (t3-l3);');
      ML.Add('f4 := k4 * (t4-l4);');
      ML.Add('');
      ML.Add('u1 := f1 * (x-x1) / t1;');
      ML.Add('u2 := f2 * (x-x2) / t2;');
      ML.Add('u3 := f3 * (x-x3) / t3;');
      ML.Add('u4 := f4 * (x-x4) / t4;');
      ML.Add('');
      ML.Add('v1 := f1 * (y-y1) / t1;');
      ML.Add('v2 := f2 * (y-y2) / t2;');
      ML.Add('v3 := f3 * (y-y3) / t3;');
      ML.Add('v4 := f4 * (y-y4) / t4;');
      ML.Add('');
      ML.Add('u := u1 + u2 + u3 + u4;');
      ML.Add('v := v1 + v2 + v3 + v4;');
      ML.Add('');
      ML.Add('g7 := sqrt(u) + sqr(v));');
    end;
    6:
    begin
      ML.Add(StrBerechneWinkel + '(x, y);');
    end;
    8:
    begin
      ML.Add('b1 := k1 * sqr(t1-l1) / 2;');
      ML.Add('b2 := k2 * sqr(t2-l2) / 2;');
      ML.Add('b3 := k3 * sqr(t3-l3) / 2;');
      ML.Add('b4 := k4 * sqr(t4-l4) / 2;');
      ML.Add('g7 := b1 + b2 + b3 + b4;');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1 := t2 * t3 * t4 * (t1-l1) * k1;');
        ML.Add('b2 := t1 * t3 * t4 * (t2-l2) * k2;');
        ML.Add('b3 := t1 * t2 * t4 * (t3-l3) * k3;');
        ML.Add('b4 := t1 * t2 * t3 * (t4-l4) * k4;');
        ML.Add('');
        ML.Add('u1 := b1 * (x-x1);');
        ML.Add('u2 := b2 * (x-x2);');
        ML.Add('u3 := b3 * (x-x3);');
        ML.Add('u4 := b4 * (x-x4);');
        ML.Add('');
        ML.Add('v1 := b1 * (y-y1);');
        ML.Add('v2 := b2 * (y-y2);');
        ML.Add('v3 := b3 * (y-y3);');
        ML.Add('v4 := b4 * (y-y4);');
        ML.Add('');
        ML.Add('u := u1 + u2 + u3 + u3;');
        ML.Add('v := v1 + v2 + v3 + u4;');
      end
      else
      begin
        ML.Add('f1 := k1 * (t1-l1);');
        ML.Add('f2 := k2 * (t2-l2);');
        ML.Add('f3 := k3 * (t3-l3);');
        ML.Add('f4 := k4 * (t4-l4);');
        ML.Add('');
        ML.Add('u1 := f1 * (x-x1) / t1;');
        ML.Add('u2 := f2 * (x-x2) / t2;');
        ML.Add('u3 := f3 * (x-x3) / t3;');
        ML.Add('u4 := f4 * (x-x4) / t4;');
        ML.Add('');
        ML.Add('v1 := f1 * (y-y1) / t1;');
        ML.Add('v2 := f2 * (y-y2) / t2;');
        ML.Add('v3 := f3 * (y-y3) / t3;');
        ML.Add('v4 := f4 * (y-y4) / t4;');
        ML.Add('');
        ML.Add('u := u1 + u2 + u3 + u4;');
        ML.Add('v := v1 + v2 + v3 + v4;');
      end;
    end;
  end;
end;

procedure TFederEquation04.InitMaxima(ML: TStrings);
begin
  ML.Add(SampleInfo);
  ML.Add('');
  ML.Add('a1: (x-x1)^2 + (y-y1)^2$');
  ML.Add('a2: (x-x2)^2 + (y-y2)^2$');
  ML.Add('a3: (x-x3)^2 + (y-y3)^2$');
  ML.Add('a4: (x-x4)^2 + (y-y4)^2$');

  ML.Add('');
  if z1 = 0 then
    ML.Add('t1: sqrt(a1)$')
  else
    ML.Add('t1: sqrt(a1 + z1^2)$');

  if z2 = 0 then
    ML.Add('t2: sqrt(a2)$')
  else
    ML.Add('t2: sqrt(a2 + z2^2)$');

  if z3 = 0 then
    ML.Add('t3: sqrt(a3)$')
  else
    ML.Add('t3: sqrt(a3 + z3^2)$');

  if z4 = 0 then
    ML.Add('t4: sqrt(a4)$')
  else
    ML.Add('t4: sqrt(a4 + z4^2)$');

  ML.Add('');
  case Plot of
    4:
    begin
      ML.Add('f1: k1 * (t1-l1)$');
      ML.Add('f2: k2 * (t2-l2)$');
      ML.Add('f3: k3 * (t3-l3)$');
      ML.Add('f4: k4 * (t4-l4)$');
      ML.Add('');
      ML.Add('u1: f1 * (x-x1) / t1$');
      ML.Add('u2: f2 * (x-x2) / t2$');
      ML.Add('u3: f3 * (x-x3) / t3$');
      ML.Add('u4: f4 * (x-x4) / t4$');
      ML.Add('');
      ML.Add('v1: f1 * (y-y1) / t1$');
      ML.Add('v2: f2 * (y-y2) / t2$');
      ML.Add('v3: f3 * (y-y3) / t3$');
      ML.Add('v4: f4 * (y-y4) / t4$');
      ML.Add('');
      ML.Add('u: u1 + u2 + u3 + u4$');
      ML.Add('v: v1 + v2 + v3 + u4$');
      ML.Add('');
      ML.Add('bf: sqrt(u^2 + v^2)$');
      ML.Add('');
      ML.Add(Format('g7: bf * %d$', [FaktorEQ]));
    end;
//    6:
//    begin
//      ML.Add(StrBerechneWinkel + '(x, y);');
//    end;
    8:
    begin
      ML.Add('b1: k1 * (t1-l1)^2 / 2$');
      ML.Add('b2: k2 * (t2-l2)^2 / 2$');
      ML.Add('b3: k3 * (t3-l3)^2 / 2$');
      ML.Add('b4: k4 * (t4-l4)^2 / 2$');
      ML.Add('g7: (b1 + b2 + b3 + b4) * 5000$');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1: t2 * t3 * t4 * (t1-l1) * k1$');
        ML.Add('b2: t1 * t3 * t4 * (t2-l2) * k2$');
        ML.Add('b3: t1 * t2 * t4 * (t3-l3) * k3$');
        ML.Add('b4: t1 * t2 * t3 * (t4-l4) * k4$');
        ML.Add('');
        ML.Add('u1: b1 * (x - x1)$');
        ML.Add('u2: b2 * (x - x2)$');
        ML.Add('u3: b3 * (x - x3)$');
        ML.Add('u4: b4 * (x - x4)$');
        ML.Add('');
        ML.Add('v1: b1 * (y - y1)$');
        ML.Add('v2: b2 * (y - y2)$');
        ML.Add('v3: b3 * (y - y3)$');
        ML.Add('v4: b4 * (y - y4)$');
        ML.Add('');
        ML.Add('u: u1 + u2 + u3 + u4$');
        ML.Add('v: v1 + v2 + v3 + u4$');
        ML.Add('');
      end
      else
      begin
        ML.Add('f1: k1 * (t1-l1)$');
        ML.Add('f2: k2 * (t2-l2)$');
        ML.Add('f3: k3 * (t3-l3)$');
        ML.Add('f4: k4 * (t4-l4)$');
        ML.Add('');
        ML.Add('u1: f1 * (x-x1) / t1$');
        ML.Add('u2: f2 * (x-x2) / t2$');
        ML.Add('u3: f3 * (x-x3) / t3$');
        ML.Add('u4: f4 * (x-x4) / t4$');
        ML.Add('');
        ML.Add('v1: f1 * (y-y1) / t1$');
        ML.Add('v2: f2 * (y-y2) / t2$');
        ML.Add('v3: f3 * (y-y3) / t3$');
        ML.Add('v4: f4 * (y-y4) / t4$');
        ML.Add('');
        ML.Add('u: (u1 + u2 + u3 + u4) * 100000$');
        ML.Add('v: (v1 + v2 + v3 + u4) * 100000$');
        ML.Add('');
      end;
      case Plot of
        0: ML.Add('g7: v$');
        1:
        begin
          if SolutionMode then
            ML.Add('g7: (b1 + b2 + b3 + b4)$')
          else
            ML.Add('g7: (f1 + f2 + f3 + b4) * 100000$');
        end;
        2: ML.Add('g7: sqrt(u^2 + v^2) + 5$');
        3: ML.Add('g7: u + v$');
//      4: Betrag
        5: ML.Add('g7: abs(u + v)$');
//      6: Richtung;
        7: ML.Add('g7: abs(v)$');
//      8: Energie;
        9: ML.Add('g7: u$');
       10: ML.Add('g7: abs(u)$');
       11: ML.Add('g7: abs(u) + abs(v)$');
       12: ML.Add('g7: sin( t1 / 10 ) * 10000000$');
       13: ML.Add('g7: abs(sin( t1 / 10 ) * 10000000)$');
      end;
    end;
  end;
  ML.Add('');
  if OffsetZ = 0 then
    ML.Add(Format('f: g7 / %.2f$', [fcap]))
  else
    ML.Add(Format('f: g7 / %.2f - %d$', [fcap, OffsetZ]));
  ML.Add('');
  ML.Add(Format('x1: %.2f$ x2: %.2f$ x3: %.2f$ x4: %.2f$', [x1, x2, x3, x4]));
  ML.Add(Format('y1: %.2f$ y2: %.2f$ y3: %.2f$ y4: %.2f$', [y1, y2, y3, y4]));
  ML.Add(Format('z1: %.2f$ z2: %.2f$ z3: %.2f$ z4: %.2f$', [z1, z2, z3, z4]));
  ML.Add(Format('l1: %.2f$ l2: %.2f$ l3: %.2f$ l4: %.2f$', [l1, l2, l3, l4]));
  ML.Add(Format('k1: %.2f$ k2: %.2f$ k3: %.2f$ k4: %.2f$', [k1, k2, k3, k4]));
  ML.Add('');
  ML.Add(Format('plot3d(f, [x,%.2f,%.2f], [y,%.2f,%.2f], [z,-100,100], [plot_format,xmaxima]);',
  [rmin, rmax, rmin, rmax]));
end;

end.

