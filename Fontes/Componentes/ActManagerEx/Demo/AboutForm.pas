unit AboutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmAbout = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lArticleLink: TLabel;
    procedure lArticleLinkMouseLeave(Sender: TObject);
    procedure lArticleLinkMouseEnter(Sender: TObject);
    procedure lArticleLinkClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure Execute;
  end;

var
  frmAbout: TfrmAbout;

implementation

uses
    ShellAPI
  ;

{$R *.dfm}

{ TfrmAbout }

procedure TfrmAbout.Button1Click(Sender: TObject);
begin
  close;
end;

class procedure TfrmAbout.Execute;
var
  lDlg: TfrmAbout;
begin
  lDlg := TfrmAbout.Create(nil);
  try
    lDlg.ShowModal;
  finally
    lDlg.Free;
  end;
end;

procedure TfrmAbout.lArticleLinkClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(TLabel(Sender).Caption), nil, nil, SW_NORMAL);
end;

procedure TfrmAbout.lArticleLinkMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsUnderline];
end;

procedure TfrmAbout.lArticleLinkMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
end;

end.
