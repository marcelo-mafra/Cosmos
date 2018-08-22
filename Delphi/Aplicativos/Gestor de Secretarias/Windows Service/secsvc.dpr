program secsvc;

uses
  Vcl.SvcMgr,
  cosmos.servers.secretarias.ei.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.ei.methods.pas' {CosmosSecEIServerMethods: TDSServerModule},
  cosmos.servers.secretarias.focos.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.focos.methods.pas' {DMCosmosFocosMethods: TDSServerModule},
  cosmos.servers.secretarias.historico.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.historico.methods.pas' {CosmosSecHistoricoServerMethods: TDSServerModule},
  cosmos.servers.secretarias.lectorium.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.lectorium.methods.pas' {DMSecLectoriumServerMethods: TDSServerModule},
  cosmos.servers.secretarias.tp.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.tp.methods.pas' {CosmosSecTPServerMethods: TDSServerModule},
  cosmos.server.common.logradouros.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.server.common.logradouros.methods.pas' {DMCosmosServerLogradouros: TDSServerModule},
  cosmos.servers.secretarias.atividades.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.servers.secretarias.atividades.methods.pas' {DMSecAtividadesServerMethods: TDSServerModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {CosmosServerServices: TDataModule},
  cosmos.server.secretarias.appcontainer in 'cosmos.server.secretarias.appcontainer.pas' {DMSecretariasAppContainer: TDataModule},
  cosmos.servers.common.servicesint in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.servicesint.pas',
  cosmos.servers.common.dao.interfaces in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dao.interfaces.pas',
  cosmos.servers.common.services.factory in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.factory.pas',
  cosmos.servers.common.dsservices in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dsservices.pas',
  cosmos.servers.common.dao.factory in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dao.factory.pas',
  cosmos.system.types;

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;

  Application.CreateForm(TDMSecretariasAppContainer, DMSecretariasAppContainer);

  TDMCosmosApplicationServer.CreateObject(cmSecretariasServer, stWinService);
  TDMCosmosServerLogradouros.CreateObject(cmSecretariasServer, stWinService);
  TDMSecAtividadesServerMethods.CreateObject(cmSecretariasServer, stWinService);

  Application.Run;
end.

