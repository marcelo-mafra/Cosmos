object DMSecLectoriumServerMethods: TDMSecLectoriumServerMethods
  OldCreateOrder = False
  Height = 540
  Width = 619
  object SQLPesquisadores: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  ((nomcad collate PT_BR starting with '#39'A'#39') or'#13#10'  (nomcad c' +
      'ollate PT_BR starting with '#39'B'#39'))'#13#10'  and codfoc = 6'#13#10'  and indati' +
      ' = '#39'S'#39#13#10'  and camdis = '#39'TP'#39#13#10'  order by nomcad'
    MaxBlobSize = -1
    Params = <>
    Left = 56
    Top = 304
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
    OnUpdateError = DspAlunosUpdateError
    OnGetTableName = DspAlunosGetTableName
    Left = 88
    Top = 304
  end
  object SQLPesquisador: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 'select * from viw_pesquisadores'#13#10'where codcad = :codcad'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 56
    Top = 352
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
    OnUpdateError = DspAlunosUpdateError
    OnGetTableName = DspAlunosGetTableName
    OnGetDataSetProperties = DspPesquisadorGetDataSetProperties
    Left = 88
    Top = 352
  end
  object SQLAlunos: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  ((nomcad collate PT_BR starting with '#39'A'#39') or'#13#10'  (nomcad c' +
      'ollate PT_BR starting with '#39'B'#39'))'#13#10'  and codfoc = 6'#13#10'  and indati' +
      ' = '#39'S'#39#13#10'  and camdis = '#39'LEC'#39#13#10'  order by nomcad'
    MaxBlobSize = -1
    Params = <>
    Left = 56
    Top = 40
    object SQLAlunosCODCAD: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object SQLAlunosMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object SQLAlunosNOMCAD: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLAlunosAPECAD: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLAlunosDATNAS: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object SQLAlunosSEXCAD: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object SQLAlunosSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLAlunosINDESCINT: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLAlunosSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLAlunosINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInWhere]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLAlunosmatcadint: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
  end
  object DspAlunos: TDataSetProvider
    DataSet = SQLAlunos
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAlunosUpdateError
    OnGetTableName = DspAlunosGetTableName
    Left = 88
    Top = 40
  end
  object DspAluno: TDataSetProvider
    DataSet = SQLAluno
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAlunosUpdateError
    OnGetTableName = DspAlunosGetTableName
    OnGetDataSetProperties = DspAlunoGetDataSetProperties
    Left = 88
    Top = 96
  end
  object SQLAluno: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 
      'select cad.codcad, cad.matcad, cad.nomcad, cad.apecad, cad.sexca' +
      'd, cad.datnas,'#13#10'cad.naccad, cad.docide, cad.orgexp, cad.estciv, ' +
      'cad.fotcad, cad.codpro,'#13#10'pro.despro, cad.codfoc, cad.coddis, dis' +
      '.sigdis, cad.cadtit, tit.nomcad as "NOMTIT",'#13#10'cad.indextnuc, cad' +
      '.indgrujov, cad.indligroz, cad.indati, cad.indfre,'#13#10'cad.indlic, ' +
      'cad.indmen, cad.valmen, cad.valtax, cad.datobi, cad.obscad, cad.' +
      'usures,'#13#10'cad.datcad'#13#10#13#10'from cadastrados cad'#13#10'left outer join pro' +
      'fissoes pro on (pro.codpro = cad.codpro)'#13#10'inner join discipulado' +
      's dis on (dis.coddis = cad.coddis)'#13#10'left outer join cadastrados ' +
      'tit on (cad.cadtit = tit.codcad)'#13#10'where cad.codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODCAD'
        ParamType = ptInput
        Value = 0
      end>
    Left = 56
    Top = 96
    object SQLAlunoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLAlunoMATCAD: TStringField
      FieldName = 'MATCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 10
    end
    object SQLAlunoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLAlunoAPECAD: TStringField
      FieldName = 'APECAD'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object SQLAlunoSEXCAD: TStringField
      FieldName = 'SEXCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoDATNAS: TDateField
      FieldName = 'DATNAS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAlunoNACCAD: TStringField
      FieldName = 'NACCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 25
    end
    object SQLAlunoDOCIDE: TStringField
      FieldName = 'DOCIDE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object SQLAlunoORGEXP: TStringField
      FieldName = 'ORGEXP'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 25
    end
    object SQLAlunoESTCIV: TStringField
      FieldName = 'ESTCIV'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 3
    end
    object SQLAlunoFOTCAD: TGraphicField
      FieldName = 'FOTCAD'
      ProviderFlags = [pfInUpdate]
      BlobType = ftGraphic
    end
    object SQLAlunoCODPRO: TIntegerField
      FieldName = 'CODPRO'
      ProviderFlags = [pfInUpdate]
    end
    object SQLAlunoDESPRO: TStringField
      FieldName = 'DESPRO'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLAlunoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAlunoCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
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
      ProviderFlags = [pfInUpdate]
    end
    object SQLAlunoNOMTIT: TStringField
      DisplayLabel = 'Titular'
      FieldName = 'NOMTIT'
      ProviderFlags = []
      Size = 70
    end
    object SQLAlunoINDEXTNUC: TStringField
      FieldName = 'INDEXTNUC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDGRUJOV: TStringField
      FieldName = 'INDGRUJOV'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDLIGROZ: TStringField
      FieldName = 'INDLIGROZ'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoINDFRE: TStringField
      FieldName = 'INDFRE'
      ProviderFlags = [pfInUpdate]
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
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlunoVALMEN: TFMTBCDField
      FieldName = 'VALMEN'
      ProviderFlags = [pfInUpdate]
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLAlunoVALTAX: TFMTBCDField
      FieldName = 'VALTAX'
      ProviderFlags = [pfInUpdate]
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object SQLAlunoDATOBI: TDateField
      FieldName = 'DATOBI'
      ProviderFlags = [pfInUpdate]
      EditMask = '99/99/9999'
    end
    object SQLAlunoOBSCAD: TMemoField
      FieldName = 'OBSCAD'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
    object SQLAlunoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
    object SQLAlunoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DspDispensas: TDataSetProvider
    DataSet = SQLDispensas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAlunosUpdateError
    OnGetDataSetProperties = DspDispensasGetDataSetProperties
    Left = 232
    Top = 337
  end
  object SQLDispensas: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 'select * from dispensas where codcad = :codcad'#13#10'order by inidis'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 200
    Top = 337
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
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 'select * from TAREFAS'
    MaxBlobSize = -1
    Params = <>
    Left = 208
    Top = 400
  end
  object DspTarefas: TDataSetProvider
    DataSet = SQLTarefas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 240
    Top = 400
  end
  object SQLJovensTM: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 
      'select codcad, matcad, nomcad, apecad, datnas, sexcad, sigdis, i' +
      'ndescint, sigfoc, indati, matcadint'#13#10' from viw_cadastrados'#13#10'  wh' +
      'ere'#13#10'  ((nomcad collate PT_BR starting with '#39'A'#39') or'#13#10'  (nomcad c' +
      'ollate PT_BR starting with '#39'B'#39'))'#13#10'  and codfoc = 6'#13#10'  and indati' +
      ' = '#39'S'#39#13#10'  and camdis = '#39'TM'#39#13#10'  order by nomcad'
    MaxBlobSize = -1
    Params = <>
    Left = 56
    Top = 176
    object SQLJovensTMCODCAD: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object SQLJovensTMMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object SQLJovensTMNOMCAD: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLJovensTMAPECAD: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object SQLJovensTMDATNAS: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object SQLJovensTMSEXCAD: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object SQLJovensTMSIGDIS: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLJovensTMINDESCINT: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLJovensTMSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLJovensTMINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInWhere]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLJovensTMMATCADINT: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
  end
  object DspJovensTM: TDataSetProvider
    DataSet = SQLJovensTM
    Options = [poIncFieldProps, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAlunosUpdateError
    OnGetTableName = DspAlunosGetTableName
    Left = 88
    Top = 176
  end
  object DspJovemTM: TDataSetProvider
    DataSet = SQLJovemTM
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspAlunosUpdateError
    OnGetTableName = DspAlunosGetTableName
    OnGetDataSetProperties = DspAlunoGetDataSetProperties
    Left = 88
    Top = 224
  end
  object SQLJovemTM: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
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
    Left = 56
    Top = 224
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
  object SQLSimpatizantes: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
    CommandText = 
      'select codsim, nomsim from SIMPATIZANTES '#13#10'where codfoc = :codfo' +
      'c'#13#10'order by nomsim'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    Left = 56
    Top = 400
    object SQLSimpatizantesCODSIM: TIntegerField
      FieldName = 'CODSIM'
      ProviderFlags = [pfInKey]
      Required = True
    end
    object SQLSimpatizantesNOMSIM: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMSIM'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object DspSimpatizantes: TDataSetProvider
    DataSet = SQLSimpatizantes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 400
  end
  object SQAlunosAlfa: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
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
        Value = 'LEC'
      end>
    Left = 216
    Top = 40
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
      DisplayLabel = 'Discipulado'
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
  object DspAlunosAlfa: TDataSetProvider
    DataSet = SQAlunosAlfa
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 248
    Top = 40
  end
  object SQLAlunosDisc: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
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
    Left = 216
    Top = 96
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
      DisplayLabel = 'Discipulado'
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
  object DspAlunosDisc: TDataSetProvider
    DataSet = SQLAlunosDisc
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 248
    Top = 96
  end
  object SQLJovensAlfa: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
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
        Value = 'TMO'
      end>
    Left = 216
    Top = 176
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
      DisplayLabel = 'Grupo'
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
  object DspJovensAlfa: TDataSetProvider
    DataSet = SQLJovensAlfa
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 248
    Top = 176
  end
  object SQLJovensDisc: TSQLDataSet
    BeforeOpen = SQLAlunosBeforeOpen
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
    Left = 216
    Top = 232
    object IntegerField7: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object StringField25: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      Size = 10
    end
    object StringField26: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object StringField27: TStringField
      DisplayLabel = 'Apelido'
      FieldName = 'APECAD'
      Size = 30
    end
    object DateField4: TDateField
      DisplayLabel = 'Nascimento'
      FieldName = 'DATNAS'
    end
    object StringField28: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object StringField29: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'SIGDIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object StringField30: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object StringField31: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object StringField32: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInWhere]
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField8: TIntegerField
      FieldName = 'MATCADINT'
      ProviderFlags = []
      ReadOnly = True
      Visible = False
    end
  end
  object DspJovensDisc: TDataSetProvider
    DataSet = SQLJovensDisc
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 248
    Top = 232
  end
end
