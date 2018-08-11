
{*****************************************************************}
{                                                                 }
{                        XML Data Binding                         }
{                                                                 }
{         Generated on: 24/09/2011 18:51:01                       }
{       Generated from: FieldsInfo.xml                            }
{                                                                 }
{*****************************************************************}

unit cosmos.core.classes.FieldsInfo;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLFieldsInfoType = interface;
  IXMLInfoType = interface;
  IXMLFieldType = interface;

{ IXMLFieldsInfoType }

  IXMLFieldsInfoType = interface(IXMLNode)
    ['{F42E4497-FAB3-4DBD-ABB8-B8B3FFE2A814}']
    { Property Accessors }
    function Get_Info: IXMLInfoType;
    { Methods & Properties }
    property Info: IXMLInfoType read Get_Info;
  end;

{ IXMLInfoType }

  IXMLInfoType = interface(IXMLNodeCollection)
    ['{AFF9747D-AA86-4B15-8E8E-AD5644D4F845}']
    { Property Accessors }
    function Get_Field(Index: Integer): IXMLFieldType;
    { Methods & Properties }
    function Add: IXMLFieldType;
    function Insert(const Index: Integer): IXMLFieldType;
    property Field[Index: Integer]: IXMLFieldType read Get_Field; default;
  end;

{ IXMLFieldType }

  IXMLFieldType = interface(IXMLNode)
    ['{79003560-746B-4545-ACC0-BDB95038607D}']
    { Property Accessors }
    function Get_Alignment: Integer;
    function Get_FieldName: UnicodeString;
    function Get_DisplayLabel: UnicodeString;
    function Get_IsVisible: Boolean;
    function Get_FieldMask: UnicodeString;
    function Get_FieldType: integer;
    function Get_DisplayWidth: Integer;
    { Methods & Properties }
    property Alignment: Integer read Get_Alignment;
    property FieldName: UnicodeString read Get_FieldName;
    property DisplayLabel: UnicodeString read Get_DisplayLabel;
    property IsVisible: Boolean read Get_IsVisible;
    property FieldMask: UnicodeString read Get_FieldMask;
    property FieldType: integer read Get_FieldType;
    property DisplayWidth: Integer read Get_DisplayWidth;

  end;

{ Forward Decls }

  TXMLFieldsInfoType = class;
  TXMLInfoType = class;
  TXMLFieldType = class;

{ TXMLFieldsInfoType }

  TXMLFieldsInfoType = class(TXMLNode, IXMLFieldsInfoType)
  protected
    { IXMLFieldsInfoType }
    function Get_Info: IXMLInfoType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfoType }

  TXMLInfoType = class(TXMLNodeCollection, IXMLInfoType)
  protected
    { IXMLInfoType }
    function Get_Field(Index: Integer): IXMLFieldType;
    function Add: IXMLFieldType;
    function Insert(const Index: Integer): IXMLFieldType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFieldType }

  TXMLFieldType = class(TXMLNode, IXMLFieldType)
  protected
    { IXMLFieldType }
    function Get_Alignment: Integer;
    function Get_FieldName: UnicodeString;
    function Get_DisplayLabel: UnicodeString;
    function Get_IsVisible: Boolean;
    function Get_FieldMask: UnicodeString;
    function Get_FieldType: Integer;
    function Get_DisplayWidth: Integer;
  end;

{ Global Functions }

function GetFieldsInfo(Doc: IXMLDocument): IXMLFieldsInfoType;
function LoadFieldsInfo(const FileName: string): IXMLFieldsInfoType;
function NewFieldsInfo: IXMLFieldsInfoType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetFieldsInfo(Doc: IXMLDocument): IXMLFieldsInfoType;
begin
  Result := Doc.GetDocBinding('FieldsInfo', TXMLFieldsInfoType, TargetNamespace) as IXMLFieldsInfoType;
end;

function LoadFieldsInfo(const FileName: string): IXMLFieldsInfoType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('FieldsInfo', TXMLFieldsInfoType, TargetNamespace) as IXMLFieldsInfoType;
end;

function NewFieldsInfo: IXMLFieldsInfoType;
begin
  Result := NewXMLDocument.GetDocBinding('FieldsInfo', TXMLFieldsInfoType, TargetNamespace) as IXMLFieldsInfoType;
end;

{ TXMLFieldsInfoType }

procedure TXMLFieldsInfoType.AfterConstruction;
begin
  RegisterChildNode('Info', TXMLInfoType);
  inherited;
end;

function TXMLFieldsInfoType.Get_Info: IXMLInfoType;
begin
  Result := ChildNodes['Info'] as IXMLInfoType;
end;

{ TXMLInfoType }

procedure TXMLInfoType.AfterConstruction;
begin
  RegisterChildNode('Field', TXMLFieldType);
  ItemTag := 'Field';
  ItemInterface := IXMLFieldType;
  inherited;
end;

function TXMLInfoType.Get_Field(Index: Integer): IXMLFieldType;
begin
  Result := List[Index] as IXMLFieldType;
end;

function TXMLInfoType.Add: IXMLFieldType;
begin
  Result := AddItem(-1) as IXMLFieldType;
end;

function TXMLInfoType.Insert(const Index: Integer): IXMLFieldType;
begin
  Result := AddItem(Index) as IXMLFieldType;
end;

{ TXMLFieldType }

function TXMLFieldType.Get_FieldName: UnicodeString;
begin
  Result := AttributeNodes['FieldName'].Text;
end;

function TXMLFieldType.Get_FieldType: Integer;
begin
  Result := AttributeNodes['FieldType'].NodeValue;
end;

function TXMLFieldType.Get_Alignment: Integer;
begin
  Result := AttributeNodes['Alignment'].NodeValue;
end;

function TXMLFieldType.Get_DisplayLabel: UnicodeString;
begin
  Result := AttributeNodes['DisplayLabel'].Text;
end;

function TXMLFieldType.Get_IsVisible: Boolean;
begin
  Result := AttributeNodes['IsVisible'].NodeValue;
end;

function TXMLFieldType.Get_FieldMask: UnicodeString;
begin
  Result := AttributeNodes['FieldMask'].Text;
end;

function TXMLFieldType.Get_DisplayWidth: Integer;
begin
  Result := AttributeNodes['DisplayWidth'].NodeValue;
end;

end.