unit cosmos.focos.services.clientconnections;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, cosmos.common.services.clientconnections,
  DB, DBClient, Data.DBXDataSnap, Data.DBXCommon, Data.FMTBcd, Xml.xmldom, Xml.XMLIntf,
  Data.SqlExpr, Datasnap.Provider, Xml.XMLDoc;

type
  TDMCon = class(TDMBase)
    CdsSearch: TClientDataSet;
    DsrSearch: TDataSource;
    CdsBufferedFocus: TClientDataSet;
    DsrBufferedFocus: TDataSource;
    CdsBufferedMentors: TClientDataSet;
    DsrBufferedMentors: TDataSource;
    CdsBufferedEnderecosFocos: TClientDataSet;
    DsrBufferedEnderecosFocos: TDataSource;
    CdsFicha: TClientDataSet;
    CdsDirigentesAtuais: TClientDataSet;
    CdsBufferedDirecoes: TClientDataSet;
    DsrBufferedDirecoes: TDataSource;
    DsrDirigentesAtuais: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCon: TDMCon;

implementation

{$R *.dfm}

end.
