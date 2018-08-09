unit cosmos.common.view.linesprop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin;

type
  TFrmLinesProp = class(TForm)
    Label1: TLabel;
    LblLineName: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    CBXFontes: TComboBox;
    EdtFontSize: TSpinEdit;
    Label3: TLabel;
    ChkBold: TCheckBox;
    ChkItalic: TCheckBox;
    Bevel2: TBevel;
    EdtPosLeft: TSpinEdit;
    Label4: TLabel;
    EdtPosTop: TSpinEdit;
    Label5: TLabel;
    Bevel3: TBevel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ListFonts;

  public
    { Public declarations }
    function SetLineProperties(const Properties: string): string;
  end;

var
  FrmLinesProp: TFrmLinesProp;

implementation

{$R *.dfm}

{ TFrmLinesProp }

procedure TFrmLinesProp.FormCreate(Sender: TObject);
begin
 ListFonts;
end;

procedure TFrmLinesProp.ListFonts;
begin
 CBxFontes.Items.Assign(Screen.Fonts);
end;

function TFrmLinesProp.SetLineProperties(const Properties: string): string;
var
 aProperties: TStringList;
 aValue: string;
begin
 aProperties := TStringList.Create;
 aProperties.Delimiter := ';';

 try
   aProperties.DelimitedText := Properties;
   //FontName
   aValue := aProperties.Values['FontName'];
   CBxFontes.Text := aValue;

   //FontSize
   aValue := aProperties.Values['FontSize'];
   EdtFontSize.Value := aValue.ToInteger;

   //PosLeft
   aValue := aProperties.Values['PosLeft'];
   EdtPosLeft.Value := aValue.ToInteger;

   //PosTop
   aValue := aProperties.Values['PosTop'];
   EdtPosTop.Value := aValue.ToInteger;

   if ShowModal = mrOK then
    begin
      aProperties.Values['FontName'] := CBXFontes.Text;
      aProperties.Values['FontSize'] := EdtFontSize.Text;
      if ChkBold.Checked then aProperties.Values['FontBold'] := 'True'
      else
       aProperties.Values['FontBold'] := 'False';

      if ChkItalic.Checked then aProperties.Values['FontItalic'] := 'True'
      else
       aProperties.Values['FontItalic'] := 'False';

      aProperties.Values['PosLeft'] := EdtPosLeft.Text;
      aProperties.Values['PosTop'] := EdtPosTop.Text;
    end;

 finally
   Result := aProperties.DelimitedText;
   aProperties.Free;
 end;
end;

end.
