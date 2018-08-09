unit cosmos.server.secretarias.WebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer, Cosmos.Classes.Application,
  Cosmos.System.Messages, Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer,
  Datasnap.DSHTTP, Web.DBWeb, Web.DBXpressWeb, Data.SQLExpr;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DataSetTableProducer1: TDataSetTableProducer;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
    function GetWebServerRootFolder: string;
  public
    { Public declarations }
    property WebServerRootFolder: string read GetWebServerRootFolder;
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation


{$R *.dfm}

uses ServerMethodsUnit1,  cosmos.server.secretarias.appcontainer, Web.WebReq,
Unit1;

function TWebModule1.GetWebServerRootFolder: string;
var
 CosmosApp: TCosmosApplication;
begin
 CosmosApp := TCosmosApplication.Create;

 try
   Result := CosmosApp.GetModulePath;

 finally
  CosmosApp.Free;
 end;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>DataSnap Server</title></head>' +
    '<body>DataSnap Server</body>' +
    '</html>';
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
 aFile: TStringList;
begin
  aFile := TStringList.Create;
  try
    aFile.LoadFromFile(self.WebServerRootFolder + TCosmosFiles.CosmosRoot);
    Response.Content :=
    '<html>' +
    '<head><title>DataSnap Server</title></head>' +
    '<body>' + aFile.Text +'</body>' +
    '</html>';

  finally
   aFile.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
 aConn: TSQLConnection;
 aDataset: TSQLDataset;
begin
 aConn := TDatalayer.CreateConnection;
 aDataset := TDatalayer.ExecuteQuery(aConn, 'select nomest, sigest from ESTADOS order by nomest');

 try
  DataSetTableProducer1.DataSet := aDataset;
  Response.Content := self.DataSetTableProducer1.Content;

 finally
   DataSetTableProducer1.Dataset := nil;
   aDataset.Free;
   aConn.Free;
 end;
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

