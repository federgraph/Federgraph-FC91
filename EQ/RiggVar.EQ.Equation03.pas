unit RiggVar.EQ.Equation03;

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
  TFederEquation03 = class(TFederEquation)
  private
    u1, u2, u3: single;
    v1, v2, v3: single;
    u, v: single;
    bf: single;

    cf, sf: single;

    _vp, _v1, _v2, _v3: TPoint3D;
    _f0, _f1, _f2, _f3: TPoint3D;
    _n1, _n2, _n3: TPoint3D;

//    iPhi: single;
//    jRadius: single;
//    iPhiMin, iPhiMax: single;

    g7: single;

    procedure BerechneWinkel(x, y: single);
    procedure f03(x, y: single);
    function NumericDiff(x, y: single): single;
    function NumericDiff01(x, y: single): single;
    function NumericDiff02(x, y: single): single;
    function NumericDiff03(x, y: single): single;
  protected
    procedure InitPascal(ML: TStrings);
    procedure InitMaxima(ML: TStrings);
    function ProbeM(x, y: single): Boolean;
  public
    constructor Create(AModelID: Integer = 1); override;
    procedure InitKoord; override;
    procedure InitMemo(ML: TStrings); override;
    procedure CalcBF(x, y: single); override;
    function GetValue(x, y : single): single; override;
    function CalcValue(x, y : single; af: Integer): single; override;
    function CalcRaw(x, y : single): single; override;
    function GetStatusLine: string; override;
  end;

implementation

constructor TFederEquation03.Create;
begin
  inherited Create(AModelID);
  FSpringCount := 3;
end;

procedure TFederEquation03.f03(x, y : single);
begin
  a3 := sqr(x-x3) + sqr(y-y3);
  t3 := sqrt(a3 + sqr(z3));

  g7 := 0;

  { Rechteck }
//  if SliceMode = 1 then
//  begin
//    if ((x < iv - iw) or (x > iv + iw))
//    or ((y < jv - jw) or (y > jv + jw)) then
//    begin
//      Exit;
//    end;
//  end;

  { Kreuz }
//  if SliceMode = 2 then
//  begin
//    if ((x < iv - iw) or (x > iv + iw))
//    and ((y < jv - jw) or (y > jv + jw)) then
//    begin
//      //yes, do it
//    end
//    else
//      Exit;
//  end;

  { Ring um Punkt 3 }
//  if SliceMode = 3 then
//  begin
//    if (t3 < l3 - 1) or (t3 > l3 + 1) then
//    begin
//      Exit;
//    end;
//  end;

  { Torte }
//  if SliceMode = 4 then
//  begin
//    iPhi := 0;
//    jRadius := sqrt(sqr(x) + sqr(y));
//    if jRadius > Epsilon then
//    begin
//      iPhi := arccos(x / jRadius);
//      iPhiMin := (iv - iw) * PI / 180;
//      iPhiMax := (iv + iw) * PI / 180;
//    end;
//    if  (iPhi < iPhiMin) or (iPhi > iPhiMax) then
//    begin
//      Exit;
//    end
//  end;

  { Ring um Null }
//  if SliceMode = 5 then
//  begin
//    jRadius := sqrt(sqr(x) + sqr(y));
//    if (jRadius < jv - jw) or (jRadius > jv + jw) then
//    begin
//      Exit;
//    end;
//  end;

  a1 := sqr(x-x1) + sqr(y-y1);
  a2 := sqr(x-x2) + sqr(y-y2);

  t1 := sqrt(a1 + sqr(z1));
  t2 := sqrt(a2 + sqr(z2));

  case Plot of

    4:
    begin
      { Betrag }
      if (t1 > Epsilon) and (t2 > Epsilon) and (t3 > Epsilon) then
      begin
        if ForceMode = 3 then
        begin
          f1 := Force(k1, t1, l1, m1);
          f2 := Force(k2, t2, l2, m2);
          f3 := Force(k3, t3, l3, m3);
        end
        else
        begin
          f1 := Kraft(k1, t1, l1);
          f2 := Kraft(k2, t2, l2);
          f3 := Kraft(k3, t3, l3);
        end;

        u1 := f1 * (x-x1) / t1;
        u2 := f2 * (x-x2) / t2;
        u3 := f3 * (x-x3) / t3;

        v1 := f1 * (y-y1) / t1;
        v2 := f2 * (y-y2) / t2;
        v3 := f3 * (y-y3) / t3;

        u := u1 + u2 + u3;
        v := v1 + v2 + v3;

        bf := sqrt(sqr(u) + sqr(v));

        g7 := bf * FaktorEQ;
      end
      else
      begin
        u := 4 * abs(k1 * l1);
        g7 := u * FaktorEQ;
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
      g7 := (b1 + b2 + b3) * 5000;
    end;

    21:
    begin
      { 1995-1 }
      b1 := t2 * t3 * (t1-l1) * k1 *(x-x1 + y - y1);
      b2 := t1 * t3 * (t2-l2) * k2 *(x-x2 + y - y2);
      b3 := t1 * t2 * (t3-l3) * k3 *(x-x3 + y - y3);
      g7 := (b1 + b2 + b3);
    end;

    22:
    begin
      { 1995-2 }
      x1 := -40; y1 := -30; l1 := 30; k1 := 1;
      x2 :=  40; y2 := -30; l2 := 30; k2 := 1;
      x3 :=   0; y3 :=  30; l3 := 30; k3 := 1;

      a1 := sqr(x-x1) + sqr(y-y1);
      a2 := sqr(x-x2) + sqr(y-y2);
      a3 := sqr(x-x3) + sqr(y-y3);

      t1 := sqrt(a1 + sqr(z1));
      t2 := sqrt(a2 + sqr(z2));
      t3 := sqrt(a3 + sqr(z3));

      b1 := t2 * t3 * (t1-l1) * k1 *(x-x1 + y - y1);
      b2 := t1 * t3 * (t2-l2) * k2 *(x-x2 + y - y2);
      b3 := t1 * t2 * (t3-l3) * k3 *(x-x3 + y - y3);
      g7 := (b1 + b2 + b3);
    end;

    23:
    begin
      { 1995-3 }
      x1 := -2; y1 := -2; l1 := 0; k1 := 1;
      x2 :=  2; y2 := -2; l2 := 0; k2 := 1;
      x3 := -2; y3 :=  2; l3 := 0; k3 := 1;

      a1 := sqr(x-x1) + sqr(y-y1);
      a2 := sqr(x-x2) + sqr(y-y2);
      a3 := sqr(x-x3) + sqr(y-y3);

      t1 := sqrt(a1 + sqr(z1));
      t2 := sqrt(a2 + sqr(z2));
      t3 := sqrt(a3 + sqr(z3));

      b1 := t2 * t3 * (t1-l1) * k1 *(x-x1 + y - y1);
      b2 := t1 * t3 * (t2-l2) * k2 *(x-x2 + y - y2);
      b3 := t1 * t2 * (t3-l3) * k3 *(x-x3 + y - y3);
      g7 := (b1 + b2 + b3);
    end;

    else
    begin
      if SolutionMode then
      begin
        b1 := t2 * t3 * (t1-l1) * k1;
        b2 := t1 * t3 * (t2-l2) * k2;
        b3 := t1 * t2 * (t3-l3) * k3;

        u1 := b1 * (x - x1);
        u2 := b2 * (x - x2);
        u3 := b3 * (x - x3);

        v1 := b1 * (y - y1);
        v2 := b2 * (y - y2);
        v3 := b3 * (y - y3);

        u := (u1 + u2 + u3);
        v := (v1 + v2 + v3);
      end
      else
      begin
        if (t1 > Epsilon) and (t2 > Epsilon) and (t3 > Epsilon) then
        begin
          if ForceMode = 3 then
          begin
            f1 := Force(k1, t1, l1, m1);
            f2 := Force(k2, t2, l2, m2);
            f3 := Force(k3, t3, l3, m3);
          end
          else
          begin
            f1 := Kraft(k1, t1, l1);
            f2 := Kraft(k2, t2, l2);
            f3 := Kraft(k3, t3, l3);
          end;

          u1 := f1 * (x-x1) / t1;
          u2 := f2 * (x-x2) / t2;
          u3 := f3 * (x-x3) / t3;

          v1 := f1 * (y-y1) / t1;
          v2 := f2 * (y-y2) / t2;
          v3 := f3 * (y-y3) / t3;

          u := (u1 + u2 + u3) * 100000;
          v := (v1 + v2 + v3) * 100000;
        end
        else
        begin
          case Plot of
            11:
            begin
              u := k1 * l1 * 1.5 * 100000;
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
            g7 := (b1 + b2 + b3) * 20
          else
            g7 := (f1 + f2 + f3) * 100000;
        end;
        2: g7 := sqrt(sqr(u) + sqr(v)) + 5;
        3: g7 := u + v;
//      4: Betrag
        5: g7 := Abs(u + v);
//      6: Richtung;
        7: g7 := Abs(v);
//      8: Energie;
        9: g7 := u;
       10: g7 := Abs(u);
       11: g7 := Abs(u) + Abs(v);

       12:
       begin
         case PlotFigure of
           2: g7 := Diff1(1, x, y);
           3: g7 := Diff1(2, x, y);
           4: g7 := Diff1(3, x, y);
         else
           g7 := Diff1(0, x, y);
         end;
       end;

       13:
       begin
         case PlotFigure of
           2: g7 := Diff2(1, x, y);
           3: g7 := Diff2(2, x, y);
           4: g7 := Diff2(3, x, y);
         else
           g7 := Diff2(0, x, y) * 1000;
         end;
       end;
      end;

    end;
  end;

end;

function TFederEquation03.GetStatusLine: string;
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
    12: result := 'Diff1(0, x, y)';
    13: result := 'Diff2(0, x, y)';
  end;
end;

procedure TFederEquation03.InitMemo(ML: TStrings);
begin
  case SourceFormat of
    0: InitPascal(ML);
    1: InitMaxima(ML);
  end;
end;

function TFederEquation03.GetValue(x, y: single): single;
begin
  result := 0;
  if Plot > -1 then
  begin
    if WantDiff or WantDiffOnce then
      result := NumericDiff(x, y)
    else
      result := CalcValue(x, y, Figure);
  end;

  if result > MaxInt then
    result := MaxInt;
  if result < -MaxInt then
    result := -MaxInt;
end;

function TFederEquation03.NumericDiff(x, y: single): single;
begin
  case DiffMode of
    1: result := NumericDiff01(x, y);
    2: result := NumericDiff02(x, y);
    3: result := NumericDiff03(x, y);
    else
      result := NumericDiff03(x, y);
  end;
end;

function TFederEquation03.NumericDiff01(x, y: single): single;
var
  temp: single;
begin
  d := 0.01;
  d1 := CalcValue(x - d, y, Figure);
  d2 := CalcValue(x + d, y, Figure);
  d3 := CalcValue(x, y - d, Figure);
  d4 := CalcValue(x, y + d, Figure);
  fx := (d2 - d1) / (2 * d);
  fy := (d4 - d3) / (2 * d);
  temp := (fx + fy);
  result := temp * 8;
end;

function TFederEquation03.NumericDiff02(x, y: single): single;
var
  temp: single;
begin
  d := 0.01;
  d1 := CalcValue(x - d, y, Figure);
  d2 := CalcValue(x + d, y, Figure);
  d3 := CalcValue(x, y - d, Figure);
  d4 := CalcValue(x, y + d, Figure);
  fx := (d2 - d1) / (2 * d);
  fy := (d4 - d3) / (2 * d);
  temp := sqr(fx) + sqr(fy);
  temp := sqrt(temp);

  result := temp * 8;
end;

function TFederEquation03.NumericDiff03(x, y: single): single;
var
  temp: single;
begin
  d := 0.01;
  d1 := CalcValue(x - d, y, Figure);
  d2 := CalcValue(x + d, y, Figure);
  d3 := CalcValue(x, y - d, Figure);
  d4 := CalcValue(x, y + d, Figure);
  fx := (d2 - d1) / (2 * d);
  fy := (d4 - d3) / (2 * d);
  temp := sqr(fx) + sqr(fy);
  temp := sqrt(temp);
  result := temp * 8;
end;

(*
gegeben
Function f = f(x, y)
Punkt P = (x1, y1, z1);

{ Tangentialebene allgemein }
z = a * (x-x1) + b * (y-y1) + z1
mit
y := -a/b * x; //Schnittgerade g von Tangentialebene mit Ebene z=0, Winkel beta
m1 := -a/b; //Richtung von g, TPoint3D v = (-a, b);
m2 := b/a; //Richtung der maximalen Steigung, senkrecht zu g, TPoint3D u = (a,b)
//Note:
m1 * m2 := -1; //Vektoren sind orthogonal

{ Tangentialebene an f }
mit fx = a, partielle Ableitung nach x
mit fy = b, partielle Ableitung nach y
z = fx * (x-x1) + fy * (y-y1) + z1;

{ beliebiger Anstiegswinkel }
mit dx = deltaX, dy = deltaY, dz = deltaZ

dz = fx * dx + fy * dy

{ maximaler Anstiegewinkel = Betrag des Gradienten }
mit alpha, der Steigung der Richtungsgeraden des stärksten Anstiegs = Betrag der Gradienten.
temp = sqr(fx) + sqr(fy);
Betrag(u) = sqrt(temp)

alpha = arctan ( dz / Betrag(u) )
alpha = arctan ( temp / sqrt(temp)) )
alpha = arctan ( Betrag(u) ) );

temp / sqrt(temp) = sqrt(temp)
//Simplification after multimpying with sqrt(temp)

*)

function TFederEquation03.CalcRaw(x, y: single): single;
begin
  if fcap < 1 then
    fcap := 1;
  f03(x, y);
  result := g7;
end;

function TFederEquation03.CalcValue(x, y: single; af: Integer): single;
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

function TFederEquation03.ProbeM(x, y: single): Boolean;
var
  fu: single;
  fv: single; //resultierende Kraft mit Vorzeichen (Zug/Druck)
  mo1, mo2, mo3: single; //Momente
  mos: single; //summe der Momente (1-3) um Nullpunkt
  alpha: single;
  mor1, mor2: single;
  temp: Boolean;
begin
  mo1 := v1 * x1 - u1 * y1;
  mo2 := v2 * x2 - u2 * y2;
  mo3 := v3 * x3 - u3 * y3;

  mos := mo1 + mo2 + mo3;
  mor1 := v * x - u * y;
  temp := Abs(mos - mor1) < 0.1;
  Assert(temp);

  if (u > Epsilon) then
  begin
    alpha := arctan(v/u);

    fu := bf * cos(alpha);
    temp := Abs(u - fu) < 0.1;
    Assert(temp);

    fv := bf * sin(alpha);
    temp := Abs(v - fv) < 0.1;
    Assert(temp);

    mor2 := fv * x - fu * y;
    temp := Abs(mor1 - mor2) < 0.1;
    Assert(temp);
  end;

  result := temp;
end;

procedure TFederEquation03.BerechneWinkel(x, y: single);
begin
  { Betrag Kraft in Feder}
//  f1 := k1 * (t1 - l1);
//  f2 := k2 * (t2 - l2);
//  f3 := k3 * (t3 - l3);
  if ForceMode = 3 then
  begin
    f1 := Force(k1, t1, l1, m1);
    f2 := Force(k2, t2, l2, m2);
    f3 := Force(k3, t3, l3, m3);
  end
  else
  begin
    f1 := Kraft(k1, t1, l1);
    f2 := Kraft(k2, t2, l2);
    f3 := Kraft(k3, t3, l3);
  end;

  { gemeinsamer Punkt }
  _vp := TPoint3D.Create(x, y, 0);

  { TPoint3D in Richtung der Feder }
  _v1 := _vp - TPoint3D.Create(x1, y1, 0);
  _v2 := _vp - TPoint3D.Create(x2, y2, 0);
  _v3 := _vp - TPoint3D.Create(x3, y3, 0);

  { normalisierte Kraft in Richtung Feder mit Betrag 1 }
  _n1 := _v1.Normalize;
  _n2 := _v2.Normalize;
  _n3 := _v3.Normalize;

  { betragsrichtige Kraft in Feder }
  _f1 := _n1 * f1;
  _f2 := _n2 * f2;
  _f3 := _n3 * f3;

  { resultierende Kraft }
  _f0 := _f1 + _f2;
  _f0 := _f0 + _f3;

  { Cosinus und Sinus von F}
  cf := _f0.AngleCosine(TPoint3D.Create(1, 0, 1));
  sf := _f0.AngleCosine(TPoint3D.Create(0, 1, 1));

  case PlotFigure of
    1: g7 := cf * 200 * FaktorEQ;
    2: g7 := Abs(cf) * 200 * FaktorEQ;
    3: g7 := Abs(sf) * 200 * FaktorEQ;
    4: g7 := sf * 200 * FaktorEQ;
  end;

end;

procedure TFederEquation03.InitKoord;
begin
  FaktorG3 := 500.0;
  FaktorEQ := 100 * 1000;
  MaxPlotFigure := 4;

  x1 := -30; y1 :=  0; l1 := 30; k1 := 1;
  x2 :=  30; y2 :=  0; l2 := 30; k2 := 1;
  x3 :=   0; y3 := 10; l3 := 30; k3 := 1;
end;

procedure TFederEquation03.CalcBF(x, y: single);
begin
  a1 := sqr(x-x1) + sqr(y-y1);
  a2 := sqr(x-x2) + sqr(y-y2);
  a3 := sqr(x-x3) + sqr(y-y3);

  t1 := sqrt(a1);
  t2 := sqrt(a2);
  t3 := sqrt(a3);

  if (t1 > Epsilon) and (t2 > Epsilon) and (t3 > Epsilon) then
  begin
    if ForceMode = 3 then
    begin
      f1 := Force(k1, t1, l1, m1);
      f2 := Force(k2, t2, l2, m2);
      f3 := Force(k3, t3, l3, m3);
    end
    else
    begin
      f1 := Kraft(k1, t1, l1);
      f2 := Kraft(k2, t2, l2);
      f3 := Kraft(k3, t3, l3);
    end;
  end;
end;

procedure TFederEquation03.InitPascal(ML: TStrings);
begin
  ML.Add('a1 := sqr(x-x1) + sqr(y-y1);');
  ML.Add('a2 := sqr(x-x2) + sqr(y-y2);');
  ML.Add('a3 := sqr(x-x3) + sqr(y-y3);');
  ML.Add('t1 := sqrt(a1);');
  ML.Add('t2 := sqrt(a2);');
  ML.Add('t3 := sqrt(a3);');
  case Plot of
    4:
    begin
      ML.Add('f1 := k1 * (t1-l1);');
      ML.Add('f2 := k2 * (t2-l2);');
      ML.Add('f3 := k3 * (t3-l3);');
      ML.Add('');
      ML.Add('u1 := f1 * (x-x1) / t1;');
      ML.Add('u2 := f2 * (x-x2) / t2;');
      ML.Add('u3 := f3 * (x-x3) / t3;');
      ML.Add('');
      ML.Add('v1 := f1 * (y-y1) / t1;');
      ML.Add('v2 := f2 * (y-y2) / t2;');
      ML.Add('v3 := f3 * (y-y3) / t3;');
      ML.Add('');
      ML.Add('u := u1 + u2 + u3;');
      ML.Add('v := v1 + v2 + v3;');
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
      ML.Add('g7 := b1 + b2 + b3');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1 := t2 * t3 * (t1-l1) * k1;');
        ML.Add('b2 := t1 * t3 * (t2-l2) * k2;');
        ML.Add('b3 := t1 * t2 * (t3-l3) * k3;');
        ML.Add('');
        ML.Add('u1 := b1 * (x-x1);');
        ML.Add('u2 := b2 * (x-x2);');
        ML.Add('u3 := b3 * (x-x3);');
        ML.Add('');
        ML.Add('v1 := b1 * (y-y1);');
        ML.Add('v2 := b2 * (y-y2);');
        ML.Add('v3 := b3 * (y-y3);');
        ML.Add('');
        ML.Add('u := u1 + u2 + u3;');
        ML.Add('v := v1 + v2 + v3;');
      end
      else
      begin
        ML.Add('f1 := k1 * (t1-l1);');
        ML.Add('f2 := k2 * (t2-l2);');
        ML.Add('f3 := k3 * (t3-l3);');
        ML.Add('');
        ML.Add('u1 := f1 * (x-x1) / t1;');
        ML.Add('u2 := f2 * (x-x2) / t2;');
        ML.Add('u3 := f3 * (x-x3) / t3;');
        ML.Add('');
        ML.Add('v1 := f1 * (y-y1) / t1;');
        ML.Add('v2 := f2 * (y-y2) / t2;');
        ML.Add('v3 := f3 * (y-y3) / t3;');
        ML.Add('');
        ML.Add('u := u1 + u2 + u3;');
        ML.Add('v := v1 + v2 + v3;');
      end;
    end;
  end;
end;

procedure TFederEquation03.InitMaxima(ML: TStrings);
begin
  if (Plot = 6) or (Plot = 22) or (Plot = 23)  then
  begin
    ML.Add(SampleInfo);
    ML.Add('');
    if Plot = 6 then
    begin
      ML.Add('x1: -40$ y1: -30$ z1: 0$ l1: 30$ k1: 1$');
      ML.Add('x2:  40$ y2: -30$ z2: 0$ l2: 30$ k2: 1$');
      ML.Add('x3:   0$ y3:  30$ z3: 0$ l3: 30$ k3: 1$');
    end
    else if Plot = 22 then
    begin
      ML.Add('x1: -40$ y1: -30$ z1: 0$ l1: 30$ k1: 1$');
      ML.Add('x2:  40$ y2: -30$ z2: 0$ l2: 30$ k2: 1$');
      ML.Add('x3:   0$ y3:  30$ z3: 0$ l3: 30$ k3: 1$');
    end
    else
    begin
      ML.Add('x1: -2$ y1: -2$ z1: 0$ l1: 0$ k1: 1$');
      ML.Add('x2:  2$ y2: -2$ z2: 0$ l2: 0$ k2: 1$');
      ML.Add('x3: -2$ y3:  2$ z3: 0$ l3: 0$ k3: 1$');
    end;
    ML.Add('');
    ML.Add('a1: (x-x1)^2 + (y-y1)^2$');
    ML.Add('a2: (x-x2)^2 + (y-y2)^2$');
    ML.Add('a3: (x-x3)^2 + (y-y3)^2$');
    ML.Add('');
    ML.Add('t1: sqrt(a1 + (z1)^2)$');
    ML.Add('t2: sqrt(a2 + (z2)^2)$');
    ML.Add('t3: sqrt(a3 + (z3)^2)$');
    ML.Add('');
    ML.Add('b1: t2 * t3 * (t1-l1) * k1 *(x-x1 + y - y1)$');
    ML.Add('b2: t1 * t3 * (t2-l2) * k2 *(x-x2 + y - y2)$');
    ML.Add('b3: t1 * t2 * (t3-l3) * k3 *(x-x3 + y - y3)$');
    ML.Add('g7: (b1 + b2 + b3)$');
    ML.Add('');
    if OffsetZ = 0 then
      ML.Add(Format('f: g7 / %.2f$', [fcap]))
    else
      ML.Add(Format('f: g7 / %.2f - %d$', [fcap, OffsetZ]));
    ML.Add('');
    ML.Add(Format('plot3d(f, [x,%.2f,%.2f], [y,%.2f,%.2f], [z,-100,100], [plot_format,xmaxima]);',
    [rmin, rmax, rmin, rmax]));

    Exit;
  end;

  ML.Add(SampleInfo);
  ML.Add('');
  ML.Add('a1: (x-x1)^2 + (y-y1)^2$');
  ML.Add('a2: (x-x2)^2 + (y-y2)^2$');
  ML.Add('a3: (x-x3)^2 + (y-y3)^2$');
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

  ML.Add('');
  case Plot of
    4:
    begin
      ML.Add('f1: k1 * (t1-l1)$');
      ML.Add('f2: k2 * (t2-l2)$');
      ML.Add('f3: k3 * (t3-l3)$');
      ML.Add('');
      ML.Add('u1: f1 * (x-x1) / t1$');
      ML.Add('u2: f2 * (x-x2) / t2$');
      ML.Add('u3: f3 * (x-x3) / t3$');
      ML.Add('');
      ML.Add('v1: f1 * (y-y1) / t1$');
      ML.Add('v2: f2 * (y-y2) / t2$');
      ML.Add('v3: f3 * (y-y3) / t3$');
      ML.Add('');
      ML.Add('u: u1 + u2 + u3$');
      ML.Add('v: v1 + v2 + v3$');
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
      ML.Add('g7: (b1 + b2 + b3) * 5000$');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1: t2 * t3 * (t1-l1) * k1$');
        ML.Add('b2: t1 * t3 * (t2-l2) * k2$');
        ML.Add('b3: t1 * t2 * (t3-l3) * k3$');
        ML.Add('');
        ML.Add('u1: b1 * (x-x1)$');
        ML.Add('u2: b2 * (x-x2)$');
        ML.Add('u3: b3 * (x-x3)$');
        ML.Add('');
        ML.Add('v1: b1 * (y-y1)$');
        ML.Add('v2: b2 * (y-y2)$');
        ML.Add('v3: b3 * (y-y3)$');
        ML.Add('');
        ML.Add('u: u1 + u2 + u3$');
        ML.Add('v: v1 + v2 + v3$');
        ML.Add('');
      end
      else
      begin
        ML.Add('f1: k1 * (t1-l1)$');
        ML.Add('f2: k2 * (t2-l2)$');
        ML.Add('f3: k3 * (t3-l3)$');
        ML.Add('');
        ML.Add('u1: f1 * (x-x1) / t1$');
        ML.Add('u2: f2 * (x-x2) / t2$');
        ML.Add('u3: f3 * (x-x3) / t3$');
        ML.Add('');
        ML.Add('v1: f1 * (y-y1) / t1$');
        ML.Add('v2: f2 * (y-y2) / t2$');
        ML.Add('v3: f3 * (y-y3) / t3$');
        ML.Add('');
        ML.Add('u: u1 + u2 + u3$');
        ML.Add('v: v1 + v2 + v3$');
        ML.Add('');
      end;
      case Plot of
        0: ML.Add('g7: v$');
        1:
        begin
          if SolutionMode then
            ML.Add('g7: (b1 + b2 + b3) * 20$')
          else
            ML.Add('g7: (f1 + f2 + f3) * 100000$');
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

        12:
        begin
          if SolutionMode then
            ML.Add('g7: diff(u1, x, 1, y, 1)$')
          else
            ML.Add('g7: diff(f1, x, 1, y, 1)$');
        end;
        13:
        begin
          if SolutionMode then
            ML.Add('g7: diff(u1, x, 2, y, 2) * 10$')
          else
            ML.Add('g7: diff(f1, x, 2, y, 2) * 10$')
        end;
      end;
    end;
  end;
  ML.Add('');
  if OffsetZ = 0 then
    ML.Add(Format('f: g7 / %.2f$', [fcap]))
  else
    ML.Add(Format('f: g7 / %.2f - %d$', [fcap, OffsetZ]));
  ML.Add('');
  ML.Add(Format('x1: %.2f$ x2: %.2f$ x3: %.2f$', [x1, x2, x3]));
  ML.Add(Format('y1: %.2f$ y2: %.2f$ y3: %.2f$', [y1, y2, y3]));
  ML.Add(Format('z1: %.2f$ z2: %.2f$ z3: %.2f$', [z1, z2, z3]));
  ML.Add(Format('l1: %.2f$ l2: %.2f$ l3: %.2f$', [l1, l2, l3]));
  ML.Add(Format('k1: %.2f$ k2: %.2f$ k3: %.2f$', [k1, k2, k3]));
  ML.Add('');
  ML.Add(Format('plot3d(f, [x,%.2f,%.2f], [y,%.2f,%.2f], [z,-100,100], [plot_format,xmaxima]);',
  [rmin, rmax, rmin, rmax]));
end;

end.
