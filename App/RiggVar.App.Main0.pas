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

uses
  FMX.Types,
  FMX.MaterialSources,
  RiggVar.FB.Def,
  RiggVar.FB.Equation,
  RiggVar.FB.MeshParams,
  RiggVar.Mesh.FederShell1,
  RiggVar.Mesh.MeshBuilder,
  RiggVar.Mesh.SolidPart,
  RiggVar.FederModel.Material,
  RiggVar.FederModel.MaterialSources;

type
  TMain0 = class
  private
    function GetMeshBuilder: TFederMeshBuilder;
    procedure InitData(Sender: TObject);
    procedure UpdateVP;
    function GetMaterialSource: TMaterialSource;
  public
    FederParam: TFederParam;
    InitDataOK: Boolean;
    MaterialPool: TMaterialPool;
    FederMaterial: TFederMaterial;
    ExportCoords: TExportCoords;
    CapValue: single;
    MeshSize: Integer;
    vp: TMeshParams;
    SolidPartVisible: Boolean;
    SolidPart: TSolidPart;
    Outer: TFederShell1;
    Inner: TFederShell1;
    CurrentRing: Integer;
    LoopFaktor: single;
    EQ: TFederEquation;
    IsOrthoProjection: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure AddMeshesToScene(ModelParent: TFmxObject);
    procedure GraphUpdateNeeded;
    procedure UpdateCurrentRing(TexCoordY: single);
    property FederMesh: TFederShell1 read Outer;
    property MeshBuilder: TFederMeshBuilder read GetMeshBuilder;
    property MaterialSource: TMaterialSource read GetMaterialSource;
  end;

implementation

uses
  FrmMain,
  RiggVar.App.Main;

{ TMain0 }

constructor TMain0.Create;
begin
  Main := self;

  SolidPartVisible := True;
  CapValue := 60;
  MeshSize := 128;
  LoopFaktor := 0;
  FederParam := fpCZ;

  FederMaterial := TFederMaterial.Create(False);
  MaterialPool := TMaterialPool.Create;

  EQ := TFederEquation.Create;
  vp := TMeshParams.Create(EQ);

  Outer := TFederShell1.Create(FormMain);
  Outer.MeshParams := vp;
  Outer.WantFlippedHands := True;

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
  SolidPart.WantSideCaps := True;

  InitData(nil);
end;

destructor TMain0.Destroy;
begin
  Outer.Free;
  Inner.Free;
  SolidPart.Free;

  vp.Free;

  FederMaterial.Free;
  MaterialPool.Free;
  EQ.Free;
  inherited;
end;

function TMain0.GetMaterialSource: TMaterialSource;
begin
  result := FederMaterial.MaterialSource;
end;

function TMain0.GetMeshBuilder: TFederMeshBuilder;
begin
  result := FederMesh.FederMeshBuilder;
end;

procedure TMain0.GraphUpdateNeeded;
begin

end;

procedure TMain0.UpdateCurrentRing(TexCoordY: single);
begin

end;

procedure TMain0.UpdateVP;
begin
  vp.range := 120;

  vp.ox := 0;
  vp.oy := -30;
  vp.oz := 0;

  vp.mc :=  128;

  vp.ReducedMesh := True;
  vp.ReduceMode := 0;

  vp.CapValue := CapValue;

  vp.GlobalScale := 0.06;
  vp.ModelGroupScale := 1;

  vp.T1 := 0;
  vp.T2 := 180;

  vp.MinusCap := False;
  vp.PlusCap := True;

  vp.Update;
end;

procedure TMain0.AddMeshesToScene(ModelParent: TFmxObject);
begin
  ModelParent.AddObject(FederMesh);
  ModelParent.AddObject(Inner);
  ModelParent.AddObject(SolidPart);
end;

procedure TMain0.InitData(Sender: TObject);
begin
//  If not IsUp then
//    Exit;

//  StopWatch.Start;

  UpdateVP;

  if InitDataOK and (FederParam in [fpt1, fpt2, fpBandWidth]) then
  begin
    FederMesh.UpdateColor;
  end
  else
  begin
    vp.PlusCap := True;
    vp.ReducedMesh := True;
    vp.WantZeroPulling := MeshBuilder.WantZeroPulling;
    vp.WantSlicePulling := MeshBuilder.WantSlicePulling;
    vp.SlicePullingMode := MeshBuilder.SlicePullingMode;
    vp.ReduceMode := MeshBuilder.ReduceMode;
    vp.WantFlippedHands := FederMesh.WantFlippedHands;
    vp.WantMirroredBottom := False;
    vp.WantUniqueVertices := True;
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

//  StopWatch.Stop;
//  InitDataMillies := StopWatch.ElapsedMilliseconds;

//  Inc(CounterInitData);
  GraphUpdateNeeded;
end;

end.
