unit RiggVar.FB.Transform;

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

type
  TTransform2D = class
  public
    NullpunktX: single;
    NullpunktY: single;
    PaintboxZoom: single;
    PaintboxRotation: single;
    procedure Init;
  end;

  TTransform3D = class
  public
    GlobalZoom: single;
    GlobalZoomMin: single;
    GlobalZoomMax: single;
    GlobalZoomSpeed: single;
    GlobalScale: single;
    NormScale: Integer;
    procedure Init;
  end;

implementation

{ Transform3D }

procedure TTransform3D.Init;
begin
  GlobalZoom := 8.0;
  GlobalZoomMin := 1;
  GlobalZoomMax := 25;
  GlobalZoomSpeed := 0.2;
  GlobalScale := 0.06;
  NormScale := 200;
end;

{ TTransform2D }

procedure TTransform2D.Init;
begin
  NullpunktX := 400;
  NullpunktY := 400;
  PaintboxZoom := 1.0;
  PaintboxRotation := 0.0;
end;

end.
