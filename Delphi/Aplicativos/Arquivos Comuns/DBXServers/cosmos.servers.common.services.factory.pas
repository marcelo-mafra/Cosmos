unit cosmos.servers.common.services.factory;

interface

uses
 cosmos.servers.common.servicesint, cosmos.system.types, cosmos.classes.logs,
  cosmos.servers.common.services ;

type
  TCosmosServiceFactory = class(TInterfacedObject, ICosmosServiceFactory)
    private
      FCosmosService: TCosmosServerServices;

    protected
      function GetCosmosLogs: ICosmosLogs;
      function GetCosmosService: ICosmosService;
      function GetDSService: ICosmosDSService;

    public
      constructor Create(Module: TCosmosModules);
      destructor Destroy; override;
      class function New(Module: TCosmosModules): ICosmosServiceFactory;

      property CosmosService: ICosmosService read GetCosmosService;
      property DSService: ICosmosDSService read GetDSService;
      property Logs: ICosmosLogs read GetCosmosLogs;
  end;

implementation

{ TCosmosServiceFactory }

constructor TCosmosServiceFactory.Create(Module: TCosmosModules);
begin
 FCosmosService := TCosmosServerServices.Create(Module);
end;

destructor TCosmosServiceFactory.Destroy;
begin
  FCosmosService.Free;
  inherited;
end;

function TCosmosServiceFactory.GetCosmosLogs: ICosmosLogs;
begin
 Result := FCosmosService.Logs;
end;

function TCosmosServiceFactory.GetCosmosService: ICosmosService;
begin
 Result:= FCosmosService;
end;

function TCosmosServiceFactory.GetDSService: ICosmosDSService;
begin
 Result := FCosmosService.DSService;
end;

class function TCosmosServiceFactory.New(Module: TCosmosModules): ICosmosServiceFactory;
begin
 Result := self.Create(Module);
end;

end.
