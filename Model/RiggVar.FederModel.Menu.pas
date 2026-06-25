unit RiggVar.FederModel.Menu;

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
  System.Classes,
  System.Types,
  System.Generics.Collections,
  System.Generics.Defaults,
  FMX.Types,
  FMX.Menus,
  RiggVar.FB.ActionConst,
  RiggVar.FB.Def,
  RiggVar.FB.ActionLong;

type
  TFederActions = TList<Integer>;

  TFederActionGroup = class
  public
    Items: TFederActions;
    Name: string;
    constructor Create;
    destructor Destroy; override;
    procedure Add(fa: Integer);
  end;

  TFederMenuBase = class (TList<TFederActionGroup>)
  protected
    procedure ConfigureItems; virtual;
  public
    TestName: string;
    constructor Create;
    destructor Destroy; override;
    procedure AddGroup(Caption: string; fag: TFederActionGroup);

    procedure CollectOne(fa: Integer; ML: TStrings);
    procedure CollectAll(ML: TStrings);
  end;

  TFederMenu = class(TFederMenuBase)
  private
    function AddMenu(M: TMainMenu; Caption: string; fas: TFederActions): TMenuItem;
    procedure InitItem(I: TMenuItem; fa: TFederAction);
    procedure OnBtnClick(Sender: TObject);
  protected
    procedure ConfigureItems; override;
    procedure UpdateMenu(Sender: TObject);
  public
    procedure InitMainMenu(M: TMainMenu);
    procedure UpdateText(M: TMainMenu);
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederMenu }

procedure TFederMenu.InitMainMenu(M: TMainMenu);
var
  ag: TFederActionGroup;
begin
  for ag in self do
  begin
    AddMenu(M, ag.Name, ag.Items);
  end;
end;

procedure TFederMenu.UpdateText(M: TMainMenu);
var
  i, j: Integer;
  fmxMenu, fmxItem: TFmxObject;
  mm: TMenuItem;
  mi: TMenuItem;
begin
  for i := 0 to M.ItemsCount-1 do
  begin
    fmxMenu := M.Items[i];
    if fmxMenu is TMenuItem then
    begin
      mm := fmxMenu as TMenuItem;
      for j := 0 to mm.ItemsCount-1 do
      begin
        fmxItem := mm.Items[j];
        if fmxItem is TMenuItem then
        begin
          mi := fmxItem as TMenuItem;
          mi.Text := Main.ActionHandler.GetCaption(mi.Tag);
//          mi.Action := Main.ActionList.GetFederAction(mi.Tag, MainVar.WantLocalizedText, False);
        end;
      end;
    end;
  end;
end;

procedure TFederMenu.ConfigureItems;
var
  fag: TFederActionGroup;
begin
  TestName := 'MEN';

  fag := TFederActionGroup.Create;
  fag.Add(faShowMemo);
  fag.Add(faShowActions);
  fag.Add(faShowImage);
  fag.Add(faToggleColorPanel);
  fag.Add(faToggleColorSwat);
  fag.Add(faToggleDropTarget);
  fag.Add(faShowEditField);
  fag.Add(faOpen);
  fag.Add(faShowRepo);
  fag.Add(faShowAnim);
  fag.Add(faEditConn);
  fag.Add(faEditText);
  if MainVar.AppTitle = '' then
    MainVar.AppTitle := 'App';
  AddGroup(MainVar.AppTitle, fag);

  fag := TFederActionGroup.Create;
  fag.Add(faCopy);
  fag.Add(faPaste);
  fag.Add(faSourcePascal);
  fag.Add(faSourceMaxima);
  fag.Add(faCopyBinCode);
  fag.Add(faCopyBinCodeTest);
  fag.Add(faCopyShortcutReport);
  fag.Add(faExportObj);
  fag.Add(faWriteActionTable);
  fag.Add(faWriteActionReport);
  AddGroup('Text', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faToggleHardCopy);
  fag.Add(faTogglePngCopy);
  fag.Add(faToggleNoCopy);
  AddGroup('Image', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faScene1);
  fag.Add(faScene2);
  fag.Add(faScene3);
  fag.Add(faScene4);
  fag.Add(faScene5);
  AddGroup('S', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faGraph1);
  fag.Add(faGraph2);
  fag.Add(faGraph3);
  fag.Add(faGraph4);
  fag.Add(faGraph5);
  AddGroup('G', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faFigure1);
  fag.Add(faFigure2);
  fag.Add(faFigure3);
  fag.Add(faFigure4);
  fag.Add(faFigure5);
  fag.Add(faFigure6);
  AddGroup('F', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faPlot0);
  fag.Add(faPlot1);
  fag.Add(faPlot2);
  fag.Add(faPlot3);
  fag.Add(faPlot4);
  fag.Add(faPlot5);
  fag.Add(faPlot6);
  fag.Add(faPlot7);
  fag.Add(faPlot8);
  fag.Add(faPlot9);
  fag.Add(faPlot10);
  fag.Add(faPlot11);
  fag.Add(faPlot12);
  fag.Add(faPlot13);
  AddGroup('Plot', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faMeshSize4);
  fag.Add(faMeshSize8);
  fag.Add(faMeshSize16);
  fag.Add(faMeshSize32);
  fag.Add(faMeshSize64);
  fag.Add(faMeshSize128);
  fag.Add(faMeshSize316);
  fag.Add(faMeshSize256);
  fag.Add(faMeshSize512);
  fag.Add(faPixelCount1);
  fag.Add(faPixelCount2);
  fag.Add(faPixelCount4);
  fag.Add(faWheelFrequency1);
  fag.Add(faWheelFrequency05);
  fag.Add(faWheelFrequency02);
  fag.Add(faWheelFrequency01);
  AddGroup('Size', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faWantBottom);
  fag.Add(faWantBottomMirrored);
  fag.Add(faToggleSolidFlip);
  fag.Add(faReducedMesh);
  fag.Add(faTogglePCap);
  fag.Add(faToggleMCap);
  fag.Add(faToggleShowEdges);
  AddGroup('Mesh', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faParamCZ);
  fag.Add(faParamRX);
  fag.Add(faParamRY);
  fag.Add(faParamRZ);
  fag.Add(faParamR);
  fag.Add(faNorthCap);
  fag.Add(faSouthCap);
  fag.Add(faEastCap);
  fag.Add(faWestCap);
  fag.Add(faParamCapValue);
  fag.Add(faParamL);
  fag.Add(faParamA);
  fag.Add(faParamT1);
  fag.Add(faParamT2);
  fag.Add(faParamT3);
  fag.Add(faParamT4);
  AddGroup('Param', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faToggleCylinder);
  fag.Add(faToggleDiameter);
  fag.Add(faParamBahnRadius);
  fag.Add(faParamBahnPositionX);
  fag.Add(faParamBahnPositionY);
  fag.Add(faParamBahnAngle);
  fag.Add(faParamBahnCylinderD);
  fag.Add(faParamBahnCylinderZ);
  AddGroup('Probe', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faToggleColorPanel);
  fag.Add(faToggleColorSwat);
  fag.Add(faToggleContour);
  fag.Add(faShowCurrentBandT);
  fag.Add(faParamBandSelected);
  fag.Add(faBandWidthRelative);
  fag.Add(faParamBandCount);
  fag.Add(faParamBandDistributionX);
  fag.Add(faParamBandDistributionY);
  AddGroup('Bands', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faCycleHelpP);
  fag.Add(faCycleHelpM);
  fag.Add(faCyclePlotP);
  fag.Add(faCycleK);
  fag.Add(faCycleL);
  fag.Add(faCycleO);
  fag.Add(faCycleR);
  fag.Add(faCycleT);
  fag.Add(faCycleU);
  fag.Add(faCycleX);
  fag.Add(faCycleY);
  fag.Add(faCycleZ);
  AddGroup('Cycle', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faWheelLeft);
  fag.Add(faWheelRight);
  fag.Add(faWheelUp);
  fag.Add(faWheelDown);
  AddGroup('Wheel', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faToggleSolutionMode);
  fag.Add(faToggleVorzeichen);
  fag.Add(faToggleGleich);
  fag.Add(faToggleLinearForce);
  fag.Add(faToggleLabelText);
  fag.Add(faToggleLuxMarker);
  fag.Add(faToggleGrid);
  fag.Add(faToggleGridFrequency);
  AddGroup('Option', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faToggleTouchMenu);
  fag.Add(faToggleTouchFrame);
  fag.Add(faTogglePrimeText);
  fag.Add(faToggleSecondText);
  AddGroup('UI', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faToggleParamLock);
  fag.Add(faToggleReportLock);
  fag.Add(faToggleTextureLock);
  fag.Add(faToggleLuxLock);
  fag.Add(faToggleForceLock);
  AddGroup('Lock', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faToggleContour);
  fag.Add(faToggleMoveMode);
  fag.Add(faToggleQuickMesh);
  fag.Add(faToggleLabelText);
  fag.Add(faToggleLuxMarker);
  fag.Add(faToggleGridFrequency);
  fag.Add(faShirtColorOn);
  fag.Add(faShirtColorOff);
  fag.Add(faTextureClear);
  AddGroup('O3D', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faOpenMesh);
  fag.Add(faPolarMesh);
  fag.Add(faReducedMesh);
  AddGroup('Mesh', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faRotX);
  fag.Add(faRotY);
  fag.Add(faRotZ);
  fag.Add(faRotXM);
  fag.Add(faRotXP);
  fag.Add(faRotYM);
  fag.Add(faRotYP);
  fag.Add(faRotZM);
  fag.Add(faRotZP);
  AddGroup('Rot', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faColor0);
  fag.Add(faColor1);
  fag.Add(faColor2);
  fag.Add(faColor3);
  fag.Add(faColor4);
  fag.Add(faColor5);
  fag.Add(faColor6);
  AddGroup('Col', fag);

  if Main.WantAnimation then
  begin
    fag := TFederActionGroup.Create;
    fag.Add(faAnimationStop);
    fag.Add(faAnimationStartA);
    fag.Add(faAnimationStartF);
    fag.Add(faAnimationStartT);
//    fag.Add(faAnimationStartD);
//    fag.Add(faAnimationStartS);
    AddGroup('Anim', fag);
  end;

  fag := TFederActionGroup.Create;
  fag.Add(faForceMode0);
  fag.Add(faForceMode1);
  fag.Add(faForceMode2);
  fag.Add(faM1);
  fag.Add(faM2);
  fag.Add(faM3);
  AddGroup('Force', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faSampleM);
  fag.Add(faSampleP);
  fag.Add(faHubM);
  fag.Add(faHubP);
  fag.Add(faLevelM);
  fag.Add(faLevelP);
  AddGroup('Sample', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faSetShift);
  fag.Add(faSetCtrl);
  fag.Add(faClearShift);
  fag.Add(faKeyboard01);
  fag.Add(faKeyboard02);
  AddGroup('Flag', fag);

  fag := TFederActionGroup.Create;
  fag.Add(faConnect);
  fag.Add(faDisconnect);
  fag.Add(faDownload);
  fag.Add(faAutoSend);
  AddGroup('Conn', fag);
end;

function TFederMenu.AddMenu(M: TMainMenu; Caption: string; fas: TFederActions): TMenuItem;
var
  fa: TFederAction;
begin
  result := TMenuItem.Create(M);
  result.Text := Caption;
  M.AddObject(result);
  for fa in fas do
    InitItem(result, fa);
  result.OnClick := UpdateMenu;
end;

procedure TFederMenu.InitItem(I: TMenuItem; fa: TFederAction);
var
  t: TMenuItem;
begin
  t := TMenuItem.Create(I);
  t.Width := 50;
  t.Height := 50;
  t.Opacity := 1.0;
  t.Font.Size := 24;
  t.Text := Main.ActionHandler.GetCaption(fa);
  t.Enabled := True;
  t.OnClick := OnBtnClick;
  t.Visible := True;
  t.Tag := Ord(fa);
  I.AddObject(t);
end;

procedure TFederMenu.OnBtnClick(Sender: TObject);
var
  t: TMenuItem;
  fa: TFederAction;
begin
  if Sender is TMenuItem then
  begin
    t := Sender as TMenuItem;
    fa := TFederAction(t.Tag);
    if fa <> faNoop then
      Main.ActionHandler.Execute(fa);
  end;
end;

procedure TFederMenu.UpdateMenu(Sender: TObject);
var
  mt, md: TMenuItem;
  j: Integer;
  fa: TFederAction;
begin
  if Sender is TMenuItem then
  begin
    mt := TMenuItem(Sender);
    for j := 0 to mt.ItemsCount - 1 do
    begin
      md := mt.Items[j] as TMenuItem;
      fa := TFederAction(md.tag);
      if fa <> faNoop then
      begin
        md.IsChecked := Main.ActionHandler.GetChecked(fa);
        md.Enabled := Main.ActionHandler.GetEnabled(fa);
      end;
    end;
  end;
end;

{ TFederMenuBase }

procedure TFederMenuBase.AddGroup(Caption: string; fag: TFederActionGroup);
begin
  fag.Name := Caption;
  Add(fag);
end;

procedure TFederMenuBase.CollectAll(ML: TStrings);
var
  ag: TFederActionGroup;
  fa: Integer;
begin
  for ag in self do
    for fa in ag.Items do
      ML.Add(Format('%s %s: %s', [TestName, ag.Name, GetFederActionLong(fa)]));
end;

procedure TFederMenuBase.CollectOne(fa: Integer; ML: TStrings);
var
  ag: TFederActionGroup;
  i: Integer;
begin
  for ag in self do
    for i in ag.Items do
      if i = fa then
        ML.Add(Format('%s %s', [TestName, ag.Name]));
end;

constructor TFederMenuBase.Create;
begin
  inherited;
  TestName := 'MEN';
  ConfigureItems;
end;

procedure TFederMenuBase.ConfigureItems;
begin
end;

destructor TFederMenuBase.Destroy;
var
  i: Integer;
begin
  for i := Count-1 downto 0 do
    Items[i].Free;
  inherited;
end;

{ TFederActionGroup }

constructor TFederActionGroup.Create;
begin
  inherited;
  Items := TList<Integer>.Create;
end;

destructor TFederActionGroup.Destroy;
begin
  Items.Free;
  inherited;
end;

procedure TFederActionGroup.Add(fa: Integer);
begin
  Items.Add(fa);
end;

end.
