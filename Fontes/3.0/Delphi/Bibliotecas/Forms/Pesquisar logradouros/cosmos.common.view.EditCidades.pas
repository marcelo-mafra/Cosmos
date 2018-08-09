unit cosmos.common.view.EditCidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, cosmos.frames.searchdata, DB, DBClient,
  Mask, DBCtrls, Cosmos.Framework.Interfaces.DataAcess, FrameDBInsertVertical,
  cosmos.frames.gridsearch, cosmos.system.messages, Datasnap.DSConnect,
  cosmos.Framework.Interfaces.Root, cosmos.classes.ServerInterface;

type
  TFrmEditCidades = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    FmeSearchDataEstados: TFmeSearchData;
    CdsCidades: TClientDataSet;
    Label2: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    EdtPais: TEdit;
    Label3: TLabel;
    procedure CdsCidadesBeforePost(DataSet: TDataSet);
    procedure CdsCidadesBeforeDelete(DataSet: TDataSet);
    procedure CdsCidadesAfterPost(DataSet: TDataSet);
    procedure CdsCidadesAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    procedure SelectData(Sender: TObject);

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditCidades: TFrmEditCidades;

implementation



{$R *.dfm}

procedure TFrmEditCidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CdsCidades.Active then CdsCidades.Close;
 CdsCidades.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditCidades.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsCidades.RemoteServer := FRemoteConnection;

 FmeSearchDataEstados.CosmosSearch := csEstados;
 FmeSearchDataEstados.CanEdit := True;
 FmeSearchDataEstados.OnSelectData := SelectData;
 FmeGridSearch1.SearchFields := 'nomcid';
end;

procedure TFrmEditCidades.SelectData(Sender: TObject);
begin
 try
 if FmeSearchDataEstados.CosmosData <> nil then
  begin
   EdtPais.Text := FmeSearchDataEstados.CosmosData.FindValue('nompai');
   CdsCidades.DisableControls;
   if CdsCidades.Active then
    CdsCidades.Close;
   CdsCidades.Params.Items[0].Value := FmeSearchDataEstados.CosmosData.FindValue('codest');
   CdsCidades.Open;
  end
 else
  CdsCidades.Close;

 finally
  CdsCidades.EnableControls;
 end;
end;

procedure TFrmEditCidades.CdsCidadesAfterInsert(DataSet: TDataSet);
begin
 with CdsCidades do
  begin
   Fields.FieldByName('codest').AsInteger := Params.Items[0].AsInteger;
   if Visible then
    Fields.FieldByName('nomcid').FocusControl;
  end; 
end;

procedure TFrmEditCidades.CdsCidadesAfterPost(DataSet: TDataSet);
begin
 if CdsCidades.ChangeCount > 0 then
  CdsCidades.ApplyUpdates(0);
end;

procedure TFrmEditCidades.CdsCidadesBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Cidades, TCosmosConfMsg.DeleteCity) = mrNo  then
  Abort;
end;

procedure TFrmEditCidades.CdsCidadesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

end.
