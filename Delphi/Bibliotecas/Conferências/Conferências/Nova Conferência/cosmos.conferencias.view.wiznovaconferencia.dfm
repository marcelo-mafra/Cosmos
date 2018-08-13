inherited FrmNovaConferencia: TFrmNovaConferencia
  HelpContext = 590
  Caption = 'Nova Confer'#234'ncia'
  ClientHeight = 501
  ClientWidth = 603
  ExplicitWidth = 609
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Top = 459
    Width = 603
    ExplicitTop = 459
    ExplicitWidth = 603
    inherited Bevel1: TBevel
      Width = 603
      ExplicitWidth = 603
    end
    inherited BtnPrior: TBitBtn
      Left = 360
      ExplicitLeft = 360
    end
    inherited BtnNext: TBitBtn
      Left = 441
      ExplicitLeft = 441
    end
    inherited BtnCancel: TBitBtn
      Left = 522
      ExplicitLeft = 522
    end
    inherited BtnHelp: TBitBtn
      Action = ActAjuda
      Caption = 'Aj&uda'
    end
  end
  inherited PcWizard: TPageControl
    Width = 603
    Height = 403
    ExplicitWidth = 603
    ExplicitHeight = 403
    inherited TabSheet1: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 595
      ExplicitHeight = 372
      inherited Image1: TImage
        Height = 372
        ExplicitHeight = 372
      end
      inherited Label1: TLabel
        Top = 40
        Width = 400
        Height = 304
        Caption = 
          'Bem-vindo ao assistente de cria'#231#227'o de confer'#234'ncias! Este assiste' +
          'nte '#233' desenhado para auxiliar o processo de agendamento de novas' +
          ' confer'#234'ncias no sistema Cosmos.'
        ExplicitTop = 40
        ExplicitWidth = 400
        ExplicitHeight = 304
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
        595
        372)
      object Label2: TLabel
        Left = 12
        Top = 29
        Width = 103
        Height = 13
        Caption = 'Nome da Confer'#234'ncia'
      end
      object EdtNomeConf: TEdit
        Left = 12
        Top = 45
        Width = 571
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object MSGroupHeader1: TMSGroupHeader
        Left = 12
        Top = 93
        Width = 571
        Height = 68
        Transparent = True
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Promotor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        DesignSize = (
          571
          68)
        object Label3: TLabel
          Left = 0
          Top = 23
          Width = 23
          Height = 13
          Caption = 'Foco'
        end
        object Label4: TLabel
          Left = 392
          Top = 23
          Width = 33
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Campo'
          ExplicitLeft = 396
        end
        object EdtFocoPromotor: TEdit
          Left = 0
          Top = 39
          Width = 364
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
        object CBXCampo: TValueComboBox
          Left = 392
          Top = 39
          Width = 179
          Height = 22
          Style = csOwnerDrawFixed
          Anchors = [akTop, akRight]
          TabOrder = 1
          Items.Strings = (
            'Lectorium Rosicrucianum'
            'Trabalho da Mocidade'
            'Escola Interna'
            'Trabalho P'#250'blico'
            'Trabalho de Simpatizantes')
          Values.Strings = (
            'LEC'
            'TM'
            'EI'
            'TP'
            'SIM')
        end
      end
      object MSGroupHeader2: TMSGroupHeader
        Left = 12
        Top = 184
        Width = 571
        Height = 129
        Transparent = True
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Datas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        DesignSize = (
          571
          129)
        object Label5: TLabel
          Left = 0
          Top = 23
          Width = 25
          Height = 13
          Caption = 'In'#237'cio'
        end
        object Label6: TLabel
          Left = 118
          Top = 23
          Width = 23
          Height = 13
          Caption = 'Hora'
        end
        object Label7: TLabel
          Left = 383
          Top = 23
          Width = 23
          Height = 13
          Caption = 'Hora'
        end
        object Label8: TLabel
          Left = 265
          Top = 23
          Width = 38
          Height = 13
          Caption = 'T'#233'rmino'
        end
        object Label16: TLabel
          Left = 2
          Top = 79
          Width = 89
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'M'#234's de Refer'#234'ncia'
        end
        object EdtDataInicial: TDateTimePicker
          Left = 0
          Top = 39
          Width = 99
          Height = 21
          Date = 39064.570013379630000000
          Time = 39064.570013379630000000
          TabOrder = 0
        end
        object EdtHoraInicio: TDateTimePicker
          Left = 118
          Top = 39
          Width = 93
          Height = 21
          Date = 39064.570013379630000000
          Time = 39064.570013379630000000
          Kind = dtkTime
          TabOrder = 1
        end
        object EdtHoraFim: TDateTimePicker
          Left = 383
          Top = 39
          Width = 93
          Height = 21
          Date = 39064.570013379630000000
          Time = 39064.570013379630000000
          Kind = dtkTime
          TabOrder = 3
        end
        object EdtDataFinal: TDateTimePicker
          Left = 265
          Top = 39
          Width = 99
          Height = 21
          Date = 39064.570013379630000000
          Time = 39064.570013379630000000
          TabOrder = 2
        end
        object CBXMesReferencia: TValueComboBox
          Left = 0
          Top = 95
          Width = 211
          Height = 22
          Style = csOwnerDrawFixed
          Anchors = [akTop, akRight]
          TabOrder = 4
          Items.Strings = (
            'Janeiro'
            'Fevereiro'
            'Mar'#231'o'
            'Abril'
            'Maio'
            'Junho'
            'Julho'
            'Agosto'
            'Setembro'
            'Outubro'
            'Novembro'
            'Dezembro')
          Values.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12')
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
        595
        372)
      object MSGroupHeader3: TMSGroupHeader
        Left = 12
        Top = 16
        Width = 571
        Height = 77
        Transparent = True
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Inscri'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object Label9: TLabel
          Left = 4
          Top = 23
          Width = 125
          Height = 13
          Caption = 'Data-limite para inscri'#231#245'es'
        end
        object Label10: TLabel
          Left = 216
          Top = 23
          Width = 91
          Height = 13
          Caption = 'Limite de inscri'#231#245'es'
        end
        object EdtDataLimite: TDateTimePicker
          Left = 4
          Top = 39
          Width = 185
          Height = 21
          Date = 39064.570013379630000000
          Time = 39064.570013379630000000
          TabOrder = 0
        end
        object EdtLimite: TSpinEdit
          Left = 216
          Top = 39
          Width = 121
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 100
        end
      end
      object MSGroupHeader4: TMSGroupHeader
        Left = 16
        Top = 112
        Width = 567
        Height = 129
        Transparent = True
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Situa'#231#227'o da Confer'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object RdbProgramada: TRadioButton
          Left = 0
          Top = 32
          Width = 137
          Height = 17
          Caption = 'Confer'#234'ncia Programada'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RdbCorrente: TRadioButton
          Left = 0
          Top = 64
          Width = 125
          Height = 17
          Caption = 'Confer'#234'ncia Corrente'
          TabOrder = 1
        end
        object RdbEncerrada: TRadioButton
          Left = 198
          Top = 32
          Width = 135
          Height = 17
          Caption = 'Confer'#234'ncia Encerrada'
          TabOrder = 2
        end
        object ChkEspecial: TCheckBox
          Left = 0
          Top = 104
          Width = 185
          Height = 17
          Caption = 'Marcar como Confer'#234'ncia Especial'
          TabOrder = 3
        end
        object ChkModelo: TCheckBox
          Left = 212
          Top = 104
          Width = 121
          Height = 17
          Caption = 'Marcar como Modelo'
          Enabled = False
          TabOrder = 4
        end
      end
      object MSGroupHeader6: TMSGroupHeader
        Left = 12
        Top = 268
        Width = 571
        Height = 77
        Transparent = True
        Caption = 'Taxa de Confer'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object Label11: TLabel
          Left = 4
          Top = 32
          Width = 24
          Height = 13
          Caption = 'Valor'
        end
        object EdtTaxa: TEdit
          Left = 4
          Top = 48
          Width = 185
          Height = 21
          TabOrder = 0
          OnKeyPress = EdtTaxaKeyPress
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
        595
        372)
      object MSGroupHeader5: TMSGroupHeader
        Left = 16
        Top = 16
        Width = 571
        Height = 251
        Transparent = True
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Controle de Freq'#252#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object Label13: TLabel
          Left = 41
          Top = 63
          Width = 520
          Height = 26
          AutoSize = False
          Caption = 
            'A pessoa ganhar'#225' presen'#231'a imediatamente ao passar pelo check-in ' +
            'de chegada. O sistema apenas verifica se o chek-in foi feito par' +
            'a atribuir presen'#231'a na confer'#234'ncia.'
          WordWrap = True
        end
        object Label14: TLabel
          Left = 41
          Top = 136
          Width = 520
          Height = 26
          AutoSize = False
          Caption = 
            'A pessoa ganhar'#225' presen'#231'a em todas as atividades da confer'#234'ncia ' +
            'como se ela fosse composta de uma '#250'nica atividade.'
          WordWrap = True
        end
        object Label15: TLabel
          Left = 41
          Top = 208
          Width = 520
          Height = 41
          AutoSize = False
          Caption = 
            'Voc'#234' dever'#225' controlar a presen'#231'a das pessoas em cadas uma das at' +
            'ividades da confer'#234'ncia. A pessoa precisa receber presen'#231'a em to' +
            'dos os servi'#231'os templ'#225'rios e ao menos o servi'#231'o de meio-dia ou c' +
            'anto para que seja considerada presente.'
          WordWrap = True
        end
        object RdbByCheckin: TRadioButton
          Left = 16
          Top = 40
          Width = 121
          Height = 17
          Caption = 'Controle por check-in'
          TabOrder = 0
        end
        object RdbByConference: TRadioButton
          Left = 16
          Top = 113
          Width = 185
          Height = 17
          Caption = 'Controle unit'#225'rio  por confer'#234'ncia'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object RdbByAtivity: TRadioButton
          Left = 16
          Top = 185
          Width = 185
          Height = 17
          Caption = 'Controle em todas as atividades'
          TabOrder = 2
        end
      end
    end
  end
  inherited Panel1: TPanel
    Width = 603
    ExplicitWidth = 603
    inherited LblHelp: TLabel
      Width = 542
      ExplicitWidth = 542
    end
    inherited Image2: TImage
      Left = 564
      ExplicitLeft = 564
    end
    inherited Bevel2: TBevel
      Width = 603
      ExplicitWidth = 603
    end
  end
  inherited ActionList1: TActionList
    Left = 236
    Top = 333
    inherited ActHelp: TAction
      HelpKeyword = 'nova_conferencia'
    end
    object ActAjuda: TAction
      Caption = 'Aj&uda'
      HelpKeyword = 'nova_conferencia'
      Hint = 'Ajuda|Aciona o sistema de ajuda'
      ImageIndex = 2
      OnExecute = ActAjudaExecute
    end
  end
  inherited ImageList1: TImageList
    Left = 132
    Top = 228
    Bitmap = {
      494C010103007000740012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000007B5A0000CE9C0800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C08007B5A00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFCEC600EFE7DE00EFEFEF00E7E7
      EF00DED6D600D6CECE00CECECE00C6C6BD00CEB5B500E7CEBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B5A0000CE9C08007B5A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B5A0000CE9C08007B5A
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EFCEC600F7F7EF00F7FFFF00E7CEC600D694
      7300D68C6300D68C6300D68C6B00CEB5A500C6C6C600C6B5B500DEC6B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B5A0000CE9C0800F7CE94007B5A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B5A0000F7CE9400CE9C
      08007B5A00000000000000000000000000000000000000000000000000000000
      00000000000000000000EFCEBD00FFF7F700FFFFFF00DEA58400CE632900CE63
      2900F7E7D600F7D6C600CE632900CE632900CE947B00C6C6C600CEBDBD00E7CE
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B5A0000CE9C0800F7CE9400F7CE94007B5A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B5A0000F7CE9400F7CE
      9400CE9C08007B5A000000000000000000000000000000000000000000000000
      00000000000000000000F7EFE700FFFFFF00E7AD9400CE5A2100CE632900CE6B
      3100EFBDA500E7B59C00CE633100CE633100CE632100D69C7B00CECECE00DEC6
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B5A0000CE9C0800F7CE9400F7CE9400F7CE94007B5A00007B5A00007B5A
      00007B5A0000CE9C080000000000000000000000000000000000000000000000
      000000000000CE9C08007B5A00007B5A00007B5A00007B5A0000F7CE9400F7CE
      9400F7CE9400CE9C08007B5A0000000000000000000000000000000000000000
      000000000000EFCEC600FFFFFF00F7E7DE00D6733900CE633100CE633100D673
      4200E7B59C00E7A58400CE632900CE6B3100CE633100CE6B3100D6C6BD00D6D6
      D600E7CEBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B5A
      0000CE9C0800F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE
      9400F7CE94007B5A000000000000000000000000000000000000000000000000
      0000000000007B5A0000F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE
      9400F7CE9400F7CE9400CE9C08007B5A00000000000000000000000000000000
      000000000000EFDED600FFFFFF00EFBD9C00D6733900D6734200CE6B3100D67B
      4A00FFFFF700FFF7EF00CE6B3900CE632900CE6B3100CE632900D6A58400DEE7
      E700E7CEC6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B5A0000CE9C
      0800F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE
      9400F7CE94007B5A000000000000000000000000000000000000000000000000
      0000000000007B5A0000F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE
      9400F7CE9400F7CE9400F7CE9400CE9C08007B5A000000000000000000000000
      000000000000F7E7DE00FFFFFF00E7AD8400D6844200D6844A00D67B4200CE6B
      3900EFC6B500FFFFFF00F7D6C600D6734200CE632900CE632900D68C6B00EFEF
      F700E7D6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C0800FFF7
      D600F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE
      9400F7CE94007B5A000000000000000000000000000000000000000000000000
      0000000000007B5A0000F7CE9400F7CE9400F7CE9400F7CE9400F7CE9400F7CE
      9400F7CE9400F7CE9400F7CE9400FFF7D600CE9C080000000000000000000000
      000000000000F7E7DE00FFFFFF00EFB58C00DE8C5200DE8C5200D6844A00D67B
      4200D6734200EFC6B500FFFFFF00F7E7DE00D6734200CE5A2100DE946B00F7F7
      FF00EFD6CE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE9C
      0800FFF7D600F7CE9400F7CE9400F7CE9400FFF7D600FFF7D600FFF7D600FFF7
      D600FFF7D6007B5A000000000000000000000000000000000000000000000000
      0000000000007B5A0000FFF7D600FFF7D600FFF7D600FFF7D600FFF7D600F7CE
      9400F7CE9400F7CE9400FFF7D600CE9C08000000000000000000000000000000
      000000000000EFDECE00FFFFFF00F7CEB500DE945A00E79C6300E79C6B00DE8C
      5200D6844A00D6733900EFC6AD00FFFFFF00E7AD9400C6521800E7AD8C00F7FF
      FF00EFD6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE9C0800FFF7D600F7CE9400F7CE9400FFF7D6007B5A0000CE9C0800CE9C
      0800CE9C0800CE9C080000000000000000000000000000000000000000000000
      000000000000CE9C0800CE9C0800CE9C0800CE9C08007B5A0000FFF7D600F7CE
      9400F7CE9400FFF7D600CE9C0800000000000000000000000000000000000000
      000000000000EFDECE00FFFFFF00FFF7E700E7A56B00F7DEC600FFFFFF00EFB5
      9400DE844A00D67B3900E7AD8C00FFFFFF00EFBDA500CE6B3100F7E7DE00F7F7
      F700EFD6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE9C0800FFF7D600F7CE9400FFF7D6007B5A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B5A0000FFF7D600F7CE
      9400FFF7D600CE9C080000000000000000000000000000000000000000000000
      00000000000000000000F7E7E700FFFFFF00F7D6B500EFC69C00FFFFFF00FFFF
      F700EFCEB500EFCEAD00FFFFF700FFFFFF00DE946300E7B59400FFFFFF00EFDE
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CE9C0800FFF7D600FFF7D6007B5A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B5A0000FFF7D600FFF7
      D600CE9C08000000000000000000000000000000000000000000000000000000
      00000000000000000000EFD6CE00FFF7EF00FFFFFF00F7D6AD00F7CEAD00FFEF
      E700FFFFF700FFFFF700FFE7DE00EFB58C00EFBD9C00FFFFFF00F7EFEF00EFDE
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CE9C0800FFF7D6007B5A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B5A0000FFF7D600CE9C
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EFD6CE00FFF7EF00FFFFFF00FFEFDE00F7D6
      B500F7D6AD00EFCEAD00EFCEAD00F7E7D600FFFFFF00F7EFEF00EFCEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CE9C08007B5A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B5A0000CE9C08000000
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
        Title = 'Bem-vindo'
        Description = 'Bem-vindo ao assistente de cria'#231#227'o de confer'#234'ncias!'
        Visible = True
      end
      item
        Title = 'Dados da confer'#234'ncia'
        Description = 'Forne'#231'a os dados fundamentais da confer'#234'ncia'
        Visible = True
      end
      item
        Title = 'Informa'#231#245'es adicionais'
        Description = 'Forne'#231'a outras informa'#231#245'es adicionais'
        Visible = True
      end
      item
        Title = 'Controle de freq'#252#234'ncia'
        Description = 
          'Indique como dever'#225' ser feito o controle de freq'#252#234'ncia da nova c' +
          'onfer'#234'ncia'
        Visible = True
      end>
    Title = 'Nova Confer'#234'ncia'
    Left = 131
    Top = 292
  end
end
