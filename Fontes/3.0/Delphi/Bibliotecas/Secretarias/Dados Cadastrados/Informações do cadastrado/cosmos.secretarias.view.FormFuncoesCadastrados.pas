unit cosmos.secretarias.view.FormFuncoesCadastrados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameDeleteButtons, cosmos.frames.fkSearch, StdCtrls, ExtCtrls,
  GroupHeader, cosmos.frames.gridsearch, cosmos.classes.ServerInterface, DB, DBClient,
  cosmos.framework.interfaces.root, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.frames.usuariocad, cosmos.system.messages, cosmos.classes.security,
  Cosmos.Framework.Interfaces.DataAcess, Datasnap.DSConnect;

type
  TFrmFuncoesCadastrados = class(TForm)
    FmeGridSearch1: TFmeGridSearch;
    CdsFuncoesCadastrado: TClientDataSet;
    FmeDBDelButtons1: TFmeDBDelButtons;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeFkFuncoes: TFmeFKSearch;
    Label2: TLabel;
    MSGroupHeader1: TMSGroupHeader;
    EdtCadastrado: TEdit;
    procedure CdsFuncoesCadastradoBeforeDelete(DataSet: TDataSet);
    procedure CdsFuncoesCadastradoBeforePost(DataSet: TDataSet);
    procedure CdsFuncoesCadastradoAfterInsert(DataSet: TDataSet);
    procedure CdsFuncoesCadastradoAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsFuncoesCadastradoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  protected


  public
    { Public declarations }
    procedure CadastrarFuncoes(const codcad: integer; nomcad: string);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmFuncoesCadastrados: TFrmFuncoesCadastrados;

implementation

{$R *.dfm}

procedure TFrmFuncoesCadastrados.CdsFuncoesCadastradoAfterInsert(
  DataSet: TDataSet);
begin
  Dataset.Fields.FieldByName('codcad').AsInteger :=
    CdsFuncoesCadastrado.Params.Items[0].AsInteger;
end;

procedure TFrmFuncoesCadastrados.CdsFuncoesCadastradoAfterPost(
  DataSet: TDataSet);
begin
 if CdsFuncoesCadastrado.ChangeCount > 0 then
  CdsFuncoesCadastrado.ApplyUpdates(0);
end;

procedure TFrmFuncoesCadastrados.CdsFuncoesCadastradoBeforeDelete(
  DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Funcoes, TCosmosConfMsg.DeleteFuncao) = mrNo then
  Abort;
end;

procedure TFrmFuncoesCadastrados.CdsFuncoesCadastradoBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
 inherited;
 DataSet.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);;
 DataSet.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;

 if Dataset.State = dsInsert then
   begin
    SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
    Dataset.Fields.Fields[0].AsInteger :=  ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
   end;
end;

procedure TFrmFuncoesCadastrados.CdsFuncoesCadastradoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmFuncoesCadastrados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsFuncoesCadastrado.Active then CdsFuncoesCadastrado.Close;

 CdsFuncoesCadastrado.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmFuncoesCadastrados.FormCreate(Sender: TObject);
begin
  FICosmosApp := Application.MainForm as ICosmosApplication;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scCommon);
  CdsFuncoesCadastrado.RemoteServer := FRemoteConnection;

  FmeFkFuncoes.Configure('codfun',csFuncoes);
  FmeGridSearch1.SearchFields := 'desfun';

  CdsFuncoesCadastrado.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
    and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

procedure TFrmFuncoesCadastrados.CadastrarFuncoes(const codcad: integer;
    nomcad: string);
begin
 CdsFuncoesCadastrado.Params.Items[0].AsInteger := codcad;
 CdsFuncoesCadastrado.Open;
 EdtCadastrado.Text := nomcad;

 ShowModal;
end;


end.
