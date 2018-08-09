unit cosmos.server.tools.mainstarter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFrmMainStarter = class(TForm)
    TrayIcon: TTrayIcon;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMainStarter: TFrmMainStarter;

implementation

{$R *.dfm}

uses cosmos.server.tools.dmstarter;

procedure TFrmMainStarter.FormCreate(Sender: TObject);
begin
  TrayIcon.Hint := DMStarter.Hint;
  TrayIcon.Visible := True;
end;

end.
