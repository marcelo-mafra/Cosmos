object DMFinanceiroMethods: TDMFinanceiroMethods
  OldCreateOrder = False
  Height = 535
  Width = 723
  object SQLConta: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 'select * from viw_plano_contas where codcon = :codcon'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 32
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
      Size = 70
    end
  end
  object DspConta: TDataSetProvider
    DataSet = SQLConta
    Options = [poIncFieldProps, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspContaUpdateError
    OnGetTableName = DspContaGetTableName
    OnGetDataSetProperties = DspContaGetDataSetProperties
    Left = 64
    Top = 32
  end
  object SQLCadastrado: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select cad.codcad, cad.nomcad, cad.matcad, dis.sigdis, foc.sigfo' +
      'c, cad.valmen, cad.valtax, cad.fotcad'#13#10'from cadastrados cad'#13#10'inn' +
      'er join discipulados dis on (dis.coddis = cad.coddis)'#13#10'inner joi' +
      'n focos foc on (foc.codfoc = cad.codfoc)'#13#10'and cad.matcad = :matc' +
      'ad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'matcad'
        ParamType = ptInput
        Value = ''
      end>
    Left = 32
    Top = 88
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
    Left = 64
    Top = 88
  end
  object SQLRecebimentos: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select rec.codrec,rec.mesref,'#13#10' case rec.mesref'#13#10'  when 1 then '#39 +
      'Janeiro'#39#13#10'  when 2 then '#39'Fevereiro'#39#13#10'  when 3 then '#39'Mar'#231'o'#39#13#10'  wh' +
      'en 4 then '#39'Abril'#39#13#10'  when 5 then '#39'Maio'#39#13#10'  when 6 then '#39'Junho'#39#13#10 +
      '  when 7 then '#39'Julho'#39#13#10'  when 8 then '#39'Agosto'#39#13#10'  when 9 then '#39'Se' +
      'tembro'#39#13#10'  when 10 then '#39'Outubro'#39#13#10'  when 11 then '#39'Novembro'#39#13#10'  ' +
      'when 12 then '#39'Dezembro'#39#13#10' end as mes,'#13#10' rec.anoref, rec.valpre, ' +
      'rec.valrec, rec.codtiprec,'#13#10' rec.destiprec, rec.codcad, rec.datr' +
      'ec, rec.nomfav, rec.indcan, rec.datcad, rec.usures'#13#10'from viw_rec' +
      'ebimentos rec'#13#10'where rec.codcad = :codcad and rec.anoref = :anor' +
      'ef'#13#10'order by rec.anoref, rec.mesref'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'anoref'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 32
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
      DisplayWidth = 20
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
      DisplayWidth = 15
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
      DisplayWidth = 15
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
    object SQLRecebimentosNOMFAV: TStringField
      DisplayLabel = 'Favorecido'
      DisplayWidth = 50
      FieldName = 'NOMFAV'
      ProviderFlags = []
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
      DisplayWidth = 20
      FieldName = 'DATREC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLRecebimentosINDCAN: TStringField
      FieldName = 'INDCAN'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 1
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
      DisplayWidth = 30
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 70
    end
  end
  object DspRecebimentos: TDataSetProvider
    DataSet = SQLRecebimentos
    Options = [poIncFieldProps, poDisableInserts, poDisableEdits, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 224
    Top = 32
  end
  object SQLTiposRecebimentos: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 'select * from tipos_recebimentos order by destiprec'
    MaxBlobSize = -1
    Params = <>
    Left = 192
    Top = 144
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
    object SQLTiposRecebimentosSIGTIPREC: TStringField
      FieldName = 'SIGTIPREC'
      Required = True
      FixedChar = True
      Size = 3
    end
  end
  object DspTiposRecebimentos: TDataSetProvider
    DataSet = SQLTiposRecebimentos
    Options = [poIncFieldProps, poUseQuoteChar]
    OnUpdateError = DspContaUpdateError
    OnGetTableName = DspTiposRecebimentosGetTableName
    OnGetDataSetProperties = DspTiposRecebimentosGetDataSetProperties
    Left = 224
    Top = 144
  end
  object SQLRecebimento: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select rec.codrec, rec.mesref, rec.anoref, rec.valpre, rec.valre' +
      'c, rec.codtiprec,'#13#10'rec.destiprec, rec.codcad, rec.obsrec, rec.co' +
      'dfav, rec.nomfav, rec.codloc, rec.nomloc,'#13#10'rec.datrec, rec.codca' +
      'i, rec.numcai, rec.nomcad, rec.indcan, rec.usucan, rec.motcan, r' +
      'ec.datcan, rec.datcad, rec.usures'#13#10'from viw_recebimentos rec'#13#10'wh' +
      'ere rec.codrec = :codrec and rec.codcad = :codcad'
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
    Left = 192
    Top = 88
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
      Size = 70
    end
    object SQLRecebimentoCODFAV: TIntegerField
      FieldName = 'CODFAV'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecebimentoNOMFAV: TStringField
      FieldName = 'NOMFAV'
      ProviderFlags = []
      Size = 70
    end
    object SQLRecebimentoCODLOC: TIntegerField
      FieldName = 'CODLOC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecebimentoNOMLOC: TStringField
      FieldName = 'NOMLOC'
      ProviderFlags = []
      Size = 70
    end
    object SQLRecebimentoCODCAI: TIntegerField
      FieldName = 'CODCAI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecebimentoNUMCAI: TStringField
      FieldName = 'NUMCAI'
      ProviderFlags = []
      FixedChar = True
      Size = 10
    end
    object SQLRecebimentoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLRecebimentoINDCAN: TStringField
      FieldName = 'INDCAN'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLRecebimentoMOTCAN: TSmallintField
      FieldName = 'MOTCAN'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecebimentoDATCAN: TSQLTimeStampField
      FieldName = 'DATCAN'
      ProviderFlags = []
    end
    object SQLRecebimentoUSUCAN: TStringField
      FieldName = 'USUCAN'
      ProviderFlags = []
      FixedChar = True
      Size = 70
    end
  end
  object DspRecebimento: TDataSetProvider
    DataSet = SQLRecebimento
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspContaUpdateError
    OnGetTableName = DspRecebimentoGetTableName
    OnGetDataSetProperties = DspRecebimentoGetDataSetProperties
    Left = 224
    Top = 88
  end
  object SQLPesquisarPlanoContas: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select * from viw_plano_contas where codfoc is null or codfoc = ' +
      ':codfoc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 152
  end
  object DspPesquisarPlanoContas: TDataSetProvider
    DataSet = SQLPesquisarPlanoContas
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 64
    Top = 152
  end
  object SQLCentrosCusto: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select cen.codcen, cen.nomcen, cen.nomeng, cen.codfoc, foc.nomfo' +
      'c, cen.indati'#13#10' from centro_custos cen'#13#10' left outer join focos f' +
      'oc on (cen.codfoc = foc.codfoc)'#13#10' order by nomcen'
    MaxBlobSize = -1
    Params = <>
    Left = 32
    Top = 224
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
    Left = 64
    Top = 224
  end
  object SQLCentroCusto: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select cen.codcen, cen.nomcen, cen.nomeng, cen.codfoc, foc.nomfo' +
      'c, cen.indati'#13#10' from centro_custos cen'#13#10' left outer join focos f' +
      'oc on (cen.codfoc = foc.codfoc)'#13#10' where cen.codcen = ?'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcen'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 280
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
    OnUpdateError = DspContaUpdateError
    OnGetTableName = DspCentroCustoGetTableName
    OnGetDataSetProperties = DspCentroCustoGetDataSetProperties
    Left = 64
    Top = 280
  end
  object SQLTransacoes: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select * from VIW_TRANSACOES where codfoc = :codfoc order by dat' +
      'tra desc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 224
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
    Left = 240
    Top = 224
  end
  object DspValoresContribuicao: TDataSetProvider
    DataSet = SQLValoresContribuicao
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspContaUpdateError
    OnGetTableName = DspValoresContribuicaoGetTableName
    Left = 232
    Top = 288
  end
  object SQLValoresContribuicao: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select cad.codcad, cad.nomcad, cad.matcad,  cad.valmen, cad.valt' +
      'ax, cad.codfoc'#13#10'from cadastrados cad'#13#10'where cad.codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 200
    Top = 288
    object IntegerField4: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInKey]
      Visible = False
    end
    object StringField4: TStringField
      DisplayLabel = 'Cadastrado'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object StringField5: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Size = 10
    end
    object FMTBCDField3: TFMTBCDField
      FieldName = 'VALMEN'
      ProviderFlags = [pfInUpdate]
      currency = True
      Precision = 18
      Size = 2
    end
    object FMTBCDField4: TFMTBCDField
      FieldName = 'VALTAX'
      ProviderFlags = [pfInUpdate]
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLValoresContribuicaoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = []
      Required = True
    end
  end
  object DspContribuicoesPendentes: TDataSetProvider
    DataSet = SQLContribuicoesPendentes
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 232
    Top = 360
  end
  object SQLContribuicoesPendentes: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select * from  CONTRIBUICOES_PENDENTES(:icodcad, :ianoref, :icod' +
      'fav, :iindmen, :iindtax)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'icodcad'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftSmallint
        Precision = 2
        Name = 'ianoref'
        ParamType = ptInput
        Value = '2014'
      end
      item
        DataType = ftInteger
        Name = 'icodfav'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = 'iindmen'
        ParamType = ptInput
        Value = 'S'
      end
      item
        DataType = ftFixedChar
        Name = 'iindtax'
        ParamType = ptInput
        Value = 'S'
      end>
    Left = 200
    Top = 360
    object SQLContribuicoesPendentesCODREC: TIntegerField
      FieldName = 'CODREC'
      Visible = False
    end
    object SQLContribuicoesPendentesMESREF: TSmallintField
      DisplayLabel = 'M'#234's'
      FieldName = 'MESREF'
      ProviderFlags = []
    end
    object SQLContribuicoesPendentesANOREF: TSmallintField
      DisplayLabel = 'Ano'
      FieldName = 'ANOREF'
      ProviderFlags = []
    end
    object SQLContribuicoesPendentesDESTIPREC: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'DESTIPREC'
      ProviderFlags = []
      Size = 70
    end
    object SQLContribuicoesPendentesVALREC: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALREC'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object SQLContribuicoesPendentesDATREC: TSQLTimeStampField
      DisplayLabel = 'Data'
      FieldName = 'DATREC'
      ProviderFlags = []
    end
    object SQLContribuicoesPendentesINDPEN: TStringField
      DisplayLabel = 'Pendente'
      FieldName = 'INDPEN'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
  end
  object SQLPagamentos: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select CODPAG, MESREF, ANOREF, VALPAG, DESPAG, CODCAI, NUMCAI, N' +
      'OMFOC, FORPAG, INDCAN, DATCAN from  VIW_PAGAMENTOS'#13#10'where codfoc' +
      ' = ? and mesref = ? and anoref = ? order by datpag'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftSmallint
        Name = 'mesref'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftSmallint
        Name = 'anoref'
        ParamType = ptInput
        Value = 0
      end>
    Left = 336
    Top = 32
    object SQLPagamentosCODPAG: TIntegerField
      FieldName = 'CODPAG'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLPagamentosMESREF: TSmallintField
      DisplayLabel = 'M'#234's'
      FieldName = 'MESREF'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentosANOREF: TSmallintField
      DisplayLabel = 'Ano'
      FieldName = 'ANOREF'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentosDESPAG: TStringField
      DisplayLabel = 'Pagamento'
      FieldName = 'DESPAG'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLPagamentosVALPAG: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALPAG'
      ProviderFlags = [pfInUpdate]
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPagamentosCODCAI: TIntegerField
      FieldName = 'CODCAI'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLPagamentosNUMCAI: TStringField
      DisplayLabel = 'Caixa'
      FieldName = 'NUMCAI'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object SQLPagamentosNOMFOC: TStringField
      DisplayLabel = 'Fonte'
      FieldName = 'NOMFOC'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLPagamentosFORPAG: TStringField
      DisplayLabel = 'Forma'
      FieldName = 'FORPAG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 3
    end
    object SQLPagamentosINDCAN: TStringField
      DisplayLabel = 'Cancelado'
      FieldName = 'INDCAN'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLPagamentosDATCAN: TSQLTimeStampField
      DisplayLabel = 'Cancelamento'
      FieldName = 'DATCAN'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DspPagamentos: TDataSetProvider
    DataSet = SQLPagamentos
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 368
    Top = 32
  end
  object SQLPagamento: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 'select * from viw_pagamentos where codpag = ?'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codpag'
        ParamType = ptInput
        Value = 0
      end>
    Left = 336
    Top = 88
    object SQLPagamentoCODPAG: TIntegerField
      FieldName = 'CODPAG'
      ProviderFlags = [pfInUpdate, pfInKey]
    end
    object SQLPagamentoMESREF: TSmallintField
      FieldName = 'MESREF'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoANOREF: TSmallintField
      FieldName = 'ANOREF'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoVALPAG: TFMTBCDField
      FieldName = 'VALPAG'
      ProviderFlags = [pfInUpdate]
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLPagamentoDESPAG: TStringField
      FieldName = 'DESPAG'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLPagamentoDATPAG: TDateField
      FieldName = 'DATPAG'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoCODCAI: TIntegerField
      FieldName = 'CODCAI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoNUMCAI: TStringField
      FieldName = 'NUMCAI'
      ProviderFlags = []
      Size = 15
    end
    object SQLPagamentoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLPagamentoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Size = 70
    end
    object SQLPagamentoFORPAG: TStringField
      FieldName = 'FORPAG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 3
    end
    object SQLPagamentoOBSPAG: TMemoField
      FieldName = 'OBSPAG'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object SQLPagamentoINDCAN: TStringField
      FieldName = 'INDCAN'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLPagamentoDATCAN: TSQLTimeStampField
      FieldName = 'DATCAN'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoUSUCAN: TStringField
      FieldName = 'USUCAN'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLPagamentoMOTCAN: TSmallintField
      FieldName = 'MOTCAN'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPagamentoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
  end
  object DspPagamento: TDataSetProvider
    DataSet = SQLPagamento
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspContaUpdateError
    OnGetTableName = DspPagamentoGetTableName
    OnGetDataSetProperties = DspPagamentoGetDataSetProperties
    Left = 368
    Top = 88
  end
  object SQLRecimentosCaixa: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select * from viw_recebimentos where codcai = :codcai order by d' +
      'atrec desc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcai'
        ParamType = ptInput
        Value = 0
      end>
    Left = 352
    Top = 192
    object SQLRecimentosCaixaCODREC: TIntegerField
      FieldName = 'CODREC'
      ProviderFlags = [pfInWhere, pfInKey]
      Visible = False
    end
    object SQLRecimentosCaixaMESREF: TSmallintField
      DisplayLabel = 'M'#234's'
      DisplayWidth = 7
      FieldName = 'MESREF'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecimentosCaixaANOREF: TSmallintField
      DisplayLabel = 'Ano'
      FieldName = 'ANOREF'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecimentosCaixaVALPRE: TFMTBCDField
      DisplayLabel = 'Previsto'
      DisplayWidth = 12
      FieldName = 'VALPRE'
      ProviderFlags = [pfInUpdate]
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLRecimentosCaixaVALREC: TFMTBCDField
      DisplayLabel = 'Realizado'
      DisplayWidth = 12
      FieldName = 'VALREC'
      ProviderFlags = [pfInUpdate]
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLRecimentosCaixaCODTIPREC: TIntegerField
      FieldName = 'CODTIPREC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLRecimentosCaixaDESTIPREC: TStringField
      DisplayLabel = 'Referente a'
      DisplayWidth = 25
      FieldName = 'DESTIPREC'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLRecimentosCaixaCODFAV: TIntegerField
      FieldName = 'CODFAV'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLRecimentosCaixaNOMFAV: TStringField
      DisplayLabel = 'Favorecido'
      DisplayWidth = 25
      FieldName = 'NOMFAV'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLRecimentosCaixaCODLOC: TIntegerField
      FieldName = 'CODLOC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLRecimentosCaixaNOMLOC: TStringField
      DisplayLabel = 'Recebedor'
      DisplayWidth = 25
      FieldName = 'NOMLOC'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLRecimentosCaixaCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLRecimentosCaixaMATCAD: TStringField
      DisplayLabel = 'Fonte Pagadora'
      FieldName = 'MATCAD'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object SQLRecimentosCaixaCODFOCCAD: TIntegerField
      FieldName = 'CODFOCCAD'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLRecimentosCaixaDATREC: TSQLTimeStampField
      DisplayLabel = 'Recebido em'
      DisplayWidth = 18
      FieldName = 'DATREC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecimentosCaixaCODCAI: TIntegerField
      FieldName = 'CODCAI'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLRecimentosCaixaNUMCAI: TStringField
      DisplayLabel = 'Caixa'
      FieldName = 'NUMCAI'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 10
    end
    object SQLRecimentosCaixaNOMCAD: TStringField
      DisplayLabel = 'Pagador'
      DisplayWidth = 25
      FieldName = 'NOMCAD'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLRecimentosCaixaINDCAN: TStringField
      FieldName = 'INDCAN'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLRecimentosCaixaUSUCAN: TStringField
      DisplayLabel = 'Cancelado por'
      FieldName = 'USUCAN'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
    object SQLRecimentosCaixaOBSREC: TStringField
      FieldName = 'OBSREC'
      ProviderFlags = [pfInUpdate]
      Visible = False
      Size = 100
    end
    object SQLRecimentosCaixaDATCAD: TSQLTimeStampField
      DisplayLabel = 'Data'
      DisplayWidth = 18
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLRecimentosCaixaUSURES: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 70
    end
  end
  object DspRecebimentosCaixa: TDataSetProvider
    DataSet = SQLRecimentosCaixa
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 384
    Top = 192
  end
  object SQLPagamentosCaixa: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select pag.codpag, pag.codcai, cai.numcai, pag.valpag, pag.datpa' +
      'g, pag.despag, pag.forpag, pag.datcad, pag.usures'#13#10' from pagamen' +
      'tos pag'#13#10'  inner join caixas cai on(cai.codcai = pag.codcai)'#13#10' a' +
      'nd pag.codcai = :codcai'#13#10'  order by pag.datpag desc'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcai'
        ParamType = ptInput
        Value = 0
      end>
    Left = 352
    Top = 256
    object SQLPagamentosCaixaCODPAG: TIntegerField
      FieldName = 'CODPAG'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLPagamentosCaixaCODCAI: TIntegerField
      FieldName = 'CODCAI'
      Required = True
      Visible = False
    end
    object SQLPagamentosCaixaNUMCAI: TStringField
      DisplayLabel = 'Caixa'
      FieldName = 'NUMCAI'
      Required = True
      FixedChar = True
      Size = 10
    end
    object SQLPagamentosCaixaVALPAG: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALPAG'
      Required = True
      Precision = 18
      Size = 2
    end
    object SQLPagamentosCaixaDATPAG: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATPAG'
      Required = True
    end
    object SQLPagamentosCaixaDESPAG: TStringField
      DisplayLabel = 'Pagamento'
      FieldName = 'DESPAG'
      Required = True
      Size = 70
    end
    object SQLPagamentosCaixaFORPAG: TStringField
      DisplayLabel = 'Pago com'
      FieldName = 'FORPAG'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLPagamentosCaixaDATCAD: TSQLTimeStampField
      DisplayLabel = 'Cadastro'
      FieldName = 'DATCAD'
      Required = True
    end
    object SQLPagamentosCaixaUSURES: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USURES'
      Required = True
      FixedChar = True
      Size = 70
    end
  end
  object DspPagamentosCaixa: TDataSetProvider
    DataSet = SQLPagamentosCaixa
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 384
    Top = 256
  end
  object SQLContasBancarias: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select con.codconban, ban.nomban, con.numban, con.numage, con.nu' +
      'mcon, con.camtra, con.codfoc,'#13#10'foc.nomfoc, con.indati from conta' +
      's_bancarias con'#13#10'join focos foc using(codfoc)'#13#10'join instituicoes' +
      '_bancarias ban using(numban)'#13#10'where con.indati = ? order by foc.' +
      'nomfoc, con.numban'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftWideString
        Name = 'indati'
        ParamType = ptInput
        Value = 'S'
      end>
    Left = 32
    Top = 336
    object SQLContasBancariasCODCONBAN: TIntegerField
      FieldName = 'CODCONBAN'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLContasBancariasNOMBAN: TStringField
      DisplayLabel = 'Banco'
      FieldName = 'NOMBAN'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLContasBancariasNUMBAN: TStringField
      DisplayLabel = 'Banco'
      FieldName = 'NUMBAN'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLContasBancariasNUMAGE: TIntegerField
      DisplayLabel = 'Ag'#234'ncia'
      FieldName = 'NUMAGE'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLContasBancariasNUMCON: TStringField
      DisplayLabel = 'Conta'
      FieldName = 'NUMCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 25
    end
    object SQLContasBancariasCAMTRA: TStringField
      DisplayLabel = 'Propriet'#225'rio'
      DisplayWidth = 10
      FieldName = 'CAMTRA'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLContasBancariasCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLContasBancariasNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLContasBancariasINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object DspContasBancarias: TDataSetProvider
    DataSet = SQLContasBancarias
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 64
    Top = 336
  end
  object SQLContaBancaria: TSQLDataSet
    BeforeOpen = SQLContaBeforeOpen
    CommandText = 
      'select con.codconban, ban.nomban, con.numban, con.numage, con.nu' +
      'mcon, con.camtra, con.codfoc, foc.nomfoc, con.indati, con.obscon' +
      ' from contas_bancarias con'#13#10'join focos foc using(codfoc)'#13#10'join i' +
      'nstituicoes_bancarias ban using(numban)'#13#10'where con.codconban = ?'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codconban'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 400
    object IntegerField5: TIntegerField
      FieldName = 'CODCONBAN'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLContaBancariaNOMBAN: TStringField
      FieldName = 'NOMBAN'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLContaBancariaNUMBAN: TStringField
      FieldName = 'NUMBAN'
      Required = True
      FixedChar = True
      Size = 3
    end
    object IntegerField6: TIntegerField
      DisplayLabel = 'Ag'#234'ncia'
      FieldName = 'NUMAGE'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object StringField6: TStringField
      DisplayLabel = 'Conta'
      FieldName = 'NUMCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 25
    end
    object StringField7: TStringField
      DisplayLabel = 'Propriet'#225'rio'
      FieldName = 'CAMTRA'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object IntegerField7: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object StringField8: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object StringField9: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLContaBancariaOBSCON: TStringField
      FieldName = 'OBSCON'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
  end
  object DspContaBancaria: TDataSetProvider
    DataSet = SQLContaBancaria
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspContaUpdateError
    OnGetTableName = DspContaBancariaGetTableName
    OnGetDataSetProperties = DspContaBancariaGetDataSetProperties
    Left = 64
    Top = 400
  end
end
