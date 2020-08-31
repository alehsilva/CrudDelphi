unit uFrmProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, uProdutoControl,
  uEnumerado, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmCadastroProduto = class(TForm)
    DBGrid1: TDBGrid;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    dsProdutos: TDataSource;
    mmTableProdutos: TFDMemTable;
    Image1: TImage;
    Image2: TImage;
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
// Alterar Produto
var
  VControleProduto: TProdutoControl;
  VNome: String;
  VCodigo: String;
begin
  VControleProduto := TProdutoControl.Create;
  try

    VCodigo := InputBox('Alterar',
      'Digite o código do Produto que deseja alterar', EmptyStr);
    VNome := InputBox('Alterar', 'Digite o novo nome do produto', EmptyStr);
    try
      VControleProduto.ProdutoModel.Acao := uEnumerado.tacAlterar;
      VControleProduto.ProdutoModel.Nome := VNome;
      VControleProduto.ProdutoModel.Codigo := StrToInt(VCodigo);
    except
      on E: EConvertError do
      begin
        ShowMessage
          ('Um dos valores digitados não corresponde com o formato do campo!');
      end;

    end;

    if VNome = '' then
    begin
      ShowMessage('O nome do produto não pode estar em branco!');
    end

    else
    begin

      if VControleProduto.Salvar then
      begin
        self.CarregarProdutos();
      end

      else if not VControleProduto.Salvar then
      begin
        ShowMessage('Não encontramos o produto');
      end;

    end;

  finally
    VControleProduto.Free;
  end;
end;

procedure TfrmCadastroProduto.btnExcluirClick(Sender: TObject);
// Excluir Produto
var
  VControleProduto: TProdutoControl;
  VCodigo: String;
  VNome: String;
begin
  VControleProduto := TProdutoControl.Create;
  VCodigo := InputBox('Excluir',
    'Digite o código do Produto que deseja excluir', EmptyStr);

  if VCodigo.Trim <> EmptyStr then
  begin
    if (Application.MessageBox('Deseja excluir o registro?', 'Confirmação',
      MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION) = mrYes) then
    begin
      try
        VControleProduto.ProdutoModel.Acao := uEnumerado.tacExcluir;
        VControleProduto.ProdutoModel.Nome := VNome;
        try
          VControleProduto.ProdutoModel.Codigo := StrToInt(VCodigo);
        except
          on E: EConvertError do
          begin
            ShowMessage(VCodigo + ' <- Não é um código válido!');

          end;

        end;
        try
          if VControleProduto.Salvar then
            self.CarregarProdutos();
        except
          on E: Exception do
            ShowMessage
              ('Não é possível excluir um produto que está vínculado a um pedido!');

      end;

    finally
      VControleProduto.Free;
    end;

  end;
end;
end;

procedure TfrmCadastroProduto.btnIncluirClick(Sender: TObject);
// Incluir Produto
var
  VControleProduto: TProdutoControl;
  VNome: String;
begin
  VControleProduto := TProdutoControl.Create;
  VNome := InputBox('Incluir', 'Digite o nome do produto', EmptyStr);
  try
    VControleProduto.ProdutoModel.Acao := uEnumerado.tacIncluir;
    VControleProduto.ProdutoModel.Nome := VNome;

    if VNome = '' then
    begin
      ShowMessage('O nome do produto não pode estar em branco!');
    end

    else
    begin
      if VControleProduto.Salvar then
        self.CarregarProdutos();
    end;

  finally
    VControleProduto.Free;
  end;
end;

procedure TfrmCadastroProduto.CarregarProdutos; // Carregar Produto
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
