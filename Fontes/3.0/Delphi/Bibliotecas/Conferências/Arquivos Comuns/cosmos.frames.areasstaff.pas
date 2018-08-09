unit cosmos.frames.areasstaff;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, DBClient,
  cosmos.classes.application, cosmos.system.messages, cosmos.classes.ServerInterface,
  cosmos.framework.interfaces.root, Vcl.ImgList, CommCtrl, Vcl.ActnList,
  Data.DBXCommon, System.Actions, cosmos.classes.security;

type
  TNodeType = (ntArea, ntAtividade, ntUnknown);
  TListType = (ltAreas, ltTarefas);
  TListTypeSet = set of TListType;

  TNode = record
   code: integer;
   NType: TNodeType;
   Nome: string;
  end;

  PNode = ^TNode;

  TChangeNodeEvent = procedure(Sender: TObject; Node: TTreeNode) of object;


  TFmeAreasStaff = class(TFrame)
    TrvAreas: TTreeView;
    TreeList: TImageList;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActAddArea: TAction;
    ActAddSubArea: TAction;
    ActEditarArea: TAction;
    ActDeleteArea: TAction;
    ActNovaTarefa: TAction;
    ActEditarTarefa: TAction;
    ActDelTarefa: TAction;
    procedure TrvAreasChange(Sender: TObject; Node: TTreeNode);
    procedure TrvAreasChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvAreasDblClick(Sender: TObject);
    procedure TrvAreasDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TrvAreasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActAddAreaExecute(Sender: TObject);
    procedure ActAddSubAreaExecute(Sender: TObject);
    procedure ActEditarAreaExecute(Sender: TObject);
    procedure ActDeleteAreaExecute(Sender: TObject);
    procedure ActNovaTarefaExecute(Sender: TObject);
    procedure ActEditarTarefaExecute(Sender: TObject);
    procedure ActEditarTarefaUpdate(Sender: TObject);
    procedure ActEditarAreaUpdate(Sender: TObject);
    procedure ActAddAreaUpdate(Sender: TObject);
    procedure ActAddSubAreaUpdate(Sender: TObject);
    procedure ActDeleteAreaUpdate(Sender: TObject);
    procedure ActNovaTarefaUpdate(Sender: TObject);
    procedure ActDelTarefaExecute(Sender: TObject);
    procedure ActDelTarefaUpdate(Sender: TObject);
    procedure TrvAreasDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private declarations }
    FChangeSelected: TChangeNodeEvent;
    FListagem: TListTypeSet;

    function GetICosmosApp: ICosmosApplication;
    function GetSelectedArea: PNode;
    function GetNodeType(Node: TTreeNode):TNodeType;
    function GetNodeCode(Node: TTreeNode):variant;
    function GetTreeNada: TtreeView;

  public
    { Public declarations }

    procedure ListarAreas(Parent: TTreeNode);
    procedure ListarAtividades(Area: TTreeNode);
    procedure AddArea(Area: string; Parent: PNode);
    function UpdateArea(Area: string; NewParent: TTreeNode = nil): boolean;
    function UpdateTarefa(TarefaId, NewParentId: integer): boolean;
    function DeleteArea: boolean;

    property ChangeSelected: TChangeNodeEvent read FChangeSelected write FChangeSelected;
    property Listagem: TListTypeSet read FListagem write FListagem;
    property SelectedArea: PNode read GetSelectedArea;
    property TreeData: TTreeView read GetTreeNada;

    property ICosmosApp: ICosmosApplication read GetICosmosApp;
  end;

implementation

{$R *.dfm}

uses cosmos.conferencias.view.FormEditarAreaStaff,
cosmos.conferencias.view.FormEditarTarefasStaff;

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

{ TFmeAreasStaff }

procedure TFmeAreasStaff.ActAddAreaExecute(Sender: TObject);
var
AArea: string;
begin
//Adiciona uma nova área na raíz do conjunto.
  inherited;
  FrmEditarAreaStaff := TFrmEditarAreaStaff.Create(Application);

  try
   if FrmEditarAreaStaff.EditarArea(AArea) then
    begin
     AddArea(AArea, nil);
     self.ListarAreas(nil);
    end;

  finally
   if Assigned(FrmEditarAreaStaff) then
    FreeAndNil(FrmEditarAreaStaff);
  end;
end;

procedure TFmeAreasStaff.ActAddAreaUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=  (Assigned(ICosmosApp))
   and (ICosmosApp.IRemoteCon.Connected)
   and (nfNovaAreaStaff in ICosmosApp.IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFmeAreasStaff.ActAddSubAreaExecute(Sender: TObject);
var
AArea: string;
begin
//Adiciona uma nova sub-área.
  inherited;
  FrmEditarAreaStaff := TFrmEditarAreaStaff.Create(Application);

  try
   if FrmEditarAreaStaff.EditarArea(AArea) then
    begin
     AddArea(AArea, SelectedArea);
     self.ListarAreas(TrvAreas.Selected);
    end;

  finally
   if Assigned(FrmEditarAreaStaff) then
    FreeAndNil(FrmEditarAreaStaff);
  end;

end;

procedure TFmeAreasStaff.ActAddSubAreaUpdate(Sender: TObject);
begin
   TAction(Sender).Enabled := (SelectedArea <> nil)
   and (SelectedArea.NType = ntArea)
   and (Assigned(ICosmosApp))
   and (ICosmosApp.IRemoteCon.Connected)
   and (nfNovaAreaStaff in ICosmosApp.IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFmeAreasStaff.ActDeleteAreaExecute(Sender: TObject);
begin
 if DeleteArea then
  TrvAreas.Selected.Delete;
end;

procedure TFmeAreasStaff.ActDeleteAreaUpdate(Sender: TObject);
begin
   TAction(Sender).Enabled := (SelectedArea <> nil)
   and (SelectedArea.NType = ntArea)
   and (Assigned(ICosmosApp))
   and (ICosmosApp.IRemoteCon.Connected)
   and (nfExcluirAreaStaff in ICosmosApp.IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFmeAreasStaff.ActDelTarefaExecute(Sender: TObject);
begin
//to-do.
end;

procedure TFmeAreasStaff.ActDelTarefaUpdate(Sender: TObject);
begin
   TAction(Sender).Enabled := (SelectedArea <> nil)
   and (SelectedArea.NType = ntArea)
   and (Assigned(ICosmosApp))
   and (ICosmosApp.IRemoteCon.Connected)
   and (nfExcluirTarefasArea in ICosmosApp.IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFmeAreasStaff.ActEditarAreaExecute(Sender: TObject);
var
AArea: string;
begin
//Altera o nome da área selecionada.
  inherited;
  FrmEditarAreaStaff := TFrmEditarAreaStaff.Create(Application);

  try
   AArea := SelectedArea.Nome;
   if FrmEditarAreaStaff.EditarArea(AArea) then
    begin
     UpdateArea(AARea);
     self.ListarAreas(TrvAreas.Selected.Parent);
    end;

  finally
   if Assigned(FrmEditarAreaStaff) then
    FreeAndNil(FrmEditarAreaStaff);
  end;
end;

procedure TFmeAreasStaff.ActEditarAreaUpdate(Sender: TObject);
begin
   TAction(Sender).Enabled := (SelectedArea <> nil)
   and (SelectedArea.NType = ntArea)
   and (Assigned(ICosmosApp))
   and (ICosmosApp.IRemoteCon.Connected)
   and (nfAlterarAreaStaff in ICosmosApp.IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFmeAreasStaff.ActEditarTarefaExecute(Sender: TObject);
var
AData: TCosmosData;
begin
  inherited;
  FrmEditarTarefasStaff := TFrmEditarTarefasStaff.Create(Application);
  AData := TCosmosData.Create(5);

  try
   AData.WriteValue('CODARE', PNode(TrvAreas.Selected.Parent.Data).code);
   AData.WriteValue('NOMARE', PNode(TrvAreas.Selected.Parent.Data).Nome, 1);
   AData.WriteValue('CODTAR', self.SelectedArea.code, 2);
   FrmEditarTarefasStaff.EditarTarefa(AData);

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(FrmEditarTarefasStaff) then FreeAndNil(FrmEditarTarefasStaff);
  end;
end;

procedure TFmeAreasStaff.ActEditarTarefaUpdate(Sender: TObject);
begin
   TAction(Sender).Enabled := (SelectedArea <> nil)
   and (SelectedArea.NType = ntAtividade)
   and (Assigned(ICosmosApp))
   and (ICosmosApp.IRemoteCon.Connected)
   and (nfAlterarTarefasArea in ICosmosApp.IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFmeAreasStaff.ActNovaTarefaExecute(Sender: TObject);
var
AData: TCosmosData;
begin
  FrmEditarTarefasStaff := TFrmEditarTarefasStaff.Create(Application);
  AData := TCosmosData.Create(5);

  try
   AData.WriteValue('CODARE', self.SelectedArea.code);
   AData.WriteValue('NOMARE', self.SelectedArea.Nome, 1);
   FrmEditarTarefasStaff.NovaTarefa(AData);

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(FrmEditarTarefasStaff) then FreeAndNil(FrmEditarTarefasStaff);
  end;
end;

procedure TFmeAreasStaff.ActNovaTarefaUpdate(Sender: TObject);
begin
   TAction(Sender).Enabled := (SelectedArea <> nil)
   and (SelectedArea.NType = ntArea)
   and (Assigned(ICosmosApp))
   and (ICosmosApp.IRemoteCon.Connected)
   and (nfNovaTarefasArea in ICosmosApp.IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFmeAreasStaff.AddArea(Area: string; Parent: PNode);
var
AParams: TCosmosData;
ACommand: TDBXCommand;
begin
  AParams := TCosmosData.Create(3);

  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
    AParams.WriteValue('AREA', QuotedStr(Area), 0);
    if Parent = nil then
     AParams.WriteValue('INFO', 'null', 1)
    else
     AParams.WriteValue('INFO', IntToStr(Parent.code), 1);

    AParams.WriteValue('FOCUS_ID', ICosmosApp.ActiveFocus.FocusID, 2);

    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TDMCosmosConferenciasMethods.ManterAreaStaff';  //do not localize!
    ACommand.Prepare;
    ACommand.Parameters[0].Value.AsVariant := AParams.Data;
    ACommand.Parameters[1].Value.SetInt32(Ord(doInsert));
    ACommand.ExecuteUpdate;

    ICosmosApp.Mainlog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
    ACommand.Free;

  except
   on E: Exception do
    begin
     if Assigned(AParams) then  FreeAndNil(AParams);
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
  end;
end;

function TFmeAreasStaff.DeleteArea: boolean;
var
AParams: TCosmosData;
ACommand: TDBXCommand;
ANode: PNode;
begin
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AreasStaff, TCosmosConfMsg.DelAreaStaff) = mrYes then
   begin
    ANode := TrvAreas.Selected.Data;
    AParams := TCosmosData.Create(1);
    AParams.WriteValue('CODARE', ANode.code, 0);
    ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMCosmosConferenciasMethods.ManterAreaStaff';  //do not localize!
     ACommand.Prepare;
     ACommand.Parameters[0].Value.AsVariant := AParams.Data;
     ACommand.Parameters[1].Value.SetInt32(Ord(doDelete));
     ACommand.ExecuteUpdate;

     Result := ACommand.Parameters[2].Value.GetInt32 = 0;

     if ACommand.Parameters[2].Value.GetInt32 = 1 then
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.AreasStaff, TCosmosInfoMsg.CantDelAreaStaff);


    ICosmosApp.Mainlog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     ACommand.Free;

   except
    on E: Exception do
     begin
      Result := False;
      if Assigned(AParams) then  FreeAndNil(AParams);
      ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
      if Assigned(ACommand) then FreeAndNil(ACommand);
     end;
   end;
   end;
end;

function TFmeAreasStaff.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

function TFmeAreasStaff.GetNodeCode(Node: TTreeNode): variant;
var
 AData: PNode;
begin
//Retorna o código do nó da árvore.
 if (Node <> nil) and (Node.Data <> nil) then
  begin
   AData := Node.Data;
   Result := AData.code;
  end
 else
  Result := null
end;

function TFmeAreasStaff.GetNodeType(Node: TTreeNode): TNodeType;
var
 AData: PNode;
begin
//Retorna o tipo do nó da árvore.
 if (Node <> nil) and (Node.Data <> nil) then
  begin
   AData := Node.Data;
   Result := AData.NType;
  end
 else
  Result := ntUnknown
end;

function TFmeAreasStaff.GetSelectedArea: PNode;
begin
 if TrvAreas.Selected <> nil then
  Result := TrvAreas.Selected.Data
 else
  Result := nil;
end;

function TFmeAreasStaff.GetTreeNada: TtreeView;
begin
 Result := self.TrvAreas;
end;

procedure TFmeAreasStaff.ListarAreas(Parent: TTreeNode);
var
Node: PNode;
ADataset: TClientDataset;
TreeNode: TTreeNode;
AParams: TCosmosData;
begin
 {Lista as áreas e sub-áreas de staff cadastradas. Somente lista as áreas caso
 a listagem de áreas esteja selecionada.}
  if not (ltAreas in Listagem) then
  Exit;

 ADataset := TClientDataset.Create(nil);
 if Parent = nil then
  AParams := TCosmosData.Create(1)
 else
  AParams := TCosmosData.Create(2);

 try
  TrvAreas.Items.BeginUpdate;
  AParams.WriteValue('FOCUS_ID', ICosmosApp.ActiveFocus.FocusID, 0);

  if Parent = nil then
   ICosmosApp.IRemoteCon.ExecuteDQL(csAreasStaff, AParams.Data, ADataset)
  else
   begin
    AParams.WriteValue('PARENT_FOCUS', PNode(Parent.Data).code, 1);
    ICosmosApp.IRemoteCon.ExecuteDQL(csSubAreasStaff, AParams.Data, ADataset);
   end;

  if Parent <> nil then
   Parent.DeleteChildren
  else
   TrvAreas.Items.Clear;

  while not ADataset.Eof do
   begin
    if ADataset.FieldValues['codare'] <> null then
     begin
       New(Node);
       Node.code := ADataset.Fields.FieldByName('codare').AsInteger;
       Node.NType := ntArea;

       Node.Nome := ADataset.FieldValues['nomare'];

       if Parent <> nil then
        TreeNode := TrvAreas.Items.AddChildObject(Parent, Node.Nome, Node)
       else
        TreeNode := TrvAreas.Items.AddObject(nil, Node.Nome, Node);

       TreeNode.ImageIndex := 0;
       TreeNode.OverlayIndex := TreeNode.ImageIndex;
       TreeNode.SelectedIndex := TreeNode.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  if Parent <> nil then Parent.Expand(False);
  TrvAreas.Items.EndUpdate;
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFmeAreasStaff.ListarAtividades(Area: TTreeNode);
var
Node: PNode;
ADataset: TClientDataset;
TreeNode, AChild: TTreeNode;
AParams: TCosmosData;
begin
 {Lista as atividades de uma áreas de staff cadastrada. Somente lista as
 atividades caso a listagem de atividades esteja selecionada.}

 if not (ltTarefas in Listagem) then
  Exit;

 if Area = nil then
  Exit //Uma atividade necessariamente está ligada a uma área de staff.
 else
  AParams := TCosmosData.Create(5);

 ADataset := TClientDataset.Create(nil);

 try
  TrvAreas.Items.BeginUpdate;
  AParams.WriteValue('CODARE', PNode(Area.Data).code, 0);
  ICosmosApp.IRemoteCon.ExecuteDQL(csTarefasAreaStaff, AParams.Data, ADataset);

  //Primeiro, exclui apenas os nós que representam tarefas.
  AChild := Area.GetNextChild(Area);

  while AChild <> nil do
   begin
    if PNode(AChild.Data).NType = ntAtividade then
     begin
      AChild.Delete;
      AChild := Area.GetNextChild(Area);
     end
    else
      AChild := AChild.getNextSibling;
   end;

  //Agora, insere todos os nós retornados na pesquisa de tarefas.
  while not ADataset.Eof do
   begin
    if ADataset.FieldValues['codtar'] <> null then
     begin
      New(Node);
      Node.code := ADataset.Fields.FieldByName('codtar').AsInteger;
      Node.NType := ntAtividade;
      Node.Nome := ADataset.FieldValues['destar'];

      TreeNode := TrvAreas.Items.AddChildObject(Area, Node.Nome, Node);
      TreeNode.ImageIndex := 1;
      TreeNode.OverlayIndex := TreeNode.ImageIndex;
      TreeNode.SelectedIndex := TreeNode.ImageIndex;
     end;

    ADataset.Next;
   end;

 finally
  Area.Expand(False);
  TrvAreas.Items.EndUpdate;
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFmeAreasStaff.TrvAreasChange(Sender: TObject; Node: TTreeNode);
begin
//Negrita o nó da árvore
  if Node <> nil then
   SetNodeBoldState(Node,True);

//Dispara o evento mapeado na classe TFmeAreasStaff.
  if Assigned(FChangeSelected) then
   FChangeSelected(Sender, Node);
end;

procedure TFmeAreasStaff.TrvAreasChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  //Retira o negrito do nó
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFmeAreasStaff.TrvAreasDblClick(Sender: TObject);
begin
 if SelectedArea = nil then
  ListarAreas(nil)
 else
  begin
   if SelectedArea.NType = ntArea then
    begin
     ListarAreas(TrvAreas.Selected);
     ListarAtividades(TrvAreas.Selected);
    end;
  end;
end;

procedure TFmeAreasStaff.TrvAreasDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
 NewParent: TTreeNode;
 ASucess: boolean;
 AParentCode: variant;
begin
  NewParent := TrvAreas.GetNodeAt(x, y);

  if NewParent = nil then
   Exit;

  case GetSelectedArea.NType of
   ntArea:  ASucess := UpdateArea(TrvAreas.Selected.Text, NewParent);
   ntAtividade:
    begin
      AParentCode := self.GetNodeCode(NewParent);
      ASucess := AParentCode <> null;
      if ASucess then
        ASucess := UpdateTarefa(GetSelectedArea.code, AParentCode);
    end
   else
    ASucess := False;
  end;

  if ASucess then
    TrvAreas.Selected.MoveTo(NewParent, naAddChild);
end;

procedure TFmeAreasStaff.TrvAreasDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
ADestNode: TTreeNode; //destinatário
begin
 Accept := (Sender is TTreeview) and (Source is TTreeView) and (TrvAreas.Selected <> nil);

 if Accept then
  begin
   ADestNode := TrvAreas.GetNodeAt(x, y); //Destinatário
   Accept := (ADestNode <> nil) and (ADestNode <> TrvAreas.Selected)
     and (TrvAreas.Selected.Parent <> ADestNode);

   if Accept then
    begin
     case GetNodeType(TrvAreas.Selected) of
      ntArea, ntAtividade: Accept := GetNodeType(ADestNode) = ntArea;
     else
      Accept := False;
     end;
    end;
 end;
end;

procedure TFmeAreasStaff.TrvAreasKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
   TrvAreas.OnDblClick(TrvAreas);
end;

function TFmeAreasStaff.UpdateArea(Area: string; NewParent: TTreeNode): boolean;
var
AParams: TCosmosData;
ACommand: TDBXCommand;
AParent: PNode;
begin
  if NewParent = nil then
   begin
    if TrvAreas.Selected.Parent = nil then
     AParent := nil
    else
     AParent := TrvAreas.Selected.Parent.Data;
   end
  else
    AParent := NewParent.Data;

  AParams := TCosmosData.Create(4);
  AParams.WriteValue('AREA', QuotedStr(Area), 0);
  if AParent = nil then
   AParams.WriteValue('PARENT', 'null', 1)
  else
   AParams.WriteValue('PARENT', IntToStr(AParent.code), 1);

  AParams.WriteValue('FOCUS_ID', ICosmosApp.ActiveFocus.FocusID, 2);
  AParams.WriteValue('CODARE', SelectedArea.code, 3);

  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMCosmosConferenciasMethods.ManterAreaStaff';  //do not localize!
     ACommand.Prepare;
     ACommand.Parameters[0].Value.AsVariant := AParams.Data;
     ACommand.Parameters[1].Value.SetInt32(Ord(doUpdate));
     ACommand.ExecuteUpdate;

     Result := ACommand.Parameters[2].Value.GetInt32 = 0;

     if ACommand.Parameters[2].Value.GetInt32 = 1 then
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.AreasStaff, TCosmosInfoMsg.CantDelAreaStaff);


    ICosmosApp.Mainlog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
    ACommand.Free;

   except
    on E: Exception do
     begin
      Result := False;
      if Assigned(AParams) then  FreeAndNil(AParams);
      ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
      if Assigned(ACommand) then FreeAndNil(ACommand);
     end;
   end;
end;

function TFmeAreasStaff.UpdateTarefa(TarefaId: integer; NewParentId: integer): boolean;
var
ACommand: TDBXCommand;
begin
  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TDMCosmosConferenciasMethods.MudarAreaTarefaStaff';  //do not localize!
    ACommand.Prepare;
    ACommand.Parameters[0].Value.SetInt32(TarefaId);
    ACommand.Parameters[1].Value.SetInt32(NewParentId);
    ACommand.ExecuteUpdate;

    Result := True;

    ICosmosApp.Mainlog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
    ACommand.Free;

  except
   on E: Exception do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
  end;
end;

end.
