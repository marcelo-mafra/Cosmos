object FrmAbout: TFrmAbout
  Left = 0
  Top = 0
  Caption = 'Cosmos'
  ClientHeight = 608
  ClientWidth = 667
  Color = clBtnFace
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClick = FormClick
  OnCreate = FormCreate
  DesignSize = (
    667
    608)
  PixelsPerInch = 96
  TextHeight = 13
  object ImgMainLogo: TImage
    Left = 0
    Top = 0
    Width = 667
    Height = 362
    Align = alTop
    AutoSize = True
    Transparent = True
    OnClick = FormClick
    ExplicitWidth = 739
  end
  object LblComments: TLabel
    Left = 408
    Top = 256
    Width = 251
    Height = 89
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'LblComments'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
    OnClick = FormClick
  end
  object LblSOInfo: TLabel
    Left = 8
    Top = 588
    Width = 47
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblSOInfo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = FormClick
  end
  object ImgIcon: TImage
    Left = 362
    Top = 256
    Width = 40
    Height = 40
    AutoSize = True
    OnClick = FormClick
  end
  object LsvInfo: TListView
    Left = 8
    Top = 377
    Width = 651
    Height = 202
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        Caption = 'Informa'#231#227'o'
        Width = 150
      end
      item
        Caption = 'Valor'
        Width = 450
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    Visible = False
  end
end
