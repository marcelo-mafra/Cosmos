unit cosmos.common.view.addresslabels;

interface

uses
  Winapi.Windows, Winapi.Messages, cosmos.framework.view.FrmDocked, Xml.xmldom,
  Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Vcl.Menus, Vcl.ActnPopup,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Data.DB, Datasnap.DBClient,
  System.Classes, System.Actions, Vcl.ActnList, Vcl.Forms,
  Vcl.Grids, Vcl.ValEdit, Vcl.ExtCtrls, Vcl.Graphics, cosmos.system.formsconst,
  Vcl.StdCtrls, Vcl.Controls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnCtrls,
  Vcl.ImgList, System.SysUtils, System.Variants, Vcl.Dialogs,
  cosmos.framework.interfaces.DataAcess, cosmos.classes.ServerInterface,
  cosmos.framework.interfaces.Dialogs, Winapi.CommCtrl, System.DateUtils,
  cosmos.system.messages, cosmos.classes.application, cosmos.system.types,
  cosmos.core.classes.labelsinfo,  cosmos.business.focos, cosmos.classes.security, Data.DBXCommon,
  cosmos.framework.datanavigators.datasets, frxClass, frxDBSet;

type

   TCosmosDataLabel = record
    LabelName: string;
    Description: string;
    Category: string;
    Enabled: boolean;
   end;

  PCosmosDataLabel = ^TCosmosDataLabel;

  TFrmAdressLabels = class(TFrmCosmosDocked)
    ActExecute: TAction;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActExport: TAction;
    ActUpdate: TAction;
    PopupActionBar1: TPopupActionBar;
    Exportar1: TMenuItem;
    Localizar1: TMenuItem;
    XMLSearchsInfo: TXMLDocument;
    Bevel1: TBevel;
    Image1: TImage;
    LblDescription: TLabel;
    TrvSearchs: TTreeView;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Bevel3: TBevel;
    Image2: TImage;
    LblParamHint: TLabel;
    frxAddressLabels: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    CdsLabels: TClientDataSet;
    PageControl1: TPageControl;
    Etiqueta: TTabSheet;
    TabSheet2: TTabSheet;
    LstParams: TValueListEditor;
    Splitter2: TSplitter;
    LstLines: TValueListEditor;
    CBXSearchs: TComboBox;
    Label1: TLabel;
    Image3: TImage;
    ValueListEditor1: TValueListEditor;
    Bevel2: TBevel;
    CdsSearch: TClientDataSet;
    procedure TrvSearchsChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure TrvSearchsChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure ActExecuteUpdate(Sender: TObject);
    procedure ActExecuteExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LstParamsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure LstParamsEditButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActLocateExecute(Sender: TObject);
    procedure LstLinesEditButtonClick(Sender: TObject);
  private
    { Private declarations }

    FIXMLLabels: IXMLLabelsType;
    FRepServerParams, FPageInfoParams, FLinesInfoParams: TCosmosData;

    procedure CheckParamsValues;
    function CreateCategory(const Category: string): TTreeNode;
    procedure ListAddressLabelsInfo;
    procedure UpdateData(Sender: TObject);

    function FindLabelNode(const FullSearchName: string): IXMLLabelType;
    function FindParamNode(const ParamName: string): IXMLParamType;
    function GetParamDefaultValue(const AParamValue: string): variant;
    function GetParamHelp(const ParamName: string): string;
    procedure CopyParamsValues(AData: TCosmosData);  overload;
    procedure CopyParamsValues(DestField, SourceField: string; AData: TCosmosData); overload;
    procedure ListParamsValues(AData: TCosmosData);  overload;
    procedure ListParamsValues(DestField, SourceField: string; AData: TCosmosData); overload;
    procedure ValidateParams(Params: TCosmosData);
    procedure LoadAddressLabelsInfo;

    function DoExecuteSearch(const SearchId: integer): boolean;
    procedure CreateLabelsReport(PageParams, LabelParams: TCosmosData);

  protected
    //ICosmosDockedForm
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

    property IXMLLabels: IXMLLabelsType read FIXMLLabels;
    property RepServerParams: TCosmosData read FRepServerParams;
    property PageInfoParams: TCosmosData read FPageInfoParams;
    property LinesInfoParams: TCosmosData read FLinesInfoParams;
  end;

var
  FrmAdressLabels: TFrmAdressLabels;

implementation

{$R *.dfm}

uses cosmos.common.view.linesprop;

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


{ TFrmCosmosDocked1 }

procedure TFrmAdressLabels.ActExecuteExecute(Sender: TObject);
var
ILabel: IXMLLabelType;
begin
  inherited;
  if TrvSearchs.Selected <> nil then
   begin
    ILabel := self.FindLabelNode(TrvSearchs.Selected.Text);
    if DoExecuteSearch(ILabel.LabelInfo.Info.LabelId) then
     CreateLabelsReport(PageInfoParams, LinesInfoParams);
   end;
end;

procedure TFrmAdressLabels.ActExecuteUpdate(Sender: TObject);
var
 AData: PCosmosDataLabel;
begin
  inherited;
  if (TrvSearchs.Selected <> nil) and (TrvSearchs.Selected.Data <> nil) then
   begin
    AData := TrvSearchs.Selected.Data;
    TAction(Sender).Enabled := AData.Enabled
   end
  else
   TAction(Sender).Enabled := False;
end;

procedure TFrmAdressLabels.ActLocateExecute(Sender: TObject);
begin
  inherited;
  ICosmosApp.IRemoteCon.DefaultLocate;
end;

procedure TFrmAdressLabels.CopyParamsValues(AData: TCosmosData);
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
      AFieldIndex := PageInfoParams.FindIndex(AFieldName);
      if AFieldIndex >= 0 then
        PageInfoParams.WriteValue(AFieldName, AFieldValue, AFieldIndex);
     end;
   end;

end;

procedure TFrmAdressLabels.CheckParamsValues;
var
 I: integer;
 AKey: string;
begin
  for I := 1 to Pred(self.LstParams.RowCount) do
    begin
     AKey := LstParams.Keys[I];
     if Akey = '' then
      Continue;

     if Trim(LstParams.Values[Akey]) = '' then
      begin
       AKey := LStParams.ItemProps[AKey].KeyDesc;
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.CentralPesquisas, Format(TCosmosInfoMsg.EmptyParam, [AKey]));
       Abort;
      end;
    end;
end;

procedure TFrmAdressLabels.CopyParamsValues(DestField, SourceField: string;
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
   AFieldIndex := PageInfoParams.FindIndex(DestField);
   if AFieldIndex >= 0 then
    PageInfoParams.WriteValue(DestField, AFieldValue, AFieldIndex);
  end;
end;

function TFrmAdressLabels.CreateCategory(const Category: string): TTreeNode;
var
 I: integer;
begin
{Localiza ou cria um nó que representa uma categoria de pesquisa.}
 Result := nil;

 for I := 0 to Pred(TrvSearchs.Items.Count) do
   begin
    Result := TrvSearchs.Items.Item[I];
    if Result.Text = Category then
     Break
    else
     Result := nil;
   end;

 if Result = nil then
  Result := TrvSearchs.Items.Add(nil, Category);

end;

function TFrmAdressLabels.DoExecuteSearch(const SearchId: integer): boolean;
var
 AIndexName: string;
begin
 //Formata os dados e escreve tudo nas duas estruturas de parâmetros em memória.
 CheckParamsValues;

 try
  ValidateParams(RepServerParams);

  Result := True;

 except
   on E: Exception do
    begin
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.CentralPesquisas, TCosmosErrorMsg.FormatParams);
       ICosmosApp.MainLog.RegisterError(E.Message);
       raise;
    end;
 end;

 try
   if not Assigned(CdsSearch) then
     CdsSearch := IRemoteCon.ExecuteRegisteredSearch(SearchId, RepServerParams.Data) as TClientDataset
   else
     begin
      CdsSearch.DisableControls;
      CdsSearch.Close; //precisa fechar o dataset antes de chamar o método abaixo.
      IRemoteCon.ExecuteRegisteredSearch(SearchId, RepServerParams.Data, CdsSearch);
     end;

   if (CdsSearch <> nil) and (CdsSearch.Active) then
    begin
     AIndexName := CdsSearch.IndexName;
     CdsSearch.IndexName := '';


     {Refaz o atual IndexName definido pelo usuário ao clicar em uma coluna da grade.
      Somente refaz isso se a nova consulta executada possuir a coluna referenciada
      na propriedade IndexName. Isto tem de ser feito para não gerar erro devido ao
      fato de uma coluna possuir um campo correto na propriedade IndexName, mas outra
      consulta não possuir este campo.}

     if AIndexName <> '' then
      begin
       if CdsSearch.Fields.FindField(AIndexName) <> nil then
        CdsSearch.IndexName := AIndexName;
      end;
    end;

 finally
  if Assigned(CdsSearch) then
   CdsSearch.EnableControls;
 end;
end;

procedure TFrmAdressLabels.ExportData;
begin
  inherited;

end;

function TFrmAdressLabels.FindParamNode(
  const ParamName: string): IXMLParamType;
var
I: integer;
ILabel: IXMLLabelType;
AData: PCosmosDataLabel;
begin
{Retorna uma interface de acesso a um parâmetro de uma pesquisa. A partir desta
 interface é possível ler seus atributos.}
 Result := nil;
 if (TrvSearchs.Selected <> nil) and (TrvSearchs.Selected.Data <> nil) then
  begin
   AData := TrvSearchs.Selected.Data;

   ILabel := self.FindLabelNode(AData.LabelName);

   if ILabel <> nil then
    begin
     for I := 0 to Pred(ILabel.PageInfo.Count) do
      begin
       if ILabel.PageInfo.Param[I].ParamName = ParamName then
        begin
         Result := ILabel.PageInfo.Param[I];
         Break;
        end;
      end;
    end;
  end;
end;

function TFrmAdressLabels.FindLabelNode(
  const FullSearchName: string): IXMLLabelType;
var
I: integer;
begin
 //Encontra uma mala direta a partir do seu nome completo.
 for I := 0 to Pred(IXMLLabels.ChildNodes.Count) do
   begin
     Result := IXMLLabels.ChildNodes.Get(I) as IXMLLabelType;
     if (Result.LabelInfo.Info.LabelName = FullSearchName) then
       break;
   end;
end;

procedure TFrmAdressLabels.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  FrmAdressLabels := nil;
end;

procedure TFrmAdressLabels.FormCreate(Sender: TObject);
begin
 {Carrega a estrutura xml de informações das malas diretas. Se a operação não puder ser
 executada, a ferramenta não irá funcionar corretamente.}
  inherited;
 FRepServerParams := TCosmosData.Create(20);
 FPageInfoParams := TCosmosData.Create(20);
 FLinesInfoParams := TCosmosData.Create(20);

 screen.Cursor := crHourGlass;

 try
  Self.LoadAddressLabelsInfo;
  ListAddressLabelsInfo;

 finally
  Screen.Cursor := crDefault;
  if IXMLLabels = nil then
    begin
     ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosErrorMsg.CentralPesquisaInfoFile, mtError);
     ICosmosApp.MainLog.RegisterError(TCosmosErrorMsg.CentralPesquisaInfoFile);
    end;
 end;
end;

procedure TFrmAdressLabels.FormDestroy(Sender: TObject);
begin
  inherited;
 if Assigned(FRepServerParams) then FRepServerParams.Free;
 if Assigned(FPageInfoParams) then FPageInfoParams.Free;
 if Assigned(FLinesInfoParams) then FLinesInfoParams.Free;
end;

function TFrmAdressLabels.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormCentralPesquisas;
end;

function TFrmAdressLabels.GetFormIDName: string;
begin
 Result := 'Cosmos.AddressLabels';
end;

function TFrmAdressLabels.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmAdressLabels.GetHelpID: integer;
begin

end;

function TFrmAdressLabels.GetParamDefaultValue(
  const AParamValue: string): variant;
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
    if AParamValue = 'NOMFOC-CURRENT' then //do not localize!
     Result := ICosmosApp.ActiveFocus.FocusName;
  end;

 if AParamValue = 'CURRENT-DATE' then  //do not localize!
   Result := TDataConverter.ToFormatedDateTime(IRemoteCon.ServerDateTime)
 else
 if AParamValue = 'CURRENT-YEAR' then  //do not localize!
   begin
    ADate := IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    Result := IntToStr(Y);
   end
 else
 if AParamValue = 'CURRENT-MONTH' then //do not localize!
   begin
    ADate := IRemoteCon.ServerDateTime;
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
    ADate := IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    Result := TDataConverter.ToFormatedDateTime(EncodeDate(Y,M,1));
   end
 else
 if AParamValue = 'LASTDAY-CURRENTMONTH' then  //do not localize!
   begin
    ADate := IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    ADate := EndOfAMonth(Y, M);
    Result := TDataConverter.ToFormatedDateTime(ADate);
   end
end;

function TFrmAdressLabels.GetParamHelp(const ParamName: string): string;
var
ILabel: IXMLLabelType;
AData: PCosmosDataLabel;
Index: integer;
begin
//Obtém o hint de ajuda para um determinado parâmetro de pesquisa.
 Result := '';

 if (TrvSearchs.Selected <> nil) and (TrvSearchs.Selected.Data <> nil) then
  begin
   AData := TrvSearchs.Selected.Data;
   ILabel := self.FindLabelNode(AData.LabelName);
   if ILabel = nil then
     Exit;

   for Index := 0 to Pred(ILabel.PageInfo.Count) do
    begin
     if ILabel.PageInfo.Param[Index].ParamName = ParamName then
      begin
        Result := ILabel.PageInfo.Param[Index].HelpHint;
        Break;
      end;
    end;
  end;
end;

function TFrmAdressLabels.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmAdressLabels.ListParamsValues(AData: TCosmosData);
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

procedure TFrmAdressLabels.ListParamsValues(DestField, SourceField: string;
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

procedure TFrmAdressLabels.LoadAddressLabelsInfo;
const
  iBufSize = 128;
var
  ACommand: TDBXCommand;
  AStream: TStream;
  ASearchsStream : TStringStream;
  buf: PByte;
  iRead: integer;
begin
  //Busca o arquivo XML que possui informações sobre as pesquisas.
  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TDMCosmosApplicationServer.GetAddressLabelsInfo';
    ACommand.Prepare;
    ACommand.ExecuteUpdate;
    AStream := ACommand.Parameters[0].Value.GetStream(True);

    {copia os dados para a memória. Necessário copiar de bloco em bloco pelo
     fato de datasnap somente suportar a transmissão de streams de 64k}
    if AStream <> nil then
     begin
      GetMem(buf, iBufSize);
      ASearchsStream := TStringStream.Create;

      repeat
        iRead := AStream.Read(Pointer(buf)^, iBufSize);

        if iRead > 0 then ASearchsStream.WriteBuffer( Pointer(buf)^, iRead);
        if iRead < iBufSize then break;

      until iRead < iBufSize;
     end;
     //fim da cópia

    if (ASearchsStream <> nil) and (ASearchsStream.Size > 0) then
     begin
       if ASearchsStream <> nil then
        begin
         XMLSearchsInfo.LoadFromStream(ASearchsStream, xetUTF_8);
         FIXMLLabels := GetLabels(XMLSearchsInfo.DocumentElement.OwnerDocument);
         ASearchsStream.Free;
        end;
     end;

    ACommand.Free;

  except
    on E: Exception do
    begin
      if Assigned(AStream) then FreeAndNil(AStream);
      if Assigned(ASearchsStream) then FreeAndNil(ASearchsStream);
      if Assigned(ACommand) then FreeAndNil(ACommand);
      ICosmosApp.MainLog.RegisterError(E.Message);
    end;
  end;

end;

procedure TFrmAdressLabels.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmAdressLabels.LstLinesEditButtonClick(Sender: TObject);
var
aKeyName, ValuesList: string;
begin
 inherited;
 aKeyName :=  LstLines.Keys[LstLines.Row];
 ValuesList := LstLines.Values[aKeyName];
 FrmLinesProp := TFrmLinesProp.Create(Application);

 try
  ValuesList :=  FrmLinesProp.SetLineProperties(ValuesList);
  if ValuesList <> '' then
   begin
     LstLines.Values[aKeyName] := ValuesList;
   end;

 finally
  FreeAndNil(FrmLinesProp);
 end;
end;

procedure TFrmAdressLabels.LstParamsEditButtonClick(Sender: TObject);
var
Param: string;
AData: TCosmosData;
ISearchParam: IXMLParamType;
begin
 inherited;

 Param :=  LstParams.Keys[LstParams.Row];

{ if Param = 'NOMFOC' then
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
  begin
   ISearchParam := self.FindParamNode(Param);
   if ISearchParam = nil then
    Exit;

   try
     if ISearchParam.ParamType = 2 then //Campo do tipo TDate.
       begin
        AData := TCosmosUtilitiesDialogs.SelecionarData;
        if AData <> nil then
          begin
           CopyParamsValues(Param, 'SELDAT', AData);
           ListParamsValues(Param, 'SELDAT', AData);
          end;
       end;

   finally
    if ISearchParam <> nil then
      ISearchParam := nil;
   end;
  end; }

end;

procedure TFrmAdressLabels.LstParamsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  self.LblParamHint.Caption := self.GetParamHelp(LstParams.Cells[0, ARow]);
end;

procedure TFrmAdressLabels.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAdressLabels.CreateLabelsReport(PageParams, LabelParams: TCosmosData);
var
 APage: TfrxReportPage;
 ALine1Data, ALine2Data, ALine3Data, ALine4Data: TfrxMemoView;
 AMasterDataBand: TfrxMasterData;
begin
 //exemplo
  frxAddressLabels.Clear;
  frxAddressLabels.LoadFromFile('malas-diretas.fr3');

  //Configura a página do relatório.
  APage := TfrxReportPage(frxAddressLabels.Pages[1]);

  APage.PaperSize := DMPAPER_A4;
  APage.LeftMargin := PageParams.FindValue('LeftMargin');
  APage.RightMargin := PageParams.FindValue('RightMargin');
  APage.TopMargin :=  PageParams.FindValue('TopMargin');
  APage.BottomMargin :=  PageParams.FindValue('BottomMargin');

  //Configura a largura e altura das etiquetas e colunas.
  AMasterDataBand := frxAddressLabels.FindObject('MasterData1') as TfrxMasterData;
  AMasterDataBand.Columns := PageParams.FindValue('Columns');
  AMasterDataBand.Height := PageParams.FindValue('Height');

  if AMasterDataBand.Columns > 1 then
   begin
    AMasterDataBand.ColumnWidth := PageParams.FindValue('ColumnWidth');
    AMasterDataBand.ColumnGap := PageParams.FindValue('ColumnGap');
   end;

  //Configura a primeira linha de dados.
  ALine1Data := frxAddressLabels.FindObject('Line1') as TfrxMemoView;
  ALine1Data.Left := LabelParams.FindValue('Line1Left');
  ALine1Data.Top := LabelParams.FindValue('Line1Top');
  ALine1Data.Font.Name :=  LabelParams.FindValue('Line1FontName');
  ALine1Data.Font.Size :=  LabelParams.FindValue('Line1FontSize');

  ALine1Data.Font.Style := [];
  if LabelParams.FindValue('Line1FontBold') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsBold];
  if LabelParams.FindValue('Line1FontItalic') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsItalic];

  //Configura a segunda linha de dados.
  ALine1Data := frxAddressLabels.FindObject('Line2') as TfrxMemoView;
  ALine1Data.Left := LabelParams.FindValue('Line2Left');
  ALine1Data.Top := LabelParams.FindValue('Line2Top');
  ALine1Data.Font.Name :=  LabelParams.FindValue('Line2FontName');
  ALine1Data.Font.Size :=  LabelParams.FindValue('Line2FontSize');

  ALine1Data.Font.Style := [];
  if LabelParams.FindValue('Line2FontBold') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsBold];
  if LabelParams.FindValue('Line2FontItalic') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsItalic];

  //Configura a terceira linha de dados.
  ALine1Data := frxAddressLabels.FindObject('Line3') as TfrxMemoView;
  ALine1Data.Left := LabelParams.FindValue('Line3Left');
  ALine1Data.Top := LabelParams.FindValue('Line3Top');
  ALine1Data.Font.Name :=  LabelParams.FindValue('Line3FontName');
  ALine1Data.Font.Size :=  LabelParams.FindValue('Line3FontSize');

  ALine1Data.Font.Style := [];
  if LabelParams.FindValue('Line3FontBold') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsBold];
  if LabelParams.FindValue('Line3FontItalic') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsItalic];

  //Configura a quarta linha de dados.
  ALine1Data := frxAddressLabels.FindObject('Line4') as TfrxMemoView;
  ALine1Data.Left := LabelParams.FindValue('Line4Left');
  ALine1Data.Top := LabelParams.FindValue('Line4Top');
  ALine1Data.Font.Name :=  LabelParams.FindValue('Line4FontName');
  ALine1Data.Font.Size :=  LabelParams.FindValue('Line4FontSize');

  ALine1Data.Font.Style := [];
  if LabelParams.FindValue('Line4FontBold') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsBold];
  if LabelParams.FindValue('Line4FontItalic') = True then
   ALine1Data.Font.Style := ALine1Data.Font.Style + [fsItalic];


  //Finalmente. exibe o relatório.
  frxAddressLabels.ShowReport(true);
end;

procedure TFrmAdressLabels.ListAddressLabelsInfo;
var
 I, J: integer;
 IXMLLabel: IXMLLabelType;
 ANode, ACategory: TTreeNode;
 ASearchData: PCosmosDataLabel;
begin
{Lista as pesquisas na árvore de pesquisas, conforme as regras estabelecidas:

 1)Somente são listadas as pesquisas do módulo em execução do Cosmos.
 2) Somente são listadas as pesquisas acessíveis ao perfil corrente.}
 try
   for I := 0 to Pred(IXMLLabels.ChildNodes.Count) do
    begin
     IXMLLabel := IXMLLabels.ChildNodes.Get(I) as IXMLLabelType;

     ACategory := self.CreateCategory(IXMLLabel.LabelInfo.Info.Category);

     New(ASearchData);
     ASearchData.LabelName := IXMLLabel.LabelInfo.Info.LabelName;
     ASearchData.Description := IXMLLabel.LabelInfo.Info.Description;
     ASearchData.Enabled := IXMLLabel.LabelInfo.Info.Enabled;

     ANode := TrvSearchs.Items.AddChildObject(ACategory, IXMLLabel.LabelInfo.Info.LabelName, ASearchData);

     if IXMLLabel.LabelInfo.Info.Enabled then
      ANode.ImageIndex := 1
     else
      ANode.ImageIndex := 2;

     ANode.SelectedIndex := ANode.ImageIndex;
    end;

 finally

 end;
end;

procedure TFrmAdressLabels.TrvSearchsChange(Sender: TObject; Node: TTreeNode);
var
ACosmosDataSearch: PCosmosDataLabel;
I: integer;
ALine: TItemProp;
ILabel: IXMLLabelType;
ILabelParams: IXMLPageInfoType;
AParamName: string;
AParamValue: string;
AParamPosition: integer;
begin
 inherited;
 self.LblParamHint.Caption := '';
 self.LblDescription.Caption := '';

 LstParams.Strings.Clear;
 LstLines.Strings.Clear;

 if Node <> nil then
  begin
   SetNodeBoldState(Node,True);

   if Node.Data <> nil then
    begin
     ACosmosDataSearch := Node.Data;
     self.LblDescription.Caption := ACosmosDataSearch.Description;

     if IXMLLabels <> nil then
       begin
        //Busca no arquivo XML de parâmetros informações sobre o relatório atual.
        ILabel := self.FindLabelNode(ACosmosDataSearch.LabelName);
        if ILabel = nil then Exit;

        ILabelParams := ILabel.PageInfo;

        PageInfoParams.ClearData;
        LinesInfoParams.ClearData;

        LstParams.Enabled := ILabel.LabelInfo.Info.Enabled;


        for I := 0 to Pred(ILabelParams.Count) do
          begin
            AParamName := ILabelParams.Param[I].ParamName;
            AParamPosition := ILabelParams.Param[I].Order;
            AParamValue := ILabelParams.Param[I].Value;

            PageInfoParams.WriteValue(AParamName, AParamValue, AParamPosition);

            //Insere a linha na grade e configura como será a edição dos dados...
            if ILabelParams.Param[I].IsVisible = True then
             begin
              LstParams.InsertRow(AParamName, AParamValue, True);
              ALine := LstParams.ItemProps[AParamName];
              ALine.KeyDesc := ILabelParams.Param[I].Description;
              ALine.ReadOnly := True;
            end;
          end;

        //Insere as linhas...
        for I := 0 to Pred(ILabel.LinesInfo.Count) do
          begin
            AParamName := ILabel.LinesInfo.Line[I].LineName;
            AParamPosition := ILabel.LinesInfo.Line[I].Order;
            AParamValue := ILabel.LinesInfo.Line[I].Value;
            LinesInfoParams.WriteValue(AParamName, AParamValue, AParamPosition);

            LstLines.InsertRow(AParamName, AParamValue, True);
            ALine := LstLines.ItemProps[AParamName];
            ALine.KeyDesc := ILabel.LinesInfo.Line[I].Description;
            ALine.ReadOnly := True;
            ALine.EditStyle := esEllipsis;
          end;

        end;
     end;
  end;
end;

procedure TFrmAdressLabels.TrvSearchsChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmAdressLabels.UpdateData(Sender: TObject);
begin
 ActExecute.Execute;
end;

procedure TFrmAdressLabels.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAdressLabels.ValidateParams(Params: TCosmosData);
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
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamMatricula, mtError);
      Abort;
    end;

   //Verifica se o código do grupo da Escola Interna foi fornecido.
   if (Param = 'CODGRU') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamCirculoEI, mtError);
      Abort;
   end;

   //Verifica se a atividade foi fornecida.
   if (Param = 'NOMATI') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamAtividade, mtError);
      Abort;
    end;

   //Verifica se o ano de uma Params foi fornecido.
   if (Param = 'ANO') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamAno, mtError);
      Abort;
    end;

   if (Param = 'MATRICULAS') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosErrorMsg.ParamMatriculas, mtError);
      Abort;
    end;

   if (Param = 'MATRICULAS-TMB') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosErrorMsg.ParamMatriculas, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-LEC') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamMatriculaLEC, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-TM') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamMatriculaTM, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-TMB') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamMatriculaTMB, mtError);
      Abort;
    end;

   if (Param = 'MATCAD-TP') and (Trim(Value) = '') then
    begin
      ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosReportsError.ParamMatriculaTP, mtError);
      Abort;
    end;
  end;
end;

initialization
 RegisterClass(TFrmAdressLabels);

finalization
 UnRegisterClass(TFrmAdressLabels);

end.
