unit cosmos.secretarias.view.membros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.frames.gridsearch, Tabs,
  DockTabSet, DB, DBClient, cosmos.system.messages, ActnMan, Menus, ActnPopup,
  XPStyleActnCtrls,  ToolWin, ActnCtrls, Cosmos.Framework.Interfaces.Root,
  cosmos.classes.application, cosmos.classes.security, cosmos.framework.interfaces.dialogs,
  cosmos.classes.ServerInterface, PlatformDefaultStyleActnCtrls, Data.SqlExpr,
  cosmos.framework.datanavigators.datasets, System.Actions,
  Cosmos.Framework.Interfaces.DataAcess;

type
  TTipoListagem = (tlAlfabetica, tlDiscipulado);

  TFrmMembros = class(TFrmCosmosDocked)
    TabSetDiscipulados: TDockTabSet;
    CdsTMB: TClientDataSet;
    DsrTMB: TDataSource;
    TabSetAlfabetico: TDockTabSet;
    ActEnderecos: TAction;
    ActMeiosContatos: TAction;
    ActFamiliares: TAction;
    ActInfoMedicas: TAction;
    ActDispensas: TAction;
    ActHistorico: TAction;
    ActNovo: TAction;
    ActEditarCadastro: TAction;
    PopupActionBar1: TPopupActionBar;
    PopupActionBar2: TPopupActionBar;
    ActionManager1: TActionManager;
    ActListagemAlfabetica: TAction;
    ActListagemDiscipulados: TAction;
    ListagemAlfabtica1: TMenuItem;
    ListagemporDiscipulados1: TMenuItem;
    ActMembrosAtivos: TAction;
    ActMembrosInativos: TAction;
    AlterarCadastro1: TMenuItem;
    NovoJovem1: TMenuItem;
    Endereos1: TMenuItem;
    Familiares1: TMenuItem;
    ActFicha: TAction;
    Documentos1: TMenuItem;
    FichadoJovem1: TMenuItem;
    N1: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ActBarraPesquisa: TAction;
    ActTransferir: TAction;
    ActDesligamento: TAction;
    ActReligamento: TAction;
    N3: TMenuItem;
    MeiosdeContatos1: TMenuItem;
    Histrico1: TMenuItem;
    N2: TMenuItem;
    Listagem1: TMenuItem;
    ListagemAlfabtica2: TMenuItem;
    ListagemporGrupos1: TMenuItem;
    ActRetrogradacao: TAction;
    ActCarteirinha: TAction;
    CarteirinhadoMembro1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    procedure ActCarteirinhaExecute(Sender: TObject);
    procedure ActRetrogradacaoExecute(Sender: TObject);
    procedure ActHistoricoUpdate(Sender: TObject);
    procedure ActEditarCadastroUpdate(Sender: TObject);
    procedure ActHistoricoExecute(Sender: TObject);
    procedure ActMembrosAtivosExecute(Sender: TObject);
    procedure ActReligamentoUpdate(Sender: TObject);
    procedure ActReligamentoExecute(Sender: TObject);
    procedure ActDesligamentoUpdate(Sender: TObject);
    procedure ActDesligamentoExecute(Sender: TObject);
    procedure ActTransferirExecute(Sender: TObject);
    procedure ActBarraPesquisaExecute(Sender: TObject);
    procedure ActFichaUpdate(Sender: TObject);
    procedure ActFichaExecute(Sender: TObject);
    procedure ActDispensasExecute(Sender: TObject);
    procedure ActInfoMedicasExecute(Sender: TObject);
    procedure ActFamiliaresExecute(Sender: TObject);
    procedure ActMeiosContatosExecute(Sender: TObject);
    procedure ActEnderecosExecute(Sender: TObject);
    procedure ActEditarCadastroExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ActListagemDiscipuladosExecute(Sender: TObject);
    procedure ActListagemAlfabeticaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNovoUpdate(Sender: TObject);
    procedure ActEnderecosUpdate(Sender: TObject);
    procedure ActMeiosContatosUpdate(Sender: TObject);
    procedure ActFamiliaresUpdate(Sender: TObject);
    procedure ActInfoMedicasUpdate(Sender: TObject);
    procedure ActDispensasUpdate(Sender: TObject);
    procedure ActTransferirUpdate(Sender: TObject);
    procedure ActRetrogradacaoUpdate(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TDatasetDataNavigator;
    FTipoListagem: TTipoListagem;
    FDiscipulado: string;
    FLetter2: string;
    FLetter1: string;
    procedure SetTipoListagem(const Value: TTipoListagem);
    procedure ListarDiscipulados;
    procedure ListarMembros;
    procedure UpdateData(Sender: TObject);

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
    property Letter1: string read FLetter1 write FLetter1 ;
    property Letter2: string read FLetter2 write FLetter2 ;    
    property TipoListagem: TTipoListagem read FTipoListagem
       write SetTipoListagem default tlAlfabetica;    
  end;

var
  FrmMembros: TFrmMembros;

implementation

uses cosmos.secretarias.view.cadastromembros;

{$R *.dfm}

procedure TFrmMembros.ActBarraPesquisaExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmMembros.ActDesligamentoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Desliga o membro.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := CdsTMB.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.DesligarCadastrado(codcad) then
        self.UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActDesligamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (CdsTMB.Fields.FieldByName('indati').Value = 'S')
   and (IRemoteCon.CurrentConnectionMode <> cmRead)
   and (cfDesligarMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActDispensasExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IDispensas: ICosmosDispensas;
begin
  inherited;
  if CdsTMB.IsEmpty then
   Exit;

  AForm := ICosmosApp.LoadDialog('dispensas.bpl', 'TFrmDispensas', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      with AForm do
       begin
        if Supports(AForm, ICosmosDispensas) then
         IDispensas := AForm as ICosmosDispensas;
        if Assigned(IDispensas) then
         IDispensas.CadastrarDispensas(CdsTMB.Fields.FieldByName('codcad').AsInteger,
           CdsTMB.Fields.FieldByName('nomcad').AsString);
        Free;
       end;
    end;

   finally
     if Assigned(IDispensas) then
      IDispensas := nil;
     UnloadPackage(AModule);
    end;
end;

procedure TFrmMembros.ActDispensasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (cfDispensasMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActEditarCadastroExecute(Sender: TObject);
begin
  inherited;
  if not FmeGridSearch1.CanDblClick then
   Exit;

  try
   if not (CdsTMB.Active) or (CdsTMB.IsEmpty) then
    Exit;

    if not Assigned(FrmCadastroMembros) then
     FrmCadastroMembros := TFrmCadastroMembros.Create(self);
    FrmCadastroMembros.EditarMembro(CdsTMB.Fields.FieldByName('codcad').AsInteger);


  finally
    if Assigned(FrmCadastroMembros) then
     FreeAndNil(FrmCadastroMembros);
  end;
end;

procedure TFrmMembros.ActEditarCadastroUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty);
end;

procedure TFrmMembros.ActEnderecosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IEndereco: ICosmosEnderecos;
begin
  inherited;
  if CdsTMB.IsEmpty then
   Exit;

  AForm := ICosmosApp.LoadDialog('cadend.bpl', 'TFrmCadastroEndereco', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      with AForm do
       begin
        if Supports(AForm, ICosmosEnderecos) then
         IEndereco := AForm as ICosmosEnderecos;
        if Assigned(IEndereco) then
         IEndereco.GetEnderecosCadastrado(CdsTMB.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

  finally
   if Assigned(IEndereco) then
    IEndereco := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActEnderecosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (cfEnderecoMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActFamiliaresExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IFamiliares: ICosmosFamiliares;
begin
  inherited;
  if CdsTMB.IsEmpty then
   Exit;

  AForm := ICosmosApp.LoadDialog('familiares.bpl', 'TFrmCadastroFamiliares', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      with AForm do
       begin
        if Supports(AForm, ICosmosFamiliares) then
         IFamiliares := AForm as ICosmosFamiliares;
        if Assigned(IFamiliares) then
         IFamiliares.ShowFamiliares(CdsTMB.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

  finally
   if Assigned(IFamiliares) then
    IFamiliares := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActFamiliaresUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (cfFamiliaresMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActFichaExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IRep: IReportCenter;
begin
  inherited;
  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       IRep := AForm as IReportCenter;
       if Assigned(IRep) then
        begin
         IRep.ReportFile :=  ICosmosApp.IApplicationPaths.ReadReportsFolder + '\' + sSecretariasReportFile;
         IRep.PrintFichaMembro(CdsTMB.Fields.FieldByName('matcad').Value);
        end;

       Free;
      end;
    end;

  finally
   if Assigned(IRep) then
    IRep := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActFichaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := not CdsTMB.IsEmpty;
end;

procedure TFrmMembros.ActHistoricoExecute(Sender: TObject);
var
  AForm: TCustomForm;
  IHistorico: ICosmosHistorico;
  codcad: integer;
begin
  inherited;
  if not (CdsTMB.Active) or (CdsTMB.IsEmpty) then
   Exit;

  AForm := ICosmosApp.OpenRegisteredWindow('historico.bpl', 'TFrmHistorico');
  if AForm <> nil then
  begin
   with AForm do
    begin
     IHistorico := AForm as ICosmosHistorico;
     codcad := CdsTMB.Fields.FieldByName('codcad').AsInteger;
     if Assigned(IHistorico) then
      IHistorico.LoadHistorico(codcad);
    end;
  end;
end;

procedure TFrmMembros.ActHistoricoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (cfHistoricoMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActInfoMedicasExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IInfo: ICosmosInfoMedicas;
begin
  inherited;
  if CdsTMB.IsEmpty then
   Exit;

  AForm := ICosmosApp.LoadDialog('infmed.bpl', 'TFrmInformacoesMedicas', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      with AForm do
       begin
        if Supports(AForm, ICosmosInfoMedicas) then
         IInfo := AForm as ICosmosInfoMedicas;
        if Assigned(IInfo) then
         IInfo.InfoMedicas(CdsTMB.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

  finally
   if Assigned(IInfo) then
    IInfo := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActInfoMedicasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (cfInfoMedicasMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActCarteirinhaExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IRep: IReportCenter;
begin
  inherited;

  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       IRep := AForm as IReportCenter;
       if Assigned(IRep) then
        begin
         IRep.ReportFile :=  ICosmosApp.IApplicationPaths.ReadReportsFolder + '\' + sSecretariasReportFile;
         IRep.PrintCarteiraMembro(CdsTMB.Fields.FieldByName('matcad').Value);
        end;

       Free;
      end;
    end;

  finally
   if Assigned(IRep) then
    IRep := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActRetrogradacaoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Registra a retrogradação discipular de um cadastrado.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := CdsTMB.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.RetrogradarCadastrado(codcad) then
        UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActRetrogradacaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (CdsTMB.Fields.FieldByName('indati').Value = 'S')
   and (IRemoteCon.CurrentConnectionMode <> cmRead)
   and (cfRetrogradarMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActMembrosAtivosExecute(Sender: TObject);
begin
  inherited;
  ListarMembros;
end;

procedure TFrmMembros.ActListagemAlfabeticaExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlAlfabetica;
end;

procedure TFrmMembros.ActListagemDiscipuladosExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlDiscipulado;
end;

procedure TFrmMembros.ActMeiosContatosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IContatos: ICosmosMeiosContatos;
begin
  inherited;
  if CdsTMB.IsEmpty then
   Exit;

  AForm := ICosmosApp.LoadDialog('meicont.bpl', 'TFrmMeiosContatos', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      with AForm do
       begin
        if Supports(AForm, ICosmosMeiosContatos) then
         IContatos := AForm as ICosmosMeiosContatos;
        if Assigned(IContatos) then
         IContatos.ShowMeiosContatosAluno(CdsTMB.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

   finally
     if Assigned(IContatos) then
      IContatos := nil;
     UnloadPackage(AModule);
   end;
end;

procedure TFrmMembros.ActMeiosContatosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (cfMeiosContatosMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActNovoExecute(Sender: TObject);
begin
  inherited;
  try
    if not Assigned(FrmCadastroMembros) then
     FrmCadastroMembros := TFrmCadastroMembros.Create(self);
    FrmCadastroMembros.NovoMembro;


  finally
    if Assigned(FrmCadastroMembros) then
     FreeAndNil(FrmCadastroMembros);
  end;
end;

procedure TFrmMembros.ActNovoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.CurrentConnectionMode <> cmRead)
  and (cfCadastrarMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActReligamentoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Religa o membro.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := CdsTMB.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.ReligarCadastrado(codcad) then
        self.UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActReligamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (CdsTMB.Fields.FieldByName('indati').Value = 'N')
   and (IRemoteCon.CurrentConnectionMode <> cmRead)
   and (cfReligarMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ActTransferirExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Transfere o membro para outro foco.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := CdsTMB.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.TransferirCadastrado(codcad) then
        self.UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.ActTransferirUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTMB.Active) and not (CdsTMB.IsEmpty)
   and (CdsTMB.Fields.FieldByName('indati').Value = 'S')
   and (IRemoteCon.CurrentConnectionMode <> cmRead)
   and (cfTransferirMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmMembros.ExportData;
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
       IExporter.ExportarMembros;
      end;
    end;

  finally
   if Assigned(IExporter) then IExporter := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmMembros.TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
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
  end;

  ListarMembros;
end;

procedure TFrmMembros.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsTMB;
  IRemoteCon.ServerClass := scMembros;
end;

procedure TFrmMembros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmCadastroMembros := nil;
end;

procedure TFrmMembros.FormCreate(Sender: TObject);
begin
  inherited;
  CdsTMB.RemoteServer := IRemoteCon.ConnectionBroker;

  FDataNavigator := TDatasetDataNavigator.Create(CdsTMB);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  Letter1 := 'A';
  Letter2 := 'B';

  ListarMembros;
  ListarDiscipulados;

  FmeGridSearch1.SearchFields := 'nomcad';
end;

function TFrmMembros.GetFormDescription: string;
begin
 Result := sDescFormTM;
end;

function TFrmMembros.GetFormIDName: string;
begin
 Result := 'Secretarias.TMB';
end;

function TFrmMembros.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmMembros.GetHelpID: integer;
begin

end;

function TFrmMembros.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmMembros.ListarDiscipulados;
var
ADataset: TClientDataset;
sDisc: string;
begin
 //Lista os discipulados no Tabset, para a navegação do usuário.
 ADataset := TClientDataset.Create(self);
 {Evita que o método "ListarMembros" seja executado desnecessariamente, pois
  este método é chamado dinamicamente durante a construção do form. Nesse
  momento, não é necessário chamar o método "ListarMembros".}
 TabSetDiscipulados.OnChange := nil;

 try
  ADataset := IRemoteCon.OpenBufferedData(sBufDiscipulados);
  ADataset.Filter := Format('CAMDIS = %s', [quotedStr('TMB')]);
  ADataset.Filtered := True;

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
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFrmMembros.ListarMembros;
var
AParamsList: TSQLParams;
ASearch: TCosmosSearch;
ADataset: TSQLDataset;
begin
 case TipoListagem of
  tlAlfabetica:
   begin
    AParamsList := TSQLParams.Create(5);
    AParamsList.AppendData(QuotedStr(self.Letter1));
    AParamsList.AppendData(QuotedStr(self.Letter2), 1);
    AParamsList.AppendData(ICosmosApp.ActiveFocus.FocusID, 2);
    AParamsList.AppendData(ActMembrosAtivos.Checked, 3);
    AParamsList.AppendData(QuotedStr('TMB'), 4);
    ASearch := csListaCadastradosNomeFoco;
   end;
 tlDiscipulado:
   begin
    AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(QuotedStr(Discipulado));
    AParamsList.AppendData(ActMembrosAtivos.Checked, 1);
    AParamsList.AppendData(ICosmosApp.ActiveFocus.FocusID, 2);
    ASearch := csListaCadastradosDiscipuladoFoco;
   end;
 end;

 ADataset := TSQLDataset.Create(nil);

 try
  CdsTMB.DisableControls;
  ADataset := IRemoteCon.ExecuteDQL(ASearch, AParamsList.Params) as TSQLDataset;

  if (ADataset <> nil) and (ADataset.Active) then
   CdsTMB := IRemoteCon.ToClientDataset(ADataset)
  else
   CdsTMB.Close;

  CdsTMB.EnableControls;
  if Assigned(AParamsList) then FreeAndNil(AParamsList);
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    CdsTMB.EnableControls;
    ICosmosApp.DlgMessage.ErrorMessage(sTitleSystemFailure, sErrorCadastradosSearch);
    ICosmosApp.MainLog.RegisterError(E.Message);
    if Assigned(AParamsList) then FreeAndNil(AParamsList);
    if Assigned(ADataset) then FreeAndNil(ADataset);
   end;
 end;
end;

procedure TFrmMembros.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmMembros.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmMembros.SetTipoListagem(const Value: TTipoListagem);
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
      TabSetDiscipulados.Visible := True;
      TabSetAlfabetico.Visible := False;
      Discipulado := TabSetDiscipulados.Tabs.Strings[TabSetDiscipulados.TabIndex];
      if TabSetDiscipulados.TabIndex <> 0 then
       TabSetDiscipulados.TabIndex := 0
      else
       TabSetDiscipulados.OnChange(TabSetDiscipulados, 0, vAllowChange);
     end;
    tlAlfabetica:
     begin
      TabSetDiscipulados.Visible := False;
      TabSetAlfabetico.Visible := True;
      if TabSetAlfabetico.TabIndex <> 0 then
       TabSetAlfabetico.TabIndex := 0
      else
       TabSetAlfabetico.OnChange(TabSetAlfabetico, 0, vAllowChange);
     end;
   end;
  end;
end;

procedure TFrmMembros.UpdateData(Sender: TObject);
begin
  inherited;
  ListarMembros;
end;

procedure TFrmMembros.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmMembros);

finalization
 UnRegisterClass(TFrmMembros);

end.
