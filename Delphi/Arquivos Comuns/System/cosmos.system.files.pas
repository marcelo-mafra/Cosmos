unit cosmos.system.files;

interface

uses Winapi.Windows;


 type
  //Conexão
  TConnectionsConst = class
    const
     TCP = 'TCP/IP';
     HTTP = 'HTTP';
     HTTPS = 'HTTPS';
  end;

  //Caminhos da registry do windows.
  TRegistryPaths = class
    const
     LocalMachineKey = HKEY_LOCAL_MACHINE;
     CurrentUserKey = HKEY_CURRENT_USER;
     AllUsersKey = HKEY_USERS;
     RegRoot = 'software\Lectorium Rosicrucianum\Cosmos\3.5';
     CosmosOptions = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Opcoes';
     GFocosOptions = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Focos Manager\Opcoes';
     SecretariasOptions = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Secretarias\Opcoes';
     FinanceiroOptions = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Financeiro\Opcoes';
     UsuariosOptions = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Usuarios\Opcoes';
     ConferenciasOptions = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Conferencias\Opcoes';
     RootUpdates = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Updates';
     MailTool = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Cosmos\Opcoes\MailTool';
     Searchs = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Cosmos\Opcoes\Searchs';
     Windows = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Cosmos\Opcoes\Janelas';
     Logs = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Cosmos\Opcoes\Logs';
     Messages = 'software\Lectorium Rosicrucianum\Cosmos\3.5\Cosmos\Opcoes\Messages';
  end;

  //Pastas de sistema usadas pelo Cosmos.
  TCosmosPaths = class
    const
      FocosReportsFolder = 'Focos';
      SecretariasReportsFolder = 'Secretarias';
      FinanceiroReportsFolder = 'Financeiro';
      UsuariosReportsFolder = 'Usuarios';
      ConferenciasReportsFolder = 'Conferencias';
      //Pastas do sistema
      CommonCosmosPath = '\Lectorium Rosicrucianum\Cosmos\3.5\';  //do not localize!
      UpdatesPath = 'Updates\';  //do not localize!
  end;

  //Arquivos usados pelo Cosmos, tais como arquivos de relatórios, dicas etc.
  TCosmosFiles = class
    const
     //Executáveis do sistema
     LogsReader = 'logrdr.exe';
     //Arquivo de versão de tabelas buferizadas.
     BufTab = 'buftab.info';
     //Relatórios
     FocosReportFile = 'gfocos.rav';
     SecretariasReportFile = 'gsec.rav';
     FinanceiroReportFile = 'gfin.rav';
     UsuariosReportFile = 'gusers.rav';
     ConferenciasReportFile = 'gconf.rav';
     //Arquivos de dicas (tips)
     TipsSecretarias = 'gsec.tips';//Arquivo de dicas do Gestor de Secretarias
     TipsGFocos = 'gfocos.tips';//Arquivo de dicas do Gestor de Focos
     TipsFinanceiro = 'gfin.tips';//Arquivo de dicas do Gestor de Secretarias
     TipsGUsuarios = 'gusers.tips';//Arquivo de dicas do Gestor de Focos
     TipsGConferencias = 'gconf.tips';//Arquivo de dicas do Gestor de Conferências
     ToolsGFocos = 'gfocos.tools';
     ToolsSecretarias = 'gsec.tools';
     ToolsFinanceiro  = 'gfin.tools';
     ToolsConferencias = 'gconf.tools';
     ToolsUsuarios = 'gusers.tools';
     ReportsParamsValues  = 'reports.conf';
     //Filtros de caixas de diálogo para seleção de arquivos.
     ExcelFilter = 'Arquivos Excel (*.xlsx)|*.xlsx';
     XmlFilter = 'Arquivos XML (*.xml)|*.xml';
     CsvFilter = 'Arquivos CSV (*.csv)|*.csv';
     DocFilter = 'Documentos do MSWord (*.docx)|*.docx';
     HTMLFilter = 'Arquivos HTML (*.htm, *.html)|*.htm; *.html';
     TXTFilter = 'Arquivos Texto (*.txt)|*.txt';
     OpenOfficeFilter = 'Arquivos ODT (*.odt)|*.odt';
     //Arquivos buferizados
     BufAptidoes = 'aptidoes.buf';
     BufCargos = 'cargos.buf';
     BufDiscipulados = 'discipulados.buf';
     BufEnfermidades = 'enfermidades.buf';
     BufFuncoes = 'funcoes.buf';
     BufMentors = 'viw_mentores_ra.buf';
     BufFocos = 'focos.buf';
     BufEnderecosFocos = 'viw_enderecos_focos.buf';
     BufDirecoes = 'direcoes.buf';
     BufExternalReports = 'extreports.buf';
     BufPerfis = 'perfis.buf';
     BufProfissoes = 'profissoes.buf';
     SiglasEventos = 'siglas_eventos.buf';
     BufTiposEventos = 'tipos_eventos.buf';
     //Arquivos de tarefas
     TaskFile = '%s.tasks';
     //Arquivos do sistema de ajuda.
     HelpFileFocos = 'gfocos.chm';
     HelpFileSecretarias = 'gsec.chm';
     HelpFileFinanceiro = 'gfin.chm';
     HelpFileUsuarios = 'gusers.chm';
     HelpFileConferencias = 'gconf.chm';
     ManualCosmos = 'Cosmos.pdf'; //do not localize!
     //Arquivos de configuração
     ConfigFormsInfo  = 'FormsInfo.xml';
     ConfigCentralPesquisas = 'CentralPesquisa.xml';
     ConfigUserDefault = 'ConfigurationsUsers(Default).xml';
     ConfigUser = 'ConfigurationsUsers.xml';
     ConfigFolders =  'CosmosFolders.ini';
     ConfigReportsParams = 'ReportsParams.xml';
     CosmosRoot = 'CosmosRoot.ini';
     dbxconnections = 'dbxconnections.ini';
     RolesPermissions = 'RolesPermissions.xml';
     FieldsInfo = 'FieldsInfo.xml';
     ReportsParams = 'ReportsParams.xml';
     CentralPesquisas = 'CentralPesquisas.xml';
  end;

  TFilesExtensions = class
    const
     CSV = 'csv';
     DOCX = 'docx';
     HTM = 'htm';
     ODT = 'odt';
     TXT = 'txt';
     XLSX = 'xlsx';
     XML = 'xml';
  end;

 //Chaves de criptografia.
  TCosmosCriptography = class
    const
      EKey = '8517536429'; //do not localize!
      CipherKey = '8954605'; //do not localize!
  end;


implementation

end.

