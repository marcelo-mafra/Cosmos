unit cosmos.secretarias.reports;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet;

type
  TDMSecReports = class(TDataModule)
    FrFolhaPresenca: TfrxDBDataset;
    frxCarteirinhas: TfrxDBDataset;
    frxFichaCadastral: TfrxDBDataset;
    FrFolhaPresencaMensal: TfrxDBDataset;
    frxEnderecoAluno: TfrxDBDataset;
    frxMeiosContatosAluno: TfrxDBDataset;
    frxHistoricoDiscipular: TfrxDBDataset;
    frxFuncoes: TfrxDBDataset;
    frxFamiliares: TfrxDBDataset;
    frxDBListaAlunos: TfrxDBDataset;
    frxDBEnderecosAlunos: TfrxDBDataset;
    frxDBContarCadastrados: TfrxDBDataset;
    frxDBAtividades: TfrxDBDataset;
    frxDBTempoDiscipulado: TfrxDBDataset;
    frxDBRegioesAdmin: TfrxDBDataset;
    frxDBResumoEstatisticoRas: TfrxDBDataset;
    frxDBQuadroTotalizacaoRaTM: TfrxDBDataset;
    frxDBResumoEstatisticoLEC: TfrxDBDataset;
    frxDBDatasInstalacoes: TfrxDBDataset;
    frxDBAlunosHistorico: TfrxDBDataset;
    frxDBHistoricoDiscipular: TfrxDBDataset;
    frxDBAtividadesCampo: TfrxDBDataset;
    frxDBSumarizaAtividades: TfrxDBDataset;
    frxDBMembrosCirculo: TfrxDBDataset;
    frxDBCirculos: TfrxDBDataset;
    frxDBContabilizarFrequencia: TfrxDBDataset;
    frxDBContabilizarFrequenciaDisc: TfrxDBDataset;
    frxDBMalaDireta: TfrxDBDataset;
    frxDBCadastradosDisc: TfrxDBDataset;
    frxDBListaFuncoes: TfrxDBDataset;
    frxDBCadastradosFuncoes: TfrxDBDataset;
    frxDBCadastradosProfissoes: TfrxDBDataset;
    frxDBListaProfissoes: TfrxDBDataset;
    frxDBJovensTM: TfrxDBDataset;
    frxDBAniversariantes: TfrxDBDataset;
    frxDBConferencia: TfrxDBDataset;
    frxDBConferenciaAtividades: TfrxDBDataset;
    frxDBContarAlunosEE: TfrxDBDataset;
    frxDBContarAlunosEI: TfrxDBDataset;
    frxDBTotalAlunos: TfrxDBDataset;
    frxDBTarefas: TfrxDBDataset;
    frxDBEscalasAtividades: TfrxDBDataset;
    frxDBListaGeralAlunos: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DMSecReports: TDMSecReports;


implementation

{$R *.dfm}

uses cosmos.secretarias.reports.data;



end.
