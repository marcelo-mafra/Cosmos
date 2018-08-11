object DMFocosData: TDMFocosData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 519
  Width = 574
  object DsrRa: TDataSource
    DataSet = CdsRAs
    Left = 88
    Top = 24
  end
  object CdsRAs: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select codreg, nomreg, regsup from viw_regioes_admin order by  n' +
      'omreg'
    Params = <>
    ProviderName = 'DspSearch'
    Left = 24
    Top = 24
  end
  object CdsFocosRegiao: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select nomfoc, sigfoc, tipfoc, indcab, codreg from viw_focos ord' +
      'er by indcab desc, nomfoc'
    IndexFieldNames = 'CODREG'
    Params = <>
    ProviderName = 'DspSearch'
    Left = 24
    Top = 72
  end
  object CdsMentores: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select codreg, nomcad, nomdis, nomdising, sigdis, nomfoc, sigfoc' +
      ', nomreg from viw_mentores_ra'
    Params = <>
    ProviderName = 'DspSearch'
    Left = 24
    Top = 120
  end
  object CdsFocos: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from viw_focos order by nomfoc'
    Params = <>
    ProviderName = 'DspReports'
    Left = 24
    Top = 192
  end
  object CdsEnderecos: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from VIW_ENDERECOS_FOCOS'
    Params = <>
    ProviderName = 'DspReports'
    Left = 24
    Top = 241
  end
  object CdsMeiosContatosFocos: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from viw_meios_contatos_focos'
    Params = <>
    ProviderName = 'DspReports'
    Left = 24
    Top = 296
  end
  object CdsFichaAluno: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select codreg, nomcad, nomdis, nomdising, sigdis, nomfoc, sigfoc' +
      ', nomreg from viw_mentores_ra'
    Params = <>
    ProviderName = 'DspReports'
    Left = 208
    Top = 16
  end
  object CdsGestoes: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select * from viw_gestoes where (datter is null) or (datter >= c' +
      'urrent_date) order by nivorg, nomorg'
    Params = <>
    ProviderName = 'DspReports'
    Left = 208
    Top = 72
  end
  object CdsOrgaosGestores: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select * from viw_orgaos_gestores order by nivorg, orgsup, nomor' +
      'g'
    Params = <>
    ProviderName = 'DspReports'
    Left = 208
    Top = 128
  end
  object CdsDirigentes: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from viw_direcoes order by nomcad'
    Params = <>
    ProviderName = 'DspReports'
    Left = 208
    Top = 184
  end
  object CdsMalaFocos: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select NOMFOC, NOMLOG, NUMEND, COMEND, CEPLOG, NOMBAI, NOMCID, S' +
      'IGEST, NOMPAI, NUMCAI   from viw_enderecos_focos where indcor = ' +
      #39'S'#39
    Params = <>
    ProviderName = 'DspReports'
    Left = 200
    Top = 240
  end
end
