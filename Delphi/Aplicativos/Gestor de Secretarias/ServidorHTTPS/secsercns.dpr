program secsercns;
{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Winapi.Windows,
  IdHTTPWebBrokerBridge,
  IdCustomHTTPServer,
  IdSSLOpenSSL,
  Web.WebReq,
  Web.WebBroker,
  Datasnap.DSSession,
  System.IniFiles,
  Cosmos.Classes.Application,
  Cosmos.System.Messages,
  cosmos.server.secretarias.appcontainer in 'cosmos.server.secretarias.appcontainer.pas' {DMSecretariasAppContainer: TDataModule},
  cosmos.server.secretarias.WebModule in 'cosmos.server.secretarias.WebModule.pas' {SecWebModule: TWebModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.server.common.logradouros.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.server.common.logradouros.methods.pas' {DMCosmosServerLogradouros: TDSServerModule},
  cosmos.servers.secretarias.atividades.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.servers.secretarias.atividades.methods.pas' {DMSecAtividadesServerMethods: TDSServerModule},
  cosmos.servers.secretarias.ei.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.ei.methods.pas' {CosmosSecEIServerMethods: TDSServerModule},
  cosmos.servers.secretarias.focos.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.focos.methods.pas' {DMCosmosFocosMethods: TDSServerModule},
  cosmos.servers.secretarias.historico.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.historico.methods.pas' {CosmosSecHistoricoServerMethods: TDSServerModule},
  cosmos.servers.secretarias.lectorium.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.lectorium.methods.pas' {DMSecLectoriumServerMethods: TDSServerModule},
  cosmos.servers.secretarias.tp.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.tp.methods.pas' {CosmosSecTPServerMethods: TDSServerModule};

{$R *.res}

var
 //Senha da chave privada do certificado digital gerado para a aplicação.
 sPrivateKey: string;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

type
  TGetSSLPassword = class
    procedure OnGetSSLPassword(var APassword: String);
    procedure OnSessionStart(Sender: TIdHTTPSession);
  end;

procedure TGetSSLPassword.OnGetSSLPassword(var APassword: String);
begin
  APassword := sPrivateKey;
end;

procedure TGetSSLPassword.OnSessionStart(Sender: TIdHTTPSession);
begin
  Writeln(Format('Session start: %s', [Sender.Content.Text]));
end;

procedure RunServer;
var
  LInputRecord: TInputRecord;
  LEvent: DWord;
  LHandle: THandle;
  LServer: TIdHTTPWebBrokerBridge;
  LGetSSLPassword: TGetSSLPassword;
  LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
  aStarterFile: TIniFile;
  APort, MaxConnections:Integer;
  AFileName, CertFile, RootCertFile, KeyFile: string;
  CosmosApp: TCosmosApplication;
begin
{Inicializa o servidor standalone https, iniciando por obter as configurações
 do servidor como certificados ssl, porta de comunicação etc.}
 CosmosApp := TCosmosApplication.Create;
 AFileName := CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot;
 aStarterFile := TIniFile.Create(AFileName);

 try
  //Certificado da Autoridade Certificadora.
  RootCertFile := aStarterFile.ReadString('Certificates', 'RootCertFile', '');
  //Certificado público do Cosmos.
  CertFile := aStarterFile.ReadString('Certificates', 'CertificateFile', '');
  //Chave privada do Cosmos.
  KeyFile := aStarterFile.ReadString('Certificates', 'PrivateKeyFile', '');
  //Senha da chave privada.
  sPrivateKey := aStarterFile.ReadString('Certificates', 'PrivateKey', '');

  APort := aStarterFile.ReadInteger('GSEC', 'DSHTTPService.HttpsPort', 443);

  MaxConnections := aStarterFile.ReadInteger('GSEC', 'DSHTTPService.MaxConnections', 100);

 finally
  aStarterFile.Free;
  CosmosApp.Free;
 end;


  Writeln(Format('Starting HTTP Server on port %d', [APort]));
  LGetSSLPassword := nil;
  LServer := TIdHTTPWebBrokerBridge.Create(nil);

  try
    LGetSSLPassword := TGetSSLPassword.Create;
    LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(LServer);
    //Atribui os arquivos dos certificados.
    LIOHandleSSL.SSLOptions.CertFile := CertFile;
    LIOHandleSSL.SSLOptions.RootCertFile := RootCertFile;
    LIOHandleSSL.SSLOptions.KeyFile := KeyFile;

    LIOHandleSSL.OnGetPassword := LGetSSLPassword.OnGetSSLPassword;
    LServer.OnSessionStart := LGetSSLPassword.OnSessionStart;
    LServer.IOHandler := LIOHandleSSL;
    LServer.DefaultPort := APort;
    LServer.MaxConnections := MaxConnections;
    LServer.KeepAlive := True;

    LServer.Active := True;
    Writeln('SSL is activated.');
    Writeln('Gsec server started successfully.');
    Writeln('');
    Writeln('Press ESC to stop the server');
    LHandle := GetStdHandle(STD_INPUT_HANDLE);


    while True do
     begin
      ReadConsoleInput(LHandle, LInputRecord, 1, LEvent);
      if (LInputRecord.EventType = KEY_EVENT) and
      LInputRecord.Event.KeyEvent.bKeyDown and
      (LInputRecord.Event.KeyEvent.wVirtualKeyCode = VK_ESCAPE) then
       begin
        Writeln('Closing and going to home...');
        break;
       end;
     end;

    TerminateThreads();

  finally
    LServer.Free;
    LGetSSLPassword.Free;
  end;
end;

begin
  try
   if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
   RunServer;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end
end.
