unit RiggVar.Anim.Player;

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
  FMX.Ani,
  RiggVar.Col.Animation,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Def,
  RiggVar.FB.Trackbar;

type
  TAnimationPlayer = class
  private
    FStopping: Boolean;
    FParam: Integer;
    FStartValue: single;
    FStopValue: single;
    FTrackbar: TFederTrackbar;
    procedure PlayAnimation;
    procedure PlayOne;
    procedure AnimationFinished(Sender: TObject);
    function GetCurrentAnimation: TFloatAnimation;
    procedure PlayDiscrete(cr: TAnimationRowCollectionItem);
    procedure PlayFloat;
    procedure PlayStop;
    function GetIsPlaying: Boolean;
    procedure TrackbarChange(Sender: TObject);
  public
    Speed: single;
    NeedTrackbarHighFrequency: Boolean;
    PlayingIndex: Integer;
    Playing: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Calc;
    procedure Stop;
    property CurrentAnimation: TFloatAnimation read GetCurrentAnimation;
    property IsPlaying: Boolean read GetIsPlaying;
  end;

implementation

uses
  FrmMain,
  RiggVar.App.Main;

function TAnimationPlayer.GetCurrentAnimation: TFloatAnimation;
var
  cr: TAnimationRowCollectionItem;
begin
  result := nil;
  if Playing and (PlayingIndex >= 0) then
  begin
    cr := Main.AnimationData.Find(PlayingIndex);
    if (cr <> nil) then
      result := cr.Animation as TFloatAnimation;
  end;
end;

function TAnimationPlayer.GetIsPlaying: Boolean;
begin
  result := NeedTrackbarHighFrequency;
end;

procedure TAnimationPlayer.Calc;
var
  a: TFloatAnimation;
begin
  { come in here if GO was sent to toggle animation on/off }
  if FTrackbar <> nil then
  begin
    if Playing then
    begin
      a := CurrentAnimation;
      if a <> nil then
      begin
        { GO without prior NS (NewStory) }
        Playing := False;
        { just stop (probably looping) animation and exit }
        a.Stop;
      end
      else
      begin
        { GO after NS (NewStory) }
        Playing := False;
        { start new batch of animations, already assembled in collection }
        PlayAnimation;
        { previously existing items/animations have already been deleted (and stopped)
          when NS was received }
      end;
    end
    else // if not Playing then
    begin
      { start first batch or restart existing finished batched }
      PlayAnimation;
    end;
  end;
  { note: Modified is not used here }
  Main.AnimationData.Modified := False;
end;

constructor TAnimationPlayer.Create;
begin
  Speed := 1;
  FTrackbar := TFederTrackbar.Create(FormMain);
  FTrackbar.Name := 'Trackbar';
  FTrackbar.Parent := FormMain.ContentParent;
  FTrackbar.OnChange := TrackbarChange;
end;

destructor TAnimationPlayer.Destroy;
begin
  Stop;
  FTrackbar.Free;
  inherited;
end;

procedure TAnimationPlayer.PlayAnimation;
begin
  { start the playlist }
  if Main.AnimationData.Count > 0 then
  begin
    PlayingIndex := 0;
    PlayOne;
  end;
end;

procedure TAnimationPlayer.PlayOne;
var
  cr: TAnimationRowCollectionItem;
begin
  if (PlayingIndex < 0) or (PlayingIndex >= Main.AnimationData.Count) then
    Exit;

  cr := Main.AnimationData.Find(PlayingIndex);
  if cr = nil then
    Exit;

  if cr.Param = 0 then
  begin
    PlayDiscrete(cr);
    { do not change, except after loading sample, see PlayDiscrete  }
    FStartValue := FTrackbar.Value;
    FStopValue := FStartValue;
  end
  else
  begin
    FParam := cr.Param;
    FStartValue := cr.StartValue;
    FStopValue := cr.StopValue;
  end;

  PlayFloat;
end;

procedure TAnimationPlayer.PlayDiscrete(cr: TAnimationRowCollectionItem);
var
  mk: TFederMessageKind;
  mv: Integer;
begin
  mk := TFederMessageKind(cr.StopValue);
  mv := cr.StartValue;
  cr.Loop := 0;
  cr.AutoReverse := 0;
  cr.FromCurrent := 0;
  cr.AnimationType := 0;
  cr.InterpolationType := 0;

  case mk of
    fmkScene: Main.SceneChanged(mv-1);
    fmkGraph: Main.GraphChanged(mv-1);
    fmkFigure: Main.FigureChanged(mv-1);
    fmkBitmap: Main.BitmapChanged(mv-1);
    fmkColor: Main.ColorChanged(mv-1);
    fmkParam: ;
    fmkParamValue: ;
    fmkMinusCap: Main.MinusCapChanged(mv = 1);
    fmkPlusCap: Main.PlusCapChanged(mv = 1);
    fmkMeshSize: Main.DensityChanged(mv);
    fmkAction:
    begin
      if mv = Integer(faReset) then
        Main.ResetRequested;
    end;
    fmkSample:
    begin
      Main.GotoSample(mv);
      FParam := Main.FederData.Param; // update FParam, may have changed in GotoSample
    end;
  end;
end;

procedure TAnimationPlayer.PlayFloat;
var
  cr: TAnimationRowCollectionItem;
  a: TFloatAnimation;
begin
  if FTrackbar = nil then
    Exit;

  FTrackbar.Frequency := MainConst.TrackbarFrequency;
  NeedTrackbarHighFrequency := True;
  cr := Main.AnimationData.Find(PlayingIndex);
  if cr = nil then
    Exit;

  { set Param }
  Main.ParamChanged(FParam - 1);

  FTrackbar.Min := -1000;
  FTrackbar.Max := 1000;
  FTrackbar.Value := Main.FederModel.ParamValue;

  { ensure Animation }
  if cr.Animation = nil then
  begin
    a := TFloatAnimation.Create(nil);
    cr.Animation := a;
    FTrackbar.AddObject(a);
  end;
  a := cr.Animation as TFloatAnimation;

  { animate ParamValue in Trackbar }
  a.PropertyName := 'Value';

  a.AnimationType := TAnimationType(cr.AnimationType);
  a.Interpolation := TInterpolationType(cr.InterpolationType);
  a.StartValue := FStartValue;
  a.StopValue := FStopValue;
  a.Duration := Speed * cr.Duration;
  a.AutoReverse := cr.AutoReverse = 1;
  a.Loop := cr.Loop = 1;
  a.StartFromCurrent := cr.FromCurrent = 1;

  a.OnFinish := AnimationFinished;
  Playing := True;
  a.Start;
end;

procedure TAnimationPlayer.AnimationFinished(Sender: TObject);
begin
  Inc(PlayingIndex);
  if FStopping or (PlayingIndex >= Main.AnimationData.Count) then
  begin
    PlayStop;
  end
  else
  begin
    { play next one }
    PlayOne;
  end;
end;

procedure TAnimationPlayer.PlayStop;
begin
  PlayingIndex := -1;
  Playing := False;
  NeedTrackbarHighFrequency := False;
  if Main <> nil then
    Main.HandleAction(faAnimationStop);
end;

procedure TAnimationPlayer.Stop;
var
  cr: TAnimationRowCollectionItem;
begin
  if not MainVar.AppIsClosing then
  begin
    if Main.AnimationData <> nil then
    begin
      cr := Main.AnimationData.Find(PlayingIndex);
      if (cr <> nil) and (cr.Animation <> nil) then
      begin
        FStopping := True;
        cr.Animation.Stop;
        FStopping := False;
      end;
    end;
  end;
end;

procedure TAnimationPlayer.TrackbarChange(Sender: TObject);
begin
  if Main.IsUp then
  begin
    Main.Trackbar_Value := FTrackbar.Value;
    Main.ParamValueChanged(Main.Trackbar_Value);

    if not Main.FederModel.Loading then
      Main.GraphUpdateNeeded;
  end;
end;

end.
