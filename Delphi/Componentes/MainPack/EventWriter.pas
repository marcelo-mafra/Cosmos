unit EventWriter;

interface

uses
  Windows, SysUtils, Classes, SvcMgr;

const

CAT_SUCESS = $0001;
CAT_INFO = $0002;
CAT_WARNING = $0003;
CAT_ERROR = $0004;
CAT_UNKNOWN = $0005;
CAT_AUTENTICACAO = $0006;

type
  TEventWriter = class(TComponent)

  private
    { Private declarations }
    FDisplayNameFile, FEventFile, FDisplayEventFile, FDisplayEventID, FCategoryMessageFile: string;
    FPrimaryModule, FLogName, FSource: string;
    FDisplayNameID, FCategoryCount,FTypesSupported: integer;
    FCustomLog: string;
    procedure Write_MULTI_SZ_Strings(const valueName: string; strings: TStrings);

  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   procedure CreateEventLog;
   procedure WriteLog(const source, msg: string; LogType, LogCategory, Id: cardinal);

  published
    { Public declarations }
    property Tag;
    property DisplayNameFile: string read FDisplayNameFile write FDisplayNameFile;
    property EventFile: string read FEventFile write FEventFile;
    property DisplayEventFile: string read FDisplayEventFile write FDisplayEventFile;
    property DisplayEventID: string read FDisplayEventID write FDisplayEventID;
    property PrimaryModule: string read FPrimaryModule write FPrimaryModule;
    property Source: string read FSource write FSource;
    property LogName: string read FLogName write FLogName;
    property CategoryMessageFile: string read FCategoryMessageFile write FCategoryMessageFile;
    property CategoryCount: integer read FCategoryCount write FCategoryCount;
    property DisplayNameID: integer read FDisplayNameID write FDisplayNameID;
    property TypesSupported: integer read FTypesSupported write FTypesSupported;

  end;

procedure Register;

implementation


type
  pArray = ^tArray;
  tArray = array[0..64535] of char;

procedure Register;
begin
  RegisterComponents('Win32', [TEventWriter]);
end;

constructor TEventWriter.Create(AOwner: TComponent);
begin
 inherited create(AOwner);
 FCustomLog := 'System\CurrentControlSet\Services\EventLog\' + FLogName;
end;

destructor TEventWriter.destroy;
begin
 inherited destroy;
end;

procedure TEventWriter.Write_MULTI_SZ_Strings(const valueName: string;
  strings: TStrings);
var
  buffer: pArray;
  i, size: integer;
  TempKey: HKEY;
begin
  size := 0;
  for i := 0 to strings.Count - 1 do
    size := size + length(strings[i]) + 1;
  inc(size);
  GetMem (buffer, size);
  fillchar(buffer^, 0, size);
  try
    size := 0;
    for i := 0 to strings.count - 1 do
    begin
      move(strings[i][1],buffer^[size],length(strings[i]));
      inc(size, length(strings[i])+1);
    end;
    inc(size);
    if RegOpenKeyEx(HKEY_LOCAL_MACHINE, PChar(FCustomLog),
                                  0, KEY_WRITE, TempKey) = ERROR_SUCCESS then
    try
      if RegSetValueEx(TempKey, PChar(valueName),
                         0, REG_MULTI_SZ, buffer, size) <> ERROR_SUCCESS then
        raise Exception.Create('Falha na escrita de valor MULTI_SZ.');
    finally
      RegCloseKey(TempKey);
    end;
  finally
    FreeMem (buffer)
  end
end;

procedure TEventWriter.WriteLog(const source, msg: string; LogType, LogCategory,
  Id: cardinal);
begin
  CreateEventLog();

  with TEventLogger.create(FSource) do
  try
    LogMessage(msg, LogType,LogCategory, Id);
  finally
    free;
  end;
end;

procedure TEventWriter.CreateEventLog;
var
  size: integer;
  s: string;
  TempKey: HKEY;
  fDisposition: pointer;
  fStrings: TStringlist;

begin
  FCustomLog := 'System\CurrentControlSet\Services\EventLog\' + FLogName;
  fDisposition := nil;
  if RegOpenKeyEx(HKEY_LOCAL_MACHINE, PChar(FCustomLog),
          0, KEY_READ, TempKey) <> ERROR_SUCCESS then
    begin
      if RegCreateKeyEx(HKEY_LOCAL_MACHINE, Pchar(FCustomLog),
                           0, nil, REG_OPTION_NON_VOLATILE, KEY_WRITE, nil,
                                  TempKey, fDisposition) = ERROR_SUCCESS then
      begin
        s := '%SystemRoot%\System32\' + FDisplayNameFile;
        size := length(s);
        RegSetValueEx (TempKey, 'DisplayNameFile',
                                          0, REG_EXPAND_SZ, pchar(s), size);

        size := FDisplayNameID;// ID da tabela de strings na dll de recursos. É usada pelo Visualizador de Eventos
        RegSetValueEx (TempKey, 'DisplayNameID',
                                          0, REG_DWORD, @size, sizeof(size));

        s := '%SystemRoot%\System32\config\' + FEventFile;
        size := length(s);
        RegSetValueEx (TempKey, 'File', 0, REG_EXPAND_SZ, pchar(s), size);

        size := $80000; // 512kb Tamanho máximo do arquivo de log
              //$40000  =  256kb (262144) bytes
        RegSetValueEx (TempKey, 'MaxSize', 0, REG_DWORD, @size, sizeof(size));

        s := FPrimaryModule;
        size := length(s);
        RegSetValueEx (TempKey, 'PrimaryModule', 0, REG_SZ, pchar(s), size);

           size := 604800; // Sobrescrever mensagens postadas há mais de 7 dias
                        // 604800 = 60/seg * 60/min * 24/hs * 7/dias
                        // $00000000 - indica a mensagem será sobrecrita se necessário.
                        // $ffffffff - indica que a mensagem nunca deve ser sobrecrita
        RegSetValueEx (TempKey, 'Retention',0,REG_DWORD,@size, sizeof(size));
        RegCloseKey(TempKey);

        fStrings := TStringlist.create;
        fStrings.add(FSource);     // Define uma fonte conhecida de mensagens
        Write_MULTI_SZ_Strings('Sources', fStrings);
        fStrings.free;
      end;
    end;

  //Cria as subchaves...
  if RegOpenKeyEx(HKEY_LOCAL_MACHINE, PChar(FCustomLog + '\' + fsource),
          0, KEY_READ, TempKey) <> ERROR_SUCCESS then
   begin
    if RegCreateKeyEx(HKEY_LOCAL_MACHINE, PChar(FCustomLog + '\' + fsource),
         0, nil, REG_OPTION_NON_VOLATILE, KEY_WRITE, nil, TempKey,
        fDisposition) = ERROR_SUCCESS then
    begin
     s := '%SystemRoot%\system32\' + FCategoryMessageFile;
     size := length(s);
     RegSetValueEx (TempKey,'CategoryMessageFile', 0, REG_EXPAND_SZ,
                   pchar(s), size);
     RegSetValueEx (TempKey, 'EventMessageFile', 0, REG_EXPAND_SZ,
                   pchar(s), size);
     size := FCategoryCount;
     RegSetValueEx (TempKey, 'CategoryCount', 0, REG_DWORD, @size, sizeof(size));
     size := FTypesSupported;
     RegSetValueEx (TempKey, 'TypesSupported', 0, REG_DWORD, @size, sizeof(size));
     RegCloseKey(TempKey);
   end
   else
    RegCloseKey(TempKey);
 end
 else
  RegCloseKey(TempKey);
end;

end.
