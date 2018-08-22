object FrmLogsDetail: TFrmLogsDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Detalhes do Log'
  ClientHeight = 462
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    594
    462)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 11
    Width = 58
    Height = 13
    Caption = 'Data e Hora'
  end
  object Label2: TLabel
    Left = 235
    Top = 11
    Width = 39
    Height = 13
    Caption = 'Gerador'
  end
  object Label5: TLabel
    Left = 4
    Top = 60
    Width = 20
    Height = 13
    Caption = 'Tipo'
  end
  object Label3: TLabel
    Left = 4
    Top = 115
    Width = 55
    Height = 13
    Caption = 'Informa'#231#227'o'
  end
  object Label4: TLabel
    Left = 4
    Top = 245
    Width = 42
    Height = 13
    Caption = 'Detalhes'
  end
  object SpeedButton1: TSpeedButton
    Left = 516
    Top = 65
    Width = 33
    Height = 33
    Action = ActPrior
    Anchors = [akTop, akRight]
  end
  object SpeedButton2: TSpeedButton
    Left = 555
    Top = 65
    Width = 33
    Height = 33
    Action = ActNext
    Anchors = [akTop, akRight]
  end
  object EdtDateTime: TEdit
    Left = 4
    Top = 28
    Width = 225
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object EdtGenerator: TEdit
    Left = 235
    Top = 28
    Width = 349
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object EdtType: TEdit
    Left = 4
    Top = 77
    Width = 225
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object MmoDetails: TMemo
    Left = 4
    Top = 264
    Width = 584
    Height = 193
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object MmoInfo: TMemo
    Left = 4
    Top = 131
    Width = 584
    Height = 102
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object ImageList1: TImageList
    Height = 18
    Width = 18
    Left = 480
    Top = 296
    Bitmap = {
      494C010107006000A40012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000480000002400000001002000000000008028
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
      0000000000000000000000000000000000009C6363006B313100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7B59400944A21000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000944A2100E7B5940000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C6363009C636300BD636300BD6B6B006B313100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEB59400A5523100A55221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5522100A5523100DEB59400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      63009C636300C66B6B00D66B6B00D66B6B00C66B6B006B3131009C6363009C63
      63009C6363009C6363009C6363009C6363000000000000000000000000000000
      0000DEAD8C00A5523100C66B4200B55A3100A5522100A54A2100944A2100D684
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D684
      6300944A2100A54A2100A5522100B55A3100C66B4200A5523100DEAD8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300DE737300D6737300D66B7300D66B6B00C66B6B006B313100FFA5A500FFAD
      B500FFBDBD00FFC6C600FFC6C6009C636300000000000000000000000000DEAD
      8400A55A3100C6734200D67B5200E7845200F78C5200F7946300FFB59400D68C
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D68C
      6300FFB59400F7946300F78C5200E7845200D67B5200C6734200A55A3100DEAD
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300E7737B00DE737300DE737300DE737300CE6B73006B31310039C6630021CE
      630029CE630018CE5A00FFC6C6009C636300000000000000000000000000B55A
      3100C6734200E77B5200E78C5200F7946300FF946300FFAD8400FFBD9400E794
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E794
      7300FFBD9400FFAD8400FF946300F7946300E78C5200E77B5200C6734200B55A
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300E77B7B00E77B7B00DE7B7B00DE737B00D67373006B31310042C66B0031CE
      630031CE630021CE6300FFC6C6009C636300000000000000000000000000E7B5
      9400B55A3100E7845200FFA57300FFAD8400FFB58400FFC6A500FFC6A500E79C
      73005A2929005A2929005A2929005A2929005A29290063313100000000000000
      000000000000633131005A2929005A2929005A2929005A2929005A292900E79C
      7300FFC6A500FFC6A500FFB58400FFAD8400FFA57300E7845200B55A3100E7B5
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300EF848400E77B8400E77B7B00E7848400D67373006B31310039C6630029CE
      630029CE630021CE5A00FFC6C6009C6363000000000000000000000000000000
      00005A292900B55A3100F79C7300E7947300D68C6300E7947300E79C7300F7A5
      7300DECEC600DECEC600DECEC600DECEC600E7DED6005A292900000000000000
      0000000000005A292900E7DED600DECEC600DECEC600DECEC600DECEC600F7A5
      7300E79C7300E7947300D68C6300E7947300F79C7300B55A3100734A31000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300F7848C00EF848400EF949400FFDEDE00DE8C8C006B313100BDE7AD006BDE
      8C005AD6840042D67300FFC6C6009C6363000000000000000000000000000000
      00005A292900EFE7D600C67B5200E79C7300EFE7D600EFE7D600EFE7D600EFE7
      D600EFE7D600EFE7D600EFE7D600EFE7D600FFFFEF0063313100000000000000
      00000000000063313100FFFFEF00EFE7D600EFE7D600EFE7D600EFE7D600EFE7
      D600F7E7D600EFE7D600EFE7D600E79C7300C67B5200F7DED600634A31000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300F78C8C00EF848400F79C9C00FFDEDE00DE8C8C006B313100FFF7DE00FFFF
      E700FFFFDE00EFFFD600FFC6C6009C6363000000000000000000000000000000
      00005A292900DECEC600F7EFE700F7A57300F7EFE700F7EFE700F7EFE700F7EF
      E700F7EFE700F7EFE700F7EFE700FFFFF700FFFFF7006B423900000000000000
      0000000000006B423900FFFFF700FFFFF700F7EFE700F7EFE700F7EFE700F7EF
      E700F7EFE700F7EFE700F7EFE700F7A57300FFF7F700F7EFE700634A31000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300FF949400F78C8C00F78C8C00F78C8C00DE7B84006B313100FFF7D600FFFF
      DE00FFFFDE00FFFFE700FFC6C6009C6363000000000000000000000000000000
      00005A292900DECEC600529C520063A5630073AD7300D6840000D6840000D684
      0000D6840000D6840000EFCE8400FFFFF700FFFFF70073524A00000000000000
      00000000000073524A00FFFFF700FFFFF700EFCE8400D6840000D6840000D684
      0000D6840000D684000073AD730063A56300529C5200DECEC6005A2929000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300FF949C00FF949400FF949400FF949400E78484006B313100FFF7D600FFFF
      DE00FFFFDE00FFFFDE00FFC6C6009C6363000000000000000000000000000000
      00005A292900F7E7BD00E7DED600EFEFE700F7F7DE00F7DEB500F7E7BD00F7E7
      BD00F7DEB500F7E7BD00FFFFEF00FFFFF700FFFFF70084525200000000000000
      00000000000084525200FFFFF700FFFFF700FFFFEF00F7E7BD00F7DEB500F7E7
      BD00F7E7BD00F7DEB500F7F7DE00EFEFE700E7DED600DECEC6005A2929000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300FF9C9C00FF949C00FF949400FF949C00E78C8C006B313100FFF7D600FFFF
      DE00FFFFDE00FFFFDE00FFC6C6009C6363000000000000000000000000000000
      00005A292900E7D6CE00EFE7D600EFDEB500F7DEB500F7DEB500F7DEB500F7DE
      B500F7DEB500F7DEB500F7DEB500F7F7DE00FFFFF70084525200000000000000
      00000000000084525200FFFFF700F7F7DE00F7DEB500F7DEB500F7DEB500F7DE
      B500F7DEB500F7DEB500F7DEB500EFDEB500EFE7D600E7D6CE005A2929000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      6300FF9CA500FF9C9C00FF9C9C00FF9C9C00E78C8C006B313100FFF7D600FFFF
      DE00FFFFDE00FFFFDE00FFC6C6009C6363000000000000000000000000000000
      00005A292900EFE7D600FFFFF700D6731000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000D6731000FFFFF7008C635A00000000000000
      0000000000008C635A00FFFFF700D6731000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000D6731000FFFFF700EFE7D6005A2929000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C63
      63009C636300EF8C8C00FF9C9C00FF9C9C00EF8C94006B313100FFF7D600FFFF
      DE00FFFFDE00FFFFDE00FFC6C6009C6363000000000000000000000000000000
      00005A292900FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFFF00FFFFFF00FFFFFF00946B6300000000000000
      000000000000946B6300FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF700FFFFF7005A2929000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C636300B5737300D6848400DE8C8C006B3131009C6363009C63
      63009C6363009C6363009C6363009C6363000000000000000000000000000000
      00005A292900DECEC600DED6CE00DED6D600E7DED600E7DED600E7DED600E7DE
      D600E7DED600E7DED600E7DED600E7DED600E7DED60094736300000000000000
      00000000000094736300E7DED600E7DED600E7DED600E7DED600E7DED600E7DE
      D600E7DED600E7DED600E7DED600DED6D600DED6CE00DECEC6005A2929000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C6363009C6363006B313100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000734A420073524A008C635A00946B63009473630094737300947373009473
      7300947373009473730094737300947373009473730094737300000000000000
      0000000000009473730094737300947373009473730094737300947373009473
      7300947373009473730094736300946B63008C635A0073524A00734A42000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEBDAD00CEB5AD00C6ADA500D6B5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007C7A760058696B00186A7C004BB5C6005BC4D400A9B3B5003A3D72006666
      6600545455006666660066666600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7BDAD00DECECE00C6CECE00B5B5B500B5A59C00E7BD
      AD00000000000000000000000000000000000000000000000000000000009795
      9100827F7A005C6F710016798E0058D7E9006FE4F5005EA8EA002032C7002A2D
      8600504F50005D5D5D0066666600909090000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002D7310002D7310002D7310002B6E0F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7C6AD00EFDEDE00E7E7EF00D6A59400C69C8C00B5ADB500B5A5
      9C00D6B5A500000000000000000000000000000000000000000000000000908D
      8600797770005653520055686A0028899C0072DCEC008AEAF7005280E3002032
      C70021247E0047464800636363006E6E6E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000317C11004B922E0047872C00437C2B00317C11002B6E0F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7BDAD00EFE7E700F7FFFF00D6947B00BD390800BD390800C67B6300B5B5
      B500B5A59C00E7BDAD0000000000000000000000000000000000000000008B87
      800076736E004B4A4800615F5D00566667002E7C8C008CE2EE00A4F0F9005C82
      E4002032C7001D20790058585900666666000000000000000000000000000000
      000000000000B0A0900060483000604830006048300060483000604830006048
      300041A5170053A63100CFE0CF00C4E0C40047872C00437C2B00317C11002B6E
      0F00000000000000000000000000000000000000000000000000DE9C7600B060
      4000B0603000A0503000A0482000904010009038100080300000803000008030
      000000000000000000000000000000000000000000000000000000000000E7BD
      AD00F7EFE700FFFFFF00DE9C8400C65A2900E7B59C00E7B59C00CE5A2900C67B
      5A00B5B5B500B5A59C00D6B5A500000000000000000000000000000000007F7C
      76006B6964008A867F007B78720057524C00485151003C7C8900A5E7F000BFF5
      FC006684E4002032C70026298200666666000000000000000000000000000000
      000000000000B0A09000E0C8C000D0C0B000D0B8B000D0B8B000C0B0A000C0B0
      A0004CC11B0058B13200E0E0E000E0E0E000C4E0C40047872C00437C2B002D73
      1000000000000000000000000000000000000000000000000000E0987000F0C0
      A000D0A08000D0907000C0806000B0685000A0604000A0604000A05830008030
      0000000000000000000000000000000000000000000000000000E7BDAD00F7EF
      E700FFFFFF00DEA58C00BD421000BD522100FFEFE700F7EFE700BD522100BD42
      1000C67B5A00B5B5B500B5A59C00E7BDAD00000000000000000000000000B8B6
      B2006E6B67008B8780008A867F00525453009BA7B20097AFC10052A2AE00BFED
      F200D9FBFE006D86E5002032C7001A3591008FC4CE00D4DDE000000000000000
      000000000000B0A09000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0
      E00060C635005AB83300E0E0E00053A63100E0E0E000C4E0C40047872C00368A
      1300000000000000000000000000000000000000000000000000E0987000FFC8
      B000F0B89000F0A08000E0987000E0886000D0785000D0785000B06840008030
      00000000000000000000000000000000000000000000E7BDAD00F7EFE700FFFF
      FF00EFBD9C00C6522100C64A1800C6521800F7E7DE00F7DED600BD4A1800BD4A
      1800BD421000C67B5A00B5ADB500AD9C9C00D6B5A50000000000000000000000
      0000DFDFDE00AEACAA00A19E990079888E007F8D9500A6B1BF0096B4BF006EA3
      AC00D5F2F400E0FDFF005E83E4002032C700686995009FD7E200CDDFE6000000
      000000000000B0A09000FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFF
      FF0067C93E0060C635002CDF2C0058B1320053A63100CFE0CF00CFE0CF00368A
      1300000000000000000000000000000000000000000000000000E0987000FFC8
      B000F0B89000F0A08000E0987000E0886000D0785000D0785000B06840008030
      10000000000000000000000000000000000000000000E7CEBD00FFFFFF00F7E7
      D600D67B3900CE6B3900CE633100C65A2900F7E7DE00F7DED600BD4A1800BD4A
      1800BD4A1800BD421000C6948400B5B5B500C6ADA50000000000000000000000
      000000000000E5E5E500D2D2D20086949C00BEC4D500AEB5C600B7C1D3009FB3
      BE0060ABB800A9E8F10077E6F600CFD0D200E9E9EE006869950085B0BB000000
      000000000000B0A09000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0
      E000FFFFFF0067C93E0060C635005AB8330058B1320053A6310041A517000000
      0000000000000000000000000000000000000000000000000000F0A08000FFD0
      C000FFC0A000F0B09000F0A08000E0907000E090700000009000000090008030
      10000000000000009000000090000000000000000000E7CEBD00FFFFFF00FFE7
      D600DE8C5200DE844A00D67B4200CE6B3900FFEFE700F7E7DE00C6522100BD4A
      1800BD4A1800BD421000D6AD9C00CECECE00CEB5AD0000000000000000000000
      00000000000000000000E1E2E400BFC3CE00CFD4E000CAD0DD00B2B9C800B8C1
      D50027A1B7005AC7D7007EDEED00A3EFF9009DC1C700949AE2002F4AAA000000
      000000000000C0A89000FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFF
      FF00FFF0E000FFFFFF0067C93E0060C635005AB8330058B13200604830000000
      0000000000000000000000000000000000000000000000000000F0A08000FFD8
      D000FFC8B000F0B8A000F0A89000F0A0800000009000507EFE000421A5000000
      900000009000072DC200072DC200071D820000000000E7BDAD00F7EFE700FFFF
      FF00F7D6BD00DE945200DE8C4A00DE946300F7DECE00EFCEB500CE632900C652
      1800BD421000D69C8400E7EFEF00DECEC600DEBDAD0000000000000000000000
      00000000000000000000E5E8EE00DCDFE700CACDD300D5D9E300CAD0DD00AFB6
      C6002CA2B7006DDCEB007FCFDA007BC8D50000667E00749DDD005873C2000000
      000000000000C0A8A000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0
      E000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFFFF00C0A8A000604830000000
      0000000000000000000000000000000000000000000000000000F0A88000FFE0
      D000FFD0C000FFC0A000F0B09000F0A88000000090004A67D7003863F6000421
      A5000421A500093CFC000421A500000090000000000000000000E7BDAD00F7E7
      DE00FFFFFF00F7DEC600E7A56300DE945A00E7A57300DE946300CE6B3100CE63
      2900E7AD9400F7FFFF00E7DED600E7BDAD000000000000000000000000000000
      00000000000000000000E8EAF100F3F4F700E8E9EC00CACDD400D0D5E000C3C9
      DA00358498007ADDEC0097E4EF00A5D8DE004D96A7008ACDDA0096C0CC000000
      000000000000C0B0A000FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFF
      FF00FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0E000C0B0A000604830000000
      0000000000000000000000000000000000000000000000000000F0B08000FFE8
      E000FFD8D000FFC8B000FFC0B000F0B8A000EA9C8800071D82004A67D7003863
      F600093CFC000421A5000000900000000000000000000000000000000000E7BD
      AD00F7E7DE00FFFFFF00FFE7C600E7AD6300FFEFE700FFE7DE00D67B4200EFB5
      9C00FFFFFF00EFE7E700E7BDAD00000000000000000000000000000000000000
      00000000000000000000C1C2C500F5F6F800F4F5F700DDE0E700C0C3CE00C3CA
      DA008F9AA9004994A50085CAD600C1EEF300B4D2D60076ACB900D5E4E8000000
      000000000000D0B0A000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0
      E000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFFFF00C0B0A000604830000000
      0000000000000000000000000000000000000000000000000000FFB09000FFE0
      D000FFE0D000FFD8C000FFD0C000FFC8B000EBBBB600071D82004A67D7007396
      FF003863F6000421A50000009000000000000000000000000000000000000000
      0000E7BDAD00F7E7DE00FFFFFF00FFE7CE00F7D6A500EFC69400F7CEAD00FFFF
      FF00F7EFE700E7BDAD0000000000000000000000000000000000000000000000
      0000000000000000000065605D00E0E1E700E9EBF200E1E4EE00CCD2DE00A9AF
      BD00595655000000000090A5AB007AADB700A1C3C800C7CCCE00000000000000
      000000000000D0B8A000FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0E000FFFF
      FF00FFF0E000FFFFFF00FFF0E000FFFFFF00FFF0E000D0B8B000604830000000
      0000000000000000000000000000000000000000000000000000FFB09000FFB0
      9000F0B08000F0A88000F0A08000F0A08000000090004A67D700507EFE004A67
      D7004A67D7003863F6000421A500000090000000000000000000000000000000
      000000000000E7BDA500F7E7DE00FFFFFF00FFEFDE00FFE7D600FFFFFF00F7EF
      E700E7BDAD000000000000000000000000000000000000000000000000000000
      0000000000000000000047413B00635F5C00AEAFB500B3B5BE00A4A7B0005B57
      560038332E000000000000000000000000000000000000000000000000000000
      000000000000F0A89000F0A89000F0A89000F0A88000F0A08000E0987000E090
      6000E0885000E0805000E0784000E0704000E0704000E0704000D06030000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000090007396FF004A67D7000000
      9000000090004A67D7003863F600000090000000000000000000000000000000
      00000000000000000000E7BDAD00F7E7DE00FFFFFF00FFFFFF00F7EFE700E7BD
      AD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000908D8A0047413B0047413B0047413B0047413B004741
      3B00888581000000000000000000000000000000000000000000000000000000
      000000000000F0A89000FFC0A000FFC0A000FFC0A000FFB89000FFB89000FFB0
      9000FFA88000FFA88000F0A07000F0A07000F0987000F0986000D06830000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001784AD0000009000000090000000
      0000000000000000900000009000000000000000000000000000000000000000
      0000000000000000000000000000E7BDAD00E7CEBD00E7CEBD00E7BDAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000908D8A0047413B0047413B0047413B00908D
      8A00000000000000000000000000000000000000000000000000000000000000
      000000000000F0A89000F0A89000F0A89000F0A89000F0A88000F0A08000F098
      7000E0987000E0906000E0886000E0805000E0784000E0784000E07040000000
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
      2800000048000000240000000100010000000000B00100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFC0000000000FF3FFCFF
      FFFE7C0000000000F83FF8FFFFFE3C0000000000E000F00FFFE01C0000000000
      E000E00FFFE00C0000000000E000E00FFFE00C0000000000E000E00038000C00
      00000000E000F00038001C0000000000E000F00038001C0000000000E000F000
      38001C0000000000E000F00038001C0000000000E000F00038001C0000000000
      E000F00038001C0000000000E000F00038001C0000000000E000F00038001C00
      00000000F800F00038001C0000000000FE3FF00038001C0000000000FFFFFFFF
      FFFFFC0000000000FFFFFFFFFFFFFFFFFF000000FE1FF001FFFFFFFFFF000000
      FC0FE000FFFC3FFFFF000000F807E000FFF81FFFFF000000F003E000F8000FC0
      0F000000E001E000F8000FC00F000000C000E00038000FC00F00000080007000
      18000FC00F0000008000780018001FC00900000080007C0018001FC000000000
      80007C0018001FC000000000C000FC0018001FC001000000E001FC0018001FC0
      01000000F003FC0438001FC000000000F807FC07F8001FFF00000000FC0FFC07
      F8001FFF19000000FE1FFE0FF8001FFFFF000000FFFFFFFFFFFFFFFFFF000000
      00000000000000000000000000000000000000000000}
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 480
    Top = 248
    object ActPrior: TAction
      ImageIndex = 5
      OnExecute = ActPriorExecute
    end
    object ActNext: TAction
      ImageIndex = 6
      OnExecute = ActNextExecute
    end
  end
end