unit RiggVar.EQ.Equation0N;

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
  TFederEquation0N = class(TFederEquation)
  private
    oz: single;

    N: Integer;

    an: single;
    bn: single;
    tn: single;

    xn, yn: single;

    u1: single;
    v1: single;
    u, v: single;

    bf, cf, sf: single;

    _vp, _vn: TPoint3D;
    _f0, _fn: TPoint3D;
    _nn : TPoint3D;

    phi: single;

    g7: single;
    procedure BerechneWinkel(x, y: single);
    procedure f03(x, y: single);
    function GetXN(i: Integer): single;
    function GetYN(i: Integer): single;
  protected
    procedure InitPascal(ML: TStrings);
    procedure InitMaxima(ML: TStrings);
  public
    procedure InitKoord; override;
    procedure InitMemo(ML: TStrings); override;
    function GetValue(x, y : single): single; override;
    function CalcValue(x, y : single; af: Integer): single; override;
    function GetStatusLine: string; override;
  end;

implementation

procedure TFederEquation0N.f03(x, y : single);
var
  i: Integer;
begin
  oz := OffsetZ;

  g7 := 0;
  case Plot of

    4:
    begin
      { Betrag }
      u := 0;
      v := 0;
      for i := 1 to N do
      begin
        xn := GetXN(i);
        yn := GetYN(i);
        an := sqr(x-xn) + sqr(y-yn);
        tn := sqrt(an);
        if (tn > Epsilon) then
        begin
          //f1 := k1 * (tn - l1);
          f1 := Kraft(k1, tn, l1);

          u1 := f1 * (x-xn) / tn;
          v1 := f1 * (y-yn) / tn;
          u := u + u1;
          v := v + v1;
        end
        else
        begin
          u := k1 * l1/ 2;
          v := u;
        end;
      end;
      bf := sqrt(sqr(u) + sqr(v));
      g7 := bf * FaktorEQ;
    end;

    6:
    begin
      { Richtung }
      BerechneWinkel(x, y);
    end;

    8:
    begin
      { Energie }
      v := 0;
      for i := 1 to N do
      begin
        xn := GetXN(i);
        yn := GetYN(i);
        an := sqr(x-xn) + sqr(y-yn);
        tn := sqrt(an);
        bn := k1 * sqr(tn - l1) / 2;
        v := v + bn;
      end;
      g7 := v * FaktorEQ / 5;
      oz := (0.6 * FaktorEQ / 5) + OffsetZ;
    end;

    else
    begin
      u := 0;
      v := 0;
      for i := 1 to N do
      begin
        xn := GetXN(i);
        yn := GetYN(i);
        an := sqr(x-xn) + sqr(y-yn);
        tn := sqrt(an);
        if (tn > Epsilon) then
        begin
          //f1 := k1 * (tn - l1);
          f1 := Kraft(k1, tn, l1);
          u1 := f1 * (x-xn) / tn;
          v1 := f1 * (y-yn) / tn;
          u := u + u1;
          v := v + v1;
        end
        else
        begin
          case Plot of
            11:
            begin
              u := k1 * l1/ 2 * N;
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
        1: g7 := Abs(u);
        2: g7 := Abs(u + v);
        3: g7 := u + v;
//      4: Betrag
        5: g7 := Abs(u + v);
//      6: Richtung;
        7: g7 := Abs(v);
//      8: Energie;
        9: g7 := u;
       10: g7 := Abs(u);
       11: g7 := Abs(u) + Abs(v);
       12: g7 := 0;
       13: g7 := 0;
      end;
      g7 := g7 * FaktorEQ;
    end;
  end;

end;

function TFederEquation0N.GetStatusLine: string;
begin
  case Plot of
    0: result := 'v';
    1: result := '0';
    2: result := '0';
    3: result := 'u + v';
    4: result := StrBetrag;
    5: result := 'abs(u + v)';
    6: result := StrRichtung;
    7: result := 'abs(v)';
    8: result := StrEnergie;
    9: result := 'u';
    10: result := 'abs(u)';
    11: result := 'abs(u) + abs(v)';
  end;
end;

procedure TFederEquation0N.InitMemo(ML: TStrings);
begin
  case SourceFormat of
    0: InitPascal(ML);
    1: InitMaxima(ML);
  end;
end;

function TFederEquation0N.GetValue(x, y: single): single;
begin
  result := 0;
  if (Plot > -1) and (Dim > 0) then
  begin
    N := Dim;
    phi := 2 * PI / N;

    if WantDiff or WantDiffOnce then
    begin
      d := 0.01;
      d1 := CalcValue(x - d, y, Figure);
      d2 := CalcValue(x + d, y, Figure);
      d3 := CalcValue(x, y - d, Figure);
      d4 := CalcValue(x, y + d, Figure);
      result := ((d2 - d1) + (d4 - d3)) / (2 * d);
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

function TFederEquation0N.GetXN(i: Integer): single;
begin
  result := x1 * cos(i * phi);
end;

function TFederEquation0N.GetYN(i: Integer): single;
begin
  result := y1 * sin(i * phi);
end;

function TFederEquation0N.CalcValue(x, y: single; af: Integer): single;
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

procedure TFederEquation0N.BerechneWinkel(x, y: single);
var
  i: Integer;
begin
  _f0 := TPoint3D.Create(0, 0, 1);
  for i := 1 to N do
  begin
    xn := GetXN(i);
    yn := GetYN(i);
    an := sqr(x-xn) + sqr(y-yn);
    tn := sqrt(an);

    { Betrag Kraft in Feder}
    bn := k1 * (tn - l1);
    { gemeinsamer Punkt }
    _vp := TPoint3D.Create(x, y, 0);
    { TPoint3D in Richtung der Feder }
    _vn := _vp - TPoint3D.Create(xn, yn, 0);
    { normalisierte Kraft in Richtung Feder mit Betrag 1 }
    _nn := _vn.Normalize;
    { betragsrichtige Kraft in Feder }
    _fn := _nn * bn;
    { resultierende Kraft }
    _f0 := _f0 + _fn;
  end;

  { Betrag }
  bf := _f0.Length;
  { Cosinus}
  cf := _f0.AngleCosine(TPoint3D.Create(1, 0, 1));
  { Sinus}
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

procedure TFederEquation0N.InitKoord;
begin
  FaktorG3 := 1.0;
  FaktorEQ := 800;
  MaxPlotFigure := 4;
  x1 := 50; y1 := 50; l1 := 30; k1 := 1;
end;

procedure TFederEquation0N.InitPascal(ML: TStrings);
begin
  ML.Add('an := sqr(x-xn) + sqr(y-yn);');
  ML.Add('tn := sqrt(an);');
  case Plot of
    8:
    begin
      ML.Add('bn := k * sqrt(tn-l) / 2;');
      ML.Add('g7 := Summe(b');
    end;
    4:
    begin
      ML.Add('un := k * (tn-l) * (x-xn) / tn;');
      ML.Add('vn := k * (tn-l) * (y-yn) / tn;');
      ML.Add('u := Summe(u);');
      ML.Add('v := Summe(v);');
      ML.Add('g7 := sqrt(sqr(u) + sqr(v));');
    end
    else
    begin
      ML.Add('');
    end;
  end;
end;

procedure TFederEquation0N.InitMaxima(ML: TStrings);
var
  i, n: Integer;
  s: string;
begin
  ML.Add(SampleInfo);

  n := Dim;
  for i := 1 to n do
    ML.Add(Format('a%d: sqr(x-x%d) + sqr(y-y%d)$', [i, i, i]));

  ML.Add('');
  for i := 1 to n do
    ML.Add(Format('t%d: sqrt(a%d)$', [i, i]));

  case Plot of
    8:
    begin
      ML.Add('');
      for i := 1 to n do
        ML.Add(Format('b%d: k * sqrt(t%d-l) / 2$', [i, i]));

      ML.Add('');
      ML.Add('/* Sum(b) */');
      s := 'g7: b1';
      for i := 2 to n do
        s := s + Format(' + b%d', [i]);
      ML.Add(s + '$');
    end;

    4:
    begin
      ML.Add('');
      for i := 1 to n do
        ML.Add(Format('u%d := k * (t%d-l) * (x-x%d) / t%d$', [i, i, i, i]));

      ML.Add('');
      for i := 1 to n do
        ML.Add(Format('v%d := k * (t%d-l) * (y-y%d) / t%d$', [i, i, i, i]));

      ML.Add('');
      ML.Add('/* Sum(u) */');
      s := 'u: u1';
      for i := 2 to n do
        s := s + Format(' + u%d', [i]);
      ML.Add(s + '$');

      ML.Add('');
      s := 'v: v1';
      ML.Add('/* Sum(v) */');
      for i := 2 to n do
        s := s + Format(' + v%d', [i]);
      ML.Add(s + '$');

      ML.Add('');
      ML.Add('g7: sqrt(u^2 + v^2)$');
    end
    else
    begin
      ML.Add('');
    end;
  end;
end;

end.
