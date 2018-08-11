program usersrv;

uses
  Vcl.Forms,
  cosmos.servers.users.appcontainer in 'cosmos.servers.users.appcontainer.pas' {DMUsuariosAppContainer: TDataModule},
  cosmos.servers.users.usersmethods in 'cosmos.servers.users.usersmethods.pas' {DMUserMethods: TDSServerModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.servers.users.mainform in 'cosmos.servers.users.mainform.pas' {FrmUsuariosMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cosmos Gestor de Usuários';
  Application.ShowMainForm := False;
  Application.CreateForm(TDMCosmosServerServices, DMCosmosServerServices);
  Application.CreateForm(TDMUsuariosAppContainer, DMUsuariosAppContainer);
  Application.CreateForm(TDMServerDataAcess, DMServerDataAcess);
  Application.CreateForm(TFrmUsuariosMainForm, FrmUsuariosMainForm);
  Application.CreateForm(TDMCosmosApplicationServer, DMCosmosApplicationServer);
  Application.CreateForm(TDMUserMethods, DMUserMethods);
  Application.Run;
end.

