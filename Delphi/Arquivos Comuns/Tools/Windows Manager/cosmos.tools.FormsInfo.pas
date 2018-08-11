
{*****************************************************************}
{                                                                 }
{                        XML Data Binding                         }
{                                                                 }
{         Generated on: 04/11/2012 23:30:00                       }
{       Generated from: FormsInfo.xml                            }
{                                                                 }
{*****************************************************************}

unit cosmos.tools.FormsInfo;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLFormsInfoType = interface;
  IXMLInfoType = interface;
  IXMLFormType = interface;

{ IXMLFormsInfoType }

  IXMLFormsInfoType = interface(IXMLNode)
    ['{B806E376-3A22-489C-9C9C-5ACB1D66C97C}']
    { Property Accessors }
    function Get_Info: IXMLInfoType;
    { Methods & Properties }
    property Info: IXMLInfoType read Get_Info;
  end;

{ IXMLInfoType }

  IXMLInfoType = interface(IXMLNodeCollection)
    ['{D4F0BBAC-76AE-4AB9-94A8-387CA2E2AF20}']
    { Property Accessors }
    function Get_Form(Index: Integer): IXMLFormType;
    { Methods & Properties }
    function Add: IXMLFormType;
    function Insert(const Index: Integer): IXMLFormType;
    property Form[Index: Integer]: IXMLFormType read Get_Form; default;
  end;

{ IXMLFormType }



  IXMLFormType = interface(IXMLNode)
    ['{39D0AB8C-68CC-4F16-9661-E624F4485072}']
    { Property Accessors }
    function Get_Docked: Boolean;
    function Get_FormClassName: UnicodeString;
    function Get_Height: Integer;
    function Get_Position: Integer;
    function Get_LeftPosition: Integer;
    function Get_Width: Integer;

    procedure Set_Docked(Value: Boolean);
    procedure Set_FormClassName(Value: UnicodeString);
    procedure Set_Height(Value: Integer);
    procedure Set_Position(Value: Integer);
    procedure Set_LeftPosition(Value: integer);
    procedure Set_Width(Value: Integer);

    { Methods & Properties }
    property Docked: Boolean read Get_Docked write Set_Docked;
    property FormClassName: UnicodeString read Get_FormClassName write Set_FormClassName;
    property Height: Integer read Get_Height write Set_Height;
    property LeftPosition: Integer read Get_LeftPosition write Set_LeftPosition;
    property Position: Integer read Get_Position write Set_Position;
    property Width: Integer read Get_Width write Set_Width;
  end;

{ Forward Decls }

  TXMLFormsInfoType = class;
  TXMLInfoType = class;
  TXMLFormType = class;

{ TXMLFormsInfoType }

  TXMLFormsInfoType = class(TXMLNode, IXMLFormsInfoType)
  protected
    { IXMLFormsInfoType }
    function Get_Info: IXMLInfoType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfoType }

  TXMLInfoType = class(TXMLNodeCollection, IXMLInfoType)
  protected
    { IXMLInfoType }
    function Get_Form(Index: Integer): IXMLFormType;
    function Add: IXMLFormType;
    function Insert(const Index: Integer): IXMLFormType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFormType }

  TXMLFormType = class(TXMLNode, IXMLFormType)
  protected
    { IXMLFormType }
    function Get_Docked: Boolean;
    function Get_FormClassName: UnicodeString;
    function Get_Height: Integer;
    function Get_LeftPosition: Integer;
    function Get_Position: Integer;
    function Get_Width: Integer;

    procedure Set_Docked(Value: Boolean);
    procedure Set_FormClassName(Value: UnicodeString);
    procedure Set_Height(Value: Integer);
    procedure Set_LeftPosition(Value: integer);
    procedure Set_Position(Value: Integer);
    procedure Set_Width(Value: Integer);


  end;

{ Global Functions }

function GetFormsInfo(Doc: IXMLDocument): IXMLFormsInfoType;
function LoadFormsInfo(const FileName: string): IXMLFormsInfoType;
function NewFormsInfo: IXMLFormsInfoType;


const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetFormsInfo(Doc: IXMLDocument): IXMLFormsInfoType;
begin
  Result := Doc.GetDocBinding('FormsInfo', TXMLFormsInfoType, TargetNamespace) as IXMLFormsInfoType;
end;

function LoadFormsInfo(const FileName: string): IXMLFormsInfoType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('FormsInfo', TXMLFormsInfoType, TargetNamespace) as IXMLFormsInfoType;
  Result.OwnerDocument.Options :=   Result.OwnerDocument.Options + [doNodeAutoIndent];
  Result.OwnerDocument.Encoding := 'UTF-8'; //do not localize!
end;

function NewFormsInfo: IXMLFormsInfoType;
begin
  Result := NewXMLDocument.GetDocBinding('FormsInfo', TXMLFormsInfoType, TargetNamespace) as IXMLFormsInfoType;
  Result.OwnerDocument.Options :=   Result.OwnerDocument.Options + [doNodeAutoIndent];
  Result.OwnerDocument.NodeIndentStr := #13;
  Result.OwnerDocument.Encoding := 'UTF-8'; //do not localize!
end;


{ TXMLFieldsInfoType }

procedure TXMLFormsInfoType.AfterConstruction;
begin
  RegisterChildNode('Info', TXMLInfoType);
  inherited;
end;

function TXMLFormsInfoType.Get_Info: IXMLInfoType;
begin
  Result := ChildNodes['Info'] as IXMLInfoType;
end;

{ TXMLInfoType }

procedure TXMLInfoType.AfterConstruction;
begin
  RegisterChildNode('Form', TXMLFormType);
  ItemTag := 'Form';
  ItemInterface := IXMLFormType;
  inherited;
end;

function TXMLInfoType.Get_Form(Index: Integer): IXMLFormType;
begin
  Result := List[Index] as IXMLFormType;
end;

function TXMLInfoType.Add: IXMLFormType;
begin
  Result := AddItem(-1) as IXMLFormType;
end;

function TXMLInfoType.Insert(const Index: Integer): IXMLFormType;
begin
  Result := AddItem(Index) as IXMLFormType;
end;

{ TXMLFieldType }

function TXMLFormType.Get_FormClassName: UnicodeString;
begin
  Result := AttributeNodes['FormClassName'].Text;
end;

function TXMLFormType.Get_Width: Integer;
begin
  Result := AttributeNodes['Width'].NodeValue;
end;

procedure TXMLFormType.Set_Docked(Value: Boolean);
begin
 AttributeNodes['Docked'].NodeValue := Value;
end;

procedure TXMLFormType.Set_FormClassName(Value: UnicodeString);
begin
 AttributeNodes['FormClassName'].Text := Value;
end;

procedure TXMLFormType.Set_Height(Value: Integer);
begin
 AttributeNodes['Height'].NodeValue := Value;
end;

procedure TXMLFormType.Set_LeftPosition(Value: integer);
begin
 AttributeNodes['LeftPosition'].NodeValue := Value;
end;

procedure TXMLFormType.Set_Position(Value: Integer);
begin
 AttributeNodes['Position'].NodeValue := Value;
end;

procedure TXMLFormType.Set_Width(Value: Integer);
begin
  AttributeNodes['Width'].NodeValue := Value;
end;

function TXMLFormType.Get_Docked: Boolean;
begin
  Result := AttributeNodes['Docked'].NodeValue;
end;

function TXMLFormType.Get_Height: Integer;
begin
  Result := AttributeNodes['Height'].NodeValue;
end;

function TXMLFormType.Get_LeftPosition: Integer;
begin
  Result := AttributeNodes['LeftPosition'].NodeValue;
end;

function TXMLFormType.Get_Position: Integer;
begin
  Result := AttributeNodes['Position'].NodeValue;
end;


end.