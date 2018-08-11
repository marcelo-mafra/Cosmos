unit cosmos.servers.focos.methods;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  cosmos.classes.application, cosmos.system.messages, cosmos.system.exceptions,
  cosmos.servers.sqlcommands, System.Variants, cosmos.classes.dataobjects,
  cosmos.classes.ServerInterface, Data.DB, Data.DBXCommon, DBClient, Data.FMTBcd,
  Data.SqlExpr, Datasnap.Provider, DataSnap.DsSession, DataSnap.DSProviderDataModuleAdapter,
  cosmos.business.focos, cosmos.classes.logs, Data.DBXDBReaders;

type
  {$METHODINFO OFF}


  {$METHODINFO ON}    
  TDMCosmosFocosMethods = class(TDSServerModule)
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
    SQLFocoINDEIN: TStringField;
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
    DspMentores: TDataSetProvider;
    SQLMentores: TSQLDataSet;
    SQLMentoresCODMEN: TIntegerField;
    SQLMentoresCODREG: TIntegerField;
    SQLMentoresNOMREG: TStringField;
    SQLMentoresCODCAD: TIntegerField;
    SQLMentoresNOMCAD: TStringField;
    SQLMentoresMATCAD: TStringField;
    SQLMentoresSIGDIS: TStringField;
    SQLMentoresSIGFOC: TStringField;
    DspDirigentesAtuais: TDataSetProvider;
    SQLDirigentesAtuais: TSQLDataSet;
    DspDirigentesGestao: TDataSetProvider;
    SQLDirigentesGestao: TSQLDataSet;
    DspCargos: TDataSetProvider;
    SQLCargos: TSQLDataSet;
    SQLCargosCODCAR: TIntegerField;
    SQLCargosDESCAR: TStringField;
    DspTiposContatos: TDataSetProvider;
    SQLTiposContatos: TSQLDataSet;
    SQLTiposContatosCODTIPCON: TIntegerField;
    SQLTiposContatosDESTIPCON: TStringField;
    DspOrgaos: TDataSetProvider;
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
    DspGestoes: TDataSetProvider;
    SQLGestoes: TSQLDataSet;
    SQLGestoesCODGES: TIntegerField;
    SQLGestoesCODORG: TIntegerField;
    SQLGestoesNOMORG: TStringField;
    SQLGestoesDATINI: TDateField;
    SQLGestoesDATTER: TDateField;
    SQLGestoesDATCAD: TSQLTimeStampField;
    SQLGestoesUSURES: TStringField;
    DspDirecoes: TDataSetProvider;
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
    procedure DspRecadosGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure SQLFocoBeforeOpen(DataSet: TDataSet);
    procedure DspFocoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspMentoresGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspMentoresGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspCargosGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspOrgaosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
  private
    { Private declarations }


  public
    { Public declarations }

    function DuplicarGestao(codorg, codges: Integer; datini, datter: TDateTime;
      Dirigentes: OleVariant): boolean;
    procedure DeleteDirigente(coddir: Integer);
    procedure MoveDirigente(coddir, codges: Integer);
    function TerminateMandate(coddir: Integer): boolean;
    function TerminateMandates(codges: Integer): boolean;
    function CloneDirigente(coddir, codges: Integer): boolean;
    procedure DeleteGestao(codges: Integer);
    procedure DeleteOrgao(codorg: Integer);
    procedure AlterarSubordinacao(codorg, NewParent: Integer);

    function DeleteFocus(codfoc: Integer): boolean;
    function DesactiveFocus(TargetFocus, TransferFocus: Integer;
      Desactivate: WordBool): boolean;
    function CriarFoco(DadosFoco, DadosEndereco, DadosGestao,
      DadosMeiosContatos: OleVariant): boolean;
    function ChangeFocusStatus(FocusID: Integer; Status: WordBool): boolean;
    function ChangeFocusParent(FocusID, NewParent: Integer): boolean;
    function ChangeFocusRegion(FocusID, NewRegion: Integer): boolean;
    function DeleteRegion(RegionID: Integer): boolean;
    function MoveRegion(RegionID, NewRegion: Integer): boolean;
    function NewAR(const ARName: WideString; ARParent: OleVariant): boolean;
    function RenameAr(codreg: Integer; const NewName: WideString): boolean;

  end;


var
  DMCosmosFocosMethods: TDMCosmosFocosMethods;

implementation

{$R *.DFM}

uses cosmos.servers.common.dataacess, cosmos.servers.common.services;

procedure TDMCosmosFocosMethods.AlterarSubordinacao(codorg, NewParent: Integer);
begin

end;

function TDMCosmosFocosMethods.ChangeFocusParent(FocusID,
  NewParent: Integer): boolean;
begin

end;

function TDMCosmosFocosMethods.ChangeFocusRegion(FocusID,
  NewRegion: Integer): boolean;
begin

end;

function TDMCosmosFocosMethods.ChangeFocusStatus(FocusID: Integer;
  Status: WordBool): boolean;
begin

end;

procedure TDMCosmosFocosMethods.DspCargosGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CARGOS, False]);
end;

procedure TDMCosmosFocosMethods.DspFocoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := UpperCase(TableName);
end;

procedure TDMCosmosFocosMethods.DspMentoresGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_MENTORES_REGIOES, False]);
end;

procedure TDMCosmosFocosMethods.DspMentoresGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_MENTORES_REGIOES;
end;

procedure TDMCosmosFocosMethods.DspOrgaosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
  TableName := TTablesNames.TAB_ORGAOS_GESTORES;
end;

procedure TDMCosmosFocosMethods.DspRecadosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_NOTAS_INSCRITO, False]);
end;

function TDMCosmosFocosMethods.DuplicarGestao(codorg, codges: Integer; datini,
  datter: TDateTime; Dirigentes: OleVariant): boolean;
begin

end;

procedure TDMCosmosFocosMethods.MoveDirigente(coddir, codges: Integer);
begin

end;

function TDMCosmosFocosMethods.MoveRegion(RegionID,
  NewRegion: Integer): boolean;
begin

end;

function TDMCosmosFocosMethods.NewAR(const ARName: WideString;
  ARParent: OleVariant): boolean;
begin

end;

function TDMCosmosFocosMethods.RenameAr(codreg: Integer;
  const NewName: WideString): boolean;
begin

end;

procedure TDMCosmosFocosMethods.SQLFocoBeforeOpen(DataSet: TDataSet);
begin
 TSQLDataSet(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

function TDMCosmosFocosMethods.CloneDirigente(coddir, codges: Integer): boolean;
begin

end;

function TDMCosmosFocosMethods.CriarFoco(DadosFoco, DadosEndereco, DadosGestao,
  DadosMeiosContatos: OleVariant): boolean;
begin

end;

procedure TDMCosmosFocosMethods.DeleteDirigente(coddir: Integer);
begin

end;

function TDMCosmosFocosMethods.DeleteFocus(codfoc: Integer): boolean;
begin

end;

procedure TDMCosmosFocosMethods.DeleteGestao(codges: Integer);
begin

end;

procedure TDMCosmosFocosMethods.DeleteOrgao(codorg: Integer);
begin

end;

function TDMCosmosFocosMethods.DeleteRegion(RegionID: Integer): boolean;
begin

end;

function TDMCosmosFocosMethods.DesactiveFocus(TargetFocus,
  TransferFocus: Integer; Desactivate: WordBool): boolean;
begin

end;

function TDMCosmosFocosMethods.TerminateMandate(coddir: Integer): boolean;
begin

end;

function TDMCosmosFocosMethods.TerminateMandates(codges: Integer): boolean;
begin

end;


end.
