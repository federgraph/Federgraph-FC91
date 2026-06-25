unit FrmMemo;

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
  FMX.ListView;

type
  TAutoUpdateReport = (
    Nothing,
    ZOrderInfo,
    MeshReport0,
    MeshReport1,
    MeshReport2,
    MeshReport3,
    MeshReport4,
    MeshReport5,
    MeshReport6,
    MeshReport7,
    V1SaveNative,
    SaveVirtual,
    V1Diff,
    Code,
    ConstBuffer,
    DiffCode,
    Test,
    Bin,
    Diff,
    CacheReport1,
    CacheReport2
  );

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

  TFormMemo = class(TForm)
    ToolbarPanel: TPanel;
    ListView: TListView;
    Memo: TMemo;
    BackBtn: TButton;
    ReadBtn: TButton;
    ReadDiffBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReadBtnClick(Sender: TObject);
    procedure ListViewItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure BackBtnClick(Sender: TObject);
  protected
    procedure NotImplemented;
    procedure ActionTestBtnClick(Sender: TObject);
    procedure WriteNewActionConstBtnClick(Sender: TObject);
    procedure WriteActionConstBtnClick(Sender: TObject);
    procedure WriteActionNamesBtnClick(Sender: TObject);
    procedure WriteActionShortBtnClick(Sender: TObject);
    procedure WriteActionLongBtnClick(Sender: TObject);
    procedure WriteZOrder(Sender: TObject);
    procedure MeshReport1BtnClick(Sender: TObject);
    procedure MeshReport2BtnClick(Sender: TObject);
    procedure MeshReport3BtnClick(Sender: TObject);
    procedure MeshReport4BtnClick(Sender: TObject);
    procedure WriteSelectedColors(Sender: TObject);
    procedure WriteColorMapping(Sender: TObject);
    procedure WriteRingInfo(Sender: TObject);
    procedure WriteOBJStats(Sender: TObject);
  private
    SL: TStringList;
    MemoActionList: TMemoActionList;
    procedure InitItems;
    procedure InitList;
    procedure MemoBeginUpdate(ClearMemo: Boolean = True);
    procedure MemoEndUpdate;
  public
    CounterNotImplemented: Integer;
    AutoUpdateID: TAutoUpdateReport;
    procedure AutoUpdate;
    procedure AutoUpdateOff;
  end;

var
  FormMemo: TFormMemo;

implementation

uses
  RiggVar.Util.AppUtils,
  RiggVar.App.Main,
  FrmMain;

{$R *.fmx}

procedure TFormMemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caHide;
end;

procedure TFormMemo.FormCreate(Sender: TObject);
begin
  Caption := 'Form Memo';
  Left := 10;
  Top := 120;
  Width := 800;
  Height := 750;
  SL := TStringList.Create;

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

  Memo.Align := TAlignLayout.Client;
  Memo.ControlType := TControlType.Styled;
  Memo.ShowScrollBars := True;
  Memo.StyleLookup := 'memostyle';
  Memo.StyledSettings := [TStyledSetting.FontColor, TStyledSetting.Other];
  Memo.TextSettings.Font.Family := TAppUtils.GetMonspacedFontFamilyName;
  Memo.TextSettings.Font.Size := 16;
{$ifdef MSWINDOWS}
  Memo.TextSettings.Font.Size := 14;
{$endif}

{ because of StyleLookup memostyle
  background can be black on iOS when dark theme is activated at night time }
//  Memo.TextSettings.FontColor := claBlack;

  MemoActionList := TMemoActionList.Create;
  InitList;
  InitItems;

  BackBtn.Visible := True;
  ReadBtn.Visible := True;
  ReadDiffBtn.Visible := True;
end;

procedure TFormMemo.FormDestroy(Sender: TObject);
begin
  SL.Free;
  MemoActionList.Free;
end;

procedure TFormMemo.ReadBtnClick(Sender: TObject);
begin
  MemoBeginUpdate(False);
  SL.Text := Memo.Lines.Text;
  Main.ReadSample(SL);
  MemoEndUpdate;
  AutoUpdateOff;
  if Main.IsMobile then
    Hide;
end;

procedure TFormMemo.ActionTestBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.ActionTest.TestAll;
  Memo.Lines.Text := Main.ActionTest.SL.Text;
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteNewActionConstBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.ActionTest.WriteNewActionConst(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteActionConstBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.ActionTest.WriteActionConst(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteActionNamesBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.ActionTest.WriteActionNames(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteActionShortBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.ActionTest.WriteActionShort(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteActionLongBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.ActionTest.WriteActionLong(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteZOrder(Sender: TObject);
begin
  MemoBeginUpdate;
  FormMain.InitZOrderInfo(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := ZOrderInfo;
end;

procedure TFormMemo.MeshReport1BtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.MeshBuilder.GetMeshDataMatrixReport(Memo.Lines, 1);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := MeshReport1;
end;

procedure TFormMemo.MeshReport2BtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.MeshBuilder.GetMeshDataMatrixReport(Memo.Lines, 2);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := MeshReport2;
end;

procedure TFormMemo.MeshReport3BtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.MeshBuilder.GetMeshDataMatrixReport(Memo.Lines, 3);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := MeshReport3;
end;

procedure TFormMemo.MeshReport4BtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.MeshBuilder.GetMeshDataMatrixReport(Memo.Lines, 4);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := MeshReport4;
end;

procedure TFormMemo.WriteSelectedColors(Sender: TObject);
begin
  MemoBeginUpdate;
  Memo.Lines.Text := Main.FederReport.GetSelectedColors;
  Memo.Lines.Add('Selected Colors from Bambu Lab PLA, Basic and Matte.');
  Memo.Lines.Add('Usable for 3D printing on Bambulab A1 printer.');
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteColorMapping(Sender: TObject);
begin
  MemoBeginUpdate;
  Memo.Lines.Text := Main.FederReport.GetColorMapping;
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteRingInfo(Sender: TObject);
begin
  MemoBeginUpdate;
  Memo.Lines.Text := Main.FederReport.GetRingInfo;
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.WriteOBJStats(Sender: TObject);
begin
  MemoBeginUpdate;
  if Main.ExporterOBJ <> nil then
  begin
    Main.ExporterOBJ.AddStats(Memo.Lines);
  end;
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.InitList;
begin
  MemoActionList.AddMemoAction('Selected Colors', WriteSelectedColors);
  MemoActionList.AddMemoAction('Color Mapping', WriteColorMapping);
  MemoActionList.AddMemoAction('Ring Info', WriteRingInfo);
  MemoActionList.AddMemoAction('OBJ Stats', WriteOBJStats);
  MemoActionList.AddMemoAction('Z-Order', WriteZOrder);

  MemoActionList.AddMemoAction('MeshData LineTag', MeshReport1BtnClick);
  MemoActionList.AddMemoAction('MeshData IsPulled', MeshReport2BtnClick);
  MemoActionList.AddMemoAction('MeshData PullDirection', MeshReport3BtnClick);
  MemoActionList.AddMemoAction('MeshData LoopCounter', MeshReport4BtnClick);

{$ifdef MSWINDOWS}
  MemoActionList.AddMemoAction('Action Test', ActionTestBtnClick);
  MemoActionList.AddMemoAction('Write Action Const', WriteActionConstBtnClick);
  MemoActionList.AddMemoAction('Write Action Names', WriteActionNamesBtnClick);
  MemoActionList.AddMemoAction('Write Action Short', WriteActionShortBtnClick);
  MemoActionList.AddMemoAction('Write Action Long', WriteActionLongBtnClick);
{$endif}
end;

procedure TFormMemo.InitItems;
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

procedure TFormMemo.ListViewItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  cr: TMemoAction;
begin
  cr := MemoActionList.FindByTag(AItem.Tag);
  if cr.Tag > -1 then
    cr.Handler(nil);
end;

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

procedure TFormMemo.MemoBeginUpdate(ClearMemo: Boolean = True);
begin
  AutoUpdateID := Nothing;
  Memo.Lines.BeginUpdate;
  if ClearMemo then
    Memo.Lines.Clear;
end;

procedure TFormMemo.MemoEndUpdate;
begin
  Memo.Lines.EndUpdate;
{$ifdef MSWINDOWS}
{$if CompilerVersion < 35}
  Memo.ContentBounds := TRectF.Empty;
{$endif}
{$endif}
end;

procedure TFormMemo.NotImplemented;
begin
  Memo.Lines.Clear;
  Inc(CounterNotImplemented);
  Memo.Lines.Add(Format('Not implemented (%d) [%s]', [CounterNotImplemented, DateTimeToStr(Now)]));
  AutoUpdateID := Nothing;
end;

procedure TFormMemo.AutoUpdateOff;
begin
  AutoUpdateID := Nothing;
end;

procedure TFormMemo.AutoUpdate;
begin
  case AutoUpdateID of
    ZOrderInfo: WriteZOrder(nil);

    MeshReport1: MeshReport1BtnClick(nil);
    MeshReport2: MeshReport2BtnClick(nil);
    MeshReport3: MeshReport3BtnClick(nil);
    MeshReport4: MeshReport4BtnClick(nil);
  end;
end;

procedure TFormMemo.BackBtnClick(Sender: TObject);
begin
  Self.Hide;
//  FormMain.Show;
end;

end.
