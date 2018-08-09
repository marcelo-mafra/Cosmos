unit cosmos.secretarias.view.instalacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Vcl.Controls, Vcl.Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages,
  ComCtrls, Menus, ActnPopup, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls,
  ExtCtrls, cosmos.frames.gridsearch, StdCtrls, DB, DBClient, CommCtrl, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, cosmos.classes.security, PlatformDefaultStyleActnCtrls,
  cosmos.framework.datanavigators.treeview, cosmos.business.focos,
  cosmos.Framework.forms.wizards, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.Framework.forms.datadialogs, System.Actions, Data.DBXCommon,
  cosmos.classes.ServerInterface, Datasnap.DSConnect, cosmos.system.formsconst,
  cosmos.framework.interfaces.dataacess;

type
  TStatusTurma = (stInstalada, stProtocolada, stDesconhecida);
  TNodeType = (ntTurma, ntCandidato, ntNone);

  TTurmas = record
   codigo: integer;
   codcad: integer;
   nome: string;
   matcad: string;
   codfoc: integer;
   coddis: integer;
   nomdis: string;
   indescint: boolean;
   indins: boolean;
   tipo: TNodeType;
  end;

  PTurmas = ^TTurmas;

  TFrmInstalacoes = class(TFrmCosmosDocked)
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    PopupActionBar1: TPopupActionBar;
    TrvTurmas: TTreeView;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Image2: TImage;
    LblTurmas: TLabel;
    CdsProtocolos: TClientDataSet;
    ImgTree: TImageList;
    DsrProtocolos: TDataSource;
    ActNovaInstalacao: TAction;
    ActDelCandidato: TAction;
    NovaInstalao1: TMenuItem;
    ExcluirCandidato1: TMenuItem;
    ActAnterior: TAction;
    ActProximo: TAction;
    PopupActionBar2: TPopupActionBar;
    ActEditarAcao: TAction;
    EditarAo1: TMenuItem;
    ActInstallPupils: TAction;
    InstalarTurma1: TMenuItem;
    ActAddCandidato: TAction;
    AdicionarCandidato1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ActCarteirinhas: TAction;
    Carteirinhas1: TMenuItem;
    PgData: TPageControl;
    TabCandidato: TTabSheet;
    TabTurma: TTabSheet;
    LblNome: TLabel;
    Label2: TLabel;
    LblDiscipulado: TLabel;
    Label3: TLabel;
    LblFoco: TLabel;
    Label6: TLabel;
    LblMatricula: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    Bevel2: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    LblNomeTurma: TLabel;
    Bevel3: TBevel;
    Label8: TLabel;
    LblDiscipuladoTurma: TLabel;
    Label10: TLabel;
    LblFocoTurma: TLabel;
    Label12: TLabel;
    LblInstalada: TLabel;
    Label7: TLabel;
    LblResponsavel: TLabel;
    Label9: TLabel;
    LblDataCadastro: TLabel;
    N3: TMenuItem;
    ActFichasAlunos: TAction;
    FichasdosAlunos1: TMenuItem;
    procedure ActCarteirinhasUpdate(Sender: TObject);
    procedure ActCarteirinhasExecute(Sender: TObject);
    procedure ActAddCandidatoUpdate(Sender: TObject);
    procedure ActAddCandidatoExecute(Sender: TObject);
    procedure ActInstallPupilsUpdate(Sender: TObject);
    procedure ActInstallPupilsExecute(Sender: TObject);
    procedure ActEditarAcaoUpdate(Sender: TObject);
    procedure ActEditarAcaoExecute(Sender: TObject);
    procedure CdsProtocolosAfterPost(DataSet: TDataSet);
    procedure ActProximoExecute(Sender: TObject);
    procedure ActAnteriorExecute(Sender: TObject);
    procedure ActDelCandidatoUpdate(Sender: TObject);
    procedure ActDelCandidatoExecute(Sender: TObject);
    procedure ActNovaInstalacaoExecute(Sender: TObject);
    procedure TrvTurmasDblClick(Sender: TObject);
    procedure TrvTurmasChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvTurmasChange(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNovaInstalacaoUpdate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure ActFichasAlunosExecute(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TTreeviewDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FCurrentYear: integer;
    procedure SetCurrentYear(const Value: integer);
    procedure ListarTurmas(const Ano: integer);
    procedure ListarMembrosTurmas(const codtur: integer);
    function GetNodeID(const Node: TTreeNode): variant; inline;
    function GetSelectedNodeType: TNodeType; inline;
    function GetSelectedNodeInfo(const Info: string): variant; inline;
    procedure LoadProtocols(const codtur, codcad: integer);
    procedure LoadCandidateInfo(const codcad: integer);
    procedure LoadTurmaInfo(const codturins: integer);
    function GetStatusTurma(const Node: TTreeNode): TStatusTurma;
    function CandidatoExiste(Node: TTreeNode; codcad: integer): boolean;
    procedure UpdateData(Sender: TObject);

    function AdicionarInstalando(const codtur, codcad, coddis, codfoc: integer): boolean;
    procedure DropInstalando(const codturins, codcad: Integer);
    function InstalarTurmaAlunos(const codturins: Integer; datins: TDate): boolean;

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
  end;

var
  FrmInstalacoes: TFrmInstalacoes;

implementation

uses cosmos.secretarias.view.DataInstalacao;


{$R *.dfm}

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

{ TFrmInstalacoes }

procedure TFrmInstalacoes.ActAddCandidatoExecute(Sender: TObject);
var
 ANode: TTreeNode;
 TurmaEI: boolean;
 PTurma: PTurmas;
 sCandidato: string;
 coddis: integer;
 AData: TCosmosData;
begin
 inherited;
  if GetSelectedNodeType in [ntNone, ntCandidato] then
   Exit;

  ANode := TrvTurmas.Selected;

  if GetStatusTurma(ANode) = stInstalada then
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.AddDelInstalandos);
    Exit;
   end;

  PTurma := ANode.Data;
  TurmaEI := PTurma.indescint;
  coddis := PTurma.coddis;
  PTurma := nil;

  AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll);

 try
  if (AData <> nil) then
   begin
    if CandidatoExiste(ANode, AData.FindValue('CODCAD')) then
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.DuplicateCandidato)
    else
      begin
       if AdicionarInstalando(GetNodeID(ANode), AData.FindValue('CODCAD'), coddis,
              ICosmosApp.ActiveFocus.FocusID) then
        begin
         New(PTurma);
         PTurma.codigo := 0; //Valor não relevante neste caso...
         PTurma.codcad := AData.FindValue('CODCAD');
         PTurma.nome := AData.FindValue('NOMCAD');
         PTurma.matcad := AData.FindValue('MATCAD');
         PTurma.codfoc := AData.FindValue('CODFOC');
         PTurma.coddis := AData.FindValue('CODDIS');
         PTurma.nomdis := AData.FindValue('SIGDIS');
         PTurma.indescint := False; //Valor não relevante neste caso...
         PTurma.indins := False; //Valor não relevante neste caso...
         PTurma.tipo := ntCandidato;
         sCandidato := Format('%s (%s)', [PTurma.nome, PTurma.matcad]);

         if PTurma <> nil then  //Instalando foi escolhido e aceito....
           begin
             ANode := TrvTurmas.Items.AddChildObject(ANode, sCandidato, PTurma);
             ANode.ImageIndex := 2;
             ANode.SelectedIndex := ANode.ImageIndex;
           end;
        end;
      end;
   end;

 finally
  if Assigned(AData) then FreeAndNil(AData);
 end;
end;

procedure TFrmInstalacoes.ActAddCandidatoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (GetSelectedNodeType = ntTurma)
    and (TrvTurmas.Selected.HasChildren)
    and (GetStatusTurma(TrvTurmas.Selected) <> stInstalada)
    and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmInstalacoes.ActAnteriorExecute(Sender: TObject);
begin
  inherited;
  CurrentYear := CurrentYear - 1;
end;

procedure TFrmInstalacoes.ActCarteirinhasExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IRep: IReportCenter;
  PNode: PTurmas;
  RootNode, Node: TTreeNode;
  List: TStringList;
  NodeType: TNodeType;
begin
  inherited;

  NodeType := GetSelectedNodeType;

  case NodeType of
   ntNone: Exit;
   ntTurma:
    begin
     RootNode := TrvTurmas.Selected;
     PNode := RootNode.Data;
     if not PNode.indins then
      begin
       ICosmosApp.DlgMessage.Execute(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.CarteirinhaInstalandos, mtError);
       Exit;
      end;
    end;
   ntCandidato:
    begin
     RootNode := TrvTurmas.Selected.Parent;
     PNode := RootNode.Data;
     if not PNode.indins then
      begin
       ICosmosApp.DlgMessage.Execute(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.CarteirinhaInstalandos, mtError);
       Exit;
      end;
     RootNode := TrvTurmas.Selected;      
     PNode := RootNode.Data; 
    end;
  end;

  if (NodeType = ntTurma) and not (RootNode.HasChildren) then
   begin
    ICosmosApp.DlgMessage.Execute(TCosmosTitles.TurmasInstalacao, TCosmosInfoMsg.InstalandosCarteirinha, mtInformation);
    Exit;
   end;

  if NodeType = ntTurma then
   begin
     List := TStringList.Create;

     Node := RootNode.getFirstChild;
     if Node <> nil then
      begin
       PNode := Node.Data;
       List.Append(PNode.matcad.Trim);
      end;

     Node := Node.GetNext;

     while (Node <> nil) and (Node.Parent = RootNode) do
      begin
       PNode := Node.Data;
       List.Append(PNode.matcad.Trim);
       Node := Node.GetNext;
      end;
   end;

  try
   AForm := ICosmosApp.LoadDialog('repcen.bpl','TFrmReportCenter', AModule);

     with AForm do
      begin
       IRep := AForm as IReportCenter;
       if Assigned(IRep) then
        begin
         //IRep.ReportFile :=  ICosmosApp.IApplicationPaths.ReadReportsFolder + TCosmosFiles.SecretariasReportFile;
         if NodeType = ntTurma then
          IRep.PrintCarteirasAlunos(List.CommaText)
         else
          IRep.PrintCarteiraAluno(PNode.matcad.Trim);
        end;

       Free;
      end;

  finally
   if Assigned(IRep) then
    IRep := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmInstalacoes.ActCarteirinhasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := TrvTurmas.Selected <> nil;
end;

procedure TFrmInstalacoes.ActDelCandidatoExecute(Sender: TObject);
var
codturins, codcad: integer;
Node: TTreeNode;
begin
  inherited;
  if GetSelectedNodeType in [ntTurma, ntNone] then
   Exit;

  case GetSelectedNodeType of
   ntNone: Exit;
   ntTurma: Node := TrvTurmas.Selected;
   ntCandidato: Node := TrvTurmas.Selected.Parent;
  end;

  if GetStatusTurma(Node) = stInstalada then
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.AddDelInstalandos);
    Exit;
   end;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasInstalacao,Format(TCosmosConfMsg.DelInstalando,
        [self.GetSelectedNodeInfo('NOME')])) = mrYes  then
   begin
    codturins := GetNodeID(TrvTurmas.Selected.Parent);
    codcad := self.GetSelectedNodeInfo('CODCAD');

    DropInstalando(codturins, codcad);
    TrvTurmas.Selected.Delete;
   end;
end;

procedure TFrmInstalacoes.ActDelCandidatoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (GetSelectedNodeType = ntCandidato)
   and (GetStatusTurma(TrvTurmas.Selected.Parent) <> stInstalada)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmInstalacoes.ActEditarAcaoExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IDialog: IDialogDetalhesHistorico;
  Node: TTreeNode;
begin
 inherited;
  if (CdsProtocolos.Active = False) or (CdsProtocolos.IsEmpty) then
   Exit;

  case GetSelectedNodeType of
   ntNone: Exit;
   ntTurma: Node := TrvTurmas.Selected;
   ntCandidato: Node := TrvTurmas.Selected.Parent;
  end;

  if GetStatusTurma(Node) = stInstalada then
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.AddDelInstalandos);
    Exit;
   end;

 try
  AForm := ICosmosApp.LoadDialog('dethis.bpl', 'TFrmDetalhesEvento', AModule);

  if AForm <> nil then
   begin
    with AForm do
     begin
      if Supports(AForm, IDialogDetalhesHistorico) then
       IDialog := AForm as IDialogDetalhesHistorico;

      if Assigned(IDialog) then
       IDialog.EditarDetalhe(CdsProtocolos.Fields.FieldByName('codhis').AsInteger,
         CdsProtocolos.Fields.FieldByName('coddet').AsInteger);
      Free;
     end;
   end;

 finally
  if Assigned(IDialog) then
   IDialog := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;
end;

procedure TFrmInstalacoes.ActEditarAcaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsProtocolos.Active)
    and not (CdsProtocolos.IsEmpty)
    and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmInstalacoes.ActFichasAlunosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IRep: IReportCenter;
  PNode: PTurmas;
  RootNode, Node: TTreeNode;
  List: TStringList;
  NodeType: TNodeType;
begin
  inherited;
  NodeType := GetSelectedNodeType;

  case NodeType of
   ntNone: Exit;
   ntTurma:
    begin
     RootNode := TrvTurmas.Selected;

     if not RootNode.HasChildren then
      begin
       ICosmosApp.DlgMessage.Execute(TCosmosTitles.TurmasInstalacao, TCosmosInfoMsg.InstalandosCarteirinha, mtInformation);
       Exit;
      end;
    end;
   ntCandidato:
    begin
     PNode := TrvTurmas.Selected.Data;
     List := TStringList.Create;
     List.Append(PNode.matcad.Trim);
    end;
  end;

  if NodeType = ntTurma then
   begin
     List := TStringList.Create;

     Node := RootNode.getFirstChild;
     if Node <> nil then
      begin
       PNode := Node.Data;
       List.Append(PNode.matcad.Trim);
      end;

     Node := Node.GetNext;

     while (Node <> nil) and (Node.Parent = RootNode) do
      begin
       PNode := Node.Data;
       List.Append(PNode.matcad.Trim);
       Node := Node.GetNext;
      end;
   end;

  try
   AForm := ICosmosApp.LoadDialog('repcen.bpl','TFrmReportCenter', AModule);

     with AForm do
      begin
       IRep := AForm as IReportCenter;
       if Assigned(IRep) then
        begin
         IRep.PrintFichasAlunos(List.CommaText)
        end;

       Free;
      end;

  finally
   if Assigned(IRep) then
    IRep := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmInstalacoes.ActInstallPupilsExecute(Sender: TObject);
var
PNode: PTurmas;
Node: TTreeNode;
Data: variant;
begin
  inherited;
  if GetSelectedNodeType in [ntNone] then
   Exit;

  case GetSelectedNodeType of
   ntNone: Exit;
   ntTurma: Node := TrvTurmas.Selected;
   ntCandidato: Node := TrvTurmas.Selected.Parent;
  end;

  PNode := Node.Data;

  if PNode.indins then
   begin
    ICosmosApp.DlgMessage.Execute(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.TurmaInstalada, mtError);
    Exit;
   end;

  if PNode.indescint then
   begin //Instalação da Escola Interna
    if not (ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
     begin
       ICosmosApp.DlgMessage.Execute(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.TurmaEI, mtError);
       Exit;
     end;
   end;

  FrmDataInstalacao := TFrmDataInstalacao.Create(self);

  try
   Data := FrmDataInstalacao.ShowCalendar(Node.Text, IRemoteCon.ServerDateTime);

   if Data <> unassigned then
    begin
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasInstalacao, TCosmosConfMsg.InstalarTurma) = mrYes then
       begin
        PNode.indins := InstalarTurmaAlunos(GetSelectedNodeInfo('CODIGO'), VarToDateTime(Data));
        TrvTurmas.OnChange(TrvTurmas, TrvTurmas.Selected);
       end;
     end;

  finally
   if Assigned(FrmDataInstalacao) then
    FreeAndNil(FrmDataInstalacao);
  end;
end;

procedure TFrmInstalacoes.ActInstallPupilsUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (GetSelectedNodeType = ntTurma)
    and (GetStatusTurma(TrvTurmas.Selected) <> stInstalada)
    and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmInstalacoes.ActNovaInstalacaoExecute(Sender: TObject);
begin
  inherited;
  if TCosmosWizardsDialogs.ExecuteWizard('wznovins.bpl', 'TFrmAssistenteInstalacao') then
   ListarTurmas(CurrentYear);
end;

procedure TFrmInstalacoes.ActNovaInstalacaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := IRemoteCon.CurrentConnectionMode <> cmRead;
end;

procedure TFrmInstalacoes.ActProximoExecute(Sender: TObject);
begin
  inherited;
  CurrentYear := CurrentYear + 1;
end;

function TFrmInstalacoes.AdicionarInstalando(const codtur, codcad, coddis,
  codfoc: integer): boolean;
var
ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.AdicionarInstalando';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(codtur);
   ACommand.Parameters[1].Value.SetInt32(codcad);
   ACommand.Parameters[2].Value.SetInt32(coddis);
   ACommand.Parameters[3].Value.SetInt32(codfoc);
   ACommand.ExecuteUpdate;

   ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);
   ACommand.Free;
   Result := True;


 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.MainLog.RegisterRemoteCallFailure(ACommand.Text, IRemoteCon.ConnectionParamsInfo);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
  end;
end;

function TFrmInstalacoes.CandidatoExiste(Node: TTreeNode;
  codcad: integer): boolean;
var
PTurma: PTurmas;
ChildNode: TTreeNode;
begin
 Result := True;
 if Node <> nil then
  begin
   PTurma := Node.Data;
   Result := PTurma.codcad = codcad;
   if Result then Exit;

   if Node.HasChildren then
    begin
     Node.Expand(True);
     ChildNode := Node.getFirstChild;
     PTurma := ChildNode.Data;
     Result := PTurma.codcad = codcad;
     if Result then Exit;

     while ChildNode <> nil do
      begin
       ChildNode := ChildNode.getNextSibling;
       if ChildNode <> nil then
        begin
         PTurma := ChildNode.Data;
         Result := PTurma.codcad = codcad;
         if Result then ChildNode := nil;
        end;
      end;
    end;
  end;
end;

procedure TFrmInstalacoes.CdsProtocolosAfterPost(DataSet: TDataSet);
begin
  inherited;
  if CdsProtocolos.ChangeCount > 0 then
   CdsProtocolos.ApplyUpdates(0);
end;

procedure TFrmInstalacoes.DropInstalando(const codturins, codcad: Integer);
var
ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.DropInstalando';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(codturins);
   ACommand.Parameters[1].Value.SetInt32(codcad);
   ACommand.ExecuteUpdate;

   ACommand.Free;

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

procedure TFrmInstalacoes.ExportData;
begin
  inherited;
//To-do. Exportar treeview de turmas...
end;

procedure TFrmInstalacoes.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsProtocolos;
end;

procedure TFrmInstalacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  inherited;

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmInstalacoes := nil;
end;

procedure TFrmInstalacoes.FormCreate(Sender: TObject);
var
Year, Month, Day: word;
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scHistorico);
  CdsProtocolos.RemoteServer := FRemoteConnection;
  FmeGridSearch1.ShowSearchBar := False;

  FDataNavigator := TTreeviewDataNavigator.Create(TrvTurmas);
  self.DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  DecodeDate(IRemoteCon.ServerDateTime, Year, Month, Day);
  CurrentYear := Year;
end;

function TFrmInstalacoes.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormInstalacoes;
end;

function TFrmInstalacoes.GetFormIDName: string;
begin
 Result := 'Secretarias.Instalações';
end;

function TFrmInstalacoes.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmInstalacoes.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmInstalacoes.GetNodeID(const Node: TTreeNode): variant;
var
PNode: PTurmas;
begin
 //Recupera o código do nó passado em parâmetro
 if Node <> nil then
  begin
    PNode := Node.Data;
    Result := PNode.codigo;
  end
 else
  Result := Unassigned;
end;

function TFrmInstalacoes.GetSelectedNodeInfo(const Info: string): variant;
var
Node: PTurmas;
begin
//Recupera uma informação do nó atualmente selecionado.
 if TrvTurmas.Selected <> nil then
  begin
    Node := TrvTurmas.Selected.Data;
    if Info = 'CODIGO' then
     Result := Node.codigo
    else
    if Info = 'CODCAD' then
     Result := Node.codcad
    else
    if Info = 'NOME' then
     Result := Node.nome
    else
    if Info = 'MATCAD' then
     Result := Node.matcad
    else
    if Info = 'CODFOC' then
     Result := Node.codfoc
    else
    if Info = 'CODDIS' then
     Result := Node.coddis
    else
    if Info = 'NOMDIS' then
     Result := Node.nomdis
    else
    if Info = 'INDESCINT' then
     Result := Node.indescint
    else
    if Info = 'INDINS' then
     Result := Node.indins
    else
    if Info = 'TIPO' then
     Result := Integer(Node.tipo)
    else
     Result := Unassigned;
  end;
end;

function TFrmInstalacoes.GetSelectedNodeType: TNodeType;
var
Node: PTurmas;
begin
//Recupera o tipo no nó selecionado na treeview.
 if TrvTurmas.Selected <> nil then
  begin
    Node := TrvTurmas.Selected.Data;
    Result := Node.tipo;
  end
 else
  Result := ntNone;
end;

function TFrmInstalacoes.GetStatusTurma(const Node: TTreeNode): TStatusTurma;
var
PTurma: PTurmas;
begin
//Retorna o status de uma turma
 if Node = nil then
  begin
   Result := stDesconhecida;
   Exit;
  end;

 PTurma := Node.Data;
 if PTurma.indins then
  Result := stInstalada
 else
  Result := stProtocolada;
end;

function TFrmInstalacoes.GetTitle: string;
begin
 Result := Caption;
end;

function TFrmInstalacoes.InstalarTurmaAlunos(const codturins: Integer;
  datins: TDate): boolean;
var
ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.InstalarTurmaAlunos';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(codturins);
   ACommand.Parameters[1].Value.AsDateTime := datins;
   ACommand.Parameters[2].Value.SetWideString(ICosmosApp.IRemoteCon.CurrentUser.UserName);
   ACommand.ExecuteUpdate;

   Result := True;
   ACommand.Free;


 except
  on E: Exception do
   begin
    Result := False;
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

procedure TFrmInstalacoes.Label1Click(Sender: TObject);
var
 AModule: HModule;
 AForm: TForm;
 IFicha: ICosmosFicha;
begin
 inherited;
 if self.GetSelectedNodeType <> ntCandidato then
  Exit;

 AForm := ICosmosApp.LoadDialog('ficha.bpl', 'TFrmFicha', AModule);

 try
  if AModule <> 0 then
  begin
     with AForm do
      begin
       if Supports(AForm, ICosmosFicha) then
        IFicha := AForm as ICosmosFicha;
       if Assigned(IFicha) then
         IFicha.ShowFicha(self.GetSelectedNodeInfo('CODCAD'));
       Free;
      end;
  end;

 finally
  if Assigned(IFicha) then IFicha := nil;
  UnloadPackage(AModule);
 end;
end;

procedure TFrmInstalacoes.ListarMembrosTurmas(const codtur: integer);
var
ANode: TTreeNode;
ADataset: TClientDataset;
AParams: TSQLParams;
PTurma: PTurmas;
sCandidato: string;
begin
 ADataset := TClientDataset.Create(self);
 AParams := TSQLParams.Create(1);

 try
  AParams.AppendData(codtur);
  IRemoteCon.ExecuteDQL(csMembrosTurmaInstalacao, AParams.Params, ADataset);

  if (ADataset.Active) and not (ADataset.IsEmpty) and (ADataset.FieldValues['codmem'] <> null) then
   begin
    TrvTurmas.Items.BeginUpdate;
    TrvTurmas.Selected.DeleteChildren;

    while not ADataset.Eof do
     begin
      New(PTurma);
      PTurma.codigo := ADataset.Fields.FieldByName('codmem').AsInteger;
      PTurma.codcad := ADataset.Fields.FieldByName('codcad').AsInteger;
      PTurma.nome := ADataset.Fields.FieldByName('nomcad').AsString;
      Pturma.matcad := ADataset.Fields.FieldByName('matcad').AsString;
      PTurma.codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;
      PTurma.coddis := ADataset.Fields.FieldByName('coddis').AsInteger;
      PTurma.nomdis := ADataset.Fields.FieldByName('nomdis').AsString;
      PTurma.indescint := False;//Não faz sentido para o membro....
      PTurma.indins := False;//Não faz sentido para o membro....
      PTurma.tipo := ntCandidato;

      sCandidato := Format('%s (%s)', [PTurma.nome, PTurma.matcad]);
      ANode := TrvTurmas.Items.AddChildObject(TrvTurmas.Selected, sCandidato, PTurma);
      ANode.ImageIndex := 2;
      ANode.SelectedIndex := ANode.ImageIndex;
      ADataset.Next;
     end;
   end;

 finally
  TrvTurmas.Selected.Expand(True);
  TrvTurmas.Items.EndUpdate;
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFrmInstalacoes.ListarTurmas(const Ano: integer);
var
ANode: TTreeNode;
ADataset: TClientDataset;
AParams: TSQLParams;
PTurma: PTurmas;
sNomeTurma: string;
begin
 ADataset := TClientDataset.Create(self);
 AParams := TSQLParams.Create(2);

 try
  if CdsProtocolos.Active then
   CdsProtocolos.Close;

  AParams.AppendData(ICosmosApp.ActiveFocus.FocusID);
  AParams.AppendData(Ano, 1);
  IRemoteCon.ExecuteDQL(csTurmasInstalacao, AParams.Params, ADataset);

  TrvTurmas.Items.BeginUpdate;
  TrvTurmas.Items.Clear;

  if (ADataset.Active) and (ADataset.FieldValues['codturins'] <> null) then
   begin

    while not ADataset.Eof do
     begin
      New(PTurma);
      PTurma.codigo := ADataset.Fields.FieldByName('codturins').AsInteger;
      PTurma.codcad := 0; //Não faz sentido para turma....
      PTurma.nome := ADataset.Fields.FieldByName('numtur').AsString;
      Pturma.matcad := '';
      PTurma.codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;
      PTurma.coddis := ADataset.Fields.FieldByName('coddis').AsInteger;
      PTurma.nomdis := ADataset.Fields.FieldByName('nomdis').AsString;
      PTurma.indescint := ADataset.Fields.FieldByName('indescint').AsString = 'S';
      PTurma.indins := ADataset.Fields.FieldByName('indins').AsString = 'S';
      PTurma.tipo := ntTurma;

      sNomeTurma := Format('%s (%s)', [PTurma.nome, PTurma.nomdis]);
      ANode := TrvTurmas.Items.AddObject(nil, sNomeTurma, PTurma);
      if PTurma.indins = False then
       ANode.ImageIndex := 0
      else
       ANode.ImageIndex := 1;
      ANode.SelectedIndex := ANode.ImageIndex;

      ADataset.Next;
     end;
   end;

 finally
  TrvTurmas.Items.EndUpdate;
  if Assigned(AParams) then FreeAndNil(AParams);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFrmInstalacoes.LoadCandidateInfo(const codcad: integer);
var
 AReader: TDBXReader;
 AParams: TSQLParams;
begin
  AParams := TSQLParams.Create(1);

  try
   AParams.AppendData(codcad);
   AReader := IRemoteCon.ListData(TCosmosSearch.csCadastradoCode, AParams.Params);

  if AReader.Next then
   begin
     LblNome.Caption := AReader.Value['nomcad'].GetAnsiString;
     LblDiscipulado.Caption :=  AReader.Value['nomdis'].GetAnsiString;
     LblFoco.Caption := ICosmosApp.ActiveFocus.FocusName;
     LblMatricula.Caption := AReader.Value['matcad'].GetAnsiString;
   end;

   AParams.Free;
   AReader.Free;

 except
  on E: Exception do
   begin
    AParams.Free;
    if Assigned(AReader) then FreeAndNil(AReader);
    raise;
   end;
 end;
end;

procedure TFrmInstalacoes.LoadProtocols(const codtur, codcad: integer);
begin
 try
  with CdsProtocolos do
   begin
    DisableControls;
    if Active then Close;
    Params.Items[0].Value := codtur;
    Params.Items[1].Value := codcad;
    Open;
   end;

 finally
   CdsProtocolos.EnableControls;
 end;
end;

procedure TFrmInstalacoes.LoadTurmaInfo(const codturins: integer);
var
 AReader: TDBXReader;
 AParams: TSQLParams;
begin
  AParams := TSQLParams.Create(1);

  try
   AParams.AppendData(codturins);
   AReader := IRemoteCon.ListData(TCosmosSearch.csTurmaInstalacaoInfo, AParams.Params);

  if AReader.Next then
   begin
     LblNomeTurma.Caption := AReader.Value['numtur'].GetAnsiString;
     LblDiscipuladoTurma.Caption :=  AReader.Value['nomdis'].GetAnsiString;
     LblFocoTurma.Caption := ICosmosApp.ActiveFocus.FocusName;
     LblInstalada.Caption := TDataConverter.ToBoleanSimNao(AReader.Value['indins'].GetAnsiString);
     LblResponsavel.Caption := AReader.Value['usures'].GetAnsiString;
     LblDataCadastro.Caption := TDataConverter.ToFormatedDateTime(AReader.Value['datcad'].GetTimeStamp);
   end;

   AParams.Free;
   AReader.Free;

 except
  on E: Exception do
   begin
    AParams.Free;
    if Assigned(AReader) then FreeAndNil(AReader);
    raise;
   end;
 end;

end;

procedure TFrmInstalacoes.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmInstalacoes.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmInstalacoes.SetCurrentYear(const Value: integer);
begin
  FCurrentYear := Value;
  LblTurmas.Caption := Format(TCosmosGUIElements.TurmasAno, [Value]);
  ListarTurmas(Value);
end;

procedure TFrmInstalacoes.TrvTurmasChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if Node <> nil then
   SetNodeBoldState(Node,True);

  case GetSelectedNodeType of
   ntTurma:
    begin
     if IRemoteCon <> nil then
      begin
       LoadTurmaInfo(GetNodeID(TrvTurmas.Selected));
       PgData.ActivePage := TabTurma;
      end;
    end;
   ntCandidato:
    begin
     if IRemoteCon <> nil then
      begin
       LoadCandidateInfo(self.GetSelectedNodeInfo('CODCAD'));
       LoadProtocols(GetNodeID(TrvTurmas.Selected.Parent), GetSelectedNodeInfo('CODCAD'));
       PgData.ActivePage := TabCandidato;
      end;
    end;
  end;
end;

procedure TFrmInstalacoes.TrvTurmasChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  inherited;
  //Retira o negrito do nó
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmInstalacoes.TrvTurmasDblClick(Sender: TObject);
begin
  inherited;
  if GetSelectedNodeType = ntTurma then
   ListarMembrosTurmas(GetSelectedNodeInfo('CODIGO'));
end;

procedure TFrmInstalacoes.UpdateData(Sender: TObject);
begin
  inherited;
  case GetSelectedNodeType of
   ntTurma: ListarMembrosTurmas(GetSelectedNodeInfo('CODIGO'));
   ntCandidato: LoadProtocols(GetNodeID(TrvTurmas.Selected.Parent), self.GetSelectedNodeInfo('CODCAD'));
   ntNone: Exit;
  end;
end;

procedure TFrmInstalacoes.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmInstalacoes);

finalization
 UnRegisterClass(TFrmInstalacoes);

end.
