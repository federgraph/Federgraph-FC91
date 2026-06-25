unit FrmConn;

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
  System.Rtti,
  System.Classes,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Controls.Presentation;

type
  TFormConn = class(TForm)
    edHost: TEdit;
    edPort: TEdit;
    HostLabel: TLabel;
    PortLabel: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
  end;

implementation

{$R *.fmx}

procedure TFormConn.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormConn.OKBtnClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

end.
