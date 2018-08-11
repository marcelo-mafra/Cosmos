unit cosmos.common.view.reportscenter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.ImgList, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, cosmos.classes.application, cosmos.reports.types,
  cosmos.business.focos, cosmos.framework.interfaces.root,
  cosmos.framework.interfaces.dataacess, cosmos.framework.interfaces.dialogs,
  Winapi.CommCtrl, Vcl.Grids, Vcl.ValEdit, Vcl.Imaging.jpeg,
  Data.DB, cosmos.system.messages, System.DateUtils, cosmos.classes.security,
  cosmos.system.winshell, cosmos.classes.ServerInterface, Datasnap.DBClient,
  Vcl.Dialogs, cosmos.framework.forms.datadialogs, cosmos.framework.forms.conferencias,
  cosmos.framework.forms.focos, cosmos.common.classes.repparamsparser,
  cosmos.classes.persistence.ini, cosmos.tools.tasks.classes, Vcl.Menus,
  System.Actions, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Data.DBXCommon, cosmos.system.types,
  frxClass, FrxVariables, frxExportPDF, frxExportRTF, frxExportCSV, frxExportImage, frxExportHTML,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, cosmos.classes.datasetspool,
  cosmos.system.exceptions;


type
  PReport = ^TReport;
  TReport = record
   ReportId: integer;
   nomrep: string;
   tiprep: TReportType;
   desrep: string;
   nomarq: string;
   reporttool: TReportTool;
   Enabled: boolean;
  end;

  TFrmReportCenter = class(TForm, IReportCenter)
    Image1: TImage;
    TrvReports: TTreeView;
    ImageList1: TImageList;
    Bevel1: TBevel;
    LblTitle: TLabel;
    LblDesc: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel2: TBevel;
    ActionList1: TActionList;
    ActPreview: TAction;
    ActPrint: TAction;
    Button4: TButton;
    Button5: TButton;
    LstParams: TValueListEditor;
    Bevel3: TBevel;
    Image2: TImage;
    LblParamHint: TLabel;
    ActHelp: TAction;
    XMLReportsInfo: TXMLDocument;
    FRProject: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxRTFExport1: TfrxRTFExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxCSVExport1: TfrxCSVExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxGIFExport1: TfrxGIFExport;
    PopupActionBar1: TPopupActionBar;
    Documentos1: TMenuItem;
    MenuItem1: TMenuItem;
    Listagem1: TMenuItem;
    Imprimir1: TMenuItem;
    ActPDFOptions: TAction;
    OpesparaPDF1: TMenuItem;
    N1: TMenuItem;
    frxBMPExport1: TfrxBMPExport;
    procedure LstParamsEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActPreviewUpdate(Sender: TObject);
    procedure ActPrintExecute(Sender: TObject);
    procedure ActPreviewExecute(Sender: TObject);
    procedure TrvReportsChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TrvReportsChange(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure LstParamsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ActHelpExecute(Sender: TObject);
    procedure FRProjectProgress(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure FRProjectProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure FRProjectProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActPDFOptionsExecute(Sender: TObject);
    procedure ActPDFOptionsUpdate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FIReports: IXMLReports;
    FParamsFile: string;
    FRepServerParams, FRepLocalParams: TCosmosData;
    FExecutionMode: cosmos.reports.types.TExecutionMode;

    function GetReportEnabled: boolean;
    function GetActiveReport: PReport;

    function GetSelectedItem: TReportType;
    procedure OpenExternalReport(const FileName: string; Mode: TOpenMode);
    procedure DescribeReport(PRep: PReport);
    property SelectedItem: TReportType read GetSelectedItem;
    property ReportEnabled: boolean read GetReportEnabled;

    procedure ListReports;
    procedure LoadReportsInfo;
    procedure CreateParamsObjects(const ReportId: integer);
    procedure SetGlobalParams;

    procedure ListExternalReports(Module: TCosmosModules);
    procedure ListExternalCategories(List: TStringList);
    procedure SelectReportNode(const ReportName: string); overload;
    procedure SelectReportNode(const ReportId: integer); overload;
    function GetNodeType(Node: TTreeNode): TReportType; inline;

    procedure SaveParamsToFile(const ReportName: string);
    procedure ReadParamsFromFile(const ReportName: string);

    procedure ValidateParams(Params: TCosmosData);
    function FindReportNode(const ReportId: integer): IXMLReport;
    function FindParamNode(const ReportId: integer; ParamName: string): IXMLReportParam;

    procedure ListParamsValues; overload;
    procedure ListParamsValues(AData: TCosmosData); overload;
    procedure ListParamsValues(DestField, SourceField: string; AData: TCosmosData); overload;
    procedure CopyParamsValues(AData: TCosmosData); overload;
    procedure CopyParamsValues(DestField, SourceField: string; AData: TCosmosData); overload;

    function GetParamDefaultValue(const AParamValue: string): variant;
    function GetParamHelp(const ReportId: integer; ParamName: string): string;

    procedure FormatParamsValues;
    function PrepareReport(const ReportId: TReportsSecretarias): boolean; overload;
    function PrepareReport(const ReportId: TReportsFinanceiro): boolean; overload;
    function PrepareReport(const ReportId: TReportsConferencias): boolean; overload;

    function FiltrarTarefas: string; inline;
    procedure BuildReport(PrintMode: TPrintMode);
    procedure SetLocalParams;
    function GetDatasets: TDatasetsPool;
    procedure DestroyDataset;



  protected
    function GetReportFile: string;
    procedure SetReportFile(const value: string);

    property ReportFile: string read GetReportFile write SetReportFile;
    procedure PrintReport(const ReportName: string);
    procedure PreviewReport(const ReportName: string);
    //Secretarias
    procedure PrintFichaAluno(const matcad: string);
    procedure PrintFichaJovemTM(const matcad: string);
    procedure PrintFichaPesquisador(const matcad: string);
    procedure PrintFichasAlunos(const matriculas: string);
    procedure PrintHistoric(AData: TCosmosData);
    procedure PrintCarteiraAluno(const matcad: string);
    procedure PrintCarteirasAlunos(const matcad: string);
    procedure PrintListagemByDiscipulado(const Discipulado: string);
    procedure PrintBoletimInfo(const DataInicial, DataFinal: TDateTime);
    procedure PrintFolhaPresenca(Data: TCosmosData; Tipo: TTipoFolhaPresenca);
    procedure PrintFolhaPresencaEI(Data: TCosmosData);

    procedure ShowReportCenter;

    //Conferências
    procedure PrintCrachaInscrito(const codins: integer);
    procedure PrintListagemInscritos(ConferenceData: TCosmosData);
    procedure PrintProgramacaoConferencia(AData: TCosmosData);



  public
    { Public declarations }
    property ActiveReport: PReport read GetActiveReport;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property ParamsFile: string read FParamsFile;
    property RepServerParams: TCosmosData read FRepServerParams;
    property RepLocalParams: TCosmosData read FRepLocalParams;
    property IReports: IXMLReports read FIReports;
    property ExecutionMode: cosmos.reports.types.TExecutionMode read FExecutionMode write FExecutionMode default cosmos.reports.types.emExecuteCentral;
    property Datasets: TDatasetsPool read GetDatasets;

  end;


var
  FrmReportCenter: TFrmReportCenter;

implementation

uses cosmos.secretarias.reports, cosmos.secretarias.reports.data,
 cosmos.conferencias.reports, cosmos.conferencias.reports.data,
 cosmos.focos.reports, cosmos.focos.reports.data,
 cosmos.financeiro.reports, cosmos.financeiro.reports.data,
 cosmos.common.view.dlgpdfoptions;


{$R *.dfm}

procedure SetNodeBoldState(Node: TTreeNode; Value: Boolean);
var
  TVItem: TTVItem;
begin
//Insere ou retira o negrito no texto do objeto TTreeNode passado.
 if not Assigned(Node) then
  Exit;
 with TVItem do
  begin
   mask := TVIF_STATE or TVIF_HANDLE;
   hItem := Node.ItemId;
   stateMask := TVIS_BOLD;
   if Value then state := TVIS_BOLD
   else
    state := 0;
   TreeView_SetItem(Node.Handle, TVItem);
  end;
end;


{ TFrmReportCenter }

procedure TFrmReportCenter.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmReportCenter.ActPDFOptionsExecute(Sender: TObject);
begin
 FrmPDFOptions := TFrmPDFOptions.Create(self);

 try
  FrmPDFOptions.ConfigurePDFOptions(FrxPDFExport);

 finally
  if not Assigned(FrmPDFOptions) then
   FreeAndNil(FrmPDFOptions);
 end;
end;

procedure TFrmReportCenter.ActPDFOptionsUpdate(Sender: TObject);
begin
 TAction(sender).Enabled := (SelectedItem = rtReport) and (ReportEnabled = True)
  and (IReports <> nil);
end;

procedure TFrmReportCenter.ActPreviewExecute(Sender: TObject);
begin
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.ActPreviewUpdate(Sender: TObject);
begin
 TAction(sender).Enabled := (SelectedItem in [rtReport, rtExternalReport])
  and (ReportEnabled = True) and (IReports <> nil);
end;

procedure TFrmReportCenter.ActPrintExecute(Sender: TObject);
begin
 BuildReport(pmPrint);
end;

procedure TFrmReportCenter.BuildReport(PrintMode: TPrintMode);
var
AMessage: TMessageData;
Prepared: boolean;
begin
{Contrói o relatório e chama a janela de preview ou o manda direto para a
 impressora. Este método é usado tanto para relatório Rave quanto Fast Report.}
 FrProject.Clear;
 FrProject.DataSets.Clear;

 //Verifica se um relatório está selecionado.
 if TrvReports.Selected <> nil then
  begin
   if ActiveReport.tiprep = rtExternalReport then //Relatórios externos.
     OpenExternalReport(ActiveReport.nomarq, omOpen)
   else
    begin
     //Fast Report
     FRProject.FileName := ActiveReport.nomarq;
     FRProject.LoadFromFile(ActiveReport.nomarq);

     try
      case ICosmosApp.CosmosModule of
       cmFocos: ;
       cmSecretarias:
        begin
         Prepared := PrepareReport(TReportsSecretarias(ActiveReport.ReportId));
        end;
       cmFinanceiro:
        begin
         Prepared := PrepareReport(TReportsFinanceiro(ActiveReport.ReportId));
        end;
       cmConferencias:
        begin
         Prepared := PrepareReport(TReportsConferencias(ActiveReport.ReportId));
        end;
       cmUsuarios: ;
      end;

     except
      Prepared := False;
     end;

    try
     if Prepared then
       begin
        SaveParamsToFile(ActiveReport.nomrep);
        SetLocalParams;
        SetGlobalParams;

        case PrintMode of
          pmPreview: FRProject.ShowReport(True);
          pmPrint:
           begin
            if FRProject.PrepareReport then
             FRProject.Print;
           end;
        end;

        DestroyDataset;
       end;

    except
     on E: Exception do
      begin
       if E.ClassName = 'EJPEG' then //Está gerando erro fatal se registrar log.
        begin
         AMessage := ICosmosApp.CreateMessageData(TCosmosErrorMsg.ReportPhoto, TCosmosTitles.ReportsCenter, mtpError);
         AMessage.SetMessageInfo(miInnerMessage, E.Message);
         ICosmosApp.DlgMessage.Execute(AMessage);
        end
       else
        begin
         AMessage := ICosmosApp.CreateMessageData(TCosmosErrorMsg.ReportExecute, TCosmosTitles.ReportsCenter, mtpError);
         AMessage.SetMessageInfo(miInnerMessage, E.Message);

         if Assigned(ICosmosApp.MainLog) then
          ICosmosApp.MainLog.RegisterError(E.Message);

         ICosmosApp.DlgMessage.Execute(AMessage);
        end;

       if Assigned(AMessage) then
        FreeAndNil(AMessage);
      end;
    end;
    end;
  end;
end;

procedure TFrmReportCenter.CopyParamsValues(DestField, SourceField: string;
  AData: TCosmosData);
var
AFieldIndex: integer;
AFieldValue: variant;
begin
{Copia um valor de parâmento da estrutura passada para o objeto a ser
 passado para o servidor remoto e o objeto de parâmetros locais. Este método
 deve ser usado quando não há equivalência de nomes entre o parâmetro e o
 campo do dataset que foi copiado para a estrutura TCosmosData passada.}

 AFieldValue := AData.FindValue(SourceField);
 if AFieldValue <> null then
  begin
   //Trabalha com a estrutura de dados a ser enviada ao servidor.
   AFieldIndex := RepServerParams.FindIndex(DestField);
   if AFieldIndex >= 0 then
    RepServerParams.WriteValue(DestField, AFieldValue, AFieldIndex);

   //Trabalha com a estrutura de dados local.
   AFieldIndex := RepLocalParams.FindIndex(DestField);
   if AFieldIndex >= 0 then
    RepLocalParams.WriteValue(DestField, AFieldValue, AFieldIndex);
  end;
end;

procedure TFrmReportCenter.CreateParamsObjects(const ReportId: integer);
var
 I: integer;
 IReport: IXMLReport;
 IReportParams: IXMLReportParams;
 AParamName: string;
 ADefaultValue: string;
 AParamPosition: integer;
begin
 if IReports <> nil then
  begin
   //Busca no arquivo XML de parâmetros informações sobre o relatório atual.
   IReport := self.FindReportNode(ReportId);
   if IReport = nil then Exit;

   IReportParams := IReport.Params;

   //Limpa os dados dos objetos de parâmetros locais e remotos.
   RepServerParams.ClearData;
   RepLocalParams.ClearData;

   for I := 0 to Pred(IReportParams.Count) do
     begin
       AParamName := IReportParams.Param[I].ParamName;
       AParamPosition := IReportParams.Param[I].Order;

       {Pega o valor default do parâmetro, caso exista no arquivo de configuração.
        Este valor pode ser ua tag, que será convertida para um valor real,
        ou pode ser uma constante, como, por exemplo, "Sim" ou "Não".}
       ADefaultValue := IReportParams.Param[I].DefaultValue;
       if ADefaultValue <> '' then
         ADefaultValue := GetParamDefaultValue(ADefaultValue);

       if IReportParams.Param[I].SendToServer = 1 then //Parâmetro de consulta SQL no servidor remoto.
         begin
           case IReportParams.Param[I].ParamType of
            //valor do tipo integer.
            0: if ADefaultValue = '' then
                RepServerParams.WriteValue(AParamName, 0, AParamPosition)
               else
                RepServerParams.WriteValue(AParamName, TDataConverter.ToInteger(ADefaultValue), AParamPosition);
            //valor do tipo string.
            1: if ADefaultValue = '' then
                RepServerParams.WriteValue(AParamName, '', AParamPosition)
               else
                RepServerParams.WriteValue(AParamName, ADefaultValue, AParamPosition);
            //valor do tipo Date.
            2: if ADefaultValue = '' then
                RepServerParams.WriteValue(AParamName, '', AParamPosition)
               else
                RepServerParams.WriteValue(AParamName, ADefaultValue, AParamPosition);
            //valor do tipo boolean.
            3: if ADefaultValue = '' then
                RepServerParams.WriteValue(AParamName, 'S', AParamPosition)
               else
                RepServerParams.WriteValue(AParamName, Copy(ADefaultValue, 1, 1), AParamPosition);
            4, 5: RepServerParams.WriteValue(AParamName, '', AParamPosition); //valores do tipo lista de strings.
            //Valor do tipo hora
            6: if ADefaultValue = '' then
                RepServerParams.WriteValue(AParamName, '', AParamPosition)
               else
                RepServerParams.WriteValue(AParamName, ADefaultValue, AParamPosition);
           end;
         end
         else  //Parâmetro de informação local, utilizado em variável do relatório.
           begin
             case IReportParams.Param[I].ParamType of
              //valor do tipo integer.
              0: if ADefaultValue = '' then
                  RepLocalParams.WriteValue(AParamName, 0, AParamPosition)
                 else
                  RepLocalParams.WriteValue(AParamName, TDataConverter.ToInteger(ADefaultValue), AParamPosition);
              //valor do tipo string.
              1: if ADefaultValue = '' then
                  RepLocalParams.WriteValue(AParamName, '', AParamPosition)
                 else
                  RepLocalParams.WriteValue(AParamName, ADefaultValue, AParamPosition);
              //valor do tipo Date.
              2: if ADefaultValue = '' then
                  RepLocalParams.WriteValue(AParamName, '', AParamPosition)
                 else
                  RepLocalParams.WriteValue(AParamName, ADefaultValue, AParamPosition);
              //valor do tipo boolean.
              3: if ADefaultValue = '' then
                  RepLocalParams.WriteValue(AParamName, 'S', AParamPosition)
                 else
                  RepLocalParams.WriteValue(AParamName, Copy(ADefaultValue, 1, 1), AParamPosition);
              //valor do tipo lista de strings.
              4, 5: RepLocalParams.WriteValue(AParamName, '', AParamPosition);
              //valor do tipo hora.
              6: if ADefaultValue = '' then
                  RepLocalParams.WriteValue(AParamName, '', AParamPosition)
                 else
                  RepLocalParams.WriteValue(AParamName, ADefaultValue, AParamPosition);
             end;
           end;
     end;
  end;
end;

procedure TFrmReportCenter.CopyParamsValues(AData: TCosmosData);
var
I, AFieldIndex: integer;
AFieldValue: variant;
AFieldName: string;
begin
{Copia os valores dos parâmetros da estrutura passada para o objeto a ser
 passado para o servidor remoto e o objeto de parâmetros locais.}

 for I := 0 to Pred(AData.DataCount) do
   begin
    AFieldName := AData.FindFieldName(I);

    if AFieldName <> null then
     begin
      AFieldValue := AData.FindValue(AFieldName);

      //Trabalha com a estrutura de dados a ser enviada ao servidor.
      AFieldIndex := RepServerParams.FindIndex(AFieldName);
      if AFieldIndex >= 0 then
        RepServerParams.WriteValue(AFieldName, AFieldValue, AFieldIndex);

      //Trabalha com a estrutura de dados local.
      AFieldIndex := RepLocalParams.FindIndex(AFieldName);
      if AFieldIndex >= 0 then
        RepLocalParams.WriteValue(AFieldName, AFieldValue, AFieldIndex);
     end;
   end;
end;

procedure TFrmReportCenter.ValidateParams(Params: TCosmosData);
var
I: integer;
Param, Value: variant;
begin
{Verifica se os valores passados em parâmetro estão preenchidos...}
 if not Assigned(Params) then
   Exit;

 for I := 0 to Pred(Params.DataCount) do
  begin
   Param := Params.FindFieldName(I);
   if Param = null then
     Break;

   Value := Params.FindValue(I);
   if Value = null then
    Value := '';

   //Verifica se a matrícula do cadastrado foi fornecida.
   if (Param = 'MATCAD') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamMatricula, mtError);
      Abort;
    end;

   //Verifica se o código do grupo da Escola Interna foi fornecido.
   if (Param = 'CODGRU') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamCirculoEI, mtError);
      Abort;
   end;

   //Verifica se a atividade foi fornecida.
   if (Param = 'NOMATI') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamAtividade, mtError);
      Abort;
    end;

   //Verifica se o ano de uma Params foi fornecido.
   if (Param = 'ANO') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamAno, mtError);
      Abort;
    end;

   if (Param = 'MATRICULAS') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosErrorMsg.ParamMatriculas, mtError);
      Abort;
    end;

   if (Param = 'MATRICULAS-TMB') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosErrorMsg.ParamMatriculas, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-LEC') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamMatriculaLEC, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-TM') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamMatriculaTM, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-TMB') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamMatriculaTMB, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-TP') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosReportsError.ParamMatriculaTP, mtError);
      Abort;
    end;
  end;
end;

procedure TFrmReportCenter.DescribeReport(PRep: PReport);
begin
//Descreve a ajuda para o relatório "Report"
 LblTitle.Caption := PRep.nomrep;
 LblDesc.Caption :=  PRep.desrep
end;

procedure TFrmReportCenter.DestroyDataset;
begin
 case ICosmosApp.CosmosModule of
   cmFocos: ;
   cmSecretarias: DMSecData.DestroyDataset;
   cmFinanceiro: ;
   cmConferencias: ;
   cmUsuarios: ;
 end;
end;

procedure TFrmReportCenter.PrintListagemInscritos(ConferenceData: TCosmosData);
begin
 //Imprime a lista de inscritos em conferência.
 ExecutionMode := emExecuteReport;
 ListReports;
 SelectReportNode(Ord(TReportsConferencias.rcInscritosConferencia));

 RepServerParams.WriteValue('CODCON', ConferenceData.FindValue('CODCON'));

 RepLocalParams.WriteValue('NOMCON', ConferenceData.FindValue('NOMCON'));
 RepLocalParams.WriteValue('NOMFOC', ConferenceData.FindValue('NOMFOC'), 1);
 RepLocalParams.WriteValue('DATINI', ConferenceData.FindValue('DATINI'), 2);
 RepLocalParams.WriteValue('DATTER', ConferenceData.FindValue('DATTER'), 3);

 LstParams.Values[LstParams.Keys[1]] := RepLocalParams.FindValue('NOMCON');
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintProgramacaoConferencia(AData: TCosmosData);
begin
 //Imprime a programação de uma conferência.
 ExecutionMode := emExecuteReport;
 ListReports;
 SelectReportNode(Ord(TReportsConferencias.rcProgramacao));

 RepServerParams.WriteValue('CODCON', AData.FindValue('CODCON'));

 RepLocalParams.WriteValue('NOMCON', AData.FindValue('NOMCON'));
 RepLocalParams.WriteValue('NOMFOC', AData.FindValue('NOMFOC'), 1);
 RepLocalParams.WriteValue('DATINI', AData.FindValue('DATINI'), 2);
 RepLocalParams.WriteValue('DATTER', AData.FindValue('DATTER'), 3);

 LstParams.Values[LstParams.Keys[1]] := RepLocalParams.FindValue('NOMCON');
 BuildReport(pmPreview);
end;

function TFrmReportCenter.PrepareReport(const ReportId: TReportsConferencias): boolean;
var
sLocalParamName, sLocalParamValue: string;
AMessage: TMessageData;
AFileName: string;
Tasks: TTasks;
aTempData: TCosmosData;
aDataset: TClientDataset;
aValue: Variant;
begin
//Prepara os dados de um relatório do módulo de secretarias.
 try
  if ExecutionMode = emExecuteCentral then //Somente executa os métodos abaixo nesse modo.
   begin
    //Formata os dados e escreve tudo nas duas estruturas de parâmetros em memória.
     FormatParamsValues;

    //Valida os valores existentes nos objetos de dados local e a enviar ao servidor.
     ValidateParams(RepServerParams);
     ValidateParams(RepLocalParams);
   end;

 except
   on E: Exception do
    begin
       Result := False;
       AMessage := ICosmosApp.CreateMessageData(TCosmosErrorMsg.FormatParams, TCosmosTitles.ReportParams, mtpError);
       AMessage.SetMessageInfo(miInnerMessage, E.Message);
       AMessage.SetMessageInfo(miCustomInfo, self.TrvReports.Selected.Text);
       ICosmosApp.DlgMessage.Execute(AMessage);
       ICosmosApp.MainLog.RegisterError(AMessage.XMLData);

       if Assigned(AMessage) then
        FreeAndNil(AMessage);
      raise;
    end;
 end;

 //Obtém os dados do relatório no servidor remoto.
 try
   DMConfData.Datasets.ClearAll;

   case ReportId of
     rcCrachas:
      begin
       Datasets.FillPool(2);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBCrachas.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCrachasInscritos, RepServerParams.Data, aDataset);


       DMConfData.DsrMasterSource.DataSet := aDataset;
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBTarefasCracha.DataSet := aDataset;

       ICosmosApp.IRemoteCon.ExecuteDQL(csStaffConferencia, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMConfData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODINS'; //do not localize!
       aDataset.MasterFields := 'CODINS'; //do not localize!
      end;
     rcCrachaInscrito:
      begin
       Datasets.FillPool(2);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBCrachas.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCrachaInscrito, RepServerParams.Data, aDataset);

       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBTarefasCracha.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCrachaTarefasInscrito, RepServerParams.Data, aDataset);
      end;
   rcInscritosConferencia:
    begin
     Datasets.FillPool(1);
     aDataset := Datasets.GetNewDataset;
     DMConfReports.frxDBListaInscritos.DataSet := aDataset;
     ICosmosApp.IRemoteCon.ExecuteDQL(csReportInscritosConferencia, RepServerParams.Data, aDataset);
    end;
    rcInscritosDesalojados:
     begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBListaInscritos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportInscritosDesalojados, RepServerParams.Data, aDataset);
     end;
    rcFolhasQuartos:
     begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBFolhasQuartos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csFolhasQuartos, RepServerParams.Data, aDataset);
     end;
    rcProgramacao:
     begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBProgramacao.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csProgramacaoConferencia, RepServerParams.Data, aDataset);
     end
    else
     raise EReportException.Create(TCosmosErrorMsg.ReportDataError);


   {rcAreasTarefasStaff:
    begin
     AParams := TCosmosData.Create(5);
      try
       AParams.WriteValue('CODFOC', ICosmosApp.ActiveFocus.FocusID);
       IRemoteCon.ExecuteDQL(csAreasTarefasStaff, AParams.Data, DMConfData.CdsAreasStaff);
       IRemoteCon.ExecuteDQL(csStaffConferencia, RepServerParams.Data, DMConfData.CdsStaffs);

      finally
       if Assigned(AParams) then
        FreeAndNil(AParams);
      end;
    end;
   rcListarTarefas:
    begin
     IRemoteCon.ExecuteDQL(csStaffConferencia, RepServerParams.Data, DMConfData.CdsStaffs);
    end;
   rcMapaAlojamento:
    begin
     IRemoteCon.ExecuteDQL(csAlojamentosFoco, RepServerParams.Data, DMConfData.CdsAlojamentos);
     IRemoteCon.ExecuteDQL(csReportLeitosAlojamentos, RepServerParams.Data, DMConfData.CdsLeitos);
    end;
   rcInfoInscritos:
    begin
     IRemoteCon.ExecuteDQL(csReportInformacoesInscritosByFlag, RepServerParams.Data, DMConfData.CdsInformacoesInscritos);
    end;
   rcAlojadosQuartos:
    begin
     IRemoteCon.ExecuteDQL(csQuartosUsadosAlojamento, RepServerParams.Data, DMConfData.CdsQuartosAlojamento);
     IRemoteCon.ExecuteDQL(csAlojadosQuartos, RepServerParams.Data, DMConfData.CdsInformacoesInscritos);
    end;}

   end;

   //Se chegou aqui, os dados do relatório foram preparados com sucesso.
   Result := True;

 except
  on E: Exception do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ReportsCenter, TCosmosErrorMsg.FormatParams);
    ICosmosApp.MainLog.RegisterError(E.Message);
    raise;
   end;
  on E: EReportException do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ReportsCenter, E.Message);
    ICosmosApp.MainLog.RegisterError(E.Message);
    raise;
   end;
 end;
end;

function TFrmReportCenter.PrepareReport(const ReportId: TReportsSecretarias): boolean;
var
sLocalParamName, sLocalParamValue: string;
AMessage: TMessageData;
AFileName: string;
Tasks: TTasks;
aTempData: TCosmosData;
aDataset: TClientDataset;
aValue: Variant;
begin
//Prepara os dados de um relatório do módulo de secretarias.
 try
  if ExecutionMode = emExecuteCentral then //Somente executa os métodos abaixo nesse modo.
   begin
    //Formata os dados e escreve tudo nas duas estruturas de parâmetros em memória.
     FormatParamsValues;

    //Valida os valores existentes nos objetos de dados local e a enviar ao servidor.
     ValidateParams(RepServerParams);
     ValidateParams(RepLocalParams);
   end;

 except
   on E: Exception do
    begin
       Result := False;
       AMessage := ICosmosApp.CreateMessageData(TCosmosErrorMsg.FormatParams, TCosmosTitles.ReportParams, mtpError);
       AMessage.SetMessageInfo(miInnerMessage, E.Message);
       AMessage.SetMessageInfo(miCustomInfo, self.TrvReports.Selected.Text);
       ICosmosApp.DlgMessage.Execute(AMessage);
       ICosmosApp.MainLog.RegisterError(AMessage.XMLData);

       if Assigned(AMessage) then
        FreeAndNil(AMessage);
      raise;
    end;
 end;

 //Obtém os dados do relatório no servidor remoto.
 try
   DMSecData.Datasets.ClearAll;

   case ReportId of
     rsEnderecosAlunos, rsEnderecosJovensTM, rsEnderecosPesquisadores:
      begin
       Datasets.FillPool(3);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBListaAlunos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportListaCadastrados, RepServerParams.Data, aDataset);

       DMSecData.DsrMasterSource.DataSet := aDataset;

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxEnderecoAluno.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csEnderecosFocoCampo, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
       aDataset.MasterFields := 'CODCAD'; //do not localize!

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxMeiosContatosAluno.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csMeiosContatoFocoCampo, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
       aDataset.MasterFields := 'CODCAD'; //do not localize!
      end;
     rsFichaAluno, rsFichaJovemTM, rsFichaPesquisador:
       begin
        //Obtém os dados do cadastrado.
        Datasets.FillPool(7);
        aDataset := Datasets.GetNewDataset;
        DMSecReports.frxFichaCadastral.DataSet := aDataset;

        ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichaAluno, RepServerParams.Data, aDataset);


        if (aDataset.Active) and not (aDataset.IsEmpty) then
         begin
          {O objeto "aTempData" é usado aqui porque não podemos alterar RepServerParams
           sem causar erro ao dar preview duas vezes seguidas no mesmo relatório. Isso porque
           não podemos alterar a estrutura de RepServerParams nesse método, mas apenas
           preencher seus parâmetros.}
          aTempData := TCosmosData.Create(5);

          try
            //Endereços dos alunos.
            aTempData.ClearData;
            //Pega o código do aluno e passa para a pesquisa de endereços.
            aValue := aDataset.Fields.FieldByName('CODCAD').AsInteger;
            aTempData.WriteValue('CODCAD', aValue);
            aTempData.WriteValue('INDCOR', QuotedStr('S'), 1);

            aDataset := Datasets.GetNewDataset;
            DMSecReports.frxEnderecoAluno.DataSet := aDataset;
            ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichaAlunoEndereco, aTempData.Data, aDataset);

            //Meios de contatos
            aTempData.ClearData;
            aTempData.WriteValue('CODCAD', aValue);

            aDataset := Datasets.GetNewDataset;
            DMSecReports.frxMeiosContatosAluno.DataSet := aDataset;
            ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichaAlunoMeioContato, aTempData.Data, aDataset);

            if ReportId <> rsFichaJovemTM then
             begin
              //Agora, pesquisa o histórico do alunos.
              aDataset := Datasets.GetNewDataset;
              DMSecReports.frxHistoricoDiscipular.DataSet := aDataset;
              ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichaAlunoHistorico, aTempData.Data, aDataset);
             end;

            if ReportId = rsFichaAluno then //Se aluno, pesquisa as funções do aluno.
             begin
              //Agora, pesquisa as funções do aluno.
               aDataset := Datasets.GetNewDataset;
               DMSecReports.frxFuncoes.DataSet := aDataset;
               ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichaAlunoFuncoes, aTempData.Data, aDataset);
             end;

            if ReportId = rsFichaJovemTM then //Se jovem ou membro, pesquisa os familiares.
             begin
              aDataset := Datasets.GetNewDataset;
              DMSecReports.frxFamiliares.DataSet := aDataset;
              ICosmosApp.IRemoteCon.ExecuteDQL(csFamiliaresCadastrado, aTempData.Data, aDataset);
             end;

          finally
           if Assigned(aTempData) then FreeAndNil(ATempData);
          end;
         end;
       end;
     rsFichasAlunos:
      begin
        //Obtém os dados do cadastrado.
        Datasets.FillPool(7);
        aDataset := Datasets.GetNewDataset;
        DMSecReports.frxFichaCadastral.DataSet := aDataset;
        ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichasAlunos, RepServerParams.Data, aDataset);
        DMSecData.DsrMasterSource.DataSet := aDataset;


        if (aDataset.Active) and not (aDataset.IsEmpty) then
         begin
          //Endereços.
          aDataset := Datasets.GetNewDataset;
          DMSecReports.frxEnderecoAluno.DataSet := aDataset;
          ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichasAlunosEndereco, RepServerParams.Data, aDataset);
          aDataset.MasterSource := DMSecData.DsrMasterSource;
          aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
          aDataset.MasterFields := 'CODCAD'; //do not localize!

          //Meios de contatos
          aDataset := Datasets.GetNewDataset;
          DMSecReports.frxMeiosContatosAluno.DataSet := aDataset;
          ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichasAlunosMeioContato, RepServerParams.Data, aDataset);
          aDataset.MasterSource := DMSecData.DsrMasterSource;
          aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
          aDataset.MasterFields := 'CODCAD'; //do not localize!

          //Agora, pesquisa o histórico do alunos.
          aDataset := Datasets.GetNewDataset;
          DMSecReports.frxHistoricoDiscipular.DataSet := aDataset;
          ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichasAlunosHistorico, RepServerParams.Data, aDataset);
          aDataset.MasterSource := DMSecData.DsrMasterSource;
          aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
          aDataset.MasterFields := 'CODCAD'; //do not localize!

          //Agora, pesquisa as funções do aluno.
          aDataset := Datasets.GetNewDataset;
          DMSecReports.frxFuncoes.DataSet := aDataset;
          ICosmosApp.IRemoteCon.ExecuteDQL(csReportFichasAlunosFuncoes, RepServerParams.Data, aDataset);
          aDataset.MasterSource := DMSecData.DsrMasterSource;
          aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
          aDataset.MasterFields := 'CODCAD'; //do not localize!
         end;
      end;
     rsCarteirinhaAluno:
       begin
        sLocalParamValue := LstParams.Values['Validade'];
        FrProject.Variables['Validade'] := QuotedStr(sLocalParamValue.Trim);
        Datasets.FillPool(1);
        aDataset := Datasets.GetDataset;
        DMSecReports.frxCarteirinhas.DataSet := aDataset;
        ICosmosApp.IRemoteCon.ExecuteDQL(csReportCarteirinhaAluno, RepServerParams.Data, aDataset);
       end;
     rsRelacaoGeralAlunos:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBDatasInstalacoes.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportRelacaoGeralAlunos, RepServerParams.Data, aDataset) ;
      end;
     rsEntregaCirculares:
      begin
       //ICosmosApp.IRemoteCon.ExecuteDQL(csReportEntregaCirculares, RepServerParams.Data, DMSecData.CdsEntregaCirculares);
      end;
     rsFolhaPresenca, rsFolhaPresencaAtividade:
      begin
       DMSecData.CloseDataset(DMSecData.CdsFolhasPresenca);
       DMSecData.CdsFolhasPresenca.Params.Items[0].Value := RepServerParams.FindValue('codati');
       DMSecData.CdsFolhasPresenca.Params.Items[1].Value := RepServerParams.FindValue('tipord');
       DMSecData.CdsFolhasPresenca.Open;
       //ICosmosApp.IRemoteCon.ExecuteDQL(csReportFolhaPresenca, RepServerParams.Data, DMSecData.CdsFolhasPresenca);
      end;
     rsCadastradosDiscipulado:
      begin
       sLocalParamValue := LstParams.Values['SIGDIS'];
       FrProject.Variables['Discipulado'] := QuotedStr(sLocalParamValue);
       Datasets.FillPool(1);
       aDataset := Datasets.GetDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCadastradosDiscipulado, RepServerParams.Data, aDataset);
       DMSecReports.frxDBCadastradosDisc.DataSet := aDataset;
      end;
     rsTotaisAlunos:
      begin
       Datasets.FillPool(3);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBContarAlunosEE.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportContarAlunosEE, RepServerParams.Data, aDataset);

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBContarAlunosEI.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportContarAlunosEI, RepServerParams.Data, aDataset);

       aDataset := Datasets.GetNewDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportTotalAlunos, RepServerParams.Data, aDataset);
       FrProject.Variables['TOTAL'] := aDataset.Fields.FieldByName('Total').Value;
      end;
     rsHistoricoAluno:
      begin
       Datasets.FillPool(2);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBAlunosHistorico.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCadastradoCodigo, RepServerParams.Data, aDataset);
       DMSecData.DsrMasterSource.DataSet := aDataset;

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBHistoricoDiscipular.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportHistoricoCadastrado, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
       aDataset.MasterFields := 'CODCAD'; //do not localize!
      end;
     rsBoletimInformativo: Exit;
     rsEscalasAtividade:
      begin
       Datasets.FillPool(2);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBAtividadesCampo.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportAtividadesCampo, RepServerParams.Data, aDataset);
       DMSecData.DsrMasterSource.DataSet := aDataset;

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBEscalasAtividades.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportEscalasAtividades, null, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODATI'; //do not localize!
       aDataset.MasterFields := 'CODATI'; //do not localize!
      end;
     rsFolhaPresencaEI:
      begin
       DMSecData.Datasets.FillPool(1);
       aDataset := DMSecData.Datasets.GetNewDataset;
       DMSecReports.frxDBMembrosCirculo.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportMembrosCirculo, RepServerParams.Data, aDataset);
      end;
     rsCirculosEI:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       Datasets.FillPool(2);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBCirculos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCirculosEI, RepServerParams.Data, aDataset);
       DMSecData.DsrMasterSource.DataSet := aDataset;

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBMembrosCirculo.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportMembrosCirculos, null, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODGRU;NOMCAD'; //do not localize!
       aDataset.MasterFields := 'CODGRU'; //do not localize!
      end;
     rsTempoDiscipulado:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       sLocalParamValue := LstParams.Values['SIGDIS'];
       FrProject.Variables['SIGDIS'] := QuotedStr(sLocalParamValue);

       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBTempoDiscipulado.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportTempoDiscipulado, RepServerParams.Data, aDataset);
      end;
     rsListaProfissoes:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       Datasets.FillPool(2);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBListaProfissoes.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportListaProfissoes, RepServerParams.Data, aDataset);
       DMSecData.DsrMasterSource.DataSet := aDataset;

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBCadastradosProfissoes.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCadastradosProfissoes, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODPRO'; //do not localize!
       aDataset.MasterFields := 'CODPRO'; //do not localize!
      end;
     rsListaFuncoes:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       Datasets.FillPool(2);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBListaFuncoes.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportListaFuncoes, RepServerParams.Data, aDataset);
       DMSecData.DsrMasterSource.DataSet := aDataset;

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBCadastradosFuncoes.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportCadastradosFuncoes, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODFUN'; //do not localize!
       aDataset.MasterFields := 'CODFUN'; //do not localize!
      end;
     rsContabilizarFrequencia:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       if RepServerParams.FindValue('ANO') <> null then
        FrProject.Variables['ANO'] := RepServerParams.FindValue('ANO');

       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBContabilizarFrequencia.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportFrequenciaAno, RepServerParams.Data, aDataset);
       aDataset.IndexFieldNames := self.RepLocalParams.FindValue('TIPORD');
      end;
     rsContabilizarFrequenciaDiscipulado:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       if RepServerParams.FindValue('ANO') <> null then
        FrProject.Variables['ANO'] := RepServerParams.FindValue('ANO');
       FrProject.Variables['SIGDIS'] := QuotedStr(LstParams.Values['SIGDIS']);

       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBContabilizarFrequenciaDisc.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportFrequenciaAnoDiscipulado, RepServerParams.Data, aDataset);
       aDataset.IndexFieldNames := self.RepLocalParams.FindValue('TIPORD');
      end;
     rsAniversariantesMes:
      begin
       if RepServerParams.FindValue('MES') <> null then
        begin
         sLocalParamName := 'NOMEMES';
         sLocalParamValue := TDataConverter.ToMonthName(RepServerParams.FindValue('MES'));
        end;

       RepLocalParams.WriteValue(sLocalParamName, sLocalParamValue, 1);
       FrProject.Variables[sLocalParamName] := sLocalParamValue;

       ICosmosApp.IRemoteCon.ExecuteDQL(csReportAniversariantesMes, RepServerParams.Data, DMSecData.CdsAniversariantes);
      end;
     rsFolhaPresencaMensal:
      begin
       //DMSecData.CloseDataset(DMSecData.CdsFolhaPresencaMensal);
       ICosmosApp.IRemoteCon.ExecuteDQL(csFolhaPresencaMensal, RepServerParams.Data, DMSecData.CdsFolhaPresencaMensal);
      end;
     rsSumarioEstatistico, rsSumarioEstatisticoRa:
       begin
        if RepLocalParams.FindValue('MES') <> null then
         FrProject.Variables['MES'] := QuotedStr(RepLocalParams.FindValue('MES'));

        if RepLocalParams.FindValue('ANO') <> null then
         FrProject.Variables['ANO'] := QuotedStr(RepLocalParams.FindValue('ANO'));

        Datasets.FillPool(1);
        aDataset := Datasets.GetNewDataset;
        DMSecReports.frxDBResumoEstatisticoLEC.DataSet := aDataset;

        case ReportId of
         rsSumarioEstatistico: //Todos os focos de todas as RA's
          begin
           ICosmosApp.IRemoteCon.ExecuteDQL(csResumoEstatistico, null, aDataset);
          end;
         rsSumarioEstatisticoRa: //Focos de uma RA/subregião específicos.
          begin
            sLocalParamValue := LstParams.Values['NOMREG'];
            FrProject.Variables['Regiao'] := sLocalParamValue.QuotedString;

            if RepServerParams.FindValue('CODPAI') <> null then
             ICosmosApp.IRemoteCon.ExecuteDQL(csResumoEstatisticoRa, RepServerParams.Data, aDataset)
            else
             begin
              aTempData := TCosmosData.Create(1);

              try
               aTempData.WriteValue('CODREG', RepServerParams.FindValue('CODREG'));
               ICosmosApp.IRemoteCon.ExecuteDQL(csResumoEstatisticoParent, aTempData.Data, aDataset)

              finally
               aTempData.Free;
              end;
             end;
          end;
        end;

//        ICosmosApp.IRemoteCon.ExecuteDQL(csReportSumarizaAtividades, RepServerParams.Data, DMSecData.CdsSumarizaAtividades);
       end;
     rsMalaDiretaPimaco6280, rsMalaDiretaPimaco6281:
      begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBMalaDireta.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csMalaDireta, RepServerParams.Data, aDataset);
       aDataset.IndexFieldNames := self.RepLocalParams.FindValue('TIPORD');
      end;
     rsFolhaPresencaConferencia: Exit;
     rsEnvelope220x115, rsEnvelope250x175: ICosmosApp.IRemoteCon.ExecuteDQL(csMalaDireta, RepServerParams.Data, DMSecData.CdsMalaDireta);
     rsFrequenciaPeriodo, rsFrequenciaPeriodoDiscipulado:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       //Primeiro, envia para o relatório um texto que indica o período a ser abarcado.
       sLocalParamValue := TDataConverter.ToString(RepServerParams.FindValue('MES_INICIAL'));
       sLocalParamValue := sLocalParamValue + '/' + TDataConverter.ToString(RepServerParams.FindValue('ANO_INICIAL'));
       FrProject.Variables['INICIO'] := sLocalParamValue.QuotedString;

       sLocalParamValue := TDataConverter.ToString(RepServerParams.FindValue('MES_FINAL'));
       sLocalParamValue := sLocalParamValue + '/' + TDataConverter.ToString(RepServerParams.FindValue('ANO_FINAL'));
       FrProject.Variables['TERMINO'] := sLocalParamValue.QuotedString;

       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;

       //Agora, executa a consulta remota.
       if ReportId = rsFrequenciaPeriodo then
        begin
         DMSecReports.frxDBContabilizarFrequencia.DataSet := aDataset;
         ICosmosApp.IRemoteCon.ExecuteDQL(csReportFrequenciaPeriodo, RepServerParams.Data, aDataset);
        end
       else
        begin
         sLocalParamValue := LstParams.Values['SIGDIS'];
         FrProject.Variables['SIGDIS'] := QuotedStr(sLocalParamValue);
         DMSecReports.frxDBContabilizarFrequenciaDisc.DataSet := aDataset;
         ICosmosApp.IRemoteCon.ExecuteDQL(csReportFrequenciaPeriodoDiscipulado, RepServerParams.Data, aDataset);
        end;
      end;
     rsEnderecosMembrosCirculos:
      begin
       sLocalParamValue := LstParams.Values['NOMDIS'];
       FrProject.Variables['NOMDIS'] := QuotedStr(sLocalParamValue);
       sLocalParamValue := LstParams.Values['NOMGRU'];
       FrProject.Variables['Circulo'] := QuotedStr(sLocalParamValue);

       Datasets.FillPool(3);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBListaAlunos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csListaMembrosCirculo, RepServerParams.Data, aDataset);

       DMSecData.DsrMasterSource.DataSet := aDataset;

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxEnderecoAluno.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csEnderecosMembrosCirculo, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
       aDataset.MasterFields := 'CODCAD'; //do not localize!

       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxMeiosContatosAluno.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csMeiosContatoMembrosCirculos, RepServerParams.Data, aDataset);
       aDataset.MasterSource := DMSecData.DsrMasterSource;
       aDataset.IndexFieldNames := 'CODCAD'; //do not localize!
       aDataset.MasterFields := 'CODCAD'; //do not localize!
      end;
     rsListaTarefasSimples, rsListaTarefasAgrupada:
      begin
       //Abre o arquivo XML de tarefas do usuário e converte-o para um DataPack.
       AFileName := ICosmosApp.IApplicationPaths.ReadTasksFilesPath;
       AFileName := AFileName +ICosmosApp.IRemoteCon.ConnectedUser + '.tasks'; //do not localize!

       if not FileExists(AFileName) then
        begin
          ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.ReportsCenter, TCosmosInfoMsg.CannotFindTaskFile);
          Abort;
        end;

       try
        Tasks := TTasks.Create(AFileName, ICosmosApp.IRemoteCon.ConnectedUser);
        Tasks.ConvertToDataPacket(DMSecData.CdsTarefas);

        if Assigned(Tasks) then
          FreeAndNil(Tasks);

        DMSecData.CdsTarefas.Filter := FiltrarTarefas;
        DMSecData.CdsTarefas.Filtered := True;

       except
        on E: Exception do
         begin
          if Assigned(Tasks) then
           FreeAndNil(Tasks);

          ICosmosApp.MainLog.RegisterError(E.Message);
          ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ReportsCenter, E.Message);
         end;
       end;
      end;
     rsFrequenciaTipoAtividade, rsFrequenciaCirculoEI:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       //Primeiro, envia para o relatório um texto que indica o período a ser abarcado.
       sLocalParamValue := TDataConverter.ToString(RepServerParams.FindValue('MES_INICIAL'));
       sLocalParamValue := sLocalParamValue + '/' + TDataConverter.ToString(RepServerParams.FindValue('ANO_INICIAL'));
       FrProject.Variables['INICIO'] := sLocalParamValue.QuotedString;

       sLocalParamValue := TDataConverter.ToString(RepServerParams.FindValue('MES_FINAL'));
       sLocalParamValue := sLocalParamValue + '/' + TDataConverter.ToString(RepServerParams.FindValue('ANO_FINAL'));
       FrProject.Variables['TERMINO'] := sLocalParamValue.QuotedString;

       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;

       //Agora, executa a consulta remota.
       if ReportId = rsFrequenciaTipoAtividade then
        begin
         ICosmosApp.IRemoteCon.ExecuteDQL(csReportFrequenciaAtividade, RepServerParams.Data, aDataset)
        end
       else
        begin
         DMSecReports.frxDBContabilizarFrequencia.DataSet := aDataset;
         ICosmosApp.IRemoteCon.ExecuteDQL(csReportFrequenciaAtividadesEI, RepServerParams.Data, aDataset)
        end;
      end;
     rsListaGeralAlunos, rsListaJovensTM, rsListaPesquisadores:
      begin
       sLocalParamValue := LstParams.Values['NOMFOC'];
       FrProject.Variables['SelectedFocus'] := QuotedStr(sLocalParamValue);
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBListaGeralAlunos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportListaGeralAlunos, RepServerParams.Data, aDataset);
      end;
     rsQuadroTotalizacaoRa:
      begin
       if RepLocalParams.FindValue('MES') <> null then
        FrProject.Variables['MES'] := QuotedStr(RepLocalParams.FindValue('MES'));

       if RepLocalParams.FindValue('ANO') <> null then
        FrProject.Variables['ANO'] := QuotedStr(RepLocalParams.FindValue('ANO'));

       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMSecReports.frxDBResumoEstatisticoRas.DataSet := aDataset;

       ICosmosApp.IRemoteCon.ExecuteDQL(csReportQuadroTotalizacaoRa, null, aDataset);
      end;
     rsQuadroTotalizacaoRaTM:
      begin
       //ICosmosApp.IRemoteCon.ExecuteDQL(csSubRegioes, RepServerParams.Data, DMSecData.CdsRegioesAdmin);
       //ICosmosApp.IRemoteCon.ExecuteDQL(csReportQuadroTotalizacaoRaTM, null, DMSecData.CdsQuadroTotalizacaoRa);
      end;
   end;

   //Se chegou aqui, os dados do relatório foram preparados com sucesso.
   Result := True;

 except
  on E: Exception do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ReportsCenter, TCosmosErrorMsg.FormatParams);
    ICosmosApp.MainLog.RegisterError(E.Message);
    raise;
   end;
 end;
end;

procedure TFrmReportCenter.PopupActionBar1Popup(Sender: TObject);
begin
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

function TFrmReportCenter.PrepareReport(const ReportId: TReportsFinanceiro): boolean;
var
sLocalParamName, sLocalParamValue: string;
AMessage: TMessageData;
AFileName: string;
Tasks: TTasks;
aTempData: TCosmosData;
aDataset: TClientDataset;
aValue: Variant;
begin
//Prepara os dados de um relatório do módulo financeiro.
 try
  if ExecutionMode = emExecuteCentral then //Somente executa os métodos abaixo nesse modo.
   begin
    //Formata os dados e escreve tudo nas duas estruturas de parâmetros em memória.
     FormatParamsValues;

    //Valida os valores existentes nos objetos de dados local e a enviar ao servidor.
     ValidateParams(RepServerParams);
     ValidateParams(RepLocalParams);
   end;

 except
   on E: Exception do
    begin
       Result := False;
       AMessage := ICosmosApp.CreateMessageData(TCosmosErrorMsg.FormatParams, TCosmosTitles.ReportParams, mtpError);
       AMessage.SetMessageInfo(miInnerMessage, E.Message);
       AMessage.SetMessageInfo(miCustomInfo, self.TrvReports.Selected.Text);
       ICosmosApp.DlgMessage.Execute(AMessage);
       ICosmosApp.MainLog.RegisterError(AMessage.XMLData);

       if Assigned(AMessage) then
        FreeAndNil(AMessage);
      raise;
    end;
 end;

 //Obtém os dados do relatório no servidor remoto.
 try
   DMFinData.Datasets.ClearAll;

   case ReportId of
     rfSumarioCaixas:
      begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMFinReports.frxDBSumarioCaixas.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csCaixasMesAno, RepServerParams.Data, aDataset);
      end;
   {rcInscritosConferencia:
    begin
     Datasets.FillPool(1);
     aDataset := Datasets.GetNewDataset;
     DMConfReports.frxDBListaInscritos.DataSet := aDataset;
     ICosmosApp.IRemoteCon.ExecuteDQL(csReportInscritosConferencia, RepServerParams.Data, aDataset);
    end;
    rcInscritosDesalojados:
     begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBListaInscritos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csReportInscritosDesalojados, RepServerParams.Data, aDataset);
     end;
    rcFolhasQuartos:
     begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBFolhasQuartos.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csFolhasQuartos, RepServerParams.Data, aDataset);
     end;
    rcProgramacao:
     begin
       Datasets.FillPool(1);
       aDataset := Datasets.GetNewDataset;
       DMConfReports.frxDBProgramacao.DataSet := aDataset;
       ICosmosApp.IRemoteCon.ExecuteDQL(csProgramacaoConferencia, RepServerParams.Data, aDataset);
     end;}

   end;

   //Se chegou aqui, os dados do relatório foram preparados com sucesso.
   Result := True;

 except
  on E: Exception do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ReportsCenter, TCosmosErrorMsg.FormatParams);
    ICosmosApp.MainLog.RegisterError(E.Message);
    raise;
   end;
 end;
end;

procedure TFrmReportCenter.ListParamsValues;
var
I: integer;
FieldName: string;
AValue: variant;
begin
 //Preenche a grade com os valores dos parâmetros armazenados em memória.
 for I := 0 to Pred(LstParams.RowCount) do
  begin
   FieldName := LstParams.Keys[I];
   AValue := RepServerParams.FindValue(FieldName);
   if AValue <> null then
    LstParams.Values[FieldName] := AValue;
  end;
end;

function TFrmReportCenter.FiltrarTarefas: string;
begin
{Monta um filtro a ser usado nos relatórios de tarefas. Atenção! Não alterar
 as strings abaixo.}
 if RepLocalParams.FindValue('INDABE') = 'N' then
  Result := '(STATUS <> ' + QuotedStr('Aberta') + ') and ';

 if (RepLocalParams.FindValue('INDCON') = 'N') then
  Result := Result + '(STATUS <> ' + QuotedStr('Concluída') + ') and ';

 if (RepLocalParams.FindValue('INDCAN') = 'N') then
  Result := Result + '(STATUS <> ' + QuotedStr('Cancelada') + ') and ';

 if (RepLocalParams.FindValue('INDSUS') = 'N') then
  Result := Result + '(STATUS <> ' + QuotedStr('Suspensa') + ')     ';

 Delete(Result, Length(Result) - 4, 5);
end;

function TFrmReportCenter.FindParamNode(
  const ReportId: integer; ParamName: string): IXMLReportParam;
var
I: integer;
IReport: IXMLReport;
IReportParams: IXMLReportParams;
begin
 Result := nil;
 IReport := self.FindReportNode(ReportId);

 if IReport <> nil then
  begin
   IReportParams := IReport.Params;

   for I := 0 to Pred(IReportParams.Count) do
     begin
      if IReportParams.Param[I].ParamName = ParamName then
       begin
         Result := IReportParams.Param[I];
         Break;
       end;
     end;
  end;
end;

function TFrmReportCenter.FindReportNode(
  const ReportId: integer): IXMLReport;
var
I: integer;
begin
 //Encontra um relatório a partir do seu nome completo.

 for I := 0 to Pred(IReports.Count) do
   begin
     Result := IReports.Report[I];
     case ICosmosApp.CosmosModule of
      cmSecretarias:
        begin
         if (Result.ReportInfo.Info.ReportId = ReportId) and (Result.ReportInfo.Info.CosmosModule = 'cmSecretarias') then //do not localize!
          break
        end;
      cmConferencias:
        begin
         if (Result.ReportInfo.Info.ReportId = ReportId) and (Result.ReportInfo.Info.CosmosModule = 'cmConferencias') then //do not localize!
          break
        end;
      cmFinanceiro:
        begin
         if (Result.ReportInfo.Info.ReportId = ReportId) and (Result.ReportInfo.Info.CosmosModule = 'cmFinanceiro') then //do not localize!
          break
        end;
      cmUsuarios:
        begin
         if (Result.ReportInfo.Info.ReportId = ReportId) and (Result.ReportInfo.Info.CosmosModule = 'cmUsuarios') then //do not localize!
          break
        end
      else
        Result := nil;
     end
   end;
end;

procedure TFrmReportCenter.FormCreate(Sender: TObject);
begin
 //RvProject.ProjectFile := '';
 FRProject.FileName := '';

 FICosmosApp := Application.MainForm as ICosmosApplication;
 self.CustomHint := ICosmosApp.CustomHintObj;
 {Carrega o arquivo de informações dos relatórios. Se este arquivo não puder ser
 carregado, a Central de Relatórios não irá funcionar corretamente.}
 try
   LoadReportsInfo;

 finally
   if IReports = nil then
     begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, TCosmosErrorMsg.ReportInfoFile, mtError);
      ICosmosApp.MainLog.RegisterError(TCosmosErrorMsg.ReportInfoFile + #13 + sReportsFile);
      Abort;
     end;
 end;

 //Obtém o caminho do arquivo onde os valores dos parâmetros dos relatórios são salvos...
 FParamsFile := ICosmosApp.IApplicationPaths.ReadUserAppDataPath + TCosmosFiles.ReportsParamsValues;

 FRepServerParams := TCosmosData.Create(20);
 FRepLocalParams := TCosmosData.Create(20);

 case ICosmosApp.CosmosModule of
   cmFocos:
    begin
     if not Assigned(DMFocosData) then
      DMFocosData := TDMFocosData.Create(self);

     if not Assigned(DMFocosReports) then
      DMFocosReports := TDMFocosReports.Create(self);
    end;
   cmSecretarias:
    begin
     if not Assigned(DMSecData) then
      DMSecData := TDMSecData.Create(self);

     if not Assigned(DMSecReports) then
      DMSecReports := TDMSecReports.Create(self);
    end;
   cmFinanceiro:
    begin
     if not Assigned(DMFinData) then
      DMFinData := TDMFinData.Create(self);

     if not Assigned(DMFinReports) then
      DMFinReports := TDMFinReports.Create(self);
    end;
   cmConferencias:
    begin
     if not Assigned(DMConfData) then
      DMConfData := TDMConfData.Create(self);

     if not Assigned(DMConfReports) then
      DMConfReports := TDMConfReports.Create(self);
    end;
   cmUsuarios: ;
 end;
end;

procedure TFrmReportCenter.FormDestroy(Sender: TObject);
begin
 if Assigned(FRepServerParams) then FRepServerParams.Free;
 if Assigned(FRepLocalParams) then  FRepLocalParams.Free;
end;

procedure TFrmReportCenter.FRProjectProgress(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
 ICosmosApp.Components.ProgressBar.Position := Progress;
end;

procedure TFrmReportCenter.FRProjectProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
 ICosmosApp.Components.ProgressBar.Visible := True;
end;

procedure TFrmReportCenter.FRProjectProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
 ICosmosApp.Components.ProgressBar.Visible := False;
end;

function TFrmReportCenter.GetActiveReport: PReport;
begin
 if TrvReports.Selected <> nil then
  Result := PReport(TrvReports.Selected.Data)
 else
 Result := nil;
end;

function TFrmReportCenter.GetDatasets: TDatasetsPool;
begin
 case ICosmosApp.CosmosModule of
   cmFocos: ;
   cmSecretarias: Result := DMSecData.Datasets;
   cmFinanceiro: ;
   cmConferencias: Result := DMConfData.Datasets;
   cmUsuarios: ;
 end;
end;

function TFrmReportCenter.GetNodeType(Node: TTreeNode): TReportType;
var
PRep: PReport;
begin
 if Node <> nil then
  begin
   PRep := Node.Data;
   Result := PRep.tiprep;
  end
 else
  Result := rtNone;
end;

function TFrmReportCenter.GetParamHelp(const ReportId: integer; ParamName: string): string;
var
IReport: IXMLReport;
IReportParams: IXMLReportParams;
Index: integer;
begin
//Obtém o hint de ajuda para um determinado parâmetro de relatório.
 Result := '';
 IReport := self.FindReportNode(ReportId);
 if IReport = nil then
   Exit;

 IReportParams := IReport.Params;

 for Index := 0 to Pred(IReportParams.Count) do
   begin
     if IReportParams.Param[Index].ParamName = ParamName then
      begin
        Result := IReportParams.Param[Index].HelpHint;
        Break;
      end;
   end;
end;

function TFrmReportCenter.GetReportEnabled: boolean;
var
PRep: PReport;
begin
 if TrvReports.Selected <> nil then
  begin
   PRep := TrvReports.Selected.Data;
   Result := PRep.Enabled;
  end
 else
  Result := False;
end;

function TFrmReportCenter.GetReportFile: string;
begin
// Result := RvProject.ProjectFile;
end;

function TFrmReportCenter.GetSelectedItem: TReportType;
var
PRep: PReport;
begin
 if TrvReports.Selected <> nil then
  begin
   PRep := TrvReports.Selected.Data;
   Result := PRep.tiprep;
  end
 else
  Result := rtNone;
end;

procedure TFrmReportCenter.ListExternalCategories(List: TStringList);
var
ADataset: TClientDataset;
IRemoteCon: ICosmosRemoteConnection;
begin
 //Lista as categorias dos relatórios externos.
 ADataset := TClientDataset.Create(self);
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 try
   RepServerParams.ClearData;
   case ICosmosApp.CosmosModule of
     cmFocos: RepServerParams.Add('INDMOD', 'INDFOC');
     cmSecretarias: RepServerParams.Add('INDMOD', 'INDSEC');
     cmFinanceiro: RepServerParams.Add('INDMOD', 'INDFIN');
     cmConferencias: RepServerParams.Add('INDMOD', 'INDCON');
     cmUsuarios: RepServerParams.Add('INDMOD', 'INDUSU');
   end;

   RepServerParams.Add('INDATI', QuotedStr('S'));

   IRemoteCon.ExecuteDQL(csExternalReportsCategories, RepServerParams.Data, ADataset);

   if ADataset.Active then
    begin
     while not ADataset.Eof do
      begin
       List.Append(ADataset.Fields.FieldByName('tagrel').AsString);
       ADataset.Next;
      end;
    end;

 finally
  if Assigned(IRemoteCon) then  IRemoteCon := nil;
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFrmReportCenter.ListExternalReports(Module: TCosmosModules);
var
RootNode, Node, RepNode: TTreeNode;
LstCategories: TStringList;
PRep: PReport;
Cds: TClientDataset;
I: integer;
AFilter: string;
IRemoteCon: ICosmosRemoteConnection;
begin
//Não existem relatório externos para os módulos abaixo...
 case Module of
   cmUsuarios, cmSincMestre, cmSincEscravo: Exit;
 end;

 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

//Lista os relatórios externos
 New(PRep);
 PRep.nomrep := TCosmosReportsNames.ExternalReports;
 PRep.desrep := '';
 PRep.nomarq := '';
 PRep.tiprep := rtCategory;

 RootNode := TrvReports.Items.AddObject(nil, PRep.nomrep, PRep);
 RootNode.ImageIndex := 0;
 RootNode.SelectedIndex := RootNode.ImageIndex;

 LstCategories := TStringList.Create;

 ListExternalCategories(LstCategories);

 Cds := TClientDataset.Create(self);
 try
  Cds := IRemoteCon.OpenBufferedData(TCosmosFiles.BufExternalReports);
  Cds.IndexFieldNames := 'nomrel';

  //Exibe apenas aqueles relacionados com o módulo corrente do Cosmos.
  case Module of
   cmFocos: AFilter := Format('INDFOC = %s', [QuotedStr('S')]);
   cmSecretarias: AFilter := Format('INDSEC = %s', [QuotedStr('S')]);
   cmFinanceiro: AFilter := Format('INDFIN = %s', [QuotedStr('S')]);
   cmConferencias: AFilter := Format('INDCON = %s', [QuotedStr('S')]);
   else
    Abort;
  end;

  for I := 0 to pred(LstCategories.Count) do
   begin
    New(PRep);
    PRep.nomrep := LstCategories.Strings[I];
    PRep.desrep := '';
    PRep.nomarq := '';
    PRep.tiprep := rtCategory;

    Node := TrvReports.Items.AddChildObject(RootNode, PRep.nomrep, PRep);
    Node.ImageIndex := 0;
    Node.SelectedIndex := Node.ImageIndex;

    with Cds do
     begin
      Filter := AFilter + ' AND ' + Format('tagrel = %s', [QuotedStr(LstCategories.Strings[I])]);
      Filtered := True;

      while not Eof do
       begin
        New(PRep);
        Prep.nomrep := Fields.FieldByName('nomrel').AsString;
        PRep.desrep := Fields.FieldByName('desrel').AsString;
        PRep.nomarq := Fields.FieldByName('nomarq').AsString;
        PRep.tiprep := rtExternalReport;
        PRep.Enabled := Fields.FieldByName('indati').AsString = 'S';

        RepNode := TrvReports.Items.AddChildObject(Node,Prep.nomrep, PRep);
        if PRep.Enabled then
         RepNode.ImageIndex := 3
        else
         RepNode.ImageIndex := 4;

        RepNode.SelectedIndex := RepNode.ImageIndex;
        Next;
       end;
     end;
  end;


 finally
  if Assigned(IRemoteCon) then IRemoteCon := nil;
  if Assigned(Cds) then
   begin
    if Cds.Active then Cds.Close;
    FreeAndNil(Cds);
   end;
 end;
end;

procedure TFrmReportCenter.ListParamsValues(AData: TCosmosData);
var
I, ARow: integer;
FieldName: string;
AValue: variant;
begin
 {Preenche a grade com os valores dos parâmetros do objeto passado em parâmetro
  do método.}
 for I := 0 to Pred(AData.DataCount) do
   begin
    FieldName := AData.FindFieldName(I);
    if FieldName <> '' then
      begin
        if LstParams.FindRow(FieldName, ARow) then
         begin
           AValue := AData.FindValue(FieldName);
           if AValue <> null then
            LstParams.Values[FieldName] := AValue;
         end;
      end;
   end;
end;

procedure TFrmReportCenter.ListReports;
var
LstCategories, LstReports: TStringList;
Node, RepNode: TTreeNode;
I, J: integer;
PRep: PReport;
sCategory, sReportsFolder: string;
begin
 //RVProject.ProjectFile := RaveReportFile;
 sReportsFolder := ICosmosApp.IApplicationPaths.ReadReportsFolder(ICosmosApp.CosmosModule);

 LstCategories := TStringList.Create;
 LstReports := TStringList.Create;

 //Obtém as categorias...
 for I := 0 to Pred(IReports.Count) do
  begin
   sCategory := IReports.Report[I].ReportInfo.Info.ReportRoot;
   if not IReports.Report[I].ReportInfo.Info.CosmosModule.Contains(ICosmosApp.CosmosModuleShortName) then
     Continue;

   if LstCategories.IndexOf(sCategory) < 0 then
     LstCategories.Append(sCategory);
  end;

 LstCategories.Sorted := True;

 for I := 0 to pred(LstCategories.Count) do
  begin
   New(PRep);
   PRep.ReportId := 0;//zero é reservado para categorias de relatórios.
   PRep.nomrep := LstCategories.Strings[I];
   PRep.desrep := '';
   PRep.nomarq := '';
   PRep.tiprep := rtCategory;

   Node := TrvReports.Items.AddObject(nil, PRep.nomrep, PRep);
   Node.ImageIndex := 0;
   Node.SelectedIndex := Node.ImageIndex;

   //Obtém os relatórios de uma determinada categoria...
   for j := 0 to pred(IReports.Count) do
    begin
     if IReports.Report[j].ReportInfo.Info.ReportRoot = LstCategories.Strings[I] then
      begin
        if not IReports.Report[j].ReportInfo.Info.CosmosModule.Contains(ICosmosApp.CosmosModuleShortName) then
          Continue;

        New(PRep);
        PRep.ReportId := IReports.Report[j].ReportInfo.Info.ReportId;
        Prep.nomrep := IReports.Report[j].ReportInfo.Info.ReportName;
        PRep.desrep := IReports.Report[j].ReportInfo.Info.Description;
        PRep.nomarq := IReports.Report[j].ReportInfo.Info.ReportFile;
        PRep.tiprep := rtReport;

        if IReports.Report[j].ReportInfo.Info.ReportTool = 'Rave' then //do not localize!
         begin
          PRep.ReportTool := rtRave;
          PRep.nomarq := IReports.Report[j].ReportInfo.Info.ReportFile;
         end
        else
         begin
          PRep.ReportTool := rtFastReport;
          PRep.nomarq := sReportsFolder + IReports.Report[j].ReportInfo.Info.ReportFile;
         end;

        PRep.Enabled := Boolean(IReports.Report[j].ReportInfo.Info.Enabled);
        RepNode := TrvReports.Items.AddChildObject(Node,Prep.nomrep, PRep);
        RepNode.ImageIndex := 1;
        RepNode.SelectedIndex := RepNode.ImageIndex;
        if not PRep.Enabled then
          RepNode.ImageIndex := 2;
        RepNode.SelectedIndex := RepNode.ImageIndex;
      end;
    end;
  end;

 //Agora lista os relatórios externos...
 if ExecutionMode <> emExecuteReport then
  ListExternalReports(ICosmosApp.CosmosModule);

 TrvReports.AlphaSort(True);
 TrvReports.FullExpand;
end;

procedure TFrmReportCenter.LoadReportsInfo;
const
  iBufSize = 128;
var
  ACommand: TDBXCommand;
  AStream: TStream;
  AReportsInfo : TStringStream;
  buf: PByte;
  iRead: integer;
begin
  {Busca o arquivo XML no servidor remoto que possui informações sobre todos os
   relatórios disponíveis para esse módulo do Cosmos. Nesse arquivo também estão
   presentes informações sobre os parâmetros de execução de cada relatório.}

   {Nesse método os dados do arquivo XML são passados pelo servidor remoto como
    um stream de dados. Os dados desse stream são copiados para outro stream
    legível para um objeto do tipo TXMLDocument.}
  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TDMCosmosApplicationServer.GetReportsInfo';
    ACommand.Prepare;
    ACommand.ExecuteUpdate;
    AStream := ACommand.Parameters[0].Value.GetStream(True);

    {copia os dados para a memória. Necessário copiar de bloco em bloco pelo
     fato de datasnap somente suportar a transmissão de streams de 64k}
    if AStream <> nil then
     begin
      GetMem(buf, iBufSize);
      AReportsInfo := TStringStream.Create;

      repeat
        iRead := AStream.Read(Pointer(buf)^, iBufSize);

        if iRead > 0 then AReportsInfo.WriteBuffer( Pointer(buf)^, iRead);
        if iRead < iBufSize then break;

      until iRead < iBufSize;
     end;
     //fim da cópia

    //Carregamento do TStringStream em um objeto do tipo TXMLDocument.
    if (AReportsInfo <> nil) and (AReportsInfo.Size > 0) then
     begin
       if AReportsInfo <> nil then
        begin
         XMLReportsInfo.LoadFromStream(AReportsInfo, xetUTF_8);
         FIReports := GetReports(XMLReportsInfo.DocumentElement.OwnerDocument);
         AReportsInfo.Free;
        end;
     end;

    ACommand.Free;

  except
    on E: Exception do
    begin
      if Assigned(AStream) then FreeAndNil(AStream);
      if Assigned(AReportsInfo) then FreeAndNil(AReportsInfo);
      if Assigned(ACommand) then FreeAndNil(ACommand);
      ICosmosApp.DlgMessage.Execute(E.Message);
    end;
  end;
end;

procedure TFrmReportCenter.LstParamsEditButtonClick(Sender: TObject);
var
Param: string;
AData: TCosmosData;
IReportParam: IXMLReportParam;
begin
 Param :=  LstParams.Keys[LstParams.Row];

 if Param = 'NOMFOC' then
  begin
   AData := TCosmosFocosDialogs.SelecionarFocos;
   if AData <> nil then
    begin
     CopyParamsValues(AData);
     ListParamsValues(AData);
    end;
  end
 else
 if (Param = 'CODGRU') or (Param = 'NOMGRU') then
  begin
   AData := TCosmosEscolaInternaDialogs.SelecionarCirculoEI;
   if AData <> nil then
    begin
     CopyParamsValues(AData);
     ListParamsValues(AData);
    end;
  end
 else
 if (Param = 'CODATI') or (Param = 'NOMATI') or (Param = 'DESTIPATI') then
  begin
   AData := TCosmosAtividadesDialogs.SelecionarAtividades;
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
      CopyParamsValues('CODATI2', 'CODATI', AData);
     end;
  end
 else
 if Param = 'NOMATI-LEC' then
  begin
   AData := TCosmosAtividadesDialogs.SelecionarAtividadesCampo(ctLectorium);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
      CopyParamsValues('NOMATI-LEC', 'DESTIPATI', AData);
      ListParamsValues('NOMATI-LEC', 'DESTIPATI', AData);
     end;
  end
 else
 if (Param = 'MATCAD') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, False);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
if (Param = 'MATCAD-LEC') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, scTodos, False);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
      CopyParamsValues('MATCAD-LEC', 'MATCAD', AData);
      ListParamsValues('MATCAD-LEC', 'MATCAD', AData);
     end;
  end
 else
 if (Param = 'MATCAD-TM') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctTM, scTodos, False);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
      CopyParamsValues('MATCAD-TM', 'MATCAD', AData);
      ListParamsValues('MATCAD-TM', 'MATCAD', AData);
     end;
  end
 else
 if (Param = 'MATCAD-TMB') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctTMB, scTodos, False);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
      CopyParamsValues('MATCAD-TMB', 'MATCAD', AData);
      ListParamsValues('MATCAD-TMB', 'MATCAD', AData);
     end;
  end
 else
 if (Param = 'MATCAD-TP') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctTP, scTodos, False);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
      CopyParamsValues('MATCAD-TP', 'MATCAD', AData);
      ListParamsValues('MATCAD-TP', 'MATCAD', AData);
     end;
  end
 else
 if (Param = 'MATRICULAS') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarMatriculas(ctLectorium);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
 if (Param = 'MATRICULAS-TMB') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarMatriculas(ctTMB);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
 if (Param = 'CODCON') or (Param = 'NOMCON') then
  begin
   AData := TCosmosConferenciasDialogs.SelecionarConferencia(ctAll, False);
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
 if (Param = 'CODREG') or (Param = 'NOMREG') then
  begin
   AData := TCosmosFocosDialogs.SelecionarRegioesAdministrativas;
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
 if (Param = 'CODINS') or (Param = 'NUMINS') then
  begin
   AData := TCosmosConferenciasDialogs.SelecionarInscrito;
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
 if (Param = 'CODITE') or  (Param = 'DESFLA') or (Param = 'DESIMP') then
  begin
   AData := TCosmosConferenciasDialogs.SelecionarInformacaoInscrito;
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
 if (Param = 'CODALO') or (Param = 'NOMALO') then
  begin
   AData := TCosmosConferenciasDialogs.SelecionarAlojamento;
   if AData <> nil then
     begin
      CopyParamsValues(AData);
      ListParamsValues(AData);
     end;
  end
 else
  begin
   IReportParam := self.FindParamNode(ActiveReport.ReportId, Param);
   if IReportParam = nil then
    Exit;

   try
     if IReportParam.ParamType = 2 then //Campo do tipo TDate.
       begin
        AData := TCosmosUtilitiesDialogs.SelecionarData;
        if AData <> nil then
          begin
           CopyParamsValues(Param, 'SELDAT', AData);
           ListParamsValues(Param, 'SELDAT', AData);
          end;
       end;

   finally
    if IReportParam <> nil then
      IReportParam := nil;
   end;
  end;
end;

procedure TFrmReportCenter.LstParamsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
 self.LblParamHint.Caption := self.GetParamHelp(ActiveReport.ReportId, LstParams.Cells[0, ARow]);
end;

procedure TFrmReportCenter.OpenExternalReport(const FileName: string;
  Mode: TOpenMode);
begin
//Abre um relatório externo
 if not FileExists(FileName) then
  begin
    ICosmosApp.DlgMessage.Execute(TCosmosTitles.ReportsCenter, Format(TCosmosErrorMsg.ExternalReportNotFound,
      [TrvReports.Selected.Text, FileName]), mtError);
    Exit;
  end;

 case Mode of
   omOpen:  TWinShell.ExecuteFile(FileName, '', '', 0);
   omPrint: TWinShell.PrintFile(FileName);
 end;
end;

procedure TFrmReportCenter.PreviewReport(const ReportName: string);
begin
//Exibe um preview de um relatório sem mostrar esta caixa de diálogo
 ListReports;
 SelectReportNode(ReportName);
 if LstParams.Keys[1] = '' then
  ActPreview.Execute;
end;

procedure TFrmReportCenter.PrintBoletimInfo(const DataInicial,
  DataFinal: TDateTime);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsBoletimInformativo));
 ShowModal;
end;

procedure TFrmReportCenter.PrintCarteiraAluno(const matcad: string);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsCarteirinhaAluno));
 LstParams.Values[LstParams.Keys[1]] := QuotedStr(matcad);
 LstParams.Values[LstParams.Keys[2]] := DateToStr(ICosmosApp.IRemoteCon.ServerDateTime);
 LstParams.Values[LstParams.Keys[4]] := IntToStr(YearOf(ICosmosApp.IRemoteCon.ServerDateTime));
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintCarteirasAlunos(const matcad: string);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsCarteirinhaAluno));
 LstParams.Values[LstParams.Keys[1]] := matcad;
 LstParams.Values[LstParams.Keys[2]] := DateToStr(ICosmosApp.IRemoteCon.ServerDateTime);
 LstParams.Values[LstParams.Keys[4]] := IntToStr(YearOf(ICosmosApp.IRemoteCon.ServerDateTime));
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintCrachaInscrito(const codins: integer);
begin
//Imprime o crachá de um inscrito em conferência.
 ExecutionMode := emExecuteReport;
 ListReports;
 SelectReportNode(Ord(TReportsConferencias.rcCrachaInscrito));
 LstParams.Values[LstParams.Keys[1]] := codins.ToString;

 RepServerParams.WriteValue('CODINS', codins);
 if LstParams.Keys[1] <> '' then
   ActPreview.Execute;
end;

procedure TFrmReportCenter.SetLocalParams;
var
  sLocalParamName, sLocalParamValue: string;
  AFieldName: Variant;
  I: Integer;
begin
  //Atribui os valores dos parâmetros locais para os parâmetros do relatório.
  for I := 0 to Pred(RepLocalParams.DataCount) do
  begin
    AFieldName := RepLocalParams.FindFieldName(I);
    if ((AFieldName <> null) and (AFieldName <> unassigned)) then
    begin
      sLocalParamName := AFieldName;
      if RepLocalParams.FindValue(sLocalParamName) <> null then
      begin
        sLocalParamValue := RepLocalParams.FindValue(sLocalParamName);
        if ActiveReport.reporttool = rtRave then
          //Rave
         // RvProject.SetParam(sLocalParamName, sLocalParamValue)
        else
        //Fast Reports
        begin
          if VarIsStr(RepLocalParams.FindValue(sLocalParamName)) then
            FrProject.Variables[sLocalParamName] := QuotedStr(RepLocalParams.FindValue(sLocalParamName))
          else
            FrProject.Variables[sLocalParamName] := RepLocalParams.FindValue(sLocalParamName);
        end;
      end;
    end;
  end;
end;

procedure TFrmReportCenter.PrintFichaAluno(const matcad: string);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsFichaAluno));
 LstParams.Values[LstParams.Keys[1]] := matcad;
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintFichaJovemTM(const matcad: string);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsFichaJovemTM));
 LstParams.Values[LstParams.Keys[1]] := matcad;
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintFichaPesquisador(const matcad: string);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsFichaPesquisador));
 LstParams.Values[LstParams.Keys[1]] := matcad;
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintFichasAlunos(const matriculas: string);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsFichasAlunos));
 LstParams.Values[LstParams.Keys[1]] := matriculas;
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintFolhaPresencaEI(Data: TCosmosData);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsFolhaPresencaEI));

 LstParams.Values[LstParams.Keys[1]] := Data.FindValue('NOMGRU');
 LstParams.Values[LstParams.Keys[2]] := Data.FindValue('SIGDIS');
 LstParams.Values[LstParams.Keys[3]] := Data.FindValue('NOMFOC');
 LstParams.Values[LstParams.Keys[4]] := Data.FindValue('ANO');

 RepServerParams.WriteValue('CODGRU', Data.FindValue('CODGRU'));
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintFolhaPresenca(Data: TCosmosData; Tipo: TTipoFolhaPresenca);
begin
 ListReports;

 case Tipo of
   tfSimples: SelectReportNode(Ord(TReportsSecretarias.rsFolhaPresenca));
   tfDupla:  SelectReportNode(Ord(TReportsSecretarias.rsFolhaPresencaAtividade));
 end;

 LstParams.Values[LstParams.Keys[1]] := Data.FindValue('DESTIPATI');
 LstParams.Values[LstParams.Keys[2]] := Data.FindValue('DATATI');
 LstParams.Values[LstParams.Keys[3]] := Data.FindValue('HORATI');
 LstParams.Values[LstParams.Keys[4]] := Data.FindValue('CAMPRO');
 LstParams.Values[LstParams.Keys[5]] := Data.FindValue('SIGFOC');
 LstParams.Values[LstParams.Keys[6]] := Data.FindValue('TIPORD');

 RepServerParams.WriteValue('CODATI', Data.FindValue('CODATI'));
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintHistoric(AData: TCosmosData);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsHistoricoAluno));
 LstParams.Values[LstParams.Keys[1]] := AData.FindValue('MATCAD');
 LstParams.Values[LstParams.Keys[2]] := AData.FindValue('NOMCAD');

 RepServerParams.WriteValue('CODCAD', AData.FindValue('CODCAD'));
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintListagemByDiscipulado(
  const Discipulado: string);
begin
 ListReports;
 SelectReportNode(Ord(TReportsSecretarias.rsCadastradosDiscipulado));
 LstParams.Values[LstParams.Keys[1]] := ICosmosApp.ActiveFocus.FocusName;
 LstParams.Values[LstParams.Keys[2]] := Discipulado;
 LstParams.Values[LstParams.Keys[3]] := 'Sim';
 LstParams.Values[LstParams.Keys[4]] := 'Nome';
 BuildReport(pmPreview);
end;

procedure TFrmReportCenter.PrintReport(const ReportName: string);
begin
//Imprime um relatório sem mostrar esta caixa de diálogo
 ListReports;
 SelectReportNode(ReportName);
 if LstParams.Keys[1] = '' then
  ActPrint.Execute;
 ShowModal;
end;

procedure TFrmReportCenter.ReadParamsFromFile(const ReportName: string);
var
I, Index: integer;
AFile: TIniFilePersistence;
IReport: IXMLReport;
IReportParams: IXMLReportParams;
AParamName: string;
AParamValue: variant;
AMessage: TMessageData;
begin
 {Lê os valores dos parâmetros usados na última vez que o relatório for gerado.}
 AFile := TIniFilePersistence.Create(ParamsFile, False);

 try
  if AFile.KeyExists(ReportName) then
   begin
    IReport := self.FindReportNode(ActiveReport.ReportId);
    if IReport = nil then
      Exit;
    IReportParams := IReport.Params;

    for I := 0 to Pred(IReportParams.Count) do
      begin
        AParamName := IReportParams.Param[I].ParamName;
        {Somente traz o valor da última geração, escreve o valor na grade e nos
         objetos de memória caso não exista um valor padrão configurado
         no arquivo de parâmetros.}
        if IReportParams.Param[I].DefaultValue = '' then
         begin
           case IReportParams.Param[I].ParamType of
            0: AParamValue := AFile.ReadInteger(ReportName, AParamName, 0);
            1: AParamValue := AFile.ReadString(ReportName, AParamName, '');
            2: AParamValue := FormatDateTime('dd/mm/yyyy', AFile.ReadDate(ReportName, AParamName, Now));
            3: AParamValue := AFile.ReadString(ReportName, AParamName, 'Sim');
            4: AParamValue := AFile.ReadString(ReportName, AParamName, '');
            5: AParamValue := AFile.ReadString(ReportName, AParamName, '');
           end;

           if (IReportParams.Param[I].IsVisible = 1) then
            LstParams.Values[AParamName] := AParamValue;

           //Atualiza a estrutura de parâmetros remota, se necessário.
           Index := RepServerParams.FindIndex(AParamName);
           if Index >= 0 then
            RepServerParams.WriteValue(AParamName, AParamValue, Index);

           //Atualiza a estrutura de parâmetros local, se necessário.
           Index := RepLocalParams.FindIndex(AParamName);
           if Index >= 0 then
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
         end;
      end;
   end;

   if Assigned(AFile) then
    AFile.Free;

 except
  on E: Exception do
   begin
    AMessage := TMessageData.Create;
    AMessage.MessageTitle := TCosmosTitles.ReportParams;
    AMessage.MessageText := TCosmosErrorMsg.ReadReportParams;
    AMessage.MessageType := mtpError;
    AMessage.SetMessageInfo(miInnerMessage, E.Message);
    ICosmosApp.DlgMessage.Execute(AMessage);

    if Assigned(AMessage) then
     AMessage.Free;

    if Assigned(AFile) then
     AFile.Free;
   end;
 end;
end;

procedure TFrmReportCenter.SelectReportNode(const ReportName: string);
var
I: integer;
Node: TTreeNode;
begin
//Seleciona um relatório na árvore a partir do seu nome completo.
 for I := 0 to Pred(TrvReports.Items.Count) do
  begin
   if (Node <> nil) and (GetNodeType(Node) = rtReport) then
    if lowercase(Node.Text) = lowercase(ReportName) then
     begin
      TrvReports.Selected := Node;
      Break;
     end;
  end;
end;

function TFrmReportCenter.GetParamDefaultValue(const AParamValue: string): variant;
var
ADate: TDateTime;
Y, M, D: Word;
begin
 {Obtém os valores de parâmetros com tags pré-definidas.}
 Result := AParamValue;

 //Parâmetro representando o foco corrente...
 if ICosmosApp.ActiveFocus <> nil then
  begin
   if AParamValue = 'CODFOC-CURRENT' then //do not localize!
    Result := ICosmosApp.ActiveFocus.FocusID
   else
    if AParamValue = 'NOMFOC-CURRENT' then  //do not localize!
     Result := ICosmosApp.ActiveFocus.FocusName;
  end;
 //Parâmetro representando a conferência corrente...
 if Supports(Application.MainForm, ICosmosConference) then
  begin
   if (ICosmosApp.IConference <> nil) and (ICosmosApp.IConference.ActiveConference <> nil) then
    begin
     if AParamValue = 'CODCON-CURRENT' then //do not localize!
      Result := ICosmosApp.IConference.ActiveConference.ConferenceID
     else
      if AParamValue = 'NOMCON-CURRENT' then  //do not localize!
       Result := ICosmosApp.IConference.ActiveConference.ConferenceName;
    end
   else
    Result := '';
  end;

 if AParamValue = 'CURRENT-DATE' then //do not localize!
   Result := TDataConverter.ToFormatedDateTime(ICosmosApp.IRemoteCon.ServerDateTime, 'dd/mm/yyyy')
 else
 if AParamValue = 'CURRENT-YEAR' then //do not localize!
   begin
    ADate := ICosmosApp.IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    Result := IntToStr(Y);
   end
 else
 if AParamValue = 'CURRENT-MONTH' then //do not localize!
   begin
    ADate := ICosmosApp.IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    Result := IntToStr(M);
   end
 else
 if AParamValue = 'CURRENT-MONTHNAME' then  //do not localize!
   begin
    ADate := ICosmosApp.IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    Result := TDataConverter.ToMonthName(M)
   end
 else
 if AParamValue = 'FIRSTDAY-CURRENTMONTH' then  //do not localize!
   begin
    ADate := ICosmosApp.IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    Result := TDataConverter.ToFormatedDateTime(EncodeDate(Y,M,1));
   end
 else
 if AParamValue = 'LASTDAY-CURRENTMONTH' then //do not localize!
   begin
    ADate := ICosmosApp.IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    ADate := EndOfAMonth(Y, M);
    Result := TDataConverter.ToFormatedDateTime(ADate);
   end
 else
 if AParamValue = 'CURRENT-USER' then //do not localize!
   begin
    Result := ICosmosApp.IRemoteCon.CurrentUser.UserName;
   end
 else
 if AParamValue = 'MAIOR-IGUAL' then  //do not localize!
   begin
    Result := '>=';
   end
 else
 if AParamValue = 'MENOR-IGUAL' then  //do not localize!
   begin
    Result := '<=';
   end
end;

procedure TFrmReportCenter.SelectReportNode(const ReportId: integer);
var
Node: TTreeNode;
aReport: PReport;
begin
//Seleciona um relatório na árvore a partir do seu index.
 Node := TrvReports.Items.GetFirstNode;

 while Node <> nil do
  begin
   if GetNodeType(Node) = rtReport then
    begin
     aReport := Node.Data;
     if (aReport <> nil) and (aReport.ReportId = ReportId) then
      begin
       TrvReports.Selected := Node;
       Break;
      end;
    end;

    Node := Node.GetNext;
  end;
end;

procedure TFrmReportCenter.SetGlobalParams;
begin
 //Configura os parâmetros de projeto do arquivo de relatórios. Isto pode variar
 //de módulo a módulo do Cosmos, pois eles trabalham com arquivos diferentes.
 {RvProject.SetParam('AppName', ICosmosApp.CosmosModuleName);
 RvProject.SetParam('User_Name', ICosmosApp.IRemoteCon.CurrentUser.UserName);}

 case ICosmosApp.CosmosModule of
  cmSecretarias, cmConferencias, cmFinanceiro:
   begin
    //RvProject.SetParam('ActiveFocus', ICosmosApp.ActiveFocus.FocusName);
     //frxGlobalVariables['ActiveFocus'] := QuotedStr('First copy');
    FRProject.Variables['ActiveFocus'] := QuotedStr(ICosmosApp.ActiveFocus.FocusName);
    FRProject.Variables['AppName'] :=  QuotedStr(ICosmosApp.CosmosModuleName);
   end;
 end;
end;

procedure TFrmReportCenter.SetReportFile(const Value: string);
begin
{ if RVProject.ProjectFile <> Value then
   RVProject.ProjectFile := Value;}
end;

procedure TFrmReportCenter.ShowReportCenter;
begin
 ListReports;
 ShowModal;
end;

procedure TFrmReportCenter.TrvReportsChange(Sender: TObject; Node: TTreeNode);
var
I: integer;
//Sec: TRaveBaseSecurity;
ALine: TItemProp;
IReport: IXMLReport;
IReportParams: IXMLReportParams;
AParamName: string;
ADefaultValue: string;
begin
 if Node <> nil then
  begin
   SetNodeBoldState(Node,True);
   LstParams.Strings.Clear;
   self.LblParamHint.Caption := '';

   DescribeReport(ActiveReport);

   case ActiveReport.tiprep of
    rtReport: //Relatório interno...
     begin
      //Busca no arquivo XML de parâmetros informações sobre o relatório atual.
      IReport := self.FindReportNode(ActiveReport.ReportId);
      if IReport = nil then Exit;

      IReportParams := IReport.Params;
      //Cria e prepara os objetos de manipulação dos parâmetros do relatório selecionado.
      CreateParamsObjects(ActiveReport.ReportId);

      for I := 0 to Pred(IReportParams.Count) do
            begin
             AParamName := IReportParams.Param[I].ParamName;

             {Pega o valor default do parâmetro, caso exista no arquivo de configuração.
              Este valor pode ser ua tag, que será convertida para um valor real,
              ou pode ser uma constante, como, por exemplo, "Sim" ou "Não".}
             ADefaultValue := IReportParams.Param[I].DefaultValue;

             if ADefaultValue <> '' then
               ADefaultValue := GetParamDefaultValue(ADefaultValue);

             //Insere a linha na grade e configura como será a edição dos dados...
             if IReportParams.Param[I].IsVisible = 1 then
              begin
               LstParams.InsertRow(AParamName, ADefaultValue, True);
               ALine := LstParams.ItemProps[AParamName];
               ALine.KeyDesc := IReportParams.Param[I].Description;
               ALine.EditStyle := TEditStyle(IReportParams.Param[I].EditType);

               //Adiciona a lista de valores, se necessário.
               if ALine.EditStyle = esPickList then
                begin
                 ALine.PickList.Delimiter := ';';
                 ALine.PickList.DelimitedText := IReportParams.Param[I].PickList;
                end;

               ALine.EditMask := IReportParams.Param[I].ParamMask;
               ALine.ReadOnly := IReportParams.Param[I].CanEdit = 0;
               ALine.MaxLength := IReportParams.Param[I].MaxLength;
              end;
            end;


      //Agora, insere na grade e nos objetos em memória os últimos valores dos parâmetros.
      if ExecutionMode = emExecuteCentral then
        ReadParamsFromFile(ActiveReport.nomrep);
     end;

    rtExternalReport:
     begin
      DescribeReport(ActiveReport);
     end ;

    rtCategory: DescribeReport(ActiveReport);
   end;
  end;
end;

procedure TFrmReportCenter.TrvReportsChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
 SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmReportCenter.SaveParamsToFile(const ReportName: string);
var
I: integer;
AFile: TIniFilePersistence;
IReport: IXMLReport;
IReportParams: IXMLReportParams;
AParamName: string;
AParamValue: variant;
AList: TSTringList;
begin
 {Salva os valores dos parâmetros em um arquivo. Estes valores serão carregados
  na próxima vez que o relatório for gerado.}
 AFile := TIniFilePersistence.Create(ParamsFile, False);

 try
  IReport := self.FindReportNode(ActiveReport.ReportId);
  if IReport = nil then Exit;

  IReportParams := IReport.Params;
  for I := 0 to Pred(IReportParams.Count) do
    begin
     AParamName := IReportParams.Param[I].ParamName;
     if IReportParams.Param[I].SendToServer = 0 then
       AParamValue := RepLocalParams.FindValue(AParamName)
     else
       AParamValue := RepServerParams.FindValue(AParamName);

     if AParamValue <> null then
      begin
       case IReportParams.Param[I].ParamType of
        0: AFile.WriteInteger(ReportName, AParamName, AParamValue);
        1: AFile.WriteString(ReportName, AParamName, AParamValue);
        2:
         begin
          //Primeiro, retira as marcas de strings para que seja possível converter para TDate.
          AParamValue := TDataConverter.UnQuotedStr(AParamValue);
          AParamValue := TDataConverter.ToFormatedDateTime(VarToDateTime(AParamValue));
          AFile.WriteString(ReportName, AParamName, AParamValue);
         end;
        3:
         begin
          //Primeiro, retira as marcas de strings para que seja possível converter para TDate.
          AParamValue := TDataConverter.UnQuotedStr(AParamValue);

          if AParamValue = 'S' then
            AFile.WriteString(ReportName, AParamName, 'Sim')
           else
            AFile.WriteString(ReportName, AParamName, 'Não');
         end;
        4:
         begin
          if IReportParams.Param[I].Quoted = 1 then
           begin
            AList := TStringList.Create;

            try
             AList.Delimiter := ',';
             AList.QuoteChar := ' ';
             AList.DelimitedText := AParamValue;
             //Salva a lista sem o delimitador de strings...
             TDataConverter.UnQuotedStr(AList);

             AParamValue := AList.DelimitedText;

            finally
              if Assigned(AList) then
               FreeAndNil(AList);
            end;
           end;

          AFile.WriteString(ReportName, AParamName, AParamValue);
         end;
        5:
          begin
            AParamValue := self.LstParams.Values[AParamName];
            AFile.WriteString(ReportName, AParamName, AParamValue);
          end;
       end;
      end;
    end;

  AFile.Save;

 finally
  if Assigned(AFile) then
   AFile.Free;
 end;
end;

procedure TFrmReportCenter.FormatParamsValues;
var
I, Index, ACounter: integer;
IReport: IXMLReport;
IReportParams: IXMLReportParams;
AParamName, AString: string;
AParamValue: variant;
AList: TStringList;
begin
{Formata os valores dos parâmetros na memória. Esta formatação é feita de
 acordo com cada tipo de parâmetro. A formatação inclui não apenas tratar os
 parâmetros de acordo com o sue tipo, como também inserir delimitares de
 texto ('') entre outros.}
 IReport := self.FindReportNode(ActiveReport.ReportId);
 if IReport = nil then Exit;

 IReportParams := IReport.Params;
 for I := 0 to Pred(IReportParams.Count) do
  begin
   AParamName := IReportParams.Param[I].ParamName;
   AParamValue := null;

   case IReportParams.Param[I].ParamType of
     0:  //integer
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToInteger(LstParams.Values[AParamName]);
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 0) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := RepServerParams.FindValue(Index);

            if (AParamValue = null) and (IReportParams.Param[I].DefaultValue <> '') then
              AParamValue := TDataConverter.ToInteger(IReportParams.Param[I].DefaultValue);

            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (IReportParams.Param[I].SendToServer = 0) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     1:   //string
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];
            RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 0) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if IReportParams.Param[I].DefaultValue <> '' then
              AParamValue := IReportParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (IReportParams.Param[I].SendToServer = 0) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     2:  //Date
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToDate(LstParams.Values[AParamName]);
            AParamValue := QuotedStr(FormatDateTime('mm/dd/yyyy', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 0) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if IReportParams.Param[I].DefaultValue <> '' then
              AParamValue := IReportParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            AParamValue := QuotedStr(FormatDateTime('mm/dd/yyyy', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (IReportParams.Param[I].SendToServer = 0) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];

            if (AParamValue <> null) and (Trim(AParamValue) <> '') then
              begin
                AParamValue := TDataConverter.ToDate(LstParams.Values[AParamName]);
                AParamValue := FormatDateTime('dd/mm/yyyy', AParamValue);
                RepLocalParams.WriteValue(AParamName, AParamValue, Index);
              end;
          end;
      end;
     3:  //boolean - Deve ser tratado com string para virar "S" ou "N".
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 1) then
         begin
           Index := RepServerParams.FindIndex(AParamName);
           AParamValue := LstParams.Values[AParamName];
           AParamValue := Copy(AParamValue, 1, 1);
           RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
         end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 0) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if IReportParams.Param[I].DefaultValue <> '' then
              AParamValue := IReportParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            AParamValue := Copy(AParamValue, 1, 1);
            RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (IReportParams.Param[I].SendToServer = 0) and (IReportParams.Param[I].IsVisible = 1) then
         begin
           Index := RepLocalParams.FindIndex(AParamName);
           AParamValue := RepLocalParams.FindValue(AParamName);
           RepLocalParams.WriteValue(AParamName, AParamValue, Index);
         end;
      end;
     4:   //lista de strings com caracteres delimitadores...
      begin
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];

            AList := TStringList.Create;
            AList.Delimiter := ',';
            AList.QuoteChar := ' ';
            AList.DelimitedText := AParamValue;


            try
             for ACounter := 0 to Pred(AList.Count) do
               begin
                AString := AList.Strings[ACounter];
                //Adiciona um delimitador de string, caso não exista.
                if Pos('''', AString) = 0 then
                  AString := QuotedStr(AString);

                case IReportParams.Param[I].CaseMode of
                 0: AString := AString; //Não faz nada.
                 1: AString := LowerCase(AString); //Lowercase
                 2: AString := UpperCase(AString); //Uppercase
                end;

                AList.Strings[ACounter] := AString;
               end;

             AParamValue := AList.DelimitedText;
             RepServerParams.WriteValue(AParamName, AParamValue, Index);

            finally
             if Assigned(AList) then
              FreeAndNil(AList);
            end;
          end
        else
        if (IReportParams.Param[I].SendToServer = 0) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     5:   //lista de opções com valores correspondentes (de-para)...
      begin
        AList := TStringList.Create;

        try
          AList.Delimiter := ';';
          AList.QuoteChar := ' ';

          AList.DelimitedText := IReportParams.Param[I].PickList;
          ACounter := AList.IndexOf(LstParams.Values[AParamName]);

          AList.DelimitedText := IReportParams.Param[I].ValueList;

          if ACounter >= 0 then
            AParamValue := AList.Strings[ACounter]
          else {Não encontrou na lista "De". Procura na lista "Para". Isso acontece
             quando o sistema já passa o valor ("Para") e não um item da lista "DE".}
            begin
              ACounter := AList.IndexOf(LstParams.Values[AParamName]);
              if ACounter >= 0 then
                AParamValue := LstParams.Values[AParamName]
              else //Nada encontrado. Sempre pega o primeiro item da lista.
               begin
                ACounter := 0;
                AParamValue := AList.Strings[ACounter];
               end;
            end;

          //Converte a string "AParamValue" para outro tipo de dado, caso necessário.
          case IReportParams.Param[I].ConvertTo of
           0: AParamValue := TDataConverter.ToInteger(AParamValue);
           1:
            begin
             if IReportParams.Param[I].Quoted = 1 then
              AParamValue := QuotedStr(AParamValue);
            end
           else
            AParamValue := AParamValue;
          end;

        finally
          if Assigned(AList) then
           FreeAndNil(AList);
        end;

        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        if (IReportParams.Param[I].SendToServer = 0) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     6:  //Hora
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToTime(LstParams.Values[AParamName]);
            AParamValue := QuotedStr(FormatDateTime('hh:nn', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (IReportParams.Param[I].SendToServer = 1) and (IReportParams.Param[I].IsVisible = 0) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if IReportParams.Param[I].DefaultValue <> '' then
              AParamValue := IReportParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            AParamValue := QuotedStr(FormatDateTime('hh:nn', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (IReportParams.Param[I].SendToServer = 0) and (IReportParams.Param[I].IsVisible = 1) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];

            if (AParamValue <> null) and (Trim(AParamValue) <> '') then
              begin
                AParamValue := TDataConverter.ToTime(LstParams.Values[AParamName]);
                AParamValue := FormatDateTime('hh:nn', AParamValue);
                RepLocalParams.WriteValue(AParamName, AParamValue, Index);
              end;
          end;
      end;
   end;
  end;
end;

procedure TFrmReportCenter.ListParamsValues(DestField, SourceField: string;
  AData: TCosmosData);
var
ARow: integer;
AValue: variant;
begin
 {Preenche a grade com os valores dos parâmetros do objeto passado em parãmetro
  do método. Este método deve ser usado quando não há equivalência de nomes
  entre o parâmetro e o campo do dataset que foi copiado para a estrutura
  TCosmosData passada.}
 if LstParams.FindRow(DestField, ARow) then
  begin
   AValue := AData.FindValue(SourceField);
   if AValue <> null then
    LstParams.Values[DestField] := AValue;
  end;
end;

initialization
 RegisterClass(TFrmReportCenter);

finalization
 UnRegisterClass(TFrmReportCenter);

end.

