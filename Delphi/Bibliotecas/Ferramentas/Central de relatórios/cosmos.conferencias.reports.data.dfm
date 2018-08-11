object DMConfData: TDMConfData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 520
  Width = 623
  object CdsCrachas: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CODCON'
        ParamType = ptInput
        Value = 0
      end>
    Left = 32
    Top = 24
  end
  object CdsProgramacao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 88
  end
  object CdsListaInscritos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 152
  end
  object CdsFichaInscricao: TClientDataSet
    PersistDataPacket.Data = {
      370000009619E0BD0100000018000000010000000000030000003700084E6F6D
      65466F636F01004900040001000557494454480200020096000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NomeFoco'
        Attributes = [faRequired]
        DataType = ftString
        Size = 150
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 32
    Top = 216
  end
  object CdsCrachaInscrito: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 272
  end
  object CdsTarefasCracha: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 26
  end
  object CdsAreasStaff: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 130
  end
  object CdsAlojamentos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 186
  end
  object CdsLeitos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 242
  end
  object CdsInformacoesInscritos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 298
  end
  object CdsStaffs: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 82
  end
  object CdsFolhasQuartos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 402
  end
  object CdsQuartosAlojamento: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 354
  end
  object DsrMasterSource: TDataSource
    Left = 247
    Top = 32
  end
end
