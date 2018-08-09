program gconf;

uses
  Forms,
  cosmos.conferencias.clientconnections in 'Connection\cosmos.conferencias.clientconnections.pas' {DMCon: TDataModule},
  cosmos.conferencias.view.MainForm in 'cosmos.conferencias.view.MainForm.pas' {FrmMainConferencias};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor de Conferências';
  Application.CreateForm(TFrmMainConferencias, FrmMainConferencias);
  Application.CreateForm(TDMCon, DMCon);
  Application.Run;
end.
