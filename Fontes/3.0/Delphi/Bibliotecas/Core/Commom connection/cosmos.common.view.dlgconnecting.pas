unit cosmos.common.view.dlgconnecting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmConnecting = class(TForm)
    Panel1: TPanel;
    LblMessage: TLabel;
    ImgConnecting: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WriteMessage(const Message: string);
  end;

var
  FrmConnecting: TFrmConnecting;

implementation

{$R *.DFM}

procedure TFrmConnecting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
FrmConnecting := nil;
end;

procedure TFrmConnecting.FormCreate(Sender: TObject);
begin
Font.Name := Application.MainForm.Font.Name;
ImgConnecting.Update;
end;

procedure TFrmConnecting.WriteMessage(const Message: string);
begin
 LblMessage.Caption := Message;
 LblMessage.Update;
end;

end.
