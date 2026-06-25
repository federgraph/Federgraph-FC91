unit RiggVar.Conn.MsgParser;

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
  RiggVar.Conn.MsgToken,
  RiggVar.FB.Classes;

type
  TCommandPathError = (
    Error_None,
    Error_TokenB,
    Error_TokenZ,
    Error_RunID,
    Error_Bib,
    Error_Command,
    Error_Value,
    Error_Pos,
    Error_Athlete,
    Error_MsgID,
    Error_Option
    );

  TMsgParser = class(TLineParser)
  private
    SL: TStringList;
    FIsValid: Boolean;
    FLastError: TCommandPathError;
    FInput: string;
    FKey: string;
    FValue: string;
    SLCompare: TStringList;
    sToken: string;
    sRest: string;
  protected
    procedure NextToken;
    function NextTokenX(TokenName: string): Integer;
    function TestTokenName(TokenName: string): Boolean;
    function CompareToken(t: string): string;
    function ParseLeaf: Boolean;
    //
    function ParseDivision: Boolean;
    function ParseRunID: Boolean;
    function ParseCommand: Boolean;
    //
    function ParseAthlete: Boolean;
    function ParseRace: Boolean;
    function ParseBib: Boolean;
    function ParsePos: Boolean;
    function ParseMsgID: Boolean;
    //
    function ParseValue: Boolean;
    function ParsePositiveIntegerValue: Boolean;
    function ParseIntegerValue: Boolean;
    //
    function IsRunID: Boolean;
    function IsProp(Token: string): Boolean;

    function ParseKeyValue(sKey, sValue: string): Boolean; override;
  public
    sAthlete: string;
    sPos: string;
    sMsgID: string;
    //
    sDivision: string;
    iRace: Integer;
    sRunID: string;
    sBib: string;
    sCommand: string;
    sValue: string;
    //
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
  end;

implementation

function TMsgParser.ParseAthlete: Boolean;
var
  temp: Integer;
begin
  temp := NextTokenX(cTokenID);
  if temp > -1 then
  begin
    sAthlete := sToken;
    result := True;
  end
  else
  begin
    sAthlete := '';
    result := False
  end;
  if not result then
    FLastError := Error_Athlete;
end;

function TMsgParser.ParseRace: Boolean;
var
  temp: Integer;
begin
  temp := NextTokenX(cTokenZ);
  if temp > -1 then
  begin
    sRunID := cTokenZ + sToken;
    iRace := StrToIntDef(sToken, 0);
    result := True;
  end
  else
  begin
    sRunID := '';
    result := False
  end;
  if not result then
    FLastError := Error_TokenZ;
end;

function TMsgParser.ParseBib: Boolean;
var
  temp: Integer;
begin
  temp := NextTokenX(cTokenY);
  if temp > -1 then
  begin
    sBib := sToken;
    result := True;
  end
  else
  begin
    sBib := '';
    result := False
  end;
  if not Result then
    FLastError := Error_Bib;
end;

function TMsgParser.ParseDivision: Boolean;
begin
  NextToken;
  SLCompare.Clear;
  SLCompare.Add(cTokenB);
  SLCompare.Add('*');
  sDivision := CompareToken(sToken);
  result := sDivision <> '';
  if not result then
    FLastError := Error_TokenB;
end;

function TMsgParser.ParseIntegerValue: Boolean;
begin
  result := StrToIntDef(FValue, MaxInt) <> MaxInt;
end;

function TMsgParser.ParsePos: Boolean;
var
  temp: Integer;
begin
  temp := NextTokenX('Pos');
  if temp > -1 then
  begin
    sPos := sToken;
    result := True;
  end
  else
  begin
    sPos := '';
    result := False
  end;
  if not result then
    FLastError := Error_Pos;
end;

function TMsgParser.ParsePositiveIntegerValue: Boolean;
begin
  result := StrToIntDef(FValue, -1) > -1;
end;

function TMsgParser.ParseRunID: Boolean;
begin
  NextToken;
  SLCompare.Clear;
  SLCompare.Add(cTokenZ + '1');
  sRunID := CompareToken(sToken);
  result := sRunID <> '';
  if not result then
    FLastError := Error_RunID;
end;

function TMsgParser.IsRunID: Boolean;
var
  s: string;
  i: Integer;
  RaceCount: Integer;
begin
//  if BO <> nil then
//    RaceCount := BO.BOParams.RaceCount
//  else
    RaceCount := 1;

  s := Copy(sRunID, 1, 1);
  i := StrToIntDef(Copy(sRunID, 2, Length(sRunID)), -1);
  result := (s = cTokenZ) and (i > 0) and (i <= RaceCount);
end;

constructor TMsgParser.Create;
begin
  inherited Create;
  SL := TStringList.Create;
  SLCompare := TStringList.Create;
end;

destructor TMsgParser.Destroy;
begin
  SL.Free;
  SLCompare.Free;
  inherited;
end;

procedure TMsgParser.Clear;
begin
  sAthlete := '';
  sDivision := '';
  sRunID := '';
  sBib := '';
  sCommand := '';
  sValue := '';
  sPos := '';
  //
  FLastError := Error_None;
  FIsValid := False;
  FInput := '';
  FKey := '';
  FValue := '';
end;

function TMsgParser.ParseKeyValue(sKey, sValue: string): Boolean;
begin
  result := False;
  Clear;
  FKey := sKey;
  FValue := sValue;
  FInput := sKey + '=' + sValue;
  sRest := sKey;

  if TestTokenName(cTokenA) then
    NextToken;

  if not ParseDivision then Exit;

  if TestTokenName('Msg') then
    if not ParseMsgID then Exit;

  if ParseLeaf then
  begin
    result := True;
    Exit;
  end;

  if TestTokenName(cTokenID) then
  begin
    if not ParseAthlete then Exit;
  end

  else
  begin
    if TestTokenName(cTokenZ) then
    begin
      if not ParseRace then Exit;
    end

    { RunID }
    else if not ParseRunID then exit;

    if TestTokenName('STL') then
    begin
      NextToken;

      { property Startlist.Count }
      if ParseLeaf then
      begin
        result := True;
        Exit;
      end;

      { Pos }
      if not ParsePos then Exit;
    end

    else if IsRunID then
    begin
      if TestTokenName('Pos') then
      begin
        { Pos }
        if not ParsePos then Exit;
      end
      else
      begin
        { Bib }
        if not ParseBib then Exit;
      end;
    end;
  end;

  result := ParseLeaf;
end;

function TMsgParser.ParseCommand: Boolean;
begin
  SLCompare.Clear;

  SLCompare.Add(cTokenXX);

  SLCompare.Add(cTokenX1);
  SLCompare.Add(cTokenX2);
  SLCompare.Add(cTokenX3);
  SLCompare.Add(cTokenX4);
  SLCompare.Add(cTokenX5);
  SLCompare.Add(cTokenX6);

  if sPos <> '' then
  begin
    SLCompare.Add(cTokenID);
    SLCompare.Add(cTokenBib);
  end;

  SLCompare.Add('Count');

  sCommand := CompareToken(sRest);
  result := sCommand <> '';
end;

function TMsgParser.ParseValue: Boolean;
begin
  sValue := '';
  result := False;

  if sCommand = cTokenXX then
    result := True

  else if
       (sCommand = cTokenID)
    or (sCommand = cTokenBib)
    or (sCommand = cTokenCount)
    or (sCommand = cTokenX1)
    or (sCommand = cTokenX2)
    or (sCommand = cTokenX3)
    or (sCommand = cTokenX4)
    or (sCommand = cTokenX5)
    or (sCommand = cTokenX6)
  then
    result := ParseIntegerValue; //ParesPositiveInteger

  if result then
    sValue := FValue;
end;

function TMsgParser.ParseMsgID: Boolean;
var
  temp: Integer;
begin
  temp := NextTokenX('Msg');
  if temp > -1 then
  begin
    sMsgID := sToken;
    result := True;
  end
  else
  begin
    sMsgID := '';
    result := False
  end;
  if not result then
    FLastError := Error_MsgID;
end;

procedure TMsgParser.NextToken;
begin
  sRest := TUtils.Cut('.', sRest, sToken);
end;

function TMsgParser.NextTokenX(TokenName: string): Integer;
var
  l: Integer;
begin
  NextToken;
  result := -1;
  if TUtils.StartsWith(sToken, TokenName) then
  begin
    l := Length(TokenName);
    sToken := Copy(sToken, l+1, Length(sToken) - l);
    result := StrToIntDef(sToken, -1);
  end;
end;

function TMsgParser.TestTokenName(TokenName: string): Boolean;
var
  LongTokenName: string;
begin
  LongTokenName := LongToken(TokenName);
  result := TUtils.StartsWith(sRest, TokenName) or TUtils.StartsWith(sRest, LongTokenName);
end;

function TMsgParser.CompareToken(t: string): string;
var
  i: Integer;
  s: string;
begin
  result := '';
  for i := 0 to SLCompare.Count-1 do
  begin
    s := SLCompare[i];
    if (t = s) or (t = LongToken(s)) then
    begin
      result := s;
      exit;
    end
  end;

  if IsProp(t) then
    result := t;
end;

function TMsgParser.IsProp(Token: string): Boolean;
begin
  result := TUtils.StartsWith(Token, 'Prop_');
end;

function TMsgParser.ParseLeaf: Boolean;
begin
  result := False;
  FIsValid := False;

  { Command }
  if not ParseCommand then
  begin
    FLastError := Error_Command;
    Exit;
  end;
  { Value }
  if not ParseValue then
  begin
    FLastError := Error_Value;
    Exit;
  end;

  FIsValid := True;
  result := True;
end;

end.
