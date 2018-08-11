object FrmServerMainForm: TFrmServerMainForm
  Left = 271
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Financeiro Server'
  ClientHeight = 95
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 30
    Height = 13
    Caption = 'Porta:'
  end
  object LblPort: TLabel
    Left = 44
    Top = 48
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Label2: TLabel
    Left = 8
    Top = 69
    Width = 86
    Height = 13
    Cursor = crHandPoint
    Caption = 'Testar Servidor...'
    OnClick = Label2Click
    OnMouseMove = Label2MouseMove
    OnMouseLeave = Label2MouseLeave
  end
  object ButtonStart: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 200
    Top = 24
  end
end
