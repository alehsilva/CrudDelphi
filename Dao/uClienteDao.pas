unit uClienteDao;

interface

uses
  FireDAC.Comp.Client, uConexao;

type
  TClienteDao = class
  private
    FConexao: TConexao;

  public
    constructor Create;

    function Obter : TFDQuery;

  end;
implementation

{ TClienteDao }

constructor TClienteDao.Create;
begin
  FConexao := TConexao.Create;
end;

function TClienteDao.Obter: TFDQuery;
var
  Vqry : TFDQuery;
begin
  Vqry := FConexao.CriarQuery();

  Vqry.Open('SELECT * FROM CLIENTES');

  Result :=  Vqry;
end;

end.
