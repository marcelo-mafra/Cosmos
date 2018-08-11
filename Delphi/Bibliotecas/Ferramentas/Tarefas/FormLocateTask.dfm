object FrmLocateTask: TFrmLocateTask
  Left = 0
  Top = 0
  ActiveControl = EdtSearchArgs
  BorderStyle = bsDialog
  Caption = 'Localizar'
  ClientHeight = 184
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
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
    object EdtSearchArgs: TEdit
      Left = 2
      Top = 43
      Width = 300
      Height = 21
      TabOrder = 0
      TextHint = 'Pesquisar por...'
      OnChange = EdtSearchArgsChange
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 82
    Width = 305
    Height = 97
    Transparent = True
    Caption = 'Op'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label2: TLabel
      Left = 2
      Top = 24
      Width = 36
      Height = 13
      Caption = 'Dire'#231#227'o'
    end
    object ChkPartial: TCheckBox
      Left = 2
      Top = 76
      Width = 207
      Height = 17
      Caption = 'Permitir o uso de argumentos parciais'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CbxDirecao: TComboBox
      Left = 2
      Top = 40
      Width = 175
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemIndex = 0
      TabOrder = 1
      Text = 'Em qualquer ponto da lista'
      Items.Strings = (
        'Em qualquer ponto da lista'
        'Abaixo da tarefa selecionada'
        'Acima da tarefa selecionada')
    end
  end
  object BtnFind: TButton
    Left = 336
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Pesquisar!'
    Enabled = False
    TabOrder = 2
    OnClick = BtnFindClick
  end
  object Button2: TButton
    Left = 336
    Top = 43
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = Button2Click
  end
end
