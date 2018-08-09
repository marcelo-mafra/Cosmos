object DMFinanceiroAppContainer: TDMFinanceiroAppContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  DisplayName = 'Cosmos Financeiro Service'
  OnStart = ServiceStart
  Height = 453
  Width = 555
  object DSServerFinanceiro: TDSServer
    OnPrepare = DSServerFinanceiroPrepare
    OnConnect = DSServerFinanceiroConnect
    OnDisconnect = DSServerFinanceiroDisconnect
    OnError = DSServerFinanceiroError
    OnTrace = DSServerFinanceiroTrace
    Left = 96
    Top = 11
  end
  object DSAuthenticationManager: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManagerUserAuthenticate
    OnUserAuthorize = DSAuthenticationManagerUserAuthorize
    Roles = <>
    Left = 96
    Top = 133
  end
  object DSServerApplicationClass: TDSServerClass
    OnGetClass = DSServerApplicationClassGetClass
    Server = DSServerFinanceiro
    Left = 280
    Top = 11
  end
  object DSServerFinanceiroClass: TDSServerClass
    OnGetClass = DSServerFinanceiroClassGetClass
    Server = DSServerFinanceiro
    Left = 280
    Top = 67
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Port = 2130
    Server = DSServerFinanceiro
    Filters = <>
    AuthenticationManager = DSAuthenticationManager
    Left = 96
    Top = 73
  end
end
