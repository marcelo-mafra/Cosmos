unit cosmos.common.services.providerspool;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Datasnap.DSConnect,
  System.Generics.Collections;

 const
  ARange = 200; //O range deve ser pequeno.

type
 {Implementa um simples pool de remote providers que utilizam a conexão com o servidor.
  Sem a gestão oferecida por meio desse pool, as aplicações clientes não conseguem
  fazer logoff corretamente, pois enquanto houverem objetos TDSProviderConnection
  não destruídos em memória, o objeto de conexão não desconecta.}

  TRemoteProvidersPool = class
   private
    FPool:  TDictionary<Integer, TDSProviderConnection>;
    function GetRemoteProvidersCount: integer;

   public
    constructor Create;
    destructor Destroy; override;
    procedure ClearAll;

    function AddRemoteProvider(AProvider: TDSProviderConnection): integer;
    procedure RemoveRemoteProvider(const SessionId: integer);

    property RemoteProvidersCount: integer read GetRemoteProvidersCount;
  end;

implementation

{ TRemoteProvidersPool }

function TRemoteProvidersPool.AddRemoteProvider(
  AProvider: TDSProviderConnection): integer;
var
 AIndex: integer;
begin
 {Adiciona um objeto TDSProviderConnection e dá a ele um índice.}
 Randomize;
 AIndex := Random(ARange);

 while FPool.ContainsKey(AIndex) do
   AIndex := Random(ARange);

 FPool.Add(AIndex, AProvider);
 Result := AIndex;
end;

procedure TRemoteProvidersPool.ClearAll;
var
 AKey: Integer;
 AProvider: TDSProviderConnection;
begin
 {Limpa o pool de destrói todos os objetos nele existentes.}
  for AKey in FPool.Keys do
   begin
    AProvider := FPool[Akey];
    AProvider.Free;
   end;

 FPool.Clear;
end;

constructor TRemoteProvidersPool.Create;
begin
 inherited;
 FPool := TDictionary<Integer, TDSProviderConnection>.Create;
end;

destructor TRemoteProvidersPool.Destroy;
begin
  FPool.Values.Free;
  FPool.Keys.Free;

  inherited Destroy;
end;

function TRemoteProvidersPool.GetRemoteProvidersCount: integer;
begin
 //Retorna o número de objetos existentes no pool.
 Result := FPool.Count;
end;

procedure TRemoteProvidersPool.RemoveRemoteProvider(const SessionId: integer);
var
 AProvider: TDSProviderConnection;
begin
 //Remove um objeto existente no pool a partir do seu número de índice.
 if FPool.ContainsKey(SessionId) then
  begin
   AProvider := FPool[SessionId];
   AProvider.Close;
   AProvider.Free;
   FPool.Remove(SessionId);
  end;
end;

end.
