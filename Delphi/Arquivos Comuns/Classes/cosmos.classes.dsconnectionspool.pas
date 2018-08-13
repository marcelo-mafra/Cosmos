unit cosmos.classes.dsconnectionspool;

interface

uses
  Winapi.Windows, System.Classes, System.SysUtils, System.DateUtils, System.SyncObjs,
  System.Math, Data.DB, Data.SqlExpr, Data.DBXCommon, cosmos.classes.logs;

const
 sOnConnectError = 'Ocorreu uma falha ao tentar conectar com o host remoto.';
 sOnDisconnectError = 'Ocorreu uma falha ao tentar desconectar de um host remoto.';

type
  TConnectionTest = (ctNotTested, ctSuccesfulTested, ctTimeoutError, ctError);

  EConnPoolException = class(Exception);

  IServerConnection = Interface(IInterface)

    function Connection: TSQLConnection;
    function CreateCommand: TDBXCommand;
    function GetRefCount: Integer;
    function GetLastAccess: TDateTime;
    function GetConnectionTest: TConnectionTest;
    procedure SetConnectionTest(Value: TConnectionTest);

    property ConnectionTest: TConnectionTest read  GetConnectionTest write SetConnectionTest;
    property LastAccess: TDateTime read GetLastAccess;
    property RefCount: Integer read GetRefCount;

  end;


  //This object provides the implementation
  //of the IConnection interface. To use a data access
  //mechanism other than dbExpress, modify the components
  //that appear on this data module, and change the class
  //of the Connection function in the IConnection interface
  //as well as in this class.


  TConnectionPoolItem = class(TInterfacedObject, IServerConnection)
  private
    FConnectionTest: TConnectionTest;
    SQLConnection: TSQLConnection;

  protected
    FRefCount: Integer;
    FLastAccess: TDateTime;
    //When the data module is created the
    //connection pool that creates the data module
    //will assign its critical section to this field.
    //The data module will use this critical section
    //to synchronize access to its reference count.
    CriticalSection: TCriticalSection;
    //This semaphore points to the FixedConnectionPool's
    //semaphore. It will be used to call ReleaseSemaphore
    //from the _Release method of the TDataModule.
    Semaphore: THandle;
    //These two static methods are reintroduced
    //in order to implement lifecycle management
    //for the interface of this object.
    //Normally, unlike normal COM objects, Delphi
    //TComponent descendants are not lifecycle managed
    //when used in interface references.
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {IConnection methods}
    function GetLastAccess: TDateTime;
    function GetRefCount: Integer;
    function GetConnectionTest: TConnectionTest;
    procedure SetConnectionTest(Value: TConnectionTest);

  public
    { Public declarations }
    {IConnection method}
    //CHANGE
    //To use a connection of another type, change the
    //return type of the Connection function
    constructor Create(Params: TStrings);
    destructor Destroy; override;

    function Connection: TSQLConnection;
    function CreateCommand: TDBXCommand;

    property ConnectionTest: TConnectionTest read  GetConnectionTest write SetConnectionTest;
  end;

  TCleanupThread = class;

  TPoolNotifyEvent = procedure(Sender: TSQLConnection);
    //Evento disparado quando uma conexão for adicionada ao pool.
  TAddedConnection = TPoolNotifyEvent;
  //Evento disparado quando uma conexão for retirada do pool.
  TDropConnection = TPoolNotifyEvent;
  //Evento disparado para notificação de ocorrência e registro de logs. O registro
  //em si é feito por classe que utiliza o pool de conexões.
  TOnRegisterEvent = procedure (const Info, ContextInfo: string; Event: TLogEvent) of Object;
  //Evento disparado quando o teste tipo "ping" de uma conexão retornar sucesso.
  TOnSuccessfulTestConnection = TPoolNotifyEvent;
  //Evento disparado quando o teste tipo "ping" de uma conexão falhar.
  TOnFailedTestConnection = TPoolNotifyEvent;
//Evento disparado quando o sistema está recuperando uma conexão perdida do pool.
  TRecuperateConnection = TNotifyEvent;

  TPoolGrowth = (pgOnDemand, pgCreateFull, pgStatelessMode);

  //This is the class that manages the connection pool.

  TDBXConnectionPool = class(TObject)
  private
    FCommandText: string;
    FPool: array of IServerConnection;
    FPoolSize: Integer;
    FPoolGrowth: TPoolGrowth;
    FTimeout: LargeInt;
    FParams: TStrings;
    FAddedConnection: TAddedConnection;
    FActive: boolean;
    FAfterConnect: TNotifyEvent;
    FAfterDisconnect: TNotifyEvent;
    FBeforeConnect: TNotifyEvent;
    FBeforeDisconnect: TNotifyEvent;
    FOnErrorEvent: TDBXErrorEvent;
    FOnRegisterEvent: TOnRegisterEvent;
    FValidatePeerCertificate: TValidateCertificate;

    CleanupThread: TCleanupThread;
    //TestThread: TTestConnectionThread;

    //This semaphore is used to limit the number of
    //simultaneous connections. When the nth+1 connection
    //is requested, it will be blocked until a connection
    //becomes available.
    Semaphore: THandle;
    //This is the critical section that synchronizes
    //access to the connection module reference counts
    CriticalSection: TCriticalSection;
    procedure DoConfigureConnection(Connection: TSQLConnection); inline;
    function DoCreateConnection(const ConnectionId: integer): IServerConnection;
    function GetConnectionsCount: integer;
    function GetIsEmpty: boolean;

  public
    //This overloaded constructor takes two optional
    //parameters. These parameters specify the size
    //of the connection pool, as well as how long idle
    //connections in the connection pool will be kept.
    constructor Create(const PoolSize: Integer; const CleanupDelayMinutes: Integer;
      const Timeoutms: LargeInt; Params: TStrings); overload;
    destructor Destroy; override;
    //This function returns an object
    //that implements the IConnection interface.
    //This object can be a data module, as was
    //done in this example.
    procedure CreateConnectionPool;
    procedure DropConnection(const PoolItemId: integer); overload;
    procedure DropConnection(const PoolItemId: integer; FreeItem: boolean); overload;
    procedure DropConnections;
    function GetConnection: IServerConnection;
    property CommandText: string read FCommandText write FCommandText;
    property Params : TStrings read FParams;
    property PoolGrowth: TPoolGrowth read FPoolGrowth write FPoolGrowth default pgCreateFull;
    property PoolSize: integer read FPoolSize;

    property Active: boolean read FActive default False;
    property AddedConnection: TAddedConnection read FAddedConnection write FAddedConnection;
    property AfterConnect: TNotifyEvent read FAfterConnect write FAfterConnect;
    property BeforeConnect: TNotifyEvent read FBeforeConnect write FBeforeConnect;
    property AfterDisconnect: TNotifyEvent read FAfterDisconnect write FAfterDisconnect;
    property BeforeDisconnect: TNotifyEvent read FBeforeDisconnect write FBeforeDisconnect;
    property OnErrorEvent: TDBXErrorEvent read FOnErrorEvent write FOnErrorEvent;
    property OnRegisterEvent: TOnRegisterEvent read FOnRegisterEvent write FOnRegisterEvent;
    property ValidatePeerCertificate: TValidateCertificate  read FValidatePeerCertificate write FValidatePeerCertificate;

    property ConnectionsCount: integer read GetConnectionsCount;
    property IsEmpty: boolean read GetIsEmpty;
  end;

  //This thread class is used by the connection pool
  //object to cleanup idle connections after a
  //configurable period of time.
  TCleanupThread = class(TThread)
  private
    FCleanupDelay: Integer;
    function DoTestConnection(const ConnectionPoolId: integer): boolean;

  protected
    //When the thread is created, this critical section
    //field will be assigned the connection pool's
    //critical section. This critical section is
    //used to synchronize access to data module
    //reference counts.
    CriticalSection: TCriticalSection;
    ConnectionPool: TDBXConnectionPool;
    procedure Execute; override;
    constructor Create(CreateSuspended: Boolean; const CleanupDelayMinutes: Integer);
  end;


implementation

{ TConnectionPoolItem }

function TConnectionPoolItem.Connection: TSQLConnection;
begin
  result := SQLConnection;
end;

constructor TConnectionPoolItem.Create(Params: TStrings);
begin
  inherited Create;
  FConnectionTest := TConnectionTest.ctNotTested;
  SQLConnection := TSQLConnection.Create(nil);
  SQLConnection.DriverName := 'DataSnap'; //do not localize!

  SQLConnection.Params.Clear;
  SQLConnection.Params.AddStrings(Params);
  SQLConnection.LoginPrompt := False;
end;

function TConnectionPoolItem.CreateCommand: TDBXCommand;
begin
 Result := Connection.DBXConnection.CreateCommand;
end;

destructor TConnectionPoolItem.Destroy;
begin
  SQLConnection.Close;
  SQLConnection.Free;
  SQLConnection := nil;
  inherited;
end;

function TConnectionPoolItem.GetConnectionTest: TConnectionTest;
begin
 Result := FConnectionTest;
end;

function TConnectionPoolItem.GetLastAccess: TDateTime;
begin
  Result := FLastAccess;
end;

function TConnectionPoolItem.GetRefCount: Integer;
begin
  result := FRefCount;
end;

function TConnectionPoolItem.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TConnectionPoolItem.SetConnectionTest(Value: TConnectionTest);
begin
 FConnectionTest := Value;
end;

function TConnectionPoolItem._AddRef: Integer;
begin
  //increment the reference count
  CriticalSection.Enter;
  try
    Inc(FRefCount);
    Result := FRefCount;
  finally
    CriticalSection.Leave;
  end;
end;


function TConnectionPoolItem._Release: Integer;
begin
  //decrement the reference count
  CriticalSection.Enter;
  try
    Dec(FRefCount);
    Result := FRefCount;
    //if not more references, call Destroy
    if Result = 0 then
      Destroy
    else
      Self.FLastAccess := Now;
  finally
    CriticalSection.Leave;
    if FRefCount = 1 then
      ReleaseSemaphore(Semaphore, 1, nil);
  end;
end;

{ TDBXConnectionPool }

constructor TDBXConnectionPool.Create(const PoolSize, CleanupDelayMinutes: Integer;
  const Timeoutms: LargeInt;  Params: TStrings);
begin
  inherited Create;
  FParams := TStringList.Create;
  FParams.AddStrings(Params);

  FPoolSize := PoolSize;
  FTimeout := Timeoutms;
  Semaphore := CreateSemaphore(nil, PoolSize, PoolSize, '');
  CriticalSection := TCriticalSection.Create;
  //Set the length of the connection pool
  SetLength(FPool, PoolSize);

  //Create and start the cleanup thread
  CleanupThread := TCleanupThread.Create(True, CleanupDelayMinutes);

  with CleanupThread do
  begin
    FreeOnTerminate := True;
    Priority := tpLower;
    ConnectionPool := Self;
    Start;
  end;
end;

procedure TDBXConnectionPool.CreateConnectionPool;
var
 I: integer;
 IConn: IServerConnection;
begin
{Preenche o pool com as conexões.}
 case PoolGrowth of
  pgOnDemand, pgStatelessMode: IConn := self.GetConnection;
  pgCreateFull:
   begin
    for I := 0 to Pred(self.PoolSize) do
      begin
       if FPool[I] = nil then
        IConn := DoCreateConnection(I);
      end;
   end;
 end;
end;

destructor TDBXConnectionPool.Destroy;
var
  i: Integer;
begin
  //Free any remaining connections
  CleanupThread.Terminate;
  CriticalSection.Enter;

  try
    for i := Low(FPool) to High(FPool) do
      FPool[i] := nil;

    SetLength(FPool,0);

  finally
    CriticalSection.Leave;
    FActive := False;
  end;

  CriticalSection.Free;
  //Release the semaphore
  CloseHandle(Semaphore);
  FParams.Free;
  inherited;
end;

procedure TDBXConnectionPool.DoConfigureConnection(Connection: TSQLConnection);
begin
 Connection.AfterConnect := FAfterConnect;
 Connection.BeforeConnect := FBeforeConnect;
 Connection.AfterDisconnect := FAfterDisconnect;
 Connection.BeforeDisconnect := FBeforeDisconnect;
 Connection.ValidatePeerCertificate := FValidatePeerCertificate;
end;

function TDBXConnectionPool.DoCreateConnection(
  const ConnectionId: integer): IServerConnection;
var
  APoolItem: TConnectionPoolItem;
begin
  Result := nil;
  CriticalSection.Enter;

  try
   case PoolGrowth of
     pgOnDemand, pgCreateFull:
      begin
       if FPool[ConnectionId] = nil then
         begin
           APoolItem := TConnectionPoolItem.Create(self.Params);
           APoolItem.CriticalSection := Self.CriticalSection;
           APoolItem.Semaphore := Self.Semaphore;
           FPool[ConnectionId] := APoolItem;
           if Assigned(FAddedConnection) then FAddedConnection(FPool[ConnectionId].Connection);

           if not FPool[ConnectionId].Connection.Connected then
            begin
             DoConfigureConnection(FPool[ConnectionId].Connection);
             FPool[ConnectionId].Connection.Connected := True;
             FPool[ConnectionId].Connection.DBXConnection.OnErrorEvent := OnErrorEvent;
            end;
         end;
      end;
     pgStatelessMode:
      begin
       DropConnection(0, True);
       if FPool[0] = nil then
        begin
          //Cria uma nova conexão no pool.
           APoolItem := TConnectionPoolItem.Create(self.Params);
           APoolItem.CriticalSection := Self.CriticalSection;
           APoolItem.Semaphore := Self.Semaphore;
           FPool[0] := APoolItem;
           if Assigned(FAddedConnection) then FAddedConnection(FPool[0].Connection);

           if not FPool[0].Connection.Connected then
            begin
             DoConfigureConnection(FPool[0].Connection);
             FPool[0].Connection.Connected := True;
             FPool[0].Connection.DBXConnection.OnErrorEvent := OnErrorEvent;
            end;
        end
       else
        begin
         Result := FPool[0];
         TConnectionPoolItem(FPool[0]).FLastAccess := Now;
         FActive := True;
        end;
       end;
   end;

   if self.PoolGrowth <> pgStatelessMode then
    begin
     Result := FPool[ConnectionId];
     TConnectionPoolItem(FPool[ConnectionId]).FLastAccess := Now;
     FActive := True;
    end;

   CriticalSection.Leave;

  except
   on E: TDBXError do
    begin
      raise;
    end;
   on E: Exception do
    begin
     CriticalSection.Leave;
     if Assigned(FOnRegisterEvent) then FOnRegisterEvent(sOnConnectError + ':' + E.Message,
       FPool[ConnectionId].Connection.Params.Text, leOnConnectError);
     raise EConnPoolException.Create(sOnConnectError);
    end;
  end;
end;

procedure TDBXConnectionPool.DropConnection(const PoolItemId: integer);
begin
 if (FPool[PoolItemId] <> nil) and (FPool[PoolItemId].Connection.DataSetCount = 0) then
  try
   FPool[PoolItemId].Connection.CloseDataSets;
   FPool[PoolItemId].Connection.Close;

  except
   on E: Exception do
    begin
     if Assigned(FOnRegisterEvent) then FOnRegisterEvent(sOnDisconnectError + ':' + E.Message,
       FPool[PoolItemId].Connection.Params.Text, leOnConnectClose);
     raise;
    end;
  end;
end;

procedure TDBXConnectionPool.DropConnection(const PoolItemId: integer;
  FreeItem: boolean);
begin
 if not FreeItem then
  DropConnection(PoolItemId)
 else
  begin
   if (FPool[PoolItemId] <> nil) then
    try
     FPool[PoolItemId].Connection.Close;
     //Delete(FPool, 0, 1);
     //SetLength(FPool, PoolSize);

    except
     on E: Exception do
      begin
       if Assigned(FOnRegisterEvent) then FOnRegisterEvent(sOnDisconnectError + ':' + E.Message,
        FPool[PoolItemId].Connection.Params.Text, leOnConnectClose);
       raise;
      end;
    end;
  end;
end;

procedure TDBXConnectionPool.DropConnections;
var
 I: integer;
begin
 I := Low(FPool);

 while I <= High(FPool) do
  begin
   DropConnection(I);
   Inc(I);
  end;
end;

function TDBXConnectionPool.GetConnection: IServerConnection;
var
  i: Integer;
begin
   Randomize;
   I := RandomRange(1, PoolSize);
   Result := DoCreateConnection(I);
end;

function TDBXConnectionPool.GetConnectionsCount: integer;
begin
 Result := Length(FPool);
end;



function TDBXConnectionPool.GetIsEmpty: boolean;
begin
 Result := self.ConnectionsCount = 0;
end;

{ TCleanupThread }

constructor TCleanupThread.Create(CreateSuspended: Boolean;
  const CleanupDelayMinutes: Integer);
begin
  // always create suspended
  inherited Create(True); // always create suspended
  FCleanupDelay := CleanupDelayMinutes;
  //Start if not created suspended
  if not CreateSuspended then
    Start;
end;

function TCleanupThread.DoTestConnection(const ConnectionPoolId: integer): boolean;
{var
 aCommand: TDBXCommand;}
begin
 Result := True;

    {if ConnectionPool.FPool[0] <> nil then
     begin
       try
        if not ConnectionPool.FPool[ConnectionPoolId].Connection.Connected then
         ConnectionPool.FPool[ConnectionPoolId].Connection.Open;

        ACommand := ConnectionPool.FPool[ConnectionPoolId].CreateCommand;
        ACommand.CommandTimeout := 3000;
        ACommand.Text := ConnectionPool.CommandText;
        ACommand.Prepare;
        ACommand.ExecuteUpdate;

        Result := ACommand.Parameters[0].Value.GetBoolean;

       finally
        if Assigned(ACommand) then FreeAndNil(ACommand);
       end;
     end;}
end;

procedure TCleanupThread.Execute;
var
  i: Integer;
begin
  while True do
  begin
    if Terminated then Exit;
    //sleep for delay
    sleep(FCleanupDelay * 1000 * 60);
    if Terminated then Exit;
    ConnectionPool.CriticalSection.Enter;

    try
      for i := low(ConnectionPool.FPool) to High(ConnectionPool.FPool) do
       begin
         {Faz um teste para verificar a resposta da conexão e a elimina em caso de insucesso.}
         if (ConnectionPool.FPool[i] <> nil) and (ConnectionPool.CommandText <> '') then
          begin
           if not DoTestConnection(I) then
            ConnectionPool.DropConnection(I);
          end
         else
         {Verifica se a conexão está sem uso há mais tempo que o permitido. Se sim, a elimina.}
         if (ConnectionPool.FPool[i] <> nil) and (MinutesBetween(ConnectionPool.FPool[i].LastAccess, Now) > FCleanupDelay) then
          ConnectionPool.DropConnection(I);
       end;

    finally
      ConnectionPool.CriticalSection.Leave;
    end;//try
  end;//while
end;

end.

