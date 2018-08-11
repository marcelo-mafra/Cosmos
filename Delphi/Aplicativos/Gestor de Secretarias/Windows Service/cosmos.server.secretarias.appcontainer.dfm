object DMSecretariasAppContainer: TDMSecretariasAppContainer
  OldCreateOrder = False
  OnCreate = ServiceCreate
  OnDestroy = ServiceDestroy
  DisplayName = 'Cosmos Secretarias Service'
  OnStart = ServiceStart
  Height = 453
  Width = 555
  object DSServerSecretarias: TDSServer
    OnPrepare = DSServerSecretariasPrepare
    OnConnect = DSServerSecretariasConnect
    OnDisconnect = DSServerSecretariasDisconnect
    OnError = DSServerSecretariasError
    OnTrace = DSServerSecretariasTrace
    Left = 88
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
    Server = DSServerSecretarias
    Left = 280
    Top = 11
  end
  object DSServerLectoriumClass: TDSServerClass
    OnGetClass = DSServerLectoriumClassGetClass
    Server = DSServerSecretarias
    Left = 280
    Top = 67
  end
  object DSServerLogradourosClass: TDSServerClass
    OnGetClass = DSServerLogradourosClassGetClass
    Server = DSServerSecretarias
    Left = 440
    Top = 11
  end
  object DSServerAtividadesClass: TDSServerClass
    OnGetClass = DSServerAtividadesClassGetClass
    Server = DSServerSecretarias
    Left = 440
    Top = 179
  end
  object DSServerHistoricoClass: TDSServerClass
    OnGetClass = DSServerHistoricoClassGetClass
    Server = DSServerSecretarias
    Left = 280
    Top = 176
  end
  object DSServerTPClass: TDSServerClass
    OnGetClass = DSServerTPClassGetClass
    Server = DSServerSecretarias
    Left = 280
    Top = 123
  end
  object DSEscolaInternaClass: TDSServerClass
    OnGetClass = DSEscolaInternaClassGetClass
    Server = DSServerSecretarias
    Left = 440
    Top = 67
  end
  object DSFocosClass: TDSServerClass
    OnGetClass = DSFocosClassGetClass
    Server = DSServerSecretarias
    Left = 440
    Top = 123
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Port = 21000
    Server = DSServerSecretarias
    Filters = <>
    AuthenticationManager = DSAuthenticationManager
    Left = 88
    Top = 145
  end
end
