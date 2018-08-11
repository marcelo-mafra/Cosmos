unit Cosmos.Common.View.FormInputString;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFrmInputString = class(TForm)
    EdtInfo: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Image1: TImage;
    LblLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function InputData(const Caption, LabelInfo: string; MaxLength: integer): string;
  end;

var
  FrmInputString: TFrmInputString;

implementation

{$R *.dfm}

{ TFrmInputString }

function TFrmInputString.InputData(const Caption, LabelInfo: string;
  MaxLength: integer): string;
begin
 self.Caption := Caption;
 LblLabel.Caption := LabelInfo;
 EdtInfo.MaxLength := MaxLength;
 Result := '';
 if ShowModal = mrOk then
  Result := EdtInfo.Text;

end;

end.
