program userserapp;
{$APPTYPE GUI}
uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  cosmos.server.users.mainform in 'cosmos.server.users.mainform.pas' {FrmServerMainForm},
  cosmos.server.users.WebModule in 'cosmos.server.users.WebModule.pas' {UsersWebModule: TWebModule},
  cosmos.servers.users.usersmethods in '..\ServerModules\cosmos.servers.users.usersmethods.pas' {DMUserMethods: TDSServerModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.server.users.appcontainer in 'cosmos.server.users.appcontainer.pas' {DMUsuariosAppContainer: TDataModule},
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
