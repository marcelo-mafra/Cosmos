unit cosmos.secretarias.view.mocidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.frames.gridsearch,
  Tabs, Datasnap.DSConnect, cosmos.system.formsconst,
  DockTabSet, DB, DBClient, cosmos.system.messages, ActnMan, Menus, ActnPopup,
  XPStyleActnCtrls, cosmos.classes.application, cosmos.classes.security, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.classes.ServerInterface, ToolWin,
  ActnCtrls, PlatformDefaultStyleActnCtrls, cosmos.framework.datanavigators.datasets,
  System.Actions, Cosmos.Framework.Interfaces.Applications;

type
  TTipoListagem = (tlAlfabetica, tlDiscipulado);
  TFrmJovensTM = class(TFrmCosmosDocked)
    TabSetDiscipulados: TDockTabSet;
    CdsJovensAlfa: TClientDataSet;
    DsrTM: TDataSource;
    TabSetAlfabetico: TDockTabSet;
    ActEnderecos: TAction;
    ActMeiosContatos: TAction;
    ActFamiliares: TAction;
    ActInfoMedicas: TAction;
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
    ActJovensAtivos: TAction;
    ActJovensInativos: TAction;
    AlterarCadastro1: TMenuItem;
    NovoJovem1: TMenuItem;
    Endereos1: TMenuItem;
    Familiares1: TMenuItem;
    ActFicha: TAction;
    Documentos1: TMenuItem;
    FichadoJovem1: TMenuItem;
    N1: TMenuItem;
    ActBatismo: TAction;
    Batismo1: TMenuItem;
    N2: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ActBarraPesquisa: TAction;
    ActTransferir: TAction;
    ActDesligamento: TAction;
    ActReligamento: TAction;
    N3: TMenuItem;
    MeiosdeContatos1: TMenuItem;
    Histrico1: TMenuItem;
    Listagem1: TMenuItem;
    ListagemAlfabtica2: TMenuItem;
    ListagemporGrupos1: TMenuItem;
    Sacramentos1: TMenuItem;
    N4: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    InformaesMdicas1: TMenuItem;
    N5: TMenuItem;
    Movimentaes1: TMenuItem;
    Desligamento1: TMenuItem;
    Religamento1: TMenuItem;
    ransferncia1: TMenuItem;
    CdsJovensDisc: TClientDataSet;
    procedure ActHistoricoUpdate(Sender: TObject);
    procedure ActEditarCadastroUpdate(Sender: TObject);
    procedure ActHistoricoExecute(Sender: TObject);
    procedure ActJovensAtivosExecute(Sender: TObject);
    procedure ActReligamentoUpdate(Sender: TObject);
    procedure ActReligamentoExecute(Sender: TObject);
    procedure ActDesligamentoUpdate(Sender: TObject);
    procedure ActDesligamentoExecute(Sender: TObject);
    procedure ActTransferirExecute(Sender: TObject);
    procedure ActBarraPesquisaExecute(Sender: TObject);
    procedure ActBatismoExecute(Sender: TObject);
    procedure ActFichaUpdate(Sender: TObject);
    procedure ActFichaExecute(Sender: TObject);
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
    procedure ActBatismoUpdate(Sender: TObject);
    procedure ActTransferirUpdate(Sender: TObject);
    procedure ActJovensInativosExecute(Sender: TObject);
    procedure ActJovensAtivosUpdate(Sender: TObject);
    procedure ActJovensInativosUpdate(Sender: TObject);
  private
    { Private declarations }
    FJovensAtivos: boolean;
    FActiveDataset: TClientDataset;
    FRemoteConnection: TDSProviderConnection;
    FDataNavigatorAlfa: TDatasetDataNavigator;
    FDataNavigatorDisc: TDatasetDataNavigator;
    FTipoListagem: TTipoListagem;
    FDiscipulado: string;
    FLetter2: string;
    FLetter1: string;
    procedure SetJovensAtivos(const Value: boolean);
    procedure SetTipoListagem(const Value: TTipoListagem);

    procedure ListarDiscipulados;
    procedure ListarJovensTM;
    procedure AtualizaGruposJovens;
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
    property ActiveDataset: TClientDataset read FActiveDataset;
    property JovensAtivos: boolean read FJovensAtivos write SetJovensAtivos;
    property Discipulado: string read FDiscipulado write FDiscipulado;
    property Letter1: string read FLetter1 write FLetter1 ;
    property Letter2: string read FLetter2 write FLetter2 ;    
    property TipoListagem: TTipoListagem read FTipoListagem
       write SetTipoListagem default tlAlfabetica;    
  end;

var
  FrmJovensTM: TFrmJovensTM;

implementation

uses cosmos.secretarias.view.cadastromocidade, Cosmos.Framework.Interfaces.DataAcess;

{$R *.dfm}

procedure TFrmJovensTM.ActBarraPesquisaExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmJovensTM.ActBatismoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Registra o batismo de um cadastrado.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
       IMovDiscipular.BatizarCadastrado(codcad);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmJovensTM.ActBatismoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (JovensAtivos = True)
   and (Assigned(IRemoteCon))
   and (sfBatismoJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmJovensTM.ActDesligamentoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Desliga o jovem do trabalho da mocidade.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.DesligarCadastrado(codcad) then
        UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmJovensTM.ActDesligamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (JovensAtivos = True)
   and (Assigned(IRemoteCon))
   and (sfDesligarJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmJovensTM.ActEditarCadastroExecute(Sender: TObject);
begin
  inherited;
  if not FmeGridSearch1.CanDblClick then
   Exit;

  try
   if not (ActiveDataset.Active) or (ActiveDataset.IsEmpty) then
    Exit;
    
    if not Assigned(FrmCadastroJovensTM) then
     FrmCadastroJovensTM := TFrmCadastroJovensTM.Create(self);
    FrmCadastroJovensTM.EditarJovemTM(ActiveDataset.Fields.FieldByName('codcad').AsInteger);


  finally
    if Assigned(FrmCadastroJovensTM) then
     FreeAndNil(FrmCadastroJovensTM);
  end;
end;

procedure TFrmJovensTM.ActEditarCadastroUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
  and (ActiveDataset.FieldValues['codcad'] <> null)
  and (Assigned(IRemoteCon))
  and (sfAlterarJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmJovensTM.ActEnderecosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IEndereco: ICosmosEnderecos;
begin
  inherited;
  if ActiveDataset.IsEmpty then
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
         IEndereco.GetEnderecosCadastrado(ActiveDataset.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

  finally
   if Assigned(IEndereco) then
    IEndereco := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmJovensTM.ActEnderecosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfEnderecoJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmJovensTM.ActFamiliaresExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IFamiliares: ICosmosFamiliares;
begin
  inherited;
  if ActiveDataset.IsEmpty then
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
         IFamiliares.ShowFamiliares(ActiveDataset.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

  finally
   if Assigned(IFamiliares) then
    IFamiliares := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmJovensTM.ActFamiliaresUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfFamiliaresJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmJovensTM.ActFichaExecute(Sender: TObject);
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
         IReport.PrintFichaJovemTM(ActiveDataset.Fields.FieldByName('matcad').Value);
        end;

       AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmJovensTM.ActFichaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
    and not ActiveDataset.IsEmpty
    and (ActiveDataset.FieldValues['codcad'] <> null)
end;

procedure TFrmJovensTM.ActHistoricoExecute(Sender: TObject);
var
  AForm: TCustomForm;
  IHistorico: ICosmosHistorico;
  codcad: integer;
begin
  inherited;
  if not (ActiveDataset.Active) or (ActiveDataset.IsEmpty) then
   Exit;

  AForm := ICosmosApp.OpenRegisteredWindow('historico.bpl', 'TFrmHistorico');
  if AForm <> nil then
  begin
   with AForm do
    begin
     IHistorico := AForm as ICosmosHistorico;
     codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
     if Assigned(IHistorico) then
      IHistorico.LoadHistorico(codcad);
    end;
  end;
end;

procedure TFrmJovensTM.ActHistoricoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfHistoricoJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmJovensTM.ActInfoMedicasExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IInfoMedicas: IInformacoesCadastrado;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('infcad.bpl', 'TInfoCadastradoController', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IInfoMedicas := AClass as IInformacoesCadastrado;
    if IInfoMedicas <> nil then
     begin
      IInfoMedicas.CadastrarInfoMedicas(ActiveDataset.Fields.FieldByName('codcad').AsInteger,
           ActiveDataset.Fields.FieldByName('nomcad').AsString);
     end;
   end;

 finally
  if Assigned(IInfoMedicas) then IInfoMedicas := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmJovensTM.ActInfoMedicasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfInfoMedicasJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmJovensTM.ActJovensAtivosExecute(Sender: TObject);
begin
  inherited;
  JovensAtivos := True;
end;

procedure TFrmJovensTM.ActJovensAtivosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := JovensAtivos;
end;

procedure TFrmJovensTM.ActJovensInativosExecute(Sender: TObject);
begin
  inherited;
  JovensAtivos := False;
end;

procedure TFrmJovensTM.ActJovensInativosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := not JovensAtivos;
end;

procedure TFrmJovensTM.ActListagemAlfabeticaExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlAlfabetica;
end;

procedure TFrmJovensTM.ActListagemDiscipuladosExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlDiscipulado;
end;

procedure TFrmJovensTM.ActMeiosContatosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IContatos: ICosmosMeiosContatos;
begin
  inherited;
  if ActiveDataset.IsEmpty then
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
         IContatos.ShowMeiosContatosAluno(ActiveDataset.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

  finally
   if Assigned(IContatos) then
    IContatos := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmJovensTM.ActMeiosContatosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfMeiosContatosJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmJovensTM.ActNovoExecute(Sender: TObject);
begin
 inherited;
 if not Assigned(FrmCadastroJovensTM) then
  FrmCadastroJovensTM := TFrmCadastroJovensTM.Create(self);

  try
    FrmCadastroJovensTM.NovoJovemTM;

  finally
    if Assigned(FrmCadastroJovensTM) then
     FreeAndNil(FrmCadastroJovensTM);
  end;
end;

procedure TFrmJovensTM.ActNovoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.CurrentConnectionMode <> cmRead)
  and (sfCadastrarJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmJovensTM.ActReligamentoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Religa o jovem do trabalho da mocidade.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
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

procedure TFrmJovensTM.ActReligamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (JovensAtivos = False)
   and (Assigned(IRemoteCon))
   and (sfReligarJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmJovensTM.ActTransferirExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Transfere o jovem da mocidade para outro foco.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
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

procedure TFrmJovensTM.ActTransferirUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (JovensAtivos = True)
   and (Assigned(IRemoteCon))
   and (sfTransferirJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmJovensTM.AtualizaGruposJovens;
var
 ISecretarias: ICosmosSecretarias;
begin
 //Esta rotina atualiza os grupos aos quais os jovens pertencem.
 ISecretarias := Application.MainForm as ICosmosSecretarias;

 try
  ISecretarias.UpdateAllYoungPupils(ICosmosApp.ActiveFocus.FocusID);

 finally
  begin
   if Assigned(ISecretarias) then ISecretarias := nil;
  end;
 end;
end;

procedure TFrmJovensTM.ExportData;
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
       IExporter.ExportarJovensTM;
      end;
    end;

  finally
   if Assigned(IExporter) then IExporter := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmJovensTM.TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
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

  ListarJovensTM;
end;

procedure TFrmJovensTM.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := ActiveDataset;

  case TipoListagem of
    tlAlfabetica: DataNavigator:= FDataNavigatorAlfa;
    tlDiscipulado: DataNavigator:= FDataNavigatorDisc;
  end;

  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmJovensTM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigatorAlfa) then FreeAndNil(FDataNavigatorAlfa);
  if Assigned(FDataNavigatorDisc) then FreeAndNil(FDataNavigatorDisc);

  inherited;

  Action := caFree;
  FrmJovensTM := nil;
end;

procedure TFrmJovensTM.FormCreate(Sender: TObject);
begin
  inherited;
  FActiveDataset := CdsJovensAlfa; //default
  FJovensAtivos := True; //default
  FmeGridSearch1.SearchFields := 'nomcad';
  Letter1 := 'A';
  Letter2 := 'B';

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scMocidade);
  CdsJovensAlfa.RemoteServer := FRemoteConnection;
  CdsJovensDisc.RemoteServer := FRemoteConnection;

  FDataNavigatorAlfa := TDatasetDataNavigator.Create(CdsJovensAlfa);
  FDataNavigatorDisc := TDatasetDataNavigator.Create(CdsJovensDisc);

  DataNavigator := FDataNavigatorAlfa;

  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  AtualizaGruposJovens;
  ListarJovensTM;
  TipoListagem := tlAlfabetica;

  ListarDiscipulados;
end;

function TFrmJovensTM.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormTM;
end;

function TFrmJovensTM.GetFormIDName: string;
begin
 Result := 'Secretarias.TM';
end;

function TFrmJovensTM.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmJovensTM.GetHelpID: integer;
begin

end;

function TFrmJovensTM.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmJovensTM.ListarDiscipulados;
var
ADataset: TClientDataset;
sDisc: string;
begin
 //Lista os discipulados no Tabset, para a navegação do usuário.
 ADataset := TClientDataset.Create(self);
 {Evita que o método "ListarJovensTM" seja executado desnecessariamente, pois
  este método é chamado dinamicamente durante a construção do form. Nesse
  momento, não é necessário chamar o método "ListarJovensTM".}
 TabSetDiscipulados.OnChange := nil;

 try
  ADataset := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);
  ADataset.Filter := Format('CAMDIS = %s', [quotedStr('TMO')]);
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
  if Assigned(ADataset) then
   ADataset.Free;
 end;
end;

procedure TFrmJovensTM.ListarJovensTM;
{var
AParamsList: TSQLParams;
ASearch: TCosmosSearch; }
begin
 case TipoListagem of
  tlAlfabetica:
   begin
    {AParamsList := TSQLParams.Create(5);
    AParamsList.AppendData(QuotedStr(self.Letter1));
    AParamsList.AppendData(QuotedStr(self.Letter2), 1);
    AParamsList.AppendData(ICosmosApp.ActiveFocus.FocusID, 2);
    AParamsList.AppendData(JovensAtivos, 3);
    AParamsList.AppendData(QuotedStr('TMO'), 4);
    ASearch := csListaCadastradosNomeFoco; }
    FActiveDataset := CdsJovensAlfa;
    CdsJovensAlfa.Params.ParamByName('param1').Value := self.Letter1;
    CdsJovensAlfa.Params.ParamByName('param2').Value := self.Letter2;
    CdsJovensAlfa.Params.ParamByName('param3').Value := ICosmosApp.ActiveFocus.FocusID;
    CdsJovensAlfa.Params.ParamByName('param4').Value := TDataConverter.ToBoleanString(JovensAtivos);
    CdsJovensAlfa.Params.ParamByName('param5').Value := 'TMO';

    if not Assigned(FDataNavigatorAlfa.OnUpdateData) then
      TDatasetDataNavigator(FDataNavigatorAlfa).OnUpdateData := UpdateData;

    DataNavigator := FDataNavigatorAlfa;
   end;
 tlDiscipulado:
   begin
    {AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(QuotedStr(Discipulado));
    AParamsList.AppendData(JovensAtivos, 1);
    AParamsList.AppendData(ICosmosApp.ActiveFocus.FocusID, 2);
    ASearch := csListaCadastradosDiscipuladoFoco;}
    FActiveDataset := CdsJovensDisc;
    CdsJovensDisc.Params.ParamByName('sigdis').Value := Discipulado;
    CdsJovensDisc.Params.ParamByName('indati').Value := TDataConverter.ToBoleanString(JovensAtivos);
    CdsJovensDisc.Params.ParamByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;

    if not Assigned(FDataNavigatorDisc.OnUpdateData) then
      TDatasetDataNavigator(FDataNavigatorDisc).OnUpdateData := UpdateData;

    DataNavigator := FDataNavigatorDisc;
   end;
 end;

 try
  ActiveDataset.DisableControls;
  DsrTM.DataSet := ActiveDataset;

  if ActiveDataset.Active then ActiveDataset.Close;
  ActiveDataset.Open;

  //IRemoteCon.ExecuteDQL(ASearch, AParams.Params, CdsTMAlfa);

 finally
  IRemoteCon.ActiveDataset := ActiveDataset;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
  ActiveDataset.EnableControls;
  //if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmJovensTM.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;

end;

procedure TFrmJovensTM.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmJovensTM.SetJovensAtivos(const Value: boolean);
begin
 if FJovensAtivos <> Value then
  begin
    FJovensAtivos := Value;
    ListarJovensTM;
  end;
end;

procedure TFrmJovensTM.SetTipoListagem(const Value: TTipoListagem);
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

procedure TFrmJovensTM.UpdateData(Sender: TObject);
begin
  inherited;
  self.ListarJovensTM;
end;

procedure TFrmJovensTM.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
 TabsetAlfabetico.Style := ICosmosApp.Components.TabsStyle;
 TabsetDiscipulados.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmJovensTM);

finalization
 UnRegisterClass(TFrmJovensTM);

end.
