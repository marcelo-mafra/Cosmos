unit cosmos.classes.servers.dataobj;

interface

uses
 System.Classes, System.SysUtils, Data.DB, DataSnap.DBClient, cosmos.classes.servers.dbxObjects,
 cosmos.classes.servers.datobjint;

type
 {Encapsula o evento de erros definido em TErrorEvent.}
 TCosmosOnDBErrorEvent = procedure(const ErrorId: integer; ErrorMsg: string) of object;

//Encapsula um simples pool de conexões com o banco de dados.
 TCosmosConnectionsPool = class
   private
   FOnErrorEvent: TCosmosOnDBErrorEvent;
   FConnectionsPool: TConnectionsPool;
   function GetConnectionsPool: TConnectionsPool;
   function GetConnectionsCount: integer;

  public
   constructor Create(const ConnectionParamsFile: string);
   destructor Destroy; override;

   procedure ClearAll;
   procedure FillPool(const ObjCount: integer);
   procedure RemoveConnection(const SessionId: Int64);

   property ConnectionsPool: TConnectionsPool read GetConnectionsPool;
   property ConnectionsCount: integer read GetConnectionsCount;
   property OnErrorEvent: TCosmosOnDBErrorEvent read FOnErrorEvent write FOnErrorEvent;

 end;

 TCosmosDBObject = class(TInterfacedObject)
   private
    FCosmosConnectionsPool: TCosmosConnectionsPool;

   public
    constructor Create;
    destructor Destroy; override;

    property ConnectionsPool: TCosmosConnectionsPool read FCosmosConnectionsPool write FCosmosConnectionsPool;
 end;

 TCosmosCommand = class(TCosmosDBObject, ICosmosCommand)
   private

   public
    constructor Create;
    destructor Destroy; override;

    function ExecuteCommand(const Command: WideString): integer;
    procedure ExecuteDQL(const DQL: WideString; Dataset: TClientDataset);

  end;

  TStoredProcCommand = class(TCosmosDBObject)
   private
    FParams: TParams;
    FProcName: string;

   public
    constructor Create;
    destructor Destroy; override;

    function ExecuteStoredProc: integer;
    procedure AddParam(const ParamName: string; value: variant); overload;
    procedure AddParam(const ParamName: string); overload;

    property Params: TParams read FParams write FParams;
    property ProcName: string read FProcName write FProcName;
  end;


 TCosmosScript = class(TCosmosDBObject, ICosmosScript)
  private
   FScript: TStringList;

  public
   constructor Create;
   destructor Destroy; override;

   procedure AddCommand(Command: string);
   procedure ClearCommands;
   function ExecuteScript: boolean; overload;
   function ExecuteScript(Script: TStringList): boolean; overload;

 end;



implementation

{ TCosmosCommand }

constructor TCosmosCommand.Create;
begin
 inherited Create;
end;

destructor TCosmosCommand.Destroy;
begin

  inherited;
end;

function TCosmosCommand.ExecuteCommand(const Command: WideString): integer;
var
 aCommand: TdbxCommand;
begin
  aCommand := TdbxCommand.Create;
  aCommand.ConnectionsPool := self.ConnectionsPool.ConnectionsPool;

  try
    Result := aCommand.ExecuteCommand(Command);

  finally
    aCommand.Free;
  end;
end;

procedure TCosmosCommand.ExecuteDQL(const DQL: WideString;
  Dataset: TClientDataset);
var
 aCommand: TdbxCommand;
begin
  aCommand := TdbxCommand.Create;
  aCommand.ConnectionsPool := self.ConnectionsPool.ConnectionsPool;

  try
    aCommand.ExecuteDQL(DQL, Dataset);

  finally
    aCommand.Free;
  end;
end;

{ TCosmosScript }

procedure TCosmosScript.AddCommand(Command: string);
begin
 FScript.Append(Command);
end;

procedure TCosmosScript.ClearCommands;
begin
 FScript.Clear;
end;

constructor TCosmosScript.Create;
begin
 FScript := TStringList.Create;
end;

destructor TCosmosScript.Destroy;
begin
  FScript.Free;
  inherited;
end;

function TCosmosScript.ExecuteScript(Script: TStringList): boolean;
begin
 FScript.Assign(Script);
 Result := self.ExecuteScript;
end;

function TCosmosScript.ExecuteScript: boolean;
var
 aCommand: TdbxCommand;
begin
  aCommand := TdbxCommand.Create;
  aCommand.ConnectionsPool := self.ConnectionsPool.ConnectionsPool;

  try
    Result := aCommand.ExecuteScript(FScript);

  finally
    aCommand.Free;
  end;
end;

{ TCosmosConnectionsPool }

procedure TCosmosConnectionsPool.ClearAll;
begin
 FConnectionsPool.ClearAll;
end;

constructor TCosmosConnectionsPool.Create(const ConnectionParamsFile: string);
begin
 FConnectionsPool := TConnectionsPool.Create(ConnectionParamsFile);
 FConnectionsPool.OnErrorEvent := OnErrorEvent;
 inherited Create;
end;

destructor TCosmosConnectionsPool.Destroy;
begin
  if Assigned(FConnectionsPool) then
   begin
     FConnectionsPool.OnErrorEvent := nil;
     FConnectionsPool.ClearAll;
     FConnectionsPool.Free;
   end;

  inherited;
end;

procedure TCosmosConnectionsPool.FillPool(const ObjCount: integer);
begin
 FConnectionsPool.FillPool(ObjCount);
end;

function TCosmosConnectionsPool.GetConnectionsPool: TConnectionsPool;
begin
 Result := FConnectionsPool;
end;

function TCosmosConnectionsPool.GetConnectionsCount: integer;
begin
 Result := FConnectionsPool.ConnectionsCount;
end;

procedure TCosmosConnectionsPool.RemoveConnection(const SessionId: Int64);
begin
  FConnectionsPool.RemoveConnection(SessionId);
end;

{ TCosmosDBObject }

constructor TCosmosDBObject.Create;
begin
 inherited Create;
end;

destructor TCosmosDBObject.Destroy;
begin
  inherited;
end;

{ TStoredProcCommand }

procedure TStoredProcCommand.AddParam(const ParamName: string; value: variant);
var
 aParam: TParam;
begin
 aParam := FParams.AddParameter;
 aParam.Name := ParamName;
 aParam.Value := value;
end;

procedure TStoredProcCommand.AddParam(const ParamName: string);
var
 aParam: TParam;
begin
 aParam := FParams.AddParameter;
 aParam.Name := ParamName;
end;

constructor TStoredProcCommand.Create;
begin
 inherited Create;
 FParams := TParams.Create;
end;

destructor TStoredProcCommand.Destroy;
begin
  FParams.Free;
  inherited;
end;

function TStoredProcCommand.ExecuteStoredProc: integer;
var
 aStoredProc: TdbxStoredProc;
begin
  aStoredProc := TdbxStoredProc.Create;
  aStoredProc.ConnectionsPool := self.ConnectionsPool.ConnectionsPool;

  try
    aStoredProc.ProcName := ProcName;
    aStoredProc.Params.Assign(Params);
    Result := aStoredProc.Execute;

  finally
    aStoredProc.Free;
  end;

end;



end.

