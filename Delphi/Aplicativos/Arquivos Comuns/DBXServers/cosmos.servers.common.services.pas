unit cosmos.servers.common.services;

interface

uses
  System.SysUtils, System.Classes, cosmos.system.types, cosmos.system.messages,
  cosmos.classes.application, Datasnap.DSSession, cosmos.system.files,
  cosmos.classes.persistence.ini, cosmos.classes.logs, cosmos.classes.logs.controller;

type

  TDMCosmosServerServices = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FCosmosModule: TCosmosModules;
    FLogActive: boolean;
    FLogInfo: TCosmosLogsController;
    FLogEvents: TLogEvents;
    FMaxFileSize: Int64;
    FServerLogsPath: string;

    function GetConnectedUser: string;
    function GetCosmosModuleName: string;
    function GetCosmosModuleShortName: string;
    procedure LoadLogsConfigurations;
    procedure SetCosmosModule(value: TCosmosModules);
    function GetCosmosModuleIdentifier: string;

  public
    function CreateContextInfoObject: TStringList;
    function FindSession(const SessionId: string): TDSSession;
    procedure RegisterLog(const Info, ContextInfo: string; Event: TLogEvent = leOnInformation);

    property ConnectedUser: string read GetConnectedUser;
    property CosmosModule: TCosmosModules read FCosmosModule write SetCosmosModule;
    property CosmosModuleName: string read GetCosmosModuleName;
    property CosmosModuleShortName: string read  GetCosmosModuleShortName;
    property CosmosModuleIdentifier: string read  GetCosmosModuleIdentifier;
    property LogInfo: TCosmosLogsController read FLogInfo;
    property LogEvents: TLogEvents read FLogEvents;
  end;

var
  DMCosmosServerServices: TDMCosmosServerServices;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMCosmosServerServices }

function TDMCosmosServerServices.CreateContextInfoObject: TStringList;
begin
 //Retorna um objeto TStringList para uso em registro de logs.
 Result := TStringList.Create;
 Result.Delimiter := ';';
 Result.QuoteChar := '"';
end;

procedure TDMCosmosServerServices.DataModuleDestroy(Sender: TObject);
begin
 if Assigned(LogInfo) then FreeAndNil(FLogInfo);
end;

function TDMCosmosServerServices.FindSession(
  const SessionId: string): TDSSession;
begin
 //Retorna um objeto TDSSession para trabalho.
 Result := TDSSessionManager.Instance.Session[SessionId];
end;

function TDMCosmosServerServices.GetConnectedUser: string;
begin
 Result := TDSSessionManager.GetThreadSession.GetData('ConnectedUser'); //do not localize!
end;

function TDMCosmosServerServices.GetCosmosModuleIdentifier: string;
begin
 //Retorna o nome "de identificação" do servidor em execução do Cosmos.
 case CosmosModule of
   cmFocosServer: Result := TCosmosAppName.CosmosFocosId;
   cmSecretariasServer: Result :=  TCosmosAppName.CosmosSecretariasId;
   cmFinanceiroServer: Result :=  TCosmosAppName.CosmosFinanceiroId;
   cmConferenciasServer: Result :=  TCosmosAppName.CosmosConferenciasId;
   cmUsuariosServer: Result :=  TCosmosAppName.CosmosUsuariosId;
 end;
end;

function TDMCosmosServerServices.GetCosmosModuleName: string;
begin
 //Retorna o nome do servidor em execução do Cosmos.
 case CosmosModule of
   cmFocosServer: Result := TCosmosAppName.CosmosFocos;
   cmSecretariasServer: Result :=  TCosmosAppName.CosmosSecretarias;
   cmFinanceiroServer: Result :=  TCosmosAppName.CosmosFinanceiro;
   cmConferenciasServer: Result :=  TCosmosAppName.CosmosConferencias;
   cmUsuariosServer: Result :=  TCosmosAppName.CosmosUsuarios;
 end;
end;

function TDMCosmosServerServices.GetCosmosModuleShortName: string;
begin
 //Retorna o nome abreviado do servidor em execução do Cosmos.
 case CosmosModule of
   cmFocosServer: Result := TCosmosAppName.CosmosFocosShort.ToUpper;
   cmSecretariasServer: Result :=  TCosmosAppName.CosmosSecretariasShort.ToUpper;
   cmFinanceiroServer: Result :=  TCosmosAppName.CosmosFinanceiroShort.ToUpper;
   cmConferenciasServer: Result :=  TCosmosAppName.CosmosConferenciasShort.ToUpper;
   cmUsuariosServer: Result :=  TCosmosAppName.CosmosUsuariosShort.ToUpper;
 end;
end;

procedure TDMCosmosServerServices.LoadLogsConfigurations;
var
  AFile: TIniFilePersistence;
  AFileName: string;
  CosmosApp: TCosmosApplication;
begin
{Carrega as configurações de registro de logs do servidor em execução.}
 CosmosApp := TCosmosApplication.Create;
 AFileName := CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot;
 AFile := TIniFilePersistence.Create(AFileName, True);

 FLogEvents := [];

 try
 //Configurações de geração de logs do servidor.
  //Ativação dos logs de todas as aplicações Cosmos.
  FLogActive := AFile.ReadBoolean('LOGS', 'Active', True);  //do not localize!
  FServerLogsPath := AFile.ReadString('LOGS', 'ServerLogsPath', '');  //do not localize!
  FMaxFileSize := AFile.ReadInteger('LOGS', 'MaxFileSize', 524288);//default 512kb 524288  //do not localize!

  {Ativação dos logs da aplicação Cosmos corrente. Somente checa caso a geração de
   logs geral dos sistemas cosmos estiver ativa.}
  if FLogActive = True then
   FLogActive := AFile.ReadBoolean(CosmosModuleShortName, 'ActiveLog', True); //do not localize!

  if FServerLogsPath = '' then
   Exit;

  if FLogActive = False then
   Exit;

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnPrepareServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnPrepare];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnErrorServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnError];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnTraceServerLogs', False) then //do not localize!
   FLogEvents := FLogEvents + [leOnTrace];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnAuthenticateSucessServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnAuthenticateSucess];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnAuthenticateFailServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnAuthenticateFail];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnAuthorizeServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnAuthorize];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnInformationServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnInformation];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnWarningServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnWarning];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnConnectServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnConnect];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnConnectErrorServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnConnectError];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnConnectCloseServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnConnectClose];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnMethodCallServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnMethodCall];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnMethodCallErrorServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leOnMethodCallError];

  if AFile.ReadBoolean(CosmosModuleShortName, 'ActivateOnUnknownServerLogs', True) then //do not localize!
   FLogEvents := FLogEvents + [leUnknown];

  if Assigned(AFile) then
   FreeAndNil(AFile);

 except
  on E: Exception do
   begin
     //Gerar logs de exceção...
     if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
     RegisterLog(E.Message, 'AppMethod: TDMCosmosServerServices.LoadLogsConfigurations', leOnError); //do not localize!
   end;
 end;
end;

procedure TDMCosmosServerServices.RegisterLog(const Info, ContextInfo: string;
  Event: TLogEvent);
var
 ACosmosApp: TCosmosApplication;
begin
{Registra logs de sistema. O registro somente é feito caso o registro de logs
para determinado tipo de evento estiver ativo.}
 if not (Event in LogEvents) then
  Exit;

 ACosmosApp := TCosmosApplication.Create;

 try
  if (LogInfo = nil) and (DirectoryExists(FServerLogsPath)) then
   begin
    FLogInfo := TCosmosLogsController.Create(FServerLogsPath, 'log', TEncoding.UTF8, LogEvents); //do not localize!
    LogInfo.MaxFileSize := FMaxFileSize;
    LogInfo.Prefix := ACosmosApp.GetLogPrefix(CosmosModule);
    LogInfo.CosmosAppName := CosmosModuleName;
   end;


 if Assigned(LogInfo) then
  LogInfo.RegisterLog(Info, ContextInfo, Event);

 finally
  if Assigned(ACosmosApp) then FreeAndNil(ACosmosApp);
 end;
end;

procedure TDMCosmosServerServices.SetCosmosModule(value: TCosmosModules);
begin
 if (FCosmosModule <> Value) then
  begin
    FCosmosModule := Value;
    LoadLogsConfigurations;
  end;
end;


end.

