unit cosmos.conferencias.view.FormEditarFlagsInscricoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, FrameDBInsertVertical,
  GroupHeader, DB, DBClient, Mask, DBCtrls, cosmos.frames.gridsearch,
  cosmos.system.messages, Datasnap.DSConnect,cosmos.framework.interfaces.dataacess;

type
  TFrmFlagsInscricoes = class(TFrmCosmosHelpDialog)
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    CdsFlagsInscricoes: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    Label3: TLabel;
    FmeGridSearchDetalhes: TFmeGridSearch;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure CdsFlagsInscricoesAfterPost(DataSet: TDataSet);
    procedure CdsFlagsInscricoesBeforePost(DataSet: TDataSet);
    procedure CdsFlagsInscricoesBeforeDelete(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsFlagsInscricoesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoFlag;
  end;

var
  FrmFlagsInscricoes: TFrmFlagsInscricoes;

implementation

{$R *.dfm}

procedure TFrmFlagsInscricoes.CdsFlagsInscricoesAfterPost(
  DataSet: TDataSet);
begin
  inherited;
 if CdsFlagsInscricoes.ChangeCount > 0 then
  CdsFlagsInscricoes.ApplyUpdates(0);
end;

procedure TFrmFlagsInscricoes.CdsFlagsInscricoesBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.InscricoesConferencia, TCosmosInfoMsg.CannotDelFlagInscricao);
  Abort;
end;

procedure TFrmFlagsInscricoes.CdsFlagsInscricoesBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
  inherited;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.FieldValues['codfla'] := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmFlagsInscricoes.CdsFlagsInscricoesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := ICosmosApp.IRemoteCon.ReconcileError(E, Updatekind);
end;

procedure TFrmFlagsInscricoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if CdsFlagsInscricoes.Active then CdsFlagsInscricoes.Close;
  CdsFlagsInscricoes.RemoteServer := nil;

  if Assigned(FRemoteConnection) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmFlagsInscricoes.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsFlagsInscricoes.RemoteServer := FRemoteConnection;
end;

procedure TFrmFlagsInscricoes.NovoFlag;
begin
 CdsFlagsInscricoes.Open;
 ShowModal;
end;

end.
