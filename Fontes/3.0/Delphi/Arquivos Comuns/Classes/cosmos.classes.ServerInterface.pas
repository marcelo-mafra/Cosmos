unit cosmos.classes.ServerInterface;

interface

uses
  Windows, Cosmos.System.Messages;

type
  TTipoControle = (tcByCheckin, tcByConferencia, tcByAtividade);

  TDatabaseOperation = (doInsert, doUpdate, doDelete);

  TCosmosTables = (ctAptidoes, ctCargos, ctEnfermidades, ctFuncoes, ctMeiosContatos,
   ctProfissoes, ctTiposRecebimentos, ctFlagsInscricao, ctFocos, ctPerfis,
   ctDiscipulados, ctTiposEventos, ctRelatoriosExternos);

//Não altere a ordem destes tipos enumerados!
  TFKSearch = (fkRegioes, fkFocoDependente, fkFocos, fkCentros, fkNucleos,
   fkSalasTP, fkLocaisTP, fkMeiosContatos, fkEnderecosFocos, fkLogradouros,
   fkPaises, fkEstados, fkCidades, fkBairros, fkFocosAtivos, fkAlunos,
   fkCargos, fkOrgaosGestores, fkOrgaosSuperiores);

//Não altere a ordem destes tipos enumerados!
  TSequences = (sqCadastrados, sqFocos, sqRegioes, sqPaises, sqEstados,
   sqCidades, sqBairros, sqLogradouros, sqCargos, sqTiposMeiosContatos,
   sqMentorRA, sqOrgaosGestores, sqGestoes, sqDirecoes, sqAreasStaff);

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

  //Informa detalhes a respeito de uma tabela buferizada do Cosmos.
  TCosmosTablesInfo = class
   class function GetCosmosTablesId(const Table: TCosmosTables): string;
   class function GetCosmosTablesFiles(const Table: TCosmosTables): string;
  end;


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

class function TCosmosTablesInfo.GetCosmosTablesFiles(
  const Table: TCosmosTables): string;
begin
{Retorna o nome do arquivo de uma tebela buferizada do Cosmos.}
 case Table of
   ctAptidoes: Result := TCosmosFiles.BufAptidoes; //do not localize!
   ctCargos: Result := TCosmosFiles.BufCargos; //do not localize!
   ctEnfermidades: Result := TCosmosFiles.BufEnfermidades; //do not localize!
   ctFuncoes: Result := TCosmosFiles.BufFuncoes; //do not localize!
   ctProfissoes: Result := TCosmosFiles.BufProfissoes; //do not localize!
   ctFocos: Result := TCosmosFiles.BufFocos; //do not localize!
   ctPerfis: Result := TCosmosFiles.BufPerfis; //do not localize!
   ctDiscipulados: Result := TCosmosFiles.BufDiscipulados; //do not localize!
   ctTiposEventos: Result := TCosmosFiles.BufTiposEventos; //do not localize!
   ctRelatoriosExternos: Result := TCosmosFiles.BufExternalReports; //do not localize!
 end;
end;



class function TCosmosTablesInfo.GetCosmosTablesId(
  const Table: TCosmosTables): string;
begin
{Retorna o identificador de uma tebela buferizada do Cosmos.}
 case Table of
   ctAptidoes: Result := 'APT'; //do not localize!
   ctCargos: Result := 'CAR'; //do not localize!
   ctEnfermidades: Result := 'ENF'; //do not localize!
   ctFuncoes: Result := 'FUN'; //do not localize!
   ctProfissoes: Result := 'PRO'; //do not localize!
   ctFocos: Result := 'FOC'; //do not localize!
   ctPerfis: Result := 'PER'; //do not localize!
   ctDiscipulados: Result := 'DIS'; //do not localize!
   ctTiposEventos: Result := 'EVE'; //do not localize!
   ctRelatoriosExternos: Result := 'REL'; //do not localize!
 end;
end;

end.


