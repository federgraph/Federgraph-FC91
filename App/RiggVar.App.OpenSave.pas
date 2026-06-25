unit RiggVar.App.OpenSave;

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
  System.UITypes,
  FMX.Dialogs;

type
  TOpenSave = class
  private
    FSL: TStringList;
    FOpenDlg: TOpenDialog;
    FSaveDlg: TSaveDialog;
    function GetSaveEnabled: Boolean;
  protected
    fn: string;
    WantReadOnlyFiles: Boolean;
    DefaultFileExtension: string;
    DefaultFileName: string;
    OpenFilterText: string;
    SaveFilterText: string;
    procedure DoOpen; virtual;
    procedure DoSave; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    function GetOpenDlg: TOpenDialog;
    function GetSaveDlg: TSaveDialog;

    procedure Open;
    procedure Save;
    procedure SaveAs;
    property SaveEnabled: Boolean read GetSaveEnabled;
    property FileName: string read fn;
    property SL: TStringList read FSL;
  end;

  TFilterBuilder = class
  private
    ML: TStrings;
    FFilterText: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(Description, Extension: string);
    procedure Compile;
    property FilterText: string read FFilterText;
  end;

  TOpenSaveText = class(TOpenSave)
  protected
    procedure DoOpen; override;
    procedure DoSave; override;
  public
    constructor Create;
  end;

  TOpenSaveImage = class(TOpenSave)
  protected
    procedure DoSave; override;
  public
    constructor Create;
  end;

  TOpenSaveEventData = class(TOpenSave)
  private
//    EventData: TEventData;
  protected
    procedure DoOpen; override;
    procedure DoSave; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TOpenSaveFC = class(TOpenSave)
  public
    constructor Create;
  end;

  TOpenSaveFR = class(TOpenSave)
  public
    constructor Create;
  end;

  TOpenOBJ = class(TOpenSave)
  public
    constructor Create;
  end;

const
  TextFilter = 'Text files (*.txt)|*.txt|Xml files (*.xml)|*.xml|All files (*.*)|*.*';
  ImageFilter = 'All files (*.*)|*.*|png images (*.png)|*.png|jpg images (*.jpg)|*.jpg|jpeg images (*.jpeg)|*.jpeg';
  TrimmFileFilter = 'Trimm-File|*.txt|Trimm-Datei|*.trm';

var
  FederDataFilterOpen: string = 'FederData|*.txt';
  FederDataFilterSave: string = 'FederData|*.txt';
  FederMeshFilterOpen: string = 'FederMesh|*.obj';

implementation

{ TOpenSave }

constructor TOpenSave.Create;
begin
  FSL := TStringList.Create;
  DefaultFileName := 'temp.txt';
  DefaultFileExtension := '.txt';
  OpenFilterText := TextFilter;
  SaveFilterText := TextFilter;
end;

destructor TOpenSave.Destroy;
begin
  FSL.Free;
  FOpenDlg.Free;
  FSaveDlg.Free;
  inherited;
end;

function TOpenSave.GetOpenDlg: TOpenDialog;
var
  oo: TOpenOptions;
begin
  if not Assigned(FOpenDlg) then
  begin
    FOpenDlg := TOpenDialog.Create(nil);
    FOpenDlg.DefaultExt := DefaultFileExtension;
    FOpenDlg.Filter := OpenFilterText;
    oo := [
      //TOpenOption.ofHideReadOnly,
      TOpenOption.ofPathMustExist,
      TOpenOption.ofFileMustExist,
      TOpenOption.ofNoNetworkButton,
      TOpenOption.ofEnableSizing
      ];
    if not WantReadOnlyFiles then
      Include(oo, TOpenOption.ofHideReadOnly);
    FOpenDlg.Options := oo;
  end;
  result := FOpenDlg;
end;

function TOpenSave.GetSaveDlg: TSaveDialog;
begin
  if not Assigned(FSaveDlg) then
  begin
    FSaveDlg := TSaveDialog.Create(nil);
    FSaveDlg.DefaultExt := DefaultFileExtension;
    FSaveDlg.Filter := SaveFilterText;
    FSaveDlg.Options := [
    TOpenOption.ofHideReadOnly,
    TOpenOption.ofPathMustExist,
    TOpenOption.ofNoReadOnlyReturn,
    TOpenOption.ofNoNetworkButton,
    TOpenOption.ofEnableSizing];
  end;
  result := FSaveDlg;
end;

function TOpenSave.GetSaveEnabled: Boolean;
begin
  result := fn <> '';
end;

procedure TOpenSave.Open;
var
  od: TOpenDialog;
begin
  od := GetOpenDlg;
  if od.Execute then
  begin
    if FileExists(od.FileName) then
    begin
      fn := od.FileName;
      DoOpen;
    end;
  end;
end;

procedure TOpenSave.Save;
begin
  if (fn <> '') and FileExists(fn) then
    DoSave
  else
    SaveAs;
end;

procedure TOpenSave.SaveAs;
var
  sd: TSaveDialog;
begin
  sd := GetSaveDlg;
  sd.FileName := fn;
  if sd.Execute then
  begin
    if sd.FileName <> '' then
    begin
      fn := sd.FileName;
      DoSave;
    end;
  end;
end;

procedure TOpenSave.DoSave;
begin
end;

procedure TOpenSave.DoOpen;
begin
end;

{ TOpenSaveEventData }

constructor TOpenSaveEventData.Create;
begin
  inherited;
//  EventData := TEventData.Create;
  DefaultFileName := 'FR.txt';
  DefaultFileExtension := '.txt';
  OpenFilterText := TextFilter;
  SaveFilterText := TextFilter;
end;

destructor TOpenSaveEventData.Destroy;
begin
//  EventData.Free;
  inherited;
end;

procedure TOpenSaveEventData.DoOpen;
begin
//  SL.LoadFromFile(fn);
//  EventData.Load(SL.Text);
//  if EventData.IsOK then
//  begin
//    Main.DocManager.EventName := ExtractFileName(fn);
//    Main.GuiManager.SwapEvent(EventData.Text);
//  end;
end;

procedure TOpenSaveEventData.DoSave;
begin
//  SL.Text := BO.ToXML;
//  SL.SaveToFile(fn, TEncoding.UTF8);
//  BO.UndoManager.Clear;
//  SL.Clear;
end;

{ TOpenSaveImage }

constructor TOpenSaveImage.Create;
begin
  inherited;
  DefaultFileName := '';
  DefaultFileExtension := '.png';
  OpenFilterText := ImageFilter;
  SaveFilterText := ImageFilter;
end;

procedure TOpenSaveImage.DoSave;
begin
  { do nothing }
end;

{ TOpenSaveText }

constructor TOpenSaveText.Create;
begin
  DefaultFileName := '';
  DefaultFileExtension := 'temp.txt';
  OpenFilterText := TextFilter;
  SaveFilterText := TextFilter;
end;

procedure TOpenSaveText.DoOpen;
begin
  SL.LoadFromFile(fn);
end;

procedure TOpenSaveText.DoSave;
begin
  SL.SaveToFile(fn, TEncoding.UTF8);
  SL.Clear;
end;

{ TOpenSaveFR }

constructor TOpenSaveFR.Create;
begin
  inherited;
  DefaultFileName := 'TrimmFile.txt';
  DefaultFileExtension := '.txt';
  OpenFilterText := TrimmFileFilter;
  SaveFilterText := TrimmFileFilter;
end;

{ TOpenSaveFC }

constructor TOpenSaveFC.Create;
var
  FilterBuilder: TFilterBuilder;
begin
  inherited;
  DefaultFileName := 'FederData.txt';
  DefaultFileExtension := '.txt';

  FilterBuilder := TFilterBuilder.Create;
  FilterBuilder.Add('Feder-Data', 'txt');
  FilterBuilder.Add('Shader-Snippet-Win', 'hlsl');
  FilterBuilder.Add('Shader-Snippet-Mac', 'glsl');
  FilterBuilder.Add('Texture', 'png');
  FilterBuilder.Add('Background', 'jpg');
  FilterBuilder.Add('All good', '*');

  FilterBuilder.Compile;
  FederDataFilterOpen := FilterBuilder.FilterText;
  OpenFilterText := FederDataFilterOpen;

  FilterBuilder.Clear;
  FilterBuilder.Add('Feder-Data', 'txt');
  FilterBuilder.Add('Shader-Snippet-Win', 'hlsl');
  FilterBuilder.Add('Shader-Snippet-Mac', 'glsl');
  FilterBuilder.Add('Texture', 'png');
  FilterBuilder.Add('MeshData-obj', 'obj');
  FilterBuilder.Add('MeshData-pov', 'pov');
  FilterBuilder.Add('Other', '*');

  FilterBuilder.Compile;
  FederDataFilterSave := FilterBuilder.FilterText;
  SaveFilterText := FederDataFilterSave;

  FilterBuilder.Free;
end;

{ TFilterBuilder }

procedure TFilterBuilder.Clear;
begin
  ML.Clear;
  FFilterText := '';
end;

procedure TFilterBuilder.Compile;
var
  i: Integer;
  k, v: string;
begin
  FFilterText := '|';
  for i := 0 to ML.Count-1 do
  begin
    k := ML.Names[i];
    v := ML.Values[k];
    if i = 0 then
      FFilterText := Format('%s|*.%s', [k, v])
    else
      FFilterText := FFilterText + Format('|%s|*.%s', [k, v]);
  end;
end;

constructor TFilterBuilder.Create;
begin
  ML := TStringList.Create;
  FFilterText := '|';
end;

destructor TFilterBuilder.Destroy;
begin
  ML.Free;
  inherited;
end;

procedure TFilterBuilder.Add(Description, Extension: string);
begin
  ML.Add(Format('%s=%s', [Description, Extension]));
end;

{ TOpenOBJ }

constructor TOpenOBJ.Create;
var
  FilterBuilder: TFilterBuilder;
begin
  inherited;
  DefaultFileName := 'FederMesh.obj';
  DefaultFileExtension := '.txt';

  FilterBuilder := TFilterBuilder.Create;
  FilterBuilder.Add('FederMesh', 'obj');

  FilterBuilder.Compile;
  FederMeshFilterOpen := FilterBuilder.FilterText;
  OpenFilterText := FederMeshFilterOpen;

  FilterBuilder.Free;
end;

end.
