unit cosmos.conferencias.view.FormAnotacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Data.DB, Datasnap.DBClient, cosmos.frames.gridsearch, Vcl.ExtCtrls, GroupHeader,
  FrameDBInsertVertical, cosmos.framework.interfaces.root, Datasnap.DSConnect,
  cosmos.framework.interfaces.dataacess;

type
  TFrmAnotacoes = class(TForm)
    CdsAnotacoes: TClientDataSet;
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    DBCheckBox1: TDBCheckBox;
    MSGroupHeader2: TMSGroupHeader;
    FmeGridSearch: TFmeGridSearch;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsAnotacoesAfterPost(DataSet: TDataSet);
    procedure CdsAnotacoesBeforePost(DataSet: TDataSet);
    procedure CdsAnotacoesAfterInsert(DataSet: TDataSet);
    procedure CdsAnotacoesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarAnotacao(const codins: integer);
    property ICosmosApp: ICosmosApplication read FICosmosApp;

  end;

var
  FrmAnotacoes: TFrmAnotacoes;

implementation

{$R *.dfm}

procedure TFrmAnotacoes.CdsAnotacoesAfterInsert(DataSet: TDataSet);
begin
 Dataset.FieldValues['CODINS'] := CdsAnotacoes.Params.Items[0].Value;
end;

procedure TFrmAnotacoes.CdsAnotacoesAfterPost(DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmAnotacoes.CdsAnotacoesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
   Dataset.FieldValues['RESNOT'] := UpperCase(ICosmosApp.IRemoteCon.CurrentUser.UserName);
   Dataset.FieldValues['DATCAD'] := ICosmosApp.IRemoteCon.ServerDateTime;
  end;
end;

procedure TFrmAnotacoes.CdsAnotacoesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmAnotacoes.EditarAnotacao(const codins: integer);
begin
 CdsAnotacoes.Params.Items[0].Value := codins;
 CdsAnotacoes.Open;
 ShowModal;
end;

procedure TFrmAnotacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CdsAnotacoes.Active then CdsAnotacoes.Close;
  CdsAnotacoes.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(ICosmosApp) then
  FICosmosApp := nil;
end;

procedure TFrmAnotacoes.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
 CdsAnotacoes.RemoteServer := FRemoteConnection;
end;

end.
