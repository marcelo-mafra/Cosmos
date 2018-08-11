object FrmEditGestoes: TFrmEditGestoes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gest'#245'es'
  ClientHeight = 226
  ClientWidth = 451
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
    451
    226)
  PixelsPerInch = 96
  TextHeight = 13
  inline FmeEditButtons1: TFmeEditButtons
    Left = 369
    Top = 5
    Width = 80
    Height = 151
    Anchors = [akTop, akRight]
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 306
    ExplicitTop = 5
    inherited DataSource1: TDataSource
      DataSet = CdsGestoes
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 8
    Width = 345
    Height = 143
    Transparent = False
    Caption = 'Dados da Gest'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DesignSize = (
      345
      143)
    object Label1: TLabel
      Left = 0
      Top = 24
      Width = 25
      Height = 13
      Caption = 'In'#237'cio'
    end
    object Label2: TLabel
      Left = 164
      Top = 24
      Width = 38
      Height = 13
      Caption = 'T'#233'rmino'
    end
    object Label3: TLabel
      Left = 0
      Top = 84
      Width = 65
      Height = 13
      Caption = #211'rg'#227'o Gestor'
    end
    object DBDateTimePicker1: TDBDateTimePicker
      Left = 0
      Top = 38
      Width = 121
      Height = 21
      Date = 38974.396168981480000000
      Time = 38974.396168981480000000
      TabOrder = 0
      DataField = 'DATINI'
      DataSource = FmeEditButtons1.DataSource1
    end
    object DBDateTimePicker2: TDBDateTimePicker
      Left = 164
      Top = 38
      Width = 121
      Height = 21
      Date = 38974.396168981480000000
      Time = 38974.396168981480000000
      TabOrder = 1
      DataField = 'DATTER'
      DataSource = FmeEditButtons1.DataSource1
    end
    inline FmeFKSearchOrgao: TFmeFKSearch
      Left = 2
      Top = 98
      Width = 340
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = True
      ExplicitLeft = 2
      ExplicitTop = 98
      ExplicitWidth = 340
      inherited SpeedButton1: TSpeedButton
        Left = 316
        ExplicitLeft = 263
      end
      inherited EdtData: TDBEdit
        Width = 314
        DataField = 'NOMORG'
        DataSource = FmeEditButtons1.DataSource1
        ExplicitWidth = 261
      end
    end
  end
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 155
    Width = 356
    Height = 58
    Transparent = False
    Anchors = []
    Caption = 'Cadastro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 162
    DesignSize = (
      356
      58)
    inline FmeUsuarioCadastrador1: TFmeUsuarioCadastrador
      Left = -1
      Top = 14
      Width = 357
      Height = 44
      Anchors = []
      TabOrder = 0
      TabStop = True
      ExplicitLeft = -1
      ExplicitTop = 14
      ExplicitWidth = 357
      inherited Label2: TLabel
        Left = 241
        ExplicitLeft = 178
      end
      inherited SpeedButton1: TSpeedButton
        Left = 213
        ExplicitLeft = 150
      end
      inherited DBEdit1: TDBEdit
        Width = 208
        DataField = 'USURES'
        DataSource = FmeEditButtons1.DataSource1
        ExplicitWidth = 208
      end
      inherited DBEdit2: TDBEdit
        Left = 241
        DataField = 'DATCAD'
        DataSource = FmeEditButtons1.DataSource1
        ExplicitLeft = 241
      end
    end
  end
  object CdsGestoes: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspGestoes'
    AfterInsert = CdsGestoesAfterInsert
    BeforePost = CdsGestoesBeforePost
    AfterPost = CdsGestoesAfterPost
    OnReconcileError = CdsGestoesReconcileError
    Left = 312
    Top = 160
  end
end
