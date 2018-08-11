
{******************************************************************************************}
{                                                                                          }
{                                     XML Data Binding                                     }
{                                                                                          }
{         Generated on: 06/08/2014 14:06:23                                                }
{       Generated from: D:\Marcelo\Projeto Cosmos\Fontes\3.0\Bin\Win32\AddressLabels.xml   }
{                                                                                          }
{******************************************************************************************}

unit cosmos.core.classes.labelsinfo;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLLabelsType = interface;
  IXMLLabelType = interface;
  IXMLLabelInfoType = interface;
  IXMLInfoType = interface;
  IXMLPageInfoType = interface;
  IXMLParamType = interface;
  IXMLLinesInfoType = interface;
  IXMLLineType = interface;

{ IXMLLabelsType }

  IXMLLabelsType = interface(IXMLNodeCollection)
    ['{48FF7944-E853-4515-885E-917DFE05E473}']
    { Property Accessors }
    function Get_Label_(Index: Integer): IXMLLabelType;
    { Methods & Properties }
    function Add: IXMLLabelType;
    function Insert(const Index: Integer): IXMLLabelType;
    property Label_[Index: Integer]: IXMLLabelType read Get_Label_; default;
  end;

{ IXMLLabelType }

  IXMLLabelType = interface(IXMLNode)
    ['{9C6AFE0E-FAB6-41D1-BABC-B0E9559176E8}']
    { Property Accessors }
    function Get_LabelInfo: IXMLLabelInfoType;
    function Get_PageInfo: IXMLPageInfoType;
    function Get_LinesInfo: IXMLLinesInfoType;
    { Methods & Properties }
    property LabelInfo: IXMLLabelInfoType read Get_LabelInfo;
    property PageInfo: IXMLPageInfoType read Get_PageInfo;
    property LinesInfo: IXMLLinesInfoType read Get_LinesInfo;
  end;

{ IXMLLabelInfoType }

  IXMLLabelInfoType = interface(IXMLNode)
    ['{6AFE613C-842A-48A5-A6E1-ACA4BCB599CB}']
    { Property Accessors }
    function Get_Info: IXMLInfoType;
    { Methods & Properties }
    property Info: IXMLInfoType read Get_Info;
  end;

{ IXMLInfoType }

  IXMLInfoType = interface(IXMLNode)
    ['{F8B95ECD-4C77-4DF0-AD3A-593B1EE801F5}']
    { Property Accessors }
    function Get_LabelId: Integer;
    function Get_LabelName: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_Category: UnicodeString;
    function Get_ReportFile: UnicodeString;
    function Get_Enabled: Boolean;
    { Methods & Properties }
    property LabelId: Integer read Get_LabelId;
    property LabelName: UnicodeString read Get_LabelName;
    property Description: UnicodeString read Get_Description;
    property Category: UnicodeString read Get_Category;
    property ReportFile: UnicodeString read Get_ReportFile;
    property Enabled: Boolean read Get_Enabled;
  end;

{ IXMLPageInfoType }

  IXMLPageInfoType = interface(IXMLNodeCollection)
    ['{D315D121-094B-48D3-99E1-ED09C8A2E837}']
    { Property Accessors }
    function Get_Param(Index: Integer): IXMLParamType;
    { Methods & Properties }
    function Add: IXMLParamType;
    function Insert(const Index: Integer): IXMLParamType;
    property Param[Index: Integer]: IXMLParamType read Get_Param; default;
  end;

{ IXMLParamType }

  IXMLParamType = interface(IXMLNode)
    ['{70053B1D-A756-41A4-95AC-0E6B1311B046}']
    { Property Accessors }
    function Get_ParamName: UnicodeString;
    function Get_ParamType: Integer;
    function Get_IsVisible: Boolean;
    function Get_Description: UnicodeString;
    function Get_HelpHint: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_ConvertTo: UnicodeString;
    function Get_Order: Integer;
    { Methods & Properties }
    property ParamName: UnicodeString read Get_ParamName;
    property ParamType: Integer read Get_ParamType;
    property IsVisible: Boolean read Get_IsVisible;
    property Description: UnicodeString read Get_Description;
    property HelpHint: UnicodeString read Get_HelpHint;
    property Value: UnicodeString read Get_Value;
    property ConvertTo: UnicodeString read Get_ConvertTo;
    property Order: Integer read Get_Order;
  end;

{ IXMLLinesInfoType }

  IXMLLinesInfoType = interface(IXMLNodeCollection)
    ['{7E3FBC74-77D1-459A-8B77-5A13CD026610}']
    { Property Accessors }
    function Get_Line(Index: Integer): IXMLLineType;
    { Methods & Properties }
    function Add: IXMLLineType;
    function Insert(const Index: Integer): IXMLLineType;
    property Line[Index: Integer]: IXMLLineType read Get_Line; default;
  end;

{ IXMLLineType }

  IXMLLineType = interface(IXMLNode)
    ['{1366B7AC-A7BD-4D31-A66F-BBAC78F46116}']
    { Property Accessors }
    function Get_LineName: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_MaxLength: Integer;
    function Get_DefaultValue: UnicodeString;
    function Get_HelpHint: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_Order: Integer;
    { Methods & Properties }
    property LineName: UnicodeString read Get_LineName;
    property Description: UnicodeString read Get_Description;
    property MaxLength: Integer read Get_MaxLength;
    property DefaultValue: UnicodeString read Get_DefaultValue;
    property HelpHint: UnicodeString read Get_HelpHint;
    property Value: UnicodeString read Get_Value;
    property Order: Integer read Get_Order;
  end;

{ Forward Decls }

  TXMLLabelsType = class;
  TXMLLabelType = class;
  TXMLLabelInfoType = class;
  TXMLInfoType = class;
  TXMLPageInfoType = class;
  TXMLParamType = class;
  TXMLLinesInfoType = class;
  TXMLLineType = class;

{ TXMLLabelsType }

  TXMLLabelsType = class(TXMLNodeCollection, IXMLLabelsType)
  protected
    { IXMLLabelsType }
    function Get_Label_(Index: Integer): IXMLLabelType;
    function Add: IXMLLabelType;
    function Insert(const Index: Integer): IXMLLabelType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLabelType }

  TXMLLabelType = class(TXMLNode, IXMLLabelType)
  protected
    { IXMLLabelType }
    function Get_LabelInfo: IXMLLabelInfoType;
    function Get_PageInfo: IXMLPageInfoType;
    function Get_LinesInfo: IXMLLinesInfoType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLabelInfoType }

  TXMLLabelInfoType = class(TXMLNode, IXMLLabelInfoType)
  protected
    { IXMLLabelInfoType }
    function Get_Info: IXMLInfoType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfoType }

  TXMLInfoType = class(TXMLNode, IXMLInfoType)
  protected
    { IXMLInfoType }
    function Get_LabelId: Integer;
    function Get_LabelName: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_Category: UnicodeString;
    function Get_ReportFile: UnicodeString;
    function Get_Enabled: Boolean;
  end;

{ TXMLPageInfoType }

  TXMLPageInfoType = class(TXMLNodeCollection, IXMLPageInfoType)
  protected
    { IXMLPageInfoType }
    function Get_Param(Index: Integer): IXMLParamType;
    function Add: IXMLParamType;
    function Insert(const Index: Integer): IXMLParamType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLParamType }

  TXMLParamType = class(TXMLNode, IXMLParamType)
  protected
    { IXMLParamType }
    function Get_ParamName: UnicodeString;
    function Get_ParamType: Integer;
    function Get_IsVisible: Boolean;
    function Get_Description: UnicodeString;
    function Get_HelpHint: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_ConvertTo: UnicodeString;
    function Get_Order: Integer;
  end;

{ TXMLLinesInfoType }

  TXMLLinesInfoType = class(TXMLNodeCollection, IXMLLinesInfoType)
  protected
    { IXMLLinesInfoType }
    function Get_Line(Index: Integer): IXMLLineType;
    function Add: IXMLLineType;
    function Insert(const Index: Integer): IXMLLineType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLineType }

  TXMLLineType = class(TXMLNode, IXMLLineType)
  protected
    { IXMLLineType }
    function Get_LineName: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_MaxLength: Integer;
    function Get_DefaultValue: UnicodeString;
    function Get_HelpHint: UnicodeString;
    function Get_Value: UnicodeString;
    function Get_Order: Integer;
  end;

{ Global Functions }

function GetLabels(Doc: IXMLDocument): IXMLLabelsType;
function LoadLabels(const FileName: string): IXMLLabelsType;
function NewLabels: IXMLLabelsType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetLabels(Doc: IXMLDocument): IXMLLabelsType;
begin
  Result := Doc.GetDocBinding('Labels', TXMLLabelsType, TargetNamespace) as IXMLLabelsType;
end;

function LoadLabels(const FileName: string): IXMLLabelsType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Labels', TXMLLabelsType, TargetNamespace) as IXMLLabelsType;
end;

function NewLabels: IXMLLabelsType;
begin
  Result := NewXMLDocument.GetDocBinding('Labels', TXMLLabelsType, TargetNamespace) as IXMLLabelsType;
end;

{ TXMLLabelsType }

procedure TXMLLabelsType.AfterConstruction;
begin
  RegisterChildNode('Label', TXMLLabelType);
  ItemTag := 'Label';
  ItemInterface := IXMLLabelType;
  inherited;
end;

function TXMLLabelsType.Get_Label_(Index: Integer): IXMLLabelType;
begin
  Result := List[Index] as IXMLLabelType;
end;

function TXMLLabelsType.Add: IXMLLabelType;
begin
  Result := AddItem(-1) as IXMLLabelType;
end;

function TXMLLabelsType.Insert(const Index: Integer): IXMLLabelType;
begin
  Result := AddItem(Index) as IXMLLabelType;
end;

{ TXMLLabelType }

procedure TXMLLabelType.AfterConstruction;
begin
  RegisterChildNode('LabelInfo', TXMLLabelInfoType);
  RegisterChildNode('PageInfo', TXMLPageInfoType);
  RegisterChildNode('LinesInfo', TXMLLinesInfoType);
  inherited;
end;

function TXMLLabelType.Get_LabelInfo: IXMLLabelInfoType;
begin
  Result := ChildNodes['LabelInfo'] as IXMLLabelInfoType;
end;

function TXMLLabelType.Get_PageInfo: IXMLPageInfoType;
begin
  Result := ChildNodes['PageInfo'] as IXMLPageInfoType;
end;

function TXMLLabelType.Get_LinesInfo: IXMLLinesInfoType;
begin
  Result := ChildNodes['LinesInfo'] as IXMLLinesInfoType;
end;

{ TXMLLabelInfoType }

procedure TXMLLabelInfoType.AfterConstruction;
begin
  RegisterChildNode('Info', TXMLInfoType);
  inherited;
end;

function TXMLLabelInfoType.Get_Info: IXMLInfoType;
begin
  Result := ChildNodes['Info'] as IXMLInfoType;
end;

{ TXMLInfoType }

function TXMLInfoType.Get_LabelId: Integer;
begin
  Result := AttributeNodes['LabelId'].NodeValue;
end;

function TXMLInfoType.Get_LabelName: UnicodeString;
begin
  Result := AttributeNodes['LabelName'].Text;
end;

function TXMLInfoType.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['Description'].Text;
end;

function TXMLInfoType.Get_Category: UnicodeString;
begin
  Result := AttributeNodes['Category'].Text;
end;

function TXMLInfoType.Get_ReportFile: UnicodeString;
begin
  Result := AttributeNodes['ReportFile'].Text;
end;

function TXMLInfoType.Get_Enabled: Boolean;
begin
  Result := AttributeNodes['Enabled'].NodeValue;
end;

{ TXMLPageInfoType }

procedure TXMLPageInfoType.AfterConstruction;
begin
  RegisterChildNode('Param', TXMLParamType);
  ItemTag := 'Param';
  ItemInterface := IXMLParamType;
  inherited;
end;

function TXMLPageInfoType.Get_Param(Index: Integer): IXMLParamType;
begin
  Result := List[Index] as IXMLParamType;
end;

function TXMLPageInfoType.Add: IXMLParamType;
begin
  Result := AddItem(-1) as IXMLParamType;
end;

function TXMLPageInfoType.Insert(const Index: Integer): IXMLParamType;
begin
  Result := AddItem(Index) as IXMLParamType;
end;

{ TXMLParamType }

function TXMLParamType.Get_ParamName: UnicodeString;
begin
  Result := AttributeNodes['ParamName'].Text;
end;

function TXMLParamType.Get_ParamType: Integer;
begin
  Result := AttributeNodes['ParamType'].NodeValue;
end;

function TXMLParamType.Get_IsVisible: Boolean;
begin
  Result := AttributeNodes['IsVisible'].NodeValue;
end;

function TXMLParamType.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['Description'].Text;
end;

function TXMLParamType.Get_HelpHint: UnicodeString;
begin
  Result := AttributeNodes['HelpHint'].Text;
end;

function TXMLParamType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['Value'].Text;
end;

function TXMLParamType.Get_ConvertTo: UnicodeString;
begin
  Result := AttributeNodes['ConvertTo'].Text;
end;

function TXMLParamType.Get_Order: Integer;
begin
  Result := AttributeNodes['Order'].NodeValue;
end;

{ TXMLLinesInfoType }

procedure TXMLLinesInfoType.AfterConstruction;
begin
  RegisterChildNode('Line', TXMLLineType);
  ItemTag := 'Line';
  ItemInterface := IXMLLineType;
  inherited;
end;

function TXMLLinesInfoType.Get_Line(Index: Integer): IXMLLineType;
begin
  Result := List[Index] as IXMLLineType;
end;

function TXMLLinesInfoType.Add: IXMLLineType;
begin
  Result := AddItem(-1) as IXMLLineType;
end;

function TXMLLinesInfoType.Insert(const Index: Integer): IXMLLineType;
begin
  Result := AddItem(Index) as IXMLLineType;
end;

{ TXMLLineType }

function TXMLLineType.Get_LineName: UnicodeString;
begin
  Result := AttributeNodes['LineName'].Text;
end;

function TXMLLineType.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['Description'].Text;
end;

function TXMLLineType.Get_MaxLength: Integer;
begin
  Result := AttributeNodes['MaxLength'].NodeValue;
end;

function TXMLLineType.Get_DefaultValue: UnicodeString;
begin
  Result := AttributeNodes['DefaultValue'].Text;
end;

function TXMLLineType.Get_HelpHint: UnicodeString;
begin
  Result := AttributeNodes['HelpHint'].Text;
end;

function TXMLLineType.Get_Value: UnicodeString;
begin
  Result := AttributeNodes['Value'].Text;
end;

function TXMLLineType.Get_Order: Integer;
begin
  Result := AttributeNodes['Order'].NodeValue;
end;

end.