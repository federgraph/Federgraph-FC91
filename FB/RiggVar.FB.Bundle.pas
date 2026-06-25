unit RiggVar.FB.Bundle;

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
  RiggVar.FB.Data,
  RiggVar.FB.Hub;

type
  TSampleBundle = class
  protected
    FSample: Integer;
    FHub: Integer;
    FHubCount: Integer;
    FLevelCount: Integer;
    FSampleHub: TSampleHub;

    function GetSampleHub: TSampleHub;
    procedure SetHub(const Value: Integer);
    function GetSampleCount: Integer;
    procedure SetSample(const Value: Integer);
    function GetHubCount: Integer;
    function GetSample: Integer;
    function GetHub: Integer;
    function GetLevelCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Init(DBID: Integer); virtual;
    function GetSampleHubByIndex(h: Integer): TSampleHub; virtual;

    function GetMatrixCount: Integer;
    function GetFederData(k: Integer): TFederData;

    procedure LoadFromFile;
    procedure SaveToFile;

    procedure NextHub;
    procedure PreviousHub;
    procedure GotoHub(h: Integer);

    procedure NextSample;
    procedure PrevSample;

    property SampleHub: TSampleHub read GetSampleHub;

    property Hub: Integer read GetHub write SetHub;
    property HubCount: Integer read GetHubCount;
    property Sample: Integer read GetSample write SetSample;
    property SampleCount: Integer read GetSampleCount;
    property LevelCount: Integer read GetLevelCount;
  end;

implementation

uses
  RiggVar.App.Main;

{ TSamleBundle }

constructor TSampleBundle.Create;
begin
  FSampleHub := TSampleHub.Create;
  Init(1);
end;

destructor TSampleBundle.Destroy;
begin
  FSampleHub.Free;
  inherited;
end;

procedure TSampleBundle.Init(DBID: Integer);
begin
  FHub := 0;
  FHubCount := 1;
//  FLevel := 0;
  FLevelCount := 1;
end;

function TSampleBundle.GetSampleHub: TSampleHub;
begin
  result := GetSampleHubByIndex(FHub);
end;

function TSampleBundle.GetSampleHubByIndex(h: Integer): TSampleHub;
begin
  result := FSampleHub;
end;

procedure TSampleBundle.SaveToFile;
begin

end;

procedure TSampleBundle.LoadFromFile;
begin

end;

procedure TSampleBundle.SetHub(const Value: Integer);
begin
  if Value > HubCount-1 then
    FHub := 0
  else if Value < 0 then
    FHub := HubCount-1
  else
    FHub := Value;

  if FHub = -1 then //when HubCount = 0
    FHub := 0;
end;

procedure TSampleBundle.GotoHub(h: Integer);
begin
  Hub := h;
end;

procedure TSampleBundle.NextHub;
begin
  Hub := Hub + 1;
end;

procedure TSampleBundle.PreviousHub;
begin
  Hub := Hub - 1;
end;

procedure TSampleBundle.NextSample;
begin
  Inc(FSample);
  if FSample > SampleHub.Count-1 then
    FSample := 0;
end;

procedure TSampleBundle.PrevSample;
begin
  Dec(FSample);
  if FSample < 0 then
    FSample := SampleHub.Count-1;
  if FSample = -1 then //when SampleHub.Count = 0
    FSample := 0;
end;

procedure TSampleBundle.SetSample(const Value: Integer);
begin
  if (Value >= 0) and (Value < SampleCount)  then
  begin
    FSample := Value;
  end;
end;

function TSampleBundle.GetHub: Integer;
begin
  result := FHub;
end;

function TSampleBundle.GetHubCount: Integer;
begin
  result := FHubCount;
end;

function TSampleBundle.GetLevelCount: Integer;
begin
  result := FLevelCount;
end;

function TSampleBundle.GetSample: Integer;
begin
  result := FSample;
end;

function TSampleBundle.GetSampleCount: Integer;
begin
  result := SampleHub.Count;
end;

function TSampleBundle.GetMatrixCount: Integer;
begin
  result := SampleHub.Count * HubCount;
end;

function TSampleBundle.GetFederData(k: Integer): TFederData;
var
  h, s: Integer;
begin
  h := k div SampleCount;
  s := k mod SampleCount;
  if (h < HubCount) then
    GetSampleHubByIndex(h).LoadSample(Main.FederData, s);
  result := Main.FederData;
end;

end.


