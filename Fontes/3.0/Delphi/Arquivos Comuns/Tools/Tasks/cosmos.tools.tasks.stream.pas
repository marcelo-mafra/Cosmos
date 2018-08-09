unit cosmos.tools.tasks.stream;
{NOTA: este arquivo contém a implementação antiga da ferramenta de tarefas. As
classes nele definidas e implementadas trabalham com arquivos binários,
através de streams. Este arquivo não está mais em uso, pois a implementação
foi completamente substituída por arquivos no formato XML. Contudo, mative este
arquivo no projeto apenas para resguardo e futuras utilizações.}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.ComCtrls, System.StrUtils;

type
 TTaskData = Olevariant;

 TTaskSearchDirection = (tsdTodas, tsdAcima, tsdAbaixo);

 TTask = class

  private
    FTaskName: string;
    FTaskCreator: string;
    FTaskDate: TDateTime;
    FTaskGoal: variant;
    FTaskStatus: string;
    FTaskCategory: string;
    FTaskModule: string;
    FTaskPriority: string;
    FTaskEndDate: variant;
    FTaskNotes: string;

  public
   constructor Create;
   destructor Destroy; override;

   function ReadData: TTaskData;


   property TaskName: string read FTaskName write FTaskName;
   property TaskCreator: string read FTaskCreator write FTaskCreator;
   property TaskModule: string read FTaskModule write FTaskModule;
   property TaskDate: TDateTime read FTaskDate;
   property TaskGoal: variant read FTaskGoal write FTaskGoal;
   property TaskStatus: string read FTaskStatus write FTaskStatus;
   property TaskCategory: string read FTaskCategory write FTaskCategory;
   property TaskPriority: string read FTaskPriority write FTaskPriority;
   property TaskEndDate: variant read FTaskEndDate write FTaskEndDate;
   property TaskNotes: string read FTaskNotes write FTaskNotes;
 end;

 TTasks = class(TInterfacedObject)

  private
   FCurrentFile: string;
   FSource: TListView;
   FCopiedTask: TTask;
   FChanged: boolean;

   function GetTasksCount: integer;
   procedure FillTask(var ATask: TTask; AItem: TListItem);
   function ReadSelectedTask: TTask;
   function GetHasMemoryData: boolean;
   function GetCurrentTask: TTask;

  public
    constructor Create(ASource: TListView);
    destructor Destroy; override;

    function FindByTaskName(Value: string; Partial: Boolean; Direction: TTaskSearchDirection): TTask;
    procedure ConcludeTask(Task: TTask);
    procedure CopyTask;
    procedure PasteTask;
    procedure SaveToFile(const FileName: TFileName);
    procedure LoadTaskFile(const FileName: TFileName);
    function GetSelectedCount: integer;
    procedure DeleteTask;
    function NewTask: TTask;
    procedure WriteTask(const ATask: TTask; Newtask: boolean = True);

    procedure ClearMemoryData;

    property CurrentFile: string read FCurrentFile;
    property CurrentTask: TTask read GetCurrentTask;
    property Source: TListView read FSource write FSource;
    property SelectedCount: integer read GetSelectedCount;
    property TasksCount: integer read GetTasksCount;
    property HasMemoryData: boolean read GetHasMemoryData;
    property Changed: boolean read FChanged;
 end;

implementation

{ TTask }

constructor TTask.Create;
begin
 inherited Create;
 self.FTaskDate := Now;
end;

destructor TTask.Destroy;
begin
 inherited Destroy;
end;

function TTask.ReadData: TTaskData;
begin
 Result := varArrayCreate([0,9], varVariant);
 Result[0] := self.TaskName;
 Result[1] := self.TaskCreator;
 Result[2] := self.TaskDate;
 Result[3] := self.TaskGoal;
 Result[4] := self.TaskStatus;
 Result[5] := self.TaskCategory;
 Result[6] := self.TaskPriority;
 Result[7] := self.TaskEndDate;
 Result[8] := self.TaskModule;
 Result[9] := self.TaskNotes;
end;


{ TTasks }

procedure TTasks.ClearMemoryData;
begin
 //Limpa a variável que contém a tarefa copiada em memória
  if Assigned(FCopiedTask) then
   FreeAndNil(FCopiedTask);
end;

procedure TTasks.ConcludeTask(Task: TTask);
begin
  Task.TaskStatus := 'Concluída';
  Task.TaskEndDate := Now;
  WriteTask(Task, False);
end;

procedure TTasks.CopyTask;
begin
 FCopiedTask := self.ReadSelectedTask;
end;

constructor TTasks.Create(ASource: TListView);
begin
 inherited Create;
 FChanged := False;
 FSource := ASource;
end;

procedure TTasks.DeleteTask;
begin
 if Source.Selected <> nil then
  begin
   Source.DeleteSelected;
   FChanged := True;
  end;
end;

destructor TTasks.Destroy;
begin
  if Assigned(FCopiedTask) then
   FreeAndNil(FCopiedTask);

  if Assigned(FSource) then
   FSource := nil;

  inherited Destroy;
end;

procedure TTasks.FillTask(var ATask: TTask; AItem: TListItem);
begin
 if Assigned(AItem) and (ATask <> nil) then
  begin
    ATask.TaskName := AItem.Caption;
    ATask.TaskCreator := AItem.SubItems.Strings[0];
    ATask.FTaskDate := StrToDateTime(AItem.SubItems.Strings[1]);

    if Trim(AItem.SubItems.Strings[2]) <> '' then
      ATask.TaskGoal := StrToDateTime(AItem.SubItems.Strings[2])
    else
      ATask.TaskGoal := unassigned;

    ATask.TaskStatus := AItem.SubItems.Strings[3];
    ATask.TaskCategory := AItem.SubItems.Strings[4];
    ATask.TaskPriority := AItem.SubItems.Strings[5];

    if Trim(AItem.SubItems.Strings[6]) <> '' then
      ATask.TaskEndDate := StrToDateTime(AItem.SubItems.Strings[6])
    else
      ATask.TaskEndDate := unassigned;

    ATask.TaskModule := AItem.SubItems.Strings[7];
    ATask.TaskNotes := AItem.SubItems.Strings[8];
  end;
end;

function TTasks.FindByTaskName(Value: string; Partial: Boolean; Direction: TTaskSearchDirection): TTask;
var
 AItem: TListItem;
 Found: boolean;
begin
// AItem := Source.FindCaption(Source.Selected.Index, Value, Partial, True, True);

 if Source.Selected <> nil then
  begin
   AItem := Source.Selected;

   if Source.GetNextItem(AItem, sdBelow, []) = nil then //última linha está selecionada...
    AItem := Source.TopItem;
  end
 else
  AItem := Source.TopItem;

 Found := False;

 while not Found do
  begin
   if Partial = True then
    Found := Pos(Value, AItem.Caption) > 0
   else
    Found := AItem.Caption = Value;

   if not Found then //Se não encontrou, segue a lista..
    AItem := Source.GetNextItem(AItem, sdBelow, [])
  end;

 if AItem <> nil then
  begin
   Result := TTask.Create;
   self.FillTask(Result, AItem);
   Source.Selected := AItem;
  end
 else
  Result := nil;
end;

function TTasks.GetCurrentTask: TTask;
begin
 Result := self.ReadSelectedTask;
end;

function TTasks.GetHasMemoryData: boolean;
begin
 Result := Assigned(FCopiedTask);
end;

function TTasks.GetSelectedCount: integer;
begin
 if Assigned(FSource) then
  Result := Source.SelCount
 else
  Result := 0;
end;

function TTasks.GetTasksCount: integer;
begin
 if Assigned(FSource) then
  Result := Source.Items.Count
 else
  Result := 0;
end;

procedure TTasks.LoadTaskFile(const FileName: TFileName);
var
  vNewFile: boolean;
  FStream: TFileStream;
begin
  if not FileExists(FileName) then
   begin
    FStream := TFileStream.Create(FileName, fmCreate);
    vNewFile := True;
   end
  else
   begin
    FStream := TFileStream.Create(FileName, fmOpenRead);
    vNewFile := False;
   end;

  FCurrentFile := FileName;

  try
    Source.Items.BeginUpdate;
    Source.Items.Clear;

    if not vNewFile then
     Source := FStream.ReadComponent(Source) as TListView

  finally
    FStream.Free;
    Source.Items.EndUpdate;
  end;
end;

function TTasks.NewTask: TTask;
begin
 Result := TTask.Create;
end;

procedure TTasks.PasteTask;
begin
 if Assigned(FCopiedTask) then
  self.WriteTask(FCopiedTask);
end;

function TTasks.ReadSelectedTask: TTask;
begin
 if Assigned(Source) and (Source.Selected <> nil) then
  begin
    Result := TTask.Create;
    Result.TaskName := Source.Selected.Caption;
    Result.TaskCreator := Source.Selected.SubItems.Strings[0];
    Result.FTaskDate := StrToDateTime(Source.Selected.SubItems.Strings[1]);

    if Trim(Source.Selected.SubItems.Strings[2]) <> '' then
      Result.TaskGoal := StrToDateTime(Source.Selected.SubItems.Strings[2])
    else
      Result.TaskGoal := unassigned;

    Result.TaskStatus := Source.Selected.SubItems.Strings[3];
    Result.TaskCategory := Source.Selected.SubItems.Strings[4];
    Result.TaskPriority := Source.Selected.SubItems.Strings[5];

    if Trim(Source.Selected.SubItems.Strings[6]) <> '' then
      Result.TaskEndDate := StrToDateTime(Source.Selected.SubItems.Strings[6])
    else
      Result.TaskEndDate := unassigned;

    Result.TaskModule := Source.Selected.SubItems.Strings[7];
    Result.TaskNotes := Source.Selected.SubItems.Strings[8];

  end
 else
  Result := nil;
end;

procedure TTasks.SaveToFile(const FileName: TFileName);
var
  FStream: TMemoryStream;
begin
  FStream := TMemoryStream.Create;

  try
    FStream.WriteComponent(Source);
    FStream.SaveToFile(FileName);
    self.FChanged := False;

  finally
    FStream.Free;
  end;
end;

procedure TTasks.WriteTask(const ATask: TTask; NewTask: boolean);
var
AItem: TListItem;
begin
 try
  Source.Items.BeginUpdate;

  if not Newtask then
   begin
    AItem := Source.Selected;
    AItem.Caption := ATask.TaskName;
    AItem.SubItems.Clear;
   end
  else
   begin
    AItem := Source.Items.Add;
    AItem.Caption := ATask.TaskName;
   end;

  AItem.SubItems.Add(ATask.TaskCreator);
  AItem.SubItems.Add(DateTimeToStr(ATask.TaskDate));
  if ATask.TaskGoal <> unassigned then
   AItem.SubItems.Add(DateTimeToStr(ATask.TaskGoal))
  else
   AItem.SubItems.Add('');
  AItem.SubItems.Add(ATask.TaskStatus);
  AItem.SubItems.Add(ATask.TaskCategory);
  AItem.SubItems.Add(ATask.TaskPriority);
  if ATask.TaskEndDate <> unassigned then
   AItem.SubItems.Add(ATask.TaskEndDate)
  else
   AItem.SubItems.Add('');
  AItem.SubItems.Add(ATask.TaskModule);
  AItem.SubItems.Add(ATask.TaskNotes);

 finally

  Source.Items.EndUpdate;
 end;

 FChanged := True;
end;


end.
