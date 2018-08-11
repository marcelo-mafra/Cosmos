object DMSecPageProducer: TDMSecPageProducer
  OldCreateOrder = False
  Height = 492
  Width = 632
  object DstTableProducer: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'MATCAD'
        Title.Caption = 'Matr'#237'cula'
      end
      item
        FieldName = 'NOMCAD'
        Title.Caption = 'Nome'
      end>
    TableAttributes.Align = haCenter
    TableAttributes.Border = 1
    TableAttributes.CellSpacing = 5
    TableAttributes.CellPadding = 5
    Left = 48
    Top = 32
  end
  object PageProducer1: TPageProducer
    Left = 48
    Top = 96
  end
end
