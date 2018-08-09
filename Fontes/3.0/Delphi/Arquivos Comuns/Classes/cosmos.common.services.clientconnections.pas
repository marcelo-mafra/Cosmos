
unit cosmos.common.services.clientconnections;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Dialogs, Data.DB, System.Variants,
  cosmos.system.types, cosmos.system.messages, cosmos.system.exceptions,
  cosmos.classes.application, Cosmos.Framework.Interfaces.Root, Vcl.Forms,
  cosmos.classes.ServerInterface, cosmos.Framework.Interfaces.DataAcess,
  cosmos.framework.interfaces.dialogs, cosmos.classes.security, Vcl.AppEvnts,
  cosmos.framework.datanavigators.common, cosmos.core.client.connection,
  cosmos.framework.interfaces.utils, IdStack, Vcl.Graphics, Xml.XMLDoc, Xml.XMLIntf,
  Xml.xmldom, Xml.Win.msxmldom, MidasLib, Data.DBXCommon, Data.SqlExpr,
  Datasnap.DSConnect, Datasnap.DBClient, Datasnap.Provider, Vcl.Controls,
  Datasnap.DSHTTPLayer, cosmos.core.classes.FieldsInfo, cosmos.business.focos,
  Data.DBXCommonIndy, cosmos.classes.logs, Data.DBXDBReaders, Vcl.ExtCtrls,
  cosmos.common.services.providerspool, Data.DBXDataSnap, IPPeerClient, Data.FMTBcd,
  Cosmos.Framework.Interfaces.ConnectionNotifiers, IdException, IdExceptionCore,
  cosmos.framework.clients.common.appinfo, DbxCompressionFilter,
  cosmos.classes.dsconnectionspool, Data.DbxHTTPLayer,  cosmos.common.services.connectionstest;

type
  //Informações existentes em um certificado digital.
  TCertificateInfo = (ciOwner, ciCountry, ciState, ciCity, ciWebsite, ciEmailAddress);

  //Forma com que as conexões são feitas.
  TConnectionType = (ctPooledOnDemand, ctPooledOnStart, ctStateless, ctFixed);

  TDMBase = class(TDataModule, ICosmosRemoteConnection)
    CdsBufferedData: TClientDataSet;
    AppEvents: TApplicationEvents;
    DBXConnection: TSQLConnection;
    DBXServerMethod: TSqlServerMethod;
    DSProviderConnection: TDSProviderConnection;
    XMLFieldsInfo: TXMLDocument;
    DspConverter: TDataSetProvider;
    TimerConnection: TTimer;
    DBXMonitor: TSQLMonitor;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DBXConnectionAfterDisconnect(Sender: TObject);
    procedure DBXConnectionBeforeConnect(Sender: TObject);
    procedure DBXConnectionAfterConnect(Sender: TObject);
    procedure DBXConnectionValidatePeerCertificate(Owner: TObject;
      Certificate: TX509Certificate; const ADepth: Integer; var Ok: Boolean);
    procedure DBXConnectionBeforeDisconnect(Sender: TObject);
    procedure TimerConnectionTimer(Sender: TObject);
    procedure DBXMonitorLogTrace(Sender: TObject; TraceInfo: TDBXTraceInfo);
    procedure DBXMonitorTrace(Sender: TObject; TraceInfo: TDBXTraceInfo;
      var LogTrace: Boolean);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FActiveDataset: TDataset;
    FActiveDataNavigator: TCustomDataNavigator;
    FConnectionStatus: TConnectionStatus;
    FConnectionObservable: TConnectionStatusObservable;
    FLockedByUser: boolean;
    FBufferDir: string;
    FCurrentConnectionInfo: TCosmosSecurity;
    FProtocols: TProtocols;
    FConnectedUserRoles: TStringList;
    FConnectionInfo: TCosmosData;
    FConnectionsPool: TDBXConnectionPool;
    FRemoteProviders: TRemoteProvidersPool;
    FCosmosCertificate: TCosmosData;
    FConnTest: TConnectionTest;

    procedure AbortConnection;
    procedure CloseConnectInfoDialog; inline;
    function DoCreateConnection: TSQLConnection;
    function GetConnectionType: TConnectionType;
    procedure ConvertToClientDataset(Source: TCustomSQLDataset; Destination: TClientDataset);
    procedure CreateFieldsInfo;
    procedure DoChangeStatus(E: EIdException);
    procedure DoCloseConnection; inline;
    function DoConnectServer(const UserName, Password: string): boolean;
    function GetCertificateInfo(Certificate: TX509Certificate; Info: TCertificateInfo): string;
    procedure GetDBXErrorMessages(const ErrorCode: integer; var Title, Message: string);
    function GetPooledConnection: boolean;
    function GetServerClassName(ServerClass: TServerClass): string;
    function HasNewerVersion(const Table: TCosmosTables): boolean;
    procedure LoadServers;
    function LoginDialog(var UserName, Password: string): boolean;
    function PasswordIsTemporary(const UserName: string): boolean;
    procedure ReadUserRoles(const UserName: string);
    procedure RegisterAuthorizations;
    procedure RegisterCamposTrabalhos;
    procedure RegisterConnectedUserInfo(const UserName: string);
    function VerifyCosmosServer(Module: TCosmosModules): boolean;

    procedure SetConnectionStatus(Value: TConnectionStatus);
    procedure ShowNoServerDialog;
    function GetConnectionParamsInfo: string;
    function GetConnectionObject: TSQLConnection;
    function NewMonitorFileName: string;
    procedure UpdateBufferedTablesControlFile(const Table: TCosmosTables;
      NewVersion: integer);

  protected
    {ICosmosRemoteConnection}
    function GetCertificateData: TCosmosData;
    function GetConnected: boolean;
    function GetConnectedUser: string;
    function GetConnectedUserRoles: string;
    function GetConnectedServer: string;
    function GetConnectedPort: integer;
    procedure SetConnected(Value: boolean);
    function GetConnectionBroker: TDSProviderConnection;
    function GetConnectionProtocol: TConnectionProtocol;
    function GetConnectionStatusNotifier: IConnectionStatusObservable;
    function GetActiveDataset: TDataset;
    procedure SetActiveDataset(value: TDataset);
    function GetActiveDataNavigator: TCustomDataNavigator;
    procedure SetActiveDataNavigator(value: TCustomDataNavigator);
    function GetCurrentConnectionInfo: TCosmosSecurity;
    function GetCurrentConnectionMode: TConnectionMode;
    function GetCurrentUser: TCosmosUser;
    function GetMonitorConnection: boolean;
    procedure SetMonitorConnection(value: boolean);
    function GetRemoteHost: string;
    function GetServerDateTime: TDateTime;

    procedure BufferData(const Table: TCosmosTables; FileName: string); overload;
    procedure BufferData(const FileName: string; Data: Olevariant); overload;
    function ChangePassword(const CurrentPassword: string): boolean;
    function IdenticacaoAtiva: TBooleanResult;
    procedure CloseConnection;
    function ConnectServer: boolean;
    procedure ReconnectServer;
    function CreateCommand: TDBXCommand;
    function CreateConnection(const ServerClass: TServerClass): TDSProviderConnection;
    function CreateReader(Dataset: TClientDataset): TDBXDataSetReader;
    procedure DropConnection(RemoteConnection: TDSProviderConnection);
    procedure DefaultExport(Dataset: TDataset);
    procedure DefaultLocate;
    function ExecuteDQL(const Search: TCosmosSearch; Params: Olevariant): TDataset;  overload;
    procedure ExecuteDQL(const Search: TCosmosSearch; Params: Olevariant; Dataset: TClientDataset); overload;
    function ExecuteRegisteredSearch(const SearchId: integer; Params: Olevariant): TDataset; overload;
    procedure ExecuteRegisteredSearch(const SearchId: integer; Params: Olevariant; ADataset: TClientDataset); overload;
    function GetAcessedFocus(const UserName: string; CosmosModule: TCosmosModules): TSQLDataset;
    function ExecuteCommand(const Command: TCosmosCommand; Params: Olevariant): boolean;
    function GetFotoCadastrado(const IdCadastrado: integer): TPicture; overload;
    function GetFotoCadastrado(ImageStream: TMemoryStream): TPicture; overload;
    function GetSequenceValue(const SequenceName: string): integer;
    procedure InsertDefaultData(const Dataset: TDataset; Data: TCosmosData);
    function ListData(const Search: TCosmosSearch; Params: Olevariant): TDBXReader;
    procedure LoadFieldsInfo(Dataset: TDataset);
    function OpenBufferedData(const BufferID: string): TClientDataset;
    function OpenTableData(const Table: TCosmosTables): string;
    procedure ProcessDBXError(E: TDBXError);
    function ReconcileError(E: EReconcileError; UpdateKind: TUpdateKind): TReconcileAction;
    procedure RegisterRemoteCallSucess(const RemoteMethod: string);
    procedure RegisterRemoteCallFailure(const Error, RemoteMethod: string);
    function ToClientDataset(Source: TCustomSQLDataset): TClientDataset; overload;
    procedure ToClientDataset(Source: TCustomSQLDataset; Target: TClientDataset); overload;
    function TestConnectedServer: boolean;

    property ActiveDataNavigator: TCustomDataNavigator read GetActiveDataNavigator write SetActiveDataNavigator;
    property ActiveDataset: TDataset read GetActiveDataset write SetActiveDataset;
    property CertificateData: TCosmosData read GetCertificateData;
    property Connected: boolean read GetConnected write SetConnected;
    property ConnectedServer: string read GetConnectedServer;
    property ConnectedPort: integer read GetConnectedPort;
    property ConnectedUser: string read GetConnectedUser;
    property ConnectedUserRoles: string read GetConnectedUserRoles;
    property ConnectionBroker: TDSProviderConnection read GetConnectionBroker;
    property ConnectionParamsInfo: string read GetConnectionParamsInfo;
    property CurrentConnectionMode: TConnectionMode read GetCurrentConnectionMode;
    property ConnectionProtocol: TConnectionProtocol read GetConnectionProtocol;
    property ConnectionStatusNotifier: IConnectionStatusObservable read GetConnectionStatusNotifier;
    property CurrentConnectionInfo: TCosmosSecurity read GetCurrentConnectionInfo;
    property CurrentUser: TCosmosUser read GetCurrentUser;
    property MonitorConnection: boolean read GetMonitorConnection write SetMonitorConnection;
    property RemoteHost: string read GetRemoteHost;
    property ServerDateTime: TDateTime read GetServerDateTime;

  public
    { Public declarations }
    procedure ApplyUpdates(Dataset: TClientDataset; MaxErrors: integer = 0);
    procedure CloseDataset(const Dataset: TDataset); inline;

    function GetRemoteHostName: string;

    property BufferDir: string read FBufferDir;
    property ConnectionType: TConnectionType read GetConnectionType default ctFixed;
    property ConnectionStatus: TConnectionStatus read FConnectionStatus write SetConnectionStatus;
    property ConnectionInfo: TCosmosData read FConnectionInfo;
    property ConnectionsPool: TDBXConnectionPool read FConnectionsPool;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property LockedByUser: boolean read FLockedByUser write FLockedByUser;
    property PooledConnection: boolean read GetPooledConnection;
    property Protocols: TProtocols read FProtocols write FProtocols;


  end;

var
  DMBase: TDMBase;

implementation

uses  cosmos.system.winshell, cosmos.common.view.dlgconnecting,
 cosmos.common.view.dlgnoserver, cosmos.common.view.LoginForm,
 cosmos.common.view.ChangePassword, cosmos.common.services.utilities;

{$R *.dfm}

{ TDM }

procedure TDMBase.DataModuleCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FCurrentConnectionInfo := TCosmosSecurity.Create;

 FConnectionInfo := TCosmosData.Create(20);
 FConnectedUserRoles := TStringList.Create;
 FConnectionObservable := TConnectionStatusObservable.Create;

 FRemoteProviders := TRemoteProvidersPool.Create;
 FConnTest := TConnectionTest.Create;

 //Encontra a pasta onde serão buferizados os dados.
 FBufferDir := ICosmosApp.IApplicationPaths.ReadBufferedDataPath;

 if not DirectoryExists(FBufferDir) then
   TShellFolders.CreateFolder(FBufferDir);
end;

procedure TDMBase.DataModuleDestroy(Sender: TObject);
begin
 if DBXConnection.Connected then
  begin
   DBXConnection.DBXConnection.OnErrorEvent := nil;
   DBXConnection.DBXConnection.OnTrace := nil;
   DBXConnection.Close;
  end;

 if Assigned(FICosmosApp) then  FICosmosApp := nil;
 if Assigned(FConnectionInfo) then FreeAndNil(FConnectionInfo);

 if Assigned(FConnectionsPool) then FreeAndNil(FConnectionsPool);


 if Assigned(FCurrentConnectionInfo) then  FreeAndNil(FCurrentConnectionInfo);

 FConnectionObservable.Free;

 FRemoteProviders.ClearAll;
 FRemoteProviders.Free;
end;

procedure TDMBase.DBXConnectionAfterConnect(Sender: TObject);
begin
 ConnectionStatus := csHostConnected;
 //Atribui um manipulador para erros do tipo TDBXError
 if Assigned(DBXConnection.DBXConnection) then
  DBXConnection.DBXConnection.OnErrorEvent := ProcessDBXError;

 TimerConnection.Enabled := ConnectionInfo.FindValue('NotifyMode') <> 'nmNoNotify'; //do not localize!!!
end;

procedure TDMBase.DBXConnectionAfterDisconnect(Sender: TObject);
begin
 {Com o uso do pool de conexões, este evento é disparado várias vezes. Por isso sempre
 é preciso testar se objetos estão instanciados, dado que esse evento mesmo destrói
 objetos quando é chamado pela primeira vez (primeira conexão do pool).}
 TimerConnection.Enabled := False;
 CloseConnectInfoDialog;

 if Assigned(DSProviderConnection.AfterDisconnect) then
  DSProviderConnection.AfterDisconnect(Sender);

 try
  if Assigned(CurrentUser) then
    ICosmosApp.MainLog.RegisterLog(Format(TCosmosLogs.DisconnectedUser, [CurrentUser.UserName]), ConnectionParamsInfo, leOnConnectClose);

 finally
  if Assigned(FCosmosCertificate) then FreeAndNil(FCosmosCertificate);
  if Assigned(CurrentConnectionInfo) then CurrentConnectionInfo.Reset;
  ConnectionStatus := csHostDisconnected;
 end;
end;

procedure TDMBase.DBXConnectionBeforeConnect(Sender: TObject);
begin
{Testa se há uma configuração de conexão definida nas configurações. Caso contrário,
exibe a tela de aviso e aborta o processo de conexão com o servidor remoto.}
 if Trim(ConnectionInfo.FindValue('CommunicationProtocol')) = '' then  //do not localize!
  begin
   ShowNoServerDialog;
   ConnectionStatus := csAborted;
   Abort;
  end
 else
  ConnectionStatus := csOnConnectingHost;
end;

procedure TDMBase.DBXConnectionBeforeDisconnect(Sender: TObject);
begin
 ConnectionStatus := csOnDisconnectingHost;

 if Assigned(DSProviderConnection.BeforeDisconnect) then
  DSProviderConnection.BeforeDisconnect(Sender);

 //Limpa o pool de TDSProviderConnection's.
 if Assigned(FRemoteProviders) then
  FRemoteProviders.ClearAll;
end;

procedure TDMBase.DBXConnectionValidatePeerCertificate(Owner: TObject;
  Certificate: TX509Certificate; const ADepth: Integer; var Ok: Boolean);
var
 aDate: TDateTime;
 sDate: string;
 CACertificate: boolean;
begin
 {Valida o certificado digital recebido do servidor.}
 Ok := (Assigned(FCosmosCertificate)) and (FCosmosCertificate.FindValue('Validated') = True);  //do not localize!

 if not Assigned(FCosmosCertificate) then
   ConnectionStatus := csCheckingCertificate;


 try
  if Assigned(Certificate) then
   begin
    if Assigned(FCosmosCertificate) then
     Exit;

    if (Certificate is  TX509CertificateIndy) and (ConnectionStatus <> csAborted) then
     begin
      //Verifica se o certificado é assinado por Autoridade Certificadora (CA).
      CACertificate := TX509CertificateIndy(Certificate).GetBasicConstraints >= 0;

      //Impede o uso de certificados auto-assinados.
      {if not CACertificate then
       begin
        Ok := False;
        raise Exception.Create('Error Message');
       end;}

      TX509CertificateIndy(Certificate).CheckValidity;
      Ok := TX509CertificateIndy(Certificate).Verify(TX509CertificateIndy(Certificate).GetPublicKey);

      if Ok then
       begin
        //Copia os dados do certificado válido para uma estrutura em memória.
        FCosmosCertificate := TCosmosData.Create(20);
        FCosmosCertificate.WriteValue('CertificateType', Certificate.GetType); //do not localize!
        FCosmosCertificate.WriteValue('SigAlgName', Certificate.GetSigAlgName, 1); //do not localize!
        FCosmosCertificate.WriteValue('Signature', Certificate.GetSignature, 2); //do not localize!
        FCosmosCertificate.WriteValue('IssuerX500Principal', Certificate.GetIssuerX500Principal.GetName, 3); //do not localize!
        FCosmosCertificate.WriteValue('PublicKey', Certificate.GetPublicKey.GetAlgorithm, 4); //do not localize!
        FCosmosCertificate.WriteValue('NotBefore', Certificate.GetNotBefore, 5); //do not localize!
        FCosmosCertificate.WriteValue('NotAfter', Certificate.GetNotAfter, 6); //do not localize!
        FCosmosCertificate.WriteValue('SerialNumber', Certificate.GetSerialNumber, 7); //do not localize!
        FCosmosCertificate.WriteValue('Owner', GetCertificateInfo(Certificate, ciOwner), 8); //do not localize!
        FCosmosCertificate.WriteValue('Website', GetCertificateInfo(Certificate, ciWebsite), 9); //do not localize!
        FCosmosCertificate.WriteValue('EmailAddress', GetCertificateInfo(Certificate, ciEmailAddress), 10); //do not localize!
        FCosmosCertificate.WriteValue('Country', GetCertificateInfo(Certificate, ciCountry), 11); //do not localize!
        FCosmosCertificate.WriteValue('State', GetCertificateInfo(Certificate, ciState), 12); //do not localize!
        FCosmosCertificate.WriteValue('City', GetCertificateInfo(Certificate, ciCity), 13); //do not localize!
        FCosmosCertificate.WriteValue('Validated', Ok, 14); //do not localize!
       end;
     end;
   end
   else //Certificado não encontrado... Somente para HTTPS ele é obrigatório.
    if Protocols = [cpHTTPS] then
     raise ECertificateNotFound.Create(TCosmosErrorMsg.CertificateNotFound);

 except
  on E: ECertificateExpiredException do //Período de validade do certificado é inválido.
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Security, TCosmosErrorMsg.CertificateExpired);
    ICosmosApp.MainLog.RegisterAuditFailure(TCosmosErrorMsg.CertificateExpired);
    AbortConnection;
   end;
  on E: ECertificateNotYetValidException do //Período de validade ainda não iniciado.
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Security, TCosmosErrorMsg.CertificateNotYetValid);
    ICosmosApp.MainLog.RegisterAuditFailure(TCosmosErrorMsg.CertificateNotYetValid);
    AbortConnection;
   end;
  on E: ECertificateNotFound do //O certificado não foi encontrado.
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Security, E.Message);
    ICosmosApp.MainLog.RegisterAuditFailure(TCosmosErrorMsg.CertificateNotFound);
    AbortConnection;
   end;
  else
   begin
    Ok := False;
    AbortConnection;
    raise;
   end;
 end;
end;

procedure TDMBase.DBXMonitorLogTrace(Sender: TObject; TraceInfo: TDBXTraceInfo);
var
  LogFileName: string;
begin
 if DBXMonitor.TraceCount = 1000 then
  begin
   LogFileName := NewMonitorFileName;
   DBXMonitor.SaveToFile(LogFileName);
   DBXMonitor.TraceList.Clear;
  end;
end;

procedure TDMBase.DBXMonitorTrace(Sender: TObject; TraceInfo: TDBXTraceInfo;
  var LogTrace: Boolean);
begin
 DBXMonitor.TraceList.Append(TraceInfo.Message);
end;

function TDMBase.GetAcessedFocus(const UserName: string;
   CosmosModule: TCosmosModules): TSQLDataset;
var
 ACommand: TDBXCommand;
begin
 //Lista os focos que um usuário pode acessar usando um módulo do Cosmos.
 ACommand := CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.GetAcessedFocus'; //do not localize!

  ACommand.Prepare;
  ACommand.Parameters[0].Value.SetWideString(UserName);
  ACommand.Parameters[1].Value.SetInt32(Ord(CosmosModule));

  ACommand.ExecuteUpdate;

  Result := TSQLDataSet.Create(nil, ACommand.Parameters[2].Value.GetDBXReader(False), True);
  Result.Open;

  ACommand.Free;

 except
  on E: TDBXError do
   begin
    Result := nil;
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.MainLog.RegisterError(E.Message);
   end;
  on E: Exception do
   begin
    Result := nil;
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
    ICosmosApp.MainLog.RegisterError(E.Message);
   end;
 end;
end;

function TDMBase.GetActiveDataNavigator: TCustomDataNavigator;
begin
 Result := FActiveDataNavigator;
end;

function TDMBase.GetActiveDataset: TDataset;
begin
 Result := FActiveDataset;
end;

function TDMBase.GetCertificateData: TCosmosData;
begin
 //Retorna os dados do certificado digital corrente na forma de uma estrutura TCosmosData.
 Result := FCosmosCertificate;
end;

function TDMBase.GetCertificateInfo(Certificate: TX509Certificate;
  Info: TCertificateInfo): string;
var
 sInfo: string;
 aStartIndex, aEndIndex: integer;
begin
{Retorna um dado específico de um certificado passado em parâmetro.}
 sInfo := Certificate.GetIssuerX500Principal.GetName;

 case Info of
   ciOwner:
    begin
     aStartIndex := sInfo.IndexOf('OU=');  //do not localize!
     sInfo := sInfo.Substring(aStartIndex);
     aEndIndex := sInfo.IndexOf('/CN=');  //do not localize!
     sInfo := sInfo.Remove(aEndIndex);
     sInfo := sInfo.Remove(0, 3);
     Result := sInfo;
    end;
   ciCountry:
    begin
     aStartIndex := sInfo.IndexOf('C=');  //do not localize!
     sInfo := sInfo.Substring(aStartIndex);
     aEndIndex := sInfo.IndexOf('/ST=');  //do not localize!
     sInfo := sInfo.Remove(aEndIndex);
     sInfo := sInfo.Remove(0, 2);
     Result := sInfo;
    end;
   ciState:
    begin
     aStartIndex := sInfo.IndexOf('ST='); //do not localize!
     sInfo := sInfo.Substring(aStartIndex);
     aEndIndex := sInfo.IndexOf('/L=');  //do not localize!
     sInfo := sInfo.Remove(aEndIndex);
     sInfo := sInfo.Remove(0, 3);
     Result := sInfo;
    end;
   ciCity:
    begin
     aStartIndex := sInfo.IndexOf('L='); //do not localize!
     sInfo := sInfo.Substring(aStartIndex);
     aEndIndex := sInfo.IndexOf('/O='); //do not localize!
     sInfo := sInfo.Remove(aEndIndex);
     sInfo := sInfo.Remove(0, 2);
     Result := sInfo;
    end;
   ciWebsite:
    begin
     aStartIndex := sInfo.IndexOf('CN='); //do not localize!
     sInfo := sInfo.Substring(aStartIndex);
     aEndIndex := sInfo.IndexOf('emailAddress'); //do not localize!
     sInfo := sInfo.Remove(aEndIndex);
     sInfo := sInfo.Remove(0, 3);
     Result := sInfo;
    end;
   ciEmailAddress:
    begin
     aStartIndex := sInfo.IndexOf('emailAddress=');  //do not localize!
     sInfo := sInfo.Substring(aStartIndex);
     sInfo := sInfo.Remove(0, 13);
     Result := sInfo;
    end;
 end;
end;

function TDMBase.GetConnected: boolean;
begin
 //Retorna se há conexão no momento.
  case ConnectionType of
    ctPooledOnDemand, ctPooledOnStart: Result := (FConnectionsPool <> nil) and (FConnectionsPool.Active);
    ctStateless: Result := (CurrentConnectionInfo <> nil) and (CurrentConnectionInfo.CurrentSection <> nil) and (CurrentConnectionInfo.CurrentSection.ConnectionID.Trim <> '');
    ctFixed: Result := Assigned(DBXConnection) and (DBXConnection.Connected);
  end;
end;

function TDMBase.GetConnectedPort: integer;
begin
//Retorna a porta do servidor remoto conectado.
 if ConnectionInfo <> nil then
  Result := ConnectionInfo.FindValue('Port')
 else
  Result := -1;
end;

function TDMBase.GetConnectedUserRoles: string;
begin
{Retorna, na forma de uma string com separador de valores ",", as roles atribuídas
 ao usuário da seção corrente.}
 if (FCurrentConnectionInfo <> nil) and (FCurrentConnectionInfo.CurrentUser <> nil) then
  Result := FConnectedUserRoles.CommaText
 else
  Result := '';
end;

function TDMBase.GetConnectedServer: string;
var
 sProtocol, sHost, sPort: string;
begin
 {Retorna o nome do servidor econfigurado para a conexão ou já conectado.}
 sProtocol := ConnectionInfo.FindValue('CommunicationProtocol');  //do not localize!
 sHost := ConnectionInfo.FindValue('HostName');  //do not localize!
 sPort := ConnectionInfo.FindValue('Port'); //do not localize!

 case ConnectionProtocol of
  cpTCP: Result := Result.Format('%s:%s', [sHost, sPort]);  //do not localize!
  cpHTTP, cpHTTPS: Result := Result.Format('%s://%s:%s', [sProtocol, sHost, sPort]); //do not localize!
 end;
end;

function TDMBase.GetConnectedUser: string;
begin
//Retorno o nome do usuário conectado.
 if (FCurrentConnectionInfo <> nil) and (FCurrentConnectionInfo.CurrentUser <> nil) then
  Result := FCurrentConnectionInfo.CurrentUser.UserName
 else
  Result := '';
end;

function TDMBase.GetConnectionBroker: TDSProviderConnection;
begin
 Result := DSProviderConnection;
end;

function TDMBase.GetConnectionType: TConnectionType;
begin
//Retorna o tipo de conexão usada na sessão corrente;
 if (ConnectionInfo <> nil) and (ConnectionInfo.FindValue('ConnectionType') <> null) then
  Result := TConnectionType(ConnectionInfo.FindValue('ConnectionType')) //do not localize!
 else
  Result := ctFixed; //default.
end;

function TDMBase.GetConnectionObject: TSQLConnection;
begin
 {Retorna um objeto de conexão. Com o uso do pool, retorna sempre um objeto
  de conexão do pool. Do contrário, retorna o objeto de conexão neste datamodule. }
 case ConnectionType of
   ctPooledOnDemand, ctPooledOnStart:
    begin
     if FConnectionsPool <> nil then
       Result := ConnectionsPool.GetConnection.Connection;
    end;
   ctStateless: Result := DoCreateConnection;
   ctFixed: Result := self.DBXConnection;
 end;
end;

function TDMBase.GetConnectionParamsInfo: string;
var
 AParams: TStringList;
begin
 {Retorna todos os parâmetros de conexão com o servidor remoto, excetuando-se
  a senha do usuário.}
 AParams := TStringList.Create;

 try
  case ConnectionType of
    ctPooledOnDemand, ctPooledOnStart:
       begin
        if Assigned(FConnectionsPool) then
          AParams.Assign(FConnectionsPool.Params);
       end;
    ctStateless: AParams.Assign(DBXConnection.Params);
    ctFixed: AParams.Assign(DBXConnection.Params);
  end;

  Result := AParams.CommaText;

 finally
  if Assigned(AParams) then FreeAndNil(AParams);
 end;
end;

function TDMBase.GetConnectionProtocol: TConnectionProtocol;
var
 sProtocol: string;
begin
 //Retorna o protocolo de conexão remoto que está sendo usado.
  sProtocol := sProtocol.LowerCase(ConnectionInfo.FindValue('CommunicationProtocol')) ;  //do not localize!

  if sProtocol = 'tcp/ip' then  //do not localize!
    Result := cpTCP
  else
  if sProtocol = 'http' then  //do not localize!
    Result := cpHTTP
  else
  if sProtocol = 'https' then //do not localize!
    Result := cpHTTPS
  else
    Result := cpTCP; //default
end;

function TDMBase.GetConnectionStatusNotifier: IConnectionStatusObservable;
begin
 Result := FConnectionObservable as IConnectionStatusObservable;
end;

function TDMBase.GetCurrentConnectionInfo: TCosmosSecurity;
begin
 Result := FCurrentConnectionInfo;
end;

function TDMBase.GetCurrentConnectionMode: TConnectionMode;
begin
 if (CurrentConnectionInfo <> nil) and (CurrentConnectionInfo.CurrentSection <> nil) then
  Result := CurrentConnectionInfo.CurrentSection.ConnectionMode
 else
  Result := cmRead;
end;

function TDMBase.GetCurrentUser: TCosmosUser;
begin
 if CurrentConnectionInfo <> nil then
  Result := CurrentConnectionInfo.CurrentUser
 else
  Result := nil;
end;

procedure TDMBase.GetDBXErrorMessages(const ErrorCode: integer; var Title, Message: string);
begin
 {Traduz as mensagens de erro disparadas por uma instância de TDBXError. Os erros
  deste tipo são mapeados com códigos diferentes. O que esse método faz é
  traduzir a mensagem de erro a partir do código de erro recebido.}

 case ErrorCode of
//--------Início da faixa de erros específica dos aplicativos Cosmos.--------
  TCosmosErrorCodes.ReativarTurmaTP:
   begin
    Title :=  TCosmosTitles.TurmasTP;
    Message := TCosmosErrorSecMsg.ReativarTurmaTP;
   end;
  TCosmosErrorCodes.EncerrarTurmaTP:
   begin
    Title :=  TCosmosTitles.TurmasTP;
    Message := TCosmosErrorSecMsg.EncerrarTurmaTP;
   end;
  TCosmosErrorCodes.IdentificaoAtiva:
   begin
    Title :=  TCosmosTitles.IdentificaoAtiva;
    Message := TCosmosErrorMsg.IdentificaoAtiva;
   end;
  TCosmosErrorCodes.CaixaFechar:
   begin
    Title :=  TCosmosTitles.Caixa;
    Message := TCosmosErrorFinMsg.CaixaFechar;
   end;
  TCosmosErrorCodes.CaixaNovo:
   begin
    Title :=  TCosmosTitles.Caixa;
    Message := TCosmosErrorFinMsg.CaixaNovo;
   end;
  TCosmosErrorCodes.MoveConta:
   begin
    Title :=  TCosmosTitles.PlanoContas;
    Message := TCosmosErrorFinMsg.MoveConta;
   end;
  TCosmosErrorCodes.DeleteConta:
   begin
    Title :=  TCosmosTitles.PlanoContas;
    Message := TCosmosErrorFinMsg.DeleteConta;
   end;
  TCosmosErrorCodes.DeleteContasUsadas:
   begin
    Title :=  TCosmosTitles.PlanoContas;
    Message := TCosmosErrorFinMsg.DeleteContasUsadas;
   end;
  TCosmosErrorCodes.DeleteContaSubcontas:
   begin
    Title :=  TCosmosTitles.PlanoContas;
    Message := TCosmosErrorFinMsg.DeleteContaSubcontas;
   end;
  TCosmosErrorCodes.DuplicatedMembroCirculoEI:
   begin
    Title :=  TCosmosTitles.CirculosEI;
    Message := TCosmosErrorSecMsg.DuplicatedMembroCirculoEI;
   end;
  TCosmosErrorCodes.DesativarCirculoEI:
   begin
    Title :=  TCosmosTitles.CirculosEI;
    Message := TCosmosErrorSecMsg.DesativarCirculoEI;
   end;
  TCosmosErrorCodes.NovoCirculoEI:
   begin
    Title :=  TCosmosTitles.CirculosEI;
    Message := TCosmosErrorSecMsg.NovoCirculoEI;
   end;
  TCosmosErrorCodes.DeleteBookEI:
   begin
    Title :=  TCosmosTitles.LivrosEI;
    Message := TCosmosErrorSecMsg.DeleteBookEI;
   end;
  TCosmosErrorCodes.CantDeleteBookEI:
   begin
    Title :=  TCosmosTitles.LivrosEI;
    Message := TCosmosErrorSecMsg.CantDeleteBookEI;
   end;
  TCosmosErrorCodes.ReorderLessonEI:
   begin
    Title :=  TCosmosTitles.LivrosEI;
    Message := TCosmosErrorSecMsg.ReorderLessonEI;
   end;
  TCosmosErrorCodes.ReorderBookEI:
   begin
    Title :=  TCosmosTitles.LivrosEI;
    Message := TCosmosErrorSecMsg.ReorderBookEI;
   end;
  TCosmosErrorCodes.CantDeleteLessonEI:
   begin
    Title :=  TCosmosTitles.LivrosEI;
    Message := TCosmosErrorSecMsg.CantDeleteLessonEI;
   end;
  TCosmosErrorCodes.DeleteLessonEI:
   begin
    Title :=  TCosmosTitles.LivrosEI;
    Message := TCosmosErrorSecMsg.DeleteLessonEI;
   end;
  TCosmosErrorCodes.NovaMatricula:
   begin
    Title :=  TCosmosTitles.ErrorSelectData;
    Message := TCosmosErrorSecMsg.NovaMatricula;
   end;
  TCosmosErrorCodes.AnularHistorico:
   begin
    Title :=  TCosmosTitles.HistoricoDiscipular;
    Message := TCosmosErrorSecMsg.AnularHistorico;
   end;
  TCosmosErrorCodes.InstalacaoInvalida:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosErrorSecMsg.InstalacaoInvalida;
   end;
  TCosmosErrorCodes.NovoInstalando:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosErrorSecMsg.NovoInstalando;
   end;
  TCosmosErrorCodes.DelMembroTurmaInstalacao:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosErrorSecMsg.DelMembroTurmaInstalacao;
   end;
  TCosmosErrorCodes.NumeroTurmaInstalacao:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosErrorSecMsg.NumeroTurmaInstalacao;
   end;
  TCosmosErrorCodes.ProtocoloAberto:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosInfoMsg.ProtocoloAberto;
   end;
  TCosmosErrorCodes.TurmaInstalada:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosErrorSecMsg.TurmaInstalada;
   end;
  TCosmosErrorCodes.InstalarTurmaAluno:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosErrorSecMsg.InstalarTurmaAluno;
   end;
  TCosmosErrorCodes.CreateTurmaInstalacao:
   begin
    Title :=  TCosmosTitles.TurmasInstalacao;
    Message := TCosmosErrorSecMsg.CreateTurmaInstalacao;
   end;
  TCosmosErrorCodes.ChangeTarefaAreaStaff:
   begin
    Title :=  TCosmosTitles.AreasStaff;
    Message := TCosmosErrorMsg.ChangeTarefaAreaStaff;
   end;
  TCosmosErrorCodes.CantCreateReader:
   begin
    Title :=  TCosmosTitles.SystemFailure;
    Message := TCosmosErrorMsg.CantCreateReader;
   end;
  TCosmosErrorCodes.ClonarAlojamento:
   begin
    Title :=  TCosmosTitles.Alojamentos;
    Message := TCosmosErrorMsg.ClonarAlojamento;
   end;
  TCosmosErrorCodes.CancelarInscricao:
   begin
    Title :=  TCosmosTitles.InscricoesConferencia;
    Message := TCosmosErrorMsg.CancelarInscricao;
   end;
  TCosmosErrorCodes.DelFlagInscricao:
   begin
    Title :=  TCosmosTitles.InscricoesConferencia;
    Message := TCosmosErrorMsg.DelFlagInscricao;
   end;
  TCosmosErrorCodes.SaveAreaStaff:
   begin
    Title :=  TCosmosTitles.AreasStaff;
    Message := TCosmosErrorMsg.SaveAreaStaff;
   end;
  TCosmosErrorCodes.DelAttribute:
   begin
    Title :=  TCosmosTitles.Classificadores;
    Message := TCosmosErrorMsg.DelAttribute;
   end;
  TCosmosErrorCodes.IlegalGrantRole:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.IlegalGrantRole;
   end;
  TCosmosErrorCodes.IlegalGrantUser:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.IlegalGrantUser;
   end;
  TCosmosErrorCodes.CreateUserAttributes:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.CreateUserAttributes;
   end;
  TCosmosErrorCodes.LoginAlreadyExists:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.LoginAlreadyExists;
   end;
  TCosmosErrorCodes.UnlockUser:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.UnlockUser;
   end;
  TCosmosErrorCodes.GrantAdministrator:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.GrantAdministrator;
   end;
  TCosmosErrorCodes.RevokePermission:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.RevokePermission;
   end;
  TCosmosErrorCodes.GrantPermission:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.GrantPermission;
   end;
  TCosmosErrorCodes.DeleteUser:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.DeleteUser;
   end;
  TCosmosErrorCodes.CreateUser:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.CreateUser;
   end;
  TCosmosErrorCodes.NumeroNovaTurmaTP:
   begin
    Title :=  TCosmosTitles.TurmasTP;
    Message := TCosmosErrorMsg.NumeroNovaTurmaTP;
   end;
  TCosmosErrorCodes.DeleteTurmaTP:
   begin
    Title :=  TCosmosTitles.TurmasTP;
    Message := TCosmosErrorMsg.DeleteTurmaTP;
   end;
  TCosmosErrorCodes.CantDeleteTurmaTP:
   begin
    Title :=  TCosmosTitles.TurmasTP;
    Message := TCosmosErrorMsg.CantDeleteTurmaTP;
   end;
  TCosmosErrorCodes.NovaTurmaTP:
   begin
    Title :=  TCosmosTitles.TurmasTP;
    Message := TCosmosErrorMsg.NovaTurmaTP;
   end;
  TCosmosErrorCodes.DadosCadastrado:
   begin
    Title :=  TCosmosTitles.SelectData;
    Message := TCosmosErrorMsg.DadosCadastrado;
   end;
  TCosmosErrorCodes.AuthenticateProcess:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.AuthenticateProcess;
   end;
  TCosmosErrorCodes.LockUser:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.LockUser;
   end;
  TCosmosErrorCodes.PasswordReset:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.PasswordReset;
   end;
  TCosmosErrorCodes.PasswordUpdate:
   begin
    Title :=  TCosmosTitles.Users;
    Message := TCosmosErrorMsg.PasswordUpdate;
   end;
  TCosmosErrorCodes.RetrogradacaoIlegal:
   begin
    Title :=  TCosmosTitles.RetrogradarCadastrado;
    Message := TCosmosErrorMsg.RetrogradacaoIlegal;
   end;
  TCosmosErrorCodes.CasarCasado:
   begin
    Title :=  TCosmosTitles.CasarCadastrados;
    Message := TCosmosErrorMsg.CasarCasado;
   end;
  TCosmosErrorCodes.BatizadoIdade:
   begin
    Title :=  TCosmosTitles.BatizarCadastrado;
    Message := TCosmosErrorMsg.BatizadoIdade;
   end;
  TCosmosErrorCodes.BatizadoDiscipulado:
   begin
    Title :=  TCosmosTitles.BatizarCadastrado;
    Message := TCosmosErrorMsg.BatizadoDiscipulado;
   end;
  TCosmosErrorCodes.BatizadoCampo:
   begin
    Title :=  TCosmosTitles.BatizarCadastrado;
    Message := TCosmosErrorMsg.BatizadoCampo;
   end;
  TCosmosErrorCodes.ExecuteOperation:
   begin
    Title :=  TCosmosTitles.SystemFailure;
    Message := TCosmosErrorMsg.ExecuteOperation;
   end;
  TCosmosErrorCodes.CadastradoDesligado:
   begin
    Title :=  TCosmosTitles.CadastradosSearch;
    Message := TCosmosErrorMsg.CadastradoDesligado;
   end;
  TCosmosErrorCodes.TransferenciaInvalidaPesquisador:
   begin
    Title :=  TCosmosTitles.TransferirCadastrado;
    Message := TCosmosErrorMsg.TransferenciaInvalidaPesquisador;
   end;
  TCosmosErrorCodes.TransferenciaInvalidaAluno:
   begin
    Title :=  TCosmosTitles.TransferirCadastrado;
    Message := TCosmosErrorMsg.TransferenciaInvalidaAluno;
   end;
  TCosmosErrorCodes.UnknownFocusType:
   begin
    Title :=  TCosmosTitles.SelectData;
    Message := TCosmosErrorMsg.UnknownFocusType;
   end;
  TCosmosErrorCodes.TransferenciaMesmoFoco:
   begin
    Title :=  TCosmosTitles.TransferirCadastrado;
    Message := TCosmosErrorMsg.TransferenciaMesmoFoco;
   end;
  TCosmosErrorCodes.CannotFindCadastrado:
   begin
    Title :=  TCosmosTitles.CadastradosSearch;
    Message := TCosmosErrorMsg.CannotFindCadastrado;
   end;
  TCosmosErrorCodes.GerarFrequenciaConferencia:
   begin
    Title :=  TCosmosTitles.ControleFrequencia;
    Message := TCosmosErrorMsg.GerarFrequenciaConferencia;
   end;
  TCosmosErrorCodes.FrequenciaComputada:
   begin
    Title :=  TCosmosTitles.ControleFrequencia;
    Message := TCosmosInfoMsg.FrequenciaComputada;
   end;
  TCosmosErrorCodes.AtualizarGruposTM:
   begin
    Title :=  TCosmosTitles.TM;
    Message := TCosmosErrorMsg.AtualizarGruposTM;
   end;
  TCosmosErrorCodes.CadastradosSearch:
   begin
    Title :=  TCosmosTitles.PesquisaDados;
    Message := TCosmosErrorMsg.CadastradosSearch;
   end;
  TCosmosErrorCodes.UnknownCosmosSearch:
   begin
    Title :=  TCosmosTitles.SystemFailure;
    Message := TCosmosErrorMsg.UnknownCosmosSearch;
   end;
  TCosmosErrorCodes.SelectSequenceData:
   begin
    Title :=  TCosmosTitles.SystemFailure;
    Message := TCosmosErrorMsg.SelectSequenceData;
   end;
  TCosmosErrorCodes.ExecuteCommand:
   begin
    Title :=  TCosmosTitles.SystemFailure;
    Message := TCosmosErrorMsg.ExecuteCommandUser;
   end;
  TCosmosErrorCodes.ExecuteScript:
   begin
    Title :=  TCosmosTitles.ExecuteScript;
    Message := TCosmosErrorMsg.ExecuteScript;
   end;
  TCosmosErrorCodes.CannotFindCentralPesquisaCmd:
   begin
    Title :=  TCosmosTitles.CentralPesquisas;
    Message := TCosmosErrorMsg.CannotFindCentralPesquisaCmd;
   end;
  TCosmosErrorCodes.CannotOpenFileCentralPesquisa:
   begin
    Title :=  TCosmosTitles.CentralPesquisas;
    Message := TCosmosErrorMsg.CannotOpenFileCentralPesquisaUser;
   end;
  TCosmosErrorCodes.OpenFocusUnknownModule:
   begin
    Title :=  TCosmosTitles.OpenFocus;
    Message := TCosmosErrorMsg.OpenFocusUnknownModule;
   end;
  TCosmosErrorCodes.EscalarFalecido:
   begin
    Title :=  TCosmosTitles.Escalas;
    Message := TCosmosErrorMsg.EscalarFalecido;
   end;
  TCosmosErrorCodes.CadastradoFalecido:
   begin
    Title :=  TCosmosTitles.DataValidation;
    Message := TCosmosErrorMsg.CadastradoFalecido;
   end;
  TCosmosErrorCodes.InvalidEscaladoConferencia:
   begin
    Title :=  TCosmosTitles.Escalas;
    Message := TCosmosErrorMsg.EscalaConferenciaInvalida;
   end;
  TCosmosErrorCodes.SelectData:
   begin
    Title :=  TCosmosTitles.ErrorSelectData;
    Message := TCosmosErrorMsg.SelectData;
   end;
  TCosmosErrorCodes.EmptyDataset:
   begin
    Title :=  TCosmosTitles.ErrorSelectData;
    Message := TCosmosErrorMsg.EmptyDataset;
   end;
  TCosmosErrorCodes.InvalidSearchParams:
   begin
    Title :=  TCosmosTitles.SystemFailure;
    Message := TCosmosErrorMsg.InvalidSearchParams;
   end;
  TCosmosErrorCodes.IndyHostNotFound:
   begin
    Title :=  TCosmosTitles.ServerConection;
    Message := TCosmosErrorMsg.HostNotFound;
   end;

   //--------Início da faixa de códigos do dbExpress.--------

  TDBXErrorCodes.InvalidUserOrPassword, 0: //Autenticação incorreta (12 e 0)
   begin
    Title := TCosmosTitles.Autentication;
    Message := TCosmosErrorMsg.LoginFailure;
   end;
  TDBXErrorCodes.NoMemory: Message := TCosmosErrorMsg.DBXNoMemory ; //Falta de memória
  TDBXErrorCodes.ConnectionFailed: Message := TCosmosErrorMsg.DBXConnectionFailed; //Falha de conexão
  TDBXErrorCodes.ServerMethodFailed: Message := TCosmosErrorMsg.DBXServerMethodFailed; //Falha de chamada a um método remoto
  TDBXErrorCodes.AuthorizationFailed: //Autorização negada
   begin
    Title := TCosmosTitles.Permissoes;
    Message := TCosmosErrorMsg.DBXDeniedAuthorization
   end
  else
   Message := TCosmosErrorMsg.DBXUnknown;
 end;

 //Se o título da mensagem napeada não foi encontrada, usa o padrão.
 if Title = '' then
  Title := TCosmosTitles.SystemFailure;
end;

function TDMBase.DoCreateConnection: TSQLConnection;
begin
  if not Assigned(FConnectionsPool) then
    begin
      //Cria e configura a conexão pool de conexões.
       FConnectionsPool :=  TDBXConnectionPool.Create(1, ConnectionInfo.FindValue('CleanupMinutes'), ConnectionInfo.FindValue('PoolTimeout'), DBXConnection.Params);
       FConnectionsPool.PoolGrowth := pgStatelessMode;
       //Configura as demais propriedades do pool.
       FConnectionsPool.CommandText := 'TDMCosmosApplicationServer.PingServer';   //do not localize!
       FConnectionsPool.ValidatePeerCertificate := DBXConnection.ValidatePeerCertificate;
       FConnectionsPool.BeforeConnect := DBXConnection.BeforeConnect;
       FConnectionsPool.AfterConnect := DBXConnection.AfterConnect;
       FConnectionsPool.BeforeDisconnect:= DBXConnection.BeforeDisconnect;
       FConnectionsPool.AfterDisconnect := DBXConnection.AfterDisconnect;
       FConnectionsPool.OnErrorEvent := ProcessDBXError;
      // FConnectionsPool.OnRegisterEvent := ICosmosApp.MainLog.RegisterLog;
       FConnectionsPool.CreateConnectionPool;
    end;

 Result := ConnectionsPool.GetConnection.Connection;

{ Result := TSQLConnection.Create(self);
 Result.DriverName := 'DataSnap';
 Result.Params.Clear;
 Result.Params.AddStrings(DBXConnection.Params);
 Result.LoginPrompt := False;

 Result.ValidatePeerCertificate := DBXConnection.ValidatePeerCertificate;
 Result.BeforeConnect := DBXConnection.BeforeConnect;
 Result.AfterConnect := DBXConnection.AfterConnect;
 Result.BeforeDisconnect:= DBXConnection.BeforeDisconnect;
 Result.AfterDisconnect := DBXConnection.AfterDisconnect;

 try
  Result.Open;
  Result.DBXConnection.OnErrorEvent :=  ProcessDBXError;

 except
  on E: Exception do
   begin
     raise;
   end;
 end;}
end;

function TDMBase.GetFotoCadastrado(ImageStream: TMemoryStream): TPicture;
var
 APicture: TPicture;
begin
 //Retorna um objeto TPicture contendo a foto de um cadastrado.
 APicture := TPicture.Create;

 try
  TGraphicUtilities.LoadPictureFromStream(ImageStream, APicture);
  Result := APicture;

 except
  raise;
 end;
end;

function TDMBase.GetMonitorConnection: boolean;
begin
 Result := DBXMonitor.Active;
end;

function TDMBase.GetPooledConnection: boolean;
begin
{Vê se a conexão usa um pool de conexões.}
 Result := ConnectionType in [ctPooledOnDemand, ctPooledOnStart];
end;

function TDMBase.GetFotoCadastrado(const IdCadastrado: integer): TPicture;
var
  ACommand: TDBXCommand;
  AStream: TStream;
  AMemoryStream: TMemoryStream;
  AData: Olevariant;
begin
  //Busca a foto de um cadastrado e retorna um objeto TPicture.
  Result := nil;
  ACommand := CreateCommand;

  try
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TDMCosmosApplicationServer.GetFotoCadastrado';  //do not localize!
    ACommand.Prepare;
    ACommand.Parameters[0].Value.SetInt32(IdCadastrado);
    ACommand.ExecuteUpdate;
    {Os dados são retornados em um variant e não stream devido a uma falha do datsnap.
     Veja notas sobre esse assunto na declaração do método no servidor.}
    AData := ACommand.Parameters[1].Value.AsVariant;

    if AData <> null then
      begin
       AMemoryStream := TDataConverter.OleVariantToMemoryStream(AData);
       Result := TGraphicUtilities.LoadPictureFromStream(AMemoryStream);
      end
    else
     Result := nil;

    RegisterRemoteCallSucess(ACommand.Text);
    AStream.Free;
    AMemoryStream.Free;
    ACommand.Free;

  except
    on E: Exception do
    begin
      RegisterRemoteCallFailure(E.Message, ACommand.Text);
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorSecMsg.LoadPhotoPupil);
      if Assigned(AStream) then FreeAndNil(AStream);
      if Assigned(AMemoryStream) then FreeAndNil(AMemoryStream);
      if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
  end;
end;

function TDMBase.GetRemoteHost: string;
begin
 if Connected then
  Result := ConnectedServer
 else
  Result := '';
end;

function TDMBase.GetRemoteHostName: string;
begin
 if Connected then
  Result := ConnectionInfo.FindValue('HostName')  //do not localize!
 else
  Result := '';
end;

procedure TDMBase.CreateFieldsInfo;
var
  ACommand: TDBXCommand;
  AStream: TStream;
begin
  //Busca no servidor o arquivo XML que possui informações sobre os fields dos datasets.
  ACommand := CreateCommand;

  try
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TDMCosmosApplicationServer.GetFieldsInfo';  //do not localize!
    ACommand.Prepare;
    ACommand.ExecuteUpdate;
    AStream := ACommand.Parameters[0].Value.GetStream(True);

    XMLFieldsInfo.LoadFromStream(AStream, xetUTF_8);

    RegisterRemoteCallSucess(ACommand.Text);
    ACommand.Free;

  except
    on E: Exception do
    begin
      if Assigned(AStream) then FreeAndNil(AStream);
      RegisterRemoteCallFailure(E.Message, ACommand.Text);
      if Assigned(ACommand) then FreeAndNil(ACommand);
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
    end;
  end;
end;

function TDMBase.CreateReader(Dataset: TClientDataset): TDBXDataSetReader;
begin
 Result := TDBXDataSetReader.Create(Dataset);
end;

function TDMBase.GetSequenceValue(const SequenceName: string): integer;
var
 ACommand: TDBXCommand;
begin
//Obtém o valor de retorno de uma Sequence do servidor SQL.
   ACommand := CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.GetSequenceValue'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetWideString(SequenceName);
   ACommand.ExecuteUpdate;
   Result := ACommand.Parameters[1].Value.GetInt32;

   RegisterRemoteCallSucess(ACommand.Text);
   ACommand.Free;

 except
  on E: Exception do
   begin
    Result := null;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

function TDMBase.GetServerClassName(ServerClass: TServerClass): string;
begin
{Retorna o nome da classe remoto que será configurada para acesso aos dataset providers.}
 case ServerClass of
   scCommon: Result := 'TDMCosmosApplicationServer'; //do not localize!
   scLogradouros: Result := 'TDMCosmosServerLogradouros'; //do not localize!
   scLectorium, scMocidade: Result := 'TDMSecLectoriumServerMethods'; //do not localize!
   scPesquisadores: Result := 'TCosmosSecTPServerMethods'; //do not localize!
   scEscolaInterna: Result := 'TCosmosSecEIServerMethods'; //do not localize!
   scAtividades: Result := 'TDMSecAtividadesServerMethods'; //do not localize!
   scHistorico: Result := 'TCosmosSecHistoricoServerMethods'; //do not localize!
   scUsuarios: Result := 'TDMUserMethods'; //do not localize!
   scConferencias: Result := 'TDMCosmosConferenciasMethods'; //do not localize!
   scFinanceiro: Result := 'TDMFinanceiroMethods'; //do not localize!
   scFocos: Result := 'TDMCosmosFocosMethods'; //do not localize!
 end;
end;

function TDMBase.GetServerDateTime: TDateTime;
var
 ACommand: TDBXCommand;
begin
//Retorna a data e hora corrente no computador onde a aplicação servidora está
//rodando.
 ACommand := CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.GetServerDateTime'; //do not localize!
   ACommand.Prepare;

   ACommand.ExecuteUpdate;
   Result := ACommand.Parameters[0].Value.AsDateTime;
   RegisterRemoteCallSucess(ACommand.Text);

   ACommand.Free;

 except
  on E: Exception do
   begin
    Result := now; //Retorna a hora local.
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

function TDMBase.HasNewerVersion(const Table: TCosmosTables): boolean;
var
 ACommand: TDBXCommand;
 vServerTableVersion: integer;
 aDataset: TClientDataset;
 sFileName, sFilter, sTableId: string;
 FCosmosAppInfo: TCosmosAppInfo;
begin
 {Verifica no servidor remoto se existe uma versão mais atualizada de uma tabela
 buferizada no lado cliente.}
 ACommand := self.CreateCommand;
 aDataset := TClientDataset.Create(self);
 FCosmosAppInfo := TCosmosAppInfo.Create;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.GetTableVersion'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(Ord(Table));
   ACommand.ExecuteUpdate;

   vServerTableVersion := ACommand.Parameters[1].Value.GetInt32;
   RegisterRemoteCallSucess(ACommand.Text);

   //Abre o arquivo local de versões de tabelas buferizadas.
   sFileName := FCosmosAppInfo.ReadCommonAppDataPath + TCosmosFiles.Buftab;
   aDataset.LoadFromFile(sFileName);

   //Monta o filtro a ser usado para encontrar a tabela recebida em parâmetro.
   sTableId := TCosmosTablesInfo.GetCosmosTablesId(Table);
   sFilter := 'SIGTAB = ' + sTableId.QuotedString; //do not localize!
   aDataset.Filter := sFilter;
   aDataset.Filtered := True;

   //Finalmente, compara o número de versão local com o recebido do servidor.
   Result :=  vServerTableVersion <> aDataset.FieldValues['versao']; //do not localize!

   if Result then
     UpdateBufferedTablesControlFile(Table, vServerTableVersion);

   ACommand.Free;
   aDataset.Free;
   FCosmosAppInfo.Free;

 except
  on E: Exception do
   begin
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(aDataset) then FreeAndNil(aDataset);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TDMBase.IdenticacaoAtiva: TBooleanResult;
var
 ACommand: TDBXCommand;
 sPassword: string;
begin
 //Realiza o processo de identificação ativa de um usuário.
 FrmChangePassword := TFrmChangePassword.Create(self);

  try
   if FrmChangePassword.DoIdentificacaoAtiva(CurrentConnectionInfo.CurrentUser.Login) then
     sPassword := FrmChangePassword.EdtNewPassword.Text
   else
     Result := rmCanceled;

  finally
   if Assigned(FrmChangePassword) then
    FreeAndNil(FrmChangePassword);
  end;


  if sPassword <> '' then
   begin
    ACommand := CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMCosmosApplicationServer.DoIdentificacaoAtiva'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetWideString(CurrentConnectionInfo.CurrentUser.Login);
     ACommand.Parameters[1].Value.SetWideString(sPassword);
     ACommand.ExecuteUpdate;

     if ACommand.Parameters[2].Value.GetBoolean then
       Result := rmSucess
     else
       Result := rmUnsucess;

     RegisterRemoteCallSucess(ACommand.Text);
     ACommand.Free;

    except
     on E: Exception do
      begin
       Result := rmFailure;
       RegisterRemoteCallFailure(E.Message, ACommand.Text);
       if Assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
      end;
     end;
   end;
 end;

procedure TDMBase.InsertDefaultData(const Dataset: TDataset; Data: TCosmosData);
var
I: integer;
AFieldName: string;
Field: TField;
begin
{Insere os valores padrões de campos de um dataset.}
 if (Dataset <> nil) and (Data <> nil) then
  begin
   if Dataset.Active then
    begin
     if Dataset.State = dsBrowse then
      Dataset.Insert;

     for I := 0 to Pred(Data.DataCount) do
      begin
       if Data.FindFieldName(I) <> null then
        begin
         AFieldName := Data.FindFieldName(I);
         Field := Dataset.FindField(AFieldName);
         if Field <> nil then
          Field.Value := Data.FindValue(AFieldName);
        end;
      end;
    end;
  end;
end;

function TDMBase.ListData(const Search: TCosmosSearch;
  Params: Olevariant): TDBXReader;
var
 ACommand: TDBXCommand;
begin
{Executa uma pesquisa do Cosmos no banco de dados remoto. Neste método, os
 dados são retornados na forma de um objeto TDBXReader, não adqueado para
 ser utilizado em controles "dataware". Contudo, muito adequado para listar
 informações em combobox, por exemplo.}
 Screen.Cursor := crHourglass;
 ACommand := CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.ListData'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(Ord(Search));
  ACommand.Parameters[1].Value.AsVariant := Params;
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[2].Value.GetDBXReader(False);
  RegisterRemoteCallSucess(ACommand.Text);

  ACommand.Free;
  Screen.Cursor := crDefault;

 except
  on E: Exception do
   begin
    Screen.Cursor := crDefault;
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
    raise;
   end;
 end;
end;

procedure TDMBase.LoadFieldsInfo(Dataset: TDataset);
var
 AFieldsInfoReader: TFieldsInfoReader;
begin
{Obtém as configurações de exibição de campos de um dataset.}
  AFieldsInfoReader := TFieldsInfoReader.Create(XMLFieldsInfo);

  try
   AFieldsInfoReader.ReadDatasetFieldsInfo(Dataset);
   if Assigned(AFieldsInfoReader) then FreeAndNil(AFieldsInfoReader);

  except
   if Assigned(AFieldsInfoReader) then FreeAndNil(AFieldsInfoReader);
   raise;
  end;
end;

procedure TDMBase.LoadServers;
var
I, ProtocolOrd, NotifyOrd: integer;
sCosmosModule: string;
AXMLDoc: TXMLDocument;
ANode, AChildNode: IXMLNode;
AProtocol: TConnectionProtocol;
ANotifyMode: TNotifyMode;
begin
{Carrega as configurações de conexão remota que existem em um arquivo de
 configuração. Escolhe o protocolo de conexão a ser usado.}
 AXMLDoc := TXMLDocument.Create(self);
 AXMLDoc.FileName := ICosmosApp.IApplicationPaths.GetUserConfigurationsFile;

 AXMLDoc.Active := True;

 Protocols := [];

 try
  //Obtém os servidores configurados para o usuário corrente.
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('CosmosServers'); //do not localize!
  ANode := ANode.ChildNodes.FindNode('ServersInfo');  //do not localize!

  ConnectionInfo.ClearData;
  sCosmosModule := ICosmosApp.CosmosModuleShortName;

  for I := 0 to Pred(ANode.ChildNodes.Count) do
   begin
    AChildNode := ANode.ChildNodes.Get(I);

    if (AChildNode <> nil) and (AChildNode.Attributes['CosmosApp'] = sCosmosModule) then  //do not localize!
     begin
      //Se a conexão estiver desabilitada, não insere as configurações nos objetos.
      if AChildNode.Attributes['Enabled'] = False then //do not localize!
       Continue;

      ProtocolOrd := AChildNode.Attributes['CommunicationProtocol'];  //do not localize!
      AProtocol := TConnectionProtocol(ProtocolOrd);

      NotifyOrd := AChildNode.Attributes['NotifyMode']; //do not localize!
      ANotifyMode := TNotifyMode(NotifyOrd);

      case ANotifyMode of
        nmNotify: ConnectionInfo.WriteValue('NotifyMode', 'nmNotify', 12); //do not localize!
        nmNoNotify: ConnectionInfo.WriteValue('NotifyMode', 'nmNoNotify', 12);  //do not localize!
        nmRegisterLog: ConnectionInfo.WriteValue('NotifyMode', 'nmRegisterLog', 12); //do not localize!
      end;

      case AProtocol of
      cpTCP:
       begin
        if not (cpTCP in Protocols) then
         Protocols := Protocols + [cpTCP];

        ConnectionInfo.WriteValue('CommunicationProtocol', 'tcp/ip'); //do not localize!
        ConnectionInfo.WriteValue('HostName', AChildNode.Attributes['Host'], 1); //do not localize!
        ConnectionInfo.WriteValue('Port', AChildNode.Attributes['Port'], 2);  //do not localize!
        ConnectionInfo.WriteValue('Enabled', AChildNode.Attributes['Enabled'], 3); //do not localize!
        ConnectionInfo.WriteValue('BufferKBSize', AChildNode.Attributes['BufferKBSize'], 4);  //do not localize!
        ConnectionInfo.WriteValue('ConnectTimeout', AChildNode.Attributes['ConnectTimeout'], 5);  //do not localize!
        ConnectionInfo.WriteValue('CommunicationTimeout', AChildNode.Attributes['CommunicationTimeout'], 6);  //do not localize!
        ConnectionInfo.WriteValue('ProxyHost', AChildNode.Attributes['ProxyHost'], 7); //do not localize!
        ConnectionInfo.WriteValue('ProxyPort', AChildNode.Attributes['ProxyPort'], 8); //do not localize!

        if Trim(AChildNode.Attributes['ProxyUsername']) <> '' then  //do not localize!
         ConnectionInfo.WriteValue('ProxyUsername', ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyUsername']), 9)  //do not localize!
        else
         ConnectionInfo.WriteValue('ProxyUsername', AChildNode.Attributes['ProxyUsername'], 9);  //do not localize!

        if Trim(AChildNode.Attributes['ProxyPassword']) <> '' then
         ConnectionInfo.WriteValue('ProxyPassword', ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyPassword']), 10) //do not localize!
        else
         ConnectionInfo.WriteValue('ProxyPassword', AChildNode.Attributes['ProxyPassword'], 10); //do not localize!

        Break;
       end;
       //----------End TCP---------------------
      cpHTTP:
       begin
        if not (cpHTTP in Protocols) then
         Protocols := Protocols + [cpHTTP];

        ConnectionInfo.WriteValue('CommunicationProtocol', 'http');  //do not localize!
        ConnectionInfo.WriteValue('HostName', AChildNode.Attributes['Host'], 1);  //do not localize!
        ConnectionInfo.WriteValue('Port', AChildNode.Attributes['Port'], 2);  //do not localize!
        ConnectionInfo.WriteValue('Enabled', AChildNode.Attributes['Enabled'], 3);   //do not localize!
        ConnectionInfo.WriteValue('PingInterval', AChildNode.Attributes['PingInterval'], 4); //do not localize!
        ConnectionInfo.WriteValue('ConnectTimeout', AChildNode.Attributes['ConnectTimeout'], 5);  //do not localize!
        ConnectionInfo.WriteValue('DatasnapContext', AChildNode.Attributes['DatasnapContext'], 6); //do not localize!
        ConnectionInfo.WriteValue('ProxyHost', AChildNode.Attributes['ProxyHost'], 7); //do not localize!
        ConnectionInfo.WriteValue('ProxyPort', AChildNode.Attributes['ProxyPort'], 8); //do not localize!

        if Trim(AChildNode.Attributes['ProxyUsername']) <> '' then  //do not localize!
         ConnectionInfo.WriteValue('ProxyUsername', ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyUsername']), 9) //do not localize!
        else
         ConnectionInfo.WriteValue('ProxyUsername', AChildNode.Attributes['ProxyUsername'], 9); //do not localize!

        if Trim(AChildNode.Attributes['ProxyPassword']) <> '' then //do not localize!
         ConnectionInfo.WriteValue('ProxyPassword', ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyPassword']), 10) //do not localize!
        else
         ConnectionInfo.WriteValue('ProxyPassword', AChildNode.Attributes['ProxyPassword'], 10); //do not localize!

        ConnectionInfo.WriteValue('ProxyByPass', AChildNode.Attributes['ProxyByPass'], 11); //do not localize!
        ConnectionInfo.WriteValue('URLPath', AChildNode.Attributes['Host'], 12);   //do not localize!
        ConnectionInfo.WriteValue('BufferKBSize', AChildNode.Attributes['BufferKBSize'], 13);  //do not localize!

        Break;
       end;
       //----------End HTTP---------------------
      cpHTTPS:
       begin
        if not (cpHTTPS in Protocols) then
          Protocols := Protocols + [cpHTTPS];

        ConnectionInfo.WriteValue('CommunicationProtocol', 'https'); //do not localize!
        ConnectionInfo.WriteValue('HostName', AChildNode.Attributes['Host'], 1);  //do not localize!
        ConnectionInfo.WriteValue('Port', AChildNode.Attributes['Port'], 2); //do not localize!
        ConnectionInfo.WriteValue('Enabled', AChildNode.Attributes['Enabled'], 3); //do not localize!
        ConnectionInfo.WriteValue('PingInterval', AChildNode.Attributes['PingInterval'], 4);  //do not localize!
        ConnectionInfo.WriteValue('ConnectTimeout', AChildNode.Attributes['ConnectTimeout'], 5);  //do not localize!
        ConnectionInfo.WriteValue('DatasnapContext', AChildNode.Attributes['DatasnapContext'], 6); //do not localize!
        ConnectionInfo.WriteValue('ProxyHost', AChildNode.Attributes['ProxyHost'], 7); //do not localize!
        ConnectionInfo.WriteValue('ProxyPort', AChildNode.Attributes['ProxyPort'], 8); //do not localize!

        if Trim(AChildNode.Attributes['ProxyUsername']) <> '' then //do not localize!
         ConnectionInfo.WriteValue('ProxyUsername', ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyUsername']), 9) //do not localize!
        else
         ConnectionInfo.WriteValue('ProxyUsername', AChildNode.Attributes['ProxyUsername'], 9); //do not localize!

        if Trim(AChildNode.Attributes['ProxyPassword']) <> '' then //do not localize!
         ConnectionInfo.WriteValue('ProxyPassword', ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyPassword']), 10) //do not localize!
        else
         ConnectionInfo.WriteValue('ProxyPassword', AChildNode.Attributes['ProxyPassword'], 10); //do not localize!

        ConnectionInfo.WriteValue('ProxyByPass', AChildNode.Attributes['ProxyByPass'], 11); //do not localize!
        ConnectionInfo.WriteValue('URLPath', AChildNode.Attributes['Host'], 12); //do not localize!
        ConnectionInfo.WriteValue('BufferKBSize', AChildNode.Attributes['BufferKBSize'], 13);  //do not localize!
        ConnectionInfo.WriteValue('CommunicationTimeout', AChildNode.Attributes['CommunicationTimeout'], 14); //do not localize!

        Break;
       end;
       //----------End HTTPS---------------------
     end; //end case
    end; //end ChildNode <> nil
   end;//end for

  //Obtém os dados de configuração de pool de conexão.
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('ConnectionsPool'); //do not localize!
  ANode := ANode.ChildNodes.FindNode('PoolInfo');  //do not localize!

  for I := 0 to Pred(ANode.ChildNodes.Count) do
   begin
    AChildNode := ANode.ChildNodes.Get(I);

    if (AChildNode <> nil) and (AChildNode.Attributes['CosmosApp'] = sCosmosModule) then  //do not localize!
     begin
      ConnectionInfo.WriteValue('PoolSize', AChildNode.Attributes['PoolSize'], 15);  //do not localize!
      ConnectionInfo.WriteValue('CleanupMinutes', AChildNode.Attributes['CleanupMinutes'], 16);  //do not localize!
      ConnectionInfo.WriteValue('PoolTimeout', AChildNode.Attributes['PoolTimeout'], 17);  //do not localize!
      ConnectionInfo.WriteValue('ConnectionType', AChildNode.Attributes['ConnectionType'], 18);  //do not localize!
      Break;
     end;
   end;

 finally
  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);
 end;
end;

function TDMBase.LoginDialog(var UserName, Password: string): boolean;
begin
//Exibe a janela de autenticação do sistema.
 FrmLogin := TFrmLogin.Create(nil);

 try
   FrmLogin.XPStyle := True;
   Result := FrmLogin.Login(UserName, Password);

 finally
  if Assigned(FrmLogin) then FreeAndNil(FrmLogin);
 end;
end;

function TDMBase.NewMonitorFileName: string;
var
 sDateTime: string;
begin
 //Gera um novo nome de arquivo de log de monitormento da conexão.
 Result := ICosmosApp.CosmosModuleShortName;
 DateTimeToString(sDateTime, 'yyyymmddsszzz', Now); //do not localize!
 Result := Result + sDateTime + '.log';
end;

function TDMBase.OpenBufferedData(const BufferID: string): TClientDataset;
var
 AFileName: string;
 ADataset: TClientDataset;
begin
//Abre uma tabela bufferizada no cliente.
 ADataset := TClientDataset.Create(nil);

 try
  AFileName := BufferDir + '\' + BufferID;

  if FileExists(AFileName) then
   begin
    ADataset.FileName := AFileName;
    ADataset.Open;
    self.LoadFieldsInfo(ADataset);
    ADataset.First;
    Result := ADataset;
   end
  else
   Result := nil;

 except
  on E: Exception do
   begin
    Result := nil;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SelectData);
    ICosmosApp.MainLog.RegisterError(E.Message);
   end;
 end;
end;

function TDMBase.OpenTableData(const Table: TCosmosTables): string;
var
 ACommand: TDBXCommand;
begin
{Retorna o nome de um DatasetProvider a partir de uma tabela mapeada do
sistema Cosmos.}
 ACommand := CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.GetTableProviderName'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(Ord(Table));
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[1].Value.GetWideString;
  RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := '';
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.Execute(E.Message);
   end;
 end;
end;

function TDMBase.PasswordIsTemporary(const UserName: string): boolean;
var
 ACommand: TDBXCommand;
begin
 //Checa se a senha de um usuário é provisória...
 FConnectedUserRoles.Clear;
 ACommand := CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.PasswordIsTemporary'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetWideString(UserName);
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.GetBoolean;
   RegisterRemoteCallSucess(ACommand.Text);
   ACommand.Free;


 except
  on E: Exception do
   begin
    RegisterRemoteCallFailure(E.Message,  ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise;
   end;
 end;
end;

procedure TDMBase.ProcessDBXError(E: TDBXError);
var
 ATitle, AMessage: string;
begin
{Processa um erro do tipo TDBXError para exibir mensagens específicas, mais
 adequadas para o entendimento do usuário do sistema.}
 AMessage := E.Message;
 GetDBXErrorMessages(E.ErrorCode, ATitle, AMessage);
 ICosmosApp.DlgMessage.ErrorMessage(ATitle, AMessage);
end;

procedure TDMBase.ReadUserRoles(const UserName: string);
var
 ACommand: TDBXCommand;
begin
 //Busca no servidor as roles atribuídas a um usuário.
 FConnectedUserRoles.Clear;
 ACommand := CreateCommand;
 ACommand.CommandTimeout := 1;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.ReadUserRoles'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetWideString(UserName);
   ACommand.ExecuteUpdate;

   FConnectedUserRoles.CommaText := ACommand.Parameters[1].Value.GetWideString;
   RegisterRemoteCallSucess(ACommand.Text);
   ACommand.Free;


 except
  on E: Exception do
   begin
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise;
   end;
 end;
end;

function TDMBase.ReconcileError(E: EReconcileError;
  UpdateKind: TUpdateKind): TReconcileAction;
begin
 RegisterRemoteCallFailure(E.Message, TCosmosTitles.UpdateData);

 if E.Message.Trim <> '' then
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.UpdateData, E.Message);

 Result := raCancel;
end;

procedure TDMBase.ReconnectServer;
var
 sCurrentUser, sCurrentPassword: string;
begin
 sCurrentUser := CurrentConnectionInfo.CurrentUser.Login;
 sCurrentPassword := '';

 try
  DoConnectServer(sCurrentUser, sCurrentPassword)

 except
   raise;
 end;
end;

procedure TDMBase.SetActiveDataNavigator(value: TCustomDataNavigator);
begin
 FActiveDataNavigator := Value;
end;

procedure TDMBase.SetActiveDataset(value: TDataset);
begin
 FActiveDataset := Value;
end;

procedure TDMBase.SetConnected(Value: boolean);
begin
 case ConnectionType of
   ctPooledOnDemand, ctPooledOnStart:
      begin
       if Value <> FConnectionsPool.Active then
        begin
         if Value = False then
          DoCloseConnection
         else
          ConnectServer;
        end;
      end;
   ctStateless:
      begin

      end;
   ctFixed:
      begin
        if Value <> DBXConnection.Connected then DBXConnection.Connected := Value;
      end;
 end;
end;

procedure TDMBase.SetConnectionStatus(Value: TConnectionStatus);
begin
  FConnectionStatus := Value;
  FConnectionObservable.NotifyObservers(FConnectionStatus);
end;

procedure TDMBase.SetMonitorConnection(value: boolean);
begin
//To-do.
end;

procedure TDMBase.RegisterCamposTrabalhos;
var
 ACommand: TDBXCommand;
 AList: TStringList;
 I: integer;
 ACampo: TCampoTrabalho;
begin
{Obtém e registra os campos de trabalho aos quais o usuário conectado possui
 acesso.}
 CurrentConnectionInfo.CamposTrabalho := [];

 ACommand := CreateCommand;
 AList := TStringList.Create;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.GetCamposTrabalho'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetWideString(CurrentConnectionInfo.CurrentUser.Login);
   ACommand.ExecuteUpdate;
   AList.CommaText := ACommand.Parameters[1].Value.GetWideString;

   for I := 0 to Pred(AList.Count) do
     begin
      ACampo := TCampoTrabalho(StrToInt(AList.Strings[I]));
      CurrentConnectionInfo.CamposTrabalho := CurrentConnectionInfo.CamposTrabalho + [ACampo];
     end;

   RegisterRemoteCallSucess(ACommand.Text);
   ACommand.Free;
   AList.Free;

 except
  on E: Exception do
   begin
    CurrentConnectionInfo.CamposTrabalho := [];
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(AList) then FreeAndNil(AList);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
 end;
end;

procedure TDMBase.RegisterConnectedUserInfo(const UserName: string);
var
 AData: TCosmosData;
 ADataset: TSQLDataset;
 ACommand: TDBXCommand;
begin
{Busca os dados de um usuário conectado e escreve esses dados em uma estrutura
de memória. Estas informações estarão disponíveis para várias outras funcionalidades
das aplicações Cosmos.}

 AData := TCosmosData.Create(15);
 ACommand := CreateCommand;

 try
  ACommand.Text := 'TDMCosmosApplicationServer.GetConnectedUserInfo'; //do not localize!
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetWideString(UserName);
  ACommand.ExecuteUpdate;

  ADataset := TSQLDataSet.Create(nil, ACommand.Parameters[1].Value.GetDBXReader(False), True);
  ADataset.Open;

  if ADataset <> nil then
    begin
     if ADataset.IsEmpty then
      raise EUnknownUser.Create(Format(TCosmosErrorSecurityMsg.UnknowUser, [UserName.QuotedString]));

     AData.WriteValue('LOGIN', UserName);  //do not localize!
     AData.WriteValue('FOCO', ADataset.Fields.FieldByName('SIGFOC').Value, 1);  //do not localize!
     AData.WriteValue('USER_NAME', ADataset.Fields.FieldByName('NOMCAD').Value, 2);  //do not localize!
     AData.WriteValue('GROUP', self.FConnectedUserRoles.CommaText, 3);  //do not localize!
     AData.WriteValue('MATRICULA', ADataset.Fields.FieldByName('MATCAD').Value, 4);  //do not localize!
     AData.WriteValue('DISCIPULADO', ADataset.Fields.FieldByName('SIGDIS').Value, 5);  //do not localize!
     AData.WriteValue('ADM', ADataset.Fields.FieldByName('INDADM').Value, 6);  //do not localize!
     AData.WriteValue('ATIVO', ADataset.Fields.FieldByName('INDATI').Value, 7);  //do not localize!
     AData.WriteValue('CONNECTION_TIME', self.ServerDateTime, 8);  //do not localize!
     AData.WriteValue('CONNECTION_ID', Random.ToString, 9);  //do not localize!
     AData.WriteValue('CONNECTION_STATUS', Ord(csAuthorizedUser), 10);  //do not localize!

     CurrentConnectionInfo.RegisterUserInfo(AData);
    end;

  RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
     RegisterRemoteCallFailure(E.Message, ACommand.Text);
     if Assigned(ACommand) then FreeAndNil(ACommand);
     if Assigned(ADataset) then FreeAndNil(ADataset);
    raise;
   end;
 end;
end;

procedure TDMBase.RegisterRemoteCallFailure(const Error, RemoteMethod: string);
begin
 //Registra os logs de uma chamada de método remota com falha.
 if (ICosmosApp <> nil) and (ICosmosApp.MainLog <> nil) then
  begin
   ICosmosApp.MainLog.RegisterRemoteCallFailure(Error + ' - ' + RemoteMethod, ConnectionParamsInfo);
  end;
end;

procedure TDMBase.RegisterRemoteCallSucess(const RemoteMethod: string);
begin
 //Registra os logs de uma chamada de método remota feita com sucesso.
 if (ICosmosApp <> nil) and (ICosmosApp.MainLog <> nil) then
  begin
   ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [RemoteMethod]), ConnectionParamsInfo);
  end;
end;

procedure TDMBase.RegisterAuthorizations;
var
 ACommand: TDBXCommand;
 AList, AModuleList: TStringList;
 I: integer;
 AFeature: TCosmosFeature;
 ASecFeature: TSecretariasFeatures;
 AConFeature: TConferenciasFeatures;
 AFinFeature: TFinanceiroFeatures;
 AUsuFeature: TUsuariosFeatures;
begin
{Obtém do servidor as autorizações de acesso a funcionalidades. Estas autorizações
serão usadas para desabilitar ou disponibilizar os controles que disparam as
funcionalidades.}
 ConnectionStatus := csGettingAuthorizations;
 CurrentConnectionInfo.AuthorizedFeatures := [];

 ACommand := CreateCommand;
 AList := TStringList.Create;
 AModuleList := TStringList.Create;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.GetAuthorizations'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetWideString(CurrentConnectionInfo.CurrentUser.Login);
   ACommand.ExecuteUpdate;
   AModuleList.CommaText := ACommand.Parameters[1].Value.GetWideString;
   AList.CommaText := ACommand.Parameters[2].Value.GetWideString;

   for I := 0 to Pred(AList.Count) do
     begin
      AFeature := TCosmosFeature(StrToInt(AList.Strings[I]));
      CurrentConnectionInfo.AuthorizedFeatures := CurrentConnectionInfo.AuthorizedFeatures + [AFeature];
     end;

   for I := 0 to Pred(AModuleList.Count) do
     begin
      case ICosmosApp.CosmosModule of
       cmSecretarias:
         begin
            ASecFeature := TSecretariasFeatures(StrToInt(AModuleList.Strings[I]));
            CurrentConnectionInfo.SecretariasFeatures := CurrentConnectionInfo.SecretariasFeatures + [ASecFeature];
         end;
       cmConferencias:
         begin
            AConFeature := TConferenciasFeatures(StrToInt(AModuleList.Strings[I]));
            CurrentConnectionInfo.ConferenciasFeatures := CurrentConnectionInfo.ConferenciasFeatures + [AConFeature];
         end;
       cmFinanceiro:
         begin
            AFinFeature := TFinanceiroFeatures(StrToInt(AModuleList.Strings[I]));
            CurrentConnectionInfo.FinanceiroFeatures := CurrentConnectionInfo.FinanceiroFeatures + [AFinFeature];
         end;
       cmUsuarios:
         begin
            AUsuFeature := TUsuariosFeatures(StrToInt(AModuleList.Strings[I]));
            CurrentConnectionInfo.UsuariosFeatures := CurrentConnectionInfo.UsuariosFeatures + [AUsuFeature];
         end;
      end;

     end;

   RegisterRemoteCallSucess(ACommand.Text);
   ACommand.Free;
   AList.Free;
   AModuleList.Free;

 except
  on E: Exception do
   begin
    CurrentConnectionInfo.AuthorizedFeatures := [];
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(AList) then FreeAndNil(AList);
    if Assigned(AModuleList) then FreeAndNil(AModuleList);

    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
 end;
end;

procedure TDMBase.ShowNoServerDialog;
begin
//Exibe mensagem quando não existe um servidor cadastrado para conexão.
 FrmDlgNoServer := TFrmDlgNoServer.Create(self);

 try
  FrmDlgNoServer.ShowModal;

 finally
  if Assigned(FrmDlgNoServer) then FreeAndNil(FrmDlgNoServer);
 end;
end;

procedure TDMBase.ToClientDataset(Source: TCustomSQLDataset;
  Target: TClientDataset);
begin
//Transfere os objetos em um fonte de dados para um TClientDataset.
 if (Source <> nil) and (Source.Active) then
  if (Target <> nil) then
   ConvertToClientDataset(Source, Target);
end;

procedure TDMBase.UpdateBufferedTablesControlFile(const Table: TCosmosTables;
  NewVersion: integer);
var
 sFile, sTableId: string;
 aDataset: TClientDataset;
 CosmosAppInfo: TCosmosAppInfo;
begin
{Atualiza o conteúdo do arquivo de controle de tabelas buferizadas. O dado a ser
 atualizado é o número mais recente da versão de uma tabela específica.}
 aDataset := TClientDataset.Create(self);
 CosmosAppInfo := TCosmosAppInfo.Create;

 try
  sFile := CosmosAppInfo.ReadCommonAppDataPath + TCosmosFiles.BufTab;
  sTableId := TCosmosTablesInfo.GetCosmosTablesId(Table);
  aDataset.LoadFromFile(sFile);

  if aDataset.Locate('SIGTAB', sTableId, []) then //do not localize!
   begin
    aDataset.Edit;
    aDataset.Fields.FieldByName('versao').Value := NewVersion; //do not localize!
    aDataset.Post;
    aDataset.SaveToFile(sFile);
   end;

 finally
  aDataset.Free;
  CosmosAppInfo.Free;
 end;
end;

function TDMBase.VerifyCosmosServer(Module: TCosmosModules): boolean;
var
 ACommand: TDBXCommand;
begin
 //Checa se o servidor que está conectado é o adequado para o módulo cliente do Cosmos.
 ACommand := CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.VerifyCosmosServer'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(Ord(Module));
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.GetBoolean;
   RegisterRemoteCallSucess(ACommand.Text);
   ACommand.Free;


 except
  on E: Exception do
   begin
    RegisterRemoteCallFailure(E.Message,  ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise;
   end;
 end;
end;

function TDMBase.TestConnectedServer: boolean;
begin
 {Testa se o servidor conectado está repondendo a nova tentativa de conexão.}
 FConnTest.ServerIsOnline(DBXConnection.Params);
 Result := FConnTest.OnLine.Value;
end;

procedure TDMBase.TimerConnectionTimer(Sender: TObject);
var
 sNotifyMode: string;
begin
 {Notifica o usuário a respeito de instabilidades na conexão de Internet ou VPN.
 Isso apenas será feito se o servidor Cosmos não estiver rodando no mesmo
 computador do cliente (conexão local) e caso a configuração da conexão indicar
 que deve ocorrer notificação.}
sNotifyMode := ConnectionInfo.FindValue('NotifyMode'); //do not localize!
// outputdebugstring(pwidechar(sNotifyMode));

 if sNotifyMode.Trim <> 'nmNoNotify' then
  begin
   if (not TestConnectedServer) then
    begin
     if sNotifyMode.Trim = 'nmNotify' then //do not localize!!!
      ICosmosApp.Components.TrayIcon.ShowError(TCosmosTitles.ServerConection, TCosmosErrorMsg.NoNetActivity)
     else
      ICosmosApp.MainLog.RegisterError(TCosmosErrorMsg.NoNetActivity); //Registra logs.
    end;
  end;
end;

function TDMBase.ToClientDataset(Source: TCustomSQLDataset): TClientDataset;
begin
//Converte um dataset do dbExpress para um dataset de memória.
 Result := TClientDataset.Create(nil);
 ConvertToClientDataset(Source, Result);
end;

procedure TDMBase.BufferData(const Table: TCosmosTables; FileName: string);
var
 ACommand: TDBXCommand;
 AData: Olevariant;
 BufferedFile: string;
 ADataset: TClientDataset;
begin
 //Guarda dados em cache para uso local das aplicações.
 ConnectionStatus := csBufferingData;

 if not HasNewerVersion(Table) then
  Exit;

 ACommand := CreateCommand;
 ADataset := TClientDataset.Create(nil);

 ConnectionStatus := csLoadingData;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.BufferData';//do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(Ord(Table));
  ACommand.ExecuteUpdate;
  AData := ACommand.Parameters[1].Value.AsVariant;

  RegisterRemoteCallSucess(ACommand.Text);

  //Verifica se o retorno do servidor foi um tipo válido.
  if not VarIsClear(AData) then
   begin
    ADataset.Data := AData;
    BufferedFile := BufferDir + FileName;

    if FileExists(BufferedFile) then DeleteFile(BufferedFile);
    ADataset.SaveToFile(BufferedFile);
   end;

  ACommand.Free;
  ADataset.Free;
  screen.Cursor := crHourGlass;

 except
  on E: Exception do
   begin
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);

    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
 end;
end;

procedure TDMBase.AbortConnection;
begin
 ConnectionStatus := csAborted;
end;

procedure TDMBase.ApplyUpdates(Dataset: TClientDataset; MaxErrors: integer);
begin
//Atualiza as alterações em um dataset no lado servidor.
 try
 if (Dataset <> nil) and (Dataset.Active) then
  if Dataset.ChangeCount > 0 then
   Dataset.ApplyUpdates(MaxErrors);

 except
  raise;
 end;
end;

procedure TDMBase.BufferData(const FileName: string; Data: Olevariant);
var
BufferedFile: string;
begin
 {Buferiza dados no lado cliente. Nesse método, os dados já chegam pronto.}
 try
  CdsBufferedData.Data := Data;
  BufferedFile := BufferDir + '\' + FileName;
  if FileExists(BufferedFile) then
   DeleteFile(BufferedFile);
  CdsBufferedData.SaveToFile(BufferedFile);

 finally
  CloseDataset(CdsBufferedData);
 end;
end;

procedure TDMBase.CloseDataset(const Dataset: TDataset);
begin
//Fecha um dataset ativo
 if (Assigned(Dataset)) and (Dataset.Active) then
   Dataset.Close;
end;

function TDMBase.ConnectServer: boolean;
 var
  UserName, Password: string;
begin
 //Connecta com o servidor remoto e inicia uma seção de trabalho.
 if not LoginDialog(UserName, Password) then
  Abort;

 if DoConnectServer(UserName, Password) then
   begin
    try
     screen.Cursor := crHourGlass;
     CloseConnectInfoDialog;

     if ConnectionStatus = csAborted then
      raise EAbortedConnection.Create(TCosmosErrorMsg.AbortedConnection);

     if not VerifyCosmosServer(ICosmosApp.CosmosModule) then
      raise EIncorrectServer.Create(TCosmosErrorMsg.IncorrectServer);

     ConnectionStatus := csVerifyingIdentity;

     //Obtém as roles atribuídas ao usuário.
     ReadUserRoles(DBXConnection.Params.Values['DSAuthenticationUser']);  //do not localize!
     //Dispara uma exceção caso o usuário não possua roles.
     if FConnectedUserRoles.Count = 0 then
      raise EInvalidRoleAcess.Create(TCosmosErrorMsg.NoneRoleToUser);

     //Registra informações sobre o usuário autenticado.
     RegisterConnectedUserInfo(DBXConnection.Params.Values['DSAuthenticationUser']);   //do not localize!

     //Registra um log de conexão feita com sucesso.
     ICosmosApp.MainLog.RegisterLog(Format(TCosmosLogs.ConnectedUser, [self.CurrentUser.UserName]),
       self.ConnectionParamsInfo, leOnConnect);

     //Registra as autorizações de acesso às funcionalidades do sistema.
     RegisterAuthorizations;

     ConnectionStatus := csAuthorizedUser;
     //Registra os campos de trabalho dos quais o usuário é obreiro.
     RegisterCamposTrabalhos;

     ConnectionStatus := csApplyPermissions;
     //Busca o arquivo XML remoto que possui informações sobre os fields dos datasets.
     CreateFieldsInfo;

     //Checa se a senha é provisória. Se sim, solicita a troca da senha.
     if PasswordIsTemporary(DBXConnection.Params.Values['DSAuthenticationUser']) then  //do not localize!
      begin
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosInfoMsg.TemporaryPassword);
       if not ChangePassword(Password) then
        CloseConnection;
      end;

     screen.Cursor := crDefault;

     except
      on E: EAbortedConnection do
       begin
        DoCloseConnection;
        Result := self.Connected;
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ServerConection, E.Message);
        ICosmosApp.MainLog.RegisterLog(E.Message, ConnectionParamsInfo, leOnConnectError);
       end;
      on E: EIncorrectServer do
       begin
        DoCloseConnection;
        Result := self.Connected;
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ServerConection, E.Message);
        ICosmosApp.MainLog.RegisterLog(E.Message, ConnectionParamsInfo, leOnConnectError);
       end;
      on E: EIdSocketError do
       begin
        DoCloseConnection;
        Result := self.Connected;
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ServerConection, TCosmosErrorMsg.RefusedConnection);
        ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnConnectError);
       end;
      on E: ENoneServerError do
       begin
        Result := self.Connected;
        DoCloseConnection;
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ServerConection, TCosmosErrorMsg.NoServerAvaible);
        ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnError);
       end;
      on E: ENetActivityError do
       begin
        Result := self.Connected;
        DoCloseConnection;
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.ServerConection, E.Message);
        ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnError);
       end;
      on E: EUnknownUser do
       begin
        DoCloseConnection;
        Result := self.Connected;
        ICosmosApp.MainLog.RegisterError(E.Message);
       end;
      on E: TDBXError do
       begin
        DoCloseConnection;
        Result := self.Connected;
        ProcessDBXError(E);
       end
     end;
   end;

 screen.Cursor := crDefault;
 Result := Connected;
end;

procedure TDMBase.ConvertToClientDataset(Source: TCustomSQLDataset;
  Destination: TClientDataset);
const
Options : TGetRecordOptions = [grMetaData,grReset];
var
 AProvider: TDatasetProvider;
begin
 //"Converte" um objeto do tipo TCustoSQLDataset para um clientdataset.
 AProvider := TDatasetProvider.Create(nil);
 AProvider.Name := 'PrvConverter';   //do not localize!

 try
  AProvider.DataSet := Source;
  AProvider.Options := AProvider.Options + [poIncFieldProps];
  Destination.SetProvider(AProvider);
  Destination.Open;

  LoadFieldsInfo(Destination);

 finally
  if Assigned(AProvider) then FreeAndNil(AProvider);
 end;
end;

function TDMBase.ChangePassword(const CurrentPassword: string): boolean;
var
 ACommand: TDBXCommand;
 sHashedPassword: string;
begin
 //Altera a senha de um usuário.
 Result := False;
 FrmChangePassword := TFrmChangePassword.Create(self);

 if FrmChangePassword.ShowDialogs(CurrentConnectionInfo.CurrentUser.Login, CurrentPassword) then
  begin
    //Obtém um hash a partir da nova senha informada pelo usuário.
    sHashedPassword := ICosmosApp.IUtilities.HashString(FrmChangePassword.NewPassword);
    ACommand := CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMCosmosApplicationServer.ChangePassword'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetWideString(CurrentConnectionInfo.CurrentUser.Login);
     ACommand.Parameters[1].Value.SetWideString(sHashedPassword);
     ACommand.ExecuteUpdate;

     Result := ACommand.Parameters[2].Value.GetBoolean;

     RegisterRemoteCallSucess(ACommand.Text);
     ACommand.Free;

     if Assigned(FrmChangePassword) then
       FreeAndNil(FrmChangePassword)


    except
     on E: Exception do
      begin
       Result := False;
       if Assigned(FrmChangePassword) then FreeAndNil(FrmChangePassword);
       RegisterRemoteCallFailure(E.Message, ACommand.Text);
       if Assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
      end;
     end;
  end
  else
   if Assigned(FrmChangePassword) then
    FreeAndNil(FrmChangePassword);
end;

procedure TDMBase.CloseConnectInfoDialog;
begin
  //Destrói a janela "Conectando..."
 ICosmosApp.Components.TrayIcon.CloseTrayIcon;

 ICosmosApp.Components.StatusBar.WriteText('');

  if Assigned(FrmConnecting) then
   begin
    FrmConnecting.Close;
    FreeAndNil(FrmConnecting);
   end;
end;

procedure TDMBase.CloseConnection;
begin
 DoCloseConnection;
end;

procedure TDMBase.DoChangeStatus(E: EIdException);
begin
{Altera o status da conexão de acordo com o erro Indy estourado.}
 if E is EIdSocketError then
  begin
   case EIdSocketError(E).LastError of
    TCosmosErrorCodes.IndyRefusedConnection: ConnectionStatus := csRefusedConnection;
    TCosmosErrorCodes.IndyHostNotFound: ConnectionStatus := csHostNotFound;
   end
  end
  else
   if E is EIdConnectTimeout then ConnectionStatus := csTimeoutExpired
  else
   if E is EIdConnectException then ConnectionStatus := csConnectError;

end;

procedure TDMBase.DoCloseConnection;
begin
 {Encerra uma conexão estabelecida com o servidor.}
 if PooledConnection then
  begin
   FConnectionsPool.DropConnections;
  end;

 DBXConnection.CloseDataSets;

 if Assigned(DBXConnection.DBXConnection) then
   DBXConnection.DBXConnection.Close;

 if Assigned(FRemoteProviders) then
   FRemoteProviders.ClearAll;

 if DBXConnection.Connected then
  DBXConnection.Close;

 if Assigned(FConnectionsPool) then
   FreeAndNil(FConnectionsPool);
end;

function TDMBase.DoConnectServer(const UserName, Password: string): boolean;
var
 InnerErrorCode: integer;
 sMessage, sTitle: string;
 vPoolSize, vCleanupDelay, vPoolTimeout: variant;
begin
{Conecta ao host onde se encontra as a aplicação Cosmos servidora.}
 ICosmosApp.MainLog.RegisterLog(Format(TCosmosLogs.PrepareConnect, [UserName]), '', leOnConnect);

 //Carrega os dados das conexões, servidores e protocolos.
 LoadServers;

 try
  //Nenhum servidor cadastrado ou ativo.
  if ConnectionInfo.FindValue('CommunicationProtocol') = null then  //do not localize!
   raise ENoneServerError.Create(TCosmosErrorMsg.NoServerAvaible);

   with  DBXConnection.Params do
    begin
     Clear;
     Values['DriverName'] := 'DataSnap'; //do not localize!
     Values['DriverUnit'] := 'Data.DBXDataSnap'; //do not localize!
     Values['BufferKBSize'] := ConnectionInfo.FindValue('BufferKBSize');

     //usuário e senha
     Values['DSAuthenticationUser'] := UserName;  //do not localize!
     Values['DSAuthenticationPassword'] := ICosmosApp.IUtilities.HashString(Password);  //do not localize!

     if cpTCP in self.Protocols then
      begin
       Values['CommunicationProtocol'] := ConnectionInfo.FindValue('CommunicationProtocol');  //do not localize!
       Values['HostName'] := ConnectionInfo.FindValue('HostName');  //do not localize!
       Values['Port'] := ConnectionInfo.FindValue('Port');  //do not localize!
       Values['CommunicationTimeout'] := ConnectionInfo.FindValue('CommunicationTimeout');  //do not localize!
       Values['ConnectTimeout'] := ConnectionInfo.FindValue('ConnectTimeout');   //do not localize!
       Values['DSProxyHost'] := ConnectionInfo.FindValue('ProxyHost');  //do not localize!
       Values['DSProxyPort'] := ConnectionInfo.FindValue('ProxyPort');  //do not localize!
       Values['DSProxyUsername'] := ConnectionInfo.FindValue('ProxyUsername');  //do not localize!
       Values['DSProxyPassword'] := ConnectionInfo.FindValue('ProxyPassword');  //do not localize!
      end
     else
     if cpHTTP in self.Protocols then
      begin
       Values['CommunicationProtocol'] := ConnectionInfo.FindValue('CommunicationProtocol');  //do not localize!
       Values['HostName'] := ConnectionInfo.FindValue('HostName');  //do not localize!
       Values['Port'] := ConnectionInfo.FindValue('Port');  //do not localize!
       Values['ConnectTimeout'] := ConnectionInfo.FindValue('ConnectTimeout');  //do not localize!
       Values['CommunicationTimeout'] := ConnectionInfo.FindValue('CommunicationTimeout');  //do not localize!
       Values['DSProxyHost'] := ConnectionInfo.FindValue('ProxyHost');  //do not localize!
       Values['DSProxyPort'] := ConnectionInfo.FindValue('ProxyPort');  //do not localize!
       Values['DSProxyUsername'] := ConnectionInfo.FindValue('ProxyUsername');  //do not localize!
       Values['DSProxyPassword'] := ConnectionInfo.FindValue('ProxyPassword');  //do not localize!
       Values['DatasnapContext'] := ConnectionInfo.FindValue('DatasnapContext');   //do not localize!
      end
     else
     if cpHTTPS in self.Protocols then
      begin
       Values['CommunicationProtocol'] := ConnectionInfo.FindValue('CommunicationProtocol');  //do not localize!
       Values['HostName'] := ConnectionInfo.FindValue('HostName');  //do not localize!
       Values['Port'] := ConnectionInfo.FindValue('Port');   //do not localize!
       Values['ConnectTimeout'] := ConnectionInfo.FindValue('ConnectTimeout');  //do not localize!
       Values['CommunicationTimeout'] := ConnectionInfo.FindValue('CommunicationTimeout');  //do not localize!
       Values['DSProxyHost'] := ConnectionInfo.FindValue('ProxyHost');   //do not localize!
       Values['DSProxyPort'] := ConnectionInfo.FindValue('ProxyPort');   //do not localize!
       Values['DSProxyUsername'] := ConnectionInfo.FindValue('ProxyUsername');  //do not localize!
       Values['DSProxyPassword'] := ConnectionInfo.FindValue('ProxyPassword');  //do not localize!
       Values['DatasnapContext'] := ConnectionInfo.FindValue('DatasnapContext');   //do not localize!
       Values['DriverAssemblyLoader'] := 'Borland.Data.TDBXClientDriverLoader,Borland.Data.DbxClientDriver,Version=21.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b';  //do not localize!
      end
    end;

    //Se não foi configurado uma conexão, já dispara uma exceção..
    if Protocols = [] then
     raise ENoneServerError.Create(TCosmosErrorMsg.NoServerAvaible);

    //Cria o objeto de pool de conexões com o servidor remoto.
    if (PooledConnection) then
     begin
       //Tamanho do pool de conexões.
       ConnectionStatus := csCreatingConnectionsPool;

       if Assigned(FConnectionsPool) then
        FreeAndNil(FConnectionsPool);

       vPoolSize := ConnectionInfo.FindValue('PoolSize');  //do not localize!
       if vPoolSize = '' then VPoolSize := 5; //default

       //Período de espera (em minutos) para o início de um processo de limpeza do pool.
       vCleanupDelay := ConnectionInfo.FindValue('CleanupMinutes');  //do not localize!
       if vCleanupDelay = '' then vCleanupDelay := 3; //default

       //Timeout para testes de conexões.
       vPoolTimeout := ConnectionInfo.FindValue('PoolTimeout');  //do not localize!
       if vPoolTimeout = '' then vPoolTimeout := 2000; //default

       //Cria e configura o pool de conexões.
       FConnectionsPool :=  TDBXConnectionPool.Create(vPoolSize, vCleanupDelay, vPoolTimeout, DBXConnection.Params);
       //Define o tipo de crescimento do pool a partir da propriedade ConnectionMode.
       case ConnectionType of
         ctPooledOnDemand: FConnectionsPool.PoolGrowth := pgOnDemand;
         ctPooledOnStart: FConnectionsPool.PoolGrowth := pgCreateFull;
       end;
       //Configura as demais propriedades do pool.
       FConnectionsPool.CommandText := 'TDMCosmosApplicationServer.PingServer';   //do not localize!
       FConnectionsPool.ValidatePeerCertificate := DBXConnection.ValidatePeerCertificate;
       FConnectionsPool.BeforeConnect := DBXConnection.BeforeConnect;
       FConnectionsPool.AfterConnect := DBXConnection.AfterConnect;
       FConnectionsPool.BeforeDisconnect:= DBXConnection.BeforeDisconnect;
       FConnectionsPool.AfterDisconnect := DBXConnection.AfterDisconnect;
       FConnectionsPool.OnErrorEvent := ProcessDBXError;
      // FConnectionsPool.OnRegisterEvent := ICosmosApp.MainLog.RegisterLog;
       FConnectionsPool.CreateConnectionPool;
     end
    else //Conexão sem pool.
     begin
       case ConnectionType of
        ctStateless: //Conexão tipo "stateless".
         begin //Cria uma conexão nova...
           Result := DoCreateConnection.Connected;
         end;
        //Conexão fixa: sempre o mesmo objeto de conexão.
        ctFixed: DBXConnection.Open;
       end;
     end;

    {Testa se o host remoto está disponível, por meio de um simples "ping".}
    if (ConnectionProtocol = cpTCP) and (ConnectionInfo.FindValue('NotifyMode') <> 'nmNoNotify') then
     begin
      if not TestConnectedServer then
       raise ENetActivityError.Create(TCosmosErrorMsg.NoNetActivity);
     end;

    screen.Cursor := crHourGlass;

    if ConnectionType <> ctStateless then
     Result := self.Connected;

 except
      on E: EIdSocketError do
       begin
        DoCloseConnection;
        Result := self.Connected;
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ServerConection, TCosmosErrorMsg.RefusedConnection);
        ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnConnectError);
       end;
      on E: ENoneServerError do
       begin
        Result := self.Connected;
        DoCloseConnection;
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ServerConection, TCosmosErrorMsg.NoServerAvaible);
        ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnError);
       end;
      on E: ENetActivityError do
       begin
        Result := self.Connected;
        DoCloseConnection;
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.ServerConection, E.Message);
        ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnError);
       end;
      on E: EConnPoolException do //Erro durante a tentativa de conexão de objetos do pool.
       begin
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ServerConection, E.Message);
        ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnConnectError);
       end;
      on E: TDBXError do
       begin
         DoCloseConnection;
         Result := Connected;
         sTitle := TCosmosTitles.ServerConection; //Título padrão.

         //Falha originária do Indy e encapsulada em um TDBXError pelo dbExpress.
         if (E.InnerException <> nil) and (E.InnerException is EIdException) then
          begin
           //Muda o status da conexão conforme o erro estourado.
           DoChangeStatus(EIdException(E.InnerException));
           {Obtém a mensagem mapeada para mensagens do Cosmos. A classe EIdSocketError mapeia
           a causa do erro através da propriedade "LastError".}
           if E.InnerException is  EIdSocketError then
            sMessage := TCosmosErrorCodes.ToMessage(EIdSocketError(E.InnerException).LastError)
           else
            begin
             InnerErrorCode := TCosmosErrorCodes.IndyCodeToCosmosCode(EIdException(E.InnerException));
             sMessage := TCosmosErrorCodes.ToMessage(InnerErrorCode);
            end;

           ICosmosApp.MainLog.RegisterLog(E.InnerException.Message, self.ConnectionParamsInfo, leOnConnectError);
          end
         else //Falha original não é um EIdSocketError.
          begin
           if E.ErrorCode = 0 then //Autenticação inválida.
            begin
             GetDBXErrorMessages(TDBXErrorCodes.InvalidUserOrPassword, sTitle, sMessage);
             ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnAuthenticateFail);
             ConnectionStatus := csAuthenticationInvalid;
            end
           else //Apresenta uma mensagem de erro genérica.
            begin
             sMessage := TCosmosErrorMsg.UnknownConnectionError;
             ICosmosApp.MainLog.RegisterLog(E.Message, self.ConnectionParamsInfo, leOnConnectError);
             ConnectionStatus := csConnectError;
            end;
          end;
         //Finalmente, exibe a mensagem de erro e registra mais um log com a mensagem exibida ao usuário.
         if sMessage <> '' then
          begin
           ICosmosApp.DlgMessage.ErrorMessage(sTitle, sMessage);
           ICosmosApp.MainLog.RegisterError(sMessage);
          end
       end
 end;
end;

procedure TDMBase.DropConnection(RemoteConnection: TDSProviderConnection);
begin
 //Destrói um TDSProviderConnection criado dinamicamente.
 if Assigned(RemoteConnection) then
   FRemoteProviders.RemoveRemoteProvider(RemoteConnection.Tag);
end;

function TDMBase.CreateCommand: TDBXCommand;
begin
 //Cria um comando que pode ser usado para executar métodos remotos.
 if PooledConnection then
  Result := FConnectionsPool.GetConnection.CreateCommand
 else
  begin
    case ConnectionType of
     ctStateless: Result := DoCreateConnection.DBXConnection.CreateCommand;
     ctFixed: Result := DBXConnection.DBXConnection.CreateCommand;
    end;
  end;
end;

function TDMBase.CreateConnection(
  const ServerClass: TServerClass): TDSProviderConnection;
begin
{Cria um objeto de acesso aos DatasetProviders do servidor e o configura para
 acessar a classe remota adequada do servidor.}
 Result := TDSProviderConnection.Create(Application);
 Result.ServerClassName := self.GetServerClassName(ServerClass);

 if PooledConnection then
  Result.SQLConnection := FConnectionsPool.GetConnection.Connection
 else
  begin
   case ConnectionType of
    ctStateless: Result.SQLConnection := GetConnectionObject;
    ctFixed: Result.SQLConnection := DBXConnection;
   end;
  end;

 try
   Result.Open;
  //Adiciona na propriedade "tag" o índice do objeto no pool.
   Result.Tag := FRemoteProviders.AddRemoteProvider(Result);

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterError(E.Message);
   end;
 end;
end;

procedure TDMBase.DefaultExport(Dataset: TDataset);
var
  AModule: HModule;
  AClass: TInterfacedPersistent;
  IDlgExporter: IExporterDialogs;
begin
//Exporta os dados do dataset ativo para um arquivo externo.
  AClass := ICosmosApp.LoadClass('dlgexporter.bpl', 'TDlgExporterControler', AModule);  //do not localize!

   try
    if AModule <> 0 then
     begin
      IDlgExporter := AClass as IExporterDialogs;
      if Assigned(IDlgExporter) then
        begin
         IDlgExporter.ExecuteDefault(Dataset);
        end;

      AClass.Free;
     end;

   finally
     if Assigned(IDlgExporter) then IDlgExporter := nil;
     if AModule <> 0 then UnloadPackage(AModule);
   end;
end;

procedure TDMBase.DefaultLocate;
var
  AModule: HModule;
  AClass: TInterfacedPersistent;
  ILocate: ICosmosLocateData;
begin
 inherited;
 {Aciona a classe que controla o mecanismo de pesquisa de todo o sistema Cosmos.
 Esta classe é capaz de executar pesquisas em dados exibidos em qualquer formato.}
 AClass := ICosmosApp.LoadClass('locdata.bpl', 'TDataLocateControler', AModule);  //do not localize!

 try
  if AModule <> 0 then
   begin
    with AClass do
     begin
      if Supports(AClass, ICosmosLocateData) then
        ILocate := AClass as ICosmosLocateData;

      if Assigned(ILocate) then
       begin
        ILocate.Execute;
       end;

      Free;
     end;
   end;

 finally
  if Assigned(ILocate) then ILocate := nil;
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

function TDMBase.ExecuteCommand(const Command: TCosmosCommand;
  Params: Olevariant): boolean;
var
 ACommand: TDBXCommand;
begin
 //Executa um comando DML pré-definido no servidor remoto.
  ACommand := CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.ExecuteCommand'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(Ord(Command));
   ACommand.Parameters[1].Value.AsVariant := Params;
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[2].Value.GetInt32 >= 0;

   RegisterRemoteCallSucess(ACommand.Text);
   ACommand.Free;


 except
  on E: Exception do
   begin
    Result := False;
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SystemFailure);
   end;
 end;
end;

procedure TDMBase.ExecuteDQL(const Search: TCosmosSearch; Params: Olevariant;
  Dataset: TClientDataset);
var
 ACommand: TDBXCommand;
 IsReadOnly: boolean;
 aServerDataset: TSQLDataSet;
begin
 //Executa uma pesquisa do Cosmos no servidor remoto.
 Screen.Cursor := crHourglass;
 ACommand := CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.ExecuteDQL';  //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(Ord(Search));
  ACommand.Parameters[1].Value.AsVariant := Params;
  ACommand.ExecuteUpdate;

  aServerDataset := TSQLDataSet.Create(nil, ACommand.Parameters[2].Value.GetDBXReader(False), True);
  aServerDataset.Open;
  ToClientDataset(aServerDataset, Dataset);

  IsReadOnly := Dataset.ReadOnly;

  if isReadOnly then
   Dataset.ReadOnly := False;

  RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommandFail, [ACommand.Text]));

  if Assigned(ACommand) then FreeAndNil(ACommand);
  Dataset.ReadOnly := IsReadOnly;

  Screen.Cursor := crDefault;

 except
  on E: Exception do
   begin
    Screen.Cursor := crDefault;
    RegisterRemoteCallFailure(E.Message, Format(TCosmosLogs.ExecutedRemoteCommandFail, [ACommand.Text]));
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SystemFailure);
   end;
 end;

end;

procedure TDMBase.ExecuteRegisteredSearch(const SearchId: integer;
  Params: Olevariant; ADataset: TClientDataset);
var
 ACommand: TDBXCommand;
 ASQLDataset: TSQLDataset;
begin
 //Executa uma pesquisa padronizada no servidor remoto.
 Screen.Cursor := crHourglass;
 ACommand := CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.ExecuteRegisteredSearch'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(SearchId);
  ACommand.Parameters[1].Value.AsVariant := Params;
  ACommand.ExecuteUpdate;

  ASQLDataset := TSQLDataSet.Create(nil, ACommand.Parameters[2].Value.GetDBXReader(False), True);
  ASQLDataset.Open;
  RegisterRemoteCallSucess(ACommand.Text);

  ToClientDataset(ASQLDataset, ADataset);
  LoadFieldsInfo(ADataset);

  ACommand.Free;
  ASQLDataset.Free;
  Screen.Cursor := crDefault;

 except
 {Falhas específicas relacionadas à Central de relatórios. A mensagem não
  precisa ser exibida porque o erro é capturado por ProcessDBXError.}
  on E: TDBXError do
   begin
    Screen.Cursor := crDefault;
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 {Falhas genéricas inesperadas.A mensagem exibida é genérica.}
  on E: Exception do
   begin
    Screen.Cursor := crDefault;
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SelectData);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

function TDMBase.ExecuteDQL(const Search: TCosmosSearch;
  Params: Olevariant): TDataset;
var
 ACommand: TDBXCommand;
begin
 //Executa uma pesquisa do Cosmos no servidor remoto. Nesse caso, o dataset é o valor de retorno.
 ACommand := CreateCommand;

 Screen.Cursor := crHourGlass;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.ExecuteDQL'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(Ord(Search));
  ACommand.Parameters[1].Value.AsVariant := Params;
  ACommand.ExecuteUpdate;

  Result := TSQLDataSet.Create(nil, ACommand.Parameters[2].Value.GetDBXReader, True);
  Result.Open;

  RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;
  Screen.Cursor := crDefault;

 except
  on E: Exception do
   begin
    Screen.Cursor := crDefault;
    Result := nil;
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SystemFailure);
   end;
 end;
end;

function TDMBase.ExecuteRegisteredSearch(const SearchId: integer;
  Params: Olevariant): TDataset;
var
 ACommand: TDBXCommand;
 ASQLDataset: TSQLDataset;
begin
 //Executa uma pesquisa padronizada no servidor remoto.
 Screen.Cursor := crHourglass;
 ACommand := CreateCommand ;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosApplicationServer.ExecuteRegisteredSearch'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(SearchId);
  ACommand.Parameters[1].Value.AsVariant := Params;
  ACommand.ExecuteUpdate;

  ASQLDataset := TSQLDataSet.Create(nil, ACommand.Parameters[2].Value.GetDBXReader(False), True);
  ASQLDataset.Open;
  RegisterRemoteCallSucess(ACommand.Text);

  Result := ToClientDataset(ASQLDataset);
  LoadFieldsInfo(Result);

  ACommand.Free;
  ASQLDataset.Free;
  Screen.Cursor := crDefault;

 except
 {Falhas específicas relacionadas à Central de relatórios. A mensagem não
  precisa ser exibida porque o erro é capturado por ProcessDBXError.}
  on E: TDBXError do
   begin
    Screen.Cursor := crDefault;
    Result := nil;
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 {Falhas genéricas inesperadas.A mensagem exibida é genérica.}
  on E: Exception do
   begin
    Screen.Cursor := crDefault;
    Result := nil;
    RegisterRemoteCallFailure(E.Message, ACommand.Text);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SelectData);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

end.
