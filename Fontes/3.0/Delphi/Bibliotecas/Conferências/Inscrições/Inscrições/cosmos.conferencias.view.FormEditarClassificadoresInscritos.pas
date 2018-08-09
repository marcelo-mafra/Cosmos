unit cosmos.conferencias.view.FormEditarClassificadoresInscritos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, FrameDBInsertVertical, DB,
  DBClient, cosmos.frames.gridsearch, cosmos.frames.fkSearch,
  cosmos.classes.ServerInterface, Datasnap.DSConnect,
  cosmos.framework.interfaces.dataacess;

type
  TFrmEditarClassificadoresInscritos = class(TFrmCosmosHelpDialog)
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    CdsClassificadores: TClientDataSet;
    FmeFkClassificadores: TFmeFKSearch;
    FmeGridSearchClassificadores: TFmeGridSearch;
    procedure FormCreate(Sender: TObject);
    procedure CdsClassificadoresAfterInsert(DataSet: TDataSet);
    procedure CdsClassificadoresAfterPost(DataSet: TDataSet);
    procedure CdsClassificadoresBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsClassificadoresReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarClassificadores(const codcad: integer);
  end;

var
  FrmEditarClassificadoresInscritos: TFrmEditarClassificadoresInscritos;

implementation

{$R *.dfm}

procedure TFrmEditarClassificadoresInscritos.CdsClassificadoresAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  Dataset.Fields.FieldByName('codcad').Value := CdsClassificadores.Params.Items[0].Value;
  Dataset.Fields.FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
end;

procedure TFrmEditarClassificadoresInscritos.CdsClassificadoresAfterPost(
  DataSet: TDataSet);
begin
  inherited;
 if CdsClassificadores.ChangeCount > 0 then
  CdsClassificadores.ApplyUpdates(0);
end;

procedure TFrmEditarClassificadoresInscritos.CdsClassificadoresBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
  inherited;
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.FieldValues['codatrcad'] := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarClassificadoresInscritos.CdsClassificadoresReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarClassificadoresInscritos.EditarClassificadores(
  const codcad: integer);
begin
 with CdsClassificadores.Params do
  begin
    Items[0].Value := codcad;
    Items[1].Value := ICosmosApp.ActiveFocus.FocusID;
  end;

 CdsClassificadores.Open;
 ShowModal;
end;

procedure TFrmEditarClassificadoresInscritos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if CdsClassificadores.Active then CdsClassificadores.Close;
  CdsClassificadores.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarClassificadoresInscritos.FormCreate(Sender: TObject);
begin
 inherited;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
 CdsClassificadores.RemoteServer := FRemoteConnection;

 FmeFkClassificadores.CosmosSearch := csClassificadoresCadastrados;
 FmeGridSearchClassificadores.SearchFields := 'desatrcad';
end;

end.
