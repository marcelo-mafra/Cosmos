unit cosmos.servers.secretarias.tp.methods;

interface

uses
  Windows, Messages, System.SysUtils, System.StrUtils, System.Classes,
  System.Json, Datasnap.DSServer, DataSnap.DSProviderDataModuleAdapter,
  Datasnap.DSAuth, DBClient, DB, SqlExpr, FMTBcd, SQLScript,
  cosmos.classes.application, Variants, Provider, cosmos.classes.logs,
  cosmos.classes.ServerInterface, cosmos.classes.arrayutils, cosmos.servers.sqlcommands,
  cosmos.framework.interfaces.utils, cosmos.classes.security, WideStrings,
  DBXFirebird, dbxCommon, cosmos.classes.dataobjects, cosmos.core.classes.FieldsInfo,
  cosmos.system.exceptions, cosmos.system.messages, Datasnap.DSSession;

type

  TCosmosSecTPServerMethods = class(TDSServerModule)
    SQLTurmasTP: TSQLDataSet;
    SQLTurmasTPCODTUR: TIntegerField;
    SQLTurmasTPCODFOC: TIntegerField;
    SQLTurmasTPNUMTUR: TIntegerField;
    SQLTurmasTPDATCRE: TDateField;
    DspTurmasTP: TDataSetProvider;
    SQLCursistas: TSQLDataSet;
    DspCursistas: TDataSetProvider;
    SQLCursistasCODMEM: TIntegerField;
    SQLCursistasCODTUR: TIntegerField;
    SQLCursistasCODCAD: TIntegerField;
    SQLCursistasMATCAD: TStringField;
    SQLCursistasNOMCAD: TStringField;
    SQLCursistasAPECAD: TStringField;
    SQLTurmasTPindenc: TStringField;
    SQLPesquisadores: TSQLDataSet;
    DspPesquisadores: TDataSetProvider;
    SQLPesquisadoresCODCAD: TIntegerField;
    SQLPesquisadoresMATCAD: TStringField;
    SQLPesquisadoresNOMCAD: TStringField;
    SQLPesquisadoresAPECAD: TStringField;
    SQLPesquisadoresSIGDIS: TStringField;
    SQLPesquisador: TSQLDataSet;
    SQLPesquisadorCODCAD: TIntegerField;
    SQLPesquisadorMATCAD: TStringField;
    SQLPesquisadorNOMCAD: TStringField;
    SQLPesquisadorAPECAD: TStringField;
    SQLPesquisadorSIGDIS: TStringField;
    DspPesquisador: TDataSetProvider;
    SQLPesquisadorSEXCAD: TStringField;
    SQLPesquisadorDATNAS: TDateField;
    SQLPesquisadorNACCAD: TStringField;
    SQLPesquisadorDOCIDE: TStringField;
    SQLPesquisadorORGEXP: TStringField;
    SQLPesquisadorCODFOC: TIntegerField;
    SQLPesquisadorSIGFOC: TStringField;
    SQLPesquisadorCODDIS: TIntegerField;
    SQLPesquisadorINDEXTNUC: TStringField;
    SQLPesquisadorINDATI: TStringField;
    SQLPesquisadorINDPRECON: TStringField;
    SQLPesquisadorDATCAD: TSQLTimeStampField;
    SQLPesquisadorUSURES: TStringField;
    SQLPesquisadoresINDATI: TStringField;
    SQLPesquisadorCONESC: TSmallintField;
    SQLPesquisadoresMATCADINT: TIntegerField;
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
    SQLTurmasTPDATENC: TDateField;
    SQLPesquisadoresDATNAS: TDateField;
    SQLPesquisadoresSEXCAD: TStringField;
    SQLPesquisadoresINDESCINT: TStringField;
    SQLPesquisadoresSIGFOC: TStringField;
    SQLPesquisadorOBSCAD: TMemoField;
    SQLAtividadesTurma: TSQLDataSet;
    DspAtividadesTurma: TDataSetProvider;
    SQLAtividadesTurmaDESTIPATI: TStringField;
    SQLAtividadesTurmaDATATI: TDateField;
    SQLAtividadesTurmaHORATI: TTimeField;
    SQLAtividadesTurmaNUMTEM: TSmallintField;
    SQLAtividadesTurmaSIGFOC: TStringField;
    SQLSimpatizante: TSQLDataSet;
    DspSimpatizante: TDataSetProvider;
    SQLSimpatizanteCODCAD: TIntegerField;
    SQLSimpatizanteNOMCAD: TStringField;
    SQLSimpatizanteSEXCAD: TStringField;
    SQLSimpatizanteDATNAS: TDateField;
    SQLSimpatizanteNACCAD: TStringField;
    SQLSimpatizanteDOCIDE: TStringField;
    SQLSimpatizanteORGEXP: TStringField;
    SQLSimpatizanteCODFOC: TIntegerField;
    SQLSimpatizanteCODDIS: TIntegerField;
    SQLSimpatizanteINDATI: TStringField;
    SQLSimpatizanteCONESC: TSmallintField;
    SQLSimpatizanteFOTCAD: TBlobField;
    SQLSimpatizanteOBSCAD: TMemoField;
    SQLSimpatizanteDATCAD: TSQLTimeStampField;
    SQLSimpatizanteUSURES: TStringField;
    SQLSimpatizanteCODPRO: TIntegerField;
    SQLSimpatizanteDESPRO: TStringField;
    SQLPesquisadoresAlfa: TSQLDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    DateField1: TDateField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    IntegerField2: TIntegerField;
    DspPesquisadoresAlfa: TDataSetProvider;
    SQLPesquisadoresDisc: TSQLDataSet;
    IntegerField3: TIntegerField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    DateField2: TDateField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    IntegerField4: TIntegerField;
    DspPesquisadoresDisc: TDataSetProvider;
    SQLSimpatizantesAlfa: TSQLDataSet;
    IntegerField5: TIntegerField;
    StringField17: TStringField;
    StringField18: TStringField;
    StringField19: TStringField;
    DateField3: TDateField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    StringField24: TStringField;
    IntegerField6: TIntegerField;
    DspSimpatizantesAlfa: TDataSetProvider;
    procedure DspCartasGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspPesquisadorGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspCursistasGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure SQLTurmasTPBeforeOpen(DataSet: TDataSet);
    procedure DspPesquisadorGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspSimpatizanteUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure DspPesquisadorUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }
    function GetDiscipuladoSimpatizante: integer;

  public
    { Public declarations }
    function NovaTurmaTP(Foco: Integer; const Membros: OleVariant): boolean;
    procedure DeleteTurmaTP(codtur: Integer);
    function ReativarTurmaTP(codtur: Integer): boolean;
    function EncerrarTurmaTP(codtur: Integer): boolean;
    function GetNextTurmaTPID(codfoc: Integer): Integer;

  end;

 

implementation

uses {cosmos.servers.sqlcommands,} cosmos.system.winshell,
  cosmos.servers.common.dataacess,  cosmos.servers.common.services;

{$R *.DFM}



procedure TCosmosSecTPServerMethods.DspCartasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_HISTORICOS, False]);
end;

procedure TCosmosSecTPServerMethods.DspCursistasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_MEMBROS_TURMAS, False]);
end;

procedure TCosmosSecTPServerMethods.DspPesquisadorGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CADASTRADOS, False]);
end;

procedure TCosmosSecTPServerMethods.DspPesquisadorGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CADASTRADOS;
end;

procedure TCosmosSecTPServerMethods.DspPesquisadorUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TCosmosSecTPServerMethods.DspSimpatizanteUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
 if Dataset.UpdateStatus = usInserted  then
  begin
   Dataset.Edit;
   Dataset.Fields.FieldByName('coddis').Value := self.GetDiscipuladoSimpatizante;
   Dataset.Post;
  end;
end;

procedure TCosmosSecTPServerMethods.SQLTurmasTPBeforeOpen(DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

function TCosmosSecTPServerMethods.GetDiscipuladoSimpatizante: integer;
var
 ADataset: TSQLDataset;
begin
 ADataset := DMServerDataAcess.CreateDataset;
 ADataset.CommandText := Format(TDQLCommand.CodigoDiscipulado, [QuotedStr('SIM'), QuotedStr('SIM')]);

 try
  ADataset.Open;
  Result := ADataset.Fields.FieldByName('coddis').AsInteger;

 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TCosmosSecTPServerMethods.GetNextTurmaTPID(codfoc: Integer): Integer;
var
 ADataset: TSQLDataset;
 ACommand: string;
begin
//Retorna o próximo número da turma de cursistas de um foco.
 Result := 0; //default, tratado como erro.

 ACommand := Format(TSecretariasTPCommands.MaxTurmas_TP, [codfoc]);

 try
  ADataset := DMServerDataAcess.DoExecuteDQL(ACommand);
  if not ADataset.Fields.Fields[0].IsNull then
   Result := ADataset.Fields.Fields[0].Value + 1
  else
   Result := 1;

  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);

    raise TDBXError.Create(TCosmosErrorCodes.NumeroNovaTurmaTP, TCosmosErrorMsg.NumeroNovaTurmaTP);
   end;
 end;
end;

function TCosmosSecTPServerMethods.NovaTurmaTP(Foco: Integer; const Membros: OleVariant): boolean;
var
TurmaID: integer;
AScript: TStringList;
ADataset: TClientDataset;
ACommand: string;
begin
//Insere uma nova turma do TP e os membros da turma.
 Result := False;
 ADataset := TClientDataset.Create(self);
 AScript := TStringList.Create;

 try
  ADataset.Data := Membros;
  TurmaID := DMServerDataAcess.DoGetSequenceValue(TSequencesNames.GEN_TURMASTP);

  if TurmaID > 0 then
   begin
    ACommand := Format(TSecretariasTPCommands.InsTurmaTP, [TurmaID, Foco]);
    AScript.Append(ACommand);

    while not ADataset.Eof do
     begin
      ACommand := Format(TSecretariasTPCommands.InsMembrosTurmasTP, [TurmaID, ADataset.Fields.FieldByName('codcad').AsInteger]);
      AScript.Append(ACommand);
      ADataset.Next;
     end;

    Result := DMServerDataAcess.DoExecuteScript(AScript);
   end;

  if Assigned(ADataset) then ADataset.Free;
  if Assigned(AScript) then AScript.Free;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.NovaTurmaTP, TCosmosErrorMsg.NovaTurmaTP);
   end;
 end;
end;

function TCosmosSecTPServerMethods.EncerrarTurmaTP(codtur: Integer): boolean;
var
 ACommand, Datenc: string;
begin
//Encerra uma turma de cursistas do TP.
 Datenc := TDataConverter.ToFormatedSQLDate(Now);
 ACommand := Format(TSecHistoricoCmd.EncerrarTurmaTP, [QuotedStr(datenc), QuotedStr('S'), codtur]);

 try
  Result := DMServerDataAcess.DoExecuteCommand(ACommand) > 0;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.EncerrarTurmaTP, TCosmosErrorSecMsg.EncerrarTurmaTP);
   end;
 end;
end;

function TCosmosSecTPServerMethods.ReativarTurmaTP(codtur: Integer): boolean;
var
 ACommand: string;
begin
//Reativa uma turma de cursitas já encerrada.
 ACommand := Format(TSecHistoricoCmd.ReativarTurmaTP, [QuotedStr('N'), codtur]);

 try
  Result := DMServerDataAcess.DoExecuteCommand(ACommand) >= 0;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.ReativarTurmaTP, TCosmosErrorSecMsg.ReativarTurmaTP);
   end;
 end;
end;

procedure TCosmosSecTPServerMethods.DeleteTurmaTP(codtur: Integer);
var
 ADataset: TSQLDataset;
 ACommand: string;
begin
//Tenta excluir uma turma de cursistas do TP.
 ACommand := Format(TSecretariasTPCommands.CountAtividadesTurmaTP, [codtur]);

 try
  ADataset := DMServerDataAcess.DoExecuteDQL(ACommand);

  if ADataset.Fields.Fields[0].AsInteger = 0 then
   begin
    ACommand := Format(TSecretariasTPCommands.DelTurmaTP, [codtur]);
    DMServerDataAcess.DoExecuteCommand(ACommand);
   end
  else
   raise EDataOperationError.Create(TCosmosErrorMsg.CantDeleteTurmaTP);

  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: EDataOperationError do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.CantDeleteTurmaTP, TCosmosErrorMsg.CantDeleteTurmaTP);
   end;
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.DeleteTurmaTP, TCosmosErrorMsg.DeleteTurmaTP);
   end;
 end;
end;




end.

