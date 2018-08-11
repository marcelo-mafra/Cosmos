program gsec;



uses
  Forms,
  HTMLHelpViewer,
  cosmos.system.messages in '..\..\..\Arquivos Comuns\System\cosmos.system.messages.pas',
  cosmos.tools.winmanager in '..\..\..\Arquivos Comuns\Tools\Windows Manager\cosmos.tools.winmanager.pas',
  cosmos.secretarias.view.mainform in 'cosmos.secretarias.view.mainform.pas' {FrmMainSecretarias},
  Cosmos.Framework.Interfaces.DataAcess in '..\..\..\Arquivos Comuns\Classes\Framework\Interfaces\Cosmos.Framework.Interfaces.DataAcess.pas',
  Cosmos.Framework.Interfaces.Dialogs in '..\..\..\Arquivos Comuns\Classes\Framework\Interfaces\Cosmos.Framework.Interfaces.Dialogs.pas',
  Cosmos.Framework.Interfaces.Root in '..\..\..\Arquivos Comuns\Classes\Framework\Interfaces\Cosmos.Framework.Interfaces.Root.pas',
  Cosmos.Framework.Interfaces.Utils in '..\..\..\Arquivos Comuns\Classes\Framework\Interfaces\Cosmos.Framework.Interfaces.Utils.pas',
  cosmos.secretarias.services.clientconnections in 'Connection\cosmos.secretarias.services.clientconnections.pas' {DMCon: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Cosmos Gestor de Secretarias';
  Application.ShowMainForm := True;
  Application.CreateForm(TFrmMainSecretarias, FrmMainSecretarias);
  Application.CreateForm(TDMCon, DMCon);
  Application.Run;
end.
