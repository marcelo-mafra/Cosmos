unit cosmos.conferencias.view.FormEditarQuarto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, DBCtrls, cosmos.system.dataconverter,
  cosmos.frames.fkSearch, Mask, GroupHeader, DB, DBClient, cosmos.classes.application,
  cosmos.classes.ServerInterface, cosmos.frames.gridsearch, FrameDBInsertVertical,
  Datasnap.DSConnect, cosmos.Framework.Interfaces.dataacess;

type
  TFrmEditarQuartos = class(TFrmCosmosHelpDialog)
    CdsQuartos: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    FmeFKAlojamento: TFmeFKSearch;
    DBCheckBox1: TDBCheckBox;
    DBEdit2: TDBEdit;
    FmeGridQuartos: TFmeGridSearch;
    DBComboBox1: TDBComboBox;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    procedure FormCreate(Sender: TObject);
    procedure CdsQuartosAfterInsert(DataSet: TDataSet);
    procedure CdsQuartosAfterPost(DataSet: TDataSet);
    procedure CdsQuartosBeforePost(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsQuartosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    Alojamento: TCosmosData;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarQuartos(AData: TCosmosData);
  end;

var
  FrmEditarQuartos: TFrmEditarQuartos;

implementation

{$R *.dfm}

procedure TFrmEditarQuartos.CdsQuartosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  with CdsQuartos.Fields do
   begin
    FieldByName('codalo').Value := Alojamento.FindValue('codalo');
    FieldByName('nomalo').Value := Alojamento.FindValue('nomalo');
    FieldByName('indtra').Value := TDataConverter.ToBoleanString(False);
   end;
end;

procedure TFrmEditarQuartos.CdsQuartosAfterPost(DataSet: TDataSet);
begin
  inherited;
  if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditarQuartos.CdsQuartosBeforePost(DataSet: TDataSet);
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

procedure TFrmEditarQuartos.CdsQuartosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarQuartos.EditarQuartos(AData: TCosmosData);
begin
 Alojamento.CopyData(AData);
 CdsQuartos.Params.Items[0].AsInteger := Alojamento.FindValue('codalo');
 CdsQuartos.Open;
 ShowModal;
end;

procedure TFrmEditarQuartos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 if CdsQuartos.Active then CdsQuartos.Close;
 CdsQuartos.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarQuartos.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsQuartos.RemoteServer := FRemoteConnection;

  FmeFKAlojamento.Configure('codalo', csAlojamentosFoco);

  Alojamento := TCosmosData.Create(2);
end;

procedure TFrmEditarQuartos.FormDestroy(Sender: TObject);
begin
  inherited;
  {Este código somente está aqui pelo fato de a referência oa dataset, nesta
  janela está dando pau se não é anulada.}
  FmeDBInsertVertical1.DataSource1.DataSet := nil;
end;

end.
