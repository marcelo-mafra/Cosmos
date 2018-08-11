unit uhelplib;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, helplib_TLB, StdVcl;

type
  TCosmosHelp = class(TTypedComObject, ICosmosHelp)
  protected
    function ShowHelpTopics: HResult; stdcall;
    function Get_FileName(out Value: WideString): HResult; stdcall;
    function Set_FileName(Value: Integer): WideString; stdcall;
    function Get_HelpFile(out Value: WideString): HResult; stdcall;
    function Set_HelpFile(Value: Integer): WideString; stdcall;
    {Declare ICosmosHelp methods here}
  end;

implementation

uses ComServ;

function TCosmosHelp.Get_HelpFile(out Value: WideString): HResult;
begin

end;

function TCosmosHelp.Set_HelpFile(Value: Integer): WideString;
begin

end;

function TCosmosHelp.Get_FileName(out Value: WideString): HResult;
begin

end;

function TCosmosHelp.Set_FileName(Value: Integer): WideString;
begin

end;

function TCosmosHelp.ShowHelpTopics: HResult;
begin

end;

initialization
  TTypedComObjectFactory.Create(ComServer, TCosmosHelp, Class_CosmosHelp,
    ciMultiInstance, tmApartment);
end.
