unit RiggVar.FederModel.SampleRepo;

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
  RiggVar.FB.Bundle,
  RiggVar.FB.Hub;

type
  TSampleRepo = class(TSampleBundle)
  private
    { SDB 010 }
    FSDB010H00: TSampleHub;
  protected
    SampleHub0: TSampleHub;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Init(DBID: Integer); override;
    function GetSampleHubByIndex(h: Integer): TSampleHub; override;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FederModel.SDB010H00;

{ TSampleRepo }

constructor TSampleRepo.Create;
begin
  FSDB010H00 := TSDB010H00.Create;

  Init(10);
end;

destructor TSampleRepo.Destroy;
begin
  FSDB010H00.Free;

  inherited;
end;

procedure TSampleRepo.Init(DBID: Integer);
begin
  FHub := 0;
  FLevelCount := 1;

  SampleHub0 := FSDB010H00;

  case DBID of
    10:
    begin
      FHubCount := 1;
    end;

    else
    begin
      FHubCount := 1;
    end;
  end;
end;

function TSampleRepo.GetSampleHubByIndex(h: Integer): TSampleHub;
begin
  case h of
    0: result := SampleHub0;
  else
    result := SampleHub0;
  end;
end;

end.


