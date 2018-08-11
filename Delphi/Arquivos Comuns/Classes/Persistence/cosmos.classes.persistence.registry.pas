unit cosmos.classes.persistence.registry;

interface

uses
 Winapi.Windows, System.Classes, cosmos.classes.persistence, System.Win.Registry,
 cosmos.system.files, cosmos.classes.cripter, cosmos.system.messages, WinAPI.ShellAPI;

type

 TRegistryPersistence = class(THierarquicalPersistence)

  private
   FRegistry: TRegistry;

  public
   procedure Open(const RootKey: HKEY); override;
   function OpenKey(const Key: string; CanCreate: boolean): boolean; override;
   function OpenKeyReadOnly(const Key: string): boolean;
   procedure CloseKey; override;

   function ReadString(const Key: string): string; override;
   function ReadInteger(const Key: string): integer; override;
   function ReadFloat(const Key: string): double; override;
   function ReadDateTime(const Key: string): TDateTime; override;
   function ReadDate(const Key: string): TDate; override;
   function ReadBoolean(const Key: string): boolean; override;
   function ReadCurrency(const Key: string): currency; override;
   function ReadCyphereValue(const Key: string): string; override;

   procedure WriteString(const Key: string; Value: string); override;
   procedure WriteInteger(const Key: string; Value: integer); override;
   procedure WriteFloat(const Key: string; Value: double); override;
   procedure WriteDateTime(const Key: string; Value: TDateTime); override;
   procedure WriteDate(const Key: string; Value: TDate); override;
   procedure WriteBoolean(const Key: string; Value: boolean); override;
   procedure WriteCurrency(const Key: string; Value: currency); override;
   procedure WriteCyphereValue(const Key: string; Value: string); override;
   procedure WriteHash(const Key: string; Value: string); override;


   procedure GetKeyNames(List: TStringList); override;
   procedure GetValueNames(List: TStrings); override;   
   function KeyExists(const Key: string): boolean; override;
   function ValueExists(const Key: string): boolean; override;
   function CreateKey(const Key: string): boolean; override;
   function DeleteKey(const Key: string): boolean; override;

   procedure CreateCosmosHive(const FileName: string);

   constructor Create;
   constructor CreateReadOnly;
   destructor Destroy; override;
 end;

implementation

{ TCustomPersistense }

procedure TRegistryPersistence.CloseKey;
begin
  inherited;
  FRegistry.CloseKey;
end;

constructor TRegistryPersistence.Create;
begin
 inherited Create;
 FRegistry := TRegistry.Create;
end;

procedure TRegistryPersistence.CreateCosmosHive(const FileName: string);
begin
{Cria a chave completa do Cosmos na Registry. A criação é feita na chave HKCU do
 usuário corrente. Este método deve ser chamado apenas quando a chave do Cosmos
 não existir para o usuário corrente.}
 ShellExecute(0,nil,'REGEDIT.EXE',PChar('/SC /C '+ '"' + FileName + '"'),nil,sw_hide);
end;

function TRegistryPersistence.CreateKey(const Key: string): boolean;
begin
 Result := FRegistry.CreateKey(Key)
end;

constructor TRegistryPersistence.CreateReadOnly;
begin
 inherited Create;
 FRegistry := TRegistry.Create(KEY_READ);
end;

function TRegistryPersistence.DeleteKey(const Key: string): boolean;
begin
 Result := FRegistry.DeleteKey(Key);
end;

destructor TRegistryPersistence.Destroy;
begin
 FRegistry.Free;
 inherited Destroy;
end;

procedure TRegistryPersistence.GetKeyNames(List: TStringList);
begin
  inherited;
  if List <> nil then
   FRegistry.GetKeyNames(List);
end;

procedure TRegistryPersistence.GetValueNames(List: TStrings);
begin
  inherited;
  FRegistry.GetValueNames(List);
end;

function TRegistryPersistence.KeyExists(const Key: string): boolean;
begin
 Result := FRegistry.KeyExists(Key);
end;

procedure TRegistryPersistence.Open(const RootKey: HKEY);
begin
  inherited;
  FRegistry.RootKey := RootKey;
end;

function TRegistryPersistence.OpenKey(const Key: string;
  CanCreate: boolean): boolean;
begin
 Result := FRegistry.OpenKey(Key, CanCreate);
end;

function TRegistryPersistence.OpenKeyReadOnly(const Key: string): boolean;
begin
 Result := FRegistry.OpenKeyReadOnly(Key);
end;

function TRegistryPersistence.ReadBoolean(const Key: string): boolean;
begin
 Result := FRegistry.ReadBool(Key);
end;

function TRegistryPersistence.ReadCurrency(const Key: string): currency;
begin
 Result := FRegistry.ReadCurrency(Key);
end;

function TRegistryPersistence.ReadDate(const Key: string): TDate;
begin
 Result := FRegistry.ReadDate(Key);
end;

function TRegistryPersistence.ReadDateTime(const Key: string): TDateTime;
begin
 Result := FRegistry.ReadDateTime(Key);
end;

function TRegistryPersistence.ReadFloat(const Key: string): double;
begin
 Result := FRegistry.ReadFloat(Key);
end;

function TRegistryPersistence.ReadCyphereValue(const Key: string): string;
var
 sValue: string;
 aCripter: TCripter;
begin
//Descriptografa uma string que é retornada pela função. A rotina de
//descriptografia está no módulo cripter.dll
 aCripter := TCripter.Create;

 try
  sValue := FRegistry.ReadString(Key);
  Result := aCripter.Decrypt(cmBlowfish128, PChar(TCosmosCriptography.EKey), PChar(sValue));

 finally
  aCripter.Free;
 end;
end;

function TRegistryPersistence.ReadInteger(const Key: string): integer;
begin
 Result := FRegistry.ReadInteger(Key);
end;

function TRegistryPersistence.ReadString(const Key: string): string;
begin
 Result := FRegistry.ReadString(Key);
end;

function TRegistryPersistence.ValueExists(const Key: string): boolean;
begin
 Result := FRegistry.ValueExists(Key);
end;

procedure TRegistryPersistence.WriteBoolean(const Key: string; Value: boolean);
begin
  inherited;
  FRegistry.WriteBool(Key, Value);
end;

procedure TRegistryPersistence.WriteCurrency(const Key: string;
  Value: currency);
begin
  inherited;
  FRegistry.WriteCurrency(Key, Value);
end;

procedure TRegistryPersistence.WriteCyphereValue(const Key: string;
  Value: string);
var
 aCripter: TCripter;
 CiphereValue: string;
begin
  inherited;
  aCripter := TCripter.Create;

  try
   CiphereValue := aCripter.Encrypt(cmBlowfish128, PChar(TCosmosCriptography.EKey), PChar(Value));
   FRegistry.WriteString(Key, CiphereValue);

  finally
   aCripter.Free;
  end;
end;

procedure TRegistryPersistence.WriteDate(const Key: string; Value: TDate);
begin
  inherited;
  FRegistry.WriteDate(Key, Value);
end;

procedure TRegistryPersistence.WriteDateTime(const Key: string;
  Value: TDateTime);
begin
  inherited;
  FRegistry.WriteDateTime(Key, Value);
end;

procedure TRegistryPersistence.WriteFloat(const Key: string; Value: double);
begin
  inherited;
  FRegistry.WriteFloat(Key, Value);
end;

procedure TRegistryPersistence.WriteHash(const Key: string; Value: string);
var
sValue: string;
aCripter: TCripter;
begin
 aCripter := TCripter.Create;

 try
   sValue := aCripter.HashValue(hmSHA512, Value);
   FRegistry.WriteString(Key, sValue);

 finally
   aCripter.Free;
 end;
end;

procedure TRegistryPersistence.WriteInteger(const Key: string; Value: integer);
begin
  inherited;
  FRegistry.WriteInteger(Key, Value);
end;

procedure TRegistryPersistence.WriteString(const Key: string; Value: string);
begin
  inherited;
  FRegistry.WriteString(Key, Value);
end;

end.

