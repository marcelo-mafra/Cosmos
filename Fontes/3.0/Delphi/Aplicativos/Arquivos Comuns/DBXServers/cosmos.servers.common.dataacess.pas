unit cosmos.servers.common.dataacess;

interface

uses
  System.SysUtils, System.Classes,  Datasnap.Provider, Data.DB, Datasnap.DBClient,
  Data.DBXFirebird, Data.SqlExpr, Data.DBXCommon, System.Variants, DataSnap.DsSession,
  cosmos.system.messages, cosmos.classes.application, cosmos.classes.dataobjects,
  cosmos.classes.servers.security, cosmos.classes.persistence.ini, Winapi.Windows,
  cosmos.core.classes.FieldsInfo, Data.FMTBcd, cosmos.servers.sqlcommands,
  cosmos.system.types, cosmos.classes.ServerInterface, Data.DBXPool,
  cosmos.system.winshell, cosmos.system.exceptions, cosmos.classes.logs,
  Data.DBXDBReaders;

type
  TDMServerDataAcess = class(TDataModule)
    SQLCon: TSQLConnection;
    SQLCommand: TSQLDataSet;
    SQLSearch: TSQLDataSet;
    DspSearch: TDataSetProvider;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SQLCommandBeforeOpen(DataSet: TDataSet);

  private
    { Private declarations }
    FCosmosFolder, FCosmosMonitorFolder, FCosmosRootFile, FConnectionRole, FConnectionPath: string;
    FActiveRange: Int64; //Faixa de formação de chaves primárias.
    AFieldsInfoReader: TFieldsInfoReader;
    FConnectionUser, FConnectionPass, FConnectionCharset: string;
    FConnectionPool: TConnectionsPool;

    procedure WriteParamsCommandInfo(Dataset: TCustomSQLDataset; List: TStringList);
    procedure LoadDatabaseOptions;
    procedure OnDatabaseError(DBXError: TDBXError);


  public
    { Public declarations }

    //Criação de objetos de dados.
    function CreateCommand: TDBXCommand;
    function CreateDataset: TSQLDataset;
    function CreateReader(Dataset: TDataset): TDBXDataSetReader;
    function CreateStoreProcedure: TSQLStoredProc;

    procedure DoBufferData(const SchemmaName: WideString;
      out DataPackage: OleVariant);

    function IsAdministrator(const UserName: WideString): Boolean;
    procedure CloseDataset(const Dataset: TDataset); inline;
    procedure SetConnectionParams; inline;//Carrega informações sobre a conexão com o banco de dados.

    //Operações de leitura e escrita.
    function DoExecuteDQL(SearchID: Integer; Params: OleVariant): TDataset; overload;
    function DoExecuteDQL(const DQL: WideString): TSQLDataset; overload;
    function DoExecuteCommand(const Command: WideString): integer;
    function DoExecuteScript(var AScript: TStringList): boolean;
    procedure ConvertToClientDataset(Source: TCustomSQLDataset; Destination: TClientDataset);

    function DoGetSequenceValue(const SequenceName: WideString): integer;

    function GetDQLCommand(SearchID: Integer; const Params: OleVariant): WideString;

    function NewSQLMonitorFile: string;
    procedure SetCosmosFolders;
    procedure SetUserInfo(UserName, Password, RoleName: WideString; var UserData: TCosmosData);
    function GetUserStatus(const UserName: string): TUserStatus;

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
     property ConnectionPool: TConnectionsPool read FConnectionPool;
     property ConnectionUser: string read FConnectionUser; //usuário interno que se usará para conectar com o banco de dados.
     property ConnectionPass: string read FConnectionPass; //Senha do usuário interno.
     property ConnectionRole: string read FConnectionRole; //Role do usuário interno.
     property ConnectionCharset: string read FConnectionCharset; //Charset da conexão interna;

     property CosmosFolder: string read FCosmosFolder;
     property CosmosRootFile: string read FCosmosRootFile;
  end;

var
  DMServerDataAcess: TDMServerDataAcess;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses cosmos.servers.common.services;

{$R *.dfm}

procedure TDMServerDataAcess.DoBufferData(const SchemmaName: WideString;
  out DataPackage: OleVariant);
var
TD: TDBXTransaction;
begin
//Bufferiza um pacote de dados no formato olevariant que é envidao para o cliente.
 try
  TD := self.BeginTransaction(SQLCon);
  SQLSearch.CommandText := Format(TDQLCommand.BufferSchemma, [SchemmaName]);
  DataPackage := DspSearch.Data;

 finally
  self.CommitTransaction(SQLCon, TD);
 end;
end;

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

procedure TDMServerDataAcess.ConvertToClientDataset(Source: TCustomSQLDataset;
  Destination: TClientDataset);
const
Options : TGetRecordOptions = [grMetaData,grReset];
var
 AProvider: TDatasetProvider;
begin
 //"Converte" um objeto do tipo TCustoSQLDataset para um clientdataset.
 AProvider := TDatasetProvider.Create(nil);
 AProvider.Name := 'PrvConverter'; //do not localize!

 try
  AProvider.DataSet := Source;
  AProvider.Options := AProvider.Options + [poIncFieldProps];
  Destination.SetProvider(AProvider);
  Destination.Open;

 finally
  if Assigned(AProvider) then FreeAndNil(AProvider);
 end;
end;

function TDMServerDataAcess.CreateCommand: TDBXCommand;
begin
 Result :=  ConnectionPool.GetConnection.DBXConnection.CreateCommand;
end;

function TDMServerDataAcess.CreateDataset: TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := ConnectionPool.GetConnection;
end;

function TDMServerDataAcess.CreateReader(Dataset: TDataset): TDBXDataSetReader;
begin
 Result := TDBXDataSetReader.Create(Dataset);
end;

function TDMServerDataAcess.CreateStoreProcedure: TSQLStoredProc;
begin
  Result := TSQLStoredProc.Create(nil);
  Result.SQLConnection := ConnectionPool.GetConnection;
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
 AConnection: TSQLConnection;
 TD: TDBXTransaction;
begin
 //Executa um comando e retorna o número de linhas afetadas.
 AConnection := ConnectionPool.GetConnection;

 try
  TD := AConnection.BeginTransaction();
  Result := AConnection.ExecuteDirect(Command);

  if AConnection.InTransaction then
   AConnection.CommitFreeAndNil(TD);

  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [Command]), '', leOnInformation);

 except
   on E: Exception do
    begin
     Result := -1;
     if AConnection.InTransaction then AConnection.RollbackFreeAndNil(TD);
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
I: integer;
ACommand: string;
AConnection: TSQLConnection;
ATransaction: TDBXTransaction;
begin
{Executa um script com diversos comandos sql de forma atômica. Caso ocorra
alguma falha, toda a operação será desfeita.}
 Result := False;
 if not Assigned(AScript) then
  Exit;

 AConnection := ConnectionPool.GetConnection;
 ATransaction := AConnection.BeginTransaction;

 DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.ExecuteScriptBegin, [AScript.Text]), '', leOnInformation);

  for I := 0 to Pred(AScript.Count) do
    begin
     ACommand := AScript.Strings[I];

     try
      AConnection.ExecuteDirect(ACommand);

     except
      on E: Exception do
       begin
        {A checagem abaixo evita que outros erros não tenham permitido o início da
        transação. p. exe: queda ou travamento do servidor sql}
        AConnection.RollbackFreeAndNil(ATransaction);
        DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [AScript.Text]), leOnError);
        raise;
      end;
     end;
    end;

  AConnection.CommitFreeAndNil(ATransaction);
  Result := True;
  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.ExecuteScriptEnd, [AScript.Text]), '', leOnInformation);
end;

function TDMServerDataAcess.DoGetSequenceValue(
  const SequenceName: WideString): integer;
var
 ADataset: TSQLDataset;
begin
 //Obtém o valor atual de uma sequence a partir do nome da sequence e da faixa
 //de chaves primárias.
 ADataset := self.CreateDataset;

 try
  ADataset.CommandText := Format(TDQLCommand.Generators, [SequenceName, 1]);
  ADataset.Open;
  Result := ADataset.Fields.Fields[0].Value + ActiveRange;

  if Assigned(ADataset) then
   FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SequenceName, [SequenceName]), leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
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

function TDMServerDataAcess.GetUserStatus(
  const UserName: string): TUserStatus;
var
 UserManager: TCosmosUsersManager;
begin
//Verifica o status do usuário...
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.GetUserStatus(UserName);

  if Assigned(UserManager) then
   FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
    Result := usUnknown;
    if Assigned(UserManager) then
     FreeAndNil(UserManager);

    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
 end;
end;

function TDMServerDataAcess.IsAdministrator(
  const UserName: WideString): Boolean;
begin
//Checa se um usuário é um administrador do sistema.
 try
  CloseDataset(SQLSearch);
  SQLSearch.CommandText := Format(TSecurityCommand.AdmUSer,[QuotedStr(UserName)]);
  SQlSearch.Open;
  Result := SQLSearch.Fields.Fields[0].AsString = 'S';

 finally
  CloseDataset(SQLSearch);
 end;
end;

function TDMServerDataAcess.NewSQLMonitorFile: string;
var
GUID: TGUID;
begin
//Gera um novo arquivo para ser usado pelo sqlmonitor
 Result := '';

 if not DirectoryExists(self.FCosmosMonitorFolder) then
  CreateDir(self.FCosmosMonitorFolder);

 CreateGUID(GUID);

 Result := Format('%s\%s_%s.%s', [FCosmosMonitorFolder,
    DMCosmosServerServices.CosmosModuleShortName.ToLower, GUIDToString(GUID), 'txt']);
end;

procedure TDMServerDataAcess.OnDatabaseError(DBXError: TDBXError);
var
 Info: string;
 AContextInfo: TStringList;
begin
 {Registra informações de logs de erros de disparados pelo RDBMS. Os eventos
  OnErrorEvent de todos os objetos TSQLConnection do pool de conexões apontam
  para este método, que só registra eventos do tipo leOnError.}
 if leOnError in DMCosmosServerServices.LogEvents then
  begin
   AContextInfo := DMCosmosServerServices.CreateContextInfoObject;

   try
    Info := DBXError.Message;
    AContextInfo.Append(Format(TCosmosLogs.ErrorCode, [DBXError.ErrorCode]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoSession, [TDSSessionManager.GetThreadSession.Id]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoUser, [TDSSessionManager.GetThreadSession.GetData('UserName')]));
    AContextInfo.Append(Format(TCosmosLogs.ContextInfoRoles, [TDSSessionManager.GetThreadSession.GetData('UserRoles')]));

    DMCosmosServerServices.RegisterLog(Info, AContextInfo.DelimitedText, leOnError);

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

  if E.Message.IndexOf('foreigne key') >= 0 then
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
  ADBXConFile: string;
  AFile: TIniFilePersistence;
  PoolSize: Integer;
begin
 //Carrega as configurações de conexão com banco de dados e monta o pool de conexões.
  DMCosmosServerServices.RegisterLog('Lendo opções de configuração do pool de conexões...', 'TDMServerDataAcess.LoadDatabaseOptions', leOnInformation);

  ADBXConFile := CosmosFolder + TCosmosFiles.dbxconnections; //do not localize!
  AFile := TIniFilePersistence.Create(CosmosRootFile, True);

  try
    PoolSize := AFile.ReadInteger(DMCosmosServerServices.CosmosModuleShortName.ToUpper, 'DatabasePoolSize', 5);
    FConnectionPool := TConnectionsPool.Create(ADBXConFile);
    FConnectionPool.OnErrorEvent := OnDatabaseError;
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

procedure TDMServerDataAcess.SetConnectionParams;
begin
 //Obtém as informações de configuração em memória sobre conexão do banco de dados.
 try
  if FConnectionPath = '' then
   EDatabaseConnectError.Create(TCosmosErrorMsg.DatabaseNotFound);

  SQLCon.ConnectionName := 'COSMOS';  //do not localize!
  SQLCon.LoadParamsFromIniFile(self.FCosmosFolder + TCosmosFiles.dbxconnections);  //do not localize!

 except
  raise;
 end;
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

procedure TDMServerDataAcess.SetUserInfo(UserName, Password,
  RoleName: WideString; var UserData: TCosmosData);
var
 UserManager: TCosmosUsersManager;
 AList: TStringList;
 ADataset: TSQLDataset;
begin
 AList := TStringList.Create;
 UserManager := TCosmosUsersManager.Create;

 try
  ADataset := DoExecuteDQL(Format(TSecurityCommand.UsuarioInfo, [QuotedStr(UserName)]));

  //Testa se o login do usuário existe...
  if ADataset.IsEmpty then //Não encontrou um usuário com o login indicado...
    raise EUnknownUser.Create(TCosmosErrorSecurityMsg.UnknownUser);

  //Testa se a senha do usuário está correta. O teste é feito com a senha criptografada.
  if Password <> SQLSearch.Fields.FieldByName('paswrd').AsString then //Senha do usuário é inválida...
    raise EValidateUser.Create(TCosmosErrorMsg.PasswordNotConfirmed);

  if Assigned(UserData) then
   begin
    with SQLSearch.Fields do
     begin
      UserData.WriteValue('LOGIN', FieldByName('logusu').AsString);
      UserData.WriteValue('USER_NAME', FieldByName('nomcad').AsString, 1);
      UserData.WriteValue('FOCO', FieldByName('sigfoc').AsString, 2);
      UserData.WriteValue('MATRICULA', FieldByName('matcad').AsString, 3);
      UserData.WriteValue('DISCIPULADO', FieldByName('sigdis').AsString, 4);

      //Usuário está ativo?
      if FieldByName('indati').Value = 'S' then
       UserData.WriteValue('ATIVO', True, 5)
      else
       UserData.WriteValue('ATIVO', False, 5);

      //Usuário é administrador?
      if FieldByName('indadm').Value = 'S' then
       UserData.WriteValue('ADM', True, 6)
      else
       UserData.WriteValue('ADM', False, 6);
     end;

    //Testa se a role do usuário está correta.
    UserManager.GetUserRoles(UserName, AList);

    if AList.IndexOf(RoleName) < 0 then
     raise EIncorrectRoleAcess.Create(TCosmosErrorMsg.IncorrectRoleName);

    if Assigned(UserManager) then
     FreeAndNil(UserManager);

    if Assigned(AList) then
     FreeAndNil(AList);

    //Agora, checa quais campos de trabalho poderão ser acessados pelo usuário.
    CloseDataset(ADataset);
    ADataset := DoExecuteDQL(Format(TSecurityCommand.PerfilUsuario, [QuotedStr(UpperCase(RoleName))]));
    with ADataset.Fields do
     begin
      UserData.WriteValue('INDLEC', FieldByName('INDLEC').AsString, 7);
      UserData.WriteValue('INDTMO', FieldByName('INDTMO').AsString, 8);
      UserData.WriteValue('INDTMB', FieldByName('INDTMB').AsString, 9);
      UserData.WriteValue('INDTPU', FieldByName('INDTPU').AsString, 10);
      UserData.WriteValue('INDEIN', FieldByName('INDEIN').AsString, 11);
      UserData.WriteValue('ABRANGENCIA', FieldByName('ABRPER').AsString, 12);
     end;
   end;

  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(UserManager) then FreeAndNil(UserManager);
  if Assigned(AList) then FreeAndNil(AList);

 except
  CloseDataset(ADataset);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(UserManager) then FreeAndNil(UserManager);
  if Assigned(AList) then FreeAndNil(AList);

  raise;
 end;
end;

procedure TDMServerDataAcess.SQLCommandBeforeOpen(DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := ConnectionPool.GetConnection;
end;

end.

