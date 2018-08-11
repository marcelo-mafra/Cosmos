unit cosmos.servers.common.methods;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Json, Datasnap.DSServer,
  DataSnap.DSProviderDataModuleAdapter, Datasnap.DSAuth, cosmos.system.files,
  cosmos.classes.application, cosmos.system.messages, cosmos.system.exceptions,
  cosmos.servers.sqlcommands, System.Variants, cosmos.classes.dataobjects,
  cosmos.classes.ServerInterface, Data.DB, Data.DBXCommon, DBClient, Data.FMTBcd,
  Data.SqlExpr, Datasnap.Provider, DataSnap.DsSession, cosmos.business.focos,
  cosmos.classes.logs, cosmos.system.types, Data.DBXPlatform;

type
  {$METHODINFO OFF}


  {$METHODINFO ON}
  {Esta classe representa a aplicação servidora do Cosmos.}
  TDMCosmosApplicationServer = class(TDSServerModule)
    SQLDiscipulados: TSQLDataSet;
    DspDiscipulados: TDataSetProvider;
    SQLDiscipuladosCODDIS: TIntegerField;
    SQLDiscipuladosNOMDIS: TStringField;
    SQLDiscipuladosSIGDIS: TStringField;
    SQLAptidoes: TSQLDataSet;
    SQLAptidoesCODARE: TIntegerField;
    SQLAptidoesDESARE: TStringField;
    DspAptidoes: TDataSetProvider;
    DspFuncoes: TDataSetProvider;
    SQLFuncoes: TSQLDataSet;
    SQLFuncoesCODFUN: TIntegerField;
    SQLFuncoesDESFUN: TStringField;
    DspProfissoes: TDataSetProvider;
    SQLProfissoes: TSQLDataSet;
    SQLProfissoesCODPRO: TIntegerField;
    SQLProfissoesDESPRO: TStringField;
    SQLCargos: TSQLDataSet;
    SQLCargosCODCAR: TIntegerField;
    SQLCargosDESCAR: TStringField;
    DspCargos: TDataSetProvider;
    SQLEnfermidades: TSQLDataSet;
    SQLEnfermidadesCODENF: TIntegerField;
    SQLEnfermidadesNOMENF: TStringField;
    DspEnfermidades: TDataSetProvider;
    SQLTiposContatos: TSQLDataSet;
    SQLTiposContatosCODTIPCON: TIntegerField;
    SQLTiposContatosDESTIPCON: TStringField;
    DspMeiosContato: TDataSetProvider;
    SQLAptidoesCadastrados: TSQLDataSet;
    SQLAptidoesCadastradosCODAPT: TIntegerField;
    SQLAptidoesCadastradosCODCAD: TIntegerField;
    SQLAptidoesCadastradosCODARE: TIntegerField;
    SQLAptidoesCadastradosDESARE: TStringField;
    SQLAptidoesCadastradosOBSCAD: TMemoField;
    DspAptidoesCadastrado: TDataSetProvider;
    SQLFuncoesCadastrado: TSQLDataSet;
    SQLFuncoesCadastradoCODFUNCAD: TIntegerField;
    SQLFuncoesCadastradoCODCAD: TIntegerField;
    SQLFuncoesCadastradoCODFUN: TIntegerField;
    SQLFuncoesCadastradoDESFUN: TStringField;
    SQLFuncoesCadastradoUSURES: TStringField;
    SQLFuncoesCadastradoDATCAD: TSQLTimeStampField;
    DspFuncoesCadastrado: TDataSetProvider;
    SQLInfoMedicas: TSQLDataSet;
    SQLInfoMedicasCODINFMED: TIntegerField;
    SQLInfoMedicasCODCAD: TIntegerField;
    SQLInfoMedicasCODENF: TIntegerField;
    SQLInfoMedicasNOMENF: TStringField;
    SQLInfoMedicasINFMED: TStringField;
    DspInfoMedicas: TDataSetProvider;
    SQLFamiliares: TSQLDataSet;
    SQLFamiliaresCODFAM: TIntegerField;
    SQLFamiliaresCODCAD: TIntegerField;
    SQLFamiliaresNOMFAM: TStringField;
    SQLFamiliaresPARFAM: TStringField;
    SQLFamiliaresTELFAM: TStringField;
    SQLFamiliaresINDFAM: TStringField;
    SQLFamiliaresINDCAR: TStringField;
    DspFamiliares: TDataSetProvider;
    SQLPesquisaConferencias: TSQLDataSet;
    SQLPesquisaConferenciasCODCON: TIntegerField;
    SQLPesquisaConferenciasNOMCON: TStringField;
    SQLPesquisaConferenciasDATINI: TDateField;
    SQLPesquisaConferenciasDATTER: TDateField;
    SQLPesquisaConferenciasSIGFOC: TStringField;
    SQLPesquisaConferenciasCAMCON: TStringField;
    SQLPesquisaConferenciasSTACON: TStringField;
    DspPesquisaConferencias: TDataSetProvider;
    procedure SQLDiscipuladosBeforeOpen(DataSet: TDataSet);
    procedure DspAptidoesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFuncoesGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspProfissoesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspCargosGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspEnfermidadesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspMeiosContatoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspAptidoesCadastradoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFuncoesCadastradoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspInfoMedicasGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFamiliaresGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspAptidoesUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }

  public
    { Public declarations }
    function BufferData(const Table: Integer): Olevariant;

    //Segurança
    function ChangePassword(const UserName, NewPassword: string): boolean;
    function DoIdentificacaoAtiva(const UserName, NewPassword: string): boolean;
    function LockCosmosUser(const codusu: integer): boolean;
    function GetAuthorizations(const UserName: WideString; out ModuleFeatures: string): string;
    function GetCamposTrabalho(const UserName: WideString): string;
    function GetConnectedUserInfo(const UserName: WideString): TDataset;
    function PasswordIsTemporary(const UserName: WideString): boolean;
    function ReadUserRoles(const UserName: string): string;
    procedure ResetPasword(const UserName: string; out NewPassword: string);
    function VerifyCosmosServer(CosmosModule: Integer): boolean;

    //Pesquisas e comandos
    function ExecuteCommand(CommandID: Integer; const Params: OleVariant): integer;
    function ExecuteCosmosSearch(CosmosSearch: Integer; Params: OleVariant): TDataset;
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): TDataset;
    function ExecuteRegisteredSearch(const SearchId: integer; Params: Olevariant): TDataset;
    function CadastradoEstaFalecido(const codcad: integer): boolean;
    function GetAcessedFocus(const UserName: WideString; CosmosModule: integer): TDataset;
    function GetFotoCadastrado(const IdCadastrado: integer): Olevariant;
    function GetSequenceValue(const SequenceName: WideString): integer;
    function GetTableProviderName(Table: Integer): string;
    function GetFieldsInfo: TStringStream;
    function GetReportsInfo: TStringStream;
    function GetSearchsCentralInfo: TStringStream;
    function GetAddressLabelsInfo: TStringStream;


    //Métodos que retornam informações sobre o ambiente do servidor.
    function GetActiveRange: Int64;
    function GetServerDateTime: TDateTime;
    function GetTableVersion(TableId: integer): integer;

    //Pesquisas
    function ListData(SearchID: Integer; Params: OleVariant): TDBXReader;
    function SearchCadastrados(SearchType, Foco: Integer; const Campo,
      Argument: WideString): TDataset;

    function PingServer: boolean;

  end;

var
  DMCosmosApplicationServer: TDMCosmosApplicationServer;

implementation

{$R *.dfm}

uses cosmos.servers.common.dataacess, cosmos.servers.common.security,
 cosmos.servers.common.security.authorizations, cosmos.servers.common.services;//,
//  cosmos.servers.secretarias.pageproducer;

{ TDMCosmosApplicationServer }


function TDMCosmosApplicationServer.BufferData(const Table: Integer): Olevariant;
var
 ADQL: string;
 ADataset: TSQLDataset;
 AProvider: TDatasetProvider;
begin
 {Retorna um pacote de dados no formato Olevariant para ser buferizado no cliente}
 ADQL := TSQLCommandsFactory.GetTableCommand(TCosmosTables(Table));
 ADataset := DMServerDataAcess.CreateDataset;
 AProvider := TDatasetProvider.Create(nil);

 try
   ADataset.CommandText := ADQL;
   AProvider.DataSet := ADataset;
   ADataset.Open;
   Result := AProvider.Data;

 finally
   if Assigned(ADataset) then FreeAndNil(ADataset);
   if Assigned(AProvider) then FreeAndNil(AProvider);
 end;
end;

function TDMCosmosApplicationServer.CadastradoEstaFalecido(
  const codcad: integer): boolean;
var
 ADataset: TSQLDataset;
begin
  //Verifica, para fins diversos, se um cadastrado está falecido.
  ADataset := DMServerDataAcess.CreateDataset;

  try
   ADataset.CommandText := TDQLCommand.CadastradoFalecido;
   ADataset.CommandText := ADataset.CommandText.Format(ADataset.CommandText, [codcad]);
   ADataset.Open;

   if ADataset.IsEmpty then
     raise TDBXError.Create(TCosmosErrorCodes.EmptyDataset, TCosmosErrorMsg.EmptyDataset);

   Result := not ADataset.Fields.FieldByName('datobi').IsNull;
   if Assigned(ADataset) then FreeAndNil(ADataset);

  except
    on E: TDBXError do
     begin
       DMCosmosServerServices.RegisterLog(E.Message, TCosmosErrorCodes.ToErrorCode(E.ErrorCode), leOnError);
       if Assigned(ADataset) then FreeAndNil(ADataset);
       raise;
     end;
  end;
end;

function TDMCosmosApplicationServer.ChangePassword(const UserName,
  NewPassword: string): boolean;
var
 AMessage: string;
begin
{Muda a senha de um usuário.}
 try
   Result := TCosmosSecurity.ChangePassword(UserName, NewPassword);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    AMessage := TCosmosErrorMsg.PasswordUpdate;
    AMessage := AMessage.Format(AMessage, [UserName]);

    raise TDBXError.Create(TCosmosErrorCodes.PasswordUpdate, AMessage);
   end;
 end;
end;

function TDMCosmosApplicationServer.DoIdentificacaoAtiva(const UserName,
  NewPassword: string): boolean;
var
 APassword: string;
begin
{Confirma a identidade do usuário a partir de novo fornecimento de senha.}
 try
  aPassword := DMCosmosServerServices.Criptografar(NewPassword);
  Result := TCosmosSecurity.AuthenticateUser(UserName, aPassword);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.IdentificaoAtiva, TCosmosErrorMsg.IdentificaoAtiva);
   end;
 end;
end;

procedure TDMCosmosApplicationServer.DspAptidoesCadastradoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_APTIDOES, False]);
end;

procedure TDMCosmosApplicationServer.DspAptidoesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_AREAS_APTIDOES, False]);
end;

procedure TDMCosmosApplicationServer.DspAptidoesUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMCosmosApplicationServer.DspCargosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CARGOS, False]);
end;

procedure TDMCosmosApplicationServer.DspEnfermidadesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ENFERMIDADES, False]);
end;

procedure TDMCosmosApplicationServer.DspFamiliaresGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_FAMILIARES, False]);
end;

procedure TDMCosmosApplicationServer.DspFuncoesCadastradoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_FUNCOES_CADASTRADO, False]);
end;

procedure TDMCosmosApplicationServer.DspFuncoesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_FUNCOES, False]);
end;

procedure TDMCosmosApplicationServer.DspInfoMedicasGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_INFO_MED, False]);
end;

procedure TDMCosmosApplicationServer.DspMeiosContatoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_TIPOS_CONTATOS, False]);
end;

procedure TDMCosmosApplicationServer.DspProfissoesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PROFISSOES, False]);
end;

function TDMCosmosApplicationServer.ExecuteCommand(CommandID: Integer;
  const Params: OleVariant): integer;
var
ACosmosCommand: TCosmosCommand;
ACommand: string;
begin
 //Executa um command DML simples (uma linha) no servidor SQL.
 ACosmosCommand :=  TSQLServerInterface.GetCosmosCommand(CommandID);
 ACommand := TSQLCommandsFactory.GetDMLCommand(ACosmosCommand);

 //Preenche os valores dos parâmetros recebidos.
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);

 try
  Result := DMServerDataAcess.DoExecuteCommand(ACommand);

 except
  on E: EUnknownCommandError do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.CommandId, [CommandId]), leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.UnknownCosmosSearch, TCosmosErrorMsg.UnknownCosmosSearch);
   end;
  on E: TDBXError do
   begin
    DMCosmosServerServices.RegisterLog(TCosmosErrorMsg.ExecuteCommand, Format(TCosmosLogs.SQLCommand, [ACommand]), leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.ExecuteCommand, TCosmosErrorMsg.ExecuteCommand);
   end;
 end;
end;

function TDMCosmosApplicationServer.ExecuteCosmosSearch(CosmosSearch: Integer;
  Params: OleVariant): TDataset;
var
 ASearch: TCosmosSearch;
 ACommand: string;
 ADataset: TSQLDataset;
begin
//Executa uma pesquisa padrão do Cosmos.
 ASearch :=  TSQLServerInterface.GetCosmosSearch(CosmosSearch);
 ACommand := TSQLCommandsFactory.GetSQLCommand(ASearch);
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := ACommand;
  ADataset.Open;
  Result := ADataset;

 except
  on E: TDBXError do
   begin
    Result := nil;
    DMCosmosServerServices.RegisterLog(E.Message, ACommand, leOnError);
   end;
 end;
end;

function TDMCosmosApplicationServer.ExecuteDQL(SearchID: Integer;
  Params: OleVariant): TDataset;
begin
 try
  Result := DMServerDataAcess.DoExecuteDQL(SearchID, Params);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    //Redispara a exceção como um TDBXError para captura adequada no cliente.
    raise TDBXError.Create(TCosmosErrorCodes.SelectData, TCosmosErrorMsg.SelectData);
   end;
 end;
end;

function TDMCosmosApplicationServer.ExecuteRegisteredSearch(
  const SearchId: integer; Params: Olevariant): TDataset;
var
ACommand: string;
ADataset: TSQLDataset;
begin
//Executa uma pesquisa existente na tabela da Central de Pesquisas.
 Result := nil; //default
 ADataset := DMServerDataAcess.CreateDataset;

 try
 ACommand := TCosmosDataObjects.GetRegisteredCommand(SearchID);
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);

  //Executa o comando DQL...
  ADataset.CommandText := ACommand;
  ADataset.Open;
  Result := ADataset;
  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [ACommand]), DMServerDataAcess.GetContextInfo(ADataset));

 except
  on E: TDBXError do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, ADataset.CommandText, leOnError);
   end;
  on E: ECannotFindFile do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    //Redispara a exceção como um TDBXError para captura adequada no cliente.
    raise TDBXError.Create(TCosmosErrorCodes.CannotOpenFileCentralPesquisa, E.Message);
   end;
  on E: ECannotFindCommand do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.CommandId, [SearchId]), leOnError);
    //Redispara a exceção como um TDBXError para captura adequada no cliente.
    raise TDBXError.Create(TCosmosErrorCodes.CannotFindCentralPesquisaCmd, E.Message);
   end;
 end;
end;

function TDMCosmosApplicationServer.GetAcessedFocus(
  const UserName: WideString; CosmosModule: integer): TDataset;
var
ADataset: TSQLDataset;
sCommand: string;
begin
//Retorna os focos que o usuário passado em parâmetro pode acessar
 ADataset := DMServerDataAcess.CreateDataset;

 try
  case CosmosModule of
    0: {cmFocos} sCommand := Format(TSecurityCommand.UserFocos, [QuotedStr(UserName), 'OINDFOC', QuotedStr('S')]);
    2: {cmSecretarias} sCommand := Format(TSecurityCommand.UserFocos, [QuotedStr(UserName), 'OINDSEC', QuotedStr('S')]);
    4: {cmFinanceiro} sCommand := Format(TSecurityCommand.UserFocos, [QuotedStr(UserName), 'OINDFIN', QuotedStr('S')]);
    6: {cmConferencias} sCommand := Format(TSecurityCommand.UserFocos, [QuotedStr(UserName), 'OINDCON', QuotedStr('S')]);
    8: {cmUsuarios} sCommand := Format(TSecurityCommand.UserFocos, [QuotedStr(UserName), 'OINDUSU', QuotedStr('S')]);
    else
     raise TDBXError.Create(TCosmosErrorCodes.OpenFocusUnknownModule, TCosmosErrorMsg.OpenFocusUnknownModule);
  end;

  ADataset.CommandText := sCommand;
  ADataset.Open;
  Result := ADataset;

 except
  on E: TDBXError do
   begin
    Result := nil;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    DMCosmosServerServices.RegisterLog(E.Message, TCosmosErrorCodes.ToErrorCode(E.ErrorCode), leOnError);
   end;
 end;
end;

function TDMCosmosApplicationServer.GetActiveRange: Int64;
begin
  Result := DMServerDataAcess.ActiveRange;
end;

function TDMCosmosApplicationServer.GetAddressLabelsInfo: TStringStream;
var
 AStream: TStringStream;
 AXMLFile: string;
 CosmosApp: TCosmosApplication;
begin
//Envia o arquivo de parâmetros de relatórios para o cliente.
  AStream := TStringStream.Create('', TEncoding.UTF8);
  CosmosApp := TCosmosApplication.Create;

  try
   AXMLFile := CosmosApp.GetModulePath + 'AddressLabels.xml'; //do not localize!

   AStream.LoadFromFile(AXMLFile);
   AStream.Position := 0;

  finally
   Result := AStream;
   if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
  end;
end;

function TDMCosmosApplicationServer.GetAuthorizations(
  const UserName: WideString; out ModuleFeatures: string): string;
var
 AList, AModuleList, ARoleList: TStringList;
 IAuthorizations: IXMLAuthorizationsType;
 IFeaturesInfo: IXMLFeatureInfoType;
 AFileName, ARoleName: string;
 I, AIndex: integer;
 CosmosApp: TCosmosApplication;
 sCommonModule, sModuleName: string;
 ModuleFeature: boolean;
begin
 {Povoa uma lista com o ID interno das funcionalidades que um usuário pode acessar,
 conforme as roles a que ele pertence.}
 sCommonModule := TCosmosAppName.CosmosCommonId;
 sModuleName := DMCosmosServerServices.CosmosModuleIdentifier;

 AList := TStringList.Create;
 AModuleList := TStringList.Create;
 ARoleList := TStringList.Create;
 CosmosApp := TCosmosApplication.Create;

{Carrega as informações de autorização existente no arquivo de configuração de
 permissões "RolesPermissions.xml".}
 AFileName := CosmosApp.GetModulePath + TCosmosFiles.RolesPermissions;  //do not localize!
 IAuthorizations := LoadAuthorizations(AFileName);

 //Carrega as roles atribuídas ai]o usuário corrente.
 ARoleList.CommaText := ReadUserRoles(UserName);

 try
  for I := 0 to Pred(IAuthorizations.Features.Count) do
   begin
    IFeaturesInfo := IAuthorizations.Features.FeatureInfo[I];
    if (IFeaturesInfo <> nil) then
     begin
      for AIndex := 0 to Pred(ARoleList.Count) do
       begin
        ARoleName := ARoleList.Strings[AIndex];

        //Verifica se o feature está associado à Role do usuário.
        if Pos(ARoleName, IFeaturesInfo.AuthorizedRoles) > 0 then
         begin
           //Se a feature não é do módulo, pula para a próxima feature.
           if (not IFeaturesInfo.CosmosModule.Contains(TCosmosAppName.CosmosCommonId)) then
             begin
              if (not (IFeaturesInfo.CosmosModule.Contains(sModuleName))) then
               Continue;
             end;


           //Verifica se a featura é específica do módulo ou comum às aplicações Cosmos.
           ModuleFeature := not IFeaturesInfo.Common.ToBoolean;

           if ModuleFeature then //Feature específica do módulo.
            begin
             if AModuleList.IndexOf(IntToStr(IFeaturesInfo.FeatureId)) < 0 then
              AModuleList.Append(IntToStr(IFeaturesInfo.FeatureId));

             Continue;
            end
            else
            begin  //Feature comum às aplicações Cosmos.
             if AList.IndexOf(IntToStr(IFeaturesInfo.FeatureId)) < 0 then
              AList.Append(IntToStr(IFeaturesInfo.FeatureId));

             Continue;
            end;
         end;
       end;
       {Verifica se o feature está associado ao usuário como um privilégio
        individual, independentemente de sua Role.}
       if Pos(LowerCase(UserName), IFeaturesInfo.PrivilegedUsers) > 0 then
        begin
         if ModuleFeature then
          begin
           if AModuleList.IndexOf(IntToStr(IFeaturesInfo.FeatureId)) < 0 then
            AModuleList.Append(IntToStr(IFeaturesInfo.FeatureId));
          end
         else
          if AList.IndexOf(IntToStr(IFeaturesInfo.FeatureId)) < 0 then
           AList.Append(IntToStr(IFeaturesInfo.FeatureId));
        end;
     end; //end IfeaturesInfo = nil
   end; //end loop

 finally
  Result := AList.CommaText;
  ModuleFeatures := AModuleList.CommaText;

  if Assigned(IAuthorizations) then IAuthorizations := nil;
  if Assigned(AList) then FreeAndNil(AList);
  if Assigned(AModuleList) then FreeAndNil(AModuleList);
  if Assigned(ARoleList) then FreeAndNil(ARoleList);
  if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
 end;

end;

function TDMCosmosApplicationServer.GetCamposTrabalho(
  const UserName: WideString): string;
var
 AList, ARoleList: TStringList;
 ARoleName: string;
 I: integer;
 ADataset: TSQLDataset;
 ACampo: TCampoTrabalho;
begin
 {Povoa uma lista com o índice dos campos de trabalho que um usuário pode acessar,
 conforme as roles a que ele pertence.}
 AList := TStringList.Create;
 ARoleList := TStringList.Create;

 ARoleList.CommaText := ReadUserRoles(UserName);
 ADataset := DMServerDataAcess.CreateDataset;

 try
  for I := 0 to Pred(ARoleList.Count) do
   begin
    ARoleName := ARoleList.strings[I];
    ARoleName := ARoleName.UpperCase(ARoleName);

    if (ARoleName.Trim <> '') then
     begin
      DMServerDataAcess.CloseDataset(ADataset);
      ADataset.CommandText := TSecurityCommand.PerfilUsuario.Format(TSecurityCommand.PerfilUsuario , [QuotedStr(ARoleName)]);
      ADataset.Open;

      while not ADataset.Eof do
       begin
        if ADataset.Fields.FieldByName('INDLEC').AsString = 'S' then
         begin
          ACampo := ctLectorium;
          if AList.IndexOf(IntToStr(Ord(ACampo))) < 0 then
           AList.Append(IntToStr(Ord(ACampo)));
         end;

        if ADataset.Fields.FieldByName('INDTMO').AsString = 'S' then
         begin
          ACampo := ctTM;
          if AList.IndexOf(IntToStr(Ord(ACampo))) < 0 then
           AList.Append(IntToStr(Ord(ACampo)));
         end;

        if ADataset.Fields.FieldByName('INDTPU').AsString = 'S' then
         begin
          ACampo := ctTP;
          if AList.IndexOf(IntToStr(Ord(ACampo))) < 0 then
           AList.Append(IntToStr(Ord(ACampo)));
         end;

        if ADataset.Fields.FieldByName('INDEIN').AsString = 'S' then
         begin
          ACampo := ctEI;
          if AList.IndexOf(IntToStr(Ord(ACampo))) < 0 then
           AList.Append(IntToStr(Ord(ACampo)));
         end;

        if ADataset.Fields.FieldByName('INDSIM').AsString = 'S' then
         begin
          ACampo := ctSimpatizantes;
          if AList.IndexOf(IntToStr(Ord(ACampo))) < 0 then
           AList.Append(IntToStr(Ord(ACampo)));
         end;

         ADataset.Next;
       end;
     end;
   end;

 finally
  Result := AList.CommaText;
  if Assigned(AList) then FreeAndNil(AList);
  if Assigned(ARoleList) then FreeAndNil(ARoleList);
 end;

end;

function TDMCosmosApplicationServer.GetConnectedUserInfo(
  const UserName: WideString): TDataset;
var
 ADataset: TSQLDataset;
begin
 {Busca os dados pessoais de um usuário. Estas informações são usadas em diversos
 locais das aplicações Cosmos}
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TSecurityCommand.UserInfo, [QuotedStr(UserName)]);
  ADataset.Open;
  Result := ADataset;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.AuthenticateProcess, TCosmosErrorMsg.AuthenticateProcess);
   end;
 end;
end;

function TDMCosmosApplicationServer.GetFieldsInfo: TStringStream;
var
 AStream: TStringStream;
 AXMLFile: string;
 CosmosApp: TCosmosApplication;
begin
//Envia o arquivo de informações de campos de datasets para o cliente.
  AStream := TStringStream.Create('', TEncoding.UTF8);
  CosmosApp := TCosmosApplication.Create;

  try
   AXMLFile := CosmosApp.GetModulePath + TCosmosFiles.FieldsInfo; //do not localize!

   AStream.LoadFromFile(AXMLFile);
   AStream.Position := 0;


  finally
   Result := AStream;
   if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
  end;
end;

function TDMCosmosApplicationServer.GetFotoCadastrado(
  const IdCadastrado: integer): Olevariant;
var
 AStream: TMemoryStream;
 ADataset: TSQLDataset;
begin
{Envia a foto de um cadastrado em um formato Olevariant. ATENÇÃO: o formato
 olevariant está sendo usado nesse método devido a uma falha no Datasnap. A
 falha consiste que o stream contendo a imagem JPEG chega vazio sempre. Consultar
 https://forums.embarcadero.com/thread.jspa?messageID=433556.}
  AStream := TMemoryStream.Create;
  ADataset := DMServerDataAcess.CreateDataset;

  try
   ADataset.CommandText := Format(TDQLCommand.DadosCadastrado, [IdCadastrado]);
   ADataset.Open;
   if TBlobField(ADataset.Fields.FieldByName('fotcad')).BlobSize > 0 then
    begin
     TBlobField(ADataset.Fields.FieldByName('fotcad')).SaveToStream(AStream);
     AStream.Position := 0;

     Result := TDataConverter.MemoryStreamToOleVariant(AStream);
    end
   else
    Result := null;

   if Assigned(ADataset) then FreeAndNil(ADataset);

  except
   on E: Exception do
    begin
     if Assigned(ADataset) then FreeAndNil(ADataset);
     DMCosmosServerServices.RegisterLog(E.Message, DMServerDataAcess.GetContextInfo(ADataset), leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.DadosCadastrado, TCosmosErrorMsg.DadosCadastrado);
    end;
 end;
end;

function TDMCosmosApplicationServer.GetReportsInfo: TStringStream;
var
 AStream: TStringStream;
 AXMLFile: string;
 CosmosApp: TCosmosApplication;
begin
//Envia o arquivo de parâmetros de relatórios para o cliente.
  AStream := TStringStream.Create('', TEncoding.UTF8);
  CosmosApp := TCosmosApplication.Create;

  try
   AXMLFile := CosmosApp.GetModulePath + TCosmosFiles.ReportsParams; //do not localize!

   AStream.LoadFromFile(AXMLFile);
   AStream.Position := 0;

  finally
   Result := AStream;
   if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
  end;
end;

function TDMCosmosApplicationServer.GetSearchsCentralInfo: TStringStream;
var
 AStream: TStringStream;
 AXMLFile: string;
 CosmosApp: TCosmosApplication;
begin
//Envia o arquivo de parâmetros de relatórios para o cliente.
  AStream := TStringStream.Create('', TEncoding.UTF8);
  CosmosApp := TCosmosApplication.Create;

  try
   AXMLFile := CosmosApp.GetModulePath + TCosmosFiles.CentralPesquisas; //do not localize!

   AStream.LoadFromFile(AXMLFile);
   AStream.Position := 0;

  finally
   Result := AStream;
   if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
  end;
end;

function TDMCosmosApplicationServer.GetSequenceValue(
  const SequenceName: WideString): integer;
begin
 //Retorna o valor de uma sequence.
 try
  Result := DMServerDataAcess.DoGetSequenceValue(SequenceName);

 except
  DMCosmosServerServices.RegisterLog(TCosmosErrorMsg.SelectSequenceData, Format(TCosmosLogs.SequenceName, [SequenceName]), leOnError);
  raise TDBXError.Create(TCosmosErrorCodes.SelectSequenceData, TCosmosErrorMsg.SelectSequenceData);
 end;
end;

function TDMCosmosApplicationServer.GetServerDateTime: TDateTime;
begin
 //Retorna a data e hora no servidor.
 Result := Now;
end;

function TDMCosmosApplicationServer.GetTableProviderName(
  Table: Integer): string;
begin
//Retorna o nome de um TDatasetProvider que retorna os dados de uma tabela acessória.
 try
  case TCosmosTables(Table) of
   ctAptidoes: Result := 'DspAptidoes';
   ctCargos: Result := 'DspCargos';
   ctEnfermidades: Result := 'DspEnfermidades';
   ctFuncoes: Result := 'DspFuncoes';
   ctMeiosContatos: Result := 'DspMeiosContato';
   ctProfissoes: Result := 'DspProfissoes';
   ctTiposRecebimentos: Result := 'DspTiposRecebimentos';
  else
   begin
    Result := '';
    raise TDBXError.Create(TCosmosErrorCodes.SelectData, TCosmosErrorMsg.SelectData);
   end;
  end


 except
  on E: TDBXError do
   begin
    Result := '';
    DMCosmosServerServices.RegisterLog(E.Message, TCosmosErrorCodes.ToErrorCode(E.ErrorCode), leOnError);
   end;
 end;
end;

function TDMCosmosApplicationServer.GetTableVersion(TableId: integer): integer;
var
 aDataset: TSQLDataset;
 aCommand, sTableId: string;
begin
 {Retorna a versão corrente de uma table buferizada no lado cliente. Essa informação
 é necessária para que o cliente compare a sua versão local com a recebida por
 esse método para decisir se é necessário uma nova buferização de dados.}
 aDataset := DMServerDataAcess.CreateDataset;
 aCommand := TDQLCommand.TableVersion;

 sTableId := TCosmosTablesInfo.GetCosmosTablesId(TCosmosTables(TableId));
 aCommand := aCommand.Format(aCommand, [QuotedStr(sTableId)]);
 aDataset.CommandText := aCommand;

 try
   aDataset.Open;
   Result := aDataset.FieldValues['versao'];
   aDataset.Free;
   //DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [ACommand]), DMServerDataAcess.GetContextInfo(ADataset));

 except
  on E: Exception do
   begin
    aDataset.Free;
    DMCosmosServerServices.RegisterLog(E.Message, DMServerDataAcess.GetContextInfo(ADataset), leOnError);
   end;
 end;
end;

function TDMCosmosApplicationServer.ListData(SearchID: Integer;
  Params: OleVariant): TDBXReader;
var
ACommand: string;
ACosmosSearch: TCosmosSearch;
ADBXCommand: TDBXCommand;
begin
//Executa uma pesquisa e retorna um objeto do TDBXReader para leitura de dados.
 Result := nil; //default

 ACosmosSearch :=  TSQLServerInterface.GetCosmosSearch(SearchID);
 ACommand := TSQLCommandsFactory.GetSQLCommand(ACosmosSearch);

 if ACommand <> '' then
   TSQLCommandsFactory.CreateCommandText(ACommand, Params)
 else
  raise TDBXError.Create(TCosmosErrorCodes.UnknownCosmosSearch, TCosmosErrorMsg.UnknownCosmosSearch);

 ADBXCommand := DMServerDataAcess.CreateCommand;
 ADBXCommand.CommandType := TDBXCommandTypes.DbxSQL;
 ADBXCommand.Text := ACommand;

 try
  //Executa o comando DQL...
  Result := ADBXCommand.ExecuteQuery;
  DMCosmosServerServices.RegisterLog(Format(TCosmosLogs.SQLCommand, [ACommand]), '', leOnInformation);

 except
  on E: EUnknownCommandError do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [ACommand]), leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.UnknownCosmosSearch, TCosmosErrorMsg.UnknownCosmosSearch);
   end;
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, ACommand, leOnError);
   end;
 end;

end;

function TDMCosmosApplicationServer.LockCosmosUser(
  const codusu: integer): boolean;
begin
 {Bloqueia um usuário do Cosmos.}
 try
   Result := TCosmosSecurity.LockCosmosUser(codusu);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.LockUser, TCosmosErrorMsg.LockUser);
   end;
 end;
end;

function TDMCosmosApplicationServer.PasswordIsTemporary(const UserName:
  WideString): boolean;
begin
{Checa se a senha de um usuário está expirada.}
 try
  Result := TCosmosSecurity.PasswordIsTemporary(UserName);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.AuthenticateProcess, TCosmosErrorMsg.AuthenticateProcess);
   end;
 end;
end;

function TDMCosmosApplicationServer.PingServer: boolean;
begin
//Usado apenas para os clientes testarem a conexão com este servidor.
 Result := True;
end;

function TDMCosmosApplicationServer.ReadUserRoles(
  const UserName: string): string;
var
 AList: TStringList;
begin
{Retorna as roles de um usuário.}
 AList := TStringList.Create;

 try
  TCosmosSecurity.GetUserRoles(UserName, AList);
  Result := AList.CommaText;

  if Assigned(AList) then FreeAndNil(AList);

 except
  on E: Exception do
   begin
    Result := '';
    if Assigned(AList) then FreeAndNil(AList);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.AuthenticateProcess, TCosmosErrorMsg.AuthenticateProcess);
   end;
 end;
end;

procedure TDMCosmosApplicationServer.ResetPasword(const UserName: string;
  out NewPassword: string);
var
 AMessage: string;
begin
 {Reseta a senha de um usuário e torna-a provisória}
 try
   TCosmosSecurity.ResetPasword(UserName, NewPassword);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    AMessage := TCosmosErrorMsg.PasswordReset;
    AMessage := AMessage.Format(AMessage, [UserName]);

    raise TDBXError.Create(TCosmosErrorCodes.PasswordReset, AMessage);
   end;
 end;
 end;

function TDMCosmosApplicationServer.SearchCadastrados(SearchType, Foco: Integer;
  const Campo, Argument: WideString): TDataset;
var
 ADataset: TSQLDataset;
 ACommand: string;
begin
//Pesquisa cadastrados a partir de um conjunto de argumentos.
 ADataset := DMServerDataAcess.CreateDataset;

 try
  case SearchType of
   0: ACommand := ACommand.Format(TDQLCommand.CadastradosMatriculaFoco, [Foco, QuotedStr(Campo), QuotedStr(Argument)]);
   1: ACommand := ACommand.Format(TDQLCommand.CadastradosNomeFoco, [Foco, QuotedStr(Campo), QuotedStr(Argument + '%')]);
   2: ACommand := ACommand.Format(TDQLCommand.CadastradosApelidoFoco, [Foco, QuotedStr(Campo), QuotedStr(Argument + '%')]);
  end;

  ADataset.Open;
  Result := ADataset;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [ACommand]), leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.CadastradosSearch, TCosmosErrorMsg.CadastradosSearch);
   end;
 end;
end;

procedure TDMCosmosApplicationServer.SQLDiscipuladosBeforeOpen(
  DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

function TDMCosmosApplicationServer.VerifyCosmosServer(
  CosmosModule: Integer): boolean;
begin
//Verifica se o client que está conectando com o servidor é o correto.
 try
  case CosmosModule of
    0: {cmFocos} Result := DMCosmosServerServices.CosmosModule = cmFocosServer;
    2: {cmSecretarias} Result := DMCosmosServerServices.CosmosModule = cmSecretariasServer;
    4: {cmFinanceiro} Result := DMCosmosServerServices.CosmosModule = cmFinanceiroServer;
    6: {cmConferencias} Result := DMCosmosServerServices.CosmosModule = cmConferenciasServer;
    8: {cmUsuarios} Result := DMCosmosServerServices.CosmosModule = cmUsuariosServer;
    else
     raise TDBXError.Create(TCosmosErrorCodes.IncorrectServerModule, TCosmosErrorMsg.IncorrectServer);
  end;

 except
  on E: TDBXError do
   begin
    Result := False;
    DMCosmosServerServices.RegisterLog(E.Message, TCosmosErrorCodes.ToErrorCode(E.ErrorCode), leOnError);
   end;
 end;

end;

end.

