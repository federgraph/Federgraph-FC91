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

    { SDB 050 }
    FSDB050H00: TSampleHub;
    FSDB050H01: TSampleHub;
    FSDB050H02: TSampleHub;
    FSDB050H03: TSampleHub;
    FSDB050H04: TSampleHub;
  protected
    SampleHub0: TSampleHub;
    SampleHub1: TSampleHub;
    SampleHub2: TSampleHub;
    SampleHub3: TSampleHub;
    SampleHub4: TSampleHub;
    SampleHub5: TSampleHub;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Init(DBID: Integer); override;
    function GetSampleHubByIndex(h: Integer): TSampleHub; override;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FederModel.SDB050H00,
  RiggVar.FederModel.SDB050H01,
  RiggVar.FederModel.SDB050H02,
  RiggVar.FederModel.SDB050H03,
  RiggVar.FederModel.SDB050H04,
  RiggVar.FederModel.SDB010H00;

{ TSampleRepo }

constructor TSampleRepo.Create;
begin
  FSDB010H00 := TSDB010H00.Create;

  FSDB050H00 := TSDB050H00.Create;
  FSDB050H01 := TSDB050H01.Create;
  FSDB050H02 := TSDB050H02.Create;
  FSDB050H03 := TSDB050H03.Create;
  FSDB050H04 := TSDB050H04.Create;

  Init(50);
end;

destructor TSampleRepo.Destroy;
begin
  FSDB010H00.Free;

  FSDB050H00.Free;
  FSDB050H01.Free;
  FSDB050H02.Free;
  FSDB050H03.Free;
  FSDB050H04.Free;
  inherited;
end;

procedure TSampleRepo.Init(DBID: Integer);
begin
  FHub := 0;
  FLevelCount := 1;

  SampleHub0 := FSDB010H00;
  SampleHub1 := FSDB010H00;
  SampleHub2 := FSDB010H00;
  SampleHub3 := FSDB010H00;
  SampleHub4 := FSDB010H00;
  SampleHub5 := FSDB010H00;

  case DBID of
    10:
    begin
      FHubCount := 1;
    end;

    50:
    begin
      FHubCount := 5 + 1;
      SampleHub1 := FSDB050H00;
      SampleHub2 := FSDB050H01;
      SampleHub3 := FSDB050H02;
      SampleHub4 := FSDB050H03;
      SampleHub5 := FSDB050H04;
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
    1: result := SampleHub1;
    2: result := SampleHub2;
    3: result := SampleHub3;
    4: result := SampleHub4;
    5: result := SampleHub5;
  else
    result := SampleHub0;
  end;
end;

end.


