unit cosmos.classes.logs.textfile;

interface

uses
 Winapi.Windows, System.Classes, System.SysUtils, cosmos.classes.logs,
 Vcl.FastStreams;

 type
  TOnNewFileEvent = procedure(var NewFileName: string) of object;

  TTextFileLog = class(TCustomLog)

   private
    FApplicationName: string;
    FAutoSave: boolean;
    FCurrentFile: string;
    FEncoding: TEncoding;
    FFileExtension: string;
    FMaxSize: Int64;
    FSourcePath: string;
    FPrefix: string;
    FOnNewFileEvent: TOnNewFileEvent;

    function GenerateNewFileName: string;
    procedure WriteMessage(const Message: string);

   public
    constructor Create(const SourcePath, FileExtension: string; Encoding: TEncoding;
     Events: TLogEvents);
    destructor Destroy; override;

    procedure RegisterAuditFailure(const Message: string); override;
    procedure RegisterAuditSucess(const Message: string); override;
    procedure RegisterError(const Message: string); override;
    procedure RegisterInfo(const Message: string); override;
    procedure RegisterSucess(const Message: string); override;
    procedure RegisterWarning(const Message: string); override;
    procedure RegisterRemoteCallSucess(const Message, ContextInfo: string); overload;
    procedure RegisterRemoteCallFailure(const Message, ContextInfo: string); overload;
    procedure RegisterRemoteCallSucess(const Message: string); overload;
    procedure RegisterRemoteCallFailure(const Message: string); overload;
    procedure RegisterPrepare(const Message: string);
    procedure RegisterTrace(const Message: string);
    procedure RegisterAuthorization(const Message: string);
    procedure RegisterConnection(const Message: string);
    procedure RegisterConnectionFailure(const Message: string);
    procedure RegisterConnectionClose(const Message: string);
    procedure RegisterUnknow(const Message: string);
    procedure RegisterLog(const Info, ContextInfo: string; Event: TLogEvent); override;

    property ApplicationName: string read FApplicationName write FApplicationName;
    property AutoSave: boolean read FAutoSave write FAutoSave;
    property CurrentFile: string read FCurrentFile write FCurrentFile;
    property Encoding: TEncoding read FEncoding;
    property FileExtension: string read FFileExtension;
    property MaxSize: Int64 read FMaxSize write FMaxSize;
    property Prefix: string read FPrefix write FPrefix;
    property OnNewFile: TOnNewFileEvent read FOnNewFileEvent write FOnNewFileEvent;

  end;

implementation

{ TTextFileLog }

constructor TTextFileLog.Create(const SourcePath, FileExtension: string;
    Encoding: TEncoding; Events: TLogEvents);
begin
 inherited Create(Events);
 FSourcePath := SourcePath;
 FFileExtension := FileExtension;
 FEncoding := Encoding;
end;

destructor TTextFileLog.Destroy;
begin
  inherited Destroy;
end;

function TTextFileLog.GenerateNewFileName: string;
var
 ANewFile: string;
begin
//Gera um novo nome de arquivo de log.
 if Prefix = '' then
  ANewFile := FSourcePath + FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now) + '.' + FileExtension
 else
  ANewFile := FSourcePath + Prefix + FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now) + '.' + FileExtension ;

 while FileExists(ANewFile) do
   begin
    if Prefix = '' then
      ANewFile := FSourcePath + FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now) + '.' + FileExtension
    else
      ANewFile := FSourcePath + Prefix + FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now) + '.' + FileExtension ;
   end;

 //Dispara o evento que notifica que o nome do arquivo mudou.
 if Assigned(FOnNewFileEvent) then
   FOnNewFileEvent(FCurrentFile);

 Result := ANewFile;
end;

procedure TTextFileLog.RegisterAuditFailure(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnAuthenticateFail);
end;

procedure TTextFileLog.RegisterAuditSucess(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnAuthenticateSucess);
end;

procedure TTextFileLog.RegisterAuthorization(const Message: string);
begin
   RegisterLog(Message, '', leOnAuthorize);
end;

procedure TTextFileLog.RegisterConnection(const Message: string);
begin
  RegisterLog(Message, '', leOnConnect);
end;

procedure TTextFileLog.RegisterConnectionClose(const Message: string);
begin
  RegisterLog(Message, '', leOnConnectClose);
end;

procedure TTextFileLog.RegisterConnectionFailure(const Message: string);
begin
  RegisterLog(Message, '', leOnConnectError);
end;

procedure TTextFileLog.RegisterError(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnError);
end;

procedure TTextFileLog.RegisterInfo(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnInformation);
end;

procedure TTextFileLog.RegisterLog(const Info, ContextInfo: string; Event: TLogEvent);
begin
  inherited;
 if not (Event in self.Events) then
  Exit;

 WriteMessage(Info);
end;

procedure TTextFileLog.RegisterPrepare(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnPrepare);
end;

procedure TTextFileLog.RegisterRemoteCallFailure(const Message,
  ContextInfo: string);
begin
   RegisterLog(Message, ContextInfo, leOnMethodCallError);
end;

procedure TTextFileLog.RegisterRemoteCallSucess(const Message,
  ContextInfo: string);
begin
   RegisterLog(Message, ContextInfo, leOnMethodCall);
end;

procedure TTextFileLog.RegisterSucess(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnInformation);
end;

procedure TTextFileLog.RegisterTrace(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnTrace);
end;

procedure TTextFileLog.RegisterUnknow(const Message: string);
begin
  RegisterLog(Message, '', leUnknown);
end;

procedure TTextFileLog.RegisterWarning(const Message: string);
begin
  inherited;
  RegisterLog(Message, '', leOnWarning);
end;

procedure TTextFileLog.WriteMessage(const Message: string);
var
 AFileWriter: TFastMemStream;// TStringStream;
 Temp: Utf8String;
begin
{Escre os dados no arquivo de log.}
 AFileWriter := TFastMemStream.Create; //TStringStream.Create('', Encoding);

 try
  if (CurrentFile.Trim = '') then //Checa se existe um arquivo corrente.
   begin  //Não existe.
     CurrentFile := GenerateNewFileName; //Gera um novo nome de arquivo e salva-o em disco.
     AFileWriter.SaveToFile(CurrentFile);
   end;

  if not FileExists(CurrentFile) then //Arquivo corrente existe não existe.
   begin
     CurrentFile := GenerateNewFileName; //Ok, alcançou. Gera um novo.
     AFileWriter.SaveToFile(CurrentFile);
   end;

  AFileWriter.LoadFromFile(CurrentFile);

  //Verifica se alcançou o tamanho máximo.
  if (AFileWriter.Size >= MaxSize) then
   begin
    AFileWriter.Clear; //Limpa os dados em memória. Será gerado um novo arquivo.
    CurrentFile := GenerateNewFileName;
    AFileWriter.SaveToFile(CurrentFile);
    AFileWriter.LoadFromFile(CurrentFile)
   end;

  Temp := UTF8Encode(Message + #13);
  AFileWriter.Seek(NativeInt(0), soEnd);
  AFileWriter.Write(Pointer(Temp)^, Length(Temp));

  if AutoSave then
   AFileWriter.SaveToFile(CurrentFile);

  if Assigned(AFileWriter) then
   FreeAndNil(AFileWriter);


 except
  on E: Exception do
   begin
    if Assigned(AFileWriter) then
      FreeAndNil(AFileWriter);

    raise;
   end;
 end;
end;

procedure TTextFileLog.RegisterRemoteCallFailure(const Message: string);
begin
  RegisterLog(Message, '', leOnMethodCallError);
end;

procedure TTextFileLog.RegisterRemoteCallSucess(const Message: string);
begin
  RegisterLog(Message, '', leOnMethodCall);
end;

end.
