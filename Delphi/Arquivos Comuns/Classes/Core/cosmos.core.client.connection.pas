unit cosmos.core.client.connection;

interface

uses
  winapi.Windows, system.SysUtils, cosmos.system.types, cosmos.system.nettypes;

type
 TClientConnectionInfo = class
  private
   FBufferKBSize: integer;
   FConnectionID: TGUID;
   FConnectionName: string;
   FConnectionTimeout: integer;
   FCommunicationTimeout: integer;
   FProtocolo: TConnectionProtocol;
   FNotifyMode: TNotifyMode;
   FAgent: string;
   FServerHost: string;
   FServerPort: integer;
   FProxyHost: string;
   FProxyPort: string;
   FProxyUsername: string;
   FProxyPassword: string;
   FProxyByPass: string;
   FDatasnapContext: string;
   FEnabled: boolean;

  public
   constructor Create;
   destructor Destroy; override;

   procedure SetProtocolo(value: TConnectionProtocol);

   property BufferKBSize: integer read FBufferKBSize write FBufferKBSize;
   property ConnectionID: TGUID read FConnectionID write FConnectionID;
   property ConnectionName: string read FConnectionName write FConnectionName;
   property ConnectionTimeout: integer read FConnectionTimeout write FConnectionTimeout;
   property CommunicationTimeout: integer read FCommunicationTimeout write FCommunicationTimeout;
   property Enabled: boolean read FEnabled write FEnabled;
   property Protocolo: TConnectionProtocol read FProtocolo write SetProtocolo;
   property NotifyMode: TNotifyMode read FNotifyMode write FNotifyMode;

   property Agent: string read FAgent write FAgent;
   property ProxyHost: string read FProxyHost write FProxyHost;
   property ProxyPort: string read FProxyPort write FProxyPort;
   property ProxyUsername: string read FProxyUsername write FProxyUsername;
   property ProxyPassword: string read FProxyPassword write FProxyPassword;
   property ProxyByPass: string read FProxyByPass write FProxyByPass;
   property ServerHost: string read FServerHost write FServerHost;
   property ServerPort: integer read FServerPort write FServerPort;
   property DatasnapContext: string read FDatasnapContext write FDatasnapContext;


 end;

implementation

{ TClientConnectionInfo }

constructor TClientConnectionInfo.Create;
begin
 inherited Create;
 CreateGUID(FConnectionID);
 Enabled := True;
end;

destructor TClientConnectionInfo.Destroy;
begin
 inherited Destroy;
end;

procedure TClientConnectionInfo.SetProtocolo(value: TConnectionProtocol);
begin
 FProtocolo := value;
end;

end.
