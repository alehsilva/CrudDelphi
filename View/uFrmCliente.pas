unit uFrmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uClienteControl;

type
  TfrmCadastroCliente = class(TForm)
    edtCodigo: TEdit;
    edtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    mmTableClientes: TFDMemTable;
    DBGrid1: TDBGrid;
    dsClientes: TDataSource;
    procedure FormShow(Sender: TObject);
  private
     procedure CarregarClientes;
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

{ TfrmCadastroCliente }

procedure TfrmCadastroCliente.CarregarClientes;
var
  VControleCliente : TClienteControl;
  VQry : TFDQuery;
begin
  VControleCliente := TClienteControl.Create;
  try
    VQry := VControleCliente.Obter;
    try
     VQry.FetchAll;
     mmTableClientes.Data := VQry.Data;
    finally
     VQry.Close;
     FreeAndNil(VQry);
    end;
  finally
    FreeAndNil(VControleCliente);
  end;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  Self.CarregarClientes();
end;

end.
