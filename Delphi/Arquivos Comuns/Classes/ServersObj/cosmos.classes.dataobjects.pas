unit cosmos.classes.dataobjects;

interface

uses
 System.Classes, Winapi.Windows, System.SysUtils, Data.DBXCommon, Data.SQLExpr,
 Data.DBXDBReaders, Data.DB, Datasnap.DBClient, cosmos.servers.sqlcommands,
 cosmos.classes.ServerInterface, cosmos.classes.arrayutils, cosmos.system.exceptions,
 cosmos.classes.application, System.Variants, Datasnap.Provider, cosmos.system.files,
 cosmos.system.messages, cosmos.classes.serversutils, cosmos.classes.cripter,
 cosmos.core.classes.searchsinfo, System.Generics.Collections;

 const
  sPassCript: string = 'galaademnos';

type

//Implementa um simples pool de conexões com o banco de dados.
 TConnectionsPool = class
   private
   FConnectionParamsFile: string;
   FConnectionsPool:  TDictionary<Int64, TSQLConnection>;
   FOnErrorEvent: TDBXErrorEvent;
   function GetConnectionsCount: integer;

  public
   constructor Create(const ConnectionParamsFile: string);
   destructor Destroy;
   procedure ClearAll;

   function GetConnection: TSQLConnection; overload;
   procedure FillPool(const ObjCount: integer);
   procedure RemoveConnection(const SessionId: Int64);

   property ConnectionsCount: integer read GetConnectionsCount;
   property OnErrorEvent: TDBXErrorEvent read FOnErrorEvent write FOnErrorEvent;
 end;

 //Classe base que implementa recursos básicos, como criação de conexões e datasets.
 TSQLServerObject = class (TInterfacedPersistent)

  private
   sSystemUser: string;
   procedure LoadConnectionParams(SQLCon: TSQLConnection);

  public
   constructor Create;
   destructor Destroy; override;

   function CreateConnection: TSQLConnection;
   function CreateDataset(Connection: TSQLConnection): TSQLDataset;
 end;

 //Abstrai um objeto controlador do transações no servidor SQL.
 TSQLServerTransactionsManager = class(TSQLServerObject)
  private

  public
   constructor Create;
   destructor Destroy; override;

   function BeginTransaction(Connection: TSQLConnection): TDBXTransaction; overload;
   function BeginTransaction(Connection: TSQLConnection; const Isolation: integer): TDBXTransaction; overload;
   procedure CommitTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
   procedure RollbackTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
   procedure PrepareTransaction(var TD: TTransactionDesc);
   procedure StartSQLServer;
 end;

 //Abstrai operações de execução de comandos no servidor SQL.
 TSQLServerCommand = class(TSQLServerObject)
  private
   procedure CloseDataset(Dataset: TDataset); inline;

  public
   constructor Create;
   destructor Destroy; override;

   function ExecuteCommand(const Command: WideString): integer;
   function ExecuteScript(Connection: TSQLConnection; Script: TStringList): boolean; overload;
   function ExecuteScript(Script: TStringList): boolean; overload;
   procedure ExecuteDQL(const DQL: WideString; Dataset: TSQLDataset); overload;
   procedure ExecuteDQL(const DQL: WideString; Dataset: TClientDataset); overload;

 end;


 TSQLCommandsFactory = class
  class function GetSQLCommand(Search: TCosmosSearch): string;
  class function GetDMLCommand(Command: TCosmosCommand): string;
  class procedure CreateCommandText(var ACommand: string; Params: Olevariant);
  class function GetDatasetCommand(Dataset: TCustomSQLDataSet): string;
  class function GetTableCommand(Table: TCosmosTables): string;

 end;


 TCosmosDataObjects = class
  class function GetSequenceName(Sequence: TSequences): string;
  class function GetRegisteredCommand(const CommandId: integer): string;
 end;


 TDataTransformation = class
  class function AsSQLBoolean(const value: boolean): string; overload;
  class function AsSQLBoolean(const value: boolean; Quotes: boolean): string; overload;
  class function AsSQLTimeStamp(const Value: TDateTime; IncludeTime: boolean = False): string;
  class function VarToInt(const value: variant): integer;
  class function StringToWideString(const s: AnsiString; codePage: Word): WideString;
  class function Criptografar(const Text: string): string;
  class function Descriptografar(Text: string): string;

 end;

implementation

{ TSQLServerTransactionsManager }

constructor TSQLServerTransactionsManager.Create;
begin
 inherited Create;
end;

destructor TSQLServerTransactionsManager.Destroy;
begin
  inherited;
end;

procedure TSQLServerTransactionsManager.PrepareTransaction(var TD: TTransactionDesc);
begin
//Prepara nova transação
 Randomize;
 TD.TransactionID := Random(32767); //Gera o ID aleatório (smallint) da transação.
 TD.IsolationLevel := xilREADCOMMITTED;
end;

function TSQLServerTransactionsManager.BeginTransaction(Connection: TSQLConnection): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction
 else
  Result := nil;
end;

function TSQLServerTransactionsManager.BeginTransaction(Connection: TSQLConnection;
  const Isolation: integer): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction(Isolation)
 else
  Result := nil;
end;

procedure TSQLServerTransactionsManager.CommitTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
begin
//Confirma uma transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
  Connection.CommitFreeAndNil(Transaction);
end;

procedure TSQLServerTransactionsManager.RollbackTransaction(Connection: TSQLConnection;
  var Transaction: TDBXTransaction);
begin
//Desfaz a transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
   Connection.RollbackFreeAndNil(Transaction);
end;

procedure TSQLServerTransactionsManager.StartSQLServer;
begin
end;

{ TSQLServerCommand }

constructor TSQLServerCommand.Create;
begin
 inherited Create;
end;

destructor TSQLServerCommand.Destroy;
begin
  inherited Destroy;
end;

function TSQLServerCommand.ExecuteCommand(const Command: WideString): integer;
var
 AConnection: TSQLConnection;
 AServer: TSQLServerTransactionsManager;
 TD: TDBXTransaction;
begin
//Executa um comando no banco de dados.
 AConnection := self.CreateConnection;
 AServer := TSQLServerTransactionsManager.Create;

 try
  TD := AServer.BeginTransaction(AConnection);
  Result := AConnection.ExecuteDirect(Command);

  if AConnection.InTransaction then
   AServer.CommitTransaction(AConnection, TD);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

  if Assigned(AServer) then
   FreeAndNil(AServer);

  {Isto é necessário porque o retorno do método ExecuteDirect, chamado acima,
   sempre está retornado 0. É uma falha do DBExpress.}
  if Result = 0 then
   Result := 1;

 except
  if AConnection.InTransaction then
   AServer.RollbackTransaction(AConnection, TD);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

  if Assigned(AServer) then
   FreeAndNil(AServer);

  raise;
 end;
end;

procedure TSQLServerCommand.ExecuteDQL(const DQL: WideString;
  Dataset: TClientDataset);
var
AConnection: TSQLConnection;
ADataset: TSQLDataset;
AProvider: TDatasetProvider;
begin
{Este método não pode ser executado usando-se a classe TDBXDatasetReader porque,
no RAD Studio 2010, o método CopyReaderToClientDataSet trunca as strings. Então,
usamos um DatasetProvider.}

 AConnection := self.CreateConnection;
 ADataset := TSQLDataset.Create(nil);
 AProvider := TDatasetProvider.Create(nil);

 try
  ADataset.SQLConnection := AConnection;
  ADataset.CommandText := DQL;
  AProvider.DataSet := ADataset;
  Dataset.Data := AProvider.Data;

 finally
  if Assigned(AConnection) then FreeAndNil(AConnection);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AProvider) then FreeAndNil(AProvider);
 end;
end;

function TSQLServerCommand.ExecuteScript(Script: TStringList): boolean;
var
TD: TDBXTransaction;  //Objeto que implementa transações no DBExpress
AServer: TSQLServerTransactionsManager;
AConnection: TSQLConnection;
ACommand: string;
I: integer;
begin
{Executa um script com diversos comandos sql de forma atômica. Caso ocorra
alguma falha, toda operação será desfeita.}
 AServer := TSQLServerTransactionsManager.Create;
 AConnection := self.CreateConnection;

 try
 //Inicia uma nova transação
  TD := AServer.BeginTransaction(AConnection);

  for I := 0 to Pred(Script.Count) do
    begin
     ACommand := Script.Strings[I];
     AConnection.ExecuteDirect(ACommand);
    end;

  if AConnection.InTransaction then
   AServer.CommitTransaction(AConnection, TD);

  Result := True;

  if Assigned(AServer) then
   FreeAndNil(AServer);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

 except
  on E: Exception do //Deu pau...
   begin
   {A checagem abaixo evita que outros erros não tenham permitido o início da
    transação. p. exe: queda ou travamento do servidor sql}
    if Assigned(AConnection) then
     begin
      if AConnection.InTransaction then
       AServer.RollbackTransaction(AConnection, TD);
     end;

    if Assigned(AServer) then FreeAndNil(AServer);
    if Assigned(AConnection) then FreeAndNil(AConnection);

    raise;
   end;
 end;
end;

procedure TSQLServerCommand.CloseDataset(Dataset: TDataset);
begin
 if Dataset.Active then
  Dataset.Close;
end;

procedure TSQLServerCommand.ExecuteDQL(const DQL: WideString; Dataset: TSQLDataset);
begin
//Executa um comando DQL no banco de dados e retorna um cursosr unidirecional.
 try
  CloseDataset(Dataset);
  Dataset.CommandText := DQL;
  Dataset.Open;

 except
  raise;
 end;
end;

function TSQLServerCommand.ExecuteScript(Connection: TSQLConnection;
  Script: TStringList): boolean;
var
TD: TDBXTransaction;  //Objeto que implementa transações no DBExpress
AServer: TSQLServerTransactionsManager;
ACommand: string;
I: integer;
begin
{Executa um script com diversos comandos sql de forma atômica. Caso ocorra
alguma falha, toda operação será desfeita.}
 AServer := TSQLServerTransactionsManager.Create;

 try
 //Inicia uma nova transação
  TD := AServer.BeginTransaction(Connection);

  for I := 0 to Pred(Script.Count) do
    begin
     ACommand := Script.Strings[I];
     Connection.ExecuteDirect(ACommand);
    end;

  AServer.CommitTransaction(Connection, TD);
  Result := True;

  if Assigned(AServer) then
   FreeAndNil(AServer);


 except
  on E: Exception do //Deu pau...
   begin
   {A checagem abaixo evita que outros erros não tenham permitido o início da
    transação. p. exe: queda ou travamento do servidor sql}
    AServer.RollbackTransaction(Connection, TD);

    if Assigned(AServer) then
     FreeAndNil(AServer);

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

class function TSQLCommandsFactory.GetDatasetCommand(
  Dataset: TCustomSQLDataSet): string;
var
I: integer;
sParamValue: string;
begin
//Retorna uma string que representa o camando executado por um dataset.
 if Dataset <> nil then
  begin
   if Dataset is TSQLDataset then
    Result := TSQLDataset(Dataset).CommandText else
   if Dataset is TSQLQuery then
    Result := TSQLQUery(Dataset).CommandText else
   if Dataset is TSQLStoredProc then
    begin
     Result := Format('exec %s ', [TSQLStoredProc(Dataset).StoredProcName]);
     Result := Result + '(%s)';

     for I := 0 to TSQLStoredProc(Dataset).Params.Count - 1 do
       begin
        sParamValue := sParamValue +  TSQLStoredProc(Dataset).Params.Items[I].Text;
        if I <=  Pred(TSQLStoredProc(Dataset).Params.Count) then
         sParamValue := sParamValue + ', ';
       end;

     Result := Format(Result, [sParamValue]);
    end;
  end;
end;

class function TSQLCommandsFactory.GetDMLCommand(Command: TCosmosCommand): string;
begin
 case Command of
  ccDeleteUsuario: Result := TSecurityCommand.DeleteUser;
  ccDeleteFocoUsuario: Result := TSecurityCommand.DeleteFocusUser;
  ccInstalarAluno: Result := TSecHistoricoCmd.InstalarAluno;
  ccNovaConferencia: Result := sSQLInsertConferencia;
  ccAtividadeConferencia: Result := sUpdAtividadesConferencia;
  ccDelAtividadeConferencia: Result := sUpdAtividadesConferenciaDel;
  else
  Result := '';
 end
end;

class function TSQLCommandsFactory.GetSQLCommand(Search: TCosmosSearch): string;
begin
//Retorna o comando SQL de uma pesquisa passada em parâmetro
  case Search of
   csGeneralSelect: Result := TDQLCommand.GeneralSelect;
   csAreasAptidoes: Result := sSQLfkAreasAptidoes;
   csCargos: Result := sSQLCargos;
   csCartasTP: Result := Format(sSQLCartasTP, [QuotedStr('TPU'), QuotedStr('DOC'), QuotedStr('N')]);
   csDiscipuladosEE: Result := Format(sDiscipulados, [QuotedStr('N'), QuotedStr('LEC'), QuotedStr('S')]);
   csDiscipuladosEI: Result := Format(sDiscipulados, [QuotedStr('S'), QuotedStr('LEC'), QuotedStr('S')]);
   csDiscipuladosLectorium: Result := Format(sDiscipuladosCampos, [QuotedStr('LEC')]);
   csDiscipuladosTM: Result := Format(sDiscipulados, [QuotedStr('N'), QuotedStr('TMO'), QuotedStr('S')]);
   csDiscipuladosTMB: Result := Format(sDiscipulados, [QuotedStr('N'), QuotedStr('TMB'), QuotedStr('S')]);
   csDiscipuladosTP: Result := Format(sDiscipulados, [QuotedStr('N'), QuotedStr('TPU'), QuotedStr('S')]);
   csDiscipuladosSIM: Result := Format(sDiscipulados, [QuotedStr('N'), QuotedStr('SIM'), QuotedStr('S')]);
   csDiscipuladosCampo: Result := TDQLCommand.DiscipuladosCampos;
   csEnfermidades: Result := sSQLfkEnfermidades;

   //Usuários e permissões
   csCosmosUsers: Result := TGUsersCommands.Cosmosusers;

   //Focos e Regiões Admnistrativas.
   csRegioes: Result := sRegioes;
   csSubRegioes: Result := sRegioesPai;
   csFocosRa: Result := sSQLFocosRa2;
   csFocos: Result := Format(sSQLFocoAtivos, [QuotedStr('S')]);
   csFocosTitulares: Result := sSQLFocosTitulares;
   csFocosDependentes: Result := sSQLFocosDependentes;
   csFocosPesquisadores: Result := Format(sSQLFocosTipos, [QuotedStr('S'), 'indtpu', QuotedStr('S')]);
   csFocosAlunos: Result := Format(sSQLFocosTipos, [QuotedStr('S'), 'indlec',  QuotedStr('S')]);
   csFocosConferencias: Result := sSQLFocosConferencia;
   csConferenciasFocoAno: Result := sSQLConferenciasFocoAno;

   //Escola Interna
   csLicoesEI: Result := sSQLfkLicoesEI;
   csLicoesLivroEI: Result := sLicoesLivroEI;
   csLivrosDiscipuladoEI: Result := sSelLivrosEI;
   csDirigentesEI: Result := '' ;
   csMentoresEI, csMentorasEI: Result := sSQLCadastradoFocoCampoSexo + ' and indmen = ' + QuotedStr('S');
   csMentoresEIFoco, csMentorasEIFoco: Result := '';
   csCirculosEIFocoDiscipulado: Result := sSQLSearchCirculosEIFocoDiscipulado;

   //Tabelas Acessórias.
   csMeiosContatos: Result := sSQLfkTiposContatos;
   csProfissoes: Result := sSQLfkProfissoes;
   csFuncoes: Result := sSQLFuncoes;
   csTipoAtuacao: Result := sSQLfkTiposAtuacao;
   csTiposEventosTP: Result := Format(sSQLfkTiposEventos, [QuotedStr('TPU')]);
   csCarteirinhaCadastrado: Result := sSQLCarteirinhasCadastrados;
   csCountAtividadeTipo: Result := TSecAtividadesCommands.TiposAtividadesCount;
   csExternalReportsCategories: Result := TReportsCommand.ExternalReports;

   //Logradouros.
   csBairros: Result := sSQLBairros;
   csCidades: Result := sSQLCidades;
   csEstados: Result := sSQLEstados;
   csPaises: Result := sSQLPaises;

   //Alocuções
   csAlocucoes: Result := SSQLAlocucoes;
   csAlocucoesDataCadastro: Result := sSQLAlocucoesDataCadastro;
   csAlocucoesDataLeitura: Result := sSQLAlocucoesDataLeitura;
   csAlocucoesIneditas: Result := sSQLAlocucoesIneditas;
   csAlocucoesAssunto: Result := sSQLAlocucoesAssunto;
   csAlocucoesAutor: Result := sSQLAlocucoesAutor;
   csAlocucoesCamposTrabalho: Result := sSQLAlocucoesCamposTrabalho;

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
   csDadosCadastrado: Result := TDQLCommand.DadosCadastrado;
   csCadastradoIndex: Result := sSQLCadastradoIndex;
   csCadastradoMatricula: Result := sSQLCadastradosMatricula;
   csCadastradoMatriculaFoco: Result := TDQLCommand.CadastradosMatriculaFoco;
   csCadastradoNome: Result := sSQLCadastradosNome;
   csCadastradoNomeFoco: Result := TDQLCommand.CadastradosNomeFoco;
   csCadastradoApelido: Result := sSQLCadastradosApelido;
   csCadastradoApelidoFoco: Result := TDQLCommand.CadastradosApelidoFoco;
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
   csListaSimpatizantes: Result := TDQLCommand.ListaSimpatizantes;
   csTurmasTP: Result := TDQLCommand.ListaTurmasTP;
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
 case Table of
   ctAptidoes: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_APTIDOES]);
   ctCargos: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_CARGOS]);
   ctEnfermidades: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_ENFERMIDADES]);
   ctFuncoes: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_FUNCOES]);
   ctMeiosContatos: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_MEIOSCONTATOS]);
   ctProfissoes: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_PROFISSOES]);
   ctTiposRecebimentos: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_TIPOS_RECEBIMENTOS]);
   ctFlagsInscricao: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_FLAGS_INSCRICOES]);
   ctFocos: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_FOCOS]);
   ctPerfis: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_PERFIS]);
   ctDiscipulados: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_DISCIPULADOS]);
   ctTiposEventos: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_TIPOS_EVENTOS]);
   ctRelatoriosExternos: Result := Result.Format(TDQLCommand.GeneralSelect, [TTablesNames.TAB_RELATORIOS_EXTERNOS]);
 end;
end;

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

class function TCosmosDataObjects.GetSequenceName(Sequence: TSequences): string;
begin
{Retorna o nome da sequence que um objeto do tipo TSequences representa.}
 case Sequence of
   sqCadastrados: ;
   sqFocos: Result := TSequencesNames.GEN_FOCOS;
   sqRegioes: Result := TSequencesNames.GEN_REGIOES;
   sqPaises: ;
   sqEstados: ;
   sqCidades: ;
   sqBairros: ;
   sqLogradouros: ;
   sqCargos: ;
   sqTiposMeiosContatos: ;
   sqMentorRA: ;
   sqOrgaosGestores: ;
   sqGestoes: Result :=  TSequencesNames.GEN_GESTOES;
   sqDirecoes: ;
   sqAreasStaff: ;
 end;
end;

{ TDataTransformation }

class function TDataTransformation.AsSQLBoolean(const value: boolean): string;
begin
//Converte um boolean para uma string que representa o tipo boolean no sgbd
 if Value = true then
  Result := 'S'
 else
  Result := 'N';
end;

class function TDataTransformation.AsSQLBoolean(const value: boolean;
  Quotes: boolean): string;
begin
//Converte um boolean para uma string que representa o tipo boolean no sgbd
 if Value = true then
  Result := 'S'
 else
  Result := 'N';
 if Quotes then
  Result := QuotedStr(Result);
end;

class function TDataTransformation.AsSQLTimeStamp(const Value: TDateTime;
  IncludeTime: boolean): string;
begin
//Formata um TDateTime para uma string que possa ser usada em uma sentença sql
 if not IncludeTime then
  Result := FormatDateTime('yyyy/mm/dd', Value)
 else
  Result := FormatDateTime('yyyy/mm/dd hh:mm:ss', Value)
end;



class function TDataTransformation.Criptografar(const Text: string): string;
var
 aCripter: TCripter;
begin
//Criptografa uma string que é retornada pela função. A rotina de criptografia
//está no módulo cripter.dll
 aCripter := TCripter.Create;

 try
  Result := aCripter.Encrypt(cmBlowfish128, TCosmosCriptography.CipherKey, Text);

 finally
  aCripter.Free;
 end;
end;

class function TDataTransformation.Descriptografar(Text: string): string;
var
 aCripter: TCripter;
begin
//Descriptografa uma string que é retornada pela função. A rotina de
//descriptografia está no módulo cripter.dll
 aCripter := TCripter.Create;

 try
  Result := aCripter.Decrypt(cmBlowfish128, TCosmosCriptography.CipherKey, Text);

 finally
  aCripter.Free;
 end;
end;

class function TDataTransformation.StringToWideString(const s: AnsiString;
  codePage: Word): WideString;
begin

end;

class function TDataTransformation.VarToInt(const value: variant): integer;
begin
//Converte um variant para um inteiro
 Result := VarAsType(value,varInteger);
end;

{ TSQLServerObject }

constructor TSQLServerObject.Create;
begin
 inherited Create;
end;

function TSQLServerObject.CreateConnection: TSQLConnection;
begin
 Result := TSQLConnection.Create(nil);
 self.LoadConnectionParams(Result);
end;

function TSQLServerObject.CreateDataset(
  Connection: TSQLConnection): TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := Connection;
end;

destructor TSQLServerObject.Destroy;
begin
  inherited;
end;

procedure TSQLServerObject.LoadConnectionParams(SQLCon: TSQLConnection);
var
 AFileName: string;
begin
  //Carrega os dados de conexão na memória para um objeto de conexão.
   AFileName := TCosmosInfoFiles.GetDatabaseConfigurationFile;
   SQLCon.ConnectionName := 'COSMOS';
   SQLCon.LoadParamsFromIniFile(AFileName);
   SQLCon.LoginPrompt := False;

   SQLCon.DriverName := 'FIREBIRD'; //do not localize!
   SQLCon.GetDriverFunc :=  'getSQLDriverINTERBASE'; //do not localize!
   SQLCon.LibraryName := 'dbxfb.dll'; //do not localize!
   SQLCon.VendorLib := 'fbclient.dll'; //do not localize!
   sSystemUser := SQLCon.Params.Values['user_name'];
end;

{ TConnectionsPool }

procedure TConnectionsPool.ClearAll;
var
 AKey: Int64;
 AConn: TSQLConnection;
begin
 {Limpa o pool de conexão e destrói todos os objetos nele existentes.}
  for AKey in FConnectionsPool.Keys do
   begin
    AConn := FConnectionsPool[Akey];

    if AConn <> nil then
     begin
      AConn.DBXConnection.OnErrorEvent := nil;
      AConn.Free;
     end;
   end;

 FConnectionsPool.Clear;
end;

constructor TConnectionsPool.Create(const ConnectionParamsFile: string);
begin
 FConnectionsPool := TDictionary<Int64, TSQLConnection>.Create;
 FConnectionParamsFile := ConnectionParamsFile;
end;

destructor TConnectionsPool.Destroy;
begin
  FConnectionsPool.Values.Free;
  FConnectionsPool.Keys.Free;
  FConnectionsPool.Free;

  inherited Destroy;
end;

procedure TConnectionsPool.FillPool(const ObjCount: integer);
var
 I: integer;
 AIndex: Int64;
 dbconn : TSQLConnection;
 sValue: string;
 aCripter: TCripter;
 aParams: TStringList;
begin
 {Cria objetos TSQLConnection no pool para uso das aplicações. O número de objetos
  TSQLConnection que serão criados é definido pelo parâmetro ObjCount.}
 I := ObjCount;
 Randomize;
 // ShowMessage('Criando TCripter...');
 aCripter := TCripter.Create;
 aParams := TStringList.Create;

 aParams.LoadFromFile(FConnectionParamsFile);

 try

 while I > 0 do
  begin
    dbconn := TSQLConnection.Create(nil);
    dbconn.LoginPrompt := False;

    dbconn.ConnectionName := 'COSMOS';
    dbconn.Params.Clear;
    dbconn.LoadParamsOnConnect := False;
    dbconn.DriverName := 'FIREBIRD'; //do not localize!

 //   dbConn.LoadParamsFromIniFile(self.FConnectionParamsFile);

    dbconn.LibraryName := aParams.Values['LibraryName']; //do not localize!
    dbconn.VendorLib := aParams.Values['VendorLib']; //do not localize!
    dbconn.Params.Values['vendorlibwin64'] := aParams.Values['vendorlibwin64']; //do not localize!

    //Descriptografa informações sobre a conexão com o banco de dados.

    //Path do banco de dados.
    sValue := aParams.Values['Database'];
    sValue := aCripter.Decrypt(cmBlowfish128, sPassCript, sValue);
    dbconn.Params.Values['Database'] := sValue;

    //Usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['user_name'];
    sValue := aCripter.Decrypt(cmBlowfish128, sPassCript, sValue);
    dbconn.Params.Values['user_name'] := sValue;

    //Senha do usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['Password'];
    sValue := aCripter.Decrypt(cmBlowfish128, sPassCript, sValue);
    dbconn.Params.Values['Password'] := sValue;

    //Role do usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['rolename'];
    sValue := aCripter.Decrypt(cmBlowfish128, sPassCript, sValue);
    dbconn.Params.Values['rolename'] := sValue;

    //Role do usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['role'];
    sValue := aCripter.Decrypt(cmBlowfish128, sPassCript, sValue);
    dbconn.Params.Values['role'] := sValue;

    //Host do servidor do banco de dados.
    sValue := aParams.Values['HostName'];
    sValue := aCripter.Decrypt(cmBlowfish128, sPassCript, sValue);
    dbconn.Params.Values['HostName'] := sValue;

    //Server charset
    dbconn.Params.Values['servercharset'] := aParams.Values['servercharset']; //do not localize!
    //SQL Dialect
    dbconn.Params.Values['sqldialect'] := aParams.Values['sqldialect']; //do not localize!

   //Inicia a inserção da conexão configurada ao pool de conexões.
    AIndex := Random(30);

    while FConnectionsPool.ContainsKey(AIndex) do
     begin
      AIndex := Random(30);
     end;

    //Agora, abre a conexão e a adiciona ao pool.
    dbconn.Open;
    dbconn.DBXConnection.OnErrorEvent := self.OnErrorEvent;
    FConnectionsPool.Add(AIndex, dbconn);
    Dec(I);
  end;

 aCripter.Free;
 aParams.Free;

 except
  on E: Exception do
   begin
    if Assigned(ACripter) then FreeAndNil(aCripter);
    raise;
   end;
 end;
end;

function TConnectionsPool.GetConnection: TSQLConnection;
var
 AKey: Int64;
begin
 //Retorna uma conexão existente no pool de conexões.
 Randomize;
 Result := nil;

 Akey := Random(30);

 while Result = nil do
  begin
   if FConnectionsPool.ContainsKey(AKey) then
    Result := FConnectionsPool[AKey];
   Akey := Random(30);
  end;
end;

function TConnectionsPool.GetConnectionsCount: integer;
begin
 Result := FConnectionsPool.Count;
end;

procedure TConnectionsPool.RemoveConnection(const SessionId: Int64);
var
 DbCon: TSQLConnection;
begin
 if FConnectionsPool.ContainsKey(SessionId) then
  begin
   DbCon := FConnectionsPool[SessionId];
   DbCon.Close;
   DbCon.Free;
   FConnectionsPool.Remove(SessionId);
  end;
end;

end.

