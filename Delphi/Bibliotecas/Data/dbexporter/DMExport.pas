unit DMExport;

interface

uses
  SysUtils, Classes, DataToHTML, DataToXLS, DataExport, DataToAscii, DB,
  DBClient;

type
  TDM = class(TDataModule)
    CdsData: TClientDataSet;
    ExpText: TDataToAscii;
    ExpXLS: TDataToXLS;
    ExpHTML: TDataToHTML;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
