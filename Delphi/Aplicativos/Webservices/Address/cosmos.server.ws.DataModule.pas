unit cosmos.server.ws.DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.Client,
  Data.DB, FireDAC.Phys.IBBase, FireDAC.Phys.FB, System.IniFiles, FireDAC.DApt,
  FireDAC.Comp.DataSet, Data.FireDACJSONReflect;

type
  TDM = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDConnection1: TFDConnection;
    FDTransaction1: TFDTransaction;
  private
    { Private declarations }
    procedure LoadDatabaseOptions(Connection: TFDConnection);
    function DoCreateConnection: TFDConnection;
    function DoCreateDataset: TFDQuery;

  public
    { Public declarations }
    function ExecuteSQL(const SQL: string): TFDJSONDataSets;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

function TDM.DoCreateConnection: TFDConnection;
begin
 Result := TFDConnection.Create(self);
 Result.LoginPrompt := False;
 Result.Params.Assign(FDConnection1.Params);
 LoadDatabaseOptions(Result);
 Result.Transaction := self.FDTransaction1;
 Result.Open;
end;

function TDM.DoCreateDataset: TFDQuery;
begin
 Result := TFDQuery.Create(self);
 Result.Connection := self.DoCreateConnection;
end;

function TDM.ExecuteSQL(const SQL: string): TFDJSONDataSets;
var
 aDataset: TFDQuery;
begin
 aDataset := DoCreateDataset;

 try
   aDataset.SQL.Add(SQL);
   aDataset.Open;

   Result := TFDJSONDataSets.Create;
   TFDJSONDataSetsWriter.ListAdd(Result, aDataset);

 finally
   aDataset.Free;
 end;
end;

procedure TDM.LoadDatabaseOptions(Connection: TFDConnection);
var
 aIniFile: TIniFile;
begin
 aIniFile := TIniFile.Create('dbOptions.ini');

 try
  Connection.Params.Values['Server'] := aIniFile.ReadString('COSMOSDB', 'Server', '');
  Connection.Params.Database := aIniFile.ReadString('COSMOSDB', 'Database', '');
  Connection.Params.UserName := aIniFile.ReadString('COSMOSDB', 'UserName', 'cosmos');
  Connection.Params.Password := aIniFile.ReadString('COSMOSDB', 'Password', '');

 finally
  aIniFile.Free;
 end;
end;

end.
