unit RiggVar.Anim.ParallelAnimation;

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
  RiggVar.FB.Data,
  RiggVar.FB.Def;

type
  TParallelAnimation = class
  private
    A: TFederData;
    B: TFederData;
  public
    SetValueCounter: Integer;
    constructor Create;
    destructor Destroy; override;
    procedure Init(fd1, fd2: TFederData);
    procedure SetValue(m: TFederModel; Value: single);
  end;

implementation

{ TParallelAnimation }

constructor TParallelAnimation.Create;
begin
  A := TFederData.Create;
  B := TFederData.Create;
end;

destructor TParallelAnimation.Destroy;
begin
  A.Free;
  B.Free;
  inherited;
end;

procedure TParallelAnimation.Init(fd1, fd2: TFederData);
begin
  A.Assign(fd1);
  B.Assign(fd2);
  A.ParallelAnimationValue := 0;
  B.ParallelAnimationValue := 1;

  SetValueCounter := 0;
end;

procedure TParallelAnimation.SetValue(m: TFederModel; Value: single);
var
  t: Integer;
begin
  t := 1000;

  m.EQ.x1 := A.x1 + Value * (B.x1 - A.x1) / t;
  m.EQ.x2 := A.x2 + Value * (B.x2 - A.x2) / t;
  m.EQ.x3 := A.x3 + Value * (B.x3 - A.x3) / t;
  m.EQ.x4 := A.x4 + Value * (B.x4 - A.x4) / t;

  m.EQ.y1 := A.y1 + Value * (B.y1 - A.y1) / t;
  m.EQ.y2 := A.y2 + Value * (B.y2 - A.y2) / t;
  m.EQ.y3 := A.y3 + Value * (B.y3 - A.y3) / t;
  m.EQ.y4 := A.y4 + Value * (B.y4 - A.y4) / t;

  m.EQ.z1 := A.z1 + Value * (B.z1 - A.z1) / t;
  m.EQ.z2 := A.z2 + Value * (B.z2 - A.z2) / t;
  m.EQ.z3 := A.z3 + Value * (B.z3 - A.z3) / t;
  m.EQ.z4 := A.z4 + Value * (B.z4 - A.z4) / t;

  m.EQ.l1 := A.l1 + Value * (B.l1 - A.l1) / t;
  m.EQ.l2 := A.l2 + Value * (B.l2 - A.l2) / t;
  m.EQ.l3 := A.l3 + Value * (B.l3 - A.l3) / t;
  m.EQ.l4 := A.l4 + Value * (B.l4 - A.l4) / t;

  m.EQ.k1 := A.k1 + Value * (B.k1 - A.k1) / t;
  m.EQ.k2 := A.k2 + Value * (B.k2 - A.k2) / t;
  m.EQ.k3 := A.k3 + Value * (B.k3 - A.k3) / t;
  m.EQ.k4 := A.k4 + Value * (B.k4 - A.k4) / t;

  m.FT1 := A.T1 + Value * (B.T1 - A.T1) / t;
  m.FT2 := A.T2 + Value * (B.T2 - A.T2) / t;

  m.FAttenuation := A.Attenuation + Value * (B.Attenuation - A.Attenuation) / t;
  m.CapValue := A.CapValue + Value * (B.CapValue - A.CapValue) / t;
  m.FAbsoluteRange := A.AbsoluteRange + Value * (B.AbsoluteRange - A.AbsoluteRange) / t;

  m.FOffsetX := A.OffsetX + Value * (B.OffsetX - A.OffsetX) / t;
  m.FOffsetY := A.OffsetY + Value * (B.OffsetY - A.OffsetY) / t;
  m.FOffsetZ := A.OffsetZ + Value * (B.OffsetZ - A.OffsetZ) / t;

  m.InitRange;

  Inc(SetValueCounter);
end;

end.
