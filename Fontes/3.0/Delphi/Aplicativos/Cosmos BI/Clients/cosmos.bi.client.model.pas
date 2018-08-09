unit cosmos.bi.client.model;

interface

uses
  System.SysUtils, System.Classes, SynCommons, mORMot, mORMotHttpClient,
  cosmos.bi.interfaces;

type
  EServerConnectError = Exception;
  EUnassignedClientConnectionObj = Exception;

  TDMModel = class(TDataModule)
  private
    { Private declarations }
    FClient: TSQLRestClientURI;
    FModel: TSQLModel;

    procedure RaiseUnassignedObject;

  public
    { Public declarations }


    procedure ConnectServer;
    procedure DisconnectServer;
    function ListPupils(const FocusId: integer): TSQLTableJson;
    function LoadActiveFocus: TSQLTableJson;
    function ServerDateTime:TDateTime;

    property Client: TSQLRestClientURI read FClient;
    property Model: TSQLModel read FModel;
  end;

var
  DMModel: TDMModel;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDMModel }

procedure TDMModel.ConnectServer;
begin
  if Client = nil then
  begin
    if Model = nil then
      FModel := TSQLModel.Create([],ROOT_NAME);

    if Client = nil then
     FClient := TSQLHttpClient.Create('lectorium-bh.dyndns.info','44333',Model);

    Client.ServiceDefine([ICosmosSystem],sicShared);
    Client.ServiceDefine([ICosmosBi],sicShared);

    if not Client.ServerTimeStampSynchronize then
     raise EServerConnectError.Create(UTF8ToString(Client.LastErrorMessage));
  end
 else
  RaiseUnassignedObject;
end;

procedure TDMModel.DisconnectServer;
begin
 Client.SessionClose;
 FreeAndNil(FModel);
 FreeAndNil(FClient);
end;

function TDMModel.ListPupils(const FocusId: integer): TSQLTableJson;
var
 CmBi: ICosmosBi;
 aJsonData: RawUTF8;
begin
 if Client <> nil then
  begin
   CmBi := Client.Service<ICosmosBi>;

   try
    aJsonData := CmBi.ListPupils(FocusId);
    Result := TSQLTableJson.Create('*', aJsonData);

   finally
    CmBi := nil;
   end;
  end
 else
  RaiseUnassignedObject;
end;

function TDMModel.LoadActiveFocus: TSQLTableJson;
var
 CmBi: ICosmosBi;
 aJsonData: RawUTF8;
begin
 //Lista os focos ativos existentes em um JSON.
 if Client <> nil then
  begin
   CmBi := Client.Service<ICosmosBi>;

   try
    aJsonData := CmBi.ListActiveFocus;
    Result := TSQLTableJson.Create('*', aJsonData);

   finally
    CmBI := nil;
   end;
  end
 else
  RaiseUnassignedObject;
end;

procedure TDMModel.RaiseUnassignedObject;
begin
 raise EUnassignedClientConnectionObj.Create('Não foi possível encontrar uma referência ao objeto de conexão com o servidor remoto.');
end;

function TDMModel.ServerDateTime: TDateTime;
var
 CmSystem: ICosmosSystem;
begin
 if Client <> nil then
  begin
   CmSystem := Client.Service<ICosmosSystem>;
   Result := CmSystem.ServerDateTime;
  end
 else
  RaiseUnassignedObject;
end;

end.
