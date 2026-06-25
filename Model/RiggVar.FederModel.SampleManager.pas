unit RiggVar.FederModel.SampleManager;

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
  RiggVar.FB.Data,
  RiggVar.FB.Bundle,
  RiggVar.FB.Hub;

type
  TSampleManagerMin = class
  public
    Hub: Integer;
    Sample: Integer;
  end;

  TSampleManager = class
  private
    FSampleBundle: TSampleBundle;
    FSampleBundle1: TSampleBundle;
    FSampleBundle2: TSampleBundle;

    function GetCount: Integer;
    procedure SetHub(const Value: Integer);
    function GetSampleCount: Integer;
    procedure SetSample(const Value: Integer);
    function GetHubCount: Integer;
    function GetSample: Integer;
    function GetHub: Integer;
    function GetSampleBundle: TSampleBundle;
    function GetSampleHub: TSampleHub;
    function GetLevelCount: Integer;
    function GetBundleID: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure WriteCSV(ML: TStrings);
    procedure ReadCSV(ML: TStrings);
    procedure LoadSample;

    procedure NextHub;
    procedure PreviousHub;
    procedure GotoHub(h: Integer);
    procedure GotoSampleID(i: Integer);

    procedure SwapBundle;

    procedure NextSample; virtual;
    procedure PrevSample; virtual;

    property SampleHub: TSampleHub read GetSampleHub;
    property SampleBundle: TSampleBundle read GetSampleBundle;

    property LevelCount: Integer read GetLevelCount;
    property Hub: Integer read GetHub write SetHub;
    property HubCount: Integer read GetHubCount;
    property Sample: Integer read GetSample write SetSample;
    property SampleCount: Integer read GetSampleCount;
    property Count: Integer read GetCount;

    property BundleID: Integer read GetBundleID;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.FederModel.SampleRepo;

{ TSampleManager }

constructor TSampleManager.Create;
begin
  FSampleBundle1 := TSampleBundle.Create;
  FSampleBundle2 := TSampleRepo.Create;
  FSampleBundle := FSampleBundle2;
end;

destructor TSampleManager.Destroy;
begin
  FSampleBundle1.Free;
  FSampleBundle2.Free;
  inherited;
end;

procedure TSampleManager.SetHub(const Value: Integer);
begin
  SampleBundle.Hub := Value;
end;

procedure TSampleManager.SetSample(const Value: Integer);
begin
  SampleBundle.Sample := Value;
end;

procedure TSampleManager.SwapBundle;
begin
  if SampleBundle = FSampleBundle1 then
    FSampleBundle := FSampleBundle2
  else
    FSampleBundle := FSampleBundle1;
end;

procedure TSampleManager.NextHub;
begin
  SampleBundle.NextHub;
  Main.GotoSample(Sample);
end;

procedure TSampleManager.PreviousHub;
begin
  SampleBundle.PreviousHub;
  Main.GotoSample(Sample);
end;

procedure TSampleManager.GotoHub(h: Integer);
begin
  SampleBundle.GotoHub(h);
  Main.GotoSample(1);
end;

procedure TSampleManager.GotoSampleID(i: Integer);
begin
  SampleBundle.GotoHub(i div 10);
  Main.GotoSample(i mod 10);
end;

procedure TSampleManager.NextSample;
begin
  SampleBundle.NextSample;
end;

procedure TSampleManager.PrevSample;
begin
  SampleBundle.PrevSample;
end;

function TSampleManager.GetHub: Integer;
begin
  result := SampleBundle.Hub;
end;

function TSampleManager.GetSample: Integer;
begin
  result := SampleBundle.Sample;
end;

function TSampleManager.GetHubCount: Integer;
begin
  result := SampleBundle.HubCount;
end;

function TSampleManager.GetLevelCount: Integer;
begin
  result := SampleBundle.LevelCount;
end;

function TSampleManager.GetSampleCount: Integer;
begin
  result := SampleBundle.SampleCount;
end;

procedure TSampleManager.WriteCSV(ML: TStrings);
begin
  //SampleFormat.Save(SampleBundle, ML);
end;

procedure TSampleManager.ReadCSV(ML: TStrings);
begin
  //SampleFormat.Load(SampleBundle, ML);
end;

procedure TSampleManager.LoadSample;
begin
  if Assigned(SampleHub) then
    SampleHub.LoadSample(Main.FederData, SampleBundle.Sample)
end;

function TSampleManager.GetSampleHub: TSampleHub;
begin
  result := SampleBundle.SampleHub;
end;

function TSampleManager.GetSampleBundle: TSampleBundle;
begin
  result := FSampleBundle;
end;

function TSampleManager.GetBundleID: Integer;
begin
  if FSampleBundle = FSampleBundle1 then
    result := 1
  else
    result := 2;
end;

function TSampleManager.GetCount: Integer;
begin
  result := HubCount * SampleCount;
end;

end.
