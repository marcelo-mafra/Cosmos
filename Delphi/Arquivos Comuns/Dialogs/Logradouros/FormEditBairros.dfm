object FrmEditBairros: TFrmEditBairros
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Bairros'
  ClientHeight = 406
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 9
    Width = 409
    Height = 108
    Transparent = False
    Caption = 'Pesquisa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label1: TLabel
      Left = 3
      Top = 18
      Width = 30
      Height = 13
      Caption = 'Pa&'#237'ses'
      FocusControl = FmeSearchDataPaises.EdtSearch
    end
    object Label2: TLabel
      Left = 219
      Top = 18
      Width = 38
      Height = 13
      Caption = '&Estados'
      FocusControl = FmeSearchDataEstados.EdtSearch
    end
    object Label3: TLabel
      Left = 3
      Top = 60
      Width = 38
      Height = 13
      Caption = '&Cidades'
      FocusControl = FmeSearchDataCidades.EdtSearch
    end
    inline FmeSearchDataPaises: TFmeSearchData
      Left = 0
      Top = 31
      Width = 192
      Height = 25
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
      inherited SbnButton: TSpeedButton
        Left = 167
      end
      inherited EdtSearch: TEdit
        Width = 163
      end
    end
    inline FmeSearchDataEstados: TFmeSearchData
      Left = 216
      Top = 31
      Width = 192
      Height = 25
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = True
      inherited SbnButton: TSpeedButton
        Left = 167
      end
      inherited EdtSearch: TEdit
        Width = 163
      end
    end
    inline FmeSearchDataCidades: TFmeSearchData
      Left = -1
      Top = 73
      Width = 314
      Height = 26
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = True
      inherited SbnButton: TSpeedButton
        Left = 289
      end
      inherited EdtSearch: TEdit
        Width = 285
      end
    end
    object BtnSearch: TButton
      Left = 333
      Top = 73
      Width = 75
      Height = 25
      Action = ActSearch
      TabOrder = 3
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 123
    Width = 323
    Height = 252
    Transparent = False
    Caption = 'Bairros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object SbnLocate: TSpeedButton
      Left = 296
      Top = 225
      Width = 23
      Height = 22
      Hint = 'Localizar!|Localiza uma cidade na grade de cidade'
      Enabled = False
      Flat = True
      Glyph.Data = {
        76060000424D7606000000000000360000002800000021000000100000000100
        18000000000040060000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F2F2F30303030
        30303037302F2F2FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF808080808080808080808080808080FF00FFFF00
        FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF303030E0E0E0
        DFDFDFD0C8BFC0AF7FBFA87F2F2F2FFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF808080E0E0E0DFDFDFD0C8BFC0AF7FBFA87F80
        8080FF00FF00FF00FF805F00806000FF00FFFF00FFFF00FFFF00FF2F2F2FEFE0
        BFFFFFF0FFFFFFFFF0D0E0D0A0B0985F7F702F2F2F2FFF00FFFF00FF80808080
        8080FF00FFFF00FFFF00FFFF00FF808080EFE0BFFFFFF0FFFFFFFFF0D0E0D0A0
        B0985F7F702F80808000805F00F0B000EFAF00806000FF00FFFF00FFFF00FF30
        3030EFDFB0FFF8EFFFFFFFF0E8D0D0C090AF975F706820303030FF00FF808080
        FF8080FF8080808080FF00FFFF00FFFF00FF808080EFDFB0FFF8EFFFFFFFF0E8
        D0D0C090AF975F70682080808000806000FFFF00F0B000F0B000806000FF00FF
        FF00FF303030EFE0BFFFF0E0FFFFFFF0E8D0DFC89FA08F50706820303030FF00
        FF808080C0C0C0FF8080808080808080FF00FFFF00FF808080EFE0BFFFF0E0FF
        FFFFF0E8D0DFC89FA08F5070682080808000FF00FF805F00FFFF00F0B000F0B0
        00805F00FF00FF303030EFDFB0FFF7EFFFFFFFF0E8D0DFC890AF905070672030
        3030FF00FFFF00FF808080C0C0C0FF8080FF8080808080FF00FF808080EFDFB0
        FFF7EFFFFFFFF0E8D0DFC890AF905070672080808000FF00FFFF00FF806000FF
        FF00FFD770805F00FF00FF2F2F2FFFEFCFFFF8EFFFFFFFEFE0CFDFC79FAF9050
        80702F2F2F2FFF00FFFF00FFFF00FF808080C0C0C0C0C0C0808080FF00FF8080
        80FFEFCFFFF8EFFFFFFFEFE0CFDFC79FAF905080702F80808000FF00FFFF00FF
        FF00FF806000805F00FFD770DFA77F806000805F008060007F58003030302F2F
        2F3030307F6F20303030FF00FFFF00FFFF00FFFF00FF808080808080C0C0C0DF
        A77F8080808080808080808080808080808080808080807F6F2080808000FF00
        FFFF00FFFF00FFFF00FFFF00FFDFA87F805F006F9F9FB0B070AFD8D0F0E8A080
        5F00C0A86F5F470F303030303030FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        DFA87F8080806F9F9FB0B070AFD8D0F0E8A0808080C0A86F8080808080808080
        8000FF00FFFF00FFFF00FFFF00FFFF00FF805F00AFFFFFB0FFFF7FAFAFC0F0EF
        CFFFFFFFFFC0805F00B098602F2F2FFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF808080AFFFFFB0FFFF7FAFAFC0F0EFCFFFFFFF8080808080B0986080
        8080FF00FF00FF00FFFF00FFFF00FFFF00FFFF00FF805F00FFFFA0AFFFFFAFFF
        FF7FAFAF7FB0B07FA8AF8060002F2F2FFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF808080FF8080C0C0C0C0C0C07FAFAF7FB0B07FA8AF808080
        808080FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FF806000AFFFFFB0
        FFFFAFFFFFAFFFFFAFFFFFFFFF9F805F00FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FF80
        80808080FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FF805F00
        FFFF9FAFFFFFB0FFFFAFFFFFAFFFFFAFFFFF806000FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FF8080C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0808080FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF805F00FFFF9FAFFFFFFFFF9FAFFFFF806000FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FF8080C0C0C0
        FF8080C0C0C0808080FF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF7F5800806000805F00806000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8080
        80808080808080808080FF00FFFF00FFFF00FFFF00FFFF00FF00}
      NumGlyphs = 2
      OnClick = SbnLocateClick
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 24
      Width = 319
      Height = 197
      DataSource = FmeDBDelButtons1.DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object EdtLocate: TEdit
      Left = 0
      Top = 226
      Width = 293
      Height = 21
      TabOrder = 1
      OnKeyUp = EdtLocateKeyUp
    end
  end
  inline FmeDBDelButtons1: TFmeDBDelButtons
    Left = 338
    Top = 155
    Width = 81
    Height = 171
    TabOrder = 2
    TabStop = True
    inherited ActionList1: TActionList
      inherited DataSetInsert1: TDataSetInsert
        Enabled = False
      end
      inherited DataSetPost1: TDataSetPost
        Enabled = False
      end
      inherited DataSetCancel1: TDataSetCancel
        Enabled = False
      end
      inherited DataSetDelete1: TDataSetDelete
        Enabled = False
      end
    end
    inherited DataSource1: TDataSource
      DataSet = CdsBairros
    end
  end
  object ChkAutoList: TCheckBox
    Left = 9
    Top = 384
    Width = 283
    Height = 17
    Caption = '&Listar bairros automaticamente ao selecionar a cidade'
    TabOrder = 3
  end
  object Button1: TButton
    Left = 342
    Top = 128
    Width = 75
    Height = 25
    Action = ActSelect
    ModalResult = 1
    TabOrder = 4
  end
  object CdsBairros: TClientDataSet
    Aggregates = <>
    ConnectionBroker = DM.CBroker
    IndexFieldNames = 'nombai'
    Params = <
      item
        DataType = ftInteger
        Name = 'codcid'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspBairros'
    AfterInsert = CdsBairrosAfterInsert
    BeforePost = CdsBairrosBeforePost
    AfterPost = CdsBairrosAfterPost
    BeforeDelete = CdsBairrosBeforeDelete
    AfterDelete = CdsBairrosAfterPost
    OnReconcileError = CdsBairrosReconcileError
    Left = 352
    Top = 320
  end
  object ActionList1: TActionList
    Left = 216
    Top = 144
    object ActSearch: TAction
      Caption = '&Pesquisar'
      Hint = 'Pesquisar|Lista os bairros da cidade selecionada'
      OnExecute = ActSearchExecute
      OnUpdate = ActSearchUpdate
    end
    object ActSelect: TAction
      Caption = 'S&elecionar'
      Hint = 
        'Selecionar|Seleciona o bairro atual como resultado da pesquisa d' +
        'e bairros'
      OnExecute = ActSelectExecute
      OnUpdate = ActSelectUpdate
    end
  end
end
