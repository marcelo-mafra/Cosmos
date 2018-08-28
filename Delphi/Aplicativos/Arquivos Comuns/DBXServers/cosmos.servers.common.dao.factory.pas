unit cosmos.servers.common.dao.factory;

interface

uses
  cosmos.servers.common.dao.interfaces, cosmos.servers.common.dataacess,
  cosmos.system.types;

type
 TCosmosDAOServiceFactory = class(TInterfacedObject, ICosmosDAOServiceFactory)
   private
    FICosmosDAOService: ICosmosDAOService;

   protected
    function GetDAOService: ICosmosDAOService;

   public
    constructor Create(Module: TCosmosModules);
    destructor Destroy; override;
    class function New(Module: TCosmosModules): ICosmosDAOServiceFactory;

    property DAOService: ICosmosDAOService read GetDAOService;
 end;

implementation

{ TCosmosDAOServiceFactory }

constructor TCosmosDAOServiceFactory.Create(Module: TCosmosModules);
begin
 FICosmosDAOService := TServerDataAcess.New(Module);
end;

destructor TCosmosDAOServiceFactory.Destroy;
begin
  FICosmosDAOService := nil;
  inherited;
end;

function TCosmosDAOServiceFactory.GetDAOService: ICosmosDAOService;
begin
 Result := FICosmosDAOService;
end;

class function TCosmosDAOServiceFactory.New(Module: TCosmosModules): ICosmosDAOServiceFactory;
begin
 Result := self.Create(Module);
end;

end.
