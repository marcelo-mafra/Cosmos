unit cosmos.conferencias.view.FormEditarClassificadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.interfaces.Root, cosmos.framework.interfaces.DataAcess,
  DB, DBClient, FrameDBInsertVertical, StdCtrls, Mask, DBCtrls,
  cosmos.classes.application, Datasnap.DSConnect;

type
  TFrmEditarClassificadores = class(TForm)
    CdsClassificador: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CdsClassificadorAfterPost(DataSet: TDataSet);
    procedure CdsClassificadorBeforePost(DataSet: TDataSet);
    procedure CdsClassificadorAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsClassificadorReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    function GetICosmosApp: ICosmosApplication;

  public
    { Public declarations }
    procedure NovoClassificador;
    procedure EditarClassificador(const codatr: integer);

    property ICosmosApp: ICosmosApplication read GetICosmosApp;
  end;

var
  FrmEditarClassificadores: TFrmEditarClassificadores;

implementation

{$R *.dfm}

{ TFrmEditarClassificadores }

procedure TFrmEditarClassificadores.CdsClassificadorAfterInsert(
  DataSet: TDataSet);
begin
if self.Visible then
 self.DBEdit1.SetFocus;
end;

procedure TFrmEditarClassificadores.CdsClassificadorAfterPost(
  DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
  TCLientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditarClassificadores.CdsClassificadorBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarClassificadores.CdsClassificadorReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarClassificadores.EditarClassificador(const codatr: integer);
begin
 self.CdsClassificador.Params.Items[0].AsInteger := codatr;
 self.CdsClassificador.Open;
 ShowModal;
end;

procedure TFrmEditarClassificadores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsClassificador.Active then CdsClassificador.Close;
  CdsClassificador.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarClassificadores.FormCreate(Sender: TObject);
begin
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsClassificador.RemoteServer := FRemoteConnection;
end;

function TFrmEditarClassificadores.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

procedure TFrmEditarClassificadores.NovoClassificador;
begin
 CdsClassificador.Open;
 CdsClassificador.Insert;
 ShowModal;
end;

end.
