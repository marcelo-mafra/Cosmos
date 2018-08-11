unit cosmos.classes.cripterint;

{Unidade de interface para uso da biblioteca CRIPTER.DLL. Essa biblioteca é responsável por prover diversos mecanismos
de criptografia e hash.}

interface

 function SimpleEncrypt(Text: PChar; var code: integer): PChar; stdcall;
 function SimpleDecrypt(Text: PChar; var code: integer): PChar; stdcall;
 function HexEncrypt(s: PChar; var Key: word): PChar; stdcall;
 function HexDecrypt(s: PChar; var Key: word): PChar; stdcall;
 function Base64Encrypt(const InString: PChar): PChar; stdcall;
 function Base64Decrypt(const InString: PChar): PChar; stdcall;
 function BlowfishEncrypt128(const InString, Pass : PWideChar): PWideChar; stdcall;
 function BlowfishDecrypt128(const InString, Pass : PWideChar): PWideChar; stdcall;
 function DesEncrypt64(const InString, Pass: PChar): PChar; stdcall;
 function DesDecrypt64(const InString, Pass: PChar): PChar; stdcall;
 function QuotedPrintableEncrypt(const InString: PChar): PChar; stdcall;
 function QuotedPrintableDecrypt(const InString : PChar): PChar; stdcall;
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



implementation

 function SimpleEncrypt; external 'CRIPTER.DLL' name 'SimpleEncrypt';
 function SimpleDecrypt; external 'CRIPTER.DLL' name 'SimpleEncrypt';
 function HexEncrypt; external 'CRIPTER.DLL' name 'HexEncrypt';
 function HexDecrypt; external 'CRIPTER.DLL' name 'HexDecrypt';
 function Base64Encrypt; external 'CRIPTER.DLL' name 'Base64Encrypt';
 function Base64Decrypt; external 'CRIPTER.DLL' name 'Base64Decrypt';
 function BlowfishEncrypt128; external 'CRIPTER.DLL' name 'BlowfishEncrypt128';
 function BlowfishDecrypt128; external 'CRIPTER.DLL' name 'BlowfishDecrypt128';
 function DesEncrypt64; external 'CRIPTER.DLL' name 'DesEncrypt64';
 function DesDecrypt64; external 'CRIPTER.DLL' name 'DesDecrypt64';
 function QuotedPrintableEncrypt; external 'CRIPTER.DLL' name 'QuotedPrintableEncrypt';
 function QuotedPrintableDecrypt; external 'CRIPTER.DLL' name 'QuotedPrintableDecrypt';
 function TripleDesEncrypt128; external 'CRIPTER.DLL' name 'TripleDesEncrypt128';
 function TripleDESDecrypt128; external 'CRIPTER.DLL' name 'TripleDESDecrypt128';
 function RDLEncrypt256; external 'CRIPTER.DLL' name 'RDLEncrypt256';
 function RDLDecrypt256; external 'CRIPTER.DLL' name 'RDLDecrypt256';
 function RDLEncrypt192; external 'CRIPTER.DLL' name 'RDLEncrypt192';
 function RDLDecrypt192; external 'CRIPTER.DLL' name 'RDLDecrypt192';
 function RDLEncrypt128; external 'CRIPTER.DLL' name 'RDLEncrypt128';
 function RDLDecrypt128; external 'CRIPTER.DLL' name 'RDLDecrypt128';
 procedure RDLEncryptFile256; external 'CRIPTER.DLL' name 'RDLEncryptFile256';
 procedure RDLDecryptFile256; external 'CRIPTER.DLL' name 'RDLDecryptFile256';
 procedure TripleDESEncryptFile128; external 'CRIPTER.DLL' name 'TripleDESEncryptFile128';
 procedure TripleDESDecryptFile128; external 'CRIPTER.DLL' name 'TripleDESDecryptFile128';
 function HashMD5(const InString: PChar):PChar; external 'CRIPTER.DLL' name 'HashMD5';
 function HashSHA1(const InString: PChar):PChar; external 'CRIPTER.DLL' name 'HashSHA1';
 function HashSHA224(const InString: PChar):PChar; external 'CRIPTER.DLL' name 'HashSHA224';
 function HashSHA256(const InString: PChar):PChar; external 'CRIPTER.DLL' name 'HashSHA256';
 function HashSHA384(const InString: PChar):PChar; external 'CRIPTER.DLL' name 'HashSHA384';
 function HashSHA512(const InString: PChar):PChar; external 'CRIPTER.DLL' name 'HashSHA512';

end.
