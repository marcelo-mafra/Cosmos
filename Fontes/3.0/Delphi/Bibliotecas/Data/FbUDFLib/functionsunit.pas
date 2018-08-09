unit functionsunit;

interface

uses sysutils;


 function PosString(Subst, Str: PChar): integer; stdcall;
 function CopyString(Text: PChar; var Index, Count: integer): PChar; stdcall;
 function LengthString(Text: PChar): integer; stdcall;
 function GetAlias(Text: PChar): PChar; stdcall;
 function GenerateGUID: PChar; stdcall;
 function QuotedString(Text: PChar): PChar; stdcall;
 function Lower(Text: PChar): PChar; stdcall;



implementation



 function PosString(Subst, Str: PChar): integer;
 begin
  Result := Pos(Subst, str);
 end;

 function CopyString(Text: PChar; var Index, Count: integer): PChar;
 begin
   Result := Pchar(Copy(Text, Index, Count));
 end;

 function LengthString(Text: PChar): integer;
 begin
  Result := Length(Text);
 end;

 function GetAlias(Text: PChar): PChar; stdcall;
 var
 I: integer;
 begin
  I := Pos(' ',Text);
  if I = 0 then
   Result := PChar(Copy(Text,1,Length(Text)))
  else
   Result := PChar(Copy(Text,1,I - 1));
 end;

 function GenerateGUID: PChar;//Cria uma nova GUID e a exporta com string
 var
 GUID: TGUID;
 begin
  CreateGUID(GUID);
  Result := PChar(GUIDToString(GUID));
 end;

 function QuotedString(Text: PChar): PChar;
 begin
  Result := PChar(QuotedStr(Text));
 end;

 function Lower(Text: PChar): PChar;
 begin
  if Text <> '' then
   Result := PChar(LowerCase(Text));
 end;




end.
