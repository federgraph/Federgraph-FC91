unit FrmBambu;

interface

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

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Classes,
  System.Messaging,
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
  RiggVar.FB.ActionConfig,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Color,
  RiggVar.FB.ColorBambu,
  RiggVar.FB.ColorList,
  RiggVar.FB.ColorListBox,
  RiggVar.FB.ColorListBoxP,
  RiggVar.FB.DefConst,
  RiggVar.FederModel.RingBuilder;

type
  TFormBambu = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    ML: TStrings;
    Text: TText;

    UnusedBox: TColorListBoxP;
    DarkBox: TColorListBoxP;
    SkinBox: TColorListBoxP;
    RingBox: TColorListBoxP;

    Btn1: TButton;
    Btn2: TButton;

    Btn3: TButton;
    Btn4: TButton;

    Btn5: TButton;
    Btn6: TButton;

    WriteBtn: TButton;
    BackBtn: TButton;

    Margin: Integer;

    FColorPool: TRggColorPoolBase;

    FColor1: TRggColor;
    FColor2: TRggColor;
    FColor3: TRggColor;
    FColor4: TRggColor;

    IsUp: Boolean;
    LayoutNeeded: Boolean;
    LayoutIsLandscape: Boolean;

    procedure ColorListBoxChange(Sender: TObject);

    procedure Btn1Click(Sender: TObject);
    procedure Btn2Click(Sender: TObject);
    procedure Btn3Click(Sender: TObject);
    procedure Btn4Click(Sender: TObject);
    procedure Btn5Click(Sender: TObject);
    procedure Btn6Click(Sender: TObject);

    procedure UpdateText;

    procedure WriteBtnClick(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);

    procedure MoveLeft(cla: TAlphaColor; ABox: TColorListBoxP);
    procedure MoveRight(cla: TAlphaColor; ABox: TColorListBoxP);

    procedure DoPortraitLayout;
    procedure DoLandscapeLayout;
    procedure DoOrientationChanged(const Sender: TObject; const M: TMessage);
    procedure DoLayout;
  end;

var
  FormBambu: TFormBambu;

implementation

{$R *.fmx}

uses
  FMX.Platform,
  RiggVar.Util.AppUtils,
  RiggVar.App.Main;

procedure TFormBambu.FormCreate(Sender: TObject);
var
  bw: single;
begin
  ClientWidth := 600;
  ClientHeight := 800;

  Margin := 10;

  FColorPool := ColorVar.RggColorPool;

  Caption := 'Form Color Partition';

  ML := TStringList.Create;

  FColorPool := ColorVar.BambuColorPool;

  UnusedBox := TColorListBoxP.Create(Self);
  UnusedBox.Parent := Self;
  UnusedBox.Part := TBambuPart.Unused;
  UnusedBox.OnChange := ColorListBoxChange;
  UnusedBox.ItemIndex := 0;

  DarkBox := TColorListBoxP.Create(Self);
  DarkBox.Parent := Self;
  DarkBox.Part := TBambuPart.Dark;
  DarkBox.OnChange := ColorListBoxChange;
  DarkBox.ItemIndex := 0;

  SkinBox := TColorListBoxP.Create(Self);
  SkinBox.Parent := Self;
  SkinBox.Part := TBambuPart.Skin;
  SkinBox.OnChange := ColorListBoxChange;
  SkinBox.ItemIndex := 0;

  RingBox := TColorListBoxP.Create(Self);
  RingBox.Parent := Self;
  RingBox.Part := TBambuPart.Ring;
  RingBox.OnChange := ColorListBoxChange;
  RingBox.ItemIndex := 0;

  Btn1 := TButton.Create(Self);
  Btn1.Parent := Self;
  bw := Btn1.DefaultSize.Width * 1.7;
  Btn1.Width := bw;
  Btn1.Text := 'move to Dark';
  Btn1.OnClick := Btn1Click;

  Btn2 := TButton.Create(Self);
  Btn2.Parent := Self;
  Btn2.Width := bw;
  Btn2.Text := 'back to Unused';
  Btn2.OnClick := Btn2Click;

  Btn3 := TButton.Create(Self);
  Btn3.Parent := Self;
  Btn3.Width := bw;
  Btn3.Text := 'move to Skin';
  Btn3.OnClick := Btn3Click;

  Btn4 := TButton.Create(Self);
  Btn4.Parent := Self;
  Btn4.Width := bw;
  Btn4.Text := 'back to Unused';
  Btn4.OnClick := Btn4Click;

  Btn5 := TButton.Create(Self);
  Btn5.Parent := Self;
  Btn5.Width := bw;
  Btn5.Text := 'move to Ring';
  Btn5.OnClick := Btn5Click;

  Btn6 := TButton.Create(Self);
  Btn6.Parent := Self;
  Btn6.Width := bw;
  Btn6.Text := 'back to Unused';
  Btn6.OnClick := Btn6Click;

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

  WriteBtn := TButton.Create(Self);
  WriteBtn.Parent := Self;
  WriteBtn.Width := bw;
  WriteBtn.Text := 'Update App';
  WriteBtn.OnClick := WriteBtnClick;

  BackBtn := TButton.Create(Self);
  BackBtn.Parent := Self;
  BackBtn.Text := 'Back';
  BackBtn.OnClick := BackBtnClick;

  FColor1 := UnusedBox.Color;
  FColor2 := DarkBox.Color;
  FColor3 := SkinBox.Color;
  FColor4 := RingBox.Color;

  TMessageManager.DefaultManager.SubscribeToMessage(TOrientationChangedMessage, DoOrientationChanged);
  DoLayout;

  IsUp := True;
  UpdateText;
end;

procedure TFormBambu.FormDestroy(Sender: TObject);
begin
  ML.Free;
end;

procedure TFormBambu.ColorListBoxChange(Sender: TObject);
begin
  if IsUp then
  begin
    FColor1 := UnusedBox.Color;
    FColor2 := DarkBox.Color;
    FColor3 := SkinBox.Color;
    FColor4 := RingBox.Color;

    UpdateText;
  end;
end;

procedure TFormBambu.UpdateText;
begin
  ML.Clear;

  ML.Add(Format('Color1 ---- = %s', [FColorPool.ColorToString(FColor1)]));
  ML.Add(Format('Color2 Dark = %s', [FColorPool.ColorToString(FColor2)]));
  ML.Add(Format('Color3 Skin = %s', [FColorPool.ColorToString(FColor3)]));
  ML.Add(Format('Color4 Ring = %s', [FColorPool.ColorToString(FColor4)]));

  Text.Text := ML.Text;
end;

procedure TFormBambu.Btn1Click(Sender: TObject);
begin
  MoveRight(FColor1, DarkBox);
end;

procedure TFormBambu.Btn2Click(Sender: TObject);
begin
  MoveLeft(FColor2, DarkBox);
end;

procedure TFormBambu.Btn3Click(Sender: TObject);
begin
  MoveRight(FColor1, SkinBox);end;

procedure TFormBambu.Btn4Click(Sender: TObject);
begin
  MoveLeft(FColor3, SkinBox);
end;

procedure TFormBambu.Btn5Click(Sender: TObject);
begin
  MoveRight(FColor1, RingBox);
end;

procedure TFormBambu.Btn6Click(Sender: TObject);
begin
  MoveLeft(FColor4, RingBox);
end;

procedure TFormBambu.MoveRight(cla: TAlphaColor; ABox: TColorListBoxP);
begin
  if UnusedBox.DeleteColor(cla) then
    ABox.AddColor(cla);
end;

procedure TFormBambu.MoveLeft(cla: TAlphaColor; ABox: TColorListBoxP);
begin
  if ABox.DeleteColor(cla) then
    UnusedBox.AddColor(cla);
  if ABox.ItemIndex = ABox.Count then
    ABox.ItemIndex := ABox.Count - 1;
end;

procedure TFormBambu.WriteBtnClick(Sender: TObject);
begin
  Main.BambuPartition.BuildActionItemList;
  Main.ActionItemList.ProcessAll;
end;

procedure TFormBambu.BackBtnClick(Sender: TObject);
begin
  Self.Hide;
end;

procedure TFormBambu.DoOrientationChanged(const Sender: TObject; const M: TMessage);
var
  screenService: IFMXScreenService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, screenService) then
  begin
    LayoutNeeded := True;
    DoLayout;
  end;
end;

procedure TFormBambu.DoLayout;
begin
  if Width > Height then
    DoLandscapeLayout
  else
    DoPortraitLayout;
end;

procedure TFormBambu.DoPortraitLayout;
var
  w: Integer;
  temp1, temp2, temp3: single;
  n: Integer;
begin
  w := 180;
  LayoutIsLandscape := False;

  UnusedBox.Position.X := 10;
  UnusedBox.Position.Y := 10;
  UnusedBox.Width := w;
  UnusedBox.Height := 500;

  DarkBox.Position.X := 400;
  DarkBox.Position.Y := 10;
  DarkBox.Width := w;
  DarkBox.Height := 200;

  SkinBox.Position.X := DarkBox.Position.X;
  SkinBox.Position.Y := DarkBox.Position.Y + DarkBox.Height + Margin;
  SkinBox.Width := w;
  SkinBox.Height := 140;

  RingBox.Position.X := SkinBox.Position.X;
  RingBox.Position.Y := SkinBox.Position.Y + SkinBox.Height + Margin;
  RingBox.Width := w;
  RingBox.Height := 300;

  temp1 := UnusedBox.Position.X + UnusedBox.Width;
  temp2 := DarkBox.Position.X;
  temp3 := (temp2 - temp1 - Btn1.Width) / 2;

  n := 3;
  Btn1.Position.X := temp1 + temp3;
  Btn1.Position.Y := DarkBox.Position.Y + n * Margin;

  Btn2.Position.X := Btn1.Position.X;
  Btn2.Position.Y := Btn1.Position.Y + Btn1.Height + Margin;

  Btn3.Position.X := Btn1.Position.X;
  Btn3.Position.Y := SkinBox.Position.Y + n * Margin;

  Btn4.Position.X := Btn3.Position.X;
  Btn4.Position.Y := Btn3.Position.Y + Btn3.Height + Margin;

  Btn5.Position.X := Btn1.Position.X;
  Btn5.Position.Y := RingBox.Position.Y + n * Margin;

  Btn6.Position.X := Btn5.Position.X;
  Btn6.Position.Y := Btn5.Position.Y + Btn5.Height + Margin;

  Text.Position.X := UnusedBox.Position.X + 20;
  Text.Position.Y := UnusedBox.Position.X + UnusedBox.Height + Margin;

  BackBtn.Position.X := Text.Position.X;
  BackBtn.Position.Y := Text.Position.Y + 100;

  WriteBtn.Position.X := BackBtn.Position.X + BackBtn.Width + Margin;
  WriteBtn.Position.Y := BackBtn.Position.Y;
end;

procedure TFormBambu.DoLandscapeLayout;
var
  w: Integer;
  x, y: single;
begin
  LayoutIsLandscape := True;
  w := 180;

  UnusedBox.Position.X := Margin;
  UnusedBox.Position.Y := Margin;
  UnusedBox.Width := w;
  UnusedBox.Height := 400;

  DarkBox.Position.X := UnusedBox.Position.X + w + Margin;
  DarkBox.Position.Y := Margin;
  DarkBox.Width := w;
  DarkBox.Height := 200;

  SkinBox.Position.X := DarkBox.Position.X + w + Margin;
  SkinBox.Position.Y := Margin;
  SkinBox.Width := w;
  SkinBox.Height := 200;

  RingBox.Position.X := SkinBox.Position.X + w + Margin;
  RingBox.Position.Y := Margin;
  RingBox.Width := w;
  RingBox.Height := 200;

  x := (w - Btn1.Width) / 2;
  y := DarkBox.Position.Y + DarkBox.Height + Margin;
  Btn1.Position.X := DarkBox.Position.X + x;
  Btn1.Position.Y := y;

  Btn2.Position.X := Btn1.Position.X;
  Btn2.Position.Y := Btn1.Position.Y + Btn1.Height + Margin;

  Btn3.Position.X := SkinBox.Position.X + x;
  Btn3.Position.Y := y;

  Btn4.Position.X := Btn3.Position.X;
  Btn4.Position.Y := Btn3.Position.Y + Btn3.Height + Margin;

  Btn5.Position.X := RingBox.Position.X + x;
  Btn5.Position.Y := y;

  Btn6.Position.X := Btn5.Position.X;
  Btn6.Position.Y := Btn5.Position.Y + Btn5.Height + Margin;

  Text.Position.X := DarkBox.Position.X + Margin;
  Text.Position.Y := Btn2.Position.Y + Btn2.Height + Margin;

  BackBtn.Position.X := Text.Position.X;
  BackBtn.Position.Y := Text.Position.Y + 100;

  WriteBtn.Position.X := BackBtn.Position.X + BackBtn.Width + Margin;
  WriteBtn.Position.Y := BackBtn.Position.Y;
end;

procedure TFormBambu.FormResize(Sender: TObject);
var
  LS: Boolean;
begin
  LS := Width > Height;
  if IsUp and (LS <> LayoutIsLandscape) then
    DoLayout;
end;

end.
