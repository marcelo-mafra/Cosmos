object DMBase: TDMBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 364
  Width = 428
  object CdsBufferedData: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 160
    Top = 176
  end
  object AppEvents: TApplicationEvents
    Left = 48
    Top = 176
  end
  object DBXConnection: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=DataSnap'
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=10001'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=18.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    ValidatePeerCertificate = DBXConnectionValidatePeerCertificate
    AfterConnect = DBXConnectionAfterConnect
    AfterDisconnect = DBXConnectionAfterDisconnect
    BeforeConnect = DBXConnectionBeforeConnect
    BeforeDisconnect = DBXConnectionBeforeDisconnect
    Left = 49
    Top = 26
    UniqueId = '{D620C09F-4AA5-4291-A055-7177D3BDB8D0}'
  end
  object DBXServerMethod: TSqlServerMethod
    Params = <
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'UserName'
        ParamType = ptInput
        Value = 'marcelo.mafra'
      end
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'ReturnParameter'
        ParamType = ptResult
        Size = 2000
      end>
    SQLConnection = DBXConnection
    ServerMethodName = 'TDMCosmosApplicationServer.ReadUserRoles'
    Left = 160
    Top = 88
  end
  object DSProviderConnection: TDSProviderConnection
    ServerClassName = 'TDMCosmosApplicationServer'
    SQLConnection = DBXConnection
    Left = 48
    Top = 88
  end
  object XMLFieldsInfo: TXMLDocument
    Left = 160
    Top = 32
    DOMVendorDesc = 'MSXML'
  end
  object DspConverter: TDataSetProvider
    Left = 160
    Top = 240
  end
  object TimerConnection: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = TimerConnectionTimer
    Left = 48
    Top = 240
  end
  object DBXMonitor: TSQLMonitor
    OnLogTrace = DBXMonitorLogTrace
    OnTrace = DBXMonitorTrace
    SQLConnection = DBXConnection
    Left = 264
    Top = 32
  end
end
