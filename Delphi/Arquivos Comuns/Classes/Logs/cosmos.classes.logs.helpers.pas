unit cosmos.classes.logs.helpers;

interface

uses
 cosmos.classes.logs, cosmos.system.messages, sysutils;

type
 TLogEventHelper = record helper for TLogEvent
   private
     function GetLogEventName: string;
     function GetLogEventIndex: integer;

   public
     property LogEventIndex: integer read GetLogEventIndex;
     property LogEventName: string read GetLogEventName;
 end;


implementation

{ TLogEventHelper }

function TLogEventHelper.GetLogEventIndex: integer;
begin
 case self of
   leOnPrepare: Result := 0 ;
   leOnError: Result := 1 ;
   leOnTrace: Result := 2 ;
   leOnAuthenticateSucess: Result := 3 ;
   leOnAuthenticateFail:  Result := 4;
   leOnAuthorize:  Result := 5;
   leOnInformation: Result := 6;
   leOnWarning:  Result := 7;
   leOnConnect:  Result := 8;
   leOnConnectError:  Result := 9;
   leOnConnectClose:  Result := 10;
   leOnMethodCall:  Result := 11;
   leOnMethodCallError:  Result := 12;
   leUnknown:  Result := 13;
 end;
end;

function TLogEventHelper.GetLogEventName: string;
begin
 case self of
   leOnPrepare: Result := TCosmosLogs.PrepareLogType;
   leOnError: Result := TCosmosLogs.ErrorLogType;
   leOnTrace: Result := TCosmosLogs.TraceLogType;
   leOnAuthenticateSucess: Result := TCosmosLogs.AuthLogType;
   leOnAuthenticateFail: Result := TCosmosLogs.AuthFailLogType;
   leOnAuthorize: Result := TCosmosLogs.AutLogType;
   leOnInformation: Result := TCosmosLogs.InfoLogType;
   leOnWarning: Result := TCosmosLogs.WarnLogType;
   leOnConnect: Result := TCosmosLogs.ConLogType;
   leOnConnectError: Result := TCosmosLogs.ConErrorLogType;
   leOnConnectClose: Result := TCosmosLogs.ConCloseLogType;
   leOnMethodCall: Result := TCosmosLogs.RemoteCallLogType;
   leOnMethodCallError: Result := TCosmosLogs.RemoteCallErrorLogType;
   leUnknown: Result := TCosmosLogs.UnknownLogType;
 end;
end;

end.
