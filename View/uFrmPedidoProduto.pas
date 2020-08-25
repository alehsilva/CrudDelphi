unit uFrmPedidoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.StdCtrls, uProdutoControl, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.DApt, Vcl.Mask, uFrmPedido;

type
  TPedidoProduto = class(TForm)
    DBLProdutos: TDBLookupComboBox;
    dsProdutos: TDataSource;
    btnInserir: TButton;
    btnCancelar: TButton;
    queryProdutos: TFDQuery;
    Label1: TLabel;
    Quantidade: TLabel;
    Label2: TLabel;
    edtQtde: TEdit;
    edtVlrUnitario: TEdit;
    procedure btnInserirClick(Sender: TObject);
    procedure edtTotalItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FCodProd: Integer;
    FQtde: Double;
    FVlrUnitario: Double;
    procedure CarregarProdutos;
    procedure SetCodProd(const Value: Integer);
    procedure SetQtde(const Value: Double);
    procedure SetVlrUnitario(const Value: Double);
  public
    property CodProd: Integer read FCodProd write SetCodProd;
    property Qtde: Double read FQtde write SetQtde;
    property VlrUnitario: Double read FVlrUnitario write SetVlrUnitario;

    function ValorTotal: Double;

  end;

var
  PedidoProduto: TPedidoProduto;

implementation

{$R *.dfm}

uses uFrmPrincipalView, uItensPedidoControl;

{ TForm2 }

procedure TPedidoProduto.btnInserirClick(Sender: TObject);
var
  VControleItensPedido: TItensPedidoControl;
begin

  CodProd := DBLProdutos.ListSource.DataSet.FieldByName('COD_PROD').Value;
  Qtde := StrToFloat(edtQtde.Text);
  VlrUnitario := StrToFloat(edtVlrUnitario.Text);

  frmPedido.dsItens.DataSet.FieldByName('COD_PROD').AsInteger := CodProd;
  frmPedido.dsItens.DataSet.FieldByName('QUANTIDADE').AsFloat := Qtde;
  frmPedido.dsItens.DataSet.FieldByName('VALORUNITARIO').AsFloat := VlrUnitario;
  frmPedido.dsItens.DataSet.FieldByName('TOTALITEM').AsFloat := ValorTotal();

  frmPedido.CalculaTotalPedido();

  PedidoProduto.Close;
end;

procedure TPedidoProduto.CarregarProdutos;
var
  VProdutoControl: TProdutoControl;

begin
  VProdutoControl := TProdutoControl.Create;
  try
    queryProdutos := VProdutoControl.Obter;
    queryProdutos.FetchAll;

    DBLProdutos.ListSource.DataSet := queryProdutos;
    DBLProdutos.KeyField := 'COD_PROD';
    DBLProdutos.ListField := 'DESC_PROD';
    DBLProdutos.DataSource := frmPedido.dsItens;
    DBLProdutos.DataField := 'COD_PROD';

  finally
    FreeAndNil(VProdutoControl);
  end;

end;

procedure TPedidoProduto.edtTotalItemClick(Sender: TObject);
begin
  ValorTotal();
end;

procedure TPedidoProduto.FormShow(Sender: TObject);
begin
  self.CarregarProdutos();
end;

procedure TPedidoProduto.SetCodProd(const Value: Integer);
begin
  FCodProd := Value;
end;

procedure TPedidoProduto.SetQtde(const Value: Double);
begin
  FQtde := Value;
end;

procedure TPedidoProduto.SetVlrUnitario(const Value: Double);
begin
  FVlrUnitario := Value;
end;

function TPedidoProduto.ValorTotal: Double;
var

  Total: Double;
begin

  Total := StrToFloat(edtQtde.Text) * StrToFloat(edtVlrUnitario.Text);
  Result := Total;
end;

end.
