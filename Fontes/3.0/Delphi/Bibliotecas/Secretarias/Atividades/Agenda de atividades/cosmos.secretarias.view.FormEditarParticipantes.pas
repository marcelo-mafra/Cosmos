unit cosmos.secretarias.view.FormEditarParticipantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, DB, DBClient, GroupHeader,
  cosmos.frames.gridsearch,  Mask, DBCtrls, Buttons, FrameDeleteButtons, ComCtrls,
  cosmos.frames.fkSearch, cosmos.classes.ServerInterface, cosmos.system.messages,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.framework.interfaces.root,
  cosmos.classes.security, Datasnap.DSConnect;

type
  TFrmEditarParticipantes = class(TFrmCosmosHelpDialog)
    MSGroupHeader1: TMSGroupHeader;
    CdsAtividade: TClientDataSet;
    CdsParticipantes: TClientDataSet;
    MSGroupHeader2: TMSGroupHeader;
    DsrAtividade: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FmeFKDiscipulados: TFmeFKSearch;
    FmeGridSearch1: TFmeGridSearch;
    FmeGridSearch2: TFmeGridSearch;
    FmeFKSearchFocos: TFmeFKSearch;
    CdsFocos: TClientDataSet;
    FmeDBDelButtons1: TFmeDBDelButtons;
    FmeDBDelButtons2: TFmeDBDelButtons;
    procedure CdsFocosBeforeDelete(DataSet: TDataSet);
    procedure CdsParticipantesBeforeDelete(DataSet: TDataSet);
    procedure CdsParticipantesAfterPost(DataSet: TDataSet);
    procedure CdsParticipantesBeforePost(DataSet: TDataSet);
    procedure CdsParticipantesAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CdsParticipantesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsParticipantesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarParticipantes(const codati: integer);

  end;

var
  FrmEditarParticipantes: TFrmEditarParticipantes;

implementation

{$R *.dfm}

procedure TFrmEditarParticipantes.CdsFocosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.DelFocoParticipante) = mrNo then
   Abort;
end;

procedure TFrmEditarParticipantes.CdsParticipantesAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  Dataset.Fields.FieldByName('codati').Value :=
    CdsAtividade.Fields.FieldByName('codati').Value;
end;

procedure TFrmEditarParticipantes.CdsParticipantesAfterOpen(DataSet: TDataSet);
begin
  inherited;
 TClientDataset(Dataset).ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode = cmRead;
end;

procedure TFrmEditarParticipantes.CdsParticipantesAfterPost(DataSet: TDataSet);
begin
  inherited;
 if TClientDataset(Dataset).ChangeCount > 0 then
  TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditarParticipantes.CdsParticipantesBeforeDelete(
  DataSet: TDataSet);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.DelParticipante) = mrNo then
    Abort;
end;

procedure TFrmEditarParticipantes.CdsParticipantesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');

   try
    Dataset.Fields.Fields[0].Value := IRemoteCon.GetSequenceValue(SequenceName);
    if Dataset.Fields.Fields[0].Value = unassigned then
     Dataset.Cancel;

   except
    Dataset.Cancel;
   end;
  end;
end;

procedure TFrmEditarParticipantes.CdsParticipantesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarParticipantes.EditarParticipantes(const codati: integer);
begin
 CdsAtividade.Params.Items[0].Value := codati;
 CdsAtividade.Open;

 CdsParticipantes.Params.Items[0].Value := codati;
 CdsParticipantes.Open;

 CdsFocos.Params.Items[0].Value := codati;
 CdsFocos.Open;

 ShowModal;
end;

procedure TFrmEditarParticipantes.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
  CdsParticipantes.RemoteServer := FRemoteConnection;
  CdsFocos.RemoteServer := FRemoteConnection;
  CdsAtividade.RemoteServer := FRemoteConnection;

  FmeFKDiscipulados.Configure('coddis', csDiscipulados);
  FmeFkSearchFocos.Configure('codfoc', csFocos);

  FmeGridSearch1.ShowSearchBar := False;
  FmeGridSearch2.ShowSearchBar := False;

 CdsParticipantes.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
 CdsFocos.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

procedure TFrmEditarParticipantes.FormDestroy(Sender: TObject);
begin
 if CdsAtividade.Active then CdsAtividade.Close;
 CdsAtividade.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  inherited;
end;

end.
