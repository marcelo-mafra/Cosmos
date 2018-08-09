unit VerInfo;

interface

uses SysUtils, WinTypes,  Classes;

type
  { define uma classe de exceção genérica para informações de versão e para
    indicar que não existe informações de versão.}
  EVerInfoError   = class(Exception);
  ENoVerInfoError = class(Exception);
  eNoFixeVerInfo  = class(Exception);

  // define um tipo enumerado representando diferentes tipos de informação de versão
  TVerInfoType =
    (viCompanyName,
     viFileDescription,
     viFileVersion,
     viInternalName,
     viLegalCopyright,
     viLegalTrademarks,
     viOriginalFilename,
     viProductName,
     viProductVersion,
     viComments);

const

  { Define um array de constantes de strings representando as chaves de
    informações de versão.}
  VerNameArray: array[viCompanyName..viComments] of String[20] =
  ('CompanyName',
   'FileDescription',
   'FileVersion',
   'InternalName',
   'LegalCopyright',
   'LegalTrademarks',
   'OriginalFileName',
   'ProductName',
   'ProductVersion',
   'Comments');

  VerTraducaoArray: array[viCompanyName..viComments] of String[20] =
  ('Empresa',
   'Descrição',
   'Versão do arquivo',
   'Nome interno',
   'Copyright',
   'Trademarks',
   'Nome original',
   'Nome do produto',
   'Versão do produto',
   'Comentários');

type

  // Define a classe de informação de versão.
  TVerInfoRes = class
  private
    Handle            : DWord;
    Size              : Integer;
    RezBuffer         : String;
    TransTable        : PLongint;
    FixedFileInfoBuf  : PVSFixedFileInfo;
    FFileFlags        : TStringList;
    FFileName         : String;
    procedure FillFixedFileInfoBuf;
    procedure FillFileVersionInfo;
    procedure FillFileMaskInfo;

  protected
    function GetFileVersion   : String;
    function GetProductVersion: String;
    function GetFileOS        : String;

  public
    constructor Create(AFileName: String);
    destructor Destroy; override;
    function GetPreDefKeyString(AVerKind: TVerInfoType): String;
    function GetUserDefKeyString(AKey: String): String;
    function HasVersionInfo(FileName: string): boolean;
    function IsWindows64: Boolean;

    property FileVersion    : String read GetFileVersion;
    property ProductVersion : String read GetProductVersion;
    property FileFlags      : TStringList read FFileFlags;
    property FileOS         : String read GetFileOS;


  end;

implementation

uses Windows;

const
  // strings que são passadas para o método VerQueryValue().
  SFInfo                = '\StringFileInfo\';
  VerTranslation: PChar = '\VarFileInfo\Translation';
  FormatStr             = '%s%.4x%.4x\%s%s';


constructor TVerInfoRes.Create(AFileName: String);
begin
  FFileName := aFileName;
  FFileFlags := TStringList.Create;
  // Obtém informação da versão do arquivo
  FillFileVersionInfo;

  FillFixedFileInfoBuf;
  // Obtém os valores da máscara do arquivo
  FillFileMaskInfo;
end;


destructor TVerInfoRes.Destroy;
begin
  FFileFlags.Free;
end;

procedure TVerInfoRes.FillFileVersionInfo;
var
  SBSize: UInt;
begin
  // Determina o tamanho da informação de versão.
  Size := GetFileVersionInfoSize(PChar(FFileName), Handle);
  if Size <= 0 then
         { raise exception if size <= 0 }
   raise ENoVerInfoError.Create('No Version Info Available.');

  // Configura o tamanho
  SetLength(RezBuffer, Size);
  // Preenche o buffer com a informação da versão.
  if not GetFileVersionInfo(PChar(FFileName), Handle, Size, PChar(RezBuffer)) then
    raise EVerInfoError.Create('Cannot obtain version info.');

  // Obtém informação da tradução
  if not VerQueryValue(PChar(RezBuffer), VerTranslation,  pointer(TransTable),
  SBSize) then
    raise EVerInfoError.Create('No language info.');
end;

procedure TVerInfoRes.FillFixedFileInfoBuf;
var
  Size: Cardinal;
begin
  if VerQueryValue(PChar(RezBuffer), '\', Pointer(FixedFileInfoBuf), Size) then begin
     if Size < SizeOf(TVSFixedFileInfo) then
        raise eNoFixeVerInfo.Create('No fixed file info');
  end
  else
    raise eNoFixeVerInfo.Create('No fixed file info')
end;

procedure TVerInfoRes.FillFileMaskInfo;
begin
  with FixedFileInfoBuf^ do begin
    if (dwFileFlagsMask and dwFileFlags and VS_FF_PRERELEASE) <> 0then
      FFileFlags.Add('Pre-release');
    if (dwFileFlagsMask and dwFileFlags and VS_FF_PRIVATEBUILD) <> 0 then
      FFileFlags.Add('Private build');
    if (dwFileFlagsMask and dwFileFlags and VS_FF_SPECIALBUILD) <> 0 then
      FFileFlags.Add('Special build');
    if (dwFileFlagsMask and dwFileFlags and VS_FF_DEBUG) <> 0 then
      FFileFlags.Add('Debug');
  end;
end;

function TVerInfoRes.GetPreDefKeyString(AVerKind: TVerInfoType): String;
var
  P: PChar;
  S: UInt;
begin
  Result := Format(FormatStr, [SfInfo, LoWord(TransTable^),HiWord(TransTable^),
    VerNameArray[aVerKind], #0]);

  if VerQueryValue(PChar(RezBuffer), @Result[1], Pointer(P), S) then
    Result := StrPas(P)
  else
    Result := '';
end;

function TVerInfoRes.GetUserDefKeyString(AKey: String): String;
var
  P: Pchar;
  S: UInt;
begin
  Result := Format(FormatStr, [SfInfo, LoWord(TransTable^),HiWord(TransTable^),
    aKey, #0]);

  if VerQueryValue(PChar(RezBuffer), @Result[1], Pointer(P), S) then
    Result := StrPas(P)
  else
    Result := '';
end;


function TVerInfoRes.HasVersionInfo(FileName: string): boolean;
var
  Size: DWord;
begin
  Size := GetFileVersionInfoSize(PChar(FileName), Handle);
  Result := Size > 0;
end;

function TVerInfoRes.IsWindows64: Boolean;
//forum.codecall.net/topic/60111-how-to-detect-windows-64bit-with-delphi-code/#ixzz2G5ZI5TA3
type
 TIsWow64Process = function(AHandle:THandle; var AIsWow64: BOOL): BOOL; stdcall;
var
 vKernel32Handle: DWORD;
 vIsWow64Process: TIsWow64Process;
 vIsWow64         : BOOL;
begin
 // 1) assume that we are not running under Windows 64 bit
 Result := False;
// 2) Load kernel32.dll library
 vKernel32Handle := LoadLibrary('kernel32.dll');
 if (vKernel32Handle = 0) then Exit; // Loading kernel32.dll was failed, just return
  try
   // 3) Load windows api IsWow64Process
   @vIsWow64Process := GetProcAddress(vKernel32Handle, 'IsWow64Process');
   if not Assigned(vIsWow64Process) then Exit; // Loading IsWow64Process was failed, just return
   // 4) Execute IsWow64Process against our own process
   vIsWow64 := False;
   if (vIsWow64Process(GetCurrentProcess, vIsWow64)) then
    Result := vIsWow64;   // use the returned value

  finally
   FreeLibrary(vKernel32Handle);  // unload the library
  end;
end;

function VersionString(Ms, Ls: Longint): String;
begin
  Result := Format('%d.%d.%d.%d', [HIWORD(Ms), LOWORD(Ms),
     HIWORD(Ls), LOWORD(Ls)]);
end;

function TVerInfoRes.GetFileVersion: String;
begin
  with FixedFileInfoBuf^ do
    Result := VersionString(dwFileVersionMS, dwFileVersionLS);
end;

function TVerInfoRes.GetProductVersion: String;
begin
  with FixedFileInfoBuf^ do
    Result := VersionString(dwProductVersionMS, dwProductVersionLS);
end;

function TVerInfoRes.GetFileOS: String;
begin
  with FixedFileInfoBuf^ do
    case dwFileOS of
      VOS_UNKNOWN:  // Mesmo que VOS__BASE
        Result := 'Unknown';
      VOS_DOS:
        Result := 'Designed for MS-DOS';
      VOS_OS216:
        Result := 'Designed for 16-bit OS/2';
      VOS_OS232:
        Result := 'Designed for 32-bit OS/2';
      VOS_NT:
        Result := 'Designed for Windows NT';


      VOS__WINDOWS16:
        Result := 'Designed for 16-bit Windows';
      VOS__PM16:
        Result := 'Designed for 16-bit PM';
      VOS__PM32:
        Result := 'Designed for 32-bit PM';
      VOS__WINDOWS32:
        Result := 'Designed for 32-bit Windows';

      VOS_DOS_WINDOWS16:
        Result := 'Designed for 16-bit Windows, running on MS-DOS';
      VOS_DOS_WINDOWS32:
        Result := 'Designed for Win32 API, running on MS-DOS';
      VOS_OS216_PM16:
        Result := 'Designed for 16-bit PM, running on 16-bit OS/2';
      VOS_OS232_PM32:
        Result := 'Designed for 32-bit PM, running on 32-bit OS/2';
      VOS_NT_WINDOWS32:
        Result := 'Designed for Win32 API, running on Windows/NT';
    else
      Result := 'Unknown';
    end;
end;


end.
