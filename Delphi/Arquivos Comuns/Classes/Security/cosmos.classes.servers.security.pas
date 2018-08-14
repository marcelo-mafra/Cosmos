unit cosmos.classes.servers.security;

{Todos as operações executadas nos métodos desta classe são executadas usando
 o usuário SYSDBA. O sistema assume uma senha padrão para este usuário. Estas
 operações falharão caso não seja usado o usuário SYSDBA.}

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, cosmos.servers.sqlcommands,
  Data.DB, Datasnap.DBClient, Data.SqlExpr, cosmos.system.types, cosmos.system.messages,
  cosmos.classes.application, cosmos.system.exceptions, cosmos.classes.dataobjects,
  cosmos.classes.cosmoscript, System.WideStrings, Data.DBXCommon, Data.DBXFirebird;

type
  TCosmosUsersManager = class(TSQLServerObject)

  private
  { Private declarations }
   sSystemUser: string;

   function CreateDataset(Connection: TSQLConnection): TSQLDataset; inline;

   procedure CloseDataset(Dataset: TDataset);
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
 end;

function TCosmosUsersManager.CreateDataset(
  Connection: TSQLConnection): TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := Connection;
end;

function TCosmosUsersManager.CreateUser(UserData,
  FocusData: Olevariant; ActiveRange: integer): boolean;
var
NewUserID, RoleID, codfoc, codcad: integer;
AScript: TStringList;
AConnection: TSQLConnection;
ACommand: TSQLServerCommand;
ASQLDataset: TSQLDataset;
ADataset: TClientDataset;
logusu, password, rolename, indati, indadm, tipper, indsec, indfin: string;
indblo, indpro, indcon, indfoc, indusu: string;
begin
//Cria um novo usuário do sistema cosmos e atribui os focos que possuirá acesso.
 ACommand := TSQLServerCommand.Create;
 AConnection := ACommand.CreateConnection;

 ASQLDataset := TSQLDataset.Create(nil);
 ASQLDataset.SQLConnection := AConnection;

 ADataset := TClientDataset.Create(nil);
 AScript := TStringList.Create;

 try

  with ADataset do
   begin
    Data := UserData;
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
   CloseDataset(ASQLDataset);
   ACommand.ExecuteDQL(Format(TGUsersCommands.UsuarioByCadastrado, [codcad]), ASQLDataset);

   if not ASQLDataset.IsEmpty then
    raise EDuplicatedCosmosUser.Create(TCosmosErrorMsg.LoginAlreadyExists);

   {Obtém o código da Role do usuário.}
   CloseDataset(ASQLDataset);
   ACommand.ExecuteDQL(Format(TGUsersCommands.CodigoPerfil, [QuotedStr(RoleName)]), ASQLDataset);

   if not ASQLDataset.IsEmpty then
    RoleID := ASQLDataset.Fields.Fields[0].Value
   else
    raise EUnknownRole.Create(TCosmosErrorSecurityMsg.UnknownProfile);


   //Agora, insere na tabela de usuários do Cosmos as informações sobre o novo
   //usuário e os focos que pode acessar.
   CloseDataset(ASQLDataset);
   ACommand.ExecuteDQL(Format(TDQLCommands.Generators, [TSequencesNames.GEN_USUARIOS, 1]), ASQLDataset);
   NewUserID := ASQLDataset.Fields.Fields[0].AsInteger + ActiveRange;
   CloseDataset(ASQLDataset);

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

   Result := ACommand.ExecuteScript(AConnection, AScript);

   //Usuário criado com sucesso.

   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(AScript) then FreeAndNil(AScript);
   if Assigned(ACommand) then FreeAndNil(ACommand);
   if Assigned(AConnection) then FreeAndNil(AConnection);

 except
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(AScript) then FreeAndNil(AScript);
   if Assigned(ACommand) then FreeAndNil(ACommand);
   if Assigned(AConnection) then FreeAndNil(AConnection);

   raise;
  end;
 end;
end;

destructor TCosmosUsersManager.Destroy;
begin
  inherited;
end;

function TCosmosUsersManager.ChangePassword(const UserName,
  NewPassword: string): integer;
var
ADML: string;
ADataset: TSQLDataset;
AConnection: TSQLConnection;
ACommand: TSQLServerCommand;
begin
//Altera a senha de um usuário.
 ACommand := TSQLServerCommand.Create;
 AConnection := ACommand.CreateConnection;
 ADataset := TSQLDataset.Create(nil);
 ADataset.SQLConnection := AConnection;

 try
  ADML := Format(TSecurityCommand.UsuarioByLogin, [QuotedStr(UpperCase(UserName))]);
  ACommand.ExecuteDQL(ADML, ADataset);

  if ADataset.IsEmpty then
   begin
    CloseDataset(ADataset);
    Result := 2;
   end
  else
   begin
    CloseDataset(ADataset);
    ADML := Format(TSecurityCommand.ChangePassword, [TCripterFactory.Criptografar(NewPassword).QuotedString, QuotedStr(UserName.ToLower)]);

    Result := ACommand.ExecuteCommand(ADML);
    if Result = 0 then //O comando não alterou nenhum registro!
     raise ECreateCosmosUser.Create(Format(TCosmosErrorMsg.PasswordUpdate, [UserName]));

    if Assigned(ADataset) then FreeAndNil(ADataset);

    if Assigned(AConnection) then
     begin
      AConnection.Close;
      FreeAndNil(AConnection);
     end;

    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;

 except
  on E: Exception do
   begin
    Result := 2;
    if Assigned(ADataset) then
     begin
      ADataset.Close;
      FreeAndNil(ADataset);
     end;

    if Assigned(AConnection) then
     begin
      AConnection.Close;
      FreeAndNil(AConnection);
     end;

    if Assigned(ACommand) then FreeAndNil(ACommand);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

procedure TCosmosUsersManager.CloseDataset(Dataset: TDataset);
begin
 if (Dataset <> nil) and (Dataset.Active) then
  Dataset.Close;
end;

function TCosmosUsersManager.DeleteUser(const codusu: integer): boolean;
var
ADML: string;
AConnection: TSQLConnection;
begin
//Exclui um usuário.
 AConnection := self.CreateConnection;

 try
  AConnection.Open;
  ADML := Format(TGUsersCommands.DeleteUser, [codusu]);
  Result := AConnection.ExecuteDirect(ADML) > 0;

  if Assigned(AConnection) then
   begin
    AConnection.Close;
    FreeAndNil(AConnection);
   end;

 except
  on E: Exception do
   begin
    if Assigned(AConnection) then
     begin
      AConnection.Close;
      FreeAndNil(AConnection);
     end;

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

procedure TCosmosUsersManager.GetUserInfo(const UserName, Password,
  RoleName: WideString; var UserData: TCosmosData);
var
 ACommand: TSQLServerCommand;
 AList: TStringList;
 AConnection: TSQLConnection;
 ADataset: TSQLDataset;
begin
 AList := TStringList.Create;
 ACommand := TSQLServerCommand.Create;
 AConnection := CreateConnection;
 ADataset := self.CreateDataset(AConnection);

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

 if Assigned(ACommand) then FreeAndNil(ACommand);
 if Assigned(ADataset) then FreeAndNil(ADataset);
 if Assigned(AConnection) then FreeAndNil(AConnection);
 if Assigned(AList) then FreeAndNil(AList);

 except
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AConnection) then FreeAndNil(AConnection);
  if Assigned(AList) then FreeAndNil(AList);
  raise;
 end;

end;

procedure TCosmosUsersManager.GetUserRoles(const UserName: string;
  List: TStringList);
var
sDQL: string;
AConnection: TSQLConnection;
ADataset: TSQLDataset;
begin
//Lista as roles atribuídas a um usuário.
 AConnection := CreateConnection;
 ADataset := CreateDataset(AConnection);

 try
  AConnection.Open;
  sDQL := Format(TGUsersCommands.UserRoles, [QuotedStr(UserName)]);
  ADataset.CommandText := sDQL;
  ADataset.Open;

  while not ADataset.Eof do
   begin
    List.Append(TrimRight(ADataset.Fields.FieldByName('nomper').AsString));
    ADataset.Next;
   end;

  if Assigned(ADataset) then
   begin
    self.CloseDataset(ADataset);
    FreeAndNil(ADataset);
   end;

  if Assigned(AConnection) then
   begin
    AConnection.Close;
    FreeAndNil(AConnection);
   end;

 except
  on E: Exception do
   begin
    if Assigned(ADataset) then
     begin
      self.CloseDataset(ADataset);
      FreeAndNil(ADataset);
     end;

    if Assigned(AConnection) then
     begin
      AConnection.Close;
      FreeAndNil(AConnection);
     end;

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
ADML: string;
AConnection: TSQLConnection;
ACommand: TSQLServerCommand;
ADataset: TSQLDataset;
codusu, codper: integer;
begin
//Atribui uma role a um usuário.
 ACommand := TSQLServerCommand.Create;
 AConnection := ACommand.CreateConnection;
 ADataset := TSQLDataset.Create(nil);

 try
  ADataset.SQLConnection := AConnection;
  AConnection.Open;

  //Primeiro, obtém o código do usuário passado em parâmentro.
  ADML := Format(TSecurityCommand.UserInfo, [QuotedStr(UpperCase(UserName))]);
  ADataset.CommandText := ADML;
  ADataset.Open;

  if not ADataset.IsEmpty then
   codusu := ADataset.Fields.FieldByName('CODUSU').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  self.CloseDataset(ADataset);

  //Agora, obtém o código do perfil passado em parâmentro.
  ADML := Format(TGUsersCommands.CodigoPerfil, [QuotedStr(UpperCase(RoleName))]);
  ADataset.CommandText := ADML;
  ADataset.Open;

  if not ADataset.IsEmpty then
   codper := ADataset.Fields.FieldByName('CODPER').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  self.CloseDataset(ADataset);

  //Executa o comando para inserir atribuir o perfil ao usuário.
  Result :=  ACommand.ExecuteCommand(Format(TSecurityCommand.InsertPerfilUsuario, [codusu, codper])) > 0;

  if Assigned(ADataset) then FreeAndNil(ADataset);

  if Assigned(AConnection) then
   begin
    AConnection.Close;
    FreeAndNil(AConnection);
   end;

  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    Result := False;

    if Assigned(ADataset) then FreeAndNil(ADataset);

    if Assigned(AConnection) then
     begin
      AConnection.Close;
      FreeAndNil(AConnection);
     end;

    if Assigned(ACommand) then FreeAndNil(ACommand);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;

end;

function TCosmosUsersManager.HasCosmosUser(const UserName: string): boolean;
var
sDQL: string;
AConnection: TSQLConnection;
ADataset: TSQLDataset;
begin
//Verifica se um usuário está cadastrado na tabela de usuários do Cosmos.
 AConnection := CreateConnection;
 ADataset := CreateDataset(AConnection);

 try
  AConnection.Open;
  sDQL := Format(TSecurityCommand.UserInfo, [QuotedStr(UserName)]);
  ADataset.CommandText := sDQL;
  ADataset.Open;

  Result := not ADataset.IsEmpty;

  if Assigned(ADataset) then
   begin
    self.CloseDataset(ADataset);
    FreeAndNil(ADataset);
   end;

  if Assigned(AConnection) then
   begin
    AConnection.Close;
    FreeAndNil(AConnection);
   end;

 except
  on E: Exception do
   begin
    Result := False;

    if Assigned(ADataset) then
     begin
      self.CloseDataset(ADataset);
      FreeAndNil(ADataset);
     end;

    if Assigned(AConnection) then
     begin
      AConnection.Close;
      FreeAndNil(AConnection);
     end;

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

function TCosmosUsersManager.IsAdministrator(
  const UserName: WideString): boolean;
var
AConnection: TSQLConnection;
ADataset: TSQLDataset;
begin
//Checa se um usuário é um administrador do sistema.
 AConnection := CreateConnection;
 ADataset := CreateDataset(AConnection);

 try
  ADataset.CommandText := Format(TSecurityCommand.AdmUser,[QuotedStr(UserName)]);
  ADataset.Open;
  Result := ADataset.Fields.Fields[0].AsString = 'S';

 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AConnection) then FreeAndNil(AConnection);
 end;
end;

procedure TCosmosUsersManager.ListServerUsers(List: TStringList);
begin
//To do.
end;

function TCosmosUsersManager.LockCosmosUser(const codusu: integer): boolean;
var
ACommand: TSQLServerCommand;
begin
//Bloqueia um usuário do Cosmos.
 ACommand := TSQLServerCommand.Create;

 try
  //Executa o comando para bloquear o usuário.
  Result := ACommand.ExecuteCommand(Format(TGUsersCommands.LockUser, [QuotedStr('S'), codusu])) > 0;

  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then  FreeAndNil(ACommand);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

function TCosmosUsersManager.RevokeRole(const UserName,
  RoleName: string): boolean;
var
ADML: string;
AConnection: TSQLConnection;
ACommand: TSQLServerCommand;
ADataset: TSQLDataset;
codusu, codper: integer;
begin
//Retira uma role de um usuário.
 ACommand := TSQLServerCommand.Create;
 AConnection := ACommand.CreateConnection;
 ADataset := TSQLDataset.Create(nil);

 try
  ADataset.SQLConnection := AConnection;
  AConnection.Open;

  //Primeiro, obtém o código do usuário passado em parâmentro.
  ADML := Format(TSecurityCommand.UserInfo, [QuotedStr(UpperCase(UserName))]);
  ACommand.ExecuteDQL(ADML, ADataset);

  if not ADataset.IsEmpty then
   codusu := ADataset.Fields.FieldByName('CODUSU').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  self.CloseDataset(ADataset);

  //Agora, obtém o código do perfil passado em parâmentro.
  ADML := Format(TGUsersCommands.CodigoPerfil, [QuotedStr(UpperCase(RoleName))]);
  ACommand.ExecuteDQL(ADML, ADataset);

  if not ADataset.IsEmpty then
   codper := ADataset.Fields.FieldByName('CODPER').AsInteger
  else
   raise ESetProfileUser.Create(TCosmosErrorSecurityMsg.SetUserProfile);

  self.CloseDataset(ADataset);

  //Executa o comando para inserir atribuir o perfil ao usuário.
  Result := ACommand.ExecuteCommand(Format(TSecurityCommand.DelPerfilUsuario, [codusu, codper])) > 0;

  if Assigned(ADataset) then FreeAndNil(ADataset);

  if Assigned(AConnection) then
   begin
    AConnection.Close;
    FreeAndNil(AConnection);
   end;

  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(ADataset) then FreeAndNil(ADataset);

    if Assigned(AConnection) then
     begin
      AConnection.Close;
      FreeAndNil(AConnection);
     end;

    if Assigned(ACommand) then FreeAndNil(ACommand);

    raise; //Redispara a exceção para ser capturada pelo método evocador...
   end;
 end;
end;

procedure TCosmosUsersManager.SetAdministrator(const Value: string;
  UserId: integer);
var
ACommand: TSQLServerCommand;
begin
{Atribui ou retira os direitos de administrador do sistema para um usuário.}
 ACommand := TSQLServerCommand.Create;

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
ACommand: TSQLServerCommand;
begin
//Desbloqueia um usuário do Cosmos.
 ACommand := TSQLServerCommand.Create;

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
sDQL: string;
AConnection: TSQLConnection;
ADataset: TSQLDataset;
begin
//Verifica se um usuário está bloqueado.
 AConnection := self.CreateConnection;
 ADataset := TSQLDataset.Create(nil);
 ADataset.SQLConnection := AConnection;

 try
  AConnection.Open;
  sDQL := Format(TSecurityCommand.UsuarioInfo, [QuotedStr(UserName)]);
  ADataset.CommandText := sDQL;
  ADataset.Open;

  Result := (ADataset.RecordCount > 0) and (ADataset.Fields.FieldByName('indblo').Value = 'S');


 finally
  if Assigned(ADataset) then
   begin
    self.CloseDataset(ADataset);
    FreeAndNil(ADataset);
   end;

  if Assigned(AConnection) then
   begin
    AConnection.Close;
    FreeAndNil(AConnection);
   end;
 end;
end;


end.
