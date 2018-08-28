program secserapp;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  cosmos.server.secretarias.mainform in 'cosmos.server.secretarias.mainform.pas' {FrmServerMainForm},
  cosmos.server.secretarias.appcontainer in 'cosmos.server.secretarias.appcontainer.pas' {DMSecretariasAppContainer: TDataModule},
  cosmos.server.secretarias.WebModule in 'cosmos.server.secretarias.WebModule.pas' {SecWebModule: TWebModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {CosmosServerServices: TDataModule},
  cosmos.server.common.logradouros.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.server.common.logradouros.methods.pas' {DMCosmosServerLogradouros: TDSServerModule},
  cosmos.servers.secretarias.atividades.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.servers.secretarias.atividades.methods.pas' {DMSecAtividadesServerMethods: TDSServerModule},
  cosmos.servers.secretarias.ei.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.ei.methods.pas' {CosmosSecEIServerMethods: TDSServerModule},
  cosmos.servers.secretarias.focos.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.focos.methods.pas' {DMCosmosFocosMethods: TDSServerModule},
  cosmos.servers.secretarias.historico.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.historico.methods.pas' {CosmosSecHistoricoServerMethods: TDSServerModule},
  cosmos.servers.secretarias.lectorium.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.lectorium.methods.pas' {DMSecLectoriumServerMethods: TDSServerModule},
  cosmos.servers.secretarias.tp.methods in '..\ServidorDBX\Server Modules\cosmos.servers.secretarias.tp.methods.pas' {CosmosSecTPServerMethods: TDSServerModule},
  cosmos.servers.common.httpsengine in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.httpsengine.pas',
  cosmos.system.types,
  cosmos.servers.common.dao.factory in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dao.factory.pas',
  cosmos.servers.common.dao.interfaces in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dao.interfaces.pas',
  cosmos.servers.common.services.factory in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.factory.pas',
  cosmos.servers.common.servicesint in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.servicesint.pas',
  cosmos.servers.common.dsservices in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dsservices.pas',
  cosmos.system.servers;

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFrmServerMainForm, FrmServerMainForm);

  TDMCosmosApplicationServer.CreateObject(cmSecretariasServer, stApplication);
  TDMCosmosServerLogradouros.CreateObject(cmSecretariasServer, stApplication);
  TDMSecAtividadesServerMethods.CreateObject(cmSecretariasServer, stApplication);

  Application.ShowMainForm := False;
  Application.Run;

end.
