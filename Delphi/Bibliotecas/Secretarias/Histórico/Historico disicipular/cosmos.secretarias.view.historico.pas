unit cosmos.secretarias.view.historico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, DB, DBClient, StdCtrls, DBCtrls,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.frames.gridsearch,  ExtCtrls, ComCtrls, cosmos.framework.interfaces.dataacess,
  cosmos.system.messages, Menus, ActnPopup, ActnMan, cosmos.classes.application,
  cosmos.classes.security, XPStyleActnCtrls, ToolWin, ActnCtrls, PlatformDefaultStyleActnCtrls,
  cosmos.classes.ServerInterface, cosmos.framework.datanavigators.datasets,
  cosmos.Framework.forms.datadialogs, cosmos.business.focos, System.Actions,
  Data.DBXCommon, Datasnap.DSConnect, cosmos.system.formsconst;

type
  TFrmHistorico = class(TFrmCosmosDocked, ICosmosHistorico)
    CdsHistorico: TClientDataSet;
    DsrHistorico: TDataSource;
    Panel1: TPanel;
    Image1: TImage;
    DBText1: TDBText;
    CdsCadastrado: TClientDataSet;
    DsrCadastrado: TDataSource;
    DBText2: TDBText;
    DBText3: TDBText;
    Shape1: TShape;
    ActAnularEvento: TAction;
    ActPrint: TAction;
    ActEditarEvento: TAction;
    ActOpenHistoric: TAction;
    PopupActionBar1: TPopupActionBar;
    Detalhes1: TMenuItem;
    ActDetalhesEvento: TAction;
    DetalhesdoEvento1: TMenuItem;
    AnularEvento1: TMenuItem;
    ActCompleteHis: TAction;
    ActResumedHis: TAction;
    Visualizar1: TMenuItem;
    HistricoCompleto1: TMenuItem;
    HistricoResumido1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ImprimirHistrico1: TMenuItem;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActBarraPesquisa: TAction;
    RegistrarEvento1: TMenuItem;
    ActRegisterEvent: TAction;
    FmeGridSearch1: TFmeGridSearch;
    AbrirHistrico1: TMenuItem;
    N1: TMenuItem;
    procedure ActRegisterEventUpdate(Sender: TObject);
    procedure ActRegisterEventExecute(Sender: TObject);
    procedure ActBarraPesquisaExecute(Sender: TObject);
    procedure ActDetalhesEventoUpdate(Sender: TObject);
    procedure ActPrintUpdate(Sender: TObject);
    procedure ActPrintExecute(Sender: TObject);
    procedure ActResumedHisExecute(Sender: TObject);
    procedure ActCompleteHisExecute(Sender: TObject);
    procedure ActDetalhesEventoExecute(Sender: TObject);
    procedure ActEditarEventoExecute(Sender: TObject);
    procedure ActOpenHistoricExecute(Sender: TObject);
    procedure ActAnularEventoUpdate(Sender: TObject);
    procedure ActAnularEventoExecute(Sender: TObject);
    procedure DBText1Click(Sender: TObject);
    procedure DBText1MouseLeave(Sender: TObject);
    procedure DBText1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActEditarEventoUpdate(Sender: TObject);
    procedure ActOpenHistoricUpdate(Sender: TObject);
  private
    { Private declarations }
    ARemoteConnection: TDSProviderConnection;
    FDataNavigator: TDatasetDataNavigator;
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

    procedure LoadHistorico(const codcad: integer);

  public
    { Public declarations }
  end;

var
  FrmHistorico: TFrmHistorico;

implementation

uses cosmos.secretarias.view.eventohistorico, cosmos.secretarias.view.anularevento,
  cosmos.secretarias.view.novoevento;

{$R *.dfm}

procedure TFrmHistorico.ActAnularEventoExecute(Sender: TObject);
var
Anular: boolean;
tipeve: string;
criticals: TStringList ;
begin
  inherited;
  Anular := ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.HistoricoDiscipular, TCosmosConfMsg.AnularHistorico)= mrYes;

  if Anular then
   begin
    Criticals := TStringList.Create;
    Criticals.Append('INS');
    Criticals.Append('RET');
    Criticals.Append('DES');
    tipeve := CdsHistorico.Fields.FieldByName('tipeve').AsString;

    if Criticals.IndexOf(tipeve) >= 0 then
     begin
      if tipeve = 'INS' then
       tipeve := 'Instalação'
      else
      if tipeve = 'RET' then
       tipeve := 'Retrogradação'
      else
      if tipeve = 'DES' then
       tipeve := 'Desligamento';

      try
       if not Assigned(FrmAnularEvento) then
        FrmAnularEvento := TFrmAnularEvento.Create(self);

       Anular := FrmAnularEvento.AnularHistorico(CdsHistorico.Fields.FieldByName('codhis').AsInteger, tipeve);

      finally
       if Assigned(FrmAnularEvento) then
        FreeAndNil(FrmAnularEvento);
      end;
     end
     else
       begin //Não é um evento crítico, que afeta o discipulado. Pode deletar apenas.
        CdsHistorico.Delete;
        if CdsHistorico.ChangeCount > 0 then
          Anular := CdsHistorico.ApplyUpdates(0) = 0;
       end;

    if Anular then
     IRemoteCon.ActiveDataset.Refresh;
   end;
end;

procedure TFrmHistorico.ActAnularEventoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsHistorico.Active)
   and not (CdsHistorico.IsEmpty) and (IRemoteCon.CurrentConnectionMode <> cmRead)
   and (sfDeleteHistoricEvent in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmHistorico.ActBarraPesquisaExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TACtion(Sender).Checked;
end;

procedure TFrmHistorico.ActCompleteHisExecute(Sender: TObject);
begin
  inherited;
  CdsHistorico.Filtered := False;
end;

procedure TFrmHistorico.ActDetalhesEventoExecute(Sender: TObject);
var
  PackageModule: HModule;
  AClass: TPersistentClass;
  AForm: TForm;
  IDialog: IDialogDetalhesHistorico;
begin
  inherited;
  if (CdsHistorico.Active = False) or (CdsHistorico.IsEmpty) then
   Exit;

 try
  PackageModule := LoadPackage('dethis.bpl');
  if PackageModule <> 0 then
   begin
    AClass := GetClass('TFrmDetalhesEvento');
    if AClass = nil then
     raise exception.Create(TCosmosErrorMsg.UnregisteredClass);
    if AClass <> nil then
     AForm := TComponentClass(AClass).Create(Application) as TForm;
     with AForm do
      begin
       if Supports(AForm, IDialogDetalhesHistorico) then
        IDialog := AForm as IDialogDetalhesHistorico;

       if Assigned(IDialog) then
        IDialog.EditarDetalhes(CdsHistorico.Fields.FieldByName('codhis').AsInteger);

       Free;
      end;
   end;

 finally
  if Assigned(IDialog) then
   IDialog := nil;
  if PackageModule <> 0 then
   UnloadPackage(PackageModule);
 end;
end;

procedure TFrmHistorico.ActDetalhesEventoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsHistorico.Active) and not (CdsHistorico.IsEmpty)
    and (sfShowDetailHistoricEvent in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmHistorico.ActEditarEventoExecute(Sender: TObject);
begin
  inherited;
  if (CdsHistorico.Active = False) or (CdsHistorico.IsEmpty) then
   Exit;

  if not FmeGridSearch1.CanDblClick then
   Exit;

  {if (EventoIsEI) and (1 = 1) then
   begin
    TMyDialogs.ErrorMessage(sErrorAcessoDadoEI);
    Exit;
   end;}

  try
   if not Assigned(FrmEventoDiscipular) then
    FrmEventoDiscipular := TFrmEventoDiscipular.Create(self);
   FrmEventoDiscipular.EditarHistorico(CdsHistorico.Fields.FieldByName('codhis').AsInteger);

  finally
   if Assigned(FrmEventoDiscipular) then
    FreeAndNil(FrmEventoDiscipular);
  end;
end;

procedure TFrmHistorico.ActEditarEventoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsHistorico.Active) and not (CdsHistorico.IsEmpty)
    and (sfAlterHistoricEvent in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmHistorico.ActRegisterEventExecute(Sender: TObject);
begin
  inherited;
  if not CdsHistorico.Active then
   Exit;

  try
   if not Assigned(FrmInsEventoDiscipular) then
    FrmInsEventoDiscipular := TFrmInsEventoDiscipular.Create(self);

   FrmInsEventoDiscipular.InsertEvent(CdsCadastrado.Fields.FieldByName('codcad').AsInteger);


  finally
   if Assigned(FrmInsEventoDiscipular) then
    FreeAndNil(FrmInsEventoDiscipular);
  end;
end;

procedure TFrmHistorico.ActRegisterEventUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsHistorico.Active)
    and (IRemoteCon.CurrentUser <> nil) and (IRemoteCon.CurrentConnectionMode <> cmRead)
    and (sfRegisterHistoricEvent in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmHistorico.ActOpenHistoricExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 inherited;
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, True);

 try
  if AData <> nil then
   LoadHistorico(AData.FindValue('codcad'));

 finally
  if Assigned(AData) then FreeAndNil(AData);
 end;
end;

procedure TFrmHistorico.ActOpenHistoricUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.CurrentUser <> nil)
    and (sfLoadHistoricCadastrado in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmHistorico.ActPrintExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
  AData: TCosmosData;
begin
  inherited;
  //Imprime o histórico discipular do cadastrado
  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);
  AData := TCosmosData.Create(3);

  try
   if AForm <> nil then
    begin
     IReport := AForm as IReportCenter;
     if Assigned(IReport) then
       begin
         AData.WriteValue('CODCAD', CdsCadastrado.FieldValues['CODCAD']);
         AData.WriteValue('MATCAD', CdsCadastrado.FieldValues['MATCAD'], 1);
         AData.WriteValue('NOMCAD', CdsCadastrado.FieldValues['NOMCAD'], 2);
         IReport.PrintHistoric(AData);
       end;

     AForm.Free;
    end;

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmHistorico.ActPrintUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (CdsHistorico.Active) and not (CdsHistorico.IsEmpty);
end;

procedure TFrmHistorico.ActResumedHisExecute(Sender: TObject);
begin
  inherited;
  CdsHistorico.Filtered := True;
end;

procedure TFrmHistorico.DBText1Click(Sender: TObject);
var
 AModule: HModule;
 AForm: TForm;
 IFicha: ICosmosFicha;
begin
 inherited;
 AForm := ICosmosApp.LoadDialog('ficha.bpl', 'TFrmFicha', AModule);

 try
  if AModule <> 0 then
  begin
     with AForm do
      begin
       if Supports(AForm, ICosmosFicha) then
        IFicha := AForm as ICosmosFicha;
       if Assigned(IFicha) then
         IFicha.ShowFicha(CdsCadastrado.Fields.FieldByName('codcad').AsInteger);
       Free;
      end;
  end;

 finally
  if Assigned(IFicha) then IFicha := nil;
  UnloadPackage(AModule);
 end;
end;

procedure TFrmHistorico.DBText1MouseLeave(Sender: TObject);
begin
  inherited;
 TLabel(Sender).Font.Style :=  TLabel(Sender).Font.Style - [fsUnderline];
end;

procedure TFrmHistorico.DBText1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
 TLabel(Sender).Font.Style :=  TLabel(Sender).Font.Style + [fsUnderline]; 
end;

procedure TFrmHistorico.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsHistorico);
end;

procedure TFrmHistorico.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsHistorico;
end;

procedure TFrmHistorico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(IRemoteCon) then IRemoteCon.DropConnection(ARemoteConnection);
  if Assigned(FDataNavigator) then FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmHistorico := nil;
end;

procedure TFrmHistorico.FormCreate(Sender: TObject);
begin
  inherited;
  ARemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scHistorico);
  CdsHistorico.RemoteServer := ARemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(CdsHistorico);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;
end;

function TFrmHistorico.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormHistorico;
end;

function TFrmHistorico.GetFormIDName: string;
begin
 Result := 'Secretarias.Historico';
end;

function TFrmHistorico.GetHelpFile: string;
begin
 Result := helpFile;
end;

function TFrmHistorico.GetHelpID: integer;
begin

end;

function TFrmHistorico.GetTitle: string;
begin
 Result := 'Histórico Discipular';
end;

procedure TFrmHistorico.LoadHistorico(const codcad: integer);
var
 AParams: TSQLParams;
 aDataset: TClientDataset;
begin
//Lista os dados do histórico de um cadastrado
 AParams := TSQLParams.Create(1);
 aDataset := TClientDataset.Create(self);

 try
  AParams.AppendData(codcad);
  CdsHistorico.DisableControls;
  CdsCadastrado.DisableControls;

  if CdsHistorico.Active then
   CdsHistorico.Close;

  CdsHistorico.Params.Items[0].AsInteger := codcad;
  CdsHistorico.Open;

  IRemoteCon.ExecuteDQL(csCadastradoCode, AParams.Params, aDataset);

  //Copia os dados para o dataset persistente.
  CdsCadastrado.Data := aDataset.Data;

  CdsCadastrado.EnableControls;
  CdsHistorico.EnableControls;

  if Assigned(AParams) then FreeAndNil(AParams);
  if Assigned(aDataset) then FreeAndNil(aDataset);

 except
  on E: TDBXError do
   begin
    CdsCadastrado.EnableControls;
    CdsHistorico.EnableControls;
    ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, '');
    if Assigned(AParams) then FreeAndNil(AParams);
    if Assigned(aDataset) then FreeAndNil(aDataset);
   end
  else
   begin
    CdsCadastrado.EnableControls;
    CdsHistorico.EnableControls;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.CadastradosSearch);
    ICosmosApp.MainLog.RegisterRemoteCallFailure(TCosmosErrorMsg.CadastradosSearch, '');
    if Assigned(AParams) then FreeAndNil(AParams);
    if Assigned(aDataset) then FreeAndNil(aDataset);
   end
 end;
end;

procedure TFrmHistorico.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;


procedure TFrmHistorico.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmHistorico.UpdateData(Sender: TObject);
begin
  inherited;
  self.LoadHistorico(CdsHistorico.Params.Items[0].Value);
end;

procedure TFrmHistorico.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmHistorico);

finalization
 UnRegisterClass(TFrmHistorico);

end.
