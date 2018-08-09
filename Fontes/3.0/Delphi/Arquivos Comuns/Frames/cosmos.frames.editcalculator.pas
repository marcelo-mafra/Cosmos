unit cosmos.frames.editcalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  cosmos.system.messages;

type
  TCreateCalculator = function(var CalcValue: double): boolean; stdcall;

  EDllError = class(Exception);     

  TFmeCalculator = class(TFrame)
    SpeedButton1: TSpeedButton;
    EdtValue: TEdit;
    procedure EdtValueKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtValueKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetValue: double;
    { Private declarations }
    function GetButtonEnabled: boolean;
    procedure SetButtonEnabled(const Value: boolean);

    procedure SetValue(const Value: double); inline;

  public
    { Public declarations }
    procedure DoClick;
    property ButtonEnabled: boolean read GetButtonEnabled write SetButtonEnabled;
    property Value: double read GetValue;    
  end;

implementation

{$R *.dfm}

{ TFmeCalculator }

procedure TFmeCalculator.DoClick;
begin
 SpeedButton1.Click;
end;

procedure TFmeCalculator.EdtValueKeyPress(Sender: TObject; var Key: Char);
begin
if CharInSet(Key, ['0'..'9',',']) then
  Abort;
end;

procedure TFmeCalculator.EdtValueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  DoClick;
end;

function TFmeCalculator.GetButtonEnabled: boolean;
begin
 Result := SpeedButton1.Enabled;
end;

function TFmeCalculator.GetValue: double;
begin
 if Trim(EdtValue.Text) = '' then
  Result := 0
 else
  Result := StrToFloat(EdtValue.Text);
end;

procedure TFmeCalculator.SetButtonEnabled(const Value: boolean);
begin
 SpeedButton1.Enabled := Value;
end;

procedure TFmeCalculator.SetValue(const Value: double);
begin
 EdtValue.Text := FloatToStr(Value);
end;

procedure TFmeCalculator.SpeedButton1Click(Sender: TObject);
var
H: THandle;
Value: double;
CreateCalculator: TCreateCalculator;
begin
{Carrega a calaculadora que está dentro da dll calc.dll. O variável "Value"
está aqui só para indicar que ela pode ser atribuída ao valor de retorno da
função. Apesar de não usarmos isto para nada neste programa, quis deixar aí para
indicar que é possível usá-la.}
{ try
 H := LoadLibrary('calc.dll');
 if H = 0 then
  raise EDLLError.Create(TCosmosErrorMsg.DllCalculator);

  @CreateCalculator := GetProcAddress(H,'CreateCalculator');
  if not (@CreateCalculator = nil) then
   begin
    if CreateCalculator(Value) then
    SetValue(Value);
   end
  else
   RaiseLastOSError;

 finally
  if H <> 0 then
   FreeLibrary(H);
 end;}
end;

end.
