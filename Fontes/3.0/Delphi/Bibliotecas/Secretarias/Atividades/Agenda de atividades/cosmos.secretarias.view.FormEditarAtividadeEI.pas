unit cosmos.secretarias.view.FormEditarAtividadeEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ComCtrls, DBDateTimePicker, Buttons,
  cosmos.frames.fkSearch, ExtCtrls, GroupHeader, cosmos.frames.usuariocad,
  FrameDBInsertVertical, DB, DBClient, cosmos.classes.ServerInterface,
  cosmos.classes.application, cosmos.system.messages, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.classes.security,
  Datasnap.DSConnect;

type
  TFrmEditarAtividadesEI = class(TForm)
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
    FmeFKCirculoEI: TFmeFKSearch;
    MSGroupHeader4: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    CdsAtividade: TClientDataSet;
    MSGroupHeader5: TMSGroupHeader;
    DBMemo1: TDBMemo;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    FmeFKLicoesEI: TFmeFKSearch;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton2: TSpeedButton;
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
  FrmEditarAtividadesEI: TFrmEditarAtividadesEI;

implementation

{$R *.dfm}

procedure TFrmEditarAtividadesEI.CdsAtividadeAfterInsert(DataSet: TDataSet);
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

procedure TFrmEditarAtividadesEI.CdsAtividadeAfterOpen(DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode = cmRead;
end;

procedure TFrmEditarAtividadesEI.CdsAtividadeAfterPost(DataSet: TDataSet);
begin
 if CdsAtividade.ChangeCount > 0 then
  CdsAtividade.ApplyUpdates(0);
end;

procedure TFrmEditarAtividadesEI.CdsAtividadeBeforePost(DataSet: TDataSet);
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

procedure TFrmEditarAtividadesEI.CdsAtividadeReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarAtividadesEI.EditarAtividade(const codati: integer);
begin
 CdsAtividade.Params.Items[0].Value := codati;
 CdsAtividade.Open;

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 if not CdsAtividade.ReadOnly then
  begin
   CdsAtividade.ReadOnly := (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
    and not (cfAlterarAtividadeEI in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
  end;

 ShowModal;
end;

procedure TFrmEditarAtividadesEI.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
 CdsAtividade.RemoteServer := FRemoteConnection;

 FmeFKTipoAtividade.Configure('codtipati', csTiposAtividadesEI);
 FmeFKCirculoEI.Configure('codgru',csCirculoEI);
 FmeFKLicoesEI.Configure('codlic', csLicoesEI);
end;

procedure TFrmEditarAtividadesEI.FormDestroy(Sender: TObject);
begin
 if CdsAtividade.Active then CdsAtividade.Close;
 CdsAtividade.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarAtividadesEI.NovaAtividade(DefaultData: TCosmosData);
begin
 CdsAtividade.Params.Items[0].AsInteger := 0;
 CdsAtividade.Open;
 CdsAtividade.Insert;
 ICosmosApp.IRemoteCon.InsertDefaultData(CdsAtividade, DefaultData);

 ShowModal;
end;

procedure TFrmEditarAtividadesEI.SpeedButton1Click(Sender: TObject);
begin
 if not CdsAtividade.Fields.FieldByName('codgru').IsNull then
  begin
    if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.ClearCirculoEI) = mrYes then
     begin
      CdsAtividade.Edit;
      CdsAtividade.Fields.FieldByName('codgru').Clear;
      CdsAtividade.Fields.FieldByName('nomgru').Clear;
     end;
  end;
end;

procedure TFrmEditarAtividadesEI.SpeedButton2Click(Sender: TObject);
begin
 if not CdsAtividade.Fields.FieldByName('codlic').IsNull then
  begin
    if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.ClearLicaoEI) = mrYes then
     begin
      CdsAtividade.Edit;
      CdsAtividade.Fields.FieldByName('codlic').Clear;
      CdsAtividade.Fields.FieldByName('nomlic').Clear;
     end;
  end;
end;

end.
