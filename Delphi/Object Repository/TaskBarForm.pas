unit TaskBarForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFrmTaskBar = class(TForm)
  private
    { Private declarations }
 protected
    procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public declarations }
  end;

var
  FrmTaskBar: TFrmTaskBar;

implementation

{$R *.dfm}

{ TFrmTaskBar }

procedure TFrmTaskBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

end.
