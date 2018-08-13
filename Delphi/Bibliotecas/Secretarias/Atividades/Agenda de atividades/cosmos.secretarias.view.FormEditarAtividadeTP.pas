unit cosmos.secretarias.view.FormEditarAtividadeTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ComCtrls, DBDateTimePicker, Buttons,
  cosmos.frames.fkSearch, ExtCtrls, GroupHeader, cosmos.frames.usuariocad,
  FrameDBInsertVertical, DB, DBClient, cosmos.classes.ServerInterface,
  cosmos.system.messages, ValueComboBox, DBValueComboBox, cosmos.system.dataconverter,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.classes.application, cosmos.classes.security, Datasnap.DSConnect;

type
  TFrmEditarAtividadesTP = class(TForm)
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
    MSGroupHeader6: TMSGroupHeader;
    SpeedButton2: TSpeedButton;
    FmeFKCursistasTP: TFmeFKSearch;
    Label6: TLabel;
    Label7: TLabel;
    DBValueComboBox1: TDBValueComboBox;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CdsAtividadeBeforePost(DataSet: TDataSet);
    procedure CdsAtividadeAfterPost(DataSet: TDataSet);
    procedure CdsAtividadeAfterInsert(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure CdsAtividadeReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
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
  FrmEditarAtividadesTP: TFrmEditarAtividadesTP;

implementation

{$R *.dfm}

procedure TFrmEditarAtividadesTP.CdsAtividadeAfterInsert(DataSet: TDataSet);
begin
  with CdsAtividade.Fields do
   begin
    FieldByName('indfre').Value := TDataConverter.ToBoleanString(True);
    FieldByName('indlis').Value := TDataConverter.ToBoleanString(False);
    FieldByName('indjal').Value := TDataConverter.ToBoleanString(False);
    FieldByName('locati').Value := ICosmosApp.ActiveFocus.FocusName;
    FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
    FieldByName('datati').Value := ICosmosApp.IRemoteCon.ServerDateTime;
   end;
end;

procedure TFrmEditarAtividadesTP.CdsAtividadeAfterOpen(DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode = cmRead;
end;

procedure TFrmEditarAtividadesTP.CdsAtividadeAfterPost(DataSet: TDataSet);
begin
 if CdsAtividade.ChangeCount > 0 then
  CdsAtividade.ApplyUpdates(0);
end;

procedure TFrmEditarAtividadesTP.CdsAtividadeBeforePost(DataSet: TDataSet);
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

procedure TFrmEditarAtividadesTP.CdsAtividadeReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarAtividadesTP.EditarAtividade(const codati: integer);
begin
 CdsAtividade.Params.Items[0].Value := codati;
 CdsAtividade.Open;

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 if not CdsAtividade.ReadOnly then
  begin
   CdsAtividade.ReadOnly := (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
   and not (cfAlterarAtividadeTP in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
  end;

 ShowModal;
end;

procedure TFrmEditarAtividadesTP.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
 CdsAtividade.RemoteServer := FRemoteConnection;

 FmeFKTipoAtividade.Configure('codtipati', csTiposAtividadesTP);
 FmeFKAlocucoes.Configure('codalo',csAlocucoes);
 FmeFKCursistasTP.Configure('codtur',csTurmasTP);

 CdsAtividade.ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

procedure TFrmEditarAtividadesTP.FormDestroy(Sender: TObject);
begin
 if CdsAtividade.Active then CdsAtividade.Close;
 CdsAtividade.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarAtividadesTP.NovaAtividade(DefaultData: TCosmosData);
begin
 CdsAtividade.Params.Items[0].AsInteger := 0;
 CdsAtividade.Open;
 CdsAtividade.Insert;
 ICosmosApp.IRemoteCon.InsertDefaultData(CdsAtividade, DefaultData);
 ShowModal;
end;

procedure TFrmEditarAtividadesTP.SpeedButton1Click(Sender: TObject);
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

procedure TFrmEditarAtividadesTP.SpeedButton2Click(Sender: TObject);
begin
 if not CdsAtividade.Fields.FieldByName('codtur').IsNull then
  begin
    if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.ClearTurmaTP) = mrYes then
     begin
      CdsAtividade.Edit;
      CdsAtividade.Fields.FieldByName('codtur').Clear;
      CdsAtividade.Fields.FieldByName('numtur').Clear;
     end;
  end;
end;

end.
