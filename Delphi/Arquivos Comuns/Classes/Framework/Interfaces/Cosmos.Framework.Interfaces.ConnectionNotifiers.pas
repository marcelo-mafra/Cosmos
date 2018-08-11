unit Cosmos.Framework.Interfaces.ConnectionNotifiers;

{Todas as classes implementadoras das interfaces declaradas nesta unidade
devem descender de TInterfacedPersistent e não de TInterfacedObject ou TAggregatedObject.
Do contrário, devido ao gerenciamento automático do ciclo de vida das interfaces,
o sistema começará a disparar Access Violations ao tentar acessar as interfaces.
}

interface

uses

 System.Classes, System.Generics.Collections, cosmos.system.types;

type
 TNotifyChangeConnectionStatusEvent = procedure(Status: TConnectionStatus) of object;


 {Observer and observable pattern for connections status changes notification.}
 IConnectionStatusObserver = interface

   ['{6B0D75A3-C2AB-461F-A008-F235FCA2479E}']
   procedure NotifyChangeConnectionStatus(Status: TConnectionStatus);
 end;

 {Classes implementadoras das interfaces acima declaradas.}

 {Observer class.}
 TConnectionStatusObserver = class(TInterfacedPersistent, IConnectionStatusObserver)
    private
     FOnNotifyChangeConnectionStatus: TNotifyChangeConnectionStatusEvent;
     FPoolIndex: Int64;

    protected
     procedure NotifyChangeConnectionStatus(Status: TConnectionStatus);

    public
     constructor Create;
     destructor Destroy;
     property PoolIndex: Int64 read FPoolIndex;

     property OnNotifyChangeConnectionStatus: TNotifyChangeConnectionStatusEvent read
        FOnNotifyChangeConnectionStatus write FOnNotifyChangeConnectionStatus;
  end;

  //Interface para o observable.
 IConnectionStatusObservable = interface
   ['{73AB3ADC-3775-4B61-82D5-362611DB13EA}']

   procedure RegisterObserver(Observer: TConnectionStatusObserver);
   procedure UnregisterObserver(Observer: TConnectionStatusObserver);
 end;

 {Observable class.}
 TConnectionStatusObservable = class(TInterfacedPersistent, IConnectionStatusObservable)
    private
     FObserversPool:  TDictionary<Int64, TConnectionStatusObserver>;

    public
     constructor Create;
     destructor Destroy;
     procedure NotifyObservers(const Status: TConnectionStatus);
     procedure RegisterObserver(Observer: TConnectionStatusObserver);
     procedure UnregisterObserver(Observer: TConnectionStatusObserver);
 end;


implementation

{ TConnectionStatusObservable }

constructor TConnectionStatusObservable.Create;
begin
  inherited Create;
  FObserversPool := TDictionary<Int64, TConnectionStatusObserver>.Create;
end;

destructor TConnectionStatusObservable.Destroy;
begin
  FObserversPool.Values.Free;
  FObserversPool.Keys.Free;
  FObserversPool.Free;
  inherited Destroy;
end;

procedure TConnectionStatusObservable.NotifyObservers(
  const Status: TConnectionStatus);
var
  AKey: Int64;
 aObserver: TConnectionStatusObserver;
begin
{Notifica todos os observadores acerca da mudança do status da conexão com
 o servidor do Cosmos.}
  for AKey in FObserversPool.Keys do
   begin
    aObserver := FObserversPool[Akey];
    aObserver.NotifyChangeConnectionStatus(Status);
   end;
end;

procedure TConnectionStatusObservable.RegisterObserver(
  Observer: TConnectionStatusObserver);
begin
 if not FObserversPool.ContainsKey(Observer.PoolIndex) then
  FObserversPool.Add(Observer.PoolIndex, Observer);
end;

procedure TConnectionStatusObservable.UnregisterObserver(
  Observer: TConnectionStatusObserver);
begin
 if FObserversPool.ContainsKey(Observer.PoolIndex) then
   FObserversPool.Remove(Observer.PoolIndex);
end;

{ TConnectionStatusObserver }

constructor TConnectionStatusObserver.Create;
begin
  inherited Create;
  Randomize;
  FPoolIndex := Random(30);
end;

destructor TConnectionStatusObserver.Destroy;
begin
  inherited Destroy;
end;

procedure TConnectionStatusObserver.NotifyChangeConnectionStatus(
  Status: TConnectionStatus);
begin
 //Dispara o evento "OnNotifyChangeConnectionStatus".
 if Assigned(FOnNotifyChangeConnectionStatus) then
   FOnNotifyChangeConnectionStatus(Status);
end;

end.
