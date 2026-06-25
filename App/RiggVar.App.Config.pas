unit RiggVar.App.Config;

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
  System.IniFiles;

type
  TIniImage = class
  protected
    ini: TCustomIniFile;
  public
    Host: string;
    Port: Integer;
    UseUnicode: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure ReadIni;
    procedure WriteIni;
  end;

implementation

uses
  RiggVar.App.Main,
  RiggVar.App.FolderInfo;

const
  StrSection = 'Connections';

{ TIniImage }

{$ifdef MSWINDOWS}
constructor TIniImage.Create;
begin
  ReadIni;
end;

destructor TIniImage.Destroy;
begin
  WriteIni;
  inherited;
end;

procedure TIniImage.ReadIni;
var
  fn: string;
  SL: TStringList;
begin
  fn := Main.FolderInfo.ConfigFileName;
  if not FileExists(fn) then
  begin
    SL := TStringList.Create;
    try
      SL.Add('[Connections]');
      SL.Add('Host=localhost');
      if Main.IsInputClient then
        SL.Add('Port=3427')
      else
        SL.Add('Port=3428');
      SL.SaveToFile(fn);
    finally
      SL.Free;
    end;
  end;
  if not FileExists(fn) then
    Exit;
  ini := TIniFile.Create(fn);
  try
    Host := ini.ReadString(StrSection, 'Host', 'localhost');
    if Main.IsInputClient then
      Port := ini.ReadInteger(StrSection, 'Port', 3427)
    else
    Port := ini.ReadInteger(StrSection, 'Port', 3428);
  finally
    ini.Free;
  end;
end;

procedure TIniImage.WriteIni;
var
  fn: string;
begin
  fn := Main.FolderInfo.ConfigFileName;
  if not FileExists(fn) then
    Exit;
  ini := TIniFile.Create(fn);
  try
    ini.WriteString(StrSection, 'Host', Host);
    ini.WriteInteger(StrSection, 'Port', Port);
  finally
    ini.Free;
  end;
end;
{$endif}

{$ifdef MACOS}
constructor TIniImage.Create;
begin
//  ini := TApplePreferencesIniFile.Create;
//  ReadIni;
end;

destructor TIniImage.Destroy;
begin
//  WriteIni;
//  ini.UpdateFile;
//  ini.Free;
//  inherited Destroy;
end;

procedure TIniImage.ReadIni;
begin
//  Host := ini.ReadString(StrSection, 'Host', 'localhost');
//  if Main.IsInputClient then
//    Port := ini.ReadInteger(StrSection, 'Port', 3427)
//  else
//    Port := ini.ReadInteger(StrSection, 'Port', 3428);
end;

procedure TIniImage.WriteIni;
begin
//  ini.WriteString(StrSection, 'Host', Host);
//  ini.WriteInteger(StrSection, 'Port', Port);
end;
{$endif}

end.

