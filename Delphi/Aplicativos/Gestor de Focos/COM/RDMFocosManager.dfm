object FocosManager: TFocosManager
  OldCreateOrder = False
  OnCreate = RemoteDataModuleCreate
  OnDestroy = RemoteDataModuleDestroy
  Height = 506
  Width = 673
  object SQLCon: TSQLConnection
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'drivername=FIREBIRD'
      'blobsize=-1'
      'commitretain=False'
      
        'Database=localhost:D:\Marcelo\Projeto Cosmos\Banco de dados\COSM' +
        'OSDB.FDB'
      'localecode=0000'
      'password=galaad'
      'Role=RoleName'
      'sqldialect=3'
      'isolationlevel=ReadCommitted'
      'user_name=sysdba'
      'waitonlocks=True'
      'hostname=localhost'
      'servercharset=ISO8859_1')
    VendorLib = 'fbclient.dll'
    AfterConnect = SQLConAfterConnect
    Left = 24
    Top = 8
  end
  object SQLSearch: TSQLDataSet
    AfterOpen = SQLSearchAfterOpen
    CommandText = 'select 1 as "cod" from focos where nomfoc = '#39'N'#250'cleo de Vit'#243'ria'#39
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 24
    Top = 65
  end
  object DspSearch: TDataSetProvider
    DataSet = SQLSearch
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    Left = 56
    Top = 65
  end
  object SQLMonitor: TSQLMonitor
    SQLConnection = SQLCon
    Left = 152
    Top = 8
  end
  object SQLFoco: TSQLDataSet
    CommandText = 
      'select foc.codfoc, foc.nomfoc, foc.sigfoc, foc.nomtem, foc.tipfo' +
      'c, foc.codreg,'#13#10'reg.nomreg, foc.focpai, pai.nomfoc as "nompai", ' +
      'foc.indlec, foc.indtpu, foc.indtmo, foc.indtmb, foc.indein,'#13#10'foc' +
      '.indind, foc.indati, foc.indnac, foc.indcab'#13#10'from focos foc'#13#10'inn' +
      'er join regioes reg on(reg.codreg = foc.codreg)'#13#10'left outer join' +
      ' focos pai on (foc.focpai = pai.codfoc)'#13#10'where foc.codfoc = :cod' +
      'foc'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 24
    Top = 128
    object SQLFocoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInKey]
      Required = True
    end
    object SQLFocoNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLFocoSIGFOC: TStringField
      DisplayWidth = 3
      FieldName = 'SIGFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 4
    end
    object SQLFocoNOMTEM: TStringField
      FieldName = 'NOMTEM'
      ProviderFlags = [pfInUpdate]
      Size = 35
    end
    object SQLFocoTIPFOC: TStringField
      FieldName = 'TIPFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLFocoCODREG: TIntegerField
      FieldName = 'CODREG'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLFocoNOMREG: TStringField
      FieldName = 'NOMREG'
      ProviderFlags = []
      Required = True
      Size = 35
    end
    object SQLFocoFOCPAI: TIntegerField
      FieldName = 'FOCPAI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLFoconompai: TStringField
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Size = 70
    end
    object SQLFocoINDLEC: TStringField
      FieldName = 'INDLEC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDTPU: TStringField
      FieldName = 'INDTPU'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDTMO: TStringField
      FieldName = 'INDTMO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDTMB: TStringField
      FieldName = 'INDTMB'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDEIN: TStringField
      FieldName = 'INDEIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDIND: TStringField
      FieldName = 'INDIND'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDNAC: TStringField
      FieldName = 'INDNAC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDCAB: TStringField
      FieldName = 'INDCAB'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspFoco: TDataSetProvider
    DataSet = SQLFoco
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 56
    Top = 128
  end
  object SQLMeiosContatosFocos: TSQLDataSet
    CommandText = 
      'select mcon.codtipcon, tc.destipcon, mcon.descon, mcon.codfoc, m' +
      'con.codcon,  mcon.indcar, mcon.datcad, mcon.usures'#13#10'from meios_c' +
      'ontatos mcon'#13#10'inner join tipos_contatos tc on (tc.codtipcon = mc' +
      'on.codtipcon)'#13#10'where mcon.codfoc = :codfoc'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 24
    Top = 184
    object SQLMeiosContatosFocosCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInKey]
      Visible = False
    end
    object SQLMeiosContatosFocosCODTIPCON: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'CODTIPCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLMeiosContatosFocosDESTIPCON: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'DESTIPCON'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLMeiosContatosFocosDESCON: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object SQLMeiosContatosFocosCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLMeiosContatosFocosINDCAR: TStringField
      FieldName = 'INDCAR'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMeiosContatosFocosDATCAD: TSQLTimeStampField
      DisplayLabel = 'Data'
      FieldName = 'DATCAD'
      ProviderFlags = []
      ReadOnly = True
    end
    object SQLMeiosContatosFocosUSURES: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USURES'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 31
    end
  end
  object DspMeiosContatos: TDataSetProvider
    DataSet = SQLMeiosContatosFocos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 56
    Top = 184
  end
  object SQLSearchLogradouros: TSQLDataSet
    CommandText = 'select * from viw_logradouros where ceplog = :ceplog'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'ceplog'
        ParamType = ptInput
        Value = ''
      end>
    SQLConnection = SQLCon
    Left = 128
    Top = 240
    object SQLSearchLogradourosCODLOG: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODLOG'
      ProviderFlags = [pfInKey]
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
  object DspSearchLogradouros: TDataSetProvider
    DataSet = SQLSearchLogradouros
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 160
    Top = 240
  end
  object SQLEnderecoFoco: TSQLDataSet
    CommandText = 'select * from viw_enderecos_focos where codfoc = :codfoc'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 128
    Top = 128
    object SQLEnderecoFocoCODEND: TIntegerField
      FieldName = 'CODEND'
      ProviderFlags = [pfInKey]
      Visible = False
    end
    object SQLEnderecoFocoCODLOG: TIntegerField
      FieldName = 'CODLOG'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLEnderecoFocoNOMLOG: TStringField
      DisplayLabel = 'Logradouro'
      DisplayWidth = 30
      FieldName = 'NOMLOG'
      ProviderFlags = []
      Size = 50
    end
    object SQLEnderecoFocoNUMEND: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMEND'
      ProviderFlags = [pfInUpdate]
    end
    object SQLEnderecoFocoCOMEND: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMEND'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 10
    end
    object SQLEnderecoFocoCEPLOG: TStringField
      DisplayLabel = 'CEP'
      FieldName = 'CEPLOG'
      ProviderFlags = []
      EditMask = '99999-999;1;_'
      FixedChar = True
      Size = 9
    end
    object SQLEnderecoFocoCODBAI: TIntegerField
      FieldName = 'CODBAI'
      ProviderFlags = []
      Visible = False
    end
    object SQLEnderecoFocoNOMBAI: TStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 30
      FieldName = 'NOMBAI'
      ProviderFlags = []
      Size = 50
    end
    object SQLEnderecoFocoCODCID: TIntegerField
      FieldName = 'CODCID'
      ProviderFlags = []
      Visible = False
    end
    object SQLEnderecoFocoNOMCID: TStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 30
      FieldName = 'NOMCID'
      ProviderFlags = []
      Size = 50
    end
    object SQLEnderecoFocoNOMEST: TStringField
      DisplayLabel = 'Estado'
      DisplayWidth = 20
      FieldName = 'NOMEST'
      ProviderFlags = []
      Size = 35
    end
    object SQLEnderecoFocoSIGEST: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGEST'
      ProviderFlags = []
      FixedChar = True
      Size = 2
    end
    object SQLEnderecoFocoNOMPAI: TStringField
      DisplayLabel = 'Pa'#237's'
      DisplayWidth = 20
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Size = 35
    end
    object SQLEnderecoFocoINDCOR: TStringField
      DisplayLabel = 'Correspond'#234'ncia'
      FieldName = 'INDCOR'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLEnderecoFocoREFEND: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'REFEND'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLEnderecoFocoACEEND: TStringField
      DisplayLabel = 'Acesso'
      FieldName = 'ACEEND'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLEnderecoFocoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLEnderecoFocoNUMCAI: TSmallintField
      Alignment = taLeftJustify
      DisplayLabel = 'Caixa Postal'
      FieldName = 'NUMCAI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLEnderecoFocoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
      Visible = False
    end
    object SQLEnderecoFocoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 31
    end
  end
  object DspEndereco: TDataSetProvider
    DataSet = SQLEnderecoFoco
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspEnderecoGetTableName
    Left = 160
    Top = 128
  end
  object SQLLogradouros: TSQLDataSet
    CommandText = 'select * from viw_logradouros where ceplog = :ceplog'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'ceplog'
        ParamType = ptInput
        Value = ''
      end>
    SQLConnection = SQLCon
    Left = 128
    Top = 336
    object SQLLogradourosCODLOG: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODLOG'
      ProviderFlags = [pfInKey]
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
  object DspLogradouros: TDataSetProvider
    DataSet = SQLLogradouros
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspLogradourosGetTableName
    Left = 160
    Top = 336
  end
  object SQLPaises: TSQLDataSet
    CommandText = 'select * from PAISES order by nompai'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 24
    Top = 240
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
  object DspPaises: TDataSetProvider
    DataSet = SQLPaises
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    BeforeUpdateRecord = DspPaisesBeforeUpdateRecord
    Left = 56
    Top = 240
  end
  object SQLEstados: TSQLDataSet
    CommandText = 
      'select est.*, pai.nompai from ESTADOS est'#13#10'inner join paises pai' +
      ' on (pai.codpai = est.codpai)'#13#10'where est.codpai = :codpai'#13#10'order' +
      ' by nomest'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codpai'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 24
    Top = 288
    object SQLEstadosCODEST: TIntegerField
      FieldName = 'CODEST'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLEstadosCODPAI: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODPAI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLEstadosNOMPAI: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'NOMPAI'
      ProviderFlags = []
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
    Left = 56
    Top = 288
  end
  object SQLMentores: TSQLDataSet
    CommandText = 
      'select codmen, codreg, nomreg, codcad, nomcad,'#13#10'matcad, sigdis, ' +
      'sigfoc from viw_mentores_ra'#13#10'where codreg = :codreg'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codreg'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 128
    Top = 184
    object SQLMentoresCODMEN: TIntegerField
      FieldName = 'CODMEN'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLMentoresCODREG: TIntegerField
      FieldName = 'CODREG'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLMentoresNOMREG: TStringField
      FieldName = 'NOMREG'
      ProviderFlags = []
      Size = 35
    end
    object SQLMentoresCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLMentoresNOMCAD: TStringField
      DisplayLabel = 'Aluno'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLMentoresMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Size = 10
    end
    object SQLMentoresSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLMentoresSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
  end
  object DspMentores: TDataSetProvider
    DataSet = SQLMentores
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspMentoresGetTableName
    OnGetDataSetProperties = DspMentoresGetDataSetProperties
    Left = 160
    Top = 184
  end
  object SQLCidades: TSQLDataSet
    CommandText = 'select * from cidades where codest = :codest'#13#10'order by nomcid'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codest'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 24
    Top = 336
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
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 56
    Top = 336
  end
  object SQLBairros: TSQLDataSet
    CommandText = 'select * from viw_bairros where codcid = :codcid'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcid'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 128
    Top = 288
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
  object DspBairros: TDataSetProvider
    DataSet = SQLBairros
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspBairrosGetTableName
    Left = 160
    Top = 288
  end
  object SQLCargos: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select * from CARGOS order by descar'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 248
    Top = 112
    object SQLCargosCODCAR: TIntegerField
      FieldName = 'CODCAR'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLCargosDESCAR: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'DESCAR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object DspCargos: TDataSetProvider
    DataSet = SQLCargos
    Options = [poIncFieldProps, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetDataSetProperties = DspCargosGetDataSetProperties
    Left = 280
    Top = 112
  end
  object SQLTiposContatos: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select * from TIPOS_CONTATOS order by destipcon'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 248
    Top = 160
    object SQLTiposContatosCODTIPCON: TIntegerField
      FieldName = 'CODTIPCON'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLTiposContatosDESTIPCON: TStringField
      DisplayLabel = 'Meio de Contato'
      FieldName = 'DESTIPCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object DspTiposContatos: TDataSetProvider
    DataSet = SQLTiposContatos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 280
    Top = 160
  end
  object SQLReports: TSQLDataSet
    CommandText = 'select 1 as "cod" from focos where nomfoc = '#39'N'#250'cleo de Vit'#243'ria'#39
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 264
    Top = 8
  end
  object DspReports: TDataSetProvider
    DataSet = SQLReports
    Options = [poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 296
    Top = 8
  end
  object SQLCommand: TSQLDataSet
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 72
    Top = 8
  end
  object SQLStoredProc: TSQLStoredProc
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftFixedChar
        Name = 'IONLYACTIVES'
        ParamType = ptInput
        Value = 'S'
      end
      item
        DataType = ftInteger
        Name = 'CODFOC'
        ParamType = ptOutput
        Size = 4
        Value = 2
      end
      item
        DataType = ftString
        Name = 'NOMFOC'
        ParamType = ptOutput
        Size = 70
        Value = 'Sede Central Brasileira'
      end
      item
        DataType = ftFixedChar
        Name = 'SIGFOC'
        ParamType = ptOutput
        Size = 4
        Value = 'SP  '
      end
      item
        DataType = ftFixedChar
        Name = 'TIPO'
        ParamType = ptOutput
        Size = 3
        Value = 'SDN'
      end
      item
        DataType = ftFixedChar
        Name = 'ATIVO'
        ParamType = ptOutput
        Size = 7
        Value = 'Ativo  '
      end>
    SQLConnection = SQLCon
    StoredProcName = 'SP_FOCOS'
    Left = 152
    Top = 65
  end
  object SQLOrgaos: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 'select * from VIW_ORGAOS_GESTORES where codorg = :codorg'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codorg'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 248
    Top = 224
    object SQLOrgaosCODORG: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODORG'
      ProviderFlags = [pfInUpdate, pfInKey]
    end
    object SQLOrgaosNOMORG: TStringField
      DefaultExpression = #39'Novo '#243'rg'#227'o gestor'#39
      DisplayLabel = #211'rg'#227'o'
      FieldName = 'NOMORG'
      Size = 50
    end
    object SQLOrgaosNOMORGING: TStringField
      DisplayLabel = 'Tradu'#231#227'o'
      FieldName = 'NOMORGING'
      Size = 50
    end
    object SQLOrgaosSIGORG: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGORG'
      FixedChar = True
      Size = 5
    end
    object SQLOrgaosCODPAI: TIntegerField
      FieldName = 'CODPAI'
    end
    object SQLOrgaosORGSUP: TStringField
      DisplayLabel = 'Subordina'#231#227'o'
      FieldName = 'ORGSUP'
      ProviderFlags = []
      Size = 50
    end
    object SQLOrgaosMANORG: TSmallintField
      DefaultExpression = '12'
      DisplayLabel = 'Mandato'
      FieldName = 'MANORG'
      ProviderFlags = [pfInUpdate]
    end
    object SQLOrgaosROLORG: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'ROLORG'
      FixedChar = True
      Size = 31
    end
    object SQLOrgaosNIVORG: TSmallintField
      DefaultExpression = '3'
      DisplayLabel = 'Esfera'
      FieldName = 'NIVORG'
      Required = True
    end
    object SQLOrgaosCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLOrgaosNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Size = 70
    end
    object SQLOrgaosSIGFOC: TStringField
      DisplayLabel = 'Sigla do Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLOrgaosINDLEC: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDLEC'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDTMO: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDTMO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDTMB: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDTMB'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDTPU: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDTPU'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDATA: TStringField
      DefaultExpression = #39'S'#39
      FieldName = 'INDATA'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDATI: TStringField
      DefaultExpression = #39'S'#39
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDNAC: TStringField
      DefaultExpression = #39'S'#39
      FieldName = 'INDNAC'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
    object SQLOrgaosDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
    end
  end
  object DspOrgaos: TDataSetProvider
    DataSet = SQLOrgaos
    Options = [poIncFieldProps, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspOrgaosGetTableName
    Left = 280
    Top = 224
  end
  object SQLGestoes: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select ges.codges, ges.codorg, org.nomorg, ges.datini, ges.datte' +
      'r, ges.datcad, ges.usures from GESTOES ges'#13#10'inner join orgaos_ge' +
      'stores org on (org.codorg = ges.codorg)'#13#10'and ges.codges = :codge' +
      's'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 248
    Top = 272
    object SQLGestoesCODGES: TIntegerField
      FieldName = 'CODGES'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLGestoesCODORG: TIntegerField
      FieldName = 'CODORG'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLGestoesNOMORG: TStringField
      FieldName = 'NOMORG'
      ProviderFlags = []
      Size = 50
    end
    object SQLGestoesDATINI: TDateField
      CustomConstraint = 'DATTER >= DATINI OR DATTER IS NULL'
      ConstraintErrorMessage = 
        'A data do in'#237'cio da gest'#227'o deve ser menor ou igual '#224' data de seu' +
        ' t'#233'rmino!'
      FieldName = 'DATINI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999;1;_'
    end
    object SQLGestoesDATTER: TDateField
      CustomConstraint = 'DATTER >= DATINI OR DATTER IS NULL'
      ConstraintErrorMessage = 
        'A data do in'#237'cio da gest'#227'o deve ser menor ou igual '#224' de seu t'#233'rm' +
        'ino!'
      FieldName = 'DATTER'
      ProviderFlags = [pfInUpdate]
      EditMask = '99/99/9999;1;_'
    end
    object SQLGestoesDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
      EditMask = '99/99/9999;1;_'
    end
    object SQLGestoesUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
  end
  object DspGestoes: TDataSetProvider
    DataSet = SQLGestoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 280
    Top = 272
  end
  object SQLDirecoes: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select dir.coddir, dir.codges, dir.codcad, cad.nomcad, dir.coddi' +
      's, dis.sigdis,dir.codfoc,'#13#10'foc.nomfoc, dir.codcar, car.descar, d' +
      'ir.datini, dir.datter, dir.indcon,'#13#10'dir.obsdir, dir.datcad, dir.' +
      'usures'#13#10'from direcoes dir'#13#10'inner join cadastrados cad on(cad.cod' +
      'cad = dir.codcad)'#13#10'inner join discipulados dis on(dis.coddis = d' +
      'ir.coddis)'#13#10'inner join focos foc on(foc.codfoc = dir.codfoc)'#13#10'in' +
      'ner join cargos car on(car.codcar = dir.codcar)'#13#10'and dir.codges ' +
      '= :codges and'#13#10'dir.coddir = :coddir'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'coddir'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 248
    Top = 320
    object SQLDirecoesCODDIR: TIntegerField
      FieldName = 'CODDIR'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLDirecoesCODGES: TIntegerField
      FieldName = 'CODGES'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDirecoesSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLDirecoesNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDirecoesCODCAR: TIntegerField
      FieldName = 'CODCAR'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesDESCAR: TStringField
      FieldName = 'DESCAR'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDirecoesDATINI: TDateField
      FieldName = 'DATINI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999;1;_'
    end
    object SQLDirecoesDATTER: TDateField
      FieldName = 'DATTER'
      ProviderFlags = [pfInUpdate]
      EditMask = '99/99/9999;1;_'
    end
    object SQLDirecoesINDCON: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLDirecoesOBSDIR: TMemoField
      FieldName = 'OBSDIR'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object SQLDirecoesDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
    end
    object SQLDirecoesUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
  end
  object DspDirecoes: TDataSetProvider
    DataSet = SQLDirecoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 280
    Top = 320
  end
  object SQLDirigentesGestao: TSQLDataSet
    CommandText = 
      'select dir.coddir, dir.codges, dir.codcad, cad.nomcad, cad.matca' +
      'd, dir.coddis, dis.sigdis,dir.codfoc,'#13#10'foc.nomfoc, dir.codcar, c' +
      'ar.descar, dir.indcon'#13#10'from direcoes dir'#13#10'inner join cadastrados' +
      ' cad on(cad.codcad = dir.codcad)'#13#10'inner join discipulados dis on' +
      '(dis.coddis = dir.coddis)'#13#10'inner join focos foc on(foc.codfoc = ' +
      'dir.codfoc)'#13#10'inner join cargos car on(car.codcar = dir.codcar)'#13#10 +
      'and dir.codges = :codges'#13#10'order by cad.nomcad'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 248
    Top = 64
  end
  object DspDirigentesGestao: TDataSetProvider
    DataSet = SQLDirigentesGestao
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 280
    Top = 64
  end
  object SQLFicha: TSQLDataSet
    CommandText = 
      'select cad.codcad, cad.matcad, cad.nomcad, cad.apecad, dis.sigdi' +
      's, foc.nomfoc, foc.sigfoc, cad.fotcad,'#13#10' (extract(year from curr' +
      'ent_date) - extract(year from cad.datnas)) as "idade"'#13#10' from  ca' +
      'dastrados cad'#13#10'inner join discipulados dis on(dis.coddis = cad.c' +
      'oddis)'#13#10'inner join focos foc on(foc.codfoc = cad.codfoc)'#13#10'where ' +
      'cad.codcad = :codcad'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 248
    Top = 374
  end
  object DspFicha: TDataSetProvider
    DataSet = SQLFicha
    Options = [poReadOnly, poUseQuoteChar]
    Left = 280
    Top = 376
  end
  object SQLDirigentesAtuais: TSQLDataSet
    CommandText = 
      'select * from viw_direcoes where codges in ('#13#10'select max(ges.cod' +
      'ges) from gestoes ges'#13#10'where ges.codorg = :codorg and (current_d' +
      'ate between ges.datini and ges.datter'#13#10'or ges.datter is null) )'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codorg'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 128
    Top = 383
  end
  object DspDirigentesAtuais: TDataSetProvider
    DataSet = SQLDirigentesAtuais
    Options = [poReadOnly, poUseQuoteChar]
    Left = 160
    Top = 384
  end
  object SQLPerfis: TSQLDataSet
    CommandText = 
      'select codper, nomper, indlec, indtmo, indtmb, indtpu, indein'#13#10'f' +
      'rom PERFIS order by nomper'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 360
    Top = 64
    object SQLPerfisCODPER: TIntegerField
      FieldName = 'CODPER'
      ProviderFlags = [pfInKey]
      Required = True
      Visible = False
    end
    object SQLPerfisNOMPER: TStringField
      DisplayLabel = 'Perfil'
      FieldName = 'NOMPER'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 31
    end
    object SQLPerfisINDLEC: TStringField
      Alignment = taCenter
      DisplayLabel = 'L.R.'
      DisplayWidth = 12
      FieldName = 'INDLEC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfisINDTMO: TStringField
      Alignment = taCenter
      DisplayLabel = 'TM'
      DisplayWidth = 12
      FieldName = 'INDTMO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfisINDTMB: TStringField
      Alignment = taCenter
      DisplayLabel = 'TMB'
      DisplayWidth = 12
      FieldName = 'INDTMB'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfisINDTPU: TStringField
      Alignment = taCenter
      DisplayLabel = 'TP'
      DisplayWidth = 12
      FieldName = 'INDTPU'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfisINDEIN: TStringField
      Alignment = taCenter
      DisplayLabel = 'E.I.'
      DisplayWidth = 12
      FieldName = 'INDEIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspPerfis: TDataSetProvider
    DataSet = SQLPerfis
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 392
    Top = 64
  end
  object SQLPerfil: TSQLDataSet
    CommandText = 
      'select codper, nomper, desper,  indlec, indtmo, indtmb, indtpu, ' +
      'indein, abrper, indadm from PERFIS where codper = :codper'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codper'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 360
    Top = 120
    object SQLPerfilCODPER: TIntegerField
      FieldName = 'CODPER'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLPerfilNOMPER: TStringField
      FieldName = 'NOMPER'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 31
    end
    object SQLPerfilDESPER: TStringField
      FieldName = 'DESPER'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object SQLPerfilINDLEC: TStringField
      FieldName = 'INDLEC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfilINDTMO: TStringField
      FieldName = 'INDTMO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfilINDTMB: TStringField
      FieldName = 'INDTMB'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfilINDTPU: TStringField
      FieldName = 'INDTPU'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfilINDEIN: TStringField
      FieldName = 'INDEIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfilABRPER: TStringField
      FieldName = 'ABRPER'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPerfilINDADM: TStringField
      FieldName = 'INDADM'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspPerfil: TDataSetProvider
    DataSet = SQLPerfil
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetDataSetProperties = DspPerfilGetDataSetProperties
    Left = 392
    Top = 120
  end
  object SQLFuncoes: TSQLDataSet
    CommandText = 'select * from FUNCOES order by desfun'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 352
    Top = 224
    object SQLFuncoesCODFUN: TIntegerField
      FieldName = 'CODFUN'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLFuncoesDESFUN: TStringField
      DisplayLabel = 'Fun'#231#227'o'
      FieldName = 'DESFUN'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
  end
  object DspFuncoes: TDataSetProvider
    DataSet = SQLFuncoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetDataSetProperties = DspFuncoesGetDataSetProperties
    Left = 384
    Top = 224
  end
end
