object FrmEditCidades: TFrmEditCidades
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Cidades'
  ClientHeight = 406
  ClientWidth = 425
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
    Width = 321
    Height = 103
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
      Left = 3
      Top = 61
      Width = 38
      Height = 13
      Caption = '&Estados'
      FocusControl = FmeSearchDataEstados.EdtSearch
    end
    inline FmeSearchDataPaises: TFmeSearchData
      Left = 0
      Top = 31
      Width = 322
      Height = 25
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
      inherited SbnButton: TSpeedButton
        Left = 297
      end
      inherited EdtSearch: TEdit
        Width = 293
      end
    end
    inline FmeSearchDataEstados: TFmeSearchData
      Left = 0
      Top = 74
      Width = 322
      Height = 25
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = True
      inherited SbnButton: TSpeedButton
        Left = 297
      end
      inherited EdtSearch: TEdit
        Width = 293
      end
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 123
    Width = 324
    Height = 252
    Transparent = False
    Caption = 'Cidades'
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
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF2F2F2F3030303030303037302F2F2FFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF303030E0E0E0DFDFDFD0C8BFC0AF
        7FBFA87F2F2F2FFF00FFFF00FF805F00806000FF00FFFF00FFFF00FFFF00FF2F
        2F2FEFE0BFFFFFF0FFFFFFFFF0D0E0D0A0B0985F7F702F2F2F2F805F00F0B000
        EFAF00806000FF00FFFF00FFFF00FF303030EFDFB0FFF8EFFFFFFFF0E8D0D0C0
        90AF975F706820303030806000FFFF00F0B000F0B000806000FF00FFFF00FF30
        3030EFE0BFFFF0E0FFFFFFF0E8D0DFC89FA08F50706820303030FF00FF805F00
        FFFF00F0B000F0B000805F00FF00FF303030EFDFB0FFF7EFFFFFFFF0E8D0DFC8
        90AF9050706720303030FF00FFFF00FF806000FFFF00FFD770805F00FF00FF2F
        2F2FFFEFCFFFF8EFFFFFFFEFE0CFDFC79FAF905080702F2F2F2FFF00FFFF00FF
        FF00FF806000805F00FFD770DFA77F806000805F008060007F58003030302F2F
        2F3030307F6F20303030FF00FFFF00FFFF00FFFF00FFFF00FFDFA87F805F006F
        9F9FB0B070AFD8D0F0E8A0805F00C0A86F5F470F303030303030FF00FFFF00FF
        FF00FFFF00FFFF00FF805F00AFFFFFB0FFFF7FAFAFC0F0EFCFFFFFFFFFC0805F
        00B098602F2F2FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF805F00FFFFA0AF
        FFFFAFFFFF7FAFAF7FB0B07FA8AF8060002F2F2FFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF806000AFFFFFB0FFFFAFFFFFAFFFFFAFFFFFFFFF9F805F
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF805F00FFFF9FAF
        FFFFB0FFFFAFFFFFAFFFFFAFFFFF806000FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF805F00FFFF9FAFFFFFFFFF9FAFFFFF806000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F
        5800806000805F00806000FF00FFFF00FFFF00FFFF00FFFF00FF}
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
      OnKeyPress = EdtLocateKeyPress
      OnKeyUp = EdtLocateKeyUp
    end
  end
  object BtnSearch: TButton
    Left = 346
    Top = 42
    Width = 75
    Height = 25
    Caption = '&Pesquisar!'
    Enabled = False
    TabOrder = 2
    OnClick = BtnSearchClick
  end
  inline FmeDBDelButtons1: TFmeDBDelButtons
    Left = 342
    Top = 127
    Width = 81
    Height = 171
    TabOrder = 3
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
      DataSet = CdsCidades
    end
  end
  object ChkAutoList: TCheckBox
    Left = 9
    Top = 384
    Width = 283
    Height = 17
    Caption = '&Listar cidades automaticamente ao selecionar o estado'
    TabOrder = 4
  end
  object CdsCidades: TClientDataSet
    Aggregates = <>
    ConnectionBroker = DM.CBroker
    Params = <
      item
        DataType = ftInteger
        Name = 'codest'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspCidades'
    AfterInsert = CdsCidadesAfterInsert
    BeforePost = CdsCidadesBeforePost
    AfterPost = CdsCidadesAfterPost
    BeforeDelete = CdsCidadesBeforeDelete
    AfterDelete = CdsCidadesAfterPost
    OnReconcileError = CdsCidadesReconcileError
    Left = 352
    Top = 320
  end
end
