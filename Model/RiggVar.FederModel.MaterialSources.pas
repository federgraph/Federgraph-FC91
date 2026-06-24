unit RiggVar.FederModel.MaterialSources;

interface

uses
  System.Classes,
  System.Types,
  System.Math.Vectors,
  System.UITypes,
  System.UIConsts,
  System.Generics.Collections,
  FMX.Objects3D,
  FMX.Controls3D,
  FMX.Types,
  FMX.Types3D,
  FMX.MaterialSources;

type
  TMaterialType = (
    ColorMat,
    SimpleMat,
    LightMat,
    FederMat,
    RingMat,
    BodyMat,
    EyeMat,
    HandMat
  );

  TColorMaterialSources = class
  private
    FDict: TObjectDictionary<TAlphaColor, TColorMaterialSource>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetMaterialSource(cla: TAlphaColor): TColorMaterialSource;
  end;

  TLightMaterialSources = class
  private
    FDict: TObjectDictionary<TAlphaColor, TLightMaterialSource>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetMaterialSource(cla: TAlphaColor): TLightMaterialSource;
  end;

  TMaterialPool = class
  public
    LightMaterialSources: TLightMaterialSources;
    ColorMaterialSources: TColorMaterialSources;
    constructor Create;
    destructor Destroy; override;
    function LookupMaterialSource(AMaterialType: TMaterialType; AColor: TAlphaColor): TMaterialSource;
  end;

implementation

{ TColorMaterialSources }

constructor TColorMaterialSources.Create;
begin
  FDict := TObjectDictionary<TAlphaColor, TColorMaterialSource>.Create([doOwnsValues]);
end;

destructor TColorMaterialSources.Destroy;
begin
  FDict.Free;
  inherited;
end;

function TColorMaterialSources.GetMaterialSource(cla: TAlphaColor): TColorMaterialSource;
begin
  if FDict.ContainsKey(cla) then
  begin
    result := FDict.Items[cla];
  end
  else
  begin
    result := TColorMaterialSource.Create(nil);
    result.Color := cla;
    FDict.Add(cla, result);
  end;
end;

{ TLightMaterialSources }

constructor TLightMaterialSources.Create;
begin
  FDict := TObjectDictionary<TAlphaColor, TLightMaterialSource>.Create([doOwnsValues]);
end;

destructor TLightMaterialSources.Destroy;
begin
  FDict.Free;
  inherited;
end;

function TLightMaterialSources.GetMaterialSource(cla: TAlphaColor): TLightMaterialSource;
begin
  if FDict.ContainsKey(cla) then
  begin
    result := FDict.Items[cla];
  end
  else
  begin
    result := TLightMaterialSource.Create(nil);
    result.Ambient := cla;
    FDict.Add(cla, result);
  end;
end;

{ TMaterialPool }

constructor TMaterialPool.Create;
begin
  ColorMaterialSources := TColorMaterialSources.Create;
  LightMaterialSources := TLightMaterialSources.Create;
end;

destructor TMaterialPool.Destroy;
begin
  ColorMaterialSources.Free;
  LightMaterialSources.Free;
  inherited;
end;

function TMaterialPool.LookupMaterialSource(AMaterialType: TMaterialType; AColor: TAlphaColor): TMaterialSource;
begin
  case AMaterialType of
    ColorMat: result := ColorMaterialSources.GetMaterialSource(AColor);
    LightMat: result := LightMaterialSources.GetMaterialSource(AColor);

    else
      result := ColorMaterialSources.GetMaterialSource(AColor);
  end;
end;

end.
