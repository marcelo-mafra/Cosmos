object FrmCalendar: TFrmCalendar
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Calend'#225'rio'
  ClientHeight = 195
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Calendar: TMonthCalendar
    Left = -4
    Top = 1
    Width = 240
    Height = 171
    Date = 38952.879678842590000000
    TabOrder = 0
    OnDblClick = CalendarDblClick
  end
  object ChkExtenso: TCheckBox
    Left = 3
    Top = 175
    Width = 161
    Height = 17
    Caption = '&Escrever a data por extenso'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 239
    Top = 5
    Width = 75
    Height = 25
    Caption = '&Selecionar'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 239
    Top = 36
    Width = 75
    Height = 25
    Caption = '&Fechar'
    ModalResult = 2
    TabOrder = 3
  end
end
