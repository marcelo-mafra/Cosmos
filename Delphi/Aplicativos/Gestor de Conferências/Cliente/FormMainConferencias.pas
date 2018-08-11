unit FormMainConferencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormMainClientGUI, CustomizeDlg, Menus, cosmos.core.classes,
  PlatformDefaultStyleActnCtrls, ActnPopup, ActnList, ImgList, XPMan, Tabs,
  DockTabSet, ComCtrls, ExtCtrls, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  cosmos.core.ConstantesMsg, cosmos.business.focos, XMLDoc, XMLIntf,
  cosmos.business.conferencias, cosmos.framework.interfaces.DataAcess, cosmos.framework.interfaces.Dialogs,
  XPStyleActnCtrls, Cosmos.Framework.Interfaces.Root, cosmos.framework.forms.conferencias,
  Vcl.AppEvnts;

type
  TFrmMainConferencias = class(TFrmMainClientGUI, ICosmosConference)
    ActManager: TActionManager;
    ActSelectFocus: TAction;
    ActNovaConferencia: TAction;
    ActAgendaConferencias: TAction;
    ActRecebimentos: TAction;
    ActAlojamentos: TAction;
    ActInscricoes: TAction;
    ActAtributos: TAction;
    ActAtividades: TAction;
    ActFrequencia: TAction;
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    ActStaffs: TAction;
    ActAreasStaff: TAction;
    ActDetalhamentoInscricoes: TAction;
    procedure ActSelectFocusExecute(Sender: TObject);
    procedure ActNovaConferenciaExecute(Sender: TObject);
    procedure ActAgendaConferenciasExecute(Sender: TObject);
    procedure ActRecebimentosExecute(Sender: TObject);
    procedure ActAlojamentosExecute(Sender: TObject);
    procedure ActAtributosExecute(Sender: TObject);
    procedure ActAtividadesExecute(Sender: TObject);
    procedure ActFrequenciaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActInscricoesExecute(Sender: TObject);
    procedure ActAreasStaffExecute(Sender: TObject);
    procedure ActDetalhamentoInscricoesExecute(Sender: TObject);
    procedure ActStaffsExecute(Sender: TObject);
  private
    { Private declarations }
    FActiveConference: TConferencia;

    function GetActionManager: TActionManager; override;
    procedure ReadMyStartupOptions; override;
    procedure WriteStartupOptions; override;
    procedure DoAplicateCustomHintObject(const CustomHint: TCustomHint); override;
    function GetActiveConference: TConferencia;
    procedure OnChangeFocusEvent(Sender: TObject);

  protected
    function GetCosmosModule: TCosmosModules; override;
    function GetIRemoteCon: ICosmosRemoteConnection;  override;

    //ICosmosConference
    property ActiveConference: TConferencia read GetActiveConference;
    function OpenConference(Campo: TCampoTrabalho): boolean;

  public
    { Public declarations }
    property ActionManager: TActionManager read GetActionManager;
  end;

var
  FrmMainConferencias: TFrmMainConferencias;

implementation

uses cosmos.conferencias.clientconnections;

{$R *.dfm}

{ TFrmMainSecretarias }


procedure TFrmMainConferencias.ActNovaConferenciaExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IWizard: ICosmosWizard;
begin
  inherited;
  AForm := self.LoadDialog('novaconf.bpl', 'TFrmNovaConferencia', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ICosmosWizard) then
        IWizard := AForm as ICosmosWizard;
       if Assigned(IWizard) then
         if IWizard.Execute then
          self.DlgMessage.Execute(sTitleConferencias, sInfoConferenciaCriada, mtInformation);
       Free;
      end;
    end;

  finally
   if Assigned(IWizard) then
    IWizard := nil;
   UnloadPackage(AModule);
  end;
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

procedure TFrmMainConferencias.ActAlojamentosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('alojamentos.bpl', 'TFrmAlojamentos')
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

procedure TFrmMainConferencias.ActAreasStaffExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('areastaff.bpl', 'TFrmAreasStaff');
end;

procedure TFrmMainConferencias.ActAtributosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('classificadores.bpl', 'TFrmClassificadores');
end;

procedure TFrmMainConferencias.ActDetalhamentoInscricoesExecute(
  Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('detinscricoes.bpl', 'TFrmDetalhamentoInscricoes')
end;

procedure TFrmMainConferencias.ActRecebimentosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('recebimentos.bpl', 'TFrmRecebimentos');
end;

procedure TFrmMainConferencias.ActAgendaConferenciasExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('conferencias.bpl', 'TFrmConferencias');
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
  self.OnChangeFocus := OnChangeFocusEvent;
end;

function TFrmMainConferencias.GetCosmosModule: TCosmosModules;
begin
 Result := cmConferencias;
end;

function TFrmMainConferencias.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := DMCon as ICosmosRemoteConnection;
end;

procedure TFrmMainConferencias.OnChangeFocusEvent(Sender: TObject);
begin
{Implementa o evento que ocorre quando o foco ativo muda. Neste caso, caso haja
 a conferência deve ser "eliminada".}
 FActiveConference := nil;
end;

function TFrmMainConferencias.OpenConference(Campo: TCampoTrabalho): boolean;
var
 AData: TCosmosData;
begin
  AData := TCosmosConferenciasDialogs.SelecionarConferencia(Campo, False);
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
   end;
end;

function TFrmMainConferencias.GetActionManager: TActionManager;
begin
 Result := self.ActManager;
end;

function TFrmMainConferencias.GetActiveConference: TConferencia;
begin
 Result := FActiveConference;
end;

procedure TFrmMainConferencias.ReadMyStartupOptions;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
 AFileName: string;
begin
 inherited;
 AFileName := IApplicationPaths.GetConnectionsInfoFile;
 if not FileExists(AFileName) then
  Exit;

 AXMLDoc := self.CreateXMLDocument;
 AXMLDoc.FileName := AFileName;
 AXMLDoc.Active := True;

 try
  //Lê as configurações de loadbalance de conexão com o servidor.
  ANode := AXMLDoc.DocumentElement;
  DMCon.LoadBalanced := ANode.Attributes['LoadBalanced'];

 finally
  if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);
 end;
end;

procedure TFrmMainConferencias.WriteStartupOptions;
begin
  inherited;
end;

end.
