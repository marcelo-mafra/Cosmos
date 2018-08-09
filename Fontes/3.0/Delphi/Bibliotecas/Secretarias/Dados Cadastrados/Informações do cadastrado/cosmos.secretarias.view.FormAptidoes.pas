unit cosmos.secretarias.view.FormAptidoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, DBCtrls, cosmos.frames.gridsearch,
  cosmos.frames.fkSearch, DB, DBClient, cosmos.classes.ServerInterface, FrameDeleteButtons,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.system.messages, cosmos.classes.security, Datasnap.DSConnect;

type
  TFrmAptidoes = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    FmeFKAptidoes: TFmeFKSearch;
    FmeGridSearch1: TFmeGridSearch;
    DBMemo1: TDBMemo;
    Label2: TLabel;
    EdtCadastrado: TEdit;
    CdsAptidoes: TClientDataSet;
    FmeDBDelButtons1: TFmeDBDelButtons;
    Label1: TLabel;
    procedure CdsAptidoesBeforeDelete(DataSet: TDataSet);
    procedure CdsAptidoesBeforePost(DataSet: TDataSet);
    procedure CdsAptidoesAfterPost(DataSet: TDataSet);
    procedure CdsAptidoesAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsAptidoesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure CadastrarAptdoes(const codcad: integer; nomcad: string);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmAptidoes: TFrmAptidoes;

implementation

{$R *.dfm}

{ TFrmAptidoes }

procedure TFrmAptidoes.CadastrarAptdoes(const codcad: integer; nomcad: string);
begin
 EdtCadastrado.Text := nomcad;

 with CdsAptidoes do
  begin
   Params.Items[0].AsInteger := codcad;
   Open;
  end;

 ShowModal; 
end;

procedure TFrmAptidoes.CdsAptidoesAfterInsert(DataSet: TDataSet);
begin
 with CdsAptidoes do
  begin
   Fields.FieldByName('codcad').AsInteger := Params.Items[0].AsInteger;
  end;
end;

procedure TFrmAptidoes.CdsAptidoesAfterPost(DataSet: TDataSet);
begin
 if CdsAptidoes.ChangeCount > 0 then
  CdsAptidoes.ApplyUpdates(0);
end;

procedure TFrmAptidoes.CdsAptidoesBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Aptidoes, TCosmosConfMsg.DeleteAptidao)= mrNo then
  Abort;
end;

procedure TFrmAptidoes.CdsAptidoesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 with CdsAptidoes do
  begin
   if State = dsInsert then
    begin
     SequenceName := GetOptionalParam('SequenceName');
     Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
    end;
  end;
end;

procedure TFrmAptidoes.CdsAptidoesReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmAptidoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsAptidoes.Active then CdsAptidoes.Close;

 CdsAptidoes.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmAptidoes.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scCommon);
 CdsAptidoes.RemoteServer := FRemoteConnection;

 FmeFKAptidoes.Configure('codare',csAreasAptidoes);
 FmeGridSearch1.ShowSearchBar := False;

 CdsAptidoes.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;


end.
