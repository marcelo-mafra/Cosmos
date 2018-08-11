inherited FrmNovaConferencia: TFrmNovaConferencia
  HelpContext = 590
  Caption = 'Nova Confer'#234'ncia'
  ClientHeight = 501
  ClientWidth = 603
  ExplicitWidth = 609
  ExplicitHeight = 526
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
      494C010103007000700012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000048000000120000000100100000000000200A
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003C633C633B631B5F1B5F
      3C5F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006F0179060000000000000000000000000000000000000000000000000000
      0000000079066F01000000000000000000000000000000000000000000000000
      00003D639D6FBD779C775B6B3A673967185FD95A3C5F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000006F0179066F0100000000000000000000
      00000000000000000000000000000000000000006F0179066F01000000000000
      000000000000000000000000000000003D63DE77FE7F3C635A3A3A323A323A36
      D9521863D85A1B5B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006F01
      79063E4B6F010000000000000000000000000000000000000000000000000000
      000000006F013E4B79066F010000000000000000000000000000000000003D5F
      DF7BFF7F9B42991599159E6B5E6399159915593E1863F95E3C5F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000006F0179063E4B3E4B6F0100000000000000000000
      00000000000000000000000000000000000000006F013E4B3E4B79066F010000
      0000000000000000000000000000BE73FF7FBC4A79119915B919FD52DC4E9919
      991999117A3E39671B5F00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006F0179063E4B
      3E4B3E4B6F016F016F016F017906000000000000000000000000000079066F01
      6F016F016F013E4B3E4B3E4B79066F010000000000000000000000003D63FF7F
      9E6FDA1D99199919DA21DC4E9C429915B9199919B9191A5F5A6B3C5F00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000006F0179063E4B3E4B3E4B3E4B3E4B3E4B3E4B3E4B6F010000
      0000000000000000000000006F013E4B3E4B3E4B3E4B3E4B3E4B3E4B3E4B7906
      6F01000000000000000000007D6BFF7FFD4EDA1DDA21B919FA25FF7BDF77B91D
      9915B91999159A429B733C630000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006F0179063E4B3E4B3E4B
      3E4B3E4B3E4B3E4B3E4B3E4B6F0100000000000000000000000000006F013E4B
      3E4B3E4B3E4B3E4B3E4B3E4B3E4B3E4B79066F0100000000000000009E6FFF7F
      BC421A221A26FA21B91D1D5BFF7F5E63DA21991599153A36BD7B5C6300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007906DF6B3E4B3E4B3E4B3E4B3E4B3E4B3E4B3E4B3E4B6F010000
      0000000000000000000000006F013E4B3E4B3E4B3E4B3E4B3E4B3E4B3E4B3E4B
      DF6B790600000000000000009E6FFF7FDD463B2A3B2A1A26FA21DA211D5BFF7F
      9E6FDA2179115B36DE7F5D670000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000007906DF6B3E4B3E4B
      3E4BDF6BDF6BDF6BDF6BDF6B6F0100000000000000000000000000006F01DF6B
      DF6BDF6BDF6BDF6B3E4B3E4B3E4BDF6B7906000000000000000000007D67FF7F
      3E5B5B2E7C327C363B2A1A26DA1D1D57FF7FBC4A580DBC46FE7F5D6300000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007906DF6B3E4B3E4BDF6B6F0179067906790679060000
      00000000000000000000000079067906790679066F01DF6B3E4B3E4BDF6B7906
      0000000000000000000000007D67FF7FDF739C367E63FF7FDD4A1B26FA1DBC46
      FF7FFD52B9199E6FDE7B5D630000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000007906DF6B
      3E4BDF6B6F010000000000000000000000000000000000000000000000000000
      000000006F01DF6B3E4BDF6B7906000000000000000000000000000000009E73
      FF7F5E5B1D4FFF7FFF7B3D5B3D57FF7BFF7F5B32DC4AFF7F7D6B000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007906DF6BDF6B6F0100000000000000000000
      00000000000000000000000000000000000000006F01DF6BDF6B790600000000
      00000000000000000000000000005D67DF77FF7F5E573E57BF73FF7BFF7B9F6F
      DD46FD4EFF7FBE777D6B00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      7906DF6B6F010000000000000000000000000000000000000000000000000000
      000000006F01DF6B790600000000000000000000000000000000000000000000
      5D67DF77FF7FBF6F5E5B5E573D573D579E6BFF7FBE773D630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000079066F0100000000000000000000
      00000000000000000000000000000000000000006F0179060000000000000000
      0000000000000000000000000000000000005D67BE73DF7BFF7FFF7FFF7FFF7F
      DF7B9E739E730000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005D675D677D675D675D675D670000000000000000000000000000
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
