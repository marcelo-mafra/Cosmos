unit cosmos.common.view.PesquisarCadastrado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormDefaultSearchs, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Data.DB, Datasnap.DBClient, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, cosmos.frames.gridsearch, ValueComboBox, cosmos.system.files,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.business.focos, cosmos.system.messages,
  cosmos.classes.application, cosmos.classes.ServerInterface, System.ImageList;

type
  TFrmPesquisarCadastrados = class(TFrmDefaultSearchs, IPesquisaCadastrados)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SbnExecute: TSpeedButton;
    Label3: TLabel;
    CbxPesquisa: TComboBox;
    EdtArgumento: TEdit;
    CBXFocos: TValueComboBox;
    FmeGridSearch1: TFmeGridSearch;
    DsrData: TDataSource;
    procedure SbnExecuteClick(Sender: TObject);
    procedure EdtArgumentoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure CdsDataAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FActiveFocus: boolean;
    FSexoCadastrado: TSexoCadastrado;
    FCampoTrabalho: TCampoTrabalho;
    FStatusCadastrado: TStatusCadastrado;
    FCurrentSearch: TCosmosSearch;
    CdsSearchData: TClientDataset;

    function GetSexoCadastrado: TSexoCadastrado;
    procedure SetSexoCadastrado(const Value: TSexoCadastrado);
    function GetActiveFocus: boolean;
    procedure SetActiveFocus(const Value: boolean);
    function GetCampoTrabalho: TCampoTrabalho;
    procedure SetCampoTrabalho(value: TCampoTrabalho);
    function GetDataset: TDataset;
    function GetValue(FieldName: string): Variant;
    function GetStatusCadastrado: TStatusCadastrado;
    procedure SetStatusCadastrado(Value: TStatusCadastrado);

    procedure ListFocos; inline;
    procedure DoSearch(const ASearch: TCosmosSearch); overload;
    procedure DoSearch(const ASearch: TCosmosSearch; AParams: TCosmosData); overload;
    procedure SetCurrentSearch(const Value: TCosmosSearch);

    procedure ReadMyOptions;
    procedure SaveMyOptions;

  protected
    function Execute: boolean; overload;
    function Execute(CosmosSearch: TCosmosSearch): boolean; overload;

    property Dataset: TDataset read GetDataset;
    property ActiveFocus: boolean read GetActiveFocus write SetActiveFocus ;
    property CampoTrabalho: TCampoTrabalho read GetCampoTrabalho write SetCampoTrabalho;
    property SexoCadastrado: TSexoCadastrado read GetSexoCadastrado write SetSexoCadastrado default scTodos;
    property StatusCadastrado: TStatusCadastrado read GetStatusCadastrado write SetStatusCadastrado default scAtivo;


  public
    { Public declarations }
    function GetWindowsId: string; override;
  end;

var
  FrmPesquisarCadastrados: TFrmPesquisarCadastrados;

implementation

{$R *.dfm}

{ TFrmDefaultSearchs1 }

procedure TFrmPesquisarCadastrados.DoSearch(const ASearch: TCosmosSearch);
var
AParamsList: TSQLParams;
begin
//Executa a pesquisa no servidor remoto passando todos os argumentos de busca.

 case ASearch of
  csMentoresEI:
   begin
    AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(True);
    AParamsList.AppendData(QuotedStr('M'), 1);
    AParamsList.AppendData(True, 2);
   end;
  csMentoresEIFoco:
   begin
    AParamsList := TSQLParams.Create(4);
    AParamsList.AppendData(True);
    AParamsList.AppendData(QuotedStr('M'), 1);
    AParamsList.AppendData(True, 2);
    AParamsList.AppendData(StrToInt(CBXFocos.GetValue), 3);
   end;
  csMentorasEI:
   begin
    AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(True);
    AParamsList.AppendData(QuotedStr('F'), 1);
    AParamsList.AppendData(True, 2);
   end;
  csMentorasEIFoco:
   begin
    AParamsList := TSQLParams.Create(4);
    AParamsList.AppendData(True);
    AParamsList.AppendData(QuotedStr('F'), 1);
    AParamsList.AppendData(True, 2);
    AParamsList.AppendData(StrToInt(CBXFocos.GetValue), 3);
   end;
  csDirigentesEI:
   begin
    AParamsList := TSQLParams.Create(4);
   end;
  csJovensAlunos: AParamsList := TSQLParams.Create;
  csJovensAlunosFoco:
   begin
    AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(StrToInt(CBXFocos.GetValue));
    AParamsList.AppendData(QuotedStr('LEC'), 1);
    AParamsList.AppendData(True, 2);
   end;
  csCadastradoMatriculaFoco:
   begin
    AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(StrToInt(CBXFocos.GetValue));
    AParamsList.AppendData(QuotedStr('LEC'), 1);
    AParamsList.AppendData(QuotedStr('%' + EdtArgumento.Text + '%'), 2);
   end;
  csCadastradoMatricula:
   begin
    AParamsList := TSQLParams.Create(2);
    AParamsList.AppendData(QuotedStr('LEC'));
    AParamsList.AppendData(QuotedStr('%' + EdtArgumento.Text + '%'), 1);
   end;
  csCadastradoNomeFoco:
   begin
    AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(StrToInt(CBXFocos.GetValue));
    AParamsList.AppendData(QuotedStr('LEC'), 1);
    AParamsList.AppendData(QuotedStr('%' + EdtArgumento.Text + '%'), 2);
   end;
  csCadastradoNome:
   begin
    AParamsList := TSQLParams.Create(2);
    AParamsList.AppendData(QuotedStr('LEC'));
    AParamsList.AppendData(QuotedStr('%' + EdtArgumento.Text + '%'), 1);
   end;
  csCadastradoApelidoFoco:
   begin
    AParamsList := TSQLParams.Create(3);
    AParamsList.AppendData(StrToInt(CBXFocos.GetValue));
    AParamsList.AppendData(QuotedStr('LEC'), 1);
    AParamsList.AppendData(QuotedStr('%' + EdtArgumento.Text + '%'), 2);
   end;
  csCadastradoApelido:
   begin
    AParamsList := TSQLParams.Create(2);
    AParamsList.AppendData(QuotedStr('LEC'));
    AParamsList.AppendData(QuotedStr('%' + EdtArgumento.Text + '%'), 1);
   end
  else
   Abort;
 end;

//Executa a pesquisa no servidor remoto passando todos os argumentos de busca.
 if Assigned(CdsSearchData) then FreeAndNil(CdsSearchData);

 CdsSearchData := TClientDataset.Create(self);
 CdsSearchData.DisableControls;

 try
  ICosmosApp.IRemoteCon.ExecuteDQL(ASearch, AParamsList.Params, CdsSearchData);

 finally
  DsrData.DataSet := CdsSearchData;
  CdsSearchData.EnableControls;
  ActiveDataset := CdsSearchData;
 end;
end;

procedure TFrmPesquisarCadastrados.CdsDataAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ICosmosApp.IRemoteCon.LoadFieldsInfo(Dataset);
end;

procedure TFrmPesquisarCadastrados.DoSearch(const ASearch: TCosmosSearch;
  AParams: TCosmosData);
begin
//Executa a pesquisa no servidor remoto passando todos os argumentos de busca.
 if Assigned(CdsSearchData) then FreeAndNil(CdsSearchData);

 CdsSearchData := TClientDataset.Create(self);
 CdsSearchData.DisableControls;

 try
  ICosmosApp.IRemoteCon.ExecuteDQL(ASearch, AParams.Data, CdsSearchData);

 finally
  DsrData.DataSet := CdsSearchData;
  CdsSearchData.EnableControls;
  ActiveDataset := CdsSearchData;
 end;
end;

function TFrmPesquisarCadastrados.Execute(CosmosSearch: TCosmosSearch): boolean;
begin
 self.DoSearch(CosmosSearch);
 Result := ShowModal = mrOK;
end;

procedure TFrmPesquisarCadastrados.EdtArgumentoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
 if (ssCtrl in Shift) and (Key = 13) then
  SbnExecute.Click;
end;

function TFrmPesquisarCadastrados.Execute: boolean;
begin
 Result := ShowModal = mrOK;
end;

procedure TFrmPesquisarCadastrados.FmeGridSearch1DBGrid1DblClick(
  Sender: TObject);
begin
  inherited;
  if (ActiveDataset <> nil) and (ActiveDataset.Active) and not (ActiveDataset.IsEmpty) then
   ActSelect.Execute;
end;

procedure TFrmPesquisarCadastrados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 SaveMyOptions;
end;

procedure TFrmPesquisarCadastrados.FormCreate(Sender: TObject);
begin
  inherited;
 FCampoTrabalho := ctAll;
 ListFocos;
 ReadMyOptions;
 FmeGridSearch1.SearchFields := 'nomcad';
end;

function TFrmPesquisarCadastrados.GetActiveFocus: boolean;
begin
 Result := FActiveFocus;
end;

function TFrmPesquisarCadastrados.GetCampoTrabalho: TCampoTrabalho;
begin
 Result := FCampoTrabalho;
end;

function TFrmPesquisarCadastrados.GetDataset: TDataset;
begin
 Result := ActiveDataset;
end;

function TFrmPesquisarCadastrados.GetSexoCadastrado: TSexoCadastrado;
begin
 Result := FSexoCadastrado;
end;

function TFrmPesquisarCadastrados.GetStatusCadastrado: TStatusCadastrado;
begin
 Result := FStatusCadastrado;
end;

function TFrmPesquisarCadastrados.GetValue(FieldName: string): Variant;
begin
 if (ActiveDataset <> nil) and (ActiveDataset.Active) then
  begin
    if ActiveDataset.FindField(FieldName) <> nil then
     Result := ActiveDataset.Fields.FieldByName(FieldName).Value
    else
     Result := null;
  end
 else
  Result := unassigned;
end;

function TFrmPesquisarCadastrados.GetWindowsId: string;
begin
 Result := '{DE9271FD-BE8B-4747-BB9D-EA6F577AA393}';
end;

procedure TFrmPesquisarCadastrados.ListFocos;
var
 ADataset : TClientDataset;
begin
 if (ActiveFocus) and (ICosmosApp.ActiveFocus <> nil) then
  begin
   CBXFocos.Items.Add(ICosmosApp.ActiveFocus.FocusName);
   CBXFocos.Values.Add(IntToStr(ICosmosApp.ActiveFocus.FocusID));
   CBXFocos.ItemIndex := 0;
   Exit;
  end;

  ADataset := TClientDataset.Create(nil);

 try
  ADataset := ICosmosApp.IRemoteCon.OpenBufferedData(TCosmosFiles.BufFocos);
  if Assigned(ADataset) and  ADataset.Active then
   begin
    ADataset.Filter := Format('INDATI = %s', [QuotedStr('S')]); //do not localize!
    ADataset.Filtered := True;
    ADataset.IndexFieldNames := 'NOMFOC'; //do not localize!

    while not ADataset.Eof do
     begin
      CBXFocos.Items.Add(ADataset.Fields.FieldByName('nomfoc').AsString); //do not localize!
      CBXFocos.Values.Add(ADataset.Fields.FieldByName('codfoc').AsString); //do not localize!
      ADataset.Next;
     end;

    //Adiciona o item para seleção de todos os focos.
    CBXFocos.Items.Add(TCosmosGUIElements.TodosFocos);
    CBXFocos.Values.Add('');

    if Assigned(ADataset) then FreeAndNil(ADataset);
   end;

 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);

  if (ICosmosApp.ActiveFocus <> nil) then
   begin
    CBXFocos.Items.Add(ICosmosApp.ActiveFocus.FocusName);
    CBXFocos.Values.Add(IntToStr(ICosmosApp.ActiveFocus.FocusID));
    CBXFocos.ItemIndex := CBXFocos.Items.IndexOf(ICosmosApp.ActiveFocus.FocusName)
   end
  else
   CBXFocos.ItemIndex := 0; //Primeiro foco da lista.
 end;

end;

procedure TFrmPesquisarCadastrados.ReadMyOptions;
var
 sMyRootKey: string;
begin
 try
  OptionsSaver.CloseKey;
  OptionsSaver.Open(TRegistryPaths.CurrentUserKey);
  sMyRootKey := TRegistryPaths.Windows + '\' + WindowsId;
  OptionsSaver.OpenKey(sMyRootKey, True);

  if OptionsSaver.ValueExists('SearchFieldID') then
    CBXPesquisa.ItemIndex := OptionsSaver.ReadInteger('SearchFieldID');

 finally
  OptionsSaver.CloseKey;
 end;
end;

procedure TFrmPesquisarCadastrados.SaveMyOptions;
var
 sMyRootKey: string;
begin
 try
  OptionsSaver.CloseKey;
  OptionsSaver.Open(TRegistryPaths.CurrentUserKey);
  sMyRootKey := TRegistryPaths.Windows + '\' + WindowsId;
  OptionsSaver.OpenKey(sMyRootKey, True);

  OptionsSaver.WriteInteger('SearchFieldID', CBXPesquisa.ItemIndex);

 finally
  OptionsSaver.CloseKey;
 end;
end;

procedure TFrmPesquisarCadastrados.SbnExecuteClick(Sender: TObject);
var
ASearch: TCosmosSearch;
AParams: TCosmosData;
AFieldName, AStatusCad: string;
AFieldValue: variant;
FocoSelecionado: boolean;
begin
  inherited;

 //Primeiro, verifica se todos os argumentos foram fornecidos.
  if (CBXPesquisa.Enabled) and (Trim(CBXPesquisa.Text) = '') then
   begin
    ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.PesquisaDados, TCosmosWarningMsg.EmptyArgument);
    Exit;
   end;

  if (EdtArgumento.Enabled) and (Trim(EdtArgumento.Text) = '') then
   begin
    ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.PesquisaDados, TCosmosWarningMsg.EmptyArgument);
    Exit;
   end;

  if (CBXFocos.Enabled) and (CBXFocos.ItemIndex < 0) then
   begin
    ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.PesquisaDados, TCosmosWarningMsg.EmptyFocus);
    Exit;
   end;

 //Determina se a pesquisa será feita em apenas um foco ou em todos.
  FocoSelecionado := CBXFocos.GetValue <> '';

  //Obtém o nome do campo que será usado: nome, matrícula ou apelido
  case CbxPesquisa.ItemIndex of
   0: AFieldName := 'MATCAD';
   1: AFieldName := 'NOMCAD';
   2: AFieldName := 'APECAD';
  end;

  //Obtém o valor do argumento de busca...
  AFieldValue := TrimRight(EdtArgumento.Text);
  AFieldValue := QuotedStr(AFieldValue + '%');

  //Formata o status do cadastrado (Ativo, inativo ou indiferente).
  case self.StatusCadastrado of
   scAtivo: AStatusCad := '= ' + QuotedStr('S');
   scInativo: AStatusCad := '= ' + QuotedStr('N');
   scQualquer: AStatusCad := 'is not null';
  end;

  //Foco e qualquer campo de trabalho e qualquer sexo.
  if (FocoSelecionado = True) and (self.CampoTrabalho = ctAll) and (self.SexoCadastrado = scTodos) then
   begin
     ASearch := csCadastradoFoco;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('CODFOC', StrToInt(CBXFocos.GetValue));
     AParams.WriteValue('AFIELDNAME', AFieldName , 1);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 2);

     AParams.WriteValue('INDATI', AStatusCad, 3);
   end;

  //Foco e campo de trabalho definido.
  if (FocoSelecionado = True) and (self.CampoTrabalho <> ctAll) and (self.SexoCadastrado = scTodos) then
   begin
     ASearch := csCadastradoCampoFoco;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('CODFOC', StrToInt(CBXFocos.GetValue));
     AParams.WriteValue('AFIELDNAME', AFieldName, 1);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 2);

     AFieldValue := TFocusTypesInfo.CampoTrabalhoToString(self.CampoTrabalho);
     AParams.WriteValue('CAMPO', QuotedStr(AFieldValue), 3);

     AParams.WriteValue('INDATI', AStatusCad, 4);
   end;

  //Foco e sexo definidos.
  if (FocoSelecionado = True) and (self.CampoTrabalho = ctAll) and (self.SexoCadastrado <> scTodos) then
   begin
     ASearch := csCadastradoSexoFoco;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('CODFOC', StrToInt(CBXFocos.GetValue));
     AParams.WriteValue('AFIELDNAME', AFieldName, 1);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 2);

     case self.SexoCadastrado of
       scMasculino: AParams.WriteValue('SEXO', QuotedStr('M'), 3);
       scFeminino: AParams.WriteValue('SEXO', QuotedStr('F'), 3);
     end;

     AParams.WriteValue('INDATI', AStatusCad, 4);
   end;

  //Foco, campo de trabalho e sexo definidos.
  if (FocoSelecionado = True) and (self.CampoTrabalho <> ctAll) and (self.SexoCadastrado <> scTodos) then
   begin
     ASearch := csCadastradoCampoSexoFoco;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('CODFOC', StrToInt(CBXFocos.GetValue));
     AParams.WriteValue('AFIELDNAME', AFieldName, 1);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 2);

     AFieldValue := TFocusTypesInfo.CampoTrabalhoToString(self.CampoTrabalho);
     AParams.WriteValue('CAMPO', QuotedStr(AFieldValue), 3);

     case self.SexoCadastrado of
       scMasculino: AParams.WriteValue('SEXO', QuotedStr('M'), 4);
       scFeminino: AParams.WriteValue('SEXO', QuotedStr('F'), 4);
     end;

     AParams.WriteValue('INDATI', AStatusCad, 5);
   end;

  //Somente nome, matrícula ou apelido de todos os focos
  if (FocoSelecionado = False) and (self.CampoTrabalho = ctAll) and (self.SexoCadastrado = scTodos) then
   begin
     ASearch := csCadastrado;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('AFIELDNAME', AFieldName);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 1);

     AParams.WriteValue('INDATI', AStatusCad, 2);
   end;

  //Campo de trabalho definido de todos os focos.
  if (FocoSelecionado = False) and (self.CampoTrabalho <> ctAll) and (self.SexoCadastrado = scTodos) then
   begin
     ASearch := csCadastradoCampo;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('AFIELDNAME', AFieldName);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 1);

     AFieldValue := TFocusTypesInfo.CampoTrabalhoToString(self.CampoTrabalho);
     AParams.WriteValue('CAMPO', QuotedStr(AFieldValue), 2);

     AParams.WriteValue('INDATI', AStatusCad, 3);
   end;

  //Sexo definido de todos os focos.
  if (FocoSelecionado = False) and (self.CampoTrabalho = ctAll) and (self.SexoCadastrado <> scTodos) then
   begin
     ASearch := csCadastradoSexo;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('AFIELDNAME', AFieldName);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 1);

     case self.SexoCadastrado of
       scMasculino: AParams.WriteValue('SEXO', QuotedStr('M'), 2);
       scFeminino: AParams.WriteValue('SEXO', QuotedStr('F'), 2);
     end;

     AParams.WriteValue('INDATI', AStatusCad, 3);
   end;

  //Campo de trabalho e sexo definidos de todos os focos.
  if (FocoSelecionado = False) and (self.CampoTrabalho <> ctAll) and (self.SexoCadastrado <> scTodos) then
   begin
     ASearch := csCadastradoCampoSexo;
     AParams := TCosmosData.Create(10);

     AParams.WriteValue('AFIELDNAME', AFieldName);
     AParams.WriteValue('AFIELDVALUE', AFieldValue, 1);

     AFieldValue := TFocusTypesInfo.CampoTrabalhoToString(self.CampoTrabalho);
     AParams.WriteValue('CAMPO', QuotedStr(AFieldValue), 2);

     case self.SexoCadastrado of
       scMasculino: AParams.WriteValue('SEXO', QuotedStr('M'), 3);
       scFeminino: AParams.WriteValue('SEXO', QuotedStr('F'), 3);
     end;

     AParams.WriteValue('INDATI', AStatusCad, 4);
   end;

 //Finalmente, executa a pesquisa...
 DoSearch(ASearch, AParams);
end;

procedure TFrmPesquisarCadastrados.SetActiveFocus(const Value: boolean);
begin
 FActiveFocus := Value;
 //Caso ACtiveFocos seja True desabilita o controle de seleção de focos.
 CBXFocos.Enabled := not FActiveFocus;
end;

procedure TFrmPesquisarCadastrados.SetCampoTrabalho(value: TCampoTrabalho);
begin
 FCampoTrabalho := Value;
end;

procedure TFrmPesquisarCadastrados.SetCurrentSearch(const Value: TCosmosSearch);
begin
  FCurrentSearch := Value;
  case FCurrentSearch of
   csJovensAlunos:
    begin
      CBXPesquisa.Enabled := False;
      EdtArgumento.Enabled := False;
      CBXFocos.Enabled := False;
    end;
   csJovensAlunosFoco:
    begin
      CBXPesquisa.Enabled := False;
      EdtArgumento.Enabled := False;
      CBXFocos.Enabled := True;
    end;
  end;
end;

procedure TFrmPesquisarCadastrados.SetSexoCadastrado(const Value: TSexoCadastrado);
begin
 if FSexoCadastrado <> Value then
  FSexoCadastrado := Value;
end;

procedure TFrmPesquisarCadastrados.SetStatusCadastrado(Value: TStatusCadastrado);
begin
 FStatusCadastrado := Value;
end;

initialization
 RegisterClass(TFrmPesquisarCadastrados);

finalization
 UnRegisterClass(TFrmPesquisarCadastrados);

end.
