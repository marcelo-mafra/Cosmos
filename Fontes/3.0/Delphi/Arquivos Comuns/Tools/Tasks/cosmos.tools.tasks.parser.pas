
{********************************************************************************}
{                                                                                }
{                                XML Data Binding                                }
{                                                                                }
{         Generated on: 13/09/2011 23:16:12                                      }
{       Generated from: tasksfile.xml   }
{                                                                                }
{********************************************************************************}

unit cosmos.tools.tasks.parser;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf, System.Variants;

type

{ Forward Decls }

  IXMLTasksFile = interface;
  IXMLTasks = interface;
  IXMLTask = interface;

{ IXMLTasksFileType }

  IXMLTasksFile = interface(IXMLNode)
    ['{145DD650-8720-414F-9026-12D1720F4B31}']
    { Property Accessors }
    function Get_FileName: UnicodeString;
    function Get_CreateDate: TDateTime;
    function Get_UpdateDate: TDateTime;
    function Get_Owner: UnicodeString;
    function Get_Tasks: IXMLTasks;
    procedure Set_FileName(Value: UnicodeString);
    procedure Set_CreateDate(Value: TDateTime);
    procedure Set_UpdateDate(Value: TDateTime);
    procedure Set_Owner(Value: UnicodeString);
    { Methods & Properties }
    property FileName: UnicodeString read Get_FileName write Set_FileName;
    property CreateDate: TDateTime read Get_CreateDate write Set_CreateDate;
    property UpdateDate: TDateTime read Get_UpdateDate write Set_UpdateDate;
    property Owner: UnicodeString read Get_Owner write Set_Owner;
    property Tasks: IXMLTasks read Get_Tasks;
  end;

{ IXMLTasksType }

  IXMLTasks = interface(IXMLNodeCollection)
    ['{D1B9E398-E380-46FA-A7FB-9D7034DEA9E7}']
    { Property Accessors }
    function Get_Task(Index: Integer): IXMLTask;
    { Methods & Properties }
    function Add: IXMLTask;
    function Insert(const Index: Integer): IXMLTask;
    property Task[Index: Integer]: IXMLTask read Get_Task; default;
  end;

{ IXMLTaskType }

  IXMLTask = interface(IXMLNode)
    ['{6E95F67E-FB80-4122-95B9-7085D2096E5D}']
    { Property Accessors }
    function Get_Description: UnicodeString;
    function Get_Creator: UnicodeString;
    function Get_CreateDate: TDateTime;
    function Get_TargetDate: Variant;
    function Get_Status: UnicodeString;
    function Get_Category: UnicodeString;
    function Get_Priority: UnicodeString;
    function Get_EndDate: Variant;
    function Get_CosmosSystem: UnicodeString;
    function Get_Notes: UnicodeString;
    function Get_Order: Integer;
    function Get_TaskIndex: UnicodeString;
    procedure Set_Description(Value: UnicodeString);
    procedure Set_Creator(Value: UnicodeString);
    procedure Set_CreateDate(Value: TDateTime);
    procedure Set_TargetDate(Value: Variant);
    procedure Set_Status(Value: UnicodeString);
    procedure Set_Category(Value: UnicodeString);
    procedure Set_Priority(Value: UnicodeString);
    procedure Set_EndDate(Value: Variant);
    procedure Set_CosmosSystem(Value: UnicodeString);
    procedure Set_Notes(Value: UnicodeString);
    procedure Set_Order(Value: Integer);
    procedure Set_TaskIndex(Value: UnicodeString);
    { Methods & Properties }
    property Description: UnicodeString read Get_Description write Set_Description;
    property Creator: UnicodeString read Get_Creator write Set_Creator;
    property CreateDate: TDateTime read Get_CreateDate write Set_CreateDate;
    property TargetDate: Variant read Get_TargetDate write Set_TargetDate;
    property Status: UnicodeString read Get_Status write Set_Status;
    property Category: UnicodeString read Get_Category write Set_Category;
    property Priority: UnicodeString read Get_Priority write Set_Priority;
    property EndDate: Variant read Get_EndDate write Set_EndDate;
    property CosmosSystem: UnicodeString read Get_CosmosSystem write Set_CosmosSystem;
    property Notes: UnicodeString read Get_Notes write Set_Notes;
    property Order: Integer read Get_Order write Set_Order;
    property TaskIndex: UnicodeString read Get_TaskIndex write Set_TaskIndex;
  end;

{ Forward Decls }

  TXMLTasksFileType = class;
  TXMLTasksType = class;
  TXMLTaskType = class;

{ TXMLTasksFileType }

  TXMLTasksFileType = class(TXMLNode, IXMLTasksFile)
  protected
    { IXMLTasksFileType }
    function Get_FileName: UnicodeString;
    function Get_CreateDate: TDateTime;
    function Get_UpdateDate: TDateTime;
    function Get_Owner: UnicodeString;
    function Get_Tasks: IXMLTasks;
    procedure Set_FileName(Value: UnicodeString);
    procedure Set_CreateDate(Value: TDateTime);
    procedure Set_UpdateDate(Value: TDateTime);
    procedure Set_Owner(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTasksType }

  TXMLTasksType = class(TXMLNodeCollection, IXMLTasks)
  protected
    { IXMLTasksType }
    function Get_Task(Index: Integer): IXMLTask;
    function Add: IXMLTask;
    function Insert(const Index: Integer): IXMLTask;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTaskType }

  TXMLTaskType = class(TXMLNode, IXMLTask)
  protected
    { IXMLTaskType }
    function Get_Description: UnicodeString;
    function Get_Creator: UnicodeString;
    function Get_CreateDate: TDateTime;
    function Get_TargetDate: Variant;
    function Get_Status: UnicodeString;
    function Get_Category: UnicodeString;
    function Get_Priority: UnicodeString;
    function Get_EndDate: Variant;
    function Get_CosmosSystem: UnicodeString;
    function Get_Notes: UnicodeString;
    function Get_Order: Integer;
    function Get_TaskIndex: UnicodeString;

    procedure Set_Description(Value: UnicodeString);
    procedure Set_Creator(Value: UnicodeString);
    procedure Set_CreateDate(Value: TDateTime);
    procedure Set_TargetDate(Value: Variant);
    procedure Set_Status(Value: UnicodeString);
    procedure Set_Category(Value: UnicodeString);
    procedure Set_Priority(Value: UnicodeString);
    procedure Set_EndDate(Value: Variant);
    procedure Set_CosmosSystem(Value: UnicodeString);
    procedure Set_Notes(Value: UnicodeString);
    procedure Set_Order(Value: Integer);
    procedure Set_TaskIndex(Value: UnicodeString);
  end;

{ Global Functions }

function GetTasksFile(Doc: IXMLDocument): IXMLTasksFile;
function LoadTasksFile(const FileName: string): IXMLTasksFile;
function NewTasksFile: IXMLTasksFile;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetTasksFile(Doc: IXMLDocument): IXMLTasksFile;
begin
  Result := Doc.GetDocBinding('TasksFile', TXMLTasksFileType, TargetNamespace) as IXMLTasksFile;
end;

function LoadTasksFile(const FileName: string): IXMLTasksFile;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('TasksFile', TXMLTasksFileType, TargetNamespace) as IXMLTasksFile;
end;

function NewTasksFile: IXMLTasksFile;
begin
  Result := NewXMLDocument.GetDocBinding('TasksFile', TXMLTasksFileType, TargetNamespace) as IXMLTasksFile;
end;

{ TXMLTasksFileType }

procedure TXMLTasksFileType.AfterConstruction;
begin
  RegisterChildNode('Tasks', TXMLTasksType);
  inherited;
end;

function TXMLTasksFileType.Get_FileName: UnicodeString;
begin
  Result := AttributeNodes['FileName'].Text;
end;

procedure TXMLTasksFileType.Set_FileName(Value: UnicodeString);
begin
  SetAttribute('FileName', Value);
end;

function TXMLTasksFileType.Get_CreateDate: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['CreateDate'].NodeValue);
end;

procedure TXMLTasksFileType.Set_CreateDate(Value: TDateTime);
begin
  SetAttribute('CreateDate', Value);
end;

function TXMLTasksFileType.Get_UpdateDate: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['UpdateDate'].NodeValue);
end;

procedure TXMLTasksFileType.Set_UpdateDate(Value: TDateTime);
begin
  SetAttribute('UpdateDate', Value);
end;

function TXMLTasksFileType.Get_Owner: UnicodeString;
begin
  Result := AttributeNodes['Owner'].Text;
end;

procedure TXMLTasksFileType.Set_Owner(Value: UnicodeString);
begin
  SetAttribute('Owner', Value);
end;

function TXMLTasksFileType.Get_Tasks: IXMLTasks;
begin
  Result := ChildNodes['Tasks'] as IXMLTasks;
end;

{ TXMLTasksType }

procedure TXMLTasksType.AfterConstruction;
begin
  RegisterChildNode('Task', TXMLTaskType);
  ItemTag := 'Task';
  ItemInterface := IXMLTask;
  inherited;
end;

function TXMLTasksType.Get_Task(Index: Integer): IXMLTask;
begin
  Result := List[Index] as IXMLTask;
end;

function TXMLTasksType.Add: IXMLTask;
begin
  Result := AddItem(-1) as IXMLTask;
end;

function TXMLTasksType.Insert(const Index: Integer): IXMLTask;
begin
  Result := AddItem(Index) as IXMLTask;
end;

{ TXMLTaskType }

function TXMLTaskType.Get_Description: UnicodeString;
begin
  Result := AttributeNodes['Description'].Text;
end;

procedure TXMLTaskType.Set_Description(Value: UnicodeString);
begin
  SetAttribute('Description', Value);
end;

function TXMLTaskType.Get_Creator: UnicodeString;
begin
  Result := AttributeNodes['Creator'].Text;
end;

procedure TXMLTaskType.Set_Creator(Value: UnicodeString);
begin
  SetAttribute('Creator', Value);
end;

function TXMLTaskType.Get_CreateDate: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['CreateDate'].NodeValue);
end;

procedure TXMLTaskType.Set_CreateDate(Value: TDateTime);
begin
  SetAttribute('CreateDate', Value);
end;

function TXMLTaskType.Get_TargetDate: Variant;
begin
  Result := VarToDateTime(AttributeNodes['TargetDate'].NodeValue);
end;

function TXMLTaskType.Get_TaskIndex: UnicodeString;
begin
  Result := AttributeNodes['TaskIndex'].Text;
end;

procedure TXMLTaskType.Set_TargetDate(Value: Variant);
begin
  SetAttribute('TargetDate', Value);
end;

procedure TXMLTaskType.Set_TaskIndex(Value: UnicodeString);
begin
  SetAttribute('TaskIndex', Value);
end;

function TXMLTaskType.Get_Status: UnicodeString;
begin
  Result := AttributeNodes['Status'].Text;
end;

procedure TXMLTaskType.Set_Status(Value: UnicodeString);
begin
  SetAttribute('Status', Value);
end;

function TXMLTaskType.Get_Category: UnicodeString;
begin
  Result := AttributeNodes['Category'].Text;
end;

procedure TXMLTaskType.Set_Category(Value: UnicodeString);
begin
  SetAttribute('Category', Value);
end;

function TXMLTaskType.Get_Priority: UnicodeString;
begin
  Result := AttributeNodes['Priority'].Text;
end;

procedure TXMLTaskType.Set_Priority(Value: UnicodeString);
begin
  SetAttribute('Priority', Value);
end;

function TXMLTaskType.Get_EndDate: Variant;
begin
  Result := AttributeNodes['EndDate'].NodeValue;
end;

procedure TXMLTaskType.Set_EndDate(Value: Variant);
begin
  SetAttribute('EndDate', Value);
end;

function TXMLTaskType.Get_CosmosSystem: UnicodeString;
begin
  Result := AttributeNodes['CosmosSystem'].Text;
end;

procedure TXMLTaskType.Set_CosmosSystem(Value: UnicodeString);
begin
  SetAttribute('CosmosSystem', Value);
end;

function TXMLTaskType.Get_Notes: UnicodeString;
begin
  Result := AttributeNodes['Notes'].Text;
end;

procedure TXMLTaskType.Set_Notes(Value: UnicodeString);
begin
  SetAttribute('Notes', Value);
end;

function TXMLTaskType.Get_Order: Integer;
begin
  Result := AttributeNodes['Order'].NodeValue;
end;

procedure TXMLTaskType.Set_Order(Value: Integer);
begin
  SetAttribute('Order', Value);
end;

end.