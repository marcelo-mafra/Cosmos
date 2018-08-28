unit cosmos.servers.secretarias.historico.methods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Classes,
  System.Json, Datasnap.DSServer, DataSnap.DSProviderDataModuleAdapter, Datasnap.DSAuth,
  Data.DB, Datasnap.DBClient, Data.SqlExpr, Data.FMTBcd, cosmos.classes.application, System.Variants,
  Provider, cosmos.servers.sqlcommands, cosmos.system.messages,  System.WideStrings,
  Data.dbxCommon, DataSnap.DsSession, cosmos.classes.logs, cosmos.system.exceptions,
  Data.DBXFirebird, cosmos.business.focos, cosmos.business.secretariats, cosmos.data.dbobjects.sequences,
  cosmos.classes.persistence.ini, cosmos.system.dataconverter, cosmos.business.focos.helpers,
  cosmos.servers.common.servicesint, cosmos.servers.common.dao.interfaces,
  cosmos.data.dbobjects.objnames;

type
  TCosmosSecHistoricoServerMethods = class(TDSServerModule)
    SQLSPTransferir: TSQLStoredProc;
    SQLHistorico: TSQLDataSet;
    DspHistorico: TDataSetProvider;
    SQLHistoricoCODHIS: TIntegerField;
    SQLHistoricoCODCAD: TIntegerField;
    SQLHistoricoCODTIPEVE: TIntegerField;
    SQLHistoricoDESTIPEVE: TStringField;
    SQLHistoricoCAMTRA: TStringField;
    SQLHistoricoTIPEVE: TStringField;
    SQLHistoricoSIGFOC: TStringField;
    SQLHistoricoDATHIS: TDateField;
    SQLEventoHistorico: TSQLDataSet;
    SQLEventoHistoricoCODHIS: TIntegerField;
    SQLEventoHistoricoDATHIS: TDateField;
    DspEventoHistorico: TDataSetProvider;
    SQLEventoHistoricoNOMCAD: TStringField;
    SQLEventoHistoricoCODTIPEVE: TIntegerField;
    SQLEventoHistoricoDESTIPEVE: TStringField;
    SQLEventoHistoricoTIPEVE: TStringField;
    SQLEventoHistoricoCAMTRA: TStringField;
    SQLEventoHistoricoNOMFOC: TStringField;
    SQLEventoHistoricoSIGDIS: TStringField;
    SQLEventoHistoricoDESEVE: TStringField;
    SQLEventoHistoricoOBSHIS: TMemoField;
    SQLEventoHistoricoMOTDES: TStringField;
    SQLEventoHistoricoNUMREG: TIntegerField;
    SQLEventoHistoricoUSURES: TStringField;
    SQLEventoHistoricoDATCAD: TSQLTimeStampField;
    SQLDetalhesHistorico: TSQLDataSet;
    DspDetalhesHistorico: TDataSetProvider;
    SQLDetalhesHistoricoCODDET: TIntegerField;
    SQLDetalhesHistoricoDATDET: TSQLTimeStampField;
    SQLDetalhesHistoricoCODFLU: TIntegerField;
    SQLDetalhesHistoricoDESFLU: TStringField;
    SQLDetalhesHistoricoSEQFLU: TSmallintField;
    SQLDetalhesHistoricoINDCUM: TStringField;
    SQLDetalhesHistoricoOBSDET: TMemoField;
    SQLDetalhesHistoricoDATCAD: TSQLTimeStampField;
    SQLDetalhesHistoricoUSURES: TStringField;
    SQLHistoricoINDESCINT: TStringField;
    SQLHistoricoCODDIS: TIntegerField;
    SQLHistoricoSIGDIS: TStringField;
    SQLSPAnularHistorico: TSQLStoredProc;
    SQLTurmasInstalacao: TSQLDataSet;
    DspTurmasInstalacao: TDataSetProvider;
    SQLMembrosTurmasIns: TSQLDataSet;
    DspMembrosTurmasIns: TDataSetProvider;
    SQLPassosProtocolo: TSQLDataSet;
    DspPassosProtocolo: TDataSetProvider;
    SQLPassosProtocoloCODHIS: TIntegerField;
    SQLPassosProtocoloCODDET: TIntegerField;
    SQLPassosProtocoloDATDET: TSQLTimeStampField;
    SQLPassosProtocoloCODFLU: TIntegerField;
    SQLPassosProtocoloDESFLU: TStringField;
    SQLPassosProtocoloSEQFLU: TSmallintField;
    SQLPassosProtocoloINDCUM: TStringField;
    SQLCartas: TSQLDataSet;
    DspCartas: TDataSetProvider;
    SQLCartasCODHIS: TIntegerField;
    SQLCartasDATHIS: TDateField;
    SQLCartasCODCAD: TIntegerField;
    SQLCartasCODTIPEVE: TIntegerField;
    SQLCartasDESTIPEVE: TStringField;
    SQLCartasTIPEVE: TStringField;
    SQLCartasCAMTRA: TStringField;
    SQLCartasCODFOC: TIntegerField;
    SQLCartasNOMFOC: TStringField;
    SQLCartasOBSHIS: TMemoField;
    SQLInstalarMembro: TSQLStoredProc;
    SQLEventoHistoricoCODCAD: TIntegerField;
    SQLEventoHistoricoCODFOC: TIntegerField;
    SQLEventoHistoricoCODDIS: TIntegerField;
    procedure DspEventoHistoricoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspCartasGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspDetalhesHistoricoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure SQLHistoricoBeforeOpen(DataSet: TDataSet);
    procedure DspEventoHistoricoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspCartasGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspPassosProtocoloGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure SQLInstalarMembroBeforeOpen(DataSet: TDataSet);
    procedure DspDetalhesHistoricoUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FCosmosServiceFactory: ICosmosServiceFactory;
    FCosmosDAOServiceFactory: ICosmosDAOServiceFactory;
    function GetCosmosService: ICosmosService;
    function GetDAOServices: ICosmosDAOService;

  public
    { Public declarations }

    //Turmas de instalação
    procedure AdicionarInstalando(codturins, codcad, coddis,  codfoc: Integer);
    procedure CreateTurmaInst(const numtur: WideString; codfoc, coddis: Integer;
      memtur: OleVariant; UserName: string);
    procedure DropInstalando(codturins, codcad: Integer);
    function GenNumeroTurmaInst(codfoc: Integer): string;
    procedure InstalarTurmaAlunos(codturins: Integer; datins: TDateTime; current_user: WideString);

    //Ações no histórico discipular
    procedure AnularEventoHistorico(codhis: Integer; const sigdis, current_user: WideString);
    procedure AtualizaGruposTM(codfoc: Integer);
    function NovaMatricula(codfoc: integer; CampoTrabalho, CreationMode: integer): string;
    procedure BatizarCadastrado(Data: OleVariant; out ReturnCode: integer);
    procedure CasarCadastrados(Data: OleVariant; out ReturnCode: integer);
    procedure DesligarCadastrado(Data: OleVariant; out ReturnCode: integer);
    procedure EnviarCartaFrequencia(Data: OleVariant; out ReturnCode: integer);
    procedure ReativarCadastrado(Data: OleVariant; out ReturnCode: integer);
    procedure RetrogradarAluno(Data: OleVariant; out ReturnCode: integer);
    procedure TransferirCadastrado(Data: Olevariant; out ReturnCode: integer);

    //Pesquisas acessórias
    function GetDiscipuladosAnteriores(coddis: Integer;
      indtmo, indtpu, indsim, incatu: boolean): TDBXReader;
    function GetDiscipuladoCadastrado(codcad: Integer): TDataset;
    function GetDiscipuladosReligacao(codcad: Integer): TDataset;

    property CosmosServices: ICosmosService read GetCosmosService;
    property DAOServices: ICosmosDAOService read GetDAOServices;

  end;



implementation

uses cosmos.servers.common.methods, cosmos.servers.common.services.factory,
  cosmos.servers.common.dao.factory, cosmos.system.types;

{$R *.DFM}

procedure TCosmosSecHistoricoServerMethods.DspCartasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_HISTORICOS, False]);
end;

procedure TCosmosSecHistoricoServerMethods.DspCartasGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_HISTORICOS;
end;

procedure TCosmosSecHistoricoServerMethods.DspDetalhesHistoricoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_DETALHES_HISTORICO, False]);
end;

procedure TCosmosSecHistoricoServerMethods.DspDetalhesHistoricoUpdateError(
  Sender: TObject; DataSet: TCustomClientDataSet; E: EUpdateError;
  UpdateKind: TUpdateKind; var Response: TResolverResponse);
begin
 DAOServices.OnUpdateError(E, UpdateKind, Response);
end;

procedure TCosmosSecHistoricoServerMethods.DspEventoHistoricoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_HISTORICOS, False]);
end;

procedure TCosmosSecHistoricoServerMethods.DspEventoHistoricoGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_HISTORICOS;
end;

procedure TCosmosSecHistoricoServerMethods.DspPassosProtocoloGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_DETALHE_HISTORICO;
end;

procedure TCosmosSecHistoricoServerMethods.DSServerModuleCreate(
  Sender: TObject);
begin
 FCosmosServiceFactory := TCosmosServiceFactory.New(cmSecretariasServer);
 FCosmosDAOServiceFactory := TCosmosDAOServiceFactory.New(cmSecretariasServer);
end;

procedure TCosmosSecHistoricoServerMethods.DSServerModuleDestroy(
  Sender: TObject);
begin
 FCosmosServiceFactory := nil;
 FCosmosDAOServiceFactory := nil;
end;

procedure TCosmosSecHistoricoServerMethods.SQLHistoricoBeforeOpen(
  DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DAOServices.SQLConnection;
end;

procedure TCosmosSecHistoricoServerMethods.SQLInstalarMembroBeforeOpen(
  DataSet: TDataSet);
begin
  TSQLStoredProc(Dataset).SQLConnection := DAOServices.SQLConnection;
end;

procedure TCosmosSecHistoricoServerMethods.DesligarCadastrado(Data: OleVariant;
  out ReturnCode: integer);
var
AData: TCosmosData;
ADate: Extended;
TD: TDBXTransaction;
AProc: TSQLStoredProc;
begin
 //Desliga um cadastrado.
 AData := TCosmosData.Create(6);
 AProc := DAOServices.CreateStoreProcedure;

 try
  AData.LoadTaggedValues(Data);

  AProc.StoredProcName := TProceduresNames.PROC_DESLIGAR_CADASTRADO;

  with AProc.Params do
   begin
    ParamByName('icodcad').AsInteger := AData.FindValue('CADASTRADO');
     ADate := AData.FindValue('DATA');
     ParamByName('idathis').Value := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');
     ParamByName('imotdes').AsString := AData.FindValue('MOTIVO');
     ParamByName('iusures').AsString := AData.FindValue('USUARIO');

     if AData.FindValue('OBITO') <> '' then
      begin
       ADate := AData.FindValue('OBITO');
       ParamByName('idatobi').Value := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');
      end;

     if Trim(AData.FindValue('OBSERVACAO')) <> '' then
       ParamByName('iobshis').AsString := AData.FindValue('OBSERVACAO');
   end;

  TD := AProc.SQLConnection.BeginTransaction;
  AProc.Prepared := True;
  AProc.ExecProc;
  AProc.SQLConnection.CommitFreeAndNil(TD);

  ReturnCode := 0; //Sucesso.
  CosmosServices.RegisterLog(TCosmosInfoMsg.DesligamentoRegistrado, DAOServices.GetContextInfo(AProc));

  AData.Free;
  AProc.Free;

 except
  on E: Exception do
   begin
     CosmosServices.RegisterLog(E.Message, DAOServices.GetContextInfo(AProc), leOnError);
     ReturnCode := TCosmosErrorCodes.ExecuteOperation; //Falha genérica.

     if E.Message.Contains('EX_CADASTRADO_INEXISTE') then //Não foi encontrado o cadastrado.
       ReturnCode := TCosmosErrorCodes.CannotFindCadastrado;

     if E.Message.Contains('EX_CADASTRADO_DESLIGADO') then
       ReturnCode := TCosmosErrorCodes.CadastradoDesligado;

     if Assigned(AData) then FreeAndNil(AData);
     AProc.SQLConnection.RollbackFreeAndNil(TD);

    if Assigned(AProc) then FreeAndNil(AProc);
    raise TDBXError.Create(ReturnCode, TCosmosErrorCodes.ToMessage(ReturnCode));
   end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.TransferirCadastrado(Data: Olevariant;
 out ReturnCode: integer);
var
AData: TCosmosData;
ADate: Extended;
TD: TDBXTransaction;
AProc: TSQLStoredProc;
begin
 //Transfere um cadastrado para outro foco.
 AData := TCosmosData.Create(6);
 AProc := DAOServices.CreateStoreProcedure;

 try
  AData.LoadTaggedValues(Data);
  ADate := AData.FindValue('DATA');
  AProc.StoredProcName := TProceduresNames.PROC_TRANSFERIR_CADASTRADO;

  with AProc.Params do
   begin
    ParamByName('icodcad').AsInteger := AData.FindValue('CADASTRADO');
    ParamByName('idathis').AsString := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');
    ParamByName('inovo_foco').AsInteger := AData.FindValue('NOVOFOCO');
    ParamByName('imanter_circulo').AsString := TDataConverter.ToBoleanString(AData.FindValue('MANTERCIRCULO'));
    ParamByName('iusures').Value := AData.FindValue('USUARIO');

    if Trim(AData.FindValue('OBSERVACAO')) = '' then
      ParamByName('iobshis').Clear
    else
      ParamByName('iobshis').Value := AData.FindValue('OBSERVACAO');
   end;

 //Inicia uma nova transação
   TD := AProc.SQLConnection.BeginTransaction;
   AProc.Prepared := True;
   AProc.ExecProc;
   AProc.SQLConnection.CommitFreeAndNil(TD);

   ReturnCode := 0; //Sucesso.
   CosmosServices.RegisterLog(TCosmosInfoMsg.TransferenciaRegistrada, DAOServices.GetContextInfo(AProc));
   AData.Free;


 except
  on E: Exception do
   begin
     CosmosServices.RegisterLog(E.Message, DAOServices.GetContextInfo(AProc), leOnError);
     ReturnCode := TCosmosErrorCodes.ExecuteOperation; //Falha genérica.

     if E.Message.Contains('EX_CADASTRADO_INEXISTE') then //Não foi encontrado o cadastrado.
       ReturnCode := TCosmosErrorCodes.CannotFindCadastrado;

     if E.Message.Contains('EX_TRANSF_ILEGAL') then //O cadastrado já está vinculado ao novo foco.
       ReturnCode := TCosmosErrorCodes.TransferenciaMesmoFoco;

     if E.Message.Contains('EX_FOCO_INVALIDO') then //O tipo do novo foco não foi determinado.
       ReturnCode := TCosmosErrorCodes.UnknownFocusType;

     if E.Message.Contains('EX_TRANSF_ALUNO_FOCO') then //Um aluno não pode se vincular a uma sala/local do TP ou a um C.C.
       ReturnCode := TCosmosErrorCodes.TransferenciaInvalidaAluno;

     if E.Message.Contains('EX_TRANSF_JOVEMTM_FOCO') then //Um jovem do TM não pode se vincular a uma sala/local do TP ou a um C.C.!      begin
       ReturnCode := TCosmosErrorCodes.TransferenciaInvalidaAluno;

     if E.Message.Contains('EX_TRANSF_PESQUISADOR_FOCO') then //Um pesquisador ou cursista não pode se vincular a um C.C.!
       ReturnCode := TCosmosErrorCodes.TransferenciaInvalidaPesquisador;

     if E.Message.Contains('EX_CADASTRADO_DESLIGADO') then
       ReturnCode := TCosmosErrorCodes.CadastradoDesligado;

     if E.Message.Contains('EX_CADASTRADO_FALECIDO') then
       ReturnCode := TCosmosErrorCodes.CadastradoFalecido;

     AProc.SQLConnection.RollbackFreeAndNil(TD);

     if Assigned(AData) then FreeAndNil(AData);
     if Assigned(AProc) then FreeAndNil(AProc);

     raise TDBXError.Create(ReturnCode, TCosmosErrorCodes.ToMessage(ReturnCode));
   end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.ReativarCadastrado(Data: OleVariant;
  out ReturnCode: integer);
var
AData: TCosmosData;
ADate: Extended;
TD: TDBXTransaction;
AProc: TSQLStoredProc;
begin
 //Reativa um cadastrado desligado.

 AData := TCosmosData.Create(6);
 AProc := DAOServices.CreateStoreProcedure;

 try
  AData.LoadTaggedValues(Data);
  ADate := AData.FindValue('DATA');
  AProc.StoredProcName := TProceduresNames.PROC_RELIGAR_CADASTRADO;

  with AProc.Params do
   begin
    ParamByName('icodcad').AsInteger := AData.FindValue('CADASTRADO');
    ParamByName('icoddis').AsInteger := ADATA.FindValue('DISCIPULADO');
    ParamByName('idathis').Value := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');
    ParamByName('ideseve').Value := ADATA.FindValue('DESCRICAO');
    ParamByName('iusures').Value := AData.FindValue('USUARIO');

    if Trim(AData.FindValue('OBSERVACAO')) = '' then
      ParamByName('iobshis').Clear
    else
      ParamByName('iobshis').Value := AData.FindValue('OBSERVACAO');
   end;

 //Inicia uma nova transação
  TD := AProc.SQLConnection.BeginTransaction;
  AProc.Prepared := True;
  AProc.ExecProc;

  AProc.SQLConnection.CommitFreeAndNil(TD);
  CosmosServices.RegisterLog(TCosmosInfoMsg.ReligamentoRegistrado, DAOServices.GetContextInfo(AProc));
  ReturnCode := 0;

  AProc.Free;
  AData.Free;

 except
  on E: Exception do
   begin
     CosmosServices.RegisterLog(E.Message, DAOServices.GetContextInfo(AProc), leOnError);
     ReturnCode := TCosmosErrorCodes.ExecuteOperation; //Falha genérica.

    if E.Message.Contains('EX_CADASTRADO_INEXISTE') then
     ReturnCode := TCosmosErrorCodes.CannotFindCadastrado;

    if E.Message.Contains('EX_CADASTRADO_FALECIDO') then
     ReturnCode := TCosmosErrorCodes.CadastradoFalecido;

    AProc.SQLConnection.RollbackFreeAndNil(TD);
    if Assigned(AData) then FreeAndNil(AData);
    if Assigned(AProc) then FreeAndNil(AProc);
    raise TDBXError.Create(ReturnCode, TCosmosErrorCodes.ToMessage(ReturnCode));
   end;
 end;
end;

function TCosmosSecHistoricoServerMethods.GetDiscipuladosAnteriores(coddis: Integer;
  indtmo, indtpu, indsim, incatu: boolean): TDBXReader;
var
 sCommand, sindtmo, sindtpu, sindsim, sincatu: string;
 ACommand: TDBXCommand;
begin
 //Lista os discipulares anteriores ao discipulado passado em parâmetro.
 sindtmo := TDataConverter.ToBoleanString(indtmo, True);
 sindtpu := TDataConverter.ToBoleanString(indtpu, True);
 sindsim := TDataConverter.ToBoleanString(indsim, True);
 sincatu := TDataConverter.ToBoleanString(incatu, True);

 sCommand := Format(TSecHistoricoCmd.DiscipuladosAnteriores, [coddis, sindtmo, sindtpu, sindsim, sincatu]);
 ACommand := DAOServices.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DbxSQL;
  ACommand.Text := sCommand;
  Result := ACommand.ExecuteQuery;

 except
  on E: TDBXError do
   begin
     CosmosServices.RegisterLog(E.Message, sCommand, leOnError);
     if Assigned(ACommand) then  FreeAndNil(ACommand);
     raise TDBXError.Create(TCosmosErrorCodes.SelectData, TCosmosErrorMsg.SelectData);
   end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.RetrogradarAluno(Data: OleVariant;
  out ReturnCode: integer);
var
TD: TDBXTransaction;
AData: TCosmosData;
ADate: Extended;
AProc: TSQLStoredProc;
//AValue: string;
begin
 //Retrograda um aluno para outro discipulado anterior ao atual.
 AData := TCosmosData.Create(7);
 AProc :=  DAOServices.CreateStoreProcedure;

 try
  AData.LoadTaggedValues(Data);
//  AValue := AData.FindValue('DATA');
//  outputdebugstring(PWideChar(AValue));
  ADate := AData.FindValue('DATA');
  AProc.StoredProcName := TProceduresNames.PROC_RETROGRADAR_CADASTRADO;

  with AProc.Params do
   begin
    ParamByName('icodcad').AsInteger := AData.FindValue('CADASTRADO');
    ParamByName('idathis').Value := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');
    ParamByName('icoddis').AsInteger := AData.FindValue('DISCIPULADO');
    ParamByName('imotivo').Value := AData.FindValue('MOTIVO');
    ParamByName('ideseve').AsString := AData.FindValue('DESCRICAO');
    ParamByName('iusures').AsString := AData.FindValue('USUARIO');

    if Trim(AData.FindValue('OBSERVACAO')) = '' then
      ParamByName('iobshis').Clear
    else
      ParamByName('iobshis').Value := AData.FindValue('OBSERVACAO');
   end;

 //Inicia uma nova transação
   TD := AProc.SQLConnection.BeginTransaction;
   AProc.ExecProc;
   AProc.SQLConnection.CommitFreeAndNil(TD);

   ReturnCode := 0; //Sucesso.
   CosmosServices.RegisterLog(TCosmosInfoMsg.RetrogradacaoRegistrada, DAOServices.GetContextInfo(AProc));

   AProc.Free;
   AData.Free;

 except
  on E: Exception do
   begin
     CosmosServices.RegisterLog(E.Message, DAOServices.GetContextInfo(AProc), leOnError);
     ReturnCode := TCosmosErrorCodes.ExecuteOperation; //Falha genérica.

    if E.Message.Contains('EX_CADASTRADO_INEXISTE') then
     ReturnCode := TCosmosErrorCodes.CannotFindCadastrado;

    if E.Message.Contains('EX_CADASTRADO_DESLIGADO') then
     ReturnCode := TCosmosErrorCodes.CadastradoDesligado;

    if E.Message.Contains('EX_CADASTRADO_FALECIDO') then
     ReturnCode := TCosmosErrorCodes.CadastradoFalecido;

    if E.Message.Contains('EX_RETROGRADACAO_ILEGAL') then
     ReturnCode := TCosmosErrorCodes.RetrogradacaoIlegal;

    AProc.SQLConnection.RollbackFreeAndNil(TD);
    if Assigned(AData) then FreeAndNil(AData);
    if Assigned(AProc) then FreeAndNil(AProc);

    raise TDBXError.Create(ReturnCode, TCosmosErrorCodes.ToMessage(ReturnCode));
   end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.BatizarCadastrado(Data: OleVariant;
 out ReturnCode: integer);
var
TD: TDBXTransaction;
AData: TCosmosData;
ADate: Extended;
AProc: TSQLStoredProc;
begin
 //Registra o batismo de um cadastrado.
 AData := TCosmosData.Create(6);
 AProc := DAOServices.CreateStoreProcedure;

 try
  AData.LoadTaggedValues(Data);
  ADate := AData.FindValue('DATA');

  AProc.StoredProcName := TProceduresNames.PROC_BATIZAR_CADASTRADO;

  with AProc.Params do
   begin
    ParamByName('icodcad').AsInteger := AData.FindValue('CADASTRADO');
    ParamByName('idathis').Value := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');;
    ParamByName('ideseve').Value := AData.FindValue('DESCRICAO');
    ParamByName('inumreg').AsInteger := AData.FindValue('REGISTRO');
    ParamByName('iusures').Value := AData.FindValue('USUARIO');

    if Trim(AData.FindValue('OBSERVACAO')) = '' then
      ParamByName('iobshis').Clear
    else
      ParamByName('iobshis').Value := AData.FindValue('OBSERVACAO');
   end;

  //Inicia uma nova transação
  TD := AProc.SQLConnection.BeginTransaction;
  AProc.Prepared := True;
  AProc.ExecProc;
  AProc.SQLConnection.CommitFreeAndNil(TD);

  ReturnCode := 0;
  CosmosServices.RegisterLog(TCosmosInfoMsg.BatismoRegistrado, DAOServices.GetContextInfo(AProc));

  AData.Free;
  AProc.Free;

 except
 on E: Exception do
  begin
    ReturnCode := TCosmosErrorCodes.ExecuteOperation; //Falha genérica.
    CosmosServices.RegisterLog(E.Message, DAOServices.GetContextInfo(AProc), leOnError);

   if Pos('EX_BATIZADO_DISCIPULADO', E.Message) > 0 then //Somente probatórios em diante podem ser batizados...
     ReturnCode := TCosmosErrorCodes.BatizadoDiscipulado;

   if Pos('EX_BATIZADO_IDADE', E.Message) > 0 then //Somente podem ser batizados alunos com até 28 anos...
     ReturnCode := TCosmosErrorCodes.BatizadoIdade;

   if Pos('EX_BATIZADO_ILEGAL', E.Message) > 0 then //Somente podem ser batizados alunos e crianças do TM...
     ReturnCode := TCosmosErrorCodes.BatizadoCampo;

    if Assigned(AData) then FreeAndNil(AData);
    AProc.SQLConnection.RollbackFreeAndNil(TD);

    if Assigned(AProc) then  FreeAndNil(AProc);
    raise TDBXError.Create(ReturnCode, TCosmosErrorCodes.ToMessage(ReturnCode));
  end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.CasarCadastrados(Data: OleVariant;
  out ReturnCode: integer);
var
TD: TDBXTransaction;
AData: TCosmosData;
ADate: Extended;
AProc: TSQLStoredProc;
begin
 //Registra o casamento de cadastrados.
 AData := TCosmosData.Create(8);
 AProc := DAOServices.CreateStoreProcedure;

 try
  AData.LoadTaggedValues(Data);
  ADate := AData.FindValue('DATA');
  AProc.StoredProcName := TProceduresNames.PROC_CASAR_CADASTRADOS;

  with AProc.Params do
   begin
    ParamByName('icodcad1').AsInteger := AData.FindValue('NOIVA');
    ParamByName('icodcad2').AsInteger := AData.FindValue('NOIVO');
    ParamByName('icodfoc').Value := AData.FindValue('FOCO');
    ParamByName('idathis').Value := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');
    ParamByName('inumreg').AsInteger := AData.FindValue('REGISTRO');
    ParamByName('ideseve').Value := AData.FindValue('DESCRICAO');
    ParamByName('iusures').Value := AData.FindValue('USUARIO');

    if Trim(AData.FindValue('OBSERVACAO')) = '' then
      ParamByName('iobshis').Clear
    else
      ParamByName('iobshis').Value := AData.FindValue('OBSERVACAO');
   end;

  TD := AProc.SQLConnection.BeginTransaction;
  AProc.Prepared := True;
  AProc.ExecProc;

  AProc.SQLConnection.CommitFreeAndNil(TD);

  ReturnCode := 0; //sucesso.
  CosmosServices.RegisterLog(TCosmosInfoMsg.CasamentoRegistrado, DAOServices.GetContextInfo(AProc));
  AData.Free;
  AProc.Free;

 except
  on E: Exception do
   begin
    ReturnCode := TCosmosErrorCodes.ExecuteOperation;

    if E.Message.Contains('EX_CADASTRADO_CASADO') then
      ReturnCode := TCosmosErrorCodes.CasarCasado;

    CosmosServices.RegisterLog(E.Message, DAOServices.GetContextInfo(AProc), leOnError);
    AProc.SQLConnection.RollbackFreeAndNil(TD);

    if Assigned(AData) then FreeAndNil(AData);
    if Assigned(AProc) then FreeAndNil(AProc);
    raise TDBXError.Create(ReturnCode, TCosmosErrorCodes.ToMessage(ReturnCode));
   end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.EnviarCartaFrequencia(Data: OleVariant;
  out ReturnCode: integer);
var
TD: TDBXTransaction;
AData: TCosmosData;
ADate: Extended;
AProc: TSQLStoredProc;
begin
 //Registra o envio de cartas de freqüência para um aluno.
 AData := TCosmosData.Create(5);
 AProc := DAOServices.CreateStoreProcedure;

 try
  AData.LoadTaggedValues(Data);
  ADate := AData.FindValue('DATA');
  AProc.StoredProcName := TProceduresNames.PROC_ENVIAR_CARTA_FREQUENCIA;

  with AProc.Params do
   begin
    ParamByName('icodcad').AsInteger := AData.FindValue('CADASTRADO');
    ParamByName('idathis').Value := TDataConverter.ToFormatedDateTime(ADate, 'yyyy/mm/dd');
    ParamByName('ideseve').Value := AData.FindValue('DESCRICAO');
    ParamByName('iusures').Value := AData.FindValue('USUARIO');

    if Trim(AData.FindValue('OBSERVACAO')) = '' then
      ParamByName('iobshis').Clear
    else
      ParamByName('iobshis').Value := AData.FindValue('OBSERVACAO');
   end;

  TD := AProc.SQLConnection.BeginTransaction;
  AProc.Prepared := True;
  AProc.ExecProc;

  AProc.SQLConnection.CommitFreeAndNil(TD);
  CosmosServices.RegisterLog(TCosmosInfoMsg.CartaFrequenciaRegistrada, DAOServices.GetContextInfo(AProc));
  ReturnCode := 0;
  AData.Free;
  AProc.Free;

 except
  on E: Exception do
   begin
     CosmosServices.RegisterLog(E.Message, DAOServices.GetContextInfo(AProc), leOnError);
     ReturnCode := TCosmosErrorCodes.ExecuteOperation; //Falha genérica.

    if E.Message.Contains('EX_CARTA_FREQUENCIA') then //do not localize!
      ReturnCode := TCosmosErrorCodes.CartaFrequenciaCampo;

    if E.Message.Contains('EX_CADASTRADO_INEXISTE') then  //do not localize!
     ReturnCode := TCosmosErrorCodes.CannotFindCadastrado;

    if E.Message.Contains('EX_CADASTRADO_DESLIGADO') then //do not localize!
     ReturnCode := TCosmosErrorCodes.CadastradoDesligado;

    if E.Message.Contains('EX_CADASTRADO_FALECIDO') then //do not localize!
     ReturnCode := TCosmosErrorCodes.CadastradoFalecido;

    AProc.SQLConnection.RollbackFreeAndNil(TD);
    if Assigned(AData) then FreeAndNil(AData);
    if Assigned(AProc) then FreeAndNil(AProc);
    raise TDBXError.Create(ReturnCode, TCosmosErrorCodes.ToMessage(ReturnCode));
   end;
 end;
end;

function TCosmosSecHistoricoServerMethods.GetCosmosService: ICosmosService;
begin
 Result := self.FCosmosServiceFactory.CosmosService;
end;

function TCosmosSecHistoricoServerMethods.GetDAOServices: ICosmosDAOService;
begin
 Result := self.FCosmosDAOServiceFactory.DAOService;
end;

function TCosmosSecHistoricoServerMethods.GetDiscipuladoCadastrado(codcad: Integer): TDataset;
var
ADataset: TSQLDataset;
aCommand: string;
begin
 //Retorna o discipulado de um cadastrado.
 aCommand := Format(TSecretariasCommands.DiscipuladoCadastrado, [codcad]);

 try

  ADataset := DAOServices.DoExecuteDQL(aCommand);
  Result := ADataset;

 except
  on E: TDBXError do
   begin
    Result := nil;
    CosmosServices.RegisterLog(E.Message, aCommand, leOnError);
   end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.AtualizaGruposTM(codfoc: Integer);
var
 CurrentUserName: string;
begin
//Atualiza os grupos de jovens do TM de acordo com a idade deles.
 try
   CurrentUserName := CosmosServices.DSService.ConnectedUser.ToUpper;
   CurrentUserName := CurrentUserName.QuotedString;
   DAOServices.DoExecuteCommand(Format(TSecHistoricoCmd.AtualizaGruposTM, [codfoc, CurrentUserName]));

 except
  on E: Exception do
   begin
    CosmosServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.AtualizarGruposTM, TCosmosErrorMsg.AtualizarGruposTM);
   end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.AnularEventoHistorico(codhis: Integer;
  const sigdis, current_user: WideString);
var
TD: TDBXTransaction;
AProc: TSQLStoredProc;
begin
//Anula um evento do histórico discipular de um cadastrado
 AProc := DAOServices.CreateStoreProcedure;

 try
  AProc.StoredProcName := TProceduresNames.PROC_ANULAR_EVENTO_DISCIPULAR;

  with AProc do
   begin
    Params.Items[0].Value := codhis;
    Params.Items[1].Value := sigdis;
    Params.Items[2].Value := current_user;
   end;

  TD := AProc.SQLConnection.BeginTransaction;
  AProc.Prepared := True;
  AProc.ExecProc;
  AProc.SQLConnection.CommitFreeAndNil(TD);

 except
 on E: Exception do
  begin
   CosmosServices.RegisterLog(E.Message, '', leOnError);
   AProc.SQLConnection.RollbackFreeAndNil(TD);
   raise TDBXError.Create(TCosmosErrorCodes.AnularHistorico, TCosmosErrorSecMsg.AnularHistorico);
  end;
 end;
end;

function TCosmosSecHistoricoServerMethods.GetDiscipuladosReligacao(codcad: Integer): TDataset;
var
 sCommand: string;
 ADataset: TSQLDataset;
begin
 //Recupera os discipulados nos quais um cadastrado pode ser religado
 sCommand := Format(TSecHistoricoCmd.DiscipuladosReligacao, [codcad]);

 try
  ADataset := DAOServices.DoExecuteDQL(sCommand);
  Result := ADataset;

 except
 on E: TDBXError do
  begin
   CosmosServices.RegisterLog(E.Message, ADataset.CommandText, leOnError);
   raise;
  end;
 end;
end;

function TCosmosSecHistoricoServerMethods.GenNumeroTurmaInst(codfoc: Integer): string;
var
 ADataset: TSQLDataset;
begin
//Gera um novo número da turma de instalação.
 try
  ADataset := DAOServices.DoExecuteDQL(Format(TSecHistoricoCmd.NumeroTurmaInstalacao, [codfoc]));
  Result :=  ADataset.Fields.Fields[0].Value;

 except
 on E: Exception do
  begin
   Result := '';
   CosmosServices.RegisterLog(E.Message, '', leOnError);
   raise TDBXError.Create(TCosmosErrorCodes.NumeroTurmaInstalacao, TCosmosErrorSecMsg.NumeroTurmaInstalacao);
  end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.CreateTurmaInst(const numtur: WideString; codfoc,
  coddis: Integer; memtur: OleVariant; UserName: string);
var
AScript: TStringList;
codturins, codcad: integer;
ADataset: TClientDataset;
sCommandText: string;
begin
//Cria uma nova turma de instalação com seus membros.
 AScript := TStringList.Create;
 ADataset := TClientDataset.Create(self);

 try
  codturins := DAOServices.DoGetSequenceValue(TSequencesNames.GEN_TURMAS_INSTALACOES);
  sCommandText := Format(TSecHistoricoCmd.InserirTurmasInstalacao, [codturins, QuotedStr(numtur),
    codfoc, coddis, QuotedStr('N'), QuotedStr(UserName)]);
  AScript.Append(sCommandText);

  ADataset.Data := memtur;

  while not ADataset.Eof do
   begin
    codcad := ADataset.Fields.FieldByName('codcad').AsInteger;
    sCommandText := Format(TSecHistoricoCmd.InserirMembrosTurmasIns, [codturins, codcad]);
    AScript.Append(sCommandText);

    ADataset.Next;
   end;

  DAOServices.DoExecuteScript(AScript);

  if Assigned(AScript) then AScript.Free;
  if Assigned(ADataset) then ADataset.Free;

 except
 on E: Exception do
  begin
   CosmosServices.RegisterLog(E.Message, AScript.Text, leOnError);
   E.Message := TCosmosErrorSecMsg.CreateTurmaInstalacao;
   if Assigned(AScript) then AScript.Free;
   if Assigned(ADataset) then ADataset.Free;
   raise TDBXError.Create(TCosmosErrorCodes.CreateTurmaInstalacao, TCosmosErrorSecMsg.CreateTurmaInstalacao);
  end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.DropInstalando(codturins, codcad: Integer);
var
AScript: TStringList;
begin
{Deleta um membro de uma turma de instalação e retira os dados do protocolo
 de instalação que foi inserido no histórico discipular quando da criação
 da turma de instalação.}
  AScript := TStringList.Create;

  try
   with AScript do
    begin
     Append(Format(TSecHistoricoCmd.DelInstalando, [codturins, codcad]));
     Append(Format(TSecHistoricoCmd.DelProtocoloInstalando, [codcad, codturins]));
    end;

   DAOServices.DoExecuteScript(AScript);

   AScript.Free;

  except
   on E: Exception do
    begin
     CosmosServices.RegisterLog(E.Message, AScript.Text, leOnError);
     if Assigned(AScript) then AScript.Free;
     raise TDBXError.Create(TCosmosErrorCodes.DelMembroTurmaInstalacao, TCosmosErrorSecMsg.DelMembroTurmaInstalacao);
  end;
 end;
end;

procedure TCosmosSecHistoricoServerMethods.InstalarTurmaAlunos(codturins: Integer;
  datins: TDateTime; current_user: WideString);
var
AScript: TStringList;
aDataset: TSQLDataset;
coddis, codcad, codfoc: integer;
Data, sCommand: string;
begin
{Instala os alunos de uma turma de instalação em seus discipulados.}
  AScript := TStringList.Create;

  try
   //Primeiro, checa se a turma já está instalada.
   sCommand := Format(TSecHistoricoCmd.TurmaInstalada, [codturins]);
   ADataset := DAOServices.DoExecuteDQL(sCommand);

   if TDataConverter.ToBolean(ADataset.FieldValues['indins']) then
    raise TDBXError.Create(TCosmosErrorCodes.TurmaInstalada, TCosmosErrorSecMsg.TurmaInstalada);

   sCommand := Format(TSecHistoricoCmd.TurmaInstalacao, [codturins]);
   ADataset := DAOServices.DoExecuteDQL(sCommand);

   coddis := ADataset.Fields.FieldByName('coddis').AsInteger;
   codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;

   Data := FormatDateTime('yyyy/mm/dd', datins);

  //Agora, recupera os membros da turma para montar o script que os instalará.
   sCommand := Format(TSecHistoricoCmd.MembrosTurmaInstalacao, [codturins]);
   ADataset := DAOServices.DoExecuteDQL(sCommand);

   while not aDataset.Eof do
    begin
      codcad := aDataset.FieldValues['codcad'];
      sCommand := Format(TSecHistoricoCmd.InstalarAluno, [coddis, codcad, codfoc, codturins, QuotedStr(Data), QuotedStr('N'), QuotedStr(current_user)]);
      AScript.Append(sCommand);

      aDataset.Next;
    end;

   //Agora, marca a turma como instalada..
   sCommand := Format(TSecHistoricoCmd.FecharTurmaIns, [QuotedStr('S'), QuotedStr(current_user), codturins]);
   AScript.Append(sCommand);

   //Finalmente, executa o AScript
   DAOServices.DoExecuteScript(AScript);

  if Assigned(AScript) then AScript.Free;
  if Assigned(ADataset) then ADataset.Free;

  except
   on E: TDBXError do
    begin
     CosmosServices.RegisterLog(E.Message, AScript.Text, leOnError);
     if Assigned(AScript) then AScript.Free;
     if Assigned(ADataset) then ADataset.Free;
     raise;
    end;
   on E: Exception do
    begin
     CosmosServices.RegisterLog(E.Message, AScript.Text, leOnError);
     if Assigned(AScript) then AScript.Free;
     if Assigned(ADataset) then ADataset.Free;
     raise TDBXError.Create(TCosmosErrorCodes.InstalarTurmaAluno, TCosmosErrorSecMsg.InstalarTurmaAluno);
    end;
 end;
end;

function TCosmosSecHistoricoServerMethods.NovaMatricula(codfoc: integer;
  CampoTrabalho, CreationMode: integer): string;
var
sCampoTrabalho, sCommand: string;
ADataset: TSQLDataset;
CosmosApp: TCosmosApplication;
ANumber: integer;
begin
//Retorna um novo número de matrícula de um aluno de um determinado foco.
 CosmosApp := TCosmosApplication.Create;
 ANumber := 0; //default, sempre a partir da última matrícula.

 case TNewMatriculaMode(CreationMode) of
  mmFromLastNumber: ANumber := 0;
  mmEmptyIntervals: ANumber := 1;
 end;

 try
  sCampoTrabalho := TCampoTrabalho(CampoTrabalho).ShortName;
  sCommand := Format(TSecretariasCommands.NovaMatricula,[codfoc, QuotedStr(sCampoTrabalho), ANumber]);

  ADataset := DAOServices.DoExecuteDQL(sCommand);
  Result :=  ADataset.Fields.Fields[0].Value;

  if Assigned(CosmosApp) then FreeAndNil(CosmosApp);

 except
  on E: Exception do
   begin
    if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
    Result := '';
    CosmosServices.RegisterLog(E.Message, sCommand, leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.NovaMatricula, TCosmosErrorSecMsg.NovaMatricula);
   end;
 end;

end;

procedure TCosmosSecHistoricoServerMethods.AdicionarInstalando(codturins, codcad, coddis,
  codfoc: Integer);
var
 sCommand: string;
 ADataset: TSQLDataset;
begin
//Adiciona um novo instalando a uma turma de instalação.
 sCommand := Format(TSecretariasCommands.DadosBasicosCadastrado, [codcad]);

 try
  //Obtém informações do cadastrado a serem usadas em algumas validações.
  ADataset := DAOServices.DoExecuteDQL(sCommand);

  //Se o cadastrado não está ativo, gera uma exceção.
  if not TDataConverter.ToBolean(ADataset.FieldValues['indati']) then
   raise EDataOperationError.Create('');

  sCommand := sCommand.Format(TSecHistoricoCmd.InserirMembrosTurmasIns, [codturins, codcad]);

  DAOServices.DoExecuteCommand(sCommand);
  if Assigned(ADataset) then FreeAndNil(ADataset);


 except
  on E: EDataOperationError do
   begin
    CosmosServices.RegisterLog(E.Message, sCommand,  leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.InstalacaoInvalida, TCosmosErrorSecMsg.InstalacaoInvalida);
   end;
  on E: Exception do
   begin
    CosmosServices.RegisterLog(E.Message, sCommand,  leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.NovoInstalando, TCosmosErrorSecMsg.NovoInstalando);
   end;
 end;
end;


end.

