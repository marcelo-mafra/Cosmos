library cripter;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }



uses
  UExplib in 'UExplib.pas',
  UHashes in 'UHashes.pas',
  UCyphers in 'UCyphers.pas';

{$R *.res}

exports
  SimpleEncrypt,
  SimpleDecrypt,
  HexEncrypt,
  HexDecrypt,
  BlowfishEncrypt128,
  BlowfishDecrypt128,
  DesEncrypt64,
  DesDecrypt64,
  TripleDESEncrypt128,
  TripleDESDecrypt128,
  TripleDESEncryptFile128,
  TripleDESDecryptFile128,
  RDLEncrypt256,
  RDLDecrypt256,
  RDLEncrypt192,
  RDLDecrypt192,
  RDLEncrypt128,
  RDLDecrypt128,
  RDLEncryptFile256,
  RDLDecryptFile256,
  HashMD5,
  HashSHA1,
  HashSHA224,
  HashSHA256,
  HashSHA384,
  HashSHA512,
  Base64Encrypt,
  Base64Decrypt,
  QuotedPrintableEncrypt,
  QuotedPrintableDecrypt;


begin
end.
