unit uItensPedidoControl;

interface

uses uItensPedidoModel, System.SysUtils, FireDAC.Comp.Client;
  type
    TItensPedidoControl = class
      private
        FItensPedidoModel : TItensPedidoModel;

      public

        constructor Create;
        destructor Destroy; override;

        function Salvar : Boolean;

        property ItensPedidoModel : TItensPedidoModel read FItensPedidoModel write FItensPedidoModel;
    end;

implementation

{ TItensPedidoControl }

constructor TItensPedidoControl.Create;
begin
    FItensPedidoModel := TItensPedidoModel.Create;
end;

destructor TItensPedidoControl.Destroy;
begin

  inherited;
end;



function TItensPedidoControl.Salvar: Boolean;
begin
  Result := FItensPedidoModel.SalvarItem;
end;

end.
