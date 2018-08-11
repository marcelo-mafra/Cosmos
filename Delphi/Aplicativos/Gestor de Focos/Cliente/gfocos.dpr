program gfocos;



uses
  Forms,
  HTMLHelpViewer,
  cosmos.focos.services.clientconnections in 'Connection\cosmos.focos.services.clientconnections.pas' {DMCon: TDataModule},
  cosmos.focos.view.mainform in 'cosmos.focos.view.mainform.pas' {FrmMainFocos};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gestor de Focos';
  Application.CreateForm(TFrmMainFocos, FrmMainFocos);
  Application.CreateForm(TDMCon, DMCon);
  Application.Run;

end.
