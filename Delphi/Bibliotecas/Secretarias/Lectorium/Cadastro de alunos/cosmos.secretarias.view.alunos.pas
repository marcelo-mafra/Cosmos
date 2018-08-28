unit cosmos.secretarias.view.alunos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.framework.view.FrmDocked,
  Vcl.ActnList, ImgList, Data.DB, Datasnap.DBClient, ExtCtrls, cosmos.data.dbobjects,
  cosmos.frames.gridsearch, Tabs, DockTabSet, ToolWin, Vcl.ActnMan, ActnCtrls, DBCtrls,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  Menus, ActnPopup, cosmos.system.messages, StdCtrls, XPStyleActnCtrls, cosmos.system.files,
  cosmos.classes.security, PlatformDefaultStyleActnCtrls, cosmos.system.formsconst,
  cosmos.classes.application, cosmos.classes.ServerInterface, cosmos.business.focos,
  cosmos.framework.datanavigators.datasets, cosmos.framework.interfaces.dataacess,
  System.Actions, Datasnap.DSConnect, cosmos.framework.interfaces.applications,
  System.ImageList, cosmos.system.dataconverter;


type
  TTipoListagem = (tlAlfabetica, tlDiscipulado);
  TFrmAlunos = class(TFrmCosmosDocked)
    CdsAlunosAlfa: TClientDataSet;
    DsrAlunos: TDataSource;
    ActNovoAluno: TAction;
    TabSetAlfabetico: TDockTabSet;
    ActionToolBar1: TActionToolBar;
    ActionManager: TActionManager;
    ActAlterar: TAction;
    ActEnderecos: TAction;
    ActContatos: TAction;
    ActHistorico: TAction;
    ActFamiliares: TAction;
    PopupActionBar1: TPopupActionBar;
    ActSearchBar: TAction;
    ActDesligar: TAction;
    ActReligar: TAction;
    ImageList2: TImageList;
    ActTransferir: TAction;
    ActAlunosAtivos: TAction;
    ActAlunosInativos: TAction;
    ActRetrogradar: TAction;
    Histrico1: TMenuItem;
    ransferir1: TMenuItem;
    RetrogradarAluno1: TMenuItem;
    Religar1: TMenuItem;
    ActCarta: TAction;
    ActCasamento: TAction;
    ActBatismos: TAction;
    ActInfoMedicas: TAction;
    ActFuncoes: TAction;
    ActAptidoes: TAction;
    PopupActionBar2: TPopupActionBar;
    ActListaAlfabetica: TAction;
    ActListaDiscipulados: TAction;
    ListarAlfabeticamente1: TMenuItem;
    ListarporDiscipulados1: TMenuItem;
    TabSetDiscipulados: TDockTabSet;
    Listagem1: TMenuItem;
    ListarAlfabeticamente2: TMenuItem;
    ListarporDiscipulados2: TMenuItem;
    N1: TMenuItem;
    Sacramentos1: TMenuItem;
    Batismo1: TMenuItem;
    Casamento1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ActCarteirinha: TAction;
    ActFichaAluno: TAction;
    Documentos1: TMenuItem;
    CarteirinhadoAluno1: TMenuItem;
    FichadoAluno1: TMenuItem;
    AlterarCadastro1: TMenuItem;
    N4: TMenuItem;
    ActListagemDiscipulado: TAction;
    Listagempordiscipulados1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    AlterarCadastro2: TMenuItem;
    Endereos1: TMenuItem;
    MeiosdeContato1: TMenuItem;
    Movimentao1: TMenuItem;
    Desligar2: TMenuItem;
    CartadeFreqncia1: TMenuItem;
    NovoAluno1: TMenuItem;
    InformaesMdicas1: TMenuItem;
    N5: TMenuItem;
    Funes1: TMenuItem;
    Aptides1: TMenuItem;
    CdsAlunosDisc: TClientDataSet;
    ActPrintHistoric: TAction;
    HistricoDiscipular1: TMenuItem;
    procedure FmeGridSearch2DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActListagemDiscipuladoUpdate(Sender: TObject);
    procedure ActListagemDiscipuladoExecute(Sender: TObject);
    procedure ActFichaAlunoUpdate(Sender: TObject);
    procedure ActFichaAlunoExecute(Sender: TObject);
    procedure ActCarteirinhaExecute(Sender: TObject);
    procedure ActListaDiscipuladosExecute(Sender: TObject);
    procedure ActListaAlfabeticaExecute(Sender: TObject);
    procedure ActHistoricoUpdate(Sender: TObject);
    procedure ActAptidoesExecute(Sender: TObject);
    procedure ActFuncoesExecute(Sender: TObject);
    procedure ActInfoMedicasExecute(Sender: TObject);
    procedure ActCartaExecute(Sender: TObject);
    procedure ActCasamentoExecute(Sender: TObject);
    procedure ActBatismosExecute(Sender: TObject);
    procedure ActRetrogradarExecute(Sender: TObject);
    procedure ActAlunosAtivosExecute(Sender: TObject);
    procedure ActFamiliaresExecute(Sender: TObject);
    procedure ActTransferirExecute(Sender: TObject);
    procedure ActReligarUpdate(Sender: TObject);
    procedure ActDesligarUpdate(Sender: TObject);
    procedure ActReligarExecute(Sender: TObject);
    procedure ActDesligarExecute(Sender: TObject);
    procedure ActSearchBarExecute(Sender: TObject);
    procedure ActAlterarExecute(Sender: TObject);
    procedure ActHistoricoExecute(Sender: TObject);
    procedure ActContatosExecute(Sender: TObject);
    procedure ActEnderecosExecute(Sender: TObject);
    procedure ActNovoAlunoExecute(Sender: TObject);
    procedure TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNovoAlunoUpdate(Sender: TObject);
    procedure ActAlterarUpdate(Sender: TObject);
    procedure ActEnderecosUpdate(Sender: TObject);
    procedure ActContatosUpdate(Sender: TObject);
    procedure ActFamiliaresUpdate(Sender: TObject);
    procedure ActInfoMedicasUpdate(Sender: TObject);
    procedure ActFuncoesUpdate(Sender: TObject);
    procedure ActAptidoesUpdate(Sender: TObject);
    procedure ActRetrogradarUpdate(Sender: TObject);
    procedure ActCartaUpdate(Sender: TObject);
    procedure ActCasamentoUpdate(Sender: TObject);
    procedure ActBatismosUpdate(Sender: TObject);
    procedure ActTransferirUpdate(Sender: TObject);
    procedure ActAlunosInativosExecute(Sender: TObject);
    procedure ActAlunosAtivosUpdate(Sender: TObject);
    procedure ActAlunosInativosUpdate(Sender: TObject);
    procedure ActPrintHistoricExecute(Sender: TObject);
    procedure ActCarteirinhaUpdate(Sender: TObject);
  private
    { Private declarations }
    FAlunosAtivos: boolean;
    FLetter2: string;
    FLetter1: string;
    FTipoListagem: TTipoListagem;
    FDiscipulado: string;
    FDataNavigatorAlfa: TDatasetDataNavigator;
    FDataNavigatorDisc: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FActiveDataset: TClientDataset;

    procedure AtualizarJovensAlunos;
    procedure SetAlunosAtivos(const Value: boolean);
    procedure SetTipoListagem(const Value: TTipoListagem);
    procedure ListarAlunos;
    procedure ListarDiscipulados;
    function IsEscolaInterna: boolean; inline;
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
    property AlunosAtivos: boolean read FAlunosAtivos write SetAlunosAtivos;
    property Discipulado: string read FDiscipulado write FDiscipulado;
    property Letter1: string read FLetter1 write FLetter1 ;
    property Letter2: string read FLetter2 write FLetter2 ;
    property TipoListagem: TTipoListagem read FTipoListagem
       write SetTipoListagem default tlAlfabetica;
  end;

var
  FrmAlunos: TFrmAlunos;

implementation

uses cosmos.secretarias.view.cadastroalunos;

{$R *.dfm}

procedure TFrmAlunos.ActEnderecosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IEndereco: ICosmosEnderecos;
begin
  inherited;
  if ActiveDataset.IsEmpty then
   Exit;

  AForm := ICosmosApp.LoadDialog('cadend.bpl','TFrmCadastroEndereco',AModule);

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
   if Assigned(IEndereco) then IEndereco := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActEnderecosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and(sfEnderecoAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActFamiliaresExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IFamiliares: ICosmosFamiliares;
begin
  inherited;
  if ActiveDataset.IsEmpty then
   Exit;

  AForm := self.ICosmosApp.LoadDialog('familiares.bpl', 'TFrmCadastroFamiliares', AModule);

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
   if Assigned(IFamiliares) then IFamiliares := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActFamiliaresUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfFamiliareasAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActFichaAlunoExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
begin
  inherited;
  if ActiveDataset.IsEmpty then
   Exit;

  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter',AModule );

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     IReport := AForm as IReportCenter;
     if Assigned(IReport) then
       begin
         IReport.PrintFichaAluno(ActiveDataset.Fields.FieldByName('matcad').Value);
        end;

       AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActFichaAlunoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null);
end;

procedure TFrmAlunos.ActFuncoesExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IFuncoes: IInformacoesCadastrado;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('infcad.bpl', 'TInfoCadastradoController', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IFuncoes := AClass as IInformacoesCadastrado;
    if IFuncoes <> nil then
     begin
      IFuncoes.CadastrarFuncoes(ActiveDataset.Fields.FieldByName('codcad').AsInteger,
           ActiveDataset.Fields.FieldByName('nomcad').AsString);
     end;
   end;

 finally
  if Assigned(IFuncoes) then IFuncoes := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAlunos.ActFuncoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfFuncoesAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActHistoricoExecute(Sender: TObject);
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

procedure TFrmAlunos.ActHistoricoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon)) and
   (sfHistoricoAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActInfoMedicasExecute(Sender: TObject);
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

procedure TFrmAlunos.ActInfoMedicasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
  and (ActiveDataset.FieldValues['codcad'] <> null)
  and (sfInfoMedicasAluno in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActListaAlfabeticaExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlAlfabetica;
end;

procedure TFrmAlunos.ActListaDiscipuladosExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlDiscipulado;
end;

procedure TFrmAlunos.ActListagemDiscipuladoExecute(Sender: TObject);
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
         IReport.PrintListagemByDiscipulado(Discipulado);
        end;

     AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActListagemDiscipuladoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := TipoListagem = tlDiscipulado;
end;

procedure TFrmAlunos.ActRetrogradarExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Registra a retrogradação discipular de um cadastrado.
  inherited;
  if (IsEscolaInterna) and not(ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
   begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.RetrogradarCadastrado, TCosmosErrorMsg.CadastradoEI);
    Exit;
   end;

  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
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

procedure TFrmAlunos.ActRetrogradarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (ActAlunosAtivos.Checked)
   and (Assigned(IRemoteCon))
   and (sfRetrogradarAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmAlunos.ActDesligarExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Desliga o aluno.
  inherited;
  if (IsEscolaInterna) and not(ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho) then
   begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.DesligarCadastrado, TCosmosErrorMsg.CadastradoEI);
    Exit;
   end;

  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule); //do not localize!

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

procedure TFrmAlunos.ActDesligarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (ActAlunosAtivos.Checked)
   and (Assigned(IRemoteCon))
   and (sfDesligarAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmAlunos.ActAlterarExecute(Sender: TObject);
begin
  inherited;
  if not FmeGridSearch1.CanDblClick then
   Exit;

   if not (ActiveDataset.Active) or (ActiveDataset.IsEmpty) then
    Exit;

   if not Assigned(FrmCadastroAluno) then
     FrmCadastroAluno := TFrmCadastroAluno.Create(self);

   try
    FrmCadastroAluno.EditarAluno(ActiveDataset.Fields.FieldByName('codcad').AsInteger);

   finally
    if Assigned(FrmCadastroAluno) then
     FreeAndNil(FrmCadastroAluno);
   end;
end;

procedure TFrmAlunos.ActAlterarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon)) and
   (sfAlterarAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActAlunosAtivosExecute(Sender: TObject);
begin
  inherited;
  AlunosAtivos := True;
end;

procedure TFrmAlunos.ActAlunosAtivosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := AlunosAtivos;
end;

procedure TFrmAlunos.ActAlunosInativosExecute(Sender: TObject);
begin
  inherited;
  AlunosAtivos := False;
end;

procedure TFrmAlunos.ActAlunosInativosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := not AlunosAtivos;
end;

procedure TFrmAlunos.ActAptidoesExecute(Sender: TObject);
var
AClass: TInterfacedPersistent;
AModule: HModule;
IAptidoes: IInformacoesCadastrado;
begin
  inherited;
 AClass := ICosmosApp.LoadClass('infcad.bpl', 'TInfoCadastradoController', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IAptidoes := AClass as IInformacoesCadastrado;
    if IAptidoes <> nil then
     begin
      IAptidoes.CadastrarAptidoes(ActiveDataset.Fields.FieldByName('codcad').AsInteger,
           ActiveDataset.Fields.FieldByName('nomcad').AsString);
     end;
   end;

 finally
  if Assigned(IAptidoes) then IAptidoes := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

procedure TFrmAlunos.ActAptidoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfAptidoesAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActBatismosExecute(Sender: TObject);
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

procedure TFrmAlunos.ActBatismosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (ActAlunosAtivos.Checked)
   and (Assigned(IRemoteCon))
   and (sfBatismoAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmAlunos.ActCartaExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Registra o envio de uma carta de freqüência.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
       IMovDiscipular.EnviarCarta(codcad);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActCartaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (ActAlunosAtivos.Checked)
   and (Assigned(IRemoteCon))
   and (sfCartaFrequenciaAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmAlunos.ActCarteirinhaExecute(Sender: TObject);
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
        IReport.PrintCarteiraAluno(ActiveDataset.Fields.FieldByName('matcad').Value);
       end;

     AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActCarteirinhaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null) and (ActAlunosAtivos.Checked);
end;

procedure TFrmAlunos.ActCasamentoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Registra o casamento de um cadastrado.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
       IMovDiscipular.RegistrarCasamento(codcad);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActCasamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (ActAlunosAtivos.Checked)
   and (Assigned(IRemoteCon))
   and (sfCasamentoAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmAlunos.ActContatosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IContatos: ICosmosMeiosContatos;
begin
  inherited;
  if ActiveDataset.IsEmpty then
   Exit;

   AForm := self.ICosmosApp.LoadDialog('meicont.bpl', 'TFrmMeiosContatos', AModule);

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
   if Assigned(IContatos) then IContatos := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActContatosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (Assigned(IRemoteCon))
   and (sfMeiosContatosAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActNovoAlunoExecute(Sender: TObject);
begin
  inherited;
  try
    if not Assigned(FrmCadastroAluno) then
     FrmCadastroAluno := TFrmCadastroAluno.Create(self);
    FrmCadastroAluno.NovoAluno;


  finally
    if Assigned(FrmCadastroAluno) then
     FreeAndNil(FrmCadastroAluno);
  end;
end;

procedure TFrmAlunos.ActNovoAlunoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.CurrentConnectionMode <> cmRead)
  and (sfCadastrarAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmAlunos.ActPrintHistoricExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IReport: IReportCenter;
  aData: TCosmosData;
begin
  inherited;
  aData := TCosmosData.Create(3);
  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     IReport := AForm as IReportCenter;
     if Assigned(IReport) then
       begin
         aData.WriteValue('CODCAD', ActiveDataset.Fields.FieldByName('CODCAD').Value );
         aData.WriteValue('MATCAD', ActiveDataset.Fields.FieldByName('MATCAD').Value, 1);
         aData.WriteValue('NOMCAD', ActiveDataset.Fields.FieldByName('NOMCAD').Value, 2);
         IReport.PrintHistoric(aData);
       end;

     AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   if Assigned(aData) then FreeAndNil(aData);
   UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActReligarExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Religa o aluno.
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

procedure TFrmAlunos.ActReligarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (ActAlunosInativos.Checked)
   and (Assigned(IRemoteCon))
   and (sfReligarAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmAlunos.ActSearchBarExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmAlunos.ActTransferirExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Transfere o aluno para outro foco
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := ActiveDataset.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.TransferirAluno(codcad) then
        self.UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmAlunos.ActTransferirUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (ActAlunosAtivos.Checked)
   and (Assigned(IRemoteCon))
   and (sfTransferirAluno in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmAlunos.AtualizarJovensAlunos;
var
 ISecretarias: ICosmosSecretarias;
begin
 {Atualiza os dados dos jovens alunos: retirando seus membros, conforme a sua
  idade.}
 ISecretarias := Application.MainForm as ICosmosSecretarias;

 try
  ISecretarias.UpdateAllYoungPupils(ICosmosApp.ActiveFocus.FocusID);

 finally
  begin
   if Assigned(ISecretarias) then ISecretarias := nil;
  end;
 end;
end;

procedure TFrmAlunos.ExportData;
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
       IExporter.ExportarAlunos;
      end;
    end;

  finally
   if Assigned(IExporter) then IExporter := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

function TFrmAlunos.IsEscolaInterna: boolean;
begin
 Result := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
  and (ActiveDataset.Fields.FieldByName('indescint').Value = 'S');
end;

procedure TFrmAlunos.FmeGridSearch2DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
   ActAlterar.Execute;
end;

procedure TFrmAlunos.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := ActiveDataset;

  case TipoListagem of
    tlAlfabetica: DataNavigator:= FDataNavigatorAlfa;
    tlDiscipulado: DataNavigator:= FDataNavigatorDisc;
  end;

  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmAlunos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigatorAlfa) then FreeAndNil(FDataNavigatorAlfa);
  if Assigned(FDataNavigatorDisc) then FreeAndNil(FDataNavigatorDisc);

  inherited;

  Action := caFree;
  FrmAlunos := nil;
end;

procedure TFrmAlunos.FormCreate(Sender: TObject);
begin
  inherited;
  FActiveDataset := CdsAlunosAlfa; //default
  FAlunosAtivos := True; //default
  FmeGridSearch1.ShowSearchBar := True;
  FmeGridSearch1.SearchFields := 'nomcad';
  Letter1 := 'A';
  Letter2 := 'B';

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLectorium);
  CdsAlunosAlfa.RemoteServer := FRemoteConnection;
  CdsAlunosDisc.RemoteServer := FRemoteConnection;

  ListarDiscipulados;
  AtualizarJovensAlunos;

  FDataNavigatorAlfa := TDatasetDataNavigator.Create(CdsAlunosAlfa);
  FDataNavigatorDisc := TDatasetDataNavigator.Create(CdsAlunosDisc);

  DataNavigator := FDataNavigatorAlfa;

  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;
  TipoListagem := tlAlfabetica;
  ListarAlunos;
end;

function TFrmAlunos.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormAlunos;
end;

function TFrmAlunos.GetFormIDName: string;
begin
 Result := 'Secretarias.Alunos';
end;

function TFrmAlunos.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmAlunos.GetHelpID: integer;
begin

end;

function TFrmAlunos.GetTitle: string;
begin
 Result := 'Alunos';
end;

procedure TFrmAlunos.ListarAlunos;
{var
 AParams: TSQLParams;
 ASearch: TCosmosSearch; }
begin
 case TipoListagem of
  tlAlfabetica:
   begin
    {AParams := TSQLParams.Create(5);
    AParams.AppendData(QuotedStr(self.Letter1));
    AParams.AppendData(QuotedStr(self.Letter2), 1);
    AParams.AppendData(ICosmosApp.ActiveFocus.FocusID, 2);
    AParams.AppendData(ActAlunosAtivos.Checked, 3);
    AParams.AppendData(QuotedStr('LEC'), 4);
    ASearch := csListaCadastradosNomeFoco; }
    FActiveDataset := CdsAlunosAlfa;
    CdsAlunosAlfa.Params.ParamByName('param1').Value := self.Letter1;
    CdsAlunosAlfa.Params.ParamByName('param2').Value := self.Letter2;
    CdsAlunosAlfa.Params.ParamByName('param3').Value := ICosmosApp.ActiveFocus.FocusID;
    CdsAlunosAlfa.Params.ParamByName('param4').Value := TDataConverter.ToBoleanString(AlunosAtivos);
    CdsAlunosAlfa.Params.ParamByName('param5').Value := 'LEC';

    if not Assigned(FDataNavigatorAlfa.OnUpdateData) then
      TDatasetDataNavigator(FDataNavigatorAlfa).OnUpdateData := UpdateData;

    DataNavigator := FDataNavigatorAlfa;
   end;
 tlDiscipulado:
   begin
    {AParams := TSQLParams.Create(3);
    AParams.AppendData(QuotedStr(Discipulado));
    AParams.AppendData(ActAlunosAtivos.Checked, 1);
    AParams.AppendData(ICosmosApp.ActiveFocus.FocusID, 2);
    ASearch := csListaCadastradosDiscipuladoFoco;}
    FActiveDataset := CdsAlunosDisc;
    CdsAlunosDisc.Params.ParamByName('sigdis').Value := Discipulado;
    CdsAlunosDisc.Params.ParamByName('indati').Value := TDataConverter.ToBoleanString(AlunosAtivos);
    CdsAlunosDisc.Params.ParamByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;

    if not Assigned(FDataNavigatorDisc.OnUpdateData) then
      TDatasetDataNavigator(FDataNavigatorDisc).OnUpdateData := UpdateData;

    DataNavigator := FDataNavigatorDisc;
   end;
 end;


 try
  ActiveDataset.DisableControls;
  DsrAlunos.DataSet := ActiveDataset;

  if ActiveDataset.Active then ActiveDataset.Close;
  ActiveDataset.Open;

  //IRemoteCon.ExecuteDQL(ASearch, AParams.Params, CdsAlunos);

 finally
  IRemoteCon.ActiveDataset := ActiveDataset;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
  ActiveDataset.EnableControls;
  //if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmAlunos.ListarDiscipulados;
var
ADataset: TClientDataset;
sDisc: string;
begin
 //Lista os discipulados no Tabset, para a navegação do usuário.
 ADataset := TClientDataset.Create(self);
 {Evita que o método "ListarAlunos" seja executado desnecessariamente, pois
  este método é chamado dinamicamente durante a construção do form. Nesse
  momento, não é necessário chamar o método "ListarAlunos".}
 TabSetDiscipulados.OnChange := nil;

 try
  ADataset := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);
  ADataset.Filter := Format(TFilterData.CAMDIS_INDATI, [QuotedStr('LEC'), QuotedStr('S')]);
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

procedure TFrmAlunos.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmAlunos.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAlunos.SetAlunosAtivos(const Value: boolean);
begin
 if Value <> FAlunosAtivos then
  begin
   FAlunosAtivos := Value;
   ListarAlunos;
  end;
end;

procedure TFrmAlunos.SetTipoListagem(const Value: TTipoListagem);
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

procedure TFrmAlunos.TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
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

  ListarAlunos;
end;


procedure TFrmAlunos.UpdateData(Sender: TObject);
begin
  inherited;
  //Não se pode simplesmente chamar o método "Refresh" aqui...
  self.ListarAlunos;
end;

procedure TFrmAlunos.UpdateVisualElements;
begin
  inherited;
 ActionManager.Style := ICosmosApp.InterfaceStyle;
 TabsetAlfabetico.Style := ICosmosApp.Components.TabsStyle;
 TabsetDiscipulados.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmAlunos);

finalization
 UnRegisterClass(TFrmAlunos);

end.
