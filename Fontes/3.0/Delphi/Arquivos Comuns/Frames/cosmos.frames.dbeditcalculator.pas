unit cosmos.frames.dbeditcalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Mask, Data.DB, Vcl.DBCtrls, cosmos.system.messages;

type
  TCreateCalculator = function(AHelpContext: LongInt;
     var CalcValue: double): boolean; stdcall;

  EDllError = class(Exception);

  TFmeDBCalculator = class(TFrame)
    DBEdit1: TDBEdit;
    SpeedButton1: TSpeedButton;
    procedure DBEdit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    function GetButtonEnabled: boolean;
    procedure SetButtonEnabled(const Value: boolean);
    { Private declarations }
    procedure SetValue(const Value: double); inline;
  public
    { Public declarations }
    procedure DoClick;
    property ButtonEnabled: boolean read GetButtonEnabled write SetButtonEnabled;
  end;

implementation

{$R *.dfm}

procedure TFmeDBCalculator.DBEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  DoClick;
end;

procedure TFmeDBCalculator.DoClick;
begin
 SpeedButton1.Click;
end;

function TFmeDBCalculator.GetButtonEnabled: boolean;
begin
 Result := SpeedButton1.Enabled;
end;

procedure TFmeDBCalculator.SetButtonEnabled(const Value: boolean);
begin
 SpeedButton1.Enabled := Value;
end;

procedure TFmeDBCalculator.SetValue(const Value: double);
var
 Ds: TDataset;
begin
 Ds := DBEdit1.DataSource.DataSet;
 if Ds = nil then
  exit;
 if Ds.Active then
  begin
   Ds.Edit;
   Ds.Fields.FieldByName(DBedit1.Field.FieldName).Value := Value;
  end;
end;

procedure TFmeDBCalculator.SpeedButton1Click(Sender: TObject);
var
H: THandle;
Value: double;
CreateCalculator: TCreateCalculator;
begin
{Carrega a calaculadora que está dentro da dll calc.dll. O variável "Value"
está aqui só para indicar que ela pode ser atribuída ao valor de retorno da
função. Apesar de não usarmos isto para nada neste programa, quis deixar aí para
indicar que é possível usá-la.}
 try
 H := LoadLibrary('calc.dll');
 if H = 0 then
  raise EDLLError.Create(TCosmosErrorMsg.DllCalculator);

  @CreateCalculator := GetProcAddress(H,'CreateCalculator');
  if not (@CreateCalculator = nil) then
   begin
    if CreateCalculator(0, Value) then
    SetValue(Value);
   end
  else
   RaiseLastOSError;

 finally
  if H <> 0 then
   FreeLibrary(H);
 end;

end;

end.
