unit RiggVar.EQ.Model;

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
  RiggVar.FB.Model,
  RiggVar.FB.Equation;

type
  TFederModelEQ = class(TFederModelEQBase)
  strict private
    Equation01: TFederEquation;
    Equation02: TFederEquation;
    Equation03: TFederEquation;
    Equation04: TFederEquation;
    Equation0N: TFederEquation;
    Equation0S: TFederEquation;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SwapEQ(newEQIndex: Integer); override;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.EQ.Equation01,
  RiggVar.EQ.Equation02,
  RiggVar.EQ.Equation03,
  RiggVar.EQ.Equation04,
  RiggVar.EQ.Equation0N,
  RiggVar.EQ.Equation0S,
  RiggVar.EQ.Equation01Diff,
  RiggVar.EQ.Equation02Diff,
  RiggVar.EQ.Equation03Diff;

{ TFederModelEQ }

constructor TFederModelEQ.Create;
begin
  Equation01 := TDiffEquation01.Create;
  Equation02 := TDiffEquation02.Create;
  Equation03 := TDiffEquation03.Create;
  Equation04 := TFederEquation04.Create;
  Equation0N := TFederEquation0N.Create;
  Equation0S := TFederEquation0S.Create;

  SwapEQ(3);
end;

destructor TFederModelEQ.Destroy;
begin
  EQ := nil;

  Equation01.Free;
  Equation02.Free;
  Equation03.Free;
  Equation04.Free;
  Equation0N.Free;
  Equation0S.Free;

  inherited;
end;

procedure TFederModelEQ.SwapEQ(newEQIndex: Integer);
begin
  case newEQIndex of
    0: EQ := Equation0S;
    1: EQ := Equation01;
    2: EQ := Equation02;
    3: EQ := Equation03;
    4: EQ := Equation04;
    5: EQ := Equation0N;
    else
      EQ := Equation03;
  end;
  EQIndex := newEQIndex;
  if (EQ <> nil) and (EQIndex >= 1) and (EQIndex <= 5) then
  begin
    EQ.SpringCount := EQIndex;
  end;

end;

end.

