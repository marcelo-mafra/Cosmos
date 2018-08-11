object CosmosSecTPServerMethods: TCosmosSecTPServerMethods
  OldCreateOrder = False
  Height = 454
  Width = 531
  object SQLTurmasTP: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select codtur, codfoc, numtur,'#13#10' case indenc'#13#10'  when '#39'N'#39' then '#39'C' +
      'ursando'#39#13#10'  when '#39'S'#39' then '#39'Encerrada'#39#13#10' end as "indenc", datcre,' +
      ' datenc  from TURMAS_TP'#13#10'where'#13#10'codfoc = :codfoc'#13#10'and extract(ye' +
      'ar from datcre) = :ano'
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
        Name = 'ano'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 296
    object SQLTurmasTPCODTUR: TIntegerField
      FieldName = 'CODTUR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLTurmasTPCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Required = True
      Visible = False
    end
    object SQLTurmasTPNUMTUR: TIntegerField
      DisplayLabel = 'Turma'
      DisplayWidth = 20
      FieldName = 'NUMTUR'
      Required = True
    end
    object SQLTurmasTPindenc: TStringField
      DisplayLabel = 'Status'
      DisplayWidth = 15
      FieldName = 'INDENC'
      ReadOnly = True
      FixedChar = True
      Size = 9
    end
    object SQLTurmasTPDATCRE: TDateField
      DisplayLabel = 'Cria'#231#227'o'
      DisplayWidth = 25
      FieldName = 'DATCRE'
      Required = True
    end
    object SQLTurmasTPDATENC: TDateField
      DisplayLabel = 'Encerramento'
      DisplayWidth = 25
      FieldName = 'DATENC'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DspTurmasTP: TDataSetProvider
    DataSet = SQLTurmasTP
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 64
    Top = 296
  end
  object SQLCursistas: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select mem.*, cad.matcad, cad.nomcad, cad.apecad from membros_tu' +
      'rmas_tp mem'#13#10'inner join cadastrados cad on (cad.codcad = mem.cod' +
      'cad)'#13#10'where mem.codtur = :codtur'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtur'
        ParamType = ptInput
        Value = 0
      end>
    Left = 40
    Top = 152
    object SQLCursistasCODMEM: TIntegerField
      FieldName = 'CODMEM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLCursistasCODTUR: TIntegerField
      FieldName = 'CODTUR'
      Required = True
      Visible = False
    end
    object SQLCursistasCODCAD: TIntegerField
      FieldName = 'CODCAD'
      Required = True
      Visible = False
    end
    object SQLCursistasMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Required = True
      Size = 10
    end
    object SQLCursistasNOMCAD: TStringField
      DisplayLabel = 'Cadastrado'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLCursistasAPECAD: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      ProviderFlags = []
      Required = True
      Size = 30
    end
  end
  object DspCursistas: TDataSetProvider
    DataSet = SQLCursistas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspPesquisadorUpdateError
    OnGetDataSetProperties = DspCursistasGetDataSetProperties
    Left = 72
    Top = 152
  end
  object SQLPesquisadores: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  ((nomcad collate PT_BR starting with '#39'A'#39') or'#13#10'  (nomcad c' +
      'ollate PT_BR starting with '#39'B'#39'))'#13#10'  and codfoc = 6'#13#10'  and indati' +
      ' = '#39'S'#39#13#10'  and camdis = '#39'TP'#39#13#10'  order by nomcad'
    MaxBlobSize = -1
    Params = <>
    Left = 40
    Top = 24
    object SQLPesquisadoresCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLPesquisadoresMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object SQLPesquisadoresNOMCAD: TStringField
      DisplayLabel = 'Pesquisador'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLPesquisadoresAPECAD: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLPesquisadoresDATNAS: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object SQLPesquisadoresSEXCAD: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object SQLPesquisadoresSIGDIS: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLPesquisadoresINDESCINT: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLPesquisadoresSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLPesquisadoresINDATI: TStringField
      FieldName = 'INDATI'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLPesquisadoresMATCADINT: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      Visible = False
    end
  end
  object DspPesquisadores: TDataSetProvider
    DataSet = SQLPesquisadores
    Options = [poIncFieldProps, poDisableInserts, poDisableEdits, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 80
    Top = 24
  end
  object SQLPesquisador: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 'select * from viw_pesquisadores'#13#10'where codcad = :codcad'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 40
    Top = 88
    object SQLPesquisadorCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLPesquisadorMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object SQLPesquisadorNOMCAD: TStringField
      DisplayLabel = 'Pesquisador'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLPesquisadorAPECAD: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLPesquisadorSEXCAD: TStringField
      FieldName = 'SEXCAD'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLPesquisadorDATNAS: TDateField
      FieldName = 'DATNAS'
    end
    object SQLPesquisadorNACCAD: TStringField
      FieldName = 'NACCAD'
      Size = 25
    end
    object SQLPesquisadorDOCIDE: TStringField
      FieldName = 'DOCIDE'
      Size = 15
    end
    object SQLPesquisadorORGEXP: TStringField
      FieldName = 'ORGEXP'
      FixedChar = True
      Size = 6
    end
    object SQLPesquisadorCODFOC: TIntegerField
      FieldName = 'CODFOC'
    end
    object SQLPesquisadorSIGFOC: TStringField
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLPesquisadorCODDIS: TIntegerField
      FieldName = 'CODDIS'
    end
    object SQLPesquisadorSIGDIS: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'SIGDIS'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLPesquisadorINDEXTNUC: TStringField
      FieldName = 'INDEXTNUC'
      FixedChar = True
      Size = 1
    end
    object SQLPesquisadorCONESC: TSmallintField
      FieldName = 'CONESC'
      Required = True
    end
    object SQLPesquisadorINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
    object SQLPesquisadorINDPRECON: TStringField
      FieldName = 'INDPRECON'
      FixedChar = True
      Size = 1
    end
    object SQLPesquisadorOBSCAD: TMemoField
      FieldName = 'OBSCAD'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object SQLPesquisadorDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLPesquisadorUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
  end
  object DspPesquisador: TDataSetProvider
    DataSet = SQLPesquisador
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspPesquisadorUpdateError
    OnGetTableName = DspPesquisadorGetTableName
    OnGetDataSetProperties = DspPesquisadorGetDataSetProperties
    Left = 80
    Top = 88
  end
  object SQLCartas: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select his.codhis, his.dathis, his.codcad, his.codtipeve, tip.de' +
      'stipeve, tip.tipeve, tip.camtra, his.codfoc, foc.nomfoc, his.obs' +
      'his'#13#10'from historicos his'#13#10'inner join tipos_eventos tip on (tip.c' +
      'odtipeve = his.codtipeve)'#13#10'inner join focos foc on (foc.codfoc =' +
      ' his.codfoc)'#13#10'and his.codcad = :codcad'#13#10'and tip.camtra = '#39'TPU'#39' a' +
      'nd tip.tipeve = '#39'DOC'#39
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 360
    object SQLCartasCODHIS: TIntegerField
      FieldName = 'CODHIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLCartasDATHIS: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATHIS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLCartasCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLCartasCODTIPEVE: TIntegerField
      FieldName = 'CODTIPEVE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLCartasDESTIPEVE: TStringField
      DisplayLabel = 'Carta'
      FieldName = 'DESTIPEVE'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLCartasTIPEVE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPEVE'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLCartasCAMTRA: TStringField
      DisplayLabel = 'Respons'#225'vel'
      FieldName = 'CAMTRA'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLCartasCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLCartasNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Visible = False
      Size = 70
    end
    object SQLCartasOBSHIS: TMemoField
      FieldName = 'OBSHIS'
      ProviderFlags = [pfInUpdate]
      Visible = False
      BlobType = ftMemo
    end
  end
  object DspCartas: TDataSetProvider
    DataSet = SQLCartas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspPesquisadorUpdateError
    OnGetDataSetProperties = DspCartasGetDataSetProperties
    Left = 64
    Top = 360
  end
  object SQLAtividadesTurma: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select destipati, datati, horati, numtem, sigfoc from viw_ativid' +
      'ades where codtur = :codtur order by datati, horati desc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtur'
        ParamType = ptInput
      end>
    Left = 40
    Top = 232
    object SQLAtividadesTurmaDESTIPATI: TStringField
      DisplayLabel = 'Atividade'
      FieldName = 'DESTIPATI'
      Size = 70
    end
    object SQLAtividadesTurmaDATATI: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATATI'
    end
    object SQLAtividadesTurmaHORATI: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'HORATI'
    end
    object SQLAtividadesTurmaNUMTEM: TSmallintField
      DisplayLabel = 'Tema'
      FieldName = 'NUMTEM'
    end
    object SQLAtividadesTurmaSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
  end
  object DspAtividadesTurma: TDataSetProvider
    DataSet = SQLAtividadesTurma
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 72
    Top = 232
  end
  object SQLSimpatizante: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select codcad, nomcad, sexcad, datnas, naccad, docide, orgexp, c' +
      'odfoc, coddis, indati, '#13#10'codpro, despro, conesc, fotcad, obscad,' +
      ' datcad, usures from VIW_SIMPATIZANTES  where codcad = :codcad'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    Left = 200
    Top = 152
    object SQLSimpatizanteCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object SQLSimpatizanteNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLSimpatizanteSEXCAD: TStringField
      FieldName = 'SEXCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLSimpatizanteDATNAS: TDateField
      FieldName = 'DATNAS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLSimpatizanteNACCAD: TStringField
      FieldName = 'NACCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 25
    end
    object SQLSimpatizanteDOCIDE: TStringField
      FieldName = 'DOCIDE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object SQLSimpatizanteORGEXP: TStringField
      FieldName = 'ORGEXP'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 25
    end
    object SQLSimpatizanteCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLSimpatizanteCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
    end
    object SQLSimpatizanteCODPRO: TIntegerField
      FieldName = 'CODPRO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLSimpatizanteDESPRO: TStringField
      FieldName = 'DESPRO'
      ProviderFlags = []
      Size = 70
    end
    object SQLSimpatizanteINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLSimpatizanteCONESC: TSmallintField
      FieldName = 'CONESC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLSimpatizanteFOTCAD: TBlobField
      FieldName = 'FOTCAD'
      ProviderFlags = [pfInUpdate]
      Size = 1
    end
    object SQLSimpatizanteOBSCAD: TMemoField
      FieldName = 'OBSCAD'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object SQLSimpatizanteDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLSimpatizanteUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 70
    end
  end
  object DspSimpatizante: TDataSetProvider
    DataSet = SQLSimpatizante
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateData = DspSimpatizanteUpdateData
    OnUpdateError = DspPesquisadorUpdateError
    OnGetTableName = DspPesquisadorGetTableName
    OnGetDataSetProperties = DspPesquisadorGetDataSetProperties
    Left = 232
    Top = 152
  end
  object SQLPesquisadoresAlfa: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  ((nomcad collate PT_BR starting with ?) or'#13#10'  (nomcad col' +
      'late PT_BR starting with ?))'#13#10'  and codfoc = ?'#13#10'  and indati = ?' +
      #13#10'  and camdis = ?'#13#10'  order by nomcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftWideString
        Name = 'param1'
        ParamType = ptInput
        Value = 'A'
      end
      item
        DataType = ftWideString
        Name = 'param2'
        ParamType = ptInput
        Value = 'B'
      end
      item
        DataType = ftInteger
        Name = 'param3'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftWideString
        Name = 'param4'
        ParamType = ptInput
        Value = 'S'
      end
      item
        DataType = ftWideString
        Name = 'param5'
        ParamType = ptInput
        Value = 'TPU'
      end>
    Left = 192
    Top = 24
    object IntegerField1: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object StringField1: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object StringField2: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object StringField3: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object DateField1: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object StringField4: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object StringField5: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object StringField6: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object StringField7: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object StringField8: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInWhere]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField2: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
  end
  object DspPesquisadoresAlfa: TDataSetProvider
    DataSet = SQLPesquisadoresAlfa
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 224
    Top = 24
  end
  object SQLPesquisadoresDisc: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  sigdis = ?'#13#10'  and indati = ?'#13#10'  and codfoc = ?'#13#10'  order b' +
      'y nomcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftWideString
        Name = 'sigdis'
        ParamType = ptInput
        Value = 'PTT'
      end
      item
        DataType = ftWideString
        Name = 'indati'
        ParamType = ptInput
        Value = 'S'
      end
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 80
    object IntegerField3: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object StringField9: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object StringField10: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object StringField11: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object DateField2: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object StringField12: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object StringField13: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object StringField14: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object StringField15: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object StringField16: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInWhere]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField4: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
  end
  object DspPesquisadoresDisc: TDataSetProvider
    DataSet = SQLPesquisadoresDisc
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 224
    Top = 80
  end
  object SQLSimpatizantesAlfa: TSQLDataSet
    BeforeOpen = SQLTurmasTPBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  ((nomcad collate PT_BR starting with ?) or'#13#10'  (nomcad col' +
      'late PT_BR starting with ?))'#13#10'  and codfoc = ?'#13#10'  and indati = ?' +
      #13#10'  and camdis = ?'#13#10'  order by nomcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftWideString
        Name = 'param1'
        ParamType = ptInput
        Value = 'A'
      end
      item
        DataType = ftWideString
        Name = 'param2'
        ParamType = ptInput
        Value = 'B'
      end
      item
        DataType = ftInteger
        Name = 'param3'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftWideString
        Name = 'param4'
        ParamType = ptInput
        Value = 'S'
      end
      item
        DataType = ftWideString
        Name = 'param5'
        ParamType = ptInput
        Value = 'SIM'
      end>
    Left = 200
    Top = 216
    object IntegerField5: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object StringField17: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object StringField18: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object StringField19: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object DateField3: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object StringField20: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object StringField21: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object StringField22: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object StringField23: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object StringField24: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInWhere]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField6: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
  end
  object DspSimpatizantesAlfa: TDataSetProvider
    DataSet = SQLSimpatizantesAlfa
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 232
    Top = 216
  end
end
