program FC91;

uses
  System.StartUpCopy,
  FMX.Forms,
  FrmMain in 'App\FrmMain.pas' {FormMain},
  RiggVar.Mesh.ReaderOBJ in 'Mesh\RiggVar.Mesh.ReaderOBJ.pas',
  RiggVar.Mesh.TestData32 in 'Mesh\RiggVar.Mesh.TestData32.pas',
  RiggVar.Util.AppUtils in 'Util\RiggVar.Util.AppUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
