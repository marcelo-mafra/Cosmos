object FrmConfig: TFrmConfig
  Left = 196
  Top = 144
  HelpContext = 40
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Configura'#231#245'es'
  ClientHeight = 588
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    686
    588)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 553
    Width = 686
    Height = 35
    Align = alBottom
    Shape = bsSpacer
    ExplicitLeft = -3
  end
  object Button1: TButton
    Left = 422
    Top = 558
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 515
    Top = 558
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl: TPageControl
    AlignWithMargins = True
    Left = 225
    Top = 3
    Width = 458
    Height = 548
    Margins.Left = 0
    Margins.Bottom = 2
    ActivePage = PageRoot
    Align = alClient
    MultiLine = True
    TabOrder = 2
    object PageRoot: TTabSheet
      Caption = 'Cosmos.PageRoot'
      object LblRootTitle: TLabel
        Left = 9
        Top = 16
        Width = 98
        Height = 20
        Caption = 'LblRootTitle'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblRootDesc: TLabel
        Left = 9
        Top = 56
        Width = 424
        Height = 137
        AutoSize = False
        Caption = 'LblRootDesc'
        WordWrap = True
      end
    end
  end
  object Button5: TButton
    Left = 608
    Top = 558
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Ajuda'
    TabOrder = 3
    OnClick = Button5Click
  end
  object TrvIndex: TTreeView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 219
    Height = 547
    Align = alLeft
    Images = PageList
    Indent = 19
    ReadOnly = True
    TabOrder = 4
    OnChange = TrvIndexChange
    OnChanging = TrvIndexChanging
  end
  object PageList: TImageList
    Left = 24
    Top = 48
    Bitmap = {
      494C010101000800540010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      000000000000000000000000000000000000000000000000000000000000FB56
      D956B852DA520000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FC563B67
      3867D65A964EFC56000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001C577D6F9C77
      9A4A7846B65A964EDA5200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FC569D73FE7F5A3E
      F704F704F831D65A964EFC560000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FC56BE73FF7F7B427815
      DC4EDC4E7915F82DD65A964EDA52000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FC56BE73FF7F9B4617095711
      BF73BE7357111709F82DD65A964EFC5600000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FC56BE73FF7FFD4E5811380D580D
      9E6F7E6B370D370D1709F82DB65A754EDA520000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003C5FFF7F9E6BFA1DB91D99197815
      9E6F7E6B370D370D370D17095842D65AB8520000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003C5FFF7F9F6B3B2A1B26FA21B91D
      BF739E6F5811370D370D1709BA4E3967D9560000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FC56BE73FF7F5E5F5B2A3B265B32
      7E673D5B9915580D17097A42BC773B63FB560000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FC569E6FFF7F7E639C325B2E
      9C3A5B32B9199915BC4AFE7F7C6BFC5600000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FC569E6FFF7F9F63BC32
      BF739F6FFA21DD4EFF7F9D73FC56000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FC569E6FFF7F9F67
      5E531D4B3E57FF7FBE73FC560000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FC529E6FFF7F
      BF6F9F6BFF7FBE73FC5600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FC569E6F
      FF7FFF7FBE73FC56000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FC56
      3C5F3C5FFC560000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC3F000000000000F81F000000000000
      F00F000000000000E007000000000000C0030000000000008001000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8001000000000000C003000000000000E007000000000000F00F000000000000
      F81F000000000000FC3F00000000000000000000000000000000000000000000
      000000000000}
  end
end