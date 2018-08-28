unit cosmos.servers.common.services;

interface

uses
  System.SysUtils, System.Classes, cosmos.system.types, cosmos.system.types.cmhelpers,
  cosmos.classes.application, Datasnap.DSSession, cosmos.system.files,
  cosmos.classes.persistence.ini, cosmos.classes.logs, cosmos.classes.logs.controller,
  cosmos.servers.common.servicesint, cosmos.servers.common.dsservices;

type

  //Serviços dos servidores do Cosmos.
  TCosmosServerServices = class(TInterfacedObject, ICosmosService)
  private
    { Private declarations }
    FCosmosModule: TCosmosModules;
    FDSService: ICosmosDSService;
    FLogActive: boolean;
    FLogObj: TCosmosLogsController;
    FLogEvents: TLogEvents;
    FMaxFileSize: Int64;
    FServerLogsPath: string;
    procedure LoadLogsConfigurations;
    procedure SetCosmosModule(value: TCosmosModules);

  protected
    function CreateContextInfoObject: TStringList;
    function GetCosmosModuleName: string;
    function GetCosmosModuleIdentifier: string;
    function GetCosmosModuleShortName: string;
    function GetDSService: ICosmosDSService;
    function GetLogs: ICosmosLogs;
    function GetLogEvents: TLogEvents;
    procedure RegisterLog(const Info, ContextInfo: string; Event: TLogEvent = leOnInformation);

  public
    constructor Create(Module: TCosmosModules);
    destructor Destroy; override;
    class function New(Module: TCosmosModules): ICosmosService;

    property CosmosModule: TCosmosModules read FCosmosModule write SetCosmosModule;
    property CosmosModuleName: string read GetCosmosModuleName;
    property CosmosModuleShortName: string read  GetCosmosModuleShortName;
    property CosmosModuleIdentifier: string read  GetCosmosModuleIdentifier;
    property DSService: ICosmosDSService read GetDSService;
    property Logs: ICosmosLogs read GetLogs;
    property LogEvents: TLogEvents read GetLogEvents;
  end;


implementation


{ TCosmosServerServices }

constructor TCosmosServerServices.Create(Module: TCosmosModules);
var
 ACosmosApp: TCosmosApplication;
begin
 FCosmosModule := Module;
 FDSService := TCosmosDSService.New;
 ACosmosApp := TCosmosApplication.Create;

 try
  //Cria o objeto que escreve os logs, caso o mesmo já não tenha sido criado.
  if (Logs = nil) and (DirectoryExists(FServerLogsPath)) then
   begin
    FLogObj := TCosmosLogsController.Create(FServerLogsPath, 'log', TEncoding.UTF8, LogEvents); //do not localize!
    FLogObj.MaxFileSize := FMaxFileSize;
    FLogObj.Prefix := ACosmosApp.GetLogPrefix(CosmosModule);
    FLogObj.CosmosAppName := CosmosModuleName;
   end;

 finally
   ACosmosApp.Free;
 end;
end;

function TCosmosServerServices.CreateContextInfoObject: TStringList;
begin
 //Retorna um objeto TStringList para uso em registro de logs.
 Result := TStringList.Create;
 Result.Delimiter := ';';
 Result.QuoteChar := '"';
end;

destructor TCosmosServerServices.Destroy;
begin
  if Assigned(FLogObj) then FreeAndNil(FLogObj);
  FDSService := nil;
  inherited;
end;

function TCosmosServerServices.GetCosmosModuleIdentifier: string;
begin
 //Retorna o nome "de identificação" do servidor em execução do Cosmos.
 Result := CosmosModule.ModuleId;
end;

function TCosmosServerServices.GetCosmosModuleName: string;
begin
 //Retorna o nome do servidor em execução do Cosmos.
 Result := CosmosModule.ModuleName;
end;

function TCosmosServerServices.GetCosmosModuleShortName: string;
begin
 //Retorna o nome abreviado do servidor em execução do Cosmos.
 Result := CosmosModule.ModuleNameShort.ToUpper;
end;

function TCosmosServerServices.GetDSService: ICosmosDSService;
begin
 Result := FDSService;
end;

function TCosmosServerServices.GetLogEvents: TLogEvents;
begin
 Result := FLogEvents;
end;

function TCosmosServerServices.GetLogs: ICosmosLogs;
begin
 Result := self.FLogObj;
end;

procedure TCosmosServerServices.LoadLogsConfigurations;
var
  AFile: TIniFilePersistence;
  CosmosApp: TCosmosApplication;
begin
{Carrega as configurações de registro de logs do servidor em execução.}
 CosmosApp := TCosmosApplication.Create;
 AFile := TIniFilePersistence.Create(CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot, True);

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

class function TCosmosServerServices.New(
  Module: TCosmosModules): ICosmosService;
begin
 Result := self.Create(Module);
end;

procedure TCosmosServerServices.RegisterLog(const Info, ContextInfo: string;
  Event: TLogEvent);
begin
{Registra logs de sistema. O registro somente é feito caso o registro de logs
para determinado tipo de evento estiver ativo.}
 if not (Event in LogEvents) then
  Exit;

 if Assigned(Logs) then
  LOgs.RegisterLog(Info, ContextInfo, Event);
end;

procedure TCosmosServerServices.SetCosmosModule(value: TCosmosModules);
begin
 if (FCosmosModule <> Value) then
  begin
    FCosmosModule := Value;
    LoadLogsConfigurations;
  end;
end;


end.

