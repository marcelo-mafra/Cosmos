object DMCosmosFocosMethods: TDMCosmosFocosMethods
  OldCreateOrder = False
  Height = 487
  Width = 611
  object SQLFoco: TSQLDataSet
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 
      'select foc.codfoc, foc.nomfoc, foc.sigfoc, foc.nomtem, foc.tipfo' +
      'c, foc.codreg,'#13#10'reg.nomreg, foc.focpai, pai.nomfoc as "nompai", ' +
      'foc.indlec, foc.indtpu, foc.indtmo, foc.indtmb, foc.indein,'#13#10'foc' +
      '.indind, foc.indati, foc.indnac, foc.indcab'#13#10'from focos foc'#13#10'inn' +
      'er join regioes reg on(reg.codreg = foc.codreg)'#13#10'left outer join' +
      ' focos pai on (foc.focpai = pai.codfoc)'#13#10'where foc.codfoc = :cod' +
      'foc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 24
    object SQLFocoCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInKey]
      Required = True
    end
    object SQLFocoNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
    object SQLFocoSIGFOC: TStringField
      DisplayWidth = 3
      FieldName = 'SIGFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 4
    end
    object SQLFocoNOMTEM: TStringField
      FieldName = 'NOMTEM'
      ProviderFlags = [pfInUpdate]
      Size = 35
    end
    object SQLFocoTIPFOC: TStringField
      FieldName = 'TIPFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLFocoCODREG: TIntegerField
      FieldName = 'CODREG'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLFocoNOMREG: TStringField
      FieldName = 'NOMREG'
      ProviderFlags = []
      Required = True
      Size = 35
    end
    object SQLFocoFOCPAI: TIntegerField
      FieldName = 'FOCPAI'
      ProviderFlags = [pfInUpdate]
    end
    object SQLFoconompai: TStringField
      FieldName = 'NOMPAI'
      ProviderFlags = []
      Size = 70
    end
    object SQLFocoINDLEC: TStringField
      FieldName = 'INDLEC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDTPU: TStringField
      FieldName = 'INDTPU'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDTMO: TStringField
      FieldName = 'INDTMO'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDTMB: TStringField
      FieldName = 'INDTMB'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDEIN: TStringField
      FieldName = 'INDEIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDIND: TStringField
      FieldName = 'INDIND'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDATI: TStringField
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDNAC: TStringField
      FieldName = 'INDNAC'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLFocoINDCAB: TStringField
      FieldName = 'INDCAB'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DspFoco: TDataSetProvider
    DataSet = SQLFoco
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 64
    Top = 24
  end
  object SQLMeiosContatosFocos: TSQLDataSet
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 
      'select mcon.codtipcon, tc.destipcon, mcon.descon, mcon.codfoc, m' +
      'con.codcon,  mcon.indcar, mcon.datcad, mcon.usures'#13#10'from meios_c' +
      'ontatos mcon'#13#10'inner join tipos_contatos tc on (tc.codtipcon = mc' +
      'on.codtipcon)'#13#10'where mcon.codfoc = :codfoc'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codfoc'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 88
    object SQLMeiosContatosFocosCODCON: TIntegerField
      FieldName = 'CODCON'
      ProviderFlags = [pfInKey]
      Visible = False
    end
    object SQLMeiosContatosFocosCODTIPCON: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'CODTIPCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object SQLMeiosContatosFocosDESTIPCON: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'DESTIPCON'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLMeiosContatosFocosDESCON: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object SQLMeiosContatosFocosCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object SQLMeiosContatosFocosINDCAR: TStringField
      FieldName = 'INDCAR'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLMeiosContatosFocosDATCAD: TSQLTimeStampField
      DisplayLabel = 'Data'
      FieldName = 'DATCAD'
      ProviderFlags = []
      ReadOnly = True
    end
    object SQLMeiosContatosFocosUSURES: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USURES'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 31
    end
  end
  object DspMeiosContatos: TDataSetProvider
    DataSet = SQLMeiosContatosFocos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 64
    Top = 88
  end
  object DspMentores: TDataSetProvider
    DataSet = SQLMentores
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspMentoresGetTableName
    OnGetDataSetProperties = DspMentoresGetDataSetProperties
    Left = 64
    Top = 152
  end
  object SQLMentores: TSQLDataSet
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 
      'select codmen, codreg, nomreg, codcad, nomcad,'#13#10'matcad, sigdis, ' +
      'sigfoc from viw_mentores_ra'#13#10'where codreg = :codreg'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codreg'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 152
    object SQLMentoresCODMEN: TIntegerField
      FieldName = 'CODMEN'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLMentoresCODREG: TIntegerField
      FieldName = 'CODREG'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLMentoresNOMREG: TStringField
      FieldName = 'NOMREG'
      ProviderFlags = []
      Size = 35
    end
    object SQLMentoresCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLMentoresNOMCAD: TStringField
      DisplayLabel = 'Aluno'
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Size = 70
    end
    object SQLMentoresMATCAD: TStringField
      DisplayLabel = 'Matr'#237'cula'
      FieldName = 'MATCAD'
      ProviderFlags = []
      Size = 10
    end
    object SQLMentoresSIGDIS: TStringField
      DisplayLabel = 'Discipulado'
      FieldName = 'SIGDIS'
      ProviderFlags = []
      FixedChar = True
      Size = 3
    end
    object SQLMentoresSIGFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
  end
  object DspDirigentesAtuais: TDataSetProvider
    DataSet = SQLDirigentesAtuais
    Options = [poReadOnly, poUseQuoteChar]
    Left = 64
    Top = 216
  end
  object SQLDirigentesAtuais: TSQLDataSet
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 
      'select * from viw_direcoes where codges in ('#13#10'select max(ges.cod' +
      'ges) from gestoes ges'#13#10'where ges.codorg = :codorg and (current_d' +
      'ate between ges.datini and ges.datter'#13#10'or ges.datter is null) )'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codorg'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 215
  end
  object DspDirigentesGestao: TDataSetProvider
    DataSet = SQLDirigentesGestao
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 64
    Top = 280
  end
  object SQLDirigentesGestao: TSQLDataSet
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 
      'select dir.coddir, dir.codges, dir.codcad, cad.nomcad, cad.matca' +
      'd, dir.coddis, dis.sigdis,dir.codfoc,'#13#10'foc.nomfoc, dir.codcar, c' +
      'ar.descar, dir.indcon'#13#10'from direcoes dir'#13#10'inner join cadastrados' +
      ' cad on(cad.codcad = dir.codcad)'#13#10'inner join discipulados dis on' +
      '(dis.coddis = dir.coddis)'#13#10'inner join focos foc on(foc.codfoc = ' +
      'dir.codfoc)'#13#10'inner join cargos car on(car.codcar = dir.codcar)'#13#10 +
      'and dir.codges = :codges'#13#10'order by cad.nomcad'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 280
  end
  object DspCargos: TDataSetProvider
    DataSet = SQLCargos
    Options = [poIncFieldProps, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetDataSetProperties = DspCargosGetDataSetProperties
    Left = 64
    Top = 344
  end
  object SQLCargos: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 'select * from CARGOS order by descar'
    MaxBlobSize = -1
    Params = <>
    Left = 32
    Top = 344
    object SQLCargosCODCAR: TIntegerField
      FieldName = 'CODCAR'
      ProviderFlags = [pfInUpdate, pfInKey]
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
  object DspTiposContatos: TDataSetProvider
    DataSet = SQLTiposContatos
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 64
    Top = 408
  end
  object SQLTiposContatos: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 'select * from TIPOS_CONTATOS order by destipcon'
    MaxBlobSize = -1
    Params = <>
    Left = 32
    Top = 408
    object SQLTiposContatosCODTIPCON: TIntegerField
      FieldName = 'CODTIPCON'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
    end
    object SQLTiposContatosDESTIPCON: TStringField
      DisplayLabel = 'Meio de Contato'
      FieldName = 'DESTIPCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 70
    end
  end
  object DspOrgaos: TDataSetProvider
    DataSet = SQLOrgaos
    Options = [poIncFieldProps, poPropogateChanges, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspOrgaosGetTableName
    Left = 192
    Top = 160
  end
  object SQLOrgaos: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 'select * from VIW_ORGAOS_GESTORES where codorg = :codorg'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codorg'
        ParamType = ptInput
        Value = 0
      end>
    Left = 160
    Top = 160
    object SQLOrgaosCODORG: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODORG'
      ProviderFlags = [pfInUpdate, pfInKey]
    end
    object SQLOrgaosNOMORG: TStringField
      DefaultExpression = #39'Novo '#243'rg'#227'o gestor'#39
      DisplayLabel = #211'rg'#227'o'
      FieldName = 'NOMORG'
      Size = 50
    end
    object SQLOrgaosNOMORGING: TStringField
      DisplayLabel = 'Tradu'#231#227'o'
      FieldName = 'NOMORGING'
      Size = 50
    end
    object SQLOrgaosSIGORG: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGORG'
      FixedChar = True
      Size = 5
    end
    object SQLOrgaosCODPAI: TIntegerField
      FieldName = 'CODPAI'
    end
    object SQLOrgaosORGSUP: TStringField
      DisplayLabel = 'Subordina'#231#227'o'
      FieldName = 'ORGSUP'
      ProviderFlags = []
      Size = 50
    end
    object SQLOrgaosMANORG: TSmallintField
      DefaultExpression = '12'
      DisplayLabel = 'Mandato'
      FieldName = 'MANORG'
      ProviderFlags = [pfInUpdate]
    end
    object SQLOrgaosROLORG: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'ROLORG'
      FixedChar = True
      Size = 31
    end
    object SQLOrgaosNIVORG: TSmallintField
      DefaultExpression = '3'
      DisplayLabel = 'Esfera'
      FieldName = 'NIVORG'
      Required = True
    end
    object SQLOrgaosCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
    end
    object SQLOrgaosNOMFOC: TStringField
      DisplayLabel = 'Foco'
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Size = 70
    end
    object SQLOrgaosSIGFOC: TStringField
      DisplayLabel = 'Sigla do Foco'
      FieldName = 'SIGFOC'
      ProviderFlags = []
      FixedChar = True
      Size = 4
    end
    object SQLOrgaosINDLEC: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDLEC'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDTMO: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDTMO'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDTMB: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDTMB'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDTPU: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDTPU'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDATA: TStringField
      DefaultExpression = #39'S'#39
      FieldName = 'INDATA'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDATI: TStringField
      DefaultExpression = #39'S'#39
      FieldName = 'INDATI'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosINDNAC: TStringField
      DefaultExpression = #39'S'#39
      FieldName = 'INDNAC'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object SQLOrgaosUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
    object SQLOrgaosDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
    end
  end
  object DspGestoes: TDataSetProvider
    DataSet = SQLGestoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 192
    Top = 32
  end
  object SQLGestoes: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 
      'select ges.codges, ges.codorg, org.nomorg, ges.datini, ges.datte' +
      'r, ges.datcad, ges.usures from GESTOES ges'#13#10'inner join orgaos_ge' +
      'stores org on (org.codorg = ges.codorg)'#13#10'and ges.codges = :codge' +
      's'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end>
    Left = 160
    Top = 32
    object SQLGestoesCODGES: TIntegerField
      FieldName = 'CODGES'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLGestoesCODORG: TIntegerField
      FieldName = 'CODORG'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLGestoesNOMORG: TStringField
      FieldName = 'NOMORG'
      ProviderFlags = []
      Size = 50
    end
    object SQLGestoesDATINI: TDateField
      CustomConstraint = 'DATTER >= DATINI OR DATTER IS NULL'
      ConstraintErrorMessage = 
        'A data do in'#237'cio da gest'#227'o deve ser menor ou igual '#224' data de seu' +
        ' t'#233'rmino!'
      FieldName = 'DATINI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999;1;_'
    end
    object SQLGestoesDATTER: TDateField
      CustomConstraint = 'DATTER >= DATINI OR DATTER IS NULL'
      ConstraintErrorMessage = 
        'A data do in'#237'cio da gest'#227'o deve ser menor ou igual '#224' de seu t'#233'rm' +
        'ino!'
      FieldName = 'DATTER'
      ProviderFlags = [pfInUpdate]
      EditMask = '99/99/9999;1;_'
    end
    object SQLGestoesDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
      EditMask = '99/99/9999;1;_'
    end
    object SQLGestoesUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
  end
  object DspDirecoes: TDataSetProvider
    DataSet = SQLDirecoes
    Options = [poIncFieldProps, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnGetTableName = DspFocoGetTableName
    Left = 192
    Top = 96
  end
  object SQLDirecoes: TSQLDataSet
    SchemaName = 'sysdba'
    BeforeOpen = SQLFocoBeforeOpen
    CommandText = 
      'select dir.coddir, dir.codges, dir.codcad, cad.nomcad, dir.coddi' +
      's, dis.sigdis,dir.codfoc,'#13#10'foc.nomfoc, dir.codcar, car.descar, d' +
      'ir.datini, dir.datter, dir.indcon,'#13#10'dir.obsdir, dir.datcad, dir.' +
      'usures'#13#10'from direcoes dir'#13#10'inner join cadastrados cad on(cad.cod' +
      'cad = dir.codcad)'#13#10'inner join discipulados dis on(dis.coddis = d' +
      'ir.coddis)'#13#10'inner join focos foc on(foc.codfoc = dir.codfoc)'#13#10'in' +
      'ner join cargos car on(car.codcar = dir.codcar)'#13#10'and dir.codges ' +
      '= :codges and'#13#10'dir.coddir = :coddir'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'codges'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'coddir'
        ParamType = ptInput
        Value = 0
      end>
    Left = 160
    Top = 96
    object SQLDirecoesCODDIR: TIntegerField
      FieldName = 'CODDIR'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLDirecoesCODGES: TIntegerField
      FieldName = 'CODGES'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesCODCAD: TIntegerField
      FieldName = 'CODCAD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesCODFOC: TIntegerField
      FieldName = 'CODFOC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesCODDIS: TIntegerField
      FieldName = 'CODDIS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesNOMCAD: TStringField
      FieldName = 'NOMCAD'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDirecoesSIGDIS: TStringField
      FieldName = 'SIGDIS'
      ProviderFlags = []
      Required = True
      FixedChar = True
      Size = 3
    end
    object SQLDirecoesNOMFOC: TStringField
      FieldName = 'NOMFOC'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDirecoesCODCAR: TIntegerField
      FieldName = 'CODCAR'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object SQLDirecoesDESCAR: TStringField
      FieldName = 'DESCAR'
      ProviderFlags = []
      Required = True
      Size = 70
    end
    object SQLDirecoesDATINI: TDateField
      FieldName = 'DATINI'
      ProviderFlags = [pfInUpdate]
      Required = True
      EditMask = '99/99/9999;1;_'
    end
    object SQLDirecoesDATTER: TDateField
      FieldName = 'DATTER'
      ProviderFlags = [pfInUpdate]
      EditMask = '99/99/9999;1;_'
    end
    object SQLDirecoesINDCON: TStringField
      DefaultExpression = #39'N'#39
      FieldName = 'INDCON'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 1
    end
    object SQLDirecoesOBSDIR: TMemoField
      FieldName = 'OBSDIR'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object SQLDirecoesDATCAD: TSQLTimeStampField
      FieldName = 'DATCAD'
      ProviderFlags = []
    end
    object SQLDirecoesUSURES: TStringField
      FieldName = 'USURES'
      ProviderFlags = []
      FixedChar = True
      Size = 31
    end
  end
end
