unit cosmos.reports.types;

interface

uses
  winapi.windows;

type
  {Mode de abertura de um arquivo de um relatório externo:
   omOpen = abre o arquivo.
   omPrint = impressão do arquivo.}
  TOpenMode = (omOpen, omPrint);

  TPrintMode = (pmPreview, pmPrint);

  {Modo de execução da central de relatórios:
   emExecuteCentral = abertura da central de relatórios normal, para escolha do relatório a imprimir.
   emExecuteReport = Central de Relatórios não é exibida, mas apenas executa um relatório.}
  TExecutionMode = (emExecuteCentral, emExecuteReport);

  TReportType = (rtCategory, rtReport, rtExternalReport, rtNone);

  TReportTool = (rtRave, rtFastReport);

  //Tipo de folha de presença: uma ou duas colunas
  TTipoFolhaPresenca = (tfSimples, tfDupla);

  //Lista de relatórios do módulo secretarias.
  TReportsSecretarias = (rsMarcacaoPresenca = 1, rsEnderecosAlunos, rsFichaAluno, rsCarteirinhaAluno,
    rsRelacaoGeralAlunos, rsEntregaCirculares, rsFolhaPresenca, rsCadastradosDiscipulado,
    rsTotaisAlunos, rsHistoricoAluno, rsBoletimInformativo, rsEscalasAtividade,
    rsFolhaPresencaEI, rsTempoDiscipulado, rsListaProfissoes,  rsListaFuncoes, rsFichaJovemTM,
    rsEnderecosJovensTM, rsListaJovensTM, rsContabilizarFrequencia, rsContabilizarFrequenciaDiscipulado,
    rsCirculosEI, rsAniversariantesMes, rsFolhaPresencaMensal,
    rsEnderecosPesquisadores, rsListaPesquisadores, rsFichaPesquisador,
    rsRelatorioOrigem, rsSumarioEstatistico, rsMalaDiretaPimaco6280,
    rsMalaDiretaPimaco6281, rsOcorrenciasMes,
    rsFolhaPresencaConferencia, rsFolhaPresencaAtividade, rsEnvelope220x115,
    rsEnvelope250x175, rsFrequenciaPeriodo, rsEnderecosMembrosCirculos,
    rsListaTarefasSimples, rsListaTarefasAgrupada, rsFrequenciaPeriodoDiscipulado,
    rsFrequenciaTipoAtividade, rsFrequenciaCirculoEI, rsListaGeralAlunos,
    rsQuadroTotalizacaoRa, rsQuadroTotalizacaoRaTM, rsSumarioEstatisticoRa,
    rsFichasAlunos);

  //Lista de relatórios do módulo conferências.
  TReportsConferencias = (rcCrachas = 101, rcCrachaInscrito, rcListarTarefas,
   rcInscritosConferencia, rcInscritosDesalojados, rcMapaAlojamento, rcInfoInscritos,
   rcListaStaff, rcFolhasQuartos, rcProgramacao, rcAreasTarefasStaff, rcAlojadosQuartos);

  //Lista de relatórios do módulo de usuários.
  TReportsUsuarios = (ruListaPerfis = 201, ruListaUsuarios);

  //Lista de relatórios do módulo financeiro.
  TReportsFinanceiro = (rfSumarioCaixas = 250);




implementation

end.
