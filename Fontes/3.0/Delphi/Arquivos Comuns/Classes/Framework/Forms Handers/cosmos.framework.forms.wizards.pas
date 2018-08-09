unit cosmos.framework.forms.wizards;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
  cosmos.framework.interfaces.root, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.system.messages;

type

 TCosmosWizardsDialogs = class
   class function ExecuteWizard(const LibraryName, ClassName: string): boolean;

 end;

implementation

{ TCosmosWizardsDialogs }

class function TCosmosWizardsDialogs.ExecuteWizard(const LibraryName,
  ClassName: string): boolean;
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TForm;
  IWizard: ICosmosWizard;
  ICosmosApp: ICosmosApplication;
begin
  inherited;
  Result := False;
  AModule := LoadPackage(LibraryName);

  try
   if AModule <> 0 then
    begin
     AClass := GetClass(ClassName);
     if AClass <> nil then
      AForm := TComponentClass(AClass).Create(Application) as TForm;

     with AForm do
      begin
       if Supports(AForm, ICosmosWizard) then
        IWizard := AForm as ICosmosWizard;
       if Assigned(IWizard) then
         Result := IWizard.Execute;
       Free;
      end;
    end;

   if Assigned(IWizard) then
    IWizard := nil;
   UnloadPackage(AModule);

  except
   on E: Exception do
    begin
     Result := False;
     if Assigned(IWizard) then
      IWizard := nil;
     UnloadPackage(AModule);

     ICosmosApp := Application.MainForm as ICosmosApplication;
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadWizard);
     ICosmosApp.MainLog.RegisterError(TCosmosErrorMsg.LoadWizard + #13 + E.Message);
     if Assigned(ICosmosApp) then
      ICosmosApp := nil;
    end;
  end;
end;

end.
