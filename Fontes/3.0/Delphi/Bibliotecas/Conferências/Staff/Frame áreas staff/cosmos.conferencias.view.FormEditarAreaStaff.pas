unit cosmos.conferencias.view.FormEditarAreaStaff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmEditarAreaStaff = class(TForm)
    EdtArea: TEdit;
    Label1: TLabel;
    BtnOK: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure EdtAreaChange(Sender: TObject);
    procedure EdtAreaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtAreaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    function EditarArea(var Area: string): boolean;
  end;

var
  FrmEditarAreaStaff: TFrmEditarAreaStaff;

implementation

{$R *.dfm}

{ TFrmEditarAreaStaff }

function TFrmEditarAreaStaff.EditarArea(var Area: string): boolean;
begin
 EdtArea.Text := Area;
 Result := ShowModal = mrOk;
 if Result then
  Area := EdtArea.Text;
end;

procedure TFrmEditarAreaStaff.EdtAreaChange(Sender: TObject);
begin
 BtnOK.Enabled := Trim(EdtArea.Text) <> '';
end;

procedure TFrmEditarAreaStaff.EdtAreaKeyPress(Sender: TObject; var Key: Char);
begin
//Aborta a inserção do delimitador de strings.
 if Key = '''' then
  Abort;
end;

procedure TFrmEditarAreaStaff.EdtAreaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = 13) and (Trim(EdtArea.Text) <> '') then
  BtnOk.Click;
end;

end.
