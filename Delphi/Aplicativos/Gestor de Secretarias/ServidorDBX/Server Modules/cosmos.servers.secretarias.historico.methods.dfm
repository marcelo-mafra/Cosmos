object CosmosSecHistoricoServerMethods: TCosmosSecHistoricoServerMethods
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 427
  Width = 639
  object SQLSPTransferir: TSQLStoredProc
    BeforeOpen = SQLInstalarMembroBeforeOpen
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ICODCAD'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'IDATHIS'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'INOVO_FOCO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'IMANTER_CIRCULO'
        ParamType = ptInput
        Size = 1
        Value = ''
      end
      item
        DataType = ftWideString
        Name = 'IUSURES'
        ParamType = ptInput
        Size = 70
        Value = 's'
      end
      item
        DataType = ftBlob
        Name = 'IOBSHIS'
        ParamType = ptInput
      end>
    StoredProcName = 'TRANSFERIR_CADASTRADO'
    Left = 224
    Top = 144
  end
  object SQLHistorico: TSQLDataSet
    BeforeOpen = SQLHistoricoBeforeOpen
    CommandText = 
      'select * from viw_historico where codcad = :codcad'#13#10'order by dat' +
      'his desc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 64
    Top = 80
    object SQLHistoricoCODHIS: TIntegerField
      FieldName = 'CODHIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLHistoricoDATHIS: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATHIS'
    end
    object SQLHistoricoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      Visible = False
    end
    object SQLHistoricoCODTIPEVE: TIntegerField
      FieldName = 'CODTIPEVE'
      Visible = False
    end
    object SQLHistoricoDESTIPEVE: TStringField
      DisplayLabel = 'Evento'
      FieldName = 'DESTIPEVE'
      Size = 70
    end
    object SQLHistoricoCAMTRA: TStringField
      DisplayLabel = 'Campo'
      FieldName = 'CAMTRA'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLHistoricoTIPEVE: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPEVE'
      FixedChar = True
      Size = 3
    end
    object SQLHistoricoSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLHistoricoINDESCINT: TStringField
      FieldName = 'INDESCINT'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 1
    end
    object SQLHistoricoCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = []
      Visible = False
    end
    object SQLHistoricoSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
  object DspHistorico: TDataSetProvider
    DataSet = SQLHistorico
    Options = [poIncFieldProps, poDisableInserts, poDisableEdits, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspDetalhesHistoricoUpdateError
    OnGetTableName = DspEventoHistoricoGetTableName
    Left = 104
    Top = 80
  end
  object SQLEventoHistorico: TSQLDataSet
    BeforeOpen = SQLHistoricoBeforeOpen
    CommandText = 
      'select his.codhis, his.dathis, his.codcad, cad.nomcad, his.codti' +
      'peve, eve.destipeve, eve.tipeve, eve.camtra, his.codfoc, foc.nom' +
      'foc, his.coddis, dis.sigdis, his.deseve, his.obshis, his.motdes,' +
      ' his.numreg, his.usures, his.datcad'#13#10'from historicos his'#13#10'inner ' +
      'join cadastrados cad on (cad.codcad = his.codcad)'#13#10'inner join ti' +
      'pos_eventos eve on (eve.codtipeve = his.codtipeve)'#13#10'inner join f' +
      'ocos foc on(foc.codfoc = his.codfoc)'#13#10'inner join discipulados di' +
      's on(dis.coddis = his.coddis)'#13#10'and his.codhis = :codhis'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codhis'
        ParamType = ptInput
        Value = 0
      end>
    Left = 64
    Top = 144
    object SQLEventoHistoricoCODHIS: TIntegerField
      FieldName = 'CODHIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLEventoHistoricoDATHIS: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATHIS'
      ProviderFlags = [pfInUpdate]
    end
    object SQLEventoHistoricoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      Required = True
    end
    object SQLEventoHistoricoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLEventoHistoricoCODTIPEVE: TIntegerField
      FieldName = 'CODTIPEVE'
      Required = True
    end
    object SQLEventoHistoricoDESTIPEVE: TStringField
      FieldName = 'DESTIPEVE'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLEventoHistoricoTIPEVE: TStringField
      FieldName = 'TIPEVE'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLEventoHistoricoCAMTRA: TStringField
      FieldName = 'CAMTRA'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLEventoHistoricoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Required = True
    end
    object SQLEventoHistoricoNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLEventoHistoricoCODDIS: TIntegerField
      FieldName = 'CODDIS'
      Required = True
    end
    object SQLEventoHistoricoSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLEventoHistoricoDESEVE: TStringField
      FieldName = 'DESEVE'
      Size = 70
    end
    object SQLEventoHistoricoOBSHIS: TMemoField
      FieldName = 'OBSHIS'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
    object SQLEventoHistoricoMOTDES: TStringField
      FieldName = 'MOTDES'
      Size = 70
    end
    object SQLEventoHistoricoNUMREG: TIntegerField
      FieldName = 'NUMREG'
    end
    object SQLEventoHistoricoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 70
    end
    object SQLEventoHistoricoDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DspEventoHistorico: TDataSetProvider
    DataSet = SQLEventoHistorico
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspDetalhesHistoricoUpdateError
    OnGetTableName = DspEventoHistoricoGetTableName
    OnGetDataSetProperties = DspEventoHistoricoGetDataSetProperties
    Left = 104
    Top = 144
  end
  object SQLDetalhesHistorico: TSQLDataSet
    BeforeOpen = SQLHistoricoBeforeOpen
    CommandText = 
      'select det.coddet, det.datdet, det.codflu, flu.desflu, flu.seqfl' +
      'u,'#13#10'det.indcum, det.obsdet, det.datcad, det.usures'#13#10'from detalhe' +
      '_historico det'#13#10'inner join fluxos_eventos flu on (flu.codflu = d' +
      'et.codflu)'#13#10'where det.codhis = :codhis'#13#10'order by flu.seqflu'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codhis'
        ParamType = ptInput
        Value = 0
      end>
    Left = 64
    Top = 24
    object SQLDetalhesHistoricoCODDET: TIntegerField
      FieldName = 'CODDET'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLDetalhesHistoricoDATDET: TSQLTimeStampField
      DisplayLabel = 'Data'
      FieldName = 'DATDET'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999 99:99:99;1;_'
    end
    object SQLDetalhesHistoricoCODFLU: TIntegerField
      FieldName = 'CODFLU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLDetalhesHistoricoDESFLU: TStringField
      DisplayLabel = 'A'#231#227'o'
      FieldName = 'DESFLU'
      ProviderFlags = []
      ReadOnly = True
      Required = True
      Size = 70
    end
    object SQLDetalhesHistoricoSEQFLU: TSmallintField
      DisplayLabel = 'Seq'#252#234'ncia'
      FieldName = 'SEQFLU'
      ProviderFlags = []
      ReadOnly = True
      Required = True
    end
    object SQLDetalhesHistoricoINDCUM: TStringField
      DisplayLabel = 'Cumprida'
      FieldName = 'INDCUM'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLDetalhesHistoricoOBSDET: TMemoField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'OBSDET'
      ProviderFlags = [pfInUpdate]
      Visible = False
      BlobType = ftMemo
    end
    object SQLDetalhesHistoricoDATCAD: TSQLTimeStampField
      DisplayLabel = 'Cadastro'
      FieldName = 'DATCAD'
      ProviderFlags = [pfInUpdate]
      ReadOnly = True
      Required = True
      Visible = False
    end
    object SQLDetalhesHistoricoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 70
    end
  end
  object DspDetalhesHistorico: TDataSetProvider
    DataSet = SQLDetalhesHistorico
    Options = [poIncFieldProps, poDisableInserts, poDisableDeletes, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspDetalhesHistoricoUpdateError
    OnGetDataSetProperties = DspDetalhesHistoricoGetDataSetProperties
    Left = 96
    Top = 25
  end
  object SQLSPAnularHistorico: TSQLStoredProc
    BeforeOpen = SQLInstalarMembroBeforeOpen
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ICODHIS'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = 'INOVODIS'
        ParamType = ptInput
        Size = 3
        Value = ''
      end>
    StoredProcName = 'ANULAR_EVENTO_DISCIPULAR'
    Left = 336
    Top = 88
  end
  object SQLTurmasInstalacao: TSQLDataSet
    BeforeOpen = SQLHistoricoBeforeOpen
    CommandText = 
      'select tur.codturins, tur.numtur, tur.codfoc, tur.coddis, dis.no' +
      'mdis,'#13#10'dis.indescint, tur.indins'#13#10' from turmas_instalacoes tur'#13#10 +
      ' inner join discipulados dis on (dis.coddis = tur.coddis)'#13#10' and ' +
      'tur.codfoc = :codfoc'#13#10' and extract(year from tur.datcad) = :ano'
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
        Name = 'ano'
        ParamType = ptInput
        Value = 0
      end>
    Left = 64
    Top = 208
  end
  object DspTurmasInstalacao: TDataSetProvider
    DataSet = SQLTurmasInstalacao
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 96
    Top = 208
  end
  object SQLMembrosTurmasIns: TSQLDataSet
    BeforeOpen = SQLHistoricoBeforeOpen
    CommandText = 
      'select mem.codmem, mem.codturins, mem.codcad, cad.nomcad, cad.ma' +
      'tcad, cad.codfoc, cad.coddis, dis.nomdis'#13#10'from membros_turmas_in' +
      'stalacoes mem'#13#10'inner join cadastrados cad on (cad.codcad = mem.c' +
      'odcad)'#13#10'inner join discipulados dis on (dis.coddis = cad.coddis)' +
      #13#10'where mem.codturins = :codturins'#13#10'order by cad.nomcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codturins'
        ParamType = ptInput
        Value = 0
      end>
    Left = 64
    Top = 264
  end
  object DspMembrosTurmasIns: TDataSetProvider
    DataSet = SQLMembrosTurmasIns
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 96
    Top = 264
  end
  object SQLPassosProtocolo: TSQLDataSet
    BeforeOpen = SQLHistoricoBeforeOpen
    CommandText = 
      'select his.codhis, det.coddet, det.datdet, det.codflu, flu.desfl' +
      'u, flu.seqflu, '#13#10'case det.indcum '#13#10' when '#39'S'#39' then '#39'Sim'#39#13#10' when '#39 +
      'N'#39' then '#39'N'#227'o'#39#13#10'end as "INDCUM"'#13#10'from historicos his'#13#10'inner join ' +
      'detalhe_historico det on (det.codhis = his.codhis)'#13#10'inner join f' +
      'luxos_eventos flu on (flu.codflu = det.codflu)'#13#10'where his.codtur' +
      'ins = :codturins'#13#10'and his.codcad = :codcad'#13#10'order by flu.seqflu'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codturins'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 64
    Top = 328
    object SQLPassosProtocoloCODHIS: TIntegerField
      FieldName = 'CODHIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLPassosProtocoloCODDET: TIntegerField
      FieldName = 'CODDET'
      ProviderFlags = [pfInKey]
      Required = True
      Visible = False
    end
    object SQLPassosProtocoloDATDET: TSQLTimeStampField
      DisplayLabel = 'Data'
      DisplayWidth = 20
      FieldName = 'DATDET'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLPassosProtocoloCODFLU: TIntegerField
      FieldName = 'CODFLU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLPassosProtocoloDESFLU: TStringField
      DisplayLabel = 'A'#231#227'o'
      DisplayWidth = 50
      FieldName = 'DESFLU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLPassosProtocoloSEQFLU: TSmallintField
      DisplayLabel = 'Seq'#252#234'ncia'
      FieldName = 'SEQFLU'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLPassosProtocoloINDCUM: TStringField
      DisplayLabel = 'Cumprida?'
      FieldName = 'INDCUM'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
  end
  object DspPassosProtocolo: TDataSetProvider
    DataSet = SQLPassosProtocolo
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspDetalhesHistoricoUpdateError
    OnGetTableName = DspPassosProtocoloGetTableName
    Left = 96
    Top = 328
  end
  object SQLCartas: TSQLDataSet
    BeforeOpen = SQLHistoricoBeforeOpen
    CommandText = 
      'select his.codhis, his.dathis, his.codcad, his.codtipeve, tip.de' +
      'stipeve, tip.tipeve, tip.camtra, his.codfoc, foc.nomfoc, his.obs' +
      'his'#13#10'from historicos his'#13#10'inner join tipos_eventos tip on (tip.c' +
      'odtipeve = his.codtipeve)'#13#10'inner join focos foc on (foc.codfoc =' +
      ' his.codfoc)'#13#10'and his.codcad = :codcad'#13#10'and tip.camtra = '#39'TP'#39' an' +
      'd tip.tipeve = '#39'DOC'#39
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 224
    Top = 24
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
    OnUpdateError = DspDetalhesHistoricoUpdateError
    OnGetTableName = DspCartasGetTableName
    OnGetDataSetProperties = DspCartasGetDataSetProperties
    Left = 256
    Top = 24
  end
  object SQLInstalarMembro: TSQLStoredProc
    BeforeOpen = SQLInstalarMembroBeforeOpen
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ICODCAD'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ICODDIS'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'IDATINS'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'IVALMEN'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'IVALTAX'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ICODPRO'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = 'IESTCIV'
        ParamType = ptInput
        Size = 3
        Value = ''
      end>
    StoredProcName = 'INSTALAR_MEMBRO'
    Left = 224
    Top = 88
  end
end
