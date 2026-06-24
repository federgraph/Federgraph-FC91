unit RiggVar.EQ.Equation01;

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
  System.Types,
  RiggVar.FB.Equation;

type
  TFederEquation01 = class(TFederEquation)
  private
    u1: single;
    v1: single;
    u, v: single;

    bf: single;
    f: single; // resultierende Kraft mit Vorzeichen (Zug/Druck)
    cf, sf: single;

    g7: single;
    function f01(x, y: single): single;
    procedure f03(x, y: single);
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

constructor TFederEquation01.Create(AModelID: Integer);
begin
  inherited Create(AModelID);
  FSpringCount := 1;
end;

procedure TFederEquation01.f03(x, y : single);
begin
  a1 := sqr(x-x1) + sqr(y-y1);
  t1 := sqrt(a1 + sqr(z1));

  g7 := 0;
  case Plot of
    4:
    begin
      { Betrag }
      if Vorzeichen then
      begin
        f := k1 * (t1 - l1);
        g7 := f * FaktorEQ;
      end
      else if t1 > Epsilon then
      begin
        f1 := Kraft(k1, t1, l1);
        u1 := f1 * (x-x1) / t1;
        v1 := f1 * (y-y1) / t1;
        bf := sqrt(sqr(u1) + sqr(v1));
        g7 := bf * FaktorEQ;
      end
      else
      begin
        u := abs(k1 * l1);
        g7 := u * FaktorEQ;
      end;
    end;

    6:
    begin
      { Richtung }
      if t1 > Epsilon then
      begin
        case PlotFigure of
          1:
          begin
            cf := (x-x1) / t1;
            g7 := cf * FaktorEQ;
          end;
          2:
          begin
            sf := (y-y1) / t1;
            g7 := sf * FaktorEQ;
          end;
        end;
      end;
    end;

    8:
    begin
      { Energie }
      b1 := k1 * sqr(t1 - l1) / 2;
      g7 := b1 * FaktorEQ;
    end;

    else
    begin
      if SolutionMode then
      begin
        b1 := k1 * (t1 - l1);
        u1 := b1 * (x - x1);
        v1 := b1 * (y - y1);
        u := u1;
        v := v1;
      end
      else
      begin
        if (t1 > Epsilon) then
        begin
          f1 := Kraft(k1, t1, l1);
          u1 := f1 * (x-x1) / t1;
          v1 := f1 * (y-y1) / t1;
          u := u1 * FaktorEQ;
          v := v1 * FaktorEQ;
        end
        else
        begin
          case Plot of
            11:
            begin
              u := k1 * l1 * 5;
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
            g7 := b1 * FaktorEQ
          else
            g7 := f1 * FaktorEQ;
        end;
        2: g7 := sqrt(sqr(u) + sqr(v));
        3: g7 := u + v;
        //4: Betrag
        5: g7 := Abs(u + v);
        //6: Richtung
        7: g7 := Abs(v);
        //8: Energie
        9: g7 := u;
       10: g7 := Abs(u);
       11: g7 := Abs(u) + Abs(v);
       12: g7 := Diff1(0, x, y);
       13: g7 := Diff2(0, x, y) * 1000;
      end;

    end;
  end;

end;

function TFederEquation01.GetStatusLine: string;
begin
  case Plot of
    0: result := 'v';
    1:
    begin
      if SolutionMode then
        result := 'b1'
      else
        result := 'f1';
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

procedure TFederEquation01.InitMemo(ML: TStrings);
begin
  case SourceFormat of
    0: InitPascal(ML);
    1: InitMaxima(ML);
  end;
end;

function TFederEquation01.GetValue(x, y: single): single;
begin
  result := 0;
  if Plot = 99 then
    result := f01(x, y)
  else if Plot > -1 then
  begin
    if WantDiff or WantDiffOnce then
    begin
      d := 0.01;
      d1 := CalcValue(x - d, y, Figure);
      d2 := CalcValue(x + d, y, Figure);
      d3 := CalcValue(x, y - d, Figure);
      d4 := CalcValue(x, y + d, Figure);
      result := ((d2 - d1) + (d4 - d3)) / d * 10;
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

function TFederEquation01.CalcRaw(x, y: single): single;
begin
  if fcap < 1 then
    fcap := 1;
  f03(x, y);
  result := g7;
end;

function TFederEquation01.CalcValue(x, y: single; af: Integer): single;
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

function TFederEquation01.f01(x, y : single): single;
begin
  a1 := x*x + y*y + 4*x + 4*y + 8;
  a2 := x*x + y*y - 4*x + 4*y + 8;
  a3 := x*x + y*y       - 4*y + 4;
  a4 :=             3*x + 3*y + 2;

  result := a1 * a2 * a3 * a4 * a4 / 2000;
  pcap := 1000;
  mcap := -1000;

  if result > pcap then
    result := pcap;
  if result < mcap then
    result := mcap;
end;

procedure TFederEquation01.InitKoord;
begin
  FaktorG3 := 0.005;
  FaktorEQ := 10;
  MaxPlotFigure := 2;

  x1 := -30; y1 := 0; l1 := 30; k1 := 1;
  x2 :=  30; y2 := 0; l2 := 30; k2 := 1;
  x3 :=   0; y3 := 10; l3 := 30; k3 := 1;
end;

procedure TFederEquation01.InitPascal(ML: TStrings);
begin
  ML.Add('a1 := sqr(x-x1) + sqr(y-y1);');
  ML.Add('t1 := sqrt(a1);');
  case Plot of
    4:
    begin
      ML.Add('u1 := k1 * (t1-l1) * (x-x1) / t1;');
      ML.Add('v1 := k1 * (t1-l1) * (y-y1) / t1;');
      ML.Add('u := u1 + u2;');
      ML.Add('v := v1 + v2;');
      ML.Add('g7 := sqrt(u) + sqr(v));');
    end;
    6:
    begin
      ML.Add(StrBerechneWinkel + '(x, y);');
    end;
    8:
    begin
      ML.Add('b1 := k1 * sqrt(t1-l1) / 2;');
      ML.Add('g7 := b1;');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1 := (t1-l1) * k1;');
        ML.Add('u1 := b1 * (x-x1);');
        ML.Add('v1 := b1 * (y-y1);');
        ML.Add('u := u1;');
        ML.Add('v := v1;');
      end
      else
      begin
        ML.Add('f1 := ' + StrKraft + '(k1, t1, l1);');
        ML.Add('u1 := f1 * (x-x1) / t1;');
        ML.Add('v1 := f1 * (y-y1) / t1;');
        ML.Add('u := u1;');
        ML.Add('v := v1;');
      end;
    end;
  end;
end;

procedure TFederEquation01.InitMaxima(ML: TStrings);
begin
  ML.Add(SampleInfo);
  ML.Add('');
  ML.Add('a1: (x-x1)^2 + (y-y1)^2$');
  ML.Add('');

  if z1 = 0 then
    ML.Add('t1: sqrt(a1)$')
  else
    ML.Add('t1: sqrt(a1 + z1^2)$');

  ML.Add('');
  case Plot of
    4:
    begin
      if Vorzeichen then
      begin
        ML.Add('f: k1 * (t1 - l1)$');
        ML.Add('g7: f * 10$');
      end
      else
      begin
        ML.Add('f1: k1 * (t1-l1)$');
        ML.Add('u1: f1 * (x-x1) / t1$');
        ML.Add('v1: f1 * (y-y1) / t1$');
        ML.Add('bf: sqrt(u1^2 + v1^2)$');
        ML.Add('g7: bf * 10$');
      end;
    end;
//    6:
//    begin
//      ML.Add(StrBerechneWinkel + '(x, y);');
//    end;
    8:
    begin
      ML.Add('b1: k1 * (t1-l1)^2 / 2$');
      ML.Add('g7: b1 * 10$');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1: k1 * (t1-l1)$');
        ML.Add('u: b1 * (x-x1)$');
        ML.Add('v: b1 * (y-y1)$');
        ML.Add('');
      end
      else
      begin
        ML.Add('f1: k1 * (t1-l1)$');
        ML.Add('u1: f1 * (x-x1) / t1$');
        ML.Add('v1: f1 * (y-y1) / t1$');
        ML.Add('u: u1 * 10$');
        ML.Add('v: v1 * 10$');
        ML.Add('');
      end;
      case Plot of
        0: ML.Add('g7: v$');
        1:
        begin
          if SolutionMode then
            ML.Add('g7: b1 * 10$')
          else
            ML.Add('g7: f1 * 10$');
        end;
        2: ML.Add('g7: sqrt(u^2 + v^2) * 1$');
        3: ML.Add('g7: u + v$');
//      4: Betrag
        5: ML.Add('g7: abs(u + v)$');
//      6: Richtung;
        7: ML.Add('g7: abs(v)$');
//      8: Energie;
        9: ML.Add('g7: u$');
       10: ML.Add('g7: abs(u)$');
       11: ML.Add('g7: abs(u) + abs(v)$');

       12: ML.Add('g7: diff(f1, x, 1, y, 1)$');
       13: ML.Add('g7: diff(f1, x, 2, y, 2) * 1000$');
      end;
    end;
  end;
  ML.Add('');
  if OffsetZ = 0 then
    ML.Add(Format('f: g7 / %.2f$', [fcap]))
  else
    ML.Add(Format('f: g7 / %.2f - %d$', [fcap, OffsetZ]));
  ML.Add('');
  ML.Add(Format('x1: %.2f$', [x1]));
  ML.Add(Format('y1: %.2f$', [y1]));
  ML.Add(Format('z1: %.2f$', [z1]));
  ML.Add(Format('l1: %.2f$', [l1]));
  ML.Add(Format('k1: %.2f$', [k1]));
  ML.Add('');
  ML.Add(Format('plot3d(f, [x,%.2f,%.2f], [y,%.2f,%.2f], [z,-100,100], [plot_format,xmaxima]);',
  [rmin, rmax, rmin, rmax]));
end;

end.
