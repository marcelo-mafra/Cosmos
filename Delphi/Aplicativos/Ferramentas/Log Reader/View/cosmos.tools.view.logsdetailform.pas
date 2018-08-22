unit cosmos.tools.view.logsdetailform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.tools.view.logs.interfaces,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Vcl.ImgList,
  Vcl.Buttons, System.ImageList, cosmos.tools.controller.logsint;

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
    FLogInfo: IControllerLogInfo;
    procedure LoadInfo; inline;

  public
    { Public declarations }
    procedure ShowLog(Data: IControllerLogInfo);
  end;

var
  FrmLogsDetail: TFrmLogsDetail;

implementation

{$R *.dfm}

procedure TFrmLogsDetail.ActNextExecute(Sender: TObject);
begin
 FLogInfo := FCosmosLogs.NextLog;
 LoadInfo;
end;

procedure TFrmLogsDetail.ActPriorExecute(Sender: TObject);
begin
 FLogInfo := FCosmosLogs.PriorLog;
 LoadInfo;
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

procedure TFrmLogsDetail.LoadInfo;
var
AContextInfo: TStringList;
begin
 if FLogInfo <> nil then
  begin
    AContextInfo := TStringList.Create;

    try
      EdtDateTime.Text := DateTimeToStr(FLogInfo.Data);
      EdtGenerator.Text := FLogInfo.Source;
      //EdtType.Text := AData.FindValue('LOGTYPE');
      MmoInfo.Text := FLogInfo.Info;
      AContextInfo.CommaText :=  FLogInfo.Context;
      MmoDetails.Lines.Assign(AContextInfo);

    finally
     AContextInfo.Free;
    end;
  end;
end;

procedure TFrmLogsDetail.ShowLog(Data: IControllerLogInfo);
begin
 FLogInfo := Data;
 LoadInfo;
 ShowModal;
end;

end.
