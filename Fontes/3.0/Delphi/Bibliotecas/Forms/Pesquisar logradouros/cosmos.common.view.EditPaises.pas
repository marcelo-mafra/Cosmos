unit cosmos.common.view.EditPaises;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, cosmos.frames.gridsearch, StdCtrls,
  cosmos.framework.interfaces.root, cosmos.framework.interfaces.dataAcess,
  FrameDBInsertVertical, cosmos.system.messages, Datasnap.DSConnect;

type
  TFrmDlgPaises = class(TForm)
    CdsPaises: TClientDataSet;
    Label1: TLabel;
    FmeGridSearchPaises: TFmeGridSearch;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    procedure CdsPaisesBeforeDelete(DataSet: TDataSet);
    procedure CdsPaisesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsPaisesBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsPaisesAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
   FICosmosApp: ICosmosApplication;
   FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarPaises;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmDlgPaises: TFrmDlgPaises;

implementation


{$R *.dfm}

{ TFrmDlgPaises }

procedure TFrmDlgPaises.EditarPaises;
begin
 CdsPaises.Open;
 ShowModal;
end;

procedure TFrmDlgPaises.CdsPaisesAfterPost(DataSet: TDataSet);
begin
 if CdsPaises.ChangeCount > 0 then
  CdsPaises.ApplyUpdates(0);
end;

procedure TFrmDlgPaises.CdsPaisesBeforeDelete(DataSet: TDataSet);
begin
 Abort;
end;

procedure TFrmDlgPaises.CdsPaisesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 inherited;
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmDlgPaises.CdsPaisesReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
end;

procedure TFrmDlgPaises.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CdsPaises.Active then CdsPaises.Close;
 CdsPaises.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmDlgPaises.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsPaises.RemoteServer := FRemoteConnection;

 FmeGridSearchPaises.SearchFields := 'nompai';
end;

end.
