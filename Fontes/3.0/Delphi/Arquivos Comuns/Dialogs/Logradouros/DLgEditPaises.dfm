object FrmDlgPaises: TFrmDlgPaises
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pa'#237'ses'
  ClientHeight = 303
  ClientWidth = 380
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
  object Label1: TLabel
    Left = 6
    Top = 7
    Width = 94
    Height = 13
    Caption = '&Pa'#237'ses Cadastrados'
    FocusControl = FmeGridSearchPaises.DBGrid1
  end
  inline FmeDBDelButtons1: TFmeDBDelButtons
    Left = 298
    Top = 20
    Width = 81
    Height = 171
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 298
    ExplicitTop = 20
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
      DataSet = CdsPaises
    end
  end
  inline FmeGridSearchPaises: TFmeGridSearch
    Left = 1
    Top = 20
    Width = 297
    Height = 281
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TabStop = True
    ExplicitLeft = 1
    ExplicitTop = 20
    ExplicitWidth = 297
    ExplicitHeight = 281
    inherited SbnSearch: TSpeedButton
      Left = 271
      Top = 257
      ExplicitLeft = 271
      ExplicitTop = 257
    end
    inherited DBGrid1: TDBGrid
      Width = 293
      Height = 252
      DataSource = FmeDBDelButtons1.DataSource1
    end
    inherited EdtSearch: TEdit
      Top = 257
      Width = 267
      ExplicitTop = 257
      ExplicitWidth = 267
    end
  end
  object CdsPaises: TClientDataSet
    Aggregates = <>
    ConnectionBroker = DM.CBroker
    Params = <>
    ProviderName = 'DspPaises'
    AfterInsert = CdsPaisesAfterInsert
    AfterPost = CdsPaisesAfterPost
    BeforeDelete = CdsPaisesBeforeDelete
    AfterDelete = CdsPaisesAfterPost
    OnReconcileError = CdsPaisesReconcileError
    Left = 240
    Top = 120
  end
end
