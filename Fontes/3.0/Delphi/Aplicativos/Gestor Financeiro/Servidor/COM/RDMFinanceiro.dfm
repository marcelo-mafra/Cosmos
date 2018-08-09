object Financeiro: TFinanceiro
  OldCreateOrder = False
  OnCreate = RemoteDataModuleCreate
  OnDestroy = RemoteDataModuleDestroy
  Height = 406
  Width = 525
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
    Left = 18
    Top = 10
  end
  object SQLSearch: TSQLDataSet
    AfterOpen = SQLSearchAfterOpen
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 16
    Top = 72
  end
  object DspSearch: TDataSetProvider
    DataSet = SQLSearch
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    Left = 48
    Top = 72
  end
  object SQLCommand: TSQLDataSet
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 80
    Top = 11
  end
  object SQLMonitor: TSQLMonitor
    OnLogTrace = SQLMonitorLogTrace
    SQLConnection = SQLCon
    Left = 168
    Top = 11
  end
  object SQLConta: TSQLDataSet
    AfterOpen = SQLSearchAfterOpen
    CommandText = 'select * from viw_plano_contas where codcon = :codcon'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 16
    Top = 128
    object SQLContaCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate, pfInKey]
    end
    object SQLContaDESCON: TStringField
      FieldName = 'DESCON'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLContaDESCONING: TStringField
      FieldName = 'DESCONING'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLContaTIPCON: TStringField
      FieldName = 'TIPCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLContaCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLContaNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Size = 70
    end
    object SQLContaCODCONPAR: TIntegerField
      FieldName = 'CODCONPAR'
      ProviderFlags = [pfInUpdate]
    end
    object SQLContaINDNAC: TStringField
      FieldName = 'INDNAC'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLContaDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLContaUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 31
    end
  end
  object DspConta: TDataSetProvider
    DataSet = SQLConta
    Options = [poIncFieldProps, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    OnGetTableName = DspContaGetTableName
    OnGetDataSetProperties = DspContaGetDataSetProperties
    Left = 48
    Top = 128
  end
  object SQLCadastrado: TSQLDataSet
    CommandText = 
      'select cad.codcad, cad.nomcad, cad.matcad, dis.sigdis, foc.sigfo' +
      'c, cad.valmen, cad.valtax, cad.fotcad'#13#10'from cadastrados cad'#13#10'inn' +
      'er join discipulados dis on (dis.coddis = cad.coddis)'#13#10'inner joi' +
      'n focos foc on (foc.codfoc = cad.codfoc)'#13#10'and cad.matcad = :matc' +
      'ad'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'matcad'
        ParamType = ptInput
        Value = ''
      end>
    SQLConnection = SQLCon
    Left = 16
    Top = 184
    object SQLCadastradoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      Visible = False
    end
    object SQLCadastradoNOMCAD: TStringField
      DisplayLabel = 'Cadastrado'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLCadastradoMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object SQLCadastradoSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLCadastradoSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLCadastradoVALMEN: TFMTBCDField
      FieldName = 'VALMEN'
      Visible = False
      Precision = 18
      Size = 2
    end
    object SQLCadastradoVALTAX: TFMTBCDField
      FieldName = 'VALTAX'
      Visible = False
      Precision = 18
      Size = 2
    end
    object SQLCadastradoFOTCAD: TGraphicField
      FieldName = 'FOTCAD'
      BlobType = ftGraphic
    end
  end
  object DspCadastrado: TDataSetProvider
    DataSet = SQLCadastrado
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    OnUpdateError = DspSearchUpdateError
    Left = 48
    Top = 184
  end
  object SQLRecebimentos: TSQLDataSet
    CommandText = 
      'select rec.codrec,rec.mesref,'#13#10' case rec.mesref'#13#10'  when 1 then '#39 +
      'Janeiro'#39#13#10'  when 2 then '#39'Fevereiro'#39#13#10'  when 3 then '#39'Mar'#231'o'#39#13#10'  wh' +
      'en 4 then '#39'Abril'#39#13#10'  when 5 then '#39'Maio'#39#13#10'  when 6 then '#39'Junho'#39#13#10 +
      '  when 7 then '#39'Julho'#39#13#10'  when 8 then '#39'Agosto'#39#13#10'  when 9 then '#39'Se' +
      'tembro'#39#13#10'  when 10 then '#39'Outubro'#39#13#10'  when 11 then '#39'Novembro'#39#13#10'  ' +
      'when 12 then '#39'Dezembro'#39#13#10' end as mes,'#13#10' rec.anoref, rec.valpre, ' +
      'rec.valrec, rec.codtiprec,'#13#10' tip.destiprec, rec.codcad, rec.datr' +
      'ec, rec.datcad, rec.usures'#13#10'from recebimentos rec'#13#10'inner join ti' +
      'pos_recebimentos tip on (tip.codtiprec = rec.codtiprec)'#13#10'and rec' +
      '.codcad = :codcad and rec.anoref = :anoref'#13#10'order by rec.anoref,' +
      ' rec.mesref'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftSmallint
        Name = 'anoref'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 136
    Top = 72
    object SQLRecebimentosCODREC: TIntegerField
      FieldName = 'CODREC'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLRecebimentosMESREF: TSmallintField
      FieldName = 'MESREF'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLRecebimentosMES: TStringField
      DisplayLabel = 'M'#234's'
      FieldName = 'MES'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 9
    end
    object SQLRecebimentosANOREF: TSmallintField
      DisplayLabel = 'Ano'
      DisplayWidth = 7
      FieldName = 'ANOREF'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLRecebimentosVALPRE: TFMTBCDField
      DisplayLabel = 'Previsto'
      DisplayWidth = 10
      FieldName = 'VALPRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLRecebimentosVALREC: TFMTBCDField
      CustomConstraint = 'VALREC > 0'
      ConstraintErrorMessage = 'O valor do recebimento deve ser maior do que zero!'
      DisplayLabel = 'Recebido'
      DisplayWidth = 10
      FieldName = 'VALREC'
      ProviderFlags = [pfInUpdate]
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLRecebimentosCODTIPREC: TIntegerField
      FieldName = 'CODTIPREC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLRecebimentosDESTIPREC: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 30
      FieldName = 'DESTIPREC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLRecebimentosCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLRecebimentosDATREC: TSQLTimeStampField
      DisplayLabel = 'Recebido em'
      DisplayWidth = 10
      FieldName = 'DATREC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLRecebimentosDATCAD: TSQLTimeStampField
      DisplayLabel = 'Cadastro'
      DisplayWidth = 20
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLRecebimentosUSURES: TStringField
      DisplayLabel = 'Respos'#225'vel'
      DisplayWidth = 15
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 31
    end
  end
  object DspRecebimentos: TDataSetProvider
    DataSet = SQLRecebimentos
    Options = [poIncFieldProps, poDisableInserts, poDisableEdits, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    Left = 168
    Top = 72
  end
  object SQLTiposRecebimentos: TSQLDataSet
    CommandText = 'select * from tipos_recebimentos order by destiprec'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 136
    Top = 128
    object SQLTiposRecebimentosCODTIPREC: TIntegerField
      FieldName = 'CODTIPREC'
      Required = True
      Visible = False
    end
    object SQLTiposRecebimentosDESTIPREC: TStringField
      DisplayLabel = 'Tipo de Recebimento'
      FieldName = 'DESTIPREC'
      Required = True
      Size = 70
    end
    object SQLTiposRecebimentosVERSION: TIntegerField
      FieldName = 'VERSION'
      Visible = False
    end
    object SQLTiposRecebimentosSYNC: TSmallintField
      FieldName = 'SYNC'
      Visible = False
    end
  end
  object DspTiposRecebimentos: TDataSetProvider
    DataSet = SQLTiposRecebimentos
    Options = [poIncFieldProps, poUseQuoteChar]
    OnUpdateError = DspSearchUpdateError
    OnGetTableName = DspTiposRecebimentosGetTableName
    OnGetDataSetProperties = DspTiposRecebimentosGetDataSetProperties
    Left = 168
    Top = 128
  end
  object SQLRecebimento: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select rec.codrec, rec.mesref, rec.anoref, rec.valpre, rec.valre' +
      'c, rec.codtiprec, tip.destiprec, rec.codcad, rec.obsrec, rec.dat' +
      'rec, rec.datcad, rec.usures'#13#10'from recebimentos rec'#13#10'inner join t' +
      'ipos_recebimentos tip on (tip.codtiprec = rec.codtiprec)'#13#10'and re' +
      'c.codrec = :codrec and rec.codcad = :codcad'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codrec'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 136
    Top = 184
    object IntegerField1: TIntegerField
      FieldName = 'CODREC'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SmallintField1: TSmallintField
      CustomConstraint = 'MESREF >= 1 and MESREF <= 12'
      ConstraintErrorMessage = 'O m'#234's indicado '#233' inv'#225'lido!'
      DisplayLabel = 'M'#234's'
      FieldName = 'MESREF'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SmallintField2: TSmallintField
      DisplayLabel = 'Ano'
      FieldName = 'ANOREF'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object FMTBCDField1: TFMTBCDField
      DisplayLabel = 'Previsto'
      FieldName = 'VALPRE'
      ProviderFlags = [pfInUpdate]
      currency = True
      Precision = 18
      Size = 2
    end
    object FMTBCDField2: TFMTBCDField
      CustomConstraint = 'VALREC > 0'
      ConstraintErrorMessage = 'O valor do recebimento deve ser maior do que zero!'
      DisplayLabel = 'Recebido'
      FieldName = 'VALREC'
      ProviderFlags = [pfInUpdate]
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object IntegerField2: TIntegerField
      FieldName = 'CODTIPREC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object StringField1: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 30
      FieldName = 'DESTIPREC'
      ProviderFlags = []
      Size = 70
    end
    object IntegerField3: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object StringField2: TStringField
      DisplayLabel = 'Observa'#231#245'es'
      DisplayWidth = 30
      FieldName = 'OBSREC'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object SQLTimeStampField1: TSQLTimeStampField
      DisplayLabel = 'Recebido em'
      FieldName = 'DATREC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLTimeStampField2: TSQLTimeStampField
      DisplayLabel = 'Cadastro'
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
    object StringField3: TStringField
      DisplayLabel = 'Respons'#225'vel'
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 31
    end
  end
  object DspRecebimento: TDataSetProvider
    DataSet = SQLRecebimento
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    OnGetTableName = DspRecebimentoGetTableName
    OnGetDataSetProperties = DspRecebimentoGetDataSetProperties
    Left = 168
    Top = 184
  end
  object SQLPesquisarPlanoContas: TSQLDataSet
    CommandText = 
      'select * from viw_plano_contas where codfoc is null or codfoc = ' +
      ':codfoc'
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
    Left = 16
    Top = 248
  end
  object DspPesquisarPlanoContas: TDataSetProvider
    DataSet = SQLPesquisarPlanoContas
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    OnUpdateError = DspSearchUpdateError
    Left = 48
    Top = 248
  end
  object SQLCentrosCusto: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select cen.codcen, cen.nomcen, cen.nomeng, cen.codfoc, foc.nomfo' +
      'c, cen.indati'#13#10' from centro_custos cen'#13#10' left outer join focos f' +
      'oc on (cen.codfoc = foc.codfoc)'#13#10' order by nomcen'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 136
    Top = 240
    object SQLCentrosCustoCODCEN: TIntegerField
      FieldName = 'CODCEN'
      ProviderFlags = [pfInKey]
      Required = True
      Visible = False
    end
    object SQLCentrosCustoNOMCEN: TStringField
      DisplayLabel = 'Centro'
      FieldName = 'NOMCEN'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLCentrosCustoNOMENG: TStringField
      DisplayLabel = 'Centro (L'#237'ngua Inglesa)'
      FieldName = 'NOMENG'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLCentrosCustoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLCentrosCustoNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Size = 70
    end
    object SQLCentrosCustoINDATI: TStringField
      DisplayLabel = 'Ativo'
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspCentrosCusto: TDataSetProvider
    DataSet = SQLCentrosCusto
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    Left = 168
    Top = 240
  end
  object SQLCentroCusto: TSQLDataSet
    CommandText = 
      'select cen.codcen, cen.nomcen, cen.nomeng, cen.codfoc, foc.nomfo' +
      'c, cen.indati'#13#10' from centro_custos cen'#13#10' left outer join focos f' +
      'oc on (cen.codfoc = foc.codfoc)'#13#10' and cen.codcen = :codcen'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcen'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 136
    Top = 296
    object SQLCentroCustoCODCEN: TIntegerField
      FieldName = 'CODCEN'
      ProviderFlags = [pfInKey]
      Required = True
    end
    object SQLCentroCustoNOMCEN: TStringField
      FieldName = 'NOMCEN'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLCentroCustoNOMENG: TStringField
      FieldName = 'NOMENG'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLCentroCustoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLCentroCustoNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Size = 70
    end
    object SQLCentroCustoINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspCentroCusto: TDataSetProvider
    DataSet = SQLCentroCusto
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    OnGetTableName = DspCentroCustoGetTableName
    OnGetDataSetProperties = DspCentroCustoGetDataSetProperties
    Left = 168
    Top = 296
  end
  object SQLTransacoes: TSQLDataSet
    CommandText = 
      'select * from VIW_TRANSACOES where codfoc = :codfoc order by dat' +
      'tra desc'
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
    Left = 264
    Top = 64
    object SQLTransacoesCODTRA: TIntegerField
      FieldName = 'CODTRA'
      Visible = False
    end
    object SQLTransacoesCODCAI: TIntegerField
      FieldName = 'CODCAI'
      Visible = False
    end
    object SQLTransacoesNUMCAI: TStringField
      DisplayLabel = 'Caixa'
      FieldName = 'NUMCAI'
      FixedChar = True
      Size = 10
    end
    object SQLTransacoesCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Visible = False
    end
    object SQLTransacoesNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      Visible = False
      Size = 70
    end
    object SQLTransacoesSIGFOC: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLTransacoesDATTRA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATTRA'
    end
    object SQLTransacoesDESTRA: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESTRA'
      Size = 70
    end
    object SQLTransacoesVALTRA: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALTRA'
      Precision = 15
      Size = 2
    end
    object SQLTransacoesINDDEBCRE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'INDDEBCRE'
      FixedChar = True
      Size = 7
    end
  end
  object DspTransacoes: TDataSetProvider
    DataSet = SQLTransacoes
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspSearchUpdateError
    Left = 312
    Top = 64
  end
end
