unit cosmos.classes.serversobj;

interface

uses
 Classes, Windows, SysUtils, Data.SQLExpr, cosmos.system.types, cosmos.system.files,
 cosmos.system.messages, cosmos.classes.application, cosmos.servers.sqlcommands,
 cosmos.classes.persistence.ini, cosmos.classes.dataobjects;

type

 TCosmosMethods = class
  private

  public
   class function GetServerDateTime: TDateTime;
   class function IsAdministrator(const UserName: WideString): Boolean;
   class function CanAccessModule(const UserId: integer; CosmosModule: TCosmosModules): boolean;
   class function GetCosmosSearchs: string;
 end;


implementation

{ TCosmosFields }

{ TCosmosMethods }

class function TCosmosMethods.CanAccessModule(const UserId: integer;
  CosmosModule: TCosmosModules): boolean;
var
ACommand: TSQLServerCommand;
AConnection: TSQLConnection;
ADataset: TSQLDataset;
sCommand, sParam: string;
begin
{Verifica se um usuário pode acessar determinado módulo do Cosmos.}
 ACommand := TSQLServerCommand.Create;
 AConnection :=  ACommand.CreateConnection;
 ADataset := TSQLDataset.Create(nil);
 ADataset.SQLConnection := AConnection;

 try
  case CosmosModule of
    cmFocosServer, cmFocos: sParam := 'INDFOC = %s';
    cmSecretariasServer, cmSecretarias: sParam := 'INDSEC = %s';
    cmFinanceiroServer, cmFinanceiro: sParam := 'INDFIN = %s';
    cmConferenciasServer, cmConferencias: sParam := 'INDCON = %s';
    cmUsuariosServer, cmUsuarios: sParam := 'INDUSU = %s';
  end;

  sParam := Format(sParam, [QuotedStr('S')]);

  sCommand := Format(TSecurityCommand.UserModules, [UserId, sParam]);
  ACommand.ExecuteDQL(sCommand, ADataset);

  Result := not ADataset.IsEmpty;

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(AConnection) then FreeAndNil(AConnection);
    raise;
   end;
 end;
end;

class function TCosmosMethods.GetCosmosSearchs: string;
var
Buffer: array[0..260] of Char;
CosmosFolder, sFilePath: string;
AFile: TIniFilePersistence;
begin
{Obtém o caminho do arquivo de mapeamento de pesquisas da ferramenta
Central de Relatórios.}
 try
  GetModuleFileName(0, Buffer, SizeOf(Buffer));
  CosmosFolder := Buffer;
  CosmosFolder := ExtractFilePath(CosmosFolder);
  sFilePath := CosmosFolder + TCosmosFiles.CosmosRoot; //do not localize!

  AFile := TIniFilePersistence.Create(sFilePath, False);
  Result := AFile.ReadString('AdmFiles', 'CosmosSearchsInfo', ''); //do not localize!

  except
   if Assigned(AFile) then
    FreeAndNil(AFile);
   raise;
  end;
end;

class function TCosmosMethods.GetServerDateTime: TDateTime;
begin
//Retorna data e hora do servidor.
 Result := Now;
end;

class function TCosmosMethods.IsAdministrator(
  const UserName: WideString): Boolean;
var
ACommand: TSQLServerCommand;
ADataset: TSQLDataset;
sCommand: string;
begin
//Checa se um usuário é um administrador do sistema.
 ACommand := TSQLServerCommand.Create;

 try
  sCommand := Format(TSecurityCommand.AdmUSer,[QuotedStr(UserName)]);
  ACommand.ExecuteDQL(sCommand, ADataset);
  Result := ADataset.Fields.Fields[0].AsString = 'S';

  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise;
   end;
 end;
end;

end.
