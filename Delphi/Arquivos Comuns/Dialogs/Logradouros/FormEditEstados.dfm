object FrmEditEstados: TFrmEditEstados
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Estados'
  ClientHeight = 344
  ClientWidth = 406
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
  object MSGraphicHeader2: TMSGraphicHeader
    Left = 8
    Top = 60
    Width = 306
    Height = 17
    Caption = 'Estados Cadastrados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = False
  end
  object Label4: TLabel
    Left = 11
    Top = 9
    Width = 19
    Height = 13
    Caption = '&Pa'#237's'
    FocusControl = FmeSearchData1.EdtSearch
  end
  inline FmeSearchData1: TFmeSearchData
    Left = 7
    Top = 22
    Width = 308
    Height = 25
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TabStop = True
    inherited SbnButton: TSpeedButton
      Left = 283
    end
    inherited EdtSearch: TEdit
      Width = 279
    end
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 81
    Width = 305
    Height = 257
    Ctl3D = True
    DataSource = FmeDBDelButtons1.DataSource1
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NOMEST'
        Title.Caption = 'Estado'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGEST'
        Title.Caption = 'Sigla'
        Visible = True
      end>
  end
  inline FmeDBDelButtons1: TFmeDBDelButtons
    Left = 323
    Top = 63
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
      DataSet = CdsEstados
    end
  end
  object CdsEstados: TClientDataSet
    Aggregates = <>
    ConnectionBroker = DM.CBroker
    Params = <
      item
        DataType = ftInteger
        Name = 'codpai'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspEstados'
    AfterInsert = CdsEstadosAfterInsert
    AfterPost = CdsEstadosAfterPost
    BeforeDelete = CdsEstadosBeforeDelete
    AfterDelete = CdsEstadosAfterPost
    OnReconcileError = CdsEstadosReconcileError
    Left = 240
    Top = 128
  end
end
