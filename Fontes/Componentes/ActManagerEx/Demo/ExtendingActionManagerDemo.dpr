program ExtendingActionManagerDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain},
  AboutForm in 'AboutForm.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
