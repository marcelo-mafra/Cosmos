object DMConfReports: TDMConfReports
  OldCreateOrder = False
  Height = 401
  Width = 525
  object frxDBCrachas: TfrxDBDataset
    UserName = 'frxDBCrachas'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODINS=CODINS'
      'NUMINS=NUMINS'
      'DATCHE=DATCHE'
      'HORCHE=HORCHE'
      'DATSAI=DATSAI'
      'HORSAI=HORSAI'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'APECAD=APECAD'
      'SEXCAD=SEXCAD'
      'SIGDIS=SIGDIS'
      'SIGFOC=SIGFOC'
      'NUMQUA=NUMQUA'
      'NUMLEI=NUMLEI'
      'NOMALO=NOMALO'
      'INDMON=INDMON'
      'INDSUB=INDSUB'
      'DATINS=DATINS')
    OpenDataSource = False
    DataSet = DMConfData.CdsCrachas
    BCDToCurrency = False
    Left = 40
    Top = 24
  end
  object frxDBProgramacao: TfrxDBDataset
    UserName = 'frxDBProgramacao'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsProgramacao
    BCDToCurrency = False
    Left = 40
    Top = 88
  end
  object frxDBListaInscritos: TfrxDBDataset
    UserName = 'frxDBListaInscritos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsListaInscritos
    BCDToCurrency = False
    Left = 40
    Top = 152
  end
  object frxDBFichaInscricao: TfrxDBDataset
    UserName = 'frxDBFichaInscricao'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsFichaInscricao
    BCDToCurrency = False
    Left = 40
    Top = 216
  end
  object frxDBCrachaInscrito: TfrxDBDataset
    UserName = 'frxDBCrachaInscrito'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsCrachaInscrito
    BCDToCurrency = False
    Left = 40
    Top = 272
  end
  object frxDBAreasStaaff: TfrxDBDataset
    UserName = 'frxDBAreasStaaff'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsAreasStaff
    BCDToCurrency = False
    Left = 152
    Top = 88
  end
  object frxDBTarefasCracha: TfrxDBDataset
    UserName = 'frxDBTarefasCracha'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsTarefasCracha
    BCDToCurrency = False
    Left = 144
    Top = 32
  end
  object frxDBAlojamentos: TfrxDBDataset
    UserName = 'frxDBAlojamentos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsAlojamentos
    BCDToCurrency = False
    Left = 168
    Top = 160
  end
  object frxDBLeitos: TfrxDBDataset
    UserName = 'frxDBLeitos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsLeitos
    BCDToCurrency = False
    Left = 168
    Top = 224
  end
  object frxDBInformacoesInscritos: TfrxDBDataset
    UserName = 'frxDBInformacoesInscritos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsInformacoesInscritos
    BCDToCurrency = False
    Left = 40
    Top = 336
  end
  object frxDBStaffs: TfrxDBDataset
    UserName = 'frxDBStaffs'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsStaffs
    BCDToCurrency = False
    Left = 168
    Top = 296
  end
  object frxDBQuartosAlojamento: TfrxDBDataset
    UserName = 'frxDBQuartosAlojamento'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMConfData.CdsQuartosAlojamento
    BCDToCurrency = False
    Left = 288
    Top = 32
  end
  object frxDBFolhasQuartos: TfrxDBDataset
    UserName = 'frxDBFolhasQuartos'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODQUA=CODQUA'
      'NUMQUA=NUMQUA'
      'NUMLEI=NUMLEI'
      'NOMALO=NOMALO'
      'ALAQUA=ALAQUA'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'SIGFOC=SIGFOC'
      'INDMON=INDMON'
      'INDSUB=INDSUB')
    OpenDataSource = False
    DataSet = DMConfData.CdsFolhasQuartos
    BCDToCurrency = False
    Left = 288
    Top = 88
  end
end
