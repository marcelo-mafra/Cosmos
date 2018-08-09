unit cosmos.tools.tasks.classes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, Xml.XMLIntf, Xml.XMLDoc, Datasnap.DBClient,
  cosmos.tools.tasks.parser, cosmos.system.winshell;

type
 TTaskData = Olevariant;

 TTask = class

  private
    FDescription: string;
    FCreator: string;
    FCreateDate: TDateTime;
    FTargetDate: variant;
    FStatus: string;
    FCategory: string;
    FCosmosSystem: string;
    FPriority: string;
    FEndDate: variant;
    FTaskIndex: string;
    FNotes: string;

  public
   constructor Create;
   destructor Destroy; override;

   function ReadData: TTaskData;


   property Description: string read FDescription write FDescription;
   property Creator: string read FCreator write FCreator;
   property CosmosSystem: string read FCosmosSystem write FCosmosSystem;
   property CreateDate: TDateTime read FCreateDate write FCreateDate;
   property TargetDate: variant read FTargetDate write FTargetDate;
   property Status: string read FStatus write FStatus;
   property Category: string read FCategory write FCategory;
   property TaskIndex: string read FTaskIndex write FTaskIndex;
   property Priority: string read FPriority write FPriority;
   property EndDate: variant read FEndDate write FEndDate;
   property Notes: string read FNotes write FNotes;
 end;

 TTasks = class(TInterfacedObject)

  private
   FChanged: boolean;
   FCurrentIndex: integer;
   FCopiedTask: TTask;
   AFile: IXMLTasksFile;

   function GetTasksCount: integer;
   function GetCurrentFile: string;
   function GetCurrentTask: TTask;
   function GetEndOfFile: boolean;

   function FindRecordIndex(const TaskIndex: string): integer;


  public
    constructor Create(const FileName, Owner: string);
    destructor Destroy; override;

    function FindByTaskName(Value: string): TTask;
    function FindByTaskIndex(const Value: string): TTask;
    function FindRecordTask(const value: string): IXMLTask;
    procedure ConcludeTask(TaskIndex: string);
    procedure CopyTask(ATask: TTask);
    procedure PasteTask;
    procedure SaveToFile(const FileName: TFileName);
    function DeleteTask(const TaskIndex: string): boolean;
    procedure Clear;

    function InsertTask(ATask: TTask): boolean;
    function UpdateTask(ATask: TTask): boolean;

    function GetTask(Index: integer): TTask;
    procedure FirstTask;
    procedure NextTask;
    procedure PriorTask;
    procedure ConvertToDataPacket(Dataset: TClientDataset);

    property Changed: boolean read FChanged;
    property CurrentFile: string read GetCurrentFile;
    property CurrentTask: TTask read GetCurrentTask;
    property EOF: boolean read GetEndOfFile;
    property CopiedTask: TTask read FCopiedTask;
    property TasksCount: integer read GetTasksCount;


 end;

implementation

{ TTask }

constructor TTask.Create;
begin
 inherited Create;
end;

destructor TTask.Destroy;
begin
 inherited Destroy;
end;

function TTask.ReadData: TTaskData;
begin
 Result := varArrayCreate([0,10], varVariant);
 Result[0] := self.Description;
 Result[1] := self.Creator;
 Result[2] := self.CreateDate;
 Result[3] := self.TargetDate;
 Result[4] := self.Status;
 Result[5] := self.Category;
 Result[6] := self.Priority;
 Result[7] := self.EndDate;
 Result[8] := self.CosmosSystem;
 Result[9] := self.Notes;
 Result[10] := self.TaskIndex;
end;


{ TTasks }

procedure TTasks.Clear;
begin
 AFile.Tasks.Clear;
end;

procedure TTasks.ConcludeTask(TaskIndex: string);
var
 ITask: IXMLTask;
begin
  ITask := self.FindRecordTask(TaskIndex);
  if ITask <> nil then
   begin
    ITask.Status := 'Concluída';
    ITask.EndDate := Now;
    self.SaveToFile(AFile.FileName);
   end;
end;

procedure TTasks.ConvertToDataPacket(Dataset: TClientDataset);
var
 ATask: TTask;
begin
 Dataset.EmptyDataSet;
 self.FirstTask;

 try
   while not self.EOF do
     begin
      ATask := self.CurrentTask;
      Dataset.Append;

      with Dataset.Fields do
       begin
        FieldByName('TaskIndex').Value := ATask.TaskIndex;
        FieldByName('Description').Value := ATask.Description;
        FieldByName('Creator').Value := ATask.Creator;
        FieldByName('CosmosSystem').Value := ATask.CosmosSystem;
        FieldByName('CreateDate').Value := ATask.CreateDate;
        FieldByName('TargetDate').Value := ATask.TargetDate;
        FieldByName('Status').Value := ATask.Status;
        FieldByName('Category').Value := ATask.Category;
        FieldByName('Priority').Value := ATask.Priority;
        FieldByName('EndDate').Value := ATask.EndDate;
        FieldByName('Notes').Value := ATask.Notes;
       end;

      Dataset.Post;
      self.NextTask;
     end;

   finally
    self.FirstTask;
   end;
end;

procedure TTasks.CopyTask(ATask: TTask);
begin
 FCopiedTask := ATask;
end;

constructor TTasks.Create(const FileName, Owner: string);
begin
  inherited Create;
  FChanged := False;

  if TShellFiles.FileExists(FileName, False) then
   begin
    AFile := LoadTasksFile(FileName);
    AFile.OwnerDocument.Encoding := 'UTF-8'; //do not localize!
    AFile.OwnerDocument.Options := [];
    AFile.OwnerDocument.Options := AFile.OwnerDocument.Options + [doNodeAutoIndent];
    AFile.OwnerDocument.NodeIndentStr := '  ';
   end
  else
   begin
    AFile := NewTasksFile;
    AFile.OwnerDocument.Encoding := 'UTF-8'; //do not localize!
    AFile.OwnerDocument.Options := [];
    AFile.OwnerDocument.Options := AFile.OwnerDocument.Options + [doNodeAutoIndent];
    AFile.OwnerDocument.NodeIndentStr := '  ';

    AFile.FileName := FileName;
    AFile.CreateDate := Now;
    AFile.UpdateDate := AFile.CreateDate;
    AFile.Owner := Owner;
    AFile.OwnerDocument.SaveToFile(FileName);

    AFile := LoadTasksFile(FileName);
   end;

  FCurrentIndex := 0;
end;

function TTasks.DeleteTask(const TaskIndex: string): boolean;
var
AIndex: integer;
begin
 try
  AIndex := self.FindRecordIndex(TaskIndex);
  if AIndex >= 0 then
   begin
    AFile.Tasks.Delete(AIndex);
    FChanged := True;
    Result := True;
   end
   else
    Result := False;

 except
  on E: Exception do
   begin
    Raise;
   end;
 end;
end;

destructor TTasks.Destroy;
begin
  if Assigned(FCopiedTask) then
   FreeAndNil(FCopiedTask);

  AFile := nil;
  inherited Destroy;
end;

function TTasks.FindByTaskIndex(const Value: string): TTask;
var
I: integer;
begin
 Result := nil;

 for I := 0 to Pred(AFile.Tasks.Count) do
   begin
    Result := self.GetTask(I);
    if Result.TaskIndex = Value then
     begin
      Result := self.GetTask(I);
      Break;
     end
    else
     Result := nil;
   end;
end;

function TTasks.FindRecordIndex(const TaskIndex: string): integer;
var
I: integer;
ITask: IXMLTask;
begin
 Result := -1;

 for I := 0 to Pred(AFile.Tasks.Count) do
   begin
    ITask := AFile.Tasks.Task[I];
    if ITask.TaskIndex = TaskIndex then
     begin
      Result := I;
      Break;
     end;
   end;
end;

function TTasks.FindRecordTask(const value: string): IXMLTask;
var
I: integer;
begin
 Result := nil;

 for I := 0 to Pred(AFile.Tasks.Count) do
   begin
    Result := AFile.Tasks.Task[I];
    if Result.TaskIndex = Value then
      Break
    else
     Result := nil;
   end;
end;

function TTasks.FindByTaskName(Value: string): TTask;
var
I: integer;
begin
 Result := nil;

 for I := 0 to Pred(AFile.Tasks.Count) do
   begin
    Result := self.GetTask(I);
    if Result.Description = Value then
     begin
      Result := self.GetTask(I);
      Break;
     end
    else
     Result := nil;
   end;
end;

procedure TTasks.FirstTask;
begin
 FCurrentIndex := 0;
end;

function TTasks.GetCurrentFile: string;
begin
 if AFile <> nil then
  Result := AFile.FileName
 else
  Result := '';
end;

function TTasks.GetCurrentTask: TTask;
begin
 Result := self.GetTask(FCurrentIndex);
end;

function TTasks.GetEndOfFile: boolean;
begin
 Result := self.GetTask(FCurrentIndex) = nil;
end;

function TTasks.GetTask(Index: integer): TTask;
begin
 Result := nil;
 if (Index <= Pred(AFile.Tasks.Count)) then
  begin
    Result := TTask.Create;
    Result.TaskIndex := AFile.Tasks.Task[Index].TaskIndex;
    Result.Description := AFile.Tasks.Task[Index].Description;
    Result.Creator := AFile.Tasks.Task[Index].Creator;
    Result.CreateDate := AFile.Tasks.Task[Index].CreateDate;
    Result.TargetDate := AFile.Tasks.Task[Index].TargetDate;
    Result.EndDate := AFile.Tasks.Task[Index].EndDate;
    Result.CosmosSystem := AFile.Tasks.Task[Index].CosmosSystem;
    Result.Status := AFile.Tasks.Task[Index].Status;
    Result.Category := AFile.Tasks.Task[Index].Category;
    Result.Priority := AFile.Tasks.Task[Index].Priority;
    Result.Notes := AFile.Tasks.Task[Index].Notes;
  end;
end;

function TTasks.GetTasksCount: integer;
begin
 Result := AFile.Tasks.Count;
end;

function TTasks.InsertTask(ATask: TTask): boolean;
var
 ITask: IXMLTask;
begin
 Result := ATask <> nil;
 ITask := AFile.Tasks.Add;
 ITask.TaskIndex := ATask.TaskIndex;
 ITask.Description := ATask.Description;
 ITask.Creator := ATask.Creator;
 ITask.CreateDate := ATask.CreateDate;
 ITask.TargetDate := ATask.TargetDate;
 ITask.EndDate := ATask.EndDate;
 ITask.CosmosSystem := ATask.CosmosSystem;
 ITask.Status := ATask.Status;
 ITask.Category := ATask.Category;
 ITask.Priority := ATask.Priority;
 ITask.Notes := ATask.Notes;


 self.SaveToFile(self.CurrentFile);
end;

procedure TTasks.NextTask;
begin
 if FCurrentIndex <= Pred(self.TasksCount) then
  Inc(FCurrentIndex);
end;

procedure TTasks.PasteTask;
var
 AIndex: TGUID;
begin
 {Cola uma tarefa nova, com todos os dados da cópia, excetuando-se o índice.
 Primeiro, muda a chave-primária (índice) da tarefa. Se isto não for feito, a
 ferramenta começará a editar as tarefas incorretamente.}
 if CopiedTask <> nil then
  begin
   CreateGUID(AIndex);
   CopiedTask.TaskIndex := GuidToString(AIndex);
   self.InsertTask(CopiedTask);
  end;
end;

procedure TTasks.PriorTask;
begin
 if FCurrentIndex > 0 then
  Dec(FCurrentIndex);
end;

procedure TTasks.SaveToFile(const FileName: TFileName);
begin
// AFile.OwnerDocument.Active := True;
// AFile.OwnerDocument.XML.Text := FormatXMLData(AFile.OwnerDocument.XML.Text);
 AFile.OwnerDocument.SaveToFile(FileName);

end;

function TTasks.UpdateTask(ATask: TTask): boolean;
var
 ITask: IXMLTask;

begin
 Result := ATask <> nil;
 ITask := self.FindRecordTask(ATask.TaskIndex);
 try
  if ITask <> nil then
   begin
    ITask.TaskIndex := ATask.TaskIndex;
    ITask.Description := ATask.Description;
    ITask.Creator := ATask.Creator;
    ITask.CreateDate := ATask.CreateDate;
    ITask.CosmosSystem := ATask.CosmosSystem;
    ITask.Status := ATask.Status;
    ITask.Category := ATask.Category;
    ITask.Priority := ATask.Priority;
    ITask.Notes := ATask.Notes;
    ITask.TargetDate := ATask.TargetDate;
    ITask.EndDate := ATask.EndDate;

    self.SaveToFile(self.CurrentFile);
   end;

 finally
  if Assigned(ITask) then
   ITask := nil;
 end;
end;

end.
