object DMSecAtividadesServerMethods: TDMSecAtividadesServerMethods
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 656
  Width = 797
  object SQLAgenda: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select * from VIW_ATIVIDADES'#13#10'where datati between :datini and :' +
      'datfin order by datati, horati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDateTime
        Name = 'datini'
        ParamType = ptInput
        Value = 0d
      end
      item
        DataType = ftDateTime
        Name = 'datfin'
        ParamType = ptInput
        Value = 0d
      end>
    Left = 32
    Top = 88
    object SQLAgendaCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLAgendaCODTIPATI: TIntegerField
      FieldName = 'CODTIPATI'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLAgendaDESTIPATI: TStringField
      DisplayLabel = 'Atividade'
      DisplayWidth = 35
      FieldName = 'DESTIPATI'
      ProviderFlags = []
      Size = 70
    end
    object SQLAgendaDATATI: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATATI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAgendaHORATI: TTimeField
      DisplayLabel = 'Hor'#225'rio'
      FieldName = 'HORATI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAgendaCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = []
      Visible = False
    end
    object SQLAgendaNOMCON: TStringField
      DisplayLabel = 'Confer'#234'ncia'
      DisplayWidth = 35
      FieldName = 'NOMCON'
      ProviderFlags = []
      Size = 70
    end
    object SQLAgendaTIPLEV: TStringField
      FieldName = 'TIPLEV'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 3
    end
    object SQLAgendaINDFRE: TStringField
      DisplayLabel = 'Freq'#252#234'ncia'
      FieldName = 'INDFRE'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLAgendaCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLAgendaSIGFOC: TStringField
      DisplayLabel = 'Promotor'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLAgendaCAMPRO: TStringField
      DisplayLabel = 'Campo'
      FieldName = 'CAMPRO'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLAgendaCODGRU: TIntegerField
      FieldName = 'CODGRU'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLAgendaINDESCINT: TStringField
      DisplayLabel = 'E.I.'
      DisplayWidth = 5
      FieldName = 'INDESCINT'
      FixedChar = True
      Size = 3
    end
  end
  object DspAgenda: TDataSetProvider
    DataSet = SQLAgenda
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAgendaGetTableName
    Left = 64
    Top = 88
  end
  object SQLTiposAtividades: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select codtipati, destipati, horati, campro, indfre, indescint, ' +
      'indest, indati from TIPOS_ATIVIDADES where indati = '#39'S'#39'  order b' +
      'y destipati'
    MaxBlobSize = -1
    Params = <>
    Left = 32
    Top = 136
    object SQLTiposAtividadesCODTIPATI: TIntegerField
      FieldName = 'CODTIPATI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLTiposAtividadesDESTIPATI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 30
      FieldName = 'DESTIPATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLTiposAtividadesHORATI: TTimeField
      DisplayLabel = 'Hor'#225'rio'
      FieldName = 'HORATI'
      ProviderFlags = [pfInUpdate]
      EditMask = '!90:00;1;_'
    end
    object SQLTiposAtividadesCAMPRO: TStringField
      DisplayLabel = 'Promotor'
      FieldName = 'CAMPRO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLTiposAtividadesINDFRE: TStringField
      FieldName = 'INDFRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLTiposAtividadesINDESCINT: TStringField
      DisplayLabel = 'E.I.'
      FieldName = 'INDESCINT'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLTiposAtividadesINDEST: TStringField
      FieldName = 'INDEST'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLTiposAtividadesINDATI: TStringField
      DisplayLabel = 'Ativa'
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspTiposAtividades: TDataSetProvider
    DataSet = SQLTiposAtividades
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspTiposAtividadesGetTableName
    OnGetDataSetProperties = DspTiposAtividadesGetDataSetProperties
    Left = 64
    Top = 137
  end
  object SQLLivrosEI: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 192
    Top = 16
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
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspLivrosEIGetDataSetProperties
    Left = 224
    Top = 16
  end
  object SQLLicoesEI: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 192
    Top = 64
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
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspLicoesEIGetDataSetProperties
    Left = 224
    Top = 64
  end
  object SQLAlocucoes: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select alo.codalo, alo.titalo, alo.nomaut, ati.datati  from ALOC' +
      'UCOES alo left outer join atividades ati on(ati.codalo = alo.cod' +
      'alo)'
    MaxBlobSize = -1
    Params = <>
    Left = 352
    Top = 464
    object SQLAlocucoesCODALO: TIntegerField
      FieldName = 'CODALO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLAlocucoesTITALO: TStringField
      DisplayLabel = 'T'#237'tulo'
      DisplayWidth = 50
      FieldName = 'TITALO'
      Required = True
      Size = 50
    end
    object SQLAlocucoesNOMAUT: TStringField
      DisplayLabel = 'Autor'
      FieldName = 'NOMAUT'
      Size = 35
    end
    object SQLAlocucoesDATATI: TDateField
      DisplayLabel = 'Proferida em'
      FieldName = 'DATATI'
    end
  end
  object DspAlocucoes: TDataSetProvider
    DataSet = SQLAlocucoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspAlocucoesGetDataSetProperties
    Left = 384
    Top = 464
  end
  object SQLAlocucao: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 'select * from ALOCUCOES where codalo = :codalo'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codalo'
        ParamType = ptInput
        Value = 0
      end>
    Left = 352
    Top = 416
    object SQLAlocucaoCODALO: TIntegerField
      FieldName = 'CODALO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLAlocucaoTITALO: TStringField
      DisplayLabel = 'T'#237'tulo'
      DisplayWidth = 50
      FieldName = 'TITALO'
      Required = True
      Size = 50
    end
    object SQLAlocucaoFRAALO: TStringField
      DisplayLabel = 'Abertura'
      FieldName = 'FRAALO'
      Required = True
      Size = 50
    end
    object SQLAlocucaoNOMAUT: TStringField
      DisplayLabel = 'Autor'
      FieldName = 'NOMAUT'
      Size = 35
    end
    object SQLAlocucaoINDLEC: TStringField
      FieldName = 'INDLEC'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlocucaoINDTMO: TStringField
      FieldName = 'INDTMO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlocucaoINDTMB: TStringField
      FieldName = 'INDTMB'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlocucaoINDTPU: TStringField
      FieldName = 'INDTPU'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlocucaoNOTALO: TMemoField
      DisplayLabel = 'Notas'
      FieldName = 'NOTALO'
      BlobType = ftMemo
      Size = 1
    end
  end
  object DspAlocucao: TDataSetProvider
    DataSet = SQLAlocucao
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspAlocucoesGetDataSetProperties
    Left = 384
    Top = 416
  end
  object SQLAtividadesTurmasTP: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select ati.codati, ati.codtipati, tip.destipati, ati.datati, ati' +
      '.horati, ati.numtem from atividades ati'#13#10'inner join tipos_ativid' +
      'ades tip on (ati.codtipati = tip.codtipati)'#13#10'where ati.codtur = ' +
      ':codtur'#13#10'order by ati.datati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtur'
        ParamType = ptInput
        Value = 0
      end>
    Left = 24
    Top = 304
    object SQLAtividadesTurmasTPCODATI: TIntegerField
      FieldName = 'CODATI'
      Required = True
      Visible = False
    end
    object SQLAtividadesTurmasTPCODTIPATI: TIntegerField
      FieldName = 'CODTIPATI'
      Required = True
      Visible = False
    end
    object SQLAtividadesTurmasTPDESTIPATI: TStringField
      DisplayLabel = 'Atividade'
      FieldName = 'DESTIPATI'
      Required = True
      Size = 70
    end
    object SQLAtividadesTurmasTPDATATI: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATATI'
      Required = True
    end
    object SQLAtividadesTurmasTPHORATI: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'HORATI'
      Required = True
    end
    object SQLAtividadesTurmasTPNUMTEM: TSmallintField
      DisplayLabel = 'Tema'
      FieldName = 'NUMTEM'
    end
  end
  object DspAtividadesTurmasTP: TDataSetProvider
    DataSet = SQLAtividadesTurmasTP
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAgendaGetTableName
    Left = 56
    Top = 304
  end
  object SQLCirculosEI: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 192
    Top = 120
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
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspCirculosEIGetTableName
    OnGetDataSetProperties = DspCirculosEIGetDataSetProperties
    Left = 224
    Top = 120
  end
  object DspMembrosCirculo: TDataSetProvider
    DataSet = SQLMembrosCirculo
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspMembrosCirculoGetTableName
    OnGetDataSetProperties = DspMembrosCirculoGetDataSetProperties
    Left = 224
    Top = 176
  end
  object SQLMembrosCirculo: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 192
    Top = 176
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
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 192
    Top = 224
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
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspDadosCirculoGetTableName
    Left = 224
    Top = 224
  end
  object DspAluno: TDataSetProvider
    DataSet = SQLAluno
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAlunoGetTableName
    OnGetDataSetProperties = DspAlunoGetDataSetProperties
    Left = 224
    Top = 352
  end
  object SQLAluno: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select cad.codcad, cad.matcad, cad.nomcad, cad.apecad, cad.sexca' +
      'd, cad.datnas,'#13#10'cad.naccad, cad.docide, cad.orgexp, cad.estciv, ' +
      'cad.fotcad, cad.codpro,'#13#10'pro.despro, cad.codfoc, cad.coddis, dis' +
      '.sigdis, cad.cadtit, tit.nomcad as "NOMTIT",'#13#10'cad.indextnuc, cad' +
      '.indgrujov, cad.indligroz, cad.indati, cad.indfre,'#13#10'cad.indlic, ' +
      'cad.indmen, cad.valmen, cad.valtax, cad.datobi, cad.obscad, cad.' +
      'usures,'#13#10'cad.datcad'#13#10#13#10'from cadastrados cad'#13#10'inner join profisso' +
      'es pro on (pro.codpro = cad.codpro)'#13#10'inner join discipulados dis' +
      ' on (dis.coddis = cad.coddis)'#13#10'left outer join cadastrados tit o' +
      'n (cad.cadtit = tit.codcad)'#13#10'where cad.codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 352
    object SQLAlunoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLAlunoMATCAD: TStringField
      FieldName = 'MATCAD'
      Required = True
      Size = 10
    end
    object SQLAlunoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      Required = True
      Size = 70
    end
    object SQLAlunoAPECAD: TStringField
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLAlunoSEXCAD: TStringField
      FieldName = 'SEXCAD'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoDATNAS: TDateField
      FieldName = 'DATNAS'
      Required = True
    end
    object SQLAlunoNACCAD: TStringField
      FieldName = 'NACCAD'
      Required = True
      Size = 25
    end
    object SQLAlunoDOCIDE: TStringField
      FieldName = 'DOCIDE'
      Required = True
      Size = 15
    end
    object SQLAlunoORGEXP: TStringField
      FieldName = 'ORGEXP'
      Required = True
      FixedChar = True
      Size = 25
    end
    object SQLAlunoESTCIV: TStringField
      FieldName = 'ESTCIV'
      FixedChar = True
      Size = 3
    end
    object SQLAlunoFOTCAD: TGraphicField
      FieldName = 'FOTCAD'
      BlobType = ftGraphic
    end
    object SQLAlunoCODPRO: TIntegerField
      FieldName = 'CODPRO'
    end
    object SQLAlunoDESPRO: TStringField
      FieldName = 'DESPRO'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLAlunoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Required = True
    end
    object SQLAlunoCODDIS: TIntegerField
      FieldName = 'CODDIS'
      Required = True
    end
    object SQLAlunoSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLAlunoCADTIT: TIntegerField
      FieldName = 'CADTIT'
    end
    object SQLAlunoNOMTIT: TStringField
      DisplayLabel = 'Titular'
      FieldName = 'NOMTIT'
      ProviderFlags = []
      Size = 70
    end
    object SQLAlunoINDEXTNUC: TStringField
      FieldName = 'INDEXTNUC'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDGRUJOV: TStringField
      FieldName = 'INDGRUJOV'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDLIGROZ: TStringField
      FieldName = 'INDLIGROZ'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDATI: TStringField
      FieldName = 'INDATI'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDFRE: TStringField
      FieldName = 'INDFRE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDLIC: TStringField
      FieldName = 'INDLIC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDMEN: TStringField
      FieldName = 'INDMEN'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoVALMEN: TFMTBCDField
      FieldName = 'VALMEN'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLAlunoVALTAX: TFMTBCDField
      FieldName = 'VALTAX'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLAlunoDATOBI: TDateField
      FieldName = 'DATOBI'
    end
    object SQLAlunoOBSCAD: TMemoField
      FieldName = 'OBSCAD'
      BlobType = ftMemo
    end
    object SQLAlunoUSURES: TStringField
      FieldName = 'USURES'
      FixedChar = True
      Size = 70
    end
    object SQLAlunoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
    end
  end
  object SQLFuncoesCadastrado: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 32
    Top = 552
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
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspFuncoesCadastradoGetTableName
    OnGetDataSetProperties = DspFuncoesCadastradoGetDataSetProperties
    Left = 64
    Top = 552
  end
  object DspDispensas: TDataSetProvider
    DataSet = SQLDispensas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspDispensasGetDataSetProperties
    Left = 224
    Top = 545
  end
  object SQLDispensas: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 'select * from dispensas where codcad = :codcad'#13#10'order by inidis'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 545
    object SQLDispensasCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLDispensasCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLDispensasINIDIS: TDateField
      DisplayLabel = 'In'#237'cio'
      FieldName = 'INIDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDispensasTERDIS: TDateField
      DisplayLabel = 'T'#233'rmino'
      FieldName = 'TERDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDispensasDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLDispensasUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 70
    end
  end
  object SQLTarefas: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 'select * from TAREFAS'
    MaxBlobSize = -1
    Params = <>
    Left = 32
    Top = 472
  end
  object DspTarefas: TDataSetProvider
    DataSet = SQLTarefas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 64
    Top = 472
  end
  object SQLAtividadeLEC: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select ati.codati, ati.codtipati, tip.destipati, tip.campro, ati' +
      '.codfoc, ati.datati, ati.horati, ati.locati, ati.codcon, con.nom' +
      'con,'#13#10'ati.indfre, ati.codalo, alo.titalo, ati.indjal, ati.indlis' +
      ', ati.obsati, ati.usures, ati.datcad'#13#10'from atividades ati'#13#10' left' +
      ' outer join conferencias con on (con.codcon = ati.codcon)'#13#10' left' +
      ' outer join alocucoes alo on (alo.codalo = ati.codalo)'#13#10' inner j' +
      'oin tipos_atividades tip on(tip.codtipati = ati.codtipati)'#13#10'and ' +
      'ati.codati = :codati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 24
    Top = 360
    object SQLAtividadeLECCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLAtividadeLECCODTIPATI: TIntegerField
      FieldName = 'CODTIPATI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeLECDESTIPATI: TStringField
      FieldName = 'DESTIPATI'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLAtividadeLECCAMPRO: TStringField
      FieldName = 'CAMPRO'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLAtividadeLECCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeLECDATATI: TDateField
      FieldName = 'DATATI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeLECHORATI: TTimeField
      FieldName = 'HORATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '!90:00;1;_'
    end
    object SQLAtividadeLECLOCATI: TStringField
      FieldName = 'LOCATI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object SQLAtividadeLECCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAtividadeLECNOMCON: TStringField
      FieldName = 'NOMCON'
      ProviderFlags = []
      Size = 70
    end
    object SQLAtividadeLECINDFRE: TStringField
      FieldName = 'INDFRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeLECCODALO: TIntegerField
      FieldName = 'CODALO'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAtividadeLECTITALO: TStringField
      FieldName = 'TITALO'
      ProviderFlags = []
      Size = 50
    end
    object SQLAtividadeLECINDJAL: TStringField
      FieldName = 'INDJAL'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeLECINDLIS: TStringField
      FieldName = 'INDLIS'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeLECOBSATI: TMemoField
      FieldName = 'OBSATI'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
    object SQLAtividadeLECUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
    object SQLAtividadeLECDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DspAtividadeLEC: TDataSetProvider
    DataSet = SQLAtividadeLEC
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAgendaGetTableName
    OnGetDataSetProperties = DspAtividadeLECGetDataSetProperties
    Left = 56
    Top = 360
  end
  object SQLParticipantes: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select ati.codatidis, ati.codati, ati.coddis, dis.nomdis from at' +
      'ividades_discipulados ati'#13#10' inner join discipulados dis on (dis.' +
      'coddis = ati.coddis)'#13#10'and ati.codati = :codati order by dis.seqd' +
      'is'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 528
    Top = 224
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
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspParticipantesGetTableName
    OnGetDataSetProperties = DspParticipantesGetDataSetProperties
    Left = 560
    Top = 224
  end
  object SQLEscalas: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select esc.codesc, esc.codati, esc.codcad, cad.nomcad, esc.codti' +
      'patu, tip.destipatu'#13#10'from escalas_atividades esc'#13#10'inner join cad' +
      'astrados cad on (cad.codcad = esc.codcad)'#13#10'inner join tipos_atua' +
      'cao tip on (tip.codtipatu = esc.codtipatu)'#13#10'and esc.codati = :co' +
      'dati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 600
    object SQLEscalasCODESC: TIntegerField
      FieldName = 'CODESC'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLEscalasCODATI: TIntegerField
      FieldName = 'CODATI'
      Required = True
      Visible = False
    end
    object SQLEscalasCODCAD: TIntegerField
      FieldName = 'CODCAD'
      Required = True
      Visible = False
    end
    object SQLEscalasNOMCAD: TStringField
      DisplayLabel = 'Aluno'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLEscalasCODTIPATU: TIntegerField
      FieldName = 'CODTIPATU'
      Required = True
      Visible = False
    end
    object SQLEscalasDESTIPATU: TStringField
      DisplayLabel = 'Fun'#231#227'o'
      FieldName = 'DESTIPATU'
      ProviderFlags = []
      Required = True
      Size = 70
    end
  end
  object DspEscalas: TDataSetProvider
    DataSet = SQLEscalas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateData = DspEscalasUpdateData
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspEscalasGetTableName
    OnGetDataSetProperties = DspEscalasGetDataSetProperties
    Left = 224
    Top = 600
  end
  object SQLFrequencias: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select fre.codfre, fre.codati, fre.codcad, cad.matcad, cad.nomca' +
      'd, cad.sigfoc, fre.indpre, fre.indjusace, cad.matcadint, cad.sig' +
      'dis'#13#10'from frequencias fre'#13#10'inner join viw_cadastrados cad on (ca' +
      'd.codcad = fre.codcad)'#13#10'and fre.codati = :codati order by cad.ma' +
      'tcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 352
    Top = 64
    object SQLFrequenciasCODFRE: TLargeintField
      FieldName = 'CODFRE'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLFrequenciasCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFrequenciasCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFrequenciasMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Required = True
      Size = 10
    end
    object SQLFrequenciasNOMCAD: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLFrequenciasSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLFrequenciasSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLFrequenciasINDPRE: TStringField
      DisplayLabel = 'Presente'
      FieldName = 'INDPRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFrequenciasINDJUSACE: TStringField
      DisplayLabel = 'Justificado'
      FieldName = 'INDJUSACE'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLFrequenciasMATCADINT: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      Visible = False
    end
  end
  object DspFrequencias: TDataSetProvider
    DataSet = SQLFrequencias
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspFrequenciasGetTableName
    OnGetDataSetProperties = DspFrequenciasGetDataSetProperties
    Left = 384
    Top = 64
  end
  object SQLAtividadeEI: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select ati.codati, ati.codtipati, tip.destipati, tip.campro, ati' +
      '.codfoc, ati.datati, ati.horati, ati.locati, ati.indfre, ati.cod' +
      'gru, gru.nomgru, ati.codlic, lic.nomlic, ati.indjal, ati.indlis,' +
      ' ati.obsati, ati.usures, ati.datcad'#13#10'from atividades ati'#13#10' left ' +
      'outer join grupos_ei gru on (gru.codgru = ati.codgru)'#13#10' left out' +
      'er join licoes_ei lic on (lic.codlic = ati.codlic)'#13#10' inner join ' +
      'tipos_atividades tip on(tip.codtipati = ati.codtipati)'#13#10'and ati.' +
      'codati = :codati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 24
    Top = 416
    object SQLAtividadeEICODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLAtividadeEICODTIPATI: TIntegerField
      FieldName = 'CODTIPATI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeEIDESTIPATI: TStringField
      FieldName = 'DESTIPATI'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLAtividadeEICAMPRO: TStringField
      FieldName = 'CAMPRO'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLAtividadeEICODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeEIDATATI: TDateField
      FieldName = 'DATATI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeEIHORATI: TTimeField
      FieldName = 'HORATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '!90:00;1;_'
    end
    object SQLAtividadeEILOCATI: TStringField
      FieldName = 'LOCATI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object SQLAtividadeEIINDFRE: TStringField
      FieldName = 'INDFRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeEICODGRU: TIntegerField
      FieldName = 'CODGRU'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAtividadeEINOMGRU: TStringField
      FieldName = 'NOMGRU'
      ProviderFlags = []
      Size = 15
    end
    object SQLAtividadeEICODLIC: TIntegerField
      FieldName = 'CODLIC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAtividadeEINOMLIC: TStringField
      FieldName = 'NOMLIC'
      ProviderFlags = []
      Size = 15
    end
    object SQLAtividadeEIINDJAL: TStringField
      FieldName = 'INDJAL'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeEIINDLIS: TStringField
      FieldName = 'INDLIS'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeEIOBSATI: TMemoField
      FieldName = 'OBSATI'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
    object SQLAtividadeEIUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
    object SQLAtividadeEIDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DspAtividadeEI: TDataSetProvider
    DataSet = SQLAtividadeEI
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAgendaGetTableName
    OnGetDataSetProperties = DspAtividadeLECGetDataSetProperties
    Left = 56
    Top = 416
  end
  object SQLAtividadeTP: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select ati.codati, ati.codtipati, tip.destipati, tip.campro, ati' +
      '.codfoc, ati.datati, ati.horati, ati.locati, ati.indfre, ati.cod' +
      'alo, alo.titalo, ati.codtur, tur.numtur, ati.numtem, ati.indjal,' +
      ' ati.indlis, ati.obsati, ati.usures, ati.datcad'#13#10'from atividades' +
      ' ati'#13#10' left outer join alocucoes alo on (alo.codalo = ati.codalo' +
      ')'#13#10' left outer join turmas_tp tur on (tur.codtur = ati.codtur)'#13#10 +
      ' inner join tipos_atividades tip on(tip.codtipati = ati.codtipat' +
      'i)'#13#10'and ati.codati = :codati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 192
    object SQLAtividadeTPCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLAtividadeTPCODTIPATI: TIntegerField
      FieldName = 'CODTIPATI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeTPDESTIPATI: TStringField
      FieldName = 'DESTIPATI'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLAtividadeTPCAMPRO: TStringField
      FieldName = 'CAMPRO'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLAtividadeTPCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeTPDATATI: TDateField
      FieldName = 'DATATI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAtividadeTPHORATI: TTimeField
      FieldName = 'HORATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '!90:00;1;_'
    end
    object SQLAtividadeTPLOCATI: TStringField
      FieldName = 'LOCATI'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object SQLAtividadeTPCODALO: TIntegerField
      FieldName = 'CODALO'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAtividadeTPTITALO: TStringField
      FieldName = 'TITALO'
      ProviderFlags = []
      Size = 50
    end
    object SQLAtividadeTPCODTUR: TIntegerField
      FieldName = 'CODTUR'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAtividadeTPNUMTUR: TIntegerField
      FieldName = 'NUMTUR'
      ProviderFlags = []
    end
    object SQLAtividadeTPNUMTEM: TSmallintField
      FieldName = 'NUMTEM'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAtividadeTPINDFRE: TStringField
      FieldName = 'INDFRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeTPINDJAL: TStringField
      FieldName = 'INDJAL'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeTPINDLIS: TStringField
      FieldName = 'INDLIS'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAtividadeTPOBSATI: TMemoField
      FieldName = 'OBSATI'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
    object SQLAtividadeTPUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
    object SQLAtividadeTPDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DspAtividadeTP: TDataSetProvider
    DataSet = SQLAtividadeTP
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAtividadeTPGetTableName
    OnGetDataSetProperties = DspAtividadeLECGetDataSetProperties
    Left = 64
    Top = 192
  end
  object SQLMembrosEISearch: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 192
    Top = 280
  end
  object DspMembrosEISearch: TDataSetProvider
    DataSet = SQLMembrosEISearch
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 224
    Top = 280
  end
  object SQLMembros: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  ((nomcad collate PT_BR starting with '#39'A'#39') or'#13#10'  (nomcad c' +
      'ollate PT_BR starting with '#39'B'#39'))'#13#10'  and codfoc = 6'#13#10'  and indati' +
      ' = '#39'S'#39#13#10'  and camdis = '#39'TMB'#39#13#10'  order by nomcad'
    MaxBlobSize = -1
    Params = <>
    Left = 192
    Top = 448
    object SQLMembrosCODCAD: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object SQLMembrosMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object SQLMembrosNOMCAD: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLMembrosAPECAD: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLMembrosDATNAS: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object SQLMembrosSEXCAD: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object SQLMembrosSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLMembrosINDESCINT: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLMembrosSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLMembrosINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInWhere]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLMembrosMATCADINT: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      Visible = False
    end
  end
  object DspMembros: TDataSetProvider
    DataSet = SQLMembros
    Options = [poIncFieldProps, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAlunoGetTableName
    OnGetDataSetProperties = DspAlunoGetDataSetProperties
    Left = 224
    Top = 448
  end
  object SQLReports: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 32
    Top = 16
  end
  object DspReports: TDataSetProvider
    DataSet = SQLReports
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 64
    Top = 16
  end
  object DspMembro: TDataSetProvider
    DataSet = SQLMembro
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAlunoGetTableName
    OnGetDataSetProperties = DspAlunoGetDataSetProperties
    Left = 224
    Top = 496
  end
  object SQLMembro: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select cad.codcad, cad.matcad, cad.nomcad, cad.apecad, cad.sexca' +
      'd, cad.datnas,'#13#10'cad.naccad, cad.docide, cad.orgexp, cad.estciv, ' +
      'cad.fotcad, cad.codpro,'#13#10'pro.despro, cad.codfoc, cad.coddis, dis' +
      '.sigdis, cad.cadtit, tit.nomcad as "NOMTIT",'#13#10'cad.indextnuc, cad' +
      '.indgrujov, cad.indligroz, cad.indati, cad.indfre,'#13#10'cad.indlic, ' +
      'cad.indimp, cad.indmen, cad.valmen, cad.valtax, cad.datobi, cad.' +
      'obscad, cad.usures,'#13#10'cad.datcad'#13#10#13#10'from cadastrados cad'#13#10'inner j' +
      'oin discipulados dis on (dis.coddis = cad.coddis)'#13#10'left outer jo' +
      'in profissoes pro on (cad.codpro = pro.codpro)'#13#10'left outer join ' +
      'cadastrados tit on (cad.cadtit = tit.codcad)'#13#10'where cad.codcad =' +
      ' :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 496
    object SQLMembroCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInWhere, pfInKey]
      Required = True
    end
    object SQLMembroMATCAD: TStringField
      FieldName = 'MATCAD'
      Required = True
      Size = 10
    end
    object SQLMembroNOMCAD: TStringField
      FieldName = 'NOMCAD'
      Required = True
      Size = 70
    end
    object SQLMembroAPECAD: TStringField
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLMembroSEXCAD: TStringField
      FieldName = 'SEXCAD'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroDATNAS: TDateField
      FieldName = 'DATNAS'
      Required = True
    end
    object SQLMembroNACCAD: TStringField
      FieldName = 'NACCAD'
      Required = True
      Size = 25
    end
    object SQLMembroDOCIDE: TStringField
      FieldName = 'DOCIDE'
      Required = True
      Size = 15
    end
    object SQLMembroORGEXP: TStringField
      FieldName = 'ORGEXP'
      Required = True
      FixedChar = True
      Size = 25
    end
    object SQLMembroESTCIV: TStringField
      FieldName = 'ESTCIV'
      FixedChar = True
      Size = 3
    end
    object SQLMembroFOTCAD: TGraphicField
      FieldName = 'FOTCAD'
      BlobType = ftGraphic
    end
    object SQLMembroCODPRO: TIntegerField
      FieldName = 'CODPRO'
    end
    object SQLMembroDESPRO: TStringField
      FieldName = 'DESPRO'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLMembroCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Required = True
    end
    object SQLMembroCODDIS: TIntegerField
      FieldName = 'CODDIS'
      Required = True
    end
    object SQLMembroSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLMembroCADTIT: TIntegerField
      FieldName = 'CADTIT'
    end
    object SQLMembroNOMTIT: TStringField
      DisplayLabel = 'Titular'
      FieldName = 'NOMTIT'
      ProviderFlags = []
      Size = 70
    end
    object SQLMembroINDEXTNUC: TStringField
      FieldName = 'INDEXTNUC'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroINDGRUJOV: TStringField
      FieldName = 'INDGRUJOV'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroINDLIGROZ: TStringField
      FieldName = 'INDLIGROZ'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroINDATI: TStringField
      FieldName = 'INDATI'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroINDFRE: TStringField
      FieldName = 'INDFRE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroINDLIC: TStringField
      FieldName = 'INDLIC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroINDIMP: TStringField
      FieldName = 'INDIMP'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLMembroINDMEN: TStringField
      FieldName = 'INDMEN'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMembroVALMEN: TFMTBCDField
      FieldName = 'VALMEN'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLMembroVALTAX: TFMTBCDField
      FieldName = 'VALTAX'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLMembroDATOBI: TDateField
      FieldName = 'DATOBI'
    end
    object SQLMembroOBSCAD: TMemoField
      FieldName = 'OBSCAD'
      BlobType = ftMemo
    end
    object SQLMembroUSURES: TStringField
      FieldName = 'USURES'
      FixedChar = True
      Size = 70
    end
    object SQLMembroDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
    end
  end
  object DspJovemTM: TDataSetProvider
    DataSet = SQLJovemTM
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAlunoGetTableName
    OnGetDataSetProperties = DspAlunoGetDataSetProperties
    Left = 224
    Top = 400
  end
  object SQLJovemTM: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select cad.codcad, cad.matcad, cad.nomcad, cad.apecad, cad.sexca' +
      'd, cad.datnas,'#13#10'cad.naccad, cad.docide, cad.orgexp, cad.estciv, ' +
      'cad.fotcad, cad.codpro,'#13#10'pro.despro, cad.codfoc, cad.coddis, dis' +
      '.sigdis, cad.cadtit, tit.nomcad as "NOMTIT",'#13#10'cad.indextnuc,  ca' +
      'd.indligroz, cad.indati, cad.indfre,'#13#10'cad.valmen, cad.valtax, ca' +
      'd.datobi, cad.obscad, cad.usures,'#13#10'cad.datcad'#13#10#13#10'from cadastrado' +
      's cad'#13#10'inner join discipulados dis on (dis.coddis = cad.coddis)'#13 +
      #10'left outer join profissoes pro on (pro.codpro = cad.codpro)'#13#10'le' +
      'ft outer join cadastrados tit on (cad.cadtit = tit.codcad)'#13#10'wher' +
      'e cad.codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 400
    object SQLJovemTMCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLJovemTMMATCAD: TStringField
      FieldName = 'MATCAD'
      Required = True
      Size = 10
    end
    object SQLJovemTMNOMCAD: TStringField
      FieldName = 'NOMCAD'
      Required = True
      Size = 70
    end
    object SQLJovemTMAPECAD: TStringField
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLJovemTMSEXCAD: TStringField
      FieldName = 'SEXCAD'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLJovemTMDATNAS: TDateField
      FieldName = 'DATNAS'
      Required = True
    end
    object SQLJovemTMNACCAD: TStringField
      FieldName = 'NACCAD'
      Required = True
      Size = 25
    end
    object SQLJovemTMDOCIDE: TStringField
      FieldName = 'DOCIDE'
      Required = True
      Size = 15
    end
    object SQLJovemTMORGEXP: TStringField
      FieldName = 'ORGEXP'
      Required = True
      FixedChar = True
      Size = 25
    end
    object SQLJovemTMESTCIV: TStringField
      FieldName = 'ESTCIV'
      FixedChar = True
      Size = 3
    end
    object SQLJovemTMFOTCAD: TGraphicField
      FieldName = 'FOTCAD'
      BlobType = ftGraphic
    end
    object SQLJovemTMCODPRO: TIntegerField
      FieldName = 'CODPRO'
    end
    object SQLJovemTMDESPRO: TStringField
      FieldName = 'DESPRO'
      ProviderFlags = []
      Size = 70
    end
    object SQLJovemTMCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Required = True
    end
    object SQLJovemTMCODDIS: TIntegerField
      FieldName = 'CODDIS'
      Required = True
    end
    object SQLJovemTMSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLJovemTMCADTIT: TIntegerField
      FieldName = 'CADTIT'
    end
    object SQLJovemTMNOMTIT: TStringField
      DisplayLabel = 'Titular'
      FieldName = 'NOMTIT'
      ProviderFlags = []
      Size = 70
    end
    object SQLJovemTMINDEXTNUC: TStringField
      FieldName = 'INDEXTNUC'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLJovemTMINDLIGROZ: TStringField
      FieldName = 'INDLIGROZ'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLJovemTMINDATI: TStringField
      FieldName = 'INDATI'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLJovemTMINDFRE: TStringField
      FieldName = 'INDFRE'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLJovemTMVALMEN: TFMTBCDField
      FieldName = 'VALMEN'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLJovemTMVALTAX: TFMTBCDField
      FieldName = 'VALTAX'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLJovemTMDATOBI: TDateField
      FieldName = 'DATOBI'
    end
    object SQLJovemTMOBSCAD: TMemoField
      FieldName = 'OBSCAD'
      BlobType = ftMemo
    end
    object SQLJovemTMUSURES: TStringField
      FieldName = 'USURES'
      FixedChar = True
      Size = 70
    end
    object SQLJovemTMDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
    end
  end
  object SQLAtividadeFrequencia: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select ati.codati, ati.destipati, ati.datati, ati.horati, ati.co' +
      'dfoc, ati.sigfoc, ati.campro, ati.indfre from viw_atividades ati' +
      ' where ati.codati = :codati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 356
    Top = 168
    object SQLAtividadeFrequenciaCODATI: TIntegerField
      FieldName = 'CODATI'
    end
    object SQLAtividadeFrequenciaDESTIPATI: TStringField
      FieldName = 'DESTIPATI'
      Size = 70
    end
    object SQLAtividadeFrequenciaDATATI: TDateField
      FieldName = 'DATATI'
    end
    object SQLAtividadeFrequenciaHORATI: TTimeField
      FieldName = 'HORATI'
    end
    object SQLAtividadeFrequenciaCODFOC: TIntegerField
      FieldName = 'CODFOC'
    end
    object SQLAtividadeFrequenciaSIGFOC: TStringField
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLAtividadeFrequenciaCAMPRO: TStringField
      FieldName = 'CAMPRO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLAtividadeFrequenciaINDFRE: TStringField
      FieldName = 'INDFRE'
      FixedChar = True
      Size = 1
    end
  end
  object DspAtividadeFrequencia: TDataSetProvider
    DataSet = SQLAtividadeFrequencia
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspFrequenciasGetDataSetProperties
    Left = 388
    Top = 168
  end
  object SQLFocosParticipantes: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
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
    Left = 528
    Top = 272
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
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspFocosParticipantesGetTableName
    OnGetDataSetProperties = DspFocosParticipantesGetDataSetProperties
    Left = 560
    Top = 272
  end
  object SQLConferencia: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select conf.codcon, conf.nomcon, foc.nomfoc, conf.camcon, conf.v' +
      'altax, conf.limins, conf.datini, conf.datter,'#13#10' conf.horini, con' +
      'f.horter, conf.datlim, conf.indesp, conf.stacon,'#13#10' conf.indmod, ' +
      'conf.tiplev, conf.mesref, conf.obscon, conf.datcad, conf.usures'#13 +
      #10'from conferencias conf'#13#10'inner join focos foc on (foc.codfoc = c' +
      'onf.codfoc)'#13#10'and conf.codcon = :codcon'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 536
    Top = 328
    object SQLConferenciaCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLConferenciaNOMCON: TStringField
      FieldName = 'NOMCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLConferenciaNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      ReadOnly = True
      Required = True
      Size = 70
    end
    object SQLConferenciaCAMCON: TStringField
      FieldName = 'CAMCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLConferenciaVALTAX: TFMTBCDField
      FieldName = 'VALTAX'
      ProviderFlags = [pfInUpdate]
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLConferenciaLIMINS: TSmallintField
      CustomConstraint = 'LIMINS > 0 or LIMINS is null'
      ConstraintErrorMessage = 'O limite m'#225'ximo de inscritos deve ser maior do que zero!'
      FieldName = 'LIMINS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLConferenciaDATINI: TDateField
      FieldName = 'DATINI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999;1;_'
    end
    object SQLConferenciaDATTER: TDateField
      CustomConstraint = 'DATTER >= DATINI'
      ConstraintErrorMessage = 
        'A data de t'#233'rmino da confer'#234'ncia deve ser posterior '#224' do seu in'#237 +
        'cio!'
      FieldName = 'DATTER'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999;1;_'
    end
    object SQLConferenciaHORINI: TTimeField
      FieldName = 'HORINI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '!90:00;1;_'
    end
    object SQLConferenciaHORTER: TTimeField
      FieldName = 'HORTER'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '!90:00;1;_'
    end
    object SQLConferenciaDATLIM: TDateField
      CustomConstraint = 'DATLIM <= DATTER'
      ConstraintErrorMessage = 
        'A data-limite das inscri'#231#245'es n'#227'o pode ser posterior '#224' confer'#234'nci' +
        'a!'
      FieldName = 'DATLIM'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999;1;_'
    end
    object SQLConferenciaINDESP: TStringField
      FieldName = 'INDESP'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLConferenciaSTACON: TStringField
      FieldName = 'STACON'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLConferenciaINDMOD: TStringField
      FieldName = 'INDMOD'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLConferenciaTIPLEV: TStringField
      FieldName = 'TIPLEV'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLConferenciaMESREF: TSmallintField
      FieldName = 'MESREF'
      ProviderFlags = [pfInUpdate]
    end
    object SQLConferenciaOBSCON: TMemoField
      FieldName = 'OBSCON'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object SQLConferenciaDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLConferenciaUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 70
    end
  end
  object DspConferencia: TDataSetProvider
    DataSet = SQLConferencia
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 568
    Top = 328
  end
  object SQLProgramacao: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select codati, destipati, datati, horati, codcon, indfre'#13#10'from v' +
      'iw_atividades where codcon = :codcon'#13#10'order by datati, horati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 536
    Top = 384
    object SQLProgramacaoCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLProgramacaoDESTIPATI: TStringField
      DisplayLabel = 'Atividade'
      FieldName = 'DESTIPATI'
      ProviderFlags = [pfInUpdate]
      Size = 70
    end
    object SQLProgramacaoDATATI: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATATI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLProgramacaoHORATI: TTimeField
      DisplayLabel = 'Hor'#225'rio'
      FieldName = 'HORATI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLProgramacaoCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLProgramacaoINDFRE: TStringField
      FieldName = 'INDFRE'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object DspProgramacao: TDataSetProvider
    DataSet = SQLProgramacao
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspAgendaGetTableName
    OnGetDataSetProperties = DspAtividadeLECGetDataSetProperties
    Left = 568
    Top = 384
  end
  object SQLParticipantesTipoAtividade: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select par.codpar, par.codtipati, par.coddis, dis.nomdis'#13#10'from p' +
      'articipantes par'#13#10'inner join discipulados dis on (dis.coddis = p' +
      'ar.coddis)'#13#10'and par.codtipati = :codtipati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtipati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 360
    Top = 272
    object SQLParticipantesTipoAtividadeCODPAR: TIntegerField
      FieldName = 'CODPAR'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLParticipantesTipoAtividadeCODTIPATI: TIntegerField
      FieldName = 'CODTIPATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLParticipantesTipoAtividadeCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLParticipantesTipoAtividadeNOMDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'NOMDIS'
      ProviderFlags = []
      Required = True
      Size = 70
    end
  end
  object DspParticipantesTipoAtividade: TDataSetProvider
    DataSet = SQLParticipantesTipoAtividade
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspParticipantesTipoAtividadeGetTableName
    OnGetDataSetProperties = DspParticipantesTipoAtividadeGetDataSetProperties
    Left = 392
    Top = 272
  end
  object SQLTipoAtividade: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select codtipati, destipati, campro'#13#10'from tipos_atividades'#13#10'wher' +
      'e codtipati = :codtipati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtipati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 536
    Top = 440
  end
  object DspTipoAtividade: TDataSetProvider
    DataSet = SQLTipoAtividade
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 568
    Top = 440
  end
  object SQLCatExternalReports: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    MaxBlobSize = -1
    Params = <>
    Left = 544
    Top = 536
  end
  object DspCatExternalReports: TDataSetProvider
    DataSet = SQLCatExternalReports
    Options = [poReadOnly, poUseQuoteChar]
    Left = 576
    Top = 536
  end
  object SQLExternalReports: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 'select * from RELATORIOS_EXTERNOS order by nomrel'
    MaxBlobSize = -1
    Params = <>
    Left = 544
    Top = 584
    object SQLExternalReportsCODREL: TIntegerField
      FieldName = 'CODREL'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLExternalReportsNOMREL: TStringField
      DisplayLabel = 'Relat'#243'rio'
      FieldName = 'NOMREL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object SQLExternalReportsDESREL: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 35
      FieldName = 'DESREL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLExternalReportsNOMARQ: TStringField
      FieldName = 'NOMARQ'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      Size = 70
    end
    object SQLExternalReportsTAGREL: TStringField
      DisplayLabel = 'Tag'
      FieldName = 'TAGREL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 25
    end
    object SQLExternalReportsINDLEC: TStringField
      FieldName = 'INDLEC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDTMO: TStringField
      FieldName = 'INDTMO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDTMB: TStringField
      FieldName = 'INDTMB'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDTPU: TStringField
      FieldName = 'INDTPU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDEIN: TStringField
      FieldName = 'INDEIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDFOC: TStringField
      FieldName = 'INDFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDSEC: TStringField
      FieldName = 'INDSEC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDFIN: TStringField
      FieldName = 'INDFIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDCON: TStringField
      FieldName = 'INDCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLExternalReportsINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object DspExternalReports: TDataSetProvider
    DataSet = SQLExternalReports
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspExternalReportsGetDataSetProperties
    Left = 576
    Top = 584
  end
  object SQLConferenciasDiscipulados: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select con.codcondis, con.codcon, con.coddis, dis.nomdis '#13#10'from ' +
      'CONFERENCIAS_DISCIPULADOS con'#13#10'inner join discipulados dis on (d' +
      'is.coddis = con.coddis)'#13#10'and con.codcon = :codcon'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 528
    Top = 120
    object SQLConferenciasDiscipuladosCODCONDIS: TFMTBCDField
      FieldName = 'CODCONDIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
      Precision = 15
      Size = 0
    end
    object SQLConferenciasDiscipuladosCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLConferenciasDiscipuladosCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLConferenciasDiscipuladosNOMDIS: TStringField
      DisplayLabel = 'Discipulados'
      FieldName = 'NOMDIS'
      ProviderFlags = []
      Required = True
      Size = 70
    end
  end
  object DspConferenciasDiscipulados: TDataSetProvider
    DataSet = SQLConferenciasDiscipulados
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspConferenciasDiscipuladosGetTableName
    OnGetDataSetProperties = DspConferenciasDiscipuladosGetDataSetProperties
    Left = 560
    Top = 120
  end
  object SQLConferenciasFocos: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select con.codconfoc, con.codcon, con.codfoc, foc.nomfoc '#13#10'from ' +
      'CONFERENCIAS_FOCOS con'#13#10'inner join focos foc on (foc.codfoc = co' +
      'n.codfoc)'#13#10'and con.codcon = :codcon'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 528
    Top = 174
    object SQLConferenciasFocosCODCONFOC: TFMTBCDField
      FieldName = 'CODCONFOC'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
      Precision = 15
      Size = 0
    end
    object SQLConferenciasFocosCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLConferenciasFocosCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLConferenciasFocosNOMFOC: TStringField
      DisplayLabel = 'Focos'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
  end
  object DspConferenciasFocos: TDataSetProvider
    DataSet = SQLConferenciasFocos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspConferenciasFocosGetTableName
    OnGetDataSetProperties = DspConferenciasFocosGetDataSetProperties
    Left = 560
    Top = 174
  end
  object SQLFrequenciasConferencia: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select fre.codfre, fre.codati, fre.codcon, fre.codcad, cad.matca' +
      'd, cad.nomcad, cad.sigfoc, fre.indpre, fre.indjusace, cad.matcad' +
      'int, cad.sigdis'#13#10'from frequencias fre'#13#10'inner join viw_cadastrado' +
      's cad on (cad.codcad = fre.codcad)'#13#10'and fre.codcon = :codcon ord' +
      'er by cad.matcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 355
    Top = 118
    object SQLFrequenciasConferenciaCODFRE: TLargeintField
      FieldName = 'CODFRE'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLFrequenciasConferenciaCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = []
      Visible = False
    end
    object SQLFrequenciasConferenciaCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFrequenciasConferenciaCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFrequenciasConferenciaMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Size = 10
    end
    object SQLFrequenciasConferenciaNOMCAD: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLFrequenciasConferenciaSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLFrequenciasConferenciaSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLFrequenciasConferenciaINDPRE: TStringField
      DisplayLabel = 'Presente'
      FieldName = 'INDPRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFrequenciasConferenciaINDJUSACE: TStringField
      DisplayLabel = 'Justificado'
      FieldName = 'INDJUSACE'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLFrequenciasConferenciaMATCADINT: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      Visible = False
    end
  end
  object DspFrequenciasConferencia: TDataSetProvider
    DataSet = SQLFrequenciasConferencia
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspFrequenciasGetTableName
    OnGetDataSetProperties = DspFrequenciasGetDataSetProperties
    Left = 387
    Top = 118
  end
  object SQLFrequenciasConByAtividade: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select fre.codfre, fre.codati, fre.codcon, fre.codcad, cad.matca' +
      'd, cad.nomcad, cad.sigfoc, fre.indpre, fre.indjusace, cad.matcad' +
      'int, cad.sigdis'#13#10'from frequencias fre'#13#10'inner join viw_cadastrado' +
      's cad on (cad.codcad = fre.codcad)'#13#10'and fre.codcon = :codcon and' +
      ' fre.codati = :codati order by cad.matcadint'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 355
    Top = 222
    object SQLFrequenciasConByAtividadeCODFRE: TFMTBCDField
      FieldName = 'CODFRE'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
      Precision = 15
      Size = 0
    end
    object SQLFrequenciasConByAtividadeCODATI: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = []
      Visible = False
    end
    object SQLFrequenciasConByAtividadeCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFrequenciasConByAtividadeCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLFrequenciasConByAtividadeMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Size = 10
    end
    object SQLFrequenciasConByAtividadeNOMCAD: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLFrequenciasConByAtividadeSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLFrequenciasConByAtividadeSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLFrequenciasConByAtividadeINDPRE: TStringField
      DisplayLabel = 'Presente'
      FieldName = 'INDPRE'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFrequenciasConByAtividadeINDJUSACE: TStringField
      DisplayLabel = 'Justificado'
      FieldName = 'INDJUSACE'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLFrequenciasConByAtividadeMATCADINT: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      Visible = False
    end
  end
  object DspFrequenciasConferenciaByAtividade: TDataSetProvider
    DataSet = SQLFrequenciasConByAtividade
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetTableName = DspFrequenciasGetTableName
    OnGetDataSetProperties = DspFrequenciasGetDataSetProperties
    Left = 387
    Top = 222
  end
  object SQLPerfis: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select codper, nomper, indlec, indtmo, indtmb, indtpu, indein'#13#10'f' +
      'rom PERFIS order by nomper'
    MaxBlobSize = -1
    Params = <>
    Left = 352
    Top = 528
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
    Left = 384
    Top = 528
  end
  object SQLPerfil: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select codper, nomper, desper,  indlec, indtmo, indtmb, indtpu, ' +
      'indein, abrper, indadm from PERFIS where codper = :codper'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codper'
        ParamType = ptInput
        Value = 0
      end>
    Left = 352
    Top = 584
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
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspPerfilGetDataSetProperties
    Left = 384
    Top = 584
  end
  object DspKeywords: TDataSetProvider
    DataSet = SQLKeywords
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAgendaUpdateError
    OnGetDataSetProperties = DspKeywordsGetDataSetProperties
    Left = 384
    Top = 368
  end
  object SQLKeywords: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 'select * from KEYWORDS where codalo = :codalo'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codalo'
        ParamType = ptInput
        Value = 0
      end>
    Left = 352
    Top = 368
    object SQLKeywordsCODKEY: TIntegerField
      FieldName = 'CODKEY'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLKeywordsKEYWOR: TStringField
      DisplayLabel = 'Palavra-chave'
      FieldName = 'KEYWOR'
      Required = True
      Size = 25
    end
    object SQLKeywordsCODALO: TIntegerField
      FieldName = 'CODALO'
      Required = True
      Visible = False
    end
  end
  object SQLDadosAtividade: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 
      'select ati.codati, ati.destipati, ati.datati, ati.horati, ati.ca' +
      'mpro from viw_atividades ati where ati.codati = :codati'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'CODATI'
        ParamType = ptInput
        Value = ''
      end>
    Left = 32
    Top = 248
    object IntegerField1: TIntegerField
      FieldName = 'CODATI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'DESTIPATI'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object DateField1: TDateField
      FieldName = 'DATATI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object TimeField1: TTimeField
      FieldName = 'HORATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '!90:00;1;_'
    end
    object StringField4: TStringField
      DisplayWidth = 3
      FieldName = 'CAMPRO'
      ProviderFlags = []
      Size = 3
    end
  end
  object DspDadosAtividade: TDataSetProvider
    DataSet = SQLDadosAtividade
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 64
    Top = 248
  end
  object SQLFolhaPresenca: TSQLDataSet
    BeforeOpen = SQLAgendaBeforeOpen
    CommandText = 'select * from folha_presenca(?,  ?)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'icodati'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = 'iordem'
        ParamType = ptInput
        Size = 1
        Value = 'NOMCAD'
      end>
    Left = 520
    Top = 16
  end
  object DspFolhaPresenca: TDataSetProvider
    DataSet = SQLFolhaPresenca
    Left = 552
    Top = 16
  end
end
