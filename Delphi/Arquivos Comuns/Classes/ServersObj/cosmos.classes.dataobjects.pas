unit cosmos.classes.dataobjects;

interface

uses
 System.Classes, System.SysUtils, Data.DBXCommon, Data.SQLExpr,
 Data.DBXDBReaders, Data.DB, Datasnap.DBClient, cosmos.servers.sqlcommands,
 cosmos.classes.ServerInterface, cosmos.system.exceptions, cosmos.classes.dbxObjects,
 cosmos.classes.application, Datasnap.Provider, cosmos.system.files,
 cosmos.system.messages, cosmos.classes.serversutils, cosmos.classes.cosmoscript,
 System.Generics.Collections;

type

 //Classe base que implementa recursos básicos, como criação de conexões e datasets.
 TSQLServerObject = class (TInterfacedPersistent)

  private
   sSystemUser: string;
   procedure LoadConnectionParams(SQLCon: TSQLConnection);

  public
   constructor Create;
   destructor Destroy; override;

   function CreateConnection: TSQLConnection;
   function CreateDataset(Connection: TSQLConnection): TSQLDataset;
 end;

 //Abstrai operações de execução de comandos no servidor SQL.
 TSQLServerCommand = class(TSQLServerObject)
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

{ TSQLServerCommand }

constructor TSQLServerCommand.Create;
begin
 inherited Create;
end;

destructor TSQLServerCommand.Destroy;
begin
  inherited Destroy;
end;

function TSQLServerCommand.ExecuteCommand(const Command: WideString): integer;
var
 AConnection: TSQLConnection;
 ATransaction: TdbxTransactionsManager;
 TD: TDBXTransaction;
begin
//Executa um comando no banco de dados.
 AConnection := self.CreateConnection;
 ATransaction := TdbxTransactionsManager.Create;

 try
  TD := ATransaction.BeginTransaction(AConnection);
  Result := AConnection.ExecuteDirect(Command);

  if AConnection.InTransaction then
   ATransaction.CommitTransaction(AConnection, TD);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

  if Assigned(ATransaction) then
   FreeAndNil(ATransaction);

  {Isto é necessário porque o retorno do método ExecuteDirect, chamado acima,
   sempre está retornado 0. É uma falha do DBExpress.}
  if Result = 0 then
   Result := 1;

 except
  if AConnection.InTransaction then
   ATransaction.RollbackTransaction(AConnection, TD);

  if Assigned(AConnection) then
   FreeAndNil(AConnection);

  if Assigned(ATransaction) then
   FreeAndNil(ATransaction);

  raise;
 end;
end;

procedure TSQLServerCommand.ExecuteDQL(const DQL: WideString;
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

function TSQLServerCommand.ExecuteScript(Script: TStringList): boolean;
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

procedure TSQLServerCommand.CloseDataset(Dataset: TDataset);
begin
 if Dataset.Active then
  Dataset.Close;
end;

procedure TSQLServerCommand.ExecuteDQL(const DQL: WideString; Dataset: TSQLDataset);
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

function TSQLServerCommand.ExecuteScript(Connection: TSQLConnection;
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

constructor TSQLServerObject.Create;
begin
 inherited Create;
end;

function TSQLServerObject.CreateConnection: TSQLConnection;
begin
 Result := TSQLConnection.Create(nil);
 self.LoadConnectionParams(Result);
end;

function TSQLServerObject.CreateDataset(
  Connection: TSQLConnection): TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := Connection;
end;

destructor TSQLServerObject.Destroy;
begin
  inherited;
end;

procedure TSQLServerObject.LoadConnectionParams(SQLCon: TSQLConnection);
var
 AFileName: string;
begin
  //Carrega os dados de conexão na memória para um objeto de conexão.
   AFileName := TCosmosInfoFiles.GetDatabaseConfigurationFile;
   SQLCon.ConnectionName := 'COSMOS'; //do not localize!
   SQLCon.LoadParamsFromIniFile(AFileName);
   SQLCon.LoginPrompt := False;

   SQLCon.DriverName := 'FIREBIRD'; //do not localize!
   SQLCon.GetDriverFunc :=  'getSQLDriverINTERBASE'; //do not localize!
   SQLCon.LibraryName := 'dbxfb.dll'; //do not localize!
   SQLCon.VendorLib := 'fbclient.dll'; //do not localize!
   sSystemUser := SQLCon.Params.Values['user_name'];
end;



end.

