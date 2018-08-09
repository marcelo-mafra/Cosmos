unit Cosmos.Framework.Interfaces.DataAcess;

interface

uses

 System.Classes, Data.DB, Datasnap.DSConnect, Datasnap.DBClient, cosmos.system.types,
 cosmos.classes.application, cosmos.classes.ServerInterface,
 cosmos.Framework.datanavigators.common, cosmos.classes.security, Data.DBXCommon,
 cosmos.core.client.connection, Data.SQLExpr, Vcl.Graphics, Data.DBXDBReaders,
 Cosmos.Framework.Interfaces.ConnectionNotifiers;

 type

 //Mapeia os módulos remotos da aplicação servidora que disponibilizam DatasetProviders.
 TServerClass = (scCommon, scLogradouros, scLectorium,
  scMocidade, scMembros, scPesquisadores, scEscolaInterna, scAtividades,
  scHistorico, scUsuarios, scConferencias, scFinanceiro, scFocos);

 TBooleanResult = (rmSucess, rmUnsucess, rmCanceled, rmFailure);

 IDataAcessInterface = interface
   ['{6782D8A1-F29E-44B6-8827-09DC032CE069}']
 end;


  ///<author>Marcelo Mafra</author>
  ///  <version>1.0</version>
  ICosmosExporter = interface(IDataAcessInterface)
   ['{5173FEF5-9174-48AA-ACD7-0A0028C2CCBA}']
//   procedure Exportar(Data: Olevariant; Options: TCosmosData);
//   function ExecuteDialog(InfoData: TCosmosData): boolean;
    procedure ExportToTXT(Dataset: TDataset; const FileName: string);
    procedure ExportToXML(Dataset: TDataset; const FileName: string);
    procedure ExportToMSWord(Dataset: TDataset; const FileName: string);
    procedure ExportToMSExcel(Dataset: TDataset; const FileName: string);
    procedure ExportToCSV(Dataset: TDataset; const FileName: string);
    procedure ExportToHTML(Dataset: TDataset; const FileName: string);
    procedure ExportToOpenOffice(Dataset: TDataset; const FileName: string);
//   function GetEnabledExportFormats: TExportFormatSet;
//   procedure SetEnabledExportFormats(const Value: TExportFormatSet);

//   property EnabledExportFormats: TExportFormatSet read GetEnabledExportFormats write SetEnabledExportFormats;
 end;

 ///<author>Marcelo Mafra</author>
 ///  <version>1.0</version>
 ICosmosRemoteConnection = interface(IDataAcessInterface)
    ['{8412213E-CFD9-4880-8263-61D5C4C35815}']

    function GetCertificateData: TCosmosData;
    function GetConnected: boolean;
    function GetConnectedUser: string;
    function GetConnectedUserRoles: string;
    function GetConnectedServer: string;
    function GetConnectedPort: integer;
    procedure SetConnected(Value: boolean);
    function GetConnectionBroker: TDSProviderConnection;
    function GetConnectionProtocol: TConnectionProtocol;
    function GetConnectionParamsInfo: string;
    function GetConnectionStatusNotifier: IConnectionStatusObservable;
    function GetActiveDataset: TDataset;
    procedure SetActiveDataset(value: TDataset);
    function GetActiveDataNavigator: TCustomDataNavigator;
    procedure SetActiveDataNavigator(value: TCustomDataNavigator);
    function GetCurrentConnectionInfo: TCosmosSecurity;
    function GetCurrentConnectionMode: TConnectionMode;
    function GetCurrentUser: TCosmosUser;
    function GetMonitorConnection: boolean;
    procedure SetMonitorConnection(value: boolean);
    function GetRemoteHost: string;
    function GetServerDateTime: TDateTime;

    procedure CloseConnection;
    function ConnectServer: boolean;
    procedure ReconnectServer;
    function CreateCommand: TDBXCommand;
    function CreateConnection(const ServerClass: TServerClass): TDSProviderConnection;
    function CreateReader(Dataset: TClientDataset): TDBXDataSetReader;
    procedure DropConnection(RemoteConnection: TDSProviderConnection);
    procedure BufferData(const Table: TCosmosTables; FileName: string); overload;
    procedure BufferData(const FileName: string; Data: Olevariant); overload;
    function ChangePassword(const CurrentPassword: string): boolean;
    function IdenticacaoAtiva: TBooleanResult;
    function ExecuteDQL(const Search: TCosmosSearch; Params: Olevariant): TDataset; overload;
    procedure ExecuteDQL(const Search: TCosmosSearch; Params: Olevariant; Dataset: TClientDataset); overload;
    function ExecuteRegisteredSearch(const SearchId: integer; Params: Olevariant): TDataset; overload;
    procedure ExecuteRegisteredSearch(const SearchId: integer; Params: Olevariant; ADataset: TClientDataset); overload;
    function ExecuteCommand(const Command: TCosmosCommand; Params: Olevariant): boolean;
    function GetAcessedFocus(const UserName: string; CosmosModule: TCosmosModules): TSQLDataset;
    function GetFotoCadastrado(const IdCadastrado: integer): TPicture; overload;
    function GetFotoCadastrado(ImageStream: TMemoryStream): TPicture; overload;
    function ListData(const Search: TCosmosSearch; Params: Olevariant): TDBXReader;
    procedure LoadFieldsInfo(Dataset: TDataset);
    procedure ProcessDBXError(E: TDBXError);
    function OpenBufferedData(const BufferID: string): TClientDataset;
    function OpenTableData(const Table: TCosmosTables): string;
    procedure DefaultLocate;
    procedure DefaultExport(Dataset: TDataset);
    function GetSequenceValue(const SequenceName: string): integer;
    procedure InsertDefaultData(const Dataset: TDataset; Data: TCosmosData);
    function ReconcileError(E: EReconcileError; UpdateKind: TUpdateKind): TReconcileAction;
    procedure RegisterRemoteCallSucess(const RemoteMethod: string);
    procedure RegisterRemoteCallFailure(const Error, RemoteMethod: string);
    function ToClientDataset(Source: TCustomSQLDataset): TClientDataset; overload;
    procedure ToClientDataset(Source: TCustomSQLDataset; Target: TClientDataset); overload;
    function TestConnectedServer: boolean;

    property ActiveDataset: TDataset read GetActiveDataset write SetActiveDataset;
    property ActiveDataNavigator: TCustomDataNavigator read GetActiveDataNavigator write SetActiveDataNavigator;
    property CertificateData: TCosmosData read GetCertificateData;
    property Connected: boolean read GetConnected write SetConnected;
    property ConnectedUser: string read GetConnectedUser;
    property ConnectedUserRoles: string read GetConnectedUserRoles;
    property ConnectedServer: string read GetConnectedServer;
    property ConnectedPort: integer read GetConnectedPort;
    property ConnectionBroker: TDSProviderConnection read GetConnectionBroker;
    property ConnectionParamsInfo: string read GetConnectionParamsInfo;
    property ConnectionProtocol: TConnectionProtocol read GetConnectionProtocol;
    property ConnectionStatusNotifier: IConnectionStatusObservable  read GetConnectionStatusNotifier;
    property CurrentConnectionInfo: TCosmosSecurity read GetCurrentConnectionInfo;
    property CurrentConnectionMode: TConnectionMode read GetCurrentConnectionMode;
    property CurrentUser: TCosmosUser read GetCurrentUser;
    property MonitorConnection: boolean read GetMonitorConnection write SetMonitorConnection;
    property RemoteHost: string read GetRemoteHost;
    property ServerDateTime: TDateTime read GetServerDateTime;


  end;

implementation

end.
