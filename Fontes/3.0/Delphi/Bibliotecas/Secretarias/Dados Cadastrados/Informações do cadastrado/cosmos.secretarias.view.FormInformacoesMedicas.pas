unit cosmos.secretarias.view.FormInformacoesMedicas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, cosmos.frames.gridsearch,
  GroupHeader, Mask, DBCtrls, cosmos.frames.fkSearch, DB, DBClient, cosmos.classes.ServerInterface,
  cosmos.framework.interfaces.root, Cosmos.Framework.Interfaces.Dialogs,
  FrameDeleteButtons, cosmos.system.messages, cosmos.classes.security,
  Cosmos.Framework.Interfaces.DataAcess, Datasnap.DSConnect;

type
  TFrmInformacoesMedicas = class(TFrmCosmosHelpDialog)
    FmeGridSearch1: TFmeGridSearch;
    MSGroupHeader1: TMSGroupHeader;
    FmeFkEnfermidades: TFmeFKSearch;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    CdsInfoMedicas: TClientDataSet;
    FmeDBDelButtons1: TFmeDBDelButtons;
    MSGroupHeader2: TMSGroupHeader;
    EdtCadastrado: TEdit;
    procedure CdsInfoMedicasBeforeDelete(DataSet: TDataSet);
    procedure CdsInfoMedicasBeforePost(DataSet: TDataSet);
    procedure CdsInfoMedicasAfterPost(DataSet: TDataSet);
    procedure CdsInfoMedicasAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsInfoMedicasReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure CadastrarInfoMedicas(const codcad: integer; nomcad: string);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmInformacoesMedicas: TFrmInformacoesMedicas;

implementation

{$R *.dfm}

procedure TFrmInformacoesMedicas.CdsInfoMedicasAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.Fields.FieldByName('codcad').AsInteger := CdsInfoMedicas.Params.Items[0].AsInteger;
end;

procedure TFrmInformacoesMedicas.CdsInfoMedicasAfterPost(DataSet: TDataSet);
begin
  inherited;
  if CdsInfoMedicas.ChangeCount > 0 then
   CdsInfoMedicas.ApplyUpdates(0);
end;

procedure TFrmInformacoesMedicas.CdsInfoMedicasBeforeDelete(DataSet: TDataSet);
begin
  inherited;
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InformacoeMedicas, TCosmosConfMsg.DeleteInfoMedica) = mrNo then
  Abort;
end;

procedure TFrmInformacoesMedicas.CdsInfoMedicasBeforePost(DataSet: TDataSet);
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

procedure TFrmInformacoesMedicas.CdsInfoMedicasReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmInformacoesMedicas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 if CdsInfoMedicas.Active then CdsInfoMedicas.Close;

 CdsInfoMedicas.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmInformacoesMedicas.FormCreate(Sender: TObject);
begin
  inherited;
  FICosmosApp := Application.MainForm as ICosmosApplication;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scCommon);
  CdsInfoMedicas.RemoteServer := FRemoteConnection;

  FmeFkEnfermidades.Configure('codenf', csEnfermidades);

  CdsInfoMedicas.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
    and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

procedure TFrmInformacoesMedicas.CadastrarInfoMedicas(const codcad: integer;
   nomcad: string);
begin
 CdsInfoMedicas.Params.Items[0].AsInteger := codcad;
 CdsInfoMedicas.Open;
 EdtCadastrado.Text := nomcad;
 ShowModal;
end;

end.
