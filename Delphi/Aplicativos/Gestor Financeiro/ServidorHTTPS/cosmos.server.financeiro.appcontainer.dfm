object DMFinanceiroAppContainer: TDMFinanceiroAppContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
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
    Left = 88
    Top = 77
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
end
