unit cosmos.system.types.cmhelpers;

interface

uses
 cosmos.system.types, cosmos.system.messages;

type
 TCosmosModulesHelper = record helper for TCosmosModules
   function ModuleName: string;
   function ModuleNameShort: string;
   function ModuleId: string;
 end;

implementation

{ TCosmosModulesHelper }

function TCosmosModulesHelper.ModuleId: string;
begin
 case self of
   cmFocos, cmFocosServer: Result := TCosmosAppName.CosmosFocosId;
   cmSecretarias, cmSecretariasServer: Result := TCosmosAppName.CosmosSecretariasId;
   cmFinanceiro, cmFinanceiroServer: Result := TCosmosAppName.CosmosFinanceiroId;
   cmConferencias, cmConferenciasServer: Result := TCosmosAppName.CosmosConferenciasId;
   cmUsuarios, cmUsuariosServer: Result := TCosmosAppName.CosmosUsuariosId;
 end;
end;

function TCosmosModulesHelper.ModuleName: string;
begin
 case self of
   cmFocos: Result := TCosmosAppName.CosmosFocos;
   cmFocosServer: Result := TCosmosAppName.CosmosFocosServer;
   cmSecretarias: Result := TCosmosAppName.CosmosSecretarias;
   cmSecretariasServer: Result := TCosmosAppName.CosmosSecretariasServer;
   cmFinanceiro: Result := TCosmosAppName.CosmosFinanceiro;
   cmFinanceiroServer: Result := TCosmosAppName.CosmosFinanceiroServer;
   cmConferencias: Result := TCosmosAppName.CosmosConferencias;
   cmConferenciasServer: Result := TCosmosAppName.CosmosConferenciasServer;
   cmUsuarios: Result := TCosmosAppName.CosmosUsuarios;
   cmUsuariosServer: Result := TCosmosAppName.CosmosUsuariosServer;
 end;
end;

function TCosmosModulesHelper.ModuleNameShort: string;
begin
 case self of
   cmFocos, cmFocosServer: Result := TCosmosAppName.CosmosFocosShort;
   cmSecretarias, cmSecretariasServer: Result := TCosmosAppName.CosmosSecretariasShort;
   cmFinanceiro, cmFinanceiroServer: Result := TCosmosAppName.CosmosFinanceiroShort;
   cmConferencias, cmConferenciasServer: Result := TCosmosAppName.CosmosConferenciasShort;
   cmUsuarios, cmUsuariosServer: Result := TCosmosAppName.CosmosUsuariosShort;
 end;
end;

end.
