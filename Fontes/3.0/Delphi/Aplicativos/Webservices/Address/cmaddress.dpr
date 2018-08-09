library cmaddress;

uses
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.Win.ISAPIApp,
  Web.Win.ISAPIThreadPool,
  cosmos.server.ws.WebModule in 'cosmos.server.ws.WebModule.pas' {WebModule1: TWebModule},
  cosmos.server.ws.CosmosAddressImpl in 'cosmos.server.ws.CosmosAddressImpl.pas',
  cosmos.server.ws.CosmosAddressIntf in 'cosmos.server.ws.CosmosAddressIntf.pas',
  cosmos.server.ws.DataModule in 'cosmos.server.ws.DataModule.pas' {DM: TDataModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
