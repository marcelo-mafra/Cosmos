unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ActnList, ActnCtrls, ToolWin, ActnMan, ActnMenus,
  XPStyleActnCtrls, ImgList, ActiveX, ComCtrls, CategoryButtons, ExtCtrls,
  StdCtrls, ButtonGroup, Tabs, DockTabSet, DB, DBClient, Menus, ActnPopup,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.core.classes, Cosmos.Framework.Interfaces.Dialogs, Contnrs, CustomizeDlg,
  XPExStyleActnCtrls, XPExActnCtrls, WinSvc, SecurityModel, HTMLHelpViewer,
  cosmos.logs.winservice, cosmos.persistence.registry, cosmos.core.windowsmanager,
  cosmos.core.SQLServerInterface, cosmos.framework.forms.dlgmessages,
  PlatformDefaultStyleActnCtrls;


type

  TCreateCalculator = function(AHelpContext: LongInt;
     var CalcValue: double): boolean; stdcall;

  TShowCalculator = procedure(AHelpContext: LongInt); stdcall;

  EDllError = class(Exception);

  TFrmMain = class(TForm, ICosmosApplication, ICosmosRemoteConnection,
    ICosmosWindowsManager, ICosmosLogs, IDlgMessage, IApplicationComponents,
    IProgressBar)
    XPManifest1: TXPManifest;
    Manager: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
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
    ActMonitorSQLServer: TAction;
    ActionToolBar2: TActionToolBar;
    ActDatasetUpdate: TAction;
    ActFirst: TAction;
    ActPrior: TAction;
    ActNext: TAction;
    ActLast: TAction;
    ActLogs: TAction;
    ActBackup: TAction;
    ActUsuarios: TAction;
    ActToolManager: TAction;
    ActCalculadora: TAction;
    ActModulos: TAction;
    ActModernStyle: TAction;
    ActWinVistaStyle: TAction;
    ActReportsCenter: TAction;
    ActSincronizador: TAction;
    ActShowTips: TAction;
    ActManualCosmos: TAction;
    ActWhatThis: TAction;
    ActDatasetsUpdates: TAction;
    ActPerfis: TAction;
    ActUpdater: TAction;
    PBar: TProgressBar;
    procedure ActUpdaterUpdate(Sender: TObject);
    procedure ActUpdaterExecute(Sender: TObject);
    procedure ActPerfisUpdate(Sender: TObject);
    procedure ActPerfisExecute(Sender: TObject);
    procedure ActDatasetsUpdatesExecute(Sender: TObject);
    procedure ActWhatThisExecute(Sender: TObject);
    procedure ActDatasetUpdateUpdate(Sender: TObject);
    procedure ActManualCosmosExecute(Sender: TObject);
    procedure ActBackupExecute(Sender: TObject);
    procedure ActUsuariosUpdate(Sender: TObject);
    procedure ActAtaPosseUpdate(Sender: TObject);
    procedure ActShowTipsUpdate(Sender: TObject);
    procedure ActShowTipsExecute(Sender: TObject);
    procedure ActLogsUpdate(Sender: TObject);
    procedure ActSincronizadorExecute(Sender: TObject);
    procedure ActTabStyleSoftUpdate(Sender: TObject);
    procedure ActTabStyleModern2Update(Sender: TObject);
    procedure ActTabStyleModernUpdate(Sender: TObject);
    procedure ActTabStyleNormalUpdate(Sender: TObject);
    procedure PopupActionBar1GetControlClass(Sender: TCustomActionBar;
      AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
    procedure ActReportsCenterExecute(Sender: TObject);
    procedure ActWinVistaStyleExecute(Sender: TObject);
    procedure ActModernStyleExecute(Sender: TObject);
    procedure ActModulosExecute(Sender: TObject);
    procedure ActCalculadoraExecute(Sender: TObject);
    procedure ActToolManagerExecute(Sender: TObject);
    procedure ActUsuariosExecute(Sender: TObject);
    procedure ActHelpSearchUpdate(Sender: TObject);
    procedure ActLogsExecute(Sender: TObject);
    procedure ActLastUpdate(Sender: TObject);
    procedure ActLastExecute(Sender: TObject);
    procedure ActNextExecute(Sender: TObject);
    procedure ActPriorExecute(Sender: TObject);
    procedure ActFirstUpdate(Sender: TObject);
    procedure ActFirstExecute(Sender: TObject);
    procedure ActDatasetUpdateExecute(Sender: TObject);
    procedure ActMonitorSQLServerExecute(Sender: TObject);
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
    procedure ActCloseAllWindowsUpdate(Sender: TObject);
    procedure ActCloseAllWindowsExecute(Sender: TObject);
    procedure BtManagerGetHint(Sender: TObject; const Button: TButtonItem;
      const Category: TButtonCategory; var HintStr: string;
      var Handled: Boolean);
    procedure ActTabStyleNormalExecute(Sender: TObject);
    procedure DockTabTabRemoved(Sender: TObject);
    procedure ActRegisterUpdate(Sender: TObject);
    procedure ActRegisterExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ActLoginUpdate(Sender: TObject);
    procedure ActLogoffUpdate(Sender: TObject);
    procedure ActLogoffExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure ActLoginExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FShowTips: boolean;
    FStarted: Boolean;
    FRegistered: boolean;
    FWindowMenu: TActionClientItem;
    FActiveDockedForm: TCustomForm;

    FWinManager: TWindowsManager;
    FShowLogin: boolean;
    FActiveFocus: TFocus;
    FMainLog: TWinServiceLog;
    FIsAdministrator: boolean;
    FSecurityClass: TCosmosSecurity;
    FDlgMessage: TDlgMessage;
    function GetRemoteHost: string;
    function GetIsBetaTest: boolean;

    { Private declarations }
    procedure OnCloseConnection(Sender: TObject);
    procedure ClearConnectionInfo(Sender: TObject);
    procedure ConfigureLogSystem;
    function LoadTips: boolean;
    procedure LoadSplashForm;
    procedure Login;
    procedure ReadStartupOptions;
    procedure SetConnectedUserInfo(const UserName, RoleName, ComputerName: string);
    procedure ShowHint(Sender: TObject);
    procedure WriteStartupOptions;
    procedure CreateTabbedForm(Form: TComponentClass; ImageIndex: integer;
       var Reference); overload;
    procedure CreateItems(Category: TButtonCategory; Action: TBasicAction);
    function FindActionClient(const Caption: string; ActionBar: TCustomActionBar): TActionClientItem;
    function ControlIsDocked(DockTabSet: TDockTabSet;
       Control: TControl): boolean; inline;


  protected
  {ICosmosApplication}
    function GetApplicationComponents: IApplicationComponents;
    function GetTitle: string;
    function GetMainForm: TForm;
    function GetMainLog: ICosmosLogs;
    function GetCosmosSecurity: TCosmosSecurity;
    function GetCosmosUpdater: ICosmosUpdater;
    function GetDlgMessage: IDlgMessage;
    function GetCamposAtivos: TCamposTrabalho;
    function GetCosmosModule: TCosmosModules;
    function GetCosmosRootFolder: string;
    function GetActiveDockedForm: TCustomForm;
    procedure SetActiveDockedForm(Value: TCustomForm);
    function GetActiveFocus: TFocus;
    function GetInterfaceStyle: TInterfaceStyle;
    function GetIRemoteCon: ICosmosRemoteConnection;
    function GetStyleControlClass: TCustomActionControlClass;

    function CreateMessageData(Code, HelpContext: integer; MessageText, MessageTitle: string;
      MessageType: TMessageType): TMessageData; overload; inline;
    function CreateMessageData(MessageText, MessageTitle: string; MessageType: TMessageType): TMessageData; overload; inline;

    property ActiveDockedForm: TCustomForm read GetActiveDockedForm;
    property ActiveFocus: TFocus read GetActiveFocus;
    property CampoAtivo: TCamposTrabalho read GetCamposAtivos;
    property Components: IApplicationComponents read GetApplicationComponents;
    property CosmosSecurity: TCosmosSecurity read GetCosmosSecurity;
    property CosmosUpdater: ICosmosUpdater read GetCosmosUpdater;
    property DlgMessage: IDlgMessage read GetDlgMessage implements IDlgMessage;
    property StyleControlClass: TCustomActionControlClass read GetStyleControlClass;
    property CosmosModule: TCosmosModules read GetCosmosModule;
    property CosmosRootFolder: string read GetCosmosRootFolder;
    property Title: string read GetTitle;
    property MainForm: TForm read GetMainForm;
    property MainLog: ICosmosLogs read GetMainLog implements ICosmosLogs;
    property InterfaceStyle: TInterfaceStyle read GetInterfaceStyle;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon implements ICosmosRemoteConnection;

    procedure CloseApplication;
    function OpenRegisteredWindow(ModuleName, ClassName: string): TCustomForm;
    procedure CreateCategory(const Caption: string);
    procedure AddCategory(Caption: string; Actions: TActionList);
    procedure DropCategory(Caption: string);
    procedure UpdateAllForms;

    procedure SetRegistered;
    function LoginDialog(var UserName, Password, RoleName: string): boolean;
    function ExecuteAction(const Action: TBasicAction): boolean;
    function LoadDialog(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): TForm;
    function LoadClass(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): TInterfacedPersistent;
    function GetCosmosInterface(const ModuleName: TFileName; ModuleClass: string;
        out Module: HModule): ICosmosInterfaces;

    {ICosmosWindowsManager}
    function GetFormCount: integer;

    function CloseRegisteredWindow(const WindowCaption: string): boolean; overload;
    function CloseRegisteredWindows(const ClassName: TClass): boolean; overload;
    function ExtractFormIcon(Form: TCustomForm): TIcon;
    function FindFormByID(const ID: integer): TCustomForm;
    function FindFormByCaption(const Caption: string): TCustomForm;
    procedure ActivateForm(Form: TCustomForm);

    property FormCount: integer read GetFormCount;

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


  {IApplicationComponents}
    function GetIProgressBar: IProgressBar;

    property ProgressBar: IProgressBar read GetIProgressBar;

  public
    { Public declarations }
    property IsBetaTest: boolean read GetIsBetaTest;
    property IsAdministrator: boolean read FIsAdministrator;
    property Registered: boolean read FRegistered;
    property SecurityClass: TCosmosSecurity read FSecurityClass;
    property ShowTips: boolean read FShowTips write FShowTips;
    property ShowLogin: boolean read FShowLogin write FShowLogin;
    property Started: boolean read FStarted write FStarted;
    property WindowMenu: TActionClientItem read FWindowMenu;
  end;

var
  FrmMain: TFrmMain;

implementation

uses Cosmos.core.ConstantesMsg, DMConnection, cosmos.core.winshell, FormModernMenu,
 cosmos.framework.forms.mydialogs;

{$R *.dfm}

procedure TFrmMain.ActLogoffExecute(Sender: TObject);
begin
 IRemoteCon.ConnectionBroker.Close;
end;

procedure TFrmMain.ActLogoffUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := IRemoteCon.ConnectionBroker.Connected;
 end;

procedure TFrmMain.ActLogsExecute(Sender: TObject);
begin
 case TWinShell.GetServiceStatus(PWideChar(TWinShell.GetComputerName),'EventLog') of
  SERVICE_RUNNING: TWinShell.OpenLocalEventLogService;
  SERVICE_STOPPED: TMyDialogs.ErrorMessage(sErrorLogService);
 end;
end;

procedure TFrmMain.ActLogsUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := IsAdministrator;
end;

procedure TFrmMain.ActAboutExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IAbout: ICosmosSplash;
begin
 try
  AForm := self.LoadDialog('splash.bpl', 'TFrmSplash', AModule);

  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosSplash) then
        IAbout := AForm as ICosmosSplash;

       if Assigned(IAbout) then
         IAbout.ShowAppAbout;
       Free;
      end;
   end;

 finally
  if Assigned(IAbout) then
   IAbout := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;

procedure TFrmMain.ActUpdaterExecute(Sender: TObject);
begin
 TMyDialogs.InfoMessage('Recurso em construção!');
end;

procedure TFrmMain.ActUpdaterUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := self.GetCosmosUpdater <> nil;
end;

procedure TFrmMain.ActUsuariosExecute(Sender: TObject);
begin
 self.OpenRegisteredWindow('cmusers.bpl', 'TFrmUsuarios')
end;

procedure TFrmMain.ActUsuariosUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := (IRemoteCon.Connected) ;
end;

procedure TFrmMain.ActBackupExecute(Sender: TObject);
var
RootDir: string;
H: THandle;
begin
 RootDir := ExtractFilePath(Application.ExeName);
 H := TWinShell.ExecuteFile(sBackupExecutable ,'', RootDir, 0);
 if H = 2 then //Falha na execução...
  TMyDialogs.ErrorMessage(sErrorExecuteDbBackup);

end;

procedure TFrmMain.ActCalculadoraExecute(Sender: TObject);
var
H: THandle;
ShowCalculator: TShowCalculator;
begin
{Carrega a calaculadora que está dentro da dll calc.dll. O variável "Value"
está aqui só para indicar que ela pode ser atribuída ao valor de retorno da
função. Apesar de não usarmos isto para nada neste programa, quis deixar aí para
indicar que é possível usá-la.}
 try
 H := LoadLibrary('calc.dll');
 if H = 0 then
  raise EDLLError.Create(sErrorDllCalculator);

  @ShowCalculator := GetProcAddress(H,'ShowCalculator');
  if not (@ShowCalculator = nil) then
   ShowCalculator(0)
  else
   RaiseLastOSError;

 finally
  if H <> 0 then
   FreeLibrary(H);
 end;
end;

procedure TFrmMain.ActCloseAllWindowsExecute(Sender: TObject);
begin
 FWinManager.CloseAllForms;
end;

procedure TFrmMain.ActCloseAllWindowsUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=  (Assigned(FWinManager)) and (FWinManager.FormCount > 0);
end;

procedure TFrmMain.ActCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmMain.ActCloseWindowExecute(Sender: TObject);
begin
 if ActiveDockedForm <> nil then
  FWinManager.CloseForm(ActiveDockedForm);
end;

procedure TFrmMain.ActCloseWindowUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (Assigned(FWinManager))
   and (FWinManager.FormCount > 0);
end;

procedure TFrmMain.ActHelpIndexExecute(Sender: TObject);
begin
  HtmlHelp(Handle, PChar(Application.HelpFile), HH_DISPLAY_INDEX, DWord(0));
end;

procedure TFrmMain.ActHelpTopicsExecute(Sender: TObject);
begin
  HtmlHelp(Handle, PChar(Application.HelpFile), HH_DISPLAY_TOC, DWord(0));
end;

procedure TFrmMain.ActModernStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('XP Style')];
 Manager.Style := NewStyle;
end;

procedure TFrmMain.ActAtaPosseUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := IRemoteCon.Connected;
end;

procedure TFrmMain.ActWhatThisExecute(Sender: TObject);
begin
 PostMessage(Handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
end;

procedure TFrmMain.ActivateForm(Form: TCustomForm);
begin
 if Form <> nil then
  begin
   Form.Show;
   Form.SetFocus;
  end;
end;

procedure TFrmMain.ActFirstExecute(Sender: TObject);
begin
IRemoteCon.ActiveDataset.First;
end;

procedure TFrmMain.ActFirstUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon.ActiveDataset <> nil) and (IRemoteCon.ActiveDataset.Active)
   and not (IRemoteCon.ActiveDataset.Bof);
end;

procedure TFrmMain.ActPriorExecute(Sender: TObject);
begin
 IRemoteCon.ActiveDataset.Prior;
end;

procedure TFrmMain.ActNextExecute(Sender: TObject);
begin
 IRemoteCon.ActiveDataset.Next;
end;

procedure TFrmMain.ActLastExecute(Sender: TObject);
begin
 IRemoteCon.ActiveDataset.Last;
end;

procedure TFrmMain.ActLastUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon.ActiveDataset <> nil) and (IRemoteCon.ActiveDataset.Active)
   and not (IRemoteCon.ActiveDataset.Eof);
end;

procedure TFrmMain.ActHelpSearchExecute(Sender: TObject);
var
Key: string;
begin
 if FActiveDockedForm <> nil then
  begin
    Key := FActiveDockedForm.HelpKeyword;
    if Trim(Key) = '' then
     begin
      TMyDialogs.ErrorMessage(sErrorNoHelpFound);
      Exit;
     end;
    Application.HelpSystem.ShowTopicHelp(Key, Application.CurrentHelpFile);

  end
  else
   ActHelpTopics.Execute;
end;

procedure TFrmMain.ActHelpSearchUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := ActiveDockedForm <> nil;
end;

procedure TFrmMain.ActConfigurationsExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IConfig: ICosmosConfiguration;
begin
  try
   AForm := self.LoadDialog('confwin.bpl', 'TFrmConfig', AModule);

   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ICosmosConfiguration) then
        IConfig := AForm as ICosmosConfiguration;
       if Assigned(IConfig) then
          IConfig.Execute;

       Free;
      end;
    end;

  finally
   if Assigned(IConfig) then
    IConfig := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMain.ActConnectInfoExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IInfo: ICosmosConnectionInfo;
begin
//Exibe informações sobre a conexão ativa
  try
    AForm := self.LoadDialog('coninfo.bpl', 'TFrmInfoConnection', AModule);

   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ICosmosConnectionInfo) then
        IInfo := AForm as ICosmosConnectionInfo;
       if Assigned(IInfo) then
         IInfo.ShowConnectionInfo;
       Free;
      end;
    end;

  finally
   if Assigned(IInfo) then
    IInfo := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMain.ActCustomizeExecute(Sender: TObject);
begin
 CustomDlg.Show;
end;

procedure TFrmMain.ActDatasetsUpdatesExecute(Sender: TObject);
begin
 self.UpdateAllForms;
end;

procedure TFrmMain.ActDatasetUpdateExecute(Sender: TObject);
begin
 IRemoteCon.ActiveDataset.Refresh;
end;

procedure TFrmMain.ActDatasetUpdateUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon.ActiveDataset <> nil) and (IRemoteCon.ActiveDataset.Active);
end;

procedure TFrmMain.ActExportDataExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IExporter: ICosmosExporter;
begin
//Exporta os dados do dataset ativo para um arquivo externo
 if (IRemoteCon.ActiveDataset <> nil) and (IRemoteCon.ActiveDataset.Active) then
  begin
   try
     AForm := self.LoadDialog('exporter.bpl', 'TFrmExportar', AModule);
     if (AModule <> 0) and (AForm <> nil) then
      begin
       with AForm do
        begin
         if Supports(AForm, ICosmosExporter) then
          IExporter := AForm as ICosmosExporter;
         if Assigned(IExporter) then
          IExporter.Exportar(TClientDataset(IRemoteCon.ActiveDataset).Data);
         Free;
        end;
      end;

   finally
     if Assigned(IExporter) then
      IExporter := nil;
     UnloadPackage(AModule);
   end;
  end;
end;

procedure TFrmMain.ActLocateExecute(Sender: TObject);
var
IDockedForm: ICosmosDockedForm;
begin
//Localiza um registro do dataset ativo
 if ActiveDockedForm <> nil then
  begin
   if Supports(ActiveDockedForm, ICosmosDockedForm) then
    begin
     IDockedForm := ActiveDockedForm as ICosmosDockedForm;
     IDockedForm.Locate;
    end;
  end;
end;

procedure TFrmMain.ActLocateUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (IRemoteCon.ActiveDataset <> nil) and (IRemoteCon.ActiveDataset.Active)
   and not (IRemoteCon.ActiveDataset.IsEmpty);
end;

procedure TFrmMain.ActLoginExecute(Sender: TObject);
begin
 Login;
end;

procedure TFrmMain.ActLoginUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := not IRemoteCon.ConnectionBroker.Connected;
end;

procedure TFrmMain.ActMainToolBarExecute(Sender: TObject);
begin
 Manager.ActionBars.ActionBars[1].Visible := TAction(Sender).Checked;
end;

procedure TFrmMain.ActManualCosmosExecute(Sender: TObject);
var
FileName: string;
begin
 FileName := ExtractFilePath(Application.ExeName) + sManualCosmos;
 TWinShell.OpenFile(FileName);
end;

procedure TFrmMain.ActMenuManagerExecute(Sender: TObject);
begin
 FrmModernMenu.Visible := TAction(Sender).Checked;
 if TAction(Sender).Checked then
  FrmModernMenu.Width := 185;
end;

procedure TFrmMain.ActMessagesExecute(Sender: TObject);
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TCustomForm;
begin
 AModule := LoadPackage('cosmosmsg.bpl');
 if AModule <> 0 then
  begin
   AClass := GetClass('TFrmMessages');
   AForm := FWinManager.FindFormByClass(AClass);
   if AForm <> nil then
    begin
     AForm.Show;
     AForm.SetFocus;
    end
   else
    begin
     if AClass = nil then
      raise exception.Create(sUnregisteredClass);
     if AClass <> nil then
      FWinManager.CreateForm(TComponentClass(AClass), AForm);

     with AForm do
      begin
       AForm.ManualDock(PnlLeftDock, nil, alClient);
       AForm.Show;
       AForm.SetFocus;
      end;
   end;
  end;
end;

procedure TFrmMain.ActModulosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
begin
 try
  AForm := self.LoadDialog('cmmodules.bpl', 'TFrmModules', AModule);

  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       ShowModal;
       Free;
      end;
   end;

 finally
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;

procedure TFrmMain.ActMonitorSQLServerExecute(Sender: TObject);
begin
 IRemoteCon.ConnectionBroker.AppServer.CommandMonitor:= TAction(Sender).Checked;
end;

procedure TFrmMain.ActPerfisExecute(Sender: TObject);
begin
 OpenRegisteredWindow('perfis.bpl','TFrmPerfis');
end;

procedure TFrmMain.ActPerfisUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := (IRemoteCon.Connected) and (SecurityClass.Administrator);
end;

procedure TFrmMain.ActRegisterExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IRegister: IRegisterInfo;
begin
//Acessa a janela de registro do aplicativo
  try
   AForm := self.LoadDialog('regcosmos.bpl', 'TFrmRegister', AModule);

   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, IRegisterInfo) then
        IRegister := AForm as IRegisterInfo;
       if Assigned(IRegister) then
         IRegister.ShowRegisterForm(CosmosModule);
       Free;
      end;
    end;

  finally
   if Assigned(IRegister) then
    IRegister := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMain.ActRegisterUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := not Registered;
end;

procedure TFrmMain.ActReportsCenterExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
begin
 try
  AForm := self.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, IReportCenter) then
        IReport := AForm as IReportCenter;

       if Assigned(IReport) then
        begin
         IReport.ReportFile := ExtractFilePath(Application.ExeName) + sUsuariosReportFile;
         IReport.ShowReportCenter;
        end;
       Free;
      end;
   end;

 finally
  if Assigned(IReport) then
   IReport := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;

procedure TFrmMain.ActShowStatusBarExecute(Sender: TObject);
begin
 MainStatusBar.Visible := TAction(Sender).Checked;
end;

procedure TFrmMain.ActShowTipsExecute(Sender: TObject);
begin
 ShowTips := not ShowTips;
end;

procedure TFrmMain.ActShowTipsUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := ShowTips;
end;

procedure TFrmMain.ActSincronizadorExecute(Sender: TObject);
var
RootDir: string;
H: THandle;
begin
 RootDir := ExtractFilePath(Application.ExeName);
 H := TWinShell.ExecuteFile(sSyncExecutable ,'', RootDir, 0);
 if H = 2 then //Falha na execução...
  TMyDialogs.ErrorMessage(sErrorExecuteDbSync);
end;

procedure TFrmMain.ActSupportExecute(Sender: TObject);
begin
 Application.HelpSystem.ShowTopicHelp('Suporte',application.HelpFile);
end;

procedure TFrmMain.ActTabelasExecute(Sender: TObject);
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TCustomForm;
begin
 AModule := LoadPackage('tabace.bpl');
 if AModule <> 0 then
  begin
   AClass := GetClass('TFrmAcessorias');
   AForm := FWinManager.FindFormByClass(AClass);
   if AForm <> nil then
    begin
     AForm.Show;
     AForm.SetFocus;
    end
   else
    begin
     if AClass = nil then
      raise exception.Create(sUnregisteredClass);
     if AClass <> nil then
      FWinManager.CreateForm(TComponentClass(AClass), AForm);

     with AForm do
      begin
       AForm.ManualDock(PnlDock, nil, alClient);
       AForm.Show;
       AForm.SetFocus;
      end;
   end;
  end;
end;

procedure TFrmMain.ActTabStyleModern2Update(Sender: TObject);
begin
 TAction(Sender).Checked := DockTab.Style = tsModernPopout;
end;

procedure TFrmMain.ActTabStyleModernUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := DockTab.Style = tsModernTabs;
end;

procedure TFrmMain.ActTabStyleNormalExecute(Sender: TObject);
begin
 case TAction(Sender).Tag of
  0: DockTab.Style := tsStandard;
  1: DockTab.Style := tsModernTabs;
  2: DockTab.Style := tsModernPopout;
  3: DockTab.Style := tsSoftTabs;
 end;
 DockTabLeft.Style := DockTab.Style;
end;

procedure TFrmMain.ActTabStyleNormalUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := DockTab.Style = tsStandard;
end;

procedure TFrmMain.ActTabStyleSoftUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := DockTab.Style = tsSoftTabs;
end;

procedure TFrmMain.ActToolManagerExecute(Sender: TObject);
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TCustomForm;
  IToolsManager: ICosmosToolsManager;
  ToolsFile: string;
begin
 AModule := LoadPackage('toolsman.bpl');
 if AModule <> 0 then
  begin
   AClass := GetClass('TFrmToolsManager');
   AForm := FWinManager.FindFormByClass(AClass);

   if AForm <> nil then
    begin
     AForm.Show;
     AForm.SetFocus;
    end
   else
    begin
     if AClass = nil then
      raise exception.Create(sUnregisteredClass);
     if AClass <> nil then
      begin
       FWinManager.CreateForm(TComponentClass(AClass), AForm);
       IToolsManager := AForm as ICosmosToolsManager;
       ToolsFile := ExtractFilePath(Application.ExeName) + 'gsec.tools';
       if Assigned(IToolsManager) then
        IToolsManager.OpenManager(ToolsFile);
      end;
    end;
  end;
end;

procedure TFrmMain.ActWindowsManagerExecute(Sender: TObject);
var
  AModule: HModule;
  AForm, SelForm: TForm;
  IWinMan: ICosmosDialogWinManager;
begin
 try
  AForm := self.LoadDialog('scrman.bpl', 'TFrmWindowsList', AModule);

  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosDialogWinManager) then
        IWinMan := AForm as ICosmosDialogWinManager;

       if Assigned(IWinMan) then
        begin
         SelForm := IWinMan.SelectForm;
         ActivateForm(SelForm);
        end;
       Free;
      end;
   end;

 finally
  if Assigned(IWinMan) then
   IWinMan := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;

procedure TFrmMain.ActWinVistaStyleExecute(Sender: TObject);
var
NewStyle: TActionBarStyle;
begin
 NewStyle := ActionBarStyles.Style[ActionBarStyles.IndexOf('New XP Style')];
 Manager.Style := NewStyle;
end;

procedure TFrmMain.AddCategory(Caption: string; Actions: TActionList);
var
I: integer;
Cat: TButtonCategory;
Window, Sender: TActionClientItem;
begin
 I := FrmModernMenu.BtManager.Categories.IndexOf(Caption);
 if I < 0 then
  begin
   if (Actions <> nil) and (Actions.ActionCount > 0) then
    begin
     Cat := FrmModernMenu.BtManager.Categories.Add;
     Cat.Caption := Caption;

     //Cria o submenu do menu "janelas"
     Sender := Manager.FindItemByCaption(Caption);
     if Sender <> nil then
      begin
       Window := WindowMenu.Items.Add;
       Window.Action := Sender.Action;
       Window.Index := 0;
      end;

     for I := 0 to Pred(Actions.ActionCount) do
      begin
       CreateItems(Cat, Actions.Actions[I]);
      end;
     Cat.Collapsed := False;
     Cat.Color := FrmModernMenu.BtManager.Color;
    end;
  end
 else
  begin
   Cat := FrmModernMenu.BtManager.Categories.Items[I];
   Cat.Collapsed := False;
   Cat.ScrollIntoView;
  end;
end;

procedure TFrmMain.BtManagerGetHint(Sender: TObject; const Button: TButtonItem;
  const Category: TButtonCategory; var HintStr: string; var Handled: Boolean);
begin
 HintStr := GetShortHint(HintStr);
end;

procedure TFrmMain.ClearConnectionInfo(Sender: TObject);
begin
//Reseta as informações sobre uma conexão que acaba de ser fechada
 DMCon.ADMUser := False;
 if Assigned(DMCon.PerfilUsuario) then
  DMCon.PerfilUsuario.Free;

 if FActiveFocus <> nil then
  FActiveFocus := nil;

 MainStatusBar.Panels.Items[1].Text := '';
 MainStatusBar.Panels.Items[2].Text := '';
 MainStatusBar.Panels.Items[3].Text := '';
 ActCloseAllWindows.Execute;
end;

procedure TFrmMain.CloseApplication;
begin
 ActClose.Execute;
end;

function TFrmMain.CloseRegisteredWindow(const WindowCaption: string): boolean;
var
Form: TCustomForm;
begin
 Result := False;
 Form := FWinManager.FindFormByCaption(WindowCaption);
 if Form <> nil then
  begin
   FWinManager.CloseForm(Form);
   Result := True;
  end;
end;

function TFrmMain.CloseRegisteredWindows(const ClassName: TClass): boolean;
var
Form: TCustomForm;
begin
 Result := False;
 Form := FWinManager.FindFormByClass(ClassName);
 if Form <> nil then
  begin
   FWinManager.CloseForm(Form);
   Result := True;
  end;

end;

procedure TFrmMain.ConfigureLogSystem;
begin
//Configura o objeto interno da classe TWinService que usa o serviço de escrita
//de logs do MSWindows.
 if Assigned(FMainLog) then
  FMainLog.ConfigureService('events.dll','events.dll','events.dll','452',
   'cosmos.evt','Cosmos','Gestor de Usuarios','Cosmos',6,150,2); //do not localize!
end;

function TFrmMain.ControlIsDocked(DockTabSet: TDockTabSet;
  Control: TControl): boolean;
begin
//Verifica se um controle está "dockado".
 if (DockTabSet <> nil) and (Control <> nil) then
  Result := DockTabSet.IndexOfDockClient(Control) >= 0
 else
  Result := False;
end;

procedure TFrmMain.CreateCategory(const Caption: string);
var
I: integer;
Cat: TButtonCategory;
begin
 I := FrmModernMenu.BtManager.Categories.IndexOf(Caption);
 if I < 0 then
  begin
   Cat := FrmModernMenu.BtManager.Categories.Add;
   Cat.Caption := Caption;
   Cat.Collapsed := True;
   Cat.Color := FrmModernMenu.BtManager.Color;
   //CreateItems(Cat, ActNewActivity);
  end
 else
   Cat := FrmModernMenu.BtManager.Categories.Items[I];
   Cat.Collapsed := False;
   Cat.ScrollIntoView;
end;

procedure TFrmMain.CreateItems(Category: TButtonCategory; Action: TBasicAction);
var
Bi: TButtonItem;
begin
//Inser o botão e o liga ao action desde que o seu tag seja diferente de 100.
//Convencionou-se que actions com tag = 100 não serão listados.
 if (Action <> nil) and (Action.Tag <> 100) then
  begin
   Bi := Category.Items.Add;
   //Bi.ImageIndex := Action.ImageIndex;
   Bi.ImageIndex := -1;
   Bi.Action := Action;
  end;

end;

function TFrmMain.CreateMessageData(MessageText, MessageTitle: string;
  MessageType: TMessageType): TMessageData;
begin
 Result := TMessageData.Create;
 Result.MessageText := MessageText;
 Result.MessageTitle := MessageTitle;
 Result.MessageType := MessageType;
 Result.SetMessageInfo(miUserName, IremoteCon.ConnectedUser);
 Result.SetMessageInfo(miRoleName, IremoteCon.ConnectedRole);
end;

function TFrmMain.CreateMessageData(Code, HelpContext: integer; MessageText,
  MessageTitle: string; MessageType: TMessageType): TMessageData;
begin
 Result := TMessageData.Create;
 Result.Code := Code;
 Result.HelpContext := HelpContext;
 Result.MessageText := MessageText;
 Result.MessageTitle := MessageTitle;
 Result.MessageType := MessageType;
 Result.SetMessageInfo(miUserName, IremoteCon.ConnectedUser);
 Result.SetMessageInfo(miRoleName, IremoteCon.ConnectedRole);
end;

procedure TFrmMain.CreateTabbedForm(Form: TComponentClass; ImageIndex: integer;
  var Reference);
begin
//Cria um formulário "dockado" no painel host.
 if FWinManager.FindFormByClass(Form) = nil then
  begin
   FWinManager.CreateForm(Form, Reference);
   TForm(Reference).ManualDock(DockTab.DestinationDockSite, nil, alTop);
  end;

 TForm(Reference).Show;
 TForm(Reference).SetFocus;
end;

procedure TFrmMain.DockTabLeftTabRemoved(Sender: TObject);
begin
 TDockTabSet(Sender).Visible := TDockTabSet(Sender).Tabs.Count > 0;
end;

procedure TFrmMain.DockTabTabRemoved(Sender: TObject);
begin
 TDockTabSet(Sender).Visible := TDockTabSet(Sender).Tabs.Count > 0;
end;

procedure TFrmMain.DropCategory(Caption: string);
var
I, P: integer;
TopItem: TActionClientItem;
s: string;
begin
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

function TFrmMain.ExecuteAction(const Action: TBasicAction): boolean;
begin
 Result := False;
 if Action <> nil then
  Result := Action.Execute;
end;

function TFrmMain.ExtractFormIcon(Form: TCustomForm): TIcon;
begin
// if Form <> nil then
  Result := FWinManager.ExtractFormIcon(Form);
end;

function TFrmMain.FindActionClient(const Caption: string;
  ActionBar: TCustomActionBar): TActionClientItem;
begin
Result := nil;
end;

function TFrmMain.FindFormByCaption(const Caption: string): TCustomForm;
begin
 Result := FWinManager.FindFormByCaption(Caption);
end;

function TFrmMain.FindFormByID(const ID: integer): TCustomForm;
begin
 Result := FWinManager.FindFormByID(ID);
end;

procedure TFrmMain.FormActivate(Sender: TObject);
var
 Reg: TRegistryPersistence;
 WState: TWindowState;
 AMessageData: TMessageData;
begin
//Lê as configurações de inicialização
 if not FStarted then
  begin
   FrmModernMenu.ManualDock(PnlLeftDock,PnlLeftDock,alClient);
   FrmModernMenu.Show;
   Reg := TRegistryPersistence.Create;

   try
    //Define o estado da janela principal. Esta configuração deve ser executada
     //aqui e não no método ReadStartupOptions.
    Reg.Open(sCurrentUserKey);
    Reg.OpenKey(sRegUsuariosVisual, True);

    WState := TWindowState(Ord(Reg.ReadInteger('MainStatus')));
    if WState = wsMaximized then
     Self.WindowState := WState;

   finally
    if Assigned(Reg) then
     begin
      Reg.CloseKey;
      FreeAndNil(Reg);
     end;
   end;


   if not Registered then
    begin
     ActRegister.Execute;
     if not Registered then
       begin
        AMessageData := self.CreateMessageData(IdMsg_UnregisteredApp, 1,
          sInfoCloseUnregisteredApp, sTitleUnregisteredApp, mtpInformation);
        try
         self.DlgMessage.Execute(AMessageData);

        finally
          if Assigned(AMessageData) then
           AMessageData.Free;
        end;

       // Application.Terminate;
        //Exit;
       end;
    end;

   ReadStartupOptions;
   if ShowTips then
    ShowTips := LoadTips;
   if ShowLogin then
    ActLogin.Execute;
  end;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteStartupOptions;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if ActCloseAllWindows.Enabled then
  CanClose := ActCloseAllWindows.Execute;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
I: integer;
ProgressBarStyle: integer;
begin
 //Cria a classe de segurança do aplicativo
 FSecurityClass := TCosmosSecurity.Create;

 LoadSplashForm;
 Application.HelpFile := ExtractFilePath(Application.ExeName) +  'gusers.chm';
 Application.OnHint := ShowHint;

 //Coloca a progressbar na status bar
 PBar.Parent := MainStatusBar;
 //Remove a borda da progressbar
 ProgressBarStyle := GetWindowLong(PBar.Handle, GWL_EXSTYLE);
 ProgressBarStyle := ProgressBarStyle - WS_EX_STATICEDGE;
 SetWindowLong(Pbar.Handle, GWL_EXSTYLE, ProgressBarStyle);

 //Classe gerenciadora de janelas
 FWinManager := TWindowsManager.Create;

 //Classe de geração de logs
 FMainLog := TWinServiceLog.Create;
 ConfigureLogSystem;
 FDlgMessage := TDlgMessage.Create;

//Encontra o menu "Janelas". É o penúltimo menu da primeira barra.
 I := Manager.ActionBars.ActionBars[0].Items.Count;
 FWindowMenu := Manager.ActionBars.ActionBars[0].Items.ActionClients[I - 2];

//Checa se o usuário do sistema operacional é um administrador
 FIsAdministrator := False;
 FIsAdministrator := TWinShell.UserIsAdministrator;

 self.FRegistered := False;

 SetRegistered;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
 IRemoteCon.ConnectionBroker.AfterDisconnect := ClearConnectionInfo;
end;


function TFrmMain.GetActiveDockedForm: TCustomForm;
begin
 Result := FActiveDockedForm;
end;

function TFrmMain.GetActiveFocus: TFocus;
begin
 Result := FActiveFocus;
end;

function TFrmMain.GetApplicationComponents: IApplicationComponents;
begin
 Result := self as IApplicationComponents;
end;

function TFrmMain.GetIsBetaTest: boolean;
begin
Result := False;
end;

function TFrmMain.GetCamposAtivos: TCamposTrabalho;
begin
 Result := []; //to-do
end;

function TFrmMain.GetCosmosInterface(const ModuleName: TFileName;
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
     raise exception.Create(sUnregisteredClass);

    if AClass <> nil then
     Result := TComponentClass(AClass).Create(Application) as ICosmosInterfaces;
   end;

 except
  raise;
 end;
end;

function TFrmMain.GetCosmosModule: TCosmosModules;
begin
 Result := cmUsuarios;
end;

function TFrmMain.GetCosmosRootFolder: string;
begin
//Retorna a pasta-raíz do Cosmos
 Result := TShellFolders.GetPreviousDir(Application.ExeName, False);
end;

function TFrmMain.GetCosmosSecurity: TCosmosSecurity;
begin
 Result := FSecurityClass;
end;

function TFrmMain.GetCosmosUpdater: ICosmosUpdater;
begin
//Obtém uma instância da interface ICosmosUpdater. (to-do)
 Result := nil;
end;

function TFrmMain.GetDlgMessage: IDlgMessage;
begin
 Result := nil;
 if FDlgMessage <> nil then
  Result := FDlgMessage as IDlgMessage;
end;

function TFrmMain.GetFormCount: integer;
begin
 Result := FWinManager.FormCount;
end;

function TFrmMain.GetInterfaceStyle: TInterfaceStyle;
begin
 if Manager.Style.GetStyleName = 'XP Style' then
  Result := isWinXP
 else
  Result := isWinVista;
end;

function TFrmMain.GetIProgressBar: IProgressBar;
begin
 Result := self as IProgressBar;
end;

function TFrmMain.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := DMCon as ICosmosRemoteConnection;
end;

function TFrmMain.GetMainForm: TForm;
begin
 Result := self;
end;

function TFrmMain.GetMainLog: ICosmosLogs;
begin
 Result := nil;
 if FMainLog <> nil then Result := FMainLog as ICosmosLogs;
end;

function TFrmMain.GetMaxPosition: integer;
begin
 Result := PBar.Max;
end;

function TFrmMain.GetPosition: integer;
begin
 Result := PBar.Position;
end;

function TFrmMain.GetRemoteHost: string;
begin
 Result := '';
 if DMCon.CBroker.Connected then
  Result := DMCon.ConnectedServer;
end;

function TFrmMain.GetStyleControlClass: TCustomActionControlClass;
var
Style: TInterfaceStyle;
begin
 if Manager.Style.GetStyleName = 'XP Style' then
  Style := isWinXP
 else
  Style := isWinVista;

 case Style of
  isWinXP: Result := nil;
  isWinVista: Result := TXPExStyleRichContent;
  else
   Result := nil;
 end
end;

function TFrmMain.GetTitle: string;
begin
 Result := Application.Title;
end;

function TFrmMain.GetVisible: boolean;
begin
 Result := PBar.Visible;
end;

function TFrmMain.LoadClass(const ModuleName: TFileName; ModuleClass: string;
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
     raise exception.Create(sUnregisteredClass);

    if AClass <> nil then
     Result := TPersistentClass(AClass).Create as TInterfacedPersistent;
   end;

 except
  raise;
 end;
end;

function TFrmMain.LoadDialog(const ModuleName: TFileName; ModuleClass: string;
  out Module: HModule): TForm;
var
  AClass: TPersistentClass;
begin
//Método usado para carregar um form hospedado dentro de uma biblioteca.
 Result := nil;

 try
  Module := LoadPackage(ModuleName);

  if Module <> 0 then
   begin
    AClass := GetClass(ModuleClass);

    if AClass = nil then
     raise exception.Create(sUnregisteredClass);

    if AClass <> nil then
     Result := TComponentClass(AClass).Create(Application) as TForm;
   end;

 except
  raise;
 end;
end;

procedure TFrmMain.LoadSplashForm;
var
  AModule: HModule;
  AForm: TForm;
  IAbout: ICosmosSplash;
begin
//Carrega a tela de abertura "Splash" na incialização.
 try
  AForm := self.LoadDialog('splash.bpl', 'TFrmSplash', AModule);

  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosSplash) then
        IAbout := AForm as ICosmosSplash;

       if Assigned(IAbout) then
         IAbout.ShowAppSplash;
       Free;
      end;
   end;

 finally
  if Assigned(IAbout) then
   IAbout := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;

function TFrmMain.LoadTips: boolean;
var
  AModule: HModule;
  AForm: TForm;
  ITips: ICosmosTips;
  TipsFile: string;
begin
//Carrega a janela de Dicas logo na inicialização da aplicação.
 try
  Result := True;
  AForm := self.LoadDialog('tips.bpl','TFrmTips',AModule);

  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosTips) then
        ITips := AForm as ICosmosTips;

       if Assigned(ITips) then
        begin
         TipsFile := ExtractFilePath(Application.ExeName) + sTipsGUsuarios;
         Result := ITips.ShowTips(TipsFile);
        end;
       Free;
      end;
   end;

 finally
  if Assigned(ITips) then
   ITips := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;

procedure TFrmMain.Login;
var
  User, Pass, Role, Host: string;
  Logged, ServerIsBeta, DBIsBeta: boolean;
begin
{O método "LoginDialog" é chamado fora do escopo do método "Login" para
garantir que a dll da janela de login será liberada e não ocorra vazamento da
pilha de memória. Manter assim.}
 if LoginDialog(User, Pass, Role) then
  begin
    FrmMain.Update;
    //Pega o nome do computar onde o sistema está sendo executado
    Host := TWinShell.GetComputerName;
    //Chama a função que realiza a conexão com o banco de dados remoto.
    Logged := IRemoteCon.ConnectDatabase(User, Pass, Role, Host);

    if Logged then //Se a conexão foi feita com sucesso...
     begin
      //Aplicação servidora e cliente só podem conversar se as duas forem beta
      //ou as duas não forem beta
      ServerIsBeta := IRemoteCon.ConnectionBroker.AppServer.BetaVersion;

      if ServerIsBeta <> IsBetaTest then
       begin
        IRemoteCon.ConnectionBroker.Connected := False;
        self.DlgMessage.Execute(sTitleAutentication, sErrorBetaVersion, mtError);
        Exit;
       end;

      //O banco de dados e a aplicação somente podem conversar se forem "betas"
      //ou se ambos forem uma versão de produção.
      DBIsBeta := IRemoteCon.DatabaseVersion = 0;

      if ServerIsBeta <> DBIsBeta then
       begin
        IRemoteCon.ConnectionBroker.Connected := False;
        self.DlgMessage.Execute(sTitleAutentication, sErrorBetaVersion, mtError);
        Exit;
       end;

      //Buferiza no cliente alguns dados muito usados.
      DMCon.BufferData('perfis', sBufPerfis);
      DMCon.BufferData('focos',sBufFocos);

      //Escreve as informações sobre o usuário conectado.
      SetConnectedUserInfo(User, Role, DMCon.ConnectedServer);

     end;
  end;
end;

function TFrmMain.LoginDialog(var UserName, Password,
  RoleName: string): boolean;
var
  AModule: HModule;
  AForm: TForm;
  ILogin: ICosmosLogin;
begin
{Este método apenas carrega a dll com a janela de login e retorna true ou false
conforme o usuário tenha clicado no botão "Conectar" ou não. Além disto,
armazena os dados de conexão fornecidos pelo usuário nos parâmetros do método.}
 try
  Result := False;
  AForm := self.LoadDialog('logint.bpl', 'TFrmLogin', AModule);

  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosLogin) then
        ILogin := AForm as ICosmosLogin;

       if Assigned(ILogin) then
        begin
          ILogin.XPStyle := TWinShell.IsWinXP;
          Result := ILogin.Login(UserName, Password, RoleName);
        end;

       Free;
      end;
   end;

 finally
  if Assigned(ILogin) then
   ILogin := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;


procedure TFrmMain.OnCloseConnection(Sender: TObject);
begin
 if not IRemoteCon.ConnectionBroker.Connected then
  ActCloseAllWindows.Execute;
end;

function TFrmMain.OpenRegisteredWindow(ModuleName, ClassName: string): TCustomForm;
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TCustomForm;
begin
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
      raise exception.Create(sUnregisteredClass);
     if AClass <> nil then
      FWinManager.CreateForm(TComponentClass(AClass), AForm);

     with AForm do
      begin
       AForm.ManualDock(PnlDock, nil, alClient);
       AForm.Show;
      end;
    end;
   Result := AForm;
  end;
end;

procedure TFrmMain.PopupActionBar1GetControlClass(Sender: TCustomActionBar;
  AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
begin
 if InterfaceStyle = isWinVista then
  ControlClass := TXPExStyleRichContent;
end;

procedure TFrmMain.ReadStartupOptions;
var
 Reg: TRegistryPersistence;
 StyleName: string;
begin
//Lê as configurações de inicialização da aplicação.
 Reg := TRegistryPersistence.Create;

 try
  FStarted := True;
  Reg.Open(sCurrentUserKey);
  Reg.OpenKey(sRegUsuariosVisual, True);

  //Lê a opção de estilos de menus
  StyleName := Reg.ReadString('Style');
  if ActionBarStyles.IndexOf(StyleName) >= 0 then
   if StyleName = 'New XP Style' then //do not localize!
    ActWinVistaStyle.Execute
   else
    ActModernStyle.Execute;

  //Lê a opção do estilo dos DockTabsets
  DockTab.Style := TTabSetTabStyle(Reg.ReadInteger('TabsStyle'));
  DockTabLeft.Style := DockTab.Style;

 //Lê a opção de exibição das dicas ao inicializar
  ShowTips := Reg.ReadBoolean('ShowTips');
  Reg.CloseKey;

  //Lê as configurações de conexão com o servidor
  Reg.OpenKey(sRegUsuariosConnections, False);
  DMCon.ObjBroker.LoadBalanced := Reg.ReadBoolean('LoadBalanced');
  ShowLogin := Reg.ReadBoolean('ShowLogin');

  Reg.CloseKey;

 finally
  if Assigned(Reg) then
   begin
    Reg.CloseKey;
    FreeAndNil(Reg);
   end;
 end;
end;

procedure TFrmMain.SetActiveDockedForm(Value: TCustomForm);
begin
 FActiveDockedForm := Value;
end;

procedure TFrmMain.SetConnectedUserInfo(const UserName, RoleName,
  ComputerName: string);
var
vData: Olevariant;
AReturn: TServerReturn;
begin
{Obtém informações sobre o usuário autenticado. Não será usado o perfil para
 determinar se o usuário é administrador ou não, mas esta info está no cadastro
 do usuário.}

 if IRemoteCon.ConnectionBroker.Connected = False then
  DMCon.ADMUser := False
 else
  begin
   DMCon.ADMUser := False;

   if DMCon.PerfilUsuario <> nil then
   begin
    with MainStatusBar.Panels do
     begin
      Items[1].Text := DMCon.PerfilUsuario.UserName; //UserName;
      Items[2].Text := DMCon.PerfilUsuario.RoleName; //RoleName;
      Items[3].Text := ComputerName;
     end;

    vData := IRemoteCon.OpenBufferedData(sBufPerfis);
    SecurityClass.Reset;
    SecurityClass.FillPrivileges(RoleName, vData);

    AReturn := TServerReturn.Create;

    try
     AReturn.ReadServerReturn(IRemoteCon.ConnectionBroker.AppServer.IsAdministrator(UserName));
     DMCon.ADMUser := AReturn.ServerData;

    finally
     if Assigned(AReturn) then
      FreeAndNil(AReturn);
    end;
   end;
  end;
end;

procedure TFrmMain.SetMaxPosition(const Value: integer);
begin
 PBar.Max := Value;
end;

procedure TFrmMain.SetPosition(const Value: integer);
begin
 PBar.Position := Value;
end;

procedure TFrmMain.SetRegistered;
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TForm;
  IRegister: IRegisterInfo;
begin
//Escreve o valor do campo FRegistered
  AModule := LoadPackage('regcosmos.bpl');

  if AModule <> 0 then
   begin
    try
     AClass := GetClass('TFrmRegister');
     if AClass <> nil then
      AForm := TComponentClass(AClass).Create(Application) as TForm;
      with AForm do
       begin
        if Supports(AForm, IRegisterInfo) then
         IRegister := AForm as IRegisterInfo;

        if Assigned(IRegister) then
         FRegistered := IRegister.IsRegistered(cmUsuarios);
        Free;
       end;

    finally
     if Assigned(IRegister) then
      IRegister := nil;
     UnloadPackage(AModule);
    end;
  end;
end;

procedure TFrmMain.SetVisible(const Value: boolean);
begin
 if Value = True then
  MainStatusBar.Panels[3].Style := psOwnerDraw
 else
  MainStatusBar.Panels[3].Style := psText;

 PBar.Visible := Value;
end;

procedure TFrmMain.ShowHint(Sender: TObject);
begin
//Exibe as dicas na barra de status.
 MainStatusBar.Panels[0].Text := Application.Hint;
end;

procedure TFrmMain.UpdateAllForms;
var
I: integer;
Form: TCustomForm;
IDockedForm: ICosmosDockedForm;
begin
  {Atualiza os dados exibidos em todas as janelas descendendetes de TDockedForm
   que se encontram abertas.}
 for I := 0 to Pred(FWinManager.FormCount) do
  begin
   Form := FWinManager.FindFormByID(I);
   if Supports(Form, ICosmosDockedForm) then
    begin
     IDockedForm := Form as ICosmosDockedForm;
     IDockedForm.UpdateData;
    end;
  end;
end;

procedure TFrmMain.MainStatusBarResize(Sender: TObject);
begin
 with MainStatusBar do
  begin
    Panels[3].Width := 80;
    Panels[2].Width := 80;
    Panels[1].Width := 80;
    Panels[0].Width := Width - 240;
  end;
end;

procedure TFrmMain.WriteStartupOptions;
var
 Reg: TRegistryPersistence;
begin
//Escreve as configurações de inicialização ao sair do ambiente
 try
  Reg := TRegistryPersistence.Create;
  Reg.Open(sCurrentUserKey);
  Reg.OpenKey(sRegUsuariosVisual, True);

  Reg.WriteBoolean('ShowTips', ShowTips);
  Reg.WriteString('Style',Manager.Style.GetStyleName);

  //Escreve as configurações de estilo dos DockTabSets
  Reg.WriteInteger('TabsStyle',Ord(DockTab.Style));

  //Escreve o status da janela principal, exceto se ela esiver minimizada
  if Self.WindowState <> wsMinimized then
    Reg.WriteInteger('MainStatus', Ord(Self.WindowState));

  Reg.CloseKey;

 finally
  if Assigned(Reg) then
   begin
    Reg.CloseKey;
    FreeAndNil(Reg);
   end;
 end;
end;

end.
