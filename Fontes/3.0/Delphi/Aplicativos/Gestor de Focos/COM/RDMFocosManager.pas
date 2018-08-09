unit RDMFocosManager;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, focser_TLB, StdVcl, DB, SqlExpr, FMTBcd, SQLScript,
  Provider, ActiveX, cosmos.core.classes, Variants, ServerConnections,
  cosmos.framework.interfaces.utils, cosmos.logs.winservice, cosmos.core.arrayutils,
  cosmos.core.security, WideStrings, DBXFirebird, dbxCommon, cosmos.core.server.dataobjects,
  cosmos.core.classes.FieldsInfo, cosmos.core.server.cosmosobj, cosmos.core.server.security,
  cosmos.core.SQLServerInterface, cosmos.persistence.ini, cosmos.core.server.utils;

type
  //Classe de exceção usada na validação do login do usuário
  EDllError = Exception;
  EValidateUser = Exception;
  EDatabaseConnectError = Exception;
  EFocusDuplicated = Exception;
  EDeleteError = Exception;
  EInvalidRoleAcess = Exception;
  EIncorrectRoleAcess = Exception;
  ELockedServerError = Exception;
  ELockedUserError = Exception;
  EUnknownUser = Exception;
  ESyncronizingStatus = Exception;  

  TUserInfo = record
   logusu: string;
   nomusu: string;
   sigfoc: string;
  end;

  TFocosManager = class(TRemoteDataModule, IFocosManager)
    SQLCon: TSQLConnection;
    SQLSearch: TSQLDataSet;
    DspSearch: TDataSetProvider;
    SQLMonitor: TSQLMonitor;
    SQLFoco: TSQLDataSet;
    SQLFocoCODFOC: TIntegerField;
    SQLFocoNOMFOC: TStringField;
    SQLFocoSIGFOC: TStringField;
    SQLFocoNOMTEM: TStringField;
    SQLFocoTIPFOC: TStringField;
    SQLFocoCODREG: TIntegerField;
    SQLFocoNOMREG: TStringField;
    SQLFocoFOCPAI: TIntegerField;
    SQLFoconompai: TStringField;
    SQLFocoINDLEC: TStringField;
    SQLFocoINDTPU: TStringField;
    SQLFocoINDTMO: TStringField;
    SQLFocoINDTMB: TStringField;
    SQLFocoINDIND: TStringField;
    SQLFocoINDATI: TStringField;
    SQLFocoINDNAC: TStringField;
    SQLFocoINDCAB: TStringField;
    DspFoco: TDataSetProvider;
    SQLMeiosContatosFocos: TSQLDataSet;
    SQLMeiosContatosFocosCODCON: TIntegerField;
    SQLMeiosContatosFocosCODTIPCON: TIntegerField;
    SQLMeiosContatosFocosDESTIPCON: TStringField;
    SQLMeiosContatosFocosDESCON: TStringField;
    SQLMeiosContatosFocosCODFOC: TIntegerField;
    SQLMeiosContatosFocosINDCAR: TStringField;
    SQLMeiosContatosFocosDATCAD: TSQLTimeStampField;
    SQLMeiosContatosFocosUSURES: TStringField;
    DspMeiosContatos: TDataSetProvider;
    SQLSearchLogradouros: TSQLDataSet;
    SQLSearchLogradourosCODLOG: TIntegerField;
    SQLSearchLogradourosNOMLOG: TStringField;
    SQLSearchLogradourosCEPLOG: TStringField;
    SQLSearchLogradourosCODBAI: TIntegerField;
    SQLSearchLogradourosNOMBAI: TStringField;
    SQLSearchLogradourosCODCID: TIntegerField;
    SQLSearchLogradourosNOMCID: TStringField;
    SQLSearchLogradourosNOMEST: TStringField;
    SQLSearchLogradourosSIGEST: TStringField;
    SQLSearchLogradourosNOMPAI: TStringField;
    DspSearchLogradouros: TDataSetProvider;
    SQLEnderecoFoco: TSQLDataSet;
    SQLEnderecoFocoCODEND: TIntegerField;
    SQLEnderecoFocoCODLOG: TIntegerField;
    SQLEnderecoFocoNOMLOG: TStringField;
    SQLEnderecoFocoNUMEND: TIntegerField;
    SQLEnderecoFocoCOMEND: TStringField;
    SQLEnderecoFocoCEPLOG: TStringField;
    SQLEnderecoFocoCODBAI: TIntegerField;
    SQLEnderecoFocoNOMBAI: TStringField;
    SQLEnderecoFocoCODCID: TIntegerField;
    SQLEnderecoFocoNOMCID: TStringField;
    SQLEnderecoFocoNOMEST: TStringField;
    SQLEnderecoFocoSIGEST: TStringField;
    SQLEnderecoFocoNOMPAI: TStringField;
    SQLEnderecoFocoINDCOR: TStringField;
    SQLEnderecoFocoREFEND: TStringField;
    SQLEnderecoFocoACEEND: TStringField;
    SQLEnderecoFocoCODFOC: TIntegerField;
    SQLEnderecoFocoNUMCAI: TSmallintField;
    SQLEnderecoFocoDATCAD: TSQLTimeStampField;
    SQLEnderecoFocoUSURES: TStringField;
    DspEndereco: TDataSetProvider;
    SQLLogradouros: TSQLDataSet;
    SQLLogradourosCODLOG: TIntegerField;
    SQLLOgradourosNOMLOG: TStringField;
    SQLLogradourosCEPLOG: TStringField;
    SQLLogradourosCODBAI: TIntegerField;
    SQLLogradourosNOMBAI: TStringField;
    SQLLogradourosCODCID: TIntegerField;
    SQLLogradourosNOMCID: TStringField;
    SQLLogradourosNOMEST: TStringField;
    SQLLogradourosSIGEST: TStringField;
    SQLLogradourosNOMPAI: TStringField;
    DspLogradouros: TDataSetProvider;
    SQLPaises: TSQLDataSet;
    SQLPaisesCODPAI: TIntegerField;
    SQLPaisesNOMPAI: TStringField;
    DspPaises: TDataSetProvider;
    SQLEstados: TSQLDataSet;
    SQLEstadosCODEST: TIntegerField;
    SQLEstadosCODPAI: TIntegerField;
    SQLEstadosNOMPAI: TStringField;
    SQLEstadosNOMEST: TStringField;
    SQLEstadosSIGEST: TStringField;
    DspEstados: TDataSetProvider;
    SQLMentores: TSQLDataSet;
    SQLMentoresCODMEN: TIntegerField;
    SQLMentoresCODREG: TIntegerField;
    SQLMentoresNOMREG: TStringField;
    SQLMentoresCODCAD: TIntegerField;
    SQLMentoresNOMCAD: TStringField;
    SQLMentoresMATCAD: TStringField;
    SQLMentoresSIGDIS: TStringField;
    SQLMentoresSIGFOC: TStringField;
    DspMentores: TDataSetProvider;
    SQLCidades: TSQLDataSet;
    SQLCidadesCODCID: TIntegerField;
    SQLCidadesNOMCID: TStringField;
    SQLCidadesCODEST: TIntegerField;
    DspCidades: TDataSetProvider;
    SQLBairros: TSQLDataSet;
    SQLBairrosCODBAI: TIntegerField;
    SQLBairrosNOMBAI: TStringField;
    SQLBairrosCODCID: TIntegerField;
    SQLBairrosNOMCID: TStringField;
    SQLBairrosCODEST: TIntegerField;
    SQLBairrosNOMEST: TStringField;
    SQLBairrosSIGEST: TStringField;
    SQLBairrosCODPAI: TIntegerField;
    SQLBairrosNOMPAI: TStringField;
    DspBairros: TDataSetProvider;
    SQLCargos: TSQLDataSet;
    SQLCargosCODCAR: TIntegerField;
    SQLCargosDESCAR: TStringField;
    DspCargos: TDataSetProvider;
    SQLTiposContatos: TSQLDataSet;
    SQLTiposContatosCODTIPCON: TIntegerField;
    SQLTiposContatosDESTIPCON: TStringField;
    DspTiposContatos: TDataSetProvider;
    SQLReports: TSQLDataSet;
    DspReports: TDataSetProvider;
    SQLCommand: TSQLDataSet;
    SQLStoredProc: TSQLStoredProc;
    SQLOrgaos: TSQLDataSet;
    SQLOrgaosCODORG: TIntegerField;
    SQLOrgaosNOMORG: TStringField;
    SQLOrgaosNOMORGING: TStringField;
    SQLOrgaosSIGORG: TStringField;
    SQLOrgaosCODPAI: TIntegerField;
    SQLOrgaosORGSUP: TStringField;
    SQLOrgaosMANORG: TSmallintField;
    SQLOrgaosROLORG: TStringField;
    SQLOrgaosNIVORG: TSmallintField;
    SQLOrgaosCODFOC: TIntegerField;
    SQLOrgaosNOMFOC: TStringField;
    SQLOrgaosSIGFOC: TStringField;
    SQLOrgaosINDLEC: TStringField;
    SQLOrgaosINDTMO: TStringField;
    SQLOrgaosINDTMB: TStringField;
    SQLOrgaosINDTPU: TStringField;
    SQLOrgaosINDATA: TStringField;
    SQLOrgaosINDATI: TStringField;
    SQLOrgaosINDNAC: TStringField;
    SQLOrgaosUSURES: TStringField;
    SQLOrgaosDATCAD: TSQLTimeStampField;
    DspOrgaos: TDataSetProvider;
    SQLGestoes: TSQLDataSet;
    SQLGestoesCODGES: TIntegerField;
    SQLGestoesCODORG: TIntegerField;
    SQLGestoesNOMORG: TStringField;
    SQLGestoesDATINI: TDateField;
    SQLGestoesDATTER: TDateField;
    SQLGestoesDATCAD: TSQLTimeStampField;
    SQLGestoesUSURES: TStringField;
    DspGestoes: TDataSetProvider;
    SQLDirecoes: TSQLDataSet;
    SQLDirecoesCODDIR: TIntegerField;
    SQLDirecoesCODGES: TIntegerField;
    SQLDirecoesCODCAD: TIntegerField;
    SQLDirecoesCODFOC: TIntegerField;
    SQLDirecoesCODDIS: TIntegerField;
    SQLDirecoesNOMCAD: TStringField;
    SQLDirecoesSIGDIS: TStringField;
    SQLDirecoesNOMFOC: TStringField;
    SQLDirecoesCODCAR: TIntegerField;
    SQLDirecoesDESCAR: TStringField;
    SQLDirecoesDATINI: TDateField;
    SQLDirecoesDATTER: TDateField;
    SQLDirecoesINDCON: TStringField;
    SQLDirecoesOBSDIR: TMemoField;
    SQLDirecoesDATCAD: TSQLTimeStampField;
    SQLDirecoesUSURES: TStringField;
    DspDirecoes: TDataSetProvider;
    SQLDirigentesGestao: TSQLDataSet;
    DspDirigentesGestao: TDataSetProvider;
    SQLFicha: TSQLDataSet;
    DspFicha: TDataSetProvider;
    SQLDirigentesAtuais: TSQLDataSet;
    DspDirigentesAtuais: TDataSetProvider;
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
    SQLPerfilINDADM: TStringField;
    DspPerfil: TDataSetProvider;
    SQLFocoINDEIN: TStringField;
    SQLFuncoes: TSQLDataSet;
    SQLFuncoesCODFUN: TIntegerField;
    SQLFuncoesDESFUN: TStringField;
    DspFuncoes: TDataSetProvider;
    procedure DspPerfilGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure SQLConAfterConnect(Sender: TObject);
    procedure DspOrgaosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspLogradourosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspBairrosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspMentoresGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspEnderecoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspPaisesBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure DspFocoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure RemoteDataModuleDestroy(Sender: TObject);
    procedure RemoteDataModuleCreate(Sender: TObject);
    procedure DspMentoresGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspCargosGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspFuncoesGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure SQLSearchAfterOpen(DataSet: TDataSet);
    procedure DspSearchUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
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
    procedure ConfigureLogSystem;
    procedure CreateLog(const Message: string; MsgType: Cardinal); inline;
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
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant; safecall;
    function GetPerfilData: OleVariant; safecall;
    function Get_BetaVersion: WordBool; safecall;
    function Get_DatabaseVersion: OleVariant; safecall;
    procedure FichaCadastrado(codcad: Integer; out CoreData, FuncoesData,
      ContatosData: OleVariant); safecall;
    function DuplicarGestao(codorg, codges: Integer; datini, datter: TDateTime;
      Dirigentes: OleVariant): OleVariant; safecall;
    function DeleteDirigente(coddir: Integer): OleVariant; safecall;
    function MoveDirigente(coddir, codges: Integer): OleVariant; safecall;
    function TerminateMandate(coddir: Integer): OleVariant; safecall;
    function TerminateMandates(codges: Integer): OleVariant; safecall;
    function CloneDirigente(coddir, codges: Integer): OleVariant; safecall;
    function ListMembrosGestao(codges: Integer): OleVariant; safecall;
    function DeleteGestao(codges: Integer): OleVariant; safecall;
    function DeleteOrgao(codorg: Integer): OleVariant; safecall;
    function ListGestoesOrgao(codorg: Integer): OleVariant; safecall;
    function ListOrgaosByEsfera(indnac, indati: WordBool): OleVariant; safecall;
    function ListOrgaosByName(codsup: OleVariant): OleVariant; safecall;
    function AlterarSubordinacao(codorg, NewParent: Integer): OleVariant; safecall;
    function ListOrgaos(codsup: OleVariant): OleVariant; safecall;

    procedure BufferData(const SchemmaName: WideString;
      out DataPackage: OleVariant); safecall;
    function DeleteFocus(codfoc: Integer): OleVariant; safecall;
    function DesactiveFocus(TargetFocus, TransferFocus: Integer;
      Desactivate: WordBool): OleVariant; safecall;
    function GetFocusData(indsed, indcco, indncc, indnuc, indstp, indltp, indnac,
      inativos: WordBool): OleVariant; safecall;
    function GetLogradouro(const Cep: WideString): OleVariant; safecall;
    function CriarFoco(DadosFoco, DadosEndereco, DadosGestao,
      DadosMeiosContatos: OleVariant): OleVariant; safecall;
    function ChangeFocusStatus(FocusID: Integer; Status: WordBool): OleVariant;
      safecall;
    function Get_ServerDateTime: OleVariant; safecall;
    function ListDependentsFocus(TitularFocus: Integer;
      Inactives: WordBool): OleVariant; safecall;
    function ListFocusByTitular(Inactives: WordBool): OleVariant; safecall;
    function ChangeFocusParent(FocusID, NewParent: Integer): OleVariant; safecall;
    function ChangeFocusRegion(FocusID, NewRegion: Integer): OleVariant; safecall;
    function DeleteRegion(RegionID: Integer): OleVariant; safecall;
    function ListFocusRegion(RegionID: Integer; Inactives,
      OnlyTop: WordBool): OleVariant; safecall;
    function MoveRegion(RegionID, NewRegion: Integer): OleVariant; safecall;
    function NewAR(const ARName: WideString; ARParent: OleVariant): OleVariant;
      safecall;
    function ListFocusByType(Inactives: WordBool): OleVariant; safecall;
    function ListFocusSequencial(Inactives: WordBool): OleVariant; safecall;
    function Get_ServerComputer: OleVariant; safecall;
    function Get_StartTime: OleVariant; safecall;
    function ListRegions(codreg: Integer): OleVariant; safecall;
    function RenameAr(codreg: Integer; const NewName: WideString): OleVariant;
      safecall;
    function Get_ActiveUser: OleVariant; safecall;
    function GetSequenceValue(const SequenceName: WideString): OleVariant; safecall;

    function ConnectDatabase(const UserName, Password, RoleName,
      HostName: WideString): OleVariant; safecall;
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_ActiveRange: OleVariant; safecall;
    function Get_CodeKey: OleVariant; safecall;
    function IsAdministrator(const UserName: WideString): OleVariant; safecall;
    function GetTableProviderName(Table: Integer): OleVariant; safecall;
    function ExecuteCommand(CommandId: Integer; Params: OleVariant): OleVariant; safecall;
    function GetDQLCommand(SearchId: Integer; Params: OleVariant): OleVariant; safecall;
    function GetLastUpdateError: OleVariant; safecall;
    function ExecuteRegisteredSearch(SearchId: Integer; Params: OleVariant): OleVariant;
          safecall;
    function Echoo(const AMessage: WideString): OleVariant; safecall;




  public
    { Public declarations }
     property ActiveRange: Int64 read FActiveRange;
     property ConnectedUser: TCosmosUser read FConnectedUser;
     property CurrentCosmosModule: TCosmosModules read GetCurrentCosmosModule;
     property Log: TWinServiceLog read FLog;
  end;

implementation

uses cosmos.core.cripterint, cosmos.core.cripter, cosmos.core.ConstantesMsg, fbservices_TLB,
  main, SQLConsts, cosmos.core.winshell, cosmos.persistence.registry;

{$R *.DFM}

procedure TFocosManager.CreateLog(const Message: string; MsgType: Cardinal);
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

function TFocosManager.CreateMessageData: TServerReturn;
begin
 //Cria um objeto TServerReturn e configura suas propriedades com valores-padrão.
 Result := TServerReturn.Create;
 Result.Code := 0;
 Result.HelpContext := 0;
 Result.MessageText := '';
 Result.MessageTitle := '';
 Result.MessageType := mtpSucess;
 Result.CosmosModule := cmFocosServer;
 Result.SetMessageInfo(miInstallationID, self.ActiveRange);
end;

procedure TFocosManager.DspBairrosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'BAIRROS';
end;

procedure TFocosManager.DspCargosGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_CARGOS, False]);
end;

procedure TFocosManager.DspEnderecoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
TableName := 'ENDERECOS';
end;

procedure TFocosManager.DspFocoGetTableName(Sender: TObject; DataSet: TDataSet;
  var TableName: WideString);
begin
 TableName := UpperCase(TableName);
end;

procedure TFocosManager.DspFuncoesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_FUNCOES, False]);
end;

procedure TFocosManager.DspLogradourosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'LOGRADOUROS';
end;

procedure TFocosManager.DspMentoresGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_MENTORES_REGIOES, False]);
end;

procedure TFocosManager.DspMentoresGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'MENTORES_REGIOES';
end;

procedure TFocosManager.DspOrgaosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ORGAOS_GESTORES';
end;

procedure TFocosManager.DspPaisesBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
var
codpai: integer;
ACommand: TSQLServerCommand;
ADataset: TSQLDataset;
begin
 case UpdateKind of
  ukDelete: //Checa se o país pode ser deletado
   begin
    self.CloseDataset(SQLSearch);
    codpai := DeltaDS.Fields.FieldByName('codpai').AsInteger;

    ACommand := TSQLServerCommand.Create;
    ADataset := TSQLDataset.Create(self);
    ADataset.SQLConnection := self.SQLCon;

    try
     ACommand.ExecuteDQL(Format(sSelCount,['codest','estados','codpai',codpai]), ADataset);
     if ADataset.Fields.Fields[0].AsInteger > 0 then
      begin
       raise EDeleteError.Create(sErroDeleteError);
       Applied := False;
      end;

     if Assigned(ACommand) then
      FreeAndNil(ACommand);

    except
     on E: Exception do
      begin
       if Assigned(ACommand) then
        FreeAndNil(ACommand);

       self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
      end;
    end;
   end;
 end;
end;

procedure TFocosManager.DspPerfilGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_PERFIS, False]);
end;

procedure TFocosManager.DspSearchUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 self.DoCreateUpdateDataError(E);
end;

function TFocosManager.NewSQLMonitorFile: string;
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
 Result := AFileName + '\gfoc_' + GUIDToString(GUID) + '.txt';
end;

procedure TFocosManager.ReadChipherKey(var Key: string);
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

procedure TFocosManager.RemoteDataModuleCreate(Sender: TObject);
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

procedure TFocosManager.RemoteDataModuleDestroy(Sender: TObject);
begin
 if Assigned(FConnectedUser) then
  FreeAndNil(FConnectedUser);

 if Assigned(FrmMain) then
  FrmMain.UnregisterConnection(FConnectionID);
end;

procedure TFocosManager.SetConnectionParams;
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

class procedure TFocosManager.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

procedure TFocosManager.CloseDataset(const Dataset: TDataset);
begin
//Fecha um dataset ativo.
 if Assigned(Dataset) then
  if Dataset.Active then
   Dataset.Close;
end;

procedure TFocosManager.ConfigureDatabaseMonitor;
begin
  //Verifica se a conexão com o servidor SQL estará em monitoramento.
  FMaxLineTrace := TCosmosInfoFiles.GetMaxLineTracesMonitor;
  SQLMonitor.FileName := self.NewSQLMonitorFile;
  SQLMonitor.Active := TCosmosInfoFiles.IsMonitoringDatabase;

  if SQLMonitor.Active then
    SQLMonitor.SQLConnection := SQLCon;
end;

procedure TFocosManager.ConfigureLogSystem;
var
 AList: TStringList;
begin
//Configura o objeto interno da classe TWinService que usa o serviço de escrita
//de logs do MSWindows.
 if Assigned(FLog) then
  begin
   AList := TStringList.Create;

   try
     TCosmosApplication.ReadLogInformation(cmFocosServer, AList);

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

function TFocosManager.ConnectDatabase(const UserName, Password, RoleName,
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

{ TSQLThread }

function TFocosManager.Get_ActiveUser: OleVariant;
begin
//Retorna o nome do usuário ativo, caso exista um
 if SQLCon.Connected then
  Result := SqlCon.Params.values['user_name']
 else
  Result := Null; //Retorna um ponteiro nulo
end;

function TFocosManager.GetSequenceValue(const SequenceName: WideString): OleVariant;
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

function TFocosManager.GetUserStatus(const UserName: string): TUserStatus;
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

function TFocosManager.Get_ServerComputer: OleVariant;
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

function TFocosManager.Get_StartTime: OleVariant;
begin
//Retorna a data e hora de início de execução da aplicação servidora
 Result := FrmMain.CManager.StartTime;
end;

function TFocosManager.ListRegions(codreg: Integer): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
sql: string;
begin
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  if codreg > 0 then
   SQL := Format(sRegioesPai, [codreg])
  else
   SQL := sRegioes;

  ACommand.ExecuteDQL(SQL, ADataset);
  Result := ADataset.Data;

  if Assigned(ACommand) then
   FreeAndNil(ACommand);

  if Assigned(ADataset) then
   FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFocosManager.RenameAr(codreg: Integer;
  const NewName: WideString): OleVariant;
begin
//Renomeia uma determinada RA
 try
  SQLCon.ExecuteDirect(Format(sRenameRegion, [QuotedStr(NewName), codreg]));
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(Format(sLogIncorrectSQL, [Format(sRenameRegion, [QuotedStr(NewName), codreg]), E.Message]),
      EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;
end;

function TFocosManager.ListFocusByType(Inactives: WordBool): OleVariant;
//Lista os focos pelo seu tipo
var
sql: string;
begin
 try
  CloseDataset(SQLSearch);
  if Inactives then
   SQL := Format(sListFocos, [''])
  else
   SQL := Format(sListFocos, ['where indati = ' + QuotedStr('S')]);

  SQLSearch.CommandText := sql;
  Result := DspSearch.Data;

 finally
  CloseDataset(SQLSearch);
 end;

end;

function TFocosManager.ListFocusSequencial(Inactives: WordBool): OleVariant;
var
sql: string;
begin
 try
  CloseDataset(SQLSearch);
  if Inactives then
   SQL := Format(sListFocos, [''])
  else
   SQL := Format(sListFocos, ['where indati = ' + QuotedStr('S')]);

  SQLSearch.CommandText := sql;
  Result := DspSearch.Data;

 finally
  CloseDataset(SQLSearch);
 end;

end;

function TFocosManager.ChangeFocusParent(FocusID,
  NewParent: Integer): OleVariant;
var
sql: string;
begin
//Muda a ligação de dependência de um foco
 sql := Format(sMoveFocoTitular, [NewParent, FocusID]);

 try
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(Format(sLogIncorrectSQL, [sql, E.Message]),
      EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;

end;

function TFocosManager.ChangeFocusRegion(FocusID,
  NewRegion: Integer): OleVariant;
var
sql: string;
begin
//Muda a região administrativa de um foco
 sql := Format(sMoveRegiaoFoco, [NewRegion, FocusID]);

 try
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(Format(sLogIncorrectSQL, [sql, E.Message]),
      EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;

end;

function TFocosManager.DeleteRegion(RegionID: Integer): OleVariant;
var
sql: string;
begin
//Exclui uma região administrativa, se possível
 try
  sql := Format(sSQLDelRegiao, [RegionID]);
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(Format(sLogIncorrectSQL, [sql, E.Message]),
      EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;

end;

function TFocosManager.ListFocusRegion(RegionID: Integer; Inactives,
  OnlyTop: WordBool): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
ASQL: string;
begin
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  if OnlyTop then
   ASQL := sSQLFocosRa
  else
   ASQL := sSQLFocosRa2;


  if Inactives then
   ASQL := Format(ASQL, [RegionID, ''])
  else
   ASQL := Format(ASQL, [RegionID, 'and indati = ' + QuotedStr('S')]); //do not localize!

  ACommand.ExecuteDQL(ASQL, ADataset);
  Result := ADataset.Data;

  if Assigned(ACommand) then
   FreeAndNil(ACommand);

  if Assigned(ADataset) then
   FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFocosManager.MoveRegion(RegionID, NewRegion: Integer): OleVariant;
var
sql: string;
begin
//Altera a ligação de uma região administrativa
 if NewRegion >= 0 then
  sql := Format(sMoveRegiao, [NewRegion, RegionID])
 else
  sql := Format(sMoveRegiaoToRoot, [RegionID]); 

 try
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(Format(sLogIncorrectSQL, [sql, E.Message]),
      EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;

end;

function TFocosManager.NewAR(const ARName: WideString;
  ARParent: OleVariant): OleVariant;
var
sql, SequenceName: string;
newcode, codpai: integer;
AReturn: TServerReturn;
ACommand: TSQLServerCommand;
begin
//Insere uma nova RA ou subregião e retorna o código dela.

//Reserva o valor do auto-incremento
 AReturn := self.CreateMessageData;
 ACommand := TSQLServerCommand.Create;
 SequenceName := TCosmosDataObjects.GetSequenceName(sqRegioes);
 AReturn.ReadServerReturn(GetSequenceValue(SequenceName));
 NewCode := AReturn.ServerData;

 if ARParent = null then
  sql := Format(sInsertRegion, [NewCode, QuotedStr(ARName), 'null'])
 else
  begin
   codpai := ARParent;
   sql := Format(sInsertRegion, [NewCode, QuotedStr(ARName),IntToStr(codpai)]);
  end;

 try
  ACommand.ExecuteCommand(sql);
  Result := AReturn.ServerReturn;

  if Assigned(AReturn) then FreeAndNil(AReturn);
  if Assigned(ACommand) then FreeAndNil(ACommand);


 except
  on E: Exception do
   begin
    AReturn.MessageType := mtpError;
    AReturn.Code := -1;
    AReturn.MessageTitle := sTitleRAs;
    AReturn.MessageText := sErrorCreateRA;
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then FreeAndNil(AReturn);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    CreateLog(Format(sLogIncorrectSQL, [sql, E.Message]), EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFocosManager.ListDependentsFocus(TitularFocus: Integer;
  Inactives: WordBool): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
begin
//Lista os focos de um foco titular.
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  if Inactives then
   ACommand.ExecuteDQL(Format(sSQLFocosDependentes, [TitularFocus]), ADataset)
  else
   ACommand.ExecuteDQL(Format(sSQLFocosTitularAtivos, [TitularFocus, QuotedStr('S')]), ADataset);

  Result := ADataset.Data;

  if Assigned(ACommand) then
   FreeAndNil(ACommand);

  if Assigned(ADataset) then
   FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFocosManager.ListFocusByTitular(Inactives: WordBool): OleVariant;
var
sql: string;
begin
//Lista os focos ordenando por focos titulares
 try
  CloseDataset(SQLSearch);
  if Inactives then
   SQL := 'select codfoc, nomfoc, tipfoc, sigfoc, indati from focos where focpai is null ' +
    'order by nomfoc'
  else
   SQL := Format('select codfoc, nomfoc, tipfoc, sigfoc, indati from focos where focpai is null  ' +
    'and indati = %s order by nomfoc', [QuotedStr('S')]);

  SQLSearch.CommandText := sql;
  Result := DspSearch.Data;

 finally
  CloseDataset(SQLSearch);
 end;

end;

function TFocosManager.ChangeFocusStatus(FocusID: Integer;
  Status: WordBool): OleVariant;
var
sql: string;
begin
//Ativa ou desativa um foco
 if Status then
  sql := Format(sAlteraStatusFoco,[QuotedStr('S'), FocusID])
 else
  sql := Format(sAlteraStatusFoco, [QuotedStr('N'), FocusID]);

 try
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(Format(sLogIncorrectSQL, [sql, E.Message]),
      EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;

end;

function TFocosManager.Get_ServerDateTime: OleVariant;
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

function TFocosManager.CriarFoco(DadosFoco, DadosEndereco, DadosGestao,
  DadosMeiosContatos: OleVariant): OleVariant;
var
  NewID: Integer;
  ScriptList: TStringList;
  sql, nomfoc, SequenceName: string;
  NOMTEM: string;
  FOCPAI: variant;
  comend: string;
  refend: string;
  aceend: string;
  AReturn, InnerReturn: TServerReturn;
  ACommand: TSQLServerCommand;
  ADataset: TClientDataset;
begin
{Este método remoto é responsável por criar um novo foco e registrar o seu
 endereço e meios de contato. É feito através da leitura de pacotes de dados,
 vindo da estação cliente, e usados para montar um script SQL que será executado.}

 ADataset := TClientDataset.Create(self);
 ACommand := TSQLServerCommand.Create;
 AReturn := self.CreateMessageData;

 ADataset.Data := DadosFoco;
 nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString;
 //Destrói o dataset para ele ser recriado e usado posteriormente.
 if Assigned(ADataset) then
  FreeAndNil(ADataset);

 try
  //Primeiramente, checa se o foco já não está cadastrado.
  ADataset := TClientDataset.Create(self);
  ACommand.ExecuteDQL(Format(sSQLFocusExists, [QuotedStr(nomfoc)]), ADataset) ;

  try
   if not ADataset.IsEmpty then
     raise EFocusDuplicated.Create(Format(sErroFocusExists, [nomfoc]));

  except
   on E: EFocusDuplicated do
    begin
     AReturn.MessageType := mtpError;
     AReturn.MessageTitle := sTitleFocoCriacao;
     AReturn.MessageText := sErrorCriacaoFocoDuplicado;
     Result := AReturn.ServerReturn;
     raise;
    end;
  end;

  //OK, o foco não está cadastrado. A operação seguirá.
  ScriptList := TStringList.Create;
  InnerReturn := self.CreateMessageData;

  try
   SequenceName := TCosmosDataObjects.GetSequenceName(sqFocos);
   InnerReturn.ReadServerReturn(GetSequenceValue(SequenceName));
   NewID := InnerReturn.ServerData;
   ADataset.Data := DadosFoco;

  finally
   if Assigned(InnerReturn) then
    FreeAndNil(InnerReturn);
  end;

  //Monta o comando SQL para inserir os dados principais do foco.
  with ADataset.Fields do
   begin
    if FieldByName('NOMTEM').IsNull then
     NOMTEM := 'null'
    else
     NOMTEM := QuotedStr(FieldByName('NOMTEM').AsString);
    if FieldByName('FOCPAI').IsNull then
     FOCPAI := 'null'
    else
     FOCPAI := FieldByName('FOCPAI').AsString; //deve ser texto..

//     NOMTEM := FieldByName('SIGFOC').AsString;

    sql := Format(sInsertFoco,[NewID,QuotedStr(FieldByName('SIGFOC').AsString),
     QuotedStr(FieldByName('NOMFOC').AsString), NOMTEM,
     FieldByName('CODREG').AsInteger, FOCPAI,
     QuotedStr(FieldByName('TIPFOC').AsString),
     QuotedStr(FieldByName('INDLEC').AsString),
     QuotedStr(FieldByName('INDTPU').AsString),
     QuotedStr(FieldByName('INDTMO').AsString),
     QuotedStr(FieldByName('INDTMB').AsString),
     QuotedStr(FieldByName('INDIND').AsString),
     QuotedStr(FieldByName('INDATI').AsString),
     QuotedStr(FieldByName('INDNAC').AsString),
     QuotedStr(FieldByName('INDCAB').AsString)]);

    ScriptList.Append(sql + ';');

   //Agora monta o comando SQL para inserir os dados do endereço.
    ADataset.Data := DadosEndereco;
    if not ADataset.IsEmpty then
     begin
      while not ADataset.Eof do
       begin
        if FieldByName('comend').IsNull then
         comend := 'null'
        else
         comend := QuotedStr(FieldByName('comend').AsString);

        if FieldByName('refend').IsNull then
         refend := 'null'
        else
         refend := QuotedStr(FieldByName('refend').AsString);

        if FieldByName('aceend').IsNull then
         aceend := 'null'
        else
         aceend := QuotedStr(FieldByName('aceend').AsString);

        sql := Format(sInsertEnderecos,[FieldByName('codlog').AsInteger,
            FieldByName('numend').AsInteger,
            comend, 'null',
            QuotedStr(FieldByName('indcor').AsString),
            refend, aceend, 'null', IntToStr(NewID)]);
        sql := sql + ';';
        ScriptList.Append(sql);
        ADataset.Next;
       end;
     end;

   //Agora monta o comando SQL para inserir os dados de meios de contato.
    ADataset.Data := DadosMeiosContatos;
    if not ADataset.IsEmpty then
     begin
      while not ADataset.Eof do
       begin
        sql := Format(sInsertMeiosContatos,
          [QuotedStr(ADataset.Fields.FieldByName('descon').AsString),
           ADataset.Fields.FieldByName('codtipcon').AsInteger,
           'null', IntToStr(NewID), QuotedStr('N')]);
        sql := sql + ';';
        ScriptList.Append(sql);
        ADataset.Next;
       end;
     end;
   end;

    if Assigned(ADataset) then
     FreeAndNil(ADataset);


    //Finalmente, executa o script em uma única transação.
    try
      AReturn.ServerData := ACommand.ExecuteScript(SQLCon, ScriptList);

    except
     on E: TDBXError do
      begin
       AReturn.MessageType := mtpError;
       AReturn.MessageTitle := sTitleFocoCriacao;
       AReturn.MessageText := sErrorCriacaoFoco;
       AReturn.SetMessageInfo(miInnerMessage, E.Message);
       Result := AReturn.ServerReturn;
       CreateLog(Format(sLogIncorrectScript, [ScriptList.CommaText, E.Message]), EVENTLOG_ERROR_TYPE);
       raise;
      end;
    end;

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
 end;
end;

function TFocosManager.GetFocusData(indsed, indcco, indncc, indnuc, indstp,
  indltp, indnac, inativos: WordBool): OleVariant;
var
sWhere, sTipo: string;
I: integer;
begin
{Lista dados dos focos que atendem os seguintes argumentos passados pelos
 parâmetros:}
 if indnac = True then
  sWhere := 'where tipfoc in (%s,%s,%s,%s,%s,%s,%s) and indnac = ' + QuotedStr(TDataTransformation.AsSQLBoolean(True))
 else
  sWhere := 'where tipfoc in (%s,%s,%s,%s,%s,%s,%s)';

 sWhere := Format(sWhere,
  [QuotedStr('SDI'),QuotedStr('SDN'),QuotedStr('CCO'),QuotedStr('NCC'),
   QuotedStr('NUC'), QuotedStr('STP'),QuotedStr('LTP')]);

 if indsed = False then
  begin
   sTipo := QuotedStr('SDI') + ',' + QuotedStr('SDN') + ',';
   I := Pos(sTipo, sWhere);
   if I <> 0 then
    Delete(sWhere,I,12);
  end;

 if indcco = False then
  begin
   sTipo := QuotedStr('CCO') + ',' ;
   I := Pos(sTipo, sWhere);
   if I <> 0 then
    Delete(sWhere,I,6);
  end;

 if indncc = False then
  begin
   sTipo := QuotedStr('NCC') + ',' ;
   I := Pos(sTipo, sWhere);
   if I <> 0 then
    Delete(sWhere,I,6);
  end;

 if indnuc = False then
  begin
   sTipo := QuotedStr('NUC') + ',' ;
   I := Pos(sTipo, sWhere);
   if I <> 0 then
    Delete(sWhere,I,6);
  end;

 if indstp = False then
  begin
   sTipo := QuotedStr('STP') + ',' ;
   I := Pos(sTipo, sWhere);
   if I <> 0 then
    Delete(sWhere,I,6);
  end;

 if indltp = False then
  begin
   sTipo := QuotedStr('LTP');
   I := Pos(sTipo, sWhere);
   if I <> 0 then
    Delete(sWhere,I,5);
  end;

 I := Pos(',)', sWhere);
 if I <> 0 then
  Delete(sWhere,I,1);

 try
  self.CloseDataset(SQLSearch);
  SQLSearch.CommandText := Format(sSQLFilteredFocos, [sWhere]);
  Result := self.DspSearch.Data;

 finally
  self.CloseDataset(SQLSearch);
 end;

end;

function TFocosManager.GetLogradouro(const Cep: WideString): OleVariant;
begin
 self.CloseDataset(SQLSearch);
 SQLSearch.CommandText := Format(sSQLFindLogradouro,[QuotedStr(Cep)]);

 try
  Result := self.DspSearch.Data;

 finally
  self.CloseDataset(SQLSearch);
 end;
end;

function TFocosManager.DesactiveFocus(TargetFocus, TransferFocus: Integer;
  Desactivate: WordBool): OleVariant;
var
TD: TDBXTransaction; //Classe que implementa transações no DBExpress
AServerManager: TSQLServerTransactionsManager;
begin
//Transfere os cadastrados para outro foco e desativa um determinado foco.
 AServerManager := TSQLServerTransactionsManager.Create;

 try
  //Inicia uma nova transação
  TD := AServerManager.BeginTransaction(SQLCon, TDBXIsolations.ReadCommitted);

  SQLSearch.CommandText := Format(sSQLDesativaFoco,[TargetFocus, TransferFocus,
   QuotedStr(TDataTransformation.AsSQLBoolean(Desactivate))]) ;
  Result := DspSearch.Data;

  AServerManager.CommitTransaction(SQLCon, TD);

  if Assigned(AServerManager) then
   FreeAndNil(AServerManager);

 except
  on E: EDatabaseError do
   begin
    AServerManager.RollbackTransaction(SQLCon, TD);
    raise;
   end
  else
   AServerManager.RollbackTransaction(SQLCon, TD);

  if Assigned(AServerManager) then
   FreeAndNil(AServerManager);
 end;
end;

function TFocosManager.DeleteFocus(codfoc: Integer): OleVariant;
var
ACommand: TSQLServerCommand;
begin
//Exclui um determinado foco
 ACommand := TSQLServerCommand.Create;

 try
  ACommand.ExecuteCommand(Format(sSQLDelFocus, [codfoc]));
  Result := True;
  if Assigned(ACommand) then
   FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

procedure TFocosManager.SQLConAfterConnect(Sender: TObject);
begin
 //Obtém o número de faixa de chaves primárias do banco de dados
 try
  DoExecuteDQL(Format(sSQLGenerators, [sGEN_ACTIVE_RANGE, 0]));
  FActiveRange := SQLSearch.Fields.Fields[0].Value;

 finally
  CloseDataset(SQLSearch);
 end;
end;

procedure TFocosManager.SQLSearchAfterOpen(DataSet: TDataSet);
begin
 TCosmosFields.LoadFieldsInfo(Dataset);
end;

procedure TFocosManager.BufferData(const SchemmaName: WideString;
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

function TFocosManager.GetCurrentCosmosModule: TCosmosModules;
begin
 Result := cmFocosServer;
end;

function TFocosManager.AlterarSubordinacao(codorg,
  NewParent: Integer): OleVariant;
var
sql: string;
begin
//Muda a ligação de dependência de um órgão gestor
 sql := Format(sMoveOrgao, [NewParent, Codorg]);

 try
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(Format(sLogIncorrectSQL, [sql, E.Message]),
      EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;


end;

function TFocosManager.ListOrgaos(codsup: OleVariant): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
begin
//Lista os órgãos gestores subordinados ao órgão com o código passado
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  if Codsup = null then
   ACommand.ExecuteDQL(Format(sSQLListOrgaos, ['is null']), ADataset)
  else
   ACommand.ExecuteDQL(Format(sSQLListOrgaos, [' = ' + VarToStr(Codsup)]), ADataset);

  Result := ADataset.Data;

 finally
  if Assigned(ACommand) then FreeAndNil(ADataset);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TFocosManager.DeleteGestao(codges: Integer): OleVariant;
var
sql: string;
begin
//Tenta excluir a gestão passada em parâmetro
 try
  sql := Format(sSQLDelGestao, [Codges]);
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;

end;

function TFocosManager.DeleteOrgao(codorg: Integer): OleVariant;
var
sql: string;
begin
//Exclui um determinado órgão gestor
 try
  sql := Format(sSQLDelOrgaoGestor, [codorg]);
  SQLCon.ExecuteDirect(sql);
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;
end;

function TFocosManager.ListGestoesOrgao(codorg: Integer): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
begin
//Lista as gestões de um determinado órgão gestor.
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(Format(sSQLListGestoesOrgao, [codorg]), ADataset);
  Result := ADataset.Data;

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TFocosManager.ListOrgaosByEsfera(indnac, indati: WordBool): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
begin
//Lista os órgãos gestores ordenados por suas respectivas esfera de atuação.
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  ACommand.ExecuteDQL(sSQLListOrgaosByName, ADataset);
  Result := ADataset.Data;

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TFocosManager.ListOrgaosByName(codsup: OleVariant): OleVariant;
var
ACommand: TSQLServerCommand;
ADataset: TClientDataset;
begin
//Lista os órgãos gestores subordinados ao órgão com o código passado.
 ACommand := TSQLServerCommand.Create;
 ADataset := TClientDataset.Create(nil);

 try
  if Codsup = null then
   ACommand.ExecuteDQL(sSQLListOrgaosByName, ADataset)
  else
   ACommand.ExecuteDQL(Format(sSQLListOrgaos, [' = ' + VarToStr(Codsup)]), ADataset);

  Result := ADataset.Data;

 finally
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TFocosManager.CloneDirigente(coddir, codges: Integer): OleVariant;
begin
//"Clona" o dirigente de uma gestão para outra
 try
  SQLCon.ExecuteDirect(Format(sSQLCloneDirigente, [Coddir, Codges]));
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;
end;

function TFocosManager.ListMembrosGestao(codges: Integer): OleVariant;
begin
//Lista os membros de uma gestão de um órgão gestor
 try
  SQLSearch.CommandText := Format(sSQLListDirecoesGestao, [codges]);
  Result := DspSearch.Data;

 finally
  CloseDataset(SQLSearch);
 end;
end;

function TFocosManager.DeleteDirigente(coddir: Integer): OleVariant;
begin
//Exclui um determinado dirigente
 try
  SQLCon.ExecuteDirect(Format(sSQLDelDirigente, [coddir]));
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;
end;

function TFocosManager.MoveDirigente(coddir, codges: Integer): OleVariant;
begin
//Move o dirigente de uma gestão para outra
 try
  SQLCon.ExecuteDirect(Format(sSQLMoveDirigente, [Codges, coddir]));
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;
end;

function TFocosManager.TerminateMandate(coddir: Integer): OleVariant;
begin
//Encerra o mandato de um dirigente
 try
  SQLCon.ExecuteDirect(Format(sSQLTerminateMandate, [QuotedStr(TDataTransformation.AsSQLTimeStamp(Now)), coddir]));
  Result := True;

 except
  on E: EDatabaseError do
   begin
    Result := False;
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
    raise;
   end;
 end;
end;

function TFocosManager.TerminateMandates(codges: Integer): OleVariant;
var
AScript: TStringList;
ACommand: TSQLServerCommand;
begin
//Encerra os mandatos dos dirigentes de uma gestão
 AScript := TStringList.Create;
 ACommand := TSQLServerCommand.Create;

 try
  AScript.Add(Format(sSQLTerminateGestao, [QuotedStr(TDataTransformation.AsSQLTimeStamp(Now)), codges]) + ';');
  AScript.Add(Format(sSQLTerminateMandates, [QuotedStr(TDataTransformation.AsSQLTimeStamp(Now)), codges]) + ';');
  Result := ACommand.ExecuteScript(SQLCon, AScript);

  if Assigned(AScript) then
   FreeAndNil(AScript);

  if Assigned(ACommand) then
   FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(AScript) then FreeAndNil(AScript);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFocosManager.DuplicarGestao(codorg, codges: Integer; datini,
  datter: TDateTime; Dirigentes: OleVariant): OleVariant;
var
AScript: TStringList;
newcodges: integer;
ACommand: TSQLServerCommand;
Cds: TClientDataset;
SequenceName: string;
AReturn: TServerReturn;
begin
//Encerra os mandatos dos dirigentes de uma gestão
 AReturn := TServerReturn.Create;
 AScript := TStringList.Create;
 Cds := TClientDataset.Create(nil);
 ACommand := TSQLServerCommand.Create;

 try
  Cds.Data := Dirigentes;
  SequenceName := TCosmosDataObjects.GetSequenceName(sqGestoes);
  AReturn.ReadServerReturn(GetSequenceValue(SequenceName));
  newcodges := AReturn.ServerData;

  with AScript do
   begin
    Add(Format(sSQLInsGestao, [newcodges, codorg, QuotedStr(TDataTransformation.AsSQLTimeStamp(datini)), QuotedStr(TDataTransformation.AsSQLTimeStamp(datter))]) + ';');

    while not Cds.Eof  do
     begin
      Add(Format(sSQLInsDirigente, [newcodges,
       Cds.Fields.FieldByName('codcad').AsInteger,
       Cds.Fields.FieldByName('codfoc').AsInteger,
       Cds.Fields.FieldByName('coddis').AsInteger,
       Cds.Fields.FieldByName('codcar').AsInteger,
       QuotedStr(Cds.Fields.FieldByName('indcon').AsString),
       QuotedStr(TDataTransformation.AsSQLTimeStamp(datini)),QuotedStr(TDataTransformation.AsSQLTimeStamp(datter))]) + ';');
      Cds.Next;
     end;
   end;

  Result := ACommand.ExecuteScript(SQLCon, AScript);
  if Assigned(AScript) then
   FreeAndNil(AScript);

  if Assigned(AReturn) then
   FreeAndNil(AReturn);

  if Assigned(ACommand) then
   FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    if Assigned(AScript) then FreeAndNil(AScript);
    if Assigned(AReturn) then FreeAndNil(AReturn);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

procedure TFocosManager.FichaCadastrado(codcad: Integer; out CoreData,
  FuncoesData, ContatosData: OleVariant);
begin
//Monta a ficha do cadastrado e exporta os dados para as aplicações clientes.
 try
  SQLFicha.Params.Items[0].AsInteger := codcad;
  CoreData := DspFicha.Data;


 finally
  CloseDataset(SQLFicha);
 end;
end;

function TFocosManager.Get_DatabaseVersion: OleVariant;
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

function TFocosManager.Get_BetaVersion: WordBool;
begin
 Result := False;
end;

procedure TFocosManager.DoCreateUpdateDataError(E: Exception);
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
  AReturn.CosmosModule := cmSecretariasServer;
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

function TFocosManager.DoExecuteCommand(const Command: WideString): integer;
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

procedure TFocosManager.DoExecuteDQL(const DQL: WideString);
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

function TFocosManager.DoExecuteScript(var AScript: TStringList): boolean;
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
  Result := ACommand.ExecuteDirect > 0;

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

function TFocosManager.GetPerfilData: OleVariant;
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

function TFocosManager.ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant;
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

function TFocosManager.Get_ActiveRange: OleVariant;
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

function TFocosManager.Get_CodeKey: OleVariant;
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

function TFocosManager.IsAdministrator(const UserName: WideString): OleVariant;
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

function TFocosManager.GetTableProviderName(Table: Integer): OleVariant;
var
AReturn: TServerReturn;
begin
//Retorna o nome de um TDatasetProvider que retorna os dados de uma tabela acessória.
 AReturn := self.CreateMessageData;

 try
  case TCosmosTables(Table) of
   ctCargos: AReturn.ServerData := 'DspCargos';
   ctFuncoes: AReturn.ServerData := 'DspFuncoes';
  end;

 finally
  Result := AReturn.ServerReturn;
  if Assigned(AReturn) then
   AReturn.Free;
 end;

end;

function TFocosManager.ExecuteCommand(CommandId: Integer; Params: OleVariant): OleVariant;
var
AReturn: TServerReturn;
ACosmosCommand: TCosmosCommand;
ACommand: string;
begin
 //Executa um command DML simples (uma linha) no servidor SQL.
 ACosmosCommand :=  TSQLServerInterface.GetCosmosCommand(CommandID);
 ACommand := TSQLCommandsFactory.GetDMLCommand(ACosmosCommand);

 if ACommand = '' then
  raise EUnknownCommandError.Create(sErrorUnknownCommand);

 //Preenche os valores dos parâmetros recebidos.
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);

 AReturn := self.CreateMessageData;

 try
  if DoExecuteCommand(ACommand) > 0 then
   begin
    AReturn.Code := 0;
    AReturn.ServerData := True;
   end;

  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorExecuteDML;
    AReturn.MessageTitle := sTitleExecuteDML;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFocosManager.GetDQLCommand(SearchId: Integer; Params: OleVariant): OleVariant;
var
ACommand: string;
AReturn: TServerReturn;
begin
{Retorna para o cliente um comando DQL. Isto é necessário apenas na situação em
que um TClientDataset está conectado a um Provider, de forma a trazer todas
as propriedades dos TFields para o lado cliente.}
 AReturn := self.CreateMessageData;

 try
  ACommand := TSQLCommandsFactory.GetSQLCommand(TSQLServerInterface.GetCosmosSearch(SearchID));
  TSQLCommandsFactory.CreateCommandText(ACommand, Params);
  AReturn.ServerData := ACommand;
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorGetCommand;
    AReturn.MessageTitle := sTitleGetCommands;
    AReturn.SetMessageInfo(miCommand, ACommand);
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TFocosManager.GetLastUpdateError: OleVariant;
begin
 {Retorna a última mensagem de erro de atualizaão de dados. Neste caso, não é
 necessário criar uma estrutura de retorno usando a classe TServerReturn.}
 Result := FLastUpdateError;
end;

function TFocosManager.ExecuteRegisteredSearch(SearchId: Integer; Params: OleVariant): OleVariant;
var
AReturn: TServerReturn;
ACosmosSearch: TCosmosSearch;
ACommand: string;
begin
//Executa uma pesquisa existente na tabela da Central de Pesquisas.
 ACommand := TCosmosDataObjects.GetRegisteredCommand(SearchID);
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);
 AReturn := self.CreateMessageData;

 try
  //Executa o comando DQL...
  self.DoExecuteDQL(ACommand);
  AReturn.ServerData := DspSearch.Data;
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

function TFocosManager.Echoo(const AMessage: WideString): OleVariant;
begin
 {Método simples, usado apenas como um "ping" para amter a conexão com o servidor.
 Isto é necessário para que o socket server não desfaça a conexõa ociosa.}
 Result := AMessage;
end;

initialization
  TComponentFactory.Create(ComServer, TFocosManager,
    Class_FocosManager, ciMultiInstance, tmApartment);
end.
