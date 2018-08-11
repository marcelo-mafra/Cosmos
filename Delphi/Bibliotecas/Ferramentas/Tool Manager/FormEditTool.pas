unit FormEditTool;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmEditTool = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EdtFerramenta: TEdit;
    EdtFile: TEdit;
    BtnOK: TButton;
    Button2: TButton;
    Button3: TButton;
    SpeedButton1: TSpeedButton;
    DlgOpen: TOpenDialog;
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtFerramentaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEditTool: TFrmEditTool;

implementation

{$R *.dfm}

procedure TFrmEditTool.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmEditTool.EdtFerramentaChange(Sender: TObject);
begin
 BtnOK.Enabled := (Trim(EdtFerramenta.Text) <> '') and
  (Trim(EdtFile.Text) <> '');
end;

procedure TFrmEditTool.SpeedButton1Click(Sender: TObject);
begin
 if DlgOpen.Execute then
  EdtFile.Text := DlgOpen.FileName;
end;

end.
