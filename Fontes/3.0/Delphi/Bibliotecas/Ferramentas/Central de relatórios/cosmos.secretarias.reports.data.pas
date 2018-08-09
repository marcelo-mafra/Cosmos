unit cosmos.secretarias.reports.data;

interface

uses
  System.SysUtils, System.Classes, Forms, cosmos.framework.interfaces.root,
  Data.DB, Datasnap.DBClient, Datasnap.DSConnect, cosmos.framework.interfaces.dataacess,
  cosmos.classes.datasetspool;

type
  TDMSecData = class(TDataModule)
    CdsListaAlunos: TClientDataSet;
    CdsEnderecosAlunos: TClientDataSet;
    CdsContarCadastrados: TClientDataSet;
    CdsAtividades: TClientDataSet;
    CdsTempoDiscipulado: TClientDataSet;
    CdsAtividadesMes: TClientDataSet;
    CdsExternalReports: TClientDataSet;
    CdsResumoEstatisticoLEC: TClientDataSet;
    CdsMalaDireta: TClientDataSet;
    CdsCadastradosDisc: TClientDataSet;
    CdsDatasInstalacoes: TClientDataSet;
    CdsAlunosHistorico: TClientDataSet;
    CdsHistoricoDiscipular: TClientDataSet;
    CdsAtividadesCampo: TClientDataSet;
    CdsCatExternalReports: TClientDataSet;
    CdsSumarizaAtividades: TClientDataSet;
    CdsFichaCadastral: TClientDataSet;
    CdsMeiosContatos: TClientDataSet;
    CdsMembrosCirculo: TClientDataSet;
    CdsCirculos: TClientDataSet;
    CdsMembrosCirculos: TClientDataSet;
    CdsContabilizarFrequencia: TClientDataSet;
    CdsConferencia: TClientDataSet;
    CdsFuncoes: TClientDataSet;
    CdsListaFuncoes: TClientDataSet;
    CdsCadastradosFuncoes: TClientDataSet;
    CdsCadastradosProfissoes: TClientDataSet;
    CdsDiscipulados: TClientDataSet;
    CdsJovensTM: TClientDataSet;
    CdsAniversariantes: TClientDataSet;
    CdsContarAlunosEI: TClientDataSet;
    CdsListaProfissoes: TClientDataSet;
    CdsTarefas: TClientDataSet;
    CdsContarAlunosEE: TClientDataSet;
    CdsResumoEstatisticoRas: TClientDataSet;
    CdsRegioesAdmin: TClientDataSet;
    CdsQuadroTotalizacaoTM: TClientDataSet;
    CdsAtividadesConferencia: TClientDataSet;
    CdsFolhasPresenca: TClientDataSet;
    CdsFamiliares: TClientDataSet;
    CdsReportData: TClientDataSet;
    CdsFolhaPresencaMensal: TClientDataSet;
    DsrMasterSource: TDataSource;
    CdsEscalasAtividades: TClientDataSet;
    CdsListaGeralAlunos: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    aDataset: TClientDataset;
    FDatasets: TDatasetsPool;
    function GetICosmosApp: ICosmosApplication;
    procedure ConfigureConnection;

  public
    { Public declarations }
    procedure CloseDataset(Dataset: TDataset);
    procedure DestroyDataset;
    property Datasets: TDatasetsPool read FDatasets;
    property ICosmosApp: ICosmosApplication read GetICosmosApp;
  end;

var
  DMSecData: TDMSecData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMSecData.CloseDataset(Dataset: TDataset);
begin
 if Dataset.Active then
  Dataset.Close;
end;

procedure TDMSecData.ConfigureConnection;
var
I: integer;
begin
//Configura o connectionbroker a ser usado
 for I  := 0 to TDataModule(self).ComponentCount - 1 do
  begin
   if (TDataModule(self).Components[I] is TClientDataset) and (TClientDataset(TDataModule(self).Components[I]).ProviderName <> '') then
    TClientDataset(TDataModule(self).Components[I]).RemoteServer := FRemoteConnection;
  end;
end;

procedure TDMSecData.DataModuleCreate(Sender: TObject);
begin
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
  ConfigureConnection;
  FDatasets := TDatasetsPool.Create;
end;

procedure TDMSecData.DataModuleDestroy(Sender: TObject);
begin
 FDatasets.ClearAll;
 FDatasets.Free;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TDMSecData.DestroyDataset;
begin
 if Assigned(aDataset) then
  FreeAndNil(aDataset);

 Datasets.ClearAll;
end;

function TDMSecData.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

end.
