unit FormDlgCopyMembro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFrmDlgConfCopy = class(TForm)
    RdbCopy: TRadioButton;
    RdbMove: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDlgConfCopy: TFrmDlgConfCopy;

implementation

{$R *.dfm}

end.
