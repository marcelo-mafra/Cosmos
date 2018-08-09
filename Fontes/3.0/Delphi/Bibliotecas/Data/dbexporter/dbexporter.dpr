library dbexporter;

uses
  ComServ,
  dbexporter_TLB in 'dbexporter_TLB.pas',
  unDataExport in 'unDataExport.pas' {DataExporter: CoClass},
  DMExport in 'DMExport.pas' {DM: TDataModule};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
