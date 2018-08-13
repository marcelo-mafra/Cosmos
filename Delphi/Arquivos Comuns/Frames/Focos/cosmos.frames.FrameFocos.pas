unit cosmos.frames.FrameFocos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, Menus, ActnPopup, ActnList, DB, DBClient,
  cosmos.classes.application, CommCtrl, Cosmos.Framework.Interfaces.Root, ActnMan,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.Framework.Interfaces.DataAcess,
  PlatformDefaultStyleActnCtrls, cosmos.classes.ServerInterface, cosmos.business.focos,
  Vcl.ToolWin, System.Actions, cosmos.system.messages, cosmos.system.types,
  Cosmos.Framework.Interfaces.Applications, Data.DBXCommon, Cosmos.Classes.Security,
  cosmos.system.dataconverter, System.ImageList;


type
  TNavigationStyle = (nsNormal, nsWeb);

  PFocos = ^TFocos;
  TFocos = record
   codfoc: integer;
   nomfoc: string;
   tipfoc: TTipoFoco;
   sigfoc: string;
   indati: boolean;
  end;

  TFmeFocos = class(TFrame)
    TreeFocos: TTreeView;
    ImgTree: TImageList;
    ActionFrame: TActionList;
    ActRenameRa: TAction;
    ActNewRA: TAction;
    ActDesactiveFocus: TAction;
    ActListInactives: TAction;
    ActSequencialStyle: TAction;
    ActRAsStyle: TAction;
    ActTitularStyle: TAction;
    ActFocoTypeStyle: TAction;
    ActCanEdit: TAction;
    ActActiveFocus: TAction;
    ActNewFocus: TAction;
    ActEditFocus: TAction;
    ActDelFocus: TAction;
    ActDelRA: TAction;
    ActWebNavigationStyle: TAction;
    ActNormalStyle: TAction;
    ActAutoExpand: TAction;
    ActFindNode: TAction;
    ActNewSubRA: TAction;
    ActEnderecosFoco: TAction;
    ActMeiosContato: TAction;
    PopupActionBarEx1: TPopupActionBar;
    RAs1: TMenuItem;
    ExcluirRA1: TMenuItem;
    AtivarFoco1: TMenuItem;
    AutoExpanso1: TMenuItem;
    PermitirEdio1: TMenuItem;
    ExcluirFoco1: TMenuItem;
    Desativarfoco1: TMenuItem;
    EditarFoco1: TMenuItem;
    Endereos1: TMenuItem;
    Localizar1: TMenuItem;
    ipodeFoco1: TMenuItem;
    ListarInativos1: TMenuItem;
    MeiosdeContato1: TMenuItem;
    NovoFoco1: TMenuItem;
    NovaRA1: TMenuItem;
    NovaSubregio1: TMenuItem;
    EstiloNormal1: TMenuItem;
    RegiesAdministrativas1: TMenuItem;
    FocosTitulares1: TMenuItem;
    EstiloWeb1: TMenuItem;
    RenomearRa1: TMenuItem;
    N1: TMenuItem;
    Focos1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Seqencial1: TMenuItem;
    ActMentors: TAction;
    Mentores1: TMenuItem;
    N7: TMenuItem;
    ImageList1: TImageList;
    N8: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ActListFocosRA: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ListarFocos1: TMenuItem;
    procedure ActDelFocusExecute(Sender: TObject);
    procedure ActMentorsExecute(Sender: TObject);
    procedure ActNewFocusUpdate(Sender: TObject);
    procedure ActEnderecosFocoExecute(Sender: TObject);
    procedure ActEditFocusExecute(Sender: TObject);
    procedure ActMeiosContatoExecute(Sender: TObject);
    procedure ActNewFocusExecute(Sender: TObject);
    procedure ActEnderecosFocoUpdate(Sender: TObject);
    procedure ActActiveFocusUpdate(Sender: TObject);
    procedure ActActiveFocusExecute(Sender: TObject);
    procedure ActCanEditUpdate(Sender: TObject);
    procedure ActListInactivesUpdate(Sender: TObject);
    procedure ActDelRAUpdate(Sender: TObject);
    procedure TreeFocosKeyPress(Sender: TObject; var Key: Char);
    procedure ActDelRAExecute(Sender: TObject);
    procedure ActNewSubRAExecute(Sender: TObject);
    procedure ActFindNodeExecute(Sender: TObject);
    procedure ActAutoExpandExecute(Sender: TObject);
    procedure ActWebNavigationStyleExecute(Sender: TObject);
    procedure TreeFocosDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeFocosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeFocosDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ActCanEditExecute(Sender: TObject);
    procedure ActRAsStyleUpdate(Sender: TObject);
    procedure ActRAsStyleExecute(Sender: TObject);
    procedure ActListInactivesExecute(Sender: TObject);
    procedure ActDesactiveFocusUpdate(Sender: TObject);
    procedure ActDesactiveFocusExecute(Sender: TObject);
    procedure ActNewRAUpdate(Sender: TObject);
    procedure ActNewRAExecute(Sender: TObject);
    procedure TreeFocosChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeFocosChange(Sender: TObject; Node: TTreeNode);
    procedure ActRenameRaUpdate(Sender: TObject);
    procedure ActRenameRaExecute(Sender: TObject);
    procedure TreeFocosDblClick(Sender: TObject);
    procedure PopupActionBarEx1Popup(Sender: TObject);
    procedure ActSequencialStyleExecute(Sender: TObject);
    procedure ActTitularStyleExecute(Sender: TObject);
    procedure ActFocoTypeStyleExecute(Sender: TObject);
    procedure ActSequencialStyleUpdate(Sender: TObject);
    procedure ActTitularStyleUpdate(Sender: TObject);
    procedure ActFocoTypeStyleUpdate(Sender: TObject);
    procedure ActListFocosRAExecute(Sender: TObject);
    procedure ActListFocosRAUpdate(Sender: TObject);
    procedure ActNewSubRAUpdate(Sender: TObject);
    procedure ActMentorsUpdate(Sender: TObject);
    procedure ActEditFocusUpdate(Sender: TObject);
    procedure ActDelFocusUpdate(Sender: TObject);
    procedure ActFindNodeUpdate(Sender: TObject);
    procedure ActMeiosContatoUpdate(Sender: TObject);
  private
    { Private declarations }
    FAllowEdit: boolean ;
    FAutoExpand: boolean;
    FEnabledTypes: TTipoFocoSet;
    FListFocosRa: boolean;
    FListInactives: boolean;
    FListType: TTipoListagem;
    FNavigationStyle: TNavigationStyle;
    FShowMenu: boolean;
    FOnSelectFocus: TNotifyEvent;

    function GetIFocos: ICosmosFocos;
    function GetSelectedNode: TTreeNode;
    function GetSelectedElement: TCustomFocus;
    function GetSelectedType: TTipoFoco;
    function GetFocusType(const Node: TTreeNode): TTipoFoco;
    procedure SetListType(const Value: TTipoListagem);
    procedure SetNavigationStyle(const Value: TNavigationStyle);
    procedure SetAutoExpand(Value: boolean);
    procedure SetShowMenu(value: boolean);

    function GetFocusID(const Node: TTreeNode): integer;
    function FindNode(const Text: string): TTreeNode;

    procedure NovaRegiaoAdministrativa(const code: integer; ARName: string; Parent: TTreeNode = nil);
    procedure DeleteFocus(FocusID: integer; FocusName: string);
    procedure ExpandNode(Node: TTreeNode); inline;
    procedure ChangeFocusStatus(const Focus: TTreeNode; value: boolean);

    //Métodos de listagem dos dados dos focos.
    procedure ListFocusByTitular(Root: TTreeNode; ADataset: TDataset);
    procedure ListFocusSequencial(ADataset: TDataset);
    procedure ListFocusByType(ADataset: TDataset);
    procedure ListRegions(const Root: TTreeNode; ADataset: TDataset);
    procedure ListFocusRegion(Root: TTreeNode; ADataset: TDataset);

  protected
    procedure SelectFocus; virtual;

  public
    { Public declarations }
   procedure ListFocus;

   function GetParenFocusType(const Focus: TTreeNode): TTipoFoco;
   function GetFocusStatus(const Focus: TTreeNode): boolean;
   function GetSelectedFocusData: PFocos;
   function GetFocusData(const Focus: TTreeNode): PFocos;


  published
   property AllowEdit: boolean read FAllowEdit write FAllowEdit default True;
   property AutoExpand: boolean read FAutoExpand write SetAutoExpand default False;

   property EnabledTypes: TTipoFocoSet read FEnabledTypes write FEnabledTypes
      default [tfRa, tfSedeInternacional, tfSedeNacional, tfCentro, tfNucleoCentro,
    tfNucleo, tfSala, tfLocal];

   property ListFocosRa: boolean read FListFocosRa write FListFocosRa default True;
   property ListInactives: boolean read FListInactives write FListInactives default False;
   property ListType: TTipoListagem read FListType write SetListType default tlNoneFocus;
   property NavigationStyle: TNavigationStyle read FNavigationStyle write SetNavigationStyle;

   property SelectedNode: TTreeNode read GetSelectedNode;
   property SelectedElement: TCustomFocus read GetSelectedElement;
   property SelectedType: TTipoFoco read GetSelectedType;

   property ShowMenu: boolean read FShowMenu write SetShowMenu default True;
   property OnSelectFocus: TNotifyEvent read FOnSelectFocus write FOnSelectFocus;


  end;

implementation

uses  cosmos.focos.view.FormEditRA, cosmos.focos.view.FormEditarFoco,
  cosmos.focos.view.FormEditMentores, cosmos.focos.view.FormDelFoco;

{$R *.dfm}

procedure SetNodeBoldState(Node: TTreeNode; Value: Boolean);
var
  TVItem: TTVItem;
begin
//Insere ou retira o negrito no texto do objeto TTreeNode passado.
 if not Assigned(Node) then Exit;

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

{ TFmeFocos }

procedure TFmeFocos.TreeFocosChange(Sender: TObject; Node: TTreeNode);
begin
//Negrita o nó da árvore
 if Node <> nil then
  SetNodeBoldState(Node,True);

 SelectFocus;
end;

procedure TFmeFocos.TreeFocosChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
 //Retira o negrito do nó
 SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFmeFocos.ListFocus;
var
ASearch: TCosmosSearch;
ADataset: TClientDataset;
AParams: TSQLParams;
ICosmosApp: ICosmosApplication;
begin
 //Lista os focos no TreeView usando um dos tipos de listagem indicados no
 //parâmetro.
 ICosmosApp := Application.MainForm as ICosmosApplication;
 ADataset := TClientDataset.Create(nil);

 case ListType of
   tlRa:
    begin
     AParams := TSQLParams.Create(1);
     if SelectedNode = nil then
      ASearch := csRegioes
     else
      begin
       AParams.AppendData(GetFocusID(SelectedNode));
       ASearch := csSubRegioes;
      end;
    end;
   tlSequencial, tlTipoLogic:
    begin
     AParams := TSQLParams.Create(1);
     AParams.AppendData(TDataConverter.ToBoleanString(True, True));
     ASearch := csFocos;
    end;
   tlTitularFocus:
    begin
     if SelectedNode = nil then
      begin
       AParams := TSQLParams.Create(2);
       AParams.AppendData(TDataConverter.ToBoleanString(True, True));
       AParams.AppendData(TDataConverter.ToBoleanString(True, True), 1);
       ASearch := csFocosTitulares;
      end
     else
      begin
       AParams := TSQLParams.Create(1);
       AParams.AppendData(GetFocusID(SelectedNode));
       ASearch := csFocosDependentes;
      end;
    end;
   tlNoneFocus: Exit;
 end;

//Executa a pesquisa no servidor remoto passando todos os argumentos de busca.
 try
  ICosmosApp.IRemoteCon.ExecuteDQL(ASearch, AParams.Params, ADataset);

  if (ADataset.Active) then
   begin
    case ListType of
     tlRa:
      begin
       ListRegions(TreeFocos.Selected, ADataset); //Lista as regiões administrativas.
       //ADataset.Close;

       {Caso a listagem de focos esteja habilitada, lista agora os focos ligados à
       RA corrente.}
       if (SelectedNode <> nil) and (ListFocosRa = True) then
        begin
         ASearch := csFocosRa;

         //ADataset.FieldDefs.Clear;
         ICosmosApp.IRemoteCon.ExecuteDQL(ASearch, AParams.Params, ADataset);

         if (ADataset.Active) then
           ListFocusRegion(SelectedNode, ADataset);
        end;
      end;
     tlSequencial: ListFocusSequencial(ADataset);
     tlTitularFocus: ListFocusByTitular(SelectedNode, ADataset);
     tlTipologic: ListFocusByType(ADataset);
     tlNoneFocus: Exit;
    end;
   end;


 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(ICosmosApp) then ICosmosApp := nil;
 end;
end;

procedure TFmeFocos.ListRegions(const Root: TTreeNode; ADataset: TDataset);
var
PFoco: PFocos;
Node: TTreeNode;
begin
 TreeFocos.Items.BeginUpdate;//Método chamado para impedir draw desnecessário

 try
  if Root = nil then
   TreeFocos.Items.Clear
  else
   Root.DeleteChildren;

  while not ADataset.Eof do
   begin
    New(PFoco);//Cria um novo ponteiro do record TFocos
    PFoco.codfoc := ADataset.Fields.FieldByName('codreg').AsInteger;
    PFoco.nomfoc := ADataset.Fields.FieldByName('nomreg').AsString;
    PFoco.tipfoc := tfRa;

    if Root = nil then
     Node := TreeFocos.Items.AddObject(Root,PFoco.nomfoc,PFoco)
    else
     Node := TreeFocos.Items.AddChildObject(Root,PFoco.nomfoc,PFoco);

    Node.ImageIndex := Ord(PFoco.tipfoc);
    ADataset.Next;
   end;

 finally
  if Root <> nil then Root.Expand(False);
  TreeFocos.Items.EndUpdate;
 end;
end;

procedure TFmeFocos.PopupActionBarEx1Popup(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if Assigned(ICosmosApp) then
   TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
 end;
end;

function TFmeFocos.GetFocusData(const Focus: TTreeNode): PFocos;
var
PFoco: PFocos;
begin
//Retorna os dados de um nó.
 if Focus = nil then
  Result := nil
 else
  begin
   PFoco := Focus.Data;
   Result := PFoco;
  end;
end;

function TFmeFocos.GetFocusID(const Node: TTreeNode): integer;
var
PFoco: PFocos;
begin
//Retorna o ID de um nó.
 if Node <> nil then
  begin
   PFoco := Node.Data;
   Result := PFoco.codfoc;
  end
 else
  raise Exception.Create(TCosmosErrorFocMsg.CannotFindID);
end;

function TFmeFocos.GetSelectedNode: TTreeNode;
begin
 Result := TreeFocos.Selected;
end;

function TFmeFocos.GetSelectedElement: TCustomFocus;
var
 aParent: PFocos;
 aRegiaoSuperior: TRegiaoAdministrativa;
begin
 if self.SelectedNode <> nil then
  begin
   if self.SelectedType = tfRa then
    begin
     Result := TRegiaoAdministrativa.Create;
     Result.FocusID := self.GetSelectedFocusData.codfoc;
     Result.FocusName := self.SelectedNode.Text;

     if SelectedNode.Parent <> nil then
      begin
        aParent := GetFocusData(SelectedNode.Parent);
        aRegiaoSuperior := TRegiaoAdministrativa.Create;
        aRegiaoSuperior.FocusID :=  aParent.codfoc;
        aRegiaoSuperior.FocusName :=  aParent.nomfoc;
        TRegiaoAdministrativa(Result).Parent := aRegiaoSuperior;
      end;
    end
   else
    begin
     Result := TFocus.Create;
     Result.FocusID := self.GetSelectedFocusData.codfoc;
     TFocus(Result).FocusName := self.GetSelectedFocusData.nomfoc;
     TFocus(Result).FocusType := self.SelectedType;
     TFocus(Result).Sigla := self.GetSelectedFocusData.sigfoc;
     TFocus(Result).Ativo := self.GetSelectedFocusData.indati;
    end;
  end;
end;

function TFmeFocos.GetSelectedFocusData: PFocos;
var
PFoco: PFocos;
begin
//Retorna o tipo de um nó.
 if self.SelectedNode = nil then
  Result := nil
 else
  begin
   PFoco := self.SelectedNode.Data;
   Result := PFoco;
  end;
end;

function TFmeFocos.GetFocusType(const Node: TTreeNode): TTipoFoco;
var
PFoco: PFocos;
begin
//Retorna o tipo de um nó.
 if Node = nil then
  Result := tfUnknown
 else
  begin
   PFoco := Node.Data;
   Result := PFoco.tipfoc;
  end;
end;

function TFmeFocos.GetIFocos: ICosmosFocos;
begin
 Result := Application.MainForm as ICosmosFocos;
end;

procedure TFmeFocos.TreeFocosDblClick(Sender: TObject);
begin
 if ListType in([tlSequencial, tlTipologic]) then
  Exit;

  case SelectedType of
   tfRa: SetListType(tlRa); //Item selecionado é uma Região Administrativa
   tfSedeNacional, tfSedeInternacional, tfCentro, tfNucleo,
   tfSala, tfNucleoCentro, tfLocal: SetListType(tlTitularFocus);
   tfUnknown: exit;
  end;
end;

procedure TFmeFocos.ActRenameRaExecute(Sender: TObject);
var
NewName: string;
PFoco: PFocos;
RegionId: integer;
IFocos: ICosmosFocos;
begin
//Renomeia a RA
 FrmDlgEditRA := TFrmDlgEditRA.Create(self);
 IFocos := GetIFocos;

 try
  NewName := FrmDlgEditRA.InputRA(SelectedNode.Text, TCosmosTitles.RenameRA);
  if (NewName.Trim <> '') and (NewName <> SelectedNode.Text) then
   begin
    RegionId := GetFocusId(SelectedNode);
    if IFocos.RenameRa(RegionId, NewName) then
     begin
      PFoco := SelectedNode.Data;
      PFoco.nomfoc := NewName;
      SelectedNode.Text := PFoco.nomfoc;
     end;
   end;

 finally
  if Assigned(FrmDlgEditRA) then FreeAndNil(FrmDlgEditRA);
  if Assigned(IFocos) then IFocos := nil;
 end;
end;

procedure TFmeFocos.ActRenameRaUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True) and (SelectedType = tfRa)
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfRenameRA in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActSequencialStyleExecute(Sender: TObject);
begin
 ListType := tlSequencial;
end;

procedure TFmeFocos.ActSequencialStyleUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := ListType = tlSequencial;
end;

procedure TFmeFocos.ActTitularStyleExecute(Sender: TObject);
begin
 ListType := tlTitularFocus;
end;

procedure TFmeFocos.ActTitularStyleUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := ListType = tlTitularFocus;
end;

function TFmeFocos.GetSelectedType: TTipoFoco;
begin
 Result := GetFocusType(SelectedNode);
end;

procedure TFmeFocos.ActNewRAExecute(Sender: TObject);
var
sRaName: string;
newcode: variant;
IFocos: ICosmosFocos;
begin
 //Insere uma nova RA.
 FrmDlgEditRA := TFrmDlgEditRA.Create(self);
 IFocos := GetIFocos;

 try
  sRaName := FrmDlgEditRA.InputRA('', TCosmosTitles.NewRA);
  if sRaName.Trim <> '' then
   begin
    NewCode := IFocos.NewRegion(sRaName, null);
    if NewCode <> null then
     NovaRegiaoAdministrativa(newcode, sRaName);
   end;

 finally
  if Assigned(FrmDlgEditRA) then FreeAndNil(FrmDlgEditRA);
  if Assigned(IFocos) then IFocos := nil;
 end;
end;

procedure TFmeFocos.ActNewRAUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True) and (ListType = tlRA)
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfNovaRA in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActDesactiveFocusExecute(Sender: TObject);
begin
//Desativa o foco selecionado
 FrmDelFocus := TFrmDelFocus.Create(self);

 try
  if FrmDelFocus.DesactiveFocus(GetFocusID(SelectedNode), SelectedNode.Text) then
   ChangeFocusStatus(SelectedNode, False);

 finally
  if Assigned(FrmDelFocus) then FreeAndNil(FrmDelFocus);
 end;
end;

procedure TFmeFocos.ActDesactiveFocusUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True)
    and not(SelectedType in ([tfRa, tfUnknown, tfTypeIndicator]))
    and (GetFocusStatus(SelectedNode) = True)
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfDesactivateFocus in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActListFocosRAExecute(Sender: TObject);
begin
 TAction(Sender).Checked := not TACtion(Sender).Checked;
 ListFocosRa := TAction(Sender).Checked;
end;

procedure TFmeFocos.ActListFocosRAUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := self.ListType = tlRa;
 TAction(Sender).Checked := (self.ListType = tlRa) and (ListFocosRA);
end;

procedure TFmeFocos.ActListInactivesExecute(Sender: TObject);
begin
 ListInactives := not ListInactives;
end;

procedure TFmeFocos.SetListType(const Value: TTipoListagem);
begin
 if FListType <> Value then
  begin
   FListType := Value;
   self.TreeFocos.Items.Clear;
  end;

  case Value of
    tlRa : ListFocus;
    tlSequencial: ListFocus;
    tlTitularFocus: ListFocus;
    tlTipologic: ListFocus;
    tlNoneFocus: exit;
  end;
end;

procedure TFmeFocos.ActRAsStyleExecute(Sender: TObject);
begin
// TAction(Sender).Checked := not TAction(Sender).Checked;
 ListType := tlRa;
end;

procedure TFmeFocos.ActRAsStyleUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := ListType = tlRa;
end;

procedure TFmeFocos.ActCanEditExecute(Sender: TObject);
begin
 AllowEdit := not AllowEdit;
end;

procedure TFmeFocos.TreeFocosDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
Node: TTreeNode;
NodeType: TTipoFoco;
LogicalAccept: Boolean;
begin
 Accept := (Sender is TTreeView) and (AllowEdit = True) and (SelectedNode <> nil)
    and (ListType <> tlSequencial) and (SelectedType <> tfUnknown);

 Node := TreeFocos.GetNodeAt(x, y); //Destinatário
 NodeType := GetFocusType(Node);
 LogicalAccept := (Node <> SelectedNode) and (SelectedNode.Parent <> Node);

 case SelectedType of
  tfRa: Accept := (NodeType in ([tfRA, tfUnknown])) and LogicalAccept ;
  tfSedeInternacional,tfSedeNacional: Accept := (NodeType in ([tfRA,tfCentro, tfNucleoCentro, tfRA])) and LogicalAccept;
  tfCentro, tfNucleoCentro: Accept := (NodeType in ([tfRA, tfCentro, tfNucleoCentro, tfRA])) and LogicalAccept;
  tfNucleo: Accept := (NodeType in ([tfRA, tfCentro, tfNucleoCentro])) and LogicalAccept;
  tfSala: Accept := (NodeType in ([tfRA, tfCentro, tfNucleoCentro, tfNucleo, tfSedeInternacional, tfSedeNacional])) and LogicalAccept;
 end;
end;

procedure TFmeFocos.TreeFocosMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (ssAlt in Shift) and (Button = mbLeft) and (TreeFocos.Selected <> nil)
  and(ListType <> tlSequencial) then
  TreeFocos.BeginDrag(True);
end;

procedure TFmeFocos.TreeFocosDragDrop(Sender, Source: TObject; X, Y: Integer);
var
TargetNode: TTreeNode;
TargetType: TTipoFoco;
SourceID, TargetID: integer;
SourceText, TargetText: string;
IFocos: ICosmosFocos;
ICosmosApp: ICosmosApplication;
begin
 SourceID := GetFocusID(SelectedNode);
 SourceText := SelectedNode.Text;

 TargetNode := TreeFocos.GetNodeAt(x, y);
 TargetType := GetFocusType(TargetNode);
 if TargetNode <> nil then
  begin
   TargetID := GetFocusID(TargetNode);
   TargetText := TargetNode.Text;
  end;

 IFocos := GetIFocos;
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try

  case TargetType of //Tipo do foco de destino.
   tfRa://Região administrativa.
      begin
       if SelectedType = tfTypeIndicator then Exit
       else
       if SelectedType = tfRa then //Ra para Ra.
        begin
          if IFocos.MoveRegion(SourceID, TargetID) then
           SelectedNode.MoveTo(TargetNode, naAddChild);
        end
       else
        begin //Foco para Ra.
          if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.FocosUpdate, Format(TCosmosConfMsg.VinculeFocusToRA, [SourceText, TargetText])) = mrYes then
           begin
            if IFocos.ChangeRegion(SourceID, TargetID) then
             SelectedNode.MoveTo(TargetNode,naAddChild);
           end;
        end;
      end;
   tfUnknown://Raíz da árvore.
      begin
       if SelectedType = tfRa then
        begin
          if IFocos.MoveRegion(SourceID, -1) then //-1 indica que não há foco superior.
           SelectedNode.MoveTo(TargetNode, naAdd);
        end
       else
       if SelectedType = tfUnknown then Exit
       else
        begin
         //ICosmosApp.IRemoteCon.ConnectionBroker.AppServer.ChangeFocusRegion(SourceID, Null);
        end;
      end
   else //Focos de qualquer tipo (sala, núcleo, centro de conferências etc).
      begin
       if SelectedType in [tfRa, tfUnknown] then Exit //Ra's não podem ser arrastado para focos.
       else
        begin
         if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.FocosUpdate, TCosmosConfMsg.ChangeTitularFocus) = mrYes then
          begin
            if IFocos.ChangeFocusParent(SourceID, TargetID) then
             SelectedNode.MoveTo(TargetNode,naAddChild);
          end;
        end;
      end;
  end;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Assigned(IFocos) then IFocos := nil;
 end;
end;

procedure TFmeFocos.ListFocusSequencial(ADataset: TDataset);
//Lista os focos de forma alfabética seqüencial e não hierárquica
var
PFoco: PFocos;
Node: TTreeNode;
begin
 TreeFocos.Items.BeginUpdate;//Método chamado para impedir draw desnecessário

 try
  TreeFocos.Items.Clear;

  while not ADataset.Eof do
   begin
    New(PFoco);//Cria um novo ponteiro do record TFocos
    PFoco.codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;
    PFoco.nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString;
    PFoco.tipfoc := TFocusTypesInfo.GetFocusType(ADataset.Fields.FieldByName('tipfoc').AsString);
    PFoco.sigfoc := ADataset.Fields.FieldByName('sigfoc').AsString;
    PFoco.indati := TDataConverter.ToBolean(ADataset.Fields.FieldByName('indati').AsString);
    Node := TreeFocos.Items.AddObject(nil,PFoco.nomfoc,PFoco);
    if PFoco.indati then
     Node.ImageIndex := Ord(PFoco.tipfoc)
    else
     Node.ImageIndex := 9;

    Node.SelectedIndex := Node.ImageIndex;
    ADataset.Next;
   end;

 finally
  TreeFocos.Items.EndUpdate;
 end;
end;

procedure TFmeFocos.ListFocusByTitular(Root: TTreeNode; ADataset: TDataset);
//Lista os focos que estão ligados ao foco indicado no parâmetro
var
PFoco: PFocos;
Node: TTreeNode;
begin
 TreeFocos.Items.BeginUpdate;//Chamado para impedir draw desnecessário.

 try
  if Root <> nil then
   Root.DeleteChildren;

  while not ADataset.Eof do
   begin
    New(PFoco);//Cria um novo ponteiro do record TFocos
    PFoco.codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;
    PFoco.nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString;
    PFoco.tipfoc := TFocusTypesInfo.GetFocusType(ADataset.Fields.FieldByName('tipfoc').AsString);
    PFoco.sigfoc := ADataset.Fields.FieldByName('sigfoc').AsString;
    Pfoco.indati := TDataConverter.ToBolean(ADataset.Fields.FieldByName('indati').AsString);

    if Root <> nil then
      Node := TreeFocos.Items.AddChildObject(Root,PFoco.nomfoc,PFoco)
    else
      Node := TreeFocos.Items.AddObject(nil,PFoco.nomfoc,PFoco);

    if PFoco.indati then
     Node.ImageIndex := Ord(PFoco.tipfoc)
    else
     Node.ImageIndex := 9;

    Node.SelectedIndex := Node.ImageIndex;
    ADataset.Next;
   end;

 finally
  if Root <> nil then Root.Expand(False);
  TreeFocos.Items.EndUpdate;
 end;
end;

procedure TFmeFocos.ListFocusByType(ADataset: TDataset);
//Lista os focos por seu tipo
var
PFoco: PFocos;
TypeNode, Node: TTreeNode;
s: string;
TipoFoco: TTipoFoco;
begin
  if not ADataset.Active then
   ADataset.Close;

 try
  TreeFocos.Items.BeginUpdate;//Método chamado para impedir draw desnecessário
  TreeFocos.Items.Clear;

  while not ADataset.Eof do
   begin
    TipoFoco := TFocusTypesInfo.GetFocusType(ADataset.Fields.FieldByName('tipfoc').AsString);
    s := TFocusTypesInfo.FocusTypeToString(TipoFoco);
    TypeNode := FindNode(s);

    if TypeNode = nil then
     begin
      New(PFoco);//Cria um novo ponteiro do record TFocos
      PFoco.codfoc := Ord(tfTypeIndicator);
      PFoco.nomfoc := s;
      PFoco.tipfoc := tfTypeIndicator;
      TypeNode := TreeFocos.Items.AddObject(nil, PFoco.nomfoc, PFoco);

      case TipoFoco of
        tfRa: TypeNode.ImageIndex := 0;
        tfSedeInternacional: TypeNode.ImageIndex := 1;
        tfSedeNacional: TypeNode.ImageIndex := 2;
        tfCentro: TypeNode.ImageIndex := 3;
        tfNucleoCentro: TypeNode.ImageIndex := 4;
        tfNucleo: TypeNode.ImageIndex := 5;
        tfSala: TypeNode.ImageIndex := 6;
        tfLocal: TypeNode.ImageIndex := 7;
        tfUnknown: TypeNode.ImageIndex := 8;
      end;

      TypeNode.SelectedIndex := TypeNode.ImageIndex;
     end;

    New(PFoco);
    PFoco.codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;
    PFoco.nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString;
    PFoco.tipfoc := TFocusTypesInfo.GetFocusType(ADataset.Fields.FieldByName('tipfoc').AsString);
    PFoco.sigfoc := ADataset.Fields.FieldByName('sigfoc').AsString;
    PFoco.indati := TDataConverter.ToBolean(ADataset.Fields.FieldByName('indati').AsString);
    Node := TreeFocos.Items.AddChildObject(TypeNode,PFoco.nomfoc,PFoco);

    if PFoco.indati then
     Node.ImageIndex := TypeNode.ImageIndex
    else
     Node.ImageIndex := 9;
    Node.SelectedIndex := Node.ImageIndex;

    ADataset.Next;
   end;

 finally
  TreeFocos.FullExpand;
  TreeFocos.Items.EndUpdate;
 end;
end;

function TFmeFocos.FindNode(const Text: string): TTreeNode;
var
I: integer;
Node: TTreeNode;
begin
//Encontra um nó pelo seu texto
 Result := nil;

 for I := 0 to Pred(TreeFocos.Items.Count) do
  begin
   Node := TreeFocos.Items.Item[I];
   if Node <> nil then
    if Node.Text = Text then
     Result := Node;
   if Result <> nil then
    Break;
  end;
end;

procedure TFmeFocos.SetNavigationStyle(const Value: TNavigationStyle);
begin
 if Value = FNavigationStyle then
  FNavigationStyle := Value;
 TreeFocos.HotTrack := Value = nsWeb;
end;

procedure TFmeFocos.SetShowMenu(value: boolean);
begin
 FShowMenu := Value;

 if FShowMenu = True then
  self.TreeFocos.PopupMenu := self.PopupActionBarEx1
 else
  self.TreeFocos.PopupMenu := nil;
end;

procedure TFmeFocos.ActWebNavigationStyleExecute(Sender: TObject);
begin
  case TAction(Sender).Tag of
   0: NavigationStyle := nsNormal;
   1: NavigationStyle := nsWeb;
  end;
end;

procedure TFmeFocos.SetAutoExpand(Value: boolean);
begin
 FAutoExpand := Value;
 TreeFocos.AutoExpand := FAutoExpand;
end;

procedure TFmeFocos.ActAutoExpandExecute(Sender: TObject);
begin
  AutoExpand := TAction(Sender).Checked;
end;

procedure TFmeFocos.ActFindNodeExecute(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  ICosmosApp.IRemoteCon.DefaultLocate;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
 end;
end;

procedure TFmeFocos.ActFindNodeUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (ICosmosApp.IRemoteCon.Connected);
end;

procedure TFmeFocos.NovaRegiaoAdministrativa(const code: integer; ARName: string; Parent: TTreeNode = nil);
var
PFoco: PFocos;
begin
//adiciona uma nova região administrativa na árvore.
 New(PFoco);
 Pfoco^.codfoc := code;
 PFoco^.nomfoc := ARName;
 PFoco^.tipfoc := tfRA;
 if Parent = nil then  //Região
  TreeFocos.Items.AddObject(nil,ARName, PFoco)
 else //Subregião
  TreeFocos.Items.AddChildObject(Parent,ARName, PFoco);
 ExpandNode(SelectedNode);
end;

procedure TFmeFocos.ActNewSubRAExecute(Sender: TObject);
var
sNewRegion: string;
NewCode: variant;
IFocos: ICosmosFocos;
begin
 //Insere uma nova RA
 FrmDlgEditRA := TFrmDlgEditRA.Create(self);
 IFocos := GetIFocos;

 try
  sNewRegion := FrmDlgEditRA.InputRA('', TCosmosTitles.NewSubRa);
  if sNewRegion.Trim <> '' then
   begin
    NewCode := IFocos.NewRegion(sNewRegion, GetFocusID(SelectedNode));
    if NewCode <> null then
     NovaRegiaoAdministrativa(NewCode, sNewRegion, SelectedNode);
   end;

 finally
  if Assigned(FrmDlgEditRA) then FreeAndNil(FrmDlgEditRA);
  if Assigned(IFocos) then IFocos := nil;
 end;
end;

procedure TFmeFocos.ActNewSubRAUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True) and (SelectedType = tfRa)
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfNovaRA in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActDelRAExecute(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
IFocos: ICosmosFocos;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;
 IFocos := GetIFocos;

 try
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.RAs, TCosmosConfMsg.DeleteRa) = mrYes then
  begin
   if IFocos.DeleteRegion(GetFocusID(SelectedNode)) then
     SelectedNode.Delete;
  end;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Assigned(IFocos) then IFocos := nil;
 end;
end;

procedure TFmeFocos.TreeFocosKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  TreeFocos.OnDblClick(self);
end;

procedure TFmeFocos.ListFocusRegion(Root: TTreeNode; ADataset: TDataset);
var
PFoco: PFocos;
ANode: TTreeNode;
begin
 //Lista of focos ligados a uma determinada região administrativa
 TreeFocos.Items.BeginUpdate;//Método chamado para impedir draw desnecessário

 try
  while not ADataset.Eof do
   begin
    New(PFoco);//Cria um novo ponteiro do record TFocos
    PFoco.codfoc := ADataset.Fields.FieldByName('codfoc').AsInteger;
    PFoco.nomfoc := ADataset.Fields.FieldByName('nomfoc').AsString;
    PFoco.tipfoc := TFocusTypesInfo.GetFocusType(ADataset.Fields.FieldByName('tipfoc').AsString);
    PFoco.sigfoc := ADataset.Fields.FieldByName('sigfoc').AsString;
    Pfoco.indati := TDataConverter.ToBolean(ADataset.Fields.FieldByName('indati').AsString);

    if Root = nil then
     ANode := TreeFocos.Items.AddObject(nil,PFoco.nomfoc,PFoco)
    else
     ANode := TreeFocos.Items.AddChildObject(Root,PFoco.nomfoc,PFoco);

    if PFoco.indati then
     ANode.ImageIndex := Ord(PFoco.tipfoc)
    else
     ANode.ImageIndex := 9;

    ANode.SelectedIndex := ANode.ImageIndex;
    ADataset.Next;
   end;

 finally
  if Root <> nil then Root.Expand(False);
  TreeFocos.Items.EndUpdate;
 end;
end;

procedure TFmeFocos.ActDelRAUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True) and (SelectedType = tfRa)
    and not (SelectedNode.HasChildren)
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfDeleteRA in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActListInactivesUpdate(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  TAction(Sender).Enabled := (ICosmosApp.IRemoteCon.Connected);
  TAction(Sender).Checked := ListInactives;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
 end;
end;

procedure TFmeFocos.ActCanEditUpdate(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  TAction(Sender).Enabled := (ICosmosApp.IRemoteCon.Connected);
  TAction(Sender).Checked := AllowEdit;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
 end;
end;

procedure TFmeFocos.ActActiveFocusExecute(Sender: TObject);
var
codfoc: Integer;
ICosmosApp: ICosmosApplication;
IFocos: ICosmosFocos;
begin
//Desativa o foco selecionado
 ICosmosApp := Application.MainForm as ICosmosApplication;
 IFocos := GetIFocos;

 try
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.FocosUpdate, Format(TCosmosConfMsg.ActiveFocus, [SelectedNode.Text])) = mrYes then
   begin
    codfoc := GetFocusID(SelectedNode);
    if IFocos.ChangeFocusStatus(codfoc, True)then
      ChangeFocusStatus(SelectedNode, True);
   end;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Assigned(IFocos) then IFocos := nil;
 end;
end;

procedure TFmeFocos.ActActiveFocusUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True)
    and not(SelectedType in ([tfRa, tfUnknown, tfTypeIndicator]))
    and (GetFocusStatus(SelectedNode) = False)
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfActivateFocus in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActEnderecosFocoUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True)
    and not(SelectedType in ([tfRa, tfUnknown, tfTypeIndicator]))
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfEnderecosFocus in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.SelectFocus;
begin
 if Assigned(FOnSelectFocus) then FOnSelectFocus(self);
end;

procedure TFmeFocos.ActFocoTypeStyleExecute(Sender: TObject);
begin
 ListType := tlTipologic;
end;

procedure TFmeFocos.ActFocoTypeStyleUpdate(Sender: TObject);
begin
 TAction(Sender).Checked := ListType = tlTipologic;
end;

function TFmeFocos.GetParenFocusType(const Focus: TTreeNode): TTipoFoco;
begin
//Obtém o tipo do foco superior de um determinada foco
 if Focus <> nil then
  Result := GetFocusType(Focus.Parent)
 else
  Result := tfUnknown;
end;

procedure TFmeFocos.ActNewFocusExecute(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
//Acessa o assistente de criação de novos focos.
 ICosmosApp := Application.MainForm as ICosmosApplication;
 ICosmosApp.ExecuteWizard('wznewfocus.bpl', 'TFrmWizardNewFocus');
end;

procedure TFmeFocos.ActMeiosContatoExecute(Sender: TObject);
var
AModule: HModule;
AForm: TForm;
ICosmosApp: ICosmosApplication;
IMeiosContatos: ICosmosMeiosContatos;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;
 AForm := ICosmosApp.LoadDialog('meicont.bpl', 'TFrmMeiosContatos', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosMeiosContatos) then
        IMeiosContatos := AForm as ICosmosMeiosContatos;

       if Assigned(IMeiosContatos) then
         IMeiosContatos.ShowMeiosContatosFocos(GetFocusID(SelectedNode));
       Free;
      end;
   end;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Assigned(IMeiosContatos) then IMeiosContatos := nil;
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFmeFocos.ActMeiosContatoUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True)
    and not(SelectedType in ([tfRa, tfUnknown, tfTypeIndicator]))
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfMeiosContatosFocus in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActEditFocusExecute(Sender: TObject);
begin
//Acessa a janela de edição dos dados do foco
 FrmEditarFoco := TFrmEditarFoco.Create(self);

 try
  FrmEditarFoco.EditarFoco(GetFocusID(SelectedNode));
  self.GetSelectedFocusData.nomfoc := FrmEditarFoco.Foco.FocusName;
  self.GetSelectedFocusData.sigfoc := FrmEditarFoco.Foco.Sigla;
  self.GetSelectedFocusData.tipfoc := FrmEditarFoco.Foco.FocusType;
  self.SelectedNode.Text := self.GetSelectedFocusData.nomfoc;

  if Assigned(self.OnSelectFocus) then
   self.OnSelectFocus(Sender);

 finally
  if Assigned(FrmEditarFoco) then FreeAndNil(FrmEditarFoco);
 end;
end;

procedure TFmeFocos.ActEditFocusUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True)
    and not(SelectedType in ([tfRa, tfUnknown, tfTypeIndicator]))
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfEditFocus in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActEnderecosFocoExecute(Sender: TObject);
var
AModule: HModule;
AForm: TForm;
ICosmosApp: ICosmosApplication;
IEnderecos: ICosmosEnderecos;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;
 AForm := ICosmosApp.LoadDialog('cadend.bpl', 'TFrmCadastroEndereco', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosEnderecos) then
        IEnderecos := AForm as ICosmosEnderecos;

       if Assigned(IEnderecos) then
         IEnderecos.GetEnderecosFoco(GetFocusID(SelectedNode));
       Free;
      end;
   end;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Assigned(IEnderecos) then IEnderecos := nil;
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFmeFocos.ActNewFocusUpdate(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  TAction(sender).Enabled := (AllowEdit = True) and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfNovoFoco in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);

 finally
  ICosmosApp := nil;
 end;
end;

procedure TFmeFocos.ActMentorsExecute(Sender: TObject);
begin
 if not Assigned(FrmEditMentores) then
  FrmEditMentores := TFrmEditMentores.Create(self);

 try
  FrmEditMentores.SelectMentoresRA(GetFocusID(SelectedNode), SelectedNode.Text);

 finally
  if Assigned(FrmEditMentores) then FreeAndNil(FrmEditMentores);
 end;
end;

procedure TFmeFocos.ActMentorsUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True) and (SelectedType = tfRa)
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfMentorsRas in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.ActDelFocusExecute(Sender: TObject);
var
ID: integer;
ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.FocosUpdate, Format(TCosmosConfMsg.DelFocus, [SelectedNode.Text])) = mrYes then
  begin
   ID := GetFocusID(SelectedNode);
   DeleteFocus(ID,SelectedNode.Text);
  end;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
 end;
end;

procedure TFmeFocos.ActDelFocusUpdate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 TAction(sender).Enabled := (AllowEdit = True)
    and not(SelectedType in ([tfRa, tfUnknown, tfTypeIndicator]))
    and (ICosmosApp.IRemoteCon.Connected)
    and (ICosmosApp.IRemoteCon.CurrentConnectionInfo <> nil)
    and (sfDeleteFocus in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFmeFocos.DeleteFocus(FocusID: integer; FocusName: string);
begin
//Exclui um determinado foco
 if GetFocusStatus(SelectedNode) then
  ActDesactiveFocus.Execute //Foco está ativo!
 else
  begin //Foco está inativo
  //Exclui o foco selecionado
   if not Assigned(FrmDelFocus) then
    FrmDelFocus := TFrmDelFocus.Create(self);

   try
    if FrmDelFocus.DeleteFocus(GetFocusID(SelectedNode), SelectedNode.Text) then
     SelectedNode.Delete;

   finally
    if Assigned(FrmDelFocus) then FreeAndNil(FrmDelFocus);
   end;
  end;
end;

procedure TFmeFocos.ExpandNode(Node: TTreeNode);
begin
 if Node <> nil then
  Node.Expand(False);
end;

function TFmeFocos.GetFocusStatus(const Focus: TTreeNode): boolean;
var
PFoco: PFocos;
begin
//Retorna se o foco está ativo ou não
 if Focus <> nil then
  begin
   PFoco := Focus.Data;
   Result := PFoco.indati;
  end
  else
   Result := False;
end;

procedure TFmeFocos.ChangeFocusStatus(const Focus: TTreeNode; value: boolean);
var
PFoco: PFocos;
begin
//Retorna se o foco está ativo ou não
 if Focus <> nil then
  begin
   PFoco := Focus.Data;
   PFoco.indati := value;
   if value then
    SelectedNode.ImageIndex := Ord(GetSelectedType)
   else
    SelectedNode.ImageIndex := 11;

   SelectedNode.SelectedIndex := SelectedNode.ImageIndex;
  end;
end;


end.
