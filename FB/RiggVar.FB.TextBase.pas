unit RiggVar.FB.TextBase;

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
  System.Types,
  System.UITypes,
  FMX.Layouts,
  FMX.Types,
  FMX.Objects,
  FMX.Edit,
  RiggVar.FB.Def;

type
  TFederTouch0 = class(TLayout)
  protected
    FTransitBarLayout: Integer;
    FActionMap: Integer;
    FActionPage: Integer;
    FFrameVisible: Boolean;
    function GetActionMap: Integer; virtual;
    function GetActionPage: Integer; virtual;
    function GetFrameVisible: Boolean; virtual;
    procedure SetActionMap(const Value: Integer); virtual;
    procedure SetActionPage(const Value: Integer); virtual;
    procedure SetFrameVisible(const Value: Boolean); virtual;
    procedure SetTransitBarLayout(const Value: Integer); virtual;
  public
    InitOK: Boolean;

    constructor Create(AOwner: TComponent); override;
    procedure Init; virtual;

    procedure ToggleTouchFrame; virtual;
    procedure UpdateText; virtual;

    procedure UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus); virtual;
    procedure UpdateTextQuick; virtual;

    property ActionMap: Integer read GetActionMap write SetActionMap;
    property ActionPage: Integer read GetActionPage write SetActionPage;
    property FrameVisible: Boolean read GetFrameVisible write SetFrameVisible;
    property TransitBarLayout: Integer read FTransitBarLayout write SetTransitBarLayout;
  end;

implementation

{ TFederTouch0 }

constructor TFederTouch0.Create(AOwner: TComponent);
begin
  inherited;
  FFrameVisible := True;
end;

function TFederTouch0.GetActionMap: Integer;
begin
  result := FActionMap;
end;

function TFederTouch0.GetActionPage: Integer;
begin
  result := FActionPage;
end;

function TFederTouch0.GetFrameVisible: Boolean;
begin
  result := FFrameVisible;
end;

procedure TFederTouch0.SetFrameVisible(const Value: Boolean);
begin
  FFrameVisible := Value;
end;

procedure TFederTouch0.SetActionMap(const Value: Integer);
begin
  FActionMap := Value;
end;

procedure TFederTouch0.SetActionPage(const Value: Integer);
begin
  FActionPage := Value;
end;

procedure TFederTouch0.ToggleTouchFrame;
begin
  { virtual }
end;

procedure TFederTouch0.UpdateText;
begin
  { virtual }
end;

procedure TFederTouch0.Init;
begin
  { virtual }
end;

procedure TFederTouch0.SetTransitBarLayout(const Value: Integer);
begin
  FTransitBarLayout := Value;
end;

procedure TFederTouch0.UpdateTextQuick;
begin
  { virtual }
end;

procedure TFederTouch0.UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus);
begin
  { virtual }
end;

end.
