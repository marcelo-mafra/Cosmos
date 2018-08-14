unit cosmos.classes.servers.security;

{Todos as operações executadas nos métodos desta classe são executadas usando
 o usuário SYSDBA. O sistema assume uma senha padrão para este usuário. Estas
 operações falharão caso não seja usado o usuário SYSDBA.}

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, cosmos.servers.sqlcommands,
  Data.DB, Datasnap.DBClient, cosmos.system.types, cosmos.system.messages,
  cosmos.classes.application, cosmos.system.exceptions, cosmos.classes.dataobjects,
  cosmos.classes.cosmoscript, System.WideStrings, cosmos.classes.serversutils;

type
  TCosmosUsersManager = class
  private
  { Private declarations }
   sSystemUser: string;
   FdbParamsFile: string;
   FConnectionsPool: TCosmosConnectionsPool;
   procedure CreateConnectionsPool;
   function HasCosmosUser(const UserName: string): boolean; inline;
   function UserIsBlocked(const UserName: string): boolean; inline;

  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

   function ChangePassword(const UserName, NewPassword: string): integer;
   function CreateUser(UserData, FocusData: Olevariant; ActiveRange: integer): boolean;
   function DeleteUser(const codusu: integer): boolean;
   function GetUserStatus(const UserName: string): TUserStatus;
   procedure GetUserRoles(const UserName: string; List: TStringList);
   function GrantRole(const UserName, RoleName: string): boolean;
   function RevokeRole(const UserName, RoleName: string): boolean;
   procedure ListServerUsers(List: TStringList);
   function LockCosmosUser(const codusu: integer): boolean;
   function UnlockCosmosUser(const codusu: integer): boolean;
   procedure GetUserInfo(const UserName, Password, RoleName: WideString;
     var UserData: TCosmosData);
   function IsAdministrator(const UserName: WideString): boolean;
   procedure SetAdministrator(const Value: string; UserId: integer);
  end;

implementation

{ TCosmosUsersManager }

constructor TCosmosUsersManager.Create;
begin
 inherited Create;
 FdbParamsFile := TCosmosInfoFiles.GetDatabaseConfigurationFile;
 CreateConnectionsPool;
 end;

procedure TCosmosUsersManager.CreateConnectionsPool;
begin
//Cria o pool de conexões que será usado durante toda a instância desse objeto.
 FConnectionsPool := TCosmosConnectionsPool.Create(FdbParamsFile);
 FConnectionsPool.FillPool(3); //Não é preciso deixar configurável isso.
end;

function TCosmosUsersManager.CreateUser(UserData,
  FocusData: Olevariant; ActiveRange: integer): boolean;
var
NewUserID, RoleID, codfoc, codcad: integer;
AScript: TStringList;
ACommand: TCosmosCommand;
AScriptObj: TCosmosScript;
ADataset: TClientDataset;
logusu, password, rolename, indati, indadm, tipper, indsec, indfin: string;
indblo, indpro, indcon, indfoc, indusu: string;
begin
//Cria um novo usuário do sistema cosmos e atribui os focos que possuirá acesso.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;

 ADataset := TClientDataset.Create(nil);
 AScriptObj := TCosmosScript.Create;
 AScriptObj.ConnectionsPool := FConnectionsPool;

 AScript := TStringList.Create;

 try
  with ADataset do
   begin
    Data := UserData; //Dados passados em parâmetro. Não é preciso abrir o dataset.
    logusu := Fields.FieldByName('logusu').AsString;
    password := TCripterFactory.Criptografar(Fields.FieldByName('passwrd').AsString);
    rolename := Fields.FieldByName('rolename').AsString;
    codcad := Fields.FieldByName('codcad').AsInteger;
    indati := Fields.FieldByName('indati').AsString;
    indadm := Fields.FieldByName('indadm').AsString;
    indblo := Fields.FieldByName('indblo').AsString;
    indpro := Fields.FieldByName('indpro').AsString;
   end;

   //Primeiro, verifica se o usuário já não está cadastrado.
   if HasCosmosUser(logusu) then
    raise EDuplicatedCosmosUser.Create(TCosmosErrorSecurityMsg.UsuarioExists);

   {Checa se um cadastrado já possui um login.}
   ACommand.ExecuteDQL(Format(TGUsersCommands.UsuarioByCadastrado, [codcad]), ADataset);

   if not ADataset.IsEmpty then
    raise EDuplicatedCosmosUser.Create(TCosmosErrorMsg.LoginAlreadyExists);

   {Obtém o código da Role do usuário.}
   ACommand.ExecuteDQL(Format(TGUsersCommands.CodigoPerfil, [QuotedStr(RoleName)]), ADataset);

   if not ADataset.IsEmpty then
    RoleID := ADataset.Fields.Fields[0].Value
   else
    raise EUnknownRole.Create(TCosmosErrorSecurityMsg.UnknownProfile);

   //Agora, insere na tabela de usuários do Cosmos as informações sobre o novo
   //usuário e os focos que pode acessar.
   ACommand.ExecuteDQL(Format(TDQLCommands.Generators, [TSequencesNames.GEN_USUARIOS, 1]), ADataset);

   NewUserID := ADataset.Fields.Fields[0].AsInteger + ActiveRange;

   //Monta o comando de criação do usuário.
   AScript.Append(Format(TSecurityCommand.InsertCosmosUser, [NewUserID, QuotedStr(logusu), QuotedStr(Password), codcad,
   QuotedStr(indati), QuotedStr(indadm), QuotedStr(indblo), QuotedStr(indpro)]));

   //Monta o comando de criação do perfil do usuário.
   AScript.Append(Format(TSecurityCommand.InsertPerfilUsuario, [NewUserID, RoleId]));

   //Monta os comandos de permissão de acesso aos núcleos.
   ADataset.Data := FocusData;
    while not ADataset.Eof do
     begin
      codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;
      tipper := QuotedStr(ADataset.Fields.FieldByName('tipper').AsString);
      indsec := QuotedStr(ADataset.Fields.FieldByName('indsec').AsString);
      indfin := QuotedStr(ADataset.Fields.FieldByName('indfin').AsString);
      indcon := QuotedStr(ADataset.Fields.FieldByName('indcon').AsString);
      indfoc := QuotedStr(ADataset.Fields.FieldByName('indfoc').AsString);
      indusu := QuotedStr(ADataset.Fields.FieldByName('indusu').AsString);

      AScript.Append(Format(TSecurityCommand.InsertPrivilegios, [NewUserID, codfoc, tipper, indsec,
       indfin, indcon, indfoc, indusu]));
      ADataset.Next;
     end;

   Result := aScriptObj.ExecuteScript(AScript);

   //Usuário criado com sucesso.
   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(AScript) then FreeAndNil(AScript);
   if Assigned(ACommand) then FreeAndNil(ACommand);
   if Assigned(aScriptObj) then FreeAndNil(aScriptObj);

 except
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(AScript) then FreeAndNil(AScript);
   if Assigned(ACommand) then FreeAndNil(ACommand);
   if Assigned(aScriptObj) then FreeAndNil(aScriptObj);

   raise;
  end;
 end;
end;

destructor TCosmosUsersManager.Destroy;
begin
 if Assigned(FConnectionsPool) then
   begin
    FConnectionsPool.ClearAll;
    FreeAndNil(FConnectionsPool);
   end;

  inherited;
end;

function TCosmosUsersManager.ChangePassword(const UserName,
  NewPassword: string): integer;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
//Altera a senha de um usuário.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.UsuarioByLogin, [QuotedStr(UpperCase(UserName))]), ADataset);

  if ADataset.IsEmpty then
    Result := 2
  else
   begin
    Result := ACommand.ExecuteCommand(Format(TSecurityCommand.ChangePassword, [TCripterFactory.Criptografar(NewPassword).QuotedString, QuotedStr(UserName.ToLower)]));
    if Result = 0 then //O comando não alterou nenhum registro!
     raise ECreateCosmosUser.Create(Format(TCosmosErrorMsg.PasswordUpdate, [UserName]));

    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;

 except
  on E: Exception do
   begin
    Result := 2;
    if Assigned(ADataset) then  FreeAndNil(ADataset);
    if Assigned(ACommand) then FreeAndNil(ACommand);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

function TCosmosUsersManager.DeleteUser(const codusu: integer): boolean;
var
 ACommand: TCosmosCommand;
begin
//Exclui um usuário.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;

 try
  Result := ACommand.ExecuteCommand(Format(TGUsersCommands.DeleteUser, [codusu])) > 0;
  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

procedure TCosmosUsersManager.GetUserInfo(const UserName, Password,
  RoleName: WideString; var UserData: TCosmosData);
var
 ACommand: TCosmosCommand;
 AList: TStringList;
 ADataset: TClientDataset;
begin
 AList := TStringList.Create;
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.UsuarioInfo, [QuotedStr(UserName)]), ADataset);

  //Testa se o login do usuário existe...
  if ADataset.IsEmpty then //Não encontrou um usuário com o login indicado...
    raise EUnknownUser.Create(TCosmosErrorSecurityMsg.UnknownUser);

  //Testa se a senha do usuário está correta. O teste é feito com a senha criptografada.
  if Password <> ADataset.Fields.FieldByName('paswrd').AsString then //Senha do usuário é inválida...
    raise EValidateUser.Create(TCosmosErrorMsg.PasswordNotConfirmed);

  if Assigned(UserData) then
   begin
    with ADataset.Fields do
     begin
      UserData.WriteValue('CODUSU', FieldByName('codusu').AsInteger);
      UserData.WriteValue('LOGIN', FieldByName('logusu').AsString, 1);
      UserData.WriteValue('USER_NAME', FieldByName('nomcad').AsString, 2);
      UserData.WriteValue('FOCO', FieldByName('sigfoc').AsString, 3);
      UserData.WriteValue('MATRICULA', FieldByName('matcad').AsString, 4);
      UserData.WriteValue('DISCIPULADO', FieldByName('sigdis').AsString, 5);

      //Usuário está ativo?
      if FieldByName('indati').Value = 'S' then
       UserData.WriteValue('ATIVO', True, 6)
      else
       UserData.WriteValue('ATIVO', False, 6);

      //Usuário é administrador?
      if FieldByName('indadm').Value = 'S' then
       UserData.WriteValue('ADM', True, 7)
      else
       UserData.WriteValue('ADM', False, 7);
     end;

    //Testa se a role do usuário está correta.
    self.GetUserRoles(UserName, AList);

    if AList.IndexOf(RoleName) < 0 then
     raise EIncorrectRoleAcess.Create(TCosmosErrorMsg.IncorrectRoleName);

    if Assigned(AList) then
     FreeAndNil(AList);

    //Agora, checa quais campos de trabalho poderão ser acessados pelo usuário.
    ACommand.ExecuteDQL(Format(TSecurityCommand.PerfilUsuario, [QuotedStr(UpperCase(RoleName))]), ADataset);
    with ADataset.Fields do
     begin
      UserData.WriteValue('INDLEC', FieldByName('INDLEC').AsString, 8);
      UserData.WriteValue('INDTMO', FieldByName('INDTMO').AsString, 9);
      UserData.WriteValue('INDTMB', FieldByName('INDTMB').AsString, 10);
      UserData.WriteValue('INDTPU', FieldByName('INDTPU').AsString, 11);
      UserData.WriteValue('INDEIN', FieldByName('INDEIN').AsString, 12);
      UserData.WriteValue('ABRANGENCIA', FieldByName('ABRPER').AsString, 13);
     end;
   end;

 if Assigned(AList) then FreeAndNil(AList);
 if Assigned(ACommand) then FreeAndNil(ACommand);
 if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  if Assigned(AList) then FreeAndNil(AList);
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  raise;
 end;
end;

procedure TCosmosUsersManager.GetUserRoles(const UserName: string;
  List: TStringList);
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
//Lista as roles atribuídas a um usuário.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TGUsersCommands.UserRoles, [QuotedStr(UserName)]), ADataset);

  while not ADataset.Eof do
   begin
    List.Append(TrimRight(ADataset.Fields.FieldByName('nomper').AsString));
    ADataset.Next;
   end;

  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;

end;

function TCosmosUsersManager.GetUserStatus(const UserName: string): TUserStatus;
var
vCosmosUser, vBlockedUser: boolean;
begin
 Result := usUnknown;

 //Verifica se o usuário que está acessando é o sysdba
 if LowerCase(UserName) = sSystemUser then
  begin
   Result := usSysdba;
   Exit;
  end;

 try
  //Verifica se o usuário está cadastrado na tabela de usuários do Cosmos.
  vCosmosUser := self.HasCosmosUser(UserName);

 except
  Result := usUnknown;
  Exit;
 end;

  //...Se estiver, verifica se o usuário está bloqueado
 if vCosmosUser = True then
  vBlockedUser := self.UserIsBlocked(UserName)
 else
   vBlockedUser := False;


 //Agora, "calcula" o status do usuário.
 if (vCosmosUser = True) and (vBlockedUser = False) then
  Result := usCosmosUser;

 if (vCosmosUser = True) and (vBlockedUser = True) then
  Result := usBlockedUser;

 if (vCosmosUser = False) then
  Result := usUnknown;
end;

function TCosmosUsersManager.GrantRole(const UserName, RoleName: string): boolean;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
 codusu, codper: integer;
begin
//Atribui uma role a um usuário.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  //Primeiro, obtém o código do usuário passado em parâmentro.
  ACommand.ExecuteDQL(Format(TSecurityCommand.UserInfo, [QuotedStr(UpperCase(UserName))]), ADataset);

  if not ADataset.IsEmpty then
   codusu := ADataset.Fields.FieldByName('CODUSU').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  //Agora, obtém o código do perfil passado em parâmentro.
  ACommand.ExecuteDQL(Format(TGUsersCommands.CodigoPerfil, [QuotedStr(UpperCase(RoleName))]), ADataset);

  if not ADataset.IsEmpty then
   codper := ADataset.Fields.FieldByName('CODPER').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  //Executa o comando para inserir atribuir o perfil ao usuário.
  Result :=  ACommand.ExecuteCommand(Format(TSecurityCommand.InsertPerfilUsuario, [codusu, codper])) > 0;

  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    Result := False;
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;

end;

function TCosmosUsersManager.HasCosmosUser(const UserName: string): boolean;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
//Verifica se um usuário está cadastrado na tabela de usuários do Cosmos.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.UserInfo, [QuotedStr(UserName)]), ADataset);
  Result := not ADataset.IsEmpty;

  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    Result := False;

    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

function TCosmosUsersManager.IsAdministrator(
  const UserName: WideString): boolean;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
//Checa se um usuário é um administrador do sistema.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.AdmUser,[QuotedStr(UserName)]), ADataset);
  Result := ADataset.Fields.Fields[0].AsString = 'S';

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TCosmosUsersManager.ListServerUsers(List: TStringList);
begin
//To do.
end;

function TCosmosUsersManager.LockCosmosUser(const codusu: integer): boolean;
var
 ACommand: TCosmosCommand;
begin
//Bloqueia um usuário do Cosmos.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;

 try
  //Executa o comando para bloquear o usuário.
  Result := ACommand.ExecuteCommand(Format(TGUsersCommands.LockUser, [QuotedStr('S'), codusu])) > 0;

  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

function TCosmosUsersManager.RevokeRole(const UserName,
  RoleName: string): boolean;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
 codusu, codper: integer;
begin
//Retira uma role de um usuário.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  //Primeiro, obtém o código do usuário passado em parâmentro.
  ACommand.ExecuteDQL(Format(TSecurityCommand.UserInfo, [QuotedStr(UpperCase(UserName))]), ADataset);

  if not ADataset.IsEmpty then
   codusu := ADataset.Fields.FieldByName('CODUSU').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  //Agora, obtém o código do perfil passado em parâmentro.
  ACommand.ExecuteDQL(Format(TGUsersCommands.CodigoPerfil, [QuotedStr(UpperCase(RoleName))]), ADataset);

  if not ADataset.IsEmpty then
   codper := ADataset.Fields.FieldByName('CODPER').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  //Executa o comando para inserir atribuir o perfil ao usuário.
  Result := ACommand.ExecuteCommand(Format(TSecurityCommand.DelPerfilUsuario, [codusu, codper])) > 0;

  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

procedure TCosmosUsersManager.SetAdministrator(const Value: string;
  UserId: integer);
var
 ACommand: TCosmosCommand;
begin
{Atribui ou retira os direitos de administrador do sistema para um usuário.}
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;

 try
  //Executa o comando...
  ACommand.ExecuteCommand(Format(TGUsersCommands.UserAdministrator, [QuotedStr(Value), UserId]));

  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

function TCosmosUsersManager.UnlockCosmosUser(const codusu: integer): boolean;
var
 ACommand: TCosmosCommand;
begin
//Desbloqueia um usuário do Cosmos.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;

 try
  //Executa o comando para desbloquear o usuário.
  Result := ACommand.ExecuteCommand(Format(TGUsersCommands.LockUser, [QuotedStr('N'), codusu])) > 0;

  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

function TCosmosUsersManager.UserIsBlocked(const UserName: string): boolean;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
//Verifica se um usuário está bloqueado.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.UsuarioInfo, [QuotedStr(UserName)]), ADataset);
  Result := (ADataset.RecordCount > 0) and (ADataset.Fields.FieldByName('indblo').Value = 'S');

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;


end.
