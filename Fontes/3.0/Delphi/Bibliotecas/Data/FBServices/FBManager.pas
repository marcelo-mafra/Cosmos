unit FBManager;

interface

type
  TFBManager = class
    class function IsFBRunning(): boolean;
    class procedure StartGuardian();
    class procedure StartServer();
    class procedure StopServer();
  end;

implementation
uses
{$IFDEF MSWINDOWS}
  Windows, Messages, Registry,
{$ENDIF}
{$IFDEF LINUX}

{$ENDIF}
  SysUtils, Variants;

class function TFBManager.IsFBRunning(): boolean;
begin
{$IFDEF MSWINDOWS}
  Result := GetWindow(GetDesktopWindow, GW_HWNDNEXT) <> FindWindow('FB_Server', 'Firebird Server');
{$ENDIF}
{$IFDEF LINUX}
  Result := TRUE;
{$ENDIF}
end;

class procedure TFBManager.StartGuardian();
{$IFDEF MSWINDOWS}
var
  lRegistry: TRegistry;
  lEXEName: string;
  lArray: array[0..255] of char;
  lStartUpInfo: STARTUPINFO;
  lSecurityAttr: SECURITY_ATTRIBUTES;
  lProcessInfo: PROCESS_INFORMATION;

{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  lRegistry := TRegistry.Create;
  try
    lRegistry.RootKey := HKEY_LOCAL_MACHINE;
    if not lRegistry.OpenKey('Software\Firebird Project\Firebird Server\Instances',False) then
      raise Exception.Create('O Firebird SQL Server parece não estar instalado no seu computador.')
    else
      lEXEName := Format('%s%s ',[lRegistry.ReadString('DefaultInstance'),'bin\fbguard.exe']);

      // use CreateProcess instead of WInexec
    ZeroMemory(@lStartUpInfo, SizeOf(lStartUpInfo));
    lStartUpInfo.cb := SizeOf(lStartUpInfo);
    lSecurityAttr.nLength := SizeOf (lSecurityAttr);
    lSecurityAttr.lpSecurityDescriptor := nil;
    lSecurityAttr.bInheritHandle := TRUE;
    if not CreateProcess(nil, StrPCopy(lArray, lEXEName), @lSecurityAttr, nil, FALSE, 0, nil,
      nil, lStartUpInfo, lProcessInfo) then
        RaiseLastOSError;

  finally
    lRegistry.Free;
  end;
{$ENDIF}
end;

class procedure TFBManager.StartServer();
{$IFDEF MSWINDOWS}
var
  lRegistry: TRegistry;
  lStartUpInfo: STARTUPINFO;
  lSecurityAttr: SECURITY_ATTRIBUTES;
  lProcessInfo: PROCESS_INFORMATION;
  lEXEName: string;
  lArray: array[0..255] of char;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  lRegistry := TRegistry.Create;
  try
    lRegistry.RootKey := HKEY_LOCAL_MACHINE;
    if not lRegistry.OpenKey('Software\Firebird Project\Firebird Server\Instances',False) then
      raise Exception.Create('O servidor SQL Firebird parece não estar instalado no seu computador.')
    else
    lEXEName := Format('%s%s -a',[lRegistry.ReadString('DefaultInstance'),'\bin\fbserver.exe']);


    ZeroMemory(@lStartUpInfo, SizeOf(lStartUpInfo));
    lStartUpInfo.cb := SizeOf(lStartUpInfo);
    lSecurityAttr.nLength := SizeOf (lSecurityAttr);
    lSecurityAttr.lpSecurityDescriptor := nil;
    lSecurityAttr.bInheritHandle := TRUE;
    if not CreateProcess(nil, StrPCopy(lArray, lEXEName), @lSecurityAttr, nil, FALSE, 0, nil,
      nil, lStartUpInfo, lProcessInfo) then
        RaiseLastOSError;
  finally
    lRegistry.Free;
  end;
{$ENDIF}
end;

class procedure TFBManager.StopServer();
{$IFDEF MSWINDOWS}
  function WinOSVersion(): DWORD;
  var
    lVersion: Windows.OSVERSIONINFO;
  begin
    ZeroMemory(@lVersion, SizeOf(lVersion));
    lVersion.dwOSVersionInfoSize := sizeof(lVersion);
    GetVersionEx(lVersion);
    result := lVersion.dwPlatformId
  end;

var
  lHWND: HWND;
  lVersion: DWORD;
  lRegistry: TRegistry;
  lEXEName: string;

{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  lRegistry := TRegistry.Create;
  try
    lVersion := WinOSVersion();

    if lVersion = VER_PLATFORM_WIN32_NT then
    begin
      lRegistry.RootKey := HKEY_LOCAL_MACHINE;
      if not lRegistry.OpenKey('Software\Firebird Project\Firebird Server\Instances',False) then
        raise Exception.Create('O servidor SQL Firebird parece não estar instalado no seu computador.')
      else
        lEXEName := Format('%s%s',[lRegistry.ReadString('DefaultInstance'),'\bin\instsvc.exe stop']);

      if WinExec(PAnsiChar(lEXEName), 2) <= 31 then
                RaiseLastOSError;
    end
    else
      if lVersion = VER_PLATFORM_WIN32_WINDOWS then
      begin
        lHWND:= FindWindow('FB_Server', 'Firebird Server');
        if lHWND <> 0 then
        begin
          if PostMessage(lHWND, WM_CLOSE, 0, 0) = Null then
            raise Exception.Create('Não foi possível encerrar o Firebird.');
//          Application.ProcessMessages;
        end;
      end;
  finally
    lRegistry.Free;
  end;
{$ENDIF}
end;

end.
 