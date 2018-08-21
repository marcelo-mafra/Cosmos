library secserisp;

uses
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  Web.Win.ISAPIThreadPool,
  Data.DBXCommon,
  Datasnap.DSSession,
  cosmos.server.secretarias.WebModule in 'cosmos.server.secretarias.WebModule.pas' {SecWebModule: TWebModule},
  cosmos.server.secretarias.appcontainer in 'cosmos.server.secretarias.appcontainer.pas' {DMSecretariasAppContainer: TDataModule},
  cosmos.servers.secretarias.ei.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.ei.methods.pas' {CosmosSecEIServerMethods: TDSServerModule},
  cosmos.servers.secretarias.focos.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.focos.methods.pas' {DMCosmosFocosMethods: TDSServerModule},
  cosmos.servers.secretarias.historico.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.historico.methods.pas' {CosmosSecHistoricoServerMethods: TDSServerModule},
  cosmos.servers.secretarias.lectorium.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.lectorium.methods.pas' {DMSecLectoriumServerMethods: TDSServerModule},
  cosmos.servers.secretarias.tp.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.tp.methods.pas' {CosmosSecTPServerMethods: TDSServerModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {CosmosServerServices: TDataModule},
  cosmos.server.common.logradouros.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.server.common.logradouros.methods.pas' {DMCosmosServerLogradouros: TDSServerModule},
  cosmos.servers.secretarias.atividades.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.servers.secretarias.atividades.methods.pas' {DMSecAtividadesServerMethods: TDSServerModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

procedure TerminateThreads;
begin
  TDSSessionManager.Instance.Free;
  Data.DBXCommon.TDBXScheduler.Instance.Free;
end;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  TISAPIApplication(Application).OnTerminate := TerminateThreads;
  Application.Run;
end.
