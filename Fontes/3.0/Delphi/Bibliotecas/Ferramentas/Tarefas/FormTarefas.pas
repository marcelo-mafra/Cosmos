unit FormTarefas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosDocked, ActnList, ImgList, cosmos.core.constantesmsg,
  DB, DBClient, Menus, ActnMan, ActnPopup, StdCtrls,
  ExtCtrls, PlatformDefaultStyleActnCtrls, ComCtrls, StrUtils, cosmos.core.classes,
  ToolWin, ActnCtrls, cosmos.framework.datanavigators.listview,
  cosmos.tools.tasks.classes, System.Actions;

type
  TCustomSortStyle = (cssAlphaNum, cssNumeric, cssDateTime);

  TStatusTask = (stAberta, stConcluida, stCancelada, stSuspensa);

  TStatusTaskSet = set of TStatusTask;

  TFrmTarefas = class(TFrmCosmosDocked)
    ActNewTask: TAction;
    ActSave: TAction;
    ActDelete: TAction;
    PopupActionBar1: TPopupActionBar;
    NovaTarefa1: TMenuItem;
    Salvar1: TMenuItem;
    ExcluirTarefa1: TMenuItem;
    ActCopyTask: TAction;
    ActPasteTask: TAction;
    ActClear: TAction;
    CopiarTarefa1: TMenuItem;
    ColarTarefa1: TMenuItem;
    LimparTarefas1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ImageList2: TImageList;
    PnlSummary: TPanel;
    Image1: TImage;
    Label1: TLabel;
    LblTotalTasks: TLabel;
    ActSummary: TAction;
    ExibirSumrio1: TMenuItem;
    LsvTasks: TListView;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    ActEditTask: TAction;
    AlterarTarefa1: TMenuItem;
    N3: TMenuItem;
    ActPrintTaskList: TAction;
    ImprimirTarefas1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    ActConcludeTask: TAction;
    MarcarcomoConcluda1: TMenuItem;
    ActFilterConcluidas: TAction;
    ActFilterAbertas: TAction;
    ActFilterCanceladas: TAction;
    ActFilterSuspensas: TAction;
    Filtrar1: TMenuItem;
    Abertas1: TMenuItem;
    Concludas1: TMenuItem;
    Canceladas1: TMenuItem;
    Suspensas1: TMenuItem;
    N6: TMenuItem;
    Label2: TLabel;
    LblTotalFiltered: TLabel;
    ActSoftGridStyle: TAction;
    ActSampleGridStyle: TAction;
    ActGroupedStyle: TAction;
    Estilos1: TMenuItem;
    Agrupado1: TMenuItem;
    GradeModerna1: TMenuItem;
    GradeSimples1: TMenuItem;
    N7: TMenuItem;
    procedure ActSummaryExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNewTaskExecute(Sender: TObject);
    procedure LsvTasksInsert(Sender: TObject; Item: TListItem);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActDeleteUpdate(Sender: TObject);
    procedure LsvTasksDeletion(Sender: TObject; Item: TListItem);
    procedure ActCopyTaskExecute(Sender: TObject);
    procedure ActPasteTaskExecute(Sender: TObject);
    procedure ActSaveUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActEditTaskExecute(Sender: TObject);
    procedure LsvTasksColumnClick(Sender: TObject; Column: TListColumn);
    procedure LsvTasksAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure LsvTasksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActConcludeTaskExecute(Sender: TObject);
    procedure ActConcludeTaskUpdate(Sender: TObject);
    procedure ActClearExecute(Sender: TObject);
    procedure ActClearUpdate(Sender: TObject);
    procedure ActFilterConcluidasExecute(Sender: TObject);
    procedure ActFilterAbertasExecute(Sender: TObject);
    procedure ActFilterCanceladasExecute(Sender: TObject);
    procedure ActFilterSuspensasExecute(Sender: TObject);
    procedure ActPasteTaskUpdate(Sender: TObject);
    procedure ActSoftGridStyleExecute(Sender: TObject);
    procedure ActSampleGridStyleExecute(Sender: TObject);
    procedure ActGroupedStyleExecute(Sender: TObject);
  private
    { Private declarations }
    FFilteredTasks: integer;
    FTasksFile: TTasks;
    FDataNavigator: TListviewDataNavigator;
    FCurrentFilter: TStatusTaskSet;

    function GetCurrentTaskIndex: string;
    procedure SumarizeTasks; inline;
    procedure LoadTasks(Filter: TStatusTaskSet);
    procedure UpdateData(Sender: TObject);

  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
    procedure ExportData; override;
    procedure UpdateVisualElements; override;

    property CurrentTaskIndex: string read GetCurrentTaskIndex;
    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;

  public
    { Public declarations }
    property CurrentFilter: TStatusTaskSet read FCurrentFilter write FCurrentFilter;
    property FilteredTasks: integer read FFilteredTasks;
    property TasksFile: TTasks read FTasksFile;
  end;

var
  FrmTarefas: TFrmTarefas;
  { variable to hold the sort style }
  LvSortStyle: TCustomSortStyle;
  { array to hold the sort order }
  LvSortOrder: array[0..4] of Boolean; // High[LvSortOrder] = Number of Lv Columns

implementation

uses FormEditarTarefa, FormExportTasks;

{$R *.dfm}

function CustomSortProc(Item1, Item2: TListItem; SortColumn: Integer): Integer; stdcall;
var
  s1, s2: string;
  i1, i2: Integer;
  r1, r2: Boolean;
  d1, d2: TDateTime;

  { Helper functions }

  function IsValidNumber(AString : string; var AInteger : Integer): Boolean;
  var
    Code: Integer;
  begin
    Val(AString, AInteger, Code);
    Result := (Code = 0);
  end;

  function IsValidDate(AString : string; var ADateTime : TDateTime): Boolean;
  begin
    Result := True;
    try
      ADateTime := StrToDateTime(AString);
    except
      ADateTime := 0;
      Result := False;
    end;
  end;

  function CompareDates(dt1, dt2: TDateTime): Integer;
  begin
    if (dt1 > dt2) then Result := 1
    else
      if (dt1 = dt2) then Result := 0
    else
      Result := -1;
  end;

  function CompareNumeric(AInt1, AInt2: Integer): Integer;
  begin
    if AInt1 > AInt2 then Result := 1
    else
      if AInt1 = AInt2 then Result := 0
    else
      Result := -1;
  end;

begin
  Result := 0;

  if (Item1 = nil) or (Item2 = nil) then Exit;

  case SortColumn of
    -1 :
    { Compare Captions }
    begin
      s1 := Item1.Caption;
      s2 := Item2.Caption;
    end;
    else
    { Compare Subitems }
    begin
      s1 := '';
      s2 := '';
      { Check Range }
      if (SortColumn < Item1.SubItems.Count) then
        s1 := Item1.SubItems[SortColumn];
      if (SortColumn < Item2.SubItems.Count) then
        s2 := Item2.SubItems[SortColumn]
    end;
  end;

  { Sort styles }

  case LvSortStyle of
    cssAlphaNum : Result := lstrcmp(PChar(s1), PChar(s2));
    cssNumeric  : begin
                    r1 := IsValidNumber(s1, i1);
                    r2 := IsValidNumber(s2, i2);
                    Result := ord(r1 or r2);
                    if Result <> 0 then
                      Result := CompareNumeric(i2, i1);
                  end;
    cssDateTime : begin
                    r1 := IsValidDate(s1, d1);
                    r2 := IsValidDate(s2, d2);
                    Result := ord(r1 or r2);
                    if Result <> 0 then
                      Result := CompareDates(d1, d2);
                  end;
  end;

  { Sort direction }

  if LvSortOrder[SortColumn + 1] then
    Result := - Result;
end;


{ TFrmTarefas }

procedure TFrmTarefas.ActClearExecute(Sender: TObject);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(sTitleTasksTool, sConfClearTasks) = mrYes then
   begin
    TasksFile.Clear;
    LoadTasks(CurrentFilter);
   end;
end;

procedure TFrmTarefas.ActClearUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (TasksFile <> nil) and (TasksFile.TasksCount > 0);
end;

procedure TFrmTarefas.ActConcludeTaskExecute(Sender: TObject);
begin
  inherited;
  TasksFile.ConcludeTask(self.CurrentTaskIndex);
  self.LoadTasks(CurrentFilter);
end;

procedure TFrmTarefas.ActConcludeTaskUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (self.CurrentTaskIndex <> '');
end;

procedure TFrmTarefas.ActCopyTaskExecute(Sender: TObject);
var
 ATask: TTask;
begin
  inherited;
  //Copia a tarefa selecionada.
  ATask := TasksFile.FindByTaskIndex(CurrentTaskIndex);
  if ATask <> nil then
   TasksFile.CopyTask(ATask);
end;

procedure TFrmTarefas.ActDeleteExecute(Sender: TObject);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(sTitleTasksTool, sConfDelTask) = mrYes then
    begin
     if TasksFile.DeleteTask(self.CurrentTaskIndex) then
      self.LsvTasks.Selected.Delete;
    end;
end;

procedure TFrmTarefas.ActDeleteUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (TasksFile <> nil) and (self.LsvTasks.Selected <> nil);
end;

procedure TFrmTarefas.ActEditTaskExecute(Sender: TObject);
var
 ATask: TTask;
begin
  inherited;
 if not Assigned(TasksFile) then
  Exit;

 ATask := FTasksFile.FindByTaskIndex(self.LsvTasks.Selected.SubItems.Strings[9]);

 if not Assigned(FrmEditarTarefa) then
  FrmEditarTarefa := TFrmEditartarefa.Create(Application);

 try
  FrmEditarTarefa.EditarTarefa(ATask, FTasksFile);

 finally
  if Assigned(FrmEditarTarefa) then
   FreeAndNil(FrmEditarTarefa);
 end;
end;

procedure TFrmTarefas.ActFilterAbertasExecute(Sender: TObject);
begin
  inherited;
  if TAction(Sender).Checked then
   CurrentFilter := CurrentFilter + [stAberta]
  else
   CurrentFilter := CurrentFilter - [stAberta];

  self.LoadTasks(CurrentFilter);
end;

procedure TFrmTarefas.ActFilterCanceladasExecute(Sender: TObject);
begin
  inherited;
  if TAction(Sender).Checked then
   CurrentFilter := CurrentFilter + [stCancelada]
  else
   CurrentFilter := CurrentFilter - [stCancelada];

  self.LoadTasks(CurrentFilter);
end;

procedure TFrmTarefas.ActFilterConcluidasExecute(Sender: TObject);
begin
  inherited;
  if TAction(Sender).Checked then
   CurrentFilter := CurrentFilter + [stConcluida]
  else
   CurrentFilter := CurrentFilter - [stConcluida];

  self.LoadTasks(CurrentFilter);
end;

procedure TFrmTarefas.ActFilterSuspensasExecute(Sender: TObject);
begin
  inherited;
  if TAction(Sender).Checked then
   CurrentFilter := CurrentFilter + [stSuspensa]
  else
   CurrentFilter := CurrentFilter - [stSuspensa];

  self.LoadTasks(CurrentFilter);
end;

procedure TFrmTarefas.ActGroupedStyleExecute(Sender: TObject);
begin
  inherited;
  LsvTasks.GroupView := True;
  LsvTasks.GridLines := False;
end;

procedure TFrmTarefas.ActNewTaskExecute(Sender: TObject);
begin
  inherited;
 if not Assigned(FrmEditartarefa) then
  FrmEditartarefa := TFrmEditartarefa.Create(Application);

 try
  FrmEditartarefa.NovaTarefa(FTasksFile);

 finally
  if Assigned(FrmEditartarefa) then
   FreeAndNil(FrmEditartarefa);
 end;
end;

procedure TFrmTarefas.ActPasteTaskExecute(Sender: TObject);
begin
  inherited;
  TasksFile.PasteTask;
  LoadTasks(CurrentFilter);
end;

procedure TFrmTarefas.ActPasteTaskUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (TasksFile <> nil) and (TasksFile.CopiedTask <> nil);
end;

procedure TFrmTarefas.ActSampleGridStyleExecute(Sender: TObject);
begin
  inherited;
  LsvTasks.GroupView := False;
  LsvTasks.GridLines := True;
end;

procedure TFrmTarefas.ActSaveExecute(Sender: TObject);
begin
  inherited;
  TasksFile.SaveToFile(TasksFile.CurrentFile);
end;

procedure TFrmTarefas.ActSaveUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(TasksFile)) and (TasksFile.Changed);
end;

procedure TFrmTarefas.ActSoftGridStyleExecute(Sender: TObject);
begin
  inherited;
  LsvTasks.GroupView := False;
  LsvTasks.GridLines := False;
end;

procedure TFrmTarefas.ActSummaryExecute(Sender: TObject);
begin
  inherited;
  PnlSummary.Visible := TAction(Sender).Checked;
end;

procedure TFrmTarefas.ExportData;
begin
  inherited;
  if not Assigned(FrmExportTasks) then
   FrmExportTasks := TFrmExportTasks.Create(Application);

  try
   FrmExportTasks.Source := LsvTasks;
   FrmExportTasks.ShowModal;

  finally
   if Assigned(FrmExportTasks) then
    FreeAndNil(FrmExportTasks);
  end;
end;

procedure TFrmTarefas.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := nil;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmTarefas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  if Assigned(TasksFile) then
   FreeAndNil(FTasksFile);
end;

procedure TFrmTarefas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
AMessage: TMessageData;
Buttons: Olevariant;
begin
  inherited;

  if TasksFile.Changed then
   begin
    AMessage := ICosmosApp.CreateMessageData(sInfoSalvamentoTarefas,sTitleTasksTool, mtpConfirmation);
    Buttons := varArrayCreate([0,1], varVariant);
    Buttons[0] := sBtSaveTasks;
    Buttons[1] := sBtNoSaveTasks;

    if ICosmosApp.DlgMessage.Execute(AMessage, Buttons) = 100 then
     TasksFile.SaveToFile(TasksFile.CurrentFile);
   end;
end;

procedure TFrmTarefas.FormCreate(Sender: TObject);
var
AFileName: string;
AMessage: TMessageData;
begin
  inherited;
  AFileName := IcosmosApp.IApplicationPaths.ReadTasksFilesPath;
  AFileName := AFileName + ICosmosApp.IRemoteCon.ConnectedUser + '.tasks';

  FDataNavigator := TListViewDataNavigator.Create(self.LsvTasks);
  DataNavigator := FDataNavigator;
  TListViewDataNavigator(DataNavigator).OnUpdateData := self.UpdateData;

  FTasksFile := TTasks.Create(AFileName, ICosmosApp.IRemoteCon.ConnectedUser);

  try
   //Abre sem filtro, isto é, mostrando tarefas com qualquer status.
   CurrentFilter := CurrentFilter + [stAberta, stConcluida, stCancelada, stSuspensa];
   self.LoadTasks(CurrentFilter);
   //Agora, ordena pela data de criação da tarefa..
   LsvTasks.OnColumnClick(LSvTasks, LsvTasks.Columns[2]);
   self.SumarizeTasks;

  except
   on E: Exception do
    begin
     AMessage := ICosmosApp.CreateMessageData(sErrorLoadTaskFile, sTitleTasksTool, mtpError);
     AMessage.SetMessageInfo(miInnerMessage, E.Message);
     AMessage.SetMessageInfo(miExceptionClassName, E.ClassName);
     AMessage.SetMessageInfo(miCustomInfo, TasksFile.CurrentFile);
     ICosmosApp.DlgMessage.Execute(AMessage);
    end;
  end;
end;

function TFrmTarefas.GetCurrentTaskIndex: string;
begin
 if self.LsvTasks.Selected <> nil then
  Result := self.LsvTasks.Selected.SubItems.Strings[9]
 else
  Result := '';
end;

function TFrmTarefas.GetFormDescription: string;
begin
 Result := sDescFormTarefas;
end;

function TFrmTarefas.GetFormIDName: string;
begin
Result := 'Cosmos.Tarefas';
end;

function TFrmTarefas.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmTarefas.GetHelpID: integer;
begin

end;

function TFrmTarefas.GetTitle: string;
begin
Result := Caption;
end;

procedure TFrmTarefas.LoadTasks(Filter: TStatusTaskSet);
var
 AItem: TListItem;
 ATask: TTask;
begin
 FFilteredTasks := 0; //default ao início.

 if FTasksFile <> nil then
  begin
   self.LsvTasks.Items.BeginUpdate;

   try
    self.LsvTasks.Items.Clear;

    while not FTasksFile.EOF do
     begin
      ATask := FTasksFile.CurrentTask;

      //Verifica se deve listar as tarefas abertas, conforme situação do filtro corrente.
      if (ATask.Status = 'Aberta') and not (stAberta in CurrentFilter) then
       begin
        FTasksFile.NextTask;
        Inc(FFilteredTasks);
        Continue;
       end;

      //Verifica se deve listar as tarefas concluídas, conforme situação do filtro corrente.
      if (ATask.Status = 'Concluída') and not (stConcluida in CurrentFilter) then
       begin
        FTasksFile.NextTask;
        Inc(FFilteredTasks);
        Continue;
       end;

      //Verifica se deve listar as tarefas canceladas, conforme situação do filtro corrente.
      if (ATask.Status = 'Cancelada') and not (stCancelada in CurrentFilter) then
       begin
        FTasksFile.NextTask;
        Inc(FFilteredTasks);
        Continue;
       end;

      //Verifica se deve listar as tarefas suspensas, conforme situação do filtro corrente.
      if (ATask.Status = 'Suspensa') and not (stSuspensa in CurrentFilter) then
       begin
        FTasksFile.NextTask;
        Inc(FFilteredTasks);
        Continue;
       end;

      AItem := self.LsvTasks.Items.Add;
      AItem.Caption := ATask.Description;
      AItem.SubItems.Add(ATask.Creator);
      AItem.SubItems.Add(TDataConverter.ToFormatedDateTime(ATask.CreateDate));
      if ATask.TargetDate <> null then
       AItem.SubItems.Add(TDataConverter.ToFormatedDateTime(TDataConverter.ToDateTime(ATask.TargetDate)))
      else
       AItem.SubItems.Add(TDataConverter.ToFormatedDateTime(Now));
      AItem.SubItems.Add(ATask.Status);

      if ATask.Status = 'Aberta' then
       AItem.GroupID := 0
      else
      if ATask.Status = 'Concluída' then
       AItem.GroupID := 1
      else
      if ATask.Status = 'Cancelada' then
       AItem.GroupID := 2
      else
       AItem.GroupID := 3;

      AItem.SubItems.Add(ATask.Category);
      AItem.SubItems.Add(ATask.Priority);
      if ATask.EndDate <> null then
       AItem.SubItems.Add(TDataConverter.ToFormatedDateTime(TDataConverter.ToDateTime(ATask.EndDate)))
      else
       AItem.SubItems.Add('');
      AItem.SubItems.Add(ATask.CosmosSystem);
      AItem.SubItems.Add(ATask.Notes);
      AItem.SubItems.Add(ATask.TaskIndex);

      FTasksFile.NextTask;
     end;

   finally
    FTasksFile.FirstTask;
    self.LsvTasks.Items.EndUpdate;
   end;
  end;
end;

procedure TFrmTarefas.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmTarefas.LsvTasksAdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
 var
  Canceled, Concluded, Vencida: boolean;
 begin
  inherited;
  Canceled := Item.SubItems.Strings[3] = 'Cancelada';
  if Canceled then
   Sender.Canvas.Font.Color := clSilver;

  Concluded := Item.SubItems.Strings[3] = 'Concluída';
  if Concluded then
   Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsStrikeOut];

  Vencida := (StrToDateTime(Item.SubItems.Strings[2]) < Now) and (Canceled = False)
   and (Concluded = False);
  if Vencida then
   Sender.Canvas.Font.Color := clRed;
end;

procedure TFrmTarefas.LsvTasksColumnClick(Sender: TObject; Column: TListColumn);
begin
  inherited;
  { determine the sort style }
  case Column.Index of
   0, 1, 4, 5, 6, 8: LvSortStyle := cssAlphaNum;
   2, 3, 7: LvSortStyle := cssDateTime
   else
    LvSortStyle := cssAlphaNum;
  end;

 { if Column.Index = 0 then
    LvSortStyle := cssAlphaNum
  else
    LvSortStyle := cssNumeric;}

  { Call the CustomSort method }
  LsvTasks.CustomSort(@CustomSortProc, Column.Index -1);

  { Set the sort order for the column}
  LvSortOrder[Column.Index] := not LvSortOrder[Column.Index];
end;

procedure TFrmTarefas.LsvTasksDeletion(Sender: TObject; Item: TListItem);
begin
  inherited;
  self.SumarizeTasks;
end;

procedure TFrmTarefas.LsvTasksInsert(Sender: TObject; Item: TListItem);
begin
  inherited;
  Item.ImageIndex := 3;
end;

procedure TFrmTarefas.LsvTasksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (LsvTasks.Selected <> nil) and (Key = 13) then //Enter
   ActEditTask.Execute;

  if (LsvTasks.Selected <> nil) and (Key = 46) then //Delete
   ActDelete.Execute;
end;

procedure TFrmTarefas.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmTarefas.SumarizeTasks;
begin
 if Assigned(TasksFile) then
  begin
   self.LblTotalTasks.Caption := IntToStr(TasksFile.TasksCount);
   self.LblTotalFiltered.Caption := IntToStr(FilteredTasks);
  end;
end;

procedure TFrmTarefas.UpdateData(Sender: TObject);
begin
  inherited;
  self.LoadTasks(CurrentFilter);
end;



procedure TFrmTarefas.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmTarefas);

finalization
 UnRegisterClass(TFrmTarefas);

end.
