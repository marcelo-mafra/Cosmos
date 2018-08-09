program gusers;



uses
  Forms,
  cosmos.usuarios.view.mainform in 'cosmos.usuarios.view.mainform.pas' {FrmMainUsuarios},
  cosmos.usuarios.clientconnections in 'Connection\cosmos.usuarios.clientconnections.pas' {DMCon: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor de Usuários';
  Application.CreateForm(TFrmMainUsuarios, FrmMainUsuarios);
  Application.CreateForm(TDMCon, DMCon);
  Application.Run;
end.
