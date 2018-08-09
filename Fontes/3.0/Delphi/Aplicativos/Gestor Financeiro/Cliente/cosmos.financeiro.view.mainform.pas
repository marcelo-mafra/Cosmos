unit cosmos.financeiro.view.mainform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.common.view.mainform, CustomizeDlg, Menus, cosmos.system.types,
  PlatformDefaultStyleActnCtrls, ActnPopup, ActnList, ImgList, XPMan, Tabs,
  DockTabSet, ComCtrls, ExtCtrls, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  cosmos.classes.application, XMLDoc, XMLIntf, cosmos.system.messages,
  cosmos.framework.interfaces.DataAcess, Vcl.Touch.GestureMgr, Vcl.AppEvnts,
  System.Actions, Data.DBXCommon, cosmos.business.financeiro, cosmos.classes.security,
  Cosmos.Framework.Interfaces.Applications, Cosmos.Framework.Interfaces.Dialogs;

type
  TFrmMainFinanceiro = class(TFrmMainClientGUI, ICosmosFinanceiro)
    ActManager: TActionManager;
    ActSelectFocus: TAction;
    ActPlanoContas: TAction;
    ActRecebimentos: TAction;
    ActCustos: TAction;
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    ActAnaliseContribuicoes: TAction;
    ActAbrirCaixa: TAction;
    ActFecharCaixa: TAction;
    ActPagamentos: TAction;
    ActContasBancarias: TAction;
    ActShowSummaryCaixa: TAction;
    ActShowPartialSummary: TAction;
    ActAnalisarCaixas: TAction;
    ActFluxoCaixa: TAction;
    ActTiposDocumentos: TAction;
    ActTiposRecebimentos: TAction;
    procedure ActSelectFocusExecute(Sender: TObject);
    procedure ActPlanoContasExecute(Sender: TObject);
    procedure ActRecebimentosExecute(Sender: TObject);
    procedure ActCustosExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActAnaliseContribuicoesExecute(Sender: TObject);
    procedure ActAbrirCaixaExecute(Sender: TObject);
    procedure ActAbrirCaixaUpdate(Sender: TObject);
    procedure ActFecharCaixaExecute(Sender: TObject);
    procedure ActFecharCaixaUpdate(Sender: TObject);
    procedure ActPlanoContasUpdate(Sender: TObject);
    procedure ActRecebimentosUpdate(Sender: TObject);
    procedure ActPagamentosExecute(Sender: TObject);
    procedure ActPagamentosUpdate(Sender: TObject);
    procedure ActShowSummaryCaixaExecute(Sender: TObject);
    procedure ActShowSummaryCaixaUpdate(Sender: TObject);
    procedure ActShowPartialSummaryExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActAnalisarCaixasExecute(Sender: TObject);
    procedure ActCustosUpdate(Sender: TObject);
    procedure ActAnaliseContribuicoesUpdate(Sender: TObject);
    procedure ActContasBancariasExecute(Sender: TObject);
    procedure ActContasBancariasUpdate(Sender: TObject);
    procedure ActShowPartialSummaryUpdate(Sender: TObject);
    procedure ActAnalisarCaixasUpdate(Sender: TObject);
    procedure ActLogoffExecute(Sender: TObject);
  private
    { Private declarations }
    FActiveCaixa: TCaixa;
    FShowSummaryCaixa: boolean;
    function DoSummarize(const codcai: integer; UserLogin: string; Close: boolean): boolean;

  protected
    procedure DoAplicateCustomHintObject(const CustomHint: TCustomHint); override;
    function GetActionManager: TActionManager; override;
    procedure ReadCommonStartupOptions; override;
    procedure WriteStartupOptions; override;

    function GetCosmosModule: TCosmosModules; override;
    function GetIRemoteCon: ICosmosRemoteConnection;  override;

    //ICosmosFinanceiro
    function GetCaixaAberto: boolean;
    function GetCurrentCaixa: TCaixa;

    procedure CadastrarDispensas(const codcad: integer; nomcad: string);
    function CancelarPagamento(Info: TCosmosData): boolean;
    function CancelarRecebimento(Info: TCosmosData): boolean;
    function FecharCaixa(const codcai: integer; UserLogin: string): boolean;
    procedure ImprimirRecibo(const RecebimentoId: integer);
    procedure SummarizeCaixa(const codcai: integer; Close: boolean);

    property CaixaAberto: boolean read GetCaixaAberto;
    property CurrentCaixa: TCaixa read GetCurrentCaixa;


  public
    { Public declarations }
    property ActiveCaixa: TCaixa read FActiveCaixa;
    property ShowSummaryCaixa: boolean read FShowSummaryCaixa;
  end;

var
  FrmMainFinanceiro: TFrmMainFinanceiro;

implementation

uses cosmos.financeiro.clienconnections, cosmos.financeiro.view.caixaresult,
 cosmos.financeiro.view.cancelarrecebimentos;

{$R *.dfm}

procedure TFrmMainFinanceiro.ActRecebimentosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('recebimentos.bpl', 'TFrmRecebimentos');
end;

procedure TFrmMainFinanceiro.ActRecebimentosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon))
   and (IRemoteCon.Connected) and (ActiveCaixa.Activated)
   and (ffRecebimentos in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActAbrirCaixaExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
 AData: TCosmosData;
begin
  inherited;

  ACommand := IRemoteCon.CreateCommand;
  AData := TCosmosData.Create(10);

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMFinanceiroMethods.AbrirCaixa'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters.Parameter[0].Value.SetInt32(ActiveFocus.FocusID);
   ACommand.Parameters.Parameter[1].Value.SetString(IRemoteCon.CurrentUser.Login);
   ACommand.ExecuteUpdate;

   self.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);

   if ACommand.Parameters.Parameter[2].Value.GetString <> '' then
    begin
      AData.LoadFromXML(ACommand.Parameters.Parameter[2].Value.GetString);

      if AData.FindValue('Result') = True then
       begin
         FActiveCaixa.CaixaID := AData.FindValue('codcai');
         FActiveCaixa.NumCaixa := AData.FindValue('numcai');
         FActiveCaixa.FocoCaixa := ActiveFocus;
         //FActiveCaixa.CaixaStart := AData.FindValue('CaixaStart');
         FActiveCaixa.UserLogin := IRemoteCon.CurrentUser.Login;
         FActiveCaixa.UserName := IRemoteCon.CurrentUser.UserName;
         FActiveCaixa.RegistrarAbertura;

         Components.TrayIcon.ShowInfo(TCosmosTitles.Caixa, Format(TCosmosInfoMsg.CaixaAberto, [FActiveCaixa.NumCaixa]));
         StatusBar.WriteText(ActiveCaixa.NumCaixa);
       end
      else
       if AData.FindValue('Message') <> '' then
         DlgMessage.ErrorMessage(TCosmosTitles.Caixa, AData.FindValue('Message'));
    end;

  finally
    ACommand.Free;
    AData.Free;
  end;
end;

procedure TFrmMainFinanceiro.ActAbrirCaixaUpdate(Sender: TObject);
begin
  inherited;
  TAction(sender).Enabled := (IRemoteCon.Connected) and (ActiveFocus <> nil)
    and not (ActiveCaixa.Activated)
   and (ffAbrirCaixa in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActAnalisarCaixasExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('caixas.bpl', 'TFrmCaixas');
end;

procedure TFrmMainFinanceiro.ActAnalisarCaixasUpdate(Sender: TObject);
begin
  inherited;
  TAction(sender).Enabled := (IRemoteCon.Connected) and (ActiveFocus <> nil)
   and (ffAnaliseCaixas in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActAnaliseContribuicoesExecute(Sender: TObject);
begin
  inherited;
  //Abre a janela de análise de contribuições.
end;

procedure TFrmMainFinanceiro.ActAnaliseContribuicoesUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
  and (ffAnaliseContribuicoes in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActContasBancariasExecute(Sender: TObject);
begin
  inherited;
  //Acessa a tela de cadastrode contas bancárias.
 self.OpenRegisteredWindow('conban.bpl', 'TFrmContasBancarias');
end;

procedure TFrmMainFinanceiro.ActContasBancariasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon))  and (IRemoteCon.Connected)
   and (ffContasBancarias in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActCustosExecute(Sender: TObject);
begin
  inherited;
 self.OpenRegisteredWindow('ccustos.bpl', 'TFrmCentroCustos');
end;

procedure TFrmMainFinanceiro.ActCustosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (ffCentrosCustos in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActFecharCaixaExecute(Sender: TObject);
begin
  inherited;
  SummarizeCaixa(ActiveCaixa.CaixaID, True);
end;

procedure TFrmMainFinanceiro.ActFecharCaixaUpdate(Sender: TObject);
begin
  inherited;
  TAction(sender).Enabled := (IRemoteCon.Connected) and (ActiveCaixa.Activated)
   and (ffFecharCaixa in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActLogoffExecute(Sender: TObject);
begin
  if ActiveCaixa.Activated then
   begin
    if DlgMessage.ConfirmationMessage(TCosmosTitles.Caixa, TCosmosConfMsg.ExitCaixaAberto) = mrYes then
     ActFecharCaixa.Execute
    else
     Abort;
   end;

  inherited;
end;

procedure TFrmMainFinanceiro.ActPagamentosExecute(Sender: TObject);
begin
  inherited;
  self.OpenRegisteredWindow('pagamentos.bpl', 'TFrmPagamentos');
end;

procedure TFrmMainFinanceiro.ActPagamentosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon))
   and (IRemoteCon.Connected) and (ActiveCaixa.Activated)
   and (ffPagamentos in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActPlanoContasExecute(Sender: TObject);
begin
 inherited;
 self.OpenRegisteredWindow('pcontas.bpl', 'TFrmPlanoContas');
end;

procedure TFrmMainFinanceiro.ActPlanoContasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon))
   and (IRemoteCon.Connected)
   and (ffPlanoContas in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmMainFinanceiro.ActSelectFocusExecute(Sender: TObject);
begin
  inherited;
  if  (CurrentConnection <> nil) and (CurrentConnection.CurrentUser <> nil) then
   LoadUserFocus(CurrentConnection.CurrentUser.Login);
end;

procedure TFrmMainFinanceiro.ActShowPartialSummaryExecute(Sender: TObject);
begin
  inherited;
  SummarizeCaixa(ActiveCaixa.CaixaID, False);
end;

procedure TFrmMainFinanceiro.ActShowPartialSummaryUpdate(Sender: TObject);
begin
  inherited;
  TAction(sender).Enabled := (IRemoteCon.Connected) and (ActiveCaixa.Activated);
end;

procedure TFrmMainFinanceiro.ActShowSummaryCaixaExecute(Sender: TObject);
begin
  inherited;
  FShowSummaryCaixa := not FShowSummaryCaixa;
end;

procedure TFrmMainFinanceiro.ActShowSummaryCaixaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := FShowSummaryCaixa;
end;

procedure TFrmMainFinanceiro.CadastrarDispensas(const codcad: integer;
  nomcad: string);
var
  AModule: HModule;
  AClass: TInterfacedPersistent;
  IDialog: IDispensasDialgs;
begin
 inherited;
 {Carrega a biblioteca de cadastro de dispensas de contribuições financeiras.}
 AClass := LoadClass('dispensas.bpl', 'TFrmDispensas', AModule);

 try
  if AModule <> 0 then
   begin
    with AClass do
     begin
      if Supports(AClass, IDispensasDialgs) then
        IDialog := AClass as IDispensasDialgs;

      if Assigned(IDialog) then
       begin
        IDialog.Execute(codcad, nomcad);
       end;

      Free;
     end;
   end;

 finally
  if Assigned(IDialog) then
   IDialog := nil;
  if AModule <> 0 then
   UnloadPackage(AModule);
 end;

end;

function TFrmMainFinanceiro.CancelarPagamento(Info: TCosmosData): boolean;
begin
  inherited;
 //Cancela um pagamento feito.
end;

function TFrmMainFinanceiro.CancelarRecebimento(
  Info: TCosmosData): boolean;
var
 aMotivo: TMotivoCancelamento;
begin
  inherited;
 //Cancela um recebimento feito.
 FrmCancelarRecebimento := TFrmCancelarRecebimento.Create(nil);

 try
  if FrmCancelarRecebimento.ConfirmarCancelamento(Info) then
   begin
    aMotivo := FrmCancelarRecebimento.MotivoCancelamento;
    DMCon.DoCancelarRecebimento(Info.FindValue('codrec'), Ord(aMotivo));
   end;

 finally
  if Assigned(FrmCancelarRecebimento) then FreeAndNil(FrmCancelarRecebimento);
 end;
end;

procedure TFrmMainFinanceiro.DoAplicateCustomHintObject(
  const CustomHint: TCustomHint);
begin
  inherited;
end;

function TFrmMainFinanceiro.DoSummarize(const codcai: integer; UserLogin: string;
  Close: boolean): boolean;
var
 ACommand: TDBXCommand;
 aCosmosData: TCosmosData;
begin
  //Fecha um caixa ativo.
  ACommand := IRemoteCon.CreateCommand;
  aCosmosData := TCosmosData.Create(10);

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMFinanceiroMethods.FecharCaixa'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters.Parameter[0].Value.SetInt32(codcai);
   ACommand.Parameters.Parameter[1].Value.SetString(UserLogin);
   ACommand.Parameters.Parameter[2].Value.SetBoolean(Close);
   ACommand.ExecuteUpdate;

   if Close = True then
     FActiveCaixa.RegistrarEncerramento;

   aCosmosData.LoadFromXML(ACommand.Parameters.Parameter[3].Value.GetString);
   self.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);

   Result := True;

   //se close for "False" significa que o usuário quer uma exibição parcial do caixa.
   if (Close = False) or (ShowSummaryCaixa = True) then
    begin
      FrmFechamentoCaixa := TFrmFechamentoCaixa.Create(nil);

      try
       FrmFechamentoCaixa.ShowSummary(aCosmosData);
       FShowSummaryCaixa := FrmFechamentoCaixa.ShowOption;

      finally
       if Assigned(FrmFechamentoCaixa) then FreeAndNil(FrmFechamentoCaixa);
      end;
    end;

    ACommand.Free;
    aCosmosData.Free;

  except
    if Assigned(ACommand) then ACommand.Free;
    if Assigned(aCosmosData) then aCosmosData.Free;
    Result := False;
  end;
end;

function TFrmMainFinanceiro.FecharCaixa(const codcai: integer;  UserLogin: string): boolean;
begin
 Result := DoSummarize(codcai, UserLogin, True);
end;

procedure TFrmMainFinanceiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 //Trata o fechamento do sistema com um caixa aberto.
 if ActiveCaixa.Activated then
  begin
    if DlgMessage.ConfirmationMessage(TCosmosTitles.Caixa, TCosmosConfMsg.CaixaAbertoSair) = mrYes then
      begin
        try
          SummarizeCaixa(ActiveCaixa.CaixaID, True);

        except
         Abort;
        end;
      end
      else
       Abort;
  end;

  inherited;
end;

procedure TFrmMainFinanceiro.FormCreate(Sender: TObject);
begin
  inherited;
  Application.HelpFile := ExtractFilePath(Application.ExeName) +  'gfin.chm';
  FActiveCaixa := TCaixa.Create;
end;

function TFrmMainFinanceiro.GetActionManager: TActionManager;
begin
 Result := self.ActManager;
end;

function TFrmMainFinanceiro.GetCaixaAberto: boolean;
begin
 Result := ActiveCaixa.Activated;
end;

function TFrmMainFinanceiro.GetCosmosModule: TCosmosModules;
begin
 Result := cmFinanceiro;
end;

function TFrmMainFinanceiro.GetCurrentCaixa: TCaixa;
begin
 Result := ActiveCaixa;
end;

function TFrmMainFinanceiro.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := DMCon as ICosmosRemoteConnection;
end;

procedure TFrmMainFinanceiro.ImprimirRecibo(const RecebimentoId: integer);
begin
 {Imprime um recibo relativo a um pagamento registrado no sistema.}
 DMCon.DoImprimirRecibo(RecebimentoId);
end;

procedure TFrmMainFinanceiro.ReadCommonStartupOptions;
var
 sCosmosModule: string;
 AXMLDoc: TXMLDocument;
 ANode, AChildNode: IXMLNode;
begin
  inherited;
 {Lê as opções de inicialização específicas do módulo financeiro.}
  FShowSummaryCaixa := False;
  if not FileExists(UserConfigurationsFile) then
   Exit;

  AXMLDoc := CreateXMLDocument;

 try
  AXMLDoc.FileName := UserConfigurationsFile;

  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('ModulesOptions');
  sCosmosModule := self.CosmosModuleShortName;

  AChildNode := ANode.ChildNodes.First;

  while (AChildNode <> nil) and (UpperCase(AChildNode.NodeName) <> UpperCase(sCosmosModule)) do
   begin
    AChildNode := AChildNode.NextSibling;
   end;

  AChildNode := AChildNode.ChildNodes.FindNode('CaixaOptions');
  //Lê a opção de exibição de sumário de operação do caixa.
  FShowSummaryCaixa := AChildNode.Attributes['ShowSummary'];


  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);

 except
  on E: Exception do
   begin
     self.MainLog.RegisterError(E.Message);
     if Assigned(AXMLDoc) then
      FreeAndNil(AXMLDoc);
   end;
 end;
end;

procedure TFrmMainFinanceiro.SummarizeCaixa(const codcai: integer; Close: boolean);
begin
  //Fecha um caixa ativo.
  DoSummarize(codcai, IRemoteCon.CurrentUser.Login, Close);
end;

procedure TFrmMainFinanceiro.WriteStartupOptions;
var
 AXMLDoc: TXMLDocument;
 ANode, AChildNode: IXMLNode;
 sCosmosModule: string;
begin
  inherited;

//Escreve as configurações de inicialização específicas do módulo financeiro.
 if not FileExists(UserConfigurationsFile) then
  Exit;

 AXMLDoc := self.CreateXMLDocument;
 AXMLDoc.FileName := UserConfigurationsFile;

 try
  AXMLDoc.Active := True;
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('ModulesOptions');

  sCosmosModule := self.CosmosModuleShortName;

  AChildNode := ANode.ChildNodes.First;

  while (AChildNode <> nil) and (UpperCase(AChildNode.NodeName) <> UpperCase(sCosmosModule)) do
   begin
    AChildNode := AChildNode.NextSibling;
   end;

  AChildNode := AChildNode.ChildNodes.FindNode('CaixaOptions');

  AChildNode.Attributes['ShowSummary'] := ShowSummaryCaixa;

  if Assigned(AXMLDoc) then
   begin
    AXMLDoc.SaveToFile(AXMLDoc.FileName);
    FreeAndNil(AXMLDoc);
   end;

 except
   on E: Exception do
    begin
      if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
      self.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
      raise;
    end;
 end;
end;

end.
