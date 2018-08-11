unit cosmos.secretarias.view.DetalhesHistorico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.frames.gridsearch, DB, DBClient,  ExtCtrls, StdCtrls, DBCtrls,
  cosmos.system.messages, ActnList, ImgList, Menus, ActnPopup, ActnMan,
  DBDateTimePicker, Mask, FrameDBEditVertical, GroupHeader,
  ComCtrls, Cosmos.Framework.Interfaces.Root, cosmos.frames.usuariocad,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  PlatformDefaultStyleActnCtrls, cosmos.classes.security, System.Actions,
  Datasnap.DSConnect;

type
  TFrmDetalhesEvento = class(TForm, IDialogDetalhesHistorico)
    CdsDetalhes: TClientDataSet;
    DBText1: TDBText;
    Image1: TImage;
    Bevel1: TBevel;
    CdsEvento: TClientDataSet;
    DsrEvento: TDataSource;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActCumprida: TAction;
    PopupActionBar1: TPopupActionBar;
    MarcarcomoCumprida1: TMenuItem;
    MSGroupHeader1: TMSGroupHeader;
    FmeDBEditVertical1: TFmeDBEditVertical;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeGridSearchAcoes: TFmeGridSearch;
    procedure CdsDetalhesAfterPost(DataSet: TDataSet);
    procedure ActCumpridaUpdate(Sender: TObject);
    procedure ActCumpridaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure CdsDetalhesBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsDetalhesAfterOpen(DataSet: TDataSet);
    procedure CdsDetalhesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  protected
    { Public declarations }
    procedure EditarDetalhe(const codhis, coddet: integer);
    procedure EditarDetalhes(const codhis: integer);

  public
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmDetalhesEvento: TFrmDetalhesEvento;

implementation

{$R *.dfm}

procedure TFrmDetalhesEvento.ActCumpridaExecute(Sender: TObject);
begin
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.HistoricoDiscipular, TCosmosConfMsg.ConcluirAcaoHis) = mrYes then
   begin
     with CdsDetalhes do
      begin
       Edit;
       Fields.FieldByName('datdet').Value := ICosmosApp.IRemoteCon.ServerDateTime;
       Fields.FieldByName('indcum').Value := 'S';
       Post;
      end;
   end;
end;

procedure TFrmDetalhesEvento.ActCumpridaUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsDetalhes.Active) and not (CdsDetalhes.IsEmpty)
  and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmRead)
  and (sfRegisterDetailHistoricEvent in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmDetalhesEvento.CdsDetalhesAfterOpen(DataSet: TDataSet);
begin
 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 CdsDetalhes.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

procedure TFrmDetalhesEvento.CdsDetalhesAfterPost(DataSet: TDataSet);
begin
 if CdsDetalhes.ChangeCount > 0 then
  CdsDetalhes.ApplyUpdates(0);
end;

procedure TFrmDetalhesEvento.CdsDetalhesBeforePost(DataSet: TDataSet);
begin
  with Dataset.Fields do
   begin
    FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);;
    FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;
   end;
end;

procedure TFrmDetalhesEvento.CdsDetalhesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmDetalhesEvento.EditarDetalhe(const codhis, coddet: integer);
begin
 with CdsDetalhes do
  begin
   Params.Items[0].AsInteger := codhis;
   Open;
   if IsEmpty then
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.HistoricoDiscipular, TCosmosInfoMsg.DetalheHistoricoVazio)
   else
    begin
     CdsEvento.Params.Items[0].AsInteger := codhis;
     CdsEvento.Open;
     CdsDetalhes.Locate('coddet', coddet, []);
     ShowModal;
    end;
  end;
end;

procedure TFrmDetalhesEvento.EditarDetalhes(const codhis: integer);
begin
 with CdsDetalhes do
  begin
   Params.Items[0].AsInteger := codhis;
   Open;
   if IsEmpty then
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.HistoricoDiscipular, TCosmosInfoMsg.DetalheHistoricoVazio)
   else
    begin
     CdsEvento.Params.Items[0].AsInteger := codhis;
     CdsEvento.Open;
     ShowModal;
    end;
  end;
end;

procedure TFrmDetalhesEvento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsDetalhes.Active then CdsDetalhes.Close;
 if CdsEvento.Active then CdsEvento.Close;

 CdsDetalhes.RemoteServer := nil;
 CdsEvento.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(ICosmosApp) then
  FICosmosApp := nil
end;

procedure TFrmDetalhesEvento.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scHistorico);
 CdsDetalhes.RemoteServer := FRemoteConnection;
 CdsEvento.RemoteServer := FRemoteConnection;

 FmeGridSearchAcoes.SearchFields := 'desflu';
end;

procedure TFrmDetalhesEvento.PopupActionBar1Popup(Sender: TObject);
begin
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmDetalhesEvento);

finalization
 UnRegisterClass(TFrmDetalhesEvento);

end.
