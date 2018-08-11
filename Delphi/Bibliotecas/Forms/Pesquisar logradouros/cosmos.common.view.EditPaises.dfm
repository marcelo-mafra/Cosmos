object FrmDlgPaises: TFrmDlgPaises
  Left = 0
  Top = 0
  HelpContext = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pa'#237'ses'
  ClientHeight = 430
  ClientWidth = 485
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
  DesignSize = (
    485
    430)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 7
    Width = 94
    Height = 13
    Caption = '&Pa'#237'ses Cadastrados'
  end
  inline FmeGridSearchPaises: TFmeGridSearch
    Left = 3
    Top = 22
    Width = 398
    Height = 406
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 3
    ExplicitTop = 22
    ExplicitWidth = 398
    ExplicitHeight = 406
    inherited PnlSearchBar: TPanel
      Top = 382
      Width = 398
      ExplicitTop = 382
      ExplicitWidth = 398
      inherited SbnSearch: TSpeedButton
        Left = 372
        ExplicitLeft = 413
      end
      inherited SbnLocate: TSpeedButton
        Left = 530
        ExplicitLeft = 530
      end
      inherited EdtSearch: TEdit
        Width = 368
        ExplicitWidth = 368
      end
    end
    inherited DBGrid1: TDBGrid
      Width = 398
      Height = 382
      DataSource = FmeDBInsertVertical1.DataSource1
    end
  end
  inline FmeDBInsertVertical1: TFmeDBInsertVertical
    Left = 404
    Top = 22
    Width = 81
    Height = 149
    Anchors = [akTop, akRight]
    TabOrder = 1
    TabStop = True
    ExplicitLeft = 404
    ExplicitTop = 22
    inherited ActionList1: TActionList
      inherited DataSetInsert1: TDataSetInsert
        Enabled = False
      end
    end
    inherited DataSource1: TDataSource
      DataSet = CdsPaises
    end
  end
  object CdsPaises: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspPaises'
    BeforePost = CdsPaisesBeforePost
    AfterPost = CdsPaisesAfterPost
    BeforeDelete = CdsPaisesBeforeDelete
    OnReconcileError = CdsPaisesReconcileError
    Left = 240
    Top = 120
  end
end
