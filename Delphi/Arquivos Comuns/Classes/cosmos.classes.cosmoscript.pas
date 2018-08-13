unit cosmos.classes.cosmoscript;

interface

uses
 cosmos.classes.cripter;

type

 //Chaves de criptografia usadas pelo Cosmos.
 TCosmosCriptography = class
    const
      EKey = '8517536429'; //do not localize!
      CipherKey = '8954605'; //do not localize!
 end;

 //Utiize sempre essa classe quando precisar de trabalhar com criptografia.
 TCripterFactory = class
  class function Criptografar(const Text: string): string;
  class function Descriptografar(Text: string): string;
  class function HashValue(Text: string): string;

 end;

implementation

{ TCripterFactory }

class function TCripterFactory.Criptografar(const Text: string): string;
var
 aCripter: TCripter;
begin
//Criptografa uma string pelo padrão Blowfish 128 bits.
 aCripter := TCripter.Create;

 try
  Result := aCripter.Encrypt(cmBlowfish128, TCosmosCriptography.CipherKey, Text);

 finally
  aCripter.Free;
 end;
end;

class function TCripterFactory.Descriptografar(Text: string): string;
var
 aCripter: TCripter;
begin
//Descriptografa uma string pelo padrão Blowfish 128 bits.
 aCripter := TCripter.Create;

 try
  Result := aCripter.Decrypt(cmBlowfish128, TCosmosCriptography.CipherKey, Text);

 finally
  aCripter.Free;
 end;
end;


class function TCripterFactory.HashValue(Text: string): string;
var
 aCripter: TCripter;
begin
 {Faz um hash SHA512 com um texto.}
 aCripter := TCripter.Create;

 try
  Result := aCripter.HashValue(hmSHA512, Text);

 finally
  aCripter.Free;
 end;
end;

end.

