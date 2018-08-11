library mod_cmususer;

uses
  Winapi.ActiveX,
  System.Win.ComObj,
  Web.WebBroker,
  Web.ApacheApp,
  Web.HTTPD22Impl,
  Data.DBXCommon,
  Datasnap.DSSession,
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDSServerModule},
  cosmos.server.users.appcontainer in 'cosmos.server.users.appcontainer.pas' {ServerContainer1: TDataModule},
  cosmos.server.users.WebModule in 'cosmos.server.users.WebModule.pas' {WebModule1: TWebModule},
  cosmos.servers.users.usersmethods in '..\ServerModules\cosmos.servers.users.usersmethods.pas' {DMUserMethods: TDSServerModule},
  cosmos.servers.common.dataacess in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.dataacess.pas' {DMServerDataAcess: TDataModule},
  cosmos.servers.common.methods in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.methods.pas' {DMCosmosApplicationServer: TDSServerModule},
  cosmos.servers.common.security.authorizations in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.authorizations.pas',
  cosmos.servers.common.security in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.security.pas',
  cosmos.servers.common.services in '..\..\Arquivos Comuns\DBXServers\cosmos.servers.common.services.pas' {DMCosmosServerServices: TDataModule};

{$R *.res}

// httpd.conf entries:
//
(*
 LoadModule cmususer_module modules/mod_cmususer.dll

 <Location /xyz>
    SetHandler mod_cmususer-handler
 </Location>
*)
//
// These entries assume that the output directory for this project is the apache/modules directory.
//
// httpd.conf entries should be different if the project is changed in these ways:
//   1. The TApacheModuleData variable name is changed
//   2. The project is renamed.
//   3. The output directory is not the apache/modules directory
//

// Declare exported variable so that Apache can access this module.
var
  GModuleData: TApacheModuleData;
exports
  GModuleData name 'cmususer_module';

procedure TerminateThreads;
begin
  TDSSessionManager.Instance.Free;
  Data.DBXCommon.TDBXScheduler.Instance.Free;
end;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Web.ApacheApp.InitApplication(@GModuleData);
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  TApacheApplication(Application).OnTerminate := TerminateThreads;
  Application.CreateForm(TDMUserMethods, DMUserMethods);
  Application.CreateForm(TDMServerDataAcess, DMServerDataAcess);
  Application.CreateForm(TDMCosmosApplicationServer, DMCosmosApplicationServer);
  Application.CreateForm(TDMCosmosServerServices, DMCosmosServerServices);
  Application.Run;
end.
