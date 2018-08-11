library Exporter;

uses
  ComServ,
  DataModule in 'DataModule.pas' {DM: TDataModule},
  Exporter_TLB in 'Exporter_TLB.pas',
  ExporterFunctions in 'ExporterFunctions.pas' {DataExporter: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
