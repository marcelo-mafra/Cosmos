program finser;

uses
  Forms {: CoClass},
  Main in 'Main.pas' {FrmMain},
  finser_TLB in 'finser_TLB.pas',
  RDMFinanceiro in 'RDMFinanceiro.pas' {Financeiro: TRemoteDataModule} {Financeiro: CoClass},
  FormAdmLogin in '..\..\..\Arquivos Comuns\FormAdmLogin.pas' {FrmAdmLogin};

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor Financeiro Server';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmAdmLogin, FrmAdmLogin);
  Application.ShowMainForm := False;
  Application.Run;
end.
