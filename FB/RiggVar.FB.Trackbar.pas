unit RiggVar.FB.Trackbar;

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
  SysUtils,
  System.Classes,
  System.UITypes,
  FMX.Controls,
  RiggVar.FB.DefConst;

type
  { Minimal Trackbar control.
    Need to inherit from TControl when animation is not used. }
  TFederTrackbar = class(TControl)
  private
    FValueOld: single;
    FValue: single;
    procedure SetValue(const AValue: single);
  public
    Min: single;
    Max: single;
    Frequency: single;
    LineSize: single;
    PageSize: single;
    OnChange: TNotifyEvent;
    Tracking: Boolean;
  published
    property Value: single read FValue write SetValue;
    property ValueNoChange: single read FValue write FValue;
  end;

  { Extended Trackbar object.
    No need to inherit from TControl when animation is not used }
  TTrackbarObject = class
  private
    FValueOld: single;
    FValue: single;
    procedure SetValue(const AValue: single);
  public
    Min: single;
    Max: single;
    Frequency: single;
    LineSize: single;
    PageSize: single;
    OnChange: TNotifyEvent;
    Tracking: Boolean;
    property Value: single read FValue write SetValue;
    property ValueNoChange: single read FValue write FValue;
  end;

implementation

{ TFederTrackbar }

procedure TFederTrackbar.SetValue(const AValue: single);
begin
  if (AValue <= Min) then
    FValue := Min
  else if AValue >= Max then
    FValue := Max
  else
    FValue := AValue;

  if (FValueOld <> FValue) and Assigned(OnChange) then
  begin
    FValueOld := FValue;
    OnChange(self);
  end;
end;

{ TTrackbarObject }

procedure TTrackbarObject.SetValue(const AValue: single);
begin
  if (AValue <= Min) then
    FValue := Min
  else if AValue >= Max then
    FValue := Max
  else
    FValue := AValue;

  if (FValueOld <> FValue) and Assigned(OnChange) then
  begin
    FValueOld := FValue;
    OnChange(self);
  end;
end;

end.
