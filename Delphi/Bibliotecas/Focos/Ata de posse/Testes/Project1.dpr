program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FormAtaPosse in '..\FormAtaPosse.pas' {FrmAtaPosse},
  FormCosmosHelpDialog in '..\..\..\Arquivos Comuns\Dialogs\FormCosmosHelpDialog.pas' {FrmCosmosHelpDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmAtaPosse, FrmAtaPosse);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmCosmosHelpDialog, FrmCosmosHelpDialog);
  Application.Run;
end.
