unit cosmos.classes.logs.winservice;

interface

uses

 Winapi.Windows, EventWriter, cosmos.classes.logs;

 type

  TWinServiceLog = class(TCustomLog, ICosmosLogs)

   private
    FEventWriter: TEventWriter;

   public
    constructor Create(Events: TLogEvents);
    destructor Destroy; override;
    property EventWriter: TEventWriter read FEventWriter;

    procedure ConfigureService(CategoryMessageFile, DisplayEventFile,
     DisplayNameFile, DisplayEventID, EventFile, PrimaryModule, Source,
     LogName: string; CategoryCount, DisplayNameID, TypesSupported: integer);
    procedure RegisterAuditFailure(const Message: string); override;
    procedure RegisterAuditSucess(const Message: string); override;
    procedure RegisterError(const Message: string); override;
    procedure RegisterInfo(const Message: string); override;
    procedure RegisterSucess(const Message: string); override;
    procedure RegisterWarning(const Message: string); override;
    procedure RegisterRemoteCallSucess(const Message, ContextInfo: string);
    procedure RegisterRemoteCallFailure(const Message, ContextInfo: string);
    procedure RegisterLog(const Info, ContextInfo: string; Event: TLogEvent); override;
  end;

implementation


{ TWinServiceLog }

procedure TWinServiceLog.ConfigureService(CategoryMessageFile, DisplayEventFile,
  DisplayNameFile, DisplayEventID, EventFile, PrimaryModule, Source,
  LogName: string; CategoryCount, DisplayNameID, TypesSupported: integer);
begin
 if FEventWriter <> nil then
  begin
   FEventWriter.CategoryMessageFile := CategoryMessageFile;
   FEventWriter.DisplayEventFile := DisplayEventFile;
   FEventWriter.DisplayNameFile := DisplayNameFile;
   FEventWriter.DisplayEventID := DisplayEventID;
   FEventWriter.EventFile := EventFile;
   FEventWriter.PrimaryModule := PrimaryModule;
   FEventWriter.Source := Source;
   FEventWriter.LogName := LogName;
   FEventWriter.CategoryCount := CategoryCount;
   FEventWriter.DisplayNameID := DisplayNameID;
   FEventWriter.TypesSupported := TypesSupported;
  end;
end;

constructor TWinServiceLog.Create(Events: TLogEvents);
begin
 inherited Create(Events);
 FEventWriter := TEventWriter.Create(nil);
end;

destructor TWinServiceLog.Destroy;
begin
 if Assigned(FEventWriter) then
  FEventWriter.Free;
 inherited Destroy;
end;

procedure TWinServiceLog.RegisterAuditFailure(const Message: string);
begin
 if EventWriter <> nil then
  EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_AUDIT_FAILURE,CAT_AUTENTICACAO,103);
end;

procedure TWinServiceLog.RegisterAuditSucess(const Message: string);
begin
 if EventWriter <> nil then
   EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_AUDIT_SUCCESS,CAT_AUTENTICACAO,103);
end;

procedure TWinServiceLog.RegisterError(const Message: string);
begin
 if EventWriter <> nil then
   EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_ERROR_TYPE,CAT_ERROR,103);
end;

procedure TWinServiceLog.RegisterInfo(const Message: string);
begin
 if EventWriter <> nil then
   EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_INFORMATION_TYPE,CAT_INFO,103);
end;

procedure TWinServiceLog.RegisterLog(const Info, ContextInfo: string;
  Event: TLogEvent);
begin
 if not (Event in self.Events) then
  Exit;

 case Event of
   leOnPrepare: ;
   leOnError: ;
   leOnTrace: ;
   leOnAuthenticateSucess: ;
   leOnAuthenticateFail: ;
   leOnAuthorize: ;
   leOnInformation: ;
   leOnWarning: ;
   leOnConnect: ;
   leOnConnectError: ;
   leOnConnectClose: ;
   leOnMethodCall: ;
   leOnMethodCallError: ;
 end;

end;

procedure TWinServiceLog.RegisterRemoteCallFailure(const Message,
  ContextInfo: string);
begin
  if EventWriter <> nil then
   EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_ERROR_TYPE,CAT_SUCESS,103);
end;

procedure TWinServiceLog.RegisterRemoteCallSucess(const Message,
  ContextInfo: string);
begin
  if EventWriter <> nil then
   EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_SUCCESS,CAT_SUCESS,103);
end;

procedure TWinServiceLog.RegisterSucess(const Message: string);
begin
 if EventWriter <> nil then
   EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_SUCCESS,CAT_SUCESS,103);
end;

procedure TWinServiceLog.RegisterWarning(const Message: string);
begin
 if EventWriter <> nil then
   EventWriter.WriteLog(EventWriter.Source,Message,EVENTLOG_WARNING_TYPE,CAT_WARNING,103);
end;

end.
