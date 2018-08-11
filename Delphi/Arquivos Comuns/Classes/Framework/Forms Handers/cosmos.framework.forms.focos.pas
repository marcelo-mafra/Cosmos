unit cosmos.framework.forms.focos;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
  cosmos.classes.application, cosmos.framework.interfaces.root,
  cosmos.framework.interfaces.dialogs, cosmos.business.focos, cosmos.classes.security,
  cosmos.classes.ServerInterface, System.Variants,
  cosmos.system.messages, cosmos.framework.forms.datadialogs;

type

 //Focos...
 TCosmosFocosDialogs = class(TCosmosDataDialogs)

   class function SelecionarRegioesAdministrativas: TCosmosData;
   class function SelecionarFocos: TCosmosData;
   class function SelecionarDiscipulados(Discipulados: TCamposTrabalho): TCosmosData;
   class function SelecionarFocosAtivos: TCosmosData;
   class function SelecionarFocosTitulares: TCosmosData;
   class function SelecionarFocosAlunos: TCosmosData;
   class function SelecionarFocosPesquisadores: TCosmosData;

 end;

 //Cadastrados

implementation

{ TCosmosDataDialogs }

class function TCosmosFocosDialogs.SelecionarDiscipulados(
  Discipulados: TCamposTrabalho): TCosmosData;
var
ISearch: ISearchDiscipulados;
AModule: HModule;
AForm: TForm;
vLec, vTM, vTMB, vTP, vEI: boolean;
begin
 Result := nil;
 AForm := self.LoadDialog('pesdis.bpl', 'TFrmPesquisarDiscipulados', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchDiscipulados;
    if Assigned(ISearch) then
     begin
      vLec := ctLectorium in Discipulados;
      vTM := ctTM in Discipulados;
      vTMB := ctTMB in Discipulados;
      vTP := ctTP in Discipulados;
      vEI := ctEI in Discipulados;

      if ISearch.Execute(vLec, vTM, vTMB, vTP, vEI) then
       begin
        Result := TCosmosData.Create(3);
        Result.WriteValue('CODDIS', ISearch.GetValue('coddis'));
        Result.WriteValue('SIGDIS', ISearch.GetValue('sigdis'), 1);
        Result.WriteValue('NOMDIS', ISearch.GetValue('nomdis'), 2);
       end;
     end;
   end;

 finally
  if Assigned(ISearch) then ISearch := nil;
  if Assigned(AForm) then FreeAndNil(AForm);
  if AModule <> 0 then UnloadPackage(AModule);
 end;
end;

class function TCosmosFocosDialogs.SelecionarFocos: TCosmosData;
var
IFocosSearch: IPesquisaFocosRAs;
AModule: HModule;
AForm: TForm;
NucleosSet: TTipoFocoSet;
begin
 NucleosSet := [tfSedeInternacional, tfSedeNacional, tfCentro, tfNucleoCentro,
    tfNucleo, tfSala, tfLocal];

 AForm := self.LoadDialog('pesfoc.bpl', 'TFrmPesquisarFocos', AModule);
 Result := nil;

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    IFocosSearch := AForm as IPesquisaFocosRAs;
    if Assigned(IFocosSearch) then
     begin
      if IFocosSearch.ExecuteSearch(tlSequencial, NucleosSet, True) <> nil then
       begin
        Result := TCosmosData.Create(3);
        Result.WriteValue('CODFOC', IFocosSearch.SelectedElement.FocusID);
        Result.WriteValue('NOMFOC', IFocosSearch.SelectedElement.FocusName, 1);
        Result.WriteValue('SIGFOC', TFocus(IFocosSearch.SelectedElement).Sigla, 2);
       end;
     end;
   end;

  finally
   if Assigned(IFocosSearch) then IFocosSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosFocosDialogs.SelecionarFocosAlunos: TCosmosData;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 //Seleciona apenas focos que contenham alunos a eles vinculados.
 Result := nil;
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csFocosAlunos, null) then
       begin
        Result := TCosmosData.Create(3);
        Result.WriteValue('CODFOC', ISimpleSearch.GetValue('CODFOC'));
        Result.WriteValue('NOMFOC', ISimpleSearch.GetValue('NOMFOC'), 1);
        Result.WriteValue('SIGFOC', ISimpleSearch.GetValue('SIGFOC'), 2);
       end;
      end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosFocosDialogs.SelecionarFocosAtivos: TCosmosData;
var
IFocosSearch: IPesquisaFocosRAs;
AModule: HModule;
AForm: TForm;
AFoco: TCustomFocus;
ICosmosApp: ICosmosApplication;
NucleosSet: TTipoFocoSet;
begin
 NucleosSet := [tfSedeInternacional, tfSedeNacional, tfCentro, tfNucleoCentro,
    tfNucleo, tfSala, tfLocal];

 Result := nil;
 AForm := self.LoadDialog('pesfoc.bpl', 'TFrmPesquisarFocos', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
    begin
     IFocosSearch := AForm as IPesquisaFocosRAs;
     if Assigned(IFocosSearch) then
      begin
       IFocosSearch.ShowMenu := True;
       AFoco := IFocosSearch.ExecuteSearch(tlTitularFocus, NucleosSet, True);
       if AFoco <> nil then
        begin
         if not (AFoco is TRegiaoAdministrativa) then
          begin
           Result := TCosmosData.Create(3);
           Result.WriteValue('CODFOC', TFocus(AFoco).FocusID);
           Result.WriteValue('NOMFOC', TFocus(AFoco).FocusName, 1);
           Result.WriteValue('SIGFOC', TFocus(AFoco).Sigla, 2);
          end
         else
          begin
           ICosmosApp := Application.MainForm as ICosmosApplication;
           ICosmosApp.DlgMessage.Execute(TCosmosTitles.FocosSearch, TCosmosInfoMsg.PesquisaFocoNoRa, mtInformation);
          end;
        end;
      end;
    end;

  finally
   if Assigned(IFocosSearch) then IFocosSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if Assigned(ICosmosApp) then ICosmosApp := nil;

   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosFocosDialogs.SelecionarFocosPesquisadores: TCosmosData;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
 //Seleciona apenas focos que contenham pesquisadores a eles vinculados.
 Result := nil;
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csFocosPesquisadores, null) then
       begin
        Result := TCosmosData.Create(3);
        Result.WriteValue('CODFOC', ISimpleSearch.GetValue('CODFOC'));
        Result.WriteValue('NOMFOC', ISimpleSearch.GetValue('NOMFOC'), 1);
        Result.WriteValue('SIGFOC', ISimpleSearch.GetValue('SIGFOC'), 2);
       end;
      end;
   end;

  finally
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosFocosDialogs.SelecionarFocosTitulares: TCosmosData;
var
IFocosSearch: IPesquisaFocosRAs;
AModule: HModule;
AForm: TForm;
AFoco: TCustomFocus;
ICosmosApp: ICosmosApplication;
NucleosSet: TTipoFocoSet;
begin
 NucleosSet := [tfSedeInternacional, tfSedeNacional, tfCentro, tfNucleoCentro,
    tfNucleo, tfSala, tfLocal];
 Result := nil;
 AForm := self.LoadDialog('pesfoc.bpl', 'TFrmPesquisarFocos', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
    begin
     IFocosSearch := AForm as IPesquisaFocosRAs;
     if Assigned(IFocosSearch) then
      begin
       IFocosSearch.ShowMenu := True;
       AFoco := IFocosSearch.ExecuteSearch(tlTitularFocus, NucleosSet, True);
       if AFoco <> nil then
        if AFoco is TFocus then
          begin
           Result := TCosmosData.Create(3);
           Result.WriteValue('FOCPAI', AFoco.FocusID);
           Result.WriteValue('NOMPAI', AFoco.FocusName, 1);
          end
        else
         begin
          ICosmosApp := Application.MainForm as ICosmosApplication;
          ICosmosApp.DlgMessage.Execute(TCosmosTitles.FocosSearch, TCosmosInfoMsg.PesquisaFocoNoRa, mtInformation);
         end;
      end;
    end;

  finally
   if Assigned(IFocosSearch) then IFocosSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if Assigned(ICosmosApp) then ICosmosApp := nil;
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosFocosDialogs.SelecionarRegioesAdministrativas: TCosmosData;
var
IFocosSearch: IPesquisaFocosRAs;
AModule: HModule;
AForm: TForm;
ARa: TCustomFocus;
ICosmosApp: ICosmosApplication;
begin
 //Pesquisa por regiões administrativas.
 Result := nil;
 AForm := self.LoadDialog('pesfoc.bpl', 'TFrmPesquisarFocos', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
    begin
     IFocosSearch := AForm as IPesquisaFocosRAs;
     if Assigned(IFocosSearch) then
      begin
       IFocosSearch.ShowMenu := False;
       ARa := IFocosSearch.ExecuteSearch(tlRa, [tfRA], False);
       if (ARa <> nil) and (ARa is TRegiaoAdministrativa) then
         begin
          Result := TCosmosData.Create(5);
          Result.WriteValue('CODREG', ARa.FocusID);
          Result.WriteValue('NOMREG', ARa.FocusName, 1);
          Result.WriteValue('CODPAI', null, 2);
          Result.WriteValue('NOMPAI', null, 3);

          if TRegiaoAdministrativa(ARa).Parent <> nil then
           begin
            Result.WriteValue('CODPAI', TRegiaoAdministrativa(ARa).Parent.FocusID, 2);
            Result.WriteValue('NOMPAI', TRegiaoAdministrativa(ARa).Parent.FocusName, 3);
           end;
         end
        else
         begin
          ICosmosApp := Application.MainForm as ICosmosApplication;
          ICosmosApp.DlgMessage.Execute(TCosmosTitles.RaSearch, TCosmosInfoMsg.PesquisaRaNoFoco, mtInformation);
         end;
      end;
    end;

  finally
   if Assigned(IFocosSearch) then IFocosSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if Assigned(ICosmosApp) then ICosmosApp := nil;
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;



end.
