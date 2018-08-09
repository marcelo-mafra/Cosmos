unit cosmos.conferencias.view.FormDetalhamentoInscricoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.framework.view.FrmDocked, Vcl.ActnList,
  Vcl.ImgList, cosmos.frames.gridsearch, Data.DB, Datasnap.DBClient,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls,
  cosmos.system.messages, cosmos.framework.datanavigators.datasets,
  Vcl.Menus, Vcl.ActnPopup, cosmos.classes.application, System.Actions,
  Datasnap.DSConnect, cosmos.framework.interfaces.dataacess, Data.DBXCommon,
  cosmos.classes.security, cosmos.system.formsconst;

type
  TFrmDetalhamentoInscricoes = class(TFrmCosmosDocked)
    FmeGridSearchDetalhes: TFmeGridSearch;
    CdsDetalhesInscricoes: TClientDataSet;
    DsrDetalhesInscricoes: TDataSource;
    ActAddInfo: TAction;
    ActEditInfo: TAction;
    ActDelInfo: TAction;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    ActLocate: TAction;
    PopupActionBar1: TPopupActionBar;
    AdicionarInformao1: TMenuItem;
    ExcluirInformao1: TMenuItem;
    ExcluirInformao2: TMenuItem;
    AlterarInformao1: TMenuItem;
    N1: TMenuItem;
    ActFlagsInscricoes: TAction;
    InformaesNacionais1: TMenuItem;
    N2: TMenuItem;
    procedure ActLocateExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ActAddInfoExecute(Sender: TObject);
    procedure ActAddInfoUpdate(Sender: TObject);
    procedure ActEditInfoExecute(Sender: TObject);
    procedure ActEditInfoUpdate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActFlagsInscricoesExecute(Sender: TObject);
    procedure ActFlagsInscricoesUpdate(Sender: TObject);
    procedure ActDelInfoExecute(Sender: TObject);

  private
    { Private declarations }
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    procedure UpdateData(Sender: TObject);


  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
    procedure ExportData; override;
    procedure UpdateVisualElements; override;

    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;

  public
    { Public declarations }
  end;

var
  FrmDetalhamentoInscricoes: TFrmDetalhamentoInscricoes;

implementation

{$R *.dfm}

uses
  cosmos.conferencias.view.FormEditarDetalhamentosInscricoes,
  cosmos.conferencias.view.FormEditarFlagsInscricoes;

procedure TFrmDetalhamentoInscricoes.ActAddInfoExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmEditarDetalhamentosInscricoes) then
   FrmEditarDetalhamentosInscricoes := TFrmEditarDetalhamentosInscricoes.Create(self);

  try
   FrmEditarDetalhamentosInscricoes.NovoDetalhe;

  finally
   if Assigned(FrmEditarDetalhamentosInscricoes) then
    FreeAndNil(FrmEditarDetalhamentosInscricoes);
  end;
end;

procedure TFrmDetalhamentoInscricoes.ActAddInfoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsDetalhesInscricoes.Active)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfManterDetalhamentoInscricao in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmDetalhamentoInscricoes.ActDelInfoExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InscricoesConferencia, TCosmosConfMsg.DelDetalhesInscricao) = mrYes then
   begin
    //Primeiro tem de verificar se é possível excluir.
    ACommand := IRemoteCon.CreateCommand;

    try
      ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
      ACommand.Text := 'TDMCosmosConferenciasMethods.DeleteInfoInscricao';  //do not localize!
      ACommand.Prepare;

      ACommand.Parameters[0].Value.SetInt32(CdsDetalhesInscricoes.FieldValues['codfla']);
      ACommand.Parameters[1].Value.SetInt32(CdsDetalhesInscricoes.FieldValues['codite']);
      ACommand.ExecuteUpdate;

      case ACommand.Parameters[2].Value.GetInt32 of
       0: CdsDetalhesInscricoes.Refresh;
       1: ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.InscricoesConferencia, TCosmosInfoMsg.CantDeleteFlagInscricoes);
      end;

      ICosmosApp.Mainlog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
      ACommand.Free;

    except
      on E: Exception do
       begin
        ICosmosApp.Mainlog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorSecMsg.LoadPhotoPupil);
        if Assigned(ACommand) then FreeAndNil(ACommand);
       end;
    end
   end;
end;

procedure TFrmDetalhamentoInscricoes.ActEditInfoExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmEditarDetalhamentosInscricoes) then
   FrmEditarDetalhamentosInscricoes := TFrmEditarDetalhamentosInscricoes.Create(self);

  try
   FrmEditarDetalhamentosInscricoes.EditarDetalhes(CdsDetalhesInscricoes.Fields.FieldByName('codite').Value);

  finally
   if Assigned(FrmEditarDetalhamentosInscricoes) then
     FreeAndNil(FrmEditarDetalhamentosInscricoes);
  end;
end;

procedure TFrmDetalhamentoInscricoes.ActEditInfoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsDetalhesInscricoes.Active)
   and not (CdsDetalhesInscricoes.IsEmpty)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfManterDetalhamentoInscricao in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmDetalhamentoInscricoes.ActFlagsInscricoesExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmFlagsInscricoes) then
   FrmFlagsInscricoes := TFrmFlagsInscricoes.Create(self);

  try
   FrmFlagsInscricoes.NovoFlag;

  finally
   if Assigned(FrmFlagsInscricoes) then FreeAndNil(FrmFlagsInscricoes);
  end;
end;

procedure TFrmDetalhamentoInscricoes.ActFlagsInscricoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsDetalhesInscricoes.Active)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfItensNacionaisDetalhamento in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmDetalhamentoInscricoes.ActLocateExecute(Sender: TObject);
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmDetalhamentoInscricoes.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(self.CdsDetalhesInscricoes);
end;

procedure TFrmDetalhamentoInscricoes.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsDetalhesInscricoes;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmDetalhamentoInscricoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsDetalhesInscricoes.Active then CdsDetalhesInscricoes.Close;
  CdsDetalhesInscricoes.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  inherited;

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);
end;

procedure TFrmDetalhamentoInscricoes.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsDetalhesInscricoes.RemoteServer := FRemoteConnection;

  FmeGridSearchDetalhes.SearchFields := 'desfla';

  FDataNavigator := TDatasetDataNavigator.Create(CdsDetalhesInscricoes);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  CdsDetalhesInscricoes.Params.Items[0].Value := ICosmosApp.ActiveFocus.FocusID;
  CdsDetalhesInscricoes.Open;
end;

function TFrmDetalhamentoInscricoes.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormDetalhamentoInscricoes;
end;

function TFrmDetalhamentoInscricoes.GetFormIDName: string;
begin
 Result := 'Cosmos.Detalhamento.Inscricoes';
end;

function TFrmDetalhamentoInscricoes.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmDetalhamentoInscricoes.GetHelpID: integer;
begin

end;

function TFrmDetalhamentoInscricoes.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmDetalhamentoInscricoes.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmDetalhamentoInscricoes.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmDetalhamentoInscricoes.UpdateData(Sender: TObject);
begin
 CdsDetalhesInscricoes.Refresh;
end;

procedure TFrmDetalhamentoInscricoes.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmDetalhamentoInscricoes);

finalization
 UnRegisterClass(TFrmDetalhamentoInscricoes);

end.
