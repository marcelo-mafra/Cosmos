unit cosmos.common.view.LocateTask;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  GroupHeader, cosmos.classes.application, cosmos.framework.interfaces.DataAcess,
  cosmos.framework.datanavigators.listview;

type

  TFrmLocateTask = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    EdtArgument: TEdit;
    MSGroupHeader2: TMSGroupHeader;
    ChkPartialKey: TCheckBox;
    BtnFind: TButton;
    Button2: TButton;
    ChkAllItems: TCheckBox;
    procedure BtnFindClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EdtArgumentChange(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

  procedure ExecuteLocate;

var
  FrmLocateTask: TFrmLocateTask;

implementation

{$R *.dfm}

procedure ExecuteLocate;
begin
 if not Assigned(FrmLocateTask) then
  FrmLocateTask := TFrmLocateTask.Create(Application);

 FrmLocateTask.FormStyle := fsStayOnTop;
 FrmLocateTask.Show;
end;

{ TFrmLocateTask }

procedure TFrmLocateTask.BtnFindClick(Sender: TObject);
var
AArguments: TCosmosData;
IRemoteCon: ICosmosRemoteConnection;
begin
 if EdtArgument.Text = '' then
  Abort;

 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 try
 if IRemoteCon.ActiveDataNavigator is TListViewDataNavigator then
  begin
   AArguments := TCosmosData.Create(2);
   AArguments.Add('TextValue', EdtArgument.Text);
   AArguments.Add('PartialKey', ChkPartialKey.Checked);
   TListViewDataNavigator(IRemoteCon.ActiveDataNavigator).LocateData(AArguments);
  end;

 finally
  if Assigned(IRemoteCon) then
   IRemoteCon := nil;

  if Assigned(AArguments) then
   AArguments.Free;
 end;
end;

procedure TFrmLocateTask.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TFrmLocateTask.EdtArgumentChange(Sender: TObject);
begin
 BtnFind.Enabled := Trim(TEdit(Sender).Text) <> '';
end;

end.
