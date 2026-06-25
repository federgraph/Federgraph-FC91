unit FrmColor;

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
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Classes,
  FMX.Colors,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Objects,
  FMX.ListBox,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  RiggVar.FB.Color,
  RiggVar.FB.ColorListBox,
  RiggVar.FB.ColorListBoxWeb,
  RiggVar.FederModel.RingBuilder;

type
  TFormColor = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    ML: TStrings;
    Text: TText; // text below color swat rectangle

    ColorListBox: TRggColorListBox; // left aligned, all colors
    Rectangle: TRectangle; // color swat in the middle
    WebColorListBox: TRggWebColorListBox; // right aligned, for color groups

    ReadBtn: TButton;
    Btn1: TButton;
    Btn2: TButton;
    Btn3: TButton;
    Btn4: TButton;
    WriteBtn: TButton;

    AllBtn: TButton;
    WebBtn: TButton;
    ExtraBtn: TButton;
    BambuBtn: TButton;
    BasicBtn: TButton;
    MatteBtn: TButton;

    BackBtn: TButton;

    Margin: Integer;

    FColorPool: TRggColorPoolBase;

    FColor: TRggColor;
    FColorGroup: TRggColorGroup;
    FCurrentGroup: TRggColorGroup;
    FColorIndex: Integer;

    FSelectedPrintColor: Integer;
    FColorUpdateCounter: Integer;
    ColorSet: TPrintColorSet;

    procedure ColorListBoxChange(Sender: TObject);
    procedure WebColorListBoxChange(Sender: TObject);
    procedure RectangleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);

    procedure SelectColor1BtnClick(Sender: TObject);
    procedure SelectColor2BtnClick(Sender: TObject);
    procedure SelectColor3BtnClick(Sender: TObject);
    procedure SelectColor4BtnClick(Sender: TObject);
    procedure ReadColorBtnClick(Sender: TObject);
    procedure WriteColorBtnClick(Sender: TObject);

    procedure AllBtnClick(Sender: TObject);
    procedure WebBtnClick(Sender: TObject);
    procedure ExtraBtnClick(Sender: TObject);
    procedure BambuBtnClick(Sender: TObject);
    procedure BasicBtnClick(Sender: TObject);
    procedure MatteBtnClick(Sender: TObject);

    procedure BackBtnClick(Sender: TObject);

    procedure UpdateText;
    procedure UpdateSelectedColorValue;
  end;

var
  FormColor: TFormColor;

implementation

{$R *.fmx}

uses
  RiggVar.App.Main,
  RiggVar.Util.AppUtils;

procedure TFormColor.FormCreate(Sender: TObject);
begin
  ClientWidth := 800;
  ClientHeight := 600;

  Margin := 10;
  FSelectedPrintColor := 1;
  FColor := TExtraColors.Windowgray;
  FColorGroup := TRggColorGroup.CombinedGroup;
  FColorPool := ColorVar.RggColorPool;

  Caption := 'Form Color';

  ML := TStringList.Create;

  ColorListBox := TRggColorListBox.Create(Self);
  ColorListBox.Parent := Self;
  ColorListBox.Align := TAlignLayout.Left;
  ColorListBox.OnChange := ColorListBoxChange;

  WebColorListBox := TRggWebColorListBox.Create(Self);
  WebColorListBox.Parent := Self;
  WebColorListBox.Align := TAlignLayout.Right;
  WebColorListBox.OnChange := WebColorListBoxChange;
  WebColorListBox.ColorGroup := OrangeGroup;

  Rectangle := TRectangle.Create(Self);
  Rectangle.Parent := Self;
  Rectangle.Position.X := ColorListBox.Position.X + ColorListBox.Width + Margin;
  Rectangle.Position.Y := Margin;
  Rectangle.Width := 145;
  Rectangle.Height := 145;
  Rectangle.OnMouseWheel := RectangleMouseWheel;

  Text := TText.Create(Self);
  Text.Parent := Self;
  Text.TextSettings.Font.Size := 14;
  Text.TextSettings.Font.Family := TAppUtils.GetMonspacedFontFamilyName;
{$ifdef MSWINDOWS}
  Text.TextSettings.FontColor := TAlphaColors.Dodgerblue;
{$else}
  Text.TextSettings.FontColor := TAlphaColors.Black;
{$endif}
  Text.TextSettings.HorzAlign := TTextAlign.Leading;
  Text.WordWrap := False;
  Text.AutoSize := True;
  Text.Text := 'Text';
  Text.Position.X := Rectangle.Position.X;
  Text.Position.Y := Rectangle.Position.Y + Rectangle.Height + 50;

  ReadBtn := TButton.Create(Self);
  ReadBtn.Parent := Self;
  ReadBtn.Width := ReadBtn.Width * 1.5;
  ReadBtn.Position.X := Rectangle.Position.X + Rectangle.Width + Margin;
  ReadBtn.Position.Y := Rectangle.Position.Y;
  ReadBtn.Text := 'Read Color';
  ReadBtn.OnClick := ReadColorBtnClick;

  Btn1 := TButton.Create(Self);
  Btn1.Parent := Self;
  Btn1.Position.X := ReadBtn.Position.X;
  Btn1.Position.Y := ReadBtn.Position.Y + ReadBtn.Height + Margin;
  Btn1.Text := 'Color 1';
  Btn1.OnClick := SelectColor1BtnClick;

  Btn2 := TButton.Create(Self);
  Btn2.Parent := Self;
  Btn2.Position.X := Btn1.Position.X + Btn1.Width + Margin;
  Btn2.Position.Y := Btn1.Position.Y;
  Btn2.Text := 'Color 2';
  Btn2.OnClick := SelectColor2BtnClick;

  Btn3 := TButton.Create(Self);
  Btn3.Parent := Self;
  Btn3.Position.X := Btn1.Position.X;
  Btn3.Position.Y := Btn1.Position.Y + Btn1.Height + Margin;
  Btn3.Text := 'Color 3';
  Btn3.OnClick := SelectColor3BtnClick;

  Btn4 := TButton.Create(Self);
  Btn4.Parent := Self;
  Btn4.Position.X := Btn2.Position.X;
  Btn4.Position.Y := Btn3.Position.Y;
  Btn4.Text := 'Color 4';
  Btn4.OnClick := SelectColor4BtnClick;

  WriteBtn := TButton.Create(Self);
  WriteBtn.Parent := Self;
  WriteBtn.Width := WriteBtn.Width * 1.5;
  WriteBtn.Position.X := Btn4.Position.X + Btn4.Width - WriteBtn.Width;
  WriteBtn.Position.Y := Btn4.Position.Y + Btn4.Height + Margin;
  WriteBtn.Text := 'Write Color';
  WriteBtn.OnClick := WriteColorBtnClick;

  { button row below text }

  AllBtn := TButton.Create(Self);
  AllBtn.Parent := Self;
  AllBtn.Position.X := Rectangle.Position.X;
  AllBtn.Position.Y := 480;
  AllBtn.Text := 'All';
  AllBtn.OnClick := AllBtnClick;

  WebBtn := TButton.Create(Self);
  WebBtn.Parent := Self;
  WebBtn.Position.X := AllBtn.Position.X + AllBtn.Width + Margin;
  WebBtn.Position.Y := AllBtn.Position.Y;
  WebBtn.Text := 'Web';
  WebBtn.OnClick := WebBtnClick;

  ExtraBtn := TButton.Create(Self);
  ExtraBtn.Parent := Self;
  ExtraBtn.Position.X := WebBtn.Position.X + WebBtn.Width + Margin;
  ExtraBtn.Position.Y := WebBtn.Position.Y;
  ExtraBtn.Text := 'Extra';
  ExtraBtn.OnClick := ExtraBtnClick;

  { new button row }

  BambuBtn := TButton.Create(Self);
  BambuBtn.Parent := Self;
  BambuBtn.Position.X := AllBtn.Position.X;
  BambuBtn.Position.Y := AllBtn.Position.Y + AllBtn.Height + Margin;
  BambuBtn.Text := 'Bambulab';
  BambuBtn.OnClick := BambuBtnClick;

  BasicBtn := TButton.Create(Self);
  BasicBtn.Parent := Self;
  BasicBtn.Position.X := BambuBtn.Position.X + BambuBtn.Width + Margin;
  BasicBtn.Position.Y := BambuBtn.Position.Y;
  BasicBtn.Text := 'Basic';
  BasicBtn.OnClick := BasicBtnClick;

  MatteBtn := TButton.Create(Self);
  MatteBtn.Parent := Self;
  MatteBtn.Position.X := BasicBtn.Position.X + BasicBtn.Width + Margin;
  MatteBtn.Position.Y := BambuBtn.Position.Y;
  MatteBtn.Text := 'Matte';
  MatteBtn.OnClick := MatteBtnClick;

  { new button row }

  BackBtn := TButton.Create(Self);
  BackBtn.Parent := Self;
  BackBtn.Position.X := BambuBtn.Position.X;
  BackBtn.Position.Y := BambuBtn.Position.Y + BambuBtn.Height + Margin;
  BackBtn.Text := 'Back';
  BackBtn.OnClick := BackBtnClick;

  ReadColorBtnClick(Self);

  UpdateText;
end;

procedure TFormColor.FormDestroy(Sender: TObject);
begin
  ML.Free;
end;

procedure TFormColor.ColorListBoxChange(Sender: TObject);
var
  c: TRggColor;
  g: TRggColorGroup;
begin
  c := ColorListBox.Color;

  g := FColorPool.ColorToGroup(c);
  if g <> FCurrentGroup then
  begin
    FCurrentGroup := g;
    WebColorListbox.ColorGroup := g;
  end;

  WebColorListbox.Color := c;

  FColor := c;
  FColorIndex := FColorPool.GetColorIndex(FColor);
  FColorGroup := g;

  Rectangle.Fill.Color := c;
  UpdateText;
end;

procedure TFormColor.WebColorListBoxChange(Sender: TObject);
begin
  FColor := WebColorListBox.Color;
  FColorIndex := FColorPool.GetColorIndex(FColor);

  Rectangle.Fill.Color := FColor;
  UpdateText;
end;

procedure TFormColor.RectangleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  i: Integer;
  j: Integer;
begin
  i := FColorIndex;

  if WheelDelta > 0 then
    Inc(i)
  else
    Dec(i);

  if (i > -1) and (i < FColorPool.Count) then
  begin
    j := FColorPool.ColorMap[i].IndexN;
    FColor := FColorPool.ColorMap[j].Value;
    FColorIndex := i;

    Rectangle.Fill.Color := FColor;
    UpdateText;
  end;
end;

procedure TFormColor.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  case KeyChar of
    'a': WebColorListBox.ColorGroup := CombinedGroup;

    'b': WebColorListBox.ColorGroup := BrownGroup;
    'c': WebColorListBox.ColorGroup := CyanGroup;
    'g': WebColorListBox.ColorGroup := GrayGroup;
    'o': WebColorListBox.ColorGroup := OrangeGroup;
    'p': WebColorListBox.ColorGroup := PinkGroup;
    'r': WebColorListBox.ColorGroup := RedGroup;
    'w': WebColorListBox.ColorGroup := WhiteGroup;
    'y': WebColorListBox.ColorGroup := YellowGroup;

    'B': WebColorListBox.ColorGroup := BlueGroup;
    'G': WebColorListBox.ColorGroup := GreenGroup;
    'P': WebColorListBox.ColorGroup := PurpleGroup;

    'X': WebColorListBox.ColorGroup := ExtraGroup;
    'Y': WebColorListBox.ColorGroup := BasicGroup;
    'Z': WebColorListBox.ColorGroup := MatteGroup;
  end;
end;

procedure TFormColor.UpdateText;
var
  cr: TAlphaColorRec;
begin
  UpdateSelectedColorValue;

  cr.Color := FColor;

  ML.Clear;

  ML.Add(Format('Index A = %d', [FColorPool.ColorToIndexA(FColor)]));
  ML.Add(Format('Index N = %d', [FColorPool.ColorToIndexN(FColor)]));
  ML.Add(Format('Name  = %s', [FColorPool.ColorToString(FColor)]));
  ML.Add(Format('Group = %s', [FColorPool.ColorGroupToGroupName(FColorGroup)]));
  ML.Add(Format('Kind  = %s', [FColorPool.GetColorKindString(FColor)]));
  ML.Add(Format('Hex   = (%3.2x, %3.2x, %3.2x)', [cr.R, cr.G, cr.B]));
  ML.Add(Format('RBG   = (%3d, %3d, %3d)', [cr.R, cr.G, cr.B]));
  ML.Add('');
  ML.Add(Format('ColorUpdateCounter = %d', [FColorUpdateCounter]));
  ML.Add(Format('SelectedColor = %d (%s)', [FSelectedPrintColor, FColorPool.ColorToString(FColor)]));
  ML.Add('');
  ML.Add(Format('Color1 Dunkel = %s', [FColorPool.ColorToString(ColorSet.Color1)]));
  ML.Add(Format('Color2 Hell   = %s', [FColorPool.ColorToString(ColorSet.Color2)]));
  ML.Add(Format('Color3 Ring   = %s', [FColorPool.ColorToString(ColorSet.Color3)]));
  ML.Add(Format('Color4 Rim    = %s', [FColorPool.ColorToString(ColorSet.Color4)]));

  Text.Text := ML.Text;
end;

procedure TFormColor.SelectColor1BtnClick(Sender: TObject);
begin
  FSelectedPrintColor := 1;
  ColorListBox.Color := ColorSet.Color1;
end;

procedure TFormColor.SelectColor2BtnClick(Sender: TObject);
begin
  FSelectedPrintColor := 2;
  ColorListBox.Color := ColorSet.Color2;
end;

procedure TFormColor.SelectColor3BtnClick(Sender: TObject);
begin
  FSelectedPrintColor := 3;
  ColorListBox.Color := ColorSet.Color3;
end;

procedure TFormColor.SelectColor4BtnClick(Sender: TObject);
begin
  FSelectedPrintColor := 4;
  ColorListBox.Color := ColorSet.Color4;
end;

procedure TFormColor.ReadColorBtnClick(Sender: TObject);
begin
  ColorSet := Main.RingBuilder.SelectedColors;

  SelectColor1BtnClick(Self);
end;

procedure TFormColor.WriteColorBtnClick(Sender: TObject);
begin
  Main.UpdatePrintColors(ColorSet);
end;

procedure TFormColor.AllBtnClick(Sender: TObject);
begin
  FColorPool := ColorVar.RggColorPool;
  ColorListBox.ColorPool := FColorPool;
  ColorListBox.ItemIndex := 1;
end;

procedure TFormColor.WebBtnClick(Sender: TObject);
begin
  FColorPool := ColorVar.WebColorPool;
  ColorListBox.ColorPool := FColorPool;
  ColorListBox.ItemIndex := 1;
end;

procedure TFormColor.ExtraBtnClick(Sender: TObject);
begin
  FColorPool := ColorVar.ExtraColorPool;
  ColorListBox.ColorPool := FColorPool;
  ColorListBox.ItemIndex := 1;
end;

procedure TFormColor.BambuBtnClick(Sender: TObject);
begin
  FColorPool := ColorVar.BambuColorPool;
  ColorListBox.ColorPool := FColorPool;
  ColorListBox.ItemIndex := 1;
end;

procedure TFormColor.BasicBtnClick(Sender: TObject);
begin
  FColorPool := ColorVar.PLABasicPool;
  ColorListBox.ColorPool := FColorPool;
  ColorListBox.ItemIndex := 1;
end;

procedure TFormColor.MatteBtnClick(Sender: TObject);
begin
  FColorPool := ColorVar.PLAMattePool;
  ColorListBox.ColorPool := FColorPool;
  ColorListBox.ItemIndex := 1;
end;

procedure TFormColor.BackBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TFormColor.UpdateSelectedColorValue;
begin
  Inc(FColorUpdateCounter);
  case FSelectedPrintColor of
    1: ColorSet.Color1 := FColor;
    2: ColorSet.Color2 := FColor;
    3: ColorSet.Color3 := FColor;
    4: ColorSet.Color4 := FColor;
  end;
end;

end.
