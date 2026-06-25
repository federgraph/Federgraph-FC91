unit RiggVar.FederModel.RingBuilder;

interface

uses
  System.SysUtils,
  System.Classes,
  System.UITypes,
  System.UIConsts,
  RiggVar.FederModel.Action,
  RiggVar.FB.Bitmap,
  RiggVar.FB.ColorConst,
  RiggVar.FB.Color,
  RiggVar.FB.ColorGroup,
  RiggVar.FB.Def,
  RiggVar.FB.ListArray;

type
  TColorArea = (
    BackPlane,

    EyeBase,
    EyeWhite,

    RingInner,
    RingOuter,

    SkinWhite,
    RimRed
  );

  TColorMappingInfo = record
  public
    BackPlane: Integer;

    EyeBase: Integer;
    EyeWhite: Integer;

    RingInner: Integer;
    RingOuter: Integer;

    SkinWhite: Integer;
    RimRed: Integer;

    { 4 Color Mapping }
    procedure Init1;
    procedure Init2;
    procedure Init3;
    procedure Init4;
    procedure Init5;

    { 2 Color Mapping }
    procedure Init6;

    { 3 Color Mapping }
    procedure Init7;
    procedure Init8;
    procedure Init9;
  end;

  TRingInfo = record
  private
    function GetTopValue: Integer;
  public
    CapValue: Integer;
    SliceHeight: Integer;
    Color: TAlphaColor;
    MeshSize: Integer;
    BungoCount: Integer;
    procedure Clear;
    function ToString(i: Integer): string;
    property TopValue: Integer read GetTopValue;
  end;

  TRingList = class(TListArray<TRingInfo>)
  public
    procedure AddSlice(ASliceHeight: Integer; AColor: TAlphaColor; AMeshSize: Integer = 128);
  end;

  TPrintColorSet = record
    Color1: TAlphaColor;
    Color2: TAlphaColor;
    Color3: TAlphaColor;
    Color4: TAlphaColor;
    procedure Init1;
    procedure Init2;
    procedure Init3;
    procedure Init4;
    procedure Init5;
    procedure Init6;
    procedure Init7;
    procedure Init8;
    function GetColor(ID: Integer): TAlphaColor;
  end;

  TRingBuilder = class
  private
    ML: TStringList;
    SL: TStringList;
    RL: TRingList;

    claRimRed,
    claSkinWhite,
    claRingOuter,
    claRingInner,
    claEyeWhite,
    claEyeBase,
    claBackPlane: TAlphaColor;

    FMapID: Integer;

    FEyeSize: TSizeName;
    FFigureSize: TSizeName;
    FCapValueSnapShot: single;

    procedure MapColors(ID: Integer);
    procedure InitWithNewMapping;
    procedure InitRL(ASelectedColors: TPrintColorSet); overload;
    procedure InitRL; overload;
    procedure UpdateLayerColors;
    procedure UpdateModelFromRingList;
    procedure SL_Add(SL: TStrings; s: string; TargetLength: Integer = 36);
    procedure SetCapValueSnapShot(const Value: single);
  protected
    procedure GetColorMappingReport1(ML: TStrings);
    procedure GetColorMappingReport2(ML: TStrings);
  public
    SelectedColors: TPrintColorSet;
    ColorMappingInfo: TColorMappingInfo;

    constructor Create;
    destructor Destroy; override;

    procedure InitFromExample(AExampleID: Integer);
    procedure InitWithNewSelectedColors(ASelectedColors: TPrintColorSet);
    procedure InitWithNewEyeSize(AEyeSize: TSizeName);

    procedure MapColorToLayer(ALayer, AColor: Integer);

    procedure ListBasicColors(ML: TStrings);
    procedure ListMatteColors(ML: TStrings);
    procedure ListSelectedColors(ML: TStrings);
    procedure GetRingInfoReport(ML: TStrings);
    procedure GetColorMappingReport(ML: TStrings);

    property RingList: TRingList read RL;
    property MapID: Integer read FMapID write FMapID;
    property EyeSize: TSizeName read FEyeSize write FEyeSize;
    property FigureSize: TSizeName read FFigureSize write FFigureSize;
    property CapValueSnapShot: single read FCapValueSnapShot write SetCapValueSnapShot;
  end;

implementation

uses
  RiggVar.App.Main;

{ TPrintColorSet }

function TPrintColorSet.GetColor(ID: Integer): TAlphaColor;
begin
  case ID of
    1: result := Color1;
    2: result := Color2;
    3: result := Color3;
    4: result := Color4;
    else
      result := Color1;
  end;
end;

procedure TPrintColorSet.Init1;
begin
  Color1 := TBambuColors.PLABasic_Blue;
  Color2 := TBambuColors.PLABasic_LightGray;
  Color3 := TBambuColors.PLABasic_MaroonRed;
  Color4 := TBambuColors.PLABasic_MaroonRed;
end;

procedure TPrintColorSet.Init2;
begin
  Color1 := TBambuColors.PLABasic_Blue;
  Color2 := TBambuColors.PLAMatte_SakuraPink;
  Color3 := TBambuColors.PLABasic_Magenta;
  Color4 := TBambuColors.PLABasic_Cyan;
end;

procedure TPrintColorSet.Init3;
begin
  Color1 := TBambuColors.PLABasic_Blue;
  Color2 := TBambuColors.PLABasic_SunflowerYellow;
  Color3 := TBambuColors.PLABasic_Magenta;
  Color4 := TBambuColors.PLABasic_Cyan;
end;

procedure TPrintColorSet.Init4;
begin
  Color1 := TBambuColors.PLAMatte_MarineBlue;
  Color2 := TBambuColors.PLAMatte_IceBlue;
  Color3 := TBambuColors.PLABasic_MaroonRed;
  Color4 := TBambuColors.PLABasic_MaroonRed;
end;

procedure TPrintColorSet.Init5;
begin
  Color1 := TBambuColors.PLABasic_Black;
  Color2 := TBambuColors.PLAMatte_AshGray;
  Color3 := TBambuColors.PLABasic_Bronze;
  Color4 := TBambuColors.PLAMatte_DarkGreen;
end;

procedure TPrintColorSet.Init6;
begin
  Color1 := TBambuColors.PLABasic_Black;
  Color2 := TBambuColors.PLAMatte_AshGray;
  Color3 := TBambuColors.PLABasic_IndigoPurple;
  Color4 := TBambuColors.PLABasic_Red;
end;

procedure TPrintColorSet.Init7;
begin
  Color1 := TBambuColors.PLAMatte_DarkBlue;
  Color2 := TBambuColors.PLAMatte_SakuraPink;
  Color3 := TBambuColors.PLAMatte_ScarletRed;
  Color4 := TBambuColors.PLABasic_Silver;
end;

procedure TPrintColorSet.Init8;
begin
  Color1 := TBambuColors.PLABasic_MistletoeGreen;
  Color2 := TBambuColors.PLABasic_LightGray;
  Color3 := TBambuColors.PLABasic_BambuGreen;
  Color4 := TBambuColors.PLABasic_Cyan;
end;

{ TRingList }

procedure TRingList.AddSlice(ASliceHeight: Integer; AColor: TAlphaColor; AMeshSize: Integer);
var
  cr: TRingInfo;
begin
  cr := Items[Count-1];
  cr.CapValue := cr.CapValue + ASliceHeight;
  cr.SliceHeight := ASliceHeight;
  cr.Color := AColor;
  cr.MeshSize := AMeshSize;
  Add(cr);
end;

{ TRingInfo }

procedure TRingInfo.Clear;
begin
  CapValue := 25;
  SliceHeight := 25;
  Color := claRed;
  MeshSize := 128;
  BungoCount := 0;
end;

function TRingInfo.GetTopValue: Integer;
begin
  result := CapValue + SliceHeight;
end;

function TRingInfo.ToString(i: Integer): string;
var
  s: string;
begin
  s := AlphaColorToString(Color);
  result := Format('%.2d = %.2d-%.4d-%.3d-%s', [i, SliceHeight, MeshSize, BungoCount, s]);
end;

{ TRingBuilder }

constructor TRingBuilder.Create;
var
  cr: TRingInfo;
begin
  FMapID := 1;
  FEyeSize := TSizeName.Medium;
  FFigureSize := TSizeName.Medium;
  CapValueSnapShot := 60;

  RandSeed := 10;

  ML := TStringList.Create;
  SL := TStringList.Create;

  cr.Clear;
  RL := TRingList.Create(34, cr);

  SelectedColors.Init1;
  ColorMappingInfo.Init1;
end;

destructor TRingBuilder.Destroy;
begin
  ML.Free;
  SL.Free;
  RL.Free;
  inherited;
end;

procedure TRingBuilder.UpdateModelFromRingList;
var
  i: Integer;
  cr: TRingInfo;
begin
  Main.CurrentRing := 17;
  for i := 0 to RL.Count do
  begin
    cr := RL[i];
    Main.RingWidth := cr.SliceHeight;
    Main.RingColor[Main.CurrentRing] := cr.Color;
    Main.CurrentRing := Main.CurrentRing + 1;
  end;
  Main.CurrentRing := 21;
  Main.UpdateBitmap;
end;

procedure TRingBuilder.ListBasicColors(ML: TStrings);
var
  i: TBasicEnum;
  bla, cla: TRggColor;
  s, t: string;
  d: TRggColorDistanceInfo;
begin
  ML.Clear;
  ML.Add('PLA Basic Nearest 1:');
  ML.Add('');
  for i := Low(TBasicEnum) to High(TBasicEnum) do
  begin
    bla := BasicColorArray[i];
    cla := ColorVar.RggColorPool.FindNearest1(bla, d);
    s := BambulabBasicColors[Integer(i)].Name;
    t := ColorVar.RggColorPool.ColorToString(cla);
    ML.Add(Format('%s -> %s (%d, %d; %d-%d-%d)', [s, t, d.Dist, d.Count, d.dr, d.dg, d.db]));
  end;
end;

procedure TRingBuilder.ListMatteColors(ML: TStrings);
var
  i: TMatteEnum;
  bla, cla: TRggColor;
  s, t: string;
  d: TRggColorDistanceInfo;
begin
  ML.Clear;
  ML.Add('PLA Matte Nearest 1:');
  ML.Add('');
  for i := Low(TMatteEnum) to High(TMatteEnum) do
  begin
    bla := MatteColorArray[i];
    cla := ColorVar.RggColorPool.FindNearest1(bla, d);
    s := BambulabMatteColors[Integer(i)].Name;
    t := ColorVar.RggColorPool.ColorToString(cla);
    ML.Add(Format('%s -> %s (%d, %d)', [s, t, d.Dist, d.Count]));
  end;

end;

procedure TRingBuilder.ListSelectedColors(ML: TStrings);
var
  s, t: string;
begin
  t := ColorVar.RggColorPool.ColorToString(SelectedColors.Color1);
  s := Format('Color1 = %s', [t]);
  SL_Add(ML, s);

  t := ColorVar.RggColorPool.ColorToString(SelectedColors.Color2);
  s := Format('Color2 = %s', [t]);
  SL_Add(ML, s);

  t := ColorVar.RggColorPool.ColorToString(SelectedColors.Color3);
  s := Format('Color3 = %s', [t]);
  SL_Add(ML, s);

  t := ColorVar.RggColorPool.ColorToString(SelectedColors.Color4);
  s := Format('Color4 = %s', [t]);
  SL_Add(ML, s);
end;

procedure TRingBuilder.InitRL(ASelectedColors: TPrintColorSet);
begin
  SelectedColors := ASelectedColors;
  MapColors(FMapID);
  InitRL;
end;

procedure TRingBuilder.InitWithNewMapping;
begin
  UpdateLayerColors;
  InitRL;
end;

procedure TRingBuilder.InitWithNewEyeSize(AEyeSize: TSizeName);
begin
  EyeSize := AEyeSize;
  InitRL;
  UpdateModelFromRingList;
end;

procedure TRingBuilder.InitWithNewSelectedColors(ASelectedColors: TPrintColorSet);
begin
  InitRL(ASelectedColors);
  UpdateModelFromRingList;
end;

procedure TRingBuilder.InitRL;
var
  cr: TRingInfo;
  EyeOffset: Integer;
begin
  RL.Clear;
  cr.Clear;
  cr.CapValue := 0;

  case FEyeSize of
    Small: EyeOffset := 1;
    Medium: EyeOffset := 0;
    Large: EyeOffset := -1;
    else
      EyeOffset := 0;
  end;

  RL.AddSlice(11, claRimRed); // ColorBand 17;

  if Main.Sample <> 1 then
  begin
    RL.AddSlice(1, claBlack); // ColorBand 18
    RL.AddSlice(10, SelectedColors.Color4); // ColorBand 19

    RL.AddSlice(1, claBlack); // ColorBand 20
    RL.AddSlice(10, SelectedColors.Color3); // ColorBand 21

    RL.AddSlice(1, claBlack); // ColorBand 22
    RL.AddSlice(11, SelectedColors.Color2); // ColorBand 23

    RL.AddSlice(1, claBlack); // ColorBand 24
  end
  else
  begin
    RL.AddSlice(1, claRimRed); // ColorBand 18; CapValue = 1
    RL.AddSlice(13, claSkinWhite); // ColorBand 19, CapValue = 14, Hell 1
    RL.AddSlice(6, claRingOuter); // ColorBand 20, CapValue = 20,
    RL.AddSlice(6, claRingInner); // ColorBand 21, CapValue = 26,
    RL.AddSlice(9 + EyeOffset, claEyeWhite); // ColorBand 22, CapValue = 36 + eo,
    RL.AddSlice(22 - EyeOffset, claEyeBase); // ColorBand 23, CapValue = 57,
    RL.AddSlice(3, claBackPlane); // ColorBand 24, CapValue = 60,
  end;

  RL.AddSlice(11, SelectedColors.Color1); // ColorBand 25,
  RL.AddSlice(11, claRingOuter); // ColorBand 26,
  RL.AddSlice(11, claRingOuter); // ColorBand 27,
  RL.AddSlice(11, claRingOuter); // ColorBand 28,
  RL.AddSlice(11, claRingOuter); // ColorBand 29,
  RL.AddSlice(11, claRingOuter); // ColorBand 30,
  RL.AddSlice(11, claRingOuter); // ColorBand 31,
  RL.AddSlice(11, claRingOuter); // ColorBand 32,
  RL.AddSlice(11, claRingOuter); // ColorBand 33,

  RL.AddSlice(1, claRingOuter); // ColorBand 34,

  { there are no more colorbands available beyond ColorBand 34 }
end;

procedure TRingBuilder.SetCapValueSnapShot(const Value: single);
begin
  { see RiggVar.Color.Bitmap02 in FC90 }
  if Value < 10 then
    Exit;
  if Value > 200 then
    Exit;

  FCapValueSnapShot := Value;
end;

procedure TRingBuilder.SL_Add(SL: TStrings; s: string; TargetLength: Integer);
var
  c: Integer;
  t: string;
begin
  c := TargetLength - s.Length;
  if c > 0 then
    t := StringOfChar(' ', c);
  SL.Add(s + t + '|');
end;

procedure TRingBuilder.GetRingInfoReport(ML: TStrings);
var
  i, j: Integer;
  cr: TRingInfo;
  s: string;
  h: Integer;
  f: single;
  sh: Integer;
  ivon1, ibis1: Integer;
  ivon2, ibis2: Integer;
begin
  case FFigureSize of
    TSizeName.ExtraSmall: h := 100;
    TSizeName.Small: h := 120;
    TSizeName.Medium: h := 160;
    TSizeName.Large: h := 240;
    TSizeName.ExtraLarge: h := 320;
    else
      h := 240;
  end;

  f := h / 240;
  ML.Add(Format('Figure Size = %.2f (%d mm)', [f, h]));
  ML.Add('');
  j := 0;
  ibis1 := 0;
  for i := 1 to 7 do
  begin
    cr := RL[i];

    sh  := cr.SliceHeight;

    ivon1 := ibis1;
    ibis1 := ivon1 + sh;

    { typically 60 oder 64 or 80, target-height of printed figure
      CapValueSnapshot is the value of CapValue at the time the Mesh
      was exported or will be when the mesh is expected as .obj in the future.  }
    ivon2 := Round(CapValueSnapShot - ibis1);
    ibis2 := Round(CapValueSnapShot - ivon1);

    Inc(j);
    s := Format('%2d: %2d = (%2d - %2d) [%5.2f - %5.2f]', [j, sh, ivon1, ibis1, ivon2 * f, ibis2 * f]);
    ML.Add(s);
  end;

end;

procedure TRingBuilder.GetColorMappingReport(ML: TStrings);
begin
  GetColorMappingReport2(ML);
end;

procedure TRingBuilder.GetColorMappingReport1(ML: TStrings);
begin
  ML.Add(Format('Back Plane = Color %d', [ColorMappingInfo.BackPlane]));
  ML.Add(Format('Eye Base   = Color %d', [ColorMappingInfo.EyeBase]));
  ML.Add(Format('Eye White  = Color %d', [ColorMappingInfo.EyeWhite]));
  ML.Add(Format('Ring Inner = Color %d', [ColorMappingInfo.RingInner]));
  ML.Add(Format('Ring Outer = Color %d', [ColorMappingInfo.RingOuter]));
  ML.Add(Format('Skin White = Color %d', [ColorMappingInfo.SkinWhite]));
  ML.Add(Format('Rim Red    = Color %d', [ColorMappingInfo.RimRed]));
end;

procedure TRingBuilder.GetColorMappingReport2(ML: TStrings);
var
  cp: TRggColorPoolBase;
  s1, s2, s3, s4: string;
  t1, t2: string;

  function A(c: Integer): string;
  var
    s: string;
  begin
    case c of
      1: s := s1;
      2: s := s2;
      3: s := s3;
      4: s := s4;
    end;
    result := Format('C%d = %s', [c, s]);
  end;
begin
  cp := ColorVar.RggColorPool;

  s1 := cp.ColorToString(SelectedColors.Color1);
  s2 := cp.ColorToString(SelectedColors.Color2);
  s3 := cp.ColorToString(SelectedColors.Color3);
  s4 := cp.ColorToString(SelectedColors.Color4);

  t1 := 'PLABasic_';
  t2 := '';
  s1 := s1.Replace(t1, t2);
  s2 := s2.Replace(t1, t2);
  s3 := s3.Replace(t1, t2);
  s4 := s4.Replace(t1, t2);

  t1 := 'PLAMatte_';
  t2 := '';
  s1 := s1.Replace(t1, t2);
  s2 := s2.Replace(t1, t2);
  s3 := s3.Replace(t1, t2);
  s4 := s4.Replace(t1, t2);

  SL_Add(ML, Format('Back Plane = %s', [A(ColorMappingInfo.BackPlane)]));
  SL_Add(ML, Format('Eye Base   = %s', [A(ColorMappingInfo.EyeBase)]));
  SL_Add(ML, Format('Eye White  = %s', [A(ColorMappingInfo.EyeWhite)]));
  SL_Add(ML, Format('Inner Ring = %s', [A(ColorMappingInfo.RingInner)]));
  SL_Add(ML, Format('Outer Ring = %s', [A(ColorMappingInfo.RingOuter)]));
  SL_Add(ML, Format('Skin White = %s', [A(ColorMappingInfo.SkinWhite)]));
  SL_Add(ML, Format('Rim Red    = %s', [A(ColorMappingInfo.RimRed)]));
end;

procedure TRingBuilder.InitFromExample(AExampleID: Integer);
begin
  case AExampleID of
    1: SelectedColors.Init1;
    2: SelectedColors.Init2;
    3: SelectedColors.Init3;
    4: SelectedColors.Init4;
    5: SelectedColors.Init5;
    6: SelectedColors.Init6;
    7: SelectedColors.Init7;
    8: SelectedColors.Init8;
  end;
  InitRL(SelectedColors);
  UpdateModelFromRingList;
end;

procedure TRingBuilder.MapColors(ID: Integer);
begin
  case ID of
    1: ColorMappingInfo.Init1;
    2: ColorMappingInfo.Init2;
    3: ColorMappingInfo.Init3;
    4: ColorMappingInfo.Init4;
    5: ColorMappingInfo.Init5;

    6: ColorMappingInfo.Init6;

    7: ColorMappingInfo.Init7;
    8: ColorMappingInfo.Init8;
    9: ColorMappingInfo.Init9;
  end;
  UpdateLayerColors;
end;

procedure TRingBuilder.UpdateLayerColors;
begin
  claBackPlane := SelectedColors.GetColor(ColorMappingInfo.BackPlane);
  claEyeBase := SelectedColors.GetColor(ColorMappingInfo.EyeBase);
  claEyeWhite := SelectedColors.GetColor(ColorMappingInfo.EyeWhite);
  claRingInner := SelectedColors.GetColor(ColorMappingInfo.RingInner);
  claRingOuter := SelectedColors.GetColor(ColorMappingInfo.RingOuter);
  claSkinWhite := SelectedColors.GetColor(ColorMappingInfo.SkinWhite);
  claRimRed := SelectedColors.GetColor(ColorMappingInfo.RimRed);
end;

procedure TRingBuilder.MapColorToLayer(ALayer, AColor: Integer);
begin
  case ALayer of
    1: ColorMappingInfo.BackPlane := AColor;
    2: ColorMappingInfo.EyeBase := AColor;
    3: ColorMappingInfo.EyeWhite := AColor;
    4: ColorMappingInfo.RingInner := AColor;
    5: ColorMappingInfo.RingOuter := AColor;
    6: ColorMappingInfo.SkinWhite := AColor;
    7: ColorMappingInfo.RimRed := AColor;
  end;
  InitWithNewMapping;
  UpdateModelFromRingList;
end;

{ TColorMappingInfo }

procedure TColorMappingInfo.Init1;
begin
  BackPlane := 4;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 3;

  SkinWhite := 2;
  RimRed := 3;
end;

procedure TColorMappingInfo.Init2;
begin
  BackPlane := 3;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 3;

  SkinWhite := 2;
  RimRed := 4;
end;

procedure TColorMappingInfo.Init3;
begin
  BackPlane := 4;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 3;

  SkinWhite := 2;
  RimRed := 4;
end;

procedure TColorMappingInfo.Init4;
begin
  BackPlane := 4;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 3;

  SkinWhite := 2;
  RimRed := 1;
end;

procedure TColorMappingInfo.Init5;
begin
  BackPlane := 4;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 1;

  SkinWhite := 2;
  RimRed := 4;
end;

procedure TColorMappingInfo.Init6;
begin
  BackPlane := 1;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 1;

  SkinWhite := 2;
  RimRed := 1;
end;

procedure TColorMappingInfo.Init7;
begin
  BackPlane := 1;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 3;

  SkinWhite := 2;
  RimRed := 1;
end;

procedure TColorMappingInfo.Init8;
begin
  BackPlane := 2;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 3;

  SkinWhite := 2;
  RimRed := 1;
end;

procedure TColorMappingInfo.Init9;
begin
  BackPlane := 3;

  EyeBase := 1;
  EyeWhite := 2;

  RingInner := 1;
  RingOuter := 3;

  SkinWhite := 2;
  RimRed := 1;
end;

end.

