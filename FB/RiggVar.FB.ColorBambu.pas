unit RiggVar.FB.ColorBambu;

interface

uses
  System.UIConsts,
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionConfig,
  RiggVar.FB.Color,
  RiggVar.FB.ColorGroup,
  RiggVar.FB.ColorList;

type
  TBambuPart = (
    Unused,
    Dark,
    Skin,
    Ring
  );

  TBambuPartition = class
  private
    procedure ClearPage(APage: Integer; AStartPos: TBtnPos = TBtnPos.TL02);
  public
    UnusedColors: TRggColorList;
    DarkColors: TRggColorList;
    SkinColors: TRggColorList;
    RingColors: TRggColorList;

    constructor Create;
    destructor Destroy; override;

    procedure InitUnused;
    procedure InitDark;
    procedure InitSkin;
    procedure InitRing;

    procedure BuildActionItemList;
    procedure AddActionItemForPage(APage: Integer; cl: TRggColorList);
  end;

implementation

uses
  RiggVar.App.Main;

{ TBambuPartition }

constructor TBambuPartition.Create;
begin
  UnusedColors := TRggColorList.Create;
  DarkColors := TRggColorList.Create;
  SkinColors := TRggColorList.Create;
  RingColors := TRggColorList.Create;

  InitUnused;
  InitDark;
  InitSkin;
  InitRing;
end;

destructor TBambuPartition.Destroy;
begin
  UnusedColors.Free;
  DarkColors.Free;
  SkinColors.Free;
  RingColors.Free;
  inherited;
end;

procedure TBambuPartition.InitDark;
begin
  with DarkColors do
  begin
    AddColor(TBasicColors.PLABasic_MaroonRed);
    AddColor(TBasicColors.PLABasic_Red);
    AddColor(TBasicColors.PLABasic_Magenta);
    AddColor(TBasicColors.PLABasic_Blue);
    AddColor(TBasicColors.PLABasic_IndigoPurple);
    AddColor(TBasicColors.PLABasic_DarkGray);
    AddColor(TBasicColors.PLABasic_Black);

    AddColor(TMatteColors.PLAMatte_DarkRed);
    AddColor(TMatteColors.PLAMatte_DarkBlue);
  end;
end;

procedure TBambuPartition.InitSkin;
begin
  with SkinColors do
  begin
    AddColor(TBasicColors.PLABasic_JadeWhite);
    AddColor(TBasicColors.PLABasic_Beige);

    AddColor(TMatteColors.PLAMatte_LatteBrown);
    AddColor(TMatteColors.PLAMatte_DesertTan);
    AddColor(TMatteColors.PLAMatte_SakuraPink);
    AddColor(TMatteColors.PLAMatte_IceBlue);
  end;
end;

procedure TBambuPartition.InitRing;
begin
  with RingColors do
  begin
    AddColor(TMatteColors.PLAMatte_MarineBlue);
    AddColor(TBasicColors.PLABasic_BlueGray);
    AddColor(TBasicColors.PLABasic_Cyan);
    AddColor(TBasicColors.PLABasic_Turquoise);

    AddColor(TMatteColors.PLAMatte_ScarletRed);

    AddColor(TBasicColors.PLABasic_Purple);
    AddColor(TMatteColors.PLAMatte_LilacPurple);
    AddColor(TBasicColors.PLABasic_CobaltBlue);
    AddColor(TBasicColors.PLABasic_Pink);

    AddColor(TBasicColors.PLABasic_Orange);
    AddColor(TMatteColors.PLAMatte_MandarinOrange);
    AddColor(TBasicColors.PLABasic_Pumpkin);

    AddColor(TBasicColors.PLABasic_BambuGreen);
    AddColor(TBasicColors.PLABasic_MistletoeGreen);
  end;
end;

procedure TBambuPartition.InitUnused;
begin
  with UnusedColors do
  begin
    AddColor(TMatteColors.PLAMatte_IvoryWhite);

    AddColor(TMatteColors.PLAMatte_Charcoal);

    AddColor(TBasicColors.PLABasic_Gray);
    AddColor(TBasicColors.PLABasic_LightGray);
    AddColor(TMatteColors.PLAMatte_AshGray);

    AddColor(TBasicColors.PLABasic_Gold);
    AddColor(TBasicColors.PLABasic_Silver);
    AddColor(TBasicColors.PLABasic_Bronze);

    AddColor(TBasicColors.PLABasic_Brown);
    AddColor(TMatteColors.PLAMatte_DarkBrown);
    AddColor(TBasicColors.PLABasic_CocoaBrown);

    AddColor(TBasicColors.PLABasic_HotPink);

    AddColor(TBasicColors.PLABasic_Yellow);
    AddColor(TBasicColors.PLABasic_SunflowerYellow);
    AddColor(TMatteColors.PLAMatte_LemonYellow);

    AddColor(TMatteColors.PLAMatte_DarkGreen);
    AddColor(TMatteColors.PLAMatte_GrassGreen);
    AddColor(TBasicColors.PLABasic_BrightGreen);
  end;
end;

procedure TBambuPartition.BuildActionItemList;
begin
  Main.ActionItemList.Clear;

  AddActionItemForPage(1, DarkColors);
  AddActionItemForPage(2, SkinColors);
  AddActionItemForPage(3, RingColors);
  AddActionItemForPage(4, RingColors);
end;

procedure TBambuPartition.AddActionItemForPage(APage: Integer; cl: TRggColorList);
var
  i: Integer;
  cr: TRggColorListItem;
  bp: TBtnPos;
  ai: TActionItem;
begin
  bp := TBtnPos.TL02;

  for i := 0 to cl.Count - 1 do
  begin
    cr := cl[i];

    ai.Page := APage;
    ai.Position := bp;
    ai.Action := Main.ActionItemList.GetBtnAction(bp);
    ai.Color := cr.Color;

    Main.ActionItemList.Add(ai);

    Inc(bp);
  end;

  ClearPage(APage, bp);
end;

procedure TBambuPartition.ClearPage(APage: Integer; AStartPos: TBtnPos);
var
  bp: TBtnPos;
  ai: TActionItem;
begin
//  for bp := AStartPos to Pred(TBtnPos.BR01) do
  for bp := AStartPos to High(TBtnPos) do
  begin
    ai.Page := APage;
    ai.Position := bp;
    ai.Action := faNoop;
    ai.Color := claGray;

    Main.ActionItemList.Add(ai);
  end;

end;

end.
