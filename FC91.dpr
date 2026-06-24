program FC91;

uses
  System.StartUpCopy,
  FMX.Forms,
  FrmMain in 'App\FrmMain.pas' {FormMain},
  RiggVar.FB.Equation in 'FB\RiggVar.FB.Equation.pas',
  RiggVar.FB.MeshParams in 'FB\RiggVar.FB.MeshParams.pas',
  RiggVar.FederModel.Material in 'Model\RiggVar.FederModel.Material.pas',
  RiggVar.Mesh.BuilderMesh in 'Mesh\RiggVar.Mesh.BuilderMesh.pas',
  RiggVar.Mesh.MeshBuilder in 'Mesh\RiggVar.Mesh.MeshBuilder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Title := 'FC91U';
  Application.Run;
end.
