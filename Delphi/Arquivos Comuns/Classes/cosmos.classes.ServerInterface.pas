unit cosmos.classes.ServerInterface;

interface

uses
  Windows, cosmos.system.files, Cosmos.System.Messages, cosmos.data.dbobjects.sequences;

type
  TTipoControle = (tcByCheckin, tcByConferencia, tcByAtividade);

  TDatabaseOperation = (doInsert, doUpdate, doDelete);



//Não altere a ordem destes tipos enumerados!
  TFKSearch = (fkRegioes, fkFocoDependente, fkFocos, fkCentros, fkNucleos,
   fkSalasTP, fkLocaisTP, fkMeiosContatos, fkEnderecosFocos, fkLogradouros,
   fkPaises, fkEstados, fkCidades, fkBairros, fkFocosAtivos, fkAlunos,
   fkCargos, fkOrgaosGestores, fkOrgaosSuperiores);

//Representa uma pesquisa disponível (comando DQL) para os aplicativos Cosmos.
  TCosmosSearch = (csRegioes, csSubRegioes, csFocosRa, csFocosTitulares, csFocosDependentes,
   csFocos, csCentros, csNucleos,
   csSalasTP, csLocaisTP, csMeiosContatos, csEnderecosFocos, csLogradouros,
   csPaises, csEstados, csCidades, csBairros, csFocosAtivos, csAlunos,
   csCargos, csOrgaosGestores, csOrgaosSuperiores, csMentoresEI, csMentoresEIFoco,
   csMentorasEI, csMentorasEIFoco, csDirigentesEI, csJovensAlunos, csJovensAlunosFoco,
   csDiscipuladosEI, csDiscipuladosEE, csLicoesEI, csLivrosDiscipuladoEI, csLicoesLivroEI,
   csProfissoes, csTiposEventosTP, csDiscipulados, csDiscipuladosLectorium,
   csAlunoTitular, csEnfermidades, csAlunosHomens, csAlunosMulheres,
   csAreasAptidoes, csTiposAtividades, csAlocucoes, csTipoAtuacao, csCadastrados,
   csTiposAtividadesTM, csTiposAtividadesTMB, csTiposAtividadesTP,
   csTiposAtividadesEI, csCirculoEI, csTurmasTP, csDiscipuladosTM,
   csDiscipuladosTMB, csFocosConferencias, csConferencias,
   csGruposUsuarios, csFuncoes, csCartasTP, csConferenciasLEC, csConferenciasTMO,
   csConferenciasTMB, csConferenciasTPU, csConferenciasEI, csPlanoContas,
   csFocosAlunos, csFocosPesquisadores, csEventosDiscipulares, csListaCadastrados,
   csCarteirinhaCadastrado, csExternalReportsCategories, csCountAtividadeTipo,
   csGeneralSelect, csConferenciasFocoAno, csAlocucoesDataCadastro,
   csALocucoesDataLeitura, csAlocucoesIneditas, csAlocucoesAssunto, csAlocucoesAutor,
   csAlocucoesCamposTrabalho, csFuncoesCadastrado, csFamiliaresCadastrado, csFichaUsuario, csDadosCadastrado,
   csCadastradoMatricula, csCadastradoMatriculaFoco, csCadastradoNome, csCadastradoNomeFoco,
   csCadastradoApelido, csCadastradoApelidoFoco, csDiscEventoHistorico,
   csCadastradoDiscipulado, csListaCadastradosDiscipuladoFoco, csListaCadastradosNomeFoco,
   csSincStatus, csClassificadores, csClassificadoresLeitos, csClassificadoresCadastrados,
   csAlojamentosFoco, csQuartosAlojamento, csLeitosQuarto, csListaLeitosQuarto, csListaInscritosAlfabetica,
   csLeitosLivresAlojamento, csListaInscritosDiscipulado, csListaInscritosFocos, csInscritosConferencia, csLeitosAlojamento,
   csAreasStaff, csSubAreasStaff, csCadastradoIndex, csGeneralFlagsInscricoes, csFlagsInscricoes,
   csReportListaCadastrados, csReportFichaAluno, csReportFichaAlunoEndereco,
   csReportFichaAlunoMeioContato, csReportFichaAlunoHistorico, csReportFichaAlunoFuncoes,
   csReportCarteirinhaAluno, csReportCarteirinhaFamiliares, csReportCarteirinhaMeiosContato,
   csReportCarteirinhaEndereco, csReportRelacaoGeralAlunos, csReportEntregaCirculares, csReportFolhaPresenca,
   csReportCadastradosDiscipulado, csReportContarAlunosEE, csReportContarAlunosEI,
   csReportTotalAlunos, csReportCadastradoCodigo, csReportHistoricoCadastrado,
   csReportAtividadesCampo, csReportEscalasAtividades, csReportMembrosCirculo,
   csReportCirculosEI, csReportMembrosCirculos, csReportTempoDiscipulado,
   csReportListaProfissoes, csReportCadastradosProfissoes, csReportListaFuncoes,
   csReportCadastradosFuncoes, csReportFamiliares, csCadastrado, csCadastradoCampo,
   csCadastradoSexo, csCadastradoCampoSexo, csCadastradoFoco, csCadastradoCampoFoco,
   csCadastradoSexoFoco, csCadastradoCampoSexoFoco, csCadastradosFocoCampo,
   csReportListaCadastradosNascimento, csReportFrequenciaAno,
   csReportFrequenciaAnoDiscipulado, csReportFrequenciaPeriodo,
   csReportFrequenciaPeriodoDiscipulado, csReportFrequenciaAtividade, csReportFrequenciaAtividadesEI,
   csReportAniversariantesMes, csFolhaPresencaMensal, csReportSumarizaAtividades, csResumoEstatistico, csResumoEstatisticoRa,
   csResumoEstatisticoParent,
   csMalaDireta, csReportOcorrenciasMes, csReportListaPresencaAtividade,
   csCirculosEIFocoDiscipulado, csListaMembrosCirculo, csEnderecosMembrosCirculo,
   csMeiosContatoMembrosCirculos,
   csInscritoNome, csTarefasAreaStaff, csAreasTarefasStaff, csStaffConferencia,
   csReportInscritosConferencia, csReportInscritoConferencia, csReportInscritosAlojados, csReportInscritosDesalojados,
   csReportCrachaInscrito, csReportCrachasInscritos, csReportAlojamentos, csReportLeitosAlojamentos, csExportCadastrados,
   csExportCadastradosEnderecos, csExportCadastradosTelefones, csExportCadastradosEmails,
   csExportCadastradosEnderecosTelefonesEmails, csExportCadastradosEnderecosTelefones,
   csExportCadastradosEnderecosEmails, csExportCadastradosTelefonesEmails,
   csListaInscritosConferenciaImportacao, csImportarInscritoConferencia,
   csImportarInscritosConferencia, csUsuarioCadastrador, csAtividadesDatasCampo,
   csAtividadesDatasCampoFoco, csReportInformacoesInscritosByFlag, csMyMessages,
   csReportListaGeralAlunos, csReportQuadroTotalizacaoRa, csReportQuadroTotalizacaoRaTM,
   csAlojadosQuartos, csQuartosUsadosAlojamento, csCosmosUsers,
   csEnderecosFocoCampo, csMeiosContatoFocoCampo, csCadastradoCode,
   csTurmasInstalacao, csMembrosTurmaInstalacao, csListaSimpatizantes,
   csTurmaInstalacaoInfo, csDiscipuladosTP, csTiposAtividadesSimpatizantes,
   csConferenciasSIM, csDiscipuladosSIM, csCaixasMesAno, csDiscipuladosCampo,
   csInstituicoesBancarias, csReportFichasAlunos, csReportFichasAlunosEndereco,
   csReportFichasAlunosMeioContato, csReportFichasAlunosHistorico, csReportFichasALunosFuncoes,
   csSituacaoAtividades, csFocosRas, csListOrgaos, csListSubOrgaos, csOrgaosByName,
   csFocosInscritos, csIncritosConferenciaFocos, csAtividadesDatasFoco,
   csProgramacaoConferencia, csFolhasQuartos, csListaInscritos, csTiposRecebimentos,
   csAlojarInscritos, csReportCrachaTarefasInscrito);

  TCosmosSearchSet = set of TCosmosSearch;

  //Representa um comando DML executado pelos aplicativos Cosmos.
  TCosmosCommand = (ccDeleteUsuario, ccDeleteFocoUsuario, ccInstalarAluno,
   ccNovaConferencia, ccAtividadeConferencia, ccDelAtividadeConferencia);

  TSQLServerInterface =
   class function GetFKSearchID(const FKSearch: TFKSearch): integer;
   class function GetSequenceID(const Sequence: TSequences): integer;
   class function GetFKSearch(const ID: integer): TFKSearch;
   class function GetCosmosSearch(const ID: integer): TCosmosSearch;
   class function GetCosmosCommand(const ID: integer): TCosmosCommand;

 end;

implementation


{ TSQLServerInterface }

class function TSQLServerInterface.GetCosmosCommand(
  const ID: integer): TCosmosCommand;
begin
 Result := TCosmosCommand(ID);
end;

class function TSQLServerInterface.GetCosmosSearch(
  const ID: integer): TCosmosSearch;
begin
 Result := TCosmosSearch(ID);
end;

class function TSQLServerInterface.GetFKSearch(const ID: integer): TFKSearch;
begin
 Result := TFKSearch(ID);
end;

function TSQLServerInterface.GetFKSearchID(const FKSearch: TFKSearch): integer;
begin
 Result := Ord(FKSearch);
end;

class function TSQLServerInterface.GetSequenceID(const Sequence: TSequences): integer;
begin
 Result := Ord(Sequence);
end;

{ TCosmosTablesInfo }






end.


