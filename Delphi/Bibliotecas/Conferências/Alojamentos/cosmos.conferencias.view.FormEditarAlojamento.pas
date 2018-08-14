unit cosmos.conferencias.view.FormEditarAlojamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, DB, DBClient, GroupHeader,
  Mask, DBCtrls, cosmos.frames.fkSearch, cosmos.classes.ServerInterface, ComCtrls,
  FrameDBInsertVertical, Datasnap.DSConnect, cosmos.Framework.Interfaces.dataacess,
  cosmos.classes.Application, cosmos.system.dataconverter;

type
  TFrmEditarAlojamento = class(TFrmCosmosHelpDialog)
    CdsAlojamento: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    FmeFKFocos: TFmeFKSearch;
    Label3: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    procedure FormCreate(Sender: TObject);
    procedure CdsAlojamentoAfterPost(DataSet: TDataSet);
    procedure CdsAlojamentoBeforePost(DataSet: TDataSet);
    procedure CdsAlojamentoAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsAlojamentoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }

    procedure NovoAlojamento;
    procedure EditarAlojamento(const codalo: integer);
  end;

var
  FrmEditarAlojamento: TFrmEditarAlojamento;

implementation

{$R *.dfm}

{ TFrmEditarAlojamento }

procedure TFrmEditarAlojamento.CdsAlojamentoAfterInsert(DataSet: TDataSet);
begin
  inherited;
  with Dataset.Fields do
   begin
     FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
     FieldByName('nomfoc').Value := ICosmosApp.ActiveFocus.FocusName;
     FieldByName('indext').Value := TDataConverter.ToBoleanString(False);
   end;
end;

procedure TFrmEditarAlojamento.CdsAlojamentoAfterPost(DataSet: TDataSet);
begin
  inherited;
  if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditarAlojamento.CdsAlojamentoBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarAlojamento.CdsAlojamentoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := ICosmosApp.IRemoteCon.ReconcileError(E, Updatekind);
end;

procedure TFrmEditarAlojamento.EditarAlojamento(const codalo: integer);
begin
 CdsAlojamento.Params.Items[0].Value := codalo;
 CdsAlojamento.Open;
 ShowModal;
end;

procedure TFrmEditarAlojamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 if CdsAlojamento.Active then CdsAlojamento.Close;
 CdsAlojamento.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarAlojamento.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsAlojamento.RemoteServer := FRemoteConnection;

  FmeFKFocos.Configure('codfoc', csFocos);
end;

procedure TFrmEditarAlojamento.NovoAlojamento;
begin
 CdsAlojamento.Params.Items[0].Value := 0;
 CdsAlojamento.Open;
 CdsAlojamento.Insert;
 ShowModal;
end;

end.
