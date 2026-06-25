unit RiggVar.App.Main0;

(*
-
-     F
-    * *  *
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

{$define WantFederText}

uses
  System.SysUtils,
  System.Classes,
  System.Math,
  System.Math.Vectors,
  System.Rtti,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Generics.Collections,
  FMX.Forms,
  FMX.Types,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Platform,
  FMX.Controls3D,
  FMX.Types3D,
  FMX.Viewport3D,
  FMX.Objects,
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
  RiggVar.FB.Classes,
  RiggVar.FB.ColorConst,
  RiggVar.FB.Color,
  RiggVar.FB.ColorBambu,
  RiggVar.FB.Data,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.Frame,
  RiggVar.FB.Hub,
  RiggVar.FB.Logger,
  RiggVar.FB.MeshParams,
  RiggVar.FB.Model,
  RiggVar.FB.Params,
  RiggVar.FB.Report,
  RiggVar.FB.Scheme,
  RiggVar.FB.StopWatch,
  RiggVar.FB.Text,
  RiggVar.FB.Transform,
  RiggVar.FB.Update,
  RiggVar.FederModel.Binding,
  RiggVar.FederModel.Color,
  RiggVar.FederModel.Format,
  RiggVar.FederModel.Frame3D,
  RiggVar.FederModel.Graph,
  RiggVar.FederModel.Keyboard01,
  RiggVar.FederModel.Memory,
  RiggVar.FederModel.Palette,
  RiggVar.FederModel.RingBuilder,
  RiggVar.FederModel.SampleManager,
  RiggVar.FederModel.Touch,
  RiggVar.FederModel.TouchBase,
  RiggVar.FederModel.TouchPhone,
  RiggVar.Mesh.ExporterOBJ,
  RiggVar.Mesh.FederShell1,
  RiggVar.Mesh.SolidPart,
  RiggVar.Mesh.MeshBuilder,
  RiggVar.Util.ActionTable,
  RiggVar.Util.BitmapCache,
  RiggVar.Util.BitmapImprinter;

type
  TMain0 = class
  private
    FBandWidthOption: TBandWidthOption;
    FColorPanelColor: TAlphaColor;
    FCurrentCoord: Integer;
    FCurrentLight: Integer;
    FCurrentRing: Integer;
    FDisplay: Integer;
    FExampleID: Integer;
    FHasShirtColor: Boolean;
    FHasShirtFarbe: Boolean;
    FHelpFlash: Boolean;
    FIsMobile: Boolean;
    FIsRetina: Boolean;
    FKeyBinding: Integer;
    FL: TStringList;
    FLayer: Integer;
    FOnMemoDraw: TNotifyEvent;
    FPixelCount: Integer;
    FReportIndex: Integer;
    FSelectedColor: Integer;
    FShowColorSwat: Boolean;
    FSolidPartVisible: Boolean;
    FTouch: Integer;
    FUpdatingColorMix: Boolean;
    FWantIdleMove: Boolean;
    FWantStripColorText: Boolean;
    FWheelFrequency: Integer;
    MappedReports: TList<TReportPage>;
    procedure CopyFL;
    procedure CreateFedergraph;
    procedure DoBigWheelForNormal(Delta: single);
    procedure DoSmallWheelForNormal(Delta: single);
    procedure DoWheelForBandWidth(Delta: single);
    procedure DoWheelForPanX(Delta: single);
    procedure DoWheelForPanY(Delta: single);
    function GetBigmap: Boolean;
    function GetBitmap: Integer;
    function GetBitmapBuilder: TBitmapBuilder02;
    function GetCanPick: Boolean;
    function GetCapValue: single;
    function GetColor: Integer;
    function GetColorPanelColor: TAlphaColor;
    function GetColorScheme: Integer;
    function GetCoordMode: Boolean;
    function GetCurrentParam: TFederParam;
    function GetDetailPulling: Boolean;
    function GetDim: Integer;
    function GetFederFrame: TFederFrameBase;
    function GetFederText: TFederTouchBase;
    function GetFigure: Integer;
    function GetFigureSize: TSizeName;
    function GetFilterMesh: Boolean;
    function GetFlippedTexture: Boolean;
    function GetForceMode: Integer;
    function GetFrame2DMouseDown: Boolean;
    function GetFrame3D: TFederFrame3D;
    function GetGleich: Boolean;
    function GetGraph: Integer;
    function GetHub: Integer;
    function GetInitDataOK: Boolean;
    function GetIsDesktop: Boolean;
    function GetIsInputClient: Boolean;
    function GetIsLandscape: Boolean;
    function GetIsPhone: Boolean;
    function GetIsPortrait: Boolean;
    function GetIsRetina: Boolean;
    function GetLevel: Integer;
    function GetLightMode: Boolean;
    function GetLimitPulling: Boolean;
    function GetLoopFaktor: single;
    function GetMaterialSource: TMaterialSource;
    function GetMenubarLayout: Integer;
    function GetMeshBuilder: TFederMeshBuilder;
    function GetMeshSize: Integer;
    function GetMinusCap: Boolean;
    function GetMoveMode: Boolean;
    function GetMoveModeText: string;
    function GetOpacity: Boolean;
    function GetOpenMesh: Boolean;
    function GetOrbitMode: Boolean;
    function GetPaletteMode: Boolean;
    function GetParam: Integer;
    function GetParamValue: single;
    function GetPickShift: Boolean;
    function GetPlot: Integer;
    function GetPlotFigure: Integer;
    function GetPlusCap: Boolean;
    function GetPolarMesh: Boolean;
    function GetReducedMesh: Boolean;
    function GetRetinaScale: single;
    function GetRGBColorMix: Integer;
    function GetRightPulling: Boolean;
    function GetRingColor(j: Integer): TAlphaColor;
    function GetRingContourWidth: Integer;
    function GetRingWidth: Integer;
    function GetSample: Integer;
    function GetScene: Integer;
    function GetShowColorPanel: Boolean;
    function GetShowCurrentBand: Boolean;
    function GetSideCapVisible: Boolean;
    function GetSliceHeight: single;
    function GetSlicePulling: Boolean;
    function GetSlicePullingMode: Integer;
    function GetSolutionMode: Boolean;
    function GetStripColor: TAlphaColor;
    function GetTargetPulling: Boolean;
    function GetTransitBarLayout: Integer;
    function GetUprightMesh: Boolean;
    function GetViewParamValue(fp: TFederParam): single;
    function GetViewport: TViewport3D;
    function GetViewportSizeX: Integer;
    function GetVorzeichen: Boolean;
    function GetZeroPulling: Boolean;
    procedure InitFederText(ft: TFederText);
    procedure InitMappedReports;
    procedure InitTouch;
    procedure InitTouchbarHelpText;
    procedure LoadColorInfoOnly;
    procedure LoadModelInfo;
    procedure OnModulationColorChanged(Sender: TObject);
    procedure OnViewport3DChanged(Sender: TObject);
    procedure PrepareForExample;
    procedure SetBandWidthOption(const Value: TBandWidthOption);
    procedure SetBigmap(const Value: Boolean);
    procedure SetBitmap(const Value: Integer);
    procedure SetColor(const Value: Integer);
    procedure SetColorPanelColor(const Value: TAlphaColor);
    procedure SetColorScheme(const Value: Integer);
    procedure SetCurrentCoord(const Value: Integer);
    procedure SetCurrentLight(const Value: Integer);
    procedure SetCurrentRing(const Value: Integer);
    procedure SetDetailPulling(const Value: Boolean);
    procedure SetDim(const Value: Integer);
    procedure SetFigure(const Value: Integer);
    procedure SetFilterMesh(const Value: Boolean);
    procedure SetFlippedTexture(const Value: Boolean);
    procedure SetForceMode(const Value: Integer);
    procedure SetGleich(const Value: Boolean);
    procedure SetGraph(const Value: Integer);
    procedure SetHub(const Value: Integer);
    procedure SetInitDataOK(const Value: Boolean);
    procedure SetKeyBinding(const Value: Integer);
    procedure SetLevel(const Value: Integer);
    procedure SetLimitPulling(const Value: Boolean);
    procedure SetMenubarLayout(const Value: Integer);
    procedure SetMeshChanged(const Value: Boolean);
    procedure SetMeshSize(const Value: Integer);
    procedure SetMinusCap(const Value: Boolean);
    procedure SetMoveMode(const Value: Boolean);
    procedure SetOnMemoDraw(const Value: TNotifyEvent);
    procedure SetOpacity(const Value: Boolean);
    procedure SetOpenMesh(const Value: Boolean);
    procedure SetOrbitMode(const Value: Boolean);
    procedure SetParam(const Value: Integer);
    procedure SetPixelCount(const Value: Integer);
    procedure SetPlot(const Value: Integer);
    procedure SetPlotFigure(const Value: Integer);
    procedure SetPlusCap(const Value: Boolean);
    procedure SetPolarMesh(const Value: Boolean);
    procedure SetReducedMesh(const Value: Boolean);
    procedure SetReduceMode(const Value: Integer);
    procedure SetRGBColorMix(const Value: Integer);
    procedure SetRightPulling(const Value: Boolean);
    procedure SetRingColor(j: Integer; const c: TAlphaColor);
    procedure SetRingWidth(const Value: Integer);
    procedure SetSample(const Value: Integer);
    procedure SetScene(const Value: Integer);
    procedure SetSelectedColor(const Value: Integer);
    procedure SetShowColorPanel(const Value: Boolean);
    procedure SetShowColorSwat(const Value: Boolean);
    procedure SetShowCurrentBand(const Value: Boolean);
    procedure SetSideCapVisible(const Value: Boolean);
    procedure SetSlicePulling(const Value: Boolean);
    procedure SetSlicePullingMode(const Value: Integer);
    procedure SetSolidPartVisible(const Value: Boolean);
    procedure SetSolutionMode(const Value: Boolean);
    procedure SetTargetPulling(const Value: Boolean);
    procedure SetTouch(const Value: Integer);
    procedure SetTransitBarLayout(const Value: Integer);
    procedure SetUpdateReason(const Value: TUpdateReason);
    procedure SetUprightMesh(const Value: Boolean);
    procedure SetViewParamValue(fp: TFederParam; const Value: single);
    procedure SetViewportSizeX(const Value: Integer);
    procedure SetVorzeichen(const Value: Boolean);
    procedure SetWantIdleMove(const Value: Boolean);
    procedure SetWheelFrequency(const Value: Integer);
    procedure SetZeroPulling(const Value: Boolean);
    procedure TrackbarUpdate(Sender: TObject);
    procedure TrackBar_CheckValue(const AValue: single);
  public
    ActionGroupList: TActionGroupList;
    ActionHandler: TActionHelper;
    ActionItemList: TActionItemList;
    ActionMapPhone: TActionMap;
    ActionMapTablet: TActionMap;
    ActionMapTransit: TActionMap;
    ActionTest: TActionTest;
    BambuPartition: TBambuPartition;
    BitmapCache: TBitmapCache;
    BitmapImprinter: TBitmapImprinter;
    BitmapIndex: Integer;
    ColorIndex: Integer;
    ColorStrip: TColorStrip;
    CounterCheckState: Integer;
    CounterDrawing2D: Integer;
    CounterDrawing3D: Integer;
    CounterInitData: Integer;
    CounterTextUpdate: Integer;
    CurrentReportAction: TFederAction;
    DefaultFederData: TFederData;
    EulerAngle: TEulerAngle;
    ExportCoords: TExportCoords;
    ExporterOBJ: TExporterOBJ;
    FederBinding: TFederBinding;
    FederColor: TFederColor;
    FederData: TFederData;
    FederFrame3D: TFederFrame3D;
    FederKeyboard1: TFederKeyboard01;
    Outer: TFederShell1;
    Inner: TFederShell1;
    SolidPart: TSolidPart;
    FederModel: TFederModel;
    FederPalette: TFederPalette;
    FederReport: TFederReport;
    FederScene: TFederSceneOne;
    FederText1: TFederTouch;
    FederText2: TFederTouchPhone;
    FederTexture: TFederTexture;
    FigureIndex: Integer;
    FKoordChanging: Boolean;
    FlashClearingNeeded: Boolean;
    FormatManager: TFormatManager;
    FParamChanging: Boolean;
    GraphIndex: Integer;
    GraphUpdatingNeeded: Boolean;
    InitDataMillies: Integer;
    IsReady: Boolean;
    IsUp: Boolean;
    Logger: TMemoLogger;
    ModelUpdate: TGridUpdate;
    ParamIndex: Integer;
    ParamManager: TParamManager;
    PlayRequested: Boolean;
    PlotIndex: Integer;
    Receiving: Boolean;
    ReportLock: Boolean;
    Resetting: Boolean;
    RingBuilder: TRingBuilder;
    SampleManager: TSampleManager;
    SceneIndex: Integer;
    StateCheckingNeeded: Boolean;
    StopWatch: TStopWatch;
    TextIndex: Integer;
    TextUpdatingNeeded: Boolean;
    Trackbar_Max: single;
    Trackbar_Min: single;
    Trackbar_Value: single;
    Trackbar_ValueOld: single;
    UpdatingData: Boolean;
    UseFixedBuffer: Boolean;
    ViewFromTop: Boolean;
    vp: TMeshParams;
    Want2D: Boolean;
    Want3D: Boolean;
    WantAnimation: Boolean;
    WantCanvasClear: Boolean;
    WantDiff: Boolean;
    WantDiffOnce: Boolean;
    WantEulerTest: Boolean;
    WantPosZ12: Boolean;
    WantTimedParams: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure AddMeshesToScene(ModelParent: TFmxObject);
    procedure ApplyButtonColor(fa: Integer);
    procedure ApplyPaletteColor;
    procedure BeginSpecialInit;
    procedure BigmapChanged(NewValue: Boolean);
    procedure BitmapChanged(NewItemIndex: Integer);
    procedure BlackText;
    procedure BlindRing(Value: Integer);
    procedure BlindRingAbsolute(Value: Integer);
    procedure BubbleUpAction(fa: TFederAction);
    procedure ChangeRingIndex(Value: Integer);
    procedure CheckStateNeeded;
    procedure ClearFlashNeeded;
    procedure CloseBitmap;
    procedure CollectShortcuts(fa: Integer; ML: TStrings);
    procedure ColorChanged(NewItemIndex: Integer);
    procedure CopyBitmap3D;
    procedure CopyCode;
    procedure CopyDatoToBitmap(Bitmap: TBitmap);
    procedure CopyDiffBin;
    procedure CopyDiffBinTest;
    procedure CopyDiffCode;
    procedure CopyImprintedBitmap;
    procedure CopyImprintedBitmapTest;
    procedure CopyScreenshot;
    procedure CopyShortcutReport;
    procedure CopySource(Value: Integer);
    procedure CopyTextureBitmap;
    procedure CopyTextureBitmapText;
    procedure CopyToBitmap(bmp: TBitmap; ARect: TRect);
    procedure CreateMainModel;
    procedure CycleBitmapE;
    procedure CycleBitmapM;
    procedure CycleBitmapOne;
    procedure CycleBitmapP;
    procedure CycleColorMixM;
    procedure CycleColorMixP;
    procedure CycleColorSchemeM;
    procedure CycleColorSchemeP;
    procedure CycleDBM;
    procedure CycleDBP;
    procedure CycleDrawFigureM;
    procedure CycleDrawFigureP;
    function CycleFigureM: Integer;
    function CycleFigureP: Integer;
    function CycleGraphM: Integer;
    function CycleGraphP: Integer;
    procedure CycleHelpM;
    procedure CycleHelpP;
    procedure CycleMX(n: Integer);
    function CyclePlotM: Integer;
    function CyclePlotP: Integer;
    procedure CycleRing(Value: Integer);
    function CycleText: string;
    procedure CycleTextureNormM;
    procedure CycleTextureNormP;
    procedure CycleToolSet(i: Integer);
    procedure DensityChanged(NewValue: Integer);
    procedure DestroyFedergraph;
    procedure DestroyMainModel;
    procedure DimChanged(NewValue: Integer);
    procedure DoBigWheel(Delta: single);
    procedure DoEulerSync;
    procedure DoEulerTest;
    procedure DoMM(fmk: TFederMessageKind; X, Y: single);
    procedure DoMMRemote(fmk: TFederMessageKind; X, Y: single);
    procedure DoMouseWheel(Shift: TShiftState; WheelDelta: Integer);
    procedure DoRandom(ID: Integer);
    procedure DoRandomBambu1;
    procedure DoRandomBambu2;
    procedure DoRasterWheel(Delta: single);
    procedure DoReset;
    procedure DoResetPosition;
    procedure DoResetPositionAndRotation;
    procedure DoResetRotation;
    procedure DoResetZoom;
    procedure DoSmallWheel(Delta: single);
    procedure DoTouchbarBottom(Delta: single);
    procedure DoTouchbarLeft(Delta: single);
    procedure DoTouchbarRight(Delta: single);
    procedure DoTouchbarTop(Delta: single);
    procedure DownloadCompleted(ML: TStrings);
    procedure DoZoom(const Delta: single);
    procedure DoZoomTimed(const Value: single);
    procedure DropTargetDropped(fn: string);
    procedure EndSpecialInit;
    procedure Example00;
    procedure Example01;
    procedure Example02;
    procedure ExportMtl;
    procedure ExportObj;
    function FederPaletteHandleTouchBtnClick(Btn: TTouchBtn): Boolean;
    procedure FigureChanged(NewItemIndex: Integer);
    procedure FilterMeshChanged(NewValue: Boolean);
    procedure FlippedTextureChanged(NewValue: Boolean);
    procedure FrameVisibilityChanged;
    procedure FuzzyMeshChanged(NewValue: Boolean);
    function GetChecked(fa: TFederAction): Boolean;
    function GetKeyboard: TFederKeyboard;
    function GetLoading: Boolean;
    function GetMeshDataDisplayText: string;
    function GetMoveModeDisplayText: string;
    function GetReport(Value: TReportPage): string;
    function GetReportPage: TReportPage;
    procedure GetRingInfoReport(ASL: TStrings);
    function GetStatusText: string;
    procedure GleichChanged(NewValue: Boolean);
    procedure GotoColorScheme(Value: Integer);
    procedure GotoHelpHome;
    procedure GotoHub(hub: Integer);
    procedure GotoSample(s: Integer);
    procedure GotoSampleHS(h, s: Integer);
    procedure GotoSampleLHS(l, h, s: Integer);
    procedure GotoScene(h: Integer);
    procedure GraphChanged(NewItemIndex: Integer);
    procedure GraphUpdateNeeded;
    procedure GrayText;
    procedure HandleAction(fa: TFederAction; CanBubble: Boolean = True);
    procedure HandleMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure HideImage;
    procedure Init;
    procedure InitData(Sender: TObject);
    procedure InitData2D;
    procedure InitDefaultRingWidth(Value: Integer);
    procedure InitFederGraph;
    procedure InitFederModel;
    procedure InitMainModel;
    procedure InitRaster;
    procedure InitRepo(Value: Integer);
    procedure InitSample;
    procedure InitSample1(fd: TFederData);
    procedure InitSpecial;
    procedure InitText;
    procedure InitTrackbar;
    procedure InitTrackbarQuick;
    procedure InitUI(fd: TFederData);
    procedure InitUIQuick(fd: TFederData);
    procedure InvertedMeshChanged(NewValue: Boolean);
    function IsTouchBtnEnabled(Btn: TTouchBtn): Boolean;
    procedure LoadAction;
    procedure LoadAnimScript(AnimData: TStrings);
    procedure LoadExample(Value: Integer);
    procedure LoadFromFederData;
    procedure LoadHub(prev: Boolean);
    procedure LoadRotation(fd: TFederData);
    procedure LoadSample(prev: Boolean);
    procedure MapColorToLayer;
    procedure MarkForUpdate(Value: TUpdateReason);
    procedure MinusCapChanged(NewValue: Boolean);
    procedure ModifyTrackbar(NewValue: single);
    procedure OnChangeParam(Sender: TObject);
    procedure OpacityChanged(NewValue: Boolean);
    procedure OpenMeshChanged(NewValue: Boolean);
    procedure OptionChanged(fmk: TFederMessageKind; NewValue: Boolean);
    procedure ParamChanged(NewItemIndex: Integer);
    procedure ParamValueChanged(NewValue: single);
    procedure PasteSample;
    procedure PickRing(X, Y: single);
    procedure PlotChanged(NewItemIndex: Integer);
    procedure PlusCapChanged(NewValue: Boolean);
    procedure PlusOne;
    procedure PlusTen;
    procedure PolarMeshChanged(NewValue: Boolean);
    procedure ProcessAnimLine(fmk: TFederMessageKind; var V: string);
    procedure RandomBitmapBlack;
    procedure RandomBitmapWhite;
    procedure ReadSample(ML: TStrings);
    procedure ReadSampleDiff(ML: TStrings);
    procedure ReducedMeshChanged(NewValue: Boolean);
    procedure Reset;
    procedure ResetRequested;
    procedure RingIndexChanged;
    procedure RingIndexUpdated;
    procedure RollStatusText;
    procedure RunBinPixelTest;
    procedure SampleChanged(NewSampleIndex: Integer);
    procedure SaveAction;
    procedure SaveColorInfoBin(ML: TStrings; AFormat: Integer);
    procedure SaveColorInfoCode(ML: TStrings; AFormat: Integer);
    procedure SaveRotation(fd: TFederData);
    procedure SaveStatus(ML: TStrings);
    procedure SceneChanged(NewItemIndex: Integer);
    procedure SetLoading(const Value: Boolean);
    procedure ShowInfo;
    procedure SolutionModeChanged(NewValue: Boolean);
    procedure SpecialDoOnMouseUp(X, Y: single);
    procedure SwapBundle;
    procedure TakeCapValueSnapShot;
    procedure TestBitmapPaint;
    procedure TextUpdateNeeded;
    procedure ToggleBottom;
    procedure ToggleCanvasClear(Value: Integer);
    procedure ToggleColorPanel;
    procedure ToggleContourPixel;
    procedure ToggleCoordMode(Value: Integer);
    procedure ToggleDiff(Value: Integer);
    procedure ToggleFlippedTexture;
    procedure ToggleLabelBatch(Value: Integer);
    procedure ToggleLightMode(Value: Integer);
    procedure ToggleLimitPulling;
    procedure ToggleLinearForce;
    procedure ToggleLux(Value: Integer);
    procedure ToggleLux1(Value: Integer);
    procedure ToggleLux2(Value: Integer);
    procedure ToggleLux3(Value: Integer);
    procedure ToggleLuxN(N: Integer; Value: Integer);
    procedure ToggleMirroredBottom;
    procedure ToggleProbe;
    procedure ToggleRightPulling;
    procedure ToggleRowHeight;
    procedure ToggleShirtColor;
    procedure ToggleShirtFarbe;
    procedure ToggleSideCaps;
    procedure ToggleSingleSide;
    procedure ToggleShowEdges;
    procedure ToggleSolidFlip;
    procedure ToggleSpecialY;
    procedure ToggleSlicePulling(AMode: Integer);
    procedure ToggleTargetPulling;
    procedure ToggleUniqueMode(Value: Integer);
    procedure ToggleUniqueVertices;
    procedure ToggleZeroPulling;
    procedure TrackBar_SetValue(const AValue: single);
    procedure TurnPage;
    procedure UpdateBitmap;
    procedure UpdateChart;
    procedure UpdateColorScheme(Value: Integer);
    procedure UpdateCurrentRing(TexCoordY: single);
    procedure UpdateData;
    procedure UpdateEyeSize(NewEyeSize: TSizeName);
    procedure UpdateFederTextData(var TD: TFederTextData);
    procedure UpdateFederTextDataPhone(var TD: TFederTextDataPhone);
    procedure UpdateFederTextDataQuick(var TD: TFederTextDataQuick);
    procedure UpdateFigureSize(NewFigureSize: TSizeName);
    procedure UpdateMesh;
    procedure UpdatePrintColors(ASelectedColors: TPrintColorSet);
    procedure UpdateReport;
    procedure UpdateRingColor(AColor: TAlphaColor); overload;
    procedure UpdateRingColor(ARing: Integer; AColor: TAlphaColor); overload;
    procedure UpdateRingColor3(AColor: TAlphaColor);
    procedure UpdateRingMapping(NewMapID: Integer);
    procedure UpdateRings;
    procedure UpdateSelectedColor(const Value: TAlphaColor);
    procedure UpdateShirtColor(Value: Boolean);
    procedure UpdateShirtFarbe(Value: Boolean);
    procedure UpdateText;
    procedure UpdateTouch;
    procedure UpdateTrackbar;
    procedure UpdateViewParamValue;
    procedure UpdateVP;
    procedure UpdateXY(mk: TFederMessageKind; Value: Integer);
    procedure UprightMeshChanged(NewValue: Boolean);
    procedure Viewpoint3;
    procedure ViewpointA;
    procedure ViewpointS;
    procedure ViewpointT;
    procedure VorzeichenChanged(NewValue: Boolean);
    procedure WhiteText;
    procedure WriteActionConst;
    procedure WriteActionNames;
    procedure WriteAllSampleDiff(ML: TStrings);
    procedure WriteCode(ML: TStrings);
    procedure WriteDiffBin(ML: TStrings);
    procedure WriteDiffBinTest(ML: TStrings);
    procedure WriteDiffCode(ML: TStrings);
    procedure WriteDiffPixelTest(ML: TStrings);
    procedure WriteSampleDiff(ML: TStrings);
    procedure WriteStatus(ML: TStrings);
    procedure WriteTestMemoLines(ML: TStrings; Count: Integer);
    procedure WriteVersion1Diff(ML: TStrings);
    procedure WriteVersion1Txt(ML: TStrings);
    property BandWidthOption: TBandWidthOption read FBandWidthOption write SetBandWidthOption;
    property Bigmap: Boolean read GetBigmap write SetBigmap;
    property Bitmap: Integer read GetBitmap write SetBitmap;
    property BitmapBuilder: TBitmapBuilder02 read GetBitmapBuilder;
    property CanPick: Boolean read GetCanPick;
    property CapValue: single read GetCapValue;
    property Color: Integer read GetColor write SetColor;
    property ColorPanelColor: TAlphaColor read GetColorPanelColor write SetColorPanelColor;
    property ColorScheme: Integer read GetColorScheme write SetColorScheme;
    property CoordMode: Boolean read GetCoordMode;
    property CurrentCoord: Integer read FCurrentCoord write SetCurrentCoord;
    property CurrentLight: Integer read FCurrentLight write SetCurrentLight;
    property CurrentParam: TFederParam read GetCurrentParam;
    property CurrentReportPage: TReportPage read GetReportPage;
    property CurrentRing: Integer read FCurrentRing write SetCurrentRing;
    property DetailPulling: Boolean read GetDetailPulling write SetDetailPulling;
    property Dim: Integer read GetDim write SetDim;
    property ExampleID: Integer read FExampleID;
    property FederFrame: TFederFrameBase read GetFederFrame;
    property FederMesh: TFederShell1 read Outer;
    property FederText: TFederTouchBase read GetFederText;
    property Figure: Integer read GetFigure write SetFigure;
    property FigureSize: TSizeName read GetFigureSize;
    property FilterMesh: Boolean read GetFilterMesh write SetFilterMesh;
    property FlippedTexture: Boolean read GetFlippedTexture write SetFlippedTexture;
    property ForceMode: Integer read GetForceMode write SetForceMode;
    property Frame2DMouseDown: Boolean read GetFrame2DMouseDown;
    property Frame3D: TFederFrame3D read GetFrame3D;
    property Gleich: Boolean read GetGleich write SetGleich;
    property Graph: Integer read GetGraph write SetGraph;
    property HasShirtColor: Boolean read FHasShirtColor write FHasShirtColor;
    property HasShirtFarbe: Boolean read FHasShirtFarbe write FHasShirtFarbe;
    property Hub: Integer read GetHub write SetHub;
    property InitDataOK: Boolean read GetInitDataOK write SetInitDataOK;
    property IsDesktop: Boolean read GetIsDesktop;
    property IsInputClient: Boolean read GetIsInputClient;
    property IsLandscape: Boolean read GetIsLandscape;
    property IsMobile: Boolean read FIsMobile write FIsMobile;
    property IsPhone: Boolean read GetIsPhone;
    property IsPortrait: Boolean read GetIsPortrait;
    property IsRetina: Boolean read GetIsRetina write FIsRetina;
    property KeyBinding: Integer read FKeyBinding write SetKeyBinding;
    property Keyboard: TFederKeyboard read GetKeyboard;
    property Layer: Integer read FLayer write FLayer;
    property Level: Integer read GetLevel write SetLevel;
    property LightMode: Boolean read GetLightMode;
    property LimitPulling: Boolean read GetLimitPulling write SetLimitPulling;
    property Loading: Boolean read GetLoading write SetLoading;
    property LoopFaktor: single read GetLoopFaktor;
    property MaterialSource: TMaterialSource read GetMaterialSource;
    property MenubarLayout: Integer read GetMenubarLayout write SetMenubarLayout;
    property MeshBuilder: TFederMeshBuilder read GetMeshBuilder;
    property MeshChanged: Boolean write SetMeshChanged;
    property MeshSize: Integer read GetMeshSize write SetMeshSize;
    property MinusCap: Boolean read GetMinusCap write SetMinusCap;
    property MoveMode: Boolean read GetMoveMode write SetMoveMode;
    property MoveModeText: string read GetMoveModeText;
    property Opacity: Boolean read GetOpacity write SetOpacity;
    property OpenMesh: Boolean read GetOpenMesh write SetOpenMesh;
    property OrbitMode: Boolean read GetOrbitMode write SetOrbitMode;
    property PaletteMode: Boolean read GetPaletteMode;
    property Param: Integer read GetParam write SetParam;
    property ParamValue: single read GetParamValue;
    property PickShift: Boolean read GetPickShift;
    property PixelCount: Integer read FPixelCount write SetPixelCount;
    property Plot: Integer read GetPlot write SetPlot;
    property PlotFigure: Integer read GetPlotFigure write SetPlotFigure;
    property PlusCap: Boolean read GetPlusCap write SetPlusCap;
    property PolarMesh: Boolean read GetPolarMesh write SetPolarMesh;
    property ReducedMesh: Boolean read GetReducedMesh write SetReducedMesh;
    property ReduceMode: Integer write SetReduceMode;
    property RetinaScale: single read GetRetinaScale;
    property RGBColorMix: Integer read GetRGBColorMix write SetRGBColorMix;
    property RightPulling: Boolean read GetRightPulling write SetRightPulling;
    property RingColor[j: Integer]: TAlphaColor read GetRingColor write SetRingColor;
    property RingContourWidth: Integer read GetRingContourWidth;
    property RingWidth: Integer read GetRingWidth write SetRingWidth;
    property Sample: Integer read GetSample write SetSample;
    property Scene: Integer read GetScene write SetScene;
    property SelectedColor: Integer read FSelectedColor write SetSelectedColor;
    property ShowColorPanel: Boolean read GetShowColorPanel write SetShowColorPanel;
    property ShowColorSwat: Boolean read FShowColorSwat write SetShowColorSwat;
    property ShowCurrentBand: Boolean read GetShowCurrentBand write SetShowCurrentBand;
    property SideCapVisible: Boolean read GetSideCapVisible write SetSideCapVisible;
    property SliceHeight: single read GetSliceHeight;
    property SlicePulling: Boolean read GetSlicePulling write SetSlicePulling;
    property SlicePullingMode: Integer read GetSlicePullingMode write SetSlicePullingMode;
    property SolidPartVisible: Boolean read FSolidPartVisible write SetSolidPartVisible;
    property SolutionMode: Boolean read GetSolutionMode write SetSolutionMode;
    property StripColor: TAlphaColor read GetStripColor;
    property TargetPulling: Boolean read GetTargetPulling write SetTargetPulling;
    property Touch: Integer read FTouch write SetTouch;
    property TransitBarLayout: Integer read GetTransitBarLayout write SetTransitBarLayout;
    property UpdateReason: TUpdateReason write SetUpdateReason;
    property UpdatingColorMix: Boolean read FUpdatingColorMix write FUpdatingColorMix;
    property UprightMesh: Boolean read GetUprightMesh write SetUprightMesh;
    property ViewParamValue[fp: TFederParam]: single read GetViewParamValue write SetViewParamValue;
    property Viewport: TViewport3D read GetViewport;
    property ViewportSizeX: Integer read GetViewportSizeX write SetViewportSizeX;
    property Vorzeichen: Boolean read GetVorzeichen write SetVorzeichen;
    property WantIdleMove: Boolean read FWantIdleMove write SetWantIdleMove;
    property WantStripColorText: Boolean read FWantStripColorText write FWantStripColorText;
    property WheelFrequency: Integer read FWheelFrequency write SetWheelFrequency;
    property ZeroPulling: Boolean read GetZeroPulling write SetZeroPulling;
    property OnMemoDraw: TNotifyEvent read FOnMemoDraw write SetOnMemoDraw;
  end;

implementation

uses
  FrmMain,
  RiggVar.App.Main,
  RiggVar.Util.ActionSorter,
  RiggVar.FederModel.ActionMapTransit,
  RiggVar.FederModel.ActionMapTablet,
  RiggVar.FederModel.ActionMapPhone,
  RiggVar.FederModel.Data,
  RiggVar.FederModel.Report;

{ TMain0 }

constructor TMain0.Create;
begin
  Main := self;
  FSelectedColor := 1;
  FLayer := 1;
  FSolidPartVisible := False;

  FormatSettings.DecimalSeparator := '.';
  MainVar.AppTitle := Application.Title;

  FL := TStringList.Create;

  InitMappedReports;
  InitTouchbarHelpText;

  Logger := TMemoLogger.Create;
  Logger.Info('Log created: ' + DateTimeToStr(Now));

  StopWatch := TStopWatch.Create;

  CreateFedergraph;

  ActionGroupList := TActionGroupList.Create;
  ActionTest := TActionTest.Create;
  ActionItemList := TActionItemList.Create;
  ActionItemList.InitTestData(2);

  RingBuilder := TRingBuilder.Create;

  BambuPartition := TBambuPartition.Create;
  BambuPartition.BuildActionItemList;
  ExporterOBJ := TExporterOBJ.Create;
end;

destructor TMain0.Destroy;
begin
  MainVar.AppIsClosing := True;
  ModelUpdate.ViewEnabled := False;

  DestroyFedergraph;

  ActionItemList.Free;
  BambuPartition.Free;
  RingBuilder.Free;

  StopWatch.Free;
  Logger.Free;
  FL.Free;

  ActionGroupList.Free;
  ActionTest.Free;
  MappedReports.Free;
  ExporterOBJ.Free;
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
    3: c := 1;
    4: c := 2;
    5: c := 3;
    else c := 1;
  end;
  if c > 0 then
  begin
    FSelectedColor := c;
    cla := FederText.FindCornerBtn(TFederTouchBase.ClickedID).Color;
    UpdateSelectedColor(cla);
    FederText1.SwatColor := cla;
    FederModel.PlusCap := True;
    TextUpdateNeeded;
    BubbleUpAction(faNoop);
    RingIndexUpdated;
  end;
end;

procedure TMain0.ApplyPaletteColor;
var
  j: Integer;
  cla: TAlphaColor;
begin
  j := CurrentRing;
  cla := FederPalette.PaletteColor;
  if (j >= 1) and (j <= StripConst.StripCount) then
  begin
    UpdateRingColor(cla);
    UpdateSelectedColor(cla);
    FederText1.SwatColor := cla;
  end;
end;

procedure TMain0.BeginSpecialInit;
begin
  FederModel.Active := False;
end;

procedure TMain0.BigmapChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederModel.Bigmap := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.BitmapChanged(NewItemIndex: Integer);
begin
  if not Resetting then
  begin
    if FederModel <> nil then
    begin
      if NewItemIndex = -1 then
      begin
        FederData.TextureLock := False;
        FederScene.ForceBitmap(-2);
      end
      else
      begin
        FederData.TextureLock := False;
        FederScene.Bitmap := NewItemIndex + 1;
        FederData.LockedTexture := FederScene.Bitmap;
        UpdateChart;
      end;
    end;
  end;
end;

procedure TMain0.BlackText;
begin
  MainVar.ColorScheme.BlackText;
  FederText.UpdateColorScheme;
end;

procedure TMain0.BlindRing(Value: Integer);
begin
  BitmapBuilder.BlindColors(Value);
  Bitmap := Bitmap;
end;

procedure TMain0.BlindRingAbsolute(Value: Integer);
begin
  BitmapBuilder.BlindRings(Value);
  Bitmap := Bitmap;
end;

procedure TMain0.BubbleUpAction(fa: TFederAction);
begin
  if IsUp then
    FormMain.HandleAction(fa);
end;

procedure TMain0.ChangeRingIndex(Value: Integer);
var
  a: Boolean;
  b: Boolean;
  c: Boolean;
begin
  a := (Value >= 1) and (Value <= StripConst.StripCount);
  if a then
    FederModel.ParamBandSelected := Value;

  b := Value <> FCurrentRing;
  c := FCurrentRing <> (Round(FederModel.ParamBandSelected) div 10);
  if b or c then
    RingIndexChanged;
end;

procedure TMain0.CheckStateNeeded;
begin
  StateCheckingNeeded := True;
end;

procedure TMain0.ClearFlashNeeded;
begin
  FlashClearingNeeded := True;
end;

procedure TMain0.CloseBitmap;
begin
  FederScene.CloseTexture;
  BitmapChanged(0);
  FederData.TextureLock := False;
end;

procedure TMain0.CollectShortcuts(fa: Integer; ML: TStrings);
begin
  Keyboard.GetShortcuts(fa, ML);
{$ifdef WantFederText}
  ActionMapTransit.CollectOne(fa, ML);
  ActionMapTablet.CollectOne(fa, ML);
  ActionMapPhone.CollectOne(fa, ML);
{$endif}
//  FederMenu.CollectOne(fa, ML);
end;

procedure TMain0.ColorChanged(NewItemIndex: Integer);
begin
  if not Resetting then
  begin
    if (NewItemIndex >= 0) and (NewItemIndex <= 6) then
    begin
      FederScene.ForceBitmap(FederScene.Bitmap);
      Frame3D.ColorIndex := NewItemIndex;
      Frame3D.GotoColor;
      FederData.Color := Frame3D.ColorIndex;
      UpdateChart;
    end;
  end;
end;

procedure TMain0.CopyBitmap3D;
var
  bmp: TBitmap;
  r: TRect;
  rs: single;
begin
  rs := RetinaScale;
  if IsRetina then
    r := Rect(0, 0, Round(Viewport.Width * rs), Round(Viewport.Height * rs))
  else
  r := Rect(0, 0, Round(Viewport.Width), Round(Viewport.Height));
  bmp := TBitmap.Create(r.Width, r.Height);
  CopyToBitmap(bmp, r);
  BitmapCache.UpdateBitmap(bmp);
  bmp.Free;
end;

procedure TMain0.CopyCode;
begin
  FL.Clear;
  WriteCode(FL);
  CopyFL;
end;

procedure TMain0.CopyDatoToBitmap(Bitmap: TBitmap);
begin
  UpdateData;
  FL.Clear;
  FederData.SaveDiffBin(DefaultFederData, FL);
  BitmapImprinter.SaveToBitmap(Bitmap, FL);
  FL.Clear;
end;

procedure TMain0.CopyDiffBin;
begin
  FL.Clear;
  WriteDiffBin(FL);
  CopyFL;
end;

procedure TMain0.CopyDiffBinTest;
begin
  FL.Clear;
  WriteDiffBinTest(FL);
  CopyFL;
end;

procedure TMain0.CopyDiffCode;
begin
  FL.Clear;
  WriteDiffCode(FL);
  CopyFL;
end;

procedure TMain0.CopyFL;
var
  cbs: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(cbs)) then
  begin
    cbs.SetClipboard(FL.Text);
    FL.Clear;
  end;
end;

procedure TMain0.CopyImprintedBitmap;
var
  bmp: TBitmap;
  r: TRect;
  rs: single;
begin
  rs := RetinaScale;
  if IsRetina then
    r := Rect(0, 0, Round(Viewport.Width * rs), Round(Viewport.Height * rs))
  else
    r := Rect(0, 0, Round(Viewport.Width), Round(Viewport.Height));
  bmp := TBitmap.Create(r.Width, r.Height);
  CopyToBitmap(bmp, r);
  CopyDatoToBitmap(bmp);
  BitmapCache.UpdateBitmap(bmp);
  bmp.Free;
end;

procedure TMain0.CopyImprintedBitmapTest;
var
  bmp: TBitmap;
begin
  UpdateData;

  bmp := TBitmap.Create(40, 40);

  FL.Clear;
  FederData.SaveDiffBin(DefaultFederData, FL);
  BitmapImprinter.SaveToBitmap(bmp, FL);
  FL.Clear;

  BitmapCache.UpdateBitmap(bmp);
  bmp.Free;
end;

procedure TMain0.CopyScreenshot;
var
  bmp: TBitmap;
begin
  bmp := FormMain.MakeScreenshot;
  BitmapCache.UpdateBitmap(bmp);
  bmp.Free;
end;

procedure TMain0.CopyShortcutReport;
begin
  FL.Clear;
  ActionHandler.GetShortcutReport(FL);
  CopyFL;
end;

procedure TMain0.CopySource(Value: Integer);
begin
  FL.Clear;
  FederModel.EQ.SourceFormat := Value;
  FederModel.EQ.InitMemo(FL);
  CopyFL;
end;

procedure TMain0.CopyTextureBitmap;
begin
  BitmapCache.UpdateBitmap(FederScene.BMP);
end;

procedure TMain0.CopyTextureBitmapText;
begin
  FL.Text := FederScene.TextureBitmapText;
  if FL.Count  < 2 then
    FL.Text := 'available only after using random colors once';
  CopyFL;
end;

procedure TMain0.CopyToBitmap(bmp: TBitmap; ARect: TRect);
begin
  Viewport.Context.CopyToBitmap(bmp, ARect);
end;

procedure TMain0.CreateFedergraph;
begin
  ActionMapTransit := TActionMapTransit.Create;
  ActionMapTablet := TActionMapTablet.Create;
  ActionMapPhone := TActionMapPhone.Create;

  FWheelFrequency := 1;
  FWantStripColorText := True;
  FDisplay := Display3D;

  Want2D := False;
  Want3D := True;
  WantAnimation := False;
  WantCanvasClear := True;
  WantTimedParams := True;
  WantEulerTest := False;

  InitRaster;

  ColorStrip := TColorStrip.Create;

  FederKeyboard1 := TFederKeyboard01.Create;

  FederData := TFederData3.Create;
  FederBinding := TFederBinding.Create;
  SampleManager := TSampleManager.Create;
  DefaultFederData := TFederData.Create;
  EulerAngle := TEulerAngle.Create;

  CreateMainModel;

  FormatManager := TFormatManager.Create;

  FederReport := TFederReport1.Create;
  FTouch := faTouchDesk;
  TTouchBtn.WantHint := True;
  FederText1 := TFederTouch.Create(nil);
  FederText1.Name := 'Tablet';
  FederText2 := TFederTouchPhone.Create(nil);
  FederText2.Name := 'Phone';
  FederPalette := TFederPalette.Create;

  ActionHandler := TActionHelper.Create;
  ActionHandler.CheckForDuplicates(FL);

  ModelUpdate := TGridUpdate.Create;
  ModelUpdate.OnUpdateView := TrackbarUpdate;

  DefaultFederData.InitDefault;

  FederColor := TFederColor.Create;

  BitmapCache := TBitmapCache.Create;
  BitmapImprinter := TBitmapImprinter.Create;
end;

procedure TMain0.CreateMainModel;
begin
  FederModel := TFederModel.Create(TFederModelEQ.Create);
  vp := TMeshParams.Create(FederModel.EQ);
  ParamManager := TParamManager.Create;
  FederTexture := TFederTexture.Create;
  FederScene := TFederSceneOne.Create;
  FederFrame3D := TFederFrame3D.Create;

  Outer := TFederShell1.Create(FormMain);
  Outer.MeshParams := vp;

  Inner := TFederShell1.Create(FormMain);
  Inner.MeshParams := vp;
  Inner.FederMeshBuilder.FlatMesh := True;
  Inner.FederMeshBuilder.IsBottom := True;

  FederMesh.InitGraph;
  Inner.InitGraph;

  SolidPart  := TSolidPart.Create(FormMain);
  SolidPart.Outer := Outer;
  SolidPart.Inner := Inner;
  SolidPart.Init;
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

procedure TMain0.CycleColorMixM;
var
  i: Integer;
begin
  i := BitmapBuilder.ColorMix;
  Dec(i);
  if (i < 0) then
    i := 5;
  if i > 5 then
    i := 0;
  RGBColorMix := i;
end;

procedure TMain0.CycleColorMixP;
var
  i: Integer;
begin
  i := BitmapBuilder.ColorMix;
  Inc(i);
  if (i < 0) then
    i := 5;
  if i > 5 then
    i := 0;
  RGBColorMix := i;
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

procedure TMain0.CycleDBM;
var
  i: Integer;
begin
  i := Level;
  Dec(i);
  if (i < 0) then
    i := SampleManager.LevelCount-1;
  if i > SampleManager.LevelCount-1 then
    i := 0;
  Level := i;
end;

procedure TMain0.CycleDBP;
var
  i: Integer;
begin
  i := Level;
  Inc(i);
  if (i < 0) then
    i := SampleManager.LevelCount-1;
  if i > SampleManager.LevelCount-1 then
    i := 0;
  Level := i;
end;

procedure TMain0.CycleDrawFigureM;
begin
  FederModel.DrawFigure := FederModel.DrawFigure - 1;
end;

procedure TMain0.CycleDrawFigureP;
begin
  FederModel.DrawFigure := FederModel.DrawFigure + 1;
end;

function TMain0.CycleFigureM: Integer;
var
  i: Integer;
begin
  { one based, do not wrap }
  i := FederModel.Figure;
  Inc(i);
  if (i < 1) then
    i := 1;
  if i > MainConst.FigureCount then
    i := MainConst.FigureCount;
  result := i;
end;

function TMain0.CycleFigureP: Integer;
var
  i: Integer;
begin
  { one based, do not wrap }
  i := FederModel.Figure;
  Dec(i);
  if (i < 1) then
    i := 1;
  if i > MainConst.FigureCount then
    i := MainConst.FigureCount;
  result := i;
end;

function TMain0.CycleGraphM: Integer;
var
  i: Integer;
begin
  { one based, do not wrap }
  i := FederModel.Graph;
  Dec(i);
  if (i < 1) then
    i := 1;
  if i > MainConst.GraphCount then
    i := MainConst.GraphCount;
  result := i;
end;

function TMain0.CycleGraphP: Integer;
var
  i: Integer;
begin
  { one based, do not wrap }
  i := FederModel.Graph;
  Inc(i);
  if (i < 1) then
    i := 1;
  if i > MainConst.GraphCount then
    i := MainConst.GraphCount;
  result := i;
end;

procedure TMain0.CycleHelpM;
begin
  FederBinding.CycleHelpMinus;
end;

procedure TMain0.CycleHelpP;
begin
  FederBinding.CycleHelpPlus;
end;

procedure TMain0.CycleMX(n: Integer);
var
  m: Integer;
begin
  m := 0;
  case n of
    1: m := FederModel.EQ.m1;
    2: m := FederModel.EQ.m2;
    3: m := FederModel.EQ.m3;
    4: m := FederModel.EQ.m4;
  end;
  Inc(m);
  if m > 2 then
    m := 0;
  case n of
    1: FederModel.EQ.m1 := m;
    2: FederModel.EQ.m2 := m;
    3: FederModel.EQ.m3 := m;
    4: FederModel.EQ.m4 := m;
  end;
  FederModel.ForceMode := 3;
end;

function TMain0.CyclePlotM: Integer;
var
  i: Integer;
begin
  i := FederModel.Plot;
  Dec(i);
  if (i < 0) then
    i := MainConst.PlotCount;
  if i > MainConst.PlotCount then
    i := 0;
  result := i;
end;

function TMain0.CyclePlotP: Integer;
var
  i: Integer;
begin
  i := FederModel.Plot;
  Inc(i);
  if (i < 0) then
    i := MainConst.PlotCount;
  if i > MainConst.PlotCount then
    i := 0;
  result := i;
end;

procedure TMain0.CycleRing(Value: Integer);
begin
  BitmapBuilder.RotateColors(Value);
  Bitmap := Bitmap;
end;

function TMain0.CycleText: string;
var
  imin, imax: Integer;
begin
  imin := 1;
  imax := 6;
  Inc(TextIndex);
  if (TextIndex < imin) then
    TextIndex := imin;
  if TextIndex > imax then
    TextIndex := imin;
  case TextIndex of
    1: result := FederModel.ModelStatus;
    2: result := FederBinding.LowerKeyInfo;
    3: result := FederBinding.UpperKeyInfo;
    4: result := FederBinding.SpecialKeyInfo;
    5: result := FederBinding.MeshKeyInfo;
    6: result := FederModel.EquationText;
  end;
end;

procedure TMain0.CycleTextureNormM;
var
  i: Integer;
begin
  i := FederModel.TextureNorm;
  Dec(i);
  if (i < 0) then
    i := 2;
  if i > 2 then
    i := 0;
  FederModel.TextureNorm := i;
end;

procedure TMain0.CycleTextureNormP;
var
  i: Integer;
begin
  i := FederModel.TextureNorm;
  Inc(i);
  if (i < 0) then
    i := 2;
  if i > 2 then
    i := 0;
  FederModel.TextureNorm := i;
end;

procedure TMain0.CycleToolSet(i: Integer);
begin
  FederText.UpdateToolSet(i);
  TextUpdateNeeded;
end;

procedure TMain0.DensityChanged(NewValue: Integer);
begin
  FederModel.MeshSize := NewValue;
  UpdateChart;
end;

procedure TMain0.DestroyFedergraph;
begin
  ActionHandler.Free;
  FederKeyboard1.Free;

  SampleManager.Free;

  FederColor.Free;

  FormatManager.Free;
  FederReport.Free;
  FederText1.Free;
  FederText2.Free;

  ModelUpdate.Free;

  DestroyMainModel;

  FederBinding.Free;
  FederData.Free;
  DefaultFederData.Free;
  EulerAngle.Free;
  ColorStrip.Free;
  FederPalette.Free;
  BitmapImprinter.Free;
  BitmapCache.Free;

  ActionMapTransit.Free;
  ActionMapTablet.Free;
  ActionMapPhone.Free;
end;

procedure TMain0.DestroyMainModel;
begin
  FederScene.Free;
  FederModel.Free;
  ParamManager.Free;
  FederTexture.Free;
  FederFrame3D.Free;

  vp.Free;
end;

procedure TMain0.DimChanged(NewValue: Integer);
begin
  FederModel.Dim := NewValue;
  UpdateChart;
end;

procedure TMain0.DoBigWheel(Delta: single);
begin
  if CurrentParam = fpBandWidth then
    DoWheelForBandWidth(Delta)
  else if CurrentParam = fpPan then
    DoWheelForPanX(Delta)
  else
    DoBigWheelForNormal(Delta);
end;

procedure TMain0.DoBigWheelForNormal(Delta: single);
var
  pv: single;
begin
  pv := Trackbar_Value;
  if Delta > 0 then
    ModifyTrackbar(pv + 10 * MainVar.WheelFrequency)
  else
    ModifyTrackbar(pv - 10 * MainVar.WheelFrequency);
end;

procedure TMain0.DoEulerSync;
begin
  if IsInputClient then
  begin
    EulerAngle.Rotation := Frame3D.GetRotationInfo * -1;
    EulerAngle.Wrap;
  end
  else
  begin
    Application.ProcessMessages;
    if EulerAngle.HasValue then
       Frame3D.LoadEulerAngle(EulerAngle.Rotation);
    EulerAngle.Reset;
    GraphUpdateNeeded;
  end;
end;

procedure TMain0.DoEulerTest;
begin
  EulerAngle.Rotation := FederFrame3D.GetRotationInfo * -1;
  EulerAngle.Wrap;

  if EulerAngle.HasValue then
    FederFrame3D.LoadEulerAngle(EulerAngle.Rotation);
  EulerAngle.Reset;
end;

procedure TMain0.DoMM(fmk: TFederMessageKind; X, Y: single);
begin
  Frame3D.DoMM(fmk, X, Y);
end;

procedure TMain0.DoMMRemote(fmk: TFederMessageKind; X, Y: single);
begin
  Frame3D.DoMMRemote(fmk, X, Y);
end;

procedure TMain0.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer);
begin
  if FederModel.MeshSize > MainConst.DefaultMeshSize then
    FederModel.MeshSize := MainConst.DefaultMeshSize;

  if (ssCtrl in Shift) and (ssShift in Shift) then
  begin
    DoRasterWheel(WheelDelta);
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

procedure TMain0.DoRandom(ID: Integer);
begin
  ModelUpdate.ViewEnabled := False;
  FederScene.ResetDataRandom(ID);
  TextUpdateNeeded;
  GraphUpdateNeeded;
end;

procedure TMain0.DoRandomBambu1;
var
  cr: TPrintColorSet;
  i1, i2, i3, i4: Integer;
begin
  i1 := Random(Length(BasicColors));
  i2 := Random(Length(MatteColors));
  i3 := Random(ColorVar.BambuColorPool.Count);
  i4 := Random(ColorVar.WebColorPool.Count);

  cr.Color1 := BasicColors[i1].Value;
  cr.Color2 := MatteColors[i2].Value;
  cr.Color3 := ColorVar.BambuColorPool.ColorMap[i3].Value;
  cr.Color4 := ColorVar.WebColorPool.ColorMap[i4].Value;

  UpdatePrintColors(cr);
end;

procedure TMain0.DoRandomBambu2;
var
  cr: TPrintColorSet;
  i1, i2, i3, i4: Integer;
begin
  i1 := Random(BambuPartition.DarkColors.Count);
  i2 := Random(BambuPartition.SkinColors.Count);
  i3 := Random(BambuPartition.RingColors.Count);
  i4 := Random(BambuPartition.RingColors.Count);

  cr.Color1 := BambuPartition.DarkColors[i1].Color;
  cr.Color2 := BambuPartition.SkinColors[i2].Color;
  cr.Color3 := BambuPartition.RingColors[i3].Color;
  cr.Color4 := BambuPartition.RingColors[i4].Color;

  UpdatePrintColors(cr);
end;

procedure TMain0.DoRasterWheel(Delta: single);
begin
  if Delta > 0 then
    ParamManager.CycleParamPlus
  else
    ParamManager.CycleParamMinus
end;

procedure TMain0.DoReset;
begin
  Frame3D.Reset;
  UpdateViewParamValue;
end;

procedure TMain0.DoResetPosition;
begin
  Frame3D.ResetPosition;
end;

procedure TMain0.DoResetPositionAndRotation;
begin
  Frame3D.ResetPositionAndRotation;
  Frame3D.CameraDummyRotationAngle.X := 180;
  Frame3D.UpdateRotation;
end;

procedure TMain0.DoResetRotation;
begin
  Frame3D.ResetRotation;
  Frame3D.CameraDummyRotationAngle.X := 180;
  Frame3D.UpdateRotation;
end;

procedure TMain0.DoResetZoom;
begin
  Frame3D.ResetZoom;
  UpdateViewParamValue;
end;

procedure TMain0.DoSmallWheel(Delta: single);
begin
  if CurrentParam = fpBandWidth then
    DoWheelForBandWidth(Delta)
  else if CurrentParam = fpPan then
    DoWheelForPanY(Delta)
  else
    DoSmallWheelForNormal(Delta);
end;

procedure TMain0.DoSmallWheelForNormal(Delta: single);
var
  pv: single;
begin
  if MainVar.WheelFrequency > 0.9 then
    pv := Round(Trackbar_Value)
  else
    pv := Trackbar_Value;

  if Delta > 0 then
    ModifyTrackbar(pv + MainVar.WheelFrequency)
  else
    ModifyTrackbar(pv - MainVar.WheelFrequency);
end;

procedure TMain0.DoTouchbarBottom(Delta: single);
begin
  DoZoom(-Delta / 20);
end;

procedure TMain0.DoTouchbarLeft(Delta: single);
begin
  DoBigWheel(Delta);
end;

procedure TMain0.DoTouchbarRight(Delta: single);
begin
  DoSmallWheel(Delta);
end;

procedure TMain0.DoTouchbarTop(Delta: single);
begin
  DoMM(fmkRZ, Delta, 0);
end;

procedure TMain0.DoWheelForBandWidth(Delta: single);
var
  d: single;
  w: Integer;
  CanChange: Boolean;
begin
  if Delta > 0 then
    d := 1
  else
    d := -1;

  w := Round(Trackbar_Value + d);

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
    Trackbar_Value := w;
  end;
end;

procedure TMain0.DoWheelForPanX(Delta: single);
begin
  if Frame3D.MoveMode then
    Frame3D.Camera00.Position.X := Frame3D.Camera00.Position.X - Delta * 0.002
  else
    Frame3D.Camera00.Position.X := Frame3D.Camera00.Position.X - Delta * 0.02;
end;

procedure TMain0.DoWheelForPanY(Delta: single);
begin
  if Frame3D.MoveMode then
    Frame3D.Camera00.Position.Y := Frame3D.Camera00.Position.Y - Delta * 0.002
  else
    Frame3D.Camera00.Position.Y := Frame3D.Camera00.Position.Y - Delta * 0.02;
end;

procedure TMain0.DownloadCompleted(ML: TStrings);
var
  i: Integer;
begin
  i := ML.Count;
  if i > 25 then
  begin
    FederData.Load(ML);
    LoadFromFederData;
  end;
end;

procedure TMain0.DoZoom(const Delta: single);
begin
  Frame3D.DoZoom(Delta);
//  UpdateViewParamValue; // done after OnIdle
end;

procedure TMain0.DoZoomTimed(const Value: single);
begin
  Frame3D.DoZoomTimed(Value);
//  UpdateViewParamValue; // done after OnIdle
end;

procedure TMain0.DropTargetDropped(fn: string);
var
  ext: string;
begin
  ext := ExtractFileExt(fn);
  if ext = '.txt' then
  begin
    FL.LoadFromFile(fn);
    ReadSample(FL);
    FL.Clear;
  end
  else
  begin
    if BitmapImprinter.CheckForData(fn) then
    begin
      CloseBitmap;
      FL.Clear;
      BitmapImprinter.LoadFromFile(fn, FL);
      ReadSample(FL);
      FL.Clear;
    end
    else if ColorScheme = 9 then
    begin
      FormMain.CheckerBitmap.LoadFromFile(fn);
      FormMain.CheckerImage.Bitmap := FormMain.CheckerBitmap;
      FormMain.CheckerImage.WrapMode := TImageWrapMode.Fit;
    end
    else
    begin
      FederScene.OpenTexture(fn);
      BitmapChanged(-1);
      FederData.TextureLock := True;
    end;
  end;
end;

procedure TMain0.EndSpecialInit;
begin
  Frame3D.LoadFromFederData(FederData);
  FederModel.LoadFromFederData(FederData);

  FederModel.Loading := True;
  try
    InitFederModel;
    FederScene.InitGraph(BitmapIndex);
    InitTrackbar;
  finally
    FederModel.Loading := False;
  end;

  FederModel.Active := True;
  FederModel.InitData;

  ClearFlashNeeded;
  TextUpdateNeeded;
end;

procedure TMain0.Example00;
begin
  FExampleID := 0;
  BitmapBuilder.UpdateReason := cuBitmap;
  Bitmap := 17;
end;

procedure TMain0.Example01;
begin
  LoadExample(1);
  FederFrame.LoadEulerAngle(TPoint3D.Create(190, -10, 0));
end;

procedure TMain0.Example02;
begin
  LoadExample(2);
end;

function TMain0.FederPaletteHandleTouchBtnClick(Btn: TTouchBtn): Boolean;
begin
  result := FederPalette.HandleTouchBtnClick(Btn);
end;

procedure TMain0.FigureChanged(NewItemIndex: Integer);
begin
  if not Resetting then
  begin
    if FederModel <> nil then
    begin
      FederModel.Figure := NewItemIndex + 1;
      UpdateChart;
    end;
  end;
end;

procedure TMain0.FilterMeshChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.FilterMesh := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.FlippedTextureChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.FlippedTexture := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.FrameVisibilityChanged;
begin
  FormMain.UpdateHintText(faNoop);
end;

procedure TMain0.FuzzyMeshChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.FuzzyMesh := NewValue;
    UpdateChart;
  end;
end;

function TMain0.GetBigmap: Boolean;
begin
  result := FederModel.Bigmap;
end;

function TMain0.GetBitmap: Integer;
begin
  result := FederScene.Bitmap;
end;

function TMain0.GetBitmapBuilder: TBitmapBuilder02;
begin
  result := FederTexture.BitmapBuilder;
end;

function TMain0.GetCanPick: Boolean;
begin
  result := True;
end;

function TMain0.GetCapValue: single;
begin
  result := FederModel.CapValue;
end;

function TMain0.GetChecked(fa: TFederAction): Boolean;
begin
   result := False;
  case fa of
    faNoop: ;
  end;
end;

function TMain0.GetColor: Integer;
begin
  result := Frame3D.ColorIndex;
end;

function TMain0.GetColorPanelColor: TAlphaColor;
begin
  result := FederText1.SwatColor;
end;

function TMain0.GetColorScheme: Integer;
begin
  result := MainVar.ColorScheme.Scheme;
end;

function TMain0.GetCoordMode: Boolean;
begin
  result := CurrentCoord > 0;
end;

function TMain0.GetCurrentParam: TFederParam;
begin
  result := ParamManager.CurrentParam;
end;

function TMain0.GetDetailPulling: Boolean;
begin
  result := MeshBuilder.WantDetailPulling;
end;

function TMain0.GetDim: Integer;
begin
  result := FederModel.Dim;
end;

function TMain0.GetFederFrame: TFederFrameBase;
begin
  result := FederFrame3D;
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

function TMain0.GetFigure: Integer;
begin
  result := FederModel.Figure;
end;

function TMain0.GetFigureSize: TSizeName;
begin
  result := RingBuilder.FigureSize;
end;

function TMain0.GetFilterMesh: Boolean;
begin
  result := FederScene.FilterMesh;
end;

function TMain0.GetFlippedTexture: Boolean;
begin
  result := FederScene.FlippedTexture;
end;

function TMain0.GetForceMode: Integer;
begin
  result := FederModel.ForceMode;
end;

function TMain0.GetFrame2DMouseDown: Boolean;
begin
  result := False;
end;

function TMain0.GetFrame3D: TFederFrame3D;
begin
  result := FederFrame3D;
end;

function TMain0.GetGleich: Boolean;
begin
  result := FederModel.WantGleich;
end;

function TMain0.GetGraph: Integer;
begin
  result := FederModel.Graph;
end;

function TMain0.GetHub: Integer;
begin
  result := SampleManager.Hub;
end;

function TMain0.GetInitDataOK: Boolean;
begin
  result := MainVar.InitDataOK;
end;

function TMain0.GetIsDesktop: Boolean;
begin
  result := not IsMobile;
end;

function TMain0.GetIsInputClient: Boolean;
begin
{$ifdef InputClient}
  result := True;
{$else}
  result := False;
{$endif}
end;

function TMain0.GetIsLandscape: Boolean;
begin
  result := FormMain.ClientWidth > FormMain.ClientHeight;
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

function TMain0.GetKeyboard: TFederKeyboard;
begin
  result := FederKeyboard1;
end;

function TMain0.GetLevel: Integer;
begin
  result := TFederData.DB;
end;

function TMain0.GetLightMode: Boolean;
begin
  result := CurrentLight > 0;
end;

function TMain0.GetLimitPulling: Boolean;
begin
  result := MeshBuilder.WantLimitPulling;
end;

function TMain0.GetLoading: Boolean;
begin
  result := FederModel.Loading;
end;

function TMain0.GetLoopFaktor: single;
begin
  result := FederModel._fp0 / MainVar.WheelFrequency;
end;

function TMain0.GetMaterialSource: TMaterialSource;
begin
  result := FederScene.MaterialSource;
end;

function TMain0.GetMenubarLayout: Integer;
begin
  if Assigned(FederText) then
    result := FederText.MenuBarLayout
  else
    result := 0;
end;

function TMain0.GetMeshBuilder: TFederMeshBuilder;
begin
  result := FederMesh.FederMeshBuilder;
end;

function TMain0.GetMeshDataDisplayText: string;
begin
  result := ' ~ ' + MeshBuilder.GetMeshDataName;
end;

function TMain0.GetMeshSize: Integer;
begin
  result := FederModel.MeshSize;
end;

function TMain0.GetMinusCap: Boolean;
begin
  result := FederModel.MinusCap;
end;

function TMain0.GetMoveMode: Boolean;
begin
  result := Frame3D.MoveMode;
end;

function TMain0.GetMoveModeDisplayText: string;
begin
  result := '';
  if MoveMode then
    result := ' ~ MoveMode';
end;

function TMain0.GetMoveModeText: string;
begin
  result := Frame3D.MoveModeText;
end;

function TMain0.GetOpacity: Boolean;
begin
  result := FederScene.IsOpaque;
end;

function TMain0.GetOpenMesh: Boolean;
begin
  result := FederScene.OpenMesh;
end;

function TMain0.GetOrbitMode: Boolean;
begin
  result := Frame3D.OrbitMode;
end;

function TMain0.GetPaletteMode: Boolean;
begin
  if FederPalette <> nil then
    result := FederPalette.PaletteMode
  else
    result := False;
end;

function TMain0.GetParam: Integer;
begin
  result := FederModel.Param;
end;

function TMain0.GetParamValue: single;
begin
  result := FederModel.ParamValue;
end;

function TMain0.GetPickShift: Boolean;
begin
  result := (ssShift in Frame3D.PickShift)
end;

function TMain0.GetPlot: Integer;
begin
  result := FederModel.Plot;
end;

function TMain0.GetPlotFigure: Integer;
begin
  result := FederModel.PlotFigure;
end;

function TMain0.GetPlusCap: Boolean;
begin
  result := FederModel.PlusCap;
end;

function TMain0.GetPolarMesh: Boolean;
begin
  result := FederScene.PolarMesh;
end;

function TMain0.GetReducedMesh: Boolean;
begin
  result := FederScene.ReducedMesh;
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
  if Viewport <> nil then
    result := Viewport.Scene.GetSceneScale
  else
    result := 1.0;
end;

function TMain0.GetRGBColorMix: Integer;
begin
  result := BitmapBuilder.ColorMix;
end;

function TMain0.GetRightPulling: Boolean;
begin
  result := MeshBuilder.WantRightPulling;
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
  BitmapBuilder.GetRingInfoReport(FigureSize, ASL);
end;

function TMain0.GetRingWidth: Integer;
begin
  result := BitmapBuilder.RingWidth[CurrentRing];
end;

function TMain0.GetSample: Integer;
begin
  result := SampleManager.Sample;
end;

function TMain0.GetScene: Integer;
begin
  result := FederModel.Scene;
end;

function TMain0.GetShowCurrentBand: Boolean;
begin
  if (FederTexture <> nil) and (FederTexture.BitmapBuilder <> nil) then
    result := FederTexture.BitmapBuilder.ShowCurrentBand
  else
    result := False;
end;

function TMain0.GetSideCapVisible: Boolean;
begin
  result := SolidPart.WantSideCaps;
end;

function TMain0.GetSliceHeight: single;
begin
  result := FederModel.SliceHeight;
end;

function TMain0.GetSlicePulling: Boolean;
begin
  result := MeshBuilder.WantSlicePulling;
end;

function TMain0.GetSlicePullingMode: Integer;
begin
  result := MeshBuilder.SlicePullingMode;
end;

function TMain0.GetSolutionMode: Boolean;
begin
  result := FederModel.SolutionMode;
end;

function TMain0.GetStatusText: string;
begin
  FL.Clear;
  UpdateData;
  FederData.SaveVirtual(FL);
  result := FL.Text;
end;

function TMain0.GetStripColor: TAlphaColor;
begin
  result := ColorStrip.StripColor;
end;

function TMain0.GetTargetPulling: Boolean;
begin
  result := MeshBuilder.WantTargetPulling;
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

function TMain0.GetUprightMesh: Boolean;
begin
  result := FederScene.UprightMesh;
end;

function TMain0.GetViewParamValue(fp: TFederParam): single;
begin
  result := 0.0;
  if Frame3D.InitOK then
  case fp of
    fprx: result := Frame3D.CameraDummyRotationAngle.X;
    fpry: result := Frame3D.CameraDummyRotationAngle.Y;
    fprz: result := Frame3D.CameraDummyRotationAngle.Z;

    fptx: result := Frame3D.Camera00.Position.X;
    fpty: result := Frame3D.Camera00.Position.Y;
    fpcz: result := Frame3D.Camera00.Position.Z;
    else
      result := 0.0;
  end;
end;

function TMain0.GetViewport: TViewport3D;
begin
  result := FormMain.Viewport;
end;

function TMain0.GetViewportSizeX: Integer;
begin
  result := FormMain.ViewportState;
end;

function TMain0.GetVorzeichen: Boolean;
begin
  result := FederModel.Vorzeichen;
end;

function TMain0.GetZeroPulling: Boolean;
begin
  result := MeshBuilder.WantZeroPulling;
end;

procedure TMain0.GleichChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederModel.WantGleich := NewValue;
    UpdateChart;
  end;
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

procedure TMain0.GotoHelpHome;
begin
  FederBinding.GoHome;
  BubbleUpAction(faShowMemo);
end;

procedure TMain0.GotoHub(hub: Integer);
begin
  Loading := True;
  try
    SampleManager.Hub := hub;
    ClearFlashNeeded;
    TextUpdateNeeded;
    SampleManager.LoadSample;
    LoadFromFederData;
  finally
    Loading := False;
  end;
end;

procedure TMain0.GotoSample(s: Integer);
begin
  Loading := True;
  try
    SampleManager.Sample := s;
    ClearFlashNeeded;
    TextUpdateNeeded;
    SampleManager.LoadSample;
    LoadFromFederData;
  finally
    Loading := False;
  end;
end;

procedure TMain0.GotoSampleHS(h, s: Integer);
begin
  SampleManager.Hub := h;
  GotoSample(s);
end;

procedure TMain0.GotoSampleLHS(l, h, s: Integer);
begin
  if (l > -1) and (l < SampleManager.LevelCount) then
  begin
    TFederData.DB := l;
    SampleManager.Hub := h;
    GotoSample(s);
  end;
end;

procedure TMain0.GotoScene(h: Integer);
begin
  if h > MainConst.SceneCount then
    h := 1;
  if h < 1 then
    h := MainConst.SceneCount;
  SceneChanged(h - 1);
end;

procedure TMain0.GraphChanged(NewItemIndex: Integer);
begin
  if not Resetting then
  begin
    if FederModel <> nil then
    begin
      FederModel.Graph := NewItemIndex + 1;
      UpdateChart;
    end;
  end;
end;

procedure TMain0.GraphUpdateNeeded;
begin
  GraphUpdatingNeeded := True;
end;

procedure TMain0.GrayText;
begin
  MainVar.ColorScheme.GrayText;
  FederText.UpdateColorScheme;
end;

procedure TMain0.HandleAction(fa: TFederAction; CanBubble: Boolean);
begin
  case fa of
    faNoop: ;
  end;

  if CanBubble then
    BubbleUpAction(fa);
end;

procedure TMain0.HandleMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
begin
  if IsUp then
    Frame3D.HandleMouseWheel(Sender, Shift, WheelDelta, Handled);
end;

procedure TMain0.HideImage;
begin
  if Assigned(FederColor) then
  begin
    if FederColor.Image.Visible then
    begin
      FederColor.Image.Visible := False;
      FederColor.Light.Color := claWhite;
    end
    else
    begin
      FederColor.Image.Visible := True;
    end;
  end;
end;

procedure TMain0.Init;
begin
  FederData.ResetUI;

  InitUIQuick(FederData); // sets BitmapIndex

  InitMainModel;

  Frame3D.InitOK := True;

  InitTrackbar;
  InitText;

  InitSample;

  FCurrentRing := 21;
  MenubarLayout := 0;
end;

procedure TMain0.InitData2D;
begin
  { keep even if empty }
end;

procedure TMain0.InitDefaultRingWidth(Value: Integer);
begin
  BitmapBuilder.InitDefaultRingWidth(Value);
end;

procedure TMain0.InitFederGraph;
begin
  FederScene.InitGraph(BitmapIndex);
end;

procedure TMain0.InitFederModel;
begin
  FederModel.IsCombi := False;

  FederModel.Scene := SceneIndex;
  FederModel.Plot := PlotIndex;
  FederModel.Figure := FigureIndex;
  FederModel.Param := ParamIndex;

  FederModel.ParamValueQuick := FederModel.ParamValue;

  if FederScene.QuickMesh then
  begin
    FederModel.GraphQuick := GraphIndex;
    FederModel.MeshSize := MainConst.DefaultMeshSize
  end
  else
    FederModel.Graph := GraphIndex;
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

procedure TMain0.InitMainModel;
begin
  InitFederModel; // calls properties from Index values
  FederScene.Init;
  InitFederGraph; // uses BitmapIndex, must be set by now
  FederModel.OnInitData := InitData;
  FederModel.Active := True;
  ParamManager.OnChangeParam := OnChangeParam;

  Frame3D.InitWithViewport(Viewport);
  Frame3D.OnViewportChanged := OnViewport3DChanged;
  Frame3D.ColorChanged := OnModulationColorChanged;
end;

procedure TMain0.InitMappedReports;
var
  cl: TList<TReportPage>;
begin
  MappedReports := TList<TReportPage>.Create;
  cl := MappedReports;
  cl.AddRange([
    rpRingInfo,
    rpColorMapping,
    rpSelectedColors,
    rpAppInfo,
    rpModelStatus,
    rpViewStatus,
    rpLockStatus,
    rpLightInfo,
    rpRotationInfo,
    rpMatrixInfo,
    rpColorInfo1,
    rpColorInfo2,
    rpMeshDataInfo
   ]);
end;

procedure TMain0.InitRaster;
begin
  MainVar.ClientWidth := FormMain.ClientWidth;
  MainVar.ClientHeight := FormMain.ClientHeight;
end;

procedure TMain0.InitRepo(Value: Integer);
begin
  Level := 0;
  SampleManager.Hub := 0;
  SampleManager.Sample := 1;
  SampleManager.SampleBundle.Init(Value);
  GotoSampleLHS(Level, SampleManager.Hub, SampleManager.Sample);
  TextUpdateNeeded;
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

procedure TMain0.InitSample;
begin
  GotoSample(1);

  FederScene.ShowKugel := False;
  FederScene.ShowGrid := False;
  FederScene.QuickMesh := True;
end;

procedure TMain0.InitSpecial;
begin
  BeginSpecialInit;

  with FederData do
  begin
    InitDefault;
    x1 := -100.458946838995;
    x2 := 100.458946838995;
    y1 := -58;
    y2 := -58;
    y3 := 116;
    l1 := 100;
    l2 := 100;
    l3 := 100;
    l4 := 100;
    Bigmap := True;
    Range := 60;
    Graph := 4;
    Plot := 4;
    Figure := 2;
    Bitmap := 17;
    AngleX := -162.65;
    AngleY := -8.21;
    AngleZ := 1.59;
    PosX := -1.80;
    PosY := -2.80;
    PosZ := 40.85;
    T1 := 0;
    T2 := 180;
    IV := 25.00;
    JV := 250.00;
    ParamBahnStrokeWidth1 := 1;
    ParamBahnStrokeWidth2 := 2;
    ShowLC2 := False;
    NullpunktX := 400;
    NullpunktY := 600;
    PaintboxZoom := 1.0;
  end;

  FederModel.DrawFigure := 5;
  PolarMesh := True;

  EndSpecialInit;

  FederText.FrameVisible := True;
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

procedure TMain0.InitTrackbar;
begin
  Trackbar_Min := -1000;
  Trackbar_Max := 1000;

  if IsUp then
  begin
    ParamChanged(FederModel.Param - 1);
  end;
end;

procedure TMain0.InitTrackbarQuick;
begin
  { called from procedure TMainModel.LoadModelInfo; }
  FParamChanging := True;
  FederData.LockedParam := FederModel.Param;
  Trackbar_Min := -1000;
  Trackbar_Max := 1000;
  Trackbar_Value := FederModel.ParamValue;
  FParamChanging := False;
end;

procedure TMain0.InitUI(fd: TFederData);
begin
  Resetting := True;
  try
    SceneIndex := fd.Scene;
    GraphIndex := fd.Graph;
    PlotIndex := fd.Plot;
    FigureIndex := fd.Figure;
    BitmapIndex := fd.Bitmap;
    ParamIndex := fd.Param;
    ColorIndex := fd.Color;

    SceneChanged(SceneIndex - 1);
    GraphChanged(GraphIndex - 1);
    PlotChanged(PlotIndex - 1);
    FigureChanged(FigureIndex -1);
    BitmapChanged(BitmapIndex - 1);
    ParamChanged(ParamIndex - 1);
    ColorChanged(ColorIndex - 1);

    MinusCapChanged(fd.MinusCap);
    PlusCapChanged(fd.PlusCap);
    OpacityChanged(fd.Opacity);
    BigmapChanged(fd.Bigmap);
  finally
    Resetting := False;
  end;
end;

procedure TMain0.InitUIQuick(fd: TFederData);
begin
  SceneIndex := fd.Scene;
  GraphIndex := fd.Graph;
  PlotIndex := fd.Plot;
  FigureIndex := fd.Figure;
  BitmapIndex := fd.Bitmap;
  ParamIndex := fd.Param;
  ColorIndex := fd.Color;
end;

procedure TMain0.InvertedMeshChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.InvertedMesh := NewValue;
    UpdateChart;
  end;
end;

function TMain0.IsTouchBtnEnabled(Btn: TTouchBtn): Boolean;
begin
  result := IsPhone or not FederPalette.HandleTouchBtnClick(Btn);
end;

procedure TMain0.LoadAction;
begin
  SampleManager.SampleBundle.LoadFromFile;
end;

procedure TMain0.LoadAnimScript(AnimData: TStrings);
begin
  { keep even if empty }
end;

procedure TMain0.LoadColorInfoOnly;
var
  fd: TFederData;
begin
  fd := FederData;

  FederTexture.LoadFromFederData(fd);

  if (fd.Bitmap = 25) and fd.ColorStrip.HasColor then
  begin
    ColorStrip.Assign(fd.ColorStrip);
    FederScene.EnsureBitmapStrip(fd.ColorStrip);
  end
  else
  begin
    FederTexture.BitmapBuilder.UpdateReason := TUpdateReason.cuBandsPasted;
    FederTexture.BitmapBuilder.Changed := True;
  end;
end;

procedure TMain0.LoadExample(Value: Integer);
begin
  FExampleID := Value;
  if ParamManager.CurrentParam = fpBandWidth then
  begin
    FederModel.ParamBandWidth := 15;
  end;
  PrepareForExample;
  RingBuilder.InitFromExample(Value);
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

procedure TMain0.LoadHub(prev: Boolean);
begin
  if prev then
    GotoHub(SampleManager.Hub - 1)
  else
    GotoHub(SampleManager.Hub + 1);
end;

procedure TMain0.LoadModelInfo;
var
  fd: TFederData;
begin
  MainVar.WantUniqueVertices := False;
  MainVar.UniqueMode := 2;

  FederModel.Active := False;

  fd := FederData;

  FederModel.LoadFromFederData(fd);
  FederFrame3D.LoadFromFederData(fd);
  FederScene.LoadFromFederData(fd);
  FederTexture.LoadFromFederData(fd);

  FederModel.Loading := True;
  try
    InitUIQuick(fd);
    InitFederModel;
    InitTrackbarQuick;

    if (fd.Bitmap = 25) and fd.ColorStrip.HasColor then
    begin
      ColorStrip.Assign(fd.ColorStrip);
      FederScene.EnsureBitmapStrip(fd.ColorStrip);
    end
    else if (fd.Bitmap = -1) then
      { do nothing }
    else
      FederScene.EnsureBitmap;

    if IsReady then
      FederScene.UpdateProbe;
    ColorScheme := fd.ColorScheme3D;

  finally
    FederModel.Loading := False;
  end;

  FederModel.Active := True;
  FederModel.InitData;

  ClearFlashNeeded;
  TextUpdateNeeded;
  CheckStateNeeded;
end;

procedure TMain0.LoadRotation(fd: TFederData);
begin
  Frame3D.LoadRotation(fd);
end;

procedure TMain0.LoadSample(prev: Boolean);
begin
  Loading := True;
  try
    if FCurrentCoord <> 0 then
      FCurrentCoord := 0;
    if FCurrentLight <> 0 then
      FCurrentLight := 0;
    if prev then
      SampleManager.PrevSample
    else
      SampleManager.NextSample;
    SampleManager.LoadSample;
    LoadFromFederData;
  finally
    Loading := False;
  end;
  ParamManager.ResetCycle;
end;

procedure TMain0.MapColorToLayer;
begin
  RingBuilder.MapColorToLayer(FLayer, FSelectedColor);
end;

procedure TMain0.MarkForUpdate(Value: TUpdateReason);
begin
  BitmapBuilder.MarkForUpdate(Value);
end;

procedure TMain0.MinusCapChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederModel.MinusCap := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.ModifyTrackbar(NewValue: single);
begin
  TrackBar_CheckValue(NewValue);

  if ParamManager.CurrentParam = fpcz then
  begin
    if (NewValue < MainVar.Transform3D.GlobalZoomMin) or
       (NewValue > MainVar.Transform3D.GlobalZoomMax) then
      Exit;
  end;

  if Assigned(Frame3D)
    and (Frame3D.WantIdleMove = False)
    and (FederModel.MeshSize <= 128)
    and (
       (CurrentParam = fpt1) or
       (CurrentParam = fpt2)
     )
   then
  begin
    Trackbar_Value := NewValue;
    TrackBar_SetValue(Trackbar_Value);
  end
  else if WantTimedParams then
  begin
    Trackbar_Value := NewValue;
    ModelUpdate.ViewEnabled := True;
    if Assigned(FederText) then
      FederText.UpdateTextQuick;
  end
  else
  begin
    Trackbar_Value := NewValue;
    ModelUpdate.ViewEnabled := False;
    Trackbar_SetValue(Trackbar_Value);
    if Assigned(FederText) then
      FederText.UpdateTextQuick;
  end;
end;

procedure TMain0.OnChangeParam(Sender: TObject);
var
  idx: Integer;
begin
  if not ParamManager.IsPseudoParam then
  begin
    idx := ParamManager.CurrentIndex;
    ParamChanged(idx);
  end;
end;

procedure TMain0.OnModulationColorChanged(Sender: TObject);
begin
  FederScene.ModulationColor := Frame3D.Color;
end;

procedure TMain0.OnViewport3DChanged(Sender: TObject);
begin
  ClearFlashNeeded;
  //TextUpdateNeeded;
end;

procedure TMain0.OpacityChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    if NewValue then
      FederScene.Opacity := 1.0
    else
      FederScene.Opacity := 0.5;
  end;
end;

procedure TMain0.OpenMeshChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.OpenMesh := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.OptionChanged(fmk: TFederMessageKind; NewValue: Boolean);
begin
  case fmk of
    fmkPlusCap: PlusCapChanged(NewValue);
    fmkMinusCap: MinusCapChanged(NewValue);
  end;
end;

procedure TMain0.ParamChanged(NewItemIndex: Integer);
begin
  FParamChanging := True;
  try
    if not Resetting then
    begin
      if NewItemIndex > -1 then
      begin
        if FederModel <> nil then
        begin
          FederModel.Param := NewItemIndex + 1;
          FederData.LockedParam := FederModel.Param;
          UpdateTrackbar;
          ClearFlashNeeded;
          TextUpdateNeeded;
        end;
      end;
    end;
  finally
    FParamChanging := False;
  end;
end;

procedure TMain0.ParamValueChanged(NewValue: single);
begin
  if (not MainVar.AppIsClosing) or Resetting then
  begin
    if FederModel <> nil then
    begin
      FederModel.ParamValue := NewValue;

      if not (Loading or FParamChanging or FKoordChanging) then
      begin
        Trackbar_Value := NewValue;
        UpdateChart;
      end
      else
      begin
        ClearFlashNeeded;
        TextUpdateNeeded;
      end;
    end;
  end;
end;

procedure TMain0.PasteSample;
var
  v: TValue;
  s: string;
  cbs: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(cbs)) then
  begin
    FL.Clear;
    try
      v := cbs.GetClipboard;
      if not v.IsEmpty then
      begin
        s := v.AsString;
        if (s <> '') and (Length(s) < 10000) then
        begin
          FL.Text := s;
          ReadSample(FL);
          FL.Clear;
        end
        else
        begin
          Logger.Error('there is no ''FederData'' string on the clipboard');
        end;
      end;
    except
      Logger.Error('no usable data on clipboard');
    end;
  end;
end;

procedure TMain0.PickRing(X, Y: single);
begin
  if FederMesh.Parent <> nil then
    FederMesh.PickRing(X, Y);
end;

procedure TMain0.PlotChanged(NewItemIndex: Integer);
begin
  if not Resetting then
  begin
    if FederModel <> nil then
    begin
      FederModel.Plot := NewItemIndex + 1;
      UpdateChart;
    end;
  end;
end;

procedure TMain0.PlusCapChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederModel.PlusCap := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.PlusOne;
begin
  DoMouseWheel([ssShift], 1);
end;

procedure TMain0.PlusTen;
begin
  DoMouseWheel([ssCtrl], 1);
end;

procedure TMain0.PolarMeshChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.PolarMesh := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.PrepareForExample;
var
  fm: TFederModel;
begin
  FederScene.ResetFBitmap;

  fm := Main.FederModel;

  fm.Active := False;

  fm.FT1 := 0;
  fm.FT2 := 180;
  fm.FT3 := 1;
  fm.FT4 := 5;

  if not FederScene.ReducedMesh then
    FederScene.ReducedMesh := True;
  fm.PlusCap := True;
  ZeroPulling := True;
  LimitPulling := True;

  fm.Active := True;

  BitmapBuilder.WantContour := False;
end;

procedure TMain0.ProcessAnimLine(fmk: TFederMessageKind; var V: string);
begin
  { keep even if empty }
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

procedure TMain0.ReadSampleDiff(ML: TStrings);
begin
  try
    FederData.InitDefault;
    FederData.Load(ML);
    LoadFromFederData;
    BubbleUpAction(faNoop);
  except
    ResetRequested;
  end;
end;

procedure TMain0.ReducedMeshChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.ReducedMesh := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.Reset;
begin
  FederModel.Active := False;

  Frame3D.Reset;
  FederModel.Reset;

  FederData.ResetUI;
  InitUI(FederData);

  InitFederModel;
  InitFederGraph;
  InitTrackbar;

  FederScene.ModulationColor := claWhite;
  FederModel.Active := True;
  FederModel.InitData;

  UpdateChart;
  ClearFlashNeeded;
  TextUpdateNeeded;
end;

procedure TMain0.ResetRequested;
begin
  Loading := True;
  try
    Reset;
  finally
    Loading := False;
  end;
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
  if CurrentParam = fpBandWidth then
  begin
    Trackbar_Value := Main.ParamValue;
    TextUpdateNeeded;
    BubbleUpAction(faNoop);
  end;
end;

procedure TMain0.RollStatusText;
begin
  if not FederText.EquationVisible then
    FederText.ToggleEquationText;
  ToggleLabelBatch(1);
end;

procedure TMain0.RunBinPixelTest;
begin
  FL.Clear;
  WriteDiffPixelTest(FL);
  CopyFL;
end;

procedure TMain0.SampleChanged(NewSampleIndex: Integer);
begin
  LoadSample(True);
end;

procedure TMain0.SaveAction;
begin
  UpdateData;
  SampleManager.SampleHub.UpdateSample(FederData);
end;

procedure TMain0.SaveColorInfoBin(ML: TStrings; AFormat: Integer);
begin
  if WantStripColorText then
  begin
    case AFormat of
      1: BitmapBuilder.WriteColorInfoBin(ML);
      4: BitmapBuilder.SaveBin(ML);
      else
        BitmapBuilder.SaveBin(ML);
    end;
  end;
end;

procedure TMain0.SaveColorInfoCode(ML: TStrings; AFormat: Integer);
begin
  if WantStripColorText then
  begin
    case AFormat of
      1: BitmapBuilder.WriteColorInfoCode(ML);
      4: BitmapBuilder.SaveCode(ML);
      6: BitmapBuilder.SaveCode6(ML);
    else
      BitmapBuilder.SaveCode(ML);
    end;
  end;
end;

procedure TMain0.SaveRotation(fd: TFederData);
begin
  Frame3D.SaveRotation(fd);
end;

procedure TMain0.SaveStatus(ML: TStrings);
begin
  UpdateData;
  FederData.SaveVirtual(ML);
end;

procedure TMain0.SceneChanged(NewItemIndex: Integer);
begin
  if not Resetting then
  begin
    if FederModel <> nil then
    begin
      FederModel.Active := False;

      SceneIndex := NewItemIndex + 1;
      GraphIndex := FederModel.Graph;
      PlotIndex := FederModel.Plot;
      FigureIndex := FederModel.Figure;
      BitmapIndex := FederScene.Bitmap;
      ColorIndex := FederData.Color;
      ParamIndex := FederModel.Param;

      InitFederModel;
      InitFederGraph;

      FederModel.Active := True;
      FederModel.InitData;
      UpdateChart;
    end;
  end;
end;

procedure TMain0.SetBandWidthOption(const Value: TBandWidthOption);
begin
  FBandWidthOption := Value;
end;

procedure TMain0.SetBigmap(const Value: Boolean);
begin
  BigmapChanged(Value);
end;

procedure TMain0.SetBitmap(const Value: Integer);
begin
  BitmapChanged(Value-1);
end;

procedure TMain0.SetColor(const Value: Integer);
begin
  ColorChanged(Value);
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

procedure TMain0.SetCurrentCoord(const Value: Integer);
begin
  FCurrentCoord := Value;
end;

procedure TMain0.SetCurrentLight(const Value: Integer);
begin
  FCurrentLight := Value;
end;

procedure TMain0.SetCurrentRing(const Value: Integer);
begin
  FCurrentRing := Value;
  if (ActionHandler.ReportPage = rpColorInfo1)
  or (ActionHandler.ReportPage = rpColorInfo2)
  then
    TextUpdateNeeded;
end;

procedure TMain0.SetDetailPulling(const Value: Boolean);
begin
  MeshBuilder.WantDetailPulling := Value;
  UpdateMesh;
end;

procedure TMain0.SetDim(const Value: Integer);
begin
  FederModel.Dim := Value;
end;

procedure TMain0.SetFigure(const Value: Integer);
begin
  FigureChanged(Value-1);
end;

procedure TMain0.SetFilterMesh(const Value: Boolean);
begin
  FilterMeshChanged(Value);
end;

procedure TMain0.SetFlippedTexture(const Value: Boolean);
begin
  FlippedTextureChanged(Value);
end;

procedure TMain0.SetForceMode(const Value: Integer);
begin
  FederModel.ForceMode := Value;
end;

procedure TMain0.SetGleich(const Value: Boolean);
begin
  GleichChanged(Value);
end;

procedure TMain0.SetGraph(const Value: Integer);
begin
  GraphChanged(Value-1);
end;

procedure TMain0.SetHub(const Value: Integer);
begin
  SampleManager.Hub := Value;
end;

procedure TMain0.SetInitDataOK(const Value: Boolean);
begin
  MainVar.InitDataOK := Value;
end;

procedure TMain0.SetKeyBinding(const Value: Integer);
begin
  FKeyBinding := Value;
end;

procedure TMain0.SetLevel(const Value: Integer);
begin
  if (Value > -1) and (Value < SampleManager.LevelCount) then
    TFederData.DB := Value
  else
    TFederData.DB := 0;
  GotoSample(SampleManager.Sample);
end;

procedure TMain0.SetLimitPulling(const Value: Boolean);
begin
  MeshBuilder.WantLimitPulling := Value;
  UpdateMesh;
end;

procedure TMain0.SetLoading(const Value: Boolean);
begin
  FederModel.Loading := Value;
end;

procedure TMain0.SetMenubarLayout(const Value: Integer);
begin
  if Assigned(FederText) then
  begin
    FederText.MenuBarLayout := Value;
    TActionMapTransit(ActionMapTransit).InitMenuCaptions(Value);
    FederText1.InitMenuBarActions(Value);
  end;
end;

procedure TMain0.SetMeshChanged(const Value: Boolean);
begin
  FederMesh.MeshChanged := Value;
end;

procedure TMain0.SetMeshSize(const Value: Integer);
begin
  DensityChanged(Value);
end;

procedure TMain0.SetMinusCap(const Value: Boolean);
begin
  MinusCapChanged(Value);
end;

procedure TMain0.SetMoveMode(const Value: Boolean);
begin
  Frame3D.MoveMode := Value;
end;

procedure TMain0.SetOnMemoDraw(const Value: TNotifyEvent);
begin
  FOnMemoDraw := Value;
end;

procedure TMain0.SetOpacity(const Value: Boolean);
begin
  OpacityChanged(Value);
end;

procedure TMain0.SetOpenMesh(const Value: Boolean);
begin
  OpenMeshChanged(Value);
end;

procedure TMain0.SetOrbitMode(const Value: Boolean);
begin
  Frame3D.OrbitMode := Value;
end;

procedure TMain0.SetParam(const Value: Integer);
begin
  ParamChanged(Value-1);
end;

procedure TMain0.SetPixelCount(const Value: Integer);
begin
  FPixelCount := Value;
  BitmapBuilder.PixelFaktor := Value;
end;

procedure TMain0.SetPlot(const Value: Integer);
begin
  PlotChanged(Value-1);
end;

procedure TMain0.SetPlotFigure(const Value: Integer);
begin
  FederModel.PlotFigure := Value;
end;

procedure TMain0.SetPlusCap(const Value: Boolean);
begin
  PlusCapChanged(Value);
end;

procedure TMain0.SetPolarMesh(const Value: Boolean);
begin
  PolarMeshChanged(Value);
end;

procedure TMain0.SetReducedMesh(const Value: Boolean);
begin
  ReducedMeshChanged(Value);
end;

procedure TMain0.SetReduceMode(const Value: Integer);
begin
  { see TMeshDataBase.Reduce; }
  if (Value >= 0) and (Value <= 3) then
  begin
    FederScene.ReduceMode := Value;
    FederModel.Refresh;
  end;
end;

procedure TMain0.SetRGBColorMix(const Value: Integer);
begin
  BitmapBuilder.ColorMix := Value;
  UpdatingColorMix := True;
  Bitmap := Bitmap;
  UpdatingColorMix := False;
end;

procedure TMain0.SetRightPulling(const Value: Boolean);
begin
  MeshBuilder.WantRightPulling := Value;
  UpdateMesh;
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

procedure TMain0.SetSample(const Value: Integer);
begin
  SampleManager.Sample := Value;
end;

procedure TMain0.SetScene(const Value: Integer);
begin
  SceneChanged(Value-1);
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
  FShowColorSwat := Value;
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
    UpdateRings;
  end;
end;

procedure TMain0.SetSlicePulling(const Value: Boolean);
begin
  MeshBuilder.WantSlicePulling := Value;

  { setting ReducedMesh below will trigger InitData and HasChanged }
  if Value then
  begin
    FederScene.ReduceMode := 3;
    FederScene.ReducedMesh := True;
  end
  else
  begin
    FederScene.ReduceMode := 1;
    FederScene.ReducedMesh := False;
  end;

  TextUpdateNeeded;
end;

procedure TMain0.SetSlicePullingMode(const Value: Integer);
begin
  MeshBuilder.SlicePullingMode := Value;
end;

procedure TMain0.SetSolutionMode(const Value: Boolean);
begin
  SolutionModeChanged(Value);
end;

procedure TMain0.SetTargetPulling(const Value: Boolean);
begin
  MeshBuilder.WantTargetPulling := Value;
  UpdateMesh;
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

procedure TMain0.SetUprightMesh(const Value: Boolean);
begin
  UprightMeshChanged(Value);
end;

procedure TMain0.SetViewParamValue(fp: TFederParam; const Value: single);
begin
  Frame3D.DoParamValueChange(fp, Value);
  FederModel.UpdateParamValue(Value);
end;

procedure TMain0.SetViewportSizeX(const Value: Integer);
begin
  FormMain.ViewportState := Value;
  MainVar.ColorScheme.Init(ColorScheme);
  FederText.UpdateColorScheme;
end;

procedure TMain0.SetVorzeichen(const Value: Boolean);
begin
  VorzeichenChanged(Value);
end;

procedure TMain0.SetWantIdleMove(const Value: Boolean);
begin
  FWantIdleMove := Value;
  Frame3D.WantIdleMove := Value;
end;

procedure TMain0.SetWheelFrequency(const Value: Integer);
begin
  FWheelFrequency := Value;
  case Value of
    1: MainVar.WheelFrequency := 1;
    2: MainVar.WheelFrequency := 0.5;
    3: MainVar.WheelFrequency := 0.2;
    4: MainVar.WheelFrequency := 0.1;
    5: MainVar.WheelFrequency := 0.01;
    6: MainVar.WheelFrequency := 0.001;
  end;
end;

procedure TMain0.SetZeroPulling(const Value: Boolean);
begin
  MeshBuilder.WantZeroPulling := Value;
  UpdateMesh;
end;

procedure TMain0.ShowInfo;
begin
  ActionHandler.ReportPage := rpAppInfo;
  TextUpdateNeeded;
  FHelpFlash := True;
end;

procedure TMain0.SolutionModeChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederModel.SolutionMode := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.SpecialDoOnMouseUp(X, Y: Single);
begin
  { keep even if empty }
end;

procedure TMain0.SwapBundle;
begin
  SampleManager.SwapBundle;
  GotoSampleLHS(0, 0, 1);
end;

procedure TMain0.TakeCapValueSnapShot;
begin
  BitmapBuilder.CapValueSnapShot := CapValue;
  RingBuilder.CapValueSnapShot := CapValue;
  TextUpdateNeeded;
end;

procedure TMain0.TestBitmapPaint;
var
  j: Integer;
begin
  j := CurrentRing;
  Inc(j);
  RingColor[j] := claRed;
  Bitmap := StripConst.RandomColorIndexW;
end;

procedure TMain0.TextUpdateNeeded;
begin
  TextUpdatingNeeded := True;
end;

procedure TMain0.ToggleCanvasClear(Value: Integer);
begin
  case Value of
    -1: WantCanvasClear := not WantCanvasClear;
    0: WantCanvasClear := False;
    1: WantCanvasClear := True;
    else
    begin
      WantCanvasClear := True;
    end;
  end;
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

procedure TMain0.ToggleCoordMode(Value: Integer);
begin
  case Value of
    1: ParamManager.ChangeParam(fpCoord1);
    2: ParamManager.ChangeParam(fpCoord2);
    3: ParamManager.ChangeParam(fpCoord3);
    else
      ParamManager.ChangeParam(fpCoord0);
  end;
  CurrentCoord := Value;
end;

procedure TMain0.ToggleDiff(Value: Integer);
begin
  case Value of
    0:
    begin
      WantDiff := False;
      WantDiffOnce := False;
    end;
    1:
    begin
      WantDiff := True;
      WantDiffOnce := False;
    end;
    else
    begin
      WantDiff := False;
      WantDiffOnce := True;
    end;
  end;
  FederModel.Refresh;
  WantDiffOnce := False;
  GraphUpdateNeeded;
end;

procedure TMain0.ToggleFlippedTexture;
begin
  FlippedTexture := not FlippedTexture;
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

procedure TMain0.ToggleLightMode(Value: Integer);
begin
  CurrentLight := Value;
end;

procedure TMain0.ToggleLimitPulling;
begin
  LimitPulling := not LimitPulling;
end;

procedure TMain0.ToggleLinearForce;
begin
  FederModel.LinearForce := not FederModel.LinearForce;
  FederModel.Refresh;
  GraphUpdateNeeded;
end;

procedure TMain0.ToggleLux(Value: Integer);
begin
  FederData.LuxLock := False;
  FederScene.ToggleLux(Value);
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

procedure TMain0.ToggleLux1(Value: Integer);
begin
  FederScene.ToggleLux1(Value);
end;

procedure TMain0.ToggleLux2(Value: Integer);
begin
  FederScene.ToggleLux2(Value);
end;

procedure TMain0.ToggleLux3(Value: Integer);
begin
  FederScene.ToggleLux3(Value);
end;

procedure TMain0.ToggleLuxN(N: Integer; Value: Integer);
begin
  FederScene.ToggleLuxN(N, Value);
end;

procedure TMain0.ToggleProbe;
begin
  FederScene.ToggleProbe;
end;

procedure TMain0.ToggleRightPulling;
begin
  RightPulling := not RightPulling;
end;

procedure TMain0.ToggleRowHeight;
begin
end;

procedure TMain0.ToggleShirtColor;
begin
  UpdateShirtColor(not HasShirtColor);
end;

procedure TMain0.ToggleShirtFarbe;
begin
  UpdateShirtFarbe(not HasShirtFarbe);
end;

procedure TMain0.ToggleShowEdges;
begin
  MainVar.ShowEdges := not MainVar.ShowEdges;
  GraphUpdateNeeded;
end;

procedure TMain0.ToggleSlicePulling(AMode: Integer);
begin
  if AMode <> SlicePullingMode then
  begin
    SlicePullingMode := AMode;
    SlicePulling := True;
  end
  else
  SlicePulling := not SlicePulling;
end;

procedure TMain0.ToggleTargetPulling;
begin
  TargetPulling := not TargetPulling;
end;

procedure TMain0.ToggleUniqueMode(Value: Integer);
begin
  MainVar.UniqueMode := Value;
  FederMesh.MeshParams.UniqueMode := MainVar.UniqueMode;
  FederModel.Refresh;
end;

procedure TMain0.ToggleUniqueVertices;
begin
  MainVar.WantUniqueVertices := not MainVar.WantUniqueVertices;
  FederMesh.MeshParams.WantUniqueVertices := MainVar.WantUniqueVertices;
  FederModel.Refresh;
end;

procedure TMain0.ToggleZeroPulling;
begin
  ZeroPulling := not ZeroPulling;
end;

procedure TMain0.TrackbarUpdate(Sender: TObject);
begin
  Trackbar_SetValue(Trackbar_Value);
end;

procedure TMain0.TrackBar_CheckValue(const AValue: single);
begin
  if (AValue <= Trackbar_Min) then
    Trackbar_Value := Trackbar_Min
  else if AValue >= TrackBar_Max then
    Trackbar_Value := Trackbar_Max
  else
    Trackbar_Value := AValue;
end;

procedure TMain0.TrackBar_SetValue(const AValue: single);
begin
  TrackBar_CheckValue(AValue);

  if (Trackbar_ValueOld <> Trackbar_Value) then
  begin
    Trackbar_ValueOld := Trackbar_Value;
    if IsUp then
    begin
      ParamValueChanged(Trackbar_Value);

      if not FederModel.Loading then
        GraphUpdateNeeded;
    end;
  end;
end;

procedure TMain0.TurnPage;
begin
  FederBinding.CycleHelpPlus;
end;

procedure TMain0.UpdateBitmap;
begin
  Bitmap := Bitmap;
end;

procedure TMain0.UpdateChart;
begin
  ClearFlashNeeded;
  TextUpdateNeeded;
  GraphUpdateNeeded;
  BubbleUpAction(faNoop);
end;

procedure TMain0.UpdateColorScheme(Value: Integer);
var
  i: Integer;
begin
  i := Value;
  if (Value < 1) then
    i := MainConst.ColorSchemeCount;
  if i > MainConst.ColorSchemeCount then
    i := Value;

  ColorScheme := i;
end;

procedure TMain0.UpdateCurrentRing(TexCoordY: single);
var
  r: Integer;
begin
  r := BitmapBuilder.FindPickedRing(TexCoordY);
  if (r > 0) and (r <= StripConst.StripCount) then
    CurrentRing := r;

  if FormMain.ColorPanel.Visible then
  begin
    FormMain.ColorPanel.Color := BitmapBuilder.RingColor[CurrentRing];
    FormMain.ColorPanelChanged := False;
  end;

  if FederText1.ColorSwat.Visible then
    FederText1.SwatColor := BitmapBuilder.RingColor[CurrentRing];

  if ShowCurrentBand then
    UpdateRings;

  if CurrentParam = fpBandSelected then
    Trackbar_Value := CurrentRing;

  TextUpdateNeeded;
  BubbleUpAction(faNoop);
end;

procedure TMain0.UpdateData;
begin
  FederModel.SaveToFederData(FederData);

  FederScene.SaveToFederData(FederData);
  UpdatingData := False;

  Frame3D.SaveToFederData(FederData);
end;

procedure TMain0.UpdateEyeSize(NewEyeSize: TSizeName);
begin
  RingBuilder.InitWithNewEyeSize(NewEyeSize);
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

  TD.SL00 := IntToStr(CurrentRing);
  TD.SR00 := IntToStr(FederModel.Scene);
  TD.ST00 := TActionMap.CurrentPageCaption;
{$ifndef IOS}
  TD.SB00 := ParamManager.CurrentCaption + ' = ' + FloatToStrF(Trackbar_Value, ff, 7, 2);
{$endif}

  TD.ParamText := ParamManager.CurrentCaption;
  TD.ValueText := FloatToStrF(FederModel.ParamValue, ff, 7, 2);
  TD.TempoText := FloatToStrF(Trackbar_Value, ff, 7, 2);

  TD.StatusLine := Format('%s (AR = %s, OY = %s, CV = %s)', [
    FederScene.MeshStatusText,
    FloatToStrF(FederModel.AbsoluteRange, ff, 7, 2),
    FloatToStrF(FederModel.OffsetY, ff, 7, 2),
    FloatToStrF(FederModel.CapValue, ff, 7, 2)
    ]);

  TD.OptionLine := FederModel.OptionText + GetMoveModeDisplayText;
  TD.RecorderLine := FederData.ComputedTitle;
  TD.EquationLine := FederModel.Equation.GetStatusLine;

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

  TD.SL00 := IntToStr(CurrentRing);
  TD.SR00 := ParamManager.CurrentCaption;
  TD.ST00 := ActionMapPhone.CurrentPageCaptionPhone;
  TD.SB00 := FloatToStrF(Trackbar_Value, ffGeneral, 7, 2);

  if FederText.ActionPage < 5 then
  begin
    TD.Line1 := 'Color 1 = ' + ColorVar.RggColorPool.ColorToString(RingBuilder.SelectedColors.Color1);
    TD.Line2 := 'Color 2 = ' + ColorVar.RggColorPool.ColorToString(RingBuilder.SelectedColors.Color2);
    TD.Line3 := 'Color 3 = ' + ColorVar.RggColorPool.ColorToString(RingBuilder.SelectedColors.Color3);

    TD.Line4 := '';
    TD.Line5 := '';
    TD.Line6 := '';
  end
  else
  begin
    TD.Line1 := Format('"%s"', [FederData.Title]);
    TD.Line2 := Format('%d-%d-%d', [Level, Hub, Sample]);
    TD.Line3 := TFederUtils.GetMessageKindLabel(fmkPlot) + ' ' + IntToStr(FederModel.Plot);

    TD.Line4 := FederModel.EQ.GetStatusLine;
    TD.Line5 := FederScene.MeshStatusText;
    TD.Line6 := FederModel.OptionText;
  end;
end;

procedure TMain0.UpdateFederTextDataQuick(var TD: TFederTextDataQuick);
var
  ff: TFloatFormat;
begin
  if MainVar.WheelFrequency = 1 then
    ff := ffGeneral
  else
    ff := ffFixed;

  TD.TempoText := FloatToStrF(Trackbar_Value, ff, 7, 2);
{$ifndef IOS}
  TD.SB00 := FloatToStrF(Trackbar_Value, ff, 7, 2);
{$endif}
  TD.RecorderLine := '';
end;

procedure TMain0.UpdateFigureSize(NewFigureSize: TSizeName);
begin
  RingBuilder.FigureSize := NewFigureSize;
  TextUpdateNeeded;
end;

procedure TMain0.UpdateMesh;
begin
  FederModel.Refresh;
  TextUpdateNeeded;
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
    FederScene.InitBitmap;
    GraphUpdateNeeded;
  end;
end;

procedure TMain0.UpdateRingColor3(AColor: TAlphaColor);
var
  ring: Integer;
begin
  ring := CurrentRing;
  if ring = 0 then
    ring := Round(FederModel._fp6);

  if ring < 1 then
    ring := 1;
  if ring > StripConst.StripCount then
    ring := StripConst.StripCount;

  BitmapBuilder.UpdatingRings := True;
  RingColor[ring] := AColor;
  Bitmap := Bitmap;
  BitmapBuilder.UpdatingRings := False;
  FormMain.InvalidateGraph(nil);
end;

procedure TMain0.UpdateRingMapping(NewMapID: Integer);
begin
  RingBuilder.MapID := NewMapID;
  LoadExample(0);
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
  if Assigned(OnMemoDraw) then
    OnMemoDraw(self);
end;

procedure TMain0.UpdateTouch;
begin
  if Assigned(FederText) and FederText.InitOK then
  begin
    Frame3D.UpdateRasterSize(IsRetina, FormMain.ClientWidth, FormMain.ClientHeight);
    MainVar.ClientWidth := FormMain.ClientWidth;
    MainVar.ClientHeight := FormMain.ClientHeight;
    InitTouch;
    FederText.UpdateMissing;
    FederText.UpdateShape;
    FederText.UpdatePageBtnText;
  end;
end;

procedure TMain0.UpdateTrackbar;
begin
  Trackbar_Min := -1000;
  Trackbar_Max := 1000;
  Trackbar_SetValue(FederModel.ParamValue);
end;

procedure TMain0.UpdateViewParamValue;
var
  t: single;
begin
  if TFederUtils.IsViewParam(Param) then
  begin
    t := ViewParamValue[ParamManager.CurrentParam];
    FederModel.UpdateParamValue(t);
    Trackbar_Value := t;
  end;
end;

procedure TMain0.UpdateVP;
begin
  vp.range := FederModel.AbsoluteRange;

  vp.ox := FederModel.OffsetX;
  vp.oy := FederModel.OffsetY;
  vp.oz := FederModel.OffsetZ;

  vp.mc :=  FederModel.mc;

  vp.ReducedMesh := FederScene.ReducedMesh;
  vp.ReduceMode := FederScene.ReduceMode;

  vp.PolarMesh := FederScene.PolarMesh;
  vp.FilterMesh := FederScene.FilterMesh;
  vp.FuzzyMesh := FederScene.FuzzyMesh;
  vp.LinearMesh := FederScene.LinearMesh;
  vp.OpenMesh := FederScene.OpenMesh;
  vp.HullMesh := FederScene.HullMesh;
  vp.InvertedMesh := FederScene.InvertedMesh;
  vp.UprightMesh := FederScene.UprightMesh;
  vp.FlippedTexture := FederScene.FlippedTexture;

  vp.ParamBahnRadius := FederModel.ParamBahnRadius;
  vp.ParamBahnPositionX := FederModel.ParamBahnPositionX;
  vp.ParamBahnPositionY := FederModel.ParamBahnPositionY;

  vp.CapValue := FederModel.CapValue;
  vp.SliceHeight := FederModel.SliceHeight;

  vp.Norm := FederModel.Norm;
  vp.Pin := FederModel.Pin;

  vp.TextureNorm := FederModel.TextureNorm;
  vp.NormScale := MainVar.Transform3D.NormScale;
  vp.GlobalScale := MainVar.Transform3D.GlobalScale;
  vp.ModelGroupScale := FederScene.ModelGroupScale;

  vp.T1 := FederModel.FT1;
  vp.T2 := FederModel.FT2;
  vp.Bitmap := FederScene.Bitmap;
  vp.BigMapFactorT2 := FederModel.BigMapFactorT2;
  vp.TextureRepeat := MainVar.TextureRepeat;

  vp.WantLux := FederScene.WantLux;
  vp.WantUniqueVertices := MainVar.WantUniqueVertices;

  vp.OffsetZ := FederModel.OffsetZ;
  vp.MinusCap := FederModel.MinusCap;
  vp.PlusCap := FederModel.PlusCap;
  vp.EQ := FederModel.Equation;
  vp.FaktorEQ := FederModel.EQ.FactorEQ;
  vp.FaktorG3 := FederModel.EQ.FactorG3;
  vp.SpringCount := FederModel.EQ.SpringCount;
  vp.Attenuation := FederModel.Attenuation;
  vp.Figure := FederModel.Figure;

  vp.Update;

  TColorBand.T1 := vp.T1;
  TColorBand.T2 := vp.T2;
end;

procedure TMain0.UpdateXY(mk: TFederMessageKind; Value: Integer);
begin
  case mk of
    fmkX1:
      FederModel.EQ.x1 := Value;
    fmkY1:
      FederModel.EQ.y1 := Value;
    fmkX2:
      FederModel.EQ.x2 := Value;
    fmkY2:
      FederModel.EQ.y2 := Value;
    fmkX3:
      FederModel.EQ.x3 := Value;
    fmkY3:
      FederModel.EQ.y3 := Value;
    fmkX4:
      FederModel.EQ.x4 := Value;
    fmkY4:
      FederModel.EQ.y4 := Value;
  end;
  FederModel.InitData;
  FKoordChanging := True;
  try
    ParamValueChanged(FederModel.Param);
  finally
    FKoordChanging := False;
  end;
end;

procedure TMain0.UprightMeshChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederScene.UprightMesh := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.Viewpoint3;
begin
  Frame3D.ResetRotation;
  Frame3D.CameraDummyRotationAngle.X := 5;
  Frame3D.UpdateRotation;
end;

procedure TMain0.ViewpointA;
begin
  Frame3D.ResetRotation;
  Frame3D.CameraDummyRotationAngle.X := 90;
  Frame3D.CameraDummyRotationAngle.Y := -90;
  Frame3D.UpdateRotation;
end;

procedure TMain0.ViewpointS;
begin
  Frame3D.ResetRotation;
  Frame3D.CameraDummyRotationAngle.X := 90;
  Frame3D.UpdateRotation;
end;

procedure TMain0.ViewpointT;
begin
  Frame3D.ResetRotation;
  Frame3D.CameraDummyRotationAngle.X := 0;
  Frame3D.UpdateRotation;
end;

procedure TMain0.VorzeichenChanged(NewValue: Boolean);
begin
  if not Resetting then
  begin
    FederModel.Vorzeichen := NewValue;
    UpdateChart;
  end;
end;

procedure TMain0.WhiteText;
begin
  MainVar.ColorScheme.WhiteText;
  FederText.UpdateColorScheme;
end;

procedure TMain0.WriteActionConst;
var
  cr: TActionSorter;
begin
  cr := TActionSorter.Create;
  cr.WriteActionConst(FL);
  cr.Free;
  CopyFL;
end;

procedure TMain0.WriteActionNames;
var
  cr: TActionSorter;
begin
  cr := TActionSorter.Create;
  cr.WriteActionNames(FL);
  cr.Free;
  CopyFL;
end;

procedure TMain0.WriteAllSampleDiff(ML: TStrings);
var
  fd1, fd2: TFederData;
  i: Integer;
begin
  fd1 := TFederData3.Create;
  fd2 := TFederData3.Create;
  for i := 1 to SampleManager.SampleHub.Count-1 do
  begin
    ML.Add(Format('{ Sample %d }', [i]));
    SampleManager.SampleHub.LoadSample(fd1, i);
    SampleManager.SampleHub.LoadSample(fd2, i+1);
    fd2.ShowVersion1Diff(fd1, ML);
    ML.Add('');
  end;
  fd1.Free;
  fd2.Free;
end;

procedure TMain0.WriteCode(ML: TStrings);
begin
  UpdateData;
  FederData.SaveCode(ML);
end;

procedure TMain0.WriteDiffBin(ML: TStrings);
begin
  UpdateData;
  FederData.SaveDiffBin(DefaultFederData, ML);
end;

procedure TMain0.WriteDiffBinTest(ML: TStrings);
begin
  UpdateData;
  FederData.SaveDiffBin(DefaultFederData, ML);
  BitmapImprinter.WriteTest(ML);
  BitmapImprinter.ReadTest(ML);
end;

procedure TMain0.WriteDiffCode(ML: TStrings);
begin
  UpdateData;
  FederData.SaveDiffCode(DefaultFederData, ML);
  ML.Insert(0, Format('// %s', [DateTimeToStr(Now)]));
  ML.Insert(0, Format('// Sample %d-%d-%d from %s', [Level, Hub, Sample, Application.Title]));
end;

procedure TMain0.WriteDiffPixelTest(ML: TStrings);
var
  bmp: TBitmap;
begin
  UpdateData;
  bmp := TBitmap.Create(40, 40);
  { ML is empty here }
  FederData.SaveDiffBin(DefaultFederData, ML);
  BitmapImprinter.SaveToBitmap(bmp, ML);
  BitmapImprinter.LoadFromBitmap(bmp, ML);
  bmp.Free;
end;

procedure TMain0.WriteSampleDiff(ML: TStrings);
begin
  UpdateData;
  FederData.ShowVersion1Diff(DefaultFederData, ML);
end;

procedure TMain0.WriteStatus(ML: TStrings);
begin
  UpdateData;
  FederData.SaveNative(ML);
end;

procedure TMain0.WriteTestMemoLines(ML: TStrings; Count: Integer);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    ML.Add(Format('%.2d: TestMemoLine[%d]', [i+1, i]));
end;

procedure TMain0.WriteVersion1Diff(ML: TStrings);
begin
  UpdateData;
  FederData.WriteVersion1Diff(DefaultFederData, ML);
end;

procedure TMain0.WriteVersion1Txt(ML: TStrings);
begin
  UpdateData;
  FederData.SaveNative(ML);
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

procedure TMain0.AddMeshesToScene(ModelParent: TFmxObject);
begin
  ModelParent.AddObject(FederMesh);
  ModelParent.AddObject(Inner);
  ModelParent.AddObject(SolidPart);
end;

procedure TMain0.InitData(Sender: TObject);
begin
  StopWatch.Start;

  UpdateVP;

  if InitDataOK and (FederModel.CurrentParam in [fpt1, fpt2, fpBandWidth]) then
  begin
    FederMesh.UpdateColor;
  end
  else
  begin
    vp.PlusCap := FederModel.PlusCap;
    vp.ReducedMesh := ReducedMesh;
    vp.WantZeroPulling := MeshBuilder.WantZeroPulling;
    vp.WantSlicePulling := MeshBuilder.WantSlicePulling;
    vp.SlicePullingMode := MeshBuilder.SlicePullingMode;
    vp.ReduceMode := FederScene.ReduceMode;
    vp.WantFlippedHands := FederMesh.WantFlippedHands;
    vp.WantMirroredBottom := False;
    vp.WantUniqueVertices := MainVar.WantUniqueVertices;
    vp.OuterOptionZ := TVertexOptionZ.Normal;
    TSolidSide.CenterPointInsetZ := 10;

    FederMesh.InitData;

    if not ReducedMesh then
      SolidPartVisible := False;
    if OpenMesh then
      SolidPartVisible := False;

    if SolidPartVisible then
    begin
      vp.OpenMesh := False;
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
  FederScene.UpdateAxis;
  GraphUpdateNeeded;
end;

procedure TMain0.SetSolidPartVisible(const Value: Boolean);
begin
  FSolidPartVisible := Value;

  Inner.Visible := Value;
  SolidPart.Visible := Value;

  if Value then
  begin
    FederScene.ReducedMesh := True;
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
