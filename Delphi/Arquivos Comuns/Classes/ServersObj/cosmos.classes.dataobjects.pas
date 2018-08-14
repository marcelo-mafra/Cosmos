unit cosmos.classes.dataobjects;

interface

uses
 System.Classes, System.SysUtils, DataSnap.DBClient, cosmos.classes.dbxObjects,
 cosmos.classes.datobj.interfaces;

type

//Encapsula um simples pool de conexões com o banco de dados.
 TCosmosConnectionsPool = class
   private
   FConnectionsPool: TConnectionsPool;
   function GetConnection: TConnectionsPool;
   function GetConnectionsCount: integer;

  public
   constructor Create(const ConnectionParamsFile: string);
   destructor Destroy; override;

   procedure ClearAll;
   procedure FillPool(const ObjCount: integer);
   procedure RemoveConnection(const SessionId: Int64);

   property Connection: TConnectionsPool read GetConnection;
   property ConnectionsCount: integer read GetConnectionsCount;
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
  aCommand.ConnectionsPool := self.ConnectionsPool.Connection;

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
  aCommand.ConnectionsPool := self.ConnectionsPool.Connection;

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
  aCommand.ConnectionsPool := self.ConnectionsPool.Connection;

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
 inherited Create;
end;

destructor TCosmosConnectionsPool.Destroy;
begin
  if Assigned(FConnectionsPool) then
   begin
     FConnectionsPool.ClearAll;
     FConnectionsPool.Free;
   end;

  inherited;
end;

procedure TCosmosConnectionsPool.FillPool(const ObjCount: integer);
begin
 FConnectionsPool.FillPool(ObjCount);
end;

function TCosmosConnectionsPool.GetConnection: TConnectionsPool;
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

end.

