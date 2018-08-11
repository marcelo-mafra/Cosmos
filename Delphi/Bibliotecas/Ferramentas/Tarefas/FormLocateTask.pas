unit FormLocateTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GroupHeader, cosmos.business.tools.tasks;

type
  TFrmLocateTask = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    EdtSearchArgs: TEdit;
    MSGroupHeader2: TMSGroupHeader;
    ChkPartial: TCheckBox;
    BtnFind: TButton;
    Button2: TButton;
    CbxDirecao: TComboBox;
    Label2: TLabel;
    procedure BtnFindClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtSearchArgsChange(Sender: TObject);
  private
    { Private declarations }
    FTasks: TTasks;
  public
    { Public declarations }
  end;

  procedure ExecuteLocate(Tasks: TTasks);

var
  FrmLocateTask: TFrmLocateTask;

implementation

{$R *.dfm}

procedure ExecuteLocate(Tasks: TTasks);
begin
 if not Assigned(FrmLocateTask) then
  FrmLocateTask := TFrmLocateTask.Create(Application);

 FrmLocateTask.FTasks := Tasks;
 FrmLocateTask.FormStyle := fsStayOnTop;
 FrmLocateTask.Show;
end;

{ TFrmLocateTask }

procedure TFrmLocateTask.BtnFindClick(Sender: TObject);
var
ADirection: TTaskSearchDirection;
begin
 case self.CbxDirecao.ItemIndex of
  0: ADirection := tsdTodas;
  1: ADirection := tsdAbaixo;
  2: ADirection := tsdAcima;
 end;

 self.FTasks.FindByTaskName(EdtSearchArgs.Text, ChkPartial.Checked, ADirection);
end;

procedure TFrmLocateTask.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TFrmLocateTask.EdtSearchArgsChange(Sender: TObject);
begin
 BtnFind.Enabled := Trim(TEdit(Sender).Text) <> '';
end;

procedure TFrmLocateTask.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(FTasks) then
  FTasks := nil;

 Action := caFree;
 FrmLocateTask := nil;
end;



end.
