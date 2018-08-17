unit cosmos.classes.servers.datobjint;

{Unidade de interfaces para o uso das classes de acesso a dados e sugurança. As
 aplicações Cosmos não devem usar diretamente as classes que realizam essas
 operações, mas apens certas classes intermediárias que implementam as interfaces
 abaixo.}

interface

uses
 System.Classes, DataSnap.DBClient, cosmos.classes.application, cosmos.system.types;

type
  ICosmosDataObj = interface
    ['{63411AAE-06C7-4FFA-84F9-6DF55C49D487}']
  end;

  ICosmosCommand = interface(ICosmosDataObj)
    ['{A3472639-FD3E-4D5E-8F06-A40D2B2D0AE1}']
    function ExecuteCommand(const Command: WideString): integer;
    procedure ExecuteDQL(const DQL: WideString; Dataset: TClientDataset);
  end;

 ICosmosScript = interface(ICosmosDataObj)
   ['{0FD7700D-57AD-43F6-829B-3D02C08209C5}']
   procedure AddCommand(Command: string);
   procedure ClearCommands;
   function ExecuteScript: boolean; overload;
   function ExecuteScript(Script: TStringList): boolean; overload;
 end;

 ICosmosUsersManager = interface(ICosmosDataObj)
   ['{F1682048-15B9-4568-A066-B375848E4C4E}']

   //Autenticação
   function AuthenticateUser(const UserName, Password: string): boolean;

   //Senhas
   function ChangePassword(const UserName, NewPassword: string): integer;
   function CreatePassword: string;
   function PasswordIsTemporary(const UserName: string): boolean;
   procedure ResetPasword(const UserName: string; out NewPassword: string);

   //Usuários
   function CreateUser(UserData, FocusData: Olevariant; ActiveRange: integer): boolean;
   function DeleteUser(const codusu: integer): boolean;
   procedure GetUserInfo(const UserName: WideString;
     var UserData: TCosmosData);
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


  end;



implementation



end.
