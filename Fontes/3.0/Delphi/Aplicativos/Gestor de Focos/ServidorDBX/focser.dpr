program focser;

uses
  Forms,
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.servers.focos.appcontainer in 'cosmos.servers.focos.appcontainer.pas' {DMFocosAppContainer: TDataModule},
  cosmos.servers.focos.mainform in 'cosmos.servers.focos.mainform.pas' {FrmFocosMainForm},
  cosmos.servers.focos.methods in 'cosmos.servers.focos.methods.pas' {DMCosmosFocosMethods: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor de Conferências Server';
  Application.CreateForm(TDMCosmosServerServices, DMCosmosServerServices);
  Application.CreateForm(TDMFocosAppContainer, DMFocosAppContainer);
  Application.CreateForm(TDMServerDataAcess, DMServerDataAcess);
  Application.CreateForm(TFrmFocosMainForm, FrmFocosMainForm);
  Application.CreateForm(TDMCosmosApplicationServer, DMCosmosApplicationServer);
  Application.CreateForm(TDMCosmosFocosMethods, DMCosmosFocosMethods);
  Application.MainFormOnTaskBar := True;
  Application.ShowMainForm := True;
  Application.Run;
end.
