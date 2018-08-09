unit cosmos.focos.reports.data;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Forms,
  cosmos.framework.interfaces.root;

type
  TDMFocosData = class(TDataModule)
    DsrRa: TDataSource;
    CdsRAs: TClientDataSet;
    CdsFocosRegiao: TClientDataSet;
    CdsMentores: TClientDataSet;
    CdsFocos: TClientDataSet;
    CdsEnderecos: TClientDataSet;
    CdsMeiosContatosFocos: TClientDataSet;
    CdsFichaAluno: TClientDataSet;
    CdsGestoes: TClientDataSet;
    CdsOrgaosGestores: TClientDataSet;
    CdsDirigentes: TClientDataSet;
    CdsMalaFocos: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function GetICosmosApp: ICosmosApplication;
    procedure ConfigureConnection(Connection: TCustomRemoteServer);

  public
    { Public declarations }

   property ICosmosApp: ICosmosApplication read GetICosmosApp;
  end;

var
  DMFocosData: TDMFocosData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMFocosData }

procedure TDMFocosData.ConfigureConnection(Connection: TCustomRemoteServer);
var
I: integer;
begin
//Configura o connectionbroker a ser usado
 for I  := 0 to TDataModule(self).ComponentCount - 1 do
  begin
   if (TDataModule(self).Components[I] is TClientDataset) and (TClientDataset(TDataModule(self).Components[I]).ProviderName <> '') then
    TClientDataset(TDataModule(self).Components[I]).RemoteServer := Connection;
  end;
end;

procedure TDMFocosData.DataModuleCreate(Sender: TObject);
begin
 ConfigureConnection(ICosmosApp.IRemoteCon.ConnectionBroker);
end;

function TDMFocosData.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

end.
