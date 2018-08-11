program focser;

uses
  Forms,
  focser_TLB in 'focser_TLB.pas',
  RDMFocosManager in 'RDMFocosManager.pas' {FocosManager: TRemoteDataModule} {FocosManager: CoClass},
  fbservices_TLB in '..\..\..\Arquivos Comuns\fbservices_TLB.pas',
  main in 'main.pas' {FrmMain},
  SQLConsts in '..\..\..\Arquivos Comuns\SQLConsts.pas',
  FormAdmLogin in '..\..\..\Arquivos Comuns\FormAdmLogin.pas' {FrmAdmLogin},
  cosmos.core.ConstantesMsg in '..\..\..\Arquivos Comuns\cosmos.core.ConstantesMsg.pas',
  cosmos.core.cripter in '..\..\..\Arquivos Comuns\cosmos.core.cripter.pas',
  cosmos.core.cripterint in '..\..\..\Arquivos Comuns\cosmos.core.cripterint.pas';

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor de Focos';
  Application.ShowMainForm := False;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
