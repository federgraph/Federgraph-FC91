unit RiggVar.FB.Scheme;

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
  System.UIConsts;

type
  TColorScheme = record
  public
    Scheme: Integer;
    SchemeDefault: Integer;
    claBackground: TAlphaColor;
    claHint: TAlphaColor;

    claLabelText: TAlphaColor;
    claSampleText: TAlphaColor;
    claOptionText: TAlphaColor;
    claToolBtnFill: TAlphaColor;
    claTouchBtnFill: TAlphaColor;
    claCornerScrollbar: TAlphaColor;
    claCornerBtnText: TAlphaColor;
    claEquationFill: TAlphaColor;
    claEquationText: TAlphaColor;
    claTouchbarText: TAlphaColor;

    IsDark: Boolean;

    Dark: Integer;
    Light: Integer;

    constructor Create(cs: Integer);

    procedure BlackText;
    procedure GrayText;
    procedure WhiteText;

    procedure Init(cs: Integer);
  end;

implementation

{ TColorScheme }

procedure TColorScheme.BlackText;
begin
  claLabelText := claBlack;
  claSampleText := claBlack;
  claToolBtnFill := claGray;
  claTouchBtnFill := claGray;
  claCornerScrollbar := claGray;
  claCornerBtnText:= claBlue;
  claEquationFill := claNull;
  claEquationText := claBlack;
  claOptionText := claSampleText;
  claHint := claYellow;
end;

procedure TColorScheme.GrayText;
begin
  claLabelText := claGray;
  claSampleText := claGray;
  claToolBtnFill := claGray;
  claTouchBtnFill := claGray;
  claCornerScrollbar := claGray;
  claCornerBtnText:= claBlue;
  claEquationFill := claNull;
  claEquationText := claBlack;
  claOptionText := claSampleText;
  claHint := claYellow;
end;

procedure TColorScheme.WhiteText;
begin
  claLabelText := claWhite;
  claSampleText := claWhite;
  claToolBtnFill := claWhite;
  claTouchBtnFill := claWhite;
  claCornerScrollbar := claGray;
  claCornerBtnText:= claWhite;
  claEquationFill := claNull;
  claEquationText := claWhite;
  claOptionText := claSampleText;
  claHint := claBlue;
end;

constructor TColorScheme.Create(cs: Integer);
begin
  Dark := 5;
  Light := 2;
  claTouchbarText := claBlack;
  SchemeDefault := cs;
  Scheme := SchemeDefault;
  Init(Scheme);
end;

procedure TColorScheme.Init(cs: Integer);
begin
  Scheme := cs;
  IsDark := True;
  case cs of
    1:
    begin
      IsDark := False;
      claBackground := claBisque;
      claLabelText := claBlack;
      claSampleText := claBlack;
      claToolBtnFill := claBlack;
      claTouchBtnFill := claSilver;
      claCornerScrollbar := claBurlywood;
      claCornerBtnText:= claDimgray;
      claEquationFill := claNull;
      claEquationText := claBlack;
      claHint := claCornflowerblue;
    end;
    2:
    begin
      IsDark := False;
      claBackground := claAntiquewhite;
      claLabelText := claBlack;
      claSampleText := claBlack;
      claToolBtnFill := claBlue;
      claTouchBtnFill := claLightblue;
      claCornerScrollbar := claLightblue;
      claCornerBtnText:= claBlue;
      claEquationFill := claNull;
      claEquationText := claBlack;
      claHint := claCornflowerblue;
    end;
    3:
    begin
      claBackground := claDarkslategray;
      claLabelText := claWhite;
      claSampleText := claWhite;
      claToolBtnFill := claGray;
      claTouchBtnFill := claGray;
      claCornerScrollbar := claGray;
      claCornerBtnText:= claBlue;
      claEquationFill := claNull;
      claEquationText := claWhite;
      claHint := claYellow;
    end;
    4:
    begin
      claBackground := StringToAlphaColor('#FF372E69');
      claLabelText := claWhite;
      claSampleText := claWhite;
      claToolBtnFill := claWhite;
      claTouchBtnFill := claWhite;
      claCornerScrollbar := claWhite;
      claCornerBtnText:= claWhite;
      claEquationFill := claNull;
      claEquationText := claWhite;
      claHint := claYellow;
    end;
    5:
    begin
      claBackground := StringToAlphaColor('#FF333333');
      claLabelText := claWhite;
      claSampleText := claWhite;
      claToolBtnFill := claWhite;
      claTouchBtnFill := claWhite;
      claCornerScrollbar := claGray;
      claCornerBtnText:= claWhite;
      claEquationFill := claNull;
      claEquationText := claWhite;
      claHint := claYellow;
    end;
    6:
    begin
      claBackground := StringToAlphaColor('#FF444444');
      claLabelText := claWhite;
      claSampleText := claWhite;
      claToolBtnFill := claWhite;
      claTouchBtnFill := claWhite;
      claCornerScrollbar := claGray;
      claCornerBtnText:= claWhite;
      claEquationFill := claNull;
      claEquationText := claWhite;
      claHint := claYellow;
    end;
    7:
    begin
      claBackground := StringToAlphaColor('#FF555555');
      claLabelText := claWhite;
      claSampleText := claWhite;
      claToolBtnFill := claWhite;
      claTouchBtnFill := claWhite;
      claCornerScrollbar := claGray;
      claCornerBtnText:= claWhite;
      claEquationFill := claNull;
      claEquationText := claWhite;
      claHint := claYellow;
    end;
    8:
    begin
      IsDark := False;
      claBackground := claWhite;
      claLabelText := claBlack;
      claSampleText := claBlack;
      claToolBtnFill := claBlue;
      claTouchBtnFill := claLightblue;
      claCornerScrollbar := claLightblue;
      claCornerBtnText:= claBlue;
      claEquationFill := claNull;
      claEquationText := claBlack;
      claHint := claCornflowerblue;
    end;
    9:
    begin
      claBackground := claNull;
      claLabelText := claBlack;
      claSampleText := claBlack;
      claToolBtnFill := claGray;
      claTouchBtnFill := claGray;
      claCornerScrollbar := claGray;
      claCornerBtnText:= claWhite;
      claEquationFill := claNull;
      claEquationText := claBlack;
      claHint := claBlack;
    end;
  end;
  claOptionText := claSampleText;
end;

end.