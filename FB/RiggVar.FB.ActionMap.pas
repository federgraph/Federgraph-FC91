unit RiggVar.FB.ActionMap;

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
  System.UIConsts,
  System.Classes,
  System.UITypes,
  RiggVar.FB.Color;

type
  ActionColors = record
  const
    { often used colors }
    Noop = TWebColors.White;
    Page = TWebColors.Yellow;
    Param = TWebColors.Plum;
    Option = TWebColors.Cornflowerblue;
    Sample = TWebColors.Aquamarine;
    Form = TWebColors.Cornflowerblue;

    { preferred colors }
    White = TWebColors.White;
    Beige = TWebColors.Beige;
    Plum = TWebColors.Plum;
    Cornflowerblue = TWebColors.Cornflowerblue;

    { also used colors }
    Antiquewhite = TWebColors.Antiquewhite;
    Khaki = TWebColors.Khaki;
    Darksalmon = TWebColors.Darksalmon;
    Darkkhaki = TWebColors.Darkkhaki;
    Coral = TWebColors.Coral;
    Dodgerblue = TWebColors.Dodgerblue;
    Yellow = TWebColors.Yellow;
  end;

  TCornerLocation = (TopLeft, TopRight, BottomRight, BottomLeft);
  TInitActionProc = procedure (BtnID: Integer; Action: Integer) of object;
  TInitActionColorProc = procedure (BtnID: Integer; Action: Integer; cla: TAlphaColor) of object;

  TActionInfo = record
    Page: Integer;
    Corner: TCornerLocation;
    Position: Integer;
    Action: Integer;
    Color: TAlphaColor;
  end;

  TActionMapBase = class
  private
    FActionProc: TInitActionProc;
    FActionColorProc: TInitActionColorProc;
    procedure SetActionColorProc(const Value: TInitActionColorProc);
    procedure SetActionProc(const Value: TInitActionProc);
    procedure SetPageCount(const Value: Integer);
  protected
    FPageCount: Integer;
    TestName: string;
    ColorAccent: TAlphaColor;
    ColorTest: TAlphaColor;
    ColorPage: TAlphaColor;
    procedure InitAction(BtnID: Integer; Action: Integer);
    procedure IAC(BtnID, Action: Integer; cla: TAlphaColor); virtual;
  public
    class var
      CurrentPageCaption: string;
      CurrentPageCaptionPhone: string;
      CurrentMenuCaptions: array[0..9] of string;

    constructor Create;
    procedure InitActions(Layout: Integer); virtual;
    procedure InitActionFromInfo(ActionInfo: TActionInfo); virtual;
    property ActionProc: TInitActionProc read FActionProc write SetActionProc;
    property ActionColorProc: TInitActionColorProc read FActionColorProc write SetActionColorProc;
    property PageCount: Integer read FPageCount write SetPageCount;
  end;

  TCollectibleActionMap = class(TActionMapBase)
  private
    procedure TestProcAll(BtnID, Action: Integer);
    procedure TestProcOne(BtnID, Action: Integer);
    procedure DoCollectMappings;
    procedure TestProcOneIAC(BtnID, Action: Integer; cla: TAlphaColor);
    procedure TestProcAllIAC(BtnID, Action: Integer; cla: TAlphaColor);
  protected
    TestAction: Integer;
    TestPage: Integer;
    TestList: TStrings;
    TestProc: TInitActionProc;
    TestProcIAC: TInitActionColorProc;
  public
    procedure CollectOne(fa: Integer; ML: TStrings);
    procedure CollectAll(ML: TStrings);
  end;

  TEscapableActionMap = class(TCollectibleActionMap)
  private
    function GetEscapeIndex: Integer;
    procedure SetEscapeIndex(const Value: Integer);
    procedure SetMaxIndex(const Value: Integer);
    function GetMaxIndex: Integer;
  protected
    FMaxIndex: Integer;
    FEscapeIndex: Integer;
  public
    constructor Create;
    property MaxIndex: Integer read GetMaxIndex write SetMaxIndex;
    property EscapeIndex: Integer read GetEscapeIndex write SetEscapeIndex;
  end;

  TActionMap = TEscapableActionMap;

implementation

uses
  RiggVar.FB.ActionShort,
  RiggVar.FB.ActionLong;

{ TActionMapBase }

procedure TActionMapBase.InitActions(Layout: Integer);
begin
  { virtual }
end;

constructor TActionMapBase.Create;
begin
  FPageCount := 1;
  ColorAccent := claDodgerBlue;
  ColorTest := claWhite;
  ColorPage := claYellow;
end;

procedure TActionMapBase.InitAction(BtnID, Action: Integer);
begin
  if Assigned(ActionProc) then
    ActionProc(BtnID, Action);
end;

procedure TActionMapBase.InitActionFromInfo(ActionInfo: TActionInfo);
begin
  { virtual }
end;

procedure TActionMapBase.IAC(BtnID, Action: Integer; cla: TAlphaColor);
begin
  if Assigned(ActionColorProc) then
    ActionColorProc(BtnID, Action, cla);
end;

procedure TActionMapBase.SetActionColorProc(const Value: TInitActionColorProc);
begin
  FActionColorProc := Value;
end;

procedure TActionMapBase.SetActionProc(const Value: TInitActionProc);
begin
  FActionProc := Value;
end;

procedure TActionMapBase.SetPageCount(const Value: Integer);
begin
  FPageCount := Value;
end;

{ TEscapableActionMap }

constructor TEscapableActionMap.Create;
begin
  inherited;
  FEscapeIndex := 2;
end;

function TEscapableActionMap.GetEscapeIndex: Integer;
begin
  if FEscapeIndex <= 0 then
    result := FPageCount + 1
  else if FEscapeIndex > FPageCount + 1 then
    result := FPageCount + 1
  else
    result := FEscapeIndex;
end;

procedure TEscapableActionMap.SetEscapeIndex(const Value: Integer);
begin
  FEscapeIndex := Value;
end;

function TEscapableActionMap.GetMaxIndex: Integer;
begin
  if (FMaxIndex > 0) and (FMaxIndex <= PageCount) then
    result := FMaxIndex
  else
    result := FPageCount;
end;

procedure TEscapableActionMap.SetMaxIndex(const Value: Integer);
begin
  FMaxIndex := Value;
end;

{ TCollectibleActionMap }

procedure TCollectibleActionMap.DoCollectMappings;
var
  p: Integer;
  iap: TInitActionProc;
  iacp: TInitActionColorProc;
begin
  iap := ActionProc;
  iacp := ActionColorProc;

  ActionProc := TestProc;
  ActionColorProc := TestProcIAC;
  { ActionMap 0 starts with 0, normal Maps start with 1 }
  for p := 0 to PageCount do
  begin
    TestPage := p;
    InitActions(p);
  end;

  ActionProc := iap;
  ActionColorProc := iacp;
end;

procedure TCollectibleActionMap.CollectAll(ML: TStrings);
begin
  TestList := ML;
  TestProc := TestProcAll;
  TestProcIAC := TestProcAllIAC;
  DoCollectMappings;
end;

procedure TCollectibleActionMap.CollectOne(fa: Integer; ML: TStrings);
begin
  TestAction := fa;
  TestList := ML;
  TestProc := TestProcOne;
  TestProcIAC := TestProcOneIAC;
  DoCollectMappings;
end;

procedure TCollectibleActionMap.TestProcOne(BtnID, Action: Integer);
begin
  if Action = TestAction then
    TestList.Add(Format('%s %d/%d', [TestName, TestPage, BtnID]));
end;

procedure TCollectibleActionMap.TestProcOneIAC(BtnID, Action: Integer; cla: TAlphaColor);
begin
  TestProcOne(BtnID, Action);
end;

procedure TCollectibleActionMap.TestProcAll(BtnID, Action: Integer);
begin
  TestList.Add(Format('%s %d/%d %s = %s', [
    TestName,
    TestPage,
    BtnID,
    GetFederActionLong(Action),
    GetFederActionShort(Action)
    ]));
end;

procedure TCollectibleActionMap.TestProcAllIAC(BtnID, Action: Integer; cla: TAlphaColor);
begin
  TestProcAll(BtnID, Action);
end;

end.
