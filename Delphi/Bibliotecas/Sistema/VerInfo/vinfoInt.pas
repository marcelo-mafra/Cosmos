unit vinfoInt;

interface

uses
  SysUtils;

 function GetVersionInfo(AppPath: PChar): PChar;  stdcall;
 function GetCustomVersionInfo(AppPath, AKey: PChar): PChar; stdcall;


implementation

 function GetVersionInfo; external 'VINFO.DLL' name 'GetVersionInfo';
 function GetCustomVersionInfo; external 'VINFO.DLL' name 'GetCustomVersionInfo';

end.

