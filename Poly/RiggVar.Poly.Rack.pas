unit RiggVar.Poly.Rack;

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
  System.Generics.Collections,
  System.Types,
  System.UIConsts,
  System.UITypes,
  System.Math,
  System.Math.Vectors,
  RiggVar.FB.Def;

type
  { forward declaration }
  TPolyRack = class;

  TPolyRadBase = class
  private
    FRack: TPolyRack;
    FMode: Integer;
    FCurveSet: Integer;
    procedure SetCurveSet(const Value: Integer);
    procedure SetMode(const Value: Integer);
    function GetCurrentCapValue: single;
    function GetCurrentMode: Integer;
    function GetWantPolyTrim: Boolean;
  protected
    CapValue: single;
    TargetDiff: single;
    LoopMax: Integer;

    PointCount: Integer;
    PolyCount: Integer;

    Count: Integer;
    Index: Integer;
    CurrentColor: TAlphaColor;
    CapValueFlipFactor: single;

    BangoCounter: Integer;
    BengoCounter: Integer;
    BingoCounter: Integer;
    BongoCounter: Integer;
    BungoCounter: Integer;
    CounterMax: Integer;

    procedure Bango;
    procedure Bengo;
    procedure Bingo;
    procedure Bongo;
    procedure Bungo;

    procedure AddOnlyOne;
    procedure AddCurve(AZ: single);
    procedure AddCurves(AMin, AMax, AStep: Integer);
  public
    FR: TRectF;
    Curves: TPolyCurveArray;
    Valid: Boolean;

    class var ColorScheme: Integer;

    function GetColorI(i: Integer): TAlphaColor;
    function GetColorZ(AZ: single): TAlphaColor;
    function GetBounds: TRectF;
    function GetBoundsRect: TRect;
    function TryGetPoly: TPolygonListArray;

    constructor Create(ARack: TPolyRack; AMode: Integer; ACurveSet: Integer = 0);
    destructor Destroy; override;

    procedure Clear;
    procedure Empty;
    function IsInRange: Boolean; virtual; abstract;
    procedure Compute; virtual; abstract;
    procedure AddReport(SL: TStrings); virtual; abstract;
    procedure Configure; virtual;
    function Contains(AP: TPointF): Boolean; virtual; abstract;

    function GetColor(i: Integer; AZ: single): TAlphaColor;
    property Mode: Integer read FMode write SetMode;
    property CurveSet: Integer read FCurveSet write SetCurveSet;

    property CurrentCapValue: single read GetCurrentCapValue;
    property CurrentMode: Integer read GetCurrentMode;
    property WantPolyTrim: Boolean read GetWantPolyTrim;
  end;

  TPolyRadList = TList<TPolyRadBase>;

  TPolyRack = class
  private
    FEmptyPolygonList: TPolygonListArray;
    FCurrentMode: Integer;
    FCurrentSet: Integer;
    FColorScheme: Integer;
    procedure SetCurrentMode(const Value: Integer);
    procedure SetColorScheme(const Value: Integer);
    procedure SetCurrentSet(const Value: Integer);
    function GetCurrentPoly: TPolyRadBase;
    function GetCurveCount: Integer;
    function GetRodPolyEnabled: Boolean;
  public
    Name: string;
    Poly1: TPolyRadBase;
    Poly2: TPolyRadBase;
    PolyRadList: TPolyRadList;
    RodPoly: TPolygonListArray;
    constructor Create(ACurveSet: Integer);
    destructor Destroy; override;
    procedure Empty;
    procedure Compute;
    function TryGetPoly(i: Integer): TPolygonListArray;
    function GetBoundsF: TRectF;
    function GetBounds: TRect;
    function GetNamePart: string;
    procedure AddReport(SL: TStrings);
    function GetColorI(i: Integer): TAlphaColor;
    function GetColorZ(AZ: single): TAlphaColor;
    property CurrentPoly: TPolyRadBase read GetCurrentPoly;
    property CurrentSet: Integer read FCurrentSet write SetCurrentSet;
    property CurrentMode: Integer read FCurrentMode write SetCurrentMode;
    property ColorScheme: Integer read FColorScheme write SetColorScheme;
    property CurveCount: Integer read GetCurveCount;
    property RodPolyEnabled: Boolean read GetRodPolyEnabled;
  end;

implementation

uses
  FrmMain, //  RiggVar.App.Main,
  RiggVar.Poly.Rad;

{ TPolyRadBase }

constructor TPolyRadBase.Create(ARack: TPolyRack; AMode: Integer; ACurveSet: Integer);
begin
  FRack := ARack;
  FMode := AMode;
  FCurveSet := ACurveSet;
  ColorScheme := 1;
end;

destructor TPolyRadBase.Destroy;
begin
  Clear;
  inherited;
end;

procedure TPolyRadBase.Clear;
var
  i: Integer;
begin
  for i := 0 to Length(Curves) - 1 do
    Curves[i].Poly.Free;
  SetLength(Curves, 0);
end;

procedure TPolyRadBase.Empty;
var
  i: Integer;
begin
  for i := 0 to Length(Curves) - 1 do
    Curves[i].Poly.Clear;
end;

procedure TPolyRadBase.Configure;
begin
  Clear;
end;

function TPolyRadBase.GetColorI(i: Integer): TAlphaColor;
begin
  result := FRack.GetColorI(i);
end;

function TPolyRadBase.GetColorZ(AZ: single): TAlphaColor;
begin
  result := FRack.GetColorZ(AZ);
end;

function TPolyRadBase.GetCurrentCapValue: single;
begin
  result := 0;
end;

function TPolyRadBase.GetCurrentMode: Integer;
begin
  result := FRack.CurrentMode;
end;

function TPolyRadBase.GetWantPolyTrim: Boolean;
begin
  result := True;
end;

function TPolyRadBase.GetColor(i: Integer; AZ: single): TAlphaColor;
begin
  case ColorScheme of
    0: result := GetColorI(i);
    1: result := GetColorZ(AZ);
    else
      result := claBlack;
  end;
end;

procedure TPolyRadBase.SetCurveSet(const Value: Integer);
begin
  FCurveSet := Value;
  Configure;
end;

procedure TPolyRadBase.SetMode(const Value: Integer);
begin
  FMode := Value;
  Configure;
end;

function TPolyRadBase.TryGetPoly: TPolygonListArray;
begin
  result := FRack.FEmptyPolygonList;
  if Valid then
  begin
    if Length(Curves) > 0 then
      result := Curves[0].Poly;
  end;
end;

procedure TPolyRadBase.AddOnlyOne;
var
  z: single;
begin
  Index := 0;
  Count := 1;
  SetLength(Curves, Count);

  z := 12; // will be set to CurrentCapValue later, before use in computation;
  CurrentColor := GetColor(Index, z);
  AddCurve(z);
end;

procedure TPolyRadBase.AddCurve(AZ: single);
var
  cr: TPolyCurve;
begin
  if Index >= Count then
    Exit;

  cr.AZ := AZ * CapValueFlipFactor;
  cr.Mode := Mode;
  cr.CurveSet := CurveSet;
  cr.Color := CurrentColor;
  cr.CurveNo := Index;
  cr.Poly := TPolygonListArray.Create(3000, TPointF.Zero);
  Curves[Index] := cr;

  Inc(Index);
end;

procedure TPolyRadBase.AddCurves(AMin, AMax, AStep: Integer);
var
  i: Integer;
  c: Integer;
  z: Integer;
begin
  { count number of curves }
  c := 0;
  z := AMin;
  while z <= AMax do
  begin
    z := z + AStep;
    Inc(c);
  end;

  { set length of dynamic array }
  Index := 0;
  Count := c;
  SetLength(Curves, Count);

  { add curves }
  i := 0;
  z := AMin;
  while z <= AMax do
  begin
    CurrentColor := GetColor(i, z);
    AddCurve(z);
    z := z + AStep;
    Inc(i);
  end;
end;

procedure TPolyRadBase.Bango;
begin
  Inc(BangoCounter);
end;

procedure TPolyRadBase.Bengo;
begin
  Inc(BengoCounter);
end;

procedure TPolyRadBase.Bingo;
begin
  Inc(BingoCounter);
end;

procedure TPolyRadBase.Bongo;
begin
  Inc(BongoCounter);
end;

procedure TPolyRadBase.Bungo;
begin
  Inc(BungoCounter);
end;

function TPolyRadBase.GetBounds: TRectF;
var
  i, j: integer;
  l, t, r, b: single;
  cl: TPolygonListArray;
  p: TPointF;
begin
  l := MaxInt;
  t := MaxInt;
  r := -MaxInt;
  b := -MaxInt;
  for i := 0 to Count - 1 do
  begin
    cl := Curves[i].Poly;
    for j := 0 to cl.Count - 1 do
    begin
      p := cl[j];
      if p.x < l then
        l := p.x;
      if p.x > r then
        r := p.x;
      if p.y < t then
        t := p.y;
      if p.y > b then
        b := p.y;
    end;
  end;
  if r < l then
    result := TRectF.Empty
  else
    result := TRectF.Create(l, t, r, b);
end;

function TPolyRadBase.GetBoundsRect: TRect;
var
  recF: TRectF;
begin
  recF := GetBounds;
  Result.Left := Floor(recF.Left);
  Result.Top := Floor(recF.Top);
  Result.Right := Ceil(recF.Right);
  Result.Bottom := Ceil(recF.Bottom);
end;

{ TPolyRack }

procedure TPolyRack.Empty;
begin
  Poly1.Empty;
  Poly2.Empty;
end;

procedure TPolyRack.Compute;
begin
  Poly1.Compute;
  Poly2.Compute;
end;

constructor TPolyRack.Create(ACurveSet: Integer);
begin
  inherited Create;

  FEmptyPolygonList := TPolygonListArray.Create(0, TPointF.Zero);

  PolyRadList := TPolyRadList.Create;

  RodPoly := TPolygonListArray.Create(3000, TPointF.Zero);

  Poly1 := TPolyRad.Create(Self, 1, ACurveSet);
  Poly2 := TPolyRad.Create(Self, 2, ACurveSet);

  PolyRadList.Add(Poly1);
  PolyRadList.Add(Poly2);

  FCurrentSet := ACurveSet;
  FCurrentMode := 0;
  FColorScheme := 1;
end;

destructor TPolyRack.Destroy;
begin
  FEmptyPolygonList.Free;

  Poly1.Free;
  Poly2.Free;

  PolyRadList.Free;

  RodPoly.Free;
  inherited;
end;

procedure TPolyRack.SetColorScheme(const Value: Integer);
var
  i: Integer;
  cr: TPolyRadBase;
begin
  FColorScheme := Value;
  TPolyRadBase.ColorScheme := Value;
  for i := 0 to PolyRadList.Count - 1 do
  begin
    cr := PolyRadList[i];
    cr.Configure;
    cr.Compute;
  end;
end;

procedure TPolyRack.SetCurrentMode(const Value: Integer);
var
  i: Integer;
  cr: TPolyRadBase;
begin
  FCurrentMode := Value;
  if CurrentMode = 0 then
  begin
    for i := 0 to PolyRadList.Count - 1 do
    begin
      cr := PolyRadList[i];
      cr.Compute;
    end;
  end
  else
  begin
    cr := CurrentPoly;
    cr.Compute;
  end;
end;

procedure TPolyRack.SetCurrentSet(const Value: Integer);
var
  i: Integer;
  cr: TPolyRadBase;
begin
  FCurrentSet := Value;
  for i := 0 to PolyRadList.Count - 1 do
  begin
    cr := PolyRadList[i];
    cr.CurveSet := Value;
    cr.Configure;
    cr.Compute;
  end;
end;

function TPolyRack.TryGetPoly(i: Integer): TPolygonListArray;
begin
  case i of
    0: result := RodPoly;
    1: result := Poly1.TryGetPoly;
    2: result := Poly2.TryGetPoly;
    else result := FEmptyPolygonList;
  end;
end;

function TPolyRack.GetBoundsF: TRectF;
var
  i: Integer;
  cr: TPolyRadBase;
  rf: TRectF;
begin
  result := TRectF.Empty;
  for i := 0 to PolyRadList.Count-1 do
  begin
    cr := PolyRadList[i];
    rf := cr.GetBounds;
    if i = 0 then
      result := rf
    else
      result.Union(rf);
  end;
end;

function TPolyRack.GetBounds: TRect;
var
  recF: TRectF;
begin
  recF := GetBoundsF;
  Result.Left := Floor(recF.Left);
  Result.Top := Floor(recF.Top);
  Result.Right := Ceil(recF.Right);
  Result.Bottom := Ceil(recF.Bottom);
end;

function TPolyRack.GetCurveCount: Integer;
var
  i: Integer;
  cr: TPolyRadBase;
begin
  result := 0;
  for i := 0 to PolyRadList.Count-1 do
  begin
    cr := PolyRadList[i];
    result := result + cr.Count;
  end;
end;

function TPolyRack.GetCurrentPoly: TPolyRadBase;
begin
  case CurrentMode of
    1: result := Poly1;
    2: result := Poly2;
    else
      result := Poly1;
  end;
end;

function TPolyRack.GetNamePart: string;
begin
  if CurrentSet = 0 then
    result := Format('S%d-Z%.2d', [CurrentSet, Round(FormMain.MeshParams.CapValue)])
  else
    result := Format('M%d-S%d', [CurrentMode, CurrentSet]);
end;

function TPolyRack.GetRodPolyEnabled: Boolean;
begin
  result := (CurrentSet = 0) and (CurrentMode = 0);
end;

procedure TPolyRack.AddReport(SL: TStrings);
var
  r: TRect;
begin
  r := GetBounds;
//SL.Add(Format('Name = %s', [Name]));
//SL.Add(Format('CurrentMode = %d', [CurrentMode]));
//SL.Add(Format('CurrentSet = %d', [CurrentSet]));
//SL.Add(Format('CurveCount = %d', [CurveCount]));
//SL.Add(Format('Bounds = (%d, %d) (%d, %d)', [r.Left, r.Top, r.Right, r.Bottom]));
  SL.Add(Format('Size = (%d, %d)', [r.Width, r.Height]));
end;

function TPolyRack.GetColorI(i: Integer): TAlphaColor;
var
  cla: TAlphaColor;
begin
  case i mod 20 of
    0: cla := claRed;
    1: cla := claDodgerblue;
    2: cla := claAqua;
    3: cla := claWhite;
    4: cla := claYellow;
    5: cla := claLime;
    6: cla := claPlum;
    7: cla := claFuchsia;

    8: cla := claGold;
    9: cla := claChocolate;
    10: cla := claLavender;
    11: cla := claSilver;
    12: cla := claCoral;
    13: cla := claBlueviolet;
    14: cla := claOrange;
    15: cla := claTomato;

    16: cla := claViolet;
    17: cla := claWheat;
    18: cla := claBeige;
    19: cla := claTeal;
    else
      cla := FormMain.claBackground;
  end;
  result := cla;
end;

function TPolyRack.GetColorZ(AZ: single): TAlphaColor;
var
  z: Integer;
begin
  z := Round(Abs(AZ));

  result := claSilver;
  if z = 0 then
    result := claLime
  else if z mod 10 = 0 then
    result := claRed
  else if z mod 5 = 0 then
    result := claAqua;
end;

end.
