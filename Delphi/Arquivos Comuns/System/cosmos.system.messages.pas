unit cosmos.system.messages;

interface

uses Winapi.Windows;

const



//aSucessfullLogin = 'A autenticação foi feita com sucesso!';
//sSearchServers = 'Buscando os servidores remotos...';

//Conferências
sRepNameCrachasInscricao = 'Crachás de Inscrição';
sRepNameCrachaInscrito = 'Crachá de Inscrito';
sRepNameListaInscritos = 'Lista de Inscritos';

//Constantes usadas nos assistentes
sUsuario = 'Usuário: %s';
sLogin = 'Login (deve ser único): %s';
sRole = 'Grupo: %s';

//Itens de opções usadas nas TaskDialogs
//sCancelarInscricao = 'Cancelar a inscrição selecionada!';
//sCancelarOperacao = 'Cancelar a operação corrente!';

 type
  //Constantes relacionadas a caixas de mensagens.
  TMessagesConst = class
    const
     //Códigos de mensagens
     IdMsg_UnregisteredApp = 1;
     IdMsg_FalhaRegistro = 2;
     IdMsg_ConfigPageNotFound = 3;
     //Cardinais
     RES_SUCESS = 0;
     RES_NO_PARTICIPANTES = 1;
     RES_ERROR = 2;
     //Botões de caixas de diálogo
     TitleInfo = 'Informação';
     TitleConf = 'Confirmação';
     TitleError = 'Erro';
     TitleWarn = 'Aviso';
     BtOK = '&OK';
     BtCancel = '&Cancelar';
     BtYes = '&Sim';
     BtNo = '&Não';
     BtIgnore = '&Ignorar';
     BtRetry = '&Retentar';
     BtHelp = '&Ajuda';
  end;


  //Conexão
  //Segurança
  TSecurityConst = class
    const
     WriteRight = 'Escrita';
     ReadRight = 'Leitura';
     AdministratorUser = 'Administrador do sistema';
     NormalUser = 'Usuário regular';
  end;

  //Certificados
  TCertificateConst = class
    const
     certType = 'Tipo';
     Owner = 'Requerente';
     Website = 'Website';
     Email = 'Email';
     Country = 'País';
     State  = 'Estado';
     Location = 'Cidade';
     SigAlgName = 'SigAlgName';
     Assinatura = 'Assinatura';
     Algoritm = 'Algoritmo de assinatura';
     NotBefore = 'Válido a partir de';
     NotAfter = 'Válido até';
     SerialNumber = 'Número de série';
  end;

  //Nomes dos aplicativos Cosmos
  TCosmosAppName = class
    const
      CosmosCommonId = 'cmAll';
      CosmosSecretariasId = 'cmSecretarias';
      CosmosFocosId = 'cmFocos';
      CosmosUsuariosId = 'cmUsuarios';
      CosmosFinanceiroId = 'cmFinanceiro';
      CosmosConferenciasId = 'cmConferencias';
      CosmosSecretarias = 'Cosmos Gestor de Secretarias';
      CosmosFocos = 'Cosmos Gestor de Focos';
      CosmosUsuarios = 'Cosmos Gestor de Usuários';
      CosmosFinanceiro = 'Cosmos Gestor Financeiro';
      CosmosConferencias = 'Cosmos Gestor de Conferências';
      CosmosSecretariasShort = 'gsec';
      CosmosFocosShort = 'gfoc';
      CosmosUsuariosShort = 'gusu';
      CosmosFinanceiroShort = 'gfin';
      CosmosConferenciasShort = 'gcon';
  end;

  //Ajuda
  TCosmosHelp = class
    const
      CosmosSuportUrl = 'http://www.lectoriumrosicrucianum.org.br';
  end;

  //Registro dos aplicativos
  TCosmosRegister = class
    const
      InvalidCosmosLicence = 'O arquivo de registro de licença não pode ser usado ' +
        'para registrar uma cópia do %s!';
      InvalidFile = 'O arquivo de registro de licença do Cosmos não é válido';
      InvalidFileToComputer = 'O arquivo de registro de licença do Cosmos não é ' +
        'válido para este computador!';
      NotValidateKey =  'Os dados de registro não foram validados! O registro ' +
        'não pode ser efetuado! Use outro arquivo de registro.';
      NotRegistered = 'A aplicação não pode ser registrada. Entre em contato com ' +
        'o fornecedor do aplicativo para obter suporte!';
      //Guids usadas para o registro
      GUID_GFocos = '{3504F0B1-C475-4CCB-96D7-E8EC58861C0D}'; //do not localize!
      GUID_Secretarias = '{F22DB419-DD5B-4076-A59C-71DA28CC2C40}'; //do not localize!
      GUID_Financeiro = '{D490AD04-7E5F-43CC-9CAA-E9F5BECE2FE2}';//do not localize!
      GUID_Conferencias = '{F2BFD094-035F-4251-AD15-6BD95B172C23}';//do not localize!
      GUID_Usuarios = '{7B295BA9-DA5C-4EB9-B286-3C4F81FBA86C}';//do not localize!
      RegisteredCopy = 'Aplicativo registrado!';
      UnregisteredCopy = '[cópia não registrada]';
      InfoRegisterFocusName = 'Você deve informar o nome do foco!';
      InfoRegisterUserName = 'Você deve informar o nome do usuário!';
      InfoRegisterEmail = 'Você deve informar o correio eletrônico!';
      InfoRegisterIncorrectEmail = 'O correio eletrônico fornecido parece não estar correto!';
      InfoCloseUnregisteredApp = 'Esta aplicação não se encontra licenciada. ' +
        'Apenas aplicações licenciadas da suíte Cosmos podem ser executadas. A aplicação será encerrada.';
  end;

  TEmailConst = class
   const
      NewEmailSubject = 'Nova mensagem';
      NewEmailBody = 'Escreva aqui a sua mensagem';
  end;

    ///<summary>
   ///  Classe que ordena pequenas strings usadas como parte de registros de
   /// logs. </summary>
   TCosmosLogs =  class
    const
      CommandId             = 'Número do comando: %d';
      SQLCommand            = 'Comando executado: %s';
      SQLStoredProc         = 'Stored procedure: %s';
      SQLParamsInfo         = 'Parâmetro: %s: Valor: %s';
      SequenceName          = 'Sequence: %';
      ExecutedRemoteCommand = 'Comando remoto executado com sucesso: %s';
      ExecutedRemoteCommandFail = 'Falha na execução do comando remoto: %s';
      ExecuteScriptBegin    = 'Inicianado a execução de script de comandos. Script: %s';
      ExecuteScriptEnd      = 'Término da execução de script de comandos. Script: %s';
      //Tipos de logs
      InfoLogType               = 'Informação';
      ErrorLogType              = 'Erro';
      WarnLogType               = 'Aviso';
      PrepareLogType            = 'Prepare';
      TraceLogType              = 'Trace';
      AuthLogType               = 'Autenticação';
      AuthFailLogType           = 'Autenticação inválida';
      AutLogType                = 'Autorização';
      ConLogType                = 'Conexão';
      ConErrorLogType           = 'Falha na conexão';
      ConCloseLogType           = 'Conexão encerrada';
      DatabasePoolCreated       = 'Database pool criado com sucesso.';
      RemoteCallLogType         = 'Chamada remota';
      RemoteCallErrorLogType    = 'Falha na chamada remota';
      UnknownLogType            = 'Desconhecido';
      InitializedServer         = 'Servidor inicializado.';
      AuthorizationsMethods     = 'Autorizações de acesso a métodos remotos carregada com sucesso!';
      ErrorCode                 = 'Código do erro: %d';
      ContextInfoSession        = 'Seção: %d';
      ContextInfoUser           = 'Usuário: %s';
      ContextInfoRoles          = 'Perfis: %s';
      ContextInfoProtocol       = 'Protocolo: %s';
      ConnectedUser             = 'Usuário %s conectado com sucesso!';
      DisconnectedUser          = 'Usuário %s desconectado com sucesso!';
      AutenticatedUser          = 'Usuário %s autenticado com sucesso!';
      InactivedUser             = 'O usuário %s está inativo. Ele não pode acessar as aplicações Cosmos.';
      IncorrectLogin            = 'Falha na tentativa de login. Usuário: %s. Mensagem: %s';
      IncorrectStatment         = 'Falha na execução de comando sql: %s';
      InvalidAuthentication     = 'Autenticação inválida de usuário! Login: %s';
      BlockedUser               = 'O usuário %s está bloqueado. Ele não pode acessar as aplicações Cosmos.';
      AuthorizedRoles           = 'Perfis autorizadas a acessar o método: %s';
      DeniedAuthorization       = 'O usuário %s não está autorizado a acessar o método "%s"!';
      CantAcessCosmosModule     = 'Usuário não está autorizado a acessar este aplicativo ' +
          'do Cosmos. Procure um administrador do sistema para solicitar a permissão de acesso.';
      AppMethod                 = 'AppMethod: %s';
      ConnectingToHost          = 'Conectando ao servidor remoto em %s ...';
      PrepareConnect            = 'Preparando a conexão do usuário %s...';
      PrepareDisconnect         = 'Preparando a desconexão do usuário %s...';
      Preparing                 = 'Preparando a execução do método %s...';
      VerifyingIdentity         = 'Verificando identidade do usuário %s...';
      GettingAuthorizations      = 'Obtendo permissões do usuário %s...';
      ApplyPermissions          = 'Aplicando as permissões do usuário e montando o ambiente. Por favor, aguarde.';
      LoadingData               = 'Carregando dados do servidor para início da seção...';
      CheckingCertificate       = 'Verificando validade do certificado digital recebido...';
      CreatingConnectionsPool   = 'Criando o pool de conexões e ativando-o. Por favor, agarde um momento.';
      BufferingData             = 'Recuperando dados do servidor para utilização durante a seção de trabalho...';
      //Indicadores de sensibilidade dos logs
      Baixa = 'Baixa';
      Media = 'Média';
      Alta = 'Alta';
      SettingFolders            = 'As configurações de pastas do sistema foram lidas com sucesso.';
      //Títulos usados apenas no sistema de logs.
      TitlePrepare= 'Prepare';
      TitleTrace= 'TraceInfo';
      TitleAuthenticate='Authenticate';
      TitleAuthorize='Authorization';
   end;

   TCosmosReportsNames = class
    const
      //Nomes de relatórios
      {sRepNameCarteiraLEC = 'Carteirinha do Aluno';
      sRepNameCarteiraTMB = 'Carteirinha do Membro';
      sRepNameFichaCadastralLEC = 'Ficha do aluno';
      sRepNameFichaCadastralTM = 'Ficha do jovem';
      sRepNameFichaCadastralTMB = 'Ficha do membro';
      sRepNameFichaCadastralTP = 'Ficha do pesquisador';
      sRepNameHistorico = 'Histórico Discipular';
      sRepBoletimInformativo = 'Boletim Informativo';
      sRepFolhaPresenca = 'Folha de Presença (2 colunas)';
      sRepFolhaPresencaSimples = 'Folha de Presença';
      sRepFolhaPresencaCirculo = 'Folha de Presença da Escola Interna';
      sRepMembrosCirculos = 'Membros dos Círculos';
      sRepCadastradosByDiscipulado = 'Cadastrados por discipulados'; }
      EscalasAtividades = 'Escalas de Atividades';
      ExternalReports = 'Relatórios Externos';

   end;

  TCosmosSearchsInfo = class
    const
     //Searchs Names
     SearchFocoRegiao = 'Regiões Administrativas';
     SearchFocosFocos = 'Relação de Focos Cadastrados';
     SearchFocosAtivos = 'Focos Ativos';
     SearchMeiosContatos = 'Meios de Contatos';
     SearchPaises = 'Países Cadastrados';
     SearchEstados = 'Estados';
     SearchCidades = 'Cidades';
     SearchBairros = 'Bairros de Cidades';
     SearchLogradouros = 'Logradouros';
     SearchOrgaosGestores = 'Órgãos Gestores';
     SearchCargos = 'Cargos';
     SearchDiscipuladosEE = 'Discipulados da Escola Externa';
     SearchDiscipuladosEI = 'Discipulados da Escola Interna';
     SearchDiscipuladosLEC = 'Discipulados do Lectorium Rosicrucianum';
     SearchDiscipuladosTM = 'Grupos do Trabalho da Mocidade';
     SearchDiscipuladosTMB = 'Grupos do Trabalho de Membros';
     SearchEnfermidades = 'Enfermidades';
     SearchFocos = 'Lista de focos ativos';
     SearchLicoesEI = 'Lições da Escola Interna';
     SearchProfissoes = 'Profissões';
     SearchFuncoes = 'Funções Exercidas';
     SearchEventosDiscipulares = 'Eventos Discipulares do TP';
     SearchAptidoes = 'Aptidões';
     SearchRegioesAdministrativas = 'Regiões Administrativas do Lectorium Rosicrucianum';
     SearchCartasTP = 'Cartas informativas do trabalho Público';
     SearchClassificadoresLeito = 'Classificadores de leitos';
     SearchClassificadores = 'Classificadores';
     SearchAlojamentos = 'Alojamentos';
     SearchLeitosAlojamentos = 'Leitos';
     SearchFlagsInscricoes = 'Informações de Inscrições';

     //Searchs Descriptions
     SearchDescDiscipuladosEI = 'Lista os discipulados da Escola Interna.';
     SearchDescDiscipuladosEE = 'Lista os discipulados da Escola Externa.';
     SearchDescDiscipuladosLEC = 'Lista os discipulados do Lectorium Rosicrucianum.';
     SearchDescDiscipuladosTM = 'Lista os grupos do Trabalho da Mocidade.';
     SearchDescDiscipuladosTMB = 'Lista os grupos do Trabalho de Membros.';
     SearchDescEnfermidades = 'Lista as enfermidades cadastradas.';
     SearchDescFocos = 'Lista os focos atualmente ativos.';
     SearchDescFocosWithPupils = 'Lista os núcleos, núcleos e centros de ' +
      'conferências e sedes atualmente ativos.';
     SearchDescFocosPesquisadores = 'Lista os núcleos, núcleos e centros de ' +
      'conferências, sedes e salas e locais do Trabalho Público atualmente ativos.';
     SearchDescLicoesEI = 'Lista as lições dos discipulados da Escola Interna.';
     SearchDescProfissoes = 'Lista as profissões atualmente cadastradas.';
     SearchDescMeiosContatos = 'Lista os tipos de meios de contatos cadastrados.';
     SearchDescTipoAtuacao = 'Lista as funções exercidas por escalados em atividades.';
     SearchDescTipoEvento = 'Lista os tipos de eventos discipulares do histórico ' +
      'discipular de um cadastrado.';
     SearchDescCargos = 'Lista os cargos cadastrados.';
     SearchDescFuncoes = 'Lista as funções cadastradas.';
     SearchDescAptidoes = 'Lista as aptidões disponíveis para um aluno.';
     SearchDescRegioesAdministrativas = 'Lista as regiões e subregiões administrativas ' +
       'do Lectorium Rosicrucianum';
     SearchDescCartasTP = 'Lista as cartas informativas do Trabalho Público';
     SearchDescClassificadoresLeito = 'Lista os classificadores que podem ser atribuídos ' +
       'a leitos de um alojamento.';
     SearchDescClassificadoresCadastrado = 'Lista os classificadores que podem ser atribuídos ' +
       'a pessoas que são alojadas durante uma conferência.';
     SearchDescAlojamentos = 'Lista os alojamentos disponíveis para o foco atual.' ;
     SearchDescLeitosAlojamentos = 'Lista os leitos disponíveis nos diversos ' +
       'alojamentos do foco atual.' ;
     SearchDescFlagsInscricoes = 'Lista as informações de inscrições que podem ' +
       'ser utilizadas para conferências promovidas por qualquer centro de conferência.' ;
  end;



  //Constantes usadas em diversos pontos da interface gráfica do usuário.

  TCosmosGUIElements = class
   const
    //sBtSaveTasks = 'Salvar as alterações nas minha lista de tarefas';
    //sBtNoSaveTasks = 'Abandonar as alterações feitas';
    BtImportarInscritos = 'Importar inscrições.';
    BtNaoImportarInscritos = 'Não importar!';
    SelectFolder = 'Selecione um pasta.';
    //Itens de caixas de diálogo
    MSWordCaption = 'Cosmos: Ata de Posse';
    NovaTarefa = 'Nova tarefa';
    TurmasAno = 'Turmas de instalação em %d';
    ConferencesCalendar = 'Calendário de Conferências para %d';
    TodosFocos = '(Todos os focos...)';
    //Esferas de atuação dos órgãos gestores
    EsferaInternacional = 'Internacional';
    EsferaNacional = 'Nacional';
    EsferaRegional = 'Regional';
    EsferaLocal = 'Local';
  end;


  //Textos da janela de personalização de menus e barras de ferramentas
   TCustomizeDlgMsg =  class
    const
      Caption                        = 'Personalizar';
      CloseBtnCaption                = '&Fechar';
      ToolbarsTabCaption             = '&Barra de Ferramentas';
      ActionsTabCaption              = '&Comandos';
      OptionsTabCaption              = '&Opções';
      ToolbarsLblCaption             = 'Barras de Ferramentas';
      LargeIconsChkCaption           = 'Usar ícones grandes';
      DescGroupBoxCaption            = 'Descrição';
      CaptionOptionsGrpCaption       = 'Opções';
      SeparatorBtnCaption            = 'Separadores...';
      SeparatorBtnHint               = 'Separadores...|Arraste para criar separadores';
      Label4Caption                  = 'Opções de Títulos';
      ApplyToAllActnCaption          = 'Todas as barras de ferramentas';
      ActionsCatLblCaption           = 'Categorias';
      ActionsActionsLblCaption       = 'Comandos';
      InfoLblCaption                 = 'Para adicionar comandos, arraste e solte um item de Categorias ou Comandos para uma barra de ferramenta.';
      PersonalizeLblCaption          = 'Personalizações';
      RecentlyUsedActnCaption        = 'Exibir primeiro itens usados recentemente';
      ShowHintsActnCaption           = 'Exibir hints de ajuda';
      ShowShortCutsInTipsActnCaption = 'Exibir atalhos nos hints';
      Label1Caption                  = 'Animações';
      ResetUsageDataActnCaption      = 'Reset...';
      OtherLblCaption                = 'Outros';
   end;

   //Constantes dos assistentes do Cosmos
   TWizardsConst = class
     const
      NextPage = '&Próximo';
      Finish = '&Concluir';
   end;

   TAlojamentosConst = class
    const
      AlojamentoProprio = 'Próprio';
      AlojamentoExterno = 'Externo';
      QuartoBloqueado = 'Bloqueado';
      QuartoEmUso = 'Em uso';
      Quarto = 'Quarto %s (Ala: %s)';
      Leito = 'Leito %d';
   end;

   ///<summary>
   ///  Classe que ordena os títulos das mensagens de caixas de diálogo.
   ///</summary>
   TCosmosTitles =  class
    const
      SystemFailure       = 'Falha de sistema';
      HelpSystem          = 'Sistema de ajuda';
      Security            = 'Segurança';
      ServerConection     = 'Conexão com o servidor';
      SelectData          = 'Seleção de dados';
      UpdateData          = 'Salvamento de dados';
      UpdateSystem        = 'Atualização do Sistema';
      ExportData          = 'Exportação de dados';
      ServerDateTime      = 'Data/hora do servidor';
      Atenttion           = 'Atenção!';
      UnregisteredApp     = 'Registre esta aplicação!';
      FalhaRegistro       = 'Falha no registro!';
      DeleteTipoAtividade = 'Exclusão de tipos de atividades';
      Autentication       = 'Autenticação de usuário';
      Users               = 'Gestão de Usuários';
      Permissoes          = 'Gestão de Permissões';
      CanceledAutentication = 'Autenticação cancelada!';
      InvalidAutentication = 'Autenticação inválida!';
      ErrorAutentication  = 'Falha durante a autenticação!';
      OpenFocus           = 'Abertura de foco';
      TM                  = 'Trabalho da Mocidade';
      TMB                 = 'Trabalho de Membros';
      TP                  = 'Trabalho Público';
      Frequencia          = 'Controle de freqüência';
      ErrorSelectData     = 'Falha na obtenção dos dados!';
      EI                  = 'Escola Interna';
      EIBook              = 'Livros da Escola Interna';
      EILesson            = 'Lições da Escola Interna';
      CadastradosSearch   = 'Pesquisa de cadastrados';
      NovaTurmaTP         = 'Nova turma do Trabalho Público';
      NovoCirculoEI       = 'Novo círculo da Escola Interna';
      DesligarCadastrado  = 'Desligamento de cadastrados';
      TransferirCadastrado = 'Transferência de cadastrados';
      ReativarCadastrado  = 'Reativação de cadastrados';
      RetrogradarCadastrado = 'Retrogradação de cadastrado';
      BatizarCadastrado   = 'Batismo';
      CasarCadastrados    = 'Casamento';
      CartaFrequencia     = 'Carta de freqüência';
      ExecuteScript       = 'Falha na escrita de dados!';
      ExecuteDML          = 'Falha na execução de comando!';
      NovaMatricula       = 'Nova matrícula';
      InstalarMembro      = 'Instalação de membros';
      HistoricoDiscipular = 'Histórico discipular';
      LivrosEI            = 'Livros da Escola Interna';
      ControleFrequencia  = 'Controle de freqüência';
      TurmasInstalacao    = 'Turmas de instalação';
      TurmasTP            = 'Turmas do Trabalho Público';
      DiscipuladosTM      = 'Discipulados do Trabalho da Mocidade';
      GJA                 = 'Grupo de Jovens Alunos';
      AgendaAtividades    = 'Agenda de atividades';
      Escalas             = 'Escalas de Atividades';
      GetCommands         = 'Recuperação de comandos';
      Conferencias        = 'Gestão de conferências';
      Classificadores     = 'Classificadores';
      PesquisaDados       = 'Pesquisa de dados';
      TasksTool           = 'Tarefas';
      InscricoesConferencia = 'Inscrições para conferência';
      AreasStaff          = 'Áreas de Staff';
      ReportParams        = 'Parâmetros de Relatórios';
      PlanoContas         = 'Plano de Contas';
      Recebimentos        = 'Recebimentos';
      CentrosCusto        = 'Centros de Custo';
      NovoFoco            = 'Novo Foco';
      ExcluirFoco         = 'Exclusão de Foco';
      RAs                 = 'Regiões Administrativas';
      ExcluirRA           = 'Exclusão de Região Administrativa';
      FocosUpdate         = 'Alteração de Foco';
      FocosSearch         = 'Pesquisa de Focos';
      RaSearch            = 'Pesquisa de Regiões Administrativas';
      MentoresRa          = 'Mentores de RA' + '''' + 's';
      Alojamentos         = 'Alojamentos';
      Alunos              = 'Alunos';
      CirculosEI          = 'Círculos da Escola Interna';
      Bairros             = 'Bairros';
      Logradouros         = 'Logradouros';
      Cidades             = 'Cidades';
      Estados             = 'Estados';
      Staff               = 'Staff de Conferências';
      Enderecos           = 'Endereços';
      OrgaosGestores      = 'Órgãos Gestores';
      Gestoes             = 'Mandatos';
      Dirigentes          = 'Dirigentes';
      Alocucoes           = 'Alocuções';
      DataValidation      = 'Validação de dados';
      CentralPesquisas    = 'Central de Pesquisas';
      Familiares          = 'Familiares';
      InformacoeMedicas   = 'Informações Médicas';
      Funcoes             = 'Funções';
      Aptidoes            = 'Aptidões';
      LogsCosmos          = 'Logs do Cosmos';
      ConfConexoes        = 'Conexões';
      ConfServidores      = 'Servidores';
      ConfPool            = 'Pool de Conexões';
      ConfGerais          = 'Configurações Gerais';
      ConfEmail           = 'Correio Eletrônico';
      ConfGUI             = 'Aparência do Aplicativo';
      ConfElements        = 'Elementos Centrais';
      ConfMenuLateral     = 'Menu Lateral';
      ConfMatriculas      = 'Geração de Matrículas';
      Messages            = 'Mensagens';
      ConfMessages        = 'Mensages do Usuário';
      ConfAtualizacoes    = 'Atualizações';
      ConfSecretarias     = 'Secretarias';
      ConfFinanceiro      = 'Financeiro';
      ConfReceiptsOptions = 'Impressão de Recibos';
      ReportsCenter       = 'Central de Relatórios';
      MeiosContato        = 'Meios de Contato';
      Caixa               = 'Caixa';
      IdentificaoAtiva    = 'Identificação Ativa';
      ContasBancarias     = 'Contas Bancárias';
      Focos               = 'Focos';
      NewRA               = 'Nova RA';
      NewSubRa            = 'Nova Subregião Administrativa';
      RenameRA            = 'Renomear RA';

 end;


   ///<summary>
   ///  Classe que ordena as mensagens de informação de caixas de diálogo.
   ///</summary>
   TCosmosInfoMsg = class
     const
       NoFocusAcess = 'Você não possui direitos de acesso a qualquer foco cadastrado! ' +
           'Entre em contato com um membro da Comissão Nacional de Informática para obter ' +
            'privilégios de acesso aos dados do seu foco.';
       FrequenciaComputada = 'O levantamento de freqüência para esta atividade já ' +
           'foi iniciado. Agora você pode continuar a apuração.';
       TransferenciaRegistrada = 'A transferência foi registrada com sucesso no histórico discipular!';
       BatismoRegistrado = 'O batismo foi registrado com sucesso no histórico discipular!';
       CasamentoRegistrado = 'O casamento foi registrado com sucesso nos históricos discipulares dos nubentes!';
       RetrogradacaoRegistrada = 'A retrogradação foi registrada com sucesso no histórico discipular!';
       RetrogradacaoImpossivel = 'O cadastrado "%s" não pode ser retrogradado para um discipulado anterior ao ' +
           'que atualmente está vinculado!';
       CartaFrequenciaRegistrada = 'A carta de freqüência foi registrada com sucesso no histórico discipular do aluno!';
       DesligamentoRegistrado = 'O desligamento foi registrado com sucesso no histórico discipular!';
       ReligamentoRegistrado = 'O religamento do cadastrado foi registrado com sucesso no histórico discipular!';
       EncerrarTurmaTP = 'Deseja realmente encerrar a turma selecionada?';
       DelTurmaTP = 'Deseja realmente excluir a turma de cursistas selecionada? Atenção! A exclusão somente ' +
           'poderá ser feita se não houverem dados de atividades promovidas para a turma.';
       SenhaAlterada = 'A senha do usuário foi alterada com sucesso!';
       TemporaryPassword = 'A sua senha atual é provisória e não pode ser usada para acessar as aplicações Cosmos. ' +
           'Troque a sua senha para continuar a autenticação.';
       ResetedPassword = 'A senha do usuário %s foi regerada como a seguinte senha provisória: %s';
       CannotUseGUsers = 'O Cosmos Gestor de Usuários é uma ferramenta destinada exclusivamente aos usuários que são ' +
           'administradores dos sistemas Cosmos. A autenticação foi cancelada.';
       CantDeleteClassificador = 'Não é possível excluir o classificador selecionado. Ele está sendo usado na categorização de leitos e pessoas.';
       CantDelAreaStaff = 'Não é possível excluir esta área de staff, pois existem tarefas a ela ligadas que estão sendo utilizadas na conferência corrente ou em conferências passadas.';
       CantDeleteFlagInscricoes = 'Não é possível excluir o item de inscrição selecionado. Ele está sendo usado por outro centro de conferência ou já foi utilizado no passado.';
       CantDelInscrito = 'Não é possível cancelar esta inscrição. A secretaria já apurou a freqüência deste inscrito nesta conferência.';
       ConferenciaCriada = 'A nova conferência foi criada com sucesso!';
       AlojamentosNaoCadastrados = 'Não existem alojamentos cadastrados para o foco corrente. Cadastre alojamentos, quartos e leitos antes de prosseguir com a operação.';
       CannotDelFlagInscricao = 'Esta informação não pode ser excluída pelos usuários. Consulte um administrador do sistema sobre a exclusão.';
       InscricoesArquivoDesconhecido = 'Antes de prosseguir com esta operação é necessário informar qual o arquivo que será usado como fonte dos dados da importação de inscritos.';
       InscricoesArquivoInexistente = 'O Cosmos Gestor de Conferências não localizou o arquivo que será usado como fonte dos dados da importação de inscritos. Talvez o endereço do arquivo esteja informado de forma incorreta.';
       InscricoesFonteDestino = 'A conferência usada como fonte dos dados dos inscritos é a mesma conferência selecionada como destino das importações de inscrições!';
       StaffTarefaRegistrado = 'O inscrito %s já está escalado como staff da tarefa "%s"';
       HoraTarefaStaff = 'As informações sobre a hora de início e término da tarefa de staff estão incorretas ou não foram fornecidas.';
       NoHelpFound = 'Não foi fornecido um item de ajuda para este recurso!';
       ProtocoloAberto = 'Existem passos neste protocolo que ainda não foram cumpridos. A instalação não poderá ser confirmada até que todos os passos do protocolo estejam marcados como "concluídos".';
       PromotorConferencia = 'Esta conferência é promovida por outro foco. Para trabalhar com qualquer informação referente a esta conferência, é necessário que você abra a sua secretaria. A operação será cancelada.';
       IncompleteData = 'Os dados requeridos nesta etapa do assistente não foram fornecidos. Preencha todas as informações antes de prosseguir.';
       MembrosCirculo = 'Antes de prosseguir com o assistente é preciso indicar quais pessoas farão parte do novo círculo!';
       SelectBook = 'Selecione o livro antes de criar esta nova lição!';
       TitularInexistente = 'Não existe um titular definido para o aluno atual. A operação foi cancelada.';
       TitularJovemTMInexistente = 'Não existe um titular definido para o jovem atual. A operação foi cancelada.';
       ValoresContribuicaoFoco = 'Os valores de contribuição deste contribuinte somente podem ser alterados por usuários com acesso ao foco ao qual ele pertence.';
       RecebimentoCancelado = 'O Recebimento foi cancelado com sucesso. As totalizações do caixa foram recalculadas.';
       InstalandosCarteirinha = 'Não é possível recuperar os dados dos instalandos da turma selecionada. Expanda a turma para visualizar os seus membros.';
       GoodNetActivity = 'O sistema detectou boa conectividade com a Internet e com o servidor do Cosmos!';
       OpenBrowserConnection = 'O sistema acessará uma interface do servidor Cosmos que pode ser interpretada por um navegador. Verifique se o navegador abrirá uma página com dados legíveis emitidos pelo servidor Cosmos.';
       CaixaAberto = 'Novo caixa aberto: %s';
       ExportEmpty = 'Não foram encontrados dados para exportar!';
       AlreadyRootFocus = 'O foco atual não está ligado a nenhum foco!';
       FocoCriado = 'O novo foco foi criado com sucesso!';
       RACriada = 'A nova Região Administrativa foi criada com sucesso!';
       ConferenciaPromotor = 'Não é possível editar os dados desta conferência, ' +
           'pois ela é promovida por um foco que não se encontra aberto. Para editar ' +
           'seus dados, você deve abrir a secretaria deste foco.';
       ClosedDataset = 'Não foi possível realizar esta operação: os dados não ' +
         'estão disponíveis.';
       CepNotFound = 'O logradouro "%s" não está cadastrado!';
       AlreadyRootOrgao = 'O órgão gestor atual não possui informações de subordinação!';
       NoSelectedDirigente = 'Nenhum dirigente foi selecionado. A operação será cancelada.';
       UndefiniedUser = 'O usuário cadastrador ainda não foi definido!';
       IncorrectPassword = 'A senha do contato não foi confirmada. Informe e ' +
         'confirme novamente a senha do contato.';
       DetalheHistoricoVazio = 'Não existem outras informações sobre este ' +
         'evento discipular!';
       InstalledTurmaInstalacao = 'os membros desta turma de instalação foram  ' +
         'instalados com sucesso em seu novo discipulado!';
       PromotorAtividade = 'Esta atividade é promovida por outro foco. Para ' +
         'trabalhar com qualquer informação referente a esta atividade, é necessário ' +
         'que você abra a sua secretaria. A operação será cancelada.';
       ParticipantesGrupoEI = 'Esta atividade é destinada a um círculo da ' +
         'Escola Interna. Não é possível cadastrar participantes para as atividades ' +
         'que são destinadas a um círculo da Escola Interna.';
       DelAtividade = 'Esta atividade é promovida por um campo de trabalho ' +
         'para o qual você não possui privilégios de acesso. A operação será cancelada.';
       FrequenciaCadastrado = 'Já foi levantada a frequência do cadastrado "%s" ' +
         'para esta atividade!';
       CanDelTableData = 'Em função da manutenção da integeridade das informações ' +
         'do sistema Cosmos, não é permitido excluir estes dados. A operação será ' +
         'abortada.';
       EndWork = 'A mensagem foi enviada com sucesso!';
       DelecaoPlanoConta = 'A exclusão da conta do plano de contas foi feita com ' +
         'sucesso.';
       NoCosmosSearchs = 'Não foi possível recuperar nehuma pesquisa com os argumentos correntes!';
       DelTipoAtividade = 'A exclusão do tipo de atividade foi concluída com sucesso!';
       AddMembroTurmaInstalacao = 'O novo membro desta turma de isntalação foi ' +
         'adicionado com sucesso!';
       FrequenciaConfComputada = 'O levantamento de freqüência para esta conferência já ' +
         'foi iniciado. Agora você pode continuar a apuração.';
       ConferenciaTP = 'O Trabalho Público não é um Campo de Trabalho promotor de ' +
         'conferências. Você não pode criar uma conferência promovida por este campo ou ' +
         'trabalhar com a programação de atividades do Trabalho Público em uma conferência.';
       ConferenciaPromotorInvalido = 'O Cosmos Gestor de Conferências não conhece ' +
         'como trabalhar com uma conferência promovida por este Campo de Trabalho. ' +
          'Procure um administrador do sistema e relate este problema.';
       ConferenciaNoAddAtividade = 'Esta atividade já está associada a uma conferência. ' +
         'A operação foi cancelada.';
       SalvamentoTarefas = 'A sua lista de tarefas foi alterada. Selecione uma ' +
         'das opções para prosseguir.';
       PesquisaFocoNoRa = 'Nesta pesquisa você deve selecionar um foco e não uma ' +
         'Região Administrativa.';
       PesquisaRaNoFoco = 'Nesta pesquisa você deve selecionar uma Região Administrativa ' +
         'e não um foco de trabalho.';
       PesquisaNoArguments = 'Para efetuar esta operação você deve informar um argumento ' +
         'de pesquisa!';
       EmptyParam = 'É preciso informar um valor para o parâmetro "%s"!';
       CannotFindTaskFile = 'Não foi possível localizar tarefas criadas por você. ' +
         'O relatório não poderá ser gerado.';

   end;


   ///<summary>
   ///  Classe que ordena as mensagens de confirmação de caixas de diálogo.
   ///</summary>
   TCosmosConfMsg = class
     const
       CancelSection = 'Deseja realmente cancelar a autenticação recentemente feita?';
       DeleteLogFiles = 'Deseja realmente excluir os arquivos de logs selecionados? Atenção, esta ' +
              'operação não poderá ser revertida.';
       TransferirCadastrado = 'Deseja realmente transferir o cadastrado para o foco indicado?';
       TransferirAluno = 'Deseja realmente transferir o aluno para o foco indicado?';
       RetrogradarCadastrado = 'Deseja realmente retrogradar? Atenção, esta operação não poderá ser revertida!';
       DesligarCadastrado = 'Deseja confirmar a operação de desligamento do cadastrado?';
       ConfDelete = 'Deseja realmente apagar esta informação?';
       EcerrarTurmaTP = 'Deseja realmente encerrar essa turma de cursista do Trabalho Público?';
       ReativarTurmaTP = 'Ao reativar uma turma já encerrada, a data de ' +
              'encerramento cadastrada será eliminada. Deseja realmente executar esta operação?';
       LockUser = 'Confirma o bloqueio do usuário "%s"?';
       UnlockUser = 'Confirma o desbloqueio do usuário "%s"?';
       DelPrivilegioFoco = 'Deseja retirar o privilégio de acesso ao foco "%s" para o usuário "%s"?';
       DeleteUsuario = 'Confirma a exclusão do usuário "%s"? ATENÇÃO! Esta ação não poderá ser desfeita.';
       SetAdministrator = 'Deseja tornar o usuário "%s" um administrador do sistema?';
       UnsetAdministrator = 'Deseja retirar do usuário "%s" o privilégio de administrador do sistema?';
       DelPerfil = 'Deseja realmente excluir o perfil selecionado?';
       ResetPassword = 'Deseja realmente gerar uma nova senha temporária para o usuário %s?';
       DelFocoParticipanteConf = 'Deseja realmente excluir este foco da lista de participantes da conferência?';
       DelParticipanteConf = 'Deseja realmente excluir este discipulado da lista de participantes da conferência?';
       CancelarInscricao = 'Esta operação irá cancelar permanentemente esta inscrição. Deseja prosseguir com a operação?';
       AtualizarAtributosInscricao = 'Esta operação irá atualizar as inscrições da conferência corrente com as ' +
        'informações de detalhes da inscrição recentemente definidas para as conferências deste foco. Deseja prosseguir com a operação?';
       DesalojarInscrito = 'Deseja realmente desalojar o inscrito de seu leito atual?';
       DelDetalhesInscricao = 'Deseja realmente excluir este item de informação de inscrição?';
       ImportarInscritos = 'Esta ação irá iniciar o processo de importação destes dados. Deseja continuar com a operação de importação?';
       DelAreaStaff = 'Deseja realmente excluir a área de staff selecionada?';
       DelStaffConferencia = 'Deseja realmente excluir esta tarefa do inscrito na conferência?';
       CalcularCandidatos = 'Deseja que o Cosmos Gestor de Secretarias liste as pessoas que poderiam ser instaladas no discipulado "%s"?';
       ClearFrequencia = 'ATENÇÃO! Você está prestes a eliminar permanentemente todos os registros de freqüência para a atividade corrente. Esta ação não poderá ser desfeita. Deseja prosseguir com esta operação?';
       DelFrequencia = 'Deseja realmente excluir o registro de freqüência do cadastrado "%s" para esta atividade? ATENÇÃO: esta ação não poderá ser desfeita!';
       DesativarCirculo = 'Esta ação irá desativar o círculo atual, desligando todos os seus atuais membros deste círculo. Deseja realmente continuar com esta ação?';
       DelContatoCirculo = 'O aluno "%s" já é o contato do círculo atual. Deseja retirar deste aluno esta função?';
       DefContatoCirculo = 'Deseja definir o aluno "%s" como contato deste círculo?';
       DelMembroCirculoEI = 'Deseja realmente excluir este membro do círculo da Escola Interna atual? ATENÇÃO: esta ação não desligará o membro do seu discipulado atual.';
       AssociarLivroDiscipulado = 'Deseja realmente associar o livro "%s" ao discipulado "%s"?';
       AlterarOrdemLivro = 'Deseja realmente alterar a ordem do livro "%s"?';
       VincularLicao = 'Deseja realmente vincular a lição "%s"  ao livro "%s"?';
       AlterarOrdemLicao = 'Deseja realmente alterar a ordem da lição "%s"?';
       DelLivroEI = 'Deseja realmente excluir este livro e todas as suas lições? ATENÇÃO: esta ação não poderá ser desfeita!';
       DelLicaoEI = 'Deseja realmente excluir esta lição? ATENÇÃO: esta ação não poderá ser desfeita!';
       DeleteTitular = 'Esta operação irá retirar a relação de titularidade do aluno atual. Deseja prosseguir com a operação?';
       DelTitularJovemTM = 'Esta operação irá retirar a relação de titularidade do jovem do TM atual. Deseja prosseguir com a operação?';
       ClearFocoCentroCusto = 'Isto irá retirar a informação sobre o foco proprietário deste centro de custo. Deseja prosseguir com a operação?';
       CaixaAbertoSair = 'Existe um caixa aberto no sistema. Ao encerrar o sistema esse caixa será automaticamente fechado. Deseja realmente encerrar o sistema?';
       InstalarTurma = 'Esta ação irá instalar a turma de instalação selecionada. Deseja prosseguir com a operação?';
       DelInstalando = 'Esta ação irá excluir permanentemente o candidato "%s" da atual turma de instalação. Deseja prosseguir com a operação?';
       DelContaBancaria = 'Deseja realmente excluir esta conta bancária? Atenção! Uma conta somente pode ser excluída caso não existam lançamentos a ela associados.';
       DesativarContaBancaria = 'Deseja realmente desativar esta conta bancária? Atenção! Uma conta bancária inativa não poderá mais ser usada para lançamentos.';
       ReativarContaBancaria = 'Deseja realmente reativar esta conta bancária?';
       ExitCaixaAberto = 'Existe um caixa aberto no momento. Não é possível desconectar a aplicação com um caixa aberto. Deseja encerrá-lo antes de desconectar?';
       ConfDelConta = 'Deseja realmente excluir a conta "%s" do plano de contas? ' +
           'ATENÇÃO! Esta operação somente poderá ser feita com sucesso caso a conta ' +
           'não esteja sendo referenciada por nenhuma transação financeira.';
       VinculeFocusToRA = 'Deseja vincular o foco "%s" à região administrativa "%s"?';
       ChangeTitularFocus = 'Atenção. Você está prestes a alterar o foco titular ' +
           'do foco selecionado. Deseja prosseguir com esta operação?';
       DeleteRa = 'Deseja realmente excluir a região administrativa selecionada?';
       ActiveFocus = 'Deseja prosseguir com a ativação do foco "%s"?';
       RemoveTitularLink = 'Confirma a operação de retirada da ligação do foco ' +
           'atual como o foco titular indicado?';
       DelMentorRA = 'Confirma a exclusão permanente do mentor de RA selecionado?';
       DeleteAddress = 'Deseja realmente apagar este endereço?';
       DeleteCity = 'Deseja realmente apagar esta cidade?';
       DeleteUF = 'Deseja realmente apagar este Estado?';
       AssuntoAlocucao = 'Deseja realmente apagar este assunto de alocução?';
       DeleteFuncao = 'Deseja realmente apagar esta função do cadastrado?';
       DeleteInfoMedica = 'Deseja realmente apagar esta informação médica do cadastrado?';
       DeleteAptidao = 'Deseja realmente apagar esta aptidão do cadastrado?';
       DeleteContato = 'Deseja realmente apagar este meio de contato?';
       DeleteFamiliar = 'Deseja realmente apagar este familiar do cadastrado?';
       ClearCirculoEI = 'Isto eliminará a informação sobre o círculo da Escola ' +
           'Interna para o qual esta atividade é destinada. Deseja prosseguir com a operação?';
       ClearLicaoEI = 'Isto eliminará a informação sobre a lição proferida nesta ' +
           'atividades da Escola Interna. Deseja prosseguir com a operação?';
       ClearAlocucao = 'Isto irá eliminar a informação sobre a alocução proferida ' +
           'nesta atividade. Deseja prosseguir com a ação?';
       ClearConferencia = 'Isto irá eliminar a vinculação desta atividade com  ' +
           'a conferência. Deseja prosseguir com a ação?';
       ClearTurmaTP = 'Isto irá eliminar a informação sobre a turma do Trabalho ' +
           'Público para a qual a atividade é destinada. Deseja prosseguir com a ação?';
       DelFuncao = 'Deseja realmente excluir este escalado para a atividade corrente?';
       DelFocoParticipante = 'Deseja realmente excluir este foco da lista de participantes da atividade?';
       DelParticipante = 'Deseja realmente excluir este discipulado da lista de ' +
           'participantes da atividade?';
       DelProgramacaoConferencia = 'Deseja realmente excluir esta atividade da ' +
           'programação da conferência selecionada? ATENÇÃO! Esta atividade não será ' +
           'excluída da agenda da atividades, mas apenas retirada da programação da ' +
           'conferência selecionada.';
       DelDispensa = 'Deseja realmente excluir esta dispensa concedida?';
       DelFocoUser = 'Deseja realmente excluir a permissão para acessar este foco?';
       DelOrgaoGestor = 'Deseja realmente excluir o órgão gestor selecionado? ' +
           'ATENÇÃO: um órgão gestor somente pode ser excluído caso não existam dados ' +
           'das gestões e membros das gestões do referido órgão gestor.';
       DelGestao = 'Deseja realmente excluir esta gestão? Atenção: somente ' +
           'gestões que não tenham membros a ela associados podem ser excluídas.';
       EndMandate = 'Esta ação irá encerrar o mandato do dirigente "%s", do ' +
            'órgão gestor "%s" na data de hoje. Deseja prosseguir com a ação?';
       DeleteBairro = 'Confirma a exclusão do bairro corrente? Atenção: esta ' +
        'operação pode tornar os dados de algunsendereços inconsistentes.';
       DeleteExternalReport = 'Deseja realmente apagar este relatório externo? ' +
         'ATENÇÃO! Ao apagar este relatório externo ele ficará completamente ' +
         'indisponível para todos os usuários!';
       Cancel = 'Confirma o cancelamento deste item? Atenção: esta ação não ' +
         'poderá ser desfeita!';
       DelServer = 'Deseja realmente excluir a conexão remota "%s"?';
       ConfCep = 'O cep fornecido parece não estar correto. Deseja prosseguir com ' +
        'a operação de escrita dos dados?';
       RemoveSubordinacaoLink = 'Confirma a operação de retirada da informação ' +
         'sobre a subordinação do órgão gestor atual?';
       DelFocus = 'ATENÇÃO: a exclusão inadivertida de ' +
         'um foco pode causar perda de informações. Por esta razão o sistema verificará ' +
         'previamente se o foco poderá ser excluído. Deseja realmente excluir o foco "%s"?';
       SubordinacaoOrgao = 'Deseja subordinar o órgão gestor "%s" ao ' +
         'órgão gestor "%s"?';
       DelDirigente = 'Atenção: você está requisitando a exclusão de um dirigente ' +
         'de um órgão gestor. Esta operação pode destruir informações importantes ' +
         'sobre este dirigente. Deseja prosseguir com a operação?';
       EndMandates = 'Esta ação irá encerrar os mandatos de todos os dirigentes ' +
         'da gestão selecionada na data de hoje. Deseja prosseguir com a ação?';
       RevokeUser = 'Retirar o usuário "%s" do grupo "%s"?';
       ReligarCadastrado = 'Deseja realmente religar o cadastrado selecionado?';
       DelFoto = 'Isto irá excluir a foto do cadastrado. Deseja prosseguir com ' +
         'a operação?';
       AnularHistorico = 'Deseja realmente anular este evento do histórico ' +
         'discipular do cadastrado? ATENÇÃO: esta ação pode trazer forte impacto na ' +
         'consistência dos dados discipulares do cadastrado.';
       ConcluirAcaoHis = 'Deseja realmente marcar como concluída esta ação do ' +
         'evento discipular?';
       ProtocoloInstalacao = 'Esta ação adicionará nos históricos dos cadastrados ' +
         'selecionados os protocolos de instalação no discipulado indicado. Deseja ' +
         'prosseguir com esta ação?';
       Instalacao = 'Esta ação irá instalar o(s) cadastrado(s) selecionado(s) no ' +
         'discipulado "%s". Deseja prosseguir com esta operação?';
       ClearTasks = 'Esta operação irá eliminar todas as tarefas cadastradas. ' +
         'Deseja prosseguir com a operação?';
       DelTask = 'Deseja realmente excluir a tarefa selecionada?';
       DelAtividade = 'Deseja realmente excluir a atividade selecionada da ' +
         'agenda de atividades?';
       DelTiposAtividades = 'Deseja realmente excluir este tipo de atividade? ' +
         'ATENÇÃO: a exclusão somente será efetuada se não existirem atividades deste ' +
         'tipo cadastradas.';
       Frequencia = 'Tipicamente, este tipo de atividade não exige a presença ' +
         'dos cadastrados. Deseja ainda assim iniciar o levantamento da freqüência ' +
         'dos cadastrados para esta atividade?';
       ConsultaCEP = 'A consulta de códigos postais na base de dados da E.C.T. ' +
         'exige o estabelecimento de uma conexão com a internet. Deseja prosseguir ' +
         'com esta operação?';
       MoverConta = 'Deseja realmente transformar a conta "%s" uma subconta de "%s"?';
       ClearFocoConta = 'Isto irá retirar a informação sobre o foco proprietário ' +
         'desta conta. Deseja prosseguir com a operação?';
       ClonarInscricoes = 'Você está prestes a copiar as inscrições da conferência modelo ' +
         '(%s) para a conferência corrente (%s). Deseja prosseguir com a operação?';
       ConfirmarAlojamento = 'Esta operação iniciará o processo de alojamento automático ' +
         'dos inscritos na conferência. Deseja prosseguir com a operação?';
   end;


   //Avisos
   TCosmosWarningMsg = class
     const
      WzNovoUsuarioStep1 = 'Os dados deste passo do assistente estão incompletos. Preencha todas as informações antes de prosseguir.';
      EmptyArgument = 'É preciso informar um argumento de pesquisa para executar ' +
       'esta operação!';
      EmptyFocus = 'É preciso informar um foco no qual será feita a pesquisa!';
      InsertKeyword = 'É necessário salvar a nova alocução antes de inserir ' +
       'as suas palavras-chave!';
      SearchFields = 'Nenhum campo de pesquisa foi definido para esta grade!';
      NoOrgaoSelcionado = 'Nenhum órgão gestor foi selecionado na lista acima!';
      IncompletedFields = 'Existem informações de preenchimento obrigatório!';
   end;

   TConverterErrorMsg = class
     const
      //Erros relacionados a conversão de dados
      StringDateConvert = '%s não é uma data válida!';
      StringTimeConvert = '%s não é uma hora válida!';
      StringIntegerConvert = '%s não é um número inteiro válido!';
   end;

   ///<summary>
   ///  Classe que ordena as mensagens de erro disparadas quando ocorrer uma falha
  ///   crítica que deve ser manipulada no evento OnReconcile dos datasets.
   ///</summary>
   TCosmosErrorReconcile = class
     const
      UnknownError = 'Ocorreu uma falaha crítica desconhecida ao tentar salvar os dados. ' +
        'Consulte os logs do servidor do Cosmos para obter mais informações. A operação será cancelada.';
      ForeignKey = 'Ocorreu uma falha crítica ao tentar salvar os dados. O sistema detectou que ' +
        'existem dados inválidos ou incompletos referentes a campos de ligação entre duas tabelas. ' +
        'A operação será cancelada.';
   end;

   ///<summary>
   ///  Classe que ordena as mensagens de erro disparadas quando ocorrer uma falha
  ///   relacionada a datanavigators.
   ///</summary>
   TCosmosErrorDataNavigators = class
     const
      UnCreatedInnerObject = 'Falha na aplicação. A fonte de dados não foi criada.';
      EInactiveInnerObject = 'Falha na aplicação. A fonte de dados não está ativa.';
   end;

   ///<summary>
   ///  Classe que ordena as mensagens de erro de caixas de diálogo.
   ///</summary>
   TCosmosErrorMsg =  class
    const
      //Mensagens técnicas de erros próprias de classes de exceção descritas na biblioteca cmlib.bpl
      sEIsNotArray = 'Os parâmetros fornececidos não estão no formato de array de variants!';
      //Protocolos, certificados e conexões.
      InvalidProtocol = 'Server Error: o protocolo de transporte configurado não é válido.';
      CertificateNotFound = 'Não foi encontrado um certificado digital para essa conexão. O uso de certificados ' +
           'digitais é requerido para esse tipo de conexão com o servidor Cosmos.';
      CertificateExpired = 'O certificado digital recebido está expirado. O período de validade para uso do certificado ' +
           'não é mais válido. A operação será encerrada.';
      CertificateNotYetValid = 'O certificado digital recebido ainda não pode ser usado. O período de validade para início ' +
           'do uso do certificado não foi alcançado. A operação será encerrada.';
      CreateMyCosmosFolder = 'Não foi possível criar seu ambiente de trabalho para a correta execução do Cosmos. A aplicação será encerrada.';
      CreateLogsFolder = 'Não foi possível criar a pasta de arquivos de logs no local: %s' + #13 + 'Verifique os arquivos de configuração do Cosmos.';
      InvalidSearchParams = 'Os parâmetros de busca desta operação são inválidos.';
      InvalidNumParams = 'O número de parâmetros chegou ao seu limite!';
      UnregisteredClass = 'Não foi possível obter uma interface para uso dos ' +
           'recursos disponíveis no módulo "%s". Relate aos administradores do Cosmos ' +
           'esta mensagem.';
      LoadDLL = 'O aplicativo não localizou a biblioteca "%s". A reinstalação ' +
           'do produto pode corrigir este erro.';
      UnknownConnectionError = 'Ocorreu um erro desconhecido ao tentar conectar-se com o servidor remoto. ' +
           'Verifique os logs do sistema para obter detalhes do erro ocorrido.';
      UnknowDataTarget = 'A fonte de dados para a escrita do resultado da pesquisa não pode ' +
           'ser encontrada. Entre em contato com o administrador do sistema.';
      InactiveDataTarget = 'A fonte de dados para a escrita do resultado da pesquisa ' +
           'está inativa. Entre em contato com o administrador do sistema.';
      IncorrectServer = 'Esta aplicação do Cosmos não pode conectar-se com este servidor. ' +
           'Verifique se as configurações atuais de endereço e porta estão corretas.';
      EmptyDataset        = 'Uma busca de dados retornou vazio. Esse resultado não é ' +
           'válido ou não pode ser processado.';
      OptionsPageNotFound = 'A página de configuração não pode ser encontrada!';
      SelectData          = 'Ocorreu um erro durante a busca dos dados para esta operação. ' +
           'Verifique se o sistema continua operando e avalie os logs do sistema.';
      LoginFailure        = 'Falha durante a tentativa de autenticação. Certifique-se de que '+
           'foram fornecidos corretamente todos os dados usados na autenticação.';
      ParamMatriculas = 'Não foram informadas as matrículas dos alunos para ' +
           'os quais serão emitidas as carteirinhas!';
      EscalaConferenciaInvalida       = 'O escalado não pode atuar nessa atividade pois não ' +
           'está inscrito para a conferência!';
      CadastradoFalecido     = 'Esta operação não pode ser finalizada pois uma ou mais ' +
           'pessoas envolvidas já estão falecidas!';
      EscalarFalecido     = 'A pessoa não pode ser escalada para a atividade pois ' +
           'já etá falecida!';
      OpenFocusUnknownModule = 'Falha remota durante a tentativa de obter os focos que o ' +
           'usuário pode acessar. Não foi possíve identificar o módulo do aplicativo ' +
           'Cosmos que solicitou a lsitagem dos focos.';
      TransferenciaMesmoFoco = 'O cadastrado já se encontra vinculado ao foco selecionado!';
      CannotOpenFileCentralPesquisaServer =  'Não foi possível obter o comando a ser executado. O arquivo ' +
           'de configuração "ServerCommands.xml" não foi encontrado.';
      CannotOpenFileCentralPesquisaUser =  'Não foi possível executar essa pesquisa. Aconteceu uma falha grave ' +
           'no servidor do Cosmos que impede a execução de pesquisas da Central de Pesquisas. ' +
           'Informe o ocorrido a um responsável pelo Cosmos.';
      CannotFindCentralPesquisaCmd = 'Não foi possível executar a pesquisa. A fonte de informação das pesquisas ' +
       'foi encontrada, mas nela não existe informação sobre a pesquisa solicitada.';
      ExecuteScript = 'Ocorreu um erro ao executar alguns comandos seqüenciais ' +
        'necessários para completar esta operação. Entre em contato com o administrador ' +
        'do sistema Cosmos.';
      ExecuteCommand = 'Ocorreu um erro ao tentar executar um comando DML no servidor de dados. A operação foi desfeita.';
      ExecuteCommandUser = 'Ocorreu um erro ao tentar salvar dados para a operação corrente. A operação foi desfeita.';
      SelectSequenceData = 'Ocorreu um erro ao tentar obter o próximo valor do ' +
        'identificador único deste novo cadastro. Informe o ocorrido a um gestor do Cosmos.';
      UnknownCosmosSearch = 'Não foi possível localizar um comando interno necessário para essa operação.';
      CadastradosSearch =  'Ocorreu um erro durante a pesquisa de cadastrados ' +
            'executada durante esta operação. Consulte os logs para obter mais informações ' +
            'sobre o problema.';
      AtualizarGruposTM =  'Ocorreu um erro durante a a atualização dos grupos do Trabalho da Mocidade.';
      GerarFrequenciaConferencia = 'Ocorreu um erro ao tentar gerar os registros ' +
            'de controle de freqüência para esta conferência. Consulte os logs para obter ' +
            'mais informações sobre este problema.';
      DadosIncompletosOperacao = 'Os dados estão incompletos. Informe todos os dados antes ' +
            'de concluir esta operação.';
      CannotFindCadastrado   = 'O cadastrado não pode ser encontrado! A operação foi cancelada.';
      UnknownFocusType       = 'Não foi possível obter os dados do novo foco do cadastrado. ' +
            'Verifique com o responsável pelo Cosmos em seu núcleo esse fato.';
      TransferenciaInvalidaAluno =  'Um aluno ou jovem da Mocidade não pode se vincular a uma sala ou ' +
            'local do Trabalho Público ou a um centro de conferência. A operação de transferência foi cancelada.';
      TransferenciaInvalidaPesquisador =  'Um pesquisador ou simpatizante não pode se vincular a um centro de conferência. '  +
            'A operação de transferência foi cancelada.';
      CadastradoDesligado =  'O cadastrado já se encontra desligado. Não é possível fazer qualquer movimentação discipular ' +
            'de pessoas que já estão desligadas.';
      ExecuteOperation  = 'Ocorre um erro inesperado ao executar esta operação. É possível que a operação ' +
            'não tenha sido concluída com sucesso e seus dados não tenham sido salvos.';
      DataObito = 'Não é possível registrar um óbito ocorrido em uma data futura! Corrija a data de óbito antes de prosseguir.';
      BatizadoCampo = 'Somente alunos do Lectorium Rosicrucianum a partir do probatório ou crianças e jovens do TM podem ser batizados!';
      BatizadoDiscipulado = 'Somente alunos que estejam no probatório ou em um discipulado posterior podem ser batizados!';
      BatizadoIdade = 'Uma pessoa somente pode ser batizada se possuir até 28 anos inteiros!';
      DBXUnknown  ='Ocorreu um erro inesperado na troca de dados com o servidor remoto. ' +
             'Acesse os logs do sistema para obter mais informações.';
      DBXNoMemory = 'Não existe memória para executar esta operação!';
      DBXConnectionFailed = 'A operação de conexão falhou. Tente novamente.';
      DBXServerMethodFailed ='A chamada a um método do servidor remoto falhou de forma inesperada. ' +
             'Consulte os logs do sistema para obter mais informações';
      DBXDeniedAuthorization ='O usuário corrente não está autorizado a acessar esta funcionalidade!';
      NoivaAusente = 'O nome da noiva ainda não foi indicado!';
      NoivoAusente = 'O nome do noivo ainda não foi indicado!';
      NumRegistroNulo = 'Um número de registro do evento deve ser fornecido para ser inserido no histórico discipular do cadastrado!';
      DescricaoHistorico = 'Uma descrição sumária a ser inserida no histórico discipular é requerida nesta operação!';
      CasarCasado = 'Um dos nubentes indicados já se encontra casado! O registro do casamento foi cancelado.';
      DiscipuladoUnselected = 'É preciso selecionar o novo discipulado antes de prosseguir com a operação!';
      MotivoUnknown = 'É preciso informar o motivo antes de prosseguir com a operação!';
      DataFutura = 'Não é possível informar uma data futura para a ocorrência dessa operação!';
      RetrogradacaoIlegal = 'Apenas alunos do Lectorium Rosicrucianum e cursistas podem ser retrogradados para outro discipulado. ' +
             'A operação foi cancelada.';
      CartaFrequenciaCampo = 'Somente alunos podem receber cartas de freqüência!';
      ReligarDescricao = 'É preciso informar o discipulado ao qual o cadastrado será religado e ' +
             'uma descrição para inserção no seu histórico discipular!';
      PasswordUpdate = 'Ocorreu uma falha durante a operação de alteração da senha do usuário %s. ' +
             'Se possível, verifique os logs do servidor para obter mais informações sobre o problema.';
      PasswordReset = 'Ocorreu uma falha durante ao tentar regerar a senha do usuário %s. ' +
             'Se possível, verifique os logs do servidor para obter mais informações sobre o problema.';
      LockUser = 'Ocorreu uma falha de sistema ao tentar bloquear um usuário. Tente novamente mais tarde.';
      AuthenticateProcess = 'Ocorreu uma falha de sistema durante o processo de autenticação do usuário ' +
             'ou em uma verificação posterior de suas credenciais de acesso.';
      DadosCadastrado = 'Ocorreu uma falha de sistema ao tentar obter os dados de um aluno, jovem, pesquisador ou simpatizante.';
      NovaTurmaTP = 'Falha durante a criação da nova turma do Trabalho Público. Consulte os logs para obter maiores informações sobre o problema.';
      CantDeleteTurmaTP = 'Não é possível excluir a turma de cursistas selecionada. Existem atividades destinadas ' +
             'à turma e outras dependências cadastradas.';
      DeleteTurmaTP = 'Ocorreu um erro ao tentar excluir uma turma do Trabalho Público. Consulte os logs para obter mais informações sobre o problema.';
      NumeroNovaTurmaTP = 'Não foi possível obter o número da nova turma do Trabalho Público';
      CadastradoJaSelecionado = 'Este cadastrado já foi selecionado previamente!';
      MembrosTurmaInstalacao = 'Não foi possível obter os membros desta turma de instalação. ' +
             'Consulte os logs para obter mais informações sobre o problema.';
     UpdateReconcile = 'O servidor detectou um conflito de conciliação de dados. É possível que algum usuário tenha alterado ' +
             'essas informações antes de você fazê-lo ou que tenha ocorrido outro tipo de conflito. Se possível, consulte ' +
             'os logs do sistema para obter os detalhes sobre o problema.';
     InitializationLogs = 'Ocorreu um erro fatal durante a inicialização do sistema. O sistema de geração de logs não pode ser criado. ' +
             'A aplicação será encerrada. Informações técnicas: AppMethod: %s.LoadLogsConfigurations';
     RequiredFields = 'Existem informações requeridas para este cadastro. Informe os dados de cada campo antes de prosseguir.';
     SystemFailure = 'Ocorreu uma falha de sistemas grave durante a execução desta operação. Se possível, consulte os logs para obter mais informações.';
     UnConfirmedNewPassword = 'A nova senha informada não pode ser confirmada. Digite a sua nova senha e confirme-a no campo de confirmação.';
     IncorrectNewPassword = 'A nova senha informada não pode ser a mesma da sua atual senha. Digite a sua nova senha e confirme-a no campo de confirmação.';
     NoneRoleToUser = 'Não foi possível identificar um perfil de acesso para você. Solicite a um administrador do Cosmos a atribuição de um perfil de acesso.';
     NoServerAvaible = 'Nenhum servidor remoto foi encontrado. Verifique nas configurações do Cosmos os endereços dos servidores que estão executando a aplicação servidora.';
     NoNetActivity = 'O sistema não detectou conectividade com a Internet ou com o servidor do Cosmos. Verifique se a sua Internet está funcionando e se a VPN do Cosmos já foi estabelecida por você.';
     AbortedConnection = 'A conexão com o servidor Cosmos que estava em curso foi abortada.';
     RefusedConnection = 'Não foi possível conectar com o servidor remoto. A conexão foi recusada ativamente.';
     LoadPhotoFromFile = 'Não foi possível exibir a foto a partir do arquivo selecionado. Selecione outro arquivo para prosseguir com a operação.';
     CreateUser = 'Ocorreu uma falha durante a operação de criação de um novo usuário. Verifique os logs para obter mais informações sobre o problema.';
     DeleteUser = 'Ocorreu uma falha ao tentar excluir um usuário. Tente novamente mais tarde.';
     GrantPermission = 'Ocorreu uma falha durante o processo de atribuição das permissões do usuário. Tente novamente mais tarde.';
     RevokePermission = 'Ocorreu uma falha durante a operação de retirada de permissões a um usuário. Tente novamente mais tarde.';
     GrantAdministrator = 'Houve uma falha de sistema ao tentar atribuir ou retirar do usuário a função de administrador do sistema. Tente novamente mais tarde.';
     UnlockUser = 'Ocorreu uma falha ao tentar desbloquear um usuário. Tente novamente mais tarde.';
     LoginAlreadyExists = 'Não é possível criar um novo usuário para esta pessoa. O login %s já é usado por outro usuário.';
     CreateUserAttributes = 'Ocorreu uma falha durante a operação de salvamento das pemissões de acesso do novo usuário. A operação não pode ser concluída.';
     AdmPrivelegies = 'Esta operação só pode ser executa por um usuário com privilégios de administração. Se você precisa continuar com o operação contacte um administrador.';
     IncorrectRoleName = 'O perfil de acesso informado não está correto. O Cosmos detectou que você não pertence ao perfil de acesso informado ou este perfil não existe.';
     PasswordNotConfirmed = 'A senha não está correta. Informe a senha e confirme-a novamente.';
     IlegalGrantUser = 'Não foi identificado o usuário para o qual os perfis seriam atribuídos ou retirados! A operação foi cancelada.';
     IlegalGrantRole = 'Não foi identificado o perfil que seria atribuído ou retirado ao usuário! A operação foi cancelada.';
     ResetPassword = 'Ocorreu uma falha ao tentar regerar uma senha temporária de usuário. A operação foi cancelada.';
     UpdateData = 'Ocorreu uma falha ao tentar salvar seus dados. A operação de salvamento foi cancelada.';

     //Conferências.
     DuplicatedAttributes = 'Já existe um classificador com a sigla fornecida. As siglas dos classificadores devem ser únicas. A operação de salvamento será cancelada.';
     DelAttribute = 'O sistema detectou um erro durante a tentativa de exclusão de um classificador. Consulte os logs para obter mais informações sobre o problema.';
     SaveAreaStaff = 'Ocorreu uma falha ao tentar executar esta operação na área de staff. A operação foi cancelada.';
     ChangeConferenceControlModel = 'Não é possível alterar o tipo de controle de freqüência de uma conferência quando o levantamento da freqüência já houver sido iniciado!';
     DelFlagInscricao = 'O sistema detectou um erro durante a tentativa de exclusão de uma informação de inscrição. Consulte os logs para obter mais informações sobre o problema.';
     CancelarInscricao = 'Ocorreu uma falha de sistema ao tentar cancelar uma inscrição para uma conferência. Contate um administrador do sistema.';
     DesalojarInscrito = 'Ocorreu uma falha ao tentar desalojar o inscrito selecionado. A operação foi cancelada.';
     ClonarAlojamento  = 'Ocorreu um erro ao tentar alojar um inscrito na conferência corrente. A operação foi cancelada.';
     InscricaoDataChegada = 'A data de chegada não pode ser posterior ao término da conferência!';
     InscricaoHoraChegadaSaida = 'A hora de chegada e saída devem ser fornecidas!';
     InscricaoDataSaida = 'A data de saída não pode ser anterior ao início da conferência!';
     AtualizarAtributosInscricoes = 'Ocorreu um erro ao tentar atualizar as informações de detalhamento das ' +
       'inscrições feitas para esta conferência. Verifique os logs para obter mais informações.';
     CantCreateReader   = 'Não foi possível ler os dados retornados pelo servidor em uma pesquisa. Se possível, consulte os logs para obter mais informações sobre a falha.';
     ImportacaoInscritosGeral = 'Ocorreu um erro ao processar a importação de inscritos. As inscrições não foram executadas com sucesso.';
     ImportacaoInscritos = 'Ocorreu um erro ao tentar ler os dados do arquivo de importação de inscritos. Verifique se o arquivo está em um formato válido.';
     CadastradoMatricula = 'Não foi possível encontrar um cadastrado com a matrícula "%s"!';
     CompareTime = 'A hora de início deve ser anterior à hora de término!';
     ChangeTarefaAreaStaff = 'Ocorreu um erro ao tentar mudar a tarefa selecionada para outra área de staff. A operação foi cancelada.';
     CantOpenFileConfigurationsAll = 'O sistema não pode encontrar o arquivo geral de configurações do sistema no caminho "%s".';
     ReadCosmosConfigurations = 'Ocorreu uma falha inesperada ao tentar acessar as configurações do sistema.';
     ReadCosmosLogsFilesPath = 'O sistema não pode detectar a pasta onde as informações de logs serão salvas. Isso pode ter ocorrido devido a eventuais problemas com um arquivo de configurações. Entre em contato com um responsável pelo sistema. A aplicação será encerrada.';
     ReadCosmosLogsFilesPathXP = 'O sistema não pode detectar a pasta onde as informações de logs devem ser salvas. Isso pode ter ocorrido devido a eventuais problemas com um arquivo de configurações. ' +
       'Em computadores executando Windows XP, o problema pode ser resolvido instalando uma versão mais recente do Internet Explorer, que atualiza bibliotecas usadas pelo Cosmos. Entre em contato com um responsável pelo sistema Cosmos. A aplicação será encerrada.';
     ExecuteLogsViewer = 'O sistema não pode abrir a ferramenta de visualização de logs do Cosmos. É provável que esse programa não tenha sido instalado ou tenha sido removido.';
     DllCalculator = 'Não foi possível executar o módulo "Calculadora". Reinstale o aplicativo para tentar corrigir o problema.';
     LoadConfigurations = 'Ocorreu uma falha de sistema ao tentar obter algumas configurações da aplicação Cosmos corrente. Informe o fato ao administrador do sistema.';
     DatabaseNotFound  = 'As configurações de conexão ao banco de dados não indicam um caminho válido para acesso ao banco de dados.';
     ExportDataSearch  = 'Ocorreu uma falha grave ao tentar exportar os dados para um arquivo. Verifique se o caminho informado está correto ou se você possui permissão para criar arquivos na pasta informada.';
     ExportDataToFile = 'Ocorreu uma falha grave ao tentar fazer a busca dos dados para serem exportados.';
     FormatParams = 'Ocorreu um erro durante a preparação dos dados dos parâmetros do relatório ou pesquisa corrente. Verifique se todos os parâmetros foram fornecidos corretamente.';
     ReportFile = 'A Central de Relatórios não conhece um arquivo de relatórios definido para este aplicativo. É impossível prosseguir.';
     IdentificaoAtiva = 'A identificação ativa falhou. Essa confirmação é necessária para a conclusão desta operação.';
     GetCommand = 'Ocorreu um erro ao tentar recuperar um comando necessários para completar esta operação. Entre em contato com o administrador do sistema Cosmos.';
     LoadWizard = 'Ocorreu uma falha ao tentar acessar o assistente. A biblioteca onde o assistente reside pode estar ausente ou apresentou algum problema. Consulte os logs do sistema para obter mais informações.';
     ExportData = 'Ocorreu uma falha ao tentar exportar dados da aplicação. A operação de exportação foi cancelada.';
     //Erros da Central de Relatórios
     ReportInfoFile = 'As informações sobre os relatórios não puderam ser obtidas. É possível que alguma configuração ou arquivo importante esteja indisponível ou inacessível. Procure um administrador do sistema e reporte esta informação.';
     ReportPhoto = 'A foto de um aluno, membro ou jovem do TM está em um formato não conhecido ou está corrompida. Insira apenas fotos no formato JPEG.';
     ReportExecute = 'Ocorreu um erro de sistema ao tentar gerar o relatório selecionado. Consulte os logs do sistema para obter mais informações sobre a falha.';
     MatriculaDuplicada = 'A matrícula %s já está em uso por uma pessoa do seu centro ou de outro. As alterações feitas serão canceladas.';
     UpdateDownload = 'Ocorreu um erro de sistema durante o download de uma atualização do sistema Cosmos. Verifique a sua conexão com a Internet.';
     EnderecosCorrespondencia = 'Somente um endereço pode ser marcado como o de ' +
       'entrega de correspondências!';
     InvalidEMail = 'O meio de contato do cadastrado não é um email!';
     GetServerDateTime = 'Ocorreu um erro ao tentar obter a data e hora no servidor ' +
       'de aplicação.';
     LoadAcessedFocus = 'Ocorreu um erro fatal ao tentar obter os focos para os quais ' +
       'você possui permissão de acesso. Consulte os logs do sistema para obter mais informações.';
     //Carregamentos/salvamento de arquivos de configuração
     LoadServerConfigFile = 'Ocorreu uma falha de sistema ao tentar obter ' +
       'as configurações das conexões com a aplicação servidora do Cosmos. Informe o fato ' +
       'ao administrador do sistema.';
     SaveServerConfigFile = 'Ocorreu uma falha de sistema ao tentar salvar ' +
       'as configurações das conexões com a aplicação servidora do Cosmos. Informe o fato ' +
       'ao administrador do sistema.';
     SaveGUIConfigurations = 'Ocorreu uma falha de sistema ao tentar salvar ' +
       'as configurações de aparência do aplicativo Cosmos. Informe o fato ' +
       'ao administrador do sistema.';
     HostNotFound = 'O servidor não pode ser acessado. Verifique se o nome ou endereço do servidor está correto ' +
       'ou se a sua conexão de rede ou internet estão disponíveis.';
     ConnectError = 'Ocorreu um erro desconhecido ao tentar conectar com o servudor do Cosmos. ' +
       'Verifique os logs para mais informações.';
     ConnectionTimeout = 'O tempo limite de estabelecimento da conexão se esgotou. Verifique se ' +
       'a sua conexão de rede ou internet estão disponíveis.';
     SocksServerGeneralError = 'Ocorreu uma falha desconhecida durante a tentativa de comunicação ' +
       'com o servidor. Verifique os logs para obter mais detalhes';
     //Cidades e estados------------------------------------------------------------
     PaisEstado = 'É necessário selecionar um país antes de escolher um estado!';
     EstadoCidade = 'É necessário selecionar um estado antes de escolher uma cidade!';
     CidadeBairro = 'É necessário selecionar uma cidade antes de escolher um bairro!';
     CepNotFount = 'O cep procurado não está cadastrado na base de dados da ECT!';
     ConsultaCEP = 'Não foi possível eatabelecer uma conexão com o webservice ' +
       'e obter uma pacote com os dados do logradouro. Talvez haja algum problema ' +
       'com a conexão com a Internet ou esta esteja inoperante.';
     FrequenciaConferenciaEmCurso = 'O levantamento de freqüência para esta conferência ' +
       'já foi feito. Agora você poderá alterar os dados já trabalhados anteriormente.';
     //Gestões e dirigentes--------------------------------------------------------
     DatasGestao = 'A data de início da gestão não pode ser igual ou superior ' +
       'à data de término. A operação será cancelada.';
     //Validação de cadastros-------------------------------------------------------
     MensalidadeNula = 'É necessário informar o valor da mensalidade!';
     TaxaConferenciaNula = 'É necessário informar o valor da taxa de conferêcnia!';
     DiscipuladoTMBNulo = 'É necessário informar em qual discipulado do ' +
       'Trabalho de Membros o cadastrado será instalado!';
     ProfissaoTMBNulo = 'É necessário informar a profissão do instalando!';
     EstadoCivilTMBNulo = 'É necessário informar o estado civil do instalando!';
     //Relatóricos Externos
     ExternalReportNotFound = 'O relatório externo "%s", situado no arquivo %s ' +
       'não pode ser executado porque o arquivo mencionado não pode ser encontrado.';
     PrivilegioFocoCadastrado = 'O usuário selecionado já possui privilégio ' +
       'de acesso ao foco indicado!';

     FaixaGruposTM = 'O cadastrado não possui idade para fazer parte do TM ou ' +
       'a data informada está incorreta.';
     UpdateLogFile = 'Se você deseja registrar logs do processo de atualização, ' +
       'é necessário informar o local e o nome do arquivo de log.';
     LinkFocos = 'Ocorreu um erro ao tentar salvar os focos com os quais o novo ' +
       'usuário poderá trabalhar. Verifique se o usuário foi criado e examine a lista '+
       'de focos a ele associada.';

     //Erros que ocorrem quando do registro de eventos no histórico discipular
     ErrorBatizado = 'Ocorreu uma falha de sistema durante o registro do batismo. ' +
       'Verifique se os dados do batismo foram inseridos corretamente no histórico discipular.';
     ReligarCadastradoInexistente = 'Não foi possível localizar o cadastrado para ' +
       'executar o religamento! A operação foi cancelada.';
     ReligarCadastradoFalecido = 'O cadastrado que seria religado já se encontra ' +
       'falecido! O religamento foi cancelado.';
     //Tasks
     LoadTaskFile = 'Ocorreu uma falha durante a leitura do arquivo de tarefas. ' +
       'Os dados podem ter sido corrompidos. O sistema criará um novo arquivo de tarefas.';
     ReadReportParams = 'Ocorreu uma falha inesperada na leitura dos últimos ' +
       'valores usados na geração deste relatório. Apesar deste problema, você poderá ' +
       'gerar o relatório normalmente.';
     ReportDataError = 'Ocorreu um erro ao tentar gerar os dados de um relatório. O código de ' +
      'tratamento de busca de dados do relatório não foi encontrado.';

     ConferenciaModelo = 'A conferência modelo selecionada é a mesma da conferência ' +
       'corrente. Para importar os inscritos da conferência modelo para a corrente ' +
       'você precisa selecionar outra conferência modelo.';
     CentralPesquisaInfoFile = 'As informações sobre as pesquisas não puderam ser ' +
       'obtidas. É possível que alguma configuração ou arquivo importante esteja ' +
       'indisponível ou inacessível. Procure um administrador do sistema e reporte ' +
       'esta informação.';

     //Outros------------------------------------------------------------
     ErrorDatas = 'A data inicial não pode ser posterior à data final!';
     CadastradoEI = 'O aluno selecionado pertence à Escola Interna. Esta ' +
       'operação somente pode ser executada por usuários que possuem direitos de ' +
       'acesso aos dados da Escola Interna.';

   end;


   TCosmosErrorSecurityMsg = class
     const
      UsuarioExists = 'Não é possível criar um novo usuário com este login, pois ele já é utilizado por outro usuário. Altere o login e repita a operação.';
      UnknownProfile = 'Não foi possível identificar o perfil "%s", atribuído na criação do novo usuário. Toda a operação foi desfeita.';
      //Mensagens relacionadas à autenticação
      BlockedUser = 'O sistema detectou que você está impedido de acessar as aplicações Cosmos. Procure um administrador do sistema Cosmos para obter mais informações.';
      UnknowUser = 'Não foi possível identificar os dados do usuário %s. A aplicação servidora do Cosmos pode ter registrado uma exceção. Procure um administrador do sistema Cosmos para obter mais informações.';
      SyncProcessing = 'O banco de dados encontra-se atualmente em estado de sincronização. Não é possível utilizar qualquer aplicativo da suite Cosmos quando o banco de dados está em estado de sincronização. Tente logar novamente dentro de alguns minutos.';
      ActivatedUser = 'A ativação do usuário %s nesta instalação do Cosmos foi feita com sucesso. Execute novamente a operação de login para acessar o sistema.';
      LoginSystemFailure = 'Ocorreu um erro de sistema durante a autenticação. Tente novamente.';
      SysdbaLoginFailure = 'Este aplicativo não pode ser acessado pelo usuário administrador do banco de dados. A conexão será cancelada.';
      UnknownUser = 'O usuário não pode ser identificado corretamente. É possível que o usuário não esteja cadastrado ou autorizado a usar o sistema. Procure um administrador do sistema para obter suporte ou consulte a ajuda do Cosmos.';
      AdmTool = 'Tentativa de acesso negada. Somente usuários que possuem privilégios de administradores podem acessar esta ferramenta!';
      AdmOnly = 'Somente os administradores do sistema estão autorizados a acessar este recurso. Peça o suporte de um usuário administrador.';
      AcessoDadoEI = 'Somente usuários autorizados a lidar com informações referentes à Escola Interna podem acessar este recurso!';
      PasswordRequired = 'É preciso informar a sua senha atual para executar esta operação.';
      NewPasswordRequired = 'É preciso informar a nova senha para executar esta operação.';
      UserNameRequired = 'É preciso informar o seu login para executar esta operação!';
      //Gestão de usuários
      ActivateUser = 'Ocorreu uma falha durante o processo de ativação do usuário. Consulte um administrador do sistema Cosmos para obter mais informações sobre o problema.';
      SelectUserRoles = 'Ocorreu uma falha ao tentar recuperar o grupo do usuário. Tente novamente mais tarde.';
      Grants = 'Ocorreu uma falha durante a operação de concessão de permissões a um usuário. Tente novamente mais tarde.';
      UserNotFound = 'Não foi possível encontrar o usuário selecionado na base de usuários. A operação foi cancelada.';
      DelFailure = 'Houve uma falha de sistema ao tentar excluir o usuário corrente. Tente novamente mais tarde.';
      SQLServerUserExists = 'O login %s já se encontra em uso por outro usuário. A criação da nova conta de acesso foi cancelada.';
      SetUserProfile = 'Ocorreu uma falha durante a operação de definição de um perfil para o usuário. Verifique os logs para obter mais informações sobre o problema.';
      UserDataNotFound = 'Não foram encontradas informações sobre este usuário!';
   end;



   //Mensagens de erro específicas do módulo "secretarias".
   TCosmosErrorSecMsg = class
     const
      CalcularCandidatos = 'Ocorreu um erro durante a busca pelos candidados a membros da nova turma de instalação. A seleção dos candidatos deverá ser feita manualmente.';
      DuplicateCandidato = 'O candidato selecionado na pesquisa já se encontra na lista de candidatos da turma de instalação!';
      CreateTurmaInstalacao = 'Ocorreu uma falha durante a criação da nova turma de instalação. Entre em contato com o administrador do sistema Cosmos.';
      InstalarTurmaAluno   = 'Ocorreu um erro durante a instalação de uma turma de alunos. A turma não pode ser instalada. Verifique os logs para obter mais informações.';
      TurmaInstalada = 'A turma selecionada já se encontra instalada!';
      NumeroTurmaInstalacao = 'Ocorreu uma falha ao tentar calcular o número da nova turma de instalação. Entre em contato com o administrador do sistema Cosmos.';
      DelMembroTurmaInstalacao = 'Ocorreu uma falha ao tentar excluir o membro da turma de instalação selecionado. Entre em contato com o administrador do sistema Cosmos.';
      InstalacaoInvalida = 'A instalação de um ou mais membros da turma de instalação não é válida. O candidato pode estar em um discipulado posterior ao da instalação ou estar inativo.';
      NovoInstalando = 'Ocorreu um erro ao tentar adicionar um novo membro desta turma de instalação. Entre em contato com o administrador do sistema Cosmos.';
      AnularHistorico = 'Ocorreu uma falha na tentativa de anular o histórico discipular. Consulte os logs para obter mais informações sobre o problema.';
      NovaMatricula = 'Ocorreu uma falha ao tentar gerar um número de matrícula para o cadastrado. Consulte os logs para obter mais informações sobre o problema.';
      CantDeleteLessonEI = 'Não é possível excluir esta lição da Escola Interna. A lição já foi ou está sendo utilizadas por um ou mais círculos do campo de trabalho brasileiro.';
      DeleteLessonEI = 'Ocorreu um erro durante a exclusão de uma lição da Escola Interna. Entre em contato com um responsável pelo sistema Cosmos.';
      ReorderBookEI = 'Ocorreu uma falha durante a reordenação dos livros da Escola Interna! Consulte os logs para obter informações sobre a natureza da falha.';
      ReorderLessonEI = 'Ocorreu uma falha durante a reordenação de lições da Escola Interna! Consulte os logs para obter informações sobre a natureza da falha.';
      CantDeleteBookEI = 'Não é possível excluir este livro da Escola Interna. O livro possui lições que já foram ou estão sendo utilizadas por um ou mais círculos do campo de trabalho brasileiro.';
      DeleteBookEI = 'Ocorreu um erro durante a exclusão de um livro da Escola Interna. Entre em contato com um responsável pelo sistema Cosmos.';
      NovoCirculoEI = 'Falha durante a criação do novo círculo da Escola Interna. Consulte os logs para obter maiores informações sobre o problema.';
      DesativarCirculoEI = 'Ocorreu um erro ao tentar desativar um círculo da Escola Interna. Consulte os logs para obter maiores informações sobre o problema.';
      DelAtividades = 'Não é possível excluir esta atividade, pois existem informações relacionadas a ela que seriam perdidas!';
      LimparFrequencia = 'Não foi possível concluir a tarefa de limpeza de controle de freqüência para a atividade selecionada. Consulte os logs para obter mais informações sobre o problema.';
      DuplicatedMembroCirculoEI = 'Um ou mais membros do círculo já estão vinculados a outro círculo da Escola Interna deste ou de outro foco. Um aluno somente pode estar vinculado a um círculo.';
      AutoTitular = 'O cadastrado não pode ser titular de si mesmo!';
      SavePhoto = 'Ocorreu uma falha ao tentar salva a foto de um aluno, pesquisador ou jovem do TM. Verifique nos logs do sistema as informações sobre a falha ocorrida.';
      LoadPhoto = 'Erro ao tentar obter a foto de um aluno, pesquisador ou jovem do TM. O erro pode acontecer ao tentar ler a foto de um arquivo com um tipo de formato não suportado ou que está corrompido. Verifique nos logs do sistema as informações sobre a falha ocorrida.';
      EncerrarTurmaTP = 'Ocorreu um erro ao tentar encerrar uma turma do Trabalho Público. Se possível, consulte os logs do servidor para obter mais informações sobre o erro.';
      ReativarTurmaTP = 'Ocorreu um erro ao tentar reativar uma turma do Trabalho Público. Se possível, consulte os logs do servidor para obter mais informações sobre o erro.';
      TurmaEI = 'Esta é uma turma de instalação de um discipulado da Escola Interna. Apenas usuários com privilégios de acesso aos dados da Escola Interna podem executar esta operação.';
      AddDelInstalandos = 'Não é possível adicionar ou remover instalandos ou alterar dados de protocolo de instalação de uma turma que já foi instalada! A operação será cancelada.';
      DelTiposAtividades = 'Existem referências a atividades deste tipo na agenda nacional de atividades. É impossível excluir um tipo de atividade que já tenha sido referenciado na agenda de atividades.';
      CarteirinhaInstalandos = 'Somente é possível emitir a carteirinha dos alunos de uma turma que já foi instalada.';
      TipoAtividadeLR = 'Você não está autorizado a cadastrar tipos de atividades ' +
         'promovidas pelo Lectorium Rosicrucianum.';
      TipoAtividadeTM = 'Você não está autorizado a cadastrar tipos de atividades ' +
         'promovidas pelo Trabalho da Mocidade.';
      TipoAtividadeTMB = 'Você não está autorizado a cadastrar tipos de atividades ' +
         'promovidas pelo Trabalho de Membros.';
      TipoAtividadeTP = 'Você não está autorizado a cadastrar tipos de atividades ' +
         'promovidas pelo Trabalho Público.';
      TipoAtividadeSIM = 'Você não está autorizado a cadastrar tipos de atividades ' +
         'promovidas pelo trabalho de simpatizantes.';
      TipoAtividadeEI = 'Você não está autorizado a cadastrar tipos de atividades ' +
         'promovidas pela Escola Interna.';
      LoadPhotoPupil = 'A foto de um aluno, membro ou jovem do TM não pode ser exibida. ' +
         'Talvez tenha ocorrido uma falha na comunicação com o servidor do Cosmos ou a ' +
         'foto está corrompida.';
      DirigenteExists = 'O dirigente "%s" já se encontra vinculado a esta gestão!';
   end;


   //Mensagens de erro específicas do módulo "financeiro".
   TCosmosErrorFinMsg = class
     const
       DeleteContaBancariaEmUso = 'Não é possível excluir a conta bancária porque existem lançamentos associados a ela.';
       DeleteContaSubcontas = 'A exclusão da conta foi cancelada. Existem outras contas vinculada a esta conta. Tente excluir todas as subcontas antes de excluir a conta selecionada.';
       DeleteContasUsadas = 'A exclusão da conta foi cancelada. Esta conta está sendo usada no momento e existem informações de lançamentos financeiros associadas à conta.';
       DesativaContasBancaria = 'Ocorreu uma falha ao tentar desativar uma conta bancária. Tente novamente mais tarde.';
       ReativaContasBancaria = 'Ocorreu uma falha ao tentar reativar uma conta bancária. Tente novamente mais tarde.';
       DeleteConta = 'A exclusão da conta foi cancelada. Ocorreu um erro desconhecido durante a operação.';
       MoveConta = 'Não foi possível alterar a conta desejada do Plano de Contas. O sistema registrou uma falha inesperada.';
       CaixaNovo = 'Ocorreu um erro inesperado ao tentar abrir um novo caixa para o usuário "%s". Tente novamente.';
       CaixaFechar = 'Ocorreu um erro inesperado ao tentar fechar um caixa para o usuário "%s". Tente novamente.';
   end;

   //Mensagens de erro específicas do módulo "conferências".
   TCosmosErrorConfMsg = class
     const
       CantClearConf = 'Não é possível limpar todos os registros de freqüência de uma conferência!';
   end;

   //Mensagens de erro específicas do módulo "usuários".
   TCosmosErrorUsuMsg = class
     const
       s = '';
   end;

   //Mensagens de erro específicas do módulo "focos".
   TCosmosErrorFocMsg = class
     const
       RenameRa = 'Ocorreu uma falha de sistema ao tentar renomear uma região administrativa. ' +
         'Tente novamente. Caso o erro persista, peça a alguém para examinar os logs do servidor.';
       MoveRa = 'Ocorreu uma falha de sistema ao tentar mover uma região administrativa. ' +
         'Tente novamente. Caso o erro persista, peça a alguém para examinar os logs do servidor.';
       DeleteRa = 'Ocorreu uma falaha de sistema ao tentar excluir a região administrativa selecionada.';
       CannotDeleteRa = 'Existem focos ou subregiões ligadas a esta subregião. A exclusão foi cancelada.';
       CreateRA = 'Ocorreu um erro ao tentar criar uma nova Região Administrativa. ' +
         'Consulte os logs do servidor para obter mais informações. A operação foi cancelada.';
       DesactiveFoco = 'Não foi possível desativar o foco.';
       FocoDoadorInexiste = 'O foco que está sendo desativado não pode ser encontrado. A operação foi cancelada.';
       FocoRecebedorInexiste = 'O foco que receberá as pessoas ligadas ao foco em desativação não pode ser encontrado. A operação foi cancelada.';
       CannotDeleteFoco = 'Ocorreu uma falha de sistema ao tentar excluir um foco. A operação foi cancelada.';
       CannotDeleteFocoHistorico = 'Não é possível excluir o foco! Existem informações no histórico discipular vinculadas ao foco.';
       CannotDeleteFocoCadastrados = 'O foco não pode ser excluído, pois existem cadastrados a ele ligados.';
       CreateFocoDuplicado = 'Já existe um foco cadastrado com o mesmo nome do ' +
         'foco que você está tentando criar. A operação foi cancelada.';
       CreateFoco = 'Ocorreu uma falha durante o processo de criação do novo ' +
         'foco no servidor remoto. A operação não foi concluída com sucesso. Consulte ' +
         'os logs do servidor remoto para obter informações detalhadas sobre a falha.';
       CannotFindID = 'Erro: Não foi possível determinar o identificador único do ítem selecionado.';
       MoveFocoRa = 'Não foi possível alterar a vinculação deste foco para uma nova região administrativa. ' +
         'Ocorreu uma falha de sistema. Tente novamente.';
       ChangeFocusParent = 'Ocorreu um erro de sistema ao tentar mudar o foco titular de outro foco. Conulte ' +
         'os logs do servidor remoto para obter informações detalhadas sobre a falha.';
       ChangeFocusStatus = 'Ocorreu um erro de sistema ao tentar ativar ou desativar um foco. Conulte ' +
         'os logs do servidor remoto para obter informações detalhadas sobre a falha.';
       NoTargetFocus = 'Nenhum foco foi definido como receptor dos cadastrados ' +
         'a serem transferidos!';
       SameTargetFocus = 'O foco definido como receptor dos cadastrados é o ' +
         'mesmo que deve ser desativado! É impossível prosseguir com a operação.';
       LengthSiglaFoco = 'A sigla do foco deve possuir 3 letras maiúsculas!';
   end;

 //Erros relacionados a relatórios.-----------------------------------
   TCosmosReportsError = class
     const
       ParamDatasAtividade = 'É preciso informar a data de início e término ' +
         'que será usada para pesquisar a agenda de atividades!';
       ParamAno = 'É preciso informar o ano para que o relatório selecionado ' +
         'seja gerado!';
       ParamCirculoEI = 'É preciso informar um círculo da Escola Interna para ' +
         'que o relatório selecionado seja gerado!';
       ParamMatriculaLEC = 'É preciso informar a matrícula do aluno para ' +
         'gerar o relatório selecionado!';
       ParamMatriculaTM = 'É preciso informar a matrícula do jovem do TM para ' +
         'que o relatório selecionado seja gerado!';
       ParamMatriculaTMB = 'É preciso informar a matrícula do membro para ' +
         'que o relatório selecionado seja gerado!';
       ParamMatriculaTP = 'É preciso informar a matrícula do pesquisador ou ' +
         'cursista para que o relatório selecionado seja gerado!';
       ParamMatricula = 'É preciso informar a matrícula do cadastrado para ' +
         'gerar o relatório selecionado!';
       ParamAtividade = 'É preciso informar uma atividade para gerar o ' +
         'relatório selecionado!';
   end;

   TCosmosMiscellaneous = class
     const
      //Nomes dos meses
      JAN = 'Janeiro';
      FEV = 'Fevereiro';
      MAR = 'Março';
      ABR = 'Abril';
      MAI = 'Maio';
      JUN = 'Junho';
      JUL = 'Julho';
      AGO = 'Agosto';
      SETM = 'Setembro';
      OUTU = 'Outubro';
      NOV = 'Novembro';
      DEZ = 'Dezembro';
      //Versão de arquivo desconhecida (ferramenta "módulos do sistema").
      UnknowVersionFile = '-';
      Nacionalidade = 'Brasileira';
      Residencial = 'Residencial';
      Gestao = 'Gestão';
      OrgaoGestor = 'Órgão Gestor';
      MembroOrgao = 'Membro de Órgão Gestor';
      Unknown  = 'Desconhecido';
      ReceiptsDataList = '"[Contribuinte]";"[Valor da contribuição]";"[Valor (extenso)]";"[Data do recebimento]";"[Foco recebedor]"';
   end;



implementation

end.

