unit cosmos.server.financeiro.WebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer, Datasnap.DSAuth, IPPeerServer,
  Datasnap.DSCommonServer, Datasnap.DSHTTP, Datasnap.DSSession;
  //DbxCompressionFilter;

const
 sContentsPos = '<ContentsPos>';

type
  TFinWebModule = class(TWebModule)
    DSHTTPWebDispatcher: TDSHTTPWebDispatcher;
    procedure WebModuleCreate(Sender: TObject);
    procedure SecWebModuleDefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure SecWebModuleServerTestAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleException(Sender: TObject; E: Exception;
      var Handled: Boolean);
  private
    { Private declarations }
    function CreateDefaultPage: TStringBuilder;
    procedure InsertContents(Content: string; var Page: TStringBuilder);

  public
    { Public declarations }

  end;

var
  WebModuleClass: TComponentClass = TFinWebModule;

implementation


{$R *.dfm}

uses cosmos.server.financeiro.appcontainer, Web.WebReq, cosmos.classes.logs,
  cosmos.servers.common.services;

function TFinWebModule.CreateDefaultPage: TStringBuilder;
begin
 Result := TStringBuilder.Create;
 Result.Append('<html>');
 Result.Append('<head><title>Gestor Financeiro</title></head>');
 Result.Append('<body>');
 Result.Append('<p>');
// Result.Append('<img src="imagens\guru.png" align="left">');
 Result.Append('<font size="5" face="Verdana">');
 Result.Append('Cosmos Gestor Financeiro');
 Result.Append('<hr>');
 Result.Append('</font>');
 Result.Append('</p>');
 Result.Append('<p>');
 Result.Append(sContentsPos);
 Result.Append('</p>');
 Result.Append('</body>');
 Result.Append('</html>');
end;

procedure TFinWebModule.InsertContents(Content: string;
  var Page: TStringBuilder);
begin
 Page := Page.Replace(sContentsPos, Content);
end;

procedure TFinWebModule.SecWebModuleDefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
 sDateTime: string;
 aPage, aContent: TStringBuilder;
begin
  DateTimeToString(sDateTime, 'dd/mmmm/yyyy hh:mm:nnn', Now);
  aPage := CreateDefaultPage;
  aContent := TStringBuilder.Create;

  try
   aContent.Append('O Gestor Financeiro Server está trabalhando...');
   aContent.Append('No servidor a data e hora certas são: <b>' + sDateTime + '</b>');
   InsertContents(aContent.ToString, aPage);
   Response.Content := aPage.ToString;

  finally
   aPage.Free;
   aContent.Free;
  end;
end;

procedure TFinWebModule.SecWebModuleServerTestAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
 sUserName: string;
 aPage, aContent: TStringBuilder;
begin
 aContent := TStringBuilder.Create;

 try
  sUserName := TDSSessionManager.GetThreadSession.GetData('ConnectedUser');

  if sUserName.Trim <> '' then
   begin
    aContent.Append('Seu nome é: <b>' + sUserName + '</b>');
    aContent.Append('Você se conectou em: <b>' + TDSSessionManager.GetThreadSession.GetData('ConnectTime') + '</b>');

    aPage := CreateDefaultPage;
    InsertContents(aContent.ToString, aPage);
    Response.Content := aPage.ToString;
   end;

 finally
  aContent.Free;
  aPage.Free;
 end;
end;

procedure TFinWebModule.WebModuleCreate(Sender: TObject);
begin
  DSHTTPWebDispatcher.Server := DSServer;

  if DSServer.Started then
   begin
    DSHTTPWebDispatcher.DbxContext := DSServer.DbxContext;
    DSHTTPWebDispatcher.Start;
   end;

  DSHTTPWebDispatcher.AuthenticationManager := DSAuthenticationManager;
  DSHTTPWebDispatcher.SessionTimeout;
end;

procedure TFinWebModule.WebModuleException(Sender: TObject; E: Exception;
  var Handled: Boolean);
var
 DMServ: TDMCosmosServerServices;
 AContextInfo, AUserInfo: TStringList;
begin
 DMServ := TDMCosmosServerServices.Create(nil);

 try
  AContextInfo := DMServ.CreateContextInfoObject;
  AContextInfo.Append('Exception Class: ' + E.ClassName); //do not localize!
  AContextInfo.Append('Exception Message: ' + E.Message);  //do not localize!
  AContextInfo.Append(TDSSessionManager.GetThreadSession.GetData('UserName')); //do not localize!
  AContextInfo.Append(TDSSessionManager.GetThreadSession.GetData('UserRoles'));  //do not localize!
  AContextInfo.Append(TDSSessionManager.GetThreadSession.GetData('ConnectedUser')); //do not localize!
  AContextInfo.Append(TDSSessionManager.GetThreadSession.GetData('UserInfo'));  //do not localize!
  AContextInfo.Append(TDSSessionManager.GetThreadSession.GetData('ConnectTime')); //do not localize!
  AContextInfo.Append('CurrentTime: ' + DateTimeToStr(Now)); //do not localize!

  DMServ.RegisterLog(E.Message, AContextInfo.CommaText, leOnError);
  Handled := True;

 finally
  DMServ.Free;
  if Assigned(AContextInfo) then FreeAndNil(AContextInfo);
 end;
end;

initialization

finalization
  Web.WebReq.FreeWebModules;

end.

