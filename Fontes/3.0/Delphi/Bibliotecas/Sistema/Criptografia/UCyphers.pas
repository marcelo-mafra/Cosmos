unit UCyphers;

interface

uses
  System.SysUtils, IdCoderMIME, IdCoderQuotedPrintable, LbCipher, LbClass;

const
 C1 = 4512;
 C2 = 5627;

  type
   TCyphers = class
    private

    public
       class function SimpleEncrypt(Text: string; var code: integer): string;
       class function SimpleDecrypt(Text: string; var code: integer): string;
       class function HexEncrypt(InString: string; var Key: word): string;
       class function HexDecrypt(InString: string; var Key: word): string;
       class function BlowfishEncrypt128(const InString, Pass : string): string;
       class function BlowfishDecrypt128(const InString, Pass : string): string;
       class function DesEncrypt64(const InString, Pass: string): string;
       class function DesDecrypt64(const InString, Pass: string): string;
       class function TripleDesEncrypt128(const InString, Pass: string): string;
       class function TripleDESDecrypt128(const InString, Pass: string): string;
       class function RDLEncrypt256(const InString, Pass: string): string;
       class function RDLDecrypt256(const InString, Pass: string): string;
       class function RDLEncrypt192(const InString, Pass: string): string;
       class function RDLDecrypt192(const InString, Pass: string): string;
       class function RDLEncrypt128(const InString, Pass: string): string;
       class function RDLDecrypt128(const InString, Pass: string): string;
       class procedure RDLEncryptFile256(const InputFile, OutputFile: string);
       class procedure RDLDecryptFile256(const InputFile, OutputFile: string);
       class procedure TripleDESEncryptFile128(const InFile, OutFile : string);
       class procedure TripleDESDecryptFile128(const InFile, OutFile : string);
       class function Base64Encrypt(const InString : string): string;
       class function Base64Decrypt(const InString : string): string;
       class function QuotedPrintableEncrypt(const InString : string): string;
       class function QuotedPrintableDecrypt(const InString : string): string;
   end;

implementation

{ TCyphers }

class function TCyphers.Base64Encrypt(const InString: string): string;
var
 IdEncBase64: TIdEncoderMIME;
begin
 IdEncBase64 := TIdEncoderMIME.Create(nil);

 try
  Result := IdEncBase64.EncodeString(InString);

 finally
  IdEncBase64.Free;
 end;
end;

class function TCyphers.Base64Decrypt(const InString: string): string;
var
 IdDecBase64: TIdDecoderMIME;
begin
 IdDecBase64 := TIdDecoderMIME.Create(nil);

 try
  Result := IdDecBase64.DecodeString(InString)

 finally
  IdDecBase64.Free;
 end;
end;

class function TCyphers.QuotedPrintableDecrypt(const InString: string): string;
var
 IdEncQuotePrintable: TIdEncoderQuotedPrintable;
begin
 IdEncQuotePrintable := TIdEncoderQuotedPrintable.Create(nil);

 try
  Result := IdEncQuotePrintable.EncodeString(InString);

 finally
  IdEncQuotePrintable.Free;
 end;
end;

class function TCyphers.QuotedPrintableEncrypt(const InString: string): string;
var
 IdDecQuotedPrintable: TIdDecoderQuotedPrintable;
begin
 IdDecQuotedPrintable := TIdDecoderQuotedPrintable.Create(nil);

 try
  Result := IdDecQuotedPrintable.DecodeString(InString)

 finally
  IdDecQuotedPrintable.Free;
 end;
end;


class function TCyphers.BlowfishDecrypt128(const InString,
  Pass: string): string;
var
 IdBlowfish: TLbBlowfish;
begin
 IdBlowfish := TLbBlowfish.Create(nil);

 try
  IdBlowfish.CipherMode := cmCBC;
  IdBlowfish.GenerateKey(Pass);
  Result := IdBlowfish.DecryptString(InString);

 finally
  IdBlowfish.Free;
 end;
end;

class function TCyphers.BlowfishEncrypt128(const InString,
  Pass: string): string;
var
 IdBlowfish: TLbBlowfish;
begin
 IdBlowfish := TLbBlowfish.Create(nil);

 try
  IdBlowfish.CipherMode := cmCBC;
  IdBlowfish.GenerateKey(Pass);
  Result := IdBlowfish.EncryptString(InString);

 finally
  IdBlowfish.Free;
 end;
end;

class function TCyphers.DesDecrypt64(const InString, Pass: string): string;
var
 LbDES: TLbDES;
begin
 LbDes := TLBDES.Create(nil);

 try
   LbDES.GenerateKey(Pass);
   Result := LbDES.DecryptString(InString)

 finally
   LbDES.Free;
 end;
end;

class function TCyphers.DesEncrypt64(const InString, Pass: string): string;
var
 LbDES: TLbDES;
begin
 LbDes := TLBDES.Create(nil);

 try
   LbDES.GenerateKey(Pass);
   Result := LbDES.EncryptString(InString)

 finally
   LbDES.Free;
 end;
end;

class function TCyphers.HexDecrypt(InString: string; var Key: word): string;
var
I: byte;
x: char;
begin
 //Descriptografia hexadecimal de 128 bits
 Result := '';
 i := 1;
 while (i < length(InString)) do
  begin
   x := char(StrToInt('$' + copy(InString,i,2)));
   Result := result + IntToStr((byte(x) xor (key shr 8)));
   Key := (byte(x) + key) * C1 + C2;
   Inc(i,2);
  end;
end;

class function TCyphers.HexEncrypt(InString: string; var Key: word): string;
var
I: byte;
begin
 //Criptografia hexadecimal de 128 bits
 Result := '';
 for i := 1 to Length(InString) do
  begin
   Result := Result + IntToHex(byte(char(byte(InString[i]) xor (key shr 8))),2);
   Key := (byte(char(byte(InString[i]) xor (key shr 8))) + Key) * C1 + C2;
  end;
end;

class function TCyphers.RDLDecrypt128(const InString, Pass: string): string;
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks128;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := LbRijndael.DecryptString(InString);

 finally
   LbRijndael.Free;
 end;
end;

class function TCyphers.RDLDecrypt192(const InString, Pass: string): string;
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks192;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := LbRijndael.DecryptString(InString);

 finally
   LbRijndael.Free;
 end;
end;

class function TCyphers.RDLDecrypt256(const InString, Pass: string): string;
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := LbRijndael.DecryptString(InString);

 finally
   LbRijndael.Free;
 end;
end;

class procedure TCyphers.RDLDecryptFile256(const InputFile, OutputFile: string);
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.DecryptFile(InputFile, OutputFile);

 finally
   LbRijndael.Free;
 end
end;

class function TCyphers.RDLEncrypt128(const InString, Pass: string): string;
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks128;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := LbRijndael.EncryptString(InString);

 finally
   LbRijndael.Free;
 end;
end;

class function TCyphers.RDLEncrypt192(const InString, Pass: string): string;
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks192;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := LbRijndael.EncryptString(InString);

 finally
   LbRijndael.Free;
 end;
end;

class function TCyphers.RDLEncrypt256(const InString, Pass: string): string;
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := LbRijndael.EncryptString(InString);

 finally
   LbRijndael.Free;
 end;
end;

class procedure TCyphers.RDLEncryptFile256(const InputFile, OutputFile: string);
var
 LbRijndael: TLbRijndael;
begin
 LbRijndael := TLbRijndael.Create(nil);

 try
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.EncryptFile(InputFile, OutputFile);

 finally
   LbRijndael.Free;
 end;
end;

class function TCyphers.SimpleDecrypt(Text: string; var code: integer): string;
 { Implementa uma descriptografia simples. Esta função permite alterar o algoritmo
  de encriptação a partir do valor passado em code. }
var
ResultStr: string;
Temp: char;
I, DecryptIndex: integer;
begin
 ResultStr := '';
 Temp := ' ';

 for I := 1 to length(Text) do
  begin
   for DecryptIndex := 1 to code do
    begin
     Temp := Pred (Text[I]);
     Text[I] := Temp;
    end;
  ResultStr := ResultStr + Temp;
 end;
 Result := ResultStr;

end;

class function TCyphers.SimpleEncrypt(Text: string; var code: integer): string;
 { Implementa uma criptografia simples. Esta função permite alterar o algoritmo
  de encriptação a partir do valor passado em code. Atenção: esta criptografia
  é muito simplória e NÃO deve ser usada quando uma criptografia real é
  exigida. }
var
ResultStr: string;
Temp: char;
I, EncryptIndex: integer;
begin
 ResultStr := '';
 Temp := ' ';

 for I := 1 to length(Text) do
  begin
   for EncryptIndex := 1 to code do
    begin
     Temp := Succ (Text[I]);
     Text[I] := Temp;
    end;
   ResultStr := ResultStr + Temp;
  end;

 Result := ResultStr;
end;

class function TCyphers.TripleDESDecrypt128(const InString,
  Pass: string): string;
var
 Lb3DES: TLb3DES;
begin
 Lb3Des := TLb3DES.Create(nil);

 try
   Lb3DES.GenerateKey(Pass);
   Result := Lb3DES.DecryptString(InString)

 finally
   Lb3DES.Free;
 end;
end;

class procedure TCyphers.TripleDESDecryptFile128(const InFile, OutFile: string);
begin

end;

class function TCyphers.TripleDesEncrypt128(const InString,
  Pass: string): string;
var
 Lb3DES: TLb3DES;
begin
 Lb3Des := TLb3DES.Create(nil);

 try
   Lb3DES.GenerateKey(Pass);
   Result := Lb3DES.EncryptString(InString)

 finally
   Lb3DES.Free;
 end;
end;

class procedure TCyphers.TripleDESEncryptFile128(const InFile, OutFile: string);
begin

end;



end.
