unit cosmos.common.view.FormTabelasAcessorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.framework.view.FrmDocked,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, FrameEditButtons, cosmos.classes.application, cosmos.system.messages,
  cosmos.frames.gridsearch, cosmos.classes.ServerInterface, System.Actions,
  cosmos.framework.datanavigators.datasets, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.system.types, Datasnap.DSConnect, cosmos.system.formsconst;

type
  TFrmAcessorias = class(TFrmCosmosDocked)
    CdsTables: TClientDataSet;
    ActMeiosContato: TAction;
    ActCargos: TAction;
    ActProfissoes: TAction;
    ActEnfermidades: TAction;
    Panel1: TPanel;
    FmeEditButtons1: TFmeEditButtons;
    ActAptidoes: TAction;
    ActFuncoes: TAction;
    ActTiposRecebimentos: TAction;
    FmeGridSearch1: TFmeGridSearch;
    ActInfoInscricao: TAction;
    procedure ActTiposRecebimentosExecute(Sender: TObject);
    procedure CdsTablesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsTablesBeforeDelete(DataSet: TDataSet);
    procedure ActFuncoesExecute(Sender: TObject);
    procedure ActAptidoesExecute(Sender: TObject);
    procedure CdsTablesBeforePost(DataSet: TDataSet);
    procedure CdsTablesAfterPost(DataSet: TDataSet);
    procedure ActEnfermidadesExecute(Sender: TObject);
    procedure ActCargosExecute(Sender: TObject);
    procedure ActMeiosContatoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActProfissoesExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActInfoInscricaoExecute(Sender: TObject);
    procedure CdsTablesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FActiveTable: TCosmosTables;
    FRemoteConnection: TDSProviderConnection;
    FDataNavigator: TDatasetDataNavigator;
    procedure OpenData(const Table: TCosmosTables); inline;
    procedure UpdateData(Sender: TObject);

  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
    procedure ExportData; override;
    procedure UpdateVisualElements; override;


    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;
  public
    { Public declarations }
    property ActiveTable: TCosmosTables read FActiveTable write FActiveTable;
  end;

var
  FrmAcessorias: TFrmAcessorias;

implementation


{$R *.dfm}

procedure TFrmAcessorias.ActAptidoesExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctAptidoes);
  FmeGridSearch1.SearchFields := 'desare';
end;

procedure TFrmAcessorias.ActCargosExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctCargos);
  FmeGridSearch1.SearchFields := 'descar';
end;

procedure TFrmAcessorias.ActEnfermidadesExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctEnfermidades);
  FmeGridSearch1.SearchFields := 'nomenf';
end;

procedure TFrmAcessorias.ActFuncoesExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctFuncoes);
  FmeGridSearch1.SearchFields := 'desfun';
end;

procedure TFrmAcessorias.ActInfoInscricaoExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctFlagsInscricao);
  FmeGridSearch1.SearchFields := 'desfla';
end;

procedure TFrmAcessorias.ActMeiosContatoExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctMeiosContatos);
  FmeGridSearch1.SearchFields := 'destipcon';
end;

procedure TFrmAcessorias.ActProfissoesExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctProfissoes);
  FmeGridSearch1.SearchFields := 'despro';
end;

procedure TFrmAcessorias.ActTiposRecebimentosExecute(Sender: TObject);
begin
  inherited;
  OpenData(ctTiposRecebimentos);
  FmeGridSearch1.SearchFields := 'destiprec';
end;

procedure TFrmAcessorias.CdsTablesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if Assigned(IRemoteCon) then
    IRemoteCon.LoadFieldsInfo(Dataset);
end;

procedure TFrmAcessorias.CdsTablesAfterPost(DataSet: TDataSet);
begin
  inherited;
 if CdsTables.ChangeCount > 0 then
  CdsTables.ApplyUpdates(0);
end;

procedure TFrmAcessorias.CdsTablesBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.UpdateData, TCosmosInfoMsg.CanDelTableData);
  Abort;
end;

procedure TFrmAcessorias.CdsTablesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
  inherited;
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmAcessorias.CdsTablesReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
  Action := raCancel;
end;

procedure TFrmAcessorias.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsTables);
end;

procedure TFrmAcessorias.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsTables;
end;

procedure TFrmAcessorias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmAcessorias := nil;
end;

procedure TFrmAcessorias.FormCreate(Sender: TObject);
begin
 inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scCommon);
  FDataNavigator := TDatasetDataNavigator.Create(CdsTables);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

 case self.ICosmosApp.CosmosModule of
   cmSecretarias:
    begin
     ActTiposRecebimentos.Tag := 100;
     ActInfoInscricao.Tag := 100;
    end;
   cmFinanceiro:
    begin
      ActAptidoes.Tag := 100;
      ActCargos.Tag := 100;
      ActEnfermidades.Tag := 100;
      ActFuncoes.Tag := 100;
      ActMeiosContato.Tag := 100;
      ActProfissoes.Tag := 100;
      ActInfoInscricao.Tag := 100;
    end;
   cmConferencias:
    begin
      ActAptidoes.Tag := 100;
      ActCargos.Tag := 100;
      ActEnfermidades.Tag := 100;
      ActMeiosContato.Tag := 100;
      ActProfissoes.Tag := 100;
      ActTiposRecebimentos.Tag := 100;
    end;
   cmFocos:
    begin
      ActAptidoes.Tag := 100;
      ActEnfermidades.Tag := 100;
      ActMeiosContato.Tag := 100;
      ActProfissoes.Tag := 100;
      ActInfoInscricao.Tag := 100;
      ActTiposRecebimentos.Tag := 100;
    end;
   cmUsuarios:
    begin
      ActAptidoes.Tag := 100;
      ActCargos.Tag := 100;
      ActEnfermidades.Tag := 100;
      ActFuncoes.Tag := 100;
      ActMeiosContato.Tag := 100;
      ActProfissoes.Tag := 100;
      ActInfoInscricao.Tag := 100;
      ActTiposRecebimentos.Tag := 100;
    end;
 end;

 Self.ICosmosApp.DropCategory(self.Title);
 Self.ICosmosApp.AddCategory(self.Title, ActionList1);

 CdsTables.RemoteServer := FRemoteConnection;
end;

function TFrmAcessorias.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormTabAcessorias;
end;

function TFrmAcessorias.GetFormIDName: string;
begin
 case self.ICosmosApp.CosmosModule of
   cmSecretarias: Result := 'Secretarias.TabelasAcessorias';
   cmFinanceiro: Result := 'Financeiro.TabelasAcessorias';
   cmConferencias: Result := 'Conferencias.TabelasAcessorias';
 end;
end;

function TFrmAcessorias.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmAcessorias.GetHelpID: integer;
begin
Result := self.HelpContext;
end;

function TFrmAcessorias.GetTitle: string;
begin
 Result := 'Tabelas Acessórias';
end;

procedure TFrmAcessorias.Locate;
begin
 inherited;
 IRemoteCon.DefaultLocate;
end;

procedure TFrmAcessorias.OpenData(const Table: TCosmosTables);

begin
 ActiveTable := Table;
 CdsTables.DisableControls;
 CdsTables.ProviderName := '';

 try
  if CdsTables.Active then
   CdsTables.Close;

  CdsTables.ProviderName := IRemoteCon.OpenTableData(ActiveTable);
  if CdsTables.ProviderName <> '' then
   CdsTables.Open;

  CdsTables.EnableControls;

 except
  on E: Exception do
   begin
    E.Message := '';
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
 end;
end;

procedure TFrmAcessorias.UpdateData(Sender: TObject);
begin
  inherited;
  if CdsTables.Active then
   CdsTables.Refresh;
end;

procedure TFrmAcessorias.UpdateVisualElements;
begin
  inherited;
  //
end;

initialization
 RegisterClass(TFrmAcessorias);

finalization
 UnRegisterClass(TFrmAcessorias);
end.
