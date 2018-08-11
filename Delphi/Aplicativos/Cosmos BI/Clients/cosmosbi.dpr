program cosmosbi;

uses
  System.StartUpCopy,
  FMX.Forms,
  cosmos.bi.client.MainForm in 'cosmos.bi.client.MainForm.pas' {FrmMain},
  cosmos.bi.interfaces in '..\Common\cosmos.bi.interfaces.pas',
  cosmos.bi.client.model in 'cosmos.bi.client.model.pas' {DMModel: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMModel, DMModel);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
