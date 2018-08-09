unit cosmos.framework.forms.logradouros;

interface

uses
 Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
 cosmos.classes.application, cosmos.business.focos,  System.Variants,
 cosmos.framework.interfaces.Dialogs, cosmos.framework.forms.datadialogs,
 cosmos.classes.ServerInterface;

type
 TCosmosLocaisDialogs = class(TCosmosDataDialogs)

  class function SelecionarPaises: TCosmosData;
  class function SelecionarEstados: TCosmosData;
  class function SelecionarCidades: TCosmosData;
  class function SelecionarBairros: TCosmosData;
  class function SelecionarLogradouro: TCosmosData;
 end;

implementation

{ TCosmosLocaisDialogs }

class function TCosmosLocaisDialogs.SelecionarBairros: TCosmosData;
var
ILocais: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
//Seleciona um bairro...
  Result := nil;
  AForm := self.LoadDialog('pesest.bpl', 'TFrmSearch', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ISearchLocais) then
        ILocais := AForm as ISearchLocais;
       if Assigned(ILocais) then
         if ILocais.Execute(csBairros) then
          begin
           Result := TCosmosData.Create(10);
           Result.WriteValue('codbai', ILocais.GetValue('codbai'));
           Result.WriteValue('nombai', ILocais.GetValue('nombai'), 1);
           Result.WriteValue('codcid', ILocais.GetValue('codcid'), 2);
           Result.WriteValue('nomcid', ILocais.GetValue('nomcid'), 3);
           Result.WriteValue('codest', ILocais.GetValue('codest'), 4);
           Result.WriteValue('nomest', ILocais.GetValue('nomest'), 5);
           Result.WriteValue('codpai', ILocais.GetValue('codpai'), 6);
           Result.WriteValue('nompai', ILocais.GetValue('nompai'), 7);
          end;
      end;
    end;

 finally
   if Assigned(ILocais) then ILocais := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosLocaisDialogs.SelecionarCidades: TCosmosData;
var
ILocais: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
//Seleciona uma cidade...
  Result := nil;
  AForm := self.LoadDialog('pesest.bpl', 'TFrmSearch', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ISearchLocais) then
        ILocais := AForm as ISearchLocais;
       if Assigned(ILocais) then
         if ILocais.Execute(csCidades) then
          begin
           Result := TCosmosData.Create(10);
           Result.WriteValue('codcid', ILocais.GetValue('codcid'));
           Result.WriteValue('nomcid', ILocais.GetValue('nomcid'), 1);
           Result.WriteValue('codest', ILocais.GetValue('codest'), 2);
           Result.WriteValue('nomest', ILocais.GetValue('nomest'), 3);
           Result.WriteValue('codpai', ILocais.GetValue('codpai'), 4);
           Result.WriteValue('nompai', ILocais.GetValue('nompai'), 5);
          end;
      end;
    end;

 finally
   if Assigned(ILocais) then ILocais := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosLocaisDialogs.SelecionarEstados: TCosmosData;
var
ILocais: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
//Seleciona um estado de um país..
  Result := nil;
  AForm := self.LoadDialog('pesest.bpl', 'TFrmSearch', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ISearchLocais) then
        ILocais := AForm as ISearchLocais;
       if Assigned(ILocais) then
         if ILocais.Execute(csEstados) then
          begin
           Result := TCosmosData.Create(5);
           Result.WriteValue('codest', ILocais.GetValue('codest'));
           Result.WriteValue('nomest', ILocais.GetValue('nomest'), 1);
           Result.WriteValue('codpai', ILocais.GetValue('codpai'), 2);
           Result.WriteValue('nompai', ILocais.GetValue('nompai'), 3);
          end;
      end;
    end;

 finally
   if Assigned(ILocais) then ILocais := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosLocaisDialogs.SelecionarLogradouro: TCosmosData;
var
ILogradouros: ICosmosLocateLogradouros;
AModule: HModule;
AForm: TForm;
begin
//Seleciona um logradouro..
  Result := nil;
  AForm := self.LoadDialog('peslog.bpl', 'TFrmSearchLogradouro', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       if Supports(AForm, ICosmosLocateLogradouros) then
        ILogradouros := AForm as ICosmosLocateLogradouros;
       if Assigned(ILogradouros) then
         if ILogradouros.Execute(emSelectData) then
          begin
           Result := TCosmosData.Create(10);
           Result.WriteValue('CODLOG', ILogradouros.GetValue('CODLOG'));
           Result.WriteValue('NOMLOG', ILogradouros.GetValue('NOMLOG'), 1);
           Result.WriteValue('CEPLOG', ILogradouros.GetValue('CEPLOG'), 2);
           Result.WriteValue('CODBAI', ILogradouros.GetValue('CODBAI'), 3);
           Result.WriteValue('NOMBAI', ILogradouros.GetValue('NOMBAI'), 4);
           Result.WriteValue('CODCID', ILogradouros.GetValue('CODCID'), 5);
           Result.WriteValue('NOMCID', ILogradouros.GetValue('NOMCID'), 6);
           Result.WriteValue('NOMEST', ILogradouros.GetValue('NOMEST'), 7);
           Result.WriteValue('SIGEST', ILogradouros.GetValue('SIGEST'), 8);
           Result.WriteValue('NOMPAI', ILogradouros.GetValue('NOMPAI'), 9);
          end;
      end;
    end;

 finally
   if Assigned(ILogradouros) then ILogradouros := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

class function TCosmosLocaisDialogs.SelecionarPaises: TCosmosData;
var
ISearch: ISearchLocais;
AModule: HModule;
AForm: TForm;
begin
 Result := nil;
 AForm := self.LoadDialog('pesest.bpl', 'TFrmSearch', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchLocais;
    if Assigned(ISearch) then
     begin
      if ISearch.Execute(csPaises) then
       begin
        Result := TCosmosData.Create(2);
        Result.WriteValue('CODPAI', ISearch.GetValue('CODPAI'));
        Result.WriteValue('NOMPAI', ISearch.GetValue('NOMPAI'), 1);
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
