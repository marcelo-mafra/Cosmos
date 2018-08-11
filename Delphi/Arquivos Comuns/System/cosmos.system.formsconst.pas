unit cosmos.system.formsconst;

interface

uses Windows;

type
  //Descrição dos formulários embutidos (TDockedForm);
  TDockedFormDesc = class
    const
     FormAlunos = 'Janela principal de manipulação dos dados cadastrais dos ' +
       'alunos do Lectorium Rosicrucianum.';
     FormAlocucoes = 'Disponibiliza recursos para cadastro de alocuções.';
     FormTurmasTP = 'Janela principal de manipulação dos dados das turmas de ' +
       'cursistas do Trabalho Público.';
     FormCirculosEI = 'Janela principal de manipulação de dados dos círculos ' +
       'da Escola Interna e seus membros.';
     FormAgendaAtividades = 'Disponibiliza recursos para manipulação da agenda ' +
       'de atividades promovidas por todo o campo de trabalho.';
     FormAlojamentos = 'Disponibiliza recursos para a gestão dos alojamentos ' +
       'dos Centros de Conferência.';
     FormClassificadores = 'Disponibiliza o cadastro geral de classificadores de leitos ' +
       'dos alojamentos.';
     FormTabAcessorias = 'Disponibiliza recursos para a edição de dados ' +
       'acessórios.';
     FormHistorico = 'Disponibiliza recursos para a análise do histórico ' +
       'discipular de um aluno, jovem do TM, membro ou pesquisador.';
     FormControleFrequencia = 'Disponibiliza recursos para o controle da ' +
       'freqüência dos cadastrados nas atividades promovidas.';
     FormLivrosLicoesEI = 'Disponibiliza recursos para cadastro de ' +
       'referências a livros e lições da Escola Interna.';
     FormPesquisadoresTP = 'Disponibiliza recursos para trabalho com ' +
       'informações sobre pesquisadores do Trabalho Público.';
     FormTarefas = 'Disponibiliza recursos para agendamento de tarefas a ' +
       'se executar.';
     FormMessages = 'Disponibiliza recursos para envio de mensagens a outros ' +
       'usuários do Cosmos.';
     FormInscricoes = 'Disponibiliza recursos para a inscrição em conferências.';
     FormDetalhamentoInscricoes = 'Disponibiliza recursos para cadastro de itens ' +
       'de detalhamento de inscrições em conferências.';
     FormTM = 'Janela principal de manipulação dos dados cadastrais das ' +
       'crianças e jovens do Trabalho da Mocidade.';
     FormTMB = 'Janela principal de manipulação dos dados cadastrais dos ' +
       'membros do Trabalho da Membros.';
     FormInstalacoes = 'Disponibiliza informações sobre turmas de instalandos.';
     FormConferencias = 'Disponibiliza os recursos para a criação de conferências ' +
       'e a montagem da sua programação.';
     FormCosmosUsers = 'Disponibiliza os recursos para a gestão de informações ' +
       'sobre os usuários dos aplicativos Cosmos.';
     FormPlanoContas = 'Disponibiliza os recursos de cadastro de contas no ' +
       'plano de contas nacional da Escola Internacional da Rosacruz Áurea.';
     FormRecebimentos = 'Disponibiliza os recursos de registro de recebimentos de ' +
        'mensalidades e outros valores de pessoas vinculadas à Escola Internacional ' +
        'da Rosacruz Áurea.';
     FormCentroCustos = 'Disponibiliza informações sobre os centros de custos ' +
        'usados nas transações financeiras.';
     FormSimpatizantes = 'Disponibiliza informações sobre simpatizantes do ' +
        'Trabalho Público.';
     FormTransacoes = 'Disponibiliza informações sobre transações de crédito e ' +
        'débito.';
     FormMailTool = 'Ferramenta para envio de correio eletrônico para alunos, ' +
        'jovens, membros e pesquisadores.';
     FormPerfis = 'Ferramenta para a configuração dos direitos dos perfis de ' +
        'usuários do Cosmos.';
     FormAreasStaff = 'Disponibiliza recursos para o cadastro de áreas de staff ' +
        'do Centro de Conferências.';
     FormStaff = 'Disponibiliza informações sobre o staff que atua em uma ' +
        'conferências.';
     FormCentralPesquisas = 'Disponibiliza recursos de pesquisas para todas as ' +
        'aplicações Cosmos.';
     FormUpdatesHistoric = 'Disponibiliza informações sobre as atualizações feitas ' +
        'nos aplicativos Cosmos.';
     FormFocos = 'Disponibiliza o cadastro de focos e regiões administrativas.';
     FormOrgaosGestores = 'Disponibiliza o cadastro de órgãos gestores.';
  end;

  TVersionInfo = class
    const
      VendorName = 'Vendedor: %s';
      CalculatorTitle = 'Calculadora';
      EXE = 'Executável';
      DLL = 'Biblioteca';
      BPL = 'Extensão de aplicativo';
      Unknown = 'Desconhecido';
      Descricao = 'Descrição';
      FileVersion = 'Versão do Arquivo';
      ModuleCount = 'Total de módulos: %d';
  end;

//------Descrições de páginas de configuração----------------------------
  TConfigurationPagesDesc = class
    const
      ConfGerais = 'Configurações diversas, válidas para todas as aplicações ' +
        'do Cosmos.';
      ConfConexoes = 'Configurações relativas às conexões estabelecidas com o ' +
        'servidor remoto, tais como protocolos de conexão, endereço do servidor etc.';
      ConfSistema = 'Configurações relativas ao funcionamento do sistema, tais como ' +
        'a aparência de elementos da tela, formato da ajuda instantânea e logs do Cosmos.';
      ConfMessages = 'Configurações relativas à ferramenta de envio e recebimento ' +
        'de mensagens do Cosmos.';
      ConfReceiptOptions = 'Configurações necessárias para a impressão de recibos ' +
        'de recebimentos aceitos pela Tesouraria.';
      ConfMatriculasOptions = 'Configurações necessárias para a geração de novas ' +
        'matrículas no Cosmos Gestor de Secretarias.';
      ConfConnectionsPool = 'Configurações do pool de conexões das aplicações Cosmos. ';
  end;


implementation

end.
