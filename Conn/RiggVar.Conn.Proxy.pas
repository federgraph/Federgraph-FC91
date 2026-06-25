unit RiggVar.Conn.Proxy;

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
  RiggVar.FB.Def;

const
  SpaceChar = '-';

type
  TProxyBase = class
  private
    i, c: Integer;
    SL: TStrings;
    Verbose: Boolean;
    FormatSettings: TFormatSettings;
    function GetCommaText: string;
    procedure SetCommaText(const Value: string);
  protected
    function CheckName(Name: string): Boolean;

    function ReadBoolean(Name: string): Boolean;
    function ReadCharacter(Name: string): char;
    function ReadDouble(Name: string): Double;
    function ReadInteger(Name: string): Integer;
    function ReadSingle(Name: string): Single;
    function ReadString(Name: string): string;

    procedure WriteBoolean(Name: string; Value: Boolean);
    procedure WriteDouble(Name: string; Value: Double);
    procedure WriteInteger(Name: string; Value: Integer);
    procedure WriteSingle(Name: string; Value: Single);
    procedure WriteString(Name, Value: string);

    procedure ReadSL; virtual;
    procedure WriteSL; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Dump(Memo: TStrings);
    procedure Update(ID: Integer); virtual;
    property CommaText: string read GetCommaText write SetCommaText;
  end;

  TFederProxy = class(TProxyBase)
  protected
    procedure ReadSL; override;
    procedure WriteSL; override;
  public
    SR: Integer; { Radius der kleinen Kreise }
    R1: Integer;
    R2: Integer;
    M1X: Integer;
    M1Y: Integer;
    M2X: Integer;
    M2Y: Integer;
    S1X: Integer;
    S2Y: Integer;
    S2X: Integer;
    S1Y: Integer;
  end;

implementation

{ TProxyBase }

procedure TProxyBase.Update(ID: Integer);
begin
  { virtual }
end;

function TProxyBase.GetCommaText: string;
begin
  SL.Clear;
  WriteSL;
  result := SL.CommaText;
end;

procedure TProxyBase.SetCommaText(const Value: string);
begin
  SL.CommaText := Value;
  i := 0;
  c := SL.Count;
  ReadSL;
end;

constructor TProxyBase.Create;
begin
  inherited Create;
  SL := TStringList.Create;
  Verbose := True;
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DecimalSeparator := '.';
end;

destructor TProxyBase.Destroy;
begin
  SL.Free;
  inherited;
end;

procedure TProxyBase.Dump(Memo: TStrings);
begin
  if Assigned(Memo) and Assigned(SL) then
  begin
    WriteSL;
    Memo.Assign(SL);
  end;
end;

function TProxyBase.CheckName(Name: string): Boolean;
var
  temp: Integer;
begin
  if Verbose then
  begin
    temp := Pos('=', SL[i]);
    result := Trim(Copy(SL[i], 1, temp - 1)) = Name;
    SL[i] := Trim(Copy(SL[i], temp + 1, Length(SL[i])));
  end
  else
  begin
    SL[i] := Trim(SL[i]);
    result := Length(SL[i]) > 0;
  end;
end;

function TProxyBase.ReadInteger(Name: string): Integer;
begin
  if i < c then
  begin
    CheckName(Name);
    result := StrToIntDef(SL[i], -1)
  end
  else
    result := -1;
  Inc(i);
end;

function TProxyBase.ReadDouble(Name: string): Double;
begin
  if i < c then
  begin
    CheckName(Name);
    result := StrToFloat(SL[i], FormatSettings)
  end
  else
    result := -1;
  Inc(i);
end;

function TProxyBase.ReadSingle(Name: string): Single;
begin
  if i < c then
  begin
    CheckName(Name);
    result := StrToFloat(SL[i], FormatSettings)
  end
  else
    result := -1;
  Inc(i);
end;

function TProxyBase.ReadString(Name: string): string;
begin
  if i < c then
  begin
    CheckName(Name);
    result := SL[i]
  end
  else
    result := '';
  Inc(i);
end;

function TProxyBase.ReadCharacter(Name: string): char;
begin
  if (i < c) and (Length(SL[i]) = 1) then
  begin
    CheckName(Name);
    result := SL[i][1]
  end
  else
    result := SpaceChar;
  Inc(i);
end;

function TProxyBase.ReadBoolean(Name: string): Boolean;
begin
  if i < c then
  begin
    CheckName(Name);
    result := (SL[i] = BoolStr[True])
  end
  else
    result := False;
  Inc(i);
end;

procedure TProxyBase.WriteString(Name, Value: string);
begin
  if Verbose then
    SL.Add(Name + '=' + Value)
  else
    SL.Add(Value);
end;

procedure TProxyBase.WriteInteger(Name: string; Value: Integer);
begin
  if Verbose then
    SL.Add(Name + '=' + IntToStr(Value))
  else
    SL.Add(IntToStr(Value));
end;

procedure TProxyBase.WriteSingle(Name: string; Value: Single);
begin
  if Verbose then
    SL.Add(Name + '=' + FloatToStr(Value, FormatSettings))
  else
    SL.Add(FloatToStr(Value));
end;

procedure TProxyBase.WriteDouble(Name: string; Value: Double);
begin
  if Verbose then
    SL.Add(Name + '=' + FloatToStr(Value, FormatSettings))
  else
    SL.Add(FloatToStr(Value));
end;

procedure TProxyBase.WriteBoolean(Name: string; Value: Boolean);
begin
  if Verbose then
    SL.Add(Name + '=' + BoolStr[Value])
  else
    SL.Add(BoolStr[Value]);
end;

procedure TProxyBase.ReadSL;
begin
  { virtual }
end;

procedure TProxyBase.WriteSL;
begin
  { virtual }
end;

{ TFederProxy }

procedure TFederProxy.ReadSL;
begin
  inherited;
  SR := ReadInteger('SR');
  R1 := ReadInteger('R1');
  R2 := ReadInteger('R2');
  M1X := ReadInteger('M1X');
  M1Y := ReadInteger('M1Y');
  M2X := ReadInteger('M2X');
  M2Y := ReadInteger('M2Y');
  S1X := ReadInteger('S1X');
  S1Y := ReadInteger('S1Y');
  S2X := ReadInteger('S2X');
  S2Y := ReadInteger('S2Y');
end;

procedure TFederProxy.WriteSL;
begin
  inherited;
  WriteInteger('SR', SR);
  WriteInteger('R1', R1);
  WriteInteger('R2', R2);
  WriteInteger('M1X', M1X);
  WriteInteger('M1Y', M1Y);
  WriteInteger('M2X', M2X);
  WriteInteger('M2Y', M2Y);
  WriteInteger('S1X', S1X);
  WriteInteger('S1Y', S1Y);
  WriteInteger('S2X', S2X);
  WriteInteger('S2Y', S2Y);
end;

end.
