unit cosmos.servers.common.httpsengine;

interface

uses
  Winapi.Messages, System.SysUtils, IdHTTPWebBrokerBridge, Web.HTTPApp,
  IdSchedulerOfThreadPool, IdSSLOpenSSL;

{Classe que encapsula objetos Indy para oferecer suporte a SSL. Essa classe é
 usada em todos os servidores do Cosmos para oferecer suporte a HTTPS.}
type
  TSampleHTTPSEngine = class(TObject)

  private
    //Senha da chave privada do certificado digital gerado para a aplicação.
    FDefaultPort: integer;
    FServer: TIdHTTPWebBrokerBridge;
    FSchedulerOfThreadPool: TIdSchedulerOfThreadPool;
    FKeyFile: string;
    FPrivateKey: string;
    FRootCertFile: string;
    FMaxConnections: integer;
    FCertFile: string;

    procedure OnGetSSLPassword(var APassword: String);

    function GetActive: boolean;
    procedure SetActive(Value: boolean);

  public
    { Public declarations }
    constructor Create(CertFile, RootFile, KeyFile, PrivateKey: string; MaxConnections: integer);
    destructor Destroy; override;
    property Active: boolean read GetActive write SetActive;

    property CertFile: string read FCertFile;
    property RootCertFile: string read FRootCertFile;
    property KeyFile: string read FKeyFile;
    property PrivateKey: string read FPrivateKey write FPrivateKey;

    property DefaultPort: integer read FDefaultPort write FDefaultPort;
    property MaxConnections: integer read FMaxConnections;

    procedure ClearBindings;
    procedure StartServer;
    procedure StopServer;
  end;


implementation

{ TSampleHTTPSEngine }

procedure TSampleHTTPSEngine.ClearBindings;
begin
 FServer.Bindings.Clear;
end;

constructor TSampleHTTPSEngine.Create(CertFile, RootFile, KeyFile, PrivateKey: string;
 MaxConnections: integer);
var
  LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
begin
  inherited Create;

{Executa o servidor standalone https, iniciando por obter as configurações
 do servidor como certificados ssl, porta de comunicação etc.}

  FPrivateKey := PrivateKey;
  //Cria o objeto que implementa o servidor https.
  FServer := TIdHTTPWebBrokerBridge.Create;
  //Pool de threads. Veja: http://blog.marcocantu.com/blog/datasnap_deployment_performance.html
  FSchedulerOfThreadPool := TIdSchedulerOfThreadPool.Create(FServer);
  FSchedulerOfThreadPool.PoolSize := 50;
  FServer.Scheduler := FSchedulerOfThreadPool;

  //Configurações SSL.
  LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(FServer);
  LIOHandleSSL.SSLOptions.CertFile := CertFile;
  LIOHandleSSL.SSLOptions.RootCertFile := RootCertFile;
  LIOHandleSSL.SSLOptions.KeyFile := KeyFile;
  LIOHandleSSL.OnGetPassword := OnGetSSLPassword;
  FServer.IOHandler := LIOHandleSSL;

  //Atribui algumas configurações importantes ao servidor https.
  FServer.MaxConnections := MaxConnections;
  FServer.KeepAlive := True;
end;

destructor TSampleHTTPSEngine.Destroy;
begin
  if FServer.Active then FServer.Active := False;
  FSchedulerOfThreadPool.Free;
  FServer.IOHandler := nil;
  FServer.Free;
  inherited;
end;

function TSampleHTTPSEngine.GetActive: boolean;
begin
 Result := FServer.Active;
end;

procedure TSampleHTTPSEngine.SetActive(Value: boolean);
begin
 if Value <> FServer.Active then
  FServer.Active := Value;
end;

procedure TSampleHTTPSEngine.OnGetSSLPassword(var APassword: String);
begin
 APassword := FPrivateKey;
end;

procedure TSampleHTTPSEngine.StartServer;
begin
  if not FServer.Active then
   begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := DefaultPort;
    FServer.Active := True;
   end;
end;

procedure TSampleHTTPSEngine.StopServer;
begin
 FServer.Active :=False;
 ClearBindings;
end;

end.
