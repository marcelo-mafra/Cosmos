program secser;

uses
  Vcl.Forms,
  cosmos.servers.secretarias.mainform in 'cosmos.servers.secretarias.mainform.pas' {FrmSecretariasMainForm},
  cosmos.server.secretarias.appcontainer in 'cosmos.server.secretarias.appcontainer.pas' {DMSecretariasAppContainer: TDataModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.secretarias.lectorium.methods in 'Server Modules\cosmos.servers.secretarias.lectorium.methods.pas' {DMSecLectoriumServerMethods: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.server.common.logradouros.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.server.common.logradouros.methods.pas' {DMCosmosServerLogradouros: TDSServerModule},
  cosmos.servers.secretarias.atividades.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.servers.secretarias.atividades.methods.pas' {DMSecAtividadesServerMethods: TDSServerModule},
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.servers.secretarias.historico.methods in 'Server Modules\cosmos.servers.secretarias.historico.methods.pas' {CosmosSecHistoricoServerMethods: TDSServerModule},
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.secretarias.ei.methods in 'Server Modules\cosmos.servers.secretarias.ei.methods.pas' {CosmosSecEIServerMethods: TDSServerModule},
  cosmos.servers.secretarias.pageproducer in 'cosmos.servers.secretarias.pageproducer.pas' {DMSecPageProducer: TDataModule},
  cosmos.servers.secretarias.tp.methods in 'Server Modules\cosmos.servers.secretarias.tp.methods.pas' {CosmosSecTPServerMethods: TDSServerModule},
  cosmos.servers.secretarias.focos.methods in 'Server Modules\cosmos.servers.secretarias.focos.methods.pas' {DMCosmosFocosMethods: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cosmos Gestor de Secretarias';
  Application.CreateForm(TDMCosmosServerServices, DMCosmosServerServices);
  Application.CreateForm(TDMSecretariasAppContainer, DMSecretariasAppContainer);
  Application.CreateForm(TDMServerDataAcess, DMServerDataAcess);
  Application.CreateForm(TFrmSecretariasMainForm, FrmSecretariasMainForm);
  Application.CreateForm(TDMCosmosApplicationServer, DMCosmosApplicationServer);
  Application.CreateForm(TDMSecPageProducer, DMSecPageProducer);
  Application.Run;
end.

