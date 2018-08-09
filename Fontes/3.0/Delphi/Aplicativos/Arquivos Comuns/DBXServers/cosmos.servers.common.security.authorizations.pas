
{*********************************************************************************************}
{                                                                                             }
{                                      XML Data Binding                                       }
{                                                                                             }
{         Generated on: 16/10/2013 22:31:12                                                   }
{       Generated from: D:\Marcelo\Projeto Cosmos\Fontes\3.0\Bin\Win32\RolesPermissions.xml   }
{                                                                                             }
{*********************************************************************************************}

unit cosmos.servers.common.security.authorizations;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  IXMLAuthorizationsType = interface;
  IXMLMethodsType = interface;
  IXMLMethodInfoType = interface;
  IXMLFeaturesType = interface;
  IXMLFeatureInfoType = interface;

{ IXMLAuthorizationsType }

  IXMLAuthorizationsType = interface(IXMLNode)
    ['{E275D215-9CB0-48BE-8E76-921C3FD01D22}']
    { Property Accessors }
    function Get_Methods: IXMLMethodsType;
    function Get_Features: IXMLFeaturesType;
    { Methods & Properties }
    property Methods: IXMLMethodsType read Get_Methods;
    property Features: IXMLFeaturesType read Get_Features;
  end;

{ IXMLMethodsType }

  IXMLMethodsType = interface(IXMLNodeCollection)
    ['{E1C0BE1B-25FE-4E6F-93AB-75D477E0FFEF}']
    { Property Accessors }
    function Get_MethodInfo(Index: Integer): IXMLMethodInfoType;
    { Methods & Properties }
    function Add: IXMLMethodInfoType;
    function Insert(const Index: Integer): IXMLMethodInfoType;
    property MethodInfo[Index: Integer]: IXMLMethodInfoType read Get_MethodInfo; default;
  end;

{ IXMLMethodInfoType }

  IXMLMethodInfoType = interface(IXMLNode)
    ['{CEB913B4-340E-434C-8AEB-755CCE5D8549}']
    { Property Accessors }
    function Get_MethodName: UnicodeString;
    function Get_AuthorizedRoles: UnicodeString;
    function Get_DeniedRoles: UnicodeString;
    function Get_Exclude: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    procedure Set_MethodName(Value: UnicodeString);
    procedure Set_AuthorizedRoles(Value: UnicodeString);
    procedure Set_DeniedRoles(Value: UnicodeString);
    procedure Set_Exclude(Value: UnicodeString);
    procedure Set_CosmosModule(Value: UnicodeString);
    { Methods & Properties }
    property MethodName: UnicodeString read Get_MethodName write Set_MethodName;
    property AuthorizedRoles: UnicodeString read Get_AuthorizedRoles write Set_AuthorizedRoles;
    property DeniedRoles: UnicodeString read Get_DeniedRoles write Set_DeniedRoles;
    property Exclude: UnicodeString read Get_Exclude write Set_Exclude;
    property CosmosModule: UnicodeString read Get_CosmosModule write Set_CosmosModule;
  end;

{ IXMLFeaturesType }

  IXMLFeaturesType = interface(IXMLNodeCollection)
    ['{AE5F3629-E8CD-4B3F-8865-C78586D38D9C}']
    { Property Accessors }
    function Get_FeatureInfo(Index: Integer): IXMLFeatureInfoType;
    { Methods & Properties }
    function Add: IXMLFeatureInfoType;
    function Insert(const Index: Integer): IXMLFeatureInfoType;
    property FeatureInfo[Index: Integer]: IXMLFeatureInfoType read Get_FeatureInfo; default;
  end;

{ IXMLFeatureInfoType }

  IXMLFeatureInfoType = interface(IXMLNode)
    ['{333EE221-5B9A-4335-AB7F-98C6E08D1F70}']
    { Property Accessors }
    function Get_FeatureId: Integer;
    function Get_FeatureName: UnicodeString;
    function Get_Group: UnicodeString;
    function Get_AuthorizedRoles: UnicodeString;
    function Get_PrivilegedUsers: UnicodeString;
    function Get_Common: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    procedure Set_FeatureId(Value: Integer);
    procedure Set_FeatureName(Value: UnicodeString);
    procedure Set_Group(Value: UnicodeString);
    procedure Set_AuthorizedRoles(Value: UnicodeString);
    procedure Set_PrivilegedUsers(Value: UnicodeString);
    procedure Set_Common(Value: UnicodeString);
    procedure Set_CosmosModule(Value: UnicodeString);
    { Methods & Properties }
    property FeatureId: Integer read Get_FeatureId write Set_FeatureId;
    property FeatureName: UnicodeString read Get_FeatureName write Set_FeatureName;
    property Group: UnicodeString read Get_Group write Set_Group;
    property AuthorizedRoles: UnicodeString read Get_AuthorizedRoles write Set_AuthorizedRoles;
    property PrivilegedUsers: UnicodeString read Get_PrivilegedUsers write Set_PrivilegedUsers;
    property Common: UnicodeString read Get_Common write Set_Common;
    property CosmosModule: UnicodeString read Get_CosmosModule write Set_CosmosModule;
  end;

{ Forward Decls }

  TXMLAuthorizationsType = class;
  TXMLMethodsType = class;
  TXMLMethodInfoType = class;
  TXMLFeaturesType = class;
  TXMLFeatureInfoType = class;

{ TXMLAuthorizationsType }

  TXMLAuthorizationsType = class(TXMLNode, IXMLAuthorizationsType)
  protected
    { IXMLAuthorizationsType }
    function Get_Methods: IXMLMethodsType;
    function Get_Features: IXMLFeaturesType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMethodsType }

  TXMLMethodsType = class(TXMLNodeCollection, IXMLMethodsType)
  protected
    { IXMLMethodsType }
    function Get_MethodInfo(Index: Integer): IXMLMethodInfoType;
    function Add: IXMLMethodInfoType;
    function Insert(const Index: Integer): IXMLMethodInfoType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMethodInfoType }

  TXMLMethodInfoType = class(TXMLNode, IXMLMethodInfoType)
  protected
    { IXMLMethodInfoType }
    function Get_MethodName: UnicodeString;
    function Get_AuthorizedRoles: UnicodeString;
    function Get_DeniedRoles: UnicodeString;
    function Get_Exclude: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    procedure Set_MethodName(Value: UnicodeString);
    procedure Set_AuthorizedRoles(Value: UnicodeString);
    procedure Set_DeniedRoles(Value: UnicodeString);
    procedure Set_Exclude(Value: UnicodeString);
    procedure Set_CosmosModule(Value: UnicodeString);
  end;

{ TXMLFeaturesType }

  TXMLFeaturesType = class(TXMLNodeCollection, IXMLFeaturesType)
  protected
    { IXMLFeaturesType }
    function Get_FeatureInfo(Index: Integer): IXMLFeatureInfoType;
    function Add: IXMLFeatureInfoType;
    function Insert(const Index: Integer): IXMLFeatureInfoType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFeatureInfoType }

  TXMLFeatureInfoType = class(TXMLNode, IXMLFeatureInfoType)
  protected
    { IXMLFeatureInfoType }
    function Get_FeatureId: Integer;
    function Get_FeatureName: UnicodeString;
    function Get_Group: UnicodeString;
    function Get_AuthorizedRoles: UnicodeString;
    function Get_PrivilegedUsers: UnicodeString;
    function Get_Common: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    procedure Set_FeatureId(Value: Integer);
    procedure Set_FeatureName(Value: UnicodeString);
    procedure Set_Group(Value: UnicodeString);
    procedure Set_AuthorizedRoles(Value: UnicodeString);
    procedure Set_PrivilegedUsers(Value: UnicodeString);
    procedure Set_Common(Value: UnicodeString);
    procedure Set_CosmosModule(Value: UnicodeString);
  end;

{ Global Functions }

function GetAuthorizations(Doc: IXMLDocument): IXMLAuthorizationsType;
function LoadAuthorizations(const FileName: string): IXMLAuthorizationsType;
function NewAuthorizations: IXMLAuthorizationsType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetAuthorizations(Doc: IXMLDocument): IXMLAuthorizationsType;
begin
  Result := Doc.GetDocBinding('Authorizations', TXMLAuthorizationsType, TargetNamespace) as IXMLAuthorizationsType;
end;

function LoadAuthorizations(const FileName: string): IXMLAuthorizationsType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Authorizations', TXMLAuthorizationsType, TargetNamespace) as IXMLAuthorizationsType;
end;

function NewAuthorizations: IXMLAuthorizationsType;
begin
  Result := NewXMLDocument.GetDocBinding('Authorizations', TXMLAuthorizationsType, TargetNamespace) as IXMLAuthorizationsType;
end;

{ TXMLAuthorizationsType }

procedure TXMLAuthorizationsType.AfterConstruction;
begin
  RegisterChildNode('Methods', TXMLMethodsType);
  RegisterChildNode('Features', TXMLFeaturesType);
  inherited;
end;

function TXMLAuthorizationsType.Get_Methods: IXMLMethodsType;
begin
  Result := ChildNodes['Methods'] as IXMLMethodsType;
end;

function TXMLAuthorizationsType.Get_Features: IXMLFeaturesType;
begin
  Result := ChildNodes['Features'] as IXMLFeaturesType;
end;

{ TXMLMethodsType }

procedure TXMLMethodsType.AfterConstruction;
begin
  RegisterChildNode('MethodInfo', TXMLMethodInfoType);
  ItemTag := 'MethodInfo';
  ItemInterface := IXMLMethodInfoType;
  inherited;
end;

function TXMLMethodsType.Get_MethodInfo(Index: Integer): IXMLMethodInfoType;
begin
  Result := List[Index] as IXMLMethodInfoType;
end;

function TXMLMethodsType.Add: IXMLMethodInfoType;
begin
  Result := AddItem(-1) as IXMLMethodInfoType;
end;

function TXMLMethodsType.Insert(const Index: Integer): IXMLMethodInfoType;
begin
  Result := AddItem(Index) as IXMLMethodInfoType;
end;

{ TXMLMethodInfoType }

function TXMLMethodInfoType.Get_MethodName: UnicodeString;
begin
  Result := AttributeNodes['MethodName'].Text;
end;

procedure TXMLMethodInfoType.Set_MethodName(Value: UnicodeString);
begin
  SetAttribute('MethodName', Value);
end;

function TXMLMethodInfoType.Get_AuthorizedRoles: UnicodeString;
begin
  Result := AttributeNodes['AuthorizedRoles'].Text;
end;

procedure TXMLMethodInfoType.Set_AuthorizedRoles(Value: UnicodeString);
begin
  SetAttribute('AuthorizedRoles', Value);
end;

function TXMLMethodInfoType.Get_DeniedRoles: UnicodeString;
begin
  Result := AttributeNodes['DeniedRoles'].Text;
end;

procedure TXMLMethodInfoType.Set_DeniedRoles(Value: UnicodeString);
begin
  SetAttribute('DeniedRoles', Value);
end;

function TXMLMethodInfoType.Get_Exclude: UnicodeString;
begin
  Result := AttributeNodes['Exclude'].Text;
end;

procedure TXMLMethodInfoType.Set_Exclude(Value: UnicodeString);
begin
  SetAttribute('Exclude', Value);
end;

function TXMLMethodInfoType.Get_CosmosModule: UnicodeString;
begin
  Result := AttributeNodes['CosmosModule'].Text;
end;

procedure TXMLMethodInfoType.Set_CosmosModule(Value: UnicodeString);
begin
  SetAttribute('CosmosModule', Value);
end;

{ TXMLFeaturesType }

procedure TXMLFeaturesType.AfterConstruction;
begin
  RegisterChildNode('FeatureInfo', TXMLFeatureInfoType);
  ItemTag := 'FeatureInfo';
  ItemInterface := IXMLFeatureInfoType;
  inherited;
end;

function TXMLFeaturesType.Get_FeatureInfo(Index: Integer): IXMLFeatureInfoType;
begin
  Result := List[Index] as IXMLFeatureInfoType;
end;

function TXMLFeaturesType.Add: IXMLFeatureInfoType;
begin
  Result := AddItem(-1) as IXMLFeatureInfoType;
end;

function TXMLFeaturesType.Insert(const Index: Integer): IXMLFeatureInfoType;
begin
  Result := AddItem(Index) as IXMLFeatureInfoType;
end;

{ TXMLFeatureInfoType }

function TXMLFeatureInfoType.Get_FeatureId: Integer;
begin
  Result := AttributeNodes['FeatureId'].NodeValue;
end;

procedure TXMLFeatureInfoType.Set_FeatureId(Value: Integer);
begin
  SetAttribute('FeatureId', Value);
end;

function TXMLFeatureInfoType.Get_FeatureName: UnicodeString;
begin
  Result := AttributeNodes['FeatureName'].Text;
end;

procedure TXMLFeatureInfoType.Set_FeatureName(Value: UnicodeString);
begin
  SetAttribute('FeatureName', Value);
end;

function TXMLFeatureInfoType.Get_Group: UnicodeString;
begin
  Result := AttributeNodes['Group'].Text;
end;

function TXMLFeatureInfoType.Get_PrivilegedUsers: UnicodeString;
begin
  Result := AttributeNodes['PrivilegedUsers'].Text;
end;

procedure TXMLFeatureInfoType.Set_Group(Value: UnicodeString);
begin
  SetAttribute('Group', Value);
end;

procedure TXMLFeatureInfoType.Set_PrivilegedUsers(Value: UnicodeString);
begin
  SetAttribute('PrivilegedUsers', Value);
end;

function TXMLFeatureInfoType.Get_AuthorizedRoles: UnicodeString;
begin
  Result := AttributeNodes['AuthorizedRoles'].Text;
end;

procedure TXMLFeatureInfoType.Set_AuthorizedRoles(Value: UnicodeString);
begin
  SetAttribute('AuthorizedRoles', Value);
end;

function TXMLFeatureInfoType.Get_Common: UnicodeString;
begin
  Result := AttributeNodes['Common'].Text;
end;

function TXMLFeatureInfoType.Get_CosmosModule: UnicodeString;
begin
  Result := AttributeNodes['CosmosModule'].Text;
end;

procedure TXMLFeatureInfoType.Set_Common(Value: UnicodeString);
begin
  SetAttribute('Common', Value);
end;

procedure TXMLFeatureInfoType.Set_CosmosModule(Value: UnicodeString);
begin
  SetAttribute('CosmosModule', Value);
end;

end.
