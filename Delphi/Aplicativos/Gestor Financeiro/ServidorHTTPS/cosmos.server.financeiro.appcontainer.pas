unit cosmos.server.financeiro.appcontainer;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSCommonServer, Datasnap.DSAuth, IPPeerServer,
  System.Generics.Collections, Datasnap.DSSession, cosmos.system.files,
  cosmos.system.types, cosmos.system.messages, cosmos.system.exceptions,
  cosmos.classes.application, Data.DBXCommon, DSHTTPLayer, cosmos.classes.logs,
  cosmos.classes.persistence.ini, Data.DBCommonTypes;

type
  TServerProtocol = (spTCP, spHTTP, spHTTPS); //Protocolos de conexão que podem ser usados.

  TOnPrepareCommandEvent = procedure(Session: TDSSession) of object;
  TOnConnectServerEvent = procedure(DSConnectEventObject: TDSConnectEventObject) of object;
  TOnDisconnectServerEvent = procedure(DSConnectEventObject: TDSConnectEventObject) of object;


  TDMFinanceiroAppContainer = class(TDataModule)
    DSServerFinanceiro: TDSServer;
    DSAuthenticationManager: TDSAuthenticationManager;
    DSServerApplicationClass: TDSServerClass;
    DSServerFinanceiroClass: TDSServerClass;
    procedure DSServerApplicationClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManagerUserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DataModuleCreate(Sender: TObject);
    procedure DSServerFinanceiroPrepare(
      DSPrepareEventObject: TDSPrepareEventObject);
    procedure DSServerFinanceiroError(DSErrorEventObject: TDSErrorEventObject);
    procedure DSServerFinanceiroConnect(
      DSConnectEventObject: TDSConnectEventObject);
    procedure DSServerFinanceiroDisconnect(
      DSConnectEventObject: TDSConnectEventObject);
    function DSServerFinanceiroTrace(TraceInfo: TDBXTraceInfo): CBRType;
    procedure DSAuthenticationManagerUserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DSServerFinanceiroClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
    FActiveProtocol: TServerProtocol;
    FTestServerPage: string;

    FOnConnectServer: TOnConnectServerEvent;
    FOnDisconnectServer: TOnDisconnectServerEvent;
    FOnPrepareCommand: TOnPrepareCommandEvent;

    procedure LoadMethodsAuthorizations;
    procedure LoadServerConfigurations;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ActiveProtocol: TServerProtocol read FActiveProtocol;
    property OnConnectServer: TOnConnectServerEvent read FOnConnectServer write FOnConnectServer;
    property OnDisconnectServer: TOnDisconnectServerEvent read FOnDisconnectServer write FOnDisconnectServer;
    property OnPrepareCommand: TOnPrepareCommandEvent read FOnPrepareCommand write FOnPrepareCommand;
    property TestServerPage: string read FTestServerPage;
  end;

function DSServer: TDSServer;
function DSAuthenticationManager: TDSAuthenticationManager;

implementation

uses cosmos.servers.common.services, cosmos.servers.common.methods,
  cosmos.servers.financeiro.finmethods, cosmos.servers.common.security,
  cosmos.servers.common.security.authorizations, cosmos.servers.common.dataacess;

{$R *.dfm}

var
  FModule: TComponent;
  FDSServer: TDSServer;
  FDSAuthenticationManager: TDSAuthenticationManager;


function DSServer: TDSServer;
begin
  Result := FDSServer;
end;

function DSAuthenticationManager: TDSAuthenticationManager;
begin
  Result := FDSAuthenticationManager;
end;

procedure TDMFinanceiroAppContainer.DSServerApplicationClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMCosmosApplicationServer;
end;

procedure TDMFinanceiroAppContainer.DSServerFinanceiroClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMFinanceiroMethods;
end;

procedure TDMFinanceiroAppContainer.DSServerFinanceiroConnect(
  DSConnectEventObject: TDSConnectEventObject);
var
 AInfo: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de operações de conexão.}

 //Registra qual o servidor Cosmos que está usando a classe TDMCosmosServices.
 DMCosmosServerServices.CosmosModule := cmFinanceiroServer;
 //Prepara o objeto que receberá as informações de contexto da conexão.
 AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

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

    DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.DelimitedText, leOnConnect);

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

procedure TDMFinanceiroAppContainer.DSServerFinanceiroDisconnect(
  DSConnectEventObject: TDSConnectEventObject);
var
 AInfo: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de operações de desconexão.}
 //DMServerDataAcess.ConnectionPool.RemoveConnection(TDSSessionManager.GetThreadSession.Id);

 AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

 try
  with DSConnectEventObject do
   begin
    AInfo := Format(TCosmosLogs.DisconnectedUser, [ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]]);

    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [ConnectProperties[TDBXPropertyNames.CommunicationProtocol]]));
   end;

  DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.DelimitedText, leOnConnectClose);

  if Assigned(OnDisconnectServer) then OnDisconnectServer(DSConnectEventObject);

 finally
  AContextInfo.Free;
 end;
end;

procedure TDMFinanceiroAppContainer.DSServerFinanceiroError(
  DSErrorEventObject: TDSErrorEventObject);
var
 Info: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de erros de execução de métodos remotos.}
 if leOnError in DMCosmosServerServices.LogEvents then
  begin
   AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

   try
    with DSErrorEventObject do
     begin
      Info := DSErrorEventObject.Error.Message;
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [ServerConnectionHandler.Channel.ChannelInfo.ClientInfo.Protocol]));
     end;

    DMCosmosServerServices.RegisterLog(Info, AContextInfo.DelimitedText, leOnError);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

procedure TDMFinanceiroAppContainer.DSServerFinanceiroPrepare(
  DSPrepareEventObject: TDSPrepareEventObject);
var
 Info: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de preparação de execução de métodos remotos.}
 if leOnPrepare in DMCosmosServerServices.LogEvents then
  begin
   AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

   try
    with DSPrepareEventObject do
     begin
      Info := DSPrepareEventObject.MethodAlias;
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));
      AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [ServerConnectionHandler.Channel.ChannelInfo.ClientInfo.Protocol]));
     end;

    DMCosmosServerServices.RegisterLog(Info, AContextInfo.DelimitedText, leOnPrepare);

    //Dispara um evento de notificação que pode ser capturado.
    if Assigned(FOnPrepareCommand) then FOnPrepareCommand(TDSSessionManager.GetThreadSession);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

function TDMFinanceiroAppContainer.DSServerFinanceiroTrace(
  TraceInfo: TDBXTraceInfo): CBRType;
var
 Info: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de trace, caso a geração para este tipo de
 evento esteja ativa.}
 if leOnTrace in DMCosmosServerServices.LogEvents then
  begin
   AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

   try
    Info := TraceInfo.Message;
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));

    DMCosmosServerServices.RegisterLog(Info, AContextInfo.DelimitedText, leOnTrace);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

procedure TDMFinanceiroAppContainer.LoadMethodsAuthorizations;
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
    if (IMethodInfo.CosmosModule = TCosmosAppName.CosmosFinanceiroId) or (IMethodInfo.CosmosModule = TCosmosAppName.CosmosCommonId) then
     begin
      ARoleInfo := TDSRoleItem(DSAuthenticationManager.Roles.Add);
      ARoleInfo.ApplyTo.CommaText := IMethodInfo.MethodName;
      ARoleInfo.AuthorizedRoles.CommaText := IMethodInfo.AuthorizedRoles;
      ARoleInfo.DeniedRoles.CommaText := IMethodInfo.DeniedRoles;
      ARoleInfo.Exclude.CommaText := IMethodInfo.Exclude;
     end;
   end;

  DMCosmosServerServices.RegisterLog(TCosmosLogs.AuthorizationsMethods, '');

 finally
  if Assigned(IAuthorizations) then IAuthorizations := nil;
  if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
 end;
end;

procedure TDMFinanceiroAppContainer.LoadServerConfigurations;
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
  DSServerApplicationClass.LifeCycle := AFile.ReadString('GFIN', 'DSServerApplicationClass.LifeCycle', 'Session');
  DSServerFinanceiroClass.LifeCycle := DSServerApplicationClass.LifeCycle;

  if Assigned(AFile) then FreeAndNil(AFile);
  if Assigned(CosmosApp) then  FreeAndNil(CosmosApp);

 except
  on E: EInvalidProtocol do
   begin
     //Gerar logs de exceção...
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.ContextInfoProtocol, [CurrentProtocol]), leOnError);
    DSServerFinanceiro.Stop;
   end;
  on E: Exception do
   begin
     //Gerar logs de exceção...
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.AppMethod, ['TDMFinanceiroAppContainer.LoadServerConfigurations']), leOnError);
   end;
 end;
end;

constructor TDMFinanceiroAppContainer.Create(AOwner: TComponent);
begin
  inherited;
  FDSServer := DSServerFinanceiro;
  FDSAuthenticationManager := DSAuthenticationManager;
end;

destructor TDMFinanceiroAppContainer.Destroy;
begin
  inherited;
  FDSServer := nil;
  FDSAuthenticationManager := nil;
end;

procedure TDMFinanceiroAppContainer.DataModuleCreate(Sender: TObject);
begin
 FDSServer := DSServerFinanceiro;
 FDSAuthenticationManager := DSAuthenticationManager;

 //Cria os objetos que disponibilizam métodos de serviços e acesso a dados.
 DMCosmosServerServices := TDMCosmosServerServices.Create(nil);
 DMCosmosServerServices.CosmosModule := cmFinanceiroServer;

 DMServerDataAcess := TDMServerDataAcess.Create(nil);
 //Carrega as configurações do servidor
 LoadServerConfigurations;

 //Carrega as autorizações para cada método remoto.
 LoadMethodsAuthorizations;

 DMCosmosServerServices.RegisterLog(TCosmosLogs.InitializedServer, '');
end;

procedure TDMFinanceiroAppContainer.DataModuleDestroy(Sender: TObject);
begin
  FDSServer := nil;
  FDSAuthenticationManager := nil;
  DMServerDataAcess.Free;
  DMCosmosServerServices.Free;
end;

procedure TDMFinanceiroAppContainer.DSAuthenticationManagerUserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
 AInfo: string;
 AContextInfo, AUserInfo: TStringList;
begin
 {Autentica o usuário. Após a autenticação, o sistema armazena alguns dados
  do usuário e da conexão no gerenciador de sessões.}
 AContextInfo := DMCosmosServerServices.CreateContextInfoObject;
 AUserInfo := TStringList.Create;

 try
  //Autentica o usuário.
  Valid := TCosmosSecurity.AuthenticateUser(User, Password);

  if Valid then
    begin
     try
       TCosmosSecurity.GetCosmosUserInfo(User, AUserInfo);
       //Checa se o usuário está ativo.
       Valid := AUserInfo.Values['INDATI'] = 'S'; //do not localize!
       if not Valid then
         raise EInactivedUser.Create('');

       if Valid then //Checa se o usuário está bloqueado.
        begin
         Valid := AUserInfo.Values['INDBLO'] = 'N';  //do not localize!
         if not Valid then
          raise EBlockedUser.Create('');
        end;

     except
       Valid := False;
     end;

     //Verifica se o usuário pode acessar o módulo corrente do Cosmos.
     Valid := TCosmosSecurity.CanAcessModule(User, DMCosmosServerServices.CosmosModule);
     if not Valid then
       raise ECantAcessCosmosModule.Create('');

     //Se chegou aqui, o usuário está autenticado.
     if Valid then
      begin
       //Pega as roles do usuário autenticado e coloca os seus dados em sessão.
       TCosmosSecurity.GetUserRoles(User, UserRoles);
       TDSSessionManager.GetThreadSession.PutData('UserName', User);
       TDSSessionManager.GetThreadSession.PutData('UserRoles', UserRoles.CommaText);
       TDSSessionManager.GetThreadSession.PutData('ConnectedUser', AUserInfo.Values['NOMCAD']);
       TDSSessionManager.GetThreadSession.PutData('UserInfo', AUserInfo.CommaText);
       TDSSessionManager.GetThreadSession.PutData('ConnectTime', DateTimeToStr(Now));

       //Agora registra logs sobre a autenticação.
       AInfo := Format(TCosmosLogs.AutenticatedUser, [User]);
       AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
       AContextInfo.Append(Context);
       DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateSucess);
      end;
    end
   else
    raise EValidateUser.Create(Format(TCosmosLogs.InvalidAuthentication, [User]));

 AContextInfo.Free;
 AUserInfo.Free;

 except
  on E: EValidateUser do//login ou senha inválidos
   begin
    AInfo := AInfo.Format(TCosmosLogs.InvalidAuthentication, [User]);
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
    AContextInfo.Append(Context);
    DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(AUserInfo) then FreeAndNil(AUserInfo);
   end;
  //O usuário está inativo.
  on E: EInactivedUser do
   begin
    AInfo := Format(TCosmosLogs.InactivedUser, [User]);
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
    AContextInfo.Append(Context);
    DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(AUserInfo) then FreeAndNil(AUserInfo);
   end;
  //O usuário não pode acessar o módulo corrente do Cosmos.
  on E: ECantAcessCosmosModule do
   begin
    AInfo := TCosmosLogs.CantAcessCosmosModule;
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
    AContextInfo.Append(Context);
    DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(AUserInfo) then FreeAndNil(AUserInfo);
   end;
  //O usuário está bloqueado.
  on E: EBlockedUser do
   begin
     AInfo := Format(TCosmosLogs.BlockedUser, [User]);
     AContextInfo.Append(Format(TCosmosLogs.ContextInfoProtocol, [protocol]));
     AContextInfo.Append(Context);
     DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthenticateFail);

    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(AUserInfo) then FreeAndNil(AUserInfo);
   end;
  //outros erros
  on E: Exception do
   begin
    Valid := False;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
    if Assigned(AUserInfo) then FreeAndNil(AUserInfo);
   end;
 end;
end;

procedure TDMFinanceiroAppContainer.DSAuthenticationManagerUserAuthorize(
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
    if leOnAuthorize in DMCosmosServerServices.LogEvents then
     begin
      AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

      try
        AInfo := Format(TCosmosLogs.DeniedAuthorization, [AuthorizeEventObject.UserName,
         AuthorizeEventObject.MethodAlias]);
        AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [AuthorizeEventObject.UserRoles.CommaText]));
        AContextInfo.Append(Format(TCosmosLogs.AuthorizedRoles, [AuthorizeEventObject.AuthorizedRoles.CommaText]));
        DMCosmosServerServices.RegisterLog(AInfo, AContextInfo.CommaText, leOnAuthorize);

      finally
        AContextInfo.Free;
      end;
     end;
  end;
end;

initialization
  FModule := TDMFinanceiroAppContainer.Create(nil);

finalization
  FModule.Free;

end.

