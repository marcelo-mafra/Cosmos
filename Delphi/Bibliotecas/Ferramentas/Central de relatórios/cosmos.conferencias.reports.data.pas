unit cosmos.conferencias.reports.data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Forms,
  cosmos.framework.interfaces.root,  Datasnap.DSConnect, cosmos.classes.datasetspool,
  Cosmos.Framework.Interfaces.DataAcess;

type
  TDMConfData = class(TDataModule)
    CdsCrachas: TClientDataSet;
    CdsProgramacao: TClientDataSet;
    CdsListaInscritos: TClientDataSet;
    CdsFichaInscricao: TClientDataSet;
    CdsCrachaInscrito: TClientDataSet;
    CdsTarefasCracha: TClientDataSet;
    CdsAreasStaff: TClientDataSet;
    CdsAlojamentos: TClientDataSet;
    CdsLeitos: TClientDataSet;
    CdsInformacoesInscritos: TClientDataSet;
    CdsStaffs: TClientDataSet;
    CdsFolhasQuartos: TClientDataSet;
    CdsQuartosAlojamento: TClientDataSet;
    DsrMasterSource: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    FDatasets: TDatasetsPool;
    function GetICosmosApp: ICosmosApplication;
    procedure ConfigureConnection;

  public
    { Public declarations }
   procedure CloseAllDatasets;
   property ICosmosApp: ICosmosApplication read GetICosmosApp;
   procedure DestroyDataset;
   property Datasets: TDatasetsPool read FDatasets;
  end;

var
  DMConfData: TDMConfData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMConfData }

procedure TDMConfData.CloseAllDatasets;
var
I: integer;
begin
{Fecha todos os datasets ativos. Este método é usado para que muitos datasets
não fiquem abertos após o usuário executar diversos relatórios.}
 for I  := 0 to TDataModule(self).ComponentCount - 1 do
  begin
   if (TDataModule(self).Components[I] is TClientDataset) and (TClientDataset(TDataModule(self).Components[I]).Active) then
    TClientDataset(TDataModule(self).Components[I]).Close;
  end;
end;

procedure TDMConfData.ConfigureConnection;
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

procedure TDMConfData.DataModuleCreate(Sender: TObject);
begin
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  ConfigureConnection;
  FDatasets := TDatasetsPool.Create;
end;

procedure TDMConfData.DataModuleDestroy(Sender: TObject);
begin
 FDatasets.ClearAll;
 FDatasets.Free;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TDMConfData.DestroyDataset;
begin
 Datasets.ClearAll;
end;

function TDMConfData.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

end.
