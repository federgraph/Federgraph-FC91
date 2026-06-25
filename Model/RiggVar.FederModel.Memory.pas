unit RiggVar.FederModel.Memory;

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
  RiggVar.FB.Def,
  RiggVar.FB.Data;

type
  TFederMemory = class
  private
    FDuration: Integer;
    procedure SetDuration(const Value: Integer);
  protected
    fd1: TFederData;
    fd2: TFederData;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Recall1;
    procedure Recall2;
    procedure Memory1;
    procedure Memory2;
    procedure Transit; virtual;
    property Duration: Integer read FDuration write SetDuration;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FederModel.Data;

{ TManualTransition }

constructor TFederMemory.Create;
begin
  fd1 := TFederData3.Create;
  fd2 := TFederData3.Create;
  FDuration := 5;
end;

destructor TFederMemory.Destroy;
begin
  fd1.Free;
  fd2.Free;
  inherited;
end;

procedure TFederMemory.Memory1;
begin
  Main.UpdateData;
  fd1.Assign(Main.FederData);
end;

procedure TFederMemory.Memory2;
begin
  Main.UpdateData;
  fd2.Assign(Main.FederData);
end;

procedure TFederMemory.Recall1;
begin
  Main.FederData.Assign(fd1);
  Main.LoadFromFederData;
end;

procedure TFederMemory.Recall2;
begin
  Main.FederData.Assign(fd2);
  Main.LoadFromFederData;
end;

procedure TFederMemory.SetDuration(const Value: Integer);
begin
  FDuration := Value;
end;

procedure TFederMemory.Transit;
begin
  { virtual }
end;

end.
