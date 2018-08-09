unit cosmos.conferencias.view.FormInscricoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages, DB,
  DBClient, ExtCtrls, ToolWin, ActnMan, ActnCtrls, Tabs, DockTabSet,
  cosmos.frames.gridsearch, StdCtrls, DBCtrls, Menus, PlatformDefaultStyleActnCtrls,
  ActnPopup, XPStyleActnCtrls, cosmos.classes.application, cosmos.classes.ServerInterface,
  cosmos.framework.interfaces.root, cosmos.framework.interfaces.dialogs,
  cosmos.framework.datanavigators.datasets, cosmos.business.focos, cosmos.classes.security,
  cosmos.business.conferencias, System.Actions, Data.DBXCommon, cosmos.system.formsconst;

type
  TTipoListagem = (tlAlfabetica, tlDiscipulado, tlFocos);

  TFrmInscricoes = class(TFrmCosmosDocked)
    ActionToolBar1: TActionToolBar;
    Panel1: TPanel;
    TabSetFocos: TDockTabSet;
    TabSetAlfabetico: TDockTabSet;
    TabSetDiscipulados: TDockTabSet;
    FmeGridSearch1: TFmeGridSearch;
    DsrInscricoes: TDataSource;
    PopupActionBar2: TPopupActionBar;
    ListagemAlfabtica1: TMenuItem;
    ListagemporDiscipulados1: TMenuItem;
    PopupActionBar1: TPopupActionBar;
    ListagemporDiscipulados2: TMenuItem;
    ActionManager1: TActionManager;
    ActListagemAlfabetica: TAction;
    ActListagemDiscipulados: TAction;
    ActListagemFocos: TAction;
    Listagens1: TMenuItem;
    ListagemporFocos1: TMenuItem;
    ListagemporDiscipulados3: TMenuItem;
    ListagemAlfabtica2: TMenuItem;
    N1: TMenuItem;
    LblConferencia: TLinkLabel;
    Label1: TLabel;
    LblPromotor: TLabel;
    Label2: TLabel;
    LblInicio: TLabel;
    Label4: TLabel;
    LblTermino: TLabel;
    ActImportarInscritos: TAction;
    ActNovaInscricao: TAction;
    ActEditarInscrito: TAction;
    ActCancelarInscricao: TAction;
    AlterarInscrio1: TMenuItem;
    CancelarInscrio1: TMenuItem;
    ImportarInscritos1: TMenuItem;
    N2: TMenuItem;
    NovaInscrio1: TMenuItem;
    ActCrachaInscrito: TAction;
    CrachdoInscrito1: TMenuItem;
    N4: TMenuItem;
    ActFiltroNaoAlojado: TAction;
    ActFiltroAlojados: TAction;
    ActFiltroReset: TAction;
    Filtrar1: TMenuItem;
    SemFiltro1: TMenuItem;
    InscritosAlojados1: TMenuItem;
    InscritosnoAlojados1: TMenuItem;
    ActFilter: TAction;
    ActFiltroMulheres: TAction;
    ActFiltroHomens: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    ApenasMulheres1: TMenuItem;
    ApenasHomens1: TMenuItem;
    ActClassificadores: TAction;
    Classificadores1: TMenuItem;
    Documentos1: TMenuItem;
    N8: TMenuItem;
    ActRecadosInscrito: TAction;
    Avisos1: TMenuItem;
    ActDesalojar: TAction;
    ActReportListaInscritos: TAction;
    ListadeInscritos1: TMenuItem;
    ActAlojarInscritos: TAction;
    N3: TMenuItem;
    ActUpdateInscricoes: TAction;
    AtualizarDetalhamento1: TMenuItem;
    N7: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActListagemAlfabeticaExecute(Sender: TObject);
    procedure ActListagemDiscipuladosExecute(Sender: TObject);
    procedure ActListagemFocosExecute(Sender: TObject);
    procedure ActNovaInscricaoExecute(Sender: TObject);
    procedure ActNovaInscricaoUpdate(Sender: TObject);
    procedure ActImportarInscritosExecute(Sender: TObject);
    procedure ActEditarInscritoExecute(Sender: TObject);
    procedure ActEditarInscritoUpdate(Sender: TObject);
    procedure ActCancelarInscricaoExecute(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActFiltroResetExecute(Sender: TObject);
    procedure ActFiltroNaoAlojadoExecute(Sender: TObject);
    procedure ActFiltroAlojadosExecute(Sender: TObject);
    procedure ActFilterExecute(Sender: TObject);
    procedure ActFiltroMulheresExecute(Sender: TObject);
    procedure ActFiltroHomensExecute(Sender: TObject);
    procedure ActClassificadoresExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActDesalojarExecute(Sender: TObject);
    procedure ActDesalojarUpdate(Sender: TObject);
    procedure ActCrachaInscritoExecute(Sender: TObject);
    procedure ActReportListaInscritosExecute(Sender: TObject);
    procedure ActAlojarInscritosExecute(Sender: TObject);
    procedure ActImportarInscritosUpdate(Sender: TObject);
    procedure ActCancelarInscricaoUpdate(Sender: TObject);
    procedure ActRecadosInscritoExecute(Sender: TObject);
    procedure ActAlojarInscritosUpdate(Sender: TObject);
    procedure ActCrachaInscritoUpdate(Sender: TObject);
    procedure ActReportListaInscritosUpdate(Sender: TObject);
    procedure ActUpdateInscricoesUpdate(Sender: TObject);
    procedure ActUpdateInscricoesExecute(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TDatasetDataNavigator;
    FTipoListagem: TTipoListagem;
    FDiscipulado: string;
    FFoco: string;
    FLetter2: string;
    FLetter1: string;
    FConferenceData: TCosmosData;
    FIConference: ICosmosConference;
    CdsInscricoes: TClientDataset;

    procedure SetTipoListagem(const Value: TTipoListagem);
    procedure ListarDiscipulados;
    procedure ListarFocos;
    procedure ListarInscritos;
    procedure UpdateData(Sender: TObject);
    procedure ShowConferenceInfo; inline;


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
    property Discipulado: string read FDiscipulado write FDiscipulado;
    property Foco: string read FFoco write FFoco;
    property Letter1: string read FLetter1 write FLetter1 ;
    property Letter2: string read FLetter2 write FLetter2 ;
    property TipoListagem: TTipoListagem read FTipoListagem
       write SetTipoListagem default tlFocos;

    property IConference: ICosmosConference read FIConference;
    property ConferenceData: TCosmosData read FConferenceData;
  end;

var
  FrmInscricoes: TFrmInscricoes;

implementation

uses cosmos.conferencias.view.FormEditarInscricao,
 cosmos.conferencias.view.FormEditarClassificadoresInscritos,
 cosmos.conferencias.view.FormAnotacoes;

{$R *.dfm}

{ TFrmInscricoes }

procedure TFrmInscricoes.ActAlojarInscritosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IWizard: ICosmosWizard;
begin
  inherited;
  //Importa os inscritos a partir de um arquivo externo.
  AForm := ICosmosApp.LoadDialog('wzaloj.bpl', 'TFrmWizardAlojaInscritos', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ICosmosWizard) then
        IWizard := AForm as ICosmosWizard;
       if Assigned(IWizard) then
         if IWizard.Execute(ConferenceData) then
          IRemoteCon.ActiveDataNavigator.UpdateData;
       Free;
      end;
    end;

  finally
   if Assigned(IWizard) then
    IWizard := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmInscricoes.ActRecadosInscritoExecute(Sender: TObject);
begin
  inherited;
  FrmAnotacoes := TFrmAnotacoes.Create(Application);

  try
   FrmAnotacoes.EditarAnotacao(CdsInscricoes.FieldValues['codins']);

  finally
   if Assigned(FrmAnotacoes) then FreeAndNil(FrmAnotacoes);
  end;
end;

procedure TFrmInscricoes.ActReportListaInscritosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
  AData: TCosmosData;
begin
  inherited;
  AForm := self.ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);
  AData := TCosmosData.Create(6);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      IReport := AForm as IReportCenter;
      if Assigned(IReport) then
        begin
          AData.WriteValue('CODCON', IConference.ActiveConference.ConferenceID);
          AData.WriteValue('NOMCON', IConference.ActiveConference.ConferenceName, 1);
          AData.WriteValue('NOMFOC', IConference.ActiveConference.FocoPromotor, 2);
          AData.WriteValue('DATINI', IConference.ActiveConference.ConferenceStart, 3);
          AData.WriteValue('DATTER', IConference.ActiveConference.ConferenceEnd, 4);
          IReport.PrintListagemInscritos(AData);
        end;

       AForm.Free;
      end;

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmInscricoes.ActReportListaInscritosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected);
end;

procedure TFrmInscricoes.ActUpdateInscricoesExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InscricoesConferencia, TCosmosConfMsg.AtualizarAtributosInscricao) = mrYes then
   begin
    ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMCosmosConferenciasMethods.AtualizarAtributosInscricao'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetInt32(IConference.ActiveConference.ConferenceID);
     ACommand.ExecuteUpdate;

     ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
     ACommand.Free;

    except
     on E: Exception do
      begin
       ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), E.Message);
       if Assigned(ACommand) then FreeAndNil(ACommand);
      end;
    end;
   end;

end;

procedure TFrmInscricoes.ActUpdateInscricoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IConference <> nil) and (IConference.ActiveConference <> nil)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfNovaInscricao in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmInscricoes.ActAlojarInscritosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := Assigned(CdsInscricoes) and (CdsInscricoes.Active) and not (CdsInscricoes.IsEmpty)
   and (CdsInscricoes.FieldValues['codins'] <> null)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlojarInscrito in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmInscricoes.ActCancelarInscricaoExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InscricoesConferencia, TCosmosConfMsg.CancelarInscricao) = mrYes then
   begin
    ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMCosmosConferenciasMethods.CancelarInscricao'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetInt32(CdsInscricoes.FieldValues['codins']);
     ACommand.ExecuteUpdate;
     if ACommand.Parameters[1].Value.GetInt32 = 0 then
       self.UpdateData(Sender);

     ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
     ACommand.Free;

    except
     on E: Exception do
      begin
       ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), E.Message);
       if Assigned(ACommand) then FreeAndNil(ACommand);
      end;
    end;
   end;
end;

procedure TFrmInscricoes.ActCancelarInscricaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := Assigned(CdsInscricoes) and (CdsInscricoes.Active) and not (CdsInscricoes.IsEmpty)
   and (CdsInscricoes.FieldValues['codins'] <> null)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfCancelarInscricao in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmInscricoes.ActClassificadoresExecute(Sender: TObject);
begin
  inherited;
  FrmEditarClassificadoresInscritos := TFrmEditarClassificadoresInscritos.Create(self);

  try
   FrmEditarClassificadoresInscritos.EditarClassificadores(CdsInscricoes.FieldValues['codcad']);

  finally
   if Assigned(FrmEditarClassificadoresInscritos) then FreeAndNil(FrmEditarClassificadoresInscritos);
  end;
end;

procedure TFrmInscricoes.ActCrachaInscritoExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
begin
  inherited;
  AForm := self.ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      IReport := AForm as IReportCenter;
      if Assigned(IReport) then
        begin
         IReport.PrintCrachaInscrito(CdsInscricoes.FieldValues['codins']);
        end;

       AForm.Free;
      end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmInscricoes.ActCrachaInscritoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := Assigned(CdsInscricoes) and (CdsInscricoes.Active) and not (CdsInscricoes.IsEmpty)
   and (CdsInscricoes.FieldValues['codins'] <> null)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected);
end;

procedure TFrmInscricoes.ActDesalojarExecute(Sender: TObject);
var
ACommand: TDBXCommand;
begin
  inherited;
  //Desaloja um inscrito de um leito.
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InscricoesConferencia, TCosmosConfMsg.DesalojarInscrito) = mrYes then
   begin
    ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMCosmosConferenciasMethods.DesalojarInscrito'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetInt32(CdsInscricoes.FieldValues['codins']);
     ACommand.ExecuteUpdate;

     ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
     ACommand.Free;

     UpdateData(sender);

    except
     on E: Exception do
      begin
       ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), E.Message);
       if Assigned(ACommand) then FreeAndNil(ACommand);
      end;
    end;
   end;
end;

procedure TFrmInscricoes.ActDesalojarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := Assigned(CdsInscricoes) and (CdsInscricoes.Active) and not (CdsInscricoes.IsEmpty)
   and (CdsInscricoes.FieldValues['codins'] <> null)
   and not (CdsInscricoes.Fields.FieldByName('codlei').IsNull)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlojarInscrito in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmInscricoes.ActEditarInscritoExecute(Sender: TObject);
begin
  inherited;
//Altera os dados de um inscrito.
  if not Assigned(FrmEditarInscricao) then
   FrmEditarInscricao := TFrmEditarInscricao.Create(Application);

  try
   FrmEditarInscricao.EditarInscrito(CdsInscricoes.FieldValues['codins'], self.ConferenceData);
   if FrmEditarInscricao.Changed then
    self.ListarInscritos;

  finally
   if Assigned(FrmEditarInscricao) then FreeAndNil(FrmEditarInscricao);
  end;
end;

procedure TFrmInscricoes.ActEditarInscritoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled :=  Assigned(CdsInscricoes) and (CdsInscricoes.Active) and not (CdsInscricoes.IsEmpty)
   and (CdsInscricoes.FieldValues['codins'] <> null)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (nfAlterarInscricao in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmInscricoes.ActFilterExecute(Sender: TObject);
begin
  inherited;
  Tag := 0; //Apenas para o menu ficar disponível...
end;

procedure TFrmInscricoes.ActFiltroAlojadosExecute(Sender: TObject);
begin
  inherited;
  CdsInscricoes.Filter := 'CODLEI <> null'; //do not localize!
  CdsInscricoes.Filtered := True;
end;

procedure TFrmInscricoes.ActFiltroHomensExecute(Sender: TObject);
begin
  inherited;
  CdsInscricoes.Filter := Format('SEXCAD = %s', [QuotedStr('M')]); //do not localize!
  CdsInscricoes.Filtered := True;
end;

procedure TFrmInscricoes.ActFiltroMulheresExecute(Sender: TObject);
begin
  inherited;
  CdsInscricoes.Filter := Format('SEXCAD = %s', [QuotedStr('F')]); //do not localize!
  CdsInscricoes.Filtered := True;
end;

procedure TFrmInscricoes.ActFiltroNaoAlojadoExecute(Sender: TObject);
begin
  inherited;
  CdsInscricoes.Filter := 'CODLEI = null'; //do not localize!
  CdsInscricoes.Filtered := True;
end;

procedure TFrmInscricoes.ActImportarInscritosExecute(Sender: TObject);
begin
  inherited;
  //Importa os inscritos a partir de um arquivo externo.
  if ICosmosApp.ExecuteWizard('impinsc.bpl', 'TFrmWizardImportInscricoes') then
    IRemoteCon.ActiveDataNavigator.UpdateData;
end;

procedure TFrmInscricoes.ActImportarInscritosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IConference <> nil) and (IConference.ActiveConference <> nil)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)and Assigned(CdsInscricoes)
   and (CdsInscricoes.Active)
   and (nfImportarInscritos in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmInscricoes.ActListagemAlfabeticaExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlAlfabetica;
end;

procedure TFrmInscricoes.ActListagemDiscipuladosExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlDiscipulado;
end;

procedure TFrmInscricoes.ActListagemFocosExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlFocos;
end;

procedure TFrmInscricoes.ActNovaInscricaoExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmEditarInscricao) then
   FrmEditarInscricao := TFrmEditarInscricao.Create(Application);

  try
   FrmEditarInscricao.NovoInscrito(self.ConferenceData);
   if FrmEditarInscricao.Changed then
    self.ListarInscritos;

  finally
   if Assigned(FrmEditarInscricao) then FreeAndNil(FrmEditarInscricao);
  end;
end;

procedure TFrmInscricoes.ActNovaInscricaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IConference <> nil) and (IConference.ActiveConference <> nil)
   and (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and Assigned(CdsInscricoes) and (CdsInscricoes.Active)
   and (nfNovaInscricao in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmInscricoes.ActFiltroResetExecute(Sender: TObject);
begin
  inherited;
  CdsInscricoes.Filtered := False;
end;

procedure TFrmInscricoes.ExportData;
var
  AModule: HModule;
  AClass: TInterfacedPersistent;
  IDlgExporter: IExporterDialogs;
begin
//Exporta os dados do dataset ativo para um arquivo externo;
  inherited;
  AClass := ICosmosApp.LoadClass('dlgexporter.bpl', 'TDlgExporterControler', AModule);

   try
    if AModule <> 0 then
     begin
       IDlgExporter := AClass as IExporterDialogs;

       if Assigned(IDlgExporter) then
         begin
          IDlgExporter.ExportarInscritos(IConference.ActiveConference.ConferenceID);
         end;

        AClass.Free;
     end;

   finally
     if Assigned(IDlgExporter) then IDlgExporter := nil;
     if AModule <> 0 then UnloadPackage(AModule);
   end;
end;

procedure TFrmInscricoes.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if CdsInscricoes.Active and not CdsInscricoes.IsEmpty then
   ActEditarInscrito.Execute;
end;

procedure TFrmInscricoes.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsInscricoes;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmInscricoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  if Assigned(IConference) then
   FIConference := nil;
end;

procedure TFrmInscricoes.FormCreate(Sender: TObject);
begin
  inherited;
  FIConference := Application.MainForm as ICosmosConference;

  Letter1 := 'A';
  Letter2 := 'B';
  FmeGridSearch1.SearchFields := 'nomcad';

  self.ShowConferenceInfo;

  ListarFocos;
  ListarDiscipulados;
  ListarInscritos;
  TipoListagem := tlFocos;
end;

function TFrmInscricoes.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormInscricoes;
end;

function TFrmInscricoes.GetFormIDName: string;
begin
Result := 'Cosmos.Inscricoes';
end;

function TFrmInscricoes.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmInscricoes.GetHelpID: integer;
begin

end;

function TFrmInscricoes.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmInscricoes.ListarDiscipulados;
var
ADataset: TClientDataset;
sDisc, sCampo: string;
begin
 //Lista os discipulados no Tabset, para a navegação do usuário.
 TabSetDiscipulados.OnChange := nil;

 try
  ADataset := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);
  sCampo := self.IConference.ActiveConference.CampoPromotor;
  ADataset.Filter := Format('CAMDIS = %s AND INDATI = %s', [quotedStr(sCampo), quotedStr('S')]);
  ADataset.Filtered := True;
  ADataset.IndexFieldNames := 'SEQDIS';

  TabSetDiscipulados.Tabs.Clear;

  while not ADataset.Eof do
   begin
    sDisc := ADataset.Fields.FieldByName('sigdis').AsString;
    TabSetDiscipulados.Tabs.Append(sDisc);
    ADataset.Next;
   end;


 finally
  TabSetDiscipulados.TabIndex := 0;
  TabSetDiscipulados.OnChange := self.TabSetAlfabetico.OnChange;
  if Assigned(ADataset) then
   ADataset.Free;
 end;
end;

procedure TFrmInscricoes.ListarFocos;
var
ADataset: TClientDataset;
sFoco: string;
begin
 //Lista os discipulados no Tabset, para a navegação do usuário.
 ADataset := TClientDataset.Create(self);
 TabSetFocos.OnChange := nil;

 try
  ADataset := IRemoteCon.OpenBufferedData(TCosmosFiles.BufFocos);
  ADataset.Filter := Format('INDATI = %s and not TIPFOC in (%s, %s, %s)', //do not localize!
    [quotedStr('S'), quotedStr('CCO'), quotedStr('STP'), quotedStr('LTP')]);
  ADataset.IndexFieldNames := 'SIGFOC';
  ADataset.Filtered := True;

  TabSetFocos.Tabs.Clear;

  while not ADataset.Eof do
   begin
    sFoco := TrimRight(ADataset.Fields.FieldByName('sigfoc').AsString);
    TabSetFocos.Tabs.Append(sFoco);
    ADataset.Next;
   end;


 finally
  TabSetFocos.TabIndex := 0;
  TabSetFocos.OnChange := self.TabSetAlfabetico.OnChange;
  if Assigned(ADataset) then
   ADataset.Free;
 end;
end;

procedure TFrmInscricoes.ListarInscritos;
var
AParams: TCosmosData;
ASearch: TCosmosSearch;
AData: variant;
AIndexName: string;
begin
 ShowConferenceInfo;

 if (IConference.ActiveConference = nil) then
   Exit;

 case TipoListagem of
  tlAlfabetica:
   begin
    AParams := TCosmosData.Create(3);
    AData := ConferenceData.Read(0);
    AParams.WriteValue('DATA', AData[1], 0);
    AParams.WriteValue('LETTER1', QuotedStr(self.Letter1), 1);
    AParams.WriteValue('LETTER2', QuotedStr(self.Letter2), 2);
    ASearch := csListaInscritosAlfabetica;
   end;
 tlDiscipulado:
   begin
    AParams := TCosmosData.Create(2);
    AData := ConferenceData.Read(0);
    AParams.WriteValue('DATA', AData[1], 0);
    AParams.WriteValue('DISC', QuotedStr(Discipulado), 1);
    ASearch := csListaInscritosDiscipulado;
   end;
 tlFocos:
   begin
    AParams := TCosmosData.Create(2);
    AData := ConferenceData.Read(0);
    AParams.WriteValue('DATA', AData[1], 0);
    AParams.WriteValue('FOCUS', QuotedStr(Foco), 1);
    ASearch := csListaInscritosFocos;
   end;
 end;

 try
  if Assigned(CdsInscricoes) then
   begin
    AIndexName := CdsInscricoes.IndexFieldNames;
    CdsInscricoes.DisableControls;
    FreeAndNil(CdsInscricoes);
   end;

 CdsInscricoes := TClientDataset.Create(self);
 CdsInscricoes.DisableControls;
 ICosmosApp.IRemoteCon.ExecuteDQL(ASearch, AParams.Data, CdsInscricoes);

 if (CdsInscricoes <> nil) and (CdsInscricoes.Active) then
   begin
     DsrInscricoes.DataSet := CdsInscricoes;

     {Refaz o atual IndexName definido pelo usuário ao clicar em uma coluna da grade.
      Somente refaz isso se a nova consulta executada possuir a coluna referenciada
      na propriedade IndexName. Isto tem de ser feito para não gerar erro devido ao
      fato de uma coluna possuir um campo correto na propriedade IndexName, mas outra
      consulta não possuir este campo.}

     if AIndexName <> '' then
      begin
       if CdsInscricoes.Fields.FindField(AIndexName) <> nil then
        CdsInscricoes.IndexFieldNames := AIndexName;
      end;

     if not Assigned(FDataNavigator) then
      begin
       FDataNavigator := TDatasetDataNavigator.Create(CdsInscricoes);
       DataNavigator := FDataNavigator;
       IRemoteCon.ActiveDataset := CdsInscricoes;
       IRemoteCon.ActiveDataNavigator := FDataNavigator;
       TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;
      end;
   end;

 finally
  if Assigned(CdsInscricoes) then CdsInscricoes.EnableControls;
  if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmInscricoes.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmInscricoes.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmInscricoes.SetTipoListagem(const Value: TTipoListagem);
var
vAllowChange: boolean;
begin
 vAllowChange := True;

 if FTipoListagem <> Value then
  begin
   FTipoListagem := Value;
   case FTipoListagem of
    tlDiscipulado:
     begin
      TabSetFocos.Visible := False;
      TabSetAlfabetico.Visible := False;
      TabSetDiscipulados.Visible := True;
      Discipulado := TabSetDiscipulados.Tabs.Strings[TabSetDiscipulados.TabIndex];
      if TabSetDiscipulados.TabIndex <> 0 then
       TabSetDiscipulados.TabIndex := 0
      else
       TabSetDiscipulados.OnChange(TabSetDiscipulados, 0, vAllowChange);
     end;
    tlAlfabetica:
     begin
      TabSetDiscipulados.Visible := False;
      TabSetFocos.Visible := False;
      TabSetAlfabetico.Visible := True;
      if TabSetAlfabetico.TabIndex <> 0 then
       TabSetAlfabetico.TabIndex := 0
      else
       TabSetAlfabetico.OnChange(TabSetAlfabetico, 0, vAllowChange);
     end;
    tlFocos:
     begin
      TabSetDiscipulados.Visible := False;
      TabSetAlfabetico.Visible := False;
      TabSetFocos.Visible := True;
      if TabSetAlfabetico.TabIndex <> 0 then
       TabSetAlfabetico.TabIndex := 0
      else
       TabSetAlfabetico.OnChange(TabSetFocos, 0, vAllowChange);
     end;
   end;
  end;
end;

procedure TFrmInscricoes.ShowConferenceInfo;
begin
 if (IConference <> nil) then
  begin
   if IConference.ActiveConference <> nil then
    begin
     LblConferencia.Caption := IConference.ActiveConference.ConferenceName;
     LblPromotor.Caption := IConference.ActiveConference.FocoPromotor;
     LblInicio.Caption := DateTimeToStr(IConference.ActiveConference.ConferenceStart);
     LblTermino.Caption := DateTimeToStr(IConference.ActiveConference.ConferenceEnd);

     if not Assigned(FConferenceData) then
      FConferenceData := TCosmosData.Create(8);

     ConferenceData.ClearData;
     ConferenceData.WriteValue('codcon', IConference.ActiveConference.ConferenceID);
     ConferenceData.WriteValue('nomcon', IConference.ActiveConference.ConferenceName, 1);
     ConferenceData.WriteValue('camcon', IConference.ActiveConference.CampoPromotor, 2);
     ConferenceData.WriteValue('nomfoc', IConference.ActiveConference.FocoPromotor, 3);
     ConferenceData.WriteValue('datini', IConference.ActiveConference.ConferenceStart, 4);
     ConferenceData.WriteValue('datter', IConference.ActiveConference.ConferenceEnd, 5);
     ConferenceData.WriteValue('horche', null, 6); //default null. usado na tela de cadastro.
     ConferenceData.WriteValue('horter', null, 7); //default null. usado na tela de cadastro.
    end
   else
    begin
     LblConferencia.Caption := '-';
     LblPromotor.Caption := '-';
     LblInicio.Caption := '-';
     LblTermino.Caption := '-';

     if not Assigned(FConferenceData) then
      FConferenceData := TCosmosData.Create(8);

     ConferenceData.ClearData;
    end;
  end;
end;

procedure TFrmInscricoes.TabSetAlfabeticoChange(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
var
AString: string;
begin
  inherited;

  case TipoListagem of
    tlAlfabetica:
     begin
      AString := TabSetAlfabetico.Tabs.Strings[NewTab];
      Letter1 := Copy(AString, 1, 1);
      Letter2 := Copy(AString, 2, 1);
     end;
    tlDiscipulado: Discipulado := TabSetDiscipulados.Tabs.Strings[NewTab];
    tlFocos: Foco := TabSetFocos.Tabs.Strings[NewTab];
  end;

  ListarInscritos;
end;

procedure TFrmInscricoes.UpdateData(Sender: TObject);
begin
  inherited;
  ListarInscritos;
end;

procedure TFrmInscricoes.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
  TabsetAlfabetico.Style := ICosmosApp.Components.TabsStyle;
  TabsetFocos.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmInscricoes);

finalization
 UnRegisterClass(TFrmInscricoes);

end.
