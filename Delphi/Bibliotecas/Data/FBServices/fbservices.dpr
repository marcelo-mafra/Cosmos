library fbservices;

uses
  ComServ,
  fbservices_TLB in 'fbservices_TLB.pas',
  main in 'main.pas',
  FBManager in 'FBManager.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
