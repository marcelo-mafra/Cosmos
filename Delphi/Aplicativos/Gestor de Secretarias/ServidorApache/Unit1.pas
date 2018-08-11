unit Unit1;

interface

uses Data.DBXFirebird, Data.DB, Data.SqlExpr, Data.FMTBcd;

type
 TDatalayer = class
  private
   class procedure LoadConnectionParams(aConn: TSQLConnection); inline;

  public
   class function CreateConnection: TSQLConnection;
   class function ExecuteQuery(aConn: TSQLConnection; Query: string): TSQLDataset;
 end;

implementation

{ TDatalayer }

class function TDatalayer.CreateConnection: TSQLConnection;
begin
 Result := TSQLConnection.Create(nil);
 LoadConnectionParams(Result);
 Result.Open;
end;

class function TDatalayer.ExecuteQuery(aConn: TSQLConnection;
  Query: string): TSQLDataset;
begin
 Result := TSQLDataset.Create(nil);
 Result.SQLConnection := aConn;
 Result.CommandText := Query;
 Result.Open;
end;

class procedure TDatalayer.LoadConnectionParams(aConn: TSQLConnection);
begin
 aConn.DriverName := 'Firebird';
 aConn.Params.Values['Database'] := 'D:\Marcelo\Projeto Cosmos\Banco de dados\COSMOSDB.FDB';
 aConn.Params.Values['RoleName'] := 'DEI';
 aConn.Params.Values['Role'] := 'DEI';
 aConn.Params.Values['User_Name'] := 'cosmos';
 aConn.Params.Values['Password'] := 'galaad';
 aConn.Params.Values['ServerCharSet'] := 'ISO8859_1';

{DriverName=Firebird
Database=D:\Marcelo\Projeto Cosmos\Banco de dados\COSMOSDB.FDB
RoleName=DEI
User_Name=cosmos
Password=galaad
ServerCharSet=ISO8859_1
SQLDialect=3
ErrorResourceFile=
LocaleCode=0000
BlobSize=-1
CommitRetain=False
WaitOnLocks=True
IsolationLevel=ReadCommitted
Trim Char=False
Role=DEI}
end;

end.
