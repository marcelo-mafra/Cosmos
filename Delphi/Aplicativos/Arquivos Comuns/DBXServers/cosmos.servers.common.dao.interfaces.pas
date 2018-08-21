unit cosmos.servers.common.dao.interfaces;

interface

uses
 Data.SQLExpr, cosmos.classes.servers.datobjint, System.Classes, Data.DB,
  Datasnap.Provider, Data.DBXCommon;

type
 ICosmosDAOService = interface
   ['{AFACBADB-31AB-4DE5-9FBC-3CA11427283C}']
   function CreateCommand: TDBXCommand;
   function CreateStoreProcedure: TSQLStoredProc;
   function DoExecuteCommand(const Command: WideString): integer;
   function DoExecuteDQL(SearchID: Integer; Params: OleVariant): TDataset; overload;
   function DoExecuteDQL(const DQL: WideString): TSQLDataset; overload;
   function DoGetSequenceValue(const SequenceName: WideString): integer;
   function DoExecuteScript(var AScript: TStringList): boolean;
   function GetIUserManager: ICosmosUsersManager;
   function GetSQLConnection: TSQLConnection;
   function GetContextInfo(Dataset: TCustomSQLDataset): string;
   procedure OnUpdateError(E: EUpdateError; UpdateKind: TUpdateKind; var Response: TResolverResponse);

   property SQLConnection: TSQLConnection read GetSQLConnection;
   property UserManager: ICosmosUsersManager read GetIUserManager;
 end;


 ICosmosDAOServiceFactory = interface
   ['{8C3E11A4-DAD6-4DAE-AA0A-A64191200284}']
   function GetDAOService: ICosmosDAOService;

   property DAOService: ICosmosDAOService read GetDAOService;
 end;

implementation

end.
