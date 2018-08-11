object FrmEditDirecoes: TFrmEditDirecoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsSingle
  Caption = 'Dire'#231#245'es'
  ClientHeight = 479
  ClientWidth = 517
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
    517
    479)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 360
    Top = 211
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      055449636F6E0000010001002020100001000400E80200001600000028000000
      2000000040000000010004000000000040020000000000000000000000000000
      0000000000000000C0C0C00080808000FFFFFF00000080000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000400000000000000000000000000000
      0454000000000000000000000000000045440000000000000000000000000004
      5440000000000000000000000000004544000000000000000000000000000454
      4000000000000000000000000000454400000000000000000000000000045440
      0000000000000000000000000045440000000000000000001100000004544000
      0000000000000112222000004544000000000000000012020002000454400000
      0000000000012010000000210400000000000000000202000000023220000000
      0000000000100100000020020000000000000000002000000000100000000000
      0000000000000000000020000000000000000000000000000000000000000000
      0000000000000100000000000000000000000000002002000000000000000000
      0000000000100021000000000000000000000000000100002112000000000000
      0000000000001200000000000000000000000000000000120000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FFFFFFFFFFFFFFFFFFFFFFCFFFFFFF87FFFFFF07FFFFFE0FFFFFFC1F
      FFFFF83FFFFFF07FFFFFE0FFFFFFC1FFFF3F83FFF81F07FFF0EE0FFFE1FC1FFF
      E3F83FFFC3F07FFFC7F0FFFFC7F1FFFFC7FFFFFFC3FFFFFFC3FFFFFFC0FFFFFF
      E00FFFFFF00FFFFFFC0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF}
  end
  inline FmeEditButtons1: TFmeEditButtons
    Left = 438
    Top = 11
    Width = 80
    Height = 151
    Anchors = [akTop, akRight]
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 348
    ExplicitTop = 11
    inherited DataSource1: TDataSource
      DataSet = CdsDirecoes
    end
  end
  object MSGroupHeader1: TMSGroupHeader
    Left = 6
    Top = 8
    Width = 428
    Height = 240
    Transparent = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Dados do Dirigente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 338
    ExplicitHeight = 188
    DesignSize = (
      428
      240)
    object Label1: TLabel
      Left = 0
      Top = 129
      Width = 29
      Height = 13
      Caption = 'Cargo'
    end
    object Label2: TLabel
      Left = 0
      Top = 19
      Width = 43
      Height = 13
      Caption = 'Dirigente'
    end
    object Label3: TLabel
      Left = 1
      Top = 74
      Width = 23
      Height = 13
      Caption = 'Foco'
    end
    object Label4: TLabel
      Left = 1
      Top = 183
      Width = 28
      Height = 13
      Caption = 'Posse'
    end
    object Label5: TLabel
      Left = 156
      Top = 183
      Width = 38
      Height = 13
      Caption = 'T'#233'rmino'
    end
    object Label6: TLabel
      Left = 363
      Top = 75
      Width = 53
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Discipulado'
    end
    object DBEdit3: TDBEdit
      Left = 1
      Top = 89
      Width = 346
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      DataField = 'NOMFOC'
      DataSource = FmeEditButtons1.DataSource1
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit4: TDBEdit
      Left = 362
      Top = 89
      Width = 62
      Height = 21
      TabStop = False
      Anchors = [akTop, akRight]
      Color = clBtnFace
      DataField = 'SIGDIS'
      DataSource = FmeEditButtons1.DataSource1
      ReadOnly = True
      TabOrder = 1
    end
    object DBDateTimePicker1: TDBDateTimePicker
      Left = 0
      Top = 197
      Width = 121
      Height = 21
      Date = 38974.396168981480000000
      Time = 38974.396168981480000000
      TabOrder = 2
      DataField = 'DATINI'
      DataSource = FmeEditButtons1.DataSource1
    end
    object DBDateTimePicker2: TDBDateTimePicker
      Left = 156
      Top = 197
      Width = 121
      Height = 21
      Date = 38974.396168981480000000
      Time = 38974.396168981480000000
      TabOrder = 3
      DataField = 'DATTER'
      DataSource = FmeEditButtons1.DataSource1
    end
    inline FmeFKSearchCargos: TFmeFKSearch
      Left = 0
      Top = 143
      Width = 424
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = True
      ExplicitTop = 143
      ExplicitWidth = 424
      inherited SpeedButton1: TSpeedButton
        Left = 400
        ExplicitLeft = 310
      end
      inherited EdtData: TDBEdit
        Width = 398
        DataField = 'DESCAR'
        DataSource = FmeEditButtons1.DataSource1
        ExplicitWidth = 308
      end
    end
    inline FmeFkSearchDirigentes: TFmeFKSearch
      Left = 1
      Top = 33
      Width = 423
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = True
      ExplicitLeft = 1
      ExplicitTop = 33
      ExplicitWidth = 333
      inherited SpeedButton1: TSpeedButton
        Left = 399
        ExplicitLeft = 309
      end
      inherited EdtData: TDBEdit
        Width = 397
        DataField = 'NOMCAD'
        DataSource = FmeEditButtons1.DataSource1
        ExplicitWidth = 307
      end
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 5
    Top = 265
    Width = 428
    Height = 137
    Transparent = False
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Informa'#231#245'es Adicionais'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 213
    ExplicitWidth = 338
    DesignSize = (
      428
      137)
    object DBCheckBox1: TDBCheckBox
      Left = 0
      Top = 120
      Width = 281
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Dirigente '#233' um contato do foco ao qual est'#225' vinculado'
      DataField = 'INDCON'
      DataSource = FmeEditButtons1.DataSource1
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBMemo1: TDBMemo
      Left = 0
      Top = 24
      Width = 424
      Height = 83
      DataField = 'OBSDIR'
      DataSource = FmeEditButtons1.DataSource1
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object MSGroupHeader3: TMSGroupHeader
    Left = 5
    Top = 415
    Width = 428
    Height = 60
    Transparent = False
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Cadastro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 363
    ExplicitWidth = 338
    DesignSize = (
      428
      60)
    inline FmeUsuarioCadastrador1: TFmeUsuarioCadastrador
      Left = 0
      Top = 15
      Width = 417
      Height = 44
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      TabStop = True
      ExplicitTop = 15
      ExplicitWidth = 327
      inherited Label2: TLabel
        Left = 301
      end
      inherited SpeedButton1: TSpeedButton
        Left = 273
      end
      inherited DBEdit1: TDBEdit
        Width = 268
        DataField = 'USURES'
        DataSource = FmeEditButtons1.DataSource1
      end
      inherited DBEdit2: TDBEdit
        Left = 301
        DataField = 'DATCAD'
        DataSource = FmeEditButtons1.DataSource1
      end
    end
  end
  object CdsDirecoes: TClientDataSet
    Aggregates = <>
    ConnectionBroker = DMCon.CBroker
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'coddir'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspDirecoes'
    BeforePost = CdsDirecoesBeforePost
    AfterPost = CdsDirecoesAfterPost
    OnReconcileError = CdsDirecoesReconcileError
    Left = 368
    Top = 248
  end
end
