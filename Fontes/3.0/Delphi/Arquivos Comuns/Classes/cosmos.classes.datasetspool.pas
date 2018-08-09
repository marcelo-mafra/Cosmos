unit cosmos.classes.datasetspool;

interface

uses

 System.Classes, System.Generics.Collections, Datasnap.DBClient;

type

//Implementa um simples pool de conexões com o banco de dados.
 TDatasetsPool = class
   private
   FDatasetsPool:  TDictionary<Int64, TClientDataset>;
   function GetDatasetsCount: integer;

  public
   constructor Create;
   destructor Destroy;
   procedure ClearAll;

   function GetDataset: TClientDataset; overload;
   function GetDataset(const AKey: Int64): TClientDataset; overload;
   function GetNewDataset: TClientDataset;
   procedure FillPool(const ObjCount: integer);
   procedure RemoveDataset(const SessionId: Int64);

   property DatasetsCount: integer read GetDatasetsCount;
 end;


implementation

{ TDatasetsPool }

procedure TDatasetsPool.ClearAll;
var
 AKey: Integer;
 aDataset: TClientDataset;
begin
 {Limpa o pool de destrói todos os objetos nele existentes.}
  for AKey in FDatasetsPool.Keys do
   begin
    aDataset := FDatasetsPool[Akey];
    aDataset.Free;
   end;

 FDatasetsPool.Clear;
end;

constructor TDatasetsPool.Create;
begin
 FDatasetsPool := TDictionary<Int64, TClientDataset>.Create;
end;

destructor TDatasetsPool.Destroy;
begin
  FDatasetsPool.Values.Free;
  FDatasetsPool.Keys.Free;
  FDatasetsPool.Free;

  inherited Destroy;
end;

procedure TDatasetsPool.FillPool(const ObjCount: integer);
var
 I: integer;
 AIndex: Int64;
 aDataset : TClientDataset;
begin
 {Cria objetos TClientDataset no pool para uso das aplicações. O número de objetos
  TClientDataset que serão criados é definido pelo parâmetro ObjCount}
 I := ObjCount;
 Randomize;

 while I > 0 do
  begin
    aDataset := TClientDataset.Create(nil);
    AIndex := Random(30);
    aDataset.Tag := AIndex;

    if not FDatasetsPool.ContainsKey(AIndex) then
     begin
      FDatasetsPool.Add(AIndex, aDataset);
      Dec(I);
     end;
  end;

end;

function TDatasetsPool.GetDataset: TClientDataset;
var
 AKey: Int64;
begin
 //Retorna um dataset existente no pool de conexões.
 Randomize;
 Result := nil;

 Akey := Random(30);

 while Result = nil do
  begin
   if FDatasetsPool.ContainsKey(AKey) then
    Result := FDatasetsPool[AKey];
   Akey := Random(30);
  end;

end;

function TDatasetsPool.GetDataset(const AKey: Int64): TClientDataset;
begin
 FDatasetsPool.Items[AKey];
end;

function TDatasetsPool.GetDatasetsCount: integer;
begin
  Result := FDatasetsPool.Count;
end;

function TDatasetsPool.GetNewDataset: TClientDataset;
var
 AKey: Int64;
begin
 //Retorna um dataset existente no pool de conexões.
 Randomize;
 Result := nil;

 Akey := Random(30);

 while Result = nil do
  begin
   if (FDatasetsPool.ContainsKey(AKey)) and not (FDatasetsPool[AKey].Active) then
    Result := FDatasetsPool[AKey];
   Akey := Random(30);
  end;
end;

procedure TDatasetsPool.RemoveDataset(const SessionId: Int64);
var
 aDataset: TClientDataset;
begin
 if FDatasetsPool.ContainsKey(SessionId) then
  begin
   aDataset := FDatasetsPool[SessionId];
   aDataset.Free;
   FDatasetsPool.Remove(SessionId);
  end;
end;

end.
