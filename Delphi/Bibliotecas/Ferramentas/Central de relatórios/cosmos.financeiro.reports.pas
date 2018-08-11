unit cosmos.financeiro.reports;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet;

type
  TDMFinReports = class(TDataModule)
    frxDBCadastrado: TfrxDBDataset;
    frxDBRecebimentosCadastrado: TfrxDBDataset;
    frxDBSumarioCaixas: TfrxDBDataset;
    frxDBContribuicoesPendentes: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DMFinReports: TDMFinReports;

implementation

{$R *.dfm}

uses cosmos.financeiro.reports.data;



end.
