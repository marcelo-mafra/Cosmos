{ Invokable implementation File for TCosmosAddress which implements ICosmosAddress }

unit cosmos.server.ws.CosmosAddressImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, cosmos.server.ws.CosmosAddressIntf;

type

  { TCosmosAddress }
  TCosmosAddress = class(TInvokableClass, ICosmosAddress)
  public
    function echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function echoDouble(const Value: Double): Double; stdcall;

    function GetCountries: WideString; stdcall;
    function GetStates(CountryId: integer): WideString; stdcall;
  end;

implementation

function TCosmosAddress.echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
begin
  { TODO : Implement method echoEnum }
  Result := Value;
end;

function TCosmosAddress.echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
begin
  { TODO : Implement method echoDoubleArray }
  Result := Value;
end;

function TCosmosAddress.echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
begin
  { TODO : Implement method echoMyEmployee }
  Result := TMyEmployee.Create;
end;

function TCosmosAddress.GetCountries: WideString;
begin

end;

function TCosmosAddress.GetStates(CountryId: integer): WideString;
begin

end;

function TCosmosAddress.echoDouble(const Value: Double): Double; stdcall;
begin
  { TODO : Implement method echoDouble }
  Result := Value;
end;


initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TCosmosAddress);
end.

