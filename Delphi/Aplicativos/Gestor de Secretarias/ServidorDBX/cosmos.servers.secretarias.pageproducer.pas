unit cosmos.servers.secretarias.pageproducer;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.DBWeb, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Web.HTTPProd;

type
  TDMSecPageProducer = class(TDataModule)
    DstTableProducer: TDataSetTableProducer;
    PageProducer1: TPageProducer;
  private
    { Private declarations }
  public
    { Public declarations }
    function GeneratePage(Params: TStrings): string;
    function GenerateTable(Dataset: TDataset): string;
  end;

var
  DMSecPageProducer: TDMSecPageProducer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses cosmos.servers.common.dataacess;

{$R *.dfm}

{ TDMSecPageProducer }

function TDMSecPageProducer.GeneratePage(Params: TStrings): string;
var
 ADataset: TSQLDataset;
begin
 ADataset := DMServerDataAcess.CreateDataset;

 try
  DstTableProducer.MaxRows := 1000;
  ADataset.CommandText := 'select matcad, nomcad from cadastrados where codfoc = 6 order by matcad';
  ADataset.Open;
  DstTableProducer.DataSet := ADataset;
  DstTableProducer.Caption := 'Cosmos Pupils';
  DstTableProducer.Columns.RebuildColumns;

  Result := DstTableProducer.Content;

 finally
  ADataset.Free;
 end;
end;

function TDMSecPageProducer.GenerateTable(Dataset: TDataset): string;
var
 aTable: TDatasetTableProducer;
begin
 aTable := TDatasetTableProducer.Create(self);

 try
  aTable.DataSet := Dataset;
  aTable.Caption := '';

  Result := aTable.Content;

 finally
  aTable.Free;
 end;

end;

end.
