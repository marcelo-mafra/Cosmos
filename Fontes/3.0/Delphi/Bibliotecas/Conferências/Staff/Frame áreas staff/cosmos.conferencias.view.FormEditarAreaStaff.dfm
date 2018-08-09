object FrmEditarAreaStaff: TFrmEditarAreaStaff
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #193'rea de Staff'
  ClientHeight = 115
  ClientWidth = 376
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
    Left = 8
    Top = 15
    Width = 65
    Height = 13
    Caption = #193'rea de Staff'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 69
    Width = 361
    Height = 10
    Shape = bsBottomLine
  end
  object EdtArea: TEdit
    Left = 8
    Top = 31
    Width = 361
    Height = 21
    MaxLength = 70
    TabOrder = 0
    TextHint = 'Informe o nome da '#225'rea de staff...'
    OnChange = EdtAreaChange
    OnKeyPress = EdtAreaKeyPress
    OnKeyUp = EdtAreaKeyUp
  end
  object BtnOK: TButton
    Left = 206
    Top = 85
    Width = 75
    Height = 25
    Caption = '&OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 294
    Top = 85
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
