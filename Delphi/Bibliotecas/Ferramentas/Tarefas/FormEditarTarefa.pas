unit FormEditarTarefa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GroupHeader, cosmos.tools.tasks.classes,
  cosmos.core.classes, cosmos.framework.interfaces.root, cosmos.core.ConstantesMsg,
  ComCtrls;

type
  TEditMode = (emInsert, emUpdate);

  TFrmEditartarefa = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    Label1: TLabel;
    EdtDescricao: TEdit;
    CBXSituacao: TComboBox;
    Label2: TLabel;
    BtnNew: TButton;
    BtnSave: TButton;
    Button3: TButton;
    CBXCategoria: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    CBXPrioridade: TComboBox;
    MmoNotes: TMemo;
    Label5: TLabel;
    EdtGoalDate: TDateTimePicker;
    Label6: TLabel;
    Label7: TLabel;
    EdtCreator: TEdit;
    Label8: TLabel;
    EdtModule: TEdit;
    Label9: TLabel;
    EdtCreateDate: TEdit;
    Label10: TLabel;
    EdtConcludeDate: TEdit;
    procedure BtnSaveClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FTaskIndex: string;
    FTasks: TTasks;
    FEditMode: TEditMode;

    procedure DoInsertTask;
    procedure DoUpdateTask(const TaskIndex: string);

  public
    { Public declarations }
    procedure NovaTarefa(var Tasks: TTasks);
    procedure EditarTarefa(const Task: TTask; var Tasks: TTasks);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditartarefa: TFrmEditartarefa;

implementation

{$R *.dfm}

{ TFrmEditartarefa }

procedure TFrmEditartarefa.BtnNewClick(Sender: TObject);
begin
 FTaskIndex := '';
 self.EdtDescricao.Text := '';
 FEditMode := emInsert;
 self.CBXSituacao.ItemIndex := 0; //Aberta
 self.EdtCreator.Text := ICosmosApp.IRemoteCon.ConnectedUser;
 self.EdtCreateDate.Text := '';
 self.EdtConcludeDate.Text := '';
 self.EdtGoalDate.DateTime := Now;
 self.MmoNotes.Lines.Clear;

 case ICosmosApp.CosmosModule of
  cmFocos: EdtModule.Text := sCosmosFocos;
  cmSecretarias: EdtModule.Text := sCosmosSecretarias;
  cmFinanceiro: EdtModule.Text := sCosmosFinanceiro;
  cmConferencias: EdtModule.Text := sCosmosConferencias;
  cmUsuarios: EdtModule.Text := sCosmosUsuarios
  else
   EdtModule.Text := '';
 end;

 self.EdtDescricao.SetFocus;
end;

procedure TFrmEditartarefa.BtnSaveClick(Sender: TObject);
begin
 if FEditMode = emInsert then
  self.DoInsertTask
 else
  self.DoUpdateTask(FTaskIndex);
end;

procedure TFrmEditartarefa.Button3Click(Sender: TObject);
begin
 Close;
end;

procedure TFrmEditartarefa.DoInsertTask;
var
ATask: TTask;
AIndex: TGUID;
begin
 ATask := TTask.Create;

 try
  CreateGUID(AIndex);
  ATask.TaskIndex := GuidToString(AIndex);
  ATask.Description := self.EdtDescricao.Text;
  Atask.Creator := ICosmosApp.IRemoteCon.ConnectedUser;

  case ICosmosApp.CosmosModule of
    cmFocos: ATask.CosmosSystem := sCosmosFocos;
    cmSecretarias: ATask.CosmosSystem := sCosmosSecretarias;
    cmFinanceiro: ATask.CosmosSystem := sCosmosFinanceiro;
    cmConferencias:ATask.CosmosSystem := sCosmosConferencias;
    cmUsuarios: ATask.CosmosSystem := sCosmosUsuarios
    else
     ATask.CosmosSystem := '';
  end;

  ATask.CreateDate := Now;
  ATask.TargetDate := self.EdtGoalDate.Date;
  ATask.Status := self.CBXSituacao.Text;
  ATask.Category := self.CBXCategoria.Text;
  ATask.Priority := self.CBXPrioridade.Text;
  ATask.EndDate := unassigned;
  ATask.Notes := self.MmoNotes.Text;
  self.FTasks.InsertTask(ATask);

 finally
  if Assigned(ATask) then
   FreeAndNil(ATask);
 end;
end;

procedure TFrmEditartarefa.DoUpdateTask(const TaskIndex: string);
var
ATask: TTask;
begin
 ATask := TTask.Create;

 try
  ATask.TaskIndex := TaskIndex;
  ATask.Description := self.EdtDescricao.Text;
  ATask.CreateDate := StrToDateTime(self.EdtCreateDate.Text);
  ATask.Creator := self.EdtCreator.Text;
  ATask.TargetDate := self.EdtGoalDate.Date;
  ATask.Status := self.CBXSituacao.Text;
  ATask.Category := self.CBXCategoria.Text;
  ATask.Priority := self.CBXPrioridade.Items.Strings[self.CBXPrioridade.ItemIndex];
  ATask.CosmosSystem := self.EdtModule.Text;

  if self.CBXSituacao.ItemIndex = 3 then
   ATask.EndDate := Now
  else
   ATask.EndDate := ATask.EndDate; //permanece igual...

  ATask.Notes := self.MmoNotes.Text;

  self.FTasks.UpdateTask(ATask)

 finally
  if Assigned(ATask) then
   FreeAndNil(ATask);
 end;

end;

procedure TFrmEditartarefa.EditarTarefa(const Task: TTask; var Tasks: TTasks);
begin
 FEditMode := emUpdate;
 FTasks := Tasks;
 FTaskIndex := Task.TaskIndex;

 self.EdtDescricao.Text := Task.Description;
 self.EdtCreator.Text := Task.Creator;
 self.EdtModule.Text := Task.CosmosSystem;
 self.EdtCreateDate.Text := TDataConverter.ToFormatedDateTime(Task.CreateDate);
 if Task.EndDate <> null then
  self.EdtConcludeDate.Text := TDataConverter.ToFormatedDateTime(TDataConverter.ToDateTime(Task.EndDate));


 self.CBXSituacao.ItemIndex :=  self.CBXSituacao.Items.IndexOf(Task.Status);
 self.CBXCategoria.Text := Task.Category;
 self.CBXPrioridade.ItemIndex := CBXPrioridade.Items.IndexOf(Task.Priority);
 self.EdtGoalDate.DateTime := Task.TargetDate;
 self.MmoNotes.Text := Task.Notes;
 ShowModal;
end;

procedure TFrmEditartarefa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(ICosmosApp) then FICosmosApp := nil;

 if Assigned(FTasks) then FTasks := nil;
end;

procedure TFrmEditartarefa.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
end;

procedure TFrmEditartarefa.NovaTarefa(var Tasks: TTasks);
begin
 FTasks := Tasks;
 FEditMode := emInsert;
 self.CBXSituacao.ItemIndex := 0; //Aberta
 self.EdtCreator.Text := ICosmosApp.IRemoteCon.ConnectedUser;

 case ICosmosApp.CosmosModule of
  cmFocos: EdtModule.Text := sCosmosFocos;
  cmSecretarias: EdtModule.Text := sCosmosSecretarias;
  cmFinanceiro: EdtModule.Text := sCosmosFinanceiro;
  cmConferencias: EdtModule.Text := sCosmosConferencias;
  cmUsuarios: EdtModule.Text := sCosmosUsuarios
  else
   EdtModule.Text := '';
 end;

 ShowModal;
end;

end.
