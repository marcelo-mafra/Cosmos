unit cosmos.financeiro.reports.data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Forms,
  cosmos.framework.interfaces.root, cosmos.classes.datasetspool;

type
  TDMFinData = class(TDataModule)
    CdsRecebimentosCadastrado: TClientDataSet;
    CdsCadastrado: TClientDataSet;
    CdsSumarioCaixas: TClientDataSet;
    CdsContribuicoesPendentes: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDatasets: TDatasetsPool;
    function GetICosmosApp: ICosmosApplication;

  public
    { Public declarations }
   procedure CloseAllDatasets;
   property ICosmosApp: ICosmosApplication read GetICosmosApp;
   procedure DestroyDataset;
   property Datasets: TDatasetsPool read FDatasets;
  end;

var
  DMFinData: TDMFinData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMFinData }

procedure TDMFinData.CloseAllDatasets;
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

procedure TDMFinData.DataModuleCreate(Sender: TObject);
begin
 FDatasets := TDatasetsPool.Create;
end;

procedure TDMFinData.DataModuleDestroy(Sender: TObject);
begin
 Datasets.ClearAll;
end;

procedure TDMFinData.DestroyDataset;
begin
 Datasets.ClearAll;
end;

function TDMFinData.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

end.
