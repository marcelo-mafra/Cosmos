unit UHashes;

interface

uses
  IdHashMessageDigest, IdHashSHA, IdGlobal, IdSSLOpenSSL;

  type
   THashes = class
    private

    public
     class function HashMD5(const Text: string):string;
     class function HashSHA1(const Text: string):string;
     class function HashSHA224(const Text: string):string;
     class function HashSHA256(const Text: string):string;
     class function HashSHA384(const Text: string):string;
     class function HashSHA512(const Text: string):string;
   end;


implementation

{ THashes }

class function THashes.HashMD5(const Text: string): string;
var
  IdMD5 : TIdHashMessageDigest5;
begin
 IdMD5 := TIdHashMessageDigest5.Create;

 try
   result := IdMD5.HashStringAsHex(Text);

 finally
   IdMD5.Free;
  end;
end;

class function THashes.HashSHA1(const Text: string): string;
var
 ISha1: TIdHashSHA1;
begin
 ISha1 :=  TIdHashSHA1.Create;

 try
   Result := ISha1.HashStringAsHex(Text);

 finally
  ISha1.Free;
 end;
end;

class function THashes.HashSHA224(const Text: string): string;
var
 ISha224: TIdHashSHA224;
begin
 ISha224 :=  TIdHashSHA224.Create;
 LoadOpenSSLLibrary;

 if TIdHashSHA224.IsAvailable then
  begin
   try
    Result :=  ISha224.HashStringAsHex(Text);

   finally
    ISha224.Free;
   end;
  end;
end;

class function THashes.HashSHA256(const Text: string): string;
var
 ISha256: TIdHashSHA256;
begin
 ISha256 :=  TIdHashSHA256.Create;
 LoadOpenSSLLibrary;

 if TIdHashSHA256.IsAvailable then
  begin
   try
    Result :=  ISha256.HashStringAsHex(Text);

   finally
    ISha256.Free;
   end;
  end;
end;

class function THashes.HashSHA384(const Text: string): string;
var
 ISha384: TIdHashSHA384;
begin
 ISha384 :=  TIdHashSHA384.Create;
 LoadOpenSSLLibrary;

 if TIdHashSHA384.IsAvailable then
  begin
   try
    Result :=  ISha384.HashStringAsHex(Text);

   finally
    ISha384.Free;
   end;
  end;
end;

class function THashes.HashSHA512(const Text: string): string;
var
 ISha512: TIdHashSHA512;
begin
 ISha512 :=  TIdHashSHA512.Create;
 LoadOpenSSLLibrary;

 if TIdHashSHA512.IsAvailable then
  begin
   try
    Result :=  ISha512.HashStringAsHex(Text);

   finally
    ISha512.Free;
   end;
  end;
end;

end.
