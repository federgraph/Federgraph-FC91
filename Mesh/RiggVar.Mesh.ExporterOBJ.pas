unit RiggVar.Mesh.ExporterOBJ;

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
  System.IOUtils,
  System.Math.Vectors,
  System.RTLConsts,
  System.Types,
  System.UITypes,
  System.UIConsts,
  FMX.Dialogs,
  FMX.Types3D,
  FMX.Objects3D,
  FMX.Forms,
  RiggVar.FB.Color,
  RiggVar.FB.Def,
  System.Generics.Defaults,
  System.Generics.Collections,
  System.Hash;

type
  TPoint3DKey = record
  public
    X: Integer;
    Y: Integer;
    Z: Integer;
    constructor Create(APoint3D: TPoint3D);
    class operator Equal(const APoint1, APoint2: TPoint3DKey): Boolean; inline;
    class operator NotEqual(const APoint1, APoint2: TPoint3DKey): Boolean; inline;
    function EqualsTo(const APoint: TPoint3DKey): Boolean; inline;
  end;

  TPointe3DKeyComparer = class(TInterfacedObject, IEqualityComparer<TPoint3DKey>)
  public
    function Equals(const Left, Right: TPoint3DKey): Boolean; reintroduce;
    function GetHashCode(const Value: TPoint3DKey): Integer; reintroduce;
  end;

  TPoint2DKey = record
  public
    U: Integer;
    V: Integer;
    constructor Create(APoint2D: TPointF);
    class operator Equal(const APoint1, APoint2: TPoint2DKey): Boolean; inline;
    class operator NotEqual(const APoint1, APoint2: TPoint2DKey): Boolean; inline;
    function EqualsTo(const APoint: TPoint2DKey): Boolean; inline;
  end;

  TPoint2DKeyComparer = class(TInterfacedObject, IEqualityComparer<TPoint2DKey>)
  public
    function Equals(const Left, Right: TPoint2DKey): Boolean; reintroduce;
    function GetHashCode(const Value: TPoint2DKey): Integer; reintroduce;
  end;

  TUniquePositions = TDictionary<TPoint3DKey, Integer>;
  TUniqueUVs = TDictionary<TPoint2DKey, Integer>;
  TUniqueNormals = TDictionary<TPoint3DKey, Integer>;

  TExporterOBJ = class
  private
    FSaveDialog: TSaveDialog;
    FObjDigits: Integer;

    FName: string;
    FMaterialName: string;
    FItemName: string;

    PL: TStringList;
    NL: TStringList;
    TL: TStringList;
    FL: TStringList;
    ML: TStringList;

    Positions: TUniquePositions;
    UVs: TUniqueUVs;
    Normals: TUniqueNormals;

    AccumulatedTriangleCount: Integer;
    DegeneratedTriangleCount: Integer;

    FormatStringP: string;
    FormatStringN: string;
    FormatStringT: string;

    function GetName: string;
    function GetDirectoryName: string;
    function GetValueFormatString(s: string; i: Integer): string;

    procedure SetObjDigits(const Value: Integer);

    function AddPosition(P: TPoint3D): Integer;
    function AddNormal(P: TPoint3D): Integer;
    function AddUV(P: TPointF): Integer;

    procedure Update(VB: TVertexBuffer; IB: TIndexBuffer; Flip: Boolean = False);
    procedure UpdateML;
    procedure InitMTL2(AML: TStrings);
    procedure AddLine(SL: TStringList; fs: string; P: TPoint3D; Offset: single = 0);
    procedure UpdateFormatString;
  protected
    function CalcNormals(P1, P2, P3: TPoint3D): TPoint3D;

    function GetIndexP(v: TPoint3D): Integer;
    function GetIndexN(n: TPoint3D): Integer;
    function GetIndexT(t: TPointF): Integer;
  public
    InitialCapacity: Integer;
    WantMaterial: Boolean;
    WantSimpleName: Boolean;
    WantAngularDir: Boolean;
    WantNormals: Boolean;
    WantUVs: Boolean;
    Selector: TExportSelector;

    class var
    DigitScale: Integer;

    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    procedure AddMeshData(Data: TMeshData; Flip: Boolean = False); overload;
    procedure AddMeshData(Data: TMeshData; Flip: Boolean; MaterialName: string; ItemName: string = ''); overload;

    procedure SaveToFile(PartName: string);
    procedure SaveMTL;
    procedure GetMtlText(AML: TStrings);

    procedure AddStats(ML: TStrings);
    property ObjDigits: Integer read FObjDigits write SetObjDigits;
  end;

  TExportableMesh = class(TCustomMesh)
  public
    procedure ExportMesh(Exporter: TExporterOBJ; StandAlone: Boolean; PartName: string);
  end;

implementation

uses
  RiggVar.App.Main;

{ TExportableMesh }

procedure TExportableMesh.ExportMesh(Exporter: TExporterOBJ; StandAlone: Boolean; PartName: string);
begin
  if Visible then
  begin
    if StandAlone then
    begin
      Exporter.Clear;
    end;
    Exporter.AddMeshData(Data);
    if StandAlone then
    begin
      Exporter.SaveToFile(PartName);
    end;
  end;
end;

{ TPoint3DKey }

constructor TPoint3DKey.Create(APoint3D: TPoint3D);
begin
  X := Round(APoint3D.X * TExporterOBJ.DigitScale);
  Y := Round(APoint3D.Y * TExporterOBJ.DigitScale);
  Z := Round(APoint3D.Z * TExporterOBJ.DigitScale);
end;

class operator TPoint3DKey.Equal(const APoint1, APoint2: TPoint3DKey): Boolean;
begin
  result :=
    (APoint1.X = APoint2.X) and
    (APoint1.Y = APoint2.Y) and
    (APoint1.Z = APoint2.Z);
end;

class operator TPoint3DKey.NotEqual(const APoint1, APoint2: TPoint3DKey): Boolean;
begin
  result := not (APoint1 = APoint2);
end;

function TPoint3DKey.EqualsTo(const APoint: TPoint3DKey): Boolean;
begin
  Result := (X = APoint.X) and (Y = APoint.Y) and (Z = APoint.Z);
end;

{ TPoint3DComparer }

function TPointe3DKeyComparer.Equals(const Left, Right: TPoint3DKey): Boolean;
begin
  result := Left = Right;
end;

function TPointe3DKeyComparer.GetHashCode(const Value: TPoint3DKey): Integer;
begin
  result := THashBobJenkins.GetHashValue(Value.X, SizeOf(Integer), 0);
  result := THashBobJenkins.GetHashValue(Value.Y, SizeOf(Integer), result);
  result := THashBobJenkins.GetHashValue(Value.Z, SizeOf(Integer), result);
end;

{ TPoint2DKey }

constructor TPoint2DKey.Create(APoint2D: TPointF);
begin
  U := Round(APoint2D.X * TExporterOBJ.DigitScale);
  V := Round(APoint2D.Y * TExporterOBJ.DigitScale);
end;

class operator TPoint2DKey.Equal(const APoint1, APoint2: TPoint2DKey): Boolean;
begin
  result :=
    (APoint1.U = APoint2.U) and
    (APoint1.V = APoint2.V);
end;

class operator TPoint2DKey.NotEqual(const APoint1, APoint2: TPoint2DKey): Boolean;
begin
  result := not (APoint1 = APoint2);
end;

function TPoint2DKey.EqualsTo(const APoint: TPoint2DKey): Boolean;
begin
  Result := (U = APoint.U) and (V = APoint.V);
end;

{ TPoint2DComparer }

function TPoint2DKeyComparer.Equals(const Left, Right: TPoint2DKey): Boolean;
begin
  result := Left = Right;
end;

function TPoint2DKeyComparer.GetHashCode(const Value: TPoint2DKey): Integer;
begin
  result := THashBobJenkins.GetHashValue(Value.U, SizeOf(Integer), 0);
  result := THashBobJenkins.GetHashValue(Value.V, SizeOf(Integer), result);
end;

{ TExporterOBJ }

constructor TExporterOBJ.Create;
begin
  InitialCapacity := 100000;
  ObjDigits := 2;
  FName := 'federgraph';

  WantMaterial := True;
  WantNormals := False;
  WantUVs := False;

  UpdateFormatString;

  PL := TStringList.Create;
  NL := TStringList.Create;
  TL := TStringList.Create;
  FL := TStringList.Create;
  ML := TStringList.Create;

  Positions := TUniquePositions.Create(InitialCapacity);
  UVs := TUniqueUVs.Create(InitialCapacity);
  Normals := TUniqueNormals.Create(InitialCapacity);
end;

destructor TExporterOBJ.Destroy;
begin
  PL.Free;
  NL.Free;
  TL.Free;
  FL.Free;
  ML.Free;

  Positions.Free;
  UVs.Free;
  Normals.Free;

  FSaveDialog.Free;

  inherited;
end;

function TExporterOBJ.GetValueFormatString(s: string; i: Integer): string;
var
  t: string;
begin
  case DigitScale of
    100000: t := '%5.5f';
    10000: t := '%4.4f';
    1000: t := '%3.3f';
    100: t := '%2.2f';
    10: t := '%1.1f';
  end;
  case i of
    2: result := Format('%s %s %s', [s, t, t]);
    else
      result := Format('%s %s %s %s', [s, t, t, t]);
  end;
end;

procedure TExporterOBJ.AddStats(ML: TStrings);
begin
  ML.Add('');
  ML.Add('--- TExporterOBJ.Stats ---');
  ML.Add('');
  ML.Add(Format('TriangleCount = %d', [AccumulatedTriangleCount]));
  ML.Add(Format('Positions.Count = %d', [Positions.Count]));
  if WantUvs then
  ML.Add(Format('UVs.Count = %d', [UVs.Count]));
  if WantNormals then
  ML.Add(Format('Normals.Count = %d', [Normals.Count]));
end;

procedure TExporterOBJ.Clear;
begin
  AccumulatedTriangleCount := 0;

  FItemName := '';
  FMaterialName := 'White';
  DegeneratedTriangleCount := 0;

  Positions.Clear;
  UVs.Clear;
  Normals.Clear;

  PL.Clear;
  NL.Clear;
  TL.Clear;
  FL.Clear;
  ML.Clear;
end;

function TExporterOBJ.AddPosition(P: TPoint3D): Integer;
var
  k: TPoint3DKey;
begin
  k := TPoint3DKey.Create(P);
  if Positions.ContainsKey(k) then
  begin
    Positions.TryGetValue(k, result);
  end
  else
  begin
    result := Positions.Count + 1;
    Positions.Add(k, result);
    AddLine(PL, FormatStringP, P, Main.CapValue);
  end;
end;

function TExporterOBJ.AddNormal(P: TPoint3D): Integer;
var
  k: TPoint3DKey;
begin
  k := TPoint3DKey.Create(P);
  if Normals.ContainsKey(k) then
  begin
    Normals.TryGetValue(k, result);
  end
  else
  begin
    result := Normals.Count + 1;
    Normals.Add(k, result);
    AddLine(NL, FormatStringN, P);
  end;
end;

procedure TExporterOBJ.AddLine(SL: TStringList; fs: string; P: TPoint3D; Offset: single);
begin
    case Main.ExportCoords of
    TExportCoords.Native:         SL.Add(Format(fs, [P.X,  P.Y,  P.Z]));
    TExportCoords.App_Blender:    SL.Add(Format(fs, [P.X, -P.Z + Offset, P.Y]));
    TExportCoords.App_3D_Viewer: SL.Add(Format(fs, [P.X, -P.Y, P.Z]));
    TExportCoords.App_3D_Printer: SL.Add(Format(fs, [P.X, -P.Y, -P.Z]));
  end;
end;

function TExporterOBJ.AddUV(P: TPointF): Integer;
var
  k: TPoint2DKey;
begin
  k := TPoint2DKey.Create(P);
  if UVs.ContainsKey(k) then
  begin
    UVs.TryGetValue(k, result);
  end
  else
  begin
    result := UVs.Count + 1;
    UVs.Add(k, result);
    TL.Add(Format(FormatStringT, [P.X, P.Y]));
  end;
end;

procedure TExporterOBJ.Update(VB: TVertexBuffer; IB: TIndexBuffer; Flip: Boolean);
var
  TriangleCount: Integer;

  i, j: Integer;
  i1, i2, i3: Integer;
  v1, v2, v3: TPoint3D;
  n1, n2, n3: TPoint3D;
  t1, t2, t3: TPointF;

  IndexP1, IndexP2, IndexP3: Integer;
  IndexN1, IndexN2, IndexN3: Integer;
  IndexT1, IndexT2, IndexT3: Integer;
begin
  IndexT1 := 0;
  IndexT2 := 0;
  IndexT3 := 0;

  IndexN1 := 0;
  IndexN2 := 0;
  IndexN3 := 0;

  TriangleCount := IB.Length div 3;
  if TriangleCount = 0 then
    Exit;

  AccumulatedTriangleCount := AccumulatedTriangleCount + TriangleCount;

  FL.Add('');
  FL.Add(Format('# %s', [FItemName])); // start of new part
  if WantMaterial then
  begin
    FL.Add('usemtl ' + FMaterialName);
  end;

  for i := 0 to TriangleCount - 1 do
  begin
    j := i * 3;

    i1 := IB[j + 0];
    i2 := IB[j + 1];
    i3 := IB[j + 2];

    v1 := VB.Vertices[i1];
    if Flip then
    begin
      v3 := VB.Vertices[i2];
      v2 := VB.Vertices[i3];
    end
    else
    begin
      v2 := VB.Vertices[i2];
      v3 := VB.Vertices[i3];
    end;

    IndexP1 := AddPosition(v1);
    IndexP2 := AddPosition(v2);
    IndexP3 := AddPosition(v3);

    if WantNormals then
    begin
      n1 := CalcNormals(v1, v2, v3);
      n2 := CalcNormals(v2, v3, v1);
      n3 := CalcNormals(v3, v1, v2);

      IndexN1 := AddNormal(n1);
      IndexN2 := AddNormal(n2);
      IndexN3 := AddNormal(n3);
    end;

    if WantUvs then
    begin
      t1 := VB.TexCoord0[i1];
      t2 := VB.TexCoord0[i2];
      t3 := VB.TexCoord0[i3];

      IndexT1 := AddUV(t1);
      IndexT2 := AddUV(t2);
      IndexT3 := AddUV(t3);
    end;

    { filter out degenerated triangles }
    if (IndexP1 = IndexP2) or (IndexP2 = IndexP3) or (IndexP3 = IndexP1) then
    begin
      Inc(DegeneratedTriangleCount);
      Continue;
    end;

    if (WantUVs and WantNormals) then
    begin
      FL.Add(Format('f %d/%d/%d %d/%d/%d %d/%d/%d', [
      IndexP1, IndexT1, IndexN1,
      IndexP2, IndexT2, IndexN2,
      IndexP3, IndexT3, IndexN3
      ]));
    end
    else if (WantNormals and not WantUvs) then
    begin
      FL.Add(Format('f %d//%d %d//%d %d//%d', [
      IndexP1, IndexN1,
      IndexP2, IndexN2,
      IndexP3, IndexN3
      ]));
    end
    else if WantUVs then
    begin
      FL.Add(Format('f %d/%d %d/%d %d/%d', [
      IndexP1, IndexT1,
      IndexP2, IndexT2,
      IndexP3, IndexT3
      ]));
    end
    else
    begin
      FL.Add(Format('f %d %d %d', [
      IndexP1,
      IndexP2,
      IndexP3
      ]));
    end;

  end;
end;

function TExporterOBJ.GetDirectoryName: string;
begin
  result := '';
end;

function TExporterOBJ.GetIndexP(v: TPoint3D): Integer;
begin
  Positions.TryGetValue(TPoint3DKey.Create(v), result);
end;

function TExporterOBJ.GetIndexN(n: TPoint3D): Integer;
begin
  Normals.TryGetValue(TPoint3DKey.Create(n), result);
end;

function TExporterOBJ.GetIndexT(t: TPointF): Integer;
begin
  UVs.TryGetValue(TPoint2DKey.Create(t), result);
end;

procedure TExporterOBJ.UpdateML;
var
  i: Integer;
begin
  if WantMaterial then
  begin
    ML.Add('mtllib federgraph-material.mtl');
    ML.Add('');
  end;

  ML.Add('o federgraph');
  ML.Add('');

  ML.Add(Format('# copyright federgraph.de %d', [CurrentYear]));
  ML.Add(Format('# generated by %s', [Application.Title]));
  ML.Add('');
  ML.Add(Format('# CapValue = %d', [Round(Main.CapValue)]));
  ML.Add(Format('# MeshSize = %d', [Main.MeshSize]));
  ML.Add('');

  ML.Add(Format('# Positions.Count = %d', [Positions.Count]));
  ML.Add(Format('# TriangleCount = %d', [AccumulatedTriangleCount]));
  if DegeneratedTriangleCount > 0 then
  ML.Add(Format('# DegeneratedTriangleCount = %d', [DegeneratedTriangleCount]));

  if WantUVs then
  ML.Add(Format('# UVs.Count = %d', [UVs.Count]));

  if WantNormals then
  ML.Add(Format('# Normals.Count = %d', [Normals.Count]));

  ML.Add('');
  for i := 0 to PL.Count - 1 do
    ML.Add(PL[i]);
  ML.Add(Format('# Positions.Count = %d', [Positions.Count]));

  if WantUvs then
  begin
    ML.Add('');
    for i := 0 to TL.Count - 1 do
      Ml.Add(TL[i]);
    ML.Add(Format('# UVs.Count = %d', [UVs.Count]));
  end;

  if WantNormals then
  begin
  ML.Add('');
    for i := 0 to NL.Count - 1 do
      ML.Add(NL[i]);
    ML.Add(Format('# Normals.Count = %d', [Normals.Count]));
  end;

  ML.Add('');
  for i := 0 to FL.Count - 1 do
    ML.Add(FL[i]);

  ML.Add('');
  ML.Add(Format('# TriangleCount = %d', [AccumulatedTriangleCount]));
end;

procedure TExporterOBJ.SaveToFile(PartName: string);
var
  fn: string;
  dn: string;
  Extension: string;
  CanSave: Boolean;
begin
  UpdateML;

  Extension := '.obj';
  FName := PartName;
  fn := GetName;
  dn := GetDirectoryName;

  if FSaveDialog = nil then
    FSaveDialog := TSaveDialog.Create(nil);
  FSaveDialog.FileName := TPath.Combine(dn, fn) + Extension;

  FSaveDialog.InitialDir := dn;
  CanSave := True;
  if (not MainVar.WantAutoFolder) or (not DirectoryExists(FSaveDialog.InitialDir)) then
    CanSave := FSaveDialog.Execute;

  if CanSave then
    ML.SaveToFile(FSaveDialog.FileName);
end;

procedure TExporterOBJ.SetObjDigits(const Value: Integer);
begin
  if (Value >= 2) and (Value <=5)  then
  begin
    FObjDigits := Value;
    case Value of
      2: DigitScale := 100;
      3: DigitScale := 1000;
      4: DigitScale := 10000;
      5: DigitScale := 100000;
    end;
    UpdateFormatString;
  end;
end;

procedure TExporterOBJ.UpdateFormatString;
begin
  FormatStringP := GetValueFormatString('v', 3);
  FormatStringN := GetValueFormatString('vn', 3);
  FormatStringT := GetValueFormatString('vt', 2);
end;

procedure TExporterOBJ.AddMeshData(Data: TMeshData; Flip: Boolean; MaterialName: string; ItemName: string);
var
  LFlip: Boolean;
begin
  case Main.ExportCoords of
    TExportCoords.Native: LFlip := not Flip;
    TExportCoords.App_Blender: LFlip := not Flip;
    TExportCoords.App_3D_Viewer: LFlip := Flip;
    TExportCoords.App_3D_Printer: LFlip := not Flip;
    else
      LFlip := Flip;
  end;
  FMaterialName := MaterialName;
  FItemName := ItemName;
  AddMeshData(Data, LFlip);
end;

procedure TExporterOBJ.AddMeshData(Data: TMeshData; Flip: Boolean);
begin
  FItemName := '';
  Update(Data.VertexBuffer, Data.IndexBuffer, Flip);
end;

function TExporterOBJ.GetName: string;
var
  dt: string;
begin
  if WantSimpleName then
  begin
    result := 'federgraph';
  Exit;
  end;

  dt := FormatDateTime('yyyy-mm-dd', Now);

  result := Format('%s-%s', [dt, FName]);

  if WantMaterial then
    result := result + '-mat';
  if WantUvs then
    result := result + '-vt';
  if WantNormals then
    result := result + '-vn';

  case Main.ExportCoords of
    TExportCoords.App_Blender: result := result + '-ecB';
    TExportCoords.App_3D_Viewer: result := result + '-ecV';
    TExportCoords.App_3D_Printer:  result := result + '-ecP';
  else
     result := result + '-ecN';
  end;

  case FObjDigits of
    2: result := result + '-ds2';
    3: result := result + '-ds3';
    4: result := result + '-ds4';
    5: result := result + '-ds5';
  end;
end;

function TExporterOBJ.CalcNormals(P1, P2, P3: TPoint3D): TPoint3D;
var
  Term1, Term2, LNormal: TPoint3D;
begin
  Term1 := P3 - P1;
  Term2 := P3 - P2;
  LNormal := (Term1.CrossProduct(Term2)).Normalize;
  result := LNormal;
end;

procedure TExporterOBJ.InitMTL2(AML: TStrings);
var
  i: Integer;
  cln: string;
  cla: TAlphaColor;
  clr: TAlphaColorRec;
  s: string;
begin
  for I := 0 to ColorVar.RggColorPool.Count - 1 do
  begin
    cla := ColorVar.RggColorPool.ColorMap[i].Value;
    cln := ColorVar.RggColorPool.ColorMap[I].Name;
    clr := TAlphaColorRec(cla);
    s := Format('%2.2f %2.2f %2.2f', [clr.R / 255, clr.G / 255, clr.B / 255]);
    AML.Add(Format('newmtl %s', [cln]));
    AML.Add(Format('Ka %s', [s]));
    AML.Add(Format('Kd %s', [s]));
    AML.Add('illum 1');
    AML.Add('');
  end;
end;

procedure TExporterOBJ.GetMtlText(AML: TStrings);
begin
  AML.Add('# federgraph-material.mtl');
  AML.Add('');

  InitMTL2(AML);

  AML.Add('');
  AML.Add('# alternative names');
  AML.Add('');
  AML.Add('newmtl Fuchsia');
  AML.Add('Ka 1.00 0.00 1.00');
  AML.Add('Kd 1.00 0.00 1.00');
  AML.Add('illum 1');
  AML.Add('');
  AML.Add('newmtl Aqua');
  AML.Add('Ka 0.00 1.00 1.00');
  AML.Add('Kd 0.00 1.00 1.00');
  AML.Add('illum 1');
end;

procedure TExporterOBJ.SaveMTL;
var
  dn: string;
  fn: string;
  CanSave: Boolean;
begin
  ML.Clear;
  GetMTLText(ML);

  dn := GetDirectoryName;
  fn := TPath.Combine(dn, 'federgraph-material.mtl');

  if FSaveDialog = nil then
    FSaveDialog := TSaveDialog.Create(nil);
  FSaveDialog.FileName := TPath.Combine(dn, fn);

  CanSave := True;
  FSaveDialog.InitialDir := dn;
  if (not MainVar.WantAutoFolder) or (not DirectoryExists(FSaveDialog.InitialDir)) then
    CanSave := FSaveDialog.Execute;

  if CanSave then
    ML.SaveToFile(FSaveDialog.FileName);

  ML.Clear;
end;

end.
