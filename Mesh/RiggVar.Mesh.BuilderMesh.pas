unit RiggVar.Mesh.BuilderMesh;

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
  System.Math,
  System.Math.Vectors,
  System.Generics.Collections,
  System.RTLConsts,
  System.UITypes,
  System.UIConsts,
  FMX.Types,
  FMX.Types3D,
  FMX.Objects3D,
  FMX.Materials,
  FMX.Controls3D,
  RiggVar.FB.Def,
  RiggVar.FB.DefConst,
  RiggVar.Mesh.ExporterOBJ,
  RiggVar.Mesh.MeshBuilder;

type
  TBuilderMesh = class(TCustomMesh)
  private
    FMeshBuilder: TMeshBuilderBase;
    FMaterialID: Integer;
    FColor: TAlphaColor;

    procedure SetMeshBuilder(const Value: TMeshBuilderBase);

    function GetCapValue: single;
    function GetColorName: string;
    function GetOffsetY: single;
  protected
    procedure RebuildMesh; virtual;
    procedure Render; override;
    procedure DrawWireFrame(const Opacity: Single; const Color: TAlphaColor);
  public
    WantScreenRender: Boolean;
    HideFromExport: Boolean;
    SX, SY: single;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Data;

    procedure InitData;
    procedure ForceRebuild;

    procedure UpdateScale(WantPositionZ: Boolean = False);

    procedure ExportOBJ(Exporter: TExporterOBJ; flipT: Boolean; StandAlone: Boolean; PartName: string); virtual;
    procedure UpdateMeshProps;

    property MeshBuilder: TMeshBuilderBase read FMeshBuilder write SetMeshBuilder;

    property OffsetY: single read GetOffsetY;
    property CapValue: single read GetCapValue;
    property Color: TAlphaColor read FColor write FColor;
    property ColorName: string read GetColorName;
    property MaterialID: Integer read FMaterialID write FMaterialID;
  end;

  TBuilderMeshList = TList<TBuilderMesh>;

  TFederGroup = class(TDummy)
  public
    procedure ExportOBJ(Exporter: TExporterOBJ; StandAlone: Boolean); virtual;
    procedure UpdateMeshList(ML: TBuilderMeshList);
  end;

implementation

uses
  RiggVar.App.Main;

{ TBuilderMesh }

constructor TBuilderMesh.Create(AOwner: TComponent);
begin
  WantScreenRender := True;
  FColor := claWhite;
  inherited;
end;

destructor TBuilderMesh.Destroy;
begin
  FMeshBuilder.Free;
  inherited;
end;

procedure TBuilderMesh.InitData;
begin
  RebuildMesh;
end;

procedure TBuilderMesh.ForceRebuild;
begin
  RebuildMesh;
  Repaint;
end;

procedure TBuilderMesh.SetMeshBuilder(const Value: TMeshBuilderBase);
begin
  FMeshBuilder := Value;
end;

procedure TBuilderMesh.UpdateMeshProps;
begin
  RebuildMesh;
end;

function TBuilderMesh.GetCapValue: single;
begin
  result := Main.CapValue;
end;

function TBuilderMesh.GetColorName: string;
begin
  result := AlphaColorToString(Color);
end;

function TBuilderMesh.GetOffsetY: single;
begin
  result := Main.vp.OffsetY;
end;

procedure TBuilderMesh.RebuildMesh;
begin
  { virtual }
end;

procedure TBuilderMesh.Render;
begin
  inherited;
  if MainVar.ShowEdges then
  begin
    DrawWireFrame(0.2, claBlue);
  end;
end;

procedure TBuilderMesh.UpdateScale(WantPositionZ: Boolean);
var
  localScale: single;
begin
  localScale := Main.vp.GlobalScale * Main.vp.ModelGroupScale;
  Scale.Point := TPoint3D.Create(1, 1, 1) * localScale;
end;

procedure TBuilderMesh.DrawWireFrame(const Opacity: Single; const Color: TAlphaColor);
var
  Idx: TIndexBuffer;
  Mat: TColorMaterial;
  i, j: Integer;
  c: Integer;
  TriangleCount: Integer;
  cl: Integer;
  i1, i2, i3: Integer;
  WantAll: Boolean;
begin
  WantAll := True; { SkipEverySecondTriangle := not WantAll; }
  Idx := nil;
  Mat := nil;
  try
    c := Data.IndexBuffer.Length;
    TriangleCount := c div 3;
    if WantAll then
    begin
      cl := TriangleCount * 6;
      Idx := TIndexBuffer.Create(cl, TIndexFormat.UInt32);
    end
    else
    begin
      TriangleCount := TriangleCount div 2;
      cl := TriangleCount * 6;
      Idx := TIndexBuffer.Create(cl, TIndexFormat.UInt32);
    end;

    i := 0;
    j := 0;
    while i < c do
    begin
      if WantAll or Odd(i) then
      begin
        i1 := Data.IndexBuffer[i + 0];
        i2 := Data.IndexBuffer[i + 1];
        i3 := Data.IndexBuffer[i + 2];

        Idx[j + 0] := i1;
        Idx[j + 1] := i2;

        Idx[j + 2] := i2;
        Idx[j + 3] := i3;

        Idx[j + 4] := i3;
        Idx[j + 5] := i1;

        Inc(j, 6);
      end;
      Inc(i, 3);
    end;

    Mat := TColorMaterial.Create;
    Mat.Color := Color;
    Context.DrawLines(Data.VertexBuffer, Idx, Mat, Opacity);
  finally
    Idx.Free;
    Mat.Free;
  end;
end;

procedure TBuilderMesh.ExportOBJ(Exporter: TExporterOBJ; flipT: Boolean; StandAlone: Boolean; PartName: string);
begin
  if StandAlone then
  begin
    Exporter.Clear;
    Exporter.AddMeshData(Data, flipT, ColorName);
    Exporter.SaveToFile(PartName);
  end
  else
  begin
    Exporter.AddMeshData(Data, flipT, ColorName);
  end;
end;

{ TFederGroup }

procedure TFederGroup.ExportOBJ(Exporter: TExporterOBJ; StandAlone: Boolean);
begin

end;

procedure TFederGroup.UpdateMeshList(ML: TBuilderMeshList);
var
  cr: TBuilderMesh;
  i: Integer;
  o: TFmxObject;
  g, h: TFederGroup;
  j: Integer;
  k: Integer;
  procedure AddCR;
  begin
    if cr.Visible and (not cr.HideFromExport) then
    begin
      ML.Add(cr);
    end
    else
    begin
      Inc(k);
    end;
  end;

  procedure ProcessGroup;
  var
    k: Integer;
  begin
    for k := 0 to h.ChildrenCount - 1 do
    begin
      o := h.Children[k];
      if o is TBuilderMesh then
      begin
        cr := o as TBuilderMesh;
        AddCR;
      end
    end;
  end;

begin
  k := 0;
  ML.Clear;
  for i := 0 to ChildrenCount - 1 do
  begin
    o := Children[i];
    if o is TBuilderMesh then
    begin
      cr := o as TBuilderMesh;
      AddCR;
    end
    else if o is TFederGroup then
    begin
      g := o as TFederGroup;
      for j := 0 to g.ChildrenCount - 1 do
      begin
        o := g.Children[j];
        if o is TBuilderMesh then
        begin
          cr := o as TBuilderMesh;
          AddCR;
        end
        else if o is TFederGroup then
        begin
          h := o as TFederGroup;
          ProcessGroup;
        end;
      end;
    end;
  end;
end;

end.
