unit cosmos.financeiro.view.frmrecebimentos;

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
  Data.DBXCommon, Cosmos.Framework.Interfaces.Applications, cosmos.system.formsconst;

type
  TFrmRecebimentos = class(TFrmCosmosDocked)
    Panel1: TPanel;
    EdtMatricula: TMaskEdit;
    BitBtn1: TBitBtn;
    Image1: TImage;
    CdsRecebimentos: TClientDataSet;
    FmeGridSearch1: TFmeGridSearch;
    DsrRecebimentos: TDataSource;
    DBText1: TDBText;
    CdsCadastrado: TClientDataSet;
    DsrCadastrado: TDataSource;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    ImgFoto: TImage;
    ActionManager1: TActionManager;
    ActPesquisar: TAction;
    ActNovoRec: TAction;
    ActAlterarRec: TAction;
    CdsTiposRecebimentos: TClientDataSet;
    ActAnoAnterior: TAction;
    ActAnoSeguinte: TAction;
    ActAnoCorrente: TAction;
    ActionToolBar1: TActionToolBar;
    PopupActionBar1: TPopupActionBar;
    AlterarRecebimento1: TMenuItem;
    Bevel1: TBevel;
    ActSelecionar: TAction;
    ActNovaMensalidade: TAction;
    ActTxConferencia: TAction;
    Recebimentos1: TMenuItem;
    NovaTaxadeConferncia1: TMenuItem;
    NovaMensalidade1: TMenuItem;
    NovoRecebimento2: TMenuItem;
    N1: TMenuItem;
    SelecionarCadastrado1: TMenuItem;
    Anterior1: TMenuItem;
    Seguinte1: TMenuItem;
    AnoCorrente1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    LblAnoCorrente: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    ActValoresAluno: TAction;
    ActSituacaoContribuinte: TAction;
    ValoresdeContribuio1: TMenuItem;
    N4: TMenuItem;
    ActMaskPrintRecibo: TAction;
    SituaodoContribuinte1: TMenuItem;
    ImprimirRecibo1: TMenuItem;
    N5: TMenuItem;
    CancelarRecebimento1: TMenuItem;
    ActCancelarRec: TAction;
    ActDispensas: TAction;
    ActPrintRecibo: TAction;
    procedure ActPesquisarUpdate(Sender: TObject);
    procedure ActSelecionarExecute(Sender: TObject);
    procedure ActAnoAnteriorUpdate(Sender: TObject);
    procedure ActAnoCorrenteExecute(Sender: TObject);
    procedure ActAnoSeguinteExecute(Sender: TObject);
    procedure ActAnoAnteriorExecute(Sender: TObject);
    procedure DBText1Click(Sender: TObject);
    procedure DBText1MouseLeave(Sender: TObject);
    procedure DBText1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ActAlterarRecUpdate(Sender: TObject);
    procedure ActAlterarRecExecute(Sender: TObject);
    procedure ActNovoRecUpdate(Sender: TObject);
    procedure ActNovoRecExecute(Sender: TObject);
    procedure EdtMatriculaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure CdsCadastradoAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActValoresAlunoExecute(Sender: TObject);
    procedure ActSituacaoContribuinteExecute(Sender: TObject);
    procedure ActNovaMensalidadeExecute(Sender: TObject);
    procedure ActTxConferenciaExecute(Sender: TObject);
    procedure ActMaskPrintReciboExecute(Sender: TObject);
    procedure ActCancelarRecExecute(Sender: TObject);
    procedure ActCancelarRecUpdate(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ActDispensasExecute(Sender: TObject);
    procedure ActDispensasUpdate(Sender: TObject);
    procedure ActValoresAlunoUpdate(Sender: TObject);
    procedure ActSituacaoContribuinteUpdate(Sender: TObject);
    procedure ActPrintReciboExecute(Sender: TObject);
    procedure ActPrintReciboUpdate(Sender: TObject);
  private
    { Private declarations }
    FAnoReferencia: integer;
    FPrintRecibo: boolean;
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FIFinanceiro: ICosmosFinanceiro;
    procedure SetAnoReferencia(const Value: integer);
    procedure LoadMensalidades(const matricula: string);
    procedure LoadImage; inline;
    procedure ShowFichaCadastrado(const codcad: integer);
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
    property IFinanceiro: ICosmosFinanceiro read FIFinanceiro;
    property PrintRecibo: boolean read FPrintRecibo write FPrintRecibo default True;
  end;

var
  FrmRecebimentos: TFrmRecebimentos;

implementation

uses cosmos.financeiro.view.frmeditrecebimentos,
  cosmos.financeiro.view.valorescontribuicao,
  cosmos.financeiro.view.situacaocontribuinte;

{$R *.dfm}

procedure TFrmRecebimentos.ActAlterarRecExecute(Sender: TObject);
var
codrec, codcad: integer;
begin
  inherited;
  if (CdsRecebimentos.Active) and not (CdsRecebimentos.IsEmpty) then
   begin
     if not Assigned(FrmEditarRecebimento) then
      FrmEditarRecebimento := TFrmEditarRecebimento.Create(self);

     try
      codrec := CdsRecebimentos.Fields.FieldByName('codrec').AsInteger;
      codcad := CdsCadastrado.Fields.FieldByName('codcad').AsInteger;

      FrmEditarRecebimento.EditarRecebimento(codrec, codcad,
        CdsTiposRecebimentos.Data);

     finally
      if Assigned(FrmEditarRecebimento) then
       FreeAndNil(FrmEditarRecebimento);
     end;
   end;
end;

procedure TFrmRecebimentos.ActAlterarRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CdsCadastrado.Active)
    and not (CdsCadastrado.IsEmpty)
    and (IFinanceiro <> nil)
    and (IFinanceiro.CaixaAberto)
    and (ffAlterarRecebimento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmRecebimentos.ActAnoAnteriorExecute(Sender: TObject);
begin
  inherited;
  AnoReferencia := AnoReferencia - 1;
end;

procedure TFrmRecebimentos.ActAnoAnteriorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := CdsCadastrado.Active;
end;

procedure TFrmRecebimentos.ActAnoCorrenteExecute(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);
  AnoReferencia := Y;
end;

procedure TFrmRecebimentos.ActAnoSeguinteExecute(Sender: TObject);
begin
  inherited;
  AnoReferencia := AnoReferencia + 1;
end;

procedure TFrmRecebimentos.ActCancelarRecExecute(Sender: TObject);
var
 aInfo: TCosmosData;
begin
  inherited;
 //Cancela um recebimento feito.
 aInfo := TCosmosData.Create(5);

 try
  aInfo.WriteValue('codrec', CdsRecebimentos.FieldValues['codrec']);
  aInfo.WriteValue('destiprec', CdsRecebimentos.FieldValues['destiprec'], 1);
  aInfo.WriteValue('datrec', CdsRecebimentos.FieldValues['datrec'], 2);
  aInfo.WriteValue('valrec', CdsRecebimentos.FieldValues['valrec'], 3);

  IFinanceiro.CancelarRecebimento(aInfo);

 finally
  if Assigned(aInfo) then FreeAndNil(aInfo);
 end;

end;

procedure TFrmRecebimentos.ActCancelarRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CdsCadastrado.Active)
    and not (CdsCadastrado.IsEmpty)
    and (IFinanceiro <> nil)
    and (IFinanceiro.CaixaAberto)
    and (ffExcluirRecebimento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmRecebimentos.ActDispensasExecute(Sender: TObject);
var
 IFinanceiro: ICosmosFinanceiro;
begin
  inherited;
  IFinanceiro := Application.MainForm as ICosmosFinanceiro;

  try
   IFinanceiro.CadastrarDispensas(CdsCadastrado.FieldValues['codcad'], CdsCadastrado.FieldValues['nomcad']);

  finally
   IFinanceiro := nil;
  end;
end;

procedure TFrmRecebimentos.ActDispensasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CdsCadastrado.Active)
    and not (CdsCadastrado.IsEmpty)
    and (ffDispensarContribuicoes in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmRecebimentos.ActNovaMensalidadeExecute(Sender: TObject);
var
codcad: integer;
Valor: variant;
begin
  inherited;
  if (CdsCadastrado.Active) and not (CdsCadastrado.IsEmpty) then
   begin
     try
      codcad := CdsCadastrado.Fields.FieldByName('codcad').AsInteger;
      Valor := unassigned;
      if not CdsCadastrado.Fields.FieldByName('valmen').IsNull then
       Valor := CdsCadastrado.Fields.FieldByName('valmen').Value;

      if not Assigned(FrmEditarRecebimento) then
       FrmEditarRecebimento := TFrmEditarRecebimento.Create(self);
      FrmEditarRecebimento.NovoRecebimento(codcad, Valor, 'MEN');

     finally
      if Assigned(FrmEditarRecebimento) then
       FreeAndNil(FrmEditarRecebimento);
     end;
   end;
end;

procedure TFrmRecebimentos.ActNovoRecExecute(Sender: TObject);
var
codcad: integer;
Valor: variant;
begin
  inherited;
  if (CdsCadastrado.Active) and not (CdsCadastrado.IsEmpty) then
   begin
     try
      codcad := CdsCadastrado.Fields.FieldByName('codcad').AsInteger;
      Valor := unassigned;
      if not CdsCadastrado.Fields.FieldByName('valmen').IsNull then
       Valor := CdsCadastrado.Fields.FieldByName('valmen').Value;

      if not Assigned(FrmEditarRecebimento) then
       FrmEditarRecebimento := TFrmEditarRecebimento.Create(self);
      FrmEditarRecebimento.NovoRecebimento(codcad, Valor);

     finally
      if Assigned(FrmEditarRecebimento) then
       FreeAndNil(FrmEditarRecebimento);
     end;
   end;
end;

procedure TFrmRecebimentos.ActNovoRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CdsCadastrado.Active)
    and not (CdsCadastrado.IsEmpty)
    and (IFinanceiro <> nil)
    and (IFinanceiro.CaixaAberto)
    and (ffNovoRecebimento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmRecebimentos.ActPesquisarExecute(Sender: TObject);
var
 sMatricula: string;
begin
  inherited;
  sMatricula := EdtMatricula.Text;
  sMatricula.Trim;

  {Caso o usuário somente tenha informado a parte numérica da matrícula, assume
   que a matrícula informada pertence ao núcleo aberto na seção corrente.}
  if sMatricula.StartsWith('-') then
   sMatricula := ICosmosApp.ActiveFocus.Sigla + sMatricula;

  LoadMensalidades(sMatricula);
end;

procedure TFrmRecebimentos.ActPesquisarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := Trim(EdtMatricula.Text) <> '';
end;

procedure TFrmRecebimentos.ActPrintReciboExecute(Sender: TObject);
begin
  inherited;
  IFinanceiro.ImprimirRecibo(CdsRecebimentos.FieldValues['codrec']);
end;

procedure TFrmRecebimentos.ActPrintReciboUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CdsCadastrado.Active)
    and not (CdsCadastrado.IsEmpty) and (IFinanceiro <> nil);
end;

procedure TFrmRecebimentos.ActMaskPrintReciboExecute(Sender: TObject);
begin
  inherited;
  PrintRecibo := not PrintRecibo;
end;

procedure TFrmRecebimentos.ActSelecionarExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 inherited;
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, False);

 try
  if AData <> nil then
   begin
    EdtMatricula.Text := AData.FindValue('matcad');
    LoadMensalidades(EdtMatricula.Text);
   end;

 finally
  if Assigned(AData) then
   FreeAndNil(AData);
 end;
end;

procedure TFrmRecebimentos.ActSituacaoContribuinteExecute(Sender: TObject);
begin
  inherited;
  //Verifica as pendências de um contribuinte.
  FrmSituacao := TFrmSituacao.Create(Application);

  try
    FrmSituacao.ExibirSituacao(CdsCadastrado.Fields.FieldByName('codcad').AsInteger);

  finally
    if Assigned(FrmSituacao) then
     FreeAndNil(FrmSituacao);
  end;
end;

procedure TFrmRecebimentos.ActSituacaoContribuinteUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CdsCadastrado.Active)
    and not (CdsCadastrado.IsEmpty)
    and (ffNovoRecebimento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmRecebimentos.ActTxConferenciaExecute(Sender: TObject);
var
codcad: integer;
Valor: variant;
begin
  inherited;
  if (CdsCadastrado.Active) and not (CdsCadastrado.IsEmpty) then
   begin
     try
      codcad := CdsCadastrado.Fields.FieldByName('codcad').AsInteger;
      Valor := unassigned;
      if not CdsCadastrado.Fields.FieldByName('valtax').IsNull then
       Valor := CdsCadastrado.Fields.FieldByName('valtax').Value;

      if not Assigned(FrmEditarRecebimento) then
       FrmEditarRecebimento := TFrmEditarRecebimento.Create(self);
      FrmEditarRecebimento.NovoRecebimento(codcad, Valor, 'TAX');

     finally
      if Assigned(FrmEditarRecebimento) then
       FreeAndNil(FrmEditarRecebimento);
     end;
   end;

end;

procedure TFrmRecebimentos.ActValoresAlunoExecute(Sender: TObject);
begin
  inherited;
 //Lista os valores definidos para o contribuinte de taxa de conferência e mensalidade.
 FrmValores := TFrmValores.Create(Application);

 try
   FrmValores.EditarValores(CdsCadastrado.FieldValues['codcad']);

 finally
   if Assigned(FrmValores) then
    FreeAndNil(FrmValores);
 end;
end;

procedure TFrmRecebimentos.ActValoresAlunoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.Connected) and (CdsCadastrado.Active)
    and not (CdsCadastrado.IsEmpty)
    and (ffNovoRecebimento in IRemoteCon.CurrentConnectionInfo.FinanceiroFeatures);
end;

procedure TFrmRecebimentos.CdsCadastradoAfterOpen(DataSet: TDataSet);
begin
 LoadImage;
end;

procedure TFrmRecebimentos.DBText1Click(Sender: TObject);
begin
  inherited;
  if (CdsCadastrado.Active) and not (CdsCadastrado.IsEmpty) then
   ShowFichaCadastrado(CdsCadastrado.Fields.FieldByName('codcad').AsInteger);
end;

procedure TFrmRecebimentos.DBText1MouseLeave(Sender: TObject);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style - [fsUnderline];
  TDBText(Sender).Font.Color := clWindowText;
end;

procedure TFrmRecebimentos.DBText1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style + [fsUnderline];
  TDBText(Sender).Font.Color := clBlue;
end;

procedure TFrmRecebimentos.EdtMatriculaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 13 then
   ActPesquisar.Execute;
end;

procedure TFrmRecebimentos.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(CdsRecebimentos);
end;

procedure TFrmRecebimentos.FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Dataset: TDataset;
begin
  inherited;
  Dataset := CdsRecebimentos;

  //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
  if  gdSelected in State then
    begin
      FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
      FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
    end;

   if Dataset.FieldByName('indcan').AsString = TDataConverter.ToBoleanString(True) then
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

procedure TFrmRecebimentos.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsRecebimentos;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmRecebimentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  FIFinanceiro := nil;

  Action := caFree;
  FrmRecebimentos := nil;
end;

procedure TFrmRecebimentos.FormCreate(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsCadastrado.RemoteServer := FRemoteConnection;
  CdsRecebimentos.RemoteServer := FRemoteConnection;
  CdsTiposRecebimentos.RemoteServer := FRemoteConnection;

  FIFinanceiro := Application.MainForm as ICosmosFinanceiro;

  FDataNavigator := TDatasetDataNavigator.Create(CdsRecebimentos);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  CdsTiposRecebimentos.Open;

  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);
  AnoReferencia := Y;
end;

function TFrmRecebimentos.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormRecebimentos;
end;

function TFrmRecebimentos.GetFormIDName: string;
begin
 Result := 'Financeiro.Recebimentos';
end;

function TFrmRecebimentos.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmRecebimentos.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmRecebimentos.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmRecebimentos.LoadImage;
var
  Bs:TStream;
  Foto:TJPEGImage;
begin
  if (CdsCadastrado.Active) and not (CdsCadastrado.Fields.FieldByName('fotcad').IsNull) then
   begin
    try
     Bs := CdsCadastrado.CreateBlobStream((CdsCadastrado.Fields.FieldByName('fotcad') as TBlobField),bmRead);
     if Bs.Size > 0 then
      begin
       Foto := TJPEGImage.Create;
       Foto.LoadFromStream(Bs);
       ImgFoto.Picture.Assign(Foto);
      end
      else
       ImgFoto.Picture.Assign(nil);

    finally
     if Assigned(Foto) then Foto.Free;
     if Assigned(Bs) then Bs.Destroy;
    end;
   end
  else
   ImgFoto.Picture.Assign(nil);
end;

procedure TFrmRecebimentos.LoadMensalidades(const matricula: string);
begin
 try
  with CdsCadastrado do
   begin
    DisableControls;
    if Active then Close;
    Params.Items[0].Value := Matricula;
    Open;
   end;

  if not CdsCadastrado.IsEmpty then
   begin
    with CdsRecebimentos do
     begin
      DisableControls;
      if Active then Close;
      Params.Items[0].Value := CdsCadastrado.Fields.FieldByName('codcad').Value;
      Params.Items[1].Value := AnoReferencia;      
      Open;
     end;
   end
  else
   ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Recebimentos, Format(TCosmosErrorMsg.CadastradoMatricula, [Trim(matricula)]));

 finally
  CdsCadastrado.EnableControls;
  CdsRecebimentos.EnableControls;
 end;
end;

procedure TFrmRecebimentos.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmRecebimentos.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmRecebimentos.SetAnoReferencia(const Value: integer);
begin
  FAnoReferencia := Value;
  LblAnoCorrente.Caption := IntToStr(Value);

  if CdsCadastrado.Active then
   LoadMensalidades(EdtMatricula.Text);
end;

procedure TFrmRecebimentos.ShowFichaCadastrado(const codcad: integer);
var
 AModule: HModule;
 AForm: TForm;
 IFicha: ICosmosFicha;
begin
 inherited;
 AForm := self.ICosmosApp.LoadDialog('ficha.bpl', 'TFrmFicha', AModule);

 try
  if AModule <> 0 then
  begin
     with AForm do
      begin
       if Supports(AForm, ICosmosFicha) then
        IFicha := AForm as ICosmosFicha;
       if Assigned(IFicha) then
         IFicha.ShowFicha(codcad);
       Free;
      end;
  end;

 finally
  if Assigned(IFicha) then IFicha := nil;
  UnloadPackage(AModule);
 end;
end;


procedure TFrmRecebimentos.UpdateData(Sender: TObject);
begin
self.ActPesquisar.Execute;
end;

procedure TFrmRecebimentos.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmRecebimentos);

finalization
 UnRegisterClass(TFrmRecebimentos);

end.
