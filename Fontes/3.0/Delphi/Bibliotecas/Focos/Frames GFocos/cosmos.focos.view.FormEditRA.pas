unit cosmos.focos.view.FormEditRA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFrmDlgEditRA = class(TForm)
    EdtRa: TEdit;
    Label1: TLabel;
    BtnOK: TButton;
    Button2: TButton;
    Image1: TImage;
    Button3: TButton;
    procedure EdtRaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtRaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   function InputRA(const RA, ACaption: string): string;
  end;

var
  FrmDlgEditRA: TFrmDlgEditRA;

implementation

{$R *.dfm}

{ TFrmDlgEditRA }


procedure TFrmDlgEditRA.EdtRaChange(Sender: TObject);
begin
 BtnOK.Enabled := Trim(EdtRA.Text) <> '';
end;

function TFrmDlgEditRA.InputRA(const RA, ACaption: string): string;
begin
 Caption := ACaption;
 EdtRa.Text := RA;
 if ShowModal = mrOk then
  Result := EdtRA.Text
 else
  Result := '';
end;

procedure TFrmDlgEditRA.EdtRaKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = #13) and (BtnOk.Enabled) then
  BtnOk.Click;
end;

end.
