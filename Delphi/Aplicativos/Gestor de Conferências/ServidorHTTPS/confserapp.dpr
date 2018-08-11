program confserapp;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  cosmos.server.conferencias.mainform in 'cosmos.server.conferencias.mainform.pas' {FrmServerMainForm},
  cosmos.server.conferencias.appcontainer in 'cosmos.server.conferencias.appcontainer.pas' {DMConferenciasAppContainer: TDataModule},
  cosmos.server.conferencias.WebModule in 'cosmos.server.conferencias.WebModule.pas' {ConfWebModule: TWebModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.server.common.logradouros.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.server.common.logradouros.methods.pas' {DMCosmosServerLogradouros: TDSServerModule},
  cosmos.servers.secretarias.atividades.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.servers.secretarias.atividades.methods.pas' {DMSecAtividadesServerMethods: TDSServerModule},
  cosmos.servers.conferencias.methods in '..\ServidorDBX\cosmos.servers.conferencias.methods.pas' {DMCosmosConferenciasMethods: TDSServerModule},
  cosmos.servers.common.httpsengine in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.httpsengine.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TDMCosmosServerServices, DMCosmosServerServices);
  Application.CreateForm(TDMServerDataAcess, DMServerDataAcess);
  Application.CreateForm(TFrmServerMainForm, FrmServerMainForm);
  Application.CreateForm(TDMCosmosApplicationServer, DMCosmosApplicationServer);
  Application.ShowMainForm := False;
  Application.Run;
end.
