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
  FPageCount := 6;
  FEscapeIndex := 7;
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
//  claExample: TAlphaColor;
//  claFigureSize: TAlphaColor;
//  claEyeSize: TAlphaColor;
//  claLayerSelection: TAlphaColor;
//  claColorSelection: TAlphaColor;
//  claColorMapping: TAlphaColor;
  claSample: TAlphaColor;
  claExporter: TAlphaColor;
//  claObject: TAlphaColor;
begin
  cla := claWhite;
  claNoop := claWhite;
  claPage := ColorPage;
  claForm := claCornflowerblue;
  claParam := claPlum;
  claOption := claCornflowerblue;
  claReset := claOrange;
  claSample := claAquamarine;

//  claExample := claAquamarine;
//  claFigureSize := claDarksalmon;
//  claEyeSize := claPlum;
//  claLayerSelection := claCornflowerblue;
//  claColorSelection := claAquamarine;
//  claColorMapping := claDarkkhaki;
  claExporter := claOrange;
//  claObject := claAquamarine;

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
      InitAC(cl, 5, faActionPage5, claPage);
      InitAC(cl, 6, faToggleLux, claOption);
    end;

    2:
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
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomRight;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faNoop, claNoop);
    end;

    3:
    begin
      CurrentPageCaption := 'Color 2';
      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
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
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomLeft;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faToggleColorPanel, claOption);
      InitAC(cl, 5, faToggleColorSwat, claOption);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faNoop, claNoop);
      InitAC(cl, 8, faNoop, claNoop);

      cl := BottomRight;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faNoop, claNoop);
      InitAC(cl, 4, faNoop, claNoop);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faNoop, claNoop);
    end;

    4:
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
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faCLA, TBambuColors.PLABasic_Turquoise);
    end;

    5:
    begin
      CurrentPageCaption := 'Extra';

      cl := TopLeft;
      //InitAC(cl, 1, faActionPageM, claPage);
      InitAC(cl, 2, faCycleBitmapM, cla);
      InitAC(cl, 3, faCycleBitmapP, cla);
      InitAC(cl, 4, faBitmapEscape, cla);
      InitAC(cl, 5, faBitmapOne, cla);
      InitAC(cl, 6, faRandomBlack, cla);

      cl := TopRight;
      InitAC(cl, 1, faWantBottom, claOption);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faToggleShowEdges, cla);
      InitAC(cl, 4, faToggleSolidFlip, claOption);
      //InitAC(cl, 5, faActionPageP, claPage);
      InitAC(cl, 6, faNorthCap, claParam);
      InitAC(cl, 7, faSouthCap, claParam);
      InitAC(cl, 8, faParamCapValue, claParam);

      cl := BottomLeft;
      InitAC(cl, 1, faNoop, claNoop);
      InitAC(cl, 2, faToggleColorPanel, claOption);
      InitAC(cl, 3, faToggleColorSwat, claOption);
      InitAC(cl, 4, faShowInfo, claForm);
      InitAC(cl, 5, faNoop, claNoop);
      InitAC(cl, 6, faNoop, claNoop);
      InitAC(cl, 7, faCycleColorSchemeM, cla);
      InitAC(cl, 8, faCycleColorSchemeP, cla);

      cl := BottomRight;
      InitAC(cl, 1, faParamCZ, claParam);
      InitAC(cl, 2, faNoop, claNoop);
      InitAC(cl, 3, faReset, claReset);
      InitAC(cl, 4, faBandWidthRelative, claParam);
      InitAC(cl, 5, faActionPage1, claPage);
      InitAC(cl, 6, faToggleLux, claOption);
    end;

    6:
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
      InitAC(cl, 3, faNoop, claNoop);
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
