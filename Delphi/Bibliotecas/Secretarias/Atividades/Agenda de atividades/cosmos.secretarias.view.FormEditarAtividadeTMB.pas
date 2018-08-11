unit cosmos.secretarias.view.FormEditarAtividadeTMB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ComCtrls, DBDateTimePicker, Buttons,
  cosmos.frames.fkSearch, ExtCtrls, GroupHeader, cosmos.frames.usuariocad,
  FrameDBInsertVertical, DB, DBClient, cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.system.messages, cosmos.classes.security,
  cosmos.classes.application, Datasnap.DSConnect;

type
  TFrmEditarAtividadesTMB = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    FmeFKTipoAtividade: TFmeFKSearch;
    Label1: TLabel;
    DBDateTimePicker1: TDBDateTimePicker;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    MSGroupHeader3: TMSGroupHeader;
    FmeFKAlocucoes: TFmeFKSearch;
    MSGroupHeader4: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    CdsAtividade: TClientDataSet;
    MSGroupHeader5: TMSGroupHeader;
    DBMemo1: TDBMemo;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    FmeFKConferencia: TFmeFKSearch;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CdsAtividadeBeforePost(DataSet: TDataSet);
    procedure CdsAtividadeReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsAtividadeAfterPost(DataSet: TDataSet);
    procedure CdsAtividadeAfterInsert(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure CdsAtividadeAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

    function GetIRemoteCon: ICosmosRemoteConnection;

  public
    { Public declarations }
    procedure NovaAtividade(DefaultData: TCosmosData);
    procedure EditarAtividade(const codati: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon;
  end;

var
  FrmEditarAtividadesTMB: TFrmEditarAtividadesTMB;

implementation

{$R *.dfm}

procedure TFrmEditarAtividadesTMB.CdsAtividadeAfterInsert(DataSet: TDataSet);
begin
  with CdsAtividade.Fields do
   begin
    FieldByName('indfre').Value := TDataConverter.ToBoleanString(True);
    FieldByName('indlis').Value := TDataConverter.ToBoleanString(True);
    FieldByName('indjal').Value := TDataConverter.ToBoleanString(False);
    FieldByName('locati').Value := ICosmosApp.ActiveFocus.FocusName;
    FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
    FieldByName('datati').Value := IRemoteCon.ServerDateTime;
   end;
end;

procedure TFrmEditarAtividadesTMB.CdsAtividadeAfterOpen(DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode = cmRead;
end;

procedure TFrmEditarAtividadesTMB.CdsAtividadeAfterPost(DataSet: TDataSet);
begin
 if CdsAtividade.ChangeCount > 0 then
  CdsAtividade.ApplyUpdates(0);
end;

procedure TFrmEditarAtividadesTMB.CdsAtividadeBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 DataSet.Fields.FieldByName('USURES').Value := UpperCase(IRemoteCon.ConnectedUser);;
 DataSet.Fields.FieldByName('DATCAD').Value := IRemoteCon.ServerDateTime;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].Value := IRemoteCon.GetSequenceValue(SequenceName);
   if Dataset.Fields.Fields[0].Value = unassigned then
    Dataset.Cancel;
  end;
end;

procedure TFrmEditarAtividadesTMB.CdsAtividadeReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarAtividadesTMB.EditarAtividade(const codati: integer);
begin
 CdsAtividade.Params.Items[0].Value := codati;
 CdsAtividade.Open;

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 if not CdsAtividade.ReadOnly then
  begin
   CdsAtividade.ReadOnly := (IRemoteCon.CurrentConnectionMode <> cmWrite)
   and not (cfAlterarAtividadeTMB in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
  end;

 ShowModal;
end;

procedure TFrmEditarAtividadesTMB.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
 CdsAtividade.RemoteServer := FRemoteConnection;

 FmeFKTipoAtividade.Configure('codtipati', csTiposAtividadesTMB);
 FmeFKConferencia.Configure('codcon', csConferenciasTMB);
 FmeFKAlocucoes.Configure('codalo',csAlocucoes);

 CdsAtividade.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

procedure TFrmEditarAtividadesTMB.FormDestroy(Sender: TObject);
begin
 if CdsAtividade.Active then CdsAtividade.Close;
 CdsAtividade.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(ICosmosApp) then
  FICosmosApp := nil;
end;

function TFrmEditarAtividadesTMB.GetIRemoteCon: ICosmosRemoteConnection;
begin
 if Assigned(FICosmosApp) then
  Result := ICosmosApp.IRemoteCon
 else
  REsult := nil;
end;

procedure TFrmEditarAtividadesTMB.NovaAtividade(DefaultData: TCosmosData);
begin
 CdsAtividade.Params.Items[0].AsInteger := 0;
 CdsAtividade.Open;
 CdsAtividade.Insert;
 IRemoteCon.InsertDefaultData(CdsAtividade, DefaultData);
 ShowModal;
end;

procedure TFrmEditarAtividadesTMB.SpeedButton1Click(Sender: TObject);
begin
 if not CdsAtividade.Fields.FieldByName('codalo').IsNull then
  begin
    if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.ClearAlocucao) = mrYes then
     begin
      CdsAtividade.Edit;
      CdsAtividade.Fields.FieldByName('codalo').Clear;
      CdsAtividade.Fields.FieldByName('titalo').Clear;
     end;
  end;
end;

procedure TFrmEditarAtividadesTMB.SpeedButton2Click(Sender: TObject);
begin
 if not CdsAtividade.Fields.FieldByName('codcon').IsNull then
  begin
    if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.ClearConferencia) = mrYes then
     begin
      CdsAtividade.Edit;
      CdsAtividade.Fields.FieldByName('codcon').Clear;
      CdsAtividade.Fields.FieldByName('nomcon').Clear;
     end;
  end;
end;

procedure TFrmEditarAtividadesTMB.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  ICosmosApp.ExecuteWizard('novaconf.bpl','TFrmNovaConferencia');
end;

end.
