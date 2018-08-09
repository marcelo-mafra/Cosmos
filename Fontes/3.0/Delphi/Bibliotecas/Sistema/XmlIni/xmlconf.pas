unit xmlconf;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, xmlcon_TLB, StdVcl;

type
  TXmlconf = class(TTypedComObject, IXmlconf)
  protected
    {Declare IXmlconf methods here}
  end;

implementation

uses ComServ;

initialization
  TTypedComObjectFactory.Create(ComServer, TXmlconf, Class_Xmlconf,
    ciMultiInstance, tmApartment);
end.
