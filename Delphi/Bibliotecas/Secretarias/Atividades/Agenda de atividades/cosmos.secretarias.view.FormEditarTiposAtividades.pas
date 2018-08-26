unit cosmos.secretarias.view.FormEditarTiposAtividades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameDeleteButtons, cosmos.frames.gridsearch, StdCtrls, ExtCtrls, GroupHeader,
  DBCtrls, Mask, DB, DBClient, ActnList , cosmos.system.messages, Buttons,
  ImgList, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  ValueComboBox, DBValueComboBox, cosmos.classes.application, cosmos.business.focos,
  cosmos.classes.ServerInterface, cosmos.classes.security, Data.SqlExpr,
  System.Actions, Data.DBXCommon, cosmos.system.exceptions, Datasnap.DSConnect,
  cosmos.system.dataconverter, System.ImageList, cosmos.business.focos.helpers;

type
  TFrmEditarTiposAtividades = class(TForm)
    MSGroupHeader2: TMSGroupHeader;
    FmeGridSearch1: TFmeGridSearch;
    FmeDBDelButtons1: TFmeDBDelButtons;
    MSGroupHeader1: TMSGroupHeader;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CdsTiposAtividades: TClientDataSet;
    RdbLEC: TRadioButton;
    RdbTM: TRadioButton;
    RdbTP: TRadioButton;
    RdbEI: TRadioButton;
    RdbAll: TRadioButton;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    ActParticipantes: TAction;
    ImageList1: TImageList;
    DBValueComboBox1: TDBValueComboBox;
    MSGroupHeader3: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    CbxEI: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    RdbSimpatizantes: TRadioButton;
    DBCheckBox2: TDBCheckBox;
    procedure ActParticipantesUpdate(Sender: TObject);
    procedure ActParticipantesExecute(Sender: TObject);
    procedure RdbAllClick(Sender: TObject);
    procedure RdbEIClick(Sender: TObject);
    procedure RdbTPClick(Sender: TObject);
    procedure RdbTMClick(Sender: TObject);
    procedure RdbLECClick(Sender: TObject);
    procedure CdsTiposAtividadesAfterInsert(DataSet: TDataSet);
    procedure CdsTiposAtividadesBeforePost(DataSet: TDataSet);
    procedure CdsTiposAtividadesBeforeDelete(DataSet: TDataSet);
    procedure CdsTiposAtividadesAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsTiposAtividadesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure RdbSimpatizantesClick(Sender: TObject);
    procedure CdsTiposAtividadesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FCampoTrabalho: TCampoTrabalho;
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

    procedure SetCampo(const Value: TCampoTrabalho);
    procedure FilterData; inline;
    function GetCosmosRemoteConnection: ICosmosRemoteConnection;

  public
    { Public declarations }
    procedure EditarTiposAtividades;

    property CampoTrabalho: TCampoTrabalho read FCampoTrabalho write SetCampo;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetCosmosRemoteConnection;
  end;

var
  FrmEditarTiposAtividades: TFrmEditarTiposAtividades;

implementation

uses cosmos.secretarias.view.FormEditarParticipantesTiposAti;

{$R *.dfm}

procedure TFrmEditarTiposAtividades.ActParticipantesExecute(Sender: TObject);
var
codtipati: integer;
begin
 if not Assigned(FrmEditarParticipantesTiposAti) then
  FrmEditarParticipantesTiposAti := TFrmEditarParticipantesTiposAti.Create(self);

 try
  codtipati := CdsTiposAtividades.Fields.FieldByName('codtipati').AsInteger;
  FrmEditarParticipantesTiposAti.EditarParticipantes(codtipati);

 finally
  if Assigned(FrmEditarParticipantesTiposAti) then
   FreeAndNil(FrmEditarParticipantesTiposAti);
 end;
end;

procedure TFrmEditarTiposAtividades.ActParticipantesUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsTiposAtividades.Active)
  and not (CdsTiposAtividades.IsEmpty)
  and (CdsTiposAtividades.State = dsBrowse)
  and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmEditarTiposAtividades.CdsTiposAtividadesAfterInsert(
  DataSet: TDataSet);
begin

 with Dataset.Fields do
  begin
    FieldByName('indfre').Value := TDataConverter.ToBoleanString(True);
    FieldByName('indescint').Value := TDataConverter.ToBoleanString(False);
    FieldByName('campro').Value := ctLectorium.ShortName; //default
    FieldByName('indest').Value := TDataConverter.ToBoleanString(True);
    FieldByName('indati').Value := TDataConverter.ToBoleanString(True);
  end;
end;

procedure TFrmEditarTiposAtividades.CdsTiposAtividadesAfterOpen(
  DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode = cmRead;
end;

procedure TFrmEditarTiposAtividades.CdsTiposAtividadesAfterPost(
  DataSet: TDataSet);
begin
 if CdsTiposAtividades.ChangeCount > 0 then
  CdsTiposAtividades.ApplyUpdates(0);
end;

procedure TFrmEditarTiposAtividades.CdsTiposAtividadesBeforeDelete(
  DataSet: TDataSet);
var
 ID: integer;
 ACommand: TDBXCommand;
begin
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.DelTiposAtividades) = mrNo then
   Abort
  else
   begin
     Id := Dataset.Fields.FieldByName('codtipati').AsInteger;
     ACommand := IRemoteCon.CreateCommand;

     try
       ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
       ACommand.Text := 'TDMSecAtividadesServerMethods.DeleteTipoAtividade'; //do not localize!
       ACommand.Prepare;

       ACommand.Parameters[0].Value.SetInt32(Id);
       ACommand.ExecuteUpdate;
       ICosmosApp.MainLog.RegisterRemoteCallSucess(TCosmosLogs.ExecutedRemoteCommand, ACommand.Text);

       ACommand.Free;

     except
      on E: ECannotDeleteActivity do
       begin
        CdsTiposAtividades.CancelUpdates;
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, E.Message);
        if Assigned(ACommand) then FreeAndNil(ACommand);
       end;
      on E: Exception do
       begin
        CdsTiposAtividades.CancelUpdates;
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
        if Assigned(ACommand) then FreeAndNil(ACommand);
      end;
     end;
   end;
end;

procedure TFrmEditarTiposAtividades.CdsTiposAtividadesBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
 inherited;

 with Dataset.Fields do
  begin
   if (FieldByName('CAMPRO').Value = 'LEC') and (FieldByName('INDESCINT').Value = 'N') and not (ctLectorium in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
    begin
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, TCosmosErrorSecMsg.TipoAtividadeLR);
      Abort;
    end;

   if (FieldByName('CAMPRO').Value = 'TMO') and not (ctTM in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
    begin
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, TCosmosErrorSecMsg.TipoAtividadeTM);
      Abort;
    end;

   if (FieldByName('CAMPRO').Value = 'TMB') and not (ctTMB in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
    begin
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, TCosmosErrorSecMsg.TipoAtividadeTMB);
      Abort;
    end;

   if (FieldByName('CAMPRO').Value = 'TPU') and not (ctTP in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
    begin
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, TCosmosErrorSecMsg.TipoAtividadeTP);
      Abort;
    end;

   if (FieldByName('CAMPRO').Value = 'SIM') and not (ctSimpatizantes in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
    begin
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, TCosmosErrorSecMsg.TipoAtividadeSIM);
      Abort;
    end;

   if (FieldByName('CAMPRO').Value = 'LEC') and (FieldByName('INDESCINT').Value = 'S') and not (ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
    begin
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, TCosmosErrorSecMsg.TipoAtividadeEI);
      Abort;
    end;
  end;
 

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].Value := IRemoteCon.GetSequenceValue(SequenceName);
   if Dataset.Fields.Fields[0].Value = unassigned then
     Dataset.Cancel;
  end;
end;

procedure TFrmEditarTiposAtividades.CdsTiposAtividadesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarTiposAtividades.EditarTiposAtividades;
begin
 CdsTiposAtividades.Open;
 CampoTrabalho := ctNone;

 while IRemoteCon.CurrentConnectionInfo.CamposTrabalho <> [] do
  begin
   if ctLectorium in IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
    begin
     RdbLEC.Checked := True;
     CampoTrabalho := ctLectorium;
     Break;
    end;

   if ctTM in IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
    begin
     RdbTM.Checked := True;
     CampoTrabalho := ctTM;
     Break;
    end;

   if ctTP in IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
    begin
     RdbTP.Checked := True;
     CampoTrabalho := ctTP;
     Break;
    end;

   if ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
    begin
     RdbEI.Checked := True;
     CampoTrabalho := ctEI;
     Break;
    end;
  end;

 ShowModal;
end;

procedure TFrmEditarTiposAtividades.FilterData;
var
F: string;
begin
  case CampoTrabalho of
   ctLectorium: F := Format('CAMPRO = %s AND INDESCINT = %s', [QuotedStr('LEC'), QuotedStr('N')]) ;
   ctTM: F := Format('CAMPRO = %s', [QuotedStr('TMO')]);
   ctTP: F := Format('CAMPRO = %s', [QuotedStr('TPU')]);
   ctEI: F := Format('CAMPRO = %s AND INDESCINT = %s', [QuotedStr('LEC'), QuotedStr('S')]);
   ctSimpatizantes: F := Format('CAMPRO = %s AND INDESCINT = %s', [QuotedStr('SIM'), QuotedStr('N')]);
   ctNone: F := ''; //Sem filtro algum...
  end;

  try
   CdsTiposAtividades.DisableControls;
   CdsTiposAtividades.Filter := F;
   CdsTiposAtividades.Filtered := False;

   if CampoTrabalho <> ctNone then
    CdsTiposAtividades.Filtered := True;

  finally
   CdsTiposAtividades.EnableControls;
  end;
end;

procedure TFrmEditarTiposAtividades.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
 CdsTiposAtividades.RemoteServer := FRemoteConnection;

 FmeGridSearch1.SearchFields := 'destipati';
 CdsTiposAtividades.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

function TFrmEditarTiposAtividades.GetCosmosRemoteConnection: ICosmosRemoteConnection;
begin
 if ICosmosApp <> nil then
  Result := ICosmosApp.IRemoteCon
 else
  Result := nil;
end;

procedure TFrmEditarTiposAtividades.RdbLECClick(Sender: TObject);
begin
 CampoTrabalho := ctLectorium;
end;

procedure TFrmEditarTiposAtividades.RdbSimpatizantesClick(Sender: TObject);
begin
 CampoTrabalho := ctSimpatizantes;
end;

procedure TFrmEditarTiposAtividades.RdbTMClick(Sender: TObject);
begin
 CampoTrabalho := ctTM;
end;

procedure TFrmEditarTiposAtividades.RdbTPClick(Sender: TObject);
begin
 CampoTrabalho := ctTP;
end;

procedure TFrmEditarTiposAtividades.RdbEIClick(Sender: TObject);
begin
 CampoTrabalho := ctEI;
end;

procedure TFrmEditarTiposAtividades.RdbAllClick(Sender: TObject);
begin
 CampoTrabalho := ctNone;
end;

procedure TFrmEditarTiposAtividades.SetCampo(const Value: TCampoTrabalho);
begin
  if FCampoTrabalho <> Value then
   begin
    FCampoTrabalho := Value;
    FilterData;
   end;
end;

end.
