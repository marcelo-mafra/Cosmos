program finserapp;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  cosmos.server.financeiro.mainform in 'cosmos.server.financeiro.mainform.pas' {FrmServerMainForm},
  cosmos.server.financeiro.appcontainer in 'cosmos.server.financeiro.appcontainer.pas' {DMFinanceiroAppContainer: TDataModule},
  cosmos.server.financeiro.WebModule in 'cosmos.server.financeiro.WebModule.pas' {FinWebModule: TWebModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.servers.financeiro.finmethods in '..\ServerModules\cosmos.servers.financeiro.finmethods.pas' {DMFinanceiroMethods: TDSServerModule},
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
