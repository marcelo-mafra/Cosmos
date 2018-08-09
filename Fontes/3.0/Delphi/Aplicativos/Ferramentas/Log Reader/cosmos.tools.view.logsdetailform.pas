unit cosmos.tools.view.logsdetailform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.tools.view.logs.interfaces,
  Vcl.StdCtrls, cosmos.classes.application, System.Actions, Vcl.ActnList, Vcl.ImgList,
  Vcl.Buttons;

type
  TFrmLogsDetail = class(TForm)
    EdtDateTime: TEdit;
    Label1: TLabel;
    EdtGenerator: TEdit;
    Label2: TLabel;
    EdtType: TEdit;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ImageList1: TImageList;
    ActionList1: TActionList;
    SpeedButton1: TSpeedButton;
    ActPrior: TAction;
    ActNext: TAction;
    SpeedButton2: TSpeedButton;
    MmoDetails: TMemo;
    MmoInfo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActNextExecute(Sender: TObject);
    procedure ActPriorExecute(Sender: TObject);
  private
    { Private declarations }
    FCosmosLogs: ICosmosLogsInterface;

    procedure LoadInfo(AData: TCosmosData); inline;

  public
    { Public declarations }
    procedure ShowLog(AData: TCosmosData);
  end;

var
  FrmLogsDetail: TFrmLogsDetail;

implementation

{$R *.dfm}

procedure TFrmLogsDetail.ActNextExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 AData := FCosmosLogs.NextLog;
 LoadInfo(AData);
end;

procedure TFrmLogsDetail.ActPriorExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 AData := FCosmosLogs.PriorLog;
 LoadInfo(AData);
end;

procedure TFrmLogsDetail.FormCreate(Sender: TObject);
begin
  FCosmosLogs := Application.MainForm as ICosmosLogsInterface;
end;

procedure TFrmLogsDetail.FormDestroy(Sender: TObject);
begin
 if FCosmosLogs <> nil then
  FCosmosLogs := nil;
end;

procedure TFrmLogsDetail.LoadInfo(AData: TCosmosData);
var
 AContextInfo: TStringList;
begin
 if AData <> nil then
  begin
    AContextInfo := TStringList.Create;
    AContextInfo.Delimiter := ';';
    AContextInfo.QuoteChar := '"';

    try
      EdtDateTime.Text := AData.FindValue('LOGDATE');
      EdtGenerator.Text := AData.FindValue('LOGGEN');
      EdtType.Text := AData.FindValue('LOGTYPE');
      MmoInfo.Text := AData.FindValue('LOGINFO');
      AContextInfo.CommaText :=  AData.FindValue('LOGCONTEXT');
      MmoDetails.Lines.Assign(AContextInfo);

    finally
     AData.Free;
     AContextInfo.Free;
    end;
  end;
end;

procedure TFrmLogsDetail.ShowLog(AData: TCosmosData);
begin
 LoadInfo(AData);
 ShowModal;
end;

end.
