object FrmPesquisarContas: TFrmPesquisarContas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Pesquisar Contas'
  ClientHeight = 474
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    600
    474)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 39
    Width = 584
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 8
    Top = 432
    Width = 584
    Height = 9
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object RdbHierarquica: TRadioButton
    Left = 8
    Top = 16
    Width = 113
    Height = 17
    Caption = 'Vis'#227'o &hier'#225'rquica'
    Checked = True
    TabOrder = 0
    TabStop = True
    OnClick = RdbHierarquicaClick
  end
  object RadioButton2: TRadioButton
    Left = 144
    Top = 16
    Width = 89
    Height = 17
    Caption = 'Vis'#227'o &Tabular'
    TabOrder = 1
    OnClick = RadioButton2Click
  end
  object BitBtn1: TBitBtn
    Left = 320
    Top = 445
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'BitBtn1'
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 418
    Top = 445
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'BitBtn2'
    TabOrder = 3
  end
  object BitBtn3: TBitBtn
    Left = 517
    Top = 445
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'BitBtn3'
    TabOrder = 4
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 47
    Width = 584
    Height = 379
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsFlatButtons
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      inline FmePlanoContas1: TFmePlanoContas
        Left = 0
        Top = 0
        Width = 576
        Height = 348
        Align = alClient
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 576
        ExplicitHeight = 348
        inherited TrvContas: TTreeView
          Width = 576
          Height = 348
          ExplicitWidth = 576
          ExplicitHeight = 348
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inline FmeGridSearch1: TFmeGridSearch
        AlignWithMargins = True
        Left = 1
        Top = 0
        Width = 574
        Height = 348
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = True
        ExplicitLeft = 1
        ExplicitWidth = 574
        ExplicitHeight = 348
        inherited PnlSearchBar: TPanel
          Top = 324
          Width = 574
          ExplicitTop = 324
          ExplicitWidth = 574
          inherited SbnSearch: TSpeedButton
            Left = 548
            ExplicitLeft = 413
          end
          inherited EdtSearch: TEdit
            Width = 544
            ExplicitWidth = 544
          end
        end
        inherited DBGrid1: TDBGrid
          Width = 574
          Height = 324
          DataSource = DsrContas
        end
      end
    end
  end
  object CdsContas: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspPesquisarPlanoContas'
    Left = 40
    Top = 192
  end
  object DsrContas: TDataSource
    DataSet = CdsContas
    Left = 72
    Top = 192
  end
end
