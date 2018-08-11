unit cosmos.financeiro.view.frmpagamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList,
  StdCtrls, Mask, ExtCtrls, Buttons, DB, DBClient, cosmos.frames.gridsearch, DBCtrls,
  Jpeg, XPStyleActnCtrls, ActnMan, Cosmos.Framework.Interfaces.Dialogs, ToolWin,
  ActnCtrls, Menus, ActnPopup, cosmos.framework.datanavigators.datasets,
  PlatformDefaultStyleActnCtrls, cosmos.system.messages, cosmos.classes.application,
  cosmos.business.focos, cosmos.Framework.forms.datadialogs, System.Actions,
  Datasnap.DSConnect, Cosmos.Framework.Interfaces.Dataacess, cosmos.classes.security,
  Vcl.Tabs, Vcl.Grids, Vcl.DBGrids, Cosmos.Framework.Interfaces.Applications,
  cosmos.system.formsconst;

type
  TFrmPagamentos = class(TFrmCosmosDocked)
    CdsPagamentos: TClientDataSet;
    FmeGridSearch1: TFmeGridSearch;
    DsrPagamentos: TDataSource;
    ActionManager1: TActionManager;
    ActNovoPag: TAction;
    ActAnoAnterior: TAction;
    ActAnoSeguinte: TAction;
    ActAnoCorrente: TAction;
    ActionToolBar1: TActionToolBar;
    PopupActionBar1: TPopupActionBar;
    ActAlterarPagamento: TAction;
    ActCancelarPagamento: TAction;
    Panel1: TPanel;
    LblAno: TLabel;
    TabMeses: TTabSet;
    ActFullScreen: TAction;
    NovoPagamento1: TMenuItem;
    Alterarpagamento1: TMenuItem;
    CancelarPagamento1: TMenuItem;
    N1: TMenuItem;
    procedure ActAnoCorrenteExecute(Sender: TObject);
    procedure ActAnoSeguinteExecute(Sender: TObject);
    procedure ActAnoAnteriorExecute(Sender: TObject);
    procedure DBText1MouseLeave(Sender: TObject);
    procedure DBText1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ActAlterarRecUpdate(Sender: TObject);
    procedure ActNovoPagUpdate(Sender: TObject);
    procedure ActNovoPagExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure TabMesesChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ActFullScreenExecute(Sender: TObject);
    procedure ActFullScreenUpdate(Sender: TObject);
    procedure ActCancelarPagamentoUpdate(Sender: TObject);
    procedure ActAlterarPagamentoUpdate(Sender: TObject);
    procedure ActAlterarPagamentoExecute(Sender: TObject);
    procedure ActCancelarPagamentoExecute(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    FAnoReferencia, FMesReferencia: integer;
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FIFinanceiro: ICosmosFinanceiro;
    procedure LoadPagamentos;
    procedure SetAnoReferencia(const Value: integer);
    procedure SetMesReferencia(const Value: integer);
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
    property AnoReferencia: integer read FAnoReferencia write SetAnoReferencia;
    property MesReferencia: integer read FMesReferencia write SetMesReferencia;
    property IFinanceiro: ICosmosFinanceiro read FIFinanceiro;
  end;

var
  FrmPagamentos: TFrmPagamentos;

implementation

uses cosmos.financeiro.view.frmeditpagamentos;

{$R *.dfm}

procedure TFrmPagamentos.ActAlterarPagamentoExecute(Sender: TObject);
begin
  inherited;
  FrmEditarPagamento := TFrmEditarPagamento.Create(Application);

  try
   FrmEditarPagamento.EditarPagamento(CdsPagamentos.FieldValues['codpag']);

  finally
   if Assigned(FrmEditarPagamento) then
    FreeAndNil(FrmEditarPagamento);
  end;
end;

procedure TFrmPagamentos.ActAlterarPagamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected)
    and (CdsPagamentos.Active)
    and not (CdsPagamentos.IsEmpty)
    and (IFinanceiro <> nil)
    and (IFinanceiro.CaixaAberto)
    and (ffAlterarPagamento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmPagamentos.ActAlterarRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected)
    and (ffAlterarPagamento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmPagamentos.ActAnoAnteriorExecute(Sender: TObject);
begin
  inherited;
  AnoReferencia := AnoReferencia - 1;
end;

procedure TFrmPagamentos.ActAnoCorrenteExecute(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);
  AnoReferencia := Y;
end;

procedure TFrmPagamentos.ActAnoSeguinteExecute(Sender: TObject);
begin
  inherited;
  AnoReferencia := AnoReferencia + 1;
end;

procedure TFrmPagamentos.ActCancelarPagamentoExecute(Sender: TObject);
var
 aInfo: TCosmosData;
begin
  inherited;
 //Cancela um pagamento feito.
 aInfo := TCosmosData.Create(5);

 try
  aInfo.WriteValue('codpag', CdsPagamentos.FieldValues['codpag']);
  IFinanceiro.CancelarPagamento(aInfo);

 finally
  if Assigned(aInfo) then FreeAndNil(aInfo);
 end;
end;

procedure TFrmPagamentos.ActCancelarPagamentoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected)
    and (CdsPagamentos.Active)
    and not (CdsPagamentos.IsEmpty)
    and (IFinanceiro <> nil)
    and (IFinanceiro.CaixaAberto)
    and (ffExcluirPagamento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmPagamentos.ActFullScreenExecute(Sender: TObject);
begin
  inherited;
  ICosmosApp.FullScreen := not ICosmosApp.FullScreen;
end;

procedure TFrmPagamentos.ActFullScreenUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := ICosmosApp.FullScreen;
end;

procedure TFrmPagamentos.ActNovoPagExecute(Sender: TObject);
begin
  inherited;
  FrmEditarPagamento := TFrmEditarPagamento.Create(Application);

  try
   FrmEditarPagamento.NovoPagamento;

  finally
   if Assigned(FrmEditarPagamento) then
    FreeAndNil(FrmEditarPagamento);
  end;
end;

procedure TFrmPagamentos.ActNovoPagUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected)
    and (IFinanceiro <> nil)
    and (IFinanceiro.CaixaAberto)
   and (ffNovoPagamento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmPagamentos.DBText1MouseLeave(Sender: TObject);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style - [fsUnderline];
  TDBText(Sender).Font.Color := clWindowText;
end;

procedure TFrmPagamentos.DBText1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style + [fsUnderline];
  TDBText(Sender).Font.Color := clBlue;
end;

procedure TFrmPagamentos.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(CdsPagamentos);
end;

procedure TFrmPagamentos.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  ActAlterarPagamento.Execute;
end;

procedure TFrmPagamentos.FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
    //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
    if  gdSelected in State then
     begin
      FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
      FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
     end;

    if (CdsPagamentos.Active) and (CdsPagamentos.FieldByName('indcan').AsString = 'S') then
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

procedure TFrmPagamentos.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsPagamentos;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmPagamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  FIFinanceiro := nil;

  Action := caFree;
  FrmPagamentos := nil;
end;

procedure TFrmPagamentos.FormCreate(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsPagamentos.RemoteServer := FRemoteConnection;

  FIFinanceiro := Application.MainForm as ICosmosFinanceiro;

  FDataNavigator := TDatasetDataNavigator.Create(CdsPagamentos);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);

  FAnoReferencia := Y;
  FMesReferencia := M;
  TabMeses.TabIndex := FMesReferencia - 1;
  LblAno.Caption := AnoReferencia.ToString;
  LoadPagamentos;
end;

function TFrmPagamentos.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormRecebimentos;
end;

function TFrmPagamentos.GetFormIDName: string;
begin
 Result := 'Financeiro.Pagamentos';
end;

function TFrmPagamentos.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmPagamentos.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmPagamentos.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmPagamentos.LoadPagamentos;
begin
  CdsPagamentos.DisableControls;

  try
   CdsPagamentos.Params.Items[0].AsInteger := ICosmosApp.ActiveFocus.FocusID;
   CdsPagamentos.Params.Items[1].AsInteger := MesReferencia;
   CdsPagamentos.Params.Items[2].AsInteger := AnoReferencia;
   if CdsPagamentos.Active then
    CdsPagamentos.Close;

   CdsPagamentos.Open

  finally
   CdsPagamentos.EnableControls;
  end;
end;

procedure TFrmPagamentos.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmPagamentos.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmPagamentos.SetAnoReferencia(const Value: integer);
begin
 if FAnoReferencia <> Value then
  begin
   FAnoReferencia := Value;
   LblAno.Caption := Value.ToString;
   LoadPagamentos;
  end;
end;

procedure TFrmPagamentos.SetMesReferencia(const Value: integer);
begin
 if FMesReferencia <> Value then
  begin
   FMesReferencia := Value;
   LoadPagamentos;
  end;
end;

procedure TFrmPagamentos.TabMesesChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  inherited;
  MesReferencia := NewTab + 1;
end;

procedure TFrmPagamentos.UpdateData(Sender: TObject);
begin
 LoadPagamentos;
end;

procedure TFrmPagamentos.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
  TabMeses.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmPagamentos);

finalization
 UnRegisterClass(TFrmPagamentos);

end.
