unit Cosmos.Framework.Interfaces.Root;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Vcl.Forms,
 Vcl.ActnList, Vcl.ActnMan, cosmos.system.types, cosmos.classes.application,
 cosmos.framework.interfaces.dataacess, cosmos.framework.interfaces.utils,
 cosmos.classes.logs, cosmos.business.focos, cosmos.business.conferencias,
 Vcl.Tabs, cosmos.reports.types, Cosmos.Framework.Interfaces.ChangeFocusNotifiers;

 const
  RP_CARTEIRINHA = 'Carteirinha do Aluno';
  RP_PRONTUARIO_ALUNO = 'Ficha do Aluno';


 type
  TInterfaceStyle = (isWinXP, isWinVista);

  //Tipo de listagem usada no frame de focos e RA´s..
  TTipoListagem = (tlRa, tlSequencial, tlTitularFocus, tlTipologic, tlNoneFocus);

  //Tipos usados para a emissão de relatórios.

  //Tipo da ordenação dos dados: nome ou matrícula.
  TTipoOrdenacao = (toMatricula, toNome);

  //Interface raíz de todas as usadas pelo Cosmos
  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosInterfaces = interface
    ['{01780FAF-743D-45BC-8567-7CB2AF11DF92}']

  end;

  IApplicationComponent = interface(ICosmosInterfaces)
   ['{9F7539FE-9764-4890-8BA7-40546E607EEA}']
  end;

  IProgressBar = interface(IApplicationComponent)
   ['{BCA3F3F8-5201-4E21-B0F8-E11369AB6936}']

   function GetMaxPosition: integer;
   procedure SetMaxPosition(const Value: integer);
   function GetPosition: integer;
   procedure SetPosition(const Value: integer);
   function GetVisible: boolean;
   procedure SetVisible(const value: boolean);

   property MaxPosition: integer read GetMaxPosition write SetMaxPosition;
   property Position: integer read GetPosition write SetPosition;
   property Visible: boolean read GetVisible write SetVisible;
  end;

  IStatusBar = interface(IApplicationComponent)
   ['{A49CA9FD-79E4-4C8B-8B03-181D701D9B03}']

   procedure WriteText(const value: string);
  end;

  ITrayIcon = interface(IApplicationComponent)
   ['{9C3782B2-376C-4233-88EB-D3E3D74680F4}']

   function GetOnBallonClickEvent: TNotifyEvent;
   procedure ShowInfo(const Title, Text: string);
   procedure ShowWarning(const Title, Text: string);
   procedure ShowError(const Title, Text: string);
   procedure CloseTrayIcon;

   property OnBallonClickEvent: TNotifyEvent read GetOnBallonClickEvent;

  end;


  IApplicationComponents = interface(ICosmosInterfaces)
   ['{3CA0DD0C-8656-4D41-9F04-9A4E88779206}']

    function GetActionManager: TActionManager;
    function GetIProgressBar: IProgressBar;
    function GetIStatusBar: IStatusBar;
    function GetTabsStyle: TTabSetTabStyle;
    function GetITrayIcon: ITrayIcon;
    procedure SetGetTabsStyle(value: TTabSetTabStyle);

    property ActionManager: TActionManager read GetActionManager;
    property ProgressBar: IProgressBar read GetIProgressBar;
    property StatusBar: IStatusBar read GetIStatusBar;
    property TabsStyle: TTabSetTabStyle read GetTabsStyle write SetGetTabsStyle;
    property TrayIcon: ITrayIcon read GetITrayIcon;
  end;

  IDlgMessage = interface(ICosmosInterfaces)
  ['{DCA9680D-4FD7-4CB2-8CFA-CC6745F0F2DB}']

    function Execute(const MessageData: Olevariant): integer; overload;
    function Execute(AMessage: TMessageData): integer; overload;
    function Execute(AMessage: TMessageData; Options: Olevariant): integer; overload;
    function Execute(const MessageTitle, MessageText: string; DialogType: TMsgDlgType): integer; overload;
    function Execute(const MessageTitle, MessageText: string; DialogType: TMsgDlgType; Options: Olevariant): integer; overload;
    function ConfirmationMessage(const MessageTitle, MessageText: string): integer;
    function ErrorMessage(const MessageTitle, MessageText: string): integer;
    function InfoMessage(const MessageTitle, MessageText: string): integer;
    function WarningMessage(const MessageTitle, MessageText: string): integer;
    {$WARN SYMBOL_PLATFORM OFF}
    function CreateTaskDialog(AMessage: TMessageData): TTaskDialog;
    {$WARN SYMBOL_PLATFORM ON}
  end;



  IReportCenter = interface(ICosmosInterfaces)
    ['{84F48AE6-979A-43B5-9696-D7515A169970}']
    function GetReportFile: string;
    procedure SetReportFile(const value: string);

    property ReportFile: string read GetReportFile write SetReportFile;
    procedure PrintReport(const ReportName: string);
    procedure PreviewReport(const ReportName: string);
    //Secretarias
    procedure PrintFichaAluno(const matcad: string);
    procedure PrintFichaJovemTM(const matcad: string);
    procedure PrintFichaPesquisador(const matcad: string);
    procedure PrintFichasAlunos(const matriculas: string);
    procedure PrintHistoric(AData: TCosmosData);
    procedure PrintCarteiraAluno(const matcad: string);
    procedure PrintCarteirasAlunos(const matcad: string);
    procedure PrintListagemByDiscipulado(const Discipulado: string);
    procedure PrintBoletimInfo(const DataInicial, DataFinal: TDateTime);
    procedure PrintFolhaPresenca(Data: TCosmosData; Tipo: TTipoFolhaPresenca);
    procedure PrintFolhaPresencaEI(Data: TCosmosData);
    procedure ShowReportCenter;
    //Conferências
    procedure PrintCrachaInscrito(const codins: integer);
    procedure PrintListagemInscritos(AData: TCosmosData);
    procedure PrintProgramacaoConferencia(AData: TCosmosData);
  end;

  ICosmosConference = interface(ICosmosInterfaces)
    ['{9873C387-98BC-4B71-80A6-9AC9A87C4508}']

    function GetActiveConference: TConferencia;

    function OpenConference(Campo: TCampoTrabalho): boolean;
    property ActiveConference: TConferencia read GetActiveConference;
  end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosApplication = interface(ICosmosInterfaces)
    ['{BFC191E3-4BBB-410D-9D71-2CDE3CD31933}']

    function GetApplicationComponents: IApplicationComponents;
    function GetMainForm: TForm;
    function GetCamposTrabalho: TCamposTrabalho;
    function GetChangeFocusNotifier: IChangeFocusObservable;
    function GetCosmosModule: TCosmosModules;
    function GetCosmosModuleName: string;
    function GetCosmosModuleShortName: string;
    function GetCosmosRootFolder: string;
    function GetFullScreen: boolean;
    procedure SetFullScreen(Value: boolean);
    function GetActiveDockedForm: TCustomForm;
    procedure SetActiveDockedForm(Value: TCustomForm);
    function GetActiveFocus: TFocus;
    function GetCosmosUpdater: ICosmosUpdater;
    function GetCustomHintObj: TCustomHint;
    function GetDlgMessage: IDlgMessage;
    function GetGestureManager: TCustomGestureManager;
    function GetIApplicationPaths: ICosmosApplicationPaths;
    function GetIConference: ICosmosConference;
    function GetInterfaceStyle: TActionBarStyle;
    function GetIRemoteCon: ICosmosRemoteConnection;
    function GetIUtilities: ICosmosUtilities;
    function GetMainLog: ICosmosLogs;
    function GetReportsFolder: string;
    function GetStyleControlClass: TCustomActionControlClass;
    function GetTitle: string;

    function CreateMessageData(Code, HelpContext: integer; MessageText, MessageTitle: string;
      MessageType: TMessageType): TMessageData; overload;
    function CreateMessageData(MessageText, MessageTitle: string; MessageType: TMessageType): TMessageData; overload;

    property ActiveDockedForm: TCustomForm read GetActiveDockedForm write SetActiveDockedForm;
    property ActiveFocus: TFocus read GetActiveFocus;
    property CamposTrabalho: TCamposTrabalho read GetCamposTrabalho;
    property ChangeFocusNotifier: IChangeFocusObservable  read GetChangeFocusNotifier;
    property Components: IApplicationComponents read GetApplicationComponents;
    property CosmosModule: TCosmosModules read GetCosmosModule;
    property CosmosModuleName: string read GetCosmosModuleName;
    property CosmosModuleShortName: string read GetCosmosModuleShortName;
    property CosmosRootFolder: string read GetCosmosRootFolder;
    property FullScreen: boolean read GetFullScreen write SetFullScreen;
    property CosmosUpdater: ICosmosUpdater read GetCosmosUpdater;
    property CustomHintObj: TCustomHint read GetCustomHintObj;
    property DlgMessage: IDlgMessage read GetDlgMessage;
    property GestureManager: TCustomGestureManager read GetGestureManager;
    property IApplicationPaths: ICosmosApplicationPaths read GetIApplicationPaths;
    property IConference: ICosmosConference read GetIConference;
    property InterfaceStyle: TActionBarStyle read GetInterfaceStyle;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon;
    property IUtilities: ICosmosUtilities read GetIUtilities;
    property MainForm: TForm read GetMainForm;
    property MainLog: ICosmosLogs read GetMainLog;
    property ReportsFolder: string read GetReportsFolder;
    property StyleControlClass: TCustomActionControlClass read GetStyleControlClass;
    property Title: string read GetTitle;

    procedure AddCategory(Caption: string; Actions: TActionList);
    procedure CloseApplication;
    procedure DropCategory(Caption: string);
    function ExecuteAction(const Action: TBasicAction): boolean;
    function ExecuteWizard(const LibraryName, ClassName: string): boolean;
    function LoadDialog(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): TForm;
    function LoadClass(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): TInterfacedPersistent;
    function LoadDataModule(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): TDataModule;
    function LoadReportCenter(var AModule: HModule): IReportCenter;
    function GetCosmosInterface(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): ICosmosInterfaces;
    procedure LoadUserFocus(const UserName: string);
    function OpenRegisteredWindow(ModuleName, ClassName: string): TCustomForm;
    procedure RestoreWindow(const ClassName: TClass);
    procedure UnregisterWindow(const ClassName: TClass);
    procedure UpdateVisualElements;

  end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosDockedForm = interface(ICosmosInterfaces)
    ['{3543E14A-A350-47C8-9C03-B17A3AE266D1}']
    function GetFormIDName: string;
    function GetHelpFile: string;
    function GetHelpID: integer;
    function GetTitle: string;
    procedure Locate;
    procedure ExportData;
    function GetFormDescription: string;
    procedure UpdateVisualElements;

    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;


  end;

  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosHelp = interface(ICosmosInterfaces)
    ['{9873C387-98BC-4B71-80A6-9AC9A87C4508}']

    function GetHelpFile: string;
    procedure SetHelpFile(Value: string);

    property HelpFile: string read GetHelpFile write SetHelpFile;
    function ShowHelpContents: integer;
    function ShowHelpIndex: integer;
    function ShowHelpSearch: integer;

  end;







implementation



end.
