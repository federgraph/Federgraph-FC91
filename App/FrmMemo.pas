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
    procedure ReadDiffBtnClick(Sender: TObject);
    procedure ListViewItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure BackBtnClick(Sender: TObject);
  protected
    procedure NotImplemented;
    procedure V1SaveNativeBtnClick(Sender: TObject);
    procedure WriteCode(Sender: TObject);
    procedure SaveVirtualClick(Sender: TObject);
    procedure WriteEquationText(Sender: TObject);
    procedure DiffBtnClick(Sender: TObject);
    procedure BinBtnClick(Sender: TObject);
    procedure HelpCycleClick(Sender: TObject);
    procedure V1DiffBtnClick(Sender: TObject);
    procedure InputHelpTextBtnClick(Sender: TObject);
    procedure OutputHelpTextBtnClick(Sender: TObject);
    procedure HelpTextBtnClick(Sender: TObject);
    procedure TestBtnClick(Sender: TObject);
    procedure DebugBtnClick(Sender: TObject);
    procedure WriteDiffCode(Sender: TObject);
    procedure ColorInfo3BtnClick(Sender: TObject);
    procedure ColorInfo5BtnClick(Sender: TObject);
    procedure ConstBufferBtnClick(Sender: TObject);
    procedure CacheReport1BtnClick(Sender: TObject);
    procedure CacheReport2BtnClick(Sender: TObject);
    procedure DeviceReportBtnClick(Sender: TObject);
    procedure JsonBtnClick(Sender: TObject);
    procedure ActionTestBtnClick(Sender: TObject);
    procedure WriteNewActionConstBtnClick(Sender: TObject);
    procedure WriteActionConstBtnClick(Sender: TObject);
    procedure WriteActionNamesBtnClick(Sender: TObject);
    procedure WriteActionShortBtnClick(Sender: TObject);
    procedure WriteActionLongBtnClick(Sender: TObject);
    procedure WriteShortcuts(Sender: TObject);
    procedure WriteZOrder(Sender: TObject);
    procedure WriteLog(Sender: TObject);
    procedure WriteSelectedColors(Sender: TObject);
    procedure WriteColorMapping(Sender: TObject);
    procedure WriteRingInfo(Sender: TObject);
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
    procedure GotoHelpHome;
  end;

var
  FormMemo: TFormMemo;

implementation

uses
  RiggVar.Util.AppUtils,
  RiggVar.App.Main,
  RiggVar.FederModel.Data,
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

procedure TFormMemo.GotoHelpHome;
begin
  HelpTextBtnClick(nil);
end;

procedure TFormMemo.V1SaveNativeBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.WriteVersion1Txt(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
//  AutoUpdateID := V1SaveNative;
end;

procedure TFormMemo.SaveVirtualClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.SaveStatus(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := SaveVirtual;
end;

procedure TFormMemo.V1DiffBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.WriteVersion1Diff(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
//  AutoUpdateID := V1Diff;
end;

procedure TFormMemo.WriteCode(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.WriteCode(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := Code;
end;

procedure TFormMemo.ColorInfo3BtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.SaveColorInfoCode(Memo.Lines, 4);
//  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.ColorInfo5BtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.SaveColorInfoCode(Memo.Lines, 6);
//  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.ConstBufferBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.FederScene.FederMaterial.CB.GetReport(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
//  AutoUpdateID := ConstBuffer;
end;

procedure TFormMemo.WriteDiffCode(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.WriteDiffCode(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
  AutoUpdateID := DiffCode;
end;

procedure TFormMemo.TestBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.WriteDiffBinTest(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
//  AutoUpdateID := Test;
end;

procedure TFormMemo.BinBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.WriteDiffBin(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
//  AutoUpdateID := Bin;
end;

procedure TFormMemo.WriteEquationText(Sender: TObject);
begin
  MemoBeginUpdate;
  Memo.Lines.Text := Main.FederModel.EquationText;
  MemoEndUpdate;
  AutoUpdateOff;
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

procedure TFormMemo.ReadDiffBtnClick(Sender: TObject);
begin
  MemoBeginUpdate(False);
  SL.Text := Memo.Lines.Text;
  Main.ReadSampleDiff(SL);
  MemoEndUpdate;
  AutoUpdateOff;
  if Main.IsMobile then
    Hide;
end;

procedure TFormMemo.DebugBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.Test(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.InputHelpTextBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.FederBinding.InitHelpForInput(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.OutputHelpTextBtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.FederBinding.InitHelpForOutput(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.HelpTextBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.FederBinding.InitAllText(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.HelpCycleClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Memo.Lines.Text := Main.CycleText;
  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.DiffBtnClick(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.WriteSampleDiff(Memo.Lines);
  MemoEndUpdate;
  AutoUpdateID := Diff;
end;

procedure TFormMemo.CacheReport1BtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.ShaderCache.GetReport1(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
//  AutoUpdateID := CacheReport1;
end;

procedure TFormMemo.CacheReport2BtnClick(Sender: TObject);
begin
  NotImplemented;
//  MemoBeginUpdate;
//  Main.ShaderCache.GetReport2(Memo.Lines);
//  MemoEndUpdate;
  AutoUpdateOff;
//  AutoUpdateID := CacheReport2;
end;

procedure TFormMemo.DeviceReportBtnClick(Sender: TObject);
//var
//  ML: TStrings;
begin
  NotImplemented;
//  MemoBeginUpdate;
//  if not Assigned(DeviceCheck) then
//    DeviceCheck := TDeviceCheck.Create;
//  DeviceCheck.GetDeviceReport(Memo.Lines);
//  ML := Memo.Lines;
//  ML.Add('');
//  ML.Add(Format('SceneScale = %4.2f', [FormMain.Viewport1.Scene.GetSceneScale]));
//  ML.Add(Format('ClientWidth = %d', [FormMain.ClientWidth]));
//  ML.Add(Format('ClientHeight = %d', [FormMain.ClientHeight]));
//  MemoEndUpdate;
  AutoUpdateOff;
end;

procedure TFormMemo.JsonBtnClick(Sender: TObject);
begin
  NotImplemented;
//  Memo.Lines.Clear;
//  Main.WriteJson(Memo.Lines);
  AutoUpdateOff;
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

procedure TFormMemo.WriteShortcuts(Sender: TObject);
begin
  MemoBeginUpdate;
  Main.ActionHandler.GetShortcutReport(Memo.Lines);
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

procedure TFormMemo.WriteLog(Sender: TObject);
begin
  MemoBeginUpdate;
  Memo.Lines.Text := Main.Logger.ML.Text;
  MemoEndUpdate;
  AutoUpdateOff;
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

procedure TFormMemo.InitList;
begin
//  MemoActionList.AddMemoAction('Save Virtual', SaveVirtualClick);

  MemoActionList.AddMemoAction('Selected Colors', WriteSelectedColors);
  MemoActionList.AddMemoAction('Color Mapping', WriteColorMapping);
  MemoActionList.AddMemoAction('Ring Info', WriteRingInfo);
  MemoActionList.AddMemoAction('Equation Text', WriteEquationText);
  MemoActionList.AddMemoAction('Z-Order', WriteZOrder);
  MemoActionList.AddMemoAction('Log', WriteLog);
  MemoActionList.AddMemoAction('Code', WriteCode);
  MemoActionList.AddMemoAction('Diff Code', WriteDiffCode);

//  MemoActionList.AddMemoAction('MeshData LineTag', MeshReport1BtnClick);
//  MemoActionList.AddMemoAction('MeshData IsPulled', MeshReport2BtnClick);
//  MemoActionList.AddMemoAction('MeshData PullDirection', MeshReport3BtnClick);
//  MemoActionList.AddMemoAction('MeshData LoopCounter', MeshReport4BtnClick);

//  MemoActionList.AddMemoAction('Write Version 1 Text', V1SaveNativeBtnClick);
//  MemoActionList.AddMemoAction('Write Version 1 Diff', V1DiffBtnClick);
//  MemoActionList.AddMemoAction('Write Diff Bin', BinBtnClick);
//  MemoActionList.AddMemoAction('Write Diff Bin Test', TestBtnClick);
//  MemoActionList.AddMemoAction('Write Html', HtmlBtnClick);
//  MemoActionList.AddMemoAction('Write Json', JsonBtnClick);

//  MemoActionList.AddMemoAction('Color Info 3', ColorInfo3BtnClick);
//  MemoActionList.AddMemoAction('Color Info 5', ColorInfo5BtnClick);

//  MemoActionList.AddMemoAction('Help for Input', InputHelpTextBtnClick);
//  MemoActionList.AddMemoAction('Help for Output', OutputHelpTextBtnClick);
//  MemoActionList.AddMemoAction('Keyboard Help Cycle', HelpCycleClick);
  MemoActionList.AddMemoAction('Help Text', HelpTextBtnClick);
  MemoActionList.AddMemoAction('Write Shortcuts', WriteShortcuts);

{$ifdef MSWINDOWS}
//  MemoActionList.AddMemoAction('Write Sample Diff', DiffBtnClick);
//  MemoActionList.AddMemoAction('Write All Sapmple Diff', AllDiffBtnClick);
{$endif}

{$ifdef MSWINDOWS}
//  MemoActionList.AddMemoAction('Device Report', DeviceReportBtnClick);
//  MemoActionList.AddMemoAction('Cache Report 1', CacheReport1BtnClick);
//  MemoActionList.AddMemoAction('Cache Report 2', CacheReport2BtnClick);
//  MemoActionList.AddMemoAction('Const Buffer Report', ConstBufferBtnClick);
{$endif}

{$ifdef MSWINDOWS}
  MemoActionList.AddMemoAction('Action Test', ActionTestBtnClick);
  MemoActionList.AddMemoAction('Write Action Const', WriteActionConstBtnClick);
//  MemoActionList.AddMemoAction('Write New Action Const', WriteNewActionConstBtnClick);
//  MemoActionList.AddMemoAction('Write Action Names', WriteActionNamesBtnClick);
  MemoActionList.AddMemoAction('Write Action Short', WriteActionShortBtnClick);
  MemoActionList.AddMemoAction('Write Action Long', WriteActionLongBtnClick);
//  MemoActionList.AddMemoAction('Debug Output', DebugBtnClick);
//  MemoActionList.AddMemoAction('Version Info', VersionInfoBtnClick);
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

    SaveVirtual: SaveVirtualClick(nil);
    Code: WriteCode(nil);
    DiffCode: WriteDiffCode(nil);
    Diff: DiffBtnClick(nil);
  end;
end;

procedure TFormMemo.BackBtnClick(Sender: TObject);
begin
  Self.Hide;
//  FormMain.Show;
end;

end.
