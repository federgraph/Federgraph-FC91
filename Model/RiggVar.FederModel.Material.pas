unit RiggVar.FederModel.Material;

interface

uses
  System.UITypes,
  System.UIConsts,
  FMX.Graphics,
  FMX.MaterialSources;

type
  TFederMaterial = class
  private
    FBMP2: TBitmap;
    FMaterialSourceL: TLightMaterialSource;
    FColor1: TAlphaColor;
    FColor2: TAlphaColor;
    FColor3: TAlphaColor;
    function CreateBitmap2: TBitmap;
    function GetMaterialSource: TMaterialSource;
  public
    constructor Create;
    destructor Destroy; override;
    property MaterialSource: TMaterialSource read GetMaterialSource;
  end;

implementation

constructor TFederMaterial.Create;
begin
  FColor1 := claBlue;
  FColor2 := claSilver;
  FColor3 := claOrange;

  FBMP2 := CreateBitmap2;

  FMaterialSourceL := TLightMaterialSource.Create(nil);
  FMaterialSourceL.Texture := FBMP2;
end;

destructor TFederMaterial.Destroy;
begin
  FBMP2.Free;
  FMaterialSourceL.Free;
  inherited;
end;

function TFederMaterial.GetMaterialSource: TMaterialSource;
begin
  result := FMaterialSourceL;
end;

function TFederMaterial.CreateBitmap2: TBitmap;
var
  Data: TBitmapData;
  i: Integer;
  c: TAlphaColor;
  FPixelCount: Integer;
begin
  FPixelCount := 360;
  result := TBitmap.Create(1, FPixelCount);
  if result.Map(TMapAccess.Write, Data) then
  begin
    c := FColor1;
    for i := 0 to FPixelCount - 1 do
    begin
      case i of
        169: c := FColor1;
        181: c := FColor2;
        194: c := FColor3;
        200: c := FColor1;
        206: c := FColor2;
        215: c := FColor1;
        237: c := FColor2;
        240: c := FColor1;
        251: c := FColor3;
      end;
      Data.SetPixel(0, i, c);
    end;
    result.Unmap(Data);
  end;
end;

end.
