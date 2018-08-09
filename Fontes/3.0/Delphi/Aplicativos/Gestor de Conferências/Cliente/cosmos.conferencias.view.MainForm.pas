unit cosmos.conferencias.view.MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.common.view.mainform, CustomizeDlg, Menus, cosmos.classes.application,
  PlatformDefaultStyleActnCtrls, ActnPopup, ActnList, ImgList, XPMan, Tabs,
  DockTabSet, ComCtrls, ExtCtrls, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  cosmos.system.messages, cosmos.business.focos, XMLDoc, XMLIntf, cosmos.system.types,
  cosmos.business.conferencias, cosmos.framework.interfaces.DataAcess, cosmos.framework.interfaces.Dialogs,
  XPStyleActnCtrls, Cosmos.Framework.Interfaces.Root, cosmos.framework.forms.conferencias,
  Vcl.AppEvnts, Vcl.Touch.GestureMgr, System.Actions, cosmos.classes.security,
  Cosmos.Framework.Interfaces.ChangeFocusNotifiers;

type
  TFrmMainConferencias = class(TFrmMainClientGUI, ICosmosConference)
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    ActManager: TActionManager;
    ActSelectFocus: TAction;
    ActNovaConferencia: TAction;
    ActAgendaConferencias: TAction;
    ActAlojamentos: TAction;
    ActInscricoes: TAction;
    ActAtributos: TAction;
    ActAtividades: TAction;
    ActFrequencia: TAction;
    ActAreasStaff: TAction;
    ActDetalhamentoInscricoes: TAction;
    ActOpenConference: TAction;
    Action1: TAction;
    ActStaff: TAction;
    procedure ActSelectFocusExecute(Sender: TObject);
    procedure ActNovaConferenciaExecute(Sender: TObject);
    procedure ActAgendaConferenciasExecute(Sender: TObject);
    procedure ActAlojamentosExecute(Sender: TObject);
    procedure ActAtributosExecute(Sender: TObject);
    procedure ActAtividadesExecute(Sender: TObject);
    procedure ActFrequenciaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActInscricoesExecute(Sender: TObject);
    procedure ActAreasStaffExecute(Sender: TObject);
    procedure ActDetalhamentoInscricoesExecute(Sender: TObject);
    procedure ActStaffsExecute(Sender: TObject);
    procedure ActOpenConferenceExecute(Sender: TObject);
    procedure ActInscricoesUpdate(Sender: TObject);
    procedure ActLogoffExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action1Update(Sender: TObject);
    procedure ActStaffExecute(Sender: TObject);
    procedure ActAreasStaffUpdate(Sender: TObject);
    procedure ActAtributosUpdate(Sender: TObject);
    procedure ActAlojamentosUpdate(Sender: TObject);
    procedure ActDetalhamentoInscricoesUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FActiveConference: TConferencia;
    FChangeFocusObserver: TChangeFocusObserver;

    procedure CloseActiveConference;
    function GetActiveConference: TConferencia;
    procedure OnChangeFocusEvent(Focus: TFocus);

  protected
    procedure DoAplicateCustomHintObject(const CustomHint: TCustomHint); override;
    function GetActionManager: TActionManager; override;
    procedure WriteStartupOptions; override;

    function GetIConference: ICosmosConference; override;
    function GetCosmosModule: TCosmosModules; override;
    function GetIRemoteCon: ICosmosRemoteConnection;  override;

    //ICosmosConference
    property ActiveConference: TConferencia read GetActiveConference;
    function OpenConference(Campo: TCampoTrabalho): boolean;

  public
    { Public declarations }

  end;

var
  FrmMainConferencias: TFrmMainConferencias;

implementation

uses cosmos.conferencias.clientconnections;

{$R *.dfm}

{ TFrmMainConferencias }


procedure TFrmMainConferencias.ActNovaConferenciaExecute(Sender: TObject);
begin
  inherited;
  if ExecuteWizard('novaconf.bpl', 'TFrmNovaConferencia') then
    DlgMessage.InfoMessage(TCosmosTitles.Conferencias, TCosmosInfoMsg.ConferenciaCriada)
end;

procedure TFrmMainConferencias.ActOpenConferenceExecute(Sender: TObject);
begin
  inherited;
//Abre umaconferência para trabalho.
 if OpenConference(ctAll) then
  WindowsManager.UpdateAllForms;
end;

procedure TFrmMainConferencias.ActAtividadesExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('agenda.bpl', 'TFrmAtividades');
end;

procedure TFrmMainConferencias.ActFrequenciaExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('confreq.bpl', 'TFrmFrequencia');
end;

procedure TFrmMainConferencias.ActInscricoesExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('inscricoes.bpl', 'TFrmInscricoes')
end;

procedure TFrmMainConferencias.ActInscricoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (ActiveConference <> nil)
   and (nfInscricoesConferencia in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures);
end;

procedure TFrmMainConferencias.Action1Execute(Sender: TObject);
begin
  inherited;
  CloseActiveConference;
end;

procedure TFrmMainConferencias.Action1Update(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ActiveConference <> nil;
end;

procedure TFrmMainConferencias.ActStaffExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('staff.bpl', 'TFrmStaffConferencias');
end;

procedure TFrmMainConferencias.ActLogoffExecute(Sender: TObject);
begin
  inherited;
  if IRemoteCon.Connected = False then
   CloseActiveConference;
end;

procedure TFrmMainConferencias.ActAlojamentosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('alojamentos.bpl', 'TFrmAlojamentos')
end;

procedure TFrmMainConferencias.ActAlojamentosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlojamentos in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures);
end;

procedure TFrmMainConferencias.ActSelectFocusExecute(Sender: TObject);
begin
  inherited;
  if  (CurrentConnection <> nil) and (CurrentConnection.CurrentUser <> nil) then
   LoadUserFocus(CurrentConnection.CurrentUser.Login);
end;

procedure TFrmMainConferencias.ActStaffsExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('staff.bpl', 'TFrmStaffConferencias');
end;

procedure TFrmMainConferencias.CloseActiveConference;
begin
 if FActiveConference <> nil then
  FreeAndNil(FActiveConference);

 WindowsManager.CloseAllRegisteredWindows;
end;

procedure TFrmMainConferencias.ActAreasStaffExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('areastaff.bpl', 'TFrmAreasStaff');
end;

procedure TFrmMainConferencias.ActAreasStaffUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAreasStaff in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures);
end;

procedure TFrmMainConferencias.ActAtributosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('classificadores.bpl', 'TFrmClassificadores');
end;

procedure TFrmMainConferencias.ActAtributosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfClassificadores in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures);
end;

procedure TFrmMainConferencias.ActDetalhamentoInscricoesExecute(
  Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('detinscricoes.bpl', 'TFrmDetalhamentoInscricoes')
end;

procedure TFrmMainConferencias.ActDetalhamentoInscricoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (ActiveConference <> nil)
   and (nfDetalhamentoInscricao in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures);
end;

procedure TFrmMainConferencias.ActAgendaConferenciasExecute(Sender: TObject);
begin
  inherited;
  OpenRegisteredWindow('conferencias.bpl', 'TFrmConferencias');
end;

procedure TFrmMainConferencias.DoAplicateCustomHintObject(
  const CustomHint: TCustomHint);
begin
 inherited;
end;

procedure TFrmMainConferencias.FormCreate(Sender: TObject);
begin
  inherited;
  Application.HelpFile := ExtractFilePath(Application.ExeName) +  'gconf.chm';

  //Cria o objeto "observador" que recebe notificações sobre a mudança do foco ativo.
  FChangeFocusObserver := TChangeFocusObserver.Create;
  FChangeFocusObserver.OnNotifyChangeFocus := OnChangeFocusEvent;
  ChangeFocusNotifier.RegisterObserver(FChangeFocusObserver);
end;

procedure TFrmMainConferencias.FormDestroy(Sender: TObject);
begin
  if (ChangeFocusNotifier <> nil) then
   ChangeFocusNotifier.UnregisterObserver(FChangeFocusObserver);
  FChangeFocusObserver.Free;

  inherited;
end;

function TFrmMainConferencias.GetCosmosModule: TCosmosModules;
begin
 Result := cmConferencias;
end;

function TFrmMainConferencias.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := DMCon as ICosmosRemoteConnection;
end;

procedure TFrmMainConferencias.OnChangeFocusEvent(Focus: TFocus);
begin
{Implementa o evento que ocorre quando o foco ativo muda. Neste caso,
 a eventual conferência ativa deve ser "eliminada".}
 CloseActiveConference;
end;

function TFrmMainConferencias.OpenConference(Campo: TCampoTrabalho): boolean;
var
 AData: TCosmosData;
begin
{Abre uma conferência para a seção de trabalho.}
  AData := TCosmosConferenciasDialogs.SelecionarConferencia(Campo, True);
  if AData <> nil then
   begin
    if not Assigned(FActiveConference) then
     FActiveConference := TConferencia.Create;

    FActiveConference.ConferenceID := AData.FindValue('codcon');
    FActiveConference.ConferenceName := AData.FindValue('nomcon');
    FActiveConference.CampoPromotor := AData.FindValue('camcon');
    FActiveConference.FocoPromotor := AData.FindValue('nomfoc');
    FActiveConference.ConferenceStart := AData.FindValue('datini');
    FActiveConference.ConferenceEnd := AData.FindValue('datter');

    Result := True;
   end;
end;

function TFrmMainConferencias.GetActionManager: TActionManager;
begin
 Result := self.ActManager;
end;

function TFrmMainConferencias.GetIConference: ICosmosConference;
begin
 {Implementação de método de leitura de ICosmosConference.}
 Result := self as ICosmosConference;
end;

function TFrmMainConferencias.GetActiveConference: TConferencia;
begin
 {Implementação de método de leitura de TConferencia.}
 Result := FActiveConference;
end;

procedure TFrmMainConferencias.WriteStartupOptions;
begin
  inherited;
end;

end.
