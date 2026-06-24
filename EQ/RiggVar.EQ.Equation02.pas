unit RiggVar.EQ.Equation02;

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
  TFederEquation02 = class(TFederEquation)
  private
    c1, c2: single;
    s1, s2: single;
    u1, u2: single;
    v1, v2: single;
    u, v: single;

    f, bf: single;
    cf, sf: single;
    df: single;

    _vp: TPoint3D;
    _v1, _v2, _v3: TPoint3D;
    _f0, _f1, _f2: TPoint3D;
    _n1, _n2: TPoint3D;

    vz: Integer;
    g7: single;

    WantSignY: Boolean;
    WantSignX: Boolean;
    WantSignF: Boolean;
    WantFactorF: Boolean;
    WantFactorBF: Boolean;
    WantRemoveJitterX: Boolean;
    WantRemoveJitterY: Boolean;
    WantRemoveJitterC: Boolean;
    WantSwap: Boolean;
    AngleVector: Integer;

    procedure f03(x, y: single);
    procedure InitCase;
  protected
    procedure InitPascal(ML: TStrings);
    procedure InitMaxima(ML: TStrings);
    procedure BerechneVorzeichen1(x, y: single);
    procedure BerechneVorzeichen2(x, y: single);
    procedure BerechneVorzeichen3(x, y: single);
    procedure BerechneVorzeichen4(x, y: single);
    procedure BerechneVorzeichen5(x, y: single);
    procedure BerechneWinkel(x, y: single);
    function Probe1(x, y: single): Boolean;
    function Probe2(x, y: single): Boolean;
    procedure Test(x, y: single);
    procedure HokusPokus(x, y: single);
    function BerechneBaseX(x, y: single): Boolean;
    function CheckEqual(value1, value2: single): Boolean;
    procedure AssertEqual(value1, value2: single);
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

constructor TFederEquation02.Create;
begin
  inherited Create(AModelID);
  FSpringCount := 2;
end;

function TFederEquation02.CheckEqual(value1, value2: single): Boolean;
begin
  result := Abs(value1 - value2) < 0.1;
  if not result then
  begin
    HasError := True;
    Inc(ErrorCounter);
  end;
end;

procedure TFederEquation02.AssertEqual(value1, value2: single);
begin
  if not (CompareValue(value1, value2, 0.1) = 0) then
  begin
    if Abs(value1 - value2) > 0.1 then
    begin
      HasError := True;
      Inc(ErrorCounter);
    end;
  end;
  //Assert(CompareValue(value1, value2, 0.1) = 0);
end;

procedure TFederEquation02.f03(x, y : single);
begin
  a1 := sqr(x-x1) + sqr(y-y1);
  a2 := sqr(x-x2) + sqr(y-y2);

//  t1 := sqrt(a1);
//  t2 := sqrt(a2);
  t1 := sqrt(a1 + sqr(z1));
  t2 := sqrt(a2 + sqr(z2));

  g7 := 0;

  case Plot of

    4:
    begin
      if (t1 > Epsilon) and (t2 > Epsilon) then
      begin
        if ForceMode = 3 then
        begin
          f1 := Force(k1, t1, l1, m1);
          f2 := Force(k2, t2, l2, m2);
        end
        else
        begin
          f1 := Kraft(k1, t1, l1);
          f2 := Kraft(k2, t2, l2);
        end;

        u1 := f1 * (x-x1) / t1;
        u2 := f2 * (x-x2) / t2;

        v1 := f1 * (y-y1) / t1;
        v2 := f2 * (y-y2) / t2;

        u := u1 + u2;
        v := v1 + v2;

        bf := sqrt(sqr(u) + sqr(v));
        g7 := bf * FaktorEQ;
      end
      else
      begin
        g7 := 2 * abs(k1 * l1);
        g7 := g7 * FaktorEQ;
      end;
    end;

    6:
    begin
      { Richtung}
      BerechneWinkel(x, y);
    end;

    8:
    begin
      { Energie }
      b1 := k1 * sqr(t1 - l1) / 2;
      b2 := k2 * sqr(t2 - l2) / 2;
      g7 := (b1 + b2) * 20;
    end;


    14:
    begin
      g7 := 4000;
      if (t1 + t2 > Epsilon) then
      begin
        g7 := g7 / (t1 + t2) * FaktorEQ;
      end;
    end;

    15:
    begin
      b1 := t2 * (t1-l1) * k1;
      b2 := t1 * (t2-l2) * k2;
      g7 := (b1 + b2);
      if (t1 * t2 > Epsilon) then
      begin
        g7 := g7 / (t1 * t2) * 10 * FaktorEQ;
      end;
    end;

    16:
    begin
     g7 := (u + v) / (Abs(x + y) + 0.1) * 20;
    end;

    else
    begin
      if SolutionMode then
      begin
        b1 := t2 * (t1-l1) * k1;
        b2 := t1 * (t2-l2) * k2;

        u1 := b1 * (x - x1);
        u2 := b2 * (x - x2);

        v1 := b1 * (y - y1);
        v2 := b2 * (y - y2);

        u := u1 + u2;
        v := v1 + v2;
      end
      else
      begin
        if (t1 > Epsilon) and (t2 > Epsilon) then
        begin
          if ForceMode = 3 then
          begin
            f1 := Force(k1, t1, l1, m1);
            f2 := Force(k2, t2, l2, m2);
          end
          else
          begin
            f1 := Kraft(k1, t1, l1);
            f2 := Kraft(k2, t2, l2);
          end;

          u1 := f1 * (x-x1) / t1;
          u2 := f2 * (x-x2) / t2;

          v1 := f1 * (y-y1) / t1;
          v2 := f2 * (y-y2) / t2;

          u := (u1 + u2) * 1000;
          v := (v1 + v2) * 1000;
        end
        else
        begin
          case Plot of
            11:
            begin
              u := k1 * l1 * 1000;
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
            g7 := (b1 + b2) * 20
          else
            g7 := (f1 + f2) * 1000;
        end;
        2: g7 := sqrt(sqr(u) + sqr(v)) * 1;
        3: g7 := u + v;
//      4: Betrag
        5: g7 := Abs(u + v);
//      6: Richtung;
        7: g7 := Abs(v);
//      8: Energie;
        9: g7 := u;
       10: g7 := Abs(u);
       11: g7 := Abs(u) + Abs(v);
       12: g7 := Diff1(0, x, y) / 5;
       13: g7 := Diff2(0, x, y) * 500;
      end;
    end;
  end;
end;

function TFederEquation02.GetStatusLine: string;
begin
  case Plot of
    1:
    begin
      if SolutionMode then
        result := 'sum b'
      else
        result := 'sum f'
    end;
    2: result := 'sqrt(sum q)';
    3: result := 'u + v';
    4: result := StrBetrag;
    5: result := 'abs(u + v)';
    6: result := StrRichtung;
    7: result := 'abs(v)';
    8: result := StrEnergie;
    9: result := 'u';
    0: result := 'v';
    10: result := 'abs(u)';
    11: result := 'abs(u) + abs(v)';
    12: result := 'Diff1(0, x, y)';
    13: result := 'Diff2(0, x, y)';
  end
end;

procedure TFederEquation02.InitMemo(ML: TStrings);
begin
  case SourceFormat of
    0: InitPascal(ML);
    1: InitMaxima(ML);
  end;
end;

function TFederEquation02.GetValue(x, y: single): single;
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

function TFederEquation02.CalcRaw(x, y: single): single;
begin
  if fcap < 1 then
    fcap := 1;
  f03(x, y);
  result := g7;
end;

function TFederEquation02.CalcValue(x, y: single; af: Integer): single;
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

procedure TFederEquation02.Test(x, y: single);
var
  fu: single;
  fv: single;
  mo1, mo2, mos: single;
  alpha: single;
  mor1, mor2: single;
begin
  mo1 := v1 * x1 - u1 * y1;
  mo2 := v2 * x2 - u2 * y2;

  mos := mo1 + mo2;
  mor1 := v * x - u * y;
  Assert(Abs(mos - mor1) < 0.1);

  if (u > Epsilon) then
  begin
    alpha := arctan(v/u);

    fu := bf * cos(alpha);
    Assert(Abs(u - fu) < 0.1);

    fv := bf * sin(alpha);
    Assert(Abs(v - fv) < 0.1);

    mor2 := fv * x - fu * y;
    Assert(Abs(mor1 - mor2) < 0.1);
  end;
end;

procedure TFederEquation02.BerechneVorzeichen1(x, y: single);
begin
  if ForceMode = 3 then
  begin
    b1 := Force(k1, t1, l1, m1);
    b2 := Force(k2, t2, l2, m2);
  end
  else
  begin
    b1 := Kraft(k1, t1, l1);
    b2 := Kraft(k2, t2, l2);
  end;

  _vp := TPoint3D.Create(x, y, 0);

  _v1 := TPoint3D.Create(x1, y1, 0);
  _v2 := TPoint3D.Create(x2, y2, 0);

  _v1 := _vp - _v1;
  _v2 := _vp - _v2;

  _v1 := _v1 * b1;
  _v2 := _v2 * b2;
  _v3 := _v1 + _v2;

  bf := _v3.Length;

  f := _v1.AngleCosine(_v3);
  f := Sign(f) * bf / FaktorEQ;
end;

procedure TFederEquation02.BerechneVorzeichen2(x, y: single);
begin
  if ForceMode = 3 then
  begin
    b1 := Force(k1, t1, l1, m1);
    b2 := Force(k2, t2, l2, m2);
  end
  else
  begin
    b1 := Kraft(k1, t1, l1);
    b2 := Kraft(k2, t2, l2);
  end;

  _vp := TPoint3D.Create(x, y, 0);

  _v1 := TPoint3D.Create(x1, y1, 0);
  _v2 := TPoint3D.Create(x2, y2, 0);

  _v1 := _vp - _v1;
  _v2 := _vp - _v2;

  _v1 := _v1 * b1;
  _v2 := _v2 * b2;

  _v3 := _v1 + _v2;
  _v3 := _vp - _v3;
  _v3 := _v3 * -1;

  bf := _v3.Length;

  f := _v1.AngleCosine(_v3);
  f := Sign(f) * bf / FaktorEQ;
end;

procedure TFederEquation02.BerechneVorzeichen3(x, y: single);
begin
  _vp := TPoint3D.Create(x, y, 0);

  _v1 := TPoint3D.Create(x1, y1, 0);
  _v2 := TPoint3D.Create(x2, y2, 0);

  _v1 := _vp - _v1;
  _v2 := _vp - _v2;

  _v1 := _v1 * k1;
  _v2 := _v2 * k2;

  _v3 := _v1 + _v2;

  bf := _v3.Length;
  bf := bf - k1 * l1;
  bf := bf - k2 * l2;

  f := _v1.AngleCosine(_v3);
  f := Sign(f) * bf;
end;

procedure TFederEquation02.BerechneVorzeichen4(x, y: single);
begin
  if ForceMode = 3 then
  begin
    b1 := Force(k1, t1, l1, m1);
    b2 := Force(k2, t2, l2, m2);
  end
  else
  begin
    b1 := Kraft(k1, t1, l1);
    b2 := Kraft(k2, t2, l2);
  end;

  _vp := TPoint3D.Create(x, y, 0);

  _v1 := TPoint3D.Create(x1, y1, 0);
  _v2 := TPoint3D.Create(x2, y2, 0);

  _v1 := _vp - _v1;
  _v2 := _vp - _v2;

  _v1 := _v1.Normalize;
  _v2 := _v2.Normalize;

  _v1 := _v1 * b1;
  _v2 := _v2 * b2;
  _v3 := _v1 + _v2;

  bf := _v3.Length;

  b1 := t2 * (t1-l1) * k1;
  b2 := t1 * (t2-l2) * k2;

  f := 0;
  f := 1;
  if b1 + b2 < 0 then
    f := -1;

  f := Sign(f) * bf / 2;
end;

procedure TFederEquation02.BerechneVorzeichen5(x, y: single);
var
  sb: Boolean;
begin
  if ForceMode = 3 then
  begin
    b1 := Force(k1, t1, l1, m1);
    b2 := Force(k2, t2, l2, m2);
  end
  else
  begin
    b1 := Kraft(k1, t1, l1);
    b2 := Kraft(k2, t2, l2);
  end;

  _vp := TPoint3D.Create(x, y, 0);
  _v1 := _vp - TPoint3D.Create(x1, y1, 0); //von 1 nach p
  _v2 := _vp - TPoint3D.Create(x2, y2, 0); //von 2 nach p

  c1 := _v1.AngleCosine(TPoint3D.Create(1, 0, 1));
  c2 := _v2.AngleCosine(TPoint3D.Create(1, 0, 1));
  s1 := _v1.AngleCosine(TPoint3D.Create(0, 1, 1));
  s2 := _v2.AngleCosine(TPoint3D.Create(0, 1, 1));

  _n1 := _v1.Normalize; //Kraft in Richtung Feder 1 mit Betrag 1
  _n2 := _v2.Normalize; //Kraft in Richtung Feder 2 mit Betrag 1
  _f1 := _n1 * b1; //Kraft in Feder 1
  _f2 := _n2 * b2; //Kraft in Feder 2
  _f0 := _f1 + _f2;

  bf := _f0.Length;

  cf := _f0.AngleCosine(TPoint3D.Create(1, 0, 1));
  sf := _f0.AngleCosine(TPoint3D.Create(0, 1, 1));

  case PlotFigure of
    1:
    begin
      df := _f0.AngleCosine(_v1 - _v2);

      vz := Sign(df);

      { linke Seite an xy-Ebenen spiegeln }
      sb := BerechneBaseX(x, y);
      if not sb then
        vz := -vz;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    2:
    begin
      if b1 = 0 then
        vz := -Sign(b2)
      else if b2 = 0 then
        vz := -Sign(b1)
      else if (b1 > 0) and (b2 > 0) then
        vz := 1
      else if (b1 < 0) and (b2 < 0) then
        vz := -1
      else if (b1 < 0) and (b1 + b2 < 0) then
        vz := -1
      else if (b2 < 0) and (b1 + b2 < 0) then
        vz := -1
      else
        vz := 1;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    3:
    begin
      vz := 1;
      if (b1 < 0) and (b2 < 0) then
        vz := -1;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    4:
    begin
      vz := 1;
      if (b1 < 0) or (b2 < 0) then
        vz := -1;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    9:
    begin
      df := _f0.AngleCosine(TPoint3D.Create(x2, y2, 0) - TPoint3D.Create(x1, y1, 0));

      vz := Sign(df);

//      { linke Seite an xy-Ebenen spiegeln }
//      sb := BerechneBaseX(x, y);
//      if not sb then
//        vz := -vz;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    8:
    begin
      vz := Sign(cf);

      { linke Seite an xy-Ebenen spiegeln }
      sb := BerechneBaseX(x, y);
      if not sb then
        vz := -vz;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    7:
    begin
      g7 := bf * Sign(cf) * FaktorEQ;
    end;

    6:
    begin
      df := _f0.AngleCosine(_v1 - _v2);
      vz := Sign(df);
      g7 := vz * 10 * FaktorEQ;
    end;

    5:
    begin
      g7 := cf * 10 * FaktorEQ;
    end;

    11:
    begin
      g7 := Abs(cf) * 10 * FaktorEQ;
    end;

    10:
    begin
      { linke Seite an xy-Ebenen spiegeln }
      sb := BerechneBaseX(x, y);
      vz := 1;
      if not sb then
        vz := -vz;
      g7 := vz * 10 * FaktorEQ;
    end;

  end;
end;

procedure TFederEquation02.InitCase;
begin
  WantSignY := False;
  WantSignX := False;
  WantSignF := False;
  WantFactorF := False;
  WantFactorBF := False;
  WantRemoveJitterX := False;
  WantRemoveJitterY := False;
  WantRemoveJitterC := False;
  WantSwap := False;

  case PlotFigure of
    1:
    begin
      AngleVector := 4;
      WantFactorBF := True;
      WantSignF := True;
    end;
    2:
    begin
      AngleVector := 6;
      WantSignF := True;
    end;
    3:
    begin
      AngleVector := 6;
      WantFactorBF := True;
      WantSignF := True;
    end;
    4:
    begin
      AngleVector := 1;
      WantFactorF := True;
      WantFactorBF := True;
      WantRemoveJitterC := True;
    end;
    5:
    begin
      AngleVector := 3;
      WantSignF := True;
      WantFactorBF := True;
    end;
    6:
    begin
      AngleVector := 3;
      WantFactorBF := True;
      WantSignX := True;
    end;
    7:
    begin
      AngleVector := 3;
      WantFactorF := True;
      WantFactorBF := True;
      WantSignX := True;
      WantSwap := True;
    end;
    8:
    begin
      AngleVector := 4;
      WantFactorF := True;
    end;
    9:
    begin
      AngleVector := 4;
      WantFactorF := True;
      WantSignX := True;
      WantSwap := True;
    end;
    10:
    begin
      AngleVector := 4;
      WantSignF := True;
    end;
    11:
    begin
      AngleVector := 4;
      WantSignF := True;
      WantSignX := True;
      WantSwap := True;
    end;
    12:
    begin
      AngleVector := 4;
      WantSignF := True;
      WantFactorBF := True;
    end;
    13:
    begin
      AngleVector := 4;
      WantSignF := True;
      WantFactorBF := True;
      WantSignX := True;
      WantSwap := True;
    end;
    14:
    begin
      AngleVector := 4;
      WantFactorF := True;
      WantFactorBF := True;
    end;
    15:
    begin
      AngleVector := 4;
      WantFactorF := True;
      WantFactorBF := True;
      WantSignX := True;
      WantSwap := True;
    end;
    16:
    begin
      AngleVector := 5;
      WantFactorF := True;
      WantFactorBF := True;
    end;
    17:
    begin
      AngleVector := 5;
      WantFactorF := True;
      WantFactorBF := True;
      WantSignF := True;
    end;
    18:
    begin
      AngleVector := 1;
      WantFactorBF := True;
      WantSignF := True;
      WantRemoveJitterY := True;
      WantSwap := True;
    end;
    19:
    begin
      AngleVector := 1;
      WantFactorBF := True;
      WantSignF := True;
      WantRemoveJitterX := True;
    end;
    20:
    begin
      AngleVector := 2;
      WantFactorF := True;
      WantFactorBF := True;
      WantRemoveJitterC := True;
    end;
    21:
    begin
      AngleVector := 2;
      WantFactorF := True;
      WantFactorBF := True;
      WantSignY := True;
    end;
    else
    begin
      AngleVector := 0;
      WantFactorF := True;
    end;

  end;
end;

procedure TFederEquation02.HokusPokus(x, y: single);
begin
  if not Vorzeichen then
  begin
    f := bf;
  end
  else
  begin

    InitCase;

    if WantRemoveJitterC then
    begin
      if Abs(y) < 0.1 then
        cf := 0;
    end;

    f := 1;
    if WantFactorBF then
      f := bf;

    if WantSignF then
    begin
      if not Probe2(x, y) then
      begin
        f := -f;
      end;
    end;

    if WantFactorF then
      f := f * cf;
    if WantSignX then
      f := Sign(x) * f;
    if WantSignY then
      f := Sign(y) * f;
    if WantSwap then
      f := -f;
    if not WantFactorBF then
      f := f * 75;

  end;
end;

function TFederEquation02.Probe1(x, y: single): Boolean;
var
  cosw1: single;
  cosw2: single;
  bf1: single;
  bf2: single;
  fx1: single;
  fx2: single;
  fx3: single;
  fxr: single;
begin
  result := False;
  if (t1 > Epsilon) and (t2 > Epsilon) then
  begin
    if ForceMode = 3 then
    begin
      bf1 := Force(k1, t1, l1, m1);
      bf2 := Force(k2, t2, l2, m2);
    end
    else
    begin
      bf1 := Kraft(k1, t1, l1);
      bf2 := Kraft(k2, t2, l2);
    end;
    cosw1 := (x-x1) / t1;
    cosw2 := (x-x2) / t2;
    fx1 := bf1 * cosw1;
    fx2 := bf2 * cosw2;
    fxr := fx1 + fx2;
    fx3 := bf * cf;
    AssertEqual(fxr, fx3);
  end;
end;

function TFederEquation02.Probe2(x, y: single): Boolean;
var
  cosw1: single;
  sinw1: single;
  cosw2: single;
  sinw2: single;

  bf1: single;
  bf2: single;
  bf3: single;

  ur: single;
  vr: single;
begin
  HasError := False;
  result := False;
  if (t1 > Epsilon) and (t2 > Epsilon) then
  begin
    if ForceMode = 3 then
    begin
      bf1 := Force(k1, t1, l1, m1);
      bf2 := Force(k2, t2, l2, m2);
    end
    else
    begin
      bf1 := Kraft(k1, t1, l1);
      bf2 := Kraft(k2, t2, l2);
    end;

    cosw1 := (x-x1) / t1;
    cosw2 := (x-x2) / t2;
    AssertEqual(c1, cosw1);
    AssertEqual(c2, cosw2);

    sinw1 := (y-y1) / t1;
    sinw2 := (y-y2) / t2;
    AssertEqual(s1, sinw1);
    AssertEqual(s2, sinw2);

    u1 := bf1 * cosw1;
    u2 := bf2 * cosw2;
    v1 := bf1 * sinw1;
    v2 := bf2 * sinw2;
    u := u1 + u2;
    v := v1 + v2;
    bf3 := sqrt(sqr(u) + sqr(v));
    AssertEqual(bf, bf3);

    ur := bf * cf;
    CheckEqual(Abs(u), Abs(ur));
    CheckEqual(u, ur);
    AssertEqual(Abs(u), Abs(ur));
    AssertEqual(u, ur);

    vr := bf * sf;
    CheckEqual(Abs(v), Abs(vr));
    CheckEqual(v, vr);
    AssertEqual(Abs(v), Abs(vr));
    AssertEqual(v, vr);

    if HasError then
      result := False;
  end;
end;

function TFederEquation02.BerechneBaseX(x, y: single): Boolean;
var
  _va, _vb: TPoint3D;
  _v12: TPoint3D;
  cb: single;
  sb: single;
  _temp: TPoint3D;
  b12: single;
  Teiler12: single;
begin
  _va := TPoint3D.Create(x1, y1, 0);
  _vb := TPoint3D.Create(x2, y2, 0);

  _vp := TPoint3D.Create(x, y, 0);
  _v12 := _vb - _va;

  b12 := _v12.Length;
  _v12 := _v12.Normalize;

  if (l1 + l2) < Epsilon then
    Teiler12 := b12 * l1 / (l1 + l2)
  else
    Teiler12 := 0.5;

  _temp := _v12 * (b12 * Teiler12);
  _temp := _va + _temp; //'Nullpunkt'
  _temp := _vp - _temp;
  cb := _temp.AngleCosine(_v12);

  sb := Sign(cb);

  if Abs(cb) < Epsilon then
    sb := 1;

  result := sb > 0;
end;

procedure TFederEquation02.BerechneWinkel(x, y: single);
begin
//  b1 := k1 * (t1 - l1); //Betrag Kraft in Feder 1
//  b2 := k2 * (t2 - l2); //Betrag Kraft in Feder 2
  if ForceMode = 3 then
  begin
    b1 := Force(k1, t1, l1, m1);
    b2 := Force(k2, t2, l2, m2);
  end
  else
  begin
    b1 := Kraft(k1, t1, l1);
    b2 := Kraft(k2, t2, l2);
  end;

  _vp := TPoint3D.Create(x, y, 0);
  _v1 := _vp - TPoint3D.Create(x1, y1, 0); //von 1 nach p
  _v2 := _vp - TPoint3D.Create(x2, y2, 0); //von 2 nach p

  c1 := _v1.AngleCosine(TPoint3D.Create(1, 0, 1));
  c2 := _v2.AngleCosine(TPoint3D.Create(1, 0, 1));
  s1 := _v1.AngleCosine(TPoint3D.Create(0, 1, 1));
  s2 := _v2.AngleCosine(TPoint3D.Create(0, 1, 1));

  _n1 := _v1.Normalize; //Kraft in Richtung Feder 1 mit Betrag 1
  _n2 := _v2.Normalize; //Kraft in Richtung Feder 2 mit Betrag 1
  _f1 := _n1 * b1; //Kraft in Feder 1
  _f2 := _n2 * b2; //Kraft in Feder 2
  _f0 := _f1 + _f2;

  bf := _f0.Length;

  cf := _f0.AngleCosine(TPoint3D.Create(1, 0, 1));
  sf := _f0.AngleCosine(TPoint3D.Create(0, 1, 1));

  case PlotFigure of
    1: g7 := cf * 10 * FaktorEQ;
    2: g7 := sf * 10 * FaktorEQ;
    3: g7 := Abs(cf) * 10 * FaktorEQ;
    4: g7 := Abs(sf) * 10 * FaktorEQ;
    5:
    begin
      df := _f0.AngleCosine(_v1 - _v2);
      vz := Sign(df);

      if not BerechneBaseX(x, y) then
        vz := -vz;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    6:
    begin
      if b1 = 0 then
        vz := -Sign(b2)
      else if b2 = 0 then
        vz := -Sign(b1)
      else if (b1 > 0) and (b2 > 0) then
        vz := 1
      else if (b1 < 0) and (b2 < 0) then
        vz := -1
      else if (b1 < 0) and (b1 + b2 < 0) then
        vz := -1
      else if (b2 < 0) and (b1 + b2 < 0) then
        vz := -1
      else
        vz := 1;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    7:
    begin
      vz := 1;
      if (b1 < 0) and (b2 < 0) then
        vz := -1;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    8:
    begin
      vz := 1;
      if (b1 < 0) or (b2 < 0) then
        vz := -1;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    9: g7 := bf * Sign(cf) * FaktorEQ;

    10:
    begin
      vz := Sign(cf);

      if not BerechneBaseX(x, y) then
        vz := -vz;

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    11:
    begin
      df := _f0.AngleCosine(TPoint3D.Create(x2, y2, 0) - TPoint3D.Create(x1, y1, 0));
      vz := Sign(df);

      f := bf * vz;
      g7 := f * FaktorEQ;
    end;

    12:
    begin
      vz := 1;
      if not BerechneBaseX(x, y) then
        vz := -vz;
      g7 := vz * 10 * FaktorEQ;
    end;

    13:
    begin
      df := _f0.AngleCosine(_v1 - _v2);
      g7 := df * 10 * FaktorEQ;
    end;

  end;

end;

procedure TFederEquation02.InitKoord;
begin
  FaktorG3 := 1.0;
  FaktorEQ := 1 * 1000;
  MaxPlotFigure := 13;

  x1 := -30; y1 := 0; l1 := 30; k1 := 1;
  x2 :=  30; y2 := 0; l2 := 30; k2 := 1;
  x3 :=   0; y3 := 10; l3 := 30; k3 := 1;
end;

procedure TFederEquation02.InitPascal(ML: TStrings);
begin
  ML.Add('a1 := sqr(x-x1) + sqr(y-y1);');
  ML.Add('a2 := sqr(x-x2) + sqr(y-y2);');
  ML.Add('t1 := sqrt(a1);');
  ML.Add('t2 := sqrt(a2);');
  case Plot of
    4:
    begin
      ML.Add('f1 := k1 * (t1-l1);');
      ML.Add('f2 := k2 * (t2-l2);');
      ML.Add('');
      ML.Add('u1 := f1 * (x-x1) / t1;');
      ML.Add('u2 := f2 * (x-x2) / t2;');
      ML.Add('');
      ML.Add('v1 := f1 * (y-y1) / t1;');
      ML.Add('v2 := f2 * (y-y2) / t2;');
      ML.Add('');
      ML.Add('u := u1 + u2;');
      ML.Add('v := v1 + v2;');
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
      ML.Add('g7 := b1 + b2;');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1 := t2 * (t1-l1) * k1;');
        ML.Add('b2 := t1 * (t2-l2) * k2;');
        ML.Add('');
        ML.Add('u1 := b1 * (x-x1);');
        ML.Add('u2 := b2 * (x-x2);');
        ML.Add('');
        ML.Add('v1 := b1 * (y-y1);');
        ML.Add('v2 := b2 * (y-y2);');
        ML.Add('');
        ML.Add('u := u1 + u2;');
        ML.Add('v := v1 + v2;');
      end
      else
      begin
        ML.Add('f1 := k1 * (t1-l1);');
        ML.Add('f2 := k2 * (t2-l2);');
        ML.Add('');
        ML.Add('u1 := f1 * (x-x1);');
        ML.Add('u2 := f2 * (x-x2);');
        ML.Add('');
        ML.Add('v1 := f1 * (y-y1);');
        ML.Add('v2 := f2 * (y-y2);');
        ML.Add('');
        ML.Add('u := u1 + u2;');
        ML.Add('v := v1 + v2;');
      end;
    end;
  end;
end;

procedure TFederEquation02.InitMaxima(ML: TStrings);
begin
  ML.Add(SampleInfo);
  ML.Add('');
  ML.Add('a1: (x-x1)^2 + (y-y1)^2$');
  ML.Add('a2: (x-x2)^2 + (y-y2)^2$');
  ML.Add('');

  if z1 = 0 then
    ML.Add('t1: sqrt(a1)$')
  else
    ML.Add('t1: sqrt(a1 + z1^2)$');

  if z2 = 0 then
    ML.Add('t2: sqrt(a2)$')
  else
    ML.Add('t2: sqrt(a2 + z2^2)$');

  ML.Add('');
  case Plot of
    4:
    begin
      ML.Add('f1: k1 * (t1-l1)$');
      ML.Add('f2: k2 * (t2-l2)$');
      ML.Add('');
      ML.Add('u1: f1 * (x-x1) / t1$');
      ML.Add('u2: f2 * (x-x2) / t2$');
      ML.Add('');
      ML.Add('v1: f1 * (y-y1) / t1$');
      ML.Add('v2: f2 * (y-y2) / t2$');
      ML.Add('');
      ML.Add('u: u1 + u2$');
      ML.Add('v: v1 + v2$');
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
      ML.Add('g7: (b1 + b2) * 20$');
    end;
    else
    begin
      if SolutionMode then
      begin
        ML.Add('b1: t2 * t3 * (t1-l1) * k1$');
        ML.Add('b2: t1 * t3 * (t2-l2) * k2$');
        ML.Add('');
        ML.Add('u1: b1 * (x-x1)$');
        ML.Add('u2: b2 * (x-x2)$');
        ML.Add('');
        ML.Add('v1: b1 * (y-y1)$');
        ML.Add('v2: b2 * (y-y2)$');
        ML.Add('');
        ML.Add('u: u1 + u2$');
        ML.Add('v: v1 + v2$');
        ML.Add('');
      end
      else
      begin
        ML.Add('f1: k1 * (t1-l1)$');
        ML.Add('f2: k2 * (t2-l2)$');
        ML.Add('');
        ML.Add('u1: f1 * (x-x1) / t1$');
        ML.Add('u2: f2 * (x-x2) / t2$');
        ML.Add('');
        ML.Add('v1: f1 * (y-y1) / t1$');
        ML.Add('v2: f2 * (y-y2) / t2$');
        ML.Add('');
        ML.Add('u: (u1 + u2) * 1000$');
        ML.Add('v: (v1 + v2) * 1000$');
        ML.Add('');
      end;
      case Plot of
        0: ML.Add('g7: v$');
        1:
        begin
          if SolutionMode then
            ML.Add('g7: (b1 + b2) * 20$')
          else
            ML.Add('g7: (f1 + f2) * 1000$');
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
        12:
        begin
          if SolutionMode then
            ML.Add('g7: diff(u1, x, 1, y, 1) / 5$')
          else
            ML.Add('g7: diff(f1, x, 1, y, 1) / 5$');
        end;
        13:
        begin
          if SolutionMode then
            ML.Add('g7: diff(u1, x, 2, y, 2) * 500$')
          else
            ML.Add('g7: diff(f1, x, 2, y, 2) * 500$')
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
  ML.Add(Format('x1: %.2f$ x2: %.2f$', [x1, x2]));
  ML.Add(Format('y1: %.2f$ y2: %.2f$', [y1, y2]));
  ML.Add(Format('z1: %.2f$ z2: %.2f$', [z1, z2]));
  ML.Add(Format('l1: %.2f$ l2: %.2f$', [l1, l2]));
  ML.Add(Format('k1: %.2f$ k2: %.2f$', [k1, k2]));
  ML.Add('');
  ML.Add(Format('plot3d(f, [x,%.2f,%.2f], [y,%.2f,%.2f], [z,-100,100], [plot_format,xmaxima]);',
  [rmin, rmax, rmin, rmax]));
end;

end.

