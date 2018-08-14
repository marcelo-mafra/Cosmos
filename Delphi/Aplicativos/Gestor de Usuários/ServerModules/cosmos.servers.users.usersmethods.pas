unit cosmos.servers.users.usersmethods;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Windows, System.StrUtils,
  DBClient, FMTBcd, Data.DB, Data.SqlExpr, Provider,  Variants,  cosmos.classes.application,
  Cosmos.classes.ServerInterface, cosmos.system.types, cosmos.system.exceptions,
  cosmos.system.winshell,  DBXCommon, DBXFirebird, DataSnap.DSProviderDataModuleAdapter,
  cosmos.classes.dataobjects, cosmos.system.dataconverter, cosmos.classes.logs,
  cosmos.system.messages, cosmos.servers.sqlcommands, cosmos.classes.cosmoscript;

type
  TDMUserMethods = class(TDSServerModule)
    SQLUser: TSQLDataSet;
    DspUser: TDataSetProvider;
    SQLFocos: TSQLDataSet;
    DspFocos: TDataSetProvider;
    SQLFocosCODPRI: TIntegerField;
    SQLFocosCODUSU: TIntegerField;
    SQLFocosCODFOC: TIntegerField;
    SQLFocosNOMFOC: TStringField;
    SQLFocosSIGFOC: TStringField;
    SQLListFocosUsuario: TSQLDataSet;
    DspListFocosUsuario: TDataSetProvider;
    SQLListFocosUsuarioLOGUSU: TStringField;
    SQLListFocosUsuarioCODPRI: TIntegerField;
    SQLListFocosUsuarioCODFOC: TIntegerField;
    SQLListFocosUsuarioNOMFOC: TStringField;
    SQLListFocosUsuarioSIGFOC: TStringField;
    SQLListFocosUsuarioCODUSU: TIntegerField;
    SQLPerfis: TSQLDataSet;
    SQLPerfisCODPER: TIntegerField;
    SQLPerfisNOMPER: TStringField;
    SQLPerfisINDLEC: TStringField;
    SQLPerfisINDTMO: TStringField;
    SQLPerfisINDTMB: TStringField;
    SQLPerfisINDTPU: TStringField;
    SQLPerfisINDEIN: TStringField;
    DspPerfis: TDataSetProvider;
    SQLPerfil: TSQLDataSet;
    SQLPerfilCODPER: TIntegerField;
    SQLPerfilNOMPER: TStringField;
    SQLPerfilDESPER: TStringField;
    SQLPerfilINDLEC: TStringField;
    SQLPerfilINDTMO: TStringField;
    SQLPerfilINDTMB: TStringField;
    SQLPerfilINDTPU: TStringField;
    SQLPerfilINDEIN: TStringField;
    SQLPerfilABRPER: TStringField;
    DspPerfil: TDataSetProvider;
    SQLListFocosUsuarioTIPPER: TStringField;
    SQLFocosUsuario: TSQLDataSet;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    DspFocosUsuario: TDataSetProvider;
    SQLFocosUsuarioINDSEC: TStringField;
    SQLFocosUsuarioINDFOC: TStringField;
    SQLFocosUsuarioINDFIN: TStringField;
    SQLFocosUsuarioINDCON: TStringField;
    SQLFocosUsuarioINDUSU: TStringField;
    SQLPerfilINDSIM: TStringField;
    SQLPerfisINDSIM: TStringField;
    procedure DspPerfilGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspFocosUsuarioGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspFocosUsuarioGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure SQLUserBeforeOpen(DataSet: TDataSet);
    procedure DspFocosUsuarioUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }
    function DoCreateUser(UserData, FocusData: string; ActiveRange: integer): boolean;
    function DoGrantRole(const UserName, RoleName: WideString): boolean;
    function DoRevokeRole(const UserName, RoleName: WideString): boolean;
    function GetCurrentCosmosModule: TCosmosModules;

  public
    { Public declarations }
    procedure GrantRoles(const UserName, Roles: WideString);

    function GetRoles: string;
    function GetUserRoles(const UserName: WideString): string;

    procedure DeleteUser(codusu: Integer);
    function UnlockUser(codusu: Integer): boolean;
    function LockUser(codusu: Integer): boolean;

    function CreateCosmosUser(UserData, FocusData: string): integer;

    function GetRegisteredUsers: TDataset;
    procedure GrantAdministrator(const UserId: Integer; IsAdministrator: boolean);
    function ResetPassword(const UserId: integer): string;

    property CurrentCosmosModule: TCosmosModules read GetCurrentCosmosModule;

  end;

var
  DMUserMethods: TDMUserMethods;

implementation

uses
  cosmos.servers.common.dataacess, cosmos.servers.common.services;

{$R *.DFM}

function TDMUserMethods.CreateCosmosUser(UserData,
  FocusData: string): integer;
begin
//Cria um novo usuário do sistema Cosmos.
 try
   if DoCreateUser(UserData, FocusData, DMServerDataAcess.ActiveRange) then
     Result := 0;

 except
  on E: TDBXError do //Falha do framework de acesso a dados.
   begin
    Result := 3;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.CreateUser, TCosmosErrorMsg.CreateUser);
   end;
  on E: EDuplicatedCosmosUser do //Novo login do usuário já está cadastrado.
   begin
    Result := 1;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.LoginAlreadyExists, TCosmosErrorMsg.LoginAlreadyExists);
   end;
  on E: ECreateCosmosUser do //Falha ao tentar atribuir os dados dos núcleos ao usuário.
   begin
    Result := 2;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.CreateUserAttributes, TCosmosErrorMsg.CreateUserAttributes);
   end; //
  on E: EUnknownRole do //Falha ao atribuir o perfil ao usuário.
   begin
    Result := 3;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.CreateUserAttributes, TCosmosErrorMsg.CreateUserAttributes);
   end;
 end;
end;

function TDMUserMethods.GetRoles: string;
var
ADataset: TSQLDataset;
AList: TStringList;
begin
//Retorna a lista de roles disponívies em uma string.
 ADataset := DMServerDataAcess.CreateDataset;
 AList := TStringList.Create;

 try
  ADataset.CommandText := TSecurityCommand.SelRoles;
  ADataset.Open;

  while not ADataset.Eof do
   begin
    AList.Append(ADataset.Fields.FieldByName('NOMPER').AsString);
    ADataset.Next;
   end;

  Result := AList.CommaText;
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    Result:= '';
    if Assigned(AList) then FreeAndNil(AList);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.SelectData, TCosmosErrorMsg.SelectData);
   end;
 end;
end;

function TDMUserMethods.LockUser(codusu: Integer): boolean;
begin
//Bloqueia um usuário de acessar os aplicativos Cosmos
 try
  DMServerDataAcess.DoExecuteCommand(Format(TGUsersCommands.LockUser, [QuotedStr('S'), codusu]));
  Result := True;

 except
  on E: Exception do
   begin
    Result := False;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.LockUser, TCosmosErrorMsg.LockUser);
   end;
 end;
end;

function TDMUserMethods.ResetPassword(const UserId: integer): string;
const
 aRange: integer =  4524586;
var
 AKey: integer;
 AValue, ACommand: string;
begin
 //Gera uma nova senha provisória para um usuário.
 Randomize;
 AKey := Random(aRange);//faixa numérica da senha

 //Faz um hash da senha gerada.
 AValue := TCripterFactory.HashValue(AKey.ToString);
 ACommand := Format(TGUsersCommands.ResetPassword, [AValue.QuotedString, QuotedStr('S'), UserId]);

 try
  DMServerDataAcess.DoExecuteCommand(ACommand);
  Result := AKey.ToString;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.ResetPassword, TCosmosErrorMsg.ResetPassword);
   end;
 end;
end;

function TDMUserMethods.UnlockUser(codusu: Integer): boolean;
begin
//Desbloqueia um usuário dos aplicativos Cosmos
 try
   DMServerDataAcess.DoExecuteCommand(Format(TGUsersCommands.LockUser, [QuotedStr('N'), codusu]));
   Result := True;

 except
  on E: Exception do
   begin
    Result := False;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.UnlockUser, TCosmosErrorMsg.UnlockUser);
   end;
 end;
end;

procedure TDMUserMethods.DeleteUser(codusu: Integer);
begin
//Exclui um usuário da tabela de usuários do Cosmos.
 try
  DMServerDataAcess.DoExecuteCommand(Format(TGUsersCommands.DeleteUser, [codusu]));

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.DeleteUser, TCosmosErrorMsg.DeleteUser);
   end;
 end;
end;

procedure TDMUserMethods.DspFocosUsuarioGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PRIVILEGIOS, False]);
end;

procedure TDMUserMethods.DspFocosUsuarioGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := 'PRIVILEGIOS';
end;

procedure TDMUserMethods.DspFocosUsuarioUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMUserMethods.DspPerfilGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PERFIS, False]);
end;

function TDMUserMethods.DoCreateUser(UserData, FocusData: string;
  ActiveRange: integer): boolean;
var
NewUserID, RoleID, codfoc, codcad: integer;
AScript: TStringList;
ASQLDataset: TSQLDataset;
ADataset: TClientDataset;
logusu, password, rolename, indati, indadm, tipper, indsec, indfin: string;
indblo, indpro, indcon, indfoc, indusu: string;
begin
//Cria um novo usuário do sistema cosmos e atribui os focos que possuirá acesso.
 ASQLDataset := DMServerDataAcess.CreateDataset;
 ADataset := TClientDataset.Create(nil);
 AScript := TStringList.Create;

 try

  with ADataset do
   begin
    XMLData := UserData;
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
   ASQLDataset.CommandText := Format(TSecurityCommand.LoginExists, [QuotedStr(logusu)]);
   ASQLDataset.Open;
   if not ASQLDataset.IsEmpty then
    raise EDuplicatedCosmosUser.Create(TCosmosErrorSecurityMsg.UsuarioExists);


   {Checa se um cadastrado já possui um login.}
   DMServerDataAcess.CloseDataset(ASQLDataset);
   ASQLDataset.CommandText := Format(TGUsersCommands.UsuarioByCadastrado, [codcad]);
   ASQLDataset.Open;

   if not ASQLDataset.IsEmpty then
    raise EDuplicatedCosmosUser.Create(TCosmosErrorMsg.LoginAlreadyExists);

   {Obtém o código da Role do usuário.}
   DMServerDataAcess.CloseDataset(ASQLDataset);
   ASQLDataset.CommandText := Format(TGUsersCommands.CodigoPerfil, [QuotedStr(RoleName)]);
   ASQLDataset.Open;

   if not ASQLDataset.IsEmpty then
    RoleID := ASQLDataset.Fields.Fields[0].Value
   else
    raise EUnknownRole.Create(TCosmosErrorSecurityMsg.UnknownProfile);


   //Agora, insere na tabela de usuários do Cosmos as informações sobre o novo
   //usuário e os focos que pode acessar.
   DMServerDataAcess.CloseDataset(ASQLDataset);
   ASQLDataset.CommandText := Format(TDQLCommands.Generators, [TSequencesNames.GEN_USUARIOS, 1]);
   ASQLDataset.Open;

   NewUserID := ASQLDataset.Fields.Fields[0].AsInteger + ActiveRange;
   DMServerDataAcess.CloseDataset(ASQLDataset);

   //Monta o comando de criação do usuário.
   AScript.Append(Format(TSecurityCommand.InsertCosmosUser, [NewUserID, QuotedStr(logusu), QuotedStr(Password), codcad,
   QuotedStr(indati), QuotedStr(indadm), QuotedStr(indblo), QuotedStr(indpro)]));

   //Monta o comando de criação do perfil do usuário.
   AScript.Append(Format(TSecurityCommand.InsertPerfilUsuario, [NewUserID, RoleId]));

   //Monta os comandos de permissão de acesso aos núcleos.
    aDataset.XMLData := FocusData;
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

   Result := DMServerDataAcess.DoExecuteScript(AScript);

   //Usuário criado com sucesso.

   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(AScript) then FreeAndNil(AScript);

 except
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(AScript) then FreeAndNil(AScript);
   raise;
  end;
 end;

end;

function TDMUserMethods.DoGrantRole(const UserName, RoleName: WideString): boolean;
var
 AProc: TSQLStoredProc;
begin
{Vincula um usuário a um perfil (role).}
 AProc := DMServerDataAcess.CreateStoreProcedure;

 try
  AProc.StoredProcName := 'PERMISSOES_USUARIO';
  AProc.Params.ParamByName('IUSERNAME').Value := UserName;
  AProc.Params.ParamByName('IROLENAME').Value := RoleName;
  AProc.Params.ParamByName('IGRANT').Value := 'S';

  AProc.ExecProc;
  Result := True;

  if Assigned(AProc) then FreeAndNil(AProc);

 except
  on E: Exception do
   begin
   if Assigned(AProc) then FreeAndNil(AProc);
   if Pos('EX_USUARIO_ILEGAL', E.Message) > 0 then
    begin
     DMCosmosServerServices.RegisterLog(TCosmosErrorMsg.IlegalGrantUser, '', leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.IlegalGrantUser, TCosmosErrorMsg.IlegalGrantUser);
    end
   else
   if Pos('EX_GERAL', E.Message) > 0 then
    begin
     DMCosmosServerServices.RegisterLog(TCosmosErrorMsg.IlegalGrantRole, '', leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.IlegalGrantRole, TCosmosErrorMsg.IlegalGrantRole);
    end
   else
    begin
     DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.ExecuteCommand, TCosmosErrorMsg.ExecuteCommand);
    end;
   end;
 end;
end;

procedure TDMUserMethods.GrantRoles(const UserName, Roles: WideString);
var
 I: integer;
 ARoles: TStringList;
 ADataset: TSQLDataset;
 AClientDataset: TClientDataset;
 sRole: string;
begin
 {Atribui e retira as roles de um usuário em um só método remoto.}
 ARoles := TStringList.Create;

 try
  //Pega as roles recebidas do cliente. Essas sãos as roles que deve ficar.
  ARoles.CommaText := Roles;

  //Pega as roles atuais do usuário.
  ADataset := DMServerDataAcess.DoExecuteDQL(Format(TGUsersCommands.UserRoles, [QuotedStr(UserName)]));
  AClientDataset := TClientDataset.Create(self);
  DMServerDataAcess.ConvertToClientDataset(ADataset, AClientDataset);

  //Para cada role recebida, verifica se ela já não está associada ao usuário.
  for I := 0 to Pred(ARoles.Count) do
    begin
     sRole := ARoles.Strings[I];
     if AClientDataset.Locate('NOMPER', sRole, [loCaseInsensitive]) then  //já está associada.
       AClientDataset.Delete
     else
       DoGrantRole(UserName, sRole); //não está associada.
    end;

  //Por fim, varre as roles não mais atribuídas ao usuário e retira-as.
  while not AClientDataset.Eof do
    begin
     sRole := AClientDataset.FieldValues['NOMPER'];
     self.DoRevokeRole(UserName, sRole);
     AClientDataset.Next;
    end;


  ARoles.Free;
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AClientDataset) then FreeAndNil(AClientDataset);

 except
  on E: Exception do
   begin
    ARoles.Free;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(AClientDataset) then FreeAndNil(AClientDataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.GrantPermission, TCosmosErrorMsg.GrantPermission);
   end;
 end;

end;

function TDMUserMethods.GetRegisteredUsers: TDataset;
var
ADataset: TSQLDataset;
begin
{Retorna todos os usuários registrados do Cosmos. Esta lista é útil para exibição
na aplicação cliente e navegação entre os usuários.}

 try
  ADataset := DMServerDataAcess.CreateDataset;
  ADataset.CommandText := TSecurityCommand.RegisteredUsers;
  ADataset.Open;
  Result := ADataset;

 except
  on E: Exception do
   begin
     Result := nil;
     DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
 end;
end;

function TDMUserMethods.GetUserRoles(const UserName: WideString): string;
var
AList: TStringList;
ADataset: TSQLDataset;
begin
//Retorna a lista de roles de um usuário em um TString
 AList := TStringList.Create;
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TGUsersCommands.UserRoles, [QuotedStr(UserName)]);
  ADataset.Open;

  while not ADataset.Eof do
    begin
     AList.Append(TrimRight(ADataset.FieldValues['NOMPER']));
     ADataset.Next;
    end;

  Result := AList.CommaText;
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AList) then FreeAndNil(AList);

 except
  on E: Exception do
   begin
    Result:= '';
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [ADataset.CommandText]), leOnError);
    if Assigned(AList) then FreeAndNil(AList);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.SelectData, TCosmosErrorMsg.SelectData);
   end;
 end;

end;

function TDMUserMethods.DoRevokeRole(const UserName, RoleName: WideString): boolean;
var
 AProc: TSQLStoredProc;
begin
{Vincula um usuário a um perfil (role).}
 AProc := DMServerDataAcess.CreateStoreProcedure;

 try
  AProc.StoredProcName := 'PERMISSOES_USUARIO';
  AProc.Params.ParamByName('IUSERNAME').Value := UserName;
  AProc.Params.ParamByName('IROLENAME').Value := RoleName;
  AProc.Params.ParamByName('IGRANT').Value := 'N';

  AProc.ExecProc;
  Result := True;

  if Assigned(AProc) then FreeAndNil(AProc);

 except
  on E: Exception do
   begin
   if Assigned(AProc) then FreeAndNil(AProc);
   if Pos('EX_USUARIO_ILEGAL', E.Message) > 0 then
    begin
     DMCosmosServerServices.RegisterLog(TCosmosErrorMsg.IlegalGrantUser, '', leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.IlegalGrantUser, TCosmosErrorMsg.IlegalGrantUser);
    end
   else
   if Pos('EX_GERAL', E.Message) > 0 then
    begin
     DMCosmosServerServices.RegisterLog(TCosmosErrorMsg.IlegalGrantRole, '', leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.IlegalGrantRole, TCosmosErrorMsg.IlegalGrantRole);
    end
   else
    begin
     DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.ExecuteCommand, TCosmosErrorMsg.ExecuteCommand);
    end;
   end;
 end;
end;



function TDMUserMethods.GetCurrentCosmosModule: TCosmosModules;
begin
 Result := cmUsuarios;
end;

procedure TDMUserMethods.GrantAdministrator(const UserId: Integer; IsAdministrator: boolean);
var
 ACommand: string;
begin
{Atribui ou retira os direitos de administrador do sistema para um usuário.}
 try

  ACommand := Format(TGUsersCommands.UserAdministrator, [QuotedStr(TDataConverter.ToBoleanString(IsAdministrator)), UserId]);
  //Executa o comando...
  DMServerDataAcess.DoExecuteCommand(ACommand);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [ACommand]) , leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.GrantAdministrator, TCosmosErrorMsg.GrantAdministrator);
   end;
 end;
end;


procedure TDMUserMethods.SQLUserBeforeOpen(DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

end.
