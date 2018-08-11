inherited FrmWzNovoCirculoEI: TFrmWzNovoCirculoEI
  HelpContext = 305
  Caption = 'Novo C'#237'rculo da Escola Interna'
  ClientHeight = 466
  ClientWidth = 587
  ExplicitWidth = 593
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Top = 424
    Width = 587
    ExplicitTop = 424
    ExplicitWidth = 587
    inherited Bevel1: TBevel
      Width = 587
      ExplicitWidth = 587
    end
    inherited BtnPrior: TBitBtn
      Left = 344
      Anchors = [akRight, akBottom]
      ExplicitLeft = 344
    end
    inherited BtnNext: TBitBtn
      Left = 425
      Anchors = [akRight, akBottom]
      ExplicitLeft = 425
    end
    inherited BtnCancel: TBitBtn
      Left = 506
      Anchors = [akRight, akBottom]
      ExplicitLeft = 506
    end
  end
  inherited PcWizard: TPageControl
    Width = 587
    Height = 368
    ExplicitWidth = 587
    ExplicitHeight = 368
    inherited TabSheet1: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 579
      ExplicitHeight = 337
      inherited Image1: TImage
        Height = 337
        ExplicitHeight = 337
      end
      inherited Label1: TLabel
        Width = 384
        Height = 306
        Caption = 
          'Este assistente ir'#225' auxili'#225'-lo na cria'#231#227'o passo-a-passo de um no' +
          'vo c'#237'rculo da Escola Interna!'
        ExplicitWidth = 384
        ExplicitHeight = 306
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        579
        337)
      object Label2: TLabel
        Left = 12
        Top = 14
        Width = 24
        Height = 13
        Caption = 'Foco'
      end
      object Label3: TLabel
        Left = 10
        Top = 118
        Width = 80
        Height = 13
        Caption = 'Nome do C'#237'rculo'
      end
      object Label4: TLabel
        Left = 12
        Top = 177
        Width = 49
        Height = 13
        Caption = 'Sacerdote'
      end
      object Label5: TLabel
        Left = 12
        Top = 233
        Width = 56
        Height = 13
        Caption = 'Sacerdotiza'
      end
      object Label6: TLabel
        Left = 12
        Top = 66
        Width = 55
        Height = 13
        Caption = 'Discipulado'
      end
      object DBEdit1: TDBEdit
        Left = 12
        Top = 137
        Width = 527
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'NOMGRU'
        DataSource = DsrCirculo
        TabOrder = 0
      end
      object EdtFoco: TEdit
        Left = 12
        Top = 31
        Width = 555
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      inline FmeFKSearch1: TFmeFKSearch
        Left = 14
        Top = 191
        Width = 553
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        TabStop = True
        ExplicitLeft = 14
        ExplicitTop = 191
        ExplicitWidth = 553
        ExplicitHeight = 24
        inherited SpeedButton1: TSpeedButton
          Left = 527
          ExplicitLeft = 269
        end
        inherited EdtData: TDBEdit
          Width = 524
          DataField = 'nomsac'
          DataSource = DsrCirculo
          ExplicitWidth = 524
        end
      end
      inline FmeFKSearch2: TFmeFKSearch
        Left = 14
        Top = 248
        Width = 550
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        TabStop = True
        ExplicitLeft = 14
        ExplicitTop = 248
        ExplicitWidth = 550
        ExplicitHeight = 24
        inherited SpeedButton1: TSpeedButton
          Left = 524
          ExplicitLeft = 268
        end
        inherited EdtData: TDBEdit
          Width = 521
          DataField = 'nomsaz'
          DataSource = DsrCirculo
          ExplicitWidth = 521
        end
      end
      inline FmeFKSearch3: TFmeFKSearch
        Left = 11
        Top = 81
        Width = 556
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        TabStop = True
        ExplicitLeft = 11
        ExplicitTop = 81
        ExplicitWidth = 556
        ExplicitHeight = 24
        inherited SpeedButton1: TSpeedButton
          Left = 530
          ExplicitLeft = 269
        end
        inherited EdtData: TDBEdit
          Width = 527
          DataField = 'SIGDIS'
          DataSource = DsrCirculo
          ExplicitWidth = 527
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        579
        337)
      object Button1: TButton
        Left = 417
        Top = 3
        Width = 75
        Height = 25
        Action = ActNew
        Anchors = [akTop, akRight]
        TabOrder = 0
      end
      object Button2: TButton
        Left = 498
        Top = 3
        Width = 75
        Height = 25
        Action = ActDelete
        Anchors = [akTop, akRight]
        TabOrder = 1
      end
      inline FmeGridSearch1: TFmeGridSearch
        Left = 4
        Top = 30
        Width = 572
        Height = 304
        Anchors = [akLeft, akTop, akRight, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        TabStop = True
        ExplicitLeft = 4
        ExplicitTop = 30
        ExplicitWidth = 572
        inherited PnlSearchBar: TPanel
          Width = 572
          ExplicitWidth = 572
          inherited SbnSearch: TSpeedButton
            Left = 546
            ExplicitLeft = 413
          end
          inherited SbnLocate: TSpeedButton
            Left = 512
            ExplicitLeft = 512
          end
          inherited EdtSearch: TEdit
            Width = 542
            ExplicitWidth = 542
          end
        end
        inherited DBGrid1: TDBGrid
          Width = 572
          DataSource = DsrMembros
          TitleFont.Name = 'MS Sans Serif'
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'TabSheet4'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        579
        337)
      object MSGroupHeader1: TMSGroupHeader
        Left = 6
        Top = 237
        Width = 570
        Height = 53
        Transparent = True
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Senha do Contato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
        object Label8: TLabel
          Left = 3
          Top = 28
          Width = 34
          Height = 13
          Caption = 'Senha:'
        end
        object Label9: TLabel
          Left = 223
          Top = 28
          Width = 64
          Height = 13
          Caption = 'Confirma'#231#227'o:'
        end
        object DBEdit2: TDBEdit
          Left = 43
          Top = 25
          Width = 148
          Height = 21
          DataField = 'SENCON'
          DataSource = DsrCirculo
          PasswordChar = '*'
          TabOrder = 0
        end
        object EdtConfirm: TEdit
          Left = 293
          Top = 25
          Width = 159
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
      end
      object MSGroupHeader2: TMSGroupHeader
        Left = 3
        Top = 3
        Width = 607
        Height = 224
        Transparent = True
        Caption = 'Contato do C'#237'rculo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        DesignSize = (
          607
          224)
        object DBCtrlGrid1: TDBCtrlGrid
          Left = 3
          Top = 11
          Width = 605
          Height = 203
          AllowDelete = False
          AllowInsert = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = DsrMembros
          PanelBorder = gbNone
          PanelHeight = 29
          PanelWidth = 588
          TabOrder = 0
          RowCount = 7
          object DBText1: TDBText
            Left = 62
            Top = 8
            Width = 331
            Height = 17
            DataField = 'NOMCAD'
            DataSource = DsrMembros
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBCheckBox1: TDBCheckBox
            Left = 554
            Top = 8
            Width = 17
            Height = 17
            Anchors = [akTop, akRight]
            DataField = 'INDCON'
            DataSource = DsrMembros
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'TabSheet5'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        579
        337)
      object Label7: TLabel
        Left = 13
        Top = 32
        Width = 112
        Height = 13
        Caption = 'Li'#231#227'o da Escola Interna'
      end
      inline FmeFKSearch4: TFmeFKSearch
        Left = 13
        Top = 50
        Width = 563
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = True
        ExplicitLeft = 13
        ExplicitTop = 50
        ExplicitWidth = 563
        ExplicitHeight = 24
        inherited SpeedButton1: TSpeedButton
          Left = 537
          ExplicitLeft = 269
        end
        inherited EdtData: TDBEdit
          Width = 534
          DataField = 'NOMLIC'
          DataSource = DsrCirculo
          ExplicitWidth = 534
        end
      end
    end
  end
  inherited Panel1: TPanel
    Width = 587
    ExplicitWidth = 587
    inherited LblHelp: TLabel
      Width = 526
      ExplicitWidth = 526
    end
    inherited Image2: TImage
      Left = 548
      ExplicitLeft = 548
    end
    inherited Bevel2: TBevel
      Width = 587
      ExplicitWidth = 587
    end
  end
  inherited ActionList1: TActionList
    Left = 60
    Top = 373
    object ActNew: TAction
      Caption = 'Novo...'
      OnExecute = ActNewExecute
      OnUpdate = ActNewUpdate
    end
    object ActDelete: TAction
      Caption = '&Excluir'
      OnExecute = ActDeleteExecute
      OnUpdate = ActDeleteUpdate
    end
  end
  inherited ImageList1: TImageList
    Left = 108
    Top = 372
    Bitmap = {
      494C010103000400440012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000480000001200000001002000000000004014
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7CEC600E7CE
      C600DECEC600DEC6BD00DEC6BD00E7CEBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F5B0000CF980800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CF9808007F5B00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFCEC600EFE7DE00EFEFEF00E7E7
      EF00DED6D600D6CECE00CECECE00C6C6BD00CEB5B500E7CEBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F5B0000CF9808007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F5B0000CF9808007F5B
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EFCEC600F7F7EF00F7FFFF00E7CEC600D694
      7300D68C6300D68C6300D68C6B00CEB5A500C6C6C600C6B5B500DEC6B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F5B0000CF980800F6CB97007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F5B0000F6CB9700CF98
      08007F5B00000000000000000000000000000000000000000000000000000000
      00000000000000000000EFCEBD00FFF7F700FFFFFF00DEA58400CE632900CE63
      2900F7E7D600F7D6C600CE632900CE632900CE947B00C6C6C600CEBDBD00E7CE
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F5B0000CF980800F6CB9700F6CB97007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F5B0000F6CB9700F6CB
      9700CF9808007F5B000000000000000000000000000000000000000000000000
      00000000000000000000F7EFE700FFFFFF00E7AD9400CE5A2100CE632900CE6B
      3100EFBDA500E7B59C00CE633100CE633100CE632100D69C7B00CECECE00DEC6
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F5B0000CF980800F6CB9700F6CB9700F6CB97007F5B00007F5B00007F5B
      00007F5B0000CF98080000000000000000000000000000000000000000000000
      000000000000CF9808007F5B00007F5B00007F5B00007F5B0000F6CB9700F6CB
      9700F6CB9700CF9808007F5B0000000000000000000000000000000000000000
      000000000000EFCEC600FFFFFF00F7E7DE00D6733900CE633100CE633100D673
      4200E7B59C00E7A58400CE632900CE6B3100CE633100CE6B3100D6C6BD00D6D6
      D600E7CEBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F5B
      0000CF980800F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB97007F5B000000000000000000000000000000000000000000000000
      0000000000007F5B0000F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB9700F6CB9700CF9808007F5B00000000000000000000000000000000
      000000000000EFDED600FFFFFF00EFBD9C00D6733900D6734200CE6B3100D67B
      4A00FFFFF700FFF7EF00CE6B3900CE632900CE6B3100CE632900D6A58400DEE7
      E700E7CEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F5B0000CF98
      0800F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB97007F5B000000000000000000000000000000000000000000000000
      0000000000007F5B0000F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB9700F6CB9700F6CB9700CF9808007F5B000000000000000000000000
      000000000000F7E7DE00FFFFFF00E7AD8400D6844200D6844A00D67B4200CE6B
      3900EFC6B500FFFFFF00F7D6C600D6734200CE632900CE632900D68C6B00EFEF
      F700E7D6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CF980800FFF3
      D500F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB97007F5B000000000000000000000000000000000000000000000000
      0000000000007F5B0000F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB9700F6CB9700F6CB9700FFF3D500CF98080000000000000000000000
      000000000000F7E7DE00FFFFFF00EFB58C00DE8C5200DE8C5200D6844A00D67B
      4200D6734200EFC6B500FFFFFF00F7E7DE00D6734200CE5A2100DE946B00F7F7
      FF00EFD6CE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CF98
      0800FFF3D500F6CB9700F6CB9700F6CB9700FFF3D500FFF3D500FFF3D500FFF3
      D500FFF3D5007F5B000000000000000000000000000000000000000000000000
      0000000000007F5B0000FFF3D500FFF3D500FFF3D500FFF3D500FFF3D500F6CB
      9700F6CB9700F6CB9700FFF3D500CF9808000000000000000000000000000000
      000000000000EFDECE00FFFFFF00F7CEB500DE945A00E79C6300E79C6B00DE8C
      5200D6844A00D6733900EFC6AD00FFFFFF00E7AD9400C6521800E7AD8C00F7FF
      FF00EFD6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CF980800FFF3D500F6CB9700F6CB9700FFF3D5007F5B0000CF980800CF98
      0800CF980800CF98080000000000000000000000000000000000000000000000
      000000000000CF980800CF980800CF980800CF9808007F5B0000FFF3D500F6CB
      9700F6CB9700FFF3D500CF980800000000000000000000000000000000000000
      000000000000EFDECE00FFFFFF00FFF7E700E7A56B00F7DEC600FFFFFF00EFB5
      9400DE844A00D67B3900E7AD8C00FFFFFF00EFBDA500CE6B3100F7E7DE00F7F7
      F700EFD6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CF980800FFF3D500F6CB9700FFF3D5007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F5B0000FFF3D500F6CB
      9700FFF3D500CF98080000000000000000000000000000000000000000000000
      00000000000000000000F7E7E700FFFFFF00F7D6B500EFC69C00FFFFFF00FFFF
      F700EFCEB500EFCEAD00FFFFF700FFFFFF00DE946300E7B59400FFFFFF00EFDE
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CF980800FFF3D500FFF3D5007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F5B0000FFF3D500FFF3
      D500CF9808000000000000000000000000000000000000000000000000000000
      00000000000000000000EFD6CE00FFF7EF00FFFFFF00F7D6AD00F7CEAD00FFEF
      E700FFFFF700FFFFF700FFE7DE00EFB58C00EFBD9C00FFFFFF00F7EFEF00EFDE
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CF980800FFF3D5007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F5B0000FFF3D500CF98
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EFD6CE00FFF7EF00FFFFFF00FFEFDE00F7D6
      B500F7D6AD00EFCEAD00EFCEAD00F7E7D600FFFFFF00F7EFEF00EFCEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CF9808007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F5B0000CF9808000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFD6CE00F7EFE700FFF7F700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7E7E700F7E7E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFD6CE00EFD6
      CE00EFDECE00EFD6CE00EFD6CE00EFD6CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000120000000100010000000000D80000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFC0000000000FFFFFFFF
      FFC0FC0000000000FF3FFF9FFF003C0000000000FE3FFF8FFE001C0000000000
      FC3FFF87FC000C0000000000F83FFF83FC000C0000000000F003F801F8000400
      00000000E003F800F800040000000000C003F8007800040000000000C003F800
      7800040000000000E003F800F800040000000000F003F801F800040000000000
      F83FFF83FC000C0000000000FC3FFF87FC000C0000000000FE3FFF8FFE001C00
      00000000FF3FFF9FFF003C0000000000FFFFFFFFFFC0FC0000000000FFFFFFFF
      FFFFFC000000000000000000000000000000000000000000000000000000}
  end
  inherited WzCosmos: TWizard
    Pages = <
      item
        Title = 'Bem-vindo!'
        Description = 'Bem-vindo ao assistente de cria'#231#227'o de novos c'#237'rculos'
        Visible = True
      end
      item
        Title = 'Dados do novo c'#237'rculo'
        Description = 'Digite as informa'#231#245'es iniciais sobre o novo c'#237'rculo.'
        Visible = True
      end
      item
        Title = 'Membros do novo c'#237'rculo'
        Description = 'Insira na grade as pessoas que far'#227'o parte do novo c'#237'rculo.'
        Visible = True
      end
      item
        Title = 'Contato do novo c'#237'rculo'
        Description = 'Marque quais pessoas servir'#227'o de contato do novo c'#237'rculo.'
        Visible = True
      end
      item
        Title = 'Li'#231#227'o atual'
        Description = 'Indique em qual li'#231#227'o o novo c'#237'rculo se encontra.'
        Visible = True
      end>
    Title = 'Novo c'#237'rculo da Escola Interna'
    OnBeforeNextPage = WzCosmosBeforeNextPage
    Left = 19
    Top = 372
  end
  object CdsCirculo: TClientDataSet
    PersistDataPacket.Data = {
      310100009619E0BD01000000180000000D000000000003000000310106434F44
      4752550400010004000000064E4F4D4752550100490004000100055749445448
      020002000F0006434F44464F43040001000400000006434F444C494304000100
      0400000006434F44444953040001000400000006534947444953010049002400
      0100055749445448020002000300064E4F4D4C49560100490000000100055749
      445448020002000F00064E4F4D4C494301004900000001000557494454480200
      02000F0006434F445341430400010000000000066E6F6D736163010049000000
      010005574944544802000200460006434F4453415A0400010000000000066E6F
      6D73617A01004900000001000557494454480200020046000653454E434F4E01
      00490000000100055749445448020002000F000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODGRU'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOMGRU'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'CODFOC'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODLIC'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODDIS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'SIGDIS'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NOMLIV'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'NOMLIC'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'CODSAC'
        DataType = ftInteger
      end
      item
        Name = 'nomsac'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'CODSAZ'
        DataType = ftInteger
      end
      item
        Name = 'nomsaz'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'SENCON'
        DataType = ftString
        Size = 15
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterInsert = CdsCirculoAfterInsert
    Left = 64
    Top = 424
  end
  object CdsMembros: TClientDataSet
    PersistDataPacket.Data = {
      DD0000009619E0BD010000001800000009000000000003000000DD0006434F44
      4D454D040001000400000006434F444341440400010004000000064E4F4D4341
      440100490004000100055749445448020002004600064D415443414401004900
      04000100055749445448020002000A0006434F44444953040001000400000006
      534947444953010049002400010005574944544802000200030006434F444752
      55040001000400000006494E44434F4E01004900240001000557494454480200
      0200010006534947464F43010049000400010005574944544802000200030000
      00}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODMEM'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODCAD'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOMCAD'
        Attributes = [faRequired]
        DataType = ftString
        Size = 70
      end
      item
        Name = 'MATCAD'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'CODDIS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'SIGDIS'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CODGRU'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'INDCON'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'SIGFOC'
        Attributes = [faRequired]
        DataType = ftString
        Size = 3
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterInsert = CdsMembrosAfterInsert
    Left = 16
    Top = 424
    object CdsMembrosCODMEM: TIntegerField
      FieldName = 'CODMEM'
      Required = True
      Visible = False
    end
    object CdsMembrosCODCAD: TIntegerField
      FieldName = 'CODCAD'
      Required = True
      Visible = False
    end
    object CdsMembrosMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Required = True
      Size = 10
    end
    object CdsMembrosNOMCAD: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Required = True
      Size = 70
    end
    object CdsMembrosCODDIS: TIntegerField
      FieldName = 'CODDIS'
      Required = True
      Visible = False
    end
    object CdsMembrosSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object CdsMembrosCODGRU: TIntegerField
      FieldName = 'CODGRU'
      Required = True
      Visible = False
    end
    object CdsMembrosINDCON: TStringField
      DisplayLabel = 'Contato?'
      FieldName = 'INDCON'
      Required = True
      FixedChar = True
      Size = 1
    end
    object CdsMembrosSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      Required = True
      Size = 3
    end
  end
  object DsrCirculo: TDataSource
    DataSet = CdsCirculo
    Left = 112
    Top = 424
  end
  object DsrMembros: TDataSource
    DataSet = CdsMembros
    Left = 152
    Top = 424
  end
end
