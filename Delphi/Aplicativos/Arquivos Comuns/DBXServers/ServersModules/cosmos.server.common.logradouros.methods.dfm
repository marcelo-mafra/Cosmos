object DMCosmosServerLogradouros: TDMCosmosServerLogradouros
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 537
  Width = 580
  object DspSearchLogradouros: TDataSetProvider
    DataSet = SQLSearchLogradouros
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetTableName = DspSearchLogradourosGetTableName
    Left = 88
    Top = 24
  end
  object SQLSearchLogradouros: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 
      'select * from viw_logradouros where ceplog = :ceplog'#13#10'order by n' +
      'omlog'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'ceplog'
        ParamType = ptInput
        Size = 9
        Value = ''
      end>
    Left = 56
    Top = 24
    object SQLSearchLogradourosCODLOG: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODLOG'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLSearchLogradourosNOMLOG: TStringField
      DisplayLabel = 'Logradouro'
      DisplayWidth = 30
      FieldName = 'NOMLOG'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object SQLSearchLogradourosCEPLOG: TStringField
      DisplayLabel = 'Cep'
      FieldName = 'CEPLOG'
      ProviderFlags = [pfInUpdate]
      EditMask = '99999-999;1;_'
      FixedChar = True
      Size = 9
    end
    object SQLSearchLogradourosCODBAI: TIntegerField
      FieldName = 'CODBAI'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLSearchLogradourosNOMBAI: TStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 30
      FieldName = 'NOMBAI'
      ProviderFlags = []
      Size = 50
    end
    object SQLSearchLogradourosCODCID: TIntegerField
      FieldName = 'CODCID'
      ProviderFlags = []
      Visible = False
    end
    object SQLSearchLogradourosNOMCID: TStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 30
      FieldName = 'NOMCID'
      ProviderFlags = []
      Size = 50
    end
    object SQLSearchLogradourosNOMEST: TStringField
      DisplayLabel = 'Estado'
      DisplayWidth = 20
      FieldName = 'NOMEST'
      ProviderFlags = []
      Visible = False
      Size = 35
    end
    object SQLSearchLogradourosSIGEST: TStringField
      FieldName = 'SIGEST'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 2
    end
    object SQLSearchLogradourosNOMPAI: TStringField
      DisplayLabel = 'Pa'#237's'
      DisplayWidth = 20
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Size = 35
    end
  end
  object DspPaises: TDataSetProvider
    DataSet = SQLPaises
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetDataSetProperties = DspPaisesGetDataSetProperties
    Left = 88
    Top = 88
  end
  object SQLPaises: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 'select * from PAISES order by nompai'
    MaxBlobSize = -1
    Params = <>
    Left = 56
    Top = 88
    object SQLPaisesCODPAI: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODPAI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLPaisesNOMPAI: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'NOMPAI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 35
    end
  end
  object SQLEstados: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 
      'select est.*, pai.nompai from ESTADOS est'#13#10'inner join paises pai' +
      ' on (pai.codpai = est.codpai)'#13#10'where est.codpai = :codpai'#13#10'order' +
      ' by nomest'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codpai'
        ParamType = ptInput
        Value = 0
      end>
    Left = 56
    Top = 152
    object SQLEstadosCODEST: TIntegerField
      FieldName = 'CODEST'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLEstadosCODPAI: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODPAI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLEstadosNOMPAI: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Visible = False
      Size = 35
    end
    object SQLEstadosNOMEST: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'NOMEST'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 35
    end
    object SQLEstadosSIGEST: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGEST'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 2
    end
  end
  object DspEstados: TDataSetProvider
    DataSet = SQLEstados
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetDataSetProperties = DspEstadosGetDataSetProperties
    Left = 88
    Top = 152
  end
  object SQLCidades: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 'select * from cidades where codest = :codest'#13#10'order by nomcid'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codest'
        ParamType = ptInput
        Value = 0
      end>
    Left = 56
    Top = 216
    object SQLCidadesCODCID: TIntegerField
      FieldName = 'CODCID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLCidadesNOMCID: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'NOMCID'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object SQLCidadesCODEST: TIntegerField
      FieldName = 'CODEST'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
  end
  object DspCidades: TDataSetProvider
    DataSet = SQLCidades
    Options = [poIncFieldProps, poDisableDeletes, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetDataSetProperties = DspCidadesGetDataSetProperties
    Left = 88
    Top = 216
  end
  object DspBairros: TDataSetProvider
    DataSet = SQLBairros
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetTableName = DspBairrosGetTableName
    OnGetDataSetProperties = DspBairrosGetDataSetProperties
    Left = 88
    Top = 280
  end
  object SQLBairros: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 'select * from viw_bairros where codcid = :codcid'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcid'
        ParamType = ptInput
        Value = 0
      end>
    Left = 56
    Top = 280
    object SQLBairrosCODBAI: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODBAI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLBairrosNOMBAI: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'NOMBAI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object SQLBairrosCODCID: TIntegerField
      DisplayLabel = 'Cidade'
      FieldName = 'CODCID'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLBairrosNOMCID: TStringField
      FieldName = 'NOMCID'
      ProviderFlags = []
      Visible = False
      Size = 50
    end
    object SQLBairrosCODEST: TIntegerField
      FieldName = 'CODEST'
      ProviderFlags = []
      Visible = False
    end
    object SQLBairrosNOMEST: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'NOMEST'
      ProviderFlags = []
      Visible = False
      Size = 35
    end
    object SQLBairrosSIGEST: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'SIGEST'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 2
    end
    object SQLBairrosCODPAI: TIntegerField
      FieldName = 'CODPAI'
      ProviderFlags = []
      Visible = False
    end
    object SQLBairrosNOMPAI: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Visible = False
      Size = 35
    end
  end
  object DspLogradouros: TDataSetProvider
    DataSet = SQLLogradouros
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetTableName = DspSearchLogradourosGetTableName
    OnGetDataSetProperties = DspLogradourosGetDataSetProperties
    Left = 256
    Top = 24
  end
  object SQLLogradouros: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 'select * from viw_logradouros where codlog = :codlog'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codlog'
        ParamType = ptInput
        Value = 0
      end>
    Left = 224
    Top = 24
    object SQLLogradourosCODLOG: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODLOG'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLLOgradourosNOMLOG: TStringField
      DisplayLabel = 'Logradouro'
      DisplayWidth = 30
      FieldName = 'NOMLOG'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object SQLLogradourosCEPLOG: TStringField
      DisplayLabel = 'Cep'
      FieldName = 'CEPLOG'
      ProviderFlags = [pfInUpdate]
      EditMask = '99999-999;1;_'
      FixedChar = True
      Size = 9
    end
    object SQLLogradourosCODBAI: TIntegerField
      FieldName = 'CODBAI'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLLogradourosNOMBAI: TStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 30
      FieldName = 'NOMBAI'
      ProviderFlags = []
      Size = 50
    end
    object SQLLogradourosCODCID: TIntegerField
      FieldName = 'CODCID'
      ProviderFlags = []
      Visible = False
    end
    object SQLLogradourosNOMCID: TStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 30
      FieldName = 'NOMCID'
      ProviderFlags = []
      Size = 50
    end
    object SQLLogradourosNOMEST: TStringField
      DisplayLabel = 'Estado'
      DisplayWidth = 20
      FieldName = 'NOMEST'
      ProviderFlags = []
      Visible = False
      Size = 35
    end
    object SQLLogradourosSIGEST: TStringField
      FieldName = 'SIGEST'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 2
    end
    object SQLLogradourosNOMPAI: TStringField
      DisplayLabel = 'Pa'#237's'
      DisplayWidth = 20
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Size = 35
    end
  end
  object DspEndereco: TDataSetProvider
    DataSet = SQLEnderecoCadastrado
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetTableName = DspEnderecoGetTableName
    OnGetDataSetProperties = DspEnderecoGetDataSetProperties
    Left = 256
    Top = 80
  end
  object SQLEnderecoCadastrado: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 
      'select edr.codend, edr.codcad, edr.codlog, log.nomlog, edr.numen' +
      'd, edr.comend, log.ceplog,'#13#10'log.codbai, bai.nombai, bai.codcid, ' +
      'cid.nomcid, est.nomest, est.sigest, pai.codpai,'#13#10'pai.nompai, edr' +
      '.indcor, edr.tipend, edr.datcad, edr.usures'#13#10'from enderecos edr'#13 +
      #10'inner join logradouros log on (log.codlog = edr.codlog)'#13#10'inner ' +
      'join bairros bai on (bai.codbai = log.codbai)'#13#10'inner join cidade' +
      's cid on (cid.codcid = bai.codcid)'#13#10'inner join estados est on (e' +
      'st.codest = cid.codest)'#13#10'inner join paises pai on (pai.codpai = ' +
      'est.codpai)'#13#10'and edr.codcad = :codcad'#13#10#13#10'PLAN JOIN (EDR INDEX (F' +
      'K_ENDERECOS_CADASTRADOS), LOG INDEX (PK_LOGRADOUROS),'#13#10'BAI INDEX' +
      ' (PK_BAIRROS), CID INDEX (PK_CIDADES), EST INDEX (PK_ESTADOS),'#13#10 +
      'PAI INDEX(PK_PAISES))'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 224
    Top = 80
    object SQLEnderecoCadastradoCODEND: TIntegerField
      FieldName = 'CODEND'
      ProviderFlags = [pfInUpdate, pfInKey]
    end
    object SQLEnderecoCadastradoCODCAD: TIntegerField
      FieldName = 'CODCAD'
    end
    object SQLEnderecoCadastradoCODLOG: TIntegerField
      FieldName = 'CODLOG'
      ProviderFlags = [pfInUpdate]
    end
    object SQLEnderecoCadastradoNOMLOG: TStringField
      DisplayLabel = 'Logradouro'
      DisplayWidth = 30
      FieldName = 'NOMLOG'
      ProviderFlags = []
      Size = 50
    end
    object SQLEnderecoCadastradoNUMEND: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMEND'
      ProviderFlags = [pfInUpdate]
    end
    object SQLEnderecoCadastradoCOMEND: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMEND'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object SQLEnderecoCadastradoCEPLOG: TStringField
      DisplayLabel = 'Cep'
      FieldName = 'CEPLOG'
      ProviderFlags = []
      EditMask = '99999-999;1;_'
      FixedChar = True
      Size = 9
    end
    object SQLEnderecoCadastradoCODBAI: TIntegerField
      FieldName = 'CODBAI'
      ProviderFlags = []
    end
    object SQLEnderecoCadastradoNOMBAI: TStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 30
      FieldName = 'NOMBAI'
      ProviderFlags = []
      Size = 50
    end
    object SQLEnderecoCadastradoCODCID: TIntegerField
      FieldName = 'CODCID'
      ProviderFlags = []
    end
    object SQLEnderecoCadastradoNOMCID: TStringField
      DisplayWidth = 30
      FieldName = 'NOMCID'
      ProviderFlags = []
      Size = 50
    end
    object SQLEnderecoCadastradoNOMEST: TStringField
      DisplayWidth = 20
      FieldName = 'NOMEST'
      ProviderFlags = []
      Size = 35
    end
    object SQLEnderecoCadastradoSIGEST: TStringField
      FieldName = 'SIGEST'
      ProviderFlags = []
      FixedChar = True
      Size = 2
    end
    object SQLEnderecoCadastradoCODPAI: TIntegerField
      FieldName = 'CODPAI'
      ProviderFlags = []
    end
    object SQLEnderecoCadastradoNOMPAI: TStringField
      DisplayWidth = 20
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Size = 35
    end
    object SQLEnderecoCadastradoINDCOR: TStringField
      FieldName = 'INDCOR'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLEnderecoCadastradoTIPEND: TStringField
      FieldName = 'TIPEND'
      FixedChar = True
      Size = 1
    end
    object SQLEnderecoCadastradoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLEnderecoCadastradoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
  end
  object DspMeiosContatos: TDataSetProvider
    DataSet = SQLMeiosContatos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchLogradourosUpdateError
    OnGetTableName = DspMeiosContatosGetTableName
    OnGetDataSetProperties = DspMeiosContatosGetDataSetProperties
    Left = 256
    Top = 152
  end
  object SQLMeiosContatos: TSQLDataSet
    BeforeOpen = SQLSearchLogradourosBeforeOpen
    CommandText = 
      'select mcon.codcon, mcon.descon, mcon.codtipcon, tc.destipcon, m' +
      'con.codcad, mcon.indcar, mcon.datcad, mcon.usures'#13#10'from meios_co' +
      'ntatos mcon'#13#10'inner join tipos_contatos tc on (tc.codtipcon = mco' +
      'n.codtipcon)'#13#10'where mcon.codfoc is null and mcon.codcad = :codca' +
      'd'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 224
    Top = 152
    object SQLMeiosContatosCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLMeiosContatosDESCON: TStringField
      DisplayLabel = 'Meios de Contato'
      FieldName = 'DESCON'
      Required = True
      Size = 50
    end
    object SQLMeiosContatosCODTIPCON: TIntegerField
      FieldName = 'CODTIPCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLMeiosContatosDESTIPCON: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'DESTIPCON'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLMeiosContatosCODCAD: TIntegerField
      FieldName = 'CODCAD'
    end
    object SQLMeiosContatosINDCAR: TStringField
      FieldName = 'INDCAR'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMeiosContatosDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLMeiosContatosUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
  end
end
