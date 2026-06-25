unit RiggVar.App.FolderInfo;

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
  System.SysUtils;

type
  TFolderInfo = class
  private
    FAppName: string;
    FWorkspacePath: string;
    FSettingsPath: string;
    FDataPath: string;
    FBackupPath: string;
    FHelpPath: string;
    FTracePath: string;
    function GetWorkspacePath: string;
    procedure SetDataPath(const Value: string);
    procedure SetSettingsPath(const Value: string);
    function GetConfigName: string;
    function GetAppName: string;
    function GetBackupPath: string;
    function GetDataPath: string;
    function GetSettingsPath: string;
    function GetHelpPath: string;
    function GetTracePath: string;
    function WorkspaceSubDir(dn: string): string;
  public
    property AppName: string read GetAppName;
    property WorkspacePath: string read GetWorkspacePath;
    property SettingsPath: string read GetSettingsPath write SetSettingsPath;
    property DataPath: string read GetDataPath write SetDataPath;
    property BackupPath: string read GetBackupPath;
    property HelpPath: string read GetHelpPath;
    property TracePath: string read GetTracePath;
    property ConfigFileName: string read GetConfigName;
  end;

implementation

uses
  RiggVar.Util.AppUtils;

resourcestring
  //StrWorkspace = 'Workspace';
  StrData = 'DBEvent';
  StrBackup = 'Backup';
  StrHelp = 'Help';
  StrTrace = 'Trace';
  StrSettings = 'Settings';
  StrConfigExtension = '.ini';

{ TFolderInfo}

procedure TFolderInfo.SetDataPath(const Value: string);
begin
  FDataPath := Value;
end;

procedure TFolderInfo.SetSettingsPath(const Value: string);
begin
  FSettingsPath := IncludeTrailingPathDelimiter(Value);
end;

function TFolderInfo.GetAppName: string;
begin
  if FAppName = '' then
  begin
    FAppName := ChangeFileExt(ExtractFileName(ParamStr(0)), '');
  end;
  result := FAppName;
end;

function TFolderInfo.GetWorkspacePath: string;
var
  dn: string;
begin
  if FWorkspacePath = '' then
  begin
{$ifdef MSWINDOWS}
    dn := TAppUtils.GetLocalDir;
{$endif}
{$ifdef MACOS}
    dn := TAppUtils.GetAppDataDir;
{$endif}
    begin
      //FWorkspacePath := IncludeTrailingPathDelimiter(dn) + StrWorkspace + '\';
      FWorkspacePath := IncludeTrailingPathDelimiter(dn);
      if not DirectoryExists(FWorkspacePath) then
        CreateDir(FWorkspacePath);
    end;
  end;
  result := FWorkspacePath;
end;

function TFolderInfo.WorkspaceSubDir(dn: string): string;
begin
  result := IncludeTrailingPathDelimiter(WorkspacePath + dn);
  if not DirectoryExists(result) then
    CreateDir(result);
end;

function TFolderInfo.GetConfigName: string;
begin
  result := SettingsPath + AppName + StrConfigExtension;
end;

function TFolderInfo.GetSettingsPath: string;
begin
  if FSettingsPath = '' then
  begin
    FSettingsPath := WorkspaceSubDir(StrSettings);
  end;
  result := FSettingsPath;
end;

function TFolderInfo.GetDataPath: string;
begin
  if FDataPath = '' then
  begin
    FDataPath := WorkspaceSubDir(StrData);
  end;
  result := FDataPath;
end;

function TFolderInfo.GetBackupPath: string;
begin
  if FBackupPath = '' then
  begin
    FBackupPath := WorkspaceSubDir(StrBackup);
  end;
  result := FBackupPath + AppName;
end;

function TFolderInfo.GetHelpPath: string;
begin
  if FHelpPath = '' then
  begin
    FHelpPath := WorkspaceSubDir(StrHelp);
  end;
  result := FHelpPath + AppName;
end;

function TFolderInfo.GetTracePath: string;
begin
  if FTracePath = '' then
  begin
    FTracePath := WorkspaceSubDir(StrTrace);
  end;
  result := FTracePath + AppName;
end;

end.
