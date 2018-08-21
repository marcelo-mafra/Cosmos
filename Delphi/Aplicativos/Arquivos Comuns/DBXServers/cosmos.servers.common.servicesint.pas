unit cosmos.servers.common.servicesint;

interface

uses
 cosmos.system.types, cosmos.classes.logs, Datasnap.DSSession, System.Classes;

type
 ICosmosServerInterface = interface
   ['{DED4D8D6-0125-4318-923E-8BAC176DC871}']
 end;

 //Serviços do Datasnap.
 ICosmosDSService = interface(ICosmosServerInterface)
   ['{18773FDC-ED11-4080-BCD0-0D6ABAA10B9A}']
    function GetConnectedUser: string;
    function FindSession(const SessionId: string): TDSSession;

    property ConnectedUser: string read GetConnectedUser;
 end;

 //Serviços dos servidores do Cosmos.
 ICosmosService = interface(ICosmosServerInterface)
   ['{9B4CCBFF-723D-4262-A7D1-F237AD72159D}']
    function CreateContextInfoObject: TStringList;
    function GetCosmosModuleName: string;
    function GetCosmosModuleIdentifier: string;
    function GetCosmosModuleShortName: string;
    function GetDSService: ICosmosDSService;
    function GetLogs: ICosmosLogs;
    function GetLogEvents: TLogEvents;
    procedure RegisterLog(const Info, ContextInfo: string; Event: TLogEvent = leOnInformation);

    property CosmosModuleName: string read GetCosmosModuleName;
    property CosmosModuleIdentifier: string read GetCosmosModuleIdentifier;
    property CosmosModuleShortName: string read GetCosmosModuleShortName;
    property DSService: ICosmosDSService read GetDSService;
    property Logs: ICosmosLogs read GetLogs;
    property LogEvents: TLogEvents read GetLogEvents;
 end;


 ICosmosServiceFactory = interface(ICosmosServerInterface)
   ['{83B76C31-8602-46AE-B9EC-FA8BF816B0A3}']
    function GetCosmosLogs: ICosmosLogs;
    function GetCosmosService: ICosmosService;
    function GetDSService: ICosmosDSService;

    property CosmosService: ICosmosService read GetCosmosService;
    property DSService: ICosmosDSService read GetDSService;
    property Logs: ICosmosLogs read GetCosmosLogs;
 end;



implementation

end.
