object DMFinData: TDMFinData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 483
  Width = 568
  object CdsRecebimentosCadastrado: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select * from viw_recebimentos where matcad = :matcad and anoref' +
      ' = :anoref order by anoref, mesref'
    Params = <
      item
        DataType = ftString
        Name = 'matcad'
        ParamType = ptInput
        Size = 7
        Value = 'LST-144'
      end
      item
        DataType = ftSmallint
        Name = 'anoref'
        ParamType = ptInput
        Value = 2008
      end>
    ProviderName = 'DspSearch'
    Left = 92
    Top = 95
  end
  object CdsCadastrado: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DspSearch'
    Left = 88
    Top = 32
  end
  object CdsSumarioCaixas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 92
    Top = 159
  end
  object CdsContribuicoesPendentes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 216
  end
end
