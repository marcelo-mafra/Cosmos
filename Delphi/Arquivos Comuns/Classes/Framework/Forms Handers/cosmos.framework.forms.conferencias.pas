unit cosmos.framework.forms.conferencias;

interface

uses
 Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
 cosmos.classes.application, cosmos.business.focos, cosmos.framework.interfaces.root,
 cosmos.framework.interfaces.Dialogs, System.Variants,
 cosmos.framework.forms.datadialogs, cosmos.classes.ServerInterface;

type

 //Conferências...
 TCosmosConferenciasDialogs = class(TCosmosDataDialogs)

   class function SelecionarConferencia(Campo: TCampoTrabalho; FocoAtivo: boolean): TCosmosData;
   //Alojamentos
   class function SelecionarQuartosAlojamento: TCosmosData;
   class function SelecionarLeitosAlojamento: TCosmosData;
   class function SelecionarAlojamento: TCosmosData;
   //Isncritos
   class function SelecionarInscrito: TCosmosData;
   class function SelecionarInformacaoInscrito: TCosmosData;
 end;

implementation

class function TCosmosConferenciasDialogs.SelecionarAlojamento: TCosmosData;
var
ISearch: IPesquisarAlojamentos;
AModule: HModule;
AClass: TInterfacedPersistent;
begin
 Result := nil;
 AClass := self.LoadClass('pesalo.bpl', 'TPesquisasAlojamentos', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
    begin
     ISearch := AClass as IPesquisarAlojamentos;
     if Assigned(ISearch) then
      begin
       Result := ISearch.PesquisarAlojamentos;
      end;
    end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosConferenciasDialogs.SelecionarConferencia(Campo: TCampoTrabalho;
  FocoAtivo: boolean): TCosmosData;
var
 AModule: HModule;
 AForm: TForm;
 IPesquisa: IPesquisaConferencias;
begin
 inherited;
 AForm := LoadDialog('pescon.bpl','TFrmPesquisarConferencias', AModule);
 Result := nil;

 try
  if AForm <> nil then
   begin
    with AForm do
      begin
       if Supports(AForm, IPesquisaConferencias) then
        begin
         IPesquisa := AForm as IPesquisaConferencias;
         IPesquisa.ActiveFocus := FocoAtivo;
         IPesquisa.CampoTrabalho := Campo;
         if IPesquisa.Execute then
          begin
           Result := TCosmosData.Create(10);
           Result.WriteValue('CODCON', IPesquisa.GetValue('CODCON'));
           Result.WriteValue('NOMCON', IPesquisa.GetValue('NOMCON'), 1);
           Result.WriteValue('CAMCON', IPesquisa.GetValue('CAMCON'), 2);
           Result.WriteValue('NOMFOC', IPesquisa.GetValue('NOMFOC'), 3);
           Result.WriteValue('DATINI', IPesquisa.GetValue('DATINI'), 4);
           Result.WriteValue('DATTER', IPesquisa.GetValue('DATTER'), 5);
           Result.WriteValue('STACON', IPesquisa.GetValue('STACON'), 6);
           Result.WriteValue('NOMFOC', IPesquisa.GetValue('NOMFOC'), 7);
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

class function TCosmosConferenciasDialogs.SelecionarInformacaoInscrito: TCosmosData;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
AParams, AData: TCosmosData;
ICosmosApp: ICosmosApplication;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);
 AParams := TCosmosData.Create(5);
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      AParams.WriteValue('CODFOC', ICosmosApp.ActiveFocus.FocusID);
      if ISimpleSearch.ExecuteSearch(csFlagsInscricoes, AParams.Data) then
       begin
         AData := TCosmosData.Create(5);
         AData.WriteValue('CODITE', ISimpleSearch.GetValue('CODITE'));
         AData.WriteValue('DESFLA', ISimpleSearch.GetValue('DESFLA'), 1);
         AData.WriteValue('DESIMP', ISimpleSearch.GetValue('DESIMP'), 2);
       end;
     end;
   end;

   Result := AData;

  finally
   if Assigned(ICosmosApp) then ICosmosApp := nil;
   if Assigned(AParams) then FreeAndNil(AParams);
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosConferenciasDialogs.SelecionarInscrito: TCosmosData;
var
ISearch: ICosmosDataSearch;
AModule: HModule;
AForm: TForm;
AData: TCosmosData;
begin
 AForm := self.LoadDialog('pesinsc.bpl', 'TFrmPesquisarInscritos', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
    begin
     ISearch := AForm as ICosmosDataSearch;
     if Assigned(ISearch) then
      begin
       if ISearch.ExecuteSearch(csFocosConferencias, null) then
        begin
         AData := TCosmosData.Create(7);
         AData.WriteValue('CODINS', ISearch.GetValue('CODINS'));
         AData.WriteValue('MATCAD', ISearch.GetValue('MATCAD'), 1);
         AData.WriteValue('NOMCAD', ISearch.GetValue('NOMCAD'), 2);
         AData.WriteValue('NUMINS', ISearch.GetValue('NUMINS'), 3);
        end;
      end;
    end;

   Result := AData;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;

end;

class function TCosmosConferenciasDialogs.SelecionarLeitosAlojamento: TCosmosData;
var
ISearch: IPesquisarAlojamentos;
AModule: HModule;
AClass: TInterfacedPersistent;
begin
 Result := nil;
 AClass := self.LoadClass('pesalo.bpl', 'TPesquisasAlojamentos', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
    begin
     ISearch := AClass as IPesquisarAlojamentos;
     if Assigned(ISearch) then
      begin
       Result := ISearch.PesquisarLeitos;
      end;
    end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosConferenciasDialogs.SelecionarQuartosAlojamento: TCosmosData;
var
ISearch: IPesquisarAlojamentos;
AModule: HModule;
AClass: TInterfacedPersistent;
begin
 Result := nil;
 AClass := self.LoadClass('pesalo.bpl', 'TPesquisasAlojamentos', AModule);

 try
  if (AModule <> 0) and (AClass <> nil) then
    begin
     ISearch := AClass as IPesquisarAlojamentos;
     if Assigned(ISearch) then
      begin
       Result := ISearch.PesquisarQuartos;
      end;
    end;

  finally
   if Assigned(ISearch) then ISearch := nil;
   if Assigned(AClass) then FreeAndNil(AClass);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

end.
