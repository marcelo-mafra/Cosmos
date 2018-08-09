unit cosmos.financeiro.view.frmcaixas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, Vcl.Grids, Vcl.DBGrids,
  StdCtrls, Mask, ExtCtrls, Buttons, DB, DBClient, cosmos.frames.gridsearch, DBCtrls,
  Jpeg, XPStyleActnCtrls, ActnMan, Cosmos.Framework.Interfaces.Dialogs, ToolWin,
  ActnCtrls, Menus, ActnPopup, cosmos.framework.datanavigators.datasets,
  PlatformDefaultStyleActnCtrls,  cosmos.system.messages, cosmos.classes.application,
  cosmos.business.focos, cosmos.Framework.forms.datadialogs, System.Actions,
  Datasnap.DSConnect, Cosmos.Framework.Interfaces.Dataacess, cosmos.classes.security,
  Vcl.Tabs, Vcl.ComCtrls, Data.DBXCommon, cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.Applications, cosmos.framework.interfaces.root,
  cosmos.system.formsconst;

type
  PCaixa = ^TCaixaRec;

  TCaixaRec = record
   CaixaId: integer;
   Numcai: string;
   codfoc: integer;
   codusu: integer;
   nomusu: string;
   databe: TDateTime;
   datenc: Olevariant;
   nomenc: Olevariant;
   indfec: boolean;
  end;

  TModoExibicao = (meResumido, meDetalhado);

  TFrmCaixas = class(TFrmCosmosDocked)
    CdsRecebimentosCaixa: TClientDataSet;
    DsrRecebimentosCaixa: TDataSource;
    ActionManager1: TActionManager;
    ActMesAnterior: TAction;
    ActMesSeguinte: TAction;
    ActMesCorrente: TAction;
    ActionToolBar1: TActionToolBar;
    PopupActionBar1: TPopupActionBar;
    Panel1: TPanel;
    LsvCaixas: TListView;
    Splitter1: TSplitter;
    Panel2: TPanel;
    TabSet1: TTabSet;
    FmeGridSearch1: TFmeGridSearch;
    ImageList2: TImageList;
    ActFecharCaixa: TAction;
    ActFullScreen: TAction;
    CdsPagamentosCaixa: TClientDataSet;
    ActFecharCaixa1: TMenuItem;
    ActSumarioCaixa: TAction;
    SumriodoCaixa1: TMenuItem;
    Panel3: TPanel;
    LblCurrentMonth: TLabel;
    ActModoResumido: TAction;
    ActModoDetalhado: TAction;
    ModoDetalhado1: TMenuItem;
    ModoResumido1: TMenuItem;
    N1: TMenuItem;
    ImageList3: TImageList;
    ActCancelarRec: TAction;
    CancelarRecebimento1: TMenuItem;
    N2: TMenuItem;
    procedure ActMesCorrenteExecute(Sender: TObject);
    procedure ActMesSeguinteExecute(Sender: TObject);
    procedure ActMesAnteriorExecute(Sender: TObject);
    procedure DBText1MouseLeave(Sender: TObject);
    procedure DBText1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ActAlterarRecUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActFullScreenExecute(Sender: TObject);
    procedure ActFullScreenUpdate(Sender: TObject);
    procedure LsvCaixasSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ActFecharCaixaExecute(Sender: TObject);
    procedure ActFecharCaixaUpdate(Sender: TObject);
    procedure ActSumarioCaixaExecute(Sender: TObject);
    procedure ActSumarioCaixaUpdate(Sender: TObject);
    procedure ActModoResumidoExecute(Sender: TObject);
    procedure ActModoResumidoUpdate(Sender: TObject);
    procedure ActModoDetalhadoExecute(Sender: TObject);
    procedure ActModoDetalhadoUpdate(Sender: TObject);
    procedure ActCancelarRecExecute(Sender: TObject);
    procedure ActCancelarRecUpdate(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    FMesCorrente, FAnoCorrente: integer;
    FDataNavigatorRec: TDatasetDataNavigator;
    FDataNavigatorPag: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FModoExibicao: TModoExibicao;
    procedure SetMesCorrente(const Value: integer);
    procedure UpdateData(Sender: TObject);
    function GetCurrentCaixa: PCaixa;
    procedure ListCaixas;
    procedure LoadMovimentacao(const codcai: integer);
    function GetSelectedCaixaId: integer;
    procedure SetModoExibicao(value: TModoExibicao);

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
    property AnoCorrente: integer read FAnoCorrente;
    property MesCorrente: integer read FMesCorrente write SetMesCorrente;
    property CurrentCaixa: PCaixa read GetCurrentCaixa;
    property SelectedCaixaId: integer read GetSelectedCaixaId;
    property ModoExibicao: TModoExibicao read FModoExibicao write SetModoExibicao;
  end;

var
  FrmCaixas: TFrmCaixas;

implementation


{$R *.dfm}

procedure TFrmCaixas.ActAlterarRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected)
    and (ffAlterarPagamento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmCaixas.ActMesAnteriorExecute(Sender: TObject);
begin
  inherited;
  if MesCorrente <> 1 then
   MesCorrente := MesCorrente - 1
  else
   begin
     FAnoCorrente := FAnoCorrente - 1;
     MesCorrente := 12;
   end;
end;

procedure TFrmCaixas.ActMesCorrenteExecute(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);
  FAnoCorrente := Y;
  MesCorrente := M;
end;

procedure TFrmCaixas.ActMesSeguinteExecute(Sender: TObject);
begin
  inherited;
  if MesCorrente <> 12 then
   MesCorrente := MesCorrente + 1
  else
   begin
     FAnoCorrente := FAnoCorrente + 1;
     MesCorrente := 1;
   end;
end;

procedure TFrmCaixas.ActModoDetalhadoExecute(Sender: TObject);
begin
  inherited;
  ModoExibicao := meDetalhado;
end;

procedure TFrmCaixas.ActModoDetalhadoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked :=  ModoExibicao = meDetalhado;
end;

procedure TFrmCaixas.ActModoResumidoExecute(Sender: TObject);
begin
  inherited;
  ModoExibicao := meResumido;
end;

procedure TFrmCaixas.ActModoResumidoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := ModoExibicao = meResumido;
end;

procedure TFrmCaixas.ActSumarioCaixaExecute(Sender: TObject);
var
 IFinanceiro: ICosmosFinanceiro;
begin
  inherited;
 IFinanceiro := Application.MainForm as ICosmosFinanceiro;

 try
   IFinanceiro.SummarizeCaixa(SelectedCaixaId, False);

 finally
   if Assigned(IFinanceiro) then IFinanceiro := nil;
 end;
end;

procedure TFrmCaixas.ActSumarioCaixaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CurrentCaixa <> nil);
end;

procedure TFrmCaixas.ActCancelarRecExecute(Sender: TObject);
var
 aInfo: TCosmosData;
 IFinanceiro: ICosmosFinanceiro;
begin
  inherited;
 //Cancela um recebimento feito.
 IFinanceiro := Application.MainForm as ICosmosFinanceiro;
 aInfo := TCosmosData.Create(5);

 try
  aInfo.WriteValue('codrec', CdsRecebimentosCaixa.FieldValues['codrec']);
  aInfo.WriteValue('destiprec', CdsRecebimentosCaixa.FieldValues['destiprec'], 1);
  aInfo.WriteValue('datrec', CdsRecebimentosCaixa.FieldValues['datrec'], 2);
  aInfo.WriteValue('valrec', CdsRecebimentosCaixa.FieldValues['valrec'], 3);

  IFinanceiro.CancelarRecebimento(aInfo);

 finally
  if Assigned(aInfo) then FreeAndNil(aInfo);
  if Assigned(IFinanceiro) then IFinanceiro := nil;
 end;
end;

procedure TFrmCaixas.ActCancelarRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (DsrRecebimentosCaixa.DataSet = CdsRecebimentosCaixa)
    and (CdsRecebimentosCaixa.Active) and not (CdsRecebimentosCaixa.IsEmpty)
    and (CdsRecebimentosCaixa.FieldValues['indcan'] = 'N')
    and (ffExcluirRecebimento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmCaixas.ActFecharCaixaExecute(Sender: TObject);
var
 IFinanceiro: ICosmosFinanceiro;
begin
  inherited;
 IFinanceiro := Application.MainForm as ICosmosFinanceiro;

 try
   case ICosmosApp.IRemoteCon.IdenticacaoAtiva of
    rmSucess: CurrentCaixa.indfec := IFinanceiro.FecharCaixa(SelectedCaixaId, ICosmosApp.IRemoteCon.CurrentUser.Login);
    rmUnsucess: ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.IdentificaoAtiva, TCosmosErrorMsg.IdentificaoAtiva);
   end;

 finally
   if Assigned(IFinanceiro) then IFinanceiro := nil;
 end;
end;

procedure TFrmCaixas.ActFecharCaixaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CurrentCaixa <> nil)
    and not (CurrentCaixa.indfec)
   and (ffFecharCaixaAbandonado in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmCaixas.ActFullScreenExecute(Sender: TObject);
begin
  inherited;
  ICosmosApp.FullScreen := not ICosmosApp.FullScreen;
end;

procedure TFrmCaixas.ActFullScreenUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := ICosmosApp.FullScreen;
end;

procedure TFrmCaixas.DBText1MouseLeave(Sender: TObject);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style - [fsUnderline];
  TDBText(Sender).Font.Color := clWindowText;
end;

procedure TFrmCaixas.DBText1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style + [fsUnderline];
  TDBText(Sender).Font.Color := clBlue;
end;

procedure TFrmCaixas.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(CdsRecebimentosCaixa);
end;

procedure TFrmCaixas.FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Dataset: TDataset;
begin
  inherited;
  Dataset := DsrRecebimentosCaixa.DataSet;

  if Dataset = CdsRecebimentosCaixa then
   begin
    //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
    if  gdSelected in State then
     begin
      FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
      FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
     end;

    if Dataset.FieldByName('indcan').AsString = 'S' then
     begin
      FmeGridSearch1.DBGrid1.Canvas.Font.Color := clRed;
      FmeGridSearch1.DBGrid1.Canvas.Font.Style :=  [fsStrikeOut];
     end
    else
     begin
      FmeGridSearch1.DBGrid1.Canvas.Font.Color := clWindowText;
      FmeGridSearch1.DBGrid1.Canvas.Font.Style := [];
     end;

    FmeGridSearch1.DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure TFrmCaixas.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := DsrRecebimentosCaixa.DataSet;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmCaixas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigatorRec) then
   FreeAndNil(FDataNavigatorRec);

  if Assigned(FDataNavigatorPag) then
   FreeAndNil(FDataNavigatorPag);

  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  Action := caFree;
  FrmCaixas := nil;
end;

procedure TFrmCaixas.FormCreate(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsRecebimentosCaixa.RemoteServer := FRemoteConnection;
  CdsPagamentosCaixa.RemoteServer := FRemoteConnection;

  FDataNavigatorRec := TDatasetDataNavigator.Create(CdsRecebimentosCaixa);
  FDataNavigatorPag := TDatasetDataNavigator.Create(CdsPagamentosCaixa);

  DataNavigator := FDataNavigatorRec;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);

  FAnoCorrente := Y;
  MesCorrente := M;
  TabSet1.Style := ICosmosApp.Components.TabsStyle;
end;

function TFrmCaixas.GetCurrentCaixa: PCaixa;
begin
 Result := nil;
 if LsvCaixas.Selected <> nil then
  Result := PCaixa(LsvCaixas.Selected);
end;

function TFrmCaixas.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormRecebimentos;
end;

function TFrmCaixas.GetFormIDName: string;
begin
 Result := 'Financeiro.Caixas';
end;

function TFrmCaixas.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmCaixas.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmCaixas.GetSelectedCaixaId: integer;
begin
 if LsvCaixas.Selected <> nil then
  Result := PCaixa(LsvCaixas.Selected.Data).CaixaId
 else
  Result := 0;
end;

function TFrmCaixas.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmCaixas.ListCaixas;
var
 aParams: TSQLParams;
 aReader: TDBXReader;
 aItem: TListItem;
 aGroup: TListGroup;
 aPCaixa: PCaixa;
 sCaixaNome: string;
 I: integer;
begin
 //Lista os caixas de acordo com os parâmetros de navegação escolhidos.
 if CdsRecebimentosCaixa.Active then CdsRecebimentosCaixa.Close;
 if CdsPagamentosCaixa.Active then CdsPagamentosCaixa.Close;

 aParams := TSQLParams.Create(3);
 aParams.AppendData(ICosmosApp.ActiveFocus.FocusID);
 aParams.AppendData(MesCorrente, 1);
 aParams.AppendData(AnoCorrente, 2);


 aReader := IRemoteCon.ListData(csCaixasMesAno, AParams.Params);

 LsvCaixas.Items.BeginUpdate;

 try
   LsvCaixas.Clear;

   while aReader.Next do
    begin
      New(aPCaixa);
      aPCaixa.CaixaId := aReader.Value['codcai'].GetInt32;
      aPCaixa.Numcai := aReader.Value['numcai'].AsString;
      aPCaixa.codfoc := aReader.Value['codfoc'].GetInt32;
      aPCaixa.codusu := aReader.Value['usuabe'].GetInt32;
      aPCaixa.nomusu := aReader.Value['nomabe'].AsString;
      aPCaixa.databe := aReader.Value['databe'].AsDateTime;
      if aReader.Value['datfec'].IsNull then
       begin
        aPCaixa.datenc := null;
        aPCaixa.nomenc := null;
       end
      else
       begin
        aPCaixa.datenc := aReader.Value['datfec'].AsDateTime;
        aPCaixa.nomenc := aReader.Value['nomfec'].AsString;
       end;

      aPCaixa.indfec := not aReader.Value['datfec'].IsNull;

      sCaixaNome := Format('%s (%s)', [aPCaixa.Numcai, TDataConverter.ToFormatedDateTime(aPCaixa.databe)]);
      aItem := LsvCaixas.Items.Add;
      aItem.Caption := sCaixaNome;
      aItem.SubItems.Append(aReader.Value['databe'].AsString);

      if not aReader.Value['datfec'].IsNull then
        aItem.SubItems.Append(aReader.Value['datfec'].AsString)
      else
        aItem.SubItems.Append('');

      aItem.SubItems.Append(aReader.Value['nomabe'].AsString);
      aItem.Data := aPCaixa;

      if aPCaixa.indfec then
       aItem.ImageIndex := 0
      else
       aItem.ImageIndex := 1;

      for I := 0 to Pred(LsvCaixas.Groups.Count) do
        begin
          aGroup := LsvCaixas.Groups.Items[I];
          if aGroup.Header = aPCaixa.nomusu then
            aItem.GroupID := aGroup.ID;
        end;

      if aItem.GroupID < 0 then
       begin
         aGroup := LsvCaixas.Groups.Add;
         aGroup.Header := aPCaixa.nomusu;
         aItem.GroupID := aGroup.ID;
       end;
    end;



 finally
    LsvCaixas.Items.EndUpdate;
    aParams.Free;
 end;
end;

procedure TFrmCaixas.LoadMovimentacao(const codcai: integer);
begin
 CdsRecebimentosCaixa.DisableControls;
 CdsPagamentosCaixa.DisableControls;

 try
  if CdsRecebimentosCaixa.Active then
   CdsRecebimentosCaixa.Close;

  if CdsPagamentosCaixa.Active then
   CdsPagamentosCaixa.Close;

  CdsRecebimentosCaixa.Params.Items[0].AsInteger := codcai;
  CdsRecebimentosCaixa.Open;

  CdsPagamentosCaixa.Params.Items[0].AsInteger := codcai;
  CdsPagamentosCaixa.Open;

 finally
  CdsRecebimentosCaixa.EnableControls;
  CdsPagamentosCaixa.EnableControls;
 end;
end;

procedure TFrmCaixas.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmCaixas.LsvCaixasSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  inherited;
  if Item <> nil then
   LoadMovimentacao(SelectedCaixaId);
end;

procedure TFrmCaixas.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmCaixas.SetMesCorrente(const Value: integer);
var
 aFormat: TFormatSettings;
 sMonthName: string;
begin
  FMesCorrente := Value;
  aFormat := TFormatSettings.Create;

  sMonthName := aFormat.LongMonthNames[MesCorrente];
  LblCurrentMonth.Caption := Format('%s de %d', [sMonthName, FAnoCorrente]);

  self.ListCaixas;
end;

procedure TFrmCaixas.SetModoExibicao(value: TModoExibicao);
begin
 FModoExibicao := Value;

 case FModoExibicao of
   meResumido: LsvCaixas.ViewStyle := vsList;
   meDetalhado: LsvCaixas.ViewStyle := vsReport;
 end;
end;

procedure TFrmCaixas.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  inherited;
  case TabSet1.TabIndex of
   0:
     begin
      DsrRecebimentosCaixa.DataSet := CdsPagamentosCaixa;
      DataNavigator := FDataNavigatorPag;
     end;
   1: begin
       DsrRecebimentosCaixa.DataSet := CdsRecebimentosCaixa;
       DataNavigator := FDataNavigatorRec;
      end;
  end;

  IRemoteCon.ActiveDataNavigator := DataNavigator;
end;

procedure TFrmCaixas.UpdateData(Sender: TObject);
begin
 if CurrentCaixa <> nil then
  self.LoadMovimentacao(SelectedCaixaId);
end;

procedure TFrmCaixas.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
  TabSet1.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmCaixas);

finalization
 UnRegisterClass(TFrmCaixas);

end.
