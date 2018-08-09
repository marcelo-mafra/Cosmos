unit DataModule;

interface

uses
  SysUtils, Classes, DB, DBClient, VBaseExport, VASCIIExport, VRTFExport, VExcelExport,
  MMSBaseExporter, MMSSQLExporter, HTTPApp, DBWeb;

type
  TDM = class(TDataModule)
    CdsExport: TClientDataSet;
    TableProd: TDataSetTableProducer;
    ASCIIExport: TVASCIIExport;
    RTFExport: TVRTFExport;
    ExcelExport: TVExcelExport;
    SQLExport: TMMSSQLExporter;
    procedure TableProdCreateContent(Sender: TObject;
      var Continue: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.TableProdCreateContent(Sender: TObject;
  var Continue: Boolean);
begin
TableProd.Footer.Add('<h5><font face= "Tahoma, Arial" color=black>' +
                     DateTimeToSTr(Now) + '</font></h5>');
Continue := True;

end;

end.
