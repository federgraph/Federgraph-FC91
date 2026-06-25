unit FrmRepo;

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
  System.Types,
  System.UITypes,
  System.Classes,
  FMX.Types,
  FMX.Types3D,
  FMX.StdCtrls,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.Layouts,
  RiggVar.Grid.ColGrid,
  RiggVar.Grid.Block,
  RiggVar.Col.Repo,
  FMX.Controls.Presentation;

type
  TFormRepo = class(TForm)
    ToolBar: TPanel;
    AddBtn: TButton;
    UpdateBtn: TButton;
    ClearBtn: TButton;
    Layout: TLayout;
    procedure AddBtnClick(Sender: TObject);
    procedure UpdateBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
  private
    function GetCollection: TRepoRowCollection;
  protected
//    procedure OnFinishEdit(cr: TBaseRowCollectionItem);
  public
    ColBO: TRepoBO;
    Node: TRepoNode;

    GB: TGridBlock;
    ColGrid: TColGrid;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitGrid;
    procedure DisposeGrid;
    procedure UpdateGrid;

    property Collection: TRepoRowCollection read GetCollection;
  end;

var
  FormRepo: TFormRepo;

implementation

{$R *.fmx}

uses
  RiggVar.App.Main;

constructor TFormRepo.Create(AOwner: TComponent);
begin
  inherited;
  GB := TGridBlock.Create;
  GB.Name := 'Actions';
  GB.Parent := Layout;
  ColBO := Main.RepoData;
  Node := ColBO.CurrentNode as TRepoNode;
  Layout.Align := TAlignLayout.Client;
end;

destructor TFormRepo.Destroy;
begin
  GB.Free;
  inherited;
end;

procedure TFormRepo.InitGrid;
begin
  GB.Node := ColBO.CurrentNode;
  GB.ColBO := ColBO;

  GB.BeginInitGrid;

  ColGrid := GB.ColGrid;
  ColGrid.AutoDelete := True;
  ColGrid.AutoInsert := True;
  ColGrid.ExcelStyle := True;
  //ColGrid.OnFinishEditCR := OnFinishEdit;

  GB.EndInitGrid;
end;

procedure TFormRepo.DisposeGrid;
begin
  GB.DisposeGrid;
  ColBO := nil;
  Node := nil;
  ColGrid := nil;
end;

procedure TFormRepo.AddBtnClick(Sender: TObject);
var
  cl: TRepoRowCollection;
begin
  cl := Node.EventRowCollection;
  cl.Add;
  UpdateGrid;
end;

procedure TFormRepo.DelBtnClick(Sender: TObject);
begin
  ColGrid.DeleteRowCollectionItem;
end;

procedure TFormRepo.RemoveBtnClick(Sender: TObject);
var
  cl: TRepoRowCollection;
begin
  cl := Node.EventRowCollection;
  if cl.Count > 0 then
  begin
    cl.Delete(cl.Count-1);
    UpdateGrid;
  end;
end;

procedure TFormRepo.UpdateBtnClick(Sender: TObject);
begin
  Main.RepoData.Load;
  if Assigned(ColGrid) then
    ColGrid.UpdateAll;
end;

procedure TFormRepo.ClearBtnClick(Sender: TObject);
begin
  if Assigned(ColGrid) then
  begin
    Node.EventRowCollection.Clear;
    ColGrid.UpdateAll;
  end;
end;

procedure TFormRepo.UpdateGrid;
begin
  if Assigned(ColGrid) then
    ColGrid.UpdateAll;
end;

function TFormRepo.GetCollection: TRepoRowCollection;
begin
  result := Node.EventRowCollection;
end;

end.
