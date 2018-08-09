unit ServerConnections;

interface

uses
  Windows, SysUtils, Classes;

type

 EMaxConnectionsError = Exception;
 TConnectionID = TGUID;

 TGetAdminPassword = procedure(Sender: TObject; var Login, passwrd: string) of Object;

 TConnectionItem = class(TCollectionItem)
  private
    FSource: string;
    FUserName: string;
    FConnectionID: TGUID;
    FGroup: string;
    FStartTime: TDateTime;
    FAditionalInfo: TStrings;
    FLocked: boolean;

    function GetIDAsString: string;
    procedure SetAditionalInfo(const Value: TStrings);

  public
   constructor Create(Collection: TCollection); override;
   destructor Destroy; override;

   property ConnectionID: TGUID read FConnectionID write FConnectionID;
   property IDAsString: string read GetIDAsString;
   property StartTime: TDateTime read FStartTime;

  published
   property AditionalInfo: TStrings read FAditionalInfo write SetAditionalInfo;
   property Group: string read FGroup write FGroup;
   property Locked: boolean read FLocked write FLocked;
   property Source: string read FSource write FSource;
   property UserName: string read FUserName write FUserName;

 end;

 TConnections = class(TCollection)
  private
    function GetItem(Index: integer): TConnectionItem;
    procedure SetItem(Index: integer; const Value: TConnectionItem);

  public
   constructor Create(AOwner: TComponent);
   function Add: TConnectionItem;
   function FindItemByID(Value: TGUID): TConnectionItem;

   property Items[Index: integer]: TConnectionItem read GetItem write SetItem; default;
 end;


 TConnectionsManager = class(TComponent)
  private
    FStartTime: TDateTime;
    FServerHost: string;
    FServerName: string;
    FAutoInterface: string;
    FLocked: boolean;
    FServerConnections: TConnections;
    FOnLockServer: TNotifyEvent;
    FOnUnLockServer: TNotifyEvent;
    FOnRegisterConnection: TNotifyEvent;
    FOnUnregisterConnection: TNotifyEvent;
    FLockedUsers: TStrings;
    FOnGetAdminPassword: TGetAdminPassword;
    FAdminLogon: string;
    FAdminPassword: string;
    FAdminMode: boolean;
    FMaxConnections: integer;
    procedure SetServerHost;
    procedure SetLocked(const Value: boolean);
    function GetConnectionsCount: integer;
    procedure SetLockedUsers(const Value: TStrings);
    procedure SetAdminMode(const Value: boolean);

  protected
    procedure DoGetAdminPassword(var Login, Passwrd: string);

  public
    property ConnectionsCount: integer read GetConnectionsCount;
    property ServerHost: string read FServerHost;
    property StartTime: TDateTime read FStartTime write FStartTime;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RegisterConnection(UserName, Group, Source: string;
      Info: TStrings): TConnectionID;
    procedure UnRegisterConnection(ConnectionID: TGUID);
    function UserIsLocked(const UserName: string): boolean;

  published
    property AdminLogon: string read FAdminLogon write FAdminLogon;
    property AdminPassword: string read FAdminPassword write FAdminPassword;
    property AdminMode: boolean read FAdminMode write SetAdminMode;
    property AutoInterface: string read FAutoInterface write FAutoInterface;
    property Locked: boolean read FLocked write SetLocked;
    property LockedUsers: TStrings read FLockedUsers write SetLockedUsers;
    property MaxConnections: integer read FMaxConnections write FMaxConnections default 0;
    property ServerName: string read FServerName write FServerName;
    property ServerConnections: TConnections read FServerConnections write FServerConnections;
    property OnLockServer: TNotifyEvent read FOnLockServer write FOnLockServer;
    property OnUnLockServer: TNotifyEvent read FOnUnLockServer write FOnUnLockServer;
    property OnRegisterConnection: TNotifyEvent read FOnRegisterConnection write FOnRegisterConnection;
    property OnUnregisterConnection: TNotifyEvent read FOnUnregisterConnection write FOnUnregisterConnection;
    property OnGetAdminPassword: TGetAdminPassword read FOnGetAdminPassword write FOnGetAdminPassword;
    property Tag;

 end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TConnectionsManager]);
end;


constructor TConnectionsManager.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  FServerConnections := TConnections.Create(self);
  FLockedUsers := TStringList.Create;
  FStartTime := Now;
  SetServerHost;
end;

destructor TConnectionsManager.Destroy;
begin
  FLockedUsers.Free;
  inherited Destroy;
end;

procedure TConnectionsManager.SetServerHost;
var
vHost: string;
I : LongWord;
begin
 SetLength(vHost, MAX_COMPUTERNAME_LENGTH + 1);
 I := Length(vHost);
 if GetComputerName(@vHost[1], i) then
  SetLength(vHost, i);
 FServerHost := vHost;
end;


procedure TConnectionsManager.SetLocked(const Value: boolean);
begin
 FLocked := Value;

 if Assigned(FOnLockServer) then
 if FLocked = True then
  FOnLockServer(self);

 if Assigned(FOnUnLockServer) then
  if FLocked = False then
   FOnUnLockServer(self);
end;


function TConnectionsManager.RegisterConnection(UserName, Group,
   Source: string; Info: TStrings): TConnectionID;
var
cl: TConnectionItem;
ErrorMsg: string;
begin
 if MaxConnections > 0 then
  if MaxConnections = GetConnectionsCount then
   begin
    ErrorMsg := Format('O servidor %s não pode atender mais pedidos de ' +
     'conexão. O número máximo de conexões simultâneas permitido foi ' +
     'alcançado.', [FServerName]);
    raise EMaxConnectionsError.Create(ErrorMsg);
   end;

 Cl := FServerConnections.Add;
 cl.FUserName := UserName;
 cl.FGroup := Group;
 cl.FSource := Source;
 if Info <> nil then
  cl.AditionalInfo.Assign(Info);
 Result := cl.FConnectionID;
 if Assigned(FOnRegisterConnection) then
  FOnRegisterConnection(self);
end;

procedure TConnectionsManager.UnRegisterConnection(ConnectionID: TGUID);
var
cl: TConnectionItem;
begin
 Cl := FServerConnections.FindItemByID(ConnectionID);
 if Cl <> nil then
  begin
   FServerConnections.Delete(Cl.Index);
   if Assigned(FOnUnregisterConnection) then
    FOnUnregisterConnection(self);
  end;
end;

{ TClientConnectionItem }

constructor TConnectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  CreateGUID(FConnectionID);
  FStartTime := Now;
  FLocked := False;
  FAditionalInfo := TStringList.Create;
end;

destructor TConnectionItem.Destroy;
begin
 FAditionalInfo.Free;
 inherited Destroy;
end;

function TConnectionItem.GetIDAsString: string;
begin
 Result := GUIDToString(FConnectionID);
end;

procedure TConnectionItem.SetAditionalInfo(const Value: TStrings);
begin
 if FAditionalInfo.Text <> Value.Text then
  FAditionalInfo.Assign(Value);
end;

{ TServerConnections }


function TConnections.GetItem(Index: integer): TConnectionItem;
begin
 Result := TConnectionItem(inherited GetItem(Index));
end;

procedure TConnections.SetItem(Index: integer;
  const Value: TConnectionItem);
begin
 inherited SetItem(Index, Value);
end;

constructor TConnections.Create(AOwner: TComponent);
begin
 inherited Create(TConnectionItem);
end;

function TConnections.Add: TConnectionItem;
begin
 Result := TConnectionItem(inherited Add);
end;

function TConnections.FindItemByID(Value: TGUID): TConnectionItem;
var
I: integer;
Cl: TConnectionItem;
begin
 Result := nil;
 for I := 0 to Pred(Count) do
  begin
   Cl := GetItem(I);
   if Cl <> nil then
    begin
     if ISEqualGUID(Cl.FConnectionID, Value) then
      begin
       Result := Cl;
       Break;
      end;
    end
    else
     Result := nil;
  end;
end;

function TConnectionsManager.GetConnectionsCount: integer;
begin
 Result := ServerConnections.Count;
end;

procedure TConnectionsManager.SetLockedUsers(const Value: TStrings);
begin
 if FLockedUsers.Text <> Value.Text then
  FLockedUsers.Assign(Value);
end;

function TConnectionsManager.UserIsLocked(const UserName: string): boolean;
begin
 Result := FLockedUsers.IndexOf(UserName) >= 0;
end;

procedure TConnectionsManager.DoGetAdminPassword(var Login, Passwrd: string);
begin
 if Assigned(FOnGetAdminPassword) then
  FOnGetAdminPassword(Self, Login, Passwrd);
 if (Trim(FAdminLogon) = '') or (Trim(FAdminPassword) = '') then
  raise exception.Create('O login e a senha não podem ser vazios!');
 if (FAdminLogon = Login) and (FAdminPassword = Passwrd) then
  FAdminMode := True
 else
  Raise exception.Create('Usuário não autenticado: login e senha não conferem!');
end;


procedure TConnectionsManager.SetAdminMode(const Value: boolean);
var
Login, Passwrd: string;
begin
 if Value = False then
   FAdminMode := Value
 else
  if Assigned(FOnGetAdminPassword) then
   DoGetAdminPassword(Login, Passwrd)
  else
   FAdminMode := Value;
end;

end.


