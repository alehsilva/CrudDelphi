unit uFrmProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, uProdutoControl,
  uEnumerado;

type
  TfrmCadastroProduto = class(TForm)
    edtCodigo: TEdit;
    edtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    dsProdutos: TDataSource;
    mmTableProdutos: TFDMemTable;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure CarregarProdutos;
  public
    { Public declarations }
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}

{ TfrmCadastroProduto }

procedure TfrmCadastroProduto.btnAlterarClick(Sender: TObject);
var VControleProduto : TProdutoControl;
begin
    VControleProduto := TProdutoControl.Create;
    try
      VControleProduto.ProdutoModel.Acao := uEnumerado.tacAlterar;
      VControleProduto.ProdutoModel.Nome := edtNome.Text;
      VControleProduto.ProdutoModel.Codigo := StrToInt(edtCodigo.Text);

      if VControleProduto.Salvar then
        ShowMessage('Alterado com sucesso!');

      self.CarregarProdutos();
    finally
      VControleProduto.Free;
    end;
end;

procedure TfrmCadastroProduto.btnExcluirClick(Sender: TObject);
var
 VControleProduto : TProdutoControl;
 VCodigo : String;
begin
  VControleProduto := TProdutoControl.Create;
  VCodigo := InputBox('Excluir', 'Digite o código do Produto', EmptyStr);

  if VCodigo.Trim <> EmptyStr then
  begin
    if (Application.MessageBox('Deseja excluir o registro?', 'Confirmação',
      MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION) = mrYes) then
    begin
      try
        VControleProduto.ProdutoModel.Acao := uEnumerado.tacExcluir;
        VControleProduto.ProdutoModel.Nome := edtNome.Text;
        VControleProduto.ProdutoModel.Codigo := StrToInt(VCodigo);

        if VControleProduto.Salvar then
          ShowMessage('Excluido com sucesso!');

        self.CarregarProdutos();
      finally
        VControleProduto.Free;
      end;
    end;
  end;
end;

procedure TfrmCadastroProduto.btnIncluirClick(Sender: TObject);
var
  VControleProduto : TProdutoControl;
begin
  VControleProduto := TProdutoControl.Create;
  try
    VControleProduto.ProdutoModel.Acao := uEnumerado.tacIncluir;
    VControleProduto.ProdutoModel.Nome := edtNome.Text;

    if VControleProduto.Salvar then
     ShowMessage('Incluído com sucesso!');

    self.CarregarProdutos();
  finally
    VControleProduto.Free;
  end;
end;

procedure TfrmCadastroProduto.CarregarProdutos;
var
  VControleProduto: TProdutoControl;
  Vqry: TFDQuery;
begin
  VControleProduto := TProdutoControl.Create;
  try
   Vqry := VControleProduto.Obter;
     try
       Vqry.FetchAll;
       mmTableProdutos.Close;
       mmTableProdutos.Data := Vqry.Data;
     finally
       Vqry.Close;
       FreeAndNil(Vqry);
   end;
  finally
   FreeAndNil(VControleProduto);
  end;
end;
procedure TfrmCadastroProduto.FormShow(Sender: TObject);
begin
   self.CarregarProdutos();
end;

end.
