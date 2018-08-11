object FrmLinesProp: TFrmLinesProp
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Propriedades'
  ClientHeight = 325
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 29
    Height = 13
    Caption = 'Linha:'
  end
  object LblLineName: TLabel
    Left = 43
    Top = 24
    Width = 55
    Height = 13
    Caption = 'LineName'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 48
    Width = 432
    Height = 9
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 28
    Height = 13
    Caption = 'Fonte'
  end
  object Label3: TLabel
    Left = 232
    Top = 72
    Width = 44
    Height = 13
    Caption = 'Tamanho'
  end
  object Bevel2: TBevel
    Left = 8
    Top = 176
    Width = 432
    Height = 9
    Shape = bsTopLine
  end
  object Label4: TLabel
    Left = 8
    Top = 200
    Width = 86
    Height = 13
    Caption = 'Margem Esquerda'
  end
  object Label5: TLabel
    Left = 120
    Top = 200
    Width = 81
    Height = 13
    Caption = 'Margem Superior'
  end
  object Bevel3: TBevel
    Left = 8
    Top = 280
    Width = 432
    Height = 9
    Shape = bsTopLine
  end
  object CBXFontes: TComboBox
    Left = 8
    Top = 88
    Width = 218
    Height = 21
    TabOrder = 0
  end
  object EdtFontSize: TSpinEdit
    Left = 232
    Top = 88
    Width = 89
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object ChkBold: TCheckBox
    Left = 8
    Top = 136
    Width = 65
    Height = 17
    Caption = 'Negrito'
    TabOrder = 2
  end
  object ChkItalic: TCheckBox
    Left = 120
    Top = 136
    Width = 65
    Height = 17
    Caption = 'It'#225'lico'
    TabOrder = 3
  end
  object EdtPosLeft: TSpinEdit
    Left = 8
    Top = 216
    Width = 89
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object EdtPosTop: TSpinEdit
    Left = 120
    Top = 216
    Width = 89
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object Button1: TButton
    Left = 284
    Top = 295
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 6
  end
  object Button2: TButton
    Left = 365
    Top = 295
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 7
  end
end
