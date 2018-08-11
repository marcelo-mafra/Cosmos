
{***********************************************************************************}
{                                                                                   }
{                                 XML Data Binding                                  }
{                                                                                   }
{         Generated on: 18/11/2012 16:01:41                                         }
{       Generated from: D:\Marcelo\Projeto Cosmos\Fontes\Bin\CentralPesquisas.xml   }
{   Settings stored in: D:\Marcelo\Projeto Cosmos\Fontes\Bin\CentralPesquisas.xdb   }
{                                                                                   }
{***********************************************************************************}

unit cosmos.core.classes.searchsinfo;

interface

uses xmldom, XMLDoc, XMLIntf, Variants;

type

{ Forward Decls }

  IXMLSearchsType = interface;
  IXMLSearchType = interface;
  IXMLSearchInfoType = interface;
  IXMLInfoType = interface;
  IXMLParamsType = interface;
  IXMLParamType = interface;

{ IXMLSearchsType }

  IXMLSearchsType = interface(IXMLNodeCollection)
    ['{B0D1C2B8-5FAA-4D23-99D7-ADD72A8486E0}']
    { Property Accessors }
    function Get_UpdatedAt: TDateTime;
    function Get_Total: Integer;
    function Get_Search(Index: Integer): IXMLSearchType;
    { Methods & Properties }
    function Add: IXMLSearchType;
    function Insert(const Index: Integer): IXMLSearchType;
    property UpdatedAt: TDateTime read Get_UpdatedAt;
    property Total: Integer read Get_Total;
    property Search[Index: Integer]: IXMLSearchType read Get_Search; default;
  end;

{ IXMLSearchType }

  IXMLSearchType = interface(IXMLNode)
    ['{81D2AF9A-DA4F-492A-ADD7-AF1F63E8F3CD}']
    { Property Accessors }
    function Get_SearchInfo: IXMLSearchInfoType;
    function Get_Params: IXMLParamsType;
    { Methods & Properties }
    property SearchInfo: IXMLSearchInfoType read Get_SearchInfo;
    property Params: IXMLParamsType read Get_Params;
  end;

{ IXMLSearchInfoType }

  IXMLSearchInfoType = interface(IXMLNode)
    ['{E480C9FF-8370-43CD-8E44-A04EF2A6187C}']
    { Property Accessors }
    function Get_Info: IXMLInfoType;
    { Methods & Properties }
    property Info: IXMLInfoType read Get_Info;
  end;

{ IXMLInfoType }

  IXMLInfoType = interface(IXMLNode)
    ['{DAA90FB2-7733-41F6-A686-078A6CBA9354}']
    { Property Accessors }
    function Get_SearchId: Integer;
    function Get_SearchName: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    function Get_Category: UnicodeString;
    function Get_SearchDescription: UnicodeString;
    function Get_ExecutedBy: UnicodeString;
    function Get_Command: UnicodeString;
    function Get_Enabled: Boolean;
    { Methods & Properties }
    property SearchId: Integer read Get_SearchId;
    property SearchName: UnicodeString read Get_SearchName;
    property CosmosModule: UnicodeString read Get_CosmosModule;
    property Category: UnicodeString read Get_Category;
    property SearchDescription: UnicodeString read Get_SearchDescription;
    property ExecutedBy: UnicodeString read Get_ExecutedBy;
    property Command: UnicodeString read Get_Command;
    property Enabled: Boolean read Get_Enabled;
  end;

{ IXMLParamsType }

  IXMLParamsType = interface(IXMLNodeCollection)
    ['{7638113F-AC70-4A78-A9D7-61A8B3F97F96}']
    { Property Accessors }
    function Get_Param(Index: Integer): IXMLParamType;
    { Methods & Properties }
    function Add: IXMLParamType;
    function Insert(const Index: Integer): IXMLParamType;
    property Param[Index: Integer]: IXMLParamType read Get_Param; default;
  end;

{ IXMLParamType }

  IXMLParamType = interface(IXMLNode)
    ['{891B1670-1F05-4E04-8186-E574BB3952F9}']
    { Property Accessors }
    function Get_ParamName: UnicodeString;
    function Get_ParamType: Integer;
    function Get_IsVisible: Boolean;
    function Get_CanEdit: Boolean;
    function Get_EditType: Integer;
    function Get_ParamMask: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_MaxLength: Integer;
    function Get_DefaultValue: UnicodeString;
    function Get_HelpHint: UnicodeString;
    function Get_SendToServer: Boolean;
    function Get_PickList: UnicodeString;
    function Get_ValueList: UnicodeString;
    function Get_Quoted: Boolean;
    function Get_CaseMode: Integer;
    function Get_ConvertTo: Integer;
    function Get_Order: Integer;
    { Methods & Properties }
    property ParamName: UnicodeString read Get_ParamName;
    property ParamType: Integer read Get_ParamType;
    property IsVisible: Boolean read Get_IsVisible;
    property CanEdit: Boolean read Get_CanEdit;
    property EditType: Integer read Get_EditType;
    property ParamMask: UnicodeString read Get_ParamMask;
    property Description: UnicodeString read Get_Description;
    property MaxLength: Integer read Get_MaxLength;
    property DefaultValue: UnicodeString read Get_DefaultValue;
    property HelpHint: UnicodeString read Get_HelpHint;
    property SendToServer: Boolean read Get_SendToServer;
    property PickList: UnicodeString read Get_PickList;
    property ValueList: UnicodeString read Get_ValueList;
    property Quoted: Boolean read Get_Quoted;
    property CaseMode: Integer read Get_CaseMode;
    property ConvertTo: Integer read Get_ConvertTo;
    property Order: Integer read Get_Order;
  end;

{ Forward Decls }

  TXMLSearchsType = class;
  TXMLSearchType = class;
  TXMLSearchInfoType = class;
  TXMLInfoType = class;
  TXMLParamsType = class;
  TXMLParamType = class;

{ TXMLSearchsType }

  TXMLSearchsType = class(TXMLNodeCollection, IXMLSearchsType)
  protected
    { IXMLSearchsType }
    function Get_UpdatedAt: TDateTime;
    function Get_Total: Integer;
    function Get_Search(Index: Integer): IXMLSearchType;
    function Add: IXMLSearchType;
    function Insert(const Index: Integer): IXMLSearchType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSearchType }

  TXMLSearchType = class(TXMLNode, IXMLSearchType)
  protected
    { IXMLSearchType }
    function Get_SearchInfo: IXMLSearchInfoType;
    function Get_Params: IXMLParamsType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSearchInfoType }

  TXMLSearchInfoType = class(TXMLNode, IXMLSearchInfoType)
  protected
    { IXMLSearchInfoType }
    function Get_Info: IXMLInfoType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfoType }

  TXMLInfoType = class(TXMLNode, IXMLInfoType)
  protected
    { IXMLInfoType }
    function Get_SearchId: Integer;
    function Get_SearchName: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    function Get_Category: UnicodeString;
    function Get_SearchDescription: UnicodeString;
    function Get_ExecutedBy: UnicodeString;
    function Get_Command: UnicodeString;
    function Get_Enabled: Boolean;
  end;

{ TXMLParamsType }

  TXMLParamsType = class(TXMLNodeCollection, IXMLParamsType)
  protected
    { IXMLParamsType }
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
    function Get_CanEdit: Boolean;
    function Get_EditType: Integer;
    function Get_ParamMask: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_MaxLength: Integer;
    function Get_DefaultValue: UnicodeString;
    function Get_HelpHint: UnicodeString;
    function Get_SendToServer: Boolean;
    function Get_PickList: UnicodeString;
    function Get_ValueList: UnicodeString;
    function Get_Quoted: Boolean;
    function Get_CaseMode: Integer;
    function Get_ConvertTo: Integer;
    function Get_Order: Integer;
  end;

{ Global Functions }

function GetSearchs(Doc: IXMLDocument): IXMLSearchsType;
function LoadSearchs(const FileName: string): IXMLSearchsType;
function LoadSearchsData(const XMLData: DOMString): IXMLSearchsType;
function NewSearchs: IXMLSearchsType;

const
  TargetNamespace = '';

implementation

function GetSearchs(Doc: IXMLDocument): IXMLSearchsType;
begin
  Result := Doc.GetDocBinding('Searchs', TXMLSearchsType, TargetNamespace) as IXMLSearchsType;
end;

function LoadSearchs(const FileName: string): IXMLSearchsType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Searchs', TXMLSearchsType, TargetNamespace) as IXMLSearchsType;
end;

function LoadSearchsData(const XMLData: DOMString): IXMLSearchsType;
begin
 Result := LoadXMLData(XMLData) as IXMLSearchsType;
end;

function NewSearchs: IXMLSearchsType;
begin
  Result := NewXMLDocument.GetDocBinding('Searchs', TXMLSearchsType, TargetNamespace) as IXMLSearchsType;
end;


{ TXMLSearchsType }

procedure TXMLSearchsType.AfterConstruction;
begin
  RegisterChildNode('Search', TXMLSearchType);
  ItemTag := 'Search';
  ItemInterface := IXMLSearchType;
  inherited;
end;

function TXMLSearchsType.Get_UpdatedAt: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['UpdatedAt'].NodeValue);
end;

function TXMLSearchsType.Get_Total: Integer;
begin
  Result := AttributeNodes['Total'].NodeValue;
end;

function TXMLSearchsType.Get_Search(Index: Integer): IXMLSearchType;
begin
  Result := List[Index] as IXMLSearchType;
end;

function TXMLSearchsType.Add: IXMLSearchType;
begin
  Result := AddItem(-1) as IXMLSearchType;
end;

function TXMLSearchsType.Insert(const Index: Integer): IXMLSearchType;
begin
  Result := AddItem(Index) as IXMLSearchType;
end;

{ TXMLSearchType }

procedure TXMLSearchType.AfterConstruction;
begin
  RegisterChildNode('SearchInfo', TXMLSearchInfoType);
  RegisterChildNode('Params', TXMLParamsType);
  inherited;
end;

function TXMLSearchType.Get_SearchInfo: IXMLSearchInfoType;
begin
  Result := ChildNodes['SearchInfo'] as IXMLSearchInfoType;
end;

function TXMLSearchType.Get_Params: IXMLParamsType;
begin
  Result := ChildNodes['Params'] as IXMLParamsType;
end;

{ TXMLSearchInfoType }

procedure TXMLSearchInfoType.AfterConstruction;
begin
  RegisterChildNode('Info', TXMLInfoType);
  inherited;
end;

function TXMLSearchInfoType.Get_Info: IXMLInfoType;
begin
  Result := ChildNodes['Info'] as IXMLInfoType;
end;

{ TXMLInfoType }

function TXMLInfoType.Get_SearchId: Integer;
begin
  Result := AttributeNodes['SearchId'].NodeValue;
end;

function TXMLInfoType.Get_SearchName: UnicodeString;
begin
  Result := AttributeNodes['SearchName'].Text;
end;

function TXMLInfoType.Get_Command: UnicodeString;
begin
  Result := AttributeNodes['Command'].Text;
end;

function TXMLInfoType.Get_CosmosModule: UnicodeString;
begin
  Result := AttributeNodes['CosmosModule'].Text;
end;

function TXMLInfoType.Get_Category: UnicodeString;
begin
  Result := AttributeNodes['Category'].Text;
end;

function TXMLInfoType.Get_SearchDescription: UnicodeString;
begin
  Result := AttributeNodes['SearchDescription'].Text;
end;

function TXMLInfoType.Get_ExecutedBy: UnicodeString;
begin
  Result := AttributeNodes['ExecutedBy'].Text;
end;

function TXMLInfoType.Get_Enabled: Boolean;
begin
  Result := AttributeNodes['Enabled'].NodeValue;
end;

{ TXMLParamsType }

procedure TXMLParamsType.AfterConstruction;
begin
  RegisterChildNode('Param', TXMLParamType);
  ItemTag := 'Param';
  ItemInterface := IXMLParamType;
  inherited;
end;

function TXMLParamsType.Get_Param(Index: Integer): IXMLParamType;
begin
  Result := List[Index] as IXMLParamType;
end;

function TXMLParamsType.Add: IXMLParamType;
begin
  Result := AddItem(-1) as IXMLParamType;
end;

function TXMLParamsType.Insert(const Index: Integer): IXMLParamType;
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

function TXMLParamType.Get_CanEdit: Boolean;
begin
  Result := AttributeNodes['CanEdit'].NodeValue;
end;

function TXMLParamType.Get_EditType: Integer;
begin
  Result := AttributeNodes['EditType'].NodeValue;
end;

function TXMLParamType.Get_ParamMask: UnicodeString;
begin
  Result := AttributeNodes['ParamMask'].Text;
end;

function TXMLParamType.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['Description'].Text;
end;

function TXMLParamType.Get_MaxLength: Integer;
begin
  Result := AttributeNodes['MaxLength'].NodeValue;
end;

function TXMLParamType.Get_DefaultValue: UnicodeString;
begin
  Result := AttributeNodes['DefaultValue'].Text;
end;

function TXMLParamType.Get_HelpHint: UnicodeString;
begin
  Result := AttributeNodes['HelpHint'].Text;
end;

function TXMLParamType.Get_SendToServer: Boolean;
begin
  Result := AttributeNodes['SendToServer'].NodeValue;
end;

function TXMLParamType.Get_PickList: UnicodeString;
begin
  Result := AttributeNodes['PickList'].Text;
end;

function TXMLParamType.Get_ValueList: UnicodeString;
begin
  Result := AttributeNodes['ValueList'].Text;
end;

function TXMLParamType.Get_Quoted: Boolean;
begin
  Result := AttributeNodes['Quoted'].NodeValue;
end;

function TXMLParamType.Get_CaseMode: Integer;
begin
  Result := AttributeNodes['CaseMode'].NodeValue;
end;

function TXMLParamType.Get_ConvertTo: Integer;
begin
  Result := AttributeNodes['ConvertTo'].NodeValue;
end;

function TXMLParamType.Get_Order: Integer;
begin
  Result := AttributeNodes['Order'].NodeValue;
end;

end.




