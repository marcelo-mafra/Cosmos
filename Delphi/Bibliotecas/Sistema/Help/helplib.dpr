library helplib;

uses
  ComServ,
  cosmos.system.helplib_TLB in 'cosmos.system.helplib_TLB.pas',
  cosmos.system.helplib in 'cosmos.system.helplib.pas' {CosmosHelp: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
