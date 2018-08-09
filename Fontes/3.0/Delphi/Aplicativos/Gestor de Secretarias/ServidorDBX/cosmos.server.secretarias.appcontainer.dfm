object DMSecretariasAppContainer: TDMSecretariasAppContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 453
  Width = 555
  object DSServerSecretarias: TDSServer
    OnPrepare = DSServerSecretariasPrepare
    OnConnect = DSServerSecretariasConnect
    OnDisconnect = DSServerSecretariasDisconnect
    OnError = DSServerSecretariasError
    OnTrace = DSServerSecretariasTrace
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Filters = <>
    AuthenticationManager = DSAuthenticationManager
    OnConnect = DSTCPServerTransportConnect
    OnDisconnect = DSTCPServerTransportDisconnect
    Left = 96
    Top = 73
  end
  object DSCertFiles: TDSCertFiles
    OnGetPEMFilePasskey = DSCertFilesGetPEMFilePasskey
    Left = 176
    Top = 197
  end
  object DSHTTPService: TDSHTTPService
    HttpPort = 8140
    DSContext = 'ds/'
    OnHTTPTrace = DSHTTPServiceTrace
    Filters = <>
    AuthenticationManager = DSAuthenticationManager
    Left = 96
    Top = 135
  end
  object DSAuthenticationManager: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManagerUserAuthenticate
    OnUserAuthorize = DSAuthenticationManagerUserAuthorize
    Roles = <>
    Left = 88
    Top = 309
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
    Left = 280
    Top = 235
  end
  object DSServerHistoricoClass: TDSServerClass
    OnGetClass = DSServerHistoricoClassGetClass
    Server = DSServerSecretarias
    Left = 280
    Top = 184
  end
  object DSHTTPServiceFile: TDSHTTPServiceFileDispatcher
    Service = DSHTTPService
    WebFileExtensions = <
      item
        MimeType = 'text/css'
        Extensions = 'css'
      end
      item
        MimeType = 'text/html'
        Extensions = 'html;htm'
      end
      item
        MimeType = 'text/javascript'
        Extensions = 'js'
      end
      item
        MimeType = 'image/jpeg'
        Extensions = 'jpeg;jpg'
      end
      item
        MimeType = 'image/x-png'
        Extensions = 'png'
      end>
    WebDirectories = <
      item
        DirectoryAction = dirInclude
        DirectoryMask = '*'
      end
      item
        DirectoryAction = dirExclude
        DirectoryMask = '\templates\*'
      end>
    Left = 96
    Top = 248
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
  object DSHTTPSService: TDSHTTPService
    HttpPort = 8141
    CertFiles = DSCertFiles
    DSContext = 'ds/'
    OnHTTPTrace = DSHTTPServiceTrace
    Filters = <>
    AuthenticationManager = DSAuthenticationManager
    Left = 96
    Top = 191
  end
end
