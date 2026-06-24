unit FrmMain;

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
  System.Types,
  System.UITypes,
  System.Classes,
  System.Math.Vectors,
  System.UIConsts,
  FMX.Controls3D,
  FMX.Objects3D,
  FMX.Viewport3D,
  FMX.Types3D,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Memo.Types,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  RiggVar.Mesh.ReaderOBJ;

type
  TFormMain = class(TForm)
    Memo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    MeshReader: TMeshReaderOBJ;
    procedure TestBtnClick(Sender: TObject);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses
  RiggVar.Util.AppUtils,
  RiggVar.Mesh.TestData32;

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FormMain := self;

{$ifdef debug}
  ReportMemoryLeaksOnShutdown := True;
{$endif}

  FormatSettings.DecimalSeparator := '.';
  Caption := 'Federgraph ' + Application.Title.ToUpper;

  Memo.Align := TAlignLayout.Client;
  Memo.ControlType := TControlType.Styled;
  Memo.ShowScrollBars := True;
  Memo.StyleLookup := 'memostyle';
  Memo.StyledSettings := [TStyledSetting.FontColor, TStyledSetting.Other];
  Memo.TextSettings.Font.Family := TAppUtils.GetMonspacedFontFamilyName;
  Memo.TextSettings.Font.Size := 16;

  MeshReader := TMeshReaderOBJ.Create;
  MeshReader.LogList := Memo.Lines;

  TestBtnClick(nil);
end;

procedure TFormMain.TestBtnClick(Sender: TObject);
//var
//  fn: string;
begin
//  MeshReader.LoadTestData(MeshReader.SL);
//  MeshReader.Parse;

  LoadTestData(MeshReader.SL);
  MeshReader.Parse;

//  fn := TAppUtils.GetProjectDir + 'federgraph.obj';
//  MeshReader.LoadFromFile(fn);
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  MeshReader.Free;
end;

end.
