unit cosmos.conferencias.view.FormEditarInscricao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, cosmos.framework.interfaces.root, cosmos.framework.interfaces.DataAcess,
  FrameDBInsertVertical, StdCtrls, Mask, DBCtrls, ComCtrls, cosmos.classes.application,
  ExtCtrls, GroupHeader, cosmos.frames.fkSearch, cosmos.classes.ServerInterface,
  ValueComboBox, DBValueComboBox, cosmos.frames.usuariocad, cosmos.system.dataconverter,
  DBCGrids, ActnList, ImgList, Buttons, cosmos.system.messages,
  DBEditDateTimePicker, System.Actions, Datasnap.DSConnect, System.ImageList;

type
  TFrmEditarInscricao = class(TForm)
    CdsInscrito: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabAcessorias: TTabSheet;
    MSGroupHeader1: TMSGroupHeader;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    MSGroupHeader3: TMSGroupHeader;
    Label4: TLabel;
    MSGroupHeader4: TMSGroupHeader;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    FmeFKCadastrado: TFmeFKSearch;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    FmeFKLeito: TFmeFKSearch;
    DBValueComboBox1: TDBValueComboBox;
    MSGroupHeader5: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    DBValueComboBox2: TDBValueComboBox;
    Label12: TLabel;
    CdsDetalhesInscricao: TClientDataSet;
    DBCtrlGrid1: TDBCtrlGrid;
    DBText1: TDBText;
    DBCheckBox3: TDBCheckBox;
    DsrDetalhesInscricao: TDataSource;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActSaveItem: TAction;
    DBEditDateTimePicker1: TDBEditDateTimePicker;
    DBEditDateTimePicker2: TDBEditDateTimePicker;
    Label13: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsInscritoAfterPost(DataSet: TDataSet);
    procedure CdsInscritoBeforePost(DataSet: TDataSet);
    procedure CdsInscritoAfterInsert(DataSet: TDataSet);
    procedure CdsDetalhesInscricaoAfterPost(DataSet: TDataSet);
    procedure ActSaveItemExecute(Sender: TObject);
    procedure ActSaveItemUpdate(Sender: TObject);
    procedure CdsInscritoAfterApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
    procedure CdsInscritoAfterCancel(DataSet: TDataSet);
    procedure CdsInscritoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FChanged: boolean;
    FICosmosApp: ICosmosApplication;
    FDefaultData: TCosmosData;
    FRemoteConnection: TDSProviderConnection;

    function GetIRemoteCon: ICosmosRemoteConnection;
    procedure OpenDetalhes; inline;


  public
    { Public declarations }
    property Changed: boolean read FChanged;
    property DefaultData: TCosmosData read FDefaultData;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon;

    procedure NovoInscrito(const ConferenceData: TCosmosData);
    procedure EditarInscrito(const codins: integer; ConferenceData: TCosmosData);
  end;

var
  FrmEditarInscricao: TFrmEditarInscricao;

implementation

{$R *.dfm}

procedure TFrmEditarInscricao.ActSaveItemExecute(Sender: TObject);
begin
 CdsDetalhesInscricao.Post;
end;

procedure TFrmEditarInscricao.ActSaveItemUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsDetalhesInscricao.Active) and (CdsDetalhesInscricao.State <> dsBrowse);
end;

procedure TFrmEditarInscricao.CdsDetalhesInscricaoAfterPost(DataSet: TDataSet);
begin
 if CdsDetalhesInscricao.ChangeCount > 0 then
  CdsDetalhesInscricao.ApplyUpdates(0);
end;

procedure TFrmEditarInscricao.CdsInscritoAfterApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
  OpenDetalhes;
end;

procedure TFrmEditarInscricao.CdsInscritoAfterCancel(DataSet: TDataSet);
begin
 OpenDetalhes;
end;

procedure TFrmEditarInscricao.CdsInscritoAfterInsert(DataSet: TDataSet);
begin
 //Insere os valores padrões...
 with Dataset.Fields do
  begin
   FieldByName('codcon').Value := DefaultData.FindValue('codcon');
   FieldByName('datche').Value := DefaultData.FindValue('datini');
   FieldByName('datsai').Value := DefaultData.FindValue('datter');
   FieldByName('horche').Value := DefaultData.FindValue('horche');
   FieldByName('horsai').Value := DefaultData.FindValue('horsai');

   FieldByName('indpre').Value := TDataConverter.ToBoleanString(False);
   FieldByName('indmon').Value := TDataConverter.ToBoleanString(True);
   FieldByName('indsub').Value := TDataConverter.ToBoleanString(False);
   FieldByName('modtra').Value := 0; //veículo particular
   FieldByName('forins').Value := 1; //Inscrição feita no centro de oonferências promotor.
  end;

 if CdsDetalhesInscricao.Active then
  begin
    PageControl1.ActivePageIndex := 0;

    CdsDetalhesInscricao.Close;
    TabAcessorias.Enabled := False;
  end;
end;

procedure TFrmEditarInscricao.CdsInscritoAfterPost(DataSet: TDataSet);
begin
 FChanged := True;

 with Dataset do
  begin
   DefaultData.WriteValue('horche', FieldByName('horche').Value, 6);
   DefaultData.WriteValue('horsai', FieldByName('horsai').Value, 7);
  end;

 if CdsInscrito.ChangeCount > 0 then
  CdsInscrito.ApplyUpdates(0);
end;

procedure TFrmEditarInscricao.CdsInscritoBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.FieldValues['datche'] > DefaultData.FindValue('datter') then
  begin
   ICosmosApp.DlgMessage.Execute(TCosmosTitles.InscricoesConferencia, TCosmosErrorMsg.InscricaoDataChegada, mtError);
   Abort;
  end;

 if (Dataset.FieldValues['horche'] = null) or  (Dataset.FieldValues['horsai'] = null) then
  begin
   ICosmosApp.DlgMessage.Execute(TCosmosTitles.InscricoesConferencia, TCosmosErrorMsg.InscricaoHoraChegadaSaida, mtError);
   Abort;
  end;

 if Dataset.FieldValues['datsai'] < DefaultData.FindValue('datini') then
  begin
   ICosmosApp.DlgMessage.Execute(TCosmosTitles.InscricoesConferencia, TCosmosErrorMsg.InscricaoDataSaida, mtError);
   Abort;
  end;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');

   Dataset.FieldValues['codins'] := IRemoteCon.GetSequenceValue(SequenceName);

   DataSet.Fields.FieldByName('USURES').Value := UpperCase(IRemoteCon.ConnectedUser);
   DataSet.Fields.FieldByName('DATINS').Value := IRemoteCon.ServerDateTime;
  end;
end;

procedure TFrmEditarInscricao.CdsInscritoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarInscricao.EditarInscrito(const codins: integer;
  ConferenceData: TCosmosData);
begin
 self.FDefaultData := ConferenceData;

 CdsInscrito.Params.Items[0].Value := codins;
 CdsInscrito.Open;

 CdsDetalhesInscricao.Params.Items[0].Value := codins;
 CdsDetalhesInscricao.Open;

 ShowModal;
end;

procedure TFrmEditarInscricao.OpenDetalhes;
begin
  if (CdsDetalhesInscricao.Active = False) and not CdsInscrito.Fields.FieldByName('codins').IsNull then
  begin
    CdsDetalhesInscricao.Params.Items[0].Value := CdsInscrito.FieldValues['codins'];
    CdsDetalhesInscricao.Open;
    TabAcessorias.Enabled := True;
  end;
end;

procedure TFrmEditarInscricao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsDetalhesInscricao.Active then CdsDetalhesInscricao.Close;
  CdsDetalhesInscricao.RemoteServer := nil;

  if CdsInscrito.Active then CdsInscrito.Close;
  CdsInscrito.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(ICosmosApp) then FICosmosApp := nil;
end;

procedure TFrmEditarInscricao.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
 CdsInscrito.RemoteServer := FRemoteConnection;
 CdsDetalhesInscricao.RemoteServer := FRemoteConnection;

 FmeFKCadastrado.CosmosSearch := csCadastrados;
 FmeFKLeito.CosmosSearch := csLeitosAlojamento;

 self.CustomHint := ICosmosApp.CustomHintObj;
end;

function TFrmEditarInscricao.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := ICosmosApp.IRemoteCon;
end;

procedure TFrmEditarInscricao.NovoInscrito(const ConferenceData: TCosmosData);
begin
 self.FDefaultData := ConferenceData;

 CdsInscrito.Params.Items[0].Value := 0;
 CdsInscrito.Open;
 CdsInscrito.Insert;
 ShowModal;
end;


end.
