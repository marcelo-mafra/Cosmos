unit cosmos.tools.controller.lists;

interface

uses
  System.SysUtils, cosmos.system.types, System.Classes, cosmos.system.winshell,
  cosmos.tools.controller.logsint, cosmos.system.types.cmhelpers;

type
  TOnChangeCosmosModule = procedure(CosmosModule: TCosmosModules) of object;

  TControllerCosmosLogsList = class(TInterfacedObject, IControllerCosmosLogsList)

  private
   FCurrentPath: string;
   FCosmosModule: TCosmosModules;
   FFileList: TStrings;
   FOnChangeModule: TOnChangeCosmosModule;

   procedure CreateFilesList;

  protected
   function GetCosmosModule: TCosmosModules;
   procedure SetCosmosModules(value: TCosmosModules);
   function GetCount: integer;
   function GetFilesList: TStrings;
   procedure UpdateFileList;

  public
   constructor Create(const CurrentPath: string);
   destructor Destroy; override;
   class function New(const CurrentPath: string): IControllerCosmosLogsList;

   property CosmosModule: TCosmosModules read GetCosmosModule write SetCosmosModules;
   property Count: integer read GetCount;
   property FilesList: TStrings read GetFilesList;

   property OnChangeModule: TOnChangeCosmosModule read FOnChangeModule write FOnChangeModule;
  end;

implementation



{ TControllerCosmosLogsList }

constructor TControllerCosmosLogsList.Create(const CurrentPath: string);
begin
 FFileList := TStrings.Create;
 FCurrentPath := CurrentPath;
end;

procedure TControllerCosmosLogsList.CreateFilesList;
var
 AList: TStringList;
 sFileName: string;
 I: integer;
begin
{Carrega as configurações de registro de logs do servidor em execução.}
 AList := TStringList.Create;

 try
  if FCurrentPath.Trim.IsEmpty then
   raise Exception.Create('Error Message');

  FFileList.BeginUpdate;
  FFileList.Clear;
  TShellFiles.FilesOfFolder(FCurrentPath, 'log', AList);

  for I := 0 to Pred(AList.Count) do
      begin
        sFileName := AList.Strings[I];
        if sFileName.Contains(CosmosModule.ModuleNameShort) then
          FFileList.Append(sFileName);
      end;

  FFileList.EndUpdate;
  AList.Free;

 except
  on E: Exception do
   begin
    raise;
   end;
 end;
end;

destructor TControllerCosmosLogsList.Destroy;
begin
  FFileList.Free;
  inherited;
end;

function TControllerCosmosLogsList.GetCosmosModule: TCosmosModules;
begin
 Result := FCosmosModule;
end;

function TControllerCosmosLogsList.GetCount: integer;
begin
 Result := FFileList.Count;
end;

function TControllerCosmosLogsList.GetFilesList: TStrings;
begin
 Result := FFileList;
end;

class function TControllerCosmosLogsList.New(const CurrentPath: string): IControllerCosmosLogsList;
begin
 Result := self.Create(CurrentPath);
end;

procedure TControllerCosmosLogsList.SetCosmosModules(value: TCosmosModules);
begin
 if value <> FCosmosModule then
   begin
     FCosmosModule := value;
     CreateFilesList;
     if assigned(FOnChangeModule) then
       FOnChangeModule(value);
   end;
end;


procedure TControllerCosmosLogsList.UpdateFileList;
begin
 CreateFilesList;
end;

end.
