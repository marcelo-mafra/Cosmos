object DMFinReports: TDMFinReports
  OldCreateOrder = False
  Height = 439
  Width = 497
  object frxDBCadastrado: TfrxDBDataset
    UserName = 'frxDBCadastrado'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMFinData.CdsCadastrado
    BCDToCurrency = False
    Left = 56
    Top = 16
  end
  object frxDBRecebimentosCadastrado: TfrxDBDataset
    UserName = 'frxDBRecebimentosCadastrado'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMFinData.CdsRecebimentosCadastrado
    BCDToCurrency = False
    Left = 56
    Top = 64
  end
  object frxDBSumarioCaixas: TfrxDBDataset
    UserName = 'frxDBSumarioCaixas'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMFinData.CdsSumarioCaixas
    BCDToCurrency = False
    Left = 56
    Top = 120
  end
  object frxDBContribuicoesPendentes: TfrxDBDataset
    UserName = 'frxDBContribuicoesPendentes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMFinData.CdsContribuicoesPendentes
    BCDToCurrency = False
    Left = 56
    Top = 176
  end
end
