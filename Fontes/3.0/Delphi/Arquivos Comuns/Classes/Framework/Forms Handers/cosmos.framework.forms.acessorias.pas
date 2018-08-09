unit cosmos.framework.forms.acessorias;

interface

uses
 Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
 cosmos.classes.application, cosmos.business.focos, System.Variants,
 cosmos.framework.interfaces.Dialogs, cosmos.framework.forms.datadialogs,
 cosmos.classes.ServerInterface;

type
 //Pesquisas acessórias
 TCosmosAcessoriasDialogs = class(TCosmosDataDialogs)

  class function InputData(const Caption, LabelInfo: string; MaxLength: integer): string;
  class function SelecionarProfissoes: TCosmosData;

end;

implementation

{ TCosmosAcessoriasDialogs }

uses Cosmos.Common.View.FormInputString;

class function TCosmosAcessoriasDialogs.InputData(const Caption,
  LabelInfo: string; MaxLength: integer): string;
var
 FrmInputString: TFrmInputString;
begin
  //Exibe a janela de input simples de dado.
  FrmInputString := TFrmInputString.Create(Application);

  try
    Result := FrmInputString.InputData(Caption, LabelInfo, MaxLength);

  finally
   if Assigned(FrmInputString) then FreeAndNil(FrmInputString);
  end;
end;

class function TCosmosAcessoriasDialogs.SelecionarProfissoes: TCosmosData;
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
AData: TCosmosData;
begin
 AForm := self.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);

 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
    ISimpleSearch := AForm as ICosmosSimpleSearch;
    if Assigned(ISimpleSearch) then
     begin
      if ISimpleSearch.ExecuteSearch(csProfissoes, null) then
       begin
        AData := TCosmosData.Create(2);
        AData.WriteValue('codpro', ISimpleSearch.Dataset.Fields.FieldByName('codpro').Value);
        AData.WriteValue('despro', ISimpleSearch.Dataset.Fields.FieldByName('despro').Value, 1);
       end;
     end;
   end;

   Result := AData;

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(ISimpleSearch) then ISimpleSearch := nil;
   if Assigned(AForm) then FreeAndNil(AForm);
   if AModule <> 0 then UnloadPackage(AModule);
  end
end;

end.
