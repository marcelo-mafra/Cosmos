unit cosmos.servers.common.dataacess;

interface

uses
  System.SysUtils, System.Classes,  Datasnap.Provider, Data.DB, Datasnap.DBClient,
  Data.DBXFirebird, Data.SqlExpr, Data.DBXCommon, System.Variants, DataSnap.DsSession,
  cosmos.system.messages, cosmos.classes.application, cosmos.classes.servers.dataobj,
  cosmos.classes.persistence.ini, Winapi.Windows,
  cosmos.core.classes.FieldsInfo, Data.FMTBcd, cosmos.servers.sqlcommands,
  cosmos.system.types, cosmos.classes.ServerInterface, Data.DBXPool, cosmos.system.files,
  cosmos.system.winshell, cosmos.system.exceptions, cosmos.classes.logs,
  Data.DBXDBReaders, cosmos.classes.servers.cmdFactories, cosmos.servers.common.security,
  cosmos.classes.servers.datobjint;

type
  TDMServerDataAcess = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }
    FCosmosFolder, FCosmosMonitorFolder, FCosmosRootFile: string;
    FActiveRange: Int64; //Faixa de formação de chaves primárias.
    AFieldsInfoReader: TFieldsInfoReader;
    FConnectionPool: TCosmosConnectionsPool;

    function GetIUserManager: ICosmosUsersManager;
    procedure LoadDatabaseOptions;
    procedure RegisterDBError(const ErrorId: integer; ErrorMsg: string);
    procedure SetCosmosFolders;
    procedure WriteParamsCommandInfo(Dataset: TCustomSQLDataset; List: TStringList);

  public
    { Public declarations }
    //Criação de objetos de dados.
    function CreateCommand: TDBXCommand;
    function CreateDataset: TSQLDataset;
    function CreateReader(Dataset: TDataset): TDBXDataSetReader;
    function CreateStoreProcedure: TSQLStoredProc;
    procedure CloseDataset(const Dataset: TDataset); inline;

    //Operações de leitura e escrita.
    function DoExecuteDQL(SearchID: Integer; Params: OleVariant): TDataset; overload;
    function DoExecuteDQL(const DQL: WideString): TSQLDataset; overload;
    function DoExecuteCommand(const Command: WideString): integer;
    function DoExecuteScript(var AScript: TStringList): boolean;

    function DoGetSequenceValue(const SequenceName: WideString): integer;

    function GetDQLCommand(SearchID: Integer; const Params: OleVariant): WideString;

    //Logs
    function GetContextInfo(Dataset: TCustomSQLDataset): string;
    procedure OnUpdateError(E: EUpdateError; UpdateKind: TUpdateKind; var Response: TResolverResponse);

    //Transações
    function BeginTransaction(Connection: TSQLConnection): TDBXTransaction; overload;
    function BeginTransaction(Connection: TSQLConnection; const Isolation: integer): TDBXTransaction; overload;
    procedure CommitTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
    procedure RollbackTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
    procedure PrepareTransaction(var TD: TTransactionDesc);


     property ActiveRange: Int64 read FActiveRange;
     property ConnectionPool: TCosmosConnectionsPool read FConnectionPool;
     property CosmosFolder: string read FCosmosFolder;
     property CosmosRootFile: string read FCosmosRootFile;
     property UserManager: ICosmosUsersManager read GetIUserManager;
  end;

var
  DMServerDataAcess: TDMServerDataAcess;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses cosmos.servers.common.services;

{$R *.dfm}

function TDMServerDataAcess.BeginTransaction(Connection: TSQLConnection;
  const Isolation: integer): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction(Isolation)
 else
  Result := nil;
end;

function TDMServerDataAcess.BeginTransaction(
  Connection: TSQLConnection): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction
 else
  Result := nil;
end;

procedure TDMServerDataAcess.CloseDataset(const Dataset: TDataset);
begin
//Fecha um dataset ativo.
 if Assigned(Dataset) then
  if Dataset.Active then
   Dataset.Close;
end;

procedure TDMServerDataAcess.CommitTransaction(Connection: TSQLConnection;
  var Transaction: TDBXTransaction);
begin
//Confirma uma transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
  Connection.CommitFreeAndNil(Transaction);
end;

function TDMServerDataAcess.CreateCommand: TDBXCommand;
begin
 Result :=  ConnectionPool.ConnectionsPool.SQLConnection.DBXConnection.CreateCommand;
end;

function TDMServerDataAcess.CreateDataset: TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := ConnectionPool.ConnectionsPool.SQLConnection;
end;

function TDMServerDataAcess.CreateReader(Dataset: TDataset): TDBXDataSetReader;
begin
 Result := TDBXDataSetReader.Create(Dataset);
end;

function TDMServerDataAcess.CreateStoreProcedure: TSQLStoredProc;
begin
  Result := TSQLStoredProc.Create(nil);
  Result.SQLConnection := ConnectionPool.ConnectionsPool.SQLConnection;
end;

procedure TDMServerDataAcess.DataModuleCreate(Sender: TObject);
var
  AXMLFile: string;
begin
 FActiveRange := 0;

 //Obtém a pasta onde o servidor está instalado.
 SetCosmosFolders;

 LoadDatabaseOptions;

 //Pega a interface com o arquivo de configuração de dados dos campos de dados.
 AXMLFile := self.FCosmosFolder + TCosmosFiles.FieldsInfo;   //do not localize!
 AFieldsInfoReader := TFieldsInfoReader.Create(AXMLFile);
end;

procedure TDMServerDataAcess.DataModuleDestroy(Sender: TObject);
begin
 FConnectionPool.ClearAll;
// FConnectionPool.Free;
end;

function TDMServerDataAcess.DoExecuteCommand(
  const Command: WideString): integer;
var
 aCommand: cosmos.classes.servers.dataobj.TCosmosCommand;
begin
 //Executa um comando e retorna o número de linhas afetadas.
 aCommand := cosmos.classes.servers.dataobj.TCosmosCommand.Create;

 try
  Result := ACommand.ExecuteCommand(Command);

  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [Command]), '', leOnInformation);

 except
   on E: Exception do
    begin
     Result := -1;
     DMCosmosServerServices.RegisterLog(E.Message + #13 + Format(TCosmosLogs.SQLCommand, [Command]), '', leOnError);
     raise;
    end;
 end;
end;

function TDMServerDataAcess.DoExecuteDQL(const DQL: WideString): TSQLDataset;
begin
{Executa um comando DQL no objeto SQLSearch. A responsabilidade de fechar este
 dataset é dos métodos chamadores.}

 Result := CreateDataset;

 try
  Result.CommandText := DQL;
  Result.Open;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [DQL]), leOnError);
    raise;
   end;
 end;
end;

function TDMServerDataAcess.DoExecuteScript(
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
  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.ExecuteScriptBegin, [AScript.Text]), '', leOnInformation);
  Result := aScriptObj.ExecuteScript(aScript);

  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.ExecuteScriptEnd, [AScript.Text]), '', leOnInformation);

 except
  on E: Exception do
    begin
     DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [AScript.Text]), leOnError);
     raise;
    end;

 end;
end;

function TDMServerDataAcess.DoGetSequenceValue(
  const SequenceName: WideString): integer;
var
 aCommand: cosmos.classes.servers.dataobj.TCosmosCommand;
 ADataset: TClientDataset;
begin
 //Obtém o valor atual de uma sequence a partir do nome da sequence e da faixa
 //de chaves primárias.
 aCommand := cosmos.classes.servers.dataobj.TCosmosCommand.Create;
 aDataset := TClientDataset.Create(nil);

 try
  aCommand.ExecuteDQL(Format(TDQLCommands.Generators, [SequenceName, 1]), aDataset);
  Result := ADataset.Fields.Fields[0].Value + ActiveRange;

  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(aCommand) then FreeAndNil(aCommand);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SequenceName, [SequenceName]), leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(aCommand) then FreeAndNil(aCommand);
    raise;
   end;
 end;
end;

function TDMServerDataAcess.DoExecuteDQL(SearchID: Integer;
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
  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [ACommand]), GetContextInfo(ADataset), leOnInformation);

  Result := ADataset;

 except
  on E: Exception do
   begin
    Result := nil;
    DMCosmosServerServices.RegisterLog(E.Message, GetContextInfo(ADataset), leOnError);
    raise;
   end;
 end;
end;

function TDMServerDataAcess.GetContextInfo(Dataset: TCustomSQLDataset): string;
var
 AContextInfo: TStringList;
begin
 AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

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

function TDMServerDataAcess.GetDQLCommand(SearchID: Integer;
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
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
 end;
end;

function TDMServerDataAcess.GetIUserManager: ICosmosUsersManager;
begin
 Result := TCosmosSecurity.Create as ICosmosUsersManager;
end;

procedure TDMServerDataAcess.WriteParamsCommandInfo(
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

procedure TDMServerDataAcess.RegisterDBError(const ErrorId: integer; ErrorMsg: string);
var
 AContextInfo: TStringList;
begin
 {Registra informações de logs de erros de disparados pelo RDBMS. Os eventos
  OnErrorEvent de todos os objetos TSQLConnection do pool de conexões apontam
  para este método, que só registra eventos do tipo leOnError.}
 if leOnError in DMCosmosServerServices.LogEvents then
  begin
   AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

   try
    AContextInfo.Append(Format(TCosmosLogs.ErrorCode, [ErrorId]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));

    DMCosmosServerServices.RegisterLog(ErrorMsg, AContextInfo.DelimitedText, leOnError);

   finally
    FreeAndNil(AContextInfo);
   end;
  end;
end;

procedure TDMServerDataAcess.OnUpdateError(E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 {Este método converte os textos de mensagens de erro disparadas pelo RDBMS para
  mensagens melhores para a exibição ao usuário. Este método apenas é chamado a
  partir dos eventos OnUpdateError dos objetos TDatasetProvider existentes no
  sistema.}

  if E.Message.IndexOf('foreign key') >= 0 then
   E.Message := TCosmosErrorReconcile.ForeignKey //violation of foreign key.
  else
  if E.Message.IndexOf('exception 58') >= 0 then
   E.Message := TCosmosErrorMsg.ChangeConferenceControlModel
  else
   E.Message := TCosmosErrorReconcile.UnknownError;//Erro desconhecido.

end;

procedure TDMServerDataAcess.PrepareTransaction(var TD: TTransactionDesc);
begin
//Prepara nova transação
 Randomize;
 TD.TransactionID := Random(32767); //Gera o ID aleatório (smallint) da transação.
 TD.IsolationLevel := xilREADCOMMITTED;
end;

procedure TDMServerDataAcess.LoadDatabaseOptions;
var
  AFile: TIniFilePersistence;
  PoolSize: Integer;
begin
 //Carrega as configurações de conexão com banco de dados e monta o pool de conexões.
  DMCosmosServerServices.RegisterLog(TCosmosConnectionErrors.ReadingPoolInfo, 'TDMServerDataAcess.LoadDatabaseOptions', leOnInformation);

  AFile := TIniFilePersistence.Create(CosmosRootFile, True);

  try
    PoolSize := AFile.ReadInteger(DMCosmosServerServices.CosmosModuleShortName.ToUpper, TCosmosConnectionErrors.PoolSize, 5);
    FConnectionPool := TCosmosConnectionsPool.Create(CosmosFolder + TCosmosFiles.dbxconnections);
    FConnectionPool.OnErrorEvent := RegisterDBError;
    FConnectionPool.FillPool(PoolSize);

    if Assigned(AFile) then FreeAndNil(AFile);
    DMCosmosServerServices.RegisterLog(TCosmosLogs.DatabasePoolCreated, 'TDMServerDataAcess.LoadDatabaseOptions', leOnInformation);

  except
    on E: Exception do
    begin
      if Assigned(AFile) then FreeAndNil(AFile);
      DMCosmosServerServices.RegisterLog(E.Message, 'TDMServerDataAcess.LoadDatabaseOptions', leOnError);
    end;
  end;
end;

procedure TDMServerDataAcess.RollbackTransaction(Connection: TSQLConnection;
  var Transaction: TDBXTransaction);
begin
//Desfaz a transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
   Connection.RollbackFreeAndNil(Transaction);
end;

procedure TDMServerDataAcess.SetCosmosFolders;
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
  DMCosmosServerServices.RegisterLog(TCosmosLogs.SettingFolders, '', leOnInformation);

 finally
  if Assigned(aFile) then FreeAndNil(aFile);
 end;
end;

end.

