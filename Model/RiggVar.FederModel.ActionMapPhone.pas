unit RiggVar.FederModel.ActionMapPhone;

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
  System.UIConsts,
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionMap;

type
  TActionMapPhone = class(TActionMap)
  private
    cla: TAlphaColor;
  protected
    procedure InitActionsFC(Layout: Integer);
  public
    constructor Create;
    procedure InitActions(Layout: Integer); override;
    procedure InitActionFromInfo(ActionInfo: TActionInfo); override;
  end;

{
[9]----[10]
[1]--------
[2]--------
[3]--------
-----------
--------[4]
--------[5]
--------[6]
[7]--- -[8]

[9][1][2][3]----[10]
--------------------
--------------------
--------------------
--------------------
[7]-----[4][5][6][8]
}

implementation

uses
  RiggVar.App.Main,
  RiggVar.FB.Color;

constructor TActionMapPhone.Create;
begin
  inherited;
  FPageCount := 10;
  FEscapeIndex := 6;
  TestName := 'Phone Page';
end;

procedure TActionMapPhone.InitActionFromInfo(ActionInfo: TActionInfo);
begin
  IAC(ActionInfo.Position, ActionInfo.Action, ActionInfo.Color);
end;

procedure TActionMapPhone.InitActions(Layout: Integer);
begin
  InitActionsFC(Layout);
end;

procedure TActionMapPhone.InitActionsFC(Layout: Integer);
var
  claNoop: TAlphaColor;
  claPage: TAlphaColor;
  claParam: TAlphaColor;
  claOption: TAlphaColor;
  claReset: TAlphaColor;
//  claForm: TAlphaColor;
//  claColorMapping: TAlphaColor;
//  claExample: TAlphaColor;
//  claEyeSize: TAlphaColor;
//  claSample: TAlphaColor;
//  claExporter: TAlphaColor;
begin
  cla := claGray;
  claNoop := claWhite;
  claPage := claYellow;
  claParam := claPlum;
  claOption := claCornflowerblue;
  claReset := claOrange;
//  claForm := claCornflowerblue;

//  claExample := claAquamarine;
//  claEyeSize := claPlum;
//  claColorMapping := claDarkkhaki;
//  claSample := claAquamarine;
//  claExporter := claOrange;

{
[9]----[10]
[1]--------
[2]--------
[3]--------
-----------
--------[4]
--------[5]
--------[6]
[7]--- -[8]

[9][1][2][3]----[10]
--------------------
--------------------
--------------------
--------------------
[7]-----[4][5][6][8]
}

  cla := claWhite;

  case Layout of
    1:
    begin
      CurrentPageCaptionPhone := 'Home Page';
      IAC(1, faReset, claReset);
      IAC(2, faMeshSize64, cla);
      IAC(3, faMeshSize128, cla);

      IAC(4, faToggleLux, claOption);
      IAC(5, faToggleSolidFlip, claOption);
      IAC(6, faWantBottom, claOption);

      IAC(7, faToggleColorPanel, claOption);
      IAC(8, faActionPageE, claPage);
    end;

    2:
    begin
      CurrentPageCaptionPhone := 'Color 1';
      IAC(1, faCLA, TBambuColors.PLABasic_Black);
      IAC(2, faCLA, TBambuColors.PLABasic_Blue);
      IAC(3, faCLA, TBambuColors.PLAMatte_DarkBlue);

      IAC(4, faCLA, TBambuColors.PLABasic_BambuGreen);
      IAC(5, faCLA, TBambuColors.PLABasic_MistletoeGreen);
      IAC(6, faCLA, TBambuColors.PLABasic_MaroonRed);

      IAC(7, faCLA, TBambuColors.PLABasic_Magenta);
      IAC(8, faCLA, TBambuColors.PLABasic_Orange);
    end;

    3:
    begin
      CurrentPageCaptionPhone := 'Color 2';
      IAC(1, faCLA, TBambuColors.PLABasic_Beige);
      IAC(2, faCLA, TBambuColors.PLABasic_LightGray);
      IAC(3, faCLA, TBambuColors.PLABasic_JadeWhite);

      IAC(4, faCLA, TBambuColors.PLAMatte_LatteBrown);
      IAC(5, faCLA, TBambuColors.PLAMatte_SakuraPink);
      IAC(6, faCLA, TBambuColors.PLAMatte_DesertTan);

      IAC(7, faCLA, TBambuColors.PLAMatte_IceBlue);
      IAC(8, faCLA, TBambuColors.PLAMatte_AshGray);
    end;

    4:
    begin
      CurrentPageCaptionPhone := 'Color 3';
      IAC(1, faCLA, TBambuColors.PLABasic_BambuGreen);
      IAC(2, faCLA, TBambuColors.PLABasic_SunflowerYellow);
      IAC(3, faCLA, TBambuColors.PLABasic_Magenta);

      IAC(4, faCLA, TBambuColors.PLABasic_Purple);
      IAC(5, faCLA, TBambuColors.PLAMatte_MarineBlue);
      IAC(6, faCLA, TBambuColors.PLAMatte_LilacPurple);

      IAC(7, faCLA, TBambuColors.PLABasic_HotPink);
      IAC(8, faCLA, TBambuColors.PLAMatte_MandarinOrange);
    end;

    5:
    begin
      CurrentPageCaptionPhone := 'Params';
      IAC(1, faParamL, claParam);
      IAC(2, faBandWidthRelative, claParam);
      IAC(3, faParamT2, claParam);

      IAC(4, faNorthCap, claParam);
      IAC(5, faSouthCap, claParam);
      IAC(6, faParamCapValue, claParam);

      IAC(7, faParamCZ, claParam);
      IAC(8, faActionPageE, claPage);
    end;

    6:
    begin
      CurrentPageCaptionPhone := 'Param Value';
      IAC(1, faParamValuePlus10, cla);
      IAC(2, faParamValueMinus10, cla);
      IAC(3, faParamCZ, claParam);

      IAC(4, faParamValuePlus1, cla);
      IAC(5, faParamValueMinus1, cla);
      IAC(6, faParamL, claParam);

      IAC(7, faActionPage1, claPage);
      IAC(8, faActionPageX, claPage);
    end;

    7:
    begin
      CurrentPageCaptionPhone := 'Texture Bitmap';
      IAC(1, faBitmapEscape, cla);
      IAC(2, faCycleBitmapP, cla);
      IAC(3, faCycleBitmapM, cla);

      IAC(4, faBitmapOne, cla);
      IAC(5, faToggleColorPanel, claOption);
      IAC(6, faToggleColorSwat, claOption);

      IAC(7, faActionPage1, claPage);
      IAC(8, faCLA, TBambuColors.PLABasic_Blue);
    end;

    8:
    begin
      CurrentPageCaptionPhone := 'Color Scheme';
      IAC(1, faShowInfo, cla);
      IAC(2, faResetRotation, cla);
      IAC(3, faResetZoom, cla);

      IAC(4, faRandomBlack, claNoop);
      IAC(5, faCycleColorSchemeP, cla);
      IAC(6, faCycleColorSchemeM, cla);

      IAC(7, faActionPage1, claPage);
      IAC(8, faActionPageX, claPage);
    end;

    9:
    begin
      CurrentPageCaptionPhone := 'Mesh Size';
      IAC(1, faMeshSize32, cla);
      IAC(2, faMeshSize64, cla);
      IAC(3, faNoop, claNoop);

      IAC(4, faToggleShowEdges, cla);
      IAC(5, faMeshSize128, cla);
      IAC(6, faMeshSize256, cla);

      IAC(7, faActionPage1, claPage);
      IAC(8, faActionPageE, claPage);
    end;

    10:
    begin
      CurrentPageCaptionPhone := 'Reset';
      IAC(1, faResetRotation, cla);
      IAC(2, faResetPosition, cla);
      IAC(3, faResetZoom, cla);

      IAC(4, faReset, claReset);
      IAC(5, faNoop, cla);
      IAC(6, faNoop, cla);

      IAC(7, faActionPage1, claPage);
      IAC(8, faActionPageE, claPage);
    end;

    else
    begin
      { do nothing }
    end;
  end;
end;

end.

