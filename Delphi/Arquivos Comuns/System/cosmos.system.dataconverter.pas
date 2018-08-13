unit cosmos.system.dataconverter;

interface

uses
 System.Classes, System.SysUtils, System.Variants, Data.SqlTimSt, System.DateUtils,
 cosmos.system.messages;

type

  //Classe utilitária usada para converter dados de diversos tipos. Somente possui métodos de classe.
 TDataConverter = class(TObject)
   class function ToBolean(const value: string): boolean; inline;
   class function ToBoleanString(const value: boolean; Quoted: boolean = False): string; inline;
   class function ToBoleanSimNao(const value: string): string; inline;
   class function ToDate(const value: string): TDate; overload; inline;
   class function ToDate(const value: Extended): TDate; overload; inline;
   class function UnQuotedStr(const value: string): string; overload; inline;
   class procedure UnQuotedStr(var AList: TStringList); overload; inline;
   class function ToFormatedDateTime(const value: TDateTime): string; overload; inline;
   class function ToFormatedDateTime(const value: TSQLTimeStamp): string; overload; inline;
   class function ToFormatedDateTime(const value: TDateTime; Format: string): string;  overload; inline;
   class function ToFormatedSQLDate(const value: TDate): string; inline;
   class function ToFormatedSQLDateTime(const value: TDateTime; Quoted: boolean = True): string; inline;
   class function ToDateTime(const value: variant): TDateTime; overload; inline;
   class function ToDateTime(const value: Extended): TDateTime; overload; inline;
   class function ToInteger(const value: string): integer; overload; inline;
   class function ToInteger(const value: variant): integer; overload; inline;
   class function ToMonthName(const Month: integer): string; inline;
   class function ToTime(const value: string): TTime; inline;
   class function ToString(const value: variant): string; reintroduce; inline;
   class function ToWideString(const value: AnsiString): WideString; inline;
   class function ToAniString(const value: PWideChar): AnsiString;
   class function ToStringStream(const AStream: TStream): TStringStream;
   class function ToOleVariant(Strm: TMemoryStream): Olevariant;
   class function ToMemoryStream(value: OleVariant): TMemoryStream;
   class function ToFormatedCurrency(const Value: Extended): string;
   class function ToSQLTimeStamp(const Value: TDateTime; IncludeTime: boolean = False): string;
 end;

implementation

{ TDataConverter  }

class function TDataConverter.ToSQLTimeStamp(const Value: TDateTime;
  IncludeTime: boolean): string;
begin
//Formata um TDateTime para uma string que possa ser usada em uma sentença sql
 if not IncludeTime then
  Result := FormatDateTime('yyyy/mm/dd', Value) //do not localize!
 else
  Result := FormatDateTime('yyyy/mm/dd hh:mm:ss', Value)//do not localize!
end;

class function TDataConverter.ToOleVariant(
  Strm: TMemoryStream): Olevariant;
var
Data: PByteArray;
begin
 Result := VarArrayCreate ([0, Strm.Size - 1], varByte);
 Data := VarArrayLock(Result);
 try
  Strm.Position := 0;
  Strm.ReadBuffer(Data^, Strm.Size);
 finally
  VarArrayUnlock(Result);
 end;
end;

class function TDataConverter.ToMemoryStream(
  value: OleVariant): TMemoryStream;
var
Data: PByteArray;
Size: integer;
begin
 Result := TMemoryStream.Create;
 try
  Size := VarArrayHighBound (value, 1) - VarArrayLowBound(value, 1) + 1;
  Data := VarArrayLock(value);

  try
   Result.Position := 0;
   Result.WriteBuffer(Data^, Size);
  finally
   VarArrayUnlock(value);
  end;

 except
  Result.Free;
  Result := nil;
 end;
end;


class function TDataConverter.ToAniString(const value: PWideChar): AnsiString;
begin
 OleStrToStrVar(Value, Result);
end;

class function TDataConverter.ToBolean(const value: string): boolean;
begin
//Converte uma string para um boolean. "S" é interpretado como True e qualquer outro valor é False.
 Result := UpperCase(value) = 'S';
end;

class function TDataConverter.ToBoleanSimNao(const value: string): string;
begin
 if Value = 'S' then
  Result := 'Sim' //do not localize!
 else
  Result := 'Não';//do not localize!
end;

class function TDataConverter.ToBoleanString(const value: boolean;
    Quoted: boolean = False): string;
begin
 if Value = True then
  Result := 'S'
 else
  Result := 'N';

 if Quoted then
  Result := Result.QuotedString;
end;

class function TDataConverter.ToDate(const value: string): TDate;
begin
 try
  Result := StrToDate(value);

 except
  on E: Exception do
   begin
    E.Message := Format(TConverterErrorMsg.StringDateConvert, [value]);
    raise;
   end;
 end;
end;

class function TDataConverter.ToDate(const value: Extended): TDate;
begin
 Result := DateOf(Value);
end;

class function TDataConverter.ToDateTime(const value: Extended): TDateTime;
begin
 Result := Value;
end;

class function TDataConverter.ToDateTime(const value: variant): TDateTime;
begin
 Result := varToDateTime(value);
end;

class function TDataConverter.ToFormatedDateTime(
  const value: TDateTime): string;
begin
 Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', value); //do not localize!
end;

class function TDataConverter.ToFormatedCurrency(const Value: Extended): string;
begin
 Result := FloatToStrF(Value, ffCurrency, 15, 2);
end;

class function TDataConverter.ToFormatedDateTime(const value: TDateTime;
  Format: string): string;
begin
 Result := FormatDateTime(Format, value);
end;

class function TDataConverter.ToFormatedDateTime(
  const value: TSQLTimeStamp): string;
begin
 Result := SQLTimeStampToStr('dd/mm/yyyy hh:nn:ss', Value);//do not localize!
end;

class function TDataConverter.ToFormatedSQLDate(const value: TDate): string;
begin
 Result := FormatDateTime('yyyy/mm/dd', Value);//do not localize!
end;

class function TDataConverter.ToFormatedSQLDateTime(
  const value: TDateTime; Quoted: boolean): string;
begin
 Result := FormatDateTime('yyyy/mm/dd hh:nn:ss', Value);//do not localize!
 if Quoted then
  Result := Result.QuotedString;
end;

class function TDataConverter.ToInteger(const value: variant): integer;
begin
//Converte um variant para um inteiro
 Result := VarAsType(value,varInteger);
end;

class function TDataConverter.ToInteger(const value: string): integer;
begin
 try
  Result := StrToInt(value);

 except
  on E: Exception do
   begin
    E.Message := Format(TConverterErrorMsg.StringIntegerConvert, [value]);
    raise;
   end;
 end;
end;

class function TDataConverter.ToMonthName(const Month: integer): string;
begin
//Retorna os nomes dos meses...
 case Month of
  1: Result := TCosmosMiscellaneous.JAN;
  2: Result := TCosmosMiscellaneous.FEV;
  3: Result := TCosmosMiscellaneous.MAR;
  4: Result := TCosmosMiscellaneous.ABR;
  5: Result := TCosmosMiscellaneous.MAI;
  6: Result := TCosmosMiscellaneous.JUN;
  7: Result := TCosmosMiscellaneous.JUL;
  8: Result := TCosmosMiscellaneous.AGO;
  9: Result := TCosmosMiscellaneous.SETM;
  10: Result := TCosmosMiscellaneous.OUTU;
  11: Result := TCosmosMiscellaneous.NOV;
  12: Result := TCosmosMiscellaneous.DEZ
  else
   Result := '';
 end;
end;

class function TDataConverter.ToString(const value: variant): string;
begin
 Result := '';
 if (Value <> null) and (Value <> unassigned) then
  Result := VarToStr(Value);
end;

class function TDataConverter.ToStringStream(
  const AStream: TStream): TStringStream;
begin
 Result := TStringStream.Create();

 try
  Result.LoadFromStream(AStream);

 except
  Result := nil;
 end;
end;

class function TDataConverter.ToTime(const value: string): TTime;
begin
 try
  Result := StrToTime(value);

 except
  on E: Exception do
   begin
    E.Message := Format(TConverterErrorMsg.StringTimeConvert, [value]);
    raise;
   end;
 end;
end;

class function TDataConverter.ToWideString(const value: AnsiString): WideString;
begin
 Result := WideString(Value);
end;

class function TDataConverter.UnQuotedStr(const value: string): string;
var
sFirstChar, sLastChar: string;
begin
 Result := value;

 sFirstChar := Copy(TrimLeft(value), 1, 1);
 sLastChar := Copy(TrimRight(value), Length(value), 1);
 if (sFirstChar = '''') and  (sLastChar = '''') then //do not localize!
  begin
    Delete(Result, 1, 1);
    Delete(Result, Length(Result), 1);
  end;
end;

class procedure TDataConverter.UnQuotedStr(var AList: TStringList);
var
AIndex: integer;
sValue: string;
begin
 if AList = nil then
  Exit;

 AList.Delimiter := ',';//do not localize!
 AList.QuoteChar := ' ';//do not localize!

 for AIndex := 0 to Pred(AList.Count) do
   begin
     sValue := AList.Strings[AIndex];
     sValue := TDataConverter.UnQuotedStr(sValue);
     AList.Strings[AIndex] := sValue;
   end;
end;
end.
