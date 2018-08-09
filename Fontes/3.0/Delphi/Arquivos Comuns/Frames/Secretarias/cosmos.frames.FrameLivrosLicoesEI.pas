unit cosmos.frames.FrameLivrosLicoesEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ImgList, ComCtrls, CommCtrl, Menus, ActnPopup, ActnList,
  Cosmos.Framework.Interfaces.Root, StdCtrls, DBClient, DB, ActnMan,
  cosmos.system.messages, cosmos.classes.application, Data.DBXCommon,
  PlatformDefaultStyleActnCtrls, cosmos.Framework.Interfaces.DataAcess,
  cosmos.classes.ServerInterface, System.Actions;

type

  ObjectType = (otDiscipulado, otLivro, otLicao, otNone);

  PEIObjects = ^TEIObjects;

  TEIObjects = record
   ECode: integer;
   EName: string;
   EType: ObjectType;
  end;

  TFmeEIBooks = class(TFrame)
    TrvLivrosLicoes: TTreeView;
    ImgTree: TImageList;
    ActionList1: TActionList;
    ActNewBook: TAction;
    ActEditBook: TAction;
    ActDelBook: TAction;
    ImageList2: TImageList;
    ActUpdate: TAction;
    ActNewLesson: TAction;
    ActEditLesson: TAction;
    ActDelLesson: TAction;
    PopUpMenu: TPopupActionBar;
    ExcluirLivro1: TMenuItem;
    ExcluirLio1: TMenuItem;
    EditarLivro1: TMenuItem;
    EditarLio1: TMenuItem;
    NovoLivro1: TMenuItem;
    NovaLio1: TMenuItem;
    Atualizar1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ActNotes: TAction;
    Notas1: TMenuItem;
    procedure ActDelBookExecute(Sender: TObject);
    procedure ActDelLessonExecute(Sender: TObject);
    procedure ActEditLessonExecute(Sender: TObject);
    procedure TrvLivrosLicoesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TrvLivrosLicoesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ActUpdateUpdate(Sender: TObject);
    procedure ActUpdateExecute(Sender: TObject);
    procedure ActEditBookUpdate(Sender: TObject);
    procedure ActNewBookUpdate(Sender: TObject);
    procedure ActEditLessonUpdate(Sender: TObject);
    procedure ActNewLessonUpdate(Sender: TObject);
    procedure ActNewLessonExecute(Sender: TObject);
    procedure TrvLivrosLicoesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TrvLivrosLicoesDblClick(Sender: TObject);
    procedure TrvLivrosLicoesChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvLivrosLicoesChange(Sender: TObject; Node: TTreeNode);
    procedure ActNewBookExecute(Sender: TObject);
    procedure ActEditBookExecute(Sender: TObject);
    procedure PopUpMenuPopup(Sender: TObject);
  private
    { Private declarations }
    FOnSelectTreeItem: TNotifyEvent;
    FListLessons: boolean;
    FHideMenu: boolean;

    function GetICosmosApp: ICosmosApplication;
    function GetSelectedNodeType: ObjectType;
    function GetSelectedID: integer;
    function GetSelectedText: string;
    function GetNodeID(Node: TTreeNode): integer;
    function GetNodeType(const Node: TTreeNode): ObjectType;
    function GetDiscipulado: string;
    function GetDiscipuladoNode: TTreeNode;
    procedure SetPopUpMenu(const Value: boolean);
    function CanDeleteLesson(const LessonId: integer): boolean;
    function DoDeleteBook(const BookId: integer): boolean;
    function DoDeleteLesson(const LessonId: integer): boolean;
    function DoReorderBook(Source, Target: integer): boolean;
    function DoReorderLesson(Source, Target: integer): boolean;

    function DoSearch(const Search: TCosmosSearch; Params: Olevariant): TDBXReader;

  protected
    procedure SelectTreeItem; virtual;

  public
    { Public declarations }
    procedure ListarDiscipuladosEI;
    procedure ListarLivrosLicoesEI(const Node: TTreeNode);

    property Discipulado: string read GetDiscipulado;
    property ICosmosApp: ICosmosApplication read GetICosmosApp;
    property SelectedID: integer read GetSelectedID;
    property SelectedText: string read GetSelectedText;
    property SelectedType: ObjectType read GetSelectedNodeType;
    property ListLessons: boolean read FListLessons write FListLessons default True;
    property HideMenu: boolean read FHideMenu write SetPopUpMenu;
    property OnSelectTreeItem: TNotifyEvent read FOnSelectTreeItem write FOnSelectTreeItem;



  end;

implementation

uses  cosmos.secretarias.view.FormNovoLivroEI, cosmos.secretarias.view.FormNovaLicaoEI;

{$R *.dfm}

{ TFmeEITree }

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

procedure TFmeEIBooks.ListarDiscipuladosEI;
var
NewNode: TTreeNode;
PEIObj: PEIObjects;
AReader: TDBXReader;
begin
{Lista os discipulados da escola interna. Os passos são os seguintes:
 1. Executar uma consulta sql na aplicação servidora.
 2. Criar os nós (com os respecrivos ponteiros) para cada discipulado.
 3. Fechar o dataset cliente usado na consulta.}
 AReader := DoSearch(csDiscipuladosEI, null);

 while AReader.Next do
   begin
      New(PEIObj);
      PEIObj^.ECode := AReader.Value['coddis'].GetInt32;
      PEIObj^.EName := AReader.Value['nomdis'].AsString;
      PEIObj^.EType := otDiscipulado;
      NewNode := TrvLivrosLicoes.Items.AddObject(nil,PEIObj^.EName,PEIObj);//Adiciona o objeto
      NewNode.ImageIndex := 3;
      NewNode.SelectedIndex := NewNode.ImageIndex;
   end;
end;

procedure TFmeEIBooks.ListarLivrosLicoesEI(const Node: TTreeNode);
var
ObjType: ObjectType;
PEIObj: PEIObjects;
NewNode: TTreeNode;
Code: integer;
ASearch: TCosmosSearch;
AParams: TSQLParams;
AReader: TDBXReader;
begin
{Lista os livros e lições de um livro de um discipulado da escola interna.
 O processo todo segue os seguintes passos:
 1. Determinar qual o tipo do objeto selecionado no treeview e o seu código.
 2. Executar uma consulta na aplicação servidora e recuperar os dados.
 3. Inserir novos nós no treeview (de um livro ou de uma lição), com o seu
    ponteiro e suas imagens.
 4. Expandir o nó selecionado.
 5. Fechar o dataset usado na consulta do passo 2. }
 if Node <> nil then
  begin
   if Assigned(Node.Data) then
    begin
     PEIObj := Node.Data;
     ObjType := PEIObj^.EType;
     Code := PEIObj^.ECode;
    end;

   case ObjType of
    otDiscipulado: ASearch := csLivrosDiscipuladoEI;
    otLivro:
     begin
      if FListLessons then
       ASearch := csLicoesLivroEI;
     end;
    otLicao: exit;
   end;
  end;

  AParams := TSQLParams.Create(1);
  AParams.AppendData(Code, 0);

  try
   AReader := DoSearch(ASearch, AParams.Params);
   Node.DeleteChildren;

   if AReader.Next then
    begin
     New(PEIObj);
     PEIObj^.ECode := AReader.Value['cod'].GetInt32;
     PEIObj^.EName := AReader.Value['desc'].AsString;
     if ObjType = otDiscipulado then
      PEIObj^.EType := otLivro
     else
      PEIObj^.EType := otLicao;
     NewNode := TrvLivrosLicoes.Items.AddChildObject(Node,PEIObj^.EName,PEIObj);

     case ObjType of
      otDiscipulado: NewNode.ImageIndex := 0;
      otLivro:
       begin
        NewNode.ImageIndex := 2;
        Node.ImageIndex := 1;
        Node.SelectedIndex := Node.ImageIndex;
       end;
      otLicao: NewNode.ImageIndex := 2;
     end;

     NewNode.SelectedIndex := NewNode.ImageIndex;
    end;

  finally
   Node.Expand(True);
   if Assigned(AParams) then FreeAndNil(AParams);
   if Assigned(AReader) then FreeAndNil(AReader);

  end;
end;

procedure TFmeEIBooks.PopUpMenuPopup(Sender: TObject);
begin
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFmeEIBooks.TrvLivrosLicoesChange(Sender: TObject; Node: TTreeNode);
begin
//Negrita o nó da árvore
 if Node <> nil then
  SetNodeBoldState(Node,True);
 SelectTreeItem;
end;

procedure TFmeEIBooks.TrvLivrosLicoesChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
 //Retira o negrito do nó
 SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFmeEIBooks.TrvLivrosLicoesDblClick(Sender: TObject);
begin
 if (TrvLivrosLicoes.Selected <> nil) and not (TrvLivrosLicoes.Selected.HasChildren) then
  ListarLivrosLicoesEI(TrvLivrosLicoes.Selected);
end;

procedure TFmeEIBooks.TrvLivrosLicoesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  TrvLivrosLicoes.OnDblClick(self);
end;

procedure TFmeEIBooks.ActNewLessonExecute(Sender: TObject);
begin
 if not Assigned(FrmNovaLicaoEI) then
  FrmNovaLicaoEI := TFrmNovaLicaoEI.Create(Self);

 try
  FrmNovaLicaoEI.NewLesson(SelectedID);

 finally
  if Assigned(FrmNovaLicaoEI) then
   FreeAndNil(FrmNovaLicaoEI);
 end;
end;

procedure TFmeEIBooks.ActNewLessonUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := SelectedType in [otLivro, otLicao];
end;

function TFmeEIBooks.GetSelectedNodeType: ObjectType;
var
PEIObj: PEIObjects;
begin
 if TrvLivrosLicoes.Selected = nil then
  Result := otNone
 else
  begin
   PEIObj := TrvLivrosLicoes.Selected.Data;
   Result := PEIObj^.EType;
  end;
end;

function TFmeEIBooks.GetSelectedText: string;
begin
 if TrvLivrosLicoes.Selected <> nil then
  Result := TrvLivrosLicoes.Selected.Text
 else
  Result := '';
end;

procedure TFmeEIBooks.ActEditLessonExecute(Sender: TObject);
begin
 if not Assigned(FrmNovaLicaoEI) then
  FrmNovaLicaoEI := TFrmNovaLicaoEI.Create(Self);

 try
  FrmNovaLicaoEI.EditLesson(GetNodeID(TrvLivrosLicoes.Selected.Parent), SelectedID);

 finally
  if Assigned(FrmNovaLicaoEI) then
   FreeAndNil(FrmNovaLicaoEI);
 end;
end;

procedure TFmeEIBooks.ActEditLessonUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := SelectedType = otLicao;
end;

procedure TFmeEIBooks.ActNewBookUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := SelectedType = otDiscipulado;
end;

procedure TFmeEIBooks.ActEditBookUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := SelectedType = otLivro;
end;

procedure TFmeEIBooks.ActUpdateExecute(Sender: TObject);
begin
 ListarLivrosLicoesEI(TrvLivrosLicoes.Selected);
end;

procedure TFmeEIBooks.ActUpdateUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := SelectedType <> otNone;
end;

function TFmeEIBooks.CanDeleteLesson(const LessonId: integer): boolean;
var
 ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.Text := 'TCosmosSecEIServerMethods.CanDeleteLesson';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(LessonId);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters.Parameter[1].Value.GetBoolean;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
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

function TFmeEIBooks.DoDeleteBook(const BookId: integer): boolean;
var
 ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.Text := 'TCosmosSecEIServerMethods.DeleteBook';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(BookId);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters.Parameter[1].Value.GetBoolean;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
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

function TFmeEIBooks.DoDeleteLesson(const LessonId: integer): boolean;
var
 ACommand: TDBXCommand;
begin
 Result := CanDeleteLesson(LessonId);
 if not Result then
  Abort;

 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.Text := 'TCosmosSecEIServerMethods.DeleteLesson';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(LessonId);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters.Parameter[1].Value.GetBoolean;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
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

function TFmeEIBooks.DoReorderBook(Source, Target: integer): boolean;
var
 ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.Text := 'TCosmosSecEIServerMethods.ReorderBook';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(Source);
  ACommand.Parameters.Parameter[1].Value.SetInt32(Target);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters.Parameter[2].Value.GetBoolean;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
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

function TFmeEIBooks.DoReorderLesson(Source, Target: integer): boolean;
var
 ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.Text := 'TCosmosSecEIServerMethods.ReorderLesson';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(Source);
  ACommand.Parameters.Parameter[1].Value.SetInt32(Target);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters.Parameter[2].Value.GetBoolean;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
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

function TFmeEIBooks.DoSearch(const Search: TCosmosSearch; Params: Olevariant): TDBXReader;
begin
 //Executa uma pesquisa no servidor remoto.
 Result := ICosmosApp.IRemoteCon.ListData(Search, Params);
end;

procedure TFmeEIBooks.TrvLivrosLicoesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
TargetNode, SourceNode: TTreeNode;
sMessage: string;
begin
 SourceNode := TrvLivrosLicoes.Selected;
 TargetNode := TrvLivrosLicoes.GetNodeAt(x,y);

 case GetNodeType(SourceNode) of
  otDiscipulado: Exit;  //Não se faz nada
  otLivro:
   begin
    case GetNodeType(TargetNode) of
     //Livro sendo arrastado para discipulado
     otDiscipulado: sMessage := Format(TCosmosConfMsg.AssociarLivroDiscipulado, [SourceNode.Text,TargetNode.Text]);
     otLivro: //Livro sendo arrastado para outro livro
      begin
       sMessage := Format(TCosmosConfMsg.AlterarOrdemLivro, [SourceNode.Text]);

       if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.LivrosEI, sMessage) = mrYes then
        begin
         if DoReorderBook(GetNodeID(SourceNode), GetNodeID(TargetNode)) then
          SourceNode.MoveTo(TargetNode, naInsert);
        end;
      end;
     otLicao: exit; //Livro sendo arrastado para lição
    end;
   end;
  otLicao:
    case GetNodeType(TargetNode) of
     otLivro: //Lição sendo arrastada para livro
      begin
       sMessage := Format(TCosmosConfMsg.VincularLicao, [SourceNode.Text, TargetNode.Text]);

       if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.LivrosEI, sMessage) = mrYes then
        SourceNode.MoveTo(TargetNode, naAddChild);
      end;
     otLicao: //Lição sendo arrastada para lição
      begin
       sMessage := Format(TCosmosConfMsg.AlterarOrdemLicao, [SourceNode.Text]);

       if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.LivrosEI, sMessage) = mrYes then
        begin
         if DoReorderLesson(GetNodeID(SourceNode), GetNodeID(TargetNode)) then
          SourceNode.MoveTo(TargetNode, naInsert);
        end;
      end;
    end;
 end;
end;

procedure TFmeEIBooks.TrvLivrosLicoesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
Target: TTreeNode;
begin
 Target := TrvLivrosLicoes.GetNodeAt(x,y);

 case SelectedType of
  otDiscipulado: Accept := False; //Não é possível arrastar um discipulado

  otLivro: Accept := (TrvLivrosLicoes.Selected.Parent <> Target)
    and (GetNodeType(Target) in [otLivro, otDiscipulado])
    and (Target.Parent = TrvLivrosLicoes.Selected.Parent)
    and (Target <> TrvLivrosLicoes.Selected);

  otLicao: Accept := (TrvLivrosLicoes.Selected.Parent <> Target)
    and (GetNodeType(Target) in [otLivro, otLicao])
    and (Target <> TrvLivrosLicoes.Selected);
 end;
end;

function TFmeEIBooks.GetSelectedID: integer;
var
PEIObj: PEIObjects;
begin
 if TrvLivrosLicoes.Selected <> nil then
  begin
   PEIObj := TrvLivrosLicoes.Selected.Data;
   Result := PEIObj^.ECode;
  end
 else
  Result := -1; 
end;

function TFmeEIBooks.GetDiscipulado: string;
var
Node: TTreeNode;
begin
 if TrvLivrosLicoes.Selected <> nil then
  begin
   Node := GetDiscipuladoNode;
   if Node <> nil then
    Result := Node.Text;
  end
 else
  Result := '';  
end;

function TFmeEIBooks.GetDiscipuladoNode: TTreeNode;
var
Node: TTreeNode;
begin
 if TrvLivrosLicoes.Selected <> nil then
  begin
   Node := TrvLivrosLicoes.Selected;
    while Node.Level <> 0 do
     Node := Node.Parent;
   Result := Node;
  end
 else
  Result := nil; 
end;

function TFmeEIBooks.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

procedure TFmeEIBooks.SelectTreeItem;
begin
 if Assigned(OnSelectTreeItem) then
  OnSelectTreeItem(self);
end;

procedure TFmeEIBooks.ActNewBookExecute(Sender: TObject);
begin
 if not Assigned(FrmNovoLivrosEI) then
  FrmNovoLivrosEI := TFrmNovoLivrosEI.Create(Self);

 try
  FrmNovoLivrosEI.NewBook(GetNodeID(GetDiscipuladoNode),GetDiscipulado);

 finally
  if Assigned(FrmNovoLivrosEI) then
   FreeAndNil(FrmNovoLivrosEI);
 end;
end;

procedure TFmeEIBooks.ActDelBookExecute(Sender: TObject);
begin
//Exclui um livro da e.i.
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.LivrosEI, TCosmosConfMsg.DelLivroEI) = mrYes then
   begin
     if DoDeleteBook(GetSelectedID) then
      TrvLivrosLicoes.Items.Delete(TrvLivrosLicoes.Selected);
   end;
end;

procedure TFmeEIBooks.ActDelLessonExecute(Sender: TObject);
begin
//Exclui uma lição da e.i.
 if  ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.LivrosEI, TCosmosConfMsg.DelLicaoEI) = mrYes then
  if CanDeleteLesson(GetSelectedID) then
   begin
    if DoDeleteLesson(GetSelectedID) then
     TrvLivrosLicoes.Items.Delete(TrvLivrosLicoes.Selected);
   end
  else
   ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.LivrosEI, TCosmosErrorSecMsg.DeleteLessonEI);
end;

procedure TFmeEIBooks.ActEditBookExecute(Sender: TObject);
begin
 if not Assigned(FrmNovoLivrosEI) then
  FrmNovoLivrosEI := TFrmNovoLivrosEI.Create(Self);

 try
  FrmNovoLivrosEI.EdtDiscipulado.Text := GetDiscipulado;
  FrmNovoLivrosEI.EditBook(GetNodeID(GetDiscipuladoNode),GetSelectedID);

 finally
  if Assigned(FrmNovoLivrosEI) then
   FreeAndNil(FrmNovoLivrosEI);
 end;
end;

procedure TFmeEIBooks.SetPopUpMenu(const Value: boolean);
begin
  FHideMenu := Value;
  if FHideMenu = True then
   TrvLivrosLicoes.PopupMenu := nil
  else
   TrvLivrosLicoes.PopupMenu := PopupMenu;
end;

function TFmeEIBooks.GetNodeID(Node: TTreeNode): integer;
var
PEIObj: PEIObjects;
begin
 if Node <> nil then
  begin
   PEIObj := Node.Data;
   Result := PEIObj^.ECode;
  end
 else
  Result := -1;
end;

function TFmeEIBooks.GetNodeType(const Node: TTreeNode): ObjectType;
var
PEIObj: PEIObjects;
begin
 if Node = nil then
  Result := otNone
 else
  begin
   PEIObj := Node.Data;
   Result := PEIObj^.EType;
  end;
end;

end.
