unit cosmos.framework.interfaces.utils;

interface

uses Classes, Vcl.Forms, Vcl.Graphics, cosmos.system.types,
 cosmos.classes.application;

type

  ICosmosUtilsInterface = interface
    ['{8B8E0257-B724-4D97-AD86-FA173B9FF946}']

  end;

  ICosmosUtilities = interface
    ['{C7705798-D870-428D-B963-B8CBD8679635}']

    function EncriptString(const InString: string): string;
    function DecryptString(const InString: string): string;
    function HashString(const InString: string): string;
  end;

  ICosmosApplicationPaths = interface(ICosmosUtilsInterface)
    ['{B0B6FB42-8A67-4516-88CF-503A7BE85512}']
     //Paths
     function ReadInstallationPath: string;
     function ReadHelpFilesPath: string;
     function ReadReportsFolder(Module: TCosmosModules): string;

     function ReadBufferedDataPath: string;
     function ReadMonitorConnectionPath: string;
     function ReadTasksFilesPath: string;
     function ReadCommonAppDataPath: string;
     function ReadUserAppDataPath: string;
     function ReadUpdatesFolder: string;

     //Files
     function GetHelpFile(CosmosModule: TCosmosModules): string;
     function GetUserConfigurationsFile: string;
     function GetCommonConfigurationsFile: string;
     function GetReportParamsFile: string;
     function GetCentralPesquisaFile: string;
     function GetFormsInfoFile: string;

  end;

  ICosmosUpdater = interface(ICosmosUtilsInterface)
    ['{847584C5-F323-4419-BB4F-66FC4E1CE3E9}']

    function CanUpdate: boolean;
    function HasUpdates: boolean;
    function ExecuteUpdate: boolean;
    procedure ExecuteWizard;
  end;

  ICosmosWindowsManager = interface(ICosmosUtilsInterface)
    ['{AD698E0C-4364-45CA-B475-69CBF2C70909}']
    function GetFormCount: integer;

    procedure ActivateForm(Form: TCustomForm); overload;
    procedure ActivateForm(const ClassName: string); overload;
    procedure CloseAllRegisteredWindows;
    function CloseRegisteredWindow(const WindowCaption: string): boolean; overload;
    function CloseRegisteredWindows(const ClassName: TClass): boolean; overload;
    function ExtractFormIcon(Form: TCustomForm): TIcon;
    function FindFormByID(const ID: integer): TCustomForm;
    function FindFormByCaption(const Caption: string): TCustomForm;
    function FindFormByClassName(const ClassName: string): TCustomForm;
    procedure UpdateAllForms;
    procedure LoadFormInfo(Form: TCustomForm);
    procedure SaveFormInfo(Form: TCustomForm); overload;
    procedure SaveFormInfo(FormClassName: string); overload;

    property FormCount: integer read GetFormCount;
  end;


implementation

end.
