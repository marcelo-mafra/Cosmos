unit Cosmos.Framework.Interfaces.Security;

interface

uses System.Classes, cosmos.system.types, cosmos.classes.application;

type

  ICosmosSecurityInterface = interface
    ['{8B8E0257-B724-4D97-AD86-FA173B9FF946}']

  end;


 ICosmosUsersManager = interface(ICosmosSecurityInterface)
  ['{58EB2819-95E3-48FD-9CF8-7B4AFBD67621}']

  function ChangePassword(const UserName, NewPassword: string): integer;
  function CreateUser(UserData, FocusData: Olevariant; ActiveRange: integer): boolean;
  function DeleteUser(const codusu: integer): boolean;
  function GetUserStatus(const UserName: string): TUserStatus;
  procedure GetUserRoles(const UserName: string; List: TStringList);
  function GrantRole(const UserName, RoleName: string): boolean;
  procedure ListServerUsers(List: TStringList);
 end;

 implementation

end.
