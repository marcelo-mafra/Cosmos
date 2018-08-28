unit cosmos.servers.common.dataacess;

interface

uses
  System.SysUtils, System.Classes, Datasnap.Provider,  Data.DB, Datasnap.DBClient,
  Data.DBXFirebird, Data.SqlExpr, Data.DBXCommon, System.Variants, DataSnap.DsSession,
  cosmos.system.messages, cosmos.classes.application, cosmos.classes.servers.dataobj,
  cosmos.classes.persistence.ini, cosmos.system.files, cosmos.system.types,
  cosmos.servers.sqlcommands, cosmos.classes.ServerInterface,
  cosmos.system.exceptions, cosmos.classes.logs, Data.DBXDBReaders,
  cosmos.classes.servers.cmdFactories, cosmos.servers.common.security,
  cosmos.classes.servers.datobjint, cosmos.servers.common.servicesint,
  cosmos.servers.common.dao.interfaces, cosmos.servers.common.services.factory;

type

  TServerDataAcess = class(TInterfacedObject,  ICosmosDAOService)

  private
    { Private declarations }
    FCosmosFolder, FCosmosMonitorFolder, FCosmosRootFile: string;
    AFieldsInfoReader: TFieldsInfoReader;
    FCosmosModule: TCosmosModules;
    FConnectionPool: TCosmosConnectionsPool;
    FCosmosServerServices: ICosmosService;

    function GetDQLCommand(SearchID: Integer; const Params: OleVariant): WideString;
    procedure LoadDatabaseOptions;
    procedure RegisterDBError(const ErrorId: integer; ErrorMsg: string);
    procedure SetCosmosFolders;
    procedure WriteParamsCommandInfo(Dataset: TCustomSQLDataset; List: TStringList);

  protected
    //Operações de leitura e escrita.
    function CreateCommand: TDBXCommand;
    function CreateStoreProcedure: TSQLStoredProc;
    function DoExecuteCommand(const Command: WideString): integer;
    function DoExecuteDQL(SearchID: Integer; Params: OleVariant): TDataset; overload;
    function DoExecuteDQL(const DQL: WideString): TSQLDataset; overload;
    function DoGetSequenceValue(const SequenceName: WideString): integer;
    function DoExecuteScript(var AScript: TStringList): boolean;
    //Logs
    function GetContextInfo(Dataset: TCustomSQLDataset): string;

    procedure OnUpdateError(E: EUpdateError; UpdateKind: TUpdateKind; var Response: TResolverResponse);

    function GetSQLConnection: TSQLConnection;
    function GetIUserManager: ICosmosUsersManager;

  public
    { Public declarations }
    constructor Create(Module: TCosmosModules);
    destructor Destroy; override;
    class function New(Module: TCosmosModules): ICosmosDAOService;

    //Criação de objetos de dados.
    function CreateDataset: TSQLDataset;
    function CreateReader(Dataset: TDataset): TDBXDataSetReader;
    procedure CloseDataset(const Dataset: TDataset); inline;

    //Transações
    function BeginTransaction(Connection: TSQLConnection): TDBXTransaction; overload;
    function BeginTransaction(Connection: TSQLConnection; const Isolation: integer): TDBXTransaction; overload;
    procedure CommitTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
    procedure RollbackTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
    procedure PrepareTransaction(var TD: TTransactionDesc);


    property CosmosFolder: string read FCosmosFolder;
    property CosmosModule: TCosmosModules read FCosmosModule;
    property CosmosRootFile: string read FCosmosRootFile;
    property CosmosServerServices: ICosmosService read FCosmosServerServices;

    //ICosmosDAOService
    property SQLConnection: TSQLConnection read GetSQLConnection;
    property UserManager: ICosmosUsersManager read GetIUserManager;
  end;


implementation


function TServerDataAcess.BeginTransaction(Connection: TSQLConnection;
  const Isolation: integer): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction(Isolation)
 else
  Result := nil;
end;

function TServerDataAcess.BeginTransaction(
  Connection: TSQLConnection): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction
 else
  Result := nil;
end;

procedure TServerDataAcess.CloseDataset(const Dataset: TDataset);
begin
//Fecha um dataset ativo.
 if Assigned(Dataset) and (Dataset.Active) then
   Dataset.Close;
end;

procedure TServerDataAcess.CommitTransaction(Connection: TSQLConnection;
  var Transaction: TDBXTransaction);
begin
//Confirma uma transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
  Connection.CommitFreeAndNil(Transaction);
end;

constructor TServerDataAcess.Create(Module: TCosmosModules);
begin
 FCosmosModule := Module;
 //Obtém a pasta onde o servidor está instalado.
 FCosmosServerServices := TCosmosServiceFactory.New(CosmosModule).CosmosService;
 SetCosmosFolders;

 LoadDatabaseOptions;

 //Pega a interface com o arquivo de configuração de dados dos campos de dados.
 AFieldsInfoReader := TFieldsInfoReader.Create(self.FCosmosFolder + TCosmosFiles.FieldsInfo);
end;

function TServerDataAcess.CreateCommand: TDBXCommand;
begin
 Result :=  SQLConnection.DBXConnection.CreateCommand;
end;

function TServerDataAcess.CreateDataset: TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := self.SQLConnection;
end;

function TServerDataAcess.CreateReader(Dataset: TDataset): TDBXDataSetReader;
begin
 Result := TDBXDataSetReader.Create(Dataset);
end;

function TServerDataAcess.CreateStoreProcedure: TSQLStoredProc;
begin
  Result := TSQLStoredProc.Create(nil);
  Result.SQLConnection := self.SQLConnection;
end;

destructor TServerDataAcess.Destroy;
begin
 FCosmosServerServices := nil;
 FConnectionPool.ClearAll;
 inherited;
end;

function TServerDataAcess.DoExecuteCommand(
  const Command: WideString): integer;
var
 aCommand: cosmos.classes.servers.dataobj.TCosmosCommand;
begin
 //Executa um comando e retorna o número de linhas afetadas.
 aCommand := cosmos.classes.servers.dataobj.TCosmosCommand.Create;

 try
  Result := ACommand.ExecuteCommand(Command);
  CosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [Command]), '', leOnInformation);

 except
   on E: Exception do
    begin
     Result := -1;
     CosmosServerServices.RegisterLog(E.Message + #13 + Format(TCosmosLogs.SQLCommand, [Command]), '', leOnError);
     raise;
    end;
 end;
end;

function TServerDataAcess.DoExecuteDQL(const DQL: WideString): TSQLDataset;
begin
{Executa um comando DQL em um objeto TSQLDataset.}
 Result := CreateDataset;

 try
  Result.CommandText := DQL;
  Result.Open;

 except
  on E: Exception do
   begin
    CosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [DQL]), leOnError);
    raise;
   end;
 end;
end;

function TServerDataAcess.DoExecuteScript(
  var AScript: TStringList): boolean;
var
 aScriptObj: TCosmosScript;
begin
{Executa um script com diversos comandos sql de forma atômica. Caso ocorra
alguma falha, toda a operação será desfeita.}
 if not Assigned(AScript) then
  Exit;

 aScriptObj := TCosmosScript.Create;

 try
  CosmosServerServices.RegisterLog(Format(TCosmosLogs.ExecuteScriptBegin, [AScript.Text]), '', leOnInformation);
  Result := aScriptObj.ExecuteScript(aScript);

  CosmosServerServices.RegisterLog(Format(TCosmosLogs.ExecuteScriptEnd, [AScript.Text]), '', leOnInformation);

 except
  on E: Exception do
    begin
     CosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [AScript.Text]), leOnError);
     raise;
    end;

 end;
end;

function TServerDataAcess.DoGetSequenceValue(
  const SequenceName: WideString): integer;
var
 aCommand: cosmos.classes.servers.dataobj.TCosmosCommand;
 ADataset: TClientDataset;
begin
 //Obtém o valor atual de uma sequence a partir do nome dela.
 aCommand := cosmos.classes.servers.dataobj.TCosmosCommand.Create;
 aDataset := TClientDataset.Create(nil);

 try
  aCommand.ExecuteDQL(Format(TDQLCommands.Generators, [SequenceName, 1]), aDataset);
  Result := ADataset.Fields.Fields[0].Value ;

  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(aCommand) then FreeAndNil(aCommand);

 except
  on E: Exception do
   begin
    CosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SequenceName, [SequenceName]), leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(aCommand) then FreeAndNil(aCommand);
    raise;
   end;
 end;
end;

function TServerDataAcess.DoExecuteDQL(SearchID: Integer;
  Params: OleVariant): TDataset;
var
ACosmosSearch: TCosmosSearch;
ACommand: string;
ADataset: TSQLDataset;
begin
//Executa uma pesquisa padrão do Cosmos.
 ACosmosSearch :=  TSQLServerInterface.GetCosmosSearch(SearchID);
 ACommand := TSQLCommandsFactory.GetSQLCommand(ACosmosSearch);
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);

 ADataset := CreateDataset;

 try
  //Executa o comando DQL...
  ADataset.CommandText := ACommand;
  ADataset.Open;
  CosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [ACommand]), GetContextInfo(ADataset), leOnInformation);

  Result := ADataset;

 except
  on E: Exception do
   begin
    Result := nil;
    CosmosServerServices.RegisterLog(E.Message, GetContextInfo(ADataset), leOnError);
    raise;
   end;
 end;
end;

function TServerDataAcess.GetContextInfo(Dataset: TCustomSQLDataset): string;
var
 AContextInfo: TStringList;
begin
 AContextInfo := CosmosServerServices.CreateContextInfoObject;

 if (Dataset <> nil) and (Dataset is TSQLDataset) and (TSQLDataset(Dataset).CommandText.Trim <> '') then
  begin
    AContextInfo.Append(Format(TCosmosLogs.SQLCommand, [TSQLDataset(Dataset).CommandText]));
    WriteParamsCommandInfo(Dataset, AContextInfo);
  end
 else
 if (Dataset <> nil) and (Dataset is TSQLStoredProc) and (TSQLStoredProc(Dataset).StoredProcName.Trim <> '') then
  begin
    AContextInfo.Append(Format(TCosmosLogs.SQLStoredProc, [TSQLStoredProc(Dataset).StoredProcName]));
    WriteParamsCommandInfo(Dataset, AContextInfo);
  end
 else
 if (Dataset <> nil) and (Dataset is TSQLQuery) and (TSQLQuery(Dataset).CommandText.Trim <> '') then
  begin
    AContextInfo.Append(Format(TCosmosLogs.SQLStoredProc, [TSQLQuery(Dataset).CommandText]));
    WriteParamsCommandInfo(Dataset, AContextInfo);
  end;

  Result := AContextInfo.DelimitedText;
end;

function TServerDataAcess.GetDQLCommand(SearchID: Integer;
  const Params: OleVariant): WideString;
var
ACommand: string;
begin
{Retorna para o cliente um comando DQL. Isto é necessário apenas na situação em
que um TClientDataset está conectado a um Provider, de forma a trazer todas
as propriedades dos TFields para o lado cliente.}

 try
  ACommand := TSQLCommandsFactory.GetSQLCommand(TSQLServerInterface.GetCosmosSearch(SearchID));
  TSQLCommandsFactory.CreateCommandText(ACommand, Params);
  Result := ACommand;

 except
  on E: Exception do
   begin
    E.Message := TCosmosErrorMsg.GetCommand;
    CosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
 end;
end;

function TServerDataAcess.GetIUserManager: ICosmosUsersManager;
begin
 Result := TCosmosSecurity.New(CosmosModule);
end;

function TServerDataAcess.GetSQLConnection: TSQLConnection;
begin
//Retorna uma conexão do pool de conexões.
 Result := FConnectionPool.ConnectionsPool.SQLConnection;
end;

procedure TServerDataAcess.WriteParamsCommandInfo(
  Dataset: TCustomSQLDataset; List: TStringList);
var
 I: integer;
 AInfo: string;
 AParam: TParam;
begin
 if Dataset is TSQLDataset then
  begin
    for I := 0 to Pred(TSQLDataset(Dataset).Params.Count) do
     begin
      AParam := TSQLDataset(Dataset).Params.Items[I];
      AInfo := '';
      AInfo := AInfo.Format(TCosmosLogs.SQLParamsInfo, [AParam.Name, AParam.Value]);
      List.Append(AInfo);
     end;
  end
 else
 if Dataset is TSQLStoredProc then
  begin
    for I := 0 to Pred(TSQLStoredProc(Dataset).Params.Count) do
     begin
      AParam := TSQLStoredProc(Dataset).Params.Items[I];
      AInfo := '';
      AInfo := AInfo.Format(TCosmosLogs.SQLParamsInfo, [AParam.Name, AParam.Value]);
      List.Append(AInfo);
     end;
  end
end;

procedure TServerDataAcess.RegisterDBError(const ErrorId: integer; ErrorMsg: string);
var
 AContextInfo: TStringList;
begin
 {Registra informações de logs de erros de disparados pelo RDBMS. Os eventos
  OnErrorEvent de todos os objetos TSQLConnection do pool de conexões apontam
  para este método, que só registra eventos do tipo leOnError.}
 if leOnError in CosmosServerServices.LogEvents then
  begin
   AContextInfo := CosmosServerServices.CreateContextInfoObject;

   try
    AContextInfo.Append(Format(TCosmosLogs.ErrorCode, [ErrorId]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));

    CosmosServerServices.RegisterLog(ErrorMsg, AContextInfo.DelimitedText, leOnError);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

procedure TServerDataAcess.OnUpdateError(E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 {Este método converte os textos de mensagens de erro disparadas pelo RDBMS para
  mensagens melhores para a exibição ao usuário. Este método apenas é chamado a
  partir dos eventos OnUpdateError dos objetos TDatasetProvider existentes no
  sistema.}

  if E.Message.IndexOf('foreign key') >= 0 then  //do not localize!
   E.Message := TCosmosErrorReconcile.ForeignKey //violation of foreign key.
  else
  if E.Message.IndexOf('exception 58') >= 0 then //do not localize!
   E.Message := TCosmosErrorMsg.ChangeConferenceControlModel
  else
   E.Message := TCosmosErrorReconcile.UnknownError;//Erro desconhecido.

end;

procedure TServerDataAcess.PrepareTransaction(var TD: TTransactionDesc);
begin
//Prepara nova transação
 Randomize;
 TD.TransactionID := Random(32767); //Gera o ID aleatório (smallint) da transação.
 TD.IsolationLevel := xilREADCOMMITTED;
end;

procedure TServerDataAcess.LoadDatabaseOptions;
var
  AFile: TIniFilePersistence;
  PoolSize: Integer;
begin
 //Carrega as configurações de conexão com banco de dados e monta o pool de conexões.
  CosmosServerServices.RegisterLog(TCosmosConnectionErrors.ReadingPoolInfo, 'TDMServerDataAcess.LoadDatabaseOptions', leOnInformation); //do not localize!

  AFile := TIniFilePersistence.Create(CosmosRootFile, True);

  try
    PoolSize := AFile.ReadInteger(CosmosServerServices.CosmosModuleShortName.ToUpper, TCosmosConnectionErrors.PoolSize, 5);
    FConnectionPool := TCosmosConnectionsPool.Create(CosmosFolder + TCosmosFiles.dbxconnections);
    FConnectionPool.OnErrorEvent := RegisterDBError;
    FConnectionPool.FillPool(PoolSize);

    if Assigned(AFile) then FreeAndNil(AFile);
    CosmosServerServices.RegisterLog(TCosmosLogs.DatabasePoolCreated, 'TDMServerDataAcess.LoadDatabaseOptions', leOnInformation); //do not localize!

  except
    on E: Exception do
    begin
      if Assigned(AFile) then FreeAndNil(AFile);
      CosmosServerServices.RegisterLog(E.Message, 'TDMServerDataAcess.LoadDatabaseOptions', leOnError); //do not localize!
    end;
  end;
end;

class function TServerDataAcess.New(
  Module: TCosmosModules): ICosmosDAOService;
begin
 Result := self.Create(Module);
end;

procedure TServerDataAcess.RollbackTransaction(Connection: TSQLConnection;
  var Transaction: TDBXTransaction);
begin
//Desfaz a transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
   Connection.RollbackFreeAndNil(Transaction);
end;

procedure TServerDataAcess.SetCosmosFolders;
var
 CosmosApp: TCosmosApplication;
 aFile: TIniFilePersistence;
begin
{Obtém o caminho de algumas pastas importantes do sistema.}
 CosmosApp := TCosmosApplication.Create;

 try
  FCosmosFolder := CosmosApp.GetModulePath;
  FCosmosRootFile := FCosmosFolder + TCosmosFiles.CosmosRoot;

 finally
  if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
 end;


 {Obtém a pasta onde serão armazenados arquivos de monitoração das transações
  com o servidor SQL.}
 aFile :=  TIniFilePersistence.Create(CosmosRootFile, True);

 try
  FCosmosMonitorFolder := aFile.ReadString('DatabaseMonitor','MonitorFolder', ''); //do not localize!
  CosmosServerServices.RegisterLog(TCosmosLogs.SettingFolders, '', leOnInformation);

 finally
  if Assigned(aFile) then FreeAndNil(aFile);
 end;
end;

end.

