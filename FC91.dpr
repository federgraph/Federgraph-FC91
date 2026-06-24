program FC91;

uses
  System.StartUpCopy,
  FMX.Forms,
  FrmMain in 'App\FrmMain.pas' {FormMain},
  RiggVar.FB.Equation in 'FB\RiggVar.FB.Equation.pas',
  RiggVar.FB.MeshParams in 'FB\RiggVar.FB.MeshParams.pas',
  RiggVar.FB.Def in 'FB\RiggVar.FB.Def.pas',
  RiggVar.FB.DefConst in 'FB\RiggVar.FB.DefConst.pas',
  RiggVar.FB.ListArray in 'FB\RiggVar.FB.ListArray.pas',
  RiggVar.FB.ParamDef in 'FB\RiggVar.FB.ParamDef.pas',
  RiggVar.FederModel.Material in 'Model\RiggVar.FederModel.Material.pas',
  RiggVar.Mesh.BuilderMesh in 'Mesh\RiggVar.Mesh.BuilderMesh.pas',
  RiggVar.Mesh.MeshBuilder in 'Mesh\RiggVar.Mesh.MeshBuilder.pas',
  RiggVar.Mesh.ReaderOBJ in 'Mesh\RiggVar.Mesh.ReaderOBJ.pas',
  RiggVar.Mesh.Stitcher in 'Mesh\RiggVar.Mesh.Stitcher.pas',
  RiggVar.Mesh.TestData32 in 'Mesh\RiggVar.Mesh.TestData32.pas',
  RiggVar.Poly.Rack in 'Poly\RiggVar.Poly.Rack.pas',
  RiggVar.Poly.Rad in 'Poly\RiggVar.Poly.Rad.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Title := 'FC91S';
  Application.Run;
end.
