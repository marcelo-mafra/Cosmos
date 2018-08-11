unit cosmos.financeiro.view.FrmEditCentroCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosDialog, DB, DBClient, FrameDBInsertVertical, StdCtrls,
  DBCtrls, cosmos.frames.fkSearch, Buttons, Mask, ExtCtrls, GroupHeader,
  cosmos.system.messages, cosmos.classes.ServerInterface, cosmos.classes.application,
  cosmos.framework.interfaces.Root, Datasnap.DSConnect, cosmos.framework.interfaces.Dataacess;

type
  TFrmEditCentroCusto = class(TFrmCosmosDialog)
    CdsCentroCusto: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    FmeFKFocos: TFmeFKSearch;
    DBCheckBox1: TDBCheckBox;
    procedure CdsCentroCustoBeforePost(DataSet: TDataSet);
    procedure CdsCentroCustoAfterPost(DataSet: TDataSet);
    procedure CdsCentroCustoAfterInsert(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsCentroCustoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
  public
    { Public declarations }
    procedure NovoCentro;
    procedure EditarCentro(const codcen: integer);
  end;

var
  FrmEditCentroCusto: TFrmEditCentroCusto;

implementation

{$R *.dfm}

procedure TFrmEditCentroCusto.CdsCentroCustoAfterInsert(DataSet: TDataSet);
begin
  inherited;
 with Dataset.Fields do
  begin
    FieldByName('indati').Value := TDataConverter.ToBoleanString(True);
  end;
end;

procedure TFrmEditCentroCusto.CdsCentroCustoAfterPost(DataSet: TDataSet);
begin
  inherited;
 if CdsCentroCusto.ChangeCount > 0 then
  CdsCentroCusto.ApplyUpdates(0);
end;

procedure TFrmEditCentroCusto.CdsCentroCustoBeforePost(DataSet: TDataSet);
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

procedure TFrmEditCentroCusto.CdsCentroCustoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditCentroCusto.EditarCentro(const codcen: integer);
begin
 with CdsCentroCusto do
  begin
    Params.Items[0].Value := codcen;
    Open;
  end;

 ShowModal;
end;

procedure TFrmEditCentroCusto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditCentroCusto.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsCentroCusto.RemoteServer := FRemoteConnection;
  FmeFKFocos.Configure('codfoc', csFocos);
end;

procedure TFrmEditCentroCusto.NovoCentro;
begin
 with CdsCentroCusto do
  begin
    Params.Items[0].Value := 0;
    Open;
    Insert;
  end;

 ShowModal;
end;

procedure TFrmEditCentroCusto.SpeedButton1Click(Sender: TObject);
begin
  inherited;
 with CdsCentroCusto do
  begin
   if not (Fields.FieldByName('nomfoc').IsNull) then
    begin
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.CentrosCusto, TCosmosConfMsg.ClearFocoCentroCusto) = mrYes then
      begin
       Edit;
       Fields.FieldByName('nomfoc').Clear;
       Fields.FieldByName('codfoc').Clear;
      end;
    end;
  end;
end;

end.
