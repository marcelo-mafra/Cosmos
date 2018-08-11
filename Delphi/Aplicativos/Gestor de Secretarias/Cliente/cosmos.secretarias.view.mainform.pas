unit cosmos.secretarias.view.mainform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.common.view.mainform,
  Vcl.CustomizeDlg, Vcl.Menus, Xml.XMLDoc, Xml.XMLIntf, Vcl.XPMan, Vcl.Tabs,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, Vcl.ActnList, Vcl.ImgList,
  Vcl.DockTabSet, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ActnMenus, cosmos.system.types, Vcl.AppEvnts, System.Actions,
  cosmos.framework.interfaces.DataAcess, cosmos.classes.security,
  Cosmos.Framework.Interfaces.Applications, Vcl.Touch.GestureMgr, Cosmos.System.Messages,
  cosmos.framework.forms.acessorias;

type
  TFrmMainSecretarias = class(TFrmMainClientGUI, ICosmosSecretarias, ICosmosFocos)
    Secretarias: TActionManager;
    ActSelectFocus: TAction;
    ActAlunos: TAction;
    ActTM: TAction;
    ActPesquisadores: TAction;
    ActTurmasTP: TAction;
    ActSimpatizantes: TAction;
    ActInstalacoes: TAction;
    ActLivrosEI: TAction;
    ActEI: TAction;
    ActAtividades: TAction;
    ActFrequencia: TAction;
    ActAlocucoes: TAction;
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    ActFocusRAs: TAction;
    ActOrgaosGestores: TAction;
    ActNewFocus: TAction;
    ActNewRA: TAction;
    ActHistorico: TAction;
    procedure ActSelectFocusExecute(Sender: TObject);
    procedure ActAlunosExecute(Sender: TObject);
    procedure ActAlunosUpdate(Sender: TObject);
    procedure ActTMExecute(Sender: TObject);
    procedure ActTMUpdate(Sender: TObject);
    procedure ActPesquisadoresExecute(Sender: TObject);
    procedure ActPesquisadoresUpdate(Sender: TObject);
    procedure ActTurmasTPExecute(Sender: TObject);
    procedure ActTurmasTPUpdate(Sender: TObject);
    procedure ActSimpatizantesExecute(Sender: TObject);
    procedure ActInstalacoesExecute(Sender: TObject);
    procedure ActLivrosEIExecute(Sender: TObject);
    procedure ActLivrosEIUpdate(Sender: TObject);
    procedure ActEIExecute(Sender: TObject);
    procedure ActEIUpdate(Sender: TObject);
    procedure ActAtividadesExecute(Sender: TObject);
    procedure ActFrequenciaExecute(Sender: TObject);
    procedure ActAlocucoesExecute(Sender: TObject);
    procedure ActSimpatizantesUpdate(Sender: TObject);
    procedure ActInstalacoesUpdate(Sender: TObject);
    procedure ActAtividadesUpdate(Sender: TObject);
    procedure ActFrequenciaUpdate(Sender: TObject);
    procedure ActAlocucoesUpdate(Sender: TObject);
    procedure ActFocusRAsExecute(Sender: TObject);
    procedure ActNewFocusExecute(Sender: TObject);
    procedure ActNewRAExecute(Sender: TObject);
    procedure ActFocusRAsUpdate(Sender: TObject);
    procedure ActNewFocusUpdate(Sender: TObject);
    procedure ActNewRAUpdate(Sender: TObject);
    procedure ActHistoricoExecute(Sender: TObject);
    procedure ActHistoricoUpdate(Sender: TObject);
  private
    { Private declarations }
    function GetISecretarias: ICosmosSecretarias;
    function GetIFocos: ICosmosFocos;


  protected
    procedure DoAplicateCustomHintObject(const CustomHint: TCustomHint); override;
    function GetActionManager: TActionManager; override;
    procedure WriteStartupOptions; override;

    function GetCosmosModule: TCosmosModules; override;
    function GetIRemoteCon: ICosmosRemoteConnection;  override;

    property IFocos: ICosmosFocos read GetIFocos implements ICosmosFocos;
    property ISecratarias: ICosmosSecretarias read GetISecretarias implements ICosmosSecretarias;

  public
    { Public declarations }

  end;

var
  FrmMainSecretarias: TFrmMainSecretarias;

implementation

uses cosmos.secretarias.services.clientconnections;

{$R *.dfm}

{ TFrmMainSecretarias }


procedure TFrmMainSecretarias.ActAlocucoesExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('alocucoes.bpl', 'TFrmAlocucoes');
end;

procedure TFrmMainSecretarias.ActAlocucoesUpdate(Sender: TObject);
begin
  inherited;
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
 (CurrentConnection <> nil) and (sfAlocucoes in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActAlunosExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('alunos.bpl', 'TFrmAlunos');
end;

procedure TFrmMainSecretarias.ActAlunosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil) and
  (sfAlunos in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActAtividadesExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('agenda.bpl', 'TFrmAtividades');
end;

procedure TFrmMainSecretarias.ActAtividadesUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
 (CurrentConnection <> nil) and (cfAgendaAtividades in CurrentConnection.AuthorizedFeatures);
end;

procedure TFrmMainSecretarias.ActEIExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('circei.bpl', 'TFrmCirculosEI');
end;

procedure TFrmMainSecretarias.ActEIUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
 (CurrentConnection <> nil) and (sfCirculosEI in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActFocusRAsExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('focosras.bpl', 'TFrmFocosRAs');
end;

procedure TFrmMainSecretarias.ActFocusRAsUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil) and
  (sfFocosRas in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActFrequenciaExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('confreq.bpl', 'TFrmFrequencia');
end;

procedure TFrmMainSecretarias.ActFrequenciaUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
 (CurrentConnection <> nil) and (cfControleFrequencia in CurrentConnection.AuthorizedFeatures);
end;

procedure TFrmMainSecretarias.ActHistoricoExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('historico.bpl', 'TFrmHistorico');
end;

procedure TFrmMainSecretarias.ActHistoricoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil) and
  (sfLoadHistoricCadastrado in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActInstalacoesExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('instalacoes.bpl', 'TFrmInstalacoes');
end;

procedure TFrmMainSecretarias.ActInstalacoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil) and
  (sfInstalacoes in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActLivrosEIExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('licei.bpl', 'TFrmLivrosEI');
end;

procedure TFrmMainSecretarias.ActLivrosEIUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
   (CurrentConnection <> nil) and (sfLivrosEI in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActNewFocusExecute(Sender: TObject);
begin
  inherited;
  if ExecuteWizard('wznewfocus.bpl', 'TFrmWizardNewFocus') then
   DlgMessage.InfoMessage(TCosmosTitles.Focos, TCosmosInfoMsg.FocoCriado);
end;

procedure TFrmMainSecretarias.ActNewFocusUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil) and
  (sfNovoFoco in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActNewRAExecute(Sender: TObject);
var
 Value: string;
 IFocos: ICosmosFocos;
begin
  inherited;
  //Cria uma nova Região Administrativa.
  Value := TCosmosAcessoriasDialogs.InputData(TCosmosTitles.RAs, TCosmosTitles.NewRA, 35);

  if Value.Trim <> '' then
   begin
    IFocos := self as ICosmosFocos;

    try
     if IFocos.NewRegion(Value, null) <> null then
      DlgMessage.InfoMessage(TCosmosTitles.RAs, TCosmosInfoMsg.RACriada);

    finally
     if Assigned(IFocos) then IFocos := nil;
    end;
   end;
end;

procedure TFrmMainSecretarias.ActNewRAUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil) and
  (sfNovaRA in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActPesquisadoresExecute(Sender: TObject);
begin
  inherited;
  //Acessa a tela principal de trabalho com pesquisadores.
  OpenRegisteredWindow('cadpes.bpl', 'TFrmPesquisadores');
end;

procedure TFrmMainSecretarias.ActPesquisadoresUpdate(Sender: TObject);
begin
  inherited;
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
  (CurrentConnection <> nil) and (sfPesquisadores in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActSelectFocusExecute(Sender: TObject);
begin
  inherited;
  //Lista os focos aos quais o usuário pode acessar.
  if  (CurrentConnection <> nil) and (CurrentConnection.CurrentUser <> nil) then
   LoadUserFocus(CurrentConnection.CurrentUser.Login);
end;

procedure TFrmMainSecretarias.ActSimpatizantesExecute(Sender: TObject);
begin
  inherited;
  //Acessa a tela principal de trabalho com simpatizantes.
  OpenRegisteredWindow('simptp.bpl', 'TFrmSimpatizantes');
end;

procedure TFrmMainSecretarias.ActSimpatizantesUpdate(Sender: TObject);
begin
  inherited;
 TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
  (CurrentConnection <> nil) and (sfSimpatizantes in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActTMExecute(Sender: TObject);
begin
  inherited;
  //Acessa a tela principal de trabalho com jovens do TM.
  OpenRegisteredWindow('jovenstm.bpl', 'TFrmJovensTM');
end;

procedure TFrmMainSecretarias.ActTMUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CurrentConnection <> nil) and
  (sfJovens in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.ActTurmasTPExecute(Sender: TObject);
begin
  inherited;
  //Acessa a tela principal de trabalho com turmas do trabalho público.
  OpenRegisteredWindow('turmastp.bpl', 'TFrmTurmasTP');
end;

procedure TFrmMainSecretarias.ActTurmasTPUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (IRemoteCon <> nil) and (IRemoteCon.Connected) and
 (CurrentConnection <> nil) and (sfTurmasCursistas in CurrentConnection.SecretariasFeatures);
end;

procedure TFrmMainSecretarias.DoAplicateCustomHintObject(
  const CustomHint: TCustomHint);
begin
 inherited;
end;

function TFrmMainSecretarias.GetCosmosModule: TCosmosModules;
begin
 Result := cmSecretarias;
end;

function TFrmMainSecretarias.GetIFocos: ICosmosFocos;
begin
 Result := DMCon.FocosClass as ICosmosFocos;
end;

function TFrmMainSecretarias.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := DMCon as ICosmosRemoteConnection;
end;

function TFrmMainSecretarias.GetISecretarias: ICosmosSecretarias;
begin
 Result := DMCon.SecretariasClass as ICosmosSecretarias;
end;

function TFrmMainSecretarias.GetActionManager: TActionManager;
begin
 Result := self.Secretarias;
end;

procedure TFrmMainSecretarias.WriteStartupOptions;
begin
 inherited;
end;

end.
