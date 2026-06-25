unit RiggVar.Grid.Model;

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
  FMX.Grid,
  RiggVar.Grid.ColGrid,
  RiggVar.Grid.Control;

type
  TColGridModel = class(TInterfacedObject, IColGrid)
  private
    Grid: TDisplayGrid;

    function GetCells(c, r: Integer): string;
    function GetColCount: Integer;
    function GetEnabled: Boolean;
    function GetFixedRows: Integer;
    function GetRow: Integer;
    function GetRowCount: Integer;
    function GetHeaderRowIndex: Integer;

    procedure SetCells(c, r: Integer; const Value: string);
    procedure SetColCount(const Value: Integer);
    procedure SetEnabled(const Value: Boolean);
    procedure SetFixedRows(const Value: Integer);
    procedure SetHeaderRowIndex(Value: Integer);
    procedure SetRow(const Value: Integer);
    procedure SetRowCount(const Value: Integer);
  public
    constructor Create(aGrid: TDisplayGrid);

    procedure CancelEdit;
    procedure InvalidateGrid;
    procedure SetupGrid;
    procedure ShowData;

    property HeaderRowIndex: Integer read GetHeaderRowIndex write SetHeaderRowIndex;
    property ColCount: Integer read GetColCount write SetColCount;
    property RowCount: Integer read GetRowCount write SetRowCount;
    property Cells[c, r: Integer]: string read GetCells write SetCells;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property FixedRows: Integer read GetFixedRows write SetFixedRows;
    property Row: Integer read GetRow write SetRow;
  end;

implementation

{ TGridModel }

procedure TColGridModel.CancelEdit;
begin
  Grid.CancelEdit;
end;

constructor TColGridModel.Create(aGrid: TDisplayGrid);
begin
  Grid := aGrid;
end;

function TColGridModel.GetCells(c, r: Integer): string;
begin
  result := Grid.Cells[c, r];
end;

function TColGridModel.GetColCount: Integer;
begin
  result := Grid.ColCount;
end;

function TColGridModel.GetEnabled: Boolean;
begin
  result := Grid.Enabled;
end;

function TColGridModel.GetFixedRows: Integer;
begin
  result := 0;
end;

function TColGridModel.GetHeaderRowIndex: Integer;
begin
  result := 0;
end;

function TColGridModel.GetRow: Integer;
begin
  result := Grid.Row;
end;

function TColGridModel.GetRowCount: Integer;
begin
  result := Grid.RowCount;
end;

procedure TColGridModel.InvalidateGrid;
begin
  Grid.InvalidateGrid;
end;

procedure TColGridModel.SetCells(c, r: Integer; const Value: string);
begin
  Grid.Cells[c, r] := Value;
end;

procedure TColGridModel.SetColCount(const Value: Integer);
begin
  Grid.ColCount := Value;
end;

procedure TColGridModel.SetEnabled(const Value: Boolean);
begin
  Grid.Enabled := Value;
end;

procedure TColGridModel.SetFixedRows(const Value: Integer);
begin
end;

procedure TColGridModel.SetHeaderRowIndex(Value: Integer);
begin
//  Grid.HeaderRowIndex := Value;
end;

procedure TColGridModel.SetRow(const Value: Integer);
begin
  Grid.Selected := Value;
end;

procedure TColGridModel.SetRowCount(const Value: Integer);
begin
  Grid.RowCount := Value;
end;

procedure TColGridModel.SetupGrid;
begin
  Grid.SetupGrid;
end;

procedure TColGridModel.ShowData;
begin
  Grid.ShowData;
end;

end.
