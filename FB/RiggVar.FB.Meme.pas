unit RiggVar.FB.Meme;

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
  FMX.Types,
  FMX.Forms,
  FMX.Effects,
  FMX.Objects,
  FMX.Text;

type
  TMemeText = class
  private
    FBottomCaption: string;
    FTopCaption: string;
    FVisible: Boolean;
    procedure SetBottomCaption(const Value: string);
    procedure SetTopCaption(const Value: string);
    procedure SetVisible(const Value: Boolean);
  protected
    TopText: TText;
    BottomText: TText;
    TopGlow: TGlowEffect;
    BottomGlow: TGlowEffect;
  public
    constructor Create;
    procedure Init(f: TForm);
    procedure DoOnResize;
    property TopCaption: string read FTopCaption write SetTopCaption;
    property BottomCaption: string read FBottomCaption write SetBottomCaption;
    property Visible: Boolean read FVisible write SetVisible;
  end;

implementation

constructor TMemeText.Create;
begin
  FTopCaption := 'Top Caption';
  FBottomCaption := 'Bottom Caption';
end;

procedure TMemeText.DoOnResize;
begin
  if Assigned(TopText) then
  begin
    TopText.AutoSize := False;
    TopText.AutoSize := True;
    BottomText.AutoSize := False;
    BottomText.AutoSize := True;
  end;
end;

procedure TMemeText.Init(f: TForm);
var
  t: TText;
  g: TGlowEffect;
begin
  TopText := TText.Create(f);
  BottomText := TText.Create(f);
  TopGlow := TGlowEffect.Create(f);
  BottomGlow := TGlowEffect.Create(f);

  f.AddObject(TopText);
  f.AddObject(BottomText);

  t := TopText;
  t.Align := TAlignLayout.Top;
  t.AutoSize := True;
  t.Color := claWhite;
  t.Font.Family := 'Stencil'; //'Showcard Gothic';
  t.Font.Size := 60;
  t.Margins.Top := 10;
  t.Text := TopCaption;
  t.HitTest := False;
  t.HorzTextAlign := TTextAlign.Center;

  g := TopGlow;
  g.Softness := 0.4;
  g.GlowColor := claBlack;
  g.Opacity := 0.5;

  t := BottomText;
  t.HorzTextAlign := TTextAlign.Center;
  t.Align := TAlignLayout.Bottom;
  t.Margins.Bottom := 10;
  t.Color := claWhite;
  t.Text := BottomCaption;
  t.Font.Family := 'Vladimir Script';
  t.Font.Size := 72;
  t.Font.Style := [TFontStyle.fsBold];
  t.HitTest := False;
  t.AutoSize := True;

  g := BottomGlow;
  g.Softness := 0.4;
  g.GlowColor := claBlack;
  g.Opacity := 0.5;

  TopText.AddObject(TopGlow);
  BottomText.AddObject(BottomGlow);
end;

procedure TMemeText.SetBottomCaption(const Value: string);
begin
  FBottomCaption := Value;
end;

procedure TMemeText.SetTopCaption(const Value: string);
begin
  FTopCaption := Value;
end;

procedure TMemeText.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
  TopText.Visible := Value;
  BottomText.Visible := Value;
end;

end.
