unit RiggVar.MeshBuilder.BorderBand;

interface

uses
  System.Math.Vectors,
  System.Generics.Collections,
  RiggVar.FB.Def,
  RiggVar.Mesh.MeshBuilder;

type
  TBandBuilder = class(TMeshBuilder)
  protected
    FIndexOffset: Integer;

    Flip: Boolean;
    CanAdvanceI: Boolean;
    CanAdvanceJ: Boolean;
    ICount: Integer;
    JCount: Integer;
    IBase: Integer;
    JBase: Integer;
    I1, I2: Integer;
    J1, J2: Integer;
    dI, dJ: single;
    LastAdded: Char;

    procedure FillJ;
    procedure FillI;
    procedure AdvanceI;
    procedure AdvanceJ;
    procedure CloseI;
    procedure CloseJ;
    procedure LogT(c: Char);
    procedure AddTriangle(i1, i2, i3: Integer);
  public
    procedure AddFederBand(PolyI, PolyJ: TPoint3DArray; AFlip: Boolean);
  end;

implementation

procedure TBandBuilder.AdvanceI;
begin
  if I2 < ICount - 1 then
  begin
    Inc(I1);
    I2 := I1 + 1;
  end;
  CanAdvanceI := I2 < ICount - 1;
end;

procedure TBandBuilder.AdvanceJ;
begin
  if J2 < JCount - 1 then
  begin
    Inc(J1);
    J2 := J1 + 1;
  end;
  CanAdvanceJ := J2 < JCount - 1;
end;

procedure TBandBuilder.AddTriangle(i1, i2, i3: Integer);
begin
  if Flip then
  begin
    T1.Add(FIndexOffset + i1);
    T3.Add(FIndexOffset + i2);
    T2.Add(FIndexOffset + i3);
  end
  else
  begin
    T1.Add(FIndexOffset + i1);
    T2.Add(FIndexOffset + i2);
    T3.Add(FIndexOffset + i3);
  end;
end;

procedure TBandBuilder.FillI;
begin
  AddTriangle(IBase + I1, JBase + J1, IBase + I2);
  LogT('i');
end;

procedure TBandBuilder.CloseI;
begin
  AddTriangle(IBase + I2, JBase + J1, JBase + J2);
  LogT('I');
end;

procedure TBandBuilder.FillJ;
begin
  AddTriangle(IBase + I1, JBase + J1, JBase + J2);
  LogT('j');
end;

procedure TBandBuilder.CloseJ;
begin
  AddTriangle(JBase + J2, IBase + I2, IBase + I1);
  LogT('J');
end;

procedure TBandBuilder.AddFederBand(PolyI, PolyJ: TPoint3DArray; AFlip: Boolean);
var
  i: Integer;
begin
  FIndexOffset := FV.Count;

  if (PolyI = nil) or ((PolyJ = nil)) then
    Exit;

  Flip := AFlip;

  ICount := Length(PolyI);
  JCount := Length(PolyJ);

  if ICount < 2 then
    Exit;
  if JCount < 2 then
    Exit;

  { add all vertices first }

  for i := 0 to ICount - 1 do
  begin
    FV.Add(PolyI[i]);
    FT.Add(pc1);
  end;

  for i := 0 to JCount - 1 do
  begin
    FV.Add(PolyJ[i]);
    FT.Add(pc2);
  end;

  { now add triangles }

  IBase := 0;
  JBase := ICount;

  I1 := 0;
  I2 := 1;
  J1 := 0;
  J2 := 1;
  CanAdvanceI := ICount > 2;
  CanAdvanceJ := JCount > 2;

  if (CanAdvanceI = False) and (CanAdvanceJ = False) then
  begin
    FillI;
    CloseI;
  end;

  while CanAdvanceI and CanAdvanceJ do
  begin
    dI := PolyI[I1].Distance(PolyJ[J2]);
    dJ := PolyJ[J1].Distance(PolyI[I2]);
    if dI < dJ then
    begin
      FillJ;
      AdvanceJ;
    end
    else
    begin
      FillI;
      AdvanceI;
    end;
  end;

  if CanAdvanceI then
  begin
    FillI;
    while CanAdvanceI do
    begin
      AdvanceI;
      FillI;
    end;
    CloseI;
  end;

  if CanAdvanceJ then
  begin
    FillJ;
    while CanAdvanceJ do
    begin
      AdvanceJ;
      FillJ;
    end;
    CloseJ;
  end;

end;

procedure TBandBuilder.LogT(c: Char);
begin
  LastAdded := c;
end;

end.
