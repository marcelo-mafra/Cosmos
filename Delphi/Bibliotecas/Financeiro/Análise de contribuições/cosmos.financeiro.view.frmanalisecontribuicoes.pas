unit cosmos.financeiro.view.frmanalisecontribuicoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList,
  StdCtrls, Mask, ExtCtrls, Buttons, DB, DBClient, cosmos.frames.gridsearch, DBCtrls,
  Jpeg, XPStyleActnCtrls, ActnMan, Cosmos.Framework.Interfaces.Dialogs, ToolWin,
  ActnCtrls, Menus, ActnPopup, cosmos.framework.datanavigators.datasets,
  PlatformDefaultStyleActnCtrls,  cosmos.system.messages, cosmos.classes.application,
  cosmos.business.focos, cosmos.Framework.forms.datadialogs, System.Actions,
  Datasnap.DSConnect, Cosmos.Framework.Interfaces.Dataacess,
  cosmos.system.formsconst;

type
  TFrmAnaliseContribuicoes = class(TFrmCosmosDocked)
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
    ActDoacao: TAction;
    Recebimentos1: TMenuItem;
    NovaDoao1: TMenuItem;
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
  private
    { Private declarations }
    FAnoReferencia: integer;
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
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
  end;

var
  FrmAnaliseContribuicoes: TFrmAnaliseContribuicoes;

implementation

{$R *.dfm}

procedure TFrmAnaliseContribuicoes.ActAlterarRecExecute(Sender: TObject);
var
codrec, codcad: integer;
begin
  inherited;
  {if (CdsRecebimentos.Active) and not (CdsRecebimentos.IsEmpty) then
   begin
     try
      codrec := CdsRecebimentos.Fields.FieldByName('codrec').AsInteger;
      codcad := CdsCadastrado.Fields.FieldByName('codcad').AsInteger;
      if not Assigned(FrmEditarRecebimento) then
       FrmEditarRecebimento := TFrmEditarRecebimento.Create(self);
      FrmEditarRecebimento.EditarRecebimento(codrec, codcad,
        CdsTiposRecebimentos.Data);

     finally
      if Assigned(FrmEditarRecebimento) then
       FreeAndNil(FrmEditarRecebimento);
     end;
   end;}
end;

procedure TFrmAnaliseContribuicoes.ActAlterarRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsRecebimentos.Active)
    and not (CdsRecebimentos.IsEmpty);
end;

procedure TFrmAnaliseContribuicoes.ActAnoAnteriorExecute(Sender: TObject);
begin
  inherited;
  AnoReferencia := AnoReferencia - 1;
end;

procedure TFrmAnaliseContribuicoes.ActAnoAnteriorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := CdsCadastrado.Active;
end;

procedure TFrmAnaliseContribuicoes.ActAnoCorrenteExecute(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);
  AnoReferencia := Y;
end;

procedure TFrmAnaliseContribuicoes.ActAnoSeguinteExecute(Sender: TObject);
begin
  inherited;
  AnoReferencia := AnoReferencia + 1;
end;

procedure TFrmAnaliseContribuicoes.ActNovoRecExecute(Sender: TObject);
var
codcad: integer;
Valor: variant;
begin
  inherited;
{  if (CdsCadastrado.Active) and not (CdsCadastrado.IsEmpty) then
   begin
     try
      codcad := CdsCadastrado.Fields.FieldByName('codcad').AsInteger;
      Valor := unassigned;
      if not CdsCadastrado.Fields.FieldByName('valmen').IsNull then
       Valor := CdsCadastrado.Fields.FieldByName('valmen').Value;

      if not Assigned(FrmEditarRecebimento) then
       FrmEditarRecebimento := TFrmEditarRecebimento.Create(self);
      FrmEditarRecebimento.NovoRecebimento(codcad, Valor, CdsTiposRecebimentos.Data);

     finally
      if Assigned(FrmEditarRecebimento) then
       FreeAndNil(FrmEditarRecebimento);
     end;
   end; }
end;

procedure TFrmAnaliseContribuicoes.ActNovoRecUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsCadastrado.Active) and not (CdsCadastrado.IsEmpty);
end;

procedure TFrmAnaliseContribuicoes.ActPesquisarExecute(Sender: TObject);
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

procedure TFrmAnaliseContribuicoes.ActPesquisarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := Trim(EdtMatricula.Text) <> '';
end;

procedure TFrmAnaliseContribuicoes.ActSelecionarExecute(Sender: TObject);
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

procedure TFrmAnaliseContribuicoes.ActSituacaoContribuinteExecute(Sender: TObject);
begin
  inherited;
  //Verifica as pendências de um contribuinte.

end;

procedure TFrmAnaliseContribuicoes.ActValoresAlunoExecute(Sender: TObject);
begin
  inherited;
 //Lista os valores definidos para o contribuinte de taxa de conferência e mensalidade.
{ FrmValores := TFrmValores.Create(Application);

 try
   FrmValores.EditarValores(CdsCadastrado.FieldValues['codcad']);

 finally
   if Assigned(FrmValores) then
    FreeAndNil(FrmValores);
 end;}
end;

procedure TFrmAnaliseContribuicoes.CdsCadastradoAfterOpen(DataSet: TDataSet);
begin
 LoadImage;
end;

procedure TFrmAnaliseContribuicoes.DBText1Click(Sender: TObject);
begin
  inherited;
  if (CdsCadastrado.Active) and not (CdsCadastrado.IsEmpty) then
   ShowFichaCadastrado(CdsCadastrado.Fields.FieldByName('codcad').AsInteger);
end;

procedure TFrmAnaliseContribuicoes.DBText1MouseLeave(Sender: TObject);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style - [fsUnderline];
  TDBText(Sender).Font.Color := clWindowText;
end;

procedure TFrmAnaliseContribuicoes.DBText1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  TDBText(Sender).Font.Style := TDBText(Sender).Font.Style + [fsUnderline];
  TDBText(Sender).Font.Color := clBlue;
end;

procedure TFrmAnaliseContribuicoes.EdtMatriculaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 13 then
   ActPesquisar.Execute;
end;

procedure TFrmAnaliseContribuicoes.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(CdsRecebimentos);
end;

procedure TFrmAnaliseContribuicoes.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsRecebimentos;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmAnaliseContribuicoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  Action := caFree;
  FrmAnaliseContribuicoes := nil;
end;

procedure TFrmAnaliseContribuicoes.FormCreate(Sender: TObject);
var
Y, M, D: word;
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsCadastrado.RemoteServer := FRemoteConnection;
  CdsRecebimentos.RemoteServer := FRemoteConnection;
  CdsTiposRecebimentos.RemoteServer := FRemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(CdsRecebimentos);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  CdsTiposRecebimentos.Open;

  DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);
  AnoReferencia := Y;
end;

function TFrmAnaliseContribuicoes.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormRecebimentos;
end;

function TFrmAnaliseContribuicoes.GetFormIDName: string;
begin
 Result := 'Financeiro.Recebimentos';
end;

function TFrmAnaliseContribuicoes.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmAnaliseContribuicoes.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmAnaliseContribuicoes.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmAnaliseContribuicoes.LoadImage;
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

procedure TFrmAnaliseContribuicoes.LoadMensalidades(const matricula: string);
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

procedure TFrmAnaliseContribuicoes.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmAnaliseContribuicoes.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAnaliseContribuicoes.SetAnoReferencia(const Value: integer);
begin
  FAnoReferencia := Value;
  LblAnoCorrente.Caption := IntToStr(Value);

  if CdsCadastrado.Active then
   LoadMensalidades(EdtMatricula.Text);
end;

procedure TFrmAnaliseContribuicoes.ShowFichaCadastrado(const codcad: integer);
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


procedure TFrmAnaliseContribuicoes.UpdateData(Sender: TObject);
begin
self.ActPesquisar.Execute;
end;

procedure TFrmAnaliseContribuicoes.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmAnaliseContribuicoes);

finalization
 UnRegisterClass(TFrmAnaliseContribuicoes);

end.
