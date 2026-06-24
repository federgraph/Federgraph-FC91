unit RiggVar.FB.ListArray;

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

type
  TListArray<T> = class
  private
    FEmpty: T;
    FArray: TArray<T>;
    FLength: Integer;
    FCount: Integer;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
  public
    constructor Create(ALength: Integer; AEmpty: T);
    procedure Clear;
    function Add(AItem: T): Integer;
    procedure Delete(Index: Integer);
    procedure Insert(Index: Integer; AItem: T);
    property Count: Integer read FCount;
    property Items[Index: Integer]: T read GetItem write SetItem; default;
  end;

{
  - Original use case: substitute for TList<TPolygon>
  - needed in Delphi 10.1 (work around RSP-16511)
  - It is intended for a known maximum number of items only.
}

implementation

{ TListArray<T> }

constructor TListArray<T>.Create(ALength: Integer; AEmpty: T);
begin
  FCount := 0;
  FLength := ALength;
  FEmpty := AEmpty;
  SetLength(FArray, FLength);
  Clear;
end;

procedure TListArray<T>.Clear;
var
  i: Integer;
begin
  FCount := 0;
  for i := 0 to FLength - 1 do
    FArray[i] := FEmpty;
end;

function TListArray<T>.GetItem(Index: Integer): T;
begin
  if (Index < 0) or (Index >= FCount) then
    result := FEmpty
  else
    result := FArray[Index];
end;

procedure TListArray<T>.SetItem(Index: Integer; const Value: T);
begin
  if (Index >= 0) and (Index < FLength) and (Index < FCount) then
    FArray[Index] := Value;
end;

function TListArray<T>.Add(AItem: T): Integer;
begin
  if FCount < FLength then
  begin
    FArray[FCount] := AItem;
    result := FCount;
    Inc(FCount);
  end
  else
    result := -1;
end;

procedure TListArray<T>.Delete(Index: Integer);
var
  I: Integer;
begin
  if (Index >= 0) and (Index < FLength) and (FCount > 0) and (Index < FCount) then
  begin
    for i := Index to FCount - 2 do
      FArray[i] := FArray[i + 1];
    FArray[FCount - 1] := FEmpty;
    Dec(FCount);
  end;
end;

procedure TListArray<T>.Insert(Index: Integer; AItem: T);
var
  i: Integer;
begin
  if (Index >= 0) and (Index < FCount) and (FCount < FLength) then
  begin
    for i := FCount downto Index + 1 do
      FArray[i] := FArray[i - 1];
    FArray[Index] := AItem;
    Inc(FCount);
  end;
end;

end.
