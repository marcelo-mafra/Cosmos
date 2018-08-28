unit cosmos.common.view.mainform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.XPMan, Vcl.ActnList,
  Vcl.ActnCtrls, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnMenus, Winapi.WinSvc,
  Vcl.XPStyleActnCtrls, Vcl.ImgList, Winapi.ActiveX, Vcl.ComCtrls,  Vcl.ExtCtrls,
  Xml.XMLDoc, Xml.XMLIntf, Vcl.StdCtrls, Vcl.ButtonGroup, Vcl.Tabs, Vcl.DockTabSet,
  Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.ActnPopup, cosmos.system.types,
  cosmos.system.messages, cosmos.system.exceptions, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Utils, Cosmos.Framework.Interfaces.Dialogs,
  System.Contnrs, Vcl.CustomizeDlg, {Cosmos.classes.logs.winservice} cosmos.data.dbobjects.tables,
  cosmos.classes.security, cosmos.classes.persistence.ini, cosmos.tools.winmanager,
  cosmos.framework.forms.dlgmessages, cosmos.framework.datanavigators.datasets,
  cosmos.framework.clients.common.appinfo, cosmos.classes.ServerInterface,
  cosmos.business.focos, Vcl.PlatformDefaultStyleActnCtrls, cosmos.classes.logs,
  cosmos.classes.logs.controller, cosmos.framework.forms.wizards, cosmos.system.files,
  {Vcl.RibbonLunaStyleActnCtrls,} Vcl.StdStyleActnCtrls, //Vcl.RibbonObsidianStyleActnCtrls,
  {Vcl.RibbonSilverStyleActnCtrls,}  cosmos.framework.view.FrmDocked, Vcl.AppEvnts,
  Vcl.DbGrids, System.Actions, cosmos.system.winshell, cosmos.core.client.connection,
  Vcl.Touch.GestureMgr, Data.DBXCommon, cosmos.classes.utils.cosmoscript,
  cosmos.system.nettypes, Cosmos.Framework.Interfaces.ConnectionNotifiers,
  Cosmos.Framework.Interfaces.ChangeFocusNotifiers, IdStack, System.ImageList;


type

  TCreateCalculator = function(var CalcValue: double): boolean; stdcall;

  TShowCalculator = procedure; stdcall;

  EDllError = class(Exception);

 /// <summary>Pode ser usada com TConnectionThread.</summary>
  TConnectionThreadWorker = reference to procedure;

  /// <summary>Thread que executa uma procedure passada no seu construtor.</summary>
  TConnectionThread = class(TThread)
  protected
    fWorker: TConnectionThreadWorker;
    procedure Execute; override;
  public
    constructor Create(Worker: TConnectionThreadWorker); virtual;
  end;


  TFrmMainClientGUI = class(TForm, ICosmosApplication, ICosmosRemoteConnection,
       ICosmosLogs, IDlgMessage, IApplicationComponents, IProgressBar, IStatusBar,
       ITrayIcon, ICosmosApplicationPaths, ICosmosUtilities)
    XPManifest1: TXPManifest;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActLogin: TAction;
    ActAbout: TAction;
    ActClose: TAction;
    MainList: TImageList;
    ActLogoff: TAction;
    MainStatusBar: TStatusBar;
    Splitter1: TSplitter;
    PnlDock: TPanel;
    ActRegister: TAction;
    DockTab: TDockTabSet;
    ActTabStyleNormal: TAction;
    ActTabStyleModern: TAction;
    ActTabStyleModern2: TAction;
    ActTabStyleSoft: TAction;
    PopupActionBar1: TPopupActionBar;
    Moderno1: TMenuItem;
    Moderno21: TMenuItem;
    Normal1: TMenuItem;
    Soft1: TMenuItem;
    ActCloseWindow: TAction;
    ActCloseAllWindows: TAction;
    ActWindowsManager: TAction;
    ActConfigurations: TAction;
    ActHelpTopics: TAction;
    ActHelpIndex: TAction;
    ActShowStatusBar: TAction;
    ActLocate: TAction;
    ActExportData: TAction;
    ActTabelas: TAction;
    ActSupport: TAction;
    ActMainToolBar: TAction;
    N1: TMenuItem;
    Janelas1: TMenuItem;
    Fechar1: TMenuItem;
    FecharTudo1: TMenuItem;
    PnlLeftDock: TPanel;
    DockTabLeft: TDockTabSet;
    ActMenuManager: TAction;
    ActConnectInfo: TAction;
    ActMessages: TAction;
    ActHelpSearch: TAction;
    CustomDlg: TCustomizeDlg;
    ActCustomize: TAction;
    ActDatasetUpdate: TAction;
    ActFirst: TAction;
    ActPrior: TAction;
    ActNext: TAction;
    ActLast: TAction;
    ActLogs: TAction;
    ActCalculadora: TAction;
    ActModulos: TAction;
    ActTarefas: TAction;
    ActWinXPStyle: TAction;
    ActModernStyle: TAction;
    ActReportsCenter: TAction;
    ActShowTips: TAction;
    ActCadastroLogradouros: TAction;
    ActManualCosmos: TAction;
    ActWhatThis: TAction;
    ActDatasetsUpdates: TAction;
    PopupActionBar2: TPopupActionBar;
    Personalizar1: TMenuItem;
    BarradeFerramentas1: TMenuItem;
    Manager1: TMenuItem;
    BarradeStatus1: TMenuItem;
    N2: TMenuItem;
    ActExternalReports: TAction;
    ActUpdater: TAction;
    PBar: TProgressBar;
    ActDataExtraction: TAction;
    ActCentralPesquisas: TAction;
    ActPlatformStyle: TAction;
    ActRibbonLunaStyle: TAction;
    ActRibbonObsidianStyle: TAction;
    ActRibbonSilverStyle: TAction;
    BalloonHint: TBalloonHint;
    ActMain: TActionList;
    ActFullScreen: TAction;
    AppEvents: TApplicationEvents;
    ActChangePassword: TAction;
    GestureManager1: TGestureManager;
    ActMalaDireta: TAction;
    ActTestServer: TAction;
    procedure CustomDlgShow(Sender: TObject);
    procedure MainStatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure ActTabelasUpdate(Sender: TObject);
    procedure ActUpdaterExecute(Sender: TObject);
    procedure ActExternalReportsUpdate(Sender: TObject);
    procedure ActExternalReportsExecute(Sender: TObject);
    procedure MainStatusBarDblClick(Sender: TObject);
    procedure ActDatasetsUpdatesExecute(Sender: TObject);
    procedure ActWhatThisExecute(Sender: TObject);
    procedure ActDatasetUpdateUpdate(Sender: TObject);
    procedure ActManualCosmosExecute(Sender: TObject);
    procedure ActCadastroLogradourosUpdate(Sender: TObject);
    procedure ActCadastroLogradourosExecute(Sender: TObject);
    procedure ActAtaPosseUpdate(Sender: TObject);
    procedure ActShowTipsUpdate(Sender: TObject);
    procedure ActShowTipsExecute(Sender: TObject);
    procedure ActTabStyleSoftUpdate(Sender: TObject);
    procedure ActTabStyleModern2Update(Sender: TObject);
    procedure ActTabStyleModernUpdate(Sender: TObject);
    procedure ActTabStyleNormalUpdate(Sender: TObject);
    procedure ActReportsCenterExecute(Sender: TObject);
    procedure ActModernStyleExecute(Sender: TObject);
    procedure ActWinXPStyleExecute(Sender: TObject);
    procedure ActTarefasExecute(Sender: TObject);
    procedure ActModulosExecute(Sender: TObject);
    procedure ActCalculadoraExecute(Sender: TObject);
    procedure ActHelpSearchUpdate(Sender: TObject);
    procedure ActLogsExecute(Sender: TObject);
    procedure ActLastUpdate(Sender: TObject);
    procedure ActLastExecute(Sender: TObject);
    procedure ActNextExecute(Sender: TObject);
    procedure ActPriorExecute(Sender: TObject);
    procedure ActFirstUpdate(Sender: TObject);
    procedure ActFirstExecute(Sender: TObject);
    procedure ActDatasetUpdateExecute(Sender: TObject);
    procedure ActCustomizeExecute(Sender: TObject);
    procedure ActHelpSearchExecute(Sender: TObject);
    procedure ActMessagesExecute(Sender: TObject);
    procedure ActConnectInfoExecute(Sender: TObject);
    procedure ActMenuManagerExecute(Sender: TObject);
    procedure DockTabLeftTabRemoved(Sender: TObject);
    procedure ActHelpIndexExecute(Sender: TObject);
    procedure ActHelpTopicsExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActSupportExecute(Sender: TObject);
    procedure ActMainToolBarExecute(Sender: TObject);
    procedure ActCloseWindowUpdate(Sender: TObject);
    procedure ActCloseWindowExecute(Sender: TObject);
    procedure ActTabelasExecute(Sender: TObject);
    procedure ActExportDataExecute(Sender: TObject);
    procedure ActLocateUpdate(Sender: TObject);
    procedure ActLocateExecute(Sender: TObject);
    procedure MainStatusBarResize(Sender: TObject);
    procedure ActShowStatusBarExecute(Sender: TObject);
    procedure ActConfigurationsExecute(Sender: TObject);
    procedure ActWindowsManagerExecute(Sender: TObject);
    procedure ActCloseAllWindowsExecute(Sender: TObject);
    procedure ActTabStyleNormalExecute(Sender: TObject);
    procedure DockTabTabRemoved(Sender: TObject);
    procedure ActRegisterUpdate(Sender: TObject);
    procedure ActRegisterExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActLoginUpdate(Sender: TObject);
    procedure ActLogoffUpdate(Sender: TObject);
    procedure ActLogoffExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure ActLoginExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActCentralPesquisasExecute(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActPlatformStyleExecute(Sender: TObject);
    procedure ActRibbonLunaStyleExecute(Sender: TObject);
    procedure ActRibbonObsidianStyleExecute(Sender: TObject);
    procedure ActRibbonSilverStyleExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PnlLeftDockDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure PnlDockDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ActWindowsManagerUpdate(Sender: TObject);
    procedure ActFullScreenExecute(Sender: TObject);
    procedure AppEventsException(Sender: TObject; E: Exception);
    procedure ActModernStyleUpdate(Sender: TObject);
    procedure ActExportDataUpdate(Sender: TObject);
    procedure ActCentralPesquisasUpdate(Sender: TObject);
    procedure ActChangePasswordExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActFullScreenUpdate(Sender: TObject);
    procedure ActMalaDiretaExecute(Sender: TObject);
    procedure ActUpdaterUpdate(Sender: TObject);
    procedure ActMalaDiretaUpdate(Sender: TObject);
    procedure ActTestServerExecute(Sender: TObject);
  private
    { Private declarations }
    FAbortedLogin: boolean; //controla se o login foi abortado pelo usuário.
    FShowTips: boolean;
    FStarted: Boolean;
    FRegistered: boolean;
    //variáveis de logs
    FLogEvents: TLogEvents;
    FCurrentLogFile: string;
    FMaxFileSize: Int64;
    FLogsFilesPath: string;

    FFullScreen: boolean;
    FWindowMenu: TActionClientItem;
    FActiveDockedForm: TCustomForm;

    FCosmosAppInfo: TCosmosAppInfo;
    FCommonConfigurationsFile, FUserConfigurationsFile: string;
    FWinManager: TWindowsManager;
    FChangeFocusObservable: TChangeFocusObservable;
    FChangeFocusObserver: TChangeFocusObserver;
    FConnectionObserver: TConnectionStatusObserver;
    FShowLogin: boolean;
    FActiveFocus: TFocus;
    FAutoUpdate: boolean;
    FDlgMessage: TDlgMessage;
    FTrayIcon: TTrayIcon; //ícone de notificação da bandeja.

    procedure OnNotifyConnectionStatus(Status: TConnectionStatus);

    function GetCurrentConnection: TCosmosSecurity;
    function GetWindowsManager: TWindowsManager;

    procedure OnActiveFormChange(Sender: TObject);

    procedure LoadLogsConfigurations;
    function LoadTips: boolean;
    procedure LoadSplashForm;
    procedure Login;
    procedure ConcludeConnectionProcess;

    procedure OnNotifyChangeFocus(Focus: TFocus);
    procedure OnShowHint(Sender: TObject);
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession);
       message WM_QueryEndSession;
    procedure StartUpdate;
    function LoadModule(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): TDataModule;
    procedure DockClient(ClientControl: TWinControl);
    procedure RedrawStatusBar;
    procedure CreateMyCosmosFolder;
    procedure ReadMyStartupOptions;
    //Métodos relacionados à geração de logs.
    function CreateLogsObject: TCosmosLogsController;
    procedure RegisterLogFileName(var NewFileName: string);

  protected
   //Métodos virtuais que devem ser implementados ou alterados pelos descendentes.
    function GetCosmosModule: TCosmosModules; virtual; abstract;
    function GetIConference: ICosmosConference; virtual; abstract;
    function GetIRemoteCon: ICosmosRemoteConnection; virtual; abstract;
    procedure ReadCommonStartupOptions; virtual;
    procedure WriteStartupOptions; virtual;
    procedure DoAplicateCustomHintObject(const CustomHint: TCustomHint); virtual;


  //Implementação de métodos de interfaces...
  {ICosmosApplication}
    function GetApplicationComponents: IApplicationComponents;
    function GetFullScreen: boolean;
    function GetTitle: string;
    function GetMainForm: TForm;
    function GetMainLog: ICosmosLogs;
    function GetReportsFolder: string;
    function GetCosmosUpdater: ICosmosUpdater;
    function GetCustomHintObj: TCustomHint;
    function GetDlgMessage: IDlgMessage;
    function GetGestureManager: TCustomGestureManager;
    function GetIApplicationPaths: ICosmosApplicationPaths;
    function GetCamposTrabalho: TCamposTrabalho;
    function GetChangeFocusNotifier: IChangeFocusObservable;
    function GetCosmosRootFolder: string;
    function GetActiveDockedForm: TCustomForm;
    procedure SetActiveDockedForm(Value: TCustomForm);
    function GetActiveFocus: TFocus;
    procedure SetFullScreen(Value: boolean);
    function GetInterfaceStyle: TActionBarStyle;
    function GetIUtilities: ICosmosUtilities;
    function GetStyleControlClass: TCustomActionControlClass;
    function GetCosmosModuleName: string;
    function GetCosmosModuleShortName: string;
    function CreateMessageData(Code, HelpContext: integer; MessageText, MessageTitle: string;
      MessageType: TMessageType): TMessageData; overload; inline;
    function CreateMessageData(MessageText, MessageTitle: string; MessageType: TMessageType): TMessageData; overload; inline;

    property IConference: ICosmosConference read GetIConference;
    property ActiveDockedForm: TCustomForm read GetActiveDockedForm;
    property ActiveFocus: TFocus read GetActiveFocus;
    property CamposTrabalho: TCamposTrabalho read GetCamposTrabalho;
    property ChangeFocusNotifier: IChangeFocusObservable read GetChangeFocusNotifier;
    property Components: IApplicationComponents read GetApplicationComponents;
    property CosmosUpdater: ICosmosUpdater read GetCosmosUpdater;
    property CustomHintObj: TCustomHint read GetCustomHintObj;
    property DlgMessage: IDlgMessage read GetDlgMessage implements IDlgMessage;
    property GestureManager: TCustomGestureManager read GetGestureManager;

    property IApplicationPaths: ICosmosApplicationPaths read GetIApplicationPaths implements ICosmosApplicationPaths;
    property StyleControlClass: TCustomActionControlClass read GetStyleControlClass;
    property CosmosModule: TCosmosModules read GetCosmosModule;
    property CosmosModuleName: string read  GetCosmosModuleName;
    property CosmosModuleShortName: string read GetCosmosModuleShortName;
    property CosmosRootFolder: string read GetCosmosRootFolder;
    property FullScreen: boolean read GetFullScreen write SetFullScreen;
    property Title: string read GetTitle;
    property MainForm: TForm read GetMainForm;
    property MainLog: ICosmosLogs read GetMainLog implements ICosmosLogs;
    property ReportsFolder: string read GetReportsFolder;
    property InterfaceStyle: TActionBarStyle read GetInterfaceStyle;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon implements ICosmosRemoteConnection;
    property IUtilities: ICosmosUtilities read GetIUtilities;

    procedure CloseApplication;
    function OpenRegisteredWindow(ModuleName, ClassName: string): TCustomForm; overload;
    procedure RestoreWindow(const ClassName: TClass);
    procedure UnregisterWindow(const ClassName: TClass);
    procedure AddCategory(Caption: string; Actions: TActionList);
    procedure DropCategory(Caption: string);
    procedure UpdateVisualElements;

    procedure SetRegistered;
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

   {IProgressBar}
    function GetMaxPosition: integer;
    procedure SetMaxPosition(const Value: integer);
    function GetPosition: integer;
    procedure SetPosition(const value: integer);
    function GetVisible: boolean;
    procedure SetVisible(const Value: boolean);

    property MaxPosition: integer read GetMaxPosition write SetMaxPosition;
    property Position: integer read GetPosition write SetPosition;
    property Visible: boolean read GetVisible write SetVisible;

   {IStatusBar}
    procedure WriteText(const value: string);

   {ITrayIcon}
    function GetOnBallonClickEvent: TNotifyEvent;
    procedure ShowInfo(const Title, Text: string);
    procedure ShowWarning(const Title, Text: string);
    procedure ShowError(const Title, Text: string);
    procedure CloseTrayIcon;

    property OnBallonClickEvent: TNotifyEvent read GetOnBallonClickEvent;


  {IApplicationComponents}
    function GetActionManager: TActionManager; virtual; abstract;
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

   {ICosmosUtilities}
    function EncriptString(const InString: string): string;
    function DecryptString(const InString: string): string;
    function HashString(const InString: string): string;


  public
    { Public declarations }
    procedure ExecuteUpdate;

    property AutoUpdate: boolean read FAutoUpdate write FAutoUpdate;
    property CurrentLogFile: string read FCurrentLogFile write FCurrentLogFile;
    property CosmosAppInfo: TCosmosAppInfo read FCosmosAppInfo;
    function CreateXMLDocument: TXMLDocument;
    property CurrentConnection: TCosmosSecurity read GetCurrentConnection;
    property LogEvents: TLogEvents read FLogEvents;
    property Registered: boolean read FRegistered;
    property ShowLogin: boolean read FShowLogin write FShowLogin;
    property ShowTips: boolean read FShowTips write FShowTips;
    property Started: boolean read FStarted write FStarted;
    property WindowsManager: TWindowsManager read GetWindowsManager;
    property WindowMenu: TActionClientItem read FWindowMenu;

    //Caminho dos arquivos de configuração.
    property CommonConfigurationsFile: string read FCommonConfigurationsFile;
    property UserConfigurationsFile: string read FUserConfigurationsFile;


  end;

var
  FrmMainClientGUI: TFrmMainClientGUI;


implementation

uses cosmos.common.view.frmmodernmenu, cosmos.common.view.frmwinmanager;

{$R *.dfm}

procedure TFrmMainClientGUI.ActLogoffExecute(Sender: TObject);
begin
 //Encerra a conexão.
 try
  IRemoteCon.CloseConnection;
  ActCloseAllWindows.Execute;

 finally
  //Destrói o foco ativo e repinta a barra de status.
  if not IRemoteCon.Connected then
   begin
     if Assigned(FActiveFocus) then
      FreeAndNil(FActiveFocus);

     MainStatusBar.Repaint;
   end;
 end;
end;

procedure TFrmMainClientGUI.ActLogoffUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected);
end;

procedure TFrmMainClientGUI.ActLogsExecute(Sender: TObject);
var
 ACosmosApp: string;
begin
{Executa o programa de visualização de logs do Cosmos.}
 try
  ACosmosApp := IApplicationPaths.ReadInstallationPath + TCosmosFiles.LogsReader;
  TWinShell.OpenProgram(ACosmosApp, '');

 except
  on E: Exception do
   begin
     DlgMessage.ErrorMessage(TCosmosTitles.LogsCosmos, TCosmosErrorMsg.ExecuteLogsViewer);
     MainLog.RegisterError(TCosmosErrorMsg.ExecuteLogsViewer + #13 + E.Message);
   end;
 end;
end;

procedure TFrmMainClientGUI.ActAboutExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAbout: ICosmosSplash;
begin
 {Carrega a janela "about" dos aplicativos Cosmos.}
 AClass := LoadClass('splash.bpl', 'TSplashControler', AModule); //do not localize!

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAbout := AClass as ICosmosSplash;
    if IAbout <> nil then
     begin
      IAbout.ShowAppAbout(CosmosModule);
     end;
   end;

 finally
  if Assigned(IAbout) then IAbout := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmMainClientGUI.ActCadastroLogradourosExecute(Sender: TObject);
var
AModule: HModule;
AForm: TForm;
begin
 {Acessa a biblioteca de cadastro de logradouros.}
  AForm := LoadDialog('peslog.bpl', 'TFrmSearchLogradouro', AModule); //do not localize!

  try
    if AModule <> 0 then
     begin
      AForm.ShowModal;
      AForm.Free;
     end;

  finally
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMainClientGUI.ActCadastroLogradourosUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
  (CurrentConnection <> nil) and (cfCadastrarLogradouros in CurrentConnection.AuthorizedFeatures);
end;

procedure TFrmMainClientGUI.ActCalculadoraExecute(Sender: TObject);
var
AModule: THandle;
ShowCalculator: TShowCalculator;
begin
{Carrega a calaculadora que está dentro da dll calc.dll. A função ShowCalculator
 retorna o resultado da operação corrente feita na cal é possível usá-la.}
 AModule := LoadLibrary('calc.dll'); //do not localize!

 try
  if AModule = 0 then
   raise EDLLError.Create(TCosmosErrorMsg.DllCalculator);

  @ShowCalculator := GetProcAddress(AModule,'ShowCalculator'); //do not localize!
  if not (@ShowCalculator = nil) then
   ShowCalculator
  else
   RaiseLastOSError;

 finally
  if AModule <> 0 then FreeLibrary(AModule);
 end;
end;

procedure TFrmMainClientGUI.ActCentralPesquisasExecute(Sender: TObject);
begin
 OpenRegisteredWindow('cenpes.bpl', 'TFrmCentralPesquisas');//do not localize!
end;

procedure TFrmMainClientGUI.ActCentralPesquisasUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
 (CurrentConnection <> nil) and (cfCentralPesquisas in CurrentConnection.AuthorizedFeatures);
end;

procedure TFrmMainClientGUI.ActChangePasswordExecute(Sender: TObject);
begin
//Muda a senha do usuário.
 if (IRemoteCon <> nil) and (IRemoteCon.Connected) then
  begin
   if IRemoteCon.ChangePassword('') then //não passa a senha atual. Ela não é armazenada em memória.
     DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosInfoMsg.SenhaAlterada);
  end
end;

procedure TFrmMainClientGUI.ActCloseAllWindowsExecute(Sender: TObject);
begin
 {Fecha todas as janelas de dados do Cosmos (Dockedform, da classe TFrmDockedForm)
  que estão abertas.}

 //Se não houver nenhuma janela dockada ativa, não há o que fazer.
 if ActiveDockedForm = nil then
  Exit;

 while FWinManager.FormCount > 0 do
  begin
   FActiveDockedForm := FWinManager.GetFirstForm;
   FWinManager.CloseForm(self.ActiveDockedForm);
  end;
end;

procedure TFrmMainClientGUI.ActCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmMainClientGUI.ActCloseWindowExecute(Sender: TObject);
begin
 if ActiveDockedForm <> nil then
   FWinManager.CloseForm(ActiveDockedForm);
end;

procedure TFrmMainClientGUI.ActCloseWindowUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := Assigned(FWinManager) and (FWinManager.FormCount > 0);
end;

procedure TFrmMainClientGUI.ActHelpIndexExecute(Sender: TObject);
begin
  HtmlHelp(Handle, PChar(Application.HelpFile), HH_DISPLAY_INDEX, DWord(0));
end;

procedure TFrmMainClientGUI.ActHelpTopicsExecute(Sender: TObject);
begin
  HtmlHelp(Handle, PChar(Application.HelpFile), HH_DISPLAY_TOC, DWord(0));
end;

procedure TFrmMainClientGUI.ActTestServerExecute(Sender: TObject);
begin
 //Testa a conexão atual com o servidor remoto.
 if IRemoteCon.TestConnectedServer then
  Components.TrayIcon.ShowInfo(TCosmosTitles.ServerConection, TCosmosInfoMsg.GoodNetActivity)
 else
  Components.TrayIcon.ShowError(TCosmosTitles.ServerConection, TCosmosErrorMsg.NoNetActivity);
end;

procedure TFrmMainClientGUI.ActWinXPStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('XP Style')];//do not localize!
 ActionManager.Style := NewStyle;
 FWinManager.UpdateAllFormsElements;

 WriteStartupOptions;
end;

procedure TFrmMainClientGUI.ActAtaPosseUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := IRemoteCon.Connected;
end;

procedure TFrmMainClientGUI.ActWhatThisExecute(Sender: TObject);
begin
 PostMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
end;

procedure TFrmMainClientGUI.ActUpdaterExecute(Sender: TObject);
begin
 OpenRegisteredWindow('updater.bpl', 'TFrmUpdatesHistoric');//do not localize!
end;

procedure TFrmMainClientGUI.ActUpdaterUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := False;
end;

procedure TFrmMainClientGUI.ActFirstExecute(Sender: TObject);
begin
//Navega para o primeiro dado controlado pelo TCustomDataNavigator ativo.
 IRemoteCon.ActiveDataNavigator.MoveToFirst;
end;

procedure TFrmMainClientGUI.ActFirstUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and (IRemoteCon.ActiveDataNavigator <> nil)
  and (IRemoteCon.ActiveDataNavigator.Active) and (IRemoteCon.ActiveDataNavigator.IsEmpty = False) and not (IRemoteCon.ActiveDataNavigator.IsBof);
end;

procedure TFrmMainClientGUI.ActFullScreenExecute(Sender: TObject);
begin
//Alterna entre a visão de tela cheia e a visao normal.
 FullScreen := not FullScreen;
end;

procedure TFrmMainClientGUI.ActFullScreenUpdate(Sender: TObject);
begin
 TAction(sender).Checked := FullScreen;
 TAction(Sender).Enabled := Assigned(FWinManager) and (FWinManager.FormCount > 0);
end;

procedure TFrmMainClientGUI.ActPriorExecute(Sender: TObject);
begin
 //Move para o primeiro registro do dataset ativo.
 IRemoteCon.ActiveDataNavigator.MoveToPrior;
end;

procedure TFrmMainClientGUI.ActNextExecute(Sender: TObject);
begin
 //Move para o próximo registro do dataset ativo.
 IRemoteCon.ActiveDataNavigator.MoveToNext;
end;

procedure TFrmMainClientGUI.ActLastExecute(Sender: TObject);
begin
//Navega para o último dado controlado pelo TCustomDataNavigator ativo..
 IRemoteCon.ActiveDataNavigator.MoveToLast;
end;

procedure TFrmMainClientGUI.ActLastUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and (IRemoteCon.ActiveDataNavigator <> nil)
   and (IRemoteCon.ActiveDataNavigator.Active) and (IRemoteCon.ActiveDataNavigator.IsEmpty = False) and not (IRemoteCon.ActiveDataNavigator.IsEof);
end;

procedure TFrmMainClientGUI.ActHelpSearchExecute(Sender: TObject);
var
ID: THelpContext;
begin
//Chama o sistema de ajuda para as janelas dockadas.
 if FActiveDockedForm <> nil then
  begin
   ID := FActiveDockedForm.HelpContext;

   if ID <> 0 then
     Application.HelpSystem.ShowContextHelp(ID, Application.CurrentHelpFile)
   else
    self.DlgMessage.Execute(TCosmosTitles.HelpSystem, TCosmosInfoMsg.NoHelpFound, mtError);
  end
 else
  ActHelpTopics.Execute;
end;

procedure TFrmMainClientGUI.ActHelpSearchUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := ActiveDockedForm <> nil;
end;

procedure TFrmMainClientGUI.ActConfigurationsExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IConfig: ICosmosConfiguration;
begin
 //Acessa a ferramenta de configurações do sistema.
  AForm := self.LoadDialog('confwin.bpl', 'TFrmConfig', AModule);//do not localize!

  try
    if AModule <> 0 then
     begin
      if Supports(AForm, ICosmosConfiguration) then
        IConfig := AForm as ICosmosConfiguration;

      if Assigned(IConfig) then
        begin
          if IConfig.Execute then
           self.ReadMyStartupOptions;
         end;

      AForm.Free;
     end;

  finally
   if Assigned(IConfig) then IConfig := nil;
    UnloadPackage(AModule);
  end;
end;

procedure TFrmMainClientGUI.ActConnectInfoExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IInfo: ICosmosConnectionInfo;
begin
//Exibe informações sobre a conexão ativa
  AForm := self.LoadDialog('coninfo.bpl', 'TFrmInfoConnection', AModule);//do not localize!

  try
   if AModule <> 0 then
    begin
     if Supports(AForm, ICosmosConnectionInfo) then
       IInfo := AForm as ICosmosConnectionInfo;
     if Assigned(IInfo) then
       IInfo.ShowConnectionInfo;
     AForm.Free;
    end;

  finally
   if Assigned(IInfo) then IInfo := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMainClientGUI.ActCustomizeExecute(Sender: TObject);
begin
 CustomDlg.Show;
end;

procedure TFrmMainClientGUI.ActDatasetsUpdatesExecute(Sender: TObject);
begin
 //Atualiza todos os datasets de todas as janelas registradas abertas.
 WindowsManager.UpdateAllForms;
end;

procedure TFrmMainClientGUI.ActDatasetUpdateExecute(Sender: TObject);
begin
 //Atualiza o dataset da janela registrada ativa.
 IRemoteCon.ActiveDataNavigator.UpdateData;
end;

procedure TFrmMainClientGUI.ActDatasetUpdateUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.ActiveDataNavigator  <> nil)
  and (IRemoteCon.ActiveDataNavigator.Active);
end;

procedure TFrmMainClientGUI.ActExportDataExecute(Sender: TObject);
var
IDockedForm: ICosmosDockedForm;
begin
//Exporta os dados do dataset da janela registrada ativa.
 if ActiveDockedForm <> nil then
  begin
   if Supports(ActiveDockedForm, ICosmosDockedForm) then
    begin
     IDockedForm := ActiveDockedForm as ICosmosDockedForm;
     IDockedForm.ExportData;
    end;
  end;
end;

procedure TFrmMainClientGUI.ActExportDataUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon.ActiveDataNavigator <> nil) and (IRemoteCon.ActiveDataNavigator.Active)
   and (CurrentConnection <> nil) and (cfExportData in CurrentConnection.AuthorizedFeatures)
   and not (IRemoteCon.ActiveDataNavigator.IsEmpty);
end;

procedure TFrmMainClientGUI.ActExternalReportsExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
begin
//Acessa a ferramenta de gestão de relatórios externos
 AForm := self.LoadDialog('erman.bpl', 'TFrmExternalReports', AModule); //do not localize!

 try
  if AModule <> 0 then
   begin
    AForm.ShowModal;
    AForm.Free;
   end;

 finally
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmMainClientGUI.ActExternalReportsUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil)
 and (cfExternalReports in CurrentConnection.AuthorizedFeatures);;
end;

procedure TFrmMainClientGUI.ActLocateExecute(Sender: TObject);
var
IDockedForm: ICosmosDockedForm;
begin
//Localiza um registro do dataset da janela registrada ativa.
 if ActiveDockedForm <> nil then
  begin
   if Supports(ActiveDockedForm, ICosmosDockedForm) then
    begin
     IDockedForm := ActiveDockedForm as ICosmosDockedForm;
     IDockedForm.Locate;
    end;
  end;
end;

procedure TFrmMainClientGUI.ActLocateUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon.ActiveDataNavigator <> nil) and (IRemoteCon.ActiveDataNavigator.Active)
   and not (IRemoteCon.ActiveDataNavigator.IsEmpty);
end;

procedure TFrmMainClientGUI.ActLoginExecute(Sender: TObject);
begin
{Inicia a operação de autenticação do usuário. Ela é um loop que continuará
 até que o usuário cancele a autenticação ou a consiga.}
 FAbortedLogin := False;

 //Cria e registra o objeto observador.
 if not Assigned(FConnectionObserver) then
  begin
    FConnectionObserver := TConnectionStatusObserver.Create;
    FConnectionObserver.OnNotifyChangeConnectionStatus := OnNotifyConnectionStatus;
    IRemoteCon.ConnectionStatusNotifier.RegisterObserver(FConnectionObserver);
  end;

 if (IRemoteCon <> nil) and not (IRemoteCon.Connected) then
  begin
   while not (FAbortedLogin) and not (IRemoteCon.Connected) do
     Login;
  end;
end;

procedure TFrmMainClientGUI.ActLoginUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon <> nil) and not (IRemoteCon.Connected);
end;

procedure TFrmMainClientGUI.ActMainToolBarExecute(Sender: TObject);
begin
 ActionManager.ActionBars.ActionBars[1].Visible := TAction(Sender).Checked;
end;

procedure TFrmMainClientGUI.ActMalaDiretaExecute(Sender: TObject);
begin
 OpenRegisteredWindow('addresslbs.bpl', 'TFrmAdressLabels'); //do not localize!
end;

procedure TFrmMainClientGUI.ActMalaDiretaUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := False;
end;

procedure TFrmMainClientGUI.ActManualCosmosExecute(Sender: TObject);
begin
//Abre o manual do usuário do Cosmos.
 TWinShell.OpenFile(CosmosAppInfo.ReadHelpFilesPath + TCosmosFiles.ManualCosmos);
end;

procedure TFrmMainClientGUI.ActMenuManagerExecute(Sender: TObject);
begin
 FrmModernMenu.Visible := TAction(Sender).Checked;
 if TAction(Sender).Checked then
   FrmModernMenu.Width := 185;
end;

procedure TFrmMainClientGUI.ActMessagesExecute(Sender: TObject);
begin
 OpenRegisteredWindow('cosmosmsg.bpl', 'TFrmMessages'); //do not localize!
end;

procedure TFrmMainClientGUI.ActModulosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
begin
 {Acessa a janela que lista os dados de versão das bibliotecas instaladas.}
 AForm := self.LoadDialog('cmmodules.bpl', 'TFrmModules', AModule); //do not localize!

 try
  if AModule <> 0 then
   begin
     AForm.ShowModal;
     AForm.Free;
   end;

 finally
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmMainClientGUI.ActPlatformStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('Platform Default')]; //do not localize!
 ActionManager.Style := NewStyle;
 FWinManager.UpdateAllFormsElements;

 WriteStartupOptions;
end;

procedure TFrmMainClientGUI.ActRegisterExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IRegister: IRegisterInfo;
begin
//Acessa a janela de registro do aplicativo
  AForm := LoadDialog('regcosmos.bpl', 'TFrmRegister', AModule); //do not localize!

  try
   if AModule <> 0 then
    begin
     if Supports(AForm, IRegisterInfo) then
      IRegister := AForm as IRegisterInfo;
     if Assigned(IRegister) then
       begin
        IRegister.ShowRegisterForm(CosmosModule);
        FRegistered := IRegister.IsRegistered(CosmosModule);
       end;
      AForm.Free;
    end;

  finally
   if Assigned(IRegister) then IRegister := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMainClientGUI.ActRegisterUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := not Registered;
end;

procedure TFrmMainClientGUI.ActReportsCenterExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
begin
{Carrega a ferramente "Central de Relatórios".}
 AForm := LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule); //do not localize!

 try
  if AModule <> 0 then
   begin
     with AForm do
      begin
       if Supports(AForm, IReportCenter) then
        IReport := AForm as IReportCenter;

       if Assigned(IReport) then
        begin
         IReport.ShowReportCenter;
        end;
       Free;
      end;
   end;

 finally
  if Assigned(IReport) then IReport := nil;
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmMainClientGUI.ActRibbonLunaStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('Ribbon - Luna')]; //do not localize!
 ActionManager.Style := NewStyle;
 FWinManager.UpdateAllFormsElements;

 WriteStartupOptions;
end;

procedure TFrmMainClientGUI.ActRibbonObsidianStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('Ribbon - Obsidian')]; //do not localize!
 ActionManager.Style := NewStyle;
 FWinManager.UpdateAllFormsElements;

 WriteStartupOptions;
end;

procedure TFrmMainClientGUI.ActRibbonSilverStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('Ribbon - Silver')]; //do not localize!
 ActionManager.Style := NewStyle;
 FWinManager.UpdateAllFormsElements;

 WriteStartupOptions;
end;

procedure TFrmMainClientGUI.ActShowStatusBarExecute(Sender: TObject);
begin
//Alterna a exibição da barra de status.
 MainStatusBar.Visible := TAction(Sender).Checked;
end;

procedure TFrmMainClientGUI.ActShowTipsExecute(Sender: TObject);
begin
//Alterna a exibição das dicas (tips) do sistema durante a inicialização.
 ShowTips := not ShowTips;
end;

procedure TFrmMainClientGUI.ActShowTipsUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := ShowTips;
end;

procedure TFrmMainClientGUI.ActSupportExecute(Sender: TObject);
begin
 Application.HelpSystem.ShowTopicHelp('Suporte',application.HelpFile);
end;

procedure TFrmMainClientGUI.ActTabelasExecute(Sender: TObject);
begin
//Abre a tela de tabelas acessórias do Cosmos.
 OpenRegisteredWindow('tabace.bpl', 'TFrmAcessorias'); //do not localize!
end;

procedure TFrmMainClientGUI.ActTabelasUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
 (CurrentConnection <> nil) and (cfTabelasAcessorias in CurrentConnection.AuthorizedFeatures)
end;

procedure TFrmMainClientGUI.ActTabStyleModern2Update(Sender: TObject);
begin
 TAction(Sender).Enabled := DockTab.Tabs.Count > 0;
 TAction(Sender).Checked := DockTab.Style = tsModernPopout;
end;

procedure TFrmMainClientGUI.ActTabStyleModernUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := DockTab.Tabs.Count > 0;
 TAction(Sender).Checked := DockTab.Style = tsModernTabs;
end;

procedure TFrmMainClientGUI.ActTabStyleNormalExecute(Sender: TObject);
begin
//Muda o estilo visual das classes TDockTabSet usadas no sistema.
 case TAction(Sender).Tag of
  0: DockTab.Style := tsStandard;
  1: DockTab.Style := tsModernTabs;
  2: DockTab.Style := tsModernPopout;
  3: DockTab.Style := tsSoftTabs;
 end;

 DockTabLeft.Style := DockTab.Style;
end;

procedure TFrmMainClientGUI.ActTabStyleNormalUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := DockTAb.Tabs.Count > 0;
 TAction(Sender).Checked := DockTab.Style = tsStandard;
end;

procedure TFrmMainClientGUI.ActTabStyleSoftUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := DockTab.Tabs.Count > 0;
 TAction(Sender).Checked := DockTab.Style = tsSoftTabs;
end;

procedure TFrmMainClientGUI.ActTarefasExecute(Sender: TObject);
begin
 OpenRegisteredWindow('tarefas.bpl', 'TFrmTarefas'); //do not localize!
end;

procedure TFrmMainClientGUI.ActWindowsManagerExecute(Sender: TObject);
begin
 if not Assigned(FrmWindowsManager) then
   begin
    FrmWindowsManager := TFrmWindowsManager.Create(Application);
    self.DockClient(FrmWindowsManager);
   end
  else
   FreeAndNil(FrmWindowsManager);
end;

procedure TFrmMainClientGUI.ActWindowsManagerUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := (FrmWindowsManager <> nil) and (FrmWindowsManager.Visible);
end;

procedure TFrmMainClientGUI.ActModernStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('New XP Style')]; //do not localize!
 ActionManager.Style := NewStyle;
 FWinManager.UpdateAllFormsElements;

 WriteStartupOptions;
end;

procedure TFrmMainClientGUI.ActModernStyleUpdate(Sender: TObject);
begin
TAction(sender).Enabled := False;
end;

procedure TFrmMainClientGUI.AddCategory(Caption: string; Actions: TActionList);
var
Window, Sender: TActionClientItem;
begin
 FrmModernMenu.AddCategory(Caption, Actions);
 //Cria o submenu do menu "janelas"
 Sender := ActionManager.FindItemByCaption(Caption);
 if Sender <> nil then
   begin
    if Sender.Action.Tag = 0 then
     begin
      Window := WindowMenu.Items.Add;
      Window.Action := Sender.Action;
      Window.Index := 0;
     end;
   end;
end;

procedure TFrmMainClientGUI.AppEventsException(Sender: TObject; E: Exception);
var
 aLogObj: TCosmosLogsController;
begin
 //Registra um log quando ocorrer uma exceção não tratada pela aplicação.

  if E is EIdSocketError then
  begin
    AppEvents.CancelDispatch;
    MessageDlg('A conexão com o servidor remoto foi perdida. Será necessário reiniciar a autenticação para continuar. Mensagem de erro recebida:'#13#10#13#10 + E.Message, mtError, [mbOK], 0);
    IRemoteCon.CloseConnection;
    Abort;
  end;

 //Captura erros de campos requiridos não preenchidos.
 if (E is EDatabaseError) and (Pos('must have a value', E.Message) > 0) then //do not localize!
  self.DlgMessage.ErrorMessage(TCosmosTitles.UpdateData, TCosmosErrorMsg.RequiredFields);
 {Somente registra logs de exceções que não forem do tipo TDBXError. Isso porque
 esse tipo de exceção é tratado em outro manipulador.}
 if not (E is TDBXError) and (Assigned(self.MainLog)) then
  begin
   aLogObj := CreateLogsObject;

   try
    aLogObj.RegisterError(E.Message);

   finally
    aLogObj.Free;
   end;
  end;
end;

procedure TFrmMainClientGUI.OnActiveFormChange(Sender: TObject);
begin
 //Associa todas as janelas criadas do sistema ao objeto de hint ativo.
 if Assigned(Screen.ActiveForm) then
  Screen.ActiveForm.CustomHint := self.CustomHintObj;
end;

procedure TFrmMainClientGUI.CloseTrayIcon;
begin
 {Fecha um ícone ao lado do relógio.}
  if Assigned(FTrayIcon) then
   begin
    FTrayIcon.Visible := False;
    FreeAndNil(FTrayIcon);
   end;
end;

procedure TFrmMainClientGUI.CloseApplication;
begin
 ActClose.Execute;
end;

procedure TFrmMainClientGUI.LoadLogsConfigurations;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
{Carrega as configurações de registro de logs da aplicação em execução.}
 FLogEvents := [];

 AXMLDoc := self.CreateXMLDocument;
 AXMLDoc.FileName  := CosmosAppInfo.GetCommonConfigurationsFile;

 try
  if not TShellFiles.FileExists(AXMLDoc.FileName) then
   raise ELogSystem.Create(Format(TCosmosErrorMsg.CantOpenFileConfigurationsAll, [AXMLDoc.FileName]));

  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('LogsInfo'); //do not localize!
  ANode := ANode.ChildNodes.FindNode('LogsFile'); //do not localize!
  ANode := ANode.ChildNodes.FindNode('Info'); //do not localize!

  //Configurações de geração de logs do servidor.
  FLogsFilesPath := ANode.Attributes['LogsFilesPath']; //do not localize!
  FMaxFileSize := ANode.Attributes['MaxFileSize']; //default 512kb 524288 //do not localize!

  if FLogsFilesPath = '' then
   Exit;

  ANode := ANode.ParentNode.ParentNode;//Retorna dois níveis acima.
  ANode := ANode.ChildNodes.FindNode(CosmosModuleShortName);

  if (ANode <> nil) then
    begin
      //Recupera o nome do arquivo corrente de logs.
      ANode := ANode.ChildNodes.FindNode('FileName'); //do not localize!
      CurrentLogFile := ANode.Attributes['CurrentFile']; //do not localize!

      //Recupera as configuraçãoes de tipos de logs que serão gerados.
      ANode := ANode.ParentNode;
      ANode := ANode.ChildNodes.FindNode('Info'); //do not localize!
      //Logs de conexão
      if ANode.Attributes['ActivateOnConnectSucessLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnConnect];

      if ANode.Attributes['ActivateOnConnectErrorLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnConnectError];

      if ANode.Attributes['ActivateOnConnectCloseLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnConnectClose];

      //Logs de autenticação
      if ANode.Attributes['ActivateOnAuthenticateSucessLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnAuthenticateSucess];

      if ANode.Attributes['ActivateOnAuthenticateFailLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnAuthenticateFail];

      //Logs de chamadas de métodos remotos
      if ANode.Attributes['ActivateOnMethodsCallSucessLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnMethodCall];

      if ANode.Attributes['ActivateOnMethodsCallFailLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnMethodCallError];

      //Logs de falhas de sistema
      if ANode.Attributes['ActivateOnApplicationFailLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnError];

      //Logs de informações e avisos.
      if ANode.Attributes['ActivateOnInformationLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnInformation];

      if ANode.Attributes['ActivateOnWarningLogs'] = True then //do not localize!
       FLogEvents := FLogEvents + [leOnWarning];
    end;

  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);

  //Cria a pasta dos arquivos de logs, caso ainda não exista.
  try
   if not TShellFolders.FolderExists(FLogsFilesPath) then
    if not TShellFolders.CreateFolder(FLogsFilesPath) then
     raise ECosmosSystemFailure.Create(Format(TCosmosErrorMsg.CreateLogsFolder, [FLogsFilesPath]));

  except
   on E: Exception do
    begin
     //Não pode continuar sem que a pasta dos logs esteja correta.
     DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, Format(TCosmosErrorMsg.CreateLogsFolder, [FLogsFilesPath]));
     Application.Terminate;
    end;
  end;

 except
  on E: ELogSystem do
   begin
    ShowMessage(E.Message);
    Application.Terminate;
   end;
  on E: Exception do
   begin
     //Não pode continuar sem que os logs estejam configurados.
     ShowMessage(Format(TCosmosErrorMsg.InitializationLogs , [self.ClassName]) + #13 + E.Message);
     Application.Terminate;
   end;
 end;
end;

function TFrmMainClientGUI.CreateMessageData(Code, HelpContext: integer; MessageText,
  MessageTitle: string; MessageType: TMessageType): TMessageData;
begin
 {Cria um objeto TMessageData já pré-configurado para o contexto da aplicação
  Cosmos que está sendo executada.}
 Result := TMessageData.Create;
 Result.Code := Code;
 Result.HelpContext := HelpContext;
 Result.MessageText := MessageText;
 Result.MessageTitle := MessageTitle;
 Result.MessageType := MessageType;
 Result.CosmosModule := self.CosmosModule;

 if Assigned(IRemoteCon) then
  begin
   Result.SetMessageInfo(miUserName, IRemoteCon.ConnectedUser);
   Result.SetMessageInfo(miRoleName, IRemoteCon.ConnectedUserRoles);
  end;
end;

function TFrmMainClientGUI.CreateMessageData(MessageText, MessageTitle: string;
  MessageType: TMessageType): TMessageData;
begin
 {Cria um objeto TMessageData já pré-configurado para o contexto da aplicação
  Cosmos que está sendo executada.}
 Result := TMessageData.Create;
 Result.MessageText := MessageText;
 Result.MessageTitle := MessageTitle;
 Result.MessageType := MessageType;
 Result.CosmosModule := self.CosmosModule;

 if Assigned(IRemoteCon) then
  begin
   Result.SetMessageInfo(miUserName, IRemoteCon.ConnectedUser);
   Result.SetMessageInfo(miRoleName, IRemoteCon.ConnectedUserRoles);
  end;
end;

procedure TFrmMainClientGUI.CreateMyCosmosFolder;
var
 ACosmosApp: TCosmosApplication;
begin
{Este método não cria a pasta do usuário diretamente. Apenas cria uma classe que
 verificará se a estrutura completa (pasta e arquivos) existe. Caso não exista, cria-os.}
 ACosmosApp := TCosmosApplication.Create;
 ACosmosApp.UserConfigFile := self.UserConfigurationsFile;

 try
   if not ACosmosApp.HasUserFiles then
    ACosmosApp.CreateNewFiles;

 except
  on E: Exception do
   begin
    DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.CreateMyCosmosFolder);
    MainLog.RegisterError(TCosmosErrorMsg.CreateMyCosmosFolder + #13 + E.Message);
   end;
 end;
end;

procedure TFrmMainClientGUI.CustomDlgShow(Sender: TObject);
begin
{Modifica a interface da janela de controle de recursos disponíveis. São alterados
 aqui principalmente os texto de cada controle exibido.}
 with CustomDlg.CustomizeForm do
  begin
   ShowHint := True;
   Caption := TCustomizeDlgMsg.Caption;
   CloseBtn.Caption := TCustomizeDlgMsg.CloseBtnCaption;
   CloseItem.Caption := CloseBtn.Caption;
   ToolbarsTab.Caption := TCustomizeDlgMsg.ToolbarsTabCaption;
   ActionsTab.Caption := TCustomizeDlgMsg.ActionsTabCaption;
   OptionsTab.Caption := TCustomizeDlgMsg.OptionsTabCaption;
   ToolbarsLbl.Caption := TCustomizeDlgMsg.ToolbarsLblCaption;
   LargeIconsChk.Caption := TCustomizeDlgMsg.LargeIconsChkCaption;
   LargeIconsChk.Width := LargeIconsChk.Width + 15;
   DescGroupBox.Caption := TCustomizeDlgMsg.DescGroupBoxCaption;
   CaptionOptionsGrp.Caption := TCustomizeDlgMsg.CaptionOptionsGrpCaption;
   Label2.Visible := False;
   SeparatorBtn.Caption := TCustomizeDlgMsg.SeparatorBtnCaption;
   SeparatorBtn.Hint := TCustomizeDlgMsg.SeparatorBtnHint;
   label4.Caption := TCustomizeDlgMsg.Label4Caption;
   ApplyToAllActn.Caption := TCustomizeDlgMsg.ApplyToAllActnCaption;
   ActionsCatLbl.Caption := TCustomizeDlgMsg.ActionsCatLblCaption;
   ActionsActionsLbl.Caption := TCustomizeDlgMsg.ActionsActionsLblCaption;
   InfoLbl.Caption := TCustomizeDlgMsg.InfoLblCaption;
   PersonalizeLbl.Caption := TCustomizeDlgMsg.PersonalizeLblCaption;
   RecentlyUsedActn.Caption := TCustomizeDlgMsg.RecentlyUsedActnCaption;
   RecentlyUsedChk.Caption := RecentlyUsedActn.Caption;
   ShowHintsActn.Caption := TCustomizeDlgMsg.ShowHintsActnCaption;
   ShowShortCutsInTipsActn.Caption := TCustomizeDlgMsg.ShowShortCutsInTipsActnCaption;
   Label1.Caption := TCustomizeDlgMsg.Label1Caption;
   ResetUsageDataActn.Caption := TCustomizeDlgMsg.ResetUsageDataActnCaption;
   OtherLbl.Caption := TCustomizeDlgMsg.OtherLblCaption;
   Height := self.Height div 2;
   Width := Height;
  end;
end;

function TFrmMainClientGUI.EncriptString(const InString: string): string;
begin
//Criptografa uma string no padrão Blowfish128.
 Result := TCripterFactory.Criptografar(InString);
end;

function TFrmMainClientGUI.DecryptString(const InString: string): string;
begin
//Descriptografa uma string no padrão Blowfish128.
  Result := TCripterFactory.Descriptografar(InString);
end;

function TFrmMainClientGUI.HashString(const InString: string): string;
begin
 //Cria um hash de uma string usando o padrão SHA512.
  Result := TCripterFactory.HashValue(InString);
end;

procedure TFrmMainClientGUI.DoAplicateCustomHintObject(
  const CustomHint: TCustomHint);
var
I: integer;
begin
 {Aplica o objeto passado em parâmetros em todos os controles da janela principal.}
  self.CustomHint := CustomHint;

  for I := 0 to self.ControlCount - 1 do
   self.Controls[I].CustomHint := CustomHint;
end;

procedure TFrmMainClientGUI.DockClient(ClientControl: TWinControl);
begin
 if PnlLeftDock.DockClientCount = 0 then
  begin
   ClientControl.ManualDock(PnlLeftDock, nil);
  end
 else
  begin
   ClientControl.ManualDock(PnlLeftDock, nil, alBottom);
  end;

 ClientControl.Visible := True;
end;

procedure TFrmMainClientGUI.DockTabLeftTabRemoved(Sender: TObject);
begin
 TDockTabSet(Sender).Visible := TDockTabSet(Sender).Tabs.Count > 0;
end;

procedure TFrmMainClientGUI.DockTabTabRemoved(Sender: TObject);
begin
 TDockTabSet(Sender).Visible := TDockTabSet(Sender).Tabs.Count > 0;
end;

procedure TFrmMainClientGUI.DropCategory(Caption: string);
var
I, P: integer;
TopItem: TActionClientItem;
s: string;
begin
{Destrói os itens de uma categoria inteira.}
 I := FrmModernMenu.BtManager.Categories.IndexOf(Caption);
 if I >= 0 then
  FrmModernMenu.BtManager.Categories.Delete(I);

 for I := 0 to Pred(WindowMenu.Items.Count) do
  begin
   TopItem := WindowMenu.Items.ActionClients[I];
   s := TopItem.Caption;
   P := Pos('&', s);
   if P >= 0 then
    Delete(s, P,1);

   if S = Caption then
    begin
     WindowMenu.Items.Delete(I);
     Break;
    end;
  end;
end;

function TFrmMainClientGUI.ExecuteAction(const Action: TBasicAction): boolean;
begin
 Result := False;
 if Action <> nil then
  Result := Action.Execute;
end;

procedure TFrmMainClientGUI.ExecuteUpdate;
var
  AModule: HModule;
  ADataModule: TDataModule;
  IUpdater: ICosmosUpdater;
begin
{Inicia o processo de atualização do sistema Cosmos.}
  ADataModule := LoadDataModule('updater.bpl', 'TDMUpdater', AModule); //do not localize!

   try
    if AModule <> 0 then
     begin
       if Supports(ADataModule, ICosmosUpdater) then
         IUpdater := ADataModule as ICosmosUpdater;
       if Assigned(IUpdater) then
         begin
          IUpdater.ExecuteUpdate;
          ADataModule.Free;
         end;
     end;

   finally
     if Assigned(IUpdater) then
      begin
       IUpdater := nil;
       UnloadPackage(AModule);
      end;
   end;
end;

function TFrmMainClientGUI.ExecuteWizard(const LibraryName,
  ClassName: string): boolean;
begin
 //Executa um assistente localizado em uma biblioteca dinâmica.
 Result := TCosmosWizardsDialogs.ExecuteWizard(LibraryName, ClassName);
end;

function TFrmMainClientGUI.CreateLogsObject: TCosmosLogsController;
var
  ACosmosApp: TCosmosApplication;
begin
  //Cria o objeto que manipula a geração dos logs e o configura.
  ACosmosApp := TCosmosApplication.Create;
  Result := TCosmosLogsController.Create(FLogsFilesPath, 'log', TEncoding.UTF8, LogEvents); //do not localize!

  try
   Result.CosmosAppName := self.GetCosmosModuleName;
   Result.CurrentFile := self.CurrentLogFile;
   Result.MaxFileSize := FMaxFileSize;
   Result.Prefix := ACosmosApp.GetLogPrefix(CosmosModule);
   Result.OnNewFile := self.RegisterLogFileName;

   if Assigned(ACosmosApp) then FreeAndNil(ACosmosApp);

  except
   on E: Exception do
    begin
     self.ShowError(TCosmosTitles.SystemFailure, E.Message);
     if Assigned(ACosmosApp) then FreeAndNil(ACosmosApp);
     Abort;
    end;
  end;
end;

function TFrmMainClientGUI.CreateXMLDocument: TXMLDocument;
begin
 {Cria um objeto de manipulação de arquivos XML's e cinfigura-o.}
  Result := TXMLDocument.Create(self);
  Result.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doNamespaceDecl];
  Result.NodeIndentStr := ''#13'';
end;

procedure TFrmMainClientGUI.FormActivate(Sender: TObject);
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
 WState: TWindowState;
 AMessageData: TMessageData;
begin
//Lê as configurações de inicialização
 if not FStarted then
  begin
   Started := True;
   {Cria e exibe a janela de menu lateral. Ela ocupará toda a área cliente do
    painel esquerdo.}
   self.PnlLeftDock.DockOrientation := doVertical;
   self.PnlLeftDock.UseDockManager := True;

   if self.CosmosModule in [cmSecretarias, cmFinanceiro, cmConferencias, cmUsuarios, cmFocos] then
    begin
     if not Assigned(FrmModernMenu) then
      FrmModernMenu := TFrmModernMenu.Create(Application);

     DockClient(FrmModernMenu);
    end;

   //Encerra a aplicação caso o local dos arquivos de logs não tenha sido identificado. Computador que não roda XP.
   if ((FLogsFilesPath.Trim = '') and not (TWinShell.IsWinXP)) then
    begin
      DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ReadCosmosLogsFilesPath);
      Application.Terminate;
    end;

   //Encerra a aplicação caso o local dos arquivos de logs não tenha sido identificado. Computador que roda XP.
   if ((FLogsFilesPath.Trim = '') and (TWinShell.IsWinXP)) then
    begin
      DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ReadCosmosLogsFilesPathXP);
      Application.Terminate;
    end;

   AXMLDoc := self.CreateXMLDocument;

   try
    AXMLDoc.FileName := UserConfigurationsFile;

    AXMLDoc.Active := True;
    ANode := AXMLDoc.DocumentElement;
    ANode := ANode.ChildNodes.FindNode('CosmosVisual'); //do not localize!
    ANode := ANode.ChildNodes.FindNode(CosmosModuleShortName);
    ANode := ANode.ChildNodes.FindNode('Visual'); //do not localize!

    //Define o estado da janela principal. Esta configuração deve ser executada
     //aqui e não no método ReadStartupOptions.
    WState := TWindowState(Ord(Integer(ANode.Attributes['MainStatus']))); //do not localize!
    if WState = wsMaximized then
     Self.WindowState := WState;

    {Agora, cria e exibe a janela "Windows Manager". Ela deve ficar logo abaixo da
     janela de menus rápidos.}
    if ANode.Attributes['ShowWindowsManager'] then //do not localize!
     begin
      if not Assigned(FrmWindowsManager) then
       FrmWindowsManager := TFrmWindowsManager.Create(Application);

      self.DockClient(FrmWindowsManager);
     end;

   finally
    if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
   end;

   if not Registered then
    begin
     ActRegister.Execute;
     if not Registered then
       begin
        AMessageData := self.CreateMessageData(TMessagesConst.IdMsg_UnregisteredApp, 1,
          TCosmosRegister.InfoCloseUnregisteredApp, TCosmosTitles.UnregisteredApp, mtpInformation);
        try
         self.DlgMessage.Execute(AMessageData);

        finally
          if Assigned(AMessageData) then AMessageData.Free;
        end;

        Application.Terminate;
        Exit;
       end;
    end;

   ReadMyStartupOptions;

   if ShowTips then
    ShowTips := LoadTips;

   if AutoUpdate then
     self.StartUpdate;

   if ShowLogin then
    ActLogin.Execute;
  end;
end;

procedure TFrmMainClientGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 try
  WriteStartupOptions;

 except
  on E: Exception do
   begin
    DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
    Application.Terminate;
   end;
 end;
end;

procedure TFrmMainClientGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ActCloseAllWindows.Enabled then
    CanClose := ActCloseAllWindows.Execute;
end;

procedure TFrmMainClientGUI.FormCreate(Sender: TObject);
var
 I: integer;
 ProgressBarStyle: integer;
 AFormInfoFile: string;
begin
 FRegistered := True; //O registro foi eliminado na versão 2.0
 //Cria alguns objetos essenciais que estarão disponíveis durante toda a execução.
 FCosmosAppInfo := TCosmosAppInfo.Create;
 FDlgMessage := TDlgMessage.Create;

 Application.HelpFile := CosmosAppInfo.GetHelpFile(CosmosModule);
 //Carrega a tela de abertura.
 LoadSplashForm;

 //Encontra o menu "Janelas". É o penúltimo menu da primeira barra.
 I := ActionManager.ActionBars.ActionBars[0].Items.Count;
 FWindowMenu := ActionManager.ActionBars.ActionBars[0].Items.ActionClients[I - 2];

 Application.OnHint := OnShowHint;

 //Coloca a progressbar na status bar
 PBar.Parent := MainStatusBar;
 //Remove a borda da progressbar
 ProgressBarStyle := GetWindowLong(PBar.Handle, GWL_EXSTYLE);
 ProgressBarStyle := ProgressBarStyle - WS_EX_STATICEDGE;
 SetWindowLong(Pbar.Handle, GWL_EXSTYLE, ProgressBarStyle);

 //Recupera o caminho de arquivos de configuração dos aplicativos Cosmos.
 FUserConfigurationsFile := CosmosAppInfo.GetUserConfigurationsFile;
 FCommonConfigurationsFile := CosmosAppInfo.GetCommonConfigurationsFile;

 //Obtém as configurações de geração de logs
 LoadLogsConfigurations;

 AFormInfoFile := CosmosAppInfo.GetFormsInfoFile;

 //Checa se as pastas do usuário corrente estão criadas.
 CreateMyCosmosFolder;

 //Classe gerenciadora de janelas
 FWinManager := TWindowsManager.Create(AFormInfoFile);

 //Classe "observável" que notifica sobre a mudança do foco ativo.
 FChangeFocusObservable := TChangeFocusObservable.Create;

 //Classe "observadora" que receber notificações sobre a mudança do foco ativo.
 FChangeFocusObserver := TChangeFocusObserver.Create;
 FChangeFocusObserver.OnNotifyChangeFocus := OnNotifyChangeFocus;
 FChangeFocusObservable.RegisterObserver(FChangeFocusObserver);

 Screen.OnActiveFormChange := OnActiveFormChange;
 //Cria os objetos de geração de logs.
 CreateLogsObject;
end;

procedure TFrmMainClientGUI.FormDestroy(Sender: TObject);
begin
 {Destrói os ojetos criados durante a criação do formulário.}
 if Assigned(FCosmosAppInfo) then
   FCosmosAppInfo.Free;

 if Assigned(FChangeFocusObserver) then
  begin
   FChangeFocusObservable.UnregisterObserver(FChangeFocusObserver);
   FChangeFocusObserver.Free;
  end;

 if Assigned(FChangeFocusObservable) then
   FChangeFocusObservable.Free;

 FWinManager := nil;
end;

procedure TFrmMainClientGUI.FormShow(Sender: TObject);
begin
 CustomDLg.ActionManager := self.ActionManager;

 {if IRemoteCon <> nil then
  begin
   IRemoteCon.ConnectionBroker.BeforeDisconnect := OnBeforeDisconnectEvent;
   IRemoteCon.ConnectionBroker.AfterDisconnect := OnAfterDisconnectEvent;
  end; }
end;

function TFrmMainClientGUI.GetActiveDockedForm: TCustomForm;
begin
 Result := FActiveDockedForm;
end;

function TFrmMainClientGUI.GetActiveFocus: TFocus;
begin
 Result := FActiveFocus;
end;

function TFrmMainClientGUI.GetApplicationComponents: IApplicationComponents;
begin
 Result := self as IApplicationComponents;
end;

function TFrmMainClientGUI.GetIStatusBar: IStatusBar;
begin
 Result := self as IStatusBar;
end;

function TFrmMainClientGUI.GetITrayIcon: ITrayIcon;
begin
 Result := self as ITrayIcon;
end;

function TFrmMainClientGUI.GetIUtilities: ICosmosUtilities;
begin
 Result := self as ICosmosUtilities;
end;

function TFrmMainClientGUI.GetCamposTrabalho: TCamposTrabalho;
begin
 if IRemoteCon <> nil then
  Result := IRemoteCon.CurrentConnectionInfo.CamposTrabalho
 else
  Result := [];
end;

function TFrmMainClientGUI.GetChangeFocusNotifier: IChangeFocusObservable;
begin
 if Assigned(FChangeFocusObservable) then
   Result := FChangeFocusObservable as IChangeFocusObservable
 else
   Result := nil;
end;

function TFrmMainClientGUI.GetCosmosInterface(const ModuleName: TFileName;
  ModuleClass: string; out Module: HModule): ICosmosInterfaces;
var
  AClass: TPersistentClass;
begin
 Result := nil;

 try
  Module := LoadPackage(ModuleName);

  if Module <> 0 then
   begin
    AClass := GetClass(ModuleClass);

    if AClass = nil then
     raise exception.Create(TCosmosErrorMsg.UnregisteredClass);

    if AClass <> nil then
     Result := TComponentClass(AClass).Create(Application) as ICosmosInterfaces;
   end;

 except
  raise;
 end;
end;

function TFrmMainClientGUI.GetCosmosModuleName: string;
begin
 //Obtém o nome do aplicativo Cosmos que está sendo executado.
 case CosmosModule of
  cmSecretarias: Result := TCosmosAppName.CosmosSecretarias;
  cmConferencias: Result := TCosmosAppName.CosmosConferencias;
  cmFinanceiro: Result := TCosmosAppName.CosmosFinanceiro;
  cmUsuarios: Result := TCosmosAppName.CosmosUsuarios;
  cmFocos: Result := TCosmosAppName.CosmosFocos;
 end;
end;

function TFrmMainClientGUI.GetCosmosModuleShortName: string;
begin
 //Obtém o nome abreviado do aplicativo Cosmos que está sendo executado.
  case CosmosModule of
   cmFocos: Result := TCosmosAppName.CosmosFocosId;
   cmSecretarias: Result := TCosmosAppName.CosmosSecretariasId;
   cmFinanceiro: Result := TCosmosAppName.CosmosFinanceiroId;
   cmUsuarios: Result := TCosmosAppName.CosmosUsuariosId;
   cmConferencias: Result := TCosmosAppName.CosmosConferenciasId;
  end;
end;

function TFrmMainClientGUI.GetCosmosRootFolder: string;
begin
//Retorna a pasta-raíz do Cosmos
 Result := FCosmosAppInfo.ReadInstallationPath;
end;

function TFrmMainClientGUI.GetCosmosUpdater: ICosmosUpdater;
begin
//Obtém uma instância da interface ICosmosUpdater. (to-do)
 Result := self.CosmosUpdater;
end;

function TFrmMainClientGUI.GetCurrentConnection: TCosmosSecurity;
begin
 {Obtém uma referência ao objeto TCosmosSecurity responsável por informações de
  segurança da seção corrente.}
 if Assigned(IRemoteCon) then
  Result := IRemoteCon.CurrentConnectionInfo
 else
  Result := nil;
end;

function TFrmMainClientGUI.GetCustomHintObj: TCustomHint;
begin
 Result := self.CustomHint;
end;

function TFrmMainClientGUI.GetDlgMessage: IDlgMessage;
begin
 //Obtém a interface IDlgMessage, para a exibição de caixas de mensagem.
 Result := nil;
 if FDlgMessage <> nil then
  Result := FDlgMessage as IDlgMessage;
end;

function TFrmMainClientGUI.GetFullScreen: boolean;
begin
 Result := FFullScreen;
end;

function TFrmMainClientGUI.GetGestureManager: TCustomGestureManager;
begin
 Result := GestureManager1;
end;

function TFrmMainClientGUI.GetIApplicationPaths: ICosmosApplicationPaths;
begin
 Result := FCosmosAppInfo as ICosmosApplicationPaths;
end;

function TFrmMainClientGUI.GetInterfaceStyle: TActionBarStyle;
begin
 Result := self.ActionManager.Style;
end;

function TFrmMainClientGUI.GetIProgressBar: IProgressBar;
begin
 Result := self as IProgressBar;
end;

function TFrmMainClientGUI.GetMainForm: TForm;
begin
 Result := self;
end;

function TFrmMainClientGUI.GetMainLog: ICosmosLogs;
var
 aLogObj: TCosmosLogsController;
begin
 aLogObj := CreateLogsObject;
 Result := aLogObj as ICosmosLogs;
end;

function TFrmMainClientGUI.GetMaxPosition: integer;
begin
 Result := PBar.Max;
end;

function TFrmMainClientGUI.GetOnBallonClickEvent: TNotifyEvent;
begin
//To-do.
end;

function TFrmMainClientGUI.GetPosition: integer;
begin
 Result := PBar.Position;
end;

function TFrmMainClientGUI.GetReportsFolder: string;
begin
{Retorna o caminho da pasta de relatórios de cada módulo do Cosmos.}
 Result := CosmosAppInfo.ReadReportsFolder(CosmosModule);

 case CosmosModule of
  cmFocos: Result := Result + TCosmosPaths.FocosReportsFolder;
  cmSecretarias: Result := Result + TCosmosPaths.SecretariasReportsFolder;
  cmConferencias: Result := Result + TCosmosPaths.ConferenciasReportsFolder;
  cmFinanceiro: Result := Result + TCosmosPaths.FinanceiroReportsFolder;
  cmUsuarios: Result := Result + TCosmosPaths.UsuariosReportsFolder;
 end;
end;

function TFrmMainClientGUI.GetStyleControlClass: TCustomActionControlClass;
begin
 Result := ActionManager.Style.GetControlClass(ActionMainMenuBar1, ActionMainMenuBar1.ActionClient.Items.ActionClients[0]);
end;

function TFrmMainClientGUI.GetTabsStyle: TTabSetTabStyle;
begin
 Result := DockTab.Style;
end;

function TFrmMainClientGUI.GetTitle: string;
begin
 Result := Application.Title;
end;

function TFrmMainClientGUI.GetVisible: boolean;
begin
 Result := PBar.Visible;
end;

function TFrmMainClientGUI.GetWindowsManager: TWindowsManager;
begin
  Result := FWinManager;
end;

function TFrmMainClientGUI.LoadClass(const ModuleName: TFileName; ModuleClass: string;
  out Module: HModule): TInterfacedPersistent;
var
  AClass: TPersistentClass;
begin
 Result := nil;

 try
  Module := LoadPackage(ModuleName);

  if Module <> 0 then
   begin
    AClass := GetClass(ModuleClass);

    if AClass = nil then
     raise exception.Create(TCosmosErrorMsg.UnregisteredClass);

    if AClass <> nil then
     Result := TPersistentClass(AClass).Create as TInterfacedPersistent;
   end;

 except
  raise;
 end;
end;

function TFrmMainClientGUI.LoadDataModule(const ModuleName: TFileName;
  ModuleClass: string; out Module: HModule): TDataModule;
var
 AClass: TPersistentClass;
begin
//Carrega um módulo de dados hospedado em uma biblioteca dinâmica.
 Result := nil;

 try
  Module := LoadPackage(ModuleName);

  if Module <> 0 then
   begin
    AClass := GetClass(ModuleClass);

    if AClass = nil then
     raise exception.Create(TCosmosErrorMsg.UnregisteredClass);

    if AClass <> nil then
     Result := TComponentClass(AClass).Create(Application) as TDataModule;
   end;

 except
  raise;
 end;
end;

function TFrmMainClientGUI.LoadDialog(const ModuleName: TFileName; ModuleClass: string;
  out Module: HModule): TForm;
var
  AClass: TPersistentClass;
begin
//Carrega uma janela hospedada em uma biblioteca dinâmica.
 Result := nil;

 try
  Module := LoadPackage(ModuleName);

  if Module <> 0 then
   begin
    AClass := GetClass(ModuleClass);

    if AClass = nil then
     raise exception.Create(TCosmosErrorMsg.UnregisteredClass);

    if AClass <> nil then
     Result := TComponentClass(AClass).Create(Application) as TForm;
   end;

 except
  raise;
 end;
end;

function TFrmMainClientGUI.LoadModule(const ModuleName: TFileName; ModuleClass: string;
  out Module: HModule): TDataModule;
var
  AClass: TPersistentClass;
begin
 {Carrga um módulo externo e retorna uma instância de uma classe descendente de
  TDataModule que provê acesso aos recursos do módulo externo.}
 Result := nil;

 try
  Module := LoadPackage(ModuleName);

  if Module <> 0 then
   begin
    AClass := GetClass(ModuleClass);

    if AClass = nil then
     raise exception.Create(Format(TCosmosErrorMsg.UnregisteredClass, [ModuleName]));

    if AClass <> nil then
     Result := TComponentClass(AClass).Create(Application) as TDataModule;
   end;

 except
  raise;
 end;
end;

function TFrmMainClientGUI.LoadReportCenter(var AModule: HModule): IReportCenter;
var
 AClass: TPersistentClass;
 AForm: TForm;
begin
  inherited;
  {Carrega a Central de Relatórios dos aplicativos Cosmos.}
  Result := nil;

  AModule := LoadPackage('repcen.bpl'); //do not localize!
  if AModule <> 0 then
   begin
    AClass := GetClass('TFrmReportCenter'); //do not localize!
    if AClass <> nil then
     begin
      AForm := TComponentClass(AClass).Create(Application) as TForm;
      Result := AForm as IReportCenter;
     end;
   end;
end;

procedure TFrmMainClientGUI.LoadSplashForm;
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAbout: ICosmosSplash;
begin
 {Carrega a janela de "splash" dos aplicativos Cosmos.}
 AClass := LoadClass('splash.bpl', 'TSplashControler', AModule); //do not localize!

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAbout := AClass as ICosmosSplash;
    if IAbout <> nil then
     begin
      IAbout.ShowAppSplash(CosmosModule);
     end;
   end;

 finally
  if Assigned(IAbout) then IAbout := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

function TFrmMainClientGUI.LoadTips: boolean;
var
  AModule: HModule;
  AForm: TForm;
  ITips: ICosmosTips;
  ATipsFile, TipsFile: string;
begin
 {Carrega a janela de discas que é implementada em um módulo externo.}
 Result := True;
 AForm := LoadDialog('tips.bpl', 'TFrmTips', AModule); //do not localize!

 try
  if AModule <> 0 then
   begin
    with AForm do
     begin
      if Supports(AForm, ICosmosTips) then
        ITips := AForm as ICosmosTips;

      if Assigned(ITips) then
       begin
        case self.CosmosModule of
          cmFocos: ATipsFile := TCosmosFiles.TipsGFocos;
          cmSecretarias: ATipsFile := TCosmosFiles.TipsSecretarias;
          cmFinanceiro: ATipsFile := TCosmosFiles.TipsFinanceiro;
          cmConferencias: ATipsFile := TCosmosFiles.TipsGConferencias;
          cmUsuarios: ATipsFile := TCosmosFiles.TipsGUsuarios;
        end;

        TipsFile := self.CosmosAppInfo.ReadHelpFilesPath + ATipsFile;
        Result := ITips.ShowTips(TipsFile);
       end;
      Free;
     end;
   end;

 finally
  if Assigned(ITips) then ITips := nil;
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmMainClientGUI.LoadUserFocus(const UserName: string);
var
  AModule: HModule;
  AForm: TForm;
  IOpenFocus: ICosmosOpenFocus;
begin
//Exibe os focos que podem ser acessados pelo usuário
  AForm := self.LoadDialog('opfocus.bpl', 'TFrmOpenFocus', AModule); //do not localize!

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ICosmosOpenFocus) then
        IOpenFocus := AForm as ICosmosOpenFocus;
       if Assigned(IOpenFocus) then
        begin
         FActiveFocus := IOpenFocus.OpenFocus(UserName);

         if FActiveFocus = nil then
          begin
           IRemoteCon.CloseConnection;
           ActLogin.Execute;
          end
         else
          begin
           Caption := Application.Title + ' - ' + FActiveFocus.FocusName;

           //Notifica os observadores acerca da mudança de foco.
           FChangeFocusObservable.NotifyObservers(FActiveFocus);

           FWinManager.UpdateAllForms;
           IRemoteCon.CurrentConnectionInfo.CurrentSection.ConnectionMode := IOpenFocus.ConnectionMode;
          end;
        end;
       Free;
      end;
    end;

  finally
   if Assigned(IOpenFocus) then IOpenFocus := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMainClientGUI.Login;
var
 Logged: boolean;
begin
{O método "LoginDialog" é chamado fora do escopo do método "Login" para
garantir que a dll da janela de login será liberada e não ocorra vazamento da
pilha de memória. Manter assim.}
  self.Update;

  try
    //Chama a função que realiza a conexão com o servidor remoto.
    Logged := IRemoteCon.ConnectServer;

    if Logged then //Se a conexão foi feita com sucesso...
     begin
      //Buferiza no cliente alguns dados muito usados.
      screen.Cursor := crHourGlass;

      IRemoteCon.BufferData(ctPerfis, TCosmosFiles.BufPerfis);
      IRemoteCon.BufferData(ctDiscipulados, TCosmosFiles.BufDiscipulados);
      IRemoteCon.BufferData(ctFocos, TCosmosFiles.BufFocos);
      IRemoteCon.BufferData(ctRelatoriosExternos, TCosmosFiles.BufExternalReports);

      case CosmosModule of
        cmFocos: ;
        cmSecretarias:
         begin
          IRemoteCon.BufferData(ctTiposEventos, TCosmosFiles.BufTiposEventos);
          IRemoteCon.BufferData(ctProfissoes, TCosmosFiles.BufProfissoes);
          IRemoteCon.BufferData(ctEnfermidades, TCosmosFiles.BufEnfermidades);
         end;
        cmFinanceiro: ;
        cmConferencias: ;
        cmUsuarios: ;
      end;

      //Conclui o processo de conexão.
      ConcludeConnectionProcess;

      //Lista os focos para os quais o usuário possui privilégio de acesso.
      case self.CosmosModule of
        cmFocos: ; //do nothing.
        cmSecretarias, cmFinanceiro, cmConferencias: LoadUserFocus(IRemoteCon.CurrentUser.Login);
        cmUsuarios: ; //do nothing.
      end;

      screen.Cursor := crDefault;
      //Redimensiona a barra de status e pinta nela informações sobre a conexão;
      RedrawStatusBar;
     end;

  except
   begin
    FAbortedLogin := True;
    screen.Cursor := crDefault;
    RedrawStatusBar
   end;
  end;
end;

function TFrmMainClientGUI.OpenRegisteredWindow(ModuleName, ClassName: string): TCustomForm;
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TCustomForm;
begin
{Abre uma janela padrão (docked) do sistema Cosmos}
 Result := nil;
 AModule := LoadPackage(ModuleName);
 if AModule <> 0 then
  begin
   AClass := GetClass(ClassName);
   AForm := FWinManager.FindFormByClass(AClass);
   if AForm <> nil then
    begin
     AForm.Show;
     AForm.SetFocus;
    end
   else
    begin
     if AClass = nil then
      raise exception.Create(TCosmosErrorMsg.UnregisteredClass);
     if AClass <> nil then
      FWinManager.CreateForm(TComponentClass(AClass), AForm);

     with AForm do
      begin
       AForm.ManualDock(PnlDock, nil, alClient);
       AForm.Show;
       AForm.SetFocus;
       if Assigned(FrmWindowsManager) then
        FrmWindowsManager.RegisterForm(AForm);
      end;
    end;
   Result := AForm;
  end;
end;

procedure TFrmMainClientGUI.PnlDockDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
 Accept := Source.Control is TFrmCosmosDocked;
end;

procedure TFrmMainClientGUI.PnlLeftDockDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
 Accept := not (Source.Control is TFrmCosmosDocked);
end;

procedure TFrmMainClientGUI.PopupActionBar1Popup(Sender: TObject);
begin
 TPopupActionBar(Sender).Style := self.InterfaceStyle;
end;

procedure TFrmMainClientGUI.ReadCommonStartupOptions;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
{Lê as opções de inicialização válidas para todos os usuários.}
 if not FileExists(CommonConfigurationsFile) then
  Exit;

 AXMLDoc := self.CreateXMLDocument;
 AXMLDoc.FileName := CommonConfigurationsFile;

 try
  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('UpdatesInfo'); //do not localize!
  ANode := ANode.ChildNodes.FindNode('Info'); //do not localize!
  FAutoUpdate := ANode.Attributes['AutoUpdate']; //do not localize!

  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);

 except
  on E: Exception do
   begin
    DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadConfigurations);
    MainLog.RegisterError(E.Message);
    if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
   end;
 end;
end;

procedure TFrmMainClientGUI.ReadMyStartupOptions;
var
 sCosmosModule: string;
 StyleName: string;
 AStyle: TActionBarStyle;
 AXMLDoc: TXMLDocument;
 ANode, AChildNode: IXMLNode;
begin
 {Lê as opções de inicialização do sistema.}
  FStarted := True;
  if not FileExists(UserConfigurationsFile) then
   Exit;

  AXMLDoc := CreateXMLDocument;

 try
  AXMLDoc.FileName := UserConfigurationsFile;

  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('CosmosVisual'); //do not localize!
  sCosmosModule := self.CosmosModuleShortName;

  AChildNode := ANode.ChildNodes.First;

  while (AChildNode <> nil) and (UpperCase(AChildNode.NodeName) <> UpperCase(sCosmosModule)) do
   begin
    AChildNode := AChildNode.NextSibling;
   end;

  AChildNode := AChildNode.ChildNodes.FindNode('Visual'); //do not localize!
  //Lê a opção de estilos de menus
  StyleName := AChildNode.Attributes['Style']; //do not localize!

  if ActionBarStyles.IndexOf(StyleName) >= 0 then
   begin
    AStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf(StyleName)];
    ActionManager.Style := AStyle;
    if AStyle.GetStyleName = 'Platform Default' then //do not localize!
      self.ActPlatformStyle.Checked := True
    else
    if AStyle.GetStyleName = 'XP Style' then  //do not localize!
     self.ActWinXPStyle.Checked := True
    else
    if AStyle.GetStyleName = 'New XP Style' then //do not localize!
     self.ActModernStyle.Checked := True
    else
    if AStyle.GetStyleName = 'Ribbon - Luna' then  //do not localize!
    self.ActRibbonLunaStyle.Checked := True
    else
    if AStyle.GetStyleName = 'Ribbon - Obsidian' then  //do not localize!
    self.ActRibbonObsidianStyle.Checked := True
    else
    if AStyle.GetStyleName = 'Ribbon - Silver' then  //do not localize!
    self.ActRibbonSilverStyle.Checked := True;

   end;

  //Determina o estilo de hint que será usado na aplicação.
   case AChildNode.Attributes['CustomHint'] of //do not localize!
    0:
     begin
      self.CustomHint :=  nil;
      self.ShowHint := True;
     end;
    1:
     begin
      self.CustomHint := self.BalloonHint;
      self.BalloonHint.Style := bhsStandard;
      self.ShowHint := True;
     end;
    2:
     begin
      self.CustomHint := self.BalloonHint;
      self.BalloonHint.Style := bhsBalloon;
      self.ShowHint := True;
     end;
    3:
     begin
      self.CustomHint := nil;
      self.ShowHint := False;
     end
    else
     self.CustomHint :=  nil;
   end;

   DoAplicateCustomHintObject(self.CustomHint);

  //Lê a opção do estilo dos DockTabsets
  DockTab.Style := TTabSetTabStyle(AChildNode.Attributes['TabsStyle']); //do not localize!
  DockTabLeft.Style := DockTab.Style;

  //Lê a opção de usar FullScreen.
  if AChildNode.Attributes['FullScreen'] then //do not localize!
   self.ActFullScreen.Execute;

 //Lê a opção de exibição das dicas ao inicializar
  ShowTips := AChildNode.Attributes['ShowTips']; //do not localize!

  //Lê a opção de exibição da janela de login
  ANode := nil;
  AXMlDoc.Active := False;
  AXMLDoc.FileName := self.IApplicationPaths.GetUserConfigurationsFile;
  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;

  ANode := ANode.ChildNodes.FindNode('CosmosServers'); //do not localize!
  ShowLogin := ANode.Attributes['ShowLogin']; //do not localize!

  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);

  //Agora carrega as configurações do menu lateral.
  if Assigned(FrmModernMenu) then
    FrmModernMenu.LoadOptions(UserConfigurationsFile, CosmosModuleShortName);

  ReadCommonStartupOptions;

  FWinManager.LoadFormInfo(self);

 except
  on E: Exception do
   begin
     MainLog.RegisterError(E.Message);
     if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
   end;
 end;
end;

procedure TFrmMainClientGUI.RegisterLogFileName(var NewFileName: string);
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
{Carrega as configurações de registro de logs da aplicação em execução.}
 AXMLDoc := self.CreateXMLDocument;
 AXMLDoc.FileName  := CosmosAppInfo.GetCommonConfigurationsFile;

 try
 if TWinShell.IsWinXP then
  begin
   AXMLDoc.Encoding := 'utf-8'; //do not localize!
   AXMLDoc.Version := '1.0';  //do not localize!
  end;

  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('LogsInfo'); //do not localize!
  ANode := ANode.ChildNodes.FindNode(CosmosModuleShortName);

  if (ANode <> nil) then
   begin
    ANode := ANode.ChildNodes.FindNode('FileName'); //do not localize!
    ANode.Attributes['CurrentFile'] := NewFileName;  //do not localize!
   end;

  AXMLDoc.SaveToFile(AXMLDoc.FileName);
  self.CurrentLogFile := NewFileName;

 finally
  if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
 end;
end;

procedure TFrmMainClientGUI.RedrawStatusBar;
var
 TotalWidth, PanelWidth: integer;
begin
  //Dimensiona os painéis da barra de status conforme a alargura da janela.
  TotalWidth := self.MainStatusBar.Width;
  PanelWidth := Integer(TotalWidth div 2); //50%
  MainStatusBar.Panels.Items[0].Width := PanelWidth;

  PanelWidth := Integer(PanelWidth div 3); //16%
  MainStatusBar.Panels.Items[1].Width := PanelWidth;
  MainStatusBar.Panels.Items[2].Width := PanelWidth;
  MainStatusBar.Panels.Items[3].Width := PanelWidth;
end;

procedure TFrmMainClientGUI.RestoreWindow(const ClassName: TClass);
var
 AForm: TCustomForm;
begin
{Reexibe uma janela padrão (docked) do sistema Cosmos. Este método é chamado
para reexibir janelas minimizadas ou ocultas atrás de outras janelas.}
 AForm := self.FWinManager.FindFormByClass(ClassName);

 if AForm <> nil then
  begin
   AForm.Show;
   AForm.SetFocus;
  end;
end;

procedure TFrmMainClientGUI.SetActiveDockedForm(Value: TCustomForm);
begin
 FActiveDockedForm := Value;
end;

procedure TFrmMainClientGUI.SetFullScreen(Value: boolean);
var
 I: integer;
begin
//Ativa ou desativa o modo "tela cheia".
 FFullScreen := Value;

 if Assigned(ActionManager) then
  begin
   if Value = False then
    begin
     for I := 0 to Pred(ActionManager.ActionBars.Count) do
      if not (ActionManager.ActionBars.ActionBars[I].ActionBar is TActionMainMenuBar) then
       ActionManager.ActionBars.ActionBars[I].Visible := not FullScreen;
    end
    else
    begin
     for I := Pred(ActionManager.ActionBars.Count) downto 0 do
      if not (ActionManager.ActionBars.ActionBars[I].ActionBar is TActionMainMenuBar) then
       ActionManager.ActionBars.ActionBars[I].Visible := not FullScreen;
    end;
  end;

 MainStatusBar.Visible := not FullScreen;
 PnlLeftDock.Visible := not FullScreen;
end;

procedure TFrmMainClientGUI.SetGetTabsStyle(value: TTabSetTabStyle);
begin
 DockTab.Style := Value;
 FWinManager.UpdateAllFormsElements;
end;

procedure TFrmMainClientGUI.ConcludeConnectionProcess;
begin
{Escreve algumas informações sobre o usuário atualmente conectado, protocolo de
 comunicação em uso e servidor connectado.}
 MainStatusBar.Panels.Items[0].Text := ''; //Limpa as mensagens exibidas durante o processo de conexão.
end;

procedure TFrmMainClientGUI.SetMaxPosition(const Value: integer);
begin
 PBar.Max := Value;
end;

procedure TFrmMainClientGUI.SetPosition(const value: integer);
begin
 PBar.Position := Value;
 MainStatusBar.Update;
end;

procedure TFrmMainClientGUI.SetRegistered;
var
  AModule: HModule;
  AForm: TForm;
  IRegister: IRegisterInfo;
begin
//Escreve o valor do campo FRegistered.
  AForm := self.LoadDialog('regcosmos.bpl', 'TFrmRegister', AModule); //do not localize!
  try
   with AForm do
    begin
     if Supports(AForm, IRegisterInfo) then
      IRegister := AForm as IRegisterInfo;

     if Assigned(IRegister) then
      FRegistered := IRegister.IsRegistered(self.CosmosModule);

     Free;
    end;

    if Assigned(IRegister) then
      IRegister := nil;
    UnloadPackage(AModule);

 except
 {Caso ocorra uma falha na verificação se o aplicativo está registrado, ele
  deve ser fechado. Isto pode ocorrer, por ex., se o arquivo regcosmos.bpl
  não for encontrado.}
  FRegistered := False;
  Application.Terminate;
 end;
end;

procedure TFrmMainClientGUI.SetVisible(const value: boolean);
begin
 if Value = True then
  MainStatusBar.Panels[3].Style := psOwnerDraw
 else
  MainStatusBar.Panels[3].Style := psText;

 PBar.Visible := Value;
end;

procedure TFrmMainClientGUI.ShowError(const Title, Text: string);
begin
  if not Assigned(FTrayIcon) then
   FTrayIcon := TTrayIcon.Create(Application);

  FTrayIcon.Icon := Application.Icon;
  FTrayIcon.BalloonTimeout := 10000;
  FTrayIcon.BalloonFlags := bfError;
  FTrayIcon.BalloonTitle := Title;
  FTrayIcon.BalloonHint := Text;
  FTrayIcon.Visible := True;
  FTrayIcon.ShowBalloonHint;
end;

procedure TFrmMainClientGUI.ShowInfo(const Title, Text: string);
begin
  if not Assigned(FTrayIcon) then
   FTrayIcon := TTrayIcon.Create(Application);

  FTrayIcon.Icon := Application.Icon;
  FTrayIcon.BalloonTimeout := 10000;
  FTrayIcon.BalloonFlags := bfInfo;
  FTrayIcon.BalloonTitle := Title;
  FTrayIcon.BalloonHint := Text;
  FTrayIcon.Visible := True;
  FTrayIcon.ShowBalloonHint;
end;

procedure TFrmMainClientGUI.ShowWarning(const Title, Text: string);
begin
  if not Assigned(FTrayIcon) then
   FTrayIcon := TTrayIcon.Create(Application);

  FTrayIcon.Icon := Application.Icon;
  FTrayIcon.BalloonTimeout := 10000;
  FTrayIcon.BalloonFlags := bfWarning;
  FTrayIcon.BalloonTitle := Title;
  FTrayIcon.BalloonHint := Text;
  FTrayIcon.Visible := True;
  FTrayIcon.ShowBalloonHint;
end;

procedure TFrmMainClientGUI.OnNotifyChangeFocus(Focus: TFocus);
begin
{Implementação padrão (todos apps Cosmos) de notificação da ocorrência de
 mudança do foco ativo.Para tratamentos específicos, cada módulo deve criar
 a sua própria instãncia da classe TChangeFocusObserver.}
  case CosmosModule of
    cmSecretarias, cmFinanceiro, cmConferencias:
      begin
        if (ActiveFocus <> nil) then
          MainStatusBar.Panels.Items[2].Text := ActiveFocus.FocusName
        else
          MainStatusBar.Panels.Items[2].Text := '';
      end;
    cmUsuarios: MainStatusBar.Panels.Items[2].Text := '';
  end;
end;

procedure TFrmMainClientGUI.OnNotifyConnectionStatus(Status: TConnectionStatus);
begin
{Acionado como um evento pelo objeto que está sendo "observado", no módulo
 de dados comum de todas as aplicações clientes. A cada troca de status da conexão
 com o servidor, o objeto "observado" notifica o fato para todos que o estão
 observando. No caso deste form ancestral das aplicações Cosmos, o observador é
  o objeto FConnectionObserver.}
 case Status of
   csHostConnected:
     begin
      Components.StatusBar.WriteText('');
      MainStatusBar.Panels.Items[3].Text := IRemoteCon.ConnectedServer;
     end;
   csHostDisconnected:
     begin
      Components.StatusBar.WriteText('');
      MainStatusBar.Panels.Items[1].Text := '';
      MainStatusBar.Panels.Items[2].Text := '';
      MainStatusBar.Panels.Items[3].Text := '';
     end;
   csUserLocked: ;
   csServerLocked: ;
   csOnConnectingHost:
    begin
     Components.StatusBar.WriteText(Format(TCosmosLogs.ConnectingToHost, [IRemoteCon.ConnectedServer]));
    end;
   csOnDisconnectingHost:
    begin
     Components.StatusBar.WriteText(Format(TCosmosLogs.PrepareDisconnect, [IRemoteCon.ConnectedUser]));
    end;
   csAborted: ;
   csVerifyingIdentity:
    begin
     Components.StatusBar.WriteText(Format(TCosmosLogs.VerifyingIdentity, [IRemoteCon.ConnectedUser]));
    end;
   csGettingAuthorizations:
     begin
      Components.StatusBar.WriteText(Format(TCosmosLogs.GettingAuthorizations, [IRemoteCon.ConnectedUser]));
     end;
   csAuthorizedUser:
     begin
      Components.StatusBar.WriteText(Format(TCosmosLogs.AutenticatedUser, [IRemoteCon.ConnectedUser]));
      MainStatusBar.Panels.Items[1].Text := IRemoteCon.ConnectedUser;
     end;
   csApplyPermissions:
    begin
     Components.StatusBar.WriteText(TCosmosLogs.ApplyPermissions);
    end;
   csLoadingData:
    begin
     Components.StatusBar.WriteText(TCosmosLogs.LoadingData);
    end;
   csRefusedConnection:
    begin
     Components.StatusBar.WriteText(TCosmosErrorMsg.RefusedConnection);
    end;
   csHostNotFound:
    begin
     Components.StatusBar.WriteText(TCosmosErrorMsg.HostNotFound);
    end;
   csTimeoutExpired:
    begin
     Components.StatusBar.WriteText(TCosmosErrorMsg.ConnectionTimeout);
    end;
   csConnectError:
    begin
     Components.StatusBar.WriteText(TCosmosErrorMsg.ConnectError);
    end;
   csAuthenticationInvalid:
    begin
     Components.StatusBar.WriteText(TCosmosErrorMsg.LoginFailure);
    end;
   csCheckingCertificate:
    begin
     Components.StatusBar.WriteText(TCosmosLogs.CheckingCertificate);
    end;
   csCreatingConnectionsPool:
    begin
     Components.StatusBar.WriteText(TCosmosLogs.CreatingConnectionsPool);
    end;
   csBufferingData:
    begin
     Components.StatusBar.WriteText(TCosmosLogs.BufferingData);
    end;
 end;

 Application.ProcessMessages;
end;

procedure TFrmMainClientGUI.OnShowHint(Sender: TObject);
begin
 MainStatusBar.Panels[0].Text := Application.Hint;
end;

procedure TFrmMainClientGUI.StartUpdate;
var
AModule: HModule;
ADataModule: TDataModule;
IUpdater: ICosmosUpdater;
begin
 {Inicia o processo de atualização do sistema Cosmos. Este processo será executado
 em um thread separado. E consiste em:
 1 - Carrega a biblioteca que contém a classe que implementa a atualização.
 2 - Verifica se existem atualizações disponíveis.
 3 - Se positivo, faz download das atualizações.}
 ADataModule := self.LoadModule('updater.bpl', 'TDMUpdater', AModule); //do not localize!

 try
   if ADataModule <> nil then
    begin
     IUpdater := ADataModule as ICosmosUpdater;
     if IUpdater.HasUpdates then
      IUpdater.ExecuteUpdate;
    end;

 finally
   if IUpdater <> nil then IUpdater := nil;
   if ADataModule <> nil then FreeAndNil(ADataModule);
   if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmMainClientGUI.MainStatusBarDblClick(Sender: TObject);
var
  mpt : TPoint;
  x : integer;
  j : integer;
  PanelIndex : integer;
begin
  {Exibe dados da conexão, caso o painel que mostra dados sobre a conexão
  corrente tenha sido clicado.}

  //Captura a posição do mouse em termos de coordenadas de tela (x e y)
  mpt := Mouse.CursorPos;

  //Captura a posição do mouse nas coordenadas da barra de status
  mpt := MainStatusBar.ScreenToClient(mpt) ;

  PanelIndex := -1;
  x := 0;
  for j := 0 to MainStatusBar.Panels.Count - 1 do
  begin
    x := x + MainStatusBar.Panels[j].Width;
    if mpt.X < x then
    begin
      PanelIndex := j;
      Break;
    end;
  end;

  if PanelIndex = -1 then
    PanelIndex := -1 + MainStatusBar.Panels.Count;

  case PanelIndex of
   0: Exit; //Painel de mensagens de ajuda.
   1, 2: ActConnectInfo.Execute;//Painel de usuários e de perfil logados.
   3: Exit; //Painel de servidores e barra de progresso.
  end;
end;

procedure TFrmMainClientGUI.MainStatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
 //Desenha a progressbar na barra de status.
 case Panel.Index of
  0: //Nome do usuário conectado.
   begin
      MainList.Draw(MainStatusBar.Canvas, Rect.Left + 2, Rect.Top, 7);
      MainStatusBar.Canvas.TextOut(Rect.left + 25, Rect.top + 2, Application.Hint);
   end;
  1: //Nome do usuário conectado.
   begin
    if (IRemoteCon <> nil) and (IRemoteCon.Connected) then
     begin
      MainList.Draw(MainStatusBar.Canvas, Rect.Left + 5, Rect.Top + 1, 23);
      MainStatusBar.Canvas.TextOut(Rect.left + 30, Rect.top + 2, IRemoteCon.ConnectedUser);
     end;
   end;
  2: //Foco aberto.
   begin
    case CosmosModule of
      cmSecretarias, cmFinanceiro, cmConferencias:
       begin
        if (ActiveFocus <> nil) then
         begin
          MainList.Draw(MainStatusBar.Canvas, Rect.Left + 5, Rect.Top + 1, 2);
          MainStatusBar.Canvas.TextOut(Rect.left + 30, Rect.top + 2, ActiveFocus.FocusName);
         end
        else
         begin
          MainList.Draw(MainStatusBar.Canvas, Rect.Left + 5, Rect.Top + 1, 2);
          MainStatusBar.Canvas.TextOut(Rect.left + 30, Rect.top + 2, '');
         end
       end;
      cmUsuarios: ;
    end;
   end;
  3: //Progress bar.
   begin
    with PBar do
     begin
      Top := Rect.Top;
      Left := Rect.Left;
      Width := Rect.Right - Rect.Left - 5;
      Height := Rect.Bottom - Rect.Top;
     end;
   end;
 end;
end;

procedure TFrmMainClientGUI.MainStatusBarResize(Sender: TObject);
begin
 RedrawStatusBar;
end;

procedure TFrmMainClientGUI.UnregisterWindow(const ClassName: TClass);
begin
 if Assigned(FrmWindowsManager) then
  FrmWindowsManager.UnregisterForm(ClassName);
end;

procedure TFrmMainClientGUI.UpdateVisualElements;
begin
 FWinManager.UpdateAllFormsElements;
end;

procedure TFrmMainClientGUI.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
//Desconecta da aplicação servidora quando o Windows estiver sendo desligado...
 if IRemoteCon.Connected then
  ActLogOff.Execute;
end;

procedure TFrmMainClientGUI.WriteStartupOptions;
var
 AXMLDoc: TXMLDocument;
 ANode, AChildNode: IXMLNode;
 sCosmosModule: string;
begin
//Escreve as configurações de inicialização ao sair do ambiente .
 if not FileExists(UserConfigurationsFile) then
  Exit;

 AXMLDoc := self.CreateXMLDocument;
 AXMLDoc.FileName := UserConfigurationsFile;

 try
  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('CosmosVisual'); //do not localize!

  sCosmosModule := self.CosmosModuleShortName;

  AChildNode := ANode.ChildNodes.First;

  while (AChildNode <> nil) and (UpperCase(AChildNode.NodeName) <> UpperCase(sCosmosModule)) do
   begin
    AChildNode := AChildNode.NextSibling;
   end;

  AChildNode := AChildNode.ChildNodes.FindNode('Visual');//do not localize!

  AChildNode.Attributes['ShowTips'] := ShowTips; //do not localize!
  AChildNode.Attributes['Style'] := ActionManager.Style.GetStyleName;  //do not localize!

  //Escreve as configurações de estilo dos DockTabSets
  AChildNode.Attributes['TabsStyle'] := Ord(DockTab.Style); //do not localize!

  //Escreve o status da janela principal, exceto se ela esiver minimizada
  if Self.WindowState <> wsMinimized then
    AChildNode.Attributes['MainStatus'] := Ord(Self.WindowState); //do not localize!

 //Estilo de hint
  if (self.CustomHint = nil) and (self.ShowHint = True) then
   AChildNode.Attributes['CustomHint'] :=  0   //do not localize!
  else
  if (self.CustomHint = self.BalloonHint) and (self.BalloonHint.Style = bhsStandard) then
   AChildNode.Attributes['CustomHint'] := 1   //do not localize!
  else
  if (self.CustomHint = self.BalloonHint) and (self.BalloonHint.Style = bhsBalloon) then
   AChildNode.Attributes['CustomHint'] :=  2   //do not localize!
  else
  if (self.CustomHint = nil) and (self.ShowHint = False) then
   AChildNode.Attributes['CustomHint'] := 3;   //do not localize!

 //Configurações de estilo de tabs, conforme tipo enumerado TTabSetTabStyle.
  AChildNode.Attributes['TabsStyle'] := Ord(DockTab.Style);  //do not localize!

  if Assigned(AXMLDoc) then
   begin
    AXMLDoc.SaveToFile(AXMLDoc.FileName);
    FreeAndNil(AXMLDoc);
   end;

 except
   on E: Exception do
    begin
      if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
      DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
      raise;
    end;
 end;
end;

procedure TFrmMainClientGUI.WriteText(const value: string);
begin
 MainStatusBar.Panels.Items[0].Text := Value;
 MainStatusBar.Update;
 MainStatusBar.Canvas.TextOut(25, 2, Value);
end;

{ TConnectionThread }

constructor TConnectionThread.Create(Worker: TConnectionThreadWorker);
begin
  inherited Create(False);
  fWorker := Worker;
  FreeOnTerminate := True;
end;

procedure TConnectionThread.Execute;
begin
  fWorker;
end;

end.
