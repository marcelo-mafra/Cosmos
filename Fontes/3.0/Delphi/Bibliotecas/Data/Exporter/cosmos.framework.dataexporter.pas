unit cosmos.framework.dataexporter;

interface

uses System.SysUtils, Data.DB, dbWeb, System.Classes, System.Win.ComObj,
 Xml.XMLDoc, Xml.XMLIntf, System.Variants, Datasnap.DBClient;

 type

  TOnProgressEvent = procedure(ADataset: TDataset) of object;

  TDataExporter = class

  private
   FOnProgressEvent: TOnProgressEvent;
   function CreateClientDataset(Source: TDataset): TClientDataset;

  public
   constructor Create;
   destructor Destroy; override;

   procedure ToHTML(DataSet: TDataSet; FileName: string);
   procedure ToTXT(DataSet: TDataSet; FileName: string);
   procedure ToExcel(DataSet: TDataSet; FileName: string);
   procedure ToWord(DataSet: TDataSet; FileName: string);
   procedure ToXML(DataSet: TDataSet; FileName: string);
   procedure ToCSV(DataSet: TDataSet; FileName: string);
   procedure ToOpenOffice(DataSet: TDataSet; FileName: string);

  public
   property OnProgressEvent: TOnProgressEvent read FOnProgressEvent write FOnProgressEvent;

  end;


implementation



{ TDataExporter }

constructor TDataExporter.Create;
begin
  inherited;
end;

function TDataExporter.CreateClientDataset(Source: TDataset): TClientDataset;
var
 I: integer;
 AFieldDef: TFieldDef;
 AField: TField;
 ABookmark: TBookmark;
 aDataset: TClientDataset;
begin
{Cria um dataset de memória e copia os dados para ele. Isto é necessário para
manipularmos os dados para esconder colunas ocultas da exportação e para
exportarmos as colunas com apenas o seu nome de exibição.}
 aDataset := TClientDataset.Create(nil);
 //Copia as definições de campos para o dataset em memória.

   for I := 0 to Pred(Source.FieldDefs.Count) do
    begin
     AField := Source.Fields.FieldByName(Source.FieldDefs.Items[I].Name);

     if AField.Visible then
      begin
       AFieldDef := aDataset.FieldDefs.AddFieldDef;
       aFieldDef.Name := Source.FieldDefs.Items[I].Name;
       aFieldDef.DataType := Source.FieldDefs.Items[I].DataType;
       aFieldDef.Size := Source.FieldDefs.Items[I].Size;
       aFieldDef.Required := False;
       aFieldDef.Attributes := [];
      end;
    end;

 aDataset.CreateDataSet;

 //Agora altera a propriedade "DisplayLabel" dos campos para exibir apenas estes
 //e não seus nomes originais.
 for I := 0 to Pred(Source.Fields.Count) do
  begin
   AField := aDataset.FindField(Source.Fields.Fields[I].FieldName);
   if AField <> nil then
    begin
     AField.DisplayLabel := Source.Fields.Fields[I].DisplayLabel;
    end;
  end;

 //Finalmente, copia os dados para o dataset de memória.
 try

  Source.DisableControls;
  ABookmark := Source.GetBookmark;
  Source.First;

  while not Source.Eof do
   begin
    aDataset.Append;

    for I := 0 to Pred(Source.Fields.Count) do
     begin
       AField := aDataset.FindField(Source.Fields.Fields[I].FieldName);
       if (AField <> nil) and (AField.FieldKind = Source.Fields.Fields[I].FieldKind) then
        if not AField.IsBlob then
          AField.Value := Source.Fields.Fields[I].Value;
     end;

    Source.Next;
   end;

 finally
  Result := aDataset;
  Source.GotoBookmark(ABookMark);
  Source.EnableControls;
 end;
end;

destructor TDataExporter.Destroy;
begin
 inherited Destroy;
end;

{ O código abaixo usa a tecnologia WebBroker, criada no Delphi3, para converter um DataSet para HTML. Isso é feito através do objeto DataSetTableProducer. Apesar de ser uma tecnologia antiga e usada para criar CGIs e ISAPIs para Web, é muito simples utilizar suas classes em aplicações Desktop }

procedure TDataExporter.ToHTML(DataSet: TDataSet; FileName: string);
var
  AList: TStringList;
  ATable: TDataSetTableProducer;
  MyDataset: TClientDataset;

begin
  AList := TStringList.Create;
  ATable := TDataSetTableProducer.Create(nil);
  MyDataset := self.CreateClientDataset(Dataset);

  try
    MyDataset.First;
    ATable.Dataset := MyDataset;
    ATable.TableAttributes.Border := 1;
    AList.Text := ATable.Content;
    AList.SaveToFile(FileName);

  finally
    ATable.free;
    AList.free;
    if Assigned(MyDataset) then
     FreeAndNil(MyDataset);
  end;
end;

procedure TDataExporter.ToOpenOffice(DataSet: TDataSet; FileName: string);
begin

end;

{ O código abaixo usa Delphi puro, montando um TXT no braço, basicamente varremos o dataSet e vamos montando o arquivo texto separando campos por ponto e vírgula }

procedure TDataExporter.ToTXT(DataSet: TDataSet; FileName: string);
var
  i: integer;
  AList: TStringList;
  MyDataset: TClientDataset;
  AValue: string;
begin
  MyDataset := self.CreateClientDataset(Dataset);
  AList := TStringList.Create;
  MyDataset.First;

  try
    AValue := '';
    for i := 0 to MyDataset.Fields.Count - 1 do
      AValue := AValue + QuotedStr(MyDataset.Fields[i].DisplayLabel) + '|';

    AList.Add(AValue);
    MyDataset.First;

    while not MyDataset.Eof do
     begin
      AValue := '';
      for i := 0 to MyDataset.Fields.Count - 1 do
        AValue := AValue + QuotedStr(MyDataset.Fields[i].DisplayText) + '|';
      AList.Add(AValue);
      MyDataset.Next;
     end;

    AList.SaveToFile(FileName);

  finally
   AList.free;
   if Assigned(MyDataset) then
    FreeAndNil(MyDataset);
  end;
end;

{ O código abaixo usa a tecnologia OLE para criar uma planilha do Excel e enviar os dados do DataSet . OLE é uma tecnologia que pode ser usada desde o Delphi 2 e permite manipular aplicações automaticamente, o que chamamos de Automation, usando interface COM }

procedure TDataExporter.ToCSV(DataSet: TDataSet; FileName: string);
var
 AFile: TStringList;
 ALine: string;
 I: integer;
 MyDataset: TClientDataset;
begin
 AFile := TStringList.Create;
 MyDataset := self.CreateClientDataset(Dataset);

 for I := 0 to Pred(MyDataset.FieldCount) do
  begin
   ALine := ALine + MyDataset.Fields.Fields[I].DisplayLabel;
   if I < Pred(MyDataset.FieldCount) then
    ALine := ALine + ';';
  end;

 AFile.Append(ALine);
 MyDataset.First;

 while not MyDataset.Eof do
  begin
   ALine := '';
   for I := 0 to Pred(MyDataset.FieldCount) do
    begin
     ALine := ALine + MyDataset.Fields.Fields[I].AsString;
     if I < Pred(MyDataset.FieldCount) then
      ALine := ALine + ';';
    end;

   AFile.Append(ALine);

  if Assigned(FOnProgressEvent) then
     FOnProgressEvent(MyDataset);

   MyDataset.Next;
  end;

 try
  AFile.SaveToFile(FileName);

 finally
  if Assigned(AFile) then
   FreeAndNil(AFile);
  if Assigned(MyDataset) then
   FreeAndNil(MyDataset);
 end;

end;

procedure TDataExporter.ToExcel(DataSet: TDataSet; FileName: string);
var
  AWorkSheet : Variant;
  I, ALine : Integer;
  MyDataset: TClientDataset;
begin
 MyDataset := self.CreateClientDataset(Dataset);

 try
  AWorkSheet := CreateOleObject('Excel.Application');
  AWorkSheet.Caption := 'COSMOS';
  AWorkSheet.Visible := False;
  AWorkSheet.WorkBooks.add(1);

  for I := 1 to MyDataset.FieldCount do
   AWorkSheet.Cells[1, I] := MyDataset.Fields.Fields[I - 1].DisplayLabel;

  ALine := 2;
  MyDataset.First;

  while not MyDataset.Eof do
   begin
   // I := 1;
     for I := 1 to MyDataset.Fields.Count do
       AWorkSheet.Cells[ALine, I] := MyDataset.Fields.Fields[I - 1].AsString;

     ALine := ALine + 1;
     MyDataset.Next;
   end;

  AWorkSheet.Columns.AutoFit;
  AWorkSheet.WorkBooks[1].SaveAs(FileName);
  AWorkSheet.Quit;

 finally
  if Assigned(MyDataset) then
   FreeAndNil(MyDataset);
  AWorkSheet := Unassigned;
 end;
end;

{ O código abaixo usa a tecnologia OLE para criar uma tabela no WORD e enviar os dados do DataSet  }

procedure TDataExporter.ToWord(DataSet: TDataSet; FileName: string);
var
  WordApp,WordDoc,WordTable,WordRange: Variant;
  Row,Column: integer;
  MyDataset: TClientDataset;
begin
  MyDataset := self.CreateClientDataset(Dataset);

  try
   WordApp := CreateOleobject('Word.basic');
   WordApp.Appshow;
   WordDoc := CreateOleobject('Word.Document');
   WordRange := WordDoc.Range;
   WordTable := WordDoc.tables.Add(WordDoc.Range,1, MyDataSet.FieldCount);

  for Column:=0 to MyDataSet.FieldCount-1 do
    WordTable.cell(1,Column+1).range.text:= MyDataSet.Fields.Fields[Column].DisplayLabel;

  Row := 2;
  MyDataSet.First;

  while not MyDataSet.Eof do
   begin
    WordTable.Rows.Add;
    for Column:=0 to MyDataSet.FieldCount -1 do
      WordTable.cell(Row,Column+1).range.text := MyDataSet.Fields.Fields[Column].DisplayText;

    MyDataSet.next;
    Row := Row+1;
  end;

  WordDoc.SaveAs(FileName);
  WordDoc := unAssigned;

  finally
   if Assigned(MyDataset) then
    FreeAndNil(MyDataset);
  end;

end;

{ O código abaixo usa DOM, ou seja, o objeto XMLDocumento do Delphi para criar uma estrutura XML em memória, que posteriormente é salva em disco }

procedure TDataExporter.ToXML(DataSet : TDataSet; FileName: string);
var
  i: integer;
  xml: TXMLDocument;
  reg, campo: IXMLNode;
  MyDataset : TClientDataset;
begin
  xml := TXMLDocument.Create(nil);
  MyDataset := self.CreateClientDataset(Dataset);

  try
    xml.Active := True;
    MyDataSet.First;
    xml.DocumentElement :=
      xml.CreateElement('DataSet','');
    MyDataSet.First;
    while not MyDataSet.Eof do
    begin
      reg := xml.DocumentElement.AddChild('row');
      for i := 0 to MyDataSet.Fields.Count - 1 do
      begin
        campo := reg.AddChild(
          MyDataSet.Fields[i].DisplayLabel);
        campo.Text := MyDataSet.Fields[i].DisplayText;
      end;
      MyDataSet.Next;
    end;
    xml.SaveToFile(FileName);

  finally
   if Assigned(MyDataset) then
    FreeAndNil(MyDataset);
    xml.free;
  end;
end;

end.
