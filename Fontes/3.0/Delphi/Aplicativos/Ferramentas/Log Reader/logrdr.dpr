program logrdr;

uses
  Vcl.Forms,
  cosmos.tools.view.logsreader in 'cosmos.tools.view.logsreader.pas' {FrmLogsReaderMainForm},
  cosmos.tools.view.logsdetailform in 'cosmos.tools.view.logsdetailform.pas' {FrmLogsDetail},
  cosmos.tools.view.logs.interfaces in 'cosmos.tools.view.logs.interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cosmos Leitor de logs';
  Application.CreateForm(TFrmLogsReaderMainForm, FrmLogsReaderMainForm);
  Application.CreateForm(TFrmLogsDetail, FrmLogsDetail);
  Application.Run;
end.
