object FrmDataInstalacao: TFrmDataInstalacao
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Data da Instala'#231#227'o'
  ClientHeight = 234
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  DesignSize = (
    333
    234)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 30
    Height = 13
    Caption = 'Turma'
  end
  object Label2: TLabel
    Left = 8
    Top = 50
    Width = 91
    Height = 13
    Caption = 'Data da Instala'#231#227'o'
  end
  object EdtTurma: TEdit
    Left = 8
    Top = 23
    Width = 317
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 250
    Top = 67
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Instalar!'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 250
    Top = 101
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
  object Calendar: TMonthCalendar
    Left = 8
    Top = 69
    Width = 225
    Height = 160
    Date = 40800.925587939810000000
    TabOrder = 3
  end
end
