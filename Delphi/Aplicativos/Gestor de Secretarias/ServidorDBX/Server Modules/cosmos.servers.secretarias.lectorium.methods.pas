unit cosmos.servers.secretarias.lectorium.methods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Classes,
  System.Json, Datasnap.DSServer, DataSnap.DSProviderDataModuleAdapter,
  Datasnap.DSAuth,  Data.DB, Datasnap.DBClient, Data.SqlExpr, cosmos.system.files,
  Data.FMTBcd, System.Variants, Datasnap.Provider, cosmos.classes.application,
  cosmos.servers.sqlcommands, cosmos.classes.ServerInterface, System.WideStrings,
  cosmos.system.messages, cosmos.system.exceptions, Data.dbxCommon, DataSnap.DsSession,
  cosmos.classes.logs, cosmos.classes.persistence.ini, Data.DBXFirebird;

type
  TDMSecLectoriumServerMethods = class(TDSServerModule)
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
    SQLAlunos: TSQLDataSet;
    DspAlunos: TDataSetProvider;
    SQLAlunosCODCAD: TIntegerField;
    SQLAlunosMATCAD: TStringField;
    SQLAlunosNOMCAD: TStringField;
    SQLAlunosAPECAD: TStringField;
    SQLAlunosSIGDIS: TStringField;
    SQLAlunosSIGFOC: TStringField;
    DspAluno: TDataSetProvider;
    SQLAluno: TSQLDataSet;
    SQLAlunoCODCAD: TIntegerField;
    SQLAlunoMATCAD: TStringField;
    SQLAlunoNOMCAD: TStringField;
    SQLAlunoAPECAD: TStringField;
    SQLAlunoSEXCAD: TStringField;
    SQLAlunoDATNAS: TDateField;
    SQLAlunoNACCAD: TStringField;
    SQLAlunoDOCIDE: TStringField;
    SQLAlunoORGEXP: TStringField;
    SQLAlunoESTCIV: TStringField;
    SQLAlunoFOTCAD: TGraphicField;
    SQLAlunoCODPRO: TIntegerField;
    SQLAlunoDESPRO: TStringField;
    SQLAlunoCODFOC: TIntegerField;
    SQLAlunoCODDIS: TIntegerField;
    SQLAlunoSIGDIS: TStringField;
    SQLAlunoCADTIT: TIntegerField;
    SQLAlunoINDEXTNUC: TStringField;
    SQLAlunoINDGRUJOV: TStringField;
    SQLAlunoINDLIGROZ: TStringField;
    SQLAlunoINDATI: TStringField;
    SQLAlunoINDFRE: TStringField;
    SQLAlunoINDMEN: TStringField;
    SQLAlunoVALMEN: TFMTBCDField;
    SQLAlunoVALTAX: TFMTBCDField;
    SQLAlunoDATOBI: TDateField;
    SQLAlunoOBSCAD: TMemoField;
    SQLAlunoUSURES: TStringField;
    SQLAlunoDATCAD: TSQLTimeStampField;
    SQLAlunosINDATI: TStringField;
    SQLAlunoNOMTIT: TStringField;
    SQLAlunoINDLIC: TStringField;
    DspDispensas: TDataSetProvider;
    SQLDispensas: TSQLDataSet;
    SQLDispensasCODDIS: TIntegerField;
    SQLDispensasCODCAD: TIntegerField;
    SQLDispensasINIDIS: TDateField;
    SQLDispensasTERDIS: TDateField;
    SQLDispensasDATCAD: TSQLTimeStampField;
    SQLDispensasUSURES: TStringField;
    SQLTarefas: TSQLDataSet;
    DspTarefas: TDataSetProvider;
    SQLJovensTM: TSQLDataSet;
    SQLJovensTMCODCAD: TIntegerField;
    SQLJovensTMMATCAD: TStringField;
    SQLJovensTMNOMCAD: TStringField;
    SQLJovensTMAPECAD: TStringField;
    SQLJovensTMSIGDIS: TStringField;
    SQLJovensTMSIGFOC: TStringField;
    SQLJovensTMINDATI: TStringField;
    DspJovensTM: TDataSetProvider;
    SQLJovensTMDATNAS: TDateField;
    DspJovemTM: TDataSetProvider;
    SQLJovemTM: TSQLDataSet;
    SQLJovemTMCODCAD: TIntegerField;
    SQLJovemTMMATCAD: TStringField;
    SQLJovemTMNOMCAD: TStringField;
    SQLJovemTMAPECAD: TStringField;
    SQLJovemTMSEXCAD: TStringField;
    SQLJovemTMDATNAS: TDateField;
    SQLJovemTMNACCAD: TStringField;
    SQLJovemTMDOCIDE: TStringField;
    SQLJovemTMORGEXP: TStringField;
    SQLJovemTMESTCIV: TStringField;
    SQLJovemTMFOTCAD: TGraphicField;
    SQLJovemTMCODPRO: TIntegerField;
    SQLJovemTMDESPRO: TStringField;
    SQLJovemTMCODFOC: TIntegerField;
    SQLJovemTMCODDIS: TIntegerField;
    SQLJovemTMSIGDIS: TStringField;
    SQLJovemTMCADTIT: TIntegerField;
    SQLJovemTMNOMTIT: TStringField;
    SQLJovemTMINDEXTNUC: TStringField;
    SQLJovemTMINDLIGROZ: TStringField;
    SQLJovemTMINDATI: TStringField;
    SQLJovemTMINDFRE: TStringField;
    SQLJovemTMVALMEN: TFMTBCDField;
    SQLJovemTMVALTAX: TFMTBCDField;
    SQLJovemTMDATOBI: TDateField;
    SQLJovemTMOBSCAD: TMemoField;
    SQLJovemTMUSURES: TStringField;
    SQLJovemTMDATCAD: TSQLTimeStampField;
    SQLAlunosmatcadint: TIntegerField;
    SQLPesquisadoresMATCADINT: TIntegerField;
    SQLJovensTMMATCADINT: TIntegerField;
    SQLAlunosSEXCAD: TStringField;
    SQLSimpatizantes: TSQLDataSet;
    DspSimpatizantes: TDataSetProvider;
    SQLSimpatizantesCODSIM: TIntegerField;
    SQLSimpatizantesNOMSIM: TStringField;
    SQLAlunosINDESCINT: TStringField;
    SQLAlunosDATNAS: TDateField;
    SQLJovensTMSEXCAD: TStringField;
    SQLJovensTMINDESCINT: TStringField;
    SQLPesquisadoresDATNAS: TDateField;
    SQLPesquisadoresSEXCAD: TStringField;
    SQLPesquisadoresINDESCINT: TStringField;
    SQLPesquisadoresSIGFOC: TStringField;
    SQLPesquisadorOBSCAD: TMemoField;
    SQAlunosAlfa: TSQLDataSet;
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
    DspAlunosAlfa: TDataSetProvider;
    SQLAlunosDisc: TSQLDataSet;
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
    DspAlunosDisc: TDataSetProvider;
    SQLJovensAlfa: TSQLDataSet;
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
    DspJovensAlfa: TDataSetProvider;
    SQLJovensDisc: TSQLDataSet;
    IntegerField7: TIntegerField;
    StringField25: TStringField;
    StringField26: TStringField;
    StringField27: TStringField;
    DateField4: TDateField;
    StringField28: TStringField;
    StringField29: TStringField;
    StringField30: TStringField;
    StringField31: TStringField;
    StringField32: TStringField;
    IntegerField8: TIntegerField;
    DspJovensDisc: TDataSetProvider;
    procedure DspLogradourosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspDispensasGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFuncoesCadastradoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspInfoMedicasGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspAlunoGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspPesquisadorGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspAlunosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure SQLAlunosBeforeOpen(DataSet: TDataSet);
    procedure DspAlunosUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);


  private
    { Private declarations }

  public
    { Public declarations }
    function FindCadastrado(Matricula, Nome: OleVariant): TDataset;
    function GetDiscipuladoTM(Nascimento: TDateTime): TDataset;
    function NovaMatricula(codfoc: Integer): string;
    procedure AtualizarJovensAlunos(codfoc: Integer);

  end;

var
  DMSecLectoriumServerMethods: TDMSecLectoriumServerMethods;

implementation

uses cosmos.servers.common.dataacess, cosmos.servers.common.services;

{$R *.DFM}

procedure TDMSecLectoriumServerMethods.DspAlunoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CADASTRADOS, False]);
end;

procedure TDMSecLectoriumServerMethods.DspAlunosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CADASTRADOS;
end;

procedure TDMSecLectoriumServerMethods.DspAlunosUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMSecLectoriumServerMethods.DspDispensasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_DISPENSAS, False]);
end;

procedure TDMSecLectoriumServerMethods.DspFuncoesCadastradoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := TTablesNames.TAB_FUNCOES_CADASTRADO;
end;

procedure TDMSecLectoriumServerMethods.DspInfoMedicasGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := TTablesNames.TAB_INFO_MED;
end;

procedure TDMSecLectoriumServerMethods.DspLogradourosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
TableName := TTablesNames.TAB_LOGRADOUROS;
end;

procedure TDMSecLectoriumServerMethods.DspPesquisadorGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CADASTRADOS, False]);
end;

function TDMSecLectoriumServerMethods.FindCadastrado(Matricula, Nome: OleVariant): TDataset;
var
 sCommand: string;
 ADataset: TSQLDataset;
begin
 ADataset := DMServerDataAcess.CreateDataset;

 try
  if Matricula <> null then
   sCommand := Format(TDQLCommands.CadastradoMatricula, [QuotedStr(Matricula + '%')])
  else
   sCommand := Format(TDQLCommands.CadastradoNome, [QuotedStr(Nome+ '%')]);

  ADataset.CommandText := sCommand;
  ADataset.Open;
  Result := ADataset;

 except
  on E: Exception do
   begin
    Result := nil;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   // E.Message := sErrorSelectData;
   end;
 end;
end;


procedure TDMSecLectoriumServerMethods.SQLAlunosBeforeOpen(DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

function TDMSecLectoriumServerMethods.NovaMatricula(codfoc: Integer): string;
var
sCommand: string;
ADataset: TSQLDataset;
CosmosApp: TCosmosApplication;
AFile: TIniFilePersistence;
ANumber: integer;
begin
//Retorna um novo número de matrícula de um aluno de um determinado foco.
 CosmosApp := TCosmosApplication.Create;
 AFile := TIniFilePersistence.Create(CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot, True);
 ANumber := AFile.ReadInteger('GSEC', 'IniciarMatriculaLEC', 150);
 ADataset := DMServerDataAcess.CreateDataset;

 try
  sCommand := Format(TSecretariasCommands.NovaMatricula,[codfoc, QuotedStr('LEC'), ANumber]);
  ADataset.CommandText := sCommand;
  ADataset.Open;
  Result :=  ADataset.Fields.Fields[0].Value;

  if Assigned(AFile) then FreeAndNil(AFile);
  if Assigned(CosmosApp) then FreeAndNil(CosmosApp);

 except
  on E: Exception do
   begin
    if Assigned(AFile) then FreeAndNil(AFile);
    if Assigned(CosmosApp) then FreeAndNil(CosmosApp);
    Result := '';
    DMCosmosServerServices.RegisterLog(E.Message, sCommand, leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.NovaMatricula, TCosmosErrorSecMsg.NovaMatricula);
   end;
 end;
end;

function TDMSecLectoriumServerMethods.GetDiscipuladoTM(Nascimento: TDateTime): TDataset;
var
 ADataset: TSQLDataset;
begin
{Retorna o código e a sigla de um discipulado do TM a partir de uma data de
nascimento, passada em parâmetro de entrada.}
 ADataset := TSQLDataset.Create(nil);

 try
  ADataset.SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
  ADataset.CommandText := Format(TSecHistoricoCmd.DiscipuladoTM , [QuotedStr(FormatDateTime('yyyy/mm/dd', Nascimento))]);
  ADataset.Open;

  Result := ADataset;


 except
  on E: Exception do
   begin
    Result := nil;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    //E.Message := sErrorSelectData;
   end;
 end;
end;

procedure TDMSecLectoriumServerMethods.AtualizarJovensAlunos(codfoc: Integer);
var
 CurrentUserName: string;
begin
//Atualiza os membros do GJA de um foco..
 try
  CurrentUserName := DMCosmosServerServices.ConnectedUser.ToUpper;
  CurrentUserName := CurrentUserName.QuotedString;

  DMServerDataAcess.DoExecuteCommand(Format(TSecHistoricoCmd.DesligaGJA, [codfoc, CurrentUserName]));

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    //E.Message := sErrorSelectData;
   end;
 end;
end;




end.

