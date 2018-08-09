unit cosmos.frames.PlanoContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, DB, DBClient, ActnList, Menus, ActnPopup, ActnMan,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  CommCtrl, cosmos.system.messages, PlatformDefaultStyleActnCtrls,
  cosmos.classes.application, System.Actions, Data.DBXCommon, Data.SqlExpr;

type
  TTipoConta = (tcCredito, tcDebito, tcNone);
  
  TConta = record
   codcon: integer;
   descon: string;
   desconing: string;
   tipcon: TTipoConta;
   indnac: boolean;
   codfoc: variant;
   nomfoc: string;
  end;

  PConta = ^TConta;

  TFmePlanoContas = class(TFrame)
    TrvContas: TTreeView;
    ImgTree: TImageList;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActNovaConta: TAction;
    ActAlterarConta: TAction;
    ActDelConta: TAction;
    PopupActionBar1: TPopupActionBar;
    NovaConta1: TMenuItem;
    AlterarConta1: TMenuItem;
    ExcluirConta1: TMenuItem;
    ActUpdateCount: TAction;
    N1: TMenuItem;
    AtualizarAqui1: TMenuItem;
    procedure TrvContasDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TrvContasDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TrvContasChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvContasChange(Sender: TObject; Node: TTreeNode);
    procedure ActAlterarContaUpdate(Sender: TObject);
    procedure ActDelContaExecute(Sender: TObject);
    procedure ActAlterarContaExecute(Sender: TObject);
    procedure ActNovaContaUpdate(Sender: TObject);
    procedure ActNovaContaExecute(Sender: TObject);
    procedure TrvContasDblClick(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActUpdateCountExecute(Sender: TObject);
    procedure ActUpdateCountUpdate(Sender: TObject);
  private
    { Private declarations }
    FCanEdit: boolean;
    function GetICosmosApp: ICosmosApplication;
    function GetIRemoteCon: ICosmosRemoteConnection;
    procedure SetCanEdit(const Value: boolean);

    function GetSelectedNodeID: variant; inline;
    function GetNodeID(Node: TTreeNode): variant; inline;
    function GetSelectedNodeType: TTipoConta; inline;
    function GetSelectedNodeText: string; inline;

    function GetSelectedItem: PConta;

  public
    { Public declarations }
    procedure ListarContas; overload;
    procedure ListarContas(const codcon: integer); overload;
    procedure ListarContas(Conta: TTreeNode); overload;

    procedure NovaConta;
    procedure EditarConta;
    procedure ExcluiConta;

    property CanEdit: boolean read FCanEdit write SetCanEdit;
    property SelectedItem: PConta read GetSelectedItem;
    property ICosmosApp: ICosmosApplication read GetICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon;
  end;

implementation

uses cosmos.frames.PlanoContas.FormEditarConta;

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

{ TFmePlanoContas }

procedure TFmePlanoContas.ListarContas;
var
Node: TTreeNode;
Conta: PConta;
ACommand: TDBXCommand;
aReader: TDBXReader;
begin
 ACommand := IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMFinanceiroMethods.GetContas'; //do not localize!
  ACommand.Prepare;

  ACommand.ExecuteUpdate;
  aReader := ACommand.Parameters.Parameter[0].Value.GetDBXReader(False);

  with TrvContas.Items do
   begin
    BeginUpdate;
    Clear;

    while aReader.Next do
     begin
      New(Conta);
      Conta.codcon := aReader.Value['codcon'].GetInt32;
      Conta.descon := aReader.Value['descon'].AsString;
      Conta.desconing := aReader.Value['desconing'].AsString;

      if aReader.Value['tipcon'].AsString = 'C' then
       Conta.tipcon := tcCredito
      else
       Conta.tipcon := tcDebito;

      Conta.indnac := aReader.Value['indnac'].AsString = 'S';

      if not aReader.Value['codfoc'].IsNull then
       begin
        Conta.codfoc := aReader.Value['codfoc'].GetInt32;
        Conta.nomfoc := aReader.Value['nomfoc'].AsString;
       end
      else
       begin
        Conta.codfoc := null;
        Conta.nomfoc := '';
       end;

      Node := TrvContas.Items.AddObject(nil, Conta.descon, Conta);

      if Conta.tipcon = tcCredito then
       Node.ImageIndex := 0
      else
       Node.ImageIndex := 1;

      Node.SelectedIndex := Node.ImageIndex;
     end;
   end;

 finally
  TrvContas.Items.EndUpdate;
 end;
end;

procedure TFmePlanoContas.NovaConta;
begin
 ActNovaConta.Execute;
end;

procedure TFmePlanoContas.ActAlterarContaExecute(Sender: TObject);
begin
  if not Assigned(FrmEditarConta) then
   FrmEditarConta := TFrmEditarConta.Create(self);

 try
  FrmEditarConta.EditarConta(GetSelectedNodeID);

 finally
  if Assigned(FrmEditarConta) then
   FreeAndNil(FrmEditarConta);
 end;
end;

procedure TFmePlanoContas.ActAlterarContaUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CanEdit) and (GetSelectedNodeType <> tcNone);
end;

procedure TFmePlanoContas.ActDelContaExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.PlanoContas,
       Format(TCosmosConfMsg.ConfDelConta, [self.GetSelectedNodeText])) = mrYes then
   begin
    ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMFinanceiroMethods.ExcluirConta'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetInt32(self.GetSelectedNodeID);
     ACommand.ExecuteUpdate;

     TrvContas.Selected.Delete;

    except
     on E: TDBXError do
      begin
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.PlanoContas, E.Message);
       ICosmosApp.MainLog.RegisterError(E.Message);
      end;
    end;
   end;
end;

procedure TFmePlanoContas.ActNovaContaExecute(Sender: TObject);
begin
  if not Assigned(FrmEditarConta) then
   FrmEditarConta := TFrmEditarConta.Create(self);

 try
  FrmEditarConta.NovaConta;

 finally
  if Assigned(FrmEditarConta) then
   FreeAndNil(FrmEditarConta);
 end;
end;

procedure TFmePlanoContas.ActNovaContaUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := CanEdit;
end;

procedure TFmePlanoContas.ActUpdateCountExecute(Sender: TObject);
begin
 self.ListarContas(TrvContas.Selected);
end;

procedure TFmePlanoContas.ActUpdateCountUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := TrvContas.Selected <> nil;
end;

procedure TFmePlanoContas.EditarConta;
begin
 ActAlterarConta.Execute;
end;

procedure TFmePlanoContas.ExcluiConta;
begin
 ActDelConta.Execute;
end;

function TFmePlanoContas.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

function TFmePlanoContas.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := Application.MainForm as ICosmosRemoteConnection;
end;

function TFmePlanoContas.GetNodeID(Node: TTreeNode): variant;
var
Conta: PConta;
begin
 if Node <> nil then
  begin
   Conta := Node.Data;
   Result := Conta.codcon;
  end
  else
   Result := unassigned;
end;

function TFmePlanoContas.GetSelectedItem: PConta;
begin
 if TrvContas.Selected <> nil then
  Result := TrvContas.Selected.Data
 else
  Result := nil;
end;

function TFmePlanoContas.GetSelectedNodeID: variant;
var
Conta: PConta;
begin
 if TrvContas.Selected <> nil then
  begin
   Conta := TrvContas.Selected.Data;
   Result := Conta.codcon;
  end
  else
   Result := unassigned;
end;

function TFmePlanoContas.GetSelectedNodeText: string;
begin
 Result := '';
 if TrvContas.Selected <> nil then
  Result := TrvContas.Selected.Text;
end;

function TFmePlanoContas.GetSelectedNodeType: TTipoConta;
var
Conta: PConta;
begin
 if TrvContas.Selected <> nil then
  begin
   Conta := TrvContas.Selected.Data;
   Result := Conta.tipcon
  end
  else
   Result := tcNone;
end;

procedure TFmePlanoContas.ListarContas(const codcon: integer);
var
Node: TTreeNode;
Conta: PConta;
aCommand: TDBXCommand;
aDataset: TSQLDataset;
begin

 aCommand := IRemoteCon.CreateCommand;

 try
  ACommand.Text := 'TDMFinanceiroMethods.GetSubContas'; //do not localize!
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.SetInt32(codcon);
  ACommand.ExecuteUpdate;

  ADataset := TSQLDataSet.Create(nil, ACommand.Parameters[1].Value.GetDBXReader(False), True);
  ADataset.Open;

  TrvContas.Items.BeginUpdate;
  TrvContas.Selected.DeleteChildren;

  while not ADataset.Eof do
    begin
      New(Conta);
      Conta.codcon := aDataset.Fields.FieldByName('codcon').AsInteger;
      Conta.descon := aDataset.Fields.FieldByName('descon').AsString;
      Conta.desconing := aDataset.Fields.FieldByName('desconing').AsString;

      if aDataset.Fields.FieldByName('tipcon').AsString = 'C' then
       Conta.tipcon := tcCredito
      else
       Conta.tipcon := tcDebito;

      Conta.indnac := aDataset.Fields.FieldByName('indnac').AsString = 'S';

      if not aDataset.Fields.FieldByName('codfoc').IsNull then
       begin
        Conta.codfoc := aDataset.Fields.FieldByName('codfoc').AsInteger;
        Conta.nomfoc := aDataset.Fields.FieldByName('nomfoc').AsString;
       end
      else
       begin
        Conta.codfoc := null;
        Conta.nomfoc := '';
       end;

      Node := TrvContas.Items.AddChildObject(TrvContas.Selected, Conta.descon, Conta);

      if Conta.tipcon = tcCredito then
       Node.ImageIndex := 0
      else
       Node.ImageIndex := 1;

      Node.SelectedIndex := Node.ImageIndex;
      aDataset.Next;
    end;

  if Assigned(aCommand) then FreeAndNil(aCommand);
  if Assigned(aDataset) then FreeAndNil(aDataset);
  TrvContas.Selected.Expand(True);
  TrvContas.Items.EndUpdate;

 except
  on E: Exception do
   begin
    if Assigned(aCommand) then FreeAndNil(aCommand);
    if Assigned(aDataset) then FreeAndNil(aDataset);
    TrvContas.Items.EndUpdate;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.PlanoContas, E.Message);
    ICosmosApp.MainLog.RegisterError(E.Message);
   end;
 end;
end;

procedure TFmePlanoContas.PopupActionBar1Popup(Sender: TObject);
begin
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFmePlanoContas.SetCanEdit(const Value: boolean);
begin
  FCanEdit := Value;
  if Value = False then
   begin
     TrvContas.PopupMenu := nil;
   end
  else
   begin
     TrvContas.PopupMenu := PopupActionBar1;
   end;
end;

procedure TFmePlanoContas.TrvContasChange(Sender: TObject; Node: TTreeNode);
begin
//Negrita o nó da árvore
  if Node <> nil then
   SetNodeBoldState(Node,True);
end;

procedure TFmePlanoContas.TrvContasChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  //Retira o negrito do nó
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFmePlanoContas.TrvContasDblClick(Sender: TObject);
begin
 if TrvContas.Selected <> nil then
  ListarContas(GetSelectedNodeID);
end;

procedure TFmePlanoContas.TrvContasDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
Selected, Node: TTreeNode;
aCommand: TDBXCommand;
begin
 Node := TrvContas.GetNodeAt(x, y);
 Selected := TrvContas.Selected;

 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.PlanoContas,
   Format(TCosmosConfMsg.MoverConta,[Selected.Text, Node.Text])) = mrYes  then

  begin
   aCommand := IRemoteCon.CreateCommand;

   try
    ACommand.Text := 'TDMFinanceiroMethods.MoverConta'; //do not localize!
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Prepare;

    ACommand.Parameters.Parameter[0].Value.SetInt32(GetNodeID(Selected));
    ACommand.Parameters.Parameter[1].Value.SetInt32(GetNodeID(Node));
    ACommand.ExecuteUpdate;

    Selected.MoveTo(Node, naAddChild);
    if Assigned(aCommand) then FreeAndNil(aCommand);

   except
    on E: Exception do
     begin
      if Assigned(aCommand) then FreeAndNil(aCommand);
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.PlanoContas, E.Message);
      ICosmosApp.MainLog.RegisterError(E.Message);
     end;
   end;
  end;
end;

procedure TFmePlanoContas.TrvContasDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
Node: TTreeNode;
begin
 Node := TrvContas.GetNodeAt(x, y);
 Accept := (TrvContas.Selected <> nil) and (Node <> nil)
  and (TrvContas.Selected <> Node) and (TrvContas.Selected.Parent <> Node);
end;

procedure TFmePlanoContas.ListarContas(Conta: TTreeNode);
begin
 if Conta <> nil then
  self.ListarContas(self.GetSelectedNodeID)
 else
  self.ListarContas;
end;

end.
