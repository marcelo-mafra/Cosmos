object DM: TDM
  OldCreateOrder = False
  Height = 283
  Width = 477
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 64
    Top = 32
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Marcelo\Projeto Cosmos\Banco de dados\COSMOSDB.FDB'
      'User_Name=cosmos'
      'Password=galaad'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'RoleName=DEI'
      'CharacterSet=ISO8859_1'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 96
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 64
    Top = 152
  end
end
