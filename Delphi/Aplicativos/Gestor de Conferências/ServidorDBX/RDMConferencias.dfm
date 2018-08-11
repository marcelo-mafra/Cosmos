object Conferencias: TConferencias
  OldCreateOrder = False
  OnCreate = RemoteDataModuleCreate
  OnDestroy = RemoteDataModuleDestroy
  Height = 835
  Width = 700
  object SQLCon: TSQLConnection
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'Password=galaad'
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver160.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=16.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver160.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=16.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      
        'Database=D:\Marcelo\Cosmos\Implanta'#231#245'es\Desenvolvimento\COSMOSDB' +
        '.FDB'
      'User_Name=sysdba'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
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
  object SQLConferencia: TSQLDataSet
    CommandText = 
      'select conf.codcon, conf.nomcon, foc.nomfoc, conf.camcon, conf.c' +
      'odmod,'#13#10' mod.nommod, mod.valtax, conf.limins, conf.datini, conf.' +
      'datter,'#13#10' conf.horini, conf.horter, conf.datlim, conf.indesp, co' +
      'nf.stacon,'#13#10' conf.indmod, conf.tiplev, conf.obscon, conf.datcad,' +
      ' conf.usures'#13#10'from conferencias conf'#13#10'inner join focos foc on (f' +
      'oc.codfoc = conf.codfoc)'#13#10'inner join modelos_taxas mod on (mod.c' +
      'odmod = conf.codmod)'#13#10'and conf.codcon = :codcon'
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
    Top = 127
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
    object SQLConferenciaCODMOD: TIntegerField
      FieldName = 'CODMOD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLConferenciaNOMMOD: TStringField
      FieldName = 'NOMMOD'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLConferenciaVALTAX: TFMTBCDField
      FieldName = 'VALTAX'
      ProviderFlags = []
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
    object SQLConferenciaOBSCON: TMemoField
      FieldName = 'OBSCON'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
    object SQLConferenciaDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
      Required = True
    end
    object SQLConferenciaUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 31
    end
  end
  object DspConferencia: TDataSetProvider
    DataSet = SQLConferencia
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 48
    Top = 127
  end
  object SQLProgramacao: TSQLDataSet
    CommandText = 
      'select codati, destipati, datati, horati, codcon, indfre'#13#10'from v' +
      'iw_atividades where codcon = :codcon'#13#10'order by datati, horati'
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
    Top = 183
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
    OnGetTableName = DspProgramacaoGetTableName
    Left = 48
    Top = 183
  end
  object DspPesquisaConferencias: TDataSetProvider
    DataSet = SQLPesquisaConferencias
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 184
    Top = 72
  end
  object SQLPesquisaConferencias: TSQLDataSet
    CommandText = 
      'select codcon, nomcon, datini, datter, codfoc, nomfoc, sigfoc, c' +
      'amcon, stacon from viw_conferencias where codfoc = :codfoc and c' +
      'amcon = :camcon and'#13#10'  extract(year from datini) = :ano'#13#10'  order' +
      ' by datini desc'
    DbxCommandType = 'Dbx.SQL'
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
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'ano'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 152
    Top = 72
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
    object SQLPesquisaConferenciasNOMFOC: TStringField
      DisplayLabel = 'Promotor'
      DisplayWidth = 50
      FieldName = 'NOMFOC'
      Size = 70
    end
    object SQLPesquisaConferenciasSIGFOC: TStringField
      DisplayLabel = 'Promotor'
      FieldName = 'SIGFOC'
      Visible = False
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
    object SQLPesquisaConferenciasCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Visible = False
    end
  end
  object SQLConferenciasDiscipulados: TSQLDataSet
    CommandText = 
      'select con.codcondis, con.codcon, con.coddis, dis.nomdis '#13#10'from ' +
      'CONFERENCIAS_DISCIPULADOS con'#13#10'inner join discipulados dis on (d' +
      'is.coddis = con.coddis)'#13#10'and con.codcon = :codcon'
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
    Left = 152
    Top = 128
    object SQLConferenciasDiscipuladosCODCONDIS: TLargeintField
      FieldName = 'CODCONDIS'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
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
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetDataSetProperties = DspConferenciasDiscipuladosGetDataSetProperties
    Left = 184
    Top = 128
  end
  object DspConferenciasFocos: TDataSetProvider
    DataSet = SQLConferenciasFocos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetDataSetProperties = DspConferenciasFocosGetDataSetProperties
    Left = 184
    Top = 182
  end
  object SQLConferenciasFocos: TSQLDataSet
    CommandText = 
      'select con.codconfoc, con.codcon, con.codfoc, foc.nomfoc '#13#10'from ' +
      'CONFERENCIAS_FOCOS con'#13#10'inner join focos foc on (foc.codfoc = co' +
      'n.codfoc)'#13#10'and con.codcon = :codcon'
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
    Left = 152
    Top = 182
    object SQLConferenciasFocosCODCONFOC: TLargeintField
      FieldName = 'CODCONFOC'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
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
  object DspAtividadeLEC: TDataSetProvider
    DataSet = SQLAtividadeLEC
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspAtividadeLECGetTableName
    OnGetDataSetProperties = DspAtividadeLECGetDataSetProperties
    Left = 176
    Top = 237
  end
  object SQLAtividadeLEC: TSQLDataSet
    CommandText = 
      'select ati.codati, ati.codtipati, tip.destipati, tip.campro, ati' +
      '.codfoc, ati.datati, ati.horati, ati.locati, ati.codcon, con.nom' +
      'con,'#13#10'ati.indfre, ati.codalo, alo.titalo, ati.indjal, ati.indlis' +
      ', ati.obsati, ati.usures, ati.datcad'#13#10'from atividades ati'#13#10' left' +
      ' outer join conferencias con on (con.codcon = ati.codcon)'#13#10' left' +
      ' outer join alocucoes alo on (alo.codalo = ati.codalo)'#13#10' inner j' +
      'oin tipos_atividades tip on(tip.codtipati = ati.codtipati)'#13#10'and ' +
      'ati.codati = :codati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 144
    Top = 237
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
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
    object SQLAtividadeLECDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
    end
  end
  object DspEscalas: TDataSetProvider
    DataSet = SQLEscalas
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspEscalasGetTableName
    OnGetDataSetProperties = DspEscalasGetDataSetProperties
    Left = 48
    Top = 240
  end
  object SQLEscalas: TSQLDataSet
    CommandText = 
      'select esc.codesc, esc.codati, esc.codcad, cad.nomcad, esc.codti' +
      'patu, tip.destipatu'#13#10'from escalas_atividades esc'#13#10'inner join cad' +
      'astrados cad on (cad.codcad = esc.codcad)'#13#10'inner join tipos_atua' +
      'cao tip on (tip.codtipatu = esc.codtipatu)'#13#10'and esc.codati = :co' +
      'dati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 16
    Top = 240
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
  object DspTiposAtividades: TDataSetProvider
    DataSet = SQLTiposAtividades
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetDataSetProperties = DspTiposAtividadesGetDataSetProperties
    Left = 48
    Top = 297
  end
  object SQLTiposAtividades: TSQLDataSet
    CommandText = 'select * from TIPOS_ATIVIDADES order by destipati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 16
    Top = 296
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
  end
  object SQLTipoAtividade: TSQLDataSet
    CommandText = 
      'select codtipati, destipati, campro'#13#10'from tipos_atividades'#13#10'wher' +
      'e codtipati = :codtipati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtipati'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 16
    Top = 352
  end
  object DspTipoAtividade: TDataSetProvider
    DataSet = SQLTipoAtividade
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    OnUpdateError = DspTipoAtividadeUpdateError
    Left = 48
    Top = 352
  end
  object SQLAlojamento: TSQLDataSet
    CommandText = 
      'select alo.codalo, alo.codfoc, foc.nomfoc, alo.nomalo, alo.index' +
      't, alo.lotalo, alo.endalo,'#13#10'alo.telalo'#13#10'from ALOJAMENTOS alo'#13#10'in' +
      'ner join FOCOS foc on (foc.codfoc = alo.codfoc)'#13#10'and alo.codalo ' +
      '= :codalo'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codalo'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 144
    Top = 296
    object SQLAlojamentoCODALO: TIntegerField
      FieldName = 'CODALO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLAlojamentoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAlojamentoNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLAlojamentoNOMALO: TStringField
      FieldName = 'NOMALO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLAlojamentoINDEXT: TStringField
      FieldName = 'INDEXT'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLAlojamentoLOTALO: TSmallintField
      FieldName = 'LOTALO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLAlojamentoENDALO: TStringField
      FieldName = 'ENDALO'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object SQLAlojamentoTELALO: TStringField
      FieldName = 'TELALO'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
  end
  object DspAlojamento: TDataSetProvider
    DataSet = SQLAlojamento
    Options = [poIncFieldProps, poCascadeUpdates, poUseQuoteChar]
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspAlojamentoGetTableName
    OnGetDataSetProperties = DspAlojamentoGetDataSetProperties
    Left = 184
    Top = 296
  end
  object SQLClassificadores: TSQLDataSet
    CommandText = 
      'select codatr, sigatr, desatrlei, desatrcad'#13#10'from ATRIBUTOS orde' +
      'r by sigatr'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 16
    Top = 424
    object SQLClassificadoresCODATR: TIntegerField
      FieldName = 'CODATR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLClassificadoresSIGATR: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGATR'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLClassificadoresDESATRLEI: TStringField
      DisplayLabel = 'Classificador (leito)'
      FieldName = 'DESATRLEI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object SQLClassificadoresDESATRCAD: TStringField
      DisplayLabel = 'Classificador (cadastrado)'
      FieldName = 'DESATRCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
  end
  object DspClassificadores: TDataSetProvider
    DataSet = SQLClassificadores
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 64
    Top = 424
  end
  object DspClassificador: TDataSetProvider
    DataSet = SQLClassificador
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspClassificadorUpdateError
    OnGetDataSetProperties = DspClassificadorGetDataSetProperties
    Left = 64
    Top = 480
  end
  object SQLClassificador: TSQLDataSet
    CommandText = 
      'select codatr, sigatr, desatrlei, desatrcad'#13#10'from ATRIBUTOS wher' +
      'e codatr = :codatr'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'codatr'
        ParamType = ptInput
      end>
    SQLConnection = SQLCon
    Left = 16
    Top = 480
    object IntegerField1: TIntegerField
      FieldName = 'CODATR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object StringField1: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGATR'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object StringField2: TStringField
      DisplayLabel = 'Classificador (leito)'
      FieldName = 'DESATRLEI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object StringField3: TStringField
      DisplayLabel = 'Classificador (cadastrado)'
      FieldName = 'DESATRCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
  end
  object SQLClassificadoresLeito: TSQLDataSet
    CommandText = 
      'select lei.codatrlei, lei.codatr, atr.sigatr, atr.desatrlei, lei' +
      '.codlei'#13#10'from ATRIBUTOS_LEITOS lei'#13#10'inner join ATRIBUTOS atr on ' +
      '(atr.codatr = lei.codatr) and lei.codlei = :codlei'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codlei'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 144
    Top = 360
    object SQLClassificadoresLeitoCODATRLEI: TIntegerField
      FieldName = 'CODATRLEI'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object SQLClassificadoresLeitoCODATR: TIntegerField
      FieldName = 'CODATR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLClassificadoresLeitoSIGATR: TStringField
      DisplayLabel = 'Sigla'
      DisplayWidth = 20
      FieldName = 'SIGATR'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 10
    end
    object SQLClassificadoresLeitoDESATRLEI: TStringField
      DisplayLabel = 'Classificador'
      DisplayWidth = 200
      FieldName = 'DESATRLEI'
      ProviderFlags = []
      Required = True
      Size = 50
    end
    object SQLClassificadoresLeitoCODLEI: TIntegerField
      FieldName = 'CODLEI'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
  end
  object DspClassificadoresLeito: TDataSetProvider
    DataSet = SQLClassificadoresLeito
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspClassificadoresLeitoGetTableName
    OnGetDataSetProperties = DspClassificadoresLeitoGetDataSetProperties
    Left = 184
    Top = 360
  end
  object DspAgenda: TDataSetProvider
    DataSet = SQLAgenda
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspAgendaGetTableName
    Left = 48
    Top = 544
  end
  object SQLAgenda: TSQLDataSet
    CommandText = 
      'select * from VIW_ATIVIDADES'#13#10'where datati between :datini and :' +
      'datfin order by datati, horati'
    DbxCommandType = 'Dbx.SQL'
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
    SQLConnection = SQLCon
    Left = 16
    Top = 544
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
  object SQLLeito: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select lei.codlei, lei.codqua, qua.numqua, lei.numlei, lei.codca' +
      'd, cad.nomcad, lei.indblo'#13#10' from LEITOS lei left outer join CADA' +
      'STRADOS cad on(lei.codcad = cad.codcad)'#13#10' inner join QUARTOS qua' +
      ' on(lei.codqua = qua.codqua) and lei.codlei = :codlei'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codlei'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 144
    Top = 416
    object SQLLeitoCODLEI: TIntegerField
      FieldName = 'CODLEI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLLeitoCODQUA: TIntegerField
      FieldName = 'CODQUA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLLeitoNUMQUA: TSmallintField
      FieldName = 'NUMQUA'
      ProviderFlags = []
      Required = True
    end
    object SQLLeitoNUMLEI: TSmallintField
      FieldName = 'NUMLEI'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLLeitoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLLeitoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLLeitoINDBLO: TStringField
      FieldName = 'INDBLO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspLeito: TDataSetProvider
    DataSet = SQLLeito
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspLeitoGetTableName
    Left = 184
    Top = 416
  end
  object SQLInscrto: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select APECAD, CODCAD, CODCON, CODFOC, CODINS, CODLEI, DATCHE, D' +
      'ATINS, DATSAI, HORCHE, HORSAI, INDMON, INDSUB, MATCAD, MODTRA, N' +
      'OMALO, NOMCAD, NUMINS, NUMLEI, NUMQUA, SEXCAD, SIGDIS, SIGFOC, I' +
      'NDPRE, FORINS, USURES '#13#10'from VIW_INSCRICOES where codins = :codi' +
      'ns'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codins'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 144
    Top = 544
    object SQLInscrtoAPECAD: TStringField
      FieldName = 'APECAD'
      ProviderFlags = []
      Size = 30
    end
    object SQLInscrtoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = []
    end
    object SQLInscrtoCODINS: TIntegerField
      FieldName = 'CODINS'
      ProviderFlags = [pfInUpdate, pfInKey]
    end
    object SQLInscrtoCODLEI: TIntegerField
      FieldName = 'CODLEI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoDATCHE: TDateField
      FieldName = 'DATCHE'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoDATINS: TSQLTimeStampField
      FieldName = 'DATINS'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoDATSAI: TDateField
      FieldName = 'DATSAI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoHORCHE: TTimeField
      FieldName = 'HORCHE'
      ProviderFlags = [pfInUpdate]
      EditMask = '99:99'
    end
    object SQLInscrtoHORSAI: TTimeField
      FieldName = 'HORSAI'
      ProviderFlags = [pfInUpdate]
      EditMask = '99:99'
    end
    object SQLInscrtoINDMON: TStringField
      FieldName = 'INDMON'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLInscrtoINDSUB: TStringField
      FieldName = 'INDSUB'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLInscrtoMATCAD: TStringField
      FieldName = 'MATCAD'
      ProviderFlags = []
      Size = 10
    end
    object SQLInscrtoMODTRA: TSmallintField
      FieldName = 'MODTRA'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoNOMALO: TStringField
      FieldName = 'NOMALO'
      ProviderFlags = []
      Size = 70
    end
    object SQLInscrtoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLInscrtoNUMINS: TIntegerField
      FieldName = 'NUMINS'
      ProviderFlags = []
    end
    object SQLInscrtoNUMLEI: TSmallintField
      FieldName = 'NUMLEI'
      ProviderFlags = []
    end
    object SQLInscrtoNUMQUA: TSmallintField
      FieldName = 'NUMQUA'
      ProviderFlags = []
    end
    object SQLInscrtoSEXCAD: TStringField
      FieldName = 'SEXCAD'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
    object SQLInscrtoSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLInscrtoSIGFOC: TStringField
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLInscrtoUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 31
    end
    object SQLInscrtoFORINS: TSmallintField
      FieldName = 'FORINS'
      ProviderFlags = [pfInUpdate]
    end
    object SQLInscrtoINDPRE: TStringField
      FieldName = 'INDPRE'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object DspInscrito: TDataSetProvider
    DataSet = SQLInscrto
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspInscritoGetTableName
    OnGetDataSetProperties = DspInscritoGetDataSetProperties
    Left = 184
    Top = 544
  end
  object SQLDetalhesInscricao: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select det.coddet, det.codins, det.codite, det.valinf, ite.codfl' +
      'a, fla.desfla'#13#10'from DETALHE_INSCRICAO det'#13#10' join ITENS_INSCRICAO' +
      ' ite using (codite)'#13#10' join FLAGS_INSCRICOES fla using (codfla)'#13#10 +
      'where codins = :codins'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codins'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 248
    Top = 544
    object SQLDetalhesInscricaoCODDET: TIntegerField
      FieldName = 'CODDET'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLDetalhesInscricaoCODINS: TIntegerField
      FieldName = 'CODINS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDetalhesInscricaoCODITE: TIntegerField
      FieldName = 'CODITE'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDetalhesInscricaoVALINF: TStringField
      FieldName = 'VALINF'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLDetalhesInscricaoCODFLA: TIntegerField
      FieldName = 'CODFLA'
      ProviderFlags = []
      Required = True
    end
    object SQLDetalhesInscricaoDESFLA: TStringField
      FieldName = 'DESFLA'
      ProviderFlags = []
      Required = True
      Size = 70
    end
  end
  object DspDetalhesInscricao: TDataSetProvider
    DataSet = SQLDetalhesInscricao
    Options = [poDisableInserts, poDisableDeletes, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspDetalhesInscricaoGetTableName
    Left = 288
    Top = 544
  end
  object SQLClassificadoresCadastrados: TSQLDataSet
    CommandText = 
      'select cad.codatrcad, cad.codatr, cad.codcad, cad.codfoc, atr.si' +
      'gatr, atr.desatrcad'#13#10'from ATRIBUTOS_CADASTRADOS cad'#13#10'join ATRIBU' +
      'TOS atr using (codatr)'#13#10'where cad.codcad = :codcad and codfoc = ' +
      ':codfoc'#13#10'order by atr.sigatr'
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
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 312
    Top = 420
    object SQLClassificadoresCadastradosCODATRCAD: TIntegerField
      FieldName = 'CODATRCAD'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLClassificadoresCadastradosCODATR: TIntegerField
      FieldName = 'CODATR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLClassificadoresCadastradosCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLClassificadoresCadastradosCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLClassificadoresCadastradosSIGATR: TStringField
      DisplayLabel = 'Sigla'
      DisplayWidth = 10
      FieldName = 'SIGATR'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLClassificadoresCadastradosDESATRCAD: TStringField
      DisplayLabel = 'Classificador'
      FieldName = 'DESATRCAD'
      ProviderFlags = []
      Required = True
      Size = 50
    end
  end
  object DspClassificadoresCadastrados: TDataSetProvider
    DataSet = SQLClassificadoresCadastrados
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspClassificadoresCadastradosGetTableName
    OnGetDataSetProperties = DspClassificadoresCadastradosGetDataSetProperties
    Left = 360
    Top = 420
  end
  object SQLTarefasArea: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select * from TAREFAS_STAFF where codare = :codare order by dest' +
      'ar'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codare'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 304
    Top = 24
    object SQLTarefasAreaCODTAR: TIntegerField
      FieldName = 'CODTAR'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLTarefasAreaDESTAR: TStringField
      DisplayLabel = 'Tarefa'
      FieldName = 'DESTAR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLTarefasAreaCODARE: TIntegerField
      FieldName = 'CODARE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
  end
  object DspTarefasArea: TDataSetProvider
    DataSet = SQLTarefasArea
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetDataSetProperties = DspTarefasAreaGetDataSetProperties
    Left = 344
    Top = 24
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
    Left = 312
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
    Left = 344
    Top = 88
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
    Left = 312
    Top = 144
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
      DisplayWidth = 20
      FieldName = 'DATREC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLRecebimentosDATCAD: TSQLTimeStampField
      DisplayLabel = 'Cadastro'
      DisplayWidth = 20
      FieldName = 'DATCAD'
      ProviderFlags = []
      Required = True
    end
    object SQLRecebimentosUSURES: TStringField
      DisplayLabel = 'Respos'#225'vel'
      DisplayWidth = 25
      FieldName = 'USURES'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 31
    end
  end
  object DspRecebimentos: TDataSetProvider
    DataSet = SQLRecebimentos
    Options = [poIncFieldProps, poDisableInserts, poDisableEdits, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 344
    Top = 144
  end
  object SQLTiposRecebimentos: TSQLDataSet
    CommandText = 'select * from tipos_recebimentos order by destiprec'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 312
    Top = 256
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
    OnGetTableName = DspTiposRecebimentosGetTableName
    OnGetDataSetProperties = DspTiposRecebimentosGetDataSetProperties
    Left = 344
    Top = 256
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
    Left = 312
    Top = 200
    object IntegerField2: TIntegerField
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
    object IntegerField3: TIntegerField
      FieldName = 'CODTIPREC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object StringField4: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 30
      FieldName = 'DESTIPREC'
      ProviderFlags = []
      Size = 70
    end
    object IntegerField4: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object StringField5: TStringField
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
      ProviderFlags = []
    end
    object StringField6: TStringField
      DisplayLabel = 'Respos'#225'vel'
      FieldName = 'USURES'
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
  end
  object DspRecebimento: TDataSetProvider
    DataSet = SQLRecebimento
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspRecebimentoGetTableName
    OnGetDataSetProperties = DspRecebimentoGetDataSetProperties
    Left = 344
    Top = 200
  end
  object SQLCrachas: TSQLDataSet
    CommandText = 
      'select ins.codins, ins.nomcon, ins.matcad, ins.nomcad, ins.sigdi' +
      's, ins.sigfoc,'#13#10' ins.nomalo, ins.numqua, ins.numlei,'#13#10' case ins.' +
      'indmon'#13#10'  when '#39'S'#39' then '#39'Monitor de quarto'#39#13#10'  when '#39'N'#39' then '#39'-'#39 +
      #13#10' end as "indmon",'#13#10#13#10' case ins.indsub'#13#10'  when '#39'S'#39' then '#39'Monito' +
      'r substituto'#39#13#10'  when '#39'N'#39' then '#39'-'#39#13#10' end as "indsub"'#13#10#13#10' from vi' +
      'w_inscricoes ins'#13#10' where ins.codcon = :codcon'#13#10' order by ins.nom' +
      'cad'
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
    Left = 440
    Top = 24
    object SQLCrachasCODINS: TIntegerField
      FieldName = 'CODINS'
    end
    object SQLCrachasNOMCON: TStringField
      FieldName = 'NOMCON'
      Size = 70
    end
    object SQLCrachasMATCAD: TStringField
      FieldName = 'MATCAD'
      Size = 10
    end
    object SQLCrachasNOMCAD: TStringField
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLCrachasSIGDIS: TStringField
      FieldName = 'SIGDIS'
      FixedChar = True
      Size = 3
    end
    object SQLCrachasSIGFOC: TStringField
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLCrachasNOMALO: TStringField
      FieldName = 'NOMALO'
      Size = 70
    end
    object SQLCrachasNUMQUA: TSmallintField
      FieldName = 'NUMQUA'
    end
    object SQLCrachasNUMLEI: TSmallintField
      FieldName = 'NUMLEI'
    end
    object SQLCrachasindmon: TStringField
      FieldName = 'indmon'
      FixedChar = True
      Size = 17
    end
    object SQLCrachasindsub: TStringField
      FieldName = 'indsub'
      FixedChar = True
      Size = 18
    end
  end
  object DspCrachas: TDataSetProvider
    DataSet = SQLCrachas
    Options = [poIncFieldProps, poUseQuoteChar]
    OnGetTableName = DspTiposRecebimentosGetTableName
    OnGetDataSetProperties = DspTiposRecebimentosGetDataSetProperties
    Left = 472
    Top = 24
  end
  object DspParticipantesTipoAtividade: TDataSetProvider
    DataSet = SQLParticipantesTipoAtividade
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspParticipantesTipoAtividadeGetTableName
    OnGetDataSetProperties = DspParticipantesTipoAtividadeGetDataSetProperties
    Left = 496
    Top = 88
  end
  object SQLParticipantesTipoAtividade: TSQLDataSet
    CommandText = 
      'select par.codpar, par.codtipati, par.coddis, dis.nomdis'#13#10'from p' +
      'articipantes par'#13#10'inner join discipulados dis on (dis.coddis = p' +
      'ar.coddis)'#13#10'and par.codtipati = :codtipati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtipati'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 464
    Top = 88
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
  object DspProgramacaoReport: TDataSetProvider
    DataSet = SQLProgramacaoReport
    Options = [poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 584
    Top = 304
  end
  object SQLProgramacaoReport: TSQLDataSet
    CommandText = 
      'select ati.destipati, ati.datati, ati.horati, ati.nomcon,'#13#10'   ca' +
      'se EXTRACT(weekday from ati.datati)'#13#10'     WHEN 0 THEN '#39'Domingo'#39#13 +
      #10'     WHEN 1 THEN '#39'Segunda-feira'#39#13#10'     WHEN 2 THEN '#39'Ter'#231'a-feira' +
      #39#13#10'     WHEN 3 THEN '#39'Quarta-feira'#39#13#10'     WHEN 4 THEN '#39'Quinta-fei' +
      'ra'#39#13#10'     WHEN 5 THEN '#39'Sexta-feira'#39#13#10'     WHEN 6 THEN '#39'S'#225'bado'#39#13#10 +
      '   END as "DIA_SEMANA"'#13#10#13#10#13#10' from viw_atividades ati'#13#10'where codc' +
      'on = 6'#13#10'order by datati, horati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 552
    Top = 304
  end
  object SQLQuartosAlojamento: TSQLDataSet
    CommandText = 
      'select qua.codqua, qua.alaqua, qua.numqua, qua.codalo, alo.nomal' +
      'o, qua.indtra'#13#10' from quartos qua'#13#10' inner join alojamentos alo on' +
      ' (qua.codalo = alo.codalo)'#13#10' and qua.codalo = :codalo'#13#10'order by ' +
      'qua.alaqua, qua.numqua'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codalo'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 312
    Top = 312
    object SQLQuartosAlojamentoCODQUA: TIntegerField
      FieldName = 'CODQUA'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLQuartosAlojamentoALAQUA: TStringField
      DisplayLabel = 'Ala'
      FieldName = 'ALAQUA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 10
    end
    object SQLQuartosAlojamentoNUMQUA: TSmallintField
      DisplayLabel = 'Quarto'
      FieldName = 'NUMQUA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLQuartosAlojamentoCODALO: TIntegerField
      FieldName = 'CODALO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLQuartosAlojamentoNOMALO: TStringField
      DisplayLabel = 'Alojamento'
      FieldName = 'NOMALO'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLQuartosAlojamentoINDTRA: TStringField
      DisplayLabel = 'Indispon'#237'vel'
      FieldName = 'INDTRA'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspQuartosAlojamento: TDataSetProvider
    DataSet = SQLQuartosAlojamento
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspQuartosAlojamentoGetTableName
    OnGetDataSetProperties = DspQuartosAlojamentoGetDataSetProperties
    Left = 352
    Top = 312
  end
  object SQLLeitoQuarto: TSQLDataSet
    CommandText = 
      'select codlei, codqua, numqua, alaqua, numlei, codcad,'#13#10'nomcad, ' +
      'codalo, nomalo, indblo from viw_leitos'#13#10'where codlei = :codlei'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codlei'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 312
    Top = 368
    object SQLLeitoQuartoCODLEI: TIntegerField
      FieldName = 'CODLEI'
      ProviderFlags = [pfInUpdate, pfInKey]
    end
    object SQLLeitoQuartoCODQUA: TIntegerField
      FieldName = 'CODQUA'
      ProviderFlags = [pfInUpdate]
    end
    object SQLLeitoQuartoNUMQUA: TSmallintField
      FieldName = 'NUMQUA'
      ProviderFlags = []
    end
    object SQLLeitoQuartoALAQUA: TStringField
      FieldName = 'ALAQUA'
      ProviderFlags = []
      Size = 10
    end
    object SQLLeitoQuartoNUMLEI: TSmallintField
      FieldName = 'NUMLEI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLLeitoQuartoCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
    end
    object SQLLeitoQuartoNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLLeitoQuartoCODALO: TIntegerField
      FieldName = 'CODALO'
      ProviderFlags = []
    end
    object SQLLeitoQuartoNOMALO: TStringField
      FieldName = 'NOMALO'
      ProviderFlags = []
      Size = 70
    end
    object SQLLeitoQuartoINDBLO: TStringField
      FieldName = 'INDBLO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object DspLeitoQuarto: TDataSetProvider
    DataSet = SQLLeitoQuarto
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspLeitoQuartoGetTableName
    OnGetDataSetProperties = DspLeitoQuartoGetDataSetProperties
    Left = 352
    Top = 368
  end
  object SQLFlagsInscricoes: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select codfla, desfla, desimp from FLAGS_INSCRICOES order by des' +
      'fla'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = 1
    Params = <>
    SQLConnection = SQLCon
    Left = 16
    Top = 600
    object SQLFlagsInscricoesCODFLA: TIntegerField
      FieldName = 'CODFLA'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLFlagsInscricoesDESFLA: TStringField
      DisplayLabel = 'Informa'#231#227'o de Inscri'#231#227'o'
      FieldName = 'DESFLA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLFlagsInscricoesDESIMP: TStringField
      DisplayLabel = 'Descri'#231#227'o (para impress'#227'o)'
      FieldName = 'DESIMP'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object DspFlagsInscricoes: TDataSetProvider
    DataSet = SQLFlagsInscricoes
    Options = [poIncFieldProps, poDisableDeletes, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetDataSetProperties = DspFlagsInscricoesGetDataSetProperties
    Left = 56
    Top = 600
  end
  object SQLDetalhesInscricoes: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select ite.codite, ite.codfla,  fla.desfla, ite.codfoc, ite.ordi' +
      'te'#13#10' from ITENS_INSCRICAO ite'#13#10' join FLAGS_INSCRICOES fla using(' +
      'codfla)'#13#10' where ite.codfoc = :codfoc order by ite.ordite'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 144
    Top = 600
    object SQLDetalhesInscricoesCODITE: TIntegerField
      FieldName = 'CODITE'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLDetalhesInscricoesCODFLA: TIntegerField
      FieldName = 'CODFLA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLDetalhesInscricoesDESFLA: TStringField
      DisplayLabel = 'Informa'#231#227'o'
      DisplayWidth = 50
      FieldName = 'DESFLA'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDetalhesInscricoesCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLDetalhesInscricoesORDITE: TSmallintField
      DisplayLabel = 'Ordem'
      FieldName = 'ORDITE'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
  object DspDetalhesInscricoes: TDataSetProvider
    DataSet = SQLDetalhesInscricoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspDetalhesInscricoesGetTableName
    OnGetDataSetProperties = DspDetalhesInscricoesGetDataSetProperties
    Left = 184
    Top = 600
  end
  object SQLExternalReports: TSQLDataSet
    CommandText = 
      'select * from RELATORIOS_EXTERNOS where indcon = '#39'S'#39' '#13#10'order by ' +
      'nomrel'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 552
    Top = 376
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
    Left = 584
    Top = 376
  end
  object SQLParticipantes: TSQLDataSet
    CommandText = 
      'select ati.codatidis, ati.codati, ati.coddis, dis.nomdis from at' +
      'ividades_discipulados ati'#13#10' inner join discipulados dis on (dis.' +
      'coddis = ati.coddis)'#13#10'and ati.codati = :codati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 464
    Top = 144
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
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspParticipantesGetTableName
    OnGetDataSetProperties = DspParticipantesGetDataSetProperties
    Left = 496
    Top = 144
  end
  object SQLFocosParticipantes: TSQLDataSet
    CommandText = 
      'select ati.codatifoc, ati.codati, ati.codfoc, foc.nomfoc, foc.si' +
      'gfoc from atividades_focos ati'#13#10' inner join focos foc on (foc.co' +
      'dfoc = ati.codfoc)'#13#10' and ati.codati = :codati'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codati'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 464
    Top = 208
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
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspFocosParticipantesGetTableName
    OnGetDataSetProperties = DspFocosParticipantesGetDataSetProperties
    Left = 496
    Top = 208
  end
  object SQLDetalheInscricoes: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select ite.codite, ite.codfla,  fla.desfla, ite.codfoc, ite.ordi' +
      'te'#13#10' from ITENS_INSCRICAO ite'#13#10' join FLAGS_INSCRICOES fla using(' +
      'codfla)'#13#10' where ite.codite = :codite'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codite'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 144
    Top = 656
    object SQLDetalheInscricoesCODITE: TIntegerField
      FieldName = 'CODITE'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLDetalheInscricoesCODFLA: TIntegerField
      FieldName = 'CODFLA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLDetalheInscricoesDESFLA: TStringField
      DisplayLabel = 'Informa'#231#227'o'
      DisplayWidth = 50
      FieldName = 'DESFLA'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDetalheInscricoesCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLDetalheInscricoesORDITE: TSmallintField
      DisplayLabel = 'Ordem'
      FieldName = 'ORDITE'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
  object DspDetalheInscricoes: TDataSetProvider
    DataSet = SQLDetalheInscricoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspDetalhesInscricoesGetTableName
    OnGetDataSetProperties = DspDetalhesInscricoesGetDataSetProperties
    Left = 184
    Top = 656
  end
  object SQLStaffTarefa: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select codsta, codins, indfix, datsta, horini, horter, codtar, m' +
      'ensta, nomcad, matcad, sexcad,'#13#10' sigdis, sigfoc from VIW_STAFF w' +
      'here codtar = :codtar and codcon = :codcon'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codtar'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 416
    Top = 544
    object SQLStaffTarefaCODSTA: TIntegerField
      FieldName = 'CODSTA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object SQLStaffTarefaCODINS: TIntegerField
      FieldName = 'CODINS'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLStaffTarefaMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Size = 10
    end
    object SQLStaffTarefaNOMCAD: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 50
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLStaffTarefaSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLStaffTarefaSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLStaffTarefaSEXCAD: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
    object SQLStaffTarefaINDFIX: TStringField
      DisplayLabel = 'Fixo'
      FieldName = 'INDFIX'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLStaffTarefaDATSTA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATSTA'
      ProviderFlags = [pfInUpdate]
    end
    object SQLStaffTarefaHORINI: TTimeField
      DisplayLabel = 'In'#237'cio'
      FieldName = 'HORINI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLStaffTarefaHORTER: TTimeField
      DisplayLabel = 'T'#233'rmino'
      FieldName = 'HORTER'
      ProviderFlags = [pfInUpdate]
    end
    object SQLStaffTarefaMENSTA: TMemoField
      DisplayLabel = 'Mensage'
      FieldName = 'MENSTA'
      ProviderFlags = [pfInUpdate]
      Visible = False
      BlobType = ftMemo
      Size = 1
    end
    object SQLStaffTarefaCODTAR: TIntegerField
      FieldName = 'CODTAR'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object DspStaffTarefa: TDataSetProvider
    DataSet = SQLStaffTarefa
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspTipoAtividadeUpdateError
    OnGetTableName = DspStaffTarefaGetTableName
    OnGetDataSetProperties = DspStaffTarefaGetDataSetProperties
    Left = 416
    Top = 592
  end
  object DspRecados: TDataSetProvider
    DataSet = SQLRecados
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 592
    Top = 448
  end
  object SQLRecados: TSQLDataSet
    SchemaName = 'sysdba'
    CommandText = 
      'select codnot, codins, assnot, cast(substring(notins from 1 for ' +
      '55) || '#39'...'#39' as varchar(60)) as notins,'#13#10' case indcra'#13#10'  when '#39'S' +
      #39' then '#39'Sim'#39#13#10'  when '#39'N'#39' then '#39'N'#227'o'#39#13#10' end as indcra'#13#10#13#10'  from no' +
      'tas_inscrito where codins = :codins'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'codins'
        ParamType = ptInput
        Value = 0
      end>
    SQLConnection = SQLCon
    Left = 552
    Top = 448
    object SQLRecadosCODNOT: TIntegerField
      FieldName = 'CODNOT'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLRecadosCODINS: TIntegerField
      FieldName = 'CODINS'
      ProviderFlags = []
      Required = True
      Visible = False
    end
    object SQLRecadosASSNOT: TStringField
      FieldName = 'ASSNOT'
      ProviderFlags = []
      Required = True
      Size = 35
    end
    object SQLRecadosNOTINS: TStringField
      FieldName = 'NOTINS'
      ProviderFlags = []
      Required = True
      Size = 60
    end
    object SQLRecadosINDCRA: TStringField
      FieldName = 'INDCRA'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 3
    end
  end
  object SQLAlojadosQuarto: TSQLDataSet
    CommandText = 
      'select lei.codlei, lei.numqua, lei.numlei,'#13#10' cad.nomcad, cad.sex' +
      'cad, cad.sigdis, cad.sigfoc,'#13#10' (extract(year from current_date) ' +
      '- extract(year from cad.datnas)) as "idade" ,'#13#10' case ins.indmon'#13 +
      #10'  when '#39'S'#39' then '#39'Sim'#39#13#10'  when '#39'N'#39' then '#39'N'#227'o'#39#13#10' end as "indmon",' +
      #13#10#13#10' case ins.indsub'#13#10'  when '#39'S'#39' then '#39'Sim'#39#13#10'  when '#39'N'#39' then '#39'N'#227 +
      'o'#39#13#10' end as "indsub"'#13#10#13#10'from viw_leitos lei'#13#10' left outer join in' +
      'scricoes ins using (codlei)'#13#10' left outer join viw_cadastrados ca' +
      'd on (cad.codcad = ins.codcad)'#13#10' where lei.codqua = :codqua and ' +
      'ins.codcon = :codcon'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'codqua'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'codcon'
        ParamType = ptInput
      end>
    SQLConnection = SQLCon
    Left = 552
    Top = 520
    object SQLAlojadosQuartoCODLEI: TIntegerField
      FieldName = 'CODLEI'
      Visible = False
    end
    object SQLAlojadosQuartoNUMQUA: TSmallintField
      DisplayLabel = 'Quarto'
      FieldName = 'NUMQUA'
      Visible = False
    end
    object SQLAlojadosQuartoNUMLEI: TSmallintField
      DisplayLabel = 'Leito'
      DisplayWidth = 7
      FieldName = 'NUMLEI'
    end
    object SQLAlojadosQuartoNOMCAD: TStringField
      DisplayLabel = 'Alojado'
      FieldName = 'NOMCAD'
      Size = 70
    end
    object SQLAlojadosQuartoSEXCAD: TStringField
      DisplayLabel = 'Sexo'
      FieldName = 'SEXCAD'
      FixedChar = True
      Size = 1
    end
    object SQLAlojadosQuartoSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      FixedChar = True
      Size = 3
    end
    object SQLAlojadosQuartoSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      FixedChar = True
      Size = 4
    end
    object SQLAlojadosQuartoidade: TLargeintField
      DisplayLabel = 'Idade'
      DisplayWidth = 8
      FieldName = 'idade'
    end
    object SQLAlojadosQuartoindmon: TStringField
      DisplayLabel = 'Monitor'
      FieldName = 'indmon'
      FixedChar = True
      Size = 3
    end
    object SQLAlojadosQuartoindsub: TStringField
      DisplayLabel = 'Substituto'
      FieldName = 'indsub'
      FixedChar = True
      Size = 3
    end
  end
  object DspAlojadosQuarto: TDataSetProvider
    DataSet = SQLAlojadosQuarto
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 592
    Top = 520
  end
  object SQLReports: TSQLDataSet
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 592
    Top = 24
  end
  object DspReports: TDataSetProvider
    DataSet = SQLReports
    Options = [poIncFieldProps, poAllowCommandText, poUseQuoteChar]
    Left = 640
    Top = 24
  end
end
