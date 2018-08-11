object DMUserMethods: TDMUserMethods
  OldCreateOrder = False
  Height = 391
  Width = 462
  object SQLUser: TSQLDataSet
    BeforeOpen = SQLUserBeforeOpen
    CommandText = 
      'select   NOMCAD, APECAD, MATCAD, SIGFOC, SIGDIS,'#13#10'  INDATI,  IND' +
      'ADM'#13#10'from viw_usuarios where codcad = :codcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 32
  end
  object DspUser: TDataSetProvider
    DataSet = SQLUser
    Options = [poReadOnly, poUseQuoteChar]
    Left = 88
    Top = 32
  end
  object SQLFocos: TSQLDataSet
    BeforeOpen = SQLUserBeforeOpen
    CommandText = 
      'select pri.codpri, pri.codusu, pri.codfoc, foc.nomfoc, foc.sigfo' +
      'c'#13#10'from privilegios pri'#13#10'inner join focos foc on(foc.codfoc = pr' +
      'i.codfoc)'#13#10'where pri.codusu = :codusu'#13#10'and pri.codgru = :codgru'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'codusu'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'codgru'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 112
    object SQLFocosCODPRI: TIntegerField
      FieldName = 'CODPRI'
      Required = True
      Visible = False
    end
    object SQLFocosCODUSU: TIntegerField
      FieldName = 'CODUSU'
      Required = True
      Visible = False
    end
    object SQLFocosCODFOC: TIntegerField
      FieldName = 'CODFOC'
      Required = True
      Visible = False
    end
    object SQLFocosNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      Required = True
      Size = 70
    end
    object SQLFocosSIGFOC: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGFOC'
      Required = True
      FixedChar = True
      Size = 4
    end
  end
  object DspFocos: TDataSetProvider
    DataSet = SQLFocos
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    Left = 88
    Top = 112
  end
  object SQLListFocosUsuario: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLUserBeforeOpen
    CommandText = 
      'select usu.codusu, usu.logusu, pri.codpri, pri.codfoc, foc.nomfo' +
      'c, foc.sigfoc,'#13#10' case pri.tipper'#13#10'  when '#39'E'#39' then '#39'Escrita'#39#13#10'  w' +
      'hen '#39'L'#39' then '#39'Leitura'#39#13#10' end as tipper'#13#10'  from usuarios usu'#13#10'   ' +
      'inner join privilegios pri on (pri.codusu = usu.codusu)'#13#10'   inne' +
      'r join focos foc on (foc.codfoc = pri.codfoc)'#13#10'   and usu.codcad' +
      ' = :codcad'#13#10'order by foc.nomfoc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codcad'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 208
    object SQLListFocosUsuarioCODUSU: TIntegerField
      FieldName = 'CODUSU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLListFocosUsuarioLOGUSU: TStringField
      FieldName = 'LOGUSU'
      ProviderFlags = []
      Visible = False
      FixedChar = True
      Size = 31
    end
    object SQLListFocosUsuarioCODPRI: TIntegerField
      FieldName = 'CODPRI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object SQLListFocosUsuarioCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLListFocosUsuarioNOMFOC: TStringField
      DisplayLabel = 'Foco'
      DisplayWidth = 40
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLListFocosUsuarioSIGFOC: TStringField
      DisplayLabel = 'Sigla'
      DisplayWidth = 6
      FieldName = 'SIGFOC'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 4
    end
    object SQLListFocosUsuarioTIPPER: TStringField
      DisplayLabel = 'Permiss'#227'o'
      DisplayWidth = 20
      FieldName = 'TIPPER'
      ProviderFlags = []
      FixedChar = True
      Size = 7
    end
  end
  object DspListFocosUsuario: TDataSetProvider
    DataSet = SQLListFocosUsuario
    Options = [poIncFieldProps, poReadOnly, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 208
  end
  object SQLPerfis: TSQLDataSet
    BeforeOpen = SQLUserBeforeOpen
    CommandText = 
      'select codper, nomper, indlec, indtmo, indtmb, indtpu, indein, i' +
      'ndsim'#13#10'from PERFIS order by nomper'
    MaxBlobSize = -1
    Params = <>
    Left = 192
    Top = 32
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
    object SQLPerfisINDSIM: TStringField
      DisplayLabel = 'Simpatizantes'
      FieldName = 'INDSIM'
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
    Left = 256
    Top = 32
  end
  object SQLPerfil: TSQLDataSet
    BeforeOpen = SQLUserBeforeOpen
    CommandText = 
      'select codper, nomper, desper,  indlec, indtmo, indtmb, indtpu, ' +
      'indein, indsim, abrper from PERFIS where codper = :codper'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codper'
        ParamType = ptInput
        Value = 0
      end>
    Left = 192
    Top = 112
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
    object SQLPerfilINDSIM: TStringField
      FieldName = 'INDSIM'
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
  end
  object DspPerfil: TDataSetProvider
    DataSet = SQLPerfil
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspFocosUsuarioUpdateError
    OnGetDataSetProperties = DspPerfilGetDataSetProperties
    Left = 256
    Top = 112
  end
  object SQLFocosUsuario: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLUserBeforeOpen
    CommandText = 
      'select usu.codusu, pri.codpri, pri.codfoc, pri.indsec, pri.indfo' +
      'c, pri.indfin, pri.indcon, pri.indusu, foc.nomfoc, foc.sigfoc,'#13#10 +
      ' pri.tipper'#13#10'  from usuarios usu'#13#10'   inner join privilegios pri ' +
      'on (pri.codusu = usu.codusu)'#13#10'   inner join focos foc on (foc.co' +
      'dfoc = pri.codfoc)'#13#10'   and usu.codusu = :codusu'#13#10'   and pri.codp' +
      'ri = :codpri'#13#10'order by foc.nomfoc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'codusu'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'codpri'
        ParamType = ptInput
      end>
    Left = 32
    Top = 296
    object IntegerField2: TIntegerField
      FieldName = 'CODPRI'
      ProviderFlags = [pfInUpdate, pfInKey]
      Visible = False
    end
    object IntegerField1: TIntegerField
      FieldName = 'CODUSU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object IntegerField3: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object StringField2: TStringField
      DisplayLabel = 'Foco'
      DisplayWidth = 40
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object StringField3: TStringField
      DisplayLabel = 'Sigla'
      DisplayWidth = 6
      FieldName = 'SIGFOC'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 4
    end
    object StringField4: TStringField
      DisplayLabel = 'Permiss'#227'o'
      DisplayWidth = 20
      FieldName = 'TIPPER'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLFocosUsuarioINDSEC: TStringField
      FieldName = 'INDSEC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocosUsuarioINDFOC: TStringField
      FieldName = 'INDFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocosUsuarioINDFIN: TStringField
      FieldName = 'INDFIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocosUsuarioINDCON: TStringField
      FieldName = 'INDCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocosUsuarioINDUSU: TStringField
      FieldName = 'INDUSU'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspFocosUsuario: TDataSetProvider
    DataSet = SQLFocosUsuario
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DspFocosUsuarioUpdateError
    OnGetTableName = DspFocosUsuarioGetTableName
    OnGetDataSetProperties = DspFocosUsuarioGetDataSetProperties
    Left = 88
    Top = 296
  end
end
