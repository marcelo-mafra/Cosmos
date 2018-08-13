unit cosmos.secretarias.view.FormEditarAtividadeTM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ComCtrls, DBDateTimePicker, Buttons,
  cosmos.frames.fkSearch, ExtCtrls, GroupHeader, cosmos.frames.usuariocad,
  FrameDBInsertVertical, DB, DBClient, cosmos.classes.ServerInterface,
  cosmos.system.messages, Cosmos.Framework.Interfaces.Root, cosmos.system.dataconverter,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.classes.application, cosmos.classes.security, Datasnap.DSConnect;

type
  TFrmEditarAtividadesTM = class(TForm)
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
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    BtnNewConf: TSpeedButton;
    procedure BtnNewConfClick(Sender: TObject);
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

  public
    { Public declarations }
    procedure NovaAtividade(DefaultData: TCosmosData);
    procedure EditarAtividade(const codati: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarAtividadesTM: TFrmEditarAtividadesTM;

implementation

{$R *.dfm}

procedure TFrmEditarAtividadesTM.CdsAtividadeAfterInsert(DataSet: TDataSet);
begin
  with CdsAtividade.Fields do
   begin
    FieldByName('indfre').Value := TDataConverter.ToBoleanString(True);
    FieldByName('indlis').Value := TDataConverter.ToBoleanString(True);
    FieldByName('indjal').Value := TDataConverter.ToBoleanString(False);
    FieldByName('locati').Value := ICosmosApp.ActiveFocus.FocusName;
    FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
    FieldByName('datati').Value := ICosmosApp.IRemoteCon.ServerDateTime;
   end;
end;

procedure TFrmEditarAtividadesTM.CdsAtividadeAfterOpen(DataSet: TDataSet);
begin
 BtnNewConf.Enabled := (CdsAtividade.Active) and (Assigned(ICosmosApp.IRemoteCon))
  and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite)
  and (cfNovaConferenciaTM in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmEditarAtividadesTM.CdsAtividadeAfterPost(DataSet: TDataSet);
begin
 if CdsAtividade.ChangeCount > 0 then
  CdsAtividade.ApplyUpdates(0);
end;

procedure TFrmEditarAtividadesTM.CdsAtividadeBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 DataSet.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);;
 DataSet.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].Value := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
   if Dataset.Fields.Fields[0].Value = unassigned then
    Dataset.Cancel;
  end;
end;

procedure TFrmEditarAtividadesTM.CdsAtividadeReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarAtividadesTM.EditarAtividade(const codati: integer);
begin
 CdsAtividade.Params.Items[0].Value := codati;
 CdsAtividade.Open;

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 if not CdsAtividade.ReadOnly then
  begin
   CdsAtividade.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
   and not (cfAlterarAtividadeTM in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
  end;

 ShowModal;
end;

procedure TFrmEditarAtividadesTM.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
 CdsAtividade.RemoteServer := FRemoteConnection;

 FmeFKTipoAtividade.Configure('codtipati', csTiposAtividadesTM);
 FmeFKConferencia.Configure('codcon',csConferenciasTMO);
 FmeFKAlocucoes.Configure('codalo',csAlocucoes);

 CdsAtividade.ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

procedure TFrmEditarAtividadesTM.FormDestroy(Sender: TObject);
begin
 if CdsAtividade.Active then CdsAtividade.Close;
 CdsAtividade.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarAtividadesTM.NovaAtividade(DefaultData: TCosmosData);
begin
 CdsAtividade.Params.Items[0].AsInteger := 0;
 CdsAtividade.Open;
 CdsAtividade.Insert;
 ICosmosApp.IRemoteCon.InsertDefaultData(CdsAtividade, DefaultData);
 ShowModal;
end;

procedure TFrmEditarAtividadesTM.SpeedButton1Click(Sender: TObject);
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

procedure TFrmEditarAtividadesTM.SpeedButton2Click(Sender: TObject);
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

procedure TFrmEditarAtividadesTM.BtnNewConfClick(Sender: TObject);
begin
  inherited;
  ICosmosApp.ExecuteWizard('novaconf.bpl', 'TFrmNovaConferencia');
end;

end.
