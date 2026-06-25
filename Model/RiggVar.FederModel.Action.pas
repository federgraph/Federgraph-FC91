unit RiggVar.FederModel.Action;

(*
-
-     F
-    * *  *
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
  System.Classes,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Action,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst;

type
  TFederActionHandler = class(TFederActionHandlerBase)
  public
    function GetShortCaption(fa: TFederAction): string; override;
    procedure Execute(fa: TFederAction); override;
    function GetChecked(fa: TFederAction): Boolean; override;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FederModel.ActionExecute,
  RiggVar.FederModel.ActionChecked;

procedure TFederActionHandler.Execute(fa: TFederAction);
var
  M: TMain;
begin
  if fa >= faMax then
    Exit;

  M := Main;
  if M = nil then
    Exit;

  if not M.IsUp then
  begin
    Exit;
  end;

  case fa of
    faNoop,
    faMax:
    begin
      { do nothing }
    end
    else
    begin
      M.CheckStateNeeded;
      M.TextUpdateNeeded;
      M.GraphUpdateNeeded;
    end;
  end;

  if not FederActionExecute(fa) then
  begin
    M.HandleAction(fa);
  end
  else
  begin
    M.BubbleUpAction(fa);
  end;
end;

function TFederActionHandler.GetChecked(fa: TFederAction): Boolean;
begin
  result := GetFederActionChecked(fa);
end;

function TFederActionHandler.GetShortCaption(fa: TFederAction): string;
begin
  case fa of
    faCLA: result := '';

    else
      result := inherited;
  end;
end;

end.
