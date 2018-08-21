unit cosmos.servers.common.dao.factory;

interface

uses
  cosmos.servers.common.dao.interfaces, cosmos.servers.common.dataacess,
  cosmos.system.types;

type
 TCosmosDAOServiceFactory = class(TInterfacedObject, ICosmosDAOServiceFactory)
   private
    FServerDataAcess: TDMServerDataAcess;

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
 FServerDataAcess := TDMServerDataAcess.Create(Module);
end;

destructor TCosmosDAOServiceFactory.Destroy;
begin
  FServerDataAcess.Free;
  inherited;
end;

function TCosmosDAOServiceFactory.GetDAOService: ICosmosDAOService;
begin
 Result := FServerDataAcess;
end;

class function TCosmosDAOServiceFactory.New(Module: TCosmosModules): ICosmosDAOServiceFactory;
begin
 Result := self.Create(Module);
end;

end.
