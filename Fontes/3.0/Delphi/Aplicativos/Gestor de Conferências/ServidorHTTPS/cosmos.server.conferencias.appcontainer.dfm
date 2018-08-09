object DMConferenciasAppContainer: TDMConferenciasAppContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 453
  Width = 555
  object DSServerConferencias: TDSServer
    OnPrepare = DSServerConferenciasPrepare
    OnConnect = DSServerConferenciasConnect
    OnDisconnect = DSServerConferenciasDisconnect
    OnError = DSServerConferenciasError
    OnTrace = DSServerConferenciasTrace
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
    Server = DSServerConferencias
    Left = 280
    Top = 11
  end
  object DSServerLogradourosClass: TDSServerClass
    OnGetClass = DSServerLogradourosClassGetClass
    Server = DSServerConferencias
    Left = 440
    Top = 11
  end
  object DSServerAtividadesClass: TDSServerClass
    OnGetClass = DSServerAtividadesClassGetClass
    Server = DSServerConferencias
    Left = 440
    Top = 83
  end
  object DSServerConferenciasClass: TDSServerClass
    OnGetClass = DSServerConferenciasClassGetClass
    Server = DSServerConferencias
    Left = 272
    Top = 83
  end
end
