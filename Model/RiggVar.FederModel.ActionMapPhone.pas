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
  FPageCount := 24;
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
  claForm: TAlphaColor;
  claColorMapping: TAlphaColor;
  claExample: TAlphaColor;
  claEyeSize: TAlphaColor;
  claSample: TAlphaColor;
  claExporter: TAlphaColor;
begin
  cla := claGray;
  claNoop := claWhite;
  claPage := claYellow;
  claParam := claPlum;
  claOption := claCornflowerblue;
  claReset := claOrange;
  claForm := claCornflowerblue;

  claExample := claAquamarine;
  claEyeSize := claPlum;
  claColorMapping := claDarkkhaki;
  claSample := claAquamarine;
  claExporter := claOrange;

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
      CurrentPageCaptionPhone := 'Page 1';
      IAC(1, faReset, claReset);
      IAC(2, faToggleShowEdges, cla);
      IAC(3, faMeshSize32, cla);

      IAC(4, faToggleLux, claOption);
      IAC(5, faToggleSolidFlip, claOption);
      IAC(6, faWantBottom, claOption);

      IAC(7, faMeshSize64, cla);
      IAC(8, faMeshSize128, cla);
    end;

    2:
    begin
      CurrentPageCaptionPhone := 'Page 2';
      IAC(1, faParamL, claParam);
      IAC(2, faParamT1, claParam);
      IAC(3, faParamT2, claParam);

      IAC(4, faParamCapValue, claParam);
      IAC(5, faNorthCap, claParam);
      IAC(6, faSouthCap, claParam);

      IAC(7, faToggleColorPanel, claOption);
      IAC(8, faActionPageE, claPage);
    end;

    3:
    begin
      CurrentPageCaptionPhone := 'Color 1';
      IAC(1, faCLA, TBambuColors.PLABasic_Black);
      IAC(2, faCLA, TBambuColors.PLABasic_Blue);
      IAC(3, faCLA, TBambuColors.PLAMatte_DarkBlue);

      IAC(4, faCLA, TBambuColors.PLABasic_BambuGreen);
      IAC(5, faCLA, TBambuColors.PLABasic_MistletoeGreen);
      IAC(6, faCLA, TBambuColors.PLABasic_MaroonRed);

      IAC(7, faCLA, TBambuColors.PLABasic_Magenta);
      IAC(8, faActionPageE, claPage);
    end;

    4:
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

    5:
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

    6:
    begin
      CurrentPageCaptionPhone := 'Example';
      cla := claBeige;
      IAC(1, faExample01, claExample);
      IAC(2, faExample02, claExample);
      IAC(3, faExample03, claExample);

      IAC(4, faExample04, claExample);
      IAC(5, faExample05, claExample);
      IAC(6, faExample06, claExample);

      IAC(7, faExample07, claExample);
      IAC(8, faExample08, claExample);
    end;

    7:
    begin
      CurrentPageCaptionPhone := 'Color Mapping';
      IAC(1, faSelectColorMapping1, claColorMapping);
      IAC(2, faSelectColorMapping2, claColorMapping);
      IAC(3, faSelectColorMapping3, claColorMapping);

      IAC(4, faSelectColorMapping4, claColorMapping);
      IAC(5, faSelectColorMapping5, claColorMapping);
      IAC(6, faSelectColorMapping6, claColorMapping);

      IAC(7, faReset, claReset);
      IAC(8, faActionPageE, claPage);
    end;

    8:
    begin
      CurrentPageCaptionPhone := 'Extra';
      IAC(1, faEyeSizeS, claEyeSize);
      IAC(2, faEyeSizeM, claEyeSize);
      IAC(3, faEyeSizeL, claEyeSize);

      IAC(4, faNoop, claNoop);
      IAC(5, faNoop, claNoop);
      IAC(6, faNoop, claNoop);

      IAC(7, faCycleColorSchemeM, cla);
      IAC(8, faCycleColorSchemeP, cla);
    end;

    9:
    begin
      CurrentPageCaptionPhone := 'Color Scheme';
      IAC(1, faShowInfo, cla);
      IAC(2, faNoop, claNoop);
      IAC(3, faNoop, claNoop);

      IAC(4, faNoop, claNoop);
      IAC(5, faCycleColorSchemeP, cla);
      IAC(6, faCycleColorSchemeM, cla);

      IAC(7, faNoop, claNoop);
      IAC(8, faActionPageE, claPage);
    end;

    10:
    begin
      CurrentPageCaptionPhone := 'Goto Sample';
      IAC(1, faBitmapEscape, cla);
      IAC(2, faCycleBitmapP, cla);
      IAC(3, faCycleBitmapM, cla);

      IAC(4, faGotoSample1, claSample);
      IAC(5, faSampleP, claSample);
      IAC(6, faSampleM, claSample);

      IAC(7, faActionPage1, claPage);
      IAC(8, faActionPageX, claPage);
    end;

    11:
    begin
      CurrentPageCaptionPhone := 'Params';
      IAC(1, faParamT, claParam);
      IAC(2, faParamL, claParam);
      IAC(3, faParamZ, claParam);

      IAC(4, faCycleZ, claParam);
      IAC(5, faCycleY, claParam);
      IAC(6, faCycleX, claParam);

      IAC(7, faParamR, claParam);
      IAC(8, faParamA, claParam);
    end;

    12:
    begin
      CurrentPageCaptionPhone := 'Pan';
      IAC(1, faPan, claParam);
      IAC(2, faCycleT, claParam);
      IAC(3, faResetRotation, cla);

      IAC(4, faNoop, claNoop);
      IAC(5, faRandomBlack, cla);
      IAC(6, faTogglePrimeText, cla);

      IAC(7, faActionPage1, claPage);
      IAC(8, faReset, claReset);
    end;

    13:
    begin
      CurrentPageCaptionPhone := 'Color Mix';
      IAC(1, faColorMixP, cla);
      IAC(2, faColorMixM, cla);
      IAC(3, faColorMix0, cla);

      IAC(4, faToggleLux, claOption);
      IAC(5, faCycleColorSchemeP, cla);
      IAC(6, faCycleColorSchemeM, cla);

      IAC(7, faToggleZeroPulling, claOption);
      IAC(8, faToggleLimitPulling, claOption);
    end;

    14:
    begin
      CurrentPageCaptionPhone := 'Mesh Size';
      IAC(1, faMeshSize32, cla);
      IAC(2, faMeshSize64, cla);
      IAC(3, faNoop, claNoop);

      IAC(4, faNoop, claNoop);
      IAC(5, faMeshSize128, cla);
      IAC(6, faMeshSize256, cla);

      IAC(7, faActionPage1, claPage);
      IAC(8, faActionPageE, claPage);
    end;

    15:
    begin
      CurrentPageCaptionPhone := 'Polar Mesh';
      IAC(1, faPolarMesh, claOption);
      IAC(2, faTogglePCap, claOption);
      IAC(3, faCycleO, claParam);

      IAC(4, faToggleShowEdges, claBeige);
      IAC(5, faCopy, cla);
      IAC(6, faPaste, cla);

      IAC(7, faGotoSample1, claSample);
      IAC(8, faActionPageX, claPage);
    end;

    16:
    begin
      CurrentPageCaptionPhone := 'Cap Value';
      IAC(1, faParamCapValue, claParam);
      IAC(2, faReducedMesh, claOption);
      IAC(3, faWantBottom, claOption);

      IAC(4, faNoop, claNoop);
      IAC(5, faTogglePCap, claOption);
      IAC(6, faToggleMCap, claOption);

      IAC(7, faPlot9, cla);
      IAC(8, faPlot10, cla);
    end;

    17:
    begin
      CurrentPageCaptionPhone := 'Extra Option';
      IAC(1, faM1, cla);
      IAC(2, faM2, cla);
      IAC(3, faM3, cla);

      IAC(4, faForceMode2, cla);
      IAC(5, faForceMode1, cla);
      IAC(6, faForceMode0, cla);

      IAC(7, faActionPage1, claPage);
      IAC(8, faActionPage3, claPage);
    end;

    18:
    begin
      CurrentPageCaptionPhone := 'Sample Bundle';
      IAC(1, faSwapBundle, claSample);
      IAC(2, faCycleBitmapP, cla);
      IAC(3, faCycleBitmapM, cla);

      IAC(4, faGotoSample1, claSample);
      IAC(5, faSampleP, claSample);
      IAC(6, faSampleM, claSample);

      IAC(7, faHubM, claSample);
      IAC(8, faHubP, claSample);
    end;

    19:
    begin
      CurrentPageCaptionPhone := 'Mesh Options';
      IAC(1, faNoop, claNoop);
      IAC(2, faNoop, claNoop);
      IAC(3, faMeshSize64, cla);

      IAC(4, faTogglePCap, cla);
      IAC(5, faPolarMesh, cla);
      IAC(6, faOpenMesh, cla);

      IAC(7, faActionPage1, cla);
      IAC(8, faMeshSize128, cla);
    end;

    20:
    begin
      CurrentPageCaptionPhone := 'Mesh Export';
      IAC(1, faNoop, claNoop);
      IAC(2, faNoop, claNoop);
      IAC(3, faMeshSize64, cla);

      IAC(4, faNoop, claNoop);
      IAC(5, faExportObj, claExporter);
      IAC(6, faExportMtl, claExporter);

      IAC(7, faActionPage1, cla);
      IAC(8, faMeshSize128, cla);
    end;

    21:
    begin
      CurrentPageCaptionPhone := 'Color Play';
      IAC(1, faColor1, cla);
      IAC(2, faColor2, cla);
      IAC(3, faColor3, cla);

      IAC(4, faColor6, cla);
      IAC(5, facolor5, cla);
      IAC(6, faColor4, cla);

      IAC(7, faColor0, cla);
      IAC(8, faColorMix0, cla);
    end;

    22:
    begin
      CurrentPageCaptionPhone := 'Plot Cycle';
      IAC(1, faCyclePlotP, cla);
      IAC(2, faCyclePlotM, cla);
      IAC(3, faMeshSize64, cla);

      IAC(4, faNoop, claNoop);
      IAC(5, faCycleFigureP, cla);
      IAC(6, faCycleFigureM, cla);

      IAC(7, faActionPage1, claPage);
      IAC(8, faMeshSize128, cla);
    end;

    23:
    begin
      CurrentPageCaptionPhone := 'Texture Params';
      IAC(1, faParamT1, claParam);
      IAC(2, faParamT2, claParam);
      IAC(3, faSampleM, claSample);

      IAC(4, faSampleP, claSample);
      IAC(5, faParamT3, claParam);
      IAC(6, faParamT4, claParam);

      IAC(7, faToggleContour, claOption);
      IAC(8, faActionPageE, claPage);
    end;

    24:
    begin
      CurrentPageCaptionPhone := 'Param Value';
      IAC(1, faParamValuePlus10, cla);
      IAC(2, faParamValueMinus10, cla);
      IAC(3, faNoop, claNoop);

      IAC(4, faParamValuePlus1, cla);
      IAC(5, faParamValueMinus1, cla);
      IAC(6, faGotoSample1, claSample);

      IAC(7, faShowActions, claForm);
      IAC(8, faShowMemo, claForm);
    end;

    else
    begin
      { do nothing }
    end;
  end;
end;

end.

