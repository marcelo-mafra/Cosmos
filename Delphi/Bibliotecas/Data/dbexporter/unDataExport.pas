unit unDataExport;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, dbexporter_TLB, StdVcl, dbClient;

type
  TDataExporter = class(TTypedComObject, IDataExporter)
  protected
    function ToText(var Data: OleVariant; const FileName: WideString): WordBool;
      stdcall;
    function ToDOC(var Data: OleVariant; const FileName: WideString): WordBool;
      stdcall;
    function ToHTM(var Data: OleVariant; const FileName: WideString): WordBool;
      stdcall;
    function ToXML(var Data: OleVariant; const FileName: WideString): WordBool;
      stdcall;
    function ToXSL(var Data: OleVariant; const FileName: WideString): WordBool;
      stdcall;
    {Declare IDataExporter methods here}
  end;

implementation

uses ComServ, DMExport;

function TDataExporter.ToDOC(var Data: OleVariant;
  const FileName: WideString): WordBool;
begin
 Result := False;
end;

function TDataExporter.ToHTM(var Data: OleVariant;
  const FileName: WideString): WordBool;
begin
 try
  DM.CdsData.Data := Data;
  DM.ExpHTML.SaveToFile(FileName);
  Result := True;
  DM.CdsData.Close;

 except
  Result := False;
  DM.CdsData.Close;
 end;
end;

function TDataExporter.ToXML(var Data: OleVariant;
  const FileName: WideString): WordBool;
var
Cds: TClientDataset;
begin
 try
  Cds := TClientDataset.Create(nil);
  Cds.Data := Data;
  Cds.SaveToFile(FileName,dfXML);
  Result := True;
  if Assigned(Cds) then
   Cds.Free;

 except
  Result := False;
  if Assigned(Cds) then
   Cds.Free;
 end;

end;

function TDataExporter.ToXSL(var Data: OleVariant;
  const FileName: WideString): WordBool;
begin
 try
  DM.CdsData.Data := Data;
  DM.ExpXLS.SaveToFile(FileName);
  Result := True;
  DM.CdsData.Close;

 except
  Result := False;
  DM.CdsData.Close;
 end;
end;

function TDataExporter.ToText(var Data: OleVariant;
  const FileName: WideString): WordBool;
begin
 try
  DM.CdsData.Data := Data;
  DM.ExpText.SaveToFile(FileName);
  Result := True;
  DM.CdsData.Close;

 except
  Result := False;
  DM.CdsData.Close;
 end;
end;

initialization
  TTypedComObjectFactory.Create(ComServer, TDataExporter, Class_DataExporter,
    ciMultiInstance, tmApartment);
end.
