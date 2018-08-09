unit cosmos.common.view.updaterothersconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, GroupHeader;

type
  TFrmOpcoesAvancadas = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    SbnLogDialog: TSpeedButton;
    Label1: TLabel;
    ChkHasLog: TCheckBox;
    EdtLogFileName: TEdit;
    DlgOpen: TOpenDialog;
    procedure SbnLogDialogClick(Sender: TObject);
    procedure ChkHasLogClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOpcoesAvancadas: TFrmOpcoesAvancadas;

implementation

{$R *.dfm}

procedure TFrmOpcoesAvancadas.ChkHasLogClick(Sender: TObject);
begin
 EdtLogFileName.Enabled := TCheckBox(Sender).Checked;
 SbnLogDialog.Enabled := EdtLogFileName.Enabled;
end;

procedure TFrmOpcoesAvancadas.SbnLogDialogClick(Sender: TObject);
begin
  if DlgOpen.Execute then
  EdtLogFileName.Text := DlgOpen.FileName;
end;

end.
