object FrmMessagesConf: TFrmMessagesConf
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es de Mensagens'
  ClientHeight = 408
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    424
    408)
  PixelsPerInch = 96
  TextHeight = 13
  object GhAutenticacoes: TMSGroupHeader
    AlignWithMargins = True
    Left = 8
    Top = 14
    Width = 408
    Height = 107
    Margins.Left = 8
    Margins.Right = 8
    Margins.Bottom = 10
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Mensagens'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object ChkOpenMyMessage: TCheckBox
      Left = 0
      Top = 57
      Width = 361
      Height = 17
      Caption = 'Abrir a ferramentas "Minhas Mensagens" caso eu possua mensagens.'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object ChkNotify: TCheckBox
      Left = 0
      Top = 84
      Width = 321
      Height = 17
      Caption = 'Notificar-me ao detectar a exist'#234'ncia de mensagens n'#227'o lidas.'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object ChkNotifyOnStart: TCheckBox
      Left = 0
      Top = 29
      Width = 258
      Height = 17
      Caption = 'Verificar a exist'#234'ncia de mensagens ao inicializar.'
      TabOrder = 2
    end
  end
end
