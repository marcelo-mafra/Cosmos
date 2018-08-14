unit cosmos.classes.dbxUtils;

interface

uses
 Winapi.Windows, System.SysUtils, System.IniFiles, cosmos.system.files;

 type

 TCosmosInfoFiles = class
  private
   class function ReadCosmosRootFolder: string;
   class function GetCosmosRootFile: string; static;
   class function GetDBInfoFile: string; static;

  public
   class property CosmosRootFile: string read GetCosmosRootFile;
   class property DBInfoFile: string read GetDBInfoFile;

 end;

implementation

{ TCosmosInfoFiles }

class function TCosmosInfoFiles.GetCosmosRootFile: string;
begin
{Recupera o caminho do arquivo de configurações central das aplicações servidoras.}
  Result := ReadCosmosRootFolder;
  Result := Result + TCosmosFiles.CosmosRoot;
end;

class function TCosmosInfoFiles.GetDBInfoFile: string;
var
 AFile: TMemIniFile;
begin
{Recupera o caminho do arquivo de configurações de conexão com o banco de dados
 do Cosmos.}
  AFile := TMemIniFile.Create(CosmosRootFile);

  try
    Result := AFile.ReadString('ServerInfo', 'ConfFilePath', ''); //do not localize!

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
