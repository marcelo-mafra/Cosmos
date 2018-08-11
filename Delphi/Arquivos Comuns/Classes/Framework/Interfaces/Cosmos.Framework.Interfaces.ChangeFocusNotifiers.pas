unit Cosmos.Framework.Interfaces.ChangeFocusNotifiers;

{Todas as classes implementadoras das interfaces declaradas nesta unidade
devem descender de TInterfacedPersistent e não de TInterfacedObject ou TAggregatedObject.
Do contrário, devido ao gerenciamento automático do ciclo de vida das interfaces,
o sistema começará a disparar Access Violations ao tentar acessar as interfaces.
}

interface

uses

 System.Classes, System.Generics.Collections, cosmos.system.types, cosmos.business.focos;

type
 TNotifyChangeFocusEvent = procedure(Focus: TFocus) of object;

 {Observer and observable pattern for changes of active focus notification.}
 IChangeFocusObserver = interface

   ['{768BAF32-26B8-4BA6-8A5A-3FAC7A9D6843}']
   procedure NotifyChangeFocus(Focus: TFocus);
 end;

 {Classes implementadoras das interfaces acima declaradas.}

 {Observer class.}
 TChangeFocusObserver = class(TInterfacedPersistent, IChangeFocusObserver)
    private
     FOnNotifyChangeFocus: TNotifyChangeFocusEvent;
     FPoolIndex: Int64;

    protected
     procedure NotifyChangeFocus(Focus: TFocus);

    public
     constructor Create;
     destructor Destroy;
     property PoolIndex: Int64 read FPoolIndex;

     property OnNotifyChangeFocus: TNotifyChangeFocusEvent read
        FOnNotifyChangeFocus write FOnNotifyChangeFocus;
  end;


 IChangeFocusObservable = interface
   ['{66AD8960-5B23-466E-AF3B-FD72703568C5}']

   procedure NotifyObservers(const Focus: TFocus);
   procedure RegisterObserver(Observer: TChangeFocusObserver);
   procedure UnregisterObserver(Observer: TChangeFocusObserver);
 end;

 {Observable class.}
 TChangeFocusObservable = class(TInterfacedPersistent, IChangeFocusObservable)
    private
     FObserversPool: TDictionary<Int64, TChangeFocusObserver>;

    public
     constructor Create;
     destructor Destroy;

     procedure NotifyObservers(const Focus: TFocus);
     procedure RegisterObserver(Observer: TChangeFocusObserver);
     procedure UnregisterObserver(Observer: TChangeFocusObserver);
 end;




implementation

{ TChangeFocusObservable }

constructor TChangeFocusObservable.Create;
begin
  inherited Create;
  FObserversPool := TDictionary<Int64, TChangeFocusObserver>.Create;
end;

destructor TChangeFocusObservable.Destroy;
begin
  FObserversPool.Values.Free;
  FObserversPool.Keys.Free;
  FObserversPool.Free;
  inherited Destroy;
end;

procedure TChangeFocusObservable.NotifyObservers(const Focus: TFocus);
var
 AKey: Int64;
 aObserver: TChangeFocusObserver;
begin
{Notifica todos os observadores acerca da mudança de foco ativo.}
  for AKey in FObserversPool.Keys do
   begin
    aObserver := FObserversPool[Akey];
    aObserver.NotifyChangeFocus(Focus);
   end;
end;

procedure TChangeFocusObservable.RegisterObserver(
  Observer: TChangeFocusObserver);
begin
 if not FObserversPool.ContainsKey(Observer.PoolIndex) then
  FObserversPool.Add(Observer.PoolIndex, Observer);
end;

procedure TChangeFocusObservable.UnregisterObserver(
  Observer: TChangeFocusObserver);
begin
 if FObserversPool.ContainsKey(Observer.PoolIndex) then
   FObserversPool.Remove(Observer.PoolIndex);
end;

{ TChangeFocusObserver }

constructor TChangeFocusObserver.Create;
begin
  inherited Create;
  Randomize;
  FPoolIndex := Random(30);
end;

destructor TChangeFocusObserver.Destroy;
begin
  inherited Destroy;
end;

procedure TChangeFocusObserver.NotifyChangeFocus(Focus: TFocus);
begin
 //Dispara o evento "OnNotifyChangeFocus".
 if Assigned(FOnNotifyChangeFocus) then
   FOnNotifyChangeFocus(Focus);
end;



end.
