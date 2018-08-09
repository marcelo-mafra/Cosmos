inherited DMCon: TDMCon
  OldCreateOrder = True
  Height = 464
  Width = 575
  object CdsSearch: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspSearch'
    Left = 440
    Top = 200
  end
  object DsrSearch: TDataSource
    DataSet = CdsSearch
    Left = 480
    Top = 200
  end
  object CdsBufferedFocus: TClientDataSet
    Aggregates = <>
    FileName = 
      'D:\Pastas Pessoais\Marcelo\LECTORIUM\Projeto Cosmos\Fontes\Buffe' +
      'redData\focos.buf'
    FieldDefs = <
      item
        Name = 'CODFOC'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'SIGFOC'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'NOMFOC'
        Attributes = [faRequired]
        DataType = ftString
        Size = 70
      end
      item
        Name = 'NOMTEM'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'CODREG'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'FOCPAI'
        DataType = ftInteger
      end
      item
        Name = 'TIPFOC'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'INDLEC'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDTPU'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDTMO'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDTMB'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDIND'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDATI'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDNAC'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDCAB'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    IndexFieldNames = 'NOMFOC'
    Params = <>
    StoreDefs = True
    Left = 440
    Top = 16
  end
  object DsrBufferedFocus: TDataSource
    DataSet = CdsBufferedFocus
    Left = 480
    Top = 16
  end
  object CdsBufferedMentors: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 440
    Top = 80
  end
  object DsrBufferedMentors: TDataSource
    DataSet = CdsBufferedMentors
    Left = 480
    Top = 80
  end
  object CdsBufferedEnderecosFocos: TClientDataSet
    Aggregates = <>
    FileName = 
      'D:\Pastas Pessoais\Marcelo\LECTORIUM\Projeto Cosmos\Fontes\Buffe' +
      'redData\VIW_ENDERECOS_FOCOS.buf'
    Params = <>
    Left = 440
    Top = 144
  end
  object DsrBufferedEnderecosFocos: TDataSource
    DataSet = CdsBufferedEnderecosFocos
    Left = 480
    Top = 144
  end
  object CdsFicha: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 152
  end
  object CdsDirigentesAtuais: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'codorg'
        ParamType = ptInput
        Value = 12
      end>
    ProviderName = 'DspDirigentesAtuais'
    Left = 312
    Top = 208
  end
  object CdsBufferedDirecoes: TClientDataSet
    Aggregates = <>
    FileName = 
      'D:\Pastas Pessoais\Marcelo\LECTORIUM\Projeto Cosmos\Fontes\Buffe' +
      'redData\direcoes.buf'
    Params = <
      item
        DataType = ftInteger
        Name = 'codorg'
        ParamType = ptInput
        Value = 1
      end>
    Left = 312
    Top = 264
  end
  object DsrBufferedDirecoes: TDataSource
    DataSet = CdsBufferedDirecoes
    Left = 344
    Top = 264
  end
  object DsrDirigentesAtuais: TDataSource
    DataSet = CdsDirigentesAtuais
    Left = 344
    Top = 208
  end
end
