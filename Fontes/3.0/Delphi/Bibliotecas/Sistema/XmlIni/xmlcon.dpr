library xmlcon;

uses
  ComServ,
  xmlini in 'xmlini.pas',
  xmlcon_TLB in 'xmlcon_TLB.pas',
  xmlconf in 'xmlconf.pas' {Xmlconf: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
