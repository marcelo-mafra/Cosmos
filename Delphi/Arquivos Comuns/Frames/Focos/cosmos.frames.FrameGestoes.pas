unit cosmos.frames.FrameGestoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBClient, ComCtrls, Menus, ActnPopup, ActnList, ImgList, CommCtrl,
  ActnMan, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, PlatformDefaultStyleActnCtrls,
  Cosmos.System.Messages, System.Actions, cosmos.classes.ServerInterface,
  cosmos.classes.application;

type
  TGestaoItem = (giGestao, giOrgaoGestor, giMembro, giEsfera, giUnknown);

  TListType = (ltGestoes, ltOrgaos, ltEsferaAcao, ltSequencial, ltNone);

  TNavigationStyle = (nsNormal, nsWeb);

  TGestaoItemSet = set of TGestaoItem;

  PGestoes = ^TGestoes;

  TGestoes = record
   coditem: integer;
   nomitem: string;
   noming: string;
   tipitem: TGestaoItem;
   sigitem: string;
   orgsup: string;
   nomfoc: string;
   descar: string;
   sigdis: string;
   codcad: integer;
   matcad: string;
   datini: TDate;
   datter: TDate;
  end;


  TFmeGestoes = class(TFrame)
    TrvGestoes: TTreeView;
    ImgTree: TImageList;
    ActionFrame: TActionList;
    ActNovaGestao: TAction;
    ActEditGestao: TAction;
    ActNovoOrgao: TAction;
    ActOrgaosStyle: TAction;
    ActEsferaStyle: TAction;
    ActCanEdit: TAction;
    ActEditOrgao: TAction;
    ActDelOrgao: TAction;
    ActDelGestao: TAction;
    ActNormalStyle: TAction;
    ActWebNavigationStyle: TAction;
    ActAutoExpand: TAction;
    ActEditDirigente: TAction;
    PopupActionBarEx1: TPopupActionBar;
    RAs1: TMenuItem;
    Focos1: TMenuItem;
    NovoFoco1: TMenuItem;
    EditarFoco1: TMenuItem;
    ExcluirFoco1: TMenuItem;
    PermitirEdio1: TMenuItem;
    N4: TMenuItem;
    FocosTitulares1: TMenuItem;
    Seqencial1: TMenuItem;
    N5: TMenuItem;
    EstiloNormal1: TMenuItem;
    EstiloWeb1: TMenuItem;
    N6: TMenuItem;
    AutoExpanso1: TMenuItem;
    ImageList1: TImageList;
    ActSequencialStyle: TAction;
    Seqencial2: TMenuItem;
    EditarGesto1: TMenuItem;
    ExcluirGesto1: TMenuItem;
    NovaGesto1: TMenuItem;
    ActNewDirigente: TAction;
    ActDelDirigente: TAction;
    Dirigentes1: TMenuItem;
    ExcluirDirigente1: TMenuItem;
    EditarDirigente2: TMenuItem;
    NovoDirigente1: TMenuItem;
    ActEndMandate: TAction;
    EncerrarMandato1: TMenuItem;
    N1: TMenuItem;
    ActEndMandates: TAction;
    EncerrarMandatos1: TMenuItem;
    N2: TMenuItem;
    ActCopyDirigente: TAction;
    ActPasteDirigente: TAction;
    CopiarDirigente1: TMenuItem;
    ColarDirigente1: TMenuItem;
    ActDuplicarGestao: TAction;
    Action11: TMenuItem;
    N3: TMenuItem;
    ActFichaAluno: TAction;
    FichadoAluno1: TMenuItem;
    N7: TMenuItem;
    ActAtaPosse: TAction;
    AtadePosse1: TMenuItem;
    N8: TMenuItem;
    procedure ActAtaPosseExecute(Sender: TObject);
    procedure ActFichaAlunoUpdate(Sender: TObject);
    procedure ActFichaAlunoExecute(Sender: TObject);
    procedure ActDuplicarGestaoExecute(Sender: TObject);
    procedure ActPasteDirigenteUpdate(Sender: TObject);
    procedure ActPasteDirigenteExecute(Sender: TObject);
    procedure ActCopyDirigenteExecute(Sender: TObject);
    procedure ActEndMandatesExecute(Sender: TObject);
    procedure ActEndMandateExecute(Sender: TObject);
    procedure ActNewDirigenteUpdate(Sender: TObject);
    procedure ActDelDirigenteExecute(Sender: TObject);
    procedure ActNewDirigenteExecute(Sender: TObject);
    procedure ActEditDirigenteUpdate(Sender: TObject);
    procedure ActEditDirigenteExecute(Sender: TObject);
    procedure ActDelGestaoUpdate(Sender: TObject);
    procedure ActDelGestaoExecute(Sender: TObject);
    procedure ActEditGestaoUpdate(Sender: TObject);
    procedure ActEditGestaoExecute(Sender: TObject);
    procedure ActNovaGestaoUpdate(Sender: TObject);
    procedure ActNovaGestaoExecute(Sender: TObject);
    procedure ActDelOrgaoExecute(Sender: TObject);
    procedure ActOrgaosStyleUpdate(Sender: TObject);
    procedure ActOrgaosStyleExecute(Sender: TObject);
    procedure TrvGestoesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TrvGestoesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TrvGestoesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrvGestoesKeyPress(Sender: TObject; var Key: Char);
    procedure TrvGestoesDblClick(Sender: TObject);
    procedure ActEditOrgaoUpdate(Sender: TObject);
    procedure ActNovoOrgaoUpdate(Sender: TObject);
    procedure TrvGestoesChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvGestoesChange(Sender: TObject; Node: TTreeNode);
    procedure ActEditOrgaoExecute(Sender: TObject);
    procedure ActNovoOrgaoExecute(Sender: TObject);
    procedure ActCanEditUpdate(Sender: TObject);
    procedure ActCanEditExecute(Sender: TObject);
    procedure ActAutoExpandExecute(Sender: TObject);
    procedure ActNormalStyleExecute(Sender: TObject);
    procedure PopupActionBarEx1Popup(Sender: TObject);

  private
    { Private declarations }
    FNavigationStyle: TNavigationStyle;
    FAllowEdit: boolean;
    FListType: TListType;
    FOnSelectItem: TNotifyEvent;
    FAutoExpand: boolean;
    CopiedNode: TTreeNode;
    FIRemoteCon: ICosmosRemoteConnection;

    function GetSelectedItem: TTreeNode;
    function GetSelectedType: TGestaoItem;
    procedure SetAutoExpand(const Value: boolean);
    procedure ClearData(Sender: TObject);
    procedure SetListType(const Value: TListType);
    procedure SetNavigationStyle(const Value: TNavigationStyle);
    function FindNode(const Text: string; Root: TTreeNode): TTreeNode;
    procedure ListOrgaos(const Parent: TTreeNode);
    procedure ListOrgaosByEsfera;
    procedure ListOrgaosByName;
    procedure ListGestoesOrgao(const Parent: TTreeNode);
    procedure ListDirections(const Parent: TTreeNode);
    function ItemTypeToString(const ItemType: TGestaoItem): string;
    function CloneDirigente(const coddir, codges: integer): boolean;

  protected
    procedure SelectItem; virtual;

  public
    { Public declarations }
   procedure CreateFramesObjects;
   function GetItemID(const Node: TTreeNode): integer; inline;
   function GetItemType(const Node: TTreeNode): TGestaoItem; overload;
   procedure ClearTreeData;
   function GetParentItemType(const Focus: TTreeNode): TGestaoItem;

   property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;   


  published
   property AllowEdit: boolean read FAllowEdit write FAllowEdit default True;
   property AutoExpand: boolean read FAutoExpand write SetAutoExpand default False;
   property ListType: TListType read FListType write SetListType default ltNone;
   property NavigationStyle: TNavigationStyle read FNavigationStyle write SetNavigationStyle;
   property SelectedItem: TTreeNode read GetSelectedItem;
   property SelectedType: TGestaoItem read GetSelectedType;
   property OnSelectItem: TNotifyEvent read FOnSelectItem write FOnSelectItem;

  end;

implementation

uses FormEditOrgao, FormEditGestoes, FormEditDirecoes,
  FormDlgCopyMembro, DlgCopyGestao;

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

{ TFmeGestoes }

procedure TFmeGestoes.SetNavigationStyle(const Value: TNavigationStyle);
begin
 if Value = FNavigationStyle then
  FNavigationStyle := Value;
 TrvGestoes.HotTrack := Value = nsWeb;
end;

function TFmeGestoes.GetSelectedItem: TTreeNode;
begin
 Result := TrvGestoes.Selected;
end;

function TFmeGestoes.GetSelectedType: TGestaoItem;
begin
 Result := GetItemType(SelectedItem);
end;

procedure TFmeGestoes.SetListType(const Value: TListType);
begin
 FListType := Value;
 
 case Value of
  ltOrgaos:  ListOrgaos(nil);
  ltEsferaAcao: ListOrgaosByEsfera;
  ltSequencial: ListOrgaosByName;
 end;
end;

procedure TFmeGestoes.SetAutoExpand(const Value: boolean);
begin
 FAutoExpand := Value;
 TrvGestoes.AutoExpand := FAutoExpand;
end;

procedure TFmeGestoes.SelectItem;
begin
 if Assigned(FOnSelectItem) then
  FOnSelectItem(self);
end;

function TFmeGestoes.GetItemType(const Node: TTreeNode): TGestaoItem;
var
PGest: PGestoes;
begin
//Retorna o tipo de um nó.
 if Node = nil then
  Result := giUnknown
 else
  begin
   PGest := Node.Data;
   Result := PGest.tipitem;
  end;
end;

function TFmeGestoes.ItemTypeToString(const ItemType: TGestaoItem): string;
begin
 case ItemType of
  giGestao: Result := TCosmosMiscellaneous.Gestao;
  giOrgaoGestor: Result := TCosmosMiscellaneous.OrgaoGestor;
  giMembro: Result := TCosmosMiscellaneous.MembroOrgao;
  giUnknown: Result := TCosmosMiscellaneous.Unknown;
 end;
end;

function TFmeGestoes.GetParentItemType(const Focus: TTreeNode): TGestaoItem;
begin
//Obtém o tipo do foco superior de um determinada foco
 if Focus <> nil then
  Result := GetItemType(Focus.Parent)
 else
  Result := giUnknown;
end;

procedure TFmeGestoes.ClearTreeData;
begin
//Este método deve ser usado para limpar o treeview
 try
  TrvGestoes.Items.BeginUpdate;
  TrvGestoes.Items.Clear;

 finally
  TrvGestoes.Items.EndUpdate;
 end;
end;

function TFmeGestoes.GetItemID(const Node: TTreeNode): integer;
var
PGest: PGestoes;
begin
//Retorna o ID de um nó.
 if Node <> nil then
  begin
   PGest := Node.Data;
   Result := PGest.coditem;
  end
end;

procedure TFmeGestoes.ClearData(Sender: TObject);
begin
 try
  TrvGestoes.Items.BeginUpdate;
  TrvGestoes.Items.Clear;

 finally
  TrvGestoes.Items.EndUpdate;
 end;
end;

procedure TFmeGestoes.ActNormalStyleExecute(Sender: TObject);
begin
  case TAction(Sender).Tag of
   0: NavigationStyle := nsNormal;
   1: NavigationStyle := nsWeb;
  end;
end;

procedure TFmeGestoes.ActAtaPosseExecute(Sender: TObject);
var
  PackageModule: HModule;
  AClass: TPersistentClass;
  AForm: TForm;
  IAta: IAtaPosse;
begin
{Este método apenas carrega a dll com a janela de login e retorna true ou false
conforme o usuário tenha clicado no botão "Conectar" ou não. Além disto,
armazena os dados de conexão fornecidos pelo usuário nos parâmetros do método.}
 try

  PackageModule := LoadPackage('ataposse.bpl');
  if PackageModule <> 0 then
   begin
    AClass := GetClass('TFrmAtaPosse');
    if AClass = nil then
     raise exception.Create(TCosmosErrorMsg.UnregisteredClass);
    if AClass <> nil then
     AForm := TComponentClass(AClass).Create(Application) as TForm;
     with AForm do
      begin
       if Supports(AForm, IAtaPosse) then
         IAta := AForm as IAtaPosse;

       if Assigned(IAta) then
        begin
         IAta.Gestao := StrToInt(TrvGestoes.Selected.Text);
         IAta.GenerateAta;
        end;

       Free;
      end;
   end;

 finally
  if Assigned(IAta) then
   IAta := nil;
  if PackageModule <> 0 then
   UnloadPackage(PackageModule);
 end;

end;

procedure TFmeGestoes.ActAutoExpandExecute(Sender: TObject);
begin
  AutoExpand := TAction(Sender).Checked;
end;

procedure TFmeGestoes.ActCanEditExecute(Sender: TObject);
begin
 AllowEdit := not AllowEdit;
end;

procedure TFmeGestoes.ActCanEditUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := AllowEdit;
end;

procedure TFmeGestoes.ListOrgaos(const Parent: TTreeNode);
//Lista os focos de forma alfabética seqüencial e não hierárquica
var
 PGestao: PGestoes;
 ADataset: TClientDataset;
 Node: TTreeNode;
 ICosmosApp: ICosmosApplication;
 aParams: TCosmosData;
begin

 ADataset := TClientDataset.Create(self); //Cria o dataset em memória
 ICosmosApp := Application.MainForm as ICosmosApplication;
 aParams := TCosmosData.Create(2);

 try
  TrvGestoes.Items.BeginUpdate;//Método chamado para impedir draw desnecessário

  if Parent = nil then
   begin
    //Chama o método remoto do servidor
    aParams.WriteValue('CODPAI', 'is null'); //do not localize
    ICosmosApp.IRemoteCon.ExecuteDQL(csListOrgaos, aParams.Data, ADataset);
    TrvGestoes.Items.Clear;
   end
  else
   begin
    aParams.WriteValue('CODPAI', GetItemID(Parent));
    ICosmosApp.IRemoteCon.ExecuteDQL(csListSubOrgaos, aParams.Data, ADataset);
   end;


  while not ADataset.Eof do
   begin
    if FindNode(ADataset.Fields.FieldByName('nomorg').AsString, Parent) = nil then
     begin
      New(PGestao);//Cria um novo ponteiro do record TFocos
      PGestao.coditem := ADataset.Fields.FieldByName('codorg').AsInteger;
      PGestao.nomitem := ADataset.Fields.FieldByName('nomorg').AsString;
      PGestao.noming := ADataset.Fields.FieldByName('nomorging').AsString;
      PGestao.tipitem := giOrgaoGestor;
      PGestao.sigitem := ADataset.Fields.FieldByName('sigorg').AsString;
      if not ADataset.Fields.FieldByName('orgsup').IsNull then
       PGestao.orgsup := ADataset.Fields.FieldByName('orgsup').AsString
      else
       PGestao.orgsup := '-';
      if not ADataset.Fields.FieldByName('nomfoc').IsNull then
       PGestao.nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString
      else
       PGestao.nomfoc := '-';
      if Parent <> nil then
       Node := TrvGestoes.Items.AddChildObject(Parent, PGestao.nomitem, PGestao)
      else
       Node := TrvGestoes.Items.AddObject(nil, PGestao.nomitem, PGestao);
       Node.ImageIndex := Ord(PGestao.tipitem);
       Node.SelectedIndex := Node.ImageIndex;
     end;
    ADataset.Next;
   end;

 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(aParams) then FreeAndNil(aParams);
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Parent <> nil then Parent.Expand(True);
  TrvGestoes.Items.EndUpdate;
 end;
end;


procedure TFmeGestoes.ActNovoOrgaoExecute(Sender: TObject);
begin
 //Cria um novo órgão gestor
 if not Assigned(FrmEditOrgao) then
  FrmEditOrgao := TFrmEditOrgao.Create(self);

 try
   case SelectedType of
    giOrgaoGestor: FrmEditOrgao.NovoOrgao(GetItemID(SelectedItem),SelectedItem.Text);
    giMembro, giUnknown: FrmEditOrgao.NovoOrgao;
    giGestao: FrmEditOrgao.NovoOrgao(GetItemID(SelectedItem.Parent),SelectedItem.Parent.Text);
   end;

 finally
  if Assigned(FrmEditOrgao) then
   FreeAndNil(FrmEditOrgao);
 end;
end;

procedure TFmeGestoes.ActEditOrgaoExecute(Sender: TObject);
begin
//Acessa a janela de edição dos dados do órgão gestor
 if not Assigned(FrmEditOrgao) then
  FrmEditOrgao := TFrmEditOrgao.Create(self);

 try
  FrmEditOrgao.EditOrgao(GetItemID(SelectedItem));

 finally
  if Assigned(FrmEditOrgao) then
   FreeAndNil(FrmEditOrgao);
 end;
end;

procedure TFmeGestoes.TrvGestoesChange(Sender: TObject; Node: TTreeNode);
begin
//Negrita o nó da árvore
 if Node <> nil then
  SetNodeBoldState(Node,True);
 SelectItem;
end;

procedure TFmeGestoes.TrvGestoesChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
 //Retira o negrito do nó
 SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFmeGestoes.ActNovoOrgaoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := AllowEdit;
end;

procedure TFmeGestoes.ActEditOrgaoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (AllowEdit) and (GetSelectedType = giOrgaoGestor);
end;

procedure TFmeGestoes.TrvGestoesDblClick(Sender: TObject);
begin
 if SelectedItem = nil then
  exit;

 case ListType of
  ltSequencial, ltEsferaAcao:
    case GetItemType(SelectedItem) of
     giOrgaoGestor: ListGestoesOrgao(SelectedItem);
     giGestao: ListDirections(selectedItem); //Lista os membros da gestão
    end;

  ltOrgaos:
    case GetItemType(SelectedItem) of
     giOrgaoGestor:
       begin
        ListOrgaos(SelectedItem);
        ListGestoesOrgao(SelectedItem);
       end;
     giGestao: ListDirections(selectedItem); //Lista os membros da gestão
    end;
 end;
end;

procedure TFmeGestoes.TrvGestoesKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  TrvGestoes.OnDblClick(self);
end;

procedure TFmeGestoes.TrvGestoesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (ssAlt in Shift) and (Button = mbLeft) and (TrvGestoes.Selected <> nil)
  and (ListType = ltOrgaos) then
  TrvGestoes.BeginDrag(True);
end;

procedure TFmeGestoes.TrvGestoesDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
Target: TTreeNode;
TargetType: TGestaoItem;
LogicalAccept: Boolean;
begin
 Accept := (Sender is TTreeView) and (AllowEdit = True) and (SelectedItem <> nil)
    and (ListType <> ltSequencial) and (SelectedType <> giGestao);

 Target := TrvGestoes.GetNodeAt(x, y); //Destinatário
 TargetType := GetItemType(Target);
 LogicalAccept := (Target <> SelectedItem) and (SelectedItem.Parent <> Target);

 case SelectedType of
  giGestao: Accept := False ;
  giOrgaoGestor: Accept := (TargetType in ([giOrgaoGestor])) and LogicalAccept;
  giMembro: Accept := (TargetType in ([giGestao])) and LogicalAccept;
  giUnknown: Accept := False;
 end;
end;

procedure TFmeGestoes.TrvGestoesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
TargetNode, NewNode: TTreeNode;
TargetType: TGestaoItem;
SourceID, TargetID: integer;
SourceText, TargetText: string;
ICosmosApp: ICosmosApplication;
begin
 SourceID := GetItemID(SelectedItem);
 SourceText := SelectedItem.Text;

 TargetNode := TrvGestoes.GetNodeAt(x, y);
 TargetType := GetItemType(TargetNode);
 if TargetNode <> nil then
  begin
   TargetID := GetItemID(TargetNode);
   TargetText := TargetNode.Text;
  end;

 case TargetType of
  giOrgaoGestor:
    begin
     case SelectedType of
      giOrgaoGestor: //alterando a hierarquia entre órgãos gestores
       begin
        ICosmosApp := Application.MainForm as ICosmosApplication;

        try
         if (1 = 1) then // ICosmosApp.DlgMessage.ConfirmationMessage(sTitleOrgaosGestores, Format(sConfSubordinacaoOrgao, [SourceText, TargetText])) = mrYes then
           //if IRemoteCon.ConnectionBroker.AppServer.AlterarSubordinacao(SourceID, TargetID) then
             SelectedItem.MoveTo(TargetNode,naAddChild);

        finally
          if Assigned(ICosmosApp) then
           ICosmosApp := nil;
        end;
       end;
     end;
    end;
  giGestao:
   if SelectedType = giMembro then
    begin
     try
      if not Assigned(FrmDlgConfCopy) then
       FrmDlgConfCopy := TFrmDlgConfCopy.Create(self);
      if FrmDlgConfCopy.ShowModal = mrOk then
       begin
        if FrmDlgConfCopy.RdbCopy.Checked then
         begin
          if  (1 = 1) then  //IRemoteCon.ConnectionBroker.AppServer.CloneDirigente(GetItemID(SelectedItem),GetItemID(TargetNode)) then
           begin
            NewNode := TrvGestoes.Items.AddChildObject(TargetNode, SelectedItem.Text, SelectedItem.Data);
            NewNode.ImageIndex := SelectedItem.ImageIndex;
            NewNode.SelectedIndex := NewNode.ImageIndex;
            NewNode.OverlayIndex := NewNode.ImageIndex;
           end;
         end
        else
         if (1 = 1) then // IRemoteCon.ConnectionBroker.AppServer.MoveDirigente(GetItemID(SelectedItem),GetItemID(TargetNode)) then
          SelectedItem.MoveTo(TargetNode, naAddChild);
       end;

     finally
      if Assigned(FrmDlgConfCopy) then
       FreeAndNil(FrmDlgConfCopy);
     end;
    end;
  giMembro: exit;
 end;

end;

procedure TFmeGestoes.ListOrgaosByEsfera;
//Lista os órgão gestores ordenado por sua esfera de ação
var
PGestao: PGestoes;
ADataset: TClientDataset;
TypeNode, Node: TTreeNode;
s: string;
TipoItem: TGestaoItem;
ICosmosApp: ICosmosApplication;
begin

 ADataset := TClientDataset.Create(self); //Cria o dataset em memória
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  //Chama o método remoto do servidor
  // .ConnectionBroker.AppServer.ListOrgaosByEsfera(False, False);
  ICosmosApp.IRemoteCon.ExecuteDQL(csOrgaosByName, null, ADataset);
  TrvGestoes.Items.BeginUpdate;//Método chamado para impedir draw desnecessário
  TrvGestoes.Items.Clear;

  while not ADataset.Eof do
   begin
    case ADataset.Fields.FieldByName('nivorg').AsInteger of
     1: s := TCosmosGUIElements.EsferaInternacional;
     2: s := TCosmosGUIElements.EsferaNacional;
     3: s := TCosmosGUIElements.EsferaRegional;
     4: s := TCosmosGUIElements.EsferaLocal;
    end;

    TypeNode := FindNode(s, nil);

    if TypeNode = nil then
     begin
      New(PGestao);//Cria um novo ponteiro do record TFocos
      PGestao.coditem := Ord(giEsfera);
      PGestao.nomitem := s;
      PGestao.tipitem := giEsfera;
      TypeNode := TrvGestoes.Items.AddObject(nil, PGestao.nomitem, PGestao);
      TypeNode.ImageIndex := Ord(PGestao.tipitem);
      TypeNode.SelectedIndex := TypeNode.ImageIndex;
     end;

    New(PGestao);
    PGestao.coditem := ADataset.Fields.FieldByName('codorg').AsInteger;
    PGestao.nomitem := ADataset.Fields.FieldByName('nomorg').AsString;
    PGestao.tipitem := giOrgaoGestor;
    PGestao.sigitem := ADataset.Fields.FieldByName('sigorg').AsString;
    Node := TrvGestoes.Items.AddChildObject(TypeNode,PGestao.nomitem,PGestao);
    Node.ImageIndex := Ord(PGestao.tipitem);
    Node.SelectedIndex := Node.ImageIndex;
    ADataset.Next;
   end;

 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  TrvGestoes.FullExpand;
  TrvGestoes.Items.EndUpdate;
 end;
end;

procedure TFmeGestoes.ListOrgaosByName;
//Lista os órgão gestores ordenado alfabeticamente pelo seu nome
var
PGestao: PGestoes;
ADataset: TClientDataset;
Node: TTreeNode;
ICosmosApp: ICosmosApplication;
begin
 if not Assigned(ADataset) then  //Cria o dataset em memória
  ADataset := TClientDataset.Create(self);

 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if not Assigned(ADataset) then  //Cria o dataset em memória
   ADataset := TClientDataset.Create(self);
  TrvGestoes.Items.BeginUpdate;//Método chamado para impedir draw desnecessário
  //Chama o método remoto do servidor
  ICosmosApp.IRemoteCon.ExecuteDQL(csOrgaosByName, null, ADataset);
  TrvGestoes.Items.Clear;

  while not ADataset.Eof do
   begin
    New(PGestao);//Cria um novo ponteiro do record TFocos
    PGestao.coditem := ADataset.Fields.FieldByName('codorg').AsInteger;
    PGestao.nomitem := ADataset.Fields.FieldByName('nomorg').AsString;
    PGestao.noming := ADataset.Fields.FieldByName('nomorging').AsString;
    PGestao.tipitem := giOrgaoGestor;
    PGestao.sigitem := ADataset.Fields.FieldByName('sigorg').AsString;
    Node := TrvGestoes.Items.AddObject(nil, PGestao.nomitem, PGestao);
    Node.ImageIndex := Ord(PGestao.tipitem);
    Node.SelectedIndex := Node.ImageIndex;
    ADataset.Next;
   end;

 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  TrvGestoes.Items.EndUpdate;
 end;
end;

procedure TFmeGestoes.PopupActionBarEx1Popup(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;

 finally
  if ICosmosApp <> nil then
   ICosmosApp := nil;
 end;
end;

function TFmeGestoes.FindNode(const Text: string; Root: TTreeNode): TTreeNode;
var
I: integer;
Node: TTreeNode;
begin
//Encontra um nó pelo seu texto
 Result := nil;
 if Root <> nil then
  begin
   for I := 0 to Pred(Root.Count) do
    begin
     Node := Root.Item[i];
     if Node <> nil then
      if Node.Text = Text then
       begin
        Result := Node;
        Break;
       end;
    end;
  end
 else
 for I := 0 to Pred(TrvGestoes.Items.Count) do
  begin
   Node := TrvGestoes.Items.Item[I];
   if Node <> nil then
    if Node.Text = Text then
     Result := Node;
   if Result <> nil then
    Break;
  end;
end;

procedure TFmeGestoes.ActOrgaosStyleExecute(Sender: TObject);
begin
  case TAction(Sender).Tag of
   0: ListType := ltOrgaos;
   1: ListType := ltEsferaAcao;
   2: ListType := ltSequencial;
  end;
end;

procedure TFmeGestoes.ActOrgaosStyleUpdate(Sender: TObject);
begin
 case TAction(Sender).Tag of
  0: TAction(Sender).Checked := FListType = ltOrgaos;
  1: TAction(Sender).Checked := FListType = ltEsferaAcao;
  2: TAction(Sender).Checked := FListType = ltSequencial;
 end;
end;

procedure TFmeGestoes.ActDelOrgaoExecute(Sender: TObject);
 var
  ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.OrgaosGestores, TCosmosConfMsg.DelOrgaoGestor) = mrYes then
   if (1 = 1) then // IRemoteCon.ConnectionBroker.AppServer.DeleteOrgao(GetItemID(SelectedITem)) then
    SelectedItem.Delete;

 finally
  if Assigned(ICosmosApp) then
    ICosmosApp := nil;
 end;
end;

procedure TFmeGestoes.ActNovaGestaoExecute(Sender: TObject);
begin
 FrmEditGestoes := TFrmEditGestoes.Create(self);

 try
  case GetItemType(SelectedItem) of
   giOrgaoGestor: FrmEditGestoes.NovaGestao(GetItemID(SelectedItem), SelectedItem.Text);
   giGestao: FrmEditGestoes.NovaGestao(GetItemID(SelectedItem.Parent), SelectedItem.Parent.Text);
  end;

 finally
  if Assigned(FrmEditGestoes) then
   FreeAndNil(FrmEditGestoes);
 end;
end;

procedure TFmeGestoes.ActNovaGestaoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (AllowEdit) and (GetSelectedType in ([giOrgaoGestor, giGestao]));
end;

procedure TFmeGestoes.ListGestoesOrgao(const Parent: TTreeNode);
var
PGestao: PGestoes;
ADataset: TClientDataset;
ICosmosApp: ICosmosApplication;
Node: TTreeNode;
Value, I: integer;
A: array of integer;
begin
//Lista as gestões de um determinado órgão gestor
 ADataset := TClientDataset.Create(self);
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  TrvGestoes.Items.BeginUpdate;//Método chamado para impedir draw desnecessário

  //Chama o método remoto do servidor
 // ADataset.Data := ICosmosApp.IRemoteCon.ConnectionBroker.AppServer.ListGestoesOrgao(GetItemID(Parent));

  if Parent.HasChildren then
   for I := 0 to Pred(Parent.Count) do
    begin
     Node := Parent.Item[I];
     PGestao := Node.Data;
     Value := PGestao.coditem;
     Inc(Value,A[I]);
    end;

  Node := nil;

  while not ADataset.Eof do
   begin
    if FindNode(ADataset.Fields.FieldByName('periodo').AsString, Parent) = nil then
     begin
      New(PGestao);//Cria um novo ponteiro do record TFocos
      PGestao.coditem := ADataset.Fields.FieldByName('codges').AsInteger;
      PGestao.nomitem := ADataset.Fields.FieldByName('periodo').AsString; //período
      PGestao.tipitem := giGestao;
      if not ADataset.Fields.FieldByName('nomfoc').IsNull then
       PGestao.nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString
      else
       PGestao.nomfoc := '-';
      if Parent <> nil then
        Node := TrvGestoes.Items.AddChildObject(Parent, PGestao.nomitem, PGestao);
      Node.ImageIndex := Ord(PGestao.tipitem);
      Node.SelectedIndex := Node.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  if Assigned(ADataset) then
   FreeAndNil(ADataset);
  if Parent <> nil then
   Parent.Expand(True);
  TrvGestoes.Items.EndUpdate;
 end;
end;

procedure TFmeGestoes.ActEditGestaoExecute(Sender: TObject);
begin
 if not Assigned(FrmEditGestoes) then
  FrmEditGestoes := TFrmEditGestoes.Create(self);

 try
   FrmEditGestoes.EditGestao(GetItemID(SelectedItem));

 finally
  if Assigned(FrmEditGestoes) then
   FreeAndNil(FrmEditGestoes);
 end;
end;

procedure TFmeGestoes.ActEditGestaoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (AllowEdit) and (GetSelectedType = giGestao);
end;

procedure TFmeGestoes.ActDelGestaoExecute(Sender: TObject);
 var
  ICosmosApp: ICosmosApplication;
begin
 //Tenta excluir uma gestão. Só pode ser excluída caso não existam mebros
 //a ela ligados

 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if  ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.OrgaosGestores, TCosmosConfMsg.DelGestao) = mrYes then
   begin
    if (1 = 1) then // IRemoteCon.ConnectionBroker.AppServer.DeleteGestao(GetItemID(SelectedItem)) then
     SelectedItem.Delete;
   end;

 finally
  if Assigned(ICosmosApp) then
    ICosmosApp := nil;
 end;
end;

procedure TFmeGestoes.ActDelGestaoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (AllowEdit) and (GetSelectedType = giGestao)
  and not (SelectedItem.HasChildren);
end;

procedure TFmeGestoes.ListDirections(const Parent: TTreeNode);
var
PGestao: PGestoes;
ADataset: TClientDataset;
ICosmosApp: ICosmosApplication;
Node: TTreeNode;
AYear, AMonth, ADay: Word;
begin
//Lista os membros de um órgão gestor
 ICosmosApp := Application.MainForm as ICosmosApplication;
 ADataset := TClientDataset.Create(self);

 try
  TrvGestoes.Items.BeginUpdate;//Método chamado para impedir draw desnecessário

  //Chama o método remoto do servidor
  //ADataset.Data := ICosmosApp.IRemoteCon.ConnectionBroker.AppServer.ListMembrosGestao(GetItemID(Parent));
  Parent.DeleteChildren;

  while not ADataset.Eof do
   begin
    New(PGestao);//Cria um novo ponteiro do record TFocos
    PGestao.coditem := ADataset.Fields.FieldByName('coddir').AsInteger;
    PGestao.codcad := ADataset.Fields.FieldByName('codcad').AsInteger; //período
    PGestao.nomitem := ADataset.Fields.FieldByName('nomcad').AsString; //período
    PGestao.tipitem := giMembro;
    PGestao.descar := ADataset.Fields.FieldByName('descar').AsString;
    PGestao.sigdis := ADataset.Fields.FieldByName('sigdis').AsString;
    PGestao.nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString;
    PGestao.matcad := ADataset.Fields.FieldByName('matcad').AsString;
    PGestao.datini := ADataset.Fields.FieldByName('datini').AsDateTime;
    if not ADataset.Fields.FieldByName('datter').IsNull then
     PGestao.datter := ADataset.Fields.FieldByName('datter').AsDateTime
    else
     begin
      AYear := 1111;
      AMonth := 11;
      ADay := 11;
      PGestao.datter := EncodeDate(AYear, AMonth, ADay);
     end;

    Node := TrvGestoes.Items.AddChildObject(Parent, PGestao.nomitem, PGestao);
    Node.ImageIndex := Ord(PGestao.tipitem);
    Node.SelectedIndex := Node.ImageIndex;
    ADataset.Next;
   end;

 finally
  if Assigned(ADataset) then
   FreeAndNil(ADataset);
  if Parent <> nil then
   Parent.Expand(True);
  TrvGestoes.Items.EndUpdate;
 end;
end;

procedure TFmeGestoes.ActEditDirigenteExecute(Sender: TObject);
begin
 if not Assigned(FrmEditDirecoes) then
  FrmEditDirecoes := TFrmEditDirecoes.Create(self);

 try
  FrmEditDirecoes.EditDirigente(GetItemID(SelectedItem.Parent), GetItemID(SelectedItem));

 finally
  if Assigned(FrmEditDirecoes) then
   FreeAndNil(FrmEditDirecoes);
 end;
end;

procedure TFmeGestoes.ActEditDirigenteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (AllowEdit) and (GetSelectedType = giMembro);
end;

procedure TFmeGestoes.ActNewDirigenteExecute(Sender: TObject);
begin
//Insere um novo dirigente para a gestão selecionada
 if not Assigned(FrmEditDirecoes) then
  FrmEditDirecoes := TFrmEditDirecoes.Create(self);

 try
  case GetItemType(SelectedItem) of
   giGestao: FrmEditDirecoes.NovoDirigente(GetItemID(SelectedItem));
   giMembro: FrmEditDirecoes.NovoDirigente(GetItemID(SelectedItem.Parent));
  end;

 finally
  if Assigned(FrmEditDirecoes) then
   FreeAndNil(FrmEditDirecoes);
 end;
end;

procedure TFmeGestoes.ActDelDirigenteExecute(Sender: TObject);
 var
  ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if (1 = 1) then  //ICosmosApp.DlgMessage.ConfirmationMessage(sTitleDirigentes, sConfDelDirigente) = mrYes then
   if (1 = 1) then  //IRemoteCon.ConnectionBroker.AppServer.DeleteDirigente(GetItemID(SelectedItem)) then
    SelectedItem.Delete;

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

procedure TFmeGestoes.ActNewDirigenteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (AllowEdit) and (GetSelectedType in ([giGestao,giMembro]));
end;

procedure TFmeGestoes.ActEndMandateExecute(Sender: TObject);
 var
  ICosmosApp: ICosmosApplication;
begin
//Encerra o mandato de um dirigente de um órgão gestor
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Dirigentes, Format(TCosmosConfMsg.EndMandate, [SelectedItem.Text,
     SelectedItem.Parent.Parent.Text])) = mrYes then
   //IRemoteCon.ConnectionBroker.AppServer.TerminateMandate(GetItemID(SelectedItem));

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

procedure TFmeGestoes.ActEndMandatesExecute(Sender: TObject);
 var
  ICosmosApp: ICosmosApplication;
begin
//Encerra os mandatos de todos os membros de uma gestão e encerra a gestão
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  //if ICosmosApp.DlgMessage.ConfirmationMessage(sTitleDirigentes,sConfEndMandates) = mrYes then
   //IRemoteCon.ConnectionBroker.AppServer.TerminateMandates(GetItemID(SelectedItem));

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

function TFmeGestoes.CloneDirigente(const coddir, codges: integer): boolean;
begin
//Copia um dirigente de uma gestão de um órgão gestor para outra gestão
 Result := True;
end;

procedure TFmeGestoes.CreateFramesObjects;
begin
{Instancia as variáveis de ponteiro de interfaces usadas no frame. Este método
 deve ser chamado pela aplicação hospedeira, no início da utilização do frame.}
 //FICosmosApp := Application.MainForm as ICosmosApplication;
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection; 

end;

procedure TFmeGestoes.ActCopyDirigenteExecute(Sender: TObject);
begin
 CopiedNode := SelectedItem;
end;

procedure TFmeGestoes.ActPasteDirigenteExecute(Sender: TObject);
var
PGest: PGestoes;
coddir, codges: integer;
Node: TTreeNode;
ICosmosApp: ICosmosApplication;
begin
//Cola os dados do dirigente
 Node := FindNode(CopiedNode.Text, SelectedItem);
 if Node <> nil then
  begin
   ICosmosApp := Application.MainForm as ICosmosApplication;
   ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.OrgaosGestores, Format(TCosmosErrorSecMsg.DirigenteExists, [CopiedNode.Text]));
   ICosmosApp := nil;

   Exit;
  end;
  
 PGest := CopiedNode.Data;
 coddir :=  PGest.coditem;
 PGest := SelectedItem.Data;
 codges := PGest.coditem;
 
 if (1 = 1) then  // IRemoteCon.ConnectionBroker.AppServer.CloneDirigente(coddir, codges) then
   TrvGestoes.OnDblClick(Self);
end;

procedure TFmeGestoes.ActPasteDirigenteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (AllowEdit) and (GetSelectedType = giGestao)
 and (CopiedNode <> nil);
end;


procedure TFmeGestoes.ActDuplicarGestaoExecute(Sender: TObject);
var
codorg: integer;
Node: TTreeNode;
begin
 Node := self.TrvGestoes.Selected.Parent;

 if Node <> nil then
  begin
   codorg := self.GetItemID(Node);
   try
    if not Assigned(FrmDlgCopyGestao) then
     FrmDlgCopyGestao := TFrmDlgCopyGestao.Create(self);
    FrmDlgCopyGestao.CopyGestao(GetItemID(SelectedItem), codorg, Node.Text);

   finally
    if Assigned(FrmDlgCopyGestao) then
     FreeAndNil(FrmDlgCopyGestao)
   end;
  end;
end;

procedure TFmeGestoes.ActFichaAlunoExecute(Sender: TObject);
var
  PackageModule: HModule;
  AClass: TPersistentClass;
  AForm: TForm;
  IFicha: ICosmosFicha;
  codcad: integer;
  CoreData: Olevariant;
  Pgestao: PGestoes;
begin
  PackageModule := LoadPackage('ficha.bpl');
  if PackageModule <> 0 then
  begin
    AClass := GetClass('TFrmFicha');
    if AClass <> nil then
     AForm := TComponentClass(AClass).Create(Application) as TForm;
     with AForm do
      begin
       if Supports(AForm, ICosmosFicha) then
        IFicha := AForm as ICosmosFicha;
       PGestao := SelectedItem.Data;
       codcad :=  PGestao.codcad;
       //IRemoteCon.ConnectionBroker.AppServer.FichaCadastrado(codcad, CoreData, null, null);
       if Assigned(IFicha) then
        IFicha.ShowFicha(CoreData);
        Free;
      end;


   if Assigned(IFicha) then
    IFicha := nil;
    UnloadPackage(PackageModule);
  end;
end;

procedure TFmeGestoes.ActFichaAlunoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := GetSelectedType = giMembro;
end;



end.
