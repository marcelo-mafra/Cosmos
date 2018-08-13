unit cosmos.classes.cripter;

interface
{Implementa um classe "interna" que disponibiliza inúmeros métodos de criptografia
 e hash. Essa classe não deve ser usada diretamente por nenhum módulo.}

uses cosmos.classes.cripterint;

 type
  //Padrões de criptografias.
  TCriptModel = (cmSimple, cmHex, cmBlowfish128, cmDES64, cmTripleDES128,
    cmRDL256, cmRDL192, cmRDL128, cmBase64, cmQuotedPrintable);

  //Padrões de hashes.
  THashModel = (hmSHA1, hmSHA224, hmSHA256, hmSHA384, hmSHA512, hmMD5);

  {Classe invólucro para as procedures exportadas em cripter.dll}
  TCripter = class
  private
   function DoSimpleEncrypt(Text: PChar; var code: integer): PChar;
   function DoSimpleDecrypt(Text: PChar; var code: integer): PChar;
   function DoHexEncrypt(s: PChar; var Key: word): PChar;
   function DoHexDecrypt(s: PChar; var Key: word): PChar;
   function DoBase64Encrypt(const InString: PChar): PChar;
   function DoBase64Decrypt(const InString: PChar): PChar;
   function DoBlowfishEncrypt128(const InString, Pass : PChar): PChar;
   function DoBlowfishDecrypt128(const InString, Pass : PChar): PChar;
   function DoDesEncrypt64(const InString, Pass: PChar): PChar;
   function DoDesDecrypt64(const InString, Pass: PChar): PChar;
   function DoQuotedPrintableEncrypt(const InString: PChar): PChar;
   function DoQuotedPrintableDecrypt(const InString : PChar): PChar;
   function DoTripleDesEncrypt128(const InString, Pass: PChar): PChar;
   function DoTripleDESDecrypt128(const InString, Pass: PChar): PChar;
   function DoRDLEncrypt256(const InString, Pass: PChar): PChar;
   function DoRDLDecrypt256(const InString, Pass: PChar): PChar;
   function DoRDLEncrypt192(const InString, Pass: PChar): PChar;
   function DoRDLDecrypt192(const InString, Pass: PChar): PChar;
   function DoRDLEncrypt128(const InString, Pass: PChar): PChar;
   function DoRDLDecrypt128(const InString, Pass: PChar): PChar;
   procedure DoRDLEncryptFile256(const InputFile, OutPutFile: PChar);
   procedure DoRDLDecryptFile256(const InputFile, OutPutFile: PChar);
   procedure DoTripleDESEncryptFile128(const InFile, OutFile : PChar);
   procedure DoTripleDESDecryptFile128(const InFile, OutFile : PChar);
   function DoHashMD5(const InString: PChar):PChar;
   function DoHashSHA1(const InString: PChar):PChar;
   function DoHashSHA224(const InString: PChar):PChar;
   function DoHashSHA256(const InString: PChar):PChar;
   function DoHashSHA384(const InString: PChar):PChar;
   function DoHashSHA512(const InString: PChar):PChar;

  public
    constructor Create;
    destructor Destroy; override;

    function Encrypt(Model: TCriptModel; Key, Text: string): string;
    function Decrypt(Model: TCriptModel; Key, Text: string): string;
    function HashValue(Model: THashModel; const Text: string): string;


 end;

implementation

{ TCripter }

procedure TCripter.DoTripleDESEncryptFile128(const InFile, OutFile: PChar);
begin
  TripleDESEncryptFile128(InFile, OutFile);
end;

function TCripter.DoTripleDesEncrypt128(const InString, Pass: PChar): PChar;
begin
  Result := TripleDesEncrypt128(InString, Pass);
end;

procedure TCripter.DoRDLEncryptFile256(const InputFile, OutPutFile: PChar);
begin
 RDLEncryptFile256(InputFile, OutputFile);
end;

function TCripter.DoRDLEncrypt256(const InString, Pass: PChar): PChar;
begin
  Result := RDLEncrypt256(InString, Pass);
end;

function TCripter.DoBase64Decrypt(const InString: PChar): PChar;
begin
 Result := Base64Decrypt(InString);
end;

function TCripter.DoBase64Encrypt(const InString: PChar): PChar;
begin
 Result := Base64Encrypt(InString);
end;

function TCripter.DoBlowfishDecrypt128(const InString, Pass: PChar): PChar;
begin
  Result := BlowfishDecrypt128(InString, Pass);
end;

function TCripter.DoHexEncrypt(s: PChar; var Key: word): PChar;
begin
 Result := HexEncrypt(s, Key);
end;

function TCripter.DoQuotedPrintableDecrypt(const InString: PChar): PChar;
begin
 Result := QuotedPrintableDecrypt(InString);
end;

function TCripter.DoQuotedPrintableEncrypt(const InString: PChar): PChar;
begin
 Result := QuotedPrintableEncrypt(InString);
end;

procedure TCripter.DoTripleDESDecryptFile128(const InFile, OutFile: PChar);
begin
  TripleDESDecryptFile128(InFile, OutFile);
end;

function TCripter.DoTripleDESDecrypt128(const InString, Pass: PChar): PChar;
begin
  Result := TripleDESDecrypt128(InString, Pass);
end;

procedure TCripter.DoRDLDecryptFile256(const InputFile, OutPutFile: PChar);
begin
 RDLDecryptFile256(InputFile, OutputFile);
end;

function TCripter.DoRDLDecrypt256(const InString, Pass: PChar): PChar;
begin
  Result := RDLDecrypt256(InString, Pass);
end;

function TCripter.DoHexDecrypt(s: PChar; var Key: word): PChar;
begin
 Result := HexDecrypt(s, Key);
end;

function TCripter.DoRDLEncrypt128(const InString, Pass: PChar): PChar;
begin
 Result := RDLEncrypt128(InString, Pass);
end;

function TCripter.DoDesEncrypt64(const InString, Pass: PChar): PChar;
begin
 Result := DesDecrypt64(InString, Pass);
end;

function TCripter.DoRDLEncrypt192(const InString, Pass: PChar): PChar;
begin
 Result := RDLEncrypt192(InString, Pass);
end;

function TCripter.DoSimpleEncrypt(Text: PChar; var code: integer): PChar;
begin
 Result := SimpleEncrypt(Text, code);
end;

function TCripter.Encrypt(Model: TCriptModel; Key, Text: string): string;
var
 IntCode: Integer;
 WordCode: word;
begin
 IntCode := 1024;
 WordCode := 1024;

 case Model of
  cmSimple: Result := DoSimpleEncrypt(PWideCHar(text), IntCode);
  cmHex: Result := DoHexEncrypt(PWideCHar(text), WordCode);
  cmBlowfish128: Result := DoBlowfishEncrypt128(PWideCHar(text), PWideChar(Key));
  cmDES64: Result := DoDESEncrypt64(PWideChar(Text), PWideChar(Key));
  cmTripleDES128: Result := DoTripleDESEncrypt128(PWideChar(Text), PWideChar(Key));
  cmRDL256: Result := DoRDLEncrypt256(PWideChar(Text), PWideChar(Key));
  cmRDL192: Result := DoRDLEncrypt192(PWideChar(Text), PWideChar(Key));
  cmRDL128: Result := DoRDLEncrypt128(PWideChar(Text), PWideChar(Key));
  cmBase64: Result := DoBase64Encrypt(PWideChar(Text));
  cmQuotedPrintable: Result := DoQuotedPrintableEncrypt(PWideChar(Text));
 end;
end;

function TCripter.Decrypt(Model: TCriptModel; Key, Text: string): string;
var
 IntCode: Integer;
 WordCode: word;
begin
 IntCode := 1024;
 WordCode := 1024;

 case Model of
  cmSimple: Result := DoSimpleDecrypt(PWideCHar(text), IntCode);
  cmHex: Result := DoHexDecrypt(PWideCHar(text), WordCode);
  cmBlowfish128: Result := DoBlowfishDecrypt128(PWideCHar(text), PWideCHar(Key));
  cmDES64: Result := DoDESDecrypt64(PWideCHar(Text), PWideCHar(Key));
  cmTripleDES128: Result := DoTripleDESDecrypt128(PWideCHar(Text), PWideCHar(Key));
  cmRDL256: Result := DoRDLDecrypt256(PWideCHar(Text), PWideCHar(Key));
  cmRDL192: Result := DoRDLDecrypt192(PWideCHar(Text), PWideCHar(Key));
  cmRDL128: Result := DoRDLDecrypt128(PWideCHar(Text), PWideCHar(Key));
  cmBase64: Result := DoBase64Decrypt(PWideChar(Text));
  cmQuotedPrintable: Result := DoQuotedPrintableDecrypt(PWideChar(Text));
 end;
end;

function TCripter.DoBlowfishEncrypt128(const InString, Pass: PChar): PChar;
begin
 Result := BlowfishEncrypt128(InString, Pass);
end;

function TCripter.DoRDLDecrypt128(const InString, Pass: PChar): PChar;
begin
 Result := RDLDecrypt128(InString, Pass);
end;

function TCripter.DoDesDecrypt64(const InString, Pass: PChar): PChar;
begin
 Result := DesDecrypt64(InString, Pass);
end;

function TCripter.DoRDLDecrypt192(const InString, Pass: PChar): PChar;
begin
 Result := RDLDecrypt192(InString, Pass);
end;

function TCripter.DoSimpleDecrypt(Text: PChar; var code: integer): PChar;
begin
 Result := SimpleDecrypt(Text, Code);
end;

constructor TCripter.Create;
begin
 inherited Create;
end;

destructor TCripter.Destroy;
begin
  inherited Destroy;
end;

function TCripter.DoHashMD5(const InString: PChar): PChar;
begin
 Result := cosmos.classes.cripterint.HashMD5(InString);
end;

function TCripter.DoHashSHA1(const InString: PChar): PChar;
begin
 Result := HashSHA1(InString);
end;

function TCripter.DoHashSHA224(const InString: PChar): PChar;
begin
 Result := HashSHA224(InString);
end;

function TCripter.DoHashSHA256(const InString: PChar): PChar;
begin
 Result := HashSHA256(InString);
end;

function TCripter.DoHashSHA384(const InString: PChar): PChar;
begin
 Result := HashSHA384(InString);
end;

function TCripter.DoHashSHA512(const InString: PChar): PChar;
begin
 Result := HashSHA512(InString);
end;

function TCripter.HashValue(Model: THashModel; const Text: string): string;
begin
 case Model of
   hmSHA1: Result := DoHashSHA1(PWideCHar(Text));
   hmSHA224: Result := DoHashSHA224(PWideCHar(Text));
   hmSHA256: Result := DoHashSHA256(PWideCHar(Text));
   hmSHA384: Result := DoHashSHA384(PWideCHar(Text));
   hmSHA512: Result := DoHashSHA512(PWideCHar(Text));
   hmMD5: Result := DoHashMD5(PWideCHar(Text));
 end;
end;


end.

