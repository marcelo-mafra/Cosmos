unit cosmos.focos.view.mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.common.view.mainform, CustomizeDlg, Menus, PlatformDefaultStyleActnCtrls,
  ActnPopup, ActnList, ImgList, XPMan, Tabs, DockTabSet, ComCtrls, ExtCtrls,
  ToolWin, ActnMan, ActnCtrls, ActnMenus, StdCtrls, cosmos.system.types,
  cosmos.framework.interfaces.DataAcess, Vcl.AppEvnts, System.Actions,
  Vcl.Touch.GestureMgr;

type
  TFrmMainFocos = class(TFrmMainClientGUI)
    ActManager: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    ActFocosManager: TAction;
    ActGestoes: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActFocosManagerExecute(Sender: TObject);
    procedure ActGestoesExecute(Sender: TObject);
  private
    { Private declarations }

  protected
    //Métodos sobrescritos da classe ancestral.
    procedure DoAplicateCustomHintObject(const CustomHint: TCustomHint); override;
    function GetActionManager: TActionManager; override;
    procedure WriteStartupOptions; override;

    function GetCosmosModule: TCosmosModules; override;
    function GetIRemoteCon: ICosmosRemoteConnection;  override;


  public
    { Public declarations }
    property ActionManager: TActionManager read GetActionManager;
  end;

var
  FrmMainFocos: TFrmMainFocos;

implementation

uses cosmos.focos.services.clientconnections;

{$R *.dfm}

{ TFrmMainFocos }

procedure TFrmMainFocos.ActFocosManagerExecute(Sender: TObject);
begin
  inherited;
   self.OpenRegisteredWindow('focosras.bpl','TFrmFocosRAs');
end;

procedure TFrmMainFocos.ActGestoesExecute(Sender: TObject);
begin
  inherited;
  self.OpenRegisteredWindow('orgestores.bpl','TFrmOrgaosGestores');
end;

procedure TFrmMainFocos.DoAplicateCustomHintObject(
  const CustomHint: TCustomHint);
begin
  inherited;
end;

procedure TFrmMainFocos.FormCreate(Sender: TObject);
begin
  inherited;
 Application.HelpFile := ExtractFilePath(Application.ExeName) + 'gfocos.chm';
end;

function TFrmMainFocos.GetActionManager: TActionManager;
begin
 Result := self.ActManager;
end;

function TFrmMainFocos.GetCosmosModule: TCosmosModules;
begin
 Result := cmFocos;
end;

function TFrmMainFocos.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := DMCon as ICosmosRemoteConnection;
end;

procedure TFrmMainFocos.WriteStartupOptions;
begin
 inherited;
end;



end.
