unit cosmos.framework.forms.datadialogs;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
  cosmos.classes.application, cosmos.framework.interfaces.root,
  cosmos.framework.interfaces.dialogs, cosmos.business.focos, System.Variants,
  cosmos.classes.ServerInterface, cosmos.classes.security,
  cosmos.system.messages;

type

 TCosmosDataDialogs = class

   class function LoadDialog(const ModuleName: TFileName; ModuleClass: string;
     out Module: HModule): TForm;
   class function LoadClass(const ModuleName: TFileName; ModuleClass: string;
     out Module: HModule): TInterfacedPersistent;
 end;

//Cadastrados
 TCosmosCadastradosDialogs = class(TCosmosDataDialogs)

   class function SelecionarFocosAlunos: TCosmosData;
   class function SelecionarCadastrado(Campo: TCampoTrabalho): TCosmosData; overload;
   class function SelecionarCadastrado(Campo: TCampoTrabalho;
     Sexo: TSexoCadastrado; FocoAtivo: boolean): TCosmosData; overload;
   class function SelecionarAlunoTitular: TCosmosData;
   class function SelecionarMatriculas(Campo: TCampoTrabalho): TCosmosData;

 end;

 //Escola Interna
 TCosmosEscolaInternaDialogs = class(TCosmosDataDialogs)

   class function SelecionarMentoresEI(Sexo: TSexoCadastrado): TCosmosData;
   class function SelecionarCirculoEI: TCosmosData;
   class function SelecionarLicaoEI: TCosmosData;
 end;

 //Agenda de atividades...
 TCosmosAtividadesDialogs = class(TCosmosDataDialogs)

   class function SelecionarTiposAtividades(Campos: TCamposTrabalho;
       Default: TCampoTrabalho): TCosmosData;
   class function SelecionarAtividades: TCosmosData;
   class function SelecionarAtividadesCampo(Campo: TCampoTrabalho): TCosmosData;
 end;

 //Vários dialogs..
 TCosmosUtilitiesDialogs = class(TCosmosDataDialogs)

   class function SelecionarData(CurrentDate: Variant): Variant; overload;
   class function SelecionarData: TCosmosData; overload;

 end;

implementation

uses Cosmos.Common.View.FormCalendar;

{ TCosmosDataDialogs }

class function TCosmosDataDialogs.LoadClass(const ModuleName: TFileName;
  ModuleClass: string; out Module: HModule): TInterfacedPersistent;
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  Result := ICosmosApp.LoadClass(ModuleName, ModuleClass, Module)

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

class function TCosmosDataDialogs.LoadDialog(const ModuleName: TFileName;
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

class function TCosmosAtividadesDialogs.SelecionarAtividades: TCosmosData;
var
ISearch: ISearchAtividades;
AModule: HModule;
AForm: TForm;
begin
 AForm := LoadDialog('pesati.bpl','TFrmPesquisarAtividades', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ISearchAtividades) then
        ISearch := AForm as ISearchAtividades;
       if Assigned(ISearch) then
        begin
         if ISearch.Execute then
          begin
           Result := TCosmosData.Create(13);
           Result.WriteValue('CODATI', ISearch.GetValue('CODATI'));
           Result.WriteValue('CODTIPATI', ISearch.GetValue('CODTIPATI'), 1);
           Result.WriteValue('DESTIPATI', ISearch.GetValue('DESTIPATI'), 2);
           Result.WriteValue('DATATI', ISearch.GetValue('DATATI'), 3);
           Result.WriteValue('HORATI', ISearch.GetValue('HORATI'), 4);
           Result.WriteValue('CODCON', ISearch.GetValue('CODCON'), 5);
           Result.WriteValue('NOMCON', ISearch.GetValue('NOMCON'), 6);
           Result.WriteValue('TIPLEV', ISearch.GetValue('TIPLEV'), 7);
           Result.WriteValue('CODFOC', ISearch.GetValue('CODFOC'), 8);
           Result.WriteValue('SIGFOC', ISearch.GetValue('SIGFOC'), 9);
           Result.WriteValue('CAMPRO', ISearch.GetValue('CAMPRO'), 10);
           Result.WriteValue('CODGRU', ISearch.GetValue('CODGRU'), 11);
           Result.WriteValue('INDESCINT', ISearch.GetValue('INDESCINT'), 12);
          end;
        end;

       Free;
      end;
   end;

  finally
   if Assigned(ISearch) then
    ISearch := nil;
   if AModule <> 0 then
    UnloadPackage(AModule);
  end;
end;

class function TCosmosAtividadesDialogs.SelecionarAtividadesCampo(
  Campo: TCampoTrabalho): TCosmosData;
var
ISearch: ISearchAtividades;
AModule: HModule;
AForm: TForm;
begin
 AForm := LoadDialog('pesati.bpl', 'TFrmPesquisarAtividades', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ISearchAtividades) then
        ISearch := AForm as ISearchAtividades;
       if Assigned(ISearch) then
        begin
         if ISearch.Execute(Campo) then
          begin
           Result := TCosmosData.Create(13);
           Result.WriteValue('CODATI', ISearch.GetValue('CODATI'));
           Result.WriteValue('CODTIPATI', ISearch.GetValue('CODTIPATI'), 1);
           Result.WriteValue('DESTIPATI', ISearch.GetValue('DESTIPATI'), 2);
           Result.WriteValue('DATATI', ISearch.GetValue('DATATI'), 3);
           Result.WriteValue('HORATI', ISearch.GetValue('HORATI'), 4);
           Result.WriteValue('CODCON', ISearch.GetValue('CODCON'), 5);
           Result.WriteValue('NOMCON', ISearch.GetValue('NOMCON'), 6);
           Result.WriteValue('TIPLEV', ISearch.GetValue('TIPLEV'), 7);
           Result.WriteValue('CODFOC', ISearch.GetValue('CODFOC'), 8);
           Result.WriteValue('SIGFOC', ISearch.GetValue('SIGFOC'), 9);
           Result.WriteValue('CAMPRO', ISearch.GetValue('CAMPRO'), 10);
           Result.WriteValue('CODGRU', ISearch.GetValue('CODGRU'), 11);
           Result.WriteValue('INDESCINT', ISearch.GetValue('INDESCINT'), 12);
          end;
        end;

       Free;
      end;
   end;

  finally
   if Assigned(ISearch) then
    ISearch := nil;
   if AModule <> 0 then
    UnloadPackage(AModule);
  end;
end;

class function TCosmosCadastradosDialogs.SelecionarAlunoTitular: TCosmosData;
var
 AModule: HModule;
 AForm: TForm;
 IPesquisa: IPesquisaCadastrados;
begin
 inherited;
 AForm := LoadDialog('pescad.bpl', 'TFrmPesquisarCadastrados', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, IPesquisaCadastrados) then
        begin
         IPesquisa := AForm as IPesquisaCadastrados;
         IPesquisa.ActiveFocus := False;
         IPesquisa.SexoCadastrado := scTodos;
         IPesquisa.CampoTrabalho := ctLectorium;
         Ipesquisa.StatusCadastrado := scAtivo;

         if IPesquisa.Execute then
          begin
           Result := TCosmosData.Create(2);
           Result.WriteValue('CADTIT', IPesquisa.GetValue('CODCAD'));
           Result.WriteValue('NOMTIT', IPesquisa.GetValue('NOMCAD'), 1);
          end;
         end;
       Free;
      end;
   end;

 finally
  if Assigned(IPesquisa) then
   IPesquisa := nil;
  UnloadPackage(AModule);
 end;
end;

class function TCosmosCadastradosDialogs.SelecionarCadastrado(Campo: TCampoTrabalho;
  Sexo: TSexoCadastrado; FocoAtivo: boolean): TCosmosData;
var
 AModule: HModule;
 AForm: TForm;
 IPesquisa: IPesquisaCadastrados;
begin
 inherited;
 AForm := LoadDialog('pescad.bpl', 'TFrmPesquisarCadastrados', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, IPesquisaCadastrados) then
        begin
         IPesquisa := AForm as IPesquisaCadastrados;
         IPesquisa.ActiveFocus := FocoAtivo;
         IPesquisa.SexoCadastrado := Sexo;
         IPesquisa.CampoTrabalho := Campo;
         if IPesquisa.Execute then
          begin
           Result := TCosmosData.Create(9);
           Result.WriteValue('CODCAD', IPesquisa.GetValue('CODCAD'));
           Result.WriteValue('MATCAD', IPesquisa.GetValue('MATCAD'), 1);
           Result.WriteValue('NOMCAD', IPesquisa.GetValue('NOMCAD'), 2);
           Result.WriteValue('APECAD', IPesquisa.GetValue('APECAD'), 3);
           Result.WriteValue('CODDIS', IPesquisa.GetValue('CODDIS'), 4);
           Result.WriteValue('SIGDIS', IPesquisa.GetValue('SIGDIS'), 5);
           Result.WriteValue('CODFOC', IPesquisa.GetValue('CODFOC'), 6);
           Result.WriteValue('SIGFOC', IPesquisa.GetValue('SIGFOC'), 7);
           Result.WriteValue('MATCADINT', IPesquisa.GetValue('MATCADINT'), 8);
          end;

         end;
       Free;
      end;
   end;

 finally
  if Assigned(IPesquisa) then
   IPesquisa := nil;
  UnloadPackage(AModule);
 end;
end;

class function TCosmosEscolaInternaDialogs.SelecionarCirculoEI: TCosmosData;
var
ISearch: ISearchCirculosEI;
AModule: HModule;
AForm: TForm;
begin
 AForm := LoadDialog('pescir.bpl', 'TFrmPesquisaCirculosEI', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ISearchCirculosEI) then
        ISearch := AForm as ISearchCirculosEI;
       if Assigned(ISearch) then
        begin
         if ISearch.Execute then
          begin
           Result := TCosmosData.Create(6);
           Result.WriteValue('CODGRU', ISearch.GetValue('CODGRU'));
           Result.WriteValue('NOMGRU', ISearch.GetValue('NOMGRU'), 1);
           Result.WriteValue('SIGDIS', ISearch.GetValue('SIGDIS'), 2);
           Result.WriteValue('NOMDIS', ISearch.GetValue('NOMDIS'), 3);
           Result.WriteValue('NOMLIV', ISearch.GetValue('NOMLIV'), 4);
           Result.WriteValue('NOMLIC', ISearch.GetValue('NOMLIC'), 5);
          end;
        end;

       Free;
      end;
   end;

  finally
   if Assigned(ISearch) then
    ISearch := nil;
   if AModule <> 0 then
    UnloadPackage(AModule);
  end;
end;

class function TCosmosUtilitiesDialogs.SelecionarData: TCosmosData;
var
AValue: variant;
begin
 Result := nil;

 if not Assigned(FrmCalendar) then
  FrmCalendar := TFrmCalendar.Create(nil);

 try
  FrmCalendar.Calendar.Date := Now;
  AValue := FrmCalendar.ShowCalendar;

  if AValue <> null then
    begin
     Result := TCosmosData.Create(1);
     Result.WriteValue('SELDAT', AValue);
    end;

 finally
  if Assigned(FrmCalendar) then
   FreeAndNil(FrmCalendar);
 end;
end;

class function TCosmosUtilitiesDialogs.SelecionarData(CurrentDate: Variant): Variant;
var
ADate: TDate;
begin
 Result := null;

 if not Assigned(FrmCalendar) then
  FrmCalendar := TFrmCalendar.Create(nil);

 try
  if CurrentDate <> null then
   FrmCalendar.Calendar.Date := CurrentDate
  else
   FrmCalendar.Calendar.Date := Now;

  if FrmCalendar.ShowCalendar(ADate) then
   Result := ADate;

 finally
  if Assigned(FrmCalendar) then
   FreeAndNil(FrmCalendar);
 end;
end;

class function TCosmosCadastradosDialogs.SelecionarFocosAlunos: TCosmosData;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csFocosAlunos, null) then
       begin
        Result := TCosmosData.Create(3);
        Result.WriteValue('CODFOC', ISimpleSearch.GetValue('codfoc'));
        Result.WriteValue('NOMFOC', ISimpleSearch.GetValue('nomfoc'), 1);
        Result.WriteValue('SIGFOC', ISimpleSearch.GetValue('sigfoc'), 2);
       end;
     end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosCadastradosDialogs.SelecionarMatriculas(
  Campo: TCampoTrabalho): TCosmosData;
var
 AModule: HModule;
 AForm: TForm;
 IPesquisa: IPesquisaCadastradosMultiplos;
begin
 inherited;
 AForm := LoadDialog('selcad.bpl', 'TFrmSelectCadastrados', AModule);
 Result := nil;
 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, IPesquisaCadastradosMultiplos) then
        begin
         IPesquisa := AForm as IPesquisaCadastradosMultiplos;
         IPesquisa.CampoTrabalho := Campo;

         if IPesquisa.Execute then
          begin
           Result := TCosmosData.Create(2);
           case Campo of
             ctLectorium: Result.WriteValue('MATRICULAS', IPesquisa.GetMatriculas);
             ctTM: Result.WriteValue('MATRICULAS-TM', IPesquisa.GetMatriculas);
             ctTMB: Result.WriteValue('MATRICULAS-TMB', IPesquisa.GetMatriculas);
           end;
          end;
        end;
       Free;
      end;
   end;

 finally
  if Assigned(IPesquisa) then
   IPesquisa := nil;
  UnloadPackage(AModule);
 end;
end;

class function TCosmosEscolaInternaDialogs.SelecionarLicaoEI: TCosmosData;
var
ISearch: ICosmosLocateLessosEI;
AModule: HModule;
AForm: TForm;
begin
 Result := nil;
 AForm := self.LoadDialog('dlglicoes.bpl', 'TFrmLicoesEI', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ICosmosLocateLessosEI;
    if Assigned(ISearch) then
     begin
      if ISearch.GetLessonEI then
       begin
        Result := TCosmosData.Create(2);
        Result.WriteValue('CODLIC', ISearch.SelectedID);
        Result.WriteValue('NOMLIC', ISearch.SelectedText, 1);
       end;
     end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosEscolaInternaDialogs.SelecionarMentoresEI(
  Sexo: TSexoCadastrado): TCosmosData;
var
 AModule: HModule;
 AForm: TForm;
 IPesquisa: IPesquisaCadastrados;
begin
 inherited;
 AForm := LoadDialog('pescad.bpl', 'TFrmPesquisarCadastrados', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, IPesquisaCadastrados) then
        begin
         IPesquisa := AForm as IPesquisaCadastrados;
         IPesquisa.ActiveFocus := False;
         IPesquisa.SexoCadastrado := Sexo;
         IPesquisa.CampoTrabalho := ctLectorium;
         IPesquisa.StatusCadastrado := scAtivo;

         if IPesquisa.Execute then
          begin
           Result := TCosmosData.Create(7);
           if Sexo = scFeminino then
            begin
             Result.WriteValue('codsaz', IPesquisa.GetValue('CODCAD'));
             Result.WriteValue('nomsaz', IPesquisa.GetValue('NOMCAD'), 1);
             Result.WriteValue('matsaz', IPesquisa.GetValue('MATCAD'), 2);
             Result.WriteValue('sigdissaz', IPesquisa.GetValue('SIGDIS'), 3);
             Result.WriteValue('nomdissaz', IPesquisa.GetValue('NOMDIS'), 4);
             Result.WriteValue('sigfocsaz', IPesquisa.GetValue('SIGFOC'), 5);
             Result.WriteValue('nomfocsaz', IPesquisa.GetValue('NOMFOC'), 6);
            end
           else
            begin
             Result.WriteValue('codsac', IPesquisa.GetValue('CODCAD'));
             Result.WriteValue('nomsac', IPesquisa.GetValue('NOMCAD'), 1);
             Result.WriteValue('matsac', IPesquisa.GetValue('MATCAD'), 2);
             Result.WriteValue('sigdissac', IPesquisa.GetValue('SIGDIS'), 3);
             Result.WriteValue('nomdissac', IPesquisa.GetValue('NOMDIS'), 4);
             Result.WriteValue('sigfocsac', IPesquisa.GetValue('SIGFOC'), 5);
             Result.WriteValue('nomfocsac', IPesquisa.GetValue('NOMFOC'), 6);
            end;
          end;
        end;
       Free;
      end;
   end;

 finally
  if Assigned(IPesquisa) then
   IPesquisa := nil;
  UnloadPackage(AModule);
 end;
end;

class function TCosmosCadastradosDialogs.SelecionarCadastrado(
  Campo: TCampoTrabalho): TCosmosData;
var
 AModule: HModule;
 AForm: TForm;
 IPesquisa: IPesquisaCadastrados;
begin
 inherited;
 AForm := LoadDialog('pescad.bpl', 'TFrmPesquisarCadastrados', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, IPesquisaCadastrados) then
        begin
         IPesquisa := AForm as IPesquisaCadastrados;
         IPesquisa.ActiveFocus := True;
         IPesquisa.SexoCadastrado := scTodos;
         IPesquisa.CampoTrabalho := Campo;
         if IPesquisa.Execute then
          begin
           Result := TCosmosData.Create(9);
           Result.WriteValue('CODCAD', IPesquisa.GetValue('CODCAD'));
           Result.WriteValue('MATCAD', IPesquisa.GetValue('MATCAD'), 1);
           Result.WriteValue('NOMCAD', IPesquisa.GetValue('NOMCAD'), 2);
           Result.WriteValue('APECAD', IPesquisa.GetValue('APECAD'), 3);
           Result.WriteValue('CODDIS', IPesquisa.GetValue('CODDIS'), 4);
           Result.WriteValue('SIGDIS', IPesquisa.GetValue('SIGDIS'), 5);
           Result.WriteValue('CODFOC', IPesquisa.GetValue('CODFOC'), 6);
           Result.WriteValue('SIGFOC', IPesquisa.GetValue('SIGFOC'), 7);
           Result.WriteValue('MATCADINT', IPesquisa.GetValue('MATCADINT'), 8);
          end;

         end;
       Free;
      end;
   end;

 finally
  if Assigned(IPesquisa) then
   IPesquisa := nil;
  UnloadPackage(AModule);
 end;
end;

{ TCosmosAtividadesDialogs }

class function TCosmosAtividadesDialogs.SelecionarTiposAtividades(
  Campos: TCamposTrabalho; Default: TCampoTrabalho): TCosmosData;
var
ISearch: ISearchTiposAtividades;
AModule: HModule;
AForm: TForm;
begin
 Result := nil;
 AForm := self.LoadDialog('tiposati.bpl', 'TFrmSearchTiposAti', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchTiposAtividades;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute(Campos, Default) then
       begin
        Result := TCosmosData.Create(10);
        Result.WriteValue('CODTIPATI', ISearch.GetValue('CODTIPATI'));
        Result.WriteValue('DESTIPATI', ISearch.GetValue('DESTIPATI'), 1);
        Result.WriteValue('CAMPRO', ISearch.GetValue('CAMPRO'), 2);
        Result.WriteValue('HORATI', ISearch.GetValue('HORATI'), 3);
        Result.WriteValue('INDFRE', ISearch.GetValue('INDFRE'), 4);
       end;
      end;
   end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;





end.
