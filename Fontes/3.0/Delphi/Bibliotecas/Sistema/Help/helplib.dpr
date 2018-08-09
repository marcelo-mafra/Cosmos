library helplib;

uses
  ComServ,
  helplib_TLB in 'helplib_TLB.pas',
  uhelplib in 'uhelplib.pas' {CosmosHelp: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
