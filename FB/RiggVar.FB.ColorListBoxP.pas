unit RiggVar.FB.ColorListBoxP;

interface

{ This is a very slim FMX 'runtime' color list box component.
  It can show colors from a group }

uses
  RiggVar.FB.Color,
  RiggVar.FB.ColorGroup,
  RiggVar.FB.ColorList,
  RiggVar.FB.ColorBambu,
  System.SysUtils,
  System.Classes,
  System.Types,
  System.Rtti,
  System.UITypes,
  FMX.Objects,
  FMX.Controls,
  FMX.ListBox;

{.$define WantCopy}

type
  TColorListBoxP = class(TCustomListBox)
  private
    FColorList: TRggColorList;
    FBambuPartition: TBambuPartition;
    FPart: TBambuPart;
    function GetColor: TRggColor;
    procedure SetColor(const Value: TRggColor);
    procedure SetPart(const Value: TBambuPart);
    procedure DoItemApplyStyleLookup(Sender: TObject);
  protected
    procedure RebuildList;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddColor(AColor: TRggColor);
    function DeleteColor(AColor: TRggColor): Boolean;

    property ColorList: TRggColorList read FColorList;

    property Color: TRggColor read GetColor write SetColor;
    property Part: TBambuPart read FPart write SetPart;
    property OnChange;
  end;

implementation

uses
  RiggVar.App.Main;

{ TColorListBoxP }

constructor TColorListBoxP.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
  FBambuPartition := Main.BambuPartition;
{$ifdef WantCopy}
  FColorList := TRggColorList.Create;
{$endif}
  Part := TBambuPart.Dark;
end;

destructor TColorListBoxP.Destroy;
begin
{$ifdef WantCopy}
  FColorList.Free;
{$endif}
  inherited;
end;

procedure TColorListBoxP.RebuildList;
var
  I, SaveIndex: Integer;
  Item: TListBoxItem;
begin
  if (FUpdating > 0) or (csDestroying in ComponentState) then
    Exit;

  BeginUpdate;
  SaveIndex := ItemIndex;
  Clear;
  for I := 0 to FColorList.Count - 1 do
  begin
    Item := TListBoxItem.Create(nil);
    Item.Parent := Self;
    Item.Width := Item.DefaultSize.Width;
    Item.Height := Item.DefaultSize.Height;
    Item.Stored := False;
    Item.Locked := True;
    Item.Text := FColorList[I].ColorName;
    Item.Tag := I;
    Item.StyleLookup := 'colorlistboxitemstyle';
    Item.OnApplyStyleLookup := DoItemApplyStyleLookup;
  end;
  SelectionController.SetCurrent(SaveIndex);
  EndUpdate;
end;

procedure TColorListBoxP.AddColor(AColor: TRggColor);
begin
  FColorList.AddColor(AColor);
  RebuildList;
end;

function TColorListBoxP.DeleteColor(AColor: TRggColor): Boolean;
begin
  result := FColorList.DeleteColor(AColor);
  if result then
    RebuildList;
end;

procedure TColorListBoxP.SetColor(const Value: TRggColor);
var
  I: Integer;
begin
  if Value = TAlphaColorRec.Null then
    ItemIndex := -1
  else
    for I := 0 to Items.Count-1 do
      if Value = FColorList[I].Color then
      begin
        ItemIndex := I;
        Break;
      end;
end;

procedure TColorListBoxP.SetPart(const Value: TBambuPart);
begin
  FPart := Value;

{$ifdef WantCopy}
    FColorList.Clear;
    case FPart of
      Unused: FColorList.AddColorsFromList(FBambuPartition.UnusedColors);
      Dark: FColorList.AddColorsFromList(FBambuPartition.DarkColors);
      Skin: FColorList.AddColorsFromList(FBambuPartition.SkinColors);
      Ring: FColorList.AddColorsFromList(FBambuPartition.RingColors);
    end;
  end;
{$else}
  case FPart of
    Unused: FColorList := FBambuPartition.UnusedColors;
    Dark: FColorList := FBambuPartition.DarkColors;
    Skin: FColorList := FBambuPartition.SkinColors;
    Ring: FColorList := FBambuPartition.RingColors;
  end;
{$endif}

  RebuildList;
end;

function TColorListBoxP.GetColor: TRggColor;
begin
  if (ItemIndex >= 0) and (ItemIndex < Count) then
    Result := FColorList[ItemIndex].Color
  else
    Result := TAlphaColorRec.Null;
end;

procedure TColorListBoxP.DoItemApplyStyleLookup(Sender: TObject);
var
  ColorObj: TShape;
begin
  if TListBoxItem(Sender).FindStyleResource<TShape>('color', ColorObj) then
    ColorObj.Fill.Color := FColorList[TListBoxItem(Sender).Tag].Color;
end;

function TColorListBoxP.GetDefaultStyleLookupName: string;
begin
  Result := 'listboxstyle';
end;

end.
