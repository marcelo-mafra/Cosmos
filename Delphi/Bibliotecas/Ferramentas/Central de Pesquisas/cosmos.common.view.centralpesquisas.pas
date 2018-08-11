unit cosmos.common.view.centralpesquisas;

interface

uses
  Winapi.Windows, Winapi.Messages, cosmos.framework.view.FrmDocked, Xml.xmldom,
  Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Vcl.Menus, Vcl.ActnPopup,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Data.DB, Datasnap.DBClient,
  System.Classes, System.Actions, Vcl.ActnList, Vcl.Forms,
  cosmos.frames.gridsearch, Vcl.Grids, Vcl.ValEdit, Vcl.ExtCtrls, Vcl.Graphics,
  Vcl.StdCtrls, Vcl.Controls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnCtrls,
  Vcl.ImgList, System.SysUtils, System.Variants, Vcl.Dialogs,
  cosmos.framework.interfaces.DataAcess, cosmos.classes.ServerInterface,
  cosmos.framework.interfaces.Dialogs, Winapi.CommCtrl, System.DateUtils,
  cosmos.system.messages, cosmos.classes.application, cosmos.system.types,
  cosmos.core.classes.searchsinfo, cosmos.framework.forms.datadialogs,
  cosmos.framework.forms.conferencias, cosmos.framework.forms.focos,
  cosmos.business.focos, cosmos.classes.security, Data.DBXCommon,
  cosmos.framework.datanavigators.datasets, cosmos.system.formsconst,
  cosmos.framework.interfaces.root;

type

   TCosmosDataSearch = record
    CosmosSearch: TCosmosSearch;
    SearchName: string;
    Description: string;
    Category: string;
    Enabled: boolean;
   end;

  PCosmosDataSearch = ^TCosmosDataSearch;

  TFrmCentralPesquisas = class(TFrmCosmosDocked)
    DsrSearch: TDataSource;
    ActExecute: TAction;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TrvSearchs: TTreeView;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    LblDescription: TLabel;
    Image1: TImage;
    Splitter1: TSplitter;
    Panel2: TPanel;
    LstParams: TValueListEditor;
    Bevel3: TBevel;
    Image2: TImage;
    LblParamHint: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    ActExport: TAction;
    ActUpdate: TAction;
    PopupActionBar1: TPopupActionBar;
    Exportar1: TMenuItem;
    ActLocate: TAction;
    Localizar1: TMenuItem;
    XMLSearchsInfo: TXMLDocument;
    ActFullScreen: TAction;
    ActFirst: TAction;
    ActPrior: TAction;
    ActNext: TAction;
    ActLast: TAction;
    ActRefresh: TAction;
    ActViewSearchBar: TAction;
    ActClearIndex: TAction;
    Desfazndice1: TMenuItem;
    N1: TMenuItem;
    ModoTelaCheia1: TMenuItem;
    Navegao1: TMenuItem;
    Primeiro1: TMenuItem;
    Anterior1: TMenuItem;
    Seguinte1: TMenuItem;
    ltimo1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
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
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActExportExecute(Sender: TObject);
    procedure ActExportUpdate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActLocateExecute(Sender: TObject);
    procedure ActFullScreenExecute(Sender: TObject);
    procedure ActFullScreenUpdate(Sender: TObject);
    procedure ActFirstExecute(Sender: TObject);
    procedure ActFirstUpdate(Sender: TObject);
    procedure ActPriorExecute(Sender: TObject);
    procedure ActNextExecute(Sender: TObject);
    procedure ActLastExecute(Sender: TObject);
    procedure ActLastUpdate(Sender: TObject);
    procedure ActRefreshExecute(Sender: TObject);
    procedure ActRefreshUpdate(Sender: TObject);
    procedure ActViewSearchBarExecute(Sender: TObject);
    procedure ActClearIndexExecute(Sender: TObject);
    procedure ActClearIndexUpdate(Sender: TObject);
  private
    { Private declarations }

    FIXMLSearchs: IXMLSearchsType;
    FRepServerParams, FRepLocalParams: TCosmosData;
    FDataNavigator: TDatasetDataNavigator;
    CdsSearch: TClientDataset;

    procedure CheckParamsValues;
    function CreateCategory(const Category: string): TTreeNode;
    procedure ListSearchsInfo;
    procedure UpdateData(Sender: TObject);

    function FindSearchNode(const FullSearchName: string): IXMLSearchType;
    function FindParamNode(const ParamName: string): IXMLParamType;
    function GetParamDefaultValue(const AParamValue: string): variant;
    function GetParamHelp(const ParamName: string): string;
    procedure CopyParamsValues(AData: TCosmosData);  overload;
    procedure CopyParamsValues(DestField, SourceField: string; AData: TCosmosData); overload;
    procedure ListParamsValues(AData: TCosmosData);  overload;
    procedure ListParamsValues(DestField, SourceField: string; AData: TCosmosData); overload;
    procedure FormatParamsValues;
    procedure ValidateParams(Params: TCosmosData);
    procedure LoadSearchsInfo;

    procedure DoExecuteSearch(const SearchId: integer);

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

    property IXMLSearchs: IXMLSearchsType read FIXMLSearchs;
    property RepServerParams: TCosmosData read FRepServerParams;
    property RepLocalParams: TCosmosData read FRepLocalParams;
  end;

var
  FrmCentralPesquisas: TFrmCentralPesquisas;

implementation

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


{ TFrmCosmosDocked1 }

procedure TFrmCentralPesquisas.ActExecuteExecute(Sender: TObject);
var
ISearch: IXMLSearchType;
begin
  inherited;
  if TrvSearchs.Selected <> nil then
   begin
    ISearch := self.FindSearchNode(TrvSearchs.Selected.Text);
    DoExecuteSearch(ISearch.SearchInfo.Info.SearchId);
   end;
end;

procedure TFrmCentralPesquisas.ActExecuteUpdate(Sender: TObject);
var
 AData: PCosmosDataSearch;
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

procedure TFrmCentralPesquisas.ActExportExecute(Sender: TObject);
begin
  inherited;
  ICosmosApp.IRemoteCon.DefaultExport(self.CdsSearch);
end;

procedure TFrmCentralPesquisas.ActExportUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsSearch <> nil) and (CdsSearch.Active) and (CdsSearch.RecordCount > 0);
end;

procedure TFrmCentralPesquisas.ActFullScreenExecute(Sender: TObject);
begin
  inherited;
  ICosmosApp.FullScreen := not ICosmosApp.FullScreen;
end;

procedure TFrmCentralPesquisas.ActFullScreenUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := (Assigned(ICosmosApp)) and (ICosmosApp.FullScreen);
end;

procedure TFrmCentralPesquisas.ActClearIndexExecute(Sender: TObject);
begin
  inherited;
  if (CdsSearch <> nil) and (CdsSearch.Active) then
    CdsSearch.IndexFieldNames := '';
end;

procedure TFrmCentralPesquisas.ActClearIndexUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsSearch <> nil) and (CdsSearch.Active)
    and (CdsSearch.IndexFieldNames <> '');
end;

procedure TFrmCentralPesquisas.ActViewSearchBarExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmCentralPesquisas.ActFirstExecute(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataNavigator.MoveToFirst;
end;

procedure TFrmCentralPesquisas.ActFirstUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(ICosmosApp))
    and (IRemoteCon.ActiveDataNavigator <> nil) and not (IRemoteCon.ActiveDataNavigator.IsBof);
end;

procedure TFrmCentralPesquisas.ActLastExecute(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataNavigator.MoveToLast;
end;

procedure TFrmCentralPesquisas.ActLastUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(ICosmosApp))
    and (IRemoteCon.ActiveDataNavigator <> nil) and not IRemoteCon.ActiveDataNavigator.IsEof;
end;

procedure TFrmCentralPesquisas.ActLocateExecute(Sender: TObject);
begin
  inherited;
  ICosmosApp.IRemoteCon.DefaultLocate;
end;

procedure TFrmCentralPesquisas.ActNextExecute(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataNavigator.MoveToNext;
end;

procedure TFrmCentralPesquisas.ActPriorExecute(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataNavigator.MoveToPrior;
end;

procedure TFrmCentralPesquisas.ActRefreshExecute(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataNavigator.UpdateData;
end;

procedure TFrmCentralPesquisas.ActRefreshUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(ICosmosApp))
    and (IRemoteCon.ActiveDataNavigator <> nil) and (IRemoteCon.ActiveDataNavigator.Active);
end;

procedure TFrmCentralPesquisas.CopyParamsValues(AData: TCosmosData);
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

procedure TFrmCentralPesquisas.CheckParamsValues;
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

procedure TFrmCentralPesquisas.CopyParamsValues(DestField, SourceField: string;
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

function TFrmCentralPesquisas.CreateCategory(const Category: string): TTreeNode;
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

procedure TFrmCentralPesquisas.DoExecuteSearch(const SearchId: integer);
var
 AIndexName: string;
begin
 //Formata os dados e escreve tudo nas duas estruturas de parâmetros em memória.
 CheckParamsValues;

 try
  FormatParamsValues;
  ValidateParams(RepServerParams);

 except
   on E: Exception do
    begin
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.CentralPesquisas, TCosmosErrorMsg.FormatParams);
       ICosmosApp.MainLog.RegisterError(E.Message);
       raise;
    end;
 end;

 try
   if Assigned(CdsSearch) then
    begin
     AIndexName := CdsSearch.IndexFieldNames;
     CdsSearch.DisableControls;
     FreeAndNil(CdsSearch);
    end;

   screen.Cursor := crHourGlass;
   CdsSearch := IRemoteCon.ExecuteRegisteredSearch(SearchId, RepServerParams.Data) as TClientDataset;

   if (CdsSearch <> nil) and (CdsSearch.Active) then
    begin
     DsrSearch.DataSet := CdsSearch;

     {Refaz o atual IndexName definido pelo usuário ao clicar em uma coluna da grade.
      Somente refaz isso se a nova consulta executada possuir a coluna referenciada
      na propriedade IndexName. Isto tem de ser feito para não gerar erro devido ao
      fato de uma coluna possuir um campo correto na propriedade IndexName, mas outra
      consulta não possuir este campo.}

     if AIndexName <> '' then
      begin
       if CdsSearch.Fields.FindField(AIndexName) <> nil then
        CdsSearch.IndexFieldNames := AIndexName;
      end;

     if not Assigned(FDataNavigator) then
      begin
       FDataNavigator := TDatasetDataNavigator.Create(CdsSearch);
       DataNavigator := FDataNavigator;
       IRemoteCon.ActiveDataset := CdsSearch;
       IRemoteCon.ActiveDataNavigator := FDataNavigator;
       TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;
      end;

     if self.PageControl1.ActivePageIndex = 0 then
      PageControl1.ActivePageIndex := 1;
    end;

 finally
  screen.Cursor := crDefault;
  if Assigned(CdsSearch) then
   CdsSearch.EnableControls;
 end;
end;

procedure TFrmCentralPesquisas.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(CdsSearch);
end;

function TFrmCentralPesquisas.FindParamNode(
  const ParamName: string): IXMLParamType;
var
I: integer;
ISearch: IXMLSearchType;
ISearchParams: IXMLParamsType;
AData: PCosmosDataSearch;
begin
{Retorna uma interface de acesso a um parâmetro de uma pesquisa. A partir desta
 interface é possível ler seus atributos.}
 Result := nil;
 if (TrvSearchs.Selected <> nil) and (TrvSearchs.Selected.Data <> nil) then
  begin
   AData := TrvSearchs.Selected.Data;

   ISearch := self.FindSearchNode(AData.SearchName);

   if ISearch <> nil then
    begin
     ISearchParams := ISearch.Params;

     for I := 0 to Pred(ISearchParams.Count) do
      begin
       if ISearchParams.Param[I].ParamName = ParamName then
        begin
         Result := ISearchParams.Param[I];
         Break;
        end;
      end;
    end;
  end;
end;

function TFrmCentralPesquisas.FindSearchNode(
  const FullSearchName: string): IXMLSearchType;
var
I: integer;
begin
 //Encontra uma pesquisa a partir do seu nome completo.
 for I := 0 to Pred(IXMLSearchs.Count) do
   begin
     Result := IXMLSearchs.Search[I];
     if (Result.SearchInfo.Info.SearchName = FullSearchName) then
       break;
   end;
end;

procedure TFrmCentralPesquisas.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsSearch;
end;

procedure TFrmCentralPesquisas.FormatParamsValues;
var
I, Index, ACounter: integer;
ISearch: IXMLSearchType;
ISearchParams: IXMLParamsType;
AParamName, AString: string;
AParamValue: variant;
AList: TStringList;
begin
{Formata os valores dos parâmetros na memória. Esta formatação é feita de
 acordo com cada tipo de parâmetro. A formatação inclui não apenas tratar os
 parâmetros de acordo com o sue tipo, como também inserir delimitares de
 texto ('') entre outros.}
 ISearch := self.FindSearchNode(TrvSearchs.Selected.Text);
 if ISearch = nil then Exit;

 ISearchParams := ISearch.Params;
 for I := 0 to Pred(ISearchParams.Count) do
  begin
   AParamName := ISearchParams.Param[I].ParamName;
   AParamValue := null;

   case ISearchParams.Param[I].ParamType of
     0:  //integer
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToInteger(LstParams.Values[AParamName]);
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = False) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := RepServerParams.FindValue(Index);

            if (AParamValue = null) and (ISearchParams.Param[I].DefaultValue <> '') then
              AParamValue := TDataConverter.ToInteger(ISearchParams.Param[I].DefaultValue);

            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (ISearchParams.Param[I].SendToServer = False) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     1:   //string
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];
            RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = False) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if ISearchParams.Param[I].DefaultValue <> '' then
              AParamValue := ISearchParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (ISearchParams.Param[I].SendToServer = False) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := LstParams.Values[AParamName];
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     2:  //Date
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToDate(LstParams.Values[AParamName]);
            AParamValue := QuotedStr(FormatDateTime('mm/dd/yyyy', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = False) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if ISearchParams.Param[I].DefaultValue <> '' then
              AParamValue := ISearchParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            AParamValue := QuotedStr(FormatDateTime('mm/dd/yyyy', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (ISearchParams.Param[I].SendToServer = False) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToDate(LstParams.Values[AParamName]);
            AParamValue := FormatDateTime('dd/mm/yyyy', AParamValue);
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     3:  //boolean - Deve ser tratado com string para virar "S" ou "N".
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = True) then
         begin
           Index := RepServerParams.FindIndex(AParamName);
           AParamValue := LstParams.Values[AParamName];
           AParamValue := Copy(AParamValue, 1, 1);
           RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
         end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = False) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if ISearchParams.Param[I].DefaultValue <> '' then
              AParamValue := ISearchParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            AParamValue := Copy(AParamValue, 1, 1);
            RepServerParams.WriteValue(AParamName, QuotedStr(AParamValue), Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (ISearchParams.Param[I].SendToServer = False) and (ISearchParams.Param[I].IsVisible = True) then
         begin
           Index := RepLocalParams.FindIndex(AParamName);
           AParamValue := RepLocalParams.FindValue(AParamName);
           RepLocalParams.WriteValue(AParamName, AParamValue, Index);
         end;
      end;
     4:   //lista de strings com caracteres delimitadores...
      begin
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = True) then
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

                case ISearchParams.Param[I].CaseMode of
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
        if (ISearchParams.Param[I].SendToServer = False) and (ISearchParams.Param[I].IsVisible = True) then
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
          AList.QuoteChar := '|';
          AList.DelimitedText := ISearchParams.Param[I].PickList;
          ACounter := AList.IndexOf(LstParams.Values[AParamName]);

          AList.DelimitedText := ISearchParams.Param[I].ValueList;
          AParamValue := AList.Strings[ACounter];

          //Converte a string "AParamValue" para outro tipo de dado, caso necessário.
          case ISearchParams.Param[I].ConvertTo of
           0: AParamValue := TDataConverter.ToInteger(AParamValue);
           1:
            begin
             if ISearchParams.Param[I].Quoted = True then
              AParamValue := QuotedStr(AParamValue);
            end
           else
            APAramValue := AParamValue;
          end;

        finally
          if Assigned(AList) then
           FreeAndNil(AList);
        end;

        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        if (ISearchParams.Param[I].SendToServer = False) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
     6:  //Hora
      begin
        //Parâmetro enviado ao servidor e visível para edição.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToTime(LstParams.Values[AParamName]);
            AParamValue := QuotedStr(FormatDateTime('hh:nn', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (ISearchParams.Param[I].SendToServer = True) and (ISearchParams.Param[I].IsVisible = False) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if ISearchParams.Param[I].DefaultValue <> '' then
              AParamValue := ISearchParams.Param[I].DefaultValue
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            AParamValue := QuotedStr(FormatDateTime('hh:nn', AParamValue));
            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
        else
        //Parâmetro local e visível para edição.
        if (ISearchParams.Param[I].SendToServer = False) and (ISearchParams.Param[I].IsVisible = True) then
          begin
            Index := RepLocalParams.FindIndex(AParamName);
            AParamValue := TDataConverter.ToTime(LstParams.Values[AParamName]);
            AParamValue := FormatDateTime('hh:nn', AParamValue);
            RepLocalParams.WriteValue(AParamName, AParamValue, Index);
          end;
      end;
    7:  //Operador SQL (maior que, menor que etc). Todos são enviados ao servidor, tratados como string e sem quotes.
      begin
        //Parâmetro enviado ao servidor, mas invisível: enviar o valor padrão do parâmetro ou manter valor armazenado.
        if (ISearchParams.Param[I].SendToServer = True) then
          begin
            Index := RepServerParams.FindIndex(AParamName);
            if ISearchParams.Param[I].DefaultValue <> '' then
              begin
               AParamValue := ISearchParams.Param[I].DefaultValue;
               AParamValue := GetParamDefaultValue(AParamValue);
              end
            else
              AParamValue := RepServerParams.FindValue(AParamName);

            RepServerParams.WriteValue(AParamName, AParamValue, Index);
          end
      end;
   end;
  end;
end;

procedure TFrmCentralPesquisas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmCentralPesquisas := nil;
end;

procedure TFrmCentralPesquisas.FormCreate(Sender: TObject);
begin
 {Carrega a estrutura xml de informações das pesquisas. Se a operação não puder ser
 executada, a Central de Pesquisas não irá funcionar corretamente.}
  inherited;
 FRepServerParams := TCosmosData.Create(20);
 FRepLocalParams := TCosmosData.Create(20);

 screen.Cursor := crHourGlass;

 try
  Self.LoadSearchsInfo;
  ListSearchsInfo;

 finally
  Screen.Cursor := crDefault;
  if IXMLSearchs = nil then
    begin
     ICosmosApp.DlgMessage.Execute(TCosmosTitles.CentralPesquisas, TCosmosErrorMsg.CentralPesquisaInfoFile, mtError);
     ICosmosApp.MainLog.RegisterError(TCosmosErrorMsg.CentralPesquisaInfoFile);
    end;
 end;
end;

procedure TFrmCentralPesquisas.FormDestroy(Sender: TObject);
begin
  inherited;
 if Assigned(FRepServerParams) then
  FRepServerParams.Free;
 if Assigned(FRepLocalParams) then
  FRepLocalParams.Free;
end;

function TFrmCentralPesquisas.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormCentralPesquisas;
end;

function TFrmCentralPesquisas.GetFormIDName: string;
begin
 Result := 'Cosmos.CentralPesquisas';
end;

function TFrmCentralPesquisas.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmCentralPesquisas.GetHelpID: integer;
begin

end;

function TFrmCentralPesquisas.GetParamDefaultValue(
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
    if AParamValue = 'NOMFOC-CURRENT' then  //do not localize!
     Result := ICosmosApp.ActiveFocus.FocusName;
  end;

 //Parâmetro representando a conferência corrente...
 if (Supports(Application.MainForm, ICosmosConference)) and (ICosmosApp.IConference <> nil) and (ICosmosApp.IConference.ActiveConference <> nil) then
  begin
   if AParamValue = 'CODCON-CURRENT' then //do not localize!
    Result := ICosmosApp.IConference.ActiveConference.ConferenceID
   else
    if AParamValue = 'NOMCON-CURRENT' then  //do not localize!
     Result := ICosmosApp.IConference.ActiveConference.ConferenceName;
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
 if AParamValue = 'CURRENT-MONTH' then  //do not localize!
   begin
    ADate := IRemoteCon.ServerDateTime;
    DecodeDate(ADate, Y, M, D);
    Result := IntToStr(M);
   end
 else
 if AParamValue = 'CURRENT-MONTHNAME' then  //do not localize!
   begin
    ADate := IRemoteCon.ServerDateTime;
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

function TFrmCentralPesquisas.GetParamHelp(const ParamName: string): string;
var
ISearch: IXMLSearchType;
ISearchParams: IXMLParamsType;
AData: PCosmosDataSearch;
Index: integer;
begin
//Obtém o hint de ajuda para um determinado parâmetro de pesquisa.
 Result := '';

 if (TrvSearchs.Selected <> nil) and (TrvSearchs.Selected.Data <> nil) then
  begin
   AData := TrvSearchs.Selected.Data;
   ISearch := self.FindSearchNode(AData.SearchName);
   if ISearch = nil then
     Exit;

   ISearchParams := ISearch.Params;

   for Index := 0 to Pred(ISearchParams.Count) do
    begin
     if ISearchParams.Param[Index].ParamName = ParamName then
      begin
        Result := ISearchParams.Param[Index].HelpHint;
        Break;
      end;
    end;
  end;
end;

function TFrmCentralPesquisas.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmCentralPesquisas.ListParamsValues(AData: TCosmosData);
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

procedure TFrmCentralPesquisas.ListParamsValues(DestField, SourceField: string;
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

procedure TFrmCentralPesquisas.LoadSearchsInfo;
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
    ACommand.Text := 'TDMCosmosApplicationServer.GetSearchsCentralInfo';
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
         FIXMLSearchs := GetSearchs(XMLSearchsInfo.DocumentElement.OwnerDocument);
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

procedure TFrmCentralPesquisas.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmCentralPesquisas.LstParamsEditButtonClick(Sender: TObject);
var
Param: string;
AData: TCosmosData;
ISearchParam: IXMLParamType;
begin
 inherited;

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
 if (Param = 'CODCAD') or (Param = 'NOMCAD') then
  begin
   AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, False);
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
  end;

end;

procedure TFrmCentralPesquisas.LstParamsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  self.LblParamHint.Caption := self.GetParamHelp(LstParams.Cells[0, ARow]);
end;

procedure TFrmCentralPesquisas.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmCentralPesquisas.ListSearchsInfo;
var
 I, J: integer;
 IXMLSearch: IXMLSearchType;
 ANode, ACategory: TTreeNode;
 ASearchData: PCosmosDataSearch;
 Modules, ReportRoles: TStringList;
 AReportRole: string;
 CanExecuteReport: boolean;
begin
{Lista as pesquisas na árvore de pesquisas, conforme as regras estabelecidas:

 1)Somente são listadas as pesquisas do módulo em execução do Cosmos.
 2) Somente são listadas as pesquisas acessíveis ao perfil corrente.}
 Modules := TStringList.Create;
 ReportRoles := TStringList.Create;
 Modules.CaseSensitive := False;
 ReportRoles.CaseSensitive := False;

 try
   for I := 0 to Pred(IXMLSearchs.Count) do
    begin
     Modules.Clear;
     ReportRoles.Clear;

     IXMLSearch := self.IXMLSearchs.Search[I];

     Modules.CommaText := IXMLSearch.SearchInfo.Info.CosmosModule;
     ReportRoles.CommaText := IXMLSearch.SearchInfo.Info.ExecutedBy;

     if Modules.IndexOf(ICosmosApp.CosmosModuleShortName) < 0 then
       Continue;

     CanExecuteReport := False; //default.

     for J := 0 to Pred(ReportRoles.Count) do
       begin
        AReportRole := ReportRoles.Strings[J];
        if not CanExecuteReport then
         CanExecuteReport := Pos(AReportRole, IRemoteCon.CurrentConnectionInfo.CurrentUser.Group) > 0;
       end;

     if not CanExecuteReport then Continue;


     ACategory := self.CreateCategory(IXMLSearch.SearchInfo.Info.Category);

     New(ASearchData);
     ASearchData.SearchName := IXMLSearch.SearchInfo.Info.SearchName;
     ASearchData.Description := IXMLSearch.SearchInfo.Info.SearchDescription;
     ASearchData.Enabled := IXMLSearch.SearchInfo.Info.Enabled;

     ANode := TrvSearchs.Items.AddChildObject(ACategory, IXMLSearch.SearchInfo.Info.SearchName, ASearchData);

     if IXMLSearch.SearchInfo.Info.Enabled then
      ANode.ImageIndex := 1
     else
      ANode.ImageIndex := 2;

     ANode.SelectedIndex := ANode.ImageIndex;
    end;

 finally
  if Assigned(ReportRoles) then FreeAndNil(ReportRoles);
  if Assigned(Modules) then FreeAndNil(Modules);
  TrvSearchs.AlphaSort(True);
 end;
end;

procedure TFrmCentralPesquisas.TrvSearchsChange(Sender: TObject; Node: TTreeNode);
var
ACosmosDataSearch: PCosmosDataSearch;
I: integer;
ALine: TItemProp;
ISearch: IXMLSearchType;
ISearchParams: IXMLParamsType;
AParamName: string;
ADefaultValue: string;
AParamPosition: integer;
begin
 inherited;
 self.LblParamHint.Caption := '';
 self.LblDescription.Caption := '';
 LstParams.Strings.Clear;

 if Node <> nil then
  begin
   SetNodeBoldState(Node,True);

   if Node.Data <> nil then
    begin
     ACosmosDataSearch := Node.Data;
     self.LblDescription.Caption := ACosmosDataSearch.Description;

     if IXMLSearchs <> nil then
       begin
        //Busca no arquivo XML de parâmetros informações sobre o relatório atual.
        ISearch := self.FindSearchNode(ACosmosDataSearch.SearchName);
        if ISearch = nil then Exit;

        ISearchParams := ISearch.Params;
        RepServerParams.ClearData;
        RepLocalParams.ClearData;

        LstParams.Enabled := ISearch.SearchInfo.Info.Enabled;


        for I := 0 to Pred(ISearchParams.Count) do
          begin
            AParamName := ISearchParams.Param[I].ParamName;
            AParamPosition := ISearchParams.Param[I].Order;

            {Pega o valor default do parâmetro, caso exista no arquivo de configuração.
             Este valor pode ser uma tag, que será convertida para um valor real,
             ou pode ser uma constante, como, por exemplo, "Sim" ou "Não".}
            ADefaultValue := ISearchParams.Param[I].DefaultValue;

            if ADefaultValue <> '' then
              ADefaultValue := GetParamDefaultValue(ADefaultValue);

             if ISearchParams.Param[I].SendToServer = True then //Parâmetro de consulta SQL no servidor remoto.
              begin
                 case ISearchParams.Param[I].ParamType of
                   //valor do tipo integer.
                   0: if ADefaultValue = '' then
                        RepServerParams.WriteValue(AParamName, 0, AParamPosition)
                      else
                        RepServerParams.WriteValue(AParamName, TDataConverter.ToInteger(ADefaultValue), AParamPosition);
                   //valor do tipo string e operadores SQL.
                   1, 7: if ADefaultValue = '' then
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
                   4, 5: RepServerParams.WriteValue(AParamName, '', AParamPosition); //valore do tipo lista de strings.
                 end;
              end
             else  //Parâmetro de informação local, utilizado em variável da pesquisa.
              begin
                 case ISearchParams.Param[I].ParamType of
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
                   4, 5: RepLocalParams.WriteValue(AParamName, '', AParamPosition); //valore do tipo lista de strings.
                 end;
              end;


            //Insere a linha na grade e configura como será a edição dos dados...
            if ISearchParams.Param[I].IsVisible = True then
             begin
              LstParams.InsertRow(AParamName, ADefaultValue, True);
              ALine := LstParams.ItemProps[AParamName];
              ALine.KeyDesc := ISearchParams.Param[I].Description;
              ALine.EditStyle := TEditStyle(ISearchParams.Param[I].EditType);

              //Adiciona a lista de valores, se necessário.
              if ALine.EditStyle = esPickList then
               begin
                ALine.PickList.Delimiter := ';';
                ALine.PickList.QuoteChar := '|';
                ALine.PickList.DelimitedText := ISearchParams.Param[I].PickList;
               end;

               ALine.EditMask := ISearchParams.Param[I].ParamMask;
               ALine.ReadOnly := not ISearchParams.Param[I].CanEdit;
               ALine.MaxLength := ISearchParams.Param[I].MaxLength;
              end;
            end;
        end;

        //Agora, insere na grade e nos objetos em memória os últimos valores dos parâmetros.
       // ReadParamsFromFile(ACosmosDataSearch.nomrep);
     end;
  end;
end;

procedure TFrmCentralPesquisas.TrvSearchsChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmCentralPesquisas.UpdateData(Sender: TObject);
begin
 ActExecute.Execute;
end;

procedure TFrmCentralPesquisas.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmCentralPesquisas.ValidateParams(Params: TCosmosData);
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
 RegisterClass(TFrmCentralPesquisas);

finalization
 UnRegisterClass(TFrmCentralPesquisas);

end.
