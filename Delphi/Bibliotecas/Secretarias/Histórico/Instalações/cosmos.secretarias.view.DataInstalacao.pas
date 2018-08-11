unit cosmos.secretarias.view.DataInstalacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFrmDataInstalacao = class(TForm)
    Label1: TLabel;
    EdtTurma: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Calendar: TMonthCalendar;
  private
    { Private declarations }
  public
    { Public declarations }
    function ShowCalendar(const Turma: string; DefaultDate: TDateTime): variant;
  end;

var
  FrmDataInstalacao: TFrmDataInstalacao;

implementation

{$R *.dfm}

function TFrmDataInstalacao.ShowCalendar(const Turma: string;
  DefaultDate: TDateTime): variant;
begin
 EdtTurma.Text := Turma;
 Calendar.Date := DefaultDate;
 Calendar.MaxDate := DefaultDate;
 if ShowModal = mrOk then
  Result := Calendar.Date
 else
  Result := unassigned; 
end;

end.
