object DM: TDM
  OldCreateOrder = False
  Left = 285
  Top = 187
  Height = 240
  Width = 265
  object CdsExport: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 24
  end
  object TableProd: TDataSetTableProducer
    Footer.Strings = (
      '<br>'
      
        '<h5><font face= "Tahoma, Arial" color=navy>Html gerado por Expor' +
        'ter.dll</font></h5>'
      '')
    Header.Strings = (
      '<HEAD>'
      '<TITLE>HTML Export</TITLE>'
      '</HEAD>'
      
        '<h3><font face= "Tahoma, Arial" color=navy>Dados exportados</fon' +
        't></h3>'
      '<hr>'
      '<br>')
    DataSet = CdsExport
    RowAttributes.Align = haCenter
    TableAttributes.Align = haCenter
    TableAttributes.Border = 1
    OnCreateContent = TableProdCreateContent
    Left = 88
    Top = 24
  end
  object ASCIIExport: TVASCIIExport
    ExportType = etTxt
    Dataset = CdsExport
    Formats.DateTimeFormat = 'dd/MM/yyyy hh:mm'
    Formats.IntegerFormat = '#,###,##0'
    Formats.CurrencyFormat = '00,00R$ '
    Formats.FloatFormat = '#,###,##0.00'
    Formats.DateFormat = 'dd/MM/yyyy'
    Formats.TimeFormat = 'hh:mm'
    Formats.BooleanTrue = 'True'
    Formats.BooleanFalse = 'False'
    Left = 24
    Top = 88
  end
  object RTFExport: TVRTFExport
    RTFOptions.DefaultFont.Charset = DEFAULT_CHARSET
    RTFOptions.DefaultFont.Color = clWindowText
    RTFOptions.DefaultFont.Height = -13
    RTFOptions.DefaultFont.Name = 'Arial'
    RTFOptions.DefaultFont.Style = []
    RTFOptions.HeaderFont.Charset = DEFAULT_CHARSET
    RTFOptions.HeaderFont.Color = clWindowText
    RTFOptions.HeaderFont.Height = -13
    RTFOptions.HeaderFont.Name = 'Arial'
    RTFOptions.HeaderFont.Style = [fsBold]
    Dataset = CdsExport
    Formats.DateTimeFormat = 'dd/MM/yyyy hh:mm'
    Formats.IntegerFormat = '#,###,##0'
    Formats.CurrencyFormat = '00,00R$ '
    Formats.FloatFormat = '#,###,##0.00'
    Formats.DateFormat = 'dd/MM/yyyy'
    Formats.TimeFormat = 'hh:mm'
    Formats.BooleanTrue = 'Sim'
    Formats.BooleanFalse = 'N'#227'o'
    Left = 80
    Top = 88
  end
  object ExcelExport: TVExcelExport
    ExcelOptions.PageFooter = 'Page &P of &N'
    ExcelOptions.DefaultFont.Charset = DEFAULT_CHARSET
    ExcelOptions.DefaultFont.Color = clWindowText
    ExcelOptions.DefaultFont.Height = -13
    ExcelOptions.DefaultFont.Name = 'Arial'
    ExcelOptions.DefaultFont.Style = []
    ExcelOptions.RowHeaderFont.Charset = DEFAULT_CHARSET
    ExcelOptions.RowHeaderFont.Color = clWindowText
    ExcelOptions.RowHeaderFont.Height = -13
    ExcelOptions.RowHeaderFont.Name = 'Arial'
    ExcelOptions.RowHeaderFont.Style = [fsBold]
    Dataset = CdsExport
    Formats.DateTimeFormat = 'dd/MM/yyyy hh:mm'
    Formats.IntegerFormat = '#,###,##0'
    Formats.CurrencyFormat = '00,00R$ '
    Formats.FloatFormat = '#,###,##0.00'
    Formats.DateFormat = 'dd/MM/yyyy'
    Formats.TimeFormat = 'hh:mm'
    Formats.BooleanTrue = 'True'
    Formats.BooleanFalse = 'False'
    Left = 128
    Top = 88
  end
  object SQLExport: TMMSSQLExporter
    Dataset = CdsExport
    DateFormat = 'yyyy/mm/dd'
    CommitExpression = 'COMMIT WORK;'
    Terminator = ';'
    NullValue = 'null'
    Left = 128
    Top = 24
  end
end
