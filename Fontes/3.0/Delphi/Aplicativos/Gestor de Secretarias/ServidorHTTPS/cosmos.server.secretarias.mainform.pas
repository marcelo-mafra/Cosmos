unit cosmos.server.secretarias.mainform;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.IniFiles,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls,  Cosmos.System.Messages, Cosmos.Classes.Application,
  cosmos.servers.common.httpsengine; {IdHTTPWebBrokerBridge,
  IdSSLOpenSSL, IdSchedulerOfThreadPool}

type
  TFrmServerMainForm = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    LblPort: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    //Senha da chave privada do certificado digital gerado para a aplicação.
    sPrivateKey: string;
    APort: integer;
    FServer: TSampleHTTPSEngine;
    //FServer: TIdHTTPWebBrokerBridge;
    //FSchedulerOfThreadPool: TIdSchedulerOfThreadPool;

    //procedure StartServer;
    //procedure OnGetSSLPassword(var APassword: String);

  public
    { Public declarations }
  end;

var
  FrmServerMainForm: TFrmServerMainForm;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession;

procedure TFrmServerMainForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
end;

procedure TFrmServerMainForm.ButtonStartClick(Sender: TObject);
begin
  FServer.StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TFrmServerMainForm.ButtonStopClick(Sender: TObject);
begin
  TerminateThreads;
  FServer.StopServer;
  {FServer.Active := False;
  FServer.ClearBindings;
  FServer.Bindings.Clear;}
end;

procedure TFrmServerMainForm.FormCreate(Sender: TObject);
var
  //LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
  aStarterFile: TIniFile;
  MaxConnections:Integer;
  AFileName, CertFile, RootCertFile, KeyFile: string;
  CosmosApp: TCosmosApplication;
begin
{Executa o servidor standalone https, iniciando por obter as configurações
 do servidor como certificados ssl, porta de comunicação etc.}
 CosmosApp := TCosmosApplication.Create;
 AFileName := CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot;
 aStarterFile := TIniFile.Create(AFileName);

 try
  //Certificado da Autoridade Certificadora.
  RootCertFile := aStarterFile.ReadString('Certificates', 'RootCertFile', '');
  //Certificado público do Cosmos.
  CertFile := aStarterFile.ReadString('Certificates', 'CertificateFile', '');
  //Chave privada do Cosmos.
  KeyFile := aStarterFile.ReadString('Certificates', 'PrivateKeyFile', '');
  //Senha da chave privada.
  sPrivateKey := aStarterFile.ReadString('Certificates', 'PrivateKey', '');
  //Porta que o servidor estará escutando.
  APort := aStarterFile.ReadInteger('GSEC', 'DSHTTPService.HttpsPort', 443);
  //Número máximo de conexões concorrentes que serão aceitas pelo servidor.
  MaxConnections := aStarterFile.ReadInteger('GSEC', 'DSHTTPService.MaxConnections', 100);

 finally
  aStarterFile.Free;
  CosmosApp.Free;
 end;

  {//Cria o objeto que implementa o servidor https.
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
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
  self.StartServer;}

  FServer := TSampleHTTPSEngine.Create(CertFile, RootCertFile, KeyFile, sPrivateKey, MaxConnections);
  FServer.DefaultPort := APort;
  FServer.StartServer;
end;

procedure TFrmServerMainForm.Label2Click(Sender: TObject);
var
  LURL: string;
begin
  FServer.StartServer;
  LURL := Format('https://localhost:%s', [APort.ToString]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFrmServerMainForm.Label2MouseLeave(Sender: TObject);
begin
 TLabel(Sender).Font.Style := [];
end;

procedure TFrmServerMainForm.Label2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 TLabel(Sender).Font.Style := [fsUnderline];
end;

{procedure TFrmServerMainForm.OnGetSSLPassword(var APassword: String);
begin
 APassword := sPrivateKey;
end;

procedure TFrmServerMainForm.StartServer;
begin
  if not FServer.Active then
   begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := APort;
    FServer.Active := True;
    LblPort.Caption := APort.ToString;
   end;
end; }

end.
