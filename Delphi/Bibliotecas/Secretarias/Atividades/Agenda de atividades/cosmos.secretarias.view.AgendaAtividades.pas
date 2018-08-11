unit cosmos.secretarias.view.AgendaAtividades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.framework.view.FrmDocked,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, System.DateUtils,
  Vcl.ActnList, Vcl.ImgList, Vcl.StdActns, Vcl.Buttons, Vcl.Menus, Vcl.ActnPopup,
  Data.DB, Datasnap.DBClient, Vcl.ComCtrls, cosmos.frames.gridsearch,
  cosmos.system.messages, Vcl.ActnMan, cosmos.classes.security, cosmos.system.types,
  Vcl.XPStyleActnCtrls, Vcl.ToolWin, Vcl.ActnCtrls, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.Dataacess, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.classes.application, Vcl.Tabs, Vcl.DockTabSet, Vcl.PlatformDefaultStyleActnCtrls,
  cosmos.framework.datanavigators.datasets, cosmos.business.focos, System.Actions,
  Data.DBXCommon, Datasnap.DSConnect, cosmos.reports.types, cosmos.system.formsconst;

type
  TTipoAgenda = (taSemanal, taQuinzenal, taMensal, taAnual);

  TFrmAtividades = class(TFrmCosmosDocked)
    Panel1: TPanel;
    LblData: TLabel;
    ActAgendar: TAction;
    ActPrintBoletim: TAction;
    PopupActionBar1: TPopupActionBar;
    NovaAtividade1: TMenuItem;
    BoletimInformativo1: TMenuItem;
    ActDelActivity: TAction;
    ExcluirAtividade1: TMenuItem;
    ActEditarAgenda: TAction;
    AlterarAtividade1: TMenuItem;
    ActEscalas: TAction;
    Escalas1: TMenuItem;
    DsrAgenda: TDataSource;
    CdsAgenda: TClientDataSet;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    Image1: TImage;
    ActAgendaSemanal: TAction;
    ActAgendaQuinzenal: TAction;
    ActAgendaMensal: TAction;
    ActPrior: TAction;
    ActNext: TAction;
    ActAgendaLocal: TAction;
    AtividadesLocais1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ActParticipantes: TAction;
    Participantes1: TMenuItem;
    N3: TMenuItem;
    LectoriumRosicrucianum1: TMenuItem;
    ActTiposAtividades: TAction;
    iposdeAtividades1: TMenuItem;
    ActNovaAtividadeTM: TAction;
    rabalhodaMocidade1: TMenuItem;
    NovaAtividade2: TMenuItem;
    ActEditarAgendaTM: TAction;
    AlterarAtividade2: TMenuItem;
    ActPrintEscalas: TAction;
    ImprimirEscalas1: TMenuItem;
    N4: TMenuItem;
    ActControleFrequencia: TAction;
    ControledeFreqncia1: TMenuItem;
    ActFolhaPresencaDuplaMatricula: TAction;
    ActNovaAtividadeEI: TAction;
    ActEditarAgendaEI: TAction;
    EscolaInterna1: TMenuItem;
    NovaAtividade4: TMenuItem;
    AlterarAtividade4: TMenuItem;
    ActNovaAtividadeTP: TAction;
    ActEditarAgendaTP: TAction;
    rabalhoPblico1: TMenuItem;
    NovaAtividade5: TMenuItem;
    AlterarAtividade5: TMenuItem;
    Documentos1: TMenuItem;
    ActViewSearchBar: TAction;
    DckTabCampos: TDockTabSet;
    FmeGridSearch1: TFmeGridSearch;
    ActNovaAtividadeSIM: TAction;
    ActEditarAgendaSIM: TAction;
    Simpatizantes1: TMenuItem;
    NovaAtividade3: TMenuItem;
    AlterarAtividade3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    FolhadePresena2: TMenuItem;
    FolhadePresena3: TMenuItem;
    ActFolhaPresencaDuplaNomes: TAction;
    FolhadePresenaNome1: TMenuItem;
    N7: TMenuItem;
    ActFolhaPresencaSimplesMatricula: TAction;
    ActFolhaPresencaSimplesNomes: TAction;
    FolhadePresena2colunas1: TMenuItem;
    FolhadePresenaSimplesMatrcula1: TMenuItem;
    FolhadePresenaSimplesNome1: TMenuItem;
    ActSituacaoAtividades: TAction;
    SituaodasAtividades1: TMenuItem;
    procedure FmeGridSearch2DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FmeGridSearch2DBGrid1DblClick(Sender: TObject);
    procedure ActEscalasUpdate(Sender: TObject);
    procedure DckTabCamposClick(Sender: TObject);
    procedure ActTiposAtividadesUpdate(Sender: TObject);
    procedure ActNovaAtividadeTPUpdate(Sender: TObject);
    procedure ActNovaAtividadeTMUpdate(Sender: TObject);
    procedure ActNovaAtividadeEIUpdate(Sender: TObject);
    procedure ActEditarAgendaTPUpdate(Sender: TObject);
    procedure ActEditarAgendaTPExecute(Sender: TObject);
    procedure ActNovaAtividadeTPExecute(Sender: TObject);
    procedure ActViewSearchBarExecute(Sender: TObject);
    procedure ActEditarAgendaEIUpdate(Sender: TObject);
    procedure ActEditarAgendaEIExecute(Sender: TObject);
    procedure ActNovaAtividadeEIExecute(Sender: TObject);
    procedure ActPrintEscalasUpdate(Sender: TObject);
    procedure ActFolhaPresencaDuplaMatriculaExecute(Sender: TObject);
    procedure ActControleFrequenciaExecute(Sender: TObject);
    procedure CdsAgendaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsAgendaAfterDelete(DataSet: TDataSet);
    procedure ActPrintEscalasExecute(Sender: TObject);
    procedure ActDelActivityUpdate(Sender: TObject);
    procedure ActEditarAgendaTMUpdate(Sender: TObject);
    procedure ActEditarAgendaTMExecute(Sender: TObject);
    procedure ActNovaAtividadeTMExecute(Sender: TObject);
    procedure ActTiposAtividadesExecute(Sender: TObject);
    procedure ActEscalasExecute(Sender: TObject);
    procedure ActParticipantesExecute(Sender: TObject);
    procedure ActNextExecute(Sender: TObject);
    procedure ActPriorExecute(Sender: TObject);
    procedure ActDelActivityExecute(Sender: TObject);
    procedure ActEditarAgendaUpdate(Sender: TObject);
    procedure ActEditarAgendaExecute(Sender: TObject);
    procedure ActAgendarExecute(Sender: TObject);
    procedure CdsAgendaAfterOpen(DataSet: TDataSet);
    procedure ActAgendaLocalExecute(Sender: TObject);
    procedure ActAgendaMensalExecute(Sender: TObject);
    procedure ActAgendaQuinzenalExecute(Sender: TObject);
    procedure ActAgendaSemanalExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActAgendarUpdate(Sender: TObject);
    procedure ActPrintBoletimExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActPrintBoletimUpdate(Sender: TObject);
    procedure ActNovaAtividadeSIMExecute(Sender: TObject);
    procedure ActEditarAgendaSIMExecute(Sender: TObject);
    procedure ActNovaAtividadeSIMUpdate(Sender: TObject);
    procedure ActEditarAgendaSIMUpdate(Sender: TObject);
    procedure ActFolhaPresencaDuplaNomesExecute(Sender: TObject);
    procedure ActFolhaPresencaDuplaNomesUpdate(Sender: TObject);
    procedure ActFolhaPresencaSimplesNomesExecute(Sender: TObject);
    procedure ActFolhaPresencaSimplesMatriculaExecute(Sender: TObject);
    procedure ActSituacaoAtividadesExecute(Sender: TObject);
    procedure ActSituacaoAtividadesUpdate(Sender: TObject);
  private
    { Private declarations }
    FDataFinal: TDate;
    FDataInicial: TDate;
    FTipoAgenda: TTipoAgenda;
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;

    procedure AbrirAgenda(const Tipo: TTipoAgenda); overload;
    procedure AbrirAgenda(Data1, Data2: TDate); overload;
    function GetPreviousDate(const Data: TDate; Tipo: TTipoAgenda): TDate; inline;
    function GetNextDate(const Data: TDate; Tipo: TTipoAgenda): TDate; inline;
    function CanEdit: boolean;
    function CanDelete: boolean;
    function HasGroupEI: boolean; inline;
    procedure DoFiltrarAgenda; inline;
    function ToBoolean(const Value: string): boolean; inline;
    procedure UpdateData(Sender: TObject);
    procedure PrintFolhaPresenca(Folha: TTipoFolhaPresenca; Ordenacao: TTipoOrdenacao);

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
    property TipoAgenda: TTipoAgenda read FTipoAgenda;
    property DataInicial: TDate read FDataInicial;
    property DataFinal: TDate read FDataFinal;
  end;

var
  FrmAtividades: TFrmAtividades;

implementation

{$R *.dfm}

uses cosmos.secretarias.view.statusfrequencias;

procedure TFrmAtividades.AbrirAgenda(const Tipo: TTipoAgenda);
var
Hoje, Data1, Data2: TDate;
D, M, Y: word;
begin
  Hoje := IRemoteCon.ServerDateTime;

  FTipoAgenda := Tipo;

  case Tipo of
   taSemanal:
    begin
     Data1 := StartOfTheWeek(Hoje);
     Data2 := EndOfTheWeek(Hoje);
    end;
   taQuinzenal:
    begin
     DecodeDate(Hoje, Y, M, D);
     if D <= 15 then
      begin
       Data1 := StartOfTheMonth(Hoje);
       Data2 := EncodeDate(Y, M, 15); //dia 15 do mês corrente
      end
     else
      begin
       Data1 := EncodeDate(Y, M, 16); //dia 16 do mês corrente
       Data2 := EndOfTheMonth(Hoje);
      end;
    end;
   taMensal:
    begin
     Data1 := StartOfTheMonth(Hoje);
     Data2 := EndOfTheMonth(Hoje);
    end;
   taAnual: exit ; //to do
 end;

 AbrirAgenda(Data1, Data2);
end;

procedure TFrmAtividades.AbrirAgenda(Data1, Data2: TDate);
var
FilterActive: boolean;
DataText1, DataText2: string;
begin
  FDataInicial := Data1;
  FDataFinal := Data2;

  try
   with CdsAgenda do
    begin
     DisableControls;
     FilterActive := Filtered;
     if Active then
      Close;
     Params.Items[0].AsDate := Data1;
     Params.Items[1].AsDate := Data2;
     CdsAgenda.Open;
    end;


    if FilterActive then
     DoFiltrarAgenda;

   finally
    DataText1 := FormatDateTime('dddd, d "de" mmmm "de" yyyy',Data1);
    DataText2 := FormatDateTime('dddd, d "de" mmmm "de" yyyy',Data2);
    LblData.Caption := Format('%s  a  %s',[DataText1, DataText2]);
    CdsAgenda.EnableControls;
   end;
end;

procedure TFrmAtividades.ActAgendaMensalExecute(Sender: TObject);
begin
  inherited;
  AbrirAgenda(taMensal);
end;

procedure TFrmAtividades.ActAgendaQuinzenalExecute(Sender: TObject);
begin
  inherited;
  AbrirAgenda(taQuinzenal);
end;

procedure TFrmAtividades.ActAgendarExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     begin
      IAgenda.NovaAtividade(ctLectorium, nil);
     end;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActAgendarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and (Assigned(IRemoteCon))
   and (cfCadastrarAtividadeLectorium in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAtividades.ActAgendaSemanalExecute(Sender: TObject);
begin
  inherited;
  AbrirAgenda(taSemanal);
end;

procedure TFrmAtividades.ActControleFrequenciaExecute(Sender: TObject);
var
  AForm: TCustomForm;
  IFrequencia: IControleFrequencia;
  codati, codcon: integer;
begin
  inherited;
  if not (CdsAgenda.Active) or (CdsAgenda.IsEmpty) then
   Exit;

  if not CanEdit then
   Exit;

  AForm := ICosmosApp.OpenRegisteredWindow('confreq.bpl', 'TFrmFrequencia');

  if AForm <> nil then
  begin
   with AForm do
    begin
     IFrequencia := AForm as IControleFrequencia;
     if Assigned(IFrequencia) then
      begin
       codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;

       //Lança presença em uma atividade
       if CdsAgenda.Fields.FieldByName('codcon').IsNull then
         IFrequencia.LancarPresencas(codati)
       else
        begin //Lança presença em uma conferência
         codcon := CdsAgenda.Fields.FieldByName('codcon').AsInteger;
         if CdsAgenda.Fields.FieldByName('tiplev').Value = 'ATI' then
           IFrequencia.LancarPresencas(codati, codcon)
         else
           IFrequencia.LancarPresencasConferencia(codcon);
        end;
      end;
    end;
  end;
end;

procedure TFrmAtividades.ActDelActivityExecute(Sender: TObject);
var
codati: integer;
ACommand: TDBXCommand;
begin
  inherited;
  //exclui uma atividade
  if not CanDelete then
   Exit;

   if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.AgendaAtividades, TCosmosConfMsg.DelAtividade) = mrYes then
    begin
     codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;
     ACommand := IRemoteCon.CreateCommand;

     try
       ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
       ACommand.Text := 'TDMSecAtividadesServerMethods.DeleteActivity'; //do not localize!
       ACommand.Prepare;

       ACommand.Parameters[0].Value.SetInt32(codati);
       ACommand.ExecuteUpdate;

       ACommand.Free;

     except
      on E: Exception do
       begin
        if Assigned(ACommand) then FreeAndNil(ACommand);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
      end;
     end;
    end;
end;

procedure TFrmAtividades.ActDelActivityUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and not (CdsAgenda.IsEmpty)
   and (Assigned(IRemoteCon))
   and (IRemoteCon.CurrentConnectionMode = cmWrite)
   and (cfDeleteAtividade in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmAtividades.ActEditarAgendaEIExecute(Sender: TObject);
var
codati: integer;
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 if not CanEdit then
  Exit;

 codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;


 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarAtividade(ctEI, codati);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActEditarAgendaEIUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active) and not (CdsAgenda.IsEmpty)
   and (Trim(CdsAgenda.Fields.FieldByName('campro').AsString) = 'LEC')
   and (ToBoolean(CdsAgenda.Fields.FieldByName('indescint').AsString))
   and (Assigned(IRemoteCon))
   and (cfAlterarAtividadeEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);

end;

procedure TFrmAtividades.ActEditarAgendaExecute(Sender: TObject);
var
codati: integer;
campro, indescint: string;
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 if not CanEdit then
  Exit;

 codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;
 campro := CdsAgenda.Fields.FieldByName('campro').AsString;
 indescint := CdsAgenda.Fields.FieldByName('indescint').AsString;

 campro := campro.Trim;
 campro := campro.UpperCase(campro);
 indescint := indescint.Trim;
 indescint := indescint.LowerCase(indescint);

 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     begin
      if (campro = 'LEC') and (indescint = 'não') then
       IAgenda.EditarAtividade(ctLectorium, codati)
      else
      if campro = 'TMO' then
       IAgenda.EditarAtividade(ctTM, codati)
      else
      if campro = 'TPU' then
       IAgenda.EditarAtividade(ctTP, codati)
      else
      if (campro = 'LEC') and (indescint = 'sim') then
       IAgenda.EditarAtividade(ctEI, codati)
     end;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActEditarAgendaSIMExecute(Sender: TObject);
var
codati: integer;
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 if not CanEdit then
  Exit;

 codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;


 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarAtividade(ctSimpatizantes, codati);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActEditarAgendaSIMUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and not (CdsAgenda.IsEmpty)
   and (Trim(CdsAgenda.Fields.FieldByName('campro').AsString) = 'SIM') //do not localize!
   and (Assigned(IRemoteCon))
   and (cfAlterarAtividadeSIM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmAtividades.ActEditarAgendaTMExecute(Sender: TObject);
var
codati: integer;
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 if not CanEdit then
  Exit;

 codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;


 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarAtividade(ctTM, codati);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActEditarAgendaTMUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and not (CdsAgenda.IsEmpty)
   and (Trim(CdsAgenda.Fields.FieldByName('campro').AsString) = 'TMO') //do not localize!
   and (Assigned(IRemoteCon))
   and (cfAlterarAtividadeTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmAtividades.ActEditarAgendaTPExecute(Sender: TObject);
var
codati: integer;
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 if not CanEdit then
  Exit;

 codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;


 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarAtividade(ctTP, codati);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActEditarAgendaTPUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and not (CdsAgenda.IsEmpty)
   and (Trim(CdsAgenda.Fields.FieldByName('campro').AsString) = 'TPU') //do not localize!
   and (Assigned(IRemoteCon))
   and (cfAlterarAtividadeTP in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmAtividades.ActEditarAgendaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and not (CdsAgenda.IsEmpty)
   and (Trim(CdsAgenda.Fields.FieldByName('campro').AsString) = 'LEC') //do not localize!
   and not (ToBoolean(CdsAgenda.Fields.FieldByName('indescint').AsString))
   and (Assigned(IRemoteCon))
   and (cfAlterarAtividadeLectorium in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmAtividades.ActEscalasExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
  if CdsAgenda.IsEmpty then
   Exit;
   
  if not CanEdit then
   Exit;

 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarEscalasAtividade(CdsAgenda.Fields.FieldByName('codati').Value);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActEscalasUpdate(Sender: TObject);
var
 campro: string;
 indescint: boolean;
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active) and not (CdsAgenda.IsEmpty);

  if not TAction(sender).Enabled then
   Exit;

  campro := CdsAgenda.Fields.FieldByName('campro').AsString;
  campro := campro.Trim;
  indescint := ToBoolean(CdsAgenda.Fields.FieldByName('indescint').AsString);

  if (campro = 'LEC') and not (indescint) then //Lectorium
     TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarAtividadeLectorium in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
  else
  if (campro = 'LEC') and (indescint) then //Escola Interna
     TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarAtividadeEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
  else
  if (campro = 'TMO') and not (indescint) then //TM
     TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarAtividadeTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
  else
  if (campro = 'TPU') and not (indescint) then //TP
     TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (cfAlterarAtividadeTP in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmAtividades.ActFolhaPresencaDuplaMatriculaExecute(Sender: TObject);
begin
  inherited;
  self.PrintFolhaPresenca(tfDupla, toMatricula);
end;

procedure TFrmAtividades.ActFolhaPresencaDuplaNomesExecute(Sender: TObject);
begin
  inherited;
 self.PrintFolhaPresenca(tfDupla, toNome);
end;

procedure TFrmAtividades.ActFolhaPresencaDuplaNomesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active) and not (CdsAgenda.IsEmpty)
   and (Trim(CdsAgenda.Fields.FieldByName('campro').AsString) = 'LEC') //do not localize!
   and not (ToBoolean(CdsAgenda.Fields.FieldByName('indescint').AsString));
end;

procedure TFrmAtividades.ActFolhaPresencaSimplesMatriculaExecute(
  Sender: TObject);
begin
  inherited;
 self.PrintFolhaPresenca(tfSimples, toMatricula);
end;

procedure TFrmAtividades.ActFolhaPresencaSimplesNomesExecute(Sender: TObject);
begin
  inherited;
 self.PrintFolhaPresenca(tfSimples, toNome);
end;

procedure TFrmAtividades.ActNextExecute(Sender: TObject);
var
Data1, Data2: TDate;
begin
  inherited;
  Data1 := GetNextDate(DataInicial, TipoAgenda);
  Data2 := GetNextDate(DataFinal, TipoAgenda);
  AbrirAgenda(Data1, Data2);
end;

procedure TFrmAtividades.ActNovaAtividadeEIExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     begin
      IAgenda.NovaAtividade(ctEI, nil);
     end;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActNovaAtividadeEIUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and (Assigned(IRemoteCon))
   and (cfCadastrarAtividadeEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAtividades.ActNovaAtividadeSIMExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     begin
      IAgenda.NovaAtividade(ctSimpatizantes, nil);
     end;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActNovaAtividadeSIMUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and (Assigned(IRemoteCon))
   and (cfCadastrarAtividadeSIM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAtividades.ActNovaAtividadeTMExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     begin
      IAgenda.NovaAtividade(ctTM, nil);
     end;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActNovaAtividadeTMUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and (Assigned(IRemoteCon))
   and (cfCadastrarAtividadeTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAtividades.ActNovaAtividadeTPExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     begin
      IAgenda.NovaAtividade(ctTP, nil);
     end;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActNovaAtividadeTPUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsAgenda.Active)
   and (Assigned(IRemoteCon))
   and (cfCadastrarAtividadeTP in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures)
   and (IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmAtividades.ActAgendaLocalExecute(Sender: TObject);
begin
  inherited;
  DoFiltrarAgenda;
end;

procedure TFrmAtividades.ActParticipantesExecute(Sender: TObject);
var
codati: integer;
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
  inherited;
  if not TAction(Sender).Enabled then
   Exit;

  if not CanEdit then
   Exit;

  {Checa se a atividade é destinada a um grupo específico da escola interna.
  Neste caso, não será possível cadastrar participantes.}
  if HasGroupEI then
   begin
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.AgendaAtividades, TCosmosInfoMsg.ParticipantesGrupoEI);
    Exit;
   end;

 if not CanEdit then
  Exit;

 codati := CdsAgenda.Fields.FieldByName('codati').AsInteger;


 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.EditarParticipantes(codati);
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;

end;

procedure TFrmAtividades.ActPrintBoletimExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
  Data1, Data2: TDateTime;
begin
  inherited;
  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     IReport := AForm as IReportCenter;
     if Assigned(IReport) then
       begin
        Data1 := CdsAgenda.Params.Items[0].Value;
        Data2 := CdsAgenda.Params.Items[1].Value;
        IReport.PrintBoletimInfo(Data1, Data2);
       end;

     AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAtividades.ActPrintBoletimUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled :=  False;//ICosmosApp.CosmosModule = cmSecretarias;
end;

procedure TFrmAtividades.ActPriorExecute(Sender: TObject);
var
Data1, Data2: TDate;
begin
  inherited;
  Data1 := GetPreviousDate(DataInicial, TipoAgenda);
  Data2 := GetPreviousDate(DataFinal, TipoAgenda);
  AbrirAgenda(Data1, Data2);
end;

procedure TFrmAtividades.ActSituacaoAtividadesExecute(Sender: TObject);
begin
  inherited;
  FrmStatusFrequencias := TFrmStatusFrequencias.Create(Application);

  try
    FrmStatusFrequencias.ShowModal;

  finally
    if Assigned(FrmStatusFrequencias) then
     FreeAndNil(FrmStatusFrequencias);
  end;
end;

procedure TFrmAtividades.ActSituacaoAtividadesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ICosmosApp.CosmosModule = cmSecretarias) and (Assigned(IRemoteCon))
    and (IRemoteCon.Connected);
end;

procedure TFrmAtividades.ActPrintEscalasExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
begin
  inherited;
  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     IReport := AForm as IReportCenter;
     if Assigned(IReport) then
       begin
        IReport.PrintReport(TCosmosReportsNames.EscalasAtividades);
       end;

     AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAtividades.ActPrintEscalasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := False;//(CdsAgenda.Active) and not (CdsAgenda.IsEmpty);
end;

procedure TFrmAtividades.ActTiposAtividadesExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAgenda: IAgendaAtividades;
begin
 inherited;
 AClass := ICosmosApp.LoadClass('dlgagenda.bpl', 'TAgendaControler', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAgenda := AClass as IAgendaAtividades;
    if IAgenda <> nil then
     IAgenda.CadastrarTiposAtividades;
   end;

 finally
  if Assigned(IAgenda) then IAgenda := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAtividades.ActTiposAtividadesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon))
    and (cfTiposAtividades in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmAtividades.ActViewSearchBarExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

function TFrmAtividades.CanDelete: boolean;
begin
 with CdsAgenda.Fields do
  begin
  //Checa se a atividade é promovida pelo foco atual
   Result := FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID;

   if not Result then
    begin
     ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.AgendaAtividades, TCosmosInfoMsg.PromotorAtividade);
     Exit;
    end;


   if (FieldByName('campro').AsString = 'LEC') and (ToBoolean(FieldByName('indescint').AsString) = False) then
    Result := ctLectorium in IRemoteCon.CurrentConnectionInfo.CamposTrabalho
   else
   if (FieldByName('campro').AsString = 'LEC') and (ToBoolean(FieldByName('indescint').AsString) = True) then
    Result := ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho
   else
   if (FieldByName('campro').AsString = 'TMO') then
    Result := ctTM in IRemoteCon.CurrentConnectionInfo.CamposTrabalho
   else
   if (FieldByName('campro').AsString = 'TPU') then
    Result := ctTP in IRemoteCon.CurrentConnectionInfo.CamposTrabalho;
  end;

  if not Result then
   ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.AgendaAtividades, TCosmosInfoMsg.DelAtividade);
end;

function TFrmAtividades.CanEdit: boolean;
begin
 with CdsAgenda.Fields do
  begin
  //Checa se a atividade é promovida pelo foco atual
   Result := FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID;
   if not Result then
    begin
     ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.AgendaAtividades, TCosmosInfoMsg.PromotorAtividade);
     Exit;
    end;
    
   //Checa se o usuário pode editar a atividade...
   if (FieldByName('campro').AsString = 'LEC') and (ToBoolean(FieldByName('indescint').AsString) = False) then
    Result := cfAlterarAtividadeLectorium in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures
   else
   if (FieldByName('campro').AsString = 'LEC') and (ToBoolean(FieldByName('indescint').AsString) = True) then
    Result := cfAlterarAtividadeEI in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures
   else
   if (FieldByName('campro').AsString = 'TMO') then
    Result := cfAlterarAtividadeTM in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures
   else
   if (FieldByName('campro').AsString = 'TPU') then
    Result := cfAlterarAtividadeTP in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures;
   end;

   if not Result then
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.AgendaAtividades, TCosmosInfoMsg.DelAtividade);
end;

function TFrmAtividades.HasGroupEI: boolean;
begin
 Result := (CdsAgenda.Active) and not (CdsAgenda.IsEmpty)
  and not (CdsAgenda.Fields.FieldByName('codgru').IsNull);
end;

procedure TFrmAtividades.CdsAgendaAfterDelete(DataSet: TDataSet);
begin
  inherited;
  if CdsAgenda.ChangeCount > 0 then
   CdsAgenda.ApplyUpdates(0);
end;

procedure TFrmAtividades.CdsAgendaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsAgenda.Filtered := ActAgendaLocal.Checked;
end;

procedure TFrmAtividades.CdsAgendaReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.AgendaAtividades, E.Message);
end;

procedure TFrmAtividades.DckTabCamposClick(Sender: TObject);
begin
  inherited;
  DoFiltrarAgenda;
end;

procedure TFrmAtividades.DoFiltrarAgenda;
var
s: string;
begin
 try
  with CdsAGenda do
   begin
    if not Active then Exit;
    DisableControls;

    s := '';

    case DckTabCampos.TabIndex of
     0: s := '';
     1: s := Format('CAMPRO = %s and INDESCINT = %s ', [QuotedStr('LEC'),QuotedStr('Não')]); //do not localize!
     2: s := Format('CAMPRO = %s ', [QuotedStr('TMO')]); //do not localize!
     3: s := Format('CAMPRO = %s ', [QuotedStr('TPU')]); //do not localize!
     4: s := Format('CAMPRO = %s ', [QuotedStr('SIM')]); //do not localize!
     5: s := Format('CAMPRO = %s and INDESCINT = %s ', [QuotedStr('LEC'),QuotedStr('Sim')]); //do not localize!
    end;

    if ActAgendaLocal.Checked then
     begin
       if s = '' then
        s := Format('CODFOC = %d ',[ICosmosApp.ActiveFocus.FocusID])
       else
        s := s + Format(' and CODFOC = %d ',[ICosmosApp.ActiveFocus.FocusID])
     end;

    Filter := s;
    if Filter <> '' then
     Filtered := True;

   end;

 finally
  CdsAgenda.EnableControls;
 end;
end;

procedure TFrmAtividades.ExportData;
var
 AModule: HModule;
 AClass: TInterfacedPersistent;
 IExporter: IExporterDialogs;
begin
  inherited;
  AClass := ICosmosApp.LoadClass('dlgexporter.bpl', 'TDlgExporterControler', AModule);

  try
   if (AModule <> 0) and (AClass <> nil) then
    begin
     IExporter := AClass as IExporterDialogs;
     if IExporter <> nil then
      begin
       IExporter.ExportarAgendaAtividades;
      end;
    end;

  finally
   if Assigned(IExporter) then IExporter := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmAtividades.FmeGridSearch2DBGrid1DblClick(Sender: TObject);
var
campro, indescint: string;
begin
  inherited;

  if not FmeGridSearch1.CanDblClick then
   Exit;

  if not CanEdit then
   Exit;   

  if (CdsAgenda.Active) and not (CdsAgenda.IsEmpty) then
   begin
    campro := Trim(CdsAgenda.Fields.FieldByName('campro').AsString);
    indescint := Trim(CdsAgenda.Fields.FieldByName('indescint').AsString);

    if (campro = 'LEC') and not (ToBoolean(indescint)) then
     ActEditarAgenda.Execute
    else
    if campro = 'TMO' then
     ActEditarAgendaTM.Execute
    else
    if (campro = 'LEC') and (Toboolean(indescint)) then
     ActEditarAgendaEI.Execute
    else
    if campro = 'TPU' then
     ActEditarAgendaTP.Execute;
   end;
end;

procedure TFrmAtividades.FmeGridSearch2DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Dataset: TDataset;
begin
  inherited;
  //Destaca com cores as atividades do foco corrente.
  Dataset := DsrAgenda.DataSet;

  FmeGridSearch1.DBGrid1.Canvas.FillRect(Rect);

  //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
  if  gdSelected in State then
   begin
    FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
    FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
   end;

    if Dataset.FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID then
     FmeGridSearch1.DBGrid1.Canvas.Font.Color := clWindowText//cor "ativa" de texto.
    else
     FmeGridSearch1.DBGrid1.Canvas.Font.Color := clGrayText; //Cor de background de texto


  FmeGridSearch1.DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmAtividades.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsAgenda;
end;

procedure TFrmAtividades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsAgenda.Active then CdsAgenda.Close;
 CdsAgenda.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(FDataNavigator) then
  FreeAndNil(FDataNavigator);

 inherited;
end;

procedure TFrmAtividades.FormCreate(Sender: TObject);
var
Data: TDateTime;
begin
  inherited ;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
  CdsAgenda.RemoteServer := FRemoteConnection;

  self.ActionManager1.Style := ICosmosApp.InterfaceStyle;
  ActPrintBoletim.Enabled := ICosmosApp.CosmosModule = cmSecretarias;
  //ActFolhaPresenca.Enabled := ICosmosApp.CosmosModule = cmSecretarias;
  FmeGridSearch1.SearchFields := 'destipati';

  if (IRemoteCon <> nil) and (IRemoteCon.Connected) then
   begin
    Data := IRemoteCon.ServerDateTime;
    LblData.Caption := FormatDateTime('dddd, d "de" mmmm "de" yyyy',Data);
   end;

  FDataNavigator := TDatasetDataNavigator.Create(CdsAgenda);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  ActAgendaMensal.Execute;
end;

function TFrmAtividades.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormAgendaAtividades;
end;

function TFrmAtividades.GetFormIDName: string;
begin
 Result := 'Secretarias.Atividades';
end;

function TFrmAtividades.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmAtividades.GetHelpID: integer;
begin

end;

function TFrmAtividades.GetNextDate(const Data: TDate;
  Tipo: TTipoAgenda): TDate;
var
D, M, Y: word;
begin
 case tipo of
   taSemanal: Result := Data + DaysPerWeek;
   taQuinzenal: Result := Data + 15;
   taMensal:
    begin
     DecodeDate(Data, Y, M, D);
     if M <> 12 then
      Inc(M)
     else
      begin
       M := 1;
       Inc(Y);
      end;

     if D = 1 then
       Result := EncodeDate(Y, M, D) //dia 1º do mês
     else
      begin
       D := DaysInAMonth(Y, M);
       Result := EncodeDate(Y, M, D) //Último dia do mês
      end;
    end;
   taAnual: Exit;
 end;


end;

function TFrmAtividades.GetPreviousDate(const Data: TDate;
  Tipo: TTipoAgenda): TDate;
var
D, M, Y: word;
begin
 case tipo of
   taSemanal: Result := Data - DaysPerWeek;
   taQuinzenal: Result := Data - 15;
   taMensal:
    begin
     DecodeDate(Data, Y, M, D);
     if M <> 1 then
      Dec(M)
     else
      begin
       M := 12;
       Dec(Y);
      end;
     if D = 1 then
       Result := EncodeDate(Y, M, D) //dia 1º do mês
     else
      begin
       D := DaysInAMonth(Y, M);
       Result := EncodeDate(Y, M, D) //Último dia do mês
      end;
    end;
   taAnual: Exit;
 end;
end;

function TFrmAtividades.GetTitle: string;
begin
 Result := 'Agenda de Atividades';
end;

procedure TFrmAtividades.Locate;
begin
 IRemoteCon.DefaultLocate;
end;

procedure TFrmAtividades.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAtividades.PrintFolhaPresenca(Folha: TTipoFolhaPresenca;
  Ordenacao: TTipoOrdenacao);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
  aData: TCosmosData;
begin
  inherited;
  aData := TCosmosData.Create(7);
  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     IReport := AForm as IReportCenter;
     if Assigned(IReport) then
       begin
         aData.WriteValue('CODATI', CdsAgenda.Fields.FieldByName('CODATI').Value);
         aData.WriteValue('DESTIPATI', CdsAgenda.Fields.FieldByName('DESTIPATI').Value, 1);
         aData.WriteValue('DATATI', CdsAgenda.Fields.FieldByName('DATATI').Value, 2);
         aData.WriteValue('HORATI', CdsAgenda.Fields.FieldByName('HORATI').Value, 3);
         aData.WriteValue('CAMPRO', CdsAgenda.Fields.FieldByName('CAMPRO').Value, 4);
         aData.WriteValue('SIGFOC', CdsAgenda.Fields.FieldByName('SIGFOC').Value, 5);

         case Ordenacao of
           toMatricula: aData.WriteValue('TIPORD', 'Matrícula', 6); //do not localize!
           toNome: aData.WriteValue('TIPORD', 'Nome', 6); //do not localize!
         end;

         IReport.PrintFolhaPresenca(aData, Folha);
         end;

     AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   if Assigned(aData) then FreeAndNil(aData);
   UnloadPackage(AModule);
  end;
end;

function TFrmAtividades.ToBoolean(const Value: string): boolean;
begin
 Result := Copy(Value, 1, 1) = 'S';
end;

procedure TFrmAtividades.UpdateData(Sender: TObject);
begin
  inherited;
  AbrirAgenda(FDataInicial, FDataFinal);
end;

procedure TFrmAtividades.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
  DckTabCampos.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmAtividades);

finalization
 UnRegisterClass(TFrmAtividades);

end.
