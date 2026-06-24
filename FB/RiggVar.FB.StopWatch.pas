unit RiggVar.FB.StopWatch;

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
  System.DateUtils;

type
  TStopWatch = class
  private
    FStartCount: Integer;
    FStopCount: Integer;
    procedure RecordTicks(var t: Integer);
    function GetElapsedMilliseconds: Integer;
  public
    procedure Start;
    procedure Stop;
    property ElapsedMilliseconds: Integer read GetElapsedMilliseconds;
  end;

implementation

{ TStopWatch }

function TStopWatch.GetElapsedMilliseconds: Integer;
begin
  if FStartCount > FStopCount then
    result := 1000 - FStartCount + FStopCount
  else
    result := FStopCount - FStartCount;
end;

procedure TStopWatch.RecordTicks(var t: Integer);
begin
  t := MilliSecondOf(Now);
end;

procedure TStopWatch.Start;
begin
  RecordTicks(FStartCount);
end;

procedure TStopWatch.Stop;
begin
  RecordTicks(FStopCount);
end;

end.
