unit RiggVar.App.Main;

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
  RiggVar.FB.Transform,
  RiggVar.App.Main0;

type
  TMain = TMain0;

var
  Main: TMain;

type
//  MainConst = class
//  public const
//    ModelScale: single = 5.0;
//  end;

  MainVar = class
  public class var
    AppTitle: string;
    Transform3D: TTransform3D;
    ShowEdges: Boolean;
    UniqueMode: Integer;
    WantAutoFolder: Boolean;

    class constructor Create;
    class destructor Destroy;
  end;

implementation

{ MainVar }

class constructor MainVar.Create;
begin
  AppTitle := 'FC91R'; // sometimes initialized in FormMain, from Application.Title set in dpr
  ShowEdges := True;
  Transform3D := TTransform3D.Create;
  Transform3D.Init;
end;

class destructor MainVar.Destroy;
begin
  Transform3D.Free;

  inherited;
end;

end.
