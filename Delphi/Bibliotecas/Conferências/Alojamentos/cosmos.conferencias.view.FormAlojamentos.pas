unit cosmos.conferencias.view.FormAlojamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages,
  ComCtrls, cosmos.classes.application, cosmos.classes.ServerInterface, DBClient,
  CommCtrl, PlatformDefaultStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, Menus,
  ActnPopup, ExtCtrls, GroupHeader, StdCtrls, cosmos.frames.gridsearch, DB,
  cosmos.framework.interfaces.Dialogs, DBCtrls, cosmos.business.focos,
  cosmos.framework.datanavigators.treeview, cosmos.framework.forms.datadialogs,
  Cosmos.Framework.Interfaces.Root, cosmos.framework.forms.conferencias,
  System.Actions, Datasnap.DSConnect, cosmos.Framework.Interfaces.dataacess,
  cosmos.classes.security, cosmos.system.formsconst;

type
  TTipoItemAlojamento = (iaFoco, iaAlojamento, iaQuarto, iaLeito, iaConferencia);

  TItemAlojamento = record
   Code: variant;
   Tipo: TTipoItemAlojamento;
   Caption: string;
   Externo: boolean;
   Bloqueado: boolean;
   Quarto: Integer;
   Ala: string;
  end;

  PNode = ^TItemAlojamento;

  TFrmAlojamentos = class(TFrmCosmosDocked)
    TreeList: TImageList;
    ActNovoAlojamento: TAction;
    ActAlterarAlojamento: TAction;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    PopupActionBar1: TPopupActionBar;
    NovoAlojamento1: TMenuItem;
    AlterarAlojamento1: TMenuItem;
    Splitter1: TSplitter;
    CdsClassificadoresLeito: TClientDataSet;
    DsrClassificadoresLeito: TDataSource;
    ActAdicionarClassificador: TAction;
    PopupActionBar2: TPopupActionBar;
    MenuItem1: TMenuItem;
    ActListarClassificadores: TAction;
    ListarClassificadores1: TMenuItem;
    N1: TMenuItem;
    ActRemoverClassificador: TAction;
    ActCopiarClassificadores: TAction;
    ActColarClassificadores: TAction;
    Remover1: TMenuItem;
    CopiarClassificadores1: TMenuItem;
    ColarClassificadores1: TMenuItem;
    N2: TMenuItem;
    ListarClassificadores2: TMenuItem;
    N3: TMenuItem;
    CdsLeito: TClientDataSet;
    DsrLeito: TDataSource;
    ActRemoverHabitue: TAction;
    ActAtribuirHabitue: TAction;
    Leitos1: TMenuItem;
    AtribuirHabitu1: TMenuItem;
    RemoverHabitu1: TMenuItem;
    PgData: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    MSGroupHeader1: TMSGroupHeader;
    DBText1: TDBText;
    DBText2: TDBText;
    Label3: TLabel;
    Label4: TLabel;
    MSGroupHeader3: TMSGroupHeader;
    Image2: TImage;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    FmeGridClassificadores: TFmeGridSearch;
    ActEditarQuartos: TAction;
    Quartos1: TMenuItem;
    MSGroupHeader4: TMSGroupHeader;
    Label6: TLabel;
    Label7: TLabel;
    LblNomeQuarto: TLabel;
    LblSituacao: TLabel;
    Label8: TLabel;
    LblVagasQuarto: TLabel;
    MSGroupHeader5: TMSGroupHeader;
    Label9: TLabel;
    Label10: TLabel;
    LblNomeAlojamento: TLabel;
    LblTipoAlojamento: TLabel;
    Label13: TLabel;
    LblVagasAlojamento: TLabel;
    ActNovoLeito: TAction;
    ActEditarLeito: TAction;
    NovoLeito1: TMenuItem;
    AlterarLeito1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ActListaHabitues: TAction;
    Documentos1: TMenuItem;
    ListadeHabitus1: TMenuItem;
    N4: TMenuItem;
    ActRelacaoLeitos: TAction;
    RelaodeLeitos1: TMenuItem;
    CdsAlojadoLeito: TClientDataSet;
    CdsAlojadosQuarto: TClientDataSet;
    DsrAlojadoLeito: TDataSource;
    DsrAlojadosQuarto: TDataSource;
    MSGroupHeader7: TMSGroupHeader;
    FmeGridSearch2: TFmeGridSearch;
    Label5: TLabel;
    DBText3: TDBText;
    MSGroupHeader6: TMSGroupHeader;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    PageControl1: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TrvAlojamentos: TTreeView;
    Bevel1: TBevel;
    CbxPesquisas: TComboBox;
    TreeView1: TTreeView;
    ActLockLeito: TAction;
    ActUnlokBed: TAction;
    procedure FormCreate(Sender: TObject);
    procedure TrvAlojamentosChange(Sender: TObject; Node: TTreeNode);
    procedure TrvAlojamentosChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvAlojamentosDblClick(Sender: TObject);
    procedure ActNovoAlojamentoExecute(Sender: TObject);
    procedure ActAlterarAlojamentoExecute(Sender: TObject);
    procedure ActAlterarAlojamentoUpdate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure CdsClassificadoresLeitoAfterInsert(DataSet: TDataSet);
    procedure ActAdicionarClassificadorExecute(Sender: TObject);
    procedure ActAdicionarClassificadorUpdate(Sender: TObject);
    procedure CdsClassificadoresLeitoAfterPost(DataSet: TDataSet);
    procedure CdsClassificadoresLeitoBeforePost(DataSet: TDataSet);
    procedure ActListarClassificadoresExecute(Sender: TObject);
    procedure ActCopiarClassificadoresExecute(Sender: TObject);
    procedure ActColarClassificadoresExecute(Sender: TObject);
    procedure ActCopiarClassificadoresUpdate(Sender: TObject);
    procedure ActColarClassificadoresUpdate(Sender: TObject);
    procedure ActRemoverHabitueExecute(Sender: TObject);
    procedure ActRemoverHabitueUpdate(Sender: TObject);
    procedure ActAtribuirHabitueExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActEditarQuartosExecute(Sender: TObject);
    procedure ActNovoLeitoExecute(Sender: TObject);
    procedure ActNovoLeitoUpdate(Sender: TObject);
    procedure ActEditarLeitoExecute(Sender: TObject);
    procedure ActEditarLeitoUpdate(Sender: TObject);
    procedure ActRemoverClassificadorExecute(Sender: TObject);
    procedure ActRemoverClassificadorUpdate(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure ActLockLeitoExecute(Sender: TObject);
    procedure ActUnlokBedExecute(Sender: TObject);
    procedure ActLockLeitoUpdate(Sender: TObject);
    procedure ActUnlokBedUpdate(Sender: TObject);
    procedure ActNovoAlojamentoUpdate(Sender: TObject);
    procedure ActEditarQuartosUpdate(Sender: TObject);
    procedure ActAtribuirHabitueUpdate(Sender: TObject);
  private
    { Private declarations }
    FIConference: ICosmosConference;
    FRemoteConnection: TDSProviderConnection;
    FDataNavigator: TTreeviewDataNavigator;
    FListarClassificadores: boolean;
    FCopyData: TCosmosData;

    procedure ListarAlojamentos;
    procedure ListarQuartos(const codalo: variant);
    procedure ListarLeitos(const codqua: variant);
    procedure ListarAlojadosQuarto(const codqua, codcon: integer);
    function GetNode: PNode;
    procedure UpdateData(Sender: TObject);

    procedure LockBed(const Lock: boolean);

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
   property ListarClassificadores: boolean read FListarClassificadores;
   property CopyData: TCosmosData read FCopyData;
   property Node: PNode read GetNode;

   property IConference: ICosmosConference read FIConference;
  end;

var
  FrmAlojamentos: TFrmAlojamentos;

implementation


{$R *.dfm}

uses cosmos.conferencias.view.FormEditarAlojamento,
  cosmos.conferencias.view.FormEditarLeito,
  cosmos.conferencias.view.FormEditarQuarto;

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

{ TFrmAlojamentos }

procedure TFrmAlojamentos.ActAdicionarClassificadorExecute(Sender: TObject);
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
  inherited;
 AForm := ICosmosApp.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csClassificadoresLeitos, null) then
       begin
        if self.CdsClassificadoresLeito.Active then
           self.CdsClassificadoresLeito.Append;
        CdsClassificadoresLeito.FieldValues['codatr'] := ISimpleSearch.Dataset.FieldValues['codatr'];
        CdsClassificadoresLeito.FieldValues['sigatr'] := ISimpleSearch.Dataset.FieldValues['sigatr'];
        CdsClassificadoresLeito.FieldValues['desatrlei'] := ISimpleSearch.Dataset.FieldValues['desatrlei'];
        CdsClassificadoresLeito.Post;
       end;
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmAlojamentos.ActAdicionarClassificadorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.Tipo = iaLeito)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAtribuirClassificador in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActAlterarAlojamentoExecute(Sender: TObject);
begin
  inherited;
  if Node = nil then
   Exit;

  if not Assigned(FrmEditarAlojamento) then
   FrmEditarAlojamento := TFrmEditarAlojamento.Create(self);

  try
   FrmEditarAlojamento.EditarAlojamento(Node.Code);

  finally
   if Assigned(FrmEditarAlojamento) then
    FreeAndNil(FrmEditarAlojamento);
  end;
end;

procedure TFrmAlojamentos.ActAlterarAlojamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.Tipo = iaAlojamento)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlterarAlojamento in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActAtribuirHabitueExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 inherited;
  //Atribui um habitué ao leito selecionado.
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, False);

 try
  if AData <> nil then
   begin
    CdsLeito.Edit;
    CdsLeito.FieldValues['codcad'] := AData.FindValue('codcad');
    CdsLeito.FieldValues['nomcad'] := AData.FindValue('nomcad');
    CdsLeito.Post;
   end;

 finally
  if Assigned(AData) then FreeAndNil(AData);
 end;
end;

procedure TFrmAlojamentos.ActAtribuirHabitueUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (node.Tipo = iaLeito)
   and (CdsLeito.Active)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfManterHabitue in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActColarClassificadoresExecute(Sender: TObject);
begin
  inherited;
  CopyData.WriteValue('CODLEI', Node.Code, 1);

  with CdsClassificadoresLeito do
   begin
     Insert;
     Fields.FieldByName('CODATR').Value := CopyData.FindValue('CODATR');
     Fields.FieldByName('CODLEI').Value := CopyData.FindValue('CODLEI');
     Fields.FieldByName('SIGATR').Value := CopyData.FindValue('SIGATR');
     Fields.FieldByName('DESATRLEI').Value := CopyData.FindValue('DESATRLEI');
     Post;
   end;
end;

procedure TFrmAlojamentos.ActColarClassificadoresUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.Tipo = iaLeito) and (CopyData <> nil)
   and (self.CdsClassificadoresLeito.Active)
   //and not (self.CdsClassificadoresLeito.IsEmpty)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAtribuirClassificador in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActCopiarClassificadoresExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FCopyData) then
   FCopyData := TCosmosData.Create(5);

  CopyData.WriteValue('CODATR', CdsClassificadoresLeito.Fields.FieldByName('CODATR').Value);
  CopyData.WriteValue('CODLEI', Node.Code, 1);
  CopyData.WriteValue('SIGATR', CdsClassificadoresLeito.Fields.FieldByName('SIGATR').Value, 2);
  CopyData.WriteValue('DESATRLEI', CdsClassificadoresLeito.Fields.FieldByName('DESATRLEI').Value, 3);
end;

procedure TFrmAlojamentos.ActCopiarClassificadoresUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.Tipo = iaLeito) and
   (self.CdsClassificadoresLeito.Active) and not (self.CdsClassificadoresLeito.IsEmpty)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAtribuirClassificador in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActEditarLeitoExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmEditarLeito) then
   FrmEditarLeito := TFrmEditarLeito.Create(self);

  try
   FrmEditarLeito.EditarLeito(Node.Code);

  finally
   if Assigned(FrmEditarLeito) then FreeAndNil(FrmEditarLeito);
  end;
end;

procedure TFrmAlojamentos.ActEditarLeitoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.Tipo = iaLeito)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlterarLeito in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActEditarQuartosExecute(Sender: TObject);
var
AData: TCosmosData;
begin
  inherited;
  AData := TCosmosData.Create(2);

  if not Assigned(FrmEditarQuartos) then
   FrmEditarQuartos := TFrmEditarQuartos.Create(self);

  try
   AData.Add('codalo', Node.Code);
   AData.Add('nomalo', Node.Caption);
   FrmEditarQuartos.EditarQuartos(AData);

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(FrmEditarQuartos) then FreeAndNil(FrmEditarQuartos);
  end;
end;

procedure TFrmAlojamentos.ActEditarQuartosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.Tipo = iaAlojamento)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfQuartosAlojamento in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActListarClassificadoresExecute(Sender: TObject);
begin
  inherited;
  self.FListarClassificadores := not self.FListarClassificadores;
  TAction(Sender).Checked := self.FListarClassificadores;

  if not (self.ListarClassificadores) and (self.CdsClassificadoresLeito.Active) then
   self.CdsClassificadoresLeito.Close;
end;

procedure TFrmAlojamentos.ActLockLeitoExecute(Sender: TObject);
begin
 inherited;
 LockBed(True);
end;

procedure TFrmAlojamentos.ActLockLeitoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (node.Tipo = iaLeito)
   and (Node.Bloqueado = False)
   and (CdsLeito.Active) and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlterarLeito in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActNovoAlojamentoExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmEditarAlojamento) then
   FrmEditarAlojamento := TFrmEditarAlojamento.Create(self);

  try
   FrmEditarAlojamento.NovoAlojamento;

  finally
   if Assigned(FrmEditarAlojamento) then FreeAndNil(FrmEditarAlojamento);
  end;
end;

procedure TFrmAlojamentos.ActNovoAlojamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfNovoAlojamento in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActNovoLeitoExecute(Sender: TObject);
var
AData: TCosmosData;
begin
  inherited;
  AData := TCosmosData.Create(5);
  AData.Add('codalo',PNode(TrvAlojamentos.Selected.Parent.Data).Code);
  AData.Add('nomalo',PNode(TrvAlojamentos.Selected.Parent.Data).Caption);
  AData.Add('alaqua',Node.Ala);
  AData.Add('codqua',Node.Code);
  AData.Add('numqua',Node.Quarto);


  if not Assigned(FrmEditarLeito) then
   FrmEditarLeito := TFrmEditarLeito.Create(self);

  try
   FrmEditarLeito.NovoLeito(AData);

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(FrmEditarLeito) then FreeAndNil(FrmEditarLeito);
  end;
end;

procedure TFrmAlojamentos.ActNovoLeitoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (Node.Tipo = iaQuarto)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfNovoLeito in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActRemoverClassificadorExecute(Sender: TObject);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Classificadores, TCosmosConfMsg.ConfDelete) = mrYes then
   CdsClassificadoresLeito.Delete;
end;

procedure TFrmAlojamentos.ActRemoverClassificadorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsClassificadoresLeito.Active) and not (CdsClassificadoresLeito.IsEmpty)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAtribuirClassificador in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActRemoverHabitueExecute(Sender: TObject);
begin
  inherited;
  if CdsLeito.Active then
   begin
     CdsLeito.Edit;
     CdsLeito.Fields.FieldByName('codcad').Clear;
     CdsLeito.Fields.FieldByName('nomcad').Clear;
     CdsLeito.Post;
   end;
end;

procedure TFrmAlojamentos.ActRemoverHabitueUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (node.Tipo = iaLeito)
   and (CdsLeito.Active) and not (CdsLeito.Fields.FieldByName('codcad').IsNull)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfManterHabitue in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.ActUnlokBedExecute(Sender: TObject);
begin
  inherited;
  LockBed(False);
end;

procedure TFrmAlojamentos.ActUnlokBedUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Node <> nil) and (node.Tipo = iaLeito)
   and (Node.Bloqueado = True)
   and (CdsLeito.Active)and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlterarLeito in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAlojamentos.CdsClassificadoresLeitoAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.FieldValues['codlei'] := Node.Code;
end;

procedure TFrmAlojamentos.CdsClassificadoresLeitoAfterPost(DataSet: TDataSet);
begin
  inherited;
  if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmAlojamentos.CdsClassificadoresLeitoBeforePost(DataSet: TDataSet);
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

procedure TFrmAlojamentos.ExportData;
begin
  inherited;
  //to-do.
end;

procedure TFrmAlojamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsLeito.Active then CdsLeito.Close;
 CdsLeito.RemoteServer := nil;

 if CdsClassificadoresLeito.Active then CdsClassificadoresLeito.Close;
 CdsClassificadoresLeito.RemoteServer := nil;

 if CdsAlojadosQuarto.Active then CdsAlojadosQuarto.Close;
 CdsAlojadosQuarto.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);

 inherited;

 if Assigned(FDataNavigator) then FreeAndNil(FDataNavigator);
 if Assigned(FCopyData) then FCopyData.Free;
 if FIConference <> nil then FIConference := nil;
end;

procedure TFrmAlojamentos.FormCreate(Sender: TObject);
var
I: integer;
begin
  inherited;
  FListarClassificadores := True;
  FIConference := Application.MainForm as ICosmosConference;

  for I := 0 to Pred(PgData.PageCount) do
   PgData.Pages[I].TabVisible := False;

  PgData.ActivePageIndex := 0;

  self.ActionManager1.Style := ICosmosApp.InterfaceStyle;

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsLeito.RemoteServer := FRemoteConnection;
  CdsClassificadoresLeito.RemoteServer := FRemoteConnection;
  CdsAlojadosQuarto.RemoteServer := FRemoteConnection;

  FDataNavigator := TTreeviewDataNavigator.Create(TrvAlojamentos);
  self.DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  self.ListarAlojamentos;
end;

function TFrmAlojamentos.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormAlojamentos;
end;

function TFrmAlojamentos.GetFormIDName: string;
begin
 Result := 'Conferencias.Alojamentos';
end;

function TFrmAlojamentos.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmAlojamentos.GetHelpID: integer;
begin

end;

function TFrmAlojamentos.GetNode: PNode;
begin
 if TrvAlojamentos.Selected <> nil then
  Result := TrvAlojamentos.Selected.Data
 else
  Result := nil;
end;

function TFrmAlojamentos.GetTitle: string;
begin
 Result := TCosmosSearchsInfo.SearchAlojamentos;
end;

procedure TFrmAlojamentos.Label16Click(Sender: TObject);
var
 AModule: HModule;
 AForm: TForm;
 IFicha: ICosmosFicha;
begin
 inherited;
 if not CdsAlojadoLeito.Active then
  Exit;

 AForm := ICosmosApp.LoadDialog('ficha.bpl', 'TFrmFicha', AModule); //do not localize!

 try
  if AModule <> 0 then
  begin
     with AForm do
      begin
       if Supports(AForm, ICosmosFicha) then
        IFicha := AForm as ICosmosFicha;
       if Assigned(IFicha) then
         IFicha.ShowFicha(CdsAlojadoLeito.Fields.FieldByName('codcad').Value);
       Free;
      end;
  end;

 finally
  if Assigned(IFicha) then IFicha := nil;
  UnloadPackage(AModule);
 end;
end;

procedure TFrmAlojamentos.ListarAlojadosQuarto(const codqua, codcon: integer);
begin
//Lista os alojados em um quarto em uma conferência.
 CdsAlojadosQuarto.DisableControls;

 try
  if CdsAlojadosQuarto.Active then
    CdsAlojadosQuarto.Close;

  if IConference.ActiveConference <> nil then
   begin
    CdsAlojadosQuarto.Params.Items[0].Value := codqua;
    CdsAlojadosQuarto.Params.Items[1].Value := codcon;
    CdsAlojadosQuarto.Open;
   end;

  finally
    CdsAlojadosQuarto.EnableControls;
  end;
end;

procedure TFrmAlojamentos.ListarAlojamentos;
var
Node: PNode;
ADataset: TClientDataset;
RootNode, ANode: TTreeNode;
AParams: TCosmosData;
begin
 ADataset := TClientDataset.Create(self);
 AParams := TCosmosData.Create(5);

 try
  TrvAlojamentos.Items.BeginUpdate;
  TrvAlojamentos.Items.Clear;
  AParams.WriteValue('ACTIVE_FOCUS_ID', ICosmosApp.ActiveFocus.FocusID);

  IRemoteCon.ExecuteDQL(csAlojamentosFoco, AParams.Data, ADataset);

  if IConference.ActiveConference = nil then //Não há conferência ativa. Listar o nome do centro.
   begin
    New(Node);
    Node.Code := ICosmosApp.ActiveFocus.FocusID;
    Node.Tipo := iaFoco;
    Node.Caption := ICosmosApp.ActiveFocus.FocusName;
    Node.Externo := False;
    Node.Bloqueado := False;

    if CdsAlojadosQuarto.Active then
     CdsAlojadosQuarto.Close;
    if CdsAlojadoLeito.Active then
     CdsAlojadoLeito.Close;

    PgData.ActivePageIndex := 0;
   end
  else
   begin //Lista a conferência ativa.
    New(Node);
    Node.Code := IConference.ActiveConference.ConferenceID;
    Node.Tipo := iaConferencia;
    Node.Caption := IConference.ActiveConference.ConferenceName;
    Node.Externo := False;
    Node.Bloqueado := False;
   end;

  //Adiciona o nome do Centro de conferências aberto na sessão.
  RootNode := TrvAlojamentos.Items.AddObject(nil, Node.Caption, Node);
  RootNode.ImageIndex := 0;
  RootNode.OverlayIndex := RootNode.ImageIndex;
  RootNode.SelectedIndex := RootNode.ImageIndex;

  //Agora, adiciona os alojamentos do centro de conferência aberto na sessão.
  while not ADataset.Eof do
   begin
    if ADataset.FieldValues['nomalo'] <> null then //Teste necessário pq EOF não funciona com o dataset recebido.
     begin
      New(Node);
      Node.code := ADataset.Fields.FieldByName('codalo').AsInteger;
      Node.tipo := iaAlojamento;
      Node.Caption := ADataset.Fields.FieldByName('nomalo').AsString;
      Node.Externo := Trim(ADataset.Fields.FieldByName('indext').AsString) = 'S';
      Node.Bloqueado := False;

      ANode := TrvAlojamentos.Items.AddChildObjectFirst(RootNode, Node.Caption, Node);

      if not Node.Externo then
       ANode.ImageIndex := 1
      else
       ANode.ImageIndex := 1;

      ANode.OverlayIndex := ANode.ImageIndex;
      ANode.SelectedIndex := ANode.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  TrvAlojamentos.FullExpand;
  TrvAlojamentos.Items.EndUpdate;
  if Assigned(ADataset) then ADataset.Free;
  if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmAlojamentos.ListarLeitos(const codqua: variant);
var
ANode: PNode;
ADataset: TClientDataset;
ParentNode, TreeNode: TTreeNode;
AParams: TCosmosData;
begin
 ADataset := TClientDataset.Create(self);
 AParams := TCosmosData.Create(5);

 try
  TrvAlojamentos.Items.BeginUpdate;
  AParams.WriteValue('CODQUA', codqua);
  Parentnode := self.TrvAlojamentos.Selected;

  IRemoteCon.ExecuteDQL(csListaLeitosQuarto, AParams.Data, ADataset);
  TrvAlojamentos.Selected.DeleteChildren;

  while not ADataset.Eof do
   begin
    if ADataset.FieldValues['numlei'] <> null then
     begin
      New(ANode);
      ANode.code := ADataset.FieldValues['codlei'];
      ANode.tipo := iaLeito;
      ANode.Caption := Format(TAlojamentosConst.Leito, [ADataset.Fields.FieldByName('numlei').AsInteger]);
      ANode.Externo := False;
      ANode.Bloqueado := Trim(ADataset.FieldValues['indblo']) = 'S';

      TreeNode := TrvAlojamentos.Items.AddChildObject(ParentNode, ANode.Caption, ANode);

      if not ANode.Bloqueado then
       TreeNode.ImageIndex := 3
      else
       TreeNode.ImageIndex := 4;

     // TreeNode.OverlayIndex := TreeNode.ImageIndex;
      TreeNode.SelectedIndex := TreeNode.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  ParentNode.Expand(False);
  TrvAlojamentos.Items.EndUpdate;
  if Assigned(ADataset) then ADataset.Free;
  if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmAlojamentos.ListarQuartos(const codalo: variant);
var
ANode: PNode;
ADataset: TClientDataset;
ParentNode, TreeNode: TTreeNode;
AParams: TCosmosData;
sNumqua: string;
begin
 ADataset := TClientDataset.Create(self);
 AParams := TCosmosData.Create(5);

 try
  TrvAlojamentos.Items.BeginUpdate;
  AParams.WriteValue('CODALO',codalo);
  ParentNode := self.TrvAlojamentos.Selected;

  IRemoteCon.ExecuteDQL(csQuartosAlojamento, AParams.Data, ADataset);
  TrvAlojamentos.Selected.DeleteChildren;

  while not ADataset.Eof do
   begin
    if ADataset.FieldValues['numqua'] <> null then
     begin
      New(ANode);
      ANode.code := ADataset.Fields.FieldByName('codqua').AsInteger;
      ANode.tipo := iaQuarto;
      ANode.Quarto := ADataset.Fields.FieldByName('numqua').AsInteger;
      ANode.Ala := ADataset.Fields.FieldByName('Alaqua').AsString;

      sNumqua := Format(TAlojamentosConst.Quarto, [ADataset.Fields.FieldByName('numqua').AsString,
          ADataset.Fields.FieldByName('alaqua').AsString]);
      ANode.Caption := sNumqua;
      ANode.Externo := False;
      ANode.Bloqueado := Trim(ADataset.Fields.FieldByName('indtra').AsString) = 'S';

      TreeNode := TrvAlojamentos.Items.AddChildObjectFirst(ParentNode, ANode.Caption, ANode);

      if not ANode.Bloqueado then
       TreeNode.ImageIndex := 2
      else
       TreeNode.ImageIndex := 2;

      TreeNode.OverlayIndex := TreeNode.ImageIndex;
      TreeNode.SelectedIndex := TreeNode.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  ParentNode.Expand(False);
  TrvAlojamentos.Items.EndUpdate;
  if Assigned(ADataset) then ADataset.Free;
  if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmAlojamentos.Locate;
begin
  inherited;
 IRemoteCon.DefaultLocate;
end;

procedure TFrmAlojamentos.LockBed(const Lock: boolean);
var
 ANode: PNode;
 sIndblo: string;
begin
 if Lock then
  sIndblo := TDataConverter.ToBoleanString(True)
 else
  sIndblo := TDataConverter.ToBoleanString(False);

 if CdsLeito.Active then
  begin
   CdsLeito.Edit;
   CdsLeito.Fields.FieldByName('indblo').Value := sIndblo;
   CdsLeito.Post;
  end;

 ANode := TrvAlojamentos.Selected.Data;
 if ANode <> nil then
  begin
   ANode.Bloqueado := Lock;
   if Lock then
    TrvAlojamentos.Selected.ImageIndex := 4
   else
    TrvAlojamentos.Selected.ImageIndex := 3;

   TrvAlojamentos.Selected.SelectedIndex :=  TrvAlojamentos.Selected.ImageIndex;
   ANode := nil;
  end;
end;

procedure TFrmAlojamentos.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAlojamentos.TrvAlojamentosChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
//Negrita o nó da árvore
  if Node <> nil then
   begin
    SetNodeBoldState(Node,True);

    case self.Node.Tipo of
     iaAlojamento:
      begin
       LblNomeAlojamento.Caption := self.Node.Caption;
       case self.Node.Externo of
        True: LblTipoAlojamento.Caption := TAlojamentosConst.AlojamentoExterno;
        False: LblTipoAlojamento.Caption := TAlojamentosConst.AlojamentoProprio;
       end;
      end;

     iaQuarto:
      begin
       LblNomeQuarto.Caption := self.Node.Caption;

       case self.Node.Bloqueado of
        True: LblSituacao.Caption := TAlojamentosConst.QuartoBloqueado;
        False: LblSituacao.Caption := TAlojamentosConst.QuartoEmUso;
       end;
       if IConference.ActiveConference <> nil then
        ListarAlojadosQuarto(self.Node.Code, IConference.ActiveConference.ConferenceID);
      end;

     iaLeito:
      begin
       try
        CdsLeito.DisableControls;
        if CdsLeito.Active then
         CdsLeito.Close;

        CdsLeito.Params.Items[0].Value := self.Node.Code;
        CdsLeito.Open;

       finally
        CdsLeito.EnableControls;
       end;

       if ListarClassificadores then
        begin
         CdsClassificadoresLeito.DisableControls;

         try
          if CdsClassificadoresLeito.Active then
           CdsClassificadoresLeito.Close;

          CdsClassificadoresLeito.Params.Items[0].Value := self.Node.Code;
          CdsClassificadoresLeito.Open;

         finally
          CdsClassificadoresLeito.EnableControls;
         end;
        end;

      end;
    end;

    PgData.ActivePageIndex := Ord(TTipoItemAlojamento(self.Node.Tipo)) -1;
   end;
end;

procedure TFrmAlojamentos.TrvAlojamentosChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  //Retira o negrito do nó
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmAlojamentos.TrvAlojamentosDblClick(Sender: TObject);
begin
  inherited;
  if Node <> nil then
   begin
    case Node.Tipo of
     iaFoco, iaConferencia:
      begin
       ListarAlojamentos;
       TTreeView(Sender).FullExpand;
      end;
     iaAlojamento: self.ListarQuartos(Node.Code);
     iaQuarto: self.ListarLeitos(Node.Code);
     iaLeito: ActEditarLeito.Execute;
    end;
   end;
end;

procedure TFrmAlojamentos.UpdateData(Sender: TObject);
begin
  inherited;
  {Atualiza os dados quando ocorre a mudança do foco corrente ou, no caso do
  Gestor de Conferências, da conferência corrente.}
  if IConference.ActiveConference = nil then
    ListarAlojamentos;

  if Node <> nil then
   begin
    case Node.Tipo of
     iaAlojamento: self.ListarQuartos(Node.Code);
     iaQuarto: ListarLeitos(Node.Code);
     iaLeito: TrvAlojamentos.OnChange(TrvAlojamentos, TrvAlojamentos.Selected);
    end;
   end;
end;

procedure TFrmAlojamentos.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmAlojamentos);

finalization
 UnRegisterClass(TFrmAlojamentos);

end.
