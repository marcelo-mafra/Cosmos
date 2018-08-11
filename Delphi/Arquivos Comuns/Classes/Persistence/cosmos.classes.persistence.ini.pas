unit cosmos.classes.persistence.ini;

interface

uses
 Winapi.Windows, System.Classes, cosmos.classes.persistence, System.IniFiles,
 System.SysUtils, cosmos.classes.cripter;

type

 //Encapsula classes de leitura de arquivos INI...
 TIniFilePersistence = class(TFilePersistence)

  private
   FIniFile: TCustomIniFile;
   FCodeKey: string;

   function GetFileName: string;

  public
   function ReadString(const Section, Key, Default: string): string; override;
   function ReadInteger(const Section, Key: string; Default: integer): integer; override;
   function ReadFloat(const Section, Key: string; Default: double): double; override;
   function ReadDateTime(const Section, Key: string; Default: TDateTime): TDateTime; override;
   function ReadDate(const Section, Key: string; Default: TDate): TDate; override;
   function ReadBoolean(const Section, Key: string; Default: boolean): boolean; override;
   function ReadCurrency(const Section, Key: string; Default: currency): currency; override;
   function ReadCyphereValue(const Section, Key, Default: string): string; override;

   procedure WriteString(const Section, Key, Value: string); override;
   procedure WriteInteger(const Section, Key: string; Value: integer); override;
   procedure WriteFloat(const Section, Key: string; Value: double); override;
   procedure WriteDateTime(const Section, Key: string; Value: TDateTime); override;
   procedure WriteDate(const Section, Key: string; Value: TDate); override;
   procedure WriteBoolean(const Section, Key: string; Value: boolean); override;
   procedure WriteCurrency(const Section, Key: string; Value: currency); override;
   procedure WriteHash(const Section, Key, Value: string); override;

   procedure GetKeyNames(List: TStringList); override;
   procedure GetValueNames(const Section: string; List: TStrings); override;
   function KeyExists(const Key: string): boolean; override;
   function ValueExists(const Section, Key: string): boolean; override;
   procedure DeleteKey(const Section, Key: string); override;

   procedure Save;


   constructor Create(const FileName: string; Memory: boolean);
   destructor Destroy; override;

   property FileName: string read GetFileName;
 end;

implementation

{ TIniFilePersistence }

constructor TIniFilePersistence.Create(const FileName: string; Memory: boolean);
begin
 inherited Create(FileName);
 if Memory = False then
  FIniFile := TIniFile.Create(FileName)
 else
  FIniFile := TMemIniFile.Create(FileName);

 FCodeKey := '7958165';
end;

procedure TIniFilePersistence.DeleteKey(const Section, Key: string);
begin
 FIniFile.DeleteKey(Section, Key);
end;

destructor TIniFilePersistence.Destroy;
begin
 FIniFile.Free;
 inherited Destroy;
end;

function TIniFilePersistence.GetFileName: string;
begin
 Result := FIniFile.FileName;
end;

procedure TIniFilePersistence.GetKeyNames(List: TStringList);
begin
  inherited;
  if List <> nil then
   FIniFile.ReadSections(List);
end;

procedure TIniFilePersistence.GetValueNames(const Section: string; List: TStrings);
begin
  inherited;
   FIniFile.ReadSectionValues(Section, List);
end;

function TIniFilePersistence.KeyExists(const Key: string): boolean;
begin
 Result := FIniFile.SectionExists(Key);
end;

function TIniFilePersistence.ReadBoolean(const Section, Key: string; Default: boolean): boolean;
begin
 Result := FIniFile.ReadBool(Section, Key, Default);
end;

function TIniFilePersistence.ReadCurrency(const Section, Key: string;
  Default: currency): currency;
begin
 Result := FloatToCurr(FIniFile.ReadFloat(Section, Key, Default));
end;

function TIniFilePersistence.ReadDate(const Section, Key: string;
  Default: TDate): TDate;
begin
 Result := FIniFile.ReadDate(Section, Key, Default);
end;

function TIniFilePersistence.ReadDateTime(const Section, Key: string; Default: TDateTime): TDateTime;
begin
 Result := FIniFile.ReadDateTime(Section, Key, Default);
end;

function TIniFilePersistence.ReadFloat(const Section, Key: string; Default: double): double;
begin
 Result := FIniFile.ReadFloat(Section, Key, Default);
end;

function TIniFilePersistence.ReadCyphereValue(const Section, Key,
  Default: string): string;
var
 sValue: string;
 aCripter: TCripter;
begin
 aCripter := TCripter.Create;

 try
  sValue := FIniFile.ReadString(Section, Key, Default);
  if sValue.Trim <> '' then
   Result := aCripter.Decrypt(cmBlowfish128, PChar(FCodeKey), PChar(sValue))
  else
   Result := sValue;

 finally
  aCripter.Free;
 end;
end;

function TIniFilePersistence.ReadInteger(const Section, Key: string; Default: integer): integer;
begin
 Result := FIniFile.ReadInteger(Section, Key, Default);
end;

function TIniFilePersistence.ReadString(const Section, Key, Default: string): string;
begin
 Result := FIniFile.ReadString(Section, Key, Default);
end;

procedure TIniFilePersistence.Save;
begin
 FIniFile.UpdateFile;
end;

function TIniFilePersistence.ValueExists(const Section, Key: string): boolean;
begin
 Result := FIniFile.ValueExists(Section, Key);
end;

procedure TIniFilePersistence.WriteBoolean(const Section, Key: string; Value: boolean);
begin
  inherited;
  FIniFile.WriteBool(Section, Key, Value);
end;

procedure TIniFilePersistence.WriteCurrency(const Section, Key: string;
  Value: currency);
begin
  inherited;
  FIniFile.WriteFloat(Section, Key, Value);
end;

procedure TIniFilePersistence.WriteDate(const Section, Key: string;
  Value: TDate);
begin
  inherited;
  FIniFile.WriteDate(Section, Key, Value);
end;

procedure TIniFilePersistence.WriteDateTime(const Section, Key: string;
  Value: TDateTime);
begin
  inherited;
  FIniFile.WriteDateTime(Section, Key, Value);
end;

procedure TIniFilePersistence.WriteFloat(const Section, Key: string; Value: double);
begin
  inherited;
  FIniFile.WriteFloat(Section, Key, Value);
end;

procedure TIniFilePersistence.WriteHash(const Section, Key, Value: string);
var
 sValue: string;
 aCripter: TCripter;
begin
  inherited;
  if Value <> '' then
   begin
    aCripter := TCripter.Create;

    try
     sValue := aCripter.HashValue(hmSHA512, Value);
     FIniFile.WriteString(Section, Key, sValue);

    finally
     aCripter.Free;
    end;
   end;
end;

procedure TIniFilePersistence.WriteInteger(const Section, Key: string; Value: integer);
begin
  inherited;
  FIniFile.WriteInteger(Section, Key, Value);
end;

procedure TIniFilePersistence.WriteString(const Section, Key, Value: string);
begin
  inherited;
  FIniFile.WriteString(Section, Key, Value);
end;


end.

