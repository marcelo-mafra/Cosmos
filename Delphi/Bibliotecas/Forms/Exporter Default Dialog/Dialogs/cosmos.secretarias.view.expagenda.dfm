object FrmExportarAgenda: TFrmExportarAgenda
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Exportar Agenda'
  ClientHeight = 565
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    553
    565)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 528
    Width = 539
    Height = 4
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
    ExplicitTop = 445
    ExplicitWidth = 443
  end
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 92
    Width = 539
    Height = 73
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Selecionar Atividades'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label2: TLabel
      Left = 4
      Top = 23
      Width = 25
      Height = 13
      Caption = 'In'#237'cio'
    end
    object Label3: TLabel
      Left = 224
      Top = 23
      Width = 38
      Height = 13
      Caption = 'T'#233'rmino'
    end
    object EdtInicio: TDateTimePicker
      Left = 4
      Top = 40
      Width = 186
      Height = 21
      Date = 41970.428401701400000000
      Time = 41970.428401701400000000
      TabOrder = 0
    end
    object EdtTermino: TDateTimePicker
      Left = 224
      Top = 40
      Width = 186
      Height = 21
      Date = 41970.428418877320000000
      Time = 41970.428418877320000000
      TabOrder = 1
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 176
    Width = 539
    Height = 241
    Transparent = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Focos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DesignSize = (
      539
      241)
    object LsvFocos: TListView
      Left = 4
      Top = 24
      Width = 525
      Height = 210
      Anchors = [akLeft, akTop, akRight, akBottom]
      Checkboxes = True
      Columns = <
        item
          Caption = 'Focos'
          Width = 400
        end>
      ReadOnly = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object Button1: TButton
    Left = 288
    Top = 538
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 381
    Top = 538
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 3
  end
  object Button3: TButton
    Left = 472
    Top = 538
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ajuda'
    TabOrder = 6
  end
  object MSGroupHeader3: TMSGroupHeader
    Left = 8
    Top = 423
    Width = 539
    Height = 66
    Transparent = False
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Arquivo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DesignSize = (
      539
      66)
    object Label1: TLabel
      Left = 4
      Top = 26
      Width = 82
      Height = 13
      Caption = 'Nome do Arquivo'
    end
    object SpeedButton1: TSpeedButton
      Left = 506
      Top = 41
      Width = 23
      Height = 22
      Anchors = [akRight, akBottom]
      Flat = True
      Glyph.Data = {
        EE030000424DEE03000000000000360000002800000012000000110000000100
        180000000000B803000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FF7088907078806070705060
        6040505030384020283010202010102010102010102010102010102010102010
        1020FF00FFFF00FF0000FF00FF708890A0E0F070D0F050B8E030B0E030A8E020
        A0D02098C02090C02080B02080B01080B02078A0207090102020FF00FFFF00FF
        0000FF00FF808890B0E8F090E8FF80E0FF70D8FF70D0F0A0E0FF90D8F090D0F0
        80C8F080C8F070C0F070B8E070A8C0707880FF00FFFF00FF0000FF00FF8090A0
        B0E8F0A0E8FF90E8FF80E0FF70D8FFA0E0FFB0A0906048306048306048306048
        30604830604830604830604830FF00FF0000FF00FF8090A0B0F0FFB0F0FFA0E8
        FFC0F0FFB0E8FFB0E8FFB0A090FFF8FFF0E0E0F0E0D0E0D8D0E0D0D0E0C8C0D0
        C8C0604830FF00FF0000FF00FF8098A0C0F0FFB0F0F0A0F0FFC0F0FFB0A09060
        4830B0A090FFF8FFF0B8A0E0B090E0B090D0A890D0A090D0C8C0604830FF00FF
        0000FF00FF8098A0C0F0FFB0F0FFB0F0FFC0F0FFB0A090FFF8FFC0A890FFFFFF
        FFF8FFFFF8F0F0F0F0F0E8E0F0E0D0D0C8C0604830FF00FF0000FF00FF90A0A0
        C0F0FFB0F0FFB0F0FFD0F8FFB0A090FFF8FFC0A8A0FFFFFFF0B8A0E0B090E0B0
        90D0A890D0A090D0C8C0604830FF00FF0000FF00FF90A0B0C0F0FFC0F0FFC0F0
        FFD0F8FFC0A890FFFFFFC0B0A0FFFFFFFFFFFFFFFFFFFFF8FFF0E8E0E0D8D0D0
        C8C0604830FF00FF0000FF00FF90A0B090A0B090A0B090A0B0B0C8D0C0A8A0FF
        FFFFD0B8B0FFF8FFF0B8A0E0B090E0B090B0A090604830604830604830FF00FF
        0000FF00FF90A8B0B0E8F0B0F0FFB0F0FFD0F0FFC0B0A0FFFFFFD0C0B0FFF8FF
        FFF8FFFFF8FFFFFFFFC0A890D0C8C0604830D1A98AFF00FF0000FF00FFFF00FF
        90A8B090A8B090A8B0C0C8D0D0B8B0FFF8FFE0C0B0FFF8FFFFF8FFFFF8FFFFF8
        FFC0B0A0604830D4AC8FFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFD0C0B0FFF8FFE0C0B0E0C0B0D0C0B0D0C0B0D0B8B0D0B0A0CDA891FF
        00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE0C0B0FF
        F8FFFFF8FFFFF8FFFFF8FFC0B0A0604830D7B499FF00FFFF00FFFF00FFFF00FF
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE0C0B0E0C0B0D0C0B0D0C0B0
        D0B8B0D0B0A0DFBFABFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
      OnClick = SpeedButton1Click
    end
    object EdtFileName: TEdit
      Left = 4
      Top = 42
      Width = 501
      Height = 21
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 0
    end
  end
  object MSGroupHeader4: TMSGroupHeader
    Left = 8
    Top = 3
    Width = 539
    Height = 83
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Formato de Exporta'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object RdbExcel: TRadioButton
      Tag = 1
      Left = 4
      Top = 47
      Width = 113
      Height = 17
      Caption = 'Microsoft Excel'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RdbDocClick
    end
    object RdbXML: TRadioButton
      Tag = 2
      Left = 148
      Top = 24
      Width = 106
      Height = 17
      Caption = 'Texto XML'
      TabOrder = 1
      OnClick = RdbDocClick
    end
    object RdbCSV: TRadioButton
      Tag = 5
      Left = 275
      Top = 47
      Width = 113
      Height = 17
      Caption = 'Arquivos CSV'
      TabOrder = 2
      OnClick = RdbDocClick
    end
    object RdbDoc: TRadioButton
      Left = 4
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Microsoft Word'
      TabOrder = 3
      OnClick = RdbDocClick
    end
    object RdbHTML: TRadioButton
      Tag = 3
      Left = 148
      Top = 47
      Width = 49
      Height = 17
      Caption = 'HTML'
      TabOrder = 4
      OnClick = RdbDocClick
    end
    object RdbTXT: TRadioButton
      Tag = 4
      Left = 275
      Top = 24
      Width = 121
      Height = 17
      Caption = 'Formato Texto'
      TabOrder = 5
      OnClick = RdbDocClick
    end
    object RdbOpenOffice: TRadioButton
      Tag = 6
      Left = 402
      Top = 24
      Width = 137
      Height = 17
      Caption = 'Arquivos OpenOffice'
      Enabled = False
      TabOrder = 6
      OnClick = RdbDocClick
    end
  end
  object ChkOpenFile: TCheckBox
    Left = 8
    Top = 505
    Width = 185
    Height = 17
    Caption = 'A&brir arquivo ap'#243's a exporta'#231#227'o'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object DlgSave: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Exportar Dados'
    Left = 96
    Top = 288
  end
end
