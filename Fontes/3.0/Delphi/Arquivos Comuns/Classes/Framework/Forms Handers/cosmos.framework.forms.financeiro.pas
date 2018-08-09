unit cosmos.framework.forms.financeiro;

interface

uses
 Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
 cosmos.classes.application, cosmos.business.focos, cosmos.framework.interfaces.Dialogs, variants,
 cosmos.framework.forms.datadialogs, cosmos.classes.ServerInterface;

type
 //Plano de Contas
 TCosmosPlanoContasDialogs = class(TCosmosDataDialogs)

  class function SelecionarConta: TCosmosData;

end;

implementation

{ TCosmosPlanoContasDialogs }

class function TCosmosPlanoContasDialogs.SelecionarConta: TCosmosData;
var
ISearch: ISearchPlanoContas;
AModule: HModule;
AForm: TForm;
begin
 Result := nil;
 AForm := self.LoadDialog('pesctas.bpl', 'TFrmPesquisarContas', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISearch := AForm as ISearchPlanoContas;
    if Assigned(ISearch) then
     begin
      ISearch.Visao := vpHierarquico;
      if ISearch.Execute then
       begin
        Result := TCosmosData.Create(2);
        Result.WriteValue('CODCON', ISearch.GetValue('CODCON'));
        Result.WriteValue('DESCON', ISearch.GetValue('DESCON'), 1);
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
