unit cosmos.servers.common.dsservices;

interface

uses
  cosmos.servers.common.servicesint, Datasnap.DSSession;

type
  //Serviços do Datasnap.
  TCosmosDSService = class(TInterfacedObject, ICosmosDSService)
    protected
      function FindSession(const SessionId: string): TDSSession;
      function GetConnectedUser: string;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: ICosmosDSService;

      property ConnectedUser: string read GetConnectedUser;
  end;

implementation

{ TCosmosDSService }
constructor TCosmosDSService.Create;
begin
 inherited;
end;

destructor TCosmosDSService.Destroy;
begin

  inherited;
end;

function TCosmosDSService.FindSession(
  const SessionId: string): TDSSession;
begin
 //Retorna um objeto TDSSession para trabalho.
 Result := TDSSessionManager.Instance.Session[SessionId];
end;

function TCosmosDSService.GetConnectedUser: string;
begin
 Result := TDSSessionManager.GetThreadSession.GetData('ConnectedUser'); //do not localize!
end;

class function TCosmosDSService.New: ICosmosDSService;
begin
 Result := self.Create;
end;


end.
