unit cosmos.server.common.logradouros.methods;

interface

uses
  System.SysUtils, System.Classes, System.Json, Datasnap.DSServer,
  DataSnap.DSProviderDataModuleAdapter, Datasnap.DSAuth, Data.FMTBcd, Data.DB,
  Datasnap.DBClient, Data.SqlExpr, Datasnap.Provider, System.Variants,
  cosmos.servers.sqlcommands, DataSnap.DsSession;

type
  TDMCosmosServerLogradouros = class(TDSServerModule)
    DspSearchLogradouros: TDataSetProvider;
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
    DspPaises: TDataSetProvider;
    SQLPaises: TSQLDataSet;
    SQLPaisesCODPAI: TIntegerField;
    SQLPaisesNOMPAI: TStringField;
    SQLEstados: TSQLDataSet;
    SQLEstadosCODEST: TIntegerField;
    SQLEstadosCODPAI: TIntegerField;
    SQLEstadosNOMPAI: TStringField;
    SQLEstadosNOMEST: TStringField;
    SQLEstadosSIGEST: TStringField;
    DspEstados: TDataSetProvider;
    SQLCidades: TSQLDataSet;
    SQLCidadesCODCID: TIntegerField;
    SQLCidadesNOMCID: TStringField;
    SQLCidadesCODEST: TIntegerField;
    DspCidades: TDataSetProvider;
    DspBairros: TDataSetProvider;
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
    DspLogradouros: TDataSetProvider;
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
    DspEndereco: TDataSetProvider;
    SQLEnderecoCadastrado: TSQLDataSet;
    SQLEnderecoCadastradoCODEND: TIntegerField;
    SQLEnderecoCadastradoCODCAD: TIntegerField;
    SQLEnderecoCadastradoCODLOG: TIntegerField;
    SQLEnderecoCadastradoNOMLOG: TStringField;
    SQLEnderecoCadastradoNUMEND: TIntegerField;
    SQLEnderecoCadastradoCOMEND: TStringField;
    SQLEnderecoCadastradoCEPLOG: TStringField;
    SQLEnderecoCadastradoCODBAI: TIntegerField;
    SQLEnderecoCadastradoNOMBAI: TStringField;
    SQLEnderecoCadastradoCODCID: TIntegerField;
    SQLEnderecoCadastradoNOMCID: TStringField;
    SQLEnderecoCadastradoNOMEST: TStringField;
    SQLEnderecoCadastradoSIGEST: TStringField;
    SQLEnderecoCadastradoCODPAI: TIntegerField;
    SQLEnderecoCadastradoNOMPAI: TStringField;
    SQLEnderecoCadastradoINDCOR: TStringField;
    SQLEnderecoCadastradoTIPEND: TStringField;
    SQLEnderecoCadastradoDATCAD: TSQLTimeStampField;
    SQLEnderecoCadastradoUSURES: TStringField;
    DspMeiosContatos: TDataSetProvider;
    SQLMeiosContatos: TSQLDataSet;
    SQLMeiosContatosCODCON: TIntegerField;
    SQLMeiosContatosDESCON: TStringField;
    SQLMeiosContatosCODTIPCON: TIntegerField;
    SQLMeiosContatosDESTIPCON: TStringField;
    SQLMeiosContatosCODCAD: TIntegerField;
    SQLMeiosContatosINDCAR: TStringField;
    SQLMeiosContatosDATCAD: TSQLTimeStampField;
    SQLMeiosContatosUSURES: TStringField;
    procedure SQLSearchLogradourosBeforeOpen(DataSet: TDataSet);
    procedure DspSearchLogradourosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspPaisesGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspEstadosGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspCidadesGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspBairrosGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspBairrosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspLogradourosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspEnderecoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspEnderecoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspMeiosContatosGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspMeiosContatosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspSearchLogradourosUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses cosmos.servers.common.dataacess;

{$R *.dfm}

procedure TDMCosmosServerLogradouros.DspBairrosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_BAIRROS, False]);
end;

procedure TDMCosmosServerLogradouros.DspBairrosGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_BAIRROS;
end;

procedure TDMCosmosServerLogradouros.DspCidadesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CIDADES, False]);
end;

procedure TDMCosmosServerLogradouros.DspEnderecoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ENDERECOS, False]);
end;

procedure TDMCosmosServerLogradouros.DspEnderecoGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ENDERECOS;
end;

procedure TDMCosmosServerLogradouros.DspEstadosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ESTADOS, False]);
end;

procedure TDMCosmosServerLogradouros.DspLogradourosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_LOGRADOUROS, False]);
end;

procedure TDMCosmosServerLogradouros.DspMeiosContatosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_MEIOS_CONTATOS, False]);
end;

procedure TDMCosmosServerLogradouros.DspMeiosContatosGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_MEIOSCONTATOS;
end;

procedure TDMCosmosServerLogradouros.DspPaisesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PAISES, False]);
end;

procedure TDMCosmosServerLogradouros.DspSearchLogradourosGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_LOGRADOUROS;
end;

procedure TDMCosmosServerLogradouros.DspSearchLogradourosUpdateError(
  Sender: TObject; DataSet: TCustomClientDataSet; E: EUpdateError;
  UpdateKind: TUpdateKind; var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMCosmosServerLogradouros.SQLSearchLogradourosBeforeOpen(
  DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.ConnectionsPool.SQLConnection;
end;

end.

