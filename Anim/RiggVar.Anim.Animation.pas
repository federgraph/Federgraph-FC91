unit RiggVar.Anim.Animation;

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
  System.Classes,
  FMX.Controls,
  FMX.Types,
  FMX.Ani;

type
  TAnimSource = class(TFmxObject)
  private
    FValue: single;
    FOnChange: TNotifyEvent;
    procedure SetValue(const Value: single);
    procedure SetOnChange(const Value: TNotifyEvent);
  public
    Max: single;
    Min: single;
    Frequency: single;
    constructor Create(AOwner: TComponent); override;
  published
    property Value: single read FValue write SetValue;
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

  TFederAnimation = class
  private
    AlreadyCalled: Boolean;
    AnimationActive: Boolean;
    AnimationPaused: Boolean;
    OldValue: Single;
    fa: TFloatAnimation; // ParamValue, Elongation Foreward
    fb: TFloatAnimation; // ParamAlue, Elongation Backward
    fc: TFloatAnimation; // ParamValue, Animation
    fd: TFloatAnimation; // RotationAngle.Y
    FDuration: single;
    procedure AnimationFinishedA(Sender: TObject);
    procedure AnimationFinishedB(Sender: TObject);
    procedure SetupAnimationA(d: single);
    procedure SetupAnimationB(d: single);
    procedure SetupAnimationC(d: single);
    procedure SetupAnimationD;
    procedure SetDuration(const Value: single);
    function GetDuration: single;
  public
    Trackbar: TAnimSource;
    PauseBtn: TControl;
    AnimBtn: TControl;
    ElongBtn: TControl;
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    procedure Reset;
    procedure StartRotation;
    procedure Stop;
    procedure AnimBtnClick(Sender: TObject);
    procedure ElongBtnClick(Sender: TObject);
    procedure PauseBtnClick(Sender: TObject);
    property Duration: single read GetDuration write SetDuration;
  end;

implementation

uses
  RiggVar.App.Main;

{ TAnimSource }

constructor TAnimSource.Create(AOwner: TComponent);
begin
  inherited;
  Stored := False;
  Min := -1000;
  Max := 1000;
  Frequency := 1;
end;

procedure TAnimSource.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TAnimSource.SetValue(const Value: single);
begin
  FValue := Value;
  if Assigned(FOnChange) then
    FOnChange(self);
end;

{ TFederAnimation }

constructor TFederAnimation.Create;
begin
  Duration := 1.0;
end;

destructor TFederAnimation.Destroy;
begin
  if (fa <> nil) then
  begin
    Stop;
    fa.Free;
    fb.Free;
    fc.Free;
    fd.Free;
  end;
  inherited;
end;

procedure TFederAnimation.Init;
begin
  if not AlreadyCalled then
  begin
    fa := TFloatAnimation.Create(nil);
    fb := TFloatAnimation.Create(nil);
    fc := TFloatAnimation.Create(nil);
    fd := TFloatAnimation.Create(nil);

    Trackbar.AddObject(fa);
    Trackbar.AddObject(fb);
    Trackbar.AddObject(fc);
    fd.Parent := Main.Viewport;

    fa.OnFinish := AnimationFinishedA;
    fb.OnFinish := AnimationFinishedB;

    ElongBtn.OnClick := ElongBtnClick;
    AnimBtn.OnClick := AnimBtnClick;
    PauseBtn.OnClick := PauseBtnClick;

    PauseBtn.Enabled := False;
    SetupAnimationD;
  end;
end;

procedure TFederAnimation.ElongBtnClick(Sender: TObject);
begin
  if not fa.Enabled then
  begin
    ElongBtn.Enabled := false;
    AnimBtn.Enabled := false;
    SetupAnimationA(10);
    fa.Start;
  end;
end;

function TFederAnimation.GetDuration: single;
begin
  result := FDuration * 4;
end;

procedure TFederAnimation.AnimBtnClick(Sender: TObject);
begin
  AnimationActive := not AnimationActive;
  if AnimationActive then
  begin
    OldValue := Trackbar.Value;
    AnimationPaused := False;
    SetupAnimationC(10);
    fc.Pause := False;
    fc.Enabled := True;
    ElongBtn.Enabled := false;
    PauseBtn.Enabled := true;
  end
  else
  begin
    fc.Stop;
    fc.Pause := False;
    fc.Enabled := false;
    fc.StartValue := OldValue;
    fc.StopValue := OldValue + 10;
    Trackbar.Value := OldValue;
    ElongBtn.Enabled := true;
    PauseBtn.Enabled := false;
  end;
end;

procedure TFederAnimation.PauseBtnClick(Sender: TObject);
begin
  AnimationPaused := not AnimationPaused;
  if AnimationPaused then
  begin
    fc.Pause := True;
  end
  else
  begin
    fc.Pause := False;
  end;
end;

procedure TFederAnimation.Reset;
begin
  SetupAnimationD;
end;

procedure TFederAnimation.SetDuration(const Value: single);
begin
  FDuration := Value / 4;
end;

procedure TFederAnimation.SetupAnimationA(d: single);
begin
  if (Trackbar.Max - Trackbar.Value > d)
    and (Trackbar.Value - Trackbar.Min > d)
  then
  begin
    Trackbar.Frequency := 0.1;
    fa.AnimationType := TAnimationType.InOut;
    fa.Interpolation := TInterpolationType.Sinusoidal;
    fa.PropertyName := 'Value';
    fa.StartFromCurrent := true;
    fa.StopValue := Trackbar.Value + d;
    fa.Duration := Duration;
    fa.AutoReverse := False;
    fa.Loop := false;
  end;
end;

procedure TFederAnimation.SetupAnimationB(d: single);
begin
  if Trackbar.Value - Trackbar.Min > d then
  begin
    Trackbar.Frequency := 0.1;
    fb.AnimationType := TAnimationType.InOut;
    fb.Interpolation := TInterpolationType.Sinusoidal;
    fb.PropertyName := 'Value';
    fb.StartFromCurrent := true;
    fb.StopValue := Trackbar.Value - d;
    fb.Duration := Duration;
    fb.AutoReverse := false;
    fb.Loop := false;
  end;
end;

procedure TFederAnimation.SetupAnimationC(d: single);
begin
  if (Trackbar.Max - Trackbar.Value > d)
    and (Trackbar.Value - Trackbar.Min > d)
  then
  begin
    Trackbar.Frequency := 0.1;
    fc.AnimationType := TAnimationType.InOut;
    fc.Interpolation := TInterpolationType.Back;
    fc.PropertyName := 'Value';
    fc.StartFromCurrent := false;
    fc.StartValue := OldValue;
    fc.StopValue := OldValue + d;
    fc.Duration := 1.5;
    fc.AutoReverse := true;
    fc.Loop := true;
    fc.Inverse := false;
  end;
end;

procedure TFederAnimation.SetupAnimationD;
begin
  fd.AnimationType := TAnimationType.InOut;
  fd.Interpolation := TInterpolationType.Back;
  fd.PropertyName := 'RotationAngle.Y';
  fd.StartFromCurrent := true;
  fd.StopValue := 360.0;
  fd.Duration := 10.0;
  fd.AutoReverse := true;
  fd.Loop := false;
end;

procedure TFederAnimation.StartRotation;
begin
  fd.Start;
end;

procedure TFederAnimation.AnimationFinishedA(Sender: TObject);
begin
  fa.Enabled := false;
  SetupAnimationB(10);
  fb.Start;
end;

procedure TFederAnimation.AnimationFinishedB(Sender: TObject);
begin
  ElongBtn.Enabled := true;
  AnimBtn.Enabled := true;
  fb.Enabled := False;
end;

procedure TFederAnimation.Stop;
begin
  if (fa <> nil) then
  begin
    fa.Stop;
    fb.Stop;
    fc.Stop;
    fd.Stop;
    fa.Enabled := False;
    fb.Enabled := False;
    fc.Enabled := False;
    fd.Enabled := False;
  end;
end;

end.
