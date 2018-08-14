unit cosmos.conferencias.view.FormEditarLeito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, DB, DBClient,
  cosmos.frames.fkSearch, Mask, DBCtrls, FrameDBInsertVertical, cosmos.system.dataconverter,
  cosmos.classes.ServerInterface, cosmos.classes.application, Datasnap.DSConnect,
  cosmos.Framework.Interfaces.dataacess;

type
  TFrmEditarLeito = class(TFrmCosmosHelpDialog)
    CdsLeito: TClientDataSet;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    DBEdit2: TDBEdit;
    FmeFkHabitue: TFmeFKSearch;
    DBCheckBox1: TDBCheckBox;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure CdsLeitoAfterInsert(DataSet: TDataSet);
    procedure CdsLeitoAfterPost(DataSet: TDataSet);
    procedure CdsLeitoBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsLeitoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FDefaultData: TCosmosData;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoLeito(AData: TCosmosData);
    procedure EditarLeito(const codlei: integer);

    property DefaultData: TCosmosData read FDefaultData;
  end;

var
  FrmEditarLeito: TFrmEditarLeito;

implementation

{$R *.dfm}

{ TFrmEditarLeito }

procedure TFrmEditarLeito.CdsLeitoAfterInsert(DataSet: TDataSet);
begin
  inherited;
  with Dataset.Fields do
   begin
    FieldByName('indblo').AsString := TDataConverter.ToBoleanString(False);
    FieldByName('codalo').Value := DefaultData.FindValue('codalo');
    FieldByName('nomalo').Value := DefaultData.FindValue('nomalo');
    FieldByName('alaqua').Value := DefaultData.FindValue('alaqua');
    FieldByName('numqua').Value := DefaultData.FindValue('numqua');
    FieldByName('codqua').Value := DefaultData.FindValue('codqua');
   end;
end;

procedure TFrmEditarLeito.CdsLeitoAfterPost(DataSet: TDataSet);
begin
  inherited;
  if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditarLeito.CdsLeitoBeforePost(DataSet: TDataSet);
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

procedure TFrmEditarLeito.CdsLeitoReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
  Action := ICosmosApp.IRemoteCon.ReconcileError(E, Updatekind);
end;

procedure TFrmEditarLeito.EditarLeito(const codlei: integer);
begin
 CdsLeito.Params.Items[0].Value := codlei;
 CdsLeito.Open;
 ShowModal;
end;

procedure TFrmEditarLeito.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
 if CdsLeito.Active then CdsLeito.Close;
 CdsLeito.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarLeito.FormCreate(Sender: TObject);
begin
  inherited;
  FDefaultData := TCosmosData.Create(5);

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsLeito.RemoteServer := FRemoteConnection;

  FmeFkHabitue.Configure('codcad', csAlunos);
end;

procedure TFrmEditarLeito.NovoLeito(AData: TCosmosData);
begin
 DefaultData.CopyData(AData);
 CdsLeito.Open;
 ShowModal;
end;

end.
