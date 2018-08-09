unit cosmos.system.types;

interface

uses
  winapi.windows, system.SysUtils;

type
 //Representa um protocolo de comunicação com o servidor.
 TConnectionProtocol = (cpTCP, cpHTTP, cpHTTPS);

 TNotifyMode = (nmNotify, nmNoNotify, nmRegisterLog);

 TProtocols = set of TConnectionProtocol;

 {Representa a situação de uma conexão como uma sequência de fases e status finais.}
 TConnectionStatus = (csOnConnectingHost, csHostConnected, csVerifyingIdentity,
   csGettingAuthorizations, csCheckingCertificate, csAuthorizedUser, csAuthenticationInvalid, csLoadingData,
   csApplyPermissions, csOnDisconnectingHost, csHostDisconnected,
   csUserLocked, csServerLocked, csAborted, csRefusedConnection, csHostNotFound,
   csTimeoutExpired, csConnectError, csCreatingConnectionsPool, csBufferingData);

 //Formato de exportação de dados.
 TExportFormat = (efMSWord, efMSExcel, efXML, efHTML, efText, efOpenOffice, efCSV);
 TExportFormatSet = set of TExportFormat;

 {Status do usuário:
  usCosmosUser = Usuário regular do Cosmos.
  usBlockedUser = Usuário do Cosmos que está bloqueado na tabela de usuários.
  usUnknown = Não foi possíve identificar o usuário na tabela de usuários.
  usSysdba = O usuário é o usuário interno do sistema.}

 TUserStatus = (usCosmosUser, usBlockedUser, usUnknown, usSysdba);

 TCosmosModules = (cmFocos, cmFocosServer, cmSecretarias, cmSecretariasServer, cmFinanceiro,
  cmFinanceiroServer, cmConferencias, cmConferenciasServer, cmUsuarios,
  cmUsuariosServer, cmSincMestre, cmSincEscravo);

 TMessageType = (mtpSucess, mtpError, mtpWarning, mtpConfirmation, mtpInformation);

 TMessageInfo = (miInnerMessage, miInstallationID, miMethodName, miMethodParameters,
   miRoleName, miSourceName, miUserName, miCommand, miExceptionClassName, miCustomInfo);

implementation

end.
