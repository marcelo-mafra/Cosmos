unit cosmos.common.view.EditBairros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, GroupHeader, ActnList, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.frames.fkSearch, Mask, DBCtrls, FrameDBInsertVertical,
  cosmos.framework.interfaces.root, cosmos.system.messages,
  cosmos.classes.ServerInterface, Datasnap.DSConnect;

type
  TFrmEditBairros = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    CdsBairros: TClientDataSet;
    Label3: TLabel;
    FmeFKSearchCidade: TFmeFKSearch;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    procedure CdsBairrosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsBairrosBeforePost(DataSet: TDataSet);
    procedure CdsBairrosBeforeDelete(DataSet: TDataSet);
    procedure CdsBairrosAfterPost(DataSet: TDataSet);
    procedure CdsBairrosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FSearchMode: boolean;
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoBairro;
    procedure EditarBairro(const codbai: integer); overload;
    function Search: integer;

    property ICosmosApp: ICosmosApplication read FICosmosApp;

  end;

var
  FrmEditBairros: TFrmEditBairros;

implementation



{$R *.dfm}

procedure TFrmEditBairros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CdsBairros.Active then CdsBairros.Close;
 CdsBairros.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditBairros.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsBairros.RemoteServer := FRemoteConnection;

 FmeFKSearchCidade.Configure('codcid', csCidades);
end;

procedure TFrmEditBairros.CdsBairrosAfterInsert(DataSet: TDataSet);
begin
 with TClientDataset(Dataset) do
  begin
   Fields.FieldByName('codcid').AsInteger := Params.Items[0].AsInteger;
   if Visible then
    Fields.FieldByName('nombai').FocusControl;
  end;
end;

procedure TFrmEditBairros.CdsBairrosAfterPost(DataSet: TDataSet);
begin
 CdsBairros.ApplyUpdates(0);
end;

procedure TFrmEditBairros.CdsBairrosBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Bairros, TCosmosConfMsg.DeleteBairro) = mrNo then
  Abort;
end;

procedure TFrmEditBairros.CdsBairrosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditBairros.CdsBairrosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Bairros, E.Message);
end;

function TFrmEditBairros.Search: integer;
begin
 FSearchMode := True;
 Result :=  ShowModal;
end;

procedure TFrmEditBairros.EditarBairro(const codbai: integer);
begin
 FSearchMode := False;
 CdsBairros.Params.Items[0].Value := codbai;
 CdsBairros.Open;
 ShowModal;
end;

procedure TFrmEditBairros.NovoBairro;
begin
 FSearchMode := False;
 CdsBairros.Params.Items[0].Value := 0;
 CdsBairros.Open;
 ShowModal;
end;

end.
