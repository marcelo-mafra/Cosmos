unit cosmos.conferencias.view.frmeditparticipantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, DB, DBClient, GroupHeader,
  cosmos.frames.gridsearch, Cosmos.Framework.Interfaces.DataAcess, Mask, DBCtrls,
  Buttons, FrameDeleteButtons, cosmos.frames.fkSearch, cosmos.classes.ServerInterface,
  cosmos.system.messages, ComCtrls, Datasnap.DSConnect, Cosmos.Framework.Interfaces.Root;

type
  TFrmEditarParticipantes = class(TFrmCosmosHelpDialog)
    MSGroupHeader1: TMSGroupHeader;
    CdsConferencia: TClientDataSet;
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
    procedure CdsParticipantesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsParticipantesAfterPost(DataSet: TDataSet);
    procedure CdsParticipantesBeforePost(DataSet: TDataSet);
    procedure CdsParticipantesAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    FICosmosApp: ICosmosApplication;

  public
    { Public declarations }
    procedure EditarParticipantes(const codcon: integer);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarParticipantes: TFrmEditarParticipantes;

implementation

{$R *.dfm}

procedure TFrmEditarParticipantes.CdsFocosBeforeDelete(DataSet: TDataSet);
begin
  inherited;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Conferencias, TCosmosConfMsg.DelFocoParticipanteConf) = mrNo then
   Abort;
end;

procedure TFrmEditarParticipantes.CdsParticipantesAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  Dataset.Fields.FieldByName('codcon').Value :=
    CdsConferencia.Fields.FieldByName('codcon').Value;
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
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Conferencias, TCosmosConfMsg.DelParticipanteConf) = mrNo then
   Abort;
end;

procedure TFrmEditarParticipantes.CdsParticipantesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 inherited;
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarParticipantes.CdsParticipantesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarParticipantes.EditarParticipantes(const codcon: integer);
begin
 CdsConferencia.Params.Items[0].Value := codcon;
 CdsConferencia.Open;

 CdsParticipantes.Params.Items[0].Value := codcon;
 CdsParticipantes.Open;

 CdsFocos.Params.Items[0].Value := codcon;
 CdsFocos.Open;

 ShowModal;
end;

procedure TFrmEditarParticipantes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 if CdsConferencia.Active then CdsConferencia.Close;
 CdsConferencia.RemoteServer := nil;

 if CdsParticipantes.Active then CdsParticipantes.Close;
 CdsParticipantes.RemoteServer := nil;

 if CdsFocos.Active then CdsFocos.Close;
 CdsFocos.RemoteServer := nil;

 if (Assigned(ICosmosApp.IRemoteCon)) and (Assigned(FRemoteConnection)) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarParticipantes.FormCreate(Sender: TObject);
begin
  inherited;
  FICosmosApp := Application.MainForm as ICosmosApplication;

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsConferencia.RemoteServer := FRemoteConnection;
  CdsParticipantes.RemoteServer := FRemoteConnection;
  CdsFocos.RemoteServer := FRemoteConnection;

  FmeFKDiscipulados.Configure('coddis', csDiscipulados);
  FmeFkSearchFocos.Configure('codfoc', csFocos);

  FmeGridSearch1.ShowSearchBar := False;
  FmeGridSearch2.ShowSearchBar := False;
end;

end.
