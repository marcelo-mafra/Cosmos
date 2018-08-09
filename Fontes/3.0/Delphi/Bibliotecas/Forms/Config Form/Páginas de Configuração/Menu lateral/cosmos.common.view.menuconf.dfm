object FrmPageMenuLateral: TFrmPageMenuLateral
  Left = 0
  Top = 0
  Caption = 'Menu lateral'
  ClientHeight = 408
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    424
    408)
  PixelsPerInch = 96
  TextHeight = 13
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 8
    Width = 409
    Height = 161
    Transparent = True
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Configura'#231#245'es dos Comandos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object ChkReorder: TCheckBox
      Left = 8
      Top = 25
      Width = 121
      Height = 17
      Caption = 'Permitir reordena'#231#227'o'
      TabOrder = 0
      OnClick = ChkReorderClick
    end
    object ChkBoldText: TCheckBox
      Left = 8
      Top = 57
      Width = 121
      Height = 17
      Caption = 'Texto em negrito'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = ChkBoldTextClick
    end
    object ChkPlusSignal: TCheckBox
      Left = 8
      Top = 125
      Width = 195
      Height = 17
      Caption = 'Sinal padr'#227'o de expandir categoria'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = ChkPlusSignalClick
    end
    object ChkCategoryBorder: TCheckBox
      Left = 192
      Top = 25
      Width = 225
      Height = 17
      Caption = 'Borda apenas na categoria de comandos'
      TabOrder = 4
      OnClick = ChkCategoryBorderClick
    end
    object ChkVerticalCategory: TCheckBox
      Left = 8
      Top = 89
      Width = 153
      Height = 17
      Caption = 'Categorias na vertical'
      TabOrder = 2
      OnClick = ChkVerticalCategoryClick
    end
    object ChkNoImages: TCheckBox
      Left = 192
      Top = 57
      Width = 153
      Height = 17
      Caption = 'N'#227' usar '#237'cones nos comandos'
      TabOrder = 5
      OnClick = ChkNoImagesClick
    end
  end
  object MSGroupHeader1: TMSGroupHeader
    Left = 7
    Top = 199
    Width = 409
    Height = 194
    Transparent = True
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Visauliza'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    DesignSize = (
      409
      194)
    object Label2: TLabel
      Left = 232
      Top = 32
      Width = 177
      Height = 42
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 
        'Este controle '#233' exibido para visualiza'#231#227'o das configura'#231#245'es feit' +
        'as por voc'#234'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpFixed
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object BtManager: TCategoryButtons
      Left = 1
      Top = 33
      Width = 203
      Height = 184
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvSpace
      BevelKind = bkFlat
      BorderStyle = bsNone
      ButtonFlow = cbfVertical
      ButtonOptions = [boFullSize, boShowCaptions, boBoldCaptions, boUsePlusMinus]
      Categories = <
        item
          Caption = 'Categoria 1'
          Color = 15395839
          Collapsed = False
          Items = <
            item
            end
            item
            end>
        end
        item
          Caption = 'Categoria 2'
          Color = 15400959
          Collapsed = False
          Items = <
            item
              Caption = 'Comando 1'
            end
            item
              Caption = 'Comando 2'
            end
            item
              Caption = 'Comando 3'
            end>
        end>
      RegularButtonColor = 15660791
      SelectedButtonColor = 13361893
      ShowHint = True
      TabOrder = 0
    end
  end
end
