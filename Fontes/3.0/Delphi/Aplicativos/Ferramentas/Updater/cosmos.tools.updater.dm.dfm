object DMUpdater: TDMUpdater
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 219
  Width = 390
  object IdFTPClient: TIdFTP
    Intercept = IdCompressionIntercept1
    OnWork = IdHTTPClientWork
    OnWorkBegin = IdHTTPClientWorkBegin
    OnWorkEnd = IdHTTPClientWorkEnd
    OnConnected = IdHTTPClientConnected
    IPVersion = Id_IPv4
    Compressor = IdCompressorZLib
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 40
    Top = 16
  end
  object IdTCPClient: TIdTCPClient
    Intercept = IdCompressionIntercept1
    OnWork = IdHTTPClientWork
    OnWorkBegin = IdHTTPClientWorkBegin
    OnWorkEnd = IdHTTPClientWorkEnd
    OnConnected = IdHTTPClientConnected
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 40
    Top = 112
  end
  object IdHTTPClient: TIdHTTP
    Intercept = IdCompressionIntercept1
    OnWork = IdHTTPClientWork
    OnWorkBegin = IdHTTPClientWorkBegin
    OnWorkEnd = IdHTTPClientWorkEnd
    OnConnected = IdHTTPClientConnected
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Compressor = IdCompressorZLib
    Left = 40
    Top = 64
  end
  object IdCompressorZLib: TIdCompressorZLib
    Left = 264
    Top = 80
  end
  object IdCompressionIntercept1: TIdCompressionIntercept
    CompressionLevel = 0
    Left = 264
    Top = 24
  end
  object XMLUpdatesSource: TXMLDocument
    Left = 152
    Top = 104
    DOMVendorDesc = 'MSXML'
  end
  object XMLUpdatesHistoric: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 152
    Top = 40
    DOMVendorDesc = 'MSXML'
  end
end
