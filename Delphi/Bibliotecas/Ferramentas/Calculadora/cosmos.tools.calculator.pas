unit cosmos.tools.calculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections;

type
  TOperators = (opSoma, opSubt, opMult, opDiv, opNone);
  TCalcElement = (ceNumber, ceOperator, ceUnsigned);

  TMemoryLine = class
    private
     FValue1, FValue2: variant;
     FCalcOperator, FJoinOperator: TOperators;

     function GetOperatorSimbol: string;

    public
      constructor Create;
      destructor Destroy;

      function GetSentence: string;

      property Value1: variant read FValue1 write FValue1;
      property Value2: variant read FValue2 write FValue2;
      property CalcOperator: TOperators read FCalcOperator write FCalcOperator;
      property JoinOperator: TOperators read FJoinOperator write FJoinOperator;
      property Sentence: string read GetSentence;

  end;

 TCalcMemory = class
   private
   FCalculesPool:  TDictionary<Integer, TMemoryLine>;
   function GetCurrentLine: TMemoryLine;
   function GetItemCount: integer;

  public
   constructor Create;
   destructor Destroy;
   procedure ClearAll;
   procedure MoveFirst;
   function MoveNext: boolean;

   function NewMemoryLine: TMemoryLine;
   procedure RemoveItem(const Id: Integer);

   property CurrentLine: TMemoryLine read GetCurrentLine;
   property ItemCount: integer read GetItemCount;
 end;

implementation

{ TMemory }

procedure TCalcMemory.ClearAll;
var
 AKey: Integer;
 ACalc: TMemoryLine;
begin
 {Limpa o pool de conexão e destrói todos os objetos nele existentes.}
  for AKey in FCalculesPool.Keys do
   begin
    ACalc := FCalculesPool[Akey];
    ACalc.Free;
   end;

 FCalculesPool.Clear;
end;

constructor TCalcMemory.Create;
begin
 FCalculesPool := TDictionary<Integer, TMemoryLine>.Create;
end;

destructor TCalcMemory.Destroy;
begin
  FCalculesPool.Values.Free;
  FCalculesPool.Keys.Free;
  FCalculesPool.Free;

  inherited Destroy;
end;

function TCalcMemory.GetCurrentLine: TMemoryLine;
begin
 Result := FCalculesPool.Values.GetEnumerator.Current;
end;

function TCalcMemory.GetItemCount: integer;
begin
 Result := FCalculesPool.Count;
end;

function TCalcMemory.NewMemoryLine: TMemoryLine;
var
 AIndex: Integer;
begin
 Randomize;
 AIndex := Random(30);

 Result := TMemoryLine.Create;

 while FCalculesPool.ContainsKey(AIndex) do
   AIndex := Random(30);

 FCalculesPool.Add(AIndex, Result);
end;

procedure TCalcMemory.MoveFirst;
begin
// TList<FCalculesPool.GetEnumerator.Current>.First;
end;

function TCalcMemory.MoveNext: boolean;
begin
 Result := FCalculesPool.GetEnumerator.MoveNext;
end;

procedure TCalcMemory.RemoveItem(const Id: Integer);
var
 ACalc: TMemoryLine;
begin
 if FCalculesPool.ContainsKey(Id) then
  begin
   ACalc := FCalculesPool[Id];
   ACalc.Free;
   FCalculesPool.Remove(Id);
  end;

end;

{ TInternalCalc }

constructor TMemoryLine.Create;
begin
 inherited Create;
 CalcOperator := opNone;
 JoinOperator := opNone;
end;

destructor TMemoryLine.Destroy;
begin
 inherited Destroy;
end;

function TMemoryLine.GetOperatorSimbol: string;
begin
 case CalcOperator of
   opSoma: Result := '+';
   opSubt: Result := '-';
   opMult: Result := '*';
   opDiv: Result := '/';
   opNone: Result := '';
 end;
end;

function TMemoryLine.GetSentence: string;
begin
 if (Value1 = null) then
  begin
    Result := '';
  end
 else
  if (Value1 <> null) and (Value2 = null)  and (CalcOperator = opNone) then
   begin
    Result := VarToStr(Value1);
   end
 else
  if (Value1 <> null) and (Value2 = null) and (CalcOperator <> opNone) then
   begin
    Result := VarToStr(Value1) + ' ' + GetOperatorSimbol;
   end
 else
  if (Value1 <> null) and (Value2 <> null) and (CalcOperator <> opNone) then
   begin
    Result := VarToStr(Value1) + ' ' + GetOperatorSimbol + ' ' + VarToStr(Value2);
   end;
end;

end.
