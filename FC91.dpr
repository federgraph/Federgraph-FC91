program FC91;

uses
  System.StartUpCopy,
  FMX.Forms,
  FrmMain in 'App\FrmMain.pas' {FormMain},
  RiggVar.App.OpenSave in 'App\RiggVar.App.OpenSave.pas',
  RiggVar.FederModel.Material in 'Model\RiggVar.FederModel.Material.pas',
  RiggVar.Mesh.BuilderMesh in 'Mesh\RiggVar.Mesh.BuilderMesh.pas',
  RiggVar.Mesh.ReaderOBJ in 'Mesh\RiggVar.Mesh.ReaderOBJ.pas',
  RiggVar.Mesh.TestData32 in 'Mesh\RiggVar.Mesh.TestData32.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Title := 'FC91W';
  Application.Run;
end.
