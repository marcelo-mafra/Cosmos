unit cosmos.conferencias.view.WizardImportInscricoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, cosmos.system.messages, cosmos.classes.application,
  DB, DBClient, Grids, DBGrids, cosmos.frames.gridsearch, cosmos.business.focos,
  cosmos.classes.ServerInterface, cosmos.frames.searchdata, Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, GroupHeader,
  cosmos.conferencias.inscricoes.importacoes, Vcl.Imaging.pngimage,
  System.Actions, Cosmos.Framework.Interfaces.Root;

type
  TImportModel = (imInternet, imFile, imReferencedConference);

  TFrmWizardImportInscricoes = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    RdbInternet: TRadioButton;
    RdbFile: TRadioButton;
    Label2: TLabel;
    Label3: TLabel;
    Image3: TImage;
    Image4: TImage;
    TabWeb: TTabSheet;
    TabFile: TTabSheet;
    RdbConferenciaAnterior: TRadioButton;
    Label4: TLabel;
    TabOutraConf: TTabSheet;
    EdtFile: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    DlgOpen: TOpenDialog;
    DsrInscritos: TDataSource;
    CdsInscritos: TClientDataSet;
    CdsInscritosMATRICULA: TStringField;
    CdsInscritosNOME: TWideStringField;
    CdsInscritosSEXO: TWideStringField;
    CdsInscritosDISCIPULAD: TWideStringField;
    CdsInscritosNUCLEO: TWideStringField;
    CdsInscritosFAM_NOM: TWideStringField;
    CdsInscritosFAM_TELS: TWideStringField;
    TabDados: TTabSheet;
    FmeGridSearch1: TFmeGridSearch;
    TabProcessamento: TTabSheet;
    CdsInscritosNASCIMENTO: TDateField;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    LblConferencia: TLabel;
    Label6: TLabel;
    LblInicio: TLabel;
    Label7: TLabel;
    LblTermino: TLabel;
    Bevel3: TBevel;
    ActDeleteInscrito: TAction;
    PopupActionBar1: TPopupActionBar;
    ExcluirdaLista1: TMenuItem;
    MSGroupHeader1: TMSGroupHeader;
    FmeSearchConferencias: TFmeSearchData;
    Label8: TLabel;
    EdtInicioConferencia: TLabeledEdit;
    EdtTerminoConferencia: TLabeledEdit;
    EdtCampoTrabalho: TLabeledEdit;
    EdtFocoPromotor: TLabeledEdit;
    MSGroupHeader2: TMSGroupHeader;
    RdbImportarTudo: TRadioButton;
    RdbSelecionarImportacao: TRadioButton;
    ChkImportarAlojamento: TCheckBox;
    LsvList: TListView;
    ImageList2: TImageList;
    procedure WzCosmosBeforeNextPage(Sender: TObject; CurrentPage: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ActProximoUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActDeleteInscritoExecute(Sender: TObject);
    procedure ActDeleteInscritoUpdate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
    FConferenceData: TCosmosData;
    FImportModel: TImportModel;
    procedure ListarInscritosFromFile;
    procedure ListarInscritosFromConference(const codcon: integer);
    procedure ImportarInscritos;

    procedure RegisterProcessing(const ResultCode: Integer; Cadastrado, Value: string);
    procedure SelectedConference(Sender: TObject);
    procedure ClearSummary; inline;

  public
    { Public declarations }
    function Execute: boolean; overload; override;
    function Execute(Data: TCosmosData): boolean; overload; override;
    property ConferenceData: TCosmosData read FConferenceData;
    property ImportModel: TImportModel read FImportModel write FImportModel;
  end;

var
  FrmWizardImportInscricoes: TFrmWizardImportInscricoes;

implementation

{$R *.dfm}

{ TFrmWizardImportInscricoes }

procedure TFrmWizardImportInscricoes.ActDeleteInscritoExecute(Sender: TObject);
begin
  inherited;
  CdsInscritos.Delete;
end;

procedure TFrmWizardImportInscricoes.ActDeleteInscritoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsInscritos.Active) and not (CdsInscritos.IsEmpty);
end;

procedure TFrmWizardImportInscricoes.ActProximoUpdate(Sender: TObject);
begin
  inherited;
 case WzCosmos.ActivePageIndex of
  0, 1, 2, 7: TAction(Sender).Enabled := True;
  4: TAction(Sender).Enabled :=  (Trim(EdtFile.Text) <> '');
  5: TAction(Sender).Enabled :=  FmeSearchConferencias.CosmosData <> nil;
  6: TAction(Sender).Enabled :=  (CdsInscritos.Active) and not (CdsInscritos.IsEmpty);
 end;
end;

function TFrmWizardImportInscricoes.Execute(Data: TCosmosData): boolean;
begin
  FConferenceData.CopyData(Data);

  if ConferenceData.FindValue('nomcon') <> null then
    LblConferencia.Caption := ConferenceData.FindValue('nomcon');

  if ConferenceData.FindValue('datini') <> null then
    LblInicio.Caption := ConferenceData.FindValue('datini');

  if ConferenceData.FindValue('datter') <> null then
    LblTermino.Caption := ConferenceData.FindValue('datter');

  if ConferenceData.FindValue('camcon') = TFocusTypesInfo.CampoTrabalhoToString(ctLectorium) then
   self.FmeSearchConferencias.CosmosSearch := csConferenciasLEC
  else
  if ConferenceData.FindValue('camcon') = TFocusTypesInfo.CampoTrabalhoToString(ctTM) then
   self.FmeSearchConferencias.CosmosSearch := csConferenciasTMO
  else
  if ConferenceData.FindValue('camcon') = TFocusTypesInfo.CampoTrabalhoToString(ctTMB) then
   self.FmeSearchConferencias.CosmosSearch := csConferenciasTMB
  else
  if ConferenceData.FindValue('camcon') = TFocusTypesInfo.CampoTrabalhoToString(ctTP) then
   self.FmeSearchConferencias.CosmosSearch := csConferenciasTPU
  else
   self.FmeSearchConferencias.CosmosSearch := csConferenciasLEC;

  FmeSearchConferencias.OnSelectData := SelectedConference;

  WzCosmos.StartWizard;

  Result := ShowModal = mrOk;
end;

procedure TFrmWizardImportInscricoes.ClearSummary;
begin
 LsvList.Items.Clear;
end;

function TFrmWizardImportInscricoes.Execute: boolean;
var
 IConference: ICosmosConference;
 AData: TCosmosData;
begin
 Result := False;
 IConference := Application.MainForm as ICosmosConference;
 if IConference <> nil then
  begin
   AData := TCosmosData.Create(15);

   try
    if IConference.ActiveConference <> nil then
     begin
      AData.WriteValue('nomcon', IConference.ActiveConference.ConferenceName);
      AData.WriteValue('datini', IConference.ActiveConference.ConferenceStart, 1);
      AData.WriteValue('datter', IConference.ActiveConference.ConferenceEnd, 2);
      AData.WriteValue('camcon', IConference.ActiveConference.CampoPromotor, 3);

      Result := self.Execute(AData);
     end;

   finally
    if Assigned(AData) then FreeAndNil(AData);
    if Assigned(IConference) then IConference := nil;
   end;
  end;
end;

procedure TFrmWizardImportInscricoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FConferenceData) then
   FreeAndNil(FConferenceData);
end;

procedure TFrmWizardImportInscricoes.FormCreate(Sender: TObject);
begin
  inherited;
  FConferenceData := TCosmosData.Create(5);
end;

procedure TFrmWizardImportInscricoes.ImportarInscritos;
var
AParamsList: TCosmosData;
ADataset: TClientDataset;
sMatricula, sNome: string;
IConference: ICosmosConference;
begin
{Importa os inscritos para a conferência.}
 AParamsList := TCosmosData.Create(5);
 ADataset := TClientDataset.Create(self);
 IConference := Application.MainForm as ICosmosConference;

 ClearSummary;

 try
  CdsInscritos.DisableControls;
  CdsInscritos.First;
  ICosmosApp.Components.ProgressBar.MaxPosition := CdsInscritos.RecordCount;
  ICosmosApp.Components.ProgressBar.Visible := True;

  while not CdsInscritos.Eof do
   begin
    with CdsInscritos.Fields do
     begin
      //Busca o inscrito a partir da sua matrícula.
      sMatricula := FieldByName('MATRICULA').AsString;
      sNome := FieldByName('NOME').AsString;
      AParamsList.WriteValue('codcon', IConference.ActiveConference.ConferenceID); //Conferência em questão.
      AParamsList.WriteValue('matcad', sMatricula.QuotedString, 1); //Inscrito a ser importado.

      case ImportModel of
        imInternet, imFile: AParamsList.WriteValue('codconref', 'null', 2);
        imReferencedConference: AParamsList.WriteValue('codconref', FmeSearchConferencias.CosmosData.FindValue('codcon'), 2); //Conferência de onde os inscritos serão copiados, quando prefere-se essa opção.
      end;

      if ChkImportarAlojamento.Checked then
       AParamsList.WriteValue('infalo', TDataConverter.ToBoleanString(True, True), 3) //Informações de alojamento.
      else
       AParamsList.WriteValue('infalo', TDataConverter.ToBoleanString(False, True), 3);

      AParamsList.WriteValue('usures', IRemoteCon.ConnectedUser.QuotedString , 4); //Usuário que efetuou a operação de importação.

      //outputdebugstring(PWideChar(AParamsList.XMLData));
      ICosmosApp.Components.ProgressBar.Position := ICosmosApp.Components.ProgressBar.Position + 1;
      IRemoteCon.ExecuteDQL(csImportarInscritoConferencia , AParamsList.Data, ADataset);
      RegisterProcessing(ADataset.Fields.FieldByName('OCODRESULT').AsInteger, sNome, ADataset.Fields.FieldByName('ODESRESULT').AsString);

      CdsInscritos.Next;
     end;
   end;

  ICosmosApp.Components.ProgressBar.Visible := False;
  ICosmosApp.Components.ProgressBar.Position := 0;
  CdsInscritos.EnableControls;
  IConference := nil;
  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  ICosmosApp.Components.ProgressBar.Visible := False;
  ICosmosApp.Components.ProgressBar.Position := 0;
  IConference := nil;
  CdsInscritos.EnableControls;
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFrmWizardImportInscricoes.ListarInscritosFromConference(
  const codcon: integer);
var
ADataset: TClientDataset;
AParams: TCosmosData;
begin
 AParams := TCosmosData.Create(1);
 AParams.WriteValue('codcon', codcon);
 ADataset := TClientDataset.Create(self);

 try
  CdsInscritos.EmptyDataSet;
  ICosmosApp.IRemoteCon.ExecuteDQL(csListaInscritosConferenciaImportacao, AParams.Data, ADataset);
  Screen.Cursor := crHourGlass;

  while not ADataset.Eof do
   begin
    CdsInscritos.Append;
    CdsInscritos.Fields.FieldByName('matricula').Value := ADataset.Fields.FieldByName('matcad').Value;
    CdsInscritos.Fields.FieldByName('nome').Value := ADataset.Fields.FieldByName('nomcad').Value;
    CdsInscritos.Fields.FieldByName('discipulado').Value := ADataset.Fields.FieldByName('sigdis').Value;
    CdsInscritos.Fields.FieldByName('sexo').Value := ADataset.Fields.FieldByName('sexcad').Value;
    CdsInscritos.Fields.FieldByName('nucleo').Value := ADataset.Fields.FieldByName('sigfoc').Value;
    CdsInscritos.Post;
    ADataset.Next;
   end;

 finally
  Screen.Cursor := crDefault;
  CdsInscritos.First;

  if Assigned(ADataset) then
   FreeAndNil(ADataset);

  if Assigned(AParams) then
   FreeAndNil(AParams);
 end;
end;

procedure TFrmWizardImportInscricoes.ListarInscritosFromFile;
var
AReader: TExcelReader;
AList: TStringList;
begin
 AReader := TExcelReader.Create;
 AList := TStringList.Create;

 try
   if AReader.OpenFile(EdtFile.Text, '[INSCRICOES$]') then //do not localize!
    begin
     CdsInscritos.ReadOnly := False;
     CdsInscritos.EmptyDataSet;

     while not AReader.EOF do
      begin
       AReader.ReadLine(AList);

       with CdsInscritos do
        begin
          Append;
          FieldValues['MATRICULA'] := AList.Values['MATRICULA'];
          FieldValues['NOME'] := AList.Values['NOME'];
          FieldValues['SEXO'] := AList.Values['SEXO'];
          FieldValues['NASCIMENTO'] := AList.Values['NASCIMENTO'];
          FieldValues['DISCIPULADO'] := AList.Values['DISCIPULADO'];
          FieldValues['NUCLEO'] := AList.Values['NUCLEO'];
          FieldValues['FAMILIAR'] := AList.Values['FAMILIAR'];
          FieldValues['TEL_FAMILIAR'] := AList.Values['TEL_FAMILIAR'];
          Post;
        end;

       AReader.NextLine;
      end;

      CdsInscritos.First;
      CdsInscritos.ReadOnly := True;
      AReader.CloseFile;
    end;

    if Assigned(AReader) then FreeAndNil(AReader);
    if Assigned(AList) then FreeAndNil(AList);

 except
  on E: Exception do
   begin
    if Assigned(AReader) then FreeAndNil(AReader);
    if Assigned(AList) then FreeAndNil(AList);
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.InscricoesConferencia, TCosmosErrorMsg.ImportacaoInscritos)
   end;
 end;
end;

procedure TFrmWizardImportInscricoes.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmWizardImportInscricoes.RegisterProcessing(
  const ResultCode: Integer; Cadastrado, Value: string);
var
AList: TListItem;
begin
 AList := LsvList.Items.Add;
 Alist.Caption := Cadastrado;
 AList.SubItems.Append(Value);
 AList.ImageIndex := ResultCode;
end;

procedure TFrmWizardImportInscricoes.SelectedConference(Sender: TObject);
begin
 if FmeSearchConferencias.CosmosData <> nil then
  begin
   EdtInicioConferencia.Text := FmeSearchConferencias.ReadValue('datini');
   EdtTerminoConferencia.Text := FmeSearchConferencias.ReadValue('datter');
   EdtFocoPromotor.Text := FmeSearchConferencias.ReadValue('nomfoc');
   EdtCampoTrabalho.Text := FmeSearchConferencias.ReadValue('camcon');
  end;
end;

procedure TFrmWizardImportInscricoes.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if DlgOpen.Execute then
   EdtFile.Text := DlgOpen.FileName;
end;

procedure TFrmWizardImportInscricoes.WzCosmosBeforeNextPage(Sender: TObject;
  CurrentPage: Integer);
begin
  inherited;
  if not RdbConferenciaAnterior.Checked then
   ChkImportarAlojamento.Checked := False;

  ChkImportarAlojamento.Enabled := RdbConferenciaAnterior.Checked;
  wzCosmos.Pages[3].Visible := RdbInternet.Checked;
  wzCosmos.Pages[4].Visible := RdbFile.Checked;
  wzCosmos.Pages[5].Visible := RdbConferenciaAnterior.Checked;
  wzCosmos.Pages[6].Visible := RdbFile.Checked;
  wzCosmos.Pages[7].Visible := True;

  if RdbInternet.Checked then
   ImportModel := imInternet
  else
  if RdbFile.Checked then
   ImportModel := imFile
  else
   ImportModel := imReferencedConference;


  case CurrentPage of
   4://Importar inscritos de um arquivo...
    begin
      if Trim(EdtFile.Text) = '' then
       begin
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.InscricoesConferencia,  TCosmosInfoMsg.InscricoesArquivoDesconhecido);
        Abort;
       end;
      if not FileExists(EdtFile.Text) then
       begin
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.InscricoesConferencia,  TCosmosInfoMsg.InscricoesArquivoInexistente);
        Abort;
       end;

      ListarInscritosFromFile;
    end;
   5: //Conferência anterior...
    begin
     if ConferenceData.FindValue('codcon') = FmeSearchConferencias.ReadValue('codcon') then
      begin
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.InscricoesConferencia,  TCosmosInfoMsg.InscricoesFonteDestino);
       Abort;
      end;

     if self.RdbImportarTudo.Checked then
      begin
       if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InscricoesConferencia, TCosmosConfMsg.ImportarInscritos) = mrYes then
         self.ImportarInscritos
       else
        Abort;
      end
     else
      ListarInscritosFromConference(FmeSearchConferencias.ReadValue('codcon'))
    end;
   6: //Dados dos inscritos...
    begin
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InscricoesConferencia, TCosmosConfMsg.ImportarInscritos) = mrYes then
      self.ImportarInscritos
     else
      Abort;
    end;
  end;
end;

initialization
 RegisterClass(TFrmWizardImportInscricoes);

finalization
 UnRegisterClass(TFrmWizardImportInscricoes);

end.
