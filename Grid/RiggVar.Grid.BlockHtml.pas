unit RiggVar.Grid.BlockHtml;

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
  System.Classes,
  FMX.Types,
  RiggVar.Grid.Color,
  RiggVar.Grid.ColGrid,
  RiggVar.Grid.SimpleBlock;

type
  THtmlGridBlock<N: TBaseNode; C: TBaseColBO> = class
  private
    SL: TStringList;
    FGB: TSimpleGridBlock;
  protected
    SortColName: string;
    procedure CreateGrid;
    procedure DestroyGrid;
    property GB: TSimpleGridBlock read FGB write FGB;
  public
    Name: string;
    Parent: TFmxObject;
    Node: N;
    ColBO: C;
    constructor Create;
    destructor Destroy; override;
    function GetHTM: string;
    function IsOutputSorted: Boolean;
    procedure SaveHTM(FileName: string);
  end;

implementation

uses
  RiggVar.App.Main;

constructor THtmlGridBlock<N, C>.Create;
begin
  inherited Create;
  SL := TStringList.Create;
  SortColName := 'col_BaseID';
end;

destructor THtmlGridBlock<N, C>.Destroy;
begin
  DestroyGrid;
  SL.Free;
  inherited;
end;

procedure THtmlGridBlock<N, C>.CreateGrid;
var
  b: Boolean;
begin
  if GB = nil then
  begin
    b := true;
    if Parent = nil then
      b := false;
    if Node = nil then
      b := false;
    if ColBO = nil then
      b := false;
    if Name = '' then
      b := false;

    if b then
    begin
      GB := TSimpleGridBlock.Create;
      GB.Name := Name;
//      GB.Parent := Parent;
      GB.ColBO := ColBO;
      GB.Node := Node;

      GB.InitGrid;
      GB.ColGrid.ColorSchema := colorBlue;
      GB.ColGrid.AutoMark := True;
      GB.ColGrid.ExcelStyle := true;
      //GB.EndInitGrid; //do not enable Timer

      GB.ColGrid.UpdateAll;
    end;
  end;
end;

procedure THtmlGridBlock<N, C>.DestroyGrid;
begin
  GB.Free;
  GB := nil;
  Node.Free;
  //Node := nil;
  ColBO.Free;
  //ColBO := nil;
end;

function THtmlGridBlock<N, C>.GetHTM: string;
begin
  if GB = nil then
    CreateGrid;

  if GB <> nil then
  begin
    SL.Clear;
    GB.ColGrid.UseHTML := True;
    try
      //Grid.ColsActive.SortColIndex := x;
      GB.ColGrid.UpdateAll;
      GB.ColGrid.Content(SL, '');
      result := SL.Text;
    finally
      GB.ColGrid.UseHTML := False;
    end;
  end
  else
    result := 'Invalid state in HtmlGridBlock: ' + Name;
end;

function THtmlGridBlock<N, C>.IsOutputSorted: Boolean;
begin
  result := GB.ColGrid.ColsActive.SortColIndex > 0;
end;

procedure THtmlGridBlock<N, C>.SaveHTM(FileName: string);
begin
  GetHTM;
  if SL.Count > 0 then
  begin
    SL.SaveToFile(FileName);
    SL.Clear;
  end;
end;

end.
