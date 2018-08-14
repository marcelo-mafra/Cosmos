unit cosmos.classes.dbxObjects;

interface

uses
 System.Classes, System.SysUtils, Data.DBXCommon, Data.SQLExpr, Datasnap.Provider,
 Data.DBXDBReaders, Data.DB, Datasnap.DBClient, System.Generics.Collections,
 cosmos.system.files, cosmos.classes.cosmoscript, cosmos.classes.dbxUtils;
 {, cosmos.servers.sqlcommands,
 cosmos.classes.ServerInterface, cosmos.system.exceptions,
 cosmos.classes.application, Datasnap.Provider,
 cosmos.system.messages, , ,
 ;}

type
//Implementa um simples pool de conexões com o banco de dados.
 TConnectionsPool = class
   private
   FConnectionParamsFile: string;
   FConnectionsPool:  TDictionary<Int64, TSQLConnection>;
   FOnErrorEvent: TDBXErrorEvent;
   function GetConnectionsCount: integer;

  public
   constructor Create(const ConnectionParamsFile: string);
   destructor Destroy;
   procedure ClearAll;

   function GetConnection: TSQLConnection; overload;
   procedure FillPool(const ObjCount: integer);
   procedure RemoveConnection(const SessionId: Int64);

   property ConnectionsCount: integer read GetConnectionsCount;
   property OnErrorEvent: TDBXErrorEvent read FOnErrorEvent write FOnErrorEvent;
 end;

 //Classe base que implementa recursos básicos, como criação de conexões e datasets.
 TdbxObject = class (TInterfacedPersistent)

  private
   sSystemUser: string;
   procedure LoadConnectionParams(SQLCon: TSQLConnection);
   function CreateDataset(Connection: TSQLConnection): TSQLDataset;

  public
   constructor Create;
   destructor Destroy; override;

   function CreateConnection: TSQLConnection;
 end;

 //Abstrai um objeto controlador do transações no servidor SQL.
 TdbxTransactionsManager = class(TdbxObject)
  private
   procedure StartSQLServer;

  public
   constructor Create;
   destructor Destroy; override;

   function BeginTransaction(Connection: TSQLConnection): TDBXTransaction; overload;
   function BeginTransaction(Connection: TSQLConnection; const Isolation: integer): TDBXTransaction; overload;
   procedure CommitTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
   procedure RollbackTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
   procedure PrepareTransaction(var TD: TTransactionDesc);

 end;

 //Abstrai operações de execução de comandos no servidor SQL.
 TdbxCommand = class(TdbxObject)
 private
   procedure CloseDataset(Dataset: TDataset); inline;

  public
   constructor Create;
   destructor Destroy; override;

   function ExecuteCommand(const Command: WideString): integer;
   function ExecuteScript(Connection: TSQLConnection; Script: TStringList): boolean; overload;
   function ExecuteScript(Script: TStringList): boolean; overload;
   procedure ExecuteDQL(const DQL: WideString; Dataset: TSQLDataset); overload;
   procedure ExecuteDQL(const DQL: WideString; Dataset: TClientDataset); overload;

 end;



implementation

{ TdbxTransactionsManager }

constructor TdbxTransactionsManager.Create;
begin
 inherited Create;
end;

destructor TdbxTransactionsManager.Destroy;
begin
  inherited;
end;

procedure TdbxTransactionsManager.PrepareTransaction(var TD: TTransactionDesc);
begin
//Prepara nova transação
 Randomize;
 TD.TransactionID := Random(32767); //Gera o ID aleatório (smallint) da transação.
 TD.IsolationLevel := xilREADCOMMITTED;
end;

function TdbxTransactionsManager.BeginTransaction(Connection: TSQLConnection): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction
 else
  Result := nil;
end;

function TdbxTransactionsManager.BeginTransaction(Connection: TSQLConnection;
  const Isolation: integer): TDBXTransaction;
begin
 if (Connection <> nil) and (Connection.Connected) then
  Result := Connection.BeginTransaction(Isolation)
 else
  Result := nil;
end;

procedure TdbxTransactionsManager.CommitTransaction(Connection: TSQLConnection; var Transaction: TDBXTransaction);
begin
//Confirma uma transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
  Connection.CommitFreeAndNil(Transaction);
end;

procedure TdbxTransactionsManager.RollbackTransaction(Connection: TSQLConnection;
  var Transaction: TDBXTransaction);
begin
//Desfaz a transação passada em parâmetro.
 if (Connection <> nil) and (Connection.Connected) and (Connection.InTransaction) then
   Connection.RollbackFreeAndNil(Transaction);
end;

procedure TdbxTransactionsManager.StartSQLServer;
begin
//To do.
end;

{ TdbxCommand }

constructor TdbxCommand.Create;
begin
 inherited Create;
end;

destructor TdbxCommand.Destroy;
begin
  inherited Destroy;
end;

function TdbxCommand.ExecuteCommand(const Command: WideString): integer;
var
 AConnection: TSQLConnection;
 AServer: TdbxTransactionsManager;
 TD: TDBXTransaction;
begin
//Executa um comando no banco de dados.
 AConnection := self.CreateConnection;
 AServer := TdbxTransactionsManager.Create;

 try
  TD := AServer.BeginTransaction(AConnection);
  Result := AConnection.ExecuteDirect(Command);

  if AConnection.InTransaction then
   AServer.CommitTransaction(AConnection, TD);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

  if Assigned(AServer) then
   FreeAndNil(AServer);

  {Isto é necessário porque o retorno do método ExecuteDirect, chamado acima,
   sempre está retornado 0. É uma falha do DBExpress.}
  if Result = 0 then
   Result := 1;

 except
  if AConnection.InTransaction then
   AServer.RollbackTransaction(AConnection, TD);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

  if Assigned(AServer) then
   FreeAndNil(AServer);

  raise;
 end;
end;

procedure TdbxCommand.ExecuteDQL(const DQL: WideString;
  Dataset: TClientDataset);
var
AConnection: TSQLConnection;
ADataset: TSQLDataset;
AProvider: TDatasetProvider;
begin
{Este método não pode ser executado usando-se a classe TDBXDatasetReader porque,
no RAD Studio 2010, o método CopyReaderToClientDataSet trunca as strings. Então,
usamos um DatasetProvider.}

 AConnection := self.CreateConnection;
 ADataset := TSQLDataset.Create(nil);
 AProvider := TDatasetProvider.Create(nil);

 try
  ADataset.SQLConnection := AConnection;
  ADataset.CommandText := DQL;
  AProvider.DataSet := ADataset;
  Dataset.Data := AProvider.Data;

 finally
  if Assigned(AConnection) then FreeAndNil(AConnection);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AProvider) then FreeAndNil(AProvider);
 end;
end;

function TdbxCommand.ExecuteScript(Script: TStringList): boolean;
var
TD: TDBXTransaction;  //Objeto que implementa transações no DBExpress
AServer: TdbxTransactionsManager;
AConnection: TSQLConnection;
ACommand: string;
I: integer;
begin
{Executa um script com diversos comandos sql de forma atômica. Caso ocorra
alguma falha, toda operação será desfeita.}
 AServer := TdbxTransactionsManager.Create;
 AConnection := self.CreateConnection;

 try
 //Inicia uma nova transação
  TD := AServer.BeginTransaction(AConnection);

  for I := 0 to Pred(Script.Count) do
    begin
     ACommand := Script.Strings[I];
     AConnection.ExecuteDirect(ACommand);
    end;

  if AConnection.InTransaction then
   AServer.CommitTransaction(AConnection, TD);

  Result := True;

  if Assigned(AServer) then
   FreeAndNil(AServer);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

 except
  on E: Exception do //Deu pau...
   begin
   {A checagem abaixo evita que outros erros não tenham permitido o início da
    transação. p. exe: queda ou travamento do servidor sql}
    if Assigned(AConnection) then
     begin
      if AConnection.InTransaction then
       AServer.RollbackTransaction(AConnection, TD);
     end;

    if Assigned(AServer) then FreeAndNil(AServer);
    if Assigned(AConnection) then FreeAndNil(AConnection);

    raise;
   end;
 end;
end;

procedure TdbxCommand.CloseDataset(Dataset: TDataset);
begin
 if Dataset.Active then
  Dataset.Close;
end;

procedure TdbxCommand.ExecuteDQL(const DQL: WideString; Dataset: TSQLDataset);
begin
//Executa um comando DQL no banco de dados e retorna um cursosr unidirecional.
 try
  CloseDataset(Dataset);
  Dataset.CommandText := DQL;
  Dataset.Open;

 except
  raise;
 end;
end;

function TdbxCommand.ExecuteScript(Connection: TSQLConnection;
  Script: TStringList): boolean;
var
TD: TDBXTransaction;  //Objeto que implementa transações no DBExpress
AServer: TdbxTransactionsManager;
ACommand: string;
I: integer;
begin
{Executa um script com diversos comandos sql de forma atômica. Caso ocorra
alguma falha, toda operação será desfeita.}
 AServer := TdbxTransactionsManager.Create;

 try
 //Inicia uma nova transação
  TD := AServer.BeginTransaction(Connection);

  for I := 0 to Pred(Script.Count) do
    begin
     ACommand := Script.Strings[I];
     Connection.ExecuteDirect(ACommand);
    end;

  AServer.CommitTransaction(Connection, TD);
  Result := True;

  if Assigned(AServer) then
   FreeAndNil(AServer);


 except
  on E: Exception do //Deu pau...
   begin
   {A checagem abaixo evita que outros erros não tenham permitido o início da
    transação. p. exe: queda ou travamento do servidor sql}
    AServer.RollbackTransaction(Connection, TD);

    if Assigned(AServer) then
     FreeAndNil(AServer);

    raise;
   end;
 end;
end;

{ TSQLServerObject }

constructor TdbxObject.Create;
begin
 inherited Create;
end;

function TdbxObject.CreateConnection: TSQLConnection;
begin
 Result := TSQLConnection.Create(nil);
 self.LoadConnectionParams(Result);
end;

function TdbxObject.CreateDataset(Connection: TSQLConnection): TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := Connection;
end;

destructor TdbxObject.Destroy;
begin
  inherited;
end;

procedure TdbxObject.LoadConnectionParams(SQLCon: TSQLConnection);
begin
  //Carrega os dados de conexão na memória para um objeto de conexão.
   SQLCon.ConnectionName := 'COSMOS'; //do not localize!
   SQLCon.LoadParamsFromIniFile(TCosmosInfoFiles.DBInfoFile);
   SQLCon.LoginPrompt := False;

   SQLCon.DriverName := 'FIREBIRD'; //do not localize!
   SQLCon.GetDriverFunc :=  'getSQLDriverINTERBASE'; //do not localize!
   SQLCon.LibraryName := 'dbxfb.dll'; //do not localize!
   SQLCon.VendorLib := 'fbclient.dll'; //do not localize!
   sSystemUser := SQLCon.Params.Values['user_name'];
end;

{ TConnectionsPool }

procedure TConnectionsPool.ClearAll;
var
 AKey: Int64;
 AConn: TSQLConnection;
begin
 {Limpa o pool de conexão e destrói todos os objetos nele existentes.}
  for AKey in FConnectionsPool.Keys do
   begin
    AConn := FConnectionsPool[Akey];

    if AConn <> nil then
     begin
      AConn.DBXConnection.OnErrorEvent := nil;
      AConn.Free;
     end;
   end;

 FConnectionsPool.Clear;
end;

constructor TConnectionsPool.Create(const ConnectionParamsFile: string);
begin
 FConnectionsPool := TDictionary<Int64, TSQLConnection>.Create;
 FConnectionParamsFile := ConnectionParamsFile;
end;

destructor TConnectionsPool.Destroy;
begin
  FConnectionsPool.Values.Free;
  FConnectionsPool.Keys.Free;
  FConnectionsPool.Free;

  inherited Destroy;
end;

procedure TConnectionsPool.FillPool(const ObjCount: integer);
var
 I: integer;
 AIndex: Int64;
 dbconn : TSQLConnection;
 sValue: string;
 aParams: TStringList;
begin
 {Cria objetos TSQLConnection no pool para uso das aplicações. O número de objetos
  TSQLConnection que serão criados é definido pelo parâmetro ObjCount.}
 I := ObjCount;
 Randomize;
 aParams := TStringList.Create;

 aParams.LoadFromFile(FConnectionParamsFile);

 try

 while I > 0 do
  begin
    dbconn := TSQLConnection.Create(nil);
    dbconn.LoginPrompt := False;

    dbconn.ConnectionName := 'COSMOS';
    dbconn.Params.Clear;
    dbconn.LoadParamsOnConnect := False;
    dbconn.DriverName := 'FIREBIRD'; //do not localize!

    dbconn.LibraryName := aParams.Values['LibraryName']; //do not localize!
    dbconn.VendorLib := aParams.Values['VendorLib']; //do not localize!
    dbconn.Params.Values['vendorlibwin64'] := aParams.Values['vendorlibwin64']; //do not localize!

    //Descriptografa informações sobre a conexão com o banco de dados.

    //Path do banco de dados.
    sValue := aParams.Values['Database']; //do not localize!
    sValue := TCripterFactory.Descriptografar(sValue);
    dbconn.Params.Values['Database'] := sValue; //do not localize!

    //Usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['user_name'];//do not localize!
    sValue := TCripterFactory.Descriptografar(sValue);
    dbconn.Params.Values['user_name'] := sValue; //do not localize!

    //Senha do usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['Password']; //do not localize!
    sValue := TCripterFactory.Descriptografar(sValue);
    dbconn.Params.Values['Password'] := sValue; //do not localize!

    //Role do usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['rolename']; //do not localize!
    sValue := TCripterFactory.Descriptografar(sValue);
    dbconn.Params.Values['rolename'] := sValue; //do not localize!

    //Role do usuário interno da conexão com o banco de dados.
    sValue := aParams.Values['role']; //do not localize!
    sValue := TCripterFactory.Descriptografar(sValue);
    dbconn.Params.Values['role'] := sValue; //do not localize!

    //Host do servidor do banco de dados.
    sValue := aParams.Values['HostName']; //do not localize!
    sValue := TCripterFactory.Descriptografar(sValue);
    dbconn.Params.Values['HostName'] := sValue; //do not localize!

    //Server charset
    dbconn.Params.Values['servercharset'] := aParams.Values['servercharset']; //do not localize!
    //SQL Dialect
    dbconn.Params.Values['sqldialect'] := aParams.Values['sqldialect']; //do not localize!

   //Inicia a inserção da conexão configurada ao pool de conexões.
    AIndex := Random(30);

    while FConnectionsPool.ContainsKey(AIndex) do
     begin
      AIndex := Random(30);
     end;

    //Agora, abre a conexão e a adiciona ao pool.
    dbconn.Open;
    dbconn.DBXConnection.OnErrorEvent := self.OnErrorEvent;
    FConnectionsPool.Add(AIndex, dbconn);
    Dec(I);
  end;

  aParams.Free;

 except
  on E: Exception do
   begin
    raise;
   end;
 end;
end;

function TConnectionsPool.GetConnection: TSQLConnection;
var
 AKey: Int64;
begin
 //Retorna uma conexão existente no pool de conexões.
 Randomize;
 Result := nil;

 Akey := Random(30);

 while Result = nil do
  begin
   if FConnectionsPool.ContainsKey(AKey) then
    Result := FConnectionsPool[AKey];
   Akey := Random(30);
  end;
end;

function TConnectionsPool.GetConnectionsCount: integer;
begin
 Result := FConnectionsPool.Count;
end;

procedure TConnectionsPool.RemoveConnection(const SessionId: Int64);
var
 DbCon: TSQLConnection;
begin
 if FConnectionsPool.ContainsKey(SessionId) then
  begin
   DbCon := FConnectionsPool[SessionId];
   DbCon.Close;
   DbCon.Free;
   FConnectionsPool.Remove(SessionId);
  end;
end;

end.

