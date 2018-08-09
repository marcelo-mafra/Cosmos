unit cosmos.conferencias.inscricoes.importacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, ADODB;

const
 sExcelConnect = 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=Excel Files;Initial Catalog=%s'; //do not localize!
 sCommand = 'select * from %s'; //do not localize!

type
 TExcelReader = class

  private
   FExcelConnection: TADOConnection;
   FDataset: TADODataset;

   function GetEOF: boolean;

  public
   constructor Create;
   destructor Destroy; override;
   function OpenFile(const FileName, Schemma: string): boolean;
   procedure CloseFile;
   procedure ReadLine(DestList: TStringList);
   function ReadValue(const ColumnName: string): variant;
   procedure NextLine;

   property EOF: boolean read GetEOF;

 end;

implementation

{ TIncricoesImporter }

procedure TExcelReader.CloseFile;
begin
 FExcelConnection.Close;
end;

constructor TExcelReader.Create;
begin
 inherited Create;
 FExcelConnection := TADOConnection.Create(nil);
 FDataset := TADODataset.Create(nil);
 FDataset.Connection := FExcelConnection;
end;

destructor TExcelReader.Destroy;
begin
  if Assigned(FDataset) then
   FreeAndNil(FDataset);

  if Assigned(FExcelConnection) then
   FreeAndNil(FExcelConnection);
  inherited;
end;

function TExcelReader.GetEOF: boolean;
begin
 if FDataset.Active then
  Result := FDataset.Eof
 else
  Result := False;
end;

procedure TExcelReader.NextLine;
begin
 if FDataset.Active then
  FDataset.Next;
end;

function TExcelReader.OpenFile(const FileName, Schemma: string): boolean;
begin
 Result := False;
 FExcelConnection.LoginPrompt := False;
 if FileExists(FileName) then
  begin
   try
    FExcelConnection.ConnectionString := Format(sExcelConnect, [FileName]);
    FExcelConnection.Open;
    FDataset.CommandText := Format(sCommand, [UpperCase(Schemma)]);
    FDataset.Open;
    Result := (FExcelConnection.Connected) and (FDataset.Active);

   except
    raise;
   end;
  end
 else
  Result := False;
end;

procedure TExcelReader.ReadLine(DestList: TStringList);
var
I: integer;
sValue: string;
begin
 if DestList <> nil then
  begin
    DestList.Clear;

    for I := 0 to Pred(FDataset.FieldCount) do
      begin
        sValue := FDataset.Fields.Fields[I].FieldName + '=' +  FDataset.Fields.Fields[I].AsString;
        DestList.Append(sValue);
      end;
  end;
end;

function TExcelReader.ReadValue(const ColumnName: string): variant;
begin
 if FDataset.FindField(ColumnName) <> nil then
  Result := FDataset.FindField(ColumnName).Value
 else
  Result := null;
end;

end.
