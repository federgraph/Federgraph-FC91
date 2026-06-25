unit RiggVar.FB.Logger;

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
  System.Classes;

type
  TTraceDestination = (
    tdNone,
    tdFile,
    tdMemo,
    tdDelphiEventLog,
    tdAll
    );

  TTraceHandler = procedure (Sender: TObject; s: string) of object;

  TLogger = class
  private
    FOnTrace: TTraceHandler;
    procedure SetOnTrace(const Value: TTraceHandler);
  protected
    procedure Write(s: string); virtual;
  public
    procedure Error(s: string); virtual;
    procedure Info(s: string); virtual;
    property OnTrace: TTraceHandler read FOnTrace write SetOnTrace;
  end;

  TMemoLogger = class(TLogger)
  protected
    procedure Write(s: string); override;
  public
    ML: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  FMX.Types;

procedure TLogger.Write(s: string);
begin
  if Assigned(OnTrace) then
    OnTrace(nil, s);
  log.d(s);
end;

procedure TLogger.Error(s: string);
begin
  Write(s);
end;

procedure TLogger.Info(s: string);
begin
  Write(s);
end;

procedure TLogger.SetOnTrace(const Value: TTraceHandler);
begin
  FOnTrace := Value;
end;

{ TMemoLogger }

constructor TMemoLogger.Create;
begin
  inherited;
  ML := TStringList.Create;
end;

destructor TMemoLogger.Destroy;
begin
  ML.Free;
  inherited;
end;

procedure TMemoLogger.Write(s: string);
begin
  inherited;
  if ML.Count > 32 then
    ML.Delete(0);
  ML.Add(s);
end;

end.
