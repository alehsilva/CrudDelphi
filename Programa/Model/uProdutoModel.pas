unit uProdutoModel;

interface

uses uEnumerado, FireDAC.Comp.Client;

type
  TProdutoModel = class
  private
    FAcao: TAcao;
    FCodigo: Integer;
    FNome: String;

    procedure SetAcao(const Value: TAcao);
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: String);

  public
    function Obter : TFDQuery;
    function Salvar : Boolean;
    function GetId(AAutoIncrementar: Integer) : integer;

    property Codigo : Integer read FCodigo write SetCodigo;
    property Nome : String read FNome write SetNome;
    property Acao : TAcao read FAcao write SetAcao;

   
  end;

implementation

{ TProdutoModel }

uses uProdutoDao;

function TProdutoModel.GetId(AAutoIncrementar: Integer): integer;
var
  VProdutoDao: TProdutoDao;
begin
  VProdutoDao := TProdutoDao.Create;
  try
    Result := VProdutoDao.GetId(AAutoIncrementar);
  finally
    VProdutoDao.Free;
  end;
end;


function TProdutoModel.Obter: TFDQuery;
var
  VProdutoDao : TProdutoDao;
begin
  VProdutoDao := TProdutoDao.Create;
  try
    Result := VProdutoDao.Obter;
  finally
    VProdutoDao.Free;
  end;
end;

function TProdutoModel.Salvar: Boolean;
var
  VProdutoDao : TProdutoDao;
begin
  Result := False;
  VProdutoDao := TProdutoDao.Create;
  try
  case FAcao of
    uEnumerado.tacIncluir:
      Result := VProdutoDao.Incluir(Self);
    uEnumerado.tacAlterar:
      Result := VProdutoDao.Alterar(Self);
    uEnumerado.tacExcluir:
      Result := VProdutoDao.Deletar(Self);
  end;
  finally
  VProdutoDao.Free;
  end;
end;

procedure TProdutoModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TProdutoModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TProdutoModel.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
