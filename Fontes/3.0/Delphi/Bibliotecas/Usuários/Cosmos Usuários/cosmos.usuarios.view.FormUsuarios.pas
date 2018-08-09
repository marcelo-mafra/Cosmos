unit cosmos.usuarios.view.FormUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, Cosmos.system.messages, ComCtrls,
  cosmos.classes.application, DB, DBClient, CommCtrl, ActnMan, Menus, ActnPopup,
  Cosmos.Framework.Interfaces.Dialogs, ExtCtrls, StdCtrls, DBCtrls, cosmos.frames.gridsearch,
  cosmos.system.winshell, PlatformDefaultStyleActnCtrls, cosmos.classes.ServerInterface,
  cosmos.framework.datanavigators.treeview, cosmos.Framework.Interfaces.DataAcess,
  Vcl.ToolWin, Vcl.ActnCtrls, System.Actions, Data.DBXCommon, Datasnap.DSConnect,
  cosmos.system.formsconst;

type
  TNodeType = (ntUsers, ntUser, ntUnknown);
  TCosmosUser = record
    codusu: integer;
    codcad: integer;
    indblo: boolean;
    indati: boolean;
    indadm: boolean;
    enabled: boolean;
    tipnod: TNodeType;
  end;

  PCosmosUser = ^TCosmosUser;

  TFrmUsuarios = class(TFrmCosmosDocked)
    TrvUsers: TTreeView;
    ImgTree: TImageList;
    ActNovoUsuario: TAction;
    ActDelUsuario: TAction;
    PopupActionBar1: TPopupActionBar;
    NovoUsurio1: TMenuItem;
    ExcluirUsurio1: TMenuItem;
    ActBloquear: TAction;
    BloquearUsurio1: TMenuItem;
    ActDesbloquear: TAction;
    DesbloquearUsurio1: TMenuItem;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    DBText1: TDBText;
    CdsUsuario: TClientDataSet;
    DsrUsuario: TDataSource;
    CdsFocosUsuario: TClientDataSet;
    DsrFocosUsuario: TDataSource;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    Label2: TLabel;
    Image1: TImage;
    ActAddFocos: TAction;
    ActDelFocos: TAction;
    PopupActionBar2: TPopupActionBar;
    AdicionarFocos1: TMenuItem;
    ExcluirUsurio2: TMenuItem;
    ActPerfis: TAction;
    Grupos1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ActResetPassword: TAction;
    AlterarSenha1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActEditFoco: TAction;
    AlterarPermisso1: TMenuItem;
    N3: TMenuItem;
    ActSetAdministrator: TAction;
    ActUnsetAdministrator: TAction;
    procedure ActNovoUsuarioUpdate(Sender: TObject);
    procedure ActResetPasswordUpdate(Sender: TObject);
    procedure ActResetPasswordExecute(Sender: TObject);
    procedure ActPerfisExecute(Sender: TObject);
    procedure ActAddFocosUpdate(Sender: TObject);
    procedure ActDelFocosUpdate(Sender: TObject);
    procedure ActDelFocosExecute(Sender: TObject);
    procedure ActAddFocosExecute(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2MouseLeave(Sender: TObject);
    procedure ActDesbloquearUpdate(Sender: TObject);
    procedure ActDesbloquearExecute(Sender: TObject);
    procedure ActBloquearUpdate(Sender: TObject);
    procedure ActBloquearExecute(Sender: TObject);
    procedure TrvUsersChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvUsersChange(Sender: TObject; Node: TTreeNode);
    procedure ActDelUsuarioUpdate(Sender: TObject);
    procedure ActDelUsuarioExecute(Sender: TObject);
    procedure ActNovoUsuarioExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActEditFocoExecute(Sender: TObject);
    procedure ActSetAdministratorExecute(Sender: TObject);
    procedure ActUnsetAdministratorExecute(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActSetAdministratorUpdate(Sender: TObject);
    procedure ActUnsetAdministratorUpdate(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TTreeViewDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    procedure DoListUsers(Dataset: TDataset);
    procedure ListUsers;
    procedure ListConnectedUser;
    procedure ListUserData(const codcad: integer);
    function GetSelectedUserLogin: string; inline;
    function GetCosmosUser: PCosmosUser;
    procedure UpdateData(Sender: TObject);
    procedure CheckAdministrator; inline;
    function DoGrantAdministrator(const Value: boolean): boolean;

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
    property CosmosUser: PCosmosUser read GetCosmosUser;
  end;

var
  FrmUsuarios: TFrmUsuarios;

implementation

uses cosmos.usuarios.view.FormUserRoles, cosmos.usuarios.view.FormAddFoco;

{$R *.dfm}

{ TFrmUsuarios }

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

procedure TFrmUsuarios.ActAddFocosExecute(Sender: TObject);
var
codusu: integer;
begin
 inherited;
 CheckAdministrator;

 if (CosmosUser = nil) or (CosmosUser.tipnod <> ntUser) then
  Exit;

 FrmAddFoco := TFrmAddFoco.Create(nil);

 try
  codusu := CosmosUser.codusu;
  FrmAddFoco.InsertAcessedFocus(codusu);
  FrmAddFoco.ShowModal;

 finally
  if Assigned(FrmAddFoco) then
   FreeAndNil(FrmAddFoco);
 end;
end;

procedure TFrmUsuarios.ActAddFocosUpdate(Sender: TObject);
begin
  inherited;
  TAction(sender).Enabled := (CdsFocosUsuario.Active) and (CosmosUser <> nil) and
   (CosmosUser.tipnod = ntUser) and (IRemoteCon.CurrentUser.Administrator = True);
end;

procedure TFrmUsuarios.ActBloquearExecute(Sender: TObject);
var
PUser: PCosmosUser;
ACommand: TDBXCommand;
begin
  inherited;
  CheckAdministrator;

  if (CosmosUser = nil) or (CosmosUser.tipnod in [ntUnknown, ntUsers]) then
   Exit;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Users, Format(TCosmosConfMsg.LockUser, [TrvUsers.Selected.Text])) = mrYes then
   begin
    ACommand := IRemoteCon.CreateCommand;

    try
      ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
      ACommand.Text := 'TDMUserMethods.LockUser'; //do not localize!
      ACommand.Prepare;

      ACommand.Parameters[0].Value.SetInt32(CosmosUser.codusu);
      ACommand.ExecuteUpdate;

      if ACommand.Parameters[2].Value.GetBoolean = True then
        begin
         PUser := TrvUsers.Selected.Data;
         PUser.indblo := True;
         TrvUsers.Selected.ImageIndex := 2;
         TrvUsers.Selected.SelectedIndex := TrvUsers.Selected.ImageIndex;
        end;

      ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
      ACommand.Free;

    except
     on E: Exception do
      begin
       ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
       if Assigned(ACommand) then FreeAndNil(ACommand);
      end;
    end;
   end;
end;

procedure TFrmUsuarios.ActBloquearUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CosmosUser <> nil) and
    (IRemoteCon.CurrentUser.Administrator = True) and not (CosmosUser.indblo);
end;

procedure TFrmUsuarios.ActResetPasswordExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
 ANewPassword: string;
begin
  inherited;
  {Altera a senha do usuário corrente.}
 CheckAdministrator;

 if (CosmosUser = nil) or (CosmosUser.tipnod <> ntUser) then
   Exit;

 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Users, Format(TCosmosConfMsg.ResetPassword, [self.GetSelectedUserLogin])) = mrYes then
  begin
    ACommand := IRemoteCon.CreateCommand;

    try
      ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
      ACommand.Text := 'TDMUserMethods.ResetPassword'; //do not localize!
      ACommand.Prepare;

      ACommand.Parameters[0].Value.SetInt32(CosmosUser.codusu);
      ACommand.ExecuteUpdate;

      ANewPAssword := ACommand.Parameters[1].Value.GetWideString;
      ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, Format(TCosmosInfoMsg.ResetedPassword, [GetSelectedUserLogin, ANewPassword]));

      ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
      if Assigned(ACommand) then FreeAndNil(ACommand);

    except
     ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
  end;
end;

procedure TFrmUsuarios.ActResetPasswordUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CosmosUser <> nil) and (CosmosUser.tipnod = ntUser)
   and (CosmosUser.indati)
   and (IRemoteCon.CurrentUser.Administrator = True);
end;

procedure TFrmUsuarios.ActDelFocosExecute(Sender: TObject);
var
 AParams: TSQLParams;
 sNomfoc: string;
begin
  inherited;
  if (CosmosUser = nil) or (CosmosUser.tipnod <> ntUser) and not (CdsFocosUsuario.Active)
   and (CdsFocosUsuario.IsEmpty) then
   Exit;

  CheckAdministrator;

  sNomfoc := CdsFocosUsuario.Fields.FieldByName('nomfoc').AsString;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Permissoes, Format(TCosmosConfMsg.DelPrivilegioFoco,
          [sNomfoc, TrvUsers.Selected.Text])) = mrYes then
    begin
     AParams := TSQLParams.Create(1);

     try
      AParams.AppendData(CdsFocosUsuario.Fields.FieldByName('codpri').AsInteger);
      if ICosmosApp.IRemoteCon.ExecuteCommand(ccDeleteFocoUsuario, AParams.Params) then
       CdsFocosUsuario.Refresh;

     finally
      if Assigned(AParams) then
       FreeAndNil(AParams);
     end;
   end;
end;

procedure TFrmUsuarios.ActDelFocosUpdate(Sender: TObject);
begin
  inherited;
  TAction(sender).Enabled := (CdsFocosUsuario.Active) and not (CdsFocosUsuario.IsEmpty)
  and (IRemoteCon.CurrentUser.Administrator = True);
end;

procedure TFrmUsuarios.ActDelUsuarioExecute(Sender: TObject);
var
ACommand: TDBXCommand;
begin
  inherited;
  {Exlui o usuário selecionado...}
  CheckAdministrator;

  if (CosmosUser = nil) or (CosmosUser.tipnod in [ntUnknown, ntUsers]) then
   Exit;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Users, Format(TCosmosConfMsg.DeleteUsuario, [TrvUsers.Selected.Text])) = mrYes then
   begin
    ACommand := IRemoteCon.CreateCommand;

    try
      ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
      ACommand.Text := 'TDMUserMethods.DeleteUser'; //do not localize!
      ACommand.Prepare;

      ACommand.Parameters[0].Value.SetInt32(CosmosUser.codusu);
      ACommand.ExecuteUpdate;

      TrvUsers.Selected.Delete;

      ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
      if Assigned(ACommand) then FreeAndNil(ACommand);

    except
     ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   end;
end;

procedure TFrmUsuarios.ActDelUsuarioUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CosmosUser <> nil) and (CosmosUser.tipnod = ntUser)
   and (IRemoteCon.CurrentUser.Administrator = True);
end;

procedure TFrmUsuarios.ActDesbloquearExecute(Sender: TObject);
var
ACommand: TDBXCommand;
PUser: PCosmosUser;
begin
  inherited;
  if (CosmosUser = nil) or (CosmosUser.tipnod in [ntUnknown, ntUsers]) then
   Exit;

  CheckAdministrator;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Users, Format(TCosmosConfMsg.LockUser, [TrvUsers.Selected.Text])) = mrYes then
   begin
    ACommand := IRemoteCon.CreateCommand;

    try
      ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
      ACommand.Text := 'TDMUserMethods.UnlockUser'; //do not localize!
      ACommand.Prepare;

      ACommand.Parameters[0].Value.SetInt32(CosmosUser.codusu);
      ACommand.ExecuteUpdate;

      if ACommand.Parameters[1].Value.GetBoolean = True then
       begin
        PUser := TrvUsers.Selected.Data;
        PUser.indati := True;
        TrvUsers.Selected.ImageIndex := 1;
        TrvUsers.Selected.SelectedIndex := TrvUsers.Selected.ImageIndex;
       end;

      ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
      if Assigned(ACommand) then FreeAndNil(ACommand);

    except
     ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   end;
end;

procedure TFrmUsuarios.ActDesbloquearUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CosmosUser <> nil) and (CosmosUser.tipnod = ntUser)
   and (IRemoteCon.CurrentUser.Administrator = True) and (CosmosUser.indblo);
end;

procedure TFrmUsuarios.ActEditFocoExecute(Sender: TObject);
var
codusu, codpri: integer;
begin
 inherited;
 CheckAdministrator;

 if (CosmosUser = nil) or (CosmosUser.tipnod <> ntUser) then
  Exit;

 FrmAddFoco := TFrmAddFoco.Create(nil);

 try
  codusu := CosmosUser.codusu;
  codpri := CdsFocosUsuario.Fields.FieldByName('codpri').AsInteger;
  FrmAddFoco.EditAcessedFocus(codusu, codpri);
  FrmAddFoco.ShowModal;

 finally
  if Assigned(FrmAddFoco) then
   FreeAndNil(FrmAddFoco);
 end;
end;

procedure TFrmUsuarios.ActPerfisExecute(Sender: TObject);
var
ACommand: TDBXCommand;
begin
  inherited;
  if (CosmosUser = nil) or (CosmosUser.tipnod <> ntUser) then
   Exit;

  CheckAdministrator;

  FrmUsersRoles := TFrmUsersRoles.Create(self);

  try
   if FrmUsersRoles.ListUserRoles(CdsUsuario.FieldValues['NOMCAD'], GetSelectedUserLogin) = mrOk then
     begin
      ACommand := IRemoteCon.CreateCommand;

      try
       ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
       ACommand.Text := 'TDMUserMethods.GrantRoles'; //do not localize!
       ACommand.Prepare;

       ACommand.Parameters[0].Value.SetWideString(GetSelectedUserLogin);
       ACommand.Parameters[1].Value.SetWideString(FrmUsersRoles.AddedRoles);
       ACommand.ExecuteUpdate;

       ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
       if Assigned(ACommand) then FreeAndNil(ACommand);

      except
       ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
       if Assigned(ACommand) then FreeAndNil(ACommand);
      end;
     end;

  finally
   if Assigned(FrmUsersRoles) then FreeAndNil(FrmUsersRoles);
  end;
end;

procedure TFrmUsuarios.ActSetAdministratorExecute(Sender: TObject);
var
PUser: PCosmosUser;
begin
  inherited;
  CheckAdministrator;

  if (CosmosUser = nil) or (CosmosUser.tipnod in [ntUnknown, ntUsers]) then
   Exit;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Users, Format(TCosmosConfMsg.SetAdministrator, [TrvUsers.Selected.Text])) = mrYes then
   begin
    if DoGrantAdministrator(True) then
     begin
      PUser := TrvUsers.Selected.Data;
      PUser.indadm := True;
      TrvUsers.Selected.ImageIndex := 2;
      TrvUsers.Selected.SelectedIndex := TrvUsers.Selected.ImageIndex;
     end;
   end;
end;

procedure TFrmUsuarios.ActSetAdministratorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CosmosUser <> nil) and (CosmosUser.tipnod = ntUser)
   and (CosmosUser.indadm = False)
   and (IRemoteCon.CurrentUser.Administrator = True);
end;

procedure TFrmUsuarios.ActUnsetAdministratorExecute(Sender: TObject);
var
PUser: PCosmosUser;
begin
  inherited;
  CheckAdministrator;

  if (CosmosUser = nil) or (CosmosUser.tipnod in [ntUnknown, ntUsers]) then
   Exit;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Users, Format(TCosmosConfMsg.UnsetAdministrator, [TrvUsers.Selected.Text])) = mrYes then
   begin
    if DoGrantAdministrator(False) then
     begin
      PUser := TrvUsers.Selected.Data;
      PUser.indadm := False;
      TrvUsers.Selected.ImageIndex := 2;
      TrvUsers.Selected.SelectedIndex := TrvUsers.Selected.ImageIndex;
     end;
   end;
end;

procedure TFrmUsuarios.ActUnsetAdministratorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CosmosUser <> nil) and (CosmosUser.tipnod = ntUser)
   and (CosmosUser.indadm = True)
   and (IRemoteCon.CurrentUser.Administrator = True);
end;

procedure TFrmUsuarios.ActNovoUsuarioExecute(Sender: TObject);
begin
  inherited;
  CheckAdministrator;

  if ICosmosApp.ExecuteWizard('newuser.bpl', 'TFrmWizardNovoUsuario') then
   ListUsers;
end;

procedure TFrmUsuarios.ActNovoUsuarioUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ICosmosApp.IRemoteCon.CurrentUser.Administrator = True);
end;

function TFrmUsuarios.DoGrantAdministrator(const Value: boolean): boolean;
var
 ACommand: TDBXCommand;
begin
 Result := False;
 ACommand := IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMUserMethods.GrantAdministrator'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(CosmosUser.codusu);
  ACommand.Parameters[1].Value.SetBoolean(True);
  ACommand.ExecuteUpdate;

  Result := True;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
  if Assigned(ACommand) then FreeAndNil(ACommand);

 except
  ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
  if Assigned(ACommand) then FreeAndNil(ACommand);
 end;
end;

procedure TFrmUsuarios.DoListUsers(Dataset: TDataset);
var
UsersNode, Node: TTreeNode;
PUser: PCosmosUser;
begin
{Lista os usuários contidos no dataset em uma árvore.}
 try
  TrvUsers.Items.BeginUpdate;
  TrvUsers.Items.Clear;
  New(PUser);
  PUser.codusu := 0;
  PUser.codcad := 0;
  PUser.indati := False;
  PUSer.indblo := False;
  PUser.indadm := False;
  PUser.tipnod := ntUsers;
  UsersNode := TrvUsers.Items.AddObject(nil, 'Usuários', PUser);
  UsersNode.ImageIndex := 0;
  UsersNode.SelectedIndex := UsersNode.ImageIndex;

   with Dataset do
    begin
     while not EOF do
      begin
       New(PUser);
       PUser.codusu := Fields.FieldByName('codusu').AsInteger;
       PUser.codcad := Fields.FieldByName('codcad').AsInteger;
       PUser.indati := TrimRight(Fields.FieldByName('indati').AsString) = 'S';
       PUser.indblo := TrimRight(Fields.FieldByName('indblo').AsString) = 'S';
       PUser.indadm := TrimRight(Fields.FieldByName('indadm').AsString) = 'S';

       outputdebugstring(PWideChar(TrimRight(Fields.FieldByName('indadm').AsString)));

       PUser.tipnod := ntUser;
       PUser.enabled := ICosmosApp.IRemoteCon.CurrentUser.Administrator;
       Node := TrvUsers.Items.AddChildObject(UsersNode, Trim(Fields.FieldByName('logusu').AsString), PUser);

       Node.ImageIndex := -1;

       if (PUser.indati = True) and (PUser.indblo = False) then //Usuário ativo e habilitado
         Node.ImageIndex := 1;

       if (PUser.indati = True) and (PUser.indadm = True) then //Usuário ativo e administrador
         Node.ImageIndex := 2;

       if (PUser.indati = True) and (PUser.indblo = True) then //Usuário ativo e bloqueado
         Node.ImageIndex := 3;

       if (PUser.indati = False) then //Usuário inativo
         Node.ImageIndex := 4;

       if Node.ImageIndex = -1 then
        Node.ImageIndex := 5;

       Node.SelectedIndex := Node.ImageIndex;
       Next;
      end;
    end;

 finally
  TrvUsers.FullExpand;
  TrvUsers.Items.EndUpdate;
 end;
end;

procedure TFrmUsuarios.ExportData;
begin
 IRemoteCon.DefaultExport(CdsFocosUsuario);
end;

procedure TFrmUsuarios.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsFocosUsuario;
end;

procedure TFrmUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  inherited;

  Action := caFree;
  FrmUsuarios := nil;
end;

procedure TFrmUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scUsuarios);
  CdsUsuario.RemoteServer := FRemoteConnection;
  CdsFocosUsuario.RemoteServer := FRemoteConnection;

  FDataNavigator := TTreeViewDataNavigator.Create(TrvUsers);
  DataNavigator := FDataNavigator;
  TTreeViewDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  if ICosmosApp.IRemoteCon.CurrentUser.Administrator then
   ListUsers
  else
   begin
    self.CdsFocosUsuario.ReadOnly := True;
    ListConnectedUser;
   end;
end;

function TFrmUsuarios.GetCosmosUser: PCosmosUser;
begin
 if TrvUsers.Selected <> nil then
   Result := TrvUsers.Selected.Data
 else
  Result := nil;
end;

function TFrmUsuarios.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormCosmosUsers;
end;

function TFrmUsuarios.GetFormIDName: string;
begin
 Result := 'GestorUsuarios.CosmosUsers';
end;

function TFrmUsuarios.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmUsuarios.GetHelpID: integer;
begin
 Result := Self.HelpContext;
end;

function TFrmUsuarios.GetSelectedUserLogin: string;
begin
 if TrvUsers.Selected <> nil then
  Result := TrvUsers.Selected.Text
 else
  Result := ''; 
end;

function TFrmUsuarios.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmUsuarios.Label2Click(Sender: TObject);
var
 AModule: HModule;
 AForm: TForm;
 IFicha: ICosmosFicha;
begin
 inherited;
 if (CosmosUser = nil) or (CosmosUser.tipnod <> ntUser) then
  Exit;
 
 try
  AForm := ICosmosApp.LoadDialog('ficha.bpl', 'TFrmFicha', AModule);
  if (AModule <> 0) and (AForm <> nil) then
  begin
     with AForm do
      begin
       if Supports(AForm, ICosmosFicha) then
        IFicha := AForm as ICosmosFicha;
       if Assigned(IFicha) then
         IFicha.SearchFicha(UpperCase(GetSelectedUserLogin));
       Free;
      end;
  end;

 finally
  if Assigned(IFicha) then
   IFicha := nil;
  UnloadPackage(AModule);
 end;
end;

procedure TFrmUsuarios.Label2MouseLeave(Sender: TObject);
begin
  inherited;
  TLabel(Sender).Font.Style :=   TLabel(Sender).Font.Style - [fsUnderline];
end;

procedure TFrmUsuarios.Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  TLabel(Sender).Font.Style :=   TLabel(Sender).Font.Style + [fsUnderline];
end;

procedure TFrmUsuarios.ListConnectedUser;
var
CdsData: TClientDataset;
begin
{Lista o usuário conectado em uma treeview. Isto acontece se ele nã ofor um
 administrador do sistema cosmos.}
 CdsData := TClientDataset.Create(self);

 try
  IRemoteCon.ExecuteDQL(csCosmosUsers, null, CdsData);

  if CdsData.Active then
   begin
    CdsData.Filter := 'logusu = ' + QuotedStr(IRemoteCon.CurrentUser.Login);
    CdsData.Filtered := True;
    self.DoListUsers(CdsData);
   end;

 finally
  if Assigned(CdsData) then FreeAndNil(CdsData);
 end;
end;

procedure TFrmUsuarios.ListUserData(const codcad: integer);
begin
//Lista os dados do usuário cujo código é passado em parâmetro.
 CdsUsuario.DisableControls;
 CdsFocosUsuario.DisableControls;

 try
  if CdsUsuario.Active then CdsUsuario.Close;
  if CdsFocosUsuario.Active then CdsFocosUsuario.Close;

  CdsUsuario.Params.Items[0].Value := codcad;
  CdsFocosUsuario.Params.Items[0].Value := codcad;

  CdsUsuario.Open;
  CdsFocosUsuario.Open;

 finally
  CdsUsuario.EnableControls;
  CdsFocosUsuario.EnableControls;
 end;
end;

procedure TFrmUsuarios.ListUsers;
var
CdsData: TClientDataset;
begin
//Lista os usuários registrados no Cosmos em uma treeview.
 CdsData := TClientDataset.Create(self);

 try
  IRemoteCon.ExecuteDQL(csCosmosUsers, null, CdsData);

  if CdsData.Active then
   self.DoListUsers(CdsData);

 finally
  if Assigned(CdsData) then FreeAndNil(CdsData);
 end;
end;

procedure TFrmUsuarios.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmUsuarios.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmUsuarios.TrvUsersChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
//Negrita o nó da árvore
  if CosmosUser = nil then
   Exit;

  if Node <> nil then
   SetNodeBoldState(Node,True);

  case CosmosUser.tipnod of
   ntUsers: Exit;
   ntUser:  ListUserData(CosmosUser.codcad);
  end;
end;

procedure TFrmUsuarios.TrvUsersChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  inherited;
  //Retira o negrito do nó
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmUsuarios.UpdateData(Sender: TObject);
begin
  inherited;
  self.ListUsers;
end;


procedure TFrmUsuarios.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmUsuarios.CheckAdministrator;
begin
 //Checa se um usuário é administrador do sistema. Em negativo, aborta a operação.
  if ICosmosApp.IRemoteCon.CurrentUser.Administrator = False then
  begin
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosErrorMsg.AdmPrivelegies);
    Abort;
  end;
end;

initialization
 RegisterClass(TFrmUsuarios);

finalization
 UnRegisterClass(TFrmUsuarios);

end.
