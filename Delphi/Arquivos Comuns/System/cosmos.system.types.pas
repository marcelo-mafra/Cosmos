unit cosmos.system.types;

{Contém alguns tipos primitivos usados ao logo das aplicações Cosmos.}
interface

type

 TNotifyMode = (nmNotify, nmNoNotify, nmRegisterLog);

 //Módulos do Cosmos.
 TCosmosModules = (cmFocos, cmFocosServer, cmSecretarias, cmSecretariasServer, cmFinanceiro,
  cmFinanceiroServer, cmConferencias, cmConferenciasServer, cmUsuarios,
  cmUsuariosServer, cmSincMestre, cmSincEscravo);

 TUserStatus = (usCosmosUser, usBlockedUser, usUnknown, usSysdba);
 {Status do usuário:
  "usCosmosUser" representa o usuário regular do Cosmos.
  "usBlockedUser" representa o usuário do Cosmos que está bloqueado na tabela
                  de usuários.
  "usUnknown" indica que não foi possíve identificar o usuário na tabela de usuários.
  "usSysdba" indica que o usuário utilizado em uma conexão foi o usuário
             interno do sistema.}

 //Tipos de mensagens aos usuários.
 TMessageType = (mtpSucess, mtpError, mtpWarning, mtpConfirmation, mtpInformation);

 //Informações existentes nas mensagens aos usuários.
 TMessageInfo = (miInnerMessage, miInstallationID, miMethodName, miMethodParameters,
   miRoleName, miSourceName, miUserName, miCommand, miExceptionClassName, miCustomInfo);

 //Formato de exportação de dados.
 TExportFormat = (efMSWord, efMSExcel, efXML, efHTML, efText, efOpenOffice, efCSV);

 TExportFormatSet = set of TExportFormat;

implementation

end.
