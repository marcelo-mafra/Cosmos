object FrmFechamentoCaixa: TFrmFechamentoCaixa
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sum'#225'rio de Caixa'
  ClientHeight = 336
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    524
    336)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 292
    Width = 508
    Height = 5
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
    ExplicitWidth = 393
  end
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 16
    Width = 508
    Height = 73
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Dados do Caixa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label5: TLabel
      Left = 16
      Top = 24
      Width = 86
      Height = 13
      Caption = 'N'#250'mero do Caixa:'
    end
    object LblNumcaixa: TLabel
      Left = 160
      Top = 24
      Width = 59
      Height = 13
      Caption = 'LblNumcaixa'
    end
    object Label7: TLabel
      Left = 16
      Top = 43
      Width = 65
      Height = 13
      Caption = 'Respons'#225'vel:'
    end
    object LblResponsavel: TLabel
      Left = 160
      Top = 43
      Width = 74
      Height = 13
      Caption = 'LblResponsavel'
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 104
    Width = 508
    Height = 65
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Recebimentos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label1: TLabel
      Left = 16
      Top = 23
      Width = 115
      Height = 13
      Caption = 'Totais de recebimentos:'
    end
    object Label2: TLabel
      Left = 16
      Top = 43
      Width = 118
      Height = 13
      Caption = 'Valores totais recebidos:'
    end
    object LblTotaisRecebidos: TLabel
      Left = 160
      Top = 24
      Width = 91
      Height = 13
      Caption = 'LblTotaisRecebidos'
    end
    object LblValoresRecebidos: TLabel
      Left = 160
      Top = 43
      Width = 97
      Height = 13
      Caption = 'LblValoresRecebidos'
    end
  end
  object MSGroupHeader3: TMSGroupHeader
    Left = 8
    Top = 184
    Width = 508
    Height = 65
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Pagamentos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 110
      Height = 13
      Caption = 'Totais de Pagamentos:'
    end
    object Label4: TLabel
      Left = 16
      Top = 45
      Width = 101
      Height = 13
      Caption = 'Valores totais pagos:'
    end
    object LblTotaisPagos: TLabel
      Left = 160
      Top = 24
      Width = 71
      Height = 13
      Caption = 'LblTotaisPagos'
    end
    object LblValoresPagos: TLabel
      Left = 160
      Top = 45
      Width = 77
      Height = 13
      Caption = 'LblValoresPagos'
    end
  end
  object ChkShowMummary: TCheckBox
    Left = 8
    Top = 266
    Width = 249
    Height = 17
    Caption = 'Exibir esse sum'#225'rio ao fechar os meus caixas'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object Button1: TButton
    Left = 441
    Top = 303
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Fechar'
    ModalResult = 2
    TabOrder = 4
  end
end
