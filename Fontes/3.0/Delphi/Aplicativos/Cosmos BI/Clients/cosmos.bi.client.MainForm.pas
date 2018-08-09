unit cosmos.bi.client.MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, SynCommons, mORMot,
  mORMotHttpClient, FMX.StdCtrls, FMX.Layouts, FMX.Memo,
  FMX.ListBox, System.Actions, FMX.ActnList, FMX.ListView.Types, FMX.ListView;

type
  TFrmMain = class(TForm)
    Button1: TButton;
    CbxFocosId: TComboBox;
    CbxFocos: TComboBox;
    ActionList1: TActionList;
    ActConnect: TAction;
    ActDisconnect: TAction;
    LsvPupils: TListView;
    procedure FormCreate(Sender: TObject);
    procedure CbxFocosChange(Sender: TObject);
    procedure ActConnectExecute(Sender: TObject);
    procedure ActDisconnectExecute(Sender: TObject);
  private
    { Private declarations }
    function GetCurrentFocusId: integer;
    procedure LoadActiveFocus;
    procedure LoadPupils;


  public
    { Public declarations }
    property CurrentFocusId: integer read GetCurrentFocusId;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}

uses cosmos.bi.client.model;

procedure TFrmMain.ActConnectExecute(Sender: TObject);
begin
  DMModel.ConnectServer;

  if DMModel.Client <> nil then
   LoadActiveFocus;

  ShowMessage(DateTimeToStr(DMModel.ServerDateTime));
end;

procedure TFrmMain.ActDisconnectExecute(Sender: TObject);
begin
 DMModel.DisconnectServer;
end;

procedure TFrmMain.CbxFocosChange(Sender: TObject);
begin
 CbxFocosId.ItemIndex := CbxFocos.ItemIndex;
 LoadPupils;
end;


procedure TFrmMain.FormCreate(Sender: TObject);
begin
 CbxFocosId.Visible := False;
end;

function TFrmMain.GetCurrentFocusId: integer;
begin
 Result :=  CbxFocosId.ItemIndex;
end;

procedure TFrmMain.LoadActiveFocus;
var
 aTable: TSQLTableJson;
begin
 //Lista os focos ativos existentes em um JSON.
 aTable := DMModel.LoadActiveFocus;

 if aTable = nil then
	Exit;

 CbxFocosId.Items.Clear;
 CbxFocos.Items.Clear;

 try
   while aTable.Step do
    begin
     CbxFocosId.Items.Append(aTable.Field(0));
     CbxFocos.Items.Append(aTable.Field(1));
    end;

 finally
   atable.Free;
 end;
end;

procedure TFrmMain.LoadPupils;
var
 aTable: TSQLTableJson;
 aItem: TListViewItem;
begin
 //Lista os alunos ativos existentes em um JSON.
 aTable := DMModel.ListPupils(CurrentFocusId);

 if aTable = nil then
	Exit;

 LsvPupils.ClearItems;

 try
   while aTable.Step do
    begin
     aItem := LsvPupils.Items.Add;
     aItem.Text := aTable.Field(2)
    end;

 finally
   atable.Free;
 end;
end;

end.
