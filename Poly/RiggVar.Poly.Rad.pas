unit RiggVar.Poly.Rad;

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
  System.UITypes,
  System.UIConsts,
  System.Types,
  System.Math,
  System.Math.Vectors,
  RiggVar.FB.Def,
  RiggVar.Poly.Rack;

type
  TPolyRad = class(TPolyRadBase)
  private
    MP: TPointF;
    P1, P2: TPointF;
    Poly: TPolygonListArray;

    SX: single;
    SY: single;
    TF: single;

    procedure Prepare;
    procedure ComputeCurve;
    function ComputePoint: TPointF;
  protected
    procedure AddCurvesA;

    procedure AddCurvesA1;
    procedure AddCurvesA2;
    procedure AddCurvesA3;

    procedure AddCurvesB;

    procedure AddCurvesB1;
    procedure AddCurvesB2;
    procedure AddCurvesB3;
  public
    constructor Create(ARack: TPolyRack; AMode: Integer; ACurveSet: Integer = 0);
    function IsInRange: Boolean; override;
    procedure Compute; override;
    procedure Configure; override;
    procedure AddReport(SL: TStrings); override;
    function Contains(AP: TPointF): Boolean; override;
  end;

implementation

uses
  RiggVar.App.Main;

{ TPolyRad }

constructor TPolyRad.Create(ARack: TPolyRack; AMode: Integer; ACurveSet: Integer = 0);
begin
  inherited;

  PointCount := 360;
  PolyCount := PointCount + 1;

  { Default Values, possibly updated in Prepare method }
  TargetDiff := 0.001;
  LoopMax := 1000;

  Configure;
end;

procedure TPolyRad.Prepare;
begin
  BingoCounter := 0;
  BongoCounter := 0;
  CounterMax := 0;

  CapValue := CurrentCapValue * CapValueFlipFactor;
  MP := TPointF.Create(SX, SY);
  TargetDiff := 0.001;
  LoopMax := 1000;

  FR.TopLeft := MP;
  FR.BottomRight := MP;

  FR.Left := FR.Left - 10;
  FR.Top := FR.Top - 10;
  FR.Right := FR.Right + 10;
  FR.Bottom := FR.Bottom + 10;
end;

function TPolyRad.IsInRange: Boolean;
var
  cv: single;
begin
  result := False;
  cv := CurrentCapValue;
  case Mode of
    1, 2: result := (cv > -3.2) and (cv < 43.3);
    3, 4: result := (cv > 0) and (cv < 36.5);
  end;
end;

procedure TPolyRad.Configure;
begin
  inherited;

  case Mode of
    1:
    begin
      SX := -71;
      SY := 37.5;
      CapValueFlipFactor := -1.0;
      TF := -1.0;
      AddCurvesA;
    end;

    2:
    begin
      SX := 71;
      SY := 37.5;
      CapValueFlipFactor := 1.0;
      TF := 1.0;
      AddCurvesA;
    end;

    3:
    begin
      SX := -22;
      SY := -80;
      CapValueFlipFactor := 1.0;
      TF := -1.0;
      AddCurvesB;
    end;

    4:
    begin
      SX := 22;
      SY := -80;
      CapValueFlipFactor := -1.0;
      TF := 1.0;
      AddCurvesB;
    end;

  end;
end;

procedure TPolyRad.AddCurvesA;
begin
  case CurveSet of
    0: AddOnlyOne;
    1: AddCurvesA1;
    2: AddCurvesA2;
    3: AddCurvesA3;
    4: AddCurves(0, 40, 5);
    5: AddCurves(-2, 42, 2);
    6: AddCurves(-3, 43, 1);
    else
      AddCurvesA1;
  end;
end;

procedure TPolyRad.AddCurvesB;
begin
  case CurveSet of
    0: AddOnlyOne;
    1: AddCurvesB1;
    2: AddCurvesB2;
    3: AddCurvesB3;
    4: AddCurves(5, 35, 5);
    5: AddCurves(2, 36, 2);
    6: AddCurves(1, 36, 1);
    else
      AddCurvesB1;
  end;
end;

procedure TPolyRad.AddCurvesA1;
begin
  Index := 0;
  Count := 3;
  SetLength(Curves, Count);

  CurrentColor := claYellow;
  AddCurve(-2);
  AddCurve(0);
  AddCurve(12);
end;

procedure TPolyRad.AddCurvesA2;
begin
  Index := 0;
  Count := 15;
  SetLength(Curves, Count);

  CurrentColor := claYellow;
  AddCurve(30);
  AddCurve(40);

  CurrentColor := claRed;
  AddCurve(12);
  AddCurve(10);
  AddCurve(8);
  AddCurve(6);
  AddCurve(4);
  AddCurve(2);

  CurrentColor := claCornflowerblue;
  AddCurve(1);

  CurrentColor := claLime;
  AddCurve(0);

  CurrentColor := claWhite;
  AddCurve(-1);
  AddCurve(-2);
  AddCurve(-3);

  CurrentColor := claYellow;
  AddCurve(-3.1);
  AddCurve(-3.2);
end;

procedure TPolyRad.AddCurvesA3;
var
  i: Integer;
  c: Integer;
  z: single;
begin
  c := 21;
  Index := 0;
  Count := c + 3;
  SetLength(Curves, Count);

  { 2 .. 42}
  for i := 1 to c do
  begin
    z := 2 * i;
    CurrentColor := GetColor(i, z);
    AddCurve(z);
  end;

  CurrentColor := GetColor(22, 0);
  AddCurve(0);

  CurrentColor := GetColor(23, -2);
  AddCurve(-2);

  CurrentColor := claYellow;
  AddCurve(43);
  AddCurve(-3);
  AddCurve(-3.2);
end;

procedure TPolyRad.AddCurvesB1;
begin
  Index := 0;
  Count := 4;
  SetLength(Curves, Count);

  CurrentColor := claYellow;
  AddCurve(30);
  AddCurve(20);
  AddCurve(10);
  AddCurve(1);
end;

procedure TPolyRad.AddCurvesB2;
begin
  Index := 0;
  Count := 13;
  SetLength(Curves, Count);

  CurrentColor := claWhite;
  AddCurve(36);

  CurrentColor := claYellow;
  AddCurve(35);
  AddCurve(30);
  AddCurve(25);
  AddCurve(20);
  AddCurve(15);
  CurrentColor := claRed;
  AddCurve(10);
  AddCurve(8);
  AddCurve(6);
  AddCurve(4);
  AddCurve(2);

  CurrentColor := claWhite;
  AddCurve(1);
  AddCurve(0.2);
end;

procedure TPolyRad.AddCurvesB3;
var
  i: Integer;
  c: Integer;
  z: single;
begin
  c := 18;
  Index := 0;
  Count := c + 4;
  SetLength(Curves, Count);

  for i := 1 to c do
  begin
    z := 2 * i;
    CurrentColor := GetColor(i, z);
    AddCurve(z);
  end;

  CurrentColor := claYellow;
  AddCurve(35);
  AddCurve(36.6);

  CurrentColor := claYellow;
  AddCurve(1);
  AddCurve(0.2);
end;

procedure TPolyRad.Compute;
var
  i: Integer;
  cr: TPolyCurve;
begin
  Prepare;

  Valid := IsInRange;
  if Valid then
  for i := 0 to Length(Curves) - 1 do
  begin
    cr := Curves[i];
    if CurveSet <> 0 then
      CapValue := cr.AZ;
    Poly := cr.Poly;
    cr.Poly.UpdateLength(PointCount + 1);
    ComputeCurve;
    if (WantPolyTrim) then
    begin
      cr.TrimPoly();
    end;
  end;
end;

procedure TPolyRad.ComputeCurve;
var
  i: Integer;
  a: single;
  R: single;
begin
  P1 := MP;
  R := 10;

  Poly.Clear;
  for i := 0 to PointCount do
  begin
    a := DegToRad(360 / PointCount * i);
    P2.X := P1.X + R * cos(a);
    P2.Y := P1.Y + R * sin(a);
    Poly.Add(ComputePoint);
  end;
end;

function TPolyRad.ComputePoint: TPointF;
var
  i: Integer;
  P: TPointF;
  T: TPointF;
  z: single;
  Counter: Integer;
begin
  Counter := 0;
  P := P1;
  T := (P2 - P1).Normalize * 4;
  for i := 0 to LoopMax do
  begin
    z := Main.FederModel.EQ.GetValueN(P.X, P.Y);

    if Abs(z - CapValue) < TargetDiff then
    begin
      Bongo;
      break;
    end;

    if (TF > 0) and (z < CapValue) then
    begin
      P := P + T;
    end
    else if (TF < 0) and (z > CapValue) then
    begin
      P := P + T;
    end
    else
    begin
      P := P - T;
      T := T * 0.5;
      P := P + T;
    end;

    Inc(Counter);
  end;

  if Counter >= LoopMax then
  begin
    Bingo;
  end;

  if Counter > CounterMax then
    CounterMax := Counter;

  result := P;
end;

procedure TPolyRad.AddReport(SL: TStrings);
var
  r: TRect;
begin
  r := GetBoundsRect;
  SL.Add('');
  SL.Add(Format('PolyRad %d:', [Mode]));
  SL.Add(Format('CurveSet = %d', [CurveSet]));
  SL.Add(Format('CurveCount = %d', [Count]));
  SL.Add(Format('TargetDiff = %.3f', [TargetDiff]));
  SL.Add(Format('LoopMax = %d', [LoopMax]));
  SL.Add(Format('IsInRange = %s', [BoolStr[IsInRange]]));
  SL.Add(Format('CounterMax = %d', [CounterMax]));
  SL.Add(Format('Bounds = (%d, %d) (%d, %d)', [r.Left, r.Top, r.Right, r.Bottom]));
  SL.Add(Format('Size = (%d, %d)', [r.Width, r.Height]));
end;

function TPolyRad.Contains(AP: TPointF):  Boolean;
var
  cr: TPolygonListArray;
  i: Integer;
  P1, P2: TPointF;
  A, B: TPointF;
  t: single;
begin
  result := True;
  cr := Poly;
  for i := 1 to cr.Count - 1 do
  begin
    P1 := cr[i-1];
    P2 := cr[i];
    A := P2 - P1;
    B := AP - P1;
    t := A.CrossProduct(B);
    if t < 0 then
    begin
      result := False;
      break;
    end;
  end;
end;

end.
