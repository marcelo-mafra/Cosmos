unit cosmos.common.view.FormMeiosContatos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient,  cosmos.frames.gridsearch, ExtCtrls, GroupHeader, cosmos.frames.fkSearch,
  StdCtrls, DBCtrls, Mask, FrameDeleteButtons, cosmos.frames.usuariocad,
  cosmos.classes.application, cosmos.classes.ServerInterface, cosmos.classes.security,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  Buttons, cosmos.system.winshell, cosmos.system.messages, cosmos.system.types,
  cosmos.Framework.Interfaces.Root, Datasnap.DSConnect, cosmos.system.dataconverter;

type
  TFrmMeiosContatos = class(TForm, ICosmosMeiosContatos)
    CdsContatos: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    FmeFKSearchTipoContato: TFmeFKSearch;
    FmeDBDelButtons1: TFmeDBDelButtons;
    Label1: TLabel;
    Label2: TLabel;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    SpeedButton1: TSpeedButton;
    FmeGridSearch1: TFmeGridSearch;
    CdsContatosFoco: TClientDataSet;
    procedure CdsContatosBeforeDelete(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CdsContatosBeforePost(DataSet: TDataSet);
    procedure CdsContatosAfterPost(DataSet: TDataSet);
    procedure CdsContatosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsContatosAfterOpen(DataSet: TDataSet);
    procedure CdsContatosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }

    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  protected
   procedure ShowMeiosContatosCadastrado(const codcad: integer);
   procedure ShowMeiosContatosPesquisador(const codcad: integer);
   procedure ShowMeiosContatosAluno(const codcad: integer);
   procedure ShowMeiosContatosFocos(const codfoc: integer);

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmMeiosContatos: TFrmMeiosContatos;

implementation

{$R *.dfm}

procedure TFrmMeiosContatos.CdsContatosAfterInsert(DataSet: TDataSet);
begin
 if CdsContatos.Active then
  Dataset.Fields.FieldByName('codcad').AsInteger := CdsContatos.Params.Items[0].AsInteger
 else
  Dataset.Fields.FieldByName('codfoc').AsInteger := CdsContatosFoco.Params.Items[0].AsInteger;

 Dataset.Fields.FieldByName('indcar').AsString := TDataConverter.ToBoleanString(False);
end;

procedure TFrmMeiosContatos.CdsContatosAfterOpen(DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

procedure TFrmMeiosContatos.CdsContatosAfterPost(DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
  TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmMeiosContatos.CdsContatosBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.MeiosContato, TCosmosConfMsg.DeleteContato) = mrNo then
  Abort;
end;

procedure TFrmMeiosContatos.CdsContatosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 DataSet.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);
 DataSet.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmMeiosContatos.CdsContatosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmMeiosContatos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsContatos.Active then CdsContatos.Close;
 if CdsContatosFoco.Active then CdsContatosFoco.Close;

 CdsContatos.RemoteServer := nil;
 CdsContatosFoco.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then FICosmosApp := nil;
end;

procedure TFrmMeiosContatos.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FmeFKSearchTipoContato.Configure('codtipcon',csMeiosContatos);
 FmeGridSearch1.SearchFields := 'destipcon';
 FmeGridSearch1.ShowSearchBar := False;
end;

procedure TFrmMeiosContatos.ShowMeiosContatosAluno(const codcad: integer);
begin
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsContatos.RemoteServer := FRemoteConnection;
 CdsContatos.Params.Items[0].AsInteger := codcad;
 CdsContatos.Open;
 DBCheckBox1.Enabled := True;

 ShowModal;
end;

procedure TFrmMeiosContatos.ShowMeiosContatosCadastrado(const codcad: integer);
begin
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsContatos.RemoteServer := FRemoteConnection;

 CdsContatos.Params.Items[0].AsInteger := codcad;
 CdsContatos.Open;

 ShowModal;
end;

procedure TFrmMeiosContatos.ShowMeiosContatosFocos(const codfoc: integer);
begin
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scFocos);
 CdsContatosFoco.RemoteServer := FRemoteConnection;

 CdsContatosFoco.Params.Items[0].AsInteger := codfoc;
 CdsContatosFoco.Open;
 FmeDBDelButtons1.DataSource1.DataSet := CdsContatosFoco;
 DBCheckBox1.Enabled := False;

 ShowModal;
end;

procedure TFrmMeiosContatos.ShowMeiosContatosPesquisador(const codcad: integer);
begin
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsContatos.RemoteServer := FRemoteConnection;

 CdsContatos.Params.Items[0].AsInteger := codcad;
 CdsContatos.Open;
 DBCheckBox1.Enabled := False;

 ShowModal;
end;

procedure TFrmMeiosContatos.SpeedButton1Click(Sender: TObject);
var
EMail: string;
begin
 if CdsContatos.Active then
  EMail := CdsContatos.Fields.FieldByName('descon').AsString
 else
  EMail := CdsContatosFoco.Fields.FieldByName('descon').AsString;

 if TWinShell.EmailIsValid(Email) then
  TWinShell.SendEmail(Application.Handle, Email, TEmailConst.NewEmailSubject,'', '', TEmailConst.NewEmailBody)
 else
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.MeiosContato, TCosmosErrorMsg.InvalidEmail);
end;

initialization
 RegisterClass(TFrmMeiosContatos);

finalization
 UnRegisterClass(TFrmMeiosContatos);
end.
