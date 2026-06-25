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
  FMX.Controls,
  FMX.Edit,
  RiggVar.FB.Def;

type
  TFederTextSimpleBase = class
  public
    Position: TPosition;
    Width: single;
    Height: single;
    Visible: Boolean;
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
  end;

  TFederTextObjectBase = class(TFmxObject)
  public
    Position: TPosition;
    Width: single;
    Height: single;
    Visible: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

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
    procedure SetHelpCaption(const Value: string); virtual;
    procedure SetOptionCaption(const Value: string); virtual;
    procedure SetComboCaption(const Value: string); virtual;
  public
    PagerText: TText;
    TableText: TText;
    OutplaceText: TText;
    OutplaceEdit: TEdit;
    InplaceRect: TRectangle;
    TableRect: TRectangle;

    InitOK: Boolean;

    constructor Create(AOwner: TComponent); override;
    procedure Init; virtual;

    procedure ToggleTouchFrame; virtual;
    procedure UpdateText; virtual;

    procedure HideRect;
    procedure HideInplaceRect;
    procedure HideTableRect;

    procedure DoAnim; virtual;

    procedure UpdatePagerText; virtual;
    procedure UpdateTableText; virtual;
    procedure UpdateTableRect; virtual;
    procedure AlignTableText; virtual;

    procedure UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus); virtual;
    procedure UpdateTextQuick; virtual;

    property ActionMap: Integer read GetActionMap write SetActionMap;
    property ActionPage: Integer read GetActionPage write SetActionPage;
    property FrameVisible: Boolean read GetFrameVisible write SetFrameVisible;
    property HelpCaption: string write SetHelpCaption;
    property OptionCaption: string write SetOptionCaption;
    property ComboCaption: string write SetComboCaption;
    property TransitBarLayout: Integer read FTransitBarLayout write SetTransitBarLayout;
  end;

implementation

{ TFederTextObjectBase }

constructor TFederTextObjectBase.Create(AOwner: TComponent);
begin
  inherited;
  Position := TPosition.Create(TPointF.Create(0, 0));
end;

destructor TFederTextObjectBase.Destroy;
begin
  Position.Free;
  inherited;
end;

{ TFederTextSimpleBase }

constructor TFederTextSimpleBase.Create(AOwner: TComponent);
begin
  inherited Create;
  Position := TPosition.Create(TPointF.Create(0, 0));
end;

destructor TFederTextSimpleBase.Destroy;
begin
  Position.Free;
  inherited;
end;

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

procedure TFederTouch0.SetHelpCaption(const Value: string);
begin
  { virtual }
end;

procedure TFederTouch0.SetOptionCaption(const Value: string);
begin
  { virtual }
end;

procedure TFederTouch0.SetTransitBarLayout(const Value: Integer);
begin
  FTransitBarLayout := Value;
end;

procedure TFederTouch0.SetComboCaption(const Value: string);
begin
  { virtual }
end;

procedure TFederTouch0.UpdateTextQuick;
begin
  { virtual }
end;

procedure TFederTouch0.UpdateLED(Host, Port, Counter, Msg: string; Status: TConnectionStatus);
begin
  { virtual }
end;

procedure TFederTouch0.AlignTableText;
begin
  { virtual }
end;

procedure TFederTouch0.DoAnim;
begin
  { virtual }
end;

procedure TFederTouch0.UpdatePagerText;
begin
  { virtual }
end;

procedure TFederTouch0.UpdateTableText;
begin
  { virtual }
end;

procedure TFederTouch0.UpdateTableRect;
begin
  { virtual }
end;

procedure TFederTouch0.HideRect;
begin
  HideInplaceRect;
  HideTableRect;
end;

procedure TFederTouch0.HideInplaceRect;
begin
  if InitOK then
  begin
    if Assigned(InplaceRect) then
    begin
      { can be nil if IsPhone }
      InplaceRect.Position.X := -100;
      InplaceRect.Position.Y := -100;
      InplaceRect.Width := 10;
      InplaceRect.Height := 10;
    end;
    if Assigned(OutplaceText) then
      OutplaceText.Text := '';
  end;
end;

procedure TFederTouch0.HideTableRect;
begin
  if InitOK then
  begin
    if Assigned(TableRect) then
    begin
      { can be nil if IsPhone }
      TableRect.Position.X := -100;
      TableRect.Position.Y := -100;
      TableRect.Width := 10;
      TableRect.Height := 10;
    end;
  end;
end;

end.
