unit cosmos.focos.reports;

interface

uses
  SysUtils, Classes, frxClass;

type
  TDMFocosReports = class(TDataModule)
    frxReport1: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DMFocosReports: TDMFocosReports;

implementation


{$R *.dfm}

uses cosmos.focos.reports.data;

{ TDMRepData }



end.
