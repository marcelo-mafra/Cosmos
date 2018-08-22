unit cosmos.tools.dao.logs;

interface

 uses
  System.SysUtils, System.Classes, cosmos.classes.logs, cosmos.tools.dao.logsint,
  cosmos.system.messages;

 type
  TDAOUtils = class
    class function GetLogEvent(const sLogEvent: string): TLogEvent; inline;
  end;

  TDAOLogInfo = class(TInterfacedObject, IDAOLogInfo)
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
    class function New: IDAOLogInfo;

    property Context: string read GetContext write SetContext;
    property Data: TDateTime read GetData write SetData;
    property Info: string read GetInfo write SetInfo;
    property Source: string read GetSource write SetSource;
    property LogType: TLogEvent read GetLogType write SetLogType;
  end;

  TDAOCosmosLogs = class(TInterfacedObject, IDAOCosmosLogs)
  private
   FFileName:string;
   FPosition: integer;
   FItens: TStringList;
   FLogInfo: IDAOLogInfo;
   procedure ReadLogInfo;

  protected
   function GetCount: integer;
   function GetCurrent: IDAOLogInfo;
   function GetEOF: boolean;
   function GetFileName: string;
   function Prior: IDAOLogInfo;
   function Next: IDAOLogInfo;
   function FindData(const Index: integer): IDAOLogInfo;

  public
   constructor Create(const FileName: string);
   destructor Destroy; override;
   class function New(const FileName: string): IDAOCosmosLogs;

   property Count: integer read GetCount;
   property Current: IDAOLogInfo read GetCurrent;
   property EOF: boolean read GetEOF;
   property FileName: string read GetFileName;
   property Position: integer read FPosition;

 end;

implementation

uses
  cosmos.tools.view.messages;


{ TDAOLogInfo }

constructor TDAOLogInfo.Create;
begin

end;

destructor TDAOLogInfo.Destroy;
begin

  inherited;
end;

function TDAOLogInfo.GetContext: string;
begin
 Result := FContext;
end;

function TDAOLogInfo.GetData: TDateTime;
begin
 Result := FData;
end;

function TDAOLogInfo.GetIndex: integer;
begin
 Result := FIndex;
end;

function TDAOLogInfo.GetInfo: string;
begin
 Result := FInfo;
end;

function TDAOLogInfo.GetLogType: TLogEvent;
begin
 Result := FLogType;
end;

function TDAOLogInfo.GetSource: string;
begin
 Result := FSource;
end;

class function TDAOLogInfo.New: IDAOLogInfo;
begin
  Result := self.Create;
end;

procedure TDAOLogInfo.SetContext(const value: string);
begin
 FContext := value;
end;

procedure TDAOLogInfo.SetData(const value: TDateTime);
begin
 FData := Value;
end;

procedure TDAOLogInfo.SetIndex(value: integer);
begin
 FIndex := value;
end;

procedure TDAOLogInfo.SetInfo(const value: string);
begin
 FInfo := value;
end;

procedure TDAOLogInfo.SetLogType(const value: TLogEvent);
begin
 FLogType := value;
end;

procedure TDAOLogInfo.SetSource(const value: string);
begin
 FSource := value;
end;

{ TDAOCosmosLogs }

constructor TDAOCosmosLogs.Create(const FileName: string);
begin
 if not FileExists(FileName) then
  raise Exception.Create(TLogsReader.UnknownFile);

 FItens := TStringList.Create;
 FItens.LoadFromFile(FileName, TEncoding.UTF8);
 FFileName := FileName;
 FPosition := 0;
end;

destructor TDAOCosmosLogs.Destroy;
begin
  FItens.Free;
  inherited;
end;

function TDAOCosmosLogs.FindData(const Index: integer): IDAOLogInfo;
begin
 if Position >= 0 then
  FPosition := Index;

 Result := self.Current;
end;

function TDAOCosmosLogs.GetCount: integer;
begin
 Result:= FItens.Count;
end;

function TDAOCosmosLogs.GetCurrent: IDAOLogInfo;
begin
 ReadLogInfo;
 Result := FLogInfo;
end;

function TDAOCosmosLogs.GetEOF: boolean;
begin
 Result := FItens.Strings[Position].Trim = '';
end;

function TDAOCosmosLogs.GetFileName: string;
begin
 Result:= FFileName;
end;

class function TDAOCosmosLogs.New(const FileName: string): IDAOCosmosLogs;
begin
 Result := self.Create(FileName);
end;

function TDAOCosmosLogs.Next: IDAOLogInfo;
begin
 if self.Count > Position then
   Inc(FPosition);

 Result := self.Current;
end;

function TDAOCosmosLogs.Prior: IDAOLogInfo;
begin
 if Position > 0 then
  Dec(FPosition);

 Result := self.Current;
end;

procedure TDAOCosmosLogs.ReadLogInfo;
var
 aLine, aLogData: string;
 aValueList: TStringList;
begin
 if FLogInfo = nil then
  FLogInfo := TDAOLogInfo.New;

 aValueList := TStringList.Create;

 try
  aLine := FItens.Strings[Position];
  aValueList.CommaText := ALine;
  aLogData := AValueList.Values['LogType'].TrimRight;

  FLogInfo.index := Position;
  FLogInfo.Data := StrToDateTime(AValueList.Values['DateTime'].TrimRight);
  FLogInfo.Context := AValueList.Values['ContextInfo'].TrimRight;
  FLogInfo.Info := AValueList.Values['Message'].TrimRight;
  FLogInfo.Source := AValueList.Values['CosmosApp'].TrimRight;
  FLogInfo.LogType := TDAOUtils.GetLogEvent(AValueList.Values['LogType'].TrimRight);

 finally
  aValueList.Free;
 end;

end;

{ TDAOUtils }

class function TDAOUtils.GetLogEvent(const sLogEvent: string): TLogEvent;
begin
 if sLogEvent = TCosmosLogs.AuthLogType then
   Result := leOnAuthenticateSucess
 else
 if sLogEvent = TCosmosLogs.AuthFailLogType then
   Result := leOnAuthenticateFail
 else
 if sLogEvent = TCosmosLogs.PrepareLogType then
   Result := leOnPrepare
 else
 if sLogEvent = TCosmosLogs.ErrorLogType then
   Result := leOnError
 else
 if sLogEvent = TCosmosLogs.InfoLogType then
   Result := leOnInformation
 else
 if sLogEvent = TCosmosLogs.TraceLogType then
   Result := leOnTrace
 else
 if sLogEvent = TCosmosLogs.RemoteCallLogType then
  Result := leOnMethodCall
 else
 if sLogEvent = TCosmosLogs.RemoteCallErrorLogType then
  Result := leOnMethodCallError
 else
 if sLogEvent = TCosmosLogs.WarnLogType then
  Result := leOnWarning
 else
 if sLogEvent = TCosmosLogs.ConLogType then
  Result := leOnConnect
 else
 if sLogEvent = TCosmosLogs.ConErrorLogType then
  Result := leOnConnectError
 else
 if sLogEvent = TCosmosLogs.ConCloseLogType then
  Result := leOnConnectClose
 else
  Result := leUnknown;
end;

end.
