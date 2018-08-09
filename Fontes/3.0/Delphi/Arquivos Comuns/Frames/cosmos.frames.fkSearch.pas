unit cosmos.frames.fkSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Mask, Data.DB, Vcl.DBCtrls, Cosmos.classes.ServerInterface,
  Datasnap.DBClient, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  Cosmos.system.messages, Cosmos.classes.application,
  cosmos.business.focos, cosmos.Framework.forms.datadialogs,
  cosmos.Framework.forms.conferencias, cosmos.Framework.forms.financeiro,
  cosmos.Framework.forms.logradouros, cosmos.Framework.forms.focos;

type
  EUnknowDataTarget = Exception;
  EInactiveDataTarget = Exception;

  TFmeFKSearch = class(TFrame)
    EdtData: TDBEdit;
    SpeedButton1: TSpeedButton;
    procedure EdtDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FCosmosSearch: TCosmosSearch;
    FFullScan: boolean;
    FCodeField: string;
    FDefaultText: string;
    FDefaultCode: Variant;
    FOnSelectData: TNotifyEvent;
    function GetButtonEnabled: boolean;
    function GetDataset: TDataset;
    procedure SetButtonEnabled(const Value: boolean);
    procedure DoSearchEstados(const codpai: integer; nompai: string);
    procedure DoSearchCidades(const codest: integer; nomest: string);
    procedure DoSearchBairros(const codcid: integer; nomcid: string);
    function LoadDialog(const ModuleName: TFileName; ModuleClass: string;
      out Module: HModule): TForm;

    procedure SearchEstados;
    procedure SearchCidades;
    procedure SearchBairros;
    procedure SearchMeiosContatos;
    procedure SearchProfissoes;
    procedure SearchTiposEventosTP;
    procedure SearchEnfermidades;
    procedure SearchCargos;
    procedure SearchFuncoes;
    procedure SearchAreasAptidoes;
    procedure SearchAlocucoes;
    procedure SearchTipoAtuacao;
    procedure SearchTurmasTP;
    procedure SearchCartasTP;
    procedure SearchTiposEventosDiscipulares;
    procedure DoSimpleCosmosSearch(const CosmosSearch: TCosmosSearch; Params: TCosmosData); overload;
    procedure DoSimpleCosmosSearch(const CosmosSearch: TCosmosSearch; SearchParams: TSQLParams;
      Fields: TCosmosData); overload;


  public
    { Public declarations }
    SQLSearch: string;
    procedure DoClick;
    procedure SetValues(const code, value: variant); overload;
    procedure SetValues(const Field: TField; Value: variant); overload;
    procedure SetValues(const FieldName: string; Value: variant); overload;
    procedure SetValues(Source: TDataset); overload;
    procedure SetValues(AData: TCosmosData; Source: TDataset); overload;
    procedure SetValues(AData: TCosmosData); overload;

    procedure Configure(const CodeField: string; Search: TCosmosSearch);

  published
   property ButtonEnabled: boolean read GetButtonEnabled write SetButtonEnabled;
   property CodeField: string read FCodeField write FCodeField;
   property Dataset: TDataset read GetDataset;
   property DefaultCode: Variant read FDefaultCode;
   property DefaultText: string read FDefaultText;
   property CosmosSearch: TCosmosSearch read FCosmosSearch write FCosmosSearch;
   property FullScan: boolean read FFullScan write FFullScan;
   property OnSelectData: TNotifyEvent read FOnSelectData write FOnSelectData;
  end;

implementation


{$R *.dfm}

procedure TFmeFKSearch.Configure(const CodeField: string;
  Search: TCosmosSearch);
begin
//Configura todas as propriedades do frame em um só método
 FCodeField := CodeField;
 CosmosSearch := Search;
 FullScan := True;
end;

procedure TFmeFKSearch.DoCLick;
begin
 SpeedButton1.Click;
end;

procedure TFmeFKSearch.DoSimpleCosmosSearch(const CosmosSearch: TCosmosSearch;
  Params: TCosmosData);
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);
 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(CosmosSearch, null) then
       SetValues(Params, ISimpleSearch.Dataset);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.DoSearchBairros(const codcid: integer; nomcid: string);
var
ISearch: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('pesest.bpl',  'TFrmSearch' , AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchLocais;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute(csBairros) then
        SetValues(ISearch.Dataset);
     end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.DoSearchCidades(const codest: integer; nomest: string);
var
ISearch: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('pesest.bpl', 'TFrmSearch', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchLocais;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute(csCidades) then
       SetValues(ISearch.Dataset);
     end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.DoSearchEstados(const codpai: integer; nompai: string);
var
ISearch: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('pesest.bpl', 'TFrmSearch', AModule);
 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchLocais;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute(csEstados) then
       begin
        SetValues(ISearch.Dataset.Fields.FieldByName('codest').Value,
         ISearch.Dataset.Fields.FieldByName('sigest').Value);
       end;
     end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.DoSimpleCosmosSearch(const CosmosSearch: TCosmosSearch;
  SearchParams: TSQLParams; Fields: TCosmosData);
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);
 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(CosmosSearch, SearchParams.Params) then
       SetValues(Fields, ISimpleSearch.Dataset);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;

end;

procedure TFmeFKSearch.EdtDataKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  DoClick;
end;

function TFmeFKSearch.GetButtonEnabled: boolean;
begin
 Result := SpeedButton1.Enabled;
end;

function TFmeFKSearch.GetDataset: TDataset;
begin
 if EdtData.DataSource <> nil then
  Result := EdtData.DataSource.DataSet
 else
  Result := nil;
end;

function TFmeFKSearch.LoadDialog(const ModuleName: TFileName;
  ModuleClass: string; out Module: HModule): TForm;
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  Result := ICosmosApp.LoadDialog(ModuleName, ModuleClass, Module)

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

procedure TFmeFKSearch.SearchAlocucoes;
var
ISearch: ISearchAlocucoes;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('pesaloc.bpl', 'TFrmPesquisarAlocucoes', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchAlocucoes;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute then
       begin
        SetValues(ISearch.Dataset.Fields.FieldByName('codalo').Value,
          ISearch.Dataset.Fields.FieldByName('titalo').Value);
       end;
     end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchAreasAptidoes;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csAreasAptidoes, null) then
        SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codare').Value,
          ISimpleSearch.Dataset.Fields.FieldByName('desare').Value);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchBairros;
var
ISearch: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('pesest.bpl', 'TFrmSearch', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchLocais;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute(csBairros) then
        SetValues(ISearch.Dataset);
     end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchCargos;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csCargos, null) then
       SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codcar').Value,
         ISimpleSearch.Dataset.Fields.FieldByName('descar').Value);
      end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchCartasTP;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csCartasTP, null) then
       begin
        SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codtipeve').Value,
           ISimpleSearch.Dataset.Fields.FieldByName('destipeve').Value);
        SetValues('camtra', ISimpleSearch.Dataset.Fields.FieldByName('camtra').Value);
        SetValues('tipeve', ISimpleSearch.Dataset.Fields.FieldByName('tipeve').Value);
       end;
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchCidades;
var
codest: integer;
nomest: string;
Dataset: TDataset;
begin
 Dataset := EdtData.DataSource.DataSet;
 if Dataset <> nil then
   DoSearchCidades(codest, nomest);
end;

procedure TFmeFKSearch.SearchEnfermidades;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csEnfermidades, null) then
       SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codenf').Value,
        ISimpleSearch.Dataset.Fields.FieldByName('nomenf').Value);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchEstados;
var
codpai: integer;
nompai: string;
Dataset: TDataset;
ICosmosApp: ICosmosApplication;
begin
 Dataset := EdtData.DataSource.DataSet;
 with Dataset do
  begin
   if Dataset <> nil then
    begin
     if (FindField('codpai') <> nil) and not (FindField('codpai').IsNull) then
      begin
       codpai := Fields.FieldByName('codpai').AsInteger;
       if FindField('nompai') <> nil then
        nompai := Fields.FieldByName('nompai').AsString;

       DoSearchEstados(codpai, nompai);
      end
     else
      begin
       ICosmosApp := Application.MainForm as ICosmosApplication;
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SelectData, TCosmosErrorMsg.PaisEstado);

       ICosmosApp := nil;
       Exit;
     end;
    end;
  end;
end;

procedure TFmeFKSearch.SearchFuncoes;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csFuncoes, null) then
       SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codfun').Value,
        ISimpleSearch.Dataset.Fields.FieldByName('desfun').Value);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchMeiosContatos;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csMeiosContatos, null) then
       SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codtipcon').Value,
        ISimpleSearch.Dataset.Fields.FieldByName('destipcon').Value);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchProfissoes;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csProfissoes, null) then
       SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codpro').Value,
         ISimpleSearch.Dataset.Fields.FieldByName('despro').Value);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchTipoAtuacao;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csTipoAtuacao, null) then
       SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codtipatu').Value,
        ISimpleSearch.Dataset.Fields.FieldByName('destipatu').Value);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchTiposEventosDiscipulares;
var
ISearch: ISearchTiposEventosDiscipulares;
AModule: HModule;
AForm: TForm;
Dataset: TDataset;
I: integer;
Field: TField;
begin

 AForm := self.LoadDialog('pestipeve.bpl', 'TFrmSearchTiposEventos', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchTiposEventosDiscipulares;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute then
       begin
        Dataset := EdtData.DataSource.DataSet;
        for I := 0 to Pred(ISearch.Dataset.FieldCount) do
         begin
          Field := Dataset.FindField(ISearch.Dataset.Fields.Fields[I].FieldName);
          if Field <> nil then
            begin
             Dataset.Edit;
             Field.Value := ISearch.Dataset.Fields.Fields[I].Value;
            end;
         end;
           //Dispara o evento...
        if Assigned(FOnSelectData) then
         FOnSelectData(self);
       end;
      end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchTiposEventosTP;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csTiposEventosTP, null) then
       SetValues(ISimpleSearch.Dataset.Fields.FieldByName('codtipeve').Value,
         ISimpleSearch.Dataset.Fields.FieldByName('destipeve').Value);
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SearchTurmasTP;
var
ISearch: ISearchTurmasTP;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('pestur.bpl', 'TFrmPesquisarTurmasTP', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchTurmasTP;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute then
        SetValues(ISearch.Dataset.Fields.FieldByName('codtur').Value,
          ISearch.Dataset.Fields.FieldByName('numtur').Value);
     end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFmeFKSearch.SetValues(const FieldName: string; Value: variant);
var
Dataset: TDataset;
Field: TField;
begin
 Dataset := EdtData.DataSource.DataSet;
 Field := Dataset.FindField(FieldName);

 if Field <> nil then
  begin
   if Field.DataSet.State = dsBrowse then
    Field.DataSet.Edit;
   Field.Value := Value;
  end;
end;

procedure TFmeFKSearch.SetValues(const Field: TField; Value: variant);
begin
 if Field <> nil then
  begin
   if Field.DataSet.State = dsBrowse then
    Field.DataSet.Edit;
   Field.Value := Value;
  end;
end;

procedure TFmeFKSearch.SetValues(const code, value: variant);
var
Field: TField;
Dataset: TDataset;
begin
 FDefaultCode := Code;
 FDefaultText := Value;
 Dataset := EdtData.DataSource.DataSet;
 if not Assigned(Dataset) then
  Exit;
 Field := DataSet.FindField(CodeField);
 if Field <> nil then
  begin
   if Dataset.State = dsBrowse then
    Dataset.Edit;
   Field.Value := Code;
   EdtData.Field.Value := Value;
  end; 
end;

procedure TFmeFKSearch.SpeedButton1Click(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
Dataset: TDataset;
FieldsData: TCosmosData;
AParams: TSQLParams;
begin
 Dataset := EdtData.DataSource.DataSet;
 if not Assigned(Dataset) then
  exit;

 try
  case CosmosSearch of
   csLogradouros:
    begin
     FieldsData := TCosmosLocaisDialogs.SelecionarLogradouro;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csAlunos:
    begin
     FieldsData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, scTodos, False);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csDiscipuladosEI:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarDiscipulados([ctEI]);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csDiscipuladosEE:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarDiscipulados([ctLectorium]);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csDiscipuladosLectorium:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarDiscipulados([ctLectorium, ctEI]);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csDiscipuladosTM:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarDiscipulados([ctTM]);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csDiscipuladosTMB:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarDiscipulados([ctTMB]);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csDiscipulados:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarDiscipulados([ctLectorium, ctTM, ctTMB, ctTP, ctEI]);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csLicoesEI:
    begin
     FieldsData := TCosmosEscolaInternaDialogs.SelecionarLicaoEI;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csPaises:
    begin
     FieldsData := TCosmosLocaisDialogs.SelecionarPaises;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csEstados: SearchEstados;
   csCidades: SearchCidades;
   csBairros: SearchBairros;
   csMeiosContatos: SearchMeiosContatos;
   csProfissoes: SearchProfissoes;
   csTiposEventosTP: SearchTiposEventosTP;
   csFocos:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarFocos;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csFocosAlunos:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarFocosAlunos;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csFocosPesquisadores:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarFocosPesquisadores;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csAlunoTitular:
    begin
     FieldsData := TCosmosCadastradosDialogs.SelecionarAlunoTitular;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csEnfermidades: SearchEnfermidades;
   csCargos: SearchCargos;
   csFuncoes: SearchFuncoes;
   csAreasAptidoes: SearchAreasAptidoes;
   csTiposAtividades:
    begin
     FieldsData := TCosmosAtividadesDialogs.SelecionarTiposAtividades([ctLectorium, ctTM, ctTP, ctSimpatizantes, ctEI], ctLectorium);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csTiposAtividadesTM:
    begin
     FieldsData := TCosmosAtividadesDialogs.SelecionarTiposAtividades([ctTM], ctTM);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csTiposAtividadesTMB:
    begin
     FieldsData := TCosmosAtividadesDialogs.SelecionarTiposAtividades([ctTMB], ctTMB);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csTiposAtividadesTP:
    begin
     FieldsData := TCosmosAtividadesDialogs.SelecionarTiposAtividades([ctTP], ctTP);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csTiposAtividadesEI:
    begin
     FieldsData := TCosmosAtividadesDialogs.SelecionarTiposAtividades([ctEI], ctEI);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csTiposAtividadesSimpatizantes:
    begin
     FieldsData := TCosmosAtividadesDialogs.SelecionarTiposAtividades([ctSimpatizantes, ctTP], ctSimpatizantes);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csAlocucoes: SearchAlocucoes;
   csCadastrados:
    begin
     FieldsData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctAll, scTodos, False);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csTipoAtuacao: SearchTipoAtuacao;
   csCirculoEI:
    begin
     FieldsData := TCosmosEscolaInternaDialogs.SelecionarCirculoEI;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csTurmasTP: SearchTurmasTP;
   csRegioes:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarRegioesAdministrativas;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csFocosDependentes:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarFocosTitulares;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csFocosAtivos:
    begin
     FieldsData := TCosmosFocosDialogs.SelecionarFocosAtivos;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csOrgaosSuperiores: ; //To do.
   csOrgaosGestores: ;//To do.
   csAlunosHomens:
    begin
     FieldsData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, scMasculino, False);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csAlunosMulheres:
    begin
     FieldsData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, scFeminino, False);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csMentoresEI:
    begin
     FieldsData := TCosmosEscolaInternaDialogs.SelecionarMentoresEI(scMasculino);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csMentorasEI:
    begin
     FieldsData := TCosmosEscolaInternaDialogs.SelecionarMentoresEI(scFeminino);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csCartasTP: SearchCartasTP;
   csConferencias:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarConferencia(ctAll, True);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csConferenciasLEC:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarConferencia(ctLectorium, True);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csConferenciasTMO:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarConferencia(ctTM, True);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csConferenciasTMB:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarConferencia(ctTMB, True);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csConferenciasTPU:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarConferencia(ctTP, True);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csConferenciasEI:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarConferencia(ctEI, True);
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csPlanoContas:
    begin
     FieldsData := TCosmosPlanoContasDialogs.SelecionarConta;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csEventosDiscipulares: self.SearchTiposEventosDiscipulares;
   csClassificadoresLeitos:
    begin
     FieldsData := TCosmosData.Create(3);
     FieldsData.Add('codatr', 'codatr');
     FieldsData.Add('desatrlei', 'desatrlei');
     FieldsData.Add('sigatr', 'sigatr');
     self.DoSimpleCosmosSearch(CosmosSearch, FieldsData);
    end;
   csClassificadoresCadastrados:
    begin
     FieldsData := TCosmosData.Create(3);
     FieldsData.Add('codatr', 'codatr');
     FieldsData.Add('desatrcad', 'desatrcad');
     FieldsData.Add('sigatr', 'sigatr');
     self.DoSimpleCosmosSearch(CosmosSearch, FieldsData);
    end;
   csQuartosAlojamento:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarQuartosAlojamento;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csLeitosAlojamento:
    begin
     FieldsData := TCosmosConferenciasDialogs.SelecionarLeitosAlojamento;
     if Assigned(FieldsData) then
      SetValues(FieldsData);
    end;
   csAlojamentosFoco:
    begin
     ICosmosApp := Application.MainForm as ICosmosApplication;
     AParams := TSQLParams.Create(1);
     AParams.AppendData(ICosmosApp.ActiveFocus.FocusID);

     FieldsData := TCosmosData.Create(2);
     FieldsData.Add('codalo', 'codalo');
     FieldsData.Add('nomalo', 'nomalo');

     self.DoSimpleCosmosSearch(CosmosSearch, AParams, FieldsData);
    end;
   csGeneralFlagsInscricoes:
    begin
     FieldsData := TCosmosData.Create(2);
     FieldsData.Add('codfla', 'codfla');
     FieldsData.Add('desfla', 'desfla');

     self.DoSimpleCosmosSearch(CosmosSearch, FieldsData);
    end;
  end;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Assigned(AParams) then FreeAndNil(AParams);
 end;
end;

procedure TFmeFKSearch.SetButtonEnabled(const Value: boolean);
begin
 SpeedButton1.Visible := Value;
{ if value = False then
  EdtData.Color := clBtnFace
 else
  EdtData.Color := clWindow; }
end;

procedure TFmeFKSearch.SetValues(Source: TDataset);
var
Dest: TDataset;
Field: TField;
I: integer;
begin
 Dest := EdtData.DataSource.DataSet;
 if Dest.State = dsbrowse then
  Dest.Edit;

 for I  := 0 to Pred(Source.Fields.Count) do
   begin
    Field := Dest.FindField(Source.Fields.Fields[I].FieldName);
    if Field <> nil then
     Field.Value := Source.Fields.Fields[I].Value;
   end;
end;

procedure TFmeFKSearch.SetValues(AData: TCosmosData; Source: TDataset);
var
ADataset: TDataset;
AParamValues: variant;
ASourceField, ADestField: string;
I: integer;
ICosmosApp: ICosmosApplication;
begin
//Aplica os valores nos campos de destino a partir da dataset de pesquisa.
 ADataset := self.EdtData.DataSource.DataSet;

 if ADataset = nil then
  raise EUnknowDataTarget.Create(TCosmosErrorMsg.UnknowDataTarget);

 if not ADataset.Active then
  raise EInactiveDataTarget.Create(TCosmosErrorMsg.InactiveDataTarget);

 if ADataset.State = dsbrowse then
  ADataset.Edit;

 try
  for I := 0 to AData.DataCount do
   begin
    AParamValues := AData.Read(I);

    ASourceField := AParamValues[0];
    ADestField := AParamValues[1];

    if (ASourceField <> '') and (ADestField <> '') then
     begin
       if (ADataset.Fields.FindField(ADestField) <> nil) and (Source.Fields.FindField(ASourceField) <> nil) then
         ADataset.FieldValues[ADestField] := Source.FieldValues[ASourceField];
     end;
   end;

 except
  on E: Exception do
   begin
    ICosmosApp := Application.MainForm as ICosmosApplication;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.PesquisaDados, E.Message);
    if Assigned(ICosmosApp) then ICosmosApp := nil;
   end;
 end;
end;

procedure TFmeFKSearch.SetValues(AData: TCosmosData);
var
I: integer;
ADataset: TDataset;
AFieldName: variant;
ICosmosApp: ICosmosApplication;
begin
{Aplica os valores no dataset de destino a partir da estrutura de dados
 retornada da pesquisa.}
 ADataset := self.EdtData.DataSource.DataSet;

 if ADataset = nil then
  raise EUnknowDataTarget.Create(TCosmosErrorMsg.UnknowDataTarget);

 if not ADataset.Active then
  raise EInactiveDataTarget.Create(TCosmosErrorMsg.InactiveDataTarget);

 if ADataset.State = dsbrowse then
  ADataset.Edit;

 try
  for I := 0 to AData.DataCount do
   begin
    AFieldName := AData.FindFieldName(I);
    if (AFieldName <> null) and (ADataset.Fields.FindField(AFieldName) <> nil) then
     ADataset.Fields.FieldByName(AFieldName).Value := AData.FindValue(VarToStr(AFieldName));
   end;

 except
  on E: Exception do
   begin
    ICosmosApp := Application.MainForm as ICosmosApplication;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.PesquisaDados, E.Message);
    if Assigned(ICosmosApp) then ICosmosApp := nil;
   end;
 end;
end;

end.
