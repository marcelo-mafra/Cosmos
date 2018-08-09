unit cosmos.secretarias.view.WzInstalacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, Cosmos.Framework.Interfaces.Dialogs, ValueComboBox,
  cosmos.frames.gridsearch, DB, DBClient, cosmos.classes.application,
  cosmos.business.focos, cosmos.Framework.forms.datadialogs, cosmos.system.messages,
  Vcl.Imaging.pngimage, System.Actions, Data.DBXCommon, Vcl.Grids, Vcl.DBGrids,
  cosmos.classes.ServerInterface;

type
  TFrmAssistenteInstalacao = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    RdbEE: TRadioButton;
    RdbEI: TRadioButton;
    Label2: TLabel;
    Label3: TLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    EdtFoco: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtTurma: TEdit;
    CBXDiscipulados: TValueComboBox;
    CBXSigla: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DsrCandidatos: TDataSource;
    ActionList2: TActionList;
    ImageList2: TImageList;
    ActExcluir: TAction;
    ActInserir: TAction;
    FmeGridSearch1: TFmeGridSearch;
    CdsDiscipulados: TClientDataSet;
    CdsCandidatos: TClientDataSet;
    procedure ActProximoUpdate(Sender: TObject);
    procedure CBXDiscipuladosChange(Sender: TObject);
    procedure ActExcluirUpdate(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure ActInserirExecute(Sender: TObject);
    procedure WzCosmosBeforeNextPage(Sender: TObject; CurrentPage: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    function DoCreateTurmaInstalacao: boolean;
    procedure DoListDiscipulados(Dataset: TDataset); inline;
    procedure ListarDiscipuladosEE;
    procedure ListarDiscipuladosEI;
    procedure ListarCandidatos;
    function GetDiscipuladoAnterior(const Sigla: string): string;
    function GetNumeroTurma: string;
    function LocateCandidato(const codcad: integer): boolean; inline;
    function CanListCandidates: boolean;

  public
    { Public declarations }
    function Execute: boolean; override;
  end;

var
  FrmAssistenteInstalacao: TFrmAssistenteInstalacao;

implementation

{$R *.dfm}

procedure TFrmAssistenteInstalacao.ActExcluirExecute(Sender: TObject);
begin
  inherited;
  CdsCandidatos.Delete;
end;

procedure TFrmAssistenteInstalacao.ActExcluirUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsCandidatos.Active) and not (CdsCandidatos.IsEmpty)
    and (CdsCandidatos.FieldValues['codcad'] <> null);
end;

procedure TFrmAssistenteInstalacao.ActInserirExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 inherited;
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, False);

 if AData <> nil then
   begin
    if LocateCandidato(AData.FindValue('CODCAD')) then
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.DuplicateCandidato)
    else
      begin
       CdsCandidatos.Insert;
       with CdsCandidatos.Fields do
         begin
          FieldByName('codcad').Value := AData.FindValue('CODCAD');
          FieldByName('matcadint').Value := AData.FindValue('MATCADINT');
          FieldByName('matcad').Value := AData.FindValue('MATCAD');
          FieldByName('nomcad').Value := AData.FindValue('NOMCAD');
          FieldByName('sigdis').Value := AData.FindValue('SIGDIS');
          FieldByName('sigfoc').Value := AData.FindValue('SIGFOC');
          FieldByName('dathis').Value := null;
          FieldByName('anos').Value := null;
          FieldByName('meses').Value := null;
          FieldByName('indins').Value := null;
         end;
         CdsCandidatos.Post;
      end;
   end;
end;

procedure TFrmAssistenteInstalacao.ActProximoUpdate(Sender: TObject);
begin
  inherited;
 case WzCosmos.ActivePageIndex of
  2: TAction(Sender).Enabled := CBXDiscipulados.ItemIndex >= 0;
  3: TAction(Sender).Enabled := (CdsCandidatos.Active) and not (CdsCandidatos.IsEmpty)
    and (CdsCandidatos.FieldValues['codcad'] <> null);
 end;
end;

function TFrmAssistenteInstalacao.CanListCandidates: boolean;
begin
 {Retorna se é possível listar os candidatos da nova turma de instalação. Essa
 listagem pode não ser possível, dependento do discipulado da turma.}
 Result := False;

 if RdbEE.Checked then
  Result := CBXDiscipulados.ItemIndex <> 0 //Não é possível para o 1AS.
 else
  begin //Escola Interna
   Result := CBXDiscipulados.ItemIndex < 3 //Não é possível para o 5AS e 6AS.
  end;
end;

procedure TFrmAssistenteInstalacao.CBXDiscipuladosChange(Sender: TObject);
begin
  inherited;
  CBXSigla.ItemIndex := CBXDiscipulados.ItemIndex;
end;

function TFrmAssistenteInstalacao.DoCreateTurmaInstalacao: boolean;
var
 ACommand: TDBXCommand;
begin
    ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TCosmosSecHistoricoServerMethods.CreateTurmaInst';
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetWideString(EdtTurma.Text);
     ACommand.Parameters[1].Value.SetInt32(ICosmosApp.ActiveFocus.FocusID);
     ACommand.Parameters[2].Value.SetInt32(StrToInt(CBXDiscipulados.GetValue));
     ACommand.Parameters[3].Value.AsVariant := CdsCandidatos.Data;
     ACommand.Parameters[4].Value.SetWideString(UpperCase(ICosmosApp.IRemoteCon.CurrentUser.UserName));
     ACommand.ExecuteUpdate;

     ACommand.Free;
     Result := True;
     ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);

    except
     on E: Exception do
      begin
       Result := False;
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
       if Assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
      end;
    end;
end;

procedure TFrmAssistenteInstalacao.DoListDiscipulados(Dataset: TDataset);
begin
  CBXDiscipulados.Items.Clear;
  CBXDiscipulados.Values.Clear;
  CBXSigla.Items.Clear;

  while not Dataset.Eof do
   begin
    CBXDiscipulados.Items.Append(Dataset.FieldValues['nomdis']);
    CBXDiscipulados.Values.Append(Dataset.FieldValues['coddis']);
    CBXSigla.Items.Append(Dataset.FieldValues['sigdis']);
    Dataset.Next;
   end;

  CBXDiscipulados.ItemIndex := 0;
  CBXDiscipulados.OnChange(CBXDiscipulados);
end;

function TFrmAssistenteInstalacao.Execute: boolean;
begin
  WzCosmos.StartWizard;
  Result := ShowModal = mrOk;

  if Result then
   Result := DoCreateTurmaInstalacao;
end;

procedure TFrmAssistenteInstalacao.FmeGridSearch1DBGrid1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  //Destaca com cores os candidatos que já podem ser instalados.
 FmeGridSearch1.DBGrid1.Canvas.FillRect(Rect);

 //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
 if  gdSelected in State then
  begin
   FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
   FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
  end;

 if CdsCandidatos.Fields.FieldByName('indins').AsString.ToUpper = 'S' then //do not localize!
  begin
   FmeGridSearch1.DBGrid1.Canvas.Font.Color := clWindowText;//cor "ativa" de texto.
   //FmeGridSearch1.DBGrid1.Canvas.Font.Style := FmeGridSearch1.DBGrid1.Canvas.Font.Style + [fsBold];
  end
 else
   FmeGridSearch1.DBGrid1.Canvas.Font.Color := clGrayText; //Cor de background de texto

 FmeGridSearch1.DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmAssistenteInstalacao.FormCreate(Sender: TObject);
var
 aField: TField;
begin
  inherited;
  RdbEI.Enabled := ctEI in IRemoteCon.CurrentConnectionInfo.CamposTrabalho;
  EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;

  CdsCandidatos.CreateDataSet;

  aField := CdsCandidatos.FindField('dathis');
  aField.Required := False;

  aField := CdsCandidatos.FindField('anos');
  aField.Required := False;

  aField := CdsCandidatos.FindField('meses');
  aField.Required := False;

  aField := CdsCandidatos.FindField('indins');
  aField.Required := False;

  IRemoteCon.LoadFieldsInfo(CdsCandidatos);
end;

function TFrmAssistenteInstalacao.GetDiscipuladoAnterior(
  const Sigla: string): string;
begin
 with CdsDiscipulados do
  begin
   Filtered := False;
   Filter := Format('CAMDIS = %s and INDATI = %s', [QuotedStr('LEC'), QuotedStr('S')]);
   Filtered := True;
   IndexFieldNames := 'seqdis';
   if Locate('sigdis', Sigla, []) then
    begin
     Prior;
     Result := Fields.FieldByName('sigdis').AsString;
    end
   else
    Result := '';
  end;
end;

function TFrmAssistenteInstalacao.GetNumeroTurma: string;
var
 ACommand: TDBXCommand;
begin
    ACommand := ICosmosApp.IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TCosmosSecHistoricoServerMethods.GenNumeroTurmaInst';
     ACommand.Prepare;

     ACommand.Parameters[0].Value.SetInt32(ICosmosApp.ActiveFocus.FocusID);
     ACommand.ExecuteUpdate;

     Result := ACommand.Parameters[1].Value.GetWideString;
     ACommand.Free;
     ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, IRemoteCon.ConnectionParamsInfo);

    except
     on E: Exception do
      begin
       Result := '';
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
       if Assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
      end;
    end;
end;

procedure TFrmAssistenteInstalacao.ListarCandidatos;
var
sDiscAnterior: string;
AParams: TSQLParams;
aDataset: TClientDataset;
begin
 AParams := TSQLParams.Create(2);
 aDataset := TClientDataset.Create(self);

 try
  sDiscAnterior := GetDiscipuladoAnterior(CBXSigla.Items.Strings[CBXDiscipulados.ItemIndex]);

  if sDiscAnterior = '' then
   begin
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.TurmasInstalacao, TCosmosErrorSecMsg.CalcularCandidatos);
    Abort;
   end;

  AParams.AppendData(ICosmosApp.ActiveFocus.FocusID);
  AParams.AppendData(QuotedStr(sDiscAnterior), 1);

  IRemoteCon.ExecuteDQL(csReportTempoDiscipulado, AParams.Params, aDataset);

  //Agora, filtra o resultset para pegar apenas os que estão em condições de serem instalados.
  aDataset.Filter := Format('INDINS = %s', [QuotedStr('S')]);
  aDataset.Filtered := True;

  //Copia todos os dados para um novo dataset que pode ser editado. O dataset anterior não pode.
  while not aDataset.Eof do
   begin
    CdsCandidatos.Append;
    CdsCandidatos.FieldValues['codcad'] := aDataset.FieldValues['codcad'];
    CdsCandidatos.FieldValues['matcadint'] := aDataset.FieldValues['matcadint'];
    CdsCandidatos.FieldValues['matcad'] := aDataset.FieldValues['matcad'];
    CdsCandidatos.FieldValues['nomcad'] := aDataset.FieldValues['nomcad'];
    CdsCandidatos.FieldValues['sigdis'] := aDataset.FieldValues['sigdis'];
    CdsCandidatos.FieldValues['sigfoc'] := aDataset.FieldValues['sigfoc'];
    CdsCandidatos.FieldValues['dathis'] := aDataset.FieldValues['dathis'];
    CdsCandidatos.FieldValues['anos'] := aDataset.FieldValues['anos'];
    CdsCandidatos.FieldValues['meses'] := aDataset.FieldValues['meses'];
    CdsCandidatos.FieldValues['indins'] := aDataset.FieldValues['indins'];

    CdsCandidatos.Post;
    aDataset.Next;
   end;

 finally
  CdsCandidatos.ReadOnly := False;
  CdsCandidatos.First;
  if Assigned(AParams) then FreeAndNil(AParams);
  if Assigned(aDataset) then FreeAndNil(aDataset);
 end;
end;

procedure TFrmAssistenteInstalacao.ListarDiscipuladosEE;
begin
  CdsDiscipulados := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);
  CdsDiscipulados.Filtered := False;
  CdsDiscipulados.Filter := Format('CAMDIS = %s and INDESCINT = %s and INDATI = %s',[QuotedStr('LEC'), QuotedStr('N'), QuotedStr('S')]);
  CdsDiscipulados.Filtered := True;
  CdsDiscipulados.IndexFieldNames := 'seqdis';

  DoListDiscipulados(CdsDiscipulados);
end;

procedure TFrmAssistenteInstalacao.ListarDiscipuladosEI;
begin
  CdsDiscipulados := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);
  CdsDiscipulados.Filtered := False;
  CdsDiscipulados.Filter := Format('INDESCINT = %s and INDATI = %s',[QuotedStr('S'), QuotedStr('S')]);
  CdsDiscipulados.Filtered := True;
  CdsDiscipulados.IndexFieldNames := 'seqdis';

  DoListDiscipulados(CdsDiscipulados);
end;

function TFrmAssistenteInstalacao.LocateCandidato(
  const codcad: integer): boolean;
begin
 if CdsCandidatos.Active then
  Result := CdsCandidatos.Locate('codcad', codcad, [])
 else
  REsult := False;
end;

procedure TFrmAssistenteInstalacao.WzCosmosBeforeNextPage(Sender: TObject;
  CurrentPage: Integer);
var
 sMessage: string;
begin
  inherited;
  case CurrentPage of
   1:
     begin
      if EdtTurma.Text = '' then
        EdtTurma.Text := GetNumeroTurma;
      if RdbEE.Checked then
       ListarDiscipuladosEE
      else
       ListarDiscipuladosEI;

      CBXDiscipulados.ItemIndex := 0;
     end;
   2:begin
      //Primeiro, limpa os dados dos candidatos listados atualmente.
      CdsCandidatos.EmptyDataSet;

      if CdsCandidatos.IsEmpty then
       begin
        if not CanListCandidates then
         Exit //Não há como listar candidatos..
        else
         begin
          sMessage := Format(TCosmosConfMsg.CalcularCandidatos, [CBXDiscipulados.Text]);

          if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasInstalacao, sMessage) = mrYes then
            ListarCandidatos;
         end;
       end;
     end;
  end;
end;


initialization
 RegisterClass(TFrmAssistenteInstalacao);

finalization
 UnRegisterClass(TFrmAssistenteInstalacao);

end.
