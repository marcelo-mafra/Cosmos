unit cosmos.classes.persistence.xml;

interface

uses
  System.SysUtils, System.Classes, Winapi.Windows, XML.XmlIntf, XML.XMLDoc,
  cosmos.classes.persistence;

type
  TXMLPersistence = class(TFilePersistence)
  private
    FModified: Boolean;
    FFileName: string;
    FCreateBackup: Boolean;
    FXML: IXMLDocument;
    FTopNode: IXMLNode;
    FCurrentNode: IXMLNode;
    function GetFileName: string;
    function GetCurrentNode: string;

    function FindNode(const ParentNode, ChildNode: string): IXMLNode;

  public
    constructor Create(const FileName, TopSection: string);
    destructor Destroy; override;
    procedure Save;
    procedure CreateNode(const Section: string; FromCurrent: boolean = False); overload;
    procedure CreateNode(const ParentNode, NewNode: string); overload;
    function ReadString(const ParentNode, ChildNode, Attribute: string): string; reintroduce;
    function ReadInteger(const ParentNode, ChildNode, Attribute: string): Integer; reintroduce;
    function ReadBoolean(const ParentNode, ChildNode, Attribute: string): Boolean; reintroduce;
    function ReadFloat(const ParentNode, ChildNode, Attribute: string): double; reintroduce;
    function ReadDateTime(const ParentNode, ChildNode, Attribute: string): TDateTime; reintroduce;
    function ReadDate(const ParentNode, ChildNode, Attribute: string): TDate; reintroduce;

    procedure WriteString(const Section, Key, Value: string); override;
    procedure WriteInteger(const Section, Key: string; Value: Integer); override;
    procedure WriteBoolean(const Section, Key: string; Value: Boolean); override;
    procedure WriteFloat(const Section, Key: string; Value: double); override;
    procedure WriteDateTime(const Section, Key: string; Value: TDateTime); override;
    procedure WriteDate(const Section, Key: string; Value: TDate); override;

    procedure GetXML(List: TStrings);
    procedure GetNodesList(List: TStrings);


    property CreateBackup: Boolean read FCreateBackup write FCreateBackup;
    property CurrentNode: string read GetCurrentNode;
    property FileName: string read GetFileName;

  end;

implementation

{ TXMLPersistence }

constructor TXMLPersistence.Create(const FileName, TopSection: string);
begin
  inherited Create(FileName);
  FXML := NewXMLDocument;
  FXML.Encoding := 'UTF-8'; //do not localize!

  FCreateBackup         := False;
  FFileName       := FileName;

  FXML.Options := [doNodeAutoIndent];

  if FileExists(FFileName) then
   begin
    FXML.LoadFromFile(FFileName);
    FTopNode := FXML.DocumentElement;
   end
  else
  begin
    FXML.Active := True;
    FTopNode := FXML.AddChild(TopSection);
    FXML.SaveToFile(FileName);
  end;
end;

procedure TXMLPersistence.CreateNode(const Section: string; FromCurrent: boolean = False);
var
  Node: IXMLNode;
begin
 if FromCurrent = False then
  begin
   Node := FTopNode.ChildNodes.FindNode(Section);
   if not Assigned(Node) then
    begin
     Node := FTopNode.AddChild(Section);
     FCurrentNode := Node;
    end;
  end
 else
  begin
   Node := FCurrentNode.ChildNodes.FindNode(Section);

   if not Assigned(Node) then
    begin
     Node := FCurrentNode.AddChild(Section);
     FCurrentNode := Node;
    end;
  end;
end;

procedure TXMLPersistence.CreateNode(const ParentNode, NewNode: string);
//var
// Node: IXMLNode;
begin
{ Node := FindNode(ParentNode);
 if Node <> nil then
  Node.AddChild(NewNode);}
end;

destructor TXMLPersistence.Destroy;
begin
  FTopNode := nil;
  FXML := nil;
  inherited;
end;

function TXMLPersistence.FindNode(const ParentNode, ChildNode: string): IXMLNode;
var
 AParentNode, AChildNode: IXMLNode;
begin
 AParentNode := FTopNode;

 while AParentNode <> nil do
  begin
   if AParentNode.ChildNodes.IndexOf(ChildNode) >= 0 then
    begin
     if (AParentNode.Text = ParentNode) and (AChildNode.Text = ChildNode) then
      begin
       Result := AChildNode;
       Break;
      end;
    end;


    AParentNode := AParentNode.NextSibling;
    //outputdebugstring(PWideChar(AParentNode.Text));
  end;

end;

function TXMLPersistence.GetCurrentNode: string;
begin
 if FCurrentNode <> nil then
  Result := FCurrentNode.NodeName
 else
  Result := '';
end;

function TXMLPersistence.GetFileName: string;
begin
 Result := self.FXML.FileName;
end;

procedure TXMLPersistence.GetNodesList(List: TStrings);
var
I: integer;
begin
 //self.FTopNode.ChildNodes
 for I := 0 to FTopNode.ChildNodes.Count - 1 do
   begin
    List.Append(FTopNode.ChildNodes.Nodes[I].NodeName);
   end;
end;

procedure TXMLPersistence.GetXML(List: TStrings);
begin
 if Assigned(List) then
  List.Assign(self.FXML.XML);
end;

function TXMLPersistence.ReadBoolean(const ParentNode, ChildNode, Attribute: string): Boolean;
begin
  Result := Boolean(ReadInteger(ParentNode, ChildNode, Attribute));
end;

function TXMLPersistence.ReadDate(const ParentNode, ChildNode, Attribute: string): TDate;
begin
  Result := StrToDate(ReadString(ParentNode, ChildNode, Attribute));
end;

function TXMLPersistence.ReadDateTime(const ParentNode, ChildNode, Attribute: string): TDateTime;
begin
  Result := StrToDateTime(ReadString(ParentNode, ChildNode, Attribute));
end;

function TXMLPersistence.ReadFloat(const ParentNode, ChildNode, Attribute: string): double;
begin
  Result := StrToFloat(ReadString(ParentNode, ChildNode, Attribute));
end;

function TXMLPersistence.ReadInteger(const ParentNode, ChildNode, Attribute: string): Integer;
begin
  Result := StrToInt(ReadString(ParentNode, ChildNode, Attribute));
end;

function TXMLPersistence.ReadString(const ParentNode, ChildNode, Attribute: string): string;
var
 ANode: IXMLNode;
begin
 Result := '';

 if (Trim(ParentNode) <> '') and (Trim(Attribute) <> '') then
  begin
   ANode := FindNode(ParentNode, ChildNode);
   if ANode <> nil then
    Result := ANode.Attributes[Attribute];
  end
 else
  raise exception.Create('O nome do nó principal e do atributo não pode ser omitido.');
end;

procedure TXMLPersistence.Save;
begin
//  if not FModified then
  //  Exit;

  if FCreateBackup then
   CopyFile(PChar(FFileName), PChar(FFileName + '.bak'), False);

 FXML.SaveToFile(FFileName);
 FModified := False;
end;

procedure TXMLPersistence.WriteBoolean(const Section, Key: string; Value: Boolean);
begin
  WriteInteger(Section, Key, Integer(Value));
end;

procedure TXMLPersistence.WriteDate(const Section, Key: string; Value: TDate);
begin
  inherited;
  WriteString(Section, Key, DateToStr(Value));
end;

procedure TXMLPersistence.WriteDateTime(const Section, Key: string;
  Value: TDateTime);
begin
  inherited;
  WriteString(Section, Key, DateTimeToStr(Value));
end;

procedure TXMLPersistence.WriteFloat(const Section, Key: string; Value: double);
begin
  inherited;
  WriteString(Section, Key, FloatToStr(Value));
end;

procedure TXMLPersistence.WriteInteger(const Section, Key: string; Value: Integer);
begin
  WriteString(Section, Key, IntToStr(Value));
end;

procedure TXMLPersistence.WriteString(const Section, Key, Value: string);
var
  Node: IXMLNode;
begin
  Node := FTopNode.ChildNodes.FindNode(Section);
  if not Assigned(Node) then
   Node := FXML.DocumentElement.AddChild(Section);

  if Assigned(Node) then
   begin
    Node.Attributes[Key] := Value;
    FModified := True;
   end;
end;

end.

