unit RiggVar.Mesh.FederShell1;

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
  System.Classes,
  FMX.Objects3D,
  RiggVar.Mesh.MeshBuilder,
  RiggVar.Mesh.FederMesh,
  RiggVar.FB.Def,
  RiggVar.FB.Equation,
  RiggVar.FB.MeshParams,
  RiggVar.MeshBuilder.BorderBuilder,
  RiggVar.MeshBuilder.BorderBuilder1;

type
  TFederShell1 = class(TFederMesh)
  protected
    procedure RebuildMesh; override;
  public
    BB: TBorderBuilder1;

    BorderNorth: TPoint3DArray;
    BorderSouth: TPoint3DArray;
    BorderWest: TPoint3DArray;
    BorderEast: TPoint3DArray;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitBorder;
  end;

implementation

uses
  RiggVar.App.Main;

{ TFederShell1 }

constructor TFederShell1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  WrapMode := TMeshWrapMode.Original;
  TwoSide := True;
  HitTest := False;

  BB := TBorderBuilder1.Create;
end;

destructor TFederShell1.Destroy;
begin
  BB.Free;
  inherited;
end;

procedure TFederShell1.RebuildMesh;
begin
end;

procedure TFederShell1.InitBorder;
var
  Target: single;
begin
  Target := CapValue;

  BB.PrepareEdges(MeshBuilder, Target);

  BB.InitBorderPoints(TEdgePart.North);
  BorderNorth := BB.BorderArray;

  BB.InitBorderPoints(TEdgePart.South);
  BorderSouth := BB.BorderArray;

  BB.InitBorderPoints(TEdgePart.West);
  BorderWest := BB.BorderArray;

  BB.InitBorderPoints(TEdgePart.East);
  BorderEast := BB.BorderArray;
end;

end.
