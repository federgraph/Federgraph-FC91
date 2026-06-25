unit RiggVar.Util.ActionSorter;

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
  System.Classes;

type
  TActionSorter = class
  private
    ML: TStringList;
    SL: TStringList;
    procedure Init;
  public
    WantCS: Boolean;
    WantJava: Boolean;
    constructor Create;
    destructor Destroy; override;

    procedure WriteActionConst(ASL: TStrings);
    procedure WriteActionNames(ASL: TStrings);
  end;

implementation

uses
  RiggVar.FB.ActionConst,
  RiggVar.FB.ActionName;

{ TActionSorter }

constructor TActionSorter.Create;
begin
  ML := TStringList.Create;
  SL := TStringList.Create;
// WantCS := True;
// WantJava := True;
end;

destructor TActionSorter.Destroy;
begin
  ML.Free;
  SL.Free;
  inherited;
end;

procedure TActionSorter.Init;
var
  fa: Integer;
begin
  for fa := 0 to faMax - 1 do
    ML.Add(GetFederActionName(fa));
end;

procedure TActionSorter.WriteActionConst(ASL: TStrings);
var
  i, j, k: Integer;
  s: string;
begin
  SL.Clear;
  ML.Clear;
  Init;

  j := -1;
  for i := 0 to ML.Count - 1 do
  begin
    s := ML[i];

    if s = '' then
    begin
      SL.Add('');
      Continue;
    end;

    if s.Trim.StartsWith('//') then
    begin
      SL.Add('');
      SL.Add(s);
      Continue;
    end;

    Inc(j);

    k := s.IndexOf('=');
    if k > 0 then
      s := s.Substring(0, s.IndexOf(' = '));

    s := s + ' = ' + IntToStr(j) + ';';

    if WantCS then
      s := 'public static int ' + s;
    if WantJava then
      s := 'public int ' + s;

    SL.Add(s);

  end;

  ASL.Text := SL.Text;
end;

procedure TActionSorter.WriteActionNames(ASL: TStrings);
var
  i: Integer;
  s: string;
begin
  SL.Clear;
  ML.Clear;
  Init;

  for i := 0 to ML.Count - 1 do
  begin
    s := ML[i];

    if s = '' then
    begin
      Continue;
    end;

    if s.Trim.StartsWith('//') then
    begin
      Continue;
    end;

    SL.Add(Format('%s: result := ''%s'';', [s, s]));
  end;

  ASL.Text := SL.Text;
end;

end.
