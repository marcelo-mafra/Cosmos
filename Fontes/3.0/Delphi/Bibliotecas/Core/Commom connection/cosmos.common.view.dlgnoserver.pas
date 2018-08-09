unit cosmos.common.view.dlgnoserver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmDlgNoServer = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDlgNoServer: TFrmDlgNoServer;

implementation

{$R *.dfm}


procedure TFrmDlgNoServer.Button2Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmDlgNoServer.FormCreate(Sender: TObject);
begin
Font.Name := Application.MainForm.Font.Name;
end;

end.
