unit cosmos.secretarias.view.FormEditarAlocucoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, ExtCtrls, GroupHeader, DB,
  DBClient, ComCtrls, Grids, DBGrids, Buttons, FrameDBEditVertical,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.classes.security;

type
  TFrmEditarAlocucoes = class(TForm)
    CdsAlocucao: TClientDataSet;
    FmeDBEditVertical1: TFmeDBEditVertical;
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    MSGroupHeader3: TMSGroupHeader;
    DBMemo1: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure CdsAlocucaoAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsAlocucaoBeforePost(DataSet: TDataSet);
    procedure CdsAlocucaoAfterPost(DataSet: TDataSet);
    procedure CdsAlocucaoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FIRemoteCon: ICosmosRemoteConnection;

  public
    { Public declarations }
    procedure NovaAlocucao;
    procedure EditarAlocucao(const codalo: integer);
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;
  end;

var
  FrmEditarAlocucoes: TFrmEditarAlocucoes;

implementation

uses cosmos.framework.forms.mydialogs, cosmos.system.messages;



{$R *.dfm}

procedure TFrmEditarAlocucoes.CdsAlocucaoAfterInsert(DataSet: TDataSet);
begin
 with Dataset.Fields do
  begin
   FieldByName('INDLEC').AsString := 'S';
   FieldByName('INDTMO').AsString := 'N';
   FieldByName('INDTMB').AsString := 'N';
   FieldByName('INDTPU').AsString := 'N';
  end;
end;

procedure TFrmEditarAlocucoes.CdsAlocucaoAfterPost(DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditarAlocucoes.CdsAlocucaoBeforePost(DataSet: TDataSet);
var
Sequence: string;
begin
 if Dataset.State = dsInsert then
  begin
   Sequence := CdsAlocucao.GetOptionalParam('SequenceName');
   CdsAlocucao.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(Sequence);
  end;
end;

procedure TFrmEditarAlocucoes.CdsAlocucaoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarAlocucoes.EditarAlocucao(const codalo: integer);
begin
 CdsAlocucao.Params.Items[0].AsInteger := codalo;
 CdsAlocucao.Open;
 ShowModal;
end;

procedure TFrmEditarAlocucoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if Assigned(CdsAlocucao) then
  begin
   CdsAlocucao.Close;
   CdsAlocucao.ConnectionBroker := nil;
  end;
end;

procedure TFrmEditarAlocucoes.FormCreate(Sender: TObject);
begin
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 CdsAlocucao.RemoteServer := IRemoteCon.ConnectionBroker;

 CdsAlocucao.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

procedure TFrmEditarAlocucoes.NovaAlocucao;
begin
 CdsAlocucao.Params.Items[0].AsInteger := 0;
 CdsAlocucao.Open;
 CdsAlocucao.Insert;
 ShowModal;
end;

end.
