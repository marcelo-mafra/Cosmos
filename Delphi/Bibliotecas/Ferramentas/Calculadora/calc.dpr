library calc;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  cosmos.tools.view.calculator in 'cosmos.tools.view.calculator.pas' {FrmCalculator},
  cosmos.tools.calculator in 'cosmos.tools.calculator.pas';

{$R *.res}

function CreateCalculator(var CalcValue: double): boolean; stdcall;
begin
 with TFrmCalculator.Create(nil) do
  begin
   try
    Result := Execute;
    if Result then
     CalcValue := CalculedValue;

   finally
    Free;
   end;
  end;
end;

procedure ShowCalculator; stdcall;
var
 ACalc: TFrmCalculator;
begin
{Apenas exibe a calculadora, sem se preocupar com o valor de retorno do cálculo.}
 ACalc := TFrmCalculator.Create(nil);

 try
  ACalc.Execute;

 finally
  if Assigned(ACalc) then FreeAndNil(ACalc);
 end;
end;



exports
 CreateCalculator,
 ShowCalculator;

begin

end.
