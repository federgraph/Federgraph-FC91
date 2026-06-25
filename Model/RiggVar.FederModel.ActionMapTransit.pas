unit RiggVar.FederModel.ActionMapTransit;

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
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionMap;

type
  TLayoutDef = record
     Caption: string;
     A0: TFederAction;
     A1: TFederAction;
     A2: TFederAction;
     A3: TFederAction;
     A4: TFederAction;
     A5: TFederAction;
     procedure Clear;
  end;

  TActionMapTransit = class(TActionMap)
  private
    function InitLayoutDef(Layout: Integer): TLayoutDef;
  public
    constructor Create;
    procedure InitActions(Layout: Integer); override;
    procedure InitMenuCaptions(Menu: Integer = 0);
  end;

implementation

constructor TActionMapTransit.Create;
begin
  inherited;
  FPageCount := 87;
  TestName := 'Layout';
end;

procedure TActionMapTransit.InitMenuCaptions(Menu: Integer = 0);
var
  i: Integer;
  cr: TLayoutDef;
begin
  for i := 0 to 9 do
  begin
    cr := InitLayoutDef(Menu + i);
    CurrentMenuCaptions[i] := cr.Caption;
  end;
end;

procedure TActionMapTransit.InitActions(Layout: Integer);
var
  cr: TLayoutDef;
  ButtonIndex: Integer;
begin
  cr := InitLayoutDef(Layout);

  InitAction(0, cr.A0);
  InitAction(1, cr.A1);
  InitAction(2, cr.A2);
  InitAction(3, cr.A3);
  InitAction(4, cr.A4);
  InitAction(5, cr.A5);

  ButtonIndex := Layout mod 10;
  if ButtonIndex > 9 then
    ButtonIndex := 9;
  CurrentMenuCaptions[ButtonIndex] := cr.Caption;
end;

function TActionMapTransit.InitLayoutDef(Layout: Integer): TLayoutDef;
  procedure InitA(Pos: Integer; fa: TFederAction);
  begin
    case Pos of
      0: result.A0 := fa;
      1: result.A1 := fa;
      2: result.A2 := fa;
      3: result.A3 := fa;
      4: result.A4 := fa;
      5: result.A5 := fa;
    end;
  end;
begin
  result.Clear;

  case Layout of

    0:
    begin
      result.Caption := 'Param Value Buttons';
      InitA(0, faParamValueMinus10);
      InitA(1, faParamValueMinus1);
      InitA(2, faParamValuePlus1);
      InitA(3, faParamValuePlus10);
      InitA(4, faToggleContour);
      InitA(5, faShowCurrentBandT);
    end;

    1:
    begin
      result.Caption := 'Mesh Size Buttons';
      InitA(0, faMeshSize16);
      InitA(1, faMeshSize32);
      InitA(2, faMeshSize64);
      InitA(3, faMeshSize128);
      InitA(4, faMeshSize256);
      InitA(5, faNoop);
    end;

    2:
    begin
      result.Caption := 'Band Params and Options';
      InitA(0, faParamCZ);
      InitA(1, faBandWidthRelative);
      InitA(2, faNoop);
      InitA(3, faNoop);
      InitA(4, faToggleContour);
      InitA(5, faShowCurrentBandT);
    end;

    3:
    begin
      result.Caption := 'Light';
      InitA(0, faToggleLux);
      InitA(1, faNoop);
      InitA(2, faNoop);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    4:
    begin
      result.Caption := 'Mesh Options';
      InitA(0, faWantBottom);
      InitA(1, faWantBottomMirrored);
      InitA(2, faToggleSolidFlip);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faToggleShowEdges);
    end;

    5:
    begin
      result.Caption := 'Popular Params';
      InitA(0, faParamR);
      InitA(1, faNorthCap);
      InitA(2, faSouthCap);
      InitA(3, faParamCapValue);
      InitA(4, faParamL);
      InitA(5, faParamCZ);
    end;

    6:
    begin
      result.Caption := 'Reset Actions';
      InitA(0, faReset);
      InitA(1, faResetRotation);
      InitA(2, faResetPosition);
      InitA(3, faResetZoom);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;

    7:
    begin
      result.Caption := 'Texture Params';
      InitA(0, faParamT1);
      InitA(1, faParamT2);
      InitA(2, faNoop);
      InitA(3, faNoop);
      InitA(4, faToggleContour);
      InitA(5, faShowCurrentBandT);
    end;

    8:
    begin
      result.Caption := 'Button Page shortcuts';
      InitA(0, faActionPage1);
      InitA(1, faActionPage2);
      InitA(2, faActionPage3);
      InitA(3, faActionPage4);
      InitA(4, faActionPageE);
      InitA(5, faActionPageX);
    end;

    9:
    begin
      result.Caption := 'Forms';
      InitA(0, faShowActions);
      InitA(1, faShowMemo);
      InitA(2, faToggleColorPanel);
      InitA(3, faToggleColorSwat);
      InitA(4, faNoop);
      InitA(5, faShowInfo);
    end;

    else
    begin
      result.Caption := 'Unused';
      InitA(0, faNoop);
      InitA(1, faNoop);
      InitA(2, faNoop);
      InitA(3, faNoop);
      InitA(4, faNoop);
      InitA(5, faNoop);
    end;
  end;
end;

{ TLayoutDef }

procedure TLayoutDef.Clear;
begin
  Caption := 'not implemented';
  A0 := faNoop;
  A1 := faNoop;
  A2 := faNoop;
  A3 := faNoop;
  A4 := faNoop;
  A5 := faNoop;
end;

end.
