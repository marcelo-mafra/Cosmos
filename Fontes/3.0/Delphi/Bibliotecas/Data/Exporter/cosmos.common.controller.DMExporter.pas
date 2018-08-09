unit cosmos.common.controller.DMExporter;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, cosmos.framework.interfaces.dataacess,
  cosmos.system.messages, cosmos.framework.interfaces.root, Data.DB, System.Variants;

type
  TDMExporter = class(TDataModule, ICosmosExporter)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure CallEvent(Dataset: TDataset);

  protected
    procedure ExportToTXT(Dataset: TDataset; const FileName: string);
    procedure ExportToXML(Dataset: TDataset; const FileName: string);
    procedure ExportToMSWord(Dataset: TDataset; const FileName: string);
    procedure ExportToMSExcel(Dataset: TDataset; const FileName: string);
    procedure ExportToCSV(Dataset: TDataset; const FileName: string);
    procedure ExportToHTML(Dataset: TDataset; const FileName: string);
    procedure ExportToOpenOffice(Dataset: TDataset; const FileName: string);

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;

  end;

var
  DMExporter: TDMExporter;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses cosmos.framework.dataexporter;

{$R *.dfm}

{ TDMExporter }

procedure TDMExporter.CallEvent(Dataset: TDataset);
begin
  with ICosmosApp.Components do
   begin
    try
     ProgressBar.Visible := True;
     ProgressBar.MaxPosition := Dataset.RecordCount;
     ProgressBar.Position := Dataset.RecNo;
     Application.ProcessMessages;

    finally
     if ProgressBar.Position = ProgressBar.MaxPosition then
      begin
       ProgressBar.Visible := False;
       ProgressBar.Position := 0;
      end;
    end;
   end;
end;

procedure TDMExporter.DataModuleCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
end;

procedure TDMExporter.DataModuleDestroy(Sender: TObject);
begin
 if Assigned(ICosmosApp) then
  FICosmosApp := nil;
end;

procedure TDMExporter.ExportToCSV(Dataset: TDataset; const FileName: string);
var
 AExporter: TDataExporter;
begin
 AExporter := TDataExporter.Create;
 AExporter.OnProgressEvent := CallEvent;

 try
  AExporter.ToCSV(Dataset, FileName);
  if Assigned(AExporter) then
   FreeAndNil(AExporter);

 except
  if Assigned(AExporter) then FreeAndNil(AExporter);
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportData);
 end;
end;

procedure TDMExporter.ExportToHTML(Dataset: TDataset; const FileName: string);
var
 AExporter: TDataExporter;
begin
 AExporter := TDataExporter.Create;
 AExporter.OnProgressEvent := CallEvent;

 try
  AExporter.ToHTML(Dataset, FileName);

  if Assigned(AExporter) then
    FreeAndNil(AExporter);

 except
  if Assigned(AExporter) then FreeAndNil(AExporter);
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportData);
 end;

end;

procedure TDMExporter.ExportToMSExcel(Dataset: TDataset; const FileName: string);
var
 AExporter: TDataExporter;
begin
 AExporter := TDataExporter.Create;
 AExporter.OnProgressEvent := CallEvent;

 try
  AExporter.ToExcel(Dataset, FileName);
  if Assigned(AExporter) then
   FreeAndNil(AExporter);

 except
  if Assigned(AExporter) then FreeAndNil(AExporter);
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportData);
 end;
end;

procedure TDMExporter.ExportToMSWord(Dataset: TDataset; const FileName: string);
var
 AExporter: TDataExporter;
begin
 AExporter := TDataExporter.Create;
 AExporter.OnProgressEvent := CallEvent;

 try
  AExporter.ToWord(Dataset, FileName);
  if Assigned(AExporter) then
   FreeAndNil(AExporter);

 except
  if Assigned(AExporter) then FreeAndNil(AExporter);
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportData);
 end;
end;

procedure TDMExporter.ExportToOpenOffice(Dataset: TDataset;
  const FileName: string);
var
 AExporter: TDataExporter;
begin
 AExporter := TDataExporter.Create;
 AExporter.OnProgressEvent := CallEvent;

 try
  AExporter.ToOpenOffice(Dataset, FileName);

  if Assigned(AExporter) then
   FreeAndNil(AExporter);

 except
  if Assigned(AExporter) then FreeAndNil(AExporter);
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportData);
 end;
end;

procedure TDMExporter.ExportToTXT(Dataset: TDataset; const FileName: string);
var
 AExporter: TDataExporter;
begin
 AExporter := TDataExporter.Create;
 AExporter.OnProgressEvent := CallEvent;

 try
  AExporter.ToTXT(Dataset, FileName);
  if Assigned(AExporter) then
   FreeAndNil(AExporter);

 except
  if Assigned(AExporter) then FreeAndNil(AExporter);
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportData);
 end;
end;

procedure TDMExporter.ExportToXML(Dataset: TDataset; const FileName: string);
var
 AExporter: TDataExporter;
begin
 AExporter := TDataExporter.Create;
 AExporter.OnProgressEvent := CallEvent;

 try
  AExporter.ToXML(Dataset, FileName);
  if Assigned(AExporter) then
   FreeAndNil(AExporter);

 except
  if Assigned(AExporter) then FreeAndNil(AExporter);
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportData);
 end;
end;



initialization
 RegisterClass(TDMExporter);

finalization
 UnRegisterClass(TDMExporter);

end.
