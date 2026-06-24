unit RiggVar.Mesh.SolidPart;

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
  System.UITypes,
  System.UIConsts,
  System.Math.Vectors,
  FMX.Objects3D,
  FMX.MaterialSources,
  RiggVar.FederModel.MaterialSources,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.FB.MeshParams,
  RiggVar.Mesh.FederMesh,
  RiggVar.Mesh.BuilderMesh,
  RiggVar.Mesh.ExporterOBJ,
  RiggVar.Mesh.FederShell1,
  RiggVar.Mesh.MeshBuilder,
  RiggVar.MeshBuilder.BorderBand,
  RiggVar.MeshBuilder.BorderBuilder1;

type
  TSolidSide = class(TBuilderMesh)
  private
    PointBorder: TPoint3DArray;
    CombiBorder: TPoint3DArray;
    function InjectedBorderOK: Boolean;
    procedure InitCombiBorder;
    function FindCenterPoint: TPoint3D;
  protected
    procedure RebuildMesh; override;
  public
    IsNorth: Boolean;
    IsSouth: Boolean;
    IsWest: Boolean;
    IsEast: Boolean;
    OuterBorder: TPoint3DArray;
    InnerBorder: TPoint3DArray;
    class var
      CenterPointInsetZ: single;
    constructor Create(AOwner: TComponent); override;
  end;

  TSolidPart = class(TFederGroup)
  private
    FMP: TMaterialPool;

    FInnerMaterialSource: TMaterialSource;
    FNorthMaterialSource: TMaterialSource;
    FSouthMaterialSource: TMaterialSource;
    FWestMaterialSource: TMaterialSource;
    FEastMaterialSource: TMaterialSource;

    FOuterColor: TAlphaColor;
    FInnerColor: TAlphaColor;
    FNorthColor: TAlphaColor;
    FSouthColor: TAlphaColor;
    FWestColor: TAlphaColor;
    FEastColor: TAlphaColor;

    NorthSide: TSolidSide;
    SouthSide: TSolidSide;
    WestSide: TSolidSide;
    EastSide: TSolidSide;

    FDoubleSided: Boolean;
    FMaterialID: Integer;
    FWantSideCaps: Boolean;
    procedure InitDefault;
    procedure SetDoubleSided(const Value: Boolean);
    procedure SetUniqueMode(const Value: Integer);
    function GetUniqueMode: Integer;
    function GetCapValue: single;
    function GetMeshSize: Integer;
    procedure SetWantSideCaps(const Value: Boolean);
    function GetTestSingleSide: Boolean;
    procedure SetTestSingleSide(const Value: Boolean);
  public
    Outer: TFederShell1;
    Inner: TFederShell1;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init;
    procedure UpdateGroup;
    procedure ExportOBJ(Exporter: TExporterOBJ; StandAlone: Boolean); override;
    property CapValue: single read GetCapValue;
    property MeshSize: Integer read GetMeshSize;
    property DoubleSided: Boolean read FDoubleSided write SetDoubleSided;
    property UniqueMode: Integer read GetUniqueMode write SetUniqueMode;
    property MaterialID: Integer read FMaterialID write FMaterialID;
    property InnerMaterialSource: TMaterialSource read FInnerMaterialSource;
    property WantSideCaps: Boolean read FWantSideCaps write SetWantSideCaps;
    property TestSingleSide: Boolean read GetTestSingleSide write SetTestSingleSide;
  end;

implementation

uses
  RiggVar.App.Main;

{ TSolidSide }

constructor TSolidSide.Create(AOwner: TComponent);
begin
  inherited;
  WrapMode := TMeshWrapMode.Original;
  TwoSide := True;
  HitTest := False;

  CenterPointInsetZ := 10;

  SetLength(PointBorder, 2);
end;

function TSolidSide.InjectedBorderOK: Boolean;
begin
  result := OuterBorder <> nil;
end;

function TSolidSide.FindCenterPoint: TPoint3D;
var
  l: Integer;
  P1, P2: TPoint3D;
begin
  result := TPoint3D.Zero;
  l := Length(InnerBorder);
  if l >= 2 then
  begin
    P1 := InnerBorder[0];
    P2 := InnerBorder[l-1];
    result := P1.MidPoint(P2);
  end;
end;

procedure TSolidSide.InitCombiBorder;
var
  i, j, l1, l2, l: Integer;
begin
  l1 := Length(OuterBorder);
  l2 := Length(InnerBorder);
  l := l1 + l2 - 1;

  SetLength(CombiBorder, l);

  for i := 0 to l1 - 2 do
    CombiBorder[i] := OuterBorder[i];

  j := l1 - 2;
  for i := l2 - 1 downto 0 do
  begin
    Inc(j);
    CombiBorder[j] := InnerBorder[i];
  end;
end;

procedure TSolidSide.RebuildMesh;
var
  mb: TBandBuilder;
  cp: TPoint3D;
  z: single;
begin
  if MeshBuilder <> nil then
    MeshBuilder.Free;

  mb := TBandBuilder.Create;

  mb.WantTexCoord := True;
  mb.WantNormals := False;

  cp := FindCenterPoint;
  z := CapValue - CenterPointInsetZ;

  if IsSouth then
    PointBorder[0] := TPoint3D.Create(cp.X, (Main.vp.Range + Main.vp.OffsetY), z);

  if IsNorth then
    PointBorder[0] := TPoint3D.Create(cp.X, -(Main.vp.range - Main.vp.OffsetY), z);

  if IsWest then
    PointBorder[0] := TPoint3D.Create(-(Main.vp.range - Main.vp.OffsetX), cp.Y, z);

  if IsEast then
    PointBorder[0] := TPoint3D.Create((Main.vp.range + Main.vp.OffsetX), cp.Y, z);

  PointBorder[1] := PointBorder[0];

  if InjectedBorderOK then
  begin
    InitCombiBorder;
    mb.AddFederBand(CombiBorder, PointBorder, IsSouth or IsEast);
  end;

  if WantScreenRender then
  begin
    mb.Update3DBuffers(Data.VertexBuffer, Data.IndexBuffer);
    Data.CalcFaceNormals;
  end;

  MeshBuilder := mb;
end;

{ TSolidPart }

constructor TSolidPart.Create(AOwner: TComponent);
begin
  inherited;

  FMP := TMaterialPool.Create;

  FDoubleSided := True;

  InitDefault;
end;

destructor TSolidPart.Destroy;
begin
  FMP.Free;
  inherited;
end;

procedure TSolidPart.Init;
begin
  inherited;

  FInnerMaterialSource := FMP.ColorMaterialSources.GetMaterialSource(FInnerColor);
  FNorthMaterialSource := FMP.ColorMaterialSources.GetMaterialSource(FNorthColor);
  FSouthMaterialSource := FMP.ColorMaterialSources.GetMaterialSource(FSouthColor);
  FWestMaterialSource := FMP.ColorMaterialSources.GetMaterialSource(FWestColor);
  FEastMaterialSource := FMP.ColorMaterialSources.GetMaterialSource(FEastColor);

  { Outer Shell }

  Outer := Main.Outer;
  Outer.Name := 'Outer';
  Inner := Main.Inner;
  Inner.Name := 'Inner';

  Outer.BB.CapValue := Outer.CapValue;
  Outer.InitBorder;

  { Inner Shell = BottomCap }

  Inner.BB.Flatten := True;
  Inner.BB.CapValue := Inner.CapValue;
  Inner.Color := FInnerColor;
  Inner.MaterialSource := FInnerMaterialSource;
  Inner.InitBorder;
  Inner.Visible := Main.SolidPartVisible;

  { NorthSide }

  NorthSide := TSolidSide.Create(Self);
  NorthSide.Parent := Self;
  NorthSide.IsNorth := True;
  NorthSide.Name := 'NorthSide';

  NorthSide.OuterBorder := Outer.BorderNorth;
  NorthSide.InnerBorder := Inner.BorderNorth;

  NorthSide.InitData;
  NorthSide.Color := FNorthColor;
  NorthSide.MaterialSource := FNorthMaterialSource;
  NorthSide.UpdateScale;

  { SouthSide }

  SouthSide := TSolidSide.Create(Self);
  SouthSide.Parent := Self;
  SouthSide.IsSouth := True;
  SouthSide.Name := 'SouthSide';

  SouthSide.OuterBorder := Outer.BorderSouth;
  SouthSide.InnerBorder := Inner.BorderSouth;

  SouthSide.InitData;
  SouthSide.Color := FSouthColor;
  SouthSide.MaterialSource := FSouthMaterialSource;
  SouthSide.UpdateScale;

  { WestSide }

  WestSide := TSolidSide.Create(Self);
  WestSide.Parent := Self;
  WestSide.IsWest := True;
  WestSide.Name := 'WestSide';

  WestSide.OuterBorder := Outer.BorderWest;
  WestSide.InnerBorder := Inner.BorderWest;

  WestSide.InitData;
  WestSide.Color := FWestColor;
  WestSide.MaterialSource := FWestMaterialSource;
  WestSide.UpdateScale;

  { EastSide }

  EastSide := TSolidSide.Create(Self);
  EastSide.Parent := Self;
  EastSide.IsEast := True;
  EastSide.Name := 'EastSide';

  EastSide.OuterBorder := Outer.BorderEast;
  EastSide.InnerBorder := Inner.BorderEast;

  EastSide.InitData;
  EastSide.Color := FEastColor;
  EastSide.MaterialSource := FEastMaterialSource;
  EastSide.UpdateScale;
end;

procedure TSolidPart.InitDefault;
begin
  FOuterColor := claBlack;
  FInnerColor := claFuchsia;
  FNorthColor := claLime;
  FSouthColor := claYellow;
  FWestColor := claOrange;
  FEastColor := claAquamarine;
end;

procedure TSolidPart.SetDoubleSided(const Value: Boolean);
begin
  FDoubleSided := Value;

  TwoSide := Value;

  Outer.TwoSide := Value;
  Inner.TwoSide := Value;

  NorthSide.TwoSide := Value;
  SouthSide.TwoSide := Value;
  WestSide.TwoSide := Value;
  EastSide.TwoSide := Value;

  Outer.Repaint;
  Inner.Repaint;

  NorthSide.Repaint;
  SouthSide.Repaint;
  WestSide.Repaint;
  EastSide.Repaint;
end;

procedure TSolidPart.SetTestSingleSide(const Value: Boolean);
begin
  Outer.TwoSide := Value;
  Inner.TwoSide := Value;
  NorthSide.TwoSide := Value;
  SouthSide.TwoSide := Value;
  EastSide.TwoSide := Value;
  WestSide.TwoSide := Value;
end;

procedure TSolidPart.SetUniqueMode(const Value: Integer);
begin
  Outer.InitData;
  Outer.Repaint;
end;

procedure TSolidPart.SetWantSideCaps(const Value: Boolean);
begin
  FWantSideCaps := Value;
  NorthSide.Visible := Value;
  SouthSide.Visible := Value;
  EastSide.Visible := Value;
  WestSide.Visible := Value;
end;

procedure TSolidPart.UpdateGroup;
begin
  if Outer = nil then
    Exit;
  if Inner = nil then
    Exit;
  if CapValue < 1 then
    Exit;

  Outer.BB.CapValue := CapValue;
  Outer.InitBorder;

  Inner.BB.CapValue := CapValue;
  Inner.InitBorder;
  Inner.Visible := Main.SolidPartVisible;

  if WantSideCaps then
  begin
    NorthSide.OuterBorder := Outer.BorderNorth;
    NorthSide.InnerBorder := Inner.BorderNorth;
    NorthSide.InitData;

    SouthSide.OuterBorder := Outer.BorderSouth;
    SouthSide.InnerBorder := Inner.BorderSouth;
    SouthSide.InitData;

    WestSide.OuterBorder := Outer.BorderWest;
    WestSide.InnerBorder := Inner.BorderWest;
    WestSide.InitData;

    EastSide.OuterBorder := Outer.BorderEast;
    EastSide.InnerBorder := Inner.BorderEast;
    EastSide.InitData;
  end;
end;

procedure TSolidPart.ExportOBJ(Exporter: TExporterOBJ; StandAlone: Boolean);
  procedure Add(cr: TBuilderMesh; ItemName: string; flipT: Boolean = false);
  begin
    if cr <> nil then
      Exporter.AddMeshData(cr.Data, flipT, cr.ColorName, ItemName);
  end;
var
  LPartName: string;
begin
  if StandAlone then
  begin
    LPartName := MainVar.AppTitle;
    Exporter.Clear;
  end;

  case Exporter.Selector of
    TExportSelector.AllParts:
    begin
      Add(Outer, 'Outer');
      Add(Inner, 'Inner');
      if WantSideCaps then
      begin
        Add(NorthSide, 'North');
        Add(SouthSide, 'South');
        Add(WestSide, 'West');
        Add(EastSide, 'East');
      end;
    end;

    TExportSelector.TopOnly:
    begin
      Add(Outer, 'Outer');
    end;

    TExportSelector.BottomOnly:
    begin
      Add(Inner, 'Inner');
    end;

    TExportSelector.NorthOnly:
    begin
      Add(NorthSide, 'North');
    end;

    TExportSelector.SouthOnly:
    begin
      Add(SouthSide, 'South');
    end;

    TExportSelector.WestOnly:
    begin
      Add(WestSide, 'West');
    end;

    TExportSelector.EastOnly:
    begin
      Add(EastSide, 'East');
    end;

  end;

  if StandAlone then
  begin
    Exporter.SaveToFile(LPartName);
  end;
end;

function TSolidPart.GetCapValue: single;
begin
  result := Main.CapValue;
end;

function TSolidPart.GetMeshSize: Integer;
begin
  result := Main.MeshSize;
end;

function TSolidPart.GetTestSingleSide: Boolean;
begin
  result := Outer.TwoSide;
end;

function TSolidPart.GetUniqueMode: Integer;
begin
  result := MainVar.UniqueMode;
end;

end.

