unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, ServerConnections, ComCtrls,
  ImgList, XPMan;

const
 FCodeKey = '89533692230'; //Chave usada para criptografia interna

type
  TConnectionID = TGUID;

  TListThread = class(TThread)
  private
    procedure RefreshUserList;

  protected
   procedure Execute; override;

  public
   constructor Create;
   destructor destroy; override;

  end;

  TFrmMain = class(TForm)
    PopupMenu1: TPopupMenu;
    MnLogs: TMenuItem;
    Propriedades1: TMenuItem;
    BtnLogs: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    LblClientsCount: TLabel;
    ImgIcon: TImage;
    LblStartTime: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LblServerHost: TLabel;
    CManager: TConnectionsManager;
    Button2: TButton;
    LsvConnections: TListView;
    Button3: TButton;
    ImageList1: TImageList;
    Bevel3: TBevel;
    XPManifest1: TXPManifest;
    MnLockServer: TMenuItem;
    ImageList32: TImageList;
    LblStatus: TLabel;
    MnLockUsers: TMenuItem;
    N1: TMenuItem;
    MnAdministrador: TMenuItem;
    MnCloseSection: TMenuItem;
    N2: TMenuItem;
    Label4: TLabel;
    LblLimite: TLabel;
    TrayIcon: TTrayIcon;
    MnConfigurations: TMenuItem;
    ImgAnimation: TImageList;
    procedure MnConfigurationsClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure MnCloseSectionClick(Sender: TObject);
    procedure MnAdministradorClick(Sender: TObject);
    procedure CManagerGetAdminPassword(Sender: TObject; var Login,
      passwrd: string);
    procedure LsvConnectionsInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure CManagerRegisterConnection(Sender: TObject);
    procedure CManagerUnLockServer(Sender: TObject);
    procedure CManagerLockServer(Sender: TObject);
    procedure MnLockServerClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MnLogsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateData;
    procedure UpdateIcons; inline;
    procedure SetLockedUsers;
    procedure DoEnableControls(const Value: boolean);
    procedure SetAdminPassword;
    function MinimizeToTray(Handle: HWND): Boolean;    


  public
    { Public declarations }
    function RegisterConnection(const UserName, Group, Source,
      AditionalInfo: string): TGUID;
    procedure UnregisterConnection(ID: TConnectionID);
    function ConnectionIsLocked(const ID: TConnectionID): boolean;
    function UserIsLocked(const User: string): boolean;
    procedure ShowMessageDlg(const Text: string);
  end;

var
  FrmMain: TFrmMain;

implementation

uses cosmos.core.winshell, cosmos.core.constantesmsg, FormAdmLogin,
  cosmos.core.cripter, cosmos.framework.forms.mydialogs;

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
 SetLockedUsers;
 CManager.OnUnLockServer(self);
 Caption := CManager.ServerName;
 LblServerHost.Caption := CManager.ServerHost;
 LblStartTime.Caption := DateTimeToStr(CManager.StartTime);
end;


procedure TFrmMain.UpdateData;
begin
 case CManager.ConnectionsCount of
  0: TrayIcon.BalloonHint := sNoActiveConnection;
  1: TrayIcon.BalloonHint := sOneConnectedUser;
  else
  TrayIcon.BalloonHint := Format(sConnectedUsers, [CManager.ConnectionsCount]);
 end;
 TrayIcon.BalloonTitle := Application.Title;

 TrayIcon.Hint := Application.Title;
 LblClientsCount.Caption := IntToStr(CManager.ConnectionsCount);
 TrayIcon.ShowBalloonHint;
end;

procedure TFrmMain.MnLogsClick(Sender: TObject);
var
 lEXEName: string;
begin
//Acessa os logs no computador local
 lEXEName := TShellFolders.GetSysDir + 'eventvwr.exe';
 TWinShell.OpenProgram(lEXEName,'');
end;

procedure TFrmMain.MnConfigurationsClick(Sender: TObject);
var
FileName: string;
begin
 FileName := TShellFolders.GetSysDir + 'fbconf.cpl';
 TWinShell.ExecuteControlPanel(FileName);
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose := False;
 FrmMain.Hide;
end;

procedure TFrmMain.UnregisterConnection(ID: TConnectionID);
var
ListThread: TListThread;
begin
 ListThread := TListThread.Create;
 CManager.UnRegisterConnection(ID);
 ListThread.Destroy;
end;

function TFrmMain.RegisterConnection(const UserName, Group,
  Source, AditionalInfo: string): TGUID;
var
ListThread: TListThread;
Info: TStringList;
begin
//Registra a conexão feita e retorna o ID da conexão criada.
 ListThread := TListThread.Create;
 if AditionalInfo <> '' then
  Info := TStringList.Create;
 Info.CommaText := AditionalInfo;
 Result := CManager.RegisterConnection(UserName, Group, Source, Info);
 ListThread.Destroy;
end;

procedure TFrmMain.Button3Click(Sender: TObject);
begin
Close;
end;

procedure TFrmMain.MnLockServerClick(Sender: TObject);
begin
 if not CManager.AdminMode then
  exit;
 if CManager.Locked then
  CManager.Locked := False
 else
  begin
   if CManager.Locked = False then
    if TMyDialogs.ConfirmMessage(sConfLockServer) = IDYes then
     CManager.Locked := True;
  end;

 TMenuItem(Sender).Checked := CManager.Locked;
end;

procedure TFrmMain.CManagerLockServer(Sender: TObject);
begin
 ImageList32.GetIcon(0, Application.Icon);
 LblStatus.Caption := Format(sServerLocked, [CManager.ServerName]);
 UpdateIcons;
end;

procedure TFrmMain.CManagerUnLockServer(Sender: TObject);
begin
 ImageList32.GetIcon(1, Application.Icon);
 LblStatus.Caption := Format(sServerFree, [CManager.ServerName]);
 UpdateIcons;
end;

procedure TFrmMain.UpdateIcons;
begin
 ImgIcon.Picture.Icon := Application.Icon;
 TrayIcon.Icon := Application.Icon;
end;

procedure TListThread.RefreshUserList;
var
I: integer;
Item: TListItem;
Connection: TConnectionItem;
begin
 try
  with FrmMain do
   begin
    LsvConnections.Items.BeginUpdate;
    LsvConnections.Clear;
    for I := 0 to Pred(CManager.ConnectionsCount) do
     begin
      Item := LsvConnections.Items.Add;
      Connection := CManager.ServerConnections.Items[I];
      Item.Caption := Connection.UserName;
      Item.SubItems.Add(Connection.Group);
      Item.SubItems.Add(Connection.Source);
      Item.SubItems.Add(DateTimeToStr(Connection.StartTime));
      Item.SubItems.Add(Connection.IDAsString);
      Item.ImageIndex := 0;
      Item.OverlayIndex := Item.ImageIndex;
     end;
   end;

 finally
  FrmMain.LsvConnections.Items.EndUpdate;
 end;
end;

{ TListThread }

procedure TListThread.Execute;
begin
 inherited Create(False);
end;

constructor TListThread.Create;
begin
 inherited Create(False);
end;

destructor TListThread.destroy;
begin
 synchronize(RefreshUserList);
 inherited Destroy;
end;

procedure TFrmMain.CManagerRegisterConnection(Sender: TObject);
begin
 UpdateData;
end;

procedure TFrmMain.LsvConnectionsInfoTip(Sender: TObject; Item: TListItem;
  var InfoTip: string);
const
s: string = 'Nome: %s (%s)' + #13 + 'Matrícula: %s' + #13 + 'Foco: %s';
var
cl: TConnectionItem;
begin
 if Item <> nil then
  begin
   cl := CManager.ServerConnections.FindItemByID(StringToGUID(Item.SubItems.Strings[3]));
   if Cl <> nil then
    InfoTip :=
     Format(s, [cl.AditionalInfo.Values['USER_NAME'],
      cl.AditionalInfo.Values['DISCIPULADO'],
      cl.AditionalInfo.Values['MATRICULA'],
      cl.AditionalInfo.Values['FOCO']]);
  end;
end;

function TFrmMain.ConnectionIsLocked(const ID: TConnectionID): boolean;
var
cl: TConnectionItem;
begin
//Retorna se a conexão com identificador passada em parâmetro está bloqueada
 Result := True; //Bloqueia, a princípio
 cl := CManager.ServerConnections.FindItemByID(ID);
 if Cl <> nil then
  Result := cl.Locked;
end;

function TFrmMain.UserIsLocked(const User: string): boolean;
begin
//Checa se um determinado usuário está bloqueado
 Result := CManager.UserIsLocked(User);
end;

procedure TFrmMain.SetLockedUsers;
begin
//Obtém a lista de usuários bloqueados
end;

procedure TFrmMain.ShowMessageDlg(const Text: string);
begin
 ShowMessage(Text);
end;

procedure TFrmMain.TrayIconDblClick(Sender: TObject);
begin
 FrmMain.Show;
end;

procedure TFrmMain.CManagerGetAdminPassword(Sender: TObject; var Login,
  passwrd: string);
var
Cript: TCripter;
begin
 try
  if not Assigned(FrmAdmLogin) then
   FrmAdmLogin := TFrmAdmLogin.Create(self);
  if FrmAdmLogin.ShowModal = mrOk then
   begin
    SetAdminPassword;
    Cript := TCripter.Create;
    with Cript do
     begin
      Key := FCodeKey;
      Model := cmRDL256;
      Login := Encrypt(FrmAdmLogin.EdtName.Text);
      Passwrd := Encrypt(FrmAdmLogin.EdtPassword.Text);
     end;
   end
  else
   Abort;

 finally
  if Assigned(Cript) then
   FreeAndNil(Cript);
  if Assigned(FrmAdmLogin) then
   FreeAndNil(FrmAdmLogin);
 end;
end;

function TFrmMain.MinimizeToTray(Handle: HWND): Boolean;
var  
  hwndTray: HWND;
  rcWindow: TRect;
  rcTray: TRect;
begin
  // Check passed window handle
  if IsWindow(Handle) then
  begin
    // Get tray handle
    hwndTray := FindWindowEx(FindWindow('Shell_TrayWnd', nil), 0, 'TrayNotifyWnd', nil);
    // Check tray handle
    if (hwndTray = 0) then
      // Failure
      Result := False
    else
    begin
      // Get window rect and tray rect
      GetWindowRect(Handle, rcWindow);
      GetWindowRect(hwndTray, rcTray);
      // Perform the animation
      DrawAnimatedRects(Handle, IDANI_CAPTION, rcWindow, rcTray);
      // Hide the window
      ShowWindow(Handle, SW_HIDE);
    end;
  end
  else
    // Failure
    Result := False;

end;

procedure TFrmMain.MnAdministradorClick(Sender: TObject);
begin
 CManager.AdminMode := True;
 DoEnableControls(CManager.AdminMode);
end;

procedure TFrmMain.DoEnableControls(const Value: boolean);
begin
 MnLockServer.Enabled := Value;
 MnLockUsers.Enabled := Value;
 MnLogs.Enabled := Value;
 BtnLogs.Enabled := Value;
 MnCloseSection.Enabled := CManager.AdminMode = True;
end;

procedure TFrmMain.MnCloseSectionClick(Sender: TObject);
begin
 CManager.AdminMode := False;
 DoEnableControls(CManager.AdminMode);
end;

procedure TFrmMain.SetAdminPassword;
var
Cript: TCripter;
begin
//Escreve login e senha do administrador do servidor
 try
  Cript := TCripter.Create;
  with Cript do
   begin
    Key := FCodeKey;
    Model := cmRDL256;
    CManager.AdminLogon :=  Encrypt('marcelo');
    CManager.AdminPassword := Encrypt('galaad');
   end;

 finally
  if Assigned(Cript) then
   FreeAndNil(Cript);
 end;
end;



end.
