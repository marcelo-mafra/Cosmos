unit cosmos.classes.servers.cmdFactories;

interface

uses
 cosmos.classes.ServerInterface, cosmos.servers.sqlcommands, cosmos.system.messages,
 cosmos.system.exceptions, cosmos.core.classes.searchsinfo, System.SysUtils,
 cosmos.classes.servers.utils, System.Variants, cosmos.classes.arrayutils,
 cosmos.data.dbobjects.tables;

type
 //Classe utilitária para obter nomes de objetos do banco e comandos.
 TCosmosDataObjects = class

  class function GetRegisteredCommand(const CommandId: integer): string;
 end;

 //Classe utilitária para obter comandos SQL etc.
 TSQLCommandsFactory = class
  class function GetSQLCommand(Search: TCosmosSearch): string;
  class function GetDMLCommand(Command: TCosmosCommand): string;
  class procedure CreateCommandText(var ACommand: string; Params: Olevariant);
  class function GetTableCommand(Table: TCosmosTables): string;

 end;

implementation

{ TCosmosDataObjects }

class function TCosmosDataObjects.GetRegisteredCommand(
  const CommandId: integer): string;
var
 I: integer;
 ISearchs: IXMLSearchsType;
 ISearch: IXMLSearchType;
 AFileName: string;
begin
{Recupera o comando SQL de uma pesquisa. Estes comandos ficam armazenados
 em um arquivo XM (ServerCommands.xml) que somente está disponível no lado
 servidor.}
  AFileName := TCosmosInfoFiles.GetServerCommandsFile;

  try
   if FileExists(AFileName) then
    begin
     ISearchs := LoadSearchs(AFileName);
     if ISearchs <> nil then
      begin
       for I := 0 to Pred(ISearchs.Count) do
        begin
         ISearch := ISearchs.Search[I];
         if ISearch <> nil then
           begin
            if ISearch.SearchInfo.Info.SearchId = CommandId then
             begin
              Result := ISearch.SearchInfo.Info.Command;
              Break;
             end;
           end;
        end;
      end;
    end
   else
    raise ECannotFindFile.Create(TCosmosErrorMsg.CannotOpenFileCentralPesquisaServer);

   if Result = '' then
    raise ECannotFindCommand.Create(TCosmosErrorMsg.CannotFindCentralPesquisaCmd);

   if Assigned(ISearch) then
    ISearch := nil;

   if Assigned(ISearchs) then
    ISearchs := nil;


 except
  on E: Exception do
   begin
    if Assigned(ISearch) then
     ISearch := nil;

    if Assigned(ISearchs) then
     ISearchs := nil;

    raise;
   end;
 end;
end;

{ TSQLCommandsFactory }

class procedure TSQLCommandsFactory.CreateCommandText(var ACommand: string;
  Params: Olevariant);
var
Argumments: TConstArray;
begin
//Preenche os parâmetros de um comando SQL recebido.
  if ACommand = '' then
   raise EUnknownCommandError.Create(TCosmosErrorMsg.UnknownCosmosSearch);

  {Caso o número de parâmetros chegue até 3, cria um array de constantes
   a partir do variant recebido. No código que cria o array de constantes,
   a função "Format" só funciona corretamente quando existem até 3 parâmetros.}
  if VarIsArray(Params) and (VarArrayHighBound(Params, 1) <= 3) then
   begin
    Argumments := TArrayUtils.CreateConstArray(Params);
    ACommand := Format(ACommand, Argumments);
   end
  else
  if VarIsArray(Params) and (VarArrayHighBound(Params, 1) > 3) then
   ACommand := TArrayUtils.VarFormat(ACommand, Params);

if ACommand = '' then
 Abort;
end;

class function TSQLCommandsFactory.GetDMLCommand(Command: TCosmosCommand): string;
begin
 case Command of
  ccDeleteUsuario: Result := TSecurityCommand.DeleteUser;
  ccDeleteFocoUsuario: Result := TSecurityCommand.DeleteFocusUser;
  ccInstalarAluno: Result := TSecHistoricoCmd.InstalarAluno;
  ccNovaConferencia: Result := TGConfCommands.InsertConferencia;
  ccAtividadeConferencia: Result := TGConfCommands.UpdAtividadesConferencia;
  ccDelAtividadeConferencia: Result := TGConfCommands.UpdAtividadesConferenciaDel;
  else
  Result := '';
 end
end;

class function TSQLCommandsFactory.GetSQLCommand(Search: TCosmosSearch): string;
begin
//Retorna o comando SQL de uma pesquisa passada em parâmetro
  case Search of
   csGeneralSelect: Result := TDQLCommands.GeneralSelect;
   csAreasAptidoes: Result := TDQLCommands.AreasAptidoes;
   csCargos: Result := TDQLCommands.Cargos;
   csCartasTP: Result := Format(TSecretariasTPCommands.CartasTP, [QuotedStr('TPU'), QuotedStr('DOC'), QuotedStr('N')]);
   csDiscipuladosEE: Result := Format(TDQLCommands.Discipulados, [QuotedStr('N'), QuotedStr('LEC'), QuotedStr('S')]);
   csDiscipuladosEI: Result := Format(TDQLCommands.Discipulados, [QuotedStr('S'), QuotedStr('LEC'), QuotedStr('S')]);
   csDiscipuladosLectorium: Result := Format(TDQLCommands.DiscipuladosCamposSequencia, [QuotedStr('LEC')]);
   csDiscipuladosTM: Result := Format(TDQLCommands.Discipulados, [QuotedStr('N'), QuotedStr('TMO'), QuotedStr('S')]);
   csDiscipuladosTMB: Result := Format(TDQLCommands.Discipulados, [QuotedStr('N'), QuotedStr('TMB'), QuotedStr('S')]);
   csDiscipuladosTP: Result := Format(TDQLCommands.Discipulados, [QuotedStr('N'), QuotedStr('TPU'), QuotedStr('S')]);
   csDiscipuladosSIM: Result := Format(TDQLCommands.Discipulados, [QuotedStr('N'), QuotedStr('SIM'), QuotedStr('S')]);
   csDiscipuladosCampo: Result := TDQLCommands.DiscipuladosCampos;
   csEnfermidades: Result := TDQLCommands.Enfermidades;

   //Usuários e permissões
   csCosmosUsers: Result := TGUsersCommands.Cosmosusers;

   //Focos e Regiões Admnistrativas.
   csRegioes: Result := TFocosCommands.Regioes;
   csSubRegioes: Result := TFocosCommands.RegioesPai;
   csFocosRa: Result := TFocosCommands.FocosRa2;
   csFocos: Result := Format(TFocosCommands.FocoAtivos, [QuotedStr('S')]);
   csFocosTitulares: Result := TFocosCommands.FocosTitulares;
   csFocosDependentes: Result := TFocosCommands.FocosDependentes;
   csFocosPesquisadores: Result := Format(TFocosCommands.FocosTipos, [QuotedStr('S'), 'indtpu', QuotedStr('S')]);
   csFocosAlunos: Result := Format(TFocosCommands.FocosTipos, [QuotedStr('S'), 'indlec',  QuotedStr('S')]);
   csFocosConferencias: Result := TGConfCommands.FocosConferencia;
   csConferenciasFocoAno: Result := TGConfCommands.ConferenciasFocoAno;

   //Escola Interna
   csLicoesEI: Result := TSecretariasEICommands.LicoesEI;
   csLicoesLivroEI: Result := TSecretariasEICommands.LicoesLivroEI;
   csLivrosDiscipuladoEI: Result := TSecretariasEICommands.LivrosEI;
   csDirigentesEI: Result := '' ;
   csMentoresEI, csMentorasEI: Result := sSQLCadastradoFocoCampoSexo + ' and indmen = ' + QuotedStr('S');
   csMentoresEIFoco, csMentorasEIFoco: Result := '';
   csCirculosEIFocoDiscipulado: Result := sSQLSearchCirculosEIFocoDiscipulado;

   //Tabelas Acessórias.
   csMeiosContatos: Result := TDQLCommands.TiposContatos;
   csProfissoes: Result := TDQLCommands.Profissoes;
   csFuncoes: Result := TDQLCommands.Funcoes;
   csTipoAtuacao: Result := TDQLCommands.TiposAtuacao;
   csTiposEventosTP: Result := Format(TDQLCommands.TiposEventos, [QuotedStr('TPU')]);


   csCarteirinhaCadastrado: Result := sSQLCarteirinhasCadastrados;
   csCountAtividadeTipo: Result := TSecAtividadesCommands.TiposAtividadesCount;
   csExternalReportsCategories: Result := TReportsCommand.ExternalReports;

   //Logradouros.
   csBairros: Result := TLogradourosCommands.Bairros;
   csCidades: Result := TLogradourosCommands.Cidades;
   csEstados: Result := TLogradourosCommands.Estados;
   csPaises: Result := TLogradourosCommands.Paises;

   //Alocuções
   csAlocucoes: Result := TAlocucoesCommands.Alocucoes;
   csAlocucoesDataCadastro: Result := TAlocucoesCommands.AlocucoesDataCadastro;
   csAlocucoesDataLeitura: Result := TAlocucoesCommands.AlocucoesDataLeitura;
   csAlocucoesIneditas: Result := TAlocucoesCommands.AlocucoesIneditas;
   csAlocucoesAssunto: Result := TAlocucoesCommands.AlocucoesAssunto;
   csAlocucoesAutor: Result := TAlocucoesCommands.AlocucoesAutor;
   csAlocucoesCamposTrabalho: Result := TAlocucoesCommands.AlocucoesCamposTrabalho;

   //Cadastrado
   csCadastrado: Result := sSQLCadastrado;
   csCadastradoCode: Result := sSQLCadastradoCodigo;
   csCadastradoCampo: Result := sSQLCadastradoCampo;
   csCadastradoSexo: Result := sSQLCadastradoSexo;
   csCadastradoCampoSexo: Result := sSQLCadastradoCampoSexo;
   csCadastradoFoco: Result := sSQLCadastradoFoco;
   csCadastradoCampoFoco: Result := sSQLCadastradoFocoCampo;
   csCadastradoSexoFoco: Result := sSQLCadastradoFocoSexo;
   csCadastradoCampoSexoFoco: Result := sSQLCadastradoFocoCampoSexo;
   csCadastradosFocoCampo: Result := sSQLCadastradosFocoCampo;
   csFuncoesCadastrado: Result := sSQLListaListaFuncoesCadastrado;
   csFichaUsuario: Result := sSQLFichaUsuario;
   csDadosCadastrado: Result := TDQLCommands.DadosCadastrado;
   csCadastradoIndex: Result := sSQLCadastradoIndex;
   csCadastradoMatricula: Result := sSQLCadastradosMatricula;
   csCadastradoMatriculaFoco: Result := TDQLCommands.CadastradosMatriculaFoco;
   csCadastradoNome: Result := sSQLCadastradosNome;
   csCadastradoNomeFoco: Result := TDQLCommands.CadastradosNomeFoco;
   csCadastradoApelido: Result := sSQLCadastradosApelido;
   csCadastradoApelidoFoco: Result := TDQLCommands.CadastradosApelidoFoco;
   csJovensAlunos: Result := Format(sSQLJovensAlunos, [QuotedStr('LEC'), QuotedStr('S')]);
   csJovensAlunosFoco: Result := sSQLJovensAlunosFoco;
   csDiscEventoHistorico: Result := sSQLDiscEventoHistorico;
   csCadastradoDiscipulado: Result := sSQLCadastradosDiscipulado;
   csListaCadastradosDiscipuladoFoco: Result := sSQLListaCadastradosDiscipuladoFoco;
   csListaCadastradosNomeFoco: Result := sSQLListaCadastradosNomeFoco;
   csEventosDiscipulares: Result := sSQLTiposEventos;

   //Alunado
   csReportListaGeralAlunos: Result :=  sSQLListaGeralAlunos;

   //Sicnronização
   csSincStatus: Result := sSQLSincStatus;

//Pesquisas de relatórios...

   //Lista de cadastrados por núcleo e campo de trabalho.
   csReportListaCadastrados: Result := TReportsCommand.ListaCadastrados;

   //Endereços e meios de contato por núcleo e campo de trabalho.
   csEnderecosFocoCampo: Result := sSQLcsEnderecoFocoCampo;
   csMeiosContatoFocoCampo: Result := sSQLcsMeiosContatoFocoCampo;

   //Ficha do aluno
   csReportFichaAluno: Result := TReportsCommand.FichaAluno;
   csReportFichaAlunoEndereco: Result := sSQLEnderecoCadastradoCorrespondencia;
   csReportFichaAlunoMeioContato: Result := sSQLMeiosContatoCadastrado;
   csReportFichaAlunoHistorico: Result := sSQLHistoricoCadastrado;
   csReportFichaALunoFuncoes: Result := sSQLFuncoesCadastrado;

   //Fichas dos alunos
   csReportFichasAlunos: Result := TReportsSecCommands.FichasAlunos;
   csReportFichasAlunosEndereco: Result := TReportsSecCommands.EnderecosCadastradosCorrespondencia;
   csReportFichasAlunosMeioContato: Result := TReportsSecCommands.MeiosContatoCadastrados;
   csReportFichasAlunosHistorico: Result := TReportsSecCommands.HistoricosCadastrados;
   csReportFichasALunosFuncoes: Result := TReportsSecCommands.FuncoesCadastrados;

   //Informações sobre o cadastrado
   csFamiliaresCadastrado: Result := sSQLFamiliaresCadastrado;

   //Alojamentos
   csAlojarInscritos: Result := TGConfCommands.AlojarInscritos;

   //Carteirinhas
   csReportCarteirinhaAluno: Result := TReportsCommand.Carteirinhas;// sSQLReportCarteirinhaAluno;
   csReportCarteirinhaFamiliares: Result := TReportsCommand.CarteirinhaFamiliares;
   csReportCarteirinhaMeiosContato: Result := TReportsCommand.CarteirinhaMeiosContato;
   csReportCarteirinhaEndereco: Result := TReportsCommand.CarteirinhaEndereco;
   //------------
   csReportRelacaoGeralAlunos: Result := sSQLReportRelacaoGeralAlunos;
   csReportEntregaCirculares: Result := TReportsCommand.ListaCadastrados;
   csReportFolhaPresenca: Result := sSQLReportFolhaPresenca;//sSQLReportListaPresencaAtividade;
   csReportCadastradosDiscipulado: Result := sSQLReportCadastradosDicipulado;
   csReportContarAlunosEE: Result := sSQLReportContarAlunosEE;
   csReportContarAlunosEI: Result := sSQLReportContarAlunosEI;
   csReportTotalAlunos: Result := sSQLReportTotalAlunos;
   csReportHistoricoCadastrado: Result := sSQLReportHistoricoCadastrado;
   csReportCadastradoCodigo: Result := sSQLReportCadastradoCodigo;
   csReportAtividadesCampo: Result := sSQLReportAtividadesCampo;
   csReportEscalasAtividades: Result := sSQLReportEscalasAtividades;
   csReportMembrosCirculo: Result := sSQLReportMembrosCirculo;
   csReportCirculosEI: Result := sSQLReportCirculosEI;
   csReportMembrosCirculos: Result := sSQLReportMembrosCirculos;
   csReportTempoDiscipulado: Result := sSQLReportTempoDiscipulado;
   csReportListaProfissoes: Result := sSQLReportListaProfissoes;
   csReportCadastradosProfissoes: Result := sSQLReportCadastradosProfissoes;
   csReportListaFuncoes: Result := sSQLReportListaFuncoes;
   csReportCadastradosFuncoes: Result := sSQLReportCadastradosFuncoes;
   csReportFamiliares: Result := sSQLReportFamiliares;
   csReportListaCadastradosNascimento: Result := TReportsCommand.ListaCadastradosNascimento;
   csReportFrequenciaAno: Result :=  sSQLReportFrequenciaAno;
   csReportFrequenciaAnoDiscipulado: Result := sSQLReportFrequenciaAnoDiscipulado;
   csReportFrequenciaPeriodo: Result :=  sSQLReportFrequenciaPeriodo;
   csReportFrequenciaPeriodoDiscipulado: Result :=  sSQLReportFrequenciaPeriodoDiscipulado;
   csReportFrequenciaAtividade: Result := sSQLReportFrequenciaAtividades;
   csReportFrequenciaAtividadesEI: Result := sSQLReportFrequenciaAtividadesEI;
   csReportAniversariantesMes: Result := sSQLReportAniversariantesMes;
   csReportInformacoesInscritosByFlag: Result := sSQLReportInformacoesInscritosByFlag;

   csFolhaPresencaMensal: Result := TReportsCommand.ListaCadastradosOrdenado;
   csReportSumarizaAtividades: Result :=  sSQLReportSumarizaAtividades;
   csResumoEstatistico: Result := sSQLReportResumoEstatistico;
   csResumoEstatisticoRa: Result := sSQLReportResumoEstatisticoRa;
   csResumoEstatisticoParent: Result := sSQLReportResumoEstatisticoParent;
   csMalaDireta: Result := sSQLReportMalaDireta;
   csReportOcorrenciasMes: Result := sSQLReportOcorrenciasMes;
   csReportListaPresencaAtividade: Result := sSQLReportListaPresencaAtividade;
   csListaMembrosCirculo: Result := sSQLListaMembrosCirculo;
   csEnderecosMembrosCirculo: Result :=  sSQLEnderecosMembrosCirculo;
   csMeiosContatoMembrosCirculos: Result := sSQLMeiosContatoMembrosCirculo;
   csListaInscritosAlfabetica: Result := TGConfInscricoes.ListaInscritosAlfabetica;
   csListaInscritosDiscipulado: Result := TGConfInscricoes.ListaInscritosDiscipulado;
   csListaInscritosFocos: Result := TGConfInscricoes.ListaInscritosFocos;
   csLeitosAlojamento: Result := TGConfAlojamentos.LeitosAlojamento;
   csLeitosLivresAlojamento: Result := TGConfAlojamentos.LeitosLivresAlojamento;
   csAlojamentosFoco: Result := TGConfAlojamentos.ListaAlojamentosFoco;
   csQuartosAlojamento: Result := TGConfAlojamentos.ListaQuartosAlojamento;
   csListaLeitosQuarto: Result := TGConfAlojamentos.ListaLeitosQuarto;
   csGeneralFlagsInscricoes: Result := TGConfInscricoes.GeneralFlagsInscricoes;
   csFlagsInscricoes: Result := TGConfInscricoes.FlagsInscricoes;
   csClassificadoresLeitos: Result := TGConfAlojamentos.ClassificadoresLeitos;
   csClassificadoresCadastrados: Result := TGConfAlojamentos.ClassificadoresCadastrados;
   csAreasStaff: Result := TGConfInscricoes.AreasStaff;
   csSubAreasStaff: Result := TGConfInscricoes.SubareasStaff;
   csInscritosConferencia: Result := TGConfInscricoes.InscritosConferencia;
   csInscritoNome: Result := TGConfInscricoes.InscritoNome;
   csTarefasAreaStaff: Result := TGConfInscricoes.TarefasAreaStaff;
   csAreasTarefasStaff: Result := TGConfInscricoes.AreasTarefasStaff;
   csStaffConferencia: Result := TGConfInscricoes.StaffConferencia;

   csReportInscritosConferencia: Result := TGConfInscricoes.InscritosConferencia;
   csReportInscritoConferencia: Result := TGConfInscricoes.InscritoConferencia;
   csReportInscritosAlojados: Result := TGConfInscricoes.InscritosAlojados;
   csReportInscritosDesalojados: Result := TGConfInscricoes.InscritosDesalojados;
   csReportCrachaInscrito: Result := TGConfInscricoes.ReportCrachaInscrito;
   csReportCrachaTarefasInscrito: Result := TGConfInscricoes.ReportTarefasInscrito;
   csReportCrachasInscritos: Result := TGConfInscricoes.ReportCrachasInscritos;
   csReportLeitosAlojamentos: Result := TGConfAlojamentos.LeitosAlojamentosFoco;

   csExportCadastrados: Result := sSQLExportCadastrados;
   csExportCadastradosEnderecos: Result := sSQLExportCadastradosEnderecos;
   csExportCadastradosTelefones: Result := sSQLExportCadastradosTelefone;
   csExportCadastradosEmails: Result := sSQLExportCadastradosEmails;
   csExportCadastradosEnderecosTelefonesEmails: Result := sSQLExportCadastradosEnderecosTelefoneEmails;
   csExportCadastradosEnderecosTelefones: Result := sSQLExportCadastradosEnderecosTelefones;
   csExportCadastradosEnderecosEmails: Result := sSQLExportCadastradosEnderecosEmails;
   csExportCadastradosTelefonesEmails: Result := sSQLExportCadastradosTelefoneEmails;

   csListaInscritosConferenciaImportacao: Result := TGConfInscricoes.ListaInscritosConferenciaImportacao;
   csImportarInscritoConferencia: Result := TGConfInscricoes.ImportarInscritoConferencia;

   csUsuarioCadastrador: Result := TGUsersCommands.UsuarioCadastrador;

   csTiposAtividades: Result := sSQLTiposAtividades;
   csAtividadesDatasCampo: Result := sSQLPesquisaAtividades;
   csAtividadesDatasCampoFoco: Result := sSQLPesquisaAtividadesFoco;

   csMyMessages: Result := sSQLMyMessages;
   csReportQuadroTotalizacaoRa: Result := sSQLReportQuadroTotalizacaoRa;
   csReportQuadroTotalizacaoRaTM: Result := sSQLReportQuadroTotalizacaoRaTM;
   csAlojadosQuartos: Result := TGConfAlojamentos.AlojadosQuartos;
   csQuartosUsadosAlojamento: Result := TGConfAlojamentos.QuartosUsadosAlojamento;
   csTurmasInstalacao: Result := sSQLTurmasInstalacao;
   csMembrosTurmaInstalacao: Result := sSQLMembrosTurmaInstalacao;
   csListaSimpatizantes: Result := TDQLCommands.ListaSimpatizantes;
   csTurmasTP: Result := TDQLCommands.ListaTurmasTP;
   csTurmaInstalacaoInfo: Result := TSecHistoricoCmd.TurmaInstalacaoInfo;
   //Financeiro
   csCaixasMesAno: Result := TFinCommands.CaixasMesAno;
   csInstituicoesBancarias: Result :=  TFinCommands.InstituicoesBancarias;
   csSituacaoAtividades: Result := TReportsSecCommands.SituacaoAtividades;
   csFocosRas: Result := TFocosCommands.FocosRas;
   csListOrgaos, csListSubOrgaos: Result := TFocosCommands.ListOrgaos;
   csOrgaosByName: Result := TFocosCommands.OrgaosByName;
   csFocosInscritos: Result := TGConfInscricoes.FocosInscritos;
   csIncritosConferenciaFocos: Result :=  TGConfInscricoes.IncritosConferenciaFocos;
   csAtividadesDatasFoco: Result := TSecAtividadesCommands.AtividadesDatasFoco;
   csProgramacaoConferencia: Result :=  TReportsConfCommands.ProgramacaoConferencia;
   csFolhasQuartos: Result :=  TReportsConfCommands.FolhasQuartos;
   csListaInscritos: Result :=  TReportsConfCommands.ListaInscritos;
   //Financeiro
   csTiposRecebimentos: Result := TFinCommands.TiposRecebimento
   else
    Result := '';
  end;
end;

class function TSQLCommandsFactory.GetTableCommand(
  Table: TCosmosTables): string;
begin
{Retorna um comando para consulta de toda uma tabela mapeada por essa classe. Este
 método é usado para obter o completo subset de dados de uma tabela.}
 Result := Result.Format(TDQLCommands.GeneralSelect, [Table.TableName]);
end;

end.
