unit cosmos.framework.clients.common.appinfo;

interface

uses
 System.Classes, System.SysUtils, Winapi.Windows, Vcl.Forms, Vcl.Dialogs,
 cosmos.system.messages, cosmos.classes.application, cosmos.framework.interfaces.utils,
 cosmos.system.winshell, System.IniFiles, cosmos.system.types;

type
  {Implementa um objeto que disponibiliza informações sobre a aplicação Cosmos em execução, tais
    como paths e nomes de arquivos de configuração e do sistema de ajuda, por exemplo.}
  TCosmosAppInfo = class(TInterfacedPersistent, ICosmosApplicationPaths)

    private
     function OpenFile: TMemIniFile;

    public

     constructor Create;
     destructor Destroy; override;

     //Paths
     function ReadInstallationPath: string;
     function ReadHelpFilesPath: string;
     function ReadReportsFolder(Module: TCosmosModules): string;
     function ReadBufferedDataPath: string;
     function ReadMonitorConnectionPath: string;
     function ReadTasksFilesPath: string;
     function ReadCommonAppDataPath: string;
     function ReadUserAppDataPath: string;
     function ReadUpdatesFolder: string;

     //Files
     function GetHelpFile(CosmosModule: TCosmosModules): string;
     function GetUserConfigurationsFile: string;
     function GetCommonConfigurationsFile: string;
     function GetReportParamsFile: string;
     function GetCentralPesquisaFile: string;
     function GetFormsInfoFile: string;


  end;


implementation

{ TCosmosAppInfo }

constructor TCosmosAppInfo.Create;
begin
 inherited Create;
end;

destructor TCosmosAppInfo.Destroy;
begin
  inherited Destroy;
end;

function TCosmosAppInfo.GetCommonConfigurationsFile: string;
var
  Ini: TMemIniFile;
begin
 {Recupera o caminho completo do arquivo de configurações comum a todos os
 usuários do sistema.}
  Ini := self.OpenFile;

  try
   Result := Ini.ReadString('CosmosFiles', 'CommonConfigurationsFile', '');

  finally
    if Assigned(Ini) then
     FreeAndNil(Ini);
  end;
end;

function TCosmosAppInfo.GetFormsInfoFile: string;
begin
 {Recupera o caminho completo do arquivo de configurações dos formulários do
  Cosmos. Cada usuário possui sua cópia deste arquivo.}
 Result := self.ReadUserAppDataPath + TCosmosFiles.ConfigFormsInfo;
end;

function TCosmosAppInfo.GetCentralPesquisaFile: string;
begin
 {Recupera o caminho completo do arquivo de definição das pesquisas disponibilziadas
  na ferramenta "Central de Pesquisas".}
 Result := self.ReadInstallationPath + TCosmosFiles.ConfigCentralPesquisas;
end;

function TCosmosAppInfo.GetUserConfigurationsFile: string;
begin
 {Recupera o caminho completo do arquivo de configurações dos usuários. Cada
  usuário possui sua cópia deste arquivo.}
 Result := self.ReadUserAppDataPath + TCosmosFiles.ConfigUser;
end;

function TCosmosAppInfo.OpenFile: TMemIniFile;
var
 sRootPathsFile: string;
begin
 {Abre o arquivo de configurações inicial de pastas e arquivos importantes
 dos aplicativos Cosmos.}
  sRootPathsFile := ExtractFilepath(Application.ExeName) +  TCosmosFiles.ConfigFolders;
  Result := TMemIniFile.Create(sRootPathsFile);
end;

function TCosmosAppInfo.GetHelpFile(CosmosModule: TCosmosModules): string;
begin
 {Recupera o caminho completo dos arquivos de ajuda das aplicações Cosmos.}
 case CosmosModule of
   cmFocos: Result := self.ReadHelpFilesPath +  TCosmosFiles.HelpFileFocos; //do not localize!
   cmSecretarias: Result := self.ReadHelpFilesPath + TCosmosFiles.HelpFileSecretarias; //do not localize!
   cmFinanceiro: Result := self.ReadHelpFilesPath + TCosmosFiles.HelpFileFinanceiro;  //do not localize!
   cmConferencias: Result := self.ReadHelpFilesPath + TCosmosFiles.HelpFileConferencias; //do not localize!
   cmUsuarios: Result := self.ReadHelpFilesPath + TCosmosFiles.HelpFileUsuarios; //do not localize!
 end;
end;

function TCosmosAppInfo.GetReportParamsFile: string;
begin
 {Recupera o caminho completo do arquivo de configurações de parâmetros dos
  relatórios.}
 Result := ReadInstallationPath + TCosmosFiles.ConfigReportsParams;
end;

function TCosmosAppInfo.ReadBufferedDataPath: string;
var
  Ini: TMemIniFile;
begin
 {Recupera o caminho completo da pasta de buferização de dados.}
  Ini := self.OpenFile;

  try
    Result := Ini.ReadString('CurrentPaths', 'BufferedDataPath', '');

  finally
    if Assigned(Ini) then
     begin
       FreeAndNil(Ini);
     end;
  end;
end;

function TCosmosAppInfo.ReadHelpFilesPath: string;
var
  Ini: TMemIniFile;
begin
 {Recupera o caminho completo da pasta de arquivos de ajuda.}
  Ini := self.OpenFile;

  try
    Result := Ini.ReadString('CurrentPaths', 'HelpPath', '');

  finally
    if Assigned(Ini) then
     begin
       FreeAndNil(Ini);
     end;
  end;
end;

function TCosmosAppInfo.ReadInstallationPath: string;
var
  Ini: TMemIniFile;
begin
//Recupera a pasta de instalação do sistema Cosmos.
  Ini := self.OpenFile;

  try
    Result := Ini.ReadString('CurrentPaths', 'InstallationPath', '');

  finally
    if Assigned(Ini) then
     begin
       FreeAndNil(Ini);
     end;
  end;
end;

function TCosmosAppInfo.ReadMonitorConnectionPath: string;
var
  Ini: TMemIniFile;
begin
 {Recupera o caminho completo da pasta de buferização de arquivos de monitoração
  da conexão com o servidor remoto.}
  Ini := self.OpenFile;

  try
    Result := Ini.ReadString('CurrentPaths', 'MonitorConnectionPath', '');

  finally
    if Assigned(Ini) then
     begin
       FreeAndNil(Ini);
     end;
  end;
end;

function TCosmosAppInfo.ReadCommonAppDataPath: string;
var
  Ini: TMemIniFile;
begin
 {Recupera o caminho completo da pasta comum de arquivos.}
  Ini := self.OpenFile;

  try
   Result := Ini.ReadString('CurrentPaths', 'CommonAppDataPath', '');

  finally
    if Assigned(Ini) then
     FreeAndNil(Ini);
  end;

end;

function TCosmosAppInfo.ReadReportsFolder(Module: TCosmosModules): string;
var
  Ini: TMemIniFile;
  sSection: string;
begin
//Recupera a pasta dos arquivos dos relatórios de cada módulo do sistema Cosmos.
  Ini := self.OpenFile;

  try
   case Module of
     cmFocos: sSection := 'ReportsGFocFilesPath'; //do not localize!
     cmSecretarias: sSection := 'ReportsGSecFilesPath'; //do not localize!
     cmFinanceiro: sSection := 'ReportsGFinFilesPath'; //do not localize!
     cmConferencias: sSection := 'ReportsGConfFilesPath'; //do not localize!
     cmUsuarios: sSection := 'ReportsGUsuFilesPath'; //do not localize!
   end;

    Result := Ini.ReadString('CurrentPaths', sSection, '');

  finally
    if Assigned(Ini) then
     begin
       FreeAndNil(Ini);
     end;
  end;
end;

function TCosmosAppInfo.ReadTasksFilesPath: string;
var
  Ini: TMemIniFile;
begin
//Recupera a pasta dos arquivos de tarefas de cada usuário.
  Ini := self.OpenFile;

  try
    Result := Ini.ReadString('CurrentPaths', 'TasksFilesPath', '');

  finally
    if Assigned(Ini) then
     begin
       FreeAndNil(Ini);
     end;
  end;
end;



function TCosmosAppInfo.ReadUpdatesFolder: string;
begin
 {Recupera o caminho completo da pasta onde são feitos downloads dos arquivos
 de updates do sistema.}
 Result := self.ReadCommonAppDataPath + TCosmosPaths.UpdatesPath;
end;

function TCosmosAppInfo.ReadUserAppDataPath: string;
begin
{*Recupera o nome da pasta local de arquivos do usuário corrente. Este método
somente é chamado por outros métodos desta classe.*}
 Result := TShellFolders.GetMyAppDataFolder + TCosmosPaths.CommonCosmosPath;
end;

end.
