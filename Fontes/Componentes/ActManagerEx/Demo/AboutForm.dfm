object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 172
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    336
    172)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 320
    Height = 57
    Alignment = taCenter
    AutoSize = False
    Caption = 'Extending Action Manager Demo Application'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 71
    Width = 320
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'by Jeremy North 2006'
  end
  object Label3: TLabel
    Left = 8
    Top = 112
    Width = 110
    Height = 13
    Caption = 'Reference BDN Article:'
  end
  object lArticleLink: TLabel
    Left = 123
    Top = 112
    Width = 207
    Height = 13
    Cursor = crHandPoint
    Caption = 'http://cc.borland.com/item.aspx?id=23960'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lArticleLinkClick
    OnMouseEnter = lArticleLinkMouseEnter
    OnMouseLeave = lArticleLinkMouseLeave
  end
  object Button1: TButton
    Left = 253
    Top = 139
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
end
