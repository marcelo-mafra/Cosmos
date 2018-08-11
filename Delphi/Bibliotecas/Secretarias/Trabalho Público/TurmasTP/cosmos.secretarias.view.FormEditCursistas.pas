unit cosmos.secretarias.view.FormEditCursistas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBClient, ExtCtrls, Buttons, ActnList, ImgList,
  cosmos.system.messages, GroupHeader, cosmos.frames.gridsearch, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.framework.forms.datadialogs,
  cosmos.business.focos, System.Actions, cosmos.classes.security,
  Datasnap.DSConnect;

type
  TFrmEditCursistas = class(TForm)
    EdtTurma: TEdit;
    Label1: TLabel;
    CdsCursistas: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    RdbJovens: TRadioButton;
    RdbPesquisadores: TRadioButton;
    MSGroupHeader2: TMSGroupHeader;
    ActionList1: TActionList;
    ActAdd: TAction;
    DsrCursistas: TDataSource;
    ImageList1: TImageList;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    ActClose: TAction;
    ActHelp: TAction;
    BitBtn1: TBitBtn;
    ActCancel: TAction;
    ActDelete: TAction;
    ActPost: TAction;
    BitBtn6: TBitBtn;
    EdtFoco: TEdit;
    Label2: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    procedure FormCreate(Sender: TObject);
    procedure CdsCursistasReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsCursistasAfterInsert(DataSet: TDataSet);
    procedure ActHelpExecute(Sender: TObject);
    procedure ActDeleteUpdate(Sender: TObject);
    procedure ActCancelUpdate(Sender: TObject);
    procedure ActPostExecute(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure ActAddExecute(Sender: TObject);
    procedure CdsCursistasBeforePost(DataSet: TDataSet);
    procedure CdsCursistasAfterPost(DataSet: TDataSet);
    procedure CdsCursistasBeforeDelete(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    function GetIRemoteConnection: ICosmosRemoteConnection;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteConnection;
    procedure EditCursistas(const codtur: integer; nomtur: string);
  end;

var
  FrmEditCursistas: TFrmEditCursistas;

implementation

{$R *.dfm}

{ TFrmEditCursistas }

procedure TFrmEditCursistas.ActAddExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 inherited;
 try
   if self.RdbPesquisadores.Checked then
    AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctTP, scTodos, False)
   else
    AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctTM, scTodos, False);

   if Assigned(AData) then
    begin
     if not CdsCursistas.Locate('CODCAD', AData.FindValue('CODCAD'),[]) then
       begin
         CdsCursistas.Append;
         with CdsCursistas.Fields do
           begin
             FieldByName('codcad').Value := AData.FindValue('CODCAD');
             FieldByName('nomcad').Value := AData.FindValue('NOMCAD');
             FieldByName('matcad').Value := AData.FindValue('MATCAD');
             FieldByName('apecad').Value := AData.FindValue('APECAD');
           end;
         CdsCursistas.Post;
       end
      else
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasTP, TCosmosErrorMsg.CadastradoJaSelecionado);
    end;

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasTP, TCosmosErrorMsg.MembrosTurmaInstalacao);
   end;
 end;
end;

procedure TFrmEditCursistas.ActCancelExecute(Sender: TObject);
begin
 CdsCursistas.Cancel;
end;

procedure TFrmEditCursistas.ActCancelUpdate(Sender: TObject);
begin
 TAction(sender).Enabled := CdsCursistas.State <> dsBrowse;
end;

procedure TFrmEditCursistas.ActCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmEditCursistas.ActDeleteExecute(Sender: TObject);
begin
 CdsCursistas.Delete;
end;

procedure TFrmEditCursistas.ActDeleteUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := not CdsCursistas.IsEmpty;
end;

procedure TFrmEditCursistas.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmEditCursistas.ActPostExecute(Sender: TObject);
begin
 CdsCursistas.Post;
end;

procedure TFrmEditCursistas.CdsCursistasAfterInsert(DataSet: TDataSet);
begin
 Dataset.Fields.FieldByName('codtur').AsInteger := CdsCursistas.Params.Items[0].AsInteger;
end;

procedure TFrmEditCursistas.CdsCursistasAfterPost(DataSet: TDataSet);
begin
 if CdsCursistas.ChangeCount > 0 then
  CdsCursistas.ApplyUpdates(0);
end;

procedure TFrmEditCursistas.CdsCursistasBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasTP, TCosmosConfMsg.ConfDelete) = mrNo then
  Abort;
end;

procedure TFrmEditCursistas.CdsCursistasBeforePost(DataSet: TDataSet);
var
Sequence: string;
begin
 if CdsCursistas.State = dsInsert then
  begin
   Sequence := CdsCursistas.GetOptionalParam('SequenceName');
   CdsCursistas.Fields.FieldByName('codmem').AsInteger := IRemoteCon.GetSequenceValue(Sequence);
  end;
end;

procedure TFrmEditCursistas.CdsCursistasReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditCursistas.EditCursistas(const codtur: integer;
  nomtur: string);
begin
 EdtTurma.Text := nomtur;
 CdsCursistas.Params.Items[0].AsInteger := codtur;
 CdsCursistas.Open;
 ShowModal;
end;

procedure TFrmEditCursistas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsCursistas.Active then CdsCursistas.Close;
 CdsCursistas.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditCursistas.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
 CdsCursistas.RemoteServer := FRemoteConnection;

 CdsCursistas.ReadOnly := IRemoteCon.CurrentConnectionMode = cmRead;
 EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;
 FmeGridSearch1.ShowSearchBar := False;
end;

function TFrmEditCursistas.GetIRemoteConnection: ICosmosRemoteConnection;
begin
 Result := ICosmosApp.IRemoteCon;
end;

end.
