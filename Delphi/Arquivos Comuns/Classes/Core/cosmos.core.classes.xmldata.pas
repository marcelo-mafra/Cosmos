
{**********************************************}
{                                              }
{               XML Data Binding               }
{                                              }
{         Generated on: 19/09/2011 22:18:43    }
{                                              }
{**********************************************}

unit cosmos.core.classes.xmldata;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLCosmosData = interface;
  IXMLCosmosDataFields = interface;
  IXMLCosmosDataField = interface;

{ IXMLCosmosData }

  IXMLCosmosData = interface(IXMLNode)
    ['{7C6F05AA-532E-4B30-A328-AE257A30E705}']
    { Property Accessors }
    function Get_Fields: IXMLCosmosDataFields;
    { Methods & Properties }
    property Fields: IXMLCosmosDataFields read Get_Fields;
  end;

{ IXMLCosmosDataFields }

  IXMLCosmosDataFields = interface(IXMLNodeCollection)
    ['{9698FCCC-5D2A-48BF-9F72-74B5726209E7}']
    { Property Accessors }
    function Get_Field(Index: Integer): IXMLCosmosDataField;
    { Methods & Properties }
    function Add: IXMLCosmosDataField;
    function Insert(const Index: Integer): IXMLCosmosDataField;
    property Field[Index: Integer]: IXMLCosmosDataField read Get_Field; default;
  end;

{ IXMLCosmosDataField }

  IXMLCosmosDataField = interface(IXMLNode)
    ['{E05EC3A9-A947-4883-A843-BBADF83622B7}']
    { Property Accessors }
    function Get_FieldIndex: Integer;
    function Get_FieldName: UnicodeString;
    function Get_FieldValue: UnicodeString;
    procedure Set_FieldIndex(Value: Integer);
    procedure Set_FieldName(Value: UnicodeString);
    procedure Set_FieldValue(Value: UnicodeString);
    { Methods & Properties }
    property FieldIndex: Integer read Get_FieldIndex write Set_FieldIndex;
    property FieldName: UnicodeString read Get_FieldName write Set_FieldName;
    property FieldValue: UnicodeString read Get_FieldValue write Set_FieldValue;
  end;

{ Forward Decls }

  TXMLCosmosData = class;
  TXMLCosmosDataFields = class;
  TXMLCosmosDataField = class;

{ TXMLCosmosData }

  TXMLCosmosData = class(TXMLNode, IXMLCosmosData)
  protected
    { IXMLCosmosData }
    function Get_Fields: IXMLCosmosDataFields;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCosmosDataFields }

  TXMLCosmosDataFields = class(TXMLNodeCollection, IXMLCosmosDataFields)
  protected
    { IXMLCosmosDataFields }
    function Get_Field(Index: Integer): IXMLCosmosDataField;
    function Add: IXMLCosmosDataField;
    function Insert(const Index: Integer): IXMLCosmosDataField;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCosmosDataField }

  TXMLCosmosDataField = class(TXMLNode, IXMLCosmosDataField)
  protected
    { IXMLCosmosDataField }
    function Get_FieldIndex: Integer;
    function Get_FieldName: UnicodeString;
    function Get_FieldValue: UnicodeString;
    procedure Set_FieldIndex(Value: Integer);
    procedure Set_FieldName(Value: UnicodeString);
    procedure Set_FieldValue(Value: UnicodeString);
  end;

{ Global Functions }

function GetCosmosData(Doc: IXMLDocument): IXMLCosmosData;
function LoadCosmosData(const FileName: string): IXMLCosmosData;
function LoadXMLCosmosData(const XML: string): IXMLCosmosData;
function NewCosmosData: IXMLCosmosData;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetCosmosData(Doc: IXMLDocument): IXMLCosmosData;
begin
  Result := Doc.GetDocBinding('CosmosData', TXMLCosmosData, TargetNamespace) as IXMLCosmosData;
end;

function LoadCosmosData(const FileName: string): IXMLCosmosData;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('CosmosData', TXMLCosmosData, TargetNamespace) as IXMLCosmosData;
end;

function LoadXMLCosmosData(const XML: string): IXMLCosmosData;
begin
  Result := LoadXMLData(XML).GetDocBinding('CosmosData', TXMLCosmosData, TargetNamespace) as IXMLCosmosData;
end;

function NewCosmosData: IXMLCosmosData;
begin
  Result := NewXMLDocument.GetDocBinding('CosmosData', TXMLCosmosData, TargetNamespace) as IXMLCosmosData;
end;

{ TXMLCosmosData }

procedure TXMLCosmosData.AfterConstruction;
begin
  RegisterChildNode('Fields', TXMLCosmosDataFields);
  inherited;
end;

function TXMLCosmosData.Get_Fields: IXMLCosmosDataFields;
begin
  Result := ChildNodes['Fields'] as IXMLCosmosDataFields;
end;

{ TXMLCosmosDataFields }

procedure TXMLCosmosDataFields.AfterConstruction;
begin
  RegisterChildNode('Field', TXMLCosmosDataField);
  ItemTag := 'Field';
  ItemInterface := IXMLCosmosDataField;
  inherited;
end;

function TXMLCosmosDataFields.Get_Field(Index: Integer): IXMLCosmosDataField;
begin
  Result := List[Index] as IXMLCosmosDataField;
end;

function TXMLCosmosDataFields.Add: IXMLCosmosDataField;
begin
  Result := AddItem(-1) as IXMLCosmosDataField;
end;

function TXMLCosmosDataFields.Insert(const Index: Integer): IXMLCosmosDataField;
begin
  Result := AddItem(Index) as IXMLCosmosDataField;
end;

{ TXMLCosmosDataField }

function TXMLCosmosDataField.Get_FieldIndex: Integer;
begin
  Result := AttributeNodes['FieldIndex'].NodeValue;
end;

procedure TXMLCosmosDataField.Set_FieldIndex(Value: Integer);
begin
  SetAttribute('FieldIndex', Value);
end;

function TXMLCosmosDataField.Get_FieldName: UnicodeString;
begin
  Result := AttributeNodes['FieldName'].Text;
end;

procedure TXMLCosmosDataField.Set_FieldName(Value: UnicodeString);
begin
  SetAttribute('FieldName', Value);
end;

function TXMLCosmosDataField.Get_FieldValue: UnicodeString;
begin
  Result := AttributeNodes['FieldValue'].Text;
end;

procedure TXMLCosmosDataField.Set_FieldValue(Value: UnicodeString);
begin
  SetAttribute('FieldValue', Value);
end;

end.