object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Agrotis Teste'
  ClientHeight = 238
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Cliente1: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
    end
    object Pedido1: TMenuItem
      Caption = 'Pedido'
      object CadastrarPedido1: TMenuItem
        Caption = 'Cadastrar Pedido'
        OnClick = CadastrarPedido1Click
      end
    end
  end
end
