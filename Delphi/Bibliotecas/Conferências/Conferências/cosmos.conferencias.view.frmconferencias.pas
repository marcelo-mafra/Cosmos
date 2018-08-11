unit cosmos.conferencias.view.frmconferencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ActnList, Vcl.ImgList,
  cosmos.framework.view.FrmDocked,  Vcl.ComCtrls, Vcl.Menus, Vcl.ActnPopup,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.XPStyleActnCtrls,Vcl. ExtCtrls,
  Vcl.StdCtrls, Data.DB, Datasnap.DBClient, Winapi.CommCtrl, cosmos.frames.gridsearch,
  cosmos.classes.ServerInterface, cosmos.system.messages, Datasnap.DSConnect,
  Cosmos.Framework.Interfaces.Dialogs, PlatformDefaultStyleActnCtrls,
  cosmos.classes.application, cosmos.business.focos, cosmos.classes.security,
  cosmos.framework.datanavigators.treeview, cosmos.Framework.forms.wizards,
  cosmos.Framework.forms.datadialogs, System.Actions, Data.SqlExpr,
  Vcl.RibbonObsidianStyleActnCtrls, Vcl.RibbonSilverStyleActnCtrls,
  cosmos.framework.interfaces.dataacess, cosmos.system.formsconst,
  Cosmos.Framework.Interfaces.Root;

type
  TNodeType = (ntFoco, ntConferencia, ntNone);

  TNode = record
   code: integer;
   NType: TNodeType;
   Promotor: TCampoTrabalho;
   Caption: string;
  end;

  PNode = ^TNode;

  TFrmConferencias = class(TFrmCosmosDocked)
    TrvConferencias: TTreeView;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    PopupActionBar1: TPopupActionBar;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Image1: TImage;
    LblConferenceName: TLabel;
    ActNovaConferencia: TAction;
    CdsProgramacao: TClientDataSet;
    TreeList: TImageList;
    NovaConferncia1: TMenuItem;
    ActEditarConferencia: TAction;
    EditarConferncia1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    ActRefreshList: TAction;
    EditarConferncia2: TMenuItem;
    ActRecuar: TAction;
    ActAvancar: TAction;
    Panel3: TPanel;
    Image2: TImage;
    LblConferencesCalendar: TLabel;
    DsrProgramacao: TDataSource;
    ActBuscarAtividade: TAction;
    ActDelAtividade: TAction;
    N1: TMenuItem;
    ActBarraPesquisa: TAction;
    ActParticipantes: TAction;
    Participantes1: TMenuItem;
    ActControleFrequencia: TAction;
    ControledeFreqncia1: TMenuItem;
    ActCriarAtividade: TAction;
    PopupActionBar2: TPopupActionBar;
    MenuItem1: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem8: TMenuItem;
    ActAlterarAtividade: TAction;
    AlterarAtividade1: TMenuItem;
    N3: TMenuItem;
    ActImprimirProgramacao: TAction;
    ImprimirProgramao1: TMenuItem;
    ImprimirProgramao2: TMenuItem;
    N2: TMenuItem;
    ActEscalas: TAction;
    ActTiposAtividades: TAction;
    EscalasdaAtividade1: TMenuItem;
    iposdeAtividades1: TMenuItem;
    N4: TMenuItem;
    procedure ActControleFrequenciaExecute(Sender: TObject);
    procedure ActParticipantesExecute(Sender: TObject);
    procedure ActBarraPesquisaExecute(Sender: TObject);
    procedure ActBuscarAtividadeUpdate(Sender: TObject);
    procedure ActDelAtividadeUpdate(Sender: TObject);
    procedure ActDelAtividadeExecute(Sender: TObject);
    procedure ActBuscarAtividadeExecute(Sender: TObject);
    procedure ActAvancarExecute(Sender: TObject);
    procedure ActRecuarExecute(Sender: TObject);
    procedure ActRefreshListExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ActEditarConferenciaUpdate(Sender: TObject);
    procedure ActEditarConferenciaExecute(Sender: TObject);
    procedure ActNovaConferenciaExecute(Sender: TObject);
    procedure TrvConferenciasChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvConferenciasChange(Sender: TObject; Node: TTreeNode);
    procedure TrvConferenciasDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActCriarAtividadeExecute(Sender: TObject);
    procedure ActAlterarAtividadeExecute(Sender: TObject);
    procedure ActEscalasExecute(Sender: TObject);
    procedure ActTiposAtividadesExecute(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure PopupActionBar2Popup(Sender: TObject);
    procedure ActNovaConferenciaUpdate(Sender: TObject);
    procedure ActTiposAtividadesUpdate(Sender: TObject);
    procedure ActCriarAtividadeUpdate(Sender: TObject);
    procedure ActAlterarAtividadeUpdate(Sender: TObject);
    procedure ActControleFrequenciaUpdate(Sender: TObject);
    procedure ActImprimirProgramacaoExecute(Sender: TObject);
    procedure ActImprimirProgramacaoUpdate(Sender: TObject);
  private
    { Private declarations }
    FCurrentYear: integer;
    FDataNavigator: TTreeviewDataNavigator;
    FRemoteConnection: TDSProviderConnection;

    procedure SetCurrentYear(const Value: integer);
    procedure ListarFocos(const Ano: integer);
    procedure ListarConferencias(const Ano, Foco: integer);
    function GetElementNodeCode(Node: TTreeNode): variant; inline;
    procedure ListarProgramacao(const codcon: integer);
    procedure PesquisarAtividades;
    procedure CloseDataset(Dataset: TDataset); inline;
    function GetNode: PNode;
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
    property CurrentYear: integer read FCurrentYear write SetCurrentYear;
    property Node: PNode read GetNode;
  end;

var
  FrmConferencias: TFrmConferencias;

implementation

uses cosmos.conferencias.view.frmeditconferencias,
 cosmos.conferencias.view.frmeditparticipantes;

{$R *.dfm}

{ TFrmConferencias }

procedure SetNodeBoldState(Node: TTreeNode; Value: Boolean);
var
  TVItem: TTVItem;
begin
//Insere ou retira o negrito no texto do objeto TTreeNode passado.
 if not Assigned(Node) then
  Exit;
 with TVItem do
  begin
   mask := TVIF_STATE or TVIF_HANDLE;
   hItem := Node.ItemId;
   stateMask := TVIS_BOLD;
   if Value then state := TVIS_BOLD
   else
    state := 0;
   TreeView_SetItem(Node.Handle, TVItem);
  end;
end;

procedure TFrmConferencias.ActBuscarAtividadeExecute(Sender: TObject);
begin
  inherited;
  if CdsProgramacao.Active then
   PesquisarAtividades;
end;

procedure TFrmConferencias.ActBuscarAtividadeUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.NType = ntConferencia)
    and (CdsProgramacao.Active) and (IRemoteCon.CurrentConnectionMode = cmWrite)
    and (GetElementNodeCode(TrvConferencias.Selected.Parent) = ICosmosApp.ActiveFocus.FocusID);
end;

procedure TFrmConferencias.ActAlterarAtividadeExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
  inherited;
 if Node = nil then
  Exit;

 if Node.NType <> ntConferencia then
  Exit;

 if not (CdsProgramacao.Active) or (CdsProgramacao.IsEmpty) then
   Exit;

 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarAtividade(Node.Promotor, CdsProgramacao.Fields.FieldByName('codati').Value);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmConferencias.ActAlterarAtividadeUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsProgramacao.Active) and not (CdsProgramacao.IsEmpty)
    and (Node <> nil)
    and (GetElementNodeCode(TrvConferencias.Selected.Parent) = ICosmosApp.ActiveFocus.FocusID)
    and (Assigned(IRemoteCon))
    and (IRemoteCon.CurrentConnectionMode = cmWrite);

  if (TAction(Sender).Enabled) and (Node <> nil) then
   begin
    case (Node.Promotor) of
     ctLectorium: TAction(Sender).Enabled := (cfAlterarAtividadeLectorium in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctTM: TAction(Sender).Enabled := (cfAlterarAtividadeTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctEI: TAction(Sender).Enabled := (cfAlterarAtividadeEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctSimpatizantes: TAction(Sender).Enabled := (cfAlterarAtividadeSIM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
    end;
  end;
end;

procedure TFrmConferencias.ActAvancarExecute(Sender: TObject);
begin
  inherited;
  CurrentYear := CurrentYear + 1;
end;

procedure TFrmConferencias.ActBarraPesquisaExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmConferencias.ActControleFrequenciaExecute(Sender: TObject);
var
  AForm: TCustomForm;
  IFrequencia: IControleFrequencia;
  codcon: integer;
begin
  inherited;
  if not (CdsProgramacao.Active) or (CdsProgramacao.IsEmpty) then
   Exit;

  AForm := ICosmosApp.OpenRegisteredWindow('confreq.bpl', 'TFrmFrequencia');

  if AForm <> nil then
  begin
   with AForm do
    begin
     IFrequencia := AForm as IControleFrequencia;
     if Assigned(IFrequencia) then
      begin
       codcon := CdsProgramacao.Fields.FieldByName('codcon').AsInteger;
       IFrequencia.LancarPresencasConferencia(codcon);
      end;
    end;
  end;
end;

procedure TFrmConferencias.ActControleFrequenciaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsProgramacao.Active) and not (CdsProgramacao.IsEmpty)
    and (Node <> nil)
    and (GetElementNodeCode(TrvConferencias.Selected.Parent) = ICosmosApp.ActiveFocus.FocusID)
    and (Assigned(IRemoteCon))
    and (IRemoteCon.CurrentConnectionMode = cmWrite);

  if (TAction(Sender).Enabled) and (Node <> nil) then
   begin
    case (Node.Promotor) of
     ctLectorium: TAction(Sender).Enabled := (cfControleFrequenciaLEC in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctTM: TAction(Sender).Enabled := (cfControleFrequenciaTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctEI: TAction(Sender).Enabled := (cfControleFrequenciaEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctTP: TAction(Sender).Enabled := (cfControleFrequenciaTP in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctSimpatizantes: TAction(Sender).Enabled := (cfControleFrequenciaSIM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
    end;
  end;
end;

procedure TFrmConferencias.ActCriarAtividadeExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
ADefaultData: TCosmosData;
begin
  inherited;
 if Node = nil then
  Exit;

 if Node.NType <> ntConferencia then
  Exit;

  if not CdsProgramacao.Active then
   Exit;

 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     begin
      ADefaultData := TCosmosData.Create(5);
      ADefaultData.WriteValue('CODCON', Node.code);
      ADefaultData.WriteValue('NOMCON', Node.Caption, 1);
      IAgenda.NovaAtividade(Node.Promotor, ADefaultData);
     end;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmConferencias.ActCriarAtividadeUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.NType = ntConferencia)
    and (CdsProgramacao.Active)
    and (GetElementNodeCode(TrvConferencias.Selected.Parent) = ICosmosApp.ActiveFocus.FocusID)
    and (Assigned(IRemoteCon))
    and (IRemoteCon.CurrentConnectionMode = cmWrite);

  if (TAction(Sender).Enabled) and (Node <> nil) then
   begin
    case (Node.Promotor) of
     ctLectorium: TAction(Sender).Enabled := (cfCadastrarAtividadeLectorium in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctTM: TAction(Sender).Enabled := (cfCadastrarAtividadeTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctEI: TAction(Sender).Enabled := (cfCadastrarAtividadeEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctSimpatizantes: TAction(Sender).Enabled := (cfCadastrarAtividadeSIM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
    end;
  end;
end;

procedure TFrmConferencias.ActDelAtividadeExecute(Sender: TObject);
var
codati: integer;
AParams: TSQLParams;
begin
  inherited;
  if (not CdsProgramacao.Active) or (CdsProgramacao.IsEmpty) then
   Exit;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Conferencias, TCosmosConfMsg.DelProgramacaoConferencia) = mryes then
   begin
    AParams := TSQLParams.Create(1);

    try
     codati := CdsProgramacao.Fields.FieldByName('codati').AsInteger;
     AParams.AppendData(codati, 0);

     if IRemoteCon.ExecuteCommand(ccDelAtividadeConferencia, AParams.Params) then
      self.UpdateData(self);

    finally
     if Assigned(AParams) then
      AParams.Free;
    end;
   end;
end;

procedure TFrmConferencias.ActDelAtividadeUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsProgramacao.Active) and not (CdsProgramacao.IsEmpty)
    and (Node <> nil)
    and (GetElementNodeCode(TrvConferencias.Selected.Parent) = ICosmosApp.ActiveFocus.FocusID)
    and (Assigned(IRemoteCon))
    and (IRemoteCon.CurrentConnectionMode = cmWrite)
    and (cfDeleteAtividade in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmConferencias.ActEditarConferenciaExecute(Sender: TObject);
begin
  inherited;
   if Node.NType <> ntConferencia then
    Exit;

   if GetElementNodeCode(TrvConferencias.Selected.Parent) <> ICosmosApp.ActiveFocus.FocusID then
    begin
     ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Conferencias, TCosmosInfoMsg.ConferenciaPromotor);
     Exit;
    end;

   if not Assigned(FrmEditarConferencia) then
    FrmEditarConferencia := TFrmEditarConferencia.Create(self);

  try
   FrmEditarConferencia.EditarConferencia(Node.code);

  finally
   if Assigned(FrmEditarConferencia) then
    FreeAndNil(FrmEditarConferencia);
  end;
end;

procedure TFrmConferencias.ActEditarConferenciaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.NType = ntConferencia)
   and (GetElementNodeCode(TrvConferencias.Selected.Parent) = ICosmosApp.ActiveFocus.FocusID)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);

  if (TAction(Sender).Enabled) and (Node <> nil) then
   begin
    case (Node.Promotor) of
     ctLectorium: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarConferenciaLEC in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctTM: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarConferenciaTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctEI: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarConferenciaEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctSimpatizantes: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarConferenciaSIM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
    end;
  end;
end;

procedure TFrmConferencias.ActEscalasExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 if Node = nil then
  Exit;

 if Node.NType <> ntConferencia then
  Exit;

 if not (CdsProgramacao.Active) or (CdsProgramacao.IsEmpty) then
   Exit;

 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarEscalasAtividade(CdsProgramacao.Fields.FieldByName('codati').Value);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmConferencias.ActImprimirProgramacaoExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
  AData: TCosmosData;
begin
  inherited;
  AForm := self.ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);
  AData := TCosmosData.Create(6);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      IReport := AForm as IReportCenter;
      if Assigned(IReport) then
        begin
          AData.WriteValue('CODCON', Node.code);
          AData.WriteValue('NOMCON', Node.Caption, 1);
          IReport.PrintProgramacaoConferencia(AData);
        end;

       AForm.Free;
      end;

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmConferencias.ActImprimirProgramacaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.NType = ntConferencia)
   and (GetElementNodeCode(TrvConferencias.Selected.Parent) = ICosmosApp.ActiveFocus.FocusID);
end;

procedure TFrmConferencias.ActNovaConferenciaExecute(Sender: TObject);
begin
  inherited;
  if TCosmosWizardsDialogs.ExecuteWizard('novaconf.bpl','TFrmNovaConferencia') then
   TrvConferencias.OnDblClick(TrvConferencias);
end;

procedure TFrmConferencias.ActNovaConferenciaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.CurrentConnectionMode = cmWrite)
   and (Node <> nil);

  if TAction(Sender).Enabled then
   begin
    case (Node.Promotor) of
     ctLectorium: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfNovaConferenciaLEC in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctTM: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfNovaConferenciaTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctEI: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfNovaConferenciaEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
     ctSimpatizantes: TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfNovaConferenciaSIM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
    end;
   end;
end;

procedure TFrmConferencias.ActParticipantesExecute(Sender: TObject);
begin
  inherited;
   if Node.NType <> ntConferencia then
    Exit;

  if not Assigned(FrmEditarParticipantes) then
   FrmEditarParticipantes := TFrmEditarParticipantes.Create(self);

  try
   FrmEditarParticipantes.EditarParticipantes(Node.code);

  finally
   if Assigned(FrmEditarParticipantes) then
    FreeAndNil(FrmEditarParticipantes);
  end;
end;

procedure TFrmConferencias.ActRecuarExecute(Sender: TObject);
begin
  inherited;
  CurrentYear := CurrentYear - 1;
end;

procedure TFrmConferencias.ActRefreshListExecute(Sender: TObject);
begin
  inherited;
  ListarFocos(CurrentYear);
end;

procedure TFrmConferencias.ActTiposAtividadesExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 if Node = nil then
  Exit;

 if Node.NType <> ntConferencia then
  Exit;

 if not (CdsProgramacao.Active) or (CdsProgramacao.IsEmpty) then
   Exit;

 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.CadastrarTiposAtividades;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmConferencias.ActTiposAtividadesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon))
    and (cfTiposAtividades in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmConferencias.CloseDataset(Dataset: TDataset);
begin
//Fecha um dataset caso esteja aberto
 if Dataset.Active then Dataset.Close;
end;

procedure TFrmConferencias.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(CdsProgramacao);
end;

procedure TFrmConferencias.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsProgramacao;
  IRemoteCon.ActiveDataNavigator := self.FDataNavigator;
end;

procedure TFrmConferencias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsProgramacao.Active then CdsProgramacao.Close;
 CdsProgramacao.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(FDataNavigator) then
  FreeAndNil(FDataNavigator);

  inherited;

  Action := caFree;
  FrmConferencias := nil;
end;

procedure TFrmConferencias.FormCreate(Sender: TObject);
var
Year, Month, Day: word;
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsProgramacao.RemoteServer := FRemoteConnection;

  FmeGridSearch1.SearchFields := 'destipati';

  DecodeDate(IRemoteCon.ServerDateTime, Year, Month, Day);
  CurrentYear := Year;

  FDataNavigator := TTreeviewDataNavigator.Create(TrvConferencias);
  self.DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := self.UpdateData;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

function TFrmConferencias.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormConferencias;
end;

function TFrmConferencias.GetFormIDName: string;
begin
 Result := 'gconf.conferências'
end;

function TFrmConferencias.GetHelpFile: string;
begin
 Result := self.HelpFile;
end;

function TFrmConferencias.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmConferencias.GetElementNodeCode(Node: TTreeNode): variant;
var
P: PNode;
begin
//Recupera o código de um nó passado em parâmetro
 if Node <> nil then
  begin
    P := Node.Data;
    Result := P.code;
  end
 else
  Result := Unassigned;
end;

function TFrmConferencias.GetNode: PNode;
begin
 if TrvConferencias.Selected <> nil then
  Result := TrvConferencias.Selected.Data
 else
  Result := nil;
end;

function TFrmConferencias.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmConferencias.ListarConferencias(const Ano, Foco: integer);
var
Node: PNode;
ADataset: TClientDataset;
TreeNode: TTreeNode;
AParamList: TSQLParams;

begin
 ADataset := TClientDataset.Create(self);
 AParamList := TSQLParams.Create(2);

 try
  TrvConferencias.Items.BeginUpdate;
  TrvConferencias.Selected.DeleteChildren;
  AParamList.AppendData(Foco, 0);
  AParamList.AppendData(Ano, 1);

  IRemoteCon.ExecuteDQL(csConferenciasFocoAno, AParamList.Params, ADataset);

  while not ADataset.Eof do
   begin
    if ADataset.FieldValues['nomcon'] <> null then
     begin
      New(Node);
      with ADataset.Fields do
       begin
        Node.code := FieldByName('codcon').AsInteger;
        Node.NType := ntConferencia;

        if Trim(ADataset.Fields.FieldByName('camcon').AsString) = 'LEC' then
          Node.Promotor := ctLectorium
        else
        if Trim(ADataset.Fields.FieldByName('camcon').AsString) = 'TMO' then
          Node.Promotor := ctTM
        else
        if Trim(ADataset.Fields.FieldByName('camcon').AsString) = 'TMB' then
          Node.Promotor := ctTMB
        else
        if Trim(ADataset.Fields.FieldByName('camcon').AsString) = 'TPU' then
          Node.Promotor := ctTP
        else
        if Trim(ADataset.Fields.FieldByName('camcon').AsString) = 'EIN' then
          Node.Promotor := ctEI
        else
          Node.Promotor := ctNONE;

        Node.Caption := Format('%s (%s)', [FieldByName('nomcon').AsString,
            FieldByName('camcon').AsString]);
       end;

      TreeNode := TrvConferencias.Items.AddChildObject(TrvConferencias.Selected,
        Node.Caption, Node);

      TreeNode.ImageIndex := 2;

      TreeNode.OverlayIndex := TreeNode.ImageIndex;
      TreeNode.SelectedIndex := TreeNode.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  TrvConferencias.Selected.Expand(False);
  TrvConferencias.Items.EndUpdate;
  if Assigned(ADataset) then ADataset.Free;
  if Assigned(AParamList) then AParamList.Free;
 end;
end;

procedure TFrmConferencias.ListarFocos(const Ano: integer);
var
Node: PNode;
ADataset: TClientDataset;
TreeNode: TTreeNode;
AParamsList: TSQLParams;
begin
 ADataset := TClientDataset.Create(self);
 AParamsList := TSQLParams.Create(1);

 try
  TrvConferencias.Items.BeginUpdate;
  TrvConferencias.Items.Clear;
  AParamsList.AppendData(Ano);


  IRemoteCon.ExecuteDQL(csFocosConferencias, AParamsList.Params, ADataset);


  while not ADataset.Eof do
   begin
    if ADataset.FieldValues['nomfoc'] <> null then
     begin
      New(Node);
      Node.code := ADataset.Fields.FieldByName('codfoc').AsInteger;
      Node.NType := ntFoco;
      Node.Caption := ADataset.Fields.FieldByName('nomfoc').AsString;

      TreeNode := TrvConferencias.Items.AddObject(nil, Node.Caption, Node);

      if Node.code <> ICosmosApp.ActiveFocus.FocusID then
       TreeNode.ImageIndex := 0
      else
       TreeNode.ImageIndex := 1;

      TreeNode.OverlayIndex := TreeNode.ImageIndex;
      TreeNode.SelectedIndex := TreeNode.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  TrvConferencias.Items.EndUpdate;
  if Assigned(ADataset) then ADataset.Free;
  if Assigned(AParamsList) then AParamsList.Free;
 end;
end;

procedure TFrmConferencias.ListarProgramacao(const codcon: integer);
begin
 try
  with CdsProgramacao do
   begin
    DisableControls;
    if Active then Close;
    Params.Items[0].Value := codcon;
    Open;
   end;

 finally
   CdsProgramacao.EnableControls;
 end;
end;

procedure TFrmConferencias.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmConferencias.PesquisarAtividades;
var
AData: TCosmosData;
codati: integer;
begin
 AData := TCosmosAtividadesDialogs.SelecionarAtividades;
 if AData <> nil then
  begin
   codati := AData.FindValue('CODATI');

   if AData.FindValue('CODCON') = null then
     begin
      AData.ClearData;
      AData.WriteValue('CODCON', CdsProgramacao.Params.Items[0].AsInteger);
      AData.WriteValue('CODATI', codati, 1);

      if IRemoteCon.ExecuteCommand(ccAtividadeConferencia, AData.Data) then
       self.UpdateData(self);
     end
    else
     ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Conferencias, TCosmosInfoMsg.ConferenciaNoAddAtividade);
  end;
end;

procedure TFrmConferencias.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmConferencias.PopupActionBar2Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmConferencias.SetCurrentYear(const Value: integer);
begin
  FCurrentYear := Value;
  LblConferencesCalendar.Caption := Format(TCosmosGUIElements.ConferencesCalendar, [Value]);
  ListarFocos(Value);
end;

procedure TFrmConferencias.TrvConferenciasChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
//Negrita o nó da árvore
  if Node <> nil then
   begin
    SetNodeBoldState(Node,True);
    case self.Node.NType of
     ntFoco:
      begin
       LblConferenceName.Caption := '-';
       CloseDataset(CdsProgramacao);
      end;
     ntConferencia:
       begin
        LblConferenceName.Caption := Node.Text;
        ListarProgramacao(self.Node.code);
       end;
    end;
   end;
end;

procedure TFrmConferencias.TrvConferenciasChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  //Retira o negrito do nó
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmConferencias.TrvConferenciasDblClick(Sender: TObject);
var
Node: PNode;
begin
  inherited;
  if TrvConferencias.Selected = nil then
   Exit;

  Node := TrvConferencias.Selected.Data;

  case Node.NType of
   ntFoco: ListarConferencias(CurrentYear, Node.code);
   ntConferencia: ActEditarConferencia.Execute;
  end;
end;

procedure TFrmConferencias.UpdateData(Sender: TObject);
begin
//Atualiza os dados exibidos, de acordo com o item selecionado na árvore.
 if Node = nil then
  Exit;

 case Node.NType of
  ntFoco: self.ListarConferencias(CurrentYear, Node.code);
  ntConferencia: self.ListarProgramacao(Node.code);
  ntNone: Exit;
 end;
end;

procedure TFrmConferencias.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmConferencias);

finalization
 UnRegisterClass(TFrmConferencias);

end.
