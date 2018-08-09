unit cosmos.servers.secretarias.ei.methods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Classes,
  System.Json, Datasnap.DSServer, DataSnap.DSProviderDataModuleAdapter, Datasnap.DSAuth, Datasnap.DBClient, Data.DB, Data.SqlExpr,
  Data.FMTBcd, cosmos.system.types, cosmos.system.messages, cosmos.servers.sqlcommands,
  cosmos.classes.application, System.Variants, Datasnap.Provider, System.WideStrings,
  Datasnap.DSSession, cosmos.system.winshell, cosmos.classes.ServerInterface,
  cosmos.classes.logs, Data.DBXCommon, cosmos.system.exceptions;


type
  TCosmosSecEIServerMethods = class(TDSServerModule)
    SQLLivrosEI: TSQLDataSet;
    DspLivrosEI: TDataSetProvider;
    SQLLivrosEICODLIV: TIntegerField;
    SQLLivrosEINOMLIV: TStringField;
    SQLLivrosEICODDIS: TIntegerField;
    SQLLivrosEIORDLIV: TSmallintField;
    SQLLivrosEINOTLIV: TMemoField;
    SQLLicoesEI: TSQLDataSet;
    DspLicoesEI: TDataSetProvider;
    SQLLicoesEICODLIC: TIntegerField;
    SQLLicoesEINOMLIC: TStringField;
    SQLLicoesEICODLIV: TIntegerField;
    SQLLicoesEIORDLIC: TSmallintField;
    SQLLicoesEINOTLIC: TMemoField;
    SQLLicoesEITITLIC: TStringField;
    SQLStProcedure: TSQLStoredProc;
    SQLCirculosEI: TSQLDataSet;
    DspCirculosEI: TDataSetProvider;
    SQLCirculosEICODGRU: TIntegerField;
    SQLCirculosEINOMGRU: TStringField;
    SQLCirculosEISIGDIS: TStringField;
    SQLCirculosEINOMLIV: TStringField;
    SQLCirculosEINOMLIC: TStringField;
    DspMembrosCirculo: TDataSetProvider;
    SQLMembrosCirculo: TSQLDataSet;
    SQLMembrosCirculoCODMEM: TIntegerField;
    SQLMembrosCirculoCODGRU: TIntegerField;
    SQLMembrosCirculoCODCAD: TIntegerField;
    SQLMembrosCirculoMATCAD: TStringField;
    SQLMembrosCirculoNOMCAD: TStringField;
    SQLMembrosCirculoINDCON: TStringField;
    SQLDadosCirculo: TSQLDataSet;
    DspDadosCirculo: TDataSetProvider;
    SQLDadosCirculoCODGRU: TIntegerField;
    SQLDadosCirculoNOMGRU: TStringField;
    SQLDadosCirculoCODLIC: TIntegerField;
    SQLDadosCirculoNOMLIC: TStringField;
    SQLDadosCirculoSENCON: TStringField;
    SQLDadosCirculoCODSAC: TIntegerField;
    SQLDadosCirculoNOMSAC: TStringField;
    SQLDadosCirculoCODSAZ: TIntegerField;
    SQLDadosCirculoNOMSAZ: TStringField;
    SQLDadosCirculoDATCAD: TSQLTimeStampField;
    SQLDadosCirculoUSURES: TStringField;
    SQLParticipantes: TSQLDataSet;
    SQLParticipantesCODATIDIS: TIntegerField;
    SQLParticipantesCODATI: TIntegerField;
    SQLParticipantesCODDIS: TIntegerField;
    SQLParticipantesNOMDIS: TStringField;
    DspParticipantes: TDataSetProvider;
    SQLMembrosEISearch: TSQLDataSet;
    DspMembrosEISearch: TDataSetProvider;
    SQLFocosParticipantes: TSQLDataSet;
    DspFocosParticipantes: TDataSetProvider;
    SQLFocosParticipantesCODATIFOC: TIntegerField;
    SQLFocosParticipantesCODATI: TIntegerField;
    SQLFocosParticipantesCODFOC: TIntegerField;
    SQLFocosParticipantesNOMFOC: TStringField;
    SQLFocosParticipantesSIGFOC: TStringField;
    SQLDadosCirculoCODDIS: TIntegerField;
    SQLDadosCirculoNOMDIS: TStringField;
    procedure DspDadosCirculoGetData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure DspMembrosCirculoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspLicoesEIGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspLivrosEIGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFocosParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspMembrosCirculoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspParticipantesGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspFocosParticipantesGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure SQLLivrosEIBeforeOpen(DataSet: TDataSet);
    procedure SQLStProcedureBeforeOpen(DataSet: TDataSet);
    procedure DspLivrosEIUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }
    function CanDeleteLesson(const LessonId: integer): boolean;


  public
    { Public declarations }
    function ReorderBook(codbook, codtarget: Integer): boolean;
    function ReorderLesson(codlesson, codtarget: Integer): boolean;
    function DeleteBook(codliv: Integer): boolean;
    function DeleteLesson(codlic: Integer): boolean;

    function NovoCirculo(Circulo, Membros: OleVariant; Usuario: string): boolean;
    function DesativarCirculo(codgru: Integer): boolean;
  end;

var
  CosmosSecEIServerMethods: TCosmosSecEIServerMethods;

implementation

uses cosmos.servers.common.dataacess, cosmos.servers.common.services;

{$R *.DFM}

procedure TCosmosSecEIServerMethods.DspDadosCirculoGetData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
 if not Dataset.Fields.FieldByName('sencon').IsNull then
  begin
   Dataset.Edit;

   try
    Dataset.Fields.FieldByName('sencon').AsString := DMCosmosServerServices.Descriptografar(Dataset.Fields.FieldByName('sencon').AsString);

   finally
    DMServerDataAcess.CloseDataset(DMServerDataAcess.SQLSearch);
   end;

   Dataset.Post;
  end;
end;

procedure TCosmosSecEIServerMethods.DspFocosParticipantesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES_FOCOS, False]);
end;

procedure TCosmosSecEIServerMethods.DspFocosParticipantesGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES_FOCOS;
end;

procedure TCosmosSecEIServerMethods.DspLicoesEIGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_LICOES_EI, False]);
end;

procedure TCosmosSecEIServerMethods.DspLivrosEIGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_LIVROS_EI, False]);
end;

procedure TCosmosSecEIServerMethods.DspLivrosEIUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TCosmosSecEIServerMethods.DspMembrosCirculoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_MEMBROS_GRUPOS_EI, False]);
end;

procedure TCosmosSecEIServerMethods.DspMembrosCirculoGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_MEMBROS_GRUPOS_EI;
end;

procedure TCosmosSecEIServerMethods.DspParticipantesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES_DISCIPULADOS, False]);
end;

procedure TCosmosSecEIServerMethods.DspParticipantesGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES_DISCIPULADOS;
end;

function TCosmosSecEIServerMethods.ReorderBook(codbook, codtarget: Integer): boolean;
begin
//Reordena um livro da Escola Interna.
 try
  with SQLStProcedure do
   begin
    StoredProcName := TProceduresNames.PROC_REORDENAR_LIVRO_LICAO;
    ParamByName('codliv').AsInteger := codbook;
    ParamByName('codlic').Clear;
    ParamByName('codtarget').AsInteger := codtarget;
    Result := ExecProc > 0;
   end;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.ReorderBookEI, TCosmosErrorSecMsg.ReorderBookEI);
   end;
 end;
end;

function TCosmosSecEIServerMethods.ReorderLesson(codlesson, codtarget: Integer): boolean;
begin
//Reordena uma lição da Escola Interna.
 try
  with SQLStProcedure do
   begin
    StoredProcName := TProceduresNames.PROC_REORDENAR_LIVRO_LICAO;
    ParamByName('codliv').Clear;
    ParamByName('codlic').AsInteger := codlesson;
    ParamByName('codtarget').AsInteger := codtarget;
    Result := ExecProc > 0;
   end;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.ReorderLessonEI, TCosmosErrorSecMsg.ReorderLessonEI);
   end;
 end;
end;

procedure TCosmosSecEIServerMethods.SQLLivrosEIBeforeOpen(DataSet: TDataSet);
begin
  TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

procedure TCosmosSecEIServerMethods.SQLStProcedureBeforeOpen(DataSet: TDataSet);
begin
  TSQLStoredProc(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

function TCosmosSecEIServerMethods.NovoCirculo(Circulo, Membros: OleVariant;
   Usuario: string): boolean;
var
CirculoID: integer;
AScript: TStringList;
ADataset: TClientDataset;
ASQLDataset: TSQLDataset;
scodsac, scodsaz, sCommand: string;
begin
 //Insere um novo círculo da E.I. e seus membros.
 ADataset := TClientDataset.Create(self);
 AScript := TStringList.Create;

 try
  //Obtém o comando para inserir o círculo da E.I.
  CirculoID := DMServerDataAcess.DoGetSequenceValue(TSequencesNames.GEN_GRUPOS_EI);
  ADataset.Data := Circulo;

  if ADataset.Fields.FieldByName('codsac').IsNull then
   scodsac := 'null'
  else
   scodsac := ADataset.Fields.FieldByName('codsac').AsString;

  if ADataset.Fields.FieldByName('codsaz').IsNull then
   scodsaz := 'null'
  else
   scodsaz := ADataset.Fields.FieldByName('codsaz').AsString;


  sCommand := Format(TSecretariasEICommands.InsertGruposEI, [CirculoID,
          ADataset.Fields.FieldByName('codfoc').AsInteger,
          QuotedStr(ADataset.Fields.FieldByName('nomgru').AsString),
          ADataset.Fields.FieldByName('coddis').AsInteger,
          ADataset.Fields.FieldByName('codlic').AsInteger,
          QuotedStr('123'), scodsac, scodsaz]);

  AScript.Append(sCommand);


  //Obtém os comandos para inserir os membros do círculo da E.I.
  ADataset.Data := Membros;

  while not ADataset.Eof do
   begin
    sCommand := Format(TSecretariasEICommands.MembroCirculoEI, [ADataset.FieldValues['codcad']]);
    ASQLDataset := DMServerDataAcess.DoExecuteDQL(sCommand);

    if not (ASQLDataset.IsEmpty) then
     raise EValidateOperation.Create(TCosmosErrorSecMsg.DuplicatedMembroCirculoEI);

    sCommand := Format(TSecretariasEICommands.InsertMembrosCirculoEI, [CirculoID,
             ADataset.Fields.FieldByName('codcad').AsInteger,
             QuotedStr(ADataset.Fields.FieldByName('indcon').AsString),
             TDataConverter.ToFormatedSQLDateTime(Now),
             QuotedStr(Usuario)]);

    AScript.Append(sCommand);
    ADataset.Next;
   end;

  Result := DMServerDataAcess.DoExecuteScript(AScript);
  ADataset.Free;
  if Assigned(ASQLDataset) then ASQLDataset.Free;
  AScript.Free;

 except
  on E: EValidateOperation do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, AScript.Text, leOnError);
    if Assigned(ADataset) then ADataset.Free;
    if Assigned(ASQLDataset) then ASQLDataset.Free;
    if Assigned(AScript) then AScript.Free;
    raise TDBXError.Create(TCosmosErrorCodes.DuplicatedMembroCirculoEI, TCosmosErrorSecMsg.DuplicatedMembroCirculoEI);
   end;
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, AScript.Text, leOnError);
    if Assigned(ADataset) then ADataset.Free;
    if Assigned(ASQLDataset) then ASQLDataset.Free;
    if Assigned(AScript) then AScript.Free;
    raise TDBXError.Create(TCosmosErrorCodes.NovoCirculoEI, TCosmosErrorSecMsg.NovoCirculoEI);
   end;
  end;
end;

function TCosmosSecEIServerMethods.DesativarCirculo(codgru: Integer): boolean;
var
sCommand: string;
begin
//Desativa um círculo da Escola Interna.
  sCommand := Format(TSecretariasEICommands.DeleteCirculoEI, [codgru]);

  try
   Result := DMServerDataAcess.DoExecuteCommand(sCommand) > 0;

  except
   on E: Exception do
    begin
     DMCosmosServerServices.RegisterLog(E.Message, sCommand, leOnError);
     raise TDBXError.Create(TCosmosErrorCodes.DesativarCirculoEI, TCosmosErrorSecMsg.DesativarCirculoEI);
    end;
  end;
end;

function TCosmosSecEIServerMethods.CanDeleteLesson(
  const LessonId: integer): boolean;
var
 ADataset: TSQLDataset;
begin
//Verifica se uma lição da EI pode ser excluída.
 Result := False; //default.

 try
  ADataset := DMServerDataAcess.DoExecuteDQL(Format(TSecretariasEICommands.LessonsCount, [LessonId]));
  Result := ADataset.Fields.Fields[0].AsInteger = 0;
  ADataset.Free;

  if Result then
   begin
    ADataset := DMServerDataAcess.DoExecuteDQL(Format(TSecretariasEICommands.CIrculosLicaoCount , [LessonId]));
    Result := ADataset.Fields.Fields[0].AsInteger = 0;
    ADataset.Free;
   end;

 except
 on E: Exception do
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   raise;
  end;
 end;
end;

function TCosmosSecEIServerMethods.DeleteBook(codliv: Integer): boolean;
var
 ADataset: TSQLDataset;
begin
//Exclui um livro da escola interna, se possível
 try
  ADataset := DMServerDataAcess.DoExecuteDQL(Format(TSecretariasEICommands.BooksEICount, [codliv]));

  if ADataset.Fields.Fields[0].AsInteger = 0 then
   begin
    Result := DMServerDataAcess.DoExecuteCommand(Format(TSecretariasEICommands.DeleteLivroEI, [codliv])) > 0;
    ADataset.Free;
   end
  else
   raise TDBXError.Create(TCosmosErrorCodes.CantDeleteBookEI, TCosmosErrorSecMsg.CantDeleteBookEI);


 except
 on E: TDBXError do
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   raise;
  end;
 on E: Exception do
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   raise TDBXError.Create(TCosmosErrorCodes.DeleteBookEI, TCosmosErrorSecMsg.DeleteBookEI);
  end;
 end;
end;

function TCosmosSecEIServerMethods.DeleteLesson(codlic: Integer): boolean;
var
 ADataset: TSQLDataset;
begin
//Exclui uma lição de um livro da escola interna
 try
  //Checa se algum círculo está na lição que será excluída...
  Result := CanDeleteLesson(codlic);

  if not Result then
   raise TDBXError.Create(TCosmosErrorCodes.CantDeleteLessonEI, TCosmosErrorSecMsg.CantDeleteLessonEI);

  Result := DMServerDataAcess.DoExecuteCommand(Format(TSecretariasEICommands.DeleteLessonEI, [codlic])) > 0;
  ADataset.Free;

 except
 on E: TDBXError do
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
  end;
 on E: Exception do
  begin
   if Assigned(ADataset) then FreeAndNil(ADataset);
   DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   raise TDBXError.Create(TCosmosErrorCodes.DeleteLessonEI, TCosmosErrorSecMsg.DeleteLessonEI);
  end;
 end;
end;



end.

