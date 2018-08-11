unit UExplib;

interface

uses  System.SysUtils;


const
 CipherIds: array[ 0.. 8 ] of string = (
    'native.AES-128', 'native.AES-192', 'native.AES-256',
    'native.DES', 'native.3DES.1', 'native.3DES.2', 'native.Blowfish',
    'native.Twofish', 'native.XXTEA.Large.Littleend');

{const
  ChainIds: array[ 0..6 ] of string = (
   ECB_ProgId, CBC_ProgId, PCBC_ProgId, CFB_ProgId,
   CFB8bit_ProgId, CTR_ProgId, OFB_ProgId);

var
  Key64            : TKey64;
  Key128           : TKey128;
  Key192           : TKey192;
  Key256           : TKey256;
  CipherText       : string;
  Passphrase       : string;
  ACodec: TCodec;
  AHash: THash;
  ACryptographicLibrary: TCryptographicLibrary;}


 procedure RefreshKeys;
 procedure CreateCodec;

 function SimpleEncrypt(Text: PChar; var code: integer): PChar; stdcall;
 function SimpleDecrypt(Text: PChar; var code: integer): PChar; stdcall;
 function HexEncrypt(InString: PChar; var Key: word): PChar; stdcall;
 function HexDecrypt(InString: PChar; var Key: word): PChar; stdcall;
 function BlowfishEncrypt128(const InString, Pass : PChar): PChar; stdcall;
 function BlowfishDecrypt128(const InString, Pass : PChar): PChar; stdcall;
 function DesEncrypt64(const InString, Pass: PChar): PChar; stdcall;
 function DesDecrypt64(const InString, Pass: PChar): PChar; stdcall;
 function TripleDesEncrypt128(const InString, Pass: PChar): PChar; stdcall;
 function TripleDESDecrypt128(const InString, Pass: PChar): PChar; stdcall;
 function RDLEncrypt256(const InString, Pass: PChar): PChar; stdcall;
 function RDLDecrypt256(const InString, Pass: PChar): PChar; stdcall;
 function RDLEncrypt192(const InString, Pass: PChar): PChar; stdcall;
 function RDLDecrypt192(const InString, Pass: PChar): PChar; stdcall;
 function RDLEncrypt128(const InString, Pass: PChar): PChar; stdcall;
 function RDLDecrypt128(const InString, Pass: PChar): PChar; stdcall;
 procedure RDLEncryptFile256(const InputFile, OutPutFile: PChar); stdcall;
 procedure RDLDecryptFile256(const InputFile, OutPutFile: PChar); stdcall;
 procedure TripleDESEncryptFile128(const InFile, OutFile : PChar); stdcall;
 procedure TripleDESDecryptFile128(const InFile, OutFile : PChar); stdcall;
 function HashMD5(const InString: PChar):PChar; stdcall;
 function HashSHA1(const InString: PChar):PChar; stdcall;
 function HashSHA224(const InString: PChar):PChar; stdcall;
 function HashSHA256(const InString: PChar):PChar; stdcall;
 function HashSHA384(const InString: PChar):PChar; stdcall;
 function HashSHA512(const InString: PChar):PChar; stdcall;
 function Base64Encrypt(const InString : PChar): PChar; stdcall;
 function Base64Decrypt(const InString : PChar): PChar; stdcall;
 function QuotedPrintableEncrypt(const InString : PChar): PChar; stdcall;
 function QuotedPrintableDecrypt(const InString : PChar): PChar; stdcall;




implementation

uses UCyphers, UHashes;


 procedure CreateCodec;
 begin
  {ACryptographicLibrary := TCryptographicLibrary.Create(nil);
  ACodec := TCodec.Create(nil);
  ACodec.CryptoLibrary := ACryptographicLibrary;}
 end;

 procedure CreateHash;
 begin
  {ACryptographicLibrary := TCryptographicLibrary.Create(nil);
  AHash := THash.Create(nil);
  AHash.CryptoLibrary := ACryptographicLibrary;}
 end;

 procedure RefreshKeys;
 begin
  {GenerateLMDKey(Key64, SizeOf(Key64), Passphrase);
  GenerateLMDKey(Key128, SizeOf(Key128), Passphrase);
  GenerateLMDKey(Key192, SizeOf(Key192), Passphrase);
  GenerateLMDKey(Key256, SizeOf(Key256), Passphrase);}
 end;

function SimpleEncrypt(Text: PChar; var code: integer): PChar;
begin
 Result := PChar(TCyphers.SimpleEncrypt(Text, Code));
end;

function SimpleDecrypt(Text: PChar; var code: integer): PChar;
begin
 Result := PChar(TCyphers.SimpleDecrypt(Text, Code));
end;


function HexEncrypt(InString: PChar; var Key: word): PChar;
begin
 Result := PChar(TCyphers.HexEncrypt(InString, Key));
end;


function HexDecrypt(InString: PChar; var Key: word): PChar;
begin
 Result := PChar(TCyphers.HexDecrypt(InString, Key));
end;

function BlowfishEncrypt128(const InString, Pass : PChar): PChar;
//Criptografia Blowfish de 128 bits
begin
 Result := PChar(TCyphers.BlowfishEncrypt128(InString, Pass));
end;

function BlowfishDecrypt128(const InString, Pass : PChar): PChar;
//Descriptografia Blowfish de 128 bits
begin
 Result :=  PChar(TCyphers.BlowfishDecrypt128(InString, Pass));
end;


 function DesEncrypt64(const InString, Pass: PChar): PChar; stdcall;
 begin
 //Criptografia DES de 64 bits
  Result :=  PChar(TCyphers.DesEncrypt64(InString, Pass));
 end;


 function DesDecrypt64(const InString, Pass: PChar): PChar; stdcall;
 begin
 //Descriptografia DES de 64 bits
  Result :=  PChar(TCyphers.DesDecrypt64(InString, Pass));
 end;

 function RDLEncrypt256(const InString, Pass: PChar): PChar; stdcall;
// var
//  LbRijndael: TLbRijndael;
 begin
 //Criptografia RDL de 256 bits
{  try
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := PChar(LbRijndael.EncryptString(InString));

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end;}
end;


 function RDLDecrypt256(const InString, Pass: PChar): PChar; stdcall;
// var
//  LbRijndael: TLbRijndael;
 begin
 //Descriptografia RDL de 256 bits
{  try
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := PChar(LbRijndael.DecryptString(InString));

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end; }
end;


 function RDLEncrypt192(const InString, Pass: PChar): PChar; stdcall;
// var
//  LbRijndael: TLbRijndael;
 begin
 //Criptografia RDL de 192 bits
{  try
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks192;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := PChar(LbRijndael.EncryptString(InString));

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end;}
end;


 function RDLDecrypt192(const InString, Pass: PChar): PChar; stdcall;
// var
//  LbRijndael: TLbRijndael;
 begin
 //Descriptografia RDL de 256 bits
{  try
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks192;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := PChar(LbRijndael.DecryptString(InString));

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end;}
end;


 function RDLEncrypt128(const InString, Pass: PChar): PChar; stdcall;
// var
//  LbRijndael: TLbRijndael;
 begin
{  try
 //Criptografia RDL de 128 bits
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks128;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := PChar(LbRijndael.EncryptString(InString));

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end; }
end;


 function RDLDecrypt128(const InString, Pass: PChar): PChar; stdcall;
// var
//  LbRijndael: TLbRijndael;
 begin
{  try
 //Descriptografia RDL de 256 bits
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks128;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.GenerateKey(Pass);
   Result := PChar(LbRijndael.DecryptString(InString));

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end; }
end;

 procedure RDLEncryptFile256(const InputFile, OutPutFile: PChar);
// var
//  LbRijndael: TLbRijndael;
 begin
{  try
 //Criptografa um arquivo usando RDL de 256 bits
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.EncryptFile(InputFile, OutputFile);

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end;}
 end;

 procedure RDLDecryptFile256(const InputFile, OutPutFile: PChar);
// var
//  LbRijndael: TLbRijndael;
 begin
{  try
 //Descriptografa um arquivo usando RDL de 256 bits
   LbRijndael := TLbRijndael.Create(nil);
   LbRijndael.KeySize := ks256;
   LbRijndael.CipherMode := cmECB;
   LbRijndael.DecryptFile(InputFile, OutputFile);

  finally
   if Assigned(LbRijndael) then
    FreeAndNil(LbRijndael);
  end;}
 end;

 function TripleDESEncrypt128(const InString, Pass: PChar): PChar; stdcall;
 begin
 //Criptografia DES de 128 bits
  Result :=  PChar(TCyphers.TripleDesEncrypt128(InString, Pass));
 end;

 function TripleDESDecrypt128(const InString, Pass: PChar): PChar; stdcall;
 begin
 //Descriptografia DES de 128 bits
  Result :=  PChar(TCyphers.TripleDESDecrypt128(InString, Pass));
 end;

 procedure TripleDESEncryptFile128(const InFile, OutFile : PChar);
// var
//  Lb3DES: TLb3DES;
//  Key: TKey128;
 begin
 { try
 //Criptografa um arquivo usando DES de 128 bits
   Lb3DES := TLb3DES.Create(nil);
   Lb3DES.SetKey(Key);

  // ShowMessage(string(inFile) + #13 +string(OutFile));

   Lb3DES.EncryptFile(string(InFile), string(OutFile));

  finally
   if Assigned(Lb3DES) then
    FreeAndNil(Lb3DES);
  end; }
 end;

 procedure TripleDESDecryptFile128(const InFile, OutFile : PChar);
// var
//  Lb3DES: TLb3DES;
//  Key: TKey128;
 begin
{  try
 //Criptografa um arquivo usando DES de 128 bits
   Lb3DES := TLb3DES.Create(nil);
   Lb3DES.SetKey(Key);
   Lb3DES.DecryptFile(string(InFile), string(OutFile));

  finally
   if Assigned(Lb3DES) then
    FreeAndNil(Lb3DES);
  end; }


 end;

 function HashMD5(const InString: PChar):PChar;
 begin
  Result := PChar(THashes.HashMD5(InString));
 end;

 function HashSHA1(const InString: PChar):PChar;
 begin
  Result := PChar(THashes.HashSHA1(InString));
 end;

 function HashSHA224(const InString: PChar):PChar;
 begin
  Result := PChar(THashes.HashSHA224(InString));
 end;

 function HashSHA256(const InString: PChar):PChar;
 begin
  Result := PChar(THashes.HashSHA256(InString));
 end;

 function HashSHA384(const InString: PChar):PChar;
 begin
  Result := PChar(THashes.HashSHA384(InString));
 end;

 function HashSHA512(const InString: PChar):PChar;
 begin
  Result := PChar(THashes.HashSHA512(InString));
 end;

 function Base64Encrypt(const InString : PChar): PChar; stdcall;
 begin
  Result := PChar(TCyphers.Base64Encrypt(InString));
 end;

 function Base64Decrypt(const InString : PChar): PChar; stdcall;
 begin
  Result := PChar(TCyphers.Base64Decrypt(InString));
 end;

 function QuotedPrintableEncrypt(const InString : PChar): PChar; stdcall;
 begin
  Result := PChar(TCyphers.QuotedPrintableEncrypt(InString));
 end;

 function QuotedPrintableDecrypt(const InString : PChar): PChar; stdcall;
 begin
  Result := PChar(TCyphers.QuotedPrintableDecrypt(InString));
 end;


end.
