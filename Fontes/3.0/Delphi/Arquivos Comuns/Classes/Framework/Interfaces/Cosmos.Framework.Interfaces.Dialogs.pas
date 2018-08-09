unit Cosmos.Framework.Interfaces.Dialogs;

interface

uses cosmos.system.types, cosmos.classes.application, Vcl.Controls,
Vcl.Forms, Data.DB, Vcl.Graphics, cosmos.classes.ServerInterface,
cosmos.classes.security, Cosmos.Framework.Interfaces.Root, cosmos.business.focos;

 type
  TSexoCadastrado = (scFeminino, scMasculino, scTodos);

  TStatusCadastrado = (scAtivo, scInativo, scQualquer);

  TVisaoPlanoContas = (vpHierarquico, vpTabular);

  TExecutionMode = (emSelectData, emUnselectData);

  TPageInfo = record
    CodePage: string;
    PageTitle: TCaption;
    PageDesc: TCaption;
    PageTreeRoot: string;
    PageTreeItem: string;
    PageIndex: integer;
    PageImage: TBitmap;
    HelpFile: string;
    HelpContext: integer;
  end;

  ICosmosFormsInfo = interface(ICosmosInterfaces)
   ['{DBE983F7-ADD4-4F2B-94F8-52AF634B068D}']

   procedure SaveFormInfo(Sender: TCustomForm);
   procedure LoadFormInfo;
  end;

  IRegisterInfo = interface(ICosmosInterfaces)
   ['{CAC9D10C-29E2-4D83-8BC1-F1F59E00EC45}']

   function IsRegistered(Module: TCosmosModules): boolean;
   procedure ShowRegisterForm(Module: TCosmosModules);
  end;


 //Interface usada por todos os assistentes dos aplicativos da suíte Cosmos.
  ICosmosWizard = interface(ICosmosInterfaces)
  ['{84B1835B-8AC8-48AE-BD37-031C27D4BE12}']

   function GetWizardName: string;
   property WizardName: string read GetWizardName;
   function Execute: boolean; overload;
   function Execute(Data: TCosmosData): boolean; overload;
  end;

  //Interface usada para acessar a janela de login
  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosLogin = interface
   ['{68EAA0B0-0B1A-4243-BEA9-4C418BD88A18}']
   function GetXPStyle: boolean;
   procedure SetXPStyle(value: boolean);

   function Login(var UserName, Password: string): boolean;
   function LoginDefaultRole(var UserName, Password: string; const RoleName: string): boolean;
   function LoginDefaultUser(var Password: string; const UserName, RoleName: string): boolean;
   property XPStyle: boolean read GetXPStyle write SetXPStyle;
  end;

  //Interface usada para exibir as janelas de splash e About.
  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosInfo = interface(ICosmosInterfaces)
 ['{EAE99E87-73B2-4345-8E4D-3E6E40F11713}']

  procedure ShowSplash;
  procedure ShowAbout;

 end;

 //Interface usada pelo módulo de localização de dados.
 ICosmosLocateData = interface(ICosmosInterfaces)
 ['{8CB716F8-D718-45A5-8FE6-CE43CBC68F1D}']
  procedure Execute; overload;
  procedure Execute(Dataset: TDataset); overload;
 end;

 //Interface usada pelo módulo de dicas de ajuda.
 ICosmosTips = interface(ICosmosInterfaces)
 ['{B528226F-B7E0-4D2F-B2A9-D9A633D4EE5A}']

   function ShowTips(FileName: string): boolean;

 end;

 //Interface usada pelo módulo que exibe as telas de "splash" e "about" dos aplicativos.
 ICosmosSplash = interface(ICosmosInterfaces)
   ['{9BA62795-5EC1-4682-81FD-8892729CB076}']
   procedure ShowAppSplash(CosmosModule: TCosmosModules);
   procedure ShowAppAbout(CosmosModule: TCosmosModules);
 end;

 ICosmosTest = interface(ICosmosInterfaces)
   ['{F8E0B534-4E34-4076-B78E-B682B2B74EEC}']
   function SelectFocus(UserName: string): integer;
 end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosFicha = interface(ICosmosInterfaces)
   ['{183A5E12-2928-4B62-A62D-FB5BC48A269D}']
   procedure ShowFicha(const codcad: integer); overload;
   procedure SearchFicha(const LoginName: string);

 end;

 //Interface usada pelo gerenciador de janelas dos aplicativos.
 ICosmosDialogWinManager = interface(ICosmosInterfaces)
   ['{0EF61761-3D37-4E7F-953A-FC71D889E416}']
   function SelectForm: TForm;
 end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ///  Interface usada pela classe da janela de configuração dos aplicativos.
  ICosmosConfiguration = interface(ICosmosInterfaces)
   ['{D1840A57-0718-462D-A9AD-062C0E11EC78}']

   function GetPageCount: integer;

   procedure Execute(const CodePage: string); overload;
   function Execute: boolean; overload;

   property PageCount: integer read GetPageCount;
 end;

 //Representa uma página de configuração da janela de configurações.
 ICosmosConfigurationPage = interface(ICosmosInterfaces)
   ['{72411991-1C14-4668-B5F3-D5F8FAA3021A}']

   function GetChanged: boolean;
   function GetEnabled: boolean;
   function GetPageInfo: TPageInfo;

   function SaveOptions: boolean;
   procedure LoadOptions;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;
 end;


  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosConnectionInfo = interface(ICosmosInterfaces)
   ['{B4BE4881-3998-4213-9354-F560D2E4D3B7}']
    procedure ShowConnectionInfo;

 end;

 ICosmosOpenFocus = interface(ICosmosInterfaces)
   ['{CB341F74-E522-447A-9CE9-EAD071E0DB35}']
    function GetConnectionMode: TConnectionMode;

    function OpenFocus(const UserName: string): TFocus;
    property ConnectionMode: TConnectionMode read GetConnectionMode;
 end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosHistorico = interface(ICosmosInterfaces)
   ['{735C3D12-1856-4FB4-AB92-EE7E46558913}']

    procedure LoadHistorico(const codcad: integer);
 end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosEnderecos = interface(ICosmosInterfaces)
   ['{DB7753DB-4926-4E7D-A8B9-86E35DC8365A}']
    procedure GetEnderecosCadastrado(const codcad: integer);
    procedure GetEnderecosFoco(const codfoc: integer);
 end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosMeiosContatos = interface(ICosmosInterfaces)
   ['{6286BDCF-25C0-48D0-997A-C2B0D8B70FE2}']

   procedure ShowMeiosContatosCadastrado(const codcad: integer);
   procedure ShowMeiosContatosAluno(const codcad: integer);
   procedure ShowMeiosContatosPesquisador(const codcad: integer);
   procedure ShowMeiosContatosFocos(const codfoc: integer);
 end;

  ICosmosFamiliares = interface(ICosmosInterfaces)
    ['{64EE3C88-AA83-4BCC-BC6F-5F80AC82AD15}']

    procedure ShowFamiliares(const codcad: integer);
  end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosLocateCadastrados = interface(ICosmosInterfaces)
   ['{BE37A513-0323-45E3-A534-1CCD22E0C59F}']
    function GetDataset: TDataset;
    property Dataset: TDataset read GetDataset;
    function GetPesquisadores(const ActiveFocus: boolean): boolean;
    function GetJovensTM(const ActiveFocus: boolean): boolean;
 end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosLocateLogradouros = interface(ICosmosInterfaces)
   ['{A1F49BE0-AC12-4B9D-903E-7748978A1A1D}']
    function GetValue(const FieldName: string): variant;
    function Execute(ExecMode: TExecutionMode): boolean;
 end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosLocateLessosEI = interface(ICosmosInterfaces)
   ['{B05D000E-E548-41B7-B9FA-8F6B08A5FD31}']
    function GetSelectedID: integer;
    function GetSelectedText: string;
    function GetLessonEI: boolean;
    property SelectedID: integer read GetSelectedID;
    property SelectedText: string read GetSelectedText;

 end;


 ICosmosSearchCadastrados = interface(ICosmosInterfaces)
   ['{AB24382C-9FBC-4FEA-9D54-4E8706D111C2}']

   function GetDataset: TDataset;
   function SearchPupils(const ActiveFocus: boolean): Olevariant;

   property Dataset: TDataset read GetDataset;
 end;

 ICosmosSearch = interface(ICosmosInterfaces)
   ['{C385DF48-7A09-4B10-88C9-299E357F2AB5}']

    function GetDataset: TDataset;
    procedure SetActiveFocus(value: boolean);
    function GetActiveFocus: boolean;

    property Dataset: TDataset read GetDataset;
    property ActiveFocus: boolean read GetActiveFocus write SetActiveFocus ;

    function SearchMentoresEI: boolean;
    function SearchDirigentesEI: boolean;
    function SearchJovensAlunos: boolean;
 end;


 ICosmosSimpleSearch = interface(ICosmosInterfaces)
   ['{EF0683D7-72A6-4194-A023-1DDCFF4C3858}']

    function GetDataset: TDataset;
    function GetValue(FieldName: string): variant;

    property Dataset: TDataset read GetDataset;

    function ExecuteSearch(Search: TCosmosSearch; Params: Olevariant; Target: TDataset): boolean; overload;
    function ExecuteSearch(const Search: TCosmosSearch; Params: Olevariant): boolean; overload;

 end;

{ICosmosDataSearch é idêntica a ICosmosSimpleSearch. To-do: eliminar uma das
 duas interfaces.}

 ICosmosDataSearch = interface(ICosmosInterfaces)
  ['{56412A9D-5E06-4263-874E-A0259256064F}']

  function GetDataset: TDataset;
  function GetValue(const FieldName: string): variant;

  function ExecuteSearch(Search: TCosmosSearch; Params: Olevariant; Target: TDataset): boolean; overload;
  function ExecuteSearch(const Search: TCosmosSearch; Params: Olevariant): boolean; overload;

  property Dataset: TDataset read GetDataset;
 end;

 IDialogMovimentacaoDiscipular = interface(ICosmosInterfaces)
  ['{E89E00E8-CDC0-4155-B3C3-F683BA4AACA9}']

   procedure BatizarCadastrado(const codcad: integer);
   function DesligarCadastrado(const codcad: integer): boolean;
   procedure EnviarCarta(const codcad: integer);
   procedure RegistrarCasamento(codcad: integer);
   function ReligarCadastrado(const codcad: integer): boolean;
   function RetrogradarCadastrado(const codcad: integer): boolean;
   function TransferirCadastrado(const codcad: integer): boolean;
   function TransferirAluno(const codcad: integer): boolean;
 end;


 IInformacoesCadastrado = interface(ICosmosInterfaces)
   ['{AFB7A73F-5737-4A2A-B2CC-42554AD42393}']

   procedure CadastrarAptidoes(const codcad: integer; nomcad: string);
   procedure CadastrarFuncoes(const codcad: integer; nomcad: string);
   procedure CadastrarInfoMedicas(const codcad: integer; nomcad: string);
 end;



 IAtaPosse = interface(ICosmosInterfaces)
   ['{98ED252F-98D3-42C5-A8F6-44E029660660}']
    function GetGestao: integer;
    procedure SetGestao(const Value: integer);

    procedure GenerateAta;
    property Gestao: integer read GetGestao write SetGestao;
 end;

 IDialogDetalhesHistorico = interface(ICosmosInterfaces)
   ['{3BB09596-3214-402F-B2C0-A7CB9A0E75ED}']
    procedure EditarDetalhe(const codhis, coddet: integer);   
    procedure EditarDetalhes(const codhis: integer);
 end;

 IInstalacaoTMB = interface(ICosmosInterfaces)
   ['{E3697F88-58AA-4F09-8DC4-60D8EB5E29C9}']
   function Execute(codcad: integer; nomcad, sigdis: string): boolean;    
 end;

 IPesquisaCadastrados = interface(ICosmosInterfaces)
  ['{081E4E47-0EF7-44AC-82DB-A06510008501}']
    function Execute: boolean; overload;
    function Execute(CosmosSearch: TCosmosSearch): boolean; overload;
        
    function GetDataset: TDataset;
    function GetValue(FieldName: string): Variant;
    function GetActiveFocus: boolean;
    procedure SetActiveFocus(const Value: boolean);
    function GetSexoCadastrado: TSexoCadastrado;
    procedure SetSexoCadastrado(const Value: TSexoCadastrado);
    function GetCampoTrabalho: TCampoTrabalho;
    procedure SetCampoTrabalho(value: TCampoTrabalho);
    function GetStatusCadastrado: TStatusCadastrado;
    procedure SetStatusCadastrado(Value: TStatusCadastrado);

    property ActiveFocus: boolean read GetActiveFocus write SetActiveFocus;
    property CampoTrabalho: TCampoTrabalho read GetCampoTrabalho write SetCampoTrabalho;
    property Dataset: TDataset read GetDataset;
    property SexoCadastrado: TSexoCadastrado read GetSexoCadastrado
       write SetSexoCadastrado;
    property StatusCadastrado: TStatusCadastrado read GetStatusCadastrado
       write SetStatusCadastrado;
 end;

 IPesquisaCadastradosMultiplos = interface(ICosmosInterfaces)
  ['{78011592-DDA1-4E05-9008-325A1B2DEC28}']
    function Execute: boolean;

    function GetCampoTrabalho: TCampoTrabalho;
    procedure SetCampoTrabalho(value: TCampoTrabalho);
    function GetMatriculas: string;

    property CampoTrabalho: TCampoTrabalho read GetCampoTrabalho write SetCampoTrabalho;
 end;

  IPesquisaFocosRAs = interface(ICosmosInterfaces)
   ['{B05D000E-E548-41B7-B9FA-8F6B08A5FD31}']
    function GetSelectedElement: TCustomFocus;
    function GetShowMenu: boolean;
    procedure SetShowMenu(value: boolean);

    function ExecuteSearch(Listagem: TTipoListagem; EnabledTypes: TTipoFocoSet;
      ListarFocosRA: boolean): TCustomFocus;

    property SelectedElement: TCustomFocus read GetSelectedElement;
    property ShowMenu: boolean read GetShowMenu write SetShowMenu;

 end;

 IPesquisaConferencias = interface(ICosmosInterfaces)
   ['{2A6FC1CB-FE99-43B6-A6D0-B57AA277CD35}']
    function Execute: boolean;

    function GetDataset: TDataset;
    function GetValue(FieldName: string): variant;
    function GetActiveFocus: boolean;
    procedure SetActiveFocus(const Value: boolean);
    function GetCampoTrabalho: TCampoTrabalho;
    procedure SetCampoTrabalho(value: TCampoTrabalho);

    property ActiveFocus: boolean read GetActiveFocus write SetActiveFocus;
    property CampoTrabalho: TCampoTrabalho read GetCampoTrabalho write SetCampoTrabalho;
    property Dataset: TDataset read GetDataset;
 end;

 ICosmosToolsManager = interface(ICosmosInterfaces)
   ['{B7383C8A-C079-41CE-B12D-A0251AAECC08}']

   procedure OpenManager(const FileName: string);
   procedure Execute(const FileName: string);
 end;

  ///<author>Marcelo Mafra Sanches</author>
  ///  <since>15/06/2006</since>
  ///  <version>1.0</version>
  ///   ///
 IDispensasDialgs = interface(ICosmosInterfaces)
   ['{2B37EDE6-3987-41E6-A9A6-33EA1A97DFB6}']

   procedure Execute(codcad: integer; nomcad: string);
 end;


 ISearchTiposAtividades = interface(ICosmosInterfaces)
   ['{6F930C88-D96E-414C-AE68-F7D4C873A0A5}']
    function GetValue(const FieldName: string): variant;

    function Execute: boolean; overload;
    function Execute(Campos: TCamposTrabalho; Default: TCampoTrabalho): boolean; overload;
 end;

 ISearchAlocucoes = interface(ICosmosInterfaces)
    ['{6D1E958F-F91E-4E6C-869D-AF08E23DBF8B}']
    function GetDataset: TDataset;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean; overload;
    function Execute(const LEC, TMO, TMB, TPU: boolean): boolean; overload;
 end;

 ISearchDiscipulados = interface(ICosmosInterfaces)
    ['{28B2E9D9-3010-4456-8CCA-FDDB39C67DED}']
    function GetValue(const FieldName: string): variant;

    function Execute: boolean; overload;
    function Execute(const LEC, TMO, TMB, TPU, EI: boolean): boolean; overload;
 end;

 IControleFrequencia = interface(ICosmosInterfaces)
    ['{50BE01C1-CB76-4EB7-8DDD-3491338FD799}']

    procedure LancarPresencas(const codati: integer); overload;
    procedure LancarPresencas(const codati, codcon: integer); overload;
    procedure LancarPresencasConferencia(const codcon: integer);    
 end;

 ISearchAtividades = interface(ICosmosInterfaces)
    ['{35773AEF-361A-4256-9EE6-048C653D943B}']
    function GetDataset: TDataset;
    function GetValue(FieldName: string): variant;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean; overload;
    function Execute(const CampoTrabalho: TCampoTrabalho): boolean; overload;
    function ExecuteSecurityContext: boolean;

 end;


 ISearchCirculosEI = interface(ICosmosInterfaces)
    ['{A0336139-255D-46C6-A033-9C822F7CBF40}']
    function GetDataset: TDataset;
    function GetValue(FieldName: string): variant;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean;
 end;

 ISearchTurmasTP = interface(ICosmosInterfaces)
    ['{DDCC7DCC-C184-4895-AEF4-F7D5BBA21B0A}']
    function GetDataset: TDataset;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean;
 end;

 ISearchLocais = interface(ICosmosInterfaces)
    ['{CFB44607-80DD-442D-B06A-9AEA51FC80AC}']
    function GetDataset: TDataset;
    function GetValue(const FieldName: string): variant;

    property Dataset: TDataset read GetDataset;
    function Execute(CosmosSearch: TCosmosSearch): boolean;
 end;


 ISearchPlanoContas = interface(ICosmosInterfaces)
    ['{E560AA55-B715-4E63-8C73-C218FC893DF5}']

    function GetValue(const FieldName: string): variant;
    function GetVisao: TVisaoPlanoContas;
    procedure SetVisao(Value: TVisaoPlanoContas);

    property Visao:TVisaoPlanoContas read GetVisao write SetVisao;
    function Execute: boolean;

 end;

 ISearchTiposEventosDiscipulares = interface(ICosmosInterfaces)
    ['{89AC0F3E-6CF0-4996-945A-4C7F487C227F}']
    function GetDataset: TDataset;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean;overload;
    function Execute(const tipeve: string): boolean; overload;
 end;

 ISincronizationStatus = interface(ICosmosInterfaces)
  ['{DC2FA1AD-BBF2-4CAB-9BD7-4756B9832208}']

  function GetCurrentInstallID: variant;
  function Execute: boolean;

  property CurrentInstallID: variant read GetCurrentInstallID;
 end;


 IAgendaAtividades = interface(ICosmosInterfaces)
   ['{14CA60F1-4E0D-4E4F-B415-4C4A53E160A0}']

   procedure OpenAgendaAtividades;
   procedure NovaAtividade(const CampoTrabalho: TCampoTrabalho; ADefault: TCosmosData);
   procedure EditarAtividade(const CampoTrabalho: TCampoTrabalho; codati: integer);
   procedure EditarEscalasAtividade(const codati: integer);
   procedure EditarParticipantes(const codati: integer);
   procedure CadastrarTiposAtividades;
 end;

 IPesquisarAlojamentos = interface(ICosmosInterfaces)
  ['{B01EE56D-9B5F-4BD4-8558-BFCB058E6F46}']

  function PesquisarAlojamentos: TCosmosData;
  function PesquisarQuartos: TCosmosData;
  function PesquisarLeitos: TCosmosData;
 end;

 IExporterDialogs = interface(ICosmosInterfaces)
   ['{3ABB3FBC-8730-4009-9894-D0A0D53B6D76}']
   function GetFileName: string;
   function GetExportFormat: TExportFormat;
   function GetOpenFile: boolean;

   procedure ExecuteDefault(Dataset: TDataset);
   procedure ExportarAgendaAtividades;
   procedure ExportarAlunos;
   procedure ExportarJovensTM;
   procedure ExportarPesquisadores;
   procedure ExportarInscritos(ConferenceId: integer);

   property FileName: string read GetFileName;
   property ExportFormat: TExportFormat read GetExportFormat;
   property OpenFile: boolean read GetOpenFile;
 end;


implementation


end.

