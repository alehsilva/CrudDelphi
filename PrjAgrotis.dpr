program PrjAgrotis;

uses
  Vcl.Forms,
  uFrmPrincipalView in 'View\uFrmPrincipalView.pas' {Form1},
  uConexao in 'Dao\uConexao.pas',
  uEnumerado in 'Model\uEnumerado.pas',
  uClienteModel in 'Model\uClienteModel.pas' {$R *.res},
  uFrmCliente in 'View\uFrmCliente.pas' {frmCadastroCliente},
  uClienteDao in 'Dao\uClienteDao.pas',
  uClienteControl in 'Controller\uClienteControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
