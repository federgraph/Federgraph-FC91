unit FrmActionGrid;

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
  RiggVar.Col.Action,
  RiggVar.FB.Def,
  FMX.Controls.Presentation;

type
  TFormActionGrid = class(TForm)
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
    function GetCollection: TActionRowCollection;
  protected
//    procedure OnFinishEdit(cr: TBaseRowCollectionItem);
  public
    ColBO: TActionBO;
    Node: TActionNode;

    GB: TGridBlock;
    ColGrid: TColGrid;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitGrid;
    procedure DisposeGrid;
    procedure UpdateGrid;

    property Collection: TActionRowCollection read GetCollection;
  end;

var
  FormActionGrid: TFormActionGrid;

implementation

{$R *.fmx}

uses
  RiggVar.App.Main;

constructor TFormActionGrid.Create(AOwner: TComponent);
begin
  inherited;
  GB := TGridBlock.Create;
  GB.Name := 'Actions';
  GB.Parent := Layout;
  ColBO := Main.ActionData;
  Node := ColBO.CurrentNode as TActionNode;
  Layout.Align := TAlignLayout.Client;
end;

destructor TFormActionGrid.Destroy;
begin
  GB.Free;
  inherited;
end;

procedure TFormActionGrid.InitGrid;
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

procedure TFormActionGrid.DisposeGrid;
begin
  GB.DisposeGrid;
  ColBO := nil;
  Node := nil;
  ColGrid := nil;
end;

procedure TFormActionGrid.AddBtnClick(Sender: TObject);
var
  cl: TActionRowCollection;
begin
  cl := Node.ActionRowCollection;
  cl.Add;
  UpdateGrid;
end;

procedure TFormActionGrid.DelBtnClick(Sender: TObject);
begin
  ColGrid.DeleteRowCollectionItem;
end;

procedure TFormActionGrid.RemoveBtnClick(Sender: TObject);
var
  cl: TActionRowCollection;
begin
  cl := Node.ActionRowCollection;
  if cl.Count > 0 then
  begin
    cl.Delete(cl.Count-1);
    UpdateGrid;
  end;
end;

procedure TFormActionGrid.UpdateBtnClick(Sender: TObject);
begin
  Main.ActionData.Load;
  if Assigned(ColGrid) then
    ColGrid.UpdateAll;
end;

procedure TFormActionGrid.ClearBtnClick(Sender: TObject);
begin
  if Assigned(ColGrid) then
  begin
    Node.ActionRowCollection.Clear;
    ColGrid.UpdateAll;
  end;
end;

procedure TFormActionGrid.UpdateGrid;
begin
  if Assigned(ColGrid) then
    ColGrid.UpdateAll;
end;

function TFormActionGrid.GetCollection: TActionRowCollection;
begin
  result := Node.ActionRowCollection;
end;

end.
