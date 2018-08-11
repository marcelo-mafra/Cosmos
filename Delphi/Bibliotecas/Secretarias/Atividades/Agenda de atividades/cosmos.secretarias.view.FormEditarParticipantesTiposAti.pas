unit cosmos.secretarias.view.FormEditarParticipantesTiposAti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameDeleteButtons, cosmos.frames.fkSearch, cosmos.frames.gridsearch, StdCtrls,
  Mask, DBCtrls, ExtCtrls, GroupHeader, DB, DBClient, cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.framework.interfaces.root,
  cosmos.system.messages, Datasnap.DSConnect, cosmos.classes.security;

type
  TFrmEditarParticipantesTiposAti = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    FmeGridSearch1: TFmeGridSearch;
    FmeFKDiscipulados: TFmeFKSearch;
    FmeDBDelButtons1: TFmeDBDelButtons;
    CdsTiposAtividades: TClientDataSet;
    CdsParticipantes: TClientDataSet;
    DsrTiposAtividades: TDataSource;
    procedure CdsParticipantesAfterInsert(DataSet: TDataSet);
    procedure CdsParticipantesBeforePost(DataSet: TDataSet);
    procedure CdsParticipantesBeforeDelete(DataSet: TDataSet);
    procedure CdsParticipantesAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsParticipantesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsParticipantesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarParticipantes(const codtipati: integer);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarParticipantesTiposAti: TFrmEditarParticipantesTiposAti;


implementation

{$R *.dfm}

procedure TFrmEditarParticipantesTiposAti.CdsParticipantesAfterInsert(
  DataSet: TDataSet);
begin
 Dataset.Fields.FieldByName('codtipati').Value := CdsParticipantes.Params.Items[0].Value;
end;

procedure TFrmEditarParticipantesTiposAti.CdsParticipantesAfterOpen(
  DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode = cmRead;
end;

procedure TFrmEditarParticipantesTiposAti.CdsParticipantesAfterPost(
  DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
  TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditarParticipantesTiposAti.CdsParticipantesBeforeDelete(
  DataSet: TDataSet);
begin
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.DelParticipante) = mrNo then
   Abort;
end;

procedure TFrmEditarParticipantesTiposAti.CdsParticipantesBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].Value := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
   if Dataset.Fields.Fields[0].Value = unassigned then
     Dataset.Cancel;
  end;
end;

procedure TFrmEditarParticipantesTiposAti.CdsParticipantesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarParticipantesTiposAti.EditarParticipantes(
  const codtipati: integer);
begin
 CdsTiposAtividades.Params.Items[0].Value := codtipati;
 CdsTiposAtividades.Open;

 CdsParticipantes.Params.Items[0].Value := codtipati;
 CdsParticipantes.Open; 

 ShowModal;
end;

procedure TFrmEditarParticipantesTiposAti.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsTiposAtividades.Active then CdsTiposAtividades.Close;
 CdsTiposAtividades.RemoteServer := nil;

 if CdsParticipantes.Active then CdsParticipantes.Close;
 CdsParticipantes.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarParticipantesTiposAti.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
 CdsTiposAtividades.RemoteServer := FRemoteConnection;
 CdsParticipantes.RemoteServer := FRemoteConnection;

 FmeFKDiscipulados.Configure('coddis', csDiscipulados);
end;

end.
