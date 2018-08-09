unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
    Data.DBXCommon, Data.SQLExpr;

type
  TServerMethods1 = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetEstados: TSQLDataset;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, Unit1;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetEstados: TSQLDataset;
var
 aConn: TSQLConnection;
 aDataset: TSQLDataset;
begin
 aConn := TDatalayer.CreateConnection;

 try
  aDataset := TDatalayer.ExecuteQuery(aConn, 'select nomest, sigest from ESTADOS order by nomest');
  Result := aDataset;

 finally
  aConn.Free;
 end;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

