unit cosmos.tools.controller.logs;

interface

uses
  System.SysUtils, cosmos.classes.logs, cosmos.tools.controller.logsint,
  cosmos.tools.model.logsint, cosmos.tools.model.logs, cosmos.system.types;

type
  TOnChangeCosmosModule = procedure(CosmosModule: TCosmosModules) of object;

  TControllerLogInfo = class(TInterfacedObject, IControllerLogInfo)
   private
    FIndex: integer;
    FContext, FInfo, FSource: string;
    FData: TDateTime;
    FLogType: TLogEvent;

   protected
    function GetIndex: integer;
    procedure SetIndex(value: integer);
    function GetContext: string;
    procedure SetContext(const value: string);
    function GetData: TDateTime;
    procedure SetData(const value: TDateTime);
    function GetInfo: string;
    procedure SetInfo(const value: string);
    function GetSource: string;
    procedure SetSource(const value: string);
    function GetLogType: TLogEvent;
    procedure SetLogType(const value: TLogEvent);

   public
    constructor Create;
    destructor Destroy; override;
    class function New: IControllerLogInfo;

    property Index: integer read GetIndex write SetIndex;
    property Context: string read GetContext write SetContext;
    property Data: TDateTime read GetData write SetData;
    property Info: string read GetInfo write SetInfo;
    property Source: string read GetSource write SetSource;
    property LogType: TLogEvent read GetLogType write SetLogType;


  end;


  TControllerCosmosLogs = class(TInterfacedObject, IControllerCosmosLogs)

  private
   FCosmosModule: TCosmosModules;
   FModelCosmosLogs: IModelCosmosLogs;
   FOnChangeModule: TOnChangeCosmosModule;
   procedure SetCosmosModules(value: TCosmosModules);
   function CopyModelInfo(Source: IModelLogInfo): IControllerLogInfo;

  protected
   function GetCount: integer;
   function GetCurrent: IControllerLogInfo;
   function GetEOF: boolean;
   function GetFileName: string;
   function Prior: IControllerLogInfo;
   function Next: IControllerLogInfo;
   function FindData(const Index: integer): IControllerLogInfo;

  public
   constructor Create(const FileName: string);
   destructor Destroy; override;
   class function New(const FileName: string): IControllerCosmosLogs;

   property CosmosModule: TCosmosModules read FCosmosModule write SetCosmosModules;
   property Count: integer read GetCount;
   property Current: IControllerLogInfo read GetCurrent;
   property EOF: boolean read GetEOF;
   property FileName: string read GetFileName;

   property OnChangeModule: TOnChangeCosmosModule read FOnChangeModule write FOnChangeModule;
  end;

implementation

uses
  cosmos.tools.view.messages;


{ TControllerCosmosLogs }

function TControllerCosmosLogs.CopyModelInfo(Source: IModelLogInfo): IControllerLogInfo;
begin
 if Source = nil then
  raise Exception.Create(TLogsReader.SourceInvalid);


 Result := TControllerLogInfo.New;
 Result.Index := Source.Index;
 Result.Context := Source.Context;
 Result.Data := Source.Data;
 Result.Info := SOurce.Info;
 Result.LogType := Source.LogType;
end;

constructor TControllerCosmosLogs.Create(const FileName: string);
begin
 FModelCosmosLogs := TModelCosmosLogs.New(FileName);
end;

destructor TControllerCosmosLogs.Destroy;
begin
  FModelCosmosLogs := nil;
  inherited;
end;

function TControllerCosmosLogs.FindData(
  const Index: integer): IControllerLogInfo;
begin
 Result := self.CopyModelInfo(FModelCosmosLogs.FindData(Index));
end;

function TControllerCosmosLogs.GetCount: integer;
begin
 Result := FModelCosmosLogs.Count;
end;

function TControllerCosmosLogs.GetCurrent: IControllerLogInfo;
begin
 Result := self.CopyModelInfo(FModelCosmosLogs.Current);
end;

function TControllerCosmosLogs.GetEOF: boolean;
begin
 Result := FModelCosmosLogs.EOF;
end;

function TControllerCosmosLogs.GetFileName: string;
begin
 Result := FModelCosmosLogs.FileName;
end;

class function TControllerCosmosLogs.New(const FileName: string): IControllerCosmosLogs;
begin
 Result := self.Create(FileName);
end;

function TControllerCosmosLogs.Next: IControllerLogInfo;
begin
 Result := self.CopyModelInfo(FModelCosmosLogs.Next);
end;

function TControllerCosmosLogs.Prior: IControllerLogInfo;
begin
 Result := self.CopyModelInfo(FModelCosmosLogs.Prior);
end;

procedure TControllerCosmosLogs.SetCosmosModules(value: TCosmosModules);
begin
 if value <> FCosmosModule then
   begin
     FCosmosModule := value;
     if assigned(FOnChangeModule) then
       FOnChangeModule(value);
   end;
end;

{ TControllerLogInfo }

constructor TControllerLogInfo.Create;
begin
 inherited;
end;

destructor TControllerLogInfo.Destroy;
begin
  inherited;
end;

function TControllerLogInfo.GetContext: string;
begin
 Result := FContext;
end;

function TControllerLogInfo.GetData: TDateTime;
begin
 Result := FData;
end;

function TControllerLogInfo.GetIndex: integer;
begin
 Result := FIndex;
end;

function TControllerLogInfo.GetInfo: string;
begin
 Result := FInfo;
end;

function TControllerLogInfo.GetLogType: TLogEvent;
begin
 Result := FLogType;
end;

function TControllerLogInfo.GetSource: string;
begin
 Result := FSource;
end;

class function TControllerLogInfo.New: IControllerLogInfo;
begin
  Result := self.Create;
end;

procedure TControllerLogInfo.SetContext(const value: string);
begin
 FContext := value;
end;

procedure TControllerLogInfo.SetData(const value: TDateTime);
begin
 FData := value;
end;

procedure TControllerLogInfo.SetIndex(value: integer);
begin
 FIndex := value;
end;

procedure TControllerLogInfo.SetInfo(const value: string);
begin
 FInfo := value;
end;

procedure TControllerLogInfo.SetLogType(const value: TLogEvent);
begin
 FLogType := value;
end;

procedure TControllerLogInfo.SetSource(const value: string);
begin
 FSource:= value;
end;

end.

