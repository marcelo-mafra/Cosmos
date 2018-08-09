object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit2
  BorderStyle = bsDialog
  Caption = 'Criptografia de Valores'
  ClientHeight = 148
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 24
    Width = 289
    Height = 21
    EditLabel.Width = 49
    EditLabel.Height = 13
    EditLabel.Caption = 'Passprase'
    TabOrder = 0
    Text = 'galaademnos'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 8
    Top = 64
    Width = 573
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor'
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 8
    Top = 112
    Width = 573
    Height = 21
    EditLabel.Width = 92
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor criptografado'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 448
    Top = 22
    Width = 133
    Height = 25
    Caption = 'Criptografar!!'
    TabOrder = 3
    OnClick = Button1Click
  end
end
