unit Cosmos.Common.View.FormCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFrmCalendar = class(TForm)
    Calendar: TMonthCalendar;
    ChkExtenso: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CalendarDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ShowCalendar(var SelDate: TDate): boolean; overload;
    function ShowCalendar: variant; overload;
  end;

var
  FrmCalendar: TFrmCalendar;

implementation

{$R *.dfm}

{ TFrmCalendar }

function TFrmCalendar.ShowCalendar(var SelDate: TDate): boolean;
begin
 Result := False;

 Result := ShowModal = mrOk;
 if Result then
   SelDate := Calendar.Date
end;

procedure TFrmCalendar.CalendarDblClick(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TFrmCalendar.FormCreate(Sender: TObject);
begin
 Calendar.Date := Now;
end;

function TFrmCalendar.ShowCalendar: variant;
begin
 Result := null;
 if FrmCalendar.ShowModal = mrOk then
  Result := FormatDateTime('dd/mm/yyyy', Calendar.Date);
end;

end.
