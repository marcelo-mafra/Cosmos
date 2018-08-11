unit cosmos.common.view.EditEstados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameEditButtons, StdCtrls, Mask, DBCtrls, cosmos.frames.fksearch, DB,
  DBClient, GraphicHeader, cosmos.frames.searchdata, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.frames.gridsearch, cosmos.system.messages, FrameDBInsertVertical,
  cosmos.Framework.Interfaces.Root, cosmos.classes.ServerInterface,
  Datasnap.DSConnect;

type
  TFrmEditEstados = class(TForm)
    CdsEstados: TClientDataSet;
    FmeSearchData1: TFmeSearchData;
    MSGraphicHeader2: TMSGraphicHeader;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    FmeGridSearch1: TFmeGridSearch;
    procedure CdsEstadosAfterInsert(DataSet: TDataSet);
    procedure CdsEstadosBeforePost(DataSet: TDataSet);
    procedure CdsEstadosBeforeDelete(DataSet: TDataSet);
    procedure CdsEstadosAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

    procedure ListData(Sender: TObject);
  public
    { Public declarations }
    procedure NovoEstado;
    procedure EditarEstado(const codest: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditEstados: TFrmEditEstados;

implementation



{$R *.dfm}

procedure TFrmEditEstados.EditarEstado(const codest: integer);
begin

end;

procedure TFrmEditEstados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CdsEstados.Active then CdsEstados.Close;
 CdsEstados.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditEstados.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsEstados.RemoteServer := FRemoteConnection;

 FmeSearchData1.CosmosSearch := csPaises;
 FmeSearchData1.CanEdit := True;
 FmeSearchData1.OnSelectData := ListData;
 FmeGridSearch1.SearchFields := 'nomest';
end;

procedure TFrmEditEstados.NovoEstado;
begin
 CdsEstados.Params.Items[0].AsInteger := 0;
 ShowModal;
end;

procedure TFrmEditEstados.CdsEstadosAfterInsert(DataSet: TDataSet);
begin
 with CdsEstados do
  begin
    Fields.FieldByName('codpai').Value := Params.Items[0].Value;
    Fields.FieldByName('nomest').FocusControl;
  end;
end;

procedure TFrmEditEstados.CdsEstadosAfterPost(DataSet: TDataSet);
begin
 if CdsEstados.ChangeCount > 0 then
   CdsEstados.ApplyUpdates(0);
end;

procedure TFrmEditEstados.ListData(Sender: TObject);
begin
 if FmeSearchData1.CosmosData <> nil then
  begin
   if CdsEstados.Active then
    CdsEstados.Close;
   CdsEstados.Params.Items[0].Value := FmeSearchData1.CosmosData.FindValue('CODPAI');
   CdsEstados.Open;
  end
 else
  CdsEstados.Close;
end;

procedure TFrmEditEstados.CdsEstadosBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Estados, TCosmosConfMsg.DeleteUF) = mrNo  then
  Abort;
end;

procedure TFrmEditEstados.CdsEstadosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   CdsEstados.Fields.FieldByName('codpai').Value := FmeSearchData1.CosmosData.FindValue('codpai');
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

end.
