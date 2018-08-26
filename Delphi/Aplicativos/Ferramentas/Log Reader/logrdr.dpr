program logrdr;

uses
  Vcl.Forms,
  cosmos.tools.view.logsreader in 'View\cosmos.tools.view.logsreader.pas' {FrmLogsReaderMainForm},
  cosmos.tools.view.logsdetailform in 'View\cosmos.tools.view.logsdetailform.pas' {FrmLogsDetail},
  cosmos.tools.view.logs.interfaces in 'View\cosmos.tools.view.logs.interfaces.pas',
  cosmos.tools.controller.logs in 'Controller\cosmos.tools.controller.logs.pas',
  cosmos.tools.model.logs in 'Model\cosmos.tools.model.logs.pas',
  cosmos.tools.model.logsint in 'Model\cosmos.tools.model.logsint.pas',
  cosmos.tools.controller.logsint in 'Controller\cosmos.tools.controller.logsint.pas',
  cosmos.tools.dao.logsint in 'Dao\cosmos.tools.dao.logsint.pas',
  cosmos.tools.dao.logs in 'Dao\cosmos.tools.dao.logs.pas',
  cosmos.tools.view.messages in 'View\cosmos.tools.view.messages.pas',
  cosmos.tools.controller.lists in 'Controller\cosmos.tools.controller.lists.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cosmos Leitor de logs';
  Application.CreateForm(TFrmLogsReaderMainForm, FrmLogsReaderMainForm);
  Application.CreateForm(TFrmLogsDetail, FrmLogsDetail);
  Application.Run;
end.
