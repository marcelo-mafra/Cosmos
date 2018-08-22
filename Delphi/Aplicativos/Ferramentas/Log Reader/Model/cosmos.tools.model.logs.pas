unit cosmos.tools.model.logs;

interface

uses
  cosmos.classes.logs, cosmos.tools.model.logsint, cosmos.tools.dao.logsint;

type
  TModelLogInfo = class(TInterfacedObject, IModelLogInfo)
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
    class function New: IModelLogInfo;

    property Index: integer read GetIndex write SetIndex;
    property Context: string read GetContext write SetContext;
    property Data: TDateTime read GetData write SetData;
    property Info: string read GetInfo write SetInfo;
    property Source: string read GetSource write SetSource;
    property LogType: TLogEvent read GetLogType write SetLogType;
  end;


  TModelCosmosLogs = class(TInterfacedObject, IModelCosmosLogs)

  private
   FDAOCosmosLogs: IDAOCosmosLogs;
   function CopyDAOInfo(Source: IDAOLogInfo): IModelLogInfo;

  protected
   function GetCount: integer;
   function GetCurrent: IModelLogInfo;
   function GetEOF: boolean;
   function GetFileName: string;
   function Prior: IModelLogInfo;
   function Next: IModelLogInfo;
   function FindData(const Index: integer): IModelLogInfo;

  public
   constructor Create(const FileName: string);
   destructor Destroy; override;
   class function New(const FileName: string): IModelCosmosLogs;

   property Count: integer read GetCount;
   property Current: IModelLogInfo read GetCurrent;
   property EOF: boolean read GetEOF;
   property FileName: string read GetFileName;
  end;

implementation

uses
  System.SysUtils, cosmos.tools.dao.logs, cosmos.tools.view.messages;

{ TModelCosmosLogs }

function TModelCosmosLogs.CopyDAOInfo(Source: IDAOLogInfo): IModelLogInfo;
begin
 if Source = nil then
  raise Exception.Create(TLogsReader.SourceInvalid);


 Result := TModelLogInfo.New;
 Result.Index := Source.Index;
 Result.Context := Source.Context;
 Result.Data := Source.Data;
 Result.Info := SOurce.Info;
 Result.LogType := Source.LogType;
end;

constructor TModelCosmosLogs.Create(const FileName: string);
begin
 FDAOCosmosLogs := TDAOCosmosLogs.New(FileName);
end;

destructor TModelCosmosLogs.Destroy;
begin
  FDAOCosmosLogs := nil;
  inherited;
end;

function TModelCosmosLogs.FindData(const Index: integer): IModelLogInfo;
begin
 Result := self.CopyDAOInfo(FDAOCosmosLogs.FindData(Index));
end;

function TModelCosmosLogs.GetCount: integer;
begin
 Result := FDAOCosmosLogs.Count;
end;

function TModelCosmosLogs.GetCurrent: IModelLogInfo;
begin
 Result := self.CopyDAOInfo(FDAOCosmosLogs.Current);
end;

function TModelCosmosLogs.GetEOF: boolean;
begin
 Result := FDAOCosmosLogs.EOF;
end;

function TModelCosmosLogs.GetFileName: string;
begin
 Result := FDAOCosmosLogs.FileName;
end;

class function TModelCosmosLogs.New(const FileName: string): IModelCosmosLogs;
begin
 Result := self.Create(FileName);
end;

function TModelCosmosLogs.Next: IModelLogInfo;
begin
 Result := self.CopyDAOInfo(FDAOCosmosLogs.Next);
end;

function TModelCosmosLogs.Prior: IModelLogInfo;
begin
 Result := self.CopyDAOInfo(FDAOCosmosLogs.Prior);
end;

{ TModelLogInfo }

constructor TModelLogInfo.Create;
begin
 inherited;
end;

destructor TModelLogInfo.Destroy;
begin
  inherited;
end;

function TModelLogInfo.GetContext: string;
begin
 Result := FContext;
end;

function TModelLogInfo.GetData: TDateTime;
begin
 Result := FData;
end;

function TModelLogInfo.GetIndex: integer;
begin
 Result := FIndex;
end;

function TModelLogInfo.GetInfo: string;
begin
 Result := FInfo;
end;

function TModelLogInfo.GetLogType: TLogEvent;
begin
 Result := FLogType;
end;

function TModelLogInfo.GetSource: string;
begin
 Result := FSource;
end;

class function TModelLogInfo.New: IModelLogInfo;
begin
  Result := self.Create;
end;

procedure TModelLogInfo.SetContext(const value: string);
begin
 FContext := value;
end;

procedure TModelLogInfo.SetData(const value: TDateTime);
begin
 FData := value;
end;

procedure TModelLogInfo.SetIndex(value: integer);
begin
 FIndex := value;
end;

procedure TModelLogInfo.SetInfo(const value: string);
begin
 FInfo := value;
end;

procedure TModelLogInfo.SetLogType(const value: TLogEvent);
begin
 FLogType := value;
end;

procedure TModelLogInfo.SetSource(const value: string);
begin
 FSource:= value;
end;

end.
