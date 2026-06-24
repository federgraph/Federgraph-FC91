unit RiggVar.FB.Formula;

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
  TFederFormulaBase = class
  private
    FModelID: Integer;
  protected
    FSpringCount: Integer;
  public
    rmin: single;
    rmax: single;
    constructor Create(AModelID: Integer = 1); virtual;
    function GetValueN(x, y: single): single; virtual;
    function GetValueL(x, y: single): single; virtual;
    function GetValue(x, y: single): single; virtual;
    procedure PrepareCalc; virtual;
    function TakesAbsolute: Boolean; virtual;
    function GetBasisPlot: Integer; virtual;
    property SpringCount: Integer read FSpringCount write FSpringCount;
    property ModelID: Integer read FModelID;
  end;

implementation

constructor TFederFormulaBase.Create(AModelID: Integer = 1);
begin
  FModelID := AModelID;
  FSpringCount := 3;
end;

procedure TFederFormulaBase.PrepareCalc;
begin
  { virtual, do nothing here }
end;

function TFederFormulaBase.GetValueN(x, y: single): single;
begin
  result := GetValue(x, y);
end;

function TFederFormulaBase.GetValue(x, y: single): single;
begin
  result := sqr(x) * sqr(y);
end;

function TFederFormulaBase.GetValueL(x, y: single): single;
begin
  result := GetValue(x, y);
end;

function TFederFormulaBase.TakesAbsolute: Boolean;
begin
  result := False;
end;

function TFederFormulaBase.GetBasisPlot: Integer;
begin
  result := 0;
end;

end.
