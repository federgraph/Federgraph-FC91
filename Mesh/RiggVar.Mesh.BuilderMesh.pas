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
  FMX.Controls3D;

type
  TBuilderMesh = class(TCustomMesh)
  protected
    procedure Render; override;
    procedure DrawWireFrame(const Opacity: Single; const Color: TAlphaColor);
  public
    ShowEdges: Boolean;
    property Data;
  end;

implementation

{ TBuilderMesh }

procedure TBuilderMesh.Render;
begin
  inherited;
  if ShowEdges then
  begin
    DrawWireFrame(0.2, claBlue);
  end;
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
begin
  Idx := nil;
  Mat := nil;
  try
    c := Data.IndexBuffer.Length;
    TriangleCount := c div 3;
    cl := TriangleCount * 6;
    Idx := TIndexBuffer.Create(cl, TIndexFormat.UInt32);
    i := 0;
    j := 0;
    while i < c do
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

end.
