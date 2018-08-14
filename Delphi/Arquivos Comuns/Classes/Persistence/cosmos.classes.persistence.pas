unit cosmos.classes.persistence;

interface

uses
 Winapi.Windows, System.Classes;

type
 //Classes-base usadas por todos os descendentes que implementam alguma forma de
 //persistência de dados.
 TCustomPersistence = class abstract
  private


  protected
   function ReadString(const Key: string): string; virtual; abstract;
   function ReadInteger(const Key: string): integer; virtual; abstract;
   function ReadFloat(const Key: string): double; virtual; abstract;
   function ReadDateTime(const Key: string): TDateTime; virtual; abstract;
   function ReadDate(const Key: string): TDate; virtual; abstract;
   function ReadBoolean(const Key: string): boolean; virtual; abstract;
   function ReadCurrency(const Key: string): currency; virtual; abstract;
   function ReadCyphereValue(const Key: string): string; virtual; abstract;

   procedure WriteString(const Key: string; Value: string); virtual; abstract;
   procedure WriteInteger(const Key: string; Value: integer); virtual; abstract;
   procedure WriteFloat(const Key: string; Value: double); virtual; abstract;
   procedure WriteDateTime(const Key: string; Value: TDateTime); virtual; abstract;
   procedure WriteDate(const Key: string; Value: TDate); virtual; abstract;
   procedure WriteBoolean(const Key: string; Value: boolean); virtual; abstract;
   procedure WriteCurrency(const Key: string; Value: currency); virtual; abstract;
   procedure WriteCyphereValue(const Key: string; Value: string); virtual; abstract;
   procedure WriteHash(const Key: string; Value: string); virtual; abstract;

   procedure GetKeyNames(List: TStringList);  virtual; abstract;
   procedure GetValueNames(List: TStrings); virtual; abstract;
   function KeyExists(const Key: string): boolean; virtual; abstract;
   function ValueExists(const Key: string): boolean; virtual; abstract;
   function DeleteKey(const Key: string): boolean; virtual; abstract;


  public
   constructor Create;
   destructor Destroy; override;

 end;

  TFilePersistence = class abstract (TCustomPersistence)
  private

   function GetFileName: string; virtual; abstract;

  public
   function ReadString(const Section, Key, Default: string): string; reintroduce; virtual; abstract;
   function ReadInteger(const Section, Key: string; Default: integer): integer; reintroduce; virtual; abstract;
   function ReadFloat(const Section, Key: string; Default: double): double; reintroduce; virtual; abstract;
   function ReadDateTime(const Section, Key: string; Default: TDateTime): TDateTime; reintroduce; virtual; abstract;
   function ReadDate(const Section, Key: string; Default: TDate): TDate; reintroduce; virtual; abstract;
   function ReadBoolean(const Section, Key: string; Default: boolean): boolean; reintroduce; virtual; abstract;
   function ReadCurrency(const Section, Key: string; Default: currency): currency; reintroduce; virtual; abstract;
   function ReadCyphereValue(const Section, Key, Default: string): string; reintroduce; virtual; abstract;

   procedure WriteString(const Section, Key, Value: string); reintroduce; virtual; abstract;
   procedure WriteInteger(const Section, Key: string; Value: integer); reintroduce; virtual; abstract;
   procedure WriteFloat(const Section, Key: string; Value: double); reintroduce; virtual; abstract;
   procedure WriteDateTime(const Section, Key: string; Value: TDateTime); reintroduce; virtual; abstract;
   procedure WriteDate(const Section, Key: string; Value: TDate); reintroduce; virtual; abstract;
   procedure WriteBoolean(const Section, Key: string; Value: boolean); reintroduce; virtual; abstract;
   procedure WriteCurrency(const Section, Key: string; Value: currency); reintroduce; virtual; abstract;
   procedure WriteCyphereValue(const Section, Key: string; Value: string); reintroduce; virtual; abstract;
   procedure WriteHash(const Section, Key, Value: string); reintroduce; virtual; abstract;

   procedure GetValueNames(const Section: string; List: TStrings); reintroduce; virtual; abstract;
   function ValueExists(const Section, Key: string): boolean; reintroduce; virtual; abstract;
   procedure DeleteKey(const Section, Key: string); reintroduce; virtual; abstract;


   constructor Create(const FileName: string);
   destructor Destroy; override;

   property FileName: string read GetFileName;

  end;


  THierarquicalPersistence = class abstract (TCustomPersistence)
  private

  public
   procedure Open(const RootKey: HKEY); virtual; abstract;
   function OpenKey(const Key: string; CanCreate: boolean): boolean; virtual; abstract;
   procedure CloseKey; virtual; abstract;

   function CreateKey(const Key: string): boolean; virtual; abstract;

   constructor Create;
   destructor Destroy; override;
  end;

   

implementation

{ TCustomPersistense }

constructor TCustomPersistence.Create;
begin
 inherited Create;
end;

destructor TCustomPersistence.Destroy;
begin
inherited Destroy;
end;

{ TFilePersistence }

constructor TFilePersistence.Create(const FileName: string);
begin
 inherited Create;
end;

destructor TFilePersistence.Destroy;
begin
inherited Destroy;
end;

{ THierarquicalPersistence }

constructor THierarquicalPersistence.Create;
begin
 inherited Create;
end;

destructor THierarquicalPersistence.Destroy;
begin
 inherited Destroy;
end;


end.
