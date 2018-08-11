unit cosmos.server.users.WebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation


{$R *.dfm}

uses ServerMethodsUnit1, cosmos.server.users.appcontainer, Web.WebReq;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
 sTimeServer: string;
begin
 sTimeServer := 'O Gestor de Usuários está trabalhando: %s';
 sTimeServer := Format(sTImeServer, [DateTimeToStr(Now)]);
  Response.Content :=
    '<html>' +
    '<head><title>Cosmos Gestor de Usuários</title></head>' +
    '<body>' + sTimeServer + '</body>' +
    '</html>';
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  DSHTTPWebDispatcher1.Server := DSServer;
  if DSServer.Started then
  begin
    DSHTTPWebDispatcher1.DbxContext := DSServer.DbxContext;
    DSHTTPWebDispatcher1.Start;
  end;
  DSHTTPWebDispatcher1.AuthenticationManager := DSAuthenticationManager;
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

