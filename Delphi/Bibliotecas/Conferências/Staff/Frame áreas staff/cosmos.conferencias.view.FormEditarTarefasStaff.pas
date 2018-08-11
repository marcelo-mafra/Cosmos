unit cosmos.conferencias.view.FormEditarTarefasStaff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ActnList, cosmos.classes.ServerInterface,
  Datasnap.DBClient, Vcl.Mask, Vcl.DBCtrls, cosmos.classes.application,
  cosmos.framework.interfaces.Dataacess, System.Actions, Datasnap.DSConnect,
  cosmos.framework.interfaces.Root;

type
  TFrmEditarTarefasStaff = class(TForm)
    EdtArea: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel1: TBevel;
    ActionList1: TActionList;
    ActNova: TAction;
    ActPost: TAction;
    ActClose: TAction;
    CdsTarefasArea: TClientDataSet;
    DsrTarefasArea: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    procedure ActNovaExecute(Sender: TObject);
    procedure ActPostExecute(Sender: TObject);
    procedure ActPostUpdate(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure CdsTarefasAreaAfterPost(DataSet: TDataSet);
    procedure CdsTarefasAreaAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsTarefasAreaBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsTarefasAreaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FCodare: integer;
    FRemoteConnection: TDSProviderConnection;
    FICosmosApp: ICosmosApplication;

  public
    { Public declarations }
    procedure NovaTarefa(AAreaData: TCosmosData);
    procedure EditarTarefa(AAreaData: TCosmosData);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarTarefasStaff: TFrmEditarTarefasStaff;

implementation

{$R *.dfm}

{ TFrmEditarTarefasStaff }

procedure TFrmEditarTarefasStaff.ActCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmEditarTarefasStaff.ActNovaExecute(Sender: TObject);
begin
 self.CdsTarefasArea.Insert;
 CdsTarefasArea.Fields.FieldByName('codare').Value := FCodare;
 CdsTarefasArea.Fields.FieldByName('destar').FocusControl;
end;

procedure TFrmEditarTarefasStaff.ActPostExecute(Sender: TObject);
begin
 CdsTarefasArea.Post;
end;

procedure TFrmEditarTarefasStaff.ActPostUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsTarefasArea.Active) and (CdsTarefasArea.State <> dsBrowse);
end;

procedure TFrmEditarTarefasStaff.CdsTarefasAreaAfterInsert(DataSet: TDataSet);
begin
 CdsTarefasArea.Fields.FieldByName('codare').Value := FCodare;
end;

procedure TFrmEditarTarefasStaff.CdsTarefasAreaAfterPost(DataSet: TDataSet);
begin
 if CdsTarefasArea.ChangeCount > 0 then
  CdsTarefasArea.ApplyUpdates(0);
end;

procedure TFrmEditarTarefasStaff.CdsTarefasAreaBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.FieldValues['codtar'] := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarTarefasStaff.CdsTarefasAreaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarTarefasStaff.EditarTarefa(AAreaData: TCosmosData);
begin
 FCodare := AAreaData.FindValue('CODARE');
 EdtArea.Text := AAreaData.FindValue('NOMARE');

 CdsTarefasArea.Params.Items[0].Value := FCodare;
 CdsTarefasArea.Open;
 CdsTarefasArea.Locate('CODTAR', AAreaData.FindValue('CODTAR'), []);

 ShowModal;
end;

procedure TFrmEditarTarefasStaff.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsTarefasArea.Active then CdsTarefasArea.Close;
  CdsTarefasArea.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmEditarTarefasStaff.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
 CdsTarefasArea.RemoteServer := FRemoteConnection;
end;

procedure TFrmEditarTarefasStaff.NovaTarefa(AAreaData: TCosmosData);
begin
 FCodare := AAreaData.FindValue('CODARE');
 EdtArea.Text := AAreaData.FindValue('NOMARE');
 CdsTarefasArea.Params.Items[0].Value := 0;
 CdsTarefasArea.Open;
 CdsTarefasArea.Insert;

 ShowModal;
end;

end.
