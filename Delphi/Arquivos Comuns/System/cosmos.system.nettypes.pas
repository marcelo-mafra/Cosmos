unit cosmos.system.nettypes;

interface

type
  //Representa um protocolo de comunicação com o servidor.
  TConnectionProtocol = (cpTCP, cpHTTP, cpHTTPS);

  TProtocols = set of TConnectionProtocol;

 {Representa a situação de uma conexão como uma sequência de fases e status finais.}
 TConnectionStatus = (csOnConnectingHost, csHostConnected, csVerifyingIdentity,
   csGettingAuthorizations, csCheckingCertificate, csAuthorizedUser, csAuthenticationInvalid, csLoadingData,
   csApplyPermissions, csOnDisconnectingHost, csHostDisconnected,
   csUserLocked, csServerLocked, csAborted, csRefusedConnection, csHostNotFound,
   csTimeoutExpired, csConnectError, csCreatingConnectionsPool, csBufferingData);

implementation

end.
