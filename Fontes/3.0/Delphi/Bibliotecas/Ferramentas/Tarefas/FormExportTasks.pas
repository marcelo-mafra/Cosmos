unit FormExportTasks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, ComCtrls, ImgList,
  cosmos.framework.interfaces.root, cosmos.core.classes, cosmos.core.ConstantesMsg;

type
  TExportFormat = (efCSV, efXML);

  TFrmExportTasks = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    MSGroupHeader3: TMSGroupHeader;
    BtnExport: TButton;
    Button2: TButton;
    RdbExportTaskList: TRadioButton;
    RdbExportAllTasks: TRadioButton;
    RdbExportPendentesTasks: TRadioButton;
    RdbExportCSV: TRadioButton;
    RdbExportXML: TRadioButton;
    RdbExportConcludeds: TRadioButton;
    EdtFileName: TButtonedEdit;
    Image1: TImage;
    ImageList1: TImageList;
    DlgSave: TSaveDialog;
    procedure RdbExportCSVClick(Sender: TObject);
    procedure RdbExportXMLClick(Sender: TObject);
    procedure BtnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EdtFileNameChange(Sender: TObject);
    procedure EdtFileNameRightButtonClick(Sender: TObject);
  private
    { Private declarations }
   FSource : TListView;
   FExportFormat: TExportFormat;

   procedure SetSource(Value: TListView);
   function DoSaveFile(const FileName: string; AList: TStringList): boolean;

   procedure ExportDataToCSV(ATaskList: TListView; const FileName: string);
   procedure ExportDataToXML(ATaskList: TListView; const FileName: string);


  public
    { Public declarations }
    property Source: TListView read FSource write SetSource;

  end;

var
  FrmExportTasks: TFrmExportTasks;

implementation

{$R *.dfm}

{ TFrmExportTasks }

procedure TFrmExportTasks.BtnExportClick(Sender: TObject);
begin
 case FExportFormat of
   efCSV: ExportDataToCSV(Source, EdtFileName.Text);
   efXML: ExportDataToXML(Source, EdtFileName.Text);
 end;
end;

procedure TFrmExportTasks.Button2Click(Sender: TObject);
begin
 Close;
end;

function TFrmExportTasks.DoSaveFile(const FileName: string;
  AList: TStringList): boolean;
var
AMessage: TMessageData;
ICosmosApp: ICosmosApplication;
begin
 try
  AList.SaveToFile(FileName);
  Result := True;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp := Application.MainForm as ICosmosApplication;
    AMessage := ICosmosApp.CreateMessageData(sErrorExportDataToFile, sTitleTasksTool, mtpError);
    AMessage.SetMessageInfo(miInnerMessage, E.Message);
    AMessage.SetMessageInfo(miExceptionClassName, E.ClassName);
    AMessage.SetMessageInfo(miCustomInfo, FileName);
    ICosmosApp.DlgMessage.Execute(AMessage);

    if Assigned(ICosmosApp) then ICosmosApp := nil;
   end;
 end;
end;

procedure TFrmExportTasks.EdtFileNameChange(Sender: TObject);
begin
 BtnExport.Enabled := Trim(EdtFileName.Text) <> '';
end;

procedure TFrmExportTasks.EdtFileNameRightButtonClick(Sender: TObject);
begin
 if DlgSave.Execute then
  EdtFileName.Text := DlgSave.FileName;
end;

procedure TFrmExportTasks.ExportDataToCSV(ATaskList: TListView;
  const FileName: string);
var
 Item: TListItem;
 I, Index: Integer;
 AFile: TStringList;
 ALine: String;
begin
 (* initialize a TStringList *)
 AFile := TStringList.Create;

 try
  (* loop to get all items of ATaskList *)
  for Index := 0 to ATaskList.Items.Count -1 do
   begin
    (* store the current Item in a local variable *)
    Item := ATaskList.Items[Index];
    (* format the current line of the CSV *)
    ALine := Item.Caption + ';';

    for I := 0 to Item.SubItems.Count - 1 do
      begin
       ALine := ALine + TrimRight(Item.SubItems.Strings[I]);
       if I < Pred(Item.SubItems.Count) then
        ALine := ALine + ';';
      end;

   // ALine := Format('%s;%s', [Item.Caption, Item.SubItems.CommaText]);
   (* add the line to CSV *)
    AFile.Append(ALine);
   end;

  (* save the CSV file *)
  self.DoSaveFile(FileName, AFile)

 finally
  (* free AFile variable *)
  if Assigned(AFile) then
   FreeAndNil(AFile);
 end;
end;

procedure TFrmExportTasks.ExportDataToXML(ATaskList: TListView;
  const FileName: string);
var
 Item: TListItem;
 Index: Integer;
 AXML: TStringList;
begin
 (* initialize a TStringList *)
 AXML := TStringList.Create;

 try
  AXML.Append('<?xml version="1.0" encoding="utf-16"?>'); //do not localize!
  AXML.Append('<CosmosData>'); //do not localize!

  (* loop to get all items of ATaskList *)
  for Index := 0 to ATaskList.Items.Count -1 do
   begin
    (* store the current Item in a local variable *)
    Item := ATaskList.Items[Index];
    (* format the current line of the CSV *)
    AXML.Append(' <Line>'); //do not localize!

    AXML.Append(Format('    <TaskName>%s</TaskName>', [Item.Caption])); //do not localize!
    AXML.Append(Format('    <Creator>%s</Creator>', [Item.SubItems.Strings[0]])); //do not localize!
    AXML.Append(Format('    <Date>%s</Date>', [Item.SubItems.Strings[1]])); //do not localize!
    AXML.Append(Format('    <GoalDate>%s</GoalData>', [Item.SubItems.Strings[2]])); //do not localize!
    AXML.Append(Format('    <Status>%s</Status>', [Item.SubItems.Strings[3]])); //do not localize!
    AXML.Append(Format('    <Category>%s</Category>', [Item.SubItems.Strings[4]])); //do not localize!
    AXML.Append(Format('    <Priority>%s</Priority>', [Item.SubItems.Strings[5]])); //do not localize!
    AXML.Append(Format('    <EndDate>%s</EndDate>', [Item.SubItems.Strings[6]])); //do not localize!
    AXML.Append(Format('    <Module>%s</Module>', [Item.SubItems.Strings[7]])); //do not localize!
    AXML.Append(Format('    <Notes>%s</Notes>', [TrimRight(Item.SubItems.Strings[8])])); //do not localize!

    AXML.Append(' </Line>'); //do not localize!
   end;

  AXML.Append('</CosmosData>'); //do not localize!

  self.DoSaveFile(FileName, AXML)

 finally
  (* free AXML variable *)
  if Assigned(AXML) then
   FreeAndNil(AXML);
 end;

end;

procedure TFrmExportTasks.FormCreate(Sender: TObject);
begin
 FExportFormat := efCSV;
end;

procedure TFrmExportTasks.RdbExportCSVClick(Sender: TObject);
begin
 FExportFormat := efCSV;
 DlgSave.FilterIndex := 1;
end;

procedure TFrmExportTasks.RdbExportXMLClick(Sender: TObject);
begin
 FExportFormat := efXML;
 DlgSave.FilterIndex := 2;
end;

procedure TFrmExportTasks.SetSource(Value: TListView);
begin
 FSource := Value;
end;

end.
