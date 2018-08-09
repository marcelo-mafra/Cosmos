unit cosmos.classes.serversutils;

interface

uses
 Winapi.Windows, System.SysUtils, System.IniFiles;

 type

 TCosmosInfoFiles = class
  private
   class function ReadCosmosRootFolder: string;

  public
   class function GetConfigurationFile: string;
   class function GetServerCommandsFile: string;
   class function GetDatabaseConfigurationFile: string;
   class function GetDatabaseMonitorFolder: string;
   class function GetMaxLineTracesMonitor: integer;
   class function IsMonitoringDatabase: boolean;

 end;

implementation

{ TCosmosInfoFiles }

class function TCosmosInfoFiles.GetConfigurationFile: string;
begin
{Recupera o caminho do arquivo de configurações central das aplicações servidoras.}
  Result := ReadCosmosRootFolder;
  Result := Result + 'CosmosRoot.ini';
end;

class function TCosmosInfoFiles.GetDatabaseConfigurationFile: string;
var
 AFile: TMemIniFile;
 AFileName: string;
begin
{Recupera o caminho do arquivo de configurações de conexão com o banco de dados
 do Cosmos.}
  AFileName := GetConfigurationFile;
  AFile := TMemIniFile.Create(AFileName);

  try
    Result := AFile.ReadString('ServerInfo', 'ConfFilePath', ''); //do not localize!

  finally
    if Assigned(AFile) then
     FreeAndNil(AFile);
  end;
end;

class function TCosmosInfoFiles.GetDatabaseMonitorFolder: string;
var
 AFile: TMemIniFile;
 AFileName: string;
begin
{Recupera o caminho da pasta onde serão escritos os arquivos de monitoramento do
 servidor SQL. Esta informação está no arquivo de configurações do servidor do Cosmos.}
  AFileName := GetConfigurationFile;
  AFile := TMemIniFile.Create(AFileName);

  try
    Result := AFile.ReadString('DatabaseMonitor', 'MonitorFolder', ''); //do not localize!

  finally
    if Assigned(AFile) then
     FreeAndNil(AFile);
  end;

end;

class function TCosmosInfoFiles.GetMaxLineTracesMonitor: integer;
var
 AFile: TMemIniFile;
 AFileName: string;
begin
{Retorna a quantidade máxima de linhas que um arquivo de dados de monitoramento
 do banco de dados pode ter.}
  AFileName := GetConfigurationFile;
  AFile := TMemIniFile.Create(AFileName);

  try
    Result := AFile.ReadInteger('DatabaseMonitor', 'MaxLinesTrace', 1000); //do not localize!

  finally
    if Assigned(AFile) then
     FreeAndNil(AFile);
  end;
end;

class function TCosmosInfoFiles.GetServerCommandsFile: string;
var
 AFile: TMemIniFile;
 AFileName: string;
begin
{Recupera o caminho do arquivo de comandos SQL do servidor. O local deste arquivo
 está configurado no arquivo de configurações do servidor do Cosmos.}
  AFileName := GetConfigurationFile;
  AFile := TMemIniFile.Create(AFileName);

  try
    Result := AFile.ReadString('AdmFiles', 'CosmosSearchsInfo', ''); //do not localize!

  finally
    if Assigned(AFile) then
     FreeAndNil(AFile);
  end;
end;

class function TCosmosInfoFiles.IsMonitoringDatabase: boolean;
var
 AFile: TMemIniFile;
 AFileName: string;
begin
{Informe se no arquivo de configurações do servidor a configuração para a
atividade de monitoramento de servidor SQL está ativa.}

  AFileName := GetConfigurationFile;
  AFile := TMemIniFile.Create(AFileName);

  try
    Result := AFile.ReadInteger('DatabaseMonitor', 'Active', 0) <> 0; //do not localize!

  finally
    if Assigned(AFile) then
     FreeAndNil(AFile);
  end;
end;

class function TCosmosInfoFiles.ReadCosmosRootFolder: string;
var
 AFileName: string;
 Buffer: array[0..260] of Char;
begin
{Recupera o caminho das pasta de instalação da aplicação servidora.}
  GetModuleFileName(0, Buffer, SizeOf(Buffer));
  AFileName := Buffer;
  Result := ExtractFilePath(AFileName);
end;

end.
