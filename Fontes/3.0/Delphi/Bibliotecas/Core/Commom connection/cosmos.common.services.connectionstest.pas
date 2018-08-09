unit cosmos.common.services.connectionstest;

interface

uses
 System.Classes, System.Threading, System.SysUtils, Data.SQLExpr,
 Data.DBXCommon;

 type
  TConnectionTest = class
    private
     FExecuteSucessfully: boolean;
     FOnline: IFuture<boolean>;

    public
     constructor Create;
     destructor Destroy;

     procedure TestConnection(Connection: TSQLConnection);
     procedure ServerIsOnline(ConnectionParams: TStrings);

     property ExecuteSucessfully: boolean read FExecuteSucessfully default False;
     property OnLine: IFuture<boolean> read FOnline;

  end;


implementation

{ TConnectionTest }

constructor TConnectionTest.Create;
begin
 inherited Create;
end;

destructor TConnectionTest.Destroy;
begin
 inherited Destroy;
end;

procedure TConnectionTest.ServerIsOnline(ConnectionParams: TStrings);
begin
 FExecuteSucessfully := False;

 FOnline := TTask.Future<boolean>(function: boolean
   var
    aConnection: TSQLConnection;

   begin
    aConnection := TSQLConnection.Create(nil);

    try
     aConnection.DriverName := 'DataSnap';
     aConnection.Params.Clear;
     aConnection.Params.AddStrings(ConnectionParams);
     aConnection.LoginPrompt := False;
     aConnection.Open;
     Result := aConnection.Connected;

    finally
     if Assigned(aConnection) then
      begin
       if aConnection.Connected then aConnection.Close;
       aConnection.Free;
      end;
    end;
   end);
end;

procedure TConnectionTest.TestConnection(Connection: TSQLConnection);
 var
  Task: ITask;
begin
 Task := TTask.Create(procedure
   begin
    try
     if Connection.Connected then
      Connection.Close;
     Connection.Open;

    except
     on E: Exception do
      begin
       raise;
      end;
    end;
   end);

 Task.Start;

end;

end.
