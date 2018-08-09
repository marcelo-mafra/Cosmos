unit cosmos.common.view.FormControleFrequencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, Grids, DBGrids, ExtCtrls, DB,
  DBClient, cosmos.frames.gridsearch, cosmos.system.messages, Cosmos.Framework.Interfaces.Dialogs,
  StdCtrls, DBCtrls, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, Menus,
  ActnPopup, ComCtrls, ValueComboBox, cosmos.classes.ServerInterface,
  cosmos.classes.application, PlatformDefaultStyleActnCtrls, cosmos.business.focos,
  cosmos.framework.datanavigators.datasets, cosmos.Framework.forms.datadialogs,
  cosmos.classes.security, System.Actions, cosmos.system.types, cosmos.system.formsconst,
  Data.DBXCommon, Datasnap.DSConnect, cosmos.framework.interfaces.dataacess;


 type
  TTipoLevantamento = (tlAtividade, tlConferencia, tlConferenciaAtividade);

  TFrmFrequencia = class(TFrmCosmosDocked, IControleFrequencia)
    ActSelecionarAtividade: TAction;
    CdsFrequencias: TClientDataSet;
    DsrFrequencia: TDataSource;
    CdsAtividade: TClientDataSet;
    DsrAtividade: TDataSource;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActVisitantes: TAction;
    ActMarcarPresenca: TAction;
    ActMarcarFalta: TAction;
    ActBarraPesquisa: TAction;
    PopupActionBar1: TPopupActionBar;
    Presente1: TMenuItem;
    Ausente1: TMenuItem;
    Visitantes1: TMenuItem;
    SelecionarAtividade1: TMenuItem;
    N1: TMenuItem;
    ActDelCadastrado: TAction;
    ExcluirCadastrado1: TMenuItem;
    ActJustificar: TAction;
    Justificar1: TMenuItem;
    ActClearAll: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText4: TDBText;
    DBText3: TDBText;
    DBText5: TDBText;
    Panel2: TPanel;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    DBText9: TDBText;
    DBText10: TDBText;
    CBXAtividades: TValueComboBox;
    LblAtividades: TLabel;
    Bevel1: TBevel;
    CdsFrequenciasCon: TClientDataSet;
    CdsConferencia: TClientDataSet;
    DsrConferencia: TDataSource;
    CdsFrequenciasAtividadeCon: TClientDataSet;
    CdsProgramacao: TClientDataSet;
    FmeGridSearch1: TFmeGridSearch;
    procedure FmeGridSearch2DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FmeGridSearch2DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBXAtividadesChange(Sender: TObject);
    procedure CdsFrequenciasAtividadeConAfterOpen(DataSet: TDataSet);
    procedure CdsFrequenciasConAfterOpen(DataSet: TDataSet);
    procedure CdsFrequenciasAfterOpen(DataSet: TDataSet);
    procedure ActClearAllExecute(Sender: TObject);
    procedure ActJustificarUpdate(Sender: TObject);
    procedure ActJustificarExecute(Sender: TObject);
    procedure ActSelecionarAtividadeExecute(Sender: TObject);
    procedure CdsFrequenciasBeforePost(DataSet: TDataSet);
    procedure ActVisitantesUpdate(Sender: TObject);
    procedure ActVisitantesExecute(Sender: TObject);
    procedure ActDelCadastradoUpdate(Sender: TObject);
    procedure ActDelCadastradoExecute(Sender: TObject);
    procedure CdsFrequenciasReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure ActMarcarFaltaUpdate(Sender: TObject);
    procedure ActMarcarPresencaUpdate(Sender: TObject);
    procedure ActMarcarPresencaExecute(Sender: TObject);
    procedure ActBarraPesquisaExecute(Sender: TObject);
    procedure CdsFrequenciasAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FTipoLevantamento: TTipoLevantamento;
    function GetActiveDataset: TDataset;

    function CanEditAtivity: boolean; inline;
    function CanEditConference: boolean; inline;
    procedure DoLancarPresencas(const codati: integer);
    procedure DoLancarPresencaConferencia(const codcon: integer);
    procedure InvertData; inline;
    procedure JustificarFalta; inline;
    procedure PesquisarCadastrados;
    procedure PesquisarAtividades;
    procedure CloseDatasets; inline;
    procedure CloseDataset(Dataset: TDataset); inline;
    procedure ListarAtividadesConferencia(const codcon: integer);
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

    {IControleFrequencia}
    procedure LancarPresencas(const codati: integer); overload;
    procedure LancarPresencas(const codati, codcon: integer); overload;
    procedure LancarPresencasConferencia(const codcon: integer);

  public
    { Public declarations }
    property ActiveDataset: TDataset read GetActiveDataset;
    property TipoLevantamento: TTipoLevantamento read FTipoLevantamento;
  end;

var
  FrmFrequencia: TFrmFrequencia;

implementation


{$R *.dfm}

procedure TFrmFrequencia.ActBarraPesquisaExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmFrequencia.ActClearAllExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
  inherited;
  if ActiveDataset = CdsFrequencias then
   begin
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Frequencia, TCosmosConfMsg.ClearFrequencia) = mrYes then
      begin
       ACommand := IRemoteCon.CreateCommand;

       try
         ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
         ACommand.Text := 'TDMSecAtividadesServerMethods.LimparFrequencias';
         ACommand.Prepare;

         ACommand.Parameters.Parameter[0].Value.SetInt32(CdsAtividade.FieldValues['codati']);
         ACommand.ExecuteUpdate;
         ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);

         CdsFrequencias.Refresh;
         ACommand.Free;

       except
        on E: Exception do
         begin
          ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
          if Assigned(ACommand) then FreeAndNil(ACommand);
         end;
       end;
      end;
   end
   else
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Frequencia, TCosmosErrorConfMsg.CantClearConf);
end;

procedure TFrmFrequencia.ActDelCadastradoExecute(Sender: TObject);
var
Cadastrado: string;
begin
  inherited;
  Cadastrado := ActiveDataset.Fields.FieldByName('nomcad').AsString;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Frequencia, Format(TCosmosConfMsg.DelFrequencia, [Cadastrado])) = mrYes then
    ActiveDataset.Delete;
end;

procedure TFrmFrequencia.ActDelCadastradoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
    and not (ActiveDataset.IsEmpty);
end;

procedure TFrmFrequencia.ActJustificarExecute(Sender: TObject);
begin
  inherited;
  JustificarFalta;
end;

procedure TFrmFrequencia.ActJustificarUpdate(Sender: TObject);
begin
  inherited;
  TAction(sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
    and (ActiveDataset.Fields.FieldByName('indpre').AsString = 'N');
end;

procedure TFrmFrequencia.ActMarcarFaltaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
    and not (ActiveDataset.IsEmpty)
    and (ActiveDataset.Fields.FieldByName('indpre').AsString = 'S');
end;

procedure TFrmFrequencia.ActMarcarPresencaExecute(Sender: TObject);
begin
  inherited;
  InvertData;
end;

procedure TFrmFrequencia.ActMarcarPresencaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
    and not (ActiveDataset.IsEmpty)
    and (ActiveDataset.Fields.FieldByName('indpre').AsString <> 'S');
end;

procedure TFrmFrequencia.ActSelecionarAtividadeExecute(Sender: TObject);
begin
  inherited;
  if ActiveDataset = CdsFrequencias then
    PesquisarAtividades;
end;

procedure TFrmFrequencia.ActVisitantesExecute(Sender: TObject);
begin
  inherited;
  if (ActiveDataset.Active) and not (ActiveDataset.IsEmpty) then
   PesquisarCadastrados;
end;

procedure TFrmFrequencia.ActVisitantesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty);
end;

function TFrmFrequencia.CanEditAtivity: boolean;
begin
 with CdsAtividade.Fields do
  begin
   Result := FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID;
   if not Result then
    begin
     ICosmosApp.DlgMessage.Execute(TCosmosTitles.Frequencia, TCosmosInfoMsg.PromotorAtividade, mtInformation);
     Exit;
    end;
  end;
end;

function TFrmFrequencia.CanEditConference: boolean;
begin
 with CdsConferencia.Fields do
  begin
   Result := (FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID);

   if FieldByName('camcon').Value = 'LEC' then
    Result := ((ctLectorium in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) or
     (ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho))
   else
   if FieldByName('camcon').Value = 'TMO' then
    Result := ctTM in IRemoteCon.CurrentConnectionInfo.CamposTrabalho
   else
   if FieldByName('camcon').Value = 'TMB' then
    Result := ctTMB in IRemoteCon.CurrentConnectionInfo.CamposTrabalho
   else
   if FieldByName('camcon').Value = 'TPU' then
    Result := ctTP in IRemoteCon.CurrentConnectionInfo.CamposTrabalho;

   if not Result then
    begin
     ICosmosApp.DlgMessage.Execute(TCosmosTitles.Frequencia, TCosmosInfoMsg.PromotorConferencia, mtInformation);
     Exit;
    end;
  end;

end;

procedure TFrmFrequencia.CBXAtividadesChange(Sender: TObject);
var
codcon, codati: integer;
begin
  inherited;
  try
    codcon := CdsConferencia.Fields.FieldByName('codcon').Value;
    codati := StrToInt(CBXAtividades.Values.Strings[CBXAtividades.ItemIndex]);

    with CdsFrequenciasAtividadeCon do
     begin
      DisableControls;
      CloseDataset(CdsFrequenciasAtividadeCon);
      Params.Items[0].Value := codcon;
      Params.Items[1].Value := codati;
      Open;
     end;

  finally
    CdsFrequenciasAtividadeCon.EnableControls;
  end;
end;

procedure TFrmFrequencia.CdsFrequenciasAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FTipoLevantamento := tlAtividade;
end;

procedure TFrmFrequencia.CdsFrequenciasAfterPost(DataSet: TDataSet);
begin
  inherited;
  if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmFrequencia.CdsFrequenciasAtividadeConAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FTipoLevantamento := tlConferenciaAtividade;
end;

procedure TFrmFrequencia.CdsFrequenciasBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 inherited;
 if Dataset.State = dsInsert then
  begin
    SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
    Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmFrequencia.CdsFrequenciasConAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FTipoLevantamento := tlConferencia;
end;

procedure TFrmFrequencia.CdsFrequenciasReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  ICosmosApp.MainLog.RegisterError(E.Message);
end;

procedure TFrmFrequencia.CloseDataset(Dataset: TDataset);
begin
 if Dataset.Active then
  Dataset.Close;
end;

procedure TFrmFrequencia.CloseDatasets;
begin
//Fecha os datasets. Esta procedure é chamada em algumas situações.
 if CdsAtividade.Active then
  CdsAtividade.Close;
 if CdsFrequencias.Active then
  CdsFrequencias.Close;
 if CdsConferencia.Active then
  CdsConferencia.Close;
 if CdsFrequenciasCon.Active then
  CdsFrequenciasCon.Close;
 if CdsFrequenciasAtividadeCon.Active then
  CdsFrequenciasAtividadeCon.Close;
end;

procedure TFrmFrequencia.DoLancarPresencaConferencia(const codcon: integer);
var
 ACommand: TDBXCommand;
begin
 ACommand := IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMSecAtividadesServerMethods.GerarFrequenciaConferencia';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(codcon);
  ACommand.ExecuteUpdate;

  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);
  ACommand.Free;


 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

procedure TFrmFrequencia.DoLancarPresencas(const codati: integer);
var
 ACommand: TDBXCommand;
begin
 ACommand := IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMSecAtividadesServerMethods.GerarFrequencia';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(codati);
  ACommand.ExecuteUpdate;

  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);
  ACommand.Free;


 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

procedure TFrmFrequencia.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsFrequencias);
end;

procedure TFrmFrequencia.FmeGridSearch2DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const IsChecked : array[Boolean] of Integer =
      (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  Dataset: TDataset;
begin
  inherited;
  Dataset := DsrFrequencia.DataSet;
  //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
  if  gdSelected in State then
   begin
    FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
    FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
   end;

  if Dataset.FieldByName('indpre').AsString = 'N' then
    FmeGridSearch1.DBGrid1.Canvas.Font.Color := clRed
  else
    FmeGridSearch1.DBGrid1.Canvas.Font.Color := clWindowText;

  FmeGridSearch1.DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmFrequencia.FmeGridSearch2DBGrid1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
Dataset: TDataset;
begin
  inherited;
  Dataset := DsrFrequencia.DataSet;
  if (Key = 13) and not (Dataset.IsEmpty) then
    InvertData;
end;

procedure TFrmFrequencia.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := ActiveDataset;
end;

procedure TFrmFrequencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CdsAtividade.RemoteServer := nil;
 CdsFrequencias.RemoteServer := nil;
 CdsConferencia.RemoteServer := nil;
 CdsFrequenciasCon.RemoteServer := nil;
 CdsFrequenciasAtividadeCon.RemoteServer := nil;
 CdsProgramacao.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);

 inherited;

 if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

 Action := caFree;
 FrmFrequencia := nil;
end;

procedure TFrmFrequencia.FormCreate(Sender: TObject);
var
I: integer;
begin
  inherited;
  for I := 0 to PageControl1.PageCount - 1 do
   PageControl1.Pages[I].TabVisible := False;

  PageControl1.ActivePageIndex := 0;

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);

  CdsAtividade.RemoteServer := FRemoteConnection;
  CdsFrequencias.RemoteServer := FRemoteConnection;
  CdsConferencia.RemoteServer := FRemoteConnection;
  CdsFrequenciasCon.RemoteServer := FRemoteConnection;
  CdsFrequenciasAtividadeCon.RemoteServer := FRemoteConnection;
  CdsProgramacao.RemoteServer := FRemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(CdsFrequencias);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;
   
  FmeGridSearch1.SearchFields := 'nomcad';

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 CdsAtividade.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
 CdsFrequencias.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
 CdsConferencia.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
 CdsFrequenciasCon.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
 CdsFrequenciasAtividadeCon.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
 CdsProgramacao.ReadOnly := IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

function TFrmFrequencia.GetActiveDataset: TDataset;
begin
 Result := DsrFrequencia.DataSet;
end;

function TFrmFrequencia.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormControleFrequencia;
end;

function TFrmFrequencia.GetFormIDName: string;
begin
 Result := 'Secretarias.Frequencia';
end;

function TFrmFrequencia.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmFrequencia.GetHelpID: integer;
begin

end;

function TFrmFrequencia.GetTitle: string;
begin
 Result := TCosmosTitles.Frequencia;
end;

procedure TFrmFrequencia.InvertData;
begin
 with ActiveDataset do
  begin
   Edit;
   if Trim(Fields.FieldByName('indpre').AsString) = 'S' then
     Fields.FieldByName('indpre').AsString := 'N'
   else
    Fields.FieldByName('indpre').AsString := 'S';
   Post;
  end;
end;

procedure TFrmFrequencia.JustificarFalta;
begin
 with ActiveDataset do
  begin
   Edit;
   if Fields.FieldByName('indjusace').Value <> 'S' then
    Fields.FieldByName('indjusace').Value := 'S'
   else
    Fields.FieldByName('indjusace').Clear;
   Post;
  end;
end;

procedure TFrmFrequencia.LancarPresencas(const codati: integer);
begin
  PageControl1.ActivePageIndex := 0;

  CloseDatasets;
  DsrFrequencia.DataSet := CdsFrequencias;

  try
   with CdsAtividade do
    begin
     DisableControls;
     CloseDataset(CdsAtividade);
     Params.Items[0].Value := codati;
     Open;
    end;

  finally
   CdsAtividade.EnableControls;
  end;

  with CdsFrequencias do
   begin
     CloseDataset(CdsFrequencias);
     Params.Items[0].Value := codati;
     Open;
   end;

 if self.CanEditAtivity then
  begin
   if CdsFrequencias.IsEmpty then
    begin
     if Trim(CdsAtividade.Fields.FieldByName('indfre').AsString) = 'N' then
      begin
        if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Frequencia, TCosmosConfMsg.Frequencia) = mrNo then
         begin
          CloseDatasets;
          Exit;
         end;
      end;
      //Gera a freqüência
      DoLancarPresencas(codati);
      CdsFrequencias.Refresh;
    end;
  end
  else
   CloseDatasets;
end;


procedure TFrmFrequencia.LancarPresencas(const codati, codcon: integer);
begin
//Lança presença em cada uma das atividades de uma conferência
  PageControl1.ActivePageIndex := 1;

  CBXAtividades.Visible := True;
  LblAtividades.Visible := True;
  Bevel1.Visible := True;

  CloseDatasets;

  ListarAtividadesConferencia(codcon);

  DsrFrequencia.DataSet := CdsFrequenciasAtividadeCon;
  DoLancarPresencaConferencia(codcon);

  CdsConferencia.Params.Items[0].Value := codcon;
  CdsConferencia.Open;

  CdsFrequenciasAtividadeCon.Params.Items[0].Value := codcon;
  CdsFrequenciasAtividadeCon.Params.Items[1].Value := codati;
  CdsFrequenciasAtividadeCon.Open;
end;

procedure TFrmFrequencia.LancarPresencasConferencia(const codcon: integer);
begin
//Lança presença em uma conferência como um todo
  PageControl1.ActivePageIndex := 1;

  CBXAtividades.Visible := False;
  LblAtividades.Visible := False;
  Bevel1.Visible := False;

  CloseDatasets;
  DsrFrequencia.DataSet := CdsFrequenciasCon;
  DoLancarPresencaConferencia(codcon);

  CdsConferencia.Params.Items[0].Value := codcon;
  CdsConferencia.Open;

  CdsFrequenciasCon.Params.Items[0].Value := codcon;
  CdsFrequenciasCon.Open;
end;

procedure TFrmFrequencia.ListarAtividadesConferencia(const codcon: integer);
begin
 try
  CloseDataset(CdsProgramacao);

  with CdsProgramacao do
   begin
    Params.Items[0].Value := codcon;
    Open;
    Filter := Format('INDFRE = %s', [QuotedStr('S')]);
    Filtered := True;

    while not Eof do
     begin
      CBXAtividades.Items.Append(Fields.FieldByName('nomati').AsString);
      CBXAtividades.Values.Append(Fields.FieldByName('codati').AsString);
      Next;
     end;
   end;

 finally
  CloseDataset(CdsProgramacao);
 end;
end;

procedure TFrmFrequencia.Locate;
begin
 inherited;
 IRemoteCon.DefaultLocate;
end;

procedure TFrmFrequencia.PesquisarAtividades;
var
ISearch: ISearchAtividades;
PackageModule: HModule;
AClass: TPersistentClass;
AForm: TForm;
begin
 try

  PackageModule := LoadPackage('pesati.bpl');
  if PackageModule <> 0 then
   begin
    AClass := GetClass('TFrmPesquisarAtividades');
    if AClass <> nil then
     AForm := TComponentClass(AClass).Create(Application) as TForm;
     with AForm do
      begin
       if Supports(AForm, ISearchAtividades) then
        ISearch := AForm as ISearchAtividades;
       if Assigned(ISearch) then
        begin
         if ISearch.ExecuteSecurityContext then
           LancarPresencas(ISearch.Dataset.Fields.FieldByName('codati').AsInteger);
        end;

       Free;
      end;
   end;

 finally
  if Assigned(ISearch) then
   ISearch := nil;
  if PackageModule <> 0 then
   UnloadPackage(PackageModule);
 end;
end;

procedure TFrmFrequencia.PesquisarCadastrados;
var
 AData: TCosmosData;
begin
 inherited;
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, False);

 try
  if AData <> nil then
   begin
    with ActiveDataset do
      begin
       DisableControls;
       if not Locate('codcad', AData.FindValue('codcad'),[]) then
         begin
          Insert;

          case TipoLevantamento of
           tlAtividade: Fields.FieldByName('codati').Value := CdsAtividade.Params.Items[0].Value;
           tlConferencia: Fields.FieldByName('codcon').Value := CdsConferencia.Params.Items[0].Value;
           tlConferenciaAtividade:
             begin
              Fields.FieldByName('codcon').Value := CdsFrequenciasAtividadeCon.Params.Items[0].Value;
              Fields.FieldByName('codati').Value := CdsFrequenciasAtividadeCon.Params.Items[1].Value;
             end;
          end;
          Fields.FieldByName('codcad').Value := AData.FindValue('codcad');
          Fields.FieldByName('matcad').Value := AData.FindValue('matcad');
          Fields.FieldByName('matcadint').Value := AData.FindValue('matcadint');
          Fields.FieldByName('nomcad').Value := AData.FindValue('nomcad');
          Fields.FieldByName('sigdis').Value := AData.FindValue('sigdis');
          Fields.FieldByName('sigfoc').Value := AData.FindValue('sigfoc');
          Fields.FieldByName('indpre').Value := 'S';
          Post;

         end
         else
           ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.ControleFrequencia, Format(TCosmosInfoMsg.FrequenciaCadastrado, [AData.FindValue('nomcad')]));
      end;
   end;

 finally
   ActiveDataset.EnableControls;
   if Assigned(AData) then
     AData.Free;
 end;
end;

procedure TFrmFrequencia.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmFrequencia.UpdateData(Sender: TObject);
begin
 inherited;
 CdsAtividade.Refresh;
 CdsFrequencias.Refresh;
end;

procedure TFrmFrequencia.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmFrequencia);

finalization
 UnRegisterClass(TFrmFrequencia);

end.
