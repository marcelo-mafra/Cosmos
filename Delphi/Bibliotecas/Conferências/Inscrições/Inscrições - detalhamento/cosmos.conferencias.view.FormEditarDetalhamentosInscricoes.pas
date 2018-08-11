unit cosmos.conferencias.view.FormEditarDetalhamentosInscricoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, FrameDBInsertVertical,
  GroupHeader, DB, DBClient, Mask, DBCtrls, cosmos.frames.fkSearch,
  cosmos.classes.ServerInterface, Datasnap.DSConnect,
  cosmos.framework.interfaces.dataacess;

type
  TFrmEditarDetalhamentosInscricoes = class(TFrmCosmosHelpDialog)
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    CdsDetalheInscricoes: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    FmeFkClassificadores: TFmeFKSearch;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CdsDetalheInscricoesAfterInsert(DataSet: TDataSet);
    procedure CdsDetalheInscricoesAfterPost(DataSet: TDataSet);
    procedure CdsDetalheInscricoesBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsDetalheInscricoesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoDetalhe;
    procedure EditarDetalhes(const coddet: integer);
  end;

var
  FrmEditarDetalhamentosInscricoes: TFrmEditarDetalhamentosInscricoes;

implementation

{$R *.dfm}

procedure TFrmEditarDetalhamentosInscricoes.CdsDetalheInscricoesAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  Dataset.Fields.FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
end;

procedure TFrmEditarDetalhamentosInscricoes.CdsDetalheInscricoesAfterPost(
  DataSet: TDataSet);
begin
  inherited;
 if CdsDetalheInscricoes.ChangeCount > 0 then
  CdsDetalheInscricoes.ApplyUpdates(0);
end;

procedure TFrmEditarDetalhamentosInscricoes.CdsDetalheInscricoesBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
  inherited;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.FieldValues['codite'] := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarDetalhamentosInscricoes.CdsDetalheInscricoesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := ICosmosApp.IRemoteCon.ReconcileError(E, Updatekind);
end;

procedure TFrmEditarDetalhamentosInscricoes.EditarDetalhes(const coddet: integer);
begin
 with CdsDetalheInscricoes do
  begin
   Params.Items[0].AsInteger := coddet;
   Open;
  end;

 ShowModal;
end;

procedure TFrmEditarDetalhamentosInscricoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if CdsDetalheInscricoes.Active then CdsDetalheInscricoes.Close;
  CdsDetalheInscricoes.RemoteServer := nil;

  if Assigned(FRemoteConnection) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarDetalhamentosInscricoes.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsDetalheInscricoes.RemoteServer := FRemoteConnection;

  FmeFkClassificadores.CosmosSearch := csGeneralFlagsInscricoes;
end;

procedure TFrmEditarDetalhamentosInscricoes.NovoDetalhe;
begin
 with CdsDetalheInscricoes do
  begin
   Params.Items[0].AsInteger := -1;
   Open;
  end;

 CdsDetalheInscricoes.Insert;
 ShowModal;
end;

end.
