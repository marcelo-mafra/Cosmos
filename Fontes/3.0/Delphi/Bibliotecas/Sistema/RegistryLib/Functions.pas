unit Functions;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ActiveX, Classes, ComObj, Reglib_TLB, Registry, StdVcl, SysUtils;

type
  TReg = class(TTypedComObject, IReg)
  protected
    function ReadString(const ValueName: WideString): WideString; stdcall;
    function ReadInteger(const ValueName: WideString): Integer; stdcall;
    function ReadBool(const ValueName: WideString): WordBool; stdcall;
    function ReadFloat(const ValueName: WideString): Double; stdcall;
    procedure WriteString(const ValueName, Value: WideString); stdcall;
    procedure WriteInteger(const ValueName: WideString; Value: Integer);
      stdcall;
    procedure WriteBool(const ValueName: WideString; Value: WordBool); stdcall;
    procedure WriteFloat(const ValueName: WideString; Value: Double); stdcall;
    procedure WriteCurrency(const ValueName: WideString; Value: Currency);
      stdcall;
    procedure WriteDate(const ValueName: WideString; Value: TDateTime);
      stdcall;
    procedure WriteTime(const ValueName: WideString; Value: TDateTime);
      stdcall;
    function ReadCurrency(const ValueName: WideString): Currency; stdcall;
    function ReadDate(const ValueName: WideString): TDateTime; stdcall;
    function ReadTime(const ValueName: WideString): TDateTime; stdcall;
    function GetKeyNames: OleVariant; stdcall;
    function ValueExists(const ValueName: WideString): WordBool; stdcall;
    function KeyExists(const KeyName: WideString): WordBool; stdcall;
    function ReadDateTime(const ValueName: WideString): OleVariant; stdcall;
    procedure WriteDateTime(const ValueName: WideString; Value: OleVariant);
      stdcall;
    function GetValueNames: WideString; stdcall;
    function ReadSectionValues: WideString; stdcall;
    function Get_Root: Integer; stdcall;
    procedure Set_Root(Value: Integer); stdcall;
    procedure Set_KeyName(const KeyPath: WideString; CreateKey: WordBool);
      stdcall;
    procedure CloseKey; stdcall;
    function ReadBinary(const ValueName: WideString; Buffer,
      BufferSize: Integer): Integer; stdcall;
    procedure WriteBinary(const ValueName: WideString; BinaryData: OleVariant;
      BufferSize: Integer); stdcall;
    function DeleteValue(const ValueName: WideString): WordBool; stdcall;
    function Deletekey(const KeyName: WideString): WordBool; stdcall;
    function GetDataSize(const ValueName: WideString): Integer; stdcall;
    function CreateKey(const KeyName: WideString): WordBool; stdcall;
    function HasSubKeys: WordBool; stdcall;
    procedure MoveKey(const OldKeyName, NewKeyName: WideString;
      DeleteKey: WordBool); stdcall;
    procedure RenameValue(const OldValueName, NewValueName: WideString);
      stdcall;
    function RestoreKey(const KeyName, FileName: WideString): WordBool;
      stdcall;
    function ReplaceKey(const keyName, FileName,
      BkpFileName: WideString): WordBool; stdcall;
    function LoadKey(const KeyName, FileName: WideString): WordBool; stdcall;
    function UnLoadKey(const KeyName: WideString): WordBool; stdcall;
    function RegistryConnect(const HostName: WideString): WordBool; stdcall;
    function SaveKey(const KeyName, FileName: WideString): WordBool; stdcall;
    function OpenKey(const KeyName: WideString; Create: WordBool): WordBool;
      stdcall;
    function Get_CurrentPath: WideString; stdcall;


  end;

  var
   Reg: TRegistry;//variável global de acesso ao registro

implementation

uses ComServ;

function TReg.ReadString(const ValueName: WideString): WideString;
begin
Result := '';
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadString(ValueName);
//Reg.CloseKey;
end;

function TReg.ReadInteger(const ValueName: WideString): Integer;
begin

Result := 0;
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadInteger(ValueName);

//Reg.CloseKey;
end;

function TReg.ReadBool(const ValueName: WideString): WordBool;
begin
Result := False;
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadBool(ValueName);
//Reg.CloseKey;
end;

function TReg.ReadFloat(const ValueName: WideString): Double;
begin
Result := 0;
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadFloat(ValueName);
//Reg.CloseKey;
end;

procedure TReg.WriteString(const ValueName, Value: WideString);
begin
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteString(ValueName,Value);
//Reg.CloseKey;
end;

procedure TReg.WriteInteger(const ValueName: WideString; Value: Integer);
begin
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteInteger(ValueName,Value);
//Reg.CloseKey;
end;

procedure TReg.WriteBool(const ValueName: WideString; Value: WordBool);
begin
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteBool(ValueName,Value);
//Reg.CloseKey;
end;

procedure TReg.WriteFloat(const ValueName: WideString; Value: Double);
begin
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteFloat(ValueName,Value);
//Reg.CloseKey;
end;

procedure TReg.WriteCurrency(const ValueName: WideString; Value: Currency);
begin
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteCurrency(ValueName,Value);
//Reg.CloseKey;
end;

procedure TReg.WriteDate(const ValueName: WideString; Value: TDateTime);
begin
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteDate(ValueName,Value);
//Reg.CloseKey;

end;


procedure TReg.WriteTime(const ValueName: WideString; Value: TDateTime);
begin
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteTime(ValueName,Value);
//Reg.CloseKey;

end;

function TReg.ReadCurrency(const ValueName: WideString): Currency;
begin
Result := 0;
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadCurrency(ValueName);
//Reg.CloseKey;

end;

function TReg.ReadDate(const ValueName: WideString): TDateTime;
begin
Result := 0;
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadDate(ValueName);
//Reg.CloseKey;
end;

function TReg.ReadTime(const ValueName: WideString): TDateTime;
begin
Result := 0;
//Reg := TRegistry.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadTime(ValueName);
// Reg.CloseKey;

end;

function TReg.GetKeyNames: OleVariant;
var
//Reg: TRegistry;
List : TStringList;
begin
Result := 0;
//Reg := TRegistry.Create;
List := TStringList.Create;
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.GetKeyNames(List);
Result := List.CommaText;
List.Free;
//Reg.CloseKey;
end;

function TReg.ValueExists(const ValueName: WideString): WordBool;
begin
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Result := Reg.ValueExists(ValueName);
//Reg.CloseKey;
end;

function TReg.KeyExists(const KeyName: WideString): WordBool;
begin
//Reg.RootKey := Root;
Result := Reg.KeyExists(KeyName);
//Reg.CloseKey;
end;

function TReg.ReadDateTime(const ValueName: WideString): OleVariant;
begin
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
if Reg.ValueExists(ValueName) then
 Result := Reg.ReadDateTime(ValueName);
//Reg.CloseKey;
end;

procedure TReg.WriteDateTime(const ValueName: WideString;
  Value: OleVariant);
begin
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
Reg.WriteDateTime(ValueName,Value);
//Reg.CloseKey;

end;

function TReg.GetValueNames: WideString;
var
st: TStringList;
begin
//Reg.RootKey := Root;
//Reg.OpenKey(KeyName,True);
St := TStringList.Create;
Reg.GetValueNames(St);
//Reg.CloseKey;
Result := ST.CommaText;
St.Free;
end;

function TReg.ReadSectionValues: WideString;
var
I: integer;
s: WideString;
St, ValueList: TStringList;
begin

St := TStringList.Create;
ValueList := TStringList.Create;
//Reg.RootKey := Root;
Try
//Reg.OpenKey(KeyName,True);
Reg.GetValueNames(St);

For I := 0 to St.Count - 1 do
 begin
  s := St.Strings[I] + '=' ;
  case Reg.GetDataType(St.Strings[I]) of
   rdString, rdExpandString: s := s + Reg.ReadString(St.Strings[I]);
   rdInteger: s := s + IntToSTr(Reg.ReadInteger(St.Strings[I]));
   rdBinary: s := s + '[Bynary Data]';
   rdUnknown: s := s + '[Tipo desconhecido]';
  end;
  ValueList.Add(s);
 end;
Result := ValueList.CommaText;

Finally
if Assigned(St) then
 St.Free;
if Assigned(ValueList) then
 ValueList.Free;
//Reg.CloseKey;
end;
end;

function TReg.Get_Root: Integer;
begin
if Assigned(Reg) then
 Result := Reg.RootKey
else
 Result := -1;//indica que Reg não está assinalado
end;

procedure TReg.Set_Root(Value: Integer);
begin
if Assigned(Reg) then
 begin
  Reg.CloseKey;
  Reg.RootKey := Value;
 end;
end;



procedure TReg.Set_KeyName(const KeyPath: WideString; CreateKey: WordBool);
begin
if Assigned(Reg) then
 begin
  Reg.CloseKey;
  Reg.OpenKey(KeyPath, CreateKey);
 end;
end;

procedure TReg.CloseKey;
begin
if Assigned(Reg) then
 Reg.CloseKey;
end;



function TReg.ReadBinary(const ValueName: WideString; Buffer,
  BufferSize: Integer): Integer;
begin
Result := Reg.ReadBinaryData(ValueName, Buffer, BufferSize);
end;

procedure TReg.WriteBinary(const ValueName: WideString;
  BinaryData: OleVariant; BufferSize: Integer);
begin
Reg.WriteBinaryData(ValueName, BinaryData, BufferSize);
end;

function TReg.DeleteValue(const ValueName: WideString): WordBool;
begin
Result := Reg.DeleteValue(ValueName);
end;

function TReg.Deletekey(const KeyName: WideString): WordBool;
begin
Result := Reg.DeleteKey(keyName);
end;

function TReg.GetDataSize(const ValueName: WideString): Integer;
begin
Result := Reg.GetDataSize(ValueName);
end;

function TReg.CreateKey(const KeyName: WideString): WordBool;
begin
Result := Reg.CreateKey(KeyName);
end;

function TReg.HasSubKeys: WordBool;
begin
Result := Reg.HasSubKeys;
end;

procedure TReg.MoveKey(const OldKeyName, NewKeyName: WideString;
  DeleteKey: WordBool);
begin
Reg.MoveKey(OldKeyName, NewKeyName, DeleteKey);
end;

procedure TReg.RenameValue(const OldValueName, NewValueName: WideString);
begin
Reg.RenameValue(OldValueName, NewValueName);
end;



function TReg.RestoreKey(const KeyName, FileName: WideString): WordBool;
begin
Result := Reg.RestoreKey(KeyName, FileName);
end;

function TReg.ReplaceKey(const keyName, FileName,
  BkpFileName: WideString): WordBool;
begin
Result := Reg.ReplaceKey(KeyName, FileName, BkpFileName)
end;

function TReg.LoadKey(const KeyName, FileName: WideString): WordBool;
begin
Result := Reg.LoadKey(KeyName, FileName);
end;

function TReg.UnLoadKey(const KeyName: WideString): WordBool;
begin
Result := Reg.UnLoadKey(KeyName)
end;

function TReg.RegistryConnect(const HostName: WideString): WordBool;
begin
Result := Reg.RegistryConnect(HostName);
end;


function TReg.SaveKey(const KeyName, FileName: WideString): WordBool;
begin
Result := Reg.SaveKey(KeyName, FileName);
end;

function TReg.OpenKey(const KeyName: WideString;
  Create: WordBool): WordBool;
begin
Result := Reg.OpenKey(Keyname, Create);
end;

function TReg.Get_CurrentPath: WideString;
begin
Result := Reg.CurrentPath;
end;

initialization
  TTypedComObjectFactory.Create(ComServer, TReg, Class_Reg,
    ciMultiInstance, tmApartment);
end.
