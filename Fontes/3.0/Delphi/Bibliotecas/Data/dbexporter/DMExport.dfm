object DM: TDM
  OldCreateOrder = False
  Height = 245
  Width = 318
  object CdsData: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 24
  end
  object ExpText: TDataToAscii
    DataSet = CdsData
    Fields = <>
    Left = 104
    Top = 24
  end
  object ExpXLS: TDataToXLS
    DataSet = CdsData
    Columns = <>
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clWindowText
    Title.Font.Height = -13
    Title.Font.Name = 'Arial'
    Title.Font.Style = [fsBold]
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -13
    Header.Font.Name = 'Arial'
    Header.Font.Style = [fsBold]
    Left = 104
    Top = 88
  end
  object ExpHTML: TDataToHTML
    DataSet = CdsData
    Fields = <>
    Left = 32
    Top = 88
  end
end
