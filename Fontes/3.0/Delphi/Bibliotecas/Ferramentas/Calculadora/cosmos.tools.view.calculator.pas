unit cosmos.tools.view.calculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  cosmos.tools.calculator;

type
  TFrmCalculator = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel1: TPanel;
    LblResult: TLabel;
    LblCounter: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
  private
    { Private declarations }
    FValue1, FValue2, FTempValue: System.Variant;
    FCalculedValue: System.Double;
    FCurrentElement: TCalcElement;
    FCurrentOperator: TOperators;
    FCalcLine: TMemoryLine;
    FCalcMemory: TCalcMemory;

    procedure ClearAll;
    procedure DoCalculate;

    procedure PrintCalcMemo;
    function GetOperatorSimbol: string;
    function GetCalculedValue: System.Double;
    procedure SetCurrentElement(value: TCalcElement);
    procedure SetCurrentOperator(value: TOperators);

  public
    { Public declarations }
    property CalcLine: TMemoryLine read FCalcLine;
    property CalculedValue: System.Double read GetCalculedValue;
    property CurrentElement: TCalcElement read FCurrentElement write SetCurrentElement;
    property CurrentOperator: TOperators read FCurrentOperator write SetCurrentOperator;

    function Execute: boolean;

  end;

var
  FrmCalculator: TFrmCalculator;

implementation

{$R *.dfm}

procedure TFrmCalculator.ClearAll;
begin
 FValue1 := null;
 FValue2 := null;
 FTempValue := 0;
 FCurrentElement := ceNumber;
 FCurrentOperator := opNone;

 PrintCalcMemo;
end;

procedure TFrmCalculator.DoCalculate;
begin
 case CurrentOperator of
   opSoma: FCalculedValue := FValue1 + FValue2;
   opSubt: FCalculedValue := FValue1 - FValue2;
   opMult: FCalculedValue := FValue1 * FValue2;
   opDiv: FCalculedValue := FValue1 / FValue2;
 end;

 PrintCalcMemo;
 FValue1 := FCalculedValue;
end;

function TFrmCalculator.Execute: boolean;
begin
 ShowModal;
end;

procedure TFrmCalculator.FormCreate(Sender: TObject);
begin
 FCalcMemory := TCalcMemory.Create;
 FCalcLine := FCalcMemory.NewMemoryLine;
 ClearAll;
end;

function TFrmCalculator.GetCalculedValue: System.Double;
begin
 Result := FCalculedValue;
end;

function TFrmCalculator.GetOperatorSimbol: string;
begin
 case CurrentOperator of
   opSoma: Result := '+';
   opSubt: Result := '-';
   opMult: Result := '*';
   opDiv: Result := '/';
   opNone: Result := '';
 end;
end;

procedure TFrmCalculator.PrintCalcMemo;
var
 I: integer;
 sMemo: string;
 AKey: Integer;
begin
 if FCalcMemory.CurrentLine <> nil then
   sMemo := sMemo + FCalcMemory.CurrentLine.Sentence;

 while FCalcMemory.MoveNext do
  begin
   if FCalcMemory.CurrentLine <> nil then
    sMemo := sMemo + FCalcMemory.CurrentLine.Sentence;
  end;

 LblCounter.Caption := sMemo;

{ if (FValue1 = null) then
  begin
    LblResult.Caption := FTempValue;
    LblCounter.Caption := '';
  end
 else
  if (FValue1 <> null) and (FValue2 = null)  and (CurrentOperator = opNone) then
   begin
    LblResult.Caption := FValue1;
    LblCounter.Caption := '';
   end
 else
  if (FValue1 <> null) and (FValue2 = null) and (CurrentOperator <> opNone) then
   begin
    LblResult.Caption := FValue1;
    LblCounter.Caption := VarToStr(FValue1) + ' ' + GetOperatorSimbol;
   end
 else
  if (FValue1 <> null) and (FValue2 <> null) then
   begin
    LblResult.Caption := FValue2;
    LblCounter.Caption := '';
   end; }
end;

procedure TFrmCalculator.SetCurrentElement(value: TCalcElement);
begin
 PrintCalcMemo;
end;

procedure TFrmCalculator.SetCurrentOperator(value: TOperators);
begin
 case CurrentElement of
   ceNumber:
     begin
      if FValue1 = null then
       begin
        FValue1 := FTempValue;
        FTempValue := null;
       end
      else
       begin
        FValue2 := FTempValue;
        DoCalculate;
       end;

      FCurrentOperator := Value;
     end;
   ceOperator:
     begin
       FCurrentOperator := Value;
     end;
 end;

 PrintCalcMemo;
end;

procedure TFrmCalculator.SpeedButton12Click(Sender: TObject);
begin
 CurrentOperator := opSubt;
end;

procedure TFrmCalculator.SpeedButton15Click(Sender: TObject);
begin
 CurrentOperator := opSoma;
end;

procedure TFrmCalculator.SpeedButton18Click(Sender: TObject);
begin
 ClearAll;
end;

procedure TFrmCalculator.SpeedButton1Click(Sender: TObject);
var
 sValue: string;
begin
 if LblResult.Caption <> '0' then
  sValue := LblResult.Caption +  TSpeedButton(Sender).Tag.ToString
 else
  sValue :=  TSpeedButton(Sender).Tag.ToString;

 FTempValue := sValue;

 CurrentElement := ceNumber;
end;

procedure TFrmCalculator.SpeedButton4Click(Sender: TObject);
begin
 CurrentOperator := opDiv;
end;

procedure TFrmCalculator.SpeedButton8Click(Sender: TObject);
begin
 CurrentOperator := opMult;
end;


end.
