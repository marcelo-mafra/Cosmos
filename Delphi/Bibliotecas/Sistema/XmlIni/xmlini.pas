{This code shows how to use TXMLDocument to save and restore configuration
settings in a XML document. The public methods works the same as a TIniFile.
There is not mutch comment in the code because it is self explaining
and small. Hope this benefit other persons. It is only tested in D7 pro.}

unit xmlini;

interface

uses
  SysUtils, Windows, XmlIntf, XMLDoc;

type
  TXmlIni = class
  private
    FModified: Boolean;
    FFileName: string;
    FXMLDoc: TXMLDocument;
    FBackup: Boolean;
    function GetVersion: string;
  public
    constructor Create(const FileName: string); overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure Save;
    function ReadString(const Section, Key, default: string): string;
    procedure WriteString(const Section, Key, Value: string);
    function ReadInteger(const Section, Key: string; default: Integer): Integer;
    procedure WriteInteger(const Section, Key: string; Value: Integer);
    function ReadBoolean(const Section, Key: string; default: Boolean): Boolean;
    procedure WriteBoolean(const Section, Key: string; Value: Boolean);
    property Backup: Boolean read FBackup write FBackup;
    property Version: string read GetVersion;
  end;

implementation

{ TXmlIni }

constructor TXmlIni.Create(const FileName: string);
begin
  inherited Create;
  FBackup         := True;
  FFileName       := FileName;
  FXMLDoc         := TXMLDocument.Create(nil);
  FXMLDoc.Options := [doNodeAutoIndent];
  if FileExists(FFileName) then
    FXMLDoc.LoadFromFile(FFileName)
  else 
  begin
    FXMLDoc.Active := True;
    FXMLDoc.AddChild('Configuration');
  end;
end;

constructor TXmlIni.Create;
begin
  Create('cfg.xml');
end;

destructor TXmlIni.Destroy;
begin
  Save;
  FXMLDoc.Destroy;
  inherited;
end;

function TXmlIni.GetVersion: string;
begin
  Result := '1.00';
end;

function TXmlIni.ReadBoolean(const Section, Key: string; default: Boolean): Boolean;
begin
  Result := Boolean(ReadInteger(Section, Key, Integer(default)));
end;

function TXmlIni.ReadInteger(const Section, Key: string; default: Integer): Integer;
begin
  Result := StrToInt(ReadString(Section, Key, IntToStr(default)));
end;

function TXmlIni.ReadString(const Section, Key, default: string): string;
var
  Node: IXMLNode;
begin
  Node := FXMLDoc.DocumentElement.ChildNodes.FindNode(Section);
  if Assigned(Node) and Node.HasAttribute(Key) then
    Result := Node.Attributes[Key]
  else
    Result := default;
end;

procedure TXmlIni.Save;
begin
  if not FModified then
    Exit;
  if FBackup then

    CopyFile(PChar(FFileName), PChar(FFileName + '.bak'), False);
  FXMLDoc.SaveToFile(FFileName);
  FModified := False;
end;

procedure TXmlIni.WriteBoolean(const Section, Key: string; Value: Boolean);
begin
  WriteInteger(Section, Key, Integer(Value));
end;

procedure TXmlIni.WriteInteger(const Section, Key: string; Value: Integer);
begin
  WriteString(Section, Key, IntToStr(Value));
end;

procedure TXmlIni.WriteString(const Section, Key, Value: string);
var
  Node: IXMLNode;
begin
  if ReadString(Section, Key, '') = Value then
    Exit;
  Node := FXMLDoc.DocumentElement.ChildNodes.FindNode(Section);
  if not Assigned(Node) then
    Node := FXMLDoc.DocumentElement.AddChild(Section);
  Node.Attributes[Key] := Value;
  FModified := True;
end;

end.