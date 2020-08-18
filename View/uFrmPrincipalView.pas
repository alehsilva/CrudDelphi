unit uFrmPrincipalView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConexao, Vcl.StdCtrls, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, System.Actions, Vcl.ActnList, Vcl.Menus,
  uFrmCliente;
type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Cliente1: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Cliente1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadastroCliente, frmCadastroCliente);
  try
    frmCadastroCliente.ShowModal;
  finally
    frmCadastroCliente.Release;
  end;
end;

initialization


end.
