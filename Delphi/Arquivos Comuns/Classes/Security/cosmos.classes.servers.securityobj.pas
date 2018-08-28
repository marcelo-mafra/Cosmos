unit cosmos.classes.servers.securityobj;

{Todos as operações executadas nos métodos desta classe são executadas usando
 o usuário SYSDBA. O sistema assume uma senha padrão para este usuário. Estas
 operações falharão caso não seja usado o usuário SYSDBA.}

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, cosmos.servers.sqlcommands,
  Data.DB, Datasnap.DBClient, cosmos.system.types, cosmos.system.messages,
  cosmos.classes.application, cosmos.system.exceptions, cosmos.classes.servers.dataobj,
  cosmos.classes.utils.cosmoscript, System.WideStrings, cosmos.classes.servers.utils,
  cosmos.data.dbobjects.sequences;

type
  ECreateCosmosUser = Exception;
  EUnknownCosmosUser = Exception;

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

   //Autenticação
   function AuthenticateUser(const UserName, Password: string): boolean;

   //Usuários e senhas
   function ChangePassword(const UserName, NewPassword: string): integer;
   function CreateUser(UserData, FocusData: Olevariant; ActiveRange: integer): boolean;
   function DeleteUser(const codusu: integer): boolean;
   procedure GetUserInfo(const UserName: WideString;
     var UserData: TCosmosData);
   function GetUserStatus(const UserName: string): TUserStatus;
   function PasswordIsTemporary(const UserName: string): boolean;
   function ResetPasword(const UserName: string; var NewPassword: string): string;

   //Bloqueios e desbloqueios
   function LockCosmosUser(const codusu: integer): boolean;
   function UnlockCosmosUser(const codusu: integer): boolean;

   //Roles
   procedure GetUserRoles(const UserName: string; List: TStrings);
   function GrantRole(const UserName, RoleName: string): boolean;
   function RevokeRole(const UserName, RoleName: string): boolean;

   //Privilégios
   function CanAcessModule(const UserName: string; Module: TCosmosModules): boolean;
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
    logusu := Fields.FieldByName('logusu').AsString; //do not localize!
    password := TCripterFactory.Criptografar(Fields.FieldByName('passwrd').AsString); //do not localize!
    rolename := Fields.FieldByName('rolename').AsString; //do not localize!
    codcad := Fields.FieldByName('codcad').AsInteger; //do not localize!
    indati := Fields.FieldByName('indati').AsString; //do not localize!
    indadm := Fields.FieldByName('indadm').AsString; //do not localize!
    indblo := Fields.FieldByName('indblo').AsString; //do not localize!
    indpro := Fields.FieldByName('indpro').AsString; //do not localize!
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
      codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger; //do not localize!
      tipper := QuotedStr(ADataset.Fields.FieldByName('tipper').AsString); //do not localize!
      indsec := QuotedStr(ADataset.Fields.FieldByName('indsec').AsString); //do not localize!
      indfin := QuotedStr(ADataset.Fields.FieldByName('indfin').AsString); //do not localize!
      indcon := QuotedStr(ADataset.Fields.FieldByName('indcon').AsString); //do not localize!
      indfoc := QuotedStr(ADataset.Fields.FieldByName('indfoc').AsString); //do not localize!
      indusu := QuotedStr(ADataset.Fields.FieldByName('indusu').AsString); //do not localize!

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

function TCosmosUsersManager.AuthenticateUser(const UserName,
  Password: string): boolean;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
 {Autentica o usuário com a senha passada em parâmetro. A autenticação basicamente
  verifica se existe um usuário com login e senha passados. Este método não verifica
  se o usuário está ativo ou bloqueado.}
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.LoginUser, [UserName.QuotedString, Password.QuotedString]), ADataset);
  Result := ADataset.RecordCount > 0;

  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    Result := False;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(ACommand) then FreeAndNil(ACommand);

    raise;
   end;
 end;

end;

function TCosmosUsersManager.CanAcessModule(const UserName: string;
  Module: TCosmosModules): boolean;
var
 sModule: string;
 aCommand: TCosmosCommand;
 aDataset: TClientDataset;
begin
 // Verifica se um usuário pode acessar um módulo do Cosmos.
 case Module of
   cmFocos, cmFocosServer: sModule := sModule.Format('pri.INDFOC = %s', [QuotedStr('S')]);   //do not localize!
   cmSecretarias, cmSecretariasServer: sModule := sModule.Format('pri.INDSEC = %s', [QuotedStr('S')]);  //do not localize!
   cmFinanceiro, cmFinanceiroServer: sModule := sModule.Format('pri.INDFIN = %s', [QuotedStr('S')]);  //do not localize!
   cmConferencias, cmConferenciasServer: sModule := sModule.Format('pri.INDCON = %s', [QuotedStr('S')]);   //do not localize!
   cmUsuarios, cmUsuariosServer: sModule := sModule.Format('pri.INDUSU = %s', [QuotedStr('S')]);  //do not localize!
 end;

 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  aCommand.ExecuteDQL(Format(TSecurityCommand.UserModule, [UserName.QuotedString, sModule]), aDataset);
  Result := aDataset.RecordCount > 0;

  if Assigned(aDataset) then FreeAndNil(aDataset);
  if Assigned(aCommand) then FreeAndNil(aCommand);


 except
  if Assigned(aDataset) then FreeAndNil(aDataset);
  if Assigned(aCommand) then FreeAndNil(aCommand);

  raise;
 end;

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
   begin
    Result := 2;
    raise EUnknownCosmosUser.Create(Format(TSecurityConst.UnknownCosmosUser, [UserName]));
   end
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

procedure TCosmosUsersManager.GetUserInfo(const UserName: WideString;
  var UserData: TCosmosData);
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.UsuarioInfo, [QuotedStr(UserName)]), ADataset);

  //Testa se o login do usuário existe...
  if ADataset.IsEmpty then //Não encontrou um usuário com o login indicado...
    raise EUnknownUser.Create(TCosmosErrorSecurityMsg.UnknownUser);

  if Assigned(UserData) then
   begin
    with ADataset.Fields do
     begin
      UserData.WriteValue('CODUSU', FieldByName('codusu').AsInteger); //do not localize!
      UserData.WriteValue('LOGIN', FieldByName('logusu').AsString, 1); //do not localize!
      UserData.WriteValue('USER_NAME', FieldByName('nomcad').AsString, 2); //do not localize!
      UserData.WriteValue('FOCO', FieldByName('sigfoc').AsString, 3); //do not localize!
      UserData.WriteValue('MATRICULA', FieldByName('matcad').AsString, 4); //do not localize!
      UserData.WriteValue('DISCIPULADO', FieldByName('sigdis').AsString, 5); //do not localize!

      //Usuário está ativo?
      if FieldByName('indati').Value = 'S' then  //do not localize!
       UserData.WriteValue('ATIVO', True, 6) //do not localize!
      else
       UserData.WriteValue('ATIVO', False, 6); //do not localize!

      //Usuário é administrador?
      if FieldByName('indadm').Value = 'S' then  //do not localize!
       UserData.WriteValue('ADM', True, 7) //do not localize!
      else
       UserData.WriteValue('ADM', False, 7); //do not localize!
     end;

    //Agora, checa quais campos de trabalho poderão ser acessados pelo usuário.
    {ACommand.ExecuteDQL(Format(TSecurityCommand.PerfilUsuario, [QuotedStr(UpperCase(RoleName))]), ADataset);
    with ADataset.Fields do
     begin
      UserData.WriteValue('INDLEC', FieldByName('INDLEC').AsString, 8); //do not localize!
      UserData.WriteValue('INDTMO', FieldByName('INDTMO').AsString, 9); //do not localize!
      UserData.WriteValue('INDTMB', FieldByName('INDTMB').AsString, 10); //do not localize!
      UserData.WriteValue('INDTPU', FieldByName('INDTPU').AsString, 11); //do not localize!
      UserData.WriteValue('INDEIN', FieldByName('INDEIN').AsString, 12); //do not localize!
      UserData.WriteValue('ABRANGENCIA', FieldByName('ABRPER').AsString, 13); //do not localize!
     end;}
   end;

 if Assigned(ACommand) then FreeAndNil(ACommand);
 if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  raise;
 end;
end;

procedure TCosmosUsersManager.GetUserRoles(const UserName: string;
  List: TStrings);
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

function TCosmosUsersManager.PasswordIsTemporary(
  const UserName: string): boolean;
var
 ACommand: TCosmosCommand;
 ADataset: TClientDataset;
begin
//Verifica se a senha do usuário é temporária.
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(TSecurityCommand.PasswordIsTemporary, [UserName.QuotedString]), ADataset);
  Result := ADataset.Fields.FieldByName('indpro').AsString.Trim.ToUpper = 'S'

 finally
   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(ACommand) then FreeAndNil(ACommand);
 end;
end;

function TCosmosUsersManager.ResetPasword(const UserName: string; var NewPassword: string): string;
var
 ACommand: TCosmosCommand;
begin
{Reseta a senha de um usuário e a marca como provisória.}
 ACommand := TCosmosCommand.Create;
 ACommand.ConnectionsPool := FConnectionsPool;

 try
  NewPassword := TCripterFactory.HashValue(NewPassword);
  ACommand.ExecuteCommand(Format(TSecurityCommand.ChangePassword, [NewPassword.QuotedString, QuotedStr('S'), QuotedStr(UserName)]));

 except
   raise;
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
