unit cosmos.common.view.FormLocate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  ValueComboBox, GroupHeader, Data.DB, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.framework.datanavigators.datasets,
  cosmos.framework.datanavigators.treeview, cosmos.system.messages;

type
  TFrmLocate = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    CbxFields: TValueComboBox;
    MSGroupHeader2: TMSGroupHeader;
    Label1: TLabel;
    EdtArgument: TEdit;
    Label2: TLabel;
    Image1: TImage;
    BtnLocate: TButton;
    Button2: TButton;
    Button3: TButton;
    ChkPartialKey: TCheckBox;
    ChkCaseInsensitive: TCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtArgumentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnLocateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FDataset: TDataset;
    FIRemoteCon: ICosmosRemoteConnection;
    procedure SetDataset(const Value: TDataset);
    procedure ListDatasetFields;

  public
    { Public declarations }
    property Dataset: TDataset read FDataset write SetDataset;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;
  end;

var
  FrmLocate: TFrmLocate;

implementation

{$R *.dfm}

{ TFrmLocate }

procedure TFrmLocate.BtnLocateClick(Sender: TObject);
var
FieldName: string;
AArguments: TCosmosData;
begin
 if EdtArgument.Text = '' then
  Abort;

 try
  if IRemoteCon.ActiveDataNavigator is TDatasetDataNavigator then
   begin
    if CbxFields.ItemIndex < 0 then
     Abort;

    FieldName := CBxFields.GetValue;

    AArguments := TCosmosData.Create(4);
    //do not localize!
    AArguments.Add('SearchField', FieldName);
    AArguments.Add('SearchArgument', EdtArgument.Text);
    AArguments.Add('CaseInsensitive', ChkCaseInsensitive.Checked);
    AArguments.Add('PartialKey', ChkPartialKey.Checked);

    TDatasetDataNavigator(IRemoteCon.ActiveDataNavigator).LocateData(AArguments);
   end;

 if IRemoteCon.ActiveDataNavigator is TTreeviewDataNavigator then
  begin
   AArguments := TCosmosData.Create(1);
   AArguments.Add('TextValue', EdtArgument.Text);
   TTreeviewDataNavigator(IRemoteCon.ActiveDataNavigator).LocateData(AArguments);
  end;

 finally
  if Assigned(AArguments) then
   AArguments.Free;
 end;
end;

procedure TFrmLocate.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TFrmLocate.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmLocate.EdtArgumentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  BtnLocate.Click;
end;

procedure TFrmLocate.FormCreate(Sender: TObject);
begin
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
end;

procedure TFrmLocate.ListDatasetFields;
var
I: integer;
Field: TField;
begin
 if Assigned(Dataset) then
  begin
   CbxFields.Clear;
   CbxFields.ClearValues;

   for I := 0 to Pred(Dataset.Fields.Count) do
    begin
     Field := Dataset.Fields.Fields[I];

     if not Field.IsBlob then
      if Field.Visible then
        begin
         CBXFields.Items.Add(Field.DisplayLabel);
         CbxFields.Values.Add(Field.FieldName);
        end;
    end;
   if CBXFields.Items.Count > 0 then
    CBXFields.ItemIndex := 0;
  end
 else
  CBXFields.Enabled := False;
end;

procedure TFrmLocate.SetDataset(const Value: TDataset);
begin
 if Value <> FDataset then
  begin
   FDataset := Value;
   if (Dataset <> nil) and (Dataset.Active) then
    ListDatasetFields;
  end;
end;



end.
