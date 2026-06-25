unit RiggVar.FB.Text;

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
  System.UITypes,
  RiggVar.FB.Def,
  RiggVar.FB.TextBase;

type
  TFederTextDataQuick = record
  public
    TempoText: string;
    SB00: string;
    RecorderLine: string;
  end;

  TFederTextDataPhone = record
  public
    Line1: string;
    Line2: string;
    Line3: string;

    Line6: string;
    Line5: string;
    Line4: string;

    SL00: string;
    SR00: string;
    ST00: string;
    SB00: string;

    HelpFlash: Boolean;
  end;

  TFederTextData = record
  public
    Spruch: string;
    MsgText: string;

    ParamText: string;
    ValueText: string;
    TempoText: string;

    HubText: string;
    SampleText: string;
    PlotText: string;

    MilliesLine: string;
    StatusLine: string;
    OptionLine: string;
    EquationLine: string;
    RecorderLine: string;
    ConnectionLine: string;

    SL00: string;
    SR00: string;
    ST00: string;
    SB00: string;

    EquationText: string;

    HelpFlash: Boolean;
  end;

  TFederText1 = class(TFederTouch0)
  private
    FSwatColor: TAlphaColor;
  protected
    FTitleVisible: Boolean;
    FAllVisible: Boolean;
    FMenuVisible: Boolean;
    FEquationVisible: Boolean;
    FTextVisible: Boolean;
    FSwatVisible: Boolean;
    FFlashCaption: string;

    function GetFlashCaption: string; virtual;
    function GetEquationVisible: Boolean; virtual;
    function GetAllVisible: Boolean; virtual;
    function GetMenuVisible: Boolean; virtual;
    function GetTextVisible: Boolean; virtual;
    function GetTitleVisible: Boolean; virtual;
    function GetSwatVisible: Boolean; virtual;
    function GetSwatColor: TAlphaColor; virtual;

    procedure SetFlashCaption(const Value: string); virtual;
    procedure SetAllVisible(const Value: Boolean); virtual;
    procedure SetEquationVisible(const Value: Boolean); virtual;
    procedure SetMenuVisible(const Value: Boolean); virtual;
    procedure SetTextVisible(const Value: Boolean); virtual;
    procedure SetTitleVisible(const Value: Boolean); virtual;
    procedure SetSwatVisible(const Value: Boolean); virtual;
    procedure SetSwatColor(const Value: TAlphaColor); virtual;
  public
    OwnsMouse: Boolean;

    procedure ToggleAllText; virtual;
    procedure ToggleTouchMenu; virtual;
    procedure ToggleEquationText; virtual;
    procedure TogglePrimeText; virtual;
    procedure ToggleSecondText; virtual;

    procedure ClearFlash; virtual;

    property AllVisible: Boolean read GetAllVisible write SetAllVisible;
    property MenuVisible: Boolean read GetMenuVisible write SetMenuVisible;
    property EquationVisible: Boolean read GetEquationVisible write SetEquationVisible;
    property TitleVisible: Boolean read GetTitleVisible write SetTitleVisible;
    property TextVisible: Boolean read GetTextVisible write SetTextVisible;
    property FlashCaption: string read GetFlashCaption write SetFlashCaption;

    property SwatVisible: Boolean read GetSwatVisible write SetSwatVisible;
    property SwatColor: TAlphaColor read GetSwatColor write SetSwatColor;
  end;

  TFederText = TFederText1;

implementation

{ TFederText1 }

function TFederText1.GetAllVisible: Boolean;
begin
  result := FAllVisible;
end;

function TFederText1.GetEquationVisible: Boolean;
begin
  result := FEquationVisible;
end;

function TFederText1.GetMenuVisible: Boolean;
begin
  result := FMenuVisible;
end;

function TFederText1.GetSwatColor: TAlphaColor;
begin
  result := FSwatColor;
end;

function TFederText1.GetSwatVisible: Boolean;
begin
  result := FSwatVisible;
end;

function TFederText1.GetTextVisible: Boolean;
begin
  result := FTextVisible;
end;

function TFederText1.GetTitleVisible: Boolean;
begin
  result := FTitleVisible;
end;

function TFederText1.GetFlashCaption: string;
begin
  result := FFlashCaption;
end;

procedure TFederText1.SetAllVisible(const Value: Boolean);
begin
  FAllVisible := Value;
end;

procedure TFederText1.SetEquationVisible(const Value: Boolean);
begin
  FEquationVisible := Value;
end;

procedure TFederText1.SetFlashCaption(const Value: string);
begin
  FFlashCaption := Value;
end;

procedure TFederText1.SetMenuVisible(const Value: Boolean);
begin
  FMenuVisible := Value;
end;

procedure TFederText1.SetSwatColor(const Value: TAlphaColor);
begin
  FSwatColor := Value;
end;

procedure TFederText1.SetSwatVisible(const Value: Boolean);
begin
  FSwatVisible := Value;
end;

procedure TFederText1.SetTextVisible(const Value: Boolean);
begin
  FTextVisible := Value;
end;

procedure TFederText1.SetTitleVisible(const Value: Boolean);
begin
  FTitleVisible := Value;
end;

procedure TFederText1.ToggleAllText;
begin
  { virtual }
end;

procedure TFederText1.ToggleEquationText;
begin
  { virtual }
end;

procedure TFederText1.TogglePrimeText;
begin
  { virtual }
end;

procedure TFederText1.ToggleSecondText;
begin
  { virtual }
end;

procedure TFederText1.ToggleTouchMenu;
begin
  { virtual }
end;

procedure TFederText1.ClearFlash;
begin
  { virtual }
end;

end.
