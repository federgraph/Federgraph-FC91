unit RiggVar.FederModel.Material;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.Math,
  System.Math.Vectors,
  System.UITypes,
  System.UIConsts,
  FMX.Graphics,
  FMX.Types3D,
  FMX.Objects3D,
  FMX.Controls3D,
  FMX.Types,
  FMX.Materials,
  FMX.MaterialSources;

type
  TFederMaterial = class
  private
    FWantSimpleBitmap: Boolean;
    FBMP1: TBitmap;
    FBMP2: TBitmap;
    FMaterialSourceL: TLightMaterialSource;
    FColor1: TAlphaColor;
    FColor2: TAlphaColor;
    FColor3: TAlphaColor;
    function CreateBitmap1: TBitmap;
    function CreateBitmap2: TBitmap;
    procedure InitBitmap;
    function GetMaterialSource: TMaterialSource;
  public
    constructor Create(AWantSimpleBitmap: Boolean);
    destructor Destroy; override;
    property MaterialSource: TMaterialSource read GetMaterialSource;
  end;

implementation

uses
  RiggVar.FB.Color,
  RiggVar.App.Main;

constructor TFederMaterial.Create(AWantSimpleBitmap: Boolean);
begin
  FMaterialSourceL := TLightMaterialSource.Create(nil);

  FColor1 := TBambuColors.PLABasic_Blue;
  FColor2 := TBambuColors.PLABasic_LightGray;
  FColor3 := TBambuColors.PLABasic_Pumpkin;

  FBMP1 := CreateBitmap1;
  FBMP2 := CreateBitmap2;

  FWantSimpleBitmap := AWantSimpleBitmap;

  InitBitmap;
end;

destructor TFederMaterial.Destroy;
begin
  FBMP1.Free;
  FBMP2.Free;
  FMaterialSourceL.Free;
  inherited;
end;

function TFederMaterial.GetMaterialSource: TMaterialSource;
begin
  result := FMaterialSourceL;
end;

function TFederMaterial.CreateBitmap1: TBitmap;
var
  Data: TBitmapData;
  i: Integer;
  c: TAlphaColor;
  FPixelCount: Integer;
begin
  FPixelCount := 2;
  result := TBitmap.Create(1, FPixelCount);
  if result.Map(TMapAccess.Write, Data) then
  begin
    for i := 0 to FPixelCount - 1 do
    begin
      case i of
        0: c := claAliceblue;
        1: c := claPlum;
        else c := claGray;
      end;
      Data.SetPixel(0, i, c);
    end;
    result.Unmap(Data);
  end;
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

procedure TFederMaterial.InitBitmap;
var
  bmp: TBitmap;
begin
  if FWantSimpleBitmap then
    bmp := FBMP1
  else
    bmp := FBMP2;
  FMaterialSourceL.Texture := bmp;
end;

end.
