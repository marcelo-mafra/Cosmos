unit cosmos.secretarias.view.turmasTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, DB, DBClient, Grids, DBGrids,
  Cosmos.Framework.Interfaces.Dialogs, Menus, ActnPopup, cosmos.frames.gridsearch, ActnMan,
  XPStyleActnCtrls, ToolWin, ActnCtrls, ExtCtrls, StdCtrls, cosmos.classes.application,
  cosmos.system.messages, cosmos.classes.security, PlatformDefaultStyleActnCtrls,
  cosmos.framework.datanavigators.datasets, cosmos.business.focos, System.Actions,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Applications,
  Datasnap.DSconnect, cosmos.system.formsconst;


type
  TFrmTurmasTP = class(TFrmCosmosDocked)
    ActNovaTurma: TAction;
    CdsTurmasTP: TClientDataSet;
    DsrTurmasTP: TDataSource;
    ActCursistas: TAction;
    ActDelTurma: TAction;
    ActAtividades: TAction;
    PopupActionBar1: TPopupActionBar;
    NovaTurma1: TMenuItem;
    ExcluirTurma1: TMenuItem;
    Cursistas1: TMenuItem;
    Atividades1: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    ActSearchBar: TAction;
    ActAnoAnterior: TAction;
    ActAnoSeguinte: TAction;
    Panel1: TPanel;
    LblAno: TLabel;
    Image1: TImage;
    ActEncerrarTurma: TAction;
    EncerrarTurma1: TMenuItem;
    N1: TMenuItem;
    ActReativarTurma: TAction;
    ReativarTurma1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    procedure ActReativarTurmaUpdate(Sender: TObject);
    procedure ActReativarTurmaExecute(Sender: TObject);
    procedure ActEncerrarTurmaUpdate(Sender: TObject);
    procedure ActEncerrarTurmaExecute(Sender: TObject);
    procedure ActAnoSeguinteExecute(Sender: TObject);
    procedure ActAnoAnteriorExecute(Sender: TObject);
    procedure ActDelTurmaExecute(Sender: TObject);
    procedure ActCursistasUpdate(Sender: TObject);
    procedure ActSearchBarExecute(Sender: TObject);
    procedure ActAtividadesExecute(Sender: TObject);
    procedure ActCursistasExecute(Sender: TObject);
    procedure ActNovaTurmaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNovaTurmaUpdate(Sender: TObject);
    procedure ActDelTurmaUpdate(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    ARemoteConnection: TDSProviderConnection;
    FCurrentYear: word;
    FDataNavigator: TDatasetDataNavigator;
    procedure SetCurrentYear(const Value: word);
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
    property CurrentYear: word read FCurrentYear write SetCurrentYear;
  end;

var
  FrmTurmasTP: TFrmTurmasTP;

implementation

uses cosmos.secretarias.view.FormEditCursistas,
  cosmos.secretarias.view.FormAtividadesTurmaTP;

{$R *.dfm}

procedure TFrmTurmasTP.ActAnoAnteriorExecute(Sender: TObject);
begin
  inherited;
  CurrentYear := CurrentYear - 1;
end;

procedure TFrmTurmasTP.ActAnoSeguinteExecute(Sender: TObject);
begin
  inherited;
  CurrentYear := CurrentYear + 1;
end;

procedure TFrmTurmasTP.ActAtividadesExecute(Sender: TObject);
var
codtur, turma: integer;
begin
  inherited;
  try
   if not Assigned(FrmAtividadesTurmaTP) then
    FrmAtividadesTurmaTP := TFrmAtividadesTurmaTP.Create(self);
   codtur := CdsTurmasTP.Fields.FieldByName('codtur').AsInteger;
   turma := CdsTurmasTP.Fields.FieldByName('numtur').AsInteger;
   FrmAtividadesTurmaTP.CdsAtividades.ConnectionBroker := CdsTurmasTP.ConnectionBroker;
   FrmAtividadesTurmaTP.ShowAtividades(codtur, turma);

  finally
   if Assigned(FrmAtividadesTurmaTP) then
    FreeAndNil(FrmAtividadesTurmaTP);
  end;
end;

procedure TFrmTurmasTP.ActCursistasExecute(Sender: TObject);
var
codtur: integer;
nomtur: string;
begin
  inherited;
  if CdsTurmasTP.IsEmpty then
    Exit;

  FrmEditCursistas := TFrmEditCursistas.Create(self);

  try
   codtur := CdsTurmasTP.Fields.FieldByName('codtur').AsInteger;
   nomtur := CdsTurmasTP.Fields.FieldByName('numtur').AsString;
   FrmEditCursistas.EditCursistas(codtur,nomtur);

  finally
   if Assigned(FrmEditCursistas) then
    FreeAndNil(FrmEditCursistas);
  end;
end;

procedure TFrmTurmasTP.ActCursistasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTurmasTP.Active) and not (CdsTurmasTP.IsEmpty)
   and (Assigned(IRemoteCon))
   and (sfAlterarTurmaCursistas in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmTurmasTP.ActDelTurmaExecute(Sender: TObject);
var
 ISecretarias: ICosmosSecretarias;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasTP, TCosmosInfoMsg.DelTurmaTP) = mrYes then
   begin
    ISecretarias := Application.MainForm as ICosmosSecretarias;

    try
     ISecretarias.DeleteTeam(CdsTurmasTP.FieldValues['codtur']);
     CdsTurmasTP.Refresh;

    finally
     if Assigned(ISecretarias) then ISecretarias := nil;
    end;
   end;
end;

procedure TFrmTurmasTP.ActDelTurmaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTurmasTP.Active) and not (CdsTurmasTP.IsEmpty)
   and (Assigned(IRemoteCon))
   and (sfExcluirTurmaCursistas in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmTurmasTP.ActEncerrarTurmaExecute(Sender: TObject);
var
 ISecretarias: ICosmosSecretarias;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasTP, TCosmosConfMsg.EcerrarTurmaTP) = mrYes then
   begin
    ISecretarias := Application.MainForm as ICosmosSecretarias;

    try
     if ISecretarias.CloseTeam(CdsTurmasTP.FieldValues['codtur']) then
      CdsTurmasTP.Refresh;

    finally
     if Assigned(ISecretarias) then ISecretarias := nil;
    end;
   end;
end;

procedure TFrmTurmasTP.ActEncerrarTurmaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTurmasTP.Active) and not (CdsTurmasTP.IsEmpty)
   and (CdsTurmasTP.Fields.FieldByName('datenc').IsNull)
   and (Assigned(IRemoteCon))
   and (sfEncerrarTurmaTP in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmTurmasTP.ActNovaTurmaExecute(Sender: TObject);
begin
  inherited;
  if ICosmosApp.ExecuteWizard('wzturmastp.bpl','TFrmWzTurmasTP') then
    self.UpdateData(Sender);
end;

procedure TFrmTurmasTP.ActNovaTurmaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled :=  Assigned(IRemoteCon) and (IRemoteCon.CurrentConnectionMode = cmWrite)
   and (sfNovaTurmaCursistas in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmTurmasTP.ActReativarTurmaExecute(Sender: TObject);
var
 codtur: integer;
 ISecretarias: ICosmosSecretarias;
begin
  inherited;
  //Reativa uma turma desligada
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasTP, TCosmosConfMsg.ReativarTurmaTP) = mrYes then
   begin
    codtur := CdsTurmasTP.Fields.FieldByName('codtur').Value;
    ISecretarias := Application.MainForm as ICosmosSecretarias;

     try
      if ISecretarias.ReactivateTeam(codtur) then
        CdsTurmasTP.Refresh;

     finally
      if Assigned(ISecretarias) then ISecretarias := nil;
     end;
   end;
end;

procedure TFrmTurmasTP.ActReativarTurmaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTurmasTP.Active) and not (CdsTurmasTP.IsEmpty)
   and not (CdsTurmasTP.Fields.FieldByName('datenc').IsNull)
   and Assigned(IRemoteCon)
   and (sfReativarTurmaTP in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmTurmasTP.ActSearchBarExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := Taction(Sender).Checked;
end;

procedure TFrmTurmasTP.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsTurmasTP);
end;

procedure TFrmTurmasTP.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if ActCursistas.Enabled then
   ActCursistas.Execute;
end;

procedure TFrmTurmasTP.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsTurmasTP;
end;

procedure TFrmTurmasTP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
// if CdsTurmasTP.Active then
//   CdsTurmasTP.Close;

 if Assigned(IRemoteCon) and Assigned(ARemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(ARemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmTurmasTP := nil;
end;

procedure TFrmTurmasTP.FormCreate(Sender: TObject);
var
y, m, d: word;
begin
  inherited;
  ARemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
  CdsTurmasTP.RemoteServer := ARemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(CdsTurmasTP);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  DecodeDate(IRemoteCon.ServerDateTime, y, m, d);
  CurrentYear := Y;
end;


function TFrmTurmasTP.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormTurmasTP;
end;

function TFrmTurmasTP.GetFormIDName: string;
begin
 Result := 'Secretarias.TurmasTP';
end;

function TFrmTurmasTP.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmTurmasTP.GetHelpID: integer;
begin

end;

function TFrmTurmasTP.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmTurmasTP.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmTurmasTP.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmTurmasTP.SetCurrentYear(const Value: word);
begin
  if FCurrentYear <> Value then
   begin
    FCurrentYear := Value;
    try
     CdsTurmasTp.DisableControls;
     if CdsTurmasTp.Active then
      CdsTurmasTp.Close;
     CdsTurmasTp.Params.Items[0].Value := ICosmosApp.ActiveFocus.FocusID;
     CdsTurmasTp.Params.Items[1].Value := Value;
     CdsTurmasTp.Open;

    finally
     CdsTurmasTp.EnableControls;
     LblAno.Caption := IntToStr(Value);
    end;
   end;
end;

procedure TFrmTurmasTP.UpdateData(Sender: TObject);
begin
  inherited;
  CdsTurmasTP.Refresh;
end;

procedure TFrmTurmasTP.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmTurmasTP);

finalization
 UnRegisterClass(TFrmTurmasTP);
end.
