unit RDMFinanceiro;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, finser_TLB, StdVcl, FMTBcd, SqlExpr, SQLScript, ServerConnections,
  Provider, DB, Cosmos.logs.winservice, cosmos.core.SQLServerInterface,
  cosmos.core.classes, cosmos.core.cripterint, ActiveX, Variants,
  cosmos.persistence.registry, cosmos.framework.interfaces.utils,
  WideStrings, DBXCommon, DBXFirebird, cosmos.core.server.cosmosobj, cosmos.core.server.dataobjects,
  cosmos.core.server.security, cosmos.core.server.utils,
  cosmos.persistence.ini, cosmos.core.classes.FieldsInfo;

type
  TUserInfo = record
   logusu: string;
   nomusu: string;
   sigfoc: string;
  end;


  TFinanceiro = class(TRemoteDataModule, IFinanceiro)
    SQLCon: TSQLConnection;
    SQLSearch: TSQLDataSet;
    DspSearch: TDataSetProvider;
    SQLCommand: TSQLDataSet;
    SQLMonitor: TSQLMonitor;
    SQLConta: TSQLDataSet;
    DspConta: TDataSetProvider;
    SQLContaCODCON: TIntegerField;
    SQLContaDESCON: TStringField;
    SQLContaDESCONING: TStringField;
    SQLContaTIPCON: TStringField;
    SQLContaCODFOC: TIntegerField;
    SQLContaNOMFOC: TStringField;
    SQLContaCODCONPAR: TIntegerField;
    SQLContaINDNAC: TStringField;
    SQLContaDATCAD: TSQLTimeStampField;
    SQLContaUSURES: TStringField;
    SQLCadastrado: TSQLDataSet;
    DspCadastrado: TDataSetProvider;
    SQLCadastradoCODCAD: TIntegerField;
    SQLCadastradoNOMCAD: TStringField;
    SQLCadastradoMATCAD: TStringField;
    SQLCadastradoSIGDIS: TStringField;
    SQLCadastradoSIGFOC: TStringField;
    SQLCadastradoFOTCAD: TGraphicField;
    SQLRecebimentos: TSQLDataSet;
    DspRecebimentos: TDataSetProvider;
    SQLRecebimentosCODREC: TIntegerField;
    SQLRecebimentosANOREF: TSmallintField;
    SQLRecebimentosVALPRE: TFMTBCDField;
    SQLRecebimentosVALREC: TFMTBCDField;
    SQLRecebimentosCODTIPREC: TIntegerField;
    SQLRecebimentosDESTIPREC: TStringField;
    SQLRecebimentosCODCAD: TIntegerField;
    SQLRecebimentosDATREC: TSQLTimeStampField;
    SQLRecebimentosUSURES: TStringField;
    SQLTiposRecebimentos: TSQLDataSet;
    DspTiposRecebimentos: TDataSetProvider;
    SQLRecebimentosDATCAD: TSQLTimeStampField;
    SQLRecebimento: TSQLDataSet;
    IntegerField1: TIntegerField;
    SmallintField1: TSmallintField;
    SmallintField2: TSmallintField;
    FMTBCDField1: TFMTBCDField;
    FMTBCDField2: TFMTBCDField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    StringField2: TStringField;
    SQLTimeStampField1: TSQLTimeStampField;
    SQLTimeStampField2: TSQLTimeStampField;
    StringField3: TStringField;
    DspRecebimento: TDataSetProvider;
    SQLRecebimentosMES: TStringField;
    SQLRecebimentosMESREF: TSmallintField;
    SQLPesquisarPlanoContas: TSQLDataSet;
    DspPesquisarPlanoContas: TDataSetProvider;
    SQLCentrosCusto: TSQLDataSet;
    DspCentrosCusto: TDataSetProvider;
    SQLCentroCusto: TSQLDataSet;
    DspCentroCusto: TDataSetProvider;
    SQLCentroCustoCODCEN: TIntegerField;
    SQLCentroCustoNOMCEN: TStringField;
    SQLCentroCustoNOMENG: TStringField;
    SQLCentroCustoCODFOC: TIntegerField;
    SQLCentroCustoNOMFOC: TStringField;
    SQLCentroCustoINDATI: TStringField;
    SQLCentrosCustoCODCEN: TIntegerField;
    SQLCentrosCustoNOMCEN: TStringField;
    SQLCentrosCustoNOMENG: TStringField;
    SQLCentrosCustoCODFOC: TIntegerField;
    SQLCentrosCustoNOMFOC: TStringField;
    SQLCentrosCustoINDATI: TStringField;
    SQLTiposRecebimentosCODTIPREC: TIntegerField;
    SQLTiposRecebimentosDESTIPREC: TStringField;
    SQLTiposRecebimentosVERSION: TIntegerField;
    SQLTiposRecebimentosSYNC: TSmallintField;
    SQLCadastradoVALMEN: TFMTBCDField;
    SQLCadastradoVALTAX: TFMTBCDField;
    SQLTransacoes: TSQLDataSet;
    DspTransacoes: TDataSetProvider;
    SQLTransacoesCODTRA: TIntegerField;
    SQLTransacoesCODCAI: TIntegerField;
    SQLTransacoesNUMCAI: TStringField;
    SQLTransacoesCODFOC: TIntegerField;
    SQLTransacoesNOMFOC: TStringField;
    SQLTransacoesSIGFOC: TStringField;
    SQLTransacoesDATTRA: TDateField;
    SQLTransacoesDESTRA: TStringField;
    SQLTransacoesVALTRA: TFMTBCDField;
    SQLTransacoesINDDEBCRE: TStringField;
    procedure DspTiposRecebimentosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTiposRecebimentosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspCentroCustoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspCentroCustoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspRecebimentoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspRecebimentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspContaGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspContaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure SQLSearchAfterOpen(DataSet: TDataSet);
    procedure RemoteDataModuleDestroy(Sender: TObject);
    procedure RemoteDataModuleCreate(Sender: TObject);
    procedure SQLConAfterConnect(Sender: TObject);
    procedure DspSearchUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure SQLMonitorLogTrace(Sender: TObject; TraceInfo: TDBXTraceInfo);
  private
    { Private declarations }
    FConnectedUser: TCosmosUser;
    FConnectionID: TGUID; //Mapeia um identificador exclusivo para uma conexão.
    FCosmosFolder, FConnectionRole, FConnectionPath: string;
    FLog: TWinServiceLog; //Classe registradora de logs.
    FActiveRange: Int64; //Faixa d formação de chaves primárias.
    FLastUpdateError: Olevariant;
    AFieldsInfoReader: TFieldsInfoReader;
    FMaxLineTrace: integer;

    procedure CloseDataset(const Dataset: TDataset); inline;
    procedure ReadChipherKey(var Key: string); inline;
    procedure CreateLog(const Message: string; MsgType: Cardinal); inline;
    procedure ConfigureLogSystem;
    procedure SetConnectionParams; inline;//Carrega informações sobre a conexão com o banco de dados.
    procedure DoExecuteDQL(const DQL: WideString);
    function DoExecuteCommand(const Command: WideString): integer;
    function DoExecuteScript(var AScript: TStringList): boolean;
    function GetCurrentCosmosModule: TCosmosModules;
    function NewSQLMonitorFile: string;
    procedure ConfigureDatabaseMonitor;
    function GetUserStatus(const UserName: string): TUserStatus;
    function CreateMessageData: TServerReturn; inline;
    procedure DoCreateUpdateDataError(E: Exception);

  protected
    function GetTableProviderName(Table: Integer): OleVariant; safecall;
    function ExcluirConta(Conta: Integer): OleVariant; safecall;
    function MoverConta(Conta, Parent: Integer): OleVariant; safecall;
    function GetSequenceValue(const SequenceName: WideString): OleVariant; safecall;
    function GetContas: OleVariant; safecall;
    function GetSubcontas(codcon: Integer): OleVariant; safecall;
    function GetAcessedFocus(const UserName: WideString): OleVariant; safecall;
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant; safecall;

    function IsAdministrator(const UserName: WideString): OleVariant; safecall;
    function GetPerfilData: OleVariant; safecall;
    function ConnectDatabase(const UserName, Password, RoleName,
      HostName: WideString): OleVariant; safecall;
    procedure BufferData(const SchemmaName: WideString;
      out DataPackage: OleVariant); safecall;
    function Get_ServerComputer: OleVariant; safecall;
    function Get_ServerDateTime: OleVariant; safecall;
    function Get_DatabaseVersion: OleVariant; safecall;
    function Get_CodeKey: OleVariant; safecall;
    function Get_ActiveUser: OleVariant; safecall;
    function Get_BetaVersion: WordBool; safecall;
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_ActiveRange: OleVariant; safecall;
  public
    { Public declarations }
     property ActiveRange: Int64 read FActiveRange;
     property ConnectedUser: TCosmosUser read FConnectedUser;
     property CurrentCosmosModule: TCosmosModules read GetCurrentCosmosModule;
     property Log: TWinServiceLog read FLog;

  end;

implementation

uses cosmos.core.constantesmsg, SQLConsts, Main, cosmos.core.winshell;

{$R *.DFM}

class procedure TFinanceiro.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

procedure TFinanceiro.CloseDataset(const Dataset: TDataset);
begin
//Fecha um dataset ativo
 if Assigned(Dataset) then
  if Dataset.Active then
   Dataset.Close;
end;

procedure TFinanceiro.ConfigureDatabaseMonitor;
begin
  //Verifica se a conexão com o servidor SQL estará em monitoramento.
  FMaxLineTrace := TCosmosInfoFiles.GetMaxLineTracesMonitor;
  SQLMonitor.FileName := self.NewSQLMonitorFile;
  SQLMonitor.Active := TCosmosInfoFiles.IsMonitoringDatabase;

  if SQLMonitor.Active then
    SQLMonitor.SQLConnection := SQLCon;
end;

procedure TFinanceiro.ConfigureLogSystem;
var
 AList: TStringList;
begin
//Configura o objeto interno da classe TWinService que usa o serviço de escrita
//de logs do MSWindows.
 if Assigned(FLog) then
  begin
   AList := TStringList.Create;

   try
     TCosmosApplication.ReadLogInformation(cmFinanceiroServer, AList);

     TWinServiceLog(FLog).ConfigureService(AList.Values['CategoryMessageFile'],
      AList.Values['DisplayEventFile'], AList.Values['DisplayNameFile'],
      AList.Values['DisplayEventID'], AList.Values['EventFile'],
      AList.Values['PrimaryModule'], AList.Values['Source'], AList.Values['LogName'],
      StrToInt(AList.Values['CategoryCount']), StrToInt(AList.Values['DisplayNameID']),
      StrToInt(AList.Values['TypesSupported']));  //do not localize!

   finally
     if Assigned(AList) then
      FreeAndNil(AList);
   end;
  end;
end;

procedure TFinanceiro.CreateLog(const Message: string; MsgType: Cardinal);
begin
//Escreve um log no sistema de logs do Windows usando o component TEventWriter.
 case MsgType of
  EVENTLOG_SUCCESS : Log.RegisterSucess(Message);
  EVENTLOG_ERROR_TYPE: Log.RegisterError(Message);
  EVENTLOG_WARNING_TYPE: Log.RegisterWarning(Message);
  EVENTLOG_INFORMATION_TYPE: Log.RegisterInfo(Message);
  EVENTLOG_AUDIT_SUCCESS: Log.RegisterAuditSucess(Message);
  EVENTLOG_AUDIT_FAILURE: Log.RegisterAuditFailure(Message);
 end;
end;

function TFinanceiro.CreateMessageData: TServerReturn;
begin
 //Cria um objeto TServerReturn e configura suas propriedades com valores-padrão.
 Result := TServerReturn.Create;
 Result.Code := 0;
 Result.HelpContext := 0;
 Result.MessageText := '';
 Result.MessageTitle := '';
 Result.MessageType := mtpSucess;
 Result.CosmosModule := cmFinanceiroServer;
 Result.SetMessageInfo(miInstallationID, self.ActiveRange);

 if self.SQLCon.Connected then
  begin
   Result.SetMessageInfo(miRoleName, SQLCon.Params.Values['Role']);
   Result.SetMessageInfo(miUserName, SQLCon.Params.Values['User_Name']);
  end;
end;

procedure TFinanceiro.DspCentroCustoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_CENTROS_CUSTOS, False]);
end;

procedure TFinanceiro.DspCentroCustoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
TableName := 'CENTRO_CUSTOS';
end;

procedure TFinanceiro.DspContaGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_CONTAS, False]);
end;

procedure TFinanceiro.DspContaGetTableName(Sender: TObject; DataSet: TDataSet;
  var TableName: WideString);
begin
TableName := 'CONTAS';
end;

procedure TFinanceiro.DspRecebimentoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_RECEBIMENTOS, False]);
end;

procedure TFinanceiro.DspRecebimentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
TableName := 'RECEBIMENTOS';
end;

procedure TFinanceiro.DspSearchUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 self.DoCreateUpdateDataError(E);
end;

procedure TFinanceiro.DspTiposRecebimentosGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_TIPOS_RECEBIMENTOS, False]);
end;

procedure TFinanceiro.DspTiposRecebimentosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
TableName := 'TIPOS_RECEBIMENTOS';
end;

function TFinanceiro.Get_ActiveUser: OleVariant;
begin
//Retorna o nome do usuário ativo, caso exista um
 if SQLCon.Connected then
  Result := SqlCon.Params.values['user_name']
 else
  Result := ''; //Retorna um ponteiro nulo
end;

function TFinanceiro.Get_BetaVersion: WordBool;
begin
 Result := False;
end;

function TFinanceiro.Get_CodeKey: OleVariant;
var
AReturn: TServerReturn;
begin
//Lê a chave dinâmica para operação de criptografia e descriptografia.
 AReturn := self.CreateMessageData;

 try
  AReturn.Code := 0;
  AReturn.ServerData := FCodeKey;
  Result := AReturn.ServerReturn;

  if Assigned(AReturn) then
   FreeAndNil(AReturn);

 except
  on E: Exception do
   begin
    if Assigned(AReturn) then
     begin
      AReturn.Code := -1;
      AReturn.ServerData := '';
      AReturn.MessageType := mtpError;
      AReturn.MessageText := sErrorGetCodeKey;
      AReturn.MessageTitle := sTitleServerConection;
      AReturn.SetMessageInfo(miInnerMessage, E.Message);
      Result := AReturn.ServerReturn;
      AReturn.Free;
     end;

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

procedure TFinanceiro.SetConnectionParams;
begin
 //Obtém as informações de configuração em memória sobre conexão do banco de dados.
 try
  if FConnectionPath = '' then
   EDatabaseConnectError.Create(sDatabaseNotFound);

  SQLCon.ConnectionName := 'COSMOS';
  SQLCon.LoadParamsFromIniFile(self.FCosmosFolder + 'dbxconnections.ini');

 except
  raise;
 end;
end;

procedure TFinanceiro.SQLConAfterConnect(Sender: TObject);
begin
 //Obtém o número de faixa de chaves primárias do banco de dados
 try
  DoExecuteDQL(Format(sSQLGenerators, [sGEN_ACTIVE_RANGE, 0]));
  FActiveRange := SQLSearch.Fields.Fields[0].Value;

 finally
  CloseDataset(SQLSearch);
 end
end;

procedure TFinanceiro.SQLMonitorLogTrace(Sender: TObject;
  TraceInfo: TDBXTraceInfo);
begin
 if (SQLMonitor.Active) and (SQLMonitor.TraceCount > FMaxLineTrace) then
  begin
   SQLMonitor.SaveToFile(SQLMonitor.FileName);
   SQLMonitor.TraceList.Clear;
   SQLMonitor.FileName := self.NewSQLMonitorFile;
  end;
end;

procedure TFinanceiro.SQLSearchAfterOpen(DataSet: TDataSet);
begin
 TCosmosFields.LoadFieldsInfo(Dataset);
end;

function TFinanceiro.Get_DatabaseVersion: OleVariant;
var
AReturn: TServerReturn;
begin
//Obtém a versão do banco de dados
 AReturn := self.CreateMessageData;

 try
  CloseDataset(SQLSearch);
  self.DoExecuteDQL(Format(sSQLGenerators, [sGEN_DBVERSION,0]));
  AReturn.ServerData := SQLSearch.Fields.Fields[0].AsInteger;
  CloseDataset(SQLSearch);
  Result := AReturn.ServerReturn;

  if Assigned(AReturn) then
   FreeAndNil(AReturn);

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleErrorSelectData;
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFinanceiro.Get_ServerComputer: OleVariant;
var
AReturn: TServerReturn;
begin
//Retorna o nome do computador no qual a aplicação servidora está rodando
 AReturn := self.CreateMessageData;

 try
  AReturn.Code := 0;
  AReturn.ServerData := TWinShell.GetComputerName;
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    if Assigned(AReturn) then
     begin
      AReturn.Code := -1;
      AReturn.ServerData := '';
      AReturn.MessageType := mtpError;
      AReturn.MessageText := sErrorGetServerName;
      AReturn.MessageTitle := sTitleSystemFailure;
      Result := AReturn.ServerReturn;
      AReturn.Free;
     end;

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFinanceiro.Get_ServerDateTime: OleVariant;
var
AReturn: TServerReturn;
begin
 //Retorna a data e hora no servidor.
 AReturn := self.CreateMessageData;

 try
  AReturn.ServerData := Now;
  Result := AReturn.ServerReturn;
  if Assigned(AReturn) then AReturn.Free;


 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorGetServerDateTime;
    AReturn.MessageTitle := sTitleServerDateTime;
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFinanceiro.NewSQLMonitorFile: string;
var
AFileName: string;
GUID: TGUID;
begin
//Gera um novo arquivo para ser usado pelo sqlmonitor
 Result := '';
{Obtém a pasta onde serão armazenados arquivos de monitoração das transações
 com o servidor SQL.}
 AFileName := TCosmosInfoFiles.GetDatabaseMonitorFolder;

 if not DirectoryExists(AFileName) then
  CreateDir(AFileName);

 CreateGUID(GUID);
 Result := AFileName + '\gfin_' + GUIDToString(GUID) + '.txt';
end;

procedure TFinanceiro.ReadChipherKey(var Key: string);
var
AFile: TIniFilePersistence;
begin
{Lê a chave criptográfica. Esta chave será usada para criptografar e descriptografar
dados, tanto na aplicação servidora como na cliente. A aplicação cliente lê a
chave gerada por esta rotina através da propriedade CodeKey,
exposta pela TypeLibrary.}
 AFile := TIniFilePersistence.Create('cosmos_adm.ini', True);

 try
  Key := AFile.ReadString('Criptografia', 'Key', '');

 finally
  if Assigned(AFile) then
   FreeAndNil(AFile);
 end;
end;

procedure TFinanceiro.RemoteDataModuleCreate(Sender: TObject);
var
AXMLFile: string;
begin
 FConnectedUser := TCosmosUser.Create;
 //Obtém a pasta onde o servidor está instalado.
 FCosmosFolder := TCosmosApplication.GetModulePath;

 //Cria e configura o objeto manipulador de logs.
 if not Assigned(FLog) then
  begin
   FLog := TWinServiceLog.Create;
   ConfigureLogSystem;
  end;

 ConfigureDatabaseMonitor;

 //Pega a interface com o arquivo de configuração de dados dos campos de dados.
 AXMLFile := self.FCosmosFolder + 'FieldsInfo.xml'; //do not localize!

 try
  AFieldsInfoReader := TFieldsInfoReader.Create(AXMLFile);

 except
  on E: Exception do
   begin
    self.Log.RegisterError(E.Message);
   end;
 end;
end;

procedure TFinanceiro.RemoteDataModuleDestroy(Sender: TObject);
begin
 if Assigned(FrmMain) then
  FrmMain.UnregisterConnection(FConnectionID);
end;

procedure TFinanceiro.BufferData(const SchemmaName: WideString;
  out DataPackage: OleVariant);
var
TD: TDBXTransaction;
AServer: TSQLServerTransactionsManager;
begin
//Bufferiza um pacote de dados no formato olevariant que é envidao para o cliente.
 AServer := TSQLServerTransactionsManager.Create;

 try
  TD := AServer.BeginTransaction(SQLCon);
  SQLSearch.CommandText := Format(sSQLBufferSchemma, [SchemmaName]);
  DataPackage := DspSearch.Data;

 finally
  AServer.CommitTransaction(SQLCon, TD);
  if Assigned(AServer) then
   FreeAndNil(AServer);
 end;
end;

function TFinanceiro.ConnectDatabase(const UserName, Password, RoleName,
  HostName: WideString): OleVariant;
var
FAditionalInfo: TStringList;
AUserManager: TCosmosUsersManager;
AUserData : TCosmosData;
sUserName: string;
vUserStatus: TUserStatus;
AReturn: TServerReturn;
begin
{Este método remoto permite que uma aplicação cliente execute a validação de usuário no
 servidor Firebird. São registradas eventos de log para o sucesso ou erro gerados durante a
 execução deste método.}

 //Cria a classe que retornará dados do método para a aplicação cliente. A Classe
 //recebe valores padrão.
 AReturn := self.CreateMessageData;
 AReturn.SetMessageInfo(miInstallationID, self.ActiveRange);
 AReturn.ServerData := null;

 //Primeiro, checa se o servidor aceita novas conexões.
 try
  if Assigned(FrmMain) then
   begin
    if FrmMain.CManager.Locked then
     raise ELockedServerError.Create(sLogLockedServer);
    end;

  //Descriptografa o login do usuário. Esse dado será usado em seguida.
  sUserName := TDataTransformation.Descriptografar(UserName);
  AReturn.SetMessageInfo(miUserName, sUserName);
  AReturn.SetMessageInfo(miRoleName, RoleName);

  //Agora, verifica o status do usuário...
  vUserStatus :=  self.GetUserStatus(sUserName);

  case vUserStatus of
   usCosmosUser:
    begin
     AReturn.Code := 0;//Usuário registrado do Cosmos.
     AReturn.MessageType := mtpSucess;
     AReturn.MessageText := sSucessfullLogin;
     AReturn.MessageTitle := sTitleAutentication;
     Result := AReturn.ServerReturn;
    end;
   usBlockedUser://É um usuário registrado, porém está bloqueado.
    begin
     AReturn.Code := 3;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sBlockedUser;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     Result := AReturn.ServerReturn;
     Exit;
    end;
   usSysdba://O usuário é o administrador do SGBD. No Gestor de Secretarias ele não pode trabalhar..
    begin
     AReturn.Code := 4;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sSysdbaLoginFailure;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     Result := AReturn.ServerReturn;
     Exit;
    end;
   usUnknown://O sistema não pode determinar o status do usuário.
    begin
     AReturn.Code := 5;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := Format(sUnknowUser, ['"'+ sUserName + '"']);
     AReturn.MessageTitle := sTitleInvalidAutentication;
     Result := AReturn.ServerReturn;
     Exit;
    end;
  end;

  if RoleName <> '' then
    FConnectionRole := RoleName;

 //Se chegou aqui, o processo de login vai começar...
  SetConnectionParams; //Configura o objeto de conexão.

  //Conecta com o usuário interno...
  SqlCon.Open;
  if SqlCon.Connected then
   AReturn.Code := 0;


   //Checa se uma conexão pode ser feita. Se o banco estiver esm estado de
   //sincronização, a conexão deverá ser desfeita.
  {*** if IsSyncronizing then
    raise ELockedDatabaseError.Create(sSyncProcessing); ***}

   //Se o login foi feito com sucesso, checa quem é o aluno usuário
   if AReturn.Code = 0 then
    begin
     AUserManager := TCosmosUsersManager.Create;
     AUserData := TCosmosData.Create(20);
     {Atribui os privilégios do perfil do aluno que efetuou o login. A senha é
     ´passada criptografada mesmo.}

     AUserManager.GetUserInfo(TDataTransformation.Descriptografar(UserName), Password, RoleName, AUserData);
    // SetUserInfo(Descriptografar(UserName), Password, RoleName, AUserData);
     AUserData.WriteValue('GROUP', RoleName, 14);

     //Agora, checa se o aluno está ligado ou é um ex-aluno
     if AUserData.FindValue('ATIVO') = False then
      begin
       CreateLog(Format(sInvalidUser, [AUserData.FindValue('USER_NAME')]),EVENTLOG_AUDIT_FAILURE);
       raise EValidateUser.Create(Format(sInvalidUser, [AUserData.FindValue('USER_NAME')]));
      end;

     if (AUserData.FindValue('USER_NAME') = '') then
      raise EUnknownUser.Create(sErroUnknownUser);

    //Agora, verifica se o usuário pode acessar o módulo corrente do Cosmos.
    if not TCosmosMethods.CanAccessModule(AUserData.FindValue('CODUSU'), CurrentCosmosModule) then
     raise ECantAcessCosmosModule.Create(sErroCantAcessCosmosModuel);

    //Finalmente, usuário está autenticado: registra-o e escreve um log do evento
     if AUserData.FindValue('USER_NAME') <> '' then
      begin
       FAditionalInfo := TStringList.Create;
       FAditionalInfo.Add('USER_NAME=' + AUserData.FindValue('USER_NAME'));
       FAditionalInfo.Add('MATRICULA=' + AUserData.FindValue('MATRICULA'));
       FAditionalInfo.Add('FOCO=' + AUserData.FindValue('FOCO'));
       FAditionalInfo.Add('DISCIPULADO=' + AUserData.FindValue('DISCIPULADO'));
       FConnectionID := FrmMain.RegisterConnection(AUserData.FindValue('USER_NAME'), RoleName, HostName,
        FAditionalInfo.CommaText);

       AUserData.WriteValue('CONNECTION_TIME', Now, 15);
       AUserData.WriteValue('CONNECTION_ID', GUIDToString(FConnectionID), 16);
       AUserData.WriteValue('CONNECTION_STATUS', 0, 17);

       AReturn.ServerData := AUserData.XMLData;
       Result := AReturn.ServerReturn;
       CreateLog(Format(sLogCorrectLogin, [AUserData.FindValue('USER_NAME'), RoleName]),EVENTLOG_AUDIT_SUCCESS);
      end;

     FConnectedUser.LoadInfo(AUserData);
    end;

  except
   on E: ELockedDatabaseError do //Banco de dados está bloqueado pela sincronização.
    begin
     SQLCon.Close;
     AReturn.Code := 6;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := E.Message;
     AReturn.MessageTitle := sTitleCanceledAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: EDatabaseError do //Erro ocorrido durante tentativa de login
    begin
     AReturn.Code := 7;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := Format(sLogIncorrectLogin, [sUserName, E.Message]);
     AReturn.MessageTitle := sTitleCanceledAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(Format(sLogIncorrectLogin, [sUserName, E.Message]),EVENTLOG_AUDIT_FAILURE);
    end;
   on E: EIncorrectRoleAcess do //Usuário não é da role passada
    begin
     AReturn.Code := 8;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := Format(sLogIcorrectRole, [sUserName, RoleName]);
     AReturn.MessageTitle := sTitleInvalidAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(Format(sLogIcorrectRole, [sUserName, RoleName]),EVENTLOG_AUDIT_FAILURE);
    end;
   on E: ELockedServerError do //Servidor está indisponível para novas conexões
    begin
     AReturn.Code := 9;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sLogLockedServer;
     AReturn.MessageTitle := sTitleCanceledAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(sLogLockedServer,EVENTLOG_AUDIT_FAILURE);
    end;
   on E: ECosmosSystemFailure do //Falha de sistema genérica...
    begin
     AReturn.Code := 10;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := E.Message;
     AReturn.MessageTitle := sTitleErrorAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message,EVENTLOG_ERROR_TYPE);
    end;
   on E: EValidateUser do //Dados fornecidos pelo usuário estão incorretos...
    begin
     AReturn.Code := 11;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sLoginFailure;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: EUnknownUser do //Não encontrou o usuário na tabela de usuários...
    begin
     AReturn.Code := 12;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sLoginFailure;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: ECantAcessCosmosModule do //Usuário não pdoe acessar o módulo do Cosmos.
    begin
     AReturn.Code := 13;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := E.Message;
     AReturn.MessageTitle := sTitlePermissoes;
     AReturn.SetMessageInfo(miInnerMessage, E.Message + ' : ' + sUserName);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message + ' : ' + sUserName, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: TDBXError do //Falha de sistema relacionada a banco de dados...
    begin
      if Pos('password', E.Message) > 0 then //Login ou senha inválidos.
       begin
        AReturn.Code := 14;
        AReturn.MessageType := mtpError;
        AReturn.MessageText := sLoginFailure;
        AReturn.MessageTitle := sTitleInvalidAutentication;
        AReturn.SetMessageInfo(miInnerMessage, E.Message);
        Result := AReturn.ServerReturn;
        CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
       end
      else
       begin
        AReturn.Code := 15; //Erro desconhecido...
        AReturn.MessageType := mtpError;
        AReturn.MessageText := sErrorCosmosSystem;
        AReturn.MessageTitle := sTitleErrorAutentication;
        AReturn.SetMessageInfo(miInnerMessage, E.Message);
        Result := AReturn.ServerReturn;
        CreateLog(E.Message,EVENTLOG_ERROR_TYPE);
       end;
    end;
  end;
end;

function TFinanceiro.GetPerfilData: OleVariant;
var
AReturn: TServerReturn;
AData: TCosmosData;
begin
//Este método retorna o perfil do usuário logado
 AReturn := TServerReturn.Create;
 AData := TCosmosData.Create(2);

 try
  if SQLCon.Connected then
   begin
    AData.WriteValue('USER_NAME', SQLCon.Params.Values['User_Name']);
    AData.WriteValue('ROLE', SQLCon.Params.Values['Role'], 1);
    AReturn.ServerData := AData.Data;
    Result := AReturn.ServerReturn;
   end;

 finally
  if Assigned(AData) then
   AData.Free;
  if Assigned(AReturn) then
   AReturn.Free;
 end;
end;

function TFinanceiro.IsAdministrator(const UserName: WideString): OleVariant;
var
AReturn: TServerReturn;
AUserManager: TCosmosUsersManager;
begin
//Checa se um usuário é um administrador do sistema.
 AUserManager := TCosmosUsersManager.Create;
 AReturn := self.CreateMessageData;

 try
  AReturn.ServerData := AUserManager.IsAdministrator(UserName);
  Result := AReturn.ServerReturn;

 finally
  if Assigned(AUserManager) then AUserManager.Free;
  if Assigned(AReturn) then AReturn.Free;
 end;
end;

function TFinanceiro.ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant;
var
AReturn: TServerReturn;
ACosmosSearch: TCosmosSearch;
ACommand: string;
begin
//Executa uma pesquisa padrão do Cosmos.
 ACosmosSearch :=  TSQLServerInterface.GetCosmosSearch(SearchID);
 ACommand := TSQLCommandsFactory.GetSQLCommand(ACosmosSearch);
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);

 AReturn := self.CreateMessageData;

 try
  //Executa o comando DQL...
  self.DoExecuteDQL(ACommand);
  AReturn.ServerData := DspSearch.Data;

  AReturn.MessageType := mtpSucess;
  Result := AReturn.ServerReturn;

  CloseDataset(SQLSearch);

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleErrorSelectData;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    CloseDataset(SQLSearch);
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFinanceiro.GetAcessedFocus(const UserName: WideString): OleVariant;
var
AReturn: TServerReturn;
ADataset: TClientDataset;
begin
//Retorna os focos que o usuário passado em parâmetro pode acessar
 AReturn := self.CreateMessageData;
 ADataset := TClientDataset.Create(nil);

 try
  ADataset.Data := TCosmosMethods.GetAcessedFocus(UserName, cmFinanceiro);

  case ADataset.RecordCount of
   0:  //Nenhum foco pode ser acessado pelo usuário
     begin
      AReturn.Code := 0;
      AReturn.MessageType := mtpInformation;
      AReturn.MessageTitle := sTitleOpenFocus;
      AReturn.MessageText := sInfoNoFocusAcess;
     end;
   1:   //Apenas um foco pode ser acessado pelo usuário
     begin
      AReturn.Code := 1;
      AReturn.ServerData := ADataset.Data;
     end
   else //Mais de um foco pode ser acessado pelo usuário
     begin
      AReturn.Code := 2;
      AReturn.ServerData := ADataset.Data;
     end;
  end;


  Result := AReturn.ServerReturn;
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AReturn) then FreeAndNil(AReturn);

 except
  on E: Exception do
   begin
    CloseDataset(SQLSearch);
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorOpenFocus;
    AReturn.MessageTitle := sTitleOpenFocus;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(AReturn) then FreeAndNil(AReturn);

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFinanceiro.GetContas: OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
begin
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(sSQLRootContas, ADataset);
  Result := ADataset.Data;

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TFinanceiro.GetCurrentCosmosModule: TCosmosModules;
begin
 Result := cmFinanceiro;
end;

function TFinanceiro.GetSubcontas(codcon: Integer): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
begin
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(sSQLSubContas, [codcon]), ADataset);
  Result := ADataset.Data;

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TFinanceiro.GetSequenceValue(
  const SequenceName: WideString): OleVariant;
var
TD: TDBXTransaction;
ASQLServer: TSQLServerTransactionsManager;
AReturn: TServerReturn;
begin
 //Obtém o valor atual de uma sequence a partir do nome da sequence e da faixa
 //de chaves primárias.
 CloseDataset(SQLSearch);
 AReturn := self.CreateMessageData;
 ASQLServer := TSQLServerTransactionsManager.Create;

 try
  TD := ASQLServer.BeginTransaction(SQLCon, TDBXIsolations.ReadCommitted);
  DoExecuteDQL(Format(sSQLGenerators, [SequenceName, 1]));

  AReturn.Code := 0;
  AReturn.ServerData := SQLSearch.Fields.Fields[0].Value + ActiveRange;
  Result := AReturn.ServerReturn;

  CloseDataset(SQLSearch);
  ASQLServer.CommitTransaction(SQLCon, TD);

  if Assigned(AReturn) then
   AReturn.Free;

  if Assigned(ASQLServer) then
   ASQLServer.Free;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectSequenceData;
    AReturn.MessageTitle := sTitleErrorSelectData;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    CloseDataset(SQLSearch);
    ASQLServer.RollbackTransaction(SQLCon, TD);

    if Assigned(AReturn) then AReturn.Free;
    if Assigned(ASQLServer) then ASQLServer.Free;

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

procedure TFinanceiro.DoCreateUpdateDataError(E: Exception);
var
AReturn: TServerReturn;
begin
{Trata a resposta, para as aplicações clientes, de exceções de violação de chaves
 primárias ou chaves estrangeiras.}
 AReturn := self.CreateMessageData;

 try
  AReturn.MessageTitle := sTitleUpdateData;
  AReturn.MessageText := sErrorUpdateData;
  AReturn.MessageType := mtpError;
  AReturn.CosmosModule := cmFinanceiroServer;
  AReturn.SetMessageInfo(miInnerMessage, E.Message);
  self.FLastUpdateError := AReturn.ServerReturn;
  //A aplicação cliente deve chamar o método GetLastUpdateError para recuperar
  //este erro.

  self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);

 finally
  if Assigned(AReturn) then
   FreeAndNil(AReturn);
 end;
end;

function TFinanceiro.DoExecuteCommand(const Command: WideString): integer;
var
 ACommand: TSQLServerCommand;
begin
 //Executa um comando e retorna o número de linhas afetadas.
 ACommand := TSQLServerCommand.Create;

 try
  Result := ACommand.ExecuteCommand(Command);

 except
  if Assigned(ACommand) then
   FreeAndNil(ACommand);
  raise;
 end;
end;

procedure TFinanceiro.DoExecuteDQL(const DQL: WideString);
var
 ACommand: TSQLServerCommand;
begin
//Executa um comando DQL
 CloseDataset(SQLSearch);
 ACommand := TSQLServerCommand.Create;

 try
  ACommand.ExecuteDQL(DQL, SQLSearch);
  if Assigned(ACommand) then
   FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    CreateLog(E.Message +  Format(sErrorSQLCommand, [DQL]), EVENTLOG_ERROR_TYPE);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise;
   end;
 end;
end;

function TFinanceiro.DoExecuteScript(var AScript: TStringList): boolean;
var
ACommand: TDbxSQLScript;
begin
{Executa um script com diversos comandos sql de forma atômica. Caso ocorra
alguma falha, toda a operação será desfeita.}
 Result := False;
 if not Assigned(AScript) then
  Exit;

 ACommand := TDbxSQLScript.Create(nil);
 ACommand.SQLConnection := self.SQLCon;
 ACommand.SQL.Assign(AScript);
 ACommand.CommitEach := False;
 ACommand.SQLProc := False;

 try
  Result := ACommand.ExecuteDirect = 0;

 except
  on E: Exception do
   begin
   {A checagem abaixo evita que outros erros não tenham permitido o início da
    transação. p. exe: queda ou travamento do servidor sql}
    Result := False;
    CreateLog(E.Message + #13 + '----Script----' + #13 + AScript.Text,EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;
end;

function TFinanceiro.MoverConta(Conta, Parent: Integer): OleVariant;
var
AReturn: TServerReturn;
ACommand: TSQLServerCommand;
begin
//Altera a relação de dependência de uma conta para com outra.
 AReturn := self.CreateMessageData;
 ACommand := TSQLServerCommand.Create;

 try
  AReturn.Code := 0;
  ACommand.ExecuteCommand(Format(sMoveConta, [Parent, Conta]));
  AReturn.ServerData := True;
  Result := AReturn.ServerReturn;

  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(AReturn) then FreeAndNil(AReturn);


 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorMoveConta;
    AReturn.MessageTitle := sTitlePlanoContas;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    AReturn.ServerData := False;
    Result := AReturn.ServerReturn;

    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(AReturn) then FreeAndNil(AReturn);

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFinanceiro.ExcluirConta(Conta: Integer): OleVariant;
var
AReturn: TServerReturn;
AConnection: TSQLConnection;
ACommand: TSQLServerCommand;
ADataset: TSQLDataset;
begin
//Exclui uma conta do plano de conta, se possível.
 AReturn := self.CreateMessageData;
 ACommand := TSQLServerCommand.Create;
 AConnection := ACommand.CreateConnection;
 ADataset := ACommand.CreateDataset(AConnection);

 try
  ACommand.ExecuteDQL(Format(sSQLDeleteConta, [Conta]), ADataset);
  AReturn.Code := ADataset.Fields.Fields[0].AsInteger;

  case AReturn.Code of
   0:  //Deleção feita com sucesso.
    begin
     AReturn.MessageType := mtpInformation;
     AReturn.MessageTitle := sTitlePlanoContas;
     AReturn.MessageText := sInfoDelecaoPlanoConta;
    end;
   1: //Deleção cancelada: existem subcontas vinculadas à conta.
    begin
     AReturn.MessageType := mtpError;
     AReturn.MessageTitle := sTitlePlanoContas;
     AReturn.MessageText := sErrorDeleteContaSubcontas;
    end;
   2://Deleção cancelada: conta encontra-se em uso.
    begin
     AReturn.MessageType := mtpError;
     AReturn.MessageTitle := sTitlePlanoContas;
     AReturn.MessageText := sErrorDeleteContasUsadas;
    end
   else //Deleção cancelada: erro desconhecido.
    begin
     AReturn.MessageType := mtpError;
     AReturn.MessageTitle := sTitlePlanoContas;
     AReturn.MessageText := sErrorDeleteConta;
    end
  end;

  Result := AReturn.ServerReturn;

  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AConnection) then FreeAndNil(AConnection);
  if Assigned(AReturn) then AReturn.Free;

 except
  on E: Exception do
   begin
    self.CloseDataset(SQLSearch);
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorDeleteConta;
    AReturn.MessageTitle := sTitlePlanoContas;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(AConnection) then FreeAndNil(AConnection);


    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;


end;

function TFinanceiro.GetTableProviderName(Table: Integer): OleVariant;
var
AReturn: TServerReturn;
begin
//Retorna o nome de um TDatasetProvider que retorna os dados de uma tabela acessória.
 AReturn := self.CreateMessageData;

 try
  case TCosmosTables(Table) of
   ctAptidoes: AReturn.ServerData := 'DspAptidoes';
   ctCargos: AReturn.ServerData := 'DspCargos';
   ctEnfermidades: AReturn.ServerData := 'DspEnfermidades';
   ctFuncoes: AReturn.ServerData := 'DspFuncoes';
   ctMeiosContatos: AReturn.ServerData := 'DspMeiosContato';
   ctProfissoes: AReturn.ServerData := 'DspProfissoes';
   ctTiposRecebimentos: AReturn.ServerData := 'DspTiposRecebimentos';
  end;

 finally
  Result := AReturn.ServerReturn;
  if Assigned(AReturn) then
   AReturn.Free;
 end;
end;

function TFinanceiro.GetUserStatus(const UserName: string): TUserStatus;
var
 UserManager: TCosmosUsersManager;
begin
//Verifica o status do usuário...
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.GetUserStatus(UserName);

  if Assigned(UserManager) then
   FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
    Result := usUnknown;
    if Assigned(UserManager) then
     FreeAndNil(UserManager);

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFinanceiro.Get_ActiveRange: OleVariant;
var
AReturn: TServerReturn;
begin
 AReturn := self.CreateMessageData;

 try
  AReturn.Code := 0;
  AReturn.ServerData := self.FActiveRange;
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleSincronizador;
    AReturn.SetMessageInfo(miInstallationID, self.FActiveRange);
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;

end;

initialization
  TComponentFactory.Create(ComServer, TFinanceiro,
    Class_Financeiro, ciMultiInstance, tmApartment);
end.
