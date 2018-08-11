object FrmCalculator: TFrmCalculator
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Calculadora'
  ClientHeight = 226
  ClientWidth = 252
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
  object SpeedButton1: TSpeedButton
    Tag = 7
    Left = 5
    Top = 75
    Width = 35
    Height = 32
    Caption = '7'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Tag = 8
    Left = 46
    Top = 75
    Width = 35
    Height = 32
    Caption = '8'
    OnClick = SpeedButton1Click
  end
  object SpeedButton3: TSpeedButton
    Tag = 9
    Left = 87
    Top = 75
    Width = 35
    Height = 32
    Caption = '9'
    OnClick = SpeedButton1Click
  end
  object SpeedButton4: TSpeedButton
    Left = 128
    Top = 75
    Width = 35
    Height = 32
    Caption = '/'
    OnClick = SpeedButton4Click
  end
  object SpeedButton5: TSpeedButton
    Tag = 4
    Left = 5
    Top = 113
    Width = 35
    Height = 32
    Caption = '4'
    OnClick = SpeedButton1Click
  end
  object SpeedButton6: TSpeedButton
    Tag = 5
    Left = 46
    Top = 113
    Width = 35
    Height = 32
    Caption = '5'
    OnClick = SpeedButton1Click
  end
  object SpeedButton7: TSpeedButton
    Tag = 6
    Left = 87
    Top = 113
    Width = 35
    Height = 32
    Caption = '6'
    OnClick = SpeedButton1Click
  end
  object SpeedButton8: TSpeedButton
    Left = 128
    Top = 113
    Width = 35
    Height = 32
    Caption = '*'
    OnClick = SpeedButton8Click
  end
  object SpeedButton9: TSpeedButton
    Tag = 1
    Left = 5
    Top = 151
    Width = 35
    Height = 32
    Caption = '1'
    OnClick = SpeedButton1Click
  end
  object SpeedButton10: TSpeedButton
    Tag = 2
    Left = 46
    Top = 151
    Width = 35
    Height = 32
    Caption = '2'
    OnClick = SpeedButton1Click
  end
  object SpeedButton11: TSpeedButton
    Tag = 3
    Left = 87
    Top = 151
    Width = 35
    Height = 32
    Caption = '3'
    OnClick = SpeedButton1Click
  end
  object SpeedButton12: TSpeedButton
    Left = 128
    Top = 151
    Width = 35
    Height = 32
    Caption = '-'
    OnClick = SpeedButton12Click
  end
  object SpeedButton13: TSpeedButton
    Left = 5
    Top = 189
    Width = 76
    Height = 32
    Caption = '0'
    OnClick = SpeedButton1Click
  end
  object SpeedButton14: TSpeedButton
    Left = 87
    Top = 189
    Width = 35
    Height = 32
    Caption = ','
  end
  object SpeedButton15: TSpeedButton
    Left = 128
    Top = 189
    Width = 35
    Height = 32
    Caption = '+'
    OnClick = SpeedButton15Click
  end
  object SpeedButton16: TSpeedButton
    Left = 169
    Top = 151
    Width = 35
    Height = 70
    Caption = '='
  end
  object SpeedButton17: TSpeedButton
    Left = 169
    Top = 113
    Width = 35
    Height = 32
    Caption = '<-'
  end
  object SpeedButton18: TSpeedButton
    Left = 169
    Top = 75
    Width = 35
    Height = 32
    Caption = 'C'
    OnClick = SpeedButton18Click
  end
  object SpeedButton19: TSpeedButton
    Left = 210
    Top = 75
    Width = 35
    Height = 32
    Caption = 'CC'
  end
  object SpeedButton20: TSpeedButton
    Left = 210
    Top = 151
    Width = 35
    Height = 70
    Caption = '<<'
  end
  object SpeedButton21: TSpeedButton
    Left = 210
    Top = 113
    Width = 35
    Height = 32
    Caption = 'X'
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 242
    Height = 54
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object LblResult: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 22
      Width = 229
      Height = 25
      Margins.Right = 6
      Align = alBottom
      Alignment = taRightJustify
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 221
      ExplicitWidth = 11
    end
    object LblCounter: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 3
      Width = 226
      Height = 11
      Margins.Left = 5
      Margins.Right = 7
      Margins.Bottom = 5
      Align = alClient
      Alignment = taRightJustify
      Caption = '9 + 8 - 6 / 5 * 9'
      ExplicitLeft = 155
      ExplicitWidth = 76
      ExplicitHeight = 13
    end
  end
end
