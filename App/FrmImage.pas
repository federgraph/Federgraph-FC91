unit FrmImage;

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
  System.IOUtils,
  System.Generics.Collections,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects;

type
  TMemoAction = record
  public
    Tag: Integer;
    Caption: string;
    Handler: TNotifyEvent;
  end;

  TMemoActionList = class (TList<TMemoAction>)
  public
    procedure AddMemoAction(ACaption: string; AHandler: TNotifyEvent);
    function FindByTag(ATag: Integer): TMemoAction;
  end;

  TFormImage = class(TForm)
    ToolbarPanel: TPanel;
    ListView: TListView;
    Memo: TMemo;
    BackBtn: TButton;
    SaveBtn: TButton;
    Image: TImage;
    CopyBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveBtnClick(Sender: TObject);
    procedure ListViewItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure BackBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
  private
    SL: TStringList;
    MemoActionList: TMemoActionList;
    Margin: Integer;
    FSaveDialog: TSaveDialog;
    FImageName: string;

    procedure InitItems;
    procedure InitList;
    function GetDirectoryName: string;
    procedure ShowBitmapProps;

    procedure ShowCurrent(Sender: TObject);
    procedure CreateScreenshot(Sender: TObject);
    procedure CreateBitmap3D(Sender: TObject);
    procedure CreateImprintedBitmap(Sender: TObject);
    procedure CreateTextureBitmap(Sender: TObject);
  end;

var
  FormImage: TFormImage;

implementation

{$R *.fmx}

uses
  RiggVar.FB.ActionConst,
  RiggVar.Util.AppUtils,
  RiggVar.App.Main;

{ TMemoActionList }

procedure TMemoActionList.AddMemoAction(ACaption: string; AHandler: TNotifyEvent);
var
  ma: TMemoAction;
begin
  ma.Caption := ACaption;
  ma.Handler := AHandler;
  ma.Tag := Self.Count;
  Self.Add(ma);
end;

function TMemoActionList.FindByTag(ATag: Integer): TMemoAction;
var
  cr: TMemoAction;
begin
  result.Caption := 'not found';
  for cr in Self do
    if cr.Tag = ATag then
    begin
      result := cr;
      break;
    end;
end;

procedure TFormImage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caHide;
end;

procedure TFormImage.FormCreate(Sender: TObject);
begin
  Caption := 'Form Memo';
  Left := 10;
  Top := 120;
  Width := 800;
  Height := 750;
  SL := TStringList.Create;
  FImageName := 'FC-Image';

  Margin := 10;

  ListView.CanSwipeDelete := False;
  ListView.Align := TAlignLayout.Left;
  ListView.StyleLookup := 'listviewstyle';
  ListView.ItemAppearanceName := 'ListItem';
  ListView.ItemAppearanceObjects.HeaderObjects.Text.Visible := False;
  ListView.ItemAppearanceObjects.FooterObjects.Text.Visible := False;
  ListView.ItemAppearanceObjects.ItemObjects.Text.TextColor := TAlphaColors.Dodgerblue;
  ListView.ItemAppearanceObjects.ItemObjects.Accessory.Visible := False;
{$ifdef MSWINDOWS}
  ListView.ItemAppearance.ItemHeight := 24;
  ListView.ItemAppearanceObjects.ItemObjects.Text.Font.Family := 'Consolas';
  ListView.ItemAppearanceObjects.ItemObjects.Text.Font.Size := 16;
{$endif}
{$ifdef OSX}
  ListView.ItemAppearance.ItemHeight := 24;
  ListView.ItemAppearanceObjects.ItemObjects.Text.Font.Size := 16;
{$endif}
{$ifdef IOS}
  ListView.ItemAppearance.ItemHeight := 24;
  ListView.ItemAppearanceObjects.ItemObjects.Text.Font.Size := 16;
{$endif}
{$ifdef Android}
  ListView.ItemAppearance.ItemHeight := 28;
  ListView.ItemAppearanceObjects.ItemObjects.Text.Font.Size := 16;
{$endif}

  Memo.Align := TAlignLayout.None;
  Memo.ControlType := TControlType.Styled;
  Memo.ShowScrollBars := True;
  Memo.StyleLookup := 'memostyle';
  Memo.StyledSettings := [TStyledSetting.FontColor, TStyledSetting.Other];
  Memo.TextSettings.Font.Family := TAppUtils.GetMonspacedFontFamilyName;
  Memo.TextSettings.Font.Size := 14;

  Memo.Position.X := ListView.Position.X + ListView.Width + Margin;
  Memo.Position.Y := ToolbarPanel.Height + Margin;
  Memo.Width := 500;
  Memo.Height := 200;

  Image.Position.X := Memo.Position.X;
  Image.Position.Y := Memo.Position.Y + Memo.Height + Margin;
  Image.Width := Memo.Width;
  Image.Height := 400;

{ because of StyleLookup memostyle
  background can be black on iOS when dark theme is activated at night time }
//  Memo.TextSettings.FontColor := claBlack;

  MemoActionList := TMemoActionList.Create;
  InitList;
  InitItems;

  BackBtn.Visible := True;
  SaveBtn.Visible := True;
end;

procedure TFormImage.FormDestroy(Sender: TObject);
begin
  SL.Free;
  MemoActionList.Free;
  FSaveDialog.Free;
end;

procedure TFormImage.ShowCurrent(Sender: TObject);
begin
  Image.Bitmap := Main.BitmapCache.Bitmap;
end;

procedure TFormImage.ShowBitmapProps;
begin
  Memo.Lines.Add(Format('(%d, %d)', [Image.Bitmap.Width, Image.Bitmap.Height]));
end;

procedure TFormImage.CreateScreenshot(Sender: TObject);
begin
  FImageName := 'FC-Screenshot.png';
  Memo.Text := 'Screenshot';
  Main.ActionHandler.Execute(faCopyScreenshot);
  Image.Bitmap := Main.BitmapCache.Bitmap;
  ShowBitmapProps;
end;

procedure TFormImage.CreateBitmap3D(Sender: TObject);
begin
  FImageName := 'FC-Bitmap3D.png';
  Memo.Text := 'Bitmap 3D';
  Main.ActionHandler.Execute(faCopyBitmap3D);
  Image.Bitmap := Main.BitmapCache.Bitmap;
  ShowBitmapProps;
end;

procedure TFormImage.CreateImprintedBitmap(Sender: TObject);
begin
  FImageName := 'FC-ImprintedBitmap.png';
  Memo.Text := 'Imprinted Bitmap';
  Main.ActionHandler.Execute(faCopyImprintedBitmap);
  Image.Bitmap := Main.BitmapCache.Bitmap;
  ShowBitmapProps;

end;

procedure TFormImage.CreateTextureBitmap(Sender: TObject);
begin
  FImageName := 'FC-TextureBitmap.png';
  Memo.Text := 'Texture Bitmap 3D';
  Main.ActionHandler.Execute(faCopyTextureBitmap);
  Image.Bitmap := Main.BitmapCache.Bitmap;
  ShowBitmapProps;
end;

procedure TFormImage.InitList;
begin
  MemoActionList.AddMemoAction('Current', ShowCurrent);
  MemoActionList.AddMemoAction('Screenshot', CreateScreenshot);
  MemoActionList.AddMemoAction('Bitmap 3D', CreateBitmap3D);
  MemoActionList.AddMemoAction('Imprinted Bitmap', CreateImprintedBitmap);
  MemoActionList.AddMemoAction('Texture Bitmap', CreateTextureBitmap);
end;

procedure TFormImage.InitItems;
var
  cr: TMemoAction;
  lvi: TListViewItem;
begin
  ListView.Items.Clear;
  for cr in MemoActionList do
  begin
    lvi := ListView.Items.Add;
    lvi.Text := cr.Caption;
    lvi.Tag := cr.Tag;
    lvi.Height := 24;
  end;
end;

procedure TFormImage.ListViewItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  cr: TMemoAction;
begin
  cr := MemoActionList.FindByTag(AItem.Tag);
  if cr.Tag > -1 then
    cr.Handler(nil);
end;

function TFormImage.GetDirectoryName: string;
begin
  result := '';

{$ifdef MSWINDOWS}
  result := 'D:\Bilder';

  if not DirectoryExists(result) then
  begin
    result  := TAppUtils.GetUserPicturesDir;
  end;
{$endif}
end;

procedure TFormImage.SaveBtnClick(Sender: TObject);
var
  dn: string;
  fn: string;
begin
  dn := GetDirectoryName;
  fn := System.IOUtils.TPath.Combine(dn, FImageName);

  if FSaveDialog = nil then
    FSaveDialog := TSaveDialog.Create(nil);
  FSaveDialog.FileName := System.IOUtils.TPath.Combine(dn, fn);

  FSaveDialog.InitialDir := dn;
  FSaveDialog.Execute;

  if DirectoryExists(dn) then
    Image.Bitmap.SaveToFile(FSaveDialog.FileName);
end;

procedure TFormImage.BackBtnClick(Sender: TObject);
begin
  Self.Hide;
end;

procedure TFormImage.CopyBtnClick(Sender: TObject);
begin
  Main.BitmapCache.CopyImage;
  Memo.Text := 'Bitmap copied to Clipboard.';
end;

end.
