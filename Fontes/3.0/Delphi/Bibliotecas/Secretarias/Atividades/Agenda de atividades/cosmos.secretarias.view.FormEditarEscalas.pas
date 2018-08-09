unit cosmos.secretarias.view.FormEditarEscalas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ExtCtrls, GroupHeader, DB, DBClient,
  cosmos.frames.fkSearch, FrameDeleteButtons, cosmos.frames.gridsearch,
  cosmos.framework.interfaces.root, cosmos.framework.interfaces.DataAcess,
  cosmos.classes.ServerInterface, cosmos.system.messages,
  cosmos.classes.security, Datasnap.DSConnect;

type
  TFrmEditarEscalas = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    Label6: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    FmeDBDelButtons1: TFmeDBDelButtons;
    FmeFKEscalado: TFmeFKSearch;
    CdsAtividade: TClientDataSet;
    DsrAtividade: TDataSource;
    CdsEscalas: TClientDataSet;
    FmeFKFuncao: TFmeFKSearch;
    Label1: TLabel;
    procedure CdsEscalasAfterInsert(DataSet: TDataSet);
    procedure CdsEscalasAfterPost(DataSet: TDataSet);
    procedure CdsEscalasBeforeDelete(DataSet: TDataSet);
    procedure CdsEscalasBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CdsEscalasReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsEscalasAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarEscalas(const codati: integer);
    property ICosmosApp: ICosmosApplication read  FICosmosApp;
  end;

var
  FrmEditarEscalas: TFrmEditarEscalas;

implementation

{$R *.dfm}

procedure TFrmEditarEscalas.CdsEscalasAfterInsert(DataSet: TDataSet);
begin
  Dataset.Fields.FieldByName('codati').Value :=
    CdsAtividade.Fields.FieldByName('codati').Value;
end;

procedure TFrmEditarEscalas.CdsEscalasAfterOpen(DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode = cmRead;
end;

procedure TFrmEditarEscalas.CdsEscalasAfterPost(DataSet: TDataSet);
begin
 if CdsEscalas.ChangeCount > 0 then
  CdsEscalas.ApplyUpdates(0);
end;

procedure TFrmEditarEscalas.CdsEscalasBeforeDelete(DataSet: TDataSet);
begin
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.DelFuncao) = mrNo then
   Abort;
end;

procedure TFrmEditarEscalas.CdsEscalasBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');

   try
    Dataset.Fields.Fields[0].Value := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
    if Dataset.Fields.Fields[0].Value = unassigned then
     Dataset.Cancel;

   except
     Dataset.Cancel;
   end;
  end;
end;

procedure TFrmEditarEscalas.CdsEscalasReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarEscalas.EditarEscalas(const codati: integer);
begin
 CdsAtividade.Params.Items[0].Value := codati;
 CdsAtividade.Open;

 CdsEscalas.Params.Items[0].Value := codati;
 CdsEscalas.Open;
 CdsEscalas.ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite;
 ShowModal;
end;

procedure TFrmEditarEscalas.FormCreate(Sender: TObject);
begin
  inherited;
  FICosmosApp := Application.MainForm as ICosmosApplication;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
  CdsAtividade.RemoteServer := FRemoteConnection;
  CdsEscalas.RemoteServer := FRemoteConnection;

  FmeFKEscalado.Configure('codcad', csAlunos);
  FmeFKFuncao.Configure('codtipatu', csTipoAtuacao);
  FmeGridSearch1.SearchFields := 'nomcad';
end;

procedure TFrmEditarEscalas.FormDestroy(Sender: TObject);
begin
 if CdsAtividade.Active then CdsAtividade.Close;
 CdsAtividade.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

end.
