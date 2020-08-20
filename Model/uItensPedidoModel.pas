unit uItensPedidoModel;

interface

uses uProdutoModel;

type
  TItensPedidoModel = class
    private
    FValorUnitario: Double;
    FQuantidade: Double;
    FCodPedido: Integer;
    FProduto: TProdutoModel;

    procedure SetCodPedido(const Value: Integer);
    procedure SetQuantidade(const Value: Double);
    procedure SetValorUnitario(const Value: Double);
    procedure SetProduto(const Value: TProdutoModel);


    public
      property CodPedido : Integer read FCodPedido write SetCodPedido;
      property Quantidade : Double read FQuantidade write SetQuantidade;
      property ValorUnitario : Double read FValorUnitario write SetValorUnitario;

      property Produto : TProdutoModel read FProduto write SetProduto;

      function TotalItem(ValorUnitario: Double; Quantidade: Double) : Double;
  end;

implementation

{ TItensPedidoModel }

procedure TItensPedidoModel.SetCodPedido(const Value: Integer);
begin
  FCodPedido := Value;
end;


procedure TItensPedidoModel.SetProduto(const Value: TProdutoModel);
begin
  FProduto := Value;
end;

procedure TItensPedidoModel.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TItensPedidoModel.SetValorUnitario(const Value: Double);
begin
  FValorUnitario := Value;
end;

function TItensPedidoModel.TotalItem(ValorUnitario, Quantidade: Double): Double;
var
  Total : Double;
begin
  Total := (Quantidade * ValorUnitario);
  Result := Total;
end;

end.
