unit ExporterFunctions;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, Classes, Exporter_TLB, StdVcl, DBClient;

type
  TDataExporter = class(TAutoObject, IDataExporter)
  protected
    procedure ExportToFile(Data: OleVariant; const FileName: WideString;
      Format: Integer); safecall;
    procedure ExportToSQL(Data: OleVariant; const FileName, TableName,
      DateTimeFormat: WideString; CreateMetadata: WordBool); safecall;
    { Protected declarations }
  end;

implementation

uses ComServ, DataModule;

procedure TDataExporter.ExportToFile(Data: OleVariant;
  const FileName: WideString; Format: Integer);
var
DM: TDM;
List: TStringList;
begin
Try
  DM := TDM.Create(nil);
  if Assigned(DM) then
   begin
    DM.CdsExport.Close;
    DM.CdsExport.Data := Data;
    DM.CdsExport.Open;
    with DM do
     begin
      case Format of
       0: CdsExport.SaveToFile(FileName,dfXML); //Exporta para XML
       1: begin //Exporta para HTML
           List := TSTringList.Create;
           List.Add(TableProd.Content);
           List.SaveToFile(FileName);
           List.Free;
          end;
       2: CdsExport.SaveToFile(FileName); //Exporta em formato binário
       3: begin //Exporta para texto ASCII
           ASCIIExport.FileName := FileName;
           ASCIIExport.ExportedFields := CdsExport.FieldDefList;
           ASCIIExport.Execute;
          end;
       4: begin //Exporta para RTF
           RTFExport.FileName := FileName;
           RTFExport.ExportedFields := CdsExport.FieldDefList;
           RTFExport.Execute;
          end;
       5: begin //Exporta para Excel
           ExcelExport.FileName := FileName;
           ExcelExport.ExportedFields := CdsExport.FieldDefList;
           ExcelExport.Execute;
          end;
      end;
    end;
   end;

Finally
if Assigned(DM) then
 if DM.CdsExport.Active then
  Dm.CdsExport.Close;
end;


end;

procedure TDataExporter.ExportToSQL(Data: OleVariant; const FileName,
  TableName, DateTimeFormat: WideString; CreateMetadata: WordBool);
var
DM: TDM;
begin
Try
//Gera um arquivo SQL através do componente TMMSSQLExport
  DM := TDM.Create(nil);
  if Assigned(DM) then
   begin
    DM.CdsExport.Close;
    DM.CdsExport.Data := Data;
    DM.CdsExport.Open;
    with DM do
     begin
      SQLExport.Fields := CdsExport.FieldDefList;
      SQLExport.TableName := TableName;
      SQLExport.DateFormat := DateTimeFormat;
      SQLExport.Execute(FileName);
     end;
   end;

Finally
if Assigned(DM) then
 if DM.CdsExport.Active then
  Dm.CdsExport.Close;
end;


end;

initialization
  TAutoObjectFactory.Create(ComServer, TDataExporter, Class_DataExporter,
    ciMultiInstance, tmApartment);
end.
