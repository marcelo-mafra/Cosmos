object DMCosmosApplicationServer: TDMCosmosApplicationServer
  OldCreateOrder = False
  Height = 552
  Width = 626
  object SQLDiscipulados: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 
      'select coddis, nomdis, sigdis from discipulados where camdis = :' +
      'camdis and indescint = :indescint  and indati = '#39'S'#39' order by seq' +
      'dis'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'CAMDIS'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'INDESCINT'
        ParamType = ptInput
      end>
    Left = 48
    Top = 32
    object SQLDiscipuladosCODDIS: TIntegerField
      FieldName = 'CODDIS'
      Required = True
      Visible = False
    end
    object SQLDiscipuladosNOMDIS: TStringField
      DisplayLabel = 'Discipulado'
      DisplayWidth = 40
      FieldName = 'NOMDIS'
      Required = True
      Size = 70
    end
    object SQLDiscipuladosSIGDIS: TStringField
      DisplayLabel = 'Sigla'
      DisplayWidth = 10
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
  end
  object DspDiscipulados: TDataSetProvider
    DataSet = SQLDiscipulados
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 128
    Top = 32
  end
  object SQLAptidoes: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 'select * from AREAS_APTIDOES order by desare'
    MaxBlobSize = -1
    Params = <>
    Left = 48
    Top = 106
    object SQLAptidoesCODARE: TIntegerField
      FieldName = 'CODARE'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLAptidoesDESARE: TStringField
      DisplayLabel = 'Aptid'#227'o'
      FieldName = 'DESARE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object DspAptidoes: TDataSetProvider
    DataSet = SQLAptidoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspAptidoesGetDataSetProperties
    Left = 112
    Top = 106
  end
  object DspFuncoes: TDataSetProvider
    DataSet = SQLFuncoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspFuncoesGetDataSetProperties
    Left = 112
    Top = 176
  end
  object SQLFuncoes: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 'select * from FUNCOES order by desfun'
    MaxBlobSize = -1
    Params = <>
    Left = 48
    Top = 176
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
  object DspProfissoes: TDataSetProvider
    DataSet = SQLProfissoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspProfissoesGetDataSetProperties
    Left = 120
    Top = 241
  end
  object SQLProfissoes: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 'select * from PROFISSOES order by despro'
    MaxBlobSize = -1
    Params = <>
    Left = 48
    Top = 240
    object SQLProfissoesCODPRO: TIntegerField
      FieldName = 'CODPRO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLProfissoesDESPRO: TStringField
      DisplayLabel = 'Profiss'#227'o'
      FieldName = 'DESPRO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object SQLCargos: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 'select * from CARGOS order by descar'
    MaxBlobSize = -1
    Params = <>
    Left = 48
    Top = 304
    object SQLCargosCODCAR: TIntegerField
      FieldName = 'CODCAR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
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
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspCargosGetDataSetProperties
    Left = 120
    Top = 305
  end
  object SQLEnfermidades: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 'select * from ENFERMIDADES order by nomenf'
    MaxBlobSize = -1
    Params = <>
    Left = 48
    Top = 360
    object SQLEnfermidadesCODENF: TIntegerField
      FieldName = 'CODENF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLEnfermidadesNOMENF: TStringField
      DisplayLabel = 'Enfermidade'
      FieldName = 'NOMENF'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object DspEnfermidades: TDataSetProvider
    DataSet = SQLEnfermidades
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspEnfermidadesGetDataSetProperties
    Left = 120
    Top = 361
  end
  object SQLTiposContatos: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 'select * from TIPOS_CONTATOS order by destipcon'
    MaxBlobSize = -1
    Params = <>
    Left = 48
    Top = 416
    object SQLTiposContatosCODTIPCON: TIntegerField
      FieldName = 'CODTIPCON'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLTiposContatosDESTIPCON: TStringField
      DisplayLabel = 'Meios de Contato'
      FieldName = 'DESTIPCON'
      Required = True
      Size = 70
    end
  end
  object DspMeiosContato: TDataSetProvider
    DataSet = SQLTiposContatos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspMeiosContatoGetDataSetProperties
    Left = 120
    Top = 417
  end
  object SQLAptidoesCadastrados: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 
      'select apt.codapt, apt.codcad, apt.codare, are.desare, apt.obsca' +
      'd'#13#10'from aptidoes apt'#13#10'inner join areas_aptidoes are on (apt.coda' +
      're = are.codare)'#13#10'and apt.codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 280
    Top = 32
    object SQLAptidoesCadastradosCODAPT: TIntegerField
      FieldName = 'CODAPT'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLAptidoesCadastradosCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLAptidoesCadastradosCODARE: TIntegerField
      FieldName = 'CODARE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLAptidoesCadastradosDESARE: TStringField
      DisplayLabel = #193'rea'
      FieldName = 'DESARE'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLAptidoesCadastradosOBSCAD: TMemoField
      FieldName = 'OBSCAD'
      ProviderFlags = [pfInUpdate]
      Visible = False
      BlobType = ftMemo
    end
  end
  object DspAptidoesCadastrado: TDataSetProvider
    DataSet = SQLAptidoesCadastrados
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspAptidoesCadastradoGetDataSetProperties
    Left = 336
    Top = 32
  end
  object SQLFuncoesCadastrado: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 
      'select cad.codfuncad, cad.codcad, cad.codfun, fun.desfun,  cad.u' +
      'sures, cad.datcad from FUNCOES_CADASTRADO cad'#13#10'inner join FUNCOE' +
      'S fun on (fun.codfun = cad.codfun)'#13#10'and cad.codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 280
    Top = 96
    object SQLFuncoesCadastradoCODFUNCAD: TIntegerField
      FieldName = 'CODFUNCAD'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLFuncoesCadastradoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFuncoesCadastradoCODFUN: TIntegerField
      FieldName = 'CODFUN'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLFuncoesCadastradoDESFUN: TStringField
      DisplayLabel = 'Fun'#231#227'o'
      FieldName = 'DESFUN'
      ProviderFlags = []
      Required = True
      Size = 50
    end
    object SQLFuncoesCadastradoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 70
    end
    object SQLFuncoesCadastradoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object DspFuncoesCadastrado: TDataSetProvider
    DataSet = SQLFuncoesCadastrado
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspFuncoesCadastradoGetDataSetProperties
    Left = 336
    Top = 96
  end
  object SQLInfoMedicas: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 
      'select med.codinfmed, med.codcad, med.codenf, enf.nomenf,'#13#10'med.i' +
      'nfmed  from INFO_MED med '#13#10'inner join enfermidades enf on (enf.c' +
      'odenf = med.codenf)'#13#10'and med.codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 280
    Top = 168
    object SQLInfoMedicasCODINFMED: TIntegerField
      FieldName = 'CODINFMED'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLInfoMedicasCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLInfoMedicasCODENF: TIntegerField
      FieldName = 'CODENF'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLInfoMedicasNOMENF: TStringField
      DisplayLabel = 'Enfermidade'
      FieldName = 'NOMENF'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLInfoMedicasINFMED: TStringField
      DisplayLabel = 'Informa'#231#245'es'
      FieldName = 'INFMED'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      Size = 100
    end
  end
  object DspInfoMedicas: TDataSetProvider
    DataSet = SQLInfoMedicas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspInfoMedicasGetDataSetProperties
    Left = 336
    Top = 168
  end
  object SQLFamiliares: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 'select * from FAMILIARES where codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 280
    Top = 232
    object SQLFamiliaresCODFAM: TIntegerField
      FieldName = 'CODFAM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLFamiliaresCODCAD: TIntegerField
      FieldName = 'CODCAD'
      Required = True
      Visible = False
    end
    object SQLFamiliaresNOMFAM: TStringField
      DisplayLabel = 'Familiar'
      DisplayWidth = 50
      FieldName = 'NOMFAM'
      Required = True
      Size = 70
    end
    object SQLFamiliaresPARFAM: TStringField
      DisplayLabel = 'Parentesco'
      FieldName = 'PARFAM'
      Required = True
      Visible = False
      FixedChar = True
      Size = 3
    end
    object SQLFamiliaresTELFAM: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELFAM'
      Required = True
      Visible = False
      Size = 15
    end
    object SQLFamiliaresINDFAM: TStringField
      DisplayLabel = 'Aluno?'
      FieldName = 'INDFAM'
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLFamiliaresINDCAR: TStringField
      FieldName = 'INDCAR'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object DspFamiliares: TDataSetProvider
    DataSet = SQLFamiliares
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAptidoesUpdateError
    OnGetDataSetProperties = DspFamiliaresGetDataSetProperties
    Left = 336
    Top = 232
  end
  object SQLPesquisaConferencias: TSQLDataSet
    BeforeOpen = SQLDiscipuladosBeforeOpen
    CommandText = 
      'select codcon, nomcon, datini, datter, sigfoc, camcon, stacon fr' +
      'om viw_conferencias where codfoc = :codfoc and camcon = :camcon ' +
      'and'#13#10'  extract(year from datini) = :ano'#13#10'  order by datini desc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = 'camcon'
        ParamType = ptInput
        Size = 3
        Value = 'LEC'
      end
      item
        DataType = ftInteger
        Name = 'ano'
        ParamType = ptInput
        Value = 0
      end>
    Left = 280
    Top = 296
    object SQLPesquisaConferenciasCODCON: TIntegerField
      FieldName = 'CODCON'
      Visible = False
    end
    object SQLPesquisaConferenciasNOMCON: TStringField
      DisplayLabel = 'Confer'#234'ncia'
      FieldName = 'NOMCON'
      Size = 70
    end
    object SQLPesquisaConferenciasDATINI: TDateField
      DisplayLabel = 'In'#237'cio'
      FieldName = 'DATINI'
    end
    object SQLPesquisaConferenciasDATTER: TDateField
      DisplayLabel = 'T'#233'rmino'
      FieldName = 'DATTER'
    end
    object SQLPesquisaConferenciasSIGFOC: TStringField
      DisplayLabel = 'Promotor'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLPesquisaConferenciasCAMCON: TStringField
      DisplayLabel = 'Campo'
      FieldName = 'CAMCON'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLPesquisaConferenciasSTACON: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STACON'
      FixedChar = True
      Size = 1
    end
  end
  object DspPesquisaConferencias: TDataSetProvider
    DataSet = SQLPesquisaConferencias
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 344
    Top = 296
  end
end
