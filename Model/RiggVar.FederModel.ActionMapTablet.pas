unit RiggVar.FederModel.ActionMapTablet;

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
  RiggVar.FB.Color,
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionMap;

type
  TActionMapTablet = class(TActionMap)
  private
    bl: array[1..8] of Integer;
    ForceActionPageMP: Boolean;
    procedure InitButtonListDefault(CornerLocation: TCornerLocation);
    procedure ProcessButtonList(CornerLocation: TCornerLocation);
    procedure InitDefault;
    procedure InitAC(cl: TCornerLocation; bi, fa: Integer; cla: TAlphaColor);
    procedure InitActionsFC90(Layout: Integer);
  public
    constructor Create;
    procedure InitActions(Layout: Integer); override;
    procedure InitActionFromInfo(ActionInfo: TActionInfo); override;
  end;

{

FrameLocation: absolute position

[01][03][04][05][06]----[14][13][12][11][07]
[02]------------------------------------[08]
----------------------------------------[09]
----------------------------------------[10]
--------------------------------------------
[22]----------------------------------------
[21]----------------------------------------
[20]------------------------------------[24]
[15][16][17][18][19]----[28][27][26][25][23]

CornerLocation: relative positions

[1][2][3][4][5]----[1][2][3][4][5]
[6]----------------------------[6]
-------------------------------[7]
-------------------------------[8]
----------------------------------
[8]-------------------------------
[7]-------------------------------
[6]----------------------------[6]
[1][2][3][4][5]----[1][2][3][4][5]

}

{
RG08:
[PM][SH][SA][SL]----[04][03][02][01][PP]
[SW]--------------------------------[05]
------------------------------------[06]
----------------------------------------
[11]------------------------------------
[10]--------------------------------[PE]
[08][09]----------------[VO][WI][WA][HU]

FC70:
[01][03][04][05][06]----[14][13][12][11][07]
02]-------------------------------------[08]
----------------------------------------[09]
----------------------------------------[10]
--------------------------------------------
[22]----------------------------------------
[21]----------------------------------------
[20]------------------------------------[24]
[15][16][17][18][19]----[28][27][26][25][23]

RG10:
[1][2][3][4]----[1][2][3][4][5]
[5]-------------------------[6]
----------------------------[7]
-------------------------------
[3]----------------------------
[4]-------------------------[5]
[1][2]-------------[1][2][3][4]

}

implementation

uses
  RiggVar.App.Main;

constructor TActionMapTablet.Create;
begin
  inherited;
  FPageCount := 19;
  FEscapeIndex := 6;
  ForceActionPageMP := True;
  TestName := 'Tablet Page';
end;

procedure TActionMapTablet.InitActions(Layout: Integer);
begin
  InitDefault;
  InitActionsFC90(Layout);
end;

procedure TActionMapTablet.InitActionFromInfo(ActionInfo: TActionInfo);
begin
  InitAC(ActionInfo.Corner, ActionInfo.Position, ActionInfo.Action, ActionInfo.Color);
end;

procedure TActionMapTablet.InitDefault;
begin
  InitButtonListDefault(TopLeft);
  ProcessButtonList(TopLeft);

  InitButtonListDefault(TopRight);
  ProcessButtonList(TopRight);

  InitButtonListDefault(BottomLeft);
  ProcessButtonList(BottomLeft);

  InitButtonListDefault(BottomRight);
  ProcessButtonList(BottomRight);
end;

procedure TActionMapTablet.InitButtonListDefault(CornerLocation: TCornerLocation);
begin
  case CornerLocation of
    TopLeft:
    begin
      //  [1][2][3][4][5]
      //  [6]------------
      bl[1] := faNoop; //faActionPageM;
      bl[2] := faNoop;
      bl[3] := faNoop;
      bl[4] := faNoop;
      bl[5] := faNoop;
      bl[6] := faNoop;
    end;

    TopRight:
    begin
      //  [1][2][3][4][5]
      //  ------------[6]
      //  ------------[7]
      //  ------------[8]
      bl[1] := faNoop;
      bl[2] := faNoop;
      bl[3] := faNoop;
      bl[4] := faNoop;
      bl[5] := faNoop; //faActionPageP;
      bl[6] := faNoop;
      bl[7] := faNoop;
      bl[8] := faNoop;
    end;

    BottomLeft:
    begin
      //  [8]------------
      //  [7]------------
      //  [6]------------
      //  [1][2][3][4][5]
      bl[1] := faNoop;
      bl[2] := faNoop;
      bl[3] := faNoop;
      bl[4] := faNoop;
      bl[5] := faNoop;
      bl[6] := faNoop;
      bl[7] := faNoop;
      bl[8] := faNoop;
    end;

    BottomRight:
    begin
      //  ------------[6]
      //  [1][2][3][4][5]
      bl[1] := faNoop;
      bl[2] := faNoop;
      bl[3] := faNoop;
      bl[4] := faNoop;
      bl[5] := faNoop;
      bl[6] := faNoop;
    end;
  end;
end;

procedure TActionMapTablet.ProcessButtonList(CornerLocation: TCornerLocation);
var
  cla: TAlphaColor;
begin
{
Input
[1][2][3][4][5]-----[1][2][3][4][5]
[6]-----------------------------[6]
--------------------------------[7]
--------------------------------[8]
-----------------------------------
-----------------------------------
[8]--------------------------------
[7]--------------------------------
[6]-----------------------------[6]
[1][2][3][4][5]-----[1][2][3][4][5]
}

{
Output
[01][03][04][05][06]----[14][13][12][11][07]
02]-------------------------------------[08]
----------------------------------------[09]
----------------------------------------[10]
--------------------------------------------
[22]----------------------------------------
[21]----------------------------------------
[20]------------------------------------[24]
[15][16][17][18][19]----[28][27][26][25][23]
}

  cla := claLightGray;

  case CornerLocation of
    TopLeft:
    begin
      if ForceActionPageMP then
        IAC(1, faActionPageM, ColorPage)
      else
        IAC(1, bl[1], cla);

      IAC(3, bl[2], cla);
      IAC(4, bl[3], cla);
      IAC(5, bl[4], cla);
      IAC(6, bl[5], cla);
      IAC(2, bl[6], cla);
    end;

    TopRight:
    begin
      IAC(14, bl[1], cla);
      IAC(13, bl[2], cla);
      IAC(12, bl[3], cla);
      IAC(11, bl[4], cla);
      if ForceActionPageMP then
        IAC(7, faActionPageP, ColorPage)
      else
        IAC(7, bl[5], cla);
      IAC(8, bl[6], cla);
      IAC(9, bl[7], cla);
      IAC(10, bl[8], cla);
    end;

    BottomRight:
    begin
      IAC(28, bl[1], cla);
      IAC(27, bl[2], cla);
      IAC(26, bl[3], cla);
      IAC(25, bl[4], cla);
      IAC(23, bl[5], cla);
      IAC(24, bl[6], cla);
    end;

    BottomLeft:
    begin
      IAC(15, bl[1], cla);
      IAC(16, bl[2], cla);
      IAC(17, bl[3], cla);
      IAC(18, bl[4], cla);
      IAC(19, bl[5], cla);
      IAC(20, bl[6], cla);
      IAC(21, bl[7], cla);
      IAC(22, bl[8], cla);
    end;
  end;
end;

procedure TActionMapTablet.InitAC(cl: TCornerLocation; bi, fa: Integer; cla: TAlphaColor);
var
  j: Integer; // FrameLocation
begin
  { First, translate from CornerLocation to FrameLocation }
  j := 0;
  case cl of
    TopLeft:
    begin
      case bi of
        1: j := 1;
        2: j := 3;
        3: j := 4;
        4: j := 5;
        5: j := 6;
        6: j := 2;
      end;
    end;

    TopRight:
    begin
      case bi of
        1: j := 14;
        2: j := 13;
        3: j := 12;
        4: j := 11;
        5: j := 7;
        6: j := 8;
        7: j := 9;
        8: j := 10;
      end;
    end;

    BottomRight:
    begin
      case bi of
        1: j := 28;
        2: j := 27;
        3: j := 26;
        4: j := 25;
        5: j := 23;
        6: j := 24;
      end;
    end;

    BottomLeft:
    begin
      case bi of
        1: j := 15;
        2: j := 16;
        3: j := 17;
        4: j := 18;
        5: j := 19;
        6: j := 20;
        7: j := 21;
        8: j := 22;
      end;
    end;
  end;
  { Init button with Action and Color }
  IAC(j, fa, cla);
end;

procedure TActionMapTablet.InitActionsFC90(Layout: Integer);
var
  cl: TCornerLocation;
  cla: TAlphaColor;
  claNoop: TAlphaColor;
  claPage: TAlphaColor;
  claForm: TAlphaColor;
  claParam: TAlphaColor;
  claOption: TAlphaColor;
  claReset: TAlphaColor;
  claExample: TAlphaColor;
  claFigureSize: TAlphaColor;
  claEyeSize: TAlphaColor;
  claLayerSelection: TAlphaColor;
  claColorSelection: TAlphaColor;
  claColorMapping: TAlphaColor;
  claSample: TAlphaColor;
  claExporter: TAlphaColor;
  claObject: TAlphaColor;
begin
  cla := claWhite;
  claNoop := claWhite;
  claPage := ColorPage;
  claForm := claCornflowerblue;
  claParam := claPlum;
  claOption := claCornflowerblue;
  claReset := claOrange;
  claSample := claAquamarine;

  claExample := claAquamarine;
  claFigureSize := claDarksalmon;
  claEyeSize := claPlum;
  claLayerSelection := claCornflowerblue;
  claColorSelection := claAquamarine;
  claColorMapping := claDarkkhaki;
  claExporter := claOrange;
  claObject := claAquamarine;

  case Layout of

    1:
    begin
      CurrentPageCaption := 'Page 1';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleBitmapM, cla);
      InitAC(cl, 3, faCycleBitmapP, cla);
      InitAC(cl, 4, faBitmapEscape, cla);
      InitAC(cl, 5, faBitmapOne, cla);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Blue);

      cl := TopRight;
      InitAC(cl, 1, faWantBottom, claOption);
      InitAC(cl, 2, faWantSideCaps, claOption);
      InitAC(cl, 3, faToggleShowEdges, cla);
      InitAC(cl, 4, faToggleSolidFlip, claOption);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faNorthCap, claParam);
      InitAC(cl, 7, faSouthCap, claParam);
      InitAC(cl, 8, faParamCapValue, claParam);

      cl := BottomLeft;
      InitAC(cl, 1, faBandWidthRelative, claParam);
      InitAC(cl, 2, faToggleColorPanel, claOption);
      InitAC(cl, 3, faToggleColorSwat, claOption);
      InitAC(cl, 4, faParamT1, claParam);
      InitAC(cl, 5, faParamT2, claParam);
      InitAC(cl, 6, faMeshSize32, cla);
      InitAC(cl, 7, faMeshSize64, cla);
      InitAC(cl, 8, faMeshSize128, cla);

      cl := BottomRight;
      InitAC(cl, 1, faGotoSample1, claSample);
      InitAC(cl, 2, faParamL, claParam);
      InitAC(cl, 3, faReset, claReset);
      InitAC(cl, 4, faParamCZ, claParam);
      InitAC(cl, 5, faActionPage2, claPage);
      InitAC(cl, 6, faToggleLux, claOption);
    end;

    2:
    begin
      CurrentPageCaption := 'Page 2';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faPan, claParam);

      cl := TopRight;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faToggleZeroPulling, claOption);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faToggleLimitPulling, claOption);
      InitAC(cl, 7, faParamCZ, claParam);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomLeft;
      InitAC(cl, 1, faShowInfo, claForm);
      InitAC(cl, 2, faShowActions, claForm);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faShowMemo, claForm);
      InitAC(cl, 7, faCyclePlotM, cla);
      InitAC(cl, 8, faCyclePlotP, cla);

      cl := BottomRight;
      InitAC(cl, 1, faGotoSample1, claSample);
      InitAC(cl, 2, faActionPageE, claPage);
      InitAC(cl, 3, faSampleM, claSample);
      InitAC(cl, 4, faSampleP, claSample);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faToggleLux, claOption);
    end;

    3:
    begin
      CurrentPageCaption := 'Color 1';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCLA, TBambuColors.PLAMatte_DarkBlue);
      InitAC(cl, 3, faCLA, TBambuColors.PLABasic_Blue);
      InitAC(cl, 4, faCLA, TBambuColors.PLABasic_IndigoPurple);
      InitAC(cl, 5, faCLA, TBambuColors.PLABasic_DarkGray);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Black);

      cl := TopRight;
      InitAC(cl, 1, faCLA, TBambuColors.PLABasic_MaroonRed);
      InitAC(cl, 2, faCLA, TBambuColors.PLABasic_Orange);
      InitAC(cl, 3, faCLA, TBambuColors.PLABasic_BambuGreen);
      InitAC(cl, 4, faCLA, TBambuColors.PLABasic_MistletoeGreen);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Red);
      InitAC(cl, 7, faCLA, TBambuColors.PLABasic_Magenta);
      InitAC(cl, 8, faCLA, TBambuColors.PLAMatte_MarineBlue);

      cl := BottomLeft;
      InitAC(cl, 1, faShowActions, claForm);
      InitAC(cl, 2, faShowInfo, claForm);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faShowMemo, claForm);
      InitAC(cl, 7, faShowColor, claForm);
      InitAC(cl, 8, faShowBambu, claForm);

      cl := BottomRight;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faActionPageE, claPage);
      InitAC(cl, 6, faExample01, claExample);
    end;

    4:
    begin
      CurrentPageCaption := 'Color 2';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faEyeSizeS, claEyeSize);
      InitAC(cl, 3, faEyeSizeM, claEyeSize);
      InitAC(cl, 4, faEyeSizeL, claEyeSize);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);

      cl := TopRight;
      InitAC(cl, 1, faCLA, TBambuColors.PLABasic_Beige);
      InitAC(cl, 2, faCLA, TBambuColors.PLABasic_LightGray);
      InitAC(cl, 3, faCLA, TBambuColors.PLAMatte_IceBlue);
      InitAC(cl, 4, faCLA, TBambuColors.PLAMatte_DesertTan);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faCLA, TBambuColors.PLAMatte_LatteBrown);
      InitAC(cl, 7, faCLA, TBambuColors.PLAMatte_AshGray);
      InitAC(cl, 8, faCLA, TBambuColors.PLAMatte_SakuraPink);

      cl := BottomLeft;
      InitAC(cl, 1, faRandomBambu1, cla);
      InitAC(cl, 2, faRandomBambu2, cla);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faToggleColorPanel, claOption);
      InitAC(cl, 5, faToggleColorSwat, claOption);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faHelpHome, claForm);

      cl := BottomRight;
      InitAC(cl, 1, faSelectColorMapping1, claColorMapping);
      InitAC(cl, 2, faSelectColorMapping2, claColorMapping);
      InitAC(cl, 3, faSelectColorMapping3, claColorMapping);
      InitAC(cl, 4, faSelectColorMapping4, claColorMapping);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faSelectColorMapping6, claColorMapping);
    end;

    5:
    begin
      CurrentPageCaption := 'Color 3';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCLA, TBambuColors.PLABasic_Black);
      InitAC(cl, 3, faCLA, TBambuColors.PLABasic_Blue);
      InitAC(cl, 4, faCLA, TBambuColors.PLABasic_MaroonRed);
      InitAC(cl, 5, faCLA, TBambuColors.PLABasic_IndigoPurple);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Purple);

      cl := TopRight;
      InitAC(cl, 1, faCLA, TBambuColors.PLABasic_Red);
      InitAC(cl, 2, faCLA, TBambuColors.PLAMatte_ScarletRed);
      InitAC(cl, 3, faCLA, TBambuColors.PLAMatte_DarkRed);
      InitAC(cl, 4, faCLA, TBambuColors.PLAMatte_LilacPurple);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_BambuGreen);
      InitAC(cl, 7, faCLA, TBambuColors.PLABasic_Orange);
      InitAC(cl, 8, faCLA, TBambuColors.PLAMatte_MarineBlue);

      cl := BottomLeft;
      InitAC(cl, 1, faCLA, TBambuColors.PLABasic_Gold);
      InitAC(cl, 2, faCLA, TBambuColors.PLABasic_Silver);
      InitAC(cl, 3, faCLA, TBambuColors.PLABasic_Bronze);
      InitAC(cl, 4, faCLA, TBambuColors.PLABasic_HotPink);
      InitAC(cl, 5, faCLA, TBambuColors.PLABasic_Pink);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Yellow);
      InitAC(cl, 7, faCLA, TBambuColors.PLABasic_Magenta);
      InitAC(cl, 8, faCLA, TBambuColors.PLABasic_Cyan);

      cl := BottomRight;
      InitAC(cl, 1, faCLA, TBambuColors.PLAMatte_MandarinOrange);
      InitAC(cl, 2, faCLA, TBambuColors.PLABasic_Pumpkin);
      InitAC(cl, 3, faCLA, TBambuColors.PLABasic_SunflowerYellow);
      InitAC(cl, 4, faCLA, TBambuColors.PLAMatte_LemonYellow);
      InitAC(cl, 5, faActionPageE, claPage);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Turquoise);
    end;

    6:
    begin
      CurrentPageCaption := 'Params Page 1';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleBitmapM, cla);
      InitAC(cl, 3, faCycleBitmapP, cla);
      InitAC(cl, 4, faBitmapEscape, cla);
      InitAC(cl, 5, faBitmapOne, cla);
      InitAC(cl, 6, faCLA, claCrimson);

      cl := TopRight;
      InitAC(cl, 1, faRandomBlack, cla);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faParamA, claParam);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faParamT, claParam);
      InitAC(cl, 7, faParamL, claParam);
      InitAC(cl, 8, faParamTRT, claParam);

      cl := BottomLeft;
      InitAC(cl, 1, faActionPage1, claPage);
      InitAC(cl, 2, faToggleColorPanel, claOption);
      InitAC(cl, 3, faToggleColorSwat, claOption);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faGotoSample1, claSample);
      InitAC(cl, 6, faToggleBMap, cla);
      InitAC(cl, 7, faParamT2, claParam);
      InitAC(cl, 8, faParamT1, claParam);

      cl := BottomRight;
      InitAC(cl, 1, faTogglePCap, claOption);
      InitAC(cl, 2, faToggleMCap, claOption);
      InitAC(cl, 3, faSampleM, claSample);
      InitAC(cl, 4, faSampleP, claSample);
      InitAC(cl, 5, faActionPageX, claPage);
      InitAC(cl, 6, faToggleMoveMode, cla);
    end;

    7:
    begin
      CurrentPageCaption := 'Params Page 2';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleX, claParam);
      InitAC(cl, 3, faCycleY, claParam);
      InitAC(cl, 4, faCycleZ, claParam);
      InitAC(cl, 5, faCycleL, claParam);
      InitAC(cl, 6, faNoop, claNoop);

      cl := TopRight;
      InitAC(cl, 1, faCycleO, claParam);
      InitAC(cl, 2, faParamZ, claParam);
      InitAC(cl, 3, faParamR, claParam);
      InitAC(cl, 4, faParamA, claParam);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faParamT, claParam);
      InitAC(cl, 7, faParamL, claParam);
      InitAC(cl, 8, faParamTRT, claParam);

      cl := BottomLeft;
      InitAC(cl, 1, faRandomBlack, cla);
      InitAC(cl, 2, faBitmapOne, cla);
      InitAC(cl, 3, faBitmapEscape, cla);
      InitAC(cl, 4, faCycleBitmapM, cla);
      InitAC(cl, 5, faCycleBitmapP, cla);
      InitAC(cl, 6, faToggleBMap, cla);
      InitAC(cl, 7, faParamT2, claParam);
      InitAC(cl, 8, faParamT1, claParam);

      cl := BottomRight;
      InitAC(cl, 1, faMenu30, cla);
      InitAC(cl, 2, faMenu20, cla);
      InitAC(cl, 3, faMenu10, cla);
      InitAC(cl, 4, faMenu00, cla);
      InitAC(cl, 5, faActionPageX, claPage);
      InitAC(cl, 6, faNoop, claNoop);
    end;

    8:
    begin
      CurrentPageCaption := 'Mesh 1';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleBitmapM, cla);
      InitAC(cl, 3, faCycleBitmapP, cla);
      InitAC(cl, 4, faBitmapEscape, cla);
      InitAC(cl, 5, faBitmapOne, cla);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Blue);

      cl := TopRight;
      InitAC(cl, 1, faReducedMesh, claOption);
      InitAC(cl, 2, faTogglePCap, claOption);
      InitAC(cl, 3, faToggleMCap, claOption);
      InitAC(cl, 4, faToggleZeroPulling, claOption);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faToggleLimitPulling, claOption);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomLeft;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faMeshSize64, cla);
      InitAC(cl, 7, faMeshSize32, cla);
      InitAC(cl, 8, faMeshSize128, cla);

      cl := BottomRight;
      InitAC(cl, 1, faWheelFrequency1, cla);
      InitAC(cl, 2, faWheelFrequency05, cla);
      InitAC(cl, 3, faWheelFrequency01, cla);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faParamCapValue, claParam);
      InitAC(cl, 6, faToggleLux, claOption);
    end;

    9:
    begin
      CurrentPageCaption := 'Mesh 2';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faTakeCapValueSnapshot, claBeige);
      InitAC(cl, 4, faToggleCrackFixing, claOption);
      InitAC(cl, 5, faWantBottom, claOption);
      InitAC(cl, 6, faToggleShowEdges, cla);

      cl := TopRight;
      InitAC(cl, 1, faReducedMesh, claOption);
      InitAC(cl, 2, faPolarMesh, claOption);
      InitAC(cl, 3, faTogglePCap, claOption);
      InitAC(cl, 4, faToggleZeroPulling, claOption);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faToggleLimitPulling, claOption);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faToggleContour, claBeige);

      cl := BottomLeft;
      InitAC(cl, 1, faMeshSize64, cla);
      InitAC(cl, 2, faMeshSize128, cla);
      InitAC(cl, 3, faMeshSize256, cla);
      InitAC(cl, 4, faMeshSize316, cla);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faFigureSizeS, claFigureSize);
      InitAC(cl, 7, faFigureSizeM, claFigureSize);
      InitAC(cl, 8, faFigureSizeL, claFigureSize);

      cl := BottomRight;
      InitAC(cl, 1, faParamR, claParam);
      InitAC(cl, 2, faOffsetY, claParam);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faParamCapValue, claParam);
      InitAC(cl, 6, faNoop, claNoop);
    end;

    10:
    begin
      CurrentPageCaption := 'Rings';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faBandSelectionM, claBeige);
      InitAC(cl, 3, faBandSelectionP, claBeige);
      InitAC(cl, 4, faShowCurrentBandT, claBeige);
      InitAC(cl, 5, faToggleColorSwat, claBeige);
      InitAC(cl, 6, faParamBandSelected, claParam);

      cl := TopRight;
      InitAC(cl, 1, faShirtColorOff, claBeige);
      InitAC(cl, 2, faShirtColorOn, claBeige);
      InitAC(cl, 3, faShirtFarbeOff, claBeige);
      InitAC(cl, 4, faShirtFarbeOn, claBeige);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Blue);
      InitAC(cl, 7, faBlindRingP, claBeige);
      InitAC(cl, 8, faBlindRingM, claBeige);

      cl := BottomLeft;
      InitAC(cl, 1, faCLA, claOrange);
      InitAC(cl, 2, faBandSelection21, claBeige);
      InitAC(cl, 3, faBandSelection19, claBeige);
      InitAC(cl, 4, faParamValueMinus1, cla);
      InitAC(cl, 5, faParamValuePlus1, cla);
      InitAC(cl, 6, faBandWidthContour, claParam);
      InitAC(cl, 7, faBandWidthRelative, claParam);
      InitAC(cl, 8, faBandWidthAbsolute, claParam);

      cl := BottomRight;
      InitAC(cl, 1, faBlindRing1, cla);
      InitAC(cl, 2, faBlindRing5, cla);
      InitAC(cl, 3, faBlindRingA, cla);
      InitAC(cl, 4, faBlindRingB, cla);
      InitAC(cl, 5, faBlindRingD, cla);
      InitAC(cl, 6, faBlindRingF, cla);
    end;

    11:
    begin
      CurrentPageCaption := 'Probe';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);

      cl := TopRight;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claWhite);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomLeft;
      InitAC(cl, 1, faToggleCylinder, claOption);
      InitAC(cl, 2, faToggleDiameter, claOption);
      InitAC(cl, 3, faParamBahnPositionX, claParam);
      InitAC(cl, 4, faParamBahnPositionY, claParam);
      InitAC(cl, 5, faParamBahnCylinderZ, claParam);
      InitAC(cl, 6, faParamBahnCylinderD, claParam);
      InitAC(cl, 7, faParamBahnAngle, claParam);
      InitAC(cl, 8, faParamBahnRadius, claParam);

      cl := BottomRight;
      InitAC(cl, 1, faMenu30, cla);
      InitAC(cl, 2, faMenu20, cla);
      InitAC(cl, 3, faMenu10, cla);
      InitAC(cl, 4, faMenu00, cla);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faNoop, claNoop);
    end;

    12:
    begin
      CurrentPageCaption := 'Texture';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleBitmapM, cla);
      InitAC(cl, 3, faCycleBitmapP, cla);
      InitAC(cl, 4, faBitmapEscape, cla);
      InitAC(cl, 5, faBitmapOne, cla);
      InitAC(cl, 6, faToggleContour, cla);

      cl := TopRight;
      InitAC(cl, 1, faColor0, claWhite);
      InitAC(cl, 2, faColor1, claRed);
      InitAC(cl, 3, faColor2, claGreen);
      InitAC(cl, 4, faColor3, claBlue);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faColor4, claMagenta);
      InitAC(cl, 7, faColor5, claCyan);
      InitAC(cl, 8, faColor6, claYellow);

      cl := BottomLeft;
      cla := claWhite;
      InitAC(cl, 1, faRandomBlack, cla);
      InitAC(cl, 2, faColorMix0, claBeige);
      InitAC(cl, 3, faColorMixM, claBeige);
      InitAC(cl, 4, faColorMixP, claBeige);
      InitAC(cl, 5, faToggleBMap, cla);
      InitAC(cl, 6, faTextureJitt, cla);
      InitAC(cl, 7, faPixelCount1, cla);
      InitAC(cl, 8, faPixelCount2, cla);

      cl := BottomRight;
      InitAC(cl, 1, faParamT1, claParam);
      InitAC(cl, 2, faParamT2, claParam);
      InitAC(cl, 3, faParamT3, claParam);
      InitAC(cl, 4, faParamT4, claParam);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faTextureJack, cla);
    end;

    13:
    begin
      CurrentPageCaption := 'Light';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faParamL3X, claParam);
      InitAC(cl, 3, faParamL3Y, claParam);
      InitAC(cl, 4, faParamL3Z, claParam);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faToggleLuxMarker, claOption);

      cl := TopRight;
      InitAC(cl, 1, faTestSingleSide, claOrangeRed);
      InitAC(cl, 2, faUniqueMode1, claOption);
      InitAC(cl, 3, faUniqueMode2, claOption);
      InitAC(cl, 4, faToggleUniqueVertices, claOption);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faParamL4X, claParam);
      InitAC(cl, 7, faParamL4Y, claParam);
      InitAC(cl, 8, faParamL4Z, claParam);

      cl := BottomLeft;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faParamL2X, claParam);
      InitAC(cl, 3, faParamL2Y, claParam);
      InitAC(cl, 4, faParamL2Z, claParam);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faToggleShowEdges, cla);
      InitAC(cl, 7, faWantSideCaps, claOption);
      InitAC(cl, 8, faWantBottom, claOption);

      cl := BottomRight;
      InitAC(cl, 1, faToggleLux1, cla);
      InitAC(cl, 2, faToggleLux2, cla);
      InitAC(cl, 3, faToggleLux3, cla);
      InitAC(cl, 4, faToggleLux4, cla);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faToggleLux, claOption);
    end;

    14:
    begin
      CurrentPageCaption := 'Extra';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleBitmapM, cla);
      InitAC(cl, 3, faCycleBitmapP, cla);
      InitAC(cl, 4, faBitmapEscape, cla);
      InitAC(cl, 5, faBitmapOne, cla);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Blue);

      cl := TopRight;
      InitAC(cl, 1, faWantBottom, claOption);
      InitAC(cl, 2, faWantSpecialY, claOption);
      InitAC(cl, 3, faToggleShowEdges, cla);
      InitAC(cl, 4, faToggleSolidFlip, claOption);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faToggleUniqueVertices, claOption);
      InitAC(cl, 7, faNorthCap, claParam);
      InitAC(cl, 8, faSouthCap, claParam);

      cl := BottomLeft;
      InitAC(cl, 1, faToggleCube, claObject);
      InitAC(cl, 2, faToggleCorner, claObject);
      InitAC(cl, 3, faToggleLimitPlane, claObject);
      InitAC(cl, 4, faToggleMarker, claObject);
      InitAC(cl, 5, faToggleReportLock, claOption);
      InitAC(cl, 6, faToggleOrbitMode, claOption);
      InitAC(cl, 7, faEastCap, claParam);
      InitAC(cl, 8, faWestCap, claParam);

      cl := BottomRight;
      InitAC(cl, 1, faParamCapValue, claParam);
      InitAC(cl, 2, faParamBahnCylinderZ, claParam);
      InitAC(cl, 3, faParamBahnAngle, claParam);
      InitAC(cl, 4, faParamCZ, claParam);
      InitAC(cl, 5, faActionPageE, claPage);
      InitAC(cl, 6, faToggleLux, claOption);
    end;

    15:
    begin
      CurrentPageCaption := 'Example';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faExample01, claExample);
      InitAC(cl, 3, faExample02, claExample);
      InitAC(cl, 4, faExample03, claExample);
      InitAC(cl, 5, faExample04, claExample);
      InitAC(cl, 6, faExample09, claExample);

      cl := TopRight;
      InitAC(cl, 1, faExample05, claExample);
      InitAC(cl, 2, faExample06, claExample);
      InitAC(cl, 3, faExample07, claExample);
      InitAC(cl, 4, faExample08, claExample);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faEyeSizeS, claEyeSize);
      InitAC(cl, 7, faEyeSizeM, claEyeSize);
      InitAC(cl, 8, faEyeSizeL, claEyeSize);

      cl := BottomLeft;
      InitAC(cl, 1, faFigureSizeXS, claFigureSize);
      InitAC(cl, 2, faFigureSizeS, claFigureSize);
      InitAC(cl, 3, faFigureSizeM, claFigureSize);
      InitAC(cl, 4, faFigureSizeL, claFigureSize);
      InitAC(cl, 5, faFigureSizeXL, claFigureSize);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomRight;
      InitAC(cl, 1, faSelectColorMapping1, claColorMapping);
      InitAC(cl, 2, faSelectColorMapping2, claColorMapping);
      InitAC(cl, 3, faSelectColorMapping3, claColorMapping);
      InitAC(cl, 4, faSelectColorMapping4, claColorMapping);
      InitAC(cl, 5, faSelectColorMapping5, claColorMapping);
      InitAC(cl, 6, faSelectColorMapping6, claColorMapping);
    end;

    16:
    begin
      CurrentPageCaption := 'Manual Mapping';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faSelectLayer1, claLayerSelection);
      InitAC(cl, 3, faSelectLayer2, claLayerSelection);
      InitAC(cl, 4, faSelectLayer3, claLayerSelection);
      InitAC(cl, 5, faSelectLayer4, claLayerSelection);
      InitAC(cl, 6, faNoop, claNoop);

      cl := TopRight;
      InitAC(cl, 1, faSelectLayer5, claLayerSelection);
      InitAC(cl, 2, faSelectLayer6, claLayerSelection);
      InitAC(cl, 3, faSelectLayer7, claLayerSelection);
      InitAC(cl, 4, faNoop, claNoop);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faMapColorToLayer, claCrimson);

      cl := BottomLeft;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomRight;
      InitAC(cl, 1, faSelectColor1, claColorSelection);
      InitAC(cl, 2, faSelectColor2, claColorSelection);
      InitAC(cl, 3, faSelectColor3, claColorSelection);
      InitAC(cl, 4, faSelectColor4, claColorSelection);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);
    end;

    17:
    begin
      CurrentPageCaption := 'Palette';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);

      cl := TopRight;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomLeft;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomRight;
      InitAC(cl, 1, faSelectColor1, claColorSelection);
      InitAC(cl, 2, faSelectColor2, claColorSelection);
      InitAC(cl, 3, faSelectColor3, claColorSelection);
      InitAC(cl, 4, faSelectColor4, claColorSelection);
      InitAC(cl, 5, faActionPageE, claPage);
      InitAC(cl, 6, faPaletteOn, claCrimson);
    end;

    18:
    begin
      CurrentPageCaption := 'Sample';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleBitmapM, cla);
      InitAC(cl, 3, faCycleBitmapP, cla);
      InitAC(cl, 4, faBitmapEscape, cla);
      InitAC(cl, 5, faBitmapOne, cla);
      InitAC(cl, 6, faCLA, claNavy);

      cl := TopRight;
      cla := claWhite;
      InitAC(cl, 1, faCycleColorSchemeM, cla);
      InitAC(cl, 2, faCycleColorSchemeP, cla);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faSwapBundle, claSample);
      InitAC(cl, 8, faGotoSample1, claSample);

      cl := BottomLeft;
      InitAC(cl, 1, faActionPage1, claPage);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faShowInfo, cla);

      cl := BottomRight;
      InitAC(cl, 1, faHubM, claSample);
      InitAC(cl, 2, faHubP, claSample);
      InitAC(cl, 3, faSampleM, claSample);
      InitAC(cl, 4, faSampleP, claSample);
      InitAC(cl, 5, faActionPageE, claPage);
      InitAC(cl, 6, faNoop, claNoop);
    end;

    19:
    begin
      CurrentPageCaption := 'Exporter OBJ';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claYellow);
      InitAC(cl, 2, faObjDigits2, claExporter);
      InitAC(cl, 3, faObjDigits3, claExporter);
      InitAC(cl, 4, faObjDigits4, claExporter);
      InitAC(cl, 5, faObjDigits5, claExporter);
      InitAC(cl, 6, faNoop, claNoop);

      cl := TopRight;
      InitAC(cl, 1, faWantMaterial, claExporter);
      InitAC(cl, 2, faWantSimpleName, claExporter);
      InitAC(cl, 3, faWantAutoFolder, claExporter);
      InitAC(cl, 4, faNoop, claNoop);
      //InitAC(cl, 5, faActionPageP, claYellow);
      InitAC(cl, 6, faWantNormals, claExporter);
      InitAC(cl, 7, faWantUVs, claExporter);
      InitAC(cl, 8, faTestSingleSide, claOrangeRed);

      cl := BottomLeft;
      InitAC(cl, 1, faExportCoordsNative, claExporter);
      InitAC(cl, 2, faExportCoordsBlender, claExporter);
      InitAC(cl, 3, faExportCoords3DV, claExporter);
      InitAC(cl, 4, faExportCoords3DP, claExporter);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faToggleSolidFlip, claOption);
      InitAC(cl, 7, faWantSideCaps, claOption);
      InitAC(cl, 8, faWantBottom, claOption);

      cl := BottomRight;
      InitAC(cl, 1, faExportObj, ColorAccent);
      InitAC(cl, 2, faExportMtl, ColorAccent);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faToggleShowEdges, cla);
    end;

  end;
end;

end.
