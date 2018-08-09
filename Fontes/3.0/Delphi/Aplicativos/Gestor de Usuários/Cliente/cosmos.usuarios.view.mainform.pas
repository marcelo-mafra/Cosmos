unit cosmos.usuarios.view.mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.common.view.mainform, CustomizeDlg, Menus, PlatformDefaultStyleActnCtrls,
  ActnPopup, ActnList, ImgList, XPMan, Tabs, DockTabSet, ComCtrls, ExtCtrls,
  ToolWin, ActnMan, ActnCtrls, ActnMenus, XPStyleActnCtrls, cosmos.classes.application,
  cosmos.framework.interfaces.DataAcess, cosmos.system.messages, XMLDoc, XMLIntf,
  MidasLib, Vcl.AppEvnts, System.Actions, Vcl.Touch.GestureMgr, cosmos.system.types;

type
  TFrmMainUsuarios = class(TFrmMainClientGUI)
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    ActManager: TActionManager;
    ActUsuarios: TAction;
    ActPerfis: TAction;
    ActPemissoes: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActUsuariosExecute(Sender: TObject);
    procedure ActUsuariosUpdate(Sender: TObject);
    procedure ActPerfisExecute(Sender: TObject);
    procedure ActPerfisUpdate(Sender: TObject);
    procedure ActLoginExecute(Sender: TObject);
  private
    { Private declarations }

   protected
    procedure DoAplicateCustomHintObject(const CustomHint: TCustomHint); override;
    function GetActionManager: TActionManager; override;
    procedure WriteStartupOptions; override;

    function GetCosmosModule: TCosmosModules; override;
    function GetIRemoteCon: ICosmosRemoteConnection;  override;

  public
    { Public declarations }

  end;

var
  FrmMainUsuarios: TFrmMainUsuarios;

implementation

uses cosmos.usuarios.clientconnections;

{$R *.dfm}

procedure TFrmMainUsuarios.ActLoginExecute(Sender: TObject);
begin
  inherited;
  //O Cosmos Gestor de Usuários somente pode ser usados por administradores do sistema.
  if (Assigned(IRemoteCon)) and (Assigned(IRemoteCon.CurrentUser)) then
   begin
     if not IRemoteCon.CurrentUser.Administrator then
      begin
       DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosInfoMsg.CannotUseGUsers);
       IRemoteCon.CloseConnection;
      end;
   end;
end;

procedure TFrmMainUsuarios.ActPerfisExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('perfis.bpl','TFrmPerfis');
end;

procedure TFrmMainUsuarios.ActPerfisUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil)
   and (self.CurrentConnection.CurrentUser.Administrator = True);
end;

procedure TFrmMainUsuarios.ActUsuariosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('cmusers.bpl', 'TFrmUsuarios');
end;

procedure TFrmMainUsuarios.ActUsuariosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected);
end;

procedure TFrmMainUsuarios.DoAplicateCustomHintObject(
  const CustomHint: TCustomHint);
begin
  inherited;
end;

procedure TFrmMainUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  Application.HelpFile := ExtractFilePath(Application.ExeName) +  'gusers.chm';
end;

function TFrmMainUsuarios.GetActionManager: TActionManager;
begin
 Result := self.ActManager;
end;

function TFrmMainUsuarios.GetCosmosModule: TCosmosModules;
begin
 Result := cmUsuarios;
end;

function TFrmMainUsuarios.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := DMCon as ICosmosRemoteConnection;
end;

procedure TFrmMainUsuarios.WriteStartupOptions;
begin
 inherited;
end;

end.
