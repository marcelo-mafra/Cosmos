program cmstarter;

uses
  System.Classes,
  Vcl.Forms,
  cosmos.server.tools.dmstarter in 'cosmos.server.tools.dmstarter.pas' {DMStarter: TDataModule},
  cosmos.server.tools.mainstarter in 'cosmos.server.tools.mainstarter.pas' {FrmMainStarter};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TDMStarter, DMStarter);
  Application.CreateForm(TFrmMainStarter, FrmMainStarter);
  Application.ShowMainForm := False;
  Application.Run;
end.
