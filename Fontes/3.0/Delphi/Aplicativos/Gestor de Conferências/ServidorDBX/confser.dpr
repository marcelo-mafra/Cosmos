program confser;

uses
  Forms,
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.servers.conferencias.appcontainer in 'cosmos.servers.conferencias.appcontainer.pas' {DMConferenciasAppContainer: TDataModule},
  cosmos.servers.conferencias.mainform in 'cosmos.servers.conferencias.mainform.pas' {FrmConferenciasMainForm},
  cosmos.servers.conferencias.methods in 'cosmos.servers.conferencias.methods.pas' {DMCosmosConferenciasMethods: TDSServerModule},
  cosmos.servers.secretarias.atividades.methods in '..\..\Arquivos Comuns\DBXServers\ServersModules\cosmos.servers.secretarias.atividades.methods.pas' {DMSecAtividadesServerMethods: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor de Conferências Server';
  Application.CreateForm(TDMCosmosServerServices, DMCosmosServerServices);
  Application.CreateForm(TDMConferenciasAppContainer, DMConferenciasAppContainer);
  Application.CreateForm(TDMServerDataAcess, DMServerDataAcess);
  Application.CreateForm(TFrmConferenciasMainForm, FrmConferenciasMainForm);
  Application.CreateForm(TDMCosmosApplicationServer, DMCosmosApplicationServer);
  Application.CreateForm(TDMCosmosConferenciasMethods, DMCosmosConferenciasMethods);
  Application.CreateForm(TDMSecAtividadesServerMethods, DMSecAtividadesServerMethods);
  Application.MainFormOnTaskBar := True;
  Application.ShowMainForm := True;
  Application.Run;
end.
