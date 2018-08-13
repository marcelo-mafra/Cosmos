unit cosmos.secretarias.view.pesquisadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, ExtCtrls,
  cosmos.frames.gridsearch, DB, Datasnap.DSConnect, cosmos.system.files,
  DBClient, StdCtrls, ToolWin, ActnMan, ActnCtrls, Tabs, cosmos.classes.security,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs, Menus,
  ActnPopup, cosmos.system.messages, XPStyleActnCtrls, DockTabSet, cosmos.data.dataobjects,
  PlatformDefaultStyleActnCtrls, cosmos.classes.application, cosmos.system.formsconst,
  cosmos.classes.ServerInterface, cosmos.framework.datanavigators.datasets,
  System.Actions, Cosmos.Framework.Interfaces.DataAcess, System.ImageList,
  cosmos.system.dataconverter;

type
  TTipoListagem = (tlAlfabetica, tlDiscipulado);

  TFrmPesquisadores = class(TFrmCosmosDocked)
    CdsPesquisadoresAlfa: TClientDataSet;
    DsrPesquisadores: TDataSource;
    ActNovo: TAction;
    ActEditar: TAction;
    ActEndereco: TAction;
    ActContatos: TAction;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActHistorico: TAction;
    ActDesligamento: TAction;
    ActReligar: TAction;
    PopupActionBar1: TPopupActionBar;
    DesligarPesquisador1: TMenuItem;
    ReligarPesquisador1: TMenuItem;
    N1: TMenuItem;
    ActPesquisadoresAtivos: TAction;
    ActPesquisadoresInativos: TAction;
    PesquisadoresAtivos1: TMenuItem;
    PesquisadoresInativos1: TMenuItem;
    ActTransferir: TAction;
    TabSetAlfabetico: TDockTabSet;
    TabSetDiscipulados: TDockTabSet;
    ActListaAlfabetica: TAction;
    ActListaDiscipulados: TAction;
    PopupActionBar2: TPopupActionBar;
    ListarAlfabeticamente1: TMenuItem;
    ListarporDiscipulados1: TMenuItem;
    ActBarraPesquisa: TAction;
    MeiosdeContato1: TMenuItem;
    Endereo1: TMenuItem;
    Histrico1: TMenuItem;
    ransferir1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Listagem1: TMenuItem;
    ListarAlfabeticamente2: TMenuItem;
    ListarporDiscipulados2: TMenuItem;
    ActEntregarCartas: TAction;
    ActFicha: TAction;
    FmeGridSearch1: TFmeGridSearch;
    CdsPesquisadoresDisc: TClientDataSet;
    EntregarCartas1: TMenuItem;
    N4: TMenuItem;
    procedure ActFichaExecute(Sender: TObject);
    procedure ActEntregarCartasExecute(Sender: TObject);
    procedure ActPesquisadoresAtivosExecute(Sender: TObject);
    procedure ActEditarUpdate(Sender: TObject);
    procedure ActBarraPesquisaExecute(Sender: TObject);
    procedure ActListaDiscipuladosExecute(Sender: TObject);
    procedure ActListaAlfabeticaExecute(Sender: TObject);
    procedure TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ActHistoricoExecute(Sender: TObject);
    procedure ActTransferirExecute(Sender: TObject);
    procedure ActReligarUpdate(Sender: TObject);
    procedure ActReligarExecute(Sender: TObject);
    procedure ActDesligamentoUpdate(Sender: TObject);
    procedure ActDesligamentoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Action1Execute(Sender: TObject);
    procedure ActContatosExecute(Sender: TObject);
    procedure ActEnderecoExecute(Sender: TObject);
    procedure ActEditarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNovoUpdate(Sender: TObject);
    procedure ActTransferirUpdate(Sender: TObject);
    procedure ActEnderecoUpdate(Sender: TObject);
    procedure ActContatosUpdate(Sender: TObject);
    procedure ActEntregarCartasUpdate(Sender: TObject);
    procedure ActHistoricoUpdate(Sender: TObject);
    procedure ActPesquisadoresInativosExecute(Sender: TObject);
    procedure ActPesquisadoresAtivosUpdate(Sender: TObject);
    procedure ActPesquisadoresInativosUpdate(Sender: TObject);
  private
    { Private declarations }
    FActiveDataset: TClientDataset;
    FDataNavigatorAlfa: TDatasetDataNavigator;
    FDataNavigatorDisc: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FTipoListagem: TTipoListagem;
    FDiscipulado: string;
    FLetter2: string;
    FLetter1: string;
    FPesquisadoresAtivos: boolean;
    procedure SetPesquisadoresAtivos(const Value: boolean);
    procedure SetTipoListagem(const Value: TTipoListagem);
    procedure ListarDiscipulados;
    procedure ListarPesquisadores;
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
    property PesquisadoresAtivos: boolean read FPesquisadoresAtivos write SetPesquisadoresAtivos;
    property Discipulado: string read FDiscipulado write FDiscipulado;
    property Letter1: string read FLetter1 write FLetter1 ;
    property Letter2: string read FLetter2 write FLetter2 ;
    property TipoListagem: TTipoListagem read FTipoListagem
       write SetTipoListagem default tlAlfabetica;
  end;

var
  FrmPesquisadores: TFrmPesquisadores;

implementation

uses cosmos.secretarias.view.cadastropesquisadores,
  cosmos.secretarias.view.cartaspesquisadores;

{$R *.dfm}

procedure TFrmPesquisadores.ActBarraPesquisaExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmPesquisadores.ActContatosExecute(Sender: TObject);
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
        IContatos.ShowMeiosContatosPesquisador(ActiveDataset.Fields.FieldByName('codcad').AsInteger);
       Free;
      end;
    end;

  finally
   if Assigned(IContatos) then
    IContatos := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmPesquisadores.ActContatosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (sfMeiosContatosPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmPesquisadores.ActEditarExecute(Sender: TObject);
begin
  inherited;
  if not FmeGridSearch1.CanDblClick then
   Exit;   

  if ActiveDataset.IsEmpty then
   Exit;

  FrmCadastroPesquisador := TFrmCadastroPesquisador.Create(self);

  try
   FrmCadastroPesquisador.EditarPesquisador(ActiveDataset.Fields.FieldByName('codcad').AsInteger);

  finally
   if Assigned(FrmCadastroPesquisador) then
    FreeAndNil(FrmCadastroPesquisador);
  end;
end;

procedure TFrmPesquisadores.ActEditarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active)
    and not (ActiveDataset.IsEmpty)
    and (ActiveDataset.FieldValues['codcad'] <> null)
      and (sfAlterarPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmPesquisadores.ActEnderecoExecute(Sender: TObject);
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

procedure TFrmPesquisadores.ActEnderecoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (sfEnderecoPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmPesquisadores.ActEntregarCartasExecute(Sender: TObject);
begin
  inherited;
  if ActiveDataset.IsEmpty then
   Exit;

  FrmEnviarCartas := TFrmEnviarCartas.Create(self);

  try
   FrmEnviarCartas.NovaCarta(ActiveDataset.Fields.FieldByName('codcad').Value);

  finally
   if Assigned(FrmEnviarCartas) then
    FreeAndNil(FrmEnviarCartas);
  end;
end;

procedure TFrmPesquisadores.ActEntregarCartasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.Fields.FieldByName('indati').AsString = 'S')
   and (sfEntregarCartasPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmPesquisadores.ActFichaExecute(Sender: TObject);
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
         IReport.PrintFichaPesquisador(ActiveDataset.Fields.FieldByName('matcad').Value);
       end;

     AForm.Free;
    end;

  finally
   if Assigned(IReport) then IReport := nil;
   UnloadPackage(AModule);
  end;
end;

procedure TFrmPesquisadores.ActHistoricoExecute(Sender: TObject);
var
  AForm: TCustomForm;
  IHistorico: ICosmosHistorico;
  codcad: integer;
begin
  inherited;
  if ActiveDataset.IsEmpty then
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

procedure TFrmPesquisadores.ActHistoricoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.FieldValues['codcad'] <> null)
   and (sfHistoricoPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmPesquisadores.Action1Execute(Sender: TObject);
begin
  inherited;
 Tag := TAction(Sender).Tag;
end;

procedure TFrmPesquisadores.ActDesligamentoExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Desliga o pesquisador.
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
        self.UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmPesquisadores.ActDesligamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.Fields.FieldByName('indati').AsString = 'S')
   and (sfDesligarPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmPesquisadores.ActPesquisadoresAtivosExecute(Sender: TObject);
begin
  inherited;
  PesquisadoresAtivos := True;
end;

procedure TFrmPesquisadores.ActPesquisadoresAtivosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := PesquisadoresAtivos;
end;

procedure TFrmPesquisadores.ActPesquisadoresInativosExecute(Sender: TObject);
begin
  inherited;
  PesquisadoresAtivos := False;
end;

procedure TFrmPesquisadores.ActPesquisadoresInativosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := not PesquisadoresAtivos;
end;

procedure TFrmPesquisadores.ActReligarExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Religa o pesquisador.
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

procedure TFrmPesquisadores.ActReligarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.Fields.FieldByName('indati').AsString = 'N')
   and (sfReligarPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmPesquisadores.ActListaAlfabeticaExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlAlfabetica;
end;

procedure TFrmPesquisadores.ActListaDiscipuladosExecute(Sender: TObject);
begin
  inherited;
  TipoListagem := tlDiscipulado;
end;

procedure TFrmPesquisadores.ActNovoExecute(Sender: TObject);
begin
  inherited;
  try
   if not Assigned(FrmCadastroPesquisador) then
    FrmCadastroPesquisador := TFrmCadastroPesquisador.Create(self);
   FrmCadastroPesquisador.NovoPesquisador;

  finally
   if Assigned(FrmCadastroPesquisador) then
    FreeAndNil(FrmCadastroPesquisador);
  end;
end;

procedure TFrmPesquisadores.ActNovoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.CurrentConnectionMode <> cmRead)
  and (sfCadastrarPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmPesquisadores.ActTransferirExecute(Sender: TObject);
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

procedure TFrmPesquisadores.ActTransferirUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ActiveDataset.Active) and not (ActiveDataset.IsEmpty)
   and (ActiveDataset.Fields.FieldByName('indati').AsString = 'S')
   and (sfTransferirPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmPesquisadores.ExportData;
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
       IExporter.ExportarPesquisadores;
      end;
    end;

  finally
   if Assigned(IExporter) then IExporter := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmPesquisadores.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := ActiveDataset;

  case TipoListagem of
    tlAlfabetica: DataNavigator:= FDataNavigatorAlfa;
    tlDiscipulado: DataNavigator:= FDataNavigatorDisc;
  end;

  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmPesquisadores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigatorAlfa) then FreeAndNil(FDataNavigatorAlfa);
  if Assigned(FDataNavigatorDisc) then FreeAndNil(FDataNavigatorDisc);

  inherited;

 Action := caFree;
 FrmPesquisadores := nil;
end;

procedure TFrmPesquisadores.FormCreate(Sender: TObject);
begin
  inherited;
  FActiveDataset := CdsPesquisadoresAlfa; //default
  FPesquisadoresAtivos := True; //default
  FmeGridSearch1.ShowSearchBar := True;
  FmeGridSearch1.SearchFields := 'nomcad';
  Letter1 := 'A';
  Letter2 := 'B';

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
  CdsPesquisadoresAlfa.RemoteServer := FRemoteConnection;
  CdsPesquisadoresDisc.RemoteServer := FRemoteConnection;

  ListarDiscipulados;

  FDataNavigatorAlfa := TDatasetDataNavigator.Create(CdsPesquisadoresAlfa);
  FDataNavigatorDisc := TDatasetDataNavigator.Create(CdsPesquisadoresDisc);

  DataNavigator := FDataNavigatorAlfa;

  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;
  TipoListagem := tlAlfabetica;
  ListarPesquisadores;
end;


function TFrmPesquisadores.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormPesquisadoresTP;
end;

function TFrmPesquisadores.GetFormIDName: string;
begin
 Result := 'Secretarias.Pesquisadores';
end;

function TFrmPesquisadores.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmPesquisadores.GetHelpID: integer;
begin

end;

function TFrmPesquisadores.GetTitle: string;
begin
 Result := 'Pesquisadores';
end;

procedure TFrmPesquisadores.ListarDiscipulados;
var
ADataset: TClientDataset;
sDisc: string;
begin
 //Lista os discipulados no Tabset, para a navegação do usuário.
 ADataset := TClientDataset.Create(self);
 {Evita que o método "ListarPesquisadores" seja executado desnecessariamente, pois
  este método é chamado dinamicamente durante a construção do form. Nesse
  momento, não é necessário chamar o método "ListarPesquisadores".}
 TabSetDiscipulados.OnChange := nil;

 try
  ADataset := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);
  ADataset.Filter := Format(TFilterData.CAMDIS_INDATI, [QuotedStr('TPU'), QuotedStr('S')]);
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

procedure TFrmPesquisadores.ListarPesquisadores;
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
    FActiveDataset := CdsPesquisadoresAlfa;
    CdsPesquisadoresAlfa.Params.ParamByName('param1').Value := self.Letter1;
    CdsPesquisadoresAlfa.Params.ParamByName('param2').Value := self.Letter2;
    CdsPesquisadoresAlfa.Params.ParamByName('param3').Value := ICosmosApp.ActiveFocus.FocusID;
    CdsPesquisadoresAlfa.Params.ParamByName('param4').Value := TDataConverter.ToBoleanString(PesquisadoresAtivos);
    CdsPesquisadoresAlfa.Params.ParamByName('param5').Value := 'TPU';

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
    FActiveDataset := CdsPesquisadoresDisc;
    CdsPesquisadoresDisc.Params.ParamByName('sigdis').Value := Discipulado;
    CdsPesquisadoresDisc.Params.ParamByName('indati').Value := TDataConverter.ToBoleanString(PesquisadoresAtivos);
    CdsPesquisadoresDisc.Params.ParamByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;

    if not Assigned(FDataNavigatorDisc.OnUpdateData) then
      TDatasetDataNavigator(FDataNavigatorDisc).OnUpdateData := UpdateData;

    DataNavigator := FDataNavigatorDisc;
   end;
 end;


 try
  ActiveDataset.DisableControls;
  DsrPesquisadores.DataSet := ActiveDataset;

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

procedure TFrmPesquisadores.Locate;
begin
 inherited;
 IRemoteCon.DefaultLocate;
end;

procedure TFrmPesquisadores.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmPesquisadores.SetPesquisadoresAtivos(const Value: boolean);
begin
 if Value <> FPesquisadoresAtivos then
  begin
   FPesquisadoresAtivos := Value;
   ListarPesquisadores;
  end;
end;

procedure TFrmPesquisadores.SetTipoListagem(const Value: TTipoListagem);
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

procedure TFrmPesquisadores.TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
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

  ListarPesquisadores;
end;

procedure TFrmPesquisadores.UpdateData(Sender: TObject);
begin
  inherited;
  self.ListarPesquisadores;
end;

procedure TFrmPesquisadores.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
 TabsetAlfabetico.Style := ICosmosApp.Components.TabsStyle;
 TabsetDiscipulados.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmPesquisadores);

finalization
 UnRegisterClass(TFrmPesquisadores);

end.
