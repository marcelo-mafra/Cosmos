unit cosmos.conferencias.clientconnections;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.common.services.clientconnections, Data.DBXDataSnap,
  IPPeerClient, Data.DBXCommon, Data.FMTBcd, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, Datasnap.DBClient, Datasnap.DSConnect,
  Data.SqlExpr, Data.DB, Vcl.AppEvnts, Vcl.ExtCtrls, Datasnap.Provider;

type
  TDMCon = class(TDMBase)
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
