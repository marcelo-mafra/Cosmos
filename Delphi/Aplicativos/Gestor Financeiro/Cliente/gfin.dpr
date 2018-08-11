program gfin;

uses
  Forms,
  cosmos.financeiro.view.mainform in 'cosmos.financeiro.view.mainform.pas' {FrmMainFinanceiro},
  cosmos.financeiro.clienconnections in 'Connection\cosmos.financeiro.clienconnections.pas' {DMCon: TDataModule},
  cosmos.financeiro.view.caixaresult in 'cosmos.financeiro.view.caixaresult.pas' {FrmFechamentoCaixa},
  cosmos.financeiro.view.cancelarrecebimentos in 'cosmos.financeiro.view.cancelarrecebimentos.pas' {FrmCancelarRecebimento};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cosmos Gestor Financeiro';
  Application.CreateForm(TFrmMainFinanceiro, FrmMainFinanceiro);
  Application.CreateForm(TDMCon, DMCon);
  Application.CreateForm(TDMCon, DMCon);
  Application.CreateForm(TFrmFechamentoCaixa, FrmFechamentoCaixa);
  Application.CreateForm(TFrmCancelarRecebimento, FrmCancelarRecebimento);
  Application.Run;
end.
