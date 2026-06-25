unit RiggVar.Util.GamePad;

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

type
  TGamePad = class
  private
    FBack: Boolean;
    FStart: Boolean;
    FA: Boolean;
    FB: Boolean;
    FX: Boolean;
    FY: Boolean;
    FLeft: Boolean;
    FRight: Boolean;
    FUp: Boolean;
    FDown: Boolean;
    FLeftShoulder: Boolean;
    FRightShoulder: Boolean;
    FLeftTrigger: Integer;
    FRightTrigger: Integer;
    FLX: single;
    FLY: single;
    FRX: single;
    FRY: single;
    FWantRepeat: Boolean;
    procedure SetA(const Value: Boolean);
    procedure SetB(const Value: Boolean);
    procedure SetX(const Value: Boolean);
    procedure SetY(const Value: Boolean);
    procedure SetBack(const Value: Boolean);
    procedure SetStart(const Value: Boolean);
    procedure SetLeft(const Value: Boolean);
    procedure SetRight(const Value: Boolean);
    procedure SetUp(const Value: Boolean);
    procedure SetDown(const Value: Boolean);
    procedure SetLeftShoulder(const Value: Boolean);
    procedure SetRightShoulder(const Value: Boolean);
    procedure SetLeftTrigger(const Value: Integer);
    procedure SetRightTrigger(const Value: Integer);
    procedure SetLX(const Value: single);
    procedure SetLY(const Value: single);
    procedure SetRX(const Value: single);
    procedure SetRY(const Value: single);
    procedure SetWantRepeat(const Value: Boolean);
  public
    constructor Create;
    procedure Loop;
    procedure Reset;

    property Back: Boolean read FBack write SetBack;
    property Start: Boolean read FStart write SetStart;

    property A: Boolean read FA write SetA;
    property B: Boolean read FB write SetB;
    property X: Boolean read FX write SetX;
    property Y: Boolean read FY write SetY;

    property Left: Boolean read FLeft write SetLeft;
    property Right: Boolean read FRight write SetRight;
    property Up: Boolean read FUp write SetUp;
    property Down: Boolean read FDown write SetDown;

    property LeftShoulder: Boolean read FLeftShoulder write SetLeftShoulder;
    property RightShoulder: Boolean read FRightShoulder write SetRightShoulder;

    property LeftTrigger: Integer read FLeftTrigger write SetLeftTrigger;
    property RightTrigger: Integer read FRightTrigger write SetRightTrigger;

    property LX: single read FLX write SetLX;
    property LY: single read FLY write SetLY;

    property RX: single read FRX write SetRX;
    property RY: single read FRY write SetRY;

    property WantRepeat: Boolean read FWantRepeat write SetWantRepeat;
  end;

implementation

{ TGamePad }

constructor TGamePad.Create;
begin

end;

procedure TGamePad.Loop;
begin

end;

procedure TGamePad.Reset;
begin
  FA := False;
  FB := False;
  FX := False;
  FY := False;

  FLeft := False;
  FRight := False;
  FUp := False;
  FDown := False;

  FBack := False;
  FStart := False;

  FLeftShoulder := False;
  FRightShoulder := False;

  FLeftTrigger := 0;
  FRightTrigger := 0;

  FLX := 0;
  FLY := 0;
  FRX := 0;
  FRY := 0;
end;

procedure TGamePad.SetA(const Value: Boolean);
begin
  FA := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetB(const Value: Boolean);
begin
  FB := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetBack(const Value: Boolean);
begin
  FBack := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetDown(const Value: Boolean);
begin
  FDown := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetLeft(const Value: Boolean);
begin
  FLeft := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetLeftShoulder(const Value: Boolean);
begin
  FLeftShoulder := Value;
  FWantRepeat := Value;
end;

procedure TGamePad.SetLeftTrigger(const Value: Integer);
begin
  FLeftTrigger := Value;
  FWantRepeat := Value <> 0;
end;

procedure TGamePad.SetLX(const Value: single);
begin
  FLX := Value;
  FWantRepeat := Abs(Value) > 0.1;
end;

procedure TGamePad.SetLY(const Value: single);
begin
  FLY := Value;
  FWantRepeat := Abs(Value) > 0.1;
end;

procedure TGamePad.SetRight(const Value: Boolean);
begin
  FRight := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetRightShoulder(const Value: Boolean);
begin
  FRightShoulder := Value;
  FWantRepeat := Value;
end;

procedure TGamePad.SetRightTrigger(const Value: Integer);
begin
  FRightTrigger := Value;
  FWantRepeat := Value <> 0;
end;

procedure TGamePad.SetRX(const Value: single);
begin
  FRX := Value;
  FWantRepeat := Abs(Value) > 0.1;
end;

procedure TGamePad.SetRY(const Value: single);
begin
  FRY := Value;
  FWantRepeat := Abs(Value) > 0.1;
end;

procedure TGamePad.SetStart(const Value: Boolean);
begin
  FStart := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetUp(const Value: Boolean);
begin
  FUp := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetWantRepeat(const Value: Boolean);
begin
  FWantRepeat := Value;
end;

procedure TGamePad.SetX(const Value: Boolean);
begin
  FX := Value;
  FWantRepeat := False;
end;

procedure TGamePad.SetY(const Value: Boolean);
begin
  FY := Value;
  FWantRepeat := False;
end;

end.
