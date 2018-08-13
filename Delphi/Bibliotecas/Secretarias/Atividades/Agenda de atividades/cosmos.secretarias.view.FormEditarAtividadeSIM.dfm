object FrmEditarAtividadesSIM: TFrmEditarAtividadesSIM
  Left = 0
  Top = 0
  HelpContext = 460
  BorderStyle = bsDialog
  Caption = 'Atividades do Trabalho de Simpatizantes'
  ClientHeight = 625
  ClientWidth = 638
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
  OnDestroy = FormDestroy
  DesignSize = (
    638
    625)
  PixelsPerInch = 96
  TextHeight = 13
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 16
    Width = 546
    Height = 215
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Dados da Atividade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DesignSize = (
      546
      215)
    object Label1: TLabel
      Left = 1
      Top = 26
      Width = 83
      Height = 13
      Caption = '&Tipo da Atividade'
      FocusControl = FmeFKTipoAtividade.EdtData
    end
    object Label2: TLabel
      Left = 1
      Top = 71
      Width = 23
      Height = 13
      Caption = '&Data'
      FocusControl = DBDateTimePicker1
    end
    object Label3: TLabel
      Left = 250
      Top = 71
      Width = 35
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '&Hor'#225'rio'
      FocusControl = DBEdit1
      ExplicitLeft = 152
    end
    object Label4: TLabel
      Left = 1
      Top = 117
      Width = 24
      Height = 13
      Caption = '&Local'
      FocusControl = DBEdit2
    end
    object Label5: TLabel
      Left = 459
      Top = 26
      Width = 33
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Campo'
      ExplicitLeft = 361
    end
    object SpeedButton3: TSpeedButton
      Left = 493
      Top = 184
      Width = 23
      Height = 22
      Hint = 'Nova|Cadastra uma nova confer'#234'ncia'
      Anchors = [akTop, akRight]
      Flat = True
      Glyph.Data = {
        AA030000424DAA03000000000000360000002800000011000000110000000100
        1800000000007403000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF0884AD0884AD0884AD0884AD
        0884AD0884ADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF00FF00FF008CBD4AD6EF21D6FF31DEFF6BE7FF8CE7FF4AC6E70084B5FF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00008CBD8CFFFF5AEFFF21
        D6FF31DEFF6BE7FF8CE7FF4AC6E7089CCE0884ADFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00008CBD8CFFFF5AEFFF21D6FF31DEFF6BE7FF6BE7FF4A
        C6E7089CCE0884ADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00008C
        BD8CFFFF5AEFFF21D6FF31DEFF94FFFF94FFFF4AC6E7089CCE0884ADFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF00008CBD94FFFF84FFFF6BFFFF7BFF
        FF94FFFF9CFFFF4AC6E7089CCE0884ADFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF00008CBDBDEFF731BDDE10A5D6109CCE21A5CE31A5CE4AC6E7089C
        CE0884ADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00008CBD4AC6DE
        5AEFFF21D6FF31DEFF6BE7FF8CE7FF4AC6E7089CCE0884ADFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00008CBD8CFFFF5AEFFF21D6FF31DEFF6BE7FF
        8CE7FF4AC6E7089CCE0884ADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF00008CBD8CFFFF5AEFFF21D6FF31DEFF6BE7FF8CE7FF4AC6E7089CCE0884AD
        FF00FFFF00FFFF00FF21D6FFFF00FFFF00FFFF00FF00008CBD8CFFFF5AEFFF21
        D6FF31DEFF6BE7FF8CE7FF4AC6E7089CCE0884ADFF00FF21D6FFFF00FF80FFFF
        FF00FF21D6FFFF00FF00008CBD94FFFF84FFFF6BFFFF7BFFFF94FFFFA5FFFF63
        DEF708A5D60884ADFF00FFFF00FF80FFFFFF00FF80FFFFFF00FFFF00FF00008C
        BDFFFFFFF7FFFFD6FFFFB5FFFFB5FFFFADFFFFADFFFF6BFFFF0884AD21D6FF80
        FFFFFF00FF21D6FFFF00FF80FFFF21D6FF00FF00FF0894C6F7FFFFE7FFFFC6FF
        FFADFFFFA5FFFF9CFFFF1084ADFF00FFFF00FFFF00FF80FFFFFF00FF80FFFFFF
        00FFFF00FF00FF00FFFF00FF008CBD008CBD008CBD008CBD008CBD008CBDFF00
        FFFF00FFFF00FF21D6FFFF00FF80FFFFFF00FF21D6FFFF00FF00FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF21D6FFFF00FFFF00FFFF00FF00}
      OnClick = SpeedButton3Click
      ExplicitLeft = 395
    end
    object SpeedButton2: TSpeedButton
      Left = 520
      Top = 184
      Width = 23
      Height = 22
      Hint = 
        'Retirar|Retira a informa'#231#227'o sobre a alocu'#231#227'o proferida na ativid' +
        'ade'
      Anchors = [akTop, akRight]
      Flat = True
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D002000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FF00009CFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FFFF00FF000000FF00FF3131CE
        0000FF00009CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000000FF00FF3131CE319CFF0000FF00009CFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF0000FFFF00FFFF00FF000000FF00FFFF00FF
        3131CE0063FF0000CEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FF0000CE0000FF00009CFF00FFFF
        00FFFF00FFFF00FF0000FF00009CFF00FFFF00FFFF00FF000000FF00FFFF00FF
        FF00FFFF00FF0000CE0000FF00009CFF00FFFF00FF0000FF00009CFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FF0000CE0000FF00
        009C0000FF00009CFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0000CE0000FF00009CFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FF0000CE0000FF00
        009C0000CE00009CFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
        FF00FFFF00FF0000CE0000FF00009CFF00FFFF00FF0000CE00009CFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FF0000CE0000FF0000FF00009CFF00FFFF
        00FFFF00FFFF00FF0000CE00009CFF00FFFF00FFFF00FF000000FF00FF0000CE
        319CFF0000FF00009CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000CE0000
        9CFF00FFFF00FF000000FF00FF63639C0000CE63639CFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000CEFF00FF000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000000}
      OnClick = SpeedButton2Click
      ExplicitLeft = 422
    end
    object Label6: TLabel
      Left = 1
      Top = 170
      Width = 58
      Height = 13
      Caption = 'C&onfer'#234'ncia'
      FocusControl = FmeFKConferencia.EdtData
    end
    inline FmeFKTipoAtividade: TFmeFKSearch
      Left = 0
      Top = 40
      Width = 443
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
      ExplicitTop = 40
      ExplicitWidth = 443
      ExplicitHeight = 25
      inherited SpeedButton1: TSpeedButton
        Left = 420
        ExplicitLeft = 339
      end
      inherited EdtData: TDBEdit
        Width = 417
        DataField = 'DESTIPATI'
        DataSource = FmeDBInsertVertical1.DataSource1
        ExplicitWidth = 417
      end
    end
    object DBDateTimePicker1: TDBDateTimePicker
      Left = 1
      Top = 86
      Width = 218
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Date = 38901.439719861110000000
      Time = 38901.439719861110000000
      TabOrder = 2
      DataField = 'DATATI'
      DataSource = FmeDBInsertVertical1.DataSource1
    end
    object DBEdit1: TDBEdit
      Left = 250
      Top = 86
      Width = 103
      Height = 21
      Anchors = [akTop, akRight]
      DataField = 'HORATI'
      DataSource = FmeDBInsertVertical1.DataSource1
      TabOrder = 3
    end
    object DBEdit2: TDBEdit
      Left = 1
      Top = 132
      Width = 521
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'LOCATI'
      DataSource = FmeDBInsertVertical1.DataSource1
      TabOrder = 4
    end
    object DBEdit3: TDBEdit
      Left = 459
      Top = 41
      Width = 63
      Height = 21
      TabStop = False
      Anchors = [akTop, akRight]
      Color = clBtnFace
      DataField = 'CAMPRO'
      DataSource = FmeDBInsertVertical1.DataSource1
      ReadOnly = True
      TabOrder = 1
    end
    inline FmeFKConferencia: TFmeFKSearch
      Left = 0
      Top = 184
      Width = 489
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = True
      ExplicitTop = 184
      ExplicitWidth = 489
      ExplicitHeight = 25
      inherited SpeedButton1: TSpeedButton
        Left = 465
        ExplicitLeft = 339
      end
      inherited EdtData: TDBEdit
        Width = 463
        DataField = 'NOMCON'
        DataSource = FmeDBInsertVertical1.DataSource1
        ExplicitWidth = 463
      end
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 237
    Width = 546
    Height = 74
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Op'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object DBCheckBox1: TDBCheckBox
      Left = 1
      Top = 25
      Width = 232
      Height = 17
      Caption = 'Presen'#231'a ser'#225' requerida para esta atividade'
      DataField = 'INDFRE'
      DataSource = FmeDBInsertVertical1.DataSource1
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBCheckBox3: TDBCheckBox
      Left = 1
      Top = 48
      Width = 288
      Height = 17
      Caption = 'Esta atividade deve ser listada no boletim informativo'
      DataField = 'INDLIS'
      DataSource = FmeDBInsertVertical1.DataSource1
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object MSGroupHeader4: TMSGroupHeader
    Left = 8
    Top = 559
    Width = 543
    Height = 59
    Transparent = True
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Cadastro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DesignSize = (
      543
      59)
    inline FmeUsuarioCadastrador1: TFmeUsuarioCadastrador
      Left = -2
      Top = 17
      Width = 524
      Height = 44
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      TabStop = True
      ExplicitLeft = -2
      ExplicitTop = 17
      ExplicitWidth = 524
      inherited Label2: TLabel
        Left = 414
        ExplicitLeft = 285
      end
      inherited SpeedButton1: TSpeedButton
        Left = 385
        ExplicitLeft = 256
      end
      inherited DBEdit1: TDBEdit
        Width = 380
        DataField = 'USURES'
        DataSource = FmeDBInsertVertical1.DataSource1
        ExplicitWidth = 380
      end
      inherited DBEdit2: TDBEdit
        Left = 414
        Width = 110
        DataField = 'DATCAD'
        DataSource = FmeDBInsertVertical1.DataSource1
        ExplicitLeft = 414
        ExplicitWidth = 110
      end
    end
  end
  inline FmeDBInsertVertical1: TFmeDBInsertVertical
    Left = 558
    Top = 20
    Width = 81
    Height = 149
    Anchors = [akTop, akRight]
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 558
    ExplicitTop = 20
    inherited ActionList1: TActionList
      inherited DataSetInsert1: TDataSetInsert
        Enabled = False
      end
    end
    inherited DataSource1: TDataSource
      DataSet = CdsAtividade
    end
    inherited ImageList1: TImageList
      Bitmap = {
        494C010105000900600012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
        0000000000003600000028000000480000002400000001002000000000008028
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000E7CEC600E7CEC600DECEC600DEC6BD00DEC6BD00E7CE
        BD00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000EFCEC600EFE7DE00EFEFEF00E7E7EF00DED6D600D6CECE00CECECE00C6C6
        BD00CEB5B500E7CEBD0000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000EFCE
        C600F7F7EF00F7FFFF00E7CEC600D6947300D68C6300D68C6300D68C6B00CEB5
        A500C6C6C600C6B5B500DEC6B500000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000EFCEBD00FFF7
        F700FFFFFF00DEA58400CE632900CE632900F7E7D600F7D6C600CE632900CE63
        2900CE947B00C6C6C600CEBDBD00E7CEBD000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000F7EFE700FFFF
        FF00E7AD9400CE5A2100CE632900CE6B3100EFBDA500E7B59C00CE633100CE63
        3100CE632100D69C7B00CECECE00DEC6BD000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000EFCEC600FFFFFF00F7E7
        DE00D6733900CE633100CE633100D6734200E7B59C00E7A58400CE632900CE6B
        3100CE633100CE6B3100D6C6BD00D6D6D600E7CEBD0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000EFDED600FFFFFF00EFBD
        9C00D6733900D6734200CE6B3100D67B4A00FFFFF700FFF7EF00CE6B3900CE63
        2900CE6B3100CE632900D6A58400DEE7E700E7CEC60000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000F7E7DE00FFFFFF00E7AD
        8400D6844200D6844A00D67B4200CE6B3900EFC6B500FFFFFF00F7D6C600D673
        4200CE632900CE632900D68C6B00EFEFF700E7D6C60000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000F7E7DE00FFFFFF00EFB5
        8C00DE8C5200DE8C5200D6844A00D67B4200D6734200EFC6B500FFFFFF00F7E7
        DE00D6734200CE5A2100DE946B00F7F7FF00EFD6CE0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000EFDECE00FFFFFF00F7CE
        B500DE945A00E79C6300E79C6B00DE8C5200D6844A00D6733900EFC6AD00FFFF
        FF00E7AD9400C6521800E7AD8C00F7FFFF00EFD6C60000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000EFDECE00FFFFFF00FFF7
        E700E7A56B00F7DEC600FFFFFF00EFB59400DE844A00D67B3900E7AD8C00FFFF
        FF00EFBDA500CE6B3100F7E7DE00F7F7F700EFD6C60000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000F7E7E700FFFF
        FF00F7D6B500EFC69C00FFFFFF00FFFFF700EFCEB500EFCEAD00FFFFF700FFFF
        FF00DE946300E7B59400FFFFFF00EFDED6000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000EFD6CE00FFF7
        EF00FFFFFF00F7D6AD00F7CEAD00FFEFE700FFFFF700FFFFF700FFE7DE00EFB5
        8C00EFBD9C00FFFFFF00F7EFEF00EFDED6000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000EFD6
        CE00FFF7EF00FFFFFF00FFEFDE00F7D6B500F7D6AD00EFCEAD00EFCEAD00F7E7
        D600FFFFFF00F7EFEF00EFCEC600000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000EFD6CE00F7EFE700FFF7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7
        F700F7E7E700F7E7E70000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000EFD6CE00EFD6CE00EFDECE00EFD6CE00EFD6CE00EFD6
        CE00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000003100000029
        0000002100000021000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000009C6363006B3131000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000420000298C
        4A00217339000018000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000634239005A2929005A2929005A2929006342390000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000009C63
        63009C636300BD636300BD6B6B006B3131000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000004A0000319C
        5200298442000021000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000006331
        3100395A5A001084A50010738400105A6300393139005A292900000000000000
        000000000000000000000000000000009C000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000000FF000000
        000000000000000000000000000000000000000000009C6363009C636300C66B
        6B00D66B6B00D66B6B00C66B6B006B3131009C6363009C6363009C6363009C63
        63009C6363009C63630000000000000000000000000000000000000000000000
        00000000000000000000000000000063000000630000005A0000005A000042C6
        6B0039AD5A000031000000290000002900000029000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000007352
        4A0000CEFF0000BDE700009CBD0000738C0000636B005A292900000000000000
        000000000000000000003131CE000000FF0000009C0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000009C636300DE737300D673
        7300D66B7300D66B6B00C66B6B006B313100FFA5A500FFADB500FFBDBD00FFC6
        C600FFC6C6009C63630000000000000000000000000000000000000000000000
        0000000000000000000000000000187B180073FFA5006BFFA50063FF9C005AF7
        940052DE840042BD6B0039AD5A0039A55A000031000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000008C63
        5A0018D6FF0000CEFF0000ADD6000084A500006B73005A292900000000000000
        000000000000000000003131CE00319CFF000000FF0000009C00000000000000
        000000000000000000000000000000000000000000000000FF00000000000000
        000000000000000000000000000000000000000000009C636300E7737B00DE73
        7300DE737300DE737300CE6B73006B31310039C6630021CE630029CE630018CE
        5A00FFC6C6009C636300000000000000000000000000633131005A2929005A29
        29005A2929005A2929005A2929003994390073E7940073E7940073E7940073FF
        AD0063FF9C0039C6630031B5520031AD5200004A000000000000000000006B4A
        42005A2929005A2929005A292900B59C9C00633131005A2929005A2929009473
        6B0039DEFF0018D6FF0000C6F7000094BD0000738C005A292900000000000000
        00000000000000000000000000003131CE000063FF000000CE00000000000000
        0000000000000000000000000000000000000000FF0000000000000000000000
        000000000000000000000000000000000000000000009C636300E77B7B00E77B
        7B00DE7B7B00DE737B00D67373006B31310042C66B0031CE630031CE630021CE
        6300FFC6C6009C6363000000000000000000000000005A292900E7DED600DECE
        C600DECEC600DECEC600DECEC60063A5630063A5630063A5630063A5630094FF
        B50084FFAD00087308000063000000630000005A00000000000000000000EFE7
        E700FFFFF700EFE7DE00DED6CE00D6C6BD00CEBDB500CEBDB500CEBDB500A584
        84004ADEFF0031DEFF0000CEFF0000ADD600008CA5005A292900000000000000
        0000000000000000000000000000000000000000CE000000FF0000009C000000
        00000000000000000000000000000000FF0000009C0000000000000000000000
        000000000000000000000000000000000000000000009C636300EF848400E77B
        8400E77B7B00E7848400D67373006B31310039C6630029CE630029CE630021CE
        5A00FFC6C6009C63630000000000000000000000000063313100FFFFEF00EFE7
        D600EFE7D600EFE7D600EFE7D600EFE7D600EFE7D600EFE7D60073AD7300A5FF
        C60094FFB500218421005A29290000000000000000000000000000000000734A
        4200FFFFF700FFFFF700EFEFE700E7DED600DECEC600DECEC600DECEC600A58C
        8C008CADBD00848C94006373730042525200315A63005A292900000000000000
        000000000000000000000000000000000000000000000000CE000000FF000000
        9C0000000000000000000000FF0000009C000000000000000000000000000000
        000000000000000000000000000000000000000000009C636300F7848C00EF84
        8400EF949400FFDEDE00DE8C8C006B313100BDE7AD006BDE8C005AD6840042D6
        7300FFC6C6009C6363000000000000000000000000006B423900FFFFF700FFFF
        F700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE70073AD730094EF
        AD0084E7A500318431005A29290000000000000000000000000000000000845A
        5200FFFFF700FFFFF700FFFFF700F7EFE700EFE7DE00EFE7DE00EFE7DE00AD94
        9400A5949C0084ADBD005A9CAD00297B9400523139005A292900000000000000
        00000000000000000000000000000000000000000000000000000000CE000000
        FF0000009C000000FF0000009C00000000000000000000000000000000000000
        000000000000000000000000000000000000000000009C636300F78C8C00EF84
        8400F79C9C00FFDEDE00DE8C8C006B313100FFF7DE00FFFFE700FFFFDE00EFFF
        D600FFC6C6009C63630000000000000000000000000073524A00FFFFF700FFFF
        F700EFCE8400D6840000D6840000D6840000D6840000D684000073AD730063A5
        6300529C5200318431005A292900000000000000000000000000000000008C63
        5A00FFFFF700FFFFF700FFFFF700EFCE8C00D6840000D6840000D6840000D684
        0000D6840000A5AD730042D6F70029B5D600395A63005A292900000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        CE000000FF0000009C0000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000009C636300FF949400F78C
        8C00F78C8C00F78C8C00DE7B84006B313100FFF7D600FFFFDE00FFFFDE00FFFF
        E700FFC6C6009C63630000000000000000000000000084525200FFFFF700FFFF
        F700FFFFEF00F7E7BD00F7DEB500F7E7BD00F7E7BD00F7DEB500F7F7DE00EFEF
        E700E7DED600DECEC6005A292900000000000000000000000000000000009C7B
        7300FFFFF700FFFFF700FFFFF700FFF7E700F7E7BD00F7E7BD00F7E7BD00E7C6
        9C00BD946B00AD8C84009C736B00845A52006331390000000000000000000000
        00000000000000000000000000000000000000000000000000000000CE000000
        FF0000009C000000CE0000009C00000000000000000000000000000000000000
        000000000000000000000000000000000000000000009C636300FF949C00FF94
        9400FF949400FF949400E78484006B313100FFF7D600FFFFDE00FFFFDE00FFFF
        DE00FFC6C6009C63630000000000000000000000000084525200FFFFF700F7F7
        DE00F7DEB500F7DEB500F7DEB500F7DEB500F7DEB500F7DEB500F7DEB500EFDE
        B500EFE7D600E7D6CE005A29290000000000000000000000000000000000F7EF
        EF00FFFFF700FFFFF700FFEFDE00F7DEBD00F7DEBD00F7DEBD00F7DEBD00F7DE
        BD00F7D6B500E7CEAD00DEC6A500D6C6BD005A29290000000000000000000000
        000000000000000000000000000000000000000000000000CE000000FF000000
        9C0000000000000000000000CE0000009C000000000000000000000000000000
        000000000000000000000000000000000000000000009C636300FF9C9C00FF94
        9C00FF949400FF949C00E78C8C006B313100FFF7D600FFFFDE00FFFFDE00FFFF
        DE00FFC6C6009C6363000000000000000000000000008C635A00FFFFF700D673
        1000CE630000CE630000CE630000CE630000CE630000CE630000CE630000D673
        1000FFFFF700EFE7D6005A292900000000000000000000000000000000009473
        6B00FFFFF700FFFFF700D67B1000CE630000CE630000CE630000CE630000CE63
        0000CE630000CE630000D6731000DED6CE00D6C6C60000000000000000000000
        00000000000000000000000000000000CE000000FF000000FF0000009C000000
        00000000000000000000000000000000CE0000009C0000000000000000000000
        000000000000000000000000000000000000000000009C636300FF9CA500FF9C
        9C00FF9C9C00FF9C9C00E78C8C006B313100FFF7D600FFFFDE00FFFFDE00FFFF
        DE00FFC6C6009C636300000000000000000000000000946B6300FFFFFF00FFFF
        FF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFF
        F700FFFFF700FFFFF7005A292900000000000000000000000000000000009C73
        6B00FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFF
        F700FFFFF700FFFFF700FFFFEF00EFE7DE006B42390000000000000000000000
        000000000000000000000000CE00319CFF000000FF0000009C00000000000000
        0000000000000000000000000000000000000000CE0000009C00000000000000
        000000000000000000000000000000000000000000009C6363009C636300EF8C
        8C00FF9C9C00FF9C9C00EF8C94006B313100FFF7D600FFFFDE00FFFFDE00FFFF
        DE00FFC6C6009C63630000000000000000000000000094736300E7DED600E7DE
        D600E7DED600E7DED600E7DED600E7DED600E7DED600E7DED600E7DED600DED6
        D600DED6CE00DECEC6005A292900000000000000000000000000000000009C7B
        7300EFE7DE00EFE7DE00E7DED600E7D6D600EFEFE700FFFFF700EFE7DE00E7D6
        D600DED6CE00EFE7E700FFFFF700DED6CE005A29290000000000000000000000
        0000000000000000000063639C000000CE0063639C0000000000000000000000
        00000000000000000000000000000000000000000000000000000000CE000000
        0000000000000000000000000000000000000000000000000000000000009C63
        6300B5737300D6848400DE8C8C006B3131009C6363009C6363009C6363009C63
        63009C6363009C63630000000000000000000000000094737300947373009473
        730094737300947373009473730094737300947373009473730094736300946B
        63008C635A0073524A00734A420000000000000000000000000000000000A584
        8400F7EFEF009C736B0094736B00946B63009C7B7300F7EFEF008C6B63008C6B
        63008C635A00946B6300EFEFE700633131006331310000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000009C6363009C6363006B3131000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000424D3E000000000000003E000000
        2800000048000000240000000100010000000000B00100000000000000000000
        000000000000000000000000FFFFFF00FFFFC0000000000000000000FC0FC000
        0000000000000000F003C0000000000000000000E001C0000000000000000000
        C000C0000000000000000000C000C00000000000000000008000400000000000
        0000000080004000000000000000000080004000000000000000000080004000
        0000000000000000800040000000000000000000800040000000000000000000
        C000C0000000000000000000C000C0000000000000000000E001C00000000000
        00000000F003C0000000000000000000FC0FC0000000000000000000FFFFC000
        0000000000000000FFFFFFFFFFFFFFFFFF000000FFC3FFFFFFFFFFFCFF000000
        FFC3FFF07FFFFFE0FF000000FFC3FFE03EFFDF8003000000FE007FE03C7FFF80
        03000000FE007FE03C3FBF8003000000800060003E3F7F800300000080006000
        3F1E7F80030000008001E0003F8CFF80030000008001E0003FC1FF8003000000
        8001E0003FE3FF80030000008001E0007FC1FF80030000008001E0007F8CFF80
        030000008001E0007E1E7F80030000008001E0007C3F3F80030000008001E000
        7C7FDFE0030000008001E0007FFFFFF8FF000000FFFFFFFFFFFFFFFFFF000000
        00000000000000000000000000000000000000000000}
    end
  end
  object MSGroupHeader5: TMSGroupHeader
    Left = 8
    Top = 317
    Width = 543
    Height = 236
    Transparent = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Notas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DesignSize = (
      543
      236)
    object DBMemo1: TDBMemo
      Left = 0
      Top = 16
      Width = 522
      Height = 220
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataField = 'OBSATI'
      DataSource = FmeDBInsertVertical1.DataSource1
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object CdsAtividade: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspAtividadeLEC'
    AfterOpen = CdsAtividadeAfterOpen
    AfterInsert = CdsAtividadeAfterInsert
    BeforePost = CdsAtividadeBeforePost
    AfterPost = CdsAtividadeAfterPost
    OnReconcileError = CdsAtividadeReconcileError
    Left = 600
    Top = 312
  end
end