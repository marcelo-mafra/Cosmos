unit cosmos.server.conferencias.appcontainer;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.SvcMgr, Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer, Datasnap.DSAuth, IPPeerServer,
  Datasnap.DSSession, cosmos.system.files, cosmos.system.types, cosmos.system.messages,
  cosmos.system.exceptions, cosmos.classes.application, Data.DBXCommon, cosmos.classes.logs,
  cosmos.classes.persistence.ini, Data.DBCommonTypes, cosmos.servers.common.servicesint,
  cosmos.servers.common.dao.interfaces;


type
  TOnPrepareCommandEvent = procedure(Session: TDSSession) of object;
  TOnConnectServerEvent = procedure(DSConnectEventObject: TDSConnectEventObject) of object;
  TOnDisconnectServerEvent = procedure(DSConnectEventObject: TDSConnectEventObject) of object;


  TDMConferenciasAppContainer = class(TService)
    DSServerConferencias: TDSServer;
    DSAuthenticationManager: TDSAuthenticationManager;
    DSServerApplicationClass: TDSServerClass;
    DSServerLogradourosClass: TDSServerClass;
    DSServerAtividadesClass: TDSServerClass;
    DSServerConferenciasClass: TDSServerClass;
    DSTCPServerTransport1: TDSTCPServerTransport;
    procedure DSServerApplicationClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManagerUserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DataModuleCreate(Sender: TObject);
    procedure DSServerLogradourosClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServerAtividadesClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServerConferenciasPrepare(
      DSPrepareEventObject: TDSPrepareEventObject);
    procedure DSServerConferenciasError(DSErrorEventObject: TDSErrorEventObject);
    procedure DSServerConferenciasConnect(
      DSConnectEventObject: TDSConnectEventObject);
    procedure DSServerConferenciasDisconnect(
      DSConnectEventObject: TDSConnectEventObject);
    function DSServerConferenciasTrace(TraceInfo: TDBXTraceInfo): CBRType;
    procedure DSAuthenticationManagerUserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DSServerConferenciasClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
    FTestServerPage: string;

    FOnConnectServer: TOnConnectServerEvent;
    FOnDisconnectServer: TOnDisconnectServerEvent;
    FOnPrepareCommand: TOnPrepareCommandEvent;
    FCosmosServiceFactory: ICosmosServiceFactory;
    FCosmosDAOServiceFactory: ICosmosDAOServiceFactory;

    procedure LoadMethodsAuthorizations;
    procedure LoadServerConfigurations;

    function GetCosmosService: ICosmosService;
    function GetDAOServices: ICosmosDAOService;

  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetServiceController: TServiceController; override;

    property CosmosServices: ICosmosService read GetCosmosService;
    property DAOServices: ICosmosDAOService read GetDAOServices;

    property OnConnectServer: TOnConnectServerEvent read FOnConnectServer write FOnConnectServer;
    property OnDisconnectServer: TOnDisconnectServerEvent read FOnDisconnectServer write FOnDisconnectServer;
    property OnPrepareCommand: TOnPrepareCommandEvent read FOnPrepareCommand write FOnPrepareCommand;
    property TestServerPage: string read FTestServerPage;
  end;

function DSServer: TDSServer;
function DSAuthenticationManager: TDSAuthenticationManager;

var
  DMConferenciasAppContainer: TDMConferenciasAppContainer;

implementation

uses cosmos.servers.common.services, cosmos.servers.common.methods,
  cosmos.servers.common.security, cosmos.servers.common.security.authorizations,
  cosmos.server.common.logradouros.methods, cosmos.servers.common.dataacess,
  cosmos.servers.conferencias.methods, cosmos.servers.secretarias.atividades.methods;

{$R *.dfm}

var
  FModule: TComponent;
  FDSServer: TDSServer;
  FDSAuthenticationManager: TDSAuthenticationManager;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  DMConferenciasAppContainer.Controller(CtrlCode);
end;

function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

function DSAuthenticationManager: TDSAuthenticationManager;
begin
  Result := FDSAuthenticationManager;
end;

procedure TDMConferenciasAppContainer.DSServerApplicationClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMCosmosApplicationServer;
end;

procedure TDMConferenciasAppContainer.DSServerAtividadesClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMSecAtividadesServerMethods;
end;

procedure TDMConferenciasAppContainer.DSServerLogradourosClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMCosmosServerLogradouros;
end;

function TDMConferenciasAppContainer.GetCosmosService: ICosmosService;
begin
 Result := self.FCosmosServiceFactory.CosmosService;
end;

function TDMConferenciasAppContainer.GetDAOServices: ICosmosDAOService;
begin
 Result := self.FCosmosDAOServiceFactory.DAOService;
end;

function TDMConferenciasAppContainer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TDMConferenciasAppContainer.DoContinue: Boolean;
begin
  Result := inherited;
  DSServerConferencias.Start;
end;

procedure TDMConferenciasAppContainer.DoInterrogate;
begin
  inherited;
end;

function TDMConferenciasAppContainer.DoPause: Boolean;
begin
  DSServerConferencias.Stop;
  Result := inherited;
end;

function TDMConferenciasAppContainer.DoStop: Boolean;
begin
  DSServerConferencias.Stop;
  Result := inherited;
end;

procedure TDMConferenciasAppContainer.DSServerConferenciasClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMCosmosConferenciasMethods;
end;

procedure TDMConferenciasAppContainer.DSServerConferenciasConnect(
  DSConnectEventObject: TDSConnectEventObject);
var
 AInfo: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de operações de conexão.}
 //Prepara o objeto que receberá as informações de contexto da conexão.
 AContextInfo := CosmosServices.CreateContextInfoObject;

 try
  with DSConnectEventObject do
   begin
    //Registra os dados da conexão no log do sistema
    AInfo := Format(TCosmosLogs.ConnectedUser, [ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]]);
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [ConnectProperties[TDBXPropertyNames.CommunicationProtocol]]));
    AContextInfo.Append(FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Now));

    CosmosServices.RegisterLog(AInfo, AContextInfo.DelimitedText, leOnConnect);

    //Registra na janela do servidor o usuário conectado.
    AContextInfo.Clear;
    AContextInfo.Append(ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]);
    AContextInfo.Append(DateTimeToStr(Now));
    AContextInfo.Append(ConnectProperties[TDBXPropertyNames.CommunicationProtocol]);

    if Assigned(OnConnectServer) then OnConnectServer(DsConnectEventObject);
   end;

 finally
  AContextInfo.Free;
 end;
end;

procedure TDMConferenciasAppContainer.DSServerConferenciasDisconnect(
  DSConnectEventObject: TDSConnectEventObject);
var
 AInfo: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de operações de desconexão.}
 //DMServerDataAcess.ConnectionPool.RemoveConnection(TDSSessionManager.GetThreadSession.Id);

 AContextInfo := CosmosServices.CreateContextInfoObject;

 try
  with DSConnectEventObject do
   begin
    AInfo := Format(TCosmosLogs.DisconnectedUser, [ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]]);

    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [ConnectProperties[TDBXPropertyNames.CommunicationProtocol]]));
   end;

  CosmosServices.RegisterLog(AInfo, AContextInfo.DelimitedText, leOnConnectClose);

  if Assigned(OnDisconnectServer) then OnDisconnectServer(DSConnectEventObject);

 finally
  AContextInfo.Free;
 end;
end;

procedure TDMConferenciasAppContainer.DSServerConferenciasError(
  DSErrorEventObject: TDSErrorEventObject);
var
 Info: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de erros de execução de métodos remotos.}
 if leOnError in CosmosServices.LogEvents then
  begin
   AContextInfo := CosmosServices.CreateContextInfoObject;

   try
    with DSErrorEventObject do
     begin
      Info := DSErrorEventObject.Error.Message;
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [ServerConnectionHandler.Channel.ChannelInfo.ClientInfo.Protocol]));
     end;

    CosmosServices.RegisterLog(Info, AContextInfo.DelimitedText, leOnError);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

procedure TDMConferenciasAppContainer.DSServerConferenciasPrepare(
  DSPrepareEventObject: TDSPrepareEventObject);
var
 Info: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de preparação de execução de métodos remotos.}
 if leOnPrepare in CosmosServices.LogEvents then
  begin
   AContextInfo := CosmosServices.CreateContextInfoObject;

   try
    with DSPrepareEventObject do
     begin
      Info := DSPrepareEventObject.MethodAlias;
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [ServerConnectionHandler.Channel.ChannelInfo.ClientInfo.Protocol]));
     end;

    CosmosServices.RegisterLog(Info, AContextInfo.DelimitedText, leOnPrepare);

    //Dispara um evento de notificação que pode ser capturado.
    if Assigned(FOnPrepareCommand) then FOnPrepareCommand(TDSSessionManager.GetThreadSession);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

function TDMConferenciasAppContainer.DSServerConferenciasTrace(
  TraceInfo: TDBXTraceInfo): CBRType;
var
 Info: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de trace, caso a geração para este tipo de
 evento esteja ativa.}
 if leOnTrace in CosmosServices.LogEvents then
  begin
   AContextInfo := CosmosServices.CreateContextInfoObject;

   try
    Info := TraceInfo.Message;
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));

    CosmosServices.RegisterLog(Info, AContextInfo.DelimitedText, leOnTrace);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

procedure TDMConferenciasAppContainer.LoadMethodsAuthorizations;
var
 IAuthorizations: IXMLAuthorizationsType;
 IMethodInfo: IXMLMethodInfoType;
 AFileName: string;
 I: integer;
 ARoleInfo: TDSRoleItem;
 CosmosApp: TCosmosApplication;
begin
{Carrega as informações de autorização existente no arquivo de configuração de
 permissões "RolesPermissions.xml". Essas informações se referem tanto ao acesso
 a funcionalidadades como a métodos remotos. Este método apenas carrega as autorizações
 relativas aos métodos remotos.}
 CosmosApp := TCosmosApplication.Create;

 AFileName := CosmosApp.GetModulePath + TCosmosFiles.RolesPermissions;
 IAuthorizations := LoadAuthorizations(AFileName);
 DSAuthenticationManager.Roles.Clear;

 try
  for I := 0 to Pred(IAuthorizations.Methods.Count) do
   begin
    IMethodInfo := IAuthorizations.Methods.MethodInfo[I];
    if (IMethodInfo.CosmosModule = TCosmosAppName.CosmosConferenciasId) or (IMethodInfo.CosmosModule = TCosmosAppName.CosmosCommonId) then
     begin
      ARoleInfo := TDSRoleItem(DSAuthenticationManager.Roles.Add);
      ARoleInfo.ApplyTo.CommaText := IMethodInfo.MethodName;
      ARoleInfo.AuthorizedRoles.CommaText := IMethodInfo.AuthorizedRoles;
      ARoleInfo.DeniedRoles.CommaText := IMethodInfo.DeniedRoles;
      ARoleInfo.Exclude.CommaText := IMethodInfo.Exclude;
     end;
   end;

  CosmosServices.RegisterLog(TCosmosLogs.AuthorizationsMethods, '');

 finally
  if Assigned(IAuthorizations) then IAuthorizations := nil;
  if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
 end;
end;

procedure TDMConferenciasAppContainer.LoadServerConfigurations;
 var
  AFile: TIniFilePersistence;
  AFileName, CurrentProtocol: string;
  CosmosApp: TCosmosApplication;
begin
{Carregas as configurações do servidor em execução. Estas configurações envolvem
 protocolos de conexão, certificados, dentre outros itens.}
 CosmosApp := TCosmosApplication.Create;
 AFileName := CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot;
 AFile := TIniFilePersistence.Create(AFileName, True);

 try
  //Configurações das classes expostas remotamente.
  DSServerApplicationClass.LifeCycle := AFile.ReadString('GCON', 'DSServerApplicationClass.LifeCycle', 'Session');
  DSServerConferenciasClass.LifeCycle := DSServerApplicationClass.LifeCycle;
  DSServerLogradourosClass.LifeCycle := DSServerApplicationClass.LifeCycle;
  DSServerAtividadesClass.LifeCycle := DSServerApplicationClass.LifeCycle;

  if Assigned(AFile) then FreeAndNil(AFile);
  if Assigned(CosmosApp) then  FreeAndNil(CosmosApp);

 except
  on E: EInvalidProtocol do
   begin
     //Gerar logs de exceção...
    CosmosServices.RegisterLog(E.Message, Format(TCosmosLogs.ContextInfoProtocol, [CurrentProtocol]), leOnError);
    DSServerConferencias.Stop;
   end;
  on E: Exception do
   begin
     //Gerar logs de exceção...
    CosmosServices.RegisterLog(E.Message, Format(TCosmosLogs.AppMethod, ['TDMConferenciasAppContainer.LoadServerConfigurations']), leOnError);
   end;
 end;
end;

procedure TDMConferenciasAppContainer.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  DSServerConferencias.Start;
end;

constructor TDMConferenciasAppContainer.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServerConferencias;
  FDSAuthenticationManager := DSAuthenticationManager;
end;

destructor TDMConferenciasAppContainer.Destroy;
begin
  inherited;
  FDSServer := nil;
  FDSAuthenticationManager := nil;
end;

procedure TDMConferenciasAppContainer.DataModuleCreate(Sender: TObject);
begin
 FDSServer := DSServerConferencias;
 FDSAuthenticationManager := DSAuthenticationManager;

 //Cria os objetos que disponibilizam métodos de serviços e acesso a dados.
 FCosmosServiceFactory := TCosmosServiceFactory.New(cmConferenciasServer);
 FCosmosDAOServiceFactory := TCosmosDAOServiceFactory.New(cmConferenciasServer);

 //Carrega as configurações do servidor
 LoadServerConfigurations;

 //Carrega as autorizações para cada método remoto.
 LoadMethodsAuthorizations;

 CosmosServices.RegisterLog(TCosmosLogs.InitializedServer, '');
end;

procedure TDMConferenciasAppContainer.DataModuleDestroy(Sender: TObject);
begin
  FDSServer := nil;
  FDSAuthenticationManager := nil;
  FCosmosServiceFactory := nil;
  FCosmosDAOServiceFactory := nil;
end;

procedure TDMConferenciasAppContainer.DSAuthenticationManagerUserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
 AInfo: string;
 AContextInfo: TStringList;
 UserData: TCosmosData;
begin
 {Autentica o usuário. Após a autenticação, o sistema armazena alguns dados
  do usuário e da conexão no gerenciador de sessões.}
 AContextInfo := CosmosServices.CreateContextInfoObject;
 UserData := TCosmosData.Create(15);

 try
  //Autentica o usuário.
  Valid := DAOServices.UserManager.AuthenticateUser(User, Password);

  if Valid then
    begin
     try
       DAOServices.UserManager.GetUserInfo(User, UserData);
       //Checa se o usuário está ativo.
       Valid := UserData.FindValue('ATIVO');; //do not localize!
       if not Valid then
         raise EInactivedUser.Create('');

       //Checa se o usuário está bloqueado.
       Valid := DAOServices.UserManager.UserIsBlocked(User);
       if not Valid then
         raise EBlockedUser.Create('');

     except
       Valid := False;
     end;

     //Verifica se o usuário pode acessar o módulo corrente do Cosmos.
     Valid := DAOServices.UserManager.CanAcessModule(User, cmSecretariasServer);
     if not Valid then
       raise ECantAcessCosmosModule.Create('');

     //Se chegou aqui, o usuário está autenticado.
     //Pega as roles do usuário autenticado e coloca os seus dados em sessão.
     DAOServices.UserManager.GetUserRoles(User, UserRoles);
     TDSSessionManager.GetThreadSession.PutData('UserName', User); //do not localize!
     TDSSessionManager.GetThreadSession.PutData('UserRoles', UserRoles.CommaText); //do not localize!
     TDSSessionManager.GetThreadSession.PutData('ConnectedUser', UserData.FindValue('USER_NAME')); //do not localize!
     //TDSSessionManager.GetThreadSession.PutData('UserInfo', AUserInfo.CommaText); //do not localize!
     TDSSessionManager.GetThreadSession.PutData('ConnectTime', DateTimeToStr(Now)); //do not localize!

     //Agora registra logs sobre a autenticação.
     AInfo := Format(TCosmosLogs.AutenticatedUser, [User]);
     AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
     AContextInfo.Append(Context);
     CosmosServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateSucess);
    end
   else
    raise EValidateUser.Create(Format(TCosmosLogs.InvalidAuthentication, [User]));

 AContextInfo.Free;
 UserData.Free;

 except
  on E: EValidateUser do//login ou senha inválidos
   begin
    AInfo := AInfo.Format(TCosmosLogs.InvalidAuthentication, [User]);
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
    AContextInfo.Append(Context);
    CosmosServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(UserData) then FreeAndNil(UserData);
   end;
  //O usuário está inativo.
  on E: EInactivedUser do
   begin
    AInfo := Format(TCosmosLogs.InactivedUser, [User]);
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
    AContextInfo.Append(Context);
    CosmosServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(UserData) then FreeAndNil(UserData);
   end;
  //O usuário não pode acessar o módulo corrente do Cosmos.
  on E: ECantAcessCosmosModule do
   begin
    AInfo := TCosmosLogs.CantAcessCosmosModule;
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
    AContextInfo.Append(Context);
    CosmosServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(UserData) then FreeAndNil(UserData);
   end;
  //O usuário está bloqueado.
  on E: EBlockedUser do
   begin
     AInfo := Format(TCosmosLogs.BlockedUser, [User]);
     AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
     AContextInfo.Append(Context);
     CosmosServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(UserData) then FreeAndNil(UserData);
   end;
  //outros erros
  on E: Exception do
   begin
    Valid := False;
    CosmosServices.RegisterLog(E.Message, '', leOnError);
    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(UserData) then FreeAndNil(UserData);
   end;
 end;
end;

procedure TDMConferenciasAppContainer.DSAuthenticationManagerUserAuthorize(
  Sender: TObject; AuthorizeEventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
var
 AInfo: string;
 AContextInfo: TStringList;
begin
 {Caso a autorização seja negada e a geração de logs estiver ativa para esse
 evento, será registrado um log.}
 if not Valid then
  begin
    if leOnAuthorize in CosmosServices.LogEvents then
     begin
      AContextInfo := CosmosServices.CreateContextInfoObject;

      try
        AInfo := Format(TCosmosLogs.DeniedAuthorization, [AuthorizeEventObject.UserName,
         AuthorizeEventObject.MethodAlias]);
        AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [AuthorizeEventObject.UserRoles.CommaText]));
        AContextInfo.Append(Format(TCosmosLogs.AuthorizedRoles, [AuthorizeEventObject.AuthorizedRoles.CommaText]));
        CosmosServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthorize);

      finally
        AContextInfo.Free;
      end;
     end;
  end;
end;

end.

