object FrmLocateTask: TFrmLocateTask
  Left = 0
  Top = 0
  ActiveControl = EdtArgument
  BorderStyle = bsDialog
  Caption = 'Localizar'
  ClientHeight = 172
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 8
    Width = 305
    Height = 71
    Transparent = True
    Caption = 'Pesquisa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label1: TLabel
      Left = 2
      Top = 24
      Width = 53
      Height = 13
      Caption = 'Argumento'
    end
    object EdtArgument: TEdit
      Left = 2
      Top = 43
      Width = 300
      Height = 21
      TabOrder = 0
      TextHint = 'Pesquisar por...'
      OnChange = EdtArgumentChange
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 82
    Width = 305
    Height = 82
    Transparent = True
    Caption = 'Op'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object ChkPartialKey: TCheckBox
      Left = 2
      Top = 52
      Width = 207
      Height = 17
      Caption = 'Permitir o uso de argumentos parciais'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object ChkAllItems: TCheckBox
      Left = 2
      Top = 29
      Width = 167
      Height = 17
      Caption = 'Em qualquer ponto da lista'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 1
    end
  end
  object BtnFind: TButton
    Left = 327
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Pesquisar!'
    Enabled = False
    TabOrder = 2
    OnClick = BtnFindClick
  end
  object Button2: TButton
    Left = 327
    Top = 43
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = Button2Click
  end
end
