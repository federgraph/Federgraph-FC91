program FC91;

uses
  System.StartUpCopy,
  FMX.Forms,
  FrmMain in 'App\FrmMain.pas' {FormMain},
  RiggVar.App.Main in 'App\RiggVar.App.Main.pas',
  RiggVar.App.Main0 in 'App\RiggVar.App.Main0.pas',
  RiggVar.FB.Classes in 'FB\RiggVar.FB.Classes.pas',
  RiggVar.FB.Color in 'FB\RiggVar.FB.Color.pas',
  RiggVar.FB.ColorGroup in 'FB\RiggVar.FB.ColorGroup.pas',
  RiggVar.FB.Def in 'FB\RiggVar.FB.Def.pas',
  RiggVar.FB.DefConst in 'FB\RiggVar.FB.DefConst.pas',
  RiggVar.FB.Equation in 'FB\RiggVar.FB.Equation.pas',
  RiggVar.FB.ListArray in 'FB\RiggVar.FB.ListArray.pas',
  RiggVar.FB.MeshParams in 'FB\RiggVar.FB.MeshParams.pas',
  RiggVar.FB.ParamDef in 'FB\RiggVar.FB.ParamDef.pas',
  RiggVar.FB.Transform in 'FB\RiggVar.FB.Transform.pas',
  RiggVar.Mesh.BuilderMesh in 'Mesh\RiggVar.Mesh.BuilderMesh.pas',
  RiggVar.Mesh.ExporterOBJ in 'Mesh\RiggVar.Mesh.ExporterOBJ.pas',
  RiggVar.Mesh.FederShell1 in 'Mesh\RiggVar.Mesh.FederShell1.pas',
  RiggVar.Mesh.FederMesh in 'Mesh\RiggVar.Mesh.FederMesh.pas',
  RiggVar.Mesh.MeshBuilder in 'Mesh\RiggVar.Mesh.MeshBuilder.pas',
  RiggVar.Mesh.MeshDataHelper in 'Mesh\RiggVar.Mesh.MeshDataHelper.pas',
  RiggVar.Mesh.SolidPart in 'Mesh\RiggVar.Mesh.SolidPart.pas',
  RiggVar.Mesh.Stitcher in 'Mesh\RiggVar.Mesh.Stitcher.pas',
  RiggVar.MeshBuilder.BorderBand in 'MeshBuilder\RiggVar.MeshBuilder.BorderBand.pas',
  RiggVar.MeshBuilder.BorderBuilder in 'MeshBuilder\RiggVar.MeshBuilder.BorderBuilder.pas',
  RiggVar.MeshBuilder.BorderBuilder1 in 'MeshBuilder\RiggVar.MeshBuilder.BorderBuilder1.pas',
  RiggVar.FederModel.MaterialSources in 'Model\RiggVar.FederModel.MaterialSources.pas',
  RiggVar.FederModel.Material in 'Model\RiggVar.FederModel.Material.pas',
  RiggVar.Poly.Rack in 'Poly\RiggVar.Poly.Rack.pas',
  RiggVar.Poly.Rad in 'Poly\RiggVar.Poly.Rad.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'FC91R';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
