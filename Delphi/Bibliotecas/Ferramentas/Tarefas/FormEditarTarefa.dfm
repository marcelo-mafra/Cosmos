object FrmEditartarefa: TFrmEditartarefa
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tarefa'
  ClientHeight = 512
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 16
    Width = 468
    Height = 217
    Transparent = True
    Caption = 'Tarefa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label1: TLabel
      Left = 0
      Top = 25
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label2: TLabel
      Left = 0
      Top = 75
      Width = 41
      Height = 13
      Caption = 'Situa'#231#227'o'
    end
    object Label3: TLabel
      Left = 224
      Top = 75
      Width = 47
      Height = 13
      Caption = 'Categoria'
    end
    object Label7: TLabel
      Left = 0
      Top = 128
      Width = 35
      Height = 13
      Caption = 'Criador'
    end
    object Label8: TLabel
      Left = 224
      Top = 130
      Width = 34
      Height = 13
      Caption = 'M'#243'dulo'
    end
    object Label9: TLabel
      Left = 0
      Top = 174
      Width = 36
      Height = 13
      Caption = 'Cria'#231#227'o'
    end
    object Label10: TLabel
      Left = 224
      Top = 176
      Width = 49
      Height = 13
      Caption = 'Conclus'#227'o'
    end
    object EdtDescricao: TEdit
      Left = 0
      Top = 42
      Width = 457
      Height = 21
      TabOrder = 0
      TextHint = 'informe a descri'#231#227'o da tarefa...'
    end
    object CBXSituacao: TComboBox
      Left = 0
      Top = 92
      Width = 185
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        'Aberta'
        'Cancelada'
        'Suspensa'
        'Conclu'#237'da')
    end
    object CBXCategoria: TComboBox
      Left = 224
      Top = 92
      Width = 233
      Height = 21
      Sorted = True
      TabOrder = 2
      TextHint = 'Escolha uma categoria'
      Items.Strings = (
        'Atividades'
        'Controle de Freq'#252#234'ncia'
        'Hist'#243'rico Discipular'
        'Instala'#231#245'es'
        'Programa'#231#227'o de Confer'#234'ncia'
        'Sincroniza'#231#227'o de Dados')
    end
    object EdtCreator: TEdit
      Left = 0
      Top = 145
      Width = 185
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object EdtModule: TEdit
      Left = 224
      Top = 145
      Width = 233
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object EdtCreateDate: TEdit
      Left = 0
      Top = 191
      Width = 185
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object EdtConcludeDate: TEdit
      Left = 224
      Top = 191
      Width = 233
      Height = 21
      Enabled = False
      TabOrder = 6
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 249
    Width = 468
    Height = 218
    Transparent = True
    Caption = 'Detalhamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label4: TLabel
      Left = 0
      Top = 27
      Width = 48
      Height = 13
      Caption = 'Prioridade'
    end
    object Label5: TLabel
      Left = 0
      Top = 84
      Width = 28
      Height = 13
      Caption = 'Notas'
    end
    object Label6: TLabel
      Left = 271
      Top = 27
      Width = 48
      Height = 13
      Caption = 'Data-Alvo'
    end
    object CBXPrioridade: TComboBox
      Left = 0
      Top = 44
      Width = 185
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        'Baixa'
        'M'#233'dia'
        'Alta'
        'M'#225'xima')
    end
    object MmoNotes: TMemo
      Left = 0
      Top = 103
      Width = 457
      Height = 114
      Lines.Strings = (
        '')
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object EdtGoalDate: TDateTimePicker
      Left = 271
      Top = 44
      Width = 186
      Height = 21
      Date = 40379.934531030090000000
      Time = 40379.934531030090000000
      TabOrder = 2
    end
  end
  object BtnNew: TButton
    Left = 225
    Top = 477
    Width = 75
    Height = 25
    Caption = '&Nova'
    TabOrder = 2
    OnClick = BtnNewClick
  end
  object BtnSave: TButton
    Left = 313
    Top = 477
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = BtnSaveClick
  end
  object Button3: TButton
    Left = 401
    Top = 477
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 4
    OnClick = Button3Click
  end
end
