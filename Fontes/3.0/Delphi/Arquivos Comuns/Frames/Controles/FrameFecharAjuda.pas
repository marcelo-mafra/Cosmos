unit FrameFecharAjuda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons;

type
  TFmeFecharAjuda = class(TFrame)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFmeFecharAjuda.BitBtn1Click(Sender: TObject);
var
AForm: TForm;
begin
 AForm := Screen.ActiveForm;

 if AForm <> nil then
  begin
   if AForm.HelpContext <> 0 then
    Application.HelpSystem.ShowContextHelp(AForm.HelpContext, Application.CurrentHelpFile);
  end;
end;

end.
