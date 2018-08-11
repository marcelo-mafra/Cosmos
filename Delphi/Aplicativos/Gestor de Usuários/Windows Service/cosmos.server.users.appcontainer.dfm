object DMUsuariosAppContainer: TDMUsuariosAppContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  DisplayName = 'Cosmos Usu'#225'rios Service'
  OnStart = ServiceStart
  Height = 453
  Width = 555
  object DSServerUsuarios: TDSServer
    OnPrepare = DSServerUsuariosPrepare
    OnConnect = DSServerUsuariosConnect
    OnDisconnect = DSServerUsuariosDisconnect
    OnError = DSServerUsuariosError
    OnTrace = DSServerUsuariosTrace
    Left = 96
    Top = 11
  end
  object DSAuthenticationManager: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManagerUserAuthenticate
    OnUserAuthorize = DSAuthenticationManagerUserAuthorize
    Roles = <>
    Left = 96
    Top = 141
  end
  object DSServerApplicationClass: TDSServerClass
    OnGetClass = DSServerApplicationClassGetClass
    Server = DSServerUsuarios
    Left = 280
    Top = 11
  end
  object DSServerUsuariosClass: TDSServerClass
    OnGetClass = DSServerUsuariosClassGetClass
    Server = DSServerUsuarios
    Left = 280
    Top = 75
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Port = 2140
    Server = DSServerUsuarios
    Filters = <>
    AuthenticationManager = DSAuthenticationManager
    Left = 96
    Top = 73
  end
end
