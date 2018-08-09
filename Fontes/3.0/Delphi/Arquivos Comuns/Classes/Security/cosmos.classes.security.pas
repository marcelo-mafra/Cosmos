unit cosmos.classes.security;

interface

uses System.SysUtils, cosmos.classes.application, cosmos.business.focos,
  cosmos.system.types;

type

 //Representa como se dará o acesso a um foco: modo de escrita ou somente leitura.
  TConnectionMode = (cmWrite, cmRead);

  {Representa todas as funcionalidades do sistema que estão sujeitas a autorização.
  Não altere a ordem desse enumerado. O arquivo RolesPermissions.xml mapeia
  cada valor aqui encontrado pela sua posição. }
  TCosmosFeature = (
   //Atividades
   cfAgendaAtividades, cfTiposAtividades, cfCadastrarAtividadeLectorium,
   cfAlterarAtividadeLectorium, cfCadastrarAtividadeTM, cfAlterarAtividadeTM,
   cfCadastrarAtividadeTMB, cfAlterarAtividadeTMB, cfCadastrarAtividadeTP,
   cfAlterarAtividadeTP, cfCadastrarAtividadeEI, cfAlterarAtividadeEI, cfDeleteAtividade,
   cfControleFrequencia,
   //Ferramentas
   cfExportData, cfCentralPesquisas, cfCadastrarLogradouros, cfExternalReports,
   cfTabelasAcessorias,
   //Páginas de configuração
   cfConfPageServers, cfConfPageLogs, cfConfPageEmails, cfConfPageUpdater,
   //Atividades e conferências
   cfCadastrarAtividadeSIM, cfAlterarAtividadeSIM, cfNovaConferenciaLEC,
   cfNovaConferenciaTM, cfNovaConferenciaEI, cfNovaConferenciaTP,
   cfNovaConferenciaSIM, cfAlterarConferenciaLEC, cfAlterarConferenciaTM,
   cfAlterarConferenciaEI, cfAlterarConferenciaTP, cfAlterarConferenciaSIM,
   //Controle de frequência
   cfControleFrequenciaLEC, cfControleFrequenciaTM,
   cfControleFrequenciaEI, cfControleFrequenciaTP, cfControleFrequenciaSIM);


  //Features do módulo gestor de secretarias.
  TSecretariasFeatures = (
   sfAlunos, sfCadastrarAluno, sfAlterarAluno, sfHistoricoAluno, sfEnderecoAluno,
   sfMeiosContatosAluno, sfFamiliareasAluno, sfInfoMedicasAluno, sfFuncoesAluno,
   sfAptidoesAluno, sfIsencoesAluno, sfDesligarAluno, sfReligarAluno, sfTransferirAluno,
   sfRetrogradarAluno, sfCartaFrequenciaAluno, sfCasamentoAluno, sfBatismoAluno,
   //Jovens do TM
   sfJovens, sfCadastrarJovem, sfAlterarJovem, sfEnderecoJovem, sfMeiosContatosJovem,
   sfFamiliaresJovem, sfInfoMedicasJovem, sfDispensasJovem, sfHistoricoJovem,
   sfInstalarJovemTMB, sfBatismoJovem, sfDesligarJovem, sfReligarJovem, sfTransferirJovem,
   //Membros
   sfMembros, sfCadastrarMembro, sfAlterarMembro, sfEnderecoMembro, sfMeiosContatosMembro,
   sfFamiliaresMembro, sfInfoMedicasMembro, sfDispensasMembro, sfHistoricoMembro,
   sfBatismoMembro, sfDesligarMembro, sfReligarMembro, sfTransferirMembro,
   sfRetrogradarMembro,
   //Trabalho Público
   sfPesquisadores, sfCadastrarPesquisador, sfAlterarPesquisador,
   sfInstalacoes, sfEnderecoPesquisador, sfMeiosContatosPesquisador, sfHistoricoPesquisador,
   sfEntregarCartasPesquisador, sfInstalarPesquisadorTMB, sfDesligarPesquisador,
   sfReligarPesquisador, sfTransferirPesquisador, sfTurmasCursistas, sfNovaTurmaCursistas,
   sfAlterarTurmaCursistas, sfExcluirTurmaCursistas, sfEncerrarTurmaTP,
   sfReativarTurmaTP, sfSimpatizantes,
   //Escola Interna
   sfLivrosEI, sfCirculosEI, sfAlocucoes, sfTrocarDiscipulado,
   //Histórico Discipular
   sfRegisterHistoricEvent, sfAlterHistoricEvent, sfDeleteHistoricEvent,
   sfShowDetailHistoricEvent, sfRegisterDetailHistoricEvent, sfLoadHistoricCadastrado,
   //simpatizantes e escola interna
   sfCadastrarSimpatizante, sfAlterarSimpatizante, sfDesligarSimpatizante,
   sfReligarSimpatizante, sfTransferirSimpatizante, sfEnderecoSimpatizante, sfMeiosContatosSimpatizante,
   sfNovoCirculoEI, sfAlterarCirculoEI, sfExcluirCirculoEI,
   //Focos
   sfFocosRas, sfNovoFoco, sfNovaRA, sfRenameRA, sfDeleteRA, sfMentorsRas,
   sfDesactivateFocus, sfActivateFocus, sfEditFocus, sfDeleteFocus, sfEnderecosFocus,
   sfMeiosContatosFocus);


  //Features do módulo de conferências.
  TConferenciasFeatures = (
   nfAreasStaff, nfNovaAreaStaff, nfAlterarAreaStaff, nfExcluirAreaStaff,
   nfNovaTarefasArea, nfAlterarTarefasArea, nfExcluirTarefasArea,
   nfClassificadores, nfNovoClassificador, nfAlterarClassificador,
   nfExcluirClassificador, nfAlojamentos, nfNovoAlojamento, nfAlterarAlojamento,
   nfQuartosAlojamento, nfNovoLeito, nfAlterarLeito, nfManterHabitue,
   nfAtribuirClassificador, nfInscricoesConferencia, nfNovaInscricao,
   nfAlterarInscricao, nfCancelarInscricao, nfImportarInscritos, nfAlojarInscrito,
   nfDetalhamentoInscricao, nfManterDetalhamentoInscricao, nfItensNacionaisDetalhamento
  );


  //Features do módulo financeiro.
  TFinanceiroFeatures = (
    ffPlanoContas, ffNovaConta, ffAlterarConta, ffExcluirConta, ffRecebimentos,
    ffNovoRecebimento, ffAlterarRecebimento, ffExcluirRecebimento, ffPagamentos,
    ffNovoPagamento, ffAlterarPagamento, ffExcluirPagamento, ffAbrirCaixa, ffFecharCaixa,
    ffFecharCaixaAbandonado, ffAnaliseCaixas, ffCentrosCustos, ffNovoCentroCusto,
    ffAlterarCentroCusto, ffContasBancarias, ffNovaContaBancaria, ffAlterarContaBancaria,
    ffExcluirContaBancaria, ffAnaliseContribuicoes, ffDispensarContribuicoes);

  //Features do módulo gestor de focos.
  TFocosFeatures = (gf001 );

  //Features do módulo gestor de usuários.
  TUsuariosFeatures = (uf001 );

  //Representa o conjunto de funcionalidades autorizadas a um usuário.
  TUserAuthorizedFeatures = set of TCosmosFeature;

  //Representa o conjunto de funcionalidades do módulo gestor de secretarias autorizadas a um usuário.
  TSecretariasAuthorizedFeatures = set of TSecretariasFeatures;

  //Representa o conjunto de funcionalidades do módulo financeiro autorizadas a um usuário.
  TConferenciasAuthorizedFeatures = set of TConferenciasFeatures;

  //Representa o conjunto de funcionalidades do módulo financeiro autorizadas a um usuário.
  TFinanceiroAuthorizedFeatures = set of TFinanceiroFeatures;

  //Representa o conjunto de funcionalidades do módulo gestor de focos autorizadas a um usuário.
  TFocosAuthorizedFeatures = set of TFocosFeatures;

  //Representa o conjunto de funcionalidades do módulo gestor de usuários autorizadas a um usuário.
  TUsuariosAuthorizedFeatures = set of TUsuariosFeatures;


  TCosmosUser = class
   private
    FLogin: string;
    FFoco: string;
    FUserName: string;
    FGroup: string;
    FMatricula: string;
    FDiscipulado: string;
    FAdministrator: boolean;
    FAtivo: boolean;

   public
    constructor Create;
    destructor Destroy; override;
    property Ativo: boolean read FAtivo write FAtivo;
    property Discipulado: string read FDiscipulado write FDiscipulado;
    property Foco: string read FFoco write FFoco;
    property Group: string read FGroup write FGroup;
    property Login: string read FLogin write FLogin;
    property Matricula: string read FMatricula write FMatricula;
    property UserName: string read FUserName write FUserName;
    property Administrator: boolean read FAdministrator write FAdministrator;
  end;


  TCosmosSection = class
   private
    FConnectionTime: TDateTime;
    FConnectionStatus: TConnectionStatus;
    FConnectionID: string;
    FConnectionMode: TConnectionMode;

   public
    constructor Create;
    destructor Destroy; override;
    procedure CloseSection;
    procedure LockSection;
    property ConnectionStatus: TConnectionStatus read FConnectionStatus;
    property ConnectionTime: TDateTime read FConnectionTime write FConnectionTime;
    property ConnectionID: string read FConnectionID write FConnectionID;
    property ConnectionMode: TConnectionMode read FConnectionMode write FConnectionMode;
  end;


  TCosmosSecurity = class
  private
    FAuthorizedFeatures: TUserAuthorizedFeatures;
    FSecretariasFeatures: TSecretariasAuthorizedFeatures;
    FConferenciasFeatures: TConferenciasAuthorizedFeatures;
    FFinanceiroFeatures: TFinanceiroAuthorizedFeatures;
    FFocosFeatures: TFocosAuthorizedFeatures;
    FUsuariosFeatures: TUsuariosAuthorizedFeatures;
    FCamposTrabalho: TCamposTrabalho;
    FCurrentSection: TCosmosSection;
    FCurrentUser: TCosmosUser;

  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterUserInfo(Data: TCosmosData);
    procedure RegisterSection(Data: TCosmosData);
    procedure Reset;

    property AuthorizedFeatures: TUserAuthorizedFeatures read FAuthorizedFeatures write FAuthorizedFeatures;
    property SecretariasFeatures: TSecretariasAuthorizedFeatures read FSecretariasFeatures write FSecretariasFeatures;
    property ConferenciasFeatures: TConferenciasAuthorizedFeatures  read FConferenciasFeatures write FConferenciasFeatures;
    property FinanceiroFeatures: TFinanceiroAuthorizedFeatures  read FFinanceiroFeatures write FFinanceiroFeatures;
    property FocosFeatures: TFocosAuthorizedFeatures read FFocosFeatures write FFocosFeatures;
    property UsuariosFeatures: TUsuariosAuthorizedFeatures read FUsuariosFeatures write FUsuariosFeatures;
    property CamposTrabalho: TCamposTrabalho read FCamposTrabalho write FCamposTrabalho;
    property CurrentSection: TCosmosSection read FCurrentSection;
    property CurrentUser: TCosmosUser read FCurrentUser;
  end;



implementation

constructor TCosmosSecurity.Create;
begin
	inherited Create;
end;

destructor TCosmosSecurity.Destroy;
begin
  if Assigned(FCurrentSection) then
   FCurrentSection.Free;

  if Assigned(FCurrentUser) then
   FCurrentUser.Free;

	inherited Destroy;
end;

procedure TCosmosSecurity.RegisterSection(Data: TCosmosData);
begin
 if not Assigned(FCurrentSection) then
  begin
   FCurrentSection := TCosmosSection.Create;
   FCurrentUser := TCosmosUser.Create;
  end;

  FCurrentUser.Login := Data.FindValue('LOGIN');
  FCurrentUser.Foco := Data.FindValue('FOCO');
  FCurrentUser.UserName := Data.FindValue('USER_NAME');
  FCurrentUser.Group := Data.FindValue('GROUP');
  FCurrentUser.Matricula := Data.FindValue('MATRICULA');
  FCurrentUser.Discipulado := Data.FindValue('DISCIPULADO');
  FCurrentUser.Administrator := Data.FindValue('ADM') = 'S';
  FCurrentUser.Ativo := Data.FindValue('ATIVO') = 'S';

  FCurrentSection.ConnectionTime := Data.FindValue('CONNECTION_TIME');
  FCurrentSection.ConnectionID := Data.FindValue('CONNECTION_ID');
  FCurrentSection.FConnectionStatus := TConnectionStatus(Data.FindValue('CONNECTION_STATUS'));


  //Agora, trata do permissionamento...
  self.Reset;

 //Campos de trabalho acessíveis ao perfil...

  //Lectorium Rosicrucianum
  if Data.FindValue('INDLEC')= 'S' then
   FCamposTrabalho := FCamposTrabalho + [ctLectorium];

  //Trabalho da Mocidade
  if Data.FindValue('INDTMO')= 'S' then
   FCamposTrabalho := FCamposTrabalho + [ctTM];

  //Trabalho de Membros
  if Data.FindValue('INDTMB')= 'S' then
   FCamposTrabalho := FCamposTrabalho + [ctTMB];

  //Trabalho Público
  if Data.FindValue('INDTPU')= 'S' then
   FCamposTrabalho := FCamposTrabalho + [ctTP];

  //Escola Interna
  if Data.FindValue('INDEIN')= 'S' then
   FCamposTrabalho := FCamposTrabalho + [ctEI];
end;

procedure TCosmosSecurity.RegisterUserInfo(Data: TCosmosData);
begin
 if not Assigned(FCurrentSection) then
  begin
   FCurrentSection := TCosmosSection.Create;
   FCurrentUser := TCosmosUser.Create;
  end;

  FCurrentUser.Login := Data.FindValue('LOGIN');
  FCurrentUser.Foco := Data.FindValue('FOCO');
  FCurrentUser.UserName := Data.FindValue('USER_NAME');
  FCurrentUser.Group := Data.FindValue('GROUP');
  FCurrentUser.Matricula := Data.FindValue('MATRICULA');
  FCurrentUser.Discipulado := Data.FindValue('DISCIPULADO');
  FCurrentUser.Administrator := Data.FindValue('ADM') = 'S';
  FCurrentUser.Ativo := Data.FindValue('ATIVO') = 'S';

  FCurrentSection.ConnectionTime := Data.FindValue('CONNECTION_TIME');
  FCurrentSection.ConnectionID := Data.FindValue('CONNECTION_ID');
  FCurrentSection.FConnectionStatus := TConnectionStatus(Data.FindValue('CONNECTION_STATUS'));
end;

procedure TCosmosSecurity.Reset;
begin
   FCamposTrabalho := [];

   FAuthorizedFeatures := [];
   FSecretariasFeatures := [];
   FFinanceiroFeatures := [];
   FConferenciasFeatures := [];
   FFocosFeatures := [];
   FUsuariosFeatures := [];

   if Assigned(CurrentSection) then FreeAndNil(FCurrentSection);
   if Assigned(CurrentUser) then FreeAndNil(FCurrentUser);
end;


{ TCosmosUser }

constructor TCosmosUser.Create;
begin
 inherited Create;
 FAdministrator := False;
end;

destructor TCosmosUser.Destroy;
begin
 inherited Destroy;
end;

{ TCosmosSection }

procedure TCosmosSection.CloseSection;
begin
 FConnectionStatus := csHostDisconnected;
end;

constructor TCosmosSection.Create;
begin
 inherited Create;
end;

destructor TCosmosSection.Destroy;
begin
 inherited Destroy;
end;

procedure TCosmosSection.LockSection;
begin
 FConnectionStatus := csUserLocked;
end;

end.

