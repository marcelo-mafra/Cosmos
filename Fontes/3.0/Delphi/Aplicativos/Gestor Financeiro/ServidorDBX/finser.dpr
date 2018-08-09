program finser;

uses
  Vcl.Forms,
  cosmos.servers.financeiro.appcontainer in 'cosmos.servers.financeiro.appcontainer.pas' {DMFinanceiroAppContainer: TDataModule},
  cosmos.servers.financeiro.finmethods in 'cosmos.servers.financeiro.finmethods.pas' {DMFinanceiroMethods: TDSServerModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule},
  cosmos.servers.financeiro.mainform in 'cosmos.servers.financeiro.mainform.pas' {FrmFinanceiroMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor Financeiro';
  Application.ShowMainForm := False;
  Application.CreateForm(TDMCosmosServerServices, DMCosmosServerServices);
  Application.CreateForm(TDMFinanceiroAppContainer, DMFinanceiroAppContainer);
  Application.CreateForm(TDMServerDataAcess, DMServerDataAcess);
  Application.CreateForm(TFrmFinanceiroMainForm, FrmFinanceiroMainForm);
  Application.CreateForm(TDMCosmosApplicationServer, DMCosmosApplicationServer);
  Application.CreateForm(TDMFinanceiroMethods, DMFinanceiroMethods);
  Application.MainFormOnTaskBar := True;
  Application.ShowMainForm := True;
  Application.Run;
end.

