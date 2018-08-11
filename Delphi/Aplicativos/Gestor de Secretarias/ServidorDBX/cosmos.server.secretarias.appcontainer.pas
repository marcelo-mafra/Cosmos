unit cosmos.server.secretarias.appcontainer;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer, Datasnap.DSAuth, IPPeerServer,
  Datasnap.DSHTTP,  System.Generics.Collections, Datasnap.DSSession, IdTCPConnection,
  cosmos.system.types, cosmos.system.messages, cosmos.system.exceptions,
  cosmos.classes.application, Data.DBXCommon, DSHTTPLayer, cosmos.classes.logs,
  cosmos.classes.persistence.ini, Data.DBCommonTypes, Datasnap.DSHTTPCommon,
  Data.DBXCommonIndy, Data.DBXJSON, cosmos.system.winshell;

type
  TServerProtocol = (spTCP, spHTTP, spHTTPS); //Protocolos de conexão que podem ser usados.

  TOnPrepareCommandEvent = procedure(Session: TDSSession) of object;
  TOnConnectServerEvent = procedure(DSConnectEventObject: TDSConnectEventObject) of object;
  TOnDisconnectServerEvent = procedure(DSConnectEventObject: TDSConnectEventObject) of object;


  TDMSecretariasAppContainer = class(TDataModule)
    DSServerSecretarias: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSHTTPService: TDSHTTPService;
    DSCertFiles: TDSCertFiles;
    DSAuthenticationManager: TDSAuthenticationManager;
    DSServerApplicationClass: TDSServerClass;
    DSServerLectoriumClass: TDSServerClass;
    DSServerLogradourosClass: TDSServerClass;
    DSServerAtividadesClass: TDSServerClass;
    DSServerHistoricoClass: TDSServerClass;
    DSHTTPServiceFile: TDSHTTPServiceFileDispatcher;
    DSServerTPClass: TDSServerClass;
    DSEscolaInternaClass: TDSServerClass;
    DSFocosClass: TDSServerClass;
    DSHTTPSService: TDSHTTPService;
    procedure DSServerApplicationClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSCertFilesGetPEMFilePasskey(ASender: TObject;
      var APasskey: AnsiString);
    procedure DSAuthenticationManagerUserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSServerLectoriumClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DSServerLogradourosClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServerAtividadesClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSTCPServerTransportConnect(Event: TDSTCPConnectEventObject);
    procedure DSTCPServerTransportDisconnect(
      Event: TDSTCPDisconnectEventObject);
    procedure DSServerSecretariasPrepare(
      DSPrepareEventObject: TDSPrepareEventObject);
    procedure DSServerSecretariasError(DSErrorEventObject: TDSErrorEventObject);
    procedure DSServerSecretariasConnect(
      DSConnectEventObject: TDSConnectEventObject);
    procedure DSServerSecretariasDisconnect(
      DSConnectEventObject: TDSConnectEventObject);
    function DSServerSecretariasTrace(TraceInfo: TDBXTraceInfo): CBRType;
    procedure DSAuthenticationManagerUserAuthorize(Sender: TObject;
      AuthorizeEventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSServerHistoricoClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSHTTPServiceTrace(Sender: TObject; AContext: TDSHTTPContext;
      ARequest: TDSHTTPRequest; AResponse: TDSHTTPResponse);
    procedure DSServerTPClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSEscolaInternaClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSFocosClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
    FActiveProtocol: TServerProtocol;
    FTestServerPage: string;

    FOnConnectServer: TOnConnectServerEvent;
    FOnDisconnectServer: TOnDisconnectServerEvent;
    FOnPrepareCommand: TOnPrepareCommandEvent;

    FTCPConnections: TObjectDictionary<TIdTCPConnection,TDSTCPChannel>;

    procedure LoadMethodsAuthorizations;
    procedure LoadServerConfigurations;
    procedure ValidateCertificate(Owner: TObject; Certificate: TX509Certificate;
                 const ADepth: Integer; var Ok: Boolean);
  public
    procedure GetServerConfigurations(AList: TStringList);

    property ActiveProtocol: TServerProtocol read FActiveProtocol;
    property OnConnectServer: TOnConnectServerEvent read FOnConnectServer write FOnConnectServer;
    property OnDisconnectServer: TOnDisconnectServerEvent read FOnDisconnectServer write FOnDisconnectServer;
    property OnPrepareCommand: TOnPrepareCommandEvent read FOnPrepareCommand write FOnPrepareCommand;
    property TestServerPage: string read FTestServerPage;
  end;

var
  DMSecretariasAppContainer: TDMSecretariasAppContainer;

implementation

uses cosmos.servers.common.services, cosmos.servers.common.methods,
  cosmos.servers.secretarias.lectorium.methods, cosmos.servers.common.security,
  cosmos.servers.common.security.authorizations, cosmos.server.common.logradouros.methods,
  cosmos.servers.secretarias.atividades.methods, cosmos.servers.secretarias.historico.methods,
  cosmos.servers.common.dataacess, cosmos.servers.secretarias.pageproducer,
  cosmos.servers.secretarias.tp.methods, cosmos.servers.secretarias.ei.methods,
  cosmos.servers.secretarias.focos.methods;

{$R *.dfm}

procedure TDMSecretariasAppContainer.DSServerApplicationClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMCosmosApplicationServer;
end;

procedure TDMSecretariasAppContainer.DSServerAtividadesClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMSecAtividadesServerMethods;
end;

procedure TDMSecretariasAppContainer.DSServerHistoricoClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TCosmosSecHistoricoServerMethods;
end;

procedure TDMSecretariasAppContainer.DSServerLectoriumClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMSecLectoriumServerMethods;
end;

procedure TDMSecretariasAppContainer.DSServerLogradourosClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMCosmosServerLogradouros;
end;

procedure TDMSecretariasAppContainer.DSServerSecretariasConnect(
  DSConnectEventObject: TDSConnectEventObject);
var
 AInfo: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de operações de conexão.}
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

procedure TDMSecretariasAppContainer.DSServerSecretariasDisconnect(
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

procedure TDMSecretariasAppContainer.DSServerSecretariasError(
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

procedure TDMSecretariasAppContainer.DSServerSecretariasPrepare(
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

    //Dispara um evento que pode ser capturado pelo Form principal, para notificação.
    if Assigned(FOnPrepareCommand) then FOnPrepareCommand(TDSSessionManager.GetThreadSession);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

function TDMSecretariasAppContainer.DSServerSecretariasTrace(
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

procedure TDMSecretariasAppContainer.DSServerTPClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TCosmosSecTPServerMethods;
end;

procedure TDMSecretariasAppContainer.DSTCPServerTransportConnect(
  Event: TDSTCPConnectEventObject);
begin
//http://docwiki.embarcadero.com/RADStudio/XE3/en/Monitoring_and_Controlling_DataSnap_TCP/IP_Connections
{ TMonitor.Enter(FTCPConnections);

 try
   FTCPConnections.Add(TIdTCPConnection(Event.Connection), Event.Channel);

 finally
   TMonitor.Exit(FTCPConnections);
 end;

 //Enable Keep-alive for this new connection.
 Event.Channel.EnableKeepAlive(DSTCPServerTransport.KeepAliveTime, DSTCPServerTransport.KeepAliveInterval);

 TThread.Synchronize(nil, procedure
  begin
   sInfo := Format('RequestConnect: Ip: %s', [Event.Channel.ChannelInfo.ClientInfo.IpAddress]);
   FrmSecretariasMainForm.RegisterInfo(sInfo, TIdTCPConnection(Event.Connection));
  end);}
end;

procedure TDMSecretariasAppContainer.DSTCPServerTransportDisconnect(
  Event: TDSTCPDisconnectEventObject);
begin
{  if (FTCPConnections = nil) or (Event.Connection = nil) then
    Exit;

  //This is called when a TCP connection is closed, for whatever reason.
  TMonitor.Enter(FTCPConnections);

  try
    FTCPConnections.Remove(TIdTCPConnection(Event.Connection));

    TThread.Synchronize(nil, procedure
      begin
        //update the connection list box, removing the connection that was just closed
        FrmSecretariasMainForm.UnregisterInfo(Event.Connection);
      end);

  finally
    TMonitor.Exit(FTCPConnections);
  end; }
end;

procedure TDMSecretariasAppContainer.GetServerConfigurations(
  AList: TStringList);
begin
 //Lista em um objeto tipo "lista" informações sobre o servidor.
 case self.ActiveProtocol of
   spTCP:
    begin
     AList.Append(Format('Protocolo=%s', ['tcp/ip'])); //do not localize!
     AList.Append(Format('Porta=%d', [DSTCPServerTransport.Port]));
    end;
   spHTTP:
    begin
     AList.Append(Format('Protocolo=%s', ['http'])); //do not localize!
     AList.Append(Format('Porta=%d', [DSHTTPService.HttpPort]));  //do not localize!
    end;
   spHTTPS:
    begin
     AList.Append(Format('Protocolo=%s', ['https'])); //do not localize!
     AList.Append(Format('Porta=%d', [DSHTTPSService.HttpPort]));  //do not localize!
    end;
 end;

 AList.Append(Format('Servidor=%s', [TWinShell.GetIPAddress]));
 AList.Append(Format('RunOn=%s', [DateTimeToStr(Now)]));
end;

procedure TDMSecretariasAppContainer.LoadMethodsAuthorizations;
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
    if (IMethodInfo.CosmosModule = TCosmosAppName.CosmosSecretariasId) or (IMethodInfo.CosmosModule = TCosmosAppName.CosmosCommonId) then
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
  if Assigned(IAuthorizations) then
   IAuthorizations := nil;
  if Assigned(CosmosApp) then
   FreeAndNil(CosmosApp);
 end;
end;

procedure TDMSecretariasAppContainer.LoadServerConfigurations;
 var
  AFile: TIniFilePersistence;
  AFileName, CurrentProtocol: string;
  CosmosApp: TCosmosApplication;
  AList: TStringList;
begin
{Carregas as configurações do servidor em execução. Estas configurações envolvem
 protocolos de conexão, certificados, dentre outros itens.}
 CosmosApp := TCosmosApplication.Create;
 AFileName := CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot;
 AFile := TIniFilePersistence.Create(AFileName, True);
 AList := TStringList.Create;

 try
  //Configurações das classes expostas remotamente.
  DSServerApplicationClass.LifeCycle := AFile.ReadString('GSEC', 'DSServerApplicationClass.LifeCycle', 'Session');
  DSServerLectoriumClass.LifeCycle := DSServerApplicationClass.LifeCycle;
  DSServerLogradourosClass.LifeCycle := DSServerApplicationClass.LifeCycle;
  DSServerAtividadesClass.LifeCycle := DSServerApplicationClass.LifeCycle;

  CurrentProtocol := AFile.ReadString('GSEC', 'DSCurrentProtocol', 'HTTPS');

  if UpperCase(CurrentProtocol) = 'TCP/IP' then //Conexão TCP/IP
   begin
    DSTCPServerTransport.BufferKBSize := AFile.ReadInteger('GSEC', 'TCPConnection.BufferKBSize', 32);
    DSTCPServerTransport.Port := AFile.ReadInteger('GSEC', 'TCPConnection.Port', 10001);
    DSTCPServerTransport.MaxThreads := AFile.ReadInteger('GSEC', 'TCPConnection.MaxThreads', 0);
    DSTCPServerTransport.PoolSize := AFile.ReadInteger('GSEC', 'TCPConnection.PoolSize', 10);

    case AFile.ReadInteger('GSEC', 'TCPConnection.KeepAliveEnablement', 0) of
     0: DSTCPServerTransport.KeepAliveEnablement := kaDefault;
     1: DSTCPServerTransport.KeepAliveEnablement := kaEnabled;
     2: DSTCPServerTransport.KeepAliveEnablement := kaDisabled
     else
      DSTCPServerTransport.KeepAliveEnablement := kaDefault;
    end;

    DSTCPServerTransport.KeepAliveTime := AFile.ReadInteger('GSEC', 'TCPConnection.KeepAliveTime', 0);
    DSTCPServerTransport.KeepAliveInterval := AFile.ReadInteger('GSEC', 'TCPConnection.KeepAliveInterval', 0);

    DSTCPServerTransport.Server := DSServerSecretarias;
    DSTCPServerTransport.Start;
   end
   else
  if UpperCase(CurrentProtocol) = 'HTTP' then  //Configurações do objeto de conexão HTTP
   begin
    FTestServerPage := AFile.ReadString('GSEC', 'TestSeverPage', '');
    DSHTTPService.Server := DSServerSecretarias;
    DSHTTPService.DSHostname := AFile.ReadString('GSEC', 'DSHTTPService.DSHostname', '');
    DSHTTPService.DSPort := AFile.ReadInteger('GSEC', 'DSHTTPService.DSPort', 0);
    DSHTTPService.HttpPort := AFile.ReadInteger('GSEC', 'DSHTTPService.HttpPort', 0);
    DSHTTPService.SessionTimeout := AFile.ReadInteger('GSEC', 'DSHTTPService.SessionTimeout', 0);

    DSHTTPService.Start;
    FActiveProtocol := spHTTPS;
   end
   else
  if UpperCase(CurrentProtocol) = 'HTTPS' then  //Configurações do objeto de conexão HTTPS
   begin
    //Primeiro, carrega as configurações de certificados X.509.
    DSCertFiles.RootCertFile := AFile.ReadString('Certificates', 'RootCertFile', '');
    DSCertFiles.CertFile := AFile.ReadString('Certificates', 'CertificateFile', '');
    DSCertFiles.KeyFile := AFile.ReadString('Certificates', 'PrivateKeyFile', '');

    //Aponta a propriedade para o método de validação do certificado SSL.
    DSAuthenticationManager.OnValidatePeerCertificate := ValidateCertificate;

    //Configura o objeto Indy interno que implementa HTTPS.
   // DSCertFiles.SetServerProperties(DSHTTPService.HttpServer);

    //Agora, carrega as propriedades do servidor HTTPS.
    FTestServerPage := AFile.ReadString('GSEC', 'TestSeverPage', '');
    DSHTTPSService.Server := DSServerSecretarias;
    DSHTTPSService.DSHostname := AFile.ReadString('GSEC', 'DSHTTPService.DSHostname', '');
    DSHTTPSService.DSPort := AFile.ReadInteger('GSEC', 'DSHTTPService.DSPort', 0);
    DSHTTPSService.HttpPort := AFile.ReadInteger('GSEC', 'DSHTTPService.HttpsPort', 443);
    DSHTTPSService.SessionTimeout := AFile.ReadInteger('GSEC', 'DSHTTPService.SessionTimeout', 0);

   // DSHTTPSService.Start;
    FActiveProtocol := spHTTPS;
   end
  else //Configuração de protocolo errada. Não pode continuar!
    raise EInvalidProtocol.Create(TCosmosErrorMsg.InvalidProtocol);

  DSServerSecretarias.Start;

  if Assigned(AFile) then FreeAndNil(AFile);
  if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
  if Assigned(AList) then FreeAndNil(AList);

 except
  on E: EInvalidProtocol do
   begin
     //Gerar logs de exceção...
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.ContextInfoProtocol, [CurrentProtocol]), leOnError);
    DSServerSecretarias.Stop;
   end;
  on E: Exception do
   begin
     //Gerar logs de exceção...
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.AppMethod, ['TDMSecretariasAppContainer.LoadServerConfigurations']), leOnError);
   end;
 end;
end;

procedure TDMSecretariasAppContainer.ValidateCertificate(Owner: TObject;
  Certificate: TX509Certificate; const ADepth: Integer; var Ok: Boolean);
begin
// Certificate := TX509CertificateIndy.Create(DSCertFiles.CertFile);

 try
 // TX509CertificateIndy(Certificate).CheckValidity;

  //Ok := Certificate.Verify(Certificate.GetPublicKey);

 except
  Ok := False;
 end;
end;

procedure TDMSecretariasAppContainer.DataModuleCreate(Sender: TObject);
begin
 DMCosmosServerServices.CosmosModule := cmSecretariasServer;
 //Carrega as configurações do servidor
 LoadServerConfigurations;

 //Carrega as autorizações para cada método remoto.
 LoadMethodsAuthorizations;

 //Cria o pool de conexão com o banco de dados.
 FTCPConnections := TObjectDictionary<TIdTCPConnection,TDSTCPChannel>.Create;

 DMCosmosServerServices.RegisterLog(TCosmosLogs.InitializedServer, '');

end;

procedure TDMSecretariasAppContainer.DSAuthenticationManagerUserAuthenticate(
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
       Valid := AUserInfo.Values['INDATI'] = 'S';
       if not Valid then
         raise EInactivedUser.Create('');

       if Valid then //Checa se o usuário está bloqueado.
        begin
         Valid := AUserInfo.Values['INDBLO'] = 'N';
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

procedure TDMSecretariasAppContainer.DSAuthenticationManagerUserAuthorize(
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

procedure TDMSecretariasAppContainer.DSCertFilesGetPEMFilePasskey(ASender: TObject;
  var APasskey: AnsiString);
begin
  APasskey := '';
end;


procedure TDMSecretariasAppContainer.DSEscolaInternaClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TCosmosSecEIServerMethods;
end;

procedure TDMSecretariasAppContainer.DSFocosClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDMCosmosFocosMethods;
end;

procedure TDMSecretariasAppContainer.DSHTTPServiceTrace(Sender: TObject;
  AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
  AResponse: TDSHTTPResponse);
 var
 AContent: TStringList;
begin
{Aciona uma página de testes para o usuário certificar-se de que o servidor está
sendo executado normalmente. Isso é feito por meio de um navegador web, informando
na url o endereço completo do servidor e o parâmetro "testpage". Uma página
HTML será exibida caso o servidor Cosmos responda corretamente.}

 if (ARequest.Params.Count > 0) and (ARequest.Params.Strings[0] = 'testpage') then
  begin

   AContent := TStringList.Create;

   try
    //AResponse.ContentText := DMSecPageProducer.GeneratePage(ARequest.Params);
    AContent.LoadFromFile(TestServerPage);
    AResponse.ContentText := AContent.Text;

   finally
    AContent.Free;
   end;
  end;

 if (ARequest.Params.Count > 0) and (ARequest.Params.Strings[0] = 'LoadPupils') then
  begin
   AResponse.ContentText := DMSecPageProducer.GeneratePage(nil)
  end;
end;

end.

