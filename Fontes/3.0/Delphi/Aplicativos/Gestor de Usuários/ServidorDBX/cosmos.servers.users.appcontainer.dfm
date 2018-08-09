object DMUsuariosAppContainer: TDMUsuariosAppContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 453
  Width = 510
  object DSServerUsuarios: TDSServer
    OnPrepare = DSServerUsuariosPrepare
    OnConnect = DSServerUsuariosConnect
    OnDisconnect = DSServerUsuariosDisconnect
    OnError = DSServerUsuariosError
    OnTrace = DSServerUsuariosTrace
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
    Left = 96
    Top = 325
  end
  object DSHTTPService: TDSHTTPService
    HttpPort = 8081
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
    Left = 96
    Top = 261
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
    Top = 67
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
    Top = 192
  end
end
