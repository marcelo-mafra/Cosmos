object DMUsuariosAppContainer: TDMUsuariosAppContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
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
    Left = 88
    Top = 77
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
end
