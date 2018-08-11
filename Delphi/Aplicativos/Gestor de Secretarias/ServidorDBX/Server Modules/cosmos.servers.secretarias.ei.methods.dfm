object CosmosSecEIServerMethods: TCosmosSecEIServerMethods
  OldCreateOrder = False
  Height = 389
  Width = 542
  object SQLLivrosEI: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select * from LIVROS_EI where coddis = :coddis and codliv = :cod' +
      'liv'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'coddis'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'codliv'
        ParamType = ptInput
        Value = 0
      end>
    Left = 48
    Top = 40
    object SQLLivrosEICODLIV: TIntegerField
      FieldName = 'CODLIV'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLLivrosEINOMLIV: TStringField
      FieldName = 'NOMLIV'
      Required = True
      Size = 15
    end
    object SQLLivrosEICODDIS: TIntegerField
      FieldName = 'CODDIS'
      Required = True
    end
    object SQLLivrosEIORDLIV: TSmallintField
      FieldName = 'ORDLIV'
    end
    object SQLLivrosEINOTLIV: TMemoField
      FieldName = 'NOTLIV'
      BlobType = ftMemo
      Size = 1
    end
  end
  object DspLivrosEI: TDataSetProvider
    DataSet = SQLLivrosEI
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspLivrosEIUpdateError
    OnGetDataSetProperties = DspLivrosEIGetDataSetProperties
    Left = 80
    Top = 40
  end
  object SQLLicoesEI: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select * from LICOES_EI where codliv = :codliv and codlic = :cod' +
      'lic'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codliv'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'codlic'
        ParamType = ptInput
        Value = 0
      end>
    Left = 48
    Top = 88
    object SQLLicoesEICODLIC: TIntegerField
      FieldName = 'CODLIC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLLicoesEINOMLIC: TStringField
      FieldName = 'NOMLIC'
      Required = True
      Size = 15
    end
    object SQLLicoesEITITLIC: TStringField
      FieldName = 'TITLIC'
      Size = 35
    end
    object SQLLicoesEICODLIV: TIntegerField
      FieldName = 'CODLIV'
      Required = True
    end
    object SQLLicoesEIORDLIC: TSmallintField
      FieldName = 'ORDLIC'
    end
    object SQLLicoesEINOTLIC: TMemoField
      FieldName = 'NOTLIC'
      BlobType = ftMemo
      Size = 1
    end
  end
  object DspLicoesEI: TDataSetProvider
    DataSet = SQLLicoesEI
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspLivrosEIUpdateError
    OnGetDataSetProperties = DspLicoesEIGetDataSetProperties
    Left = 80
    Top = 88
  end
  object SQLStProcedure: TSQLStoredProc
    BeforeOpen = SQLStProcedureBeforeOpen
    MaxBlobSize = -1
    Params = <>
    Left = 392
    Top = 37
  end
  object SQLCirculosEI: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select codgru, nomgru, sigdis, nomliv, nomlic'#13#10'from viw_circulos' +
      '_ei'#13#10'where codfoc = :codfoc and coddis = :coddis'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'coddis'
        ParamType = ptInput
        Value = 0
      end>
    Left = 48
    Top = 152
    object SQLCirculosEICODGRU: TIntegerField
      FieldName = 'CODGRU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object SQLCirculosEINOMGRU: TStringField
      DisplayLabel = 'C'#237'rculo'
      FieldName = 'NOMGRU'
      Size = 15
    end
    object SQLCirculosEISIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLCirculosEINOMLIV: TStringField
      DisplayLabel = 'Livro'
      FieldName = 'NOMLIV'
      Size = 15
    end
    object SQLCirculosEINOMLIC: TStringField
      DisplayLabel = 'Li'#231#227'o'
      FieldName = 'NOMLIC'
      Size = 15
    end
  end
  object DspCirculosEI: TDataSetProvider
    DataSet = SQLCirculosEI
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspLivrosEIUpdateError
    Left = 80
    Top = 152
  end
  object DspMembrosCirculo: TDataSetProvider
    DataSet = SQLMembrosCirculo
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspLivrosEIUpdateError
    OnGetTableName = DspMembrosCirculoGetTableName
    OnGetDataSetProperties = DspMembrosCirculoGetDataSetProperties
    Left = 80
    Top = 208
  end
  object SQLMembrosCirculo: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select mem.codmem, mem.codgru, mem.codcad, cad.matcad,'#13#10'cad.nomc' +
      'ad,'#13#10' case mem.indcon'#13#10'  when '#39'S'#39' then '#39'Sim'#39#13#10'  when '#39'N'#39' then '#39'N' +
      #227'o'#39#13#10' end as "indcon"'#13#10'from MEMBROS_GRUPOS_EI mem'#13#10'inner join CA' +
      'DASTRADOS cad on (cad.codcad = mem.codcad)'#13#10'and mem.codgru = :co' +
      'dgru order by cad.nomcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codgru'
        ParamType = ptInput
        Value = 0
      end>
    Left = 48
    Top = 208
    object SQLMembrosCirculoCODMEM: TIntegerField
      FieldName = 'CODMEM'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLMembrosCirculoCODGRU: TIntegerField
      FieldName = 'CODGRU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLMembrosCirculoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLMembrosCirculoMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Required = True
      Size = 10
    end
    object SQLMembrosCirculoNOMCAD: TStringField
      DisplayLabel = 'Aluno'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLMembrosCirculoINDCON: TStringField
      DisplayLabel = 'Contato'
      FieldName = 'INDCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
  end
  object SQLDadosCirculo: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select cir.codgru, cir.nomgru, cir.coddis, dis.nomdis, cir.codli' +
      'c, lic.nomlic, cir.sencon, cir.codsac,'#13#10'cad.nomcad as "NOMSAC", ' +
      'cir.codsaz, cad2.nomcad as "NOMSAZ", cir.datcad, cir.usures'#13#10'fro' +
      'm GRUPOS_EI cir'#13#10'inner join DISCIPULADOS dis on (dis.coddis = ci' +
      'r.coddis)'#13#10'inner join LICOES_EI lic on (cir.codlic = lic.codlic)' +
      #13#10'left outer join CADASTRADOS cad on (cad.codcad = cir.codsac)'#13#10 +
      'left outer join CADASTRADOS cad2 on (cad2.codcad = cir.codsaz)'#13#10 +
      'where cir.codgru = :codgru'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codgru'
        ParamType = ptInput
        Value = 0
      end>
    Left = 48
    Top = 256
    object SQLDadosCirculoCODGRU: TIntegerField
      FieldName = 'CODGRU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLDadosCirculoNOMGRU: TStringField
      FieldName = 'NOMGRU'
      Required = True
      Size = 15
    end
    object SQLDadosCirculoCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDadosCirculoNOMDIS: TStringField
      FieldName = 'NOMDIS'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDadosCirculoCODLIC: TIntegerField
      FieldName = 'CODLIC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDadosCirculoNOMLIC: TStringField
      FieldName = 'NOMLIC'
      ProviderFlags = []
      Required = True
      Size = 15
    end
    object SQLDadosCirculoSENCON: TStringField
      FieldName = 'SENCON'
      Required = True
      Size = 15
    end
    object SQLDadosCirculoCODSAC: TIntegerField
      FieldName = 'CODSAC'
    end
    object SQLDadosCirculoNOMSAC: TStringField
      FieldName = 'NOMSAC'
      ProviderFlags = []
      Size = 70
    end
    object SQLDadosCirculoCODSAZ: TIntegerField
      FieldName = 'CODSAZ'
    end
    object SQLDadosCirculoNOMSAZ: TStringField
      FieldName = 'NOMSAZ'
      ProviderFlags = []
      Size = 70
    end
    object SQLDadosCirculoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      Required = True
    end
    object SQLDadosCirculoUSURES: TStringField
      FieldName = 'USURES'
      Required = True
      FixedChar = True
      Size = 70
    end
  end
  object DspDadosCirculo: TDataSetProvider
    DataSet = SQLDadosCirculo
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetData = DspDadosCirculoGetData
    OnUpdateError = DspLivrosEIUpdateError
    Left = 80
    Top = 256
  end
  object SQLParticipantes: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select ati.codatidis, ati.codati, ati.coddis, dis.nomdis from at' +
      'ividades_discipulados ati'#13#10' inner join discipulados dis on (dis.' +
      'coddis = ati.coddis)'#13#10'and ati.codati = :codati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 184
    Top = 88
    object SQLParticipantesCODATIDIS: TIntegerField
      FieldName = 'CODATIDIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLParticipantesCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLParticipantesCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLParticipantesNOMDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'NOMDIS'
      ProviderFlags = []
      Required = True
      Size = 70
    end
  end
  object DspParticipantes: TDataSetProvider
    DataSet = SQLParticipantes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspLivrosEIUpdateError
    OnGetTableName = DspParticipantesGetTableName
    OnGetDataSetProperties = DspParticipantesGetDataSetProperties
    Left = 224
    Top = 88
  end
  object SQLMembrosEISearch: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select * from viw_membros_circulos where codgru = :codgru'#13#10'order' +
      ' by nomcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codgru'
        ParamType = ptInput
        Value = 0
      end>
    Left = 184
    Top = 40
  end
  object DspMembrosEISearch: TDataSetProvider
    DataSet = SQLParticipantes
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 224
    Top = 40
  end
  object SQLFocosParticipantes: TSQLDataSet
    BeforeOpen = SQLLivrosEIBeforeOpen
    CommandText = 
      'select ati.codatifoc, ati.codati, ati.codfoc, foc.nomfoc, foc.si' +
      'gfoc from atividades_focos ati'#13#10' inner join focos foc on (foc.co' +
      'dfoc = ati.codfoc)'#13#10' and ati.codati = :codati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 184
    Top = 136
    object SQLFocosParticipantesCODATIFOC: TIntegerField
      FieldName = 'CODATIFOC'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLFocosParticipantesCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFocosParticipantesCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFocosParticipantesNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLFocosParticipantesSIGFOC: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 4
    end
  end
  object DspFocosParticipantes: TDataSetProvider
    DataSet = SQLFocosParticipantes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspLivrosEIUpdateError
    OnGetTableName = DspFocosParticipantesGetTableName
    OnGetDataSetProperties = DspFocosParticipantesGetDataSetProperties
    Left = 224
    Top = 136
  end
end
