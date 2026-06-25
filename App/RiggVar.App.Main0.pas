unit RiggVar.App.Main0;

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

{$I App\RiggVar.App.Defs.inc}

uses
  System.SysUtils,
  System.Classes,
  System.Math,
  System.UITypes,
  System.UIConsts,
  System.Generics.Collections,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Types,
  FMX.MaterialSources,
  RiggVar.Bitmap.Bitmap02,
  RiggVar.Bitmap.Texture,
  RiggVar.EQ.Model,
  RiggVar.FB.Action,
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionGroup,
  RiggVar.FB.ActionGroups,
  RiggVar.FB.ActionConfig,
  RiggVar.FB.ActionKeys,
  RiggVar.FB.ActionMap,
  RiggVar.FB.ActionTest,
  RiggVar.FB.Bitmap,
  RiggVar.FB.Color,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Equation,
  RiggVar.FB.MeshParams,
  RiggVar.FB.Model,
  RiggVar.FB.Report,
  RiggVar.FB.Scheme,
  RiggVar.FB.StopWatch,
  RiggVar.FB.Text,
  RiggVar.FederModel.Action,
  RiggVar.FederModel.Color,
  RiggVar.FederModel.RingBuilder,
  RiggVar.FederModel.Touch,
  RiggVar.FederModel.TouchBase,
  RiggVar.FederModel.TouchPhone,
  RiggVar.Mesh.ExporterOBJ,
  RiggVar.Mesh.FederShell1,
  RiggVar.Mesh.SolidPart,
  RiggVar.Mesh.MeshBuilder;

type
  TMain0 = class
  private
    FBandWidthOption: TBandWidthOption;
    FColorPanelColor: TAlphaColor;
    FBitmap: Integer;
    FCurrentRing: Integer;
    FFederParam: TFederParam;
    FHasShirtColor: Boolean;
    FHasShirtFarbe: Boolean;
    FHelpFlash: Boolean;
    FIsMobile: Boolean;
    FIsRetina: Boolean;
    FL: TStringList;
    FMaterialSource: TLightMaterialSource;
    FReportIndex: Integer;
    FSelectedColor: Integer;
    FTouch: Integer;
    FSolidPartVisible: Boolean;
    MappedReports: TList<TReportPage>;
    procedure InitData(Sender: TObject);
    function GetBitmap: Integer;
    function GetBitmapBuilder: TBitmapBuilder02;
    function GetCapValue: single;
    function GetColorPanelColor: TAlphaColor;
    function GetColorScheme: Integer;
    function GetFederText: TFederTouchBase;
    function GetInitDataOK: Boolean;
    function GetIsDesktop: Boolean;
    function GetIsLandscape: Boolean;
    function GetIsPhone: Boolean;
    function GetIsPortrait: Boolean;
    function GetIsRetina: Boolean;
    function GetLoopFaktor: single;
    function GetMaterialSource: TLightMaterialSource;
    function GetMenubarLayout: Integer;
    function GetMeshBuilder: TFederMeshBuilder;
    function GetMeshSize: Integer;
    function GetParamCaption: string;
    function GetParamValue: single;
    function GetRetinaScale: single;
    function GetRingColor(j: Integer): TAlphaColor;
    function GetRingContourWidth: Integer;
    function GetRingWidth: Integer;
    function GetShowColorPanel: Boolean;
    function GetShowColorSwat: Boolean;
    function GetShowCurrentBand: Boolean;
    function GetSideCapVisible: Boolean;
    function GetTransitBarLayout: Integer;
    procedure InitFederText(ft: TFederText);
    procedure InitMappedReports;
    procedure InitSample1(fd: TFederData);
    procedure InitTouch;
    procedure InitTouchbarHelpText;
    procedure LoadColorInfoOnly;
    procedure LoadFromFederData;
    procedure LoadModelInfo;
    procedure PrepareForExample;
    procedure SetBandWidthOption(const Value: TBandWidthOption);
    procedure SetBitmap(const Value: Integer);
    procedure SetColorPanelColor(const Value: TAlphaColor);
    procedure SetColorScheme(const Value: Integer);
    procedure SetCurrentRing(const Value: Integer);
    procedure SetFederParam(const Value: TFederParam);
    procedure SetInitDataOK(const Value: Boolean);
    procedure SetMenubarLayout(const Value: Integer);
    procedure SetMeshSize(const Value: Integer);
    procedure SetRingColor(j: Integer; const c: TAlphaColor);
    procedure SetRingWidth(const Value: Integer);
    procedure SetSelectedColor(const Value: Integer);
    procedure SetShowColorPanel(const Value: Boolean);
    procedure SetShowColorSwat(const Value: Boolean);
    procedure SetShowCurrentBand(const Value: Boolean);
    procedure SetSideCapVisible(const Value: Boolean);
    procedure SetSolidPartVisible(const Value: Boolean);
    procedure SetTouch(const Value: Integer);
    procedure SetTransitBarLayout(const Value: Integer);
    procedure SetUpdateReason(const Value: TUpdateReason);
  public
    ActionGroupList: TActionGroupList;
    ActionHandler: TFederActionHandler;
    ActionItemList: TActionItemList;
    ActionMapPhone: TActionMap;
    ActionMapTablet: TActionMap;
    ActionMapTransit: TActionMap;
    ActionTest: TActionTest;
    BMP: TBitmap;
    ColorStrip: TColorStrip;
    CounterCheckState: Integer;
    CounterDrawing3D: Integer;
    CounterInitData: Integer;
    CounterTextUpdate: Integer;
    CurrentReportAction: TFederAction;
    ExportCoords: TExportCoords;
    ExporterOBJ: TExporterOBJ;
    FederData: TFederData;
    SolidPart: TSolidPart;
    Outer: TFederShell1;
    Inner: TFederShell1;
    FederModel: TFederModel;
    FederReport: TFederReport;
    FederText1: TFederTouch;
    FederText2: TFederTouchPhone;
    FederTexture: TFederTexture;
    FlashClearingNeeded: Boolean;
    GraphUpdatingNeeded: Boolean;
    InitDataMillies: Integer;
    IsReady: Boolean;
    IsUp: Boolean;
    PaletteMode: Boolean;
    ReportLock: Boolean;
    RingBuilder: TRingBuilder;
    StateCheckingNeeded: Boolean;
    StopWatch: TStopWatch;
    StripColor: TAlphaColor;
    TextIndex: Integer;
    TextUpdatingNeeded: Boolean;
    vp: TMeshParams;
    WantDiff: Boolean;
    WantDiffOnce: Boolean;
    ViewportSizeX: Integer;

    Level: Integer;
    Hub: Integer;
    Sample: Integer;

    constructor Create;
    destructor Destroy; override;
    procedure AddMeshesToScene(ModelParent: TFmxObject);
    procedure ApplyButtonColor(fa: Integer);
    procedure BlindRing(Value: Integer);
    procedure BubbleUpAction(fa: TFederAction);
    procedure CheckStateNeeded;
    procedure ClearFlashNeeded;
    procedure CollectShortcuts(fa: Integer; ML: TStrings);
    procedure CycleBitmapE;
    procedure CycleBitmapM;
    procedure CycleBitmapOne;
    procedure CycleBitmapP;
    procedure CycleColorSchemeM;
    procedure CycleColorSchemeP;
    procedure CycleToolSet(i: Integer);
    procedure DoBigWheel(Delta: single);
    procedure DoMM(fmk: TFederMessageKind; X, Y: single);
    procedure DoMouseWheel(Shift: TShiftState; WheelDelta: Integer);
    procedure DoReset;
    procedure DoResetPosition;
    procedure DoResetRotation;
    procedure DoResetZoom;
    procedure DoSmallWheel(Delta: single);
    procedure DoTouchbarBottom(Delta: single);
    procedure DoTouchbarLeft(Delta: single);
    procedure DoTouchbarRight(Delta: single);
    procedure DoTouchbarTop(Delta: single);
    procedure DoWheelForBandWidth(Delta: single);
    procedure DoZoom(const Delta: single);
    procedure ExportMtl;
    procedure ExportObj;
    function FederPaletteHandleTouchBtnClick(Btn: TTouchBtn): Boolean;
    procedure FrameVisibilityChanged;
    function GetReport(Value: TReportPage): string;
    function GetReportPage: TReportPage;
    procedure GetRingInfoReport(ASL: TStrings);
    procedure GotoColorScheme(Value: Integer);
    procedure GraphUpdateNeeded;
    procedure HandleAction(fa: TFederAction; CanBubble: Boolean = True);
    procedure Init;
    procedure InitDefaultRingWidth(Value: Integer);
    procedure InitFederModel(fd: TFederData);
    procedure InitMaterial;
    procedure InitRaster;
    procedure InitText;
    function IsTouchBtnEnabled(Btn: TTouchBtn): Boolean;
    procedure MarkForUpdate(Value: TUpdateReason);
    procedure PickRing(X, Y: single);
    procedure RandomBitmapBlack;
    procedure RandomBitmapWhite;
    procedure ReadSample(ML: TStrings);
    procedure Refresh;
    procedure ResetRequested;
    procedure RingIndexChanged;
    procedure RingIndexUpdated;
    procedure ShowInfo;
    procedure TextUpdateNeeded;
    procedure ToggleBottom;
    procedure ToggleColorPanel;
    procedure ToggleContourPixel;
    procedure ToggleLabelBatch(Value: Integer);
    procedure ToggleLux(Value: Integer);
    procedure ToggleMirroredBottom;
    procedure ToggleSideCaps;
    procedure ToggleSingleSide;
    procedure ToggleShowEdges;
    procedure ToggleSolidFlip;
    procedure ToggleSpecialY;
    procedure UpdateBitmap;
    procedure UpdateCurrentRing(TexCoordY: single);
    procedure UpdateFederTextData(var TD: TFederTextData);
    procedure UpdateFederTextDataPhone(var TD: TFederTextDataPhone);
    procedure UpdatePrintColors(ASelectedColors: TPrintColorSet);
    procedure UpdateReport;
    procedure UpdateRingColor(AColor: TAlphaColor); overload;
    procedure UpdateRingColor(ARing: Integer; AColor: TAlphaColor); overload;
    procedure UpdateRings;
    procedure UpdateSelectedColor(const Value: TAlphaColor);
    procedure UpdateShirtColor(Value: Boolean);
    procedure UpdateShirtFarbe(Value: Boolean);
    procedure UpdateText;
    procedure UpdateTouch;
    procedure UpdateVP;
    property BandWidthOption: TBandWidthOption read FBandWidthOption write SetBandWidthOption;
    property Bitmap: Integer read GetBitmap write SetBitmap;
    property BitmapBuilder: TBitmapBuilder02 read GetBitmapBuilder;
    property CapValue: single read GetCapValue;
    property ColorPanelColor: TAlphaColor read GetColorPanelColor write SetColorPanelColor;
    property ColorScheme: Integer read GetColorScheme write SetColorScheme;
    property CurrentReportPage: TReportPage read GetReportPage;
    property CurrentRing: Integer read FCurrentRing write SetCurrentRing;
    property FederMesh: TFederShell1 read Outer;
    property FederParam: TFederParam read FFederParam write SetFederParam;
    property FederText: TFederTouchBase read GetFederText;
    property HasShirtColor: Boolean read FHasShirtColor write FHasShirtColor;
    property HasShirtFarbe: Boolean read FHasShirtFarbe write FHasShirtFarbe;
    property InitDataOK: Boolean read GetInitDataOK write SetInitDataOK;
    property IsDesktop: Boolean read GetIsDesktop;
    property IsLandscape: Boolean read GetIsLandscape;
    property IsMobile: Boolean read FIsMobile write FIsMobile;
    property IsPhone: Boolean read GetIsPhone;
    property IsPortrait: Boolean read GetIsPortrait;
    property IsRetina: Boolean read GetIsRetina write FIsRetina;
    property LoopFaktor: single read GetLoopFaktor;
    property MaterialSource: TLightMaterialSource read GetMaterialSource;
    property MenubarLayout: Integer read GetMenubarLayout write SetMenubarLayout;
    property MeshBuilder: TFederMeshBuilder read GetMeshBuilder;
    property MeshSize: Integer read GetMeshSize write SetMeshSize;
    property ParamCaption: string read GetParamCaption;
    property ParamValue: single read GetParamValue;
    property RetinaScale: single read GetRetinaScale;
    property RingColor[j: Integer]: TAlphaColor read GetRingColor write SetRingColor;
    property RingContourWidth: Integer read GetRingContourWidth;
    property RingWidth: Integer read GetRingWidth write SetRingWidth;
    property SelectedColor: Integer read FSelectedColor write SetSelectedColor;
    property ShowColorPanel: Boolean read GetShowColorPanel write SetShowColorPanel;
    property ShowColorSwat: Boolean read GetShowColorSwat write SetShowColorSwat;
    property ShowCurrentBand: Boolean read GetShowCurrentBand write SetShowCurrentBand;
    property SideCapVisible: Boolean read GetSideCapVisible write SetSideCapVisible;
    property SolidPartVisible: Boolean read FSolidPartVisible write SetSolidPartVisible;
    property Touch: Integer read FTouch write SetTouch;
    property TransitBarLayout: Integer read GetTransitBarLayout write SetTransitBarLayout;
    property UpdateReason: TUpdateReason write SetUpdateReason;
  end;

implementation

uses
  FrmMain,
  RiggVar.App.Main,
  RiggVar.FederModel.ActionMapTransit,
  RiggVar.FederModel.ActionMapTablet,
  RiggVar.FederModel.ActionMapPhone,
  RiggVar.FederModel.Report;

{ TMain0 }

constructor TMain0.Create;
begin
  Main := self;

  Level := 0;
  Hub := 0;
  Sample := 1;
  FFederParam := fpcz;

  FormatSettings.DecimalSeparator := '.';
  MainVar.AppTitle := Application.Title;

  FSolidPartVisible := False;

  FL := TStringList.Create;

  InitMappedReports;
  InitTouchbarHelpText;

  ColorStrip := TColorStrip.Create;

  StopWatch := TStopWatch.Create;
  FederData := TFederData.Create;

  FederModel := TFederModel.Create(TFederModelEQ.Create);
  vp := TMeshParams.Create(FederModel.EQ);
  FederTexture := TFederTexture.Create;

  ActionGroupList := TActionGroupList.Create;
  ActionTest := TActionTest.Create;
  ActionItemList := TActionItemList.Create;
  ActionItemList.InitTestData(2);
  ActionHandler := TFederActionHandler.Create;
  ActionMapTransit := TActionMapTransit.Create;
  ActionMapTablet := TActionMapTablet.Create;
  ActionMapPhone := TActionMapPhone.Create;

  RingBuilder := TRingBuilder.Create;

  FederReport := TFederReport1.Create;

  FTouch := faTouchPhone;
  TTouchBtn.WantHint := True;
  FederText1 := TFederTouch.Create(nil);
  FederText1.Name := 'Tablet';
  FederText2 := TFederTouchPhone.Create(nil);
  FederText2.Name := 'Phone';

  FederData.InitDefault;
  InitSample1(FederData);
  LoadFromFederData;
  FederModel.InitRange;
  FederModel.UpdateVP;
  FederModel.OnInitData := InitData;
  FederModel.Active := True;

  InitMaterial;

  Outer := TFederShell1.Create(FormMain);
  Outer.MeshParams := vp;
  Outer.WantFlippedHands := False;

  Inner := TFederShell1.Create(FormMain);
  Inner.MeshParams := vp;
  Inner.FederMeshBuilder.FlatMesh := True;
  Inner.FederMeshBuilder.IsBottom := True;

  Outer.InitGraph;
  Inner.InitGraph;

  SolidPart  := TSolidPart.Create(FormMain);
  SolidPart.Outer := Outer;
  SolidPart.Inner := Inner;
  SolidPart.Init;

  ExporterOBJ := TExporterOBJ.Create;
end;

destructor TMain0.Destroy;
begin
  MainVar.AppIsClosing := True;

  BMP.Free;

  FederModel.Free;
  FederTexture.Free;
  ColorStrip.Free;
  RingBuilder.Free;

  StopWatch.Free;
  FederData.Free;

  ActionItemList.Free;
  ActionHandler.Free;
  ActionGroupList.Free;
  ActionTest.Free;
  MappedReports.Free;
  ExporterOBJ.Free;

  IsUp := False;

  Outer.Free;
  Inner.Free;
  SolidPart.Free;

  FederText1.Free;
  FederText2.Free;
  vp.Free;

  FederReport.Free;
  FMaterialSource.Free;

  ActionMapTransit.Free;
  ActionMapTablet.Free;
  ActionMapPhone.Free;

  FL.Free;
  inherited;
end;

procedure TMain0.ApplyButtonColor(fa: Integer);
var
  c: Integer;
  cla: TAlphaColor;
begin
//  c := 0;
//  case fa of
//    faTL01 .. faTL06: c := 1;
//    faTR01 .. faTR08: c := 2;
//    faBL01 .. faBL08: c := 3;
//    faBR01 .. faBR06: c := 4;
//  end;
  case FederText.ActionPage of
    2: c := 1;
    3: c := 2;
    4: c := 3;
    else c := 1;
  end;
  if c > 0 then
  begin
    FSelectedColor := c;
    cla := FederText.FindCornerBtn(TFederTouchBase.ClickedID).Color;
    UpdateSelectedColor(cla);
    FederText1.SwatColor := cla;
    FederModel.PlusCap := True;
    RingIndexUpdated;
  end;
end;

procedure TMain0.DoBigWheel(Delta: single);
var
  EQ: TFederEquation;
  d: single;
  temp: single;
begin
  if Delta > 0 then
    d := 1
  else
    d := -1;

  case FederParam of
    fpcz:
    begin
      DoZoom(d);
      Exit;
    end;

    fpT1: FederModel.FT1 := FederModel.FT1 + d;
    fpT2: FederModel.FT2 := FederModel.FT2 + 2 * d;

    fpParamCapValue: FederModel.CapValue := FederModel.CapValue + d;

    fpL:
    begin
      FederModel.Param := TFederUtils.GetParamInt(fpL);
      EQ := FederModel.EQ;
      temp := EQ.l1 + 10 * Delta;
      if (temp >= 85) and (temp <= 110) then
      begin
        FederModel.ParamValue := temp;
      end;
    end;

    fpNorthCapValue:
    begin
      FederModel.Param := TFederUtils.GetParamInt(fpNorthCapValue);
      temp := FederModel.North + 10 * Delta;
      if (temp >= 130) and (temp <= 160) then
      begin
        FederModel.ParamValue := temp;
      end;
    end;

    fpSouthCapValue:
    begin
      FederModel.Param := TFederUtils.GetParamInt(fpSouthCapValue);
      temp := FederModel.South + 10 * Delta;
      if (temp >= -100) and (temp <= -70) then
      begin
        FederModel.ParamValue := temp;
      end;
    end;

    fpAbsoluteRange:
    begin
      FederModel.Param := TFederUtils.GetParamInt(fpAbsoluteRange);
      temp := FederModel.AbsoluteRange + 10 * Delta;
      if (temp >= 100) and (temp <= 140) then
      begin
        FederModel.ParamValue := temp;
      end;
    end;

    fpBandWidth: DoWheelForBandWidth(Delta);
  end;

  Refresh;
end;

procedure TMain0.DoWheelForBandWidth(Delta: single);
var
  d: Integer;
  w: Integer;
  CanChange: Boolean;
begin
  if Delta > 0 then
    d := 1
  else
    d := -1;

  w := RingWidth + d;

  CanChange := True;
  if w < 1 then
    CanChange := False;

  if BandWidthOption = bwAbsolute then
  begin
    if not BitmapBuilder.CanChangeAbsoluteWidth(CurrentRing, w) then
      CanChange := False;
  end;
  if BandWidthOption = bwContour then
  begin
    if not BitmapBuilder.CanChangeContourWidth(CurrentRing, w) then
      CanChange := False;
  end;
  if BandWidthOption = bwRelative then
  begin
    if not BitmapBuilder.CanChangeRelativeWidth(CurrentRing, w) then
      CanChange := False;
  end;

  if CanChange then
  begin
    FederModel.ParamBandWidth := w;
    RingWidth := Round(FederModel.ParamBandWidth);
    UpdateRings;
    BitmapBuilder.UpdateReason := TUpdateReason.cuParamBandWidth;
    BitmapBuilder.RingWidthChanged := False;
    TextUpdateNeeded;
    GraphUpdateNeeded;
    BubbleUpAction(faNoop);
  end;
end;

procedure TMain0.BlindRing(Value: Integer);
begin
  BitmapBuilder.BlindColors(Value);
  Bitmap := Bitmap;
end;

procedure TMain0.BubbleUpAction(fa: TFederAction);
begin
  if IsUp then
    FormMain.HandleAction(fa);
end;

procedure TMain0.CheckStateNeeded;
begin
  StateCheckingNeeded := True;
end;

procedure TMain0.ClearFlashNeeded;
begin
  FlashClearingNeeded := True;
end;

procedure TMain0.CollectShortcuts(fa: Integer; ML: TStrings);
begin

end;

procedure TMain0.CycleBitmapE;
begin
  Bitmap := StripConst.EscapeColorIndex;
end;

procedure TMain0.CycleBitmapM;
var
  i: Integer;
begin
  i := Bitmap;
  Dec(i);
  if (i < 1) then
    i := StripConst.ColorCount;
  if i > StripConst.MaxColorIndex then
    i := 1;
  Bitmap := i;
end;

procedure TMain0.CycleBitmapOne;
begin
  Bitmap := 1;
end;

procedure TMain0.CycleBitmapP;
var
  i: Integer;
begin
  i := Bitmap;
  Inc(i);
  if (i < 1) then
    i := StripConst.ColorCount;
  if i = StripConst.RandomColorIndexB then
    i := 1
  else if i = StripConst.EscapeColorIndex then
    i := 1
  else if i > StripConst.EscapeColorIndex then
  begin
    if i > StripConst.MaxColorIndex then
      i := 1;
  end
  else if i > StripConst.ColorCount then
    i := 1;
  Bitmap := i;
end;

procedure TMain0.CycleColorSchemeM;
var
  i: Integer;
  l: Boolean;
begin
  l := FederData.BackgroundLock;
  FederData.BackgroundLock := False;
  i := ColorScheme;
  Dec(i);
  if (i < 1) then
    i := MainConst.ColorSchemeCount;
  if i > MainConst.ColorSchemeCount then
    i := 1;

  ColorScheme := i;
  FederData.BackgroundLock := l;
end;

procedure TMain0.CycleColorSchemeP;
var
  i: Integer;
  l: Boolean;
begin
  l := FederData.BackgroundLock;
  FederData.BackgroundLock := False;
  i := ColorScheme;
  Inc(i);
  if (i < 1) then
    i := MainConst.ColorSchemeCount;
  if i > MainConst.ColorSchemeCount then
    i := 1;

  ColorScheme := i;
  FederData.BackgroundLock := l;
end;

procedure TMain0.CycleToolSet(i: Integer);
begin
  FederText.UpdateToolSet(i);
  TextUpdateNeeded;
end;

procedure TMain0.DoMM(fmk: TFederMessageKind; X, Y: single);
begin
  FormMain.DoMM(fmk, X, Y);
end;

procedure TMain0.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer);
begin
  if FederModel.MeshSize > MainConst.DefaultMeshSize then
    FederModel.MeshSize := MainConst.DefaultMeshSize;

  if (ssCtrl in Shift) and (ssShift in Shift) then
  begin
//    DoRasterWheel(WheelDelta);
  end
  else if ssCtrl in Shift then
  begin
    DoBigWheel(WheelDelta);
  end
  else if ssShift in Shift then
  begin
    DoSmallWheel(WheelDelta);
  end
end;

procedure TMain0.DoReset;
begin
  FederModel.Active := False;

  FederModel.Reset;
  FederModel.EQ.Reset;

  FederData.InitDefault;
  InitSample1(FederData);
  LoadFromFederData;
  FormMain.ResetCamera;

  InitDataOK := False;
  FFederParam := fpcz;

  FederModel.Active := True;

  Refresh;

  UpdateRings;
end;

procedure TMain0.DoResetPosition;
begin
  FormMain.ResetPosition;
end;

procedure TMain0.DoResetRotation;
begin
  FormMain.ResetRotation;
end;

procedure TMain0.DoResetZoom;
begin
  FormMain.ResetZoom;
end;

procedure TMain0.DoTouchbarBottom(Delta: single);
begin
  DoZoom(Delta / 20);
end;

procedure TMain0.DoTouchbarLeft(Delta: single);
begin
  DoBigWheel(Delta / 30);
end;

procedure TMain0.DoTouchbarRight(Delta: single);
begin
  DoSmallWheel(Delta / 50);
end;

procedure TMain0.DoTouchbarTop(Delta: single);
begin
  DoMM(fmkRZ, Delta / 1, 0);
end;

procedure TMain0.FrameVisibilityChanged;
begin
  FormMain.UpdateHintText(faNoop);
end;

procedure TMain0.DoZoom(const Delta: single);
begin
  FormMain.DoZoom(Delta);
end;

function TMain0.GetBitmap: Integer;
begin
  result := FBitmap;
end;

function TMain0.GetBitmapBuilder: TBitmapBuilder02;
begin
  result := FederTexture.BitmapBuilder;
end;

function TMain0.GetCapValue: single;
begin
  result := FederModel.CapValue;
end;

function TMain0.GetColorPanelColor: TAlphaColor;
begin
  result := FederText1.SwatColor;
end;

function TMain0.GetColorScheme: Integer;
begin
  result := MainVar.ColorScheme.Scheme;
end;

function TMain0.GetFederText: TFederTouchBase;
begin
  case FTouch of
    faTouchTablet: result := FederText1;
    faTouchPhone: result := FederText2;
    faTouchDesk:
    begin
      if IsPhone then
        result := FederText2
      else
        result := FederText1;
    end;
    else
      result := FederText1;
  end;
end;

function TMain0.GetInitDataOK: Boolean;
begin
  result := MainVar.InitDataOK;
end;

function TMain0.GetIsDesktop: Boolean;
begin
  result := not IsMobile;
end;

function TMain0.GetIsLandscape: Boolean;
begin
  result := FormMain.ClientWidth > FormMain.ClientHeight;
end;

function TMain0.GetLoopFaktor: single;
begin
  result := FederModel._fp0 / MainVar.WheelFrequency;
end;

function TMain0.GetIsPhone: Boolean;
var
  MinCount, MaxCount: Integer;
begin
  case FTouch of
    faTouchPhone: result := True;
    faTouchTablet: result := False;
    else
    begin
      MinCount := Min(FormMain.ClientHeight, FormMain.ClientWidth) div MainVar.Raster;
      MaxCount := Max(FormMain.ClientHeight, FormMain.ClientWidth) div MainVar.Raster;
      result  := (MinCount < 8) or (MaxCount < 12);
    end;
  end;
end;

function TMain0.GetIsPortrait: Boolean;
begin
  result := not IsLandscape;
end;

function TMain0.GetIsRetina: Boolean;
begin
  result := FIsRetina;
end;

function TMain0.GetMaterialSource: TLightMaterialSource;
begin
  result := FMaterialSource;
end;

function TMain0.GetMenubarLayout: Integer;
begin
  result := 0;
end;

function TMain0.GetMeshBuilder: TFederMeshBuilder;
begin
  result := FederMesh.FederMeshBuilder;
end;

function TMain0.GetMeshSize: Integer;
begin
  if FederModel = nil then
    result := 128
  else
    result := FederModel.MeshSize;
end;

function TMain0.GetParamCaption: string;
begin
  case FederParam of
    fpcz: result := 'cz';
    fpT1: result := 't1';
    fpT2: result := 't2';
    fpL: result := 'L';
    fpParamCapValue: result := 'pcv';
    fpNorthCapValue: result := 'ncv';
    fpSouthCapValue: result := 'scv';
    fpAbsoluteRange: result := 'AR';
    fpBandWidth: result := 'bw';
    else
      result := '*';
  end;
end;

function TMain0.GetParamValue: single;
begin
  case FederParam of
    fpcz: result := FormMain.Camera.Position.Z;
    fpT1: result := FederModel.FT1;
    fpT2: result := FederModel.FT2;
    fpParamCapValue: result := FederModel.CapValue;
    fpL: result := FederModel.EQ.l1;
    fpNorthCapValue: result := FederModel.North;
    fpSouthCapValue: result := FederModel.South;
    fpAbsoluteRange: result := FederModel.AbsoluteRange;
    fpBandWidth: result := FederModel.ParamBandWidth;
    else
      result := 0;
  end;
end;

function TMain0.GetReport(Value: TReportPage): string;
begin
  result := FederReport.GetReport(Value);
end;

function TMain0.GetReportPage: TReportPage;
begin
  result := ActionHandler.ReportPage;
end;

function TMain0.GetRetinaScale: single;
begin
  if FormMain.Viewport <> nil then
    result := FormMain.Viewport.Scene.GetSceneScale
  else
    result := 1.0;
end;

function TMain0.GetRingColor(j: Integer): TAlphaColor;
begin
  result := claWhite;
  FCurrentRing := j;
  if (j < 1) or (j > StripConst.StripCount) then
    FCurrentRing := 0
  else
    result := BitmapBuilder.RingColor[j];
end;

function TMain0.GetRingContourWidth: Integer;
begin
  result := BitmapBuilder.RingWidthContour[CurrentRing];
end;

procedure TMain0.GetRingInfoReport(ASL: TStrings);
begin
  BitmapBuilder.GetRingInfoReport(TSizeName.Medium, ASL);
end;

function TMain0.GetRingWidth: Integer;
begin
  result := BitmapBuilder.RingWidth[CurrentRing];
end;

function TMain0.GetSideCapVisible: Boolean;
begin
  result := SolidPart.WantSideCaps;
end;

function TMain0.GetTransitBarLayout: Integer;
begin
  if Assigned(FederText) then
    result := FederText.TransitBarLayout
  else
    result := 1;
end;

function TMain0.GetShowColorPanel: Boolean;
begin
  result := FormMain.ShowColorPanel;
end;

function TMain0.GetShowColorSwat: Boolean;
begin
  result := FederText1.ColorSwat.Visible;
end;

function TMain0.GetShowCurrentBand: Boolean;
begin
  if BitmapBuilder <> nil then
    result := BitmapBuilder.ShowCurrentBand
  else
    result := False;
end;

procedure TMain0.GotoColorScheme(Value: Integer);
var
  i: Integer;
  l: Boolean;
begin
  l := FederData.BackgroundLock;
  FederData.BackgroundLock := false;
  i := Value;

  if (i < 1) then
    i := MainConst.ColorSchemeCount;
  if i > MainConst.ColorSchemeCount then
    i := 1;

  ColorScheme := i;
  FederData.BackgroundLock := l;
end;

procedure TMain0.GraphUpdateNeeded;
begin
  GraphUpdatingNeeded := True;
end;

procedure TMain0.HandleAction(fa: TFederAction; CanBubble: Boolean);
begin
  case fa of
    faNoop: ;
  end;

  if CanBubble then
    BubbleUpAction(fa);
end;

procedure TMain0.Init;
begin
  FederData.ResetUI;

  InitText;

  FCurrentRing := 21;
  MenubarLayout := 0;
end;

procedure TMain0.InitDefaultRingWidth(Value: Integer);
begin
  BitmapBuilder.InitDefaultRingWidth(Value);
end;

procedure TMain0.InitFederModel(fd: TFederData);
begin
  FederModel.IsCombi := False;

  FederModel.Scene := fd.Scene;
  FederModel.Plot := fd.Plot;
  FederModel.Figure := fd.Figure;
  FederModel.Param := fd.Param;

  FederModel.ParamValueQuick := FederModel.ParamValue;
end;

procedure TMain0.InitFederText(ft: TFederText);
begin
  if ft is TLayout then
  begin
    ft.Parent := FormMain.ContentParent;
    TFederTouchBase.OwnerComponent := ft;
    TFederTouchBase.ParentObject := ft;
  end
  else
  begin
    TFederTouchBase.OwnerComponent := FormMain;
    TFederTouchBase.ParentObject := FormMain.ContentParent;
  end;

  ft.Position.X := 0;
  ft.Position.Y := 0;
  ft.Width := MainVar.ClientWidth;
  ft.Height := MainVar.ClientHeight;
  ft.Init;
end;

procedure TMain0.InitMappedReports;
var
  cl: TList<TReportPage>;
begin
  MappedReports := TList<TReportPage>.Create;
  cl := MappedReports;
  cl.AddRange([
    rpRingInfo,
//    rpColorMapping,
//    rpSelectedColors,
    rpAppInfo,
    rpModelStatus,
    rpViewStatus,
    rpLockStatus,
//    rpLightInfo,
//    rpRotationInfo,
//    rpMatrixInfo,
    rpColorInfo1,
    rpColorInfo2,
    rpMeshDataInfo
   ]);
end;

procedure TMain0.InitMaterial;
var
  bmp: TBitmap;
begin
  if MainConst.WantOldBandColors then
    bmp := FederTexture.GetBitmap(17)
  else
    bmp := FederTexture.GetBitmap(14);

  FMaterialSource := TLightMaterialSource.Create(nil);
  FMaterialSource.Texture := bmp;
  bmp.Free;
end;

procedure TMain0.InitRaster;
begin
  MainVar.ClientWidth := FormMain.ClientWidth;
  MainVar.ClientHeight := FormMain.ClientHeight;
end;

procedure TMain0.InitSample1(fd: TFederData);
begin
  with fd do
  begin
    Title := 'Federgraph';
    SubTitle := 'das Original';
    Version := 2;
    x1 := 64.95;
    x2 := -64.95;
    y1 := 37.5;
    y2 := 37.5;
    y3 := -75;
    l1 := 90;
    l2 := 90;
    l3 := 90;
    l4 := 90;
    MeshSize := 128;
    Limit := 0;
    Plot := 10;
    Figure := 2;
    Param := 14;
    Bitmap := 22;
    AngleX := 180.00;
    AngleY := -10.00;
    PosY := 1;
    PosZ := 9.15;
    T1 := 0;
    T2 := 180;
    StandardColor := 17;
    ShowCylinder := False;
    ShowDiameter := False;
    ColorScheme3D := 4;
    Lux := True;
    Lux1 := True;
    Lux2 := False;
    Lux3 := True;
    Lux4 := False;

    OffsetY := -30;
    CapValue := 60;
    AbsoluteRange := 120;
    PlusCap := False;
    ReducedMesh := True;
  end;
end;

procedure TMain0.InitText;
begin
  InitRaster;
  InitFederText(FederText1);
  InitFederText(FederText2);
  Touch := faTouchDesk;
end;

procedure TMain0.InitTouch;
begin
  InitRaster;
  FederText1.Visible := not IsPhone;
  FederText2.Visible := IsPhone;
end;

procedure TMain0.InitTouchbarHelpText;
begin
  FL.Clear;

  FL.Add('T');
  FL.Add('o');
  FL.Add('u');
  FL.Add('c');
  FL.Add('h');
  FL.Add('b');
  FL.Add('a');
  FL.Add('r');

  TFederTouchBase.HorizontalTouchbarHelpText := 'Touchbar';
  TFederTouchBase.VerticalTouchbarHelpText := FL.Text;

  FL.Clear;
end;

function TMain0.IsTouchBtnEnabled(Btn: TTouchBtn): Boolean;
begin
  result := True;
end;

procedure TMain0.LoadColorInfoOnly;
begin
  FederTexture.BitmapBuilder.UpdateReason := TUpdateReason.cuBandsPasted;
  FederTexture.BitmapBuilder.Changed := True;
end;

procedure TMain0.LoadFromFederData;
var
  fd: TFederData;
begin
  fd := FederData;
  if fd.HasColorInfo and not fd.HasModelInfo then
    LoadColorInfoOnly
  else
    LoadModelInfo;
end;

procedure TMain0.LoadModelInfo;
var
  fd: TFederData;
begin
  fd := FederData;

  FederModel.LoadFromFederData(fd);

  FederModel.Loading := True;
  try
    InitFederModel(fd);
  finally
    FederModel.Loading := False;
  end;

  FederModel.InitData;

  ClearFlashNeeded;
  TextUpdateNeeded;
  CheckStateNeeded;
end;

procedure TMain0.MarkForUpdate(Value: TUpdateReason);
begin
  BitmapBuilder.MarkForUpdate(Value);
end;

procedure TMain0.PickRing(X, Y: single);
begin
  if FederMesh.Parent <> nil then
    FederMesh.PickRing(X, Y);
end;

procedure TMain0.PrepareForExample;
var
  fm: TFederModel;
begin
  FBitmap := 0;
  fm := Main.FederModel;

  fm.Active := False;

  fm.FT1 := 0;
  fm.FT2 := 180;
  fm.FT3 := 1;
  fm.FT4 := 5;

  fm.PlusCap := True;

  fm.Active := True;

  BitmapBuilder.WantContour := False;
  ShowCurrentBand := False;
  FederTexture.BitmapBuilder.ShowCurrentBand := False;
end;

procedure TMain0.RandomBitmapBlack;
begin
  BitmapBuilder.UpdateReason := TUpdateReason.cuRandom;
  Bitmap := StripConst.RandomColorIndexB;
end;

procedure TMain0.RandomBitmapWhite;
begin
  BitmapBuilder.UpdateReason := TUpdateReason.cuRandom;
  Bitmap := StripConst.RandomColorIndexW;
end;

procedure TMain0.ReadSample(ML: TStrings);
begin
  try
    FederData.Load(ML);

    if FederData.HasBandColor then
      BitmapBuilder.UpdateReason := TUpdateReason.cuBandsPasted;
    if FederData.HasStripColor then
      BitmapBuilder.UpdateReason := TUpdateReason.cuStripsPasted;

    LoadFromFederData;
    BubbleUpAction(faNoop);
  except
    ResetRequested;
  end;
end;

procedure TMain0.Refresh;
begin
  FederModel.InitRange;
  FederModel.InitData;
  FederModel.UpdateVP;
  GraphUpdateNeeded;
  TextUpdateNeeded;
  BubbleUpAction(faNoop);
end;

procedure TMain0.ResetRequested;
begin
  DoReset;
end;

procedure TMain0.RingIndexChanged;
var
  j: Integer;
begin
  j := Round(FederModel.ParamBandSelected);
  if (j >= 1) and (j <= StripConst.StripCount) then
  begin
    FCurrentRing := j;
    FederModel.ParamBandWidth := RingWidth;
    FederText1.SwatColor := GetRingColor(j);
    FederText2.SwatColor := FederText1.SwatColor;
    if ShowCurrentBand then
    begin
      BitmapBuilder.UpdateReason := TUpdateReason.cuRingColor;
      UpdateRings;
    end;
    RingIndexUpdated;
  end;
end;

procedure TMain0.RingIndexUpdated;
begin
  Main.TextUpdateNeeded;
  Main.BubbleUpAction(faNoop);
end;

procedure TMain0.SetBandWidthOption(const Value: TBandWidthOption);
begin
  FBandWidthOption := Value;
end;

procedure TMain0.SetBitmap(const Value: Integer);
begin
  FBitmap := Value;
  if BMP <> nil then
    BMP.Free;
  BMP := Main.FederTexture.GetBitmap(FBitmap);
  if FMaterialSource <> nil then
    FMaterialSource.Texture := BMP;
end;

procedure TMain0.SetColorPanelColor(const Value: TAlphaColor);
begin
  FColorPanelColor := Value;
  FormMain.BandColor := Value;
  FederText1.SwatColor := Value;
  FederText2.SwatColor := Value;
end;

procedure TMain0.SetColorScheme(const Value: Integer);
begin
  if not FederData.BackgroundLock then
  begin
    MainVar.ColorScheme.Scheme := Value;
    MainVar.ColorScheme.Init(Value);
    FormMain.UpdateBackground;
    FederText1.UpdateColorScheme;
    FederText2.UpdateColorScheme;
  end;
end;

procedure TMain0.SetCurrentRing(const Value: Integer);
begin
  FCurrentRing := Value;
  if (ActionHandler.ReportPage = rpColorInfo1)
  or (ActionHandler.ReportPage = rpColorInfo2)
  then
    TextUpdateNeeded;
  if FederParam = fpBandWidth then
  begin
    FederModel.ParamBandWidth := RingWidth;
  end;
end;

procedure TMain0.SetFederParam(const Value: TFederParam);
begin
  FFederParam := Value;
  TextUpdateNeeded;
end;

procedure TMain0.SetInitDataOK(const Value: Boolean);
begin
  MainVar.InitDataOK := Value;
end;

procedure TMain0.SetMenubarLayout(const Value: Integer);
begin

end;

procedure TMain0.SetMeshSize(const Value: Integer);
begin
  FederModel.MeshSize := Value;
  GraphUpdateNeeded;
end;

procedure TMain0.SetRingColor(j: Integer; const c: TAlphaColor);
begin
  FCurrentRing := j;
  if (j < 1) or (j > StripConst.StripCount) then
    FCurrentRing := 1
  else
  begin
    BitmapBuilder.RingColor[j] := c;
    FederText1.SwatColor := c;
    FederText2.SwatColor := c;
    TextUpdateNeeded;
  end;
end;

procedure TMain0.SetRingWidth(const Value: Integer);
begin
  BitmapBuilder.UpdateReason := TUpdateReason.cuParamBandWidth;
  case BandWidthOption of
    bwAbsolute: BitmapBuilder.RingWidth[CurrentRing] := Value;
    bwRelative: BitmapBuilder.RingWidthRelative[CurrentRing] := Value;
    bwContour: BitmapBuilder.RingWidthContour[CurrentRing] := Value;
  end;
end;

procedure TMain0.SetSelectedColor(const Value: Integer);
var
  cr: TPrintColorSet;
begin
  FSelectedColor := Value;
  cr := RingBuilder.SelectedColors;
  case FSelectedColor of
    1: ColorPanelColor := cr.Color1;
    2: ColorPanelColor := cr.Color2;
    3: ColorPanelColor := cr.Color3;
    4: ColorPanelColor := cr.Color4;
  end;
  ShowColorSwat := True;
end;

procedure TMain0.SetShowColorPanel(const Value: Boolean);
begin
  if FormMain <> nil then
    FormMain.ShowColorPanel := Value;
end;

procedure TMain0.SetShowColorSwat(const Value: Boolean);
begin
  FederText1.SwatVisible := Value;
  FederText2.SwatVisible := Value;
end;

procedure TMain0.SetShowCurrentBand(const Value: Boolean);
begin
  if (FederTexture <> nil) and (FederTexture.BitmapBuilder <> nil) then
  begin
    FederTexture.BitmapBuilder.ShowCurrentBand := Value;
    FederTexture.BitmapBuilder.UpdateReason := cuContour;
    if Value then
      FederTexture.BitmapBuilder.WantContour := True;
    CheckStateNeeded;
    UpdateRings;
  end;
end;

procedure TMain0.SetTouch(const Value: Integer);
begin
  FTouch := Value;
  if IsPhone then
    FederText1.Visible := False
  else case FTouch of
    faTouchTablet: FederText1.Visible := True;
    faTouchPhone: FederText1.Visible := False;
    else
      FederText1.Visible := not IsPhone;
  end;
  FederText2.Visible := not FederText1.Visible;

  FederText.UpdateShape;
end;

procedure TMain0.SetTransitBarLayout(const Value: Integer);
begin
  if Assigned(FederText) then
    FederText.TransitBarLayout := Value;
end;

procedure TMain0.SetUpdateReason(const Value: TUpdateReason);
begin
  BitmapBuilder.UpdateReason := Value;
end;

procedure TMain0.ShowInfo;
begin
  ActionHandler.ReportPage := rpAppInfo;
  TextUpdateNeeded;
  FHelpFlash := True;
end;

procedure TMain0.DoSmallWheel(Delta: single);
begin
  DoBigWheel(Delta / 10);
end;

procedure TMain0.TextUpdateNeeded;
begin
  TextUpdatingNeeded := True;
end;

procedure TMain0.ToggleColorPanel;
begin
  ShowColorPanel := not ShowColorPanel;
end;

procedure TMain0.ToggleContourPixel;
begin
  BitmapBuilder.WantContour := not BitmapBuilder.WantContour;
  BitmapBuilder.MarkForUpdate(TUpdateReason.cuContour);
end;

procedure TMain0.ToggleLabelBatch(Value: Integer);
var
  i: Integer;
begin
  i := FReportIndex;
  if Value > 0 then
    Inc(i)
  else
    Dec(i);
  if i > MappedReports.Count - 1 then
    i := 0;
  if i < 0 then
    i := MappedReports.Count - 1;
  FReportIndex := i;
  ActionHandler.ReportPage := MappedReports[FReportIndex];
  TextUpdateNeeded;
end;

procedure TMain0.ToggleLux(Value: Integer);
begin
  FederData.LuxLock := False;
  vp.WantLux := not vp.WantLux;
  FormMain.ToggleLux;
  if MainVar.WantUniqueVertices then
  begin
    FederModel.Refresh;
  end;
end;

procedure TMain0.ToggleSpecialY;
begin
  MeshBuilder.WantSpecialY := not MeshBuilder.WantSpecialY;
  FederModel.Refresh;
end;

procedure TMain0.UpdateBitmap;
begin
  Bitmap := Bitmap;
end;

procedure TMain0.UpdateCurrentRing(TexCoordY: single);
var
  r: Integer;
begin
  r := BitmapBuilder.FindPickedRing(TexCoordY);
  if (r > 0) and (r <= StripConst.StripCount) then
    CurrentRing := r;
end;

procedure TMain0.UpdateFederTextData(var TD: TFederTextData);
var
  ff: TFloatFormat;
begin
  Inc(CounterTextUpdate);

  TD.Spruch := FederText.Spruch;

  if MainVar.WheelFrequency = 1 then
    ff := ffGeneral
  else
    ff := ffFixed;

  if TD.Spruch <> '' then
    TD.MsgText := TD.Spruch;

  TD.HelpFlash := FHelpFlash;
  FHelpFlash := False;

  TD.ST00 := TActionMap.CurrentPageCaption;

  if FederModel.MeshSize = 1024 then
    TD.SR00 := '1K'
  else
    TD.SR00 := IntToStr(FederModel.MeshSize);

  TD.SL00 := ParamCaption;
  TD.SB00 := Format('%.2f', [ParamValue]);

  TD.StatusLine := Format('(AR = %s, OY = %s, CV = %s)', [
    FloatToStrF(FederModel.AbsoluteRange, ff, 7, 2),
    FloatToStrF(FederModel.OffsetY, ff, 7, 2),
    FloatToStrF(FederModel.CapValue, ff, 7, 2)
    ]);

  TD.OptionLine := FederData.ComputedTitle;
  TD.RecorderLine := '';
  TD.EquationLine := '';

  if MainVar.ClientHeight < MainVar.ClientWidth then
  begin
      TD.MilliesLine :=
      Format('%d Millies ~ ', [InitDataMillies]) +
      IntToStr(CounterInitData) + ' InitData ~ ' +
      IntToStr(CounterDrawing3D) + ' Drawing ~ ' +
      IntToStr(CounterTextUpdate) + ' Text ~ ' +
      IntToStr(CounterCheckState) + ' Check';
  end
  else
  begin
{$ifdef Debug}
    TD.MilliesLine :=
      IntToStr(CounterDrawing3D) + ' D ' +
      IntToStr(CounterTextUpdate) + ' T ' +
      IntToStr(CounterCheckState) + ' C';
{$else}
    TD.MilliesLine := '';
{$endif}
  end;

  TD.EquationText := GetReport(ActionHandler.ReportPage);
end;

procedure TMain0.UpdateFederTextDataPhone(var TD: TFederTextDataPhone);
begin
  Inc(CounterTextUpdate);

  TD.HelpFlash := FHelpFlash;
  FHelpFlash := False;

  TD.ST00 := TActionMap.CurrentPageCaptionPhone;

  if FederModel.MeshSize = 1024 then
    TD.SR00 := '1K'
  else
    TD.SR00 := IntToStr(FederModel.MeshSize);

  TD.SL00 := ParamCaption;
  TD.SB00 := Format('%.2f', [ParamValue]);

  if (FederText.ActionPage > 1) and (FederText.ActionPage < 5) then
  begin
    TD.Line1 := '';
    TD.Line2 := '';
    TD.Line3 := '';

    TD.Line4 := 'Color 1 = ' + ColorVar.RggColorPool.ColorToString(RingBuilder.SelectedColors.Color1);
    TD.Line5 := 'Color 2 = ' + ColorVar.RggColorPool.ColorToString(RingBuilder.SelectedColors.Color2);
    TD.Line6 := 'Color 3 = ' + ColorVar.RggColorPool.ColorToString(RingBuilder.SelectedColors.Color3);
  end
  else
  begin
    TD.Line1 := '';
    TD.Line2 := '';
    TD.Line3 := '';
    if FederText.ActionPage = 8 then
    TD.Line3 := 'federgraph.de';


    TD.Line4 := '';
    TD.Line5 := '';
    TD.Line6 := '';
  end;
end;

procedure TMain0.UpdatePrintColors(ASelectedColors: TPrintColorSet);
begin
  PrepareForExample;
  RingBuilder.InitWithNewSelectedColors(ASelectedColors);
end;

procedure TMain0.UpdateReport;
begin
  ActionHandler.Execute(CurrentReportAction);
end;

procedure TMain0.UpdateRingColor(AColor: TAlphaColor);
begin
  UpdateRingColor(CurrentRing, AColor);
end;

procedure TMain0.UpdateRingColor(ARing: Integer; AColor: TAlphaColor);
var
  ring: Integer;
begin
  if IsUp then
  begin
    ring := ARing;

    if ring < 1 then
      ring := 1;
    if ring > StripConst.StripCount then
      ring := StripConst.StripCount;

    RingColor[ring] := AColor;
    Bitmap := FBitmap;
    GraphUpdateNeeded;
  end;
end;

procedure TMain0.UpdateRings;
begin
  if not FederData.TextureLock then
  begin
    BitmapBuilder.UpdatingRings := True;
    Bitmap := Bitmap;
  end;
end;

procedure TMain0.UpdateSelectedColor(const Value: TAlphaColor);
var
  cr: TPrintColorSet;
begin
  cr := RingBuilder.SelectedColors;
  case FSelectedColor of
    1: cr.Color1 := Value;
    2: cr.Color2 := Value;
    3: cr.Color3 := Value;
    4: cr.Color4 := Value;
  end;
  UpdatePrintColors(cr);
end;

procedure TMain0.UpdateShirtColor(Value: Boolean);
begin
  HasShirtColor := Value;
  BitmapBuilder.WantShirtColor := HasShirtColor;
  BlindRing(0);
end;

procedure TMain0.UpdateShirtFarbe(Value: Boolean);
begin
  HasShirtFarbe := Value;
  BitmapBuilder.WantShirtFarbe := HasShirtFarbe;
  BlindRing(0);
end;

procedure TMain0.UpdateText;
begin
  if IsUp then
  begin
    if IsReady then
    begin
      if Assigned(FederText) then
      begin
        ClearFlashNeeded;
        TextUpdateNeeded;
      end;
    end;
  end;
end;

procedure TMain0.UpdateTouch;
begin
  if Assigned(FederText) and FederText.InitOK then
  begin
//    Frame3D.UpdateRasterSize(IsRetina, FormMain.ClientWidth, FormMain.ClientHeight);
    MainVar.ClientWidth := FormMain.ClientWidth;
    MainVar.ClientHeight := FormMain.ClientHeight;
    InitTouch;
    FederText.UpdateMissing;
    FederText.UpdateShape;
    FederText.UpdatePageBtnText;
  end;
end;

procedure TMain0.UpdateVP;
begin
  vp.range := FederModel.AbsoluteRange;

  vp.ox := FederModel.OffsetX;
  vp.oy := FederModel.OffsetY;
  vp.oz := FederModel.OffsetZ;

  vp.mc :=  FederModel.mc;

  vp.ReducedMesh := True;
  vp.ReduceMode := 0;

  vp.CapValue := FederModel.CapValue;
  vp.SliceHeight := FederModel.CapValue;

  vp.NormScale := MainVar.Transform3D.NormScale;
  vp.GlobalScale := MainVar.Transform3D.GlobalScale;
  vp.ModelGroupScale := 1;

  vp.T1 := FederModel.FT1;
  vp.T2 := FederModel.FT2;

  vp.OffsetZ := FederModel.OffsetZ;
  vp.MinusCap := FederModel.MinusCap;
  vp.PlusCap := FederModel.PlusCap;
  vp.EQ := FederModel.Equation;
  vp.SpringCount := FederModel.EQ.SpringCount;
  vp.Attenuation := FederModel.Attenuation;
  vp.Figure := FederModel.Figure;

  vp.Update;

  TColorBand.T1 := FederModel.FT1;
  TColorBand.T2 := FederModel.FT2;
end;

procedure TMain0.ToggleShowEdges;
begin
  MainVar.ShowEdges := not MainVar.ShowEdges;
  Main.GraphUpdateNeeded;
end;

function TMain0.FederPaletteHandleTouchBtnClick(Btn: TTouchBtn): Boolean;
begin
  result := False;
end;

procedure TMain0.ExportObj;
begin
  if ExporterOBJ = nil then
    ExporterOBJ := TExporterOBJ.Create;

  SolidPart.ExportOBJ(ExporterObj, True);
end;

procedure TMain0.ExportMtl;
begin
  if ExporterOBJ = nil then
    ExporterOBJ := TExporterOBJ.Create;

  ExporterOBJ.SaveMTL;
end;

procedure TMain0.ToggleBottom;
begin
  SolidPartVisible := not SolidPartVisible;
end;

procedure TMain0.ToggleSolidFlip;
begin
  FederMesh.WantFlippedHands := not FederMesh.WantFlippedHands;
  InitDataOK := False;
  FederModel.InitData;
end;

procedure TMain0.ToggleSideCaps;
begin
  SideCapVisible := not SideCapVisible;
end;

procedure TMain0.ToggleSingleSide;
begin
  SolidPart.TestSingleSide := not SolidPart.TestSingleSide;
end;

procedure TMain0.AddMeshesToScene(ModelParent: TFmxObject);
begin
  ModelParent.AddObject(FederMesh);
  ModelParent.AddObject(Inner);
  ModelParent.AddObject(SolidPart);
end;

procedure TMain0.InitData(Sender: TObject);
begin
  If not IsUp then
    Exit;

  StopWatch.Start;

  UpdateVP;

  if InitDataOK and (FederParam in [fpt1, fpt2, fpBandWidth]) then
  begin
    FederMesh.UpdateColor;
  end
  else
  begin
    vp.PlusCap := FederModel.PlusCap;
    vp.ReducedMesh := True;
    vp.WantZeroPulling := MeshBuilder.WantZeroPulling;
    vp.WantSlicePulling := MeshBuilder.WantSlicePulling;
    vp.SlicePullingMode := MeshBuilder.SlicePullingMode;
    vp.ReduceMode := MeshBuilder.ReduceMode;
    vp.WantFlippedHands := FederMesh.WantFlippedHands;
    vp.WantMirroredBottom := False;
    vp.WantUniqueVertices := MainVar.WantUniqueVertices;
    vp.OuterOptionZ := TVertexOptionZ.Normal;
    TSolidSide.CenterPointInsetZ := 10;

    FederMesh.InitData;

    if SolidPartVisible then
    begin
      vp.PlusCap := True;
      vp.ReducedMesh := True;
      vp.WantSlicePulling := True;
      vp.SlicePullingMode := 0;
      vp.ReduceMode := 3;
      vp.WantFlippedHands := False;
      vp.WantMirroredBottom := Inner.WantMirroredBottom;
      vp.WantUniqueVertices := False;

      if Inner.WantMirroredBottom then
      begin
        vp.WantZeroPulling := True;
        vp.OuterOptionZ := TVertexOptionZ.MirroredBottom;
        vp.WantFlippedHands := FederMesh.WantFlippedHands;
        Inner.FederMeshBuilder.FlatMesh := False;
        Inner.MaterialSource := Outer.MaterialSource;
        Inner.BB.Flatten := False;
        Inner.BB.Mirror := True;
        TSolidSide.CenterPointInsetZ := 0;
      end
      else
      begin
        vp.WantZeroPulling := False;
        Inner.FederMeshBuilder.FlatMesh := True;
        Inner.MaterialSource := SolidPart.InnerMaterialSource;
        Inner.BB.Flatten := True;
        Inner.BB.Mirror := False;
        TSolidSide.CenterPointInsetZ := 10;
      end;

      Inner.InitData;
      SolidPart.UpdateGroup;
    end;

    InitDataOK := True;
  end;

  StopWatch.Stop;
  InitDataMillies := StopWatch.ElapsedMilliseconds;

  Inc(CounterInitData);
  GraphUpdateNeeded;
end;

procedure TMain0.SetSolidPartVisible(const Value: Boolean);
begin
  FSolidPartVisible := Value;

  Inner.Visible := Value;
  SolidPart.Visible := Value;

  if Value then
  begin
    vp.ReducedMesh := True;
    InitDataOK := False;
    InitData(nil);
  end;
end;

procedure TMain0.SetSideCapVisible(const Value: Boolean);
begin
  if Value then
  begin
    SolidPart.WantSideCaps := True;
    InitDataOK := False;
    InitData(nil);
  end
  else
  begin
    SolidPart.WantSideCaps := False;
  end;
end;

procedure TMain0.ToggleMirroredBottom;
begin
  Inner.WantMirroredBottom := not Inner.WantMirroredBottom;
  FederModel.Refresh;
end;

end.
