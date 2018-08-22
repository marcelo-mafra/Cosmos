unit cosmos.servers.common.security;

interface

uses
  System.SysUtils, System.Classes, cosmos.system.exceptions, cosmos.system.types,
  cosmos.classes.logs, cosmos.system.messages, cosmos.servers.sqlcommands,
  cosmos.classes.application, cosmos.classes.utils.cosmoscript,
  cosmos.classes.servers.securityobj, cosmos.classes.servers.datobjint,
  cosmos.servers.common.servicesint, cosmos.servers.common.services.factory;


 type
  TCosmosSecurity = class(TInterfacedObject, ICosmosUsersManager)

   private
     FModule: TCosmosModules;
     FCosmosServiceFactory: ICosmosServiceFactory;
     function CreatePassword: string;
     function GetCosmosService: ICosmosService;

   protected
     //Autenticação
     function AuthenticateUser(const UserName, Password: string): boolean;

     //Senhas
     function ChangePassword(const UserName, NewPassword: string): integer;
     function PasswordIsTemporary(const UserName: string): boolean;
     procedure ResetPasword(const UserName: string; out NewPassword: string);

     //Usuários
     function CreateUser(UserData, FocusData: Olevariant; ActiveRange: integer): boolean;
     function DeleteUser(const codusu: integer): boolean;
     procedure GetUserInfo(const UserName: WideString; var UserData: TCosmosData);
     function GetUserStatus(const UserName: string): TUserStatus;

     //Bloqueios e desbloqueios
     function LockCosmosUser(const codusu: integer): boolean;
     function UnlockCosmosUser(const codusu: integer): boolean;
     function UserIsBlocked(const UserName: string): boolean;

     //Roles
     procedure GetUserRoles(const UserName: string; Roles: TStrings);
     function GrantRole(const UserName, RoleName: string): boolean;
     function RevokeRole(const UserName, RoleName: string): boolean;

     //Privilégios
     function CanAcessModule(const UserName: string; Module: TCosmosModules): boolean;
     function IsAdministrator(const UserName: WideString): boolean;
     procedure SetAdministrator(const Value: string; UserId: integer);

   public
     constructor Create(Module: TCosmosModules);
     destructor Destroy; override;

     property CosmosServerService: ICosmosService read GetCosmosService;
  end;


implementation


{ TComosSecurity }

function TCosmosSecurity.AuthenticateUser(const UserName,
  Password: string): boolean;
var
 UserManager: TCosmosUsersManager;

begin
 {Autentica o usuário com a senha passada em parâmetro. A autenticação basicamente
  verifica se existe um usuário com login e senha passados. Este método não verifica
  se o usuário está ativo ou bloqueado.}
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.AuthenticateUser(UserName, Password);

  //Registra um log da operação feita com sucesso.
  CosmosServerService.RegisterLog(Format(TSecurityConst.AutenticacaoSucesso, [UserName]), '', leOnInformation);

  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
    Result := False;
    if Assigned(UserManager) then FreeAndNil(UserManager);
    CosmosServerService.RegisterLog(E.Message, '', leOnError);
   end;
 end;

end;

function TCosmosSecurity.CanAcessModule(const UserName: string;
  Module: TCosmosModules): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.CanAcessModule(UserName, Module);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.ChangePassword(const UserName,
  NewPassword: string): integer;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.ChangePassword(UserName, NewPassword);
  if Assigned(UserManager) then FreeAndNil(UserManager);


 except
  on E: Exception do
   begin
    if Assigned(UserManager) then FreeAndNil(UserManager);
    CosmosServerService.RegisterLog(E.Message, '', leOnError);
    raise;
   end;
 end;
end;

constructor TCosmosSecurity.Create(Module: TCosmosModules);
begin
 inherited Create;
 FModule := Module;
 FCosmosServiceFactory := TCosmosServiceFactory.New(Module);
end;

function TCosmosSecurity.CreatePassword: string;
const
  conso: array [0..19] of Char = ('b', 'c', 'd', 'f', 'g', 'h', 'j',
    'k', 'l', 'm', 'n', 'p', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z');
  vocal: array [0..4] of Char = ('a', 'e', 'i', 'o', 'u');
var
  i: Integer;
begin
 //Retorna uma senha randômica .
  Result := '';
  for i := 1 to 5 do
    begin
      Result := Result + conso[Random(19)];
      Result := Result + vocal[Random(4)];
    end;
end;

function TCosmosSecurity.CreateUser(UserData, FocusData: Olevariant;
  ActiveRange: integer): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.CreateUser(UserData, FocusData,ActiveRange);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.DeleteUser(const codusu: integer): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.DeleteUser(codusu);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

destructor TCosmosSecurity.Destroy;
begin
  FCosmosServiceFactory := nil;
  inherited;
end;

function TCosmosSecurity.GetCosmosService: ICosmosService;
begin
 Result := self.FCosmosServiceFactory.CosmosService;
end;

procedure TCosmosSecurity.GetUserInfo(const UserName: WideString; var UserData: TCosmosData);
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  UserManager.GetUserInfo(UserName, UserData);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

procedure TCosmosSecurity.GetUserRoles(const UserName: string;
  Roles: TStrings);
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  UserManager.GetUserRoles(UserName, Roles);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.GetUserStatus(const UserName: string): TUserStatus;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.GetUserStatus(UserName);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.GrantRole(const UserName,
  RoleName: string): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.GrantRole(UserName, RoleName);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.IsAdministrator(
  const UserName: WideString): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.IsAdministrator(UserName);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.LockCosmosUser(const codusu: integer): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.LockCosmosUser(codusu);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.PasswordIsTemporary(
  const UserName: string): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.PasswordIsTemporary(UserName);
  if Assigned(UserManager) then FreeAndNil(UserManager);


 except
  on E: Exception do
   begin
    if Assigned(UserManager) then FreeAndNil(UserManager);
    CosmosServerService.RegisterLog(E.Message, '', leOnError);
    raise;
   end;
 end;
end;

procedure TCosmosSecurity.ResetPasword(const UserName: string;
  out NewPassword: string);
var
 UserManager: TCosmosUsersManager;
begin
{Reseta a senha de um usuário e a marca como provisória.}
 UserManager := TCosmosUsersManager.Create;

 try
  NewPassword := CreatePassword;
  UserManager.ResetPasword(UserName, NewPassword);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.RevokeRole(const UserName,
  RoleName: string): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.RevokeRole(UserName, RoleName);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;

end;

procedure TCosmosSecurity.SetAdministrator(const Value: string;
  UserId: integer);
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  UserManager.SetAdministrator(Value, UserId);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;

end;

function TCosmosSecurity.UnlockCosmosUser(const codusu: integer): boolean;
var
 UserManager: TCosmosUsersManager;
begin
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.UnlockCosmosUser(codusu);
  if Assigned(UserManager) then FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
     if Assigned(UserManager) then FreeAndNil(UserManager);
     CosmosServerService.RegisterLog(E.Message, '', leOnError);
     raise;
   end;
 end;
end;

function TCosmosSecurity.UserIsBlocked(const UserName: string): boolean;
begin
 Result := self.GetUserStatus(UserName) = usBlockedUser;
end;

end.
