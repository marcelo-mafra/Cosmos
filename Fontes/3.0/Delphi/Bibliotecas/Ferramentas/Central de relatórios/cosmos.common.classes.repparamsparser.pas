
{*******************************************************************}
{                                                                   }
{                         XML Data Binding                          }
{                                                                   }
{         Generated on: 14/08/2011 09:27:43                         }
{       Generated from: C:\Users\Marcelo\Desktop\ReportParams.xml   }
{   Settings stored in: C:\Users\Marcelo\Desktop\ReportParams.xdb   }
{                                                                   }
{*******************************************************************}

unit cosmos.common.classes.repparamsparser;

interface

uses xmldom, XMLDoc, XMLIntf;

const
 //Nome do arquivo de definição de parâmetros e informações dos relatórios.
 sReportsFile = 'ReportsParams.xml'; //do not localize!

type

{ Forward Decls }

  IXMLReports = interface;
  IXMLReport = interface;
  IXMLReportInfos = interface;
  IXMLReportInfo = interface;
  IXMLReportParams = interface;
  IXMLReportParam = interface;

{ IXMLReports }

  IXMLReports = interface(IXMLNodeCollection)
    ['{84F682EF-F4E7-4339-80CD-2F052CC99081}']
    { Property Accessors }
    function Get_Report(Index: Integer): IXMLReport;
    { Methods & Properties }
    function Add: IXMLReport;
    function Insert(const Index: Integer): IXMLReport;
    property Report[Index: Integer]: IXMLReport read Get_Report; default;
  end;

{ IXMLReport }

  IXMLReport = interface(IXMLNode)
    ['{B21D6914-5A91-499E-9B60-30FCB94C1C77}']
    { Property Accessors }
    function Get_ReportInfo: IXMLReportInfos;
    function Get_Params: IXMLReportParams;
    { Methods & Properties }
    property ReportInfo: IXMLReportInfos read Get_ReportInfo;
    property Params: IXMLReportParams read Get_Params;
  end;

{ IXMLReportInfos }

  IXMLReportInfos = interface(IXMLNode)
    ['{268BB164-8C12-4834-8EF1-70219210E5A5}']
    { Property Accessors }
    function Get_Info: IXMLReportInfo;
    { Methods & Properties }
    property Info: IXMLReportInfo read Get_Info;
  end;

{ IXMLInfo }

  IXMLReportInfo = interface(IXMLNode)
    ['{AE832891-6EAC-40A4-93FF-E1BEE880E9D2}']
    { Property Accessors }
    function Get_ReportId: Integer;
    function Get_ReportName: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    function Get_ReportFile: UnicodeString;
    function Get_ReportTool: UnicodeString;
    function Get_ReportRoot: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_Enabled: Integer;
    procedure Set_ReportId(Value: Integer);
    procedure Set_ReportName(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_CosmosModule(Value: UnicodeString);
    procedure Set_ReportFile(Value: UnicodeString);
    procedure Set_ReportRoot(Value: UnicodeString);
    procedure Set_ReportTool(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Enabled(Value: Integer);
    { Methods & Properties }
    property ReportId: Integer read Get_ReportId write Set_ReportId;
    property ReportName: UnicodeString read Get_ReportName write Set_ReportName;
    property Description: UnicodeString read Get_Description write Set_Description;
    property CosmosModule: UnicodeString read Get_CosmosModule write Set_CosmosModule;
    property ReportFile: UnicodeString read Get_ReportFile write Set_ReportFile;
    property ReportTool: UnicodeString read Get_ReportTool write Set_ReportTool;
    property ReportRoot: UnicodeString read Get_ReportRoot write Set_ReportRoot;
    property Version: UnicodeString read Get_Version write Set_Version;
    property Enabled: Integer read Get_Enabled write Set_Enabled;
  end;

{ IXMLParams }

  IXMLReportParams = interface(IXMLNodeCollection)
    ['{8C1975D7-E5A6-4F98-8D99-D1D621FBA723}']
    { Property Accessors }
    function Get_Param(Index: Integer): IXMLReportParam;
    { Methods & Properties }
    function Add: IXMLReportParam;
    function Insert(const Index: Integer): IXMLReportParam;
    property Param[Index: Integer]: IXMLReportParam read Get_Param; default;
  end;

{ IXMLParam }

  IXMLReportParam = interface(IXMLNode)
    ['{60FBBE7B-B1D5-4754-A3FE-6EBF980A70DD}']
    { Property Accessors }
    function Get_ParamName: UnicodeString;
    function Get_ParamType: Integer;
    function Get_IsVisible: Integer;
    function Get_CanEdit: Integer;
    function Get_EditType: Integer;
    function Get_ParamMask: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_MaxLength: integer;
    function Get_HelpHint: UnicodeString;
    function Get_PickList: UnicodeString;
    function Get_ValueList: UnicodeString;
    function Get_Quoted: Integer;
    function Get_DefaultValue: UnicodeString;
    function Get_SendToServer: Integer;
    function Get_Order: Integer;
    function Get_ConvertTo: Integer;
    function Get_CaseMode: Integer;

    procedure Set_ParamName(Value: UnicodeString);
    procedure Set_ParamType(Value: Integer);
    procedure Set_IsVisible(Value: Integer);
    procedure Set_CanEdit(Value: Integer);
    procedure Set_EditType(Value: Integer);
    procedure Set_ParamMask(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_MaxLength(Value: integer);
    procedure Set_HelpHint(Value: UnicodeString);
    procedure Set_PickList(Value: UnicodeString);
    procedure Set_ValueList(Value: UnicodeString);
    procedure Set_Quoted(Value: integer);
    procedure Set_DefaultValue(Value: UnicodeString);
    procedure Set_SendToServer(Value: Integer);
    procedure Set_CaseMode(Value: Integer);
    procedure Set_ConvertTo(Value: Integer);
    procedure Set_Order(Value: Integer);

    { Methods & Properties }
    property ParamName: UnicodeString read Get_ParamName write Set_ParamName;
    property ParamType: Integer read Get_ParamType write Set_ParamType;
    property IsVisible: Integer read Get_IsVisible write Set_IsVisible;
    property CanEdit: Integer read Get_CanEdit write Set_CanEdit;
    property EditType: Integer read Get_EditType write Set_EditType;
    property ParamMask: UnicodeString read Get_ParamMask write Set_ParamMask;
    property Description: UnicodeString read Get_Description write Set_Description;
    property MaxLength: integer read Get_MaxLength write Set_MaxLength;
    property HelpHint: UnicodeString read Get_HelpHint write Set_HelpHint;
    property PickList: UnicodeString read Get_PickList write Set_PickList;
    property ValueList: UnicodeString read Get_ValueList write Set_ValueList;
    property Quoted: integer read Get_Quoted write Set_Quoted;
    property DefaultValue: UnicodeString read Get_DefaultValue write Set_DefaultValue;
    property SendToServer: Integer read Get_SendToServer write Set_SendToServer;
    property CaseMode: Integer read Get_CaseMode write Set_CaseMode;
    property ConvertTo: Integer read Get_ConvertTo write Set_ConvertTo;
    property Order: integer read Get_Order write Set_Order;
  end;

{ Forward Decls }

  TXMLReports = class;
  TXMLReport = class;
  TXMLReportInfos = class;
  TXMLReportInfo = class;
  TXMLReportParams = class;
  TXMLReportParam = class;

{ TXMLReports }

  TXMLReports = class(TXMLNodeCollection, IXMLReports)
  protected
    { IXMLReports }
    function Get_Report(Index: Integer): IXMLReport;
    function Add: IXMLReport;
    function Insert(const Index: Integer): IXMLReport;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLReport }

  TXMLReport = class(TXMLNode, IXMLReport)
  protected
    { IXMLReport }
    function Get_ReportInfo: IXMLReportInfos;
    function Get_Params: IXMLReportParams;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLReportInfos }

  TXMLReportInfos = class(TXMLNode, IXMLReportInfos)
  protected
    { IXMLReportInfos }
    function Get_Info: IXMLReportInfo;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfo }

  TXMLReportInfo = class(TXMLNode, IXMLReportInfo)
  protected
    { IXMLInfo }
    function Get_ReportId: Integer;
    function Get_ReportName: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_CosmosModule: UnicodeString;
    function Get_ReportFile: UnicodeString;
    function Get_ReportTool: UnicodeString;
    function Get_ReportRoot: UnicodeString;
    function Get_Version: UnicodeString;
    function Get_Enabled: Integer;
    procedure Set_ReportId(Value: Integer);
    procedure Set_ReportName(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_CosmosModule(Value: UnicodeString);
    procedure Set_ReportFile(Value: UnicodeString);
    procedure Set_ReportTool(Value: UnicodeString);
    procedure Set_ReportRoot(Value: UnicodeString);
    procedure Set_Version(Value: UnicodeString);
    procedure Set_Enabled(Value: Integer);

  end;

{ TXMLParams }

  TXMLReportParams = class(TXMLNodeCollection, IXMLReportParams)
  protected
    { IXMLParams }
    function Get_Param(Index: Integer): IXMLReportParam;
    function Add: IXMLReportParam;
    function Insert(const Index: Integer): IXMLReportParam;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLParam }

  TXMLReportParam = class(TXMLNode, IXMLReportParam)
  protected
    { IXMLParam }
    function Get_ParamName: UnicodeString;
    function Get_ParamType: Integer;
    function Get_IsVisible: Integer;
    function Get_CanEdit: Integer;
    function Get_EditType: Integer;
    function Get_ParamMask: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_MaxLength: integer;
    function Get_HelpHint: UnicodeString;
    function Get_PickList: UnicodeString;
    function Get_ValueList: UnicodeString;
    function Get_Quoted: integer;
    function Get_DefaultValue: UnicodeString;
    function Get_SendToServer: Integer;
    function Get_CaseMode: Integer;
    function Get_ConvertTo: Integer;
    function Get_Order: Integer;

    procedure Set_ParamName(Value: UnicodeString);
    procedure Set_ParamType(Value: Integer);
    procedure Set_IsVisible(Value: Integer);
    procedure Set_CanEdit(Value: Integer);
    procedure Set_EditType(Value: Integer);
    procedure Set_ParamMask(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_MaxLength(Value: integer);
    procedure Set_HelpHint(Value: UnicodeString);
    procedure Set_PickList(Value: UnicodeString);
    procedure Set_ValueList(Value: UnicodeString);
    procedure Set_Quoted(Value: Integer);
    procedure Set_DefaultValue(Value: UnicodeString);
    procedure Set_SendToServer(Value: Integer);
    procedure Set_CaseMode(Value: Integer);
    procedure Set_ConvertTo(Value: Integer);
    procedure Set_Order(Value: Integer);

  end;

{ Global Functions }

function GetReports(Doc: IXMLDocument): IXMLReports;
function LoadReports(const FileName: string): IXMLReports;
function NewReports: IXMLReports;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetReports(Doc: IXMLDocument): IXMLReports;
begin
  Result := Doc.GetDocBinding('Reports', TXMLReports, TargetNamespace) as IXMLReports;
end;

function LoadReports(const FileName: string): IXMLReports;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Reports', TXMLReports, TargetNamespace) as IXMLReports;
end;

function NewReports: IXMLReports;
begin
  Result := NewXMLDocument.GetDocBinding('Reports', TXMLReports, TargetNamespace) as IXMLReports;
end;

{ TXMLReports }

procedure TXMLReports.AfterConstruction;
begin
  RegisterChildNode('Report', TXMLReport);
  ItemTag := 'Report';
  ItemInterface := IXMLReport;
  inherited;
end;

function TXMLReports.Get_Report(Index: Integer): IXMLReport;
begin
  Result := List[Index] as IXMLReport;
end;

function TXMLReports.Add: IXMLReport;
begin
  Result := AddItem(-1) as IXMLReport;
end;

function TXMLReports.Insert(const Index: Integer): IXMLReport;
begin
  Result := AddItem(Index) as IXMLReport;
end;

{ TXMLReport }

procedure TXMLReport.AfterConstruction;
begin
  RegisterChildNode('ReportInfo', TXMLReportInfos);
  RegisterChildNode('Params', TXMLReportParams);
  inherited;
end;

function TXMLReport.Get_ReportInfo: IXMLReportInfos;
begin
  Result := ChildNodes['ReportInfo'] as IXMLReportInfos;
end;

function TXMLReport.Get_Params: IXMLReportParams;
begin
  Result := ChildNodes['Params'] as IXMLReportParams;
end;

{ TXMLReportInfos }

procedure TXMLReportInfos.AfterConstruction;
begin
  RegisterChildNode('Info', TXMLReportInfo);
  inherited;
end;

function TXMLReportInfos.Get_Info: IXMLReportInfo;
begin
  Result := ChildNodes['Info'] as IXMLReportInfo;
end;

{ TXMLInfo }

function TXMLReportInfo.Get_ReportFile: UnicodeString;
begin
  Result := AttributeNodes['ReportFile'].Text;
end;

function TXMLReportInfo.Get_ReportId: Integer;
begin
  Result := AttributeNodes['ReportId'].NodeValue;
end;

procedure TXMLReportInfo.Set_ReportFile(Value: UnicodeString);
begin
  SetAttribute('ReportFile', Value);
end;

procedure TXMLReportInfo.Set_ReportId(Value: Integer);
begin
  SetAttribute('ReportId', Value);
end;

function TXMLReportInfo.Get_ReportName: UnicodeString;
begin
  Result := AttributeNodes['ReportName'].Text;
end;

function TXMLReportInfo.Get_ReportRoot: UnicodeString;
begin
  Result := AttributeNodes['ReportRoot'].Text;
end;

function TXMLReportInfo.Get_ReportTool: UnicodeString;
begin
  Result := AttributeNodes['ReportTool'].Text;
end;

function TXMLReportInfo.Get_Version: UnicodeString;
begin
  Result := AttributeNodes['Version'].Text;
end;

procedure TXMLReportInfo.Set_ReportName(Value: UnicodeString);
begin
  SetAttribute('ReportName', Value);
end;

procedure TXMLReportInfo.Set_ReportRoot(Value: UnicodeString);
begin
  SetAttribute('ReportRoot', Value);
end;

procedure TXMLReportInfo.Set_ReportTool(Value: UnicodeString);
begin
  SetAttribute('ReportTool', Value);
end;

procedure TXMLReportInfo.Set_Version(Value: UnicodeString);
begin
  SetAttribute('Version', Value);
end;

function TXMLReportInfo.Get_CosmosModule: UnicodeString;
begin
  Result := AttributeNodes['CosmosModule'].Text;
end;

function TXMLReportInfo.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['Description'].Text;
end;

function TXMLReportInfo.Get_Enabled: Integer;
begin
  Result := AttributeNodes['Enabled'].NodeValue;
end;

procedure TXMLReportInfo.Set_CosmosModule(Value: UnicodeString);
begin
  SetAttribute('CosmosModule', Value);
end;

procedure TXMLReportInfo.Set_Description(Value: UnicodeString);
begin
  SetAttribute('Description', Value);
end;

procedure TXMLReportInfo.Set_Enabled(Value: Integer);
begin
  SetAttribute('Enabled', Value);
end;

{ TXMLParams }

procedure TXMLReportParams.AfterConstruction;
begin
  RegisterChildNode('Param', TXMLReportParam);
  ItemTag := 'Param';
  ItemInterface := IXMLReportParam;
  inherited;
end;

function TXMLReportParams.Get_Param(Index: Integer): IXMLReportParam;
begin
  Result := List[Index] as IXMLReportParam;
end;

function TXMLReportParams.Add: IXMLReportParam;
begin
  Result := AddItem(-1) as IXMLReportParam;
end;

function TXMLReportParams.Insert(const Index: Integer): IXMLReportParam;
begin
  Result := AddItem(Index) as IXMLReportParam;
end;

{ TXMLParam }

function TXMLReportParam.Get_ParamName: UnicodeString;
begin
  Result := AttributeNodes['ParamName'].Text;
end;

procedure TXMLReportParam.Set_ParamName(Value: UnicodeString);
begin
  SetAttribute('ParamName', Value);
end;

function TXMLReportParam.Get_ParamType: Integer;
begin
  Result := AttributeNodes['ParamType'].NodeValue;
end;

function TXMLReportParam.Get_PickList: UnicodeString;
begin
  Result := AttributeNodes['PickList'].NodeValue;
end;

function TXMLReportParam.Get_Quoted: integer;
begin
  Result := AttributeNodes['Quoted'].NodeValue;
end;

function TXMLReportParam.Get_SendToServer: Integer;
begin
  Result := AttributeNodes['SendToServer'].NodeValue;
end;

function TXMLReportParam.Get_ValueList: UnicodeString;
begin
  Result := AttributeNodes['ValueList'].NodeValue;
end;

procedure TXMLReportParam.Set_ParamType(Value: Integer);
begin
  SetAttribute('ParamType', Value);
end;

procedure TXMLReportParam.Set_PickList(Value: UnicodeString);
begin
  SetAttribute('PickList', Value);
end;

procedure TXMLReportParam.Set_Quoted(Value: Integer);
begin
  SetAttribute('Quoted', Value);
end;

procedure TXMLReportParam.Set_SendToServer(Value: Integer);
begin
  SetAttribute('SendToServer', Value);
end;

procedure TXMLReportParam.Set_ValueList(Value: UnicodeString);
begin
  SetAttribute('ValueList', Value);
end;

function TXMLReportParam.Get_IsVisible: Integer;
begin
  Result := AttributeNodes['IsVisible'].NodeValue;
end;

function TXMLReportParam.Get_MaxLength: integer;
begin
  Result := AttributeNodes['MaxLength'].NodeValue;
end;

function TXMLReportParam.Get_Order: Integer;
begin
  Result := AttributeNodes['Order'].NodeValue;
end;

procedure TXMLReportParam.Set_IsVisible(Value: Integer);
begin
  SetAttribute('IsVisible', Value);
end;

procedure TXMLReportParam.Set_MaxLength(Value: integer);
begin
  SetAttribute('MaxLength', Value);
end;

procedure TXMLReportParam.Set_Order(Value: Integer);
begin
  SetAttribute('Order', Value);
end;

function TXMLReportParam.Get_CanEdit: Integer;
begin
  Result := AttributeNodes['CanEdit'].NodeValue;
end;

procedure TXMLReportParam.Set_CanEdit(Value: Integer);
begin
  SetAttribute('CanEdit', Value);
end;

procedure TXMLReportParam.Set_CaseMode(Value: Integer);
begin
  SetAttribute('CaseMode', Value);
end;

procedure TXMLReportParam.Set_ConvertTo(Value: Integer);
begin
  SetAttribute('ConvertTo', Value);
end;

function TXMLReportParam.Get_EditType: Integer;
begin
  Result := AttributeNodes['EditType'].NodeValue;
end;

function TXMLReportParam.Get_HelpHint: UnicodeString;
begin
  Result := AttributeNodes['HelpHint'].Text;
end;

procedure TXMLReportParam.Set_EditType(Value: Integer);
begin
  SetAttribute('EditType', Value);
end;

procedure TXMLReportParam.Set_HelpHint(Value: UnicodeString);
begin
  SetAttribute('HelpHint', Value);
end;

function TXMLReportParam.Get_ParamMask: UnicodeString;
begin
  Result := AttributeNodes['ParamMask'].Text;
end;

procedure TXMLReportParam.Set_ParamMask(Value: UnicodeString);
begin
  SetAttribute('ParamMask', Value);
end;

function TXMLReportParam.Get_CaseMode: Integer;
begin
  Result := AttributeNodes['CaseMode'].NodeValue;
end;

function TXMLReportParam.Get_ConvertTo: Integer;
begin
  Result := AttributeNodes['ConvertTo'].NodeValue;
end;

function TXMLReportParam.Get_DefaultValue: UnicodeString;
begin
  Result := AttributeNodes['DefaultValue'].Text;
end;

function TXMLReportParam.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['Description'].Text;
end;

procedure TXMLReportParam.Set_DefaultValue(Value: UnicodeString);
begin
  SetAttribute('DefaultValue', Value);
end;

procedure TXMLReportParam.Set_Description(Value: UnicodeString);
begin
  SetAttribute('Description', Value);
end;

end.