program cmupdater;

uses
  Vcl.Forms, Dialogs,
  cosmos.tools.updater.dm in 'cosmos.tools.updater.dm.pas' {DMUpdater: TDataModule},
  cosmos.tools.updater.main in 'cosmos.tools.updater.main.pas' {FrmUpdateStatus};

{$R *.res}

const
 sCannotRun = 'Esta aplicação não pode ser executada neste modo. O processo será encerrado.';

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cosmos updater';

  {Somente executa a aplicação caso ela seja executada com parâmetros de inicialização.
  Caso contrário, emite mensagem de aviso e encerra a aplicação.}
  if ParamStr(1) = '' then
   begin
     ShowMessage(sCannotRun);
     Application.Terminate;
   end
  else
   begin
    Application.CreateForm(TFrmUpdateStatus, FrmUpdateStatus);
    Application.CreateForm(TDMUpdater, DMUpdater);
    // Application.ShowMainForm := False;
    Application.Run;
   end;
end.
